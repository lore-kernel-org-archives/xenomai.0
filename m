Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2073.outbound.protection.outlook.com [40.107.241.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53CBA4F
	for <xenomai@lists.linux.dev>; Mon, 21 Nov 2022 09:51:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZrQoZYxRvLYbiQd4EaVpbSMtdaJY+CzD3wLSMHaF/nzZTxeXL9PtqPmdo0tr0tPXdl7uqehwCuSNBgbfmKmcVhpxvGEY3WfqGi/jqYJtbITZIq2mZi8ntuI2mouUuOASyROw2DKChB0X4q4qgYW6IPcjQc7gPEulRlfrjgBNY7Bo9hYW++cLU+cAV1jNE7Tey3Ze7AQV3imb7QCLHvFm2b8G30z89nepr+Xa9t1sPMLiAohzIw4q8H7pVsFZtfbRAluHGzCqvmcHCMsDgNBYatrHdJbCJInFI6+0raS15GF9JaDlx2vrk7yN4g6qbGd0nZnlsXqdWuZf/C9phPr6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OS32UDkN3ZBqOrdGGEkrVWoWSoCRS0/kOOvBj8jIyiA=;
 b=J5Hqaq128Tl8lxiIAIN0QTsxHq3Pj0H8eJsHqbPjoe+du34QEGBebP8XiMwv8to/ubNG+SIZ5xhaXo7U3dRpPXzGRsjJzzFGt+rBRQlASDfkgRRR+aaM8w0mqNttiPqA4PyFRrtT2qNDFJC80pwnbUsm2eL1BlU3Rfxf5Ieiw0oqm835oQq1f41AAOAGwbaGaqlzR9c/wwCPQ3iS+LFHpWoIFwS+Ntj08fcwpeU9Qhcv49/C7UBzKFPofn8KU8I3OQY9fhXiZoU+l+DAJBEe/HpGT0y+9cuUWnZcc1jOpPkNlptkmBhkegaTax0ntjvl3YgT3nxVZhrCIg734LgMPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OS32UDkN3ZBqOrdGGEkrVWoWSoCRS0/kOOvBj8jIyiA=;
 b=HMtqGAQbtaUe6Xjv8p2xbUQ6nmdNZOoOmPGxK4paQnVqa2oT4+sDaCEPCNzArNc73wDWyXdsSei2ZDjVWT0vF3r6r5ZwhDkjbApreTsBYOkYFd9uojxaxOZdYbDGqkbBO8ffYkluCdDCjjBkF5IUC9iXOjyRBBXPY8MxRcFWY5yd9zm43mB/49+6eljtsDPpKhoRiHoqQABvHEa1AacJ75tzMAErPdk3nwlogk3U6G0dsF0LPjyFKE5tEgCKjMer4IUuxL+k0dsVOqlSmIFspDyUzTG7k5/nIHonxtgGysmjoiCL89uy4GS6IoIO3tQ0Poz+lC3PzHuyk011kMblfQ==
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB8PR10MB3260.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:119::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Mon, 21 Nov
 2022 09:51:33 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::13fb:15f4:a3c5:4ec3]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::13fb:15f4:a3c5:4ec3%4]) with mapi id 15.20.5834.009; Mon, 21 Nov 2022
 09:51:33 +0000
From: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: Re: [RFC][stable 3.0.x] lib: Switch to pthread_mutexattr_setrobust
Thread-Topic: [RFC][stable 3.0.x] lib: Switch to pthread_mutexattr_setrobust
Thread-Index: AQHY+2Rajz/txkhIKUqcuwfyZKtDTa5JHTMAgAAJrwA=
Date: Mon, 21 Nov 2022 09:51:33 +0000
Message-ID: <0afbc24d39c0f299cbdce15ec33c05e2592d0459.camel@siemens.com>
References: <20221118154220.869584-1-florian.bezdeka@siemens.com>
	 <ea34c26a-e3e5-609e-5af5-2ad3a45e9d96@siemens.com>
