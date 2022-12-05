Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2055.outbound.protection.outlook.com [40.107.14.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7230E8485
	for <xenomai@lists.linux.dev>; Mon,  5 Dec 2022 18:29:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J69EmGDvCM4iQKpzBDNflpultzXNYv9Fpt54OFn54knBKJvmhve5LgQvrPDdU2Zft7cxiqCQBX/xGNHiu55Rb2k79GfRvzp62AVUSW2S9xxHWginTa9KzfJka27eEVczxIlSy3L4+/O39V4QGQtV9hsfQ5dm2O6LiUk0y5REwZSe3B2BtMk5olKAYRujna0bH8MXYmiIB1Ex2YlEFPg5UcdtXHsbrRrUnPVIIPBRctvMoRIFtrdoWWfXmpD+VZh+/3dSH1Sk61cJ37FNOpF3rRm+gy5zPFs0oacByAi7gFH5ezFsQ44wn/0dxhtJ86z0wfV+GkWU9wTxQDNfVxj7CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4T7L6RHYFfQALHxU59SDyUPvYNmMv7qd/s24JrtbGc=;
 b=FpM+zoWFh4utkPZDMohjYOX33+cGN3rqJZvkVPamVNI+Qks6RTYQnu+Y/unY+AHkFmamnc0tNMqgjXItrujCGuFNyy8vFAc3FXGzX50ItzhjgulWq6ccjsRcK3UIBbeOaTHqjoH/cbkLdYI6rJsDYwWhz6ZUUkQ82oQGKgM9AyDa/AknXy1LUJELTkFZrljgr1qFp8xYs87burPUT/g9YyhAwcTzefNUMQMEqN7Px48ZS8DLHMfpsAkHvA75Hg5Zeyj3Qzktdqr7Fm+4WvBoY7hn2t/JHfO1ETilm4HPAI6ocl/IppswA95LqQ77uXGYFHGYTrG2xl28zun9BW+l6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4T7L6RHYFfQALHxU59SDyUPvYNmMv7qd/s24JrtbGc=;
 b=nLDcxRDYQSYfgoflmZwXBQ/FcEDo1CCgdlgQLW7/izd0GA7GEp2QczCvQNh0cTC7QHJk7BAmW25JhoUsTrq4OETJGz0qAtLOJ+//FgcwhqhFEBFTMWSb081g3dXIv1I6212Q/GRJPTKj0/f6O3F2Yc6tL8adVjcdmnamcaKlbxO4OqnOKRqtW8VSj3cZGdgJfqxhlOn3ev2T6FW18izCPtxh3EviWEFedQhrLKBH8ICvKrfcaPg4NOV78qpOVuQeIMJ5xkIUiHXLgU/8WqGBCP5Tx7mGJpEy0AjAQHjBmJLZ39nZS6QIdhXXEsNUUEbRUphqFGtT68juc17vb6ftSw==
Received: from GV2PR10MB6067.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:af::8)
 by AS8PR10MB7523.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Mon, 5 Dec
 2022 18:29:15 +0000
Received: from GV2PR10MB6067.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2805:9acb:c8c4:ea7b]) by GV2PR10MB6067.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2805:9acb:c8c4:ea7b%4]) with mapi id 15.20.5880.013; Mon, 5 Dec 2022
 18:29:15 +0000
From: "Schaffner, Tobias" <tobias.schaffner@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
CC: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
Subject: Re: [PATCH v2 0/3] switchtest: test different migration types
Thread-Topic: [PATCH v2 0/3] switchtest: test different migration types
Thread-Index: AQHZCL079bbAOM0IOU+FrIPpiF8q5a5fiQgAgAAUcQA=
Date: Mon, 5 Dec 2022 18:29:15 +0000
Message-ID: <ebea9f5a-4606-1aba-c9f9-79a9d692b6ed@siemens.com>
References: <20221205152104.3555474-1-tobias.schaffner@siemens.com>
 <edba58e8-46a5-2d15-1f7d-616517119b1d@siemens.com>
