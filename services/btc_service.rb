require 'nokogiri'
require 'httparty'
require 'pp'
require 'cryptocompare'
def get_gann(high, low, close)
    gannurl = 'http://www.pivottrading.co.in/pages/gannPositional.php'
    headers = {
        'Content-Type' => 'application/x-www-form-urlencoded',
        'User-Agent' => 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36'    
    }
    opts = { high: high, low: low, close: close}

    body = HTTParty.post(gannurl, body: opts, headers: headers).body
    doc = Nokogiri::HTML(body)
    File.open('test.html','w') { |f| f.write(doc) }
    r1 = doc.at('#impRes1').text
    r2 = doc.at('#impRes2').text
    r3 = doc.at('#impRes3').text
    s1 = doc.at('#impSup1').text
    s2 = doc.at('#impSup2').text
    s3 = doc.at('#impSup3').text
    [s1, s2, s3, r1, r2, r3]
end
def get_elliott(high, low, close, open)
    ellioturl = 'http://www.pivottrading.co.in/pages/advancedElliott.php'

    opts = { 
        high: high,
        low: low,
        close: close,
        open: open
    }
    body = HTTParty.post(ellioturl, body: opts).body
    doc = Nokogiri::HTML(body)
    r1 = doc.at('#alertMessage')
    [OpenStruct.new(
        action: r1.children[3].children[0].text.strip,
        entry: r1.children[3].children[1].text.strip.to_f, 
        target: r1.children[3].children[3].text.strip.to_f,
        stoploss: r1.children[3].children[5].text.strip.to_f,
        note: r1.children[3].children[6].text.strip
    )]
end

def get_all_btc(base: 'XVG', lookback: -1, duration: 5)     
    target = 'BTC'
    dat = Cryptocompare::HistoDay.find(base, target)["Data"]
    from = lookback - duration - 1
    to = lookback - 1
    high = 10**8 *  dat.map { |t| t["high"] }[from..to].max
    low = 10**8 * dat.map { |t| t['low'] }[from..to].min
    close = 10**8 * dat.map { |t| t['close'] }[from..to][-2]
    open = 10**8 * dat.map { |t| t['open'] }[from..to][-1]
    _gann = get_gann(high, low, close)
    _elliot = get_elliott(high, low, close, open)
    current = Cryptocompare::PriceHistorical.find(base, target)[base][target] * 10**8
    #[current ,_gann, _elliot]
    OpenStruct.new(
        name: base,
        recommendations: _elliot,
        extras: [],
        supports: _gann[0..2],
        resistances: _gann[3..5]
    )
end
