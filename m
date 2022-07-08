Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70090.outbound.protection.outlook.com [40.107.7.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7D57EB
	for <xenomai@lists.linux.dev>; Fri,  8 Jul 2022 07:30:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwa+6oM9fR4YViAA5j1X+6c8IfhrrNXrUyz5KLrzErV0zyaKTl9iDBR8iw7wdXKxZwkoZZDPOo68vGb7KJdEwkNa9UeVeP9nYy4Y4+Rq/XpV30h8vw7joIxFJqh7U4J5LJmBG/TAL58j0/uV62+s5eIKo/jMYXusesFffUycxHsReUxFs5hkSjOxZ3aJ91Q7T3PHOKmF3A8G4nUNAm2qKIzyt0R5CGNgVmL63ezcwDH523IQ8RxSwV5cN8elrMLnEeFd51WFdoCTmpcTFv098JzMzExmGLH5R0/rIU6BAAovuVwx3SdvrJgSLy7pKRBPmhlqcHRE5HNX7zu/WPolvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YErtiHgwQZPF3hI5LLN64d3sgEgsWOuB8QRtcsumG5Q=;
 b=WWoNeCi7m/qaIsiaNYcpvAW3RB/RgSF+JnOJN6PNKHAmnCbSycWHUPE21Kc4Cq8cgqmRPvHautqZg/CxVkgEg4C2/IkWEQkzf33b1SbhsF8q4bzwuoSzZqSCkhkd6lALGS5AuSMrOX81zNjfgLrSmMrLblcVR43LnpzMm/G3StKoNnTlH6whrOKjP3OAf13u5ie23/IHDTUjlDTxFTfSdj84GsYqs9a71hIiUGbTO2b+PKD+zzZ535TAr5yUhzeGDxpiYNwjF7PdPTzvD+Nfug0Fxzj17yjlolG3jAvH+E3A0LfsWavGlGI8iU61V7/4/Eu9WZUpErQwJcFGJeNdTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigmatek.at; dmarc=pass action=none header.from=sigmatek.at;
 dkim=pass header.d=sigmatek.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigmatek.at;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YErtiHgwQZPF3hI5LLN64d3sgEgsWOuB8QRtcsumG5Q=;
 b=UOhiV1P8El9CEDwHDvtq41nlR/BIiZjitjcYp4IXUEPo1qBoy/1qoIdzKdZhMuKNmg3N/T66g/zz7hmtxaWQ4HjGqEI6001+89xyD9q2YMakY9L3lLexI93o43uj4RGsoxOyP19f9QHn5BM15Jq4ePJuFFQJXM7IYIpCw3UAxwY=
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com (2603:10a6:802:a8::22)
 by DB9PR08MB6618.eurprd08.prod.outlook.com (2603:10a6:10:263::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Fri, 8 Jul
 2022 07:30:21 +0000
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::9978:7089:d0f:b288]) by VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::9978:7089:d0f:b288%5]) with mapi id 15.20.5417.017; Fri, 8 Jul 2022
 07:30:21 +0000
From: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
To: Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: RE: [PATCH 1/3] rtsignals: part one, core code plus x86
Thread-Topic: [PATCH 1/3] rtsignals: part one, core code plus x86
Thread-Index: AQHYkgnbSLoiefwmdkiR84kBz3ZuC61zBvaAgAEMfuA=
Date: Fri, 8 Jul 2022 07:30:21 +0000
Message-ID:
 <VE1PR08MB490960CBB789FC9F26E4210192829@VE1PR08MB4909.eurprd08.prod.outlook.com>
References: <20220707135952.5171-1-johannes.kirchmair@sigmatek.at>
 <20220707135952.5171-2-johannes.kirchmair@sigmatek.at>
 <327d7547-3485-1aa4-c686-60e81d4885e1@siemens.com>
