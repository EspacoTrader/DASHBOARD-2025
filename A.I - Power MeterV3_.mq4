#property copyright "Fênix Capital HFT"
#property link      "https://www.instagram.com/fenix.capital.hft/"
#property version   "1.00"
#property strict
#include <stdlib.mqh>
#include <WinUser32.mqh>
#include <ChartObjects\ChartObjectsTxtControls.mqh>

//#define BullColor Lime
//#define BearColor Tomato

enum dbu {Constant=0,OneMinute=1,FiveMinutes=5};

sinput     string          t_trade                    = "EXPERT MANAGEMENT"; // =================================
sinput     bool            UseDefaultPairs            = true;              // Use the default 28 pairs
sinput     string          OwnPairs                   = "AUDCAD,AUDCHF,AUDJPY,AUDNZD,AUDUSD,CADCHF,CADJPY,CHFJPY,EURAUD,EURCAD,EURCHF,EURGBP,EURJPY,EURNZD,EURUSD,GBPAUD,GBPCAD,GBPCHF,GBPJPY,GBPNZD,GBPUSD,NZDCAD,NZDCHF,NZDJPY,NZDUSD,USDCAD,USDCHF,USDJPY";                // Comma seperated own pair list
sinput     dbu             DashUpdate                 = 0;                 // Dashboard update interval
sinput     int             Magic_Number               = 1;
/*sinput*/ bool            autotrade                  = true;
//====================================================================================================================
/*sinput*/     string          t_triggerGERAL               = "PIP"; // =================================
/*sinput*/     ENUM_TIMEFRAMES PERIOD_GERAL                 = PERIOD_H4;              // TimeFrame GERAL
//====================================================================================================================
sinput     string          t_triggerHM                = "HEATMAP"; // =================================
/*sinput*/ bool            trigger_UseHeatMap1        = true;             // Use Heat Map
sinput     ENUM_TIMEFRAMES trigger_TF_HM1             = PERIOD_H4;              // TimeFrame for Heat Map 
sinput     double          trade_MIN_HeatMap1         = 0.01;               // Minimum % HeatMap to open position
sinput     double          trade_MAX_HeatMap1         = 0.20;               // Maximum % HeatMap to open position
//===========================================================================================================
/*extern*/   bool         trigger_UseHeatMap2         = true    ;//======================== 
input   ENUM_TIMEFRAMES   trigger_TF_HM2              = PERIOD_W1       ;//TimeFrame Heat Map 2
input   double            trade_MIN_HeatMap2          = 0.01     ;//Minimo % HeatMap2 para abrir posição
sinput  double            trade_MAX_HeatMap2          = 2.00;               // Maximum % HeatMap to open position
//====================================================================================================================
/*sinput*/    string           AI_set_AdrDir     = "(AdrDir)";
/*sinput*/bool             AI_AdrDir        = false      ;// (AI)AdrDir :
//=====================================================================================================================
sinput     string          t_triggerPIP               = "PIP"; // =================================
/*sinput*/ bool            trigger_use_Pips           = true;              // Use Pips
sinput     ENUM_TIMEFRAMES PERIOD_PIP                 = PERIOD_M30;   // TimeFrame for Pip 
sinput     double          trade_MIN_pips             = 1     ;     // Minimum pips to open position
sinput     double          trade_MAX_pips             = 20       ;//Maximum pips to open position
//=====================================================================================================================
sinput     string          t_triggerADR               = "ADR"; // =================================
sinput     ENUM_TIMEFRAMES PERIOD_ADR                 = PERIOD_D1;   // TimeFrame for ADR 
//====================================================================================================================
input     string           t_triggerUSD               = "FORÇA STR";//===========================================  
/*sinput*/bool             trigger_use_Strength       = true      ;//Use Strength filtro
input     ENUM_TIMEFRAMES  trigger_TF_Strength        = PERIOD_M30 ;//TimeFrame for USD Calculation
input     double           trade_MIN_Strength         = 60        ;//Minimum % USD to open position
//=====================================================================================================================
   /*input*/   string               t_triggerBD1                  = "POWER METER ";//BID RATIO AJUSTE 1 =========
   /*sinput*/  bool                 ShowPowerMeter1          = true; // Show power meter panel
   /*sinput*/   bool                         trigger_use_bidratio1         = false    ;//Use BidRatio filtro
   /*input*/   ENUM_TIMEFRAMES      periodBR1                     = PERIOD_D1        ;//TimeFrame BidRatio
   /*input*/   double               trigger_buy_bidratio1         = 1       ;//% Level to open purchase
   /*sinput*/  double               trade_MIN_buy_bidratio1       = 1       ;//Minimum adjustment for opening
   /*sinput*/  double               trade_MAX_buy_bidratio1       = 99       ;//Maximum opening adjustment   
   /*input*/   double               trigger_sell_bidratio1        = -1      ;//% Level to open sale
   /*sinput*/  double               trade_MIN_sell_bidratio1      = -1      ;//Minimum adjustment for opening
   /*sinput*/  double               trade_MAX_sell_bidratio1      = -99      ;//Maximum opening adjustment    
//=====================================================================================================================
sinput     string          t_triggerBD                = "BIDRATIO"; // =================================
/*sinput*/ bool            trigger_use_bidratio       = true;              // Use BidRatio filtering
sinput     ENUM_TIMEFRAMES PERIOD_BID                 = PERIOD_M30;              // TimeFrame for BID  
sinput     int             Period_1                   = 1;
sinput     double          trigger_buy_bidratio       = 70         ;// % Level to open Buy
sinput     double          trade_MIN_buy_bidratio     = 70         ;//Minimum adjustment for opening
sinput     double          trade_MAX_buy_bidratio     = 100        ;//Maximum opening adjustment
sinput     double          trigger_sell_bidratio      = 30         ;// % Level to open Sell
sinput     double          trade_MIN_sell_bidratio    = 30         ;//Minimum adjustment for opening
sinput     double          trade_MAX_sell_bidratio    = 0          ;//Maximum opening adjustment
sinput     string          t_triggerBSR = "BUY/SELL RATIO"; // =================================
/*sinput*/ bool            trigger_use_buysellratio   = true;  // Use Buy/Sell Ratio filtering
sinput     double          trigger_buy_buysellratio   = 2.0;     // Level to open Buy
sinput     double          trade_MIN_buy_buysellratio = 2.0        ;//Minimum adjustment for opening
sinput     double          trade_MAX_buy_buysellratio = 10.0       ;//Maximum opening adjustment  
sinput     double          trigger_sell_buysellratio  = -2.0      ;   // level to open Sell
sinput     double          trade_MIN_sell_buysellratio= -2.0       ;//Minimum adjustment for opening
sinput     double          trade_MAX_sell_buysellratio= -10.0      ;//Maximum opening adjustment

sinput     string          t_triggerSTR = "RELSTRENGHT"; // =================================
/*sinput*/ bool            trigger_use_relstrength    = true;      // Use Relative Strength filtering (Base)
sinput     double          trigger_buy_relstrength    = 6.0;       // Strenth to open Buy
sinput     double          trade_MIN_buy_relstrength  = 6.0        ;//Minimum adjustment for opening
sinput     double          trade_MAX_buy_relstrength  = 10.0       ;//Maximum opening adjustment
sinput     double          trigger_sell_relstrength   = -6.0;      // Strength to open Sell
sinput     double          trade_MIN_sell_relstrength = -6.0       ;//Minimum adjustment for opening
sinput     double          trade_MAX_sell_relstrength = -10.0      ;//Maximum opening adjustment
sinput     string          t_triggerGAP = "GAP"; // =================================

sinput     string          t_triggerPREVGAP = "PREVGAP"; // =================================
/*sinput*/ bool            trigger_use_PrevGap            = false;      // Use Gap filtering
sinput     double          trigger_PrevGap_buy            = 4.0        ; // Gap level to open Buy
sinput     double          trade_MIN_PrevGap_buy          = 4.0        ;//Minimum adjustment for opening
sinput     double          trade_MAX_PrevGap_buy          = 15.0       ;//Maximum opening adjustment 
sinput     double          trigger_PrevGap_sell           = -4.0       ; // Gap level to open Sell
sinput     double          trade_MIN_PrevGap_sell         = -4.0       ;//Minimum adjustment for opening
sinput     double          trade_MAX_PrevGap_sell         = -15.0      ;//Maximum opening adjustment

sinput     string          t_triggerGAPp = "GAP"; // =================================
/*sinput*/ bool            trigger_use_gap            = true;      // Use Gap filtering
sinput     double          trigger_gap_buy            = 4.0        ; // Gap level to open Buy
sinput     double          trade_MIN_gap_buy          = 4.0        ;//Minimum adjustment for opening
sinput     double          trade_MAX_gap_buy          = 15.0       ;//Maximum opening adjustment 
sinput     double          trigger_gap_sell           = -4.0       ; // Gap level to open Sell
sinput     double          trade_MIN_gap_sell         = -4.0       ;//Minimum adjustment for opening
sinput     double          trade_MAX_gap_sell         = -15.0      ;//Maximum opening adjustment 
//=====================================================================================================================
sinput    string           t_RSI                      = "RSI MANAGEMENT"; // ================================================
/*sinput*/ bool             trigger_use_RSI            = true       ;              // Use RSI filtering
sinput    ENUM_TIMEFRAMES  trigger_RSI_Timeframe      = PERIOD_M30  ;                // RSI Timeframe
sinput    int              trigger_RSI_period         = 2          ;                  // RSI Period
sinput    double           trigger_buy_RSI            = 70         ;                // RSI level to open Buy
sinput    double           trigger_sell_RSI           = 30         ;                 // RSI level to open Sell
sinput    ENUM_APPLIED_PRICE trigger_RSI_Applied        = 0          ;                  // RSI Applied Price
sinput    int              trigger_RSI_shift          = 0          ;                  // RSI 0=current bar 1=previous bar     
//=====================================================================================================================
sinput     string          AI_set_Fibonacci           = "(AI) - Fibonacci";           // =================================
/*sinput*/ bool            AI_Fibonacci               = true       ;// Fibonacci :
sinput     ENUM_TIMEFRAMES PERIOD_FIBO                = PERIOD_M30  ;// FIBO Timeframe
sinput     double          AI_Fibonacci_BUY_Dari      = 100.00     ;// Minimum level BUY 61.80
sinput     double          AI_Fibonacci_BUY_Sampai    = 161.80     ;// Maximum level BUY 161.80
sinput     double          AI_Fibonacci_SELL_Dari     = 00.00      ;// Minimum level SELL 38.20
sinput     double          AI_Fibonacci_SELL_Sampai   = -61.80     ;// Maximum level SELL - 61.80
sinput     string          AI_set_FibonacciB           = "(AI) - Fibonacci";           // =================================
/*sinput*/ bool            AI_FibonacciB               = true       ;// Fibonacci :
sinput     ENUM_TIMEFRAMES PERIOD_FIBOB                = PERIOD_M30  ;// FIBO Timeframe
sinput     double          AI_Fibonacci_BUY_DariB      = 100.00     ;// Minimum level BUY 61.80
sinput     double          AI_Fibonacci_BUY_SampaiB    = 161.80     ;// Maximum level BUY 161.80
sinput     double          AI_Fibonacci_SELL_DariB     = 00.00      ;// Minimum level SELL 38.20
sinput     double          AI_Fibonacci_SELL_SampaiB   = -61.80     ;// Maximum level SELL - 61.80
sinput     string          AI_set_FibonacciC           = "(AI) - Fibonacci";           // =================================
/*sinput*/ bool            AI_FibonacciC               = true       ;// Fibonacci :
sinput     ENUM_TIMEFRAMES PERIOD_FIBOC                = PERIOD_M30  ;// FIBO Timeframe
sinput     double          AI_Fibonacci_BUY_DariC      = 100.00     ;// Minimum level BUY 61.80
sinput     double          AI_Fibonacci_BUY_SampaiC    = 161.80     ;// Maximum level BUY 161.80
sinput     double          AI_Fibonacci_SELL_DariC     = 00.00      ;// Minimum level SELL 38.20
sinput     double          AI_Fibonacci_SELL_SampaiC   = -61.80     ;// Maximum level SELL - 61.80
//=======================================================================================================
sinput     string          AI_Stochastic_A            = "Stochastic Ke-1" ;    // =================================
/*sinput*/ bool            AI_Stochastic1             = true       ;     // (AI)Stochastic :
sinput     ENUM_TIMEFRAMES TF_StochasticM30           = PERIOD_M30  ;     // Timeframe Stochastic 
sinput     double          kPeriod_1                  = 4          ;
sinput     double          Slowing_1                  = 4          ;
sinput     double          dPeriod_1                  = 4          ;
/*sinput*/     double          maMethod_1                 = 0         ;
sinput     double          priceField_1               = 1          ;
sinput     double          AI_Stochastic_A_BUY_Dari   = 80.00      ; // Minimum level BUY
sinput     double          AI_Stochastic_A_BUY_Sampai = 100.00     ;   // Maximum level BUY
sinput     double          AI_Stochastic_A_SELL_Dari  = 20.00      ;     // Minimum level SELL
sinput     double          AI_Stochastic_A_SELL_Sampai= 0.00      ;     // Maximum level SELL
//=======================================================================================================
sinput     string          AI_Stochastic_B            = "Stochastic Ke-2" ;                       // =================================
/*sinput*/ bool            AI_Stochastic2             = true      ; 
sinput     ENUM_TIMEFRAMES TF_StochasticH1            = PERIOD_M30  ; 
sinput     double          kPeriod_2                  = 4          ;
sinput     double          Slowing_2                  = 4          ;
sinput     double          dPeriod_2                  = 4          ;
/*sinput*/     double          maMethod_2                 = 0       ;
sinput     double          priceField_2               = 1          ;
sinput     double          AI_Stochastic_B_BUY_Dari   = 80.00      ;    // Minimum level BUY
sinput     double          AI_Stochastic_B_BUY_Sampai = 100.00     ;   // Maximum level BUY
sinput     double          AI_Stochastic_B_SELL_Dari  = 20.00      ;    // Minimum level SELL
sinput     double          AI_Stochastic_B_SELL_Sampai= 0.00      ;    // Maximum level SELL
//=======================================================================================================
sinput     string          AI_Stochastic_C            = "Stochastic Ke-3" ;  // =================================
/*sinput*/ bool            AI_Stochastic3             = true      ; 
sinput     ENUM_TIMEFRAMES TF_StochasticH4            = PERIOD_M30  ;
sinput     double          kPeriod_3                  = 4          ;
sinput     double          Slowing_3                  = 4          ;
sinput     double          dPeriod_3                  = 4          ;
/*sinput*/     double          maMethod_3                 = 0       ;
sinput     double          priceField_3               = 1          ;
sinput     double          AI_Stochastic_C_BUY_Dari   = 80.00      ;  // Minimum level BUY
sinput     double          AI_Stochastic_C_BUY_Sampai = 100.00     ;  // Maximum level BUY
sinput     double          AI_Stochastic_C_SELL_Dari  = 20.00      ;  // Minimum level SELL
sinput     double          AI_Stochastic_C_SELL_Sampai= 0.00      ;     // Maximum level SELL
//=======================================================================================================
sinput string                 ID_set_ADX                    = "Adjustment - ADX"; // =================================
/*sinput*/ bool             AI_ADX                    = true       ; 
sinput    ENUM_TIMEFRAMES  trigger_ADX_Timeframe     = PERIOD_M30  ; 
sinput int                    trigger_ADX_period            = 2;  // ADX Period
sinput string                 ID_set_ATR                    = "Adjustment - ATR";// =================================
/*sinput*/ bool             AI_ATR                    = true ;      
sinput    ENUM_TIMEFRAMES  trigger_ATR_Timeframe     = PERIOD_M30  ; 
sinput int                    trigger_ATR_period            = 2;   // ATR Period
sinput string                 ID_set_Williams               = "Adjustment - Williams %R";   // =================================
/*sinput*/ bool             AI_WILL                    = true ;   
sinput    ENUM_TIMEFRAMES  trigger_WILL_Timeframe     = PERIOD_M30 ; 
sinput int                    trigger_Williams_period       = 2;   // Williams %R Period

//=====================================================================================================================
//=====================================================================================================================
input      string          t_trigger1                 = "TRIGGER MANAGEMENT MM";// ================================     
/*sinput*/ bool            trigger_Moving_Average1    = true       ;// Use Moving Average
input      ENUM_TIMEFRAMES PERIODMM_M1                = PERIOD_M30  ;//TimeFrame
sinput     int             trade_Period_MAM1          = 2         ;// Moving Average Period 
/*sinput*/ bool            trigger_Moving_Average2    = true      ;// Use Moving Average
input      ENUM_TIMEFRAMES PERIODMM_M5                = PERIOD_M30  ;//TimeFrame
sinput     int             trade_Period_MAM5          = 2          ;// Moving Average Period 
/*sinput*/ bool            trigger_Moving_Average3    = true      ;// Use Moving Average
input      ENUM_TIMEFRAMES PERIODMM_M15               = PERIOD_M30  ;//TimeFrame
sinput     int             trade_Period_MAM15         = 2;// Moving Average Period 

//=====================================================================================================================
/*sinput*/ string                 AI_RSI_AA                      = "RSI Ke-1" ;                              // =================================
/*sinput*/ bool             AI_RSI_A            = false       ;              // Use RSI filtering
/*sinput*/ ENUM_TIMEFRAMES        trigger_RSIA_Timeframe        = PERIOD_H4;                               // RSI Ke-1 Timeframe
/*sinput*/ int                    trigger_RSIA_period            = 2;                                       // RSI Period
/*sinput*/ ENUM_APPLIED_PRICE     trigger_RSIA_Applied           = 0;                                        // RSI Applied Price
/*sinput*/ int                    trigger_RSIA_shift             = 0;                                        // RSI 0=current bar 1=previous bar
/*sinput*/ double                 AI_RSI_A_BUY_Dari             = 60.00;                                    // Minimum level BUY
/*sinput*/ double                 AI_RSI_A_BUY_Sampai           = 100.00;                                   // Maximum level BUY
/*sinput*/ double                 AI_RSI_A_SELL_Dari            = 40.00;                                    // Minimum level SELL
/*sinput*/ double                 AI_RSI_A_SELL_Sampai          = 0.00;                                    // Maximum level SELL

/*sinput*/ string                 AI_RSI_BB                      = "RSI Ke-2" ;                              // =================================
/*sinput*/ bool             AI_RSI_B            = false       ;              // Use RSI filtering
/*sinput*/ ENUM_TIMEFRAMES        trigger_RSIB_Timeframe        = PERIOD_H4;                                // RSI Ke-2 Timeframe
/*sinput*/ int                    trigger_RSIB_period            = 2;                                       // RSI Period
/*sinput*/ ENUM_APPLIED_PRICE     trigger_RSIB_Applied           = 0;                                        // RSI Applied Price
/*sinput*/ int                    trigger_RSIB_shift             = 0;                                        // RSI 0=current bar 1=previous bar
/*sinput*/ double                 AI_RSI_B_BUY_Dari             = 60.00;                                    // Minimum level BUY
/*sinput*/ double                 AI_RSI_B_BUY_Sampai           = 100.00;                                   // Maximum level BUY
/*sinput*/ double                 AI_RSI_B_SELL_Dari            = 40.00;                                    // Minimum level SELL
/*sinput*/ double                 AI_RSI_B_SELL_Sampai          = 0.00;                                    // Maximum level SELL

/*sinput*/ string                 AI_RSI_CC                      = "RSI Ke-3" ;                              // =================================
/*sinput*/ bool             AI_RSI_C            = false       ;              // Use RSI filtering
/*sinput*/ ENUM_TIMEFRAMES        trigger_RSIC_Timeframe        = PERIOD_H4;                                // RSI Ke-3 Timeframe
/*sinput*/ int                    trigger_RSIC_period            = 2;                                       // RSI Period
/*sinput*/ ENUM_APPLIED_PRICE     trigger_RSIC_Applied           = 0;                                        // RSI Applied Price
/*sinput*/ int                    trigger_RSIC_shift             = 0;                                        // RSI 0=current bar 1=previous bar
/*sinput*/ double                 AI_RSI_C_BUY_Dari             = 60.00;                                    // Minimum level BUY
/*sinput*/ double                 AI_RSI_C_BUY_Sampai           = 100.00;                                   // Maximum level BUY
/*sinput*/ double                 AI_RSI_C_SELL_Dari            = 40.00;                                    // Minimum level SELL
/*sinput*/ double                 AI_RSI_C_SELL_Sampai          = 0.00;                                    // Maximum level SELL
//=====================================================================================================================
/*sinput*/    string           t_triggerCCI               = "TRIGGER MANAGEMENT CCI";// ================================     
/*sinput*/bool             AI_CCIA                = false       ;              // Use CCI
/*sinput*/    ENUM_TIMEFRAMES  PERIODCCIA                  = PERIOD_H4  ;//TimeFrame
/*sinput*/    int              trade_Period_CCIA           = 2         ;                 // CCI Period
///sinput    double           trigger_CCI_Buy            = -100       ;                // CCI Buy Level
///sinput    double           trigger_CCI_Sell           = 100        ;               // CCI Sell Level
/*sinput*/bool             AI_CCIB                = false       ;              // Use CCI
/*sinput*/    ENUM_TIMEFRAMES  PERIODCCIB                  = PERIOD_H4  ;//TimeFrame
/*sinput*/    int              trade_Period_CCIB           = 2         ;                 // CCI Period
///sinput    double           trigger_CCI_Buy            = -100       ;                // CCI Buy Level
///sinput    double           trigger_CCI_Sell           = 100        ;               // CCI Sell Level
/*sinput*/bool             AI_CCIC                = false       ;              // Use CCI
/*sinput*/    ENUM_TIMEFRAMES  PERIODCCIC                  = PERIOD_H4  ;//TimeFrame
/*sinput*/    int              trade_Period_CCIC           = 2         ;                 // CCI Period
//sinput    double           trigger_CCI_Buy            = -100       ;                // CCI Buy Level
///sinput    double           trigger_CCI_Sell           = 100        ;               // CCI Sell Level
/*sinput*/    string           t_triggerCCI2               = "TRIGGER MANAGEMENT CCI";// ================================     
/*sinput*/bool             trigger_CCI                = false       ;              // Use CCI
/*sinput*/    ENUM_TIMEFRAMES  TF_CCI                  = PERIOD_H4  ;//TimeFrame
/*sinput*/    int              trade_Period_CCI           = 2         ;                 // CCI Period
/*sinput*/    double           trigger_CCI_Buy            = -100       ;                // CCI Buy Level
/*sinput*/    double           trigger_CCI_Sell           = 100        ;               // CCI Sell Level
//=======================================================================================================
/*sinput*/    string           AI_set_MACD                = "Penyesuaian (AI) - MACD";                // =================================*/
/*sinput*/string           ID_set_MACD                = "MACD"     ;                     // =================================
/*sinput*/bool             AI_MACD                    = false       ;                                 // (AI)Gunakan MACD :
/*sinput*/    ENUM_TIMEFRAMES  trigger_MACD_Timeframe     = PERIOD_H4  ;                                // MACD Timeframe
/*sinput*/    int              trigger_MACD_FastEMA       = 5         ;                                       // MACD FastEMA
/*sinput*/    int              trigger_MACD_SlowEMA       = 12         ;                                       // MACD SlowEMA
/*sinput*/    int              trigger_MACD_SignalSMA     = 3          ;                                        // MACD SignalSMA
//=====================================================================================================================
/*sinput*/     string            t_trigger6                  = "TRIGGER MANAGEMENT";//MACD ============================ 
   bool                      trigger_MACD1               = false    ;//Use MACD
/*sinput*/      ENUM_TIMEFRAMES   periodMACD1                 = PERIOD_H4;//
/*sinput*/      int               FastPeriod                  = 5        ;//Fast EMA Period
/*sinput*/      int               SlowPeriod                  = 12       ;//Slow EMA Period
/*sinput*/      int               SignPeriod                  = 3       ;//Signal SMA Period
/*sinput*/                        ENUM_APPLIED_PRICE Price    = PRICE_WEIGHTED;//MACD price
   int                       BarToTest                   = 0        ;//Bar to test
//--- indicator buffers
   double                    ExtMacdBuffer[];
   double                    ExtSignalBuffer[];
//--- right input parameters flag
   bool                      ExtParameters               = false    ;//================================================
//=====================================================================================================================
///*input*/ bool ShowPivots=false; //Show Pivots
//=====================================================================================================================
sinput    string           AI_set_CandleDirection     = "(AI) - Candle Direction IntraDay";    // =================================
/*sinput*/bool             AI_Candle_Direction        = true      ;// (AI)Candle Direction :
/*sinput*/bool             AI_Candle_Direction_TF1    = true       ;// Candle Direction M1 :
/*sinput*/bool             AI_Candle_Direction_TF2    = true       ;// Candle Direction M5 :
/*sinput*/bool             AI_Candle_Direction_TF3    = true       ;// Candle Direction H15 :
/*sinput*/bool             AI_Candle_Direction_TF4    = true       ;// Candle Direction M30 :
/*sinput*/bool             AI_Candle_Direction_TF5    = true       ;// Candle Direction H1 :
/*sinput*/bool             AI_Candle_Direction_TF6    = true       ;// Candle Direction H4 :
/*sinput*/bool             AI_Candle_Direction_TF7    = false       ;// Candle Direction D1 :
/*sinput*/bool             AI_Candle_Direction_TF8    = false       ;// Candle Direction W1 :
/*sinput*/bool             AI_Candle_Direction_TF9    = false       ;// Candle Direction MN1 :
//===================================================================================================================== 
/*sinput*/   string                    t_triggerCANDLEDIR2         = "TRIGGER MANAGEMENT";//CANDLE DIRECTION ==
/*extern*/   bool             trigger_Candle_DirectionM1   = true;//Use a direção da vela M1
/*input*/       ENUM_TIMEFRAMES   trigger_TF_CDM1         = PERIOD_M1  ;//TimeFrame para Candle Direction
/*input*/       ENUM_TIMEFRAMES   trigger_TF_CDM1close         = PERIOD_M1  ;//TimeFrame para Candle Direction
/*extern*/   bool             trigger_Candle_DirectionM5   = true;//Use a direção da vela M5
/*input*/       ENUM_TIMEFRAMES   trigger_TF_CDM5         = PERIOD_M5  ;//TimeFrame para Candle Direction
/*input*/       ENUM_TIMEFRAMES   trigger_TF_CDM5close         = PERIOD_M5  ;//TimeFrame para Candle Direction
/*extern*/   bool             trigger_Candle_DirectionM15   = true;//Use a direção da vela M15
/*input*/       ENUM_TIMEFRAMES   trigger_TF_CDM15         = PERIOD_M15  ;//TimeFrame para Candle Direction
/*input*/       ENUM_TIMEFRAMES   trigger_TF_CDM15close         = PERIOD_M15  ;//TimeFrame para Candle Direction
/*extern*/   bool             trigger_Candle_DirectionM30   = true;//Use a direção da vela M30
/*input*/       ENUM_TIMEFRAMES   trigger_TF_CDM30         = PERIOD_M30  ;//TimeFrame para Candle Direction
/*input*/       ENUM_TIMEFRAMES   trigger_TF_CDM30close         = PERIOD_M30  ;//TimeFrame para Candle Direction
/*extern*/   bool             trigger_Candle_DirectionH1   = true;//Use a direção da vela H1
/*input*/       ENUM_TIMEFRAMES   trigger_TF_CDH1         = PERIOD_H1  ;//TimeFrame para Candle Direction
/*input*/       ENUM_TIMEFRAMES   trigger_TF_CDH1close         = PERIOD_H1  ;//TimeFrame para Candle Direction
/*extern*/   bool             trigger_Candle_DirectionH4   = true;//Use a direção da vela H4
/*input*/       ENUM_TIMEFRAMES   trigger_TF_CDH4         = PERIOD_H4  ;//TimeFrame para Candle Direction
/*input*/       ENUM_TIMEFRAMES   trigger_TF_CDH4close         = PERIOD_H4  ;//TimeFrame para Candle Direction
/*extern*/   bool             trigger_Candle_DirectionD1   = false;//Use a direção da vela D1
/*input*/       ENUM_TIMEFRAMES   trigger_TF_CDD1         = PERIOD_D1  ;//TimeFrame para Candle Direction
/*input*/       ENUM_TIMEFRAMES   trigger_TF_CDD1close         = PERIOD_D1  ;//TimeFrame para Candle Direction
/*extern*/   bool             trigger_Candle_DirectionW1   = false;//Use a direção da vela W1
/*input*/       ENUM_TIMEFRAMES   trigger_TF_CDW1         = PERIOD_W1  ;//TimeFrame para Candle Direction
/*input*/       ENUM_TIMEFRAMES   trigger_TF_CDW1close         = PERIOD_W1  ;//TimeFrame para Candle Direction
//=====================================================================================================================

//=====================================================================================================================
sinput    string           t_basket                   = "BASKET MANAGEMENT"; // =================================
extern    double           lot                        = 0.10       ;//Fixed lot size 0.00
extern    double           lotStep                    = 0.10       ;//Lot size (0.01)
sinput    int              MaxTrades                  = 1;                  // Max trades per pair
sinput    int              MaxTotalTrades             = 0;                  // Max total trades overall
sinput    double           MaxSpread                  = 4.5;                // Max Spread Allowe
/*sinput*/int              Basket_Target              = 0;                  // Basket Take Profit in $
/*sinput*/int              Basket_StopLoss            = 0;                  // Basket Stop Lloss in $
extern    int              Piptp                      = 00         ;//Takeprofit em pips 
extern    double           PiptpStep                  = 5          ;
extern    int              Pipsl                      = 00         ;//Stoploss em pips 
extern    double           PipslStep                  = 5          ;
extern    double           Pair_Target                = 300.0       ;//Take Profit in $
extern    double           Pair_StopLoss              = 300.0       ;//Stop Loss in $
//=====================================================================================================================
/*sinput*/double           BasketP1                   = 0.0;                // At profit 1
/*sinput*/double           BasketL1                   = 0.0;                // Lock 1
/*sinput*/double           BasketP2                   = 0.0;                // At profit 2
/*sinput*/double           BasketL2                   = 0.0;                // Lock 2
/*sinput*/double           BasketP3                   = 0.0;                // At profit 3
/*sinput*/double           BasketL3                   = 0.0;                // Lock 3
/*sinput*/double           BasketP4                   = 0.0;                // At profit 4
/*sinput*/double           BasketL4                   = 0.0;                // Lock 4
/*sinput*/double           BasketP5                   = 0.0;                // At profit 5
/*sinput*/double           BasketL5                   = 0.0;                // Lock 5
/*sinput*/double           BasketP6                   = 0.0;                // At profit 6
/*sinput*/double           BasketL6                   = 0.0;                // Lock 6
sinput    bool             TrailLastLock              = true;               // Trail the last set lock
sinput    double           TrailDistance              = 0.0;                // Trail distance 0 means last lock
sinput    int              StopProfit                 = 0;                  // Stop after this many profitable baskets
extern    double           Adr1tp                     = 80          ;//Takeprofit percent adr(10) 0=None
extern    double           Adr1tpStep                 = 10         ;
extern    double           Adr1sl                     = 80          ;//Stoploss adr percent adr(10) 0 = None
extern    double           Adr1slStep                 = 10         ;
sinput    int              StopLoss                   = 0;                  // Stop after this many losing baskets baskets
sinput    bool             OnlyAddProfit              = true;               // Only adds trades in profit 
sinput    bool             CloseAllSession            = false;              // Close all trades after session(s)

//=====================================================================================================================
sinput   string            t_time                     = "SESSÂO"; // =================================
sinput   bool              UseSession1                = true;
sinput   string            sess1start                 = "00:00";
sinput   string            sess1end                   = "23:59";
sinput   string            sess1comment               = "AUTO SESS1";
sinput   bool              UseSession2                = false;
sinput   string            sess2start                 = "00:00";
sinput   string            sess2end                   = "23:59";
sinput   string            sess2comment               = "AUTO SESS2";
sinput   bool              UseSession3                = false;
sinput   string            sess3start                 = "00:00";
sinput   string            sess3end                   = "23:59";
sinput   string            sess3comment               = "AUTO SESS3";
/*sinput*/int              brokerGMTOffset            = 0; // Broker GMT offset time
//=====================================================================================================================
/*sinput*/ bool                      ShowRSICCIMACD          = false; // Show MMRSICCI 
//=====================================================================================================================
sinput   string   t_chart                             = "CHART MANAGEMENT"; // =================================
sinput   ENUM_TIMEFRAMES           TimeFrame          = PERIOD_H4;                //TimeFrame to open chart
sinput   string                    usertemplate       = "Fênix";
/*sinput*/int                       x_axis            =0;
/*sinput*/int                       y_axis            =123;
//=====================================================================================================================
   int                       a_axis                      = 1458       ;//Esquerda X Direita //536
   int                       aa_axis                     = 241        ;//Cima X Baixo //223 
   int                       z_axis                      = 1458       ;//Esquerda X Direita //536              
//=====================================================================================================================
//AJUSTE CANDLE 1 AO 8
/*sinput*/   int   p1x_axis   =5;/*sinput*/   int   p1y_axis   =95;//0-//95
/*sinput*/   int   p2x_axis   =5;/*sinput*/   int   p2y_axis   =95;//0-//95
/*sinput*/   int   p3x_axis   =5;/*sinput*/   int   p3y_axis   =95;//0-//95
/*sinput*/   int   p4x_axis   =5;/*sinput*/   int   p4y_axis   =95;//0-//95
/*sinput*/   int   p5x_axis   =5;/*sinput*/   int   p5y_axis   =95;//0-//95
/*sinput*/   int   p6x_axis   =5;/*sinput*/   int   p6y_axis   =95;//0-//95
/*sinput*/   int   p7x_axis   =5;/*sinput*/   int   p7y_axis   =95;//0-//95
/*sinput*/   int   p8x_axis   =5;/*sinput*/   int   p8y_axis   =95;//0-//95
//AJUSTE ST 
/*sinput*/   int   st1x_axis   =-90;/*sinput*/   int   st1y_axis   =90;//5-//95
extern color BullColor = Lime;
extern color BearColor = Red;
extern color BBullColor = Lime;
extern color BBearColor = Red;
extern color NeutroColor = Gray;
extern color PMBullColor = Lime;
extern color PMBearColor = Red;
extern color PMNeutroColor = White;
/*sinput*/ string masterPreamble = "CM_Strenght_1";
/*sinput*/ int UpdateInSeconds  = 1;
int BeforeMin = 15;
int FontSize = 8;
string FontName = "Arial";
int ShiftX = 250;
int ShiftY = 70;
int Corner = 0;
//BASKET BOTAO
int B_TP = Basket_Target;  //save it for future restore
int B_SL = Basket_StopLoss;  //save it for future restore

string button_increase_basket_tp = "INCREASE BASKET TP";
string button_decrease_basket_tp = "DECREASE BASKET TP";
string button_increase_basket_sl = "INCREASE BASKET SL";
string button_decrease_basket_sl = "DECREASE BASKET SL";
//BASKET BOTAO
//LOTE PAINEL
string button_increase_lot = "INCREASE LOT";
string button_decrease_lot = "DECREASE LOT";
//---
string button_increase_Piptp = "INCREASE STOPTP";
string button_decrease_Piptp = "DECREASE STOPTP";
string button_increase_Pipsl = "INCREASE STOPSL";
string button_decrease_Pipsl = "DECREASE STOPSL";

string button_enable_basket_lock="ENABLE BASKET LOCK";
string button_enable_basket_tp = "ENABLE BASKET TP";
string button_enable_basket_sl = "ENABLE BASKET SL";
//---
string button_increase_Adr1tp = "INCREASE ADRSTOPTP";
string button_decrease_Adr1tp = "DECREASE ADRSTOPTP";
string button_increase_Adr1sl = "INCREASE ADRSTOPSL";
string button_decrease_Adr1sl = "DECREASE ADRSTOPSL";

//PAINEL LOTES
//buttons for Single and Basket trade inputs
string button_SB1 = "btn_SB_lot_input1";
string button_SB2 = "btn_SB_lot_input2";
string button_SB3 = "btn_SB_lot_input3";
string button_SB4 = "btn_SB_lot_input4";
string button_SB5 = "btn_SB_lot_input5";
string button_SB6 = "btn_SB_lot_input6";
string button_SB7 = "btn_SB_lot_input7";
string button_SB8 = "btn_SB_lot_input8";
string button_SB9 = "btn_SB_TP_input9";
string button_SB10 = "btn_SB_TP_input10";
string button_SB11 = "btn_SB_TP_input11";
string button_SB12 = "btn_SB_TP_input12";

//buttons for HARE trade inputs
string button_H1 = "btn_H_lot_input1";
string button_H2 = "btn_H_lot_input2";
string button_H3 = "btn_H_lot_input3";
string button_H4 = "btn_H_lot_input4";
string button_H5 = "btn_H_lot_input5";
string button_H6 = "btn_H_lot_input6";
string button_H7 = "btn_H_lot_input7";
string button_H8 = "btn_H_lot_input8";
string button_H9 = "btn_H_TP_input9";
string button_H10 = "btn_H_TP_input10";
string button_H11 = "btn_H_TP_input11";
string button_H12 = "btn_H_TP_input12";

//buttons for TORTOISE trade inputs
string button_T1 = "btn_T_lot_input1";
string button_T2 = "btn_T_lot_input2";
string button_T3 = "btn_T_lot_input3";
string button_T4 = "btn_T_lot_input4";
string button_T5 = "btn_T_lot_input5";
string button_T6 = "btn_T_lot_input6";
string button_T7 = "btn_T_lot_input7";
string button_T8 = "btn_T_lot_input8";
string button_T9 = "btn_T_TP_input9";
string button_T10 = "btn_T_TP_input10";
string button_T11 = "btn_T_TP_input11";
string button_T12 = "btn_T_TP_input12";

int S_BS_TP=0.0,S_BS_SL=0.0,H_TP=0.0,H_SL=0.0,TOR_TP=0.0,TOR_SL=0.0;
double S_BS_Lot=0.01,H_Lot=0.01,TOR_Lot=0.01;
string temp_lot="";
string temp_lotc="";
//PAINEL LOTES
string button_close_basket_All = "btn_Close ALL"; 
string button_close_basket_Prof = "btn_Close Prof";
string button_close_basket_Loss = "btn_Close Loss";

string button_reset_ea = "RESET EA";
 
string button_EUR_basket = "EUR_BASKET"; 
string button_EUR_basket_buy = "EUR_BASKET_BUY";
string button_EUR_basket_sell = "EUR_BASKET_SELL";
string button_EUR_basket_close = "EUR_BASKET_CLOSE";

string button_GBP_basket = "GBP_BASKET"; 
string button_GBP_basket_buy = "GBP_BASKET_BUY";
string button_GBP_basket_sell = "GBP_BASKET_SELL";
string button_GBP_basket_close = "GBP_BASKET_CLOSE";

string button_CHF_basket = "CHF_BASKET"; 
string button_CHF_basket_buy = "CHF_BASKET_BUY";
string button_CHF_basket_sell = "CHF_BASKET_SELL";
string button_CHF_basket_close = "CHF_BASKET_CLOSE";

string button_USD_basket = "USD_BASKET"; 
string button_USD_basket_buy = "USD_BASKET_BUY";
string button_USD_basket_sell = "USD_BASKET_SELL";
string button_USD_basket_close = "USD_BASKET_CLOSE";

string button_CAD_basket = "CAD_BASKET"; 
string button_CAD_basket_buy = "CAD_BASKET_BUY";
string button_CAD_basket_sell = "CAD_BASKET_SELL";
string button_CAD_basket_close = "CAD_BASKET_CLOSE";

string button_NZD_basket = "NZD_BASKET"; 
string button_NZD_basket_buy = "NZD_BASKET_BUY";
string button_NZD_basket_sell = "NZD_BASKET_SELL";
string button_NZD_basket_close = "NZD_BASKET_CLOSE";

string button_AUD_basket = "AUD_BASKET"; 
string button_AUD_basket_buy = "AUD_BASKET_BUY";
string button_AUD_basket_sell = "AUD_BASKET_SELL";
string button_AUD_basket_close = "AUD_BASKET_CLOSE";

string button_JPY_basket = "JPY_BASKET"; 
string button_JPY_basket_buy = "JPY_BASKET_BUY";
string button_JPY_basket_sell = "JPY_BASKET_SELL";
string button_JPY_basket_close = "JPY_BASKET_CLOSE";
 
string DefaultPairs[] = {"AUDCAD","AUDCHF","AUDJPY","AUDNZD","AUDUSD","CADCHF","CADJPY","CHFJPY","EURAUD","EURCAD","EURCHF","EURGBP","EURJPY","EURNZD","EURUSD","GBPAUD","GBPCAD","GBPCHF","GBPJPY","GBPNZD","GBPUSD","NZDCAD","NZDCHF","NZDJPY","NZDUSD","USDCAD","USDCHF","USDJPY"};
string TradePairs[];
string curr[8] = {"USD","EUR","GBP","JPY","AUD","NZD","CAD","CHF"};
string Periode[9]={"M1","M5","M15","M30","H1","H4","D1","W1","MN1"};
string EUR[7] = {"EURAUD","EURCAD","EURCHF","EURGBP","EURJPY","EURNZD","EURUSD"};
string GBP[6] = {"GBPAUD","GBPCAD","GBPCHF","GBPJPY","GBPNZD","GBPUSD"};
string GBP_R[1] = {"EURGBP"};
string CHF[1] = {"CHFJPY"};
string CHF_R[6] = {"AUDCHF","CADCHF","EURCHF","GBPCHF","NZDCHF","USDCHF"};
string USD[3] = {"USDCAD","USDCHF","USDJPY"};
string USD_R[4] = {"AUDUSD","EURUSD","GBPUSD","NZDUSD"};
string CAD[2] = {"CADCHF","CADJPY"};
string CAD_R[5] = {"AUDCAD","EURCAD","GBPCAD","NZDCAD","USDCAD"};
string NZD[4] = {"NZDCAD","NZDCHF","NZDJPY","NZDUSD"};
string NZD_R[3] = {"AUDNZD","EURNZD","GBPNZD"};
string AUD[5] = {"AUDCAD","AUDCHF","AUDJPY","AUDNZD","AUDUSD"};
string AUD_R[2] = {"EURAUD","GBPAUD"};
string JPY_R[7] = {"AUDJPY","CADJPY","CHFJPY","EURJPY","GBPJPY","NZDJPY","USDJPY"};

string   _font="Consolas";

struct pairinf {
   double PairPip;
   int pipsfactor;
   double Pips;
   double PipsSig;
   double Pipsprev;
   double Spread;
   double point;
   int lastSignal;
   int    base;
   int    quote;   
}; pairinf pairinfo[];

#define NONE 0
#define DOWN -1
#define UP 1

#define NOTHING 0
#define BUY 1
#define SELL 2

struct Pair 
{
   string symbol1;    
   double pips1;    
   double ratio1;     
   double calc1;   
   double open1;   
   double close1;   
   double point1;   
   double hi1;   
   double lo1;   
   double ask1;   
   double bid1;   
   int pipsfactor1;   
   double spread1;   
   double range1;   
 
};
struct signal { 
   string symbol;
   double range;
   double range1;
   double ratio;
   double ratio1;
   double bidratio;
   double fact;
   double strength;
   double strength_old;
   double strength1;
   double strength2;
   double calc;
   double strength3;
   double strength4;
   double strength5;
   double strength6;
   double strength7;
   double strength8;
   double strength_Gap;
   double hi;
   double lo;
   double prevratio;   
   double prevbid;   
   int    shift;
   double open;
   double close;
   double bid;
   double point;   
   double Signalperc; double Signalperc1;  
   double SigRatio;
   double SigRelStr;
   double SigBSRatio;    
   double SigCRS;
   double SigGap;
   double SigGapPrev;
   double PrevGap;
   double SigRatioPrev;
//FIBO
   string Signal_Direction;
   string Signal_DirectionB;
   string Signal_DirectionC;
   double FibonacciDaily;
   string Signal_Fibonacci;
   double FibonacciDailyB;
   string Signal_FibonacciB;
   double FibonacciDailyC;
   string Signal_FibonacciC;
   int Dir0;
   int Dir1;
   int Dir2;
   int Dir3;
   int Dir4;
   int Dir5;
   int Dir6;
   int Dir7;
   int Dir8;
   //string Signal_Direction;
   double Stochastic1A;
   double Stochastic1B;
   double Stochastic2A;
   double Stochastic2B;
   double Stochastic3A;
   double Stochastic3B;
   string Signal_Stochastic;
   double MACD;
   string Signal_MACD;
   double CCIA;
   string Signal_CCIA;
   double CCIB;
   string Signal_CCIB;
   double CCIC;
   string Signal_CCIC;
   double RSI;
   double SigRSI;
   double Signalrsi;
   double highRatio;
   double lowRatio;
   double Signalcc;
   double Signalm1;  double Signalm5;  double Signalm15;  
   double Signalmaup;
   double Signalmadn;
//SIGNAL USD   
   double prevSignalusd;   double Signalusd;   double Signalm1USD;   double Signalm5USD;   double Signalm15USD;   double Signalm30USD;
   double Signalh1USD;   double Signalh4USD;   double Signald1USD;   double Signalw1USD;   double SignalmnUSD;
   double SignalpercUSD;
   //HI-LO ASK BID
  double ratio3;
  double high1;
  double low1;
  double ask1;
  double range2;
  //double bid;
  int    digit1;
  double high3;
  double low3;
  double open3;
  double close3;
  double bid3;
  double ask3;
  double point3;
  string digit3;
  double range3;
  double bidratio3;  
  //HI-LO ASK BID
  double ADX0;
  double ADX1;
  double ADX2;
  double ADX3;
  string Signal_ADX;
  double ATR0;
  double ATR1;
  string Signal_ATR;
  double Williams_R0;
  double Williams_R1;
  string Signal_Williams;
  double RSI_A;
  double RSI_B;
  double RSI_C;
  string Signal_RSIA;
  string Signal_RSIB;
  string Signal_RSIC;
  //SIGNAL ST
   string symbol1;   string symbol2;   string symbol3;   string symbol4;   string symbol5;   string symbol6;   string symbol7;   string symbol8;   
   /*double ratio1;*/   double ratio2;   /*double ratio3;*/   double ratio4;   double ratio5;   double ratio6;   double ratio7;   double ratio8;
   double pips1;   double pips2;   double pips3;   double pips4;   double pips5;   double pips6;   double pips7;   double pips8;
//SIGNAL ST
  //MACD
  double SignalMACDup01;
  double SignalMACDdn01;
    //CANDLE DIRECTION
  double SignalCDm1;
  double SignalCDm5;
  double SignalCDm15;
  double SignalCDm30;
  double SignalCDh1;
  double SignalCDh4;
  double SignalCDd1;
  double SignalCDw1;
  double SignaldirupM1; double SignaldirupM5; double SignaldirupM15; double SignaldirupM30; double SignaldirupH1; double SignaldirupH4; double SignaldirupD1; double SignaldirupW1;
  double SignaldirdnM1; double SignaldirdnM5; double SignaldirdnM15; double SignaldirdnM30; double SignaldirdnH1; double SignaldirdnH4; double SignaldirdnD1; double SignaldirdnW1;
  //CANDLE
  //adr dir
  double ADR68;
  double ADR32;
  //adr dir     
}; signal signals[];

struct currency 
  {
   string            curr;
   double            strength;
   double            prevstrength;
   double            crs;
   int               sync;
   datetime          lastbar;
  }
; currency currencies[8];

double totalbuystrength,totalsellstrength;
double Signalm1[28],Signalm5[28],Signalm15[28],Signalm30[28],Signalh1[28],Signalh4[28],Signald1[28],Signalw1[28],Signalmn[28],Signalusd[28];
color ProfitColor,ProfitColor1,ProfitColor2,ProfitColor3,PipsColor,LotColor,LotColor1,OrdColor,OrdColor1;
color Color,Color1,Color2,Color3,Color4,Color5,Color6,Color7,Color8,Color9,Color10,Color11,Color12;

color BackGrnCol =C'20,20,20';
color LineColor=clrBlack;
color TextColor=clrBlack;

struct adrval {
   double adr;
   double adr1;
   double adr5;
   double adr10;
   double adr20;
}; adrval adrvalues[];

double totalprofit,totallots,totalpips;

datetime s1start,s2start,s3start;
datetime s1end,s2end,s3end;

string comment;
int strper = PERIOD_W1;
int profitbaskets = 0;
int lossbaskets = 0;
int ticket;
int    orders  = 0;
double blots[28],slots[28],bprofit[28],sprofit[28],tprofit[28],bpos[28],spos[28],bpips[28],spips[28],tpips[28],tmp_bpips[28],tmp_spips[28],tmp_tpips[28];
Pair list[];
bool CloseAll;
string postfix=StringSubstr(Symbol(),6,10);
int   symb_cnt=0;
int period1[]= {240,1440,10080};
double factor;
int labelcolor,labelcolor1,labelcolor2=clrNONE,labelcolor3,labelcolor4,labelcolor5,labelcolor6,labelcolor7,labelcolor8,labelcolor9,labelcolor10,labelcolor11; 
int labelcolorUSD,labelcolor1USD,labelcolor2USD=clrNONE,labelcolor3USD,labelcolor4USD,labelcolor5USD,labelcolor6USD,labelcolor7USD,labelcolor8USD,labelcolor9USD,labelcolor10USD,labelcolor11USD; 
 
double GetBalanceSymbol,SymbolMaxDD,SymbolMaxHi;
double PercentFloatingSymbol=0;
double PercentMaxDDSymbol=0;
datetime newday=0;
datetime newm1=0; 
bool   Accending=true;
/* HP */
int localday = 99;
bool s1active = false;
bool s2active = false;
bool s3active = false;
MqlDateTime sess;
string strspl[];
double currentlock = 0.0;
bool trailstarted = false;
double lockdistance = 0.0;
int totaltrades = 0;
int maxtotaltrades=0;
double stoploss;
double takeprofit;
double currstrength[8];
double prevstrength[8];
//string Sig[28],Sell;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {   
//--- indicator buffers mapping      
   ChartColorSet(CHART_COLOR_BACKGROUND,clrBlack);
   ChartColorSet(CHART_COLOR_FOREGROUND,clrWhite);
   ChartColorSet(CHART_COLOR_GRID,clrNONE);
   ChartColorSet(CHART_COLOR_VOLUME,clrNONE);
   ChartColorSet(CHART_COLOR_CHART_UP,clrNONE);
   ChartColorSet(CHART_COLOR_CHART_DOWN,clrNONE);
   ChartColorSet(CHART_COLOR_CHART_LINE,clrNONE);
   ChartColorSet(CHART_COLOR_CANDLE_BULL,clrNONE);
   ChartColorSet(CHART_COLOR_CANDLE_BEAR,clrNONE);
   ChartColorSet(CHART_COLOR_BID,clrNONE);
   ChartColorSet(CHART_COLOR_ASK,clrNONE);
   ChartColorSet(CHART_COLOR_LAST,clrNONE);
   ChartColorSet(CHART_COLOR_STOP_LEVEL,clrNONE);
   ChartModeSet(CHART_LINE);
//---

//--- indicator buffers mapping

  string s;
  string name;
    s = masterPreamble; //_symbolPair;
    //s = Symbol();
    for (int i = ObjectsTotal() - 1; i >= 0; i--)
    {
        name = ObjectName(i);
        if (StringSubstr(name, 0, StringLen(s)) == s)
        {
            ObjectDelete(name);
        }
    }                  
    if (UseDefaultPairs == true)
      ArrayCopy(TradePairs,DefaultPairs);
    else
      StringSplit(OwnPairs,',',TradePairs);
   
  for (int i=0;i<8;i++)
      currencies[i].curr = curr[i]; 
   
   if (ArraySize(TradePairs) <= 0) {
      Print("No pairs to trade");
      return(INIT_FAILED);
   }
   
   ArrayResize(adrvalues,ArraySize(TradePairs));
   ArrayResize(signals,ArraySize(TradePairs));
   ArrayResize(pairinfo,ArraySize(TradePairs));
          
    for(int i=0;i<ArraySize(TradePairs);i++){
    TradePairs[i]=TradePairs[i]+postfix;    

     pairinfo[i].base = StringSubstr(TradePairs[i],0,3);
     pairinfo[i].quote = StringSubstr(TradePairs[i],3,0);
   
      if (MarketInfo(TradePairs[i] ,MODE_DIGITS) == 4 || MarketInfo(TradePairs[i] ,MODE_DIGITS) == 2) {
         pairinfo[i].PairPip = MarketInfo(TradePairs[i] ,MODE_POINT);
         pairinfo[i].pipsfactor = 1;
      } else { 
         pairinfo[i].PairPip = MarketInfo(TradePairs[i] ,MODE_POINT)*10;
         pairinfo[i].pipsfactor = 10;
      }
//--------------------------------------


      
//--------------------------------------
   if (ShowRSICCIMACD) {  SetPanel("Panel",0,x_axis+600+x_axis,y_axis+13+y_axis,130,150,clrNONE,clrNONE,1);  }
   if (ShowPowerMeter1) {  SetPanel("Panel1",0,x_axis+600+x_axis,y_axis+13+y_axis,130,150,clrNONE,clrNONE,1);  } 
     
         SetPanel("BarSupMeter",0,x_axis+1,y_axis-135,1305,670,clrDarkSlateGray,C'61,61,61',1);                
         SetPanel("Bar",0,x_axis+8,y_axis-50,1293,370,C'30,30,30',C'61,61,61',1);//painel fundo cinza
         SetPanel("Panel",0,x_axis+1020,y_axis+390,280,140,C'30,30,30',C'61,61,61',1);//PAINEL FUNDO PRETO LUCRO
         SetPanel("BottPanel",0,x_axis+10,y_axis+320,570,210,C'30,30,30',clrWhite,1);//836
         
         SetPanel("Spread"+IntegerToString(i),0,x_axis+160,(i*11)+y_axis-36,20,11,clrBlack,C'61,61,61',1);
         SetPanel("Pips"+IntegerToString(i),0,x_axis+180,(i*11)+y_axis-36,27,11,clrBlack,C'61,61,61',1);
         SetPanel("Adr"+IntegerToString(i),0,x_axis+207,(i*11)+y_axis-36,18,11,clrBlack,C'61,61,61',1);
         
         SetPanel("BidRatio"+IntegerToString(i),0,x_axis+280,(i*11)+y_axis-36,40,11,clrBlack,C'61,61,61',1);
         SetPanel("BSRatio"+IntegerToString(i),0,x_axis+320,(i*11)+y_axis-36,20,11,clrBlack,C'61,61,61',1);
         SetPanel("RelStr"+IntegerToString(i),0,x_axis+340,(i*11)+y_axis-36,10,11,clrBlack,C'61,61,61',1);
         SetPanel("PrevGAP"+IntegerToString(i),0,x_axis+350,(i*11)+y_axis-36,20,11,clrBlack,C'61,61,61',1);
         SetPanel("GAP123"+IntegerToString(i),0,x_axis+370,(i*11)+y_axis-36,30,11,clrBlack,C'61,61,61',1);         
         SetPanel("HM1"+IntegerToString(i),0,x_axis+985,(i*11)+y_axis-36,33,13,BackGrnCol,C'61,61,61',1);       
         SetPanel("HM2"+IntegerToString(i),0,x_axis+1018,(i*11)+y_axis-36,33,13,BackGrnCol,C'61,61,61',1);
         //SetPanel("HM2"+IntegerToString(i),0,(i*46)+x_axis+9,y_axis+307,50,12,BackGrnCol,C'61,61,61',1);       
         SetPanel("TP",0,x_axis+1245,y_axis-53,55,17,Black,White,1);//LUCRO
         SetPanel("TP1",0,x_axis+815,y_axis-68,45,17,Black,White,1);//10
         SetPanel("TP6",0,x_axis+860,y_axis-68,92,17,Black,White,1);//55
         SetPanel("TP2",0,x_axis+952,y_axis-68,130,17,Black,White,1);//147
         SetPanel("TP3",0,x_axis+1082,y_axis-68,120,17,Black,White,1);//277
         SetPanel("TP4",0,x_axis+1202,y_axis-68,60,17,Black,White,1);//397
         SetPanel("TP5",0,x_axis+1260,y_axis-68,20,17,Black,White,1);//455
         SetPanel("TP7",0,x_axis+1280,y_axis-68,20,17,Black,White,1);//475
         //SetPanel("TP8",0,x_axis+1051,y_axis-70,22,17,Black,White,1);
         //SetPanel("TP9",0,x_axis+1073,y_axis-70,22,17,Black,White,1);        
         SetPanel("TP10",0,x_axis+10,y_axis-105,1290,40,Black,White,1);        

        // SetPanel("A2"+IntegerToString(i),0,x_axis+1175,(i*11)+y_axis-32,125,11,C'30,30,30',C'61,61,61',1);//painel lotes          
       
         //SetText("Pr1"+IntegerToString(i),StringSubstr(TradePairs[i],0,6),x_axis+1105,(i*10)+y_axis-34,clrWhite,8);
         SetText("Spr1"+IntegerToString(i),0,x_axis+160,(i*11)+y_axis-36,Orange,7);
         SetText("Pp1"+IntegerToString(i),0,x_axis+180,(i*11)+y_axis-36,PipsColor,7);
         SetText("S1"+IntegerToString(i),0,x_axis+207,(i*11)+y_axis-36,Yellow,7);
         
         ///SetPanel("PointRange"+IntegerToString(i),0,x_axis+787,(i*11)+y_axis-32,15,11,C'20,20,20',C'20,20,20',0);
         //SetPanel("PanelPointRange3"+(string)i,0,x_axis+790,(i*11)+y_axis-32,10,11,C'30,30,30',C'61,61,61',1); 
         //SetText("Textpointrange3"+(string)i,"0",x_axis+790,(i*11)+y_axis-32,clrWhite,8);
         ///SetPanel("High"+IntegerToString(i),0,x_axis+801,(i*11)+y_axis-32,30,11,C'20,20,20',C'20,20,20',0); 
         //SetPanel("Panelhigh3"+(string)i,0,x_axis+810,(i*11)+y_axis-32,30,11,C'30,30,30',C'61,61,61',1);    
         //SetText("Texthigh3"+(string)i,"0",x_axis+810,(i*11)+y_axis-33,clrWhite,6);
         ///SetPanel("Ask"+IntegerToString(i),0,x_axis+830,(i*11)+y_axis-32,30,11,C'20,20,20',C'20,20,20',0);        
         //SetPanel("PanelAsk3"+(string)i,0,x_axis+840,(i*11)+y_axis-32,30,11,C'30,30,30',C'61,61,61',1);    
         //SetText("TextAsk3"+(string)i,"0",x_axis+840,(i*11)+y_axis-33,clrWhite,6);
         ///SetPanel("Bid"+IntegerToString(i),0,x_axis+859,(i*11)+y_axis-32,30,11,C'20,20,20',C'20,20,20',0);
         //SetPanel("PanelBid3"+(string)i,0,x_axis+870,(i*11)+y_axis-32,30,11,C'30,30,30',C'61,61,61',1);    
         //SetText("TextBid3"+(string)i,"0",x_axis+870,(i*11)+y_axis-33,clrWhite,6);
         ///SetPanel("Low"+IntegerToString(i),0,x_axis+888,(i*11)+y_axis-32,30,11,C'20,20,20',C'20,20,20',0);
         //SetPanel("PanelLow3"+(string)i,0,x_axis+900,(i*11)+y_axis-32,30,11,C'30,30,30',C'61,61,61',1);    
         //SetText("TextLow3"+(string)i,"0",x_axis+900,(i*11)+y_axis-33,clrWhite,6);
         SetText("bLots"+IntegerToString(i),DoubleToStr(blots[i],2),x_axis+1155,(i*11)+y_axis-36,C'61,61,61',7);
         SetText("sLots"+IntegerToString(i),DoubleToStr(slots[i],2),x_axis+1175,(i*11)+y_axis-36,C'61,61,61',7);
         SetText("bPos"+IntegerToString(i),DoubleToStr(bpos[i],0),x_axis+1198,(i*11)+y_axis-36,C'61,61,61',7);
         SetText("sPos"+IntegerToString(i),DoubleToStr(spos[i],0),x_axis+1204,(i*11)+y_axis-36,C'61,61,61',7);
         SetPanel("Panelbprof"+(string)i,0,x_axis+1213,(i*11)+y_axis-36,26,11,C'30,30,30',C'61,61,61',1);    
         SetText("Textsbprof"+IntegerToString(i),"0",x_axis+1214,(i*11)+y_axis-36,clrDimGray,7);
         SetPanel("Panelsprof"+(string)i,0,x_axis+1242,(i*11)+y_axis-36,26,11,C'30,30,30',C'61,61,61',1);    
         SetText("Textsprof"+IntegerToString(i),"0",x_axis+1243,(i*11)+y_axis-36,clrDimGray,7);
         //SetText("TProf"+IntegerToString(i),DoubleToStr(MathAbs(bprofit[i]),2),x_axis+1210,(i*11)+y_axis-34,C'61,61,61',8);
         //SetText("SProf"+IntegerToString(i),DoubleToStr(MathAbs(sprofit[i]),2),x_axis+1240,(i*11)+y_axis-34,C'61,61,61',8);
         SetText("TtlProf"+IntegerToString(i),DoubleToStr(MathAbs(tprofit[i]),2),x_axis+1270,(i*11)+y_axis-36,C'61,61,61',7);
         SetText("TotProf",DoubleToStr(MathAbs(totalprofit),2),x_axis+1255,y_axis-51,ProfitColor1,10);         
         SetText("Lowest","Lowest= "+DoubleToStr(SymbolMaxDD,2)+" ("+DoubleToStr(PercentMaxDDSymbol,2)+"%)",x_axis+955,y_axis-66,BearColor,8);
         SetText("Highest","Highest= "+DoubleToStr(SymbolMaxHi,2)+" ("+DoubleToStr(PercentFloatingSymbol,2)+"%)",x_axis+1085,y_axis-66,BullColor,8);
         SetText("Lock","Lock= "+DoubleToStr(currentlock,2),x_axis+1204,y_axis-66,BullColor,8);
         SetText("Won",IntegerToString(profitbaskets,2),x_axis+1264,y_axis-66,BullColor,8);
         SetText("Lost",IntegerToString(lossbaskets,2),x_axis+1284,y_axis-66,BearColor,8);
         
         //SetButton(IntegerToString(i)+"Pair1",StringSubstr(TradePairs[i],0,6),35,10,x_axis+107,(i*10)+y_axis,clrSilver,clrBlack,5);
     
  for (int j=0;j<8;j++){
  SetPanel("C"+(string)i+"D"+(string)j,0,x_axis+10+(j*11),(i*11)+y_axis-36,13,13,C'30,30,30',C'61,61,61',1);//1010    
  //SetPanel("C"+(string)i+"D"+(string)j,0,(i*46)+x_axis+10+(j*6),y_axis+395,4,13,C'30,30,30',C'61,61,61',1);    
  SetPanel("PanelFibonacciDaily"+(string)i,0,x_axis+465,(i*11)+y_axis-36,30,11,C'30,30,30',C'61,61,61',1);    
  SetText("TextFibonacciDaily"+(string)i,"0.0 %",x_axis+467,(i*11)+y_axis-36,clrWhite,7);  
  SetPanel("PanelFibonacciDailyB"+(string)i,0,x_axis+495,(i*11)+y_axis-36,30,11,C'30,30,30',C'61,61,61',1);    
  SetText("TextFibonacciDailyB"+(string)i,"0.0 %",x_axis+497,(i*11)+y_axis-36,clrWhite,7);  
  SetPanel("PanelFibonacciDailyC"+(string)i,0,x_axis+525,(i*11)+y_axis-36,30,11,C'30,30,30',C'61,61,61',1);    
  SetText("TextFibonacciDailyC"+(string)i,"0.0 %",x_axis+527,(i*11)+y_axis-36,clrWhite,7);  
   
  SetPanel("PanelStochastic1A"+(string)i,0,x_axis+555,(i*11)+y_axis-36,30,11,C'30,30,30',C'61,61,61',1);    
  SetText("TextStochastic1A"+(string)i,"0.0 %",x_axis+555,(i*11)+y_axis-36,clrWhite,7);
  SetPanel("PanelStochastic2A"+(string)i,0,x_axis+585,(i*11)+y_axis-36,30,11,C'30,30,30',C'61,61,61',1);    
  SetText("TextStochastic2A"+(string)i,"0.0 %",x_axis+585,(i*11)+y_axis-36,clrWhite,7);
  SetPanel("PanelStochastic3A"+(string)i,0,x_axis+615,(i*11)+y_axis-36,30,11,C'30,30,30',C'61,61,61',1);    
  SetText("TextStochastic3A"+(string)i,"0.0 %",x_axis+615,(i*11)+y_axis-36,clrWhite,7);
  
  SetPanel("RSI"+(string)(i),0,x_axis+400,(i*11)+y_axis-36,35,11,clrBlack,C'61,61,61',1);   
  //SetText("rsi"+(string)[i],"0.0 %", x_axis+554,(i*12)+y_axis+5,clrBlack,C'61,61,61',1);  
  SetText("rsi"+(string)i,"0.0 %",x_axis+405,(i*11)+y_axis-36,clrWhite,7);
  
  ///SetPanel("CCI"+(string)(i),0,x_axis+435,(i*11)+y_axis-34,25,11,clrBlack,C'61,61,61',1);   
  //SetText("TextCCI"+(string)i,"0.0",x_axis+425,(i*11)+y_axis-34,clrWhite,7);
  ///SetPanel("MACD"+(string)(i),0,x_axis+460,(i*11)+y_axis-34,30,11,clrBlack,C'61,61,61',1); 
  
  SetPanel("PanelADX"+(string)i,0,x_axis+645,(i*11)+y_axis-36,30,11,C'30,30,30',C'61,61,61',1);    
  SetText("TextADX"+(string)i,"0.0 %",x_axis+646,(i*11)+y_axis-36,clrWhite,7);
      
  SetPanel("PanelATR"+(string)i,0,x_axis+675,(i*11)+y_axis-36,35,11,C'30,30,30',C'61,61,61',1);    
  SetText("TextATR"+(string)i,"0.0",x_axis+676,(i*11)+y_axis-36,clrWhite,7);
      
  SetPanel("PanelWilliams"+(string)i,0,x_axis+710,(i*11)+y_axis-36,40,11,C'30,30,30',C'61,61,61',1);    
  SetText("TextWilliams"+(string)i,"0.0",x_axis+711,(i*11)+y_axis-36,clrWhite,7);
  
  SetPanel("MM"+(string)(i),0,x_axis+750,(i*11)+y_axis-36,30,11,clrBlack,C'61,61,61',1);    
if (ShowRSICCIMACD) { 
  SetPanel("PanelRSIA"+(string)i,0,x_axis+780,(i*11)+y_axis-36,30,11,C'30,30,30',C'61,61,61',1);    
  SetText("TextRSIA"+(string)i,"0.0 %",x_axis+780,(i*11)+y_axis-36,clrWhite,7);
  SetPanel("PanelRSIB"+(string)i,0,x_axis+810,(i*11)+y_axis-36,30,11,C'30,30,30',C'61,61,61',1);    
  SetText("TextRSIB"+(string)i,"0.0 %",x_axis+810,(i*11)+y_axis-36,clrWhite,7);
  SetPanel("PanelRSIC"+(string)i,0,x_axis+840,(i*11)+y_axis-36,30,11,C'30,30,30',C'61,61,61',1);    
  SetText("TextRSIC"+(string)i,"0.0 %",x_axis+840,(i*11)+y_axis-36,clrWhite,7);
  
  SetPanel("PanelCCIA"+(string)i,0,x_axis+870,(i*11)+y_axis-36,30,11,C'30,30,30',C'61,61,61',1);    
  SetText("TextCCIA"+(string)i,"0.0",x_axis+870,(i*11)+y_axis-36,clrWhite,7);
  SetPanel("PanelCCIB"+(string)i,0,x_axis+900,(i*11)+y_axis-36,30,11,C'30,30,30',C'61,61,61',1);    
  SetText("TextCCIB"+(string)i,"0.0",x_axis+900,(i*11)+y_axis-36,clrWhite,7);
  SetPanel("PanelCCIC"+(string)i,0,x_axis+930,(i*11)+y_axis-36,30,11,C'30,30,30',C'61,61,61',1);    
  SetText("TextCCIC"+(string)i,"0.0",x_axis+930,(i*11)+y_axis-36,clrWhite,7);
  
  SetPanel("PanelMACD"+(string)i,0,x_axis+960,(i*11)+y_axis-36,47,11,C'30,30,30',C'61,61,61',1);    
  SetText("TextMACD"+(string)i,"0.0 %",x_axis+962,(i*11)+y_axis-36,clrWhite,7);    
}
 } //BOTAO LOTES
  //panel box for Auto Pending Orders 

  SetPanel("H_Inputs",0,a_axis-385,aa_axis-222,113,39,clrGoldenrod,White,1);//inputs box for HARE LOTS,SL,TP
  //SetText("H_In1","LOTE/STOP por PIP",a_axis-385,aa_axis-222,Black,7);
  SetText("LotSize","LotSize",a_axis-384,aa_axis-222,White,8);//
  SetPanel("H_Lots_P",0,a_axis-339,aa_axis-221,38,11,clrBlack,Black,1);
  Create_Button(button_increase_lot,"+",13,13,z_axis-355,aa_axis-222,clrGainsboro,clrWhite);
  Create_Button(button_decrease_lot,"-",13,13,z_axis-299,aa_axis-222,clrGainsboro,clrWhite);
  //Create_Button(button_H3,"+",12,12,z_axis+641,aa_axis+34,clrGainsboro,clrWhite);
  //Create_Button(button_H4,"-",12,12,z_axis+655,aa_axis+34,clrGainsboro,clrWhite);
  //Create_Button(button_H5,"+",12,12,z_axis+641,aa_axis+48,clrGainsboro,clrWhite);
  //Create_Button(button_H6,"-",12,12,z_axis+655,aa_axis+48,clrGainsboro,clrWhite);         
  //Create_Button(button_H7,"+",12,12,z_axis+641,aa_axis+62,clrGainsboro,clrWhite);
  //Create_Button(button_H8,"-",12,12,z_axis+655,aa_axis+62,clrGainsboro,clrWhite);
  SetText("Piptp","TP",a_axis-383,aa_axis-210,Black,8);
  SetPanel("H_TP_P",0,a_axis-340,aa_axis-210,40,14,clrBlack,White,1);
  Create_Button(button_increase_Piptp,"+",13,13,z_axis-355,aa_axis-210,clrGainsboro,clrWhite);
  Create_Button(button_decrease_Piptp,"-",13,13,z_axis-299,aa_axis-210,clrGainsboro,clrWhite);
  SetText("Pipsl","SL",a_axis-384,aa_axis-197,Black,8);
  SetPanel("H_SL_P",0,a_axis-340,aa_axis-197,40,14,clrBlack,White,1);
  Create_Button(button_increase_Pipsl,"+",13,13,z_axis-355,aa_axis-197,clrGainsboro,clrWhite);
  Create_Button(button_decrease_Pipsl,"-",13,13,z_axis-299,aa_axis-197,clrGainsboro,clrWhite);
  //SetText("H_In5",DoubleToStr(H_Lot,2),a_axis+610,aa_axis+20,clrWhite,8);         
  SetText("Piptp",IntegerToString(H_TP),a_axis-383,aa_axis-210,clrWhite,8);
  SetText("Pipsl",IntegerToString(H_SL),a_axis-384,aa_axis-197,clrWhite,8);
  
  //panel box for Basket Trades & Single Trades        
  SetPanel("S_BAS_Inputs",0,a_axis-272,aa_axis-222,113,39,clrGoldenrod,White,1);//inputs box for SINGLE and BASKET LOTS,SL,TP
  //SetText("S_BAS_In1","STOP por ADR",a_axis-272,aa_axis-222,Black,7);
  //SetText("LotSize1","Lot",a_axis+576,aa_axis+342,White,8);
  //SetPanel("S_BAS_Lots_P",0,a_axis+623,aa_axis+341,40,14,clrBlack,White,1);
  //Create_Button(button_SB1,"+",13,13,z_axis+627,aa_axis+356,clrGainsboro,clrWhite);
  //Create_Button(button_SB2,"-",13,13,z_axis+645,aa_axis+356,clrGainsboro,clrWhite);
  //Create_Button(button_SB3,"+",12,12,z_axis+641,aa_axis+359,clrGainsboro,clrWhite);
  //Create_Button(button_SB4,"-",12,12,z_axis+655,aa_axis+359,clrGainsboro,clrWhite);
  //Create_Button(button_SB5,"+",12,12,z_axis+641,aa_axis+373,clrGainsboro,clrWhite);
  //Create_Button(button_SB6,"-",12,12,z_axis+655,aa_axis+373,clrGainsboro,clrWhite);         
  //Create_Button(button_SB7,"+",12,12,z_axis+641,aa_axis+387,clrGainsboro,clrWhite);
  //Create_Button(button_SB8,"-",12,12,z_axis+655,aa_axis+387,clrGainsboro,clrWhite);
  SetText("Adr1tp","TP",a_axis-270,aa_axis-210,Black,8);//
  SetPanel("S_BAS_TP_P",0,a_axis-235,aa_axis-210,40,14,clrBlack,White,1);
  Create_Button(button_increase_Adr1tp,"+",13,13,z_axis-250,aa_axis-210,clrGainsboro,clrWhite);
  Create_Button(button_decrease_Adr1tp,"-",13,13,z_axis-194,aa_axis-210,clrGainsboro,clrWhite);
  SetText("Adr1sl","SL",a_axis-270,aa_axis-197,Black,8);//
  SetPanel("S_BS_SL_P",0,a_axis-235,aa_axis-197,40,14,clrBlack,White,1);
  Create_Button(button_increase_Adr1sl,"+",13,13,z_axis-250,aa_axis-197,clrGainsboro,clrWhite);
  Create_Button(button_decrease_Adr1sl,"-",13,13,z_axis-194,aa_axis-197,clrGainsboro,clrWhite);
  //SetText("S_BAS_In5",DoubleToStr(S_BS_Lot,2),a_axis+610,aa_axis+345,clrWhite,8);         
  SetText("Adr1tp",IntegerToString(S_BS_TP),a_axis-270,aa_axis-210,clrWhite,8);//
  SetText("Adr1sl",IntegerToString(S_BS_SL),a_axis-270,aa_axis-197,clrWhite,8);//
  //   
  //SetPanel("TP1",0,x_axis+122,y_axis+288,125,20,Black,White,1); //these move the "Monitoring Trade" boxes
  //SetPanel("TP2",0,x_axis+122,y_axis+307,125,20,Black,White,1);
  //SetPanel("TP3",0,x_axis+122,y_axis+326,125,20,Black,White,1);
//BOTAO LOTES 
        
  //Create_Button(IntegerToString(i)+"Pair",StringSubstr(TradePairs[i],0,6),50 ,11,x_axis+10 ,(i*10)+y_axis-32,C'35,35,35',clrWhite);
  SetButton(IntegerToString(i)+"Pair",StringSubstr(TradePairs[i],0,6),50,12,x_axis+110,(i*11)+y_axis-37,clrSilver,clrBlack,7);
  ///SetButton(IntegerToString(i)+"PairPerc",StringSubstr(TradePairs[i],0,6),48,12,(i*46)+x_axis+10,y_axis+295,clrSilver,clrBlack,7);
  SetButton(IntegerToString(i)+"Pair2",StringSubstr(TradePairs[i],0,6),50,12,x_axis+1100,(i*11)+y_axis-36,clrSilver,clrBlack,7);

  Create_Button(i+"BUY","B",15 ,12,x_axis+1053,(i*11)+y_axis-36,C'35,35,35',clrLime);           
  Create_Button(i+"SELL","S",15 ,12,x_axis+1068 ,(i*11)+y_axis-36,C'35,35,35',clrRed);
  Create_Button(i+"CLOSE","C",15 ,12,x_axis+1083,(i*11)+y_axis-36,C'35,35,35',clrOrange);
  //Create_Button(i+"Hold","~",30 ,10,x_axis+1043,(i*10)+y_axis-32,C'35,35,35',clrAqua);

   }
   
   //BASKET
  SetText("TPr","B TP =$ "+DoubleToString(Basket_Target,0),x_axis+924,y_axis-91,Yellow,7);
  SetText("SL","B SL =$ -"+DoubleToString(Basket_StopLoss,0),x_axis+1000,y_axis-91,Yellow,7);
  //BASKET                
  //SetText("Symbol","Spr Pip  ADR STR BdR BSR RStr Prev",x_axis+180,y_axis-45,White,8);
  //SetText("Sy","Gap        HeatMap",x_axis+335,y_axis-45,White,8);                
  //SetText("Trades","Buy Sell Buy Sell Buy Sell",x_axis+1120,y_axis-45,White,8);
  //SetText("TTr","Lots           Orders",x_axis+860,y_axis-54,White,8);
  
   

    //Basket Trades
   int basket_x = x_axis + 900;
   int basket_y = y_axis + 312;
   int i = 0;
   
/*   //AUD
   Create_Button(button_AUD_basket,"AUD",50 ,18,basket_x+i ,basket_y+6,C'35,35,35',clrWhite);
   Create_Button(button_AUD_basket_buy,"BUY",50 ,18,basket_x+i ,basket_y+24,C'35,35,35',clrLime);
   Create_Button(button_AUD_basket_sell,"SELL",50 ,18,basket_x+i ,basket_y+42,C'35,35,35',clrRed);
   Create_Button(button_AUD_basket_close,"CLOSE",50 ,18,basket_x+i ,basket_y+60,C'35,35,35',clrOrange);
   //CAD
   i += 50;
   Create_Button(button_CAD_basket,"CAD",50 ,18,basket_x+i ,basket_y+6,C'35,35,35',clrWhite);
   Create_Button(button_CAD_basket_buy,"BUY",50 ,18,basket_x+i ,basket_y+24,C'35,35,35',clrLime);
   Create_Button(button_CAD_basket_sell,"SELL",50 ,18,basket_x+i ,basket_y+42,C'35,35,35',clrRed);
   Create_Button(button_CAD_basket_close,"CLOSE",50 ,18,basket_x+i ,basket_y+60,C'35,35,35',clrOrange);
   //CHF
   i += 50;
   Create_Button(button_CHF_basket,"CHF",50 ,18,basket_x+i ,basket_y+6,C'35,35,35',clrWhite);
   Create_Button(button_CHF_basket_buy,"BUY",50 ,18,basket_x+i ,basket_y+24,C'35,35,35',clrLime);
   Create_Button(button_CHF_basket_sell,"SELL",50 ,18,basket_x+i ,basket_y+42,C'35,35,35',clrRed);
   Create_Button(button_CHF_basket_close,"CLOSE",50 ,18,basket_x+i ,basket_y+60,C'35,35,35',clrOrange);
   //EUR
   i += 50;
   Create_Button(button_EUR_basket,"EUR",50 ,18,basket_x+i ,basket_y+6,C'35,35,35',clrWhite);
   Create_Button(button_EUR_basket_buy,"BUY",50 ,18,basket_x+i ,basket_y+24,C'35,35,35',clrLime);
   Create_Button(button_EUR_basket_sell,"SELL",50 ,18,basket_x+i ,basket_y+42,C'35,35,35',clrRed);
   Create_Button(button_EUR_basket_close,"CLOSE",50 ,18,basket_x+i ,basket_y+60,C'35,35,35',clrOrange);
   //GBP
   i += 50;
   Create_Button(button_GBP_basket,"GBP",50 ,18,basket_x+i ,basket_y+6,C'35,35,35',clrWhite);
   Create_Button(button_GBP_basket_buy,"BUY",50 ,18,basket_x+i ,basket_y+24,C'35,35,35',clrLime);
   Create_Button(button_GBP_basket_sell,"SELL",50 ,18,basket_x+i ,basket_y+42,C'35,35,35',clrRed);
   Create_Button(button_GBP_basket_close,"CLOSE",50 ,18,basket_x+i ,basket_y+60,C'35,35,35',clrOrange);
   //JPY
   i += 50;
   Create_Button(button_JPY_basket,"JPY",50 ,18,basket_x+i ,basket_y+6,C'35,35,35',clrWhite);
   Create_Button(button_JPY_basket_buy,"BUY",50 ,18,basket_x+i ,basket_y+24,C'35,35,35',clrLime);
   Create_Button(button_JPY_basket_sell,"SELL",50 ,18,basket_x+i ,basket_y+42,C'35,35,35',clrRed);
   Create_Button(button_JPY_basket_close,"CLOSE",50 ,18,basket_x+i ,basket_y+60,C'35,35,35',clrOrange);
   //NZD
   i += 50;
   Create_Button(button_NZD_basket,"NZD",50 ,18,basket_x+i ,basket_y+6,C'35,35,35',clrWhite);
   Create_Button(button_NZD_basket_buy,"BUY",50 ,18,basket_x+i ,basket_y+24,C'35,35,35',clrLime);
   Create_Button(button_NZD_basket_sell,"SELL",50 ,18,basket_x+i ,basket_y+42,C'35,35,35',clrRed);
   Create_Button(button_NZD_basket_close,"CLOSE",50 ,18,basket_x+i ,basket_y+60,C'35,35,35',clrOrange);
   //USD
   i += 50;
   Create_Button(button_USD_basket,"USD",50 ,18,basket_x+i ,basket_y+6,C'35,35,35',clrWhite);
   Create_Button(button_USD_basket_buy,"BUY",50 ,18,basket_x+i ,basket_y+24,C'35,35,35',clrLime);
   Create_Button(button_USD_basket_sell,"SELL",50 ,18,basket_x+i ,basket_y+42,C'35,35,35',clrRed);
   Create_Button(button_USD_basket_close,"CLOSE",50 ,18,basket_x+i ,basket_y+60,C'35,35,35',clrOrange);
*/  
   Create_Button("button_autotrade","Manual",75 ,18,x_axis+925 ,y_axis-123,C'51,51,51',C'51,160,180');
   Create_Button(button_close_basket_All,"CLOSE ALL",75 ,18,x_axis+1000 ,basket_y-435,C'35,35,35',clrWhite);
   Create_Button(button_close_basket_Prof,"CLOSE PROFIT",75 ,18,x_axis+1075 ,basket_y-435,C'35,35,35',clrLime);
   Create_Button(button_close_basket_Loss,"CLOSE LOSS",75 ,18,x_axis+1150 ,basket_y-435,C'35,35,35',clrRed);
   Create_Button(button_reset_ea,"RESET EA",75 ,18,x_axis+1225 ,basket_y-435,C'35,35,35',clrOrange);
   
   Create_Button(button_increase_basket_tp,"+ BASKET / TP",74 ,12,x_axis+924 ,y_axis-105,C'35,35,35',clrLime);
   Create_Button(button_decrease_basket_tp,"- BASKET / TP",74 ,12,x_axis+924 ,y_axis-78,C'35,35,35',clrRed);
   Create_Button(button_increase_basket_sl,"+ BASKET / SL",74 ,12,x_axis+999 ,y_axis-105,C'35,35,35',clrLime);
   Create_Button(button_decrease_basket_sl,"- BASKET / SL",74 ,12,x_axis+999 ,y_axis-78,C'35,35,35',clrRed);  
  
   Create_Button("button_trigger_use_Pips","PIP",50 ,14,x_axis+110 ,y_axis-51,Black,White);//
   Create_Button("button_trigger_use_Strength","Strength",50 ,14,x_axis+160 ,y_axis-51,Black,White);
   Create_Button("button_trigger_use_bidratio","Bid Ratio",50 ,14,x_axis+210 ,y_axis-51,Black,White);
   Create_Button("button_trigger_use_buysellratio","B/S Ratio",50 ,14,x_axis+260 ,y_axis-51,Black,White);
   Create_Button("button_trigger_use_relstrength","R Strength",50 ,14,x_axis+310 ,y_axis-51,Black,White);
   Create_Button("button_trigger_use_PrevGap","PG",20 ,14,x_axis+360 ,y_axis-51,Black,White);
   Create_Button("button_trigger_use_gap","Gap",30 ,14,x_axis+380 ,y_axis-51,Black,White);
   Create_Button("trigger_use_RSI","RSI",30 ,14,x_axis+405 ,y_axis-51,Black,White);//
   ///Create_Button("trigger_CCI","CCI",25 ,14,x_axis+435 ,y_axis-51,Black,White);//
   ///Create_Button("trigger_MACD1","MACD",30 ,14,x_axis+460 ,y_axis-51,Black,White);//
   
   Create_Button("AI_Fibonacci","Fibo",30 ,14,x_axis+465 ,y_axis-51,Black,White);//
   Create_Button("AI_FibonacciB","Fibo",30 ,14,x_axis+495 ,y_axis-51,Black,White);//
   Create_Button("AI_FibonacciC","Fibo",30 ,14,x_axis+525 ,y_axis-51,Black,White);//
   
   Create_Button("AI_Stochastic1","Sto 1",30 ,14,x_axis+555 ,y_axis-51,Black,White);//
   Create_Button("AI_Stochastic2","Sto 2",30 ,14,x_axis+585 ,y_axis-51,Black,White);//
   Create_Button("AI_Stochastic3","Sto 3",30 ,14,x_axis+615 ,y_axis-51,Black,White);//
      
   Create_Button("AI_ADX","ADX",30 ,14,x_axis+645 ,y_axis-51,Black,White);
   Create_Button("AI_ATR","ATR",35 ,14,x_axis+675 ,y_axis-51,Black,White);
   Create_Button("AI_WILL","Williams",40 ,14,x_axis+710 ,y_axis-51,Black,White);
   Create_Button("trigger_Moving_Average1","MM",10 ,14,x_axis+750 ,y_axis-51,Black,White);//
   Create_Button("trigger_Moving_Average2","MM",10 ,14,x_axis+760 ,y_axis-51,Black,White);//
   Create_Button("trigger_Moving_Average3","MM",10 ,14,x_axis+770 ,y_axis-51,Black,White);// 
   if (ShowRSICCIMACD) {
   Create_Button("AI_RSI_A","RSIA",30 ,14,x_axis+780 ,y_axis-51,Black,White);//
   Create_Button("AI_RSI_B","RSIB",30 ,14,x_axis+810 ,y_axis-51,Black,White);//
   Create_Button("AI_RSI_C","RSIC",30 ,14,x_axis+840 ,y_axis-51,Black,White);//
   
   Create_Button("AI_CCIA","CCIA",30 ,14,x_axis+870 ,y_axis-51,Black,White);//
   Create_Button("AI_CCIB","CCIB",30 ,14,x_axis+900 ,y_axis-51,Black,White);//
   Create_Button("AI_CCIC","CCIC",30 ,14,x_axis+930 ,y_axis-51,Black,White);//
   Create_Button("AI_MACD","MACD",46 ,14,x_axis+960 ,y_axis-51,Black,White);//
   }
  //Create_Button("AI_Volume","Volume",70 ,14,x_axis+580 ,y_axis-51,Black,White);
  //Create_Button("AI_adx2","ADX2",70 ,14,x_axis+650 ,y_axis-51,Black,White);
  //Create_Button("AI_Pivot","Pivot",70 ,14,x_axis+720 ,y_axis-51,Black,White);
  //Create_Button("AI_Extreme","Extreme",70 ,14,x_axis+790 ,y_axis-51,Black,White);
  
  Create_Button("AI_Candle_Direction","Candle Dir",90 ,14,x_axis+10 ,y_axis-65,Black,White);//
  Create_Button("AI_Candle_Direction_TF1","1",11 ,14,x_axis+10 ,y_axis-51,Black,White);//
  Create_Button("AI_Candle_Direction_TF2","2",11 ,14,x_axis+21 ,y_axis-51,Black,White);//
  Create_Button("AI_Candle_Direction_TF3","3",11 ,14,x_axis+32 ,y_axis-51,Black,White);//
  Create_Button("AI_Candle_Direction_TF4","4",11 ,14,x_axis+43 ,y_axis-51,Black,White);//
  Create_Button("AI_Candle_Direction_TF5","5",11 ,14,x_axis+54 ,y_axis-51,Black,White);//
  Create_Button("AI_Candle_Direction_TF6","6",11 ,14,x_axis+65 ,y_axis-51,Black,White);//
  Create_Button("AI_Candle_Direction_TF7","7",11 ,14,x_axis+76 ,y_axis-51,Black,White);//
  Create_Button("AI_Candle_Direction_TF8","8",11 ,14,x_axis+87 ,y_axis-51,Black,White);//
  ///Create_Button("AI_Candle_Direction_TF9","9",11 ,14,x_axis+98 ,y_axis-51,Black,White);//        
  Create_Button("AI_AdrDir","A",11 ,14,x_axis+98 ,y_axis-51,Black,White);//

  Create_Button("button_trigger_Candle_DirectionM1","1",10 ,7,x_axis+980 ,y_axis-51,Black,White); 
  Create_Button("button_trigger_Candle_DirectionM5","2",10 ,7,x_axis+990 ,y_axis-51,Black,White);
  Create_Button("button_trigger_Candle_DirectionM15","3",10 ,7,x_axis+1000 ,y_axis-51,Black,White);
  Create_Button("button_trigger_Candle_DirectionM30","4",10 ,7,x_axis+1010 ,y_axis-51,Black,White);
  Create_Button("button_trigger_Candle_DirectionH1","5",10 ,7,x_axis+980 ,y_axis-44,Black,White);
  Create_Button("button_trigger_Candle_DirectionH4","6",10 ,7,x_axis+990 ,y_axis-44,Black,White);
  Create_Button("button_trigger_Candle_DirectionD1","7",10 ,7,x_axis+1000 ,y_axis-44,Black,White);
  Create_Button("button_trigger_Candle_DirectionW1","8",10 ,7,x_axis+1010 ,y_axis-44,Black,White);

       
  Create_Button("button_trigger_UseHeatMap1","HM",32 ,14,x_axis+1020 ,y_axis-51,Black,White);
  Create_Button("button_trigger_UseHeatMap2","HM2",32 ,14,x_axis+1052 ,y_axis-51,Black,White);

   newday = 0;
   newm1=0;

/*  HP  */
   localday = 99;
   s1active = false;
   s2active = false;
   s3active = false;
   trailstarted = false;

   if (MaxTotalTrades == 0)
      maxtotaltrades = ArraySize(TradePairs) * MaxTrades;
   else
      maxtotaltrades = MaxTotalTrades;
      
                
/*  HP  */
  //FIBO
  GetFibonacciDaily();GetFibonacciDailyB();GetFibonacciDailyC();GetStochastic();GetMACD();GetCCI();GetADX();GetATR();GetWilliams();GetRSI();
  //FIBO  
   EventSetTimer(1);
   //Extract the pairs traded by the user
   if(SymbolSource == USER_INPUT )
	{
		//Extract the pairs traded by the user
		NoOfPairs = StringFindCount(PairsToTrade,",")+1;
		ArrayResize(TradePair, NoOfPairs);
		string AddChar = StringSubstr(Symbol(),6,4);
		StrPairToStringArray(PairsToTrade, TradePair, AddChar);
	}
		
		
   DrawHeader();
   DrawScanner();
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate0(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//---
   
//--- return value of prev_calculated for next call
   return(rates_total);
  }
  
  
  //+------------------------------------------------------------------+  
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- destroy timer
  string s;
  string name;
    s = masterPreamble; //_symbolPair;
    //s = Symbol();
    for (int i = ObjectsTotal() - 1; i >= 0; i--)
    {
        name = ObjectName(i);
        if (StringSubstr(name, 0, StringLen(s)) == s)
        {
            ObjectDelete(name);
        }
    }

   EventKillTimer();
   ObjectsDeleteAll();
  ObjectsDeleteAll(ChartID(),INDI_NAME);
   //return(0);
 // }    
  }

//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate00(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
   DrawMissingTime();
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer() {
   {
   GetFibonacciDaily();GetFibonacciDailyB();GetFibonacciDailyC();GetDirection();GetStochastic();GetMACD();GetCCI();GetADX();GetATR();GetWilliams();GetRSI();
   AI_SCANING_SIGNALS();
   }

   Trades();
   
   Trades2();
   
   TradeManager();

   PlotTrades();

   PlotSpreadPips();

   GetSignals();  
   GetSignals1();         
   displayMeter();
   GetSignalsCD();
   DoWork();
   GetCommodity();
   GetTrendChange();
   Geth4d1();
   GethUSD();
   GetMACD2 ();
   DrawMissingTime();
   if(TimeSeconds(TimeCurrent())%TimerInterval==0)
     {
   DrawScanner();
    } 
   get_list_status(list);   
   if (newday != iTime("EURUSD"+postfix,PERIOD_D1,0)) {
      GetAdrValues();
      PlotAdrValues();
      newday = iTime("EURUSD"+postfix,PERIOD_D1,0);
   }
          
   if (DashUpdate == 0 || (DashUpdate == 1 && newm1 != iTime("EURUSD"+postfix,PERIOD_M1,0)) || (DashUpdate == 5 && newm1 != iTime("EURUSD"+postfix,PERIOD_M5,0))) {

      
   for(int i=0;i<ArraySize(TradePairs);i++) 
   for(int a=0;a<5;a++){
   //STOP POR $
   if(tprofit[i]>=Pair_Target)
   {
   closeOpenOrders(TradePairs[i]);
  }
//STOP POR      
    ChngBoxCol((signals[i].Signalperc * 100), i);
    ChngBoxCol1((signals[i].Signalperc1 * 100), i);
    SetColors(i);      
    SetText("Percent"+IntegerToString(i),DoubleToStr(signals[i].Signalperc,2)+"%" ,x_axis+987,(i*11)+y_axis-35,clrBlack,7);
    //SetText("Percnt2"+IntegerToString(i),DoubleToStr(signals[i].Signalperc1,2)+"%" ,(i*46)+x_axis+20,y_axis+307,clrBlack,7);
    SetText("Percnt2"+IntegerToString(i),DoubleToStr(signals[i].Signalperc1,2)+"%" ,x_axis+1020,(i*11)+y_axis-35,clrBlack,7);
  //BOTAO LOTES
  ObjectSetText("LotSize","Lot:           "+DoubleToString(lot,2));
  //BOTAO LOTES
  //BOTAO STOPS
  ObjectSetText("Piptp","PipTP:       "+DoubleToString(Piptp,2));
  ObjectSetText("Pipsl","PipSL:       "+DoubleToString(Pipsl,2));
  //---
  ObjectSetText("Adr1tp","AdrTP: % "+DoubleToString(Adr1tp,2));
  ObjectSetText("Adr1sl","AdrSL: % "+DoubleToString(Adr1sl,2));
  //BOTAO STOPS 

  ///SetText("pointrange"+IntegerToString(i),DoubleToStr(signals[i].range3,0),x_axis+788,(i*11)+y_axis-32,clrGray,6); 
  ///SetText("high"+IntegerToString(i),DoubleToStr(signals[i].high3,signals[i].digit3),x_axis+802,(i*11)+y_axis-32,clrGray,6);
  ///SetText("ask"+IntegerToString(i),DoubleToStr(signals[i].ask3,signals[i].digit3),x_axis+832,(i*11)+y_axis-32,clrGray,6); 
  ///SetText("bid"+IntegerToString(i),DoubleToStr(signals[i].bid3,signals[i].digit3),x_axis+862,(i*11)+y_axis-32,clrGray,6); 
  ///SetText("low"+IntegerToString(i),DoubleToStr(signals[i].low3,signals[i].digit3),x_axis+892,(i*11)+y_axis-32,clrGray,6);
  
  if(MathAbs(signals[i].Signalusd)>MathAbs(signals[i].prevSignalusd)){SetObjText("SDM5"+IntegerToString(i),CharToStr(216),x_axis+247,(i*11)+y_axis-36,BBullColor,7);}
  if(MathAbs(signals[i].Signalusd)<MathAbs(signals[i].prevSignalusd)){SetObjText("SDM5"+IntegerToString(i),CharToStr(215),x_axis+247,(i*11)+y_axis-36,BBearColor,7);}
  if(signals[i].Signalusd==signals[i].prevSignalusd){SetObjText("SDM5M5"+IntegerToString(i),"",x_axis+247,(i*11)+y_axis-36,NeutroColor,7);}
  ObjectSetText("usdintsigM5"+IntegerToString(i),DoubleToStr(MathAbs( signals[i].Signalusd),0)+"%",6,NULL,Color9);      
  //SetText("Pr1USD"+IntegerToString(i),StringSubstr(TradePairs[i],0,6),x_axis+655,(i*10)+y_axis,ColorPair,6);
  SetPanel("A22322USD"+IntegerToString(i),0,x_axis+225,(i*11)+y_axis-36,55,11,clrBlack,C'61,61,61',1);//COLUNA PARES / LINHA VERDE

  SetText("usdintsigM5"+IntegerToString(i),DoubleToStr(MathAbs(signals[i].Signalusd),0)+"%",x_axis+225,(i*11)+y_axis-36,Color9,7);           
  SetPanel("B1M5"+IntegerToString(i),0,x_axis+257,(i*11)+y_axis-36,3,11,C'0,0,0',C'0,0,0',1); 
  SetPanel("B2M5"+IntegerToString(i),0,x_axis+259,(i*11)+y_axis-36,3,11,C'0,0,0',C'0,0,0',1); 
  SetPanel("B3M5"+IntegerToString(i),0,x_axis+261,(i*11)+y_axis-36,3,11,labelcolor4USD,labelcolor2USD,1);
  SetPanel("B4M5"+IntegerToString(i),0,x_axis+263,(i*11)+y_axis-36,3,11,labelcolor5USD,labelcolor2USD,1);
  SetPanel("B5M5"+IntegerToString(i),0,x_axis+265,(i*11)+y_axis-36,3,11,labelcolor6USD,labelcolor2USD,1);
  SetPanel("B6M5"+IntegerToString(i),0,x_axis+267,(i*11)+y_axis-36,3,11,labelcolor7USD,labelcolor2USD,1);
  SetPanel("B7M5"+IntegerToString(i),0,x_axis+269,(i*11)+y_axis-36,3,11,labelcolor8USD,labelcolor2USD,1);
  SetPanel("B8M5"+IntegerToString(i),0,x_axis+271,(i*11)+y_axis-36,3,11,labelcolor9USD,labelcolor2USD,1);
  SetPanel("B9M5"+IntegerToString(i),0,x_axis+273,(i*11)+y_axis-36,3,11,labelcolor10USD,labelcolor2USD,1);
  SetPanel("B10M5"+IntegerToString(i),0,x_axis+275,(i*11)+y_axis-36,3,11,labelcolor11USD,labelcolor2USD,1);
  //SetPanel("DIRM5"+IntegerToString(i),0,x_axis+145,(i*11)+y_axis-32,10,10,C'0,0,0',C'0,0,0',1); 
       
     if(pairinfo[i].PipsSig==UP){SetObjText("Sigpips"+IntegerToString(i),CharToStr(108),x_axis+199,(i*11)+y_axis-36,BBullColor,7);}
     else if(pairinfo[i].PipsSig==DOWN){SetObjText("Sigpips"+IntegerToString(i),CharToStr(108),x_axis+199,(i*11)+y_axis-36,BBearColor,7);}
     
     SetText("BidRat"+IntegerToString(i),DoubleToStr(signals[i].ratio,1)+"%",x_axis+282,(i*11)+y_axis-36,Colorstr(signals[i].ratio),7); 
     SetText("BSRat"+IntegerToString(i),DoubleToStr(signals[i].strength5,1),x_axis+320,(i*11)+y_axis-36,ColorBSRat(signals[i].strength5),7);
     SetText("RelStrgth"+IntegerToString(i),DoubleToStr(signals[i].calc,0),x_axis+340,(i*11)+y_axis-36,Colorsync(signals[i].calc),7);
     SetText("PrevGap"+signals[i].symbol,DoubleToStr(signals[i].strength8,1),x_axis+353,(i*11)+y_axis-36,PrevGap(signals[i].strength8),7);
     SetText("gap"+signals[i].symbol, DoubleToStr(signals[i].strength_Gap,1),x_axis+370,(i*11)+y_axis-36,ColorGap(signals[i].strength_Gap),7);
     
     ///if(signals[i].PrevGap==UP){SetObjText("PrevGap12"+IntegerToString(i),CharToStr(108),x_axis+370,(i*11)+y_axis-34,BBullColor,7);}
     ///else if(signals[i].PrevGap==DOWN){SetObjText("PrevGap12"+IntegerToString(i),CharToStr(108),x_axis+370,(i*11)+y_axis-34,BBearColor,7);}
     ///else {SetObjText("PrevGap12"+IntegerToString(i),CharToStr(243),x_axis+370,(i*11)+y_axis-34,NeutroColor,8);}
     
     if(signals[i].SigRatioPrev==UP){SetObjText("Sig"+IntegerToString(i),CharToStr(108),x_axis+312,(i*11)+y_axis-36,BBullColor,7);}
     else if(signals[i].SigRatioPrev==DOWN){SetObjText("Sig"+IntegerToString(i),CharToStr(108),x_axis+312,(i*11)+y_axis-36,BBearColor,7);}
     
     if(signals[i].SigGapPrev==UP){SetObjText("GapSig"+IntegerToString(i),CharToStr(108),x_axis+390,(i*11)+y_axis-36,BBullColor,7);}
     else if(signals[i].SigGapPrev==DOWN){SetObjText("GapSig"+IntegerToString(i),CharToStr(108),x_axis+390,(i*11)+y_axis-36,BBearColor,7);}
     else {SetObjText("GapSig"+IntegerToString(i),CharToStr(243),x_axis+390,(i*11)+y_axis-36,NeutroColor,8);}
//CANDLE DIRECTION---------------------------------------------------------------------------------------------------------------------------+
  if(signals[i].SignalCDm1==UP){SetObjText("CDM1"+IntegerToString(i),CharToStr(127),x_axis+943,(i*11)+y_axis-37,BullColor,11);}//08 CANDLE DIRECTION
  if(signals[i].SignalCDm1==DOWN){SetObjText("CDM1"+IntegerToString(i),CharToStr(127),x_axis+943,(i*11)+y_axis-37,BearColor,11);}//08 CANDLE DIRECTION
  if(signals[i].SignalCDm5==UP){SetObjText("CDM5"+IntegerToString(i),CharToStr(127),x_axis+948,(i*11)+y_axis-37,BullColor,11);}//08 CANDLE DIRECTION
  if(signals[i].SignalCDm5==DOWN){SetObjText("CDM5"+IntegerToString(i),CharToStr(127),x_axis+948,(i*11)+y_axis-37,BearColor,11);}//08 CANDLE DIRECTION
  if(signals[i].SignalCDm15==UP){SetObjText("CDM15"+IntegerToString(i),CharToStr(127),x_axis+953,(i*11)+y_axis-37,BullColor,11);}//08 CANDLE DIRECTION
  if(signals[i].SignalCDm15==DOWN){SetObjText("CDM15"+IntegerToString(i),CharToStr(127),x_axis+953,(i*11)+y_axis-37,BearColor,11);}//08 CANDLE DIRECTION 
  if(signals[i].SignalCDm30==UP){SetObjText("CDM30"+IntegerToString(i),CharToStr(127),x_axis+958,(i*11)+y_axis-37,BullColor,11);}//08 CANDLE DIRECTION
  if(signals[i].SignalCDm30==DOWN){SetObjText("CDM30"+IntegerToString(i),CharToStr(127),x_axis+958,(i*11)+y_axis-37,BearColor,11);}//08 CANDLE DIRECTION
  if(signals[i].SignalCDh1==UP){SetObjText("CDH1"+IntegerToString(i),CharToStr(127),x_axis+963,(i*11)+y_axis-37,BullColor,11);}//09 CANDLE DIRECTION
  if(signals[i].SignalCDh1==DOWN){SetObjText("CDH1"+IntegerToString(i),CharToStr(127),x_axis+963,(i*11)+y_axis-37,BearColor,11);}//09 CANDLE DIRECTION
  if(signals[i].SignalCDh4==UP){SetObjText("CDH4"+IntegerToString(i),CharToStr(127),x_axis+968,(i*11)+y_axis-37,BullColor,11);}//10 CANDLE DIRECTION
  if(signals[i].SignalCDh4==DOWN){SetObjText("CDH4"+IntegerToString(i),CharToStr(127),x_axis+968,(i*11)+y_axis-37,BearColor,11);}//10 CANDLE DIRECTION
  if(signals[i].SignalCDd1==UP){SetObjText("CDD1"+IntegerToString(i),CharToStr(127),x_axis+973,(i*11)+y_axis-37,BullColor,11);}//10 CANDLE DIRECTION
  if(signals[i].SignalCDd1==DOWN){SetObjText("CDD1"+IntegerToString(i),CharToStr(127),x_axis+973,(i*11)+y_axis-37,BearColor,11);}//10 CANDLE DIRECTION
  if(signals[i].SignalCDw1==UP){SetObjText("CDW1"+IntegerToString(i),CharToStr(127),x_axis+978,(i*11)+y_axis-37,BullColor,11);}//10 CANDLE DIRECTION
  if(signals[i].SignalCDw1==DOWN){SetObjText("CDW1"+IntegerToString(i),CharToStr(127),x_axis+978,(i*11)+y_axis-37,BearColor,11);}//10 CANDLE DIRECTION

//---------------------------------------------------------------------------------------------------------------------------+
  if(signals[i].Signalm1==UP){SetObjText("SigM1"+IntegerToString(i),CharToStr(217),x_axis+750,(i*11)+y_axis-36,BBullColor,8);}
  if(signals[i].Signalm1==DOWN){SetObjText("SigM1"+IntegerToString(i),CharToStr(218),x_axis+750,(i*11)+y_axis-36,BBearColor,8);}
  if(signals[i].Signalm5==UP){SetObjText("SigM5"+IntegerToString(i),CharToStr(217),x_axis+760,(i*11)+y_axis-36,BBullColor,8);}
  if(signals[i].Signalm5==DOWN){SetObjText("SigM5"+IntegerToString(i),CharToStr(218),x_axis+760,(i*11)+y_axis-36,BBearColor,8);}
  if(signals[i].Signalm15==UP){SetObjText("SigM15"+IntegerToString(i),CharToStr(217),x_axis+770,(i*11)+y_axis-36,BBullColor,8);}
  if(signals[i].Signalm15==DOWN){SetObjText("SigM15"+IntegerToString(i),CharToStr(218),x_axis+770,(i*11)+y_axis-36,BBearColor,8);}
//---------------------------------------------------------------------------------------------------------------------------+
  if(signals[i].Signalrsi==UP){SetObjText("RSI_Sig"+IntegerToString(i),CharToStr(233),x_axis+425,(i*11)+y_axis-36,BBullColor,6);}
  else if(signals[i].Signalrsi==DOWN){SetObjText("RSI_Sig"+IntegerToString(i),CharToStr(234),x_axis+425,(i*11)+y_axis-34,BBearColor,6);}
  else {SetObjText("RSI_Sig"+IntegerToString(i),CharToStr(243),x_axis+425,(i*11)+y_axis-35,NeutroColor,6);}  
  
  ///if(signals[i].Signalcc==UP){SetObjText("CCI11"+IntegerToString(i),CharToStr(221),x_axis+443,(i*11)+y_axis-34,BBullColor,8);}
  ///if(signals[i].Signalcc==DOWN){SetObjText("CCI11"+IntegerToString(i),CharToStr(222),x_axis+443,(i*11)+y_axis-34,BBearColor,8);}

//---------------------------------------------------------------------------------------------------------------------------+
  ///if(signals[i].SignalMACDup01==UP){SetObjText("MACD_Sig"+IntegerToString(i),CharToStr(221),x_axis+469,(i*11)+y_axis-34,BullColor,8);}//MACD M30
  ///if(signals[i].SignalMACDdn01==DOWN){SetObjText("MACD_Sig"+IntegerToString(i),CharToStr(222),x_axis+469,(i*11)+y_axis-34,BearColor,8);}//MACD M30
//---------------------------------------------------------------------------------------------------------------------------+
//---------------------------------------------------------------------------------------------------------------------------+
  if (ShowRSICCIMACD) {
  if(signals[i].Signal_CCIA=="BUY"){SetObjText("CCIA"+IntegerToString(i),CharToStr(217),x_axis+890,(i*11)+y_axis-34,BBullColor,7);}
  if(signals[i].Signal_CCIA=="SELL"){SetObjText("CCIA"+IntegerToString(i),CharToStr(218),x_axis+890,(i*11)+y_axis-32,BBearColor,7);}
  if(signals[i].Signal_CCIB=="BUY"){SetObjText("CCIB"+IntegerToString(i),CharToStr(217),x_axis+920,(i*11)+y_axis-34,BBullColor,7);}
  if(signals[i].Signal_CCIB=="SELL"){SetObjText("CCIB"+IntegerToString(i),CharToStr(218),x_axis+920,(i*11)+y_axis-32,BBearColor,7);}
  if(signals[i].Signal_CCIC=="BUY"){SetObjText("CCIC"+IntegerToString(i),CharToStr(217),x_axis+950,(i*11)+y_axis-34,BBullColor,7);}
  if(signals[i].Signal_CCIC=="SELL"){SetObjText("CCIC"+IntegerToString(i),CharToStr(218),x_axis+950,(i*11)+y_axis-32,BBearColor,7);}
  }
//---------------------------------------------------------------------------------------------------------------------------+
//---------------------------------------------------------------------------------------------------------------------------+
if (ShowPowerMeter1) { 
  SetText("Pr111"+IntegerToString(i),list[i].symbol1,st1x_axis+875,(i*11)+st1y_axis-2,ColorstrST(list[i].ratio1),7);
  SetText("fxs111"+IntegerToString(i),DoubleToStr(MathAbs(list[i].ratio1),1)+"%",st1x_axis+920,(i*11)+st1y_axis-2,ColorstrST(list[i].ratio1),7);
  //SetText("Pp111"+IntegerToString(i),DoubleToStr(MathAbs(list[i].pips1),0),st1x_axis+900,(i*11)+st1y_axis-2,ColorPips(list[i].pips1),7);

  if(list[i].ratio1>0){SetObjText("Sig111"+IntegerToString(i),CharToStr(217),st1x_axis+952,(i*11)+st1y_axis-2,PMBullColor,7);}
  else if(list[i].ratio1<0){SetObjText("Sig111"+IntegerToString(i),CharToStr(218),st1x_axis+952,(i*11)+st1y_axis-2,PMBearColor,7);}
  for(int b=0; b<=list[i].calc1-1; b++){
  ObjectDelete("fx1111"+IntegerToString(i)+IntegerToString(b));   
  if(list[i].ratio1>0){SetText("fx1111"+IntegerToString(i)+IntegerToString(b),"|",(b*3)+st1x_axis+965,(i*11)+st1y_axis-2,PMBullColor,7);}
  else if(list[i].ratio1<0){SetText("fx1111"+IntegerToString(i)+IntegerToString(b),"|",(b*3)+st1x_axis+965,(i*11)+st1y_axis-2,PMBearColor,7);}
  }   
}
//---------------------------------------------------------------------------------------------------------------------------+                
      if (((pairinfo[i].PipsSig==UP && pairinfo[i].Pips > trade_MIN_pips) || trigger_use_Pips==false)
      && ((pairinfo[i].Pips >trade_MIN_pips)|| trigger_use_Pips==false)
  && ((pairinfo[i].Pips <trade_MAX_pips)|| trigger_use_Pips==false)
      && ((signals[i].SigRatioPrev==UP && signals[i].ratio>=trigger_buy_bidratio) || trigger_use_bidratio==false)
  && ((signals[i].ratio > trade_MIN_buy_bidratio)|| trigger_use_bidratio==false)
  && ((signals[i].ratio < trade_MAX_buy_bidratio)|| trigger_use_bidratio==false)
  && (signals[i].calc>=trigger_buy_relstrength || trigger_use_relstrength==false)
  && ((signals[i].calc > trade_MIN_buy_relstrength)|| trigger_use_relstrength==false)
  && ((signals[i].calc < trade_MAX_buy_relstrength)|| trigger_use_relstrength==false)
  && (signals[i].strength5>=trigger_buy_buysellratio || trigger_use_buysellratio==false)
  && ((signals[i].strength5 > trade_MIN_buy_buysellratio)|| trigger_use_buysellratio==false)
  && ((signals[i].strength5 < trade_MAX_buy_buysellratio)|| trigger_use_buysellratio==false)
  && ((signals[i].SigGapPrev==UP && signals[i].strength_Gap>=trigger_gap_buy) || trigger_use_gap==false)         
  && ((signals[i].strength_Gap > trade_MIN_gap_buy)|| trigger_use_gap==false)
  && ((signals[i].strength_Gap < trade_MAX_gap_buy)|| trigger_use_gap==false)
  //ADR
  && ((signals[i].ADR68 < signals[i].close>signals[i].open) || AI_AdrDir == false )
  //ADR
  && ((signals[i].PrevGap==UP && signals[i].strength8>=trigger_PrevGap_buy) || trigger_use_PrevGap==false)         
  && ((signals[i].strength8 > trade_MIN_PrevGap_buy)|| trigger_use_PrevGap==false)
  && ((signals[i].strength8 < trade_MAX_PrevGap_buy)|| trigger_use_PrevGap==false)
  
  && (signals[i].Signal_Fibonacci=="BUY"    || AI_Fibonacci==false)
  && (signals[i].Signal_FibonacciB=="BUY"    || AI_FibonacciB==false)
  && (signals[i].Signal_FibonacciC=="BUY"    || AI_FibonacciC==false)
       
  && (signals[i].Signal_Direction=="BUY"    || AI_Candle_Direction==false)
  && (signals[i].Signal_Stochastic=="BUY"   || AI_Stochastic1==false)
  && (signals[i].Signal_Stochastic=="BUY"   || AI_Stochastic2==false)
  && (signals[i].Signal_Stochastic=="BUY"   || AI_Stochastic3==false)
  && (signals[i].Signalm1>0||trigger_Moving_Average1==false )
  && (signals[i].Signalm5>0||trigger_Moving_Average2==false )
  && (signals[i].Signalm15>0||trigger_Moving_Average3==false )
  && (signals[i].Signalrsi==UP || trigger_use_RSI==false)
  && (signals[i].Signalcc == UP || trigger_CCI==false)
  && (signals[i].Signal_MACD=="BUY"         || AI_MACD==false)
  && (signals[i].SignalMACDup01 >= UP || trigger_MACD1==false)
  && (signals[i].Signal_ADX=="BUY"    || AI_ADX==false)
  && (signals[i].Signal_ATR=="BUY"   || AI_ATR==false)
  && (signals[i].Signal_Williams=="BUY"   || AI_WILL==false)
  && (signals[i].Signal_CCIA=="BUY"     ||     AI_CCIA==false)
  && (signals[i].Signal_CCIB=="BUY"     ||     AI_CCIB==false)
  && (signals[i].Signal_CCIC=="BUY"     ||     AI_CCIC==false)
  && (signals[i].Signal_RSIA=="BUY"          || AI_RSI_A==false)
  && (signals[i].Signal_RSIB=="BUY"          || AI_RSI_B==false)
  && (signals[i].Signal_RSIC=="BUY"          || AI_RSI_C==false)

  && (signals[i].SignaldirupM1>0||trigger_Candle_DirectionM1==false)
  && (signals[i].SignaldirupM5>0||trigger_Candle_DirectionM5==false)
  && (signals[i].SignaldirupM15>0||trigger_Candle_DirectionM15==false)
  && (signals[i].SignaldirupM30>0||trigger_Candle_DirectionM30==false)
  && (signals[i].SignaldirupH1>0||trigger_Candle_DirectionH1==false)
  && (signals[i].SignaldirupH4>0||trigger_Candle_DirectionH4==false)
  && (signals[i].SignaldirupD1>0||trigger_Candle_DirectionD1==false)
  && (signals[i].SignaldirupW1>0||trigger_Candle_DirectionW1==false)
  
  && (list[i].ratio1>=trigger_buy_bidratio1 || trigger_use_bidratio1==false)
  && ((list[i].ratio1 > trade_MIN_buy_bidratio1)|| trigger_use_bidratio1==false)
  && ((list[i].ratio1 < trade_MAX_buy_bidratio1)|| trigger_use_bidratio1==false)
    
  && (signals[i].Signalusd > trade_MIN_Strength || trigger_use_Strength==false)
  &&(signals[i].Signalperc >=trade_MIN_HeatMap1 || trigger_UseHeatMap1==false)
  &&(signals[i].Signalperc <=trade_MAX_HeatMap1 || trigger_UseHeatMap1==false) 
  
  &&(signals[i].Signalperc1 >trade_MIN_HeatMap2 || trigger_UseHeatMap2==false)
  &&(signals[i].Signalperc1 <=trade_MAX_HeatMap2 || trigger_UseHeatMap2==false))
        
       {
         labelcolor = BBullColor;
         if ((bpos[i]+spos[i]) < MaxTrades && pairinfo[i].lastSignal != BUY && autotrade == true && (OnlyAddProfit == false || bprofit[i] >= 0.0) && pairinfo[i].Spread <= MaxSpread && inSession() == true && totaltrades <= maxtotaltrades) {
            pairinfo[i].lastSignal = BUY;
            
            while (IsTradeContextBusy()) Sleep(100);
            ticket=OrderSend(TradePairs[i],OP_BUY,lot,MarketInfo(TradePairs[i],MODE_ASK),100,0,0,comment,Magic_Number,0,Blue);
            if (OrderSelect(ticket,SELECT_BY_TICKET) == true) {
                if (Pipsl != 0.0)
                           stoploss=OrderOpenPrice() - Pipsl * pairinfo[i].PairPip;
                        else
                           if (Adr1sl != 0.0)
                              stoploss=OrderOpenPrice() - ((adrvalues[i].adr10/100)*Adr1sl) * pairinfo[i].PairPip;
                           else
                              stoploss = 0.0;

                        if (Piptp != 0.0)
                              takeprofit=OrderOpenPrice() + Piptp * pairinfo[i].PairPip;
                        else
                           if (Adr1tp != 0.0)
                              takeprofit=OrderOpenPrice() + ((adrvalues[i].adr10/100)*Adr1tp) * pairinfo[i].PairPip;
                           else
                              takeprofit = 0.0;
               
               while (IsTradeContextBusy()) Sleep(100);
               OrderModify(ticket,OrderOpenPrice(),NormalizeDouble(stoploss,MarketInfo(TradePairs[i],MODE_DIGITS)),NormalizeDouble(takeprofit,MarketInfo(TradePairs[i],MODE_DIGITS)),0,clrBlue);
            }
         }
      } else {
         if (((pairinfo[i].PipsSig==DOWN && pairinfo[i].Pips < -trade_MIN_pips) || trigger_use_Pips==false) 
         && ((pairinfo[i].Pips < - trade_MIN_pips)|| trigger_use_Pips==false) 
  && ((pairinfo[i].Pips > - trade_MAX_pips) || trigger_use_Pips==false)
         && ((signals[i].SigRatioPrev==DOWN && signals[i].ratio<=trigger_sell_bidratio) || trigger_use_bidratio==false)
  && ((signals[i].ratio < trade_MIN_sell_bidratio)|| trigger_use_bidratio==false)
  && ((signals[i].ratio > trade_MAX_sell_bidratio)|| trigger_use_bidratio==false)
  && (signals[i].calc<=trigger_sell_relstrength || trigger_use_relstrength==false)
  && ((signals[i].calc < trade_MIN_sell_relstrength)|| trigger_use_relstrength==false)
  && ((signals[i].calc > trade_MAX_sell_relstrength)|| trigger_use_relstrength==false)
  && (signals[i].strength5<=trigger_sell_buysellratio || trigger_use_buysellratio==false)
  && ((signals[i].strength5 < trade_MIN_sell_buysellratio)|| trigger_use_buysellratio==false)
  && ((signals[i].strength5 > trade_MAX_sell_buysellratio)|| trigger_use_buysellratio==false)
  && ((signals[i].SigGapPrev==DOWN && signals[i].strength_Gap<=trigger_gap_sell) || trigger_use_gap==false)         
  && ((signals[i].strength_Gap < trade_MIN_gap_sell)|| trigger_use_gap==false)
  && ((signals[i].strength_Gap > trade_MAX_gap_sell)|| trigger_use_gap==false)
  //ADR
  && ((signals[i].ADR32 > signals[i].close<signals[i].open) || AI_AdrDir == false )
  //ADR
  && ((signals[i].PrevGap==DOWN && signals[i].strength8<=trigger_PrevGap_sell) || trigger_use_PrevGap==false)         
  && ((signals[i].strength8 < trade_MIN_PrevGap_sell)|| trigger_use_PrevGap==false)
  && ((signals[i].strength8 > trade_MAX_PrevGap_sell)|| trigger_use_PrevGap==false)
      
  && (signals[i].Signal_Fibonacci=="SELL"    || AI_Fibonacci==false)
  && (signals[i].Signal_FibonacciB=="SELL"    || AI_FibonacciB==false)
  && (signals[i].Signal_FibonacciC=="SELL"    || AI_FibonacciC==false)
  
  && (signals[i].Signal_Direction=="SELL"    || AI_Candle_Direction==false)
  && (signals[i].Signal_Stochastic=="SELL"   || AI_Stochastic1==false)
  && (signals[i].Signal_Stochastic=="SELL"   || AI_Stochastic2==false)
  && (signals[i].Signal_Stochastic=="SELL"   || AI_Stochastic3==false)
  && (signals[i].Signalm1<0||trigger_Moving_Average1==false )
  && (signals[i].Signalm5<0||trigger_Moving_Average2==false )
  && (signals[i].Signalm15<0||trigger_Moving_Average3==false )
  && (signals[i].Signalrsi==DOWN  || trigger_use_RSI==false)
  && (signals[i].Signalcc == DOWN || trigger_CCI==false)
  && (signals[i].Signal_MACD=="SELL"         || AI_MACD==false)
  && (signals[i].SignalMACDdn01 <= DOWN || trigger_MACD1==false)
  && (signals[i].Signal_ADX=="SELL"   || AI_ADX==false)
  && (signals[i].Signal_ATR=="SELL"   || AI_ATR==false)
  && (signals[i].Signal_Williams=="SELL"   || AI_WILL==false)
  && (signals[i].Signal_CCIA=="SELL"    ||     AI_CCIA==false)
  && (signals[i].Signal_CCIB=="SELL"    ||     AI_CCIB==false)
  && (signals[i].Signal_CCIC=="SELL"    ||     AI_CCIC==false)
  
  && (signals[i].Signal_RSIA=="SELL"          || AI_RSI_A==false)
  && (signals[i].Signal_RSIB=="SELL"          || AI_RSI_B==false)
  && (signals[i].Signal_RSIC=="SELL"          || AI_RSI_C==false)

  && (signals[i].SignaldirdnM1>0||trigger_Candle_DirectionM1==false)
  && (signals[i].SignaldirdnM5>0||trigger_Candle_DirectionM5==false)
  && (signals[i].SignaldirdnM15>0||trigger_Candle_DirectionM15==false)
  && (signals[i].SignaldirdnM30>0||trigger_Candle_DirectionM30==false)
  && (signals[i].SignaldirdnH1>0||trigger_Candle_DirectionH1==false)
  && (signals[i].SignaldirdnH4>0||trigger_Candle_DirectionH4==false)
  && (signals[i].SignaldirdnD1>0||trigger_Candle_DirectionD1==false)
  && (signals[i].SignaldirdnW1>0||trigger_Candle_DirectionW1==false)
  
  && (list[i].ratio1<=trigger_sell_bidratio1 || trigger_use_bidratio1==false)
  && ((list[i].ratio1 < trade_MIN_sell_bidratio1)|| trigger_use_bidratio1==false)
  && ((list[i].ratio1 > trade_MAX_sell_bidratio1)|| trigger_use_bidratio1==false) 
  
  && (signals[i].Signalusd < - trade_MIN_Strength || trigger_use_Strength==false)
  &&(signals[i].Signalperc <-trade_MIN_HeatMap1 || trigger_UseHeatMap1==false)
  &&(signals[i].Signalperc >-trade_MAX_HeatMap1 || trigger_UseHeatMap1==false)
  
  && (signals[i].Signalperc1 <-trade_MIN_HeatMap2 || trigger_UseHeatMap2==false)
  && (signals[i].Signalperc1 >-trade_MAX_HeatMap2 || trigger_UseHeatMap2==false))        
         {
            labelcolor = BBearColor;           
            if ((bpos[i]+spos[i]) < MaxTrades && pairinfo[i].lastSignal != SELL && autotrade == true && (OnlyAddProfit == false || sprofit[i] >= 0.0) && pairinfo[i].Spread <= MaxSpread && inSession() == true && totaltrades <= maxtotaltrades) {
               pairinfo[i].lastSignal = SELL;
               
               while (IsTradeContextBusy()) Sleep(100);
               ticket=OrderSend(TradePairs[i],OP_SELL,lot,MarketInfo(TradePairs[i],MODE_BID),100,0,0,comment,Magic_Number,0,Red);
               if (OrderSelect(ticket,SELECT_BY_TICKET) == true) {
                  if (Pipsl != 0.0)
                              stoploss=OrderOpenPrice() + Pipsl * pairinfo[i].PairPip;
                           else
                              if (Adr1sl != 0.0)
                                 stoploss=OrderOpenPrice()+((adrvalues[i].adr10/100)*Adr1sl)  *pairinfo[i].PairPip;
                              else
                                 stoploss = 0.0;
                                 
                                 
                           if (Piptp != 0.0)
                              takeprofit=OrderOpenPrice() - Piptp * pairinfo[i].PairPip;
                           else 
                              if (Adr1tp != 0.0)
                                 takeprofit=OrderOpenPrice() - ((adrvalues[i].adr10/100)*Adr1tp) * pairinfo[i].PairPip;
                              else
                                 takeprofit = 0.0;
                                 
                  while (IsTradeContextBusy()) Sleep(100);
                  OrderModify(ticket,OrderOpenPrice(),NormalizeDouble(stoploss,MarketInfo(TradePairs[i],MODE_DIGITS)),NormalizeDouble(takeprofit,MarketInfo(TradePairs[i],MODE_DIGITS)),0,clrBlue);
               }
            }
         } else {
            labelcolor = BackGrnCol;
            pairinfo[i].lastSignal = NOTHING;
         }  
      }
      ///string HM0 = iCustom(NULL, 0, "HeatMapModokiV1",5, 10, "Arial", 585 , 250, 0 , 0,i);
      ///string HM1 = iCustom(NULL, 0, "HeatMapModokiV1",15, 10, "Arial", 620 , 250, 0 , 0,i);
      ///string HM2 = iCustom(NULL, 0, "HeatMapModokiV1",60, 10, "Arial", 655 , 250, 0 , 0,i);
      ///string HM3 = iCustom(NULL, 0, "HeatMapModokiV1",240, 10, "Arial", 690 , 250, 0 , 0,i);
      ///string HM4 = iCustom(NULL, 0, "HeatMapModokiV1",1440, 10, "Arial", 725 , 250, 0 , 0,i);
      
              
         ColorPanel("Spread"+IntegerToString(i),labelcolor,C'61,61,61');        
         ColorPanel("Pips"+IntegerToString(i),labelcolor,C'61,61,61');
         ColorPanel("Adr"+IntegerToString(i),labelcolor,C'61,61,61');         
         ColorPanel("TP",Black,White);
         ColorPanel("TP1",Black,White);
         ColorPanel("TP2",Black,White);
         ColorPanel("TP3",Black,White);
         ColorPanel("TP4",Black,White);
         ColorPanel("TP5",Black,White);         
         //ColorPanel("A2"+IntegerToString(i),labelcolor,C'61,61,61');          
  ColorPanel("B1M5"+IntegerToString(i),labelcolor1USD,labelcolor2USD);
  ColorPanel("B2M5"+IntegerToString(i),labelcolor3USD,labelcolor2USD);
  ColorPanel("B3M5"+IntegerToString(i),labelcolor4USD,labelcolor2USD);
  ColorPanel("B4M5"+IntegerToString(i),labelcolor5USD,labelcolor2USD);
  ColorPanel("B5M5"+IntegerToString(i),labelcolor6USD,labelcolor2USD);
  ColorPanel("B6M5"+IntegerToString(i),labelcolor7USD,labelcolor2USD);
  ColorPanel("B7M5"+IntegerToString(i),labelcolor8USD,labelcolor2USD);
  ColorPanel("B8M5"+IntegerToString(i),labelcolor9USD,labelcolor2USD);
  ColorPanel("B9M5"+IntegerToString(i),labelcolor10USD,labelcolor2USD);
  ColorPanel("B10M5"+IntegerToString(i),labelcolor11USD,labelcolor2USD);
  ColorPanel("DIRM5"+IntegerToString(i),labelcolorUSD,C'0,0,0');     
   //CANDLE DIRECTION
  ColorPanel("m1"+IntegerToString(i),clrNONE,clrBlack);
  ColorPanel("m5"+IntegerToString(i),clrBlack,White);
  ColorPanel("m15"+IntegerToString(i),clrBlack,C'0,0,0');
  ColorPanel("m30"+IntegerToString(i),clrBlack,C'0,0,0');
  ColorPanel("h1"+IntegerToString(i),clrBlack,C'0,0,0');
  ColorPanel("h4"+IntegerToString(i),clrBlack,C'0,0,0');
  ColorPanel("d1"+IntegerToString(i),clrBlack,C'0,0,0');
  ColorPanel("w1"+IntegerToString(i),clrBlack,C'0,0,0');
  //CANDLE DIRECTION          
      }
      if (DashUpdate == 1)
         newm1 = iTime("EURUSD"+postfix,PERIOD_M1,0);
      else if (DashUpdate == 5)
         newm1 = iTime("EURUSD"+postfix,PERIOD_M5,0);
   }
   WindowRedraw(); 
   MarketSessionTimePanel();   
}
  
//+------------------------------------------------------------------+

void SetText(string name,string text,int x,int y,color colour,int fontsize=12)
  {
   if (ObjectFind(0,name)<0)
      ObjectCreate(0,name,OBJ_LABEL,0,0,0);

    ObjectSetInteger(0,name,OBJPROP_XDISTANCE,x);
    ObjectSetInteger(0,name,OBJPROP_YDISTANCE,y);
    ObjectSetInteger(0,name,OBJPROP_COLOR,colour);
    ObjectSetInteger(0,name,OBJPROP_FONTSIZE,fontsize);
    ObjectSetInteger(0,name,OBJPROP_CORNER,CORNER_LEFT_UPPER);
    ObjectSetString(0,name,OBJPROP_TEXT,text);
  }
void EditText(string name,string text,color fontcolor,int fontsize)  {
    ObjectSetString(0,name,OBJPROP_TEXT,text);
    ObjectSetInteger(0,name,OBJPROP_COLOR,fontcolor);
    ObjectSetInteger(0,name,OBJPROP_FONTSIZE,fontsize);
} 
//+------------------------------------------------------------------+

void SetObjText(string name,string CharToStr,int x,int y,color colour,int fontsize=12)
  {
   if(ObjectFind(0,name)<0)
      ObjectCreate(0,name,OBJ_LABEL,0,0,0);

   ObjectSetInteger(0,name,OBJPROP_FONTSIZE,fontsize);
   ObjectSetInteger(0,name,OBJPROP_COLOR,colour);
   ObjectSetInteger(0,name,OBJPROP_BACK,false);
   ObjectSetInteger(0,name,OBJPROP_XDISTANCE,x);
   ObjectSetInteger(0,name,OBJPROP_YDISTANCE,y);
   ObjectSetString(0,name,OBJPROP_TEXT,CharToStr);
   ObjectSetString(0,name,OBJPROP_FONT,"Wingdings");
  }  
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void SetPanel(string name,int sub_window,int x,int y,int width,int height,color bg_color,color border_clr,int border_width)
  {
   if(ObjectCreate(0,name,OBJ_RECTANGLE_LABEL,sub_window,0,0))
     {
      ObjectSetInteger(0,name,OBJPROP_XDISTANCE,x);
      ObjectSetInteger(0,name,OBJPROP_YDISTANCE,y);
      ObjectSetInteger(0,name,OBJPROP_XSIZE,width);
      ObjectSetInteger(0,name,OBJPROP_YSIZE,height);
      ObjectSetInteger(0,name,OBJPROP_COLOR,border_clr);
      ObjectSetInteger(0,name,OBJPROP_BORDER_TYPE,BORDER_FLAT);
      ObjectSetInteger(0,name,OBJPROP_WIDTH,border_width);
      ObjectSetInteger(0,name,OBJPROP_CORNER,CORNER_LEFT_UPPER);
      ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
      ObjectSetInteger(0,name,OBJPROP_BACK,true);
      ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0);
      ObjectSetInteger(0,name,OBJPROP_SELECTED,0);
      ObjectSetInteger(0,name,OBJPROP_HIDDEN,true);
      ObjectSetInteger(0,name,OBJPROP_ZORDER,0);
     }
   ObjectSetInteger(0,name,OBJPROP_BGCOLOR,bg_color);
  }
void ColorPanel(string name,color bg_color,color border_clr)
  {
   ObjectSetInteger(0,name,OBJPROP_COLOR,border_clr);
   ObjectSetInteger(0,name,OBJPROP_BGCOLOR,bg_color);
  }
void SignalColorPanel_border_clr(string name,color border_clr)
  {
   ObjectSetInteger(0,name,OBJPROP_COLOR,border_clr);
  }    
void SignalColorPanel_bg(string name,color bg_color)
  {
   ObjectSetInteger(0,name,OBJPROP_BGCOLOR,bg_color);
  }    
void SignalColorPanel_txt(string name,string text,color FontColor)
  {
    ObjectSetString(0,name,OBJPROP_TEXT,text);
    ObjectSetInteger(0,name,OBJPROP_COLOR,FontColor);
 }         
//+------------------------------------------------------------------+
void Create_Button(string but_name,string label,int xsize,int ysize,int xdist,int ydist,int bcolor,int fcolor,color bgcolor=clrBlack,
  color border_color=clrNONE,
  color fgcolor=clrWhite,
  string fontface="Arial",
  double fontsize=8,
  double fontsize1=8,
  bool selectable=false,
  bool selected=false,
  bool state=false)
  {
  if(ObjectFind(0,but_name)<0)
  {
  if(!ObjectCreate(0,but_name,OBJ_BUTTON,0,0,0))
  {
  Print(__FUNCTION__,
  ": failed to create the button! Error code = ",GetLastError());
  return;
  }
  ObjectSetString(0,but_name,OBJPROP_TEXT,label);
  ObjectSetInteger(0,but_name,OBJPROP_XSIZE,xsize);
  ObjectSetInteger(0,but_name,OBJPROP_YSIZE,ysize);
  ObjectSetInteger(0,but_name,OBJPROP_CORNER,CORNER_LEFT_UPPER);     
  ObjectSetInteger(0,but_name,OBJPROP_XDISTANCE,xdist);      
  ObjectSetInteger(0,but_name,OBJPROP_YDISTANCE,ydist);         
  ObjectSetInteger(0,but_name,OBJPROP_BGCOLOR,bcolor);
  ObjectSetInteger(0,but_name,OBJPROP_BGCOLOR,bgcolor);
  ObjectSetInteger(0,but_name,OBJPROP_BORDER_COLOR,border_color);
  ObjectSetInteger(0,but_name,OBJPROP_COLOR,fgcolor);
  ObjectSetInteger(0,but_name,OBJPROP_FONTSIZE,fontsize);
  ObjectSetInteger(0,but_name,OBJPROP_COLOR,fcolor);
  ObjectSetInteger(0,but_name,OBJPROP_FONTSIZE,8);
  ObjectSetInteger(0,but_name,OBJPROP_HIDDEN,true);
  //ObjectSetInteger(0,but_name,OBJPROP_BORDER_COLOR,ChartGetInteger(0,CHART_COLOR_FOREGROUND));
  ObjectSetInteger(0,but_name,OBJPROP_BORDER_TYPE,BORDER_RAISED);
  ObjectSetString(0,but_name,OBJPROP_FONT,fontface);

  //--- enable (true) or disable (false) the mode of moving the button by mouse
  ObjectSetInteger(0,but_name,OBJPROP_SELECTABLE,selectable);
  ObjectSetInteger(0,but_name,OBJPROP_SELECTED,selected);
  //--- set button state
  ObjectSetInteger(0,but_name,OBJPROP_STATE,state);
  //--- hide (true) or display (false) graphical object name in the object list

  ChartRedraw();      
  }
  }
void SetButton(string but_name,string label,int xsize,int ysize,int xdist,int ydist,int bcolor,int fcolor,int textFont)
{
    
   if(ObjectFind(0,but_name)<0)
   {
      if(!ObjectCreate(0,but_name,OBJ_BUTTON,0,0,0))
        {
         Print(__FUNCTION__,
               ": failed to create the button! Error code = ",GetLastError());
         return;
        }
      ObjectSetString(0,but_name,OBJPROP_TEXT,label);
      ObjectSetInteger(0,but_name,OBJPROP_XSIZE,xsize);
      ObjectSetInteger(0,but_name,OBJPROP_YSIZE,ysize);
      ObjectSetInteger(0,but_name,OBJPROP_CORNER,CORNER_LEFT_UPPER);     
      ObjectSetInteger(0,but_name,OBJPROP_XDISTANCE,xdist);      
      ObjectSetInteger(0,but_name,OBJPROP_YDISTANCE,ydist);         
      ObjectSetInteger(0,but_name,OBJPROP_BGCOLOR,bcolor);
      ObjectSetInteger(0,but_name,OBJPROP_COLOR,fcolor);
      ObjectSetInteger(0,but_name,OBJPROP_FONTSIZE,textFont);
      ObjectSetInteger(0,but_name,OBJPROP_HIDDEN,true);
      
      ObjectSetInteger(0,but_name,OBJPROP_BORDER_TYPE,BORDER_FLAT);
      
      ChartRedraw();      
   }

}
void EditButton(string but_name,string label,int bcolor,int fcolor){
   ObjectSetString(0,but_name,OBJPROP_TEXT,label);
   ObjectSetInteger(0,but_name,OBJPROP_BGCOLOR,bcolor);
   ObjectSetInteger(0,but_name,OBJPROP_COLOR,fcolor);
}  
string ConvertPeriodetoString(ENUM_TIMEFRAMES TimeFrame){
   if(TimeFrame==PERIOD_M1){return(Periode[0]);}else
   if(TimeFrame==PERIOD_M5){return(Periode[1]);}else
   if(TimeFrame==PERIOD_M15){return(Periode[2]);}else
   if(TimeFrame==PERIOD_M30){return(Periode[3]);}else
   if(TimeFrame==PERIOD_H1){return(Periode[4]);}else
   if(TimeFrame==PERIOD_H4){return(Periode[5]);}else
   if(TimeFrame==PERIOD_D1){return(Periode[6]);}else
   if(TimeFrame==PERIOD_W1){return(Periode[7]);}else
   if(TimeFrame==PERIOD_MN1){return(Periode[8]);}else{return("");}
}
void PenyetelanTampilan(int GetTampilan,int i){
color clr_bg_color=C'30,30,30';
color clr_border_color=C'61,61,61';
      
   if(GetTampilan==0){clr_border_color=clrTurquoise;}else
   if(GetTampilan==1){clr_border_color=clrViolet;}else
   if(GetTampilan==2){clr_border_color=C'61,61,61';}else{clr_border_color=C'61,61,61';}
   
   SignalColorPanel_border_clr("PanelPerc"+(string)i,clr_border_color);    
   SignalColorPanel_border_clr("PanelFibonacciDaily"+(string)i,clr_border_color);
   SignalColorPanel_border_clr("PanelFibonacciDailyB"+(string)i,clr_border_color);
   SignalColorPanel_border_clr("PanelFibonacciDailyC"+(string)i,clr_border_color);    
   ColorPanel("PanelStochastic1A"+(string)i,clr_bg_color,clr_border_color);    
   ColorPanel("PanelStochastic2A"+(string)i,clr_bg_color,clr_border_color);    
   ColorPanel("PanelStochastic3A"+(string)i,clr_bg_color,clr_border_color);    
   ColorPanel("RSI"+(string)i,clr_bg_color,clr_border_color);    
   ColorPanel("CCI"+(string)i,clr_bg_color,clr_border_color); 
   ColorPanel("MACD"+(string)i,clr_bg_color,clr_border_color);   
   ColorPanel("MM"+(string)i,clr_bg_color,clr_border_color);    
   ColorPanel("PanelMACD"+(string)i,clr_bg_color,clr_border_color);    
   ColorPanel("PanelADX"+(string)i,clr_bg_color,clr_border_color);    
   ColorPanel("PanelCCIA"+(string)i,clr_bg_color,clr_border_color);
   ColorPanel("PanelCCIB"+(string)i,clr_bg_color,clr_border_color); 
   ColorPanel("PanelCCIC"+(string)i,clr_bg_color,clr_border_color);     
   ColorPanel("PanelATR"+(string)i,clr_bg_color,clr_border_color);    
   ColorPanel("PanelWilliams"+(string)i,clr_bg_color,clr_border_color);
   ///ColorPanel("BidRatio"+(string)i,clr_bg_color,clr_border_color);
   ///ColorPanel("BSRatio33"+(string)i,clr_bg_color,clr_border_color);
   ///ColorPanel("RelStr"+(string)i,clr_bg_color,clr_border_color);
   ///ColorPanel("GAP123"+(string)i,clr_bg_color,clr_border_color);
   ColorPanel("PanelPointRange3"+(string)i,clr_bg_color,clr_border_color);
   ColorPanel("Panelhigh3"+(string)i,clr_bg_color,clr_border_color); 
   ColorPanel("PanelAsk3"+(string)i,clr_bg_color,clr_border_color);
   ColorPanel("PanelBid3"+(string)i,clr_bg_color,clr_border_color);
   ColorPanel("PanelLow3"+(string)i,clr_bg_color,clr_border_color);
   ColorPanel("PanelRSIA"+(string)i,clr_bg_color,clr_border_color);    
   ColorPanel("PanelRSIB"+(string)i,clr_bg_color,clr_border_color);    
   ColorPanel("PanelRSIC"+(string)i,clr_bg_color,clr_border_color);
   ColorPanel("xAdr"+IntegerToString(i),C'30,30,30',C'61,61,61');    
}     
void OnChartEvent(const int id,  const long &lparam, const double &dparam,  const string &sparam)
  {
   if(id==CHARTEVENT_OBJECT_CLICK)
//+------------------------------------------------------------------+  
if(sparam=="button_autotrade" && autotrade ==false)
   {
   autotrade =true;
   ObjectSetInteger(0,"button_autotrade",OBJPROP_BGCOLOR,Green);
   ObjectSetInteger(0,"button_autotrade",OBJPROP_COLOR,White);
   ObjectSetString(0,"button_autotrade",OBJPROP_TEXT,"Autotrade");
   Sleep(100);ObjectSetInteger(0,"button_autotrade",OBJPROP_STATE,false);
   }
   else if(sparam=="button_autotrade" && autotrade ==true)
   {
   autotrade=false;
   ObjectSetInteger(0,"button_autotrade",OBJPROP_BGCOLOR,Red);
   ObjectSetInteger(0,"button_autotrade",OBJPROP_COLOR,Black);
   ObjectSetString(0,"button_autotrade",OBJPROP_TEXT,"Manual");
   Sleep(100);ObjectSetInteger(0,"button_autotrade",OBJPROP_STATE,false);
   }
//----------------------------------------------------------------
  if(sparam=="button_trigger_use_Pips" && trigger_use_Pips ==false)
  {
  trigger_use_Pips =true;
  ObjectSetInteger(0,"button_trigger_use_Pips",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_Pips",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_use_Pips",OBJPROP_TEXT,"PIP");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_Pips",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_Pips" && trigger_use_Pips ==true)
  {
  trigger_use_Pips=false;
  ObjectSetInteger(0,"button_trigger_use_Pips",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_Pips",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_use_Pips",OBJPROP_TEXT,"PIP");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_Pips",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
//----------------------------------------------------------------
  if(sparam=="button_trigger_use_bidratio" && trigger_use_bidratio ==false)
  {
  trigger_use_bidratio =true;
  ObjectSetInteger(0,"button_trigger_use_bidratio",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_bidratio",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_use_bidratio",OBJPROP_TEXT,"BDR");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_bidratio",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_bidratio" && trigger_use_bidratio ==true)
  {
  trigger_use_bidratio=false;
  ObjectSetInteger(0,"button_trigger_use_bidratio",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_bidratio",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_use_bidratio",OBJPROP_TEXT,"BDR");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_bidratio",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
  if(sparam=="button_trigger_use_relstrength" && trigger_use_relstrength ==false)
  {
  trigger_use_relstrength =true;
  ObjectSetInteger(0,"button_trigger_use_relstrength",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_relstrength",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_use_relstrength",OBJPROP_TEXT,"Strength");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_relstrength",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_relstrength" && trigger_use_relstrength ==true)
  {
  trigger_use_relstrength=false;
  ObjectSetInteger(0,"button_trigger_use_relstrength",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_relstrength",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_use_relstrength",OBJPROP_TEXT,"Strength");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_relstrength",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
  if(sparam=="button_trigger_use_buysellratio" && trigger_use_buysellratio ==false)
  {
  trigger_use_buysellratio =true;
  ObjectSetInteger(0,"button_trigger_use_buysellratio",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_buysellratio",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_use_buysellratio",OBJPROP_TEXT,"BSR");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_buysellratio",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_buysellratio" && trigger_use_buysellratio ==true)
  {
  trigger_use_buysellratio=false;
  ObjectSetInteger(0,"button_trigger_use_buysellratio",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_buysellratio",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_use_buysellratio",OBJPROP_TEXT,"BSR");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_buysellratio",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
  if(sparam=="button_trigger_use_gap" && trigger_use_gap ==false)
  {
  trigger_use_gap =true;
  ObjectSetInteger(0,"button_trigger_use_gap",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_gap",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_use_gap",OBJPROP_TEXT,"GAP");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_gap",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_gap" && trigger_use_gap ==true)
  {
  trigger_use_gap=false;
  ObjectSetInteger(0,"button_trigger_use_gap",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_gap",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_use_gap",OBJPROP_TEXT,"GAP");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_gap",OBJPROP_STATE,false);
  }
  //----------------------------------------------------------------
  if(sparam=="button_trigger_use_PrevGap" && trigger_use_PrevGap ==false)
  {
  trigger_use_PrevGap =true;
  ObjectSetInteger(0,"button_trigger_use_PrevGap",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_PrevGap",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_use_PrevGap",OBJPROP_TEXT,"P.G");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_PrevGap",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_PrevGap" && trigger_use_PrevGap ==true)
  {
  trigger_use_PrevGap=false;
  ObjectSetInteger(0,"button_trigger_use_PrevGap",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_PrevGap",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_use_PrevGap",OBJPROP_TEXT,"P.G");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_PrevGap",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
//----------------------------------------------------------------
  if(sparam=="button_trigger_UseHeatMap1" && trigger_UseHeatMap1 ==false)
  {
  trigger_UseHeatMap1 =true;
  ObjectSetInteger(0,"button_trigger_UseHeatMap1",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_UseHeatMap1",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_UseHeatMap1",OBJPROP_TEXT,"HMap");
  Sleep(100);ObjectSetInteger(0,"button_trigger_UseHeatMap1",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_UseHeatMap1" && trigger_UseHeatMap1 ==true)
  {
  trigger_UseHeatMap1=false;
  ObjectSetInteger(0,"button_trigger_UseHeatMap1",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_UseHeatMap1",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_UseHeatMap1",OBJPROP_TEXT,"HMap");
  Sleep(100);ObjectSetInteger(0,"button_trigger_UseHeatMap1",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
//----------------------------------------------------------------
  if(sparam=="button_trigger_UseHeatMap2" && trigger_UseHeatMap2 ==false)
  {
  trigger_UseHeatMap2 =true;
  ObjectSetInteger(0,"button_trigger_UseHeatMap2",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_UseHeatMap2",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_UseHeatMap2",OBJPROP_TEXT,"HMap");
  Sleep(100);ObjectSetInteger(0,"button_trigger_UseHeatMap2",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_UseHeatMap2" && trigger_UseHeatMap2 ==true)
  {
  trigger_UseHeatMap2=false;
  ObjectSetInteger(0,"button_trigger_UseHeatMap2",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_UseHeatMap2",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_UseHeatMap2",OBJPROP_TEXT,"HMap");
  Sleep(100);ObjectSetInteger(0,"button_trigger_UseHeatMap2",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
//+------------------------------------------------------------------+  
if(sparam=="AI_Fibonacci" && AI_Fibonacci ==false)
  {
  AI_Fibonacci =true;
  ObjectSetInteger(0,"AI_Fibonacci",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_Fibonacci",OBJPROP_COLOR,Green);
  ObjectSetString(0,"AI_Fibonacci",OBJPROP_TEXT,"FiboA");
  Sleep(100);ObjectSetInteger(0,"AI_Fibonacci",OBJPROP_STATE,false);
  }
  else if(sparam=="AI_Fibonacci" && AI_Fibonacci ==true)
  {
  AI_Fibonacci=false;
  ObjectSetInteger(0,"AI_Fibonacci",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_Fibonacci",OBJPROP_COLOR,Red);
  ObjectSetString(0,"AI_Fibonacci",OBJPROP_TEXT,"fiboA");
  Sleep(100);ObjectSetInteger(0,"AI_Fibonacci",OBJPROP_STATE,false); 
  }
  //+------------------------------------------------------------------+  
if(sparam=="AI_FibonacciB" && AI_FibonacciB ==false)
  {
  AI_FibonacciB =true;
  ObjectSetInteger(0,"AI_FibonacciB",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_FibonacciB",OBJPROP_COLOR,Green);
  ObjectSetString(0,"AI_FibonacciB",OBJPROP_TEXT,"FiboB");
  Sleep(100);ObjectSetInteger(0,"AI_FibonacciB",OBJPROP_STATE,false);
  }
  else if(sparam=="AI_FibonacciB" && AI_FibonacciB ==true)
  {
  AI_FibonacciB=false;
  ObjectSetInteger(0,"AI_FibonacciB",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_FibonacciB",OBJPROP_COLOR,Red);
  ObjectSetString(0,"AI_FibonacciB",OBJPROP_TEXT,"fiboB");
  Sleep(100);ObjectSetInteger(0,"AI_FibonacciB",OBJPROP_STATE,false); 
  }
  //+------------------------------------------------------------------+  
if(sparam=="AI_FibonacciC" && AI_FibonacciC ==false)
  {
  AI_FibonacciC =true;
  ObjectSetInteger(0,"AI_FibonacciC",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_FibonacciC",OBJPROP_COLOR,Green);
  ObjectSetString(0,"AI_FibonacciC",OBJPROP_TEXT,"FiboC");
  Sleep(100);ObjectSetInteger(0,"AI_FibonacciC",OBJPROP_STATE,false);
  }
  else if(sparam=="AI_FibonacciC" && AI_FibonacciC ==true)
  {
  AI_FibonacciC=false;
  ObjectSetInteger(0,"AI_FibonacciC",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_FibonacciC",OBJPROP_COLOR,Red);
  ObjectSetString(0,"AI_FibonacciC",OBJPROP_TEXT,"fiboC");
  Sleep(100);ObjectSetInteger(0,"AI_FibonacciC",OBJPROP_STATE,false); 
  }
  //+------------------------------------------------------------------+  
if(sparam=="AI_Stochastic1" && AI_Stochastic1 ==false)
  {
  AI_Stochastic1 =true;
  ObjectSetInteger(0,"AI_Stochastic1",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_Stochastic1",OBJPROP_COLOR,Green);
  ObjectSetString(0,"AI_Stochastic1",OBJPROP_TEXT,"Sto 1");
  Sleep(100);ObjectSetInteger(0,"AI_Stochastic1",OBJPROP_STATE,false);
  }
  else if(sparam=="AI_Stochastic1" && AI_Stochastic1 ==true)
  {
  AI_Stochastic1=false;
  ObjectSetInteger(0,"AI_Stochastic1",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_Stochastic1",OBJPROP_COLOR,Red);
  ObjectSetString(0,"AI_Stochastic1",OBJPROP_TEXT,"Sto 1");
  Sleep(100);ObjectSetInteger(0,"AI_Stochastic1",OBJPROP_STATE,false); 
  }
  //+------------------------------------------------------------------+
  if(sparam=="AI_Stochastic2" && AI_Stochastic2 ==false)
  {
  AI_Stochastic2 =true;
  ObjectSetInteger(0,"AI_Stochastic2",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_Stochastic2",OBJPROP_COLOR,Green);
  ObjectSetString(0,"AI_Stochastic2",OBJPROP_TEXT,"Sto 2");
  Sleep(100);ObjectSetInteger(0,"AI_Stochastic2",OBJPROP_STATE,false);
  }
  else if(sparam=="AI_Stochastic2" && AI_Stochastic2 ==true)
  {
  AI_Stochastic2=false;
  ObjectSetInteger(0,"AI_Stochastic2",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_Stochastic2",OBJPROP_COLOR,Red);
  ObjectSetString(0,"AI_Stochastic2",OBJPROP_TEXT,"Sto 2");
  Sleep(100);ObjectSetInteger(0,"AI_Stochastic2",OBJPROP_STATE,false); 
  }
  //+------------------------------------------------------------------+  
  if(sparam=="AI_Stochastic3" && AI_Stochastic3 ==false)
  {
  AI_Stochastic3 =true;
  ObjectSetInteger(0,"AI_Stochastic3",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_Stochastic3",OBJPROP_COLOR,Green);
  ObjectSetString(0,"AI_Stochastic3",OBJPROP_TEXT,"Sto 3");
  Sleep(100);ObjectSetInteger(0,"AI_Stochastic3",OBJPROP_STATE,false);
  }
  else if(sparam=="AI_Stochastic3" && AI_Stochastic3 ==true)
  {
  AI_Stochastic3=false;
  ObjectSetInteger(0,"AI_Stochastic3",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_Stochastic3",OBJPROP_COLOR,Red);
  ObjectSetString(0,"AI_Stochastic3",OBJPROP_TEXT,"Sto 3");
  Sleep(100);ObjectSetInteger(0,"AI_Stochastic3",OBJPROP_STATE,false); 
  }
  //+------------------------------------------------------------------+                
  //+------------------------------------------------------------------+  
if(sparam=="AI_Candle_Direction" && AI_Candle_Direction ==false)
  {
  AI_Candle_Direction =true;
  ObjectSetInteger(0,"AI_Candle_Direction",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_Candle_Direction",OBJPROP_COLOR,Green);
  ObjectSetString(0,"AI_Candle_Direction",OBJPROP_TEXT,"CANDLE");
  Sleep(100);ObjectSetInteger(0,"AI_Candle_Direction",OBJPROP_STATE,false);
  }
  else if(sparam=="AI_Candle_Direction" && AI_Candle_Direction ==true)
  {
  AI_Candle_Direction=false;
  ObjectSetInteger(0,"AI_Candle_Direction",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_Candle_Direction",OBJPROP_COLOR,Red);
  ObjectSetString(0,"AI_Candle_Direction",OBJPROP_TEXT,"CANDLE");
  Sleep(100);ObjectSetInteger(0,"AI_Candle_Direction",OBJPROP_STATE,false); 
  }
//+------------------------------------------------------------------+
  //+------------------------------------------------------------------+  
if(sparam=="AI_Candle_Direction_TF1" && AI_Candle_Direction_TF1 ==false)
  {
  AI_Candle_Direction_TF1 =true;
  ObjectSetInteger(0,"AI_Candle_Direction_TF1",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_Candle_Direction_TF1",OBJPROP_COLOR,Green);
  ObjectSetString(0,"AI_Candle_Direction_TF1",OBJPROP_TEXT,"1");
  Sleep(100);ObjectSetInteger(0,"AI_Candle_Direction_TF1",OBJPROP_STATE,false);
  }
  else if(sparam=="AI_Candle_Direction_TF1" && AI_Candle_Direction_TF1 ==true)
  {
  AI_Candle_Direction_TF1=false;
  ObjectSetInteger(0,"AI_Candle_Direction_TF1",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_Candle_Direction_TF1",OBJPROP_COLOR,Red);
  ObjectSetString(0,"AI_Candle_Direction_TF1",OBJPROP_TEXT,"1");
  Sleep(100);ObjectSetInteger(0,"AI_Candle_Direction_TF1",OBJPROP_STATE,false); 
  }
//+------------------------------------------------------------------+ 
  //+------------------------------------------------------------------+  
if(sparam=="AI_Candle_Direction_TF2" && AI_Candle_Direction_TF2 ==false)
  {
  AI_Candle_Direction_TF2 =true;
  ObjectSetInteger(0,"AI_Candle_Direction_TF2",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_Candle_Direction_TF2",OBJPROP_COLOR,Green);
  ObjectSetString(0,"AI_Candle_Direction_TF2",OBJPROP_TEXT,"2");
  Sleep(100);ObjectSetInteger(0,"AI_Candle_Direction_TF2",OBJPROP_STATE,false);
  }
  else if(sparam=="AI_Candle_Direction_TF2" && AI_Candle_Direction_TF2 ==true)
  {
  AI_Candle_Direction_TF2=false;
  ObjectSetInteger(0,"AI_Candle_Direction_TF2",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_Candle_Direction_TF2",OBJPROP_COLOR,Red);
  ObjectSetString(0,"AI_Candle_Direction_TF2",OBJPROP_TEXT,"2");
  Sleep(100);ObjectSetInteger(0,"AI_Candle_Direction_TF2",OBJPROP_STATE,false); 
  }
//+------------------------------------------------------------------+ 
  //+------------------------------------------------------------------+  
if(sparam=="AI_Candle_Direction_TF3" && AI_Candle_Direction_TF3 ==false)
  {
  AI_Candle_Direction_TF3 =true;
  ObjectSetInteger(0,"AI_Candle_Direction_TF3",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_Candle_Direction_TF3",OBJPROP_COLOR,Green);
  ObjectSetString(0,"AI_Candle_Direction_TF3",OBJPROP_TEXT,"3");
  Sleep(100);ObjectSetInteger(0,"AI_Candle_Direction_TF3",OBJPROP_STATE,false);
  }
  else if(sparam=="AI_Candle_Direction_TF3" && AI_Candle_Direction_TF3 ==true)
  {
  AI_Candle_Direction_TF3=false;
  ObjectSetInteger(0,"AI_Candle_Direction_TF3",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_Candle_Direction_TF3",OBJPROP_COLOR,Red);
  ObjectSetString(0,"AI_Candle_Direction_TF3",OBJPROP_TEXT,"3");
  Sleep(100);ObjectSetInteger(0,"AI_Candle_Direction_TF3",OBJPROP_STATE,false); 
  }
//+------------------------------------------------------------------+ 
  //+------------------------------------------------------------------+  
if(sparam=="AI_Candle_Direction_TF4" && AI_Candle_Direction_TF4 ==false)
  {
  AI_Candle_Direction_TF4 =true;
  ObjectSetInteger(0,"AI_Candle_Direction_TF4",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_Candle_Direction_TF4",OBJPROP_COLOR,Green);
  ObjectSetString(0,"AI_Candle_Direction_TF4",OBJPROP_TEXT,"4");
  Sleep(100);ObjectSetInteger(0,"AI_Candle_Direction_TF4",OBJPROP_STATE,false);
  }
  else if(sparam=="AI_Candle_Direction_TF4" && AI_Candle_Direction_TF4 ==true)
  {
  AI_Candle_Direction_TF4=false;
  ObjectSetInteger(0,"AI_Candle_Direction_TF4",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_Candle_Direction_TF4",OBJPROP_COLOR,Red);
  ObjectSetString(0,"AI_Candle_Direction_TF4",OBJPROP_TEXT,"4");
  Sleep(100);ObjectSetInteger(0,"AI_Candle_Direction_TF4",OBJPROP_STATE,false); 
  }
//+------------------------------------------------------------------+ 
  //+------------------------------------------------------------------+  
if(sparam=="AI_Candle_Direction_TF5" && AI_Candle_Direction_TF5 ==false)
  {
  AI_Candle_Direction_TF5 =true;
  ObjectSetInteger(0,"AI_Candle_Direction_TF5",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_Candle_Direction_TF5",OBJPROP_COLOR,Green);
  ObjectSetString(0,"AI_Candle_Direction_TF5",OBJPROP_TEXT,"5");
  Sleep(100);ObjectSetInteger(0,"AI_Candle_Direction_TF5",OBJPROP_STATE,false);
  }
  else if(sparam=="AI_Candle_Direction_TF5" && AI_Candle_Direction_TF5 ==true)
  {
  AI_Candle_Direction_TF5=false;
  ObjectSetInteger(0,"AI_Candle_Direction_TF5",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_Candle_Direction_TF5",OBJPROP_COLOR,Red);
  ObjectSetString(0,"AI_Candle_Direction_TF5",OBJPROP_TEXT,"5");
  Sleep(100);ObjectSetInteger(0,"AI_Candle_Direction_TF5",OBJPROP_STATE,false); 
  }
//+------------------------------------------------------------------+ 
  //+------------------------------------------------------------------+  
if(sparam=="AI_Candle_Direction_TF6" && AI_Candle_Direction_TF6 ==false)
  {
  AI_Candle_Direction_TF6 =true;
  ObjectSetInteger(0,"AI_Candle_Direction_TF6",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_Candle_Direction_TF6",OBJPROP_COLOR,Green);
  ObjectSetString(0,"AI_Candle_Direction_TF6",OBJPROP_TEXT,"6");
  Sleep(100);ObjectSetInteger(0,"AI_Candle_Direction_TF6",OBJPROP_STATE,false);
  }
  else if(sparam=="AI_Candle_Direction_TF6" && AI_Candle_Direction_TF6 ==true)
  {
  AI_Candle_Direction_TF6=false;
  ObjectSetInteger(0,"AI_Candle_Direction_TF6",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_Candle_Direction_TF6",OBJPROP_COLOR,Red);
  ObjectSetString(0,"AI_Candle_Direction_TF6",OBJPROP_TEXT,"6");
  Sleep(100);ObjectSetInteger(0,"AI_Candle_Direction_TF6",OBJPROP_STATE,false); 
  }
//+------------------------------------------------------------------+ 
  //+------------------------------------------------------------------+  
if(sparam=="AI_Candle_Direction_TF7" && AI_Candle_Direction_TF7 ==false)
  {
  AI_Candle_Direction_TF7 =true;
  ObjectSetInteger(0,"AI_Candle_Direction_TF7",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_Candle_Direction_TF7",OBJPROP_COLOR,Green);
  ObjectSetString(0,"AI_Candle_Direction_TF7",OBJPROP_TEXT,"7");
  Sleep(100);ObjectSetInteger(0,"AI_Candle_Direction_TF7",OBJPROP_STATE,false);
  }
  else if(sparam=="AI_Candle_Direction_TF7" && AI_Candle_Direction_TF7 ==true)
  {
  AI_Candle_Direction_TF7=false;
  ObjectSetInteger(0,"AI_Candle_Direction_TF7",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_Candle_Direction_TF7",OBJPROP_COLOR,Red);
  ObjectSetString(0,"AI_Candle_Direction_TF7",OBJPROP_TEXT,"7");
  Sleep(100);ObjectSetInteger(0,"AI_Candle_Direction_TF7",OBJPROP_STATE,false); 
  }
//+------------------------------------------------------------------+ 
  //+------------------------------------------------------------------+  
if(sparam=="AI_Candle_Direction_TF8" && AI_Candle_Direction_TF8 ==false)
  {
  AI_Candle_Direction_TF8 =true;
  ObjectSetInteger(0,"AI_Candle_Direction_TF8",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_Candle_Direction_TF8",OBJPROP_COLOR,Green);
  ObjectSetString(0,"AI_Candle_Direction_TF8",OBJPROP_TEXT,"8");
  Sleep(100);ObjectSetInteger(0,"AI_Candle_Direction_TF8",OBJPROP_STATE,false);
  }
  else if(sparam=="AI_Candle_Direction_TF8" && AI_Candle_Direction_TF8 ==true)
  {
  AI_Candle_Direction_TF8=false;
  ObjectSetInteger(0,"AI_Candle_Direction_TF8",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_Candle_Direction_TF8",OBJPROP_COLOR,Red);
  ObjectSetString(0,"AI_Candle_Direction_TF8",OBJPROP_TEXT,"8");
  Sleep(100);ObjectSetInteger(0,"AI_Candle_Direction_TF8",OBJPROP_STATE,false); 
  }
//+------------------------------------------------------------------+
  //+------------------------------------------------------------------+  
if(sparam=="AI_Candle_Direction_TF9" && AI_Candle_Direction_TF9 ==false)
  {
  AI_Candle_Direction_TF9 =true;
  ObjectSetInteger(0,"AI_Candle_Direction_TF9",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_Candle_Direction_TF9",OBJPROP_COLOR,Green);
  ObjectSetString(0,"AI_Candle_Direction_TF9",OBJPROP_TEXT,"9");
  Sleep(100);ObjectSetInteger(0,"AI_Candle_Direction_TF9",OBJPROP_STATE,false);
  }
  else if(sparam=="AI_Candle_Direction_TF9" && AI_Candle_Direction_TF9 ==true)
  {
  AI_Candle_Direction_TF9=false;
  ObjectSetInteger(0,"AI_Candle_Direction_TF9",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_Candle_Direction_TF9",OBJPROP_COLOR,Red);
  ObjectSetString(0,"AI_Candle_Direction_TF9",OBJPROP_TEXT,"9");
  Sleep(100);ObjectSetInteger(0,"AI_Candle_Direction_TF9",OBJPROP_STATE,false); 
  }
//+------------------------------------------------------------------+
//----------------------------------------------------------------
  if(sparam=="button_trigger_Candle_DirectionM1" && trigger_Candle_DirectionM1 ==false)
  {
  trigger_Candle_DirectionM1 =true;
  ObjectSetInteger(0,"button_trigger_Candle_DirectionM1",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Candle_DirectionM1",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_Candle_DirectionM1",OBJPROP_TEXT,"CDir");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Candle_DirectionM1",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_Candle_DirectionM1" && trigger_Candle_DirectionM1 ==true)
  {
  trigger_Candle_DirectionM1=false;
  ObjectSetInteger(0,"button_trigger_Candle_DirectionM1",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Candle_DirectionM1",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_Candle_DirectionM1",OBJPROP_TEXT,"CDir");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Candle_DirectionM1",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
//----------------------------------------------------------------
  if(sparam=="button_trigger_Candle_DirectionM5" && trigger_Candle_DirectionM5 ==false)
  {
  trigger_Candle_DirectionM5 =true;
  ObjectSetInteger(0,"button_trigger_Candle_DirectionM5",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Candle_DirectionM5",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_Candle_DirectionM5",OBJPROP_TEXT,"CDir");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Candle_DirectionM5",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_Candle_DirectionM5" && trigger_Candle_DirectionM5 ==true)
  {
  trigger_Candle_DirectionM5=false;
  ObjectSetInteger(0,"button_trigger_Candle_DirectionM5",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Candle_DirectionM5",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_Candle_DirectionM5",OBJPROP_TEXT,"CDir");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Candle_DirectionM5",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
//----------------------------------------------------------------
  if(sparam=="button_trigger_Candle_DirectionM15" && trigger_Candle_DirectionM15 ==false)
  {
  trigger_Candle_DirectionM15 =true;
  ObjectSetInteger(0,"button_trigger_Candle_DirectionM15",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Candle_DirectionM15",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_Candle_DirectionM15",OBJPROP_TEXT,"CDir");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Candle_DirectionM15",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_Candle_DirectionM15" && trigger_Candle_DirectionM15 ==true)
  {
  trigger_Candle_DirectionM15=false;
  ObjectSetInteger(0,"button_trigger_Candle_DirectionM15",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Candle_DirectionM15",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_Candle_DirectionM15",OBJPROP_TEXT,"CDir");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Candle_DirectionM15",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
//----------------------------------------------------------------
  if(sparam=="button_trigger_Candle_DirectionM30" && trigger_Candle_DirectionM30 ==false)
  {
  trigger_Candle_DirectionM30 =true;
  ObjectSetInteger(0,"button_trigger_Candle_DirectionM30",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Candle_DirectionM30",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_Candle_DirectionM30",OBJPROP_TEXT,"CDir");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Candle_DirectionM30",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_Candle_DirectionM30" && trigger_Candle_DirectionM30 ==true)
  {
  trigger_Candle_DirectionM30=false;
  ObjectSetInteger(0,"button_trigger_Candle_DirectionM30",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Candle_DirectionM30",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_Candle_DirectionM30",OBJPROP_TEXT,"CDir");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Candle_DirectionM30",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
//----------------------------------------------------------------
  if(sparam=="button_trigger_Candle_DirectionH1" && trigger_Candle_DirectionH1 ==false)
  {
  trigger_Candle_DirectionH1 =true;
  ObjectSetInteger(0,"button_trigger_Candle_DirectionH1",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Candle_DirectionH1",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_Candle_DirectionH1",OBJPROP_TEXT,"CDir");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Candle_DirectionH1",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_Candle_DirectionH1" && trigger_Candle_DirectionH1 ==true)
  {
  trigger_Candle_DirectionH1=false;
  ObjectSetInteger(0,"button_trigger_Candle_DirectionH1",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Candle_DirectionH1",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_Candle_DirectionH1",OBJPROP_TEXT,"CDir");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Candle_DirectionH1",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
//----------------------------------------------------------------
  if(sparam=="button_trigger_Candle_DirectionH4" && trigger_Candle_DirectionH4 ==false)
  {
  trigger_Candle_DirectionH4 =true;
  ObjectSetInteger(0,"button_trigger_Candle_DirectionH4",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Candle_DirectionH4",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_Candle_DirectionH4",OBJPROP_TEXT,"CDir");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Candle_DirectionH4",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_Candle_DirectionH4" && trigger_Candle_DirectionH4 ==true)
  {
  trigger_Candle_DirectionH4=false;
  ObjectSetInteger(0,"button_trigger_Candle_DirectionH4",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Candle_DirectionH4",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_Candle_DirectionH4",OBJPROP_TEXT,"CDir");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Candle_DirectionH4",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
//----------------------------------------------------------------
  if(sparam=="button_trigger_Candle_DirectionD1" && trigger_Candle_DirectionD1 ==false)
  {
  trigger_Candle_DirectionD1 =true;
  ObjectSetInteger(0,"button_trigger_Candle_DirectionD1",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Candle_DirectionD1",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_Candle_DirectionD1",OBJPROP_TEXT,"CDir");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Candle_DirectionD1",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_Candle_DirectionD1" && trigger_Candle_DirectionD1 ==true)
  {
  trigger_Candle_DirectionD1=false;
  ObjectSetInteger(0,"button_trigger_Candle_DirectionD1",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Candle_DirectionD1",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_Candle_DirectionD1",OBJPROP_TEXT,"CDir");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Candle_DirectionD1",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
//----------------------------------------------------------------
  if(sparam=="button_trigger_Candle_DirectionW1" && trigger_Candle_DirectionW1 ==false)
  {
  trigger_Candle_DirectionW1 =true;
  ObjectSetInteger(0,"button_trigger_Candle_DirectionW1",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Candle_DirectionW1",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_Candle_DirectionW1",OBJPROP_TEXT,"CDir");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Candle_DirectionW1",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_Candle_DirectionW1" && trigger_Candle_DirectionW1 ==true)
  {
  trigger_Candle_DirectionW1=false;
  ObjectSetInteger(0,"button_trigger_Candle_DirectionW1",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_Candle_DirectionW1",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_Candle_DirectionW1",OBJPROP_TEXT,"CDir");
  Sleep(100);ObjectSetInteger(0,"button_trigger_Candle_DirectionW1",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
//+------------------------------------------------------------------+  
if(sparam=="AI_AdrDir" && AI_AdrDir ==false)
  {
  AI_AdrDir =true;
  ObjectSetInteger(0,"AI_AdrDir",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_AdrDir",OBJPROP_COLOR,Green);
  ObjectSetString(0,"AI_AdrDir",OBJPROP_TEXT,"A");
  Sleep(100);ObjectSetInteger(0,"AI_AdrDir",OBJPROP_STATE,false);
  }
  else if(sparam=="AI_AdrDir" && AI_AdrDir ==true)
  {
  AI_AdrDir=false;
  ObjectSetInteger(0,"AI_AdrDir",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_AdrDir",OBJPROP_COLOR,Red);
  ObjectSetString(0,"AI_AdrDir",OBJPROP_TEXT,"A");
  Sleep(100);ObjectSetInteger(0,"AI_AdrDir",OBJPROP_STATE,false); 
  }
//+------------------------------------------------------------------+       
  //+------------------------------------------------------------------+  
if(sparam=="trigger_Moving_Average1" && trigger_Moving_Average1 ==false)
  {
  trigger_Moving_Average1 =true;
  ObjectSetInteger(0,"trigger_Moving_Average1",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"trigger_Moving_Average1",OBJPROP_COLOR,Green);
  ObjectSetString(0,"trigger_Moving_Average1",OBJPROP_TEXT,"MM");
  Sleep(100);ObjectSetInteger(0,"trigger_Moving_Average1",OBJPROP_STATE,false);
  }
  else if(sparam=="trigger_Moving_Average1" && trigger_Moving_Average1 ==true)
  {
  trigger_Moving_Average1=false;
  ObjectSetInteger(0,"trigger_Moving_Average1",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"trigger_Moving_Average1",OBJPROP_COLOR,Red);
  ObjectSetString(0,"trigger_Moving_Average1",OBJPROP_TEXT,"MM");
  Sleep(100);ObjectSetInteger(0,"trigger_Moving_Average1",OBJPROP_STATE,false); 
  }
//+------------------------------------------------------------------+ 
//----------------------------------------------------------------
  if(sparam=="trigger_Moving_Average2" && trigger_Moving_Average2 ==false)//MM12
  {
  trigger_Moving_Average2 =true;
  ObjectSetInteger(0,"trigger_Moving_Average2",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"trigger_Moving_Average2",OBJPROP_COLOR,Green);
  ObjectSetString(0,"trigger_Moving_Average2",OBJPROP_TEXT,"MM");
  Sleep(100);ObjectSetInteger(0,"trigger_Moving_Average2",OBJPROP_STATE,false);
  }
  else if(sparam=="trigger_Moving_Average2" && trigger_Moving_Average2 ==true)
  {
  trigger_Moving_Average2=false;
  ObjectSetInteger(0,"trigger_Moving_Average2",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"trigger_Moving_Average2",OBJPROP_COLOR,Red);
  ObjectSetString(0,"trigger_Moving_Average2",OBJPROP_TEXT,"MM");
  Sleep(100);ObjectSetInteger(0,"trigger_Moving_Average2",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
  if(sparam=="trigger_Moving_Average3" && trigger_Moving_Average3 ==false)//MM12
  {
  trigger_Moving_Average3 =true;
  ObjectSetInteger(0,"trigger_Moving_Average3",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"trigger_Moving_Average3",OBJPROP_COLOR,Green);
  ObjectSetString(0,"trigger_Moving_Average3",OBJPROP_TEXT,"MM");
  Sleep(100);ObjectSetInteger(0,"trigger_Moving_Average3",OBJPROP_STATE,false);
  }
  else if(sparam=="trigger_Moving_Average3" && trigger_Moving_Average3 ==true)
  {
  trigger_Moving_Average3=false;
  ObjectSetInteger(0,"trigger_Moving_Average3",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"trigger_Moving_Average3",OBJPROP_COLOR,Red);
  ObjectSetString(0,"trigger_Moving_Average3",OBJPROP_TEXT,"MM");
  Sleep(100);ObjectSetInteger(0,"trigger_Moving_Average3",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
  //+------------------------------------------------------------------+  
if(sparam=="trigger_use_RSI" && trigger_use_RSI ==false)
  {
  trigger_use_RSI =true;
  ObjectSetInteger(0,"trigger_use_RSI",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"trigger_use_RSI",OBJPROP_COLOR,Green);
  ObjectSetString(0,"trigger_use_RSI",OBJPROP_TEXT,"RSI");
  Sleep(100);ObjectSetInteger(0,"trigger_use_RSI",OBJPROP_STATE,false);
  }
  else if(sparam=="trigger_use_RSI" && trigger_use_RSI ==true)
  {
  trigger_use_RSI=false;
  ObjectSetInteger(0,"trigger_use_RSI",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"trigger_use_RSI",OBJPROP_COLOR,Red);
  ObjectSetString(0,"trigger_use_RSI",OBJPROP_TEXT,"RSI");
  Sleep(100);ObjectSetInteger(0,"trigger_use_RSI",OBJPROP_STATE,false); 
  }
//+------------------------------------------------------------------+ 
  //+------------------------------------------------------------------+  
if(sparam=="AI_RSI_A" && AI_RSI_A ==false)
  {
  AI_RSI_A =true;
  ObjectSetInteger(0,"AI_RSI_A",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_RSI_A",OBJPROP_COLOR,Green);
  ObjectSetString(0,"AI_RSI_A",OBJPROP_TEXT,"RSIA");
  Sleep(100);ObjectSetInteger(0,"AI_RSI_A",OBJPROP_STATE,false);
  }
  else if(sparam=="AI_RSI_A" && AI_RSI_A ==true)
  {
  AI_RSI_A=false;
  ObjectSetInteger(0,"AI_RSI_A",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_RSI_A",OBJPROP_COLOR,Red);
  ObjectSetString(0,"AI_RSI_A",OBJPROP_TEXT,"RSIA");
  Sleep(100);ObjectSetInteger(0,"AI_RSI_A",OBJPROP_STATE,false); 
  }
//+------------------------------------------------------------------+
  //+------------------------------------------------------------------+  
if(sparam=="AI_RSI_B" && AI_RSI_B ==false)
  {
  AI_RSI_B =true;
  ObjectSetInteger(0,"AI_RSI_B",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_RSI_B",OBJPROP_COLOR,Green);
  ObjectSetString(0,"AI_RSI_B",OBJPROP_TEXT,"RSIB");
  Sleep(100);ObjectSetInteger(0,"AI_RSI_B",OBJPROP_STATE,false);
  }
  else if(sparam=="AI_RSI_B" && AI_RSI_B ==true)
  {
  AI_RSI_B=false;
  ObjectSetInteger(0,"AI_RSI_B",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_RSI_B",OBJPROP_COLOR,Red);
  ObjectSetString(0,"AI_RSI_B",OBJPROP_TEXT,"RSIB");
  Sleep(100);ObjectSetInteger(0,"AI_RSI_B",OBJPROP_STATE,false); 
  }
//+------------------------------------------------------------------+
  //+------------------------------------------------------------------+  
if(sparam=="AI_RSI_C" && AI_RSI_C ==false)
  {
  AI_RSI_C =true;
  ObjectSetInteger(0,"AI_RSI_C",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_RSI_C",OBJPROP_COLOR,Green);
  ObjectSetString(0,"AI_RSI_C",OBJPROP_TEXT,"RSIC");
  Sleep(100);ObjectSetInteger(0,"AI_RSI_C",OBJPROP_STATE,false);
  }
  else if(sparam=="AI_RSI_C" && AI_RSI_C ==true)
  {
  AI_RSI_C=false;
  ObjectSetInteger(0,"AI_RSI_C",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_RSI_C",OBJPROP_COLOR,Red);
  ObjectSetString(0,"AI_RSI_C",OBJPROP_TEXT,"RSIC");
  Sleep(100);ObjectSetInteger(0,"AI_RSI_C",OBJPROP_STATE,false); 
  }
//+------------------------------------------------------------------+  
  //+------------------------------------------------------------------+  
if(sparam=="AI_CCIA" && AI_CCIA ==false)
  {
  AI_CCIA =true;
  ObjectSetInteger(0,"AI_CCIA",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_CCIA",OBJPROP_COLOR,Green);
  ObjectSetString(0,"AI_CCIA",OBJPROP_TEXT,"CCIA");
  Sleep(100);ObjectSetInteger(0,"AI_CCIA",OBJPROP_STATE,false);
  }
  else if(sparam=="AI_CCIA" && AI_CCIA ==true)
  {
  AI_CCIA=false;
  ObjectSetInteger(0,"AI_CCIA",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_CCIA",OBJPROP_COLOR,Red);
  ObjectSetString(0,"AI_CCIA",OBJPROP_TEXT,"CCIA");
  Sleep(100);ObjectSetInteger(0,"AI_CCIA",OBJPROP_STATE,false); 
  }
//+------------------------------------------------------------------+
  //+------------------------------------------------------------------+  
if(sparam=="AI_CCIB" && AI_CCIB ==false)
  {
  AI_CCIB =true;
  ObjectSetInteger(0,"AI_CCIB",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_CCIB",OBJPROP_COLOR,Green);
  ObjectSetString(0,"AI_CCIB",OBJPROP_TEXT,"CCIB");
  Sleep(100);ObjectSetInteger(0,"AI_CCIB",OBJPROP_STATE,false);
  }
  else if(sparam=="AI_CCIB" && AI_CCIB ==true)
  {
  AI_CCIB=false;
  ObjectSetInteger(0,"AI_CCIB",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_CCIB",OBJPROP_COLOR,Red);
  ObjectSetString(0,"AI_CCIB",OBJPROP_TEXT,"CCIB");
  Sleep(100);ObjectSetInteger(0,"AI_CCIB",OBJPROP_STATE,false); 
  }
//+------------------------------------------------------------------+ 
  //+------------------------------------------------------------------+  
if(sparam=="AI_CCIC" && AI_CCIC ==false)
  {
  AI_CCIC =true;
  ObjectSetInteger(0,"AI_CCIC",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_CCIC",OBJPROP_COLOR,Green);
  ObjectSetString(0,"AI_CCIC",OBJPROP_TEXT,"CCIC");
  Sleep(100);ObjectSetInteger(0,"AI_CCIC",OBJPROP_STATE,false);
  }
  else if(sparam=="AI_CCIC" && AI_CCIC ==true)
  {
  AI_CCIC=false;
  ObjectSetInteger(0,"AI_CCIC",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_CCIC",OBJPROP_COLOR,Red);
  ObjectSetString(0,"AI_CCIC",OBJPROP_TEXT,"CCIC");
  Sleep(100);ObjectSetInteger(0,"AI_CCIC",OBJPROP_STATE,false); 
  }
//+------------------------------------------------------------------+  
  //+------------------------------------------------------------------+  
if(sparam=="trigger_CCI" && trigger_CCI ==false)
  {
  trigger_CCI =true;
  ObjectSetInteger(0,"trigger_CCI",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"trigger_CCI",OBJPROP_COLOR,Green);
  ObjectSetString(0,"trigger_CCI",OBJPROP_TEXT,"CCI");
  Sleep(100);ObjectSetInteger(0,"trigger_CCI",OBJPROP_STATE,false);
  }
  else if(sparam=="trigger_CCI" && trigger_CCI ==true)
  {
  trigger_CCI=false;
  ObjectSetInteger(0,"trigger_CCI",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"trigger_CCI",OBJPROP_COLOR,Red);
  ObjectSetString(0,"trigger_CCI",OBJPROP_TEXT,"CCI");
  Sleep(100);ObjectSetInteger(0,"trigger_CCI",OBJPROP_STATE,false); 
  }
//+------------------------------------------------------------------+ 
  //+------------------------------------------------------------------+  
if(sparam=="AI_MACD" && AI_MACD ==false)
  {
  AI_MACD =true;
  ObjectSetInteger(0,"AI_MACD",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_MACD",OBJPROP_COLOR,Green);
  ObjectSetString(0,"AI_MACD",OBJPROP_TEXT,"MACD");
  Sleep(100);ObjectSetInteger(0,"AI_MACD",OBJPROP_STATE,false);
  }
  else if(sparam=="AI_MACD" && AI_MACD ==true)
  {
  AI_MACD=false;
  ObjectSetInteger(0,"AI_MACD",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_MACD",OBJPROP_COLOR,Red);
  ObjectSetString(0,"AI_MACD",OBJPROP_TEXT,"MACD");
  Sleep(100);ObjectSetInteger(0,"AI_MACD",OBJPROP_STATE,false); 
  }
//+------------------------------------------------------------------+
  //+------------------------------------------------------------------+  
if(sparam=="trigger_MACD1" && trigger_MACD1 ==false)
  {
  trigger_MACD1 =true;
  ObjectSetInteger(0,"trigger_MACD1",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"trigger_MACD1",OBJPROP_COLOR,Green);
  ObjectSetString(0,"trigger_MACD1",OBJPROP_TEXT,"MACD");
  Sleep(100);ObjectSetInteger(0,"trigger_MACD1",OBJPROP_STATE,false);
  }
  else if(sparam=="trigger_MACD1" && trigger_MACD1 ==true)
  {
  trigger_MACD1=false;
  ObjectSetInteger(0,"trigger_MACD1",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"trigger_MACD1",OBJPROP_COLOR,Red);
  ObjectSetString(0,"trigger_MACD1",OBJPROP_TEXT,"MACD");
  Sleep(100);ObjectSetInteger(0,"trigger_MACD1",OBJPROP_STATE,false); 
  }
//+------------------------------------------------------------------+
//----------------------------------------------------------------
  if(sparam=="button_trigger_use_Strength" && trigger_use_Strength ==false)//USD
  {
  trigger_use_Strength =true;
  ObjectSetInteger(0,"button_trigger_use_Strength",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_Strength",OBJPROP_COLOR,Green);
  ObjectSetString(0,"button_trigger_use_Strength",OBJPROP_TEXT,"Strenght");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_Strength",OBJPROP_STATE,false);
  }
  else if(sparam=="button_trigger_use_Strength" && trigger_use_Strength ==true)
  {
  trigger_use_Strength=false;
  ObjectSetInteger(0,"button_trigger_use_Strength",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"button_trigger_use_Strength",OBJPROP_COLOR,Red);
  ObjectSetString(0,"button_trigger_use_Strength",OBJPROP_TEXT,"Strenght");
  Sleep(100);ObjectSetInteger(0,"button_trigger_use_Strength",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
//----------------------------------------------------------------
  if(sparam=="AI_ADX" && AI_ADX ==false)//USD
  {
  AI_ADX =true;
  ObjectSetInteger(0,"AI_ADX",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_ADX",OBJPROP_COLOR,Green);
  ObjectSetString(0,"AI_ADX",OBJPROP_TEXT,"ADX");
  Sleep(100);ObjectSetInteger(0,"AI_ADX",OBJPROP_STATE,false);
  }
  else if(sparam=="AI_ADX" && AI_ADX ==true)
  {
  AI_ADX=false;
  ObjectSetInteger(0,"AI_ADX",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_ADX",OBJPROP_COLOR,Red);
  ObjectSetString(0,"AI_ADX",OBJPROP_TEXT,"ADX");
  Sleep(100);ObjectSetInteger(0,"AI_ADX",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
//----------------------------------------------------------------
  if(sparam=="AI_ATR" && AI_ATR ==false)//USD
  {
  AI_ATR =true;
  ObjectSetInteger(0,"AI_ATR",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_ATR",OBJPROP_COLOR,Green);
  ObjectSetString(0,"AI_ATR",OBJPROP_TEXT,"ATR");
  Sleep(100);ObjectSetInteger(0,"AI_ATR",OBJPROP_STATE,false);
  }
  else if(sparam=="AI_ATR" && AI_ATR ==true)
  {
  AI_ATR=false;
  ObjectSetInteger(0,"AI_ATR",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_ATR",OBJPROP_COLOR,Red);
  ObjectSetString(0,"AI_ATR",OBJPROP_TEXT,"ATR");
  Sleep(100);ObjectSetInteger(0,"AI_ATR",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
//----------------------------------------------------------------
  if(sparam=="AI_WILL" && AI_WILL ==false)//USD
  {
  AI_WILL =true;
  ObjectSetInteger(0,"AI_WILL",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_WILL",OBJPROP_COLOR,Green);
  ObjectSetString(0,"AI_WILL",OBJPROP_TEXT,"Williams");
  Sleep(100);ObjectSetInteger(0,"AI_WILL",OBJPROP_STATE,false);
  }
  else if(sparam=="AI_WILL" && AI_WILL ==true)
  {
  AI_WILL=false;
  ObjectSetInteger(0,"AI_WILL",OBJPROP_BGCOLOR,Black);
  ObjectSetInteger(0,"AI_WILL",OBJPROP_COLOR,Red);
  ObjectSetString(0,"AI_WILL",OBJPROP_TEXT,"Williams");
  Sleep(100);ObjectSetInteger(0,"AI_WILL",OBJPROP_STATE,false);
  }
//----------------------------------------------------------------
//----------------------------------------------------------------
//BOTAO LOTES
if(sparam==button_increase_lot)
  {
  lot+=lotStep;
  ObjectSetInteger(0,sparam,OBJPROP_STATE,0);
  return;
  }
  if(sparam==button_decrease_lot)
  {
  if(lot>lotStep) lot-=lotStep;
  ObjectSetInteger(0,sparam,OBJPROP_STATE,0);
  return;
  }
//BOTAO LOTES 
//BOTAO STOPSPIP
if(sparam==button_increase_Piptp)
  {
  Piptp+=PiptpStep;
  ObjectSetInteger(0,sparam,OBJPROP_STATE,0);
  return;
  }
  if(sparam==button_decrease_Piptp)
  {
  if(Piptp>PiptpStep) Piptp-=PiptpStep;
  ObjectSetInteger(0,sparam,OBJPROP_STATE,0);
  return;
  }
//----------------------------------------------------------------
  if(sparam==button_increase_Pipsl)
  {
  Pipsl+=PipslStep;
  ObjectSetInteger(0,sparam,OBJPROP_STATE,0);
  return;
  }
  if(sparam==button_decrease_Pipsl)
  {
  if(Pipsl>PipslStep) Pipsl-=PipslStep;
  ObjectSetInteger(0,sparam,OBJPROP_STATE,0);
  return;
  }
//BOTAO STOPSPIP
//BOTAO STOPSADR
if(sparam==button_increase_Adr1tp)
  {
  Adr1tp+=Adr1tpStep;
  ObjectSetInteger(0,sparam,OBJPROP_STATE,0);
  return;
  }
  if(sparam==button_decrease_Adr1tp)
  {
  if(Adr1tp>Adr1tpStep) Adr1tp-=Adr1tpStep;
  ObjectSetInteger(0,sparam,OBJPROP_STATE,0);
  return;
  }
//---  
  if(sparam==button_increase_Adr1sl)
  {
  Adr1sl+=Adr1slStep;
  ObjectSetInteger(0,sparam,OBJPROP_STATE,0);
  return;
  }
  if(sparam==button_decrease_Adr1sl)
  {
  if(Adr1sl>Adr1slStep) Adr1sl-=Adr1slStep;
  ObjectSetInteger(0,sparam,OBJPROP_STATE,0);
  return;
  }
//BOTAO STOPSADR  
//-----------------------------------------------------------------------------------------------------------------   
      {
       if (sparam==button_AUD_basket_buy)
        {          
               buy_basket(AUD);
               sell_basket(AUD_R);
               ObjectSetInteger(0,button_AUD_basket_buy,OBJPROP_STATE,0);
               return;
        }
//-----------------------------------------------------------------------------------------------------------------  
      if (sparam==button_AUD_basket_sell)
        {          
               sell_basket(AUD);
               buy_basket(AUD_R);
               ObjectSetInteger(0,button_AUD_basket_sell,OBJPROP_STATE,0);
               return;
        }
//-----------------------------------------------------------------------------------------------------------------  
      if (sparam==button_CAD_basket_buy)
        {          
               buy_basket(CAD);
               sell_basket(CAD_R);
               ObjectSetInteger(0,button_CAD_basket_buy,OBJPROP_STATE,0);
               return;
        }
//-----------------------------------------------------------------------------------------------------------------  
      if (sparam==button_CAD_basket_sell)
        {          
               sell_basket(CAD);
               buy_basket(CAD_R);
               ObjectSetInteger(0,button_CAD_basket_sell,OBJPROP_STATE,0);
               return;
        }
//-----------------------------------------------------------------------------------------------------------------
      if (sparam==button_CHF_basket_buy)
        {          
               buy_basket(CHF);
               sell_basket(CHF_R);
               ObjectSetInteger(0,button_CHF_basket_buy,OBJPROP_STATE,0);
               return;
        }
//-----------------------------------------------------------------------------------------------------------------  
      if (sparam==button_CHF_basket_sell)
        {          
               sell_basket(CHF);
               buy_basket(CHF_R);
               ObjectSetInteger(0,button_CHF_basket_sell,OBJPROP_STATE,0);
               return;
        }
//-----------------------------------------------------------------------------------------------------------------
      if (sparam==button_EUR_basket_buy)
        {          
               buy_basket(EUR);
               ObjectSetInteger(0,button_EUR_basket_buy,OBJPROP_STATE,0);
               return;
        }
//-----------------------------------------------------------------------------------------------------------------  
      if (sparam==button_EUR_basket_sell)
        {          
               sell_basket(EUR);
               ObjectSetInteger(0,button_EUR_basket_sell,OBJPROP_STATE,0);
               return;
        }
//-----------------------------------------------------------------------------------------------------------------
      if (sparam==button_GBP_basket_buy)
        {          
               buy_basket(GBP);
               sell_basket(GBP_R);
               ObjectSetInteger(0,button_GBP_basket_buy,OBJPROP_STATE,0);
               return;
        }
//-----------------------------------------------------------------------------------------------------------------  
      if (sparam==button_GBP_basket_sell)
        {          
               sell_basket(GBP);
               buy_basket(GBP_R);
               ObjectSetInteger(0,button_GBP_basket_sell,OBJPROP_STATE,0);
               return;
        }
//-----------------------------------------------------------------------------------------------------------------
      if (sparam==button_JPY_basket_buy)
        {          
               sell_basket(JPY_R);
               ObjectSetInteger(0,button_JPY_basket_buy,OBJPROP_STATE,0);
               return;
        }
//-----------------------------------------------------------------------------------------------------------------  
      if (sparam==button_JPY_basket_sell)
        {          
               buy_basket(JPY_R);
               ObjectSetInteger(0,button_JPY_basket_sell,OBJPROP_STATE,0);
               return;
        }
//-----------------------------------------------------------------------------------------------------------------
      if (sparam==button_NZD_basket_buy)
        {          
               buy_basket(NZD);
               sell_basket(NZD_R);
               ObjectSetInteger(0,button_NZD_basket_buy,OBJPROP_STATE,0);
               return;
        }
//-----------------------------------------------------------------------------------------------------------------  
      if (sparam==button_NZD_basket_sell)
        {          
               sell_basket(NZD);
               buy_basket(NZD_R);
               ObjectSetInteger(0,button_NZD_basket_sell,OBJPROP_STATE,0);
               return;
        }
//-----------------------------------------------------------------------------------------------------------------
      if (sparam==button_USD_basket_buy)
        {          
               buy_basket(USD);
               sell_basket(USD_R);
               ObjectSetInteger(0,button_USD_basket_buy,OBJPROP_STATE,0);
               return;
        }
//-----------------------------------------------------------------------------------------------------------------  
      if (sparam==button_USD_basket_sell)
        {          
               sell_basket(USD);
               buy_basket(USD_R);
               ObjectSetInteger(0,button_USD_basket_sell,OBJPROP_STATE,0);
               return;
        }
//-----------------------------------------------------------------------------------------------------------------
      if (sparam==button_AUD_basket_close)
        {          
               close_cur_basket(AUD);
               close_cur_basket(AUD_R);
               ObjectSetInteger(0,button_AUD_basket_close,OBJPROP_STATE,0);
               return;
        }
//----------------------------------------------------------------------------------------------------------------- 
      if (sparam==button_CAD_basket_close)
        {          
               close_cur_basket(CAD);
               close_cur_basket(CAD_R);
               ObjectSetInteger(0,button_CAD_basket_close,OBJPROP_STATE,0);
               return;
        }
//----------------------------------------------------------------------------------------------------------------- 
      if (sparam==button_CHF_basket_close)
        {          
               close_cur_basket(CHF);
               close_cur_basket(CHF_R);
               ObjectSetInteger(0,button_CHF_basket_close,OBJPROP_STATE,0);
               return;
        }
//----------------------------------------------------------------------------------------------------------------- 
      if (sparam==button_EUR_basket_close)
        {          
               close_cur_basket(EUR);
               ObjectSetInteger(0,button_EUR_basket_close,OBJPROP_STATE,0);
               return;
        }
//----------------------------------------------------------------------------------------------------------------- 
      if (sparam==button_GBP_basket_close)
        {          
               close_cur_basket(GBP);
               close_cur_basket(GBP_R);
               ObjectSetInteger(0,button_GBP_basket_close,OBJPROP_STATE,0);
               return;
        }
//----------------------------------------------------------------------------------------------------------------- 
      if (sparam==button_JPY_basket_close)
        {          
               close_cur_basket(JPY_R);
               ObjectSetInteger(0,button_JPY_basket_close,OBJPROP_STATE,0);
               return;
        }
//----------------------------------------------------------------------------------------------------------------- 
      if (sparam==button_NZD_basket_close)
        {          
               close_cur_basket(NZD);
               close_cur_basket(NZD_R);
               ObjectSetInteger(0,button_NZD_basket_close,OBJPROP_STATE,0);
               return;
        }
//----------------------------------------------------------------------------------------------------------------- 
      if (sparam==button_USD_basket_close)
        {          
               close_cur_basket(USD);
               close_cur_basket(USD_R);
               ObjectSetInteger(0,button_USD_basket_close,OBJPROP_STATE,0);
               return;
        }
//----------------------------------------------------------------------------------------------------------------- 
      if (sparam==button_reset_ea)
        {          
               Reset_EA();
               ObjectSetInteger(0,button_reset_ea,OBJPROP_STATE,0);
               return;
        }
//----------------------------------------------------------------------------------------------------------------- 
      if (sparam==button_increase_basket_tp)
        {          
               Basket_Target ++;
               SetText("TPr","B TP =$ "+DoubleToString(Basket_Target,0),x_axis+924,y_axis-91,Yellow,7);
               ObjectSetInteger(0,button_increase_basket_tp,OBJPROP_STATE,0);
               return;
        }
//----------------------------------------------------------------------------------------------------------------- 
      if (sparam==button_increase_basket_sl)
        {          
               Basket_StopLoss ++;
               SetText("SL","B SL =$ -"+DoubleToString(Basket_StopLoss,0),x_axis+1000,y_axis-91,Yellow,7);
               ObjectSetInteger(0,button_increase_basket_sl,OBJPROP_STATE,0);
               return;
        }
//-----------------------------------------------------------------------------------------------------------------
      if (sparam==button_decrease_basket_tp)
        {          
               Basket_Target --;
               SetText("TPr","B TP =$ "+DoubleToString(Basket_Target,0),x_axis+924,y_axis-91,Yellow,7);
               ObjectSetInteger(0,button_decrease_basket_tp,OBJPROP_STATE,0);
               return;
        }
//-----------------------------------------------------------------------------------------------------------------
      if (sparam==button_decrease_basket_sl)
        {          
               Basket_StopLoss --;
               SetText("SL","B SL =$ -"+DoubleToString(Basket_StopLoss,0),x_axis+1000,y_axis-91,Yellow,7);
               ObjectSetInteger(0,button_decrease_basket_sl,OBJPROP_STATE,0);
               return;
        }
//-----------------------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------
      if (sparam==button_close_basket_All)
        {
               ObjectSetString(0,button_close_basket_All,OBJPROP_TEXT,"Closing...");               
               close_basket(Magic_Number);
               ObjectSetInteger(0,button_close_basket_All,OBJPROP_STATE,0);
               ObjectSetString(0,button_close_basket_All,OBJPROP_TEXT,"Close Basket"); 
               return;
        }
//-----------------------------------------------------------------------------------------------------------------     
      if (sparam==button_close_basket_Prof)
        {
               ObjectSetString(0,button_close_basket_Prof,OBJPROP_TEXT,"Closing...");               
               close_profit();
               ObjectSetInteger(0,button_close_basket_Prof,OBJPROP_STATE,0);
               ObjectSetString(0,button_close_basket_Prof,OBJPROP_TEXT,"Close Basket"); 
               return;
        }
//----------------------------------------------------------------------------------------------------------------- 
      if (sparam==button_close_basket_Loss)
        {
               ObjectSetString(0,button_close_basket_Loss,OBJPROP_TEXT,"Closing...");               
               close_loss();
               ObjectSetInteger(0,button_close_basket_Loss,OBJPROP_STATE,0);
               ObjectSetString(0,button_close_basket_Loss,OBJPROP_TEXT,"Close Basket"); 
               return;
        }
//-----------------------------------------------------------------------------------------------------------------
     if (StringFind(sparam,"BUY") >= 0)
        {
               int ind = StringToInteger(sparam);
               ticket=OrderSend(TradePairs[ind],OP_BUY,lot,MarketInfo(TradePairs[ind],MODE_ASK),100,0,0,"OFF",Magic_Number,0,Blue);
               if (OrderSelect(ticket,SELECT_BY_TICKET) == true) {
                  if (Pipsl != 0.0)
                           stoploss=OrderOpenPrice() - Pipsl * pairinfo[ind].PairPip;
                        else
                           if (Adr1sl != 0.0)
                              stoploss=OrderOpenPrice() - ((adrvalues[ind].adr10/100)*Adr1sl) * pairinfo[ind].PairPip;
                           else
                              stoploss = 0.0;

                        if (Piptp != 0.0)
                              takeprofit=OrderOpenPrice() + Piptp * pairinfo[ind].PairPip;
                        else
                           if (Adr1tp != 0.0)
                              takeprofit=OrderOpenPrice() + ((adrvalues[ind].adr10/100)*Adr1tp) * pairinfo[ind].PairPip;
                           else
                              takeprofit = 0.0;
                  OrderModify(ticket,OrderOpenPrice(),NormalizeDouble(stoploss,MarketInfo(TradePairs[ind],MODE_DIGITS)),NormalizeDouble(takeprofit,MarketInfo(TradePairs[ind],MODE_DIGITS)),0,clrBlue);
               }
               ObjectSetInteger(0,ind+"BUY",OBJPROP_STATE,0);
               ObjectSetString(0,ind+"BUY",OBJPROP_TEXT,"BUY"); 
               return;
        }
     if (StringFind(sparam,"SELL") >= 0)
        {
               int ind = StringToInteger(sparam);
               ticket=OrderSend(TradePairs[ind],OP_SELL,lot,MarketInfo(TradePairs[ind],MODE_BID),100,0,0,"OFF",Magic_Number,0,Red);
               if (OrderSelect(ticket,SELECT_BY_TICKET) == true) {
                   if (Pipsl != 0.0)
                              stoploss=OrderOpenPrice() + Pipsl * pairinfo[ind].PairPip;
                           else
                              if (Adr1sl != 0.0)
                                 stoploss=OrderOpenPrice()+((adrvalues[ind].adr10/100)*Adr1sl)  *pairinfo[ind].PairPip;
                              else
                                 stoploss = 0.0;
                                 
                                 
                           if (Piptp != 0.0)
                              takeprofit=OrderOpenPrice() - Piptp * pairinfo[ind].PairPip;
                           else 
                              if (Adr1tp != 0.0)
                                 takeprofit=OrderOpenPrice() - ((adrvalues[ind].adr10/100)*Adr1tp) * pairinfo[ind].PairPip;
                              else
                                 takeprofit = 0.0;
                  OrderModify(ticket,OrderOpenPrice(),NormalizeDouble(stoploss,MarketInfo(TradePairs[ind],MODE_DIGITS)),NormalizeDouble(takeprofit,MarketInfo(TradePairs[ind],MODE_DIGITS)),0,clrBlue);
               }
               ObjectSetInteger(0,ind+"SELL",OBJPROP_STATE,0);
               ObjectSetString(0,ind+"SELL",OBJPROP_TEXT,"SELL");
               return;
        }
     if (StringFind(sparam,"CLOSE") >= 0)
        {
               int ind = StringToInteger(sparam);
               closeOpenOrders(TradePairs[ind]);               
               ObjectSetInteger(0,ind+"CLOSE",OBJPROP_STATE,0);
               ObjectSetString(0,ind+"CLOSE",OBJPROP_TEXT,"CLOSE");
               return;
        }
         
      if (StringFind(sparam,"Pair") >= 0) {
         int ind = StringToInteger(sparam);
         ObjectSetInteger(0,sparam,OBJPROP_STATE,0);
         OpenChart(ind);
         return;         
      }   
     }
}
void buy_basket(string &pairs[])
{
   int i;
   int ticket;
   
   for(i=0;i<ArraySize(pairs);i++)
   {
      ticket=OrderSend(pairs[i],OP_BUY,lot,MarketInfo(pairs[i],MODE_ASK),100,0,0,NULL,Magic_Number,0,clrNONE);
      if (OrderSelect(ticket,SELECT_BY_TICKET) == true) {
                  if (Pipsl != 0.0)
                           stoploss=OrderOpenPrice() - Pipsl * pairinfo[i].PairPip;
                        else
                           if (Adr1sl != 0.0)
                              stoploss=OrderOpenPrice() - ((adrvalues[i].adr10/100)*Adr1sl) * pairinfo[i].PairPip;
                           else
                              stoploss = 0.0;

                        if (Piptp != 0.0)
                              takeprofit=OrderOpenPrice() + Piptp * pairinfo[i].PairPip;
                        else
                           if (Adr1tp != 0.0)
                              takeprofit=OrderOpenPrice() + ((adrvalues[i].adr10/100)*Adr1tp) * pairinfo[i].PairPip;
                           else
                              takeprofit = 0.0;
                  OrderModify(ticket,OrderOpenPrice(),NormalizeDouble(stoploss,MarketInfo(pairs[i],MODE_DIGITS)),NormalizeDouble(takeprofit,MarketInfo(pairs[i],MODE_DIGITS)),0,clrBlue);
   }
  }
}

void sell_basket(string &pairs[])
{
   int i;
   int ticket;
   
   for(i=0;i<ArraySize(pairs);i++)
   {
      ticket=OrderSend(pairs[i],OP_SELL,lot,MarketInfo(pairs[i],MODE_BID),100,0,0,NULL,Magic_Number,0,clrNONE);
      if (OrderSelect(ticket,SELECT_BY_TICKET) == true) {
                   if (Pipsl != 0.0)
                              stoploss=OrderOpenPrice() + Pipsl * pairinfo[i].PairPip;
                           else
                              if (Adr1sl != 0.0)
                                 stoploss=OrderOpenPrice()+((adrvalues[i].adr10/100)*Adr1sl)  *pairinfo[i].PairPip;
                              else
                                 stoploss = 0.0;
                                 
                                 
                           if (Piptp != 0.0)
                              takeprofit=OrderOpenPrice() - Piptp * pairinfo[i].PairPip;
                           else 
                              if (Adr1tp != 0.0)
                                 takeprofit=OrderOpenPrice() - ((adrvalues[i].adr10/100)*Adr1tp) * pairinfo[i].PairPip;
                              else
                                 takeprofit = 0.0;
                  OrderModify(ticket,OrderOpenPrice(),NormalizeDouble(stoploss,MarketInfo(pairs[i],MODE_DIGITS)),NormalizeDouble(takeprofit,MarketInfo(pairs[i],MODE_DIGITS)),0,clrBlue);
   }
  }
}

void close_cur_basket(string &pairs[])
{ 
  
   if (OrdersTotal() <= 0)
   return;

   int TradeList[][2];
   int ctTrade = 0;

   for (int i=0; i<OrdersTotal(); i++) 
   {
	   OrderSelect(i, SELECT_BY_POS);
      if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)==true &&
         (OrderType()==0 || OrderType()==1) && 
         OrderMagicNumber()==Magic_Number &&
         InArray(pairs, OrderSymbol())) 
      {
	      ctTrade++;
		   ArrayResize(TradeList, ctTrade);
		   TradeList[ctTrade-1][0] = OrderOpenTime();
		   TradeList[ctTrade-1][1] = OrderTicket();
	   }
   }
   ArraySort(TradeList,WHOLE_ARRAY,0,MODE_ASCEND);

   for (int i=0;i<ctTrade;i++) 
   {
       if (OrderSelect(TradeList[i][1], SELECT_BY_TICKET)==true) 
       {
            if (OrderType()==0)
               {
               ticket=OrderClose(OrderTicket(),OrderLots(), MarketInfo(OrderSymbol(),MODE_BID), 100, clrNONE);
               if (ticket==-1) Print ("Error: ",  GetLastError());
               
               }
            if (OrderType()==1)
               {
               ticket=OrderClose(OrderTicket(),OrderLots(), MarketInfo(OrderSymbol(),MODE_ASK), 100, clrNONE);
               if (ticket==-1) Print ("Error: ",  GetLastError());
               
               }  
         }
         Sleep(500);
   }
      
}
//+------------------------------------------------------------------+
//| closeOpenOrders                                                  |
//+------------------------------------------------------------------+
void closeOpenOrders(string closecurr ) {
   int cnt = 0;

   for (cnt = OrdersTotal()-1 ; cnt >= 0 ; cnt--) {
      if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES)==true) {
         if(OrderType()==OP_BUY && OrderSymbol() == closecurr && OrderMagicNumber()==Magic_Number)
            ticket=OrderClose(OrderTicket(),OrderLots(),MarketInfo(OrderSymbol(),MODE_BID),5,Violet);
         else if(OrderType()==OP_SELL && OrderSymbol() == closecurr && OrderMagicNumber()==Magic_Number) 
            ticket=OrderClose(OrderTicket(),OrderLots(),MarketInfo(OrderSymbol(),MODE_ASK),5,Violet);
         else if(OrderType()>OP_SELL) //pending orders
            ticket=OrderDelete(OrderTicket());
                   
      }
   }
}
void close_basket(int magic_number)
{ 
  
if (OrdersTotal() <= 0)
   return;

int TradeList[][2];
int ctTrade = 0;

for (int i=0; i<OrdersTotal(); i++) {
	OrderSelect(i, SELECT_BY_POS);
   if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)==true && (OrderType()==0 || OrderType()==1) && OrderMagicNumber()==Magic_Number) {
	   ctTrade++;
		ArrayResize(TradeList, ctTrade);
		TradeList[ctTrade-1][0] = OrderOpenTime();
		TradeList[ctTrade-1][1] = OrderTicket();
	}
}
ArraySort(TradeList,WHOLE_ARRAY,0,MODE_ASCEND);

for (int i=0;i<ctTrade;i++) {
      
       if (OrderSelect(TradeList[i][1], SELECT_BY_TICKET)==true) {
            if (OrderType()==0)
               {
               ticket=OrderClose(OrderTicket(),OrderLots(), MarketInfo(OrderSymbol(),MODE_BID), 3,Red);
               if (ticket==-1) Print ("Error: ",  GetLastError());
               
               }
            if (OrderType()==1)
               {
               ticket=OrderClose(OrderTicket(),OrderLots(), MarketInfo(OrderSymbol(),MODE_ASK), 3,Red);
               if (ticket==-1) Print ("Error: ",  GetLastError());
               
               }  
            }
      }
  
   for (int i=0;i<ArraySize(TradePairs);i++)
      pairinfo[i].lastSignal = NOTHING; 
       
   currentlock = 0.0;
   trailstarted = false;   
   lockdistance = 0.0;    
   SymbolMaxDD = 0;
   SymbolMaxHi = 0;
   PercentFloatingSymbol=0;
   PercentMaxDDSymbol=0;    
}
void close_profit()
{
 int cnt = 0; 
 for (cnt = OrdersTotal()-1 ; cnt >= 0 ; cnt--)
            {
               if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES)==true)
               if (OrderProfit() > 0)
               {
                  if(OrderType()==OP_BUY && OrderMagicNumber()==Magic_Number)
                     ticket=OrderClose(OrderTicket(),OrderLots(),MarketInfo(OrderSymbol(),MODE_BID),5,Violet);
                  if(OrderType()==OP_SELL && OrderMagicNumber()==Magic_Number) 
                     ticket=OrderClose(OrderTicket(),OrderLots(),MarketInfo(OrderSymbol(),MODE_ASK),5,Violet);
                  if(OrderType()>OP_SELL)
                     ticket=OrderDelete(OrderTicket());
               }
            } 
    }
void close_loss()
{
 int cnt = 0; 
 for (cnt = OrdersTotal()-1 ; cnt >= 0 ; cnt--)
            {
               if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES)==true)
               if (OrderProfit() < 0)
               {
                  if(OrderType()==OP_BUY && OrderMagicNumber()==Magic_Number)
                     ticket=OrderClose(OrderTicket(),OrderLots(),MarketInfo(OrderSymbol(),MODE_BID),5,Violet);
                  if(OrderType()==OP_SELL && OrderMagicNumber()==Magic_Number) 
                     ticket=OrderClose(OrderTicket(),OrderLots(),MarketInfo(OrderSymbol(),MODE_ASK),5,Violet);
                  if(OrderType()>OP_SELL)
                     ticket=OrderDelete(OrderTicket());
               }
            } 
    } 

void Reset_EA()
{
   currentlock = 0.0;
   trailstarted = false;   
   lockdistance = 0.0;    
   SymbolMaxDD = 0;
   SymbolMaxHi = 0;
   PercentFloatingSymbol=0;
   PercentMaxDDSymbol=0;
  
   OnInit();
}
                               
//+------------------------------------------------------------------+
void Trades()
{
   int i, j;
   totallots=0;
   totalprofit=0;
   totaltrades = 0;

   for(i=0;i<ArraySize(TradePairs);i++)
   {
      
      bpos[i]=0;
      spos[i]=0;       
      blots[i]=0;
      slots[i]=0;     
      tmp_bpips[i]=0;
      tmp_spips[i]=0; 
      bprofit[i]=0;
      sprofit[i]=0;
      tprofit[i]=0;
   }
	for(i=0;i<OrdersTotal();i++)
	{
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false)
         break;

      for(j=0;j<ArraySize(TradePairs);j++)
      {	  
         if((TradePairs[j]==OrderSymbol() || TradePairs[j]=="") && OrderMagicNumber()==Magic_Number)
         {
            TradePairs[j]=OrderSymbol();                       
            tprofit[j]=tprofit[j]+OrderProfit()+OrderSwap()+OrderCommission();
           if(OrderType()==0){ bprofit[j]+=OrderProfit()+OrderSwap()+OrderCommission(); } 
           if(OrderType()==1){ sprofit[j]+=OrderProfit()+OrderSwap()+OrderCommission(); } 
           if(OrderType()==0){ blots[j]+=OrderLots(); } 
           if(OrderType()==1){ slots[j]+=OrderLots(); }
           if(OrderType()==0){ bpos[j]+=+1; } 
           if(OrderType()==1){ spos[j]+=+1; } 
                                
            totallots=totallots+OrderLots();
            totaltrades++;
            totalprofit = totalprofit+OrderProfit()+OrderSwap()+OrderCommission();
            if(OrderType()==0){ tmp_bpips[j]+=+(MarketInfo(OrderSymbol(),MODE_BID)-OrderOpenPrice())/(MarketInfo(OrderSymbol(),MODE_POINT)); } 
            if(OrderType()==1){ tmp_spips[j]+=+(OrderOpenPrice()-MarketInfo(OrderSymbol(),MODE_ASK))/(MarketInfo(OrderSymbol(),MODE_POINT)); }                      
            tmp_tpips[j]=tmp_tpips[j]+tmp_bpips[j]+tmp_spips[j];
            break;
  }
  }//End For
  }//End Order Total
  totalpips=0;
  for(int x=0;x<ArraySize(TradePairs);x++){
  bpips[x]=tmp_bpips[x];
  spips[x]=tmp_spips[x];
  tpips[x]=tmp_tpips[x];
  totalpips=totalpips+tmp_tpips[x];
  }//End For x

  PlotTrades();
  }
void Trades2()
{    
   if(OrdersTotal()==0)
      SetText("CTP","Sem Trades",x_axis+864,y_axis-66,Yellow,8);
   else
      SetText("CTP","Monitor de Trades",x_axis+864,y_axis-66,Yellow,8);

   if (inSession() == true)
      SetText("CTPT","Trading",x_axis+816,y_axis-67,Green,8);
   else
      SetText("CTPT","Closed",x_axis+816,y_axis-67,Red,8);
//         SetPanel("TP6",0,x_axis+95,y_axis-50,100,20,Black,White,1);

   }
//+------------------------------------------------------------------+ 

void OpenChart(int ind) {
long nextchart = ChartFirst();
   do {
      string sym = ChartSymbol(nextchart);
      if (StringFind(sym,TradePairs[ind]) >= 0) {
            ChartSetInteger(nextchart,CHART_BRING_TO_TOP,true);
            ChartSetSymbolPeriod(nextchart,TradePairs[ind],TimeFrame);
            ChartApplyTemplate(nextchart,usertemplate);
            return;
         }
   } while ((nextchart = ChartNext(nextchart)) != -1);
   long newchartid = ChartOpen(TradePairs[ind],TimeFrame);
   ChartApplyTemplate(newchartid,usertemplate);
 }
//+------------------------------------------------------------------+  

void TradeManager() {

   double AccBalance=AccountBalance();
         
      //- Target
      if(Basket_Target>0 && totalprofit>=Basket_Target) {
         profitbaskets++;
         close_basket(Magic_Number);
         return;
      }
      
      //- StopLoss
      if(Basket_StopLoss>0 && totalprofit<(0-Basket_StopLoss)) {
         lossbaskets++;
         close_basket(Magic_Number);
         return;
      }

      //- Out off session
      if(inSession() == false && totallots > 0.0 && CloseAllSession == true) {
         close_basket(Magic_Number);
         return;
      }

      //- Profit lock stoploss
      if (currentlock != 0.0 && totalprofit < currentlock) {
         profitbaskets++;
         close_basket(Magic_Number);
         return;
      }

      //- Profit lock trail
      if (trailstarted == true && totalprofit > currentlock + lockdistance)
         currentlock = totalprofit - lockdistance;

      //- Lock in profit 1
      if (BasketP1 != 0.0 && BasketL1 != 0.0 && currentlock < BasketL1) {
         if (totalprofit > BasketP1)
            currentlock = BasketL1;
         if (BasketP2 == 0.0 && TrailLastLock == true) {
            trailstarted = true;
            if (TrailDistance != 0.0)
               lockdistance = BasketP1 - TrailDistance;
            else
               lockdistance = BasketL1;
         }
      }
      //- Lock in profit 2
      if (BasketP2 != 0.0 && BasketL2 != 0.0 && currentlock < BasketL2) {
         if (totalprofit > BasketP2)
            currentlock = BasketL2;
         if (BasketP3 == 0.0 && TrailLastLock == true) {
            trailstarted = true;
            if (TrailDistance != 0.0)
               lockdistance = BasketP2 - TrailDistance;
            else
               lockdistance = BasketL2;
         }
      }
      //- Lock in profit 3
      if (BasketP3 != 0.0 && BasketL3 != 0.0 && currentlock < BasketL3) {
         if (totalprofit > BasketP3)
            currentlock = BasketL3;
         if (BasketP4 == 0.0 && TrailLastLock == true) {
            trailstarted = true;
            if (TrailDistance != 0.0)
               lockdistance = BasketP3 - TrailDistance;
            else
               lockdistance = BasketL3;
         }
      }
      //- Lock in profit 4
      if (BasketP4 != 0.0 && BasketL4 != 0.0 && currentlock < BasketL4) {
         if (totalprofit > BasketP4)
            currentlock = BasketL4;
         if (BasketP5 == 0.0 && TrailLastLock == true) {
            trailstarted = true;
            if (TrailDistance != 0.0)
               lockdistance = BasketP4 - TrailDistance;
            else
               lockdistance = BasketL4;
         }
      }
      //- Lock in profit 5
      if (BasketP5 != 0.0 && BasketL5 != 0.0 && currentlock < BasketL5) {
         if (totalprofit > BasketP5)
            currentlock = BasketL5;
         if (BasketP6 == 0.0 && TrailLastLock == true) {
            trailstarted = true;
            if (TrailDistance != 0.0)
               lockdistance = BasketP5 - TrailDistance;
            else
               lockdistance = BasketL5;
         }
      }
      //- Lock in profit 6
      if (BasketP6 != 0.0 && BasketL6 != 0.0 && currentlock < BasketL6) {
         if (totalprofit > BasketP6)
            currentlock = BasketL6;
         if (TrailLastLock == true) {
            trailstarted = true;
            if (TrailDistance != 0.0)
               lockdistance = BasketP6 - TrailDistance;
            else
               lockdistance = BasketL6;
         }
      }


     if(totalprofit<=SymbolMaxDD) {
        SymbolMaxDD=totalprofit;
        GetBalanceSymbol=AccBalance;
     }

     if(GetBalanceSymbol != 0)
      PercentMaxDDSymbol=(SymbolMaxDD*100)/GetBalanceSymbol;
     
     if(totalprofit>=SymbolMaxHi) {
        SymbolMaxHi=totalprofit;
        GetBalanceSymbol=AccBalance;
     }
     
     if(GetBalanceSymbol != 0)
      PercentFloatingSymbol=(SymbolMaxHi*100)/GetBalanceSymbol;

     ObjectSetText("Lowest","Lowest= "+DoubleToStr(SymbolMaxDD,2)+" ("+DoubleToStr(PercentMaxDDSymbol,2)+"%)",8,NULL,BearColor);
     ObjectSetText("Highest","Highest= "+DoubleToStr(SymbolMaxHi,2)+" ("+DoubleToStr(PercentFloatingSymbol,2)+"%)",8,NULL,BullColor);
     ObjectSetText("Lock","Lock= "+DoubleToStr(currentlock,2),8,NULL,BullColor);
     ObjectSetText("Won",IntegerToString(profitbaskets,2),8,NULL,BullColor);
     ObjectSetText("Lost",IntegerToString(lossbaskets,2),8,NULL,BearColor);

}
//----------------------------------------------------------------
//SIGNAL USD
void SetColors(int i) 
  {
  if(signals[i].Signalm1USD==1)  {Color=BBullColor;}
  if(signals[i].Signalm1USD==-1) {Color=BBearColor;}
  if(signals[i].Signalm5USD==1)  {Color1=BBullColor;}         
  if(signals[i].Signalm5USD==-1) {Color1 =BBearColor;}
  if(signals[i].Signalm15USD==1) {Color2 =BBullColor;}
  if(signals[i].Signalm15USD==-1){Color2=BBearColor;}
  if(signals[i].Signalm30USD==1) {Color3=BBullColor;}
  if(signals[i].Signalm30USD==-1){Color3=BBearColor;}
  if(signals[i].Signalh1USD==1)  {Color4=BBullColor;}
  if(signals[i].Signalh1USD==-1) {Color4=BBearColor;}
  if(signals[i].Signalh4USD==1)  {Color5=BBullColor;}
  if(signals[i].Signalh4USD==-1) {Color5=BBearColor;}
  if(signals[i].Signald1USD==1)  {Color6=BBullColor;}
  if(signals[i].Signald1USD==-1) {Color6=BBearColor;}
  if(signals[i].Signalw1USD==1)  {Color7=BBullColor;}
  if(signals[i].Signalw1USD==-1) {Color7=BBearColor;}
  if(signals[i].SignalmnUSD==1)  {Color8=BBullColor;}
  if(signals[i].SignalmnUSD==-1) {Color8=BBearColor;}
  if(signals[i].Signalusd>0)  {Color9=BBullColor;}
  if(signals[i].Signalusd<0)  {Color9=BBearColor;}
  if(signals[i].SignalpercUSD>0) {Color1=BBullColor;}
  if(signals[i].SignalpercUSD<0) {Color1=BBearColor;}
  
  if(signals[i].Signalusd>0)  {Color9=BBullColor;}
  if(signals[i].Signalusd<0)  {Color9=BBearColor;}
  if(signals[i].SignalpercUSD>0) {Color1=BBullColor;}
  if(signals[i].SignalpercUSD<0) {Color1=BBearColor;}
  
  if(signals[i].Signalusd>0.0)labelcolor1USD=BBullColor;     
  else if(signals[i].Signalusd<0.0)labelcolor1USD=BBearColor;
  if(signals[i].Signalusd>10.0)labelcolor3USD=BBullColor;     
  else if(signals[i].Signalusd<-10.0)labelcolor3USD=BBearColor;
  else labelcolor3USD=C'20,20,20'; 
  if(signals[i].Signalusd>20.0)labelcolor4USD=BBullColor;     
  else if(signals[i].Signalusd<-20.0)labelcolor4USD=BBearColor;
  else labelcolor4USD=C'20,20,20';  
  if(signals[i].Signalusd>30.0)labelcolor5USD=BBullColor;     
  else if(signals[i].Signalusd<-30.0)labelcolor5USD=BBearColor;
  else labelcolor5USD=C'20,20,20'; 
  if(signals[i].Signalusd>40.0)labelcolor6USD=BBullColor;     
  else if(signals[i].Signalusd<-40.0)labelcolor6USD=BBearColor;
  else labelcolor6USD=C'20,20,20'; 
  if(signals[i].Signalusd>50.0)labelcolor7USD=BBullColor;     
  else if(signals[i].Signalusd<-50.0)labelcolor7USD=BBearColor;
  else labelcolor7USD=C'20,20,20'; 
  if(signals[i].Signalusd>60.0)labelcolor8USD=BBullColor;     
  else if(signals[i].Signalusd<-60.0)labelcolor8USD=BBearColor;
  else labelcolor8USD=C'20,20,20'; 
  if(signals[i].Signalusd>70.0)labelcolor9USD=BBullColor;     
  else if(signals[i].Signalusd<-70.0)labelcolor9USD=BBearColor;
  else labelcolor9USD=C'20,20,20'; 
  if(signals[i].Signalusd>80.0)labelcolor10USD=BBullColor;     
  else if(signals[i].Signalusd<-80.0)labelcolor10USD=BBearColor;
  else labelcolor10USD=C'20,20,20';  
  if(signals[i].Signalusd>90.0)labelcolor11USD=BBullColor;     
  else if(signals[i].Signalusd<-90.0)labelcolor11USD=BBearColor;
  else labelcolor11USD=C'20,20,20';    
}
//----------------------------------------------------------------        
void PlotTrades() {

   for (int i=0; i<ArraySize(TradePairs);i++) {
//ADR SIG
   double D1H=iHigh(TradePairs[i],PERIOD_D1,1),D1L=iLow(TradePairs[i],PERIOD_D1,1);
   double ADR32=D1L+(D1H-D1L)*0.32,ADR68=D1L+(D1H-D1L)*0.68; color wclr = C'61,61,61';  
   if(signals[i].close>ADR68 && signals[i].close>signals[i].open){wclr = clrDodgerBlue;}  
   if(signals[i].close<ADR32 && signals[i].close<signals[i].open){wclr = C'255,140,255';}
   SetObjText("xADRatio"+IntegerToString(i),CharToStr(108),x_axis+100,(i*11)+y_axis-34,wclr,8);
//ADR SIG

     if(blots[i]>0){LotColor =Orange;}        
     if(blots[i]==0){LotColor =C'61,61,61';}
     if(slots[i]>0){LotColor1 =Orange;}        
     if(slots[i]==0){LotColor1 =C'61,61,61';}
     if(bpos[i]>0){OrdColor =DodgerBlue;}        
     if(bpos[i]==0){OrdColor =C'61,61,61';}
     if(spos[i]>0){OrdColor1 =DodgerBlue;}        
     if(spos[i]==0){OrdColor1 =C'61,61,61';}
     if(bprofit[i]>0){ProfitColor =BullColor;}
     if(bprofit[i]<0){ProfitColor =BearColor;}
     if(bprofit[i]==0){ProfitColor =C'61,61,61';}
     if(sprofit[i]>0){ProfitColor2 =BullColor;}
     if(sprofit[i]<0){ProfitColor2 =BearColor;}
     if(sprofit[i]==0){ProfitColor2 =C'61,61,61';}
     if(tprofit[i]>0){ProfitColor3 =BullColor;}
     if(tprofit[i]<0){ProfitColor3 =BearColor;}
     if(tprofit[i]==0){ProfitColor3 =C'61,61,61';}

     if(totalprofit>0){ProfitColor1 =BullColor;}
     if(totalprofit<0){ProfitColor1 =BearColor;}
     if(totalprofit==0){ProfitColor1 =clrWhite;}         

     ObjectSetText("bLots"+IntegerToString(i),DoubleToStr(blots[i],2),7,NULL,LotColor);
     ObjectSetText("sLots"+IntegerToString(i),DoubleToStr(slots[i],2),7,NULL,LotColor1);
     ObjectSetText("bPos"+IntegerToString(i),DoubleToStr(bpos[i],0),7,NULL,OrdColor);
     ObjectSetText("sPos"+IntegerToString(i),DoubleToStr(spos[i],0),7,NULL,OrdColor1);
     ObjectSetText("TProf"+IntegerToString(i),DoubleToStr(MathAbs(bprofit[i]),2),7,NULL,ProfitColor);
     ObjectSetText("SProf"+IntegerToString(i),DoubleToStr(MathAbs(sprofit[i]),2),7,NULL,ProfitColor2);
     ObjectSetText("Textsbprof"+IntegerToString(i),DoubleToStr(bpips[i]/10,1),7,NULL,ProfitColor);
     ObjectSetText("Textsprof"+IntegerToString(i),DoubleToStr(spips[i]/10,1),7,NULL,ProfitColor2);
     ObjectSetText("TtlProf"+IntegerToString(i),DoubleToStr(MathAbs(tprofit[i]),2),7,NULL,ProfitColor3);
     ObjectSetText("TotProf",DoubleToStr(MathAbs(totalprofit),2),10,NULL,ProfitColor1);
  if(bpos[i]+spos[i]!=0){
      EditButton(IntegerToString(i)+"Pair",StringSubstr(TradePairs[i],0,7),ProfitColor3,clrBlack);
     }else{
      EditButton(IntegerToString(i)+"Pair",StringSubstr(TradePairs[i],0,7),clrSilver,clrBlack); 
     }
     if(bpos[i]+spos[i]!=0){
      EditButton(IntegerToString(i)+"PairPerc",StringSubstr(TradePairs[i],0,7),ProfitColor3,clrBlack);
     }else{
      EditButton(IntegerToString(i)+"PairPerc",StringSubstr(TradePairs[i],0,7),clrSilver,clrBlack); 
     }
     if(bpos[i]+spos[i]!=0){
      EditButton(IntegerToString(i)+"Pair2",StringSubstr(TradePairs[i],0,7),ProfitColor3,clrBlack);
     }else{
      EditButton(IntegerToString(i)+"Pair2",StringSubstr(TradePairs[i],0,7),clrSilver,clrBlack); 
     }
} 
  //}
  }
void PlotAdrValues() {

   for (int i=0;i<ArraySize(TradePairs);i++)
     ObjectSetText("S1"+IntegerToString(i),DoubleToStr(adrvalues[i].adr,0),7,NULL,Yellow);
}
bool inSession() {
 
   if ((localday != TimeDayOfWeek(TimeLocal()) && s1active == false && s2active == false && s3active == false) || localday == 99) {
      TimeToStruct(TimeLocal(),sess);
      StringSplit(sess1start,':',strspl);sess.hour=(int)strspl[0];sess.min=(int)strspl[1];sess.sec=0;
      s1start = StructToTime(sess);
      StringSplit(sess1end,':',strspl);sess.hour=(int)strspl[0];sess.min=(int)strspl[1];sess.sec=0;
      s1end = StructToTime(sess);
      StringSplit(sess2start,':',strspl);sess.hour=(int)strspl[0];sess.min=(int)strspl[1];sess.sec=0;
      s2start = StructToTime(sess);
      StringSplit(sess2end,':',strspl);sess.hour=(int)strspl[0];sess.min=(int)strspl[1];sess.sec=0;
      s2end = StructToTime(sess);
      StringSplit(sess3start,':',strspl);sess.hour=(int)strspl[0];sess.min=(int)strspl[1];sess.sec=0;
      s3start = StructToTime(sess);
      StringSplit(sess3end,':',strspl);sess.hour=(int)strspl[0];sess.min=(int)strspl[1];sess.sec=0;
      s3end = StructToTime(sess);
      if (s1end < s1start)
         s1end += 24*60*60;
      if (s2end < s2start)
         s2end += 24*60*60;
      if (s3end < s3start)
         s3end += 24*60*60;
      newSession();
      localday = TimeDayOfWeek(TimeLocal());
      Print("Sessions for today");
      if (UseSession1 == true)
         Print("Session 1 From:"+s1start+" until "+s1end);
      if (UseSession2 == true)
         Print("Session 2 From:"+s2start+" until "+s2end);
      if (UseSession3 == true)
         Print("Session 3 From:"+s3start+" until "+s3end);
   }


   if (UseSession1 && TimeLocal() >= s1start && TimeLocal() <= s1end) {
      comment = sess1comment;
      if (s1active == false)
         newSession();         
      else if ((StopProfit != 0 && profitbaskets >= StopProfit) || (StopLoss != 0 && lossbaskets >= StopLoss))
         return(false);
      s1active = true;
      return(true);
   } else {
      s1active = false;
   }   
   if (UseSession2 && TimeLocal() >= s2start && TimeLocal() <= s2end) {
      comment = sess2comment;
      if (s2active == false)
         newSession();
      else if ((StopProfit != 0 && profitbaskets >= StopProfit) || (StopLoss != 0 && lossbaskets >= StopLoss))
         return(false);
      s2active = true;
      return(true);
   } else {
      s2active = false;
   }
   if (UseSession3 && TimeLocal() >= s3start && TimeLocal() <= s3end) {
      comment = sess3comment;
      if (s3active == false)
         newSession();
      else if ((StopProfit != 0 && profitbaskets >= StopProfit) || (StopLoss != 0 && lossbaskets >= StopLoss))
         return(false);
      s3active = true;
      return(true);
   } else {
      s3active = false;
   }
   
   return(false);
}
void newSession() {
   
   profitbaskets = 0;
   lossbaskets = 0;
   SymbolMaxDD = 0.0;
   PercentMaxDDSymbol = 0.0;
   SymbolMaxHi=0.0;
   PercentFloatingSymbol = 0.0;
   currentlock = 0.0;
   trailstarted = false;   
   lockdistance = 0.0;
}

//-----------------------------------------------------------------------------
void ChngBoxCol(int mVal, int mBx)
 {
   if(mVal >= 0 && mVal < 10)
         ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, White);
   if(mVal > 10 && mVal < 20)
         ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, LightCyan);
   if(mVal > 20 && mVal < 30)
         ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, PowderBlue);
   if(mVal > 30 && mVal < 40)
         ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, PaleTurquoise);
   if(mVal > 40 && mVal < 50)
         ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, LightBlue);
   if(mVal > 50 && mVal < 60)
         ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, SkyBlue);
   if(mVal > 60 && mVal < 70)
         ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, Turquoise);
   if(mVal > 70 && mVal < 80)
         ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, DeepSkyBlue);
   if(mVal > 80 && mVal < 90)
         ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, SteelBlue);
   if(mVal > 90 && mVal < 100)
         ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, Blue);
   if(mVal > 100)
         ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, MediumBlue);

   if(mVal < 0 && mVal > -10)
         ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, White);
   if(mVal < -10 && mVal > -20)
         ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, Seashell);
   if(mVal < -20 && mVal > -30)
         ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, MistyRose);
   if(mVal < -30 && mVal > -40)
         ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, Pink);
   if(mVal < -40 && mVal > -50)
         ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, LightPink);
   if(mVal < -50 && mVal > -60)
         ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, Plum);
   if(mVal < -60 && mVal >-70)
         ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, Violet);
   if(mVal < -70 && mVal > -80)
         ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, Orchid);
   if(mVal < -80 && mVal > -90)
         ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, DeepPink);
   if(mVal < -90)
         ObjectSet("HM1"+mBx, OBJPROP_BGCOLOR, Red);
   return;
 }
//-----------------------------------------------------------------------------
//----------------------------------------------------------------
void ChngBoxCol1(int mVal1, int mBx1)
  {
  if(mVal1 >= 0 && mVal1 < 10)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, White);
  if(mVal1 > 10 && mVal1 < 20)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, LightCyan);
  if(mVal1 > 20 && mVal1 < 30)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, PowderBlue);
  if(mVal1 > 30 && mVal1 < 40)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, PaleTurquoise);
  if(mVal1 > 40 && mVal1 < 50)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, LightBlue);
  if(mVal1 > 50 && mVal1 < 60)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, SkyBlue);
  if(mVal1 > 60 && mVal1 < 70)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, Turquoise);
  if(mVal1 > 70 && mVal1 < 80)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, DeepSkyBlue);
  if(mVal1 > 80 && mVal1 < 90)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, SteelBlue);
  if(mVal1 > 90 && mVal1 < 100)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, Blue);
  if(mVal1 > 100)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, MediumBlue);

  if(mVal1 < 0 && mVal1 > -10)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, White);
  if(mVal1 < -10 && mVal1 > -20)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, Seashell);
  if(mVal1 < -20 && mVal1 > -30)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, MistyRose);
  if(mVal1 < -30 && mVal1 > -40)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, Pink);
  if(mVal1 < -40 && mVal1 > -50)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, LightPink);
  if(mVal1 < -50 && mVal1 > -60)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, Plum);
  if(mVal1 < -60 && mVal1 >-70)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, Violet);
  if(mVal1 < -70 && mVal1 > -80)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, Orchid);
  if(mVal1 < -80 && mVal1 > -90)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, DeepPink);
  if(mVal1 < -90)
  ObjectSet("HM2"+mBx1, OBJPROP_BGCOLOR, Red);
  return;
  }
//----------------------------------------------------------------
//+------------------------------------------------------------------+
void GethUSD() {

  for (int i=0;i<ArraySize(TradePairs);i++) {
  signals[i].prevSignalusd = signals[i].Signalusd; 
     
  double high   = iHigh(TradePairs[i],trigger_TF_Strength ,0);
  double low    = iLow(TradePairs[i],trigger_TF_Strength ,0);
  double close  = iClose(TradePairs[i],trigger_TF_Strength ,0);
  double open   = iOpen(TradePairs[i],trigger_TF_Strength ,0);
  double point  = MarketInfo(TradePairs[i],MODE_POINT);
  double range  = (high-low)*point;
  
  if (range*point > 0.0) {
  if (open>close)
  signals[i].Signalusd = MathMin((high-close)/range*point/ (-0.01),100);
  else
  signals[i].Signalusd = MathMin((close-low)/range*point*100,100);                                           
  } else {
  signals[i].Signalusd = signals[i].prevSignalusd;
  }
  }
  }
  //}
  //}
  //}
bool InArray(string &pairs[], string symbol)
{
   int arraysize = ArraySize(pairs);
   if(arraysize <= 0) return(false);
   if(symbol == NULL) return(false);
   
   int i;
   
   for(i=0;i<arraysize;i++)
      if(pairs[i] == symbol) return(true);

   return(false);
}
//-------------------------------------------------------------------+ 
void PlotSpreadPips() {
             
   for (int i=0;i<ArraySize(TradePairs);i++) {
      if(MarketInfo(TradePairs[i],MODE_POINT) != 0 && pairinfo[i].pipsfactor != 0) {
       pairinfo[i].Pips = (iClose(TradePairs[i],PERIOD_PIP,0)-iOpen(TradePairs[i], PERIOD_PIP,0))/MarketInfo(TradePairs[i],MODE_POINT)/pairinfo[i].pipsfactor; 
       pairinfo[i].Pipsprev = (iClose(TradePairs[i],PERIOD_PIP,signals[i].shift+900)-iOpen(TradePairs[i], PERIOD_PIP,0))/MarketInfo(TradePairs[i],MODE_POINT)/pairinfo[i].pipsfactor;    
       pairinfo[i].Spread=MarketInfo(TradePairs[i],MODE_SPREAD)/pairinfo[i].pipsfactor;
       if(iClose(TradePairs[i], trigger_TF_HM1, 1)!=0){
       signals[i].Signalperc = (iClose(TradePairs[i], 1, 0) - iClose(TradePairs[i], trigger_TF_HM1, 1)) / iClose(TradePairs[i], trigger_TF_HM1, 1) * 100;
       signals[i].Signalperc1 = (iClose(TradePairs[i], 1, 0) - iClose(TradePairs[i], trigger_TF_HM2, 1)) / iClose(TradePairs[i], trigger_TF_HM2, 1) * 100;
       }    
      }  
     if(pairinfo[i].Pips>0){PipsColor =BBullColor;}
     if(pairinfo[i].Pips<0){PipsColor =BBearColor;} 
     if(pairinfo[i].Pips==0){PipsColor =NeutroColor;}       
     if(pairinfo[i].Spread > MaxSpread)
     
     ObjectSetText("Spr1"+IntegerToString(i),DoubleToStr(pairinfo[i].Spread,1),7,NULL,Red);
     else
      ObjectSetText("Spr1"+IntegerToString(i),DoubleToStr(pairinfo[i].Spread,1),7,NULL,Orange);
     ObjectSetText("Pp1"+IntegerToString(i),DoubleToStr(MathAbs(pairinfo[i].Pips),0),7,NULL,PipsColor);
     
     if(pairinfo[i].Pips > pairinfo[i].Pipsprev){
         pairinfo[i].PipsSig=UP;
        } else{
     if(pairinfo[i].Pips < pairinfo[i].Pipsprev)
         pairinfo[i].PipsSig=DOWN;
        }  
      

   }
}
//----------------------------------------------------------------------+
 void GetAdrValues() {

   double s=0.0;

   for (int i=0;i<ArraySize(TradePairs);i++) {

      for(int a=1;a<=20;a++) {
         if(pairinfo[i].PairPip != 0)
            s=s+(iHigh(TradePairs[i],PERIOD_ADR,a)-iLow(TradePairs[i],PERIOD_ADR,a))/pairinfo[i].PairPip;
         if(a==1)
            adrvalues[i].adr1=MathRound(s);
         if(a==5)
            adrvalues[i].adr5=MathRound(s/5);
         if(a==10)
            adrvalues[i].adr10=MathRound(s/10);
         if(a==20)
            adrvalues[i].adr20=MathRound(s/20);
      }
      adrvalues[i].adr=MathRound((adrvalues[i].adr1+adrvalues[i].adr5+adrvalues[i].adr10+adrvalues[i].adr20)/4.0);
      s=0.0;
   }
 }
//----------------------------------------------------------------
void GetSignalsCD() 
  {
  // CANDLE DIRECTION
  //void GetSignals() {
  for (int i=0;i<ArraySize(TradePairs);i++) 
  { // for (int i=0;i<ArraySize(signals);i++) {
  double Openm1    = iOpen(TradePairs[i], trigger_TF_CDM1,0);
  double Closem1   = iClose(TradePairs[i],trigger_TF_CDM1close,0);
  double Openm5    = iOpen(TradePairs[i], trigger_TF_CDM5,0);
  double Closem5   = iClose(TradePairs[i],trigger_TF_CDM5close,0);
  double Openm15   = iOpen(TradePairs[i], trigger_TF_CDM15,0);
  double Closem15  = iClose(TradePairs[i],trigger_TF_CDM15close,0);
  double Openm30   = iOpen(TradePairs[i], trigger_TF_CDM30,0);
  double Closem30  = iClose(TradePairs[i],trigger_TF_CDM30close,0);
  double Openh1    = iOpen(TradePairs[i], trigger_TF_CDH1,0);
  double Closeh1   = iClose(TradePairs[i],trigger_TF_CDH1close,0);      
  double Openh4    = iOpen(TradePairs[i], trigger_TF_CDH4,0);
  double Closeh4   = iClose(TradePairs[i],trigger_TF_CDH4close,0);
  double Opend     = iOpen(TradePairs[i], trigger_TF_CDD1,0);
  double Closed    = iClose(TradePairs[i],trigger_TF_CDD1close,0);
  double Openw     = iOpen(TradePairs[i], trigger_TF_CDW1,0);
  double Closew    = iClose(TradePairs[i],trigger_TF_CDW1close,0);
      
  if(Closem1>Openm1)signals[i].SignalCDm1=UP;
  if(Closem1<Openm1)signals[i].SignalCDm1=DOWN;
  if(Closem5>Openm5)signals[i].SignalCDm5=UP;
  if(Closem5<Openm5)signals[i].SignalCDm5=DOWN;
  if(Closem15>Openm15)signals[i].SignalCDm15=UP;
  if(Closem15<Openm15)signals[i].SignalCDm15=DOWN;
  if(Closem30>Openm30)signals[i].SignalCDm30=UP;
  if(Closem30<Openm30)signals[i].SignalCDm30=DOWN;
  if(Closeh1>Openh1)signals[i].SignalCDh1=UP;
  if(Closeh1<Openh1)signals[i].SignalCDh1=DOWN;
  if(Closeh4>Openh4)signals[i].SignalCDh4=UP;
  if(Closeh4<Openh4)signals[i].SignalCDh4=DOWN;
  if(Closed>Opend)signals[i].SignalCDd1=UP;
  if(Closed<Opend)signals[i].SignalCDd1=DOWN;
  if(Closew>Openw)signals[i].SignalCDw1=UP;
  if(Closew<Openw)signals[i].SignalCDw1=DOWN;

  signals[i].SignaldirupM1=signals[i].SignalCDm1==UP;
  signals[i].SignaldirdnM1=signals[i].SignalCDm1==DOWN;
  signals[i].SignaldirupM5=signals[i].SignalCDm5==UP;
  signals[i].SignaldirdnM5=signals[i].SignalCDm5==DOWN;
  signals[i].SignaldirupM15=signals[i].SignalCDm15==UP;
  signals[i].SignaldirdnM15=signals[i].SignalCDm15==DOWN;
  signals[i].SignaldirupM30=signals[i].SignalCDm30==UP;
  signals[i].SignaldirdnM30=signals[i].SignalCDm30==DOWN;
  signals[i].SignaldirupH1=signals[i].SignalCDh1==UP;
  signals[i].SignaldirdnH1=signals[i].SignalCDh1==DOWN;
  signals[i].SignaldirupH4=signals[i].SignalCDh4==UP;
  signals[i].SignaldirdnH4=signals[i].SignalCDh4==DOWN;
  signals[i].SignaldirupD1=signals[i].SignalCDd1==UP;
  signals[i].SignaldirdnD1=signals[i].SignalCDd1==DOWN;
  signals[i].SignaldirupW1=signals[i].SignalCDw1==UP;
  signals[i].SignaldirdnW1=signals[i].SignalCDw1==DOWN;
  }
  }   
//+------------------------------------------------------------------+
//-----------------------------------------------------------------------------------------------+ 
void GetSignals() {
   int cnt = 0;
   ArrayResize(signals,ArraySize(TradePairs));
   for (int i=0;i<ArraySize(signals);i++) {
      signals[i].symbol=TradePairs[i]; 
      signals[i].point=MarketInfo(signals[i].symbol,MODE_POINT);
      signals[i].open=iOpen(signals[i].symbol,PERIOD_BID,Period_1);      
      signals[i].close=iClose(signals[i].symbol,PERIOD_BID,0);
      signals[i].hi=hi(signals[i].symbol, PERIOD_BID,Period_1,0); 
      signals[i].lo=lo(signals[i].symbol, PERIOD_BID,Period_1,0);
      //signals[i].open=iOpen(signals[i].symbol,PERIOD_BID,0);      
      //signals[i].close=iClose(signals[i].symbol,PERIOD_BID,0);
      //signals[i].hi=MarketInfo(signals[i].symbol,MODE_HIGH);
      //signals[i].lo=MarketInfo(signals[i].symbol,MODE_LOW);
      signals[i].bid=MarketInfo(signals[i].symbol,MODE_BID);
      signals[i].range=(signals[i].hi-signals[i].lo);
      signals[i].shift = iBarShift(signals[i].symbol,PERIOD_M1,TimeCurrent()-900);
      signals[i].prevbid = iClose(signals[i].symbol,PERIOD_M1,signals[i].shift);
      
      signals[i].RSI = RSI_Value(signals[i].symbol);
      signals[i].highRatio=(signals[i].hi - signals[i].bid)/signals[i].point/10;
      signals[i].lowRatio=(signals[i].bid - signals[i].lo)/signals[i].point/10;
             
      if(signals[i].range!=0) {            
      signals[i].ratio=MathMin(((signals[i].bid-signals[i].lo)/signals[i].range*100 ),100);
      signals[i].prevratio=MathMin(((signals[i].prevbid-signals[i].lo)/signals[i].range*100 ),100);     
/*
  //} 
  if(signals[i].open<signals[i].close) 
  {       
  signals[i].range=(signals[i].hi-signals[i].lo)*signals[i].point;      
  signals[i].ratio=MathMin((signals[i].hi-signals[i].close)/signals[i].range*signals[i].point/ (-0.01),100);
  signals[i].calc=signals[i].ratio/(-10);
  }
  else if(signals[i].range !=0 )
  {
  signals[i].range=(signals[i].hi-signals[i].lo)*signals[i].point; 
  signals[i].ratio=MathMin(100*(signals[i].close-signals[i].lo)/signals[i].range*signals[i].point,100);
  signals[i].calc=signals[i].ratio/10;   
  }
*/            
      for (int j = 0; j < 8; j++){
            
      if(signals[i].ratio <= 3.0) signals[i].fact = 0;
      if(signals[i].ratio > 3.0)  signals[i].fact = 1;
      if(signals[i].ratio > 10.0) signals[i].fact = 2;
      if(signals[i].ratio > 25.0) signals[i].fact = 3;
      if(signals[i].ratio > 40.0) signals[i].fact = 4;
      if(signals[i].ratio > 50.0) signals[i].fact = 5;
      if(signals[i].ratio > 60.0) signals[i].fact = 6;
      if(signals[i].ratio > 75.0) signals[i].fact = 7;
      if(signals[i].ratio > 90.0) signals[i].fact = 8;
      if(signals[i].ratio > 97.0) signals[i].fact = 9;
       cnt++;
      
      if(curr[j]==StringSubstr(signals[i].symbol,3,3))
               signals[i].fact=9-signals[i].fact;

      if(curr[j]==StringSubstr(signals[i].symbol,0,3)) {
               signals[i].strength1=signals[i].fact;
              }  else{
      if(curr[j]==StringSubstr(signals[i].symbol,3,3))
               signals[i].strength2=signals[i].fact;
              }

      signals[i].calc =signals[i].strength1-signals[i].strength2;
      
      signals[i].strength=currency_strength(curr[j]);

            if(curr[j]==StringSubstr(signals[i].symbol,0,3)){
               signals[i].strength3=signals[i].strength;
            } else{
            if(curr[j]==StringSubstr(signals[i].symbol,3,3))
               signals[i].strength4=signals[i].strength;
            }
            signals[i].strength5=(signals[i].strength3-signals[i].strength4);
            
       signals[i].strength_old=old_currency_strength(curr[j]);

            if(curr[j]==StringSubstr(signals[i].symbol,0,3)){
               signals[i].strength6=signals[i].strength_old;
            } else {
            if(curr[j]==StringSubstr(signals[i].symbol,3,3))
               signals[i].strength7=signals[i].strength_old;
            }
            signals[i].strength8=(signals[i].strength6-signals[i].strength7);     
            signals[i].strength_Gap=signals[i].strength5-signals[i].strength8;
        
        if(signals[i].ratio>=trigger_buy_bidratio){
               signals[i].SigRatio=UP;
           } else {
         if(signals[i].ratio<=trigger_sell_bidratio)
               signals[i].SigRatio=DOWN;
           }  
        
        if(signals[i].ratio>signals[i].prevratio){
                signals[i].SigRatioPrev=UP;
           } else {
        if(signals[i].ratio<signals[i].prevratio)
                signals[i].SigRatioPrev=DOWN;
           }      
                    
        if(signals[i].calc>=trigger_buy_relstrength){
               signals[i].SigRelStr=UP;
             } else {
        if (signals[i].calc<=trigger_sell_relstrength) 
              signals[i].SigRelStr=DOWN;
             } 
             
         if(signals[i].strength5>=trigger_buy_buysellratio){
               signals[i].SigBSRatio=UP;
             } else {
       if (signals[i].calc<=trigger_sell_buysellratio) 
              signals[i].SigBSRatio=DOWN;
             }       
        
        if(signals[i].strength_Gap>=trigger_gap_buy){
               signals[i].SigGap=UP;
             } else {
        if (signals[i].strength_Gap<=trigger_gap_sell) 
              signals[i].SigGap=DOWN;
             }
              
        if(signals[i].strength5>signals[i].strength8){
              signals[i].SigGapPrev=UP;
             } else {
        if(signals[i].strength5<signals[i].strength8)      
               signals[i].SigGapPrev=DOWN;
               
        if(signals[i].strength8>=trigger_PrevGap_buy){
               signals[i].PrevGap=UP;
             } else {
        if (signals[i].strength8<=trigger_PrevGap_sell) 
              signals[i].PrevGap=DOWN;
             }
        
        if(signals[i].strength5>signals[i].strength8){
              signals[i].PrevGap=UP;
             } else {
        if(signals[i].strength5<signals[i].strength8)      
               signals[i].PrevGap=DOWN;
               
        if(signals[i].RSI>=trigger_buy_RSI){
  signals[i].SigRSI=UP;
  } else {
  if (signals[i].RSI<=trigger_sell_RSI) 
  signals[i].SigRSI=DOWN;
  }        
             }          
      
      }
     
     }
      
    }    

}}
//+------------------------------------------------------------------+ 
//-----------------------------------------------------------------------------------------------+ 
/*void GetSignals() {
   int cnt = 0;
   ArrayResize(signals,ArraySize(TradePairs));
   for (int i=0;i<ArraySize(signals);i++) {
      signals[i].symbol=TradePairs[i]; 
      signals[i].point=MarketInfo(signals[i].symbol,MODE_POINT);
      signals[i].open=iOpen(signals[i].symbol,PERIOD_BID,0);      
      signals[i].close=iClose(signals[i].symbol,PERIOD_BID,0);
      signals[i].hi=MarketInfo(signals[i].symbol,MODE_HIGH);
      signals[i].lo=MarketInfo(signals[i].symbol,MODE_LOW);
      signals[i].bid=MarketInfo(signals[i].symbol,MODE_BID);
      signals[i].range=(signals[i].hi-signals[i].lo);
      signals[i].shift = iBarShift(signals[i].symbol,PERIOD_M1,TimeCurrent()-1800);
      signals[i].prevbid = iClose(signals[i].symbol,PERIOD_M1,signals[i].shift);
      
            signals[i].RSI = RSI_Value(signals[i].symbol);
  signals[i].highRatio=(signals[i].hi - signals[i].bid)/signals[i].point/10;
  signals[i].lowRatio=(signals[i].bid - signals[i].lo)/signals[i].point/10;
             
     if(signals[i].range!=0) {            
      signals[i].ratio=MathMin(((signals[i].bid-signals[i].lo)/signals[i].range*100 ),100);
      signals[i].prevratio=MathMin(((signals[i].prevbid-signals[i].lo)/signals[i].range*100 ),100);     
           
      for (int j = 0; j < 8; j++){
            
      if(signals[i].ratio <= 3.0) signals[i].fact = 0;
      if(signals[i].ratio > 3.0)  signals[i].fact = 1;
      if(signals[i].ratio > 10.0) signals[i].fact = 2;
      if(signals[i].ratio > 25.0) signals[i].fact = 3;
      if(signals[i].ratio > 40.0) signals[i].fact = 4;
      if(signals[i].ratio > 50.0) signals[i].fact = 5;
      if(signals[i].ratio > 60.0) signals[i].fact = 6;
      if(signals[i].ratio > 75.0) signals[i].fact = 7;
      if(signals[i].ratio > 90.0) signals[i].fact = 8;
      if(signals[i].ratio > 97.0) signals[i].fact = 9;
       cnt++;
      
      if(curr[j]==StringSubstr(signals[i].symbol,3,3))
               signals[i].fact=9-signals[i].fact;

      if(curr[j]==StringSubstr(signals[i].symbol,0,3)) {
               signals[i].strength1=signals[i].fact;
              }  else{
      if(curr[j]==StringSubstr(signals[i].symbol,3,3))
               signals[i].strength2=signals[i].fact;
              }

      signals[i].calc =signals[i].strength1-signals[i].strength2;
      
      signals[i].strength=currency_strength(curr[j]);

            if(curr[j]==StringSubstr(signals[i].symbol,0,3)){
               signals[i].strength3=signals[i].strength;
            } else{
            if(curr[j]==StringSubstr(signals[i].symbol,3,3))
               signals[i].strength4=signals[i].strength;
            }
            signals[i].strength5=(signals[i].strength3-signals[i].strength4);
            
       signals[i].strength_old=old_currency_strength(curr[j]);

            if(curr[j]==StringSubstr(signals[i].symbol,0,3)){
               signals[i].strength6=signals[i].strength_old;
            } else {
            if(curr[j]==StringSubstr(signals[i].symbol,3,3))
               signals[i].strength7=signals[i].strength_old;
            }
            signals[i].strength8=(signals[i].strength6-signals[i].strength7);     
            signals[i].strength_Gap=signals[i].strength5-signals[i].strength8;
        
        if(signals[i].ratio>=trigger_buy_bidratio){
               signals[i].SigRatio=UP;
           } else {
         if(signals[i].ratio<=trigger_sell_bidratio)
               signals[i].SigRatio=DOWN;
           }  
        
        if(signals[i].ratio>signals[i].prevratio){
                signals[i].SigRatioPrev=UP;
           } else {
        if(signals[i].ratio<signals[i].prevratio)
                signals[i].SigRatioPrev=DOWN;
           }      
                    
        if(signals[i].calc>=trigger_buy_relstrength){
               signals[i].SigRelStr=UP;
             } else {
        if (signals[i].calc<=trigger_sell_relstrength) 
              signals[i].SigRelStr=DOWN;
             } 
             
         if(signals[i].strength5>=trigger_buy_buysellratio){
               signals[i].SigBSRatio=UP;
             } else {
       if (signals[i].calc<=trigger_sell_buysellratio) 
              signals[i].SigBSRatio=DOWN;
             }       
        
        if(signals[i].strength_Gap>=trigger_gap_buy){
               signals[i].SigGap=UP;
             } else {
        if (signals[i].strength_Gap<=trigger_gap_sell) 
              signals[i].SigGap=DOWN;
             }
              
        if(signals[i].strength5>signals[i].strength8){
              signals[i].SigGapPrev=UP;
             } else {
        if(signals[i].strength5<signals[i].strength8)      
               signals[i].SigGapPrev=DOWN;
                       if(signals[i].RSI>=trigger_buy_RSI){
  signals[i].SigRSI=UP;
  } else {
  if (signals[i].RSI<=trigger_sell_RSI) 
  signals[i].SigRSI=DOWN;
             }          
      }
    }    
}
}}*/
//+------------------------------------------------------------------+             
//-----------------------------------------------------------------------+

double hi(string _symbol, int _tf, int _lookBack, int _shift)
{
   double hi = -500000;
   for (int u = 0; u < _lookBack; u++)
   {
         if (iHigh(_symbol, _tf, _shift+u) > hi)
         {
            hi = iHigh(_symbol, _tf, _shift+u);
         }
   }
   return hi;
}

double lo(string _symbol, int _tf, int _lookBack, int _shift)
{
   double lo = 500000;
   for (int u = 0; u < _lookBack; u++)
   {
         if (iLow(_symbol, _tf, _shift+u) < lo)
         {
            lo = iLow(_symbol, _tf, _shift+u);
         }
   }
   return lo;
}

//+------------------------------------------------------------------+
color Colorstr(double tot) 
  {
   if(tot>=trigger_buy_bidratio)
      return (BBullColor);
   if(tot<=trigger_sell_bidratio)
      return (BBearColor);
   return (NeutroColor);
  }
color ColorBSRat(double tot) 
  {
   if(tot>=trigger_buy_buysellratio)
      return (BBullColor);
   if(tot<=trigger_sell_buysellratio)
      return (BBearColor);
   return (NeutroColor);
  } 
color ColorGap(double tot) 
  {
   if(tot>=trigger_gap_buy)
      return (BBullColor);
   if(tot<=trigger_gap_sell)
      return (BBearColor);
   return (NeutroColor);
  }
color PrevGap(double tot1) 
  {
   if(tot1>=trigger_PrevGap_buy)
      return (BBullColor);
   if(tot1<=trigger_PrevGap_sell)
      return (BBearColor);
   return (NeutroColor);
  }  
color ColorRSI(double tot) 
  {
  if(tot>=trigger_buy_RSI)
  return (BBullColor);
  if(tot<=trigger_sell_RSI)
  return (BBearColor);
  return (NeutroColor);
  }           
//----------------------------------------------------------------  
///*sinput*/ string masterPreamble = "CM_GVC_TF_10_";
///*sinput*/ int UpdateInSeconds  = 1;
/*sinput*/ int xAnchor = -2;
/*sinput*/ int yAnchor = 111;

int panelWidth = 500;
int panelHeight = 400;

int xWidth = 50;
int yHeight = 10;
int xSpace = 1;
int ySpace = -4;
color ClrText = clrWhiteSmoke;
color ClrBackground = clrBlack;
color ClrBorder = clrBlack;
int fontSize = 6;
//+------------------------------------------------------------------+ 
void displayMeter() {
   static datetime PrevSignal = 0, PrevTime = 0;
   int MyValue[8];
      
   double arrt[8][3];
   int arr2,arr3;
   arrt[0][0] = currency_strength(curr[0]); 
   arrt[1][0] = currency_strength(curr[1]); 
   arrt[2][0] = currency_strength(curr[2]);
   arrt[3][0] = currency_strength(curr[3]); 
   arrt[4][0] = currency_strength(curr[4]); 
   arrt[5][0] = currency_strength(curr[5]);
   arrt[6][0] = currency_strength(curr[6]); 
   arrt[7][0] = currency_strength(curr[7]);
   arrt[0][2] = old_currency_strength(curr[0]); 
   arrt[1][2] = old_currency_strength(curr[1]);
   arrt[2][2] = old_currency_strength(curr[2]);
   arrt[3][2] = old_currency_strength(curr[3]); 
   arrt[4][2] = old_currency_strength(curr[4]);
   arrt[5][2] = old_currency_strength(curr[5]);
   arrt[6][2] = old_currency_strength(curr[6]);
   arrt[7][2] = old_currency_strength(curr[7]);
   arrt[0][1] = 0; 
   arrt[1][1] = 1; 
   arrt[2][1] = 2; 
   arrt[3][1] = 3; 
   arrt[4][1] = 4;
   arrt[5][1] = 5; 
   arrt[6][1] = 6; 
   arrt[7][1] = 7;
   ArraySort(arrt, WHOLE_ARRAY, 0, MODE_DESCEND);
   panelWidth = 1;
   panelWidth = panelWidth + 80;

   panelWidth = panelWidth + 3 * xSpace; 
   panelHeight = 9 * yHeight + 10 * ySpace;
   string strText = "TF: " + IntegerToString(PERIOD_BID,1) + ";  P: " + IntegerToString(Period_1,1) + ")";
   SetText(masterPreamble + "_label_indiName",strText,x_axis+600 +  xSpace,y_axis-10 - 70,ClrText, fontSize);

   for (int m = 0; m < 8; m++) {
      arr2 = arrt[m][1];
      arr3=(int)arrt[m][2];
      currstrength[m] = arrt[m][1];///0
      prevstrength[m] = arrt[m][2];///2 
        SetText(curr[arr2]+"pos",IntegerToString(m+1)+".",(m*161)+x_axis+12,y_axis+273,clrBlack,12);
        SetText(curr[arr2]+"curr", curr[arr2],(m*161)+x_axis+40,y_axis+273,clrBlack,12);
        SetText(curr[arr2]+"currdig", DoubleToStr(arrt[m][0],1),(m*161)+x_axis+82,y_axis+273,clrBlack,12);
        SetPanel("Strength"+IntegerToString(m),0,(m*161)+x_axis+9,y_axis+272,165,20,color_for_profit(arrt[m][0]),C'61,61,61',1);                                    
       
  if(currstrength[m] > prevstrength[m]){SetObjText("Sdir3"+IntegerToString(m),CharToStr(233),(m*160)+x_axis+125,y_axis+273,BullColor,10);}
  else if(currstrength[m] < prevstrength[m]){SetObjText("Sdir3"+IntegerToString(m),CharToStr(234),(m*160)+x_axis+125,y_axis+277,BearColor,10);}
  else {SetObjText("Sdir3"+IntegerToString(m),CharToStr(243),(m*160)+x_axis+125,y_axis+274,clrYellow,10);}       
         
         }
 ChartRedraw(); 
}

color color_for_profit(double total) 
  {
  if(total<2.0)
      return (clrRed);
   if(total<=3.0)
      return (clrOrangeRed);
   if(total>7.0)
      return (clrLime);
   if(total>6.0)
      return (clrGreen);
   if(total>5.0)
      return (clrSandyBrown);
   if(total<=5.0)
      return (clrYellow);       
   return(clrSteelBlue);
  }

double currency_strength(string pair) {
   int fact;
   string sym;
   double range;
   double ratio;
   double strength = 0;
   int cnt1 = 0;
   
   for (int x = 0; x < ArraySize(TradePairs); x++) {
      fact = 0;
      sym = TradePairs[x];
      if (pair == StringSubstr(sym, 0, 3) || pair == StringSubstr(sym, 3, 3)) {
        // sym = sym + tempsym;
         //range = (MarketInfo(sym, MODE_HIGH) - MarketInfo(sym, MODE_LOW)) ;
         range = hi(sym, PERIOD_BID,Period_1,0) - lo(sym, PERIOD_BID,Period_1,0);
         if (range != 0.0) {
            ratio = 100.0 * ((MarketInfo(sym, MODE_BID) - lo(sym, PERIOD_BID,Period_1,0)) / range );
            if (ratio > 3.0)  fact = 1;
            if (ratio > 10.0) fact = 2;
            if (ratio > 25.0) fact = 3;
            if (ratio > 40.0) fact = 4;
            if (ratio > 50.0) fact = 5;
            if (ratio > 60.0) fact = 6;
            if (ratio > 75.0) fact = 7;
            if (ratio > 90.0) fact = 8;
            if (ratio > 97.0) fact = 9;
            cnt1++;
            if (pair == StringSubstr(sym, 3, 3)) fact = 9 - fact;
            strength += fact;
           // signals[x].strength += fact;
         }
      } 
           
   }
  // for (int x = 0; x < ArraySize(TradePairs); x++) 
   //if(cnt1!=0)signals[x].strength /= cnt1;
   if(cnt1!=0)strength /= cnt1;
   return (strength);
   
 }
//-----------------------------------------------------------------------------------+
double old_currency_strength(string pair) 
  {
   int fact;
   string sym;
   double range;
   double ratio;
   double strength=0;
   int cnt1=0;

   for(int x=0; x<ArraySize(TradePairs); x++) 
     {
      fact= 0;
      sym = TradePairs[x];
      int bar = iBarShift(TradePairs[x],PERIOD_M1,TimeCurrent()-900);
      double prevbid = iClose(TradePairs[x],PERIOD_M1,bar);
      
      if(pair==StringSubstr(sym,0,3) || pair==StringSubstr(sym,3,3)) 
        {
         // sym = sym + tempsym;
         range=(hi(sym, PERIOD_BID,Period_1,0)-lo(sym, PERIOD_BID,Period_1,0));
         if(range!=0.0) 
           {
            ratio=100.0 *((prevbid-lo(sym, PERIOD_BID,Period_1,0))/range);

            if(ratio > 3.0)  fact = 1;
            if(ratio > 10.0) fact = 2;
            if(ratio > 25.0) fact = 3;
            if(ratio > 40.0) fact = 4;
            if(ratio > 50.0) fact = 5;
            if(ratio > 60.0) fact = 6;
            if(ratio > 75.0) fact = 7;
            if(ratio > 90.0) fact = 8;
            if(ratio > 97.0) fact = 9;
            
            cnt1++;

            if(pair==StringSubstr(sym,3,3))
               fact=9-fact;

            strength+=fact;

           }
        }
     }
   if(cnt1!=0)
      strength/=cnt1;

   return (strength);
  
} 
/*double currency_strength(string pair) {
   int fact;
   string sym;
   double range;
   double ratio;
   double strength = 0;
   int cnt1 = 0;
   
   for (int x = 0; x < ArraySize(TradePairs); x++) {
      fact = 0;
      sym = TradePairs[x];
      if (pair == StringSubstr(sym, 0, 3) || pair == StringSubstr(sym, 3, 3)) {
        // sym = sym + tempsym;
         range = (MarketInfo(sym, MODE_HIGH) - MarketInfo(sym, MODE_LOW)) ;
         if (range != 0.0) {
            ratio = 100.0 * ((MarketInfo(sym, MODE_BID) - MarketInfo(sym, MODE_LOW)) / range );
            if (ratio > 3.0)  fact = 1;
            if (ratio > 10.0) fact = 2;
            if (ratio > 25.0) fact = 3;
            if (ratio > 40.0) fact = 4;
            if (ratio > 50.0) fact = 5;
            if (ratio > 60.0) fact = 6;
            if (ratio > 75.0) fact = 7;
            if (ratio > 90.0) fact = 8;
            if (ratio > 97.0) fact = 9;
            cnt1++;
            if (pair == StringSubstr(sym, 3, 3)) fact = 9 - fact;
            strength += fact;
           // signals[x].strength += fact;
         }
      } 
           
   }
  // for (int x = 0; x < ArraySize(TradePairs); x++) 
   //if(cnt1!=0)signals[x].strength /= cnt1;
   if(cnt1!=0)strength /= cnt1;
   return (strength);
   
 }
//-----------------------------------------------------------------------------------+
double old_currency_strength(string pair) 
  {
   int fact;
   string sym;
   double range;
   double ratio;
   double strength=0;
   int cnt1=0;

   for(int x=0; x<ArraySize(TradePairs); x++) 
     {
      fact= 0;
      sym = TradePairs[x];
      int bar = iBarShift(TradePairs[x],PERIOD_M1,TimeCurrent()-1800);
      double prevbid = iClose(TradePairs[x],PERIOD_M1,bar);
      
      if(pair==StringSubstr(sym,0,3) || pair==StringSubstr(sym,3,3)) 
        {
         // sym = sym + tempsym;
         range=(MarketInfo(sym,MODE_HIGH)-MarketInfo(sym,MODE_LOW));
         if(range!=0.0) 
           {
            ratio=100.0 *((prevbid-MarketInfo(sym,MODE_LOW))/range);

            if(ratio > 3.0)  fact = 1;
            if(ratio > 10.0) fact = 2;
            if(ratio > 25.0) fact = 3;
            if(ratio > 40.0) fact = 4;
            if(ratio > 50.0) fact = 5;
            if(ratio > 60.0) fact = 6;
            if(ratio > 75.0) fact = 7;
            if(ratio > 90.0) fact = 8;
            if(ratio > 97.0) fact = 9;
            
            cnt1++;

            if(pair==StringSubstr(sym,3,3))
               fact=9-fact;

            strength+=fact;

           }
        }
     }
   if(cnt1!=0)
      strength/=cnt1;

   return (strength);
  
} */
//-----------------------------------------------------------------------+
color Colorsync(double tot) 
  {
   if(tot>=trigger_buy_relstrength)
      return (BBullColor);
   if(tot<=trigger_sell_relstrength)
      return (BBearColor);
   return (NeutroColor);
  }
//-----------------------------------------------------------------------+
//-----------------------------------------------------------------------+    
void get_list_status(Pair &this_list[]) 
  {
   
   ArrayResize(this_list,ArraySize(TradePairs));
   for(int i=0; i<ArraySize(this_list); i++)   
     {
      this_list[i].symbol1=TradePairs[i];      
      this_list[i].point1=MarketInfo(this_list[i].symbol1,MODE_POINT);       
      this_list[i].open1=iOpen(this_list[i].symbol1,periodBR1,0);      
      this_list[i].close1=iClose(this_list[i].symbol1,periodBR1,0);
      this_list[i].hi1=MarketInfo(this_list[i].symbol1,MODE_HIGH);
      this_list[i].lo1=MarketInfo(this_list[i].symbol1,MODE_LOW);
      this_list[i].ask1=MarketInfo(this_list[i].symbol1,MODE_ASK);
      this_list[i].bid1=MarketInfo(this_list[i].symbol1,MODE_BID);
      
      
      if(this_list[i].point1==0.0001 || this_list[i].point1==0.01)
      this_list[i].pipsfactor1=1;
      if(this_list[i].point1==0.00001 || this_list[i].point1==0.001)
      this_list[i].pipsfactor1=10;
      if(this_list[i].point1 !=0 && this_list[i].pipsfactor1 != 0){ 
      this_list[i].spread1=MarketInfo(this_list[i].symbol1,MODE_SPREAD)/this_list[i].pipsfactor1;
      this_list[i].pips1=(this_list[i].close1-this_list[i].open1)/this_list[i].point1/this_list[i].pipsfactor1;
      } 
      if(this_list[i].open1>this_list[i].close1) {       
      this_list[i].range1=(this_list[i].hi1-this_list[i].lo1)*this_list[i].point1;      
      this_list[i].ratio1=MathMin((this_list[i].hi1-this_list[i].close1)/this_list[i].range1*this_list[i].point1/ (-0.01),100);
      this_list[i].calc1=this_list[i].ratio1/(-10);
      
      }
      else if(this_list[i].range1 !=0 ){
      this_list[i].range1=(this_list[i].hi1-this_list[i].lo1)*this_list[i].point1; 
      this_list[i].ratio1=MathMin(100*(this_list[i].close1-this_list[i].lo1)/this_list[i].range1*this_list[i].point1,100);
      this_list[i].calc1=this_list[i].ratio1/10;
      
     }
      WindowRedraw();   
   }
// SORT THE TABLE!!!
   for(int i=0; i<ArraySize(this_list); i++)
      for(int j=i; j<ArraySize(this_list); j++) 
        {
         if(!Accending) 
           {
            if(this_list[j].ratio1<this_list[i].ratio1)
               swap(this_list[i],this_list[j]);
              } else {
            if(this_list[j].ratio1>this_list[i].ratio1)
               swap(this_list[i],this_list[j]);
           }
        }

 
  }   
  
//+------------------------------------------------------------------+
//-------------------------------------------------------------------+
void swap (Pair &i, Pair &j) {
   string strTemp;
   double dblTemp;
   int    intTemp;
   
      strTemp = i.symbol1; i.symbol1 = j.symbol1; j.symbol1 = strTemp;
      dblTemp = i.point1; i.point1 = j.point1; j.point1 = dblTemp;
      dblTemp = i.open1; i.open1 = j.open1; j.open1 = dblTemp;
      dblTemp = i.close1; i.close1 = j.close1; j.close1 = dblTemp;
      dblTemp = i.hi1; i.hi1 = j.hi1; j.hi1 = dblTemp;
      dblTemp = i.lo1; i.lo1 = j.lo1; j.lo1 = dblTemp;
      dblTemp = i.ask1; i.ask1 = j.ask1; j.ask1 = dblTemp;
      dblTemp = i.bid1; i.bid1 = j.bid1; j.bid1 = dblTemp;
      intTemp = i.pipsfactor1; i.pipsfactor1 = j.pipsfactor1; j.pipsfactor1 = intTemp;
      dblTemp = i.spread1; i.spread1 = j.spread1; j.spread1 = dblTemp; 
      dblTemp = i.pips1; i.pips1 = j.pips1; j.pips1 = dblTemp;
      dblTemp = i.range1; i.range1 = j.range1; j.range1 = dblTemp;
      dblTemp = i.ratio1; i.ratio1 = j.ratio1; j.ratio1 = dblTemp;
      dblTemp = i.calc1; i.calc1= j.calc1; j.calc1 = dblTemp;
 
}
//+------------------------------------------------------------------+ 
color ColorPips(double Pips) 
  {
   if(Pips>0)
      return (clrLawnGreen);
   if(Pips<0)
      return (clrRed);
   return (clrWhite);
  }
//+------------------------------------------------------------------+ 
color ColorstrST(double tot) 
  {
   if(tot>0)
      return (PMBullColor);
   if(tot<0)
      return (PMBearColor);
   return (PMNeutroColor);
  }
//-------------------------------------------------------------------+
//----------------------------------------------------------------
void GetSignals1() 
  {
  ArrayResize(signals,ArraySize(TradePairs));
  for (int i=0;i<ArraySize(signals);
  i++) 
  {
  signals[i].symbol=TradePairs[i]; 
  signals[i].point3=MarketInfo(signals[i].symbol,MODE_POINT);
  signals[i].digit3=MarketInfo(signals[i].symbol,MODE_DIGITS);
  signals[i].open3=iOpen(signals[i].symbol,periodBR1,0);      
  signals[i].close3=iClose(signals[i].symbol,periodBR1,0);
  signals[i].high3=MarketInfo(signals[i].symbol,MODE_HIGH);
  signals[i].low3=MarketInfo(signals[i].symbol,MODE_LOW);
  signals[i].bid3=MarketInfo(signals[i].symbol,MODE_BID);
  signals[i].ask3=MarketInfo(signals[i].symbol,MODE_ASK);
  if((signals[i].high3-signals[i].low3) !=0)
  {
  signals[i].bidratio3=((signals[i].bid3-signals[i].low3)/(signals[i].high3-signals[i].low3)*100);
  signals[i].range3=((signals[i].high3-signals[i].low3)/signals[i].point3/pairinfo[i].pipsfactor);      
  signals[i].ratio3=MathMin((signals[i].high3-signals[i].close3)/signals[i].range3*signals[i].point3 / (-0.01),100);
  
  EditText("Textpointrange3"+(string)i,GetSymbolPOINT(NormalizeDouble(signals[i].point3,3))+(string)DoubleToString(MathAbs(NormalizeDouble(signals[i].point3,3)),3) +"",SetClrPOINT(NormalizeDouble(signals[i].point3,3)),6);
  EditText("Texthigh3"+(string)i,GetSymbolHI(NormalizeDouble(signals[i].high3,3))+(string)DoubleToString(MathAbs(NormalizeDouble(signals[i].high3,3)),3) +"",SetClrHI(NormalizeDouble(signals[i].high3,3)),6);
  EditText("TextAsk3"+(string)i,GetSymbolLO(NormalizeDouble(signals[i].low3,3))+(string)DoubleToString(MathAbs(NormalizeDouble(signals[i].low3,3)),3) +"",SetClrLO(NormalizeDouble(signals[i].low3,3)),6);
  EditText("TextBid3"+(string)i,GetSymbolBID(NormalizeDouble(signals[i].bid3,3))+(string)DoubleToString(MathAbs(NormalizeDouble(signals[i].bid3,3)),3) +"",SetClrBID(NormalizeDouble(signals[i].bid3,3)),6);
  EditText("TextLow3"+(string)i,GetSymbolASK(NormalizeDouble(signals[i].ask3,3))+(string)DoubleToString(MathAbs(NormalizeDouble(signals[i].ask3,3)),3) +"",SetClrASK(NormalizeDouble(signals[i].ask3,3)),6);


/*  if(signals[i].high3>signals[i].low3){
  signals[i].high3=UP;
  } else {
  if(signals[i].low3<signals[i].high3)
  signals[i].low3=DOWN;*
  }*/       
  }            
  }  
  } 
//----------------------------------------------------------------
string GetSymbolPOINT(double Value){
   if(Value>0){return("+");}else
   if(Value<0){return("-");}else
   if(Value==0){return(" ");}else{return(" ");}
}
color SetClrPOINT(double Value){
   if(Value>0){return(clrLime);}else
   if(Value<0){return(clrRed);}else
   if(Value==0){return(clrWhite);}else{return(clrWhite);}
}
//----------------------------------------------------------------
string GetSymbolHI(double Value){
   if(Value>0){return("+");}else
   if(Value<0){return("-");}else
   if(Value==0){return(" ");}else{return(" ");}
}
color SetClrHI(double Value){
   if(Value>0){return(clrLime);}else
   if(Value<0){return(clrRed);}else
   if(Value==0){return(clrWhite);}else{return(clrWhite);}
}
//----------------------------------------------------------------
string GetSymbolLO(double Value){
   if(Value>0){return("+");}else
   if(Value<0){return("-");}else
   if(Value==0){return(" ");}else{return(" ");}
}
color SetClrLO(double Value){
   if(Value>0){return(clrLime);}else
   if(Value<0){return(clrRed);}else
   if(Value==0){return(clrWhite);}else{return(clrWhite);}
}
string GetSymbolBID(double Value){
   if(Value>0){return("+");}else
   if(Value<0){return("-");}else
   if(Value==0){return(" ");}else{return(" ");}
}
color SetClrBID(double Value){
   if(Value>0){return(clrLime);}else
   if(Value<0){return(clrRed);}else
   if(Value==0){return(clrWhite);}else{return(clrWhite);}
}
string GetSymbolASK(double Value){
   if(Value>0){return("+");}else
   if(Value<0){return("-");}else
   if(Value==0){return(" ");}else{return(" ");}
}
color SetClrASK(double Value){
   if(Value>0){return(clrLime);}else
   if(Value<0){return(clrRed);}else
   if(Value==0){return(clrWhite);}else{return(clrWhite);}
}
//-----------------------------------------------------------------------+
double RSI_Value(string sym)
   {    
   double  valu;
   int    i; 
   double RSI_PRES;
   
   for(i=0; i<ArraySize(TradePairs); i++)
   {                         
   RSI_PRES    = iRSI(sym,trigger_RSI_Timeframe,trigger_RSI_period,trigger_RSI_Applied,trigger_RSI_shift);   //i+1 => previous bar           
   }
   valu=RSI_PRES;
   
   return(valu);
   
   } 
//-----------------------------------------------------------------------+
void GetTrendChange() {
   for (int i=0;i<ArraySize(TradePairs);i++) {
   EditText("rsi"+(string)i,(string)DoubleToString(signals[i].RSI,0) +"%",SetClrRSI(signals[i].RSI),7);   

   signals[i].Signalrsi = NONE;
   
   double Closelast = iRSI(TradePairs[i],trigger_RSI_Timeframe,trigger_RSI_period,trigger_RSI_Applied,0);
   double Closebefore = iRSI(TradePairs[i],trigger_RSI_Timeframe,trigger_RSI_period,trigger_RSI_Applied,1);
   
   if (Closelast<Closebefore && Closelast<=trigger_sell_RSI) {
   
   signals[i].Signalrsi = DOWN;
   }
   
   if (Closelast>Closebefore && Closelast>=trigger_buy_RSI)  {
   
   signals[i].Signalrsi = UP;
  
   }   
   }
   }
color SetClrRSI1(double Value){
   if(Value>80){return (clrTurquoise);}else
   if(Value<=80 && Value>=60){return (clrLime);}else
   if(Value<60 && Value>40){return (clrWhite);}else
   if(Value<=40 && Value>20){return (clrRed);}else
   if(Value<=20){return (clrViolet);}else
   {return (clrWhite);}
}
//+------------------------------------------------------------------+
void GetCommodity() {
   for (int i=0;i<ArraySize(TradePairs);i++) 
   {
   signals[i].Signalcc = NONE;
   double cci = iCCI(TradePairs[i],TF_CCI,trade_Period_CCI,5,0);
   double cci_prev = iCCI(TradePairs[i],TF_CCI,trade_Period_CCI,5,1); 
   EditText("TextCCI"+(string)i,(string)DoubleToString(signals[i].Signalcc,0),SetClrCCI(signals[i].Signalcc),7);   
   if (cci<trigger_CCI_Sell/*&&cci<cci_prev*/) {
   
   signals[i].Signalcc = DOWN;
   }
   
   if (cci>trigger_CCI_Buy/*&&cci>cci_prev*/)  {
   
   signals[i].Signalcc = UP;
   
   }   
   }
   }
color SetClrCCI(double Value){
   if(Value<100 && Value>-100){return (clrWhite);}else
   if(Value>200){return (clrTurquoise);}else
   if(Value<=200 && Value>=100){return (clrLime);}else
   if(Value<-200){return (clrViolet);}else
   if(Value<=-100 && Value>=-200){return (clrRed);}else
   {return (clrWhite);}
}
//+------------------------------------------------------------------+
void GetCCI(){
   string pair="";
   for(int i=0; i<ArraySize(TradePairs); i++)
   {    
      pair=TradePairs[i];
      signals[i].CCIA    = iCCI(pair,PERIODCCIA, trade_Period_CCIA, PRICE_CLOSE, 0);
      signals[i].CCIB    = iCCI(pair,PERIODCCIB, trade_Period_CCIB, PRICE_CLOSE, 0);
      signals[i].CCIC    = iCCI(pair,PERIODCCIC, trade_Period_CCIC, PRICE_CLOSE, 0);
      if(signals[i].CCIA>0){signals[i].Signal_CCIA="BUY";}else
      if(signals[i].CCIA<0){signals[i].Signal_CCIA="SELL";}else{signals[i].Signal_CCIA="FLAT";}
      if(signals[i].CCIB>0){signals[i].Signal_CCIB="BUY";}else
      if(signals[i].CCIB<0){signals[i].Signal_CCIB="SELL";}else{signals[i].Signal_CCIB="FLAT";}
      if(signals[i].CCIC>0){signals[i].Signal_CCIC="BUY";}else
      if(signals[i].CCIC<0){signals[i].Signal_CCIC="SELL";}else{signals[i].Signal_CCIC="FLAT";}
      EditText("TextCCIA"+(string)i,(string)DoubleToString(signals[i].CCIA,0),SetClrCCIA(signals[i].CCIA),7);
      EditText("TextCCIB"+(string)i,(string)DoubleToString(signals[i].CCIB,0),SetClrCCIB(signals[i].CCIB),7);
      EditText("TextCCIC"+(string)i,(string)DoubleToString(signals[i].CCIC,0),SetClrCCIC(signals[i].CCIC),7);
   }
}
color SetClrCCIA(double ValueA){
   if(ValueA<100 && ValueA>-100){return (clrWhite);}else
   if(ValueA>200){return (clrTurquoise);}else
   if(ValueA<=200 && ValueA>=100){return (clrLime);}else
   if(ValueA<-200){return (clrViolet);}else
   if(ValueA<=-100 && ValueA>=-200){return (clrRed);}else
   {return (clrWhite);}
}
color SetClrCCIB(double ValueB){
   if(ValueB<100 && ValueB>-100){return (clrWhite);}else
   if(ValueB>200){return (clrTurquoise);}else
   if(ValueB<=200 && ValueB>=100){return (clrLime);}else
   if(ValueB<-200){return (clrViolet);}else
   if(ValueB<=-100 && ValueB>=-200){return (clrRed);}else
   {return (clrWhite);}
}
color SetClrCCIC(double ValueC){
   if(ValueC<100 && ValueC>-100){return (clrWhite);}else
   if(ValueC>200){return (clrTurquoise);}else
   if(ValueC<=200 && ValueC>=100){return (clrLime);}else
   if(ValueC<-200){return (clrViolet);}else
   if(ValueC<=-100 && ValueC>=-200){return (clrRed);}else
   {return (clrWhite);}
}
//------------------------------------------------------------------------------
void Geth4d1() {
   for (int i=0;i<ArraySize(TradePairs);i++) {
   
  double BB1 = iMA(TradePairs[i],PERIODMM_M1,trade_Period_MAM1,0,MODE_SMA,PRICE_CLOSE,0);
  double BB5 = iMA(TradePairs[i],PERIODMM_M5,trade_Period_MAM5,0,MODE_SMA,PRICE_CLOSE,0);
  double BB15 = iMA(TradePairs[i],PERIODMM_M15,trade_Period_MAM15,0,MODE_SMA,PRICE_CLOSE,0);  
  if(iClose(TradePairs[i],PERIODMM_M1,0)>BB1 )
  signals[i].Signalm1=UP;
  if(iClose(TradePairs[i],PERIODMM_M1,0)<BB1 )
  signals[i].Signalm1=DOWN;
  if(iClose(TradePairs[i],PERIODMM_M5,0)>BB5 )
  signals[i].Signalm5=UP;
  if(iClose(TradePairs[i],PERIODMM_M5,0)<BB5 )
  signals[i].Signalm5=DOWN;
  if(iClose(TradePairs[i],PERIODMM_M15,0)>BB15 )
  signals[i].Signalm15=UP;
  if(iClose(TradePairs[i],PERIODMM_M15,0)<BB15 )
  signals[i].Signalm15=DOWN;
             
  signals[i].Signalmaup=(signals[i].Signalm1==UP&&signals[i].Signalm5==UP&&signals[i].Signalm15==UP);
  signals[i].Signalmadn=(signals[i].Signalm1==DOWN&&signals[i].Signalm5==DOWN&&signals[i].Signalm15==DOWN);   
       
  }
  }
//------------------------------------------------------------------------------ 
double GetFibo(string pair) {
   string sym;double bid=0.0;double hi=0.0;double lo=0.0;double open=0.0;double range=0.0;double ratio=0.0;double strength = 0;
   for (int x = 0; x < ArraySize(TradePairs); x++) {
      sym = TradePairs[x];
      if (pair == sym) {
         hi=iHigh(sym,PERIOD_FIBO,1);    
         lo=iLow(sym,PERIOD_FIBO,1);   
         open=iOpen(sym,PERIOD_FIBO,0);
         bid=MarketInfo(sym,MODE_BID);
         range = hi- lo;
         if (range != 0.0) {            
            if (bid>hi){ratio=NormalizeDouble(100+ ((MarketInfo(sym, MODE_BID)-hi)/range*100),0);    
            }else
            if (bid<lo){
            ratio=NormalizeDouble( 0 - ((lo-MarketInfo(sym, MODE_BID))/range*100),0);     
            }else{
            ratio=NormalizeDouble(MathMin(((MarketInfo(sym, MODE_BID)-lo)/range*100 ),100),0);
            }
         }
      }    
   }
   return (ratio);
 }
 
void GetFibonacciDaily(){
   color clr_bg_color= clrWhite;
   color clr_bg_txtcolor= clrBlack;
   for (int i=0;i<ArraySize(TradePairs);i++){
      signals[i].FibonacciDaily=GetFibo(TradePairs[i]);
      if(signals[i].FibonacciDaily>=60 && signals[i].FibonacciDaily<=100){clr_bg_color=clrLime;clr_bg_txtcolor=clrBlack;}else
      if(signals[i].FibonacciDaily>100){clr_bg_color=clrTurquoise;clr_bg_txtcolor=clrBlack;}else
      if(signals[i].FibonacciDaily<=40 && signals[i].FibonacciDaily>=0){clr_bg_color=clrRed;clr_bg_txtcolor=clrBlack;}else
      if(signals[i].FibonacciDaily<0){clr_bg_color=clrViolet;clr_bg_txtcolor=clrBlack;}else{clr_bg_color=clrWhite;clr_bg_txtcolor=clrBlack;}
         EditText("TextFibonacciDaily"+(string)i,(string)DoubleToString(signals[i].FibonacciDaily,0) +"%",clr_bg_color,7); 
      if(signals[i].Signal_Direction!="FLAT"){
         SignalColorPanel_bg("PanelFibonacciDaily"+(string)i,clr_bg_color); 
         SignalColorPanel_txt("TextFibonacciDaily"+(string)i,(string)DoubleToString(signals[i].FibonacciDaily,0) +"%",clr_bg_txtcolor);
      }else{
         SignalColorPanel_bg("PanelFibonacciDaily"+(string)i,C'30,30,30');
         SignalColorPanel_txt("TextFibonacciDaily"+(string)i,(string)DoubleToString(signals[i].FibonacciDaily,0) +"%",clr_bg_color);
      }
      if(signals[i].FibonacciDaily>=AI_Fibonacci_BUY_Dari && signals[i].FibonacciDaily<=AI_Fibonacci_BUY_Sampai){signals[i].Signal_Fibonacci="BUY";}else
      if(signals[i].FibonacciDaily<=AI_Fibonacci_SELL_Dari && signals[i].FibonacciDaily>=AI_Fibonacci_SELL_Sampai){signals[i].Signal_Fibonacci="SELL";}else{
      signals[i].Signal_Fibonacci="FLAT";
      }
   }
}
//FIBOB
//------------------------------------------------------------------------------ 
double GetFiboB(string pair) {
   string sym;double bid=0.0;double hi=0.0;double lo=0.0;double open=0.0;double range=0.0;double ratio=0.0;double strength = 0;
   for (int x = 0; x < ArraySize(TradePairs); x++) {
      sym = TradePairs[x];
      if (pair == sym) {
         hi=iHigh(sym,PERIOD_FIBOB,1);    
         lo=iLow(sym,PERIOD_FIBOB,1);   
         open=iOpen(sym,PERIOD_FIBOB,0);
         bid=MarketInfo(sym,MODE_BID);
         range = hi- lo;
         if (range != 0.0) {            
            if (bid>hi){ratio=NormalizeDouble(100+ ((MarketInfo(sym, MODE_BID)-hi)/range*100),0);    
            }else
            if (bid<lo){
            ratio=NormalizeDouble( 0 - ((lo-MarketInfo(sym, MODE_BID))/range*100),0);     
            }else{
            ratio=NormalizeDouble(MathMin(((MarketInfo(sym, MODE_BID)-lo)/range*100 ),100),0);
            }
         }
      }    
   }
   return (ratio);
 }
 
void GetFibonacciDailyB(){
   color clr_bg_color= clrWhite;
   color clr_bg_txtcolor= clrBlack;
   for (int i=0;i<ArraySize(TradePairs);i++){
      signals[i].FibonacciDailyB=GetFiboB(TradePairs[i]);
      if(signals[i].FibonacciDailyB>=60 && signals[i].FibonacciDailyB<=100){clr_bg_color=clrLime;clr_bg_txtcolor=clrBlack;}else
      if(signals[i].FibonacciDailyB>100){clr_bg_color=clrTurquoise;clr_bg_txtcolor=clrBlack;}else
      if(signals[i].FibonacciDailyB<=40 && signals[i].FibonacciDailyB>=0){clr_bg_color=clrRed;clr_bg_txtcolor=clrBlack;}else
      if(signals[i].FibonacciDailyB<0){clr_bg_color=clrViolet;clr_bg_txtcolor=clrBlack;}else{clr_bg_color=clrWhite;clr_bg_txtcolor=clrBlack;}
         EditText("TextFibonacciDailyB"+(string)i,(string)DoubleToString(signals[i].FibonacciDailyB,0) +"%",clr_bg_color,7); 
      if(signals[i].Signal_DirectionB!="FLAT"){
         SignalColorPanel_bg("PanelFibonacciDailyB"+(string)i,clr_bg_color); 
         SignalColorPanel_txt("TextFibonacciDailyB"+(string)i,(string)DoubleToString(signals[i].FibonacciDailyB,0) +"%",clr_bg_txtcolor);
      }else{
         SignalColorPanel_bg("PanelFibonacciDailyB"+(string)i,C'30,30,30');
         SignalColorPanel_txt("TextFibonacciDailyB"+(string)i,(string)DoubleToString(signals[i].FibonacciDailyB,0) +"%",clr_bg_color);
      }
      if(signals[i].FibonacciDailyB>=AI_Fibonacci_BUY_DariB && signals[i].FibonacciDailyB<=AI_Fibonacci_BUY_SampaiB){signals[i].Signal_FibonacciB="BUY";}else
      if(signals[i].FibonacciDailyB<=AI_Fibonacci_SELL_DariB && signals[i].FibonacciDailyB>=AI_Fibonacci_SELL_SampaiB){signals[i].Signal_FibonacciB="SELL";}else{
      signals[i].Signal_FibonacciB="FLAT";
      }
   }
}
//FIBOC
//------------------------------------------------------------------------------ 
double GetFiboC(string pair) {
   string sym;double bid=0.0;double hi=0.0;double lo=0.0;double open=0.0;double range=0.0;double ratio=0.0;double strength = 0;
   for (int x = 0; x < ArraySize(TradePairs); x++) {
      sym = TradePairs[x];
      if (pair == sym) {
         hi=iHigh(sym,PERIOD_FIBOC,1);    
         lo=iLow(sym,PERIOD_FIBOC,1);   
         open=iOpen(sym,PERIOD_FIBOC,0);
         bid=MarketInfo(sym,MODE_BID);
         range = hi- lo;
         if (range != 0.0) {            
            if (bid>hi){ratio=NormalizeDouble(100+ ((MarketInfo(sym, MODE_BID)-hi)/range*100),0);    
            }else
            if (bid<lo){
            ratio=NormalizeDouble( 0 - ((lo-MarketInfo(sym, MODE_BID))/range*100),0);     
            }else{
            ratio=NormalizeDouble(MathMin(((MarketInfo(sym, MODE_BID)-lo)/range*100 ),100),0);
            }
         }
      }    
   }
   return (ratio);
 }
 
void GetFibonacciDailyC(){
   color clr_bg_color= clrWhite;
   color clr_bg_txtcolor= clrBlack;
   for (int i=0;i<ArraySize(TradePairs);i++){
      signals[i].FibonacciDailyC=GetFiboC(TradePairs[i]);
      if(signals[i].FibonacciDailyC>=60 && signals[i].FibonacciDailyC<=100){clr_bg_color=clrLime;clr_bg_txtcolor=clrBlack;}else
      if(signals[i].FibonacciDailyC>100){clr_bg_color=clrTurquoise;clr_bg_txtcolor=clrBlack;}else
      if(signals[i].FibonacciDailyC<=40 && signals[i].FibonacciDailyC>=0){clr_bg_color=clrRed;clr_bg_txtcolor=clrBlack;}else
      if(signals[i].FibonacciDailyC<0){clr_bg_color=clrViolet;clr_bg_txtcolor=clrBlack;}else{clr_bg_color=clrWhite;clr_bg_txtcolor=clrBlack;}
         EditText("TextFibonacciDailyC"+(string)i,(string)DoubleToString(signals[i].FibonacciDailyC,0) +"%",clr_bg_color,7); 
      if(signals[i].Signal_DirectionC!="FLAT"){
         SignalColorPanel_bg("PanelFibonacciDailyC"+(string)i,clr_bg_color); 
         SignalColorPanel_txt("TextFibonacciDailyC"+(string)i,(string)DoubleToString(signals[i].FibonacciDailyC,0) +"%",clr_bg_txtcolor);
      }else{
         SignalColorPanel_bg("PanelFibonacciDailyC"+(string)i,C'30,30,30');
         SignalColorPanel_txt("TextFibonacciDailyC"+(string)i,(string)DoubleToString(signals[i].FibonacciDailyC,0) +"%",clr_bg_color);
      }
      if(signals[i].FibonacciDailyC>=AI_Fibonacci_BUY_DariC && signals[i].FibonacciDailyC<=AI_Fibonacci_BUY_SampaiC){signals[i].Signal_FibonacciC="BUY";}else
      if(signals[i].FibonacciDailyC<=AI_Fibonacci_SELL_DariC && signals[i].FibonacciDailyC>=AI_Fibonacci_SELL_SampaiC){signals[i].Signal_FibonacciC="SELL";}else{
      signals[i].Signal_FibonacciC="FLAT";
      }
   }
}
//FIBOC
void GetDirection(){
   for (int i=0;i<ArraySize(TradePairs);i++){
      //M1
      if(iClose(TradePairs[i], PERIOD_M1,1)<iClose(TradePairs[i], PERIOD_M1,0) && iOpen(TradePairs[i], PERIOD_M1,1)<iClose(TradePairs[i], PERIOD_M1,0)){signals[i].Dir0=0;}else 
      if(iClose(TradePairs[i], PERIOD_M1,1)>iClose(TradePairs[i], PERIOD_M1,0) && iOpen(TradePairs[i], PERIOD_M1,1)>iClose(TradePairs[i], PERIOD_M1,0)){signals[i].Dir0=1;}else
      {signals[i].Dir0=2;}
      //M5
      if(iClose(TradePairs[i], PERIOD_M5,1)<iClose(TradePairs[i], PERIOD_M5,0) && iOpen(TradePairs[i], PERIOD_M5,1)<iClose(TradePairs[i], PERIOD_M5,0)){signals[i].Dir1=0;}else 
      if(iClose(TradePairs[i], PERIOD_M5,1)>iClose(TradePairs[i], PERIOD_M5,0) && iOpen(TradePairs[i], PERIOD_M5,1)>iClose(TradePairs[i], PERIOD_M5,0)){signals[i].Dir1=1;}else
      {signals[i].Dir1=2;}
      //M15
      if(iClose(TradePairs[i], PERIOD_M15,1)<iClose(TradePairs[i], PERIOD_M15,0) && iOpen(TradePairs[i], PERIOD_M15,1)<iClose(TradePairs[i], PERIOD_M15,0)){signals[i].Dir2=0;}else 
      if(iClose(TradePairs[i], PERIOD_M15,1)>iClose(TradePairs[i], PERIOD_M15,0) && iOpen(TradePairs[i], PERIOD_M15,1)>iClose(TradePairs[i], PERIOD_M15,0)){signals[i].Dir2=1;}else
      {signals[i].Dir2=2;}
      //M30
      if(iClose(TradePairs[i], PERIOD_M30,1)<iClose(TradePairs[i], PERIOD_M30,0) && iOpen(TradePairs[i], PERIOD_M30,1)<iClose(TradePairs[i], PERIOD_M30,0)){signals[i].Dir3=0;}else 
      if(iClose(TradePairs[i], PERIOD_M30,1)>iClose(TradePairs[i], PERIOD_M30,0) && iOpen(TradePairs[i], PERIOD_M30,1)>iClose(TradePairs[i], PERIOD_M30,0)){signals[i].Dir3=1;}else
      {signals[i].Dir3=2;}
      //H1
      if(iClose(TradePairs[i], PERIOD_H1,1)<iClose(TradePairs[i], PERIOD_H1,0) && iOpen(TradePairs[i], PERIOD_H1,1)<iClose(TradePairs[i], PERIOD_H1,0)){signals[i].Dir4=0;}else 
      if(iClose(TradePairs[i], PERIOD_H1,1)>iClose(TradePairs[i], PERIOD_H1,0) && iOpen(TradePairs[i], PERIOD_H1,1)>iClose(TradePairs[i], PERIOD_H1,0)){signals[i].Dir4=1;}else
      {signals[i].Dir4=2;}
      //H4
      if(iClose(TradePairs[i], PERIOD_H4,1)<iClose(TradePairs[i], PERIOD_H4,0) && iOpen(TradePairs[i], PERIOD_H4,1)<iClose(TradePairs[i], PERIOD_H4,0)){signals[i].Dir5=0;}else 
      if(iClose(TradePairs[i], PERIOD_H4,1)>iClose(TradePairs[i], PERIOD_H4,0) && iOpen(TradePairs[i], PERIOD_H4,1)>iClose(TradePairs[i], PERIOD_H4,0)){signals[i].Dir5=1;}else
      {signals[i].Dir5=2;}
      //D1
      if(iClose(TradePairs[i], PERIOD_D1,1)<iClose(TradePairs[i], PERIOD_D1,0) && iOpen(TradePairs[i], PERIOD_D1,1)<iClose(TradePairs[i], PERIOD_D1,0)){signals[i].Dir6=0;}else 
      if(iClose(TradePairs[i], PERIOD_D1,1)>iClose(TradePairs[i], PERIOD_D1,0) && iOpen(TradePairs[i], PERIOD_D1,1)>iClose(TradePairs[i], PERIOD_D1,0)){signals[i].Dir6=1;}else
      {signals[i].Dir6=2;}
      //W1
      if(iClose(TradePairs[i], PERIOD_W1,1)<iClose(TradePairs[i], PERIOD_W1,0) && iOpen(TradePairs[i], PERIOD_W1,1)<iClose(TradePairs[i], PERIOD_W1,0)){signals[i].Dir7=0;}else 
      if(iClose(TradePairs[i], PERIOD_W1,1)>iClose(TradePairs[i], PERIOD_W1,0) && iOpen(TradePairs[i], PERIOD_W1,1)>iClose(TradePairs[i], PERIOD_W1,0)){signals[i].Dir7=1;}else
      {signals[i].Dir7=2;}
      //MN1
      if(iClose(TradePairs[i], PERIOD_MN1,1)<iClose(TradePairs[i], PERIOD_MN1,0) && iOpen(TradePairs[i], PERIOD_MN1,1)<iClose(TradePairs[i], PERIOD_MN1,0)){signals[i].Dir8=0;}else 
      if(iClose(TradePairs[i], PERIOD_MN1,1)>iClose(TradePairs[i], PERIOD_MN1,0) && iOpen(TradePairs[i], PERIOD_MN1,1)>iClose(TradePairs[i], PERIOD_MN1,0)){signals[i].Dir8=1;}else
      {signals[i].Dir8=2;}
   }
   for (int i=0;i<ArraySize(TradePairs);i++){
      for(int j=0;j<3;j++){
            if(            
                     (signals[i].Dir0==0 || AI_Candle_Direction_TF1==false)
                  && (signals[i].Dir1==0 || AI_Candle_Direction_TF2==false)
                  && (signals[i].Dir2==0 || AI_Candle_Direction_TF3==false)
                  && (signals[i].Dir3==0 || AI_Candle_Direction_TF4==false)
                  && (signals[i].Dir4==0 || AI_Candle_Direction_TF5==false)
                  && (signals[i].Dir5==0 || AI_Candle_Direction_TF6==false)
                  && (signals[i].Dir6==0 || AI_Candle_Direction_TF7==false)
                  && (signals[i].Dir7==0 || AI_Candle_Direction_TF8==false)
                  && (signals[i].Dir8==0 || AI_Candle_Direction_TF9==false)
              ){
                  if(AI_Candle_Direction_TF1==true){ColorPanel("C"+(string)i+"D"+(string)0,clrTurquoise,C'61,61,61');} 
                  if(AI_Candle_Direction_TF2==true){ColorPanel("C"+(string)i+"D"+(string)1,clrTurquoise,C'61,61,61');} 
                  if(AI_Candle_Direction_TF3==true){ColorPanel("C"+(string)i+"D"+(string)2,clrTurquoise,C'61,61,61');} 
                  if(AI_Candle_Direction_TF4==true){ColorPanel("C"+(string)i+"D"+(string)3,clrTurquoise,C'61,61,61');} 
                  if(AI_Candle_Direction_TF5==true){ColorPanel("C"+(string)i+"D"+(string)4,clrTurquoise,C'61,61,61');} 
                  if(AI_Candle_Direction_TF6==true){ColorPanel("C"+(string)i+"D"+(string)5,clrTurquoise,C'61,61,61');} 
                  if(AI_Candle_Direction_TF7==true){ColorPanel("C"+(string)i+"D"+(string)6,clrTurquoise,C'61,61,61');} 
                  if(AI_Candle_Direction_TF8==true){ColorPanel("C"+(string)i+"D"+(string)7,clrTurquoise,C'61,61,61');} 
                  if(AI_Candle_Direction_TF9==true){ColorPanel("C"+(string)i+"D"+(string)8,clrTurquoise,C'61,61,61');} 
                  signals[i].Signal_Direction="BUY";
               }else if(
                     (signals[i].Dir0==1 || AI_Candle_Direction_TF1==false)
                  && (signals[i].Dir1==1 || AI_Candle_Direction_TF2==false)
                  && (signals[i].Dir2==1 || AI_Candle_Direction_TF3==false)
                  && (signals[i].Dir3==1 || AI_Candle_Direction_TF4==false)
                  && (signals[i].Dir4==1 || AI_Candle_Direction_TF5==false)
                  && (signals[i].Dir5==1 || AI_Candle_Direction_TF6==false)
                  && (signals[i].Dir6==1 || AI_Candle_Direction_TF7==false)
                  && (signals[i].Dir7==1 || AI_Candle_Direction_TF8==false)
                  && (signals[i].Dir8==1 || AI_Candle_Direction_TF9==false)
              ){
                  if(AI_Candle_Direction_TF1==true){ColorPanel("C"+(string)i+"D"+(string)0,clrViolet,C'61,61,61');} 
                  if(AI_Candle_Direction_TF2==true){ColorPanel("C"+(string)i+"D"+(string)1,clrViolet,C'61,61,61');} 
                  if(AI_Candle_Direction_TF3==true){ColorPanel("C"+(string)i+"D"+(string)2,clrViolet,C'61,61,61');} 
                  if(AI_Candle_Direction_TF4==true){ColorPanel("C"+(string)i+"D"+(string)3,clrViolet,C'61,61,61');} 
                  if(AI_Candle_Direction_TF5==true){ColorPanel("C"+(string)i+"D"+(string)4,clrViolet,C'61,61,61');} 
                  if(AI_Candle_Direction_TF6==true){ColorPanel("C"+(string)i+"D"+(string)5,clrViolet,C'61,61,61');} 
                  if(AI_Candle_Direction_TF7==true){ColorPanel("C"+(string)i+"D"+(string)6,clrViolet,C'61,61,61');} 
                  if(AI_Candle_Direction_TF8==true){ColorPanel("C"+(string)i+"D"+(string)7,clrViolet,C'61,61,61');} 
                  if(AI_Candle_Direction_TF9==true){ColorPanel("C"+(string)i+"D"+(string)8,clrViolet,C'61,61,61');} 
                  signals[i].Signal_Direction="SELL";
               }else {
                  if(AI_Candle_Direction_TF1==true){ColorPanel("C"+(string)i+"D"+(string)0,SetClrDir(signals[i].Dir0),C'61,61,61');}else {ColorPanel("C"+(string)i+"D"+(string)0,C'30,30,30',C'61,61,61');}
                  if(AI_Candle_Direction_TF2==true){ColorPanel("C"+(string)i+"D"+(string)1,SetClrDir(signals[i].Dir1),C'61,61,61');}else {ColorPanel("C"+(string)i+"D"+(string)1,C'30,30,30',C'61,61,61');}
                  if(AI_Candle_Direction_TF3==true){ColorPanel("C"+(string)i+"D"+(string)2,SetClrDir(signals[i].Dir2),C'61,61,61');}else {ColorPanel("C"+(string)i+"D"+(string)2,C'30,30,30',C'61,61,61');}
                  if(AI_Candle_Direction_TF4==true){ColorPanel("C"+(string)i+"D"+(string)3,SetClrDir(signals[i].Dir3),C'61,61,61');}else {ColorPanel("C"+(string)i+"D"+(string)3,C'30,30,30',C'61,61,61');}
                  if(AI_Candle_Direction_TF5==true){ColorPanel("C"+(string)i+"D"+(string)4,SetClrDir(signals[i].Dir4),C'61,61,61');}else {ColorPanel("C"+(string)i+"D"+(string)4,C'30,30,30',C'61,61,61');}
                  if(AI_Candle_Direction_TF6==true){ColorPanel("C"+(string)i+"D"+(string)5,SetClrDir(signals[i].Dir5),C'61,61,61');}else {ColorPanel("C"+(string)i+"D"+(string)5,C'30,30,30',C'61,61,61');}
                  if(AI_Candle_Direction_TF7==true){ColorPanel("C"+(string)i+"D"+(string)6,SetClrDir(signals[i].Dir6),C'61,61,61');}else {ColorPanel("C"+(string)i+"D"+(string)6,C'30,30,30',C'61,61,61');}
                  if(AI_Candle_Direction_TF8==true){ColorPanel("C"+(string)i+"D"+(string)7,SetClrDir(signals[i].Dir7),C'61,61,61');}else {ColorPanel("C"+(string)i+"D"+(string)7,C'30,30,30',C'61,61,61');}
                  if(AI_Candle_Direction_TF9==true){ColorPanel("C"+(string)i+"D"+(string)8,SetClrDir(signals[i].Dir8),C'61,61,61');}else {ColorPanel("C"+(string)i+"D"+(string)8,C'30,30,30',C'61,61,61');}
                  signals[i].Signal_Direction="FLAT";
               }
         }
   }
}
color SetClrDir(int Value){
   if(Value==0){return (clrLime);}else
   if(Value==1){return (clrRed);}else
   {return (clrSilver);}
}
void GetStochastic(){
//+------------------------------------------------------------------+
//| Custom Stochastic initialization function                        |
//+------------------------------------------------------------------+
//bool show_stoch_1 = true;
int kPeriod_1 = kPeriod_1;
int Slowing_1 = Slowing_1;//3
int dPeriod_1 = dPeriod_1;//3
int maMethod_1= maMethod_1;
int priceField_1=priceField_1;

//bool show_stoch_2 = true;
int kPeriod_2 = kPeriod_2;
int Slowing_2 = Slowing_2;//3
int dPeriod_2 = dPeriod_2;//3
int maMethod_2= maMethod_2;
int priceField_2=priceField_2;

//bool show_stoch_3 = true;
int kPeriod_3 = kPeriod_3;
int Slowing_3 = Slowing_3;//3
int dPeriod_3 = dPeriod_3;//3
int maMethod_3= maMethod_3;
int priceField_3=priceField_3;

string ThisPair="";

//+------------------------------------------------------------------+
   for (int i=0;i<ArraySize(TradePairs);i++){
         color clr_bg_color= clrWhite;
         color clr_bg_txtcolor= clrBlack;
         ThisPair=TradePairs[i];
         signals[i].Stochastic1A = iStochastic(ThisPair, TF_StochasticM30,kPeriod_1,dPeriod_1, Slowing_1, maMethod_1, priceField_1,MODE_MAIN,0);
         signals[i].Stochastic1B  = iStochastic(ThisPair, TF_StochasticM30,kPeriod_1,dPeriod_1, Slowing_1, maMethod_1, priceField_1,MODE_MAIN,1);
         
         signals[i].Stochastic2A  = iStochastic(ThisPair, TF_StochasticH1,kPeriod_2,dPeriod_2, Slowing_2, maMethod_2, priceField_2,MODE_MAIN,0);
         signals[i].Stochastic2B  = iStochastic(ThisPair, TF_StochasticH1,kPeriod_2,dPeriod_2, Slowing_2, maMethod_2, priceField_2,MODE_MAIN,1);
         
         signals[i].Stochastic3A  = iStochastic(ThisPair, TF_StochasticH4,kPeriod_3,dPeriod_3, Slowing_3, maMethod_3, priceField_3,MODE_MAIN,0);
         signals[i].Stochastic3B  = iStochastic(ThisPair, TF_StochasticH4,kPeriod_3,dPeriod_3, Slowing_3, maMethod_3, priceField_3,MODE_MAIN,1);
         
         if(
               (signals[i].Stochastic1A>=signals[i].Stochastic1B && signals[i].Stochastic1A>=AI_Stochastic_A_BUY_Dari && signals[i].Stochastic1A<=AI_Stochastic_A_BUY_Sampai)
            && (signals[i].Stochastic2A>=signals[i].Stochastic2B && signals[i].Stochastic2A>=AI_Stochastic_B_BUY_Dari && signals[i].Stochastic2A<=AI_Stochastic_B_BUY_Sampai)
            && (signals[i].Stochastic3A>=signals[i].Stochastic3B && signals[i].Stochastic3A>=AI_Stochastic_C_BUY_Dari && signals[i].Stochastic3A<=AI_Stochastic_C_BUY_Sampai)
           ){
               signals[i].Signal_Stochastic="BUY";
         }else if(
               (signals[i].Stochastic1A<=signals[i].Stochastic1B && signals[i].Stochastic1A<=AI_Stochastic_A_SELL_Dari && signals[i].Stochastic1A>=AI_Stochastic_A_SELL_Sampai)
            && (signals[i].Stochastic2A<=signals[i].Stochastic2B && signals[i].Stochastic2A<=AI_Stochastic_B_SELL_Dari && signals[i].Stochastic2A>=AI_Stochastic_B_SELL_Sampai)
            && (signals[i].Stochastic3A<=signals[i].Stochastic3B && signals[i].Stochastic3A<=AI_Stochastic_C_SELL_Dari && signals[i].Stochastic3A>=AI_Stochastic_C_SELL_Sampai)
           ){
               signals[i].Signal_Stochastic="SELL";
         }else{
               signals[i].Signal_Stochastic="FLAT";
         }
         EditText("TextStochastic1A"+(string)i,(string)DoubleToString(signals[i].Stochastic1A,0) +"%",SetClrStochastic(signals[i].Stochastic1A),7);   
         EditText("TextStochastic2A"+(string)i,(string)DoubleToString(signals[i].Stochastic2A,0) +"%",SetClrStochastic(signals[i].Stochastic2A),7);   
         EditText("TextStochastic3A"+(string)i,(string)DoubleToString(signals[i].Stochastic3A,0) +"%",SetClrStochastic(signals[i].Stochastic3A),7); 
   }         
}

color SetClrStochastic(double Value){
   if(Value>80){return (clrTurquoise);}else
   if(Value<=80 && Value>=60)
   {return (clrLime);}else
   if(Value<60 && Value>40)
   {return (clrWhite);}else
   if(Value<=40 && Value>20)
   {return (clrRed);}else
   if(Value<=20)
   {return (clrViolet);}else
   {return (clrWhite);}
}
void GetMACD(){
string pair="";
   for(int i=0; i<ArraySize(TradePairs); i++)
   {    
      pair=TradePairs[i];
      signals[i].MACD    = iMACD(pair,trigger_MACD_Timeframe,trigger_MACD_FastEMA,trigger_MACD_SlowEMA,trigger_MACD_SignalSMA,PRICE_CLOSE,MODE_MAIN,0);
      if(signals[i].MACD>0){signals[i].Signal_MACD="BUY";}else
      if(signals[i].MACD<0){signals[i].Signal_MACD="SELL";}else{signals[i].Signal_MACD="FLAT";}
      
      EditText("TextMACD"+(string)i,GetSymbol(NormalizeDouble(signals[i].MACD,3))+(string)DoubleToString(MathAbs(NormalizeDouble(signals[i].MACD,3)),3) +"%",SetClrMACD(NormalizeDouble(signals[i].MACD,3)),7);
   }
}
string GetSymbol(double Value){
   if(Value>0){return("+");}else
   if(Value<0){return("-");}else
   if(Value==0){return(" ");}else{return(" ");}
}
color SetClrMACD(double Value){
   if(Value>0){return(clrLime);}else
   if(Value<0){return(clrRed);}else
   if(Value==0){return(clrWhite);}else{return(clrWhite);}
}
void GetADX(){
   string pair="";
   for(int i=0; i<ArraySize(TradePairs); i++)
   {    
      pair=TradePairs[i];
      signals[i].ADX0    = iADX(pair,trigger_ADX_Timeframe,trigger_ADX_period, PRICE_CLOSE, MODE_MAIN, 0);
      signals[i].ADX1    = iADX(pair,trigger_ADX_Timeframe,trigger_ADX_period, PRICE_CLOSE, MODE_MAIN, 1);
      signals[i].ADX2    = iADX(pair,trigger_ADX_Timeframe,trigger_ADX_period, PRICE_CLOSE, MODE_PLUSDI, 0);
      signals[i].ADX3    = iADX(pair,trigger_ADX_Timeframe,trigger_ADX_period, PRICE_CLOSE, MODE_MINUSDI, 0);
      
       if(signals[i].ADX0>signals[i].ADX1&&signals[i].ADX2>signals[i].ADX3 ) {signals[i].Signal_ADX="BUY";}else//{
       if(signals[i].ADX0>signals[i].ADX1&&signals[i].ADX2<signals[i].ADX3 ) {signals[i].Signal_ADX="SELL";}else{signals[i].Signal_ADX="FLAT";}
      
      EditText("TextADX"+(string)i,(string)DoubleToString(signals[i].ADX0,0) +"%",SetClrADX(signals[i].ADX0,signals[i].ADX1,signals[i].ADX2,signals[i].ADX3),7);
   }
}

color SetClrADX(double Value0,double Value1,double Value2,double Value3){
         if ((Value0 > Value1 ) && (Value2 > Value3)){return (clrTurquoise);}else 
         if ((Value0 < Value1 ) && (Value2 > Value3)){return (clrLime);}else 
         if ((Value0 > Value1 ) && (Value2 < Value3)){return (clrViolet);}else
         if ((Value0 < Value1 ) && (Value2 < Value3)){return (clrRed);}else
         {return (clrWhite);}
}

void GetATR(){
   string pair="";
   for(int i=0; i<ArraySize(TradePairs); i++)
   {    
      pair=TradePairs[i];
      signals[i].ATR0    = iATR(pair,trigger_ATR_Timeframe,trigger_ATR_period,0);
      signals[i].ATR1    = iATR(pair,trigger_ATR_Timeframe,trigger_ATR_period,1);
      if(signals[i].ATR0>signals[i].ATR1){signals[i].Signal_ATR="BUY";}else//{
      if(signals[i].ATR0<signals[i].ATR1){signals[i].Signal_ATR="SELL";}else{signals[i].Signal_ATR="FLAT";}
      EditText("TextATR"+(string)i,(string)DoubleToString(signals[i].ATR0,4),clrGoldenrod,7);
      }
      //else
      {
      //EditText("TextATR"+(string)i,(string)DoubleToString(signals[i].ATR0,4),clrWhite,8);
      }
      
   }
//}

void GetWilliams(){
   string pair="";
   for(int i=0; i<ArraySize(TradePairs); i++)
   {    
      pair=TradePairs[i];
      signals[i].Williams_R0    = iWPR(pair,trigger_WILL_Timeframe,trigger_Williams_period,0);
      signals[i].Williams_R1    = iWPR(pair,trigger_WILL_Timeframe,trigger_Williams_period,1);
      if(signals[i].Williams_R0>signals[i].Williams_R1){signals[i].Signal_Williams="BUY";}else//{
      if(signals[i].Williams_R0<signals[i].Williams_R1){signals[i].Signal_Williams="SELL";}else{signals[i].Signal_Williams="FLAT";}
      EditText("TextWilliams"+(string)i,(string)DoubleToString(signals[i].Williams_R0,3),SetClrWilliams(signals[i].Williams_R0,signals[i].Williams_R1),7);
      }
      //else
      {
      //EditText("TextWilliams"+(string)i,(string)DoubleToString(signals[i].Signal_Williams,4),clrWhite,8);
      }
      
   }
//}

color SetClrWilliams(double Value0,double Value1){
if(MathAbs(Value0)>80){return(clrViolet);}else
if(MathAbs(Value0)>50){return(clrRed);}else
if(MathAbs(Value0)<20){return(clrTurquoise);}else
if(MathAbs(Value0)<50){return(clrLime);}else
{return(clrWhite);}
}
void GetRSI(){
   string pair="";
   for(int i=0; i<ArraySize(TradePairs); i++)
   {    
      pair=TradePairs[i];
      signals[i].RSI_A    = iRSI(pair,trigger_RSIA_Timeframe,trigger_RSIA_period,trigger_RSIA_Applied,trigger_RSIA_shift);
      signals[i].RSI_B    = iRSI(pair,trigger_RSIB_Timeframe,trigger_RSIB_period,trigger_RSIB_Applied,trigger_RSIB_shift);
      signals[i].RSI_C    = iRSI(pair,trigger_RSIC_Timeframe,trigger_RSIC_period,trigger_RSIC_Applied,trigger_RSIC_shift);
      
      if(
               (signals[i].RSI_A>=AI_RSI_A_BUY_Dari && signals[i].RSI_A<=AI_RSI_A_BUY_Sampai)
            && (signals[i].RSI_B>=AI_RSI_B_BUY_Dari && signals[i].RSI_B<=AI_RSI_B_BUY_Sampai)
            && (signals[i].RSI_C>=AI_RSI_C_BUY_Dari && signals[i].RSI_C<=AI_RSI_C_BUY_Sampai)
      ){
               signals[i].Signal_RSIA="BUY";
               signals[i].Signal_RSIB="BUY";
               signals[i].Signal_RSIC="BUY";
      }else if(
               (signals[i].RSI_A<=AI_RSI_A_SELL_Dari && signals[i].RSI_A>=AI_RSI_A_SELL_Sampai)
            && (signals[i].RSI_B<=AI_RSI_B_SELL_Dari && signals[i].RSI_B>=AI_RSI_B_SELL_Sampai)
            && (signals[i].RSI_C<=AI_RSI_C_SELL_Dari && signals[i].RSI_C>=AI_RSI_C_SELL_Sampai)
      ){
               signals[i].Signal_RSIA="SELL";
               signals[i].Signal_RSIB="SELL";
               signals[i].Signal_RSIC="SELL";
      }else{
               signals[i].Signal_RSIA="FLAT";
               signals[i].Signal_RSIB="FLAT";
               signals[i].Signal_RSIC="FLAT";
      }

      EditText("TextRSIA"+(string)i,(string)DoubleToString(signals[i].RSI_A,0) +"%",SetClrRSI(signals[i].RSI_A),7);   
      EditText("TextRSIB"+(string)i,(string)DoubleToString(signals[i].RSI_B,0) +"%",SetClrRSI(signals[i].RSI_B),7);   
      EditText("TextRSIC"+(string)i,(string)DoubleToString(signals[i].RSI_C,0) +"%",SetClrRSI(signals[i].RSI_C),7);
   }
   
}
color SetClrRSI(double Value){
   if(Value>80){return (clrTurquoise);}else
   if(Value<=80 && Value>=60){return (clrLime);}else
   if(Value<60 && Value>40){return (clrWhite);}else
   if(Value<=40 && Value>20){return (clrRed);}else
   if(Value<=20){return (clrViolet);}else
   {return (clrWhite);}
}
void AI_SCANING_SIGNALS(){

   for(int i=0; i<ArraySize(TradePairs); i++)
   {    
      if(
            (signals[i].Signal_Fibonacci=="BUY"    || AI_Fibonacci==false)
         && (signals[i].Signal_FibonacciB=="BUY"    || AI_FibonacciB==false)
         && (signals[i].Signal_FibonacciC=="BUY"    || AI_FibonacciC==false)
         && (signals[i].Signal_Direction=="BUY"    || AI_Candle_Direction==false)
         && (signals[i].Signal_Stochastic=="BUY"   || AI_Stochastic1==false)
         && (signals[i].Signal_Stochastic=="BUY"   || AI_Stochastic2==false)
         && (signals[i].Signal_Stochastic=="BUY"   || AI_Stochastic3==false)
         && (signals[i].Signal_ADX=="BUY"    || AI_ADX==false)
         && (signals[i].Signal_ATR=="BUY"   || AI_ATR==false)
         && (signals[i].Signal_Williams=="BUY"   || AI_WILL==false)
         && (signals[i].Signal_ADX=="BUY"     ||     AI_ADX==false) 
         && (signals[i].Signal_CCIA=="BUY"     ||     AI_CCIA==false)
         && (signals[i].Signal_CCIB=="BUY"     ||     AI_CCIB==false)
         && (signals[i].Signal_CCIC=="BUY"     ||     AI_CCIC==false)
         && (signals[i].Signal_RSIA=="BUY"          || AI_RSI_A==false)
         && (signals[i].Signal_RSIB=="BUY"          || AI_RSI_B==false)
         && (signals[i].Signal_RSIC=="BUY"          || AI_RSI_C==false)
      ){
         PenyetelanTampilan(0,i);        
          EditButton(IntegerToString(i)+"BUY","B",clrTurquoise,clrBlack);
          EditButton(IntegerToString(i)+"SELL","S",clrRed,clrBlack);
          EditButton(IntegerToString(i)+"CLOSE","C",clrSilver,clrBlack);
       }else 
      if(
            (signals[i].Signal_Fibonacci=="SELL"    || AI_Fibonacci==false)
         && (signals[i].Signal_FibonacciB=="SELL"    || AI_FibonacciB==false)
         && (signals[i].Signal_FibonacciC=="SELL"    || AI_FibonacciC==false)
         && (signals[i].Signal_Direction=="SELL"    || AI_Candle_Direction==false)
         && (signals[i].Signal_Stochastic=="SELL"   || AI_Stochastic1==false)
         && (signals[i].Signal_Stochastic=="SELL"   || AI_Stochastic2==false)
         && (signals[i].Signal_Stochastic=="SELL"   || AI_Stochastic3==false)
         && (signals[i].Signal_ADX=="SELL"  || AI_ADX==false)
         && (signals[i].Signal_ATR=="SELL"   || AI_ATR==false)
         && (signals[i].Signal_Williams=="SELL"   || AI_WILL==false)
         && (signals[i].Signal_ADX=="SELL"    ||     AI_ADX==false)
         && (signals[i].Signal_CCIA=="SELL"    ||     AI_CCIA==false)
         && (signals[i].Signal_CCIB=="SELL"    ||     AI_CCIB==false)
         && (signals[i].Signal_CCIC=="SELL"    ||     AI_CCIC==false)
         && (signals[i].Signal_RSIA=="SELL"          || AI_RSI_A==false)
         && (signals[i].Signal_RSIB=="SELL"          || AI_RSI_B==false)
         && (signals[i].Signal_RSIC=="SELL"          || AI_RSI_C==false)
      ){
         PenyetelanTampilan(1,i);
          EditButton(IntegerToString(i)+"BUY","B",clrLime,clrBlack);
          EditButton(IntegerToString(i)+"SELL","S",clrViolet,clrBlack);
          EditButton(IntegerToString(i)+"CLOSE","C",clrSilver,clrBlack);
      }
      else
      {
         PenyetelanTampilan(2,i);
          EditButton(IntegerToString(i)+"BUY","B",clrLime,clrBlack);
          EditButton(IntegerToString(i)+"SELL","S",clrRed,clrBlack);
          EditButton(IntegerToString(i)+"CLOSE","C",clrSilver,clrBlack);
      }
   }
}
//+------------------------------------------------------------------+
void GetMACD2() {

  for (int i=0;i<ArraySize(TradePairs);i++) {
//======================MACD=============== 
//int OnInit(void)
  {
  IndicatorDigits(Digits+1);
//--- drawing settings
  SetIndexStyle(0,DRAW_HISTOGRAM);
  SetIndexStyle(1,DRAW_LINE);
  SetIndexDrawBegin(1,SignPeriod);
//--- indicator buffers mapping
  SetIndexBuffer(0,ExtMacdBuffer);
  SetIndexBuffer(1,ExtSignalBuffer);
//--- name for DataWindow and indicator subwindow label
  IndicatorShortName("MACD("+IntegerToString(FastPeriod)+","+IntegerToString(SlowPeriod)+","+IntegerToString(SignPeriod)+")");
  SetIndexLabel(0,"MACD");
  SetIndexLabel(1,"Signal");
//--- check for input parameters
  if(FastPeriod<=1 || SlowPeriod<=1 || SignPeriod<=1 || FastPeriod>=SlowPeriod)
  {
  Print("Wrong input parameters");
  ExtParameters=false;
//return(INIT_FAILED);
  }
  else
  ExtParameters=false;
//--- initialization done
//return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Moving Averages Convergence/Divergence                           |
//+------------------------------------------------------------------+
/*int OnCalculate (const int rates_total,
  const int prev_calculated,
  const datetime& time[],
  const double& open[],
  const double& high[],
  const double& low[],
  const double& close[],
  const long& tick_volume[],
  const long& volume[],
  const int& spread[])
  {
  int i,limit;
//---
  if(rates_total<=InpSignalSMA || !ExtParameters)
  return(0);
//--- last counted bar will be recounted
  limit=rates_total-prev_calculated;
  if(prev_calculated>0)
  //limit++;
//--- macd counted in the 1-st buffer
  for(i=0; i<limit; i++)
  ExtMacdBuffer[i]=iMA(NULL,0,InpFastEMA,0,MODE_EMA,PRICE_CLOSE,i)-
  iMA(NULL,0,InpSlowEMA,0,MODE_EMA,PRICE_CLOSE,i);
//--- signal line counted in the 2-nd buffer
  SimpleMAOnBuffer(rates_total,prev_calculated,0,InpSignalSMA,ExtMacdBuffer,ExtSignalBuffer);
//--- done
  return(rates_total);
  }*/
//======================MACD===============02 
  double valuem = iMACD(TradePairs[i],periodMACD1,FastPeriod,SlowPeriod,SignPeriod,Price,MODE_MAIN  ,0); //Times[t] no lugar no period
  double values = iMACD(TradePairs[i],periodMACD1,FastPeriod,SlowPeriod,SignPeriod,Price,MODE_SIGNAL,0);
  if (valuem > 0)
  if (valuem > values) 
  signals[i].SignalMACDup01=UP;
  if (valuem < 0)
  if (valuem < values) 
  signals[i].SignalMACDdn01=DOWN; 
  /*signals[i].SignalMACDup=(signals[i].Signalham12==UP&&signals[i].Signalham52==UP);
  signals[i].SignalMACDdn=(signals[i].Signalham12==DOWN&&signals[i].Signalham52==DOWN);*/               
//MACD
}}
//======================INFORMAÇOES DE CONTA===============
//INFO ACCOUNT
 bool    ShowAccountOrderInfo    = true; //true
 bool    ShowProfitInfo          = true; 
 bool    ShowTodayRanges         = false;
 bool    ShowRiskInfo            = false; 
 
 int     RiskStopLoss            = 5;
 string  RiskLevels              = "1,5,10,20,40,50,60,80,100";

 bool    OnlyAttachedSymbol      = false;
 int     MagicNumber             = -1;
 string  CommentFilter           = "";
/*input*/ string  StartDateFilter         = "2024.09.20"; //ANO-MES-DIA
//input int     FontSize                = 8;
 bool    WhiteMode               = false;

int      windowIndex                   = 0;
string   preCurrSign                   = "";
string   postCurrSign                  = "";
double   pip_multiplier                = 1.0;
int      daySeconds                    = 86400;

double   MaxDD            = 0,
         MaxDDp           = 0,
         CurrentDD        = 0, 
         CurrentDDp       = 0;

datetime maxDDDay;
datetime startDateFilter = 0;
datetime LastDrawProfitInfo = 0;

//string   IndiName                      = "InfoTrade v1.0";

/*******************  Version history  ********************************
   
 
***********************************************************************/

//+------------------------------------------------------------------+
/*int init() 
{
//+------------------------------------------------------------------+
	//IndicatorShortName(IndiName);
   DeleteAllObject();

   SetPipMultiplier(Symbol());

   setCurrency();
   
   // Load today max DD from global
   maxDDDay     = getGlobalVar("TRADEINFO_DD_DAY", 0);
   if (maxDDDay >= iTime(Symbol(), PERIOD_D1, 0))
   {
      MaxDD    = getGlobalVar("TRADEINFO_MAXDD", 0);
      MaxDDp   = getGlobalVar("TRADEINFO_MAXDDP", 0);
   } else {
   
      maxDDDay = iTime(Symbol(), PERIOD_D1, 0);
      MaxDD    = 0;
      MaxDDp   = 0;      
   }
   
   if (StartDateFilter != "")
      startDateFilter = StrToTime(StartDateFilter);

   
   return(0);
}
*/
//+------------------------------------------------------------------+
int start() 
{
//+------------------------------------------------------------------+
   DoWork(); 

   return(0); 
}

//+------------------------------------------------------------------+
void DoWork() {
//+------------------------------------------------------------------+
//   windowIndex = WindowFind(IndiName);

   CalculateDailyDrawDown();

   if (ShowAccountOrderInfo) DrawAccountInfo();
   if (ShowAccountOrderInfo) DrawCurrentTrades();  
   if (ShowTodayRanges) DrawTodayRange();
   if (ShowProfitInfo) DrawProfitHistory();
   if (ShowRiskInfo) DrawRiskInfo(); 
   //DrawCopyright();
}

//+------------------------------------------------------------------+
//int deinit() {
//+------------------------------------------------------------------+
//   DeleteAllObject();

//  return(0);
//}

//+------------------------------------------------------------------+
void CalculateDailyDrawDown() {
//+------------------------------------------------------------------+
   double balance = AccountBalance();

   if (balance != 0)
   {
      CurrentDD = 0.0 - ( AccountMargin() + (AccountBalance() - AccountEquity()));
      CurrentDDp = MathDiv(CurrentDD, balance) * 100.0;

      if (CurrentDD < MaxDD || iTime(Symbol(), PERIOD_D1, 0) > maxDDDay)
      {
         MaxDD    = CurrentDD;
         MaxDDp   = CurrentDDp;
         maxDDDay = iTime(Symbol(), PERIOD_D1, 0);
         
         // Save to Global
         setGlobalVar("TRADEINFO_MAXDD",  MaxDD);
         setGlobalVar("TRADEINFO_MAXDDP", MaxDDp);
         setGlobalVar("TRADEINFO_DD_DAY", maxDDDay);
      }

   }
}

//+------------------------------------------------------------------+
double ND(double value, int decimal = -1) { 
//+------------------------------------------------------------------+
   if (decimal == -1)
      decimal = Digits();
   
   return (NormalizeDouble(value, decimal)); 
}

//+------------------------------------------------------------------+
string CutAt(string& str, string sep) {
//+------------------------------------------------------------------+
   string res = "";
   
   int index = StringFind(str, sep, 0);
   if (index != -1)
   {
      if (index > 0) res = StringSubstr(str, 0, index);
      str = StringSubstr(str, index + StringLen(sep));    
   } else {
      res = str;
      str = "";
   }
   return(res);
}

//+------------------------------------------------------------------+
color levelColors[10] = {Lime, SpringGreen, SpringGreen, LawnGreen, Gold, Gold, DarkSalmon, Tomato, Tomato, FireBrick};
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
void DrawRiskInfo() {
//+------------------------------------------------------------------+
   SetPipMultiplier(Symbol());

   //if (RiskStopLoss > 0)
      //DrawText(1, 46, 370, "Risco Ordem (SL=" + RiskStopLoss + ")", WhiteMode?Black:White, FontSize=6); 
   //else
      //DrawText(1, 46, 370, "Risco Ordem", WhiteMode?Black:White, FontSize=6); 
   
//   DrawText(1, 1, 0, "-------------------", WhiteMode?Black:White, FontSize=8); 
   
   string levels = RiskLevels;
   int i = 0;
  
   while (StringLen(levels) > 0)
   {
      string c = StringTrimLeft(StringTrimRight(CutAt(levels, ",")));
      double value = StringToDouble(c);
      
      if (value != EMPTY_VALUE) {
      
         color clr = levelColors[ArraySize(levelColors) - 1];
         if ( i < ArraySize(levelColors))
            clr = levelColors[i];            
      
         DrawText(1, i + 34, 375, StringConcatenate(value, "%:   ", DTS(MM(value), 2) + " lot"), clr, FontSize=7); 
         i++;
         
      }
   } 
}

//+------------------------------------------------------------------+
void DrawAccountInfo() {
//+------------------------------------------------------------------+
   SetPipMultiplier(Symbol());

   int row = 1;
   string text;
   int colWidth1 = 50;
   color c = WhiteMode?DarkBlue:LightCyan;
   text = StringConcatenate("Saldo:  ", MTS(AccountBalance())); 
   DrawText(0, row, 165, text, c, FontSize =6); 
   
   double eqPercent = 0;
   if (AccountBalance() > 0)
      eqPercent = MathDiv(AccountEquity(), AccountBalance() * 100.0);
   
   text = StringConcatenate("Equity:  ", MTS(AccountEquity()), "  (", DTS(eqPercent, 2), "%)"); 
   DrawText(0, row, colWidth1-45, text, c, FontSize); 
   row++;
   double marginLevel = 0;
   
   if (AccountMargin() > 0) marginLevel = MathDiv(AccountEquity(), AccountMargin() * 100.0);
   text = StringConcatenate("Margem: ", DTS(AccountMargin(), 2), "  (", DTS(marginLevel, 2), "%)"); 
   DrawText(0, row, 165, text, c, FontSize); 
   
   if (AccountFreeMargin() < 0)
      c = Red;
   text = StringConcatenate("Margem Livre: ", DTS(AccountFreeMargin(), 2)); 
   DrawText(0, row, colWidth1-45, text, c, FontSize); 
   row++;
   c = WhiteMode?DarkBlue:LightCyan;

   text = StringConcatenate("Alavancagem: 1:", AccountLeverage()); 
   DrawText(0, row, 165, text, c, FontSize); 
   
   text = StringConcatenate("Swap  Compra: ", MTS(MarketInfo(Symbol(), MODE_SWAPLONG), 2), "  Venda: ", MTS(MarketInfo(Symbol(), MODE_SWAPSHORT), 2)); 
   DrawText(0, row, colWidth1-45, text, c, FontSize); 
   row++;

//   DrawText(0, row, 0, "------------------------------------------------------------------", Gray, FontSize); 
}

//+------------------------------------------------------------------+
bool IsValidOrder() {
//+------------------------------------------------------------------+
   if (!OnlyAttachedSymbol || OrderSymbol() == Symbol()) 
      if ( MagicNumber == -1 || MagicNumber == OrderMagicNumber() )
         if (CommentFilter == "" || StringFind(OrderComment(), CommentFilter) != -1)
            return(true);

   return(false);
}

//+------------------------------------------------------------------+
void DrawCurrentTrades() {
//+------------------------------------------------------------------+
   int buyCount, sellCount = 0;
   double buyProfit, sellProfit, buyLot, sellLot, buyPip, sellPip = 0;
   double slPip, tpPip;
   double allTPPips, allSLPips = 0;
   double maxLoss, maxProfit = 0;
   color c = White;
   string text = "";
   int colWidth1 = 200;

   for (int i = OrdersTotal() - 1; i >= 0; i--)
      if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
         if ( IsValidOrder() )
         {
            slPip = 0;
            tpPip = 0;
            if (OrderType() == OP_BUY) {
               buyCount++;
               buyProfit += OrderProfit() + OrderSwap() + OrderCommission();
               buyLot += OrderLots();
               buyPip += point2pip(MarketInfo(OrderSymbol(), MODE_BID) - OrderOpenPrice(), OrderSymbol());

               if (OrderStopLoss() > 0.0) slPip = point2pip(OrderOpenPrice() - OrderStopLoss(), OrderSymbol());
               if (OrderTakeProfit() > 0.0) tpPip = point2pip(OrderTakeProfit() - OrderOpenPrice(), OrderSymbol());
                  
            } else if (OrderType() == OP_SELL) {
               sellCount++;
               sellProfit += OrderProfit() + OrderSwap() + OrderCommission();
               sellLot += OrderLots();
               sellPip += point2pip(OrderOpenPrice() - MarketInfo(OrderSymbol(), MODE_BID), OrderSymbol());

               if (OrderStopLoss() > 0.0) slPip = point2pip(OrderStopLoss() - OrderOpenPrice(), OrderSymbol());
               if (OrderTakeProfit() > 0.0) tpPip = point2pip(OrderOpenPrice() - OrderTakeProfit(), OrderSymbol());
            }         
            if (slPip != 0) {
               maxLoss -= pip2money(slPip, OrderLots(), OrderSymbol());
               allSLPips -= slPip;
            }
            
            if (tpPip != 0) {
               maxProfit += pip2money(tpPip, OrderLots(), OrderSymbol()) + OrderSwap() + OrderCommission();
               allTPPips += tpPip;
            }
            
         }

   SetPipMultiplier(Symbol());

   int row = 0;

   //Spread   
   double spread = MathDiv(MarketInfo(Symbol(), MODE_SPREAD), pip_multiplier);
   if (spread < 3) c = WhiteMode?DarkGreen:LawnGreen; else c = Crimson;   
   //text = StringConcatenate("Spread: ", DTS(spread, 2)); 
   DrawText(0, row+1, 1150, text, c, FontSize=6); 

   //Drawdown
   if (CurrentDD < 0) c = WhiteMode?Red:LightPink; else if (CurrentDD == 0.0) c = WhiteMode?Black:White; else c = WhiteMode?DarkGreen:LawnGreen;
   //text = StringConcatenate("DD Corrente: ", DTS(CurrentDD, 2), "   (" + DTS(CurrentDDp, 2), "%)"); 
   DrawText(0, row, colWidth1=1010, text, c, FontSize=6); 
   row++;

   //Max daily Drawdown
   if (MaxDD < 0) c = WhiteMode?Red:LightPink; else if (MaxDD == 0.0) c = WhiteMode?Black:White; else c = WhiteMode?DarkGreen:LawnGreen;
   //text = StringConcatenate("DD Max. Diário: ", DTS(MaxDD, 2), "   (" + DTS(MaxDDp, 2), "%)"); 
   DrawText(0, row, colWidth1, text, c, FontSize=6); 
   row++;


   //Max loss + profit
   if (maxProfit < 0) c = FireBrick; else if (maxProfit > 0) c = WhiteMode?DarkGreen:LawnGreen; else c = WhiteMode?Black:White;
   text = StringConcatenate("Profit: ", MTS(maxProfit), "  (", DTS(allTPPips, 1), " pips)"); 
   DrawText(0, row, 470, text, c, FontSize=6); 

   if (maxLoss < 0) c = Red; else if (maxLoss > 0) c = WhiteMode?DarkGreen:LawnGreen; else c = WhiteMode?Black:White;
   double maxLossp = 0; if (AccountBalance() > 0) maxLossp = MathDiv(maxLoss, AccountBalance() * 100);
   text = StringConcatenate("Loss:  ", MTS(maxLoss), "  (", DTS(allSLPips, 1), " pips)"); 
   DrawText(0, row+1, colWidth1-540, text, c, FontSize=6); 
   row++;
   
//   DrawText(0, row, 0, "------------------------------------------------------------------", Gray, FontSize); 
   row++;

   //Order counts
   c = WhiteMode?DimGray:Gainsboro;
   text = StringConcatenate("Buy:    ", buyCount); 
   DrawText(0, row - 3, 320, text, c, FontSize=6); 
   text = StringConcatenate("Sell:    ", sellCount); 
   DrawText(0, row - 2, 320, text, c, FontSize=6);  

//   DrawText(0, row + 2, 0, "------------------------------------------------------------------", Gray, FontSize); 
   text = StringConcatenate("Total:  ", buyCount + sellCount); 
   DrawText(0, row - 1, 320, text, c, FontSize=6); 

   // Order lots
   text = StringConcatenate("Lot: ", DTS(buyLot, 2)); 
   DrawText(0, row - 3, 275, text, c, FontSize=6); 
   text = StringConcatenate("Lot: ", DTS(sellLot, 2)); 
   DrawText(0, row - 2 , 275, text, c, FontSize=6); 
   text = StringConcatenate("Lot: ", DTS(buyLot + sellLot, 2)); 
   DrawText(0, row - 1, 275, text, c, FontSize=6); 
   
   // Order profits
   if (buyProfit < 0) c = Crimson; else if (buyProfit == 0.0) c = WhiteMode?DimGray:Gainsboro; else c = WhiteMode?DarkGreen:LawnGreen;
   text = StringConcatenate("Profit: ", MTS(buyProfit), "   (", DTS(buyPip, 1), " pips)"); 
   DrawText(0, row - 3, colWidth1-645, text, c, FontSize=6); 


   if (sellProfit < 0) c = Crimson; else if (sellProfit == 0.0) c = WhiteMode?DimGray:Gainsboro; else c = WhiteMode?DarkGreen:LawnGreen;
   text = StringConcatenate("Profit: ", MTS(sellProfit), "   (", DTS(sellPip, 1), " pips)"); 
   DrawText(0, row - 2, colWidth1-645, text, c, FontSize=6); 

   if (buyProfit + sellProfit < 0) c = Crimson; else if (buyProfit + sellProfit == 0.0) c = WhiteMode?DimGray:Gainsboro; else c = WhiteMode?DarkGreen:LawnGreen;
   text = StringConcatenate("Profit: ", MTS(buyProfit + sellProfit), "   (", DTS(buyPip + sellPip, 1), " pips)"); 
   DrawText(0, row - 1, colWidth1-645, text, c, FontSize=6); 
}

//+------------------------------------------------------------------+
void DrawProfitHistory() {
//+------------------------------------------------------------------+
   if (LastDrawProfitInfo > TimeCurrent() - 10) return;
   LastDrawProfitInfo = TimeCurrent();

   datetime day, today, now, prevDay;
   
   int xOffset = 410;
   if (!ShowRiskInfo) xOffset = 415;

   DrawText(1, 39, xOffset - 208, "DATA", Gray, FontSize=7); 
   DrawText(1, 39, xOffset - 248, "PIPS", Gray, FontSize=7); 
   DrawText(1, 39, xOffset - 315, "PROFIT", Gray, FontSize=7); 
   DrawText(1, 39, xOffset - 373, "GAIN % ", Gray, FontSize=7); 
   DrawText(1, 39, xOffset - 410 , "LOTE", Gray, FontSize=7); 
//   DrawText(1, 1, xOffset     , "====================================", Gray, FontSize=8); 

   now = TimeCurrent();
   today = StrToTime(TimeToStr(now, TIME_DATE));

   DrawDayHistoryLine(xOffset-14, today, now, 12, "Today");

   day = today; prevDay = GetPreviousDay(day - daySeconds);
   DrawDayHistoryLine(xOffset-14, prevDay, day, 13, "Yesterday");

   day = prevDay; prevDay = GetPreviousDay(day - daySeconds);
   DrawDayHistoryLine(xOffset-14, prevDay, day, 14);

   day = prevDay; prevDay = GetPreviousDay(day - daySeconds);
   DrawDayHistoryLine(xOffset-14, prevDay, day, 15);

   day = prevDay; prevDay = GetPreviousDay(day - daySeconds);
   DrawDayHistoryLine(xOffset-14, prevDay, day, 16);
   
   day = DateOfMonday();
   DrawDayHistoryLine(xOffset-14, day, now, 17, "Week");

   day = StrToTime(Year()+"."+Month()+".01");
   DrawDayHistoryLine(xOffset-14, day, now, 18, "Month");

   day = StrToTime(Year()+".01.01");
   DrawDayHistoryLine(xOffset-14, day, now, 19, "Year");
   
//   DrawText(1, 10, xOffset, "====================================", Gray, FontSize=8); 

   // Daily & Monthly profit
   if (AccountBalance() != 0.0)
   {
      double pips, profit, lots = 0;
      datetime firstOrderTime = GetHistoryInfoFromDate(day, now, pips, profit, lots);
      if (now - firstOrderTime != 0)
      {
         int oneDay = 86400; //int oneMonth = oneDay * 30.4;
         double daily   = MathDiv(MathDiv(profit, MathDiv(now - firstOrderTime, oneDay)), (AccountBalance() - profit)) * 100.0;
         double monthly = daily * 30.4;

         DrawText(1, 45, xOffset = 165, StringConcatenate("Monthly: ", DTS(monthly, 2), "%"), ColorOnSign(monthly), FontSize=8); 
         DrawText(1, 45, xOffset - 160, StringConcatenate("Daily: ", DTS(daily, 2), "%"), ColorOnSign(daily), FontSize=8); 
      }
   }

//   DrawText(1, 12, xOffset = 360, "====================================", Gray, FontSize=8); 
}

//+------------------------------------------------------------------+
double MathDiv(double a, double b) {
//+------------------------------------------------------------------+
   if (b != 0.0)
      return(a/b);

   return(0.0);
}  

//+------------------------------------------------------------------+
void DrawDayHistoryLine(int xOffset, datetime prevDay, datetime day, int row, string header = "") {
//+------------------------------------------------------------------+
   if (header == "") header = TimeToStr(prevDay, TIME_DATE); 

   double pips, profit, percent, lots = 0.0;
   string text;
   
   GetHistoryInfoFromDate(prevDay, day, pips, profit, lots);
   double profitp = 0;
   if (AccountBalance() > 0) profitp = MathDiv(profit, (AccountBalance() - profit)) * 100.0;
   
   text = StringConcatenate(header, ": "); 
   DrawText(1, row+25, xOffset - 200, text, WhiteMode?DimGray:Gray, FontSize=8); 

   text = DTS(pips, 1); 
   DrawText(1, row+25, xOffset - 235, text, ColorOnSign(pips), FontSize=8); 

   text = MTS(profit); 
   DrawText(1, row+25, xOffset - 285, text, ColorOnSign(profit), FontSize=8); 

   text = StringConcatenate(DTS(profitp, 2), "%"); 
   DrawText(1, row+25, xOffset - 350, text, ColorOnSign(profitp), FontSize=8); 

   text = DTS(lots, 2); 
   DrawText(1, row+25, xOffset - 395, text, ColorOnSign(profit), FontSize=8); 
}

//+------------------------------------------------------------------+
void DrawTodayRange() {
//+------------------------------------------------------------------+
   string text;
   
   SetPipMultiplier(Symbol());
   
   double todayPips = point2pip(iHigh(NULL, PERIOD_H1, 0) - iLow(NULL, PERIOD_H1, 0));
   double yesterdayPips = point2pip(iHigh(NULL, PERIOD_H1, 1) - iLow(NULL, PERIOD_H1, 1));

   double thisWeekPips = point2pip(iHigh(NULL, PERIOD_H4, 0) - iLow(NULL, PERIOD_H4, 0));
   double lastWeekPips = point2pip(iHigh(NULL, PERIOD_H4, 1) - iLow(NULL, PERIOD_H4, 1));

   double thisMonthPips = point2pip(iHigh(NULL, PERIOD_D1, 0) - iLow(NULL, PERIOD_D1, 0));
   double lastMonthPips = point2pip(iHigh(NULL, PERIOD_D1, 1) - iLow(NULL, PERIOD_D1, 1));
   
   int colWidth2 = 830;
   int colWidth3 = 950;
   int row = 28;
   color c = C'141,176,241';
   DrawText(0, row+12, colWidth2, "Today range:", c, FontSize=8);                  DrawText(0, row+12, colWidth3, StringConcatenate(DTS(todayPips, 1), " pips"), c, FontSize=8); 
   DrawText(0, row + 13, colWidth2, "Yesterday range:", c, FontSize=8);          DrawText(0, row + 13, colWidth3, StringConcatenate(DTS(yesterdayPips, 1), " pips"), c, FontSize=8); 
   row += 2;
   
   c = C'103,150,237';
   DrawText(0, row+12, colWidth2, "This week range:", c, FontSize=8);              DrawText(0, row+12, colWidth3, StringConcatenate(DTS(thisWeekPips, 1), " pips"), c, FontSize=8); 
   DrawText(0, row + 13, colWidth2, "Last week range:", c, FontSize=8);          DrawText(0, row + 13, colWidth3, StringConcatenate(DTS(lastWeekPips, 1), " pips"), c, FontSize=8); 
   row += 2;

   c = C'65,123,233';
   DrawText(0, row+12, colWidth2, "This month range:", c, FontSize=8);             DrawText(0, row+12, colWidth3, StringConcatenate(DTS(thisMonthPips, 1), " pips"), c, FontSize=8); 
   DrawText(0, row + 13, colWidth2, "Last month range:", c, FontSize=8);         DrawText(0, row + 13, colWidth3, StringConcatenate(DTS(lastMonthPips, 1), " pips"), c, FontSize=8); 
   row += 2;


   datetime nextCandleTime = (Period() * 1440) - (TimeCurrent() - iTime(NULL, 0, 0));

   c = WhiteMode?Orange:Bisque;
   //DrawText(0, row+10, colWidth2, "Novo Dia:", c, FontSize=10);                  DrawText(0, row+10, colWidth3, TimeToStr(nextCandleTime, TIME_SECONDS), c, FontSize=10); 
}

//+------------------------------------------------------------------+
//void DrawCopyright() {
//+------------------------------------------------------------------+
//   string text = StringConcatenate(IndiName, " - Created by Samurai FX - fb.com/FenixCapital.Ltda"); 
//   DrawText(3, 0, 0, text, DimGray, 7);
//}

//+------------------------------------------------------------------+
datetime GetHistoryInfoFromDate(datetime prevDay, datetime day, double &pips, double &profit, double &lots) {
//+------------------------------------------------------------------+
   datetime res = day;
   int i, k = OrdersHistoryTotal();
   pips = 0;
   profit = 0;
   lots = 0;
  
   for (i = 0; i < k; i++) {
      if (OrderSelect(i, SELECT_BY_POS, MODE_HISTORY)) {
         if ( IsValidOrder() ) {
           if (OrderType()==OP_BUY || OrderType()==OP_SELL) {
               if (day >= OrderCloseTime() && OrderCloseTime() >= prevDay && OrderCloseTime() > startDateFilter) {
                  profit += OrderProfit() + OrderCommission() + OrderSwap();

                  if (OrderType() == OP_BUY) {
                     pips += point2pip(OrderClosePrice() - OrderOpenPrice(), OrderSymbol());
                  }
                  if (OrderType() == OP_SELL) {
                     pips += point2pip(OrderOpenPrice() - OrderClosePrice(), OrderSymbol());
                  }                  
                  lots += OrderLots();
                  
                  if (OrderCloseTime() < res) res = OrderCloseTime();
               }
            }
         }
      }
   }
   return(res);
}

//+------------------------------------------------------------------+
datetime GetPreviousDay(datetime curDay) {
//+------------------------------------------------------------------+
   datetime prevDay = curDay;
   
   while (TimeDayOfWeek(prevDay) < 1 || TimeDayOfWeek(prevDay) > 5) prevDay -= daySeconds;
   return(prevDay);
}

//+------------------------------------------------------------------+
datetime DateOfMonday(int no = 0) {
//+------------------------------------------------------------------+
  datetime dt = StrToTime(TimeToStr(TimeCurrent(), TIME_DATE));

  while (TimeDayOfWeek(dt) != 1) dt -= daySeconds;
  dt += no * 7 * daySeconds;

  return(dt);
}

color ColorOnSign(double value) {
  color lcColor = WhiteMode?DimGray:Gray;

  if (value > 0) lcColor = WhiteMode?DarkGreen:Green;
  if (value < 0) lcColor = FireBrick;

  return(lcColor);
}

//+------------------------------------------------------------------+
double MM(double Risk) {
//+------------------------------------------------------------------+
   double SL = RiskStopLoss;
   double NewLOT = 0;

   string Symb = Symbol();                                                    // Symb default value
   double One_Lot = MarketInfo(Symb,MODE_MARGINREQUIRED);                     // margin for 1 LOT
   double Min_Lot = MarketInfo(Symb,MODE_MINLOT);                             // Minimum LOT
   double Max_Lot = MarketInfo(Symb,MODE_MAXLOT);                             // Maximum LOT
   double Step   = MarketInfo(Symb,MODE_LOTSTEP);                             // Lot step
   double Free   = AccountFreeMargin();                                       // Free margin
//-------------------------------------------------------------------------------
   if (SL > 0)                                                                // If set StopLoss
   {               
      double RiskAmount = AccountEquity() * (Risk / 100);                     // Calc risk in money
      double tickValue = MarketInfo(Symb, MODE_TICKVALUE) * pip_multiplier;   // Get how many pips 1 unit price
      
      if (tickValue * SL != 0) NewLOT = RiskAmount / (tickValue * SL);        // Divide Risk price with SL price
      if (Step > 0) NewLOT = MathFloor(NewLOT / Step) * Step; //Round         // Round LOT to step
   }
//-------------------------------------------------------------------------------
   else                                                                       // Dynamic LOT calculation
   {                                                        
      if (Risk > 100)                                                         // If greater then 100
         Risk = 100;                                                          // then 100%
      if (Risk == 0)                                                          // If 0
         NewLOT = Min_Lot;                                                    // then minimal LOT
      else                                                                    
         if (Step > 0 && One_Lot > 0) 
            NewLOT = MathFloor(Free * Risk / 100 / One_Lot / Step) * Step;    // Calc by Risk and round to step
   }
//-------------------------------------------------------------------------------
   if (NewLOT < Min_Lot)                                                      // If smaller than minimum
      NewLOT = Min_Lot;                                                       // set to minimum LOT
   if (NewLOT > Max_Lot)                                                      // If greater than maximum
      NewLOT = Max_Lot;                                                       // set to maximum LOT
//-------------------------------------------------------------------------------
   double margin = NewLOT * One_Lot;                                          // Calc the required margin for LOT
   if (margin > AccountFreeMargin())                                          // If greater than the free
   {                                                                          // Message, alert, ...etczenet, alert....stb.       
      //string msg = "You have not enough money! Free margin: " + DTS(AccountFreeMargin(), 2) + ", Require: " + DTS(margin, 2); 
      //Log.Warning(msg);
      //Print(msg);
      //Alert(msg);
      return(0);                                                              // Return with 0. Skip the order open
   }
   return(NewLOT);                            
}

//+------------------------------------------------------------------+
void setCurrency() {
//+------------------------------------------------------------------+
   string currSign = AccountCurrency();
   if (currSign == "USD") {
      preCurrSign = "$";
      postCurrSign = postCurrSign;   
   } else if (currSign == "EUR") {
      preCurrSign = "";
      postCurrSign = postCurrSign;   
   } else {
      preCurrSign = "";
      postCurrSign = postCurrSign;   
   }
}

//+------------------------------------------------------------------+
string MTS(double value, int decimal = 2) {
//+------------------------------------------------------------------+
   return(StringConcatenate(preCurrSign, DTS(value, decimal), postCurrSign));
}

//+------------------------------------------------------------------+
string DTS(double value, int decimal = 0) { return(DoubleToStr(value, decimal)); }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
double point2pip(double point, string Symb = "") {
//+------------------------------------------------------------------+
   if (Symb == "") Symb = Symbol();

   SetPipMultiplier(Symb);
   
   return(MathDiv(MathDiv(point, MarketInfo(Symb, MODE_POINT)), pip_multiplier));
}

//+------------------------------------------------------------------+
double pip2money(double pip, double lot, string Symb) {
//+------------------------------------------------------------------+
   if (Symb == "") Symb = Symbol();

   SetPipMultiplier(Symb);

   double tickSize = MarketInfo(Symb, MODE_TICKSIZE);
   if (tickSize != 0)
   {
      double onePipValue = MarketInfo(Symb, MODE_TICKVALUE) * (MarketInfo(Symb, MODE_POINT) / tickSize);
      return((pip * pip_multiplier) * onePipValue * lot);
   } else return(0);
}

//+------------------------------------------------------------------+
double SetPipMultiplier(string Symb, bool simple = false) {
//+------------------------------------------------------------------+
   pip_multiplier = 1;
   int digit = MarketInfo(Symb, MODE_DIGITS);
   
   if (simple)
   {
      if (digit % 4 != 0) pip_multiplier = 10; 
        
   } else {
      if (digit == 5 || 
         (digit == 3 && StringFind(Symb, "JPY") > -1) ||     // If 3 digits and currency is JPY
         (digit == 2 && StringFind(Symb, "XAU") > -1) ||     // If 2 digits and currency is gold
         (digit == 2 && StringFind(Symb, "GOLD") > -1) ||    // If 2 digits and currency is gold
         (digit == 3 && StringFind(Symb, "XAG") > -1) ||     // If 3 digits and currency is silver
         (digit == 3 && StringFind(Symb, "SILVER") > -1) ||  // If 3 digits and currency is silver
         (digit == 1))                                       // If 1 digit (CFDs)
            pip_multiplier = 10;
      else if (digit == 6 || 
         (digit == 4 && StringFind(Symb, "JPY") > -1) ||     // If 4 digits and currency is JPY
         (digit == 3 && StringFind(Symb, "XAU") > -1) ||     // If 3 digits and currency is gold
         (digit == 3 && StringFind(Symb, "GOLD") > -1) ||    // If 3 digits and currency is gold
         (digit == 4 && StringFind(Symb, "XAG") > -1) ||     // If 4 digits and currency is silver
         (digit == 4 && StringFind(Symb, "SILVER") > -1) ||  // If 4 digits and currency is silver
         (digit == 2))                                       // If 2 digit (CFDs)
            pip_multiplier = 100;
   }  
   //Print("PipMultiplier: ", pip_multiplier, ", Digits: ", Digits);
   return(pip_multiplier);
}

//+------------------------------------------------------------------+
void DrawText(int corner, int row, int xOffset, string text, color c, int size = 7) {
//+------------------------------------------------------------------+
   string objName = "TradeInfo_" + DTS(corner) + "_" + DTS(xOffset) + "_" + DTS(row);
   if (ObjectFind(objName) != 0) {
      ObjectCreate(objName, OBJ_LABEL, windowIndex, 0, 0);
      ObjectSet(objName, OBJPROP_CORNER, corner);
      ObjectSet(objName, OBJPROP_SELECTABLE, 0);
      ObjectSet(objName, OBJPROP_HIDDEN, 1);
   }

   ObjectSetText(objName, text, size, "Verdana", c);
   ObjectSet(objName, OBJPROP_XDISTANCE, 6 + xOffset);
   ObjectSet(objName, OBJPROP_YDISTANCE, 6 + row * (size + 6));
   ObjectSet(objName, OBJPROP_BACK, false);
}

//+------------------------------------------------------------------+
double getGlobalVar(string name, double defaultValue = EMPTY_VALUE) {
//+------------------------------------------------------------------+
   if (GlobalVariableCheck(name))
      return (GlobalVariableGet(name));
   else 
      return (defaultValue);
}

//+------------------------------------------------------------------+
string setGlobalVar(string name, double value = EMPTY_VALUE) {
//+------------------------------------------------------------------+
   if (value == EMPTY_VALUE)
      GlobalVariableDel(name);
   else  
      GlobalVariableSet(name, value);
      
   return(name);
}

//+------------------------------------------------------------------+
void DeleteAllObject() {
//+------------------------------------------------------------------+
   for(int i = ObjectsTotal() - 1; i >= 0; i--)
      if(StringFind(ObjectName(i), "TradeInfo_", 0) >= 0)
         ObjectDelete(ObjectName(i));

}
//---
//-----------------------------------------------------------------------+
//-----------------------------------------------------------------------+    
void MarketSessionTimePanel() {

  int tokyoGMTOffset = 9;    // Tokyo GMT offset
  int londonGMTOffset = 1;  // During winter months, GMT+0. When Daylight Saving Time starts, GMT+1
  int newYorkGMTOffset = -4; // New York GMT offset
  int newZealandGMTOffset = 12; // New Zealand GMT offset 

  int MarketOpenHour = 9;    // 8 AM Session start time
  int MarketCloseHour = 17;  // 5 PM Session close time

  datetime gmtTime = TimeGMT();
  datetime localTime = TimeLocal();
  datetime brokerTime = TimeCurrent();

  datetime tokyoTime = brokerTime + tokyoGMTOffset * 3600 - brokerGMTOffset * 3600;
  datetime londonTime = brokerTime + londonGMTOffset * 3600 - brokerGMTOffset * 3600;
  datetime newYorkTime = brokerTime + newYorkGMTOffset * 3600 - brokerGMTOffset * 3600;
  datetime newZealandTime = brokerTime + newZealandGMTOffset * 3600 - brokerGMTOffset * 3600;

  string LocalTime = "Local:      " + TimeToString(localTime, TIME_DATE | TIME_MINUTES);
  string BrokerTime = "Broker:     " + TimeToString(brokerTime, TIME_DATE | TIME_MINUTES);
  string TokyoTime = "Tokyo:     " + TimeToString(tokyoTime, TIME_DATE | TIME_MINUTES);
  string LondonTime = "London:         " + TimeToString(londonTime, TIME_DATE | TIME_MINUTES);
  string NewYorkTime = "New York:     " + TimeToString(newYorkTime, TIME_DATE | TIME_MINUTES);
  string NewZealandTime = "New Zealand: " + TimeToString(newZealandTime, TIME_DATE | TIME_MINUTES);
  
  SetPanel("NewsTimePanel", 0, x_axis - 71 + 730, y_axis - 104 , 265, 38,C'10,10,10', C'61,61,61', 1);
   
  SetPanel("LocalTimePanel", 0, x_axis - 65 + 725, y_axis  - 102, 135, 11,C'10,10,10', C'10,10,10', 1);
  SetText("LocalTimeVal",LocalTime,x_axis - 65 + 5 + 725,y_axis - 102,clrLightGray,7);
   
  SetPanel("BrokerTimePanel", 0, x_axis - 65 + 725, y_axis - 91, 135, 11,C'10,10,10', C'10,10,10', 1);
  SetText("BrokerTimeVal",BrokerTime,x_axis - 65 + 4 + 725,y_axis - 91,clrLightGray,7);
   
  if (TimeHour(tokyoTime) >= MarketOpenHour && TimeHour(tokyoTime) <= MarketCloseHour) {
     SetPanel("TokyoTimePanel", 0, x_axis - 61 + 725, y_axis - 79, 120, 11,clrLimeGreen, C'10,10,10', 1);
     SetText("TokyoTimeVal",TokyoTime,x_axis - 66 + 5 + 725,y_axis - 79,clrBlack,7);
   } else {
     SetPanel("TokyoTimePanel", 0, x_axis - 61 + 725, y_axis - 79, 120, 11,C'10,10,10', C'10,10,10', 1);
     SetText("TokyoTimeVal",TokyoTime,x_axis - 66 + 5 + 725,y_axis - 79,clrLightGray,7);
   }
   
   if (TimeHour(londonTime) >= MarketOpenHour && TimeHour(londonTime) <= MarketCloseHour) {
     SetPanel("LondonTimePanel", 0, x_axis + 84 + 704, y_axis - 102, 135, 11,clrLimeGreen, C'10,10,10', 1);
     SetText("LondonTimeVal",LondonTime,x_axis + 89 + 5 + 695,y_axis - 102,clrBlack,7);
   } else {
     SetPanel("LondonTimePanel", 0, x_axis + 84 + 704, y_axis - 102, 135, 11,C'10,10,10', C'10,10,10', 1);
     SetText("LondonTimeVal",LondonTime,x_axis + 89 + 5 + 695,y_axis - 102,clrLightGray,7);
   }

   if (TimeHour(newYorkTime) >= MarketOpenHour && TimeHour(newYorkTime) <= MarketCloseHour) {
     SetPanel("NewYorkTimePanel", 0, x_axis + 84 + 704, y_axis - 90, 135, 11,clrLimeGreen, C'10,10,10', 1);
     SetText("NewYorkTimeVal",NewYorkTime,x_axis + 89 + 5 + 695,y_axis - 90,clrBlack,7);
   } else {
     SetPanel("NewYorkTimePanel", 0, x_axis + 84 + 704, y_axis - 90, 135, 11,C'10,10,10', C'10,10,10', 1);
     SetText("NewYorkTimeVal",NewYorkTime,x_axis + 89 + 5 + 695,y_axis - 90,clrLightGray,7);   
   }
   
      if (TimeHour(newZealandTime) >= MarketOpenHour && TimeHour(newZealandTime) <= MarketCloseHour) {
     SetPanel("NewZealandTimePanel", 0, x_axis + 84 + 704, y_axis - 79, 135, 11,clrLimeGreen, C'10,10,10', 1);
     SetText("NewZealandTimeVal",NewZealandTime,x_axis + 89 + 5 + 695,y_axis - 79,clrBlack,7);
   } else {
     SetPanel("NewZealandTimePanel", 0, x_axis + 84 + 704, y_axis - 79, 135, 11,C'10,10,10', C'10,10,10', 1);
     SetText("NewZealandTimeVal",NewZealandTime,x_axis + 89 + 5 + 695,y_axis - 79,clrLightGray,7);   
   }  
}
//-----------------------------------------------------------------------+ 
//FX SCANNER
enum ENUM_SYMBOL_SOURCE
{
   AUTO_LIST,
   USER_INPUT,
};

   

string INDI_NAME="MPSCN-";

/*extern*/ ENUM_SYMBOL_SOURCE SymbolSource = USER_INPUT;  //Select Where to get Symbol List
/*extern*/ string	PairsToTrade = "XAUUSD,XAGUSD,XPDUSD,XPTUSD,BRENT,CRUDE,NGAS,AU200,DE30,EU50,FR40,HK50,JP225,SP500,SPAIN35,UK100,US100,US30";

//string INDI_NAME="MPSCN-";
/*input*/ int TimerInterval=1; //Update interval (secs)
/*input*/ int FontSizeScanner=8;  //Font Size
//input string FontName="Calibri"; //Font Name
/*input*/ int ColumnHeight=30; //Max symbols per column

/*input*/ string Group0; //---------------------------------------------------
/*input*/ bool ShowPrice=false; //Show Price

/*input*/ string Group1; //---------------------------------------------------
/*input*/ bool ShowSpread=false; //Show Spread

/*input*/ string Group2; //---------------------------------------------------
/*input*/ bool ShowPrice_Percentage=false; //Show Price % Change
//input ENUM_TIMEFRAMES PCTimeframe=PERIOD_D1;

/*input*/ string Group3; //---------------------------------------------------
/*input*/ bool ShowATR_Value=false; //Show ATR Value
/*input*/ bool ShowATR_Percentage=false; //Show ATR Percentage
//input ENUM_TIMEFRAMES AtrTimeframe=PERIOD_D1; //ATR Timeframe
/*input*/ int AtrPeriod=5; //ATR Period
/*input*/ int AtrAlertLevel = 120; //ATR Alert Level


/*input*/ string Group4; //---------------------------------------------------
/*input*/ bool ShowVolume=false; //Show Volume
//input ENUM_TIMEFRAMES VolumeTimeframe=PERIOD_D1; //Volume Timeframe
/*input*/ int VolumePeriod=5; //Volume Period

/*input*/ string Group5; //---------------------------------------------------
/*input*/ bool ShowRsi=false; //Show RSI
//input ENUM_TIMEFRAMES RsiTimeframe=PERIOD_D1; //RSI Timeframe
//original RSI levle was 75 and 25 but that is a bit extream
/*input*/ int RsiPeriod=14; //RSI Period
/*input*/ int RsiUpperLevel = 40; //RSI Upper Level
/*input*/ int RsiLowerLevel = 60; //RSI Lower Level


/*input*/ string Group6; //---------------------------------------------------
/*input*/ bool ShowStoch=false; //Show Stochastic
//input ENUM_TIMEFRAMES StochTimeframe=PERIOD_D1; //Stoch Timeframe
/*input*/ int StochK = 20;   //%K period
/*input*/ int StochD = 3;   //%D period
/*input*/ int StochSlow = 3;//Slowing
/*input*/ ENUM_MA_METHOD StochMethod=MODE_EMA; //MA Method
/*input*/ ENUM_STO_PRICE StochPrice=STO_LOWHIGH; //Price Field
/*input*/ int StochUpperLevel = 60; //Stoch Upper Level
/*input*/ int StochLowerLevel = 40; //Stoch Lower Level



/*input*/ string Group7; //---------------------------------------------------
/*input*/ bool ShowAdx=false; //Show ADX
//input ENUM_TIMEFRAMES AdxTimeframe=PERIOD_D1; //ADX Timeframe
/*input*/ int AdxPeriod=20; //ADX Period
/*input*/ ENUM_APPLIED_PRICE AdxAppliedPrice=PRICE_CLOSE; //ADX Applied Price

/*input*/ string Group8; //---------------------------------------------------
/*input*/ bool ShowPivots=false; //Show Pivots

/*input*/ string Group9; //---------------------------------------------------
/*input*/ bool ShowMA=false; //Show MA
//input ENUM_TIMEFRAMES MATimeframe=PERIOD_D1; //MA Timeframe
/*input*/ int MAPeriod=20; //MA Period
/*input*/ ENUM_MA_METHOD MAMethod=MODE_EMA; //MA Method
/*input*/ ENUM_APPLIED_PRICE MAAppliedPrice=PRICE_CLOSE; //MA Applied

/*input*/ string Group10; //---------------------------------------------------
/*input*/ bool ShowExtremes=false; //Show Extreme Col
/*input*/ int ExtremesUpperLevel = 4;

/*extern*/ string  _AlertSetting = "---Alert Settings ---";
/*extern*/ bool   alertsOn            = false;  //Turn alerts on?
/*extern*/ bool   alertsMessage       = false;  //Alerts Message true/false?
/*extern*/ bool   alertsSound         = false;   //Alerts sound true/false?
/*extern*/ bool   alertsNotification  = false;  //Alerts push notification true/false?
/*extern*/ bool   alertsEmail         = false;  //Alerts email true/false?
/*extern*/ string  soundFile = "alert.wav";

int GUIXOffset = 675;//760
int GUIYOffset = 46;

int GUIHeaderXOffset = 20;
int GUIHeaderYOffset = 0;

int GUIColOffset=55;

int ListXOffset = 10;
int ListYOffset = 43;

int ListXMultiplier = 10;
int ListYMultiplier = 11;


 MqlRates       PCBar[];
 
 bool StochAlert = false;
 bool RSIAlert = false;
 bool ATRAlert = false;
 
 int AlertExtremes = 0;
 
 //Pair extraction
int		NoOfPairs;				// Holds the number of pairs passed by the user via the inputs screen
string	TradePair[];			//Array to hold the pairs traded by the user

double ATRrangePercent;
double RSIvalue;
double PIVOTvalue;
string PIVOTstringValue;
double STOCHvalue;


datetime TimeMissing;
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
long getAvgVolume(string symbol,int period)
  {
   long volume_total=0;
   for(int i=0; i<period; i++)
     {
      volume_total+=iVolume(symbol,PERIOD_GERAL,i);
     }
   return volume_total / period;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getRange(string symbol,int period)
  {
   int DataPeriod=PERIOD_GERAL;
   int DataBar=iBarShift(symbol,DataPeriod,Time[0]);
   double range = iHigh(symbol, period, DataBar) - iLow(symbol, period, DataBar);
   double point = MarketInfo(symbol, MODE_POINT);
   if(point > 0) return (NormalizeDouble(range / point, 0));
   return 1;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void DrawMissingTime(int deltaY=0)
  {
   int x=GUIXOffset+ListXOffset,y=20;

   //DrawLabel("CurTimeLbl",x,y,"Server Time:"+TimeToStr(TimeCurrent(),TIME_MINUTES),FontSize,FontName,clrWhite);
   //DrawLabel("LocalTimeLbl",x+=150,y,"Local Time:"+TimeToStr(TimeLocal(),TIME_MINUTES),FontSize,FontName,clrWhite);
   //DrawLabel("TimeLeftLbl",x+=150,y,"Time until Candle close:",FontSize,FontName,clrWhite);
   //DrawTimeMissingColum(PERIOD_M1,x+=150,y);
   //DrawTimeMissingColum(PERIOD_M5,x+=GUIColOffset,y);
   //DrawTimeMissingColum(PERIOD_M15,x+=GUIColOffset,y,30);
   //DrawTimeMissingColum(PERIOD_H1,x+=GUIColOffset, y);
   //DrawTimeMissingColum(PERIOD_H4,x+=GUIColOffset, y);
   //DrawTimeMissingColum(PERIOD_D1,x+=GUIColOffset, y);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void DrawTimeMissingColum(int period,int x,int y,int dxOffset=25)
  {
   int dx=x;
   color timeColor;
   string periodStr= GetPeriodStr(period);
   string timeLeft = GetTimeToClose(period, timeColor);

   DrawLabel("TimeLeftLbl_"+periodStr,dx,y,periodStr+":",FontSizeScanner,FontName,clrWhite);
   DrawLabel("TimeLeftVal_"+periodStr,dx+=dxOffset,y,timeLeft,FontSizeScanner,FontName,timeColor);

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string GetTimeToClose(int period,color &timeColor)
  {
   int periodMinutes = periodToMinutes(period);
   int shift         = periodMinutes*60;
   int currentTime   = (int)TimeCurrent();
   int localTime     = (int)TimeLocal();
   int barTime       = (int)iTime(period);
   int diff          = (int)MathMax(round((currentTime-localTime)/3600.0)*3600,-24*3600);

   string time=getTime(barTime+periodMinutes*60-localTime-diff,timeColor);
   time=(TerminalInfoInteger(TERMINAL_CONNECTED)) ? time : time+" x";

   return time;
  }
//+------------------------------------------------------------------+

void DrawLabel(string name,int x,int y,string label,int size=9,string font="Arial",color clr=DimGray,string tooltip="")
  {
   name=INDI_NAME+":"+name;
   ObjectDelete(name);
   ObjectCreate(name,OBJ_LABEL,0,0,0);
   ObjectSetText(name,label,size,font,clr);
   ObjectSet(name,OBJPROP_CORNER,0);
   ObjectSet(name,OBJPROP_XDISTANCE,x);
   ObjectSet(name,OBJPROP_YDISTANCE,y);
   ObjectSetString(0,name,OBJPROP_TOOLTIP,tooltip);
//--- justify text
//ObjectSet(name, OBJPROP_ANCHOR, 0);
//ObjectSetString(0, name, OBJPROP_TOOLTIP, tooltip);
//ObjectSet(name, OBJPROP_SELECTABLE, 0);
//---
  }
//+------------------------------------------------------------------+
//| The function sets chart background color.                        |
//+------------------------------------------------------------------+
bool ChartColorSet(int prop_id,const color clr,const long chart_ID=0)
  {
//--- reset the error value
   ResetLastError();
//--- set the chart background color
   if(!ChartSetInteger(chart_ID,prop_id,clr))
     {
      //--- display the error message in Experts journal
      Print(__FUNCTION__+", Error Code = ",GetLastError());
      return(false);
     }
//--- successful execution
   return(true);
  }
//+------------------------------------------------------------------+
//| Set chart display type (candlesticks, bars or                    |
//| line).                                                           |
//+------------------------------------------------------------------+
bool ChartModeSet(const long value,const long chart_ID=0)
  {
//--- reset the error value
   ResetLastError();
//--- set property value
   if(!ChartSetInteger(chart_ID,CHART_MODE,value))
     {
      //--- display the error message in Experts journal
      Print(__FUNCTION__+", Error Code = ",GetLastError());
      return(false);
     }
//--- successful execution
   return(true);
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
void DrawScanner()
  {
   Print("=============>DrawScanner");
 
   if (SymbolSource == USER_INPUT)
   {
      for(int x=0; x<NoOfPairs; x++)
      {
        DrawSymbol(TradePair[x],x);
        manageAlerts(TradePair[x]);
      }
      
   }
   else
    
   
      for(int x=0; x<SymbolsTotal(true); x++)
        {
         DrawSymbol(SymbolName(x,true),x);
         manageAlerts(SymbolName(x,true));
       
        }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void DrawSymbol(string symbolName,int symbolIdx)
  {
   AlertExtremes = 0;
   int yMult = (int)fmod(symbolIdx, ColumnHeight);
   int xMult = (symbolIdx/ColumnHeight);
   int x= (GUIXOffset+GUIHeaderXOffset) + (NumVisibleColumns()*GUIColOffset)*xMult;
   int y= GUIYOffset+ListYOffset + ListYMultiplier * yMult;
   int colOffset=GUIColOffset;

   DrawSymbolColumn(symbolName,x-685,y+365,symbolName,FontSizeScanner,FontName);///ESCONDER SIMBOLO

   if(ShowPrice)
      DrawPriceColumn(symbolName,x+=colOffset,y,symbolName,FontSizeScanner,FontName);
   if(ShowSpread)
      DrawSpreadColumn(symbolName,x+=colOffset,y,symbolName,FontSizeScanner,FontName);
   if(ShowPrice_Percentage)
      DrawPCColumn(symbolName,x+=colOffset,y,symbolName,FontSizeScanner,FontName);
   if(ShowATR_Value)
      DrawATRValueColumn(symbolName,x+=colOffset,y,symbolName,FontSizeScanner,FontName);
   if(ShowATR_Percentage)
      DrawATRPercentageColumn(symbolName,x+=colOffset,y,symbolName,FontSizeScanner,FontName);
   if(ShowVolume)
      DrawVolumeColumn(symbolName,x+=colOffset,y,symbolName,FontSizeScanner,FontName);
   if(ShowRsi)
      DrawRsiColumn(symbolName,x+=colOffset,y,symbolName,FontSizeScanner,FontName);
   if(ShowStoch)
      DrawStochColumn(symbolName,x+=colOffset,y,symbolName,FontSizeScanner,FontName);
   if(ShowAdx)
      DrawAdxColumn(symbolName,x+=colOffset,y,symbolName,FontSizeScanner,FontName);
   if(ShowPivots)
      DrawPivotsColumn(symbolName,x+=colOffset,y,symbolName,FontSizeScanner,FontName);
   if(ShowMA)
      DrawMAColumn(symbolName,x+=colOffset,y,symbolName,FontSizeScanner,FontName);
   if(ShowExtremes)
      DrawExtremesColumn(symbolName,x+=colOffset,y,symbolName,FontSizeScanner,FontName);
    WindowRedraw();
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

double getPoint(string symbol)
  {
   return MarketInfo(symbol,MODE_POINT);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getModifier(string symbol)
  {
   int digits=(int)MarketInfo(symbol,MODE_DIGITS);
   double modifier=1;
   if(digits==3 || digits==5)
      modifier=10.0;
   return modifier;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void DrawRsiColumn(string symbolName,int x,int y,string text,int fontSize=8,string fontName="Calibri")
  {
  
 

   double rsi=NormalizeDouble(iRSI(symbolName,PERIOD_GERAL,RsiPeriod,PRICE_CLOSE,0),0);
   string tooltip=symbolName+"\n.: "+GetPeriodStr(PERIOD_GERAL)+" RSI ("+IntegerToString(RsiPeriod)+"):.\nCurrent  ("+DoubleToStr(rsi,1)+")";
   DrawLabel("rsi_"+symbolName,x-930,y+365,DoubleToStr(rsi,1),fontSize,fontName,GetRsiColor(rsi),tooltip);
   RSIvalue = rsi;
   
   if (rsi <=  RsiLowerLevel || rsi >  RsiUpperLevel) 
    {
       RSIAlert = true;
       AlertExtremes++;
    }
   else 
       RSIAlert = false;
       
  
         
       
   
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void DrawStochColumn(string symbolName,int x,int y,string text,int fontSize=8,string fontName="Calibri")
  {
  


   double stoch=iStochastic(symbolName,PERIOD_GERAL,StochK,StochD,StochSlow,StochMethod,StochPrice,MODE_MAIN,0);
   string tooltip=symbolName+"\n.: "+GetPeriodStr(PERIOD_GERAL)+" Stoch :.\nCurrent  ("+DoubleToStr(stoch,1)+")";
   DrawLabel("stoch_"+symbolName,x-950,y+365,DoubleToStr(stoch,1),fontSize,fontName,GetStochColor(stoch),tooltip);
   STOCHvalue = stoch;
   
   
   if(stoch>=StochUpperLevel || stoch<=StochLowerLevel )
   {
   
      StochAlert = true; 
      AlertExtremes++;
   }
   else
      StochAlert = false;
   
   
      

   
   
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void DrawAdxColumn(string symbolName,int x,int y,string text,int fontSize=8,string fontName="Calibri")
  {
   double adx=iADX(symbolName,PERIOD_GERAL,AdxPeriod,AdxAppliedPrice,MODE_MAIN,0);
   string tooltip=symbolName+"\n.: "+GetPeriodStr(PERIOD_GERAL)+" ADX ("+IntegerToString(AdxPeriod)+"):.\nCurrent  ("+DoubleToStr(adx,1)+")";
   DrawLabel("adx_"+symbolName,x-970,y+365,GetAdxStr(adx),fontSize,fontName,GetAdxColor(adx),tooltip);
   
   if(adx>=50)
   {
      AlertExtremes++;
   }
   
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string GetAdxStr(double adx)
  {
   if(adx<25)
      return "N T";//No Trend
   if(adx>=25 && adx < 50)
      return "W T";//Weak Trend
   if(adx>=50 && adx < 75)
      return "S T";//Strong Trend
   return "V S T";//Very Strong Trend
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
color GetAdxColor(double adx)
  {
   if(adx<25)
      return clrWhite;
   if(adx>=25 && adx < 50)
      return clrGreen;
    if(adx>=50 && adx < 75)
      return clrRed;
   return clrRed;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void DrawPriceColumn(string symbolName,int x,int y,string text,int fontSize=8,string fontName="Calibri")
  {
   int digits=(int)MarketInfo(symbolName,MODE_DIGITS);
   double vAsk=NormalizeDouble(MarketInfo(symbolName,MODE_ASK),digits);
   double vBid=NormalizeDouble(MarketInfo(symbolName,MODE_BID),digits);
   double vSpread=NormalizeDouble(MarketInfo(symbolName,MODE_SPREAD),digits);
   string tooltip=symbolName+"\n.: Price :.\nAsk: "+(string)vAsk+"\nBid: "+(string)vBid+"\nSpread: "+(string)vSpread;
   DrawLabel("price_"+symbolName,x-655,y+365,DoubleToString(vBid,digits),fontSize,fontName,clrWhite,tooltip);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void DrawSpreadColumn(string symbolName,int x,int y,string text,int fontSize=8,string fontName="Calibri")
  {
   int digits=(int)MarketInfo(symbolName,MODE_DIGITS);
   double vAsk=NormalizeDouble(MarketInfo(symbolName,MODE_ASK),digits);
   double vBid=NormalizeDouble(MarketInfo(symbolName,MODE_BID),digits);
   double vSpread=NormalizeDouble(MarketInfo(symbolName,MODE_SPREAD),digits);
   string tooltip=symbolName+"\n.: SPREAD :.\nAsk: "+(string)vAsk+"\nBid: "+(string)vBid+"\nSpread: "+(string)vSpread;
   DrawLabel("spread_"+symbolName,x-740,y+365,(string)vSpread,fontSize,fontName,clrWhite,tooltip);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void DrawPivotsColumn(string symbolName,int x,int y,string text,int fontSize=8,string fontName="Calibri")
  {
   double pivots[7];
   int digits=(int)MarketInfo(symbolName,MODE_DIGITS);
   double vAsk=MarketInfo(symbolName,MODE_BID);
   double pivot=NormalizeDouble((GetPivotValue(symbolName,PERIOD_GERAL)),digits);

   pivots[0]=pivot;

   pivots[1]=NormalizeDouble((GetPivotResistance(symbolName,PERIOD_GERAL,pivot,1)),digits);
   pivots[2]=NormalizeDouble((GetPivotResistance(symbolName,PERIOD_GERAL,pivot,2)),digits);
   pivots[3]=NormalizeDouble((GetPivotResistance(symbolName,PERIOD_GERAL,pivot,3)),digits);

   pivots[4]=NormalizeDouble((GetPivotSupport(symbolName,PERIOD_GERAL,pivot,1)),digits);
   pivots[5]=NormalizeDouble((GetPivotSupport(symbolName,PERIOD_GERAL,pivot,2)),digits);
   pivots[6]=NormalizeDouble((GetPivotSupport(symbolName,PERIOD_GERAL,pivot,3)),digits);

   int closestIdx=GetClosestPivot(vAsk,pivots);
   double pips=vAsk-pivots[closestIdx];

   string tooltip=symbolName+"\n.: Daily Pivots :.\nPP: "+DoubleToStr(pivots[0])+"\nR1: "+DoubleToStr(pivots[1]);
   string pivotText=GetPivotDirection(pips)+" "+GetPivotStr(closestIdx);

   DrawLabel("pivots_"+symbolName,x-835,y+365,pivotText,fontSize,fontName,GetPivotColor(closestIdx),tooltip);
   PIVOTvalue = closestIdx;
   PIVOTstringValue=pivotText;
   
   if (closestIdx > 3)
      AlertExtremes++;
   
   
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void DrawMAColumn(string symbolName,int x,int y,string text,int fontSize=8,string fontName="Calibri")
  {
   double ma=iMA(symbolName,PERIOD_GERAL,MAPeriod,0,MAMethod,MAAppliedPrice,0);
  
   string tooltip=symbolName+"\n.: "+GetPeriodStr(PERIOD_GERAL)+" MA ("+IntegerToString(MAPeriod)+"):.\nCurrent  ("+DoubleToStr(ma,1)+")";
   DrawLabel("ma_"+symbolName,x-1050,y+365,GetMAStr(symbolName,ma),fontSize,fontName,GetMAColor(symbolName,ma),tooltip);
   
  }
  
 void DrawPCColumn(string symbolName,int x,int y,string text,int fontSize=8,string fontName="Calibri")
 {
   
   if(CopyRates(symbolName,PERIOD_GERAL,0,2,PCBar)!=2)
    {
         printf("Not all data available yet (%s) !",symbolName);
         return;
    }

      //--- Calculates daily percent change
      double percentagechange = ((PCBar[1].close/PCBar[0].close)-1)*100;
  
   string tooltip=symbolName+"\n.: "+"Prev Close: " + DoubleToStr(PCBar[0].close) + "\n" + "Current Close: " + DoubleToStr(PCBar[0].close);
   DrawLabel("PC_"+symbolName,x-370,y+365,DoubleToStr(percentagechange,2) +"%",fontSize,fontName,GetPCColor(percentagechange),tooltip);
   
 }
 
  void DrawExtremesColumn(string symbolName,int x,int y,string text,int fontSize=8,string fontName="Calibri")
 {
 
   
   string tooltip=symbolName+"\n.";
   DrawLabel("Extremes_"+symbolName,x-915,y+365,IntegerToString(AlertExtremes),fontSize,fontName,GetAlertExtremesColor(AlertExtremes),tooltip);
  
      
 }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
color GetAlertExtremesColor(int aExtremes)
  {
  //4 or higher 
   if(aExtremes>=ExtremesUpperLevel)
      return clrRed;
   return clrWhite;
   
   
  }
 
//+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
color GetPivotColor(int pivotIdx)
  {
   if(pivotIdx==0)
      return clrWhite;
   if(pivotIdx<=3)
      return clrGreen;
   return clrRed;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int GetClosestPivot(double ask,double &pivots[])
  {
   int idx=0;
   double minDistance=1.7976931348623158e+308;
   for(int i=0;i<ArraySize(pivots);i++)
     {
      double dist=MathAbs(ask-pivots[i]);
      if(dist<minDistance)
        {
         minDistance=dist;
         idx=i;
        }
     }
   return idx;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string GetPivotDirection(double value)
  {
   if(value>0)
      return "A";//Above
   return "B";//Below
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double GetPivotValue(string symbolName,int PERIOD_GERAL)
  {
//Pivot point (PP) = (High + Low + Close) / 3
   return (iHigh(symbolName,PERIOD_GERAL,1)+iLow(symbolName,PERIOD_GERAL,1)+iClose(symbolName,PERIOD_GERAL,1))/3;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double GetPivotResistance(string symbolName,int PERIOD_GERAL,double pivotValue,int resistanceIdx=1)
  {
   switch(resistanceIdx)
     {
      case 3:
         //Third resistance (R3) = High + 2(PP – Low)
         return iHigh(symbolName,PERIOD_GERAL,1) + 2*(pivotValue - iLow(symbolName,PERIOD_GERAL,1));
      case 2:
         //Second resistance (R2) = PP + (High – Low)
         return pivotValue + (iHigh(symbolName,PERIOD_GERAL,1)-iLow(symbolName,PERIOD_GERAL,1));
      default:
         //First resistance (R1) = (2 x PP) – Low
         return (2*pivotValue) - iLow(symbolName,PERIOD_GERAL,1);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double GetPivotSupport(string symbolName,int PERIOD_GERAL,double pivotValue,int supportIdx=1)
  {
   switch(supportIdx)
     {
      case 3:
         //Third support (S3) = Low – 2(High – PP)
         return iLow(symbolName,PERIOD_GERAL,1) - 2*(iHigh(symbolName,PERIOD_GERAL,1)-pivotValue);
      case 2:
         //Second support (S2) = PP – (High – Low)
         return pivotValue - (iHigh(symbolName,PERIOD_GERAL,1) - iLow(symbolName,PERIOD_GERAL,1));
      default:
         //First support (S1) = (2 x PP) – High
         return (2*pivotValue) - iHigh(symbolName,PERIOD_GERAL,1);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void DrawVolumeColumn(string symbolName,int x,int y,string text,int fontSize=8,string fontName="Calibri")
  {
   long volume=iVolume(symbolName,PERIOD_GERAL,0);
   double volAvg=(double)getAvgVolume(symbolName,VolumePeriod);
   if(volAvg==0) volAvg=1;
   double volPercent=(volume/volAvg)*100;
   string tooltip=symbolName+"\n.: "+GetPeriodStr(PERIOD_GERAL)+" Volume ("+IntegerToString(VolumePeriod)+"):.\nCurrent  ("+DoubleToStr(volume,0)+")\nAverage ("+DoubleToStr(volAvg,0)+")";

   DrawLabel("vol"+symbolName,x-735,y+365,DoubleToStr(volPercent,2)+"%",fontSize,fontName,GetPercentColor(volPercent),tooltip);
   
   if (volPercent > 100)
      AlertExtremes++;
   
   
  }
  
  //+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void DrawATRValueColumn(string symbolName,int x,int y,string text,int fontSize=8,string fontName="Calibri")
  {
   double atr=0;
   double point=getPoint(symbolName);
   double modifier=getModifier(symbolName);

   if(point>0) atr=(NormalizeDouble(iATR(symbolName,PERIOD_GERAL,AtrPeriod,0)/point,0))/modifier;
   if(atr==0) atr=1;
   double range=getRange(symbolName,PERIOD_GERAL)/modifier;
   double rangePercent=(range/atr)*100;
   string tooltip=symbolName+"\n.: "+GetPeriodStr(PERIOD_GERAL)+" ATR ("+IntegerToString(AtrPeriod)+"):.\nCurrent  ("+DoubleToStr(range,1)+")\nAverage ("+DoubleToStr(atr,1)+")";

   DrawLabel("atr_V_"+symbolName,x-585,y+365,DoubleToStr(atr,1),fontSize,fontName,GetVPercentColor(rangePercent),tooltip);
  }
  
  
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void DrawATRPercentageColumn(string symbolName,int x,int y,string text,int fontSize=8,string fontName="Calibri")
  {
   double atr=0;
   double point=getPoint(symbolName);
   double modifier=getModifier(symbolName);
   

   if(point>0) atr=(NormalizeDouble(iATR(symbolName,PERIOD_GERAL,AtrPeriod,0)/point,0))/modifier;
   if(atr==0) atr=1;
   double atrrange=getRange(symbolName,PERIOD_GERAL)/modifier;
   double atrrangePercent=(atrrange/atr)*100;
   string tooltip=symbolName+"\n.: "+GetPeriodStr(PERIOD_GERAL)+" ATR ("+IntegerToString(AtrPeriod)+"):.\nCurrent  ("+DoubleToStr(atrrange,1)+")\nAverage ("+DoubleToStr(atr,1)+")";

   DrawLabel("atr_"+symbolName,x-600,y+365,DoubleToStr(atrrangePercent,1)+"%",fontSize,fontName,GetPercentColor(atrrangePercent),tooltip);
   
   ATRrangePercent = atrrangePercent;
   
   if (atrrangePercent >= AtrAlertLevel )
      {
        ATRAlert = true;
        AlertExtremes++;
      }
   else
      ATRAlert = false;
   
  
   
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
color GetRsiColor(double value)
  {
   if(value>=RsiUpperLevel)
      return clrGreen;
   if(value<=RsiLowerLevel)
      return clrRed;
   return clrWhite;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
color GetMAColor(string symbolName, double value)
  {
   double pAsk = MarketInfo(symbolName,MODE_ASK);
   
   if(pAsk>value)
   
      return clrGreen;
   else
      return clrRed;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string GetMAStr(string symbolName, double value)
  {
   double  pAsk = MarketInfo(symbolName,MODE_ASK);
   
   if(pAsk>value)
      return "up";
   else
      return "down";
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
color GetStochColor(double value)
  {
   if(value>=StochUpperLevel)
      return clrGreen;
   if(value<=StochLowerLevel)
      return clrRed;
   return clrWhite;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
color GetPercentColor(double value)
  {
   if(value<=25)
      return clrWhite;
   if(value<=50)
      return clrGreen;
   if(value<=75)
      return clrYellow;
   if(value<=100)
      return clrRed;
   return clrPurple;
  }
 
 color GetVPercentColor(double value)
  {
   if(value< 80)
      return clrWhite;
   return clrYellow;
  }
  
  
  color GetPCColor(double value)
  {
   if(value< 0)
      return clrRed;
   if(value>=0 )
      return clrGreen;
   return clrPurple;
  }
  
  
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void DrawSymbolColumn(string symbolName,int x,int y,string text,int fontSize=8,string fontName="Calibri")
  {
   ///DrawLabel("lbl_"+symbolName,x,y,text,fontSize,fontName,clrWhite,symbolName);///RETIRAR SIMBOLOS 
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void DrawHeader()
  {
   string objName="Header";
   int numColumns;
   
   if (SymbolSource == USER_INPUT)
      numColumns = (NoOfPairs/ColumnHeight)+1;
   else
      numColumns=(SymbolsTotal(true)/ColumnHeight)+1;
   
  
   int i=0;
   do
     {
      int x=(GUIXOffset+GUIHeaderXOffset)+(NumVisibleColumns()*GUIColOffset)*i;
      int y=GUIYOffset+GUIHeaderYOffset;
      string n=IntegerToString(i);

      ///DrawLabel(objName+"name"+n,x-685,y+395,"Name",FontSizeScanner,FontName,clrWhite,"Name");
      ///DrawHorizontalLine(objName+"namehline"+n,x-685,y+395,15);

      if(ShowPrice)
        {
         DrawLabel(objName+"price"+n,x-600,y+395,"Price",FontSizeScanner,FontName,clrWhite,"Price");
         DrawHorizontalLine(objName+"pricehline"+n,x-600,y+395,15);
        }
      if(ShowSpread)
        {
         DrawLabel(objName+"spread"+n,x-630,y+395,"Spr",FontSizeScanner,FontName,clrWhite,"Spread");
         DrawHorizontalLine(objName+"spreadhline"+n,x-630,y+395,15);
        }
      if(ShowPrice_Percentage)
        {
         DrawLabel(objName+"PC"+n,x-205,y+395,"Change("/*+GetPeriodStr(PERIOD_GERAL)+*/")",FontSizeScanner,FontName,clrWhite,"DCP");
         DrawHorizontalLine(objName+"pcline"+n,x-205,y+395,15);
        }  
       if(ShowATR_Value)
        {
         DrawLabel(objName+"rangeV"+n,x-325,y+395,"ATR_V("/*+GetPeriodStr(PERIOD_GERAL)+*/")",FontSizeScanner,FontName,clrWhite,"Range_V");
         DrawHorizontalLine(objName+"rangehline_V"+n,x-325,y+395,15);
        }
        
      if(ShowATR_Percentage)
        {
         DrawLabel(objName+"range"+n,x-365,y+395,"ATR ("/*+GetPeriodStr(PERIOD_GERAL)+*/")",FontSizeScanner,FontName,clrWhite,"Range");
         DrawHorizontalLine(objName+"rangehline"+n,x-355,y+395,15);
        }
      if(ShowVolume)
        {
         DrawLabel(objName+"curvolume"+n,x-405,y+395,"Vol ("/*+GetPeriodStr(PERIOD_GERAL)+*/")",FontSizeScanner,FontName,clrWhite,"Volume");
         DrawHorizontalLine(objName+"volhline"+n,x-405,y+395,15);
        }
      if(ShowRsi)
        {
         DrawLabel(objName+"rsi"+n,x-545,y+395,"RSI ("/*+GetPeriodStr(PERIOD_GERAL)+*/")",FontSizeScanner,FontName,clrWhite,"Pivots");
         DrawHorizontalLine(objName+"rsihline"+n,x-545,y+395,15);
        }
      if(ShowStoch)
        {
         DrawLabel(objName+"stoch"+n,x-510,y+395,"Stoch ("/*+GetPeriodStr(PERIOD_GERAL)+*/")",FontSizeScanner,FontName,clrWhite,"Stochastic");
         DrawHorizontalLine(objName+"stochhline"+n,x-510,y+395,15);
        }
      if(ShowAdx)
        {
         DrawLabel(objName+",adx"+n,x-470,y+395,"ADX ("/*+GetPeriodStr(PERIOD_GERAL)+*/")",FontSizeScanner,FontName,clrWhite,"ADX");
         DrawHorizontalLine(objName+"adxhline"+n,x-470,y+395,15);
        }

      if(ShowPivots)
        {
         ///DrawLabel(objName+"pivots"+n,x-285,y+395,"Pivots",FontSizeScanner,FontName,clrWhite,"Pivots");//
         ///DrawHorizontalLine(objName+"pvotshline"+n,x-285,y+395,15);
        }

      if(ShowMA)
        {
         DrawLabel(objName+"ma"+n,x-440,y+395,"MA"+"(" /*+ GetPeriodStr(PERIOD_GERAL)+*/ ")",FontSizeScanner,FontName,clrWhite,"MA");
         DrawHorizontalLine(objName+"maline"+n,x-440,y+395,15);
        }
     if(ShowExtremes)
        {
         DrawLabel(objName+"Extremes"+n,x-255,y+395,"Extremes",FontSizeScanner,FontName,clrWhite,"Extremes");
         DrawHorizontalLine(objName+"Extremesline"+n,x-255,y+395,15);
        }
      i++;
     }
   while(i<numColumns);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int NumVisibleColumns()
  {
   int x=1;
   if(ShowPrice)
     {
      x++;
     }
   if(ShowSpread)
     {
      x++;
     }
   if(ShowPrice_Percentage)
     {
      x++;
     }
   if(ShowATR_Value)
     {
      x++;
     }
   if(ShowATR_Percentage)
     {
      x++;
     }
   if(ShowVolume)
     {
      x++;
     }
   if(ShowRsi)
     {
      x++;
     }
   if(ShowStoch)
     {
      x++;
     }
   if(ShowAdx)
     {
      x++;
     }
   if(ShowPivots)
     {
      x++;
     }
   if(ShowMA)
     {
      x++;
     }
  
  if(ShowExtremes)
     {
      x++;
     }
     
   return x;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void DrawHorizontalLine(string objName,int x,int y,int length=250)
  {
   string line;
   for(int i=0;i<length;i++)
      line += "_";

   DrawLabel(objName+"1",x,y,line,FontSizeScanner,FontName,clrWhite,"");
//DrawLabel(objName+"2",x+380,y,line,FontSize,FontName,clrWhite,"");
  }
//+------------------------------------------------------------------+
int periodToMinutes(int period)
  {
   int i;
   static int _per[]={1,2,3,4,5,6,10,12,15,20,30,60,120,180,240,360,480,720,1440,10080,43200,0x4001,0x4002,0x4003,0x4004,0x4006,0x4008,0x400c,0x4018,0x8001,0xc001};
   static int _min[]={1,2,3,4,5,6,10,12,15,20,30,60,120,180,240,360,480,720,1440,10080,43200};
//---
   if(period==PERIOD_CURRENT)
      period=Period();
   for(i=0;i<20;i++) if(period==_per[i]) break;
   return(_min[i]);
  }
//+------------------------------------------------------------------+
datetime iTime(int period)
  {
   datetime times[];
   if(CopyTime(Symbol(),period,0,1,times)<=0)
      return(TimeLocal());
   return(times[0]);
  }
//+------------------------------------------------------------------+
string getTime(int times,color &theColor)
  {
   string stime="";
   int    seconds;
   int    minutes;
   int    hours;

   if(times<0)
     {
      theColor=clrRed;
      times=(int)fabs(times);
     }
   else if(times>0)
     {
      theColor=clrYellow;
     }

   seconds = (times%60);
   hours   = (times-times%3600)/3600;
   minutes = (times-seconds)/60-hours*60;
//---
   if(hours>0)
      if(minutes<10)
         stime = stime+(string)hours+":0";
   else  stime = stime+(string)hours+":";
   stime=stime+(string)minutes;
   if(seconds<10)
      stime=stime+":0"+(string)seconds;
   else  stime=stime+":"+(string)seconds;
   return(stime);
  }
//+------------------------------------------------------------------+
string GetPivotStr(int pivotIdx)
  {
   switch(pivotIdx)
     {
      case 1:
         return "R1";
      case 2:
         return "R2";
      case 3:
         return "R3";
      case 4:
         return "S1";
      case 5:
         return "S2";
      case 6:
         return "S3";
      default:
         return "PP";
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string GetPeriodStr(int period)
  {
   string TMz="";
   switch(period)
     {
      case 1:     TMz = "M1";  break;
      case 2:     TMz = "M2";  break;
      case 3:     TMz = "M3";  break;
      case 4:     TMz = "M4";  break;
      case 5:     TMz = "M5";  break;
      case 6:     TMz = "M6";  break;
      case 7:     TMz = "M7";  break;
      case 8:     TMz = "M8";  break;
      case 9:     TMz = "M9";  break;
      case 10:    TMz = "M10"; break;
      case 11:    TMz = "M11"; break;
      case 12:    TMz = "M12"; break;
      case 13:    TMz = "M13"; break;
      case 14:    TMz = "M14"; break;
      case 15:    TMz = "M15"; break;
      case 20:    TMz = "M20"; break;
      case 25:    TMz = "M25"; break;
      case 30:    TMz = "M30"; break;
      case 40:    TMz = "M40"; break;
      case 45:    TMz = "M45"; break;
      case 50:    TMz = "M50"; break;
      case 60:    TMz = "H1";  break;
      case 120:   TMz = "H2";  break;
      case 180:   TMz = "H3";  break;
      case 240:   TMz = "H4";  break;
      case 300:   TMz = "H5";  break;
      case 360:   TMz = "H6";  break;
      case 420:   TMz = "H7";  break;
      case 480:   TMz = "H8";  break;
      case 540:   TMz = "H9";  break;
      case 600:   TMz = "H10"; break;
      case 660:   TMz = "H11"; break;
      case 720:   TMz = "H12"; break;
      case 1440:  TMz = "D1";  break;
      case 10080: TMz = "W1";  break;
      case 43200: TMz = "M1";  break;
     }
   return TMz;
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Create a trend line by the given coordinates                     |
//+------------------------------------------------------------------+
bool TrendCreate(const long            chart_ID=0,        // chart's ID
                 const string          name="TrendLine",  // line name
                 const int             sub_window=0,      // subwindow index
                 datetime              time1=0,           // first point time
                 double                price1=0,          // first point price
                 datetime              time2=0,           // second point time
                 double                price2=0,          // second point price
                 const color           clr=clrRed,        // line color
                 const ENUM_LINE_STYLE style=STYLE_SOLID, // line style
                 const int             width=1,           // line width
                 const bool            back=false,        // in the background
                 const bool            selection=true,    // highlight to move
                 const bool            ray_right=false,   // line's continuation to the right
                 const bool            hidden=true,       // hidden in the object list
                 const long            z_order=0)         // priority for mouse click
  {
//--- set anchor points' coordinates if they are not set
   ChangeTrendEmptyPoints(time1,price1,time2,price2);
//--- reset the error value
   ResetLastError();
//--- create a trend line by the given coordinates
   if(!ObjectCreate(chart_ID,name,OBJ_TREND,sub_window,time1,price1,time2,price2))
     {
      Print(__FUNCTION__,
            ": failed to create a trend line! Error code = ",GetLastError());
      return(false);
     }
//--- set line color
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
//--- set line display style
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style);
//--- set line width
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width);
//--- display in the foreground (false) or background (true)
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
//--- enable (true) or disable (false) the mode of moving the line by mouse
//--- when creating a graphical object using ObjectCreate function, the object cannot be
//--- highlighted and moved by default. Inside this method, selection parameter
//--- is true by default making it possible to highlight and move the object
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
//--- enable (true) or disable (false) the mode of continuation of the line's display to the right
   ObjectSetInteger(chart_ID,name,OBJPROP_RAY_RIGHT,ray_right);
//--- hide (true) or display (false) graphical object name in the object list
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
//--- set the priority for receiving the event of a mouse click in the chart
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
//--- successful execution
   return(true);
  }
//+------------------------------------------------------------------+
//| Check the values of trend line's anchor points and set default   |
//| values for empty ones                                            |
//+------------------------------------------------------------------+
void ChangeTrendEmptyPoints(datetime &time1,double &price1,
                            datetime &time2,double &price2)
  {
//--- if the first point's time is not set, it will be on the current bar
   if(!time1)
      time1=TimeCurrent();
//--- if the first point's price is not set, it will have Bid value
   if(!price1)
      price1=SymbolInfoDouble(Symbol(),SYMBOL_BID);
//--- if the second point's time is not set, it is located 9 bars left from the second one
   if(!time2)
     {
      //--- array for receiving the open time of the last 10 bars
      datetime temp[10];
      CopyTime(Symbol(),Period(),time1,10,temp);
      //--- set the second point 9 bars left from the first one
      time2=temp[0];
     }
//--- if the second point's price is not set, it is equal to the first point's one
   if(!price2)
      price2=price1;
  }
//+------------------------------------------------------------------+

struct alert_struct
{
  string Symbolname;
  string AlertType;
  string AlertString;
  datetime AlertTime;
};


void manageAlerts(string symbolName)
{

 
 if ( ATRrangePercent > AtrAlertLevel  && (PIVOTstringValue == "Above S3" || PIVOTstringValue == "Below R3"))
   {
       string msg = symbolName + ", " + TF2Str(PERIOD_GERAL); 
       string AlertMsg =  msg + " FX Scanner ATR/PIVOT Alert:" + DoubleToStr(ATRrangePercent,2)+"%"+"/"+PIVOTstringValue + "  @ " + TimeToStr(Time[0],TIME_SECONDS);
       
       doAlert( 0, AlertMsg);
   
   
   }
 
   
   
}

void doAlert(int forBar, string doWhat)
{

static string   previousAlert="nothing";
static datetime previousTime = TimeCurrent();

   
   if (previousAlert != doWhat && previousTime != Time[forBar]) {
       previousAlert  = doWhat;
       previousTime   = Time[forBar];

 
    if (alertsMessage)      Alert(doWhat);
          if (alertsEmail)        SendMail(StringConcatenate(Symbol()," FX Scanner  "),doWhat);
          if (alertsNotification) SendNotification(doWhat);
          if (alertsSound)        PlaySound("alert2.wav");
   }
}



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string TF2Str(int nperiod)
  {
   switch(nperiod)
     {
      case PERIOD_M1: return("M1");
      case PERIOD_M5: return("M5");
      case PERIOD_M15: return("M15");
      case PERIOD_M30: return("M30");
      case PERIOD_H1: return("H1");
      case PERIOD_H4: return("H4");
      case PERIOD_D1: return("D1");
      case PERIOD_W1: return("W1");
      case PERIOD_MN1: return("MN");
     }
   return((string)Period());
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
// StringFindCount                                                   |
//+------------------------------------------------------------------+
int StringFindCount(string str, string str2)
// Returns the number of occurrences of STR2 in STR
// Usage:   int x = StringFindCount("ABCDEFGHIJKABACABB","AB")   returns x = 3
{
  int c = 0;
  for (int i=0; i<StringLen(str); i++)
    if (StringSubstr(str,i,StringLen(str2)) == str2)  c++;
  return(c);
} // End int StringFindCount(string str, string str2)


void StrToStringArray(string str, string &a[], string delim=",")
{
	int z1=-1, z2=0;
	for (int i=0; i<ArraySize(a); i++)
	{
		z2 = StringFind(str,delim,z1+1);
		a[i] = StringSubstr(str,z1+1,z2-z1-1);
		if (z2 >= StringLen(str)-1)   break;
		z1 = z2;
	}
	return;
} // End void StrToStringArray(string str, string &a[], string delim=",") 

//+------------------------------------------------------------------+
// StrPairToStringArray                                                  |
//+------------------------------------------------------------------+
void StrPairToStringArray(string str, string &a[], string p_suffix, string delim=",")
{
	int z1=-1, z2=0;
	for (int i=0; i<ArraySize(a); i++)
	{
		z2 = StringFind(str,delim,z1+1);
		a[i] = StringSubstr(str,z1+1,z2-z1-1) + p_suffix;
		if (z2 >= StringLen(str)-1)   break;
		z1 = z2;
	}
	return;
} // End void StrPairToStringArray(string str, string &a[], string p_suffix, string delim=",") 

