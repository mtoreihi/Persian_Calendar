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
		//System.println("KEY_ENTER pressed");
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
    
	function onBack() {
		//System.println("back...");
		updateTable(true);
		return false;
	}

	function onNextPage() {
		//System.println("next page...");
		current_month_view += 1;
		if (current_month_view > 12) {
			current_year_view += 1;
			current_month_view = 1;
		} 
		updateTable(false);
		//System.println("Month: "+ current_month_view);
		//System.println("Year : "+ current_year_view);
	}
	function onPreviousPage() {
		//System.println("previous page...");
		current_month_view -= 1; 
		if (current_month_view < 1) {
			current_year_view -= 1;
			current_month_view = 12;
		} 
		updateTable(false);
		//System.println("Month: "+ current_month_view);
		//System.println("Year : "+ current_year_view);	
	}

}