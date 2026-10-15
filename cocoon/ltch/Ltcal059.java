import cocoon.runtime.CobolDecimal;
import cocoon.runtime.CobolText;
import cocoon.runtime.CobolRecord;
import java.math.BigDecimal;

/**
 * Translated from COBOL program LTCAL059.
 *
 * The arithmetic is deliberately not Java arithmetic. A
 * COBOL field holds what its PICTURE allows, and a value
 * too large loses its high-order digits without raising
 * anything. Every place this translation reproduces that
 * is marked TRUNCATES, because a faithful migration has
 * to compute the same numbers as the program it
 * replaces, defects included.
 */
public class Ltcal059 {

    // Records: the bytes, laid out as the mainframe lays them out.
    private final CobolRecord r_W_STORAGE_REF = new CobolRecord("W-STORAGE-REF", 46,
        "4c5443414c3035392020202020202d2057204f2052204b2049204e2047202020532054204f205220412047204520");
    private final CobolRecord r_CAL_VERSION = new CobolRecord("CAL-VERSION", 5,
        "5630352e39");
    private final CobolRecord r_PROGRAM_CONSTANTS = new CobolRecord("PROGRAM-CONSTANTS", 40,
        "32303032313030313230303331303031323030343130303132303035313030313230303631303031");
    private final CobolRecord r_W_DRG_FILLS = new CobolRecord("W-DRG-FILLS", 5632,
        "30303131313839393238353030323131383939323835303033313138393932383530303630363036343231313030373134343538333637303038303630363432313130303931303935303331333031303039303232323530303131303435383631363930313230373431363235363031333037383230323436303134303831383932353930313530373836383237323031363038333538323437303137303630363432313130313830373735353234383031393036353833323131303230313035353832373030323131313839393238353032323036303634323131303233313132323532363630323430363734303232343032353036303634323131303236303630363432313130323731313431383238333032383039323530323938303239303835303832343330333030383530383234333033313036303634323131303332303630363432313130333330363036343231313033343038343138323432303335303639373632323630333630343538363136393033373034353836313639303338303435383631363930333930343538363136393034303034353836313639303431303435383631363930343230343538363136393034333034353836313639303434303835303832343330343530343538363136393034363036303634323131303437303435383631363930343830343538363136393034393131383939323835303530313138393932383530353131313839393238353035323131383939323835303533313138393932383530353431313839393238353035353138363538333836303536313138393932383530353730363036343231313035383036303634323131303539303630363432313130363030363036343231313036313036303634323131303632303630363432313130363331313839393238353036343132353838323734303635303338353831363230363630363036343231313036373131383939323835303638303631313532313330363930363036343231313037303036303634323131303731303435383631363930373230383530383234333037333039333431323335303734303630363432313130373532303636313331393037363233383233343136303737313836353833383630373830373432343232303037393039333530323337303830303932313532363730383130363036343231313038323037353931313939303833303630363432313130383430343538363136393038353037383532323230303836303738353232323030383731363739373330343038383037333334323031303839303737363232313230393030373439343231393039313038353038323433303932303733313832303430393330343538363136393039343038333438323133303935303435383631363930393630373537353230323039373035333035313636303938303435383631363930393931303634383235383130303039303438323239313031303837333732313931303230383733373231393130343034353836313639313035303435383631363931303630343538363136393130373034353836313639313038313138393932383531303930363036343231313131303034353836313639313131303435383631363931313331333239383336323131343131373830333333313135313138393932383531313631383635383338363131373036303634323131313138313836353833383631313930343538363136393132303132303134333236313231303832393332313831323230383530383234333132333039383930313836313234303835303832343331323531383635383338363132363038343339323436313237303735393732313631323830383530383234333132393036303634323131313330303730373232323731333130353731383230363133323037303836323236313333303536323931393431333430363637343231353133353038393038323436313336303835303832343331333730383530383234333133383037343531323230313339303534383831393331343030363036343231313134313035333034323235313432303533303432323531343330343538363136393134343037393133323138313435303739313332313831343631383635383338363134373138363538333836313438323034363033353131343930343538363136393135303138363538333836313531313836353833383631353231383635383338363135333138363538333836313534313836353833383631353531383635383338363135363138363538333836313537313138393932383531353831313839393238353135393038353038323433313630303835303832343331363131383635383338363136323034353836313639313633303435383631363931363431383635383338363136353138363538333836313636313836353833383631363731383635383338363136383131383939323835313639303835303832343331373031373434383333333137313137343438333333313732303838323232323831373330383832323232383137343037303637323139313735303730363732313931373631303132343233333137373038353038323433313738303435383631363931373930383732383233343138303039343338323232313831303630363432313131383230383337333233313138333036393932323037313834303630363432313131383530383434373234323138363038353038323433313837303835303832343331383830393735313234303138393038383339323239313930303835303832343331393131383635383338363139323138363538333836313933303435383631363931393430343538363136393139353138363538333836313936313836353833383631393731383635383338363139383138363538333836313939303835303832343332303030383530383234333230313131383939323835323032303732313732333332303330373836373230393230343038363236323135323035303735393632333032303630363036343231313230373036343932313933323038303435383631363932303931383635383338363231303138363538333836323131313836353833383632313231383635383338363231333131363936333339323136313836353833383632313731333132333337323231383131383939323835323139313138393932383532323031313839393238353232333131383939323835323234303630363432313132323531303630313330343232363138363538333836323237303630363432313132323830383530383234333232393034353836313639323330313836353833383632333230383530383234333233333135313335333435323334303835303832343332333530373932303330333233363037333438323639323337303435383631363932333830393332393238393233393036363139323134323430303731363032333132343130343538363136393234323037393433323632323433303630373232323332343430353730353232333234353035313039313933323436303538383432313432343730353434353231343234383037383330323433323439303639303732333932353030363036343231313235313036303634323131323532303835303832343332353330383336383238353235343036393536323731323535303835303832343332353630373439313233333235373034353836313639323538303435383631363932353930343538363136393236303034353836313639323631313836353833383632363230383530383234333236333133353638333931323634313036323233333032363531343336333335373236363038353038323433323637313836353833383632363831383635383338363236393133393034333834323730303835303832343332373130393537323238343237323037393536323530323733303435383631363932373430393533353237373237353034353836313639323736303630363432313132373730363731313231363237383035323737313930323739303435383631363932383030383834303237313238313038313930323833323832303835303832343332383330373731323232393238343034353836313639323835313237393933353932383631313839393238353238373131303930333234323838303835303832343332383931313839393238353239303131383939323835323931313138393932383532393231313839393238353239333131383939323835323934303734373232333832393530363036343231313239363037393733323337323937303632323532313632393830363036343231313239393131383939323835333030303739343832343633303130373934383234363330333131383939323835333034313138393932383533303530363036343231313330363131383939323835333037303835303832343333303831313839393238353330393131383939323835333130303835303832343333313130383530383234333331323131383939323835333133313138393932383533313430363036343231313331353134363138333432333136303931373532333633313730393233383232313331383037373938323235333139303737393832323533323030373739383232353332313035373231323139333232303435383631363933323330363036343231313332343034353836313639333235303835303832343333323630343538363136393332373034353836313639333238303630363432313133323930363036343231313333303036303634323131333331303832343032323933333230363236333232333333333036303634323131333334313836353833383633333531383635383338363333363131383939323835333337313138393932383533333831383635383338363333393034353836313639333430303435383631363933343131383635383338363334323034353836313639333433303435383631363933343431383635383338363334353138363538333836333436303635353632303833343730343538363136393334383036303634323131333439303630363432313133353030373738393232363335313034353836313639333532313138393932383533353331383635383338363335343138363538333836333535313836353833383633353631313839393238353335373131383939323835333538313138393932383533353931313839393238353336303131383939323835333631303435383631363933363230343538363136393336333034353836313639333634303435383631363933363531383635383338363336363130333435323339333637303435383631363933363830373136383232353336393038353038323433333730303835303832343333373130343538363136393337323034353836313639333733303435383631363933373430343538363136393337353034353836313639333736303435383631363933373730343538363136393337383038353038323433333739303435383631363933383030343538363136393338313034353836313639333832303435383631363933383330343538363136393338343034353836313639333835303435383631363933383630343538363136393338373034353836313639333838303435383631363933383930343538363136393339303034353836313639333931303435383631363933393231383635383338363339333138363538333836333934313138393932383533393530373531363233373339363036303634323131333937303738323731393233393830373532303231343339393036303634323131343031313138393932383534303230383530383234333430333038393936323230343034303435383631363934303530343538363136393430363138363538333836343037313138393932383534303831313839393238353430393039313034323236343130313138393932383534313130343538363136393431323034353836313639343133303838303732303734313430363036343231313431353135343835333635343136303839363132333934313730383530383234333431383038363937323437343139313138393932383534323031313839393238353432313130313235323531343232303630363432313134323330393432353232383432343138363538333836343235303536343932313234323630353737373236363432373034353836313639343238303636313732393134323930353736373234343433303034373436323237343331303438373532323034333230343538363136393433333034353836313639343339313038303833353034343031323235343332323434313036303634323131343432313437373233373334343331343737323337333434343038303531323434343435303830353132343434343630383530383234333434373038353038323433343438303835303832343334343930363036343231313435303034353836313639343531303630363432313134353230393933383235343435333037303835323230343534303835303832343334353530363036343231313436313132383234333532343632303635363932333234363330363633313233343436343035353631323237343635303638383532303534363630373238363232323436373036303634323131343638323132383634313734373130383530383234333437333038363232323037343735323130313533343234373630383530383234333437373135363533333532343738313430313033333334373930363036343231313438313131383939323835343832313138393932383534383431313839393238353438353131383939323835343836313836353833383634383731313433313234373438383138363538333836343839303938353432333734393031303439353233333439313138363538333836343932313138393932383534393331313839393238353439343131383939323835343936303835303832343334393730383530383234333439383038353038323433343939313138393932383535303030343538363136393530313131383939323835353032313138393932383535303331313839393238353530343138363538333836353035303835303832343335303631313839393238353530373038353038323433353038303833303332363035303930343538363136393531303039333031323638353131303630363432313135313531383635383338363531363036303634323131353137303835303832343335313830363036343231313531393038353038323433353230303835303832343335323130363031313232323532323036303131323232353233303630313132323235323430363234373232303532353138363538333836353236303835303832343335323730383530383234333532383131383939323835353239313138393932383535333031313839393238353533313131383939323835353332303435383631363935333331383635383338363533343034353836313639353335303835303832343335333631383635383338363533373132363836333532353338303835303832343335333930383530383234333534303036303634323131353431333531383435363235343232393333373435393534333138363538333836");
    private final CobolRecord r_W_DRG_TABLE = r_W_DRG_FILLS;   // REDEFINES W-DRG-FILLS
    private final CobolRecord r_HOLD_PPS_COMPONENTS = new CobolRecord("HOLD-PPS-COMPONENTS", 85,
        "30303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030");
    private final CobolRecord r_BILL_NEW_DATA = new CobolRecord("BILL-NEW-DATA", 60);   // LINKAGE: bound by the caller
    private final CobolRecord r_PPS_DATA_ALL = new CobolRecord("PPS-DATA-ALL", 182);   // LINKAGE: bound by the caller
    private final CobolRecord r_PRICER_OPT_VERS_SW = new CobolRecord("PRICER-OPT-VERS-SW", 6);   // LINKAGE: bound by the caller
    private final CobolRecord r_PROV_NEW_HOLD = new CobolRecord("PROV-NEW-HOLD", 240);   // LINKAGE: bound by the caller
    private final CobolRecord r_WAGE_NEW_INDEX_RECORD = new CobolRecord("WAGE-NEW-INDEX-RECORD", 30);   // LINKAGE: bound by the caller
    private final java.util.Map<String, CobolRecord> cocoonRecordMap = new java.util.LinkedHashMap<>();
    {
        cocoonRecordMap.put("W-STORAGE-REF", r_W_STORAGE_REF);
        cocoonRecordMap.put("CAL-VERSION", r_CAL_VERSION);
        cocoonRecordMap.put("PROGRAM-CONSTANTS", r_PROGRAM_CONSTANTS);
        cocoonRecordMap.put("W-DRG-FILLS", r_W_DRG_FILLS);
        cocoonRecordMap.put("W-DRG-TABLE", r_W_DRG_TABLE);
        cocoonRecordMap.put("HOLD-PPS-COMPONENTS", r_HOLD_PPS_COMPONENTS);
        cocoonRecordMap.put("BILL-NEW-DATA", r_BILL_NEW_DATA);
        cocoonRecordMap.put("PPS-DATA-ALL", r_PPS_DATA_ALL);
        cocoonRecordMap.put("PRICER-OPT-VERS-SW", r_PRICER_OPT_VERS_SW);
        cocoonRecordMap.put("PROV-NEW-HOLD", r_PROV_NEW_HOLD);
        cocoonRecordMap.put("WAGE-NEW-INDEX-RECORD", r_WAGE_NEW_INDEX_RECORD);
    }
    /** A record by its COBOL name; a caller binds a LINKAGE record's bytes here. */
    public CobolRecord record(String name) { return cocoonRecordMap.get(name); }
    public java.util.Map<String, CobolRecord> records() { return cocoonRecordMap; }

