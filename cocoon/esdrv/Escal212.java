import cocoon.runtime.CobolDecimal;
import cocoon.runtime.CobolText;
import cocoon.runtime.CobolRecord;
import java.math.BigDecimal;

/**
 * Translated from COBOL program ESCAL212.
 *
 * The arithmetic is deliberately not Java arithmetic. A
 * COBOL field holds what its PICTURE allows, and a value
 * too large loses its high-order digits without raising
 * anything. Every place this translation reproduces that
 * is marked TRUNCATES, because a faithful migration has
 * to compute the same numbers as the program it
 * replaces, defects included.
 */
public class Escal212 {

    // Records: the bytes, laid out as the mainframe lays them out.
    private final CobolRecord r_W_STORAGE_REF = new CobolRecord("W-STORAGE-REF", 46,
        "455343414c3231322020202020202d2057204f2052204b2049204e2047202020532054204f205220412047204520");
    private final CobolRecord r_CAL_VERSION = new CobolRecord("CAL-VERSION", 5,
        "4332312e32");
    private final CobolRecord r_DISPLAY_LINE_MEASUREMENT = new CobolRecord("DISPLAY-LINE-MEASUREMENT", 120,
        "2e2e2e2e3a2e2e2e31302e2e2e2e3a2e2e2e32302e2e2e2e3a2e2e2e33302e2e2e2e3a2e2e2e34302e2e2e2e3a2e2e2e35302e2e2e2e3a2e2e2e36302e2e2e2e3a2e2e2e37302e2e2e2e3a2e2e2e38302e2e2e2e3a2e2e2e39302e2e2e2e3a2e2e3130302e2e2e2e3a2e2e3131302e2e2e2e3a2e2e313230");
    private final CobolRecord r_PRINT_LINE_MEASUREMENT = new CobolRecord("PRINT-LINE-MEASUREMENT", 133,
        "582e2e2e2e3a2e2e2e31302e2e2e2e3a2e2e2e32302e2e2e2e3a2e2e2e33302e2e2e2e3a2e2e2e34302e2e2e2e3a2e2e2e35302e2e2e2e3a2e2e2e36302e2e2e2e3a2e2e2e37302e2e2e2e3a2e2e2e38302e2e2e2e3a2e2e2e39302e2e2e2e3a2e2e3130302e2e2e2e3a2e2e3131302e2e2e2e3a2e2e3132302e2e2e2e3a2e2e3133302e2e");
    private final CobolRecord r_HOLD_COMP_RATE_PPS_COMPONENTS = new CobolRecord("HOLD-COMP-RATE-PPS-COMPONENTS", 97,
        "30303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030");
    private final CobolRecord r_DRUG_ADDON = new CobolRecord("DRUG-ADDON", 5,
        "3131343030");
    private final CobolRecord r_BASE_PAYMENT_RATE = new CobolRecord("BASE-PAYMENT-RATE", 6,
        "303134353230");
    private final CobolRecord r_MSA_BLEND_PCT = new CobolRecord("MSA-BLEND-PCT", 3,
        "303030");
    private final CobolRecord r_CBSA_BLEND_PCT = new CobolRecord("CBSA-BLEND-PCT", 3,
        "313030");
    private final CobolRecord r_NAT_LABOR_PCT = new CobolRecord("NAT-LABOR-PCT", 6,
        "303533373131");
    private final CobolRecord r_NAT_NONLABOR_PCT = new CobolRecord("NAT-NONLABOR-PCT", 6,
        "303436323839");
    private final CobolRecord r_ETC_HDPA_PCT = new CobolRecord("ETC-HDPA-PCT", 3,
        "313033");
    private final CobolRecord r_A_49_CENT_PART_D_DRUG_ADJ = new CobolRecord("A-49-CENT-PART-D-DRUG-ADJ", 3,
        "303439");
    private final CobolRecord r_HEMO_PERI_CCPD_AMT = new CobolRecord("HEMO-PERI-CCPD-AMT", 2,
        "3230");
    private final CobolRecord r_CAPD_AMT = new CobolRecord("CAPD-AMT", 2,
        "3132");
    private final CobolRecord r_CAPD_OR_CCPD_FACTOR = new CobolRecord("CAPD-OR-CCPD-FACTOR", 7,
        "30343238353731");
    private final CobolRecord r_CASE_MIX_BDGT_NEUT_FACTOR = new CobolRecord("CASE-MIX-BDGT-NEUT-FACTOR", 5,
        "3039313136");
    private final CobolRecord r_COMPOSITE_RATE_MULTIPLIERS = new CobolRecord("COMPOSITE-RATE-MULTIPLIERS", 32,
        "3136323031323233313035353130303031303934313137343130333731313132");
    private final CobolRecord r_HOLD_BUNDLED_PPS_COMPONENTS = new CobolRecord("HOLD-BUNDLED-PPS-COMPONENTS", 320,
        "3030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030302020202020202020202020202020203030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303020303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030");
    private final CobolRecord r_HOLD_OUTLIER_PPS_COMPONENTS = new CobolRecord("HOLD-OUTLIER-PPS-COMPONENTS", 125,
        "3030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030");
    private final CobolRecord r_BUNDLED_BASE_PMT_RATE = new CobolRecord("BUNDLED-BASE-PMT-RATE", 6,
        "303235333133");
    private final CobolRecord r_COM_CBSA_BLEND_PCT = new CobolRecord("COM-CBSA-BLEND-PCT", 3,
        "303030");
    private final CobolRecord r_BUN_CBSA_BLEND_PCT = new CobolRecord("BUN-CBSA-BLEND-PCT", 3,
        "313030");
    private final CobolRecord r_WAIVE_CBSA_BLEND_PCT = new CobolRecord("WAIVE-CBSA-BLEND-PCT", 3,
        "313030");
    private final CobolRecord r_BUN_NAT_LABOR_PCT = new CobolRecord("BUN-NAT-LABOR-PCT", 6,
        "303532333030");
    private final CobolRecord r_BUN_NAT_NONLABOR_PCT = new CobolRecord("BUN-NAT-NONLABOR-PCT", 6,
        "303437373030");
    private final CobolRecord r_TRAINING_ADD_ON_PMT_AMT = new CobolRecord("TRAINING-ADD-ON-PMT-AMT", 4,
        "39353630");
    private final CobolRecord r_TRANSITION_BDGT_NEUT_FACTOR = new CobolRecord("TRANSITION-BDGT-NEUT-FACTOR", 5,
        "3039363930");
    private final CobolRecord r_BSA_NATIONAL_AVERAGE = new CobolRecord("BSA-NATIONAL-AVERAGE", 3,
        "313930");
    private final CobolRecord r_PEDIATRIC_MULTIPLIERS = new CobolRecord("PEDIATRIC-MULTIPLIERS", 32,
        "3034313031343036303536393134393431303633313330363131303231333237");
    private final CobolRecord r_ADULT_MULTIPLIERS = new CobolRecord("ADULT-MULTIPLIERS", 112,
        "31303434313030303130303531303030303936313130303031303930313430393132303931343236313939393134393430393535303937383132353731303638313037303130303031313039313033323130313731333237313034303130383231313932313039353132333931303038");
    private final CobolRecord r_OUTLIER_SB_CALC_AMOUNTS = new CobolRecord("OUTLIER-SB-CALC-AMOUNTS", 34,
        "30303330383830303530393230303434373830313232343930303038303030303830");
    private final CobolRecord r_PAID_RETURN_CODE_TRACKERS = new CobolRecord("PAID-RETURN-CODE-TRACKERS", 8,
        "2020202020202020");
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
        cocoonRecordMap.put("HOLD-COMP-RATE-PPS-COMPONENTS", r_HOLD_COMP_RATE_PPS_COMPONENTS);
        cocoonRecordMap.put("DRUG-ADDON", r_DRUG_ADDON);
        cocoonRecordMap.put("BASE-PAYMENT-RATE", r_BASE_PAYMENT_RATE);
        cocoonRecordMap.put("MSA-BLEND-PCT", r_MSA_BLEND_PCT);
        cocoonRecordMap.put("CBSA-BLEND-PCT", r_CBSA_BLEND_PCT);
        cocoonRecordMap.put("NAT-LABOR-PCT", r_NAT_LABOR_PCT);
        cocoonRecordMap.put("NAT-NONLABOR-PCT", r_NAT_NONLABOR_PCT);
        cocoonRecordMap.put("ETC-HDPA-PCT", r_ETC_HDPA_PCT);
        cocoonRecordMap.put("A-49-CENT-PART-D-DRUG-ADJ", r_A_49_CENT_PART_D_DRUG_ADJ);
        cocoonRecordMap.put("HEMO-PERI-CCPD-AMT", r_HEMO_PERI_CCPD_AMT);
        cocoonRecordMap.put("CAPD-AMT", r_CAPD_AMT);
        cocoonRecordMap.put("CAPD-OR-CCPD-FACTOR", r_CAPD_OR_CCPD_FACTOR);
        cocoonRecordMap.put("CASE-MIX-BDGT-NEUT-FACTOR", r_CASE_MIX_BDGT_NEUT_FACTOR);
        cocoonRecordMap.put("COMPOSITE-RATE-MULTIPLIERS", r_COMPOSITE_RATE_MULTIPLIERS);
        cocoonRecordMap.put("HOLD-BUNDLED-PPS-COMPONENTS", r_HOLD_BUNDLED_PPS_COMPONENTS);
        cocoonRecordMap.put("HOLD-OUTLIER-PPS-COMPONENTS", r_HOLD_OUTLIER_PPS_COMPONENTS);
        cocoonRecordMap.put("BUNDLED-BASE-PMT-RATE", r_BUNDLED_BASE_PMT_RATE);
        cocoonRecordMap.put("COM-CBSA-BLEND-PCT", r_COM_CBSA_BLEND_PCT);
        cocoonRecordMap.put("BUN-CBSA-BLEND-PCT", r_BUN_CBSA_BLEND_PCT);
        cocoonRecordMap.put("WAIVE-CBSA-BLEND-PCT", r_WAIVE_CBSA_BLEND_PCT);
        cocoonRecordMap.put("BUN-NAT-LABOR-PCT", r_BUN_NAT_LABOR_PCT);
        cocoonRecordMap.put("BUN-NAT-NONLABOR-PCT", r_BUN_NAT_NONLABOR_PCT);
        cocoonRecordMap.put("TRAINING-ADD-ON-PMT-AMT", r_TRAINING_ADD_ON_PMT_AMT);
        cocoonRecordMap.put("TRANSITION-BDGT-NEUT-FACTOR", r_TRANSITION_BDGT_NEUT_FACTOR);
        cocoonRecordMap.put("BSA-NATIONAL-AVERAGE", r_BSA_NATIONAL_AVERAGE);
        cocoonRecordMap.put("PEDIATRIC-MULTIPLIERS", r_PEDIATRIC_MULTIPLIERS);
        cocoonRecordMap.put("ADULT-MULTIPLIERS", r_ADULT_MULTIPLIERS);
        cocoonRecordMap.put("OUTLIER-SB-CALC-AMOUNTS", r_OUTLIER_SB_CALC_AMOUNTS);
        cocoonRecordMap.put("PAID-RETURN-CODE-TRACKERS", r_PAID_RETURN_CODE_TRACKERS);
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
    // H-PAYMENT-RATE PIC 9(04)V9(02)
    private CobolDecimal hPaymentRate;
    // H-PYMT-AMT PIC 9(04)V9(02)
    private CobolDecimal hPymtAmt;
    // H-WAGE-ADJ-PYMT-AMT PIC 9(04)V9(02)
    private CobolDecimal hWageAdjPymtAmt;
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
    // HGT-PART PIC 9(04)V9(08)
    private CobolDecimal hgtPart;
    // WGT-PART PIC 9(04)V9(08)
    private CobolDecimal wgtPart;
    // COMBINED-PART PIC 9(04)V9(08)
    private CobolDecimal combinedPart;
    // CALC-BSA PIC 9(04)V9(08)
    private CobolDecimal calcBsa;
    // DRUG-ADDON PIC 9(01)V9(04)
    private CobolDecimal drugAddon;
    // BASE-PAYMENT-RATE PIC 9(04)V9(02)
    private CobolDecimal basePaymentRate;
    // MSA-BLEND-PCT PIC 9(01)V9(02)
    private CobolDecimal msaBlendPct;
    // CBSA-BLEND-PCT PIC 9(01)V9(02)
    private CobolDecimal cbsaBlendPct;
    // NAT-LABOR-PCT PIC 9(01)V9(05)
    private CobolDecimal natLaborPct;
    // NAT-NONLABOR-PCT PIC 9(01)V9(05)
    private CobolDecimal natNonlaborPct;
    // ETC-HDPA-PCT PIC 9V99
    private CobolDecimal etcHdpaPct;
    // A-49-CENT-PART-D-DRUG-ADJ PIC 9(01)V9(02)
    private CobolDecimal a49CentPartDDrugAdj;
    // HEMO-PERI-CCPD-AMT PIC 9(02)
    private CobolDecimal hemoPeriCcpdAmt;
    // CAPD-AMT PIC 9(02)
    private CobolDecimal capdAmt;
    // CAPD-OR-CCPD-FACTOR PIC 9(01)V9(06)
    private CobolDecimal capdOrCcpdFactor;
    // CASE-MIX-BDGT-NEUT-FACTOR PIC 9(01)V9(04)
    private CobolDecimal caseMixBdgtNeutFactor;
    // CR-AGE-LT-18 PIC 9(01)V9(03)
    private CobolDecimal crAgeLt18;
    // CR-AGE-18-44 PIC 9(01)V9(03)
    private CobolDecimal crAge1844;
    // CR-AGE-45-59 PIC 9(01)V9(03)
    private CobolDecimal crAge4559;
    // CR-AGE-60-69 PIC 9(01)V9(03)
    private CobolDecimal crAge6069;
    // CR-AGE-70-79 PIC 9(01)V9(03)
    private CobolDecimal crAge7079;
    // CR-AGE-80-PLUS PIC 9(01)V9(03)
    private CobolDecimal crAge80Plus;
    // CR-BSA PIC 9(01)V9(03)
    private CobolDecimal crBsa;
    // CR-BMI-LT-18-5 PIC 9(01)V9(03)
    private CobolDecimal crBmiLt185;
    // H-BUN-NAT-LABOR-AMT PIC 9(04)V9(02)
    private CobolDecimal hBunNatLaborAmt;
    // H-BUN-NAT-NONLABOR-AMT PIC 9(04)V9(02)
    private CobolDecimal hBunNatNonlaborAmt;
    // H-BUN-BASE-WAGE-AMT PIC 9(04)V9(04)
    private CobolDecimal hBunBaseWageAmt;
    // H-BUN-AGE-FACTOR PIC 9(01)V9(03)
    private CobolDecimal hBunAgeFactor;
    // H-BUN-BSA PIC 9(03)V9(04)
    private CobolDecimal hBunBsa;
    // H-BUN-BSA-FACTOR PIC 9(01)V9(04)
    private CobolDecimal hBunBsaFactor;
    // H-BUN-BMI PIC 9(03)V9(04)
    private CobolDecimal hBunBmi;
    // H-BUN-BMI-FACTOR PIC 9(01)V9(04)
    private CobolDecimal hBunBmiFactor;
    // H-BUN-ONSET-FACTOR PIC 9(01)V9(04)
    private CobolDecimal hBunOnsetFactor;
    // H-BUN-COMORBID-MULTIPLIER PIC 9(01)V9(03)
    private CobolDecimal hBunComorbidMultiplier;
    // H-BUN-ADJUSTED-BASE-WAGE-AMT PIC 9(07)V9(04)
    private CobolDecimal hBunAdjustedBaseWageAmt;
    // H-BUN-WAGE-ADJ-TRAINING-AMT PIC 9(07)V9(04)
    private CobolDecimal hBunWageAdjTrainingAmt;
    // H-CC-74-PER-DIEM-AMT PIC 9(07)V9(04)
    private CobolDecimal hCc74PerDiemAmt;
    // H-HEMO-EQUIV-DIAL-SESSIONS PIC 9(07)V9(04)
    private CobolDecimal hHemoEquivDialSessions;
    // H-PPS-FINAL-PAY-AMT PIC 9(07)V9(02)
    private CobolDecimal hPpsFinalPayAmt;
    // H-FULL-CLAIM-AMT PIC 9(07)V9(02)
    private CobolDecimal hFullClaimAmt;
    // H-LV-BUN-ADJUST-BASE-WAGE-AMT PIC 9(07)V9(04)
    private CobolDecimal hLvBunAdjustBaseWageAmt;
    // H-LV-PPS-FINAL-PAY-AMT PIC 9(07)V9(04)
    private CobolDecimal hLvPpsFinalPayAmt;
    // H-LV-OUT-PREDICT-SERVICES-MAP PIC 9(07)V9(04)
    private CobolDecimal hLvOutPredictServicesMap;
    // H-LV-OUT-CM-ADJ-PREDICT-M-TRT PIC 9(07)V9(04)
    private CobolDecimal hLvOutCmAdjPredictMTrt;
    // H-LV-OUT-PREDICTED-MAP PIC 9(07)V9(04)
    private CobolDecimal hLvOutPredictedMap;
    // H-LV-OUT-PAYMENT PIC 9(07)V9(04)
    private CobolDecimal hLvOutPayment;
    // H-COMORBID-MULTIPLIER PIC 9(01)V9(03)
    private CobolDecimal hComorbidMultiplier;
    // IS-HIGH-COMORBID-FOUND PIC X(01)
    private CobolText isHighComorbidFound;
    // H-COMORBID-DATA PIC X(02)
    private CobolText[] hComorbidData;
    // H-COMORBID-CWF-CODE PIC X(02)
    private CobolText hComorbidCwfCode;
    // H-BUN-LOW-VOL-MULTIPLIER PIC 9(01)V9(03)
    private CobolDecimal hBunLowVolMultiplier;
    // QIP-REDUCTION PIC 9(01)V9(03)
    private CobolDecimal qipReduction;
    // SUB PIC 9(04)
    private CobolDecimal sub;
    // THE-DATE PIC 9(08)
    private CobolDecimal theDate;
    // INTEGER-LINE-ITEM-DATE PIC S9(09)
    private CobolDecimal integerLineItemDate;
    // INTEGER-DIALYSIS-DATE PIC S9(09)
    private CobolDecimal integerDialysisDate;
    // ONSET-DATE PIC 9(08)
    private CobolDecimal onsetDate;
    // MOVED-CORMORBIDS PIC X(01)
    private CobolText movedCormorbids;
    // H-BUN-RURAL-MULTIPLIER PIC 9(01)V9(03)
    private CobolDecimal hBunRuralMultiplier;
    // H-TDAPA-PAYMENT PIC 9(07)V9(04)
    private CobolDecimal hTdapaPayment;
    // H-TPNIES-PAYMENT PIC 9(07)V9(04)
    private CobolDecimal hTpniesPayment;
    // H-NETWORK-REDUCTION PIC 9(01)V9(02)
    private CobolDecimal hNetworkReduction;
    // H-PER-DIEM-AMT-WITHOUT-HDPA PIC 9(07)V9(04)
    private CobolDecimal hPerDiemAmtWithoutHdpa;
    // H-PER-DIEM-AMT-WITH-HDPA PIC 9(07)V9(04)
    private CobolDecimal hPerDiemAmtWithHdpa;
    // H-FINAL-AMT-WITHOUT-HDPA PIC 9(07)V9(02)
    private CobolDecimal hFinalAmtWithoutHdpa;
    // H-FINAL-AMT-WITH-HDPA PIC 9(07)V9(02)
    private CobolDecimal hFinalAmtWithHdpa;
    // H-OUT-AGE-FACTOR PIC 9(01)V9(03)
    private CobolDecimal hOutAgeFactor;
    // H-OUT-BSA PIC 9(03)V9(04)
    private CobolDecimal hOutBsa;
    // H-OUT-BSA-FACTOR PIC 9(01)V9(04)
    private CobolDecimal hOutBsaFactor;
    // H-OUT-BMI PIC 9(03)V9(04)
    private CobolDecimal hOutBmi;
    // H-OUT-BMI-FACTOR PIC 9(01)V9(04)
    private CobolDecimal hOutBmiFactor;
    // H-OUT-ONSET-FACTOR PIC 9(01)V9(04)
    private CobolDecimal hOutOnsetFactor;
    // H-OUT-COMORBID-MULTIPLIER PIC 9(01)V9(03)
    private CobolDecimal hOutComorbidMultiplier;
    // H-OUT-LOW-VOL-MULTIPLIER PIC 9(01)V9(03)
    private CobolDecimal hOutLowVolMultiplier;
    // H-OUT-ADJ-AVG-MAP-AMT PIC 9(03)V9(02)
    private CobolDecimal hOutAdjAvgMapAmt;
    // H-OUT-FIX-DOLLAR-LOSS PIC 9(04)V9(02)
    private CobolDecimal hOutFixDollarLoss;
    // H-OUT-LOSS-SHARING-PCT PIC 9(01)V9(02)
    private CobolDecimal hOutLossSharingPct;
    // H-OUT-PREDICTED-SERVICES-MAP PIC 9(07)V9(04)
    private CobolDecimal hOutPredictedServicesMap;
    // H-OUT-IMPUTED-MAP PIC 9(07)V9(04)
    private CobolDecimal hOutImputedMap;
    // H-OUT-CM-ADJ-PREDICT-MAP-TRT PIC 9(07)V9(04)
    private CobolDecimal hOutCmAdjPredictMapTrt;
    // H-OUT-PREDICTED-MAP PIC 9(07)V9(04)
    private CobolDecimal hOutPredictedMap;
    // H-OUT-PAYMENT PIC 9(07)V9(04)
    private CobolDecimal hOutPayment;
    // H-OUT-HEMO-EQUIV-PAYMENT PIC 9(07)V9(04)
    private CobolDecimal hOutHemoEquivPayment;
    // H-OUT-RURAL-MULTIPLIER PIC 9(01)V9(03)
    private CobolDecimal hOutRuralMultiplier;
    // BUNDLED-BASE-PMT-RATE PIC 9(04)V9(02)
    private CobolDecimal bundledBasePmtRate;
    // COM-CBSA-BLEND-PCT PIC 9(01)V9(02)
    private CobolDecimal comCbsaBlendPct;
    // BUN-CBSA-BLEND-PCT PIC 9(01)V9(02)
    private CobolDecimal bunCbsaBlendPct;
    // WAIVE-CBSA-BLEND-PCT PIC 9(01)V9(02)
    private CobolDecimal waiveCbsaBlendPct;
    // BUN-NAT-LABOR-PCT PIC 9(01)V9(05)
    private CobolDecimal bunNatLaborPct;
    // BUN-NAT-NONLABOR-PCT PIC 9(01)V9(05)
    private CobolDecimal bunNatNonlaborPct;
    // TRAINING-ADD-ON-PMT-AMT PIC 9(02)V9(02)
    private CobolDecimal trainingAddOnPmtAmt;
    // TRANSITION-BDGT-NEUT-FACTOR PIC 9(01)V9(04)
    private CobolDecimal transitionBdgtNeutFactor;
    // BSA-NATIONAL-AVERAGE PIC 9(01)V9(02)
    private CobolDecimal bsaNationalAverage;
    // SB-AGE-LT-13-PD-MODE PIC 9(01)V9(03)
    private CobolDecimal sbAgeLt13PdMode;
    // SB-AGE-LT-13-HEMO-MODE PIC 9(01)V9(03)
    private CobolDecimal sbAgeLt13HemoMode;
    // SB-AGE-13-17-PD-MODE PIC 9(01)V9(03)
    private CobolDecimal sbAge1317PdMode;
    // SB-AGE-13-17-HEMO-MODE PIC 9(01)V9(03)
    private CobolDecimal sbAge1317HemoMode;
    // EB-AGE-LT-13-PD-MODE PIC 9(01)V9(03)
    private CobolDecimal ebAgeLt13PdMode;
    // EB-AGE-LT-13-HEMO-MODE PIC 9(01)V9(03)
    private CobolDecimal ebAgeLt13HemoMode;
    // EB-AGE-13-17-PD-MODE PIC 9(01)V9(03)
    private CobolDecimal ebAge1317PdMode;
    // EB-AGE-13-17-HEMO-MODE PIC 9(01)V9(03)
    private CobolDecimal ebAge1317HemoMode;
    // SB-AGE-18-44 PIC 9(01)V9(03)
    private CobolDecimal sbAge1844;
    // SB-AGE-45-59 PIC 9(01)V9(03)
    private CobolDecimal sbAge4559;
    // SB-AGE-60-69 PIC 9(01)V9(03)
    private CobolDecimal sbAge6069;
    // SB-AGE-70-79 PIC 9(01)V9(03)
    private CobolDecimal sbAge7079;
    // SB-AGE-80-PLUS PIC 9(01)V9(03)
    private CobolDecimal sbAge80Plus;
    // SB-BSA PIC 9(01)V9(03)
    private CobolDecimal sbBsa;
    // SB-BMI-LT-18-5 PIC 9(01)V9(03)
    private CobolDecimal sbBmiLt185;
    // SB-ONSET-LE-120 PIC 9(01)V9(03)
    private CobolDecimal sbOnsetLe120;
    // SB-PERICARDITIS PIC 9(01)V9(03)
    private CobolDecimal sbPericarditis;
    // SB-GI-BLEED PIC 9(01)V9(03)
    private CobolDecimal sbGiBleed;
    // SB-SICKEL-CELL PIC 9(01)V9(03)
    private CobolDecimal sbSickelCell;
    // SB-MYELODYSPLASTIC PIC 9(01)V9(03)
    private CobolDecimal sbMyelodysplastic;
    // SB-LOW-VOL-ADJ-LT-4000 PIC 9(01)V9(03)
    private CobolDecimal sbLowVolAdjLt4000;
    // SB-RURAL PIC 9(01)V9(03)
    private CobolDecimal sbRural;
    // CM-AGE-18-44 PIC 9(01)V9(03)
    private CobolDecimal cmAge1844;
    // CM-AGE-45-59 PIC 9(01)V9(03)
    private CobolDecimal cmAge4559;
    // CM-AGE-60-69 PIC 9(01)V9(03)
    private CobolDecimal cmAge6069;
    // CM-AGE-70-79 PIC 9(01)V9(03)
    private CobolDecimal cmAge7079;
    // CM-AGE-80-PLUS PIC 9(01)V9(03)
    private CobolDecimal cmAge80Plus;
    // CM-BSA PIC 9(01)V9(03)
    private CobolDecimal cmBsa;
    // CM-BMI-LT-18-5 PIC 9(01)V9(03)
    private CobolDecimal cmBmiLt185;
    // CM-ONSET-LE-120 PIC 9(01)V9(03)
    private CobolDecimal cmOnsetLe120;
    // CM-PERICARDITIS PIC 9(01)V9(03)
    private CobolDecimal cmPericarditis;
    // CM-GI-BLEED PIC 9(01)V9(03)
    private CobolDecimal cmGiBleed;
    // CM-SICKEL-CELL PIC 9(01)V9(03)
    private CobolDecimal cmSickelCell;
    // CM-MYELODYSPLASTIC PIC 9(01)V9(03)
    private CobolDecimal cmMyelodysplastic;
    // CM-LOW-VOL-ADJ-LT-4000 PIC 9(01)V9(03)
    private CobolDecimal cmLowVolAdjLt4000;
    // CM-RURAL PIC 9(01)V9(03)
    private CobolDecimal cmRural;
    // ADJ-AVG-MAP-AMT-LT-18 PIC 9(04)V9(02)
    private CobolDecimal adjAvgMapAmtLt18;
    // ADJ-AVG-MAP-AMT-GT-17 PIC 9(04)V9(02)
    private CobolDecimal adjAvgMapAmtGt17;
    // FIX-DOLLAR-LOSS-LT-18 PIC 9(04)V9(02)
    private CobolDecimal fixDollarLossLt18;
    // FIX-DOLLAR-LOSS-GT-17 PIC 9(04)V9(02)
    private CobolDecimal fixDollarLossGt17;
    // LOSS-SHARING-PCT-LT-18 PIC 9(03)V9(02)
    private CobolDecimal lossSharingPctLt18;
    // LOSS-SHARING-PCT-GT-17 PIC 9(03)V9(02)
    private CobolDecimal lossSharingPctGt17;
    // OUTLIER-TRACK PIC X(01)
    private CobolText outlierTrack;
    // ACUTE-COMORBID-TRACK PIC X(01)
    private CobolText acuteComorbidTrack;
    // CHRONIC-COMORBID-TRACK PIC X(01)
    private CobolText chronicComorbidTrack;
    // ONSET-TRACK PIC X(01)
    private CobolText onsetTrack;
    // LOW-VOLUME-TRACK PIC X(01)
    private CobolText lowVolumeTrack;
    // TRAINING-TRACK PIC X(01)
    private CobolText trainingTrack;
    // PEDIATRIC-TRACK PIC X(01)
    private CobolText pediatricTrack;
    // LOW-BMI-TRACK PIC X(01)
    private CobolText lowBmiTrack;
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
    // HOLD-COMP-RATE-PPS-COMPONENTS (group, 97 bytes)
    private CobolText holdCompRatePpsComponents;
    // COMPOSITE-RATE-MULTIPLIERS (group, 32 bytes)
    private CobolText compositeRateMultipliers;
    // HOLD-BUNDLED-PPS-COMPONENTS (group, 320 bytes)
    private CobolText holdBundledPpsComponents;
    // HOLD-OUTLIER-PPS-COMPONENTS (group, 125 bytes)
    private CobolText holdOutlierPpsComponents;
    // PEDIATRIC-MULTIPLIERS (group, 32 bytes)
    private CobolText pediatricMultipliers;
    // PED-SEP-BILL-PAY-MULTI (group, 16 bytes)
    private CobolText pedSepBillPayMulti;
    // PED-EXPAND-BUNDLE-PAY-MULTI (group, 16 bytes)
    private CobolText pedExpandBundlePayMulti;
    // ADULT-MULTIPLIERS (group, 112 bytes)
    private CobolText adultMultipliers;
    // SEP-BILLABLE-PAYMANT-MULTI (group, 56 bytes)
    private CobolText sepBillablePaymantMulti;
    // CASE-MIX-PAYMENT-MULTI (group, 56 bytes)
    private CobolText caseMixPaymentMulti;
    // OUTLIER-SB-CALC-AMOUNTS (group, 34 bytes)
    private CobolText outlierSbCalcAmounts;
    // PAID-RETURN-CODE-TRACKERS (group, 8 bytes)
    private CobolText paidReturnCodeTrackers;
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
        hPaymentRate = new CobolDecimal(r_HOLD_COMP_RATE_PPS_COMPONENTS, 0, 6, 4, 2, false, 0, 0);
        hPymtAmt = new CobolDecimal(r_HOLD_COMP_RATE_PPS_COMPONENTS, 6, 6, 4, 2, false, 0, 0);
        hWageAdjPymtAmt = new CobolDecimal(r_HOLD_COMP_RATE_PPS_COMPONENTS, 12, 6, 4, 2, false, 0, 0);
        hPatientAge = new CobolDecimal(r_HOLD_COMP_RATE_PPS_COMPONENTS, 18, 3, 3, 0, false, 0, 0);
        hAgeFactor = new CobolDecimal(r_HOLD_COMP_RATE_PPS_COMPONENTS, 21, 4, 1, 3, false, 0, 0);
        hBsaFactor = new CobolDecimal(r_HOLD_COMP_RATE_PPS_COMPONENTS, 25, 5, 1, 4, false, 0, 0);
        hBmiFactor = new CobolDecimal(r_HOLD_COMP_RATE_PPS_COMPONENTS, 30, 5, 1, 4, false, 0, 0);
        hBsa = new CobolDecimal(r_HOLD_COMP_RATE_PPS_COMPONENTS, 35, 7, 3, 4, false, 0, 0);
        hBmi = new CobolDecimal(r_HOLD_COMP_RATE_PPS_COMPONENTS, 42, 7, 3, 4, false, 0, 0);
        hgtPart = new CobolDecimal(r_HOLD_COMP_RATE_PPS_COMPONENTS, 49, 12, 4, 8, false, 0, 0);
        wgtPart = new CobolDecimal(r_HOLD_COMP_RATE_PPS_COMPONENTS, 61, 12, 4, 8, false, 0, 0);
        combinedPart = new CobolDecimal(r_HOLD_COMP_RATE_PPS_COMPONENTS, 73, 12, 4, 8, false, 0, 0);
        calcBsa = new CobolDecimal(r_HOLD_COMP_RATE_PPS_COMPONENTS, 85, 12, 4, 8, false, 0, 0);
        drugAddon = new CobolDecimal(r_DRUG_ADDON, 0, 5, 1, 4, false, 0, 0);
        basePaymentRate = new CobolDecimal(r_BASE_PAYMENT_RATE, 0, 6, 4, 2, false, 0, 0);
        msaBlendPct = new CobolDecimal(r_MSA_BLEND_PCT, 0, 3, 1, 2, false, 0, 0);
        cbsaBlendPct = new CobolDecimal(r_CBSA_BLEND_PCT, 0, 3, 1, 2, false, 0, 0);
        natLaborPct = new CobolDecimal(r_NAT_LABOR_PCT, 0, 6, 1, 5, false, 0, 0);
        natNonlaborPct = new CobolDecimal(r_NAT_NONLABOR_PCT, 0, 6, 1, 5, false, 0, 0);
        etcHdpaPct = new CobolDecimal(r_ETC_HDPA_PCT, 0, 3, 1, 2, false, 0, 0);
        a49CentPartDDrugAdj = new CobolDecimal(r_A_49_CENT_PART_D_DRUG_ADJ, 0, 3, 1, 2, false, 0, 0);
        hemoPeriCcpdAmt = new CobolDecimal(r_HEMO_PERI_CCPD_AMT, 0, 2, 2, 0, false, 0, 0);
        capdAmt = new CobolDecimal(r_CAPD_AMT, 0, 2, 2, 0, false, 0, 0);
        capdOrCcpdFactor = new CobolDecimal(r_CAPD_OR_CCPD_FACTOR, 0, 7, 1, 6, false, 0, 0);
        caseMixBdgtNeutFactor = new CobolDecimal(r_CASE_MIX_BDGT_NEUT_FACTOR, 0, 5, 1, 4, false, 0, 0);
        crAgeLt18 = new CobolDecimal(r_COMPOSITE_RATE_MULTIPLIERS, 0, 4, 1, 3, false, 0, 0);
        crAge1844 = new CobolDecimal(r_COMPOSITE_RATE_MULTIPLIERS, 4, 4, 1, 3, false, 0, 0);
        crAge4559 = new CobolDecimal(r_COMPOSITE_RATE_MULTIPLIERS, 8, 4, 1, 3, false, 0, 0);
        crAge6069 = new CobolDecimal(r_COMPOSITE_RATE_MULTIPLIERS, 12, 4, 1, 3, false, 0, 0);
        crAge7079 = new CobolDecimal(r_COMPOSITE_RATE_MULTIPLIERS, 16, 4, 1, 3, false, 0, 0);
        crAge80Plus = new CobolDecimal(r_COMPOSITE_RATE_MULTIPLIERS, 20, 4, 1, 3, false, 0, 0);
        crBsa = new CobolDecimal(r_COMPOSITE_RATE_MULTIPLIERS, 24, 4, 1, 3, false, 0, 0);
        crBmiLt185 = new CobolDecimal(r_COMPOSITE_RATE_MULTIPLIERS, 28, 4, 1, 3, false, 0, 0);
        hBunNatLaborAmt = new CobolDecimal(r_HOLD_BUNDLED_PPS_COMPONENTS, 0, 6, 4, 2, false, 0, 0);
        hBunNatNonlaborAmt = new CobolDecimal(r_HOLD_BUNDLED_PPS_COMPONENTS, 6, 6, 4, 2, false, 0, 0);
        hBunBaseWageAmt = new CobolDecimal(r_HOLD_BUNDLED_PPS_COMPONENTS, 12, 8, 4, 4, false, 0, 0);
        hBunAgeFactor = new CobolDecimal(r_HOLD_BUNDLED_PPS_COMPONENTS, 20, 4, 1, 3, false, 0, 0);
        hBunBsa = new CobolDecimal(r_HOLD_BUNDLED_PPS_COMPONENTS, 24, 7, 3, 4, false, 0, 0);
        hBunBsaFactor = new CobolDecimal(r_HOLD_BUNDLED_PPS_COMPONENTS, 31, 5, 1, 4, false, 0, 0);
        hBunBmi = new CobolDecimal(r_HOLD_BUNDLED_PPS_COMPONENTS, 36, 7, 3, 4, false, 0, 0);
        hBunBmiFactor = new CobolDecimal(r_HOLD_BUNDLED_PPS_COMPONENTS, 43, 5, 1, 4, false, 0, 0);
        hBunOnsetFactor = new CobolDecimal(r_HOLD_BUNDLED_PPS_COMPONENTS, 48, 5, 1, 4, false, 0, 0);
        hBunComorbidMultiplier = new CobolDecimal(r_HOLD_BUNDLED_PPS_COMPONENTS, 53, 4, 1, 3, false, 0, 0);
        hBunAdjustedBaseWageAmt = new CobolDecimal(r_HOLD_BUNDLED_PPS_COMPONENTS, 57, 11, 7, 4, false, 0, 0);
        hBunWageAdjTrainingAmt = new CobolDecimal(r_HOLD_BUNDLED_PPS_COMPONENTS, 68, 11, 7, 4, false, 0, 0);
        hCc74PerDiemAmt = new CobolDecimal(r_HOLD_BUNDLED_PPS_COMPONENTS, 79, 11, 7, 4, false, 0, 0);
        hHemoEquivDialSessions = new CobolDecimal(r_HOLD_BUNDLED_PPS_COMPONENTS, 90, 11, 7, 4, false, 0, 0);
        hPpsFinalPayAmt = new CobolDecimal(r_HOLD_BUNDLED_PPS_COMPONENTS, 101, 9, 7, 2, false, 0, 0);
        hFullClaimAmt = new CobolDecimal(r_HOLD_BUNDLED_PPS_COMPONENTS, 110, 9, 7, 2, false, 0, 0);
        hLvBunAdjustBaseWageAmt = new CobolDecimal(r_HOLD_BUNDLED_PPS_COMPONENTS, 119, 11, 7, 4, false, 0, 0);
        hLvPpsFinalPayAmt = new CobolDecimal(r_HOLD_BUNDLED_PPS_COMPONENTS, 130, 11, 7, 4, false, 0, 0);
        hLvOutPredictServicesMap = new CobolDecimal(r_HOLD_BUNDLED_PPS_COMPONENTS, 141, 11, 7, 4, false, 0, 0);
        hLvOutCmAdjPredictMTrt = new CobolDecimal(r_HOLD_BUNDLED_PPS_COMPONENTS, 152, 11, 7, 4, false, 0, 0);
        hLvOutPredictedMap = new CobolDecimal(r_HOLD_BUNDLED_PPS_COMPONENTS, 163, 11, 7, 4, false, 0, 0);
        hLvOutPayment = new CobolDecimal(r_HOLD_BUNDLED_PPS_COMPONENTS, 174, 11, 7, 4, false, 0, 0);
        hComorbidMultiplier = new CobolDecimal(r_HOLD_BUNDLED_PPS_COMPONENTS, 185, 4, 1, 3, false, 0, 0);
        isHighComorbidFound = new CobolText(r_HOLD_BUNDLED_PPS_COMPONENTS, 189, 1);
        hComorbidData = CobolText.table(r_HOLD_BUNDLED_PPS_COMPONENTS, 190, 2, 6, 2);
        hComorbidCwfCode = new CobolText(r_HOLD_BUNDLED_PPS_COMPONENTS, 202, 2);
        hBunLowVolMultiplier = new CobolDecimal(r_HOLD_BUNDLED_PPS_COMPONENTS, 204, 4, 1, 3, false, 0, 0);
        qipReduction = new CobolDecimal(r_HOLD_BUNDLED_PPS_COMPONENTS, 208, 4, 1, 3, false, 0, 0);
        sub = new CobolDecimal(r_HOLD_BUNDLED_PPS_COMPONENTS, 212, 4, 4, 0, false, 0, 0);
        theDate = new CobolDecimal(r_HOLD_BUNDLED_PPS_COMPONENTS, 216, 8, 8, 0, false, 0, 0);
        integerLineItemDate = new CobolDecimal(r_HOLD_BUNDLED_PPS_COMPONENTS, 224, 9, 9, 0, true, 0, 0);
        integerDialysisDate = new CobolDecimal(r_HOLD_BUNDLED_PPS_COMPONENTS, 233, 9, 9, 0, true, 0, 0);
        onsetDate = new CobolDecimal(r_HOLD_BUNDLED_PPS_COMPONENTS, 242, 8, 8, 0, false, 0, 0);
        movedCormorbids = new CobolText(r_HOLD_BUNDLED_PPS_COMPONENTS, 250, 1);
        hBunRuralMultiplier = new CobolDecimal(r_HOLD_BUNDLED_PPS_COMPONENTS, 251, 4, 1, 3, false, 0, 0);
        hTdapaPayment = new CobolDecimal(r_HOLD_BUNDLED_PPS_COMPONENTS, 255, 11, 7, 4, false, 0, 0);
        hTpniesPayment = new CobolDecimal(r_HOLD_BUNDLED_PPS_COMPONENTS, 266, 11, 7, 4, false, 0, 0);
        hNetworkReduction = new CobolDecimal(r_HOLD_BUNDLED_PPS_COMPONENTS, 277, 3, 1, 2, false, 0, 0);
        hPerDiemAmtWithoutHdpa = new CobolDecimal(r_HOLD_BUNDLED_PPS_COMPONENTS, 280, 11, 7, 4, false, 0, 0);
        hPerDiemAmtWithHdpa = new CobolDecimal(r_HOLD_BUNDLED_PPS_COMPONENTS, 291, 11, 7, 4, false, 0, 0);
        hFinalAmtWithoutHdpa = new CobolDecimal(r_HOLD_BUNDLED_PPS_COMPONENTS, 302, 9, 7, 2, false, 0, 0);
        hFinalAmtWithHdpa = new CobolDecimal(r_HOLD_BUNDLED_PPS_COMPONENTS, 311, 9, 7, 2, false, 0, 0);
        hOutAgeFactor = new CobolDecimal(r_HOLD_OUTLIER_PPS_COMPONENTS, 0, 4, 1, 3, false, 0, 0);
        hOutBsa = new CobolDecimal(r_HOLD_OUTLIER_PPS_COMPONENTS, 4, 7, 3, 4, false, 0, 0);
        hOutBsaFactor = new CobolDecimal(r_HOLD_OUTLIER_PPS_COMPONENTS, 11, 5, 1, 4, false, 0, 0);
        hOutBmi = new CobolDecimal(r_HOLD_OUTLIER_PPS_COMPONENTS, 16, 7, 3, 4, false, 0, 0);
        hOutBmiFactor = new CobolDecimal(r_HOLD_OUTLIER_PPS_COMPONENTS, 23, 5, 1, 4, false, 0, 0);
        hOutOnsetFactor = new CobolDecimal(r_HOLD_OUTLIER_PPS_COMPONENTS, 28, 5, 1, 4, false, 0, 0);
        hOutComorbidMultiplier = new CobolDecimal(r_HOLD_OUTLIER_PPS_COMPONENTS, 33, 4, 1, 3, false, 0, 0);
        hOutLowVolMultiplier = new CobolDecimal(r_HOLD_OUTLIER_PPS_COMPONENTS, 37, 4, 1, 3, false, 0, 0);
        hOutAdjAvgMapAmt = new CobolDecimal(r_HOLD_OUTLIER_PPS_COMPONENTS, 41, 5, 3, 2, false, 0, 0);
        hOutFixDollarLoss = new CobolDecimal(r_HOLD_OUTLIER_PPS_COMPONENTS, 46, 6, 4, 2, false, 0, 0);
        hOutLossSharingPct = new CobolDecimal(r_HOLD_OUTLIER_PPS_COMPONENTS, 52, 3, 1, 2, false, 0, 0);
        hOutPredictedServicesMap = new CobolDecimal(r_HOLD_OUTLIER_PPS_COMPONENTS, 55, 11, 7, 4, false, 0, 0);
        hOutImputedMap = new CobolDecimal(r_HOLD_OUTLIER_PPS_COMPONENTS, 66, 11, 7, 4, false, 0, 0);
        hOutCmAdjPredictMapTrt = new CobolDecimal(r_HOLD_OUTLIER_PPS_COMPONENTS, 77, 11, 7, 4, false, 0, 0);
        hOutPredictedMap = new CobolDecimal(r_HOLD_OUTLIER_PPS_COMPONENTS, 88, 11, 7, 4, false, 0, 0);
        hOutPayment = new CobolDecimal(r_HOLD_OUTLIER_PPS_COMPONENTS, 99, 11, 7, 4, false, 0, 0);
        hOutHemoEquivPayment = new CobolDecimal(r_HOLD_OUTLIER_PPS_COMPONENTS, 110, 11, 7, 4, false, 0, 0);
        hOutRuralMultiplier = new CobolDecimal(r_HOLD_OUTLIER_PPS_COMPONENTS, 121, 4, 1, 3, false, 0, 0);
        bundledBasePmtRate = new CobolDecimal(r_BUNDLED_BASE_PMT_RATE, 0, 6, 4, 2, false, 0, 0);
        comCbsaBlendPct = new CobolDecimal(r_COM_CBSA_BLEND_PCT, 0, 3, 1, 2, false, 0, 0);
        bunCbsaBlendPct = new CobolDecimal(r_BUN_CBSA_BLEND_PCT, 0, 3, 1, 2, false, 0, 0);
        waiveCbsaBlendPct = new CobolDecimal(r_WAIVE_CBSA_BLEND_PCT, 0, 3, 1, 2, false, 0, 0);
        bunNatLaborPct = new CobolDecimal(r_BUN_NAT_LABOR_PCT, 0, 6, 1, 5, false, 0, 0);
        bunNatNonlaborPct = new CobolDecimal(r_BUN_NAT_NONLABOR_PCT, 0, 6, 1, 5, false, 0, 0);
        trainingAddOnPmtAmt = new CobolDecimal(r_TRAINING_ADD_ON_PMT_AMT, 0, 4, 2, 2, false, 0, 0);
        transitionBdgtNeutFactor = new CobolDecimal(r_TRANSITION_BDGT_NEUT_FACTOR, 0, 5, 1, 4, false, 0, 0);
        bsaNationalAverage = new CobolDecimal(r_BSA_NATIONAL_AVERAGE, 0, 3, 1, 2, false, 0, 0);
        sbAgeLt13PdMode = new CobolDecimal(r_PEDIATRIC_MULTIPLIERS, 0, 4, 1, 3, false, 0, 0);
        sbAgeLt13HemoMode = new CobolDecimal(r_PEDIATRIC_MULTIPLIERS, 4, 4, 1, 3, false, 0, 0);
        sbAge1317PdMode = new CobolDecimal(r_PEDIATRIC_MULTIPLIERS, 8, 4, 1, 3, false, 0, 0);
        sbAge1317HemoMode = new CobolDecimal(r_PEDIATRIC_MULTIPLIERS, 12, 4, 1, 3, false, 0, 0);
        ebAgeLt13PdMode = new CobolDecimal(r_PEDIATRIC_MULTIPLIERS, 16, 4, 1, 3, false, 0, 0);
        ebAgeLt13HemoMode = new CobolDecimal(r_PEDIATRIC_MULTIPLIERS, 20, 4, 1, 3, false, 0, 0);
        ebAge1317PdMode = new CobolDecimal(r_PEDIATRIC_MULTIPLIERS, 24, 4, 1, 3, false, 0, 0);
        ebAge1317HemoMode = new CobolDecimal(r_PEDIATRIC_MULTIPLIERS, 28, 4, 1, 3, false, 0, 0);
        sbAge1844 = new CobolDecimal(r_ADULT_MULTIPLIERS, 0, 4, 1, 3, false, 0, 0);
        sbAge4559 = new CobolDecimal(r_ADULT_MULTIPLIERS, 4, 4, 1, 3, false, 0, 0);
        sbAge6069 = new CobolDecimal(r_ADULT_MULTIPLIERS, 8, 4, 1, 3, false, 0, 0);
        sbAge7079 = new CobolDecimal(r_ADULT_MULTIPLIERS, 12, 4, 1, 3, false, 0, 0);
        sbAge80Plus = new CobolDecimal(r_ADULT_MULTIPLIERS, 16, 4, 1, 3, false, 0, 0);
        sbBsa = new CobolDecimal(r_ADULT_MULTIPLIERS, 20, 4, 1, 3, false, 0, 0);
        sbBmiLt185 = new CobolDecimal(r_ADULT_MULTIPLIERS, 24, 4, 1, 3, false, 0, 0);
        sbOnsetLe120 = new CobolDecimal(r_ADULT_MULTIPLIERS, 28, 4, 1, 3, false, 0, 0);
        sbPericarditis = new CobolDecimal(r_ADULT_MULTIPLIERS, 32, 4, 1, 3, false, 0, 0);
        sbGiBleed = new CobolDecimal(r_ADULT_MULTIPLIERS, 36, 4, 1, 3, false, 0, 0);
        sbSickelCell = new CobolDecimal(r_ADULT_MULTIPLIERS, 40, 4, 1, 3, false, 0, 0);
        sbMyelodysplastic = new CobolDecimal(r_ADULT_MULTIPLIERS, 44, 4, 1, 3, false, 0, 0);
        sbLowVolAdjLt4000 = new CobolDecimal(r_ADULT_MULTIPLIERS, 48, 4, 1, 3, false, 0, 0);
        sbRural = new CobolDecimal(r_ADULT_MULTIPLIERS, 52, 4, 1, 3, false, 0, 0);
        cmAge1844 = new CobolDecimal(r_ADULT_MULTIPLIERS, 56, 4, 1, 3, false, 0, 0);
        cmAge4559 = new CobolDecimal(r_ADULT_MULTIPLIERS, 60, 4, 1, 3, false, 0, 0);
        cmAge6069 = new CobolDecimal(r_ADULT_MULTIPLIERS, 64, 4, 1, 3, false, 0, 0);
        cmAge7079 = new CobolDecimal(r_ADULT_MULTIPLIERS, 68, 4, 1, 3, false, 0, 0);
        cmAge80Plus = new CobolDecimal(r_ADULT_MULTIPLIERS, 72, 4, 1, 3, false, 0, 0);
        cmBsa = new CobolDecimal(r_ADULT_MULTIPLIERS, 76, 4, 1, 3, false, 0, 0);
        cmBmiLt185 = new CobolDecimal(r_ADULT_MULTIPLIERS, 80, 4, 1, 3, false, 0, 0);
        cmOnsetLe120 = new CobolDecimal(r_ADULT_MULTIPLIERS, 84, 4, 1, 3, false, 0, 0);
        cmPericarditis = new CobolDecimal(r_ADULT_MULTIPLIERS, 88, 4, 1, 3, false, 0, 0);
        cmGiBleed = new CobolDecimal(r_ADULT_MULTIPLIERS, 92, 4, 1, 3, false, 0, 0);
        cmSickelCell = new CobolDecimal(r_ADULT_MULTIPLIERS, 96, 4, 1, 3, false, 0, 0);
        cmMyelodysplastic = new CobolDecimal(r_ADULT_MULTIPLIERS, 100, 4, 1, 3, false, 0, 0);
        cmLowVolAdjLt4000 = new CobolDecimal(r_ADULT_MULTIPLIERS, 104, 4, 1, 3, false, 0, 0);
        cmRural = new CobolDecimal(r_ADULT_MULTIPLIERS, 108, 4, 1, 3, false, 0, 0);
        adjAvgMapAmtLt18 = new CobolDecimal(r_OUTLIER_SB_CALC_AMOUNTS, 0, 6, 4, 2, false, 0, 0);
        adjAvgMapAmtGt17 = new CobolDecimal(r_OUTLIER_SB_CALC_AMOUNTS, 6, 6, 4, 2, false, 0, 0);
        fixDollarLossLt18 = new CobolDecimal(r_OUTLIER_SB_CALC_AMOUNTS, 12, 6, 4, 2, false, 0, 0);
        fixDollarLossGt17 = new CobolDecimal(r_OUTLIER_SB_CALC_AMOUNTS, 18, 6, 4, 2, false, 0, 0);
        lossSharingPctLt18 = new CobolDecimal(r_OUTLIER_SB_CALC_AMOUNTS, 24, 5, 3, 2, false, 0, 0);
        lossSharingPctGt17 = new CobolDecimal(r_OUTLIER_SB_CALC_AMOUNTS, 29, 5, 3, 2, false, 0, 0);
        outlierTrack = new CobolText(r_PAID_RETURN_CODE_TRACKERS, 0, 1);
        acuteComorbidTrack = new CobolText(r_PAID_RETURN_CODE_TRACKERS, 1, 1);
        chronicComorbidTrack = new CobolText(r_PAID_RETURN_CODE_TRACKERS, 2, 1);
        onsetTrack = new CobolText(r_PAID_RETURN_CODE_TRACKERS, 3, 1);
        lowVolumeTrack = new CobolText(r_PAID_RETURN_CODE_TRACKERS, 4, 1);
        trainingTrack = new CobolText(r_PAID_RETURN_CODE_TRACKERS, 5, 1);
        pediatricTrack = new CobolText(r_PAID_RETURN_CODE_TRACKERS, 6, 1);
        lowBmiTrack = new CobolText(r_PAID_RETURN_CODE_TRACKERS, 7, 1);
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
        holdCompRatePpsComponents = new CobolText(r_HOLD_COMP_RATE_PPS_COMPONENTS, 0, 97);
        compositeRateMultipliers = new CobolText(r_COMPOSITE_RATE_MULTIPLIERS, 0, 32);
        holdBundledPpsComponents = new CobolText(r_HOLD_BUNDLED_PPS_COMPONENTS, 0, 320);
        holdOutlierPpsComponents = new CobolText(r_HOLD_OUTLIER_PPS_COMPONENTS, 0, 125);
        pediatricMultipliers = new CobolText(r_PEDIATRIC_MULTIPLIERS, 0, 32);
        pedSepBillPayMulti = new CobolText(r_PEDIATRIC_MULTIPLIERS, 0, 16);
        pedExpandBundlePayMulti = new CobolText(r_PEDIATRIC_MULTIPLIERS, 16, 16);
        adultMultipliers = new CobolText(r_ADULT_MULTIPLIERS, 0, 112);
        sepBillablePaymantMulti = new CobolText(r_ADULT_MULTIPLIERS, 0, 56);
        caseMixPaymentMulti = new CobolText(r_ADULT_MULTIPLIERS, 56, 56);
        outlierSbCalcAmounts = new CobolText(r_OUTLIER_SB_CALC_AMOUNTS, 0, 34);
        paidReturnCodeTrackers = new CobolText(r_PAID_RETURN_CODE_TRACKERS, 0, 8);
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

