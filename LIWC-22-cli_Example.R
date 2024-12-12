#  _      _______          _______    ___  ___     _____ _      _____  
# | |    |_   _\ \        / / ____|  |__ \|__ \   / ____| |    |_   _| 
# | |      | |  \ \  /\  / | |   ______ ) |  ) | | |    | |      | |   
# | |      | |   \ \/  \/ /| |  |______/ /  / /  | |    | |      | |   
# | |____ _| |_   \  /\  / | |____    / /_ / /_  | |____| |____ _| |_  
# |______|_____|   \/  \/   \_____|  |____|____|  \_____|______|_____| 
#  ______                           _                                  
# |  ____|                         | |                                 
# | |__  __  ____ _ _ __ ___  _ __ | | ___ ___                         
# |  __| \ \/ / _` | '_ ` _ \| '_ \| |/ _ / __|                        
# | |____ >  | (_| | | | | | | |_) | |  __\__ \                        
# |______/_/\_\__,_|_| |_| |_| .__/|_|\___|___/                        
#                            | |                                       
#                            |_|                                       
#
#
#    Ryan L. Boyd
#    2022-02-26
#
#
#
#
#    This is an example script that demonstrates how to make a call to the LIWC-22 command line interface (CLI)
#    from R. Briefly described, what we want to do is launch the CLI application as a separate process, then
#    pick back up from there.
#
#    This is a very crude example script, so please feel free to improve/innovate on this code :)
#
#
#    Make sure that you have either the LIWC-22 GUI or LIWC-22-license-server running in the background — 
#        it is required for the CLI to function correctly :)
#
#    Make sure that you have either the LIWC-22 GUI or LIWC-22-license-server running in the background — 
#        it is required for the CLI to function correctly :)
#
#    Make sure that you have either the LIWC-22 GUI or LIWC-22-license-server running in the background — 
#        it is required for the CLI to function correctly :)



# This specifies what type of cmd we're calling. For the shell() function, we can
# use cmd, cmd2, csh, and sh - the one that you choose will vary based on your OS.
shellType <- "cmd"



#  ______    _     _                      _ _   _       _________   _________   ______ _ _
# |  ____|  | |   | |                    (_| | | |     |__   __\ \ / |__   __| |  ____(_| |
# | |__ ___ | | __| | ___ _ __  __      ___| |_| |__      | |   \ V /   | |    | |__   _| | ___ ___
# |  __/ _ \| |/ _` |/ _ | '__| \ \ /\ / | | __| '_ \     | |    > <    | |    |  __| | | |/ _ / __|
# | | | (_) | | (_| |  __| |     \ V  V /| | |_| | | |    | |   / . \   | |    | |    | | |  __\__ \
# |_|  \___/|_|\__,_|\___|_|      \_/\_/ |_|\__|_| |_|    |_|  /_/ \_\  |_|    |_|    |_|_|\___|___/



inputFolderTXT <- "C:/Users/Ryan/Datasets/TED - English Only - TXT Files/"
outputLocation <- "C:/Users/Ryan/Datasets/TED Talk TXT Files - Analyzed.csv"

# This command will read texts from a folder, analyze them using the standard "Word Count" LIWC analysis,
# then save our output to a specified location. It is important that we use shQuote() to make sure that
# we are not accidentally passing 
cmd_to_execute <- paste("LIWC-22-cli",
                          "--mode", "wc",
                          "--input", shQuote(inputFolderTXT, type=shellType),
                          "--output", shQuote(outputLocation, type=shellType),
                       sep = ' ')



# Let's go ahead and run this analysis:

shell(cmd=cmd_to_execute, #specify the command that we want to run
      shell=shellType,    #specify the shell type we are calling
      intern=FALSE,       #specify that we do *not* want the output to be returned as an R object
      wait=TRUE,          #specify that we do, in fact, want to wait for the shell command to finish running before we continue
      mustWork=TRUE)      #we want to halt execution of this R script if something about our call to the shell fails



# We will see the following in the terminal as it begins working:
#
#    Picked up JAVA_TOOL_OPTIONS: -Dfile.encoding=UTF-8
#    Processing:
#     - [folder] C:\Users\Ryan\Datasets\TED - English Only - TXT Files
#    [===================                     ] 47.75%; Number of Texts Analyzed: 1304; Total Words Analyzed: 2.62M


# Now, we can take that output file and read it in to R to do with as we wish:
liwc.data <- read.csv(outputLocation, fileEncoding = 'UTF-8')



# A thing of beauty, to be sure. What if we want to process our texts using an older LIWC dictionary,
# or an external dictionary file? This can be done easily as well.




# We can specify whether we want to use the LIWC2001, LIWC2007, LIWC2015,
# or LIWC22 dictionary with the --dictionary argument.
liwcDict <- "LIWC2015"

