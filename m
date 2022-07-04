Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77E146A3
	for <xenomai@lists.linux.dev>; Mon,  4 Jul 2022 13:57:12 +0000 (UTC)
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay.mail.gandi.net (Postfix) with ESMTPS id EBA86E0004
	for <xenomai@lists.linux.dev>; Mon,  4 Jul 2022 13:57:10 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2082.outbound.protection.outlook.com [40.107.21.82])
	by spool.mail.gandi.net (Postfix) with ESMTPS id C8269D80442
	for <xenomai@xenomai.org>; Mon,  4 Jul 2022 13:57:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4tXUunyOu1RaLMIcVv0okQUgy1JJXSfYhDDkiTWWdh2S1LjPpo+DrB+9i14iDdXxN7cvV/KjX3ZRnS3oUwiOuX9+OcvBJ1lyyp4phPTUyXgP1CGDeEuqqbGqzdAbLn+6xq80f4G95SazOoh4IGkVMPjZP18fDSU83r7OHYTO1w3d4Z0tecdszKXX8lqNhNueF7nfJXtv6dkxtI222JSYIV0PdtGjhxK6lW1v/T3RB0FQfpSngjhbZpTBJ5sjLPmYVlNtA6TufrIhxPRfVONPcghkt6oJ61+K+ND1A1ItDslFeu5gKgmweA73iW+XEELUY0LecdYL+0xm+Z8YbVa3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WoBvJhwbDkbyc47LsOsuRxRS4r1wy7hK8Y7UmQnyJJQ=;
 b=HPpdDo35r+o5ek6s3Uv4wyrP57MX4b5APS6EDyVi0A+S8dhQTTTh/ZDfJSyDpcoLtC9W+EB+TwoByT6BfjVQ+zdI5vgN0Jx2LTNdiw0qw6bEdCAdHPptP/yaxMKmWkRtjd/KIVm/Zg+RhnnWtIFhn9rst1y8/964c3JVRBgMvdUVt6EKkooJLztcCsibAYSWAaQ97u94bKLaV9hb9ZGOA7n8mlis510j4GwvxUbDDZZwGVKsalGy8tZUtjgtjVTx6CPKBcljme8uOXOPW1qqDGoLgTunYbVGuOthxMjT9gfhOHk1ldqqsTl8RgfgId4r2xJ+LUj3B7KnKxLXhaRBRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WoBvJhwbDkbyc47LsOsuRxRS4r1wy7hK8Y7UmQnyJJQ=;
 b=RDetaiy3nfAIc5Usv/3FDfvwzwj2pTv0j/8yksOi7b4pyTSBab5W1Q0+Y4/DGKE77JBC827ezTtI5U8MMD/yXx/98bbdQC1qGMrerJFablgOrV/sbvR8Sr4PfZ/JjHkMNJcLVM77wD1qVKIrFulZ5NSrZ54Z/X4ecHKzAL3dkkjcxs4xGG6fyUq1KLui9Qgr6dqFwYSiJ3idF7Wuv6+FYlgODnvXh/apOgD1LlF18dOw1OgnxGxLBvQbfGnO9hBFoHoQGLrYSpLKCEemz3GsatPpwvMEx/rNwtOKgd6NTdXZBpOb7PCVsiWPtbS3v/LGjAoTZwtyxWy57G562qCF3A==
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DBAPR10MB4122.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Mon, 4 Jul
 2022 13:57:08 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::31fa:3b8c:f022:4ac4]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::31fa:3b8c:f022:4ac4%4]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 13:57:08 +0000
From: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>, "jan.kiszka@siemens.com"
	<jan.kiszka@siemens.com>