In-Reply-To: <edba58e8-46a5-2d15-1f7d-616517119b1d@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR10MB6067:EE_|AS8PR10MB7523:EE_
x-ms-office365-filtering-correlation-id: 44e854e7-4e7e-4b7f-8f04-08dad6ee9d18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 3V9huPYVzu2iUk6uTsQcwi/22bcnLBsbabf0D02qiTmuDXPw5AelJokoJTplmtpPYlRzoj6nzkmNER1vBEjA4H3y6CdhTk4pWTOxAQLmM/ufz58J+bc+Y8/r/kqE1YeFSNeFtsNluhPIPw+fZVqBfKNFvZ1ral8/kAhLKk/24os9pAL1uiDKifwb5/IGMztWQZKe8DpLzFntRjp4bO1SFYYO28Ct+3aZvFb4W0bayt/6lwoFVJ9JDN2ew+V8x+c7IdFk4I8QGw89e3AB1EE6JoXgvbBVhTSPSIyAio3YkCT+ppZPCJMbG1qXtqRCRVA4su/htHlY6oQ33ySpdgum15PmblCbyjPCxJWGjo1UyIiRNZwCLoIMofpBDkYg1luViKnlHwV3gaqWCnJ35wKRDEU4CBqI5L3ydTeHoF3kEO0mL2Tdmpo8xx3+hCw3of/5+InHe1FROFjLN2TsR7prOgAG2K49VW3PQa7xMe7NW3kZvtcgJYAdQGrl5fWerZkS5qArAIpW82vUthhU4OcqzaPQhY872GNLe/dV4xnNmqS2YDBbYdO2I5HtdwBWo1WePtIsaCDWn3sSRQ4kMQIVn+aGbqjC4bR6lJ/FtVN6RUbOSXFue4Y+eLEG+maVPv9/UDdE/XLuvnhqHpDdEZebh4rww8xR+HNIKMlmaThyJOCvCLNSv/gHccvSUXZ5LI+ycYRMrNonIyi355LKGzR6mkMQKl2Pqd7Awc8xUfAsFAQo6YlDeVqi9Cwy0uDwPXoc
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6067.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(39860400002)(396003)(376002)(451199015)(36756003)(316002)(6486002)(6512007)(6506007)(53546011)(26005)(107886003)(186003)(110136005)(2906002)(31696002)(86362001)(83380400001)(66556008)(64756008)(66476007)(31686004)(38100700002)(4326008)(66446008)(8676002)(122000001)(76116006)(91956017)(66946007)(82960400001)(71200400001)(41300700001)(38070700005)(2616005)(478600001)(8936002)(5660300002)(21314003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TXIxZ0hHTmtodk1OZk1kM29VamR4cmdSbUtEd3VCaG91TndnWkRiNGhqUDk5?=
 =?utf-8?B?SXIwVDVhaEUvV01OSXJHRDNCbkFmOVNpUkxiSnZLa2E4clV0dGR0VjVhdDdL?=
 =?utf-8?B?ZzFxZDZjOWRHSnBrVUFuL05rVnFhVFVoT1YxK2xRbkorTzN5ODA0eGhhSHJx?=
 =?utf-8?B?Sk8vMFRKS05HT21wTWxmcmg3Q3JkaFpUdUR0aHFpeVc3MW9tYnlkUENEbEtO?=
 =?utf-8?B?UlZFSVU2RDBvTW5lOGhTVytLbWJ3dmhtTmg0Ui9VWnAzK1BHRnlGaDUxVzF4?=
 =?utf-8?B?b0o1Q3F0blJiVFVmTzdxbHE4SDFCUm5ZNUsxd0h6TWFkclhzZWEvUlNBdVFk?=
 =?utf-8?B?aGF1NVpIOXNvTFF5OFNxcitMTUFZMFVPRXlJOE9uR0lYN2FNNEhGUzZQSkZh?=
 =?utf-8?B?b0Ywb3dxa3A5cExuUk8zNnZQcVRPSXlDRE93RitYWVVnOXpQSEJ5cmFHdGg1?=
 =?utf-8?B?TUREck9Kc0hzaEJuekkrUVZpV3dOMXF4K1VUSjVNa2N6b20rUFpIY0tlUUw3?=
 =?utf-8?B?VzQ0OEQ2UzRURUkvbXd3VzF6MXpqN2F1VzVzUGJtOWpGdXQyanQ5Y0svSnl3?=
 =?utf-8?B?RVhyYlprdzU2MVoyY1B3NmJWekJSdkp2YVBiKytJdlovZnNCblRLM0J5NlFE?=
 =?utf-8?B?dG5IR0dXRE9WbEMvZU1wdDk0OThOb2FyVnVVSytuNm52ai9qYkhKYkgwV2tk?=
 =?utf-8?B?YklWVEx1cEZGY0pYM0hnMldFRTlGSXUyaUs2azBod090QUEwbWJaVHptcFhN?=
 =?utf-8?B?N2c2eWRhcE1OMDNTYkFBRmpseUtzNlBHRDlYOTl0UmxXZ0JaeUIvQ3JrdkM5?=
 =?utf-8?B?bDNaMEgwZ2dEZXh0QnoxclZtTi9rb0NNTU9xUTRCK3pKSDUvbThxNTlwZmJr?=
 =?utf-8?B?SmZCeFdhdFBmY3pWenlySUhXRGo2RzFwVFduSlZ3U1pFL1JXNU94eXBXZXFv?=
 =?utf-8?B?dkEyUUp1ek5CdlNJM0hOUVVGcTVoa09GUFlOTUFIZU9RZUFBNU9FVC9GSm53?=
 =?utf-8?B?UFdURm1OZGhKdUJqTDBoQkpadUVoZTd1dXhDaHFPaGpBeFpHclZ6Rmd3OGVr?=
 =?utf-8?B?RFZNWU90bHNaaXNPbHpOVG5vSVE5VDJmaFI2azBZOGE3M0RTREFpYk1IK2lH?=
 =?utf-8?B?SWRWdXNjaWxiQ0hLMUdGWUtrMksramZVNTc1Z21ja2ZmOHBPa0MxeVY4RDF3?=
 =?utf-8?B?NW1GRTNqbkVZYlIvZnVOR1VCN2h0ajJVMEFhdnVKZTRFTU1XM0d3ZmRHSTBH?=
 =?utf-8?B?RnI0Y1pucFhqOWh2UHJwb05zOENaUEdOc2JkeUhDY3hjWUhITnBneDBrdW95?=
 =?utf-8?B?SFJjeU9LdlFCV0w1WDYxMkp5Y01oTHFlSEVLYS90THVtREIrYUVXWlgwTkM3?=
 =?utf-8?B?azhCaHRTVXdzMjhVdkludjJ3a1RXcTFRekZZZG5mNXN2RUNrdmJtWGFzMXg5?=
 =?utf-8?B?WEVYUHlldEJnb3hZU2hSUHFFRmo2em5wbEpVdUxhcytWZDlYY09zc2pMRE1J?=
 =?utf-8?B?OW5lMFdZUDR1UGNmb25DMUM0ei8yeWkzUlF2YTBuNGt6b2FGcEFyMURuL210?=
 =?utf-8?B?NWE0SWVJajZkU0tramVwREdkbEhZcDJ6R050dzhsVnU5bjNmcU1BSm5jTzU3?=
 =?utf-8?B?S2QrdmVLbDJTQ2ljZ3BxOWxpTGZ3MlpoRHRhSnZxV0Vrcmpwd0RFTnpYTWpD?=
 =?utf-8?B?V3QvdW1ZVzNqdXBlK0NOS0pUZk5mTk10ZFBkZWtlTkhWYWV1RVZxYkZGOVNs?=
 =?utf-8?B?ckZ0OWlRbGh2TzdkeHlMUHpWQlhTQ25ZRDlSM0VCeVh1OHVxeWJyd2xVV1VB?=
 =?utf-8?B?cytDUXNvcEVsWVI1SDFrVzZvMy9uVGg2c05qRmJEOWRDRzJPNndGbjNpTCs0?=
 =?utf-8?B?RThPekJ4M0doSEluZkFjQkZRZkFsUDlNTW5kUmdyTTdVaVI1UWovV0ZzTTBD?=
 =?utf-8?B?aDNsMTJlb2hrN2F5RjI2RVBaUGwvUHl4TUVVeityNzFTNzJMcC8wTnRTVFhF?=
 =?utf-8?B?Y0hqSjR4THpIUzR5TWZBWExORFJHaTNIMHVEdFRtVXlQZkxSc1RRMjF0YmR4?=
 =?utf-8?B?TnFlTUhUM3JjR043Y1d4QnNZWnlrNDRDbjNaNCtBbzlycUszQS9JZnBXcUV1?=
 =?utf-8?B?QU53V2tucXlocmJndTl5V0lzR2M0cEdza0R0SDEyb25tUFF1Zk5neUtrdnI1?=
 =?utf-8?B?bFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B1B381FC8B5CD4E9FE073AFF8735275@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6067.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e854e7-4e7e-4b7f-8f04-08dad6ee9d18
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2022 18:29:15.2226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kyeE7Pam+g6SHqD+2hDkMTdBEYNwo+yjKc9W9J+j5YPTib1ZLo3p8kZUls9+44a4SY4mr/hL9NT9Zrd7K4hdEQXy0O92VlErNcP2uSSpyqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7523

T24gMDUuMTIuMjIgMTg6MTYsIEphbiBLaXN6a2Egd3JvdGU6DQo+IE9uIDA1LjEyLjIyIDE2OjIx
LCBULiBTY2hhZmZuZXIgd3JvdGU6DQo+PiBGcm9tOiBUb2JpYXMgU2NoYWZmbmVyIDx0b2JpYXMu
c2NoYWZmbmVyQHNpZW1lbnMuY29tPg0KPj4NCj4+IFN3aXRjaHRlc3Qgb25seSB0ZXN0ZWQgaW50
ZW5kZWQgc3dpdGNoZXMgYmV0d2VlbiBwcmltYXJ5IGFuZCBzZWNvbmRhcnkNCj4+IG1vZGUgaW4g
dXNlcmxhbmQuDQo+Pg0KPj4gTGV0IHRoZSBydHVvIHRocmVhZCBhbHNvIHRlc3QgZmF1bHQgYmFz
ZWQgbWlncmF0aW9ucyBhbmQgbWlncmF0aW9ucyB0aGF0DQo+PiBvY2N1ciB3aGlsZSBpbiBrZXJu
ZWwgbW9kZS4NCj4+DQo+PiBUaGlzIHBhdGNoIHNlcmllcyB3aWxsIGFsc28gdGVzdCB0aGUgYnVn
IHRoYXQgd2FzIGZpeGVkIGluDQo+PiA4MjlkNGQzM2NiN2FhM2VlNDg1YWQ1NmRhNmFjMGMzYjBj
ZTVkYmU1DQo+Pg0KPiANCj4gRG9lcyBpdCB0cmlnZ2VyIG92ZXIgYW4gdW5wYXRjaGVkIHZlcnNp
b24/DQo+IA0KPiBUaGFua3MgZm9yIGxvb2tpbmcgaW50byB0aGlzIQ0KPiANCj4gSmFuDQoNCkhp
IEphbiwNCg0KeWVzLCB0aGUgcGF0Y2hlcyB0cmlnZ2VyIHRoZSBkZXNjcmliZWQgRlBVIGVycm9y
cyB3aGVuIHlvdXIgZml4IGlzIHJlbW92ZWQuDQoNCkJlc3QNCg0KPj4gQ2hhbmdlcyBzaW5jZSB2
MToNCj4+IC0gU3F1YXNoIHBhdGNoZXMgMSBhbmQgMiBhc3dlbGwgYXMgMyBhbmQgNA0KPj4gLSBD
YWxsIHRoZSBjb3JyZWN0IHJ0c3dpdGNoX3RvX3h4eCBmdW5jdGlvbiBhZnRlciBtb2RlIHN3aXRj
aCBpbiB0aGUNCj4+ICAgIHN3aXRjaHRlc3QgZHJpdmVyDQo+PiAtIE9ubHkgc3dpdGNoIHRvIHNl
Y29uZGFyeSBtb2RlIGJ5IHVzaW5nIGEgbGludXggc3lzY2FsbCBvciBieSBhIGNhbGwgdG8NCj4+
ICAgIGNvYmFsdF90aHJlYWRfcmVsYXgoKQ0KPj4NCj4+IFRvYmlhcyBTY2hhZmZuZXIgKDMpOg0K
Pj4gICAgc3dpdGNodGVzdDogc3BsaXQgdGhlIHNldF9tb2RlIG1ldGhvZA0KPj4gICAgc3dpdGNo
dGVzdDogdGVzdCBtdWx0aXBsZSBzZWNvbmRhcnkgc3dpdGNoIGNhc2VzDQo+PiAgICBzd2l0Y2h0
ZXN0OiB0ZXN0IG1vZGUgc3dpdGNoZSB3aGlsZSBpbiBrZXJuZWwgbW9kZQ0KPj4NCj4+ICAgaW5j
bHVkZS9ydGRtL3VhcGkvdGVzdGluZy5oICAgICAgICAgfCAgMTAgKysNCj4+ICAga2VybmVsL2Ry
aXZlcnMvdGVzdGluZy9zd2l0Y2h0ZXN0LmMgfCAgIDggKysNCj4+ICAgdGVzdHN1aXRlL3N3aXRj
aHRlc3Qvc3dpdGNodGVzdC5jICAgfCAxNDIgKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLQ0K
Pj4gICAzIGZpbGVzIGNoYW5nZWQsIDEyNiBpbnNlcnRpb25zKCspLCAzNCBkZWxldGlvbnMoLSkN
Cj4+DQo+IA0K
