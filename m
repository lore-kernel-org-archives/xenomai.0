Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2077.outbound.protection.outlook.com [40.107.7.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5225B3D960
	for <xenomai@lists.linux.dev>; Thu,  1 Feb 2024 22:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706827023; cv=fail; b=q/sPrO/KMn6+OQDwQLTUZA7MYm4CjL8lAuxLiQmDubZmXCkcwm57ZTxunmuHgCwJg5UyPS+JrjM//av8FH/0KuOZhFCfY4KtAZXXXgleE5YenH5N33utPz/VQlJLvM9neDpn6qVaxsLPzal1rroDr6NzC0ipptfPlBqjl5h8L1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706827023; c=relaxed/simple;
	bh=LU4xqaUhCAUIkSDeyxSn+3kjEyEar7LIBsYHjaH6ON0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oxPkyYVE0XternbYxjXPn5sqfH2SMknGt0HxDYoJP9Yu/9d3gyZRS3CG1Y6/x1gqRh/o6Y8J0K8w2AbnzR+q2bWRDK8jmhbttCmNbhzDiLihHZtBhJsKoaOb4f+7w6cytbtSwHzcNn+8PcpzAeeYBupbivdYopeg4UFbZjcY2WU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=mSmIDA0R; arc=fail smtp.client-ip=40.107.7.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="mSmIDA0R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gjbL4li45Cg2L92DbxmRHE0JXtPMp5n3x7TMmoK8z/prm4jSvD1+22HfD0dfQIrv2ATUekQKbWCepOGtXJCx+J7yZhvxFSN1CG3D5IAH6+Prxo8/m7XK2F3JQ9+C4LAjUqSb4p4mKg5EEEP39VIMW1GVyYNU41VA01qwJgM1Cfbk4E6QyUTwEqRsLGz7ov/kQ0LxOekvGIrz9rAw01yPZz1hn+CqRl1EvEPw7Nu7i7tdMl5yM8J4Nk7Tooh8hV0pQbzoAuFhSYMQ8wyE93FCHtDR/ZCS48IoWoK6EM0tyTaHKjBuZVM444mCeD/29BYVueRS9pZwxb/qdqaakLAhcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LU4xqaUhCAUIkSDeyxSn+3kjEyEar7LIBsYHjaH6ON0=;
 b=GIGScXiveyMkncOr9bW8Khu64ZPE0qDHs99pmH2oq8EJ2VLgAdWlTCDjFIdeNDzS6cMOTbf+pt1zSFxhyqDQ5/+6NIOH2wvVJVglMnZXVLOvejOwGTlzK4gqaaBwpce2y/qdq9IDO8nPaniik2o920NA0e/UDCT6phQgQplm2o+Df2XYZft90VQKWr1crBGkrVbRcXOquhYZ25lBBBLzCMJ3I7SnSEvNrECGExtt1oGS2kQZNNxysBnRf91hmA5GxzIejV1mlSxImNJwP83RgaFFdYAN7WWe1ixN/y23e4skAmLSBAe2DJMAhz3poLZc1treik6ShAjRgEQfXs9iiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LU4xqaUhCAUIkSDeyxSn+3kjEyEar7LIBsYHjaH6ON0=;
 b=mSmIDA0R9q0kSAumqbO/hcva3wWqbFIn+88D80o75uLNK8UxdzKQgHQPXGf+f43mibGWindZDf8K3f4EoUbJjnJfrkAwtQ71gJf4JYLA76VE9wZmP3zcydYUKguQi2jM6b/9MFbeBPPeF/9M738SwyxkXx9wG/iOcLhwstC3/Xo78xrHl8x3H89YoObeG2Zz/DVC0YBiY1xv31sGT39l/KsquiZwQDAcbO3h5vOle202LUx/FIYLsEqcKEsTNRYLWeEc9j6pdHJUoKATfeh+O0EWTTioPa4me8FjjuWvbOyXwZ4iKWqPjc4sJLkLc/g3DKs2h00Pb5sYEs8NG2/A9w==
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB3PR10MB6762.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:43b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Thu, 1 Feb
 2024 22:36:55 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::55c1:2302:1bd8:d9db]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::55c1:2302:1bd8:d9db%5]) with mapi id 15.20.7249.023; Thu, 1 Feb 2024
 22:36:55 +0000
