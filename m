Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2133.outbound.protection.outlook.com [40.107.8.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390633C38
	for <xenomai@lists.linux.dev>; Thu,  7 Sep 2023 10:48:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SHGDyYq5jreLAFbhqi4Vpqs5FtEAM9zRqaCwzxs630DlguHn1MA3RBZbdavgvYzGROBEnQjBWQLJqVt85mk8pTkVglCDlQQads5BeTdT3VVlQOwCQqu2MN8Q4UnV3B7pt4lGuQToz/GT+YT3HZ8YDjq6wq170DcGfO/qKrTVZnlIcY+sJL+84gl8g6l2K5dHdsimCg36beFh5CM1JTI4Z4yxA0tYdOuBxJdSBoan96OdJ/Wm/pxFWN507pGOwDhnj7ibZj/EmmvFS+JWYujeWGFNuYLvpEv9u5rIqa5im0Jpl34QaZ95YZsY2WiWgBZxOY2+EO/c6/PzWheEpU7TQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awdxSX+0fNMlDPhJ0kyWwpPmq9/PVYPfNJres9Q8TyA=;
 b=BFlYCkdw9oZ+/wsAlwuoiSOV2aotZ2HmsX70kvhOaqc+Dhq0HY7xJjCFpy9md5IlqRUkPb2pSyCUxIJ+6RSJkw1/6rmyDf/T34RB5sZu4wnwAxhx88vxJ+9h4qlb2EIt7pyXCvo2tpqVqy7jtMaTGn0b22Plbon3sSCWWsG7HrijSDxfgdlXTS3TqReE1OruKv0Z04IZar7e29HOen6pmCMLxmAiqQn0epsxoh+Ag1ERg67X/WBvuE3U1va7LKx4vedZce7bAfL3wyxBpX1sMj5Ms9hQH7LGEPrVk0Xd/HbdVgwa0YpNAktRc1oqKvpbmF5MGHbrMEjaxaNI5lGCJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigmatek.at; dmarc=pass action=none header.from=sigmatek.at;
 dkim=pass header.d=sigmatek.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigmatek.at;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awdxSX+0fNMlDPhJ0kyWwpPmq9/PVYPfNJres9Q8TyA=;
 b=MVP1APeryVRL6QftGO3I5oxRnJIFvYw33t6QHu52Cm7T5GQVRbRIKgtp9nl0WUYbzVzWkAmDyPgAZKIFZdAA8jfKi/tSScuGCYx0kYBxvejGp3gQTkKtHuV6tKTLqsyCGzrHByCJ1KvH5nmUoHAyYole3pZPxk5yBxAL1CmD66I=
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com (2603:10a6:802:a8::22)
 by DB9PR08MB6602.eurprd08.prod.outlook.com (2603:10a6:10:23c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 10:48:29 +0000
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::1c00:64f3:d6fd:832b]) by VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::1c00:64f3:d6fd:832b%4]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 10:48:29 +0000
From: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
To: Florian Bezdeka <florian.bezdeka@siemens.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
CC: Jan Kiszka <jan.kiszka@siemens.com>
Subject: RE: [PATCH 1/3] [POC] test implementaion of rt-signals
Thread-Topic: [PATCH 1/3] [POC] test implementaion of rt-signals
Thread-Index: AQHZ0Csq/ZWExxuArEijlXU/s8xHfa/syBkAgCKG9UA=
Date: Thu, 7 Sep 2023 10:48:29 +0000
Message-ID:
 <VE1PR08MB49094D931267988E377A9A2E92EEA@VE1PR08MB4909.eurprd08.prod.outlook.com>
References: <20230816101842.3377643-1-johannes.kirchmair@sigmatek.at>
 <d5e43ccdceba5f28de7798c0826318e1bbcfc1d4.camel@siemens.com>
