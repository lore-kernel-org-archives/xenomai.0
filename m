Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013004.outbound.protection.outlook.com [40.107.162.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5519409106
	for <xenomai@lists.linux.dev>; Wed,  3 Jun 2026 08:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780474859; cv=fail; b=Y+f4H7uby1xWdLaz8hTKyngZuun40WmMP4KSRdUibHZ07hf58ZfD1yf4Dnkw/OyZhkfjzPBbCTfuqe8Ldts+fkdkz7GpXW8i7gMagM0zH1TYFpS7M+K4D0AhsAtqY6+f7AD+fUhnA8wUSsbim/x/VtjBMpjWqoYf23eaI68jHyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780474859; c=relaxed/simple;
	bh=IUdOxsSGTmYIYDwm9xMebcOQH6V9rge/trSYCVkWLC4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jJY2i3hzOfsNYPJQBqNWOTJ5NUlOWUSMKieiDdEVGQkmm5IGbt5eZxsyu+/WDTw5QpRgVAgj/6KvEhy9APqPT6iqkvCC60KIy6XWqYOjqGzWXoUQIkLu5pC4R/3NY4goyhyZ2cBH+KZ3yYCCD3ACdPLbPMfHU6zXTCuEXhSlsH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=MqqZ18CT; arc=fail smtp.client-ip=40.107.162.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="MqqZ18CT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Woz09ZUhGh3gpS48I6yQc16o+jmkZAfrvIBa/NVgt1hT45fTjoThqKOwrttziC6dMbU3cYZ4uUyb+VG6lEBA2SU0Vxg5j1dhIJjYwtdoB+xfrHtFdUHJc4/cnPRrHorKZGPz5MnHoJiuIT0/O/TST2Cgr7tyS+9A/gCHA3A4iA8WMbbBI3oG6w/ZeygORzwvQZglm5j8KXJ7ZTgkK7fRFUfjSBc/69Ecor5xJFaInI1N0AnUlJkRgP0XH0jxu9F+Y24eZA4cybXVKYVZISbFuxKhIU1tCeatqLGHBmKGA+NOYR9g8orYFtqrVW7aw78akSPPUqNSdtfRzkcNh2I3hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUdOxsSGTmYIYDwm9xMebcOQH6V9rge/trSYCVkWLC4=;
 b=OHm3UpkbnVIviX7DUJQsO3Xvw6kjyV6qLL7dLcSyjg+WcB2aGwRk2p9MjeC33HibazQoNFyJwNqul2EfnAY5ECVrd29ubTddsWZiWm8423JDy6NRU1Js1tKzxFS0+DXMv3jPA9YokMq78D2lZbrOErDCsOd9hULTOyrF+SaccaMLEJMKyqA0iobZbADfH3t8OlhKY+YGpZh5DLpyp1ZVy9Dm32zEpfNxIQc87xENRU2gcT0rRTZr6g7cEjZ6wCXPglCf1Wfnw3rXLDee4MdmZQ8fsBfOrHugrPhekRYE4WZpWGj2iDV3F9r+x8J3UXK+4GFjOVVWXCsSVlkR7iHVgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUdOxsSGTmYIYDwm9xMebcOQH6V9rge/trSYCVkWLC4=;
 b=MqqZ18CTiKNqoZ+0Syq3h80A6rEPTfA+v1mGU/E1LWKFP8C6MbyLzFjwEbULAX7OPDuMahVZ9nx0nbg6IOGojhdkqt9WqpHtyWv1Rg2B5aoxnq4SHGaY0dcfcAr7IAQy+LssSEvA5n01UlKumpgAzHNlh3P//qjyKShmN+szwqyk9InF6Yq/aAZxPXj6PRm8r+q/PRnzW+MZLQzwI8o+vB6qPIoz7NryafCQJ5s8cY4laDxv9M5MeoXKUgw2M0+LcooWg66zmP64ve+nKPA7zMBzQqbCXdGgQVFr9Z0zNSzLoWGnqmV/yya82RkzVffwLu9aAARaGkxi1OQtirpVdQ==
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB4PR10MB6094.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:38e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Wed, 3 Jun 2026
 08:20:54 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4072:14dc:7d1:74c7]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4072:14dc:7d1:74c7%5]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 08:20:53 +0000
