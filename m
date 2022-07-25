Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2086.outbound.protection.outlook.com [40.107.22.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D5162D
	for <xenomai@lists.linux.dev>; Mon, 25 Jul 2022 08:46:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+UHZzRCcpqZ9yGFbW+Fkqu6bmUPXvGVq80eYBiwiTd2koOY5mlOqAVs1soN8xA0yWl/27ImanCbaO8clBbUT/ZSfmyDSgS34PmqrhjmPC0gNfoA7QaD4CQ/FMHdnPdRMiWWmqfj30Aw8++qTj9GGQtgZEr57W451POQX55EfkS6kdinE7rpea1Ynw163Mk3WOiXeJ2XU9FAH+Y9AcGNmgmOLXjLKENfezWsIdlJGtLtSvx4dm8dKa76y4tpA1ecrsU1FOoLpuD7+NTaj/fzzxfMMYSaVmluHKsN89CwSJ5cJCzuHb4VAgu0pgUeEXkNYDhzzs9tkTp/g50QybO2KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/eXLNzJuRhyiq7JsDBYAJj86RoDpNwoV/GXV/bTHom0=;
 b=RAXCy2NFLYL9nBGKLbNgFsBA/HYCSsBsnaZzhefIXaXf9XyL5B57UtiC7qBS8CD0XGYMzApGwq9dl+w+3Ptzj8cm5aXCNfUHKbD8QkBJD4xMhjLv74rf5byHQa2lW/Ji9t0s3ga7jXndd7qTJszIkI8cXsxiMxcNPyF+MQrptvX5ilXGPffBbPZi2SEM5SGUXQy07p3v1Na39HF3Z1mji+W9R1nqM9lAw934Nj5hjot13exE3KjVg2UPAmAWizaqfOjCxaPJ0CsiisRt5jqWd69YilUT4eFGT+VoqL7njbkAsHQUwhXGGyZJ0sy6OA74gjbhuZjYTCdiy4KpQMSpKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=andritz.com; dmarc=pass action=none header.from=andritz.com;
 dkim=pass header.d=andritz.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=andritz.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/eXLNzJuRhyiq7JsDBYAJj86RoDpNwoV/GXV/bTHom0=;
 b=hLRbOVb6e73sOCh+HUxXRLP7eJysoI39QaJ9z6HgAEZuWBRQqCe/xZXeVUuNtpOk3ojhpGDiku68xoS+OD0GypBHlZ0bIMbdK4//lmuhgE64nHp+wJMQsXSYtfgKqXVTy4gFz1yyGlQtUUclX8DTQBLqqMs0exJ/n2AXxqHQZp0=
Received: from DB9PR05MB7723.eurprd05.prod.outlook.com (2603:10a6:10:21f::11)
 by AM6PR05MB4184.eurprd05.prod.outlook.com (2603:10a6:209:4a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Mon, 25 Jul
 2022 08:46:04 +0000
Received: from DB9PR05MB7723.eurprd05.prod.outlook.com
 ([fe80::541e:3c30:100c:d04c]) by DB9PR05MB7723.eurprd05.prod.outlook.com
 ([fe80::541e:3c30:100c:d04c%5]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 08:46:04 +0000
From: Lange Norbert <norbert.lange@andritz.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Norbert Lange <nolange79@gmail.com>,
	"xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: [PATCH] fix build with clang
Thread-Topic: [PATCH] fix build with clang
Thread-Index: AQHYnOm6ayjpADcSI0KgxRL8GXXLf62MByqAgALEuWA=
Date: Mon, 25 Jul 2022 08:46:04 +0000
Message-ID:
 <DB9PR05MB7723703F70667211483E9903F6959@DB9PR05MB7723.eurprd05.prod.outlook.com>
References: <20220721100432.672540-1-norbert.lange@andritz.com>
 <9ac8c987-07b7-4f78-a1db-249b6383c4cb@siemens.com>
In-Reply-To: <9ac8c987-07b7-4f78-a1db-249b6383c4cb@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=andritz.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f094560-ce74-4070-d13f-08da6e1a1bf9
x-ms-traffictypediagnostic: AM6PR05MB4184:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 AmPjiIUzS+ouyi9vXT0KyMMYaqfHggsI1hRqVi+1ac26UhrgcQYBSn432BvtbkXsY/kN+qCYeicphEVJul6g/2Lm83+mrtoPBVivdcgGERz5SiNoMB8+f8ALp4/1ZCgMuglLSpSXjhgUMCzun7wrVBzxHhLXQyW+Z9CZttxg4SIGv/MPsreCKCRXTxVAwcAgU/dYWi0qwN1nlR7FSOB/M5igwHxwMJpRoZOh+ohGA8lwnmVlWkWd0h/PzvEsO2rMpNyj3tFymJayMDUOINdhxpMI91XAiTJLGVpmG8oRPQqrRRjxc50+Eu70zanbN1tsZHMopz+9OlLSz2SQV9NeYno1tMc3D7qsxWjm77nutAh/RkY/dS3EsU+w2mYsswwyX5ByGuvYRoXtN79fB4jsRvrxkqS/WLXkbqeik1Yxx76Fm3UucZc5jh/eUg7c+9v4A5TjIZLmsHgARIlk+K2vgqPr563Brvw2d6Q3vAK8KccsXKHbdhi2Q53B5Tw4uKhpzsWwZK6x8HkHVgA+r2HH2iyYBjy3GPYFI7DDrYDhnCbCZMZ2lm95290Wn/wLS/hrWjV+K+nDZZe/s9LSFHg4EQQc8oO1J0009TRXLiWAlUEaH1S2P8sxs0KUdveR6naYLZNdLt7hf53fpABHmoIpYTn+PZSK2R0zfy/bXxXFSNnU/BTkWV35DmV2pBHrHBy36xzT/t3J9Huk7jmxA8eOUeDm1HuyAnAar1ACjdAKE6mvzvuLn0skGITsexCRfw3KMESiuPW+cClhl6woH7J7L61xAl3Ami/4Qvez+ZlopChKvZdie2Fa9vLMtlTl/z91NHvrp2o47hJA4uuJ1pcvog==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR05MB7723.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(38070700005)(83380400001)(53546011)(55016003)(66556008)(7696005)(64756008)(8676002)(76116006)(66446008)(66946007)(6506007)(71200400001)(41300700001)(26005)(33656002)(66574015)(9686003)(110136005)(186003)(86362001)(316002)(122000001)(5660300002)(66476007)(8936002)(966005)(2906002)(38100700002)(52536014)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d2xocVpQcWxob2xOa2pySURUaHdjclhYanNPVXowTEVubmx6dm5BZVVQOE9G?=
 =?utf-8?B?VEh0TEFmcmw4ZnhsZFNSVUtGUTBpL1dPM0F3SXFQblhaMHR5VDZoQnBocUtW?=
 =?utf-8?B?ZFpEQU5vcCtmeHo1Y0ZTS25OZXZMMXFpV1R0Z1Z1cUZ0VFNRZWtvOTM2MlFV?=
 =?utf-8?B?NmZvdmV2d1lVVmJOWDA3WGVqUTNucXRwaFVReVYzaWFFMmtsNE5ValJadU5k?=
 =?utf-8?B?dmtWZk8vOUllTDlCUTV0eXJhUmJvS0VMcUQ3OFhoM2QxazFUMVB4WmkxRU1Z?=
 =?utf-8?B?Q2JFT2licUltQko0V0xhN1Rxall0NWtaMDl1QTZLcERCZERuRXRNR0ZzeUxG?=
 =?utf-8?B?bllVZ2RGZU5nT28ybkVyVXc4S2VJWnpwcEhXdHNtTU00MlM5bVZrUVNZMm5o?=
 =?utf-8?B?THI4UWFRUFZ0UGpPV1p5d3pUbnFhaEY2ejV4TmJmWmlEQnBvdzdtellsU3p2?=
 =?utf-8?B?eElvL25uVTl0Sjh3SGMramZudTFmenYxVzFRQmx5Ujh6L29VMWRtVlJUQ3Z2?=
 =?utf-8?B?WDdYRFFXdVFZWTNlWU4yN3YvcE9BNHlaRURzUWhDVjVaMFAvOXd6MkhIczRh?=
 =?utf-8?B?SEpMbVdQaERzOU1qN3dqS2E2OW13MjZybFhGRlJycTdIanFSbzdRMmgrV3da?=
 =?utf-8?B?K05kazl0ZjdoWTN3clFlVkZWUGxXVFlqclJLVUM4NVdFZFBGQ29mdVk0dkZX?=
 =?utf-8?B?eEhQZUF1V2h2Zm1mWlVmTkhLN1RZdzl3RmtYc0VNMzBLNUR1QmppVVJBczN1?=
 =?utf-8?B?OUtBeVpTQ2VOUVhtcUtGNXNCcnlYQlRXa0Rvekd1aXBvT0lxTDQwdkE1MTRF?=
 =?utf-8?B?WUxCb0tlamhheEhpMUhXSUU4VkFwOGY4d0tBdEx6MUhZNFJ3SEs3TTBvdUYv?=
 =?utf-8?B?U2h4N2FXV2VnVnBFcklLbGdqZHNTUlh5QmljV09WSERhajUvcms4enBnK0ZY?=
 =?utf-8?B?dEJNZXVHV2lNV3VvTzRhUTIzcjVBRC94Q2VCR0oyWUJSTU5aUkRXcEx4eWRz?=
 =?utf-8?B?TjdJNldqRjQxdXI5YjdNU2JiQ2VEZXJZeG05TTYrSmpqNFpTUmlKL1lEZFNG?=
 =?utf-8?B?RnFMcE5iR2U2eWo4UUduTXNPeE54OU5rUFBEZFZscTZzZ2o2UjR0L0VFbjRa?=
 =?utf-8?B?eVBUZTJ2LzlsSmcrRjZhcVJ4RnhxWEpyaGZrMlc5TFRhaTBwcTlhNUtUazFZ?=
 =?utf-8?B?ZTIvL2tsWWFqTHVGVlFDdnJ6M2tCN2lDK21JWlFDUE1DMHlDVDZrWlpYOEZU?=
 =?utf-8?B?eFJQTFcwbTZsd3Izd1pSaEh4eXlHWlpnWmRVdDZmRTdtaEdBa2xwWjlYOWpQ?=
 =?utf-8?B?dGwyVmxIVi9QUTdKVk92U254UHl2aHFHSmpMZGdZNU9zMEhSUy8vc2pnM1F5?=
 =?utf-8?B?bUozNTRYWHFCd1RnUnZlaVAvMjVhcDB4S1VwVFlTZkdObWNLSHU4RHo5b1Rq?=
 =?utf-8?B?WStwa0RpNTlvVzh6MnB5ckM0VE52NUJZSEl2M0NxUzRkNWlzT0dHWmpPR0VK?=
 =?utf-8?B?QWJWTGhWamdwK2xvKzBaUmcyNmMwUFNlZ0ZwdlplMExSZkJzSzhQRndmREdY?=
 =?utf-8?B?eWdCZjZLeFRDSGRUeWIwWTN5N29uTmZRK09kR2Nqam9tSGNGRFRxc0RGNC9s?=
 =?utf-8?B?aW1SRnZUd1pIcU1JSEJDc1ozam5BMUpieFN3b3J1clZwNnhmSnZMN3BNUVQ5?=
 =?utf-8?B?OGpCQy9hV0l4SncrdWFWS1VabUtMYXZ4TDZQTHNDcGVVdmZ0cVhCUjJNSmlL?=
 =?utf-8?B?TU9KeThpdE9GNC9Yd1Myb1NVR05jcWdYT2Y3SldXMWFLVnRlYTFMNkFNZk9u?=
 =?utf-8?B?SFJCRmsrUUtRQ1F5MzgwbDJ6YnlPcFRFbU0vTmc2S3BITU81SUJ4eUJqRlhO?=
 =?utf-8?B?V3pERDhLdThKdHhIYzAvN2djYU94c0tNSjdWZFF1ZFROMjU3V0c5a3ZlYlQ1?=
 =?utf-8?B?dzJkZTdUcUhEaE96NkZrN2creHgya2ZsaFJFN0c3QUY4MlNrdSsrNUU2ajA1?=
 =?utf-8?B?a2dmd1cvekVISDg1RjB6bnQ5UnpyeDEyTDM1TFcvc0hjczZjbDZVaUlWZU5O?=
 =?utf-8?B?QWg4MFRSVVR5dTU3T2pZcys5a3p2VjBaNmExTmNJbzAzWFpmakY3a0xXK2ky?=
 =?utf-8?Q?+TYIXi2dtk4YbjmPBxZLdQqFI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: andritz.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR05MB7723.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f094560-ce74-4070-d13f-08da6e1a1bf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2022 08:46:04.3590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6785298f-e857-464b-9b4b-807178402632
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kfmUzu3pL4wg7pK34rbfVQDH/xZ09WFva8ELCGIv9HXnYrFP31tucFiBOOsPnp92IWnJSdJAgcqktaNiPZ0hcb0oAkyIcaXWBoQYRJSJ2CI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4184

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFuIEtpc3prYSA8amFu
Lmtpc3prYUBzaWVtZW5zLmNvbT4NCj4gU2VudDogU2Ftc3RhZywgMjMuIEp1bGkgMjAyMiAxNjoy
OQ0KPiBUbzogTm9yYmVydCBMYW5nZSA8bm9sYW5nZTc5QGdtYWlsLmNvbT47IHhlbm9tYWlAbGlz
dHMubGludXguZGV2DQo+IENjOiBMYW5nZSBOb3JiZXJ0IDxub3JiZXJ0LmxhbmdlQGFuZHJpdHou
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBmaXggYnVpbGQgd2l0aCBjbGFuZw0KPg0KPg0K
Pg0KPiBDQVVUSU9OOiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IGNsaWNrIG9uIGxpbmtzIG9yIG9w
ZW4gYXR0YWNobWVudHMgdW5sZXNzDQo+IHlvdSBrbm93IHRoZSBzZW5kZXIgYW5kIHRoYXQgdGhl
IGNvbnRlbnQgaXMgc2FmZS4NCj4NCj4gT24gMjEuMDcuMjIgMTI6MDQsIE5vcmJlcnQgTGFuZ2Ug
d3JvdGU6DQo+ID4gY2xhbmcgd2lsbCBuZXZlciBzdXBwb3J0ICd2YXJpYWJsZSBsZW5ndGggYXJy
YXkgaW4gc3RydWN0dXJlJywgYW5kDQo+ID4gdGhlcmUgZG9lcyBub3Qgc2VlbSB0byBiZSBhIHJl
YXNvbiBmb3IgdGhpcyB3ZWlyZCBjb25zdHJ1Y3QuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBO
b3JiZXJ0IExhbmdlIDxub3JiZXJ0LmxhbmdlQGFuZHJpdHouY29tPg0KPiA+IC0tLQ0KPiA+ICB0
ZXN0c3VpdGUvc21va2V5L21lbWNoZWNrL21lbWNoZWNrLmMgfCA0ICstLS0NCj4gPiAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL3Rlc3RzdWl0ZS9zbW9rZXkvbWVtY2hlY2svbWVtY2hlY2suYw0KPiA+IGIvdGVzdHN1
aXRlL3Ntb2tleS9tZW1jaGVjay9tZW1jaGVjay5jDQo+ID4gaW5kZXggYTMzNzAwZjQ5Li5jMTJk
NjU4YTQgMTAwNjQ0DQo+ID4gLS0tIGEvdGVzdHN1aXRlL3Ntb2tleS9tZW1jaGVjay9tZW1jaGVj
ay5jDQo+ID4gKysrIGIvdGVzdHN1aXRlL3Ntb2tleS9tZW1jaGVjay9tZW1jaGVjay5jDQo+ID4g
QEAgLTgwLDkgKzgwLDcgQEAgc3RhdGljIGlubGluZSB2b2lkIHN3YXAodm9pZCAqbGVmdCwgdm9p
ZCAqcmlnaHQsDQo+ID4gY29uc3Qgc2l6ZV90IHNpemUpDQo+ID4NCj4gPiAgc3RhdGljIHZvaWQg
cmFuZG9tX3NodWZmbGUodm9pZCAqdmJhc2UsIHNpemVfdCBubWVtYiwgY29uc3Qgc2l6ZV90DQo+
ID4gc2l6ZSkgIHsNCj4gPiAtICAgICBzdHJ1Y3Qgew0KPiA+IC0gICAgICAgICAgICAgY2hhciB4
W3NpemVdOw0KPiA+IC0gICAgIH0gX19hdHRyaWJ1dGVfXygocGFja2VkKSkgKmJhc2UgPSB2YmFz
ZTsNCj4gPiArICAgICBjaGFyICpiYXNlID0gKGNoYXIgKil2YmFzZTsNCj4NCj4gSSBkb24ndCB0
aGluayB0aGF0IGlzIHRoZSBzYW1lLiBiYXNlW25dIHdpbGwgYWRkcmVzcyB0aGUgbi10aCAobWlu
dXMNCj4gb25lKSBidWZmZXIgb2YgdGhlIHNpemUgJ3NpemUnLg0KPg0KPiA+ICAgICAgIHVuc2ln
bmVkIGludCBqLCBrOw0KPiA+ICAgICAgIGRvdWJsZSB1Ow0KPiA+DQoNClRydWUsIHYyIGdlbmVy
YXRlcyB0aGUgc2FtZSBjb2RlIG5vdzogaHR0cHM6Ly9nb2Rib2x0Lm9yZy96LzFLaGFNNzlxcg0K
DQpOb3JiZXJ0DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KDQpUaGlzIG1lc3Nh
Z2UgYW5kIGFueSBhdHRhY2htZW50cyBhcmUgc29sZWx5IGZvciB0aGUgdXNlIG9mIHRoZSBpbnRl
bmRlZCByZWNpcGllbnRzLiBUaGV5IG1heSBjb250YWluIHByaXZpbGVnZWQgYW5kL29yIGNvbmZp
ZGVudGlhbCBpbmZvcm1hdGlvbiBvciBvdGhlciBpbmZvcm1hdGlvbiBwcm90ZWN0ZWQgZnJvbSBk
aXNjbG9zdXJlLiBJZiB5b3UgYXJlIG5vdCBhbiBpbnRlbmRlZCByZWNpcGllbnQsIHlvdSBhcmUg
aGVyZWJ5IG5vdGlmaWVkIHRoYXQgeW91IHJlY2VpdmVkIHRoaXMgZW1haWwgaW4gZXJyb3IgYW5k
IHRoYXQgYW55IHJldmlldywgZGlzc2VtaW5hdGlvbiwgZGlzdHJpYnV0aW9uIG9yIGNvcHlpbmcg
b2YgdGhpcyBlbWFpbCBhbmQgYW55IGF0dGFjaG1lbnQgaXMgc3RyaWN0bHkgcHJvaGliaXRlZC4g
SWYgeW91IGhhdmUgcmVjZWl2ZWQgdGhpcyBlbWFpbCBpbiBlcnJvciwgcGxlYXNlIGNvbnRhY3Qg
dGhlIHNlbmRlciBhbmQgZGVsZXRlIHRoZSBtZXNzYWdlIGFuZCBhbnkgYXR0YWNobWVudCBmcm9t
IHlvdXIgc3lzdGVtLg0KDQpBTkRSSVRaIEhZRFJPIEdtYkgNCg0KDQpSZWNodHNmb3JtLyBMZWdh
bCBmb3JtOiBHZXNlbGxzY2hhZnQgbWl0IGJlc2NocsOkbmt0ZXIgSGFmdHVuZyAvIENvcnBvcmF0
aW9uDQoNCkZpcm1lbnNpdHovIFJlZ2lzdGVyZWQgc2VhdDogV2llbg0KDQpGaXJtZW5idWNoZ2Vy
aWNodC8gQ291cnQgb2YgcmVnaXN0cnk6IEhhbmRlbHNnZXJpY2h0IFdpZW4NCg0KRmlybWVuYnVj
aG51bW1lci8gQ29tcGFueSByZWdpc3RyYXRpb246IEZOIDYxODMzIGcNCg0KRFZSOiAwNjA1MDc3
DQoNClVJRC1Oci46IEFUVTE0NzU2ODA2DQoNCg0KVGhhbmsgWW91DQpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXw0K
