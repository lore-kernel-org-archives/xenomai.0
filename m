Received: from mx0a-001f5801.pphosted.com (mx0a-001f5801.pphosted.com [148.163.157.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080FE6138
	for <xenomai@lists.linux.dev>; Thu, 17 Nov 2022 15:57:28 +0000 (UTC)
Received: from pps.filterd (m0090334.ppops.net [127.0.0.1])
	by mx0a-001f5801.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHE4bhG028384;
	Thu, 17 Nov 2022 07:57:28 -0800
Received: from usg02-cy1-obe.outbound.protection.office365.us (mail-cy1usg02lp0179.outbound.protection.office365.us [23.103.199.179])
	by mx0a-001f5801.pphosted.com (PPS) with ESMTPS id 3kw3253n95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Nov 2022 07:57:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=hFkKWXpMHPwxtTkRJDp0zs08By8ky6BeK6tQpAp93z/PGPLvA0Y8HAANPdNdOY1WQB4oFzy8Plyh/mKO+Y7/uXot2lti1ZW/+mRY/kvV5y1HUNdo22TwwZn3cf3nU8mQSX6wK9lEnqTjyKy/CcQlTAaTAAhX0Tk9C7xVm7wbzZwHghYNwxCIT+XFPvlkI4xRNSq9MoUpknyTHmhiPW5wtZgVLX5mWFKveDYuoZ5g7c8DbLgrcgKW8Gg3YNN3BRfo9UU5oI1wsVOUsSVQ6JL4SQ1F/kIfoIEwCOyv/yHFeVpmu3YzHbht/QhLHCUtEPnYAPIO+yi6tif7LXArzI0zVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKJ4XQz4CU2jE09EuQ8cqJX8j2L5lYVQlaCg2RiUxnM=;
 b=ZwCkKcmNgp4lrDv4YrXnxzyhDuwH6HsQl0dpVkhApiBhoy6rJqEtOPfifdnOhNyrV3Q/RVWp1TxD2Q4sv3Nmz6tfG2rNSZXsz+fKKaV2VnHfBQWwdyTl5YEKNaHfaWmswGZuS3Ykqy/H/9vMfhxtbFY/BgvyY98xGpbSCDQVF9aqoMmy5/Uwp4tPTYY3HEZShlpbofx+zT3G5J8CEEfQ55XogbnqzOtjOdhEi/gIdfFWpsSjj5tCcDW+KSnWTRRyH5vc7ll1q+u9C6VahiDNhvuhg/pd3K6b15YaEiRS2UdmJlg3Qhb6McYJZm0eHFE+ektFDWCEU2uSbiQw04c4Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kratosdefense.com; dmarc=pass action=none
 header.from=kratosdefense.com; dkim=pass header.d=kratosdefense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kratosdefense.onmicrosoft.us; s=selector1-kratosdefense-onmicrosoft-us;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKJ4XQz4CU2jE09EuQ8cqJX8j2L5lYVQlaCg2RiUxnM=;
 b=NgTQIPyHOVCX7+yHq8goDWfJIIpn4dacR2qyFgMOoAwLia+5woFvoAxB0WDSyp4EiQ/7Vm4i4JKQawdF7MFgLRbaxnIPhL4i5IqQkDEENZ+v/QGinRDcZro1YVmtQL5pOttaNfzc8DKEPEVussoVHbfaGzYPgLyUQeWt9M1zoUdOtZkabCcY4lIAFKNx2+jUqRa5s5WWfzzx1os6532sExZUA39ISISR2qpFVBogjTY1hZ4w34SRG6HhSauYvGFCgR44jl6/bc6nWD/3j1R9RuvFh4iwUBvMFybtGxQqEk9qthtA7PzojXGGq73zz1OJKAJWoFvLcEX132IlVWRwWg==
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:176::15)
 by PH1P110MB1396.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:189::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Thu, 17 Nov
 2022 15:57:25 +0000
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::2dc2:8d63:5c5b:f725]) by PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::2dc2:8d63:5c5b:f725%6]) with mapi id 15.20.5813.019; Thu, 17 Nov 2022
 15:57:25 +0000
From: Russell Johnson <russell.johnson@kratosdefense.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>,
        Philippe Gerum
	<rpm@xenomai.org>
CC: Bryan Butler <Bryan.Butler@kratosdefense.com>,
        Shawn McManus
	<shawn.mcmanus@kratosdefense.com>
Subject: EVL Thread Priorities
Thread-Topic: EVL Thread Priorities
Thread-Index: Adj6nIpZ+KKz8qlcRLOcGLbH2yzx8Q==
Date: Thu, 17 Nov 2022 15:57:25 +0000
Message-ID: 
 <PH1P110MB1050FFAC564F1F74AFE24367E2069@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH1P110MB1050:EE_|PH1P110MB1396:EE_
