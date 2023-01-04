Received: from mx0a-001f5801.pphosted.com (mx0a-001f5801.pphosted.com [148.163.157.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEC3BA53
	for <xenomai@lists.linux.dev>; Wed,  4 Jan 2023 22:24:36 +0000 (UTC)
Received: from pps.filterd (m0090334.ppops.net [127.0.0.1])
	by mx0a-001f5801.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 304F2fNF019662
	for <xenomai@lists.linux.dev>; Wed, 4 Jan 2023 12:08:27 -0800
Received: from usg02-bn3-obe.outbound.protection.office365.us (mail-bn3usg02lp0147.outbound.protection.office365.us [23.103.199.147])
	by mx0a-001f5801.pphosted.com (PPS) with ESMTPS id 3mwbrkh0hm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <xenomai@lists.linux.dev>; Wed, 04 Jan 2023 12:08:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=OrWQPtlHhUoT9VrYRuJcFm5PSc5mWn8HPG5QJxne20fh6UzkETE46vZqX+lQTzYx9jiXiXORA+Nf5l3rtFuTxQ22dPUCXz80U261WsTWI9mI2ci+zGzryRStbo+KMCL8SzOMbKgrmYdTdMytjFNALwEByLugnQRxmQqFXMq8zaifm87W7UK+XtX3srThjKn9wgvqTlNEP7VSAlOn2ERPZNuQ7JixcgNL6T9tzdqvLur51BpevdwEma3BC7Cd8XyGS3xNX0urfqMKmiCMxSnmDgNtJqgeG4cpeyWuYMinClqwXG9qBaP6MQ4/PNDrGPdrB33nTJHCK+q/ZaPPwIlI8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2aSgbzTMVY0LHvuLjSrR9TxIWlRYYHRpX04njw5uUo=;
 b=IFkNx8QlOLIgZzn4BSZublQlMVftCCFbuxfCs3V2GYCC+h1PwtYiVhrsprkX+pGFiNuckBNbeRC3H8nr3SsdR1wAcC2Xek5yNkRtMsm+ih96fXbc4u1UmrpRAW8SIRf1vsNPwMe17JPoM2tGnJJkn4ZOYE1/UHJLJPwwcljlz1Xgt0LrFae18pHSc/WQV67V5op+L7tOYUuMBfQzm2gkf6L4rNa1QOVqDTFA6Px6D8VvWe6veX0q7bkXbOKa42ba4j+odzAX1vrWVZMjeAiA9BV7IBZQ3a2/MtXuylJdg9p4ALqr15/YMJxpaOqOCgLuo+PXOrYBUfDEXoBYwWw7+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kratosdefense.com; dmarc=pass action=none
 header.from=kratosdefense.com; dkim=pass header.d=kratosdefense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kratosdefense.onmicrosoft.us; s=selector1-kratosdefense-onmicrosoft-us;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2aSgbzTMVY0LHvuLjSrR9TxIWlRYYHRpX04njw5uUo=;
 b=a3nCxnwlZCtWS3TwSe9oG7VGxCSnDQDtWt0pDhuIGSI17I/zgw5OGMDLWP+l/U3lgH7e4YxYXAQw0OeWfeQl1VjGe8mjc5bDzRcpCum1aeh1EWbceKNZ0p1oiUack/KzpJZTKlLZlAfijgjPWPKe1xO6+o9uAkYi3RTkBEb2m7SCnRqTlSHPxF72uCnVtrUI9L3nVhTvumdNn/JsSgIrxHFXMvaxKhetiWL1le9usTdmFsbE68lZenm+vrGcUauutzTejV5eXORlVeDfdGmqkiGdjwSDIQ5pnw5s+GB/TsdNnHU1H1qDbwYg0Mn9zwNj6TykDh8xcdEgFRS3v9O3Mw==
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:176::15)
 by PH1P110MB1185.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:18c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 20:08:24 +0000
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::f260:75b3:f076:14cb]) by PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::f260:75b3:f076:14cb%4]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 20:08:24 +0000
From: Russell Johnson <russell.johnson@kratosdefense.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
CC: Bryan Butler <Bryan.Butler@kratosdefense.com>
Subject: Conflicting EVL Processing Loops
Thread-Topic: Conflicting EVL Processing Loops
Thread-Index: AdkgeBQXz3DcF9hoQHmlGeiHUsYglg==
Date: Wed, 4 Jan 2023 20:08:24 +0000
Message-ID: 
 <PH1P110MB10502215781144297BCF2AC9E2F59@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH1P110MB1050:EE_|PH1P110MB1185:EE_
