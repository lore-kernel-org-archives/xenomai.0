Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2082.outbound.protection.outlook.com [40.107.21.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5109B10FE
	for <xenomai@lists.linux.dev>; Wed,  5 Jul 2023 07:05:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GkyPiy0czesIPAQrPY7mvCukU3VMUpl38tu40D325z0CQcHSKCdEI4tzw2pQlTsTRKGG5AY2S/gD/oVsS7VcWDrZP2dXcpSumwwYZskNna7cxLWv8DE9NAbct/rRZ+3c1eOtCxE7fg88ZL8dvRm6pr9qJwn3RwgiOTbtN63pyKJ2V/ajv6flboFw0I25ABqnGqjF5YpW7EEFLdoZJxQuvikeGIoDykLy73HRCYSAw6gVnvTKURj9MRVXPvLsbJmoZxFZISFamw7AJpmfihAGHqpJwkzfJwMoJJ8sTHV8NlI3uCqhZsMG/08wzgrZ3+WfvGiSM6p2CbYQYQQMlqm0Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uuw81RFO9n1kFemk0pvlBlkrrcqEz3ZMUPzwsqMedXw=;
 b=Tmauhw9V8gnu1RlXR+K08O+hY+wjmdWaUG419MZo+IbBCi14NQCZUzlsB6KzBrfb/pO6tuM1LoArB5WPkuYy/5fdg1u3nxtcx/Y27ZuVOnwBtdegeJS/lOtYULp+8Gd2F8HlvTtP/Ohu4tHd/nsD+97qnjvu9p7llti3BXmItiaSgVvub3NiF4qsHzQqGxWrHdi7Vh+c1nTdiN38d970Mt1BYicSPkUZ5U9c7Hwm1eBHkrk3KnBjXU1f5OSQXiH+zml5Bl62OMFe5vw1o51hRUqN4JsKO6u9WwQXGTXX/Ys+Pbc4ikvde74FLPIYNAW+5HHIPQCLFYhlOwOTpsC7Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuw81RFO9n1kFemk0pvlBlkrrcqEz3ZMUPzwsqMedXw=;
 b=wVBMLlf6lkmIl2N06VqPj1Y6QJtkEHdMbflAPwiscmUYrKR3d7uky1nwt/Kb38v9tzepqhX3lMReDB89jXnuG5QgSoE9bdLIGTPWPEfzETOtnEvm0aBgBcNLshj6qSdkKHa5kP1NY9NndY8bcEx6XxUFKFy3vNpn+LzN/JrNyWFl0ANAo0fuGr7+KL4MLJKUaW9Mt7M5xE36X6EtrhLmUzSKad/ZqqXbzamGQxAJB8H1/d8NFucI/z8HGBOHCawF+0/SHLfQ0m8UBq7RJBzXmD03qUTE93K5BxKuxgSv3nEYMNGIppHiG3jjZHbRKhs+3J+GnyzcepK7/sZNo33YjQ==
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB4PR10MB6309.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:383::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 07:05:24 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::340:b481:b8d8:81e8]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::340:b481:b8d8:81e8%7]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 07:05:24 +0000
From: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: Re: [PATCH 00/12] y2038: Add time64_t support to scheduler and thread
 APIs
Thread-Topic: [PATCH 00/12] y2038: Add time64_t support to scheduler and
 thread APIs
Thread-Index: AQHZrwtMevRQKjU1106oIKJc0IhAMK+qvOyAgAADH4A=
Date: Wed, 5 Jul 2023 07:05:24 +0000
Message-ID: <d33cf5d4913f71182682bc1fcc8d12ff94237053.camel@siemens.com>
References:
 <20230630-florian-y2038-part-four-upstreaming-v1-0-604a089542c2@siemens.com>
	 <bbded65d-a4df-1570-26f3-fab45bc71d1e@siemens.com>
