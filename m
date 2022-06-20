Received: from mx0a-001f5801.pphosted.com (mx0b-001f5801.pphosted.com [148.163.159.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469A82562
	for <xenomai@lists.linux.dev>; Mon, 20 Jun 2022 15:27:00 +0000 (UTC)
Received: from pps.filterd (m0090335.ppops.net [127.0.0.1])
	by mx0b-001f5801.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25KBt6jR029135
	for <xenomai@lists.linux.dev>; Mon, 20 Jun 2022 08:17:25 -0700
Received: from usg02-bn3-obe.outbound.protection.office365.us (mail-bn3usg02lp0147.outbound.protection.office365.us [23.103.199.147])
	by mx0b-001f5801.pphosted.com (PPS) with ESMTPS id 3gsdvau1t0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <xenomai@lists.linux.dev>; Mon, 20 Jun 2022 08:17:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=dQamn9KlX3yO0VcFqDCx5wd2jMKMIytT3pO3eZ6MDlPARy2sI48D+DFjoTdHNcMofd7hjSQuaJW9VosxOzYEFMhvwr63Hza+8tuI5fYFC9TN6r3dBsmew7dAnDvLJsckA7crzoczEUvhF2RFh3pL349ml09uajeEbrMu3q63otz9wC1jrwlioNrwMdhUSgd/ZUL7nr4GrgnwKgTo1aAUes5bBLeeFD4kNkzQvT1q98Ftmtz4qPCNNqOKLAjsjYQrJIJGzIEfNbAspjZ8beFH+W98T96F1SHFrBPdRrWve3WJaVLKJfPSwO90HbKxf44E5Q58sjyEdIstnreI+2GZMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPYnPpL92Zd2mEaEAYBxGzFrV4SfbTC+dMLuRujI1fQ=;
 b=i4S803WUB/rV7mNCdVmcPKJgQVhPJf81J4qFAO6PVCnzlA6pcMUlMb8L81TmRdNqoupaH05FVnirFWQAPsR4KChEOI99kaGdJtotbsZJMjVnkq9EwRJKwNqvpcN7crSfF+Q4krDbKqGjn8WaUzKhvCT2sOJDhLIN14HBuseZBdZ2dvuba0TcGhA+DWLnKfq6CvtXo+NCshqJt5coeBU9Ha52cXpERTyqlv7cs5OXhM6VuurgKC0qodtysznd8IuEZEys5yVLYiONnbgu+1rzVhWnasOEfG/2PPzyY4n3UYfpCsfj8E4t1o8QY+r+GlQzp6GSIugg41Xs0HOYwlx3tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kratosdefense.com; dmarc=pass action=none
 header.from=kratosdefense.com; dkim=pass header.d=kratosdefense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kratosdefense.onmicrosoft.us; s=selector1-kratosdefense-onmicrosoft-us;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPYnPpL92Zd2mEaEAYBxGzFrV4SfbTC+dMLuRujI1fQ=;
 b=LaWBC61KCl5OtfAW9RHi0NjM7DjQDDII+5uxm8fWRwNZNoB69kMlJZwzwO0mUVly/fmifLEXPNxn3BBEfBQofTIMZGaNRpDrGALCAWXKAQMXR8A+YRWapf6nsFjrpeaZHRaEMgC7RPJUxEIIIRcFhyeji5YFuWwIcOFjakmJx9NQz8XrVbJeJc/RR77RNxYS9qBadh0dD3roRKUB67+fd310Y6WYktj7skEzS1OdY9pBztzPoBznrY0VbG1BFs4fHm/vBSV27nrjVBiODVO8n+KGDuxk4U0OizApOBSYg+ljqjOdcLq6vqSNqAZnQdzXUJE6DDce9WCgMqJN6EdkkQ==
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM (52.145.34.143) by
 PH1P110MB1588.NAMP110.PROD.OUTLOOK.COM (52.145.25.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13; Mon, 20 Jun 2022 15:17:21 +0000
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::546c:1f1b:8e47:c855]) by PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::546c:1f1b:8e47:c855%6]) with mapi id 15.20.5353.018; Mon, 20 Jun 2022
 15:17:21 +0000