    public Escal212() {
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
    private int hComorbidIndex = 1;   // H-COMORBID-INDEX, of H-COMORBID-DATA
    private int comorbidIndex = 1;   // COMORBID-INDEX, of COMORBID-DATA

    public void run() {
        try {
            cocoonPerform(0, 10);
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
            if (p >= 11) {
                throw COCOON_STOP;   // the end of the program
            }
        }
    }

    private void cocoonParagraph(int p) {
        switch (p) {
            case 0: p0000StartToFinish(); return;   // 0000-START-TO-FINISH
            case 1: p1000ValidateBillElements(); return;   // 1000-VALIDATE-BILL-ELEMENTS
            case 2: p1200Initialization(); return;   // 1200-INITIALIZATION
            case 3: p2000CalculateBundledFactors(); return;   // 2000-CALCULATE-BUNDLED-FACTORS
            case 4: p2100CalcComorbidAdjust(); return;   // 2100-CALC-COMORBID-ADJUST
            case 5: p2500CalcOutlierFactors(); return;   // 2500-CALC-OUTLIER-FACTORS
            case 6: p2600CalcComorbidOutAdjust(); return;   // 2600-CALC-COMORBID-OUT-ADJUST
            case 7: p3000LowVolFullPpsPayment(); return;   // 3000-LOW-VOL-FULL-PPS-PAYMENT
            case 8: p3100LowVolOutPpsPayment(); return;   // 3100-LOW-VOL-OUT-PPS-PAYMENT
            case 9: p9000SetReturnCode(); return;   // 9000-SET-RETURN-CODE
            case 10: p9100MoveResults(); return;   // 9100-MOVE-RESULTS
            default: throw COCOON_STOP;
        }
    }

    /** 0000-START-TO-FINISH */
    private void p0000StartToFinish() {
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
        pProvWaiveBlendPayIndic.store("Y");
        if (bundledTestIndic.value().compareTo("T") == 0) {
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
            filler.store(" ");
            amtIndic.store(" ");
            filler.store(" ");
            bloodDollar.store(BigDecimal.ZERO);
            filler.store(" ");
        }
        ppsCalcVersCd.store(calVersion.value());
        ppsRtc.store(BigDecimal.ZERO);
        p1000ValidateBillElements();
        if (ppsRtc.value().compareTo(new BigDecimal("00")) == 0) {
            p1200Initialization();
            if (bCondCode.value().compareTo("84") == 0) {
                hPpsFinalPayAmt.store(hBunBaseWageAmt.value());
                // TRUNCATES: H-BUN-BASE-WAGE-AMT holds 4+4 digits, H-PPS-FINAL-PAY-AMT holds 7+2. The original loses the excess here; so does this.
                ppsRtc.store("02");
                pps2011ComorbidPay.store("10");
            } else {
                p2000CalculateBundledFactors();
                p9000SetReturnCode();
            }
            p9100MoveResults();
        }
        cocoonStop();   // GOBACK
    }

    /** 1000-VALIDATE-BILL-ELEMENTS */
    private void p1000ValidateBillElements() {
        if (ppsRtc.value().compareTo(new BigDecimal("00")) == 0) {
            if (bCondCode.value().compareTo("73") != 0 && bCondCode.value().compareTo("74") != 0 && bCondCode.value().compareTo("84") != 0 && bCondCode.value().compareTo("87") != 0 && bCondCode.value().compareTo("  ") != 0) {
                ppsRtc.store(new BigDecimal("58"));
            }
        }
        if (ppsRtc.value().compareTo(new BigDecimal("00")) == 0) {
            if (pProvType.value().compareTo("40") == 0 || pProvType.value().compareTo("41") == 0 || pProvType.value().compareTo("05") == 0) {
            } else {
                ppsRtc.store(new BigDecimal("52"));
            }
        }
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
            if (bCondCode.value().compareTo("84") != 0) {
                if (bPatientWgt.value().compareTo(new BigDecimal("0")) == 0 || !bPatientWgt.isNumeric()) {
                    ppsRtc.store(new BigDecimal("55"));
                }
            }
        }
        if (ppsRtc.value().compareTo(new BigDecimal("00")) == 0) {
            if (bCondCode.value().compareTo("84") != 0) {
                if (bPatientHgt.value().compareTo(new BigDecimal("0")) == 0 || !bPatientHgt.isNumeric()) {
                    ppsRtc.store(new BigDecimal("56"));
                }
            }
        }
        if (ppsRtc.value().compareTo(new BigDecimal("00")) == 0) {
            if (bRevCode.value().compareTo("0821") == 0 || bRevCode.value().compareTo("0831") == 0 || bRevCode.value().compareTo("0841") == 0 || bRevCode.value().compareTo("0851") == 0 || bRevCode.value().compareTo("0881") == 0) {
            } else {
                ppsRtc.store(new BigDecimal("57"));
            }
        }
        if (ppsRtc.value().compareTo(new BigDecimal("00")) == 0) {
            if (pQipReduction.value().compareTo("1") != 0 && pQipReduction.value().compareTo("2") != 0 && pQipReduction.value().compareTo("3") != 0 && pQipReduction.value().compareTo("4") != 0 && pQipReduction.value().compareTo(" ") != 0) {
                ppsRtc.store(new BigDecimal("53"));
            }
        }
        if (ppsRtc.value().compareTo(new BigDecimal("00")) == 0) {
            if (bCondCode.value().compareTo("84") != 0) {
                if (bPatientHgt.value().compareTo(new BigDecimal("300.00")) > 0) {
                    ppsRtc.store(new BigDecimal("71"));
                }
            }
        }
        if (ppsRtc.value().compareTo(new BigDecimal("00")) == 0) {
            if (bCondCode.value().compareTo("84") != 0) {
                if (bPatientWgt.value().compareTo(new BigDecimal("500.00")) > 0) {
                    ppsRtc.store(new BigDecimal("72"));
                }
            }
        }
        if (ppsRtc.value().compareTo(new BigDecimal("00")) == 0) {
            if (bClaimNumDialysisSessions.value().compareTo(BigDecimal.ZERO) == 0 || !bClaimNumDialysisSessions.isNumeric()) {
                ppsRtc.store(new BigDecimal("73"));
            }
        }
        if (ppsRtc.value().compareTo(new BigDecimal("00")) == 0) {
            if (CobolText.compareAlnum(bLineItemDateService.value(), "00000000") == 0 || !bLineItemDateService.isNumeric()) {
                ppsRtc.store(new BigDecimal("74"));
            }
        }
        if (ppsRtc.value().compareTo(new BigDecimal("00")) == 0) {
            if (!bDialysisStartDate.isNumeric()) {
                ppsRtc.store(new BigDecimal("75"));
            }
        }
        if (ppsRtc.value().compareTo(new BigDecimal("00")) == 0) {
            if (!bTotPriceSbOutlier.isNumeric()) {
                ppsRtc.store(new BigDecimal("76"));
            }
        }
        if (ppsRtc.value().compareTo(new BigDecimal("00")) == 0) {
            if (bCondCode.value().compareTo("84") != 0) {
                if (CobolText.compareAlnum(comorbidCwfReturnCode.value(), "  ") == 0 || comorbidCwfReturnCode.value().compareTo("10") == 0 || comorbidCwfReturnCode.value().compareTo("20") == 0 || comorbidCwfReturnCode.value().compareTo("40") == 0 || comorbidCwfReturnCode.value().compareTo("50") == 0 || comorbidCwfReturnCode.value().compareTo("60") == 0) {
                } else {
                    ppsRtc.store(new BigDecimal("81"));
                }
            }
        }
    }

