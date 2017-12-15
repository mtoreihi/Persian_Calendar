//
// Copyright 2015-2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.WatchUi as Ui;


    
class KeyboardDelegate extends Ui.InputDelegate {

    function initialize() {
        Ui.InputDelegate.initialize();
    }

    // Push a text picker if the up button is pressed
    // or the screen receives a tap.
    function onKey(key) {
        if (key.getKey() == Ui.KEY_ENTER) {
        	//System.println("KEY_ENTER pressed");
            Ui.pushView(new Persian_CalendarView(), new KeyboardListener(), Ui.KEY_LAP);
            updateTable(false);
        }
    }

}

class KeyboardListener extends Ui.BehaviorDelegate {

    function initialize() {
       Ui.InputDelegate.initialize();
    }
    
    function onKey(key) {
    	//System.println(key.getKey());
    	
	    if (key.getKey() == Ui.KEY_DOWN) {
			current_month_view += 1;
			if (current_month_view > 12) {
				current_year_view += 1;
				current_month_view = 1;
			} 
			updateTable(false);
			//System.println("Month: "+ current_month_view);
			//System.println("Year : "+ current_year_view);
	    }
	    else if (key.getKey() == Ui.KEY_UP) {
			current_month_view -= 1; 
			if (current_month_view < 1) {
				current_year_view -= 1;
				current_month_view = 12;
			} 
			updateTable(false);
			//System.println("Month: "+ current_month_view);
			//System.println("Year : "+ current_year_view);
	    }   
	    else {
	    	//System.println("ELSE");
	    	updateTable(true);
	    	return false;
	    }
	    
	    return true;
	}

}