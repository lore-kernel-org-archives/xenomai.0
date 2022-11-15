Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2052.outbound.protection.outlook.com [40.107.135.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860F3139E
	for <xenomai@lists.linux.dev>; Tue, 15 Nov 2022 15:07:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNjGr4sTp8TEqsDBDH9riN0MY+B1P4s7bDMcnD3i2rtpm+v/ZXp1aH1T/CcESk/DNWJ83DahgER9lu3DBXlD39ZiH1ZnsGManuE1Ac3zRCLqeL7/spyurvT9HBb5qIgBb3CQK7yv89ultNaIG2/5xsMFYc2GtQD0IikMrX/HMMpJLZ+yUpNPqOGVRCeRghjDGEe4Szbtg5tlXJPv9CWUxz+PslFJY86B8JwKzbU9WNrPV1OtI+ERbHKnsLOkm/NfRKLkPeJgVQ4/591NVElW4slcVywtpnfNwONc/QTOGtx10mMSFJVInzEDvlH/xqbXNHKHT9tLM7eiuJ3TCMaGzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RYzjw0nuiTPswyTiZYETiW/1GH47VAgdWq/xhqS27wE=;
 b=Y+anWSuQ0+Q7zm88zczdr0geU7mY2EQQnR8ze8vE02a1KKMcWZRBaBBc2hJrOERaMGfxM65M9Qs3f31BZx2pOq58NPk1tayLnNerU36kUwu7sLGisJ+8LeDGJShGKEmO9Ix8bN1cLF11wu74arm9ZSPbcIWarYuu5PFB8eVKHxOxE72qFIwc8LJWXnCOLZxod6EonVupyZSxbX+wv5lBs1C19+yseLFi3BhP4wQ6m1EwDc+sR7GbRLmiln/KpFwTEw18O2XsKtwjvW6jc/YanlZDkZjCy2UkdONkqjgb73TamyjLX/uHg9NJA1MIpl+lpVUNKXyDFkAo8xd9uTpQcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zwickroell.com; dmarc=pass action=none
 header.from=zwickroell.com; dkim=pass header.d=zwickroell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=zwickroell.onmicrosoft.com; s=selector2-zwickroell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYzjw0nuiTPswyTiZYETiW/1GH47VAgdWq/xhqS27wE=;
 b=IXsaOWkx5cA087ENjy4Nbbefjbj/zLE+E7TaK+Rci/A8MmIz9P2xI5n2MQB6uD+se6Ejd7oGrCtAacLMJege61MaNyYKmV+vahjXMp7UEDGZKm+gmQO0lOyA+kQhW3b0funiEP1xtSyF3aBCgfiLGk/ZyNc0tTHPNytzMee0E+4=
Received: from FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:63::8) by
 FR2P281MB2638.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:61::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.18; Tue, 15 Nov 2022 15:07:56 +0000
