Received: from mx0a-001f5801.pphosted.com (mx0a-001f5801.pphosted.com [148.163.157.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E1FA93A
	for <xenomai@lists.linux.dev>; Thu, 23 Mar 2023 15:09:22 +0000 (UTC)
Received: from pps.filterd (m0090334.ppops.net [127.0.0.1])
	by mx0a-001f5801.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32NEBULe001535
	for <xenomai@lists.linux.dev>; Thu, 23 Mar 2023 07:51:19 -0700
Received: from usg02-cy1-obe.outbound.protection.office365.us (mail-cy1usg02lp0176.outbound.protection.office365.us [23.103.199.176])
	by mx0a-001f5801.pphosted.com (PPS) with ESMTPS id 3pgrah85de-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <xenomai@lists.linux.dev>; Thu, 23 Mar 2023 07:51:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=OsqANQozinlUIMgldwkgTZXos5FWGP5iKEfGzyBW4bELFWdEG7kIO1ihVPcsEjrqKXVeymAyq+uOzjXgqN6JqiqXTIoaF/gTE5Ug0JpqJmtqX1VZg9XGXqZT/SgeER3DhpEXfKRRb/U++djew3aCzJqfi6N+U+YtxVWCL0zWZcGRHXj4jA73a+84B8BQC6CYI1KL9sHho2ptcfDQPOzGeFfKdLD60gCiITOPerbKUfGjIVq35C5GfXhTm0OHTIx+xFZwF6aW6g36UGQd5twq9snzLOEnG/Av+Ruh1nVZlHSF+pxnXvA+E6EDjrXVV89dItaocwvtVaHRcvVls6vhuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IL/naF4ouswtSZwXg7DobCdPnaz4eXYDTy6xl4kpF+I=;
 b=MUUOsJHZ1DU46Cg0tjap9vcmcBDcjQnrKY8Gb4O/Wyp1tRY+5qVriH0IaDIW2ieEDGaSqJ306dequ89tL0XoImszM32doU1yYucAOSglLlASi0+AljK6XLkLvWjqjHVeguLlXrwm5A44qmtapa7AUXR71Cf15kX6nMUrdOEuKLSjIjDe6+XBLr9gunY8oIHma0ijS/N7VKGWiOa218F3oQ7bfsULtt1EypYHGcOiSKxCB+06YCuc9qAQEyc95PdP6RSL1sPW7NRon0/xBdtxlQq7ybIHfPnNTSAnfuO7o9v2zGPZ4ykQ8fukFLnRSazM4LOdQncjK9G+gxAOep9E4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kratosdefense.com; dmarc=pass action=none
 header.from=kratosdefense.com; dkim=pass header.d=kratosdefense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kratosdefense.onmicrosoft.us; s=selector1-kratosdefense-onmicrosoft-us;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IL/naF4ouswtSZwXg7DobCdPnaz4eXYDTy6xl4kpF+I=;
 b=hDmela+Dslmvh5n4ZgZ3+0P6wKqT0U4i4Rgtq7KyGG3tRevU4J24CMCuoWNhxzRX3VW1h1xTBo3gXpw9oppuRls/zkLNtRcEIrhAlymycXzVE1jT+RK6CeYnMKKY4FgQB2++TrBA6PgQxLwbSMfgNvpxnTzFo9ZmsLywtL7sWeDezX5ApeW+fYJNA/dUjS+TeWAkd+DQmU58tpSWEPfALiVXXAtTTkhFvTpOl8kr+raPejuHtEGZhRMf38uOoz/49Z3nYSuOi9gcvrN3YG7DnqnPQAUvDdlmnfeSVpiqTqCytjT0mGNsNmkG5gF591YxQOdt+psT4Aj8vR8htUYaWw==
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:176::15)
 by PH1P110MB1004.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:174::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 14:51:15 +0000
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::bdc2:38d4:36c5:68d1]) by PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::bdc2:38d4:36c5:68d1%4]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 14:51:15 +0000
From: Russell Johnson <russell.johnson@kratosdefense.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Issue with evl_wait_event on startup
Thread-Topic: Issue with evl_wait_event on startup
Thread-Index: Adldlmq6BAwjVK/7T+ucGRrlb+09Iw==
Date: Thu, 23 Mar 2023 14:51:14 +0000
Message-ID: 
 <PH1P110MB105092F3657F368FA123D4A5E2879@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH1P110MB1050:EE_|PH1P110MB1004:EE_
