/**
* MochiServices
* Connection class for all MochiAds Remote Services
* @author Mochi Media
*/

class mochi.as2.MochiDigits
{
    private var Fragment:Number;
    private var Sibling:MochiDigits;
    private var Encoder:Number;

    /**
     * Method: MochiDigits
     * Construct and initialize the value of a MochiDigit
     * @param   digit: initialization value
     * @param   index: internal use only
     */
    public function MochiDigits( digit:Number, index:Number )
    {
        Encoder = 0;
        setValue( digit, index );
    }

    public function get value():Number
    {
        return Number(this.toString());
    }

    public function set value(v:Number)
    {
        setValue( v );
    }

    /**
     * Method: add
     * Increments the stored value by a specified amount
     * @param   inc: Value to add to the stored variable
     */
    public function addValue(v:Number)
    {
        this.value += v;
    }

    /**
     * Method: setValue
     * Resets the stored value
     * @param   digit: initialization value
     * @param   index: internal use only
     */
    public function setValue( digit:Number, index:Number )
    {
        var s:String = digit.toString();

        if( index == undefined || isNaN(index) )
            index = 0;

        Fragment = s.charCodeAt(index++) ^ Encoder;

        if( index < s.length )
            Sibling = new MochiDigits(digit,index);
        else
            Sibling = null;

        reencode();
    }

    /**
     * Method: reencode
     * Reencodes the stored number without changing its value
     */
    public function reencode()
    {
        var newEncode:Number = int(0x7FFFFFFF * Math.random());

        Fragment ^= newEncode ^ Encoder;
        Encoder = newEncode;
    }

    /**
     * Method: toString
     * Returns the stored number as a formatted string
     */
    public function toString():String
    {
        var s:String = String.fromCharCode(Fragment ^ Encoder);

        return ( Sibling != null ) ? s.concat(Sibling.toString()) : s;
    }
}
