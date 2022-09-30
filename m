Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2055.outbound.protection.outlook.com [40.107.20.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C7C10F5
	for <xenomai@lists.linux.dev>; Fri, 30 Sep 2022 22:43:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKtYLQeTTNdge5IPhZQUCLuQftHMN5hHhJER0Qnb/Zuj1kZKPOyImORpESD3lExVH5QeuzJfzGq4aCLIZE7BN0YidMTb/Q+qI0c1gnWaqNqvbF0d/qn5K7iraf4aorA5oilX4iFRCEje8moVCtDxWIbBg14IEyDpsPcBMih+pGRYgJr2Ov6Zj9h5AZZ9ahzgzpqDON/pA/COTjBet3slCFrwhVoXWcqIqZXUlXyGd1/2qOZp2Y3Is0qRcpsmOieT8gRNJYJbj/tQ0bYp4NGr8Njrp+H7XNJcVLcaNhcR/UK9miANpD+3kcwP19+P5K0+hvN0kZUNJTEiSd03luUfPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70Re8UqY/syUIFEYDOIpAdxILVfc0q35Ow7O8tg99yA=;
 b=GfO9FzhVGnt3l7jZhlLe+rhMV/8jd26yzD+6R8BisA5KWaxa+HmzLEQlALv+eefPfNVox2U/wiFuSec+YviknQWr1lxpIzhE2Nr/bx0TCCeeMojeR6CpSic/O1cwJBCyl8gfygkSwwAHNDGg3iEtG9wbnFIx4erPxSVhqEMMRU7954UpgVc21tYFLb8UOPOLI56S0/FzmaOtXTx6xBd362lRB0tYUv8xylln/M6GHeEEDgkyJKGUtRir0n6f0T0vVoPInIBXsdOu/73qP39SB7xTaVrkpnwnVwDwBeuOVrjFK2km6zcIaa7P62UR0MqJU9yV9/s2KAwUZSiIKlMzMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70Re8UqY/syUIFEYDOIpAdxILVfc0q35Ow7O8tg99yA=;
 b=ZOKrXDy+YLGMKIabKy5/uSo3Q6V9H5rjLcqlgTAHFHLEqHGUMuskkanKbtGSbm/ZypnoQkw/vq5wykjzkhAkgzlWnZHmHnGiCQRm0L8e081EQ1qjJL9376R5CdRUjwCym/1mEg3oDnM3UCdOEGLr3m+mj/O3r31Ddk1YJNAYP5APoGox4g17TaCeMipZ8l4MvaQ9+ZJ5DLqBJ6uFm0uitZZFA2Z+Ex6auo7qLAEnTA8m3FFpxUrvrurTmGaHugLHJ2a2nMJUfaCE376itC1PezynOL52bR/On+T+j2u2JdseSC1wk3Xa4k9nyd+hfe6VBV2IHcyVQ8H8yQWgwYrOmA==
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by PAXPR10MB5757.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:247::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Fri, 30 Sep
 2022 22:43:00 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c9a0:731a:c172:4a6e]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c9a0:731a:c172:4a6e%7]) with mapi id 15.20.5676.020; Fri, 30 Sep 2022
 22:43:00 +0000
From: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
To: "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: [PATCH v2 0/4] Enablement of compat tests in CI
Thread-Topic: [PATCH v2 0/4] Enablement of compat tests in CI
Thread-Index: AQHYzOwFZX1qblzk/kKG4DwG6GLXy63xyjEAgAACiYCAAAnmAIAAAISAgAbK/oA=
Date: Fri, 30 Sep 2022 22:43:00 +0000
Message-ID: <90d585aeec1afc5ce593518fb2b4174dffab881a.camel@siemens.com>
References: <20220920122503.115682-1-florian.bezdeka@siemens.com>
	 <0b37be56-c31f-5603-414c-07e678c6b560@siemens.com>
	 <da16ff7b5550d7a6fd2bb2aa67f6e194534282d8.camel@siemens.com>
	 <b1cb0aa4-7707-b2af-72ad-723d98d500e3@siemens.com>
	 <a8005a9a-9d43-514d-20ec-3bee801c5b48@siemens.com>
