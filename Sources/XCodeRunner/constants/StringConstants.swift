let unknownErrorMessage = "Unknown error occured" 

let commonErrorTitle = "Error occured" 
let decodingErrorTitle = "Decoding error occured"

let invalidArgumentMessage = "Invalid argument was used: {%@}"
let invalidUsageMessage = "Invalid usage of the command or option: {%@}"
let invalidUsageOfOptionForCommand = "Invalid usage of the option: {%@} for command: {%@}"
let decodingErrorMessage = "Failed to decode data in file at path: {%@}.\nTry to manually modify it or write an email with your issue to t.me/castlelecs"

let versionsCommandMessage = "Available XCodes: {%@}"
let noVersionsAvailableMessage = "There no available XCodes or path to XCode applications were specified wrong"

// TODO: Update help message with other commands and usage cases
let commonHelpMessage = """
Usage:
    xrunner <command>

Commands:
    versions: prints every available xcode version on current device

Options:
    -help - show help message
"""