From: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
To: "rpm@xenomai.org" <rpm@xenomai.org>
CC: "Schaffner, Tobias" <tobias.schaffner@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>, "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: Dovetail 7.1-rc6 updates pushed
Thread-Topic: Dovetail 7.1-rc6 updates pushed
Thread-Index: AQHc8avhJjimH0x+YE+YR+1sM/Iqv7YptduwgABLYICAAARvOYAA/4MAgAF7QwA=
Date: Wed, 3 Jun 2026 08:20:53 +0000
Message-ID: <3551ce7178079f669dcf8a15981132be3641571a.camel@siemens.com>
References: <aea902f9f55316c2c357b9fadbbd8e9b716e92ff.camel@siemens.com>
			<87y0gy4brj.fsf@xenomai.org>
			<27c28604c6d3abca8b31ddf182bdf6d52ad4d572.camel@siemens.com>
		 <87se763yji.fsf@xenomai.org>
	 <eae9c7c7ecfebf7503f52051e8a444a4cec90888.camel@siemens.com>
In-Reply-To: <eae9c7c7ecfebf7503f52051e8a444a4cec90888.camel@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.60.1 (3.60.1-1.fc44) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB5712:EE_|DB4PR10MB6094:EE_
x-ms-office365-filtering-correlation-id: b83a7b70-0c3f-48de-09b2-08dec14907a9
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|55112099003|38070700021|18002099003|22082099003|56012099006|4143699003|11063799006|6133799003;
x-microsoft-antispam-message-info:
 LHu864yBDQnweeDM29qdcnOTUjWeEcWF3O5qLCk15Ki+tQdZ/hwzRq0oj41lMygtk9HiDXLs4dc7VKnHX2FqAvku9EMDsV5crKsMNAVTOegJqeCF8uuYMSLwJskouBjGQ3IqcG930kkXyGpWO4icj07R5XBHbipMRNtMo8E+Ksxw0FMC2WF0rCEwc82B9IN6X4mr0V2ve/ePjFgGDU8WdDxfdmWs5cU5yzLp7NhzwkGHNk1680C/YPrcel8BmQTbUX099JYrExzX+GTDKWJFTww3xdquZZaslU9Qg+lcrQmym8dEwdwBKsKiqp/EmZxURFLtUZ1vx53JuFZer/mOCBO4zT1GesD958TLL+BBJfaXiOLy7RhJcqke+JXECM4OyXN4HubeU1fgy5+7I1r0hZBQ71/t1T+3cjSR64VgvxEnKaxa8l26sSHePC0y3nj5F2jQi5iXdsMcjw5Ph+ulWIeWeSN0rk+d4XAF4zCRzzDkD4GsHrQ77/VRDRFY/Ite0gToks/fmd1fN17T2xrv6UjR+E4N7/JNPBotukSu1h+EOCpM617KbVEqPHqJCJ6R5e1XMTcgD/g0ogPC+oGF2OsvjoW5zEJUsbb0OqE/DCh9OQeFOaTxGLuEsuUPYYejRQ8YufsH3ixxeY0CVCIQ0GPdnjgqBm9tbQo3hW1PBhQ/eH6N35AMfTv/KOShGquSa72JQmlt7wIdEnjmWtEsfXlOSJAGzwQGsBCfd5ruLBbWV1GbmZmkCzdDx1q424Gu
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(55112099003)(38070700021)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K0NIV010K2g4RHhnb3ZZWXVBamRyUmZ3Qzc4b0ZUSTFiM1FpcXZucUdsQnZT?=
 =?utf-8?B?eVVQa2JSM21YWTk0RGR4bTJIT1VjaC9Ub3k5VHMybWJyY0hYZmFodnl3aTlU?=
 =?utf-8?B?UWFwOVcrK2ZhUzVES2ZvenhGV0ZVbXZIUUtTTkNDdFhGQlZudnM1bzJYWWFy?=
 =?utf-8?B?VERCM3RuNHJaME5naHlPd2paUmZMbXZYNG1xUEZyVU1Zb0t2eVJlQ1BaQ0tZ?=
 =?utf-8?B?L0NKUUgwc1dUVXdreXJKOExyVVY1d0I2R3FLZDA0N3JJM2xMelZhYjU4MFlE?=
 =?utf-8?B?cGs1M2NMNTNXZUZvNXltYUpXOHA1Y2hLWFdTTzBENzJ4M0VGOTlMQ1dCUDJH?=
 =?utf-8?B?MG1BUVIzVzI3TnNtTnF3cUY3eGhmUHF0enRwb2ROOStJc1ZMUlhZNUZpWlRV?=
 =?utf-8?B?eUVSVnFqTmNGUENUQ0hhVkhEekZ4SHBaWXl2aUxHd2xEbzdNQzUrMFFMZGRI?=
 =?utf-8?B?UkZ0VFdQWGZGYmU0eFFJU1Z0RmFzaVZLK0psMkFHYkwxRFB2SDk0QjdVdUpL?=
 =?utf-8?B?Ly9JbXZ6d3V5WTFMdkRxa0h3OEJ5Zk1venROMXhzblhrRjZ2bXR1ekFZalNX?=
 =?utf-8?B?aUdYYm0yMzFEcGpRc0k4dWdGR1lXdERjbWtDdmN5YUljRWdPZkJRVnZQdTZW?=
 =?utf-8?B?SmtQNElHcUVQQS9NU1hwRUQ3SU4zY0JrQjBnQm1KbUlPWHJ0aEo0cG1wUTNC?=
 =?utf-8?B?MmF1c0VWbFNsSnFoWUl4Q3A5dzF2OE1uZUtMVVVMMWZQSXRoSlRaRG43NSsz?=
 =?utf-8?B?NUxxZjZxczdMS2ZwTjVZZzRaRXhEbDNnaEw0TUZYcEZEcTZuN3ZOeVowdEVt?=
 =?utf-8?B?NlZFYWtHN2FBSVd0ZThZR0xxTzJxZEx2N0JQNC84OXU4M2NNT0tFTGxrS1o3?=
 =?utf-8?B?dFpJQmlMVHdrbUlkQTRsNHYxLzYxZGpCZVdITW43Z01hN2xidXFvSEk2dFh2?=
 =?utf-8?B?NkFkRFZCK216UjhjR3pPSURKY0pDQ0paY01qek05Z1piM0lsanMwVjdPL25I?=
 =?utf-8?B?ai8zU1NOUjRWSVAzZ1NwcWxnUDRseHNDYkp6SmptS0VWUnRTeUJ0Mm0rc3BX?=
 =?utf-8?B?NG9tVzBMSlBaQjVqVWZyLzg0bzg0U25xL01UZ3ZINTFTZDdqMUtkWFFKZ01a?=
 =?utf-8?B?aWNGWEE0d0NiWE9PSmhlbU9Oc01Jb1pHQitTVmhhd25rNFl3bVV2WSt1RC8v?=
 =?utf-8?B?ZVoySS91aUkvTENvS0FFQUxTaCs5cDhvR25zdWR0bHpJQzAvRXBObkdsTzJ5?=
 =?utf-8?B?RkU2bmJ1Zjl1RXJjVkJJKzVCRHp5aS9TQ0pXMjVvMS9pQ1NoUHlVbE95V2xr?=
 =?utf-8?B?OXIzUmU2WlRFSXExUXY5aVcwUlJxNVFQZi9ydTFPOEk5cFdiWHZmUSswT3pi?=
 =?utf-8?B?WS8vRC82YkdjMEoxNENHc2U5S0ZHblhScWsxWmZxSVA4Z05SNUljTFlaTW5M?=
 =?utf-8?B?RU1vNnlLZnkvbkFlWGM2eVRPUG1PelY0V0dTdElDMUkzV0VvOTNuREFMaVBR?=
 =?utf-8?B?VlI1ZFZ6Qkx1cU1EYk4yYzRramZGdjNPQ0VmeXdBT1NJL0RDZVlpNmVyQWQ4?=
 =?utf-8?B?TXJINXNtWHFFVThhVnUya3MwL2doK3B4bDBYbVNvanVSWklRelh3bFRTcEVa?=
 =?utf-8?B?S2RoUmxZY3M5eUtMKzlPM05jYUswRFYzZXRJbmt2TnY2YmJyeE1qZzdpL3VL?=
 =?utf-8?B?NVBsZWptZ1hVWVZuZDRwMm90V0lGQW1RbEZsQTdkeFlveXVhNzF3OS95VHZC?=
 =?utf-8?B?OGVEZXphME5SMG5yaUZlMXhTaVlEZ1FnQkJLNmJDU1YwVDFrcU82TnhUakFE?=
 =?utf-8?B?elFDVVl1U1oyVzdHOEE4eUVmMlkwL2Z3TUJJZmZrVjVKMEgwdG9Jb2YwNnly?=
 =?utf-8?B?aXFSYmluaHBWTCtWZDF4UEd6WlF2MlY3Y3BobmExZ3ptNTRjMDRWTGJzd01Z?=
 =?utf-8?B?Y2Z0eDM2MllxSmVCb3FRSVMrcFR5M2ZLZGJSRVRFdFdNRjBOSHExZGxldzUz?=
 =?utf-8?B?L0h3d05Bb1hSbDRGREhmWDJDSkk0V3RZK3ZwQnpDWDhBNWVaQVB3REtDcUxT?=
 =?utf-8?B?dHBpVXdCd3NKSUdnUzVFWnlrMldFTVhSZDROTmRlS2Q3SGRHMzF4QjVpUmxj?=
 =?utf-8?B?WTZXMmRyK3poWUVSaWR4TVhXQlJnWXhnRDIwSFZPV2RHV2pVYU4wSW1VKzhi?=
 =?utf-8?B?cDFrdW4rcXNVcms0d1ZLNWtrTEpNVTdIeVQrcHU1eGRZajQwZklxOWRGVzAw?=
 =?utf-8?B?TWR5TmxvNHI4QTVDai9TdUVvZzBKell4TWxFOFJBM0RtTmN5Z3hjY2RONSt6?=
 =?utf-8?B?cUdxRlp0T0RzZ3dESW91Y3RRWVQ4dmZYeURXc2l6NmhCVzlERmNMUEk3S2Rx?=
 =?utf-8?Q?6fRUPHFrwI4mRpZ9wTbY245Q80aEG0atZ2Cym/fIWVfnT?=