x-ms-office365-filtering-correlation-id: 8d2078ce-0f84-4204-5d7d-08daee8f6fbd
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 2SLB0D4zWAqHbm2UUPCeGup2RiHlj/+3qM1XAbVqisNAb2y9VJg6e6AmKseMsZMmjVYYd8aqvHJakHm/Q1Rppx/9lP6CmRh3wZa9fmCM0SC7rJQAeCk40HMSaiMN2vl8HG8+KLJ9PT11ji39BLmNaaOOpGqa/i5EviiS+ug52HNgLx0kWXLAnDWU3gZA5/kFxJliFlf4LnHaD3G52g8PKvtyWpM5LuhjWQAssd4tpFSkPPVVweT525c2APFf1jkJd2ChVo7Q5OVeR4QpN6uSx1xZ9NnCjbnXY/coiklIC7XuPg9+wH5xOQjlVnN54loZ/rPIMyJWN/ySULTxUwvudYBurR8DX4n1FK+QLSMULl5NWvaWtBRY7/B1/c6lzmAWickZQgmJdfXiJ3R+RzRG9h5PfsLA7v5+RRCwzL+uryi0SxUoUKQr3EPAgYrOmE/ypIUd/+1EhegVdUNOp10HHTPzZ9QJazzx3yAM8tjgoKW7FKPyvi1mza0El4VEQ3mlLEh/lS0CkMTVjId6gLDeV535074HDY6zTeOPoKdTJYq2cOINQlWC8AjCcVFe5/rG
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(366004)(39830400003)(136003)(396003)(451199015)(9686003)(76116006)(26005)(186003)(4744005)(3480700007)(44832011)(99936003)(6916009)(5660300002)(38100700002)(122000001)(8936002)(9326002)(6506007)(52536014)(66446008)(66946007)(66556008)(38070700005)(107886003)(8676002)(4326008)(41320700001)(7696005)(66476007)(41300700001)(55016003)(86362001)(33656002)(64756008)(2906002)(71200400001)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 NYA/gwRPNHIW2ncqRW+D8KGENWE+UqqLnX76CNKgQ94iRw6c18XoDTtl3CYJqXcpYpFt3glJ1HFLudxDzkTacyBICJsVxeSuN8tGFhc5GepQh5HGdIYUTg0elQF5Yla3ZfomxpijjWgA3Y72xb2UiSHT45AIxcnXC5J5pd8IdWz6zGxgxcmZT6tnET83eZq/8EF07DqhlyY1wNYra/7TcAsG52laJwIh+Z1vsDv1Nf8IqSnYw7sHKurDycTGKpckBcM+BRGpopkycPU0ny4X4IP3wVG8O/kLjQifOSxKPf72q1lUM27cB0OMJo4WAKX9qxLWCJcTjelZdSX/EFP7+34vFylNYo0n2o7hn7ogqheklGAVwq9hd2T87OdaZPY1CGhFRTM2M4XRrdsvvrfwF+Tr9yMUdThI3Kwm4WwmowA=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=2.16.840.1.101.3.4.2.1;
	boundary="----=_NextPart_000_00A7_01D9203D.A0064680"
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	xs9/NjNwUJn9ZujrNsr6S9cYdz7ZMp+St2RLIc3PZEsEvceokl4UDoz5nEJnc0rxpV4x1WH0udoPghy0K8fWKHey+d6MYph9s3mirVS7C6PUxhZ/YDYGwbWLzkiCgjWtcecl5sRyJKP8KpHnA4e4jMA63Iy4Euwj41oIqg7iYErCbnrWoamqENnCAdKIcSxx8/6jLbEwX67ZlzIkEqMCMzSvjtbIZR1Ko2DwvgU2w3cmMGQBE0xOyFXGNXcVtLkt+2l3zuR+dc/5D5qz/mgFdmYw7cWLoxP+pqGeMuujfMeHT1ZBedaBBg0Nzc+lsd9bbTxOPqyeTdH+S3AtNCnfWix/p2gSPt6lBXjUFMKZLhmuRVpOqcBXJ0W2kzqFWehSHHIww9npFncv4KEjlyKoIb8Xk9+jIkvesOeG3FZ1zF6IrE70tvA8PsEY95MrjFZiPmmS/1FEHhkUAFQe5Cy2Xi7QBC+uRWSMICfN9ZF94pF5rcS09Zcrm2Ub13wSneKPXOg3nUlLb0kXOXijEKw6zyYZTZHcFp0QT4LQGuPmMhUR+zIatO8O1DW2ozI4ZgZ+sJAfnQtNII5zLg0ZAV/awL3dawdtX40kk6MAj/EUgqm+8ukJjcQMa+yb9ekU1jQIviHz4gJ9OPfagcecWSlaJanka5P56LP2ZNWI2gXtcVxVZZhlqt8ODFIGmNB901B9ME6qu3eWyGu+m60/3TiJXe5OqX+DUfOaP4HxyvJPz4z26GxYZjEUkMnpr8oXYNCNZ1fKJYci6KlMvFx/lnib2g==
X-OriginatorOrg: kratosdefense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d2078ce-0f84-4204-5d7d-08daee8f6fbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2023 20:08:24.8605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7932d891-b9cc-431d-be14-d43339fa1133
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH1P110MB1185
X-Proofpoint-GUID: 1s-GdbxePKARhu9-vu1woOOsWaH5ubSM
X-Proofpoint-ORIG-GUID: 1s-GdbxePKARhu9-vu1woOOsWaH5ubSM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_07,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 suspectscore=0 mlxlogscore=477 adultscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301040162

