Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2048.outbound.protection.outlook.com [40.107.135.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3221877
	for <xenomai@lists.linux.dev>; Wed, 30 Aug 2023 09:41:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WY4oEtrDrivGc6vzU40ecA3lGph5XQY4JC1Ag4TTvtHEdfaQHYjdLbEYipyBSlJbx97O1piB8pJrLEI9vKXbv7Di5ZWxeZRKsV0aR0RmhpjUBMzRCzjrlawfGLU/Hoe3dsC+LjxAFTEFvh/F2uU8zs3Xk85K+a2zyaAnU+FBfPR1zZNkDuXAYoAwnb2W+yiEcUqIdwtZYxb5FfsP4pSnp7Pz8VST+VD6LDpwr55iiw7mlL9VBuIacVe9hBsEdsY/FhjFlwDGtiggPWxVgmC0skGKe8DR/br+xQ0TnaEDB2jizd0CYZ3D1lWSpSe4itBxxuL+4RjA7y0sLobri8ovYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqjvUxMcBHFiXOegpEotZIHu3mCm+aKgPQtyGG2EuTQ=;
 b=IbtvCtWVToMrp9gXh9PuJs7obZQGUQNj47OVGM5mJok3GgUljxpVwy06uJ9ZlgYGs1/ctnjhk+Fp4GxpSKWxwjKkr2sWH/kU2RlFTdTljg0DohPKpqjNBFpKXjih9cQCzhAHzrIhbZ+f4SrWfNW56NgIp1rRryb0nfuxPWFar61klvFZ9fezYJ7tEj9x7DuWZDE6OzPXxF7GZXEYnaDuTbmrueqgMeqhLYGXk+vIzTWCXPOx7lHptlrLLZ8nJf8MFA+kwXz/rVxSkFrGm1e3t+wtwsqr6137GHj1X38HkYnMPgQLHbAkaKTle0Lo0xWbKkkhDHQmlnirB5skpCxk1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zwickroell.com; dmarc=pass action=none
 header.from=zwickroell.com; dkim=pass header.d=zwickroell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=zwickroell.onmicrosoft.com; s=selector2-zwickroell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqjvUxMcBHFiXOegpEotZIHu3mCm+aKgPQtyGG2EuTQ=;
 b=LgnwNtttnZcIFyVXegpVXoAxtnMQwGj8ajSLaOsb4Aj3IYTiOZYEF0UIaZwjIA1dfRCvUSwlWgQ6gtZlipgw8UP+nR91KeFo5oJET4Lyw1JPiSxt0H89UtXdErfVZpaVeJzZajAY5TrhkgKsMrQw5E8XBNRZDyOmowCeC58rbow=
Received: from FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:63::8) by
 FR0P281MB2667.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:56::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.20; Wed, 30 Aug 2023 09:41:24 +0000
