Received: from mx0a-001f5801.pphosted.com (mx0a-001f5801.pphosted.com [148.163.157.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33E64A09
	for <xenomai@lists.linux.dev>; Fri, 19 Aug 2022 19:14:45 +0000 (UTC)
Received: from pps.filterd (m0090334.ppops.net [127.0.0.1])
	by mx0a-001f5801.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27JFQHLv021180
	for <xenomai@lists.linux.dev>; Fri, 19 Aug 2022 12:14:45 -0700
Received: from usg02-cy1-obe.outbound.protection.office365.us (mail-cy1usg02lp0177.outbound.protection.office365.us [23.103.199.177])
	by mx0a-001f5801.pphosted.com (PPS) with ESMTPS id 3j1q70bkpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <xenomai@lists.linux.dev>; Fri, 19 Aug 2022 12:14:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=iU0Pk6ahQGnpOvTh81k8qHf2eEkUR7dZTYSr9H19GG7WQX7aKWO2JnorPsXUuOXVWn2LETdLNN8rQBAsbDTvKUkFmZu6qyUjGHejtuCLoCEhyNCd/NvfoKY6/s2oQy31pZYKBF5WaUioGyxyVNI7v3AfplkKic4S3YVs5uJX8853DGF9hJHgH17gHmTQuUT0ub886905+bwAWrQDSF01Ml9FNNKCjLVi59AVq1m2aLo57kKQEpSllRX0uxAAgIUCGVy0aes10h5672MXOqEcM561MU4ygbMFiIErlgTx9RzKzKxH+pUTtFuWTq7dVYrV8eEwmkf+/HcE4rQzNSGyDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSKbc6EYV5KRqGsjUn/BshgAL81IdDg9L9XTp741/5k=;
 b=bDXrOU12cgloRVrdxgwEi/oeGMDzQbu7ObU1X9hC0aO+1R5WgvMCwxQ40Y29ZgpMp+PJkMwwvgjzU7ChylypC+uqtRHj9mD7lr/RHCWcEvuX41k2Vb0FSFBG1V3fBhlrH5vAKJaHxjvENn4BvYsnX+nG9xg5gUwPDMKZ9j08uv1C29k5/muboIn/1v1MtC6geJtPTA6bLkSNlg24VX+TMrXU1eVnPaUJkedcwxufM9Yb2DleUr3TMX9tHXgEP7B26AOTE2WjAxMNgdzRH0Who4P/ToRcHTt3fDZzm3TWBza5rVUpqHapUH7WW6ubHD368j/hDp7PHZkEFnEeWHN+AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kratosdefense.com; dmarc=pass action=none
 header.from=kratosdefense.com; dkim=pass header.d=kratosdefense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kratosdefense.onmicrosoft.us; s=selector1-kratosdefense-onmicrosoft-us;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSKbc6EYV5KRqGsjUn/BshgAL81IdDg9L9XTp741/5k=;
 b=AzRzZkUJe/D392WHPm+BaCZP4Fdy3+r8yGUeaP2XXvA8XqlrRtcVJiJCHefjZgDDEANoECA7loiV8I98vGLPv2a2P+I2sTvg7RWsC44YFJK7npnB8cis0PbFBBr9HjUL3NDtC3uvfsekH6MGgYQyH7NcPqoc8YENrRa/sy+sjDZ/2LY2cx1XD4FaloDJbaEsowQP5qH1Bnc/p3F09T+P7VKM8QYXBGBlI0hSuHVhcn+CeCtMxp6hQia9rCwpYQWgHB7CrzHauk0ISXWZcrJA+XTIaX6q5y5P41Xo5GJ2pa+UBFHlKeE+HZuKjD6t80JgWPkUvyCaqepE4erCnK0wWg==
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:176::15)
 by PH1P110MB1396.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:189::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.15; Fri, 19 Aug
 2022 19:14:43 +0000
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::f968:7cdd:eff1:e547]) by PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::f968:7cdd:eff1:e547%6]) with mapi id 15.20.5525.010; Fri, 19 Aug 2022
 19:14:43 +0000