x-ms-office365-filtering-correlation-id: 76e386e5-f59a-4b7e-708d-08db2bae0d29
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 1BbBP7CLOVP7m/Hqb0ivu47TAh+rt9OU1apydx84l+GZL1w5LYm84KIScRGRDmTaHF6vYdvwR2VgJq8QLS3by9IxYP9mSbsygfBtHf88GxADylrW1dJXQmzMVLGqaUfu7K1zx8QGoz4K3s54Q5VXgmbjelTE36czg05mnz95LmCJstX66whZ1Faof+nh8JIqUk/R0ivUhHnikNQ+h8b4KZxfyQl++EFCM2Nu6l+xK++N7qkltgruutpcajSIpzGO/Pmx3oP0wWR6GCq8JzE1h1naxng39eaFr+s1GQjCFW7cyPQEyOvotJp1yYl5fE70+fnb1RGvVODh8EMxMx1M4T7gT5gAaQkfgIDo/ImJoHOJPoEBp5otFIf3/m7qDArT++bKDngoZIJT+ACome0gEUbM1ZA/jP8OMkRAf8k4OvK6Ql3L5pxTj4+37noohn5K4xX9Jciae6lvEV/V0vE0LWybDLlUkAtKAB1na3CQN2ZQimFk+JGLKAWQQfhtP0Azmtfaeo09c0OXlzQgDvt+LVXHGW/o9KYigdbX60j+3CM0s6t6LCw9UCmpYsy/H48gxR3bKQO5gcugmSKQQN1G2N49MX3/Na4k2TQcaNFZbNXN9Sb2W/5BDEPHfRI56LY5
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(396003)(39830400003)(451199018)(2906002)(33656002)(86362001)(55016003)(38070700005)(38100700002)(122000001)(6916009)(41300700001)(5660300002)(8676002)(66446008)(66946007)(66556008)(76116006)(99936003)(52536014)(64756008)(8936002)(44832011)(66476007)(4744005)(71200400001)(508600001)(9686003)(6506007)(186003)(26005)(41320700001)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 f+Y7KHPgyN8lWaXhBityjMWg+27PmsH1uXB6H7xTqtzlFfS8QMbxGAxi9Rq7aWNeOGhmOCFau2N7UvD8THnF4a7F8vmZg/QKZWUMiZgVLokYnmzDE/5oI6F4FremE6ckdE400KWCAJWJHMHl/PzU/28A38CPaoL+yBUbQuahotGRgNNM6ihTtg9pohfdnPOGShMjHJUcmFfxgI/bKA2Xml5uaexep3z5de7WYmTTe3RO4n56vT8q55JN5aAByWoDB+17/5W0hSzG3WVvcddZ346mimZwhaQFK15obk++iwwf1emq3ybTnIeksqyQYp2FAGXncEJIQ7JQoY/p9k9N9dJfgHZu7i1ETUd3aXjGIzkODY9uMFEZBGWTmEZlFMxTE4ZoUoSGgvieY1Ek6i3bvqumqzTmVeGl9Cj9OUke1K8=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=2.16.840.1.101.3.4.2.1;
	boundary="----=_NextPart_000_0021_01D95D64.9E8920C0"
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1l67ySSQrOPEIaLpanqKlFzaF27sI41/sybJ2WKi0TuBjlMMj0TLuBC+Hye4/rMQV1n/8iJWum9WNWaaMGMfQmzMoQJoUaZiWfHE8LNQtyhyH3IYQOSLhAjsLHT4hja+Lrx3MygVvxLigLadvSZo9F+qE3J5EopgUGby6k7Hr2BdKgP+GhDv1mmIQ0mOlMzYDdRZLO+K63Rd89bzitoha478JGzGVAudRuoIKM9AG0g5z55wDQzmpHUOQctYvPXjS4YnrP71pAqEKewLtc4dG13cYXdnaf2hjDwg5UCfJrgyoOoEH5l/U1EBjDDlzZbX4/2eviUF2iOA42Eqd8RPih9M9xrQk1RLI+tPIipnc/0B6K87co9jM9mgoK3mgZKOHaZOKv3pTzRX6//2D6ZQ8CmVLvp55lwAuRrNK854WiCjqAy9JPWMt6ro2EHUFEfDd1gFN38o/tDHidywYxMcSPIpKcwKxtG/waDHOHqS46UafKmyogr9EnSeXGZdQea3TlNJIkz3aiDuND6w4LTVZoz8FECVH36fBGEr5sPAl6Uc8b11wj34B49Yg1U6CG5eDpZ6ogwm7Kc4z5NlyU5rlDW9IF4QTykXQk9u/IlPxDDLFXBzoEB26ocWc6sV8Tb+kC2r0MlE9AQlfGtJNkrfcJTYjPW0LxhfZ51FTpJiYS6GcC5HJw+DiiP4QXXGSst400/IWo+ct1le110XC8fWfAyNNaXeXgP8qkU79e8Uz5btXiId9a2jfv5oU1atvnTDcGPY+GonAk66Bto2dHRSQQ==
X-OriginatorOrg: kratosdefense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e386e5-f59a-4b7e-708d-08db2bae0d29
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 14:51:14.8024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7932d891-b9cc-431d-be14-d43339fa1133
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH1P110MB1004
X-Proofpoint-GUID: G_b3cIS_1qz1cG8o9_9_IIevnVxq1aMa
X-Proofpoint-ORIG-GUID: G_b3cIS_1qz1cG8o9_9_IIevnVxq1aMa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-23_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0
 clxscore=1011 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230110

