Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2058.outbound.protection.outlook.com [40.107.247.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226B414F7A
	for <xenomai@lists.linux.dev>; Tue, 29 Aug 2023 11:39:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbjcy1KqnJcQftDFxKfEVtrrBPVvC4C1QNfk5J25k1SDrN7VSFtvg4yh+pj/L1N8NIQ/uYc4k6PPXeamKU3s7GJkcg2EBnev1zTvRxB6LsAig82HIRLOi7H1Q1mMQTU2+nsV2NvJcO29KkJ4x7WvJ5IFK0Y+29xenCZBh+0smHdmp2F6OdrEFnJo9kyE6KHdK+RyWv3wyJax5dqqaIVvq4+bUxRYkO9ZKDDy24eNQN5q0/O2ryPzB5GQ4BsDmaUeuA3SME2WnxZCImpneQ9c+JqiHqAkqtxYpRfoo+v0E8LlZBWm086rstsM6At7PPHVdDv07EQFgnQz/QKQ1xx8oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=auiIaEPd3uxBVBooZEjisci0xLHKEpJkcjgvKEWkwTE=;
 b=dnlAYUwcmNfqYjWSvy7o7zQT1LYRiJgp4YHVpYdT0pIog0/ZsD921kTgJpe1rucHIrKGvB4S+BgqdxAygfPq+KB+fn3wryzE7Sr30JmgWxbhsghFfs5pE+dLeY2S7nBl0ukDgM+dYBSvoPZ+W/PjKm7BC0RLmfLNsFOE9XmtQu2Fq04JMYyeab1J7MEl1Vgj3ycY0gicg2LoppnyNdzGqmgEwUCpnBghNDH0GjFOcv7cdz0u4Cc21i9rLQgDlZHmiIr5JXQtGnvufHm4x/kLr3BK3W/mKwL79K2sOKqqxJ6J9dDQLQ6IlLVajkOg53QiEq2E78xJQK4/t3ilgkLrbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=auiIaEPd3uxBVBooZEjisci0xLHKEpJkcjgvKEWkwTE=;
 b=yXYFUOxMrpaW5xD3So0UaKASmDfVWM4SsOcqliwVXWTgZ8mQeCYiOXBTWXtHTNiSYdFxJBxNLtkjd62c1vJKsNVFRI+896ZR/1ih9CB40igz9IJfEqzdUXOKEcHf7YwldshNFDlzYaK9tdR5hJJniG7XjcMm2f5cAhmSsOMk2UGYLtcMDssF9imHokEfot1vlxEuunnnWYkeDQL5rzIPLlhOI0zeM6MpTTnMytC+VXnftcmYe5v0Qge7qMTzK7E7ZafyO59XPSfNrp5rzU3fMe3HzdGCgM0wP+HYmXYOCgd43kP0WHAAZqgDtqIY5kBHZ1oV+AwXhayHDbLs1GCmLg==
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by VI1PR10MB3151.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:135::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Tue, 29 Aug
 2023 11:39:12 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::83e0:fdfd:2432:226a]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::83e0:fdfd:2432:226a%7]) with mapi id 15.20.6699.034; Tue, 29 Aug 2023
 11:39:11 +0000
From: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: Re: [PATCH v3] cobalt: Adjust dev_addr_set wrapper to 5.10, 5.1 and
 4.19 backports
Thread-Topic: [PATCH v3] cobalt: Adjust dev_addr_set wrapper to 5.10, 5.1 and
 4.19 backports
Thread-Index: AQHZ2lzjonuCTB5urUKRLq2s0tcwzbABHFgAgAAJv4A=
Date: Tue, 29 Aug 2023 11:39:11 +0000
Message-ID: <f1d803d0f7b59818cd29fd3e80a37787e3e7ea6d.camel@siemens.com>
References: <f4a0e665-394e-46b6-ac61-cb3d3f76ea21@siemens.com>
	 <d0819b6742607b5763ff643e9b7a540e5de7d544.camel@siemens.com>