From: Russell Johnson <russell.johnson@kratosdefense.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: Weird GDB behavior with parent/child EVL threads
Thread-Topic: Weird GDB behavior with parent/child EVL threads
Thread-Index: Adiz+qiZ/e1HxEuNTQ2TkgbZB+6zfQABO07w
Date: Fri, 19 Aug 2022 19:14:43 +0000
Message-ID: 
 <PH1P110MB1050DADF4DA216989262F434E26C9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
References: 
 <PH1P110MB10502931ADF4B99016ABBCFDE26C9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
In-Reply-To: 
 <PH1P110MB10502931ADF4B99016ABBCFDE26C9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dbef0a0e-d2e8-44f1-d97a-08da82171266
x-ms-traffictypediagnostic: PH1P110MB1396:EE_
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 JnPgQGMnhkfLt5TL7d96ogfdcDAI4CztxapItMnSGUIxR/a1fxxJDjPbf7n2tx/yYgrU0+Dk6/kJaw2IjA6ERCzC0olPdnvUS0sWPFsppfhtWtic4mmFukNninUc4GKyXCCp35Tk5VPsSjU7he4ArmcWEjmhW3aFKVI1oGdp1VgYq4brMvk4k/lYQ2VIUA5hVR3pssQLzVVClcnhkcGbFsuqD3FDDuQUJOHEYOz3LECmwzwUU2S7G/aznCLzYkteJDAXNe7ia8nWnu1gp70BLrlNPonnCg/QKrqOgdnc22AZRFWwQ/4TyUgs2637V24HiZ4+v+FZZouyFEHnkp4CUHxvz4hyiT9E0MEU985Q7FxuaZbkwsHBJIbu7wez3jC+Jz+BaPOkPS+gy6kzo6NGe4EhJV7TzVWMC3bmzP970Mh6KixLycoP53daBGORH0UNsJncRryIXTRNdj5ZtWNBD4vUSe9T/ND0hMbooZu6GEuhUJruqvuTJDAQ+2PlFPMq2GvgCiBPhowrBW+tvhu7j4WncPQhCuMzQBoDWLps0tMaweT0QY4Po8ADGrSv3d4CLdCEEcP4RODJV4jPu33EglONI6eXfFdVdNcDjm1vHDUgTsFgOT4amwEuIFjKBznshSFiJGsTjWIcwXBoBh5UMB9lSy9dExObR5LVEW8LlN4qyxm3r27DiDQ0fHbOIpao
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(366004)(38070700005)(186003)(83380400001)(86362001)(38100700002)(66556008)(66446008)(99936003)(66476007)(122000001)(66946007)(76116006)(8676002)(64756008)(6916009)(55016003)(2906002)(52536014)(44832011)(5660300002)(8936002)(33656002)(2940100002)(71200400001)(498600001)(6506007)(7696005)(53546011)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 reotxou/qHn3Iq54aXsomHB0w6g2D/cWhlIqCsJt5GX3EW+3sdd/0n4R5Z7wc3Clx9BdX1aVnTJtjfkSJiwPCR+aj23bu98ASgia3UJ1+jCrC5WK4O65xq13f2NGQewyPiSc2wJaHQwLOS6qYpTF8fcDKJaHBXVaclQqPehg2fExKSWWkEQHNbLfH/laSM9X36gbXsUeIOp8SGOPqO108RE7bi/zY2PMza0lauvW0WJ/p/BMSk9A0SMH6QJZoK0RN2bNrPcBGTOwIXe18y2VbTmCZEcBu3CouiP1ERO8LA+BXfIT5rbWJOmTObxMaNMsQtZ6nJrOqcU4cdlgVUxlD+WS6eeeg/83RCmcR5Kz28v5I1TuZFoZUINX09l5O6UvM1yCzjKR3tqR83u25AhNR15xkgJbgywM/grlp3dcEmjMGIenYiOaZ3xUX5aXUHu2uk8yFh23qfnLpdH8sYMez9dXA6IAnOHiq/fQac9+LWM=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=2.16.840.1.101.3.4.2.1;
	boundary="----=_NextPart_000_0174_01D8B3CD.A4202FB0"
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: kratosdefense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: dbef0a0e-d2e8-44f1-d97a-08da82171266
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 19:14:43.0779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7932d891-b9cc-431d-be14-d43339fa1133
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH1P110MB1396
X-Proofpoint-GUID: fE0caUbFX6G-AjaoeueLbNwF3eZVigMA
X-Proofpoint-ORIG-GUID: fE0caUbFX6G-AjaoeueLbNwF3eZVigMA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_10,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 mlxscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208190072

