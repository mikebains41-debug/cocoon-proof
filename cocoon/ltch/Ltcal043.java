import cocoon.runtime.CobolDecimal;
import cocoon.runtime.CobolText;
import cocoon.runtime.CobolRecord;
import java.math.BigDecimal;

/**
 * Translated from COBOL program LTCAL043.
 *
 * The arithmetic is deliberately not Java arithmetic. A
 * COBOL field holds what its PICTURE allows, and a value
 * too large loses its high-order digits without raising
 * anything. Every place this translation reproduces that
 * is marked TRUNCATES, because a faithful migration has
 * to compute the same numbers as the program it
 * replaces, defects included.
 */
public class Ltcal043 {

    // Records: the bytes, laid out as the mainframe lays them out.
    private final CobolRecord r_W_STORAGE_REF = new CobolRecord("W-STORAGE-REF", 46,
        "4c5443414c3034332020202020202d2057204f2052204b2049204e2047202020532054204f205220412047204520");
    private final CobolRecord r_CAL_VERSION = new CobolRecord("CAL-VERSION", 5,
        "4330342e33");
    private final CobolRecord r_W_DRG_FILLS = new CobolRecord("W-DRG-FILLS", 5610,
        "303031323038343134303030303232303834313430303030333230383431343030303036303439363431383530303731353735343431303030383135373534343130303039313530323533323930313030373534393233343031313037323831323230303132303734383532353830313330373533303235393031343039313936323734303135303837313432383830313630393132353233393031373035323632323034303138303832323532333930313930363233363232373032303130303937323438303231303733373232333530323230373337323233353032333039303333323838303234303835323732363230323530373732373234313032363037333732323335303237313139323933303430323831303231313239303032393039303536323636303330303935363232363130333130393536323236313033323039353632323631303333303733373232333530333430393134303237383033353036363531323435303336303439363431383530333730343936343138353033383034393634313835303339303439363431383530343032303834313430303034313034393634313835303432303439363431383530343330343936343138353034343034393634313835303435303439363431383530343630343936343138353034373034393634313835303438303439363431383530343931333536393332353035303039353632323631303531303935363232363130353230393536323236313035333037333732323335303534303935363232363130353530393536323236313035363037333732323335303537303935363232363130353830393536323236313035393039353632323631303630303935363232363130363130373337323233353036323039353632323631303633303935363232363130363431323534303237353036353034393634313835303636303439363431383530363730393536323236313036383038323433323139303639303439363431383530373030343936343138353037313034393634313835303732303733373232333530373330373231353230333037343034393634313835303735323038343134303030373632343338323433393037373230383431343030303738303838393632343230373930383938353232363038303037363435323233303831303439363431383530383230373438303230333038333039353632323631303834303733373232333530383530383531343233353038363036353430323234303837313635313333313930383830373635333230373038393038343238323331303930303733313832313730393130373337323233353039323037373032323034303933303439363431383530393430363537313138393039353034393634313835303936303733383132303530393730353239363138373039383034393634313835303939313036323232363631303031303537393236313130313039303039323236313032303730313132313031303432303834313430303130353230383431343030313036323038343134303031303732303834313430303130383230383431343030313039323038343134303031313032303834313430303131313230383431343030313133313536323933383731313431333630343338333131353230383431343030313136323038343134303031313730393536323236313131383230383431343030313139313335363933323531323031323433353334343132313037343637323231313232303634343031383831323330383532373138383132343133353639333235313235313335363933323531323630383730363235363132373037373139323231313238303733373232333531323930393536323236313133303037373132323434313331303633393832333131333230383039323232343133333037303434323139313334303931353432373931333530393033393233313133363037313836323234313337303733373232333531333830373433303232373133393036303332323033313430303630393431393331343130363435333232393134323035303431323033313433303733313432313831343430373932313232323134353036393833323037313436323038343134303031343732303834313430303134383230383431343030313439303439363431383531353031333536393332353135313133353639333235313532313335363933323531353331333536393332353135343230383431343030313535313335363933323531353631333536393332353135373133353639333235313538303935363232363131353931333536393332353136303133353639333235313631313335363933323531363230343936343138353136333034393634313835313634323038343134303031363530343936343138353136363230383431343030313637303439363431383531363832303834313430303136393037333732323335313730313730303634303331373131333536393332353137323038373032323235313733303730393232303231373430373837343233373137353036333435323131313736303737323832313231373730373337323233353137383034393634313835313739313030323332353231383030383232323232393138313038323232323239313832303834343932333531383330363336323230333138343037333732323335313835303733373232333531383630373337323233353138373037333732323335313838313033303832353331383930373832363231383139303037333732323335313931313335363933323531393230343936343138353139333037333732323335313934303733373232333531393531333536393332353139363039353632323631313937303935363232363131393830393536323236313139393037333732323335323030303733373232333532303132303834313430303230323037323534323233323033303637353831383932303430393938363233343230353037303239323231323036303730323932323132303730363637313230353230383036363731323035323039313335363933323532313031333536393332353231313037333732323335323132303733373232333532313331333835313333383231363133353639333235323137313430333833393332313830393536323236313231393039353632323631323230303935363232363132323330393536323236313232343039353632323631323235303935363232363132323631333536393332353232373133353639333235323238313335363933323532323930393536323236313233303133353639333235323332303733373232333532333330393536323236313233343039353632323631323335303833393632393632333630373336383237313233373037333732323335323338303834333232373932333930363631303232303234303036363835323132323431303435333831383732343230373732313236343234333036363136323332323434303535363332303032343530343732313138353234363035313238323232323437303535333632303232343830373237343234353234393037383239323730323530303832303632393932353130363030393237333235323039353632323631323533303831373632373632353430363639313235313235353039353632323631323536303832393432353932353730393536323236313235383039353632323631323539303935363232363132363030393536323236313236313230383431343030323632303935363232363132363331343532323432343236343132383932343431323635313232313533343832363631323231353334383236373039353632323631323638323038343134303032363931343436363433303237303039393136333339323731303936323033303432373230373132313232383237333034393634313835323734303930373232343932373530373337323233353237363034393634313835323737303734303932333632373830353938323230373237393039353632323631323830303937323432393532383130373338363236343238323037333732323335323833303635303831393332383430343936343138353238353135313736333734323836303733373232333532383731333938323339373238383230383431343030323839303733373232333532393030373337323233353239313037333732323335323932313335363933323532393330393536323236313239343038303631323539323935303935363232363132393630383230373234313239373036353234323435323938303733373232333532393930393536323236313330303037373034323233333031303733373232333533303332303834313430303330343230383431343030333035303439363431383533303631333536393332353330373133353639333235333038313335363933323533303930373337323233353331303133353639333235333131303439363431383533313231333536393332353331333034393634313835333134303439363431383533313531353037303336383331363039323134323338333137303935363232363133313830373034383231313331393034393634313835333230303732323332333033323130363236303233323332323034393634313835333233303733373232333533323430373337323233353332353039353632323631333236303439363431383533323730343936343138353332383034393634313835333239303439363431383533333030343936343138353333313038343733323332333332303537323232313133333330343936343138353333343230383431343030333335323038343134303033333630373337323233353333373037333732323335333338303733373232333533333930373337323233353334303037333732323335333431303733373232333533343230343936343138353334333037333732323335333434303439363431383533343532303834313430303334363037313530323233333437303731353032323333343830343936343138353334393034393634313835333530313138323032363633353130373337323233353335323039353632323631333533323038343134303033353432303834313430303335353230383431343030333536313335363933323533353731333536393332353335383133353639333235333539313335363933323533363031333536393332353336313034393634313835333632303439363431383533363330343936343138353336343034393634313835333635323038343134303033363630383133393233313336373034393634313835333638303639363331393333363930393536323236313337303039353632323631333731303439363431383533373230343936343138353337333034393634313835333734303439363431383533373530343936343138353337363034393634313835333737303439363431383533373830393536323236313337393034393634313835333830303439363431383533383130343936343138353338323034393634313835333833303439363431383533383430343936343138353338353034393634313835333836303439363431383533383730343936343138353338383034393634313835333839303439363431383533393030343936343138353339313034393634313835333932303733373232333533393330373337323233353339343039353632323631333935303737383232343033393630343936343138353339373039343534323335333938303833373232323033393930343936343138353430313230383431343030343032303935363232363134303330383934313232343430343037333934313830343035303733373232333534303632303834313430303430373039353632323631343038303935363232363134303930383837313235313431303039353632323631343131303439363431383534313230343936343138353431333039353431323535343134303439363431383534313531363834393430313431363039313931323439343137303935363232363134313830383330343235323431393039353632323631343230303733373232333534323130373337323233353432323037333732323335343233303930323432333134323431333536393332353432353035393831323735343236303436363032323334323731333536393332353432383034393634313835343239303634333832373434333030343638393232373433313034393634313835343332303439363431383534333330343936343138353433393133363633343035343430313538353434303034343132303834313430303434323134393731343436343433313335363933323534343430393630393330363434353037353532323636343436303733373232333534343730393536323236313434383037333732323335343439303935363232363134353030393536323236313435313037333732323335343532303936393232343934353330383633333234323435343037333732323335343535303733373232333534363131333231363336353436323036343731323332343633303735343132363834363430363137303235353436353037333732323335343636303733363532323034363730343936343138353436383230363836343235343731323038343134303034373330393536323236313437353231333538333532343736313030333233313934373731383939383430303437383132353637333432343739313235363733343234383130393536323236313438323230383431343030343833333231333135353734383432303834313430303438353133353639333235343836313335363933323534383731323438343332373438383230383431343030343839303932353432313334393030373336313139363439313133353639333235343932303935363232363134393331333536393332353439343230383431343030343936313335363933323534393730393536323236313439383039353632323631343939323038343134303035303031333536393332353530313230383431343030353032303733373232333535303330393536323236313530343230383431343030353035313335363933323535303630373337323233353530373037333732323335353038303733373232333535303930373337323233353531303037333732323335353131303439363431383535313532303834313430303531363039353632323631353137313335363933323535313830393536323236313531393133353639333235353230303935363232363135323130343735333230353532323034303631323034353233303432313431393835323430353838353232393532353230383431343030353236313335363933323535323731333536393332353532383230383431343030353239303733373232333535333030373337323233353533313133353639333235353332303935363232363135333332303834313430303533343133353639333235353335323038343134303035333632303834313430303533373133353639333235353338303439363431383535333932303834313430303534303034393634313835");
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
    // PIC PIC X(22)
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
    // W-DRG-FILLS (group, 5610 bytes)
    private CobolText wDrgFills;
    // W-DRG-TABLE (group, 5610 bytes)
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
        pic = new CobolText(r_W_DRG_FILLS, 0, 44);
        wwmDrg = CobolText.table(r_W_DRG_TABLE, 0, 11, 510, 3);
        wwmRelwt = CobolDecimal.table(r_W_DRG_TABLE, 3, 11, 510, 5, 1, 4, false, 0, 0);
        wwmAlos = CobolDecimal.table(r_W_DRG_TABLE, 8, 11, 510, 3, 2, 1, false, 0, 0);
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
        wDrgFills = new CobolText(r_W_DRG_FILLS, 0, 5610);
        wDrgTable = new CobolText(r_W_DRG_TABLE, 0, 5610);
        wwmEntry = CobolText.table(r_W_DRG_TABLE, 0, 11, 510, 11);
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