From: Russell Johnson <russell.johnson@kratosdefense.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: Interrupts
Thread-Topic: RE: Interrupts
Thread-Index: AdiEt6tZqwtxO0uGQm+OMsgMNQnRVA==
Date: Mon, 20 Jun 2022 15:17:21 +0000
Message-ID: 
 <PH1P110MB1050B18C8CE66B077B50B31CE2B09@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7d56dff-ec1b-4e81-607c-08da52cff8f1
x-ms-traffictypediagnostic: PH1P110MB1588:EE_
x-microsoft-antispam-prvs: 
 <PH1P110MB15887B92FDF8796DE245DEF4E2B09@PH1P110MB1588.NAMP110.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 27xym6P5h8r9e/Q9GLlTA0KJ/JEZZk5NVt3O2oKvVHdWAWDb4HZYNEcYjIShyWdTAOlaTtQeBNjpnPPfSSMtLjqcQGfvuF7eTv8z1huP1AXHa0drwhOuHPq4raiJIPLinX849UkcDlEmavcBvx7lIFdS6sRi8r2ZtN6lxfkSupkiMdZEuBLnR0QEx3HCt1N8JMDfcjOrbiv8usLb5WXrpdwOlUMGrR//7Ol3TEQTVSbL5ix29e7kJvZ80NWuMbswovx5Uzkm6F3mAKh7ltc7o+IokZHQDv/eeVtvJLwDZIw/+aq16pBjifW+ySvnO2fRqiuELdocaFaVTSUz7RtO9vJZFTqReDbJK8GCtw/C9C4kAHy1f/OjD5ETTmANcIj5J/mR5hcocV0mrHrccVrlbUF1AwYpDRVdy0ho/tNOiR5ZxHFj+LVw5yxSTz3bsZ6sk9m+Fid0sTn7C0JglAhyAQMeEBp3k5Oc/2mEmr3MWf0+qJDH7Rz6+oCFk9ONI9KPRDLGP3VQmJPpbTHqVXv+NDeVWrwmHEf1P9oSgEm/xLLoIWv3PmZFma8Rh8X3kIxWOqUnGoAyIlcSRkMD/ive5H9BFuk/4Fae/m1Sb64g0C8O5X9NOIU6eJEBCbcGgfh16YYBkNmwNKj/NPuhfjMOeu4EPfltjCXKtgMn1MnUTyQ6Fe62T4ATEk+lhiLdw27KfjDkegHEEJ23QmbiBJGRUQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(366004)(498600001)(26005)(52536014)(83380400001)(38100700002)(44832011)(33656002)(8936002)(71200400001)(99936003)(38070700005)(9686003)(2906002)(64756008)(8676002)(66476007)(55016003)(122000001)(66946007)(7696005)(5660300002)(7116003)(166002)(76116006)(3480700007)(66446008)(6506007)(6916009)(966005)(86362001)(186003)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 rkkszE0azol4OjGOL7x7NVWWaGWES8Ua9SyzXKeDBeMSZUZZ+c+BOfk4ze31idNUJU/Cr/TG8AHl38+7Q8OyHG8RJB2AiWalml46nRBcTkgkvnHfThavEqcrMoudAehCga8LlWbnkcMNy57IE6M+JA98a5d7b4zIx3+vLvwnc5DaAjGfXk7vuTOwYoqxaWVR0m8eDQUN6CebQcq8iPIcsvORMsEK4ulOaMKEfqt3H5bRPZE7YsOTXD+M3Ktckq4umLnL9p38do4ah4b5NK3B1sqiKugxRg00SHsMyuzjNHDUgmOq97zbRZ8aeejr6IYS5PVNaGSbe4gC1n5bE+hrGGtedjhtJYARD4iV+8WPP4XqHuzWs/00nL+JNnH1Nke1rUspaAuL4hwpISPgsYqxyu34fNqYp/+cl1yyJ17TxP4=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=2.16.840.1.101.3.4.2.1;
	boundary="----=_NextPart_000_00BC_01D88486.8ACA0890"
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: kratosdefense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b7d56dff-ec1b-4e81-607c-08da52cff8f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2022 15:17:21.4153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7932d891-b9cc-431d-be14-d43339fa1133
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH1P110MB1588
X-Proofpoint-ORIG-GUID: dfjt3CdJqsFSQsatJhzKqUOAvtsWuZDX
X-Proofpoint-GUID: dfjt3CdJqsFSQsatJhzKqUOAvtsWuZDX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-20_05,2022-06-17_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 spamscore=0 impostorscore=0 mlxscore=0 suspectscore=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=975 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206200070

