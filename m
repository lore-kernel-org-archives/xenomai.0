Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2055.outbound.protection.outlook.com [40.107.21.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC427C
	for <xenomai@lists.linux.dev>; Mon,  5 Dec 2022 21:04:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LV/hM10XLIymQeIkEouqp4LKJ0a3zGOnimqdbtq15japwQrpNj3sSGzm5ThGcklWVQrxYIDkLH+8ikoZb7kcYPBSruhBBRKlfRAGqPiIE1TxSioVUQwiec7wge37QFp6NiGXi2M1rKl95fgYzG2ZJpTQA+O4HTwt8HHFYnghkIHlI6aOwku+c+iYQ0/q51C/yKmyGwkSCHG239g0W5GzGrIYvVAB2uO+TsHXjE/05AQq1A2cL7d28qnjCrXbd/dgvuIYZUyYQTpF7nZ9LmSsmOLMUistwOWcwDWj3pEb9YZ5AkEsO6rHtx+2+LekGGTjaQlCv5jppx3AO3PADjCVdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v22ubkzLf5GhcsqKysyniJXbgDkx8SmEWnqiS4Xl6Aw=;
 b=fvna87TMAed9H88viijP9UJ3vojlvTtqO0El0pHBQAkZfAUfGhpWBaSry9g5thAnnpw+1rMzwuVnniMYKDUbmWukhkp/XHEovBZ2ja5xt5uYUfMc15pNQNUHOH+Ejm9lnEw9qNK7S6YM+LtakLXsndycwQBPMpGF9z6OnAUmkhkGxveW7epRKGra6IcqUooZ4ITtZx2WyP+8Xa56xnKvzaDj3mD2NI1PpbqxnVhgnV87ctKGs+E7v95wcdjbma7JZ5RqYZJ2hEp0TBU+V7dS6ftO6ZN7HTOu5dBMRuDIew1zbt8vILGZrN/Eg3Tbg6mj7A09jUrr1OyMEFGTGEuzUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v22ubkzLf5GhcsqKysyniJXbgDkx8SmEWnqiS4Xl6Aw=;
 b=kBrod3ohMcuYcl9mR6UEM9t4IRQ+QCdnahda3pu9AxHYHpvYe4hLmASOpgseRWqrixOpnIeTq0BKL5G1yv4tMJn/WOBcUyXP/04d2Au7hq+lT60TFFr1v4ydyN7FeisJP+pAjNEc8y6XYG/CTOb5Dj1XvW+vjBw8k5A2cGR+j2YLR3+aBiq1sj5RqFXqAA9oUXpeA9K71zBvh9/63+SA32briZcGk5jE9RDgbyNuYwLIui0akwIm7rPtwC2RpPWfDdHbFGhe4lUs/YB4FHxA5Ckj7Ftg2tXlXD+MAcRAepApTNuBuJU42iI6GpJx6wKfDZ3hYIU2R9p5MeSkcOz+uw==
Received: from GV2PR10MB6067.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:af::8)
 by PR3PR10MB4047.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 21:04:40 +0000
Received: from GV2PR10MB6067.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2805:9acb:c8c4:ea7b]) by GV2PR10MB6067.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2805:9acb:c8c4:ea7b%4]) with mapi id 15.20.5880.013; Mon, 5 Dec 2022
 21:04:40 +0000
From: "Schaffner, Tobias" <tobias.schaffner@siemens.com>
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>,
	"xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>
Subject: Re: [PATCH v2 0/3] switchtest: test different migration types
Thread-Topic: [PATCH v2 0/3] switchtest: test different migration types
Thread-Index: AQHZCL079bbAOM0IOU+FrIPpiF8q5a5fjaeAgAA7PoA=
Date: Mon, 5 Dec 2022 21:04:40 +0000
Message-ID: <43d9368a-a5a5-b195-cefa-0707df949841@siemens.com>
References: <20221205152104.3555474-1-tobias.schaffner@siemens.com>
 <e5ec7bdd80c33bfd98cb9251ca70f392cb9afdd7.camel@siemens.com>
