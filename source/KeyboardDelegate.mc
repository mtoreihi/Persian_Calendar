//
// Copyright 2015-2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.WatchUi as Ui;

  
class KeyboardDelegate extends Ui.InputDelegate {

    function initialize() {
        Ui.InputDelegate.initialize();
        device = Ui.loadResource(Rez.Strings.DeviceModel);	// get the device model from resource file
    }

    // Push a text picker if the up button is pressed
    // or the screen receives a tap.
    function onKey(key) {
		//System.println("KEY_ENTER pressed");
        if (key.getKey() == Ui.KEY_ENTER) {
        	//System.println("KEY_ENTER pressed");
            Ui.pushView(new Persian_CalendarView(), new myBehaviorDelegate(), Ui.KEY_LAP);
            updateTable(false);
        }
    }
}

class myBehaviorDelegate extends Ui.BehaviorDelegate {
    function initialize() {
       Ui.BehaviorDelegate.initialize();
    }
    

	function onKey(key) {
    	System.println(key.getKey());
    	System.println("inside onKey...");
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
		    	System.println("ELSE");
		    	updateTable(true);
		    	return false;
		    }
	    return true;
	}

	function onBack() {
		//System.println("back...");
			updateTable(true);
			return false;
	}

	function onNextPage() {
		//System.println("next page...");
		if ("fenix5".equals(device)) {
			return false;
		}
			current_month_view += 1;
			if (current_month_view > 12) {
				current_year_view += 1;
				current_month_view = 1;
			} 
			updateTable(false);
			return false;
			//System.println("Month: "+ current_month_view);
			//System.println("Year : "+ current_year_view);
		
	}
	function onPreviousPage() {
			//System.println("previous page...");
			System.println(device);
			if ("fenix5".equals(device)) {
				return false;
			}			
			current_month_view -= 1; 
			if (current_month_view < 1) {
				current_year_view -= 1;
				current_month_view = 12;
			} 
			updateTable(false);
			return false;
			//System.println("Month: "+ current_month_view);
			//System.println("Year : "+ current_year_view);	
	}	

}