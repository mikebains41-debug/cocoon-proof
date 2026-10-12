import cocoon.runtime.CobolDecimal;
import cocoon.runtime.CobolText;
import cocoon.runtime.CobolRecord;
import java.math.BigDecimal;

/**
 * Translated from COBOL program ESCAL056.
 *
 * The arithmetic is deliberately not Java arithmetic. A
 * COBOL field holds what its PICTURE allows, and a value
 * too large loses its high-order digits without raising
 * anything. Every place this translation reproduces that
 * is marked TRUNCATES, because a faithful migration has
 * to compute the same numbers as the program it
 * replaces, defects included.
 */
public class Escal056 {

    // Records: the bytes, laid out as the mainframe lays them out.
    private final CobolRecord r_W_STORAGE_REF = new CobolRecord("W-STORAGE-REF", 46,
        "455343414c3035362020202020202d2057204f2052204b2049204e2047202020532054204f205220412047204520");
    private final CobolRecord r_CAL_VERSION = new CobolRecord("CAL-VERSION", 5,
        "4330352e36");
    private final CobolRecord r_DISPLAY_LINE_MEASUREMENT = new CobolRecord("DISPLAY-LINE-MEASUREMENT", 120,
        "2e2e2e2e3a2e2e2e31302e2e2e2e3a2e2e2e32302e2e2e2e3a2e2e2e33302e2e2e2e3a2e2e2e34302e2e2e2e3a2e2e2e35302e2e2e2e3a2e2e2e36302e2e2e2e3a2e2e2e37302e2e2e2e3a2e2e2e38302e2e2e2e3a2e2e2e39302e2e2e2e3a2e2e3130302e2e2e2e3a2e2e3131302e2e2e2e3a2e2e313230");
    private final CobolRecord r_PRINT_LINE_MEASUREMENT = new CobolRecord("PRINT-LINE-MEASUREMENT", 133,
        "582e2e2e2e3a2e2e2e31302e2e2e2e3a2e2e2e32302e2e2e2e3a2e2e2e33302e2e2e2e3a2e2e2e34302e2e2e2e3a2e2e2e35302e2e2e2e3a2e2e2e36302e2e2e2e3a2e2e2e37302e2e2e2e3a2e2e2e38302e2e2e2e3a2e2e2e39302e2e2e2e3a2e2e3130302e2e2e2e3a2e2e3131302e2e2e2e3a2e2e3132302e2e2e2e3a2e2e3133302e2e");
    private final CobolRecord r_HOLD_PPS_COMPONENTS = new CobolRecord("HOLD-PPS-COMPONENTS", 72,
        "303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030");
    private final CobolRecord r_DRUG_ADDON = new CobolRecord("DRUG-ADDON", 5,
        "3130383730");
    private final CobolRecord r_MSA_BLEND_PCT = new CobolRecord("MSA-BLEND-PCT", 3,
        "313030");
    private final CobolRecord r_CBSA_BLEND_PCT = new CobolRecord("CBSA-BLEND-PCT", 3,
        "303030");
    private final CobolRecord r_NAT_LABOR_PCT = new CobolRecord("NAT-LABOR-PCT", 6,
        "303533373131");
    private final CobolRecord r_NAT_NONLABOR_PCT = new CobolRecord("NAT-NONLABOR-PCT", 6,
        "303436323839");
    private final CobolRecord r_HEMO_PERI_CCPD_AMT = new CobolRecord("HEMO-PERI-CCPD-AMT", 2,
        "3230");
    private final CobolRecord r_CAPD_AMT = new CobolRecord("CAPD-AMT", 2,
        "3132");
    private final CobolRecord r_CAPD_OR_CCPD_FACTOR = new CobolRecord("CAPD-OR-CCPD-FACTOR", 7,
        "30343238353731");
    private final CobolRecord r_CASE_MIX_BDGT_NEUT_FACTOR = new CobolRecord("CASE-MIX-BDGT-NEUT-FACTOR", 5,
        "3039313136");
    private final CobolRecord r_BILL_NEW_DATA = new CobolRecord("BILL-NEW-DATA", 450);   // LINKAGE: bound by the caller
    private final CobolRecord r_PPS_DATA_ALL = new CobolRecord("PPS-DATA-ALL", 396);   // LINKAGE: bound by the caller
    private final CobolRecord r_WAGE_NEW_RATE_RECORD = new CobolRecord("WAGE-NEW-RATE-RECORD", 24);   // LINKAGE: bound by the caller
    private final CobolRecord r_COM_CBSA_WAGE_RECORD = new CobolRecord("COM-CBSA-WAGE-RECORD", 19);   // LINKAGE: bound by the caller
    private final CobolRecord r_BUN_CBSA_WAGE_RECORD = new CobolRecord("BUN-CBSA-WAGE-RECORD", 19);   // LINKAGE: bound by the caller
    private final java.util.Map<String, CobolRecord> cocoonRecordMap = new java.util.LinkedHashMap<>();
    {
        cocoonRecordMap.put("W-STORAGE-REF", r_W_STORAGE_REF);
        cocoonRecordMap.put("CAL-VERSION", r_CAL_VERSION);
        cocoonRecordMap.put("DISPLAY-LINE-MEASUREMENT", r_DISPLAY_LINE_MEASUREMENT);
        cocoonRecordMap.put("PRINT-LINE-MEASUREMENT", r_PRINT_LINE_MEASUREMENT);
        cocoonRecordMap.put("HOLD-PPS-COMPONENTS", r_HOLD_PPS_COMPONENTS);
        cocoonRecordMap.put("DRUG-ADDON", r_DRUG_ADDON);
        cocoonRecordMap.put("MSA-BLEND-PCT", r_MSA_BLEND_PCT);
        cocoonRecordMap.put("CBSA-BLEND-PCT", r_CBSA_BLEND_PCT);
        cocoonRecordMap.put("NAT-LABOR-PCT", r_NAT_LABOR_PCT);
        cocoonRecordMap.put("NAT-NONLABOR-PCT", r_NAT_NONLABOR_PCT);
        cocoonRecordMap.put("HEMO-PERI-CCPD-AMT", r_HEMO_PERI_CCPD_AMT);
        cocoonRecordMap.put("CAPD-AMT", r_CAPD_AMT);
        cocoonRecordMap.put("CAPD-OR-CCPD-FACTOR", r_CAPD_OR_CCPD_FACTOR);
        cocoonRecordMap.put("CASE-MIX-BDGT-NEUT-FACTOR", r_CASE_MIX_BDGT_NEUT_FACTOR);
        cocoonRecordMap.put("BILL-NEW-DATA", r_BILL_NEW_DATA);
        cocoonRecordMap.put("PPS-DATA-ALL", r_PPS_DATA_ALL);
        cocoonRecordMap.put("WAGE-NEW-RATE-RECORD", r_WAGE_NEW_RATE_RECORD);
        cocoonRecordMap.put("COM-CBSA-WAGE-RECORD", r_COM_CBSA_WAGE_RECORD);
        cocoonRecordMap.put("BUN-CBSA-WAGE-RECORD", r_BUN_CBSA_WAGE_RECORD);
    }
    /** A record by its COBOL name; a caller binds a LINKAGE record's bytes here. */
    public CobolRecord record(String name) { return cocoonRecordMap.get(name); }
    public java.util.Map<String, CobolRecord> records() { return cocoonRecordMap; }

    // W-STORAGE-REF PIC X(46)
    private CobolText wStorageRef;
    // CAL-VERSION PIC X(05)
    private CobolText calVersion;
    // FILLER PIC X(066)
    private CobolText filler;
    // H-PYMT-AMT PIC 9(07)V9(02)
    private CobolDecimal hPymtAmt;
    // H-WAGE-ADJ-PYMT-AMT PIC 9(07)V9(02)
    private CobolDecimal hWageAdjPymtAmt;
    // H-FIXED-LOSS-AMT PIC 9(07)V9(02)
    private CobolDecimal hFixedLossAmt;
    // H-ESRD-FAC-RATE PIC 9(07)V9(02)
    private CobolDecimal hEsrdFacRate;
    // H-PATIENT-AGE PIC 9(03)
    private CobolDecimal hPatientAge;
    // H-AGE-FACTOR PIC 9(01)V9(03)
    private CobolDecimal hAgeFactor;
    // H-BSA-FACTOR PIC 9(01)V9(04)
    private CobolDecimal hBsaFactor;
    // H-BMI-FACTOR PIC 9(01)V9(04)
    private CobolDecimal hBmiFactor;
    // H-BSA PIC 9(03)V9(04)
    private CobolDecimal hBsa;
    // H-BMI PIC 9(03)V9(04)
    private CobolDecimal hBmi;
    // H-DRUG-ADDON PIC 9(01)V9(04)
    private CobolDecimal hDrugAddon;
    // DRUG-ADDON PIC 9(01)V9(04)
    private CobolDecimal drugAddon;
    // MSA-BLEND-PCT PIC 9(01)V9(02)
    private CobolDecimal msaBlendPct;
    // CBSA-BLEND-PCT PIC 9(01)V9(02)
    private CobolDecimal cbsaBlendPct;
    // NAT-LABOR-PCT PIC 9(01)V9(05)
    private CobolDecimal natLaborPct;
    // NAT-NONLABOR-PCT PIC 9(01)V9(05)
    private CobolDecimal natNonlaborPct;
    // HEMO-PERI-CCPD-AMT PIC 9(02)
    private CobolDecimal hemoPeriCcpdAmt;
    // CAPD-AMT PIC 9(02)
    private CobolDecimal capdAmt;
    // CAPD-OR-CCPD-FACTOR PIC 9(01)V9(06)
    private CobolDecimal capdOrCcpdFactor;
    // CASE-MIX-BDGT-NEUT-FACTOR PIC 9(01)V9(04)
    private CobolDecimal caseMixBdgtNeutFactor;
    // B-COND-CODE PIC X(02)
    private CobolText bCondCode;
    // B-REV-CODE3 PIC X(03)
    private CobolText bRevCode3;
    // B-PATIENT-HGT PIC 9(07)V9(02)
    private CobolDecimal bPatientHgt;
    // B-PATIENT-HEIGHT PIC 9(09)
    private CobolDecimal bPatientHeight;
    // B-PATIENT-WGT PIC 9(07)V9(02)
    private CobolDecimal bPatientWgt;
    // B-PATIENT-WEIGHT PIC 9(09)
    private CobolDecimal bPatientWeight;
    // B-THRU-CCYY PIC 9(04)
    private CobolDecimal bThruCcyy;
    // B-THRU-MM PIC 9(02)
    private CobolDecimal bThruMm;
    // B-THRU-DD PIC 9(02)
    private CobolDecimal bThruDd;
    // B-DOB-CCYY PIC 9(04)
    private CobolDecimal bDobCcyy;
    // B-DOB-MM PIC 9(02)
    private CobolDecimal bDobMm;
    // B-DOB-DD PIC 9(02)
    private CobolDecimal bDobDd;
    // P-NPI PIC X(08)
    private CobolText pNpi;
    // P-NPI-FILLER PIC X(02)
    private CobolText pNpiFiller;
    // P-PROV-OSCAR PIC X(06)
    private CobolText pProvOscar;
    // P-GEO-MSA PIC X(04)
    private CobolText pGeoMsa;
    // P-GEO-CBSA PIC X(05)
    private CobolText pGeoCbsa;
    // P-SPEC-PYMT-IND PIC X(01)
    private CobolText pSpecPymtInd;
    // P-PROV-TYPE PIC X(02)
    private CobolText pProvType;
    // P-SPEC-WAGE-INDX PIC 9(02)V9(04)
    private CobolDecimal pSpecWageIndx;
    // P-ESRD-RATE PIC 9(07)V9(02)
    private CobolDecimal pEsrdRate;
    // P-PROV-WAIVE-BLEND-PAY-INDIC PIC X(01)
    private CobolText pProvWaiveBlendPayIndic;
    // P-PROV-LOW-VOLUME-INDIC PIC X(01)
    private CobolText pProvLowVolumeIndic;
    // P-PACIFIC-IS-TRUST-TERR PIC X(01)
    private CobolText pPacificIsTrustTerr;
    // P-QIP-REDUCTION PIC X(01)
    private CobolText pQipReduction;
    // P-SUPP-WI-IND PIC X(01)
    private CobolText pSuppWiInd;
    // P-SUPP-WI PIC 9(02)V9(04)
    private CobolDecimal pSuppWi;
    // OLD-TEST-INDICATOR PIC X(01)
    private CobolText oldTestIndicator;
    // B-CLAIM-NUM-DIALYSIS-SESSIONS PIC 9(02)
    private CobolDecimal bClaimNumDialysisSessions;
    // B-LINE-ITEM-DT-SVC-CCYY PIC 9(04)
    private CobolDecimal bLineItemDtSvcCcyy;
    // B-LINE-ITEM-DT-SVC-MM PIC 9(02)
    private CobolDecimal bLineItemDtSvcMm;
    // B-LINE-ITEM-DT-SVC-DD PIC 9(02)
    private CobolDecimal bLineItemDtSvcDd;
    // B-DIALYSIS-START-DT-CCYY PIC 9(04)
    private CobolDecimal bDialysisStartDtCcyy;
    // B-DIALYSIS-START-DT-MM PIC 9(02)
    private CobolDecimal bDialysisStartDtMm;
    // B-DIALYSIS-START-DT-DD PIC 9(02)
    private CobolDecimal bDialysisStartDtDd;
    // B-TOT-PRICE-SB-OUTLIER PIC 9(07)V9(02)
    private CobolDecimal bTotPriceSbOutlier;
    // B-PAYER-ONLY-VC-Q8 PIC 9(07)V9(04)
    private CobolDecimal bPayerOnlyVcQ8;
    // B-DATA-CODE PIC X(02)
    private CobolText bDataCode;
    // B-PAYER-ONLY-VALUE-CODE PIC X(02)
    private CobolText bPayerOnlyValueCode;
    // B-PAYER-ONLY-VC-QG-AMT PIC 9(07)V9(04)
    private CobolDecimal bPayerOnlyVcQgAmt;
    // COMORBID-DATA PIC X(02)
    private CobolText[] comorbidData;
    // COMORBID-RECURRENCE-COND-CODE PIC X(02)
    private CobolText comorbidRecurrenceCondCode;
    // COMORBID-CWF-RETURN-CODE PIC X(02)
    private CobolText comorbidCwfReturnCode;
    // DRUG-ADD-ON-RETURN PIC 9(01)V9(04)
    private CobolDecimal drugAddOnReturn;
    // MSA-WAGE-ADJ PIC 9(04)V9(02)
    private CobolDecimal msaWageAdj;
    // COMP-CBSA-WAGE-ADJ PIC 9(04)V9(02)
    private CobolDecimal compCbsaWageAdj;
    // CBSA-WAGE-ADJ PIC 9(04)V9(02)
    private CobolDecimal cbsaWageAdj;
    // BUND-CBSA-WAGE-ADJ PIC 9(04)V9(02)
    private CobolDecimal bundCbsaWageAdj;
    // CBSA-WAGE-PMT-RATE PIC 9(04)V9(02)
    private CobolDecimal cbsaWagePmtRate;
    // AMT-INDIC PIC X(01)
    private CobolText amtIndic;
    // BLOOD-DOLLAR PIC 9(02)
    private CobolDecimal bloodDollar;
    // HEMO-CCPD-CAPD PIC 9(02)V9(06)
    private CobolDecimal hemoCcpdCapd;
    // AGE-RETURN PIC 9(03)
    private CobolDecimal ageReturn;
    // MSA-WAGE-AMT PIC S9(04)V9(02)
    private CobolDecimal msaWageAmt;
    // CBSA-WAGE-INDEX PIC S9(02)V9(04)
    private CobolDecimal cbsaWageIndex;
    // LABOR-PCT PIC 9(01)V9(05)
    private CobolDecimal laborPct;
    // PPS-BMI PIC 9(03)V9(04)
    private CobolDecimal ppsBmi;
    // PPS-BSA PIC 9(03)V9(04)
    private CobolDecimal ppsBsa;
    // MSA-PCT PIC 9(01)V9(02)
    private CobolDecimal msaPct;
    // CBSA-PCT PIC 9(01)V9(02)
    private CobolDecimal cbsaPct;
    // COM-CBSA-PCT-BLEND PIC 9(01)V9(02)
    private CobolDecimal comCbsaPctBlend;
    // BUN-CBSA-PCT-BLEND PIC 9(01)V9(02)
    private CobolDecimal bunCbsaPctBlend;
    // CASE-MIX-FCTR-ADJ-RATE PIC 9(07)V9(02)
    private CobolDecimal caseMixFctrAdjRate;
    // BUN-BSA PIC 9(03)V9(04)
    private CobolDecimal bunBsa;
    // BUN-BMI PIC 9(03)V9(04)
    private CobolDecimal bunBmi;
    // BUN-ONSET-FACTOR PIC 9(01)V9(04)
    private CobolDecimal bunOnsetFactor;
    // BUN-COMORBID-MULTIPLIER PIC 9(01)V9(03)
    private CobolDecimal bunComorbidMultiplier;
    // BUN-WAGE-ADJ-TRAINING-AMT PIC 9(04)V9(04)
    private CobolDecimal bunWageAdjTrainingAmt;
    // BUN-LOW-VOL-MULTIPLIER PIC 9(01)V9(03)
    private CobolDecimal bunLowVolMultiplier;
    // OUT-AGE-FACTOR PIC 9(01)V9(03)
    private CobolDecimal outAgeFactor;
    // OUT-BSA PIC 9(03)V9(04)
    private CobolDecimal outBsa;
    // OUT-BSA-FACTOR PIC 9(01)V9(04)
    private CobolDecimal outBsaFactor;
    // OUT-BMI PIC 9(03)V9(04)
    private CobolDecimal outBmi;
    // OUT-BMI-FACTOR PIC 9(01)V9(04)
    private CobolDecimal outBmiFactor;
    // OUT-ONSET-FACTOR PIC 9(01)V9(04)
    private CobolDecimal outOnsetFactor;
    // OUT-COMORBID-MULTIPLIER PIC 9(01)V9(03)
    private CobolDecimal outComorbidMultiplier;
    // OUT-LOW-VOL-MULTIPLIER PIC 9(01)V9(03)
    private CobolDecimal outLowVolMultiplier;
    // OUT-ADJ-AVG-MAP-AMT PIC 9(03)V9(02)
    private CobolDecimal outAdjAvgMapAmt;
    // OUT-LOSS-SHARING-PCT PIC 9(01)V9(02)
    private CobolDecimal outLossSharingPct;
    // OUT-IMPUTED-MAP PIC 9(04)V9(04)
    private CobolDecimal outImputedMap;
    // OUT-FIX-DOLLAR-LOSS PIC 9(04)V9(02)
    private CobolDecimal outFixDollarLoss;
    // OUT-PREDICTED-MAP PIC 9(07)V9(04)
    private CobolDecimal outPredictedMap;
    // OUT-PREDICTED-SERVICES-MAP PIC 9(02)V9(04)
    private CobolDecimal outPredictedServicesMap;
    // BUNDLED-TEST-INDIC PIC X(01)
    private CobolText bundledTestIndic;
    // PPS-RTC PIC 9(02)
    private CobolDecimal ppsRtc;
    // PPS-MSA PIC X(04)
    private CobolText ppsMsa;
    // PPS-CBSA PIC X(05)
    private CobolText ppsCbsa;
    // PPS-WAGE-ADJ-RATE PIC 9(04)V9(02)
    private CobolDecimal ppsWageAdjRate;
    // PPS-FINAL-PAY-AMT PIC 9(07)V9(02)
    private CobolDecimal ppsFinalPayAmt;
    // PPS-CALC-VERS-CD PIC X(05)
    private CobolText ppsCalcVersCd;
    // PPS-COND-CODE PIC X(02)
    private CobolText ppsCondCode;
    // PPS-REV-CODE PIC X(04)
    private CobolText ppsRevCode;
    // PPS-2011-WAGE-ADJ-RATE PIC 9(04)V9(02)
    private CobolDecimal pps2011WageAdjRate;
    // PPS-2011-NAT-LABOR-PCT PIC 9(01)V9(05)
    private CobolDecimal pps2011NatLaborPct;
    // PPS-2011-NAT-NONLABOR-PCT PIC 9(01)V9(05)
    private CobolDecimal pps2011NatNonlaborPct;
    // PPS-NAT-LABOR-PCT PIC 9(01)V9(05)
    private CobolDecimal ppsNatLaborPct;
    // PPS-NAT-NONLABOR-PCT PIC 9(01)V9(05)
    private CobolDecimal ppsNatNonlaborPct;
    // PPS-AGE-FACTOR PIC 9(01)V9(03)
    private CobolDecimal ppsAgeFactor;
    // PPS-BSA-FACTOR PIC 9(01)V9(04)
    private CobolDecimal ppsBsaFactor;
    // PPS-BMI-FACTOR PIC 9(01)V9(04)
    private CobolDecimal ppsBmiFactor;
    // PPS-BDGT-NEUT-RATE PIC 9(01)V9(04)
    private CobolDecimal ppsBdgtNeutRate;
    // PPS-2011-AGE-FACTOR PIC 9(01)V9(03)
    private CobolDecimal pps2011AgeFactor;
    // PPS-2011-BSA-FACTOR PIC 9(01)V9(04)
    private CobolDecimal pps2011BsaFactor;
    // PPS-2011-BMI-FACTOR PIC 9(01)V9(04)
    private CobolDecimal pps2011BmiFactor;
    // PPS-2011-BDGT-NEUT-RATE PIC 9(01)V9(04)
    private CobolDecimal pps2011BdgtNeutRate;
    // PPS-2011-COMORBID-MA PIC X(02)
    private CobolText pps2011ComorbidMa;
    // PPS-2011-COMORBID-MA-CC PIC X(02)
    private CobolText pps2011ComorbidMaCc;
    // PPS-2011-COMORBID-PAY PIC X(02)
    private CobolText pps2011ComorbidPay;
    // PPS-2011-FULL-COMP-RATE PIC 9(07)V9(02)
    private CobolDecimal pps2011FullCompRate;
    // PPS-2011-BLEND-COMP-RATE PIC 9(07)V9(02)
    private CobolDecimal pps2011BlendCompRate;
    // PPS-2011-FULL-PPS-RATE PIC 9(07)V9(02)
    private CobolDecimal pps2011FullPpsRate;
    // PPS-2011-BLEND-PPS-RATE PIC 9(07)V9(02)
    private CobolDecimal pps2011BlendPpsRate;
    // PPS-2011-FULL-OUTLIER-RATE PIC 9(07)V9(02)
    private CobolDecimal pps2011FullOutlierRate;
    // PPS-2011-BLEND-OUTLIER-RATE PIC 9(07)V9(02)
    private CobolDecimal pps2011BlendOutlierRate;
    // MSA-ADJ-YEAR-AMT PIC 9(04)V9(02)
    private CobolDecimal msaAdjYearAmt;
    // PPS-LOW-VOL-AMT PIC 9(04)V9(02)
    private CobolDecimal ppsLowVolAmt;
    // OUT-CASE-MIX-PREDICTED-MAP PIC 9(04)V9(04)
    private CobolDecimal outCaseMixPredictedMap;
    // OUT-HEMO-EQUIV-DIAL-SESSIONS PIC 9(02)V9(04)
    private CobolDecimal outHemoEquivDialSessions;
    // OUT-SB-BSA PIC 9(01)V9(03)
    private CobolDecimal outSbBsa;
    // OUT-SB-BMI PIC 9(01)V9(03)
    private CobolDecimal outSbBmi;
    // A-49-CENT-DRUG-ADJ PIC 9(01)V9(02)
    private CobolDecimal a49CentDrugAdj;
    // PPS-CM-BSA PIC 9(01)V9(03)
    private CobolDecimal ppsCmBsa;
    // PPS-CM-BMI-LT-18-5 PIC 9(01)V9(03)
    private CobolDecimal ppsCmBmiLt185;
    // PPS-BUN-BASE-PMT-RATE PIC 9(04)V9(02)
    private CobolDecimal ppsBunBasePmtRate;
    // BUN-ADJUSTED-BASE-WAGE-AMT PIC 9(07)V9(04)
    private CobolDecimal bunAdjustedBaseWageAmt;
    // CR-BSA-MULTIPLIER PIC 9(01)V9(03)
    private CobolDecimal crBsaMultiplier;
    // CR-BMI-MULTIPLIER PIC 9(01)V9(03)
    private CobolDecimal crBmiMultiplier;
    // PPS-BUN-CBSA-W-INDEX PIC 9(02)V9(04)
    private CobolDecimal ppsBunCbsaWIndex;
    // PPS-BUN-WAGE-ADJ-TRAIN-AMT PIC 9(07)V9(04)
    private CobolDecimal ppsBunWageAdjTrainAmt;
    // PPS-TRAINING-ADD-ON-PMT-AMT PIC 9(02)V9(02)
    private CobolDecimal ppsTrainingAddOnPmtAmt;
    // OUT-NON-PER-DIEM-PAYMENT PIC 9(07)V9(04)
    private CobolDecimal outNonPerDiemPayment;
    // COM-PAYMENT-RATE PIC 9(04)V9(02)
    private CobolDecimal comPaymentRate;
    // TDAPA-RETURN PIC 9(07)V9(04)
    private CobolDecimal tdapaReturn;
    // TPNIES-RETURN PIC 9(07)V9(04)
    private CobolDecimal tpniesReturn;
    // NETWORK-REDUCTION-RETURN PIC 9(01)V9(02)
    private CobolDecimal networkReductionReturn;
    // ADJ-BASE-WAGE-BEFORE-ETC-HDPA PIC 9(07)V9(04)
    private CobolDecimal adjBaseWageBeforeEtcHdpa;
    // W-NEW-MSA PIC 9(04)
    private CobolDecimal wNewMsa;
    // W-NEW-EFF-DATE-CC PIC 9(02)
    private CobolDecimal wNewEffDateCc;
    // W-NEW-EFF-DATE-YY PIC 9(02)
    private CobolDecimal wNewEffDateYy;
    // W-NEW-EFF-DATE-MM PIC 9(02)
    private CobolDecimal wNewEffDateMm;
    // W-NEW-EFF-DATE-DD PIC 9(02)
    private CobolDecimal wNewEffDateDd;
    // W-NEW-RATE1-RECORD PIC S9(04)V9(02)
    private CobolDecimal wNewRate1Record;
    // W-NEW-RATE2-RECORD PIC S9(04)V9(02)
    private CobolDecimal wNewRate2Record;
    // COM-CBSA PIC 9(05)
    private CobolDecimal comCbsa;
    // COM-CBSA-DATE-CC PIC 9(02)
    private CobolDecimal comCbsaDateCc;
    // COM-CBSA-DATE-YY PIC 9(02)
    private CobolDecimal comCbsaDateYy;
    // COM-CBSA-DATE-MM PIC 9(02)
    private CobolDecimal comCbsaDateMm;
    // COM-CBSA-DATE-DD PIC 9(02)
    private CobolDecimal comCbsaDateDd;
    // COM-CBSA-W-INDEX PIC S9(02)V9(04)
    private CobolDecimal comCbsaWIndex;
    // BUN-CBSA PIC 9(05)
    private CobolDecimal bunCbsa;
    // BUN-CBSA-DATE-CC PIC 9(02)
    private CobolDecimal bunCbsaDateCc;
    // BUN-CBSA-DATE-YY PIC 9(02)
    private CobolDecimal bunCbsaDateYy;
    // BUN-CBSA-DATE-MM PIC 9(02)
    private CobolDecimal bunCbsaDateMm;
    // BUN-CBSA-DATE-DD PIC 9(02)
    private CobolDecimal bunCbsaDateDd;
    // BUN-CBSA-W-INDEX PIC S9(02)V9(04)
    private CobolDecimal bunCbsaWIndex;
    // DISPLAY-LINE-MEASUREMENT (group, 120 bytes)
    private CobolText displayLineMeasurement;
    // PRINT-LINE-MEASUREMENT (group, 133 bytes)
    private CobolText printLineMeasurement;
    // HOLD-PPS-COMPONENTS (group, 72 bytes)
    private CobolText holdPpsComponents;
    // BILL-NEW-DATA (group, 450 bytes)
    private CobolText billNewData;
    // BILL-PORTION (group, 60 bytes)
    private CobolText billPortion;
    // B-REV-CODE (group, 4 bytes)
    private CobolText bRevCode;
    // B-THRU-DATE (group, 8 bytes)
    private CobolText bThruDate;
    // B-DOB-DATE (group, 8 bytes)
    private CobolText bDobDate;
    // PROVIDER-SPECIFIC-FILE-PORTION (group, 86 bytes)
    private CobolText providerSpecificFilePortion;
    // BUNDLED-BILL-PORTION (group, 67 bytes)
    private CobolText bundledBillPortion;
    // B-LINE-ITEM-DATE-SERVICE (group, 8 bytes)
    private CobolText bLineItemDateService;
    // B-DIALYSIS-START-DATE (group, 8 bytes)
    private CobolText bDialysisStartDate;
    // COMORBIDITIES-PORTION (group, 16 bytes)
    private CobolText comorbiditiesPortion;
    // BILL-DATA-TEST (group, 220 bytes)
    private CobolText billDataTest;
    // COND-CD-73 (group, 8 bytes)
    private CobolText condCd73;
    // COND-CD-74 (group, 8 bytes)
    private CobolText condCd74;
    // PPS-DATA-ALL (group, 396 bytes)
    private CobolText ppsDataAll;
    // PPS-DATA (group, 55 bytes)
    private CobolText ppsData;
    // PPS-OTHER-DATA (group, 51 bytes)
    private CobolText ppsOtherData;
    // PPS-BUNDLED-DATA (group, 84 bytes)
    private CobolText ppsBundledData;
    // PPS-2011-COMORBID-DATA (group, 30 bytes)
    private CobolText pps2011ComorbidData;
    // WAGE-NEW-RATE-RECORD (group, 24 bytes)
    private CobolText wageNewRateRecord;
    // W-NEW-EFF-DATE (group, 8 bytes)
    private CobolText wNewEffDate;
    // W-NEW-EFF-DATE-YMD (group, 6 bytes)
    private CobolText wNewEffDateYmd;
    // COM-CBSA-WAGE-RECORD (group, 19 bytes)
    private CobolText comCbsaWageRecord;
    // COM-CBSA-DATE (group, 8 bytes)
    private CobolText comCbsaDate;
    // COM-CBSA-DATE-YMD (group, 6 bytes)
    private CobolText comCbsaDateYmd;
    // BUN-CBSA-WAGE-RECORD (group, 19 bytes)
    private CobolText bunCbsaWageRecord;
    // BUN-CBSA-DATE (group, 8 bytes)
    private CobolText bunCbsaDate;
    // BUN-CBSA-DATE-YMD (group, 6 bytes)
    private CobolText bunCbsaDateYmd;

    private void cocoonInit0() {
        wStorageRef = new CobolText(r_W_STORAGE_REF, 0, 46);
        calVersion = new CobolText(r_CAL_VERSION, 0, 5);
        filler = new CobolText(66);
        hPymtAmt = new CobolDecimal(r_HOLD_PPS_COMPONENTS, 0, 9, 7, 2, false, 0, 0);
        hWageAdjPymtAmt = new CobolDecimal(r_HOLD_PPS_COMPONENTS, 9, 9, 7, 2, false, 0, 0);
        hFixedLossAmt = new CobolDecimal(r_HOLD_PPS_COMPONENTS, 18, 9, 7, 2, false, 0, 0);
        hEsrdFacRate = new CobolDecimal(r_HOLD_PPS_COMPONENTS, 27, 9, 7, 2, false, 0, 0);
        hPatientAge = new CobolDecimal(r_HOLD_PPS_COMPONENTS, 36, 3, 3, 0, false, 0, 0);
        hAgeFactor = new CobolDecimal(r_HOLD_PPS_COMPONENTS, 39, 4, 1, 3, false, 0, 0);
        hBsaFactor = new CobolDecimal(r_HOLD_PPS_COMPONENTS, 43, 5, 1, 4, false, 0, 0);
        hBmiFactor = new CobolDecimal(r_HOLD_PPS_COMPONENTS, 48, 5, 1, 4, false, 0, 0);
        hBsa = new CobolDecimal(r_HOLD_PPS_COMPONENTS, 53, 7, 3, 4, false, 0, 0);
        hBmi = new CobolDecimal(r_HOLD_PPS_COMPONENTS, 60, 7, 3, 4, false, 0, 0);
        hDrugAddon = new CobolDecimal(r_HOLD_PPS_COMPONENTS, 67, 5, 1, 4, false, 0, 0);
        drugAddon = new CobolDecimal(r_DRUG_ADDON, 0, 5, 1, 4, false, 0, 0);
        msaBlendPct = new CobolDecimal(r_MSA_BLEND_PCT, 0, 3, 1, 2, false, 0, 0);
        cbsaBlendPct = new CobolDecimal(r_CBSA_BLEND_PCT, 0, 3, 1, 2, false, 0, 0);
        natLaborPct = new CobolDecimal(r_NAT_LABOR_PCT, 0, 6, 1, 5, false, 0, 0);
        natNonlaborPct = new CobolDecimal(r_NAT_NONLABOR_PCT, 0, 6, 1, 5, false, 0, 0);
        hemoPeriCcpdAmt = new CobolDecimal(r_HEMO_PERI_CCPD_AMT, 0, 2, 2, 0, false, 0, 0);
        capdAmt = new CobolDecimal(r_CAPD_AMT, 0, 2, 2, 0, false, 0, 0);
        capdOrCcpdFactor = new CobolDecimal(r_CAPD_OR_CCPD_FACTOR, 0, 7, 1, 6, false, 0, 0);
        caseMixBdgtNeutFactor = new CobolDecimal(r_CASE_MIX_BDGT_NEUT_FACTOR, 0, 5, 1, 4, false, 0, 0);
        bCondCode = new CobolText(r_BILL_NEW_DATA, 0, 2);
        bRevCode3 = new CobolText(r_BILL_NEW_DATA, 2, 3);
        bPatientHgt = new CobolDecimal(r_BILL_NEW_DATA, 6, 9, 7, 2, false, 0, 0);
        bPatientHeight = new CobolDecimal(r_BILL_NEW_DATA, 6, 9, 9, 0, false, 0, 0);
        bPatientWgt = new CobolDecimal(r_BILL_NEW_DATA, 15, 9, 7, 2, false, 0, 0);
        bPatientWeight = new CobolDecimal(r_BILL_NEW_DATA, 15, 9, 9, 0, false, 0, 0);
        bThruCcyy = new CobolDecimal(r_BILL_NEW_DATA, 24, 4, 4, 0, false, 0, 0);
        bThruMm = new CobolDecimal(r_BILL_NEW_DATA, 28, 2, 2, 0, false, 0, 0);
        bThruDd = new CobolDecimal(r_BILL_NEW_DATA, 30, 2, 2, 0, false, 0, 0);
        bDobCcyy = new CobolDecimal(r_BILL_NEW_DATA, 32, 4, 4, 0, false, 0, 0);
        bDobMm = new CobolDecimal(r_BILL_NEW_DATA, 36, 2, 2, 0, false, 0, 0);
        bDobDd = new CobolDecimal(r_BILL_NEW_DATA, 38, 2, 2, 0, false, 0, 0);
        pNpi = new CobolText(r_BILL_NEW_DATA, 60, 8);
        pNpiFiller = new CobolText(r_BILL_NEW_DATA, 68, 2);
        pProvOscar = new CobolText(r_BILL_NEW_DATA, 70, 6);
        pGeoMsa = new CobolText(r_BILL_NEW_DATA, 76, 4);
        pGeoCbsa = new CobolText(r_BILL_NEW_DATA, 80, 5);
        pSpecPymtInd = new CobolText(r_BILL_NEW_DATA, 85, 1);
        pProvType = new CobolText(r_BILL_NEW_DATA, 86, 2);
        pSpecWageIndx = new CobolDecimal(r_BILL_NEW_DATA, 88, 6, 2, 4, false, 0, 0);
        pEsrdRate = new CobolDecimal(r_BILL_NEW_DATA, 94, 9, 7, 2, false, 0, 0);
        pProvWaiveBlendPayIndic = new CobolText(r_BILL_NEW_DATA, 103, 1);
        pProvLowVolumeIndic = new CobolText(r_BILL_NEW_DATA, 104, 1);
        pPacificIsTrustTerr = new CobolText(r_BILL_NEW_DATA, 105, 1);
        pQipReduction = new CobolText(r_BILL_NEW_DATA, 106, 1);
        pSuppWiInd = new CobolText(r_BILL_NEW_DATA, 107, 1);
        pSuppWi = new CobolDecimal(r_BILL_NEW_DATA, 108, 6, 2, 4, false, 0, 0);
        oldTestIndicator = new CobolText(r_BILL_NEW_DATA, 122, 1);
        bClaimNumDialysisSessions = new CobolDecimal(r_BILL_NEW_DATA, 146, 2, 2, 0, false, 0, 0);
        bLineItemDtSvcCcyy = new CobolDecimal(r_BILL_NEW_DATA, 148, 4, 4, 0, false, 0, 0);
        bLineItemDtSvcMm = new CobolDecimal(r_BILL_NEW_DATA, 152, 2, 2, 0, false, 0, 0);
        bLineItemDtSvcDd = new CobolDecimal(r_BILL_NEW_DATA, 154, 2, 2, 0, false, 0, 0);
        bDialysisStartDtCcyy = new CobolDecimal(r_BILL_NEW_DATA, 156, 4, 4, 0, false, 0, 0);
        bDialysisStartDtMm = new CobolDecimal(r_BILL_NEW_DATA, 160, 2, 2, 0, false, 0, 0);
        bDialysisStartDtDd = new CobolDecimal(r_BILL_NEW_DATA, 162, 2, 2, 0, false, 0, 0);
        bTotPriceSbOutlier = new CobolDecimal(r_BILL_NEW_DATA, 164, 9, 7, 2, false, 0, 0);
        bPayerOnlyVcQ8 = new CobolDecimal(r_BILL_NEW_DATA, 173, 11, 7, 4, false, 0, 0);
        bDataCode = new CobolText(r_BILL_NEW_DATA, 184, 2);
        bPayerOnlyValueCode = new CobolText(r_BILL_NEW_DATA, 186, 2);
        bPayerOnlyVcQgAmt = new CobolDecimal(r_BILL_NEW_DATA, 188, 11, 7, 4, false, 0, 0);
        comorbidData = CobolText.table(r_BILL_NEW_DATA, 213, 2, 6, 2);
        comorbidRecurrenceCondCode = new CobolText(r_BILL_NEW_DATA, 225, 2);
        comorbidCwfReturnCode = new CobolText(r_BILL_NEW_DATA, 227, 2);
        drugAddOnReturn = new CobolDecimal(r_BILL_NEW_DATA, 229, 5, 1, 4, false, 0, 0);
        msaWageAdj = new CobolDecimal(r_BILL_NEW_DATA, 234, 6, 4, 2, false, 0, 0);
        compCbsaWageAdj = new CobolDecimal(r_BILL_NEW_DATA, 234, 6, 4, 2, false, 0, 0);
        cbsaWageAdj = new CobolDecimal(r_BILL_NEW_DATA, 240, 6, 4, 2, false, 0, 0);
        bundCbsaWageAdj = new CobolDecimal(r_BILL_NEW_DATA, 240, 6, 4, 2, false, 0, 0);
        cbsaWagePmtRate = new CobolDecimal(r_BILL_NEW_DATA, 246, 6, 4, 2, false, 0, 0);
        amtIndic = new CobolText(r_BILL_NEW_DATA, 253, 1);
        bloodDollar = new CobolDecimal(r_BILL_NEW_DATA, 255, 2, 2, 0, false, 0, 0);
        hemoCcpdCapd = new CobolDecimal(r_BILL_NEW_DATA, 252, 8, 2, 6, false, 0, 0);
        ageReturn = new CobolDecimal(r_BILL_NEW_DATA, 260, 3, 3, 0, false, 0, 0);
        msaWageAmt = new CobolDecimal(r_BILL_NEW_DATA, 263, 6, 4, 2, true, 0, 0);
        cbsaWageIndex = new CobolDecimal(r_BILL_NEW_DATA, 269, 6, 2, 4, true, 0, 0);
        laborPct = new CobolDecimal(r_BILL_NEW_DATA, 275, 6, 1, 5, false, 0, 0);
        ppsBmi = new CobolDecimal(r_BILL_NEW_DATA, 281, 7, 3, 4, false, 0, 0);
        ppsBsa = new CobolDecimal(r_BILL_NEW_DATA, 288, 7, 3, 4, false, 0, 0);
        msaPct = new CobolDecimal(r_BILL_NEW_DATA, 295, 3, 1, 2, false, 0, 0);
        cbsaPct = new CobolDecimal(r_BILL_NEW_DATA, 298, 3, 1, 2, false, 0, 0);
        comCbsaPctBlend = new CobolDecimal(r_BILL_NEW_DATA, 301, 3, 1, 2, false, 0, 0);
        bunCbsaPctBlend = new CobolDecimal(r_BILL_NEW_DATA, 304, 3, 1, 2, false, 0, 0);
        caseMixFctrAdjRate = new CobolDecimal(r_BILL_NEW_DATA, 307, 9, 7, 2, false, 0, 0);
        bunBsa = new CobolDecimal(r_BILL_NEW_DATA, 316, 7, 3, 4, false, 0, 0);
        bunBmi = new CobolDecimal(r_BILL_NEW_DATA, 323, 7, 3, 4, false, 0, 0);
        bunOnsetFactor = new CobolDecimal(r_BILL_NEW_DATA, 330, 5, 1, 4, false, 0, 0);
        bunComorbidMultiplier = new CobolDecimal(r_BILL_NEW_DATA, 335, 4, 1, 3, false, 0, 0);
        bunWageAdjTrainingAmt = new CobolDecimal(r_BILL_NEW_DATA, 339, 8, 4, 4, false, 0, 0);
        bunLowVolMultiplier = new CobolDecimal(r_BILL_NEW_DATA, 347, 4, 1, 3, false, 0, 0);
        outAgeFactor = new CobolDecimal(r_BILL_NEW_DATA, 369, 4, 1, 3, false, 0, 0);
        outBsa = new CobolDecimal(r_BILL_NEW_DATA, 373, 7, 3, 4, false, 0, 0);
        outBsaFactor = new CobolDecimal(r_BILL_NEW_DATA, 380, 5, 1, 4, false, 0, 0);
        outBmi = new CobolDecimal(r_BILL_NEW_DATA, 385, 7, 3, 4, false, 0, 0);
        outBmiFactor = new CobolDecimal(r_BILL_NEW_DATA, 392, 5, 1, 4, false, 0, 0);
        outOnsetFactor = new CobolDecimal(r_BILL_NEW_DATA, 397, 5, 1, 4, false, 0, 0);
        outComorbidMultiplier = new CobolDecimal(r_BILL_NEW_DATA, 402, 4, 1, 3, false, 0, 0);
        outLowVolMultiplier = new CobolDecimal(r_BILL_NEW_DATA, 406, 4, 1, 3, false, 0, 0);
        outAdjAvgMapAmt = new CobolDecimal(r_BILL_NEW_DATA, 410, 5, 3, 2, false, 0, 0);
        outLossSharingPct = new CobolDecimal(r_BILL_NEW_DATA, 415, 3, 1, 2, false, 0, 0);
        outImputedMap = new CobolDecimal(r_BILL_NEW_DATA, 418, 8, 4, 4, false, 0, 0);
        outFixDollarLoss = new CobolDecimal(r_BILL_NEW_DATA, 426, 6, 4, 2, false, 0, 0);
        outPredictedMap = new CobolDecimal(r_BILL_NEW_DATA, 432, 11, 7, 4, false, 0, 0);
        outPredictedServicesMap = new CobolDecimal(r_BILL_NEW_DATA, 443, 6, 2, 4, false, 0, 0);
        bundledTestIndic = new CobolText(r_BILL_NEW_DATA, 449, 1);
        ppsRtc = new CobolDecimal(r_PPS_DATA_ALL, 0, 2, 2, 0, false, 0, 0);
        ppsMsa = new CobolText(r_PPS_DATA_ALL, 2, 4);
        ppsCbsa = new CobolText(r_PPS_DATA_ALL, 6, 5);
        ppsWageAdjRate = new CobolDecimal(r_PPS_DATA_ALL, 11, 6, 4, 2, false, 0, 0);
        ppsFinalPayAmt = new CobolDecimal(r_PPS_DATA_ALL, 17, 9, 7, 2, false, 0, 0);
        ppsCalcVersCd = new CobolText(r_PPS_DATA_ALL, 26, 5);
        ppsCondCode = new CobolText(r_PPS_DATA_ALL, 31, 2);
        ppsRevCode = new CobolText(r_PPS_DATA_ALL, 33, 4);
        pps2011WageAdjRate = new CobolDecimal(r_PPS_DATA_ALL, 37, 6, 4, 2, false, 0, 0);
        pps2011NatLaborPct = new CobolDecimal(r_PPS_DATA_ALL, 43, 6, 1, 5, false, 0, 0);
        pps2011NatNonlaborPct = new CobolDecimal(r_PPS_DATA_ALL, 49, 6, 1, 5, false, 0, 0);
        ppsNatLaborPct = new CobolDecimal(r_PPS_DATA_ALL, 57, 6, 1, 5, false, 0, 0);
        ppsNatNonlaborPct = new CobolDecimal(r_PPS_DATA_ALL, 63, 6, 1, 5, false, 0, 0);
        ppsAgeFactor = new CobolDecimal(r_PPS_DATA_ALL, 69, 4, 1, 3, false, 0, 0);
        ppsBsaFactor = new CobolDecimal(r_PPS_DATA_ALL, 73, 5, 1, 4, false, 0, 0);
        ppsBmiFactor = new CobolDecimal(r_PPS_DATA_ALL, 78, 5, 1, 4, false, 0, 0);
        ppsBdgtNeutRate = new CobolDecimal(r_PPS_DATA_ALL, 83, 5, 1, 4, false, 0, 0);
        pps2011AgeFactor = new CobolDecimal(r_PPS_DATA_ALL, 88, 4, 1, 3, false, 0, 0);
        pps2011BsaFactor = new CobolDecimal(r_PPS_DATA_ALL, 92, 5, 1, 4, false, 0, 0);
        pps2011BmiFactor = new CobolDecimal(r_PPS_DATA_ALL, 97, 5, 1, 4, false, 0, 0);
        pps2011BdgtNeutRate = new CobolDecimal(r_PPS_DATA_ALL, 102, 5, 1, 4, false, 0, 0);
        pps2011ComorbidMa = new CobolText(r_PPS_DATA_ALL, 108, 2);
        pps2011ComorbidMaCc = new CobolText(r_PPS_DATA_ALL, 110, 2);
        pps2011ComorbidPay = new CobolText(r_PPS_DATA_ALL, 112, 2);
        pps2011FullCompRate = new CobolDecimal(r_PPS_DATA_ALL, 138, 9, 7, 2, false, 0, 0);
        pps2011BlendCompRate = new CobolDecimal(r_PPS_DATA_ALL, 147, 9, 7, 2, false, 0, 0);
        pps2011FullPpsRate = new CobolDecimal(r_PPS_DATA_ALL, 156, 9, 7, 2, false, 0, 0);
        pps2011BlendPpsRate = new CobolDecimal(r_PPS_DATA_ALL, 165, 9, 7, 2, false, 0, 0);
        pps2011FullOutlierRate = new CobolDecimal(r_PPS_DATA_ALL, 174, 9, 7, 2, false, 0, 0);
        pps2011BlendOutlierRate = new CobolDecimal(r_PPS_DATA_ALL, 183, 9, 7, 2, false, 0, 0);
        msaAdjYearAmt = new CobolDecimal(r_PPS_DATA_ALL, 192, 6, 4, 2, false, 0, 0);
        ppsLowVolAmt = new CobolDecimal(r_PPS_DATA_ALL, 192, 6, 4, 2, false, 0, 0);
        outCaseMixPredictedMap = new CobolDecimal(r_PPS_DATA_ALL, 198, 8, 4, 4, false, 0, 0);
        outHemoEquivDialSessions = new CobolDecimal(r_PPS_DATA_ALL, 206, 6, 2, 4, false, 0, 0);
        outSbBsa = new CobolDecimal(r_PPS_DATA_ALL, 212, 4, 1, 3, false, 0, 0);
        outSbBmi = new CobolDecimal(r_PPS_DATA_ALL, 216, 4, 1, 3, false, 0, 0);
        a49CentDrugAdj = new CobolDecimal(r_PPS_DATA_ALL, 220, 3, 1, 2, false, 0, 0);
        ppsCmBsa = new CobolDecimal(r_PPS_DATA_ALL, 223, 4, 1, 3, false, 0, 0);
        ppsCmBmiLt185 = new CobolDecimal(r_PPS_DATA_ALL, 227, 4, 1, 3, false, 0, 0);
        ppsBunBasePmtRate = new CobolDecimal(r_PPS_DATA_ALL, 231, 6, 4, 2, false, 0, 0);
        bunAdjustedBaseWageAmt = new CobolDecimal(r_PPS_DATA_ALL, 237, 11, 7, 4, false, 0, 0);
        crBsaMultiplier = new CobolDecimal(r_PPS_DATA_ALL, 248, 4, 1, 3, false, 0, 0);
        crBmiMultiplier = new CobolDecimal(r_PPS_DATA_ALL, 252, 4, 1, 3, false, 0, 0);
        ppsBunCbsaWIndex = new CobolDecimal(r_PPS_DATA_ALL, 256, 6, 2, 4, false, 0, 0);
        ppsBunWageAdjTrainAmt = new CobolDecimal(r_PPS_DATA_ALL, 262, 11, 7, 4, false, 0, 0);
        ppsTrainingAddOnPmtAmt = new CobolDecimal(r_PPS_DATA_ALL, 273, 4, 2, 2, false, 0, 0);
        outNonPerDiemPayment = new CobolDecimal(r_PPS_DATA_ALL, 277, 11, 7, 4, false, 0, 0);
        comPaymentRate = new CobolDecimal(r_PPS_DATA_ALL, 288, 6, 4, 2, false, 0, 0);
        tdapaReturn = new CobolDecimal(r_PPS_DATA_ALL, 294, 11, 7, 4, false, 0, 0);
        tpniesReturn = new CobolDecimal(r_PPS_DATA_ALL, 305, 11, 7, 4, false, 0, 0);
        networkReductionReturn = new CobolDecimal(r_PPS_DATA_ALL, 316, 3, 1, 2, false, 0, 0);
        adjBaseWageBeforeEtcHdpa = new CobolDecimal(r_PPS_DATA_ALL, 319, 11, 7, 4, false, 0, 0);
        wNewMsa = new CobolDecimal(r_WAGE_NEW_RATE_RECORD, 0, 4, 4, 0, false, 0, 0);
        wNewEffDateCc = new CobolDecimal(r_WAGE_NEW_RATE_RECORD, 4, 2, 2, 0, false, 0, 0);
        wNewEffDateYy = new CobolDecimal(r_WAGE_NEW_RATE_RECORD, 6, 2, 2, 0, false, 0, 0);
        wNewEffDateMm = new CobolDecimal(r_WAGE_NEW_RATE_RECORD, 8, 2, 2, 0, false, 0, 0);
        wNewEffDateDd = new CobolDecimal(r_WAGE_NEW_RATE_RECORD, 10, 2, 2, 0, false, 0, 0);
        wNewRate1Record = new CobolDecimal(r_WAGE_NEW_RATE_RECORD, 12, 6, 4, 2, true, 0, 0);
        wNewRate2Record = new CobolDecimal(r_WAGE_NEW_RATE_RECORD, 18, 6, 4, 2, true, 0, 0);
        comCbsa = new CobolDecimal(r_COM_CBSA_WAGE_RECORD, 0, 5, 5, 0, false, 0, 0);
        comCbsaDateCc = new CobolDecimal(r_COM_CBSA_WAGE_RECORD, 5, 2, 2, 0, false, 0, 0);
        comCbsaDateYy = new CobolDecimal(r_COM_CBSA_WAGE_RECORD, 7, 2, 2, 0, false, 0, 0);
        comCbsaDateMm = new CobolDecimal(r_COM_CBSA_WAGE_RECORD, 9, 2, 2, 0, false, 0, 0);
        comCbsaDateDd = new CobolDecimal(r_COM_CBSA_WAGE_RECORD, 11, 2, 2, 0, false, 0, 0);
        comCbsaWIndex = new CobolDecimal(r_COM_CBSA_WAGE_RECORD, 13, 6, 2, 4, true, 0, 0);
        bunCbsa = new CobolDecimal(r_BUN_CBSA_WAGE_RECORD, 0, 5, 5, 0, false, 0, 0);
        bunCbsaDateCc = new CobolDecimal(r_BUN_CBSA_WAGE_RECORD, 5, 2, 2, 0, false, 0, 0);
        bunCbsaDateYy = new CobolDecimal(r_BUN_CBSA_WAGE_RECORD, 7, 2, 2, 0, false, 0, 0);
        bunCbsaDateMm = new CobolDecimal(r_BUN_CBSA_WAGE_RECORD, 9, 2, 2, 0, false, 0, 0);
        bunCbsaDateDd = new CobolDecimal(r_BUN_CBSA_WAGE_RECORD, 11, 2, 2, 0, false, 0, 0);
        bunCbsaWIndex = new CobolDecimal(r_BUN_CBSA_WAGE_RECORD, 13, 6, 2, 4, true, 0, 0);
        displayLineMeasurement = new CobolText(r_DISPLAY_LINE_MEASUREMENT, 0, 120);
        printLineMeasurement = new CobolText(r_PRINT_LINE_MEASUREMENT, 0, 133);
        holdPpsComponents = new CobolText(r_HOLD_PPS_COMPONENTS, 0, 72);
        billNewData = new CobolText(r_BILL_NEW_DATA, 0, 450);
        billPortion = new CobolText(r_BILL_NEW_DATA, 0, 60);
        bRevCode = new CobolText(r_BILL_NEW_DATA, 2, 4);
        bThruDate = new CobolText(r_BILL_NEW_DATA, 24, 8);
        bDobDate = new CobolText(r_BILL_NEW_DATA, 32, 8);
        providerSpecificFilePortion = new CobolText(r_BILL_NEW_DATA, 60, 86);
        bundledBillPortion = new CobolText(r_BILL_NEW_DATA, 146, 67);
        bLineItemDateService = new CobolText(r_BILL_NEW_DATA, 148, 8);
        bDialysisStartDate = new CobolText(r_BILL_NEW_DATA, 156, 8);
        comorbiditiesPortion = new CobolText(r_BILL_NEW_DATA, 213, 16);
        billDataTest = new CobolText(r_BILL_NEW_DATA, 229, 220);
        condCd73 = new CobolText(r_BILL_NEW_DATA, 252, 8);
        condCd74 = new CobolText(r_BILL_NEW_DATA, 252, 8);
        ppsDataAll = new CobolText(r_PPS_DATA_ALL, 0, 396);
        ppsData = new CobolText(r_PPS_DATA_ALL, 2, 55);
        ppsOtherData = new CobolText(r_PPS_DATA_ALL, 57, 51);
        ppsBundledData = new CobolText(r_PPS_DATA_ALL, 108, 84);
        pps2011ComorbidData = new CobolText(r_PPS_DATA_ALL, 108, 30);
        wageNewRateRecord = new CobolText(r_WAGE_NEW_RATE_RECORD, 0, 24);
        wNewEffDate = new CobolText(r_WAGE_NEW_RATE_RECORD, 4, 8);
        wNewEffDateYmd = new CobolText(r_WAGE_NEW_RATE_RECORD, 6, 6);
        comCbsaWageRecord = new CobolText(r_COM_CBSA_WAGE_RECORD, 0, 19);
        comCbsaDate = new CobolText(r_COM_CBSA_WAGE_RECORD, 5, 8);
        comCbsaDateYmd = new CobolText(r_COM_CBSA_WAGE_RECORD, 7, 6);
        bunCbsaWageRecord = new CobolText(r_BUN_CBSA_WAGE_RECORD, 0, 19);
        bunCbsaDate = new CobolText(r_BUN_CBSA_WAGE_RECORD, 5, 8);
        bunCbsaDateYmd = new CobolText(r_BUN_CBSA_WAGE_RECORD, 7, 6);
    }

    public Escal056() {
        cocoonInit0();
    }

    /** GOBACK, STOP RUN or EXIT PROGRAM: the program ends, from however deep. */
    private static final class CocoonStop extends RuntimeException {
        CocoonStop() {
            super(null, null, false, false);
        }
    }

    /** GO TO: the paragraph control goes to next; the runner continues there. */
    private static final class CocoonGoTo extends RuntimeException {
        final int to;

        CocoonGoTo(int to) {
            super(null, null, false, false);
            this.to = to;
        }
    }

    private static final CocoonStop COCOON_STOP = new CocoonStop();

    private static void cocoonStop() {
        throw COCOON_STOP;
    }

    private static void cocoonGoTo(int to) {
        throw new CocoonGoTo(to);
    }

    // Index names (INDEXED BY): occurrence numbers, counted from one.
    private int comorbidIndex = 1;   // COMORBID-INDEX, of COMORBID-DATA

    public void run() {
        try {
            cocoonPerform(0, 6);
        } catch (CocoonStop s) {
            // GOBACK, STOP RUN or EXIT PROGRAM: the program ends
        }
    }

    /**
     * PERFORM from THRU thru: the paragraphs in order from the first to
     * the end of the last, falling through as COBOL does, and following
     * every GO TO wherever it leads - within the range or beyond it.
     */
    private void cocoonPerform(int from, int thru) {
        int p = from;
        while (true) {
            try {
                cocoonParagraph(p);
            } catch (CocoonGoTo g) {
                p = g.to;
                continue;
            }
            if (p == thru) {
                return;
            }
            p++;
            if (p >= 7) {
                throw COCOON_STOP;   // the end of the program
            }
        }
    }

    private void cocoonParagraph(int p) {
        switch (p) {
            case 0: p0000MainlineControl(); return;   // 0000-MAINLINE-CONTROL
            case 1: p0100InitialRoutine(); return;   // 0100-INITIAL-ROUTINE
            case 2: p1000EditTheBillInfo(); return;   // 1000-EDIT-THE-BILL-INFO
            case 3: p1200CalcAge(); return;   // 1200-CALC-AGE
            case 4: p2000AssemblePpsVariables(); return;   // 2000-ASSEMBLE-PPS-VARIABLES
            case 5: p3000CalcPayment(); return;   // 3000-CALC-PAYMENT
            case 6: p9000MoveResults(); return;   // 9000-MOVE-RESULTS
            default: throw COCOON_STOP;
        }
    }

    /** 0000-MAINLINE-CONTROL */
    private void p0000MainlineControl() {
        p0100InitialRoutine();
        if (ppsRtc.value().compareTo(new BigDecimal("00")) == 0) {
            p1000EditTheBillInfo();
        }
        if (ppsRtc.value().compareTo(new BigDecimal("00")) == 0) {
            p2000AssemblePpsVariables();
            p3000CalcPayment();
        }
        p9000MoveResults();
        cocoonStop();   // GOBACK
    }

    /** 0100-INITIAL-ROUTINE */
    private void p0100InitialRoutine() {
        ppsRtc.store(BigDecimal.ZERO);
        ppsMsa.store(" ");
        ppsCbsa.store(" ");
        ppsWageAdjRate.store(BigDecimal.ZERO);
        ppsFinalPayAmt.store(BigDecimal.ZERO);
        ppsCalcVersCd.store(" ");
        ppsCondCode.store(" ");
        ppsRevCode.store(" ");
        pps2011WageAdjRate.store(BigDecimal.ZERO);
        pps2011NatLaborPct.store(BigDecimal.ZERO);
        pps2011NatNonlaborPct.store(BigDecimal.ZERO);
        filler.store(" ");
        ppsNatLaborPct.store(BigDecimal.ZERO);
        ppsNatNonlaborPct.store(BigDecimal.ZERO);
        ppsAgeFactor.store(BigDecimal.ZERO);
        ppsBsaFactor.store(BigDecimal.ZERO);
        ppsBmiFactor.store(BigDecimal.ZERO);
        ppsBdgtNeutRate.store(BigDecimal.ZERO);
        pps2011AgeFactor.store(BigDecimal.ZERO);
        pps2011BsaFactor.store(BigDecimal.ZERO);
        pps2011BmiFactor.store(BigDecimal.ZERO);
        pps2011BdgtNeutRate.store(BigDecimal.ZERO);
        filler.store(" ");
        pps2011ComorbidMa.store(" ");
        pps2011ComorbidMaCc.store(" ");
        pps2011ComorbidPay.store(" ");
        filler.store(" ");
        pps2011FullCompRate.store(BigDecimal.ZERO);
        pps2011BlendCompRate.store(BigDecimal.ZERO);
        pps2011FullPpsRate.store(BigDecimal.ZERO);
        pps2011BlendPpsRate.store(BigDecimal.ZERO);
        pps2011FullOutlierRate.store(BigDecimal.ZERO);
        pps2011BlendOutlierRate.store(BigDecimal.ZERO);
        msaAdjYearAmt.store(BigDecimal.ZERO);
        outCaseMixPredictedMap.store(BigDecimal.ZERO);
        outHemoEquivDialSessions.store(BigDecimal.ZERO);
        outSbBsa.store(BigDecimal.ZERO);
        outSbBmi.store(BigDecimal.ZERO);
        a49CentDrugAdj.store(BigDecimal.ZERO);
        ppsCmBsa.store(BigDecimal.ZERO);
        ppsCmBmiLt185.store(BigDecimal.ZERO);
        ppsBunBasePmtRate.store(BigDecimal.ZERO);
        bunAdjustedBaseWageAmt.store(BigDecimal.ZERO);
        crBsaMultiplier.store(BigDecimal.ZERO);
        crBmiMultiplier.store(BigDecimal.ZERO);
        ppsBunCbsaWIndex.store(BigDecimal.ZERO);
        ppsBunWageAdjTrainAmt.store(BigDecimal.ZERO);
        ppsTrainingAddOnPmtAmt.store(BigDecimal.ZERO);
        outNonPerDiemPayment.store(BigDecimal.ZERO);
        comPaymentRate.store(BigDecimal.ZERO);
        tdapaReturn.store(BigDecimal.ZERO);
        tpniesReturn.store(BigDecimal.ZERO);
        networkReductionReturn.store(BigDecimal.ZERO);
        adjBaseWageBeforeEtcHdpa.store(BigDecimal.ZERO);
        filler.store(" ");
        drugAddOnReturn.store(BigDecimal.ZERO);
        msaWageAdj.store(BigDecimal.ZERO);
        cbsaWageAdj.store(BigDecimal.ZERO);
        cbsaWagePmtRate.store(BigDecimal.ZERO);
        filler.store(" ");
        amtIndic.store(" ");
        filler.store(" ");
        bloodDollar.store(BigDecimal.ZERO);
        filler.store(" ");
        ageReturn.store(BigDecimal.ZERO);
        msaWageAmt.store(BigDecimal.ZERO);
        cbsaWageIndex.store(BigDecimal.ZERO);
        laborPct.store(BigDecimal.ZERO);
        ppsBmi.store(BigDecimal.ZERO);
        ppsBsa.store(BigDecimal.ZERO);
        msaPct.store(BigDecimal.ZERO);
        cbsaPct.store(BigDecimal.ZERO);
        comCbsaPctBlend.store(BigDecimal.ZERO);
        bunCbsaPctBlend.store(BigDecimal.ZERO);
        caseMixFctrAdjRate.store(BigDecimal.ZERO);
        bunBsa.store(BigDecimal.ZERO);
        bunBmi.store(BigDecimal.ZERO);
        bunOnsetFactor.store(BigDecimal.ZERO);
        bunComorbidMultiplier.store(BigDecimal.ZERO);
        bunWageAdjTrainingAmt.store(BigDecimal.ZERO);
        bunLowVolMultiplier.store(BigDecimal.ZERO);
        filler.store(" ");
        outAgeFactor.store(BigDecimal.ZERO);
        outBsa.store(BigDecimal.ZERO);
        outBsaFactor.store(BigDecimal.ZERO);
        outBmi.store(BigDecimal.ZERO);
        outBmiFactor.store(BigDecimal.ZERO);
        outOnsetFactor.store(BigDecimal.ZERO);
        outComorbidMultiplier.store(BigDecimal.ZERO);
        outLowVolMultiplier.store(BigDecimal.ZERO);
        outAdjAvgMapAmt.store(BigDecimal.ZERO);
        outLossSharingPct.store(BigDecimal.ZERO);
        outImputedMap.store(BigDecimal.ZERO);
        outFixDollarLoss.store(BigDecimal.ZERO);
        outPredictedMap.store(BigDecimal.ZERO);
        outPredictedServicesMap.store(BigDecimal.ZERO);
        hPymtAmt.store(BigDecimal.ZERO);
        hWageAdjPymtAmt.store(BigDecimal.ZERO);
        hFixedLossAmt.store(BigDecimal.ZERO);
        hEsrdFacRate.store(BigDecimal.ZERO);
        hPatientAge.store(BigDecimal.ZERO);
        hAgeFactor.store(BigDecimal.ZERO);
        hBsaFactor.store(BigDecimal.ZERO);
        hBmiFactor.store(BigDecimal.ZERO);
        hBsa.store(BigDecimal.ZERO);
        hBmi.store(BigDecimal.ZERO);
        hDrugAddon.store(BigDecimal.ZERO);
        ppsRtc.store(BigDecimal.ZERO);
        ppsCalcVersCd.store(calVersion.value());
        if (pProvType.value().compareTo("40") == 0) {
            ppsNatLaborPct.store(BigDecimal.ZERO);
            ppsNatNonlaborPct.store(BigDecimal.ZERO);
            ppsWageAdjRate.store(wNewRate1Record.value());
            msaWageAmt.store(wNewRate1Record.value());
        } else {
            if (pProvType.value().compareTo("41") == 0) {
                ppsNatLaborPct.store(BigDecimal.ZERO);
                ppsNatNonlaborPct.store(BigDecimal.ZERO);
                ppsWageAdjRate.store(wNewRate2Record.value());
                msaWageAmt.store(wNewRate2Record.value());
            } else {
                ppsRtc.store(new BigDecimal("52"));
                ppsWageAdjRate.store(BigDecimal.ZERO);
            }
        }
        msaAdjYearAmt.store(ppsWageAdjRate.value());
        ppsBdgtNeutRate.store(caseMixBdgtNeutFactor.value());
        hDrugAddon.store(drugAddon.value());
    }

    /** 1000-EDIT-THE-BILL-INFO */
    private void p1000EditTheBillInfo() {
        if (ppsRtc.value().compareTo(new BigDecimal("00")) == 0) {
            if (pSpecPymtInd.value().compareTo("1") != 0 && pSpecPymtInd.value().compareTo(" ") != 0) {
                ppsRtc.store(new BigDecimal("53"));
            }
        }
        if (ppsRtc.value().compareTo(new BigDecimal("00")) == 0) {
            if (CobolText.compareAlnum(bDobDate.value(), "00000000") == 0 || !bDobDate.isNumeric()) {
                ppsRtc.store(new BigDecimal("54"));
            }
        }
        if (ppsRtc.value().compareTo(new BigDecimal("00")) == 0) {
            if (bPatientWgt.value().compareTo(new BigDecimal("0")) == 0 || !bPatientWgt.isNumeric()) {
                ppsRtc.store(new BigDecimal("55"));
            }
        }
        if (ppsRtc.value().compareTo(new BigDecimal("00")) == 0) {
            if (bPatientHgt.value().compareTo(new BigDecimal("0")) == 0 || !bPatientHgt.isNumeric()) {
                ppsRtc.store(new BigDecimal("56"));
            }
        }
        if (ppsRtc.value().compareTo(new BigDecimal("00")) == 0) {
            if (bRevCode.value().compareTo("0821") == 0 || bRevCode.value().compareTo("0831") == 0 || bRevCode.value().compareTo("0841") == 0 || bRevCode.value().compareTo("0851") == 0 || bRevCode.value().compareTo("0880") == 0 || bRevCode.value().compareTo("0881") == 0) {
            } else {
                ppsRtc.store(new BigDecimal("57"));
            }
        }
        if (ppsRtc.value().compareTo(new BigDecimal("00")) == 0) {
            if (bCondCode.value().compareTo("73") != 0 && bCondCode.value().compareTo("74") != 0 && bCondCode.value().compareTo("  ") != 0) {
                ppsRtc.store(new BigDecimal("58"));
            }
        }
        if (ppsRtc.value().compareTo(new BigDecimal("00")) == 0) {
            if (bPatientHgt.value().compareTo(new BigDecimal("300.00")) > 0) {
                ppsRtc.store(new BigDecimal("71"));
            }
        }
        if (ppsRtc.value().compareTo(new BigDecimal("00")) == 0) {
            if (bPatientWgt.value().compareTo(new BigDecimal("500.00")) > 0) {
                ppsRtc.store(new BigDecimal("72"));
            }
        }
        if (ppsRtc.value().compareTo(new BigDecimal("00")) == 0) {
            p1200CalcAge();
        }
    }

    /** 1200-CALC-AGE */
    private void p1200CalcAge() {
        hPatientAge.store(bThruCcyy.value().subtract(bDobCcyy.value()));
        // TRUNCATES: the expression produces up to 4 integer digits and H-PATIENT-AGE holds 3. The high-order digits are lost, as in the original.
        if (bDobMm.value().compareTo(bThruMm.value()) > 0) {
            hPatientAge.store(hPatientAge.value().subtract(new BigDecimal("1")));
        }
        if (hPatientAge.value().compareTo(new BigDecimal("18")) < 0) {
            hAgeFactor.store(new BigDecimal("1.620"));
        } else {
            if (hPatientAge.value().compareTo(new BigDecimal("17")) > 0 && hPatientAge.value().compareTo(new BigDecimal("45")) < 0) {
                hAgeFactor.store(new BigDecimal("1.223"));
            } else {
                if (hPatientAge.value().compareTo(new BigDecimal("44")) > 0 && hPatientAge.value().compareTo(new BigDecimal("60")) < 0) {
                    hAgeFactor.store(new BigDecimal("1.055"));
                } else {
                    if (hPatientAge.value().compareTo(new BigDecimal("59")) > 0 && hPatientAge.value().compareTo(new BigDecimal("70")) < 0) {
                        hAgeFactor.store(new BigDecimal("1.000"));
                    } else {
                        if (hPatientAge.value().compareTo(new BigDecimal("69")) > 0 && hPatientAge.value().compareTo(new BigDecimal("80")) < 0) {
                            hAgeFactor.store(new BigDecimal("1.094"));
                        } else {
                            if (hPatientAge.value().compareTo(new BigDecimal("79")) > 0) {
                                hAgeFactor.store(new BigDecimal("1.174"));
                            }
                        }
                    }
                }
            }
        }
    }

