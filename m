Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3BC18B0D
	for <xenomai@lists.linux.dev>; Thu,  3 Aug 2023 15:05:35 +0000 (UTC)
Received: from redirect.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::232])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 5B654C2272
	for <xenomai@lists.linux.dev>; Thu,  3 Aug 2023 14:43:45 +0000 (UTC)
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay12.mail.gandi.net (Postfix) with ESMTPS id 2C1F7200005
	for <xenomai@lists.linux.dev>; Thu,  3 Aug 2023 14:43:37 +0000 (UTC)
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on20725.outbound.protection.outlook.com [IPv6:2a01:111:f403:700f::725])
	by spool.mail.gandi.net (Postfix) with ESMTPS id F055674003A
	for <xenomai@xenomai.org>; Thu,  3 Aug 2023 14:43:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ms+mJ0nRR2yALJLI9EbP+al2A40EGQKy28V/sosscBIuQMsfqBUiYQG8J7AJm9hjQcctEZmHKrUcYN3NUfHPMGUp8Me0y+b0wODMZ/M9nESdYdSdWweyVyEsMkHwpxuIEwgQxUq0CzwxzE6q7tyqShC3A3d7FvS7GnS12jN/PJB2KEHZKWtLFv7K3NnYvJXEV/JVR3Y6a93M0FOudy481kbYj+Nce9a3AYrWwigWCWCkMUWjkEdhyQ4tNb7NwVXw8kUUpvKGMqLOiedmZx2ZnVzC5xogrA/Az7lG8hXyxA2vzf5YYKgmfiXroxPON/LRyOlN3MMG9l6yRrcHZzxlKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=McXHD8/QYCxGnOI79jAlDptzgVAFWX9IZaW8jcI4jJU=;
 b=J/nME8cHNMUnccc5zNkJTtRMubkv5ESJjkCz0PtYo0l/SzdaUH/5+ReAZUWG/u19aBRHQxQ1oxmhekmOJWEoCbqAb40jvs5d13Vbg1EBD8Ycx4FMv2JRxLkFCxfHmxPQnarAMOKJpJhDsXIDvwnFCxpbvKv7/Qmlxb6adqwMmlZSxio3wyNtoqe4N1f/jAB+Ko6ir/Ixvjuiwj8qQUv+vyzsTqzY1iTWayW6fyUqFVVltnVz8hl4HgLcboaTKF5w2qmJndxTOR635p5LK3IMiARCTXJfk8hkx10Ol7++e9qiNLiEtn+K41ngjsPDIGJEzltLthSCKEih2UCsiWP2Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marketsdatainfousa.onmicrosoft.com; dmarc=pass action=none
 header.from=marketsdatainfousa.onmicrosoft.com; dkim=pass
 header.d=marketsdatainfousa.onmicrosoft.com; arc=none
Received: from PN0PR01MB9576.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:10c::10)
 by PN3PR01MB5462.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:79::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 14:43:33 +0000
Received: from PN0PR01MB9576.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::21bb:6de4:fe7e:2add]) by PN0PR01MB9576.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::21bb:6de4:fe7e:2add%6]) with mapi id 15.20.6652.020; Thu, 3 Aug 2023
 14:43:32 +0000
From: Claire Davis <Claire.Davis@marketsdatainfousa.onmicrosoft.com>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>
Subject: Re: xenomai IT Services decision makers
Thread-Topic: xenomai IT Services decision makers
Thread-Index: AQHZxhjgEATE0UpihEqzgJ7BpfLK5w==
Date: Thu, 3 Aug 2023 14:43:32 +0000
Message-ID:
 <53e4470e-dd10-2110-fd61-82f99f2a8466@marketsdatainfousa.onmicrosoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0PR01MB9576:EE_|PN3PR01MB5462:EE_