------=_NextPart_000_00BC_01D88486.8ACA0890
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_00BD_01D88486.8ACA0890"


------=_NextPart_001_00BD_01D88486.8ACA0890
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

> The recommended way with EVL is to follow the common patterns used for
> developing regular linux drivers, except that the EVL kernel API must be
> used instead of the regular/in-band kernel API for anything which wants
> to synchronize threads over the oob stage.
> 
> Typically, you could share an EVL semaphore [1] or an event flag group
> [2] between the interrupt handler and the oob_ioctl() or oob_read()
> call, which would block the user-space task until the matching event
> happens. To monitor complex events, you could use an EVL wait queue
> instead of a semaphore or a flag.
> 
> If you need to monitor multiple event sources in userland, you can use
> the EVL poll API [4] with the file descriptors you would otherwise pass
> to the oob_{ioctl, read, write}() calls.
> 
> [1] https://evlproject.org/core/user-api/semaphore/
> [2] https://evlproject.org/core/user-api/flags/
> [3] https://evlproject.org/core/kernel-api/wait/
> [4] https://evlproject.org/core/user-api/poll/
> 
> -- 
> Philippe.
 
If I create an EVL semaphore or event flag group on the userspace side
(using the libevl API), how would I go about passing a reference to that
down to the kernel driver (through ioctl)? Wouldn't the kernel driver need
to know what a "struct evl_sem" or a "struct evl_flags" is? But those are
defined in the libevl usersapce API and the kernel does not have access to
those headers from what I can see.
 
Thanks,
 
Russell

 


