//
//  ASCalendar.swift
//  Example
//
//  Created by alberto.scampini on 18/05/2016.
//  Copyright © 2016 Alberto Scampini. All rights reserved.
//

import Foundation
import UIKit

protocol ASCalendarDelegate: class {
    func calendarSelect(_ day: Int, week: Int, month: Int, year: Int)
}

class ASCalendar: NSObject {
    
    internal var calendarV : ASCalendarV!
    internal var calendarSettings : ASSettingsM!
    internal var calendarVM : ASCalendarVM!
    var theme = ASThemeVM()
    weak var delegate : ASCalendarDelegate?
    
    override init() {
        super.init()
        //get current date
        let date = Date()
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([.day , .month , .year], from: date)
        let year =  components.year
        let month = components.month
        //create default settings
        calendarSettings = ASSettingsM(month: month!, year: year!)
        calendarSettings.selectedDay.bind {
            self.delegate?.calendarSelect($0.dayNumber, week: $0.dayWeek, month: $0.dayMonth, year: $0.dayYear)
        }
    }
    
    //MARK: presentation public methods
    
    var calendarLayer : ASCustomLayer!
    
    func showCalendarAsLayer() {
        calendarLayer = ASCustomLayer()
        calendarLayer.showCalendar()
        calendarV = calendarLayer.calendar as! ASCalendarV
        calendarVM = ASCalendarVM(settings: self.calendarSettings)
        calendarV.theme = theme
        calendarV.viewModel = calendarVM
    }
    
    func hideCalendar() {
        calendarLayer.closingAnimations()
    }
    
    //MARK: settings public methods
    
    func setcurrentPage(_ month: Int, year: Int) {
        calendarSettings.selectedMonth.value = (month: month, year: year)
    }
    
    func setFirstSelectableDate(_ day: Int, month: Int, year: Int) {
        calendarSettings.firstSelectableDate.value = (day : day, month : month, year: year)
    }
    
    func setLastSelectableDate(_ day: Int, month: Int, year: Int) {
        calendarSettings.lastSelectableDate.value = (day : day, month : month, year: year)
    }
    
    func setSelectedDay(_ day: Int, month: Int, year: Int) {
        let selectedDay = ASDayM(day: day, month: month, year: year)
        calendarSettings.selectedDay.value = selectedDay
    }
    
    func setSelectionStyle(_ style : BodySelectionStyle) {
        calendarSettings.selectionStyle.value = style
    }
    
    func setMondayFirstWeekDay(_ flag : Bool) {
        self.calendarSettings.startByMonday.value = flag
    }
    
    func setSundayFirstWeekDay(_ flag : Bool) {
        self.calendarSettings.startByMonday.value = !flag
    }
    
    //MARK: theme public methods
    
    func configureHeader(_ backgroundColor: UIColor?, textColor: UIColor?, textFont : UIFont?, separationLineColor: UIColor?) {
        if (backgroundColor != nil) {
            theme.headerColor.value = backgroundColor!
        }
        if (textColor != nil) {
            theme.headerTextColor.value = textColor!
        }
        if (textFont != nil) {
            theme.headerTextFont.value = textFont!
        }
        if (separationLineColor != nil) {
            theme.headerSeparatorColor.value = separationLineColor!
        }
    }
    
    func configureBodyHeader(_ backgroundColor: UIColor?, textColor: UIColor?, textFont: UIFont?, separationLineColor: UIColor?) {
        if (backgroundColor != nil) {
            theme.bodyBackgroundColor.value = backgroundColor!
        }
        if (textColor != nil) {
            theme.bodyHeaderTextColor.value = textColor!
        }
        if (textFont != nil) {
            theme.bodyHeaderTextFont.value = textFont!
        }
        if (separationLineColor != nil) {
            theme.bodySeparatorColor.value = separationLineColor!
        }
    }
    
    func configureBody(_ backgroundColor: UIColor?, monthTextColor: UIColor?, monthTextFont: UIFont?, separationLineColor: UIColor?) {
        if (backgroundColor != nil) {
            theme.bodyHeaderColor.value = backgroundColor!
        }
        if (monthTextColor != nil) {
            theme.bodyMonthTitleColor.value = monthTextColor!
        }
        if (monthTextFont != nil) {
            theme.bodyMonthTextFont.value = monthTextFont!
        }
        if (separationLineColor != nil) {
            theme.bodySeparatorColor.value = separationLineColor!
        }
    }
    
    func configureDay(_ selectableTextColor: UIColor?, unselectableTextColor: UIColor?, selectedTextColor: UIColor?, TextFont: UIFont?) {
        if (selectableTextColor != nil) {
            theme.bodyDayActiveTextColor.value = selectableTextColor!
        }
        if (unselectableTextColor != nil) {
            theme.bodyDayInactiveTextColor.value = unselectableTextColor!
        }
        if (selectedTextColor != nil) {
            theme.bodyDaySelectedTextColor.value = selectedTextColor!
        }
        if (TextFont != nil) {
            theme.bodyDayTextFont.value = TextFont!
        }
    }
    
    func configureSelections(_ selectionColor: UIColor?, daySelectionSize: CGFloat?, weekSelectionHeight: CGFloat?) {
        if (selectionColor != nil) {
            theme.bodySelectionColor.value = selectionColor!
        }
        if (daySelectionSize != nil) {
            theme.daySelectionSize.value = daySelectionSize!
        }
        if (weekSelectionHeight != nil) {
            theme.weekSelectionSize.value = weekSelectionHeight!
        }
    }
    
}