From: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
To: "rpm@xenomai.org" <rpm@xenomai.org>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>, "Kowalsky, Clara"
	<clara.kowalsky@siemens.com>
Subject: Re: linux-dovetail: Branch v6.6-dovetail1 was removed
Thread-Topic: linux-dovetail: Branch v6.6-dovetail1 was removed
Thread-Index: AQHaTshv6er2amzImE+01mRDqucDJ7D2IL4A
Date: Thu, 1 Feb 2024 22:36:55 +0000
Message-ID: <84f36ac3a6e146a3301edc1503f257742af0c7ab.camel@siemens.com>
References: <5ae4513b93b5d14b59940daa604b9caef74fda40.camel@siemens.com>
In-Reply-To: <5ae4513b93b5d14b59940daa604b9caef74fda40.camel@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB5712:EE_|DB3PR10MB6762:EE_
x-ms-office365-filtering-correlation-id: 3cb34616-fbb6-412e-1cba-08dc23764b59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 z4fmugDdBfjXz6djKOKO7cvmtMoejlKIubs9R9IxkexC0/IstSqEdOKJHyG9SNQcbRqTmYJ/YL0nMYEoYy8irzGRZIpUtw/rb39MqNCnRlhKrM6L1wLIWSgXWkksI1XTrRXrcqMT3GTKgDVQlfi0M+0gQn4Sh/AFivQSey+e3i3Q/yQaSK6LRGhoba2brtPB+BwEsKzw6KYmHJ5kVjPO2pJL26ENPr5kI5/XidYttvg9bvSVz+aVH+uHE1eu6aiu41Qo83zBaeNooUp5XJYMj3aw2scFh6JJkyba1zwVi9ZZI3VXGxsSSoEqRGbrT3TR9vl2jXk4x0Vo5mSNTbbx8eaV7tsE7qkQcboAlj/2fKoLrQSZTi9v1MrBLzFzwLGFgxCfdkcRCA7X1LNCQSBAmf4sgteFdx29SRl02GmsbYCe6CL1Ts6+BgwxFszkdCad3O8uEyguZ/FAKzIARh42qVhq+ITQ9Wo4jmoQsf4ZlGhVS0HZXD/5aoQ7k/NbSNa0lnkXGtD/e7ZB2YW8QoS8wzY74HxSnuL+6qfciB7LwoinNUuYdcvCIPnzjzbWYj0e95QLdZzQPWN6Iqdj4pNOUQ3oUk87jG2JUrHp9RB7uwg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(39860400002)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(107886003)(2616005)(82960400001)(38100700002)(122000001)(8936002)(8676002)(66946007)(76116006)(110136005)(66556008)(66446008)(54906003)(66476007)(6636002)(64756008)(316002)(2906002)(4744005)(5660300002)(4326008)(6506007)(71200400001)(6512007)(966005)(478600001)(86362001)(6486002)(36756003)(38070700009)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dDRqOS9nbkpJYUxvZGNGYmR5aGx0UFFVYWdJaHBFcEZCcTFoM0c2WFcyT25i?=
 =?utf-8?B?Y0k2ZjdlcTlkZHlJWWxORnhuV3RMM1pITnp4YWdIeVE1clVzblQ3WmdVT0Z3?=
 =?utf-8?B?VTJVYVR2V09VS0JtR0RUOGJUeHA1eHJqT2Qza1VKRU1seXUzekdwOGR3WXlE?=
 =?utf-8?B?cHppc0p5S0NGcFBBMDFuaFIxbGFGM3F5eWFOSHdvanJIRWF3b1JTQU9tV0U1?=
 =?utf-8?B?M0NZTnlVblJlYlk4Y05hT0prbGQwT1ZmcFNldSswVjVuTkpsSS81OXpPMnhY?=
 =?utf-8?B?YVFCOVorZC9zQ0NBYzRyczRPZWVJMkhOenNrOHh3QzJlTmtNY3duV2V1K0Vs?=
 =?utf-8?B?TkJjb3hUV3QxeU5pc2VQY0xMYWZlTFRtUjRYR1c0ZHZjTnhiRGZLZ2JjVXRZ?=
 =?utf-8?B?enlhV0tmY2o2ekNVV001eUtqa3c2VEMyOXdsTlFLMVcvMWFpb3VwZTJtd1FK?=
 =?utf-8?B?ZDBzT0VQaDB3OW1OeEpkZk1lUkNoQVprdzVlaFpuZHpSWThqeXA4V1FwMDRY?=
 =?utf-8?B?VlBWMEFlbzZiMmlKdloxSHgxV1dxOG1wRDkwMUFNdXdoUmpvWDRxT09xbUVa?=
 =?utf-8?B?TFZCaGNRaWR2R2NzMkkwZGhDSCtLbDRZalQveUNvMVUydGZka3NYRGpvbENy?=
 =?utf-8?B?cmxCaENYK3V4TFNEdzNxOUxzenhrRUVVYU1iaWFyeDlxUVY5SVhpY0V4NWE1?=
 =?utf-8?B?OFFBeEg1bm5qdDZuN0JGWjhhWWk1SFNEa0hYeUxUa0ZXN1RpVUhSaUp6MmNF?=
 =?utf-8?B?dzNUcEhsOFlYbG9RUmpHaHlXeHZaY0RXWndtTERWRlhNa3kxYmllUVlaeCts?=
 =?utf-8?B?NEliZzdDbmFqdzhaYXVEMUZsOUxkcE9oc3NjTVlaYXpVTTRmYzZ4TGR3L1lp?=
 =?utf-8?B?Qk8za0pRV0lOKzdUUnV3VWtZamlybVVmVURQaEVpUjljYlhJTW5JMjhmdURs?=
 =?utf-8?B?b2xkY2MvdE5CaTA2L2taYjZiODFKVjhMb0tUbE5Icm9DdStRRmhZVWZGS1JZ?=
 =?utf-8?B?SnkrQ3RXVkU1dW5reDNNdXNzajZhRngrMFFoeHVjbThHY0VzMXVYNi8xN1BQ?=
 =?utf-8?B?cDFUam50c0lLRGV2SGhGYkZBRERGQzF3SHk2M1hVZmU1UHMrL0xiYVhVZjkz?=
 =?utf-8?B?b1lUajkzM20wVXhqTnJlNTY0cDdZRGliYjR0WDV2TG5nSUQ0QlpyOERuQXk5?=
 =?utf-8?B?UnFTVWJxRXB6MVlQdkVWbG9KUStWVmxYdHp5b1pNRWpMUkRsUEVJZWl6Yk1a?=
 =?utf-8?B?M1FvUnl6b05Hc3JuRWkrQnJ5Mldwc2haUGlkUUtWY3lMaUJ6bFAwak9uOU1K?=
 =?utf-8?B?YkdUVkV2V0sxbndBTEhaaWJJQ3ltZk1FSDhobWpUUFRLSDIzTUllZmVUMjdl?=
 =?utf-8?B?K2xDYS8zQ3U3TXhUc3RvcXpRenp4WWk2bTZQY290dHN6Vjc4ZHlSYW1SSFF2?=
 =?utf-8?B?bVBmUHZwL3Q4NlVRRm5hSXNpUHU3ZXd3OWxuWXdYV1FPK1JxNmF5LzhHY0FM?=
 =?utf-8?B?SUhPRDAxS0NrcUMxMzRFMzlhaVRjdlF0UGZsS0lyZFhKMnZZenI4ZU1ZSlhs?=
 =?utf-8?B?SlpLOWNpU2FrTVppOHJFYkpub3g0cnFsNTljMlh1NzdGa2pQUWtuL3ZpUmUr?=
 =?utf-8?B?dlczVzNvMEJBelRrd3FDbEk1a3p6c0hDVW1jSzJBbjFjcVFYeFpWTE1vMGlX?=
 =?utf-8?B?c0VyS3ljbjNuSWpMbUhxTjZFZ2MyOGM5WWxqYWg2aEVNaDRLVnZRc2FjWCsr?=
 =?utf-8?B?MzJvdHBnV2xQOHdVZkxqSGlYUkgxWEZSMVdSRU5Kcmh4R0dhTFFZRjlqM3c0?=
 =?utf-8?B?QWpkdHFpbWI4Ukc2TGdZYkN0WjgvcWRaVW9iUGw2cVJ6NFRMVk1VUnVJdVlR?=
 =?utf-8?B?WEMxcjlnY0FsamxkdlIzTllVY29BbGhYR3lqUjJYUUtKODZXcUZFeVVHbUJq?=
 =?utf-8?B?MU5ockNYd1RjbnJyQ25SRkNyWHJuMFNmUTdjTUhseStBd2tlSXNzOGVHV0Zm?=
 =?utf-8?B?bTJQUUJZTXN3S1VzQVZuSXYweG9PMkdyeXpYRGlqT2N1NWJzOHlKbmdoamY0?=
 =?utf-8?B?eDFQdWpqN0ozL0Fzd0R1RExEaVJ2WWRaU0RkUHRsU2FyTkU2a1FFNDYxd0xK?=
 =?utf-8?B?RzNOQzFFTzNnSjNoQlFUS3hNVC9FTnZTSnp6aFpta29RNFlUcVFZZE03aDU2?=
 =?utf-8?B?aXJRc2c5K0VNU204N3E5eVUvcWpteUdWRUVjVnhNR3J5dk5NK1JsWEoyZVdM?=
 =?utf-8?Q?2+H3Qb9IsAs/soF7PPTrRIjfGYZ8lhSd3qzDe/sReY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A39F836CCD2DA94A89019AAD7DD32692@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb34616-fbb6-412e-1cba-08dc23764b59
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 22:36:55.6914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BKUMdRQwtY0IVtXwqFwoATc2XWYyAoOT6VNc2RcqrSS+RUrMEY+t6EUVmEntQfBTRzcobkU5nI6eE6lAeVHSk2gzCWpVA5nHhLAFCLaDin4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR10MB6762