------=_NextPart_001_00BD_01D88486.8ACA0890
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
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:"Courier New";}
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
class=3DWordSection1><pre><span style=3D'color:black'>&gt; The =
recommended way with EVL is to follow the common patterns used =
for<o:p></o:p></span></pre><pre><span style=3D'color:black'>&gt; =
developing regular linux drivers, except that the EVL kernel API must =
be<o:p></o:p></span></pre><pre><span style=3D'color:black'>&gt; used =
instead of the regular/in-band kernel API for anything which =
wants<o:p></o:p></span></pre><pre><span style=3D'color:black'>&gt; to =
synchronize threads over the oob =
stage.<o:p></o:p></span></pre><pre><span =
style=3D'color:black'>&gt;<o:p>&nbsp;</o:p></span></pre><pre><span =
style=3D'color:black'>&gt; Typically, you could share an EVL semaphore =
[1] or an event flag group<o:p></o:p></span></pre><pre><span =
style=3D'color:black'>&gt; [2] between the interrupt handler and the =
oob_ioctl() or oob_read()<o:p></o:p></span></pre><pre><span =
style=3D'color:black'>&gt; call, which would block the user-space task =
until the matching event<o:p></o:p></span></pre><pre><span =
style=3D'color:black'>&gt; happens. To monitor complex events, you could =
use an EVL wait queue<o:p></o:p></span></pre><pre><span =
style=3D'color:black'>&gt; instead of a semaphore or a =
flag.<o:p></o:p></span></pre><pre><span =
style=3D'color:black'>&gt;<o:p>&nbsp;</o:p></span></pre><pre><span =
style=3D'color:black'>&gt; If you need to monitor multiple event sources =
in userland, you can use<o:p></o:p></span></pre><pre><span =
style=3D'color:black'>&gt; the EVL poll API [4] with the file =
descriptors you would otherwise pass<o:p></o:p></span></pre><pre><span =
style=3D'color:black'>&gt; to the oob_{ioctl, read, write}() =
calls.<o:p></o:p></span></pre><pre><span =
style=3D'color:black'>&gt;<o:p>&nbsp;</o:p></span></pre><pre><span =
style=3D'color:black'>&gt; [1] <a =
href=3D"https://evlproject.org/core/user-api/semaphore/">https://evlproje=
ct.org/core/user-api/semaphore/</a><o:p></o:p></span></pre><pre><span =
style=3D'color:black'>&gt; [2] <a =
href=3D"https://evlproject.org/core/user-api/flags/">https://evlproject.o=
rg/core/user-api/flags/</a><o:p></o:p></span></pre><pre><span =
style=3D'color:black'>&gt; [3] <a =
href=3D"https://evlproject.org/core/kernel-api/wait/">https://evlproject.=
org/core/kernel-api/wait/</a><o:p></o:p></span></pre><pre><span =
style=3D'color:black'>&gt; [4] <a =
href=3D"https://evlproject.org/core/user-api/poll/">https://evlproject.or=
g/core/user-api/poll/</a><o:p></o:p></span></pre><pre><span =
style=3D'color:black'>&gt;<o:p>&nbsp;</o:p></span></pre><pre><span =
style=3D'color:black'>&gt; -- <o:p></o:p></span></pre><pre><span =
style=3D'color:black'>&gt; Philippe.<o:p></o:p></span></pre><pre><span =
style=3D'color:black'><o:p>&nbsp;</o:p></span></pre><pre><span =
style=3D'color:black'>If I create an EVL semaphore or event flag group =
on the userspace side (using the libevl API), how would I go about =
passing a reference to that down to the kernel driver (through ioctl)? =
Wouldn&#8217;t the kernel driver need to know what a &#8220;struct =
evl_sem&#8221; or a &#8220;struct evl_flags&#8221; is? But those are =
defined in the libevl usersapce API and the kernel does not have access =
to those headers from what I can see.<o:p></o:p></span></pre><pre><span =
style=3D'color:black'><o:p>&nbsp;</o:p></span></pre><pre><span =
style=3D'color:black'>Thanks,<o:p></o:p></span></pre><pre><span =
style=3D'color:black'><o:p>&nbsp;</o:p></span></pre><pre><span =
style=3D'color:black'>Russell<o:p></o:p></span></pre><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p></div></body></html>
------=_NextPart_001_00BD_01D88486.8ACA0890--

------=_NextPart_000_00BC_01D88486.8ACA0890
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
9w0BCQUxDxcNMjIwNjIwMTUxNzE5WjAvBgkqhkiG9w0BCQQxIgQgzsGqWlAB6rs311k662lIXza9
ig3TppegYN7sGwd00yswgZMGCSqGSIb3DQEJDzGBhTCBgjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAoGCCqGSIb3DQMHMAsGCWCGSAFlAwQBAjAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwIC
AUAwCwYJYIZIAWUDBAIBMAsGCWCGSAFlAwQCAzALBglghkgBZQMEAgIwBwYFKw4DAhowgb0GCSsG
AQQBgjcQBDGBrzCBrDCBljELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3Rl
cjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVT
ZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJIF
dv7a2pEWVMfTkiUaPlcwgb8GCyqGSIb3DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkG
A1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0
aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBh
bmQgU2VjdXJlIEVtYWlsIENBAhEAkgV2/trakRZUx9OSJRo+VzANBgkqhkiG9w0BAQEFAASCAQBt
CC3XFGX3x5xg2H4WNK0HxN2NqalUOjnYn5c43JfHQCEfPxbLIjKUMnjtGBIErVcENqB7GVwhv5bX
jxaqs4teETokQF+DBuXbD3uKgDRVZJxWpHsn3t3yvQNzXhPX19xRQ9GXJDLJveUYJzVJhTFRP5vP
8OJvavWgcJ2by1s9pD60z21Q2QJglcspjv9zWVG0AXSGYBwzWxMYVpArU0bVWlHqml/dGBe61G/4
Hvm3cGLEB/fo0/NsrVLvsJMjYRokPUOvJS0WITh53vzH2zDKMX5EgTBHXYdYWg8iGWlq2HcrbLWO
wTjzsPihasmMBE1Zn7hM7ZMQh31jwtZ+JzZqAAAAAAAA

------=_NextPart_000_00BC_01D88486.8ACA0890--