    public Ltcal043() {
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
        ppsStdFedRate.store(new BigDecimal("35726.18"));
        hFixedLossAmt.store(new BigDecimal("19590"));
        ppsBdgtNeutRate.store(new BigDecimal("0.940"));
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
                int cocoonHead1 = 0, cocoonTail1 = 510 + 1;
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
        if (CobolText.compareAlnum(pNewFyBeginDate.value(), "20031001") >= 0 && bDischargeDate.value().compareTo(pNewFyBeginDate.value()) >= 0) {
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
        } else {
            if (CobolText.compareAlnum(bDischargeDate.value(), "20040101") >= 0 && CobolText.compareAlnum(bDischargeDate.value(), "20050101") < 0) {
                hSsCost.storeRounded(ppsFacCosts.value().multiply(new BigDecimal("1.93")));
                try {   // a zero divisor stores nothing, as in COBOL
                    hSsPayAmt.storeRounded(CobolDecimal.divide(ppsDrgAdjPayAmt.value(), ppsAvgLos.value()).multiply(hLos.value()).multiply(new BigDecimal("1.93")));
                    // TRUNCATES: the expression produces up to 10 integer digits and H-SS-PAY-AMT holds 7. The high-order digits are lost, as in the original.
                } catch (CobolDecimal.ZeroDivide cocoonZeroDivide) {
                    // every receiver keeps what it held
                }
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
            ppsCalcVersCd.store("V04.3");
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
            ppsCalcVersCd.store("V04.3");
        }
    }

    /** 9000-EXIT */
    private void p9000Exit() {
        // nothing translatable here
    }

    public static void main(String[] args) {
        new Ltcal043().run();
    }
}
