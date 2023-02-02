Received: from mx0a-001f5801.pphosted.com (mx0b-001f5801.pphosted.com [148.163.159.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1618F7D
	for <xenomai@lists.linux.dev>; Thu,  2 Feb 2023 21:18:53 +0000 (UTC)
Received: from pps.filterd (m0090335.ppops.net [127.0.0.1])
	by mx0b-001f5801.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312L6geZ005532;
	Thu, 2 Feb 2023 13:08:26 -0800
Received: from usg02-bn3-obe.outbound.protection.office365.us (mail-bn3usg02lp0150.outbound.protection.office365.us [23.103.199.150])
	by mx0b-001f5801.pphosted.com (PPS) with ESMTPS id 3ngkpqg2rs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Feb 2023 13:08:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=Yuhw9x63xvDSIkCRkeC7F9n/tX8C9GxU9sEMpkTjteHupWUXL0xreeJiJJCqh1SmwD1Bf092SB5MPA/9XIo51Ss/42SWe8AKxkA9D66VYNo2FKQpRft4PtkLPgGmZxfYvsrRyE5/3VkewLivj/vZYcxnNMk1Riub+7c1o9mQnIYfhHlJ2YLTOsj5q3c/zWlf8NsUZF8r5T+jZD2tu+aSU2XqImPpuMuC98sRQGuJPKW7wzGNLKJoTqaX1IHq6pO15tts0lazWJC44pLsm5oc4bo4zfTed+ho6Ch0Qf/5BG+1YAOL60avvRhMX9tFPNgsJ3uf7QV7JIivtKUhxM5MGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8bMvudMSMWtigUDZfmtCFhuBds9n3HYMfDEcxrRlXk=;
 b=qPGwKHY0/cs1ft4DyHbCqLC4sr0XRs5ifZQPg4IalKo7961xUSPQVgULwb8W4Kt2WWabQivQVRh4EDyy4YIyI0MI9B+ghTb6OCcxcY+KhfTpel7hKO2tjFgwL2KkmjzOd03njna4Zixi4V+98+3sunpIrkTJkfIEWoF9UaF4EJ1XM6QBofAGafNlbtvoIF7bMrpMR/PwxgqSFfWoONg5nM+5wHv0T1MfSaylMAo+MUSF74q528tlmSEXR8OHOroYuf4r/weV782aOJveQutiuselyRSAonoR45+v0EDNWh9AlrbdCtQpb9eVl3WPJ3R5TUcN1XQxGcBOvzDsrjCccw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kratosdefense.com; dmarc=pass action=none
 header.from=kratosdefense.com; dkim=pass header.d=kratosdefense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kratosdefense.onmicrosoft.us; s=selector1-kratosdefense-onmicrosoft-us;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8bMvudMSMWtigUDZfmtCFhuBds9n3HYMfDEcxrRlXk=;
 b=TXoOjwgN+SMwtVolj+OnG1yU+EbdbvkL1QVMnSkn9ST2Rc6N03HW3bOhjkfj0VtqZq1FqbJJlzIo0KNquRig481CZNgbZYULk1yGZNZMlj97LZmNMCMDMs5mfVWlSMTNvRTU/JPNiMPvLtNh9tyLLb6okLymeINOKCgBDS8NyBXIDb6GQjtn0D0aiUqvDNNcxfGHQHmwKDXzsssM03s7gOwcarByC3+ilbgoPCNTBbrj4xvi4ru+M8hNz2RGpktaaJHG5qdUPW623nwWAQDOxJ1QFlqC+Df3fwMsgd41Imwdl6et0prYF+Y8oqT68Nhv8uL84kK90htzewpfAX4M8w==
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:176::15)
 by PH1P110MB0988.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:174::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.43; Thu, 2 Feb
 2023 21:08:23 +0000
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::5e7f:b08f:4ab4:f6cd]) by PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::5e7f:b08f:4ab4:f6cd%7]) with mapi id 15.20.6043.038; Thu, 2 Feb 2023
 21:08:23 +0000
From: Russell Johnson <russell.johnson@kratosdefense.com>
To: Philippe Gerum <rpm@xenomai.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>,
        Bryan Butler
	<Bryan.Butler@kratosdefense.com>
Subject: RE: [External] - Re: Conflicting EVL Processing Loops
Thread-Topic: [External] - Re: Conflicting EVL Processing Loops
Thread-Index: Adkgi+LtPmHGHADoTpO4vPcK7ox9NgFSNX3AAAHH/gAAB7P/wAAr+3wABCdZV+A=
Date: Thu, 2 Feb 2023 21:08:23 +0000
Message-ID: 
 <PH1P110MB1050E0B3A0465A0D0911F171E2D69@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
References: 
 <PH1P110MB105032AE6426F4599E6A080CE2F59@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB10507C980109C793A20E6910E2FC9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB10507AF7439E0794AC183597E2FC9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB1050C8C197F9CF9FC17F84B1E2FC9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87fscfboox.fsf@xenomai.org>
