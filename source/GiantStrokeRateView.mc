import Toybox.Activity;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;

class GiantStrokeRateView extends WatchUi.DataField {

    typedef FontData as {
        :face as String,
        :percentage as Number,
    };

    private var mValue as Number;
    private var _availableFonts = [] as Array<FontData>;


    function initialize() {
        DataField.initialize();
        mValue = 0;
    

        // RobotoCondensedRegular  1.0
        // RobotoCondensedBold    1.0
        // BionicBold   1.0
        // Swiss721Regular  0.8
        // Swiss721Bold    0.8

        _availableFonts.add({
            :face => "RobotoCondensedRegular",
            :percentage => 95,
        });

        _availableFonts.add({
            :face => "RobotoCondensedBold",
            :percentage => 95,
        });
        
        _availableFonts.add({
            :face => "BionicBold",
            :percentage => 105,
        });
        
        _availableFonts.add({
            :face => "Swiss721Regular",
            :percentage => 72,
        });

        _availableFonts.add({
            :face => "Swiss721Bold",
            :percentage =>  75,
        });
                
    }

    //! Update the view
    //! @param dc Device context
    function onUpdate(dc as Dc) as Void {
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();

        var fontIdx = 0;

        var fieldLabel = "Stroke Rate";

        var fontData = _availableFonts[fontIdx];
        var face = fontData[:face];
        var size = dc.getWidth() * fontData[:percentage] / 100;

        fieldLabel = "Stroke Rate";

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(dc.getWidth() / 2, 30, Graphics.FONT_XTINY, fieldLabel as String, Graphics.TEXT_JUSTIFY_CENTER);

        // Draw the vector font name given the _vectorFontOption array as parameters.
        try {
            var font = Graphics.getVectorFont({
                :face => face as String,
                :size => size as Number
            });

            if (font != null) {
                var text = mValue.format("%d");
                
                dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2, font, text, Graphics.TEXT_JUSTIFY_VCENTER|Graphics.TEXT_JUSTIFY_CENTER);
                System.println("dc width " + dc.getWidth() + "  height  " + dc.getHeight());
            } else {
                dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2, Graphics.FONT_XTINY, "No Font", Graphics.TEXT_JUSTIFY_CENTER);
            }

        } catch (e) {

            var msg = e.getErrorMessage();

            if (msg == null) {
                msg = e.toString();
            }

            dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2, Graphics.FONT_XTINY, msg, Graphics.TEXT_JUSTIFY_CENTER);
        }
    }



    // The given info object contains all the current workout information.
    // Calculate a value and save it locally in this method.
    // Note that compute() and onUpdate() are asynchronous, and there is no
    // guarantee that compute() will be called before onUpdate().
    function compute(info as Activity.Info) as Void {
        // See Activity.Info in the documentation for available information.
        if(info has :currentCadence && info.currentCadence != null){
            mValue = info.currentCadence as Number;
        } else {
            mValue = 0;
        }
        
    }



}
