Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED747F
	for <xenomai@lists.linux.dev>; Tue,  2 Aug 2022 17:08:52 +0000 (UTC)
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 9D30E2000E
	for <xenomai@lists.linux.dev>; Tue,  2 Aug 2022 17:08:50 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 554AF780443
	for <xenomai@xenomai.org>; Tue,  2 Aug 2022 17:08:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Haukb9feR6Cruv8wMdRHpAUV0KKoqqb3GmEjl4ngX52sEClfVaGKh9CTSp0LUbQYTFJdcYkSSgE4C0TTeaJdP44Q5LEFQhm+qoHgarAD8OfLFkz87wc3vUm6NNQjgN+PCivSeIDEXGlY3Oohwdwgszpn3HYDgf2NbjUWgVa+pUBOsda+QpG5r2OeowKcViOgvi57WQqsE5ZPZY+ENa033U/EHNHF2wjtTMyaUKq/hxU3iwdvTYhcXrzPyYU74AAp6Oyi5co+kKD2hM+raB3B8nbl5BHUNaX3Aux8T1+tD2vlVkaDq1ed+4cNMMFkqmDBR7gYGU4Br70Q7FMxLFXHEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndXBSl82yeRFdDfdulqOAUiYJUJos3IL9bJJ5F1qsGU=;
 b=ofWym2be7enCsicloT3etLf9kj72pTjvw+cWB1Px5/GoUL15b9P6DYvVIEB66OJR9mtpcqT+r172aITYVFMCExC0spcKTTRH3OkwumsnBxIFGSyY8El1D2c5OdbcYiURVdQCLZ/gK1FyU7BCeyLEb0UXS5Eqm84f6+LEWhr7bzpVevOt3ogWSAHaRbrdUcf2d7yN0xtDDwbEux1Ia6VbC3F6l7Nb+NcNtu8O+kkXLva9X2UEF2DzqMOShu2tRnS9Z0Q3S29Zp7ES5EWZcMCbOq2HyXKxTKv2AWrtEON+UT3Af6uCeK0JSKvAI0ntkJj3QDyPjJDmAUu/kRhiGGt3MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndXBSl82yeRFdDfdulqOAUiYJUJos3IL9bJJ5F1qsGU=;
 b=fkc+fuTPPreiOoomg6iNBQ6FmtcDb/kPn7Ru2jwA3UKxcP5DgujelSmD6Mo4LQEpSb0BpCFGkFRhr1kUYk8FH1fflhNzBAK+cJoRADcYQeyTVW2PLr4GnJyZxI2yv+0IlOU8XqFisCFuBZmhb3WhtC1aLsFzNufUdhyygU7VKsDfXfvUyZVkJ4p+w51OfUIQN/89miaTgZunIJmH0lvCHLxVaZqbXdshUAPqoE7sKHMBqeIRhlJvPy1q1u0HB57tr7xZDnmUMfkWnbLUxSO/blt3iDBkliaVSas7YhWD/75HDeVotASecxekKLC4Rla0xFpe9Vgsq9oaxaq3QWXD3w==
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by PAXPR10MB4816.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.10; Tue, 2 Aug
 2022 17:08:48 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 17:08:48 +0000
From: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
To: "ksmola51@gmail.com" <ksmola51@gmail.com>, "xenomai@xenomai.org"
	<xenomai@xenomai.org>
Subject: Re: [PATCH 1/1] drivers/net/stack/ipv4/udp/udp.c: added 32-bit compat
Thread-Topic: [PATCH 1/1] drivers/net/stack/ipv4/udp/udp.c: added 32-bit
 compat
Thread-Index: AQHYpo+LrIsVWE3eXE2kID+4yx1Omq2b1OkAgAADBoA=
Date: Tue, 2 Aug 2022 17:08:48 +0000
Message-ID: <1f8b7ac6585181ec27549a443abcc67973b129b8.camel@siemens.com>
References: <1659458811-3014-1-git-send-email-ksmola51@gmail.com>
	 <55a4975055367ceadd17446d311b0147f0621939.camel@siemens.com>
