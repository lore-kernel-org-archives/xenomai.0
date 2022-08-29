Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2050.outbound.protection.outlook.com [40.107.104.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0D7211A
	for <xenomai@lists.linux.dev>; Mon, 29 Aug 2022 09:11:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OPF+3SzsuCH3mLtp9y8apT/VvIt/a9T2dsRXScJO2BKQijQIUL1yknil3G7w7qh7RPlU1eBDE+KRQlYzOs2OD6Lp/WbPPf9JPz+WzLxGRRXo6a95WnGNbX2nzS9OOh5gtCy8vitysS1YlisOWKZvrzeOwLFmtkpxBub/7Ffzua6PshCZ7Ngti44obiFUITASgtd23CXUEK4gjznOcepkcB+hoysjb+tJVVMBVsplgCRx/wvOB3CYG5qjysFuV9AMKPj8GTeylRGZ4DZlcL+YzHfADdPwxKa2zbmwTRrPrfSr9179E7GEHU+pC1ogITPl0zSPh/RpJEf8Maq/+WCX4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TO1R7PoS8niP31mzt7BHn2U3IAuvvne4t7GvKISva4=;
 b=WVDkwLwio/iT8pR+fMc+EPQ6mxHCIgYBG6GHucBTxPD1hJYuRIh8nW4FjNbEexziXy8PJ7xiS3+x+RcPE5/9RwRoHp70LBq3au2Ur5tl6AZyDn+CuGaYhUKJJP9PMqD9yXV+CYmKss+dGBrpdYOFsFBoklvjqK3enAMMCdMTiTNIMcvlNUz0+gDzc0NL53m7BvDdXfHENi55lE72MjCrWxXinJdS9JjOtbuKPYYx0cZLg/+WsuuC3K8DjYWlbHFJzlfK1iuK5hkW5aBde65iLTuN1Eu1nzbzz0M0u2AnPQLmsX0rDifDyRfVCTyrIRHMS9rKik1rChDKCq/mtq47Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TO1R7PoS8niP31mzt7BHn2U3IAuvvne4t7GvKISva4=;
 b=EqXahdR0HX7khS570ZE4eYjpwtIhxGlJMNRp8Nv3N0zjbXG/PqK1TxIM6IcmymU/B1g8d1ms11K/EEhcxCrjAHkunM/pyjWJYObVArzBwB5vwmEEsRZkiOkTL19vijDZe1u6nhzQ2kV1Fyq/CGez0MsmnpoDrQLzQ8UPPkY1+fuYdqHabEsfmHuuye4ytMAxjYim9BjP2RxEZInLbTqKjqDvh0V8cQdgkvJcsyvQlzxANiUMN55Amz4zDi3Io2XmSh1wsd8dgO7BngrMpXW1P2qQOnge9ZrQLHHnc/RvA5u3IqXWtXeLU68lrrYccd1b57KZmM1jUVanrh3+pI9suQ==
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by AM9PR10MB4006.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 09:11:53 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%6]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 09:11:53 +0000
From: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
To: "jan.kiszka@web.de" <jan.kiszka@web.de>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
CC: "rpm@xenomai.org" <rpm@xenomai.org>
Subject: Re: ipipe-4.19 on arm64: Stack overflow when compiled with gcc 12
Thread-Topic: ipipe-4.19 on arm64: Stack overflow when compiled with gcc 12
Thread-Index: AQHYtgR+LV9jgn3KxU22mQmE60hdg63BY12AgAQ/WgA=
Date: Mon, 29 Aug 2022 09:11:52 +0000
Message-ID: <5248b448f4e35fbe5c192ed0419e39776268f281.camel@siemens.com>
References: <977443ed9083abfe574dcb1aa8582ecf091c2ff1.camel@siemens.com>
	 <a6aa4aa0-fe70-a6fe-35ab-08c9636b59c4@web.de>