In-Reply-To: <327d7547-3485-1aa4-c686-60e81d4885e1@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sigmatek.at;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34a508a4-d18a-4767-5c49-08da60b3b728
x-ms-traffictypediagnostic: DB9PR08MB6618:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 0WPgjSMFc39wp/5Qitwdu03uEUf7tNNdTzVfgovG5RWlSoEuvvF1Wu5vUF+VNFjc6/Gv3BHXuxJniItw0yb4iArxg4/0PcwSX+S2uSDksSmVIR366+fSRvwLK5pKJC9WJuFeR9gA7i1dsMd+GhoiO5XYlFoKdTSmi4k3Pvg2qL0oWZWEuILsBQjDc0C3hNmhF0tBkc9BoICKHBn55AiQmy5Geya2/yJ2quLd89n/jSaxM9UTP8xkeMFjmcC5eV/UB6FJgWwCFsfQ608pzb8By8veAK/so0kbmL6tnuuSDn5iq0K9sgTHr1Q0mjid9XHPW5rnGd4A+f6RQxVFsyQVCRF5A0cz6VYNdsuzleLXx9zWoBIpeXk6QkGt3xVsiuW3+GvObJxqkUBl24x2uBb4X4zMnbqBWd4sX2oOebnGiznx/xBRvXKP8IDTBIgyfn9s6j1eNvZsCF1A/D250BlAIfpqPaQ8ecwncJad1qLERxbEya7DADZ8jvVn3SzcGwRQHfuE/ym4vPo0K0ijlsOY9rMlrbb9s9vyMudva+biIGk0AVP4o/VVhU5Z5XTzewB/mLwDHCrckVCI3kSAhf5yzVo/VRWmLChjj7GsNv0JwnsVjoDn1uX/knrMz4ZgFfsEcXdB4WMoTD5ywPTq3UlOUxjIfHu1JTVKqvISDu9cIYErWjSBM6bzSuoJX/ViQf1in0zOqL2uGHPd5QfM4BVnPqKTK6JNbWUl2fIFr3d9DU8Y3x8bfyGgm2T6pfsfMB1rakZnpDp+0YEcu+4+cnWEdPVYBcIaTZop7mZBtTlADog5uhk4AQIhCu5ObpEvx2sN
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4909.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(366004)(39840400004)(346002)(376002)(9686003)(38100700002)(44832011)(26005)(8936002)(52536014)(110136005)(5660300002)(38070700005)(122000001)(2906002)(41300700001)(86362001)(33656002)(64756008)(66446008)(66476007)(76116006)(83380400001)(71200400001)(66556008)(55016003)(66946007)(8676002)(478600001)(6506007)(7696005)(53546011)(316002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c2k0Tk1BVDlJS2NQOWJyZlBYTWdBb1dXcW5XVG12a2VSd0lVMVVzdDRYT08y?=
 =?utf-8?B?MmUrOGZnNjl4Q2ZDMEQzR1pGV0l0cXJMcDBJSlJXS2dpWFJlbHVxOUlzcDJ2?=
 =?utf-8?B?aklibXltMVV4TG5YQ1FIenR2Q3ZXK2NnOVdnOU9IQnpVSmMxOElQdzRicHBy?=
 =?utf-8?B?enU1anE0TStVZFBKZTZONmVrVGMyR2c2R0NteUxTODV0WDZCa2llQ3R5N1lr?=
 =?utf-8?B?cncwNng3UHpFU1BoR2txdHJ0RlVwb3A5dGwzYVhxRUQyczFySk9SYnJEQlVE?=
 =?utf-8?B?alRPbCtqWDFRbUNIajFyTDNlYzFvN2c4SXBuak5RU2o0S0V0RWlENjUxM0Z0?=
 =?utf-8?B?ZEp6OVF4WEJxM3RBcHVDQnpzNWF2b1pxRFRoVCtQRXdUTDRuWnhCY20zSGEv?=
 =?utf-8?B?MEY4eEpub255VHNRdjFzN3J3ckcwLzAyMWt5QWthYmluVzkxTmEzeTRQTFg0?=
 =?utf-8?B?aEhRV1ZTOVBmb2dhTkIvUDZSRmR0Vnl4Y1NxL0kzRmJ1ZFRyMEpWUlpWRW9o?=
 =?utf-8?B?QUtUNllYZXFZWW9vUkZ5b2poMXJrYzQ0NURPSGlWdDFVQ01kZURneWJWN3BY?=
 =?utf-8?B?a1lyZmRLdkhqTXFlVFBRYUVBT0d5QStITHhoUVQ4bXNObWhObFRHaXVxQ1VQ?=
 =?utf-8?B?OEpJQW82T0Faano2S0p5RHhXY1pIWTg5ZHZVYW9vQWJFSm11UUJGclJsMHhp?=
 =?utf-8?B?Mmw5ZGNxdmdvaHdZdlp3R3RhQzZ6bFZMOEtEVEJZK1lwbkpBb1l1TzNwQUFl?=
 =?utf-8?B?MXRYaUxySDJQdzJLNUd4U1NKVDkxT1BqOE1HV25hRnJqZ2ZNNkh6WWJCbVUx?=
 =?utf-8?B?R1V0b2prNjNMaTk5ZXB2V2hmTWxSd1ZzMEwrSmlDQUIxVEp4dkdjeTZxd1p1?=
 =?utf-8?B?Nm8vRi9wWUFyMGlKd2ZWTWF5N1Znb2lwNkVSaHQrYWpPNklYYU1CaVhpaDNP?=
 =?utf-8?B?VXptbm9lYUJ5UXpUTDN2dklwY0RwVTIyMVpRRHZTcitFdzgrdkhBRUo4anZx?=
 =?utf-8?B?am9mYWlpNWw1VjFVWWxJZ25lTEFMU3YzUkVRazI3MUJvMzRDcGJpNE4xTGlz?=
 =?utf-8?B?ZjExUGRNYitucWFNVWFWaUZaNWlldFJQaXNWTkswUWxVV28zQXhMNnIrQ0h4?=
 =?utf-8?B?SW40bXhQL1gwZU82Zk4wUWQ1OEIxdmxlTWpJOXFNQkNJb0JqRTBwYnVvMTQw?=
 =?utf-8?B?bllwL0RwN2x4YXFIMmpiVUp6TkpmdTVQZTBsU0xOZkNwcElxMUxIRGxYYkNu?=
 =?utf-8?B?NHRTNlFjUS9mVSt2UURlVG13VW1pazdIMWI5Q3k0OERjMnhJUGR1dzAxcElw?=
 =?utf-8?B?UzBrUWlteS9FWlNIVWlCejV6YjhNU0lhcFhubk5wZlgxS1dLRHNCSU5JSUNy?=
 =?utf-8?B?RkwzazAzVUs1enpWbGRrbXNBODJIbE5ESmxKNXVUelZmZ2p0bm83Z01ZMUl6?=
 =?utf-8?B?Z2U1Q09aYTF2OHlrclJvbzNrZmdIcUZjdDVRU2tTb3dYMVNkcmtNemhJSUhX?=
 =?utf-8?B?Umt2ZnBkaUlCaktUcXR4dHpEdmxJNTFFWEV5VjVVbVM2bDF0VnFnOWlNakRl?=
 =?utf-8?B?ZTRrelBPbi9ENWtvclhpQXIxeXZIVENUYkpIblVDcjlZeEkzaStyQXpCTDRW?=
 =?utf-8?B?UE44UWtQWldVUTI5QUFmY2VnQUU3cDlhbXRoNHZ0OW9tVXdnWVR1bXQyV0Vy?=
 =?utf-8?B?VG8rRmM5eUNuWVlEQjhHbzZnN24rbjlzSE42OW1hZEszUmZ0eUlkRUlBRmh6?=
 =?utf-8?B?SXNtRGcwUEJ3T1Qzc0RIa21JaGpIQkhxUVYvd2Jua29XTmJEdmNZY3gyVXk4?=
 =?utf-8?B?Y0RiZ3gvNGZjNkhnSlV4cXp4VkMxQzZseGFvQVZDMFBHbnR0WEY0bGRMbVdy?=
 =?utf-8?B?eFBjejc2N3czdGVBRE9ZbmJDOGNMUFk1OVVzNTNTaHNvRTFBZnlYQm5PckRH?=
 =?utf-8?B?cE9rb0ZpQnVSM2xQU1VOZFJSTm5tbVd4Q29aaGsvbWRZWHovL0xKUGllN1dE?=
 =?utf-8?B?SlhEemZ3L1BFTURKTXFKdUNUT0tSS2ZiQStWem5iWUR3NTRlOXpQb01IYkl5?=
 =?utf-8?B?cHdObCtHVENRYjNQMHozYmR6UHFqNEJRZ010L3pIMUhJMm8rN2FkMG1zSU1N?=
 =?utf-8?B?RkQ4aVdKMFlWaU9Fd1lnMWJHandzWXJvTElzajZyVWIycEg5dVNLTTAvY1la?=
 =?utf-8?B?R2c9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a508a4-d18a-4767-5c49-08da60b3b728
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 07:30:21.4322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bcb1d87a-d2bc-486e-a62b-9ac9c746bc1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zvPtZVcc800gB1K0+SoA9877PpmFh0B8VNA0FY7abYLRyM6rh1NCOLtbt2ALFt+X0fkxFjeIkjrzdpdNuCLsZ8rrL49MevvEiW6nhgWhOz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6618

SGV5IEphbiwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYW4gS2lz
emthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPiBTZW50OiBEb25uZXJzdGFnLCA3LiBKdWxp
IDIwMjIgMTc6MjQNCj4gVG86IEpvaGFubmVzIEtpcmNobWFpciA8am9oYW5uZXMua2lyY2htYWly
QHNpZ21hdGVrLmF0PjsNCj4geGVub21haUBsaXN0cy5saW51eC5kZXYNCj4gU3ViamVjdDogUmU6
IFtQQVRDSCAxLzNdIHJ0c2lnbmFsczogcGFydCBvbmUsIGNvcmUgY29kZSBwbHVzIHg4Ng0KPiAN
Cj4gT24gMDcuMDcuMjIgMTU6NTksIEpvaGFubmVzIEtpcmNobWFpciB3cm90ZToNCj4gPiBGcm9t
OiBSaWNoYXJkIFdlaW5iZXJnZXIgPHJpY2hhcmRAbm9kLmF0Pg0KPiA+DQo+ID4gQWRkcyBjb2Rl
IGZvciBpbXBsZW1lbnRpbmcgc2lnbmFscyB0aGF0IGFyZSBoYW5kbGVkIGluIHRoZSByZWFsIHRp
bWUNCj4gPiBkb21haW4uIFRoaXMgaXMgZG9uZSBmb3IgMzJiaXQgcHJvY2VzcyB1bmRlciBhbiA2
NGJpdCBrZXJuZWwuDQo+ID4gSXQgd29ya3MgaW4gYSBzaW1pbGFyIHdheSB0byBzaWduYWxzIGlu
IHRoZSBMaW51eCBrZXJuZWwuDQo+ID4NCj4gPiBFZGl0ZWQtYnk6IEpvaGFubmVzIEtpcmNobWFp
ciA8am9oYW5uZXMua2lyY2htYWlyQHNpZ21hdGVrLmF0Pg0KPiANCj4gLi4uDQo+IA0KPiA+ICtz
dGF0aWMgaW50IGlhMzJfc2V0dXBfc2lnY29udGV4dChzdHJ1Y3Qgc2lnY29udGV4dF8zMiBfX3Vz
ZXIgKnNjLA0KPiA+ICsJCQkJIHZvaWQgX191c2VyICpmcHN0YXRlLCBzdHJ1Y3QgcHRfcmVncyAq
cmVncywNCj4gPiArCQkJCSB1bnNpZ25lZCBpbnQgbWFzaykNCj4gPiArew0KPiA+ICsJaW50IGVy
ciA9IDA7DQo+ID4gKw0KPiA+ICsJcHV0X3VzZXJfdHJ5DQo+ID4gKwl7DQo+ID4gKwkJcHV0X3Vz
ZXJfZXgoZ2V0X3VzZXJfc2VnKGdzKSwgKHVuc2lnbmVkIGludCBfX3VzZXIgKikmc2MtPmdzKTsN
Cj4gPiArCQlwdXRfdXNlcl9leChnZXRfdXNlcl9zZWcoZnMpLCAodW5zaWduZWQgaW50IF9fdXNl
ciAqKSZzYy0+ZnMpOw0KPiA+ICsJCXB1dF91c2VyX2V4KGdldF91c2VyX3NlZyhkcyksICh1bnNp
Z25lZCBpbnQgX191c2VyICopJnNjLT5kcyk7DQo+ID4gKwkJcHV0X3VzZXJfZXgoZ2V0X3VzZXJf
c2VnKGVzKSwgKHVuc2lnbmVkIGludCBfX3VzZXIgKikmc2MtPmVzKTsNCj4gPiArDQo+ID4gKwkJ
cHV0X3VzZXJfZXgocmVncy0+ZGksICZzYy0+ZGkpOw0KPiA+ICsJCXB1dF91c2VyX2V4KHJlZ3Mt
PnNpLCAmc2MtPnNpKTsNCj4gPiArCQlwdXRfdXNlcl9leChyZWdzLT5icCwgJnNjLT5icCk7DQo+
ID4gKwkJcHV0X3VzZXJfZXgocmVncy0+c3AsICZzYy0+c3ApOw0KPiA+ICsJCXB1dF91c2VyX2V4
KHJlZ3MtPmJ4LCAmc2MtPmJ4KTsNCj4gPiArCQlwdXRfdXNlcl9leChyZWdzLT5keCwgJnNjLT5k
eCk7DQo+ID4gKwkJcHV0X3VzZXJfZXgocmVncy0+Y3gsICZzYy0+Y3gpOw0KPiA+ICsJCXB1dF91
c2VyX2V4KHJlZ3MtPmF4LCAmc2MtPmF4KTsNCj4gPiArCQlwdXRfdXNlcl9leChjdXJyZW50LT50
aHJlYWQudHJhcF9uciwgJnNjLT50cmFwbm8pOw0KPiA+ICsJCXB1dF91c2VyX2V4KGN1cnJlbnQt
PnRocmVhZC5lcnJvcl9jb2RlLCAmc2MtPmVycik7DQo+ID4gKwkJcHV0X3VzZXJfZXgocmVncy0+
aXAsICZzYy0+aXApOw0KPiA+ICsJCXB1dF91c2VyX2V4KHJlZ3MtPmNzLCAodW5zaWduZWQgaW50
IF9fdXNlciAqKSZzYy0+Y3MpOw0KPiA+ICsJCXB1dF91c2VyX2V4KHJlZ3MtPmZsYWdzLCAmc2Mt
PmZsYWdzKTsNCj4gPiArCQlwdXRfdXNlcl9leChyZWdzLT5zcCwgJnNjLT5zcF9hdF9zaWduYWwp
Ow0KPiA+ICsJCXB1dF91c2VyX2V4KHJlZ3MtPnNzLCAodW5zaWduZWQgaW50IF9fdXNlciAqKSZz
Yy0+c3MpOw0KPiA+ICsNCj4gPiArCQlwdXRfdXNlcl9leChwdHJfdG9fY29tcGF0KGZwc3RhdGUp
LCAmc2MtPmZwc3RhdGUpOw0KPiA+ICsNCj4gPiArCQkvKiBub24taUJDUzIgZXh0ZW5zaW9ucy4u
ICovDQo+ID4gKwkJcHV0X3VzZXJfZXgobWFzaywgJnNjLT5vbGRtYXNrKTsNCj4gPiArCQlwdXRf
dXNlcl9leChjdXJyZW50LT50aHJlYWQuY3IyLCAmc2MtPmNyMik7DQo+ID4gKwl9DQo+ID4gKwlw
dXRfdXNlcl9jYXRjaChlcnIpOw0KPiANCj4gQW0gSSBtaXNzaW5nIHNvbWV0aGluZyAtIG9yIGRp
ZCB5b3UgbWlzcyB0byBhZGQgdGhlIG1hZ2ljIGZvciB0aGlzDQo+IGdldC9wdXRfdXNlcl90cnkv
Y2F0Y2g/DQpUcmllZCB0byBmaWd1cmUgaXQgb3V0IHRoaXMgbW9ybmluZywgYnV0IGRvbuKAmXQg
dW5kZXJzdGFuZCBpdCBmdWxseSBqZXQuIEFjdHVhbGx5IGRvbuKAmXQgcXVpdGUgZ2V0LCBob3cg
dGhlIGVycm9ycyBvZiBwdXRfdXNlcl9leCBhcmUgcHJvcGFnYXRlZCBpbnRvIHRoZSBlcnIgdmFy
aWFibGUuIFByb2JhYmx5IGluIHRoaXMgY2FzZSBwdXRfdXNlcl90cnksIHB1dF91c2VyX2NhdGNo
IGlzIG9ubHkgZm9yIGRpc2FibGluZyBTTUFQLiBCdXQgSSB3aWxsIGhhdmUgYSBkZWVwZXIgbG9v
ayBhdCBpdCBpbiB0aGUgYmVnaW5uaW5nIG9mIEF1Z3VzdCBhZnRlciBteSB2YWNhdGlvbi4NCg0K
QmVzdCByZWdhcmRzIEpvaGFubmVzIA0KDQo+IA0KPiBKYW4NCj4gDQo+IC0tDQo+IFNpZW1lbnMg
QUcsIFRlY2hub2xvZ3kNCj4gQ29tcGV0ZW5jZSBDZW50ZXIgRW1iZWRkZWQgTGludXgNCg==
