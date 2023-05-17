Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2108.outbound.protection.outlook.com [40.107.105.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2CE1FDF
	for <xenomai@lists.linux.dev>; Wed, 17 May 2023 07:16:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LoBqZKTrzXz1akEkeSdhYsI+lIIVcfVeNhfLlI7/QCL2inonjOc/NgWp+8HWrGGbuJ1Frm0q4vAtgf6FtaXKlqMoAcQa6jeW4lN7+31HNbN0G49HK7sfe/urD2JXd1Bu2Q9lnHMSSD8vN2G2QARZdbuhFRPXXybEePULkfQ7KEhDWivo7zn0Oni3qURvSldmxQbijV+dInNFJDx6+ArICh8YiVNaa8fv+cg8woukbVYRLMIcWFkLnlcFYhXTyHn1HcKiZ32rmodPc//8sHQDqPrKAy83R7OIP8GdeYOV09q8duR80DubV9cwB6e50tJ/czopoFSM/BnvRiTOuOphcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hV8rEZutuLczyis+shL1T0AQnTZUZi6o+dRFV6BdFs0=;
 b=RTyYjOummbZDwTVtZTNnK7ZcRq8/G9DncL56ppo3qYM23BQg8ddeUCiEPPbSGgQC0oXxsTGlF10y4iFWnTba05hpE7tQOevFWFoxFRXx/hMG0AEYnai6N+AEukzHrPW6x7yk/sGYN6OogodcUAy3u+J2pcurGim5Gh8ahbBY850aa5GzmdbflWi0JwV+2QTvhO4XeMmk8HD0DuU7QQyvxnFZ2yd4OrzK/AMerXYrt7M6HOFItDuOH79gtusH2yZGbSL77sryn6N+Cys9UYRkU60m8DJeXPznWV9fDTrwvKl435YJajmLg7Nv/EO06wYnjbrZShti4J5TS3CdDYZbzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigmatek.at; dmarc=pass action=none header.from=sigmatek.at;
 dkim=pass header.d=sigmatek.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigmatek.at;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hV8rEZutuLczyis+shL1T0AQnTZUZi6o+dRFV6BdFs0=;
 b=GQvHvccmB1j/fyOPLx0N5ZedsKayGC8/ThL4OcrggLLXGLH2lRe7uluhUsDNPcnqCZgfc1O4j/Y9AWtd+clXdJC5fjWU6QdDUpAuDDZKyDS4bJv4+/a038z+nxZoxAnFP3CpcYC4RJewDFf1Ua+WY0UeEV1KZwHitxfiO+2CJbY=
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com (2603:10a6:802:a8::22)
 by AS2PR08MB10350.eurprd08.prod.outlook.com (2603:10a6:20b:57a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.32; Wed, 17 May
 2023 07:16:50 +0000
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::6887:9d98:888d:e700]) by VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::6887:9d98:888d:e700%3]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 07:16:49 +0000
From: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Subject: RE: Meet-up around EOSS (Prague, end of June)
Thread-Topic: Meet-up around EOSS (Prague, end of June)
Thread-Index: AQHZRo/oD2ZvNv9Bukqvj53fOp/aRq9ekNmAgAAAqIA=
Date: Wed, 17 May 2023 07:16:49 +0000
Message-ID:
 <VE1PR08MB4909EC2EF0C817C923B271CA927E9@VE1PR08MB4909.eurprd08.prod.outlook.com>
References: <de5bac83-77b1-87bf-1a66-c1e712e52a7c@siemens.com>
 <5a62a0fe-d60c-9ded-cf89-2ebfc53a85d0@siemens.com>