    /** 1200-INITIALIZATION */
    private void p1200Initialization() {
        hPaymentRate.store(BigDecimal.ZERO);
        hPymtAmt.store(BigDecimal.ZERO);
        hWageAdjPymtAmt.store(BigDecimal.ZERO);
        hPatientAge.store(BigDecimal.ZERO);
        hAgeFactor.store(BigDecimal.ZERO);
        hBsaFactor.store(BigDecimal.ZERO);
        hBmiFactor.store(BigDecimal.ZERO);
        hBsa.store(BigDecimal.ZERO);
        hBmi.store(BigDecimal.ZERO);
        hgtPart.store(BigDecimal.ZERO);
        wgtPart.store(BigDecimal.ZERO);
        combinedPart.store(BigDecimal.ZERO);
        calcBsa.store(BigDecimal.ZERO);
        hBunNatLaborAmt.store(BigDecimal.ZERO);
        hBunNatNonlaborAmt.store(BigDecimal.ZERO);
        hBunBaseWageAmt.store(BigDecimal.ZERO);
        hBunAgeFactor.store(BigDecimal.ZERO);
        hBunBsa.store(BigDecimal.ZERO);
        hBunBsaFactor.store(BigDecimal.ZERO);
        hBunBmi.store(BigDecimal.ZERO);
        hBunBmiFactor.store(BigDecimal.ZERO);
        hBunOnsetFactor.store(BigDecimal.ZERO);
        hBunComorbidMultiplier.store(BigDecimal.ZERO);
        hBunAdjustedBaseWageAmt.store(BigDecimal.ZERO);
        hBunWageAdjTrainingAmt.store(BigDecimal.ZERO);
        hCc74PerDiemAmt.store(BigDecimal.ZERO);
        hHemoEquivDialSessions.store(BigDecimal.ZERO);
        hPpsFinalPayAmt.store(BigDecimal.ZERO);
        hFullClaimAmt.store(BigDecimal.ZERO);
        hLvBunAdjustBaseWageAmt.store(BigDecimal.ZERO);
        hLvPpsFinalPayAmt.store(BigDecimal.ZERO);
        hLvOutPredictServicesMap.store(BigDecimal.ZERO);
        hLvOutCmAdjPredictMTrt.store(BigDecimal.ZERO);
        hLvOutPredictedMap.store(BigDecimal.ZERO);
        hLvOutPayment.store(BigDecimal.ZERO);
        hComorbidMultiplier.store(BigDecimal.ZERO);
        isHighComorbidFound.store(" ");
        for (CobolText cobolElement : hComorbidData) { cobolElement.store(" "); }
        hComorbidCwfCode.store(" ");
        hBunLowVolMultiplier.store(BigDecimal.ZERO);
        qipReduction.store(BigDecimal.ZERO);
        sub.store(BigDecimal.ZERO);
        theDate.store(BigDecimal.ZERO);
        integerLineItemDate.store(BigDecimal.ZERO);
        integerDialysisDate.store(BigDecimal.ZERO);
        onsetDate.store(BigDecimal.ZERO);
        movedCormorbids.store(" ");
        hBunRuralMultiplier.store(BigDecimal.ZERO);
        hTdapaPayment.store(BigDecimal.ZERO);
        hTpniesPayment.store(BigDecimal.ZERO);
        hNetworkReduction.store(BigDecimal.ZERO);
        hPerDiemAmtWithoutHdpa.store(BigDecimal.ZERO);
        hPerDiemAmtWithHdpa.store(BigDecimal.ZERO);
        hFinalAmtWithoutHdpa.store(BigDecimal.ZERO);
        hFinalAmtWithHdpa.store(BigDecimal.ZERO);
        hOutAgeFactor.store(BigDecimal.ZERO);
        hOutBsa.store(BigDecimal.ZERO);
        hOutBsaFactor.store(BigDecimal.ZERO);
        hOutBmi.store(BigDecimal.ZERO);
        hOutBmiFactor.store(BigDecimal.ZERO);
        hOutOnsetFactor.store(BigDecimal.ZERO);
        hOutComorbidMultiplier.store(BigDecimal.ZERO);
        hOutLowVolMultiplier.store(BigDecimal.ZERO);
        hOutAdjAvgMapAmt.store(BigDecimal.ZERO);
        hOutFixDollarLoss.store(BigDecimal.ZERO);
        hOutLossSharingPct.store(BigDecimal.ZERO);
        hOutPredictedServicesMap.store(BigDecimal.ZERO);
        hOutImputedMap.store(BigDecimal.ZERO);
        hOutCmAdjPredictMapTrt.store(BigDecimal.ZERO);
        hOutPredictedMap.store(BigDecimal.ZERO);
        hOutPayment.store(BigDecimal.ZERO);
        hOutHemoEquivPayment.store(BigDecimal.ZERO);
        hOutRuralMultiplier.store(BigDecimal.ZERO);
        outlierTrack.store(" ");
        acuteComorbidTrack.store(" ");
        chronicComorbidTrack.store(" ");
        onsetTrack.store(" ");
        lowVolumeTrack.store(" ");
        trainingTrack.store(" ");
        pediatricTrack.store(" ");
        lowBmiTrack.store(" ");
        hBunNatLaborAmt.storeRounded(bundledBasePmtRate.value().multiply(bunNatLaborPct.value()).multiply(bunCbsaWIndex.value()));
        // TRUNCATES: the expression produces up to 7 integer digits and H-BUN-NAT-LABOR-AMT holds 4. The high-order digits are lost, as in the original.
        hBunNatNonlaborAmt.storeRounded(bundledBasePmtRate.value().multiply(bunNatNonlaborPct.value()));
        // TRUNCATES: the expression produces up to 5 integer digits and H-BUN-NAT-NONLABOR-AMT holds 4. The high-order digits are lost, as in the original.
        hBunBaseWageAmt.storeRounded(hBunNatLaborAmt.value().add(hBunNatNonlaborAmt.value()));
    }

