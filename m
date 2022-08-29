Received: from mx0b-0019b802.pphosted.com (mx0b-0019b802.pphosted.com [205.220.174.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E885C98
	for <xenomai@lists.linux.dev>; Mon, 29 Aug 2022 19:33:12 +0000 (UTC)
Received: from pps.filterd (m0240899.ppops.net [127.0.0.1])
	by mx0b-0019b802.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27THdMqF013433;
	Mon, 29 Aug 2022 15:33:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3dsystems.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps1;
 bh=EtzYtCWGI1ktHFyTwOynGhRFiRK77+Kz7TZGFjv2g+w=;
 b=cX5r6yFvDRMkQ+FZ3LM9wTquJo+FLBZyxIA9UMRtjITdlRrBfzQb2JtSQkr8Nf21s7az
 UGQ22RA9y9hjaHpIAHznnnpcPpIn8GjzKk2GstllKBVz5xqGNdf7Ii18LWTA8bb/o9zb
 dOFsXB7MWSSezbCgj1KHWBdjyNcH4jP/K617Ox0fAEkwIehBh/Fu+Lo105GOakvvAZsx
 EmUbMo9M8KMU6KsDcxvOuaQY9DlQbsZG9Upm60z4C3E96cBPaat5DUXcbPRxUlMX4gom
 vL88ORIHzDSsPpYI/Hr2OhrwSUEt+CCl0SXSVwX8SbyW530Gvv8ZF20KNMdGbbX0hqcj eQ== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by mx0b-0019b802.pphosted.com (PPS) with ESMTPS id 3j7fn812pg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Aug 2022 15:33:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdW7fZMkgRTKvpF6OL5FedH4TYT/evKzpihbcz4y4mRG5ZUvnUNxKiAUIv3013/EPcIjU0VXr/81XdMQ/e83MT/VbkWXM1U6hh5DXnDCy36EJ17ySD6A5ZcgxzjdCOXOs9ZxGbp4QTph1ALm0FnEktoeN4nbCmNvJwl+bof67ExHx++kcH8LDWzIqflvlkti1CWrlVLcrQtiVDCazY6fnFsMYaRdcwP6QB6NSL2o4q8h95xiel5U6dkp63moEUnEeNg926IHlTbbSo/nUIUXNy909DN93K1+k0/QaoXXVIHwUAtmKEksnW6tf5hATmIeo8hFS6Jdb5kfX8vyeWWiJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EtzYtCWGI1ktHFyTwOynGhRFiRK77+Kz7TZGFjv2g+w=;
 b=SGrU3IWk6a267wIdhY6RlafjRmBUYnBb/wYPWxJOz5b4Qt+EmSAKofVGwVL+jMhd1VMDCzhCIbCvMueumhugjWeDGHDITSxuCBiK3PuSaesI/6/7KlHtc1wepfMdWLcKAe1768Q38VTdoY+zxomzZtB6rDJkch7H7VfZK5wyry8IyoK+dzxmefh+9A1rDXdQENwK9D0pgG+oNagtYLP83LNt8SNCijWd8dsgpEkaHuiwElB8DaFek5yGQ6psVt38SvSX3H4aINHBKkMNtHkhGt5oCdl5FwzECpZa5KQwohtIjSUj4mkJwmNvtTWKeSWWXRhaHMV0kwVedN0zdy/RbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=3dsystems.com; dmarc=pass action=none
 header.from=3dsystems.com; dkim=pass header.d=3dsystems.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=3dsystems.onmicrosoft.com; s=selector2-3dsystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtzYtCWGI1ktHFyTwOynGhRFiRK77+Kz7TZGFjv2g+w=;
 b=kgkQdjL8u0mYTGD09y2QmvSUsnkLSR4LjYoXEe/SXYMK6EDUsGRMCss0OKlK2/tDDHApeReNg6/Mz0hwqF11xvKh202gFEbO25oUa5kq0mAhGnGRN3u2HD+03UFUA6ElgREWneSLq3YCMDauyRyUXRw4LieYd2MhpMnQvsphGkM=
Received: from MW3PR12MB4460.namprd12.prod.outlook.com (2603:10b6:303:2f::7)
 by SA0PR12MB4461.namprd12.prod.outlook.com (2603:10b6:806:9c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Mon, 29 Aug
 2022 19:33:04 +0000
Received: from MW3PR12MB4460.namprd12.prod.outlook.com
 ([fe80::b86a:14d4:9b71:c819]) by MW3PR12MB4460.namprd12.prod.outlook.com
 ([fe80::b86a:14d4:9b71:c819%8]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 19:33:03 +0000
From: "Auel, Kendall" <Kendall.Auel@3DSystems.Com>
To: Philippe Gerum <rpm@xenomai.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: PCI probe fails (Cobalt 3.2.2 / Dovetail 5.15.y-dovetail)
Thread-Topic: PCI probe fails (Cobalt 3.2.2 / Dovetail 5.15.y-dovetail)
Thread-Index: Adi5hHT1QzOR8y5vTEiAQ2pXMX+pvwAaG9EAAHvO6aA=
Date: Mon, 29 Aug 2022 19:33:03 +0000
Message-ID: 
 <MW3PR12MB44601CB662469B8D95FA1400C2769@MW3PR12MB4460.namprd12.prod.outlook.com>
References: 
 <MW3PR12MB4460264EEABB2C91E529440BC2759@MW3PR12MB4460.namprd12.prod.outlook.com>
 <87tu5yaxv5.fsf@xenomai.org>
In-Reply-To: <87tu5yaxv5.fsf@xenomai.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0be9d434-e964-4439-78f7-08da89f54a97
x-ms-traffictypediagnostic: SA0PR12MB4461:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 7/wXdjWL/yptdofhw9nAV9VXJXZ3KkkamTCIiX6JsKJh5ZcEtpOrhe++G7qJPfeAWLaGSvXjE/Fdb+5Qlq/zftcNlTxPPuUBy8VgYcEKgfreU1A/LKJih9oMGHYS8zCWYeuyMFVwsAVGpSTZy6CbWz8xRjzEd1KCCJJ9F503a8B3oxGC+Elu9NAXRMIDcpeONwUZGw9gQ8fptZ8XvDxLEevKZU7xLsLEnoOQapzPzpyTOXwzyTfiqZu0gV/6z88dLxOiv8G73PZDmfGTFzVv7oFMchEitA6Gcc/Xe1Jdy8KDYcFTYuW0dZGVdqq7JqkqWCttjlmZFEgGCKfy2dsevzCY6BMzZDjC0slUFp2EZEuVsunA+AYLglA3v/wZH2WOBc09h8p9diipDT3CS7WsG5cyfnMpu+oWAVSpHKthpOyFfD8Cqs6xRp7D+4y98cu1mrEDyh/kCuf68RiNUmFePNCum/yO0mjn/XLET4VTQDpBUG/rbT5sygdZZbCq8XgsUS5xckWyhIwVFxMXnP68Jb7ra3AG3Rgmpr9dszMeCiUwuetl0Pb3vapt9XmXFaoZZf1TUjkk+u87KoOxnzq6MjLMQSjIk/Qtml83S0Xy8jQUDojU0rmVaaD7cHmnAEjjVA+5gtgbCZoIiMh6oIshQSzK0TCsm5Bk/udDIVPl8ULn0wuAnSm1XcslABMers4g539BoyUeN8rje+u52BournH7K0EWjDpSVxFzgwxmKtnR8erV3lzT8dlID1XyYBlU5C01Cr9Q7VQUrkJSuM/ZdQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4460.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(376002)(346002)(39850400004)(136003)(26005)(316002)(6916009)(8676002)(86362001)(4326008)(76116006)(66446008)(66946007)(66556008)(66476007)(64756008)(71200400001)(5660300002)(478600001)(52536014)(38070700005)(41300700001)(8936002)(7696005)(122000001)(38100700002)(6506007)(2906002)(83380400001)(55016003)(9686003)(33656002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?K0tFeU8wMkhMT2NUUkUwVDFPcGVSQVZLaVUzVS8za0FsYUhOTTAzbllHQ3V2?=
 =?utf-8?B?WFFtRERVZVM2VzN2NVN4dU5wYlpxa3d0ZFRCMkZQVnFDR3h6MXczTTlWaXhN?=
 =?utf-8?B?QzhFQVVWSzBab2E1RUNXSlAraG5SR0t4eHZkM3dXQ3MyUjdva0JFb3RBZkcr?=
 =?utf-8?B?TjhmeW5ZWXBacnZ2Z2wvTThEdHJvTUozc2ZaZ08rVU4vMWF5ckE5TDZPWHd5?=
 =?utf-8?B?RmNDcWlPZU03aldKWlFBTlFWeE8waVJ3OFFWQlN0NzFkUmpjK1JxNERjNjFI?=
 =?utf-8?B?ZStwUzBUQVRod2lIZ0ZZUlpTUmVoNzRnMjJtK2p5ajR2U28wRU5oeUlWK3hG?=
 =?utf-8?B?dFBpNms4Q2xxSWt4emdGRVVWN0k3NFpUVVlxbjdkd2RXbGpjWTB2T2tNaElm?=
 =?utf-8?B?YnFjR3FLVk8vODVidk1URFJQUjRiVTBhem1BSjhISlRnaWQzbnF5VmJ2MnhR?=
 =?utf-8?B?bm9Mb1VublZNeXdkb3FNUVRKYnBjZ2t0YzJxZzBFeXpwNnRnUzgxb1VBSGJu?=
 =?utf-8?B?N1RkTW5hd2wwM2lEVzBwUFhIOG5OYzcyaHVMZXFJSFpFd3JnTFZZenZQVUlH?=
 =?utf-8?B?U3ROR2Yxa1lFZThlbUgydGc2NG9ZZDdWUzdaNWpTOHBYQUI3alJmclR3NmU4?=
 =?utf-8?B?Wm43ajMySFJNaDQvcjZyL0JkaXd4OTdMOEdoMmMyQU5HSUxsV0xvaHdMYzFy?=
 =?utf-8?B?ZHZXSVZYbnV4NlU2UUNJVU1XNW9wWklLZmRmV01OVStqV2YyOHdTeUllSis0?=
 =?utf-8?B?Vk5EQVlLWGRnc2ZOOVFlYzRKM1NMZnFGMmYvb1ZRSEZDSEJZRFpBRXhaSUZn?=
 =?utf-8?B?MWFIUGhpRS84cXl6cDIydHNnYThNejNoL0hXS2E2UzN2VUQxMTl3Unk3S1dC?=
 =?utf-8?B?ZjlaWEcyVzVVLytKMmRGSUo1SDhsN3oybFhsMkZHbldlRUd1QjlhK2E3TDlm?=
 =?utf-8?B?VkFOTFZCRzQ4L0x0bU80ei9hNzV4S3NUZy9SSFYrVnZZZTExa25YNC9ac1hk?=
 =?utf-8?B?ekNseTR6MXA1S0JpUVNWazZjQXdwcklQZXQxNHV3M0syVmRkNGNxclhhYmlH?=
 =?utf-8?B?aFlvdXpBdTROL3pXTzVQQmNJVUdjbzRoTk85Qkxyb1h0aUxSOHRCblZPSmtj?=
 =?utf-8?B?UDcwM0pQc2FkRUc3SytBYzkwOVc5NVVnMjE2VG5tWVRaSmNwMUd1RmxmOTZH?=
 =?utf-8?B?RmcrbU5aN2ZxcUpTcEo2T1d3OFBFZElqNXp1Z25RWU03WHlLdlQxUUJ1Y2VE?=
 =?utf-8?B?SnRnWDZ5ZGd6WEVPOFBKOTU0M2JzcHBtRk4yK0xVb0NHSXpDcVp3NnN6b05F?=
 =?utf-8?B?N3RtUDU5ejlaeWNrVDEwWFlwTUxFOC9NZkVTUTFKN3BXMEZmTlBrd0lCeTFM?=
 =?utf-8?B?c2RoaTVrLzlyRzBTdTRwR2RXVXBWNmV5d3JNMEgwN29nOU5YSlluUjFSclJ5?=
 =?utf-8?B?SWVFSWJqazdzdE5CY1FjdWVucHl5Wm1uMjJiS3JnYkx5VXlOSkVuYWFaRC8y?=
 =?utf-8?B?cWNQNDFVSE5FMEVJYUc4QUdNajJRQlkvNGY5WVkzaXlTeld1MVprUkpEZEhN?=
 =?utf-8?B?ZStCaU41Q3lhWi8ycDNXTHdkeTUycFp2RWlEUkx1SDFFeUVBUTBGOHJWbldQ?=
 =?utf-8?B?bHBWNmN4cFFxN1Ivd3lVczR5TTVKV3I5WkFZdTlZeWNTMUdNUnpDNnhJSkVB?=
 =?utf-8?B?a01ydFpTak5rSkFjTUN5VFlCMmsyYkptazNrM2NKNHZPL3pQQ2NCUS81NGJW?=
 =?utf-8?B?ZFYvRGh6YnJoZUgyOENnYlBuVEd1RFpYQVUwZVE0Wk1uMEUzbUc5OXpsTjVM?=
 =?utf-8?B?KzZ0Y0hnMDlpRjFjd2Y1SGlqYUxCOTlwOENUNWVhdGFLVitIYWRLOVBtcnJQ?=
 =?utf-8?B?aDcyelU1a0FOOUNYYSsrMzM1NWlWdW4rU2lFaFZ4UU5yMG81dXVLOFgrV0xP?=
 =?utf-8?B?UTVaYWhVUVRkb2Z5MEtyc3EwQXFObEw3S1ozMmV0Wncxa2wzMGkrZzVPU3Fx?=
 =?utf-8?B?UENKeG9VQXNsZzlPVnRjZjBOckJqUVQyd1dkNUNuNW84WG1HNFYrVE1Cdm5U?=
 =?utf-8?B?dVk1TVloVEVjSHJGWjdJTCtpM3VUSFJoMGdvWm1LRjJ5MEw2cHRYbzVwVk1q?=
 =?utf-8?Q?e+fpM/cFVlHlYeJhMjZWhCCjy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: 3dsystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0be9d434-e964-4439-78f7-08da89f54a97
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2022 19:33:03.7467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 150688f4-8db2-44d3-b980-cd00ab6848fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U+z2wl3cZ/Mz6UfTkNxAc2N/A0RJEuc6hDhF9gbk9wAdWNmJDVWk3uebs+X2EXryTDOmBVe4HTTNzcJWw9QYFJX1k5eauTTksjV2C1kw11c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4461
X-Proofpoint-ORIG-GUID: H97MiRVcrFPln1Vj6_4RsUWNl4JoHX9K
X-Proofpoint-GUID: H97MiRVcrFPln1Vj6_4RsUWNl4JoHX9K

SGkgUGhpbGlwcGUsDQoNCj4gRnJvbTogUGhpbGlwcGUgR2VydW0gPHJwbUB4ZW5vbWFpLm9yZz4N
Cj4gU2VudDogU2F0dXJkYXksIEF1Z3VzdCAyNywgMjAyMiAxOjE0IEFNDQo+IA0KPiBIaSBLZW5k
YWxsLA0KPiANCj4gVGhlcmUgYXJlIG11bHRpcGxlIGlzc3VlczoNCj4gDQo+IC0gRG92ZXRhaWwg
ZG9lcyBhbGxvdyBzaGFyaW5nIGxpbmVzIGZvciBvb2IgaW50ZXJydXB0cyBbMV0sIF9vbmx5XyBp
Zg0KPiAgIElSUUZfT09CfElSUUZfU0hBUkVEIGFyZSBzZXQgZm9yIGFsbCBoYW5kbGVycyBhdHRh
Y2hlZCB0byB0aGUgc2hhcmVkDQo+ICAgSVJRIGxpbmUuICJnZW5pcnE6IEZsYWdzIG1pc21hdGNo
IiByZXBvcnRzIGFuIGlzc3VlIHdpdGggdGhpcy4gVGhlDQo+ICAgc21idXMgaGFuZGxlciB3YXMg
c2V0IHRvIElSUUZfU0hBUkVEICgweDAwMDAwMDgwKSwgd2hpbHN0IHRoZSAnYm9sdCcNCj4gICBJ
UlEgaGFuZGxlciB3YXMgZ2l2ZW4gSVJRRl9PT0JbfElSUUZfTk9fVEhSRUFEXS4gSW4gb3JkZXIg
dG8gc2hhcmUNCj4gICB0aGlzIGxpbmUgd2l0aCB0aGUgJ2JvbHQnIGRldmljZSwgeW91IHdvdWxk
IG5lZWQgdG8gZW5hYmxlIElSUUZfT09CIG9uDQo+ICAgdGhlIHNtYnVzIGhhbmRsZXIgYXMgd2Vs
bC4NCj4gDQo+IC0gTm93LCBlbmFibGluZyBJUlFGX1NIQVJFRCBvbiBhbiBvb2IgbGluZSBpcyBu
b3QgcG9zc2libGUgd2l0aCB0aGUNCj4gICBjdXJyZW50IGltcGxlbWVudGF0aW9uIG9mIHhuaW50
cl9hdHRhY2goKSBpbiAzLjIuMiwgd2hpY2ggZm9yY2VzIHRoZQ0KPiAgIGlycWZsYWdzIHRvIElS
UUZfT09CLiBBdCB0aGUgdmVyeSBsZWFzdCwgeW91IHdvdWxkIG5lZWQgYSB3YXkgdG8gcGFzcw0K
PiAgIElSUUZfT09CfElSUUZfU0hBUkVEIHRoZXJlLg0KPiANCj4gLSB4bmludHJfZGVzdHJveSgp
IGFzc3VtZXMgdGhlIElSUSB3YXMgc3VjY2Vzc2Z1bGx5IGF0dGFjaGVkL3JlcXVlc3RlZCwNCj4g
ICBhcyBpdCBhdHRlbXB0cyB0byBmcmVlIGl0LiBDb2JhbHQvSS1waXBlIGhhZCBhIHN0YXRlIGJp
dCBndWFyZGluZyB0aGlzDQo+ICAgY29uZGl0aW9uLCB3aGljaCBkb2VzIG5vdCBleGlzdCBpbiB0
aGUgRG92ZXRhaWwtYmFzZWQgdmVyc2lvbiBvZg0KPiAgIENvYmFsdC4gQXMgYSByZXN1bHQsIHJ0
ZG1faXJxX3JlcXVlc3RfYWZmaW5lKCkgY2FsbHMgeG5pbnRyX2Rlc3Ryb3koKQ0KPiAgIHVuY29u
ZGl0aW9uYWxseSB0byBjbGVhbnVwIHRoZSBtZXNzIGFmdGVyIHhuaW50cl9hdHRhY2goKSBmYWls
ZWQsDQo+ICAgY2F1c2luZyB0aGlzIHJlcG9ydDogIlRyeWluZyB0byBmcmVlIGFscmVhZHktZnJl
ZSBJUlEgMTYiLg0KPiANCj4gRG8geW91IGFjdHVhbGx5IGhhdmUgdG8gc2hhcmUgSVJRMTYgYmV0
d2VlbiB0aGUgYm9sdCBhbmQgc21idXMgZGV2aWNlcz8NCj4gQWx0aG91Z2ggcG9zc2libGUgdmlh
IHNvbWUgdWdseSBoYWNrLCBzaGFyaW5nIElSUXMgYmV0d2VlbiBydCBhbmQgbm9uLXJ0DQo+IGRl
dmljZXMgaXMgYSByZWFsIHByb2JsZW0uDQoNCkkgY2hhbmdlZCB0aGUga2VybmVsIGNvbmZpZyBm
cm9tICJDT05GSUdfSTJDX0k4MDE9bSIgdG8NCiJDT05GSUdfSTJDX1NNQlVTPW0iIGFuZCB0aGUg
aXNzdWUgd2VudCBhd2F5LiBUaGVyZSBkbyBub3QNCnNlZW0gdG8gYmUgYW55IG5lZ2F0aXZlIHNp
ZGUgZWZmZWN0cyBmb3IgbXkgc3lzdGVtLg0KDQpUaGUgSTgwMSBkZXZpY2UgaXMgd29ya2luZyBv
a2F5IGFsb25nc2lkZSB0aGUgUlRETSBkcml2ZXIgYW5kDQpJUGlwZSAocGF0Y2hlZCBrZXJuZWwg
dmVyc2lvbiA1LjQuMTgwKS4gU28gcGVyaGFwcyB0aGlzIGlzIG9ubHkgYQ0KZG92ZXRhaWwgbGlt
aXRhdGlvbiwgYnV0IGluIGFueSBjYXNlIEknbSBhYmxlIHRvIG1vdmUgZm9yd2FyZA0Kd2l0aCB0
aGUgNS4xNSBrZXJuZWwuDQoNClJlZ2FyZHMsDQpLZW5kYWxsDQoNCg==
