Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2044.outbound.protection.outlook.com [40.107.247.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BA07488
	for <xenomai@lists.linux.dev>; Thu,  3 Nov 2022 15:39:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRD6jD/xXLZFL7BQXsmNtO/OR42xvj0lANiMfVYr6RS1LBlVhhwUsunRiZ6Mrxcj8F/MhLyhSCbVyRsHFYqS5110wWPLH81s7nT9Eo4ZKgdwK0boAoLZQa4TUq3nv2mHvUFwwYRFtKqJWAkQbhove2QfgHDiaJjmiSKhy0c7A9WyH0J+5k5HD8Avl2xTnOpGaWL4F7A+WdQTF5uBPV6fz5we6XiUEGZXewOVfCYHq6uBfPihot9fVyUTYGxEuHhLuEei9rxN68fQfWswzo7crGad+spihs5INX5L/ZqeS+fu2tJP0mijJaLmI6bpm6p/MK65JnusoI/uM3c1+zCuCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65fv/XQVLE1rsGwtSohpYX9j73QeoVJ3/4OrL34sjsk=;
 b=BfDzTyqikjToqetoycVR9aNaPpfIWv8A3UYeprYUrIVbgsNbb11yGDnBuCHB/OJNxhWaqVm9tBxRc/sJyl8ul9NILkG4gLjpYPm9rKJ+qFigPkd02LXwtJe5mTP8XNIOEoZH+HuPs1OLK7J4uRMjrggS8TeoI52j3ZDfVaP+2KEXrBjidvXRX+2t+cSV7RN9hOQ7fCYjCizmGupM5CW2cjkLPwhiZMy6DWNvUoOxZwYCd/Pj49JOUuXs1Ac0+kSoAW+MLnkK1NMoz/wonVt/iYFBK9tjy0nNZWU9K55N5IUwKFhVjdx+HooERhDQwDSfcNBWJg/sJxR1RUZjaArh8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65fv/XQVLE1rsGwtSohpYX9j73QeoVJ3/4OrL34sjsk=;
 b=oIAH/90TTrXHvDPQr73XtWZOrt60O11ucX1LzA9MneFL5DeXyJkqMdg9QgB9GyHuvKsXRQ9bP8gU8CQFbDX0hBKjce1Fqrmw8VGq4uIChNqvf6z9thcE4nldup88E9XYcr6JFJeCGwd/VR6iBaZha/93oB1T8b/t1VzN2aJPptusdB4DAt1Cs9xhEJwKQufe2f4lo0p/sNBhYIGtkerEgSvF3GGP4d8VOOnQVyCTy/BZDoUFnGL0z6PYg5x7XI/b8qeRvM2JAZw8naiVM9jl1QM6emRwBz2fUJm7nFHm7rs/0aYErTqOHmjK4kptyQHBpHaB3Awi1s4eH/qRk8BosQ==
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB8PR10MB3941.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:162::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 3 Nov
 2022 15:39:16 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::18f5:54d5:ca97:5a8d]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::18f5:54d5:ca97:5a8d%9]) with mapi id 15.20.5769.021; Thu, 3 Nov 2022
 15:39:16 +0000
From: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
To: "rpm@xenomai.org" <rpm@xenomai.org>, "greg@embeddedgreg.com"
	<greg@embeddedgreg.com>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: Several problems with ipipe on arm64
