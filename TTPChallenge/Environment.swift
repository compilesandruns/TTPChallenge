//
//  Environment.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/9/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

struct Environment {
    
    struct Firebase {
        static let loginToList = "LoginToList"
    }
    
    struct Validation {
        static let namePattern = "^[\\w][\\w\\s.-]*$"
        static let emailPattern = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]+$"
        static let passwordPattern = "^(?=.*[A-Za-z])(?=.*[0-9])[A-Za-z[0-9]]{8,}$"
    }
    struct Alert {
        static let errorTitle = "Whoops!"
        static let invalidEmail = "Invalid email. Please enter a valid email address"
        static let emailInUse = "Email already in use. Please sign in."
        static let defaultError = "An error has occured. Please try again later."
        static let userNotFound = "Unable to locate account. Please create a new account."
    }
}

struct Quizzes {
    static let techJobs = [
        "Quality Assurance Analyst",
        "IT Engineer",
        "Web Developer",
        "Mobile Developer",
        "Data Analyst"
    ]
    
    static let personalityData = [
        ["Enjoy trying out new products",
         "Stay up to date on the latest and greatest in tech and devices",
         "Want to get involved in tech, but not sure where to start",
         "Enjoy puzzles and challenges"],
        ["Enjoy tinkering with computers and devices",
         "Are curious about how tech products work",
         "Enjoy fast-paced work",
         "Enjoy solving problems"],
        ["Have a creative spirit",
         "Love following the latest web trends & technologies",
         "Think logically and critically",
         "Have tried or are interested in learning how to code"],
        ["Are iPhone or Android obsessed",
         "Are Always on the hunt for the latest cool app",
         "Have strong preferences for specific technology or apps",
         "Have tried or areinterested in learning how to code"],
        ["Able to work across teams and with a variety of stakeholders",
         "Communicate effectively and build strong relationships with team members",
         "Have a knack for math, facts and figures",
         "Love simplifying complex ideas"]
    ]
}

struct Identifier {
    struct Cell {
        static let personalityCell = "personalityCell"
        static let resultCell = "resultCell"
    }
    
    struct Segue {
        static let toResult = "toResult"
        static let backHome = "backHome"
        static let backToQuizMain = "backToQuizMain"
    }
}

struct URLS {
    static let acceleratedProgram = "https://ttp.nyc/accelerated-programs"
    static let signUpForTTP = "https://ttp.nyc/join"
    static let cunyProgram = "https://ttp.nyc/cuny-programs"
    static let qaPartTime = "https://perscholas.org/apply/quality-assurance-part-time"
}


struct Answer {
    static let none = ""
    static let yes = "1"
    static let no = "0"
}

struct Colors {
    static let mdBlue = UIColor(red: 23/255.0, green: 167/255.0, blue: 239/255.0, alpha: 1)
    static let qaPeach = UIColor(red: 255/255.0, green: 213/255.0, blue: 185/255.0, alpha: 1)
    static let wdRose = UIColor(red: 255/255.0, green: 129/255.0, blue: 146/255.0, alpha: 1)
    static let daGreen = UIColor(red: 46/255.0, green: 191/255.0, blue: 146/255.0, alpha: 1)
    static let itPink = UIColor(red: 247/255.0, green: 213/255.0, blue: 219/255.0, alpha: 1)
    static let resultPurple = UIColor(red: 102/255.0, green: 102/255.0, blue: 255/255.0, alpha: 1)
    static let closeNavy = UIColor(red: 46/255.0, green: 49/255.0, blue: 146/255.0, alpha: 1)
}