    /** 2000-CALCULATE-BUNDLED-FACTORS */
    private void p2000CalculateBundledFactors() {
        hPatientAge.store(bThruCcyy.value().subtract(bDobCcyy.value()));
        // TRUNCATES: the expression produces up to 4 integer digits and H-PATIENT-AGE holds 3. The high-order digits are lost, as in the original.
        if (bDobMm.value().compareTo(bThruMm.value()) > 0) {
            hPatientAge.store(hPatientAge.value().subtract(new BigDecimal("1")));
        }
        if (hPatientAge.value().compareTo(new BigDecimal("18")) < 0) {
            pediatricTrack.store("Y");
        }
        movedCormorbids.store(" ");
        if (pQipReduction.value().compareTo(" ") == 0) {
            qipReduction.store(new BigDecimal("1.000"));
        } else {
            if (pQipReduction.value().compareTo("1") == 0) {
                qipReduction.store(new BigDecimal("0.995"));
            } else {
                if (pQipReduction.value().compareTo("2") == 0) {
                    qipReduction.store(new BigDecimal("0.990"));
                } else {
                    if (pQipReduction.value().compareTo("3") == 0) {
                        qipReduction.store(new BigDecimal("0.985"));
                    } else {
                        qipReduction.store(new BigDecimal("0.980"));
                    }
                }
            }
        }
        if (CobolText.compareAlnum(comorbidCwfReturnCode.value(), "  ") == 0) {
        } else {
            movedCormorbids.store("Y");
            hComorbidData[0].store(comorbidData[0].value());
            hComorbidData[1].store(comorbidData[1].value());
            hComorbidData[2].store(comorbidData[2].value());
            hComorbidData[3].store(comorbidData[3].value());
            hComorbidData[4].store(comorbidData[4].value());
            hComorbidData[5].store(comorbidData[5].value());
            hComorbidCwfCode.store(comorbidCwfReturnCode.value());
            if (comorbidCwfReturnCode.value().compareTo("10") == 0) {
                comorbidData[0].store(" ");
                comorbidData[1].store(" ");
                comorbidData[2].store(" ");
                comorbidData[3].store(" ");
                comorbidData[4].store(" ");
                comorbidData[5].store(" ");
                comorbidCwfReturnCode.store(" ");
            } else {
                if (comorbidCwfReturnCode.value().compareTo("20") == 0) {
                    comorbidData[0].store("MA");
                    comorbidData[1].store(" ");
                    comorbidData[2].store(" ");
                    comorbidData[3].store(" ");
                    comorbidData[4].store(" ");
                    comorbidData[5].store(" ");
                    comorbidCwfReturnCode.store(" ");
                } else {
                    if (comorbidCwfReturnCode.value().compareTo("40") == 0) {
                        comorbidData[0].store(" ");
                        comorbidData[1].store(" ");
                        comorbidData[2].store("MC");
                        comorbidData[3].store(" ");
                        comorbidData[4].store(" ");
                        comorbidData[5].store(" ");
                        comorbidCwfReturnCode.store(" ");
                    } else {
                        if (comorbidCwfReturnCode.value().compareTo("50") == 0) {
                            comorbidData[0].store(" ");
                            comorbidData[1].store(" ");
                            comorbidData[2].store(" ");
                            comorbidData[3].store("MD");
                            comorbidData[4].store(" ");
                            comorbidData[5].store(" ");
                            comorbidCwfReturnCode.store(" ");
                        } else {
                            if (comorbidCwfReturnCode.value().compareTo("60") == 0) {
                                comorbidData[0].store(" ");
                                comorbidData[1].store(" ");
                                comorbidData[2].store(" ");
                                comorbidData[3].store(" ");
                                comorbidData[4].store("ME");
                                comorbidData[5].store(" ");
                                comorbidCwfReturnCode.store(" ");
                            }
                        }
                    }
                }
            }
        }
        if (hPatientAge.value().compareTo(new BigDecimal("13")) < 0) {
            if (bRevCode.value().compareTo("0821") == 0 || bRevCode.value().compareTo("0881") == 0) {
                hBunAgeFactor.store(ebAgeLt13HemoMode.value());
            } else {
                hBunAgeFactor.store(ebAgeLt13PdMode.value());
            }
        } else {
            if (hPatientAge.value().compareTo(new BigDecimal("18")) < 0) {
                if (bRevCode.value().compareTo("0821") == 0 || bRevCode.value().compareTo("0881") == 0) {
                    hBunAgeFactor.store(ebAge1317HemoMode.value());
                } else {
                    hBunAgeFactor.store(ebAge1317PdMode.value());
                }
            } else {
                if (hPatientAge.value().compareTo(new BigDecimal("45")) < 0) {
                    hBunAgeFactor.store(cmAge1844.value());
                } else {
                    if (hPatientAge.value().compareTo(new BigDecimal("60")) < 0) {
                        hBunAgeFactor.store(cmAge4559.value());
                    } else {
                        if (hPatientAge.value().compareTo(new BigDecimal("70")) < 0) {
                            hBunAgeFactor.store(cmAge6069.value());
                        } else {
                            if (hPatientAge.value().compareTo(new BigDecimal("80")) < 0) {
                                hBunAgeFactor.store(cmAge7079.value());
                            } else {
                                hBunAgeFactor.store(cmAge80Plus.value());
                            }
                        }
                    }
                }
            }
        }
        hBunBsa.storeRounded(new BigDecimal(".007184").multiply(CobolDecimal.pow(bPatientHgt.value(), new BigDecimal(".725"))).multiply(CobolDecimal.pow(bPatientWgt.value(), new BigDecimal(".425"))));
        // TRUNCATES: the expression produces up to 14 integer digits and H-BUN-BSA holds 3. The high-order digits are lost, as in the original.
        if (hPatientAge.value().compareTo(new BigDecimal("17")) > 0) {
            try {   // a zero divisor stores nothing, as in COBOL
                hBunBsaFactor.storeRounded(CobolDecimal.pow(cmBsa.value(), CobolDecimal.divide(hBunBsa.value().subtract(bsaNationalAverage.value()), new BigDecimal(".1"))));
                // TRUNCATES: the expression produces up to 3 integer digits and H-BUN-BSA-FACTOR holds 1. The high-order digits are lost, as in the original.
            } catch (CobolDecimal.ZeroDivide cocoonZeroDivide) {
                // every receiver keeps what it held
            }
        } else {
            hBunBsaFactor.store(new BigDecimal("1.000"));
        }
        try {   // a zero divisor stores nothing, as in COBOL
            hBunBmi.storeRounded(CobolDecimal.divide(bPatientWgt.value(), CobolDecimal.pow(bPatientHgt.value(), new BigDecimal("2"))).multiply(new BigDecimal("10000")));
            // TRUNCATES: the expression produces up to 7 integer digits and H-BUN-BMI holds 3. The high-order digits are lost, as in the original.
        } catch (CobolDecimal.ZeroDivide cocoonZeroDivide) {
            // every receiver keeps what it held
        }
        if (hPatientAge.value().compareTo(new BigDecimal("17")) > 0 && hBunBmi.value().compareTo(new BigDecimal("18.5")) < 0) {
            hBunBmiFactor.store(cmBmiLt185.value());
            lowBmiTrack.store("Y");
        } else {
            hBunBmiFactor.store(new BigDecimal("1.000"));
        }
        if (CobolText.compareAlnum(bDialysisStartDate.value(), "00000000") > 0) {
            theDate.store(bLineItemDateService.value());
            integerLineItemDate.store(CobolDecimal.integerOfDate(theDate.value()));
            theDate.store(bDialysisStartDate.value());
            integerDialysisDate.store(CobolDecimal.integerOfDate(theDate.value()));
            onsetDate.store(integerLineItemDate.value().subtract(integerDialysisDate.value()).add(new BigDecimal("1")));
            // TRUNCATES: the expression produces up to 9 integer digits and ONSET-DATE holds 8. The high-order digits are lost, as in the original.
            if (hPatientAge.value().compareTo(new BigDecimal("17")) > 0) {
                if (onsetDate.value().compareTo(new BigDecimal("120")) > 0) {
                    hBunOnsetFactor.store(new BigDecimal("1"));
                } else {
                    hBunOnsetFactor.store(cmOnsetLe120.value());
                    onsetTrack.store("Y");
                }
            } else {
                hBunOnsetFactor.store(new BigDecimal("1"));
            }
        } else {
            hBunOnsetFactor.store(new BigDecimal("1.000"));
        }
        if (CobolText.compareAlnum(comorbidCwfReturnCode.value(), "  ") == 0) {
            if (hPatientAge.value().compareTo(new BigDecimal("18")) < 0) {
                hBunComorbidMultiplier.store(new BigDecimal("1.000"));
                pps2011ComorbidPay.store("10");
            } else {
                if (hBunOnsetFactor.value().compareTo(cmOnsetLe120.value()) == 0) {
                    hBunComorbidMultiplier.store(new BigDecimal("1.000"));
                    pps2011ComorbidPay.store("10");
                } else {
                    p2100CalcComorbidAdjust();
                    hBunComorbidMultiplier.store(hComorbidMultiplier.value());
                }
            }
        } else {
            if (comorbidCwfReturnCode.value().compareTo("10") == 0) {
                hBunComorbidMultiplier.store(new BigDecimal("1.000"));
                pps2011ComorbidPay.store("10");
            } else {
                if (comorbidCwfReturnCode.value().compareTo("20") == 0) {
                    hBunComorbidMultiplier.store(cmGiBleed.value());
                    pps2011ComorbidPay.store("20");
                } else {
                    if (comorbidCwfReturnCode.value().compareTo("40") == 0) {
                        hBunComorbidMultiplier.store(cmPericarditis.value());
                        pps2011ComorbidPay.store("40");
                    }
                }
            }
        }
        if (pProvLowVolumeIndic.value().compareTo("Y") == 0) {
            if (hPatientAge.value().compareTo(new BigDecimal("17")) > 0) {
                hBunLowVolMultiplier.store(cmLowVolAdjLt4000.value());
                lowVolumeTrack.store("Y");
            } else {
                hBunLowVolMultiplier.store(new BigDecimal("1.000"));
            }
        } else {
            hBunLowVolMultiplier.store(new BigDecimal("1.000"));
        }
        if (CobolText.compareAlnum(pGeoCbsa.value(), "100") < 0 && hPatientAge.value().compareTo(new BigDecimal("17")) > 0) {
            hBunRuralMultiplier.store(cmRural.value());
        } else {
            hBunRuralMultiplier.store(new BigDecimal("1.000"));
        }
        hBunAdjustedBaseWageAmt.storeRounded(hBunBaseWageAmt.value().multiply(hBunAgeFactor.value()).multiply(hBunBsaFactor.value().multiply(hBunBmiFactor.value())).multiply(hBunOnsetFactor.value().multiply(hBunComorbidMultiplier.value())).multiply(hBunLowVolMultiplier.value()).multiply(hBunRuralMultiplier.value()));
        // TRUNCATES: the expression produces up to 11 integer digits and H-BUN-ADJUSTED-BASE-WAGE-AMT holds 7. The high-order digits are lost, as in the original.
        if (bCondCode.value().compareTo("73") == 0 || bCondCode.value().compareTo("87") == 0) {
            if (hBunOnsetFactor.value().compareTo(cmOnsetLe120.value()) == 0) {
                hBunWageAdjTrainingAmt.store(BigDecimal.ZERO);
            } else {
                hBunWageAdjTrainingAmt.storeRounded(trainingAddOnPmtAmt.value().multiply(bunCbsaWIndex.value()));
                trainingTrack.store("Y");
            }
        } else {
            if (bCondCode.value().compareTo("74") == 0 && (bRevCode.value().compareTo("0841") == 0 || bRevCode.value().compareTo("0851") == 0)) {
                try {   // a zero divisor stores nothing, as in COBOL
                    hPerDiemAmtWithoutHdpa.storeRounded(CobolDecimal.divide(hBunAdjustedBaseWageAmt.value().multiply(new BigDecimal("3")), new BigDecimal("7")));
                } catch (CobolDecimal.ZeroDivide cocoonZeroDivide) {
                    // every receiver keeps what it held
                }
                try {   // a zero divisor stores nothing, as in COBOL
                    hPerDiemAmtWithHdpa.storeRounded(CobolDecimal.divide(hBunAdjustedBaseWageAmt.value().multiply(new BigDecimal("3")), new BigDecimal("7")).multiply(etcHdpaPct.value()));
                    // TRUNCATES: the expression produces up to 8 integer digits and H-PER-DIEM-AMT-WITH-HDPA holds 7. The high-order digits are lost, as in the original.
                } catch (CobolDecimal.ZeroDivide cocoonZeroDivide) {
                    // every receiver keeps what it held
                }
            } else {
                hBunWageAdjTrainingAmt.store(BigDecimal.ZERO);
                hPerDiemAmtWithoutHdpa.store(BigDecimal.ZERO);
                hPerDiemAmtWithHdpa.store(BigDecimal.ZERO);
            }
        }
        if (bCondCode.value().compareTo("74") == 0 && (bRevCode.value().compareTo("0841") == 0 || bRevCode.value().compareTo("0851") == 0)) {
            hFinalAmtWithoutHdpa.storeRounded(hPerDiemAmtWithoutHdpa.value());
            hFinalAmtWithHdpa.storeRounded(hPerDiemAmtWithHdpa.value());
            try {   // a zero divisor stores nothing, as in COBOL
                hFullClaimAmt.storeRounded(CobolDecimal.divide(hBunAdjustedBaseWageAmt.value().multiply(bClaimNumDialysisSessions.value().multiply(new BigDecimal("3"))), new BigDecimal("7")));
                // TRUNCATES: the expression produces up to 9 integer digits and H-FULL-CLAIM-AMT holds 7. The high-order digits are lost, as in the original.
            } catch (CobolDecimal.ZeroDivide cocoonZeroDivide) {
                // every receiver keeps what it held
            }
        } else {
            hFinalAmtWithoutHdpa.storeRounded(hBunAdjustedBaseWageAmt.value().add(hBunWageAdjTrainingAmt.value()));
            hFinalAmtWithHdpa.storeRounded(hBunAdjustedBaseWageAmt.value().multiply(etcHdpaPct.value()).add(hBunWageAdjTrainingAmt.value()));
            // TRUNCATES: the expression produces up to 15 integer digits and H-FINAL-AMT-WITH-HDPA holds 7. The high-order digits are lost, as in the original.
        }
        try {   // a zero divisor stores nothing, as in COBOL
            hTdapaPayment.store(CobolDecimal.divide(bPayerOnlyVcQ8.value(), bClaimNumDialysisSessions.value()));
        } catch (CobolDecimal.ZeroDivide cocoonZeroDivide) {
            // every receiver keeps what it held
        }
        if (bPayerOnlyVcQgAmt.isNumeric()) {
            try {   // a zero divisor stores nothing, as in COBOL
                hTpniesPayment.store(CobolDecimal.divide(new BigDecimal("0.65").multiply(bPayerOnlyVcQgAmt.value()), bClaimNumDialysisSessions.value()));
                // TRUNCATES: the expression produces up to 9 integer digits and H-TPNIES-PAYMENT holds 7. The high-order digits are lost, as in the original.
            } catch (CobolDecimal.ZeroDivide cocoonZeroDivide) {
                // every receiver keeps what it held
            }
        }
        hFinalAmtWithoutHdpa.store(hFinalAmtWithoutHdpa.value().add(hTdapaPayment.value()).add(hTpniesPayment.value()));
        hFinalAmtWithHdpa.store(hFinalAmtWithHdpa.value().add(hTdapaPayment.value()).add(hTpniesPayment.value()));
        if (bDataCode.value().compareTo("94") == 0) {
            hPpsFinalPayAmt.store(hFinalAmtWithHdpa.value());
        } else {
            hPpsFinalPayAmt.store(hFinalAmtWithoutHdpa.value());
        }
        if (bCondCode.value().compareTo("74") == 0 && (bRevCode.value().compareTo("0841") == 0 || bRevCode.value().compareTo("0851") == 0)) {
            hNetworkReduction.store(new BigDecimal("0.21"));
        } else {
            hNetworkReduction.store(new BigDecimal("0.50"));
        }
        p2500CalcOutlierFactors();
        if (lowVolumeTrack.value().compareTo("Y") == 0) {
            p3000LowVolFullPpsPayment();
            p3100LowVolOutPpsPayment();
            hLvPpsFinalPayAmt.store(hLvPpsFinalPayAmt.value().subtract(hPpsFinalPayAmt.value()));
            hLvOutPayment.store(hLvOutPayment.value().subtract(hOutPayment.value()));
            hLvPpsFinalPayAmt.store(hLvPpsFinalPayAmt.value().add(hLvOutPayment.value()));
            if (pProvWaiveBlendPayIndic.value().compareTo("N") == 0) {
                ppsLowVolAmt.storeRounded(hLvPpsFinalPayAmt.value().multiply(bunCbsaBlendPct.value()));
                // TRUNCATES: the expression produces up to 8 integer digits and PPS-LOW-VOL-AMT holds 4. The high-order digits are lost, as in the original.
            } else {
                ppsLowVolAmt.store(hLvPpsFinalPayAmt.value());
                // TRUNCATES: H-LV-PPS-FINAL-PAY-AMT holds 7+4 digits, PPS-LOW-VOL-AMT holds 4+2. The original loses the excess here; so does this.
            }
        }
    }