In-Reply-To: <55a4975055367ceadd17446d311b0147f0621939.camel@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.3 (3.44.3-1.fc36) 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd0deace-d581-4046-6d8e-08da74a9aa4c
x-ms-traffictypediagnostic: PAXPR10MB4816:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 vrCE7LT2DJ01S4+0376WBthIUwzhl0vKKupIkwH3ZumoYpwc0C5ylPZH3DMgr7TPz8fRRN6MzU3nHXMVI50NGVSw786AID7jg5WLjy/3R2l0OFulWp4m5aH6qPdzH2YV9edIb0BfXn87suORFD0seipsB4xK0WOvAapGMB9SGdt16EAhoLXNoJcP7N/UtxNhLBYYZI735W46Ah98DDFw1okgz2EDVG3nCa6T2/3NP8iHelgPh5m4HOYDsPEFw7pX+oMndltWXL8HE7dJXhUA2YrtGRe+ijTQ21qpkvqbDSSDapH6Z1Aws9p2mwfRejVv87hxESpRKC+PpDVsUPcDVTMG3o79y49OcuhZJ0sW88jzbX0iLWlom1RysgRPNallpXvD/VKaiAV30wQQ7fFxuW0Bwe7qk2cKUXkPPGdAdFmv+DWnoJh5/3RNfApX04eI5Gamtk0hZrDxXw/yp47wxElJjN3IthMb/rYr7gmIY7M9/2BulfK6pKRENQMW9YmEn4/oQ6jx9m7a0XREBQyrOgaN2EVH6dao2I9W/8H9m4lFnfjr92bnrmAjRYHW6f5MP5VGfY20H+4TDoY8DCfmxViQxPy7Qt0c51eMC75XU6jRUtOGztAjICMh6OFNwMq+Fa5zzYBZquJeKkxu1DqXJJKlLD/cOL9D/RA70j0vh69BDsSBJYbvITT11u39OK6yaftnXg9DKp0qXLdP/CLJCH5JN5i6+xSMcWKgKAuo7sbEpEJ9SQlXwt1p7Rdfv+/OQjQyhLPvHc12JSfJytxgGgtGWLGpln/p+6Ld3dT5yRr/KftT4I7SX6QlVxq7H2/L6W4js/nmnReTjMmeKOzaLv2fs8RSJ2X/6enSSekNpXwSOaMqUKIlNdZcIiYNCSof
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(38100700002)(6512007)(41300700001)(86362001)(6506007)(316002)(110136005)(71200400001)(6486002)(966005)(478600001)(122000001)(38070700005)(2616005)(186003)(82960400001)(83380400001)(4744005)(36756003)(2906002)(5660300002)(8936002)(91956017)(64756008)(66946007)(66556008)(76116006)(66476007)(8676002)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QzFUUlVuWFRFbEVoZ1NKNzZZSVhpcGNYUElNSnZJTnA0NnVlcGpMWnB1akVN?=
 =?utf-8?B?TjFqUGxpNGNOUXlCWGM1RndBazBWYktpcFJNTVlyU1RvZHhGY3gzNHhVcyts?=
 =?utf-8?B?QUl6dUg4K0pqdDdnQTBWV09FeDg5R2EwV2YvS3VqbVlUaGZXSkhSZG5XSzRV?=
 =?utf-8?B?UVhCM1VWQzRKbDJNWDNDYjVBL0NYQm5FLzZiRlczUGFxdXFRQ0pkakdiY3hE?=
 =?utf-8?B?RFV6R1l0aVZOV2k0bk01cEIxYUFtOVRwT2lKSUtOaGxNQm90a1BlODJtZmRh?=
 =?utf-8?B?Q0NTWEoxTmZoWHRUZWprQ0RTbXRkVnpJTmhwUzlFK2xkeUsxUWVHL3o5bGla?=
 =?utf-8?B?d3JTbWQydGFGblZ5TGZRY09yS0lQWHI0SkkxWnBWQkJpMGpkT1FlbDVsQkpt?=
 =?utf-8?B?ZzRZSDRkSitmTUdET04yckZnTVhmdkpyM1EzTHV5bnJYYlkxWXpNQ1dzZ1ls?=
 =?utf-8?B?OUYzU1lmV0pQRmVIWnFoZVhIanozZlU5clJBbnNXayswV1kyS0Q2TG8yWWxZ?=
 =?utf-8?B?OGdWdGthQmZBL3N2eXZTN1JPNE1UWVYzeU0rTXNyT3pnRmxGQmhqNnlKZzRB?=
 =?utf-8?B?TXdLWmt1TnJCdStjUnNMeWcwRklRZDU1elFzejVGRHZ3LzV1aUxNUnV4MXRC?=
 =?utf-8?B?RFYwSnZtam5GM2NYd3NveTErcDR2NzZqQ0NaUUszQTQybE9HK0lRb0NYdFNj?=
 =?utf-8?B?Wnd5K2JZRjlOMzB2ZHVOVHpxbHhkd0oyd0lqSWlYUDNSZlFFSUZCWThqc2ZJ?=
 =?utf-8?B?T3U5UDZpUlo4aHNadU1yQUJTNk1UVjRnYVo3R3FkVm1kWUNzM0VucGdneDRF?=
 =?utf-8?B?dE5YNXNkd1Z0Q0dGZm1UY3VBVTBnNU1ydDVaT3kvQ253eGxSdzhKcHBsUUJz?=
 =?utf-8?B?ZjJzdWRiZWJjK0xKcFZoaWp1eWNlME1TbWNwcUp0Sll6ZUgyR1YyRXRVYjNo?=
 =?utf-8?B?RjBoeGJ5NjhqdnhEWTdnbFRnWHg1K2FXQy9Tc0JGRVh1c3NtWkhwazd3b2x3?=
 =?utf-8?B?eXlpaVBOK2QwaWZVVW9KWDQvdHB1NzlZemZrVDZ6NGgxVS9NUzFranM0RVBJ?=
 =?utf-8?B?RW1wcWlnU0xaV2ZxdisycmxzUEp0UzFkVmFHOExvb0FoQ0RZc2JEVlUxaktr?=
 =?utf-8?B?ZkcvR3hudVhyV0NKS3ZqMVdOdU4xUUpLOFA0VFBxRzZYWVNuSHVGN0FyQXlY?=
 =?utf-8?B?UWREVVZScWgzcnRvdTBEMEw4a1A5N2JHdURMdURBNm11UDNBMDg0dExKbG9z?=
 =?utf-8?B?OGtOYzNSQS9VZEg0S1FuZmE2cW1JWjNpaGVENTdqUU9SdnlROGkyUVlxU3lj?=
 =?utf-8?B?MmRDYVZYeE9VNFNrSXRnSjczQ1BMVDVmMVl1U3ZQMTR0cjIwdEVtNXp0TzEz?=
 =?utf-8?B?a01DTGpOd1FQZ1lpT3gxY3VkQ3VaeFZJVmUvQWMwYWpxNGI1VUxmRzhNWExj?=
 =?utf-8?B?ZmhBV2phMExWLy9zb0I3a2pUZFJsTUtDZDhZdWdjaUZTMnZyV3c2V1JXOHdx?=
 =?utf-8?B?cmFlTmhTa3U3UGxRcG1KeVZwYVE3QXBhcEt2T3gvdkt4c3cwbU9TNEJCZ1Iz?=
 =?utf-8?B?ZFlURVBWMFl0dFI0blJCa3JjZmZDUUZqLzZWUlRUN29wNW94SmtrV3daOUJh?=
 =?utf-8?B?d1RyQVVrblhuTG14dG42ejhtQVJZd2ZEaU5DQjM3VjhKT0dsV0FteDZQajBl?=
 =?utf-8?B?OVB2blpCcW14M3FTZ3Z6S0FMOU4zZzgxam9MMTV5NFNsSkNZaGoyRm5raXc1?=
 =?utf-8?B?Rk9SUzBIb2c1RlRTY1kzakcxMTlYakE4MGlFc3Vua1VGVzNHSHRUOVNxOEJC?=
 =?utf-8?B?aWhsL1A0d04weUlEQUd6dnZQM2ZBcmFnemFlZy94bzg1Qk5aUW91VmErVUdJ?=
 =?utf-8?B?SmRNVnNLUzIvSkdUVitjR3RmWVRlSWd2eTRTcnhDdnV3ZW9vdFc2QzVXVUUy?=
 =?utf-8?B?eEJMZmx1cHBWZm5zK0szNUYvenFLL2xvdXBaOHk0YThmOXNkSE4zRXowWXJx?=
 =?utf-8?B?Q0twZmtCT1BSTTFVcHd4Unk5QUdNWDR0cGdSN2xxUHhrWm5QY2R2NzNadjc0?=
 =?utf-8?B?QlhVaDJiZlpvN0FWOFhNWExhb245WlkxQms4RUNjZ0I3TW9xSlRUQWNUcFE4?=
 =?utf-8?B?dHhJK2lSY08yeHQ1M2RDeUlwdTlaQmJWaXFFOHdUenNtT1JlMkJ5MGgzWGN5?=
 =?utf-8?B?SllhOXlCV0xBK25jK05JbVMyZENVNWNTdm9ETUh0aUN5eDVGU2d5TURhOFFR?=
 =?utf-8?B?U0YxNjdGMUJmWHQ2MWE4elp5Q1hRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0928D33B6DA2744B5F0A730667F4B2B@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0deace-d581-4046-6d8e-08da74a9aa4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2022 17:08:48.1620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tEv0niJMP688Yr53poVxvjMJRaF8Wo+mzya9Q6pZnsTN6F13yNkbdWbbiM9HsGowm+ypiRU/gioZPFFuNQKuqy0X9aCXgzJJt2oW17E6p3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4816