In-Reply-To: <5a62a0fe-d60c-9ded-cf89-2ebfc53a85d0@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sigmatek.at;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VE1PR08MB4909:EE_|AS2PR08MB10350:EE_
x-ms-office365-filtering-correlation-id: 2bff778c-e867-4b09-cfea-08db56a6ae94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 y3f7jEdtuvS/CXD9kaEzKMgjTZW4MAsofildgmKTVjklwt7QYyqNXWDePr0hyqK7OFUa0kIPmirGIC6i1fgzqHIXILqSxb0OKX/OUhLb0CR3BdlNt9vbMQnrYgtLl6sohnCazIYjX3UwgxdU6ttWtwf5SnrGuPTzkRS4kQYP7V9EJSGotIWQiQKgyIBkuQJVZlTh4AkCVs0wfPfDxdFBQrBFknOTp8TmLqyu7LhU8TJ9BmJgCAc1aDFKbCyHZObEsLMJ0BY5pdd2/uYss6yG6ZMcEoMf6wfEg0MMWR5fBMsjYDfS1vrGHkvXRVvELSReJKvTtf5kig4rH8ZtakLjJmOWDWyQqJRFZNTwk230LHNJI/W5n34tqJHdKNw+Eh9088CfqjXMHU22EbewtjnVx2KSa4PSfyph9HYkr9fkERXYYAxe3IverkUpIKJQuDMKYpKAvV7wuD4WksMK+tQp5EPoIzLKolq18NVvs+JhVicLRzPwHBSwoUXH4EDNe2p7K0h5GxqGqCaZYlNck2Fs653pyOnl935OI28+KqXRAdGIsjGluWj9pz5mvJwIfI+s53PBj3g/+V2kQobflvzpdq6bUBf6/QWTzPeSPWHNcoo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4909.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39840400004)(366004)(451199021)(5660300002)(52536014)(76116006)(66556008)(66476007)(2906002)(44832011)(66946007)(64756008)(41300700001)(38070700005)(66446008)(316002)(86362001)(110136005)(8936002)(8676002)(478600001)(38100700002)(71200400001)(122000001)(7696005)(966005)(186003)(55016003)(9686003)(53546011)(6506007)(26005)(33656002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dzVnQ3VON1NTVkE1c2R1RXB1MlhZOXB1OXRsL2ZDNFVCZC9MTlZLRnBYNjJt?=
 =?utf-8?B?OXBSbVNPek5zUFFwbEV2NG5HZ0M1aW9JNE1xMGp0K2ttdHNDUEh5UWRNd0VK?=
 =?utf-8?B?RlhndzhvZFlZT1dBcGVqZTRmanpud3JEYjZ0NTdVdVp6dmJSNEdCN3FBb0Vu?=
 =?utf-8?B?MVRqUHVYcVVxS3NpS2ltMy9jbS9Cd0pqTWdCQ0JPaHJUamtoVStKSGtpYWZt?=
 =?utf-8?B?QmNreC9OQXJLbnpZTFJvWU9VQzFWL01qckM2Skc4TFZxRmhVMGd0bVRsVGNz?=
 =?utf-8?B?N09TNGd2N205NEVDUExMUGFjVzg1K2ZFc1lKaURXOTJnMTJQc3dqY3pOK0hp?=
 =?utf-8?B?UG1OdEhQR3V3eFdSeUdLV1lsZC9sL1V1TVF2MXZ3NXRRTDEwT0YrS0tmakxC?=
 =?utf-8?B?ZWNqaUVINWJjazdVUnNMRVY0RThLYlp3dUtpZlhNbVNhRjVobW9mVWlXcUZB?=
 =?utf-8?B?akxyVVowdWVROWxsNU1TRHNuNXJyNEQrZWZEQlliMFZGZlFmT0VlSHN2ZlhH?=
 =?utf-8?B?b2ZqNDBQQ2hvLzhLbUtJY0xpSS8xNGFaSWtlNjVKSVVsTFlqMktxdS8zTmx0?=
 =?utf-8?B?YWZzSzdEVDhmNmxNUjdKeHFMeGJpNDNiZ29IekR2RHFabTY3ZTlGdmJ3Ui9Z?=
 =?utf-8?B?cmVkRDVsNFdUS2wxUXhFYTFxWmsxL3VGWU8wcjVRc29YM0tmTm5MWjdudmFP?=
 =?utf-8?B?U1pZM3pGMG5XT1p2a2MrSzBCQ3hzMTg1amlXVHI2aWx0bHN5bS85eHhaQUcx?=
 =?utf-8?B?cGJsVDIxbGhSMUx2N0JObS9QQkcyczF4UWYvZXd1ZVJCT0ZNKzJnSCtVbTlm?=
 =?utf-8?B?anJlTnAwZHhOTXZvd1MyVXdXRy8vRVlKNGJqZ2l1ZnhYMlI1SnF4ZzlhZERi?=
 =?utf-8?B?SlBZdVZBdXA0TVVzU0M2L2UrTUxVdG9Nc0c5NHdYc0wwbERwN3hUZk1JNWhP?=
 =?utf-8?B?M3BYcXVPVjMvdmJHVjRzSTdtckxWQTFxMVh6T3NHZ0w1Sy9VUWZUb2FOcjZx?=
 =?utf-8?B?QXN6ME0wdGhlMjRRUnNaL0JRai85dTFMZ2QyeHhzeEhRcVNJenovVjNWa0pO?=
 =?utf-8?B?cFRhbjdSQUxSRnBBNkRXOVVDNkMzOWZzNUI5czRKMkhzYklnNHJCOUhiVHp5?=
 =?utf-8?B?aHhWWmEwS1BudjZYNzBERVJZbzYrRnRxTkZNaE5YMmtyeXYvcHdBaEovekxq?=
 =?utf-8?B?NzhzYTRPZFZmZ3RYQVZBakRmM1BDeXNFUFBoVjZSRlM0NUVLRThDQ25jeFlK?=
 =?utf-8?B?ODNLL2RhcWFRK3ZpWE5WS3cyUVpHTkdUa3lXWk1rR1JyY25zM292K1ljYWxo?=
 =?utf-8?B?WlJJNE5vNXpkT2RJU1pDSjJ1dHlJNHROK0FyUlNnY1Q4ZmU4NVdLeDExRzha?=
 =?utf-8?B?QkFaSFM0V2hsNjdjVldZNytrRVdvMHVNSDRKYW96eStPYmlaL0RIbFNWOFJ1?=
 =?utf-8?B?eTBpbEtFWHlwbVpESWtJZWhieWEvSVFOanh0UDZ6aitha1FlMDFySStudi96?=
 =?utf-8?B?MDdlZ0tNUnJJMzJ1S0I2TXM0cTdXaGZPajhHelhQZ0lLLzNBa0F1N0xvT2Mw?=
 =?utf-8?B?YzEvSlJCUC9WMjFkUXdtOHdwNzJqMjFaMTZmcCt3YzZJZ2dBNnovR1lrY0pO?=
 =?utf-8?B?bDZFMVJtaTRabU1JKzlibDVSL01zb1Y5bThBTkJLTURyYlp4dnhVNmIxZUNs?=
 =?utf-8?B?aWtUOUlmN1Z6N2hLcU5mbFZucUFvUDRWcUNJYjNqYmRrUUExcHkvSkJyeDE2?=
 =?utf-8?B?alV6b2pNOFFLbzJqanJjQzhKR2JuNnBUTWwxb1Z4UHRrcjlVdkU4UUV5SHUy?=
 =?utf-8?B?U1VZa3NyMVRYU2l1ME5vRFhISTVtZGJ3ZGhITVBXSnBFWXdNQW1wbnlYcU5D?=
 =?utf-8?B?V25hRjFhdVYwVFM0N2R2d254NXpQeGE4TGw5SXdSOGJaSi9QYUJ1eUZ0bUIw?=
 =?utf-8?B?NWNTNUR3aEE3RG02YXZ6cTdZL09aQ040RHFQdFNDQS9seHBBMENqZ0JDWlg0?=
 =?utf-8?B?VGtBWWdNT1NXNGJYVGRnOU5JejROLzRVNFVnVkJOeTN2M1dNWlR4S0wrTC93?=
 =?utf-8?B?TW44MmFvS3BpZitOaHZEUHdjRE9vWFRkU0xRYU9ROHFFMm9xbHcwdjZHaGVo?=
 =?utf-8?B?ZEVtZ0dVQnNPd1lFcUgrcDVCdnBEcXJQNENFTGZNQ1BhVDIxNmhXMkdtc0lP?=
 =?utf-8?B?akE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: sigmatek.at
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4909.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bff778c-e867-4b09-cfea-08db56a6ae94
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 07:16:49.6477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bcb1d87a-d2bc-486e-a62b-9ac9c746bc1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C2fU0ncJv0KPS8QpSWwOvqLhZE3c0+ZNaLHPAL5ZOtxegZNh8E/ESDup6eEJOJQpE8i4jKtL/Gm9tva54uDGhYfa+vtYVbNhr4B5x6jtQLE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10350

SGV5LA0KDQpBcyBJIGRpZCBub3Qgd3JpdGUgaGVyZSBiZWZvcmUsIGhvcGUgSSBhbSBpbmNsdWRl
ZCBpbiB0aGUgdGhyZWUgb3RoZXIgcGVvcGxlLiA6LSkNCg0KSm9oYW5uZXMNCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVtZW5z
LmNvbT4NCj4gU2VudDogTWl0dHdvY2gsIDE3LiBNYWkgMjAyMyAwOToxMw0KPiBUbzogWGVub21h
aSA8eGVub21haUBsaXN0cy5saW51eC5kZXY+DQo+IFN1YmplY3Q6IFJlOiBNZWV0LXVwIGFyb3Vu
ZCBFT1NTIChQcmFndWUsIGVuZCBvZiBKdW5lKQ0KPiANCj4gQ0FVVElPTjogRXh0ZXJuYWwgRS1N
YWlsICENCj4gDQo+IE9uIDIyLjAyLjIzIDA4OjMyLCBKYW4gS2lzemthIHdyb3RlOg0KPiA+IEhp
IGFsbCwNCj4gPg0KPiA+IGFzIGp1c3QgZGlzY3Vzc2VkIGluIHRoZSBjb21tdW5pdHkgY2FsbCwg
SSdkIGxpa2UgdG8gcHJvcG9zZSBoYXZpbmcgYQ0KPiA+IFhlbm9tYWkgbWVldC11cCBhdCBvciBh
cm91bmQgdGhlIEVtYmVkZGVkIE9wZW4gU291cmNlIFN1bW1pdCBpbiBQcmFndWUNCj4gPiB0aGlz
IHllYXIgWzFdLiBJZiB5b3UgcGxhbiB0byBnbyB0aGVyZSAtIEkgZG8gLSBhbmQgYXJlIGludGVy
ZXN0ZWQgaW4NCj4gPiBjaGF0dGluZyBhYm91dCBYZW5vbWFpIHRvcGljcyBmYWNlLXRvLWZhY2Us
IHBsZWFzZSBsZXQgdXMga25vdy4NCj4gPiBEZXBlbmRpbmcgb24gdGhlIGZlZWRiYWNrLCB3ZSB3
b3VsZCBtYWtlIHRoaXMgbW9yZSBvciBsZXNzIGZvcm1hbCwgZnJvbQ0KPiA+IGxvb2tpbmcgZm9y
IGEgcmVhbCBtZWV0aW5nIHJvb20gdG8gZGVmaW5pbmcgYSB0aW1lIGFuZCBwbGFjZSB0byBoYXZl
DQo+ID4gZGlubmVyIGFuZCBiZWVyIHRvZ2V0aGVyLg0KPiA+DQo+ID4gQlRXLCB0aGUgQ0ZQIGZv
ciBFT1NTIGlzIHN0aWxsIG9wZW4gZm9yIGEgZmV3IG1vcmUgZGF5cyBpbiBjYXNlIHlvdSB3YW50
DQo+ID4gdG8gdGFsayBhYm91dCB5b3VyIGxhdGVzdCBncmVhdCBYZW5vbWFpIHByb2plY3QgYXQg
dGhpcyBldmVudC4NCj4gPg0KPiA+IEphbg0KPiA+DQo+ID4gWzFdIGh0dHBzOi8vZXZlbnRzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvZW1iZWRkZWQtb3Blbi1zb3VyY2Utc3VtbWl0Lw0KPiA+DQo+IA0K
PiBKdXN0IGEgcmVtaW5kZXIgdGhhdCB3ZSBzaXRsbCBwbGFuIHRvIGhhdmUgYW4gaW5mb3JtYWwg
bWVldHVwIHRoZXJlLA0KPiBsaWtlbHkgaW4gc29tZSBuaWNlIHBsYWNlIGZvciBkaW5uZXIgYW5k
IGRyaW5rcy4gQmVzaWRlcyBSaWNoYXJkLCBhdA0KPiBsZWFzdCAzIG1vcmUgZm9sa3Mgc2lnbmFs
ZWQgdG8gam9pbi4NCj4gDQo+IEphbg0KPiANCj4gLS0NCj4gU2llbWVucyBBRywgVGVjaG5vbG9n
eQ0KPiBDb21wZXRlbmNlIENlbnRlciBFbWJlZGRlZCBMaW51eA0KPiANCg0K