In-Reply-To: <bbded65d-a4df-1570-26f3-fab45bc71d1e@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.46.4 (3.46.4-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB5712:EE_|DB4PR10MB6309:EE_
x-ms-office365-filtering-correlation-id: 3b23dcb0-cdc1-4f3a-4ab6-08db7d263449
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 z420+LfHMJUxj+D96AXl4eoKpORngrYg6XXaiamZ9tQMuhxsRrzLbzJaz7SKCH7LfY5/1mtNh5hQybs0H2lgIcrbuPju6lwwTlb7qGU4N0Ei3gwYE7kixO4mKcObvlBfcTqkuyFtWgrmzQOm8NfJiA7ppukT+4TU4wOx+f++jEVEvVvfONxRQq6BS1wcEa4YaSPS5RKScfBJaz2gR1shAIZdkfHu8yK3RT4famlZ/ckqMVn0rBIWoWggXfI0bmqjO6NGu9jkhChfFdNTj35jUYEK/PzKjJrEYwltxCCHafCB3I+YeRHACIzGAZY5ojtZh4Lgh4gOzulYMOnigZz+qfhQS2qxdCeMkoV939WnAuce2dL+0ijLiV3dQuJpGwRIKXh59Zx+9Upd6J/ED0DpIjuyih6atjMLNaKq/MQBIS2kwdB+K9VQIpd/fY+PgXz2fpOgrAdJJwCBk1WcRHHQaZGW48pXR7mYAu9zUiFscfl1BO44TCNFXlSuUhSQqB5vPstQN3Kcgc0u0lM/OOOVSWKXAKgCqmQGtu5jSGN5fNp67OMkdj0B+eM2UBp7impZhMNYwnKkuj23AHkzcnMJoUry6fbYMUPTx+5Jamji1Kg00QKUT1RmeYvPZGed1cwd
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(451199021)(38100700002)(2906002)(71200400001)(6486002)(36756003)(8936002)(8676002)(38070700005)(110136005)(478600001)(5660300002)(76116006)(66946007)(53546011)(66556008)(66476007)(91956017)(6512007)(26005)(86362001)(66446008)(6506007)(186003)(64756008)(41300700001)(316002)(83380400001)(2616005)(122000001)(82960400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M1FFSENMM2RNUEFqRHZGb3F3NkVUeldTSGFhbWt2MzFBTXk5c2dEaWJNOGV5?=
 =?utf-8?B?YS9uOFIvVkVTMjd5TEh5VitLZW5EaWYwZmtIVmFXbWlZaGJ1UXA4UE9GYVgr?=
 =?utf-8?B?WGpwdTlEWndjRG9jSW5HOXNUZUVUdVZLaW9xWXRJdThtVjVKcTNtcFo0YWlI?=
 =?utf-8?B?Q25UUTl0alR2d0tnTGtzNU8yZXM5L0hRSXN0ZnBBQzRNRkt5dDhtZ0QyS01G?=
 =?utf-8?B?bWs3OWNFb3FmeENZWlV6OFN3OGJBVERXMFNCRWFpL1UvbEdTUGJsZ0t0RVNN?=
 =?utf-8?B?ZHhSUWFBQ1M0cU5YVGVUemM3QzFUU2pGSEFFZUtjd2N0M0cxQ2tJWmtYd2Y4?=
 =?utf-8?B?ZWo1SzBFbEJZeXBOOTFlY3ovTnoyR3cvQnRHSFBsa21qRlRJYllUTjh5VkhI?=
 =?utf-8?B?Uit1bEZodzBYNWs5ZEx4UjNwb1RaY0tjYk5oNlFTN21Ddm1xSllPeW1wOWhJ?=
 =?utf-8?B?a3JYU25xZVMxcll4SlludGVoMHFqaUxhWTEvWkxnQW0xUHFXVHdNMFM2UUJV?=
 =?utf-8?B?ZkxUL1JQYlRvU25lNEcxQlE3M09oT3Fhc252dzlZeSt6ZFFwZG93MnNWazFl?=
 =?utf-8?B?RFQ5ZHhRbzNyQ3dzUm1qUHo3NFRNWXpObmZpdStjNDBONkg3Z3RTSXh4WnZO?=
 =?utf-8?B?QytFeUlrTDUrRDRWVC9DR3R0NVMrUmsvQmJtL3JPN2VHcTVabnhnZWlkMEM2?=
 =?utf-8?B?eDYrUyt4dHh2azRHUlNHanI5ekZSSHVFdXA3aU5EU3NmVCt3Sk1icTFEbC9v?=
 =?utf-8?B?d3Z4dFkvYUg1TUtEZFptUVgrRXhDZnhLVjl6ZkdKSWVESW9TRTQvMHM3YUJs?=
 =?utf-8?B?TDlIbHR5OHR6VWFzZ091aHgwVGg1b01MSnhteGhmK1VjejJ6OEVveVE1cjRW?=
 =?utf-8?B?eWJ2bEVva2pKQ1phODd5S0RDaXBKWXJTZW51TFhxMTBsTmduenNleEFXVUMx?=
 =?utf-8?B?ek1kTmdxcThrRUkvQzV2TW5uSTlTc3hMMjJxTUdzb2lkbU8wWGllcHA5YkpU?=
 =?utf-8?B?dDJkb0ZyM2Z4V0FoUW04WWtpeWFjVGJJdDVjZzlOY01pNjR2YWVRNWRDWE5y?=
 =?utf-8?B?VFF6ZXM5cXEwM0NDdkxzRGpzSnhUeHNpWDluREVxVm1QQm4vQXR4VE8vQWdo?=
 =?utf-8?B?TkpuVDFEVGV2VE0rN2d1bzhtc2gxRTgrU1pyVDRFZlFGSVE1MzIyeGlIaysz?=
 =?utf-8?B?WkkzVU9CN2dqYThWOFBmVFNFZ29uYjZBNERXZVVja2lQU2ZwR0pRSTIrOWVS?=
 =?utf-8?B?YzkxZXgySzdTaTZOYkJqQnNTU3paTGpPOEh6NThvdHFmL3dwWC9XRFNQWTc5?=
 =?utf-8?B?bkJSWjZvVU9YMmoxWkRiZ2E4WCtvRzFsRmRicm1kSkt4azArQzhqWi9QV0pB?=
 =?utf-8?B?cEY0SStmT3FZb1dwUXZTWHdLb2tyS254ZDZxb1dGdURwcWgyejBoV0NHY1dN?=
 =?utf-8?B?djlYWWgwWndTZE8yTSthcUZzVkh3bDRTTGZ4MENORWRJK2pSWU05L2QvdUND?=
 =?utf-8?B?aUVweXZ3T2RzSUg3MEwvUTRWWVh1dlMyZFQ0Y2tWUGxKTTVKWk8wNk0wcUpB?=
 =?utf-8?B?b3VhVS9DMmNKQmFsY1oyc285ajhId1B0RlJNck1mN2xRbk94SGduRkZlUGxC?=
 =?utf-8?B?MjhOK1ZrcFVZeHAvZWF4ZlRzYUh0ZmtzUHA2ajFMNXRxNU9Lb0Q3T2xERjRI?=
 =?utf-8?B?cW5LbW85NW1lQ2s5dlN3R2JVWkVKOWFlMVFJbkJZMzRWTUVpbUtjQ2tnbzhz?=
 =?utf-8?B?MlZNV0V5NWp4VTB5c3F2dWI3cG8weWlEekQwL0pDeVB6NWhKNzlkZGx4S2E5?=
 =?utf-8?B?SWNDQ0x5SGxsZUdva2g1YWhRV0tJUjFCMU5pbGtFOEJwODBNMzFQSndNb01V?=
 =?utf-8?B?b011WS9UaDVMb0NXTFJCdXp1eDVLR1FlZ0loQTVtSUV1VmpQZHdBUU1MNTFZ?=
 =?utf-8?B?ZncrTWIvSXpHVFdtSlprMk1mbTJGZjdsd2dxeFowZDM2OUdhbUV3bkoxamgr?=
 =?utf-8?B?VW41Q2pXK0dlSHpiN1ptMjFyTHh6eDNRandUcEg3VlFCM29tTFV3VXFsd2VE?=
 =?utf-8?B?TlV4Zk4rWUxKNzljMkJDL3VWTFNPa2g5VTFKalpabTZ3ZTlkTHI3N2M3eW1n?=
 =?utf-8?B?TmhlMmphL2VsRFdJNXhQZ05zdlFZYUlJK1hDd3hQNFVaRWZjbEgxUU4yMmJo?=
 =?utf-8?Q?fA1cp/Td6oo1rdEXk/YF5XA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <400B006BCA86914C93E6020EE6BC9D7A@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b23dcb0-cdc1-4f3a-4ab6-08db7d263449
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 07:05:24.2426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GaZyQ1CRuhHyWby4uuH+uO/DK4XdUUrpq+qeJ45OFN9ru5Q8QvGrp90D7XE0daNwU7VsAuNoSGrQbN6Ws5j48wzeKGZFIW4T4IcVPxrZEyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6309

T24gV2VkLCAyMDIzLTA3LTA1IGF0IDA4OjU0ICswMjAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAwNS4wNy4yMyAwODozOCwgRmxvcmlhbiBCZXpkZWthIHdyb3RlOg0KPiA+IEhpIGFsbCwNCj4g
PiANCj4gPiB0aGlzIGlzIGhvcGVmdWxseSB0aGUgbGFzdCBwcmVwYXJhdGlvbiBzZXJpZXMgbmVj
ZXNzYXJ5IHRvIHR1cm4gb24NCj4gPiB0aW1lNjRfdCBzdXBwb3J0IChhLmsuYS4geTIwMzggc3Vw
cG9ydCkuIA0KPiA+IA0KPiA+IFdpdGggdGhpcyBzZXJpZXMgYXBwbGllZCB0aGUgWGVub21haSBz
cGVjaWZpYyBBUElzIGFyb3VuZCBzY2hlZHVsZXINCj4gPiBhbmQNCj4gPiB0aHJlYWQgQVBJcyB3
aWxsIHN1cHBvcnQgdGltZTY0X3Qgd2hlbiByZXF1ZXN0ZWQuIFRoZSBmaW5hbCAidHVybg0KPiA+
IG9uIGJ5DQo+ID4gZGVmYXVsdCIgc3dpdGNoIHdpbGwgYmUgcGFydCBvZiB0aGUgZmluYWwgeTIw
Mzggc2VyaWVzICh3aGljaCBpcw0KPiA+IGhvcGVmdWxseQ0KPiA+IHRoZSBuZXh0IG9uZSkuDQo+
ID4gDQo+ID4gVGhlIHJlbWFpbmluZyBzdHVmZiBjYW4gYmUgZm91bmQgaW4gbXkgeTIwMzggcXVl
dWUgYXQgWzFdLg0KPiA+IFRoZSBYZW5vbWFpIGhhY2tlcnNwYWNlIHdpa2kgaXMgdXAgdG8gZGF0
ZSBhbmQgcmVwcmVzZW50cyB0aGUNCj4gPiBjdXJyZW50DQo+ID4gc3RhdGUgb2YgdGhlIHkyMDM4
IHdvcmsuIFNlZSBbMl0uDQo+IA0KPiBXaGljaCBvZiB0aGUgZml4ZXMgZnJvbSBwYXRjaCA4IG9u
d2FyZCBzaG91bGQgYmUgbWVyZ2VkIGZpcnN0IHNvIHRoYXQNCj4gdGhlIHByb2JsZW1zIHdpdGgg
dGhlIGluLXRyZWUgdGVzdHMgYXJlIGFkZHJlc3NlZCBmaXJzdD8NCg0KVGhhdCB3b3VsZCBiZSBQ
YXRjaCAxMCBvbmx5LiBJIG5ldmVyIHNhdyB0aGlzIHByb2JsZW0gb24gaW50ZXJuYWwgQ0kNCnRl
c3QgcnVucywgc28gSSdtIG5vdCAxMDAlIHN1cmUgaWYgdGhhdCBmaXhlcyB0aGUgaXNzdWUuIEJ1
dCBJIHRoaW5rDQppdCdzIHdvcnRoIGdpdmluZyBpdCBhIHRyeS4NCg0KSSBjYW4gdHJ5IHRvIG1v
dmUgaXQgdG8gdGhlIGZyb250IG9mIHRoZSBzZXJpZXMuIFNob3VsZCBiZSBlYXN5IGJ1dCB0aGUN
ClFBIENJIHJ1biB3aWxsIHRha2Ugc29tZSB0aW1lLg0KDQpGbG9yaWFuDQoNCj4gVGhhbmtzLA0K
PiBKYW4NCj4gDQoNCg==
