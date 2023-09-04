Received: from DEU01-BE0-obe.outbound.protection.outlook.com (mail-be0deu01on2066.outbound.protection.outlook.com [40.107.127.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112A67E
	for <xenomai@lists.linux.dev>; Mon,  4 Sep 2023 08:36:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8yPwki0+q+BJpH64gLHh0AC5xNM0Z5XVbrdLtIOb6eVdCvN5SmClhgUQdMcx/xDgD+a6rcnqTbqNOQPJmN8YgBg2YKCzJnqU3h10ZfKvyYOXsaDT2YCKwd+aWLeDlWxv7mW2WSqEALyCG1lu4dUwfiGxVg0OvRXV12w3vZb8NFnj/nEDfkwr4XQFKUpC7iWLARnG4yEMX2Mmh7j29YGv4tAYuJ5of4e+OszEquKho4K0PJovHM0qzVl6DmU/rTH16oTbioLZ9DSztnRznRzxrUdFucd/IRT4hUf6b+hLl87mmpkb4XQMtskjODbIPB5aVrqgbpQGw/azojwjwWj1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Db/0S3+Xb0r3ZW+TDbN6nawXyG3klr72GQxH5vuCcxU=;
 b=PKP1rtIpvXNPZ4krjx5DER3uN4oaxdKyiCc669NKKUPxzkpvLNqDgB2tSAVVal9KtjzL4l7DYrFQKkooGQi0Er0La9uxZpeC7BQRmba/yxDdPelcz8ClixuwNhhlWknWsxc6M4rqiqLSjmue4jmvuTi8Hz3tKqTb4aBBR3N93/rFS7z07mipMKp+N3McOqxDWDZAD6D8NZn2UBMjetKHxg/1cDy2AAKL1lzdOciYWWHVi4GT3iUvq19Pbso3bpxOmG6bdl8cVyQSsgXr7cra3tGaSTcaR4PElG2ofmNAkvcN1goOiPQ7JiaQ9rgL2CG9AOl0gxl+kJojDS5XoDNn7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zwickroell.com; dmarc=pass action=none
 header.from=zwickroell.com; dkim=pass header.d=zwickroell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=zwickroell.onmicrosoft.com; s=selector2-zwickroell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Db/0S3+Xb0r3ZW+TDbN6nawXyG3klr72GQxH5vuCcxU=;
 b=GnSDf9sj1U1jkSqcai6KJCHmsbDT+2IQUg4pOGmQZMMOxCwewtprPaJ9EZk85zISf6Uku9MOMhvhmMxFY9zeB2iugAFALBrMrIYAIw28LrNZGm6LjYW0FCUFgOBpyPCzvX7dAsoHzhKwv6j9WAEAUprI+c+BP7nvrP0tT/2kxes=
Received: from FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:63::8) by
 FR2P281MB0140.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:e::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.30; Mon, 4 Sep 2023 08:36:03 +0000
Received: from FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM
 ([fe80::4fe7:13ed:cf9:4b55]) by FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM
 ([fe80::4fe7:13ed:cf9:4b55%5]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 08:36:03 +0000
From: "Heber, Stefan" <Stefan.Heber@zwickroell.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Subject: RE: [PATCH] x86: ipipe: Protect ARCH_SET_GS and ARCH_SET_FS sections
Thread-Topic: [PATCH] x86: ipipe: Protect ARCH_SET_GS and ARCH_SET_FS sections
Thread-Index: AQHZ3Cz0cZ4ZdtKK+0+SJegGnaG/dbAKW+eA
Date: Mon, 4 Sep 2023 08:36:02 +0000
Message-ID:
 <FR2P281MB26543530F7B1FA196376CBABFCE9A@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
References: <22ffd839-af5c-48f0-a3c8-136be591302d@siemens.com>
In-Reply-To: <22ffd839-af5c-48f0-a3c8-136be591302d@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zwickroell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2P281MB2654:EE_|FR2P281MB0140:EE_
x-ms-office365-filtering-correlation-id: 7a60fc95-48ba-4e92-2e35-08dbad21f93f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 W0qoUo79p6QsmJT9vd90bKEKMrnF0N2Eio/aQg56M8GTnE06S0pOntZIERlB22wybBMjQQa4ieG2A0/lZqzRIDG3DGNk2O1epkRqdCl6ePlWypieELay3b7FAvzWHGhdLgzWl06/yblfioUDyEe6rd1u9qV6rAzxaI8+OR/OF/1eOBsBezJ2nXBrjYhY4RzmXmxwuInmZaaorKr1ylZTlHefllpLa2UuevWkcvuUiYoJLvGGCA/zA/X3GQO3W7jwgKS0M6EcRlyiE5oWpleMYiBbMktkYHc2lQNOuyuFNcMinXZ78l33qPTUYZfOPGY/KkcLsCcVeXk7dtEfv4NCQwVaPCVmpra02RhR8ad3v+M3A+gwGP3bU7E/uTYtnpQhHCXMnQi1XQ9viO0pKmV7gcbfWyIGrOZdeBWE6yYHCdWDIdzfT+Jy9nhWjRS+8hezDoNGaZP18gOfIHV5uyEZe3XsLAjR9Rfege9d8m7F8T7LZEvUabkTUgUiMbYjYlLwPaHct5BgsEe8QD24bJJSxG1f8EAn21zaZfH6boXYQhOYAJqyRDNn55E53OxQQOyMIRmTu2Nb3Xy2ZIxnlpKdG88e4XqxCaHyY6DuWHycZ6F437PEGkDwI7Mp39n6ll7bwE7caK+ylpe9WmBUMeaNGPpkd0O/7P6t33GTSvG6ydg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(346002)(366004)(39840400004)(186009)(1800799009)(451199024)(7696005)(26005)(6506007)(53546011)(9686003)(86362001)(38100700002)(38070700005)(122000001)(33656002)(83380400001)(55016003)(41300700001)(8936002)(52536014)(316002)(66446008)(64756008)(66476007)(66556008)(5660300002)(76116006)(66946007)(110136005)(8676002)(71200400001)(2906002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ajZIQU93QTNhL2d2eEJsU2tnWGVtRHNua1dOdVptczgzTzA3MkhXN2VFQ2ls?=
 =?utf-8?B?RVVqT3ZIS1FJdmVxeEdyQ0NlRnFOakJENUdzV2pQRFk3NllLUUk5TmVOL3Rl?=
 =?utf-8?B?Z25uU1N0WDNlRGcyS3VGWDBOYVduZXk2UU15a2p4R2Zpckp3N0pWeTZ0QlhS?=
 =?utf-8?B?SWo2TTZ2TktaaWRtay9sU1ovY1cyc1pSclNzVDd5Y2oyUlVqTnBTWkNSVFhU?=
 =?utf-8?B?dHJ5U1FZNEtvejZIUjJQS1MxbFJJd2NvSEJJREwxL1ZVWFhqb01EK0ZNT2lB?=
 =?utf-8?B?Nm5ZMys0Ym9iMnRTSHhld3RGc2gyS21XVHJjSzkwNlZZeTFGSFZqeEdzMG1O?=
 =?utf-8?B?KzJ5MVVHN3F2MUl0NUpUWkRyRnZzNDJldG1sMm5EQlhvaDErSmpSK0dHRUM1?=
 =?utf-8?B?aEFFR3g3M1ppZ3dyUkVoMzFGYjhsSTJpaWs4M05ub05kZlVUaGtRNUo5U2dq?=
 =?utf-8?B?RVk2S0J2WEF4QVUzU1BzUEVwRjFqSExoVG9KSWZROHBDYnJ3OFdPZzJ3bjlB?=
 =?utf-8?B?WHJVTU5HWWRWNGZGOGVFaVN2V0VSNXVDOVRCckhXQUhnc3A0YlJVSktrV2to?=
 =?utf-8?B?Kyt3bzZpbm9pVjFVR3h6RkNSN3NvNEdacCtyblFERGRBNVEraU9EbGtXYzdu?=
 =?utf-8?B?a1kyN0hDSjJjT1N3L0ZKdnRGb1k0NjlBZ0FiUDZlb2N3eUU4MDhEa3NCMnVa?=
 =?utf-8?B?MkVENmhiNXBTY1kvcDdlcjh6dDcwR0d5b09CSkRNdW54dDVyeWpTbHlYNlNW?=
 =?utf-8?B?TS84ZEZGYUY3LzJvMm9OczVsdTBsSm9SMDRaZjlib1F5amJxUlVJS21paGZz?=
 =?utf-8?B?WWsxWWZjcmtqRFB1T0lSZGcvSS9VSEtub1BVSmNHMUVaN0hLV2l1NUZZZGd0?=
 =?utf-8?B?ajdlcHk1RjFUY2hoUmkrbmtRQWtaU1JyMU4yWHMxZ0tQNVBaT2FBSG0ydnlo?=
 =?utf-8?B?OW1Ob1lLMlRDZkFRcGlSUGx4OVdCdTBLczlqdjZybUlKNGpWam8rbG9MYis3?=
 =?utf-8?B?ZzNIT2RDVk9VT1poaUtFVmVHU015RUdtZWtLY2FhZC8zUWUyNENZTHh4SlIx?=
 =?utf-8?B?Sjh5cEcrRXF2TStXQ0xKZ09aV0d4cU01OTZ2VUpxVnpQRy9ZUjIyeDBZQU8w?=
 =?utf-8?B?ajBTTTE1Yy9MYWxtb1FqclhqUlROT2YrK0d6OWVhV2lhcXVGRERvVkozYjBH?=
 =?utf-8?B?d0pSd203RXlackJRWlF6V0ZrRUhKSFZXV2dRekVhWjJ1bm5zUEhES0VNT0ky?=
 =?utf-8?B?RE5lS28yV1pYWFFpamE5djRJc1k5RDMrWlBZNVlPRG9FOW1FaGo0M3VNTzcx?=
 =?utf-8?B?WU5STUJTSUhEdjJmOEdQRjRZRURQZ0p4MUdqOEpDbVFMNTFQazB0bThnMzJ6?=
 =?utf-8?B?WlBEbURDT2ZHbStaOW44T3RjL2dBempXMENrcWZ6OHR4TitobkRVQUc4Zyth?=
 =?utf-8?B?VmFNTkVkaWM0WUlmS3hZU21SdDlWQnRIYXo2a2wvVnRmTC8xcktMUnRsVmp2?=
 =?utf-8?B?Y3M4N3gvb1ZHbmVZOWVsRFUxdnVacGp1b0VUQUNrbTRCRlI3dWliKzNKVm8w?=
 =?utf-8?B?K0lWTzAzZkNrNkdJMVFFQktUMUZxazBjTkNqUlFtU2FrbUZGUnNZdHZhSlFL?=
 =?utf-8?B?cU5pQVVXVlRaSzVxNVRMYXNGMGcyNEJsTkRNNVcxN1RxZStXNEMrdG9nZEM5?=
 =?utf-8?B?WkxoUERldmc2L2grYmxxeGtJQU9YQnhValJqc280WnBJYVNPMStpaWNsS1Vr?=
 =?utf-8?B?cHAvNzRYM0NMQnFOblRPNFZGSFBDNTZmTERBT1NONGlNL3hFTlZtNmdSUEtY?=
 =?utf-8?B?VUxiSTVHMkZ2RmVSK1BHNnVrMDNkakFtSUdnN3FWMStnaDBEMjNmZlQwcXp5?=
 =?utf-8?B?SmUzSmVZczlCVlluN0NJek1TQWN6bG1qTHlzVWVLaHU3ekkwTVlybm5ZcEV4?=
 =?utf-8?B?NXJPQ3htRk9RQUxKR05EcnowOWE4OUhmczg2TVFPVm9ZdW95UERNcU1YRHR3?=
 =?utf-8?B?RDcydStIY3pZcTZTVWdaZWdscStwUVA1aEFXbXRzNVJwcm1UVHNrdDUycG4r?=
 =?utf-8?B?RUxhRDJCKzB4aTcyV1d6QWtlRnlrQnJNRDVBcnExNmwxT2ozK1UzeWxQVmE0?=
 =?utf-8?Q?JpN/Gq//lzSvc5T8rD1i36xby?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: zwickroell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a60fc95-48ba-4e92-2e35-08dbad21f93f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2023 08:36:02.9982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 538edf66-8fb7-4bad-8608-a521ab580ca0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aWMxSMLcTBzpqwJLNgZ22XtAKp9mjYz5Yt03FFvuSlXRoOIP9i2Wn5mCTWDDZmfBrB0pM3W2nMVrBseD0g51yKuWm7kkcCFd9fhJuNad4k4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB0140

Q29uZmlybWVkISBXaXRoIHRoaXMgcGF0Y2ggdGhlIHByb2JsZW0gaXMgZ29uZS4NCg0KLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVu
cy5jb20+IA0KU2VudDogVGh1cnNkYXksIEF1Z3VzdCAzMSwgMjAyMyA3OjAzIFBNDQpUbzogWGVu
b21haSA8eGVub21haUBsaXN0cy5saW51eC5kZXY+OyBIZWJlciwgU3RlZmFuIDxTdGVmYW4uSGVi
ZXJAendpY2tyb2VsbC5jb20+DQpTdWJqZWN0OiBbUEFUQ0hdIHg4NjogaXBpcGU6IFByb3RlY3Qg
QVJDSF9TRVRfR1MgYW5kIEFSQ0hfU0VUX0ZTIHNlY3Rpb25zDQoNCkZyb206IEphbiBLaXN6a2Eg
PGphbi5raXN6a2FAc2llbWVucy5jb20+DQoNCldlIG5lZWQgdG8gbWFrZSB0aGUgdXBkYXRlIG9m
IHRoZSByZWdpc3RlciBhbmQgaXRzIHRhc2stc3BlY2lmaWMgY2FjaGUNCmF0b21pYywgb3IgdGhl
IGhlYWQgc3RhZ2UgY2FuIHByZWVtcHQgYW5kIHJlc3RvcmUgdGhlIHdyb25nIHN0YXRlIG9uDQpy
ZXR1cm4uIENhdXNlZCBjcmFzaGVzIG9mIExpbnV4IGFwcGxpY2F0aW9ucyBkdXJpbmcgdGhlaXIg
c3RhcnR1cCBpZiB0aGUNCnJhY2UgY29uZGl0aW9uIHdhcyBtZXQuDQoNClJlcG9ydGVkLWJ5OiBT
dGVmYW4gSGViZXIgPFN0ZWZhbi5IZWJlckB6d2lja3JvZWxsLmNvbT4NClNpZ25lZC1vZmYtYnk6
IEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+DQotLS0NCg0KU3RlZmFuLCBwbGVh
c2UgY29uZmlybS4gSSdsbCByZWxlYXNlIGEgbmV3IHg4NiBpcGlwZSB2ZXJzaW9uIGZvciA1LjQg
aWYNCnRoaXMgc29sdmVzIHRoZSBwcm9ibGVtIChpdCBkaWQgZm9yIG1lKS4NCg0KIGFyY2gveDg2
L2tlcm5lbC9wcm9jZXNzXzY0LmMgfCA5ICsrKysrLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA1IGlu
c2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJu
ZWwvcHJvY2Vzc182NC5jIGIvYXJjaC94ODYva2VybmVsL3Byb2Nlc3NfNjQuYw0KaW5kZXggZTMw
MjJlNzgyMDAxNS4uMjA3YTI3YWQwNzE4MiAxMDA2NDQNCi0tLSBhL2FyY2gveDg2L2tlcm5lbC9w
cm9jZXNzXzY0LmMNCisrKyBiL2FyY2gveDg2L2tlcm5lbC9wcm9jZXNzXzY0LmMNCkBAIC03MDAs
NiArNzAwLDcgQEAgc3RhdGljIGxvbmcgcHJjdGxfbWFwX3Zkc28oY29uc3Qgc3RydWN0IHZkc29f
aW1hZ2UgKmltYWdlLCB1bnNpZ25lZCBsb25nIGFkZHIpDQoNCiBsb25nIGRvX2FyY2hfcHJjdGxf
NjQoc3RydWN0IHRhc2tfc3RydWN0ICp0YXNrLCBpbnQgb3B0aW9uLCB1bnNpZ25lZCBsb25nIGFy
ZzIpDQogew0KKyAgICAgICB1bnNpZ25lZCBsb25nIGZsYWdzOw0KICAgICAgICBpbnQgcmV0ID0g
MDsNCg0KICAgICAgICBzd2l0Y2ggKG9wdGlvbikgew0KQEAgLTcwNyw3ICs3MDgsNyBAQCBsb25n
IGRvX2FyY2hfcHJjdGxfNjQoc3RydWN0IHRhc2tfc3RydWN0ICp0YXNrLCBpbnQgb3B0aW9uLCB1
bnNpZ25lZCBsb25nIGFyZzIpDQogICAgICAgICAgICAgICAgaWYgKHVubGlrZWx5KGFyZzIgPj0g
VEFTS19TSVpFX01BWCkpDQogICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVQRVJNOw0K
DQotICAgICAgICAgICAgICAgcHJlZW1wdF9kaXNhYmxlKCk7DQorICAgICAgICAgICAgICAgZmxh
Z3MgPSBoYXJkX3ByZWVtcHRfZGlzYWJsZSgpOw0KICAgICAgICAgICAgICAgIC8qDQogICAgICAg
ICAgICAgICAgICogQVJDSF9TRVRfR1MgaGFzIGFsd2F5cyBvdmVyd3JpdHRlbiB0aGUgaW5kZXgN
CiAgICAgICAgICAgICAgICAgKiBhbmQgdGhlIGJhc2UuIFplcm8gaXMgdGhlIG1vc3Qgc2Vuc2li
bGUgdmFsdWUNCkBAIC03MjgsNyArNzI5LDcgQEAgbG9uZyBkb19hcmNoX3ByY3RsXzY0KHN0cnVj
dCB0YXNrX3N0cnVjdCAqdGFzaywgaW50IG9wdGlvbiwgdW5zaWduZWQgbG9uZyBhcmcyKQ0KICAg
ICAgICAgICAgICAgICAgICAgICAgdGFzay0+dGhyZWFkLmdzaW5kZXggPSAwOw0KICAgICAgICAg
ICAgICAgICAgICAgICAgeDg2X2dzYmFzZV93cml0ZV90YXNrKHRhc2ssIGFyZzIpOw0KICAgICAg
ICAgICAgICAgIH0NCi0gICAgICAgICAgICAgICBwcmVlbXB0X2VuYWJsZSgpOw0KKyAgICAgICAg
ICAgICAgIGhhcmRfcHJlZW1wdF9lbmFibGUoZmxhZ3MpOw0KICAgICAgICAgICAgICAgIGJyZWFr
Ow0KICAgICAgICB9DQogICAgICAgIGNhc2UgQVJDSF9TRVRfRlM6IHsNCkBAIC03MzksNyArNzQw
LDcgQEAgbG9uZyBkb19hcmNoX3ByY3RsXzY0KHN0cnVjdCB0YXNrX3N0cnVjdCAqdGFzaywgaW50
IG9wdGlvbiwgdW5zaWduZWQgbG9uZyBhcmcyKQ0KICAgICAgICAgICAgICAgIGlmICh1bmxpa2Vs
eShhcmcyID49IFRBU0tfU0laRV9NQVgpKQ0KICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJu
IC1FUEVSTTsNCg0KLSAgICAgICAgICAgICAgIHByZWVtcHRfZGlzYWJsZSgpOw0KKyAgICAgICAg
ICAgICAgIGZsYWdzID0gaGFyZF9wcmVlbXB0X2Rpc2FibGUoKTsNCiAgICAgICAgICAgICAgICAv
Kg0KICAgICAgICAgICAgICAgICAqIFNldCB0aGUgc2VsZWN0b3IgdG8gMCBmb3IgdGhlIHNhbWUg
cmVhc29uDQogICAgICAgICAgICAgICAgICogYXMgJWdzIGFib3ZlLg0KQEAgLTc1Nyw3ICs3NTgs
NyBAQCBsb25nIGRvX2FyY2hfcHJjdGxfNjQoc3RydWN0IHRhc2tfc3RydWN0ICp0YXNrLCBpbnQg
b3B0aW9uLCB1bnNpZ25lZCBsb25nIGFyZzIpDQogICAgICAgICAgICAgICAgICAgICAgICB0YXNr
LT50aHJlYWQuZnNpbmRleCA9IDA7DQogICAgICAgICAgICAgICAgICAgICAgICB4ODZfZnNiYXNl
X3dyaXRlX3Rhc2sodGFzaywgYXJnMik7DQogICAgICAgICAgICAgICAgfQ0KLSAgICAgICAgICAg
ICAgIHByZWVtcHRfZW5hYmxlKCk7DQorICAgICAgICAgICAgICAgaGFyZF9wcmVlbXB0X2VuYWJs
ZShmbGFncyk7DQogICAgICAgICAgICAgICAgYnJlYWs7DQogICAgICAgIH0NCiAgICAgICAgY2Fz
ZSBBUkNIX0dFVF9GUzogew0KLS0NCjIuMzUuMw0K