------=_NextPart_000_0174_01D8B3CD.A4202FB0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_0175_01D8B3CD.A4202FB0"


------=_NextPart_001_0175_01D8B3CD.A4202FB0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Turns out that it may have been a gdb version issue... I am using CentOS7
which natively has gdb7, and when I upgraded to gdb8, it appears to work
okay now. Sorry for the false alarm.

 

From: Russell Johnson 
Sent: Friday, August 19, 2022 12:44 PM
To: xenomai@lists.linux.dev
Subject: Weird GDB behavior with parent/child EVL threads

 

I put together a very simple standalone test app to re-create an issue I am
seeing in my own app. The scenario is simple: I spawn a parent evl thread in
main, and the parent evl threads spawns two evl child threads (each child
prints their name every second so you know they are alive). This runs great
outside of gdb - you see both children printing their name out every second,
and "evl ps -l" shows all 3 evl threads as expected. However, when you go to
run this in gdb, you only see the parent and the first child in "evl ps -l",
and that one child prints out its name only once - the second child does not
get created/tracked and there are no prints to the console showing that they
are alive. I have not seen any issues if I create multiple evl threads
directly in main; I have only seen this issue when main creates one parent
evl thread that then spawns all the child evl threads for the app. Any
insight into why I am seeing this behavior? I have pasted in my code to
re-create this scenario.

 

// g++ -Wall -g -o test test.cpp -I/opt/evl/include -L/opt/evl/lib -levl
-lpthread

#include <evl/evl.h>

#include <evl/thread.h>

#include <evl/clock.h>

#include <thread>

#include <unistd.h>

 

void* Child1(void*)

{

    pthread_setname_np(pthread_self(), "Child1");

 

    int fd = evl_attach_thread(EVL_CLONE_OBSERVABLE | EVL_CLONE_NONBLOCK,
"Child1");

    if (fd < 0)

    {

        evl_printf("Failed to attach to thread\n");

        return nullptr;

    }

    evl_set_thread_mode(fd, T_HMSIG | T_WOSS | T_WOLI | T_WOSX, NULL);

 

    while(true)

    {

        evl_printf("Child 1\n");

        evl_usleep(100000);

    }

}

 

void* Child2(void*)

{

    pthread_setname_np(pthread_self(), "Child2");

 

    int fd = evl_attach_thread(EVL_CLONE_OBSERVABLE | EVL_CLONE_NONBLOCK,
"Child2");

    if (fd < 0)

    {

        evl_printf("Failed to attach to thread\n");

        return nullptr;

    }

    evl_set_thread_mode(fd, T_HMSIG | T_WOSS | T_WOLI | T_WOSX, NULL);

 

    while(true)

    {

        evl_printf("Child 2\n");

        evl_usleep(100000);

    }

}

 

void* Parent(void*)

{

    pthread_setname_np(pthread_self(), "Parent");

 

    int fd = evl_attach_thread(EVL_CLONE_OBSERVABLE | EVL_CLONE_NONBLOCK,
"Parent");

   if (fd < 0)

    {

        evl_printf("Failed to attach to thread\n");

        return nullptr;

    }

 

    // Spawn child 1

    pthread_attr_t tattr;

    sched_param param;

    pthread_t tid;

    cpu_set_t tkcpu;

    CPU_ZERO(&tkcpu);

    CPU_SET(4, &tkcpu);

    pthread_attr_init(&tattr);

    pthread_attr_getschedparam(&tattr, &param);

    pthread_attr_setstacksize(&tattr, 1024*1024);

    pthread_attr_setaffinity_np(&tattr, sizeof(cpu_set_t), &tkcpu);

    pthread_attr_setschedpolicy(&tattr, SCHED_FIFO);

    param.sched_priority = 96;

    pthread_attr_setschedparam(&tattr, &param);

    pthread_attr_setinheritsched(&tattr, PTHREAD_EXPLICIT_SCHED);

    pthread_create(&tid, &tattr, Child1, NULL);

 

    // Spawn child 2

   pthread_attr_t tattr2;

    sched_param param2;

    pthread_t tid2;

    cpu_set_t tkcpu2;

    CPU_ZERO(&tkcpu2);

    CPU_SET(5, &tkcpu2);

    pthread_attr_init(&tattr2);

    pthread_attr_getschedparam(&tattr2, &param2);

    pthread_attr_setstacksize(&tattr2, 1024*1024);

    pthread_attr_setaffinity_np(&tattr2, sizeof(cpu_set_t), &tkcpu2);

    pthread_attr_setschedpolicy(&tattr2, SCHED_FIFO);

    param2.sched_priority = 95;

    pthread_attr_setschedparam(&tattr2, &param2);

    pthread_attr_setinheritsched(&tattr2, PTHREAD_EXPLICIT_SCHED);

    pthread_create(&tid2, &tattr2, Child2, NULL);

               

    // Do not exit so we can see stats

    while (true)

    {

        evl_usleep(100000);

    }

}

 