In-Reply-To: <d5e43ccdceba5f28de7798c0826318e1bbcfc1d4.camel@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sigmatek.at;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VE1PR08MB4909:EE_|DB9PR08MB6602:EE_
x-ms-office365-filtering-correlation-id: 36074c91-e5a8-49f7-bcb8-08dbaf8ff8e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 YI9ODm10B9weyC57HF6dPaHVO2r3B3/FlycY2l+XyQNLOas/AY6CSeqMSQiaj0IqS8kMEBEhETuOhDmqm8VKA05raWezysYlRDTD1jKRFtS1/2iZXB2SoDs51obKH4KvJI4rRIdSvgCRoKxY92mQErmHcfK4IgtkByOXjUMMeMmWxO02o3eM25N2+aNvVmmgKvUsSrmR+BIOHFYbWCYuIiHK+eSi7Gh3DWdSh+4eKdYi6CcyCFaI9Cwog0Td7V//hVPZDVhW6//iemvnciUXt9mdtyPaztP1SYbavEFaLeKRlRLEHNKLtTaIf0cLmyCjd526ante8BI+tD6DGJgqcexUHspX6EYNYX/s0LC28b5KB0dBEuS8n0KVMHcilfQ7hVO4nvoZsnoJ+rMNAX7uSER3GcHgG2LU+rN/8vBxP30v192rtEGeDBMae6NXd7DzaYU8xPGs31x+IUvoEFo1MHqWopZqHYmEfIhwE2trGZopO5Bx8a1Pi3tzqFt6awiBAgzN8/hOY5ZxOfBmjpa53rrhHgJb2QBwE9murrnejsWu1xFSvIGjuDAQABj+HffH6uYG/Pj7gzsuU1+2hqt7UQrF5CCbDoi8qmZWBP+tfd17Pqnk/EFOxL2sHIcdlCim
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4909.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39850400004)(376002)(396003)(136003)(346002)(1800799009)(186009)(451199024)(44832011)(83380400001)(26005)(52536014)(4326008)(6506007)(7696005)(5660300002)(8936002)(8676002)(9686003)(38100700002)(38070700005)(122000001)(71200400001)(55016003)(478600001)(33656002)(86362001)(41300700001)(66946007)(2906002)(110136005)(76116006)(66476007)(66446008)(64756008)(66556008)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RStsbWNwanFucXZOM3g5QVphaHNKVHBWS0dBV1hHYm02bjR1N094ak9EM2Zn?=
 =?utf-8?B?ckd0emVhNjd5aXpUVGdEWlJLNytnVzdZZVkySHhXU2lUMHVHeXA1dnBrQzNy?=
 =?utf-8?B?V3pLbEF5UysyNktXOVFWdEFjdHBBdHBiMHo1eHlLVzd6Y0JHQkxUUitsWWcx?=
 =?utf-8?B?eEhDcnMzQUIvOC9OQ0dQdTkvN0Y0QXRxd0Q0YVZuMXhsRVNqd2pmZUNRQUJz?=
 =?utf-8?B?OGJqZVNkVWNkZ0RnOHlUTzJPRE13UHhZWUZJY1RIQTZ6aWFnMUJValRndnRp?=
 =?utf-8?B?OTB1TzdRdEw1S0hWNmxyQkxUQVJVOUQzMlE3NDc3bGFsdnhlOE01TmttVENx?=
 =?utf-8?B?UGlIVWFSYlk0QmZLeDR6K2pkWTVnNnlUTUhoY2RyL2JLUTNFdmxCM1plNVRB?=
 =?utf-8?B?cElraGpZZS9jZG9LUVZycmlqcHFxMHRuY1ZLMDhKWXZaUWhsL1BKNUVMTXVh?=
 =?utf-8?B?c0tSdWdSaVoycnBRWDJXb0Q4OVJZWXlSeGkvWjJJWUttZnQ2Ym5JNkozZVYv?=
 =?utf-8?B?YWgvMTBTZUUvUm9IeXVOKzZ6VlZQYzdDa3dmREQzRFRvZkdGMFEycm1nWUF6?=
 =?utf-8?B?aEl6REVwTUt6aGVtdU9VU01GTkh0VzRJMk5jMkFRaG41VUswTVFjOGVzRmQ1?=
 =?utf-8?B?ZERsSEVpMlJVUFdPWGFOM1pSd2RqZjJYTVFmVEw0TjMrMDFGN01SZS9sbTRl?=
 =?utf-8?B?M2xVVENWL2pFeW8wYkErVWpmTWhiY2lpVHkzZnk3OGd5bzVoSldYTXZ3UmZY?=
 =?utf-8?B?b1FYc0xrV3JYSEx2OTI3RjJWejk2MkJMYmU4eGNoaU1BL3ZnMFovMHYrRmpQ?=
 =?utf-8?B?QUdkQzhseTZZQkEwMTVtbkh1ZU5Zc0NZYkhoNHdtWnJiYWpnbE1XQnhUOTh1?=
 =?utf-8?B?S09OQk1YWVJYM1E0ZWVGNHNwNkNXMWtTSzdZR0toak9mRFRjSy91QW00eGJD?=
 =?utf-8?B?eWZrUFRQN1B5ZHNzd1JUZEhRdlppaEZZS0JYTlA0TEhTd05tM0FjTDhEbVhY?=
 =?utf-8?B?RUxHd2FPNEM5eVNveWoweVM2NG9seWt1YzFXY25Gc2J3L2NwdCt0eVk5SHR3?=
 =?utf-8?B?TzFzVU5HRXZ6cjdKY2Y1RGF1WkVvR2tvQ1FUQlIyOURVUDQ4YVpQU2NwcGhn?=
 =?utf-8?B?YjFEMnBEVkVtNXpjVlFDd3hRZ09nU0NIaE5OdzR5SytCdGxvNlRKMkR6WFlR?=
 =?utf-8?B?ek1NVkFvVnd1Ri9IV0YyU2cvandoWFpmdTFPRWJyL3YxaFVlMXlUWndyYndW?=
 =?utf-8?B?bTVKWEVTV3pocVpqY2syeTQvc0hWTVNobGJOZmpHOTdSSS9xSnlEQndYeURB?=
 =?utf-8?B?U1pYemk5MVBtVjRKY2NFcjg0THNkYksvaXBrKzNZejJmdnJYSFpiSmk4c0dh?=
 =?utf-8?B?RFlvQVRwSjM3em4ySmRzdnoyeU5ja3lud21SRzhlWnBYT3hvUitidzV1ejMz?=
 =?utf-8?B?Q3NzNkdJYmJLQ1JFNko2bGJDUUc4a3pqMmU5QURQSU43alZmaXFqQ20zdjVN?=
 =?utf-8?B?aVhZSjR4bkVQUUJtRnFvY0tYUHIvK0RjYlRYdXR1VUVvdDIyeHk5SzQ3T0ZM?=
 =?utf-8?B?UnBGb3JsNjVpYVR5bVVHMmUxRzZ4eUpvOGVIaUIwUC9OenQyUjhmT1AzdHQ1?=
 =?utf-8?B?Y0owTkUwbmtxeHN4SC9CeGlESGdudS9tWStpZk1LaGN0MUdjOXM0R3hmcXF4?=
 =?utf-8?B?cjIrOGhYVWNVTVo0bGF2WFJvSnJZK2htZ3grRnAvOE9kaXUyT1cvVUJOdHd1?=
 =?utf-8?B?WnFVUFJQcHVSdzcrT1BOVjc4ZGNMYzEvNHRKSUZseGdSdk5CUWpoRTBGeFBW?=
 =?utf-8?B?andCcUwyaUM3Y1o4ZktQZXhJay91RkhpSVdKR3pWUHFrTUVMdm03aEMxT01B?=
 =?utf-8?B?OER3MlhmQXhyYVpPWXBmY0NSU3FUSEQ1WC9ISDlSaG9LWGlNSEEwNk9GTUlh?=
 =?utf-8?B?Yld0Z0J1VVJBdUx5UHlFSStJUWRiMGJYUEJXcXdSWmVweEVUYUMzeVNPdzBl?=
 =?utf-8?B?ZkVlMm95bmdwbUhGTjdveVh3VndhR1A5eWJEaHphOUlmRHhCUjVTVW1yaGxn?=
 =?utf-8?B?SzN0M0lxd0dOV1lOa0RvbSszYWJpTlV3ZG85NFRVSWd0eGdFVHBIQTkxcTJH?=
 =?utf-8?B?VGFmN0NTOHFUWk5BWVIreHliVy93UnNCZ05DVUNyQ2RvRDE3ekNNTld2OU14?=
 =?utf-8?B?NHc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 36074c91-e5a8-49f7-bcb8-08dbaf8ff8e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2023 10:48:29.3344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bcb1d87a-d2bc-486e-a62b-9ac9c746bc1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IWS5EgCJQiTuIfgvVQ7bI0CAj4R0kI3Cm71954UeK/SLtsqgn3qYwNDO6qRC+j0xYnf0+wU9o9rt9hvooMRIEwJvPLs2fJqjnIRwV9E5tPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6602

