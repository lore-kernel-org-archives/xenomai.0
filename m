Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F05C46BA
	for <xenomai@lists.linux.dev>; Mon, 28 Aug 2023 12:57:17 +0000 (UTC)
Received: from redirect.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::232])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id CF1E4D2870
	for <xenomai@lists.linux.dev>; Mon, 28 Aug 2023 12:53:16 +0000 (UTC)
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay12.mail.gandi.net (Postfix) with ESMTPS id 91B42200003
	for <xenomai@lists.linux.dev>; Mon, 28 Aug 2023 12:53:09 +0000 (UTC)
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2070f.outbound.protection.outlook.com [IPv6:2a01:111:f403:7011::70f])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 7D8469417C1
	for <xenomai@xenomai.org>; Mon, 28 Aug 2023 12:53:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pr/LK3lPDyoDl1z1vG3mhPRjASTX/w43Gds/KJOuiU3h8AE1PGjJiu0Rx3/ldUHbyooZ8HAlM4PvGvbC9IeI3WTLoPZ938VmGLZQib2JnbgF1524UsY3v8bt5hjiFjK84gR0AqgnLzOPfTJOwnpUreMAEk1v5p7hFqyDUN6X6qwTaa8XVbtMn3uof+BtCIXiEIDdunDWp0PVJR+S0MttRy+37s7lWov0WpAOs4P2fbPxxeKK8Q+YN6p3qRupiqrdyV6k5BywgtJqiFFJ7RVfTT88bcsUvB4/Och26oxV3DTWsdVlPohkKjjG3EJEkkXiX7VliTZtAZF4OHPb7JD0zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0P6iypVdP5pMKU8RDXXpjXnG8q7w/OJovGgVaW16pY=;
 b=INzWDaRRnJH2KCrNCssRtU2gZi6Q6YTtv7gzTtJWdA26HuAD2LZlbfOKI7M/fALVmWrvQZ5MJyKwbWZU3gMaXBCp+hI/RbOHW3wTM8ktnSGtCXzsRbin0KIUgTHGVI4UwI7OF77VygZcdDXH5XXBzyEYQxuPBU4mE3VNUWte2fcueJDi91qlbKGwgz3iy2RPT/cfy/8L17CnnKKFrEXwU/1aikCdOXWRS/WHVmKxwb1Y7LWxrIwO75u/NIkb8ra9YMzju3UUrD0DXl5bneRQCjRWwrf6viwaVCHQVPMibL+7T88Rq+ACTGM2Bhys8ZAqYwJsAg6MjzgoiVafH5g01Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marketsdatainfousa.onmicrosoft.com; dmarc=pass action=none
 header.from=marketsdatainfousa.onmicrosoft.com; dkim=pass
 header.d=marketsdatainfousa.onmicrosoft.com; arc=none
Received: from PN0P287MB0603.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:166::10)
 by MA0P287MB2094.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:121::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 12:53:05 +0000
