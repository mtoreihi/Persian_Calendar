using Toybox.Graphics as Gfx;
using Toybox.Time.Gregorian;
using Toybox.Time;
using Toybox.WatchUi;
using Toybox.System;

class Persian_CalendarGlanceView extends WatchUi.GlanceView {

    function initialize() {
        GlanceView.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
    	var today = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
		var result = gregorian_to_jalali(today.year, today.month, today.day, true);
		
    	dc.setColor( Gfx.COLOR_BLACK, Gfx.COLOR_BLACK );
        dc.clear();
        dc.setColor( Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
    	dc.drawText(0, 5, Gfx.FONT_GLANCE, "Today", Gfx.TEXT_JUSTIFY_LEFT);
    	dc.drawText(0, dc.getFontHeight(Gfx.FONT_GLANCE), Gfx.FONT_GLANCE_NUMBER, result, Gfx.TEXT_JUSTIFY_LEFT);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

}