x-ms-office365-filtering-correlation-id: 848a5af2-435a-41e6-0043-08db943002cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 r8Sl0G92V9Nam3w1+umswV5Tznw+JVcDdAbHVNaaZ+NDBHeOSbbn9R6OE5cInS1WQqs1LrcfArDcROBXkvYjgJuPTNMdzX1rL7q9XufCtUKq3wAKkzBfYtW8fVxk6/woo6q5ar4F7B4yc8tqSu8DsrGZmgeHgHg+JCn9eJeyNkF6L1zTv3kepnwDo24DZp00tFXPSYfhveOgXL7uZaB1l4J8VU0NIONnNllxDPMz1TnQKPlVMxBCqawd2rrTSvecXvSJpXe8tGVhpMMmfW1Y6vbK8Ochv35IfsWFZjr0RPXum/rGL2JOqJWKEgQU6jsQMaqW/4Zsq15CNAh7bkfGZ8DGZaVKNjVbumJWbZdRwiKZvN0eCQ82fCHcL3w38nUT2CIvumfxmQNlCBoicpjgmRLRRtzrVQ91uoWNyNgJVe1giyJ440Z1reRjyHtIgNvQKpnZQwWJ9zgkm4Hjnrv/72U813a6klJqsmy4fLyXXi7hzV3zeiOv3ouywilAW8EBRA2+o6caPk8l9r/XT6uq4KMtuUf8qbJ+shgLbeeNQmXrwdq+X65o6YX/chFormm8588/f+dGQ9So2fxK8edMGOyuz0vFsAcUnjF76n2ULNNJvDf0Vb1TJcM8n72ppdwKVeoKtihz/j6rIeC6cIKQFoAbRTAFglIwT0bq/47ycco=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0PR01MB9576.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(136003)(39850400004)(396003)(346002)(451199021)(2616005)(6506007)(186003)(83380400001)(8676002)(66476007)(316002)(66556008)(2906002)(91956017)(66946007)(5660300002)(64756008)(6916009)(76116006)(66446008)(8936002)(41300700001)(6486002)(71200400001)(6512007)(478600001)(38100700002)(122000001)(31696002)(86362001)(38070700005)(31686004)(66899021)(6396002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aWY0L2xpSUkrTThxRWxEVlE2T0VRbThrZGFNT1pMeCthSGpVUS83anFoK2ov?=
 =?utf-8?B?akh5cmhhdU9xNXk5NkI1MnNLY04zd0ZjOTVKSnVjeStEZEtMNEN4RWhkZXhB?=
 =?utf-8?B?SmtLNk1JTFRDSGRCUU5kZUdoR3FFZmJwNmtjSWxya3cwOHVOb3BITEtHNHY1?=
 =?utf-8?B?S1pFcTEvbFdIVDdvZ24xUnhWWnpOYWN0L0Eyd3BpSDRaeGpnaGJtUjVXYXhT?=
 =?utf-8?B?UzBZakVxcUNxMGt6ajNFMTYveHNJRW1Udk12YnlRM3JyWGJhSGxlS251ckds?=
 =?utf-8?B?cDVCZWFQV2FpYVc2eTM5UUlBRGpJV0V5bTdTdS9zOExEdDBvbUZuaDlRSStL?=
 =?utf-8?B?REhVaXQ4M0pEMFZtL0lVc28vT3huMnJGZWJjQWR6d011QUJuTXZFOHRVRUJx?=
 =?utf-8?B?bCtZNk45MmlxV1AyaG5CYnJyZXg2K0g3YnFic1EzTGl4bW51eHBwUzVkdVJW?=
 =?utf-8?B?cnlPRkxDeVc4Ulk5RCtjYkVlcVFDQW1QdDV3aDV4M3N1UWxSR1ZPR2VRTlpl?=
 =?utf-8?B?Q0xQMXdJRGsreS92bzdPU0YwZjBPK3hGVHQvTmNiRnB2RFpOdGF4UWlBU2Ru?=
 =?utf-8?B?d2tBZFkyMXN4Kzd2bG9pZ2oyc2M3dFU3U0J1dXhkY0ZwSlltdkhhYzcyMjlX?=
 =?utf-8?B?NnpNblp0S05yYXB3YVZ2R0lMYmR1b21UY1Y4djNZYVdpaTBHTWJoYmxXeUZC?=
 =?utf-8?B?dm9mS3FtSzg5M1B2Q2kzTXhYbDZLeVJsM0wzUG5pSS8rd3hyVmw1bEQ4REZO?=
 =?utf-8?B?OWRzNzFkZXBpQkRDZVdyaklhVy8yeUJYMUlKbjhtK0FUZEhyTWxvclF2NUZG?=
 =?utf-8?B?V1FkL2dPZE1PYW1VYmJaYXlnMG92Rzc1NEQ1b256dWpqQnVaQStPNnJBUDVK?=
 =?utf-8?B?Z2ordlp6aml0ZXhENWRUZ3BrYmxHaTdneUsvVzg0cUlheWZjM3RWWWJ6SDZw?=
 =?utf-8?B?WUZ3b3NlZHFXL0JLSWdOVzk0QkhsOG5vaDFJdXBDczZnTnlpV2I1RmdLS0FD?=
 =?utf-8?B?eWI2b1ZES281bmpNS1czR3pxNGpmZDgzd2NyNjlUU2xQUDU3M3V3eHd2dlBo?=
 =?utf-8?B?Yk5Sb0paQWJrbVN4dnZWQzlCTnJBUEhuclFWS1hpZ1pWWnBMSGVQUTZwTXND?=
 =?utf-8?B?Q3ZjQjBpOEM4dFZrTDBKZ0krdkpVekRqaDV3dmlRd1dCclh3Q3lhdEZVTmNj?=
 =?utf-8?B?K3BaQzRZdGh4ZmtBNGRiWWxINjFzNkZIRVR2d25DR1dUN01kSEdOVmp2WE9F?=
 =?utf-8?B?VFJEOEt2MXQxSG4wZllLT3p0SjdFZWcvbDBwZzBzcUJrRkZkVURzSk5IeEZj?=
 =?utf-8?B?MDIraGZsV3QydmEzUmlsL0hmejFzV3pTVldubE1oaXhYT3FTaW1TUkxUZVRD?=
 =?utf-8?B?Nm1Kc0x2M0hBMGkyeDVqMi9nTzhjY2Q5a05EU2tTMll2aUwrNFJzTHVwbGtw?=
 =?utf-8?B?VkRydjhQR2l4aFUvTDhhL242RS9QL1BZTnJEOStCRmVxRU0zRDZNRm9BWnZP?=
 =?utf-8?B?ajNpWFpHNVJEWDdhMFl1MnNFZTdwSmhQZkNQdEtBSnRyVVRmSDMwVi9jUGNj?=
 =?utf-8?B?bU9qNmI5WVkrd0RKRXRpMUgyWENxVWxKcjRBaDBPcHNJS2JwdjlmdFVDSFVl?=
 =?utf-8?B?NTJUdERzcHNCMHpkMUE0WDNwb1M0WTdHSENRTjd6Z0ZaS0FnTStYTlhIdnBI?=
 =?utf-8?B?MndacjlBbUJpZnFGWWdTbXZyQk9URVdiRmI5dDNER29xT1d0L2c0SHk2cHdB?=
 =?utf-8?B?OWhjSk85VDVaWERXZFZiZEkzRTVaME1sVitvSGFienBtVG9adTdSOXJhMXh0?=
 =?utf-8?B?NmJmN3VxLyt0dmYwTDlOWkRQZWhOa05HSUtwakdmVkNLdDQ1eU1NNVoyWUdy?=
 =?utf-8?B?eDlVWncyOWRDWlJwWERnRG1zZjh5TVRnaXZLR2RueEJYYkI3WGoxNkcvYndk?=
 =?utf-8?B?STJBZTN3MmpSQXdMV0NIUmNhREoycXEvZVh5VzNKa2dxbjltWTZjV0lmdG8y?=
 =?utf-8?B?Y2YxeVhHaTI5VmFhOFJKVlRXVWZiaU5DYm5wek9IVVFrN0ZFTElsKzlVMTZm?=
 =?utf-8?B?OFBndW5pYjJmbmpmc1hlUkZvOFpYU0tLdlNhbFlwKzUzNzA2djI3ek52bkpx?=
 =?utf-8?B?Uk95dUxmT3RrcHorMWdYWDdOT0luYXVtRjZtelRxRHErOG5nMC93ZVZNKzJG?=
 =?utf-8?B?N01vUmt0eGJEeDRJSnJZVUs0RjhCSU5kdHVyVk5sWjJpSHMrVGUzbFF0bmJ2?=
 =?utf-8?B?S3kvUXpGVGxHNzlCOHBkZEhLWEoyY2kwMzM0K3piMzBKRU5Dc3BReWVYRkNU?=
 =?utf-8?Q?xyT5GogmFcsqlDI4a9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F39C83AEE0433040A9FBB1CB890AB631@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: marketsdatainfousa.onmicrosoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB9576.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 848a5af2-435a-41e6-0043-08db943002cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 14:43:32.8930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 62dfda68-9244-4547-9a56-5a49125b28f2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bb/0xfCQ2i5vs7ecf/egKEZnV5I526Fv5ijxS6d9MMyFzQqRMrepbnczlovR+gGV7e1N2RCr/ZOMDkuo3bTD1ell/mnu0NWE3L/PiEZCMu66baNBtfEnqjKIwzGiqHYeaC3eoYI6yHiERT2jznewsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB5462
Authentication-Results: spool.mail.gandi.net;
	dkim=none;
	dmarc=none;
	spf=pass (spool.mail.gandi.net: domain of Claire.Davis@marketsdatainfousa.onmicrosoft.com designates 2a01:111:f403:700f::725 as permitted sender) smtp.mailfrom=Claire.Davis@marketsdatainfousa.onmicrosoft.com;
	arc=pass ("microsoft.com:s=arcselector9901:i=1")

SGksDQoNCldlIGhhZCBzZW50IHlvdSBhbiBlbWFpbCByZWdhcmRpbmcgYSBjdXN0b21pemVkIGxp
c3Qgb2YgSVQsIElTIGFuZCANCnRlY2hub2xvZ3kgY29udGFjdHMuIFlvdSBtYXkgaGF2ZSBtaXNz
ZWQgdGhlIGVtYWlsIGFzIHdlIGRpZCBub3QgcmVjZWl2ZSANCmEgcmVzcG9uc2UgZnJvbSB5b3Vy
IGVuZC4gQmVsb3cgcGxlYXNlIGZpbmQgbXkgbGFzdCBlbWFpbC4NCg0KUGxlYXNlIGxldCBtZSBr
bm93IHlvdXIgdGFyZ2V0IGluZHVzdHJpZXMgYW5kIGpvYiB0aXRsZXMgc28gd2UgY2FuIA0KcHJv
Y2VzcyB0aGUgbnVtYmVycy4NCg0KUmVnYXJkcywNCkNsYWlyZQ0KDQpPbiBUdWUsIDMwLTA1LTIw
MjMgMTE6NDMgQU0sICJDbGFpcmUgRGF2aXMiIHdyb3RlOg0KDQpIaSwNCg0KV291bGQgeW91IGJl
IGludGVyZXN0ZWQgaW4gcmVhY2hpbmcgb3V0IHRvIHRvcCBsZXZlbCBJVCBhbmQgTmV0d29ya2lu
ZyANCmRlY2lzaW9ucyBtYWtlcnPCoCB0byBwcm9tb3RlL3NlbGwgeW91ciBwcm9kdWN0cyBhbmQg
c2VydmljZXM/DQoNCiDCoMKgwqAgQ1ZEIFRlY2hub2xvZ3kgb2ZmaWNlcg0KIMKgwqDCoCBDSU8s
IFZQIG9mIElULCBEaXJlY3RvciBvZiBJVA0KIMKgwqDCoCBEYXRhIENlbnRlciBNYW5hZ2VyDQog
wqDCoMKgIENPTywgTmV0d29ya2luZyBNYW5hZ2Vycw0KIMKgwqDCoCBTb2Z0d2FyZSBFbmdpbmVl
cg0KIMKgwqDCoCBPd25lcnMsIENFTywgUHJlc2lkZW50cyBldGMNCg0KV2Ugd291bGQgYmUgaGFw
cHkgdG8gY3VzdG9taXplIHlvdXIgbGlzdCBhY2NvcmRpbmdseSBmb3IgYW55IG90aGVyIA0KcmVx
dWlyZW1lbnRzIHRoYXQgeW91IGhhdmUuDQoNCkluZHVzdHJpZXM6DQpJbmZvcm1hdGlvbiBUZWNo
bm9sb2d5IHxGaW5hbmNlIHxBZHZlcnRpc2luZyAmIE1hcmtldGluZyB8Q29uc3RydWN0aW9uIA0K
YW5kIFJlYWwgZXN0YXRlIHxDaGFyaXR5IGFuZCBOR0/igJlzIHxFZHVjYXRpb24gfFB1Ymxpc2hp
bmcgfFJldGFpbCB8IA0KQ29uc3VtZXIgfCBNYW51ZmFjdHVyaW5nIHxHb3Zlcm5tZW50ICYgcHVi
bGljIGFnZW5jaWVzIHxFbGVjdHJvbmljcyBhbmQgDQpUZWxlY29tbXVuaWNhdGlvbnMgfEluZHVz
dHJ5IGFzc29jaWF0aW9ucyB8SGVhbHRoY2FyZSB8IEhvc3BpdGFsaXR5IA0KfExlZ2FsIFNlcnZp
Y2VzIHxGb29kICYgQmV2ZXJhZ2VzIHxNZWRpYSAmIEVudGVydGFpbm1lbnQgfEVuZXJneSBhbmQg
DQpjaGVtaWNhbHMgfEFlcm9zcGFjZSBhbmQgRGVmZW5zZSB8VHJhbnNwb3J0YXRpb24gYW5kIExv
Z2lzdGljcyBFVEMuDQoNCkFwcHJlY2lhdGUgeW91ciByZXNwb25zZS4NCg0KUmVnYXJkcywNCkNs
YWlyZQ0KDQpDbGFpcmUgRGF2aXMgfCBNYXJrZXRpbmcgQ29uc3VsdGFudA0KDQpSZXBseSBvbmx5
IG9wdC1vdXQgaW4gdGhlIHN1YmplY3QgbGluZSB0byByZW1vdmUgZnJvbSB0aGUgbWFpbGluZyBs
aXN0Lg0KDQo=