x-ms-exchange-antispam-messagedata-1: MNmaH3KjG30a/c3xJriuY/kwbcAtdYFKHm0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <35DB124645B849438A942F5B640DDC14@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b83a7b70-0c3f-48de-09b2-08dec14907a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 08:20:53.8044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FL63G8FPb/S2L3KdJOn4W/nFukauFCybZOjDVx5kaQkvW/XklhvN4jWbmJnomR/H08bIu7cdf5FW/kStehXbYcITD2EOEX7pSBIiOY10vmE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6094

T24gVHVlLCAyMDI2LTA2LTAyIGF0IDExOjQzICswMjAwLCBGbG9yaWFuIEJlemRla2Egd3JvdGU6
DQo+IE9uIE1vbiwgMjAyNi0wNi0wMSBhdCAyMDoyOCArMDIwMCwgUGhpbGlwcGUgR2VydW0gd3Jv
dGU6DQo+ID4gRmxvcmlhbiBCZXpkZWthIDxmbG9yaWFuLmJlemRla2FAc2llbWVucy5jb20+IHdy
aXRlczoNCj4gPiANCj4gPiA+IE9uIE1vbiwgMjAyNi0wNi0wMSBhdCAxNTo0MyArMDIwMCwgUGhp
bGlwcGUgR2VydW0gd3JvdGU6DQo+ID4gPiA+IEZsb3JpYW4gQmV6ZGVrYSA8Zmxvcmlhbi5iZXpk
ZWthQHNpZW1lbnMuY29tPiB3cml0ZXM6DQo+ID4gPiA+IA0KPiA+ID4gPiA+IEhpIGFsbCwNCj4g
PiA+ID4gPiANCj4gPiA+ID4gPiBJIGp1c3QgcHVzaGVkIHRoZSBmb2xsb3dpbmcgYnJhbmNoIHVw
ZGF0ZXMgZm9yIERvdmV0YWlsIGJhc2VkIG9uIDcuMS0NCj4gPiA+ID4gPiByYzY6DQo+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gRG92ZXRhaWw6DQo+ID4gPiA+ID4gd2lwL2Zsby92Ny4xLWRvdmV0YWls
LXJlYmFzZQ0KPiA+ID4gPiA+IHdpcC9mbG8vdjcuMS1kb3ZldGFpbC1yZWJhc2UrcmlzY3YNCj4g
PiA+ID4gPiANCj4gPiA+ID4gPiBFdmw6DQo+ID4gPiA+ID4gd2lwL2Zsby92Ny4xLWV2bC1yZWJh
c2UNCj4gPiA+ID4gPiB3aXAvZmxvL3Y3LjEtZXZsLXJlYmFzZStyaXNjdg0KPiA+ID4gPiA+IA0K
PiA+ID4gPiA+IFRoZSArcmlzY3YgYnJhbmNoZXMgYXJlIGNvbnRhaW5pbmcgdjggb2YgVG9iaWFz
JyByaXNjdiBlbmFibGluZyBzZXJpZXMsDQo+ID4gPiA+ID4gbWF5YmUgd2UgbmVlZCB2OSwgbGV0
J3Mgc2VlLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEFueSBhZGRpdGlvbmFsIHRlc3Rpbmcgb24g
dGhvc2UgYnJhbmNoZXMgaXMgaGlnaGx5IGFwcHJlY2lhdGVkLg0KPiA+ID4gPiA+IA0KPiA+ID4g
PiA+IEBQaGlsaXBwZToNCj4gPiA+ID4gPiBJJ20gc3RpbGwgd2FpdGluZyBmb3Igc29tZSBmZWVk
YmFjayBmb3IgWzFdLiBUaGF0IHNlZW1zIG5vdyB0byBiZSBhDQo+ID4gPiA+ID4gaW52YWxpZCBj
b21iaW5hdGlvbiBvZiBrY29uZmlncywgd2hpY2ggaXMgZG92ZXRhaWwgc3BlY2lmaWMuIFVwc3Ry
ZWFtDQo+ID4gPiA+ID4gdGhyZWFkIGF0IFsyXS4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBDYW4g
eW91IHJlbWVtYmVyIHdoeSBLVk1fSU5URUwgaXMgbm90IHNlbGVjdGluZyBYODZfRlJFRCBpbiBj
YXNlDQo+ID4gPiA+ID4gSVJRX1BJUEVMSU5FIGlzIGVuYWJsZWQ/IEkgaGF2ZW4ndCBjaGVja2Vk
IHRoZSBkZXRhaWxzIHlldCwgbm9yIHRyaWVkIHRvDQo+ID4gPiA+ID4gcmVtb3ZlIHRoZSBkb3Zl
dGFpbCBzcGVjaWZpYyBhZGp1c3RtZW50Lg0KPiA+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4g
TWF5YmUgYmVjYXVzZSB0aGUgcGlwZWxpbmUgbmV2ZXIgc3VwcG9ydGVkIFg4Nl9GUkVELCBkb2lu
ZyBzbyB3b3VsZA0KPiA+ID4gPiByZXF1aXJlZCB0byByZXdvcmsgdGhlIGlycS1lbnRyeSB0cmFt
cG9saW5lIG1hY3Jvcywgd2hpY2ggaXMgZGVlbWVkDQo+ID4gPiA+IHBhaW5mdWwgd29yay4NCj4g
PiA+IA0KPiA+ID4gSSBzZW50IG91dCBhIFJGQyBwYXRjaCBmb3IgdGhhdCwgaW5wdXQgd2VsY29t
ZS4NCj4gPiA+IA0KPiA+ID4gTWVhbndoaWxlIEkgY2FuIHByb3ZpZGUgc29tZSB1cGRhdGVzIG9u
IHRoZSB0ZXN0aW5nIHBhcnQuIFRoZSBmb2xsb3dpbmcNCj4gPiA+IHByb2JsZW1zIHNlZW0gdG8g
YmUgcmVwcm9kdWNpYmxlIG9uIDcuMS1yYzUgYW5kIDcuMS1yYzYgLSB3aGlsZSA3LjEtcmM0DQo+
ID4gPiB3YXMgZmluZSAoYXQgbGVhc3Qgb25jZSk6DQo+ID4gPiANCj4gPiA+IHg4NiAgIHgzOiBU
ZXN0IHRpbWVvdXQuIFNvbWV0aGluZyBzZWVtcyBzbG93ZXIgdGhhbiBleHBlY3RlZC4NCj4gPiA+
IGFybTY0IHg0OiBTYW1lIHByb2JsZW0NCj4gPiA+IA0KPiA+ID4gVG8gcnVsZSBvdXQgcHJvYmxl
bXMgaW4gb3VyIENJIHNldHVwIEkgc3Bhd25lZCBzb21lIDcuMCB0ZXN0cywgd2hpY2gNCj4gPiA+
IHdlcmUgZmluZSwgYXQgbGVhc3QgdHdpY2UgaW4gYSByb3cuIFNlZW1zIHNvbWVvbmUgaGFzIHRv
IGxvb2sgaW50byB0aGF0Lg0KPiA+ID4gQXMgSSdtIHJ1bm5pbmcgb3V0IG9mIHRpbWU6IEFueSBy
ZXNvdXJjZXMgYXZhaWxhYmxlPw0KPiA+ID4gDQo+ID4gDQo+ID4gTm90IGhlcmUsIGF0IGxlYXN0
IG5vdCB5ZXQuDQo+IA0KPiBJIHNjaGVkdWxlZCBhIGNvdXBsZSBvZiBvdmVybmlnaHQgdGVzdCBy
dW5zIG9uIC1yYzQuIFRob3NlIHRlc3QgYXJlDQo+IGxvb2tpbmcgT0suIFNvbWV0aGluZyBpbiAt
cmM1IHNlZW1zIHRvIHRyaWdnZXIgdGhhdC4gVGhlIHByb2JsZW0gc2VlbXMNCj4gcWVtdS9rdm0g
c3BlY2lmaWMsIHRlc3QgcnVucyBvbiByZWFsIGhhcmR3YXJlIHdlcmUgT0suDQo+IA0KPiBJIGZv
dW5kIGEgY291cGxlIG9mIHJlY2VudCBkaXNjdXNzaW9ucyBhcm91bmQgVk1YL1NWTSByZWdyZXNz
aW9ucywgc29tZQ0KPiBvZiB0aGVtIHJlbGF0ZWQgdG8gdGhlIGRlbGF5ZWQgaHJ0aW1lciBhcm1p
bmcuIEFzIHdlIGRpc2FibGUgdGhlIGRlbGF5ZWQNCj4gYXJtaW5nIGNvbXBsZXRlbHksIHRoYXQg
c2hvdWxkIG5vdCBiZSBvdXIgcHJvYmxlbS4gTWF5YmUgd2Ugc2hvdWxkIGp1c3QNCj4gd2FpdCBm
b3IgLXJjNz8NCg0KVGhlIGxhc3QgcmVtYWluaW5nIHByb2JsZW0gZm9yIG5vdzoNCg0KMjAyNi0w
Ni0wMlQyMjoxNDoyNCBwcm94eS1wb2xsOiBPSw0KMjAyNi0wNi0wMlQyMjoxNTowNyBbICAxMTYu
MTI5MjUyXSBiY21nZW5ldCBmZDU4MDAwMC5ldGhlcm5ldCBlbmQwOiBORVRERVYgV0FUQ0hET0c6
IENQVTogMjogdHJhbnNtaXQgcXVldWUgNCB0aW1lZCBvdXQgMzcwMCBtcw0KDQpUaGF0IHdhcyB0
YWtlbiBmcm9tIGFuIGV2bCB0ZXN0IG9uIHJwaTQsIHRoZSBzYW1lIGhhcHBlbnMgKHdpdGhvdXQN
CndhdGNoZG9nIHdhcm5pbmcpIG9uIGFybTY0LXFlbXUuIFNlZW1zIHRoZSBzeXN0ZW0gaXMgZGVh
ZCBhZnRlcndhcmRzLg0KDQo=
