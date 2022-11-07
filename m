Received: from DEU01-BE0-obe.outbound.protection.outlook.com (mail-be0deu01on2078.outbound.protection.outlook.com [40.107.127.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40553D51D
	for <xenomai@lists.linux.dev>; Mon,  7 Nov 2022 15:09:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8G4ESoYgPKnW2bErbHLI5d5CxwlhoyPQQK+ybAJIr2SdUY7DJ6EJsEoGsU+egvzGsnt4XTt6EEquUFU0ayl3vGBQRYKIk3pb3IHAMbVZsd/GZn1TBMBqQYAkugYnUfS6yMT1GrIXonfXZzTeKax0OKN2jDmLKVzWEa+qRiShA1t7xKHH7Pi9BIZzHMp9pkfqmY3Lst9QQINYDscCqApX63veWiwGEQAFITZNCiczHOD/ECtvvwCK5awuq/chbPOvK9lXtsldvR3x7R3Fe/AjMwSXch3NMFNvD2v8iplnDMRYkZyfwDYx2NrfQf3rNAemn0+jTcCEY51qpypQRC7kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ux+IX3TTJ5cIaW8pWZpvNLyxljLanoJXFb0Dovdvk3U=;
 b=RL1f9pQ31xZ0cOc92PXsM0MIRZdrPzIBgLn+J9w2dNXY8vICQh+30Zzn4oe8QKiJ2pLj6ntOOXGE7Haba2Kc3g5BE1RPElEsLZ5+FkixmE+Cz8uycCD55CHkHL4bTbylLg2JgJ9bS8kEFJANkvQvnysVpYBT2YsZeXYdVfhkiox3p8kaE7Kc4Mr/JUYXd2eUo5gS3qVgNSOKLDFvcetdBRy5grXr7A5VmJ0fDFr6zCl2xAY/EViWgBPgewGhYG+Jmln9EcF52QUYenSTnaEhVXASBesyZ+ajS4BqcqnRS3SZX/7diarg5IN78K4znwDdJPnAYYQhW/3ZYTo1vLIJLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zwickroell.com; dmarc=pass action=none
 header.from=zwickroell.com; dkim=pass header.d=zwickroell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=zwickroell.onmicrosoft.com; s=selector2-zwickroell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ux+IX3TTJ5cIaW8pWZpvNLyxljLanoJXFb0Dovdvk3U=;
 b=nsUtlN3GvXOxDEThhkuYBDc1W3ipf2AE+sauznOskPH46oJGAKw1F0nap8MQHcmY6blxpLCHGFz37ReQznLLUxOEXe/+WfFIJkmkMwDiG6P7W+9ypfGf76nf76/3rG+k1Aoh9OXv2OwoA4+/od1wG7qBdMIpuYspw/p+CWyXxNU=
Received: from FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:63::8) by
 BEZP281MB3000.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:24::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.25; Mon, 7 Nov 2022 15:09:33 +0000
Received: from FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM
 ([fe80::b3f6:e832:1424:434c]) by FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM
 ([fe80::b3f6:e832:1424:434c%4]) with mapi id 15.20.5791.025; Mon, 7 Nov 2022
 15:09:33 +0000
From: "Heber, Stefan" <Stefan.Heber@zwickroell.com>
To: "Zhang, Qiang1" <qiang1.zhang@intel.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
CC: "Chen, Hongzhan" <hongzhan.chen@intel.com>, "Wang, Rick Y"
	<rick.y.wang@intel.com>, "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: Memory corruptions upon strcpy and similar when being interrupted
 by scheduler
Thread-Topic: Memory corruptions upon strcpy and similar when being
 interrupted by scheduler
Thread-Index:
 AdjUuPBUbK+UhP87T6Sf3hDOZQOijgTLBYqAAA1CmiAACKQcgAA/AGAgAV0zStAACIauoAAAw4AAAOySfgAABi7zgAADOIVQAAPeFyA=
Date: Mon, 7 Nov 2022 15:09:33 +0000
Message-ID:
 <FR2P281MB26545ED41E498275501328E9FC3C9@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
References:
 <FR2P281MB265487EA098F01EFC0F77CB8FC569@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
 <ca3f971c-87e1-b7b4-262c-bf80483ef9fd@siemens.com>
 <PH0PR11MB5880908DA18819B93D4DAEB9DA319@PH0PR11MB5880.namprd11.prod.outlook.com>
 <4a08b7af-039d-99ef-ec9e-4749cb47379d@siemens.com>
 <FR2P281MB265412CDC9321A60BA8B87BCFC309@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
 <PH0PR11MB58807DD17256817B3BFC54A3DA399@PH0PR11MB5880.namprd11.prod.outlook.com>
 <FR2P281MB265432E604FFEB38A3FB7AB9FC399@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
 <b49df726-0eb8-1f65-f584-37eba99aae77@siemens.com>
 <151047c2-a1cf-db66-d4d6-61d0df96976f@siemens.com>
 <b16e958f-bd57-5b18-c1fd-e2e67cc8f589@siemens.com>
 <PH0PR11MB5880A19D008C286A96BC9495DA3C9@PH0PR11MB5880.namprd11.prod.outlook.com>
In-Reply-To:
 <PH0PR11MB5880A19D008C286A96BC9495DA3C9@PH0PR11MB5880.namprd11.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zwickroell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR2P281MB2654:EE_|BEZP281MB3000:EE_
x-ms-office365-filtering-correlation-id: f32df3d4-8b10-4126-8179-08dac0d213cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 rjHWrPnMq8l4yULcq29T2/2PTSs5f5hvBDnova+a8MThsA2VMh4w70KXScHKy7BtednNCABazFvuEby1+Da9rDbwSEyixmNNWpkMSqPOL8HXnVzngV2pIDgEWjyfiEG3pvPPsK+0Z6xxcpySV6L1BPcYRalDdxdqO4zZlrxRSNJMcAkmQHuCjT42e9tZ64prUgrF4gdyz+s8JyL89TOd/sYB9ZgBAqWOW5GtATbpm/wYMMh7weN6BYJy6NW46DWdmxk5ISIk4iV/SDktQ60s8AYOK6RoUeccBYfxesVEYrxET3nKoH4jKFPpNKL9QsGPsdDG0GpxkNn7WFt/vfDAvxzUY/ruj0npJqk5LHk8EtYC2ZUXk94RFBJ/UTKhm/o8nHKBZ9H8KTOWgTzWyEg2z25skVjawW5RvCvt88wOWTn1RZGfa9CIvcANe9GWOHYKKdgfkfjTiKHE0cnnlCs5hiDyKtqAnevV6XDBujd7LEI6MtkxrVqncgBKvNLSUGxfGxFXQgZuQ7dymvxRwqh/v3/+dltfTZYhKT99e2/JTL8Wmh5jZkHD3RgtIHXtsgFZdiINbqDavp2GH8h/H2W9dEMMg7IQIVzGHuv50YtHT4P4Pg11nrDyGt4wtwC1KsMC93NtxE2oxeEVxqpTTGHo4eTLV+OEL26dtYpcaEDFyF7utdE/23r0GLtJJJn0msF0bpfZmE67rtYJH3v2dSMjAv9Mb2jqXJekNje/q7Dj+1FltDRkfseUzD30pSoY13GeuWwL0+MpsDwjmkBmDSEgkw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(346002)(396003)(136003)(39850400004)(451199015)(52536014)(71200400001)(8936002)(5660300002)(478600001)(122000001)(76116006)(316002)(64756008)(7696005)(26005)(38100700002)(2906002)(9686003)(6506007)(66476007)(53546011)(55016003)(41300700001)(54906003)(38070700005)(86362001)(66946007)(33656002)(110136005)(66556008)(66446008)(8676002)(186003)(4326008)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dURJVWJOb01CcnBmbytkam9FU28xbG1NMDY3cWJoOEtweitRZy92bGs4dXM3?=
 =?utf-8?B?b2x6djhiK083TXVUL1BqUWRsZzlqclE4dzJ4SHQ2WUpabDVrVkplWEYzd3Ev?=
 =?utf-8?B?Mm0wcTBsdVo1bmhML3NBTlgzYlNyVWlDSEFBdTJPQjNGeXdsdHFlRWYxRVFN?=
 =?utf-8?B?aXJDY2Vwd2pVZnpMTVVSb2dlbmhsN0NWcUZic2dzaUQ0anZEd2ZkMlF3eEJZ?=
 =?utf-8?B?U3VOeEdzTTJEcEFqRUNDc0hEbnBrSTVCM2R2Q2tlN3hIdVI5cEhGc3prcjBD?=
 =?utf-8?B?ck1zNzgxdDU0WitiOHl2UnVrckJiU0U3VXhhdFFMMmlXWkhFb2pUNVpkWDU2?=
 =?utf-8?B?eit4d2c1dDhXZlVLYnhEOHI1dHBzQjRzNEVmYkt6ek44TUZDZkJHRFhoMmhI?=
 =?utf-8?B?QWJqVDVaTG5FcElZWitxdjhPcTErOEV0YU5lTHdTaWFWUVdDSHc5Q05IOVVY?=
 =?utf-8?B?ZCsyWW5NMFN3TXpTMzY2SHd6VDV4K2hLT0RwUEpSc1BLaitIWlJSS3pUbGhO?=
 =?utf-8?B?U00va1k4Mm1mL1J6NklMd2dtMkNLM0VGVThtY0dFTUNFZVdxNFRndnBZUVRY?=
 =?utf-8?B?QVNKSWJWYkU0VXFucGtmendvTEJERTdRRzBtRlpVdUhSTDc1OWpJa1N3SmNG?=
 =?utf-8?B?L2hubHVUVEpualhUOWozK2htdFd1dVdneVU0VkJJVHNaaTRibndCK2JtZEhF?=
 =?utf-8?B?a2t0eUVmYWlwcGkxQVJTaUovclc1SE13a1U0U2RHTEZUY0xPS0djNnhFY0dB?=
 =?utf-8?B?dURqaEk3eFFKNUxmSWxHRWR0VDJDNlJGZkl4S1AzMmRnWGVSVEZvRzFRS0FI?=
 =?utf-8?B?Z3RSOGc4RXJyYVVnQ1lPNzUweE9DZytlZUFhc1FpOVZ1bytBY24yZmJ1YzM1?=
 =?utf-8?B?QjBHdTloQ3JJbDN0UTluZlRlUVVwY1krTHRYTEk0UVg2cXYzRUc2ZUQxU1Vi?=
 =?utf-8?B?Q3c2RmNpY21JTjdCdXJBN1UrYzNyaVk3TXoxekhpKzN1QjhsREltd09BdXBW?=
 =?utf-8?B?MXQ0WWlxOU50Y25pSmJCeno1VkNsdlZLMTUrQm5IaTdoTlpoWW9qQ3VLb0Va?=
 =?utf-8?B?aVhWTzd6cUVZQmZmZFhodUhxWUJEUVY5Z1k2eG5EcWxYaTZ6bzNLTjlidnZs?=
 =?utf-8?B?R3NFc3hORE8wbkJxSWxKRnRWT01vbWp0VFhtbmJRMkVLV2VvR3FzVVM4ZE1l?=
 =?utf-8?B?RHZobTRDYW0zdVFER21FT3pVbHJ3RU5oNHJzNUx4anB4NFhLSUMraXlEb1My?=
 =?utf-8?B?ak5MOW0vWHBNR0N3emt0QnYwSDRaTXY5T2tkQ2IxZlc5T3FuaFFnTE1BTlor?=
 =?utf-8?B?RnJBd2F5a2RVMVIreHAxWS9zRHdZdmNydUlkM0lqendTVUlxVWZrUzhvVjhM?=
 =?utf-8?B?dDNzUzkrd3Bzb2pyMUNES2Vndm50UWlyb1F5MDJHNG8yT0tUbUVCcE13emZR?=
 =?utf-8?B?UHo4aS9kaUp6NkV5UGEvTUlWTXhrZDhIcEd1ZW1tVThkb203ZjZkVGJSZEhD?=
 =?utf-8?B?UG51dXVBK1h5dEg4eGxTNktpenlPMmVSN1NvOTVGemdWVXkyOWhZYjJpVmRt?=
 =?utf-8?B?SHAxc0hqK2pVaFlRRFdUcXFwMmFmcGZRcnFJUlEzNTZzQ0tnTFd5YXZmSTBh?=
 =?utf-8?B?dzM2bmZPdm1DVXlvUzJQWWRPYzBaSGkyakEzQTBZTEtKV1Y4b3VQZVV6RXEv?=
 =?utf-8?B?c01rU3JjejdKRS9Ud0IxMTdpQ2RSUys0QjJKY1g1UHlGNTBqalJtWlFSR29s?=
 =?utf-8?B?ZjRiWEdaRyt3TkN0ZFcrODhEOEtQT2N4YXJ0NUt3WnFpQllqNy9SZEwvck43?=
 =?utf-8?B?UVZQQk1ldW85dkc4TE8wNE9WQlhDaFN2VHgxZ0lCSHpvUExpNEFWQTRPWE9T?=
 =?utf-8?B?YlF4NVo5Qy9ySFdHZVhyV051Nk1vaGFxcnFUOURVQ3RuNFk2NG1EaXo1c0g3?=
 =?utf-8?B?WVJNbWxyRzB1WS83VkJGRmJtVkplajc3bGQ0SW1jU0pOUFl5Y2ZXL1pxVlcw?=
 =?utf-8?B?Sjd4R1M3eGJ4aUY3M08veWl6ZWdWb1pVQUlLdUZnTXpXSGZtQWp3TVV6d1NJ?=
 =?utf-8?B?SkFlZlFLdE40QzFvQjloMmExdzk0OG01Q0ZEOHdISDgrazh5S3NKOWVZOEJQ?=
 =?utf-8?Q?eF38idY0kN5wcZAJJlFpmLgbZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: zwickroell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f32df3d4-8b10-4126-8179-08dac0d213cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 15:09:33.3934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 538edf66-8fb7-4bad-8608-a521ab580ca0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mx9ymZ0Dqw3Uu5e4jzM7hYiiY57LdxAjxS+pztHIDFjbULYoqWlR88HqWAT2CN8AvJ0MEN9nBM3on+poRA4egFA0D1lxVORvANWutjauzKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB3000

SGVsbG8gSmFuIGFuZCBacWlhbmcsDQoNCldlIHRlc3RlZCBKYW4ncyBwYXRjaCBvbiBvdXIgc3lz
dGVtIChMaW51eC1rZXJuZWwgNS40LCBYZW5vbWFpIHYzLjIpLg0KDQpUaGlzIHBhdGNoIG1ha2Vz
IHRoZSBwcm9ibGVtIGRpc2FwcGVhciB3aXRoIG91ciB0aW55IHRlc3RhcHAgb24gb3VyIHN5c3Rl
bSwgdG9vLg0KQW5kIHRoZSBwcm9ibGVtIGRpc2FwcGVhcnMgYWxzbyB3aXRoIHRoZSBzeXN0ZW10
ZXN0IGZyb20gb3VyIGh1Z2UgYXBwbGljYXRpb24uDQoNClN0ZWZhbg0KDQotLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KRnJvbTogWmhhbmcsIFFpYW5nMSA8cWlhbmcxLnpoYW5nQGludGVsLmNv
bT4gDQpTZW50OiBNb25kYXksIE5vdmVtYmVyIDcsIDIwMjIgMjoxOCBQTQ0KVG86IEtpc3prYSwg
SmFuIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPjsgSGViZXIsIFN0ZWZhbiA8U3RlZmFuLkhlYmVy
QHp3aWNrcm9lbGwuY29tPg0KQ2M6IENoZW4sIEhvbmd6aGFuIDxob25nemhhbi5jaGVuQGludGVs
LmNvbT47IFdhbmcsIFJpY2sgWSA8cmljay55LndhbmdAaW50ZWwuY29tPjsgeGVub21haUBsaXN0
cy5saW51eC5kZXYNClN1YmplY3Q6IFJFOiBNZW1vcnkgY29ycnVwdGlvbnMgdXBvbiBzdHJjcHkg
YW5kIHNpbWlsYXIgd2hlbiBiZWluZyBpbnRlcnJ1cHRlZCBieSBzY2hlZHVsZXINCg0KT24gMDcu
MTEuMjIgMDk6NDIsIEphbiBLaXN6a2Egd3JvdGU6DQo+IE9uIDAyLjExLjIyIDE2OjQ4LCBKYW4g
S2lzemthIHdyb3RlOg0KPj4gT24gMDIuMTEuMjIgMTY6MzQsIEhlYmVyLCBTdGVmYW4gd3JvdGU6
DQo+Pj4gSGVsbG8gWnFpYW5nLA0KPj4+DQo+Pj4gV2UgdGVzdGVkIHlvdXIgMDAwMS1JUElQRS1p
Z25vcmUteGVub21haS1GUFUtb3BlcmF0aW9uLnBhdGNoIG9uIG91ciBzeXN0ZW0gKExpbnV4LWtl
cm5lbCA1LjQsIFhlbm9tYWkgdjMuMikuDQo+Pj4NCj4+PiBUaGlzIHBhdGNoIG1ha2VzIHRoZSBw
cm9ibGVtIGRpc2FwcGVhciB3aXRoIG91ciB0aW55IHRlc3RhcHAgb24gb3VyIHN5c3RlbSwgdG9v
Lg0KPj4+IEJ1dCB3aXRoIGEgc3lzdGVtdGVzdCBmcm9tIG91ciBodWdlIGFwcGxpY2F0aW9uICg+
MjUwayBMb0MsID4yMCB0aHJlYWRzKSB0aGUgcHJvYmxlbSBzdGlsbCBleGlzdHMuDQo+Pg0KPj4g
VGhlIHBhdGNoIGlzIHN1cmVseSBubyBzb2x1dGlvbiwgYnV0IGl0IHBvaW50cyB0byB0aGUgZGly
ZWN0aW9uIHdoZXJlIHdlDQo+PiBuZWVkIHRvIGRpZy4gVW5mb3J0dW5hdGVseSwgSSBzdGlsbCBk
aWRuJ3QgZmluZCBlbm91Z2ggY29udGlndW91cyB0aW1lDQo+PiB0byBzdGFydCB0aGF0Lg0KPg0K
PiBJJ20gc3RhcnRpbmcgdG8gdW5kZXJzdGFuZCB0aGUgcHJvYmxlbToNCj4NCj4gU29tZXdoZXJl
IGJldHdlZW4gNC4xOSBhbmQgNS40LCB0aGUga2VybmVsIG1vdmVkIEZQVSByZXN0b3JhdGlvbiBm
b3INCj4gaW5jb21pbmcgdGhyZWFkcyBmcm9tIHRoZSB0aHJlYWQtc3dpdGNoaW5nIGNvZGUgdG8N
Cj4gcHJlcGFyZV9leGl0X3RvX3VzZXJtb2RlKCkuIEhvd2V2ZXIsIHRoaXMgcGF0aCBpcyBub3Qg
dGFrZW4gd2hlbg0KPiBzd2l0Y2hpbmcgaW4gYSBwcmltYXJ5IHRocmVhZCwgYXQgbGVhc3Qgd2hl
biBpdCdzIGNvbWluZyBmcm9tIHNlY29uZGFyeS4NCj4gTmVlZCB0byBsb29rIGZvciB0aGUgcmln
aHQgd2F5IHRvIGFjY291bnQgZm9yIHRoaXMgbm93Lg0KPg0KDQo+QSBmaXJzdCwgc28gZmFyIHBy
b21pc2luZyBmaXggYXR0ZW1wdDoNCg0KSGkgSmFuDQoNClRoYW5rcyBmb3IgdGhlIHBhdGNoLCAg
SSBoYXZlIHRlc3RlZCBpdCBiYXNlIG9uIFhlbm9tYWkgdjMuMiBhbmQgbGludXgtdjUuNA0KVGhp
cyBwcm9ibGVtIGRpc2FwcGVhci4gIEkgZXhwZWN0IFN0ZWZhbidzIHRlc3QgcmVzdWx0Lg0KDQpU
aGFua3MNClpxaWFuZw0KDQo+DQo+DQo+ZGlmZiAtLWdpdCBhL2tlcm5lbC9jb2JhbHQvYXJjaC94
ODYvaXBpcGUvdGhyZWFkLmMgYi9rZXJuZWwvY29iYWx0L2FyY2gveDg2L2lwaXBlL3RocmVhZC5j
DQo+aW5kZXggN2UyODkwM2E0Mi4uOGJkMmNkOTEyYiAxMDA2NDQNCj4tLS0gYS9rZXJuZWwvY29i
YWx0L2FyY2gveDg2L2lwaXBlL3RocmVhZC5jDQo+KysrIGIva2VybmVsL2NvYmFsdC9hcmNoL3g4
Ni9pcGlwZS90aHJlYWQuYw0KPkBAIC00NDMsMTUgKzQ0MywxOSBAQCB2b2lkIHhuYXJjaF9zd2l0
Y2hfZnB1KHN0cnVjdCB4bnRocmVhZCAqZnJvbSwgc3RydWN0IHhudGhyZWFkICp0bykNCj4gew0K
PiAgICAgICBzdHJ1Y3QgeG5hcmNodGNiICpjb25zdCB0b190Y2IgPSB4bnRocmVhZF9hcmNodGNi
KHRvKTsNCj4NCj4tICAgICAgaWYgKCF0Y2JfdXNlZF9rZnB1KHRvX3RjYikpDQo+LSAgICAgICAg
ICAgICAgcmV0dXJuOw0KPi0NCj4tICAgICAgY29weV9rZXJuZWxfdG9fZnByZWdzKCZ0b190Y2It
PmtmcHUtPnN0YXRlKTsNCj4rICAgICAgaWYgKHRjYl91c2VkX2tmcHUodG9fdGNiKSkgew0KPisg
ICAgICAgICAgICAgIGNvcHlfa2VybmVsX3RvX2ZwcmVncygmdG9fdGNiLT5rZnB1LT5zdGF0ZSk7
DQo+ICNpZiBMSU5VWF9WRVJTSU9OX0NPREUgPj0gS0VSTkVMX1ZFUlNJT04oNSwyLDApDQo+LSAg
ICAgIC8qIHJlZG8gdGhlIGludmFsaWRhdGlvbiBkb25lIGJ5IGtlcm5lbF9mcHVfYmVnaW4gKi8N
Cj4tICAgICAgX19jcHVfaW52YWxpZGF0ZV9mcHJlZ3Nfc3RhdGUoKTsNCj4rICAgICAgICAgICAg
ICAvKiByZWRvIHRoZSBpbnZhbGlkYXRpb24gZG9uZSBieSBrZXJuZWxfZnB1X2JlZ2luICovDQo+
KyAgICAgICAgICAgICAgX19jcHVfaW52YWxpZGF0ZV9mcHJlZ3Nfc3RhdGUoKTsNCj4rI2VuZGlm
DQo+KyAgICAgICAgICAgICAga2VybmVsX2ZwdV9kaXNhYmxlKCk7DQo+KyAgICAgIH0NCj4rI2lm
IExJTlVYX1ZFUlNJT05fQ09ERSA+PSBLRVJORUxfVkVSU0lPTig1LDIsMCkNCj4rICAgICAgZWxz
ZSBpZiAoeG50aHJlYWRfdGVzdF9zdGF0ZSh0bywgWE5ST09UIHwgWE5VU0VSKSA9PSBYTlVTRVIg
JiYNCj4rICAgICAgICAgICAgICAgdGVzdF90aHJlYWRfZmxhZyhUSUZfTkVFRF9GUFVfTE9BRCkp
DQo+KyAgICAgICAgICAgICAgc3dpdGNoX2ZwdV9yZXR1cm4oKTsNCj4jZW5kaWYNCj4tICAgICAg
a2VybmVsX2ZwdV9kaXNhYmxlKCk7DQo+IH0NCj4gI2VuZGlmIC8qICEgSVBJUEVfWDg2X0ZQVV9F
QUdFUiAqLw0KPg0KPg0KPkphbg0KPg0KPi0tDQo+U2llbWVucyBBRywgVGVjaG5vbG9neQ0KPkNv
bXBldGVuY2UgQ2VudGVyIEVtYmVkZGVkIExpbnV4DQoNCg==
