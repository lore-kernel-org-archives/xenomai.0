Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36162F5A
	for <xenomai@lists.linux.dev>; Tue,  5 Jul 2022 11:16:28 +0000 (UTC)
Received: from spool.mail.gandi.net (spool3.mail.gandi.net [217.70.178.212])
	by relay.mail.gandi.net (Postfix) with ESMTPS id D2C57240002
	for <xenomai@lists.linux.dev>; Tue,  5 Jul 2022 11:16:26 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
	by spool.mail.gandi.net (Postfix) with ESMTPS id CD9E9AC0B2B
	for <xenomai@xenomai.org>; Tue,  5 Jul 2022 11:16:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqHCxNGMRNnfPwUwWgSEXh/+VzhaJLcEsgRd4FSEu/p3uK075LwIUcwB6xTM1GBR3eKwOur80q+2Fi6Pu6CggypJyrJ7ppV01qPIJKJJio2euxC/9ekCJi5POaMmEAG4HU9guQ7dYNAiLMHsDQ3nHUyOdKirKLt01yd7tjvhPEV9fJMFPLLE3kwqVnkGwZ8CLCIKSVy1/H3fpYZsa6817MpwkCG9mYdhJSeQkc+GCx465PU3CJgo3sjefFHDoRWNdIgc7gq6Mcrek66IOMxNZ6qrT5cXE0kRIw7Fy7Y3fEnxrxK7jWH16QVZbflIl6Lf8Qi6CEq7Qxk3xTy5Io5qiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3jQpioERj779RJEm9xG7B8NpL6illEKRxB9tCx7TsIU=;
 b=Xq2zM6pq1FMA0cpkaEFPwNiL8FWnlhb5MNdqjkfw7nKPU8rUHZz8X6NQiq4fZVu9DOQ3uuISbyMjMV/fFPbAVK96rPr1WhecCVLI87pGw0Ppg0TDAq6txCnIbMINBbRYtKHinz3nOGj9cQBb+uhrdGSCdFEqVSwSIK5HITSMZ8BNSYRkbKKQFEhWR72J49AwCuNxJe76XHa5IhXjf85wX8BHf+8qD+a8EU7s3eMbz8XyqH87KSXuBJPVSWq1fOvnIzteThy5Nz6CLbGeUKgzubRtWLysbmkrnPr+36FFn90QUy/b0D6gh/y8utK1ph6K75HoKDn57gQzuwKREcdMLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jQpioERj779RJEm9xG7B8NpL6illEKRxB9tCx7TsIU=;
 b=KBEFnZRE2bZdzCT7PeTkMAa/B08LgRTC3ifBARlQCFG64Bp7Tt746vwOtEpLUKobNQGhcdCFx+J4oiOqLOguEOMau50EPOb3HpgwaiYG+OKGe+kyY+AwTRC01/Vk8Kx8MQ3uAXWhD+k+SXD1VOqy2Tnn2hLtzvG0oJ6edEtdlAO/OMGhP9lehUvR0SwXx1uhE0wPpdps7uYoQWkQk9yPdBdsS91D1AiO5mAZEDSN5ff9153CvsA9PkXLU13okRBRLDEGeq7LmUiz+YTfJUZQb7kzVK6CtnyG6KPmqW2C+yh1XyDdhgrz7QGUft0VYZQaAjBmTljMzeY11m9t5ukR8Q==
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB7PR10MB2364.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.19; Tue, 5 Jul
 2022 11:16:24 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::31fa:3b8c:f022:4ac4]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::31fa:3b8c:f022:4ac4%4]) with mapi id 15.20.5395.020; Tue, 5 Jul 2022
 11:16:24 +0000
From: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>, "jan.kiszka@siemens.com"
	<jan.kiszka@siemens.com>