# Alternatively, you can specify the absolute path to an external dictionary
# file that you would like to use, and LIWC will load this dictionary for processing.
#liwcDict <- "C:/Users/Ryan/Dictionaries/Personal Values Dictionary.dicx"


# Let's update our output location as well so that we don't overwrite our previous file.
outputLocation = "C:/Users/Ryan/Datasets/TED Talk TXT Files - Analyzed (LIWC2015).csv"

cmd_to_execute <- paste("LIWC-22-cli",
                        "--mode", "wc",
                        "--dictionary", shQuote(liwcDict, type=shellType),
                        "--input", shQuote(inputFolderTXT, type=shellType),
                        "--output", shQuote(outputLocation, type=shellType),
                        sep = ' ')


# Let's go ahead and run this analysis:
shell(cmd=cmd_to_execute,
      shell=shellType,
      intern=FALSE,
      wait=TRUE,
      mustWork=TRUE)







#   _____  _______      __  ______ _ _
#  / ____|/ ____\ \    / / |  ____(_| |
# | |    | (___  \ \  / /  | |__   _| | ___
# | |     \___ \  \ \/ /   |  __| | | |/ _ \
# | |____ ____) |  \  /    | |    | | |  __/
#  \_____|_____/    \/     |_|    |_|_|\___|



# Beautiful. Now, let's do the same thing, but analyzing a CSV file full of the same texts.
inputFileCSV <- 'C:/Users/Ryan/Datasets/TED Talk - English Transcripts.csv'
outputLocation <- 'C:/Users/Ryan/Datasets/TED Talk CSV File - Analyzed.csv'


# We're going to use a variation on the command above. Since this is a CSV file, we want to include the indices of
#     1) the columns that include the text identifiers (although this is not required, it makes our data easier to merge later)
#     2) the columns that include the actual text that we want to analyze
#
# In my CSV file, the first column has the text identifiers, and the second column contains the text.
# For more complex datasets, please use the --help argument with LIWC-22 to learn more about how to process your text.


cmd_to_execute <- paste("LIWC-22-cli",
                        "--mode", "wc",
                        "--row-id-indices", "1",
                        "--column-indices", "2",
                        "--input", shQuote(inputFileCSV, type=shellType),
                        "--output", shQuote(outputLocation, type=shellType),
                        sep = ' ')


# Let's go ahead and run this analysis:
shell(cmd=cmd_to_execute,
      shell=shellType,
      intern=FALSE,
      wait=TRUE,
      mustWork=TRUE)


# We will see the following in the terminal as LIWC does its magic:
#    Picked up JAVA_TOOL_OPTIONS: -Dfile.encoding=UTF-8
#    Processing:
#     - [file] C:\Users\Ryan\Datasets\TED Talk - English Transcripts.csv
#    [========================================] 100.00%; Number of Rows Analyzed: 2737; Total Words Analyzed: 5.40M
#    Done. Please examine results in C:\Users\Ryan\Datasets\TED Talk CSV File - Analyzed.csv







#                       _                  _____ _        _
#     /\               | |                / ____| |      (_)
#    /  \   _ __   __ _| |_   _ _______  | (___ | |_ _ __ _ _ __   __ _
#   / /\ \ | '_ \ / _` | | | | |_  / _ \  \___ \| __| '__| | '_ \ / _` |
#  / ____ \| | | | (_| | | |_| |/ |  __/  ____) | |_| |  | | | | | (_| |
# /_/    \_|_| |_|\__,_|_|\__, /___\___| |_____/ \__|_|  |_|_| |_|\__, |
#                          __/ |                                   __/ |
#                         |___/                                   |___/

# What if we want to simply pass a string to the CLI for analysis? This is possible. As described on the
# Help section of the liwc.app website, this is generally not recommended as it will not be very performant.
# However, if you insist...

# The string that we would like to analyze.
inputString <- "This is some text that I would like to analyze. After it has finished, I will say \"Thank you, LIWC!\""

# For this one, let's save our result as a newline-delimited json file (.ndjson)
outputLocation <- "C:/Users/Ryan/Datasets/LIWC-22 Results from String.ndjson"

cmd_to_execute <- paste("LIWC-22-cli",
                        "--mode", "wc",
                        "--input", "console",
                        "--console-text", shQuote(inputString, type=shellType),
                        "--output", shQuote(outputLocation, type=shellType),
                        sep = ' ')



# Let's go ahead and run this analysis:
shell(cmd=cmd_to_execute,
      shell=shellType,
      intern=FALSE,
      wait=TRUE,
      mustWork=TRUE)








# Lastly, what if we want to process a text and just get the results *directly* from the console, then
# bring them into R? Put another way: what if we don't want to process data, save it to disk, then
# read that data into R back from the disk?
#
# Thankfully, LIWC-22's CLI can dump the output to the console window as a JSON. Then, we can use
# some very nice R libraries to parse that json into a "named list" in R.
#
# For this, you will want to have a package installed that can parse JSONs. I prefer the "jsonlite"
# package but, of course, whatever works best for you is wonderful :)
#
# Just in case you do not have a package installed already, you can install using the code below:
#install.packages("jsonlite")

