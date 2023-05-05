Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2059.outbound.protection.outlook.com [40.107.8.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4701C2B
	for <xenomai@lists.linux.dev>; Fri,  5 May 2023 07:36:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IcgOmjoxXLomYV2C8hhdH/BW02VrQlyd1N5iIeTMescXDeqlms36JD6jJFOdhEJbn9AOQRBL3qw/cQsC2KhkrEE751xMPCxQYNdh6g9vy7Bww94LzKPOKWhYbJglTASWphMvpOANH+DR2CvsHZskoas0/VtGuTGtmJqvtQnxlCNLUdxYP2V7JkUhVZyqUDRgrmPf6zQsYCf8eAcWspSkvzi3vJK6XEwlgA8ly+rnKL7SEF+Ei6rjPnxoX5sT/DZJtDizbGil8G/zYCbNnfa37CvJdvvjXmuW3M7z/HL5EygB5B2vJJAOOz6WMEM5x7vDZ8yjdJbVwYVHlWcyw9R3Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OS2xZ1X4LYHn1AjXuYeGD1AXN3EMDhHJL/QXVcCw1aw=;
 b=CbYLRTqb51CJi7tH1jyxcyfysmmuVeOsUKZhelWE2WO9FExJ2LChKrVhRKsIfhpAH3LfDs1mbcZW6me4J8WmsRsPYicmv8N6jJZzYnagD0ZlDFx6sGTq7hBLRBQVNGtukER2OE2GSbrk6HFu9aPPnQPfHnLGXyYYjTMUhzupcrz+ssT7RPS8ATrTaQtSXpiwodJXj26kVsfF48RY6MJY4NV8ExKlv/3pa+EcAPp6/xOdyw62vQfdhFzjhNtB+96jAgK/0IYYQDfpyiSLoRfzjs8pN7sdzfeKs8Lxmn7cuDvzShk7yRJS90NoXE5UhBHFQl7iAhL9lKXF1Kc2CylY4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=boschrexroth.nl; dmarc=pass action=none
 header.from=boschrexroth.nl; dkim=pass header.d=boschrexroth.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=boschrexroth.nl;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OS2xZ1X4LYHn1AjXuYeGD1AXN3EMDhHJL/QXVcCw1aw=;
 b=eeDUweJ+95NjkaMHZZYgfhCH6yuDt0yvd5fvB9SEvto70yQ9W4yAR57puRXDDZnrePacC46USTGmq5HS6BIGajOATlK0PcvJBys+/rSlFixIOcnnGwO+dXULhlWTXp9J5KtWYla0dyvPVbgGv2jLQpR1x8vufqG9jyQkaTiBfck=
Received: from DB7PR10MB2459.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4f::29)
 by AS8PR10MB7970.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:568::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Fri, 5 May
 2023 07:36:05 +0000
Received: from DB7PR10MB2459.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b80:4de6:1500:d046]) by DB7PR10MB2459.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b80:4de6:1500:d046%4]) with mapi id 15.20.6363.027; Fri, 5 May 2023
 07:36:05 +0000
From: "Schuman Eelco (DC-AE/ESW5)" <Eelco.Schuman@boschrexroth.nl>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: Question about a freeze under Xenomai 3.2.1
Thread-Topic: Question about a freeze under Xenomai 3.2.1
Thread-Index:
 AQHZfcVBA4GbIQ1h1EaRVS4jgWLnyq9Io4gAgAF67QCAAAxjAIAAAr0AgAAJPoCAAA4CgIAA/JuQ
Date: Fri, 5 May 2023 07:36:05 +0000
Message-ID:
 <DB7PR10MB2459812A2291AB88A99ECBB5EC729@DB7PR10MB2459.EURPRD10.PROD.OUTLOOK.COM>
References: <5a8afa1e-d6d7-df9f-2895-6832ffa9673f@smile.fr>
 <189dee91-923f-131a-ccae-0afcccd06107@siemens.com>
 <7dfbe0c0-161f-0977-4332-75575f1a17ce@smile.fr>
 <9a48d273-5ebd-f557-7941-8532b7ec4b67@siemens.com>
 <5523da9b-bb44-a1be-9e54-bcad21867eb6@smile.fr>
 <CALLqZ8TeAeeu++UP499YS_XPwVYw05eMEYf-K7HPmyhXHBoACg@mail.gmail.com>
 <0e065176-74b8-b02a-29c2-30eb34a79cdb@smile.fr>