SGV5IEZsb3JpYW4sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmxv
cmlhbiBCZXpkZWthIDxmbG9yaWFuLmJlemRla2FAc2llbWVucy5jb20+DQpbLi4uXQ0KPiA+ICtD
T0JBTFRfU1lTQ0FMTDMyZW11KHNpZ2FjdGlvbiwgY3VycmVudCwNCj4gPiArICAgICAgICAgICAg
ICAgICAoaW50IHNpZywgdm9pZCBfX3VzZXIgKmhhbmRsZXIsIHZvaWQgX191c2VyICpyZXN0b3Jl
cikpDQo+ID4gK3sNCj4gPiArICAgICBzdHJ1Y3QgY29iYWx0X3BwZCAqc3lzX3BwZCA9IGNvYmFs
dF9wcGRfZ2V0KDApOw0KPiA+ICsNCj4gPiArICAgICBpZiAoc2lnIDwgMCB8fCBzaWcgPj0gX05T
SUcpDQo+ID4gKyAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPiArDQo+ID4gKyAgICAg
c3lzX3BwZC0+c2lnaGFuZFtzaWddID0gaGFuZGxlcjsNCj4gPiArDQo+ID4gKyAgICAgaWYgKCFz
eXNfcHBkLT5zaWdyZXN0b3JlcikNCj4gPiArICAgICAgICAgICAgIHN5c19wcGQtPnNpZ3Jlc3Rv
cmVyID0gcmVzdG9yZXI7DQo+ID4gKw0KPiA+ICsgICAgIHJldHVybiAwOw0KPiA+ICt9DQo+ID4g
Kw0KPiANCj4gWW91IGRpZCBub3QgdG91Y2ggdGhlIHN5c2NhbGwzMi10YWJsZS5oICh4ODYgc3Bl
Y2lmaWMpLCBzbyBJIHdvdWxkDQo+IGV4cGVjdCB0aGF0IHlvdXIgY29tcGF0IHN1cHBvcnQgaXMg
YnJva2VuIHJpZ2h0IG5vdy4gWW91IHNob3VsZCBlbmQgdXANCj4gaW4gdGhlICJuYXRpdmUiIHNv
IHg4Nl82NCBpbXBsZW1lbnRhdGlvbi4gVGhhdCBicmluZ3MgbWUgdG8gdGhlIG5leHQNCj4gcXVl
c3Rpb246DQpDaGVja2VkIHRoaXMgYW5kIHlvdSBhcmUgcmlnaHQsIHdlIGVuZCB1cCBpbiB0aGUg
Im5hdGl2ZSIgaW1wbGVtZW50YXRpb24gb2YgdGhlIHN5c2NhbGwuDQpXaWxsIGRyb3AgdGhlIGNv
bXBhdCBzeXNjYWxsLg0KDQo+IA0KPiBDYW4ndCB3ZSBhdm9pZCBhIHNwZWNpYWwgY29tcGF0IGNh
c2UgaGVyZT8gVGhlIHBvaW50ZXJzIHRoZW1zZWxmcyBhcmUNCj4gY29ycmVjdGVkIGJ5IHRoZSBz
eXNjYWxsIGVudHJ5IG1hY2hpbmVyeSBidXQgdGhlIG1lbW9yeSBwb2ludGVkIHRvIGlzDQo+IG5v
dC4gU28gaXMgdGhlIG1lbW9yeSBwb2ludGVkIHRvIGJ5IGhhbmRsZXIgYW5kIHJlc3RvcmVyIGRp
ZmZlcmVudCBpbg0KPiB0ZXJtcyBvZiBtZW1vcnkgbGF5b3V0L3BhZGRpbmc/DQpXZSBkb27igJl0
IGFjY2VzcyB0aGUgbWVtb3J5IHBvaW50ZWQgdG8gZnJvbSBrZXJuZWwgc3BhY2UsIHNvIHRoaXMg
c2hvdWxkIG5vdCBiZSBpbXBvcnRlZCBvciBhbSBJIG1pc3Npbmcgc29tZXRoaW5nPw0KDQo+IA0K
PiBJbiBhZGRpdGlvbiB5b3Ugc2hvdWxkIHVwZGF0ZSBrZXJuZWwvY29iYWx0L3RyYWNlL2NvYmFs
dC1wb3NpeC5oIHRvIGdldA0KPiBwcm9wZXIgdHJhY2Ugc3VwcG9ydC4NCkNoYW5nZWQgdGhlIGZv
bGxvd2luZyBkZWZpbmUgdG8gbG9vayBsaWtlIHRoaXM6DQojZGVmaW5lIF9fY29iYWx0X3N5c2Nh
bGxfbmFtZShfX25yKQkJCQkJXA0KCV9fcHJpbnRfc3ltYm9saWMoKF9fbnIpLAkJCQkJXA0KCQku
Li4uDQoJCV9fY29iYWx0X3N5bWJvbGljX3N5c2NhbGwocHNlbGVjdDY0KSwJCQlcDQoJCV9fY29i
YWx0X3N5bWJvbGljX3N5c2NhbGwoc2lncmV0dXJuKSwJCQlcDQoJCV9fY29iYWx0X3N5bWJvbGlj
X3N5c2NhbGwoc2lnYWN0aW9uKSkNCg0KSXMgdGhpcyBzdWZmaWNpZW50IG9yIGRvIEkgaGF2ZSB0
byBjaGFuZ2Ugc29tZXRoaW5nIGVsc2U/DQoNCkJlc3QgcmVnYXJkcyBKb2hhbm5lcw0KDQoNCg0K