CC: "gunter.grau@philips.com" <gunter.grau@philips.com>
Subject: Re: [PATCH 05/15] drivers/net: Switch to dev_addr_set
Thread-Topic: [PATCH 05/15] drivers/net: Switch to dev_addr_set
Thread-Index: AQHYj6dIF5BpXiXHPEqAcW1RxWvyKq1uRpmAgAFA5oCAABqDgA==
Date: Tue, 5 Jul 2022 11:16:24 +0000
Message-ID: <83bb43a9f69b7a4e211543050ef3cb60d22df94b.camel@siemens.com>
References: <cover.1656940114.git.jan.kiszka@siemens.com>
	 <fed48b9dd1275fd788bbbc3571608b07b88d681e.1656940114.git.jan.kiszka@siemens.com>
	 <3bc48f68be16235291bae284fb438ec25b7679f4.camel@siemens.com>
	 <a271d367-615c-16f3-ad71-20ae107bc6aa@siemens.com>
In-Reply-To: <a271d367-615c-16f3-ad71-20ae107bc6aa@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.2 (3.44.2-1.fc36) 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1e3c373-cbb5-48c8-5990-08da5e77cbf1
x-ms-traffictypediagnostic: DB7PR10MB2364:EE_
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 8ERuHPitrMVmhehOB8SBeCW4DbuzlWaZ2bZRaN+pWC6QHMnl3eukXplC2nn17Ej+8ABMHwvaCt1/quJUtFyG9AhoMTkg3CfUQlwyDgMqPVPLOd9qP2EyS5lovGaaB8h8Zkd80jnpMU1MWdjNaJ9LIXjQBaynaATMuEsykuY+p0B/GeDmUGTLkQqivonY6wfxu+lw4mbFseK149YVolxhgL1AJQO4JrjftEufF5mih53k2eH17cgt2JBWp6zxcdLmBSZmFqkoy7v5lBFIvigXN300FR9WlIO9X2Xab/NoLxdisIt4QnrzwFcNDb4HDYuPn4io+J/+3xLADkPTXr7cQEdIqeO6SfJDpXs8CpudtzVcafY5Mr8f7Vx+qIJobA27WzIg+lmVSPTTWsoy1mObkxMKfGTEX8+UYCrVG2sOdf9hAqi4PsZFDm9AS8PgAhuxdJ/sRcOLAEUP1IGU2bWfyinIVGdSs/MRMMdsOcEugSmB6dz1UCT0mBbc50BgatGSQtJaD/P/RUON6Mg5DvLe7OpWwbpOt2UKJ1n9INEffjxFEGUtCu+r9rtr7KPgFZqdzg/m5UIguIJ98q5f9bLJXqmm1Nj96/BOYWhZ6dBqIlRsoslyC1A/5H2Sao8uO9F7aXGjagsH8nDe+7bU4CCs+d8Q/qNu0wSgawESpD4PKvCH8jHo5cbZFGq0NMlcaJzF7is/vkpp50LMzArZU8v/EFVwu0AbEwjaXbwqDH5lEbtzKxYU/yPLNDBynJhajV3T4expiPC7bMm8ofYR6NmIH+sxpHb3iMhIVByrFWkzsUCK4mk8gSwp2Jli3Gdl9/BB
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(6506007)(41300700001)(6512007)(66446008)(186003)(53546011)(83380400001)(5660300002)(478600001)(2616005)(86362001)(8936002)(2906002)(82960400001)(6486002)(8676002)(110136005)(38100700002)(316002)(4326008)(76116006)(122000001)(66476007)(66556008)(71200400001)(38070700005)(66946007)(36756003)(91956017)(6636002)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a002TEtTbTNVK2dDUHhGZ2xQdXhubGg1UVptNld1VWo2UHh3amd3NnhQTm5j?=
 =?utf-8?B?OG0yU1R1dGdzcjFCTG1KYldPMkZSUUxmRkdHZUJHSWFKc3MrRjNSdnU3bTVO?=
 =?utf-8?B?QTM4MEIrQlZLcnhwVHBHSnRTdUcvZFlUL0gvLzNVOXgrVDFtRitQSWkyY0cw?=
 =?utf-8?B?NXZ4cVk5bVRPVVFhMmtDZ2xyT3ViT2hlUVVsRTVBYTZhVFRJWUVsalhzNHp0?=
 =?utf-8?B?TkZ4dUpCS1duakc1ZVF2cy9OREZVV2srOTh1REpNRllqUFRyMVpCcHgzN2o2?=
 =?utf-8?B?Y3c0Q3phV0lSWmdFd0pML1ZWVFcvMjR6WVdybHYzSlhyYXdIenJkRG15SXZl?=
 =?utf-8?B?cFVlL2dRenU1MHJkZUx5V3B5RGxjdGp2Q2xwVE01dVVFVHdpMms3b08xZ3VZ?=
 =?utf-8?B?WlViQ28xU0h3MSs2WEh3WWs2VkQvY0RwQ1RiNlRkYUZielFIY2E0ZTdPNnhI?=
 =?utf-8?B?OXp5RUNpVHQrbXdSWXpEMkgyZXd3NHB0MzZGZWJTWGhpRVFBN2JWQnNpcVNk?=
 =?utf-8?B?SUY1WEIwbVU0WVUxSEovVGtDZzBvdnJVMnhsUnFmb2tmSXhWa0lvL2RJVGRI?=
 =?utf-8?B?VkJ3OFVwMnRmU1NrWTE0VHpudmptR0dtNnJyV3VnQnRtalNzOFNSZnh0ZEJF?=
 =?utf-8?B?QjNPaWdLODBGeWVzK2hHbDZzSm52bkl6enFxcnY3Um91ZmRkOE9nQlM0RDIv?=
 =?utf-8?B?cDFlWm1xbmUrQWpsUU41TTlySnptbXdsVDVWRkNHNmlsSGU2MEdXOTBuNUg3?=
 =?utf-8?B?ZTBSSlpIeFBwUFNKWDViV3YrQUFqZzY5Ukx3S1R5cnBOamdnRmg1cHppclZn?=
 =?utf-8?B?c0tMN0oxbkZGNlRCQUt6bGExMGF0VHUyRmhsMXVTVW1wakJhVlpyblRyaHBB?=
 =?utf-8?B?UVFmVTE4ekM1VnFwbkpwMWxkVjVxMDA2ejNKNFpGSXl1b01sdGFYTnlnNHdz?=
 =?utf-8?B?aWl1cy9rQkdiZHo3cmgrSnl5R2NHZTY0ZTlZZk9uN1lqQm9sUzFKQ2xjWWlL?=
 =?utf-8?B?Nk1PWW80UXFVVHlCMkFpTFJpOTgrZWt6R09tcG1ENEcwYmlpWkoxcm9NeG9F?=
 =?utf-8?B?bjlEeGpucS9yOWdONzBEeS9BQ3IySkR2clNWTWxEeU1tSGVpVWxIQXBpNGpa?=
 =?utf-8?B?bFNpSUJvdHhwQ2ZzdmJGNWRqeUhwbnZ0SGlWS2ZPa1hDUXcyTHk1QkhnOXFJ?=
 =?utf-8?B?cFIzM1RBa0p2MXBBZWtibWd4UkhUaEFmYkVjRllVTi9ncTlJWkFUT3FhdWI2?=
 =?utf-8?B?cjhSalFuOVJ4S0loOTFpZkZjeTFrbGFDZmZ5eUJqUXNWeGI1YlQ1dENicXlo?=
 =?utf-8?B?SmlCN0QvSUloR29RZHVVQlhRclExZUFVSWhoaU1iT1hwV3p5MFBWeGJzN1Fi?=
 =?utf-8?B?ODRFdGN4K1ZFOWZMSUhFMEpCcCtvSnk4TGFVWEhIQk4vNWgrbGNxM0xmQzJs?=
 =?utf-8?B?SHkzbWQ1eTg4aVBVak9DTlgweHI4QUtseFhvQ212UzYrMkVHY2VBcjg5VUVv?=
 =?utf-8?B?Y0dNSzJ2WmY2dWRxREc4OFdVdnQ4YzNGTVg4N2I0cU5xNTl4UnNtRWVOQVRF?=
 =?utf-8?B?NHNobTlLZitBbVBjZ1pKWG9yaFlxdTBQSWZQZXZYR01NdWlqZjdlMzREUG16?=
 =?utf-8?B?QWlxVVM1UG5pd092Z3VRdDN1bDZiRzNXWmt0L29aRWM4ZW4yc2srRVFQaHh1?=
 =?utf-8?B?Qkx1ck13bkxKamFFRHlDYTc3VTY0cjhDZEM2azBSb3huUDI0cmxUbWRZU2xT?=
 =?utf-8?B?SG5zNVlKS0ZmYlB5Mnk0czFLNU1iT1J4WWkzaFYzN2MxaTVWZ3lnV1d6RzZN?=
 =?utf-8?B?bHRoMjRVV2Y3ak9NWloyQkVGOEhxd2Fyc2MwZFhIdWlrYUVLRGtWaHYvV3d0?=
 =?utf-8?B?TzlUVklNdW55VjhxbXZidSs4QlNwSE5hOHFsWStYTFBsRnM0VWx1WWtCMzdH?=
 =?utf-8?B?eVhORDdodDhDVWFzdlVpb0dBRVY1TU9xZzlUM3N2QU9WcUp6aFZ2UEE0aUMx?=
 =?utf-8?B?TUduRWVYUWVXc1Yzb1ZxakprY2hMRDZXajVqUXRYaUlVNEcxRC9wTHFrckJW?=
 =?utf-8?B?SUVEQkp5cjZHM2N4UUt2eDdaeXczckMvOG9XbWZ2bi9tTmNlR0MwWU1hUzNm?=
 =?utf-8?B?SmxvUWdvWVB5WTVrTzhRTU1oczMxNDEyTHRGUVVsazdaR0lsdVI3aTB2Q0xT?=
 =?utf-8?B?SEF4ZFRvekV2YmJOT0RhbTR1TmpvOWU0YmFyVmdScDlXLzBLNjdPMEV6VU1N?=
 =?utf-8?B?ZW84ZHR4S01jWG5aakFqYis0eHl3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5571EA27B09F644ABE91CF48121497CB@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e3c373-cbb5-48c8-5990-08da5e77cbf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 11:16:24.1744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mVD/HBaBH4JvNBbVd8Sa0QJxGvva+3sbJawrc09bGGdKk9CQpBxs1qpnqTdrNP24RBvwBOjtTM6PPPrvk5ir/27b27iT5KO/oHaliQxNTwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB2364