Received: from FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM
 ([fe80::4fe7:13ed:cf9:4b55]) by FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM
 ([fe80::4fe7:13ed:cf9:4b55%5]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 09:41:24 +0000
From: "Heber, Stefan" <Stefan.Heber@zwickroell.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: RE: Sporadic segfault upon start of Linux app while Xenomai app is
 running
Thread-Topic: Sporadic segfault upon start of Linux app while Xenomai app is
 running
Thread-Index: AdnZs7a186+M2Cb0QdeyFj+3f/PI2gAGQiWAAFV5PNA=
Date: Wed, 30 Aug 2023 09:41:24 +0000
Message-ID:
 <FR2P281MB26546E4A8786BBB886160D45FCE6A@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
References:
 <FR2P281MB2654953C4123B74DB77CDC51FCE0A@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
 <906ca7ee-c870-4466-b495-3f5ba2c81d0b@siemens.com>
In-Reply-To: <906ca7ee-c870-4466-b495-3f5ba2c81d0b@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zwickroell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2P281MB2654:EE_|FR0P281MB2667:EE_
x-ms-office365-filtering-correlation-id: 1681dfa2-4381-4158-f99c-08dba93d46a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 21aHp/+o/98thef1f8ZOjV4lUydRiVHwpMv3Pr1Zt9k0JJQifGa44I+WZ4TI8WT+UA4H1F0rIVUXBwaW/JVSbqIaozatZMqGCkAi2V9SxLC0BRYFSuowOakvEn2fa98WmVZtH/eCv3zHxnFuX0rADMSljUKLkKlXrvqfVcr32IdXkvF/PJFU0Br1UpBIio01oHwf0uIZ2QJaNegj8p4g2bUCMuz+9B+OUV+P4084QwSyjkRREncILkiTnldvWgoDEzRVIzUDCj4dke0jO7k2F3vYz18rtNSIWzXeE6KtCfElctirbvlsOyjtyym2znCraLvmvhVmeM0M6Y4I9J6rijhFIZghdVXbC8B0WJEbGC4VBVto23u/MZrSC4i2STWu/92xS3Eqc9spyODhyB9XS6udCGVuqP+nn1u614m0VsS4tg3nVHiGr/pw+f2Flu03SMUN54xQxOIAEVT6wbQWvma+31sEre7RxTvh2oEWcHZJXghlgOgno3Ij7btYnJJLb0YVNTOdlf52NUrDNx4pv3shSzOJxEevfypkOIJNua3v4Y+dw//JZErDsIXmRkt1ri7+K8T+Of/N2lr1bWCeTSy13kCGhZjC0Q6Zeo9iWKdjjNtERDAYLDZit9KKzJRj16rs7JeXFhEMGLP/w2G2LkCSxjFqDSM8mYvM1vbAXBM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(376002)(366004)(1800799009)(186009)(451199024)(2906002)(5660300002)(33656002)(86362001)(122000001)(38070700005)(38100700002)(52536014)(55016003)(8676002)(41300700001)(8936002)(83380400001)(66556008)(316002)(26005)(9686003)(53546011)(7696005)(6506007)(66446008)(71200400001)(478600001)(66476007)(64756008)(110136005)(66946007)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VkpDT29WdDFoS2Uycmx5SEVMellUZTRkTisyNEF1bStoRnR6OHZsMHpCSWc3?=
 =?utf-8?B?bnBDNzhWRlluN09jeTVlMFdLeGttSit2Z20rWTZyRVJDcFloYUhDQTF2NHI5?=
 =?utf-8?B?My9lZGZYVWI2MG9QRzYwUk5jR0psUFNTSUtjQUpSd2dSTzNuTXg1RlZuUlFm?=
 =?utf-8?B?bVFCVS9zUGE1WXFqMnJzdUNrazk0Z1NTcVlEZDhxajNlN1ZLektDUkwvbTZ2?=
 =?utf-8?B?d1hLd0JVa29Sd2JUMEgxOXdaMXR5YXpvYUEyZldoVjI1UzUxOEdSWWNVZ0x5?=
 =?utf-8?B?bFVCYW9qZVo5QmtET0pQd3pkRVpCMzNUcjdPYzhjbm5yYWlWZ1JneE91Q1Zs?=
 =?utf-8?B?N0o1T0JpWVpNU0VGaUpuYTNzY2E5Q2VEZWtaVmRQZ2tSMFk4d3ZxbURFNkNC?=
 =?utf-8?B?Z01sMDEvYlB4TXlZUEd4NElOZmsxK2R5aDBLQTN0eXc4WGlLRk9QdjNGdjZX?=
 =?utf-8?B?SlNzMGtJOWg2bWZCZGtRcEZXdDhkam1XRHcrNUtNSHc5aXhJQlBCOEpvd2pK?=
 =?utf-8?B?aU80ZjBzVUU2TkFlQWoyMWt4WkM1Wk1GQlZOTm9yMFhQeXlZR2JJS0FrdG9O?=
 =?utf-8?B?RUJSOUpaa0k4cXU0TDR4SGo3ciszS3ZuM3lPcE12Z1ZQNkhNL2NjSU1ST1ll?=
 =?utf-8?B?dDZLcjdmaXZaR1Vhb1Fib3BjL2l0WWRkK1RIaUU5SFpiSitXTldkNmJOKyt1?=
 =?utf-8?B?VTBwS2NqZVdIcE1VK09kZngvaHhMQzg2UUtjZlhPbGRYbWRIUGw1Vkp3dVN0?=
 =?utf-8?B?VGovaUdwdDMvMitYQ3F3RmlramdZNEY0aWxTNTNiRTQ0RTdtTlQ3ZlZTa3c3?=
 =?utf-8?B?NzhRM3NPYVlER1VDbzhzbkF1b3dtZ25KLzZ0VFNtRnN0V1BRNllrQVFhQnQw?=
 =?utf-8?B?MlVOYWhSVmlnZjcyVWgyejR2VkxpWmJOWE5jSGFpVmowcXh3RmRCS1NqL1VD?=
 =?utf-8?B?MmlRVjd2LzlSU2hxWjRzK21lSFFDdG84UzlCTlZ3L0pVTkhDUFRNNlRicVJM?=
 =?utf-8?B?a0tXNTVEanFBMkhtV2w5OXI1OXRDNzg3UGZidlF5bXBndFpEMW5UbUJQUWV1?=
 =?utf-8?B?aGFCczUrOTh2S3RqYm5WNDdVVVZqY3RxRzExS1NKV3d3aTk5TUVVMCtUcHRn?=
 =?utf-8?B?U0RNY1YvNGpxYXJEZm85Q3JrNk5SWXc0aGlGNUgvZ1ZJMVp1U3licVZFcUIr?=
 =?utf-8?B?QWVIS29aK3I3WEl4ZmFuYjJKb2ZybTE2NWJYWWZCVlYxNGUrVnY1RmdUeEw5?=
 =?utf-8?B?b0NZMmVVQ1Z2MW13cGRyU2VmNHZzS1FuOUd6THFkcGp6OHBqYUxiTDlxdkdn?=
 =?utf-8?B?UGgxOFZxblkxWmRNcVJSbjFJV3pqQllrWlZLRTg3RmJoekxjVmVaR2NZRDZw?=
 =?utf-8?B?NE8xeG1PMFJUSE1jbTk5aWVYS0tjZDlxRlhCQ0RoRzArOXR0akdaMTJYVG9B?=
 =?utf-8?B?cHhyQTY0Tm01MkRzaXBDMFozV0xNUURLaENhMi9JREEwTFZjM0taaFJDZi9X?=
 =?utf-8?B?VmI2aVZ3VFNmK1FWQjV6dklJUXd0aFdvakVCcFJDak04WjcrS3FtdS9mUWJy?=
 =?utf-8?B?b2dDLzhCMmh3anJyVU1LSExrOVB2MkY3dFhSb0lDbkk3dm9mbllFZldKd1Np?=
 =?utf-8?B?bW11QTJwQ24zNGxKM3FReFpKMmFUUEtTbzJUYTg1QkIxRGJkUFQ2dTRjdkFl?=
 =?utf-8?B?aklIL1V1b01lZVVrOXR6dGhvN2EwNTRSZ1NGR2RJOTh3cnZrSXpUcVFDdlhV?=
 =?utf-8?B?VmNSWWI1UFNIaTNWSjJQSFE4TFRpK1VIMjBmQ2xRMVdQa1o3UHZaSlBDSUdN?=
 =?utf-8?B?dzNreUoyYThQcER3VW13dmVrTVkwWnp0dFJXdndqVG9JTFFSS1lKVzhBcktU?=
 =?utf-8?B?Q3VHZjhOTWZoczRnalZEWG5EdUh3S1J1OWhybmJBampGaGRIV3VXTDV4c0hJ?=
 =?utf-8?B?dlhEcnk3S3FlWVVMaG9tbUV1WmtnWklSTDBBakxXNE9qTk5EWDZsM3hIMEd5?=
 =?utf-8?B?Y2JPNmVKdzdGbjlkNkoxSnJlWm5mYUJqUzdzZktjRjUvTC9YT3lXbER4alRu?=
 =?utf-8?B?bnprS2VWTU43QXdJSVZyMnRnT2Fxcnh2VjVaNmgxVXNvMnlIaTRZNWRaay9K?=
 =?utf-8?Q?vfp0YIeEjrQtrVkuDMt0Z/NiP?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1681dfa2-4381-4158-f99c-08dba93d46a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2023 09:41:24.5857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 538edf66-8fb7-4bad-8608-a521ab580ca0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ASiDwcqsyFOLEIk3TJ4jEdHwTMTUpB8eR/MpBIBArn/6ylVVF0Fhmjl+b5iMPAm1D2ECs1vRchuv51PY1MG3RWnHGYk27ZhFyJQ/GyMsrTY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB2667

SGVsbG8gSmFuLA0KDQp3ZSBzZWUgdGhhdCB0aGUgc3RhbmRhcmQgYXBwbGljYXRpb24gYWx3YXlz
IHNlZW1zIHRvIGNyYXNoIHZlcnkgc29vbiwNCmF0IGxlYXN0IG1haW4oKSBkb2VzIG5vdCAoeWV0
PykgYXBwZWFyIGluIGJhY2t0cmFjZS4gV2UgaGF2ZSBvbmx5IDIgZnJhbWVzDQppbiB0aGUgYmFj
a3RyYWNlIHdpdGhvdXQgYW55IGRlYnVnIGluZm8sIG5vdCBldmVuIGZ1bmN0aW9uIG5hbWVzLg0K
V2UgZG9uJ3Qga25vdyBpZiB0aGlzIHByb2JsZW0gb2NjdXJzIHdpdGggc3RhbmRhcmQgeDg2IGlt
YWdlIGJlY2F1c2Ugd2UNCmRvbid0IHVzZSB4ZW5vbWFpIGluIHFlbXUgaW1hZ2VzLiBXZSBkb24n
dCB0aGluayBpdCBoYXMgYW55dGhpbmcgdG8gZG8NCndpdGggdGhlIGtlcm5lbCBjb25maWcuDQpB
cyB5b3Ugd2lsbCBwcm9iYWJseSBhbnl3YXkgaGF2ZSBhIHN0YW5kYXJkIGltYWdlIHJ1bm5pbmcg
aXQgd2lsbCBiZQ0KZWFzeSB0byBmaW5kIG91dCB3aGV0aGVyIGl0IGlzIHJlcHJvZHVjaWJsZSwg
d2l0aCBvdXIgc2NyaXB0IHlvdSB3aWxsLCANCmlmIHJlcHJvZHVjaWJsZSwgc2VlIHNlZ2ZhdWx0
cyB3aXRoaW4gc2Vjb25kcy4NCg0KU3RlZmFuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQpGcm9tOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPiANClNlbnQ6IE1vbmRh
eSwgQXVndXN0IDI4LCAyMDIzIDY6MjkgUE0NClRvOiBIZWJlciwgU3RlZmFuIDxTdGVmYW4uSGVi
ZXJAendpY2tyb2VsbC5jb20+OyB4ZW5vbWFpQGxpc3RzLmxpbnV4LmRldg0KU3ViamVjdDogUmU6
IFNwb3JhZGljIHNlZ2ZhdWx0IHVwb24gc3RhcnQgb2YgTGludXggYXBwIHdoaWxlIFhlbm9tYWkg
YXBwIGlzIHJ1bm5pbmcNCg0KT24gMjguMDguMjMgMTU6NDAsIEhlYmVyLCBTdGVmYW4gd3JvdGU6
DQo+IERlYXIgbGlzdCwNCj4NCj4gd2UgYWdhaW4gaGF2ZSBzb21lIHRyb3VibGUgd2l0aCB4ZW5v
bWFpICh4NjQgLyAzLjIuMyAvIGlwaXBlIC8NCj4gbGludXggNS40LjEwNSk6IElmIHdlIHN0YXJ0
IGEgc2ltcGxlIG5vbi14ZW5vbWFpIHByb2dyYW0gd2hpbGUgYSB4ZW5vbWFpDQo+IHByb2dyYW0g
cnVubmluZyBhIHRocmVhZCBpbiBTQ0hFRF9GSUZPIChpbiBvdXIgY2FzZSBwcmlvIDk5KSBhbmQg
Z2V0dGluZw0KPiBzY2hlZHVsZWQgZnJlcXVlbnRseSwgd2Ugc29tZXRpbWVzIChpbiBvdXIgY2Fz
ZSB3aXRoIGEgcHJvYmFiaWxpdHkgb2YNCj4gMC4yJSkgZXhwZXJpZW5jZSBhIHNlZ2ZhdWx0IHVw
b24gc3RhcnQgb2YgdGhlIHNpbXBsZSBwcm9ncmFtLg0KPg0KPiBXZSByZWR1Y2VkIHRoaXMgY2Fz
ZSB0byBhIHZlcnkgc2ltcGxlIHhlbm9tYWkgYXBwIHRoYXQgZW5kbGVzc2x5IHJ1bnMgYQ0KPiBs
b29wIHdpdGggb25seSBuYW5vc2xlZXAgYW5kIGEgc2ltcGxlICJoZWxsbyB3b3JsZCIgbm9uLXhl
bm9tYWkgYXBwLiBUaGUNCj4gc291cmNlcyBvZiBib3RoIHlvdSBjYW4gZmluZCBhdHRhY2hlZCB0
byB0aGlzIGVtYWlsLCB0b2dldGhlciB3aXRoIGENCj4gTWFrZWZpbGUgYW5kIGEgYmFzaCBzY3Jp
cHQgdGhhdCBzdGFydHMgaGVsbG93b3JsZCAxMDAwMDAwIHRpbWVzIGFuZA0KPiBjb3VudHMgZXJy
b3JzLiBBZGRpdGlvbmFsbHkgeW91IGNhbiBmaW5kIHRoZSBjb25maWcgb2Ygb3VyIHhlbm9tYWkg
YnVpbGQNCj4gdGhlcmUuDQo+DQo+IFdlIGFsc28gZXhwZXJpbWVudGVkIHdpdGggeGVub21haSB2
ZXJzaW9ucyBhIGJpdDoNCj4gLSB4ZW5vbWFpIDMuMi4zIGlwaXBlIHdpdGggbGludXggNS40LjEw
NSBzaG93cyB0aGUgcHJvYmxlbQ0KPiAtIHhlbm9tYWkgMy4yLjIgaXBpcGUgd2l0aCBsaW51eCA1
LjQuMTA1IHNob3dzIHRoZSBwcm9ibGVtDQo+ICAgPT4gaXQgaXNuJ3QgYSBzaWRlIGVmZmVjdCBv
ZiB0aGUgcGF0Y2ggeW91IGRldmVsb3BlZCBmb3IgdXMgYSB3aGlsZSBhZ28NCj4gICBhbmQgdGhh
dCBpcyBpbmNsdWRlZCBpbiAzLjIuMw0KPiAtIHhlbm9tYWkgMy4yLjMgZG92ZXRhaWwgd2l0aCBs
aW51eCA1LjEwLjEyNyBpcyBjbGVhbi4NCj4NCj4gQ291bGQgeW91IHBsZWFzZSBoYXZlIGEgbG9v
ayBpbnRvIHRoYXQ/DQo+DQoNCklzIHRoaXMgcmVwcm9kdWNpYmxlIHdpdGggYSBzdGFuZGFyZCB4
ODYgaW1hZ2UsIG1heWJlIGV2ZW4gcWVtdSwgd2hpY2gNCndlIGdlbmVyYXRlIGZyb20geGVub21h
aS1pbWFnZXM/IE9yIGRvZXMgaXQgbmVlZCBzcGVjaWZpYyBrZXJuZWwgY29uZmlnDQpzZXR0aW5n
cz8NCg0KRGlkIHlvdSBhbHJlYWR5IHRyeSB0byBmaW5kIG91dCBtb3JlIGFib3V0IHRoZSBjcmFz
aCBvZiB0aGF0IHN0YW5kYXJkDQphcHBsaWNhdGlvbj8gRG9lcyBpdCBhbHdheXMgZmFpbCBvdmVy
IHRoZSBzYW1lIGluc3RydWN0aW9uIG9yIHNhbWUgdHlwZQ0Kb2Ygb3BlcmF0aW9uPw0KDQpKYW4N
Cg0KLS0NClNpZW1lbnMgQUcsIFRlY2hub2xvZ3kNCkxpbnV4IEV4cGVydCBDZW50ZXINCg0K
