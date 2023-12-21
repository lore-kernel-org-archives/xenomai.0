Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2061.outbound.protection.outlook.com [40.107.21.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE56D360AE
	for <xenomai@lists.linux.dev>; Thu, 21 Dec 2023 16:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="rMQhkik0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nuDVYIE2Suun+Cj+0dBv6mjFhOZirzmTDqN/EmC+QvjnIMsgvUgjK5vVISK/Ziu6woHUjwH1ZUJwpPFdEWOyu8Yph66Zpx2PyjzP54W5wek8xcj4fw3D6aqdyFlY4pwpJj/BS2Q1W22VfC965EzLPl3Deiqsa2SoPKVpcMHmIEPzv5m6zu6xcQoDZHYktDxAPo9qUgwIdWXSmGPVLF4klb0VbExG/C74WwPbkINdNL82NYZi+EJI1gl35rGZmUg6eq/LQ90LWDtNOeAskQmK9P/m/mDC6+GdosECpfZdf5A1pZ+k0hHzeYwELo3F/82LTBsYlc4CmFqZhR9FlCeh1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qTG32sHoAcoKXOXCoGTVNHQUwLR3Wnqy8kAzvJomrc=;
 b=c8oHAwtRZuhjxEB62ULqZ7IoROYO4q0axLrJxlVjUvPehxAIwPFaN4e0u6YgcpYWTIflWv/1/ubLj9WTDpCKq5rmv9H878jq3L9lFKaDxbfvWgVDZwhsm6m2J+V60t9R6W6fywtGm1zhFUKXO0Cxvi8YZnoMQp+GLEFMLsNAMWCII3jF7jw7pq4U6n+S89VhRuND5au4YQ95QSOgXOdnCnnJcvnquz6XUh+iAlVNh0el1AzoGMth3L8Vs6+9ni7Hijs8ToSBFbnWXnb64HkB6Uiy1rgyYDf3pOE5Vq7nqgYBOY423Dx7SlSJTzUh1RP5puH6k0BTiijjSLOiRWUFzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qTG32sHoAcoKXOXCoGTVNHQUwLR3Wnqy8kAzvJomrc=;
 b=rMQhkik009K6wYHRI4BvucjYrDzjPfjwWe5ZBQK5yk1CfpoCOUSc/sjhy1Ta+2FszW7jxUaFXJouAwmJ3XdfZNWxaJ7eP92IEt/1HazqK99MZ65NYIMuX1EInSZzt2x9Y1rEmOOCea+l4LOkjdBIRyeN8N0Z6OklnFYRJEQbUQX2AUZmXK3WH+tyOBWDEkKMPzhuIUE5BzkvRO8eS0AanwBlM9bExw5QBBq/gSsQfofytJ9FEQzVczuTkknS+ZAuN4yuvN6gTKUmbbx/jxUh209LcTViPGxWkAR9TPTCES0323IQZYtVSSPQfkdZqfAUsYxhHlDerHqTrGv6sRj+gA==
Received: from AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:672::17)
 by PAWPR10MB7150.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2eb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Thu, 21 Dec
 2023 16:56:58 +0000
Received: from AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a6de:d440:23ed:d8cd]) by AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a6de:d440:23ed:d8cd%6]) with mapi id 15.20.7113.016; Thu, 21 Dec 2023
 16:56:58 +0000
From: "Kowalsky, Clara" <clara.kowalsky@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>
CC: Xenomai <xenomai@lists.linux.dev>
Subject: RE: [libevl][PATCH] meson: setup-uapi: Take Debian multiarch into
 account
Thread-Topic: [libevl][PATCH] meson: setup-uapi: Take Debian multiarch into
 account
Thread-Index: AQHaMQWEuFONYf4XNE2n2Pnoc1ZRubCz+upg
Date: Thu, 21 Dec 2023 16:56:58 +0000
Message-ID:
 <AS5PR10MB817309AB8C068BB573C637349395A@AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM>