In-Reply-To: <a8005a9a-9d43-514d-20ec-3bee801c5b48@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB5712:EE_|PAXPR10MB5757:EE_
x-ms-office365-filtering-correlation-id: 04d35b16-398c-4fab-86e4-08daa3352090
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 a3Mk5WhDcM539Hj7LcouZ9gxWCRUjWh1aJmb163kTxHxfgJehQNmj/bKlz0vAip6yRmnyElZrFPExMs4NXB3eL2xPElzn+vDpj8k2fyXmaoRyiBLvvP26cbwV5LIWR3dOobuQUEFwIgPEyh/UmEOTFpR/Ww04WYOaS9JMA/Rl3oFkS/+/jnN/nCiRj5ztN3eAXKgKHA4LocE+o1n1XFeBa8FKl6B2AhhVfXON/LBO+c+hD2h4AyiLvBRU5hF0zsLXAtItToVgGIH1MeMOU1CEem+4I8kcU9kFuyOI3n7OZmQ6xCW0X6m8SqFS3GCpTveNRs5A26I8Db+y0Ut6T0jAaThPRtQL8nJDYzAtVc8tdUPVcwcENyEpXXBIS5xzzqHX5Ldrm0xIjWYOYVgvyigfbzvhqbgXAh/QnIG2a+w7sImaVT6UZwCxFzo4bA6ABvMPHo7eae7BZc2nvKwHkS7RM+u9+LQ+pVikYDhUREgE83c5EOPizCsLqIG3uwttV06hDmOEb8ir4sgD9slBmMRIYxASfmMQC4ICvbrZP2xy5epoxfmec8wVI+aU188ZK6iKDBMW1d6VsQP0fhCjivPgioNURfcZku5+SDkPswUeuHvjNvDHFV80GiY4c8I8XviQk7+uRhSTNgyokviYElk3t4QaMt86IFO/GQ+SG5gwS4YC7J0OjnTnLHlsWrux7paXTGIEKpBiK+7QvWxnfMoVJt1tPK2440gkOuXuWacwtFuWbXuJbl7KdnE3mtTS6Qn1ry93/MOvZLe/p5KUDUGmg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199015)(66476007)(6512007)(2616005)(186003)(316002)(36756003)(6506007)(38070700005)(66446008)(82960400001)(38100700002)(6486002)(53546011)(71200400001)(478600001)(5660300002)(2906002)(110136005)(83380400001)(8936002)(86362001)(76116006)(91956017)(122000001)(8676002)(66946007)(41300700001)(66556008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cVNYQ2NLaEprZ1RHdWFlOEpmaG1TbUh2ZElFK25ocHZ1RlpaVVY4NlU1SVJi?=
 =?utf-8?B?UmNYd3RyUDBnT0NNb1JjbThYTUVna3lKZlRNaW9aMFRDLzlnYjcrOThCSzFp?=
 =?utf-8?B?Nk5KU25Oa3g3Q2pwLzBFdkZ2ZEI0eTY5WmhVUERXdWM5clI5RU9RS2hVTkto?=
 =?utf-8?B?SEdSZ1hYYkIwd0FlZElsRHM1d3JST0Y1ekVqajVIS1JHcWRURFJyR3haMzcr?=
 =?utf-8?B?TC9XWWhZaGRGUzZ0SEMzNnFicGFPQ2hQWEdXNjBXMFNVV0ppRmIyUlhkdXJX?=
 =?utf-8?B?R0VpQk83L1AvTC95YndQY3V0eXlCTDh4SnZBUEE2Q1h6Vk0yRzFYa1gzdlJa?=
 =?utf-8?B?Q3ViOHp5SjhJMWZVWHhqMXZhRUZXVm9uUzVDTlpic3dtWTJaeGpDU2V5aG1q?=
 =?utf-8?B?VjJOYTkwTGwvbW5FcVc5a2lEM1lVV0pvQ1dHYU85ODhlaURTSmZKWkxRM1Bs?=
 =?utf-8?B?MnlxMkNsc0R0c2xFZGR5QzIwNDFoNUxHamdqa3IwSThFVXhocnVLM0VYWEE1?=
 =?utf-8?B?SFlYMkhHRDUyUE9yZEcvelRmUm90YmJFRDB6c1J1RHlLV3hKOHczSXdEcEhB?=
 =?utf-8?B?eURtYWt1cnpwS0QwajBVenB3enN1WjAwWEVHN2hKNGc0M3ZINlIrOWwrQUN3?=
 =?utf-8?B?aWI2YnVVNXZsQktxN3BzejU5cmp4bHYvcW5QWmRGMGVYN2hXM2FzMEhUM2tp?=
 =?utf-8?B?NnJDNWduMUhld3Rsb2c2cDlKTitONXhGdnZSdnVWV2R6eVIxWTI3MkEvV2N0?=
 =?utf-8?B?bElLTHVPTGFldXh4a1E5U21DVlBjbVZQY2JHZmNmSjdwUDRTUGRIYnVmSTA4?=
 =?utf-8?B?VnlEdmRhU2drSHZtTjdHMHNCSWJaREdyU2U5T0cxZ1Y4VUVCQmM3azRkd0dh?=
 =?utf-8?B?bDZ2UC9sMkR2RytnMmlkMG8vT20reHJYdVFVZVlua2ZWMUpzQUcyTHVXOHVI?=
 =?utf-8?B?anBmL1dTUkJPN2RhSG4vS1RqeFl4c3RCT24vZjRocmxsZW5UbnlkYlB3WUhj?=
 =?utf-8?B?WUFSTllIemZocHkrZUZOY0tHTFE3cE9ndTg4MHRsd09ObHlXTXRERXVtcWVl?=
 =?utf-8?B?d3pnQnJFVlFFUFc0Mk84UXltNWNiRDVyb3pRY2lrdkxmK1hpSmtycXZpdS9x?=
 =?utf-8?B?TTVrb04xTXZHeG5sN1pwQit1UE9aRW5FM2E2QTRwN1JzOWFjS1cyZitPZUdQ?=
 =?utf-8?B?Z05Mb1Fxb1BONS81eWkrVlc2OENCVnNlOWtmTVdEMlNxZ1NHUEhiLzN5eTk3?=
 =?utf-8?B?SmlsZzFsRVJxTDNJdzB5aEZqTkszQjVBQ2xXcVJSekRmcFhrZVVWQ3JCb0Vt?=
 =?utf-8?B?VHRLOVJ0MTZ1TGR0dFpXVjFrTHg3QVRUaWRabzdOZWwreWRMaHdvNGxZYWgx?=
 =?utf-8?B?Mk56ZytXQUNxK21aN2dveis1bHJSS0UwMzJidXVsYjNCT0hqQm1SUmdpMk1v?=
 =?utf-8?B?aFpUV0U5TEdldEorRHFlNndSTVRQdU0yUHF2ajFEWEdyelBGdEg0cEhWS0FH?=
 =?utf-8?B?N3dLRG9ua3I0Z2c1ZkVxNytQNFVseENObDIyRjlBZkVqS2NHYk1OUUJQUGNq?=
 =?utf-8?B?QURzOENFcGlOSHBQaUx5WWNFejFLdXA0M0NNZW1QOTVOMFVXSTNwSXM1d1Bk?=
 =?utf-8?B?NmNSSlZUSTM4OU9KRWx0ZXdYL2JlRDhKYzFwYVBpNE4xc3hqRTAwbnRhYlFn?=
 =?utf-8?B?UGc3UFFtTFp5RlZOT1IxNnlBSmdSZjM2c3kxRzlJUDNEdXkzVzAyMVJpZDYx?=
 =?utf-8?B?MGY2cjlSc2NhNEpHdlRUb1ZZcHVKdGpGaVFjOWhkWTNVdWI5OXpheE5zQWs1?=
 =?utf-8?B?MERZcXJSQ202M0pGQVpaZEVsZzUrYnBBZ0RRMW5tQ2RDSE1LOUplWGRHN1dh?=
 =?utf-8?B?YlA0eFNLRXdjeUFZRHdhSTAvUW1ReUw3VmVzRkE4dFZGWWxJL3JyWWVzYWNI?=
 =?utf-8?B?WnZLeHQxZnVFcFNac3VFUjNHUVV5My9TcjBsMS9MR29tdERpV0RXYmJtc0Z4?=
 =?utf-8?B?VUh3eHVBeFAvdzRaeElSRUxNZDRGWGlpbzJOZEF6NUdzeUlxZmJiOTV3WW13?=
 =?utf-8?B?eGVsYnJDWDhJT1FSZXJtQnVQNCtkZ205OUl0Mmx0bktUMFRDL214NUltV1VB?=
 =?utf-8?B?c3p1dnAyZEN0TS84dkZVRUF1eGlsajJsYno3akNENW92aGYwWnk4c25TMEhk?=
 =?utf-8?B?T0FEUGtCQ1V3cVBGOUNHbTV0VEE2cEtZUlhKZ0h1RjZZMm5sVU8rWjN0aTNI?=
 =?utf-8?B?NjQyM0pVZjByRU1sdnlPZTIxSUJBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8508E15658CE284BA6838672A438528F@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d35b16-398c-4fab-86e4-08daa3352090
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2022 22:43:00.1127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iN+Uy1M8FRGAMH0UaR7BzBF0CQ/uAi/I0/Hcjg79o3t88FwGPIYV5OgPmFskXdLMTDJmHidBUI25QxAyHdtdfIuqrVFDOd6IER6rHmi3rdE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5757

T24gTW9uLCAyMDIyLTA5LTI2IGF0IDE2OjU4ICswMjAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAyNi4wOS4yMiAxNjo1NywgSmFuIEtpc3prYSB3cm90ZToNCj4gPiBPbiAyNi4wOS4yMiAxNjoy
MSwgQmV6ZGVrYSwgRmxvcmlhbiAoVCBDRUQgU0VTLURFKSB3cm90ZToNCj4gPiA+IE9uIE1vbiwg
MjAyMi0wOS0yNiBhdCAxNjoxMiArMDIwMCwgSmFuIEtpc3prYSB3cm90ZToNCj4gPiA+ID4gT24g
MjAuMDkuMjIgMTQ6MjQsIEZsb3JpYW4gQmV6ZGVrYSB3cm90ZToNCj4gPiA+ID4gPiBDaGFuZ2Vz
IGluIHYyOg0KPiA+ID4gPiA+ICAgLSBSZW1vdmVkIHBhdGNoIDEgKGFscmVhZHkgbWVyZ2VkKQ0K
PiA+ID4gPiA+ICAgLSBTcGxpdHRlZCBwYXRjaCAyIGludG8gMiBwYXJ0cyAoYWRkcmVzc2luZyBy
ZXZpZXcgY29tbWVudHMpDQo+ID4gPiA+ID4gICAgIC0gcnRkbSBleHRlbnNpb24gKG5vdyBpbiBw
YXRjaCAxKQ0KPiA+ID4gPiA+ICAgICAtIGNvbXBhdCBzdXBwb3J0IGZvciBydF9jYW4gKHBhdGNo
IDIpDQo+ID4gPiA+ID4gICAtIEFkZGVkIHBhdGNoIDQgKGhlbHBzIHRvIHNlcGFyYXRlIENJIGxv
Z3MpDQo+ID4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBIb3cgYWJvdXQgdXNpbmcgcGF0Y2gg
MSBvbiBvdGhlciBkcml2ZXJzIHRoYW4gdGhvdXNlIHlvdSBhZGRyZXNzIGluDQo+ID4gPiA+IHBh
dGNoIDIgYW5kIDM/IE5vdCBuZWVkZWQ/IE9yIG5vdCBwb3NzaWJsZT8NCj4gPiA+IA0KPiA+ID4g
Tm8gKGZhaWxpbmcpIHRlc3RzIGF2YWlsYWJsZS4gVGhhdCdzIHRoZSBtYWluIHJlYXNvbi4gVGhl
cmUgbWlnaHQgYmUNCj4gPiA+IG1vcmUgdGhhdCBpcyBtaXNzaW5nIHJlZ2FyZGluZyBjb21wYXQg
c3VwcG9ydCBpbiB0aG9zZSBkcml2ZXJzLiBBcyB0aGlzDQo+ID4gPiBpcyBtb3JlIGNvbXBhdCB0
aGFuIHkyMDM4IHJlbGF0ZWQgSSBkaWRuJ3Qgc3BlbnQgdG8gbXVjaCB0aW1lIG9uIHRoYXQNCj4g
PiA+IGZvciBub3cuDQo+ID4gPiANCj4gPiA+IElmIHlvdSBsaWtlIHdlIGNvdWxkIGFkZCBwb3Rl
bnRpYWwgY29tcGF0IHByb2JsZW1hdGljIGRyaXZlcnMgdG8gc29tZQ0KPiA+ID4ga2luZCBvZiB0
b2RvIC8gaXNzdWUgbGlzdC4NCj4gPiANCj4gPiBJJ20gcGlja2luZyBvbiB0aGlzIHRvIGVuc3Vy
ZSB0aGF0IHRoZSBuZXcgUlRETSBBUElzIGhhdmUgYXQgbGVhc3QgYmVlbg0KPiA+IHZhbGlkYXRl
ZCBhZ2FpbnN0IGFsbCBwb3RlbnRpYWwgaW4tdHJlZSB1c2Vycy4gU28sIGNvdWxkIHlvdSBoYXZl
IGEgbG9vayBpZg0KPiA+IA0KPiA+IGtlcm5lbC9kcml2ZXJzL2lwYy8qDQoNCmJ1ZnAuYywgaWRk
cC5jLCB4ZGRwLmM6IE1pc3NpbmcgcGFydCB3YXMgYXJvdW5kIHN0cnVjdCBpb3ZlYyB3aGljaCBp
cw0Kbm93IGhhbmRsZWQgY29ycmVjdGx5Lg0KDQo+ID4ga2VybmVsL2RyaXZlcnMvbmV0L3N0YWNr
L2lvdmVjLmMNCg0KaW92ZWMuYyBsb29rcyBPSy4gSXQgaXMgd29ya2luZyBvbiBzdHJ1Y3QgaW92
ZWMgdGhhdCBhbHJlYWR5IGhhcyBiZWVuDQpjb3JyZWN0bHkgZmlsbGVkIHVwIGJ5IHJ0ZG1fe2dl
dCxwdXR9X2lvdmVjKCkgdXBmcm9udC4gQ29weWluZyBkYXRhDQpmcm9tIHN0cnVjdCBpb3ZlYzo6
aW92X2Jhc2UgaXMgbm90IGRpZmZlcmVudCBpbiBjb21wYXQgbW9kZS4NCg0KPiA+IGtlcm5lbC9k
cml2ZXJzL25ldC9zdGFjay9pcHY0L3RjcC90Y3AuYw0KPiA+IGtlcm5lbC9kcml2ZXJzL25ldC9z
dGFjay9wYWNrZXQvYWZfcGFja2V0LmMNCg0KcmVnYXJkaW5nIGlvdmVjOg0KcnRkbV97Z2V0LHB1
dH1faW92ZWMgaXMgdXNlZCAtIHdoaWNoIG5vdyBoYW5kbGVzIGNvbXBhdCBtb2RlIGNvcnJlY3Rs
eQ0KLSBzbyBubyBhZGRpdGlvbmFsIEFQSSBhZGp1c3RtZW50cyBuZWNlc3NhcnkuDQoNCnJlZ2Fy
ZGluZyBpb2N0bDoNClRoZSBleGlzdGluZyBBUEkgaXMgdXNhYmxlIGFzIGlzIGJ1dCBzb21lIGFk
ZGl0aW9uYWwgaGVscGVycyBtaWdodCBiZQ0KbmVjZXNzYXJ5IGZvciBoYW5kbGluZyBzdHJ1Y3Qg
X3J0ZG1fZ2V0c29ja2FkZHJfYXJncyBhbmQgc3RydWN0DQpfcnRkbV9nZXRzb2Nrb3B0X2FyZ3Mu
DQoNClN1bW1hcnk6IEkgYXNzdW1lIHRoZSBBUEkgY2FuIHN0YXkgYXMgaXMuDQoNCj4gPiANCj4g
PiBtYXkgaGF2ZSBhIG5lZWQgQU5EIGNvdWxkIG1ha2UgdXNlIG9mIHRoZSBmdW5jdGlvbnM/IEFj
dHVhbGx5IHdyaXRpbmcNCj4gPiBwYXRjaGVzIGNvdWxkIHN0aWxsIGJlIGRvbmUgbGF0ZXIuDQo+
ID4gDQo+ID4gVGhhbmtzLA0KPiA+IEphbg0KPiA+IA0KPiANCj4gVGhhbmtzIHNhaWQsIEknbSBt
ZXJnaW5nIHRoZSBzZXJpZXMgaW50byBuZXh0IG5vdyBhcyBpdCBmaXhlcyBpc3N1ZXMgYW5kDQo+
IGFsbG93cyB0byBwcm9ncmVzcy4gQnV0IHdlIHNob3VsZCB2YWxpZGF0ZSB0aGUgQVBJIGJlZm9y
ZSB0aGluZ3MgbW92ZSBvbg0KPiBpbnRvIG1hc3Rlci4NCj4gDQo+IEphbg0KPiANCg0K