    /** 2000-ASSEMBLE-PPS-VARIABLES */
    private void p2000AssemblePpsVariables() {
        hWageAdjPymtAmt.store(ppsWageAdjRate.value());
        hBsa.storeRounded(new BigDecimal(".007184").multiply(CobolDecimal.pow(bPatientHgt.value(), new BigDecimal(".725"))).multiply(CobolDecimal.pow(bPatientWgt.value(), new BigDecimal(".425"))));
        // TRUNCATES: the expression produces up to 14 integer digits and H-BSA holds 3. The high-order digits are lost, as in the original.
        hBmi.storeRounded(CobolDecimal.divide(bPatientWgt.value(), CobolDecimal.pow(bPatientHgt.value(), new BigDecimal("2"))).multiply(new BigDecimal("10000")));
        // TRUNCATES: the expression produces up to 7 integer digits and H-BMI holds 3. The high-order digits are lost, as in the original.
        if (hPatientAge.value().compareTo(new BigDecimal("17")) > 0) {
            hBsaFactor.storeRounded(CobolDecimal.pow(new BigDecimal("1.037"), CobolDecimal.divide(hBsa.value().subtract(new BigDecimal("1.84")), new BigDecimal(".1"))));
            // TRUNCATES: the expression produces up to 3 integer digits and H-BSA-FACTOR holds 1. The high-order digits are lost, as in the original.
        } else {
            hBsaFactor.store(new BigDecimal("1.000"));
        }
        if (hPatientAge.value().compareTo(new BigDecimal("17")) > 0 && hBmi.value().compareTo(new BigDecimal("18.5")) < 0) {
            hBmiFactor.store(new BigDecimal("1.112"));
        } else {
            hBmiFactor.store(new BigDecimal("1.000"));
        }
    }

    /** 3000-CALC-PAYMENT */
    private void p3000CalcPayment() {
        hPymtAmt.storeRounded(hWageAdjPymtAmt.value().multiply(hBmiFactor.value()).multiply(hBsaFactor.value()).multiply(ppsBdgtNeutRate.value()).multiply(hAgeFactor.value()).multiply(hDrugAddon.value()));
        // TRUNCATES: the expression produces up to 12 integer digits and H-PYMT-AMT holds 7. The high-order digits are lost, as in the original.
        caseMixFctrAdjRate.store(hPymtAmt.value());
        condCd73.store(" ");
        if (bCondCode.value().compareTo("73") == 0 && (bRevCode.value().compareTo("0821") == 0 || bRevCode.value().compareTo("0831") == 0 || bRevCode.value().compareTo("0851") == 0)) {
            hPymtAmt.store(hPymtAmt.value().add(hemoPeriCcpdAmt.value()));
            amtIndic.store("A");
            bloodDollar.store(hemoPeriCcpdAmt.value());
        } else {
            if (bCondCode.value().compareTo("73") == 0 && bRevCode.value().compareTo("0841") == 0) {
                hPymtAmt.store(hPymtAmt.value().add(capdAmt.value()));
                amtIndic.store("A");
                bloodDollar.store(capdAmt.value());
            } else {
                if (bCondCode.value().compareTo("74") == 0 && (bRevCode.value().compareTo("0841") == 0 || bRevCode.value().compareTo("0851") == 0)) {
                    hPymtAmt.storeRounded(hPymtAmt.value().multiply(capdOrCcpdFactor.value()));
                    // TRUNCATES: the expression produces up to 8 integer digits and H-PYMT-AMT holds 7. The high-order digits are lost, as in the original.
                    hemoCcpdCapd.store(capdOrCcpdFactor.value());
                } else {
                    amtIndic.store("A");
                    bloodDollar.store(BigDecimal.ZERO);
                }
            }
        }
        ppsFinalPayAmt.store(hPymtAmt.value());
        ppsWageAdjRate.store(BigDecimal.ZERO);
    }

    /** 9000-MOVE-RESULTS */
    private void p9000MoveResults() {
        if (ppsRtc.value().compareTo(new BigDecimal("50")) < 0) {
            ppsCondCode.store(bCondCode.value());
            ppsRevCode.store(bRevCode.value());
            ppsMsa.store(pGeoMsa.value());
            ppsCbsa.store(pGeoCbsa.value());
            ppsAgeFactor.store(hAgeFactor.value());
            ppsBsaFactor.store(hBsaFactor.value());
            ppsBmiFactor.store(hBmiFactor.value());
            if (oldTestIndicator.value().compareTo("T") == 0) {
                drugAddOnReturn.store(hDrugAddon.value());
                if (pProvType.value().compareTo("40") == 0 || pProvType.value().compareTo("05") == 0) {
                    ppsWageAdjRate.store(wNewRate1Record.value());
                    msaWageAmt.store(wNewRate1Record.value());
                    msaWageAdj.store(wNewRate1Record.value());
                } else {
                    ppsWageAdjRate.store(wNewRate2Record.value());
                    msaWageAmt.store(wNewRate2Record.value());
                    msaWageAdj.store(wNewRate2Record.value());
                }
                cbsaWageAdj.store(BigDecimal.ZERO);
                cbsaPct.store(cbsaBlendPct.value());
                msaPct.store(msaBlendPct.value());
                cbsaWagePmtRate.store(BigDecimal.ZERO);
                ageReturn.store(hPatientAge.value());
                cbsaWageIndex.store(BigDecimal.ZERO);
                laborPct.store(natLaborPct.value());
            }
        } else {
            if (oldTestIndicator.value().compareTo("T") == 0) {
                ppsCondCode.store(" ");
                ppsRevCode.store(" ");
                ppsMsa.store(" ");
                ppsCbsa.store(" ");
                ppsAgeFactor.store(BigDecimal.ZERO);
                ppsBsaFactor.store(BigDecimal.ZERO);
                ppsBmiFactor.store(BigDecimal.ZERO);
                drugAddOnReturn.store(BigDecimal.ZERO);
                msaWageAdj.store(BigDecimal.ZERO);
                cbsaWageAdj.store(BigDecimal.ZERO);
                cbsaPct.store(BigDecimal.ZERO);
                msaPct.store(BigDecimal.ZERO);
                caseMixFctrAdjRate.store(BigDecimal.ZERO);
                cbsaWagePmtRate.store(BigDecimal.ZERO);
                hemoCcpdCapd.store(BigDecimal.ZERO);
                ageReturn.store(BigDecimal.ZERO);
            }
        }
    }

    public static void main(String[] args) {
        new Escal056().run();
    }
}
