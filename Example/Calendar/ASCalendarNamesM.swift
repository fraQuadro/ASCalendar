//
//  ASCalendarNamesM.swift
//  Example
//
//  Created by alberto.scampini on 19/05/2016.
//  Copyright © 2016 Alberto Scampini. All rights reserved.
//

import Foundation

protocol ASCalendarNamesM {
    func getWeekNamesFromMonday() -> Array<String>
    func getWeekNamesFromSunday() -> Array<String>
    func getMonthNames() -> Array<String>
}

extension ASCalendarNamesM {
    
    func getWeekNamesFromMonday() -> Array<String> {
        //get day names
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        let fullWeekDays = formatter.weekdaySymbols
        var weekDays = Array<String>()
        for i in 1...6 {
            weekDays.append(String(describing: fullWeekDays?[i].characters.first!).uppercased())
        }
        //move sunday at the end of the week
        weekDays.append(String(describing: fullWeekDays?[0].characters.first!).uppercased())
        return weekDays
    }
    
    func getWeekNamesFromSunday() -> Array<String> {
        //get day names
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        let fullWeekDays = formatter.weekdaySymbols
        var weekDays = Array<String>()
        for i in 0...6 {
            weekDays.append(String(describing: fullWeekDays?[i].characters.first!).uppercased())
        }
        return weekDays
    }
    
    func getMonthNames() -> Array<String> {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        return formatter.monthSymbols
    }
    
}