int main(int argc, char *argv[])

{

    // Init EVL

    int ret = evl_init();

   if (ret != 0)

    {

        printf("EVL Init failed with error: %d\n", ret);

        return -1;

    }

 

    // Create parent

    pthread_attr_t tattr;

    sched_param param;

    pthread_t tid;

    cpu_set_t tkcpu;

    CPU_ZERO(&tkcpu);

    CPU_SET(3, &tkcpu);

    pthread_attr_init(&tattr);

    pthread_attr_getschedparam(&tattr, &param);

    pthread_attr_setstacksize(&tattr, 1024*1024);

    pthread_attr_setaffinity_np(&tattr, sizeof(cpu_set_t), &tkcpu);

    pthread_attr_setschedpolicy(&tattr, SCHED_FIFO);

    param.sched_priority = 97;

    pthread_attr_setschedparam(&tattr, &param);

    pthread_attr_setinheritsched(&tattr, PTHREAD_EXPLICIT_SCHED);

    pthread_create(&tid, &tattr, Parent, NULL);

 

    // Do not exit so we can see stats

    while(true)

    {

        sleep(1);

    }

 

    return 0;

}


------=_NextPart_001_0175_01D8B3CD.A4202FB0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta =
http-equiv=3DContent-Type content=3D"text/html; =
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
span.EmailStyle19
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
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US =
link=3D"#0563C1" vlink=3D"#954F72" style=3D'word-wrap:break-word'><div =
class=3DWordSection1><p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Arial",sans-serif;color:black'>Tur=
ns out that it may have been a gdb version issue... I am using CentOS7 =
which natively has gdb7, and when I upgraded to gdb8, it appears to work =
okay now&#8230; Sorry for the false alarm.<o:p></o:p></span></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><div><div =
style=3D'border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in'><p class=3DMsoNormal><b>From:</b> Russell Johnson =
<br><b>Sent:</b> Friday, August 19, 2022 12:44 PM<br><b>To:</b> =
xenomai@lists.linux.dev<br><b>Subject:</b> Weird GDB behavior with =
parent/child EVL threads<o:p></o:p></p></div></div><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>I put =
together a very simple standalone test app to re-create an issue I am =
seeing in my own app. The scenario is simple: I spawn a parent evl =
thread in main, and the parent evl threads spawns two evl child threads =
(each child prints their name every second so you know they are alive). =
This runs great outside of gdb &#8211; you see both children printing =
their name out every second, and &#8220;evl ps -l&#8221; shows all 3 evl =
threads as expected. However, when you go to run this in gdb, you only =
see the parent and the first child in &#8220;evl ps -l&#8221;, and that =
one child prints out its name only once &#8211; the second child does =
not get created/tracked and there are no prints to the console showing =
that they are alive. I have not seen any issues if I create multiple evl =
threads directly in main; I have only seen this issue when main creates =
one parent evl thread that then spawns all the child evl threads for the =
app. Any insight into why I am seeing this behavior? I have pasted in my =
code to re-create this scenario.<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>// g++ -Wall =
-g -o test test.cpp -I/opt/evl/include -L/opt/evl/lib -levl =
-lpthread<o:p></o:p></p><p class=3DMsoNormal>#include =
&lt;evl/evl.h&gt;<o:p></o:p></p><p class=3DMsoNormal>#include =
&lt;evl/thread.h&gt;<o:p></o:p></p><p class=3DMsoNormal>#include =
&lt;evl/clock.h&gt;<o:p></o:p></p><p class=3DMsoNormal>#include =
&lt;thread&gt;<o:p></o:p></p><p class=3DMsoNormal>#include =
&lt;unistd.h&gt;<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>void* =
Child1(void*)<o:p></o:p></p><p class=3DMsoNormal>{<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; pthread_setname_np(pthread_self(), =
&quot;Child1&quot;);<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; int fd =3D =
evl_attach_thread(EVL_CLONE_OBSERVABLE | EVL_CLONE_NONBLOCK, =
&quot;Child1&quot;);<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; if (fd &lt; 0)<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; {<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
evl_printf(&quot;Failed to attach to thread\n&quot;);<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
nullptr;<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; =
}<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; =
evl_set_thread_mode(fd, T_HMSIG | T_WOSS | T_WOLI | T_WOSX, =
NULL);<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; while(true)<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; {<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
evl_printf(&quot;Child 1\n&quot;);<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
evl_usleep(100000);<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; }<o:p></o:p></p><p =
class=3DMsoNormal>}<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>void* =
Child2(void*)<o:p></o:p></p><p class=3DMsoNormal>{<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; pthread_setname_np(pthread_self(), =
&quot;Child2&quot;);<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; int fd =3D =
evl_attach_thread(EVL_CLONE_OBSERVABLE | EVL_CLONE_NONBLOCK, =
&quot;Child2&quot;);<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; if (fd &lt; 0)<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; {<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
evl_printf(&quot;Failed to attach to thread\n&quot;);<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
nullptr;<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; =
}<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; =
evl_set_thread_mode(fd, T_HMSIG | T_WOSS | T_WOLI | T_WOSX, =
NULL);<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; while(true)<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; {<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
evl_printf(&quot;Child 2\n&quot;);<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
evl_usleep(100000);<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; }<o:p></o:p></p><p =
class=3DMsoNormal>}<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>void* =
Parent(void*)<o:p></o:p></p><p class=3DMsoNormal>{<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; pthread_setname_np(pthread_self(), =
&quot;Parent&quot;);<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; int fd =3D =
evl_attach_thread(EVL_CLONE_OBSERVABLE | EVL_CLONE_NONBLOCK, =
&quot;Parent&quot;);<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;if (fd &lt; 0)<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; {<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
evl_printf(&quot;Failed to attach to thread\n&quot;);<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
nullptr;<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; =
}<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; // Spawn child 1<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; pthread_attr_t =
tattr;<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; sched_param =
param;<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; pthread_t =
tid;<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; cpu_set_t =
tkcpu;<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; =
CPU_ZERO(&amp;tkcpu);<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; CPU_SET(4, =
&amp;tkcpu);<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; =
pthread_attr_init(&amp;tattr);<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; =
pthread_attr_getschedparam(&amp;tattr, &amp;param);<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; =
pthread_attr_setstacksize(&amp;tattr, 1024*1024);<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; =
pthread_attr_setaffinity_np(&amp;tattr, sizeof(cpu_set_t), =
&amp;tkcpu);<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; =
pthread_attr_setschedpolicy(&amp;tattr, SCHED_FIFO);<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; param.sched_priority =3D =
96;<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; =
pthread_attr_setschedparam(&amp;tattr, &amp;param);<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; =
pthread_attr_setinheritsched(&amp;tattr, =
PTHREAD_EXPLICIT_SCHED);<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; pthread_create(&amp;tid, =
&amp;tattr, Child1, NULL);<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; // Spawn child 2<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;pthread_attr_t =
tattr2;<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; =
sched_param param2;<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; pthread_t tid2;<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; cpu_set_t tkcpu2;<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; =
CPU_ZERO(&amp;tkcpu2);<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; CPU_SET(5, =
&amp;tkcpu2);<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; =
pthread_attr_init(&amp;tattr2);<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; =
pthread_attr_getschedparam(&amp;tattr2, &amp;param2);<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; =
pthread_attr_setstacksize(&amp;tattr2, 1024*1024);<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; =
pthread_attr_setaffinity_np(&amp;tattr2, sizeof(cpu_set_t), =
&amp;tkcpu2);<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; =
pthread_attr_setschedpolicy(&amp;tattr2, SCHED_FIFO);<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; param2.sched_priority =3D =
95;<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; =
pthread_attr_setschedparam(&amp;tattr2, &amp;param2);<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; =
pthread_attr_setinheritsched(&amp;tattr2, =
PTHREAD_EXPLICIT_SCHED);<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; pthread_create(&amp;tid2, =
&amp;tattr2, Child2, NULL);<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; // Do not exit so we can see =
stats<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; while =
(true)<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; =
{<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
evl_usleep(100000);<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; }<o:p></o:p></p><p =
class=3DMsoNormal>}<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>int main(int =
argc, char *argv[])<o:p></o:p></p><p =
class=3DMsoNormal>{<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; // Init EVL<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; int ret =3D =
evl_init();<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp;if (ret =
!=3D 0)<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; =
{<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
printf(&quot;EVL Init failed with error: %d\n&quot;, =
ret);<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
-1;<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; =
}<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; // Create parent<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; pthread_attr_t =
tattr;<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; sched_param =
param;<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; pthread_t =
tid;<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; cpu_set_t =
tkcpu;<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; =
CPU_ZERO(&amp;tkcpu);<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; CPU_SET(3, =
&amp;tkcpu);<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; =
pthread_attr_init(&amp;tattr);<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; =
pthread_attr_getschedparam(&amp;tattr, &amp;param);<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; =
pthread_attr_setstacksize(&amp;tattr, 1024*1024);<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; =
pthread_attr_setaffinity_np(&amp;tattr, sizeof(cpu_set_t), =
&amp;tkcpu);<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; =
pthread_attr_setschedpolicy(&amp;tattr, SCHED_FIFO);<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; param.sched_priority =3D =
97;<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; =
pthread_attr_setschedparam(&amp;tattr, &amp;param);<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; =
pthread_attr_setinheritsched(&amp;tattr, =
PTHREAD_EXPLICIT_SCHED);<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; pthread_create(&amp;tid, =
&amp;tattr, Parent, NULL);<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; // Do not exit so we can see =
stats<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; =
while(true)<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; =
{<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
sleep(1);<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; =
}<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p><p =
class=3DMsoNormal>}<o:p></o:p></p></div></body></html>
------=_NextPart_001_0175_01D8B3CD.A4202FB0--