Received: from PN0P287MB0603.INDP287.PROD.OUTLOOK.COM
 ([fe80::3374:c0ec:d451:429]) by PN0P287MB0603.INDP287.PROD.OUTLOOK.COM
 ([fe80::3374:c0ec:d451:429%4]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 12:53:05 +0000
From: Claire Davis <Claire.Davis@marketsdatainfousa.onmicrosoft.com>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>
Subject: Re: xenomai Electrical decision makers
Thread-Topic: xenomai Electrical decision makers
Thread-Index: AQHZ2a6WfDZR4QMgJEq+qrGhgxnq7g==
Date: Mon, 28 Aug 2023 12:53:05 +0000
Message-ID:
 <32a5e158-fece-dd4c-ae6e-687421a42ce2@marketsdatainfousa.onmicrosoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0P287MB0603:EE_|MA0P287MB2094:EE_
x-ms-office365-filtering-correlation-id: 931f3b84-de61-4706-8a64-08dba7c5b8d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 VeZ7tGVaClTasjfl5+iTRBfAXMA+MgC5TUC2Eyptkio+fiZZotSh6Yk3jsx0IW9M7yUcIqEkTlTKRdtohy7DhbeUnmB9K/rg7WPNuOuSaTebGoSUxkQovNu6UigaqypgiONDCUYFh0wzHLijINCrpbjxfpx7tIF+HRVMsXoYxUzgGeleC+Hxx+BSEh2BGFUOrs28Q5TLMNQ/Fouiz+Xu6b3KkfjmqfDXTtpcdzRvy4t/Ey40gB3UBe2TGVGSU5JIVwBzPx4KZ9U6v3NoOFuvXx5vF/w+HfVBUQKG3JPfrHK7HZppY6qYGRFWRZClkIQuIhxeyh7nc2GH91M+6hQKS8jDV6GP6LAfbGBfwCyGoAE2RxwC9AJP4MlBhKHPdB0CdiMBkEzKW/U1ae2H5X7FPQp8rts314KTcqsVRsQcSQ+1tmawLl+jDSdv8AssD4JP0L6MJNnmYdsfq8FjsV7LKtTIjk41AXsFadEXdilZUCKuVsv7ZcBWt3wDW6u35NnTf72hZSFHLimU3Z0qiCh9+II13EFiX/l6HyRckQnUc1KO36CU/AZf/xMaHj6i3l+JER+QjRDXb6UeN7uw21JoB/jH/vZnRy1DDAws+QFLW+TwUabpuxD19iRctXqKlcNNGG5GGsGGFF3TpiG88lNc1uy3fc8pzhkXxIR1n9MESWQH72Bn48MfyKiWfe+qd1HP/3I86j8aDzKXxpQHyG+WeDrvPKuXMdifdDtr4APklTxDllaN60kD3Rjz/oft5QEvPqjB5x/aZ7Dz9fZaoFC9fOixIabG6aJ3d9Yp7EgBEnQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB0603.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(39840400004)(396003)(186009)(1800799009)(451199024)(41300700001)(66899024)(122000001)(38100700002)(86362001)(31696002)(83380400001)(478600001)(38070700005)(71200400001)(2616005)(3480700007)(6512007)(53546011)(6486002)(6506007)(76116006)(66946007)(66476007)(91956017)(6916009)(2906002)(64756008)(66446008)(66556008)(316002)(5660300002)(8676002)(8936002)(31686004)(13220200019)(437434003)(581174003)(45980500001)(6396002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?azJ3Q3lVdjVpMkpuTUJPN3hodlhudndaTEh4cmxmbXdYVFh4WEtBTGpySXVH?=
 =?utf-8?B?UTVHekJaWUFIeTk4SktSditRbEVPMmV3aFAvVW9oeVRTSTdSS1Y4OWVFZ3hK?=
 =?utf-8?B?WDZyakJ5cHdjSENQUURDTWF2T0w3QWtrTlV5SzMyb3RBaXQxKzhsT1MyMG00?=
 =?utf-8?B?cWQ2QnJJRC9CN3kwSHQ0RW5NV1BpdVF6ZHV1Q3lRd29GYkcxOTEyQTBTSmNH?=
 =?utf-8?B?YXROOHVYTm5uSFBMUHJJNEpNZEVxcEZyemdkbm9laGJBNFB3Q1huSTlxa0dS?=
 =?utf-8?B?VnlESldVUGNnN3NYTlQzYUFJdnI1bnFaUHcwQkUzNHh5R1dvNUN6bGExSjhZ?=
 =?utf-8?B?ek1Zc3BySXF2ZUJ6WDVzM3ZaS0llT2l6NE5TMlFrTWJwZmFnWXoyK0lGUnB1?=
 =?utf-8?B?RG04dTVwSFM4eG82QlFLYWRSaVpFdk15SFI5MDVLVHJlOVpuWUI0QkJRcktL?=
 =?utf-8?B?ODdEcUl3ZjJuNWtHMmpTanpmL0M4bjNiTHl5UUFPV2JMYUY1K3NEc2dzT1Yx?=
 =?utf-8?B?Szk3dXdkQWhCdWJOS1p5V0pSVFpzUDQ4Tm5VZjZSNnpOT2Rnd1hRN0lxYUhW?=
 =?utf-8?B?YnVMKytLU28zakExQ0lMb0hJNkpPQ0p4bmk3ZllwYVhoY0g4dHg5c1NDVW9X?=
 =?utf-8?B?RFRHdUJiN2FPckhmR2NodUNUNExtTko4Y3BGVGdBZENZQmhLQTQyc1JVcjV2?=
 =?utf-8?B?bmpISG8yZ21GMTVQWFAwQU5uMDdTKzg0cXlHOVFZd0xnbll3TjNVMnI4Qkwy?=
 =?utf-8?B?TzlqMDlpaVBxdVp2RkRHQjdWdXo3ZGR0UGJ1VGhFVzlybSsyYU1SK2UxWWV6?=
 =?utf-8?B?ZWxVYnFpM1YvVUN4cHpZdjN2UEpFbGVCNWRFZC9MR0doRUI4N0tDWSsyeUJW?=
 =?utf-8?B?bTA3eHBmeWtjUFVOUVZJeXJMWXZjL3RlRHo3VVJNcGNhY2JDOC9HdDlrdWo3?=
 =?utf-8?B?ekZMZFRpZ2d6V0JMQTBVemN2cUgwblVXZU9MQmw5MTVNSldEM3ZIN2tBc1dE?=
 =?utf-8?B?VkhYbThLZnJ4cFRucFhObVJmcHR5MnQ3REJzRFNXdlQ4bCtMMXRZYVNLMyts?=
 =?utf-8?B?NVZHaWMyYlNFQUJZR29vbVd0WHl1SFh0OVZZVUVnZXIrSVRaeEZabmJ0aFlK?=
 =?utf-8?B?WFFmYWcvVEkrT0dqUithUVV5SmxaSTIwa1I5bzFUL0J6S2lQV1RkMFUxMnlD?=
 =?utf-8?B?UWsycXpvVlZLb0FzTTVjaU5QY3ZnOVUxQmljZ2lSN3FuczBVVmFTUXAwOHdS?=
 =?utf-8?B?a3prdU51QXZwaDEzWDdKZ2dWcHBzTXQ5RnA0UDVRNktVN3NKeHhsTXkrTnFp?=
 =?utf-8?B?S3crbTM5VmRDUjNpQXlUcWNzcUp6Mi9HTDR1V0R4YmRuOFJMUFZLK0JIMnNl?=
 =?utf-8?B?RnQ2V1Ric0pha1ZKV0VBaGhYeUJQTGxsQ2ZEWDNSb2dKS1prS1NOMTh2V2Mz?=
 =?utf-8?B?dDlpdHVlNjRZbmtQSWJ0WUJYVnpkdG9WanQwdGIzTExaR0RDR3pJSmdrZ01l?=
 =?utf-8?B?K1ByV1pqbEJZYUdOZE5HUXcwRnVvb2NRYU42UTBtQll1Y3MzbmIyOHVKb3dj?=
 =?utf-8?B?cjRmQVkvUFNtclpobE81SDQwRzR5YXVrTW1yT04wMFZjM0pFcndvNkpRaDNs?=
 =?utf-8?B?QUJXSkRMNEJXT3JVWmthN2pVZWRFWEpQa0YzSEdJVVluNE1MMGpoWktEeXVX?=
 =?utf-8?B?U2l3bFZsa1lmdUU5RjBOZHB3ZVIyWTBIZXVLblVPTXhoUGNIVXFkNnpRdU1v?=
 =?utf-8?B?Zm5Wa2Mvd0tyNkVJK2Iybmo4NlhTVmtCMWVhU1Z5R3ZxQUcxb2NzSEIyUjYz?=
 =?utf-8?B?Z1A0NndpMkpyemUxT213MXNWYndwQlozU0tSYTBjbnZpVW5uVmxmVG5rWUgz?=
 =?utf-8?B?b1Ira09MSzNyWWVwRFdadHRaTDRRNTNvcWVXankvMm4yZTk3bFlUS24zSldO?=
 =?utf-8?B?NFo5S05Kb0plUiszVjZyQkJTZ290VXJQRFRPaHQ1d0lPVks5Nkh1ZGF6VVZF?=
 =?utf-8?B?NVVKRDJHcUpLdzVGVlZhdTIrWGdFNitQNVJ5WTJXT0s2QVFNaGYweE52ajhC?=
 =?utf-8?B?cEZLL0tIVEhNbkgvYzc2N3MzMjE4TWVWaUdjSVhQQmxRekJGanNNNm5DRUk2?=
 =?utf-8?B?VXZ4a3Nnazd4djdBM2d5RDVtTDZ3aHM0dms4b0JCRTdCUXgvRXEvMFcvam52?=
 =?utf-8?B?VVNWWkpodDlJS3dNSmwzV3VwUTErSkJvRjQ2WXYyQ1FFc1h3U2pCQUZFQ2c2?=
 =?utf-8?B?MUpSWWEvTEdsbnE5Vk5udXZUTHdITFY4NGNLdzRha2ZnK1ZSdlVCekl6MFFW?=
 =?utf-8?Q?MuUnohxTn0Koct/vJa?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F1A89D8F0CAC542BE0A66580F08BA23@INDP287.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: marketsdatainfousa.onmicrosoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB0603.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 931f3b84-de61-4706-8a64-08dba7c5b8d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 12:53:05.3870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 62dfda68-9244-4547-9a56-5a49125b28f2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LHlaxGrXqdgViiatA1uQva6IJOcPFMH1LL4H9y1aA7t/omYv5Vhv2VP85WgxYWSDUfiH/Y9i/35U93v6YXE+dB+ZgPG4RWh75SdmcbRkNaCwX0bpBRUYhvez3NyytHtnVOP0UiulhnYpSP9xRSFwqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB2094
Authentication-Results: spool.mail.gandi.net;
	dkim=none;
	dmarc=none;
	spf=pass (spool.mail.gandi.net: domain of Claire.Davis@marketsdatainfousa.onmicrosoft.com designates 2a01:111:f403:7011::70f as permitted sender) smtp.mailfrom=Claire.Davis@marketsdatainfousa.onmicrosoft.com

SGksDQoNCkp1c3Qgd2FudGVkIHRvIG1ha2Ugc3VyZSB5b3UgcmVjZWl2ZWQgbXkgbGFzdCBlbWFp
bCByZWdhcmRpbmcgYSANCmN1c3RvbWl6ZWQgbGlzdCBvZiBUZWNobm9sb2d5IG9mZmljZXIsIElu
Zm9ybWF0aW9uIHNlY3VyaXR5IG9mZmljZXIsIA0KRWxlY3RyaWNhbCBFbmdpbmVlciAmIEVsZWN0
cmljaWFuIGV0YyBjb250YWN0cy4gSeKAmW0gbG9va2luZyB0byBmaW5kIHRoZSANCnJpZ2h0IHBl
cnNvbiB3aG8gbG9va3MgYWZ0ZXIgeW91ciBwcm9zcGVjdGluZyBhbmQgbGVhZCBnZW5lcmF0aW9u
Lg0KDQpXZSBoZWxwIGNvbXBhbmllcyBncm93IHNhbGVzIHdpdGggb3VyIGhpZ2hseSB0YXJnZXRl
ZCBlbWFpbCBsaXN0cy4NCg0KUGxlYXNlIGxldCB1cyBrbm93IHlvdXIgdGFyZ2V0IGluZHVzdHJp
ZXMgYW5kIGpvYiB0aXRsZXMgc28gd2UgY2FuIHNlbmQgDQp5b3UgdGhlIG51bWJlcnMgb2YgY29u
dGFjdHMuDQoNClJlZ2FyZHMsDQpDbGFpcmUNCg0KT24gMjAtMDMtMjAyMyAxMTo0MywgQ2xhaXJl
IERhdmlzIHdyb3RlOg0KDQpIaSwNCg0KV291bGQgeW91IGJlIGludGVyZXN0ZWQgaW4gcmVhY2hp
bmcgb3V0IHRvIHRvcCBsZXZlbCBJVCBhbmQgRWxlY3RyaWNhbCANCmRlY2lzaW9ucyBtYWtlcnPC
oCB0byBwcm9tb3RlL3NlbGwgeW91ciBwcm9kdWN0cyBhbmQgc2VydmljZXM/DQoNCiDCoMKgwqAg
Q1ZEIFRlY2hub2xvZ3kgb2ZmaWNlcg0KIMKgwqDCoCBJVCBPcGVyYXRpb25zDQogwqDCoMKgIENW
RCBJbmZvcm1hdGlvbiBzZWN1cml0eSBvZmZpY2VyDQogwqDCoMKgIEVsZWN0cmljYWwgc2Vydmlj
ZSBUZWNoDQogwqDCoMKgIFNlbmlvciBFbGVjdHJpY2FsIEVuZ2luZWVyDQogwqDCoMKgIEVsZWN0
cmljaWFuDQogwqDCoMKgIEFkbWluDQogwqDCoMKgIE93bmVycy9DRU8vUHJlc2lkZW50cyBldGMN
Cg0KV2Ugd291bGQgYmUgaGFwcHkgdG8gY3VzdG9taXplIHlvdXIgbGlzdCBhY2NvcmRpbmdseSBm
b3IgYW55IG90aGVyIA0KcmVxdWlyZW1lbnRzIHRoYXQgeW91IGhhdmUuIFBsZWFzZSBsZXQgbWUg
a25vdyBpbmR1c3RyaWVzIGFuZCBqb2IgdGl0bGVzIA0KeW91IHRhcmdldCBzbyBpIGNhbiBnZXQg
YmFjayB0byB5b3Ugd2l0aCBhZGRpdGlvbmFsIGluZm9ybWF0aW9uLg0KDQpSZWdhcmRzLA0KQ2xh
aXJlDQoNCkNsYWlyZSBEYXZpcyB8IE1hcmtldGluZyBDb25zdWx0YW50DQoNClJlcGx5IG9ubHkg
b3B0LW91dCBpbiB0aGUgc3ViamVjdCBsaW5lIHRvIHJlbW92ZSBmcm9tIHRoZSBtYWlsaW5nIGxp
c3QuDQo=
