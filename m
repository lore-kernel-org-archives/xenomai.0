Received: from KOR01-SL2-obe.outbound.protection.outlook.com (mail-sl2kor01on2075.outbound.protection.outlook.com [40.107.129.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0626562A
	for <xenomai@lists.linux.dev>; Wed,  8 Nov 2023 00:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=doosan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doosan.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=Doosan.onmicrosoft.com header.i=@Doosan.onmicrosoft.com header.b="6aRN9PyQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bU+95tYjKRPCsZDhHGS+Gm7jIvuArJPdZJoNpsT6aAltqRI8rImJmT7lYEhk2mSUFa3dbY2EMrmaEa40Re0tXDB3dCtqlaKsQWqMRpCaEHt/OAKZQXwgW0xQ/Qb31aeUaKY/TxpBu+1Z/ldHAooAwNN1NPmOO+OdLq5PtSVvnjgRSExfLXzOH5a0JEmuTZwZlRYMt4zVJWHxbxekgPHzOFr+8Ask9uQ4J5vcMYxfvtS1WPVkV1c86uwvR2s5UBlvZUxeOHWMjJBCUp4aJK9tosMTr1Z6lWqvXmYBr3QQbIHBmOziBZ6e4d3xX4TYlR6o0VTXO8BLa9mCp65WZ14JnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1szVN/O04gG+xJlrVrIeo8Ohx4j0ekTTj1iEWTJFbw=;
 b=Rr2S8acvbYsy5/Tud3TCI/KhBGsl+Aj62Lcz4+/MgF64HV+FFQX+rTpnk5WvlMeie5eKGNO6iHuixrynkCWC2Rr7F2PId4xAGQpuyugQdP1DdnWsOEkM8L1fCR0PwN+HIwY1tB5YYV0lBwagKB6gALebBzSx9uCWTEsly1zT7mJQ5/85ilgbUfKd30ge6kCqLq8xIX94WH5gwzIfww1ijlVPwrWkEp2NcDjkqXfl31UVOV1PMOwp9ZRa2nZK21Ze8CDKYvzvM9yXX9sOBlxm7Pirue4s9QuNOKoFR/Cn/Mc59Yy2eEXinw3iQniXR1s4DEHw10x8lj2OqUULCeu6JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=doosan.com; dmarc=pass action=none header.from=doosan.com;
 dkim=pass header.d=doosan.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Doosan.onmicrosoft.com; s=selector1-Doosan-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1szVN/O04gG+xJlrVrIeo8Ohx4j0ekTTj1iEWTJFbw=;
 b=6aRN9PyQFsOcY/9JsfRF7DOq7i7MqfDgq/QP5Tgwb7KPJ2TTZ1PYkj1A57nuo71934lFHVFitD5eLiW8q/x+hlhL8ReNOlio5+hGYJG4G00kuKIj+/Zd1VKGFnK6s5SH46SEH+h1Ht6bH6wGeU2rMb53hzKZLe/joWR7mymYj2g=
Received: from PS2P216MB1330.KORP216.PROD.OUTLOOK.COM (2603:1096:301:a0::13)
 by SE1P216MB2610.KORP216.PROD.OUTLOOK.COM (2603:1096:101:1cc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Wed, 8 Nov
 2023 00:11:47 +0000
Received: from PS2P216MB1330.KORP216.PROD.OUTLOOK.COM
 ([fe80::a119:25d4:7c3b:b16b]) by PS2P216MB1330.KORP216.PROD.OUTLOOK.COM
 ([fe80::a119:25d4:7c3b:b16b%2]) with mapi id 15.20.6977.018; Wed, 8 Nov 2023
 00:11:47 +0000
From: =?utf-8?B?67CV6rK97ZuIKEt5dW5naG9vbiBQYXJrKSDtjIDsnqUg65GQ7IKw66Gc67O0?=
 =?utf-8?B?7Yux7Iqk?= <kyunghoon2.park@doosan.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: Shell command segfault occurrence phenomenon when xenomai task
 switching running
Thread-Topic: Shell command segfault occurrence phenomenon when xenomai task
 switching running
Thread-Index:
 AQHZ8Dvh6PD2J1eeWE61B2j5eRG+6bAsl5qAgAAOhXCAAAmgAIAPsMlwgAATJYCAM1ijYA==
Date: Wed, 8 Nov 2023 00:11:46 +0000
Message-ID:
 <PS2P216MB13303009D73D26413933E76AD1A8A@PS2P216MB1330.KORP216.PROD.OUTLOOK.COM>
References: <1695706251-3997-mlmmj-62db5be2@lists.linux.dev>
 <PS2P216MB13306DDFC18190667DEE0409D1C3A@PS2P216MB1330.KORP216.PROD.OUTLOOK.COM>
 <49968ea8-1651-4bf0-bdd5-b3e3dbe252b0@siemens.com>
 <PS2P216MB13303939F1828F55FF296B3AD1C3A@PS2P216MB1330.KORP216.PROD.OUTLOOK.COM>
 <78d7a44a-c84c-4a36-bbb6-fc6d7a3bb3b5@siemens.com>
 <PS2P216MB1330EB1FD1896D2A239CBF25D1C9A@PS2P216MB1330.KORP216.PROD.OUTLOOK.COM>
 <6dfcb5c9-8f86-4c12-9207-21b99bc22b38@siemens.com>
In-Reply-To: <6dfcb5c9-8f86-4c12-9207-21b99bc22b38@siemens.com>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=doosan.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PS2P216MB1330:EE_|SE1P216MB2610:EE_
x-ms-office365-filtering-correlation-id: 6ecae965-6d21-4bfc-9230-08dbdfef4c0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 2eHVC9VhW9jti/k+j1GqWTvZ+QGLTHo1mc0tvaMnBzUYnSdoDlBVXvN9o3ZZpao6ZrDUCUZJVg4PGMk2P2wEVjXZg7yr0thO0zk3JccabEc3z6ro/uSHM0x+TVVsVtCQI4RseRyy3Kl1Nx79/dbMYWobmaN4j0bkBZfo4B1Fav2ZDv5EHanCK0173HWIPziPAbUwaOMDiN+Oy5iM+/Vrf6MFrcG0rDkrUml4D6ais6vzoIOj7nLz+06SfWo7vg2ZyUKuafkWkaZX+2Re6SYkChRJFVq1uO8ZOWP/TVWfLofhdHKzd3LLwZ23ENHIfI59+e/5+htBzIQpMEyF/42o4r4JjStwX5crpbscIMCNJaHmUdZ3WDKjEk00Os8TN7ospmCJsHAyABqSAb/BCjiBt/98/21GhTV2bcUEYtSHIH6OS7udA0m3pSIaadXgyz9K2tIFy6DmE9m35LCRieCxsRGYNAkOVNJ8bzqBVqly35B1sVjYOL7EiEeBNNeEIERLby3TX0CofyFR2qPZTGkkJsFuKzoi/dNMIgpNDc3KlacG/XOqJj07ELnhjbDMz1P+NmRq5vms4aTPUdbKckgFQqwYAyVJvunn0v16LQAn8Xe+tjuX2atdgD4sKKqXAv5Sk2Q3U3qAJq8gmypXOqPdlNtrYwEv9+ZnfkiL3M0upaA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS2P216MB1330.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(396003)(366004)(376002)(230273577357003)(230922051799003)(230173577357003)(186009)(64100799003)(451199024)(1800799009)(9686003)(6506007)(7696005)(53546011)(33656002)(26005)(478600001)(83380400001)(38100700002)(66946007)(76116006)(71200400001)(66476007)(66446008)(64756008)(316002)(6916009)(66556008)(41300700001)(55016003)(5660300002)(52536014)(122000001)(8676002)(4326008)(8936002)(2906002)(86362001)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?STlNSnB6VnAxZWhab2EyY1I4WSsxZlB6cHlvYmR1eG5Pd0NIeWZKWXkyOWda?=
 =?utf-8?B?Wm9lWnVTbnNVaHhVUktSZXFKTlNJZkc5bHhDTm1tSVlRYUNDWUJlSkthNXIw?=
 =?utf-8?B?R2VpZGU1d3RHL3NuQjB4S2tZK0RjVnpEOGNieENOMlZsUG5VWTJXblRKdE9Z?=
 =?utf-8?B?di81T1padUdQNjFFekFhQ2U5Z2hnWDU2Mi8xWHl5VFNzc09hOWF1WndyTURG?=
 =?utf-8?B?eVROZXVDSmRITTBhRjJZbEduVlAxM1hhMEwxY0RVdXpaRjNaTENQVS9ZdHV6?=
 =?utf-8?B?eUhYL29JYWE1bmN3clpQR1NyTkhEVTV3NFVsV085YXA0dnV0b0JIaXVYbzFp?=
 =?utf-8?B?bjY4ZzhtUTlkTFRqYnh0KzhKRFY4YU1JV1BsY2h6clN3MEpycnI0Y2dkemdu?=
 =?utf-8?B?aWZHc08rRis0QWlYYVdNM3lhdUc3VFl5YUNIM1ltRHIrY29WQm9sZWFhRzV4?=
 =?utf-8?B?alc4VTZydEdwanFqeGJ5MHQzTFA3LzA2WnRQazRmQjkrQXdHVzN1eG1sNDYr?=
 =?utf-8?B?R21FNlA0SGR1RnhVeDBuRjJhLzRQVGFycEtLTHg1UWZ6WnF5OGZSSXhMYjRJ?=
 =?utf-8?B?VDBvek9XcWM2WGo3VWJKbWtyQU1NL2lzZEJhUTg3cGNkL090ZVQvZml4dmM4?=
 =?utf-8?B?NUdEc0lPNVVHdWp5L0VoVjl2K0Era0ZHZlJaNnBvNnF1aytyby8rMVpmU0Fl?=
 =?utf-8?B?bTc1Wmd1bGFXTkIvSk1Ga1JRWi8zak45Vy9LdFliQTEvQjh1bUpqWXRRNkhE?=
 =?utf-8?B?SHhlUHk4TjB3WDVnMHkva1c1SUo5RERTVVo2OFhsWFlQbGlGam55dmgvcll5?=
 =?utf-8?B?SGlCSE82T0g5UVR4czQ3WjErdWdwTGd5WXpLRWVXQTVFcDZtaFF2b1dGcXo5?=
 =?utf-8?B?dlBmaVpZNlhPVVZiY3I1VS9IUDdvMUNxSkFTNGJ2ZHNWazZZZmpVVndnSlAx?=
 =?utf-8?B?andHdnJYbS9lQmwyQjVBZVl2VXRKbGEzT09seUgyVjc0WVZkQXllK3J6Q2Fv?=
 =?utf-8?B?Y2F4d0JrY0lDYkFTOWZneEd4M3F2d0tnK3lvWkNmRzdIOU56UWU4WkkyN3B2?=
 =?utf-8?B?WjNrTGJoMm0xVVVFUEZXU0hONGtsTXJTbkFZWnYrcEk4VW10WHN0cFY1VTBz?=
 =?utf-8?B?QWFZb25WeUIyeE5JZnlYd2pockcxUGJkRXBJVUlRL0FrREQxMXpQNHpZUFdh?=
 =?utf-8?B?TlNjaCthRERhbVVVNzh6VDFuZ1dFWTU4bkh1dFQ1MUdCWjV0QWhmN2NBMHVF?=
 =?utf-8?B?bzNaN1VHdWxZTDBySmxwNVVIUmpZRkN4V1ZWaWYzM29DV3FaY0JTZS91dE54?=
 =?utf-8?B?N3NJdkFTejc4YitwYWxIb294eXpEUnlVQTZsbTFrRlNXRWluMDBiNHJiOWxQ?=
 =?utf-8?B?SE90UndISlNMQTA3dGE1YlBsVDRDY0VTODdhRWUyRUliNE53RXJQSDg3c2Fi?=
 =?utf-8?B?UmF0OGxWWStTTmpKUmw3OUVUOFdoQ3Y2VTlaQi9vTVUyRFBVTzVZaG1PUzJG?=
 =?utf-8?B?ejFKbE85UWtBL1NUMHAwTHd5eUo0b1Q5RXRGR1dUdHVtL1VxRng3cDhCRFVE?=
 =?utf-8?B?SmluRzhkWEpXY3lQTXI1c0dUaWY5ZUE2Mk9nZUNTWlZYS3puVk95dUl4Vms2?=
 =?utf-8?B?eE5Dd1ZRM0dXdlRSc2lkeE03bDNBZ0Fwek54QVVQTUkrQXVoR2hTL3pvemlF?=
 =?utf-8?B?dlVTSVBLYUJzcHpMMkl2VVJNQ0FXZzlIczFuaW9zbVZyaFcxekxFWlBYUWk1?=
 =?utf-8?B?RUtTZEpFMXA4MlFWUGZPRzl1eXpRZzVnTElRYU5wNWFnalh0Q3pWT3ZEajVL?=
 =?utf-8?B?R3lYU3pSV1VJM0J3TFNNREhYdVcxMzdMYmkzTVpxbHVjZGZxcWFVUHNXMEFP?=
 =?utf-8?B?VEZmSkMxb0JORGxvTmwzcWtzelk4cTNLc3UvcEJDVjc4MXJ1L3ZuMVhEY3po?=
 =?utf-8?B?RFhReXJtdEFRUWhVT2FNcFBmV29UVXIzaE40eG9NTEJJQkROU3FTUDN0NVZZ?=
 =?utf-8?B?ZEp5MElnOFVDZzFqQ3RqVGdoY1B6anMxcWZWWXZ6MjA0M1JORW1hNG1KTDBy?=
 =?utf-8?B?b3hIOUhXczgxMVZTTS83VVVlYXhhRzVYS2tHa0s0UjBCR1g3TlhoVitFMHQv?=
 =?utf-8?B?UEZPWVlUanlESGNxa3JjMW83UjVjZ01KU244U0ljQ0NZWmVUYmFQcG5nMzBP?=
 =?utf-8?B?QWc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ecae965-6d21-4bfc-9230-08dbdfef4c0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2023 00:11:46.8978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1b3610-9ab0-42d5-93aa-46150d723d87
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yE5SFKmy287/MaPn7chm4s4tj4ydIpBCF72/Xl8eMSWgRi4JG52NkNbHpX/mnbwKbxyAH22RKMzH3kDvYAahORE5o7uuCOPYo2SoZjdsDNA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1P216MB2610

SGVsbG8NCg0KSSBhbSBjb250YWN0aW5nIHlvdSBiZWNhdXNlIHRoZSB4ZW5vbWFpIHdhdGNoZG9n
IGlzc3VlIGhhcyBub3QgeWV0IGJlZW4gcmVzb2x2ZWQuDQoNCldoZW4gYSB0YXNrIGlzIGtpbGxl
ZCBieSB0aGUgeGVub21haSB3YXRjaGRvZywgYSBkdW1wIGZpbGUgaXMgY3JlYXRlZCB1c2luZyBH
REIuDQoNCldoZW4gSSBjaGVja2VkIHRoZSBzdGFjayBmcmFtZSwgSSBmb3VuZCB0aGF0IHRoZSB0
YXNrIHdhcyBhbHdheXMgdGVybWluYXRlZCBpbiB0aGUgZ2V0dGltZW9mZGF5KCkgZnVuY3Rpb24u
DQoNCmdldHRpbWVvZmRheSgpIGlzIGNhbGxlZCBmcm9tIHRoZSBweXRob24gdGhyZWFkLCBhbmQg
dGhlIHB5dGhvbiB0aHJlYWQgd2FzIGNoYW5nZWQgdG8gYW4gcnQgdGhyZWFkIHVzaW5nIHJ0X3Rh
c2tfc2hhZG93KCkuDQoNClRoZSB4ZW5vbWFpIHZlcnNpb24gaXMgMy4xLjQgYW5kIHRoZSBsaW51
eCBrZXJuZWwgdmVyc2lvbiBpcyA1LjQuMjU1DQoNCkkga25vdyB0aGF0IGEgc3lzdGVtIGNhbGwg
aXMgdXNlZCBpbnNpZGUgZ2V0dGltZW9mZGF5KCkuIFdpbGwgdGhpcyBoYXZlIGFueSBpbXBhY3Q/
DQoNCsKgDQpUaGFuayB5b3UNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEph
biBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+IA0KU2VudDogRnJpZGF5LCBPY3RvYmVy
IDYsIDIwMjMgNDo1MyBQTQ0KVG86IOuwleqyve2biChLeXVuZ2hvb24gUGFyaykg7YyA7J6lIOuR
kOyCsOuhnOuztO2LseyKpCA8a3l1bmdob29uMi5wYXJrQGRvb3Nhbi5jb20+DQpDYzogeGVub21h
aUBsaXN0cy5saW51eC5kZXYNClN1YmplY3Q6IFJlOiBTaGVsbCBjb21tYW5kIHNlZ2ZhdWx0IG9j
Y3VycmVuY2UgcGhlbm9tZW5vbiB3aGVuIHhlbm9tYWkgdGFzayBzd2l0Y2hpbmcgcnVubmluZw0K
DQrso7zsnZg6IOydtCDrqZTsnbzsnYAg7Jm467aA7JeQ7IScIOuwnOyGoSDrkJjsl4jsirXri4jr
i6QuIOunge2BrCDtmLnsnYAg7LKo67aA7YyM7J28IOyXtOuejCDsi5wg7KO87J2Y7ZWY7Iuc6riw
IOuwlOuejeuLiOuLpC4NCg0KQ0FVVElPTjogVGhpcyBlbWFpbCBpcyBzZW50IGJ5IGFuIGV4dGVy
bmFsIGFjY291bnQuIFBsZWFzZSB0YWtlIGV4dHJhIGNhdXRpb24gd2hlbiBjbGlja2luZyB0aGUg
bGluayBvciBvcGVuaW5nIHRoZSBhdHRhY2htZW50Lg0KDQpPbiAwNi4xMC4yMyAwODo1NCwg67CV
6rK97ZuIKEt5dW5naG9vbiBQYXJrKSDtjIDsnqUg65GQ7IKw66Gc67O07Yux7IqkIHdyb3RlOg0K
PiBIZWxsbw0KPg0KPiBJIHNvbHZlZCBzZWdmYXVsdCBpc3N1ZSB3aXRoIHlvdXIgaGVscA0KPg0K
PiBBcyB5b3Ugc2FpZCwgSSBwb3J0ZWQgeGVub21haS1zdGFibGUgMy4xLnggdG8gDQo+IGlwaXBl
LWNvcmUtNS40LjI1NS14ODYtMTUgYW5kIG5vIHNlZ2ZhdWx0IG9jY3VycmVkIHdoZW4gZXhlY3V0
aW5nIHRoZSANCj4gc2hlbGwgY29tbWFuZA0KPg0KPiBCdXQgSSBtZXQgYSBuZXcgcHJvYmxlbSB0
aGF0IHhlbm9tYWkgdGFzayB3YXMga2lsbGVkIGJ5IHhlbm9tYWkgd2F0Y2hkb2cuDQo+IFRoaXMg
aXNzdWVkIG9jY3VycmVkIGFib3V0IDIwIGhvdXJzIHJ1bm5pbmcgYWZ0ZXIuDQo+DQo+IEkgY2hh
bmdlZCB3YXRjaGRvZyB0aW1lcyg0c2VjIC0+IDlzZWMpaW4gdGhlIGtlcm5lbCBjb25maWd1cmF0
aW9uKHhlbm9tYWkgZGVidWcgbWVudSkgYW5kIHJlLXRlc3RlZCBpdC4NCj4gQnV0IHRoZSBzYW1l
IHBoZW5vbWVub24gb2NjdXJyZWQuDQo+DQo+IEhhdmUgdGhlcmUgYmVlbiBhbnkgcmVwb3J0cyBv
ZiBhIHNpbWlsYXIgcGhlbm9tZW5vbj8NCg0KU3VyZSwgdGhpcyBpcyBhIGZyZXF1ZW50IHByb2Js
ZW0gb2YgYXBwbGljYXRpb25zIHRoYXQgZG8gbm90IGxlYXZlIExpbnV4IHNvbWUgdGltZSB0byAi
YnJlYXRoIi4gTWFrZSBzdXJlIHlvdSBoYXZlIG5vIGluZmluaXRlbHkgcnVubmluZyBSVCB0aHJl
YWRzIGluIHlvdXJzLiBUaGV5IHNob3VsZCB0aHJvdHRsZSB0aGVpciB3b3JrIGV2ZXJ5IGZldyBo
dW5kcmVkIG9mIG1pbGxpc2Vjb25kcyBhdCBsZWFzdC4gTWF5YmUgdGhlcmUgaXMgZXZlbiBhIG1v
cmUgZnVuZGFtZW50YWwgaXNzdWUgaW4geW91ciBjb2RlIHRoYXQgY2F1c2VzIHJ1bi1hd2F5cyB0
aHJlYWRzLg0KDQpKYW4NCg0KLS0NClNpZW1lbnMgQUcsIFRlY2hub2xvZ3kNCkxpbnV4IEV4cGVy
dCBDZW50ZXINCg0K