x-ms-office365-filtering-correlation-id: e76538c0-985b-46a6-96a9-08dac8b46bbc
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 zW3Ay06Vngo2YRvWRor3Ip633zsFHorQSQ+uMuZBMPvOj8VgaZ3MmOL/hbc7blYHBHiw8y2yHPqXNTL2XKQUgEpr55uDjYyx7L0+Gi6ydjQEqv5w2kq9nEqEWNDf5KDwaC0C2G70qp+SzW7XGtr6VF/69NNUNs4bmXw56m5J6E/yb2AUbGnGQ6V087GeT6bfEdpotocXK1KoU5LFVq8T+TynEvCrKYWYELZ+Foe8Vpunmo9lLakf3AG/gQtMoRTGFj4FEq2FOcXHF3QmavjLqi8H9ALr930AbDJcNQmhHLcaR6WSz1Y2DAho9XDl13nowALgUXsO3JrJVB7bDqzG/Ig2UDIj58bEn1jUWlKv2md7zcKqhuWfbRBaL6c5gLgdntsbjpMg3+pR1iI+NnKIRrE9NhMq/lZrdbpGOtQ/O6J/dEAXi+BRDaK95tmGpbxsuocYTS4OlwRvYpyq7UmiUIjsVBBkMJrgnWa3hQhQ1l4zgxHvP6IhbHDudWgTZsVpgX5CVmGqutFn2Y5OkcjZGWFfj0eg0mKWwslyMQai/REHGM0+shkOZa0el3cljFrne8E4C/tRNcgTvPuq3u0JdsRlqFBXsy3ooQ0Vr+o2eiEWB2kI7GnEexPXZvimLnGT
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(366004)(451199015)(3480700007)(55016003)(86362001)(33656002)(38100700002)(99936003)(122000001)(38070700005)(54906003)(6506007)(7696005)(110136005)(71200400001)(498600001)(107886003)(7116003)(2906002)(44832011)(52536014)(5660300002)(66946007)(76116006)(186003)(9326002)(8936002)(66476007)(66446008)(4326008)(66556008)(8676002)(64756008)(9686003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 gHQqo63SA6WbNIWE//s8DvYBq1s2XfbCoLrd8i5yPxT9TAje37gdteEQmkokO0yG29h+UFgZX3uWBCc1RQq/7ZSZI1ChiD/Hmu2717weEjkN+eK8fjxVazbDp3D0fPNUTMhIZT3XiWujnwnDZxYl3vY+UP72ZwjcuLcu23e+s/3h2CVfZ6XMiSoseag8sxY+5mqotaHISJevhFkvK4JxYTTUwv1WPhQOxJpspRFzOXcIesDF5P2NGsZ6P81E5PWd2XP9LzgAspx1nGPEp3IQ1MLP1c8ig/MR1z3kilPgc92NUot3aCBNVjPKR1+LPkSelZz2B36rSzFa3+4HlBCVOQ4F0Ws0GZqGTnKDTVHiXnMe1UEfuotivJerEsr0IiJGRM/SMiVxsxYgDbtSEaWCYJ8+ELPKXh110FpbVMWCcdsq20twdaAOBgpajBRk9ZsGmSPbINgYzxw7zEyIYT49Ipg0AwZCMs1yAwnp9CyjLfU=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=2.16.840.1.101.3.4.2.1;
	boundary="----=_NextPart_000_002C_01D8FA62.9B7E3BF0"
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	AP14rJ68wa1TDO03/1us9CaJNNrJDRgp9VDwGjfTIWxnWkYhPz0wPRbJMVginy/YqEZq1qkt4brqJkDP0Z7UUJOFO72ySb9H/js/dzj7bgkxjyJSYCBv8/wopkRKk82m3KFKw9l9e1YUc3mxii7XqPWNxDGlXDLBcg7F9qCsxhfXSrxnU6jBeajYntPghd5V+a4SSzxFZN9+XmR2Fxs1iuHy2SSOd5vRmHJYqafS1dtf50GGs8zhEJTo22oRnRoVDDhcpIV8M5FXm13ZXOLem1jTCyycKP31m56xH2ikT2TQPdMq2CVMbF0kQB8O6ddtJP5vZA61m3RWafcokdvq5aCcIl3Tgv1W35XsnXTMk7flQ41NdRS1Rnh+1vgwxh04hvQOQcTJ3Mt++5THNJNDh5ztd6lsh8pZznkuu8h/Xl9yf0eikUXOec+6MU/VJacAeAYXFPRK+X02OVSz4EiCAshGDO/4EMcwJ6Nx8bDrKQmM3cjyEBedkyHgP0VFReiXl66Ns54SA/tzn/+B+/sOBK/JE/LmcUZbem769kbRFc4ZhElz8dTDsby+34zY9sTJI/oTbXD2wDE9V7ni1IdQ5YgJeTno8XKAqtqP6Ns3ogYPQXpzmA11a8txphMRd8bqNg5Jfga6Q7tMdLANBYRjkEq7oef1gr447TrkbL7RbLqGkob/anDPilDwZ1GZE+zmYeqjjb8MS2d9j8WD4qKBMn8/A5cyVIULLdEDU+bip57RsWSuJKIj0jbdiHZajjUdv4XRZzzV2SjRMOb7urNorxNPZWCItVeKBZuH3fS0EXypNq+NZW9/4Geo+skFv3BT
X-OriginatorOrg: kratosdefense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e76538c0-985b-46a6-96a9-08dac8b46bbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 15:57:25.2911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7932d891-b9cc-431d-be14-d43339fa1133
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH1P110MB1396
X-Proofpoint-GUID: cNggRlfIrrRWbqk3LLJXOwGUeMsq18nG
X-Proofpoint-ORIG-GUID: cNggRlfIrrRWbqk3LLJXOwGUeMsq18nG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 mlxlogscore=999 impostorscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211170119

------=_NextPart_000_002C_01D8FA62.9B7E3BF0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_002D_01D8FA62.9B7E6300"


------=_NextPart_001_002D_01D8FA62.9B7E6300
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

 

We are seeing an issue with setting thread priorities. I'm not sure if this
is a real problem that is contributing to our issues, or if it's just
something weird happening. 

 

Here is a list of the real time threads and the priority and CPU affinity
settings we're asking for.

 

Thread               Priority  CPU

___________________________

Main                         50     0

TxStartup                 52     0

RxStartup                 51     0

DummyTxConfig     89     2

DummyTxService    88     3

TxMain                      87     4

TxWorker(n)             86    8-11

DummyTxSample    85     5

DummyRxConfig     79     2

DummyRxService    78     3

RxMain                      77     4

RxWorker(n)             76    8-11

 

If we run 'top' we can see the priority settings:

  PID USER      PR  NI    VIRT    RES    SHR S %CPU %MEM     TIME+ COMMAND

32130 root      20   0 3731268   2.5g 110748 S  0.0 16.2   0:05.54
realtime_sfhm

32140 root      20   0 3731268   2.5g 110748 S  0.0 16.2   0:00.00 sigthread

32144 root     -51   0 3731268   2.5g 110748 S  0.0 16.2   0:00.09 Main

32150 root     -53   0 3731268   2.5g 110748 S  0.0 16.2   0:00.21 TxStartup

32151 root     -86   0 3731268   2.5g 110748 S  0.0 16.2   0:00.00
DummyTxSample

32152 root     -87   0 3731268   2.5g 110748 S  0.0 16.2   0:00.00 TxWorker0

32153 root     -87   0 3731268   2.5g 110748 S  0.0 16.2   0:00.00 TxWorker1

32154 root     -87   0 3731268   2.5g 110748 S  0.0 16.2   0:00.00 TxWorker2

32155 root     -52   0 3731268   2.5g 110748 S  0.0 16.2   0:00.13 RxStartup

32156 root     -87   0 3731268   2.5g 110748 S  0.0 16.2   0:00.00 TxWorker3

32157 root     -88   0 3731268   2.5g 110748 S  0.0 16.2   0:00.00 TxMain

32158 root     -89   0 3731268   2.5g 110748 S  0.0 16.2   0:00.00
DummyTxService

32159 root     -80   0 3731268   2.5g 110748 S  0.0 16.2   0:00.00
DummyRxConfig

32160 root     -78   0 3731268   2.5g 110748 S  0.0 16.2   0:00.00 RxMain

32161 root     -77   0 3731268   2.5g 110748 S  0.0 16.2   0:00.00 RxWorker0

32162 root     -79   0 3731268   2.5g 110748 S  0.0 16.2   0:00.00
DummyRxService

 

Top apparently has this weirdness where it displays real-time thread
priorities as -(P+1), which I guess is how it's maintained in the kernel.
This seems to be a known issue, but it appears that, with this caveat, that
the thread priorities are being set properly within the pthreads
implementation. The two non-realtime threads are part of our startup
process. They never execute within the EVL context. 

 

However, if we look at the same threads using 'evl ps', we get this result:

CPU   PID   SCHED   PRIO  ISW     CTXSW     SYS       RWA       STAT
TIMEOUT      %CPU   CPUTIME     NAME

  0   32144  fifo    50   34      1316      2910      0          Dto
011.587        0.0  00:027.437  Main

  0   32150  fifo    52   4       1286      1974      0          Dto
075.003        0.0  00:023.977  TxStartup

  5   32151  fifo    87   0       51201     587379    49931      wbto
907.752        1.0  01:343.085  DummyTxSample

  8   32152  fifo    87   0       19580     207489    19653      wbto
998.796        1.0  01:240.410  TxWorker0

  9   32153  fifo    87   0       19000     206602    19071      wbto
905.257        1.0  01:242.255  TxWorker1

10   32154  fifo    87   0       16976     197880    17049      wbto
901.719        1.0  01:314.756  TxWorker2

  0   32155  fifo    87   4       141       646       8          Dbto
966.055        0.0  00:007.204  RxStartup

11   32156  fifo    87   0       16372     180026    16439      wbto
907.961        1.0  01:273.781  TxWorker3

  4   32157  fifo    87   0       13443     851659    13390      wto
902.939        1.5  01:929.911  TxMain

  3   32158  fifo    88   0       1281      3845      0          Dto
004.172        0.0  00:039.957  DummyTxService

  2   32159  fifo    87   0       6515      260458    5314       wbto
073.624        0.7  00:858.282  DummyRxConfig

  4   32160  fifo    87   0       49059     626499    49185      wbto
972.854        2.4  03:082.805  RxMain

  8   32161  fifo    87   0       33436     386429    32535      wbto
065.114        1.8  02:317.974  RxWorker0

  3   32162  fifo    87   0       37243     378069    36132      Dbto
071.350        1.9  02:374.748  DummyRxService

 

CPU affinity settings look to be correct, but the priorities shown by 'evl
ps' are not consistent with those from 'top'. Furthermore, there seems to be
some difference between runs. Sometimes the priorities will be closer to
those we asked for. At other times it looks more like this, where they all
appear to be set to 87.

 

I don't know if this is just a mistake by the 'evl ps' command, or if the
EVL scheduler is actually using the wrong priorities for scheduling.
Relative to our other issue that you're looking at, this one is definitely
of lower importance, unless it is related in some way to that other problem.

 

 

Thanks,

 

Russell


------=_NextPart_001_002D_01D8FA62.9B7E6300
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><META =
HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word 15 =
(filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US =
link=3D"#0563C1" vlink=3D"#954F72" style=3D'word-wrap:break-word'><div =
class=3DWordSection1><p class=3DMsoNormal>Hello,<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>We are =
seeing an issue with setting thread priorities. I&#8217;m not sure if =
this is a real problem that is contributing to our issues, or if =
it&#8217;s just something weird happening. <o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Here is a =
list of the real time threads and the priority and CPU affinity settings =
we&#8217;re asking for.<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>Thread&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Priority =
&nbsp;CPU<o:p></o:p></p><p =
class=3DMsoNormal>___________________________<o:p></o:p></p><p =
class=3DMsoNormal>Main&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5=
0&nbsp;&nbsp;&nbsp;&nbsp; 0<o:p></o:p></p><p =
class=3DMsoNormal>TxStartup&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;52&nbsp;&nbsp;&nbsp=
;&nbsp; 0<o:p></o:p></p><p =
class=3DMsoNormal>RxStartup&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;51&nbsp;&nbsp;&nbsp=
;&nbsp; 0<o:p></o:p></p><p =
class=3DMsoNormal>DummyTxConfig&nbsp;&nbsp;&nbsp; =
&nbsp;89&nbsp;&nbsp;&nbsp;&nbsp; 2<o:p></o:p></p><p =
class=3DMsoNormal>DummyTxService&nbsp;&nbsp; =
&nbsp;88&nbsp;&nbsp;&nbsp;&nbsp; 3<o:p></o:p></p><p =
class=3DMsoNormal>TxMain&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;87&nbsp=
;&nbsp;&nbsp;&nbsp; 4<o:p></o:p></p><p =
class=3DMsoNormal>TxWorker(n)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;86&nbsp;&nbsp; =
&nbsp;8-11<o:p></o:p></p><p =
class=3DMsoNormal>DummyTxSample&nbsp;&nbsp;&nbsp; =
85&nbsp;&nbsp;&nbsp;&nbsp; 5<o:p></o:p></p><p =
class=3DMsoNormal>DummyRxConfig&nbsp;&nbsp;&nbsp; =
&nbsp;79&nbsp;&nbsp;&nbsp;&nbsp; 2<o:p></o:p></p><p =
class=3DMsoNormal>DummyRxService&nbsp;&nbsp; =
&nbsp;78&nbsp;&nbsp;&nbsp;&nbsp; 3<o:p></o:p></p><p =
class=3DMsoNormal>RxMain&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;77&nbsp;&nbsp;&nbsp;&nbsp; 4<o:p></o:p></p><p =
class=3DMsoNormal>RxWorker(n)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;76&nbsp;&nbsp;&nbsp; =
8-11<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>If we run &#8216;top&#8217; we can see the priority =
settings:<o:p></o:p></p><p class=3DMsoNormal>&nbsp; PID =
USER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PR&nbsp; NI&nbsp;&nbsp;&nbsp; =
VIRT&nbsp;&nbsp;&nbsp; RES&nbsp;&nbsp;&nbsp; SHR S %CPU =
%MEM&nbsp;&nbsp;&nbsp;&nbsp; TIME+ COMMAND<o:p></o:p></p><p =
class=3DMsoNormal>32130 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
20&nbsp;&nbsp; 0 3731268&nbsp;&nbsp; 2.5g 110748 S&nbsp; 0.0 =
16.2&nbsp;&nbsp; 0:05.54 realtime_sfhm<o:p></o:p></p><p =
class=3DMsoNormal>32140 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
20&nbsp;&nbsp; 0 3731268&nbsp;&nbsp; 2.5g 110748 S&nbsp; 0.0 =
16.2&nbsp;&nbsp; 0:00.00 sigthread<o:p></o:p></p><p =
class=3DMsoNormal>32144 root&nbsp;&nbsp;&nbsp;&nbsp; -51&nbsp;&nbsp; 0 =
3731268&nbsp;&nbsp; 2.5g 110748 S&nbsp; 0.0 16.2&nbsp;&nbsp; 0:00.09 =
Main<o:p></o:p></p><p class=3DMsoNormal>32150 =
root&nbsp;&nbsp;&nbsp;&nbsp; -53&nbsp;&nbsp; 0 3731268&nbsp;&nbsp; 2.5g =
110748 S&nbsp; 0.0 16.2&nbsp;&nbsp; 0:00.21 TxStartup<o:p></o:p></p><p =
class=3DMsoNormal>32151 root&nbsp;&nbsp;&nbsp;&nbsp; -86&nbsp;&nbsp; 0 =
3731268&nbsp;&nbsp; 2.5g 110748 S&nbsp; 0.0 16.2&nbsp;&nbsp; 0:00.00 =
DummyTxSample<o:p></o:p></p><p class=3DMsoNormal>32152 =
root&nbsp;&nbsp;&nbsp;&nbsp; -87&nbsp;&nbsp; 0 3731268&nbsp;&nbsp; 2.5g =
110748 S&nbsp; 0.0 16.2&nbsp;&nbsp; 0:00.00 TxWorker0<o:p></o:p></p><p =
class=3DMsoNormal>32153 root&nbsp;&nbsp;&nbsp;&nbsp; -87&nbsp;&nbsp; 0 =
3731268&nbsp;&nbsp; 2.5g 110748 S&nbsp; 0.0 16.2&nbsp;&nbsp; 0:00.00 =
TxWorker1<o:p></o:p></p><p class=3DMsoNormal>32154 =
root&nbsp;&nbsp;&nbsp;&nbsp; -87&nbsp;&nbsp; 0 3731268&nbsp;&nbsp; 2.5g =
110748 S&nbsp; 0.0 16.2&nbsp;&nbsp; 0:00.00 TxWorker2<o:p></o:p></p><p =
class=3DMsoNormal>32155 root&nbsp;&nbsp;&nbsp;&nbsp; -52&nbsp;&nbsp; 0 =
3731268&nbsp;&nbsp; 2.5g 110748 S&nbsp; 0.0 16.2&nbsp;&nbsp; 0:00.13 =
RxStartup<o:p></o:p></p><p class=3DMsoNormal>32156 =
root&nbsp;&nbsp;&nbsp;&nbsp; -87&nbsp;&nbsp; 0 3731268&nbsp;&nbsp; 2.5g =
110748 S&nbsp; 0.0 16.2&nbsp;&nbsp; 0:00.00 TxWorker3<o:p></o:p></p><p =
class=3DMsoNormal>32157 root&nbsp;&nbsp;&nbsp;&nbsp; -88&nbsp;&nbsp; 0 =
3731268&nbsp;&nbsp; 2.5g 110748 S&nbsp; 0.0 16.2&nbsp;&nbsp; 0:00.00 =
TxMain<o:p></o:p></p><p class=3DMsoNormal>32158 =
root&nbsp;&nbsp;&nbsp;&nbsp; -89&nbsp;&nbsp; 0 3731268&nbsp;&nbsp; 2.5g =
110748 S&nbsp; 0.0 16.2&nbsp;&nbsp; 0:00.00 =
DummyTxService<o:p></o:p></p><p class=3DMsoNormal>32159 =
root&nbsp;&nbsp;&nbsp;&nbsp; -80&nbsp;&nbsp; 0 3731268&nbsp;&nbsp; 2.5g =
110748 S&nbsp; 0.0 16.2&nbsp;&nbsp; 0:00.00 =
DummyRxConfig<o:p></o:p></p><p class=3DMsoNormal>32160 =
root&nbsp;&nbsp;&nbsp;&nbsp; -78&nbsp;&nbsp; 0 3731268&nbsp;&nbsp; 2.5g =
110748 S&nbsp; 0.0 16.2&nbsp;&nbsp; 0:00.00 RxMain<o:p></o:p></p><p =
class=3DMsoNormal>32161 root&nbsp;&nbsp;&nbsp;&nbsp; -77&nbsp;&nbsp; 0 =
3731268&nbsp;&nbsp; 2.5g 110748 S&nbsp; 0.0 16.2&nbsp;&nbsp; 0:00.00 =
RxWorker0<o:p></o:p></p><p class=3DMsoNormal>32162 =
root&nbsp;&nbsp;&nbsp;&nbsp; -79&nbsp;&nbsp; 0 3731268&nbsp;&nbsp; 2.5g =
110748 S&nbsp; 0.0 16.2&nbsp;&nbsp; 0:00.00 =
DummyRxService<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Top =
apparently has this weirdness where it displays real-time thread =
priorities as &#8211;(P+1), which I guess is how it&#8217;s maintained =
in the kernel. This seems to be a known issue, but it appears that, with =
this caveat, that the thread priorities are being set properly within =
the pthreads implementation. The two non-realtime threads are part of =
our startup process. They never execute within the EVL context. =
<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>However, if we look at the same threads using =
&#8216;evl ps&#8217;, we get this result:<o:p></o:p></p><p =
class=3DMsoNormal>CPU&nbsp;&nbsp; PID&nbsp;&nbsp; SCHED&nbsp;&nbsp; =
PRIO&nbsp; ISW&nbsp;&nbsp;&nbsp;&nbsp; CTXSW&nbsp;&nbsp;&nbsp;&nbsp; =
SYS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
RWA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; STAT&nbsp;&nbsp;&nbsp;&nbsp; =
TIMEOUT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; %CPU&nbsp;&nbsp; =
CPUTIME&nbsp;&nbsp;&nbsp;&nbsp; NAME<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp; 0&nbsp;&nbsp; 32144&nbsp; =
fifo&nbsp;&nbsp;&nbsp; 50&nbsp;&nbsp; 34&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1316&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2910&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Dto&nbsp;&nbsp;&nbsp;&nbsp; =
011.587&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.0&nbsp; =
00:027.437&nbsp; Main<o:p></o:p></p><p class=3DMsoNormal>&nbsp; =
0&nbsp;&nbsp; 32150&nbsp; fifo&nbsp;&nbsp;&nbsp; 52&nbsp;&nbsp; =
4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1286&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1974&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Dto&nbsp;&nbsp;&nbsp;&nbsp; =
075.003&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.0&nbsp; =
00:023.977&nbsp; TxStartup<o:p></o:p></p><p class=3DMsoNormal>&nbsp; =
5&nbsp;&nbsp; 32151&nbsp; fifo&nbsp;&nbsp;&nbsp; 87&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 51201&nbsp;&nbsp;&nbsp;&nbsp; =
587379&nbsp;&nbsp;&nbsp; 49931&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
wbto&nbsp;&nbsp;&nbsp; 907.752&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.0&nbsp; 01:343.085&nbsp; DummyTxSample<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp; 8&nbsp;&nbsp; 32152&nbsp; =
fifo&nbsp;&nbsp;&nbsp; 87&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 19580&nbsp;&nbsp;&nbsp;&nbsp; =
207489&nbsp;&nbsp;&nbsp; 19653&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
wbto&nbsp;&nbsp;&nbsp; 998.796&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.0&nbsp; 01:240.410&nbsp; TxWorker0<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp; 9&nbsp;&nbsp; 32153&nbsp; =
fifo&nbsp;&nbsp;&nbsp; 87&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 19000&nbsp;&nbsp;&nbsp;&nbsp; =
206602&nbsp;&nbsp;&nbsp; 19071&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
wbto&nbsp;&nbsp;&nbsp; 905.257&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.0&nbsp; 01:242.255&nbsp; TxWorker1<o:p></o:p></p><p =
class=3DMsoNormal>10&nbsp;&nbsp; 32154&nbsp; fifo&nbsp;&nbsp;&nbsp; =
87&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
16976&nbsp;&nbsp;&nbsp;&nbsp; 197880&nbsp;&nbsp;&nbsp; =
17049&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wbto&nbsp;&nbsp;&nbsp; =
901.719&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;1.0&nbsp; =
01:314.756&nbsp; TxWorker2<o:p></o:p></p><p class=3DMsoNormal>&nbsp; =
0&nbsp;&nbsp; 32155&nbsp; fifo&nbsp;&nbsp;&nbsp; 87&nbsp;&nbsp; =
4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
141&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
646&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Dbto&nbsp;&nbsp;&nbsp; 966.055&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0.0&nbsp; 00:007.204&nbsp; RxStartup<o:p></o:p></p><p =
class=3DMsoNormal>11&nbsp;&nbsp; 32156&nbsp; fifo&nbsp;&nbsp;&nbsp; =
87&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
16372&nbsp;&nbsp;&nbsp;&nbsp; 180026&nbsp;&nbsp;&nbsp; =
16439&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wbto&nbsp;&nbsp;&nbsp; =
907.961&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.0&nbsp; =
01:273.781&nbsp; TxWorker3<o:p></o:p></p><p class=3DMsoNormal>&nbsp; =
4&nbsp;&nbsp; 32157&nbsp; fifo&nbsp;&nbsp;&nbsp; 87&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 13443&nbsp;&nbsp;&nbsp;&nbsp; =
851659&nbsp;&nbsp;&nbsp; 13390&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
wto&nbsp;&nbsp;&nbsp;&nbsp; =
902.939&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.5&nbsp; =
01:929.911&nbsp; TxMain<o:p></o:p></p><p class=3DMsoNormal>&nbsp; =
3&nbsp;&nbsp; 32158&nbsp; fifo&nbsp;&nbsp;&nbsp; 88&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1281&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
3845&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Dto&nbsp;&nbsp;&nbsp;&nbsp; =
004.172&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.0&nbsp; =
00:039.957&nbsp; DummyTxService<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp; 2&nbsp;&nbsp; 32159&nbsp; fifo&nbsp; =
&nbsp;&nbsp;87&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
6515&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 260458&nbsp;&nbsp;&nbsp; =
5314&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wbto&nbsp;&nbsp;&nbsp; =
073.624&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.7&nbsp; =
00:858.282&nbsp; DummyRxConfig<o:p></o:p></p><p class=3DMsoNormal>&nbsp; =
4&nbsp;&nbsp; 32160&nbsp; fifo&nbsp;&nbsp;&nbsp; 87&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 49059&nbsp;&nbsp;&nbsp;&nbsp; =
626499&nbsp;&nbsp;&nbsp; 49185&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
wbto&nbsp;&nbsp;&nbsp; 972.854&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
2.4&nbsp; 03:082.805&nbsp; RxMain<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp; 8&nbsp;&nbsp; 32161&nbsp; =
fifo&nbsp;&nbsp;&nbsp; 87&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 33436&nbsp;&nbsp;&nbsp;&nbsp; =
386429&nbsp;&nbsp;&nbsp; 32535&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
wbto&nbsp;&nbsp;&nbsp; 065.114&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.8&nbsp; 02:317.974&nbsp; RxWorker0<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp; 3&nbsp;&nbsp; 32162&nbsp; =
fifo&nbsp;&nbsp;&nbsp; 87&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 37243&nbsp;&nbsp;&nbsp;&nbsp; =
378069&nbsp;&nbsp;&nbsp; 36132&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Dbto&nbsp;&nbsp;&nbsp; 071.350&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1.9&nbsp; 02:374.748&nbsp; DummyRxService<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>CPU affinity =
settings look to be correct, but the priorities shown by &#8216;evl =
ps&#8217; are not consistent with those from &#8216;top&#8217;. =
Furthermore, there seems to be some difference between runs. Sometimes =
the priorities will be closer to those we asked for. At other times it =
looks more like this, where they all appear to be set to =
87.<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>I don&#8217;t know if this is just a mistake by the =
&#8216;evl ps&#8217; command, or if the EVL scheduler is actually using =
the wrong priorities for scheduling. Relative to our other issue that =
you&#8217;re looking at, this one is definitely of lower importance, =
unless it is related in some way to that other problem.<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>Thanks,<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>Russell<o:p></o:p></p></div></body></html>
------=_NextPart_001_002D_01D8FA62.9B7E6300--

------=_NextPart_000_002C_01D8FA62.9B7E3BF0
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCFcgw
ggQyMIIDGqADAgECAgEBMA0GCSqGSIb3DQEBBQUAMHsxCzAJBgNVBAYTAkdCMRswGQYDVQQIDBJH
cmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcMB1NhbGZvcmQxGjAYBgNVBAoMEUNvbW9kbyBDQSBM
aW1pdGVkMSEwHwYDVQQDDBhBQUEgQ2VydGlmaWNhdGUgU2VydmljZXMwHhcNMDQwMTAxMDAwMDAw
WhcNMjgxMjMxMjM1OTU5WjB7MQswCQYDVQQGEwJHQjEbMBkGA1UECAwSR3JlYXRlciBNYW5jaGVz
dGVyMRAwDgYDVQQHDAdTYWxmb3JkMRowGAYDVQQKDBFDb21vZG8gQ0EgTGltaXRlZDEhMB8GA1UE
AwwYQUFBIENlcnRpZmljYXRlIFNlcnZpY2VzMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAvkCd9G7h6naHHE1FRI6+RsiDBp3BKv4YH47kAvrzq11QihYxC5oG0MVwIs1JLVRjzLZuaEYL
U+rLTCTAvHJO6vEVrvRUmhIKw3qyM2Di2olV8yJY897cz++DhqKMlE+faPKYkEaEJ8d2v+PMNSyL
XgdkZYLASLCokflhn3YgUKiRx2a163hiA1bwihoT6jGjHqCZ/Tj29icyWG8H9Wu4+xQrr7eqzNZj
X3OM2gWZqDioyxd4NlGs6Z70eDqNzw/ZQuKYDKsvnw4B3u+fmUnxLd+sdE0bmLVHxeUp0fmQGMdi
nL6DxyZ7Poolx8DdneY1aBAgnY/Y3tLDhJwNXugvyQIDAQABo4HAMIG9MB0GA1UdDgQWBBSgEQoj
PpbxB+zirynvgqV/0DCktDAOBgNVHQ8BAf8EBAMCAQYwDwYDVR0TAQH/BAUwAwEB/zB7BgNVHR8E
dDByMDigNqA0hjJodHRwOi8vY3JsLmNvbW9kb2NhLmNvbS9BQUFDZXJ0aWZpY2F0ZVNlcnZpY2Vz
LmNybDA2oDSgMoYwaHR0cDovL2NybC5jb21vZG8ubmV0L0FBQUNlcnRpZmljYXRlU2VydmljZXMu
Y3JsMA0GCSqGSIb3DQEBBQUAA4IBAQAIVvwC8Jvo/6T61nvGRIDOT8TF9gBYzKa2vBRJaAR26Obu
XewCD2DWjVAYTyZOAePmsKXuv7x0VEG//fwSuMdPWvSJYAV/YLcFSvP28cK/xLl0hrYtfWvM0vNG
3S/G4GrDwzQDLH2W3VrCDqcKmcEFi6sML/NcOs9sN1UJh95TQGxY7/y2q2VuBPYb3DzgWhXGntnx
WUgwIWUDbOzpIXPsmwOh4DetoBUYj/q6As6nLKkQEyzU5QgmqyKXYPiQXnTUoppTvfKpaOCibsLX
bLGjD56/62jnVvKu8uMrODoJgbVrhde+Le0/GreyY+L1YiyC1GoAQVDxOYOflek2lphuMIIFgTCC
BGmgAwIBAgIQOXJEOvkit1HX02wQ3TE1lTANBgkqhkiG9w0BAQwFADB7MQswCQYDVQQGEwJHQjEb
MBkGA1UECAwSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHDAdTYWxmb3JkMRowGAYDVQQKDBFD
b21vZG8gQ0EgTGltaXRlZDEhMB8GA1UEAwwYQUFBIENlcnRpZmljYXRlIFNlcnZpY2VzMB4XDTE5
MDMxMjAwMDAwMFoXDTI4MTIzMTIzNTk1OVowgYgxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpOZXcg
SmVyc2V5MRQwEgYDVQQHEwtKZXJzZXkgQ2l0eTEeMBwGA1UEChMVVGhlIFVTRVJUUlVTVCBOZXR3
b3JrMS4wLAYDVQQDEyVVU0VSVHJ1c3QgUlNBIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MIICIjAN
BgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAgBJlFzYOw9sIs9CsVw127c0n00ytUINh4qogTQkt
ZAnczomfzD2p7PbPwdzx07HWezcoEStH2jnGvDoZtF+mvX2do2NCtnbyqTsrkfjib9DsFiCQCT7i
6HTJGLSR1GJk23+jBvGIGGqQIjy8/hPwhxR79uQfjtTkUcYRZ0YIUcuGFFQ/vDP+fmyc/xadGL1R
jjWmp2bIcmfbIWax1Jt4A8BQOujM8Ny8nkz+rwWWNR9XWrf/zvk9tyy29lTdyOcSOk2uTIq3XJq0
tyA9yn8iNK5+O2hmAUTnAU5GU5szYPeUvlM3kHND8zLDU+/bqv50TmnHa4xgk97Exwzf4TKuzJM7
UXiVZ4vuPVb+DNBpDxsP8yUmazNt925H+nND5X4OpWaxKXwyhGNVicQNwZNUMBkTrNN9N6frXTps
NVzbQdcS2qlJC9/YgIoJk2KOtWbPJYjNhLixP6Q5D9kCnusSTJV882sFqV4Wg8y4Z+LoE53MW4LT
TLPtW//e5XOsIzstAL81VXQJSdhJWBp/kjbmUZIO8yZ9HE0XvMnsQybQv0FfQKlERPSZ51eHnlAf
V1SoPv10Yy+xUGUJ5lhCLkMaTLTwJUdZ+gQek9QmRkpQgbLevni3/GcV4clXhB4PY9bpYrrWX1Uu
6lzGKAgEJTm4Diup8kyXHAc/DVL17e8vgg8CAwEAAaOB8jCB7zAfBgNVHSMEGDAWgBSgEQojPpbx
B+zirynvgqV/0DCktDAdBgNVHQ4EFgQUU3m/WqorSs9UgOHYm8Cd8rIDZsswDgYDVR0PAQH/BAQD
AgGGMA8GA1UdEwEB/wQFMAMBAf8wEQYDVR0gBAowCDAGBgRVHSAAMEMGA1UdHwQ8MDowOKA2oDSG
Mmh0dHA6Ly9jcmwuY29tb2RvY2EuY29tL0FBQUNlcnRpZmljYXRlU2VydmljZXMuY3JsMDQGCCsG
AQUFBwEBBCgwJjAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuY29tb2RvY2EuY29tMA0GCSqGSIb3
DQEBDAUAA4IBAQAYh1HcdCE9nIrgJ7cz0C7M7PDmy14R3iJvm3WOnnL+5Nb+qh+cli3vA0p+rvSN
b3I8QzvAP+u431yqqcau8vzY7qN7Q/aGNnwU4M309z/+3ri0ivCRlv79Q2R+/czSAaF9ffgZGclC
KxO/WIu6pKJmBHaIkU4MiRTOok3JMrO66BQavHHxW/BBC5gACiIDEOUMsfnNkjcZ7Tvx5Dq2+UUT
JnWvu6rvP3t3O9LEApE9GQDTF1w52z97GA1FzZOFli9d31kWTz9RvdVFGD/tSo7oBmF0Ixa1DVBz
J0RHfxBdiSprhTEUxOipakyAvGp4z7h/jnZymQyd/teRCBaho1+VMIIF9TCCBN2gAwIBAgIRAJIF
dv7a2pEWVMfTkiUaPlcwDQYJKoZIhvcNAQELBQAwgZYxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJH
cmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoTD1NlY3RpZ28gTGlt
aXRlZDE+MDwGA1UEAxM1U2VjdGlnbyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1
cmUgRW1haWwgQ0EwHhcNMjIwMzEwMDAwMDAwWhcNMjMwMzEwMjM1OTU5WjCB9jEaMBgGA1UEFBMR
KzEgKDcxOSkgODg0LTYzOTIxDjAMBgNVBBETBTkyMTMxMTIwMAYDVQQKDClLcmF0b3MgRGVmZW5z
ZSAmIFNlY3VyaXR5IFNvbHV0aW9ucywgSW5jLjESMBAGA1UECRMJU3VpdGUgNjAwMRMwEQYDVQQI
EwpDYWxpZm9ybmlhMRIwEAYDVQQHEwlTYW4gRGllZ28xCzAJBgNVBAYTAlVTMRgwFgYDVQQDEw9S
dXNzZWxsIEpvaG5zb24xMDAuBgkqhkiG9w0BCQEWIXJ1c3NlbGwuam9obnNvbkBrcmF0b3NkZWZl
bnNlLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALnh/To9+nijBjtTASsMRaO4
eMR3Oh755HRtJdmmnh8R22FPh0g7SqJ0LqsdxB+F2MZuiATU0yGTqCiipYr7rvJe84G+g7buxK89
qShsTVKg7ho0hYqf5st4OofS70TU6tDSok5DonFeoP13o8WSDj6VaTCgdN4R2EpylpCbkwA0Ztab
OVLXq2c3T/2lYz9E3FktVbyW/g98PMreSQw/YHHVJDHIjRVuHWPDXNxWgL8JhvmBgW/sM0+RbOEB
d8BbpUDKKENyfyh7pyWDuaGdwXgZewYN/rsed9sY3CQbjXdPlkNs2hRr3OBF2x7/r2dxC1WcjAqX
nFpkj5GgZAj9ylkCAwEAAaOCAdowggHWMB8GA1UdIwQYMBaAFAnA8vwL2pTbX/4r36iZQs/J4K0A
MB0GA1UdDgQWBBQozNUBGAya4A+1PrjoDHHIppZKmDAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/
BAIwADAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwQAYDVR0gBDkwNzA1BgwrBgEEAbIx
AQIBAQEwJTAjBggrBgEFBQcCARYXaHR0cHM6Ly9zZWN0aWdvLmNvbS9DUFMwWgYDVR0fBFMwUTBP
oE2gS4ZJaHR0cDovL2NybC5zZWN0aWdvLmNvbS9TZWN0aWdvUlNBQ2xpZW50QXV0aGVudGljYXRp
b25hbmRTZWN1cmVFbWFpbENBLmNybDCBigYIKwYBBQUHAQEEfjB8MFUGCCsGAQUFBzAChklodHRw
Oi8vY3J0LnNlY3RpZ28uY29tL1NlY3RpZ29SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3Vy
ZUVtYWlsQ0EuY3J0MCMGCCsGAQUFBzABhhdodHRwOi8vb2NzcC5zZWN0aWdvLmNvbTAsBgNVHREE
JTAjgSFydXNzZWxsLmpvaG5zb25Aa3JhdG9zZGVmZW5zZS5jb20wDQYJKoZIhvcNAQELBQADggEB
AFr/GaEORVDnaQlG1aZnzFZxeaplFNh2DXG9CRzdu3U6HWBvAYgQqwVxvRD8O8omtchUCTyApdif
jla9M2OlWeyyAqIvCLqgZu7R2YkDuKzrNkyug95yKSUuG6WnFyr62tmlm7/Z/BOwYKdDracwiiJf
1nhhK9tCUhSLEWmNBv6z6rYmszNdajEGuJ4Om2ul76u21GZzvV9xAeCZtzbpQiVK+ib5T8fe/USd
/GIJkUmeyLNip1x1UA6TWJQNM6Y6vBNj2juHeydhVYUwOwrNiBWfYvbzZgbcTkoPjC5zbNf1/ffM
j37+cmagv+vKIk2eZNfvxAw2iHBK/+oQe8fqbZ0wggYQMIID+KADAgECAhBNlCwQ1DvglAnFgS06
KwZPMA0GCSqGSIb3DQEBDAUAMIGIMQswCQYDVQQGEwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEU
MBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoTFVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwG
A1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTAeFw0xODExMDIwMDAw
MDBaFw0zMDEyMzEyMzU5NTlaMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5j
aGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNV
BAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENB
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAyjztlApB/975Rrno1jvm2pK/KxBOqhq8
gr2+JhwpKirSzZxQgT9tlC7zl6hn1fXjSo5MqXUfItMltrMaXqcESJuK8dtK56NCSrq4iDKaKq9N
xOXFmqXX2zN8HHGjQ2b2Xv0v1L5Nk1MQPKA19xeWQcpGEGFUUd0kN+oHox+L9aV1rjfNiCj3bJk6
kJaOPabPi2503nn/ITX5e8WfPnGw4VuZ79Khj1YBrf24k5Ee1sLTHsLtpiK9OjG4iQRBdq6Z/TlV
x/hGAez5h36bBJMxqdHLpdwIUkTqT8se3ed0PewDch/8kHPo5fZl5u1B0ecpq/sDN/5sCG52Ds+Q
U5O5EwIDAQABo4IBZDCCAWAwHwYDVR0jBBgwFoAUU3m/WqorSs9UgOHYm8Cd8rIDZsswHQYDVR0O
BBYEFAnA8vwL2pTbX/4r36iZQs/J4K0AMA4GA1UdDwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDARBgNVHSAECjAIMAYGBFUdIAAwUAYD
VR0fBEkwRzBFoEOgQYY/aHR0cDovL2NybC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJTQUNlcnRp
ZmljYXRpb25BdXRob3JpdHkuY3JsMHYGCCsGAQUFBwEBBGowaDA/BggrBgEFBQcwAoYzaHR0cDov
L2NydC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJTQUFkZFRydXN0Q0EuY3J0MCUGCCsGAQUFBzAB
hhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0GCSqGSIb3DQEBDAUAA4ICAQBBRHUAqznCFfXe
jpVtMnFojADdF9d6HBA4kMjjsb0XMZHztuOCtKF+xswhh2GqkW5JQrM8zVlU+A2VP72Ky2nlRA1G
wmIPgou74TZ/XTarHG8zdMSgaDrkVYzz1g3nIVO9IHk96VwsacIvBF8JfqIs+8aWH2PfSUrNxP6Y
s7U0sZYx4rXD6+cqFq/ZW5BUfClN/rhk2ddQXyn7kkmka2RQb9d90nmNHdgKrwfQ49mQ2hWQNDkJ
JIXwKjYA6VUR/fZUFeCUisdDe/0ABLTI+jheXUV1eoYV7lNwNBKpeHdNuO6Aacb533JlfeUHxvBz
9OfYWUiXu09sMAviM11Q0DuMZ5760CdO2VnpsXP4KxaYIhvqPqUMWqRdWyn7crItNkZeroXaecG0
3i3mM7dkiPaCkgocBg0EBYsbZDZ8bsG3a08LwEsL1Ygz3SBsyECa0waq4hOf/Z85F2w2ZpXfP+w8
q4ifwO90SGZZV+HR/Jh6rEaVPDRF/CEGVqR1hiuQOZ1YL5ezMTX0ZSLwrymUE0pwi/KDaiYB15us
wgeIAcA6JzPFf9pLkAFFWs1QNyN++niFhsM47qodx/PL+5jR87myx5uYdBEQkkDc+lKB1Wct6ucX
qm2EmsaQ0M95QjTmy+rDWjkDYdw3Ms6mSWE3Bn7i5ZgtwCLXgAIe5W8mybM2JzGCBF0wggRZAgEB
MIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQH
EwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNB
IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAkgV2/trakRZUx9OS
JRo+VzANBglghkgBZQMEAgEFAKCCAoEwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG
9w0BCQUxDxcNMjIxMTE3MTU1NzIyWjAvBgkqhkiG9w0BCQQxIgQg9MmPnZ/i97xXdpi65FfLwAkY
Os6/GmlQ8NsoG1XHtTUwgZMGCSqGSIb3DQEJDzGBhTCBgjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAoGCCqGSIb3DQMHMAsGCWCGSAFlAwQBAjAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwIC
AUAwCwYJYIZIAWUDBAIBMAsGCWCGSAFlAwQCAzALBglghkgBZQMEAgIwBwYFKw4DAhowgb0GCSsG
AQQBgjcQBDGBrzCBrDCBljELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3Rl
cjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVT
ZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJIF
dv7a2pEWVMfTkiUaPlcwgb8GCyqGSIb3DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkG
A1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0
aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBh
bmQgU2VjdXJlIEVtYWlsIENBAhEAkgV2/trakRZUx9OSJRo+VzANBgkqhkiG9w0BAQEFAASCAQAU
pydvF6ToV5dz/ZLO4BWVmCJmN1ACcoHLa+9IgbdilM6QroQLyVBZ8wT8DQpyKvaT95HTO42eM4eL
kbCt3UOtrWIrbelbpdhdMsN3c4bL+ny3c1byk18almrKBMXJ4+hD8EAUSBU7SDeofTV+YPxCwVat
hSJ/yGS05o/DB1sAMJ07g5lEBY7uY4eU+UdIwrp6DvXzz0QlcwyNnV/HGhjkUv9zjmBqhKyyrLj3
6y1Fb4UdyD1ik7lntsRoUYTE1Y39QbZihwT0zpfPni2y6hqZWb6CiLkxsPc7STaVB93cFi1KW1u1
ZMDRboQAlpEhqFRIbwBJoaNcLgCr3YiFqii5AAAAAAAA

------=_NextPart_000_002C_01D8FA62.9B7E3BF0--