    /** 2100-CALC-COMORBID-ADJUST */
    private void p2100CalcComorbidAdjust() {
        isHighComorbidFound.store("N");
        hComorbidMultiplier.store(new BigDecimal("1.000"));
        pps2011ComorbidPay.store("10");
        sub.store(new BigDecimal("1"));
        while (!(sub.value().compareTo(new BigDecimal("6")) > 0 || isHighComorbidFound.value().compareTo("Y") == 0)) {
            if (comorbidData[sub.value().intValue() - 1].value().compareTo("MA") == 0) {
                hComorbidMultiplier.store(cmGiBleed.value());
                acuteComorbidTrack.store("Y");
                pps2011ComorbidPay.store("20");
            } else {
                if (comorbidData[sub.value().intValue() - 1].value().compareTo("MC") == 0) {
                    if (cmPericarditis.value().compareTo(hComorbidMultiplier.value()) > 0) {
                        hComorbidMultiplier.store(cmPericarditis.value());
                        acuteComorbidTrack.store("Y");
                        pps2011ComorbidPay.store("40");
                    }
                } else {
                    if (comorbidData[sub.value().intValue() - 1].value().compareTo("MD") == 0) {
                        if (cmMyelodysplastic.value().compareTo(hComorbidMultiplier.value()) > 0) {
                            hComorbidMultiplier.store(cmMyelodysplastic.value());
                            chronicComorbidTrack.store("Y");
                            pps2011ComorbidPay.store("50");
                        }
                    } else {
                        if (comorbidData[sub.value().intValue() - 1].value().compareTo("ME") == 0) {
                            if (cmSickelCell.value().compareTo(hComorbidMultiplier.value()) > 0) {
                                hComorbidMultiplier.store(cmSickelCell.value());
                                chronicComorbidTrack.store("Y");
                                pps2011ComorbidPay.store("60");
                            }
                        }
                    }
                }
            }
            sub.store(sub.value().add(new BigDecimal("1")));
        }
    }

