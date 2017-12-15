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
using Toybox.Math;

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
var current_month_view = 1;
var current_year_view = 1396;
var show_today = true;

function updateTable(reset) {
	if (reset) {
	    var today = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
		var result = gregorian_to_jalali(today.year,today.month,today.day,false);
		current_month_view = result[1];
		current_year_view = result[0];
		show_today = true;	
	}
	else {
		show_today = false;
	}
    Ui.requestUpdate();
    return true;
}

    
class Persian_CalendarView extends Ui.View {

    var font = Gfx.FONT_XTINY;
    var lineSpacing = Gfx.getFontHeight(font);
    
    var centerY = 60; // Default taken from previous hard coded values
    var centerX = 60;


    function initialize() {
        View.initialize();
        
        var today = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
    	var result = gregorian_to_jalali(today.year,today.month,today.day,false);
    	current_month_view = result[1];
    	current_year_view = result[0];
        
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
    	//drawMonthTable(dc, current_month_view, current_year_view);
    }

    // Update the view
    function onUpdate(dc) {
    	var current_view_text;
    	if (show_today) {
	    	var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
			font = Gfx.FONT_XTINY;
	   	
	    	dc.setColor( Gfx.COLOR_BLACK, Gfx.COLOR_BLACK );
	        dc.clear();
	        dc.setColor( Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT );
	        
	        var result = [];
	        result = gregorian_to_jalali(today.year,get_month_number(today.month),today.day,false);
	        //System.println(result[0]);
	    	var jalali = result[0] + "/" + result[1] + "/" + result[2];
	    	dc.drawText( centerX, centerY - (1 * lineSpacing), font, jalali, Gfx.TEXT_JUSTIFY_LEFT );
    	}
    	else {
    		dc.setColor( Gfx.COLOR_BLACK, Gfx.COLOR_BLACK );
	        dc.clear();
	        dc.setColor( Gfx.COLOR_GREEN, Gfx.COLOR_TRANSPARENT );
    		current_view_text = get_month_string(current_month_view) + "-" + current_year_view;
    		dc.drawText( centerX + 10, centerY - (1 * lineSpacing), font, current_view_text, Gfx.TEXT_JUSTIFY_LEFT );
    		dc.setColor( Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT );
    	}
    	
    	// Draw the Month Table
    	drawMonthTable(dc, current_month_view, current_year_view);
    	
    	
        // Call the parent onUpdate function to redraw the layout
        //View.onUpdate(dc);
    }



	public function drawMonthTable(dc, month, year) {

    	var my_x = 45;
    	var my_y = 20;
		var i = 0; 
		
		font = Gfx.FONT_XTINY;
    	var X_Spacing = 30;
    	var Y_Spacing = 20;
    	
    	// Draw the calendar header table 
    	my_x = centerX - 45;
    	my_y = my_y + Y_Spacing;
    	var week = ['S','S','M','T','W','T','F'];
    	for (i=0; i<7; i++) {
    		if (i == 6) {
    			dc.setColor( Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT );
    		}
    		dc.drawText(my_x , centerY - (1 * lineSpacing) + my_y, font, week[i], Gfx.TEXT_JUSTIFY_LEFT );
    		dc.setColor( Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT );
    		my_x += X_Spacing;
    	}
    	
    	// Draw the calendar month table
    	my_y = my_y + Y_Spacing;
    	my_x = centerX - 45;    	
    	var iterator = 1;
    	//today = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
    	var week_day = get_week_day(month, year);
    	if (week_day == 7) { week_day = 0; } //set Saturday to 0   	
    	var month_days = get_month_days(month);
    	
    	//System.println("week day:" + week_day);
    	//System.println(month_days);  	
    	
    	while (iterator <= month_days) {
    		for (i=0; i<7; i++) {
    			if (i == 6) {
    				dc.setColor( Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT );
    			}
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
    			dc.setColor( Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT );
    			//System.println(iterator);
    		}
    		my_y = my_y + Y_Spacing;
    		my_x = centerX - 45;	
    	}	
	}
    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }
    
}

//public functions 
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
	
	function get_month_string(month) {
		switch (month) {
			case 1: return "Farv"; break;
			case 2: return "Ordi"; break;
			case 3: return "Khor"; break;
			case 4: return "Tir "; break;
			case 5: return "Mor "; break;
			case 6: return "Shah"; break;
			case 7: return "Mehr"; break;
			case 8: return "Aban"; break;
			case 9: return "Azar"; break;
			case 10: return "Dei "; break;
			case 11: return "Bahm"; break;
			case 12: return "Esfa"; break;
		}	
	}
	
 	function get_week_day(month, year) {
    	//System.println(month_days);
    	//System.println(today.day_of_week);

    	var res = jalali_to_gregorian(year, month, 1); //get the week day for the first day of the month
    	//System.println(res[0]+","+res[1]+","+res[2]);
    	var options = {
		    :year   => res[0],
		    :month  => res[1],
		    :day    => res[2]
		};
		var date = Gregorian.moment(options);
		var first_day = Gregorian.info(date, Time.FORMAT_SHORT);
		return first_day.day_of_week;
		//System.println(first_day.day_of_week);
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
	
	function jalali_to_gregorian(j_y, j_m, j_d)
    {
    	var i = 0;
	    var g_days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]; 
	    var j_days_in_month = [31, 31, 31, 31, 31, 31, 30, 30, 30, 30, 30, 29];
        var jy = j_y-979;
        var jm = j_m-1;
        var jd = j_d-1;
        var j_day_no = 365*jy + Math.floor(jy/33)*8 + Math.floor((jy%33+3)/4);
        for (i=0; i < jm; ++i){
            j_day_no += j_days_in_month[i];
        }
        j_day_no += jd;
        var g_day_no = j_day_no+79;
        var gy = 1600 + 400 * Math.floor(g_day_no/146097);
        g_day_no = g_day_no % 146097;
        var leap = true;
        if (g_day_no >= 36525){
            g_day_no--;
            gy += 100 * Math.floor(g_day_no/36524);
            g_day_no = g_day_no % 36524;
            if (g_day_no >= 365){
                g_day_no++;
            }else{
                leap = false;
            }
        }
        gy += 4 * Math.floor(g_day_no/1461);
        g_day_no %= 1461;
        if (g_day_no >= 366){
            leap = false;
            g_day_no--;
            gy += Math.floor(g_day_no/365);
            g_day_no = g_day_no % 365;
        }
        var flag = 0;
 		if ((i == 1 && leap) == true) {
 			flag = 1;
 		} else {
 			flag = 0;
 		}
        for (i = 0; g_day_no >= g_days_in_month[i] + (flag); i++){
            g_day_no -= g_days_in_month[i] + (flag);
            
         	if ((i == 1 && leap) == true) {
	 			flag = 1;
	 		} else {
	 			flag = 0;
	 		}            
        }
        var gm = i+1;
        var gd = g_day_no+1;
        
        var array = [gy, gm, gd];
	    return array; 
    }