------=_NextPart_000_00A7_01D9203D.A0064680
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_00A8_01D9203D.A0064680"


------=_NextPart_001_00A8_01D9203D.A0064680
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

 

We have two independent processing loops, each consisting of their own set
of EVL threads and interrupts. Each loop completes its processing and then
performs an evl_sleep_until to delay until the next processing deadline
occurs. If we run either loop by itself, everything is fine, and our timing
margins are met. However, if we try to run both simultaneously, the timing
error is increased significantly, and the loops never meet their processing
deadlines. If we compile the code for Linux (substituting all EVL primitives
with Linux equivalents), then we are able to run both loops simultaneously
without issue. Any clue what could be causing us troubles or where to start
looking?

 

 

Thanks,

 

Russell


------=_NextPart_001_00A8_01D9203D.A0064680
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
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>We have two =
independent processing loops, each consisting of their own set of EVL =
threads and interrupts. Each loop completes its processing and then =
performs an evl_sleep_until to delay until the next processing deadline =
occurs. If we run either loop by itself, everything is fine, and our =
timing margins are met. However, if we try to run both simultaneously, =
the timing error is increased significantly, and the loops never meet =
their processing deadlines. If we compile the code for Linux =
(substituting all EVL primitives with Linux equivalents), then we are =
able to run both loops simultaneously without issue. Any clue what could =
be causing us troubles or where to start looking?<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>Thanks,<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>Russell<o:p></o:p></p></div></body></html>
------=_NextPart_001_00A8_01D9203D.A0064680--

------=_NextPart_000_00A7_01D9203D.A0064680
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
9w0BCQUxDxcNMjMwMTA0MjAwODIzWjAvBgkqhkiG9w0BCQQxIgQg3Sj1KtXEyGXRkqNx7pF6AS9W
MLUW0n9uIDphU9jFR04wgZMGCSqGSIb3DQEJDzGBhTCBgjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAoGCCqGSIb3DQMHMAsGCWCGSAFlAwQBAjAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwIC
AUAwCwYJYIZIAWUDBAIBMAsGCWCGSAFlAwQCAzALBglghkgBZQMEAgIwBwYFKw4DAhowgb0GCSsG
AQQBgjcQBDGBrzCBrDCBljELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3Rl
cjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVT
ZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJIF
dv7a2pEWVMfTkiUaPlcwgb8GCyqGSIb3DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkG
A1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0
aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBh
bmQgU2VjdXJlIEVtYWlsIENBAhEAkgV2/trakRZUx9OSJRo+VzANBgkqhkiG9w0BAQEFAASCAQB5
20QfKnOyOBKlclis0DYqHCwMYwaov5pSfZDtp33vOabhpBSDvwx8flk3l0DvxctKXSNs8PPekw0r
eYtaJXshbmiu5sNysbjyT7HWkke5RS+jidS+/ttXwgmJAWVjIdBV22+IgI02FX3qg7y7QgzaIFKY
6ZyJuisujdPibISU25lP1ga1q7Cqq6x/MbmEDbpHVHzUJxFN0vuGxX+fhFvAD5b+FvRD2c4T591d
eaYabH11D4UQ/O7kfpOphDqJbQvyts9syMvl6xFBO3OvcDoioI5iLM0/H7O/pfmk30Wf0toq367T
csIUa4O9Ygt2UnU0lIJXsZB+wcT+qhBkE1B7AAAAAAAA

------=_NextPart_000_00A7_01D9203D.A0064680--