In-Reply-To: <e5ec7bdd80c33bfd98cb9251ca70f392cb9afdd7.camel@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR10MB6067:EE_|PR3PR10MB4047:EE_
x-ms-office365-filtering-correlation-id: 86a88a9e-608d-48fd-aece-08dad7045332
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 aRTliJZRycJtvmO5p4WTJutfLWWw3F0Hyr2X4wXs3hPNX7V44VOv2saAwQ9MFFwYmCnml1dZ6eJ6djFUNLfqrEEHEBGRb/lY6+o3caXXBfYWMi6QL5VmMUdrOAcEkEyCROrWvlXGNn5dzxBGZnVKOaattB2Z5llD4Sse87ZacV47CYOVWKGjld4BJBnI5skzYVdTvNgscsFfnWkbvKcbxTKqJNqE5OfhQUZyQR2L0WfPSxcxUnuIKOz9TMiEM+m9BDeZHJSsER90dFQ6kM8GjAlLS0NLeIidJBc7QA78vv61UTdprwM2dTRTXCpPd+d5+ttDFwxMVZoKNAb49OdWT+UDDwsIpM3QGCtUobVeLS96bwrng4wCCUgiHrsXDIMqfVtc0+q3qTabHwRu4DiddLOqokb11c+Rce7vgjutXbJWWILY8/d0d1ysmKjp5hZlaBzVRnTJZOSpYBP7kz3+CKxGIOLcgpLr2h95psWWy5X1hzYUPtjIWy2TtcbUboH39WF/GuXc7MhRpNfHEn0X202HLVZ/Nj4w+/6U1dFXk+8u7vaPYfHcSlzYzHzytD4sO+mR2P2TQbCYEj+/262Az+csdTIzUw3aI8L23hDeF4xaIQ2E4711E6ryX9zqQrxSZnifgPNrg346r4ld+FRTAymEbAPk3An0KD1uwfl+LduS2o+AuFHIgJACw8O3PPu1/akTWkKqzvGwhyBi4H58swJOCJ90PiugrDu6IpES/ks9FI9lWKGwktXly1JIKKwR
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6067.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(396003)(366004)(346002)(451199015)(38070700005)(26005)(36756003)(86362001)(31696002)(71200400001)(6486002)(6506007)(53546011)(478600001)(6512007)(107886003)(4326008)(41300700001)(5660300002)(8936002)(8676002)(66446008)(316002)(110136005)(2906002)(64756008)(66946007)(66556008)(91956017)(66476007)(76116006)(83380400001)(38100700002)(186003)(122000001)(2616005)(82960400001)(31686004)(21314003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a3Vwc2I3YkV4aEJRbmNJTTFaSG5tYURxcnZSTjAzWG5PZnFab2l3dG9PK005?=
 =?utf-8?B?OW5vWlBCeVNqbXRMTmJ5TVIxQkhQbkJObUZuUk15c0E5aHBkaVhsREppTEJ0?=
 =?utf-8?B?empRL3NMdnp1SWhPWFcwOWNMQXdMMnVLVnBwK0I4Y3VTbmt4dktnaGMyQzhZ?=
 =?utf-8?B?elgrMXQ0VUdUbFlFaHhpOHRVQ1c3UGpUaFRScXpMeEw4ZFFpdG1NbGg3SDZ1?=
 =?utf-8?B?c3pKRjUxSTJVeUtJMW44S0xPN0p2SU13OWlXWHBoZ3hiWno4dFZsNjNaYTU5?=
 =?utf-8?B?NEhMVExWQ3RoM216ckx3Wm5VdG9VNDdRaC8vYzZ1bnhCSWkwSFROcHdHSVVG?=
 =?utf-8?B?bDBBb29UemtDd3hTcnBTOUZUV0c3WmV2OVhjQTEwa2EvdGEwM0lZQTZmSkxy?=
 =?utf-8?B?Nk1FOVl4aURwMXZwdGxPMTdiRlpCbStwcXExZDk3eFBaMFhjNFozRFp6bTNL?=
 =?utf-8?B?Um5laFFoSG5TRzU1VnV1cFVHMTV3djRMZnloR1B6eGIvdWd5Y3U3bEprYzJU?=
 =?utf-8?B?N1F4NmxFQmZPTVFxRE5WdEt5d2pFb3BXczQ0Z1JSZGhjL0VKS2FWN211S2s5?=
 =?utf-8?B?bU1HdVpXajVRdXdwYTBDTE40WjBDcFl2ZWdKVlRkODRRTUVXcUc0Q2dRTDRR?=
 =?utf-8?B?MHpFeFpCVDNFdzFwejJiU3VRZEp4K0g3cmJVQmZtTm44K2NjMWpwN2t1eUFo?=
 =?utf-8?B?ZUQ0TmxEckVyYzExNWNJSEVzOVJQTzJJWTFveU1yRjFHaXM1bmN4MmN4bXdM?=
 =?utf-8?B?QWwyQllHdlB3cG1lczREb1RmbTg0ekdlYXlIVFl1WXZPdU1yS1VXc1duWmZ0?=
 =?utf-8?B?VktLcU82S3AydVNneFNDanlWQThuVjFGVnZ6YnlsUGNlN0ErT2QxZGVCOW1y?=
 =?utf-8?B?eVhqYXVwcHRpa1BqYUFyOWhlQnNzVTRjMjBadVlMYmt5dXMyWUZGYU1KSDRV?=
 =?utf-8?B?b3NmOHFsQnY4Y3FtT01ZUjlNNHhlUHlSYmp4WWtiWkhXdThGOHBmeUxmbG1D?=
 =?utf-8?B?dzA4ZDBoWnpQNC9jOGRUeVl5aHF4WE8yWFhiM0I4TFpGNTFMM3dPcDdHYk84?=
 =?utf-8?B?TkdncUJRN0p2SG9zR05DR2tFc2gyOUpGM0JVdm84Wkt5eEFBVk02UERkWjFl?=
 =?utf-8?B?Mkh4UFFoUzdzMVgybVIwb0hTR1I1RVc2QTdPMVJldy9odjhGb1A5elY3OXlU?=
 =?utf-8?B?eEJTa2x2Mkdqb0ZQOEVGenhlKzI2elJOQnowNnNLdE55QlE1WFZzUG82TXpV?=
 =?utf-8?B?bVVSckNqdmVXS2xNbGg5VWNmTzNvY2gwN0JnZTBBbEZTbm5zQmtBTHpQNWQv?=
 =?utf-8?B?ZGlWNHZ6SU5NdWpSY0kyWlNleTYvN09Qdng2T1hoUUpyL210Vnk4eFhiQU0y?=
 =?utf-8?B?OWNxRmIxZ1FLZ0w3eGlOMnJFNjRlcEdjRVlRVDB5SUJhNUxQLy9BTlFtU3d5?=
 =?utf-8?B?cGRtVzlmSEM3Rk9DajlpWDljU2ZTc1crTlMxZ0pJRjcrKzdWeVJBWGVNSjAw?=
 =?utf-8?B?NGhLaU9MRThBVW9xT3JqWVY4eWZyZ1hzY1YwWWpPdkhwSjdGM28wYVozeW1N?=
 =?utf-8?B?bUtWY2JSa1ViWVFHZ3ZsdHBJd3VmSjlxTGtxUGFHSzZjL1BONjNrbmNIcWlG?=
 =?utf-8?B?NXZFRmdvUXNteEpDdDBnQlh5RDJNdHFXeFpoeURFRWx6ajlienB5VnFLamFV?=
 =?utf-8?B?RHhRSWFHaEpXd2Z0Ky9ScnFqaHVnc01Dd09KSm0xdDF2ZDZ2UGZXbXhoZ1hJ?=
 =?utf-8?B?aXN5NjlXcmhISUxOS3kwMHk2VERjN2tEdGZKblJVU0dqK3NWQ2toM3llaUt0?=
 =?utf-8?B?eEV5KytOeG5OUDYxL0lzQWV5a3lZeUNhQ0NidDA3d241MVg3U2dwTHpCYnp5?=
 =?utf-8?B?QjFzb0k4YXhoSmhHVTRYYVgxOU5URjFIcUhJRXlrekxQVjEzTTAzM0NyYzNP?=
 =?utf-8?B?SFFUN2ljUDExZmM1RUdKWlRkSEVXU08zVVlQM1dBUllScmUwMTZMejJnT29S?=
 =?utf-8?B?Vi9ZaG1PRnFtdjBGcFQ5aHVKUTh5YWFub0FOOFkwM2pyRW5EdVlFNFJZMDdF?=
 =?utf-8?B?UGx0Q2dXTDJ5ekJpNU9IWUpwYnBZZ3BMTXJDRnN4em5UVmFnQ1BnbS9DV0Yz?=
 =?utf-8?B?cDdvRFJva0l0SmRCVlNScWJaK0YvSEFTRzdLbC9zZldxYlFwdjg3VXFVZGJH?=
 =?utf-8?B?eWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <763F6177C3DB13489DB829D5BFBB3E3E@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a88a9e-608d-48fd-aece-08dad7045332
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2022 21:04:40.1861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7wvg0HtHBQe/M32R7eS7m75dKuEAIXR75eR8EvP5JOSuSScOGx1yXg8SLFTkhrHRm51SGXtm56zEp3dK5AkRdaLv60v6KHpl8cw70+bgoe0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4047

T24gMDUuMTIuMjIgMTg6MzIsIEJlemRla2EsIEZsb3JpYW4gKFQgQ0VEIFNFUy1ERSkgd3JvdGU6
DQo+IE9uIE1vbiwgMjAyMi0xMi0wNSBhdCAxNjoyMSArMDEwMCwgVC4gU2NoYWZmbmVyIHdyb3Rl
Og0KPj4gRnJvbTogVG9iaWFzIFNjaGFmZm5lciA8dG9iaWFzLnNjaGFmZm5lckBzaWVtZW5zLmNv
bT4NCj4+DQo+PiBTd2l0Y2h0ZXN0IG9ubHkgdGVzdGVkIGludGVuZGVkIHN3aXRjaGVzIGJldHdl
ZW4gcHJpbWFyeSBhbmQgc2Vjb25kYXJ5DQo+PiBtb2RlIGluIHVzZXJsYW5kLg0KPj4NCj4+IExl
dCB0aGUgcnR1byB0aHJlYWQgYWxzbyB0ZXN0IGZhdWx0IGJhc2VkIG1pZ3JhdGlvbnMgYW5kIG1p
Z3JhdGlvbnMgdGhhdA0KPj4gb2NjdXIgd2hpbGUgaW4ga2VybmVsIG1vZGUuDQo+Pg0KPj4gVGhp
cyBwYXRjaCBzZXJpZXMgd2lsbCBhbHNvIHRlc3QgdGhlIGJ1ZyB0aGF0IHdhcyBmaXhlZCBpbg0K
Pj4gODI5ZDRkMzNjYjdhYTNlZTQ4NWFkNTZkYTZhYzBjM2IwY2U1ZGJlNQ0KPj4NCj4+IENoYW5n
ZXMgc2luY2UgdjE6DQo+PiAtIFNxdWFzaCBwYXRjaGVzIDEgYW5kIDIgYXN3ZWxsIGFzIDMgYW5k
IDQNCj4+IC0gQ2FsbCB0aGUgY29ycmVjdCBydHN3aXRjaF90b194eHggZnVuY3Rpb24gYWZ0ZXIg
bW9kZSBzd2l0Y2ggaW4gdGhlDQo+PiAgICBzd2l0Y2h0ZXN0IGRyaXZlcg0KPj4gLSBPbmx5IHN3
aXRjaCB0byBzZWNvbmRhcnkgbW9kZSBieSB1c2luZyBhIGxpbnV4IHN5c2NhbGwgb3IgYnkgYSBj
YWxsIHRvDQo+PiAgICBjb2JhbHRfdGhyZWFkX3JlbGF4KCkNCj4gDQo+IFdoeSBoYXMgdGhlIHBh
cnQgd2l0aCBhIGZhdWx0aW5nIHN5c2NhbGwgYmVlbiByZW1vdmVkPw0KPiANCj4gSnVzdCBpbiBj
YXNlIG15IHByZXZpb3VzIGNvbW1lbnQgd2FzIG1pc3JlYWQ6IE15IGlkZWEgd2FzIG5vdCB0byBy
ZW1vdmUNCj4gaXQgYnV0IHRvIG1vdmUgaXQgaW50byB0aGUgc3dpdGNodGVzdCB1YXBpLCBzaW1p
bGFyIHRvIHRoZSBzd2l0Y2hfbW9kZQ0KPiBmbGFnIHRoYXQgeW91IGhhdmUgaW50cm9kdWNlZCBp
biBwYXRjaCAzLzMuDQo+IA0KPiBTb21ldGhpbmcgbGlrZSAidHJpZ2dlcl9mYXVsdCIgaW4gYWRk
aXRpb24gdG8gc3dpdGNoX21vZGUgc2hvdWxkIGRvIGl0Lg0KPiBUaGF0IHdvdWxkIGRlY291cGxl
IHRoZSBzd2l0Y2h0ZXN0IHV0aWxpdHkgZnJvbSB5MjAzOCBzdHVmZi4NCkkgYWRkZWQgYW4gYWRk
aXRpb25hbCBzd2l0Y2h0ZXN0IHN5c2NhbGwgd2hpY2ggdHJpZ2dlcnMgYSBmYXVsdCBpbiB0aGUg
DQp3YXkgeW91IHN1Z2dlc3RlZC4gQWdhaW4gdGhpcyBkb2VzIG5vdCBhbHdheXMgdHJpZ2dlciBh
IG1pZ3JhdGlvbiBhbmQgDQp0aGUgYXNzZXJ0aW9uIGdldHMgcmFpc2VkLg0KDQpJIHdvdWxkIGxp
a2UgdG8gZXhhbWluZSB0aGF0IGZ1cnRoZXIgdGlsbCBJIGZ1bGx5IHVuZGVyc3RhbmQgd2hhdCBp
cyANCmdvaW5nIG9uIGhlcmUuIEkgd291bGQgc3VnZ2VzdCB0byBjcmVhdGUgYSBuZXcgcGF0Y2gg
c2VyaWVzIGZvciB0aGF0IHRvIA0KYWxsb3cgdGhpcyBwYXRjaCBzZXJpZXMgd2l0aCB0aGUgRlBV
IHRlc3QgZm9yIEphbnMgZml4IHRvIGdldCBtZXJnZWQgDQpzb29uLiBXaGF0IGRvIHlvdSB0aGlu
az8NCg0KPj4NCj4+IFRvYmlhcyBTY2hhZmZuZXIgKDMpOg0KPj4gICAgc3dpdGNodGVzdDogc3Bs
aXQgdGhlIHNldF9tb2RlIG1ldGhvZA0KPj4gICAgc3dpdGNodGVzdDogdGVzdCBtdWx0aXBsZSBz
ZWNvbmRhcnkgc3dpdGNoIGNhc2VzDQo+PiAgICBzd2l0Y2h0ZXN0OiB0ZXN0IG1vZGUgc3dpdGNo
ZSB3aGlsZSBpbiBrZXJuZWwgbW9kZQ0KPj4NCj4+ICAgaW5jbHVkZS9ydGRtL3VhcGkvdGVzdGlu
Zy5oICAgICAgICAgfCAgMTAgKysNCj4+ICAga2VybmVsL2RyaXZlcnMvdGVzdGluZy9zd2l0Y2h0
ZXN0LmMgfCAgIDggKysNCj4+ICAgdGVzdHN1aXRlL3N3aXRjaHRlc3Qvc3dpdGNodGVzdC5jICAg
fCAxNDIgKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLQ0KPj4gICAzIGZpbGVzIGNoYW5nZWQs
IDEyNiBpbnNlcnRpb25zKCspLCAzNCBkZWxldGlvbnMoLSkNCj4+DQo+IA0K