    /** 2500-CALC-OUTLIER-FACTORS */
    private void p2500CalcOutlierFactors() {
        if (hPatientAge.value().compareTo(new BigDecimal("13")) < 0) {
            if (bRevCode.value().compareTo("0821") == 0 || bRevCode.value().compareTo("0881") == 0) {
                hOutAgeFactor.store(sbAgeLt13HemoMode.value());
            } else {
                hOutAgeFactor.store(sbAgeLt13PdMode.value());
            }
        } else {
            if (hPatientAge.value().compareTo(new BigDecimal("18")) < 0) {
                if (bRevCode.value().compareTo("0821") == 0 || bRevCode.value().compareTo("0881") == 0) {
                    hOutAgeFactor.store(sbAge1317HemoMode.value());
                } else {
                    hOutAgeFactor.store(sbAge1317PdMode.value());
                }
            } else {
                if (hPatientAge.value().compareTo(new BigDecimal("45")) < 0) {
                    hOutAgeFactor.store(sbAge1844.value());
                } else {
                    if (hPatientAge.value().compareTo(new BigDecimal("60")) < 0) {
                        hOutAgeFactor.store(sbAge4559.value());
                    } else {
                        if (hPatientAge.value().compareTo(new BigDecimal("70")) < 0) {
                            hOutAgeFactor.store(sbAge6069.value());
                        } else {
                            if (hPatientAge.value().compareTo(new BigDecimal("80")) < 0) {
                                hOutAgeFactor.store(sbAge7079.value());
                            } else {
                                hOutAgeFactor.store(sbAge80Plus.value());
                            }
                        }
                    }
                }
            }
        }
        hOutBsa.storeRounded(new BigDecimal(".007184").multiply(CobolDecimal.pow(bPatientHgt.value(), new BigDecimal(".725"))).multiply(CobolDecimal.pow(bPatientWgt.value(), new BigDecimal(".425"))));
        // TRUNCATES: the expression produces up to 14 integer digits and H-OUT-BSA holds 3. The high-order digits are lost, as in the original.
        if (hPatientAge.value().compareTo(new BigDecimal("17")) > 0) {
            try {   // a zero divisor stores nothing, as in COBOL
                hOutBsaFactor.storeRounded(CobolDecimal.pow(sbBsa.value(), CobolDecimal.divide(hOutBsa.value().subtract(bsaNationalAverage.value()), new BigDecimal(".1"))));
                // TRUNCATES: the expression produces up to 3 integer digits and H-OUT-BSA-FACTOR holds 1. The high-order digits are lost, as in the original.
            } catch (CobolDecimal.ZeroDivide cocoonZeroDivide) {
                // every receiver keeps what it held
            }
        } else {
            hOutBsaFactor.store(new BigDecimal("1.000"));
        }
        try {   // a zero divisor stores nothing, as in COBOL
            hOutBmi.storeRounded(CobolDecimal.divide(bPatientWgt.value(), CobolDecimal.pow(bPatientHgt.value(), new BigDecimal("2"))).multiply(new BigDecimal("10000")));
            // TRUNCATES: the expression produces up to 7 integer digits and H-OUT-BMI holds 3. The high-order digits are lost, as in the original.
        } catch (CobolDecimal.ZeroDivide cocoonZeroDivide) {
            // every receiver keeps what it held
        }
        if (hPatientAge.value().compareTo(new BigDecimal("17")) > 0 && hOutBmi.value().compareTo(new BigDecimal("18.5")) < 0) {
            hOutBmiFactor.store(sbBmiLt185.value());
        } else {
            hOutBmiFactor.store(new BigDecimal("1.000"));
        }
        if (CobolText.compareAlnum(bDialysisStartDate.value(), "00000000") > 0) {
            if (hPatientAge.value().compareTo(new BigDecimal("17")) > 0) {
                if (onsetDate.value().compareTo(new BigDecimal("120")) > 0) {
                    hOutOnsetFactor.store(new BigDecimal("1"));
                } else {
                    hOutOnsetFactor.store(sbOnsetLe120.value());
                }
            } else {
                hOutOnsetFactor.store(new BigDecimal("1"));
            }
        } else {
            hOutOnsetFactor.store(new BigDecimal("1.000"));
        }
        if (CobolText.compareAlnum(comorbidCwfReturnCode.value(), "  ") == 0) {
            if (hPatientAge.value().compareTo(new BigDecimal("18")) < 0) {
                hOutComorbidMultiplier.store(new BigDecimal("1.000"));
                pps2011ComorbidPay.store("10");
            } else {
                if (hBunOnsetFactor.value().compareTo(cmOnsetLe120.value()) == 0) {
                    hOutComorbidMultiplier.store(new BigDecimal("1.000"));
                    pps2011ComorbidPay.store("10");
                } else {
                    p2600CalcComorbidOutAdjust();
                }
            }
        } else {
            if (comorbidCwfReturnCode.value().compareTo("10") == 0) {
                hOutComorbidMultiplier.store(new BigDecimal("1.000"));
            } else {
                if (comorbidCwfReturnCode.value().compareTo("20") == 0) {
                    hOutComorbidMultiplier.store(sbGiBleed.value());
                } else {
                    if (comorbidCwfReturnCode.value().compareTo("40") == 0) {
                        hOutComorbidMultiplier.store(sbPericarditis.value());
                    }
                }
            }
        }
        if (pProvLowVolumeIndic.value().compareTo("N") == 0) {
            hOutLowVolMultiplier.store(new BigDecimal("1"));
        } else {
            if (hPatientAge.value().compareTo(new BigDecimal("18")) < 0) {
                hOutLowVolMultiplier.store(new BigDecimal("1"));
            } else {
                hOutLowVolMultiplier.store(sbLowVolAdjLt4000.value());
                lowVolumeTrack.store("Y");
            }
        }
        if (CobolText.compareAlnum(pGeoCbsa.value(), "100") < 0 && hPatientAge.value().compareTo(new BigDecimal("17")) > 0) {
            hOutRuralMultiplier.store(sbRural.value());
        } else {
            hOutRuralMultiplier.store(new BigDecimal("1.000"));
        }
        hOutPredictedServicesMap.storeRounded(hOutAgeFactor.value().multiply(hOutBsaFactor.value()).multiply(hOutBmiFactor.value()).multiply(hOutOnsetFactor.value()).multiply(hOutComorbidMultiplier.value()).multiply(hOutRuralMultiplier.value()).multiply(hOutLowVolMultiplier.value()));
        if (hPatientAge.value().compareTo(new BigDecimal("18")) < 0) {
            hOutCmAdjPredictMapTrt.storeRounded(hOutPredictedServicesMap.value().multiply(adjAvgMapAmtLt18.value()));
            // TRUNCATES: the expression produces up to 11 integer digits and H-OUT-CM-ADJ-PREDICT-MAP-TRT holds 7. The high-order digits are lost, as in the original.
            hOutAdjAvgMapAmt.store(adjAvgMapAmtLt18.value());
            // TRUNCATES: ADJ-AVG-MAP-AMT-LT-18 holds 4+2 digits, H-OUT-ADJ-AVG-MAP-AMT holds 3+2. The original loses the excess here; so does this.
        } else {
            hOutCmAdjPredictMapTrt.storeRounded(hOutPredictedServicesMap.value().multiply(adjAvgMapAmtGt17.value()));
            // TRUNCATES: the expression produces up to 11 integer digits and H-OUT-CM-ADJ-PREDICT-MAP-TRT holds 7. The high-order digits are lost, as in the original.
            hOutAdjAvgMapAmt.store(adjAvgMapAmtGt17.value());
            // TRUNCATES: ADJ-AVG-MAP-AMT-GT-17 holds 4+2 digits, H-OUT-ADJ-AVG-MAP-AMT holds 3+2. The original loses the excess here; so does this.
        }
        if (bCondCode.value().compareTo("74") == 0 && (bRevCode.value().compareTo("0841") == 0 || bRevCode.value().compareTo("0851") == 0)) {
            try {   // a zero divisor stores nothing, as in COBOL
                hHemoEquivDialSessions.storeRounded(CobolDecimal.divide(bClaimNumDialysisSessions.value().multiply(new BigDecimal("3")), new BigDecimal("7")));
            } catch (CobolDecimal.ZeroDivide cocoonZeroDivide) {
                // every receiver keeps what it held
            }
            try {   // a zero divisor stores nothing, as in COBOL
                hOutImputedMap.storeRounded(CobolDecimal.divide(bTotPriceSbOutlier.value(), hHemoEquivDialSessions.value()));
            } catch (CobolDecimal.ZeroDivide cocoonZeroDivide) {
                // every receiver keeps what it held
            }
        } else {
            try {   // a zero divisor stores nothing, as in COBOL
                hOutImputedMap.storeRounded(CobolDecimal.divide(bTotPriceSbOutlier.value(), bClaimNumDialysisSessions.value()));
            } catch (CobolDecimal.ZeroDivide cocoonZeroDivide) {
                // every receiver keeps what it held
            }
        }
        if (hPatientAge.value().compareTo(new BigDecimal("18")) < 0) {
            hOutPredictedMap.storeRounded(hOutCmAdjPredictMapTrt.value().add(fixDollarLossLt18.value()));
            hOutFixDollarLoss.store(fixDollarLossLt18.value());
            if (hOutImputedMap.value().compareTo(hOutPredictedMap.value()) > 0) {
                hOutPayment.storeRounded(hOutImputedMap.value().subtract(hOutPredictedMap.value()).multiply(lossSharingPctLt18.value()));
                // TRUNCATES: the expression produces up to 10 integer digits and H-OUT-PAYMENT holds 7. The high-order digits are lost, as in the original.
                hOutLossSharingPct.store(lossSharingPctLt18.value());
                // TRUNCATES: LOSS-SHARING-PCT-LT-18 holds 3+2 digits, H-OUT-LOSS-SHARING-PCT holds 1+2. The original loses the excess here; so does this.
                outlierTrack.store("Y");
            } else {
                hOutPayment.store(BigDecimal.ZERO);
                hOutLossSharingPct.store(BigDecimal.ZERO);
            }
        } else {
            hOutPredictedMap.storeRounded(hOutCmAdjPredictMapTrt.value().add(fixDollarLossGt17.value()));
            hOutFixDollarLoss.store(fixDollarLossGt17.value());
            if (hOutImputedMap.value().compareTo(hOutPredictedMap.value()) > 0) {
                hOutPayment.storeRounded(hOutImputedMap.value().subtract(hOutPredictedMap.value()).multiply(lossSharingPctGt17.value()));
                // TRUNCATES: the expression produces up to 10 integer digits and H-OUT-PAYMENT holds 7. The high-order digits are lost, as in the original.
                hOutLossSharingPct.store(lossSharingPctGt17.value());
                // TRUNCATES: LOSS-SHARING-PCT-GT-17 holds 3+2 digits, H-OUT-LOSS-SHARING-PCT holds 1+2. The original loses the excess here; so does this.
                outlierTrack.store("Y");
            } else {
                hOutPayment.store(BigDecimal.ZERO);
            }
        }
        outNonPerDiemPayment.store(hOutPayment.value());
        if (bCondCode.value().compareTo("74") == 0 && (bRevCode.value().compareTo("0841") == 0 || bRevCode.value().compareTo("0851") == 0)) {
            try {   // a zero divisor stores nothing, as in COBOL
                hOutPayment.storeRounded(hOutPayment.value().multiply(CobolDecimal.divide(bClaimNumDialysisSessions.value().multiply(new BigDecimal("3")), new BigDecimal("7"))));
                // TRUNCATES: the expression produces up to 9 integer digits and H-OUT-PAYMENT holds 7. The high-order digits are lost, as in the original.
            } catch (CobolDecimal.ZeroDivide cocoonZeroDivide) {
                // every receiver keeps what it held
            }
        }
    }

