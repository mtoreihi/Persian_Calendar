/**
	Mehran Toreihi [mtoreihi@gmail.com]
	1396-08-28
	2017-11-19
**/
using Toybox.WatchUi as Ui;
using Toybox.Time.Gregorian;
using Toybox.Time;
using Toybox.Graphics as Gfx;
using Toybox.System;

/*
var dateString = Lang.format(
    "1:2:3 4 5 6 7",
    [
        today.hour,
        today.min,
        today.sec,
        today.day_of_week,
        today.day,
        today.month,
        today.year
    ]
);
System.println(dateString); // e.g. "16:28:32 Wed 1 Mar 2017"
*/

class Persian_CalendarView extends Ui.View {

    var font = Gfx.FONT_TINY;
    var lineSpacing = Gfx.getFontHeight(font);
    
    var centerY = 60; // Default taken from previous hard coded values
    var centerX = 60;

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
    	centerY = (dc.getHeight() / 2) - (lineSpacing / 2);
    	centerY -= 70;
    	centerX = 65;
    	//languageLabel = Ui.loadResource( Rez.Strings.language_label );
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
    	var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
    	var my_x = 45;
    	var my_y = 20;
    	var i = 0;
   	
    	dc.setColor( Gfx.COLOR_BLACK, Gfx.COLOR_BLACK );
        dc.clear();
        dc.setColor( Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT );
        
        var result = [];
        result = gregorian_to_jalali(today.year,get_month_number(today.month),today.day,false);
        //System.println(result[0]);
    	var jalali = result[0] + "/" + result[1] + "/" + result[2];
    	dc.drawText( centerX, centerY - (1 * lineSpacing), font, jalali, Gfx.TEXT_JUSTIFY_LEFT );


		font = Gfx.FONT_XTINY;
    	var X_Spacing = 30;
    	var Y_Spacing = 20;
    	
    	// Draw the calendar header table 
    	my_x = centerX - 45;
    	my_y = my_y + Y_Spacing;
    	var week = ['S','S','M','T','W','T','F'];
    	for (i=0; i<7; i++) {
    		dc.drawText(my_x , centerY - (1 * lineSpacing) + my_y, font, week[i], Gfx.TEXT_JUSTIFY_LEFT );
    		my_x += X_Spacing;
    	}
    	
    	// Draw the calendar month table
    	my_y = my_y + Y_Spacing;
    	my_x = centerX - 45;    	
    	var iterator = 1;
    	today = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
    	var week_day = today.day_of_week - 1;
    	var month_days = get_month_days(result[1]);
    	//System.println(month_days);
    	//System.println(today.day_of_week);
    	while (iterator < month_days) {
    		for (i=0; i<7; i++) {
    			//System.println(iterator);
    			if (iterator == 1) {
    				if (week_day == i) {
    					dc.drawText(my_x , centerY - (1 * lineSpacing) + my_y, font, iterator, Gfx.TEXT_JUSTIFY_LEFT );
    					my_x += X_Spacing;
    					iterator += 1;
    					if (iterator > month_days) { break; }
    				}
    				else {
    					my_x += X_Spacing;
    				}
    			}
    			else {
    				dc.drawText(my_x , centerY - (1 * lineSpacing) + my_y, font, iterator, Gfx.TEXT_JUSTIFY_LEFT );	
    				my_x += X_Spacing;
    				iterator += 1;
    				if (iterator > month_days) { break; }
    			}
    		}
    		my_y = my_y + Y_Spacing;
    		my_x = centerX - 45;	
    	}
    	
        // Call the parent onUpdate function to redraw the layout
        //View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }
    
    function div(a,b) { 
    	return (a / b); 
	} 
	
	function get_month_number(month) {
		switch (month) {
			case "Jan": return 1; break;
			case "Feb": return 2; break;
			case "Mar": return 3; break;
			case "Apr": return 4; break;
			case "May": return 5; break;
			case "Jun": return 6; break;
			case "Jul": return 7; break;
			case "Aug": return 8; break;
			case "Sep": return 9; break;
			case "Oct": return 10; break;
			case "Nov": return 11; break;
			case "Dec": return 12; break;
		}
	}
	
	function get_month_days(month) {
		switch (month) {
			case 1: return 31; break;
			case 2: return 31; break;
			case 3: return 31; break;
			case 4: return 31; break;
			case 5: return 31; break;
			case 6: return 31; break;
			case 7: return 30; break;
			case 8: return 30; break;
			case 9: return 30; break;
			case 10: return 30; break;
			case 11: return 30; break;
			case 12: return 29; break;
		}
	}
	
 
	function gregorian_to_jalali (g_y, g_m, g_d,str) 
	{ 

		var i;
	    var g_days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]; 
	    var j_days_in_month = [31, 31, 31, 31, 31, 31, 30, 30, 30, 30, 30, 29]; 
	 
	  
	   var gy = g_y-1600; 
	   var gm = g_m-1; 
	   var gd = g_d-1; 
	 
	   var g_day_no = 365*gy+div(gy+3,4)-div(gy+99,100)+div(gy+399,400); 
	 
	   for (i=0; i < gm; ++i) {
	      g_day_no += g_days_in_month[i]; 
	   }
	   if (gm>1 && ((gy%4==0 && gy%100!=0) || (gy%400==0))) {
	      /* leap and after Feb */ 
	      g_day_no = g_day_no + 1; 
	   }
	   g_day_no += gd; 
	 
	   var j_day_no = g_day_no-79; 
	 
	   var j_np = div(j_day_no, 12053); /* 12053 = 365*33 + 32/4 */ 
	   j_day_no = j_day_no % 12053; 
	 
	   var jy = 979+33*j_np+4*div(j_day_no,1461); /* 1461 = 365*4 + 4/4 */ 
	 
	   j_day_no %= 1461; 
	 
	   if (j_day_no >= 366) { 
	      jy += div(j_day_no-1, 365); 
	      j_day_no = (j_day_no-1)%365; 
	   } 
	 
	   for (i = 0; i < 11 && j_day_no >= j_days_in_month[i]; ++i) {
	      j_day_no -= j_days_in_month[i]; 
	   }
	   var jm = i+1; 
	   var jd = j_day_no+1; 
	   
	   if(str) {
	      return jy+"/"+jm+"/"+jd ;
	   }
	   var array = [jy,jm,jd];
	   return array; 
	} 

}