In-Reply-To: <0e065176-74b8-b02a-29c2-30eb34a79cdb@smile.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=boschrexroth.nl;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR10MB2459:EE_|AS8PR10MB7970:EE_
x-ms-office365-filtering-correlation-id: e281c0b9-c8cc-48dc-2d4a-08db4d3b62bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 SPHWhgdS/7DTrA3wxL56Moo/WoUY6NlwLKLMtHfj7l3qSHHffA89lqiGHEUGRhgcbrjp/5zr4JO51CAyIrszsmrJTKb54RRzRg2NjOrCZ4GTXebtDJ5jpO+wAi3z5vX7gWcshWjl8Ohi8DUbqsaxXAR6AmwiGVjTIe3U0bmcm7RkmS6FHWAaeib/lK9Yt3h68TCCqX1l/s6CM/SUWNNSiCLIbJIW8jL/S0BjgN8VOzllSGmQNSbqLDVr5kj9tgVvqN22SM2s8t71LZJw6eA8jSWoPGPOy2OtwHkm8zaGKZWSrs3/upDmMyLaEmkMoVUO+loPZjF9v0YlYqxBHbvZ7kX2a8DhZhZ1S8nTjRRKlpKTgMDvQWGKQlhM1dbpBSAkHF8K169iNtmhbJV0QHKcSwAGaQj5XCZGF7Er/HFKts5qhYyoo2I8gfq/ReweedddqCcMh2Tsz+hDbYmd2+Zp7W/LY/9j2Y42kS8H+okvuYt/gCJdbb+mlkQT4sqTU7Nf+96lpEGw+CB4B0JMgwt0Gr+abZPNzWfIZxWw/YhSg4EeLjCdl1Q5kYvulFSF9cvXs44Wp7PzZmwxZuHgZnji+K7FjwzFDAR6JSGV+bNu67gJym0WUBXXWnLWs1mMmP3+
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2459.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(366004)(346002)(376002)(451199021)(38100700002)(478600001)(122000001)(55016003)(82960400001)(52536014)(8936002)(5660300002)(8676002)(86362001)(7696005)(26005)(2906002)(76116006)(66946007)(6916009)(64756008)(66446008)(66556008)(6506007)(33656002)(316002)(186003)(41300700001)(9686003)(66476007)(38070700005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q0c5R3g1SU9DS2s4UVpoQWJYTW93WGVydTNTbzN2ZXdZVzBoVHcydzRrbGtK?=
 =?utf-8?B?ZGxSVzVqSy9SVEt3QzZNeVozWWhEb1dNQVFUYk5DR0xwRmIxVkVoYkhQZ1RU?=
 =?utf-8?B?OXVMb2JBOUduTkFSMmJIdDA2OWlLN243aENzVmpNV29YS0FhSDNrdWpEMlBN?=
 =?utf-8?B?TjFqZUVLUlg1NnlxaUpkZ2haWTdBeDBDUWlCMjFOMFZmQXc1MGQ0dTBmTkt4?=
 =?utf-8?B?cXBSZ0tYVTRmVWlBeFg2UFdHaUJsOWpXQjNqUmVpdUVKUFZFQjFkRjdJdzJJ?=
 =?utf-8?B?WFZRZGovNmdBVHV1OFYxWjdLanFmSzh2Smx2Uk5yWEFNT0JWb0d6a3hsTTJ6?=
 =?utf-8?B?NUZvNzAvQ3RGOVpwdERPTFZvVEgraUd3cnBrZEkzL3lSK0gyLytlQUhhL003?=
 =?utf-8?B?OXlHUWNZRnUxRUMwVWVrVTRhKy8vMnlmU0J1RjBiSjdNVmNzeGpOUmE0RzRV?=
 =?utf-8?B?VXYwWkw2SVFiWUpBaGs3VFZBYlNRS3k4NGxnVjNvQklKMXUwZlJnOFhNSGp6?=
 =?utf-8?B?UVIvQUVQM25SOGVlcFlobUI1QmU1d3pvT21wa1Z1Y2M4Nm9tR1dWanJRT2dD?=
 =?utf-8?B?WGdzTUFzYTVzZkRQZGJaS1lzMmQwcDd1Z2t4YzUxS0NWZFc0NHpZYkNFd1pK?=
 =?utf-8?B?Tys5SERyYzhFaHEyQnRuQ1ZNdXhSWmJkODRhV0phQUtFb25oT3U5b2lwa1Fh?=
 =?utf-8?B?VjFQREN1OVlPYnBTUlpFQ09lSHF3YUtSWE80T3FlSTVGdWxaQytDV3hyQzk2?=
 =?utf-8?B?NmhUMGdFWHd4eDhwdFpKUjU4SUZUZ1h1UHFGa3llUnl3UFpUWHJsaGJ1N2t1?=
 =?utf-8?B?Njk4QUJNTndsZU44ekNva2EzRWpBY2l1cXZwRVBXNm9BeVVCZlZac3JWRGh1?=
 =?utf-8?B?UC84ZTl3QmRiUUpKMXJkUlQ3WVJMd0VLQmhZYnZZSHlZQTUwbjhjYTZiNndS?=
 =?utf-8?B?T1JtM3plZUU3SkpsUzVJd2F6b09leXJzS1ExYXdYQUtmcE1lcXQ3L0tMaGJv?=
 =?utf-8?B?K3JPbWJZVDNFWnZ3RnJScmE0VERSVFFoS3lEQUZxcXk4UjVubWw2T21UTnZF?=
 =?utf-8?B?bzVZR0VvL3lwODBzWi9hYU94OGZ3V0UzWWIrSmgxdmdsVUpJYi9oOVpjbVh4?=
 =?utf-8?B?ZGpKRzl2T3YwL0c2RlQ4YllZZlVLdUxtbWlrRlFzWHA0SEZCYWZBYkV4RHBs?=
 =?utf-8?B?T1JmUU1pMk5xYlZQdmpXdjY5TWZ6SVdKTU5NWmpoY2lQUFBiQUFzZkI1SCtC?=
 =?utf-8?B?cVRpU05OS0FuWm43bmwxOFhJdXJWV2RRZGNwdHBKT3ErYjZNN0hhZ1JXampU?=
 =?utf-8?B?V0dsUllXTXpvMmpLaXJYQ0JXV0M5d0IxbmY0em5Nb3A3d0dsMEZBd3pTTUxF?=
 =?utf-8?B?NWhJa2V2bGZUaDdmTTluSEx5d3dPUjJuaWhlOHJNbGZ2KzFtb0VadGZlaXd4?=
 =?utf-8?B?V0lCc0gwczdEcUVwVFQwNWpzQnZwNDB6SGt2MHJ0VE9wbGhlNHNVRmJlajU2?=
 =?utf-8?B?UFB1dDRmeUs2VE13bkF0Z0F6V3FJQ2tDdmd2eHkrbnFVRGJ6SjBVaDVyK0Ft?=
 =?utf-8?B?WjgxYm9hbER0aldyYzBRc0ZyTmE3VFlJNlN0S3VON2ZYWWdxcHpCMU81VnpY?=
 =?utf-8?B?S0libTFMcUIyTGFEYzZyZ3Z5NVRaZ3hSSEtHWEtxWGZJR21VS0p4b0xlTjdk?=
 =?utf-8?B?M3N1eHluNkhsT1NTQnJtQVcvejVNaTJGZUxKZi9kbllxQTdyVGtoMERoeTJR?=
 =?utf-8?B?NkI0ejlUNlk3S3VnZTBVUlovK29RVEh1WXl0RTFob2lTNzVCbTJraEVIVXUw?=
 =?utf-8?B?VjlwNWFneDYraWFwQTZZK09VaTBrOXZpMWcyZXhvcUxQM1ZuQXlXQ1hoWVRL?=
 =?utf-8?B?eWFqZzRGTVkrcDgrNFVYNTEzaFYrUnY5dXlnNVpuQnY1Zk13L3gzblVMOHBH?=
 =?utf-8?B?V0ZRS29ld2ZRYzFNa2tDNDF3KzlKU2piZCsvQTBPL2RHMGJHVUZQa0lVMGFp?=
 =?utf-8?B?ajFyWGhLWitodE40d0hxdWlHS1VlbllGMkdaZXd3c29QSkR1K1dxdElXM3JY?=
 =?utf-8?B?Rm9BNHZQWS9uQzBwc0cyaWtRSDNVRXNIUDB3ak5xNXNsVGh4ME9rLzRZQ3B3?=
 =?utf-8?Q?if1U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: boschrexroth.nl
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2459.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e281c0b9-c8cc-48dc-2d4a-08db4d3b62bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2023 07:36:05.7704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /80baN7KQpftoUsdVh+JWoAwMvEopBkp36Sfwhx+mhvuH+Q8D5Ch9pI0TvOomL88IPRD3ODG05V4T958zz+/pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7970

SGksDQoNCj4+IEkgdGhpbmsgd2Ugc2F3IHRoaXMgaXNzdWUgYSB3aGlsZSBhZ28uICBJIGNhbid0
IHJlbWVtYmVyIGlmIGEgcHJvcGVyIA0KPj4gcGF0Y2ggd2FzIHN1Ym1pdHRlZC4gIExldCBtZSB0
YWtlIGEgbG9vayBhdCBteSBzZXR1cCBoZXJlLiAgSSB0ZXN0IA0KPj4gaXBpcGUgb24gYm90aCB6
eW5xNzAwMCBhbmQgVWx0cmFzY2FsZSBib2FyZHMuICBJIGhhZCBhIGRvdmV0YWlsIA0KPj4gZW52
aXJvbm1lbnQgdG8gdGVzdCB6eW5xIDcwMDAgc2luY2UgdGhlcmUgd2VyZSBzb21lIHNtYWxsIGlz
c3VlcyANCj4+IHJlcG9ydGVkIGluIHRoZSBwYXN0LiBJIHNob3VsZCBoYXZlIHNvbWUgdGltZSB0
byBib290IHNvbWV0aGluZyANCj4+IHNpbWlsYXIgdGhpcyB3ZWVrZW5kIGFuZCBzZWUuDQo+Pg0K
Pj4gLUdyZWcNCg0KPlRoYW5rcyBmb3IgeW91ciBoZWxwLg0KPkFzIGFuIGFkZGl0aW9uYWwgdGVz
dCBJIHRyaWVkIGEgUmVkUGl0YXlhIHRoYXQgSSBvd24gKHZlcnkgdXNlZnVsIHRvb2wNCj5idHcp
ICwgYmFzZWQgb24gYSA3MDEwLiBTYW1lIGlzc3VlIG9jY3VycyBpbiB0aGUgc2FtZSBzZXR1cC4/
DQo+DQo+SW50ZXJlc3RpbmcgdG8ga25vdyB0aGF0IHNvbWUgaXNzdWVzIG9jY3VycyBpbiB0aGUg
cGFzdC4gSSdsbCB0cnkgdG8gc2VlIGlmIEkgY2FuIGZpbmQgc29tZSBpbnNpZ2h0cyBpbiB0aGUg
bWFpbGluZyBsaXN0IGFyY2hpdmUuDQo+DQo+SnVsaWVuDQoNCkkgaGFkIGFuIGlzc3VlIGxpa2Ug
dGhpcyBzb21lIHRpbWUgYWdvLCBhbHNvIHdpdGggYSBaeW5xIDcwMDAsIExpbnV4IERvdmV0YWls
IDUuMTUsIFhlbm9tYWkgMy4yIGFuZCBhIEJ1aWxkcm9vdCBidWlsZC4gIFByb2Nlc3NlcyB3b3Vs
ZCBmcmVlemUgYWZ0ZXIgZXhlY3V0aW5nDQpzb21lIGtpbmQgb2YgZGVsYXkgZS5nLiBzbGVlcCgp
LiBJdCBsb29rZWQgbGlrZSB0aGUgZGVmYXVsdCB0aW1lciBmb3IgdGhlIFp5bnEgZGlkIG5vdCBn
ZW5lcmF0ZSB0aW1lciBldmVudHMgZm9yIHRoZSBwcm94eSB0aWNrIGludGVycnVwdHMuIEknbSBu
b3cgdHJ5aW5nIGEgc2V0dXAgd2l0aCANCnRoZSBaeW5xIGdsb2JhbCB0aW1lciBhcyBzb3VyY2Ug
b2YgZXZlbnRzLiBUaGF0IHNlZW1zIHRvIHJ1biBPayBzbyBmYXIuDQoNCkVlbGNvIFNjaHVtYW4N
Cg0K