    /** 2600-CALC-COMORBID-OUT-ADJUST */
    private void p2600CalcComorbidOutAdjust() {
        isHighComorbidFound.store("N");
        hOutComorbidMultiplier.store(new BigDecimal("1.000"));
        sub.store(new BigDecimal("1"));
        while (!(sub.value().compareTo(new BigDecimal("6")) > 0 || isHighComorbidFound.value().compareTo("Y") == 0)) {
            if (comorbidData[sub.value().intValue() - 1].value().compareTo("MA") == 0) {
                hOutComorbidMultiplier.store(sbGiBleed.value());
                acuteComorbidTrack.store("Y");
            } else {
                if (comorbidData[sub.value().intValue() - 1].value().compareTo("MC") == 0) {
                    if (sbPericarditis.value().compareTo(hOutComorbidMultiplier.value()) > 0) {
                        hOutComorbidMultiplier.store(sbPericarditis.value());
                        acuteComorbidTrack.store("Y");
                    }
                } else {
                    if (comorbidData[sub.value().intValue() - 1].value().compareTo("MD") == 0) {
                        if (sbMyelodysplastic.value().compareTo(hOutComorbidMultiplier.value()) > 0) {
                            hOutComorbidMultiplier.store(sbMyelodysplastic.value());
                            chronicComorbidTrack.store("Y");
                        }
                    } else {
                        if (comorbidData[sub.value().intValue() - 1].value().compareTo("ME") == 0) {
                            if (sbSickelCell.value().compareTo(hOutComorbidMultiplier.value()) > 0) {
                                hOutComorbidMultiplier.store(sbSickelCell.value());
                                chronicComorbidTrack.store("Y");
                            }
                        }
                    }
                }
            }
            sub.store(sub.value().add(new BigDecimal("1")));
        }
    }

    /** 3000-LOW-VOL-FULL-PPS-PAYMENT */
    private void p3000LowVolFullPpsPayment() {
        hLvBunAdjustBaseWageAmt.storeRounded(hBunBaseWageAmt.value().multiply(hBunAgeFactor.value()).multiply(hBunBsaFactor.value().multiply(hBunBmiFactor.value())).multiply(hBunOnsetFactor.value().multiply(hBunComorbidMultiplier.value())).multiply(hBunRuralMultiplier.value()));
        // TRUNCATES: the expression produces up to 10 integer digits and H-LV-BUN-ADJUST-BASE-WAGE-AMT holds 7. The high-order digits are lost, as in the original.
        if (bCondCode.value().compareTo("73") == 0 || bCondCode.value().compareTo("87") == 0) {
            if (hBunOnsetFactor.value().compareTo(cmOnsetLe120.value()) == 0) {
                hBunWageAdjTrainingAmt.store(BigDecimal.ZERO);
            } else {
                hBunWageAdjTrainingAmt.storeRounded(trainingAddOnPmtAmt.value().multiply(bunCbsaWIndex.value()));
                trainingTrack.store("Y");
            }
        } else {
            if (bCondCode.value().compareTo("74") == 0 && (bRevCode.value().compareTo("0841") == 0 || bRevCode.value().compareTo("0851") == 0)) {
                try {   // a zero divisor stores nothing, as in COBOL
                    hCc74PerDiemAmt.storeRounded(CobolDecimal.divide(hLvBunAdjustBaseWageAmt.value().multiply(new BigDecimal("3")), new BigDecimal("7")));
                } catch (CobolDecimal.ZeroDivide cocoonZeroDivide) {
                    // every receiver keeps what it held
                }
            } else {
                hBunWageAdjTrainingAmt.store(BigDecimal.ZERO);
                hCc74PerDiemAmt.store(BigDecimal.ZERO);
            }
        }
        if (bCondCode.value().compareTo("74") == 0 && (bRevCode.value().compareTo("0841") == 0 || bRevCode.value().compareTo("0851") == 0)) {
            hLvPpsFinalPayAmt.storeRounded(hCc74PerDiemAmt.value());
        } else {
            hLvPpsFinalPayAmt.storeRounded(hLvBunAdjustBaseWageAmt.value().add(hBunWageAdjTrainingAmt.value()));
        }
    }

    /** 3100-LOW-VOL-OUT-PPS-PAYMENT */
    private void p3100LowVolOutPpsPayment() {
        hLvOutPredictServicesMap.storeRounded(hOutAgeFactor.value().multiply(hOutBsaFactor.value()).multiply(hOutBmiFactor.value()).multiply(hOutOnsetFactor.value()).multiply(hOutComorbidMultiplier.value()).multiply(hOutRuralMultiplier.value()));
        if (hPatientAge.value().compareTo(new BigDecimal("18")) < 0) {
            hLvOutCmAdjPredictMTrt.storeRounded(hLvOutPredictServicesMap.value().multiply(adjAvgMapAmtLt18.value()));
            // TRUNCATES: the expression produces up to 11 integer digits and H-LV-OUT-CM-ADJ-PREDICT-M-TRT holds 7. The high-order digits are lost, as in the original.
            hOutAdjAvgMapAmt.store(adjAvgMapAmtLt18.value());
            // TRUNCATES: ADJ-AVG-MAP-AMT-LT-18 holds 4+2 digits, H-OUT-ADJ-AVG-MAP-AMT holds 3+2. The original loses the excess here; so does this.
        } else {
            hLvOutCmAdjPredictMTrt.storeRounded(hLvOutPredictServicesMap.value().multiply(adjAvgMapAmtGt17.value()));
            // TRUNCATES: the expression produces up to 11 integer digits and H-LV-OUT-CM-ADJ-PREDICT-M-TRT holds 7. The high-order digits are lost, as in the original.
            hOutAdjAvgMapAmt.store(adjAvgMapAmtGt17.value());
            // TRUNCATES: ADJ-AVG-MAP-AMT-GT-17 holds 4+2 digits, H-OUT-ADJ-AVG-MAP-AMT holds 3+2. The original loses the excess here; so does this.
        }
        if (hPatientAge.value().compareTo(new BigDecimal("18")) < 0) {
            hLvOutPredictedMap.storeRounded(hLvOutCmAdjPredictMTrt.value().add(fixDollarLossLt18.value()));
            hOutFixDollarLoss.store(fixDollarLossLt18.value());
            if (hOutImputedMap.value().compareTo(hLvOutPredictedMap.value()) > 0) {
                hLvOutPayment.storeRounded(hOutImputedMap.value().subtract(hLvOutPredictedMap.value()).multiply(lossSharingPctLt18.value()));
                // TRUNCATES: the expression produces up to 10 integer digits and H-LV-OUT-PAYMENT holds 7. The high-order digits are lost, as in the original.
                hOutLossSharingPct.store(lossSharingPctLt18.value());
                // TRUNCATES: LOSS-SHARING-PCT-LT-18 holds 3+2 digits, H-OUT-LOSS-SHARING-PCT holds 1+2. The original loses the excess here; so does this.
            } else {
                hLvOutPayment.store(BigDecimal.ZERO);
                hOutLossSharingPct.store(BigDecimal.ZERO);
            }
        } else {
            hLvOutPredictedMap.storeRounded(hLvOutCmAdjPredictMTrt.value().add(fixDollarLossGt17.value()));
            hOutFixDollarLoss.store(fixDollarLossGt17.value());
            if (hOutImputedMap.value().compareTo(hLvOutPredictedMap.value()) > 0) {
                hLvOutPayment.storeRounded(hOutImputedMap.value().subtract(hLvOutPredictedMap.value()).multiply(lossSharingPctGt17.value()));
                // TRUNCATES: the expression produces up to 10 integer digits and H-LV-OUT-PAYMENT holds 7. The high-order digits are lost, as in the original.
                hOutLossSharingPct.store(lossSharingPctGt17.value());
                // TRUNCATES: LOSS-SHARING-PCT-GT-17 holds 3+2 digits, H-OUT-LOSS-SHARING-PCT holds 1+2. The original loses the excess here; so does this.
            } else {
                hLvOutPayment.store(BigDecimal.ZERO);
            }
        }
        outNonPerDiemPayment.store(hLvOutPayment.value());
        if (bCondCode.value().compareTo("74") == 0 && (bRevCode.value().compareTo("0841") == 0 || bRevCode.value().compareTo("0851") == 0)) {
            try {   // a zero divisor stores nothing, as in COBOL
                hLvOutPayment.storeRounded(hLvOutPayment.value().multiply(CobolDecimal.divide(bClaimNumDialysisSessions.value().multiply(new BigDecimal("3")), new BigDecimal("7"))));
                // TRUNCATES: the expression produces up to 9 integer digits and H-LV-OUT-PAYMENT holds 7. The high-order digits are lost, as in the original.
            } catch (CobolDecimal.ZeroDivide cocoonZeroDivide) {
                // every receiver keeps what it held
            }
        }
    }