Thread-Topic: Several problems with ipipe on arm64
Thread-Index: AQHY75puopA4mElsVUqD1E4xe55OnA==
Date: Thu, 3 Nov 2022 15:39:16 +0000
Message-ID: <8721e84b34268e33f2e5d3c6781a8af3769de816.camel@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB5712:EE_|DB8PR10MB3941:EE_
x-ms-office365-filtering-correlation-id: cf3b31a2-c1ac-4ea0-8002-08dabdb190d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 +bJ5eyx7tGYc0KIG+13O77KS06254U7dWeqFzxf89ixkPD+/YGexZq4q+J5jdzArj3J/aCyhe3Z1m7QjrhQaQFKPTzeXsrc/ypCO8r7JRdXK6feh73uBD8nvdo1wuZxkVQMuwCTMLaFK1urRL2OeMmIPkyiMWVsnf3tN/OtogxukleS6jx269t2OOktgnQkci9jHbun3qKMLHtMjPK/ICPYCXs3z2P6S9dptDhnaSCGZ7NAv+MRSao82Xno2oEBkQbCxtUCXvCgX7WgWr5bCrql6pqXfwHcVACzMQ41Gghx/j5YPYH7y2IwUqtIbTqWrUCSZSbqEnujR1iM6K9irhEKgGjVcjOml202S1jTU+2IslhnaYWxdS70uQ+crbne/0rq/dUzjwaNnTmccQsUKn7P/+s3nVnwU4AeHjP+69mA+vsJvWrU0PClhjnAX3deU6zpkd1VfOmKUYwkVsmPWmA5Ig1McVkkCtP/XTWC3gnm3WdTjLdRqzZIDTHw+PUCFxOm8TLGNSysqGT9DSRWp8H0HIUHPK9rW1g1v8IIoF3tvOobs4ihfCJOS75MfFAoIZQ0/SwsulJlN6rq05DlKo3u8BtMUzj9vw6RDgwLtdFrRgHfKlnxetVAp3qB1NdMzc+VAc8tVo8butKaYp0vbVbnd+NDZGRpnFKLk4xgZSmLBdM2jIM4CTY7aSkhYz7+sRCduOX4BDN+ChW/w8ybPNcFf/n7ebje7GNqxJm2zISopgiMUTIbbo/5vkBRXnIdhYleK5viKuOsk4/cgGrvfpJgSSzeBBG2QQgTM82T/q98=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(451199015)(83380400001)(64756008)(86362001)(122000001)(38100700002)(82960400001)(5660300002)(2906002)(66476007)(8676002)(66556008)(8936002)(41300700001)(66446008)(6506007)(66946007)(186003)(6512007)(110136005)(71200400001)(316002)(54906003)(478600001)(91956017)(76116006)(38070700005)(966005)(4326008)(6486002)(36756003)(2616005)(66899015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ajhPRkFQcWlFVlAzbDZ1ck5wUzhsQjIzZ2d2UXp1LzN6MzB6bWg3c0F1RDdn?=
 =?utf-8?B?Q1pRL1VDY3dDNzIzbVl1NDZNWUxRR05jc3U1Ni9oaU10NFlXMHJad21ZTXU0?=
 =?utf-8?B?TlFJL1ZkeDdrZ281SXYwUjExdzZjQ1BLa1o4ZmFrTnMyYWFjWUkzL0xrWml6?=
 =?utf-8?B?VjBMSXQ2alV1eWpDQ2k3OTNlNDBFRUN6Skk0bEJWenBwUE9hNmhCUDlIYTRr?=
 =?utf-8?B?dnoyY2RSQU9iRnB0dFhuUVFZYmYrU2tJSFdidEwwd2R5MEFacmRSVytHKzdh?=
 =?utf-8?B?dUU4Q1h1aUUvNzZFalZ5bTUrTUh4VEtEeDVwTzhUbldDVTdiTkx4SW94L2NL?=
 =?utf-8?B?aXB0Q1ZSdERtSEM5NzJWR1ZkclZsQnRsWS81WG5icVpveTJnVG82QU0zYWlH?=
 =?utf-8?B?V3Q4ak1NbGJKb010L3k2blRVeHhuMVRaSTdsZlZqVStKMnFVYmhUOGdsL2ZP?=
 =?utf-8?B?VHFGUU02RzFwSTB4SFdOdEdjckhyL1RTV2NyUVpjak14TktYajN2RXp3RXdE?=
 =?utf-8?B?MUhMKzJlakhVMzZQTXMvT1h4RzdtUTI1dkVTamZ0cTZXSzBQYkdvUnB4SFV4?=
 =?utf-8?B?aHNDLy9MMlRJRUxoVzVFbG9GYWhSNEFhMmhhckJVdVVQMUlaeTliOVRybkln?=
 =?utf-8?B?eE95WkdpNW5kcFhSMDJGR2hsRkw3enFjaXd2c1hXalZPbTZhRTRCV2ZVL3Ev?=
 =?utf-8?B?dnN0VitKQ0dWeHhJcU1ySnRibkhDcktoMnBMd2hYK21pQzRLSHNEaUkyTmFM?=
 =?utf-8?B?VnRqemdveS82QTc3ZEtjck83eVFhRG4wVGxMckZhUHVGcUt5ZXE1OUIrREtH?=
 =?utf-8?B?U1pXOXFtQ3Q1ZTh5RUtSL3cvQkZOdnhTUXlIRnpSaEVnUG8wL0lXVUw4ci8z?=
 =?utf-8?B?bXk2bVR5emxvY1RSMy8zRUl1OVN4RklLeFlVLzlJMjMvTWE2R0phd0tibWFt?=
 =?utf-8?B?QnBpYWU1VWN3ZTM5UktTSks2TUVMZ1pDMkFIV2puWlVRbE45R0p5WGlWK1Br?=
 =?utf-8?B?UkhBVTZFSDdMSko3WHpHcGVRUzNxenY2eENYVFZ2b2VXRDVwc0NneGQ3YVZs?=
 =?utf-8?B?TjR5dnMyOWFRdnlnRVpjd0ZjL1ZaTUJHQXVJdklOT1VPOCtYcUpLZmVSaDNa?=
 =?utf-8?B?czE1dXIyUFUwc2lyMm50WHVWSllhRVgyUEZPMEFSMEtkV1hEVGVxMFdGQTZ6?=
 =?utf-8?B?V0svbkdIdlhzcnphVm01MWtJd2FZNHJodkUrcjAwR1BTQ0JMR29GQmxiN0Ew?=
 =?utf-8?B?Qk9veVJMVFpQaDE4NTBlRUtlRDdHSzcrQTRwd05sVXk2S2poaXZjZlhiUldk?=
 =?utf-8?B?bTRSQVpBcmxQVzNsQ1BXZFN1MjVZQkdjaGFxV3MvSFhrcGo4SlhEZHR4NnUv?=
 =?utf-8?B?RjJNaE8yQ2l1L04yaG82cGJDNVN6OUg3VWh4K2laMG1sM2toQWhiNjJ1VXgw?=
 =?utf-8?B?YnhtdUMvY29lTzhDc2NyTEh0QUpYVnk3N2dxNjkwSk1aNFhueWF1cDhiRE9H?=
 =?utf-8?B?TUpQZyt1WjF1bE5ENW1NWW9XdGx6ZkRMZXNZRnJKTE9MQ2JBZW9VWW5XNGY3?=
 =?utf-8?B?RStGbFV2ajBLdFZYdm1lN3U5cHFlMzVRTEczVGlrRnVFeFF1enFWK1NsTiti?=
 =?utf-8?B?REZ0cGdNQ2xPWnRWelVSQnRHaVhyell6Vlp4dzIxNjUxalUxUVZWbWk4aXlN?=
 =?utf-8?B?YStVUGlhMFF5ckJkSGEzdVZtMlgvVVU4YVZ0b0w5c1JkWkh3WlozcWRGKzFE?=
 =?utf-8?B?QTR2WXJjMTNXQ0o5cGloZlcyUG5iQTlzMWlUc29XUnV6eGY5RXRocjNSdWth?=
 =?utf-8?B?N2xNVUF2bmlodE1JaG5RaEs1dGhxcFlaRG9BOXZHNGwrTXFoTzAyZWhNckll?=
 =?utf-8?B?UFNJa3MvUGUwdDNqdVhoclpKTHVMeVB6eGZsU0NzQ0V3Yjl1clg0Vm1IcTRw?=
 =?utf-8?B?UmdtSEllNXZhdGRMNjcrcHRmMmRvOW5hUWF4UFVTVWw0NEVhUUVuUnROSTdm?=
 =?utf-8?B?aVRIVzZvbUM1UERhQ2orUUNVWWs1V2RkVkJaVzg3S3dJeHJ6MExOK0Nka25W?=
 =?utf-8?B?SXpLaUNmanQzZy9xN2NlaFAwaFBYa3RtdGZ0dldhc0ZKS1lPN2FYdHFLWUJn?=
 =?utf-8?B?eUs3anUrQnhCcnBBRHltdHBuR2VnSVYrZ1p6TnBNM2JoOS9GclVPV3hqTUZH?=
 =?utf-8?B?TCtaV3JSOFN5THQzb09UVTJoWUIzbWJYNVl5bGRXVU1CS2VnVG1mOVdjWEFC?=
 =?utf-8?B?R0d2Q2FmVWJSMHpnOEdBWVpsL0xnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9787ADE4DD830A478119CC9805BFA50E@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3b31a2-c1ac-4ea0-8002-08dabdb190d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 15:39:16.2781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sGk14GyQH6DTQBaZnjzV0iu8wf62EFtT2T+UKoX0xWfUb/2nzP1iZETBO0Tj3liJLGrU6ZfRLEb+oFNZO8VLt5UhDCY2lPT+suPnaWtjVHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3941

SGkgYWxsLA0KDQp0aGlzIGlzIGEgc21hbGwgc3VtbWFyeSBvZiBteSByZWNlbnQgaXBpcGUgb24g
YXJtNjQgZGVidWcgc2Vzc2lvbiwNCm1heWJlIHNvbWVvbmUgaXMgYWJsZSB0byBhbnN3ZXIgc29t
ZSBvZiBteSBxdWVzdGlvbnMuDQoNCg0KRmlyc3Q6IERpZmZlcmVuY2UgYmV0d2VlbiBpcGlwZSA0
LjE5IGFuZCA1LjQ6DQppcGlwZV9wcmVwYXJlX3BhbmljKCkgaW4ga2VybmVsL2lwaXBlL2NvcmUu
YyBkb2VzIG5vdCBjYWxsDQppcGlwZV9jb250ZXh0X2NoZWNrX29mZigpIGluIDUuNCBbMV0gYnV0
IGRvZXMgaW4gNC4xOSBbMl0uDQoNCklzIHRoZXJlIGFueSBkaWZmZXJlbmNlIGJldHdlZW4gNC4x
OSBhbmQgNS40IHNvIHRoYXQgY2FsbGluZw0KaXBpcGVfY29udGV4dF9jaGVja19vZmYoKSBpcyBu
byBsb25nZXIgbmVjZXNzYXJ5LCBvciBpcyB0aGF0IGEgYnVnPw0KDQoNClNlY29uZDogSVJRIHN0
YWNrIG92ZXJmbG93IG9uIEhpa2V5IGJvYXJkOg0KSSBub3RpY2VkIHRoYXQgd2UgY2FsbCBwcl9l
cnIoKSwgV0FSTigpLCBXQVJOX09OQ0UoKSBhdCBzZXZlcmFsIHBsYWNlcw0KaW5zaWRlIHRoZSBI
VyBJUlEgb2ZmIGVudHJ5IHBhdGhzLiBUaGUgdW5kZXJseWluZyBwcmludGsoKSB3aWxsIGNhbGwN
CmlwaXBlX3Vuc3RhbGxfcm9vdCgpIGF0IHNvbWUgcG9pbnQgc28gSFcgSVJRcyB3aWxsIGJlICpP
TiogYWZ0ZXJ3YXJkcy4NCkFzIHNvbWUgcHJpbnRrKCkgY2FsbHMgaGFwcGVuIGJlZm9yZSB0aGUg
SVJRIEFDSyB3ZSBjYW4gZWFzaWx5IGVuZCB1cA0KaW4gSVJRIHJlY3Vyc2lvbi9uZXN0aW5nLCBl
c3BlY2lhbGx5IGZvciBsZXZlbCB0cmlnZ2VyZWQgSVJRcy4gSG93IGlzDQp0aGF0IHN1cHBvc2Vk
IHRvIHdvcms/DQoNCkkgaGF2ZSBjb21tZW50ZWQgb3V0IHN1Y2ggZXJyb3IgcmVwb3J0aW5nIHN0
dWZmIGZvciBub3cuIE5vIElSUSBzdGFjaw0Kb3ZlcmZsb3cgc2VlbiBhbnltb3JlLg0KDQoNClRo
aXJkOiBBZGRpbmcgbWF4Y3B1cz0xIHRvIHRoZSBrZXJuZWwgY21kbGluZSBicmVha3MgYWxsIG9m
IG91ciBDSQ0KdGVzdHMsIHNvIHNvbWV0aGluZyBzZXJpb3VzIGlzIHdyb25nIHdpdGggaXBpcGUu
IEF0IGxlYXN0IDQuMTkgYW5kIDUuNA0KYXJlIGFmZmVjdGVkLg0KDQoNCkxhc3Q6IFRoZSBIaWtl
eSBib2FyZCBpbiBvdXIgbGFiIGJvb3RzIHVwIHVudGlsIHRoZSBmaXJzdCBVQVJUIGhhbmd1cA0K
b2NjdXJzLiBUaGF0IHNlZW1zIHRvIGhhcHBlbiB3aGVuIHN5c3RlbWQgaXMgdHJ5aW5nIHRvIHNw
YXduIGdldHR5IGZvcg0KdGhlIHNlcmlhbCBwb3J0LiBJJ20gcXVpdGUgc3VyZSB3ZSBoYXZlIGEg
cHJvYmxlbSB3aGVuIG9uZSBDUFUgaXMNCmhhbmRsaW5nwqBpcnFfZnJlZSgpL2lycV9zaHV0ZG93
biBhbmQgdGhlcmUgaXMgc3RpbGwgb25lIElSUSBpbiBmbGlnaHQNCm9uIGFub3RoZXIgQ1BVIChv
ciB0aGUgSVJRIGlzIHN0aWxsIHBlbmRpbmcvd2FpdGluZyBpbnNpZGUgdGhlIElSUSBsb2cNCmR1
ZSB0byBhIHN0YWxsZWQgcm9vdCBzdGFnZSkuDQoNCkkgaGF2ZSBubyBwaHlzaWNhbCBhY2Nlc3Mg
dG8gdGhpcyBib2FyZCBhbmQga2dkYiBpc24ndCB3b3JraW5nIGFzDQpleHBlY3RlZC4gZ2RiIGlz
IHVuYWJsZSB0byB0YWxrIG92ZXIgdGhlIHNlcmlhbCBsaW5lLiBJdCBtaWdodCBiZQ0Kc29tZXRo
aW5nIGRpZmZlcmVudC4uLg0KDQoNCklkZWFzLCBjb21tZW50cywgLi4uIHdlbGNvbWUuIFRoYW5r
cyENCg0KQmVzdCByZWdhcmRzLA0KRmxvcmlhbg0KDQpbMV0gaHR0cHM6Ly9zb3VyY2UuZGVueC5k
ZS9YZW5vbWFpL2lwaXBlLWFybTY0Ly0vYmxvYi9pcGlwZS81LjQueS9rZXJuZWwvaXBpcGUvY29y
ZS5jI0wxOTgwDQpbMl0gaHR0cHM6Ly9zb3VyY2UuZGVueC5kZS9YZW5vbWFpL2lwaXBlLWFybTY0
Ly0vYmxvYi9pcGlwZS80LjE5LnktY2lwL2tlcm5lbC9pcGlwZS9jb3JlLmMjTDE5NzkNCg==