Received-SPF: pass (spool3: domain of siemens.com designates 40.107.22.40 as permitted sender) client-ip=40.107.22.40; envelope-from=florian.bezdeka@siemens.com; helo=EUR05-AM6-obe.outbound.protection.outlook.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=KBEFnZRE;
	dmarc=pass (policy=none) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of florian.bezdeka@siemens.com designates 40.107.22.40 as permitted sender) smtp.mailfrom=florian.bezdeka@siemens.com;
	arc=pass ("microsoft.com:s=arcselector9901:i=1")

T24gVHVlLCAyMDIyLTA3LTA1IGF0IDExOjQxICswMjAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAwNC4wNy4yMiAxNjozMiwgQmV6ZGVrYSwgRmxvcmlhbiAoVCBDRUQgU0VTLURFKSB3cm90ZToN
Cj4gPiBPbiBNb24sIDIwMjItMDctMDQgYXQgMTU6MDggKzAyMDAsIEphbiBLaXN6a2Egd3JvdGU6
DQo+ID4gPiBGcm9tOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPiA+ID4g
DQo+ID4gPiBMYXRlc3Qga2VybmVsIGNvbXBsYWluIGFib3V0IGFjY2Vzc2luZyBkZXZfYWRkciBk
aXJlY3RseSBhbmQgcHVzaCB1cw0KPiA+ID4gdG93YXJkIHRoZSBhY2Nlc3NvciBmdW5jdGlvbnMu
IFVzZSB0aGF0IGFuZCBwcm92aWRlIGEgd3JhcHBlciBmb3INCj4gPiA+IGtlcm5lbHMgcHJpb3Ig
dG8gNS4xNS4NCj4gPiA+IA0KPiA+ID4gQ0M6IEd1bnRlciBHcmF1IDxndW50ZXIuZ3JhdUBwaGls
aXBzLmNvbT4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2ll
bWVucy5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBrZXJuZWwvY29iYWx0L2luY2x1ZGUvYXNtLWdl
bmVyaWMveGVub21haS93cmFwcGVycy5oIHwgIDQgKysrKw0KPiA+ID4gIGtlcm5lbC9kcml2ZXJz
L25ldC9hZGRvbnMvY2FwLmMgICAgICAgICAgICAgICAgICAgICAgfCAgNSArKy0tLQ0KPiA+ID4g
IGtlcm5lbC9kcml2ZXJzL25ldC9hZGRvbnMvcHJveHkuYyAgICAgICAgICAgICAgICAgICAgfCAg
MiArLQ0KPiA+ID4gIGtlcm5lbC9kcml2ZXJzL25ldC9kcml2ZXJzL2ZyZWVzY2FsZS9mZWNfbWFp
bi5jICAgICAgfCAxMSArKysrKysrLS0tLQ0KPiA+ID4gIGtlcm5lbC9kcml2ZXJzL25ldC9zdGFj
ay9ydG1hYy9ydG1hY192bmljLmMgICAgICAgICAgfCAgNSArKy0tLQ0KPiA+ID4gIDUgZmlsZXMg
Y2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQo+ID4gPiANCj4gPiA+
IGRpZmYgLS1naXQgYS9rZXJuZWwvY29iYWx0L2luY2x1ZGUvYXNtLWdlbmVyaWMveGVub21haS93
cmFwcGVycy5oIGIva2VybmVsL2NvYmFsdC9pbmNsdWRlL2FzbS1nZW5lcmljL3hlbm9tYWkvd3Jh
cHBlcnMuaA0KPiA+ID4gaW5kZXggODgxNTJhMjVlMS4uNjQ4OWM4MmM4YyAxMDA2NDQNCj4gPiA+
IC0tLSBhL2tlcm5lbC9jb2JhbHQvaW5jbHVkZS9hc20tZ2VuZXJpYy94ZW5vbWFpL3dyYXBwZXJz
LmgNCj4gPiA+ICsrKyBiL2tlcm5lbC9jb2JhbHQvaW5jbHVkZS9hc20tZ2VuZXJpYy94ZW5vbWFp
L3dyYXBwZXJzLmgNCj4gPiA+IEBAIC01NCw2ICs1NCwxMCBAQA0KPiA+ID4gICNkZWZpbmUgY2xv
c2VfZmQoX191ZmQpICAgICAgX19jbG9zZV9mZChjdXJyZW50LT5maWxlcywgX191ZmQpDQo+ID4g
PiAgI2VuZGlmDQo+ID4gPiANCj4gPiA+ICsjaWYgTElOVVhfVkVSU0lPTl9DT0RFIDwgS0VSTkVM
X1ZFUlNJT04oNSwxNSwwKQ0KPiA+ID4gKyNkZWZpbmUgZGV2X2FkZHJfc2V0KGRldiwgYWRkcikg
ICAgICBtZW1jcHkoKGRldiktPmRldl9hZGRyLCBhZGRyLCBNQVhfQUREUl9MRU4pDQo+ID4gPiAr
I2VuZGlmDQo+ID4gPiArDQo+ID4gPiAgI2lmIExJTlVYX1ZFUlNJT05fQ09ERSA8IEtFUk5FTF9W
RVJTSU9OKDUsMTcsMCkNCj4gPiA+ICAjZGVmaW5lIHBkZV9kYXRhKGkpICBQREVfREFUQShpKQ0K
PiA+ID4gICNlbmRpZg0KPiA+ID4gZGlmZiAtLWdpdCBhL2tlcm5lbC9kcml2ZXJzL25ldC9hZGRv
bnMvY2FwLmMgYi9rZXJuZWwvZHJpdmVycy9uZXQvYWRkb25zL2NhcC5jDQo+ID4gPiBpbmRleCAx
ZTg2NDQwNjk5Li4zNzg0YjY1MjI2IDEwMDY0NA0KPiA+ID4gLS0tIGEva2VybmVsL2RyaXZlcnMv
bmV0L2FkZG9ucy9jYXAuYw0KPiA+ID4gKysrIGIva2VybmVsL2RyaXZlcnMvbmV0L2FkZG9ucy9j
YXAuYw0KPiA+ID4gQEAgLTI2Myw5ICsyNjMsOCBAQCBzdGF0aWMgaW50IHRhcF9kZXZfb3Blbihz
dHJ1Y3QgbmV0X2RldmljZSAqZGV2KQ0KPiA+ID4gICAgICAgaWYgKGVyciA9PSAwKQ0KPiA+ID4g
ICAgICAgICAgICAgICByZXR1cm4gLUVJRFJNOw0KPiA+ID4gDQo+ID4gPiAtICAgICBtZW1jcHko
ZGV2LT5kZXZfYWRkciwNCj4gPiA+IC0gICAgICAgICAgICAoKihzdHJ1Y3QgcnRuZXRfZGV2aWNl
ICoqKW5ldGRldl9wcml2KGRldikpLT5kZXZfYWRkciwNCj4gPiA+IC0gICAgICAgICAgICBNQVhf
QUREUl9MRU4pOw0KPiA+ID4gKyAgICAgZGV2X2FkZHJfc2V0KGRldiwNCj4gPiA+ICsgICAgICAg
ICAgICAgICAgICAoKihzdHJ1Y3QgcnRuZXRfZGV2aWNlICoqKW5ldGRldl9wcml2KGRldikpLT5k
ZXZfYWRkcik7DQo+ID4gPiANCj4gPiA+ICAgICAgIHJldHVybiAwOw0KPiA+ID4gIH0NCj4gPiA+
IGRpZmYgLS1naXQgYS9rZXJuZWwvZHJpdmVycy9uZXQvYWRkb25zL3Byb3h5LmMgYi9rZXJuZWwv
ZHJpdmVycy9uZXQvYWRkb25zL3Byb3h5LmMNCj4gPiA+IGluZGV4IGY3MDU4NzY3OGEuLmIzN2I0
MmM5ZGUgMTAwNjQ0DQo+ID4gPiAtLS0gYS9rZXJuZWwvZHJpdmVycy9uZXQvYWRkb25zL3Byb3h5
LmMNCj4gPiA+ICsrKyBiL2tlcm5lbC9kcml2ZXJzL25ldC9hZGRvbnMvcHJveHkuYw0KPiA+ID4g
QEAgLTMyMSw3ICszMjEsNyBAQCBzdGF0aWMgdm9pZCBfX2luaXQgcnRuZXRwcm94eV9pbml0KHN0
cnVjdCBuZXRfZGV2aWNlICpkZXYpDQo+ID4gPiANCj4gPiA+ICAgICAgIGRldi0+dHhfcXVldWVf
bGVuID0gMDsNCj4gPiA+ICAjaWZkZWYgQ09ORklHX1hFTk9fRFJJVkVSU19ORVRfQURET05fUFJP
WFlfQVJQDQo+ID4gPiAtICAgICBtZW1jcHkoZGV2LT5kZXZfYWRkciwgcnRuZXRwcm94eV9ydGRl
di0+ZGV2X2FkZHIsIE1BWF9BRERSX0xFTik7DQo+ID4gPiArICAgICBkZXZfYWRkcl9zZXQoZGV2
LCBydG5ldHByb3h5X3J0ZGV2LT5kZXZfYWRkcik7DQo+ID4gPiAgI2Vsc2UNCj4gPiA+ICAgICAg
IGRldi0+ZmxhZ3MgfD0gSUZGX05PQVJQOw0KPiA+ID4gICNlbmRpZg0KPiA+ID4gZGlmZiAtLWdp
dCBhL2tlcm5lbC9kcml2ZXJzL25ldC9kcml2ZXJzL2ZyZWVzY2FsZS9mZWNfbWFpbi5jIGIva2Vy
bmVsL2RyaXZlcnMvbmV0L2RyaXZlcnMvZnJlZXNjYWxlL2ZlY19tYWluLmMNCj4gPiA+IGluZGV4
IGJlMGVkMGM1MWUuLjcyZWU0ZGU3MzggMTAwNjQ0DQo+ID4gPiAtLS0gYS9rZXJuZWwvZHJpdmVy
cy9uZXQvZHJpdmVycy9mcmVlc2NhbGUvZmVjX21haW4uYw0KPiA+ID4gKysrIGIva2VybmVsL2Ry
aXZlcnMvbmV0L2RyaXZlcnMvZnJlZXNjYWxlL2ZlY19tYWluLmMNCj4gPiA+IEBAIC0xMzE1LDEx
ICsxMzE1LDE0IEBAIHN0YXRpYyB2b2lkIGZlY19nZXRfbWFjKHN0cnVjdCBuZXRfZGV2aWNlICpu
ZGV2KQ0KPiA+ID4gICAgICAgICAgICAgICByZXR1cm47DQo+ID4gPiAgICAgICB9DQo+ID4gPiAN
Cj4gPiA+IC0gICAgIG1lbWNweShuZGV2LT5kZXZfYWRkciwgaWFwLCBFVEhfQUxFTik7DQo+ID4g
PiAtDQo+ID4gPiAgICAgICAvKiBBZGp1c3QgTUFDIGlmIHVzaW5nIG1hY2FkZHIgKi8NCj4gPiA+
IC0gICAgIGlmIChpYXAgPT0gbWFjYWRkcikNCj4gPiA+IC0gICAgICAgICAgICAgIG5kZXYtPmRl
dl9hZGRyW0VUSF9BTEVOLTFdID0gbWFjYWRkcltFVEhfQUxFTi0xXSArIGZlcC0+ZGV2X2lkOw0K
PiA+ID4gKyAgICAgaWYgKGlhcCA9PSBtYWNhZGRyKSB7DQo+ID4gPiArICAgICAgICAgICAgIG1l
bWNweSh0bXBhZGRyLCBtYWNhZGRyLCBFVEhfQUxFTik7DQo+ID4gPiArICAgICAgICAgICAgIHRt
cGFkZHJbRVRIX0FMRU4tMV0gKz0gZmVwLT5kZXZfaWQ7DQo+ID4gPiArICAgICAgICAgICAgIGRl
dl9hZGRyX3NldChuZGV2LCB0bXBhZGRyKTsNCj4gPiANCj4gPiBPbmUgbW9yZSB0aGluZyBoZXJl
Og0KPiA+IA0KPiA+IGRldl9hZGRyX3NldCB3aGVuIGF2YWlsYWJsZSBpbnNpZGUgdGhlIGtlcm5l
bCB1c2VzIG5kZXYtPmFkZHJfbGVuIGZvcg0KPiA+IHBlcmZvcm1pbmcgdGhlIG1lbWNweS4gRG8g
d2UgZXZlciBzZXQgbmRldi0+YWRkcl9sZW4/DQo+IA0KPiBIbW0sIEkgd291bGQgaGF2ZSBleHBl
Y3RlZCB0aGlzIHRvIGJlIGluaXRpYWxpemVkIG9uIGRldmljZSBjcmVhdGlvbiwNCj4gYnV0IGl0
IHNlZW1zIG5vdC4NCj4gDQo+IFNlZW1zIHRoZSBiZXR0ZXIgYW5zd2VyIGlzIHRvIHVzZSBldGhf
aHdfYWRkcl9zZXQgLSB3aGljaCBoYXJkLWNvZGVzDQo+IEVUSF9BTEVOIGFzIGxlbmd0aC4NCg0K
U291bmRzIHJlYXNvbmFibGUuIEkgYXNzdW1lIHRoZSBleHBlY3RhdGlvbiBpcyB0byBzZXQgbmRl
di0+YWRkciBhbmQNCm5kZXYtPmFkZHJfbGVuIGF0IHRoZSBzYW1lIHRpbWUuIE5vIGlkZWEgd2hp
Y2ggQVBJIHRvIGNob29zZS4NCg0KUG9zc2liaWxpdGllcyBJIGtub3cgb2Y6DQotIGRldl9hZGRy
X3NldA0KLSBkZXZfYWRkcl9tb2QNCi0gZXRoX2h3X2FkZHJfc2V0DQoNCj4gDQo+IEphbg0KPiAN
Cj4gPiANCj4gPiA+ICsgICAgIH0gZWxzZSB7DQo+ID4gPiArICAgICAgICAgICAgIGRldl9hZGRy
X3NldChuZGV2LCBpYXApOw0KPiA+ID4gKyAgICAgfQ0KPiA+ID4gIH0NCj4gPiA+IA0KPiA+ID4g
IC8qIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0gKi8NCj4gPiA+IGRpZmYgLS1naXQgYS9rZXJuZWwvZHJpdmVy
cy9uZXQvc3RhY2svcnRtYWMvcnRtYWNfdm5pYy5jIGIva2VybmVsL2RyaXZlcnMvbmV0L3N0YWNr
L3J0bWFjL3J0bWFjX3ZuaWMuYw0KPiA+ID4gaW5kZXggMTM4ZTI3NmFkOS4uNGI0MTc4NWRiOCAx
MDA2NDQNCj4gPiA+IC0tLSBhL2tlcm5lbC9kcml2ZXJzL25ldC9zdGFjay9ydG1hYy9ydG1hY192
bmljLmMNCj4gPiA+ICsrKyBiL2tlcm5lbC9kcml2ZXJzL25ldC9zdGFjay9ydG1hYy9ydG1hY192
bmljLmMNCj4gPiA+IEBAIC0xMTQsOSArMTE0LDggQEAgc3RhdGljIHZvaWQgcnRtYWNfdm5pY19z
aWduYWxfaGFuZGxlcihydGRtX25ydHNpZ190ICpucnRzaWcsIHZvaWQgKmFyZykNCj4gPiA+IA0K
PiA+ID4gIHN0YXRpYyBpbnQgcnRtYWNfdm5pY19jb3B5X21hYyhzdHJ1Y3QgbmV0X2RldmljZSAq
ZGV2KQ0KPiA+ID4gIHsNCj4gPiA+IC0gICAgIG1lbWNweShkZXYtPmRldl9hZGRyLA0KPiA+ID4g
LSAgICAgICAgICAgICgqKHN0cnVjdCBydG5ldF9kZXZpY2UgKiopbmV0ZGV2X3ByaXYoZGV2KSkt
PmRldl9hZGRyLA0KPiA+ID4gLSAgICAgICAgICAgIE1BWF9BRERSX0xFTik7DQo+ID4gPiArICAg
ICBkZXZfYWRkcl9zZXQoZGV2LA0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICgqKHN0cnVjdCBy
dG5ldF9kZXZpY2UgKiopbmV0ZGV2X3ByaXYoZGV2KSktPmRldl9hZGRyKTsNCj4gPiA+IA0KPiA+
ID4gICAgICAgcmV0dXJuIDA7DQo+ID4gPiAgfQ0KPiA+IA0KPiANCj4gDQoNCg==