References: <d5c7f346-1137-40e2-ab24-958d7bbd339f@siemens.com>
In-Reply-To: <d5c7f346-1137-40e2-ab24-958d7bbd339f@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=4beb5000-b3d8-4c37-bef2-1e65aab29590;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-12-21T16:55:19Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS5PR10MB8173:EE_|PAWPR10MB7150:EE_
x-ms-office365-filtering-correlation-id: 40926b95-b63e-4f01-0e60-08dc0245d875
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 t5RIOLn9SnEB3HmTQQEOXftmcXUWqZkfWXptMgbKzZkHCN6yvRhrscE/4BQZ0GbUbbpq0vvcXBmaj+FtshvuHgfJ5ggaWbGzPKyp5HT4NPhMW0+gaL/XypnaWYipy5SdjGnBD3yw22LKeoRFsyEt+2vSeytIgKySB1wk4Nf5EOg9vVlpkOAhMJhLgLsZa/wg8acHAb50hRK3TwdAupKP1MWWboDKqconnOEWM3u2U+Ry1l9hesvhKoY2ZyePut01r+zN2WI0T1pniZXXyelphmpNAdF0ojawtEnsfA2Hlqd2Mibokk0LWbosLCmb5lx+EH/9I2SQPxqkOmdykxC12+gkhewLyvIQn0i8cb3lMVB3ZsY0EaTEiJEc6fqVcFS0dMhNDM9gjEM1pxAIs6Mtz6iJycy/xelEcDZUJjQFASzjO5VYq2RKIGQbQ59iufjDRUCz2abGADpRtcCoPabycp9il+MBWOxI9mq94Txawbf844pRXeiC96DjyIsEjF9b+iVc1qtGRuKjbl/U3oGLjt1eHeruQlO91TixhzGMC2e1ybbYMzo0k75NZSWpw4UFEad/bxsDP/QbV1W+TfuR0aqYG7oFiXzknwD7WOT1uq1t4UT8ZFYHRy4WD+72ZOQb
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(38070700009)(55016003)(7696005)(53546011)(4326008)(26005)(9686003)(52536014)(15650500001)(5660300002)(64756008)(6506007)(66446008)(8676002)(66476007)(110136005)(8936002)(66946007)(83380400001)(76116006)(66556008)(316002)(478600001)(82960400001)(122000001)(38100700002)(71200400001)(33656002)(2906002)(86362001)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SGdXbERydHFiOElyUnRyWlFtZ3dsaDlscEhERVhHQmdHV1BJQTl1VHVOZ2NB?=
 =?utf-8?B?SytubGNmNFgvUUR1UkVoZ2xwelJScDNqL2xrVTZxc0M2cjdHMlhUTjVmMzFZ?=
 =?utf-8?B?N2RDcmVRUlZUeElCSlg5a24yMjBZd3QveStrNU9kejhubStNZ0xaK3ErWXV6?=
 =?utf-8?B?eDdiRTVGVW9jSld1LzRza2xNODhYMEVUWmxZMklvNlhSdUN4cnBsaUFjZ1pS?=
 =?utf-8?B?dVB3K1VvVGkvTGNyL25jNWdrWWxRNzg3eWlDVkl5Z2dPVzRtLzcyU2NlTTJq?=
 =?utf-8?B?djN1ZFFXWFVVOWY1ZzNpcUw3NHV1R20wK1V4UnRaZzd0MVZxaVRwWlREc0dH?=
 =?utf-8?B?dnh0VnNZQU5JVHcyTXFicmFkbnJQK0s5aWNyRUFmaUxISGZYZXZwNVVwUTZa?=
 =?utf-8?B?RWxtNkZTWGtYL0oxajRqN0NtYlIxWXZvdm56OS8yUmhKRVJmUmRoMEQzWS9B?=
 =?utf-8?B?eXlVR2Q2R0RNWGViSmM1ZG11b2xRYlVTS0RoVGVqMk1SdTYwamFTUUpVZG5u?=
 =?utf-8?B?QkZYSnM3ZHJJMWQ1NHp6bnNMNDlJNGJya0dhNUZ0aDU5SkFRdHFMUmlZY1Fx?=
 =?utf-8?B?cjZOUndZdmt1N0VscFk3ZGdaNDArRVNzZ216WTAxazRYL1VDUzRlUVdNbWNE?=
 =?utf-8?B?c205TzB5S1RwOWRNSWdCUWd5OTZQMFVPd0FOcTN6a1JwTSsvL2RrRXYzOUFv?=
 =?utf-8?B?OVJ4SFpGMythanh6akJWbVBtVVF1c2xUd1J4N21TWEYvUFhJcklsNDEvYW9s?=
 =?utf-8?B?OE5uZVJHR3FhM3BiT0E0VGRsSGF1RzRxVVNmMHU1UmVteHorelNmcWtXVUVR?=
 =?utf-8?B?Qm8xTTg3ei8vTVFRZ2ZoVU5NOER5Z2crZE1NdHlXSHZ1THU5cDNzMDh4NGY3?=
 =?utf-8?B?ek1WWnQ3QkZiTXRsV1V5aGxyN0dWMGVleDVrUXVwSFNjTkZJcjJ6d0ZuUy9l?=
 =?utf-8?B?RTNyMWh5T3BLdFhSMTlOQlBFV25yYmg1OUdSdXVoNnNrR1dyL2pKanE2eUhE?=
 =?utf-8?B?RkNNT284YlFqeXU4TzNyZVN4SlJmK0pjUlRPMGl1ZnBRZTByeW5BVEQxZy9x?=
 =?utf-8?B?ZUJwZGI2blM1VWxMbDhsV215TklEOWxKc2VtazRBa05pVUNnT1UrNlVkYWRJ?=
 =?utf-8?B?STVNa3dKczRIblR1TGpNam1RaFowOVA2RjVIRVFMRVJBU21VNmZvamhqcDBm?=
 =?utf-8?B?b25NaDlmSG5YMjExZTh4Wk1qdHhHcGVoT0JmWXJXSUl5bk5WZ2dRS0ZCTENQ?=
 =?utf-8?B?TXI2bU5qVFhiSWthSWgyZ05wUU5ZT2pDT2MzQ0x1cEY2RnA4TDAvRWMyMVNt?=
 =?utf-8?B?MDFoOGZWYmwxL0RoczArY0FENmp2MTNZMVlvNUVtcWxsYzNKS3puUTBuMEZr?=
 =?utf-8?B?R0lNUVZyWW1PeHNmd2xuOCt5emYyaU1xZzZqWUlGdldxaUQzMVdScmZiWjho?=
 =?utf-8?B?MFRJTEVCWXhKaFNBakFxdGZ0OWM2T0ZTRHNaeFZXUFdsWk9WckpVSmwzVGNM?=
 =?utf-8?B?VFJIQTBpN0FrbEJXcGpBeFVHdjZJUW1oSHVhQk0vblN6MzhzcDlKOUdpWXo1?=
 =?utf-8?B?ZWpQdmJ1RXE1Uk1zNU9FdGR6ekk3aEp2UU1sU1l0bzBZTWNxYlU1VnVCWTBl?=
 =?utf-8?B?VmVmMExDVTJhdndEVnJCT3Q5SzJhb21HS09CNGFiMlhndEJ5V3JWdDdCWkRn?=
 =?utf-8?B?QkViTlhRbmhOdXpFZU8vbkpoRDcvOVBKTG5VbkFhN2g0UzNhM0pOMTEvNmJP?=
 =?utf-8?B?UlFuREhsbExYSFkzejFHYTNSOHNtZDlscUthbnJodWQ2THMzY2N6M0RPQ3Rz?=
 =?utf-8?B?Tk1nU3M5UXpoTWtUNGdmOGJ4VCtGUE9icWcxNU9vc1NIeWtPR3RXWUVjaHVF?=
 =?utf-8?B?cHdIQzJYSzFNTUxoYjUwdnpPS0Q1SzB2UFViMUhrekVXQnpUMTJwWUUwaGtP?=
 =?utf-8?B?SFNtdTF5cVlhMWJzL3VmTFVWN3AzaFhvQnFIblZCZTREZGh6czAvR2VyUXNK?=
 =?utf-8?B?NXVETTFJcCtuTVprUE9MZDVhQ2RnNElxNS9hUGhNT2lVOEpnT2RFdks4WjZj?=
 =?utf-8?B?VHJVUWM1NXVmdE5Mc2lDNHFvYU9ReklyTXBvTU0yWXVjd0JaTVpkZVd4OXFH?=
 =?utf-8?B?RWhYb291dkFWeDVyM3FKUjBuUVg3WXh3b1NoZ0lETkJiTXY1S2diTEZHRXov?=
 =?utf-8?B?Umc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 40926b95-b63e-4f01-0e60-08dc0245d875
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2023 16:56:58.7249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x2k5C2wwk0J0FdiIKkknegj1b0fO+Y+qvzbMOM22/jS0T9N+oAUFROryRJeAQIqM34i1tKJwD7tTRhsJMI0C8wRVGnY29cweuAdbo6pMfCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7150