QXMgdGhpcyB3YXMgbWVyZ2VkIHRvIG1hc3RlciBub3cgd2Ugc2VlbSB0byBoYXZlIGEgcmVncmVz
c2lvbi4uLg0KDQpbUmVzZW5kIHdpdGggbGlzdCBpbiBDQ10NCg0KT24gV2VkLCAyMDI0LTAxLTI0
IGF0IDE0OjIyICswMTAwLCBGbG9yaWFuIEJlemRla2Egd3JvdGU6DQo+IEhpIGFsbCwNCj4gDQo+
IHRoaXMgcGF0Y2ggWzFdIGluIHhlbm9tYWkgaW1hZ2VzIC0gd2hpY2ggSSBjYW5ub3QgZmluZCBv
biB0aGUgbGlzdCAtDQo+IHJlZmVyZW5jZXMgYSBicmFuY2ggbmFtZWQgInY2LjYtZG92ZXRhaWwx
IiB3aGljaCBkb2VzIG5vdCBleGlzdC4NCj4gDQo+IEFjY29yZGluZyB0byB0aGUgcHJvamVjdCBo
aXN0b3J5IG9uIHNvdXJjZS5kZW54LmRlIHRoaXMgYnJhbmNoIG5ldmVyDQo+IGV4aXN0ZWQsIHNv
IEkgYXNzdW1lIHRoYXQga2FzIGNtZGxpbmVzIHVzaW5nIG9wdC1saW51eC02LjYueW1sIHdlcmUN
Cj4gbmV2ZXIgd29ya2luZy4NCj4gDQo+IFRoYXQgYnJpbmdzIG1lIHRvIHRoZSBmb2xsb3dpbmcg
cXVlc3Rpb246IEhvdyB0byBmaXggdGhhdD8gRm9yIDYuNg0KPiB0aGVyZSBpcyBubyBub24gLXJl
YmFzZSBicmFuY2ggYXZhaWxhYmxlIHlldC4gV2h5IGlzIHRoYXQ/IE5vIHBsYW5zIHRvDQo+IG1h
aW50YWluIDYuNiBhcyBtZXJnZSBicmFuY2ggYXMgd2UgZGlkIGZvciA1LjEwIGFuZCBuZXdlcj8N
Cj4gDQo+IFsxXSBodHRwczovL3NvdXJjZS5kZW54LmRlL1hlbm9tYWkveGVub21haS1pbWFnZXMv
LS9jb21taXQvMzMwNWFiNWIzNTkzYjAxZGMwOGM1OWUxNzBhYzk4YmUxZjgzZjYzNA0KPiANCj4g
QmVzdCByZWdhcmRzLA0KPiBGbG9yaWFuDQoNCg==