CC: "gunter.grau@philips.com" <gunter.grau@philips.com>
Subject: Re: [PATCH 05/15] drivers/net: Switch to dev_addr_set
Thread-Topic: [PATCH 05/15] drivers/net: Switch to dev_addr_set
Thread-Index: AQHYj6dIF5BpXiXHPEqAcW1RxWvyKq1uPJcA
Date: Mon, 4 Jul 2022 13:57:08 +0000
Message-ID: <6d01cd44f4a10f771b47696de3bfc7c159819f00.camel@siemens.com>
References: <cover.1656940114.git.jan.kiszka@siemens.com>
	 <fed48b9dd1275fd788bbbc3571608b07b88d681e.1656940114.git.jan.kiszka@siemens.com>
In-Reply-To:
 <fed48b9dd1275fd788bbbc3571608b07b88d681e.1656940114.git.jan.kiszka@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.2 (3.44.2-1.fc36) 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2ea8d77-0375-4580-72ab-08da5dc515fb
x-ms-traffictypediagnostic: DBAPR10MB4122:EE_
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 IlwbRQsRLod6Zykh6XWINOjuXgjCng1CUv6rrZelnOUttw6V186w1QDmhIyxXFftdGiDxP8LHFgJhQIpjn3a45lwgtVADV9Bdj2R03y5vfuA4cj3Y1D/j9VpBoM2b9yOE0fBvh19Zrp0UzfMJqt71QbPXKeArYfsGUY5EsHpatsrgFhA+diK9IQPYvA/32v7w5s7ykXAgGRzUotDhXDeHpsHTwJi7sJp6+QUqlG8fl/9CXbjfJCk8cf9kxC+nUo9g7An1bjeu/bfbVJjT5H9kKYRpm2d+HTaJnonxpPi7ZWIlN35vDkMyrQb3NK/xkopCw4mRVQe/wSNNi1PxoLuAFMwT4UmuyhmAOakoUp7uxm25RBV/ClN4j6CTgP32j6dWaMEfda7/jaqcOc1hmAuTBgE9U3OaM0/0ukqAtw+M1Au7B25Yx8fHcL5IJIpcJVPvSIz4TgMTjuEDQKE1dZmDEkMgZSeZh/ZpPglwssZn2iex7onjLaZIDaT/nSv6kfUIEcHGzkf0ehwRuK1jP+/XnHZl9iMoi4h9c5sVZ9zP/wzf/6L8VkWN+uQotqH8KJSNQyODBIPptso8LEI96flZKtNA3XQU62J926obMtwI5C2Rn+q4uNybn1hLMHVb8/b2x5/6vb2GM0NpGJ/tkiafQ+2zNU4+e+eOrkMiO/CkIxVjP8g52LPoAVRWR6DQRZwt0V/jZL3ooYVwKgjUJiED/ZBgB0z2ZONBYBgjXRJ/XxIgKCn+ZKrLTgIDcX/0+mKuPjZNYfQAsNwHiAu5b2lZxjdCXhMij1C6YyVHgbf/Pg1I38H+NKo4tMSv8y147Zq
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(396003)(136003)(376002)(39860400002)(478600001)(5660300002)(8936002)(82960400001)(122000001)(110136005)(38070700005)(6636002)(316002)(86362001)(64756008)(66946007)(76116006)(6486002)(91956017)(71200400001)(66446008)(66476007)(8676002)(66556008)(4326008)(83380400001)(2616005)(186003)(6512007)(38100700002)(6506007)(41300700001)(2906002)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bXQ2RzZnY1MwMVd1V0p3dDVHNncrL3l2dEliYThGR2taNHJCTGZIcU4vSnpM?=
 =?utf-8?B?VkRrVXYrYU01THdnbnkvQ3BqMnM1NkNnQlhDVVcxYTZBR0tFdnZldEpOak5H?=
 =?utf-8?B?TVVvKzVFTnR0VGI3d1NTOUhyRStUMTVrU3AxaDV5MjdiaXBRMStQOWw3eXlT?=
 =?utf-8?B?Nzk3ak1QUzFDbWpCUjh2K2FKZnkraUJ0d2FjaUFVaUdDZGVWZTFFMGVzQ0Rt?=
 =?utf-8?B?VzMrVHVKaGE0a1gwVVlqRlJkMm5QLzEzTi9nMVd3alR6b1JYb3o1VkFOL3Nw?=
 =?utf-8?B?cVJHbStyV1dLUVZwRGJERE1uQUVUeFRTMXBYOGpaWlcrcmttaCttcWpCSnFV?=
 =?utf-8?B?N3pSZDJIWXZRS0U5VVg1SmpGakNWSENKSUVTMklqdXBJdlkvZDg3bHNjU3l2?=
 =?utf-8?B?RDNURys3Q09VR0xlZE1icFpGLzN1RUsyRmF2K1NwaGtkVmM2L0czUXYzT0Er?=
 =?utf-8?B?cW9jY0ZTcVlVRS9sTXljalZFcDNORU1hMXFaVGRsZUkwM2gyK2E2ak1JTUh6?=
 =?utf-8?B?M0lyQ0k2WWtGYis0K3NNcnBJdHgzSnVrdEM4dVJzVFcxVlJSTkRvV2d4UzdN?=
 =?utf-8?B?UGd0ZnZFRGdxQkJrS3o3T0JqQ2Q5ZkZsMXViZWh5UGw5OFNvUWNYa2IyNnVU?=
 =?utf-8?B?WTAwcEF3OHh4bHBMOGJreDlGeU41UC9tOXk3MkhVK29NYzJNR2lxT083K1lt?=
 =?utf-8?B?cnRuMHcwSHNDWmpoTkJJb1BBYlN2eCt1Y3dTS2FKcDFRZ0dwb3RidlVvZzBj?=
 =?utf-8?B?dWlKUGhwR3l1ckppSHlhSlRmbmdWdUc3R0QrbXBXZmZLSWIrd2ROajhvcTlV?=
 =?utf-8?B?a2tXUytYVWVGV1hwZGd0dE4wTS9DL2FXSVZtM0R1SHJiK0ZBUUEvTlQ2Tjdk?=
 =?utf-8?B?VklvM1lPejh3Rlh1bUVnNXJBek4yVjJnK3J4YUVCYWlycWhISis3c1ErNVFx?=
 =?utf-8?B?MnFiSjEzMXBWVDlrT2xNd3drMHpWVGUrVENyMXBhejRaYWRhQnZXdXBBdU9N?=
 =?utf-8?B?aExWcFNmYXR4Wm1NN3VoemRCWVgwTVZoQnV4a0o0TzNKTENlL1c2eG8xWGFy?=
 =?utf-8?B?UDZ0S04vY0txOG43OHVqb0R1cVdLTHNyR2J6aVlXcm1UZTAwNlVkVTVCUStq?=
 =?utf-8?B?dHAzYXgyT3ExcEJRbkRZVWc2UHU1K0V6ZU5wMTJ3NUlSejdqMmhBMG1hczBE?=
 =?utf-8?B?YWZqUTQ2NlY0QzBqNkdBOU15V25FYnIvMkdjN3JKZVMrc0MyUTBpVWJFS3Vl?=
 =?utf-8?B?VTQ4RTBjenR1ckNMZC9WS01xYXFsS0srRWcrQVJqMVVPRkdBMmpkRDMyMWpk?=
 =?utf-8?B?Z0RXNFNEY0VNT3o1T2lOTWg1T3lKbVE4dEg3bXlndW15NkNWeXdHaGRYRXBF?=
 =?utf-8?B?Ulh4NEZ1bWI4eXVlU1ZQa250RFp0TjBKQ0MwR2pXQkZkR1o5Y2E5bjZaYis2?=
 =?utf-8?B?a1JlVFRwajFiTVZxS2tLdnVjNnNVSzMrRWErTDRyc1ZEUHhHUkxwbEY4NFNB?=
 =?utf-8?B?WEdPMm5HbFhoREVJcC9vVUFkMlI0b2s4bG4yRVRnQmF5cE5DVWtqaXJDNktT?=
 =?utf-8?B?cHBWZzJXVzdZelJmNmtZRkl6ZUhiNEo1MVM2dDdMZXpMMVRCbnZQTWZHcTlM?=
 =?utf-8?B?b3NUN0dNczF0TTFJNWExajVsRCtBbkJrMDgxVkdDenB5VlFidTM3ZVB3M3JK?=
 =?utf-8?B?NzFNTWZRei90ZHFQZ09JbW1tY25kQ0w3ME1ENVV5TlVaQ3RYWlZCYmN0cEkz?=
 =?utf-8?B?TTI1UStRaXlueW9kbzNjUWNobmJvbGxnNlJuRjdEY2wveTZMdXBWMFpzeEtE?=
 =?utf-8?B?QTFJTnU1MmJKK0VXRkMyS1U0RkcySFJKWjY4YU5KNVp3NE9UV2NLSXRsb3pE?=
 =?utf-8?B?c3ZuMm5uRGZqcE1wQ2dvdXZKRWJRNWk5Q3FnWjJ1aGtCaGtpRkc5c3hkVkt2?=
 =?utf-8?B?RkR3Z1p0TVpjWDd3NVZLU0Fka3BkTEhkRFBJZ20yU05XZCtZSDRSR1BJaW1B?=
 =?utf-8?B?YVlDeEtYMVdtdW45S3FPTmI5VDIwZ1VTUGF2OWlyVlB4Mkk2cDNxQUc3ZW5R?=
 =?utf-8?B?K1R0R3IxNTlKVTZxVTExMXZvN0NGWVlKU0FnVDJMMFJWcURxaE8wKzl3dW5L?=
 =?utf-8?B?bkNqTjdPNFU4RUNtMmVoZXNiVEtINDNUNGNaa0wzbEE4bTRYNWVzNlBoWWhX?=
 =?utf-8?B?SUcyVXhZOFhlR3pJeW9hbkJxQ21RdnRBck1KekRjZnZ0citwdUM5N29hYVlR?=
 =?utf-8?B?bm1la3R3VTJYWi9XWnBOTmQzckN3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <10AF2564A848064F9C9502FB68B15A8E@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ea8d77-0375-4580-72ab-08da5dc515fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 13:57:08.4774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: //QtIyI07gS6DNpyF65zX3FsUn1zRfNYlTkahGM3Y6miDXlvRe0CqiRS3YUVifkfAfkxBTGo5ouQRGEGYGOQLqLcxT9TVtiHtqKJGOgAi30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4122
