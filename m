Received: from mx0a-001f5801.pphosted.com (mx0b-001f5801.pphosted.com [148.163.159.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DACEC0E
	for <xenomai@lists.linux.dev>; Wed,  9 Nov 2022 17:29:21 +0000 (UTC)
Received: from pps.filterd (m0090335.ppops.net [127.0.0.1])
	by mx0b-001f5801.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A9GxfPj026990;
	Wed, 9 Nov 2022 09:04:37 -0800
Received: from usg02-bn3-obe.outbound.protection.office365.us (mail-bn3usg02lp0143.outbound.protection.office365.us [23.103.199.143])
	by mx0b-001f5801.pphosted.com (PPS) with ESMTPS id 3knq0beyhw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Nov 2022 09:04:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=thZhSOHcUczeNSE+HgFceF7CumsvEDFR4vi/gnOlY+Jg0C1Cqka3TU9Cp1nIoXVpn5ld17wfWyQOYM3abhOa2iy8otKgBxcYGCw8ccypvLpr0iaYXdM1H2wPf3u+tNOp5gZaHkq2Jx9uKJibZAlj3xvJzwLAva5471YgtS798k5M2EBK9fQwXPmX3JtVsgaeZEhbrDJpcuBEP0zmC31Xf2BFDc8HixmN0YpZDwQsKIabgGvGZAelkFV8ONpa2E8nddg9sJMCoIrXtnx3D0YHu5CHeTyo0gRdqFhnQ/Xhz55yL7vPUW2pmvn8iFZ32OFvqCcoiHtZvA+OgrXfOcbr4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjkYu5+uxEMxwL/WoZJXP51YMZ0VZjZjXlgM8NIwp2g=;
 b=taxK3xMuGL0fEb7XFGIjveAJLbEqQhVbbBGeMWKyd9RiXVNgoilm25GUomwoUc+4B+NJyswKGXH+rGr2whfGOF+MpcDcSF3+rIEIjjTEPYM/euzR9Cti5er7d6HZ9aCTzxoRqLoSRDcsbjKQASBKCLtTZW1ra8tin9UK6d4f8N/UPUaWA0+5LufDpTeTHgebvSLvUMP8l4fZ04Cr5YPYPawZFSBnAeHNXknZQZAnRzfS/uILu5BclsU4IhuWvdnrC8leJKIzGSm0TGGZP6EzFVFFt/e8Y8eaIcWLKfLT0n8Ine9xw8x3VvhjUIbV50EmlF4jIf/VYvP/UzWCq4GtVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kratosdefense.com; dmarc=pass action=none
 header.from=kratosdefense.com; dkim=pass header.d=kratosdefense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kratosdefense.onmicrosoft.us; s=selector1-kratosdefense-onmicrosoft-us;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjkYu5+uxEMxwL/WoZJXP51YMZ0VZjZjXlgM8NIwp2g=;
 b=kWkxXO8CzOg4v1i213uAxrprZwrz76kqcaaFAJXRWwpdUFiBRIJKiE936I89Hf/KeL+8vPBuzju1APdks3Zg1YzLWi00uKHWiqMEtxGil/Er5ktIOdJJM+dE61lq6YmxiMGoSruNldDZuYtYS/ZZCaGe0Pw4jqZMG7S88DuKaNUsha7dqXL1IzmiK++KQljmRCJP9xmnEL+p4SraFN5MXLT4StNUxRCBFDzfQlu6zVh7RzHZ+1Z7CnusLd0jGLXBoTvEyRmElDgef7A3yK9QFrVrcps5O6MyQvpzHKrziAg93ygpvQ3j965KrARzQQ1xXPPs/WtsnSF4+YPapsI+kQ==
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:176::15)
 by PH1P110MB1620.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:18e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.24; Wed, 9 Nov
 2022 17:04:34 +0000
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::243c:a72b:71b4:9f78]) by PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::243c:a72b:71b4:9f78%4]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 17:04:34 +0000
From: Russell Johnson <russell.johnson@kratosdefense.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>,
        Philippe Gerum
	<rpm@xenomai.org>
CC: Bryan Butler <Bryan.Butler@kratosdefense.com>,
        Shawn McManus
	<shawn.mcmanus@kratosdefense.com>
Subject: EVL Memory
Thread-Topic: EVL Memory
Thread-Index: Adjz0yff24VAOdNORJO8c3TjB/9lSwAgymPQAAE3ZMA=
Date: Wed, 9 Nov 2022 17:04:34 +0000
Message-ID: 
 <PH1P110MB1050307D7FC58A2B99A40094E23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