Received-SPF: pass (spool4: domain of siemens.com designates 40.107.20.65 as permitted sender) client-ip=40.107.20.65; envelope-from=florian.bezdeka@siemens.com; helo=EUR05-DB8-obe.outbound.protection.outlook.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=fkc+fuTP;
	spf=pass (spool.mail.gandi.net: domain of florian.bezdeka@siemens.com designates 40.107.20.65 as permitted sender) smtp.mailfrom=florian.bezdeka@siemens.com;
	arc=pass ("microsoft.com:s=arcselector9901:i=1");
	dmarc=pass (policy=none) header.from=siemens.com

T24gVHVlLCAyMDIyLTA4LTAyIGF0IDE2OjU3ICswMDAwLCBCZXpkZWthLCBGbG9yaWFuIHdyb3Rl
Og0KPiBIaSBLb25zdGFudGluLA0KPiANCj4gT24gVHVlLCAyMDIyLTA4LTAyIGF0IDA5OjQ2IC0w
NzAwLCBLb25zdGFudGluIFNtb2xhIHdyb3RlOg0KPiA+IFRoZSBydG5ldCBpbnRlcmZhY2Ugd2Fz
IGxhY2tpbmcgMzItYml0IHN1cHBvcnQgZm9yIGJpbmQgYW5kIGNvbm5lY3QgaW9jdGwuDQo+ID4g
DQo+ID4gU2lnbmVkLW9mZi1ieTogS29uc3RhbnRpbiBTbW9sYSA8a3Ntb2xhNTFAZ21haWwuY29t
Pg0KPiA+IC0tLQ0KPiANCj4gaGF2ZSB5b3UgcnVuIGNoZWNrcGF0Y2ggYWdhaW5zdCB0aGlzIHBh
dGNoPyBHZXR0aW5nIGEgbG90IG9mIHdhcm5pbmdzDQo+IGhlcmUuLi4gDQo+IA0KDQpPbmUgbW9y
ZSB0aGluZzoNCg0KSSB3YXMgbG9va2luZyBpbnRvIHRoZSBzbW9rZXkgbmV0X3VkcCB0ZXN0IHRv
ZGF5IGFzIHdlbGwuIEl0IGlzIHRoZQ0KbGFzdCBmYWlsaW5nIHRlc3QgZm9yIG15IHkyMDM4IHF1
ZXVlIFsxXS4gRXZlbiB3aXRoIHRoaXMgcGF0Y2ggYXBwbGllZA0KaXQgc3RpbGwgZmFpbHMgYXQg
dGhlIElPQ19SVF9JRklORk8gaW9jdGwuDQoNCkkgaGF2ZSBub3Qgc3BlbnQgbXVjaCB0aW1lIG9u
IHRoYXQgaXNzdWUgc28gZmFyLiBNb3JlIGludmVzdGlnYXRpb25zDQp3aWxsIGZvbGxvdy4gU28g
ZmFyIEkgb25seSBub3RpY2VkIHRoYXQgcnRkbV9mZF9nZXQoKSByZXR1cm5zIGFuIGVycm9yLA0K
dW5jbGVhciB3aHkuDQoNClBsZWFzZSBub3RlIHRoYXQgd2UgaGF2ZSBhbiBvcGVuIHRlc3QgaXNz
dWUgaGVyZSBhcyB3ZWxsOg0KaHR0cHM6Ly9naXRsYWIuY29tL1hlbm9tYWkveGVub21haS1oYWNr
ZXItc3BhY2UvLS9pc3N1ZXMvMjENCg0KSSBmZWVsIHRoZXJlIGlzIHN0aWxsIG1vcmUgd29yayBu
ZWNlc3NhcnkgdG8gZnVsbHkgcmVwYWlyIHJ0ZG0gaW4NCmNvbXBhdCBtb2RlLg0KDQpbMV0gaHR0
cHM6Ly9naXRsYWIuY29tL1hlbm9tYWkveGVub21haS1oYWNrZXItc3BhY2UvLS90cmVlL2Zsb3Jp
YW4veTIwMzgNCg0KPiBCZXN0IHJlZ2FyZHMsDQo+IEZsb3JpYW4NCg0K