In-Reply-To: <87fscfboox.fsf@xenomai.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH1P110MB1050:EE_|PH1P110MB0988:EE_
x-ms-office365-filtering-correlation-id: 369dc5f6-43d4-450f-31b5-08db05619ecf
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 8aR7DOQ0vgZg2p9J0Z1xP+HcGX7Y/o+F5XcMHowsZ6tS4DFffVDJ1SJjFx0wp5KsFPhljDKNQzGYnbbJveoOWRGDXCUaVAMCCuitRSe/otQHDPjph0Pc/QKyU8uXRlXt4/4LKYDThFmopzi/ICfUw076B5U5nAwgm+ZLG03xmzLsOBTPI6gQ1b9vPkNcjJ7ipBtpkxnTOrPaRp8pVduZ78eSiWXStcuwfqXcIXtqY3P+9qT+x3T7XJtIslJM5jnQBvGXPIrujs0PdZuRorim5goyO+6WDlTq+yU/Kq9sJBGp5XZRa82qo8I5JixdRckEHVj711rUxGjkzOijLKZge1ftHqFBhvp3XAbzeoyijCKfpgF7JKoWadwsDW1Ln3NVP9e7c6sONMkDtekalO9aO7ayY+q8/B/7NONYU+ksGNXOuuESTJ11cA0k0Sm43ntpgT3U+tovvKsdQx0c31Y8aePeogYh/QR8ylvHJs9v/4RUpp00qtq1gOhD4HyRs4iC3CttmrI7+oM7MCisuuXZjdT7LWi5Cs3Y+b5dwMTI1VTI3wcv4ON/ha2VfmsrzeQQZ5TKu0dIXkIPHiV4XwEpbbvUFNSQITHlRo4HxR4V+iiJCzqCF5gC2en+voDAPsTX
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(136003)(39830400003)(451199018)(44832011)(5660300002)(186003)(76116006)(6506007)(41320700001)(9686003)(99936003)(122000001)(107886003)(38100700002)(83380400001)(66946007)(6916009)(64756008)(66446008)(66476007)(33656002)(55016003)(86362001)(4326008)(66556008)(8936002)(8676002)(41300700001)(52536014)(71200400001)(54906003)(7696005)(508600001)(38070700005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 UyNploIMWovjsicv8W7AfRKuHLfN6G15Aijw9tSP2hASO7WlPliAWKTq/rBu4yjexqZEVOa3jWtVKjurbysrVj2kesw8zdlyYbLTlubfc1LkytRKCxpurkMwHtiQ1MmjohBvYQNvN/1CeImEC+hMiMtM29V/zPbmbkSYN0pHz7LvpnYXoeEwI9imZFpfdFPxV6brm7jA3X0YljeVsF8t+I4ktaW/c3MACSYMP4+xvCctn6EOnVc6aI+QJGPCPtbSr/4QOhT6LCcVzjUxhxsf9OKSr/BWVM+EL4JvDGMpAFWEcLRq56bonuX4a9yGQoD5iaQeYzGTKaZeGr5yJ9sfzkk9ODhbFwNtTiwtdWomYBGxbjPtzQUsQQhq0ydYuHpwLNf0v+oKydR2szhz5rbg2FP/6oOe0TyX8VMc23r6yNXt33FCMLKKe7yZKkQcVDfxIqIHT7JRB3R+00Y0KJOUGWeMV+bLNasQPhMKauxjVnI=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=2.16.840.1.101.3.4.2.1;
	boundary="----=_NextPart_000_01FB_01D9370F.CEC78680"
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	176XHnKGlUL6NjWEyb/nPwIHhrWiThxho5D0kadH+VBzBFhZetl22DGxTeUjC5pomLnPBl466XPRVn4wIJ1shNjunwlGd0FAsP4jHDKp7nxOqNhc/ryhVeK5prGYdhuiGcTbC6VEUPtp8hmRGovAFtYOTD7VkJ9JOyPQ8A9Plfolxt3d+26MoYj8YJUWbCLqpalYXobaKEtkMIvAR4sxv3GG/Cpci4eNQ/CXHd3kpK2rkE/mvre0MQ18GZ3dw6c8snWuIa45x+fgyge3zJtO1AovuBB5Q+xlgSjC0L4CAfPMSg0a21Jre3etLo7SiX0K2WS3Ap8HNWxOgY4Net8TXSk5jRsbHV0FoBEwBMMSADbqtHtJwxpItT02TyeZgaF1jkfnJfTZb2Ikxduthok7OWHGyOH16QFhUC5Hd+8blw5KpVEfKgs/6czI0cykMrxXl0LHm+mRGdnY1q9mAKD2rfUiPjWJvdzH7cUQZwNhT2idiskCtCfPdL2WlD9Y7xHys+3qm32nWfkhnqhLronfzX38igUZ1hWVanlS/sizpXpZS1llE1otwNIKf8IzbxntIo3Guc6qYOU5P2Y4sb+wzjQAHXs9MxDjQm8SJthUGrip3jwTrDrc4wYgV2LitG/oxe1sbj8fajCpk3Duw47ZEH9gjAMVzZUjZ1WMaUN4VRVuVHMZTenj4qFmLK2VsKw8Y+DNrkKtj2mnLb55QJU3vAl2n/VJWAfVFSEEF+EAtYwR+i9zkekVwYX/Doku1x51vbQCFCTv5M9F3mMGM88RGDeMySKk3sY8LG+MrdYKEOyBv+A7aLU51+fVe6HNMVAN
X-OriginatorOrg: kratosdefense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 369dc5f6-43d4-450f-31b5-08db05619ecf
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2023 21:08:23.7090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7932d891-b9cc-431d-be14-d43339fa1133
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH1P110MB0988
X-Proofpoint-ORIG-GUID: HcOPEy56hwGjSw1BKR2-zJwLu5K_bO05
X-Proofpoint-GUID: HcOPEy56hwGjSw1BKR2-zJwLu5K_bO05
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_14,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 impostorscore=0 phishscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302020186

------=_NextPart_000_01FB_01D9370F.CEC78680
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Philippe,

An update and question for you.

First, as you know, we found that the built-in heap management in Xenomai
4/EVL was causing us substantial performance problems, due to the need to
perform locking on all memory allocations. The nolock API is not an option
for us since we perform memory operations in most of our threads. We also
tried the TLSF manager, but saw similar performance issues.

The good news is that we've adapted the mimalloc memory management library,
which I believe implements something like the fast bins you mention in your
earlier email. The performance of mimalloc looks to be very good, and we are
able to get our dual processing loop system running within our real-time
constraints. The current implementation is still a bit "hackish", and we're
continuing to test it and clean it up. I am hoping to get you the specifics
about what we had to do to implement it, since I think it could be a good
option for other X4/EVL users. At a high level, it is essentially a
"go-between" with the Xenomai heap management at the bottom layer, replacing
the low-level sbrk() used to get memory in a Linux run-time environment.

One nagging problem is that we're still plagued by occasional page faults.
We have tried to prefault everything we can think of, but we're obviously
missing something. I go through each accessible section in the
/proc/self/maps file, prefaulting each one (this includes all code and data
segments). I have also added a hack to the kernel so that when the "switched
inband (fault)" occurs, the faulting address is displayed in dmesg. So far,
all of the runtime page faults we see are in the heap section, which I have
attempted to prefault completely, even doing it multiple times during
startup, since the heap section seems to be growing as we start up our real
time threads. 

So, I'm looking at one of 2 possibilities:
1. My prefaulting code, which touches one memory location in each page, is
not actually doing what it is supposed to. I've declared variables in the
prefaulting function to be "volatile" so that they don't get optimized out.
But I don't know any way to really verify that the pages are being mapped in
and locked.
2. A kernel bug, where the pages are not, in fact, being locked into memory.
We're calling "mlockall(MCL_CURRENT | MCL_FUTURE)", so, even if the heap is
growing, I don't understand why any future pages are not being populated and
locked into memory at the very beginning. And, the kernel should not be
unmapping any of our pages, but perhaps it is?

I know this isn't likely a problem with the EVL code, but we're just about
out of ideas for how to find and kill this problem. I'm not much of a kernel
expert. If you have any ideas for how to isolate this problem, especially if
there's a way to verify whether our process pages are really locked or not,
they would be greatly appreciated.


------=_NextPart_000_01FB_01D9370F.CEC78680
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
9w0BCQUxDxcNMjMwMjAyMjEwODIxWjAvBgkqhkiG9w0BCQQxIgQgxMcs1rxmqtD/J39E0IcerBp9
B9w46iGaT/oKN0TUpmwwgZMGCSqGSIb3DQEJDzGBhTCBgjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAoGCCqGSIb3DQMHMAsGCWCGSAFlAwQBAjAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwIC
AUAwCwYJYIZIAWUDBAIBMAsGCWCGSAFlAwQCAzALBglghkgBZQMEAgIwBwYFKw4DAhowgb0GCSsG
AQQBgjcQBDGBrzCBrDCBljELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3Rl
cjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVT
ZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJIF
dv7a2pEWVMfTkiUaPlcwgb8GCyqGSIb3DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkG
A1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0
aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBh
bmQgU2VjdXJlIEVtYWlsIENBAhEAkgV2/trakRZUx9OSJRo+VzANBgkqhkiG9w0BAQEFAASCAQB0
7q/axMiUxZbusNmkVVsWeCAZgqAoHS7DOcbQfNlKST5mqCB5tJliEDO1QIuxF/OgckEFPP3DDqOy
KuLVOqVCbF7hfivuNifW7UruQtPDRK/5NEEuK9x8ziKK75rIEJ0v4s7N4GXukPimx3OjyBHdTIBb
so7VQ7gDQDmPNDiFf1LaRutWvKJlyaamd2aYQJmBgq2KskkVUXnFEV8foT3pXrcFQhUFUwwJkJFm
vs+7eMlHpqIZTj1OZNozEzKsUnyZjgRX4vGQCPIq7yPvMUxO6wraxWWIrqzaWEtwoyH0crLw8enZ
GbVOSMGP3aGwK0rqcim+q+ocAaFOVJWos9pXAAAAAAAA

------=_NextPart_000_01FB_01D9370F.CEC78680--