Received: from FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM
 ([fe80::b3f6:e832:1424:434c]) by FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM
 ([fe80::b3f6:e832:1424:434c%5]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 15:07:56 +0000
From: "Heber, Stefan" <Stefan.Heber@zwickroell.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
CC: "Zhang, Qiang1" <qiang1.zhang@intel.com>, Xenomai
	<xenomai@lists.linux.dev>
Subject: RE: [PATCH, 3.2.x] cobalt/x86: Fix FPU switch during thread hardening
Thread-Topic: [PATCH, 3.2.x] cobalt/x86: Fix FPU switch during thread
 hardening
Thread-Index: AQHY8tBIefZdlIhkCkuAkXKVDs4t+K43uJKAgAH4L/CAACJ8gIAGTlkQ
Date: Tue, 15 Nov 2022 15:07:56 +0000
Message-ID:
 <FR2P281MB26546335664C41F97F3D8CC5FC049@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
References: <3a80ab49-09ac-2403-8e1f-6e61e3726657@siemens.com>
 <2934513f-c67b-35ee-e72c-dbebd23a432d@siemens.com>
 <FR2P281MB2654EB01BCBD13AD63A59326FC009@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
 <29fd6c4f-65cd-3961-99d0-aa1bbfc542d1@siemens.com>
In-Reply-To: <29fd6c4f-65cd-3961-99d0-aa1bbfc542d1@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zwickroell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2P281MB2654:EE_|FR2P281MB2638:EE_
x-ms-office365-filtering-correlation-id: 041596be-8580-4723-63b3-08dac71b2d2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 /+e/zSkD3Y9ilsz7Gyf0Uk634/VzdG6jQXZuo/q2JdSeSFtILKkTMZTuHLwhPfHZzXs4X5oJKak4ROss7CRAF9uiORobRwaUYJQQP1Sf1WTeTQc6RDa7gATQ+ZAtqItoi5KDt08nSZqGrM6QB73VjSkSJKrVdkhqAhN7abFIVCTSk1hxYzpc3Qbl48/PNUukCmATH17tm/KCswhJoFKw/bKUBOCvz4YygEbD43zNEzpX1usp0zdmrrUURGZXLNDfzAEyERMemgOKqNV6enKd3KH66JgANo8YWJbMUuD+aa0PWe3on9SubRJQfUYyUWt+SQGPV3L8a2oFG0Ixu6N05nBmKQLbLxLsCzTiRs/lkcI9g0H9JAF+YQGvevdbVEBgang5FxuueF0858hJZC4Zl404SH9D3nb+kLwAW6RiSquZ2NTTfh2qatcMAiBhvZBmRC+FDQidg/1AAhg2Y2G6yKtc3tbKeMllimYg9d5iBAPUf92kjbyf6rbBKUNV4birmxaHhJt4XIDDSgFXcgy29D6XNq8JB0g8pwL3Im61JPuf7zeQ/n4brson0YI6PewGx+z3o9Ec+jYu4RUh9GbOlH84vUDh47TdOvoCvoK5zHrmROEBXXjGsfgT3ezsmN03njmkJbef5MvM6b5IBQkcNu/Xag1mxdvEzpmoX5wLo6f3U8NpUVJYFFRoVSYsNOD61geGjloWSesSWFx26CO1WGAnS4G6vO0AgGWq8Z+sIxCowk7xh0SXIqmLJ1iNNpcJN49M+U/eg5VjPEESxQa7+Q==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(451199015)(478600001)(71200400001)(38070700005)(5660300002)(8936002)(122000001)(83380400001)(38100700002)(86362001)(33656002)(186003)(9686003)(26005)(7696005)(6506007)(54906003)(55016003)(6916009)(316002)(53546011)(41300700001)(66476007)(8676002)(52536014)(76116006)(2906002)(64756008)(66946007)(66446008)(66556008)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cXpQMHRDOWZkaTNVRXJWdFpSa2JOM0ZSSHNHK0hXRmhkdUlzQjJNbFRQdVV1?=
 =?utf-8?B?SGFOQXZuQmd0Tm91SkRtYzljalcrSlZhZG8zL3FBY3BtTUh4YXNpRkJocmlO?=
 =?utf-8?B?RlpJOWp1UCt4MHZMdWppTHp6aDNTcnJHZlJaZkJVR0VNVUJicnhGMGhDOTdk?=
 =?utf-8?B?QmlHV2JiWDBEc1ZsS0puMktTQ3kvNlFpNXcvMTM4U2NrdGhxclMyRkZqWEdl?=
 =?utf-8?B?UVNpNFJvS21UTGwrQVFKdktxcHNMUVk2Q2RkYTRqQW93UHBGZ2hPNm11OGtC?=
 =?utf-8?B?RjFvZEpVcFVSZ3JaaDlLakJibjQyRFFGc2p5VVlHUk1FQ2pRVVFnaEpqbDVh?=
 =?utf-8?B?ZXpTQXE3TEEwcE90YVVNMXk3QkhSQ0pBWElBRExseE9KVlR2WnJ3OWJwOFNN?=
 =?utf-8?B?dTVLQU0wY3VsNVVuQWc0RG5PaXV6S1hUUnU4Rm9UVEpPNFlzdi9iclowMTJG?=
 =?utf-8?B?RnJVbFIzQldEelFHNWtoRTdQNjQ1djZhOTF2dU5ZaGNYbXA4aWhieUdjbVJU?=
 =?utf-8?B?REwzblJlK1d0eGJDVkIxeXptMEh5SWFkeCtkaEhwWUwxMFJlOXoyQ2lhZS9I?=
 =?utf-8?B?U1pWd0RCOTM5RzlwaklYcmE0b2JUQXMyNWRNZ0J0OW1kblRpc0pOc1M1WGdn?=
 =?utf-8?B?ZlJlZGdyWVJrNGNFNWN3c1cyMkJhQTAxM1gvQ2Q4Ui9IN1NDTVkzQUJ6SStV?=
 =?utf-8?B?NjM3dm9KbGJ3eVo0dkZ2RXk1TnNYQzNWUTJhaklXZ2c2aWdPRjhhWC9LcXYz?=
 =?utf-8?B?SGR2bFRZQnFwNWYwYXpwK3o2QmJVbWlVVnhEVlpZUENiL3VVUmNLRktIQ3dC?=
 =?utf-8?B?LytBVHJpMkYxZ29pOUNaSnpvUW40dVRIemUySU1xMU5PeE1HamE2YzVjU2E4?=
 =?utf-8?B?TkM0Wm5jSGtoU3J4VUFwbWtNVUNIV3ZFdkZnaVVJdjhhemxxaXVMSm0yOWl3?=
 =?utf-8?B?S0xvOXNWOHJrVmwzK1dBMFpQV3ZVellNNlJjNitpYkFyT2pHcXU0M2N6U3pH?=
 =?utf-8?B?cVR3b1F0NExIQmpTSXFZblc3dExVMFRYbVhLKzNNVldyMWNYRWRIM0U1WGM3?=
 =?utf-8?B?MmE4UnRad0xxZUpmZVN5U0pla3JZR2kwQ3VpS0VhUHRmN2MvZXlhaWxJR2RR?=
 =?utf-8?B?b3pJVXI3NGNpdXdCV25rVU11Wk1RSkxSc1JZUTlLL1BVTnRZMW1GY0dUN2Y0?=
 =?utf-8?B?TkhyMUxtSnd6WHR4NDVMVUVxNXMzRG9RbldVcXNXY2x4c2hXYk1nTVQzM01D?=
 =?utf-8?B?M2hxdUhtNzhLZHVRL2FCM1l2OHB2QlJOSW9xN2RiTVp0eVhJWjVHMWVGNUxw?=
 =?utf-8?B?Q3poVHJpRVR1bnZkQm93YndnMTJVR29tRlM3MG1Pa3JDSlZIeVNINHFUamNY?=
 =?utf-8?B?R2UvQ3daQUt6NDRxdERtTVU2VEVablpKMk9ZOXY4U2xrMjdNWnl1V3czZkFm?=
 =?utf-8?B?aEVUNTRBLzF5TmpRWTF0VmRvSE5EaXRhTiswYnYrQ2QxdGZmNEdxU2toeUtD?=
 =?utf-8?B?c253S3dLRThseHpxN240MTdlRDkzVWhUdHkyVmVwbytYdlNBSjNvVlZUQ2FF?=
 =?utf-8?B?R0FnTVNkQldqNkkyWWdMbGpNVGtEUEp4cFFFYkQ2bHQrZEZ0YzNnWWdodWkr?=
 =?utf-8?B?L0tyRG12emFCR1lGNVZLVU9HY1F6aS9xVFBBc1NVcFpQYktHQTc0U3FPNVBE?=
 =?utf-8?B?bFp3WGFVMkpWN3c5Rlplc2VTdkZERTF5Q2dFcFpqV2ZkMElSazV5QU1LN0ZQ?=
 =?utf-8?B?b2s1Ly9IdTVGb21YTGJSZjZiOWN6bUNKa1dLbzVRemMyeTlST052dmNRd0pR?=
 =?utf-8?B?c1k2ZmViclp2SmNRNUdXbUg3NUxRYkF5U1hGczBKS2lSUjlGWWc1N2R3a1V4?=
 =?utf-8?B?S3k5Z0JVQkgvM2F4VjNEek1ubVkyK0NiMHc0aG1DQ0gxSkpseDlQRWhNUTRI?=
 =?utf-8?B?VjdhMCtQcDVaUk5KTGl1OHFPd1FBdnozWkdiNDErUHE2emJYK1B5MlNvSzht?=
 =?utf-8?B?Y3R5VUxxZTBUMXNUR2xtVU52NnZpa3lTcTN4U09SSXFVbmJySEpEc2RQVUpW?=
 =?utf-8?B?bUFRaHpMTjBxQVkrKzdpSkwvVytXK3d1TXJKK0E3OFRickpET0tNd0xtSnZ1?=
 =?utf-8?Q?+3CDn5vEPZ4PyroKzZzuTSrmS?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 041596be-8580-4723-63b3-08dac71b2d2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 15:07:56.1870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 538edf66-8fb7-4bad-8608-a521ab580ca0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pYCh33uv/TPtUYVzm0XGO0to3Ur71bdeQ1BohNwa9Ffei/eAyFYO+fezxH/12T4QegJXtivdhSl0eLancm7E4zjd6SyFh0uxoua58NgakrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB2638

SGVsbG8gSmFuLA0KDQpJIHdvdWxkIGxpa2UgdG8gdGhhbmsgeW91IG9uY2UgYWdhaW4gZm9yIHRo
ZSBoZWxwIGFuZCBmaXggd2l0aCBvdXIgcHJvYmxlbSBoZXJlLg0KIA0KRmluYWxseSwgSSBoYXZl
IHR3byBsYXN0IHF1ZXN0aW9ucy4NCkl0IHdvdWxkIGJlIGdyZWF0IGlmIHlvdSBjb3VsZCBnaXZl
IGEgc2hvcnQgYW5zd2VyIG9yIGFzc2Vzc21lbnQ6DQoNCjEpIFdoeSBoYXMgdGhpcyBidWcgYmVl
biBkaXNjb3ZlcmVkIGp1c3Qgbm93LCBvciB3aHkgaGFzIG5vIG9uZSBlbHNlIGluIHRoZSB3b3Js
ZCBoYWQgdGhpcyBwcm9ibGVtIHNvIGZhcj8NCklzIGl0IGJlY2F1c2UgdGhlcmUgYXJlIG9ubHkg
YSBmZXcgc3lzdGVtcyB3aXRoIGtlcm5lbCA1LjQgaW4gdXNlIHRvZ2V0aGVyIHdpdGggWGVub21h
aT8NCkFwcGFyZW50bHkgdGhlIHByb2JsZW0gc2VlbXMgdG8gb2NjdXIgb25seSB3aXRoIDUuNC4N
Cg0KMikgQXJlIHRoZXJlIGFueSBjb25jcmV0ZSB0ZWNobmljYWwgYWR2YW50YWdlcyBmb3IgdXMg
KGZyb20gdGhlIHVzZXIncyBwZXJzcGVjdGl2ZSkgaWYgd2Ugd291bGQgdXNlIExpbnV4IGtlcm5l
bCA1LjEwIGFuZCBEb3ZldGFpbCBpbnN0ZWFkIG9mIDUuNCBhbmQgaXBpcGU/DQoNClRoYW5rcywN
ClN0ZWZhbg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogSmFuIEtpc3prYSA8
amFuLmtpc3prYUBzaWVtZW5zLmNvbT4gDQpTZW50OiBGcmlkYXksIE5vdmVtYmVyIDExLCAyMDIy
IDM6NDcgUE0NClRvOiBIZWJlciwgU3RlZmFuIDxTdGVmYW4uSGViZXJAendpY2tyb2VsbC5jb20+
DQpDYzogWmhhbmcsIFFpYW5nMSA8cWlhbmcxLnpoYW5nQGludGVsLmNvbT47IFhlbm9tYWkgPHhl
bm9tYWlAbGlzdHMubGludXguZGV2Pg0KU3ViamVjdDogUmU6IFtQQVRDSCwgMy4yLnhdIGNvYmFs
dC94ODY6IEZpeCBGUFUgc3dpdGNoIGR1cmluZyB0aHJlYWQgaGFyZGVuaW5nDQoNCk9uIDExLjEx
LjIyIDEzOjQ1LCBIZWJlciwgU3RlZmFuIHdyb3RlOg0KPiBXZSBoYXZlIHNldCB1cCBvdXIgY29t
cGxldGUgaHVnZSBhcHBsaWNhdGlvbiBvbiBhIHN5c3RlbSBiYXNlZCBvbiB0aGlzIHZhcmlhbnQg
b2YgdGhlIGZpeC4NCj4gQW5kIHRoZSBwcm9ibGVtcyBoYXZlIGRpc2FwcGVhcmVkIGhlcmUgYXMg
d2VsbCENCj4NCj4gVGhhbmtzIHRvIGV2ZXJ5b25lIGZvciB0aGUgc3VwcG9ydCBhbmQgZm9yIGZp
bmFsbHkgZml4aW5nIHRoZSBwcm9ibGVtLg0KPg0KDQpHcmVhdCB0byBoZWFyLCB0aGFua3MgZm9y
IHRlc3RpbmchDQoNCk1lYW53aGlsZSwgSSBhbHNvIHB1c2hlZCB0aGlzIGNoYW5nZSB0byBzdGFi
bGUvdjMuMS54Lg0KDQpKYW4NCg0KLS0NClNpZW1lbnMgQUcsIFRlY2hub2xvZ3kNCkNvbXBldGVu
Y2UgQ2VudGVyIEVtYmVkZGVkIExpbnV4DQoNCg==