    // W-STORAGE-REF PIC X(46)
    private CobolText wStorageRef;
    // CAL-VERSION PIC X(05)
    private CobolText calVersion;
    // FED-FY-BEGIN-03 PIC 9(08)
    private CobolDecimal fedFyBegin03;
    // FED-FY-BEGIN-04 PIC 9(08)
    private CobolDecimal fedFyBegin04;
    // FED-FY-BEGIN-05 PIC 9(08)
    private CobolDecimal fedFyBegin05;
    // FED-FY-BEGIN-06 PIC 9(08)
    private CobolDecimal fedFyBegin06;
    // FED-FY-BEGIN-07 PIC 9(08)
    private CobolDecimal fedFyBegin07;
    // PIC PIC X(44)
    private CobolText pic;
    // WWM-DRG PIC X(3)
    private CobolText[] wwmDrg;
    // WWM-RELWT PIC 9(1)V9(4)
    private CobolDecimal[] wwmRelwt;
    // WWM-ALOS PIC 9(2)V9(1)
    private CobolDecimal[] wwmAlos;
    // H-LOS PIC 9(03)
    private CobolDecimal hLos;
    // H-REG-DAYS PIC 9(03)
    private CobolDecimal hRegDays;
    // H-TOTAL-DAYS PIC 9(05)
    private CobolDecimal hTotalDays;
    // H-SSOT PIC 9(02)
    private CobolDecimal hSsot;
    // H-BLEND-RTC PIC 9(02)
    private CobolDecimal hBlendRtc;
    // H-BLEND-FAC PIC 9(01)V9(01)
    private CobolDecimal hBlendFac;
    // H-BLEND-PPS PIC 9(01)V9(01)
    private CobolDecimal hBlendPps;
    // H-SS-PAY-AMT PIC 9(07)V9(02)
    private CobolDecimal hSsPayAmt;
    // H-SS-COST PIC 9(07)V9(02)
    private CobolDecimal hSsCost;
    // H-LABOR-PORTION PIC 9(07)V9(06)
    private CobolDecimal hLaborPortion;
    // H-NONLABOR-PORTION PIC 9(07)V9(06)
    private CobolDecimal hNonlaborPortion;
    // H-FIXED-LOSS-AMT PIC 9(07)V9(02)
    private CobolDecimal hFixedLossAmt;
    // H-NEW-FAC-SPEC-RATE PIC 9(05)V9(02)
    private CobolDecimal hNewFacSpecRate;
    // H-LOS-RATIO PIC 9(01)V9(05)
    private CobolDecimal hLosRatio;
    // B-NPI8 PIC X(08)
    private CobolText bNpi8;
    // B-NPI-FILLER PIC X(02)
    private CobolText bNpiFiller;
    // B-PROVIDER-NO PIC X(06)
    private CobolText bProviderNo;
    // B-PATIENT-STATUS PIC X(02)
    private CobolText bPatientStatus;
    // B-DRG-CODE PIC X(03)
    private CobolText bDrgCode;
    // B-LOS PIC 9(03)
    private CobolDecimal bLos;
    // B-COV-DAYS PIC 9(03)
    private CobolDecimal bCovDays;
    // B-LTR-DAYS PIC 9(02)
    private CobolDecimal bLtrDays;
    // B-DISCHG-CC PIC 9(02)
    private CobolDecimal bDischgCc;
    // B-DISCHG-YY PIC 9(02)
    private CobolDecimal bDischgYy;
    // B-DISCHG-MM PIC 9(02)
    private CobolDecimal bDischgMm;
    // B-DISCHG-DD PIC 9(02)
    private CobolDecimal bDischgDd;
    // B-COV-CHARGES PIC 9(07)V9(02)
    private CobolDecimal bCovCharges;
    // B-SPEC-PAY-IND PIC X(01)
    private CobolText bSpecPayInd;
    // FILLER PIC X(22)
    private CobolText filler;
    // PPS-RTC PIC 9(02)
    private CobolDecimal ppsRtc;
    // PPS-CHRG-THRESHOLD PIC 9(07)V9(02)
    private CobolDecimal ppsChrgThreshold;
    // PPS-MSA PIC X(04)
    private CobolText ppsMsa;
    // PPS-WAGE-INDEX PIC 9(02)V9(04)
    private CobolDecimal ppsWageIndex;
    // PPS-AVG-LOS PIC 9(02)V9(01)
    private CobolDecimal ppsAvgLos;
    // PPS-RELATIVE-WGT PIC 9(01)V9(04)
    private CobolDecimal ppsRelativeWgt;
    // PPS-OUTLIER-PAY-AMT PIC 9(07)V9(02)
    private CobolDecimal ppsOutlierPayAmt;
    // PPS-LOS PIC 9(03)
    private CobolDecimal ppsLos;
    // PPS-DRG-ADJ-PAY-AMT PIC 9(07)V9(02)
    private CobolDecimal ppsDrgAdjPayAmt;
    // PPS-FED-PAY-AMT PIC 9(07)V9(02)
    private CobolDecimal ppsFedPayAmt;
    // PPS-FINAL-PAY-AMT PIC 9(07)V9(02)
    private CobolDecimal ppsFinalPayAmt;
    // PPS-FAC-COSTS PIC 9(07)V9(02)
    private CobolDecimal ppsFacCosts;
    // PPS-NEW-FAC-SPEC-RATE PIC 9(07)V9(02)
    private CobolDecimal ppsNewFacSpecRate;
    // PPS-OUTLIER-THRESHOLD PIC 9(07)V9(02)
    private CobolDecimal ppsOutlierThreshold;
    // PPS-SUBM-DRG-CODE PIC X(03)
    private CobolText ppsSubmDrgCode;
    // PPS-CALC-VERS-CD PIC X(05)
    private CobolText ppsCalcVersCd;
    // PPS-REG-DAYS-USED PIC 9(03)
    private CobolDecimal ppsRegDaysUsed;
    // PPS-LTR-DAYS-USED PIC 9(03)
    private CobolDecimal ppsLtrDaysUsed;
    // PPS-BLEND-YEAR PIC 9(01)
    private CobolDecimal ppsBlendYear;
    // PPS-COLA PIC 9(01)V9(03)
    private CobolDecimal ppsCola;
    // PPS-NAT-LABOR-PCT PIC 9(01)V9(05)
    private CobolDecimal ppsNatLaborPct;
    // PPS-NAT-NONLABOR-PCT PIC 9(01)V9(05)
    private CobolDecimal ppsNatNonlaborPct;
    // PPS-STD-FED-RATE PIC 9(05)V9(02)
    private CobolDecimal ppsStdFedRate;
    // PPS-BDGT-NEUT-RATE PIC 9(01)V9(03)
    private CobolDecimal ppsBdgtNeutRate;
    // PPS-COT-IND PIC X(01)
    private CobolText ppsCotInd;
    // PRICER-OPTION-SW PIC X(01)
    private CobolText pricerOptionSw;
    // PPDRV-VERSION PIC X(05)
    private CobolText ppdrvVersion;
    // P-NEW-NPI8 PIC X(08)
    private CobolText pNewNpi8;
    // P-NEW-NPI-FILLER PIC X(02)
    private CobolText pNewNpiFiller;
    // P-NEW-STATE PIC 9(02)
    private CobolDecimal pNewState;
    // P-NEW-EFF-DT-CC PIC 9(02)
    private CobolDecimal pNewEffDtCc;
    // P-NEW-EFF-DT-YY PIC 9(02)
    private CobolDecimal pNewEffDtYy;
    // P-NEW-EFF-DT-MM PIC 9(02)
    private CobolDecimal pNewEffDtMm;
    // P-NEW-EFF-DT-DD PIC 9(02)
    private CobolDecimal pNewEffDtDd;
    // P-NEW-FY-BEG-DT-CC PIC 9(02)
    private CobolDecimal pNewFyBegDtCc;
    // P-NEW-FY-BEG-DT-YY PIC 9(02)
    private CobolDecimal pNewFyBegDtYy;
    // P-NEW-FY-BEG-DT-MM PIC 9(02)
    private CobolDecimal pNewFyBegDtMm;
    // P-NEW-FY-BEG-DT-DD PIC 9(02)
    private CobolDecimal pNewFyBegDtDd;
    // P-NEW-REPORT-DT-CC PIC 9(02)
    private CobolDecimal pNewReportDtCc;
    // P-NEW-REPORT-DT-YY PIC 9(02)
    private CobolDecimal pNewReportDtYy;
    // P-NEW-REPORT-DT-MM PIC 9(02)
    private CobolDecimal pNewReportDtMm;
    // P-NEW-REPORT-DT-DD PIC 9(02)
    private CobolDecimal pNewReportDtDd;
    // P-NEW-TERM-DT-CC PIC 9(02)
    private CobolDecimal pNewTermDtCc;
    // P-NEW-TERM-DT-YY PIC 9(02)
    private CobolDecimal pNewTermDtYy;
    // P-NEW-TERM-DT-MM PIC 9(02)
    private CobolDecimal pNewTermDtMm;
    // P-NEW-TERM-DT-DD PIC 9(02)
    private CobolDecimal pNewTermDtDd;
    // P-NEW-WAIVER-CODE PIC X(01)
    private CobolText pNewWaiverCode;
    // P-NEW-INTER-NO PIC 9(05)
    private CobolDecimal pNewInterNo;
    // P-NEW-PROVIDER-TYPE PIC X(02)
    private CobolText pNewProviderType;
    // P-NEW-CURRENT-CENSUS-DIV PIC 9(01)
    private CobolDecimal pNewCurrentCensusDiv;
    // P-NEW-CURRENT-DIV PIC 9(01)
    private CobolDecimal pNewCurrentDiv;
    // P-NEW-CHG-CODE-INDEX PIC X
    private CobolText pNewChgCodeIndex;
    // P-NEW-GEO-LOC-MSAX PIC X(04)
    private CobolText pNewGeoLocMsax;
    // P-NEW-GEO-LOC-MSA9 PIC 9(04)
    private CobolDecimal pNewGeoLocMsa9;
    // P-NEW-WAGE-INDEX-LOC-MSA PIC X(04)
    private CobolText pNewWageIndexLocMsa;
    // P-NEW-STAND-AMT-LOC-MSA PIC X(04)
    private CobolText pNewStandAmtLocMsa;
    // P-NEW-STAND-RURAL PIC XX
    private CobolText pNewStandRural;
    // P-NEW-RURAL-2ND PIC XX
    private CobolText pNewRural2nd;
    // P-NEW-SOL-COM-DEP-HOSP-YR PIC XX
    private CobolText pNewSolComDepHospYr;
    // P-NEW-LUGAR PIC X
    private CobolText pNewLugar;
    // P-NEW-TEMP-RELIEF-IND PIC X
    private CobolText pNewTempReliefInd;
    // P-NEW-FED-PPS-BLEND-IND PIC X
    private CobolText pNewFedPpsBlendInd;
    // P-NEW-FAC-SPEC-RATE PIC 9(05)V9(02)
    private CobolDecimal pNewFacSpecRate;
    // P-NEW-COLA PIC 9(01)V9(03)
    private CobolDecimal pNewCola;
    // P-NEW-INTERN-RATIO PIC 9(01)V9(04)
    private CobolDecimal pNewInternRatio;
    // P-NEW-BED-SIZE PIC 9(05)
    private CobolDecimal pNewBedSize;
    // P-NEW-OPER-CSTCHG-RATIO PIC 9(01)V9(03)
    private CobolDecimal pNewOperCstchgRatio;
    // P-NEW-CMI PIC 9(01)V9(04)
    private CobolDecimal pNewCmi;
    // P-NEW-SSI-RATIO PIC V9(04)
    private CobolDecimal pNewSsiRatio;
    // P-NEW-MEDICAID-RATIO PIC V9(04)
    private CobolDecimal pNewMedicaidRatio;
    // P-NEW-PPS-BLEND-YR-IND PIC 9(01)
    private CobolDecimal pNewPpsBlendYrInd;
    // P-NEW-PRUF-UPDTE-FACTOR PIC 9(01)V9(05)
    private CobolDecimal pNewPrufUpdteFactor;
    // P-NEW-DSH-PERCENT PIC V9(04)
    private CobolDecimal pNewDshPercent;
    // P-NEW-FYE-DATE PIC X(08)
    private CobolText pNewFyeDate;
    // P-NEW-PASS-AMT-CAPITAL PIC 9(04)V99
    private CobolDecimal pNewPassAmtCapital;
    // P-NEW-PASS-AMT-DIR-MED-ED PIC 9(04)V99
    private CobolDecimal pNewPassAmtDirMedEd;
    // P-NEW-PASS-AMT-ORGAN-ACQ PIC 9(04)V99
    private CobolDecimal pNewPassAmtOrganAcq;
    // P-NEW-PASS-AMT-PLUS-MISC PIC 9(04)V99
    private CobolDecimal pNewPassAmtPlusMisc;
    // P-NEW-CAPI-PPS-PAY-CODE PIC X
    private CobolText pNewCapiPpsPayCode;
    // P-NEW-CAPI-HOSP-SPEC-RATE PIC 9(04)V99
    private CobolDecimal pNewCapiHospSpecRate;
    // P-NEW-CAPI-OLD-HARM-RATE PIC 9(04)V99
    private CobolDecimal pNewCapiOldHarmRate;
    // P-NEW-CAPI-NEW-HARM-RATIO PIC 9(01)V9999
    private CobolDecimal pNewCapiNewHarmRatio;
    // P-NEW-CAPI-CSTCHG-RATIO PIC 9V999
    private CobolDecimal pNewCapiCstchgRatio;
    // P-NEW-CAPI-NEW-HOSP PIC X
    private CobolText pNewCapiNewHosp;
    // P-NEW-CAPI-IME PIC 9V9999
    private CobolDecimal pNewCapiIme;
    // P-NEW-CAPI-EXCEPTIONS PIC 9(04)V99
    private CobolDecimal pNewCapiExceptions;
    // W-MSA PIC X(4)
    private CobolText wMsa;
    // W-EFF-DATE PIC X(8)
    private CobolText wEffDate;
    // W-WAGE-INDEX1 PIC S9(02)V9(04)
    private CobolDecimal wWageIndex1;
    // W-WAGE-INDEX2 PIC S9(02)V9(04)
    private CobolDecimal wWageIndex2;
    // W-WAGE-INDEX3 PIC S9(02)V9(04)
    private CobolDecimal wWageIndex3;
    // PROGRAM-CONSTANTS (group, 40 bytes)
    private CobolText programConstants;
    // W-DRG-FILLS (group, 5632 bytes)
    private CobolText wDrgFills;
    // W-DRG-TABLE (group, 5632 bytes)
    private CobolText wDrgTable;
    // WWM-ENTRY (group, 11 bytes)
    private CobolText[] wwmEntry;
    // HOLD-PPS-COMPONENTS (group, 85 bytes)
    private CobolText holdPpsComponents;
    // BILL-NEW-DATA (group, 60 bytes)
    private CobolText billNewData;
    // B-NPI10 (group, 10 bytes)
    private CobolText bNpi10;
    // B-DISCHARGE-DATE (group, 8 bytes)
    private CobolText bDischargeDate;
    // PPS-DATA-ALL (group, 182 bytes)
    private CobolText ppsDataAll;
    // PPS-DATA (group, 107 bytes)
    private CobolText ppsData;
    // PPS-OTHER-DATA (group, 43 bytes)
    private CobolText ppsOtherData;
    // PPS-PC-DATA (group, 21 bytes)
    private CobolText ppsPcData;
    // PRICER-OPT-VERS-SW (group, 6 bytes)
    private CobolText pricerOptVersSw;
    // PPS-VERSIONS (group, 5 bytes)
    private CobolText ppsVersions;
    // PROV-NEW-HOLD (group, 240 bytes)
    private CobolText provNewHold;
    // PROV-NEWREC-HOLD1 (group, 80 bytes)
    private CobolText provNewrecHold1;
    // P-NEW-NPI10 (group, 10 bytes)
    private CobolText pNewNpi10;
    // P-NEW-PROVIDER-NO (group, 6 bytes)
    private CobolText pNewProviderNo;
    // P-NEW-DATE-DATA (group, 32 bytes)
    private CobolText pNewDateData;
    // P-NEW-EFF-DATE (group, 8 bytes)
    private CobolText pNewEffDate;
    // P-NEW-FY-BEGIN-DATE (group, 8 bytes)
    private CobolText pNewFyBeginDate;
    // P-NEW-REPORT-DATE (group, 8 bytes)
    private CobolText pNewReportDate;
    // P-NEW-TERMINATION-DATE (group, 8 bytes)
    private CobolText pNewTerminationDate;
    // P-NEW-MSA-DATA (group, 13 bytes)
    private CobolText pNewMsaData;
    // P-NEW-STAND-AMT-LOC-MSA9 (group, 4 bytes)
    private CobolText pNewStandAmtLocMsa9;
    // P-NEW-RURAL-1ST (group, 2 bytes)
    private CobolText pNewRural1st;
    // PROV-NEWREC-HOLD2 (group, 80 bytes)
    private CobolText provNewrecHold2;
    // P-NEW-VARIABLES (group, 57 bytes)
    private CobolText pNewVariables;
    // PROV-NEWREC-HOLD3 (group, 80 bytes)
    private CobolText provNewrecHold3;
    // P-NEW-PASS-AMT-DATA (group, 24 bytes)
    private CobolText pNewPassAmtData;
    // P-NEW-CAPI-DATA (group, 34 bytes)
    private CobolText pNewCapiData;
    // WAGE-NEW-INDEX-RECORD (group, 30 bytes)
    private CobolText wageNewIndexRecord;