library(jsonlite)

# Let's do the same example that we did before, but this time, we'll read the JSON output in the console.
inputString <- "This is some text that I would like to analyze. After it has finished, I will say \"Thank you, LIWC!\""

# This time, note that the "output" argument is also set to "console" - this is important.
cmd_to_execute <- paste("LIWC-22-cli",
                        "--mode", "wc",
                        "--input", "console",
                        "--console-text", shQuote(inputString, type=shellType),
                        "--output", "console",
                        sep = ' ')

# Let's go ahead and run this analysis.
# 
# ...HOWEVER!!!
# 
# Note that the "intern" parameter is now set to TRUE. This is because, unlike before, we *do*
# want to capture the output from the console and store it as an R object.
liwc22.json.output = shell(cmd=cmd_to_execute,
                           shell=shellType,
                           intern=TRUE,
                           wait=TRUE,
                           mustWork=TRUE)


# Note that the output comes as a list of 3 strings:
# [1] "Picked up JAVA_TOOL_OPTIONS: -Dfile.encoding=UTF-8"
# [2] "Processing input text..."
# [3] "{\"Segment\": 1,\"WC\": 20,\"Analytic\": 3.8,\"Clout\": 40.06,\"Authentic\": 28.56,\"Tone\": 99,\"WPS\": 10,\"BigWords\": 10,\"Dic\": 100,\"Linguistic\": 80,\"function\": 70,\"pronoun\": 30,\"ppron\": 15,\"i\": 10,\"we\": 0,\"you\": 5,\"shehe\": 0,\"they\": 0,\"ipron\": 15,\"det\": 15,\"article\": 0,\"number\": 0,\"prep\": 15,\"auxverb\": 20,\"adverb\": 0,\"conj\": 5,\"negate\": 0,\"verb\": 35,\"adj\": 0,\"quantity\": 5,\"Drives\": 5,\"affiliation\": 0,\"achieve\": 5,\"power\": 0,\"Cognition\": 15,\"allnone\": 0,\"cogproc\": 15,\"insight\": 5,\"cause\": 0,\"discrep\": 10,\"tentat\": 0,\"certitude\": 0,\"differ\": 0,\"memory\": 0,\"Affect\": 15,\"tone_pos\": 15,\"tone_neg\": 0,\"emotion\": 10,\"emo_pos\": 10,\"emo_neg\": 0,\"emo_anx\": 0,\"emo_anger\": 0,\"emo_sad\": 0,\"swear\": 0,\"Social\": 20,\"socbehav\": 15,\"prosocial\": 5,\"polite\": 5,\"conflict\": 0,\"moral\": 0,\"comm\": 15,\"socrefs\": 5,\"family\": 0,\"friend\": 0,\"female\": 0,\"male\": 0,\"Culture\": 5,\"politic\": 0,\"ethnicity\": 0,\"tech\": 5,\"Lifestyle\": 0,\"leisure\": 0,\"home\": 0,\"work\": 0,\"money\": 0,\"relig\": 0,\"Physical\": 0,\"health\": 0,\"illness\": 0,\"wellness\": 0,\"mental\": 0,\"substances\": 0,\"sexual\": 0,\"food\": 0,\"death\": 0,\"need\": 0,\"want\": 0,\"acquire\": 0,\"lack\": 0,\"fulfill\": 0,\"fatigue\": 0,\"reward\": 0,\"risk\": 0,\"curiosity\": 0,\"allure\": 0,\"Perception\": 0,\"attention\": 0,\"motion\": 0,\"space\": 0,\"visual\": 0,\"auditory\": 0,\"feeling\": 0,\"time\": 10,\"focuspast\": 0,\"focuspresent\": 10,\"focusfuture\": 5,\"Conversation\": 0,\"netspeak\": 0,\"assent\": 0,\"nonflu\": 0,\"filler\": 0,\"AllPunc\": 30,\"Period\": 5,\"Comma\": 10,\"QMark\": 0,\"Exclam\": 5,\"Apostro\": 0,\"OtherP\": 10}"

# As you'd expect, it is this third element that we want to parse as a json object.
# Let's go ahead and do this and finally bring it in as actual data that R can use.

liwc22.data = jsonlite::parse_json(liwc22.json.output[3])

# Voila! Let's make sure that it worked:
print(liwc22.data$Analytic)
# The output is:
# [1] 3.8

# Success!

# To reiterate: processing individual texts on a one-by-one basis like this is not
# very computationally efficient. Thus, if you do something like an apply() function
# call to where you analyze texts from rows of a dataframe this way, it will be
# less efficient than if you analyze all of your data as a single batch.
# 
# That said, this is a perfectly acceptable solution even if it is not computationally
# optimal. The most important thing is that your data gets analyzed correctly and
# that your code is understandable to you!