------=_NextPart_000_0174_01D8B3CD.A4202FB0
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
9w0BCQUxDxcNMjIwODE5MTkxNDQxWjAvBgkqhkiG9w0BCQQxIgQgiui4hrdzneZx/k8Jp4xx6sWt
3mmtNtBLbaczD9RWHBQwgZMGCSqGSIb3DQEJDzGBhTCBgjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAoGCCqGSIb3DQMHMAsGCWCGSAFlAwQBAjAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwIC
AUAwCwYJYIZIAWUDBAIBMAsGCWCGSAFlAwQCAzALBglghkgBZQMEAgIwBwYFKw4DAhowgb0GCSsG
AQQBgjcQBDGBrzCBrDCBljELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3Rl
cjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVT
ZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJIF
dv7a2pEWVMfTkiUaPlcwgb8GCyqGSIb3DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkG
A1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0
aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBh
bmQgU2VjdXJlIEVtYWlsIENBAhEAkgV2/trakRZUx9OSJRo+VzANBgkqhkiG9w0BAQEFAASCAQBR
hwknoocCMq9VGmp0o1bDIOky2jZAeGrNbNGztRfhBDgOR+/w2O+icDXL8pleN+JOkrvWC9o3j9zd
t2ZWjwTSH2Q1kuuBL23KWyT66O4oJmtIYmihq8dhV7uIwOTI4AaHkQH1+ZEBWUT9tu/oEvaExXqq
pniLsvt0IXvkIn/xJ/mXaNtLrBNVBJF1ayG6G2IQXZmN4CJEfT1IJnhrPIA6AZFEz3idvbkftzxu
Inld5of+6lU6wR0OVevoChtKjdXRESRQ+tGeiyVZqM+TP4DaMOzpk9eR93Zgyb1HSIUDGAD7ie/I
MElrkxo0IueA4xg/Kw8wVopLihz1dw2RjZtDAAAAAAAA

------=_NextPart_000_0174_01D8B3CD.A4202FB0--
