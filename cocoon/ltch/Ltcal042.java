import cocoon.runtime.CobolDecimal;
import cocoon.runtime.CobolText;
import cocoon.runtime.CobolRecord;
import java.math.BigDecimal;

/**
 * Translated from COBOL program LTCAL042.
 *
 * The arithmetic is deliberately not Java arithmetic. A
 * COBOL field holds what its PICTURE allows, and a value
 * too large loses its high-order digits without raising
 * anything. Every place this translation reproduces that
 * is marked TRUNCATES, because a faithful migration has
 * to compute the same numbers as the program it
 * replaces, defects included.
 */
public class Ltcal042 {

    // Records: the bytes, laid out as the mainframe lays them out.
    private final CobolRecord r_W_STORAGE_REF = new CobolRecord("W-STORAGE-REF", 46,
        "4c5443414c3034322020202020202d2057204f2052204b2049204e2047202020532054204f205220412047204520");
    private final CobolRecord r_CAL_VERSION = new CobolRecord("CAL-VERSION", 5,
        "4330342e32");
    private final CobolRecord r_W_DRG_FILLS = new CobolRecord("W-DRG-FILLS", 5522,
        "3030313138373833343633303032313837383334363330303331383738333436333030343132343933333133303035313234393333313330303630343035353136383030373137383239343338303038313234393333313330303931343131383334363031303038353337323435303131303835333732343530313230373737333237313031333037323037323536303134303838313632363630313530393035333239343031363038383634323730303137303636353532313930313830373737303234393031393035343836323230303230313233333132393330323130343035353136383032323036363535323139303233303936323332373230323430383833313234383032353034383330323034303236303430353531363830323731313132363331363032383131353037323930303239303932363832373230333030383238343233333033313036363535323139303332303430353531363830333330343035353136383033343038333835323531303335303635363132353330333630343035353136383033373034303535313638303338303430353531363830333930343035353136383034303034303535313638303431303430353531363830343230343035353136383034333038323834323333303434303636353532313930343530343035353136383034363036363535323139303437303430353531363830343830343035353136383034393138373833343633303530303636353532313930353130363635353231393035323036363535323139303533303636353532313930353430363635353231393035353036363535323139303536303636353532313930353730363635353231393035383036363535323139303539303636353532313930363030363635353231393036313138373833343633303632303636353532313930363331383738333436333036343130343437323535303635303530353631393830363630343035353136383036373034303535313638303638303832383432333330363930383238343233333037303034303535313638303731303430353531363830373230343035353136383037333038303937323337303734303430353531363830373531383738333436333037363237363734353036303737313837383334363330373830363334383230353037393038393136323232303830303739343732323830383130343035353136383038323037393736323039303833303733383432343830383430343035353136383038353038323037323336303836303631393432313130383731363539373332333038383037353332323039303839303835333332333630393030373932313233303039313038323834323333303932303732353131393130393330353537333138353039343037383835323237303935303430353531363830393630383137333234323039373035393430313739303938303430353531363830393931313136343237333130303130303135323534313031303937363332333431303230393331333234353130343138373833343633313035313837383334363331303631383738333436333130373138373833343633313038303636353532313931303931383738333436333131303138373833343633313131313837383334363331313331343130333336393131343133333737343032313135313837383334363331313630383238343233333131373034303535313638313138303430353531363831313930363635353231393132303134303931333634313231303731363732313631323230353134343139303132333039343132323039313234303832383432333331323531383738333436333132363037363839323438313237303736313632323431323830363034323230383132393130353334323039313330303739313432343831333130373038313233373133323038313833323138313333303534383431383531333430363938353234303133353037333331323033313336303730373532313031333730363635353231393133383037313837323334313339303634383232303431343030373639303230313134313036323532323332313432303534353232313531343330373331363232373134343037383730323139313435303736333732353031343631323439333331333134373132343933333133313438323834383834373631343930363635353231393135303034303535313638313531303430353531363831353231323439333331333135333038323834323333313534313234393333313331353530383238343233333135363038323834323333313537303430353531363831353830343035353136383135393132343933333133313630303636353532313931363130363635353231393136323036363535323139313633303636353532313931363430383238343233333136353038323834323333313636303636353532313931363730363635353231393136383038323834323333313639303636353532313931373031353534333335303137313038323834323333313732303835353332343231373330353531333138393137343038373431323336313735303833353932353631373630373636313234343137373038323834323333313738303636353532313931373931303937353233343138303038343537323238313831303536333831393531383230383832393235393138333036393133323135313834303636353532313931383530383238343233333138363038323834323333313837303832383432333331383831303439303234323138393035383532313734313930303636353532313931393131383738333436333139323132343933333133313933313234393333313331393430383238343233333139353038323834323333313936303832383432333331393731383738333436333139383138373833343633313939303832383432333332303031323439333331333230313138373833343633323032303537333631383432303330353839373138323230343039343434323231323035303638323532313532303630363635353231393230373036393739323135323038303430353531363832303931383738333436333231303132343933333133323131303832383432333332313230383238343233333231333132353931333330323136313234393333313332313731333630323338383231383038323834323333323139303832383432333332323030383238343233333232333132343933333133323234303430353531363832323531323439333331333232363132343933333133323237303832383432333332323830363635353231393232393036363535323139323330303430353531363832333131383738333436333233323034303535313638323333313234393333313332333430343035353136383233353037353430323835323336303733383132373232333730363635353231393233383038323735323735323339303636383932313932343030393236303236303234313035383035323237323432303737323532363332343330363539363233343234343035373536323036323435303434323631373532343630363035333231343234373035353930323034323438303732383832333932343930383030353237313235303038333733333138323531303639303432363032353230343035353136383235333038303534323830323534303639393932363432353530343035353136383235363038303032323531323537303636353532313932353830363635353231393235393036363535323139323630303636353532313932363130343035353136383236323034303535313638323633313533383834353032363431313634353338383236353136353639343536323636303832383432333332363730343035353136383236383132343933333133323639313339313534313732373031333837393431363237313039373134333131323732303638343632313032373330363635353231393237343037383732323230323735303738373232323032373630363635353231393237373037373034323434323738303633353332323432373930363635353231393238303130303937333039323831303733363332373432383230363635353231393238333038353734323438323834303430353531363832383531333639323331373238363132343933333133323837313331393533393632383831383738333436333238393034303535313638323930303430353531363832393130343035353136383239323132343933333133323933303636353532313932393430373637383235313239353038323834323333323936303737313032343332393730363332313231313239383036363535323139323939303832383432333333303030383637303233333330313034303535313638333033313837383334363333303431323439333331333330353036363535323139333036303832383432333333303730343035353136383330383038323834323333333039303430353531363833313031323439333331333331313034303535313638333132313837383334363333313330343035353136383331343034303535313638333135313538303033393533313630393330383234313331373132343933333133333138303830373532313533313930363635353231393332303037343234323339333231303631323332303433323230363635353231393332333036363535323139333234303636353532313933323530383132333236373332363036363535323139333237303430353531363833323830363635353231393332393034303535313638333330303430353531363833333130393236373234363333323036333933323039333333303430353531363833333431323439333331333333353038323834323333333336303832383432333333333730363635353231393333383036363535323139333339303430353531363833343030343035353136383334313036363535323139333432313234393333313333343330343035353136383334343132343933333133333435303832383432333333343630373037303231363334373036363535323139333438303430353531363833343930343035353136383335303036303538313939333531303430353531363833353230383238343233333335333138373833343633333534313234393333313333353531323439333331333335363132343933333133333537313234393333313333353831383738333436333335393034303535313638333630303430353531363833363130363635353231393336323036363535323139333633303832383432333333363430363635353231393336353138373833343633333636303936353432333933363730383238343233333336383132343933333133333639303636353532313933373030383238343233333337313036363535323139333732303636353532313933373330343035353136383337343034303535313638333735303430353531363833373630343035353136383337373034303535313638333738303636353532313933373930343035353136383338303034303535313638333831303430353531363833383230343035353136383338333034303535313638333834303430353531363833383530343035353136383338363036363535323139333837303636353532313933383830343035353136383338393132343933333133333930303636353532313933393130343035353136383339323038323834323333333933303636353532313933393431383738333436333339353038353834323531333936303430353531363833393730373536373139343339383039303038323334333939303430353531363834303030383238343233333430313132343933333133343032303832383432333334303330393635313233393430343038393830313931343035303636353532313934303631383738333436333430373038323834323333343038313234393333313334303930353232303139353431303034303535313638343131303430353531363834313230343035353136383431333039303631323337343134303930363132333734313531343933333338373431363039363132323539343137303832383432333334313830383737313235383431393035393438323035343230303430353531363834323131323439333331333432323034303535313638343233303837303132343734323431383738333436333432353036313737323630343236303537333932363934323730363635353231393432383132343933333133343239303534363632353034333030343437393232393433313034333435323237343332303636353532313934333330323438393133313433393133323030343235343430313335363734303134343130363635353231393434323136343432333937343433303636353532313934343430393631343330373434353038343438323733343436303832383432333334343730363635353231393434383034303535313638343439303832383432333334353030363635353231393435313034303535313638343532303935393632353534353330363636363233313435343038323834323333343535303430353531363834363131333338333338303436323036343639323335343633303736313832363834363430363233343234333436353038323834323333343636303831313932333934363730363635353231393436383232313737343535343731313837383334363334373330383034373137313437353230393036333535343736313837383334363334373731363739313339373437383136323434333738343739303636353532313934383131383738333436333438323036363535323139343833333233313935343634383431383738333436333438353138373833343633343836303832383432333334383731303838353239353438383138373833343633343839303838343632323934393030363935323230343439313138373833343633343932303832383432333334393330383238343233333439343034303535313638343936313234393333313334393731383738333436333439383038323834323333343939313837383334363335303030383238343233333530313138373833343633353032303832383432333335303331383738333436333530343138373833343633353035313234393333313335303631383738333436333530373038323834323333353038303832383432333335303930383238343233333531303130373334333232353131303832383432333335313430383238343233333531353132343933333133353136303832383432333335313731383738333436333531383132343933333133353139303832383432333335323030363635353231393532313033373535313836353232303430353531363835323330333836303231323532343036323530323331353235313837383334363335323630383238343233333532373038323834323333");
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
    // W-DRG-FILLS (group, 5522 bytes)
    private CobolText wDrgFills;
    // W-DRG-TABLE (group, 5522 bytes)
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
        wwmDrg = CobolText.table(r_W_DRG_TABLE, 0, 11, 502, 3);
        wwmRelwt = CobolDecimal.table(r_W_DRG_TABLE, 3, 11, 502, 5, 1, 4, false, 0, 0);
        wwmAlos = CobolDecimal.table(r_W_DRG_TABLE, 8, 11, 502, 3, 2, 1, false, 0, 0);
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
        wDrgFills = new CobolText(r_W_DRG_FILLS, 0, 5522);
        wDrgTable = new CobolText(r_W_DRG_TABLE, 0, 5522);
        wwmEntry = CobolText.table(r_W_DRG_TABLE, 0, 11, 502, 11);
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

    public Ltcal042() {
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
                int cocoonHead1 = 0, cocoonTail1 = 502 + 1;
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
            hLosRatio.store(new BigDecimal("1"));
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
            ppsCalcVersCd.store("V04.2");
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
            ppsCalcVersCd.store("V04.2");
        }
    }

    /** 9000-EXIT */
    private void p9000Exit() {
        // nothing translatable here
    }

    public static void main(String[] args) {
        new Ltcal042().run();
    }
}
