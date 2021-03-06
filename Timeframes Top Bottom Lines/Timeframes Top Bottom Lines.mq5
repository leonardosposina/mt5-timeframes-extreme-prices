//+------------------------------------------------------------------+
//|                                  Timeframes Top Bottom Lines.mq5 |
//|                                Copyright 2019, Leonardo Sposina. |
//|           https://www.mql5.com/en/users/leonardo_splinter/seller |
//+------------------------------------------------------------------+

#include "TimeframesLines.mqh"

#property indicator_plots 0

enum ENUM_LINES_STATUS {disabled, enabled};

input ENUM_LINES_STATUS isH1Active = enabled;   // H1 Top/Bottom Lines (1 hour)
input ENUM_LINES_STATUS isH4Active = disabled;  // H4 Top/Bottom Lines (4 hours)
input ENUM_LINES_STATUS isD1Active = enabled;   // D1 Top/Bottom Lines (Daily)
input ENUM_LINES_STATUS isW1Active = disabled;  // W1 Top/Bottom Lines (Weekly)
input ENUM_LINES_STATUS isMN1Active = disabled; // MN1 Top/Bottom Lines (Monthly)
input color lineColor = clrGray;                    // Lines Color
input ENUM_LINE_STYLE lineStyle = STYLE_DASHDOTDOT; // Lines Style

TimeframesLines* h1Lines;
TimeframesLines* h4Lines;
TimeframesLines* d1Lines;
TimeframesLines* w1Lines;
TimeframesLines* mn1Lines;

int OnInit() {
  if (isH1Active)
    h1Lines = new TimeframesLines(PERIOD_H1, lineColor, lineStyle);
  if (isH4Active)
    h4Lines = new TimeframesLines(PERIOD_H4, lineColor, lineStyle);
  if (isD1Active)
    d1Lines = new TimeframesLines(PERIOD_D1, lineColor, lineStyle);
  if (isW1Active)
    w1Lines = new TimeframesLines(PERIOD_W1, lineColor, lineStyle);
  if (isMN1Active)
    mn1Lines = new TimeframesLines(PERIOD_MN1, lineColor, lineStyle);

  return(INIT_SUCCEEDED);
}

void OnDeinit(const int reason) {
  if (isH1Active)
    delete h1Lines;
  if (isH4Active)
    delete h4Lines;
  if (isD1Active)
    delete d1Lines;
  if (isW1Active)
    delete w1Lines;
  if (isMN1Active)  
    delete mn1Lines;
  ChartRedraw();
}

int OnCalculate(
  const int rates_total,
  const int prev_calculated,
  const int begin,
  const double &price[]
) {

  if (isH1Active)
    h1Lines.update();
  if (isH4Active)
    h4Lines.update();
  if (isD1Active)
    d1Lines.update();
  if (isW1Active)
    w1Lines.update();
  if (isMN1Active)
    mn1Lines.update();

  return(rates_total);
}
