Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150087.outbound.protection.outlook.com [40.107.15.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32C133CF
	for <xenomai@lists.linux.dev>; Mon, 26 Sep 2022 14:21:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YIdRegkOx4wLNUjMP6OXFEwL5FFznM8z93rpCzD2m2W4Ngqqp+BBX9Z7zV99eBXO/R+Sbab1I9aBtC6TzZQAOEtD+AfJk6HYsWi8yRPgIN9ivItfrR0xd8AzGLKJBHtRuzkEPbRyFUmfWU4KM6achEbkOjfc4C4e5zfb3yExSAg2Jn2SN4WtvJpg1mg8iqRGc3jKOWJLsSR9REeImT5siLVFEt9tE4AsKwrP9f0xAWGyjBv+5Fs84D1nFM0M9iAtrKMAQRxIFZTsWPodPZCtsOAg2K7jfmycdQkIRMr3S7im2sXkptA3AQY/CDevwWYKHAq4q8G1tbdWJHLD4xqzYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mX8l+VJjwvUAA/KszS7Q5epSLIx/nSZAHYMv3wyXn3k=;
 b=VPryH6YpIvhR/u4SZK8RAvuU6B7R0XtG+s+Sc8+1s54xVPp2RjLZ8c3VMpjdQsJaNjwV0vY3VnQAxOWVIGy91vgVuKg7uL9QtwIPnWwwMMVUF9CWIeI8YdZh47y1pzeRxHlY6pQozXJoeq3HqjXaye5tORFY1QSxSLBbSM7TWw0OugB4XJfEJhcC1M2teUDLC7MU4GAoCZsWrxeszW5cyHwEfuo88IBUafcG47zZL1AdhUqcmqzfwfuJor0klIGUqnSQ8b6Qw69csW4kW0b558kV4LsbLpxSxFNK/FEdX8YO3Hqr2Yn0T+oQuce1R8Xa+WnwvzF/8X6PS3hAvNn+Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mX8l+VJjwvUAA/KszS7Q5epSLIx/nSZAHYMv3wyXn3k=;
 b=fcH1NcSSs26iyxxed1YV8t3XrnR0uz7Q72+6qsbbO4CDro7ERYoE2MHY/0GQC6Bvk6fK9EHusdI1HdmLRNLdXWogY2I3vRe8ZbbrQ/vDMjnaal/mOAGlkm1Wyr4broPqBIITqCurQ0TPaocoVJQaqg+BfYx6j3sbLQo6vIzsEdyNSYWTN6cXnB2561MDPlo/5RY9iI8s3+0w9rB6ajonmRjiR6kehz2keuC1Ba8HZvPXeI4mIB9LFU/YwFwcFFzunc8LhAT7XsysNzUu4PBITkQgGAaQvsSEW5TGUbAnNhGg/u7cJ1Arsx3PjxC7LBaoEETwitR38utDJrnRQxPGmg==
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB9PR10MB5716.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2ef::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 14:21:38 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a52e:3187:b92b:cc8b]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a52e:3187:b92b:cc8b%9]) with mapi id 15.20.5654.024; Mon, 26 Sep 2022
 14:21:38 +0000
From: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
To: "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: [PATCH v2 0/4] Enablement of compat tests in CI
Thread-Topic: [PATCH v2 0/4] Enablement of compat tests in CI
Thread-Index: AQHYzOwFZX1qblzk/kKG4DwG6GLXy63xyjEAgAACiYA=
Date: Mon, 26 Sep 2022 14:21:38 +0000
Message-ID: <da16ff7b5550d7a6fd2bb2aa67f6e194534282d8.camel@siemens.com>
References: <20220920122503.115682-1-florian.bezdeka@siemens.com>
	 <0b37be56-c31f-5603-414c-07e678c6b560@siemens.com>