In-Reply-To: <d0819b6742607b5763ff643e9b7a540e5de7d544.camel@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB5712:EE_|VI1PR10MB3151:EE_
x-ms-office365-filtering-correlation-id: 2095e7f9-a016-40fc-c3e1-08dba88490a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 i2rOxPg7awfmQeWdUykc9kmbE2eZoe7xnafmsnUx/YklmbQWnlYCpr5G0RUh3WYdaejPbecfBSJWO9XLHZN5S46I6Wjbkv02ic6G6mjYe6HkDPnR5++zdWcDDxJhbSnWGpPmN6bx86LEWDqxwRzoxzzKCrNcxf9IZnH8MSejnuTnIeHK/OWye93oD1fH7jTvx9IU+PJqiIq94cOswVBW86hhF7EBKT4otjSEA/e1w1WOrxIPiYk6YDT9fB/KG/V0YAdHhb12ut2b5OOQeysI0sc1A0aQ7PUyGuJXW6+3P09P+dwrRLHGy3n7k5xHlfUidk+Lb76WVxuEsLZv+D7+epVq7Bt7WbnLzZtSfsj5BXnAUi+L8NhqjAefGnrAINcrQKfKH0n19rab1JPz0JqRVNs03OC/vgcdVujFCbB9aPfEJTsziJhC6ddAwRdd860bl5CBBHet5znykPam1N1DxhoggVgceXRdmH7021mNbcgA4DtYVFwYROele1AVG2Mg1tbgQ7NVcFEzrgQXy3OA+KG/U+41I8Rwfu4+PTMHMZ1bW8vMrJiCEftOI++btcPH/UbCM6/gmyt921O+5H+4rlmMjC/Zgg+EXpFiNDaEO1Ouxli9eJEkUR5GQye8xp6K
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(346002)(366004)(396003)(451199024)(186009)(1800799009)(71200400001)(6512007)(2616005)(6486002)(6506007)(86362001)(38070700005)(2906002)(110136005)(41300700001)(91956017)(76116006)(38100700002)(66446008)(66476007)(66946007)(8676002)(5660300002)(82960400001)(66556008)(64756008)(36756003)(8936002)(316002)(478600001)(122000001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?em91ZWNxSVc0eUlnVkxNVC9RM21Sd2xMUkZZb09BeFRVeE9GbUdjcFp4K1lE?=
 =?utf-8?B?cXNDeklsRzVRN1AzM3FXaVhxLzFtTEtJS2tKazBrVENUZnlFRC9kSm5OT1VE?=
 =?utf-8?B?b1lqKzNHNlphOW1mN1hXNU1WUUowcUl2L3k3MDBpZlYwN3pGK1Y1dUw5NFo4?=
 =?utf-8?B?VkJWeDJ5NytlSzVkL3I4ZnVQNDZwNEJNZmFJR0lvS0kwam42cEV4NHFPV2dE?=
 =?utf-8?B?UEdDYkxpYnVHbWhWM1dFa1JLQzJxWHZabjFLdk1iN2NnZ3hEaVZ5OUpITmh0?=
 =?utf-8?B?MmwrVjFKZGcwUnU1eTNTMU1UNU42bkdLVjF2VGM4Wnd2NzZtaWJReGZFSS9D?=
 =?utf-8?B?TisxT0lFSFA0b2sxL1ZOeTNHTHVtOGt5NWFHSUdsMXhYWFFPQ3V6MU9obXBC?=
 =?utf-8?B?cTd0am04bENCMTUyeTVaMWhDQUNheE5GbEZxbmJ0dVdpYzY5UkdKblFuSTBW?=
 =?utf-8?B?MnlsaXhVR1VCc3ZWZnNWVjgzV085VW55N2xJOVdVcWE0MTlJeGsvSkhGNEth?=
 =?utf-8?B?aFNUZG11dGxXdVlqNkdYdXQ5Nmtla1cyZm1OeE5Ha2hFa2tNT0FNaFA2dkM3?=
 =?utf-8?B?N24rYXpPc0RjdnVLL0FmNnpnSkVPS3RUVW8rVStQVGFod3ZhVkJZNGZ3N3F4?=
 =?utf-8?B?RGVCVHBCRWlrUmJHakVHK1N5VDRYQi9BYkNodjdTMXpRNHhWV3VYNUVtVVVL?=
 =?utf-8?B?UjBNTnpFTWZieCtMdUEzNTVVNElMQVZtYkFiZmNXYUdOdzExWEx0VU1YclFH?=
 =?utf-8?B?UmEvdXY2SFhrS1RVdDFDbG9jdVQvYmRsVEhVWHJzNW1DZlVrc29Fd0VnVjFo?=
 =?utf-8?B?RXpyMmV3dndWSVcwcERkemgzOWY1ZEM1VGtqN2V5Q1p6N3NvVWpHdkdaem9H?=
 =?utf-8?B?QWlISmt5RUZVQUV5aXZMZnQrYWRtRnkyaUNCRmE0WTZNUGF2eEJKSStuUTZY?=
 =?utf-8?B?SkhmRDR3YlhHcTcwTTk3L0NiVytnSExqOWgwZ2dSeGxBcjhaN3VCSjFWY2FC?=
 =?utf-8?B?emlSWExGWDdmY25rcEhxcHNQQjIvOFBmQ01mbmtjTGZyNmp2a2VOTXd4am0y?=
 =?utf-8?B?aExnWGN6akNESFRwOHRHY24vTStaV0p3S1ZmSDU5WmdsZUpMSVBPbGx6Z2Fo?=
 =?utf-8?B?dHhJZGExbmlaSGlXUVVPZ1NCTklXVGpESU8vb3ptWWJxdGhBNGN3Tk10VXp0?=
 =?utf-8?B?WExMdjFyM3RUMzROb0xFSjhocUc3NjgwRG16ZERJYkxBSDdYNk5lelBPd0pt?=
 =?utf-8?B?d3N2TDZ2bzV1aDFQZG9mb1g3dDVDckJqOW8vSFNYZDdiTGw4WFNTbktTaTBr?=
 =?utf-8?B?WVE5U2Z0cFRNdFVrUStqNC9uRGdNdXRMTXFtc01sWk1HS2tVdXVzZkhxWGZv?=
 =?utf-8?B?TG8vQjNOR0VtSTl6YWszZklsTGtkMDRUZ3llQUt3eVJJdjMvK0ZUVXRCa2I0?=
 =?utf-8?B?TnZzNktGY1VhWEtVNEhESjZLOHJUa2JIOCtxUFlDSjRoczg5dUVHNG1mUjA2?=
 =?utf-8?B?S1JCQlJicWt6RFZLZ2hWRDRhYnNkb2hKZ3R4SE1UNzUzc2VQd0d0ejFtN2xH?=
 =?utf-8?B?bDM3OGJPSlEzQlp3RGltVkJQNFhjbTg3UzBzd2JvV0toY3JGbFljZFR1VVVW?=
 =?utf-8?B?THNkSkFJSHJnY1hZOFZWNUVaOVRGUExLdytUdlgvVFFuZUxEb0hFMW1mU2Iw?=
 =?utf-8?B?SktFTkc2b21TdW5zRlM1R2ZlbGgvdEN0U0dGRGxZTkVHUlhWeWRZUnJxVzAw?=
 =?utf-8?B?Uzl3czc4azdPYWFPZGp3N1VuNitRRHZNODNtdEljOGl5TlNGMExwZEN4MjFI?=
 =?utf-8?B?Wld6S25aM0RRNjFxUWtjRGtqZG1mbEJYWGlUZ1B6MmhJUUl0WkxOWmp4cUhm?=
 =?utf-8?B?S0ZBNnBNM3UrUHVqTUtvNERPbzFxdHdCQUUyQTF6RDYyNW1RWHpxcm42Vk9t?=
 =?utf-8?B?VTU5blFJbHhUcG1KOTFhZzFIMXBteFZuVmtFcTZMcmJ0clZBMG5vMmRsS2Zn?=
 =?utf-8?B?WnQ5M1hCTk5tb0tPWUVpa3R4UzdxTG5aT0pJUWV6RnRkZW0rTmozc3hJdTFO?=
 =?utf-8?B?S015NHc5L20zUGxNTS9zSnphekJ6ZzJWcVJnekNqb0RNY2M3dXlUcWJTUTdB?=
 =?utf-8?B?REtNcmtWaDlvRGRuTGtzKzJRUkF0bTNzT3NsVk9NZXBpZ2wxY3k2RERIaUhD?=
 =?utf-8?B?RzVBMjl1clgySTgwN3JNZGpjeWs5QUlXeEpQWnVjNnQ5OEhlUnlwcW1XZEhC?=
 =?utf-8?Q?6oUFX6z8noLLPJAtGMSjyip56PjYruM3ZIcrNTfKSk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA6C43C24F3D004187C3A64ECE9DE44E@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2095e7f9-a016-40fc-c3e1-08dba88490a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 11:39:11.8324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EgNqX9esFEXbaMhBb8+0nluyFs7eisf3qJMoJF7pj+mccgUqTBUu6bVdQgZ51YA65vi5xaGe1nJ671fOo6XUCGnJpnoaSAhdW4kBZIeKSgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3151

T24gVHVlLCAyMDIzLTA4LTI5IGF0IDEzOjA0ICswMjAwLCBGbG9yaWFuIEJlemRla2Egd3JvdGU6
DQo+IE9uIFR1ZSwgMjAyMy0wOC0yOSBhdCAxMTo0MCArMDIwMCwgSmFuIEtpc3prYSB3cm90ZToN
Cj4gPiBGcm9tOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPiA+IA0KPiA+
IFNvbWUgc3RhYmxlIGtlcm5lbHMgZ2FpbmVkIHRoaXMgaGVscGVyIG1lYW53aGlsZSBhcyB3ZWxs
Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVu
cy5jb20+DQo+ID4gLS0tDQo+ID4gIGtlcm5lbC9jb2JhbHQvaW5jbHVkZS9hc20tZ2VuZXJpYy94
ZW5vbWFpL3dyYXBwZXJzLmggfCA4ICsrKysrKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA3IGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEva2VybmVs
L2NvYmFsdC9pbmNsdWRlL2FzbS1nZW5lcmljL3hlbm9tYWkvd3JhcHBlcnMuaCBiL2tlcm5lbC9j
b2JhbHQvaW5jbHVkZS9hc20tZ2VuZXJpYy94ZW5vbWFpL3dyYXBwZXJzLmgNCj4gPiBpbmRleCBl
YTdlZDNhZDU2Li5hNTMzZDQ2NjkwIDEwMDY0NA0KPiA+IC0tLSBhL2tlcm5lbC9jb2JhbHQvaW5j
bHVkZS9hc20tZ2VuZXJpYy94ZW5vbWFpL3dyYXBwZXJzLmgNCj4gPiArKysgYi9rZXJuZWwvY29i
YWx0L2luY2x1ZGUvYXNtLWdlbmVyaWMveGVub21haS93cmFwcGVycy5oDQo+ID4gQEAgLTU0LDcg
KzU0LDEzIEBADQo+ID4gICNkZWZpbmUgY2xvc2VfZmQoX191ZmQpCV9fY2xvc2VfZmQoY3VycmVu
dC0+ZmlsZXMsIF9fdWZkKQ0KPiA+ICAjZW5kaWYNCj4gPiAgDQo+ID4gLSNpZiBMSU5VWF9WRVJT
SU9OX0NPREUgPCBLRVJORUxfVkVSU0lPTig1LDE1LDApDQo+ID4gKyNpZiBMSU5VWF9WRVJTSU9O
X0NPREUgPCBLRVJORUxfVkVSU0lPTig1LDE1LDApICYmIFwNCj4gPiArICAgIChMSU5VWF9WRVJT
SU9OX0NPREUgPj0gS0VSTkVMX1ZFUlNJT04oNSwxMSwwKSB8fCBcDQo+ID4gKyAgICAgTElOVVhf
VkVSU0lPTl9DT0RFIDwgS0VSTkVMX1ZFUlNJT04oNSwxMCwxODgpKSAmJiBcDQo+ID4gKyAgICAo
TElOVVhfVkVSU0lPTl9DT0RFID49IEtFUk5FTF9WRVJTSU9OKDUsNCwwKSB8fCBcDQo+ID4gKyAg
ICAgTElOVVhfVkVSU0lPTl9DT0RFIDwgS0VSTkVMX1ZFUlNJT04oNSw0LDI1MSkpICYmIFwNCj4g
PiArICAgIChMSU5VWF9WRVJTSU9OX0NPREUgPj0gS0VSTkVMX1ZFUlNJT04oNCwxOSwwKSB8fCBc
DQo+ID4gKyAgICAgTElOVVhfVkVSU0lPTl9DT0RFIDwgS0VSTkVMX1ZFUlNJT04oNCwxOSwyOTEp
KQ0KPiANCj4gVGhpcyBpcyBzdGlsbCBicm9rZW4uIEkgaGF2ZSBhIDUuNC4yNTMga2VybmVsIGhl
cmUgd2hpY2ggYWxyZWFkeQ0KPiBwcm92aWRlcyBldGhfaHdfYWRkcl9zZXQuIA0KPiANCj4gTElO
VVhfVkVSU0lPTl9DT0RFID49IEtFUk5FTF9WRVJTSU9OKDUsNCwwKSBpcyB0cnVlIGZvciB0aGF0
IGtlcm5lbC4NCg0KSSdtIHRlc3Rpbmcgd2l0aA0KDQojaWYgTElOVVhfVkVSU0lPTl9DT0RFIDwg
S0VSTkVMX1ZFUlNJT04oNSwxNSwwKSAmJiBcDQogICAgKCBcDQogICAgTElOVVhfVkVSU0lPTl9D
T0RFID49IEtFUk5FTF9WRVJTSU9OKDUsMTEsMCkgfHwgXA0KICAgIChMSU5VWF9WRVJTSU9OX0NP
REUgPj0gS0VSTkVMX1ZFUlNJT04oNSwxMCwwKSAmJiBMSU5VWF9WRVJTSU9OX0NPREUgPCBLRVJO
RUxfVkVSU0lPTig1LDEwLDE4OCkpIHx8IFwNCiAgICAoTElOVVhfVkVSU0lPTl9DT0RFID49IEtF
Uk5FTF9WRVJTSU9OKDUsNCwwKSAmJiBMSU5VWF9WRVJTSU9OX0NPREUgPCBLRVJORUxfVkVSU0lP
Tig1LDQsMjUxKSkgfHwgXA0KICAgIChMSU5VWF9WRVJTSU9OX0NPREUgPj0gS0VSTkVMX1ZFUlNJ
T04oNCwxOSwwKSAmJiBMSU5VWF9WRVJTSU9OX0NPREUgPCBLRVJORUxfVkVSU0lPTig0LDE5LDI5
MSkpIFwNCiAgICApDQoNCnJpZ2h0IG5vdy4gV291bGQgbmVlZCBwcm9wZXIgZm9ybWF0dGluZyBv
ZiBjb3Vyc2UuDQoNCj4gDQo+ID4gICNkZWZpbmUgZGV2X2FkZHJfc2V0KGRldiwgYWRkcikJCW1l
bWNweSgoZGV2KS0+ZGV2X2FkZHIsIGFkZHIsIE1BWF9BRERSX0xFTikNCj4gPiAgI2RlZmluZSBl
dGhfaHdfYWRkcl9zZXQoZGV2LCBhZGRyKQltZW1jcHkoKGRldiktPmRldl9hZGRyLCBhZGRyLCBF
VEhfQUxFTikNCj4gPiAgI2VuZGlmDQo+ID4gLS0gDQo+ID4gMi4zNS4zDQoNCg==