References: 
 <PH1P110MB1050AD875FCD924D827A0A54E23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB10508DD9688B7D0E82AB30CDE23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
In-Reply-To: 
 <PH1P110MB10508DD9688B7D0E82AB30CDE23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH1P110MB1050:EE_|PH1P110MB1620:EE_
x-ms-office365-filtering-correlation-id: 41f5541d-9516-414b-feeb-08dac2747a28
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 dDOkGUEeHaTAsnsl56H/JXbAyLzp1ggO5aVDF7ULMMAZ4bWpNACVoJ0Wgk2okaxmkBYtt7NMYizlP4hwJ6r/ijmV1371VEG9lIbOALs0VtB4AwVvQUassLJtPuM/m2hmD5KZk7p6YhGNs2L8nFqP63uNLL/zDDz26OnrQf180VVmigMKM/xYWF+b7I40lyKSvciWCN1onQ+o9IbrNvpKNPwPny9oc+pioeVBaiohVDH/MYs9AUlyO0Ej9bXM4Y1QOdqmXOvMoP3X6pUR1oxRiRjvXc14Z1qpgM77IV07tPON96ArMkCFr2yN4G/w18khR50ZzmypwnA9qBOazX9LmD4vlaCG3UxPbJ9SQ+aDO8CFHsbGnOEe3FdNgRybFXD2vJ1HVMtPSddMsKfOCTHfzHD9NiBn8oZ5MKUw61hZnwmN+TUIhd90BdWK06XFYBs20lpKGcgdR9DPrqz11wNnDuzZiijfy7j71dcbio7ugHpERB+SjlJ3eSy25XKWIkC/jRF/WWlFeVP/4duLynK3B8sCCU//1UVY+X+rMtnz8fas8M0qx4hZXlG3cqK3sEUUExtzhUgSiB5RGbdZ9zibzH5M+xcJwHkQmZLOoAUWOomjfPUWKsVJsNtDxdwO59Y8fZ8nSmdUTCYo+OOaoGwOIzoTcfVCl+BdbanP21AU0VhH+PYiifFrfZyfZZYoEdDi
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(366004)(451199015)(54906003)(8676002)(498600001)(64756008)(4326008)(66446008)(7116003)(66556008)(66946007)(110136005)(76116006)(66476007)(55016003)(33656002)(86362001)(5660300002)(38100700002)(83380400001)(44832011)(3480700007)(9326002)(8936002)(2906002)(52536014)(38070700005)(71200400001)(186003)(2940100002)(99936003)(6506007)(122000001)(107886003)(9686003)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 7EuJXdFCwxN9Y/Dzr31dPxP+43QlCRlorYNf3TusRIMs+Akq05GZ43d1zPiRn84VSaAgWOnooZ40kmqLI1VJk3UpUkQ7HQvr7iyZhlPzjWM69Icq3dTPyTblNkYiALmH1bXEPWQPimcs3e+KlAqziRoWFPBg+rKuVLE8dHuChIk+VoUJVxcdyDGIe6lRMujGpFmsjKb3lUoZDRnoSWJXVwBoDkKYV8hNFr69XsyuNfKNi5pcl0GNBiV94N2LvNYd4sgwq60WIKBO2Yt4JDD15taEXo+sj/nMb2M+7qFnRGsi6WNiI+0tG5oiCgwMaBKyF6i4hVa7tdCxiSPbhnZlj+jqnLEASRadIsdHfTGjAN/+CqUr8OE4nQUr4pgpBtmaSjcPf0+adHxAFr6L/U/d8en0nKFmc5xgHMRo5t+cHs8owcmwD0dzSOxvb56UfuWqi34fHmfTzRJv4Qkd1629webgx+C+3mHs4Scxy7Dk0Xg=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=2.16.840.1.101.3.4.2.1;
	boundary="----=_NextPart_000_01AC_01D8F422.AA5210C0"
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: kratosdefense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f5541d-9516-414b-feeb-08dac2747a28
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2022 17:04:34.7536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7932d891-b9cc-431d-be14-d43339fa1133
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH1P110MB1620
X-Proofpoint-GUID: _zRIiL_byR2P4IpKwsYl4JvvN7s7VeK2
X-Proofpoint-ORIG-GUID: _zRIiL_byR2P4IpKwsYl4JvvN7s7VeK2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 clxscore=1011 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211090129

------=_NextPart_000_01AC_01D8F422.AA5210C0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_001_01AD_01D8F422.AA5210C0"


------=_NextPart_001_01AD_01D8F422.AA5210C0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_002_01AE_01D8F422.AA5210C0"