In-Reply-To: <a6aa4aa0-fe70-a6fe-35ab-08c9636b59c4@web.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4 (3.44.4-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 036b8f22-041b-4013-dc04-08da899e8378
x-ms-traffictypediagnostic: AM9PR10MB4006:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 r9u0R2Me1OyJ3eAjxj5kB4Vlg4o0/lNtodcqLTjN9j3gc6IwtHyw5H/jbmYmGy776LQcW7PgrzG1Hu0HG+YuAcENOijeFsyieRzr9JQTEM0dyEObkPE4jiCW4X5rhmcK0oxPl8jA1ZLbKw/siPJhQkFeFQesnGrYN8i7y0qurf6Y9II3PP4f3Q48qHVjxM+AHwV3xytYwiwdpM3W0AYQ2ZHw8v3+htabO6xiOBv33rPM5JdK34UuEA0m/iPt6foKQx35lg9Pm/dmn0B+oolH8Ql8DtT5TumwGrFCNC6gIzLZduQ+fzkL86BOmZPUoPTAmYQ539s7G23wGOfVAYOIXk61y19ZgQB/TxScErcZfm85fg/21N7tnYHRwn2Xp70sWa3wFCJnXgPEQ0mzV83ag7kdHmuG89Pu4nKGqRXEJaheKOiUbBX5K5f3+xI9mcwIuRwPx4vvXH44BPhDdRwAhSBKyw9ZV+QCsNupaELFHiKTtav9cU9lRC7loq49B2hoNkFAH8Dl4i2BpME6XQ5PRvk44h4q6cs2ZvLqBzMTYdeOrjNDo+oz35e4dHzkyW1o/dx2bmQRJKdrtaDnhNkiis1fNB7/Gaw9P3Pzo/BpygC/TH3wFF6xWK33J/2YHQtuQifF+3hgOF2exLcwcmpoGqQpkkQahN+AnIUrTEXwFpkL7eGl9Y6nJGZ1rU7vHWKKMqVGdDeC28vXJEQm2abbNq9YZIEAoRB9l7a7JORxdfLC1UELdYAd0TkkQBkeRQs7qBpASvuiAO3cAvSZknNetz1cjoq0xd65QrjjxRkPBFE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(66946007)(76116006)(64756008)(66446008)(91956017)(66556008)(66476007)(53546011)(2906002)(8676002)(8936002)(6506007)(6486002)(41300700001)(966005)(4326008)(5660300002)(2616005)(186003)(83380400001)(86362001)(478600001)(82960400001)(6512007)(38070700005)(110136005)(122000001)(38100700002)(316002)(71200400001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QlQvZEpKa2VQYVg4VFVsSUN3bTVTeklRTTZqNzkvb3dCSUpzUG5aWXJ4RDlQ?=
 =?utf-8?B?TktSWEo5THZONjRBNzlTb0dEWGtpOE1TYVBKclFKVXQ3TjQwUFlTMjlxOHZN?=
 =?utf-8?B?cGpsMDdPb292SmU3d0Q0NEl2OGtBTnZZeVJXSlVjV3l5bUIzb3lDYmpnaGR0?=
 =?utf-8?B?WktrZE9qdjVVTmlWcjBpODNkVWh3bmZ1WWFXcHI5Qy81YU9JMGYvZmtZRzd3?=
 =?utf-8?B?L3ZnbVFIbi9HK0xIV1VEWXN6R1RSTG4xTU0yNGhhV0pDRGcxVFZiM0xhWXZS?=
 =?utf-8?B?K2lGdG52NjJldUhxMW1FRUZZQWZsZXN6eFB3TFdzSUpweDMweStFM3BncnFO?=
 =?utf-8?B?SDd0TmFQSk8xak1tdEJLNU8rdityT2NuTzJlaGREbWo3ZW4yTTZGNzk5UmJy?=
 =?utf-8?B?WmRmV0xVc0VJQzRmMFBZYjJpd0FFQjdoMndjMTBmYzZhN1FaeG55TDhYcDBC?=
 =?utf-8?B?SUI4a1VISWNXRXVTcTlNNm82R3dXNDRlOU1sMlZYNFVSdFJROEQxbTVPSGlw?=
 =?utf-8?B?Z2FZendmSGVMdUF6a3pDallxOFJxTnNrN0JPZ1RYaURNemhCM3AzeS9CVmdC?=
 =?utf-8?B?dC92KzZCMzdZMVNabVV3b3hFeXRwZjJNb2x2UFVpeFY5TVhoVU56TExGVHBz?=
 =?utf-8?B?cjdwbXhjbG1PZWFyTmVlMlYvOC9lQ2VXenpTQ00zQU9wL3hPcExSYUpDWUFQ?=
 =?utf-8?B?b3lrbGtwQ0Y1bSsyMnpENjZXM0dkSDZMb0R5Qmp4WUhjM0dkdlZHbEdrbDNT?=
 =?utf-8?B?RDA5SkpBQ1l3aGZ6NWo2UDRMKzhCOFN2M1NvZGFqdjZOb1Y5Q3UxbThCTjhY?=
 =?utf-8?B?OHNZNWJwNHViWERnWDY0MEI2OGVGNnRUT3NkSXg0QUVhWi9XY3JDakNLSkxm?=
 =?utf-8?B?OGFnWVJleTdIOTBGcG82bUJFZk01QldtQnpxWnVNdFRIRUhnZ3VMMU1aNXZ3?=
 =?utf-8?B?RldERnhIOThodXFRa1lpN2MvNzY5WHF2eEJSOXVKbGQ5dTBlVGpYeFZzcEdO?=
 =?utf-8?B?bTFMSGYvNWdtZlhwU3BFa3V6MGJrdCsvLzZLZnRpNGdHTHBndDl3Znd5YW1R?=
 =?utf-8?B?SlJoUGRSMm9pNTJ4cmJsZ241cy9CcEVYVUh4eHFlNHliSXBFTkUrNHkxZlpq?=
 =?utf-8?B?QjZLblhad2M3QmlINmtmYTlHZXFZREkwUklzcExsNjJKeVVkWkh2NlAzRHNI?=
 =?utf-8?B?SERkUGxqd0NMNUhWSk02aEIxaHlLTTZTZFQ3cFlUVGc5TGRmTG13WCs4R29y?=
 =?utf-8?B?QkMrZ0FOVWRmeWlpbVFnSWlWT3ZCbldqR3diNzdlOWo3TEdXQzRyYjVuNi85?=
 =?utf-8?B?eHAycHpMdktyYXR0N2hLWVpmbncxTUhydUF3VWhuU09RQ3FxaGtyM2ZabmRK?=
 =?utf-8?B?SVZ6NGtQUWxFcWtYMlFMa3BmOXp4ajMxV2J3WTBRaFR3SGNIYitrK2l4NnJ5?=
 =?utf-8?B?VkVtS2ZUS01hcUo3TlVpK3hjNzhaSTJUcllUZWUzNlZpR2Q2S1pLT3IrRCtD?=
 =?utf-8?B?Zkw5ZnhSWURub2sxS2x5RTVmZTQvVENtZC9DdUZzZUorSk9QeVBseWdPYm5j?=
 =?utf-8?B?am5ZS0t6Vk1QRHFUSktNNHdjL0NTSTFabzRPTno2a1pJVFBoYUpOa2JNUGl6?=
 =?utf-8?B?Vy9mdEVoZnBNeXFTbit6UlRuM2JocURSTXhJdUprOEM0NmRPeXcraUVUalR0?=
 =?utf-8?B?UFgvMmgzeENtWitvWkFGMlBXZ3BUeElONG1ETWgwb1kwbGQxUHJmTXA0YWFK?=
 =?utf-8?B?TDhOc3lHRW5HYnBna21tTGs3azFxZ0EzTTFubDVndnAySzRTQzEvSnp1OFhu?=
 =?utf-8?B?dFpqSllsUStmb0ZXRTVQUVJxOHVtVVBNZTlncy9IZXlYaElmVGlNRHl1OWEx?=
 =?utf-8?B?YkgrbVk2VVh6eHJycWtwaDZDWmFGelY5eDEzdVdUb2pkSTVXVVBYbnZGdVpW?=
 =?utf-8?B?QVhKVGd6VVlJWEZzcWlvdHRGaXgydmswcFZ1MGVxd0VjV0dqbHE3TlBUaWpo?=
 =?utf-8?B?U1VSTFE2SWdJdTBxNUFvU0pxOE9GcGN2ZWpPVXZ3L015dnp5Q016elpKeW9F?=
 =?utf-8?B?ZjlmUjYzd01FckszaHFqaUN5NU5tTThLU3JHU2V6aEN3dlkxTXNNSUkvbkNF?=
 =?utf-8?B?VmFTbmEraW5ZV1BlUzBFOE5mOURoekZvdUo2QU9QSnprSTJWS2RZSC9xRUZx?=
 =?utf-8?B?MHJlREJvb3dqd0NmQXM3a29NKzA4R1cvVURrZnRISUo2N2Z2dWlVWE5FRUk4?=
 =?utf-8?B?TTVnUUxOdCsxampSZTVnV1NaWXRnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DFCC7DDC1BAEA046A5D192CFA03E5482@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 036b8f22-041b-4013-dc04-08da899e8378
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2022 09:11:52.9763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5gowpXPMRt8PHLhB3ME/0a58bReA/jQLWNHAAY30YunE1ZSRUCXHD7X7khi8Y+U6+j7PMP5G4gQGNbzGjNfeFRsBvJWEQkAaJdCgz95G/l4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4006

T24gRnJpLCAyMDIyLTA4LTI2IGF0IDE4OjIwICswMjAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAyMi4wOC4yMiAxMDo1MiwgQmV6ZGVrYSwgRmxvcmlhbiB3cm90ZToNCj4gPiBIaSBhbGwsDQo+
ID4gDQo+ID4gd2hlbiB0cnlpbmcgdG8gZmluZCBhIHBsYXRmb3JtL2ltYWdlIHRoYXQgaXMgYWJs
ZSB0byBidWlsZCBhbmQgdGVzdCBhbGwNCj4gPiBvZiBvdXIgWGVub21haSBicmFuY2hlcyBhbmQg
a2VybmVsIGNvbWJpbmF0aW9ucyBmb3IgZHJpdmluZyB0aGUgQ0kNCj4gPiBpbmZyYXN0cnVjdHVy
ZSBJIGhpdCB0aGUgZm9sbG93aW5nIHByb2JsZW06DQo+ID4gDQo+ID4gV2hlbiBjb21waWxpbmcg
aXBpcGUtNC4xOSB1c2luZyBnY2MgMTIgdGhlIGFybTY0IHRlc3Rib2FyZCAoaGlrZXkpDQo+ID4g
Y3Jhc2hlcyB3aXRoIGEga2VybmVsIHBhbmljIGR1ZSB0byBhIHN0YWNrIG92ZXJmbG93Lg0KPiA+
IA0KPiA+IFRoZSBsb2dzIGFyZSBhdmFpbGFibGUgaGVyZToNCj4gPiAoU2VhcmNoaW5nIGZvciAi
S2VybmVsIHBhbmljIiBtaWdodCBoZWxwKQ0KPiA+IA0KPiA+IC0gaHR0cHM6Ly9sYXZhLnhlbm9t
YWkub3JnL3NjaGVkdWxlci9qb2IvNTA2OSAoc3RhYmxlL3YzLjEueCkNCj4gPiAtIGh0dHBzOi8v
bGF2YS54ZW5vbWFpLm9yZy9zY2hlZHVsZXIvam9iLzUwNzIgKHN0YWJsZS92My4yLngpDQo+ID4g
DQo+ID4gSXMgdGhhdCBzb21ldGhpbmcgdGhhdCBzaG91bGQgd29yayAvIHNob3VsZCBiZSBzdXBw
b3J0ZWQgb3Igc2hvdWxkIHdlDQo+ID4gZGVmaW5lIHN1cHBvcnRlZCBjb21waWxlciB2ZXJzaW9u
cyAocGVyIFhlbm9tYWkvS2VybmVsIGNvbWJpbmF0aW9uKSBhcw0KPiA+IHdlbGw/IEkgaG9wZWQg
SSBjb3VsZCBhdm9pZCBhZGRpbmcgZXZlbiBtb3JlIGNvbXBsZXhpdHkgaW50byB0aGUgQ0kNCj4g
PiBidWlsZC90ZXN0IG1hdHJpeC4NCj4gPiANCj4gPiBXYWl0aW5nIGZvciB5b3VyIGNvbW1lbnRz
Li4uDQo+ID4gDQo+IA0KPiBBbHJlYWR5IGNoZWNrZWQgaWYgc29tZXRoaW5nIGhhcHBlbmVkIGlu
IDQuMTkgb3Igc29tZSBzbGlnaHRseSBuZXdlciBMVFMNCj4ga2VybmVsIHJlbGF0ZWQgdG8gImdj
YyAxMiIgdGhhdCB3ZSBqdXN0IGRpZCBub3QgcGljayB1cCB3aXRoIHRoZSBJLXBpcGUNCj4gYnJh
bmNoZXMgc28gZmFyPw0KDQpJIGRpZCBhIHZlcnkgc2hvcnQgaW52ZXN0aWdhdGlvbi4gTW9zdCBv
ZiBnY2MgMTIgcmVsYXRlZCBzdHVmZiB3YXMNCnNpbGVuY2luZyBuZXcgd2FybmluZ3MuIEVzcGVj
aWFsbHkgaW4gdGhlIGFyZWEgb2YgYXJyYXkgYm91bmRhcnkNCmNoZWNrcy4NCg0KVGhlIGdjYyBj
aGFuZ2Vsb2cgWzFdIG1lbnRpb25zIGEgbmV3IGZlYXR1cmUgY2FsbGVkIFNoYWRvd0NhbGxTdGFj
aw0Kd2hpY2ggY2FuIGJlIHVzZWQgb24gQUFyY2g2NCAodGhlIG9ubHkgYXJjaCB0aGUgcHJvYmxl
bSBzZWVtcw0KcmVwcm9kdWNpYmxlKSBvbmx5LiBNYWluIHVzZXIgb2YgdGhhdCBuZXcgZmVhdHVy
ZSBpcyB0aGUgTGludXgga2VybmVsLiANCkl0IHNlZW1zIExpbnV4ID49IDUuOCBtaWdodCBlbmFi
bGUgdGhhdCBmZWF0dXJlIGlmIGF2YWlsYWJsZS4gQXMgb2xkZXINCmlwaXBlIGtlcm5lbHMgYXJl
IGFmZmVjdGVkIGFzIHdlbGwsIEkgZ3Vlc3MgaXQncyBub3QgdGhlIHNvdXJjZSBvZiBvdXINCnBy
b2JsZW0uDQoNCkhhdmUgeW91IGNoZWNrZWQgdGhlIGxvZ3MgbWVudGlvbmVkIGFib3ZlPyBTZWVt
cyB3ZSBoYXZlIGEgbG9vcCBhcm91bmQNCmhhbmRsZV9hcmNoX2lycV9waXBlbGluZWQuDQoNCkZs
b3JpYW4NCg0KWzFdIGh0dHBzOi8vZ2NjLmdudS5vcmcvZ2NjLTEyL2NoYW5nZXMuaHRtbA0KDQoN
Cj4gDQo+IEphbg0KDQo=
