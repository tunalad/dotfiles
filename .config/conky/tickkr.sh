#!/bin/sh

TICKER="${1:?Usage: tickker.sh <ticker>}"
URL="https://query1.finance.yahoo.com/v8/finance/chart/${TICKER}?range=1d&interval=1d"

json=$(curl -sf -A "Mozilla/5.0" "$URL") || {
    echo "Error: fetch failed"
    exit 1
}

echo "$json" | awk '
function extract(str, key,    idx, val) {
    idx = index(str, "\"" key "\":")
    if (!idx) return "N/A"
    val = substr(str, idx + length(key) + 3)
    sub(/[^0-9.\-]+.*/, "", val)
    return val
}
function extractstr(str, key,    idx, val) {
    idx = index(str, "\"" key "\":\"")
    if (!idx) return "N/A"
    val = substr(str, idx + length(key) + 4)
    sub(/".*/, "", val)
    return val
}
{
    current   = extract($0, "regularMarketPrice")
    prev      = extract($0, "chartPreviousClose")
    day_lo    = extract($0, "regularMarketDayLow")
    day_hi    = extract($0, "regularMarketDayHigh")
    w52_lo    = extract($0, "fiftyTwoWeekLow")
    w52_hi    = extract($0, "fiftyTwoWeekHigh")
    currency  = extractstr($0, "currency")
    exchange  = extractstr($0, "fullExchangeName")
    symbol    = extractstr($0, "symbol")
    #shortname = extractstr($0, "shortName")

    change = current - prev
    pct    = change / prev * 100
    sign   = change >= 0 ? "+" : ""
    arrow  = change >= 0 ? "▲" : "▼"

    #printf "%s\n", shortname
    printf "%s  %s\n", symbol, exchange
    printf "%.2f %s  %s %s%.2f (%s%.1f%%)\n", current, currency, arrow, sign, change, sign, pct
    printf "day  %.2f \342\200\224 %.2f\n", day_lo, day_hi
    printf "52w  %.2f \342\200\224 %.2f\n", w52_lo, w52_hi
}
'