In-Reply-To: <ea34c26a-e3e5-609e-5af5-2ad3a45e9d96@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB5712:EE_|DB8PR10MB3260:EE_
x-ms-office365-filtering-correlation-id: 3753aeb7-3463-41ea-7790-08dacba5f90d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 F672xfnnb9WuTBKcDGgd6niI31mPYLazAW+vpZqtYyLFdKBcBHTALS0oD4ZTrqLOzgL+JUD56tVpystAoTlc34Ji3wrrw+fz64YMXsYzT3u2tkPD/AN1wXZOMVo+aUeybuFF/5QRGS/mFE9z7SiPNF3LznDk9Q3qJUOCZgm8hJX7kRkDTLuGzKyJwxDNUogvh2RL0tmwQvqjsU+wdkeJ1vWfco72d+VHGFl+nlJeKz45t72ZgeG3g0Sv3R22Qi9Q4qNRaZzUZuqO9LLObCRSvegr7Yg+xB0x8x6i2S4fl+2nALfAzAvtvGwYO8q32N9ekaPC/vKBrmu9tZwb1UobpvGas7ktriktWYIbp0aOhiOnnRncMst8KmeWbWhIQTuloXAUSrLKAJ6cdL7KZnPmkHskLOnQ1yWGFlpR6KRuB/48bv1neKTJqMX9sqTsLjFvxSNpYsXwYiRI+i5lVawDRA0fb9eTnpzWE3ikTdFQBJHvDikr/kkGif/p1oINHf2i3+wzOM4Rc7Upr0AgYsZdKkvEOvFHqcHkhiHy9Apa+fKVrjCCBGN1fd3LDhrHSp1pVQi5qDAc3P2TExIvyf/eCnowWsRqXRfHafL7WmZYztcBufmdEYqPQA69QjedkMYX295vqDdqCvvTmbcQRrLCoLTSWtwxTELgk5JkWvINSlEHH2vXUmqQDigOem7o8yShJtTT/iGyu92fgR3QBrecdg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(451199015)(316002)(86362001)(41300700001)(71200400001)(36756003)(4001150100001)(2616005)(186003)(5660300002)(2906002)(83380400001)(8936002)(64756008)(110136005)(53546011)(6506007)(66476007)(66556008)(38070700005)(66946007)(82960400001)(6512007)(76116006)(66446008)(38100700002)(122000001)(91956017)(478600001)(6486002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NTAzSVhrWUZGcmNyVG9MRVVZeVRiSDZWaG4xc0cwMjJQdUZmSUh4d29TYzJs?=
 =?utf-8?B?UHdiU1J5UG1XYVZBekhRZFdJQ0hia3ArOVV0OHZka1ZUWVZSNnVaRkNSVTdr?=
 =?utf-8?B?SGpPYjlNc2JSQ0RCdFZaVU0vRWUrRzQyU2doT1libVpMZUhUSm0ybzJKMG94?=
 =?utf-8?B?ZDBLblh2Y01yeUgyUHJ2RjFDQnFlVjVMRy8xZWNia2tqYmo0dkhNQ2FxZHMr?=
 =?utf-8?B?S1M3T1JDcXVJejVPb241ZFVVMlY1RDNmbTdlMUE0NDU2M05mZGFwOFVBb0x3?=
 =?utf-8?B?RkpEandMcytjczZiWVppaUVlQUY0OTd2REk5MFdqTVRIaVJpRHplVzh5M0c5?=
 =?utf-8?B?dy9kanhqK1R2d1lOTzNnckdML3puRzRiNyt2VHkzcUg4MnZRR0I0ZXdlQVdk?=
 =?utf-8?B?MVl3Z0xwUmlTNy8vaEVOcjJXZ2R0K1ZXdkZtWGUxUTVqU1NGWGUwdTRxUFpY?=
 =?utf-8?B?OVd3MFRDZWFmL3poWVMvclM1U2VVME5vK2V1TUNqbS9LUndhYTZYK0FYNHRK?=
 =?utf-8?B?NWEzVDhIdFJ5V0VJYmtoTlRBUlNwNXBmVmUxRTZOSytmR1dZRlhubkRxeVFX?=
 =?utf-8?B?Z29rVHhVT1ZEbmRrMWJUNlFSWGVPRTV0MWtDZS9uM0pyeVhjRTBONlRDT0l5?=
 =?utf-8?B?WGRzTVhHeVNZeFhsTHNHcndvRFkxMGFPWnRMTlZkZGRDM3pUU3licHVEeWlY?=
 =?utf-8?B?c3hIcXhzVGwrMGlSeWxwZFhHVlE3NldRS1lIRWJtS3ZBaGYwQ3cyUXVBYktD?=
 =?utf-8?B?YjVETzVpR1FxajNxQ2N3VEU4bXpUSVg5RVdMUVlmZDNCMWJWUDk2eC9SK0JH?=
 =?utf-8?B?anRaUDBhMEJqdFlXaHZYaUIrVHVLTklyZ29RZTE3TjhEWUlRMTJEQVFwUWpX?=
 =?utf-8?B?QzN3TjFVdXNwSmZoa3Z2SE9qOHp0U0ZuYlJlSUR4dHpWUHlidUIvRm45UkdL?=
 =?utf-8?B?K1B3N2tRcEpmT1JpdGFKaTRwRE9JK1AzMTFjV3lVWUNreXpPKzYzZTZyek5H?=
 =?utf-8?B?b2ovM3k5ZUpLaU14ZzlOVGtoYVhJYjVXelc4ZGdGRnBkK0l6WGx3VkdpVzZl?=
 =?utf-8?B?Wkh6WlhHYUVZUmVSbUwyNFN5T3lsUHR4bmgrVGYrN0hlQzNQSURnRzJkdk1O?=
 =?utf-8?B?anhEaWIyenBZYktMRXYrcWs2Y2dBVUdSdTMveDdicUxwaGNqZ1RESzRwTzZv?=
 =?utf-8?B?NWRQV01lRTd4T25xa2hoZzVyTXFMNnE1Z0Nrd3dPV091M08zeStBRU5yQXhr?=
 =?utf-8?B?NUF3RnZXUGJCTjNSUTVYOXlQMmoxemNXdnVVenVjbXpQWXZLSEJEcS9EMlFY?=
 =?utf-8?B?eEtCRGV1M2xYb3UvblFhY2hFZVZSZzJTVGE5eW1DVEw2L1lRSFowcFNWMUd3?=
 =?utf-8?B?OWFSNzVvNHBudm1VN3dhSWdWWGZLM0syRTJkMzVPdFhhenhJaG1SM2dKWHI1?=
 =?utf-8?B?NHJUSGpNbU9DVUNRdVRuNnlVZGZuMis3aGo0Z2EycFhmQWdYRU0vanlBWjVC?=
 =?utf-8?B?YXB1bnZsRzh4OVhpQW9BM08zTzZWbXB5NmlVWCswb3pxL1lFSU85RzlqQ3dG?=
 =?utf-8?B?Y1RlSUR6NEtYQWFNeGFKdDd1b1Q4RU1rbDZJRjM4ZmhtVVRwWUN2eS9wR2J3?=
 =?utf-8?B?aWx6T0MxbW9NWFY3YzZKaDc5UDh2NHB6OXdGbVRzTGtQTXhFOEM1L3FtcWcv?=
 =?utf-8?B?L2RhZ2dXb0srbmtqRFpsT0orQ1Y5TGRTQUhWd2Zrc1hncXoyU2doditvbWVH?=
 =?utf-8?B?MXd0UGZQdFRWdDY4azU3VVRMMmw4a2RYVUpIOWlzSFp3djYweUZmOEJKT1Q5?=
 =?utf-8?B?dVc1Y29oSGxRcmZWZnRGNFNNSDkrd0tHTklzbzd3TDNXWVdwanhCa2RLQ2tz?=
 =?utf-8?B?RHpXZFR6Q0ZYcUw5OXMrZFUrSkdXLytsMVhWMWFsYkR5NjVRQ1RLdWdxZllq?=
 =?utf-8?B?NmpWVkZ4UnMvaGZqL1Nja0pjUTdPeUdhamlmK0x0SDd3SVRlOHVSTXlhWFBz?=
 =?utf-8?B?bHhYZnZYcVpjcU9YSUxwaE5jczR1WURNMTZsQWlnb1R1VDVOcUVEQlhtcUdi?=
 =?utf-8?B?UVErZVpyY1c4MTJyQ2ZUSVp3N00vSU5zRVlFd0hHOEJ2ZE9JdVBoUmJZdnBy?=
 =?utf-8?B?Ty9WY2dNaDROZ1JONzhuM3A2UTY0U3FySFBLM002WFlEWEQ0Q2I4L2lWcVVs?=
 =?utf-8?B?clZ0aW9QZStnRVM4RkY5Nll3QTZVaC9tWFMzcXNiNzRHcHZUb21aSUFRMVlR?=
 =?utf-8?B?K0xFSi8wWEhoOE9YSzFPTVl2T3JRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <65CD816EE4303F46A73741F489736C26@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3753aeb7-3463-41ea-7790-08dacba5f90d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2022 09:51:33.4173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OcYIZiA6r2CfiCLBru+wFNmvkMM1J9LESHCNyhKKbPLpP+UioSQrc41bLstTd49UVhljyi8uCArtdmVYDlWcZpMgbhZbkgqDY1cSdTTnE8g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3260

T24gTW9uLCAyMDIyLTExLTIxIGF0IDEwOjE2ICswMTAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAxOC4xMS4yMiAxNjo0MiwgRmxvcmlhbiBCZXpkZWthIHdyb3RlOg0KPiA+IFdpdGggcmVjZW50
IGdsaWJjIChhdCBsZWFzdCAyLjM0KSwgYXV0b2NvbmYgZmFpbHMgdG8gZGV0ZWN0DQo+ID4gcHRo
cmVhZF9tdXRleGF0dHJfc2V0cm9idXN0X25wLiBCdXQgdGhhdCBpcyBsb25nIGRlcHJlY2F0ZWQg
YW55d2F5LiBTbw0KPiA+IHN3aXRjaCB0byBwdGhyZWFkX211dGV4YXR0cl9zZXRyb2J1c3QgYW5k
IG9ubHkgZmFsbCBiYWNrIHRvIF9ucCB3aGVuDQo+ID4gbmVlZGVkLg0KPiA+IA0KPiA+IFRoaXMg
aXMgYSBiYWNrcG9ydCBvZiB0aGUgZm9sbG93aW5nIGNvbW1pdHMgZnJvbSBzdGFibGUgMy4yOg0K
PiA+IA0KPiA+IDc0NmNiZWI2Y2NjMCAoImxpYjogU3dpdGNoIHRvIHB0aHJlYWRfbXV0ZXhhdHRy
X3NldHJvYnVzdCIpDQo+ID4gM2Y4NWMxNzRlMjk3ICgibGliOiBGaXggZmFsbGJhY2sgc2lnbmF0
dXJlIG9mIHB0aHJlYWRfbXV0ZXhhdHRyX3NldHJvYnVzdCIpDQo+ID4gMmQ5NDdlNmZlM2Y4ICgi
bGliOiBSZS1hZGQgInN0YXRpYyIgdG8gcHRocmVhZF9tdXRleGF0dHJfc2V0cm9idXN0IGZhbGxi
YWNrIHN0dWIiKQ0KPiA+IA0KPiA+IEJhY2twb3J0aW5nIGFsbG93cyB0aGUgc3RhYmxlIDMuMCBi
cmFuY2ggdG8gYmUgYnVpbGQgd2l0aCB0aGUgbGF0ZXN0DQo+ID4gRGViaWFuIHRvb2xjaGFpbiwg
c28gd2UgZG9uJ3QgbmVlZCBhIHNwZWNpYWwgQ0kgc2V0dXAgZm9yIHRoZSAzLjANCj4gPiBicmFu
Y2guDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogRmxvcmlhbiBCZXpkZWthIDxmbG9yaWFuLmJl
emRla2FAc2llbWVucy5jb20+DQo+ID4gLS0tDQo+ID4gDQo+ID4gSGkgYWxsLA0KPiA+IA0KPiA+
IHdvdWxkIGl0IGJlIGFjY2VwdGFibGUgdG8gYXBwbHkgdGhpcyBwYXRjaCB0byB0aGUgMy4wLngg
c3RhYmxlIGJyYW5jaD8gDQo+ID4gSXQgd291bGQgYWxsb3cgdXMgdG8gYnVpbGQgdGhpcyBicmFu
Y2ggd2l0aCB0aGUgc2FtZSBpbmZyYXN0cnVjdHVyZSBvbmNlIA0KPiA+IHdlIGxpa2UgdG8gdXBk
YXRlIHRvIHRoZSBuZXh0IERlYmlhbiB2ZXJzaW9uICgxMikuDQo+ID4gDQo+ID4gRXNwZWNpYWxs
eSB0aGUgeTIwMzggdGVzdHMgcmVxdWlyZSBhIHJlY2VudCBnbGliYyB2ZXJzaW9uIHRoZSBuZXh0
IA0KPiA+IERlYmlhbiBzdGFibGUgcmVsZWFzZSAoYm9va3dvcm0sIERlYmlhbiAxMikgd2lsbCBz
aGlwIHN1Y2ggYSB2ZXJzaW9uLg0KPiA+IA0KPiA+IE9uZSBhbHRlcm5hdGl2ZSB3b3VsZCBiZSB0
byB1c2UgZGlmZmVyZW50IGJ1aWxkIGVudmlyb25tZW50cyBmb3INCj4gPiBkaWZmZXJlbnQgWGVu
b21haSBzdGFibGUgYnJhbmNoZXMuIEkgZmVhciB0aGF0J3MgaGFyZCB0byBtYWludGFpbiAtDQo+
ID4gZXNwZWNpYWxseSB0aGUgQ0kgY29uZmlndXJhdGlvbiB3aWxsIGxpa2VseSBleHBsb2RlLg0K
PiA+IA0KPiA+IFdEWVQ/DQo+ID4gDQo+ID4gVGhpcyBwYXRjaCBoYXMgYmVlbiB0ZXN0ZWQgd2l0
aCBib3RoIGJ1aWxkIGVudmlyb25tZW50cywgc28gRGViaWFuIDExDQo+ID4gKGFzIGlzIG5vdykg
YW5kIHRoZSB1cGNvbWluZyBEZWJpYW4gMTIuDQo+ID4gDQo+IA0KPiBJIGRvbid0IG1pbmQgYmFj
a3BvcnRpbmcgd2l0aCB0aGlzIHVzZSBjYXNlIGluIG1pbmQsIGJ1dCB3aHkgY2FuJ3Qgd2UNCj4g
Y2hlcnJ5LXBpY2sgYW5kIHBvc3NpYmx5IG1hc3NhZ2UgdGhlIG9yaWdpbmFsIGNvbW1pdHM/DQoN
CkhpIEphbiwNCg0KSSB0cmllZCBidXQgdGhlIGZpcnN0IG9uZSByZXF1aXJlcyBtZXJnaW5nIC8g
ZG9lcyBub3QgYXBwbHkgZGlyZWN0bHkgdG8NCnRoZSAzLjAueCBzdGFibGUgYnJhbmNoLg0KDQpI
b3cgdG8gcHJvY2VlZD8gU2hvdWxkIEkgcmVzZW5kIHdpdGhvdXQgUkZDIHRhZz8NCg0KRmxvcmlh
bg0KDQo+IA0KPiBKYW4NCj4gDQoNCg==
