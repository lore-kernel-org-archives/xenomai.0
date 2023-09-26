Received: from KOR01-SL2-obe.outbound.protection.outlook.com (mail-sl2kor01on2078.outbound.protection.outlook.com [40.107.129.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9584FEC5
	for <xenomai@lists.linux.dev>; Tue, 26 Sep 2023 06:36:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EwCiezA0dj1W2AMJ4h0g1PZnSku+uT+ioiFwdN97tyoTyQ8IlIZbwtzl8BRVxd4JpkWm+vRkFgxZYzoEH5UfRNv6GY6QY0zzXK3wDvcOJKetoQjCWw1szGQIA1qmBmG2JRzMimpLVR0lZm5hFBXzioQYsZnET3LZpn4jE9M3IW4v8UQA3P5IKrEaF6hXnlQ910a/GPJAjIl9qL6E7jlwPC9TkFRhF450UXXEbLb5aQwTsoqCCco4yvYDTBy0fc9DP6Szeatvh6FjhxNpDc7dwLCLhmbA4VzmTFXqqqKYPPA/M8siQORL6SQ7ihh+o7j2bKjJ8MP+qv+biTiCbbI3DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FU708CiSLL1SrIItivgqYeGix7IY72J//LhoIeSLbdI=;
 b=WI9Cibp8w8+wYP9ywQ4crT6D4j8GvNZEgkqpG2aey2JTIZlG0Dg7bpwXp3FbxiCfc3kHAiWWKzVxm7kixetJ9TQkYqwqgbWgsG/lYKUt/F0nvZAzXxDW3iaLxjLplPxUL/Xa4ZKCIsUZuEQBmr5AezK6NWs1gGfxft4s9FwpL67LIfj/YGpWeGwnGpQf2Q+js4U1Ss4+uGlJKe3cAiMVGGmFxuXpPlJawySErwHJrvtA2Lm7vdUDcYla/x/bN5rVSTJAA/6fMVsC/kzYDetPDKaa1A8I6f8HF7OfdUXIvOfO9prA9XtRk7HhorDRMRnEu11iyaad1zPk6cSzUUbOKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=doosan.com; dmarc=pass action=none header.from=doosan.com;
 dkim=pass header.d=doosan.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Doosan.onmicrosoft.com; s=selector1-Doosan-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FU708CiSLL1SrIItivgqYeGix7IY72J//LhoIeSLbdI=;
 b=17so7oz64LD0eK8x0omXyLFNXGxteWqYP5ozzNYBePRv4PPaW5rfXYw7vWppp0LBGnW6iDntKfBmiKotwkkNfWiklogFqDyiXwXoZS3kXpqrAOaowsujZBIpcU/NJ6CIp99bTbZr8k8vARHmqVz7HZzwWFDo0FfCPsdjqhubvXE=
Received: from PS2P216MB1330.KORP216.PROD.OUTLOOK.COM (2603:1096:301:a0::13)
 by PU4P216MB1808.KORP216.PROD.OUTLOOK.COM (2603:1096:301:10a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 06:35:57 +0000
Received: from PS2P216MB1330.KORP216.PROD.OUTLOOK.COM
 ([fe80::9fa6:9f51:bc2:66eb]) by PS2P216MB1330.KORP216.PROD.OUTLOOK.COM
 ([fe80::9fa6:9f51:bc2:66eb%6]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 06:35:57 +0000
From: =?utf-8?B?67CV6rK97ZuIKEt5dW5naG9vbiBQYXJrKSDsiJjshJ0g65GQ7IKw66Gc67O0?=
 =?utf-8?B?7Yux7Iqk?= <kyunghoon2.park@doosan.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Shell command segfault occurrence phenomenon when xenomai task
 switching running
Thread-Topic: Shell command segfault occurrence phenomenon when xenomai task
 switching running
Thread-Index: AQHZ8Dvh6PD2J1eeWE61B2j5eRG+6bAsl5qAgAAOhXA=
Date: Tue, 26 Sep 2023 06:35:57 +0000
Message-ID:
 <PS2P216MB13303939F1828F55FF296B3AD1C3A@PS2P216MB1330.KORP216.PROD.OUTLOOK.COM>
References: <1695706251-3997-mlmmj-62db5be2@lists.linux.dev>
 <PS2P216MB13306DDFC18190667DEE0409D1C3A@PS2P216MB1330.KORP216.PROD.OUTLOOK.COM>
 <49968ea8-1651-4bf0-bdd5-b3e3dbe252b0@siemens.com>
In-Reply-To: <49968ea8-1651-4bf0-bdd5-b3e3dbe252b0@siemens.com>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=doosan.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PS2P216MB1330:EE_|PU4P216MB1808:EE_
x-ms-office365-filtering-correlation-id: fde5e8be-afdb-4160-0a99-08dbbe5ad79f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 v71zBNZ7xMqSM8yAjm93qIn71S/ZAWG5+o2k1hQfix+ZqbLnP+mE6G5TnbC3/CoeqjHJMFbMIcmuzdTfUgbxBv+bYHUSeJ9couYrwB69V5UjJHqLV8gO2N7ftZnWxuMykrgVcyH/te/8PJSyH9CWii0MuJs9cfE7fhv4wsuAo6TFH3TGNId6ecCHtRCjO/d0UFQtAe7ZBesmtv122UEhY99V5kjfPMVOkNvG4PPSwm6El5D7NvQoQCgN87W8HvunHzXS1UYxGOeUMF8QdXdd23RL3bqoLtF5elcBt1jJ4+BEZNMvhEkJftHpv0acJmRldIiCH2O6iiHHvkm/q2lVOzBQf8+QGAv1agIo4JxTHtsbI6TAy/+rss0isX9EqLXa6Pu3t27tvOWZB2ElbdRYD5VjgVr1z98WfCFNcGLOm6coBszwe+zIi+nouZgkuOuoDNJsh3qZgmfKme5fTWY2p52K2roV4V6vvxAqYwaJ62Rxx7ViVxAvYbFdh8P5PmKPSrBRcaYm2ZazWI6zBrLXPD5UgpAiEGubp4KAH30WQNPbtJmTWQOF5VZlLAOkKtPHvMx9eymbFdfcY1aDvS8MwCXEhIvyozk5SL7vK3A+ksaEztslOo+ScRFFS9vMs5n9
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS2P216MB1330.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(376002)(39860400002)(84040400005)(230922051799003)(451199024)(1800799009)(186009)(83380400001)(55016003)(26005)(86362001)(38070700005)(38100700002)(122000001)(33656002)(76116006)(8936002)(8676002)(2906002)(66946007)(66476007)(6916009)(66556008)(316002)(64756008)(66446008)(52536014)(41300700001)(5660300002)(9686003)(6506007)(71200400001)(478600001)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aVFNaDQycjR1YlN5M2lueWdFRG5JYWxaclcvMGt0SGlUOC80NnM0UTIyN1lT?=
 =?utf-8?B?T29XdVZZS0NGT0NTZ0RSaVpwc2Z0VVhZODJuVFh4T2JaK0lrbUZMd2dFcjBj?=
 =?utf-8?B?SVJNNjNTcStZQ3phSkJScEFmUXJuM3VzbTZSQStuSGV5VWpjUzV3dGpjNTNE?=
 =?utf-8?B?bmdBYXNpbHlac2FNdnBMc3VVZnBqREo1ZFNYK2tFSkttaUZRQXhJek1icnFu?=
 =?utf-8?B?TnFldUN3M2lzU29MN0NhWlJ4Mm52YXQrMzVtQ0J1QTMrdTZneCtySTVLRVJJ?=
 =?utf-8?B?dTBVc1JHajlCSCtMVW1tMTdyS296OXNOOU4yUGhHS0NZajBHeEl1NW1xWkpP?=
 =?utf-8?B?UEpzNXBxSWFOZjZuUldMRThxYVZNUHIwTTR3K0RHM1craXV1eWNUOU9RdzJ1?=
 =?utf-8?B?cDlEUEE5RldtK3ozNml0aWxXOFMvN0JsT1JhUnAxVmk0NDRTdlliQzlaZzJh?=
 =?utf-8?B?QThSanpiYkRvME5pQUsya1VqZmZ1M0FxYXF1TFlpd3VuNE9YTmlVbnZSVlEx?=
 =?utf-8?B?RmVQajVMT1pBUVFzZXNuK3hFWWt6WUNoRlExODlZTHZnVlE2VTRsSldaakJT?=
 =?utf-8?B?TUM3UnJrQWgvelpOcGo5MzJDdEFIUldlOTJnc2E0Mk5DTTlpV1E3OEFZYXhL?=
 =?utf-8?B?endZRW03YzA2SGM3cVBidTZyRmJ6YVFnd1BiY3Mzd200TW9Sdk1oQWZFRHgw?=
 =?utf-8?B?OGZTb1BjT1hGVXE2ZmNHV3VBNzl4aDRIQzlBWUFFa0pUNm14YWpydFBrQVV1?=
 =?utf-8?B?REV1Mk5ZTlhDS3RPQ2FGNGMzd1J6aWRhOUE5UmVxOXFUSlZQVVZkM2RMaXFY?=
 =?utf-8?B?NHRTUXRJMmNsREMyYzZKeGdyRS9vUmVGV0FRZkRoaUMycFUybmVVcmM4ZGVB?=
 =?utf-8?B?WVJENWNqNFI2dU9KQ2pONStsREJOa1ZlbkJZRXYrUUZLYm0zVzdQb0lXbjJG?=
 =?utf-8?B?U0JUQy9Hd015QWRsM0JvTEcrUVhtWjczOWFlaTA5d1ZyQ3Vnemp1S0xUUHk5?=
 =?utf-8?B?L1BtMWpkeEIzTEpLZ0RHT1g0cXg4TldLRGl6UlB4dDQ5Y0hFUkxkZkVYUWFJ?=
 =?utf-8?B?cUtoRjAxUXprR0d1aFhxbVRCVGlNSTl0bVJVMTBwenJYaGlkdHhZSk1nSkly?=
 =?utf-8?B?eFlIaXFyRW1sUXpKVTJ1cllQckFMbStPKzZ1djFjLzhva0dXaHZrVTFJV1lZ?=
 =?utf-8?B?M3dFRDdNcmtmK1hFd3IxeWlDQUx5Snowd2xLZm42eG5Gc3R5TGNXM29hKzhH?=
 =?utf-8?B?eS9XSlRpMTNuTWV3cHBNTTJVQ0F1NWdZMUo3bVF3ZkFLWWx4RCthWmVtaFBP?=
 =?utf-8?B?aDl4RlVMK0RETU55RXFhR0JkRUwxTWlZTXBJZVNtUGFMZzBHY3dtdFJNbytn?=
 =?utf-8?B?aVpLWWUxeW5HS2xVM1NKK21RajFGR1B5ZUhPT25rcGp5bXYzZFBNVGdyM1ZH?=
 =?utf-8?B?elF6b01JQ2xDRDRydkpyTERaZTgra2U1RGtoKzcyZWVXYlY3UEs0eUc4cllH?=
 =?utf-8?B?UWtMLzdDTTlOcWpRZHVpcjFuWDlYUXk2L29LWXZmWVQ2TEpPZGFrZ1d6d0xu?=
 =?utf-8?B?Ukd3WGJWTk5DWmV5c01wSmhQS0RucmxGWXhBQnBIbU5keHEyRTlSMXFYejlY?=
 =?utf-8?B?ZDJqL0FBR0ZPckpjSmhJQ1AxWDdYcmhidUNWZ2VXeXZLek9lT0paZ0IwOUdl?=
 =?utf-8?B?QUV4UmRKdEcvaFFrWFdKNS9DWE1YdDJBczRoYWlNZFZlbklwQ3JaMlpCem9V?=
 =?utf-8?B?NzJQZjl6TTVhZnk4a25pemRnTkxzT01GZDRiVTJYallRdUZrY0lsYms3WE13?=
 =?utf-8?B?bmFMYS8rOGVvM0tWWWVMS1hsaUozR3FEM3M5VEFxSm95Zytrd29rMXBNSk5W?=
 =?utf-8?B?MWxYN3NOMEVpaDVGYmduL3F4WWVrTlZPd1VMd0Y2Q3crS2pPYTF5Q0lCMkEy?=
 =?utf-8?B?WVpZVUdNenlBKzFWRGVienR1T2JNZXVvUjdlR3BKamhKK2pYSSswWEYxWjN3?=
 =?utf-8?B?cmdGK3gwL3h3cDZNRndCUU9DcTJmck40ampvVTQ3MmNtNEFRMFFxZUljM3Jk?=
 =?utf-8?B?TzNiZ3hPdmpuUGlBclRZNlE0VysreEtaQjVXczZPNnFWSjZaTWJOMmhpZ3g1?=
 =?utf-8?B?SHJ2M2czOXp4WVBVSnNVdGY5clB0ayt6OHp5YWduNENGcWZ2Y2s4RmtENFZm?=
 =?utf-8?B?Z3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: doosan.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS2P216MB1330.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fde5e8be-afdb-4160-0a99-08dbbe5ad79f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 06:35:57.6358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1b3610-9ab0-42d5-93aa-46150d723d87
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hPP2tGlr9oOrMoJf6goBT0sYxbxeUD79HTaLFUMCJGt9X03bvSTAyvlU7o+9+zCnWIOe5BOPymxiW0f26jlSRysVtHmg6mtKsID3oCxMib4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU4P216MB1808

SGVsbG8gIQ0KDQoNCkkgYW0gaGF2aW5nIGRpZmZpY3VsdHkgZGV2ZWxvcGluZyBhIHhlbm9tYWkg
YXBwbGljYXRpb25zIGluIHRoZSBsaW51eCBzeXN0ZW0uDQoNClRoZSB4ZW5vbWFpIGFwcGxpY2F0
aW9uIGlzIGltcGxlbWVudGVkIHRvIGNyZWF0ZSBtdWx0aXBsZSBSVCB0YXNrcyBhbmQgcGVyZm9y
bSB0aGVpciByZXNwZWN0aXZlIGZ1bmN0aW9ucyBieSBzd2l0Y2hpbmcgYmV0d2VlbiB0aGVtLg0K
DQpIb3dldmVyLCBhIHBoZW5vbWVub24gd2FzIGRpc2NvdmVyZWQgd2hlcmUgdGhlIGxpbnV4IHNo
ZWxsIGNvbW1hbmQgY3Jhc2hlZCB3aXRoIGEgc2VnZmF1bHQgd2hlbiB0aGUgeGVub21haSBhcHBs
aWNhdGlvbiBydW5uaW5nDQooZXJyb3IgbWVzc2FnZSBpbiB0aGUgL3Zhci9sb2cva2Vybi5sb2cg
OiBwc1sxNDkzNDQ1XTogc2VnZmF1bHQgYXQgMjggaXAgMDAwMDdmMThmYjk1NTMwNCBzcCAwMDAw
N2ZmZTZhNzZmYjUwIGVycm9yIDYgaW4gbGQtMi4zMS5zb1s3ZjE4ZmI5NTIwMDArMjMwMDBdKQ0K
DQpJdCBvY2N1cnMgaW4gc2V2ZXJhbCBzaGVsbCBjb21tYW5kcyhwcywgc2xlZXAsIGF3aywgZ3Jl
cCAuLi4pIGFuZCB0aGUgc3ltcHRvbXMgb2Ygc2VnZmF1bHRzIGFyZSBhbGwgdGhlIHNhbWUuDQoo
b2NjdXJyZW5jZSBsb2NhdGlvbiwgb2NjdXJyZW5jZSBsaWJyYXJ5OiBsZC0yLjMxLnNvKQ0KDQpJ
ZiB0aGlzIHhlbm9tYWkgYXBwbGljYXRpb24gZG9lc24ndCBydW4sIGl0IHdvbid0IGhhcHBlbiBh
dCBhbGwNCg0KV2hlbiBJIGNoZWNrZWQgd2l0aCBHREIsIGl0IG9jY3VycmVkIGF0ICJUSFJFQURf
U0VUX1NUQUNLX0dVQVJEIA0KKHN0YWNrX2Noa19ndWFyZCkiIGluIHRoZSBnbGliYydzIHNlY3Vy
aXR5X2luaXQoKSBmdW5jdGlvbihlbGYvcnRsZC5jKQ0KDQpJIHRlc3RlZCB3aXRoIHRoZSB4ZW5v
bWFpIGRlbW8gcHJvZ3JhbSgvdXNyL3hlbm9tYWkvZGVtby9hbHRlbmN5KSBpbnN0ZWFkIG9mIHRo
ZSB4ZW5vbWFpIGFwcGxpY2F0aW9uLCBidXQgdGhlIHNhbWUgc3ltcHRvbXMgb2NjdXJyZWQuDQoN
CkkgZG9uJ3Qga25vdyB3aGF0IHRoZSBwcm9ibGVtIGlzKHhlbm9tYWkgcG9ydGluZywgeGVub21h
aSBhbmQgbGludXgga2VybmVsIHZlcnNpb24gY29uZmxpY3QsIC4uLi4pDQoNCkkgcmVhbGx5IG5l
ZWQgeW91ciBoZWxwLg0KDQoNCiMjIE5vdGUgKGVudmlyb21lbnQpDQp4ZW5vbWFpIDogeGVub21h
aS1zdGFibGUuMy4xLngNCmtlcm5lbCA6IDUuNC4yMDgNCmdjYyA6IDkuNC4wDQoNCg0KVGhhbmsg
eW91DQoNCg0K