------=_NextPart_002_01AE_01D8F422.AA5210C0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

 

We have been running into some memory issues with our realtime EVL
application. Recently, we are seeing a core dump write immediately on
startup, and when running in the debugger,  the call stack just doesn't make
any sense - it almost seems random. I have the latest EVL kernel built with
all the EVL debug on including the EVL_DEBUG_MEM option, and I also turned
on KASAN. I see no output at all from the kernel when this core dump happens
except for a couple basic lines:

 

EVL: RxMain switching in-band [pid=4327, excpt=14, user_pc=0x0]

RxMain[4327]: segfault at 0 ip 0000000000000000 sp 00007f7ab5305468 error 14
in realtime_sfhm[400000+161000]

Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.

 

I wouldn't say those lines are very helpful. I know that exception 14 on x86
is a page fault and that a pc value of 0 does not seem good (memory
corruption?). 

 

I wanted to get your opinion on our overall memory setup and see if there
are obvious issues or if you had any recommendations of things to try. So we
set up 1 EVL heap on startup of the application, and this heap is used for
all dynamic allocations throughout the entire app as we also overrode global
new/delete to use the EVL heap rather than malloc/free. The reason we
overrode global new/delete is that we have a lot of STL objects as well as
third party libraries that we are using in this app and it would become a
very long and challenging process to actually go through and modify all
those to use custom allocators. So, in main(), we spawn a "Main" EVL thread.
All other threads are spawned from this parent EVL thread. When the EVL Main
thread starts, it sets a static flag that enables using the evl heap in the
global news/deletes, and every library and process for the realtime app is
created and started. We also prefault the EVL heap after it is
initialized/created in order to try to avoid page faults while running the
realtime loop. However, we still see occasional page faults in our realtime
EVL threads while running our main realtime loop. I don't understand how
there could be a page fault if the EVL heap is large enough (verified) and
prefaulted.

 

Now back to the issue mentioned at the beginning of this email - we are
unsure at this time if the page fault error seen there is cause, result, or
primary error causing these core dumps. Typically when I see the occasional
page faults while running other EVL threads in the app, I do not see core
dumps - just the log from the kernel. The only reason why I figured I would
at least run this past you was that I did not see any core dumps when
disabling the flag in the global new/delete and just using malloc/free (of
course I saw some in band switches, but that was it).

 

The issue of occasional page faults, handling dynamic memory allocation
(using global new/delete), and now these possible memory corruption seg
faults is becoming a larger concern for us. We would like to make sure that
we are understanding how to use memory in an EVL application properly, and
we would be interested to know if there are any recommended ways of tracking
these down with an EVL application. I have tried to build/run with the gcc
address sanitizer, but I was seeing issues attaching EVL threads when this
was enabled. I have also tried running valgrind, but that has produced
nothing useful. And, of course, I have run in gdb and the stack traces are
not helpful. At this point, any guidance, thoughts, and/or recommendations
would be greatly appreciated. I added some more clear/specific questions at
the bottom.

 

A few specific questions:

1.	Is this a reasonable model to use for an EVL application, or do you
expect the model to revolve more around static allocation?
2.	Are you aware of people using EVL overriding the global new/delete
to use the EVL heap?
3.	Do you have any tools for debugging the EVL heap or have you adapted
any existing tools (such as valgrind) to debug the EVL heap?
4.	Is there any known way of protecting against a stack overflow?
5.	PC value of 0 is never valid and we have no evidence that we have an
uninitialized pointer in our C++ code. Is there anyway to use info from EVL
to help track down this issue?
6.	We are allocating 2GB of EVL Heap memory and pre-faulting all of it
on startup. We also use pthread_attr_setstacksize to pre-allocate the stack
for each EVL thread we have. EVL still says that we get rare page faults.
How is this possible? Are we missing something? (I have attached our heap
pre-faulting logic)

 

 

Thanks,

 

Russell


------=_NextPart_002_01AE_01D8F422.AA5210C0
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
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:227687421;
	mso-list-template-ids:517744814;}