In-Reply-To: <0b37be56-c31f-5603-414c-07e678c6b560@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB5712:EE_|DB9PR10MB5716:EE_
x-ms-office365-filtering-correlation-id: 3d5b02db-b496-4049-5e86-08da9fca6cb7
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 yRB8Kd4p5azD9ZB7CUBDErXsNYfN2DhM4K/dd3i607TXro3tZh8AG/UDvpPhLwL9Tr8J8znUmdiBb3SDQYZG7zr/xjFJdZWRQTxmOTVtsIpNzhfwkcMEWhjt3VYjtG7DcbBEZOxytta1lfvRdDQgp7Qth0XTDUOpoNOjGmzve4Yq/xU9J8V4XFifd6X1XOxhYPtjXk+jjjaMAkG2hEUqzGr4GP/hPOpqLai3NDPo0ezHOaFfqWcvoCqeZcifr08Pxh0noZieSLV6OapRbSZ17idUIJ8hdLLigLi4IV7qWxQg+P9pobGsgrFTcF/Ac8dM5u6GZcHJEyhwq3QYyBynMXE/4/Efq8FY667Hc2dEZ72VL5wLEcH0Cj4zGDrGs+evBNfe1kKLVSJ4gXX8TbD3jdNz+9E+JU+S/LMmiTbaBrvZ8ko88nfJ6K6GWF1BA8CMbsuwEkzNOxk+a79QQhkJdNDjyUpgUQQxONbPFd4tDYrcDE0ssC3Co0aUHCA77+kN6A1eoSBg8jGRjcDzK/hOfy24//3bS7V04GcVmjfwgv/j4J/hCPORpAFzaRMZDc2wnormzGwaTqOim3LOqB3g+0z0swy6zQHJ0dNv5v3RsG4bGomU+o8PyXFv37YX7LCPclXOnuGc+bKYZkDlwmzc9pmKUFehps2dv1HP+RGi0lTzy54nO3b+q5s+XQiXhJ1B80Z+68jrgBhbGmghNDwGtjAGbEc1aAs1ytOvDrKlz/1sSYI17dEiTudIAS9bO7bfVPmMO3acdQByHTczmj94tlCGiQahGnU5nx7V4qTrsk8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(366004)(136003)(451199015)(71200400001)(83380400001)(110136005)(5660300002)(53546011)(6512007)(8936002)(6506007)(41300700001)(36756003)(91956017)(2906002)(2616005)(316002)(966005)(478600001)(66446008)(6486002)(38070700005)(66946007)(8676002)(64756008)(66476007)(66556008)(76116006)(186003)(122000001)(86362001)(82960400001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ylg0VCtGdzJWZXhoTGJJZ1I4T1hVcVRUWTl5ZWl6SEk3Y1lzeWppSTdaUUlr?=
 =?utf-8?B?VlRUeG0wQW0zL09zcjdRZWRJTjFiV25DL1ZuM3NKVlk2VFFGdWhqYVRIcDBJ?=
 =?utf-8?B?S3poNXhseHp1YWloeTlzVUVDMllqZmsxWmNRZjJ2ZFMrb3FJQUFSaG1ySlBj?=
 =?utf-8?B?NHZZNDRjdjdHWWlkeERtTHh5cy9JbnhSelpPY1RVR1ZvbjU4RlRSK0JONkE5?=
 =?utf-8?B?ZEIxVEk1ZVF5c2F6N1gvOUxQenBRSDJDYm1pMUowVEl5S3puWXFHd05oRURJ?=
 =?utf-8?B?QWxVTVpVcDRMNE5wbnI0Qzc0YWJtaW8xMmpMS1I5QTlMdHFRVGRiUmIxTUs0?=
 =?utf-8?B?SjFPb0xOU2pPcGxIZWlFVTdFQW1QUXVVVHI1ZjQxdXRQMGRFSHF6OThrcWZm?=
 =?utf-8?B?cTNwSE1FTkN6VnZ4bFBXWEM5OGhrRG1HWjIvUzNDVjBwNmZiblA5MVRCbFAv?=
 =?utf-8?B?WndUaEYrM3U1NktVNUN6cks3TUY4RzM2bkEzMktVV1UrakQ3ZFZ2SnMyM1Bv?=
 =?utf-8?B?ZzJiR0xUVUNDM21OOVh1bGlianVVR2NaMDQwY1lNeEt4SWlVRVR1ZDh3SkI0?=
 =?utf-8?B?TzJwZ1Z6bmZ6UWI3c09EV0VxcHVrZ05WVWsxN2p3KzBsM3B6dlJVTytRTHRy?=
 =?utf-8?B?Y244a3EvV3NNQm83WjBlZWNyenVINnltVmhwekREdllsYjcvVmJKNGhVZnJl?=
 =?utf-8?B?TjhIenRkbERaeVlwbkgvaTg0SkNSeVBzTVIrTTI1SnhyZU1UaE5oUTNURGxx?=
 =?utf-8?B?SzRVVEtLMGEwWUZnamNPRlF1dTVWMDB4VjR0VW9DVEp0T1FhRFc3SEQ0WUJo?=
 =?utf-8?B?ZHY2bzBRRE5SWW16cTh4a3dxRUVncmt0d0lBZE9iZnJSOHp2SmtHYXVwNER3?=
 =?utf-8?B?aVlrUElBSVR0NUlQbHBBV0tzZEN6dURyN0JtWUswOXNTSlEvRmlUK2xZUEJm?=
 =?utf-8?B?bU84cGQvZ0JWWWYzL2trNmV5RG5KdndsMTdQalE1bk5FSi9JbkF5UzFFOVo4?=
 =?utf-8?B?VnY3d3Nydm01bkhwMGRiMXU4eUlaUnhwN1ZKR3dUa3pENVFISThsNHp4R1NY?=
 =?utf-8?B?UXpqeHd2N0k3ZUI4Y1BjZXpETVNWaVVkUnNzRStHWlppYzRTSWNXYUoxN1lp?=
 =?utf-8?B?TXQ2SjkvZ3FVVlRlMmVaTmNublZwTzN3UW5mR2paT3hRdTd2a0tleGM1ZUhy?=
 =?utf-8?B?azZEMTVyaUlEdzZTWGNDV3dUdUg1ZXlaU3VBV0x1aVdNelc2T092TCs4MVNi?=
 =?utf-8?B?akUyb3lXcytvelhOVnRwMVUzMFdZU2pMczBkVE0xb0Nud1ptZVBJdURpZ0xD?=
 =?utf-8?B?L1U4ZGI0V080b201NExOeFZyczhuSXdNbjYzYnpGd3lxM2RaSkdQWjk2OG9N?=
 =?utf-8?B?REIzTEFoZ0RoOElFMlJ5QXMwN3l1a3lVMkNDbjAxLzQraHZ5eVBMNGRUVGJa?=
 =?utf-8?B?eGd4QjgzN0J2MGRKdnd1bWhzS0cxL2w5Q1UzRU05TDN6Rmx4RHpCbHpnYWJO?=
 =?utf-8?B?MFNaWm1yd3pGdU43Wm5qVmNueEQvQXdXYVBSSmRRK3R6ZFRIdVQycW1zeG9k?=
 =?utf-8?B?MlVQVEtFY0dVTk1wS01QSmtGWWlUNEhveHFKaU5lMmtRMVNtY3NGeWJ0cDFU?=
 =?utf-8?B?cXdyckJjMWM2RFlrK1hrQkVlSFRMb2JudjUybU1FVFRVV292eURDRENtb0xT?=
 =?utf-8?B?S3lNTjRlZlNlSHJzck1WUVQ3WXQ4cjFvRHJvR0RVSGhZV2llVW44cWVia1JF?=
 =?utf-8?B?K0pPTUcwYVVvTVR2bXUyVzF4Z0c3ZlVMNlZwTGRYL09YVjBEM1o0ZVJmSGhZ?=
 =?utf-8?B?YmRYemNjNVR2UGw1ZmxOelR4Nkx3M2JXUVNGelh4bWh3eFdkQjY5d28vNWNX?=
 =?utf-8?B?NmY1Y2NFSDhxNWIrZ05zV3ZGQ0xRM2FwMk9TS3hGWkxaSCt0MkRuNkMwVG42?=
 =?utf-8?B?QlE5eEt4Mlh5Rm9SL20wN0duY1V6S3RwM2t4RnZHclpDQ0l2OFNUYVJ1YUoz?=
 =?utf-8?B?OWFrQ0Q2YkdDT2UveGpIclRiZUtIV2VTdE96c3Jha29ueHdJMGk4QjlxYWhI?=
 =?utf-8?B?WVp6dG9QUC95eGdTbEM0dElaVUR2ZDNtZjhMZGQ5eEhMZkh0dnc2MEZNaVdB?=
 =?utf-8?B?RnRMVnRTMnN0dVNZRGMyNFVXd0l3ZEw2TEVteksybldjdHVZZFltVjZ2eUx0?=
 =?utf-8?B?bjcybUpjNUFWK2dZTUlOL0JOaEtjb3hFbmVxUkhwMm1IM3ROWGF2ZUhIdEg0?=
 =?utf-8?B?MEQvYUJCMkpIMzRGV3lZZHhUQnlBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7C5ED6886FDB940B68F6A128C27C16F@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d5b02db-b496-4049-5e86-08da9fca6cb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2022 14:21:38.2044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D9kB0YFt0+hesRnJ53rSgT3hM+UN5jBZYu6rvfyVCgwyiZC8cFFWd8RYNnt1+N3nbTASZWGRwaY9eSUFwll+D/ZNPO934i7zdXXYOrvJNU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5716