    private void cocoonInit0() {
        wStorageRef = new CobolText(r_W_STORAGE_REF, 0, 46);
        calVersion = new CobolText(r_CAL_VERSION, 0, 5);
        fedFyBegin03 = new CobolDecimal(r_PROGRAM_CONSTANTS, 0, 8, 8, 0, false, 0, 0);
        fedFyBegin04 = new CobolDecimal(r_PROGRAM_CONSTANTS, 8, 8, 8, 0, false, 0, 0);
        fedFyBegin05 = new CobolDecimal(r_PROGRAM_CONSTANTS, 16, 8, 8, 0, false, 0, 0);
        fedFyBegin06 = new CobolDecimal(r_PROGRAM_CONSTANTS, 24, 8, 8, 0, false, 0, 0);
        fedFyBegin07 = new CobolDecimal(r_PROGRAM_CONSTANTS, 32, 8, 8, 0, false, 0, 0);
        pic = new CobolText(r_W_DRG_FILLS, 0, 44);
        wwmDrg = CobolText.table(r_W_DRG_TABLE, 0, 11, 512, 3);
        wwmRelwt = CobolDecimal.table(r_W_DRG_TABLE, 3, 11, 512, 5, 1, 4, false, 0, 0);
        wwmAlos = CobolDecimal.table(r_W_DRG_TABLE, 8, 11, 512, 3, 2, 1, false, 0, 0);
        hLos = new CobolDecimal(r_HOLD_PPS_COMPONENTS, 0, 3, 3, 0, false, 0, 0);
        hRegDays = new CobolDecimal(r_HOLD_PPS_COMPONENTS, 3, 3, 3, 0, false, 0, 0);
        hTotalDays = new CobolDecimal(r_HOLD_PPS_COMPONENTS, 6, 5, 5, 0, false, 0, 0);
        hSsot = new CobolDecimal(r_HOLD_PPS_COMPONENTS, 11, 2, 2, 0, false, 0, 0);
        hBlendRtc = new CobolDecimal(r_HOLD_PPS_COMPONENTS, 13, 2, 2, 0, false, 0, 0);
        hBlendFac = new CobolDecimal(r_HOLD_PPS_COMPONENTS, 15, 2, 1, 1, false, 0, 0);
        hBlendPps = new CobolDecimal(r_HOLD_PPS_COMPONENTS, 17, 2, 1, 1, false, 0, 0);
        hSsPayAmt = new CobolDecimal(r_HOLD_PPS_COMPONENTS, 19, 9, 7, 2, false, 0, 0);
        hSsCost = new CobolDecimal(r_HOLD_PPS_COMPONENTS, 28, 9, 7, 2, false, 0, 0);
        hLaborPortion = new CobolDecimal(r_HOLD_PPS_COMPONENTS, 37, 13, 7, 6, false, 0, 0);
        hNonlaborPortion = new CobolDecimal(r_HOLD_PPS_COMPONENTS, 50, 13, 7, 6, false, 0, 0);
        hFixedLossAmt = new CobolDecimal(r_HOLD_PPS_COMPONENTS, 63, 9, 7, 2, false, 0, 0);
        hNewFacSpecRate = new CobolDecimal(r_HOLD_PPS_COMPONENTS, 72, 7, 5, 2, false, 0, 0);
        hLosRatio = new CobolDecimal(r_HOLD_PPS_COMPONENTS, 79, 6, 1, 5, false, 0, 0);
        bNpi8 = new CobolText(r_BILL_NEW_DATA, 0, 8);
        bNpiFiller = new CobolText(r_BILL_NEW_DATA, 8, 2);
        bProviderNo = new CobolText(r_BILL_NEW_DATA, 10, 6);
        bPatientStatus = new CobolText(r_BILL_NEW_DATA, 16, 2);
        bDrgCode = new CobolText(r_BILL_NEW_DATA, 18, 3);
        bLos = new CobolDecimal(r_BILL_NEW_DATA, 21, 3, 3, 0, false, 0, 0);
        bCovDays = new CobolDecimal(r_BILL_NEW_DATA, 24, 3, 3, 0, false, 0, 0);
        bLtrDays = new CobolDecimal(r_BILL_NEW_DATA, 27, 2, 2, 0, false, 0, 0);
        bDischgCc = new CobolDecimal(r_BILL_NEW_DATA, 29, 2, 2, 0, false, 0, 0);
        bDischgYy = new CobolDecimal(r_BILL_NEW_DATA, 31, 2, 2, 0, false, 0, 0);
        bDischgMm = new CobolDecimal(r_BILL_NEW_DATA, 33, 2, 2, 0, false, 0, 0);
        bDischgDd = new CobolDecimal(r_BILL_NEW_DATA, 35, 2, 2, 0, false, 0, 0);
        bCovCharges = new CobolDecimal(r_BILL_NEW_DATA, 37, 9, 7, 2, false, 0, 0);
        bSpecPayInd = new CobolText(r_BILL_NEW_DATA, 46, 1);
        filler = new CobolText(22);
        ppsRtc = new CobolDecimal(r_PPS_DATA_ALL, 0, 2, 2, 0, false, 0, 0);
        ppsChrgThreshold = new CobolDecimal(r_PPS_DATA_ALL, 2, 9, 7, 2, false, 0, 0);
        ppsMsa = new CobolText(r_PPS_DATA_ALL, 11, 4);
        ppsWageIndex = new CobolDecimal(r_PPS_DATA_ALL, 15, 6, 2, 4, false, 0, 0);
        ppsAvgLos = new CobolDecimal(r_PPS_DATA_ALL, 21, 3, 2, 1, false, 0, 0);
        ppsRelativeWgt = new CobolDecimal(r_PPS_DATA_ALL, 24, 5, 1, 4, false, 0, 0);
        ppsOutlierPayAmt = new CobolDecimal(r_PPS_DATA_ALL, 29, 9, 7, 2, false, 0, 0);
        ppsLos = new CobolDecimal(r_PPS_DATA_ALL, 38, 3, 3, 0, false, 0, 0);
        ppsDrgAdjPayAmt = new CobolDecimal(r_PPS_DATA_ALL, 41, 9, 7, 2, false, 0, 0);
        ppsFedPayAmt = new CobolDecimal(r_PPS_DATA_ALL, 50, 9, 7, 2, false, 0, 0);
        ppsFinalPayAmt = new CobolDecimal(r_PPS_DATA_ALL, 59, 9, 7, 2, false, 0, 0);
        ppsFacCosts = new CobolDecimal(r_PPS_DATA_ALL, 68, 9, 7, 2, false, 0, 0);
        ppsNewFacSpecRate = new CobolDecimal(r_PPS_DATA_ALL, 77, 9, 7, 2, false, 0, 0);
        ppsOutlierThreshold = new CobolDecimal(r_PPS_DATA_ALL, 86, 9, 7, 2, false, 0, 0);
        ppsSubmDrgCode = new CobolText(r_PPS_DATA_ALL, 95, 3);
        ppsCalcVersCd = new CobolText(r_PPS_DATA_ALL, 98, 5);
        ppsRegDaysUsed = new CobolDecimal(r_PPS_DATA_ALL, 103, 3, 3, 0, false, 0, 0);
        ppsLtrDaysUsed = new CobolDecimal(r_PPS_DATA_ALL, 106, 3, 3, 0, false, 0, 0);
        ppsBlendYear = new CobolDecimal(r_PPS_DATA_ALL, 109, 1, 1, 0, false, 0, 0);
        ppsCola = new CobolDecimal(r_PPS_DATA_ALL, 110, 4, 1, 3, false, 0, 0);
        ppsNatLaborPct = new CobolDecimal(r_PPS_DATA_ALL, 118, 6, 1, 5, false, 0, 0);
        ppsNatNonlaborPct = new CobolDecimal(r_PPS_DATA_ALL, 124, 6, 1, 5, false, 0, 0);
        ppsStdFedRate = new CobolDecimal(r_PPS_DATA_ALL, 130, 7, 5, 2, false, 0, 0);
        ppsBdgtNeutRate = new CobolDecimal(r_PPS_DATA_ALL, 137, 4, 1, 3, false, 0, 0);
        ppsCotInd = new CobolText(r_PPS_DATA_ALL, 161, 1);
        pricerOptionSw = new CobolText(r_PRICER_OPT_VERS_SW, 0, 1);
        ppdrvVersion = new CobolText(r_PRICER_OPT_VERS_SW, 1, 5);
        pNewNpi8 = new CobolText(r_PROV_NEW_HOLD, 0, 8);
        pNewNpiFiller = new CobolText(r_PROV_NEW_HOLD, 8, 2);
        pNewState = new CobolDecimal(r_PROV_NEW_HOLD, 10, 2, 2, 0, false, 0, 0);
        pNewEffDtCc = new CobolDecimal(r_PROV_NEW_HOLD, 16, 2, 2, 0, false, 0, 0);
        pNewEffDtYy = new CobolDecimal(r_PROV_NEW_HOLD, 18, 2, 2, 0, false, 0, 0);
        pNewEffDtMm = new CobolDecimal(r_PROV_NEW_HOLD, 20, 2, 2, 0, false, 0, 0);
        pNewEffDtDd = new CobolDecimal(r_PROV_NEW_HOLD, 22, 2, 2, 0, false, 0, 0);
        pNewFyBegDtCc = new CobolDecimal(r_PROV_NEW_HOLD, 24, 2, 2, 0, false, 0, 0);
        pNewFyBegDtYy = new CobolDecimal(r_PROV_NEW_HOLD, 26, 2, 2, 0, false, 0, 0);
        pNewFyBegDtMm = new CobolDecimal(r_PROV_NEW_HOLD, 28, 2, 2, 0, false, 0, 0);
        pNewFyBegDtDd = new CobolDecimal(r_PROV_NEW_HOLD, 30, 2, 2, 0, false, 0, 0);
        pNewReportDtCc = new CobolDecimal(r_PROV_NEW_HOLD, 32, 2, 2, 0, false, 0, 0);
        pNewReportDtYy = new CobolDecimal(r_PROV_NEW_HOLD, 34, 2, 2, 0, false, 0, 0);
        pNewReportDtMm = new CobolDecimal(r_PROV_NEW_HOLD, 36, 2, 2, 0, false, 0, 0);
        pNewReportDtDd = new CobolDecimal(r_PROV_NEW_HOLD, 38, 2, 2, 0, false, 0, 0);
        pNewTermDtCc = new CobolDecimal(r_PROV_NEW_HOLD, 40, 2, 2, 0, false, 0, 0);
        pNewTermDtYy = new CobolDecimal(r_PROV_NEW_HOLD, 42, 2, 2, 0, false, 0, 0);
        pNewTermDtMm = new CobolDecimal(r_PROV_NEW_HOLD, 44, 2, 2, 0, false, 0, 0);
        pNewTermDtDd = new CobolDecimal(r_PROV_NEW_HOLD, 46, 2, 2, 0, false, 0, 0);
        pNewWaiverCode = new CobolText(r_PROV_NEW_HOLD, 48, 1);
        pNewInterNo = new CobolDecimal(r_PROV_NEW_HOLD, 49, 5, 5, 0, false, 0, 0);
        pNewProviderType = new CobolText(r_PROV_NEW_HOLD, 54, 2);
        pNewCurrentCensusDiv = new CobolDecimal(r_PROV_NEW_HOLD, 56, 1, 1, 0, false, 0, 0);
        pNewCurrentDiv = new CobolDecimal(r_PROV_NEW_HOLD, 56, 1, 1, 0, false, 0, 0);
        pNewChgCodeIndex = new CobolText(r_PROV_NEW_HOLD, 57, 1);
        pNewGeoLocMsax = new CobolText(r_PROV_NEW_HOLD, 58, 4);
        pNewGeoLocMsa9 = new CobolDecimal(r_PROV_NEW_HOLD, 58, 4, 4, 0, false, 0, 0);
        pNewWageIndexLocMsa = new CobolText(r_PROV_NEW_HOLD, 62, 4);
        pNewStandAmtLocMsa = new CobolText(r_PROV_NEW_HOLD, 66, 4);
        pNewStandRural = new CobolText(r_PROV_NEW_HOLD, 66, 2);
        pNewRural2nd = new CobolText(r_PROV_NEW_HOLD, 68, 2);
        pNewSolComDepHospYr = new CobolText(r_PROV_NEW_HOLD, 70, 2);
        pNewLugar = new CobolText(r_PROV_NEW_HOLD, 72, 1);
        pNewTempReliefInd = new CobolText(r_PROV_NEW_HOLD, 73, 1);
        pNewFedPpsBlendInd = new CobolText(r_PROV_NEW_HOLD, 74, 1);
        pNewFacSpecRate = new CobolDecimal(r_PROV_NEW_HOLD, 80, 7, 5, 2, false, 0, 0);
        pNewCola = new CobolDecimal(r_PROV_NEW_HOLD, 87, 4, 1, 3, false, 0, 0);
        pNewInternRatio = new CobolDecimal(r_PROV_NEW_HOLD, 91, 5, 1, 4, false, 0, 0);
        pNewBedSize = new CobolDecimal(r_PROV_NEW_HOLD, 96, 5, 5, 0, false, 0, 0);
        pNewOperCstchgRatio = new CobolDecimal(r_PROV_NEW_HOLD, 101, 4, 1, 3, false, 0, 0);
        pNewCmi = new CobolDecimal(r_PROV_NEW_HOLD, 105, 5, 1, 4, false, 0, 0);
        pNewSsiRatio = new CobolDecimal(r_PROV_NEW_HOLD, 110, 4, 0, 4, false, 0, 0);
        pNewMedicaidRatio = new CobolDecimal(r_PROV_NEW_HOLD, 114, 4, 0, 4, false, 0, 0);
        pNewPpsBlendYrInd = new CobolDecimal(r_PROV_NEW_HOLD, 118, 1, 1, 0, false, 0, 0);
        pNewPrufUpdteFactor = new CobolDecimal(r_PROV_NEW_HOLD, 119, 6, 1, 5, false, 0, 0);
        pNewDshPercent = new CobolDecimal(r_PROV_NEW_HOLD, 125, 4, 0, 4, false, 0, 0);
        pNewFyeDate = new CobolText(r_PROV_NEW_HOLD, 129, 8);
        pNewPassAmtCapital = new CobolDecimal(r_PROV_NEW_HOLD, 160, 6, 4, 2, false, 0, 0);
        pNewPassAmtDirMedEd = new CobolDecimal(r_PROV_NEW_HOLD, 166, 6, 4, 2, false, 0, 0);
        pNewPassAmtOrganAcq = new CobolDecimal(r_PROV_NEW_HOLD, 172, 6, 4, 2, false, 0, 0);
        pNewPassAmtPlusMisc = new CobolDecimal(r_PROV_NEW_HOLD, 178, 6, 4, 2, false, 0, 0);
        pNewCapiPpsPayCode = new CobolText(r_PROV_NEW_HOLD, 184, 1);
        pNewCapiHospSpecRate = new CobolDecimal(r_PROV_NEW_HOLD, 185, 6, 4, 2, false, 0, 0);
        pNewCapiOldHarmRate = new CobolDecimal(r_PROV_NEW_HOLD, 191, 6, 4, 2, false, 0, 0);
        pNewCapiNewHarmRatio = new CobolDecimal(r_PROV_NEW_HOLD, 197, 5, 1, 4, false, 0, 0);
        pNewCapiCstchgRatio = new CobolDecimal(r_PROV_NEW_HOLD, 202, 4, 1, 3, false, 0, 0);
        pNewCapiNewHosp = new CobolText(r_PROV_NEW_HOLD, 206, 1);
        pNewCapiIme = new CobolDecimal(r_PROV_NEW_HOLD, 207, 5, 1, 4, false, 0, 0);
        pNewCapiExceptions = new CobolDecimal(r_PROV_NEW_HOLD, 212, 6, 4, 2, false, 0, 0);
        wMsa = new CobolText(r_WAGE_NEW_INDEX_RECORD, 0, 4);
        wEffDate = new CobolText(r_WAGE_NEW_INDEX_RECORD, 4, 8);
        wWageIndex1 = new CobolDecimal(r_WAGE_NEW_INDEX_RECORD, 12, 6, 2, 4, true, 0, 0);
        wWageIndex2 = new CobolDecimal(r_WAGE_NEW_INDEX_RECORD, 18, 6, 2, 4, true, 0, 0);
        wWageIndex3 = new CobolDecimal(r_WAGE_NEW_INDEX_RECORD, 24, 6, 2, 4, true, 0, 0);
        programConstants = new CobolText(r_PROGRAM_CONSTANTS, 0, 40);
        wDrgFills = new CobolText(r_W_DRG_FILLS, 0, 5632);
        wDrgTable = new CobolText(r_W_DRG_TABLE, 0, 5632);
        wwmEntry = CobolText.table(r_W_DRG_TABLE, 0, 11, 512, 11);
        holdPpsComponents = new CobolText(r_HOLD_PPS_COMPONENTS, 0, 85);
        billNewData = new CobolText(r_BILL_NEW_DATA, 0, 60);
        bNpi10 = new CobolText(r_BILL_NEW_DATA, 0, 10);
        bDischargeDate = new CobolText(r_BILL_NEW_DATA, 29, 8);
        ppsDataAll = new CobolText(r_PPS_DATA_ALL, 0, 182);
        ppsData = new CobolText(r_PPS_DATA_ALL, 11, 107);
        ppsOtherData = new CobolText(r_PPS_DATA_ALL, 118, 43);
        ppsPcData = new CobolText(r_PPS_DATA_ALL, 161, 21);
        pricerOptVersSw = new CobolText(r_PRICER_OPT_VERS_SW, 0, 6);
        ppsVersions = new CobolText(r_PRICER_OPT_VERS_SW, 1, 5);
        provNewHold = new CobolText(r_PROV_NEW_HOLD, 0, 240);
        provNewrecHold1 = new CobolText(r_PROV_NEW_HOLD, 0, 80);
        pNewNpi10 = new CobolText(r_PROV_NEW_HOLD, 0, 10);
        pNewProviderNo = new CobolText(r_PROV_NEW_HOLD, 10, 6);
        pNewDateData = new CobolText(r_PROV_NEW_HOLD, 16, 32);
        pNewEffDate = new CobolText(r_PROV_NEW_HOLD, 16, 8);
        pNewFyBeginDate = new CobolText(r_PROV_NEW_HOLD, 24, 8);
        pNewReportDate = new CobolText(r_PROV_NEW_HOLD, 32, 8);
        pNewTerminationDate = new CobolText(r_PROV_NEW_HOLD, 40, 8);
        pNewMsaData = new CobolText(r_PROV_NEW_HOLD, 57, 13);
        pNewStandAmtLocMsa9 = new CobolText(r_PROV_NEW_HOLD, 66, 4);
        pNewRural1st = new CobolText(r_PROV_NEW_HOLD, 66, 2);
        provNewrecHold2 = new CobolText(r_PROV_NEW_HOLD, 80, 80);
        pNewVariables = new CobolText(r_PROV_NEW_HOLD, 80, 57);
        provNewrecHold3 = new CobolText(r_PROV_NEW_HOLD, 160, 80);
        pNewPassAmtData = new CobolText(r_PROV_NEW_HOLD, 160, 24);
        pNewCapiData = new CobolText(r_PROV_NEW_HOLD, 184, 34);
        wageNewIndexRecord = new CobolText(r_WAGE_NEW_INDEX_RECORD, 0, 30);
    }