@list l1
	{mso-list-id:486745222;
	mso-list-type:hybrid;
	mso-list-template-ids:428098478 67698703 67698713 67698715 67698703 =
67698713 67698715 67698703 67698713 67698715;}
@list l1:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US =
link=3D"#0563C1" vlink=3D"#954F72" style=3D'word-wrap:break-word'><div =
class=3DWordSection1><p class=3DMsoNormal>Hello,<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>We have been =
running into some memory issues with our realtime EVL application. =
Recently, we are seeing a core dump write immediately on startup, and =
when running in the debugger, &nbsp;the call stack just doesn&#8217;t =
make any sense &#8211; it almost seems random. I have the latest EVL =
kernel built with all the EVL debug on including the EVL_DEBUG_MEM =
option, and I also turned on KASAN. I see no output at all from the =
kernel when this core dump happens except for a couple basic =
lines:<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>EVL: RxMain switching in-band [pid=3D4327, excpt=3D14, =
user_pc=3D0x0]<o:p></o:p></p><p class=3DMsoNormal>RxMain[4327]: segfault =
at 0 ip 0000000000000000 sp 00007f7ab5305468 error 14 in =
realtime_sfhm[400000+161000]<o:p></o:p></p><p class=3DMsoNormal>Code: =
Unable to access opcode bytes at RIP =
0xffffffffffffffd6.<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>I =
wouldn&#8217;t say those lines are very helpful. I know that exception =
14 on x86 is a page fault and that a pc value of 0 does not seem good =
(memory corruption?). <o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>I wanted to =
get your opinion on our overall memory setup and see if there are =
obvious issues or if you had any recommendations of things to try. So we =
set up 1 EVL heap on startup of the application, and this heap is used =
for all dynamic allocations throughout the entire app as we also =
overrode global new/delete to use the EVL heap rather than malloc/free. =
The reason we overrode global new/delete is that we have a lot of STL =
objects as well as third party libraries that we are using in this app =
and it would become a very long and challenging process to actually go =
through and modify all those to use custom allocators. So, in main(), we =
spawn a &#8220;Main&#8221; EVL thread. All other threads are spawned =
from this parent EVL thread. When the EVL Main thread starts, it sets a =
static flag that enables using the evl heap in the global news/deletes, =
and every library and process for the realtime app is created and =
started. We also prefault the EVL heap after it is initialized/created =
in order to try to avoid page faults while running the realtime loop. =
However, we still see occasional page faults in our realtime EVL threads =
while running our main realtime loop. I don&#8217;t understand how there =
could be a page fault if the EVL heap is large enough (verified) and =
prefaulted.<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>Now back to the issue mentioned at the beginning of =
this email &#8211; we are unsure at this time if the page fault error =
seen there is cause, result, or primary error causing these core dumps. =
Typically when I see the occasional page faults while running other EVL =
threads in the app, I do not see core dumps &#8211; just the log from =
the kernel. The only reason why I figured I would at least run this past =
you was that I did not see any core dumps when disabling the flag in the =
global new/delete and just using malloc/free (of course I saw some in =
band switches, but that was it).<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>The issue of =
occasional page faults, handling dynamic memory allocation (using global =
new/delete), and now these possible memory corruption seg faults is =
becoming a larger concern for us. We would like to make sure that we are =
understanding how to use memory in an EVL application properly, and we =
would be interested to know if there are any recommended ways of =
tracking these down with an EVL application. I have tried to build/run =
with the gcc address sanitizer, but I was seeing issues attaching EVL =
threads when this was enabled. I have also tried running valgrind, but =
that has produced nothing useful. And, of course, I have run in gdb and =
the stack traces are not helpful. At this point, any guidance, thoughts, =
and/or recommendations would be greatly appreciated. I added some more =
clear/specific questions at the bottom.<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>A few =
specific questions:<o:p></o:p></p><ol style=3D'margin-top:0in' start=3D1 =
type=3D1><li class=3DMsoListParagraph =
style=3D'margin-left:0in;mso-list:l1 level1 lfo3'>Is this a reasonable =
model to use for an EVL application, or do you expect the model to =
revolve more around static allocation?<o:p></o:p></li><li =
class=3DMsoListParagraph style=3D'margin-left:0in;mso-list:l1 level1 =
lfo3'>Are you aware of people using EVL overriding the global new/delete =
to use the EVL heap?<o:p></o:p></li><li class=3DMsoListParagraph =
style=3D'margin-left:0in;mso-list:l1 level1 lfo3'>Do you have any tools =
for debugging the EVL heap or have you adapted any existing tools (such =
as valgrind) to debug the EVL heap?<o:p></o:p></li><li =
class=3DMsoListParagraph style=3D'margin-left:0in;mso-list:l1 level1 =
lfo3'>Is there any known way of protecting against a stack =
overflow?<o:p></o:p></li><li class=3DMsoListParagraph =
style=3D'margin-left:0in;mso-list:l1 level1 lfo3'>PC value of 0 is never =
valid and we have no evidence that we have an uninitialized pointer in =
our C++ code. Is there anyway to use info from EVL to help track down =
this issue?<o:p></o:p></li><li class=3DMsoListParagraph =
style=3D'margin-left:0in;mso-list:l1 level1 lfo3'>We are allocating 2GB =
of EVL Heap memory and pre-faulting all of it on startup. We also use =
pthread_attr_setstacksize to pre-allocate the stack for each EVL thread =
we have. EVL still says that we get rare page faults. How is this =
possible? Are we missing something? (I have attached our heap =
pre-faulting logic)<o:p></o:p></li></ol><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>Thanks,<b><span =
style=3D'font-size:10.0pt;font-family:"Arial",sans-serif;color:black'><o:=
p></o:p></span></b></p><p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Arial",sans-serif'><o:p>&nbsp;</o:=
p></span></p><p =
class=3DMsoNormal>Russell<o:p></o:p></p></div></body></html>
------=_NextPart_002_01AE_01D8F422.AA5210C0--

