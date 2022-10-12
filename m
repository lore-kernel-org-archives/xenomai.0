Received: from mx0a-001f5801.pphosted.com (mx0a-001f5801.pphosted.com [148.163.157.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE5E256E
	for <xenomai@lists.linux.dev>; Wed, 12 Oct 2022 16:25:00 +0000 (UTC)
Received: from pps.filterd (m0090334.ppops.net [127.0.0.1])
	by mx0a-001f5801.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CBXgKf026132;
	Wed, 12 Oct 2022 09:24:59 -0700
Received: from usg02-bn3-obe.outbound.protection.office365.us (mail-bn3usg02lp0145.outbound.protection.office365.us [23.103.199.145])
	by mx0a-001f5801.pphosted.com (PPS) with ESMTPS id 3k5ghttfu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Oct 2022 09:24:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=yPtCaCW/b7NKL8RRafhE7L0bmjHvSRajrpcaESNq7pcPIkCKsc3yJMqRneco1Wcvbcs6lyLOO+My8UgDv7s2Ts/W63NQkFaIEC7dtpfN+HWTEmaKljKugmqDW5KPuyk/uxbmXOTnF2gQyociLzoFkhBTA/xzZPx7TjlIw4kVqX+u9zL+JOcfNH9VvM15dfnBwiPFF7YaKbZ1kDilGtL39KoUi9C5j2h3Gf83e4SVnD1+zgTUq+K1HNW+w7WzhtAcZUJzB9gdhMsPi6UOtkVcJJgARbCE0+ssKRRfPq0S4KDv0QDRqvHBGPjDtvGzyzJ2ZPwxSi8/6+jCgSjXy0R53A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ktWAdi/BphwqxeT0VdZLwd7EAZMdZXH+uSiB8OZsk0=;
 b=yR0lfnxLcGClM1LzaC7OCkFrGRgzZnw8matA+PkUwP0Fz4w5/s16duUnjgHE9F6xZDI92z4OZU/Wk2y5UJNz1ZSKwQJEXD9lQXECdZLqc33z0rhDQEXELqgE7M4vVGGPP6zusnJ3imyXUUTpvCxskoHtJuezMVFa9BO0KyOuQHcFyRaXEQAagoOgNKsbCIudekjNO7BrfJHTLWwcoghUvUY81bLuTs0l1RYfgXvf1RuvBkJtgGbUWTxpoHwQgxDQs6Z+cADN1fqUYwO22YPQ7sbsvks5hox64rAEtcnovMzM5LFz9jI1EFzJYdw7SxcVCpOLr3j1ckYhQ5zTROfEIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kratosdefense.com; dmarc=pass action=none
 header.from=kratosdefense.com; dkim=pass header.d=kratosdefense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kratosdefense.onmicrosoft.us; s=selector1-kratosdefense-onmicrosoft-us;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ktWAdi/BphwqxeT0VdZLwd7EAZMdZXH+uSiB8OZsk0=;
 b=K10x474cJYRXOb4gvW0hTi2lABlK1huzBoanBLp0AL0NCUk0eKtTve5giwjQVtSnNQ4Zvr7DseuX8Xp3a9ieYBcp8aVVjGQtbIlCmKV1DokaDej2QzW++mgThhaAv0rB7HaBq6itLgweQj8UCl+MFYHp3SIBbPEpfLDoHTPWE4A3ds6/abI2b6XX6YkvZD5G9ZnvhMkGnbKfGy15xfl3MyiHnt46MMLH7UxFqLSdY54f8Tcky7B5QwFbmtNsrz9yqOSsWMFGW3vyyGoaXJNPO+w0Zh/2tHMz6dHddsKPF13Z1IFf/ZNrzJq9YapdjOyY8UuPTGxBnXLP5SuRWPgw7g==
Received: from PH1P110MB1004.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:174::13)
 by PH1P110MB1603.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:18b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Wed, 12 Oct
 2022 16:24:57 +0000
Received: from PH1P110MB1004.NAMP110.PROD.OUTLOOK.COM
 ([fe80::4e6:784a:5bf6:ffd2]) by PH1P110MB1004.NAMP110.PROD.OUTLOOK.COM
 ([fe80::4e6:784a:5bf6:ffd2%4]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 16:24:57 +0000
From: Eric Kuzara <Eric.Kuzara@kratosdefense.com>
To: Russell Johnson <russell.johnson@kratosdefense.com>,
        Philippe Gerum
	<rpm@xenomai.org>
CC: Bryan Butler <Bryan.Butler@kratosdefense.com>,
        "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: RE: [External] - Re: System hanging when using condition variables
Thread-Topic: [External] - Re: System hanging when using condition variables
Thread-Index: 
 AdjMb2kqEi/6rzVHQeiyZvhBQUhKewCH+EqAAD3N5wAAGglKAABAL88AAANEjQAALawygABDfHNwABf1R4AAEfuKoAAaNBUAAF91C2AArl+sAAGTD20wAAAOSPA=
Date: Wed, 12 Oct 2022 16:24:57 +0000
Message-ID: 
 <PH1P110MB1004AFDF790324668D268830FA229@PH1P110MB1004.NAMP110.PROD.OUTLOOK.COM>
References: 
 <PH1P110MB10500CC96F6D84D2026A6F63E24D9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87pmfncw9u.fsf@xenomai.org>
 <BN2P110MB128891FFD2A6A7F6AAF6C5EE8F519@BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM>
 <87o7v59o02.fsf@xenomai.org> <87illb8pfs.fsf@xenomai.org>
 <87edvz8l5i.fsf@xenomai.org>
 <BN2P110MB1288812BD18DBAA0E2714B618F529@BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB1050E6764B49A09B1699F3D1E2559@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87h70r7r0m.fsf@xenomai.org>
 <PH1P110MB1050C74BE6BB64AD707616BAE2549@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87r0zu7j6i.fsf@xenomai.org>
 <PH1P110MB1050EC5BE3C92F3A71EB8855E2599@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87fsg38to9.fsf@xenomai.org>
 <PH1P110MB10507285415B676A9E6B28CDE2229@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
In-Reply-To: 
 <PH1P110MB10507285415B676A9E6B28CDE2229@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH1P110MB1004:EE_|PH1P110MB1603:EE_
x-ms-office365-filtering-correlation-id: 96e7c186-d391-4d6f-18c3-08daac6e4d76
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 gnO8asgan3DjqSw5p4Z4EXItEG6s4uIMAAaFvBe5O+StU5Kv+++ZGftygNbnYN4iyb8uOtdVO4MMTDemvOIGWc/9r/lzijY8nV1CGjkO9iStN05PPaawH3q/FR+BrdinZUMQiqi8TCLs1bGk/ApzvNQqMgd9IO1K/FeMc33btiAzmSlDzUhb866tBemZ2tKscHNm7AqPULgpCzMrWP3aiKtRUcEqaYCCMF1hwX7IWP4/Xh+rXxComzvmDEr3v0IZO7Tq6KPS8tr/QTeEhctaCQ0r2NMTVi86B2jbmMijQxTaKVSyYszgEQrJtbK5TqcStQJ2DpXKCNXRDb7FGTdSrMji7lMM5sQrRhSGzfnElplD4XAGGb6Mhr0THd9gvkVRtfmfcQ5DDVRlyBTrk2VeYdYryK/ZN693Xw8kLhP8XlX1Gsq3m4k9j2zWxjTOuzXWHE9lImGZTRvosfp21AcIQoYye+XpyvrYIqdQ2T1nwdEv2SSBhUWUJ8OYbHkokQKnqd4+0QafCLID8WfP0vEWQbruHbZT4PFUlJqTcs2M9KvHurfy3MDVhI5Gfqw5zrDMFz2ldiaPw/sm7albfhCaLYjfmrNJLSMrlSWqiMD0ljyCc3TrzRUwdyCvWf8t7XvO9SPWIizTpZV9fJw/L31rI6SsyVZd93T0lmV5V4ZvWMEYFQV/sLm9NA88iQTDpRQI
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH1P110MB1004.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(366004)(451199015)(4326008)(55016003)(8676002)(66446008)(64756008)(5660300002)(9686003)(66476007)(66946007)(66556008)(498600001)(76116006)(52536014)(26005)(122000001)(99936003)(33656002)(6506007)(7696005)(40140700001)(38070700005)(38100700002)(86362001)(8936002)(186003)(2906002)(110136005)(54906003)(71200400001)(53546011)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 S380zIfX5B54BTzIE0TkaOSF5kf8/FJpP/9f7gDwUJSPK1hUP4WW+W0jAQo8R95fklo1L2eB1rOgcOwMfgLWvZYkOMWg2YM2wzFkEpkjgqVDRcaj5QUOe+vB9V3rQ8Uo4lMJiyTtwRmVYC0nlorHzQj2s8kHVbVE6YQqb+HFx6bDtBf3sHG9RctoUksUi4ftlQynmotLTCvwmHlA5oh1It+/Oe//9Z8+r9n8ffi0O0Ty3de0Mmhyl2dYMuKv08MLUx55phtkSzBK5owHvm2bzMhCV9+hLHvn75mz5JhdkmgBelV1IBVH4msXgykozMewrHAfC8cLRje8Z3JplBwaal3UbMxGeeofpZazQ0RBN050WGiqp1QTNod+RXt5tT4bcE2gVP84oiY1uDOusoj3yFVFrRIWpYPhiMiESuj6hMU=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=2.16.840.1.101.3.4.2.1;
	boundary="----=_NextPart_000_0186_01D8DE24.DF956B10"
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: kratosdefense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH1P110MB1004.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e7c186-d391-4d6f-18c3-08daac6e4d76
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2022 16:24:57.1686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7932d891-b9cc-431d-be14-d43339fa1133
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH1P110MB1603
X-Proofpoint-GUID: tyuMnELI4ZSBKSh_XcOjpcpCVQKtbwmE
X-Proofpoint-ORIG-GUID: tyuMnELI4ZSBKSh_XcOjpcpCVQKtbwmE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_07,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 spamscore=0 clxscore=1011
 suspectscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210120107

------=_NextPart_000_0186_01D8DE24.DF956B10
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Philippe,

It is nice to meet you.  As Russell said I am a Sr. Project Manager for the
effort Russell and Bryan are working on.  First let me say that both Russell
and Bryan have been very complimentary of you and how responsive you have
been in resolving our EVL issues the last few months.  It is very much
appreciated.  But as the manager I need to make sure you understand the
criticality and urgency of the current situation.  According to Russell we
are now completely stalled awaiting the resolution of this  latest issue you
are working for us.  This is gating progress on two very large customer
projects we have one of which has national security implications.  Please
continue to do everything you can to resolve this as soon as possible.  I
know it is difficult as I have some personal ancient history in real time
operating systems and I have an appreciation for their complexity and
difficulty to debug.  But please do whatever you can.  Feel free to continue
to reach out to Russell if he can be of any further assistance.

Thank you for your diligent efforts Phillipe
___________________________
Eric Kuzara
Sr. Project Manager, Kratos Space
Direct: 719.867.6063
Eric.Kuzara@kratosdefense.com

-----Original Message-----
From: Russell Johnson <russell.johnson@kratosdefense.com> 
Sent: Wednesday, October 12, 2022 10:12 AM
To: Philippe Gerum <rpm@xenomai.org>
Cc: Bryan Butler <Bryan.Butler@kratosdefense.com>; xenomai@lists.linux.dev;
Eric Kuzara <Eric.Kuzara@kratosdefense.com>
Subject: RE: [External] - Re: System hanging when using condition variables

Adding one of my managers with interest in tracking this issue.

Thanks,

Russell

------=_NextPart_000_0186_01D8DE24.DF956B10
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCFaAw
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
J0RHfxBdiSprhTEUxOipakyAvGp4z7h/jnZymQyd/teRCBaho1+VMIIFzTCCBLWgAwIBAgIRAM4G
WQ8Eb683M/DwO5MarS4wDQYJKoZIhvcNAQELBQAwgZYxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJH
cmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoTD1NlY3RpZ28gTGlt
aXRlZDE+MDwGA1UEAxM1U2VjdGlnbyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1
cmUgRW1haWwgQ0EwHhcNMjIwMTA0MDAwMDAwWhcNMjMwMTA0MjM1OTU5WjCB0jEOMAwGA1UEERMF
OTIxMzExMjAwBgNVBAoMKUtyYXRvcyBEZWZlbnNlICYgU2VjdXJpdHkgU29sdXRpb25zLCBJbmMu
MRIwEAYDVQQJEwlTdWl0ZSA2MDAxEzARBgNVBAgTCkNhbGlmb3JuaWExEjAQBgNVBAcTCVNhbiBE
aWVnbzELMAkGA1UEBhMCVVMxFDASBgNVBAMTC0VyaWMgS3V6YXJhMSwwKgYJKoZIhvcNAQkBFh1l
cmljLmt1emFyYUBrcmF0b3NkZWZlbnNlLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBAKuxbUCzlPcWW2al7tRsjy1VSEQeSFBs8PuEzONLiNxCcqmS1W7DOequ3emCsAvr0/rNovXP
VT1xTkzbMLPoqUHTELrRja+dQ4O886FUx3FXyMAPMh4Sy6lfqwnrH1B4XOCVT7G9Nf/BijqajZpy
6NELtl6hnfEzP0UTIh8OyIa86MAy1Ee2K8Twj2NeO5ZC0AXy/5EJBxYEqtVVk2IqB68Vih0b8xoV
hBoNUk45JBOy33ONodyIRSb9K+S5cp/sGQpsrfObVWg1otXbZyadM2QN1RRgkAG5aQmsp+C4ywyt
GGaz2RQaedWewC5cmpBhr6fALfk0F0wmUGdjarmZR6MCAwEAAaOCAdYwggHSMB8GA1UdIwQYMBaA
FAnA8vwL2pTbX/4r36iZQs/J4K0AMB0GA1UdDgQWBBTfrOPN1NLr9KawuRPRU98/5tpkETAOBgNV
HQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIw
QAYDVR0gBDkwNzA1BgwrBgEEAbIxAQIBAQEwJTAjBggrBgEFBQcCARYXaHR0cHM6Ly9zZWN0aWdv
LmNvbS9DUFMwWgYDVR0fBFMwUTBPoE2gS4ZJaHR0cDovL2NybC5zZWN0aWdvLmNvbS9TZWN0aWdv
UlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNybDCBigYIKwYBBQUHAQEE
fjB8MFUGCCsGAQUFBzAChklodHRwOi8vY3J0LnNlY3RpZ28uY29tL1NlY3RpZ29SU0FDbGllbnRB
dXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWlsQ0EuY3J0MCMGCCsGAQUFBzABhhdodHRwOi8vb2Nz
cC5zZWN0aWdvLmNvbTAoBgNVHREEITAfgR1lcmljLmt1emFyYUBrcmF0b3NkZWZlbnNlLmNvbTAN
BgkqhkiG9w0BAQsFAAOCAQEAFU/P8Zoe46dx+beJ+zgoJLCCmhabfB4DKjz7vE/06489DD24xDPh
xDofoN/+xOEWGaAEOEHUZSqCstb/YAHR/0JM3q/VhFdHeJlzBmfOl1Rallbl0t1Hgk/91sZx4DJs
eeq7e2rhat90OtHfrvq/aooqSq4rTpfNXlm8SyJcQAKpkq16/qXv+tpYV2BA5hYC7MxvMK0LS7DU
ijCKqjTSQQFpO82+UlQ9jPYbIfFyZ+CGlZLUJ5B2mfpwpl0Mds4udT4NhxJQj0t5G5OIlNhpC72I
hl++Fmp64XJKTcQMWNHBjiJVWgRgqsKCQmIl96HnyK2nGSYoRmHNZaWRkQgI7DCCBhAwggP4oAMC
AQICEE2ULBDUO+CUCcWBLTorBk8wDQYJKoZIhvcNAQEMBQAwgYgxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpOZXcgSmVyc2V5MRQwEgYDVQQHEwtKZXJzZXkgQ2l0eTEeMBwGA1UEChMVVGhlIFVTRVJU
UlVTVCBOZXR3b3JrMS4wLAYDVQQDEyVVU0VSVHJ1c3QgUlNBIENlcnRpZmljYXRpb24gQXV0aG9y
aXR5MB4XDTE4MTEwMjAwMDAwMFoXDTMwMTIzMTIzNTk1OVowgZYxCzAJBgNVBAYTAkdCMRswGQYD
VQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoTD1NlY3Rp
Z28gTGltaXRlZDE+MDwGA1UEAxM1U2VjdGlnbyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFu
ZCBTZWN1cmUgRW1haWwgQ0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDKPO2UCkH/
3vlGuejWO+bakr8rEE6qGryCvb4mHCkqKtLNnFCBP22ULvOXqGfV9eNKjkypdR8i0yW2sxpepwRI
m4rx20rno0JKuriIMpoqr03E5cWapdfbM3wccaNDZvZe/S/Uvk2TUxA8oDX3F5ZBykYQYVRR3SQ3
6gejH4v1pXWuN82IKPdsmTqQlo49ps+LbnTeef8hNfl7xZ8+cbDhW5nv0qGPVgGt/biTkR7WwtMe
wu2mIr06MbiJBEF2rpn9OVXH+EYB7PmHfpsEkzGp0cul3AhSROpPyx7d53Q97ANyH/yQc+jl9mXm
7UHR5ymr+wM3/mwIbnYOz5BTk7kTAgMBAAGjggFkMIIBYDAfBgNVHSMEGDAWgBRTeb9aqitKz1SA
4dibwJ3ysgNmyzAdBgNVHQ4EFgQUCcDy/AvalNtf/ivfqJlCz8ngrQAwDgYDVR0PAQH/BAQDAgGG
MBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBEGA1Ud
IAQKMAgwBgYEVR0gADBQBgNVHR8ESTBHMEWgQ6BBhj9odHRwOi8vY3JsLnVzZXJ0cnVzdC5jb20v
VVNFUlRydXN0UlNBQ2VydGlmaWNhdGlvbkF1dGhvcml0eS5jcmwwdgYIKwYBBQUHAQEEajBoMD8G
CCsGAQUFBzAChjNodHRwOi8vY3J0LnVzZXJ0cnVzdC5jb20vVVNFUlRydXN0UlNBQWRkVHJ1c3RD
QS5jcnQwJQYIKwYBBQUHMAGGGWh0dHA6Ly9vY3NwLnVzZXJ0cnVzdC5jb20wDQYJKoZIhvcNAQEM
BQADggIBAEFEdQCrOcIV9d6OlW0ycWiMAN0X13ocEDiQyOOxvRcxkfO244K0oX7GzCGHYaqRbklC
szzNWVT4DZU/vYrLaeVEDUbCYg+Ci7vhNn9dNqscbzN0xKBoOuRVjPPWDechU70geT3pXCxpwi8E
Xwl+oiz7xpYfY99JSs3E/piztTSxljHitcPr5yoWr9lbkFR8KU3+uGTZ11BfKfuSSaRrZFBv133S
eY0d2AqvB9Dj2ZDaFZA0OQkkhfAqNgDpVRH99lQV4JSKx0N7/QAEtMj6OF5dRXV6hhXuU3A0Eql4
d0247oBpxvnfcmV95QfG8HP059hZSJe7T2wwC+IzXVDQO4xnnvrQJ07ZWemxc/grFpgiG+o+pQxa
pF1bKftysi02Rl6uhdp5wbTeLeYzt2SI9oKSChwGDQQFixtkNnxuwbdrTwvASwvViDPdIGzIQJrT
BqriE5/9nzkXbDZmld8/7DyriJ/A73RIZllX4dH8mHqsRpU8NEX8IQZWpHWGK5A5nVgvl7MxNfRl
IvCvKZQTSnCL8oNqJgHXm6zCB4gBwDonM8V/2kuQAUVazVA3I376eIWGwzjuqh3H88v7mNHzubLH
m5h0ERCSQNz6UoHVZy3q5xeqbYSaxpDQz3lCNObL6sNaOQNh3DcyzqZJYTcGfuLlmC3AIteAAh7l
bybJszYnMYIEXTCCBFkCAQEwgawwgZYxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1h
bmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoTD1NlY3RpZ28gTGltaXRlZDE+MDwG
A1UEAxM1U2VjdGlnbyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwg
Q0ECEQDOBlkPBG+vNzPw8DuTGq0uMA0GCWCGSAFlAwQCAQUAoIICgTAYBgkqhkiG9w0BCQMxCwYJ
KoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMjEwMTIxNjI0NTVaMC8GCSqGSIb3DQEJBDEiBCCm
tGwDceelQ7Iz5aE/EyjExJiQ0lrXfwhUh3+e9PJftzCBkwYJKoZIhvcNAQkPMYGFMIGCMAsGCWCG
SAFlAwQBKjALBglghkgBZQMEARYwCgYIKoZIhvcNAwcwCwYJYIZIAWUDBAECMA4GCCqGSIb3DQMC
AgIAgDANBggqhkiG9w0DAgIBQDALBglghkgBZQMEAgEwCwYJYIZIAWUDBAIDMAsGCWCGSAFlAwQC
AjAHBgUrDgMCGjCBvQYJKwYBBAGCNxAEMYGvMIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMS
R3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExp
bWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2Vj
dXJlIEVtYWlsIENBAhEAzgZZDwRvrzcz8PA7kxqtLjCBvwYLKoZIhvcNAQkQAgsxga+ggawwgZYx
CzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZv
cmQxGDAWBgNVBAoTD1NlY3RpZ28gTGltaXRlZDE+MDwGA1UEAxM1U2VjdGlnbyBSU0EgQ2xpZW50
IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0ECEQDOBlkPBG+vNzPw8DuTGq0uMA0G
CSqGSIb3DQEBAQUABIIBAFtwcmxaS3kMY/vs200ypA79XmnlYazLu+cUczeCmjLxNQv4zuvnyAbr
KnkU5uotIifFQtuEPa2hts8Bksdx8q8kCfIXuDhczDuBVGn52gdCJIxxRPtDwYyMm+4X6+bP7SeO
KkOMr9O13I5ngMB7UlHJkmm81YbhTNO7K/QTb6/l8u1VHZc6EvgkOtuEDPMrIY4ogFXAqmHWlWdF
dZ1XnIPAUeHsW/KPItkVLJ/5W8vy2uSFJj9hkBj/0vba/UgFxCf480CSc9QPcxWSMOD4alrXehjY
EiwDzOz1Tf5K5bztJ9RETZKBVKQcDQMBOo/777Luc4TWDFMOpiwTUhFxZ+cAAAAAAAA=

------=_NextPart_000_0186_01D8DE24.DF956B10--