WW91ciBwYXRjaCBpcyB3b3JraW5nLCB0aGVyZSBpcyBqdXN0IG9uZSBzcGVsbGluZyBtaXN0YWtl
Lg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtpc3prYSwgSmFuIChU
IENFRCkgPGphbi5raXN6a2FAc2llbWVucy5jb20+DQo+IFNlbnQ6IFNvbm50YWcsIDE3LiBEZXpl
bWJlciAyMDIzIDE3OjI1DQo+IFRvOiBQaGlsaXBwZSBHZXJ1bSA8cnBtQHhlbm9tYWkub3JnPg0K
PiBDYzogWGVub21haSA8eGVub21haUBsaXN0cy5saW51eC5kZXY+OyBLb3dhbHNreSwgQ2xhcmEg
KFQgQ0VEIFNFUy1ERSkNCj4gPGNsYXJhLmtvd2Fsc2t5QHNpZW1lbnMuY29tPg0KPiBTdWJqZWN0
OiBbbGliZXZsXVtQQVRDSF0gbWVzb246IHNldHVwLXVhcGk6IFRha2UgRGViaWFuIG11bHRpYXJj
aCBpbnRvDQo+IGFjY291bnQNCj4gDQo+IEZyb206IEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2ll
bWVucy5jb20+DQo+IA0KPiBDaGVjayBhbHNvIHRoZSBEZWJpYW4gbXVsdGlhcmNoIGluY2x1ZGUg
cGF0aCBmb3IgdGhlIGNob3NlbiBhcmNoaXRlY3R1cmUgc28NCj4gdGhhdCB3ZSBjYW4gc3VwcG9y
dCAoc2VsZi1idWlsdCkgbGludXgtbGliYy1kZXYgcGFja2FnZXMgdGhhdCBjb250YWluIHRoZSBl
dmwNCj4gaGVhZGVycy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEphbiBLaXN6a2EgPGphbi5raXN6
a2FAc2llbWVucy5jb20+DQo+IC0tLQ0KPiAgbWVzb24vc2V0dXAtdWFwaS5zaCB8IDEyICsrKysr
KysrKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9tZXNvbi9zZXR1cC11YXBpLnNoIGIvbWVzb24vc2V0dXAt
dWFwaS5zaCBpbmRleA0KPiBmMmQwNzc0Li5jOTM5MjU0IDEwMDY0NA0KPiAtLS0gYS9tZXNvbi9z
ZXR1cC11YXBpLnNoDQo+ICsrKyBiL21lc29uL3NldHVwLXVhcGkuc2gNCj4gQEAgLTE3LDcgKzE3
LDE3IEBAIGlmIHRlc3QgLXIgJFVBUEkvS2J1aWxkOyB0aGVuDQo+ICAgICAgbGlua19kaXIgJFVB
UEkvYXJjaC8kQVJDSC9pbmNsdWRlL3VhcGkvYXNtL2V2bCBhc20NCj4gICAgICBsaW5rX2RpciAk
VUFQSS9pbmNsdWRlL3VhcGkvYXNtLWdlbmVyaWMgLg0KPiAgZWxzZQ0KPiArICAgIERFQl9IT1NU
X0FSQ0g9JEFSQ0gNCj4gKyAgICBpZiBbICIkREVCX0hPU1RfQVJDSCIgPSAieDg2IiBdOyB0aGVu
DQo+ICsgICAgICAgIERFQl9IT1NUX0FSQ0g9YW1kNjQNCj4gKyAgICBmaQ0KPiArICAgIERFQl9I
T1NUX01VTFRJQVJDSD0kKCBcDQo+ICsgICAgICAgIGRwa2ctYXJjaGl0ZWN0dXJlIC1xIERFQl9I
T1NUX01VTFRJQVJDSCAtYSAkREVWX0hPU1RfQVJDSA0KDQpERUJfSE9TVF9NVUxUSUFSQ0ggaW5z
dGVhZCBvZiBERVZfSE9TVF9BUkNIDQoNCj4gKyAyPi9kZXYvbnVsbCkNCj4gICAgICBsaW5rX2Rp
ciAkVUFQSS9ldmwgLg0KPiAtICAgIGxpbmtfZGlyICRVQVBJL2FzbS9ldmwgYXNtDQo+ICsgICAg
aWYgWyAtZCAkVUFQSS8kREVCX0hPU1RfTVVMVElBUkNIL2FzbS9ldmwgXTsgdGhlbg0KPiArICAg
ICAgICBsaW5rX2RpciAkVUFQSS8kREVCX0hPU1RfTVVMVElBUkNIL2FzbS9ldmwgYXNtDQo+ICsg
ICAgZWxzZQ0KPiArICAgICAgICBsaW5rX2RpciAkVUFQSS9hc20vZXZsIGFzbQ0KPiArICAgIGZp
DQo+ICAgICAgbGlua19kaXIgJFVBUEkvYXNtLWdlbmVyaWMgLg0KPiAgZmkNCj4gLS0NCj4gMi4z
NS4zDQoNCkNsYXJhDQo=