------=_NextPart_001_01AD_01D8F422.AA5210C0
Content-Type: text/plain;
	name="heap_prealloc.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="heap_prealloc.txt"

// Static variables
struct evl_heap heap_manager::s_runtime_heap;
bool heap_manager::s_use_evl =3D false; // Flag used in global =
new/delete to switch between Linux and EVL heaps
size_t heap_manager::s_init_bytes =3D 2147483648; // 2GB

/////////////////////////////////////////////////////////////////////////=
//////
void* heap_manager::alloc_block(size_t bytes)
{
    void* data =3D evl_alloc_block(&s_runtime_heap, bytes);
    if (data =3D=3D NULL)
    {
        // Switch back to Linux heap to avoid infinite alloc loop
        s_use_evl =3D false;
        throw(std::runtime_error("Error allocating a block on the EVL =
heap"));
    }
    return data;
}

/////////////////////////////////////////////////////////////////////////=
//////
void heap_manager::free_block(void* block)
{
    int ret =3D evl_free_block(&s_runtime_heap, block);
    if (ret < 0)
    {
        sfhm::rtString msg;
        msg.Format("%s:%d: Error freeing a block on the EVL heap", =
__FILE__, __LINE__);
        throw(std::system_error(ret, std::generic_category(), msg));
    }
}

/////////////////////////////////////////////////////////////////////////=
//////
void heap_manager::prefault()
{
    char *dummy =3D (char*)alloc_block(s_init_bytes);
    for (size_t i =3D 0; i < s_init_bytes; i +=3D sysconf(_SC_PAGESIZE))
        dummy[i] =3D 1; =20
    free_block(dummy);
}


------=_NextPart_001_01AD_01D8F422.AA5210C0--

------=_NextPart_000_01AC_01D8F422.AA5210C0
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
9w0BCQUxDxcNMjIxMTA5MTcwNDMzWjAvBgkqhkiG9w0BCQQxIgQgv6+zeJEqEllkTiVZg2dWXVu+
W4hwZ08Oi4SOmmxSCGwwgZMGCSqGSIb3DQEJDzGBhTCBgjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAoGCCqGSIb3DQMHMAsGCWCGSAFlAwQBAjAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwIC
AUAwCwYJYIZIAWUDBAIBMAsGCWCGSAFlAwQCAzALBglghkgBZQMEAgIwBwYFKw4DAhowgb0GCSsG
AQQBgjcQBDGBrzCBrDCBljELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3Rl
cjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVT
ZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJIF
dv7a2pEWVMfTkiUaPlcwgb8GCyqGSIb3DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkG
A1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0
aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBh
bmQgU2VjdXJlIEVtYWlsIENBAhEAkgV2/trakRZUx9OSJRo+VzANBgkqhkiG9w0BAQEFAASCAQBI
rEYClVakAsESxfP7fuYfTGKfs7YZyUUtiybyM8EdbOgW2d3Emg7AFJgonQc5stQN7BTd77lj6teH
18cBV6qt3w/8Rl1UHNtRD2vlZ2ossn6jdSAYM5cSfv5E7KYtDYmzSmanLQRwxmJxhUypKBAXed48
P1gCWggsFWK4+PVYU8HEHdCQgeoGwRbXB43zl43QqU4WLH/jWdqOLkAd65rcI87MAk26DmBQdSm6
sgNiXQlmCQZJaCf7oSU5bPoXbYF+I2k27ya9WVrKH2BYIOltlb5gZKCvnpanlxq0xwoTgz3DyvJv
8E722jjDl4IF2kxXCnIFgGP7i3m/ylJGgZ9eAAAAAAAA

------=_NextPart_000_01AC_01D8F422.AA5210C0--