------=_NextPart_000_0021_01D95D64.9E8920C0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_0022_01D95D64.9E8920C0"


------=_NextPart_001_0022_01D95D64.9E8920C0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Sometimes on startup of my EVL application, I get an EIDRM error returned
from a evl_wait_event call. When this happens, we create a new event to
replace the old invalid one. Then any successive calls to evl_wait_event
seem to return EPERM.. First of all, what could be causing the EIDRM error?
Is creating a new event the correct solution when you receive that error?
And why would I be getting EPERM after creating a new event?

 

Thanks,

 

Russell


------=_NextPart_001_0022_01D95D64.9E8920C0
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
class=3DWordSection1><p class=3DMsoNormal>Sometimes on startup of my EVL =
application, I get an EIDRM error returned from a evl_wait_event call. =
When this happens, we create a new event to replace the old invalid one. =
Then any successive calls to evl_wait_event seem to return EPERM.. First =
of all, what could be causing the EIDRM error? Is creating a new event =
the correct solution when you receive that error? And why would I be =
getting EPERM after creating a new event?<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>Thanks,<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>Russell<o:p></o:p></p></div></body></html>
------=_NextPart_001_0022_01D95D64.9E8920C0--

------=_NextPart_000_0021_01D95D64.9E8920C0
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCFbQw
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
J0RHfxBdiSprhTEUxOipakyAvGp4z7h/jnZymQyd/teRCBaho1+VMIIF4TCCBMmgAwIBAgIRAI/z
sKoC9gIWd6K2uUMqX0gwDQYJKoZIhvcNAQELBQAwgZYxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJH
cmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoTD1NlY3RpZ28gTGlt
aXRlZDE+MDwGA1UEAxM1U2VjdGlnbyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1
cmUgRW1haWwgQ0EwHhcNMjMwMzA5MDAwMDAwWhcNMjQwMzA4MjM1OTU5WjCB4jEaMBgGA1UEFBMR
KzEgKDcxOSkgODg0LTYzOTIxDjAMBgNVBBETBTkyMTMxMTIwMAYDVQQKDClLcmF0b3MgRGVmZW5z
ZSAmIFNlY3VyaXR5IFNvbHV0aW9ucywgSW5jLjESMBAGA1UECRMJU3VpdGUgNjAwMRMwEQYDVQQI
EwpDYWxpZm9ybmlhMQswCQYDVQQGEwJVUzEYMBYGA1UEAxMPUnVzc2VsbCBKb2huc29uMTAwLgYJ
KoZIhvcNAQkBFiFydXNzZWxsLmpvaG5zb25Aa3JhdG9zZGVmZW5zZS5jb20wggEiMA0GCSqGSIb3
DQEBAQUAA4IBDwAwggEKAoIBAQDAs1JlPXcxObC/SDH5jeXQCR/wpwukNllyXtVupCmQwW0zjEXN
bnSaUcXkpkqU52fnuPrvg49YNVMs8j9ftVR1JgYBTzqfe4cYa1085W31zMc1ysOFO4Q4fmL1ew+t
UkDewFDJhiZMPbsFDFMLZmrdsdE+zoO3snCOykm1bJYQ23DFfk+41sgLNMSxrvaMzTk9Dr2MVGYJ
U5XiwKGseszOA59mR278QTbitwAaGm2yZ3haqxRpSiLdTCpWP6NT+ufDgN7gdUqNHzIDX0/Wkm2l
se1EneAnUyGvZAVuqcgrtdHzslP51mJ92jxuDSkRNJxUU8jo3OkX1rkRRpppQi0vAgMBAAGjggHa
MIIB1jAfBgNVHSMEGDAWgBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUG/7kujLuZ4Qp
vVGdPTrnUMwMRwMwDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYwFAYIKwYB
BQUHAwQGCCsGAQUFBwMCMEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYBBQUHAgEW
F2h0dHBzOi8vc2VjdGlnby5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwuc2Vj
dGlnby5jb20vU2VjdGlnb1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5j
cmwwgYoGCCsGAQUFBwEBBH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdvLmNvbS9T
ZWN0aWdvUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAjBggrBgEF
BQcwAYYXaHR0cDovL29jc3Auc2VjdGlnby5jb20wLAYDVR0RBCUwI4EhcnVzc2VsbC5qb2huc29u
QGtyYXRvc2RlZmVuc2UuY29tMA0GCSqGSIb3DQEBCwUAA4IBAQBRRMaZHiM5JRYIchy62As+w13F
TXX2s5QeFwTWbbS732kxBxsFpv1KxGoL7Dze5Y3pQXk0wHKEu922i1O5rSBQ/63HOeZ9t1F1Vu7b
oUU6BP+uhqcamCtQPkV9MiEInBonCOimhoeqU2aSgyOHAM7MAnXAk4SZ/ElFQAogucYaDI1DpciA
uClBkWCfbYVjYkzbN/WURM02AQpicgXkWXJoWxHt9J1unZP7AIdIE3WD5No+wsxF0nZTg+5XU0RY
Y1FAx82tWR4Hq4i2qOFgs/pu2KSfGzo2IOuft380xuEe67ovMgvTzNL/PVaYNxn08XACfn4hbP9Y
LBCOCUz2NbYXMIIGEDCCA/igAwIBAgIQTZQsENQ74JQJxYEtOisGTzANBgkqhkiG9w0BAQwFADCB
iDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCk5ldyBKZXJzZXkxFDASBgNVBAcTC0plcnNleSBDaXR5
MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNUIE5ldHdvcmsxLjAsBgNVBAMTJVVTRVJUcnVzdCBSU0Eg
Q2VydGlmaWNhdGlvbiBBdXRob3JpdHkwHhcNMTgxMTAyMDAwMDAwWhcNMzAxMjMxMjM1OTU5WjCB
ljELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2Fs
Zm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGll
bnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAMo87ZQKQf/e+Ua56NY75tqSvysQTqoavIK9viYcKSoq0s2cUIE/bZQu85eo
Z9X140qOTKl1HyLTJbazGl6nBEibivHbSuejQkq6uIgymiqvTcTlxZql19szfBxxo0Nm9l79L9S+
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
8AJNTHU3HwAAAAAAAA==

------=_NextPart_000_0021_01D95D64.9E8920C0--