    public Ltcal059() {
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
    private int wwmIndx = 1;   // WWM-INDX, of WWM-ENTRY

    public void run() {
        try {
            cocoonPerform(0, 24);
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
            if (p >= 25) {
                throw COCOON_STOP;   // the end of the program
            }
        }
    }

    private void cocoonParagraph(int p) {
        switch (p) {
            case 0: p0000MainlineControl(); return;   // 0000-MAINLINE-CONTROL
            case 1: p0100InitialRoutine(); return;   // 0100-INITIAL-ROUTINE
            case 2: p0100Exit(); return;   // 0100-EXIT
            case 3: p1000EditTheBillInfo(); return;   // 1000-EDIT-THE-BILL-INFO
            case 4: p1000Exit(); return;   // 1000-EXIT
            case 5: p1200DaysUsed(); return;   // 1200-DAYS-USED
            case 6: p1200DaysUsedExit(); return;   // 1200-DAYS-USED-EXIT
            case 7: p1700EditDrgCode(); return;   // 1700-EDIT-DRG-CODE
            case 8: p1700Exit(); return;   // 1700-EXIT
            case 9: p1750FindValue(); return;   // 1750-FIND-VALUE
            case 10: p1750Exit(); return;   // 1750-EXIT
            case 11: p2000AssemblePpsVariables(); return;   // 2000-ASSEMBLE-PPS-VARIABLES
            case 12: p2000Exit(); return;   // 2000-EXIT
            case 13: p3000CalcPayment(); return;   // 3000-CALC-PAYMENT
            case 14: p3000Exit(); return;   // 3000-EXIT
            case 15: p3400ShortStay(); return;   // 3400-SHORT-STAY
            case 16: p3400ShortStayExit(); return;   // 3400-SHORT-STAY-EXIT
            case 17: p4000SpecialProvider(); return;   // 4000-SPECIAL-PROVIDER
            case 18: p4000SpecialProviderExit(); return;   // 4000-SPECIAL-PROVIDER-EXIT
            case 19: p7000CalcOutlier(); return;   // 7000-CALC-OUTLIER
            case 20: p7000Exit(); return;   // 7000-EXIT
            case 21: p8000Blend(); return;   // 8000-BLEND
            case 22: p8000Exit(); return;   // 8000-EXIT
            case 23: p9000MoveResults(); return;   // 9000-MOVE-RESULTS
            case 24: p9000Exit(); return;   // 9000-EXIT
            default: throw COCOON_STOP;
        }
    }

    /** 0000-MAINLINE-CONTROL */
    private void p0000MainlineControl() {
        cocoonPerform(1, 2);   // PERFORM 0100-INITIAL-ROUTINE THRU 0100-EXIT
        cocoonPerform(3, 4);   // PERFORM 1000-EDIT-THE-BILL-INFO THRU 1000-EXIT
        if (ppsRtc.value().compareTo(new BigDecimal("00")) == 0) {
            cocoonPerform(7, 8);   // PERFORM 1700-EDIT-DRG-CODE THRU 1700-EXIT
        }
        if (ppsRtc.value().compareTo(new BigDecimal("00")) == 0) {
            cocoonPerform(11, 12);   // PERFORM 2000-ASSEMBLE-PPS-VARIABLES THRU 2000-EXIT
        }
        if (ppsRtc.value().compareTo(new BigDecimal("00")) == 0) {
            cocoonPerform(13, 14);   // PERFORM 3000-CALC-PAYMENT THRU 3000-EXIT
            cocoonPerform(19, 20);   // PERFORM 7000-CALC-OUTLIER THRU 7000-EXIT
        }
        if (ppsRtc.value().compareTo(new BigDecimal("50")) < 0) {
            cocoonPerform(21, 22);   // PERFORM 8000-BLEND THRU 8000-EXIT
        }
        cocoonPerform(23, 24);   // PERFORM 9000-MOVE-RESULTS THRU 9000-EXIT
        cocoonStop();   // GOBACK
    }

    /** 0100-INITIAL-ROUTINE */
    private void p0100InitialRoutine() {
        ppsRtc.store(BigDecimal.ZERO);
        ppsMsa.store(" ");
        ppsWageIndex.store(BigDecimal.ZERO);
        ppsAvgLos.store(BigDecimal.ZERO);
        ppsRelativeWgt.store(BigDecimal.ZERO);
        ppsOutlierPayAmt.store(BigDecimal.ZERO);
        ppsLos.store(BigDecimal.ZERO);
        ppsDrgAdjPayAmt.store(BigDecimal.ZERO);
        ppsFedPayAmt.store(BigDecimal.ZERO);
        ppsFinalPayAmt.store(BigDecimal.ZERO);
        ppsFacCosts.store(BigDecimal.ZERO);
        ppsNewFacSpecRate.store(BigDecimal.ZERO);
        ppsOutlierThreshold.store(BigDecimal.ZERO);
        ppsSubmDrgCode.store(" ");
        ppsCalcVersCd.store(" ");
        ppsRegDaysUsed.store(BigDecimal.ZERO);
        ppsLtrDaysUsed.store(BigDecimal.ZERO);
        ppsBlendYear.store(BigDecimal.ZERO);
        ppsCola.store(BigDecimal.ZERO);
        filler.store(" ");
        ppsNatLaborPct.store(BigDecimal.ZERO);
        ppsNatNonlaborPct.store(BigDecimal.ZERO);
        ppsStdFedRate.store(BigDecimal.ZERO);
        ppsBdgtNeutRate.store(BigDecimal.ZERO);
        filler.store(" ");
        hLos.store(BigDecimal.ZERO);
        hRegDays.store(BigDecimal.ZERO);
        hTotalDays.store(BigDecimal.ZERO);
        hSsot.store(BigDecimal.ZERO);
        hBlendRtc.store(BigDecimal.ZERO);
        hBlendFac.store(BigDecimal.ZERO);
        hBlendPps.store(BigDecimal.ZERO);
        hSsPayAmt.store(BigDecimal.ZERO);
        hSsCost.store(BigDecimal.ZERO);
        hLaborPortion.store(BigDecimal.ZERO);
        hNonlaborPortion.store(BigDecimal.ZERO);
        hFixedLossAmt.store(BigDecimal.ZERO);
        hNewFacSpecRate.store(BigDecimal.ZERO);
        hLosRatio.store(BigDecimal.ZERO);
        ppsNatLaborPct.store(new BigDecimal(".72885"));
        ppsNatNonlaborPct.store(new BigDecimal(".27115"));
        ppsStdFedRate.store(new BigDecimal("36833.69"));
        hFixedLossAmt.store(new BigDecimal("17864"));
        ppsBdgtNeutRate.store(new BigDecimal("0.995"));
    }

    /** 0100-EXIT */
    private void p0100Exit() {
        // nothing translatable here
    }

    /** 1000-EDIT-THE-BILL-INFO */
    private void p1000EditTheBillInfo() {
        if (bLos.isNumeric() && bLos.value().compareTo(new BigDecimal("0")) > 0) {
            hLos.store(bLos.value());
        } else {
            ppsRtc.store(new BigDecimal("56"));
        }
        if (ppsRtc.value().compareTo(new BigDecimal("00")) == 0) {
            if (!pNewCola.isNumeric()) {
                ppsRtc.store(new BigDecimal("50"));
            }
        }
        if (ppsRtc.value().compareTo(new BigDecimal("00")) == 0) {
            if (pNewWaiverCode.value().compareTo("Y") == 0) {
                ppsRtc.store(new BigDecimal("53"));
            }
        }
        if (ppsRtc.value().compareTo(new BigDecimal("00")) == 0) {
            if (bDischargeDate.value().compareTo(pNewEffDate.value()) < 0 || bDischargeDate.value().compareTo(wEffDate.value()) < 0) {
                ppsRtc.store(new BigDecimal("55"));
            }
        }
        if (ppsRtc.value().compareTo(new BigDecimal("00")) == 0) {
            if (CobolText.compareAlnum(pNewTerminationDate.value(), "00000000") > 0) {
                if (bDischargeDate.value().compareTo(pNewTerminationDate.value()) >= 0) {
                    ppsRtc.store(new BigDecimal("51"));
                }
            }
        }
        if (ppsRtc.value().compareTo(new BigDecimal("00")) == 0) {
            if (!bCovCharges.isNumeric()) {
                ppsRtc.store(new BigDecimal("58"));
            }
        }
        if (ppsRtc.value().compareTo(new BigDecimal("00")) == 0) {
            if (!bLtrDays.isNumeric() || bLtrDays.value().compareTo(new BigDecimal("60")) > 0) {
                ppsRtc.store(new BigDecimal("61"));
            }
        }
        if (ppsRtc.value().compareTo(new BigDecimal("00")) == 0) {
            if (!bCovDays.isNumeric() || bCovDays.value().compareTo(new BigDecimal("0")) == 0 && hLos.value().compareTo(new BigDecimal("0")) > 0) {
                ppsRtc.store(new BigDecimal("62"));
            }
        }
        if (ppsRtc.value().compareTo(new BigDecimal("00")) == 0) {
            if (bLtrDays.value().compareTo(bCovDays.value()) > 0) {
                ppsRtc.store(new BigDecimal("62"));
            }
        }
        if (ppsRtc.value().compareTo(new BigDecimal("00")) == 0) {
            hRegDays.store(bCovDays.value().subtract(bLtrDays.value()));
            hTotalDays.store(hRegDays.value().add(bLtrDays.value()));
        }
        if (ppsRtc.value().compareTo(new BigDecimal("00")) == 0) {
            cocoonPerform(5, 6);   // PERFORM 1200-DAYS-USED THRU 1200-DAYS-USED-EXIT
        }
    }

    /** 1000-EXIT */
    private void p1000Exit() {
        // nothing translatable here
    }

    /** 1200-DAYS-USED */
    private void p1200DaysUsed() {
        if (bLtrDays.value().compareTo(new BigDecimal("0")) > 0 && hRegDays.value().compareTo(new BigDecimal("0")) == 0) {
            if (bLtrDays.value().compareTo(hLos.value()) > 0) {
                ppsLtrDaysUsed.store(hLos.value());
            } else {
                ppsLtrDaysUsed.store(bLtrDays.value());
            }
        } else {
            if (hRegDays.value().compareTo(new BigDecimal("0")) > 0 && bLtrDays.value().compareTo(new BigDecimal("0")) == 0) {
                if (hRegDays.value().compareTo(hLos.value()) > 0) {
                    ppsRegDaysUsed.store(hLos.value());
                } else {
                    ppsRegDaysUsed.store(hRegDays.value());
                }
            } else {
                if (hRegDays.value().compareTo(new BigDecimal("0")) > 0 && bLtrDays.value().compareTo(new BigDecimal("0")) > 0) {
                    if (hRegDays.value().compareTo(hLos.value()) > 0) {
                        ppsRegDaysUsed.store(hLos.value());
                        ppsLtrDaysUsed.store(new BigDecimal("0"));
                    } else {
                        if (hTotalDays.value().compareTo(hLos.value()) > 0) {
                            ppsRegDaysUsed.store(hRegDays.value());
                            ppsLtrDaysUsed.store(hLos.value().subtract(hRegDays.value()));
                        } else {
                            if (hTotalDays.value().compareTo(hLos.value()) <= 0) {
                                ppsRegDaysUsed.store(hRegDays.value());
                                ppsLtrDaysUsed.store(bLtrDays.value());
                            } else {
                            }
                        }
                    }
                } else {
                }
            }
        }
    }

    /** 1200-DAYS-USED-EXIT */
    private void p1200DaysUsedExit() {
        // nothing translatable here
    }

    /** 1700-EDIT-DRG-CODE */
    private void p1700EditDrgCode() {
        ppsSubmDrgCode.store(bDrgCode.value());
        if (ppsRtc.value().compareTo(new BigDecimal("00")) == 0) {
            {   // SEARCH ALL WWM-ENTRY, as GnuCOBOL runs it
                int cocoonHead1 = 0, cocoonTail1 = 512 + 1;
                while (true) {
                    if (cocoonHead1 >= cocoonTail1 - 1) {
                        ppsRtc.store(new BigDecimal("54"));
                        break;
                    }
                    wwmIndx = (cocoonHead1 + cocoonTail1) / 2;
                    int cocoonRet1 = wwmDrg[wwmIndx - 1].value().compareTo(ppsSubmDrgCode.value());
                    if (cocoonRet1 == 0) {
                        cocoonPerform(9, 10);   // PERFORM 1750-FIND-VALUE THRU 1750-EXIT
                        break;
                    }
                    if (cocoonRet1 < 0) {
                        cocoonHead1 = wwmIndx;
                    } else {
                        cocoonTail1 = wwmIndx;
                    }
                }
            }
        }
    }

    /** 1700-EXIT */
    private void p1700Exit() {
        // nothing translatable here
    }

    /** 1750-FIND-VALUE */
    private void p1750FindValue() {
        ppsRelativeWgt.store(wwmRelwt[wwmIndx - 1].value());
        ppsAvgLos.store(wwmAlos[wwmIndx - 1].value());
    }

    /** 1750-EXIT */
    private void p1750Exit() {
        // nothing translatable here
    }

    /** 2000-ASSEMBLE-PPS-VARIABLES */
    private void p2000AssemblePpsVariables() {
        if (CobolText.compareAlnum(pNewFyBeginDate.value(), fedFyBegin05.display()) >= 0) {
            if (bDischargeDate.value().compareTo(pNewFyBeginDate.value()) >= 0) {
                if (wWageIndex3.isNumeric() && wWageIndex3.value().compareTo(new BigDecimal("0")) > 0) {
                    ppsWageIndex.store(wWageIndex3.value());
                } else {
                    ppsRtc.store(new BigDecimal("52"));
                    cocoonGoTo(12);   // GO TO 2000-EXIT
                }
            } else {
                if (wWageIndex2.isNumeric() && wWageIndex2.value().compareTo(new BigDecimal("0")) > 0) {
                    ppsWageIndex.store(wWageIndex2.value());
                } else {
                    ppsRtc.store(new BigDecimal("52"));
                    cocoonGoTo(12);   // GO TO 2000-EXIT
                }
            }
        } else if (CobolText.compareAlnum(pNewFyBeginDate.value(), fedFyBegin05.display()) < 0 && CobolText.compareAlnum(pNewFyBeginDate.value(), fedFyBegin04.display()) >= 0) {
            if (bDischargeDate.value().compareTo(pNewFyBeginDate.value()) >= 0) {
                if (wWageIndex2.isNumeric() && wWageIndex2.value().compareTo(new BigDecimal("0")) > 0) {
                    ppsWageIndex.store(wWageIndex2.value());
                } else {
                    ppsRtc.store(new BigDecimal("52"));
                    cocoonGoTo(12);   // GO TO 2000-EXIT
                }
            } else {
                if (wWageIndex1.isNumeric() && wWageIndex1.value().compareTo(new BigDecimal("0")) > 0) {
                    ppsWageIndex.store(wWageIndex1.value());
                } else {
                    ppsRtc.store(new BigDecimal("52"));
                    cocoonGoTo(12);   // GO TO 2000-EXIT
                }
            }
        } else if (CobolText.compareAlnum(pNewFyBeginDate.value(), fedFyBegin04.display()) < 0 && CobolText.compareAlnum(pNewFyBeginDate.value(), fedFyBegin03.display()) >= 0) {
            if (wWageIndex1.isNumeric() && wWageIndex1.value().compareTo(new BigDecimal("0")) > 0) {
                ppsWageIndex.store(wWageIndex1.value());
            } else {
                ppsRtc.store(new BigDecimal("52"));
                cocoonGoTo(12);   // GO TO 2000-EXIT
            }
        } else if (CobolText.compareAlnum(pNewFyBeginDate.value(), fedFyBegin03.display()) < 0) {
            ppsRtc.store(new BigDecimal("98"));
            cocoonGoTo(12);   // GO TO 2000-EXIT
        }
        if (!pNewOperCstchgRatio.isNumeric()) {
            ppsRtc.store(new BigDecimal("65"));
        }
        ppsBlendYear.store(pNewFedPpsBlendInd.value());
        if (ppsBlendYear.value().compareTo(new BigDecimal("0")) > 0 && ppsBlendYear.value().compareTo(new BigDecimal("6")) < 0) {
        } else {
            ppsRtc.store(new BigDecimal("72"));
            cocoonGoTo(12);   // GO TO 2000-EXIT
        }
        hBlendFac.store(new BigDecimal("0"));
        hBlendPps.store(new BigDecimal("1"));
        hBlendRtc.store(new BigDecimal("0"));
        if (ppsBlendYear.value().compareTo(new BigDecimal("1")) == 0) {
            hBlendFac.store(new BigDecimal(".8"));
            hBlendPps.store(new BigDecimal(".2"));
            hBlendRtc.store(new BigDecimal("4"));
        } else {
            if (ppsBlendYear.value().compareTo(new BigDecimal("2")) == 0) {
                hBlendFac.store(new BigDecimal(".6"));
                hBlendPps.store(new BigDecimal(".4"));
                hBlendRtc.store(new BigDecimal("8"));
            } else {
                if (ppsBlendYear.value().compareTo(new BigDecimal("3")) == 0) {
                    hBlendFac.store(new BigDecimal(".4"));
                    hBlendPps.store(new BigDecimal(".6"));
                    hBlendRtc.store(new BigDecimal("12"));
                } else {
                    if (ppsBlendYear.value().compareTo(new BigDecimal("4")) == 0) {
                        hBlendFac.store(new BigDecimal(".2"));
                        hBlendPps.store(new BigDecimal(".8"));
                        hBlendRtc.store(new BigDecimal("16"));
                    }
                }
            }
        }
    }

    /** 2000-EXIT */
    private void p2000Exit() {
        // nothing translatable here
    }

    /** 3000-CALC-PAYMENT */
    private void p3000CalcPayment() {
        ppsCola.store(pNewCola.value());
        ppsFacCosts.storeRounded(pNewOperCstchgRatio.value().multiply(bCovCharges.value()));
        // TRUNCATES: the expression produces up to 8 integer digits and PPS-FAC-COSTS holds 7. The high-order digits are lost, as in the original.
        hLaborPortion.storeRounded(ppsStdFedRate.value().multiply(ppsNatLaborPct.value()).multiply(ppsWageIndex.value()));
        // TRUNCATES: the expression produces up to 8 integer digits and H-LABOR-PORTION holds 7. The high-order digits are lost, as in the original.
        hNonlaborPortion.storeRounded(ppsStdFedRate.value().multiply(ppsNatNonlaborPct.value()).multiply(ppsCola.value()));
        ppsFedPayAmt.storeRounded(hLaborPortion.value().add(hNonlaborPortion.value()));
        ppsDrgAdjPayAmt.storeRounded(ppsFedPayAmt.value().multiply(ppsRelativeWgt.value()));
        // TRUNCATES: the expression produces up to 8 integer digits and PPS-DRG-ADJ-PAY-AMT holds 7. The high-order digits are lost, as in the original.
        try {   // a zero divisor stores nothing, as in COBOL
            hSsot.store(CobolDecimal.divide(ppsAvgLos.value(), new BigDecimal("6")).multiply(new BigDecimal("5")));
        } catch (CobolDecimal.ZeroDivide cocoonZeroDivide) {
            // every receiver keeps what it held
        }
        if (hLos.value().compareTo(hSsot.value()) <= 0) {
            cocoonPerform(15, 16);   // PERFORM 3400-SHORT-STAY THRU 3400-SHORT-STAY-EXIT
        }
    }

    /** 3000-EXIT */
    private void p3000Exit() {
        // nothing translatable here
    }

    /** 3400-SHORT-STAY */
    private void p3400ShortStay() {
        if (pNewProviderNo.value().compareTo("332006") == 0) {
            cocoonPerform(17, 18);   // PERFORM 4000-SPECIAL-PROVIDER THRU 4000-SPECIAL-PROVIDER-EXIT
        } else {
            hSsCost.storeRounded(ppsFacCosts.value().multiply(new BigDecimal("1.2")));
            try {   // a zero divisor stores nothing, as in COBOL
                hSsPayAmt.storeRounded(CobolDecimal.divide(ppsDrgAdjPayAmt.value(), ppsAvgLos.value()).multiply(hLos.value()).multiply(new BigDecimal("1.2")));
                // TRUNCATES: the expression produces up to 10 integer digits and H-SS-PAY-AMT holds 7. The high-order digits are lost, as in the original.
            } catch (CobolDecimal.ZeroDivide cocoonZeroDivide) {
                // every receiver keeps what it held
            }
        }
        if (hSsCost.value().compareTo(hSsPayAmt.value()) < 0) {
            if (hSsCost.value().compareTo(ppsDrgAdjPayAmt.value()) < 0) {
                ppsDrgAdjPayAmt.store(hSsCost.value());
                ppsRtc.store(new BigDecimal("02"));
            } else {
            }
        } else {
            if (hSsPayAmt.value().compareTo(ppsDrgAdjPayAmt.value()) < 0) {
                ppsDrgAdjPayAmt.store(hSsPayAmt.value());
                ppsRtc.store(new BigDecimal("02"));
            } else {
            }
        }
    }

    /** 3400-SHORT-STAY-EXIT */
    private void p3400ShortStayExit() {
        // nothing translatable here
    }

    /** 4000-SPECIAL-PROVIDER */
    private void p4000SpecialProvider() {
        if (CobolText.compareAlnum(bDischargeDate.value(), "20030701") >= 0 && CobolText.compareAlnum(bDischargeDate.value(), "20040101") < 0) {
            hSsCost.storeRounded(ppsFacCosts.value().multiply(new BigDecimal("1.95")));
            try {   // a zero divisor stores nothing, as in COBOL
                hSsPayAmt.storeRounded(CobolDecimal.divide(ppsDrgAdjPayAmt.value(), ppsAvgLos.value()).multiply(hLos.value()).multiply(new BigDecimal("1.95")));
                // TRUNCATES: the expression produces up to 10 integer digits and H-SS-PAY-AMT holds 7. The high-order digits are lost, as in the original.
            } catch (CobolDecimal.ZeroDivide cocoonZeroDivide) {
                // every receiver keeps what it held
            }
        }
        if (CobolText.compareAlnum(bDischargeDate.value(), "20040101") >= 0 && CobolText.compareAlnum(bDischargeDate.value(), "20050101") < 0) {
            hSsCost.storeRounded(ppsFacCosts.value().multiply(new BigDecimal("1.93")));
            try {   // a zero divisor stores nothing, as in COBOL
                hSsPayAmt.storeRounded(CobolDecimal.divide(ppsDrgAdjPayAmt.value(), ppsAvgLos.value()).multiply(hLos.value()).multiply(new BigDecimal("1.93")));
                // TRUNCATES: the expression produces up to 10 integer digits and H-SS-PAY-AMT holds 7. The high-order digits are lost, as in the original.
            } catch (CobolDecimal.ZeroDivide cocoonZeroDivide) {
                // every receiver keeps what it held
            }
        }
        if (CobolText.compareAlnum(bDischargeDate.value(), "20050101") >= 0 && CobolText.compareAlnum(bDischargeDate.value(), "20060101") < 0) {
            hSsCost.storeRounded(ppsFacCosts.value().multiply(new BigDecimal("1.65")));
            try {   // a zero divisor stores nothing, as in COBOL
                hSsPayAmt.storeRounded(CobolDecimal.divide(ppsDrgAdjPayAmt.value(), ppsAvgLos.value()).multiply(hLos.value()).multiply(new BigDecimal("1.65")));
                // TRUNCATES: the expression produces up to 10 integer digits and H-SS-PAY-AMT holds 7. The high-order digits are lost, as in the original.
            } catch (CobolDecimal.ZeroDivide cocoonZeroDivide) {
                // every receiver keeps what it held
            }
        }
        if (CobolText.compareAlnum(bDischargeDate.value(), "20060101") >= 0 && CobolText.compareAlnum(bDischargeDate.value(), "20070101") < 0) {
            hSsCost.storeRounded(ppsFacCosts.value().multiply(new BigDecimal("1.36")));
            try {   // a zero divisor stores nothing, as in COBOL
                hSsPayAmt.storeRounded(CobolDecimal.divide(ppsDrgAdjPayAmt.value(), ppsAvgLos.value()).multiply(hLos.value()).multiply(new BigDecimal("1.36")));
                // TRUNCATES: the expression produces up to 10 integer digits and H-SS-PAY-AMT holds 7. The high-order digits are lost, as in the original.
            } catch (CobolDecimal.ZeroDivide cocoonZeroDivide) {
                // every receiver keeps what it held
            }
        }
        if (CobolText.compareAlnum(bDischargeDate.value(), "20070101") >= 0) {
            hSsCost.storeRounded(ppsFacCosts.value().multiply(new BigDecimal("1.2")));
            try {   // a zero divisor stores nothing, as in COBOL
                hSsPayAmt.storeRounded(CobolDecimal.divide(ppsDrgAdjPayAmt.value(), ppsAvgLos.value()).multiply(hLos.value()).multiply(new BigDecimal("1.2")));
                // TRUNCATES: the expression produces up to 10 integer digits and H-SS-PAY-AMT holds 7. The high-order digits are lost, as in the original.
            } catch (CobolDecimal.ZeroDivide cocoonZeroDivide) {
                // every receiver keeps what it held
            }
        }
    }

    /** 4000-SPECIAL-PROVIDER-EXIT */
    private void p4000SpecialProviderExit() {
        // nothing translatable here
    }

    /** 7000-CALC-OUTLIER */
    private void p7000CalcOutlier() {
        ppsOutlierThreshold.storeRounded(ppsDrgAdjPayAmt.value().add(hFixedLossAmt.value()));
        if (ppsFacCosts.value().compareTo(ppsOutlierThreshold.value()) > 0) {
            ppsOutlierPayAmt.storeRounded(ppsFacCosts.value().subtract(ppsOutlierThreshold.value()).multiply(new BigDecimal(".8")).multiply(ppsBdgtNeutRate.value()).multiply(hBlendPps.value()));
            // TRUNCATES: the expression produces up to 9 integer digits and PPS-OUTLIER-PAY-AMT holds 7. The high-order digits are lost, as in the original.
        }
        if (bSpecPayInd.value().compareTo("1") == 0) {
            ppsOutlierPayAmt.store(new BigDecimal("0"));
        }
        if (ppsOutlierPayAmt.value().compareTo(new BigDecimal("0")) > 0 && ppsRtc.value().compareTo(new BigDecimal("02")) == 0) {
            ppsRtc.store(new BigDecimal("03"));
        }
        if (ppsOutlierPayAmt.value().compareTo(new BigDecimal("0")) > 0 && ppsRtc.value().compareTo(new BigDecimal("00")) == 0) {
            ppsRtc.store(new BigDecimal("01"));
        }
        if (ppsRtc.value().compareTo(new BigDecimal("00")) == 0 || ppsRtc.value().compareTo(new BigDecimal("02")) == 0) {
            if (ppsRegDaysUsed.value().compareTo(hSsot.value()) > 0) {
                ppsLtrDaysUsed.store(new BigDecimal("0"));
            } else {
            }
        }
        if (ppsRtc.value().compareTo(new BigDecimal("01")) == 0 || ppsRtc.value().compareTo(new BigDecimal("03")) == 0) {
            if (bCovDays.value().compareTo(hLos.value()) < 0 || ppsCotInd.value().compareTo("Y") == 0) {
                try {   // a zero divisor stores nothing, as in COBOL
                    ppsChrgThreshold.storeRounded(CobolDecimal.divide(ppsOutlierThreshold.value(), pNewOperCstchgRatio.value()));
                } catch (CobolDecimal.ZeroDivide cocoonZeroDivide) {
                    // every receiver keeps what it held
                }
                ppsRtc.store(new BigDecimal("67"));
            } else {
            }
        } else {
        }
    }

    /** 7000-EXIT */
    private void p7000Exit() {
        // nothing translatable here
    }

    /** 8000-BLEND */
    private void p8000Blend() {
        try {   // a zero divisor stores nothing, as in COBOL
            hLosRatio.storeRounded(CobolDecimal.divide(hLos.value(), ppsAvgLos.value()));
            // TRUNCATES: the expression produces up to 3 integer digits and H-LOS-RATIO holds 1. The high-order digits are lost, as in the original.
        } catch (CobolDecimal.ZeroDivide cocoonZeroDivide) {
            // every receiver keeps what it held
        }
        if (hLosRatio.value().compareTo(new BigDecimal("1")) > 0) {
            hLosRatio.store(hLosRatio.value().subtract(new BigDecimal("1")).multiply(new BigDecimal(".8")).add(new BigDecimal("1")));
        }
        ppsDrgAdjPayAmt.storeRounded(ppsDrgAdjPayAmt.value().multiply(ppsBdgtNeutRate.value()).multiply(hBlendPps.value()));
        // TRUNCATES: the expression produces up to 9 integer digits and PPS-DRG-ADJ-PAY-AMT holds 7. The high-order digits are lost, as in the original.
        ppsNewFacSpecRate.storeRounded(pNewFacSpecRate.value().multiply(ppsBdgtNeutRate.value()).multiply(hBlendFac.value()).multiply(hLosRatio.value()));
        // TRUNCATES: the expression produces up to 8 integer digits and PPS-NEW-FAC-SPEC-RATE holds 7. The high-order digits are lost, as in the original.
        ppsFinalPayAmt.store(ppsDrgAdjPayAmt.value().add(ppsOutlierPayAmt.value()).add(ppsNewFacSpecRate.value()));
        ppsRtc.store(ppsRtc.value().add(hBlendRtc.value()));
    }

    /** 8000-EXIT */
    private void p8000Exit() {
        // nothing translatable here
    }

    /** 9000-MOVE-RESULTS */
    private void p9000MoveResults() {
        if (ppsRtc.value().compareTo(new BigDecimal("50")) < 0) {
            ppsLos.store(hLos.value());
            ppsCalcVersCd.store(calVersion.value());
        } else {
            ppsMsa.store(" ");
            ppsWageIndex.store(BigDecimal.ZERO);
            ppsAvgLos.store(BigDecimal.ZERO);
            ppsRelativeWgt.store(BigDecimal.ZERO);
            ppsOutlierPayAmt.store(BigDecimal.ZERO);
            ppsLos.store(BigDecimal.ZERO);
            ppsDrgAdjPayAmt.store(BigDecimal.ZERO);
            ppsFedPayAmt.store(BigDecimal.ZERO);
            ppsFinalPayAmt.store(BigDecimal.ZERO);
            ppsFacCosts.store(BigDecimal.ZERO);
            ppsNewFacSpecRate.store(BigDecimal.ZERO);
            ppsOutlierThreshold.store(BigDecimal.ZERO);
            ppsSubmDrgCode.store(" ");
            ppsCalcVersCd.store(" ");
            ppsRegDaysUsed.store(BigDecimal.ZERO);
            ppsLtrDaysUsed.store(BigDecimal.ZERO);
            ppsBlendYear.store(BigDecimal.ZERO);
            ppsCola.store(BigDecimal.ZERO);
            filler.store(" ");
            ppsNatLaborPct.store(BigDecimal.ZERO);
            ppsNatNonlaborPct.store(BigDecimal.ZERO);
            ppsStdFedRate.store(BigDecimal.ZERO);
            ppsBdgtNeutRate.store(BigDecimal.ZERO);
            filler.store(" ");
            ppsCalcVersCd.store(calVersion.value());
        }
    }

    /** 9000-EXIT */
    private void p9000Exit() {
        // nothing translatable here
    }

    public static void main(String[] args) {
        new Ltcal059().run();
    }
}