    /** 9000-SET-RETURN-CODE */
    private void p9000SetReturnCode() {
        if (pediatricTrack.value().compareTo("Y") == 0) {
            if (outlierTrack.value().compareTo("Y") == 0) {
                if (trainingTrack.value().compareTo("Y") == 0) {
                    ppsRtc.store(new BigDecimal("17"));
                } else {
                    ppsRtc.store(new BigDecimal("16"));
                }
            } else {
                if (trainingTrack.value().compareTo("Y") == 0) {
                    ppsRtc.store(new BigDecimal("15"));
                } else {
                    ppsRtc.store(new BigDecimal("14"));
                }
            }
        } else {
            if (outlierTrack.value().compareTo("Y") == 0) {
                if (lowVolumeTrack.value().compareTo("Y") == 0) {
                    if (trainingTrack.value().compareTo("Y") == 0) {
                        if (chronicComorbidTrack.value().compareTo("Y") == 0) {
                            ppsRtc.store(new BigDecimal("24"));
                        } else {
                            if (acuteComorbidTrack.value().compareTo("Y") == 0) {
                                ppsRtc.store(new BigDecimal("19"));
                            } else {
                                ppsRtc.store(new BigDecimal("29"));
                            }
                        }
                    } else {
                        if (chronicComorbidTrack.value().compareTo("Y") == 0) {
                            ppsRtc.store(new BigDecimal("23"));
                        } else {
                            if (acuteComorbidTrack.value().compareTo("Y") == 0) {
                                ppsRtc.store(new BigDecimal("18"));
                            } else {
                                if (onsetTrack.value().compareTo("Y") == 0) {
                                    ppsRtc.store(new BigDecimal("30"));
                                } else {
                                    ppsRtc.store(new BigDecimal("28"));
                                }
                            }
                        }
                    }
                } else {
                    if (trainingTrack.value().compareTo("Y") == 0) {
                        if (chronicComorbidTrack.value().compareTo("Y") == 0) {
                            ppsRtc.store(new BigDecimal("34"));
                        } else {
                            if (acuteComorbidTrack.value().compareTo("Y") == 0) {
                                ppsRtc.store(new BigDecimal("35"));
                            } else {
                                ppsRtc.store(new BigDecimal("33"));
                            }
                        }
                    } else {
                        if (chronicComorbidTrack.value().compareTo("Y") == 0) {
                            ppsRtc.store(new BigDecimal("07"));
                        } else {
                            if (acuteComorbidTrack.value().compareTo("Y") == 0) {
                                ppsRtc.store(new BigDecimal("06"));
                            } else {
                                if (onsetTrack.value().compareTo("Y") == 0) {
                                    ppsRtc.store(new BigDecimal("09"));
                                } else {
                                    ppsRtc.store(new BigDecimal("03"));
                                }
                            }
                        }
                    }
                }
            } else {
                if (lowVolumeTrack.value().compareTo("Y") == 0) {
                    if (trainingTrack.value().compareTo("Y") == 0) {
                        if (chronicComorbidTrack.value().compareTo("Y") == 0) {
                            ppsRtc.store(new BigDecimal("26"));
                        } else {
                            if (acuteComorbidTrack.value().compareTo("Y") == 0) {
                                ppsRtc.store(new BigDecimal("21"));
                            } else {
                                ppsRtc.store(new BigDecimal("12"));
                            }
                        }
                    } else {
                        if (chronicComorbidTrack.value().compareTo("Y") == 0) {
                            ppsRtc.store(new BigDecimal("25"));
                        } else {
                            if (acuteComorbidTrack.value().compareTo("Y") == 0) {
                                ppsRtc.store(new BigDecimal("20"));
                            } else {
                                if (onsetTrack.value().compareTo("Y") == 0) {
                                    ppsRtc.store(new BigDecimal("32"));
                                } else {
                                    ppsRtc.store(new BigDecimal("10"));
                                }
                            }
                        }
                    }
                } else {
                    if (trainingTrack.value().compareTo("Y") == 0) {
                        if (chronicComorbidTrack.value().compareTo("Y") == 0) {
                            ppsRtc.store(new BigDecimal("27"));
                        } else {
                            if (acuteComorbidTrack.value().compareTo("Y") == 0) {
                                ppsRtc.store(new BigDecimal("22"));
                            } else {
                                ppsRtc.store(new BigDecimal("11"));
                            }
                        }
                    } else {
                        if (onsetTrack.value().compareTo("Y") == 0) {
                            ppsRtc.store(new BigDecimal("08"));
                        } else {
                            if (acuteComorbidTrack.value().compareTo("Y") == 0) {
                                ppsRtc.store(new BigDecimal("04"));
                            } else {
                                if (chronicComorbidTrack.value().compareTo("Y") == 0) {
                                    ppsRtc.store(new BigDecimal("05"));
                                } else {
                                    if (lowBmiTrack.value().compareTo("Y") == 0) {
                                        ppsRtc.store(new BigDecimal("31"));
                                    } else {
                                        ppsRtc.store(new BigDecimal("02"));
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    /** 9100-MOVE-RESULTS */
    private void p9100MoveResults() {
        if (CobolText.compareAlnum(movedCormorbids.value(), " ") == 0) {
        } else {
            comorbidData[0].store(hComorbidData[0].value());
            comorbidData[1].store(hComorbidData[1].value());
            comorbidData[2].store(hComorbidData[2].value());
            comorbidData[3].store(hComorbidData[3].value());
            comorbidData[4].store(hComorbidData[4].value());
            comorbidData[5].store(hComorbidData[5].value());
            comorbidCwfReturnCode.store(hComorbidCwfCode.value());
        }
        ppsMsa.store(pGeoMsa.value());
        ppsCbsa.store(pGeoCbsa.value());
        ppsWageAdjRate.store(hWageAdjPymtAmt.value());
        ppsCondCode.store(bCondCode.value());
        ppsRevCode.store(bRevCode.value());
        pps2011WageAdjRate.store(hBunBaseWageAmt.value());
        // TRUNCATES: H-BUN-BASE-WAGE-AMT holds 4+4 digits, PPS-2011-WAGE-ADJ-RATE holds 4+2. The original loses the excess here; so does this.
        pps2011NatLaborPct.store(bunNatLaborPct.value());
        pps2011NatNonlaborPct.store(bunNatNonlaborPct.value());
        ppsNatLaborPct.store(natLaborPct.value());
        ppsNatNonlaborPct.store(natNonlaborPct.value());
        ppsAgeFactor.store(hAgeFactor.value());
        ppsBsaFactor.store(hBsaFactor.value());
        ppsBmiFactor.store(hBmiFactor.value());
        ppsBdgtNeutRate.store(caseMixBdgtNeutFactor.value());
        pps2011AgeFactor.store(hBunAgeFactor.value());
        pps2011BsaFactor.store(hBunBsaFactor.value());
        pps2011BmiFactor.store(hBunBmiFactor.value());
        pps2011BdgtNeutRate.store(transitionBdgtNeutFactor.value());
        pps2011ComorbidMa.store(" ");
        pps2011ComorbidMaCc.store(" ");
        if (bCondCode.value().compareTo("74") == 0 && (bRevCode.value().compareTo("0841") == 0 || bRevCode.value().compareTo("0851") == 0)) {
            try {   // a zero divisor stores nothing, as in COBOL
                hOutPayment.storeRounded(CobolDecimal.divide(hOutPayment.value(), bClaimNumDialysisSessions.value()));
            } catch (CobolDecimal.ZeroDivide cocoonZeroDivide) {
                // every receiver keeps what it held
            }
        }
        if (pProvWaiveBlendPayIndic.value().compareTo("N") == 0) {
            pps2011BlendCompRate.storeRounded(hPymtAmt.value().multiply(comCbsaBlendPct.value()));
            pps2011BlendPpsRate.storeRounded(hPpsFinalPayAmt.value().multiply(bunCbsaBlendPct.value()));
            // TRUNCATES: the expression produces up to 8 integer digits and PPS-2011-BLEND-PPS-RATE holds 7. The high-order digits are lost, as in the original.
            pps2011BlendOutlierRate.storeRounded(hOutPayment.value().multiply(bunCbsaBlendPct.value()));
            // TRUNCATES: the expression produces up to 8 integer digits and PPS-2011-BLEND-OUTLIER-RATE holds 7. The high-order digits are lost, as in the original.
        } else {
            pps2011BlendCompRate.store(BigDecimal.ZERO);
            pps2011BlendPpsRate.store(BigDecimal.ZERO);
            pps2011BlendOutlierRate.store(BigDecimal.ZERO);
        }
        pps2011FullCompRate.store(hPymtAmt.value());
        pps2011FullPpsRate.store(hPpsFinalPayAmt.value());
        ppsFinalPayAmt.store(hPpsFinalPayAmt.value());
        pps2011FullOutlierRate.store(hOutPayment.value());
        // TRUNCATES: H-OUT-PAYMENT holds 7+4 digits, PPS-2011-FULL-OUTLIER-RATE holds 7+2. The original loses the excess here; so does this.
        tdapaReturn.store(hTdapaPayment.value());
        tpniesReturn.store(hTpniesPayment.value());
        networkReductionReturn.store(hNetworkReduction.value());
        if (bCondCode.value().compareTo("84") != 0) {
            if (pQipReduction.value().compareTo(" ") == 0) {
            } else {
                pps2011BlendCompRate.storeRounded(pps2011BlendCompRate.value().multiply(qipReduction.value()));
                // TRUNCATES: the expression produces up to 8 integer digits and PPS-2011-BLEND-COMP-RATE holds 7. The high-order digits are lost, as in the original.
                pps2011FullCompRate.storeRounded(pps2011FullCompRate.value().multiply(qipReduction.value()));
                // TRUNCATES: the expression produces up to 8 integer digits and PPS-2011-FULL-COMP-RATE holds 7. The high-order digits are lost, as in the original.
                pps2011BlendPpsRate.storeRounded(pps2011BlendPpsRate.value().multiply(qipReduction.value()));
                // TRUNCATES: the expression produces up to 8 integer digits and PPS-2011-BLEND-PPS-RATE holds 7. The high-order digits are lost, as in the original.
                pps2011BlendOutlierRate.storeRounded(pps2011BlendOutlierRate.value().multiply(qipReduction.value()));
                // TRUNCATES: the expression produces up to 8 integer digits and PPS-2011-BLEND-OUTLIER-RATE holds 7. The high-order digits are lost, as in the original.
                hFinalAmtWithoutHdpa.storeRounded(hFinalAmtWithoutHdpa.value().multiply(qipReduction.value()));
                // TRUNCATES: the expression produces up to 8 integer digits and H-FINAL-AMT-WITHOUT-HDPA holds 7. The high-order digits are lost, as in the original.
                hFinalAmtWithHdpa.storeRounded(hFinalAmtWithHdpa.value().multiply(qipReduction.value()));
                // TRUNCATES: the expression produces up to 8 integer digits and H-FINAL-AMT-WITH-HDPA holds 7. The high-order digits are lost, as in the original.
                pps2011FullOutlierRate.storeRounded(pps2011FullOutlierRate.value().multiply(qipReduction.value()));
                // TRUNCATES: the expression produces up to 8 integer digits and PPS-2011-FULL-OUTLIER-RATE holds 7. The high-order digits are lost, as in the original.
            }
        }
        hFinalAmtWithoutHdpa.storeRounded(hFinalAmtWithoutHdpa.value().subtract(hNetworkReduction.value()));
        hFinalAmtWithHdpa.storeRounded(hFinalAmtWithHdpa.value().subtract(hNetworkReduction.value()));
        if (bCondCode.value().compareTo("84") != 0) {
            if (bDataCode.value().compareTo("94") == 0) {
                pps2011FullPpsRate.store(hFinalAmtWithHdpa.value());
                adjBaseWageBeforeEtcHdpa.store(hFinalAmtWithoutHdpa.value());
            } else {
                pps2011FullPpsRate.store(hFinalAmtWithoutHdpa.value());
                adjBaseWageBeforeEtcHdpa.store(BigDecimal.ZERO);
            }
        }
        if (bundledTestIndic.value().compareTo("T") == 0) {
            drugAddOnReturn.store(drugAddon.value());
            msaWageAdj.store(new BigDecimal("0.0"));
            cbsaWageAdj.store(hWageAdjPymtAmt.value());
            cbsaWagePmtRate.store(basePaymentRate.value());
            ageReturn.store(hPatientAge.value());
            msaWageAmt.store(new BigDecimal("0.0"));
            cbsaWageIndex.store(comCbsaWIndex.value());
            ppsBmi.store(hBmi.value());
            ppsBsa.store(hBsa.value());
            msaPct.store(msaBlendPct.value());
            cbsaPct.store(cbsaBlendPct.value());
            if (pProvWaiveBlendPayIndic.value().compareTo("N") == 0) {
                comCbsaPctBlend.store(comCbsaBlendPct.value());
                bunCbsaPctBlend.store(bunCbsaBlendPct.value());
            } else {
                comCbsaPctBlend.store(BigDecimal.ZERO);
                bunCbsaPctBlend.store(waiveCbsaBlendPct.value());
            }
            bunBsa.store(hBunBsa.value());
            bunBmi.store(hBunBmi.value());
            bunOnsetFactor.store(hBunOnsetFactor.value());
            bunComorbidMultiplier.store(hBunComorbidMultiplier.value());
            bunLowVolMultiplier.store(hBunLowVolMultiplier.value());
            outAgeFactor.store(hOutAgeFactor.value());
            outBsa.store(hOutBsa.value());
            outSbBsa.store(sbBsa.value());
            outBsaFactor.store(hOutBsaFactor.value());
            outBmi.store(hOutBmi.value());
            outBmiFactor.store(hOutBmiFactor.value());
            outOnsetFactor.store(hOutOnsetFactor.value());
            outComorbidMultiplier.store(hOutComorbidMultiplier.value());
            outPredictedServicesMap.store(hOutPredictedServicesMap.value());
            // TRUNCATES: H-OUT-PREDICTED-SERVICES-MAP holds 7+4 digits, OUT-PREDICTED-SERVICES-MAP holds 2+4. The original loses the excess here; so does this.
            outCaseMixPredictedMap.store(hOutCmAdjPredictMapTrt.value());
            // TRUNCATES: H-OUT-CM-ADJ-PREDICT-MAP-TRT holds 7+4 digits, OUT-CASE-MIX-PREDICTED-MAP holds 4+4. The original loses the excess here; so does this.
            outHemoEquivDialSessions.store(hHemoEquivDialSessions.value());
            // TRUNCATES: H-HEMO-EQUIV-DIAL-SESSIONS holds 7+4 digits, OUT-HEMO-EQUIV-DIAL-SESSIONS holds 2+4. The original loses the excess here; so does this.
            outLowVolMultiplier.store(hOutLowVolMultiplier.value());
            outAdjAvgMapAmt.store(hOutAdjAvgMapAmt.value());
            outImputedMap.store(hOutImputedMap.value());
            // TRUNCATES: H-OUT-IMPUTED-MAP holds 7+4 digits, OUT-IMPUTED-MAP holds 4+4. The original loses the excess here; so does this.
            outFixDollarLoss.store(hOutFixDollarLoss.value());
            outLossSharingPct.store(hOutLossSharingPct.value());
            outPredictedMap.store(hOutPredictedMap.value());
            crBsaMultiplier.store(crBsa.value());
            crBmiMultiplier.store(crBmiLt185.value());
            a49CentDrugAdj.store(a49CentPartDDrugAdj.value());
            ppsCmBsa.store(cmBsa.value());
            ppsCmBmiLt185.store(cmBmiLt185.value());
            ppsBunBasePmtRate.store(bundledBasePmtRate.value());
            ppsBunCbsaWIndex.store(bunCbsaWIndex.value());
            bunAdjustedBaseWageAmt.store(hBunAdjustedBaseWageAmt.value());
            ppsBunWageAdjTrainAmt.store(hBunWageAdjTrainingAmt.value());
            ppsTrainingAddOnPmtAmt.store(trainingAddOnPmtAmt.value());
            comPaymentRate.store(hPaymentRate.value());
        }
    }

    public static void main(String[] args) {
        new Escal212().run();
    }
}