Received-SPF: pass (spool5: domain of siemens.com designates 40.107.21.82 as permitted sender) client-ip=40.107.21.82; envelope-from=florian.bezdeka@siemens.com; helo=EUR05-VI1-obe.outbound.protection.outlook.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=RDetaiy3;
	arc=pass ("microsoft.com:s=arcselector9901:i=1");
	dmarc=pass (policy=none) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of florian.bezdeka@siemens.com designates 40.107.21.82 as permitted sender) smtp.mailfrom=florian.bezdeka@siemens.com

T24gTW9uLCAyMDIyLTA3LTA0IGF0IDE1OjA4ICswMjAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBG
cm9tOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPiANCj4gTGF0ZXN0IGtl
cm5lbCBjb21wbGFpbiBhYm91dCBhY2Nlc3NpbmcgZGV2X2FkZHIgZGlyZWN0bHkgYW5kIHB1c2gg
dXMNCj4gdG93YXJkIHRoZSBhY2Nlc3NvciBmdW5jdGlvbnMuIFVzZSB0aGF0IGFuZCBwcm92aWRl
IGEgd3JhcHBlciBmb3INCj4ga2VybmVscyBwcmlvciB0byA1LjE1Lg0KPiANCj4gQ0M6IEd1bnRl
ciBHcmF1IDxndW50ZXIuZ3JhdUBwaGlsaXBzLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSmFuIEtp
c3prYSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4NCj4gLS0tDQo+ICBrZXJuZWwvY29iYWx0L2lu
Y2x1ZGUvYXNtLWdlbmVyaWMveGVub21haS93cmFwcGVycy5oIHwgIDQgKysrKw0KPiAga2VybmVs
L2RyaXZlcnMvbmV0L2FkZG9ucy9jYXAuYyAgICAgICAgICAgICAgICAgICAgICB8ICA1ICsrLS0t
DQo+ICBrZXJuZWwvZHJpdmVycy9uZXQvYWRkb25zL3Byb3h5LmMgICAgICAgICAgICAgICAgICAg
IHwgIDIgKy0NCj4gIGtlcm5lbC9kcml2ZXJzL25ldC9kcml2ZXJzL2ZyZWVzY2FsZS9mZWNfbWFp
bi5jICAgICAgfCAxMSArKysrKysrLS0tLQ0KPiAga2VybmVsL2RyaXZlcnMvbmV0L3N0YWNrL3J0
bWFjL3J0bWFjX3ZuaWMuYyAgICAgICAgICB8ICA1ICsrLS0tDQo+ICA1IGZpbGVzIGNoYW5nZWQs
IDE2IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2tl
cm5lbC9jb2JhbHQvaW5jbHVkZS9hc20tZ2VuZXJpYy94ZW5vbWFpL3dyYXBwZXJzLmggYi9rZXJu
ZWwvY29iYWx0L2luY2x1ZGUvYXNtLWdlbmVyaWMveGVub21haS93cmFwcGVycy5oDQo+IGluZGV4
IDg4MTUyYTI1ZTEuLjY0ODljODJjOGMgMTAwNjQ0DQo+IC0tLSBhL2tlcm5lbC9jb2JhbHQvaW5j
bHVkZS9hc20tZ2VuZXJpYy94ZW5vbWFpL3dyYXBwZXJzLmgNCj4gKysrIGIva2VybmVsL2NvYmFs
dC9pbmNsdWRlL2FzbS1nZW5lcmljL3hlbm9tYWkvd3JhcHBlcnMuaA0KPiBAQCAtNTQsNiArNTQs
MTAgQEANCj4gICNkZWZpbmUgY2xvc2VfZmQoX191ZmQpCV9fY2xvc2VfZmQoY3VycmVudC0+Zmls
ZXMsIF9fdWZkKQ0KPiAgI2VuZGlmDQo+ICANCj4gKyNpZiBMSU5VWF9WRVJTSU9OX0NPREUgPCBL
RVJORUxfVkVSU0lPTig1LDE1LDApDQo+ICsjZGVmaW5lIGRldl9hZGRyX3NldChkZXYsIGFkZHIp
CW1lbWNweSgoZGV2KS0+ZGV2X2FkZHIsIGFkZHIsIE1BWF9BRERSX0xFTikNCg0KVGhlIHdyYXBw
ZXIgZm9yIG9sZGVyIGtlcm5lbCBhbHdheXMgdXNlcyBNQVhfQUREUl9MRU4sIHNlZSBiZWxvdy4u
Lg0KDQo+ICsjZW5kaWYNCj4gKw0KPiAgI2lmIExJTlVYX1ZFUlNJT05fQ09ERSA8IEtFUk5FTF9W
RVJTSU9OKDUsMTcsMCkNCj4gICNkZWZpbmUgcGRlX2RhdGEoaSkJUERFX0RBVEEoaSkNCj4gICNl
bmRpZg0KPiBkaWZmIC0tZ2l0IGEva2VybmVsL2RyaXZlcnMvbmV0L2FkZG9ucy9jYXAuYyBiL2tl
cm5lbC9kcml2ZXJzL25ldC9hZGRvbnMvY2FwLmMNCj4gaW5kZXggMWU4NjQ0MDY5OS4uMzc4NGI2
NTIyNiAxMDA2NDQNCj4gLS0tIGEva2VybmVsL2RyaXZlcnMvbmV0L2FkZG9ucy9jYXAuYw0KPiAr
KysgYi9rZXJuZWwvZHJpdmVycy9uZXQvYWRkb25zL2NhcC5jDQo+IEBAIC0yNjMsOSArMjYzLDgg
QEAgc3RhdGljIGludCB0YXBfZGV2X29wZW4oc3RydWN0IG5ldF9kZXZpY2UgKmRldikNCj4gIAlp
ZiAoZXJyID09IDApDQo+ICAJCXJldHVybiAtRUlEUk07DQo+ICANCj4gLQltZW1jcHkoZGV2LT5k
ZXZfYWRkciwNCj4gLQkgICAgICAgKCooc3RydWN0IHJ0bmV0X2RldmljZSAqKiluZXRkZXZfcHJp
dihkZXYpKS0+ZGV2X2FkZHIsDQo+IC0JICAgICAgIE1BWF9BRERSX0xFTik7DQo+ICsJZGV2X2Fk
ZHJfc2V0KGRldiwNCj4gKwkJICAgICAoKihzdHJ1Y3QgcnRuZXRfZGV2aWNlICoqKW5ldGRldl9w
cml2KGRldikpLT5kZXZfYWRkcik7DQoNClRoaXMgb25lIGxvb2tzIGdvb2QuIE1BWF9BRERSX0xF
TiB3YXMgcHJldmlvdXNseSB1c2VkIGFzIHdlbGwuDQoNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4g
ZGlmZiAtLWdpdCBhL2tlcm5lbC9kcml2ZXJzL25ldC9hZGRvbnMvcHJveHkuYyBiL2tlcm5lbC9k
cml2ZXJzL25ldC9hZGRvbnMvcHJveHkuYw0KPiBpbmRleCBmNzA1ODc2NzhhLi5iMzdiNDJjOWRl
IDEwMDY0NA0KPiAtLS0gYS9rZXJuZWwvZHJpdmVycy9uZXQvYWRkb25zL3Byb3h5LmMNCj4gKysr
IGIva2VybmVsL2RyaXZlcnMvbmV0L2FkZG9ucy9wcm94eS5jDQo+IEBAIC0zMjEsNyArMzIxLDcg
QEAgc3RhdGljIHZvaWQgX19pbml0IHJ0bmV0cHJveHlfaW5pdChzdHJ1Y3QgbmV0X2RldmljZSAq
ZGV2KQ0KPiAgDQo+ICAJZGV2LT50eF9xdWV1ZV9sZW4gPSAwOw0KPiAgI2lmZGVmIENPTkZJR19Y
RU5PX0RSSVZFUlNfTkVUX0FERE9OX1BST1hZX0FSUA0KPiAtCW1lbWNweShkZXYtPmRldl9hZGRy
LCBydG5ldHByb3h5X3J0ZGV2LT5kZXZfYWRkciwgTUFYX0FERFJfTEVOKTsNCj4gKwlkZXZfYWRk
cl9zZXQoZGV2LCBydG5ldHByb3h5X3J0ZGV2LT5kZXZfYWRkcik7DQo+ICAjZWxzZQ0KPiAgCWRl
di0+ZmxhZ3MgfD0gSUZGX05PQVJQOw0KPiAgI2VuZGlmDQo+IGRpZmYgLS1naXQgYS9rZXJuZWwv
ZHJpdmVycy9uZXQvZHJpdmVycy9mcmVlc2NhbGUvZmVjX21haW4uYyBiL2tlcm5lbC9kcml2ZXJz
L25ldC9kcml2ZXJzL2ZyZWVzY2FsZS9mZWNfbWFpbi5jDQo+IGluZGV4IGJlMGVkMGM1MWUuLjcy
ZWU0ZGU3MzggMTAwNjQ0DQo+IC0tLSBhL2tlcm5lbC9kcml2ZXJzL25ldC9kcml2ZXJzL2ZyZWVz
Y2FsZS9mZWNfbWFpbi5jDQo+ICsrKyBiL2tlcm5lbC9kcml2ZXJzL25ldC9kcml2ZXJzL2ZyZWVz
Y2FsZS9mZWNfbWFpbi5jDQo+IEBAIC0xMzE1LDExICsxMzE1LDE0IEBAIHN0YXRpYyB2b2lkIGZl
Y19nZXRfbWFjKHN0cnVjdCBuZXRfZGV2aWNlICpuZGV2KQ0KPiAgCQlyZXR1cm47DQo+ICAJfQ0K
PiAgDQo+IC0JbWVtY3B5KG5kZXYtPmRldl9hZGRyLCBpYXAsIEVUSF9BTEVOKTsNCj4gLQ0KPiAg
CS8qIEFkanVzdCBNQUMgaWYgdXNpbmcgbWFjYWRkciAqLw0KPiAtCWlmIChpYXAgPT0gbWFjYWRk
cikNCj4gLQkJIG5kZXYtPmRldl9hZGRyW0VUSF9BTEVOLTFdID0gbWFjYWRkcltFVEhfQUxFTi0x
XSArIGZlcC0+ZGV2X2lkOw0KPiArCWlmIChpYXAgPT0gbWFjYWRkcikgew0KPiArCQltZW1jcHko
dG1wYWRkciwgbWFjYWRkciwgRVRIX0FMRU4pOw0KPiArCQl0bXBhZGRyW0VUSF9BTEVOLTFdICs9
IGZlcC0+ZGV2X2lkOw0KPiArCQlkZXZfYWRkcl9zZXQobmRldiwgdG1wYWRkcik7DQoNClJlbWVt
YmVyOiBUaGUgd3JhcHBlciBmb3Igb2xkZXIga2VybmVsIHVzZXMgTUFYX0FERFJfTEVOLCBidXQg
d2Ugb25seQ0Kc3VwcGx5IEVUSF9BTEVOIGJ5dGVzLCB3aGljaCBpcyBhIG1pc21hdGNoLCBpc24n
dCBpdD8NCg0KPiArCX0gZWxzZSB7DQo+ICsJCWRldl9hZGRyX3NldChuZGV2LCBpYXApOw0KPiAr
CX0NCj4gIH0NCj4gIA0KPiAgLyogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSAqLw0KPiBkaWZmIC0tZ2l0IGEv
a2VybmVsL2RyaXZlcnMvbmV0L3N0YWNrL3J0bWFjL3J0bWFjX3ZuaWMuYyBiL2tlcm5lbC9kcml2
ZXJzL25ldC9zdGFjay9ydG1hYy9ydG1hY192bmljLmMNCj4gaW5kZXggMTM4ZTI3NmFkOS4uNGI0
MTc4NWRiOCAxMDA2NDQNCj4gLS0tIGEva2VybmVsL2RyaXZlcnMvbmV0L3N0YWNrL3J0bWFjL3J0
bWFjX3ZuaWMuYw0KPiArKysgYi9rZXJuZWwvZHJpdmVycy9uZXQvc3RhY2svcnRtYWMvcnRtYWNf
dm5pYy5jDQo+IEBAIC0xMTQsOSArMTE0LDggQEAgc3RhdGljIHZvaWQgcnRtYWNfdm5pY19zaWdu
YWxfaGFuZGxlcihydGRtX25ydHNpZ190ICpucnRzaWcsIHZvaWQgKmFyZykNCj4gIA0KPiAgc3Rh
dGljIGludCBydG1hY192bmljX2NvcHlfbWFjKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpDQo+ICB7
DQo+IC0JbWVtY3B5KGRldi0+ZGV2X2FkZHIsDQo+IC0JICAgICAgICgqKHN0cnVjdCBydG5ldF9k
ZXZpY2UgKiopbmV0ZGV2X3ByaXYoZGV2KSktPmRldl9hZGRyLA0KPiAtCSAgICAgICBNQVhfQURE
Ul9MRU4pOw0KPiArCWRldl9hZGRyX3NldChkZXYsDQo+ICsJCSAgICAgKCooc3RydWN0IHJ0bmV0
X2RldmljZSAqKiluZXRkZXZfcHJpdihkZXYpKS0+ZGV2X2FkZHIpOw0KPiAgDQoNCkZpbmUgYWdh
aW4uDQoNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCg0K