T24gTW9uLCAyMDIyLTA5LTI2IGF0IDE2OjEyICswMjAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAyMC4wOS4yMiAxNDoyNCwgRmxvcmlhbiBCZXpkZWthIHdyb3RlOg0KPiA+IENoYW5nZXMgaW4g
djI6DQo+ID4gICAtIFJlbW92ZWQgcGF0Y2ggMSAoYWxyZWFkeSBtZXJnZWQpDQo+ID4gICAtIFNw
bGl0dGVkIHBhdGNoIDIgaW50byAyIHBhcnRzIChhZGRyZXNzaW5nIHJldmlldyBjb21tZW50cykN
Cj4gPiAgICAgLSBydGRtIGV4dGVuc2lvbiAobm93IGluIHBhdGNoIDEpDQo+ID4gICAgIC0gY29t
cGF0IHN1cHBvcnQgZm9yIHJ0X2NhbiAocGF0Y2ggMikNCj4gPiAgIC0gQWRkZWQgcGF0Y2ggNCAo
aGVscHMgdG8gc2VwYXJhdGUgQ0kgbG9ncykNCj4gPiANCj4gDQo+IEhvdyBhYm91dCB1c2luZyBw
YXRjaCAxIG9uIG90aGVyIGRyaXZlcnMgdGhhbiB0aG91c2UgeW91IGFkZHJlc3MgaW4NCj4gcGF0
Y2ggMiBhbmQgMz8gTm90IG5lZWRlZD8gT3Igbm90IHBvc3NpYmxlPw0KDQpObyAoZmFpbGluZykg
dGVzdHMgYXZhaWxhYmxlLiBUaGF0J3MgdGhlIG1haW4gcmVhc29uLiBUaGVyZSBtaWdodCBiZQ0K
bW9yZSB0aGF0IGlzIG1pc3NpbmcgcmVnYXJkaW5nIGNvbXBhdCBzdXBwb3J0IGluIHRob3NlIGRy
aXZlcnMuIEFzIHRoaXMNCmlzIG1vcmUgY29tcGF0IHRoYW4geTIwMzggcmVsYXRlZCBJIGRpZG4n
dCBzcGVudCB0byBtdWNoIHRpbWUgb24gdGhhdA0KZm9yIG5vdy4NCg0KSWYgeW91IGxpa2Ugd2Ug
Y291bGQgYWRkIHBvdGVudGlhbCBjb21wYXQgcHJvYmxlbWF0aWMgZHJpdmVycyB0byBzb21lDQpr
aW5kIG9mIHRvZG8gLyBpc3N1ZSBsaXN0Lg0KDQpGbG9yaWFuDQoNCj4gDQo+IEphbg0KPiANCj4g
PiBIaSBhbGwsDQo+ID4gDQo+ID4gdGhpcyBpcyBhIHNwaW4tb2ZmIG91dCBvZiBteSB5MjAzOCBx
dWV1ZS4gVGhpcyBoZWxwcyB0byBzaG9ydGVuIHRoZQ0KPiA+IHkyMDM4IHN0dWZmLiBUaGUgZm9s
bG93aW5nIDMgcGF0Y2hlcyBhcmUgbmVjZXNzYXJ5IGZvciBnZXR0aW5nIHRoZSBzbW9rZXkgDQo+
ID4gdGVzdHN1aXRlIHN1Y2Vzc2Z1bGx5IHJ1bm5pbmcgaW4gY29tcGF0IG1vZGUuDQo+ID4gDQo+
ID4gVGhlIG5lY2Vzc2FyeSBhZGp1c3RtZW50cyB0byB0aGUgQ0kgaW5mcmFzdHJ1Y3R1cmUgKHBh
cnQgb2YgdGhlDQo+ID4geGVub21haS1pbWFnZXMgcHJvamVjdCkgd2lsbCBmb2xsb3cgc29vbi4N
Cj4gPiANCj4gPiBBdCB0aGUgZW5kIHRoZSBmb2xsb3dpbmcgaXNzdWUgd2lsbCBiZSByZXNvbHZl
ZDogDQo+ID4gaHR0cHM6Ly9naXRsYWIuY29tL1hlbm9tYWkveGVub21haS1oYWNrZXItc3BhY2Uv
LS9pc3N1ZXMvMjENCj4gPiANCj4gPiBCZXN0IHJlZ2FyZHMsDQo+ID4gRmxvcmlhbg0KPiA+IA0K
PiA+IA0KPiA+IEZsb3JpYW4gQmV6ZGVrYSAoNCk6DQo+ID4gICBjb2JhbHQvcnRkbS9mZDogQWRk
aW5nIGhlbHBlcnMgZm9yIGhhbmRsaW5nIGNvbXBhdCBhZmZlY3RlZCBkYXRhDQo+ID4gICAgIHN0
cnVjdHVyZXMNCj4gPiAgIGRyaXZlcnMvcnRjYW46IEltcGxlbWVudCBjb21wYXQgc3VwcG9ydCBm
b3IgdGhlIHJ0Y2FuIGRyaXZlcg0KPiA+ICAgZHJpdmVycy9uZXQvc3RhY2svaXB2NC91ZHA6IElt
cGxlbWVudCBjb21wYXQgc3VwcG9ydCBmb3IgdGhlIHVkcA0KPiA+ICAgICBkcml2ZXINCj4gPiAg
IHRlc3RzdWl0ZS9zbW9rZXkveTIwMzg6IFNob3cgc2l6ZW9mKGxvbmcpIGFuZCBzaXplb2YodGlt
ZV90KSBvbg0KPiA+ICAgICBzdGFydHVwDQo+ID4gDQo+ID4gIGluY2x1ZGUvY29iYWx0L2tlcm5l
bC9ydGRtL2ZkLmggICAgICAgICB8ICAxNiArKysrDQo+ID4gIGtlcm5lbC9jb2JhbHQvcnRkbS9k
cnZsaWIuYyAgICAgICAgICAgICB8ICAxNyArLS0tDQo+ID4gIGtlcm5lbC9jb2JhbHQvcnRkbS9m
ZC5jICAgICAgICAgICAgICAgICB8IDEyMiArKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAg
a2VybmVsL2RyaXZlcnMvY2FuL3J0Y2FuX3Jhdy5jICAgICAgICAgIHwgIDQyICsrKystLS0tDQo+
ID4gIGtlcm5lbC9kcml2ZXJzL25ldC9zdGFjay9pcHY0L3VkcC91ZHAuYyB8ICAyOSArKystLS0N
Cj4gPiAgdGVzdHN1aXRlL3Ntb2tleS95MjAzOC9zeXNjYWxsLXRlc3RzLmMgIHwgICAzICsNCj4g
PiAgNiBmaWxlcyBjaGFuZ2VkLCAxNzYgaW5zZXJ0aW9ucygrKSwgNTMgZGVsZXRpb25zKC0pDQo+
ID4gDQo+IA0KDQo=
