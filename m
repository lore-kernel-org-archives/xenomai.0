Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2058.outbound.protection.outlook.com [40.107.105.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9159453369
	for <xenomai@lists.linux.dev>; Thu, 15 Feb 2024 11:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707996338; cv=fail; b=f4Cek3T1aEpN7eeZLrGPwAOh3puX0Y4kseOus3nyhviWGg7zaiUKlwhm9v27O6BATBJGvsUkmi700U31J6CbLiJO43B4gYnmxK55uvIBckIQfTnJSONnVEOCqpBLns9FhqYXUJeNtQ0UEO5MHUSgvmxVT7pBrUtY6sTP5Wb6iPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707996338; c=relaxed/simple;
	bh=dQN0rYCsqfh74UWrOuGX+ysi1gw5MoWjxYB5OGuouT4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KRSemZzx/qjBjBWSj6PLtQJx28UuwSM1feE6ptSa0vFwTLhNFgGk1OXUGSgpALsIpE6m5BqZOzP55hAN4lW7w1x5ZBBpqGXA5TR3x4zRvERS7dY3bp60GU/Ic6Q7cS2v/qoUGQ0O0FORnb6jHbHtMKb8SCBiCrGMCG5fhugH2vA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=kNIcSfVr; arc=fail smtp.client-ip=40.107.105.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="kNIcSfVr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfSyO5Lx7K5CjDabyIGUGdaXtGRrfpvSy7ZmtgVKfeBt6eiJohCMPIdFCgODONH/ZfPNRP/DV0AiHQrHLe8wUWY8slB1kfJgz5+cURgZ3kn3e/hZzpVlNV+7ZLVp2s6TdW6eVH5DMXnHwr49SBJr158Wk2rS8jGaePp/tpQXPIkLn+ais7KXzT1nijJ6KOA80MXgEGd7SNdUsutfoPjgSJxIY2HEqiRinllCYynvEBnhqD+PjSeqswIuMgNMuV/DHdfB6iKyjJ0PWB/zYeaszzpqoFkj5BuP8n2b4Gd6gvLAarq1tDMCVcmw/0fJzAiOXD0+DmlUhVm0Wfl71pQWLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQN0rYCsqfh74UWrOuGX+ysi1gw5MoWjxYB5OGuouT4=;
 b=B2DiAX3J3q0p8MuBGNkSbtevqV+07MxOQFCERlWT4EuNFRy4TjdizYwMNyYcyo0aGh+71VNWDzXSvXz19O2eeCSIPhRZlcKurHKCbik632k4JwaUF8Va2k6zy3L9vQ+UAGavDqImXRc568tBUJEXBCG2+ew1Sqqeb2iiIFF55mf9exKEGDpA7sCLOQvoLK0R9WPkWBXGFkcc9uvtXVG0HKIL2gbdWhueL6iO5KSg2qZ9d0nReo+A76/kpQ80vZY1rTIDPasXeKvZk89gzCai/gF98AYoz1kvgSVbi5YmxGa9ssCAEkVHf4hVufHLYPjAGI0ucCV2UqwPCL5vpzuzrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQN0rYCsqfh74UWrOuGX+ysi1gw5MoWjxYB5OGuouT4=;
 b=kNIcSfVrTPcB8ooYFHREF+/LuVO1rsrQICxdSIKyaYkk2UPnImymcDTU5ZxDqvCeZpnRp/Q4B1qgi9sTuQdTgg984SOHPxNxIKD1hYOR62BuYH3RToYQFLHkLK8uyuXHNMVXfB1AQa/kKwqgB/ntz2r/tagGkkjxkRogALFy61YKOamuZa560oe5l7OdiPIMeugeYHAWFBb5WM7Hvq5Jv2HwQ387ninWjzP0HkUTpXYWog9zKlHqp//fMwXay15aGvy091/gr+JX9TeIwMq+fkU8ddTbs9x2hk53k0p1uG0TIdCvFoxJLHOvgs/2jfGCTorEP6ljfweJhneZnkzJoA==
Received: from AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:672::17)
 by DB3PR10MB6881.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:43a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Thu, 15 Feb
 2024 11:25:32 +0000
Received: from AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a2bd:dabe:eb07:3667]) by AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a2bd:dabe:eb07:3667%2]) with mapi id 15.20.7292.029; Thu, 15 Feb 2024
 11:25:32 +0000
From: "Kowalsky, Clara" <clara.kowalsky@siemens.com>
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>,
	"xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>
Subject: RE: [PATCH v3 0/6] Add 32-bit compat support for arm64 to xenomai
Thread-Topic: [PATCH v3 0/6] Add 32-bit compat support for arm64 to xenomai
Thread-Index: AQHaX2HNdgJF4KuSUUOlkm/OhdCeArELK6yAgAAHGzA=
Date: Thu, 15 Feb 2024 11:25:32 +0000
Message-ID:
 <AS5PR10MB81732D5423D07A39219DC699934D2@AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM>
References: <20240214162045.2017832-1-clara.kowalsky@siemens.com>
 <73b53943bfe3fb1166de243e0c0930c9df7f3142.camel@siemens.com>
In-Reply-To: <73b53943bfe3fb1166de243e0c0930c9df7f3142.camel@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=638bbb91-8cc5-42cb-bfbb-46216d463a69;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-02-15T10:21:43Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS5PR10MB8173:EE_|DB3PR10MB6881:EE_
x-ms-office365-filtering-correlation-id: eabcd725-5ff8-49f0-8e47-08dc2e18d2a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 T52Tw7PduLF9kBdnvBSRKrC9HmLnPqFNVqMzS7GHKaP8/GO3e9dAlKySjmr2r5Cum4d/GpPLjPQZQOCL4/F257QFLla1PWaBfY+glKIGb3BdprfncCm62CuDIfPunLGN2Q5d2pNIofJuV95FoCBGC1HengBqnMuLR7Y6IE6V49YtTpeiJIzZP/eRnk+29AIGZynYD5NAJDCEwETrmBXZfejgy15t4KMZHhD4xQwBPzAA1mqVnIkheJvZ+SSv2uEnyzpZORSEx0GIw2aPQRAXLcx6cJZnI41l7ylXXm1bsz3m0gGR0+r1JFZ/rs1Yp+zT3QSzvt6PC5YtpCoWN8qzVK3eaVM6iUsQSmXA4H+VMjHfqSaylXcDjTMM7xwI4hRMvFEaRJ9BU83tAXwT3+NskK38gdjegmIzig8aGTVwojawG0RfkDu/sbiqyhRMoGlBhWzWCFxEvqTp+jyV8CZj6/rHIig4juN4u3UaRTwrOUQPLj9h9n/mBP7Aid5si4NCQr2zVLqCp9BOY6ggDYDJ66hE+C7gYwiqhbhEmt+oTNj0FMqTdvXBsj/Pw8BobWUJM14GyzPzZ39CSRxmEgnOaHdZk77FxuW4zQW42LtdXorIyapBefPEXaG5WEK++zVb
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39860400002)(376002)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(5660300002)(2906002)(7696005)(38070700009)(4744005)(478600001)(26005)(6506007)(316002)(71200400001)(9686003)(107886003)(110136005)(66556008)(76116006)(66946007)(64756008)(52536014)(66446008)(66476007)(4326008)(8936002)(8676002)(53546011)(41300700001)(83380400001)(86362001)(122000001)(33656002)(55016003)(38100700002)(82960400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TWNBalZ6OHZKUlRsNUVQNEZHQ2YrVExJdWdwaXRSb3d3MXhlVDcyQlZEbEVJ?=
 =?utf-8?B?c3psSUxVOWtjbDZtWDZLWDNYMG5HdUp6TThvRVlWUUE5YVpiSldRaUozRjhD?=
 =?utf-8?B?c0VEZkdyNDdMMFRxLzNqS1JlN0ZweE8wUGc5N3pSNXF5SmY2VElzc1UyYmlJ?=
 =?utf-8?B?bWdlSDUrWHV0ZmhFbCtNTHJYZ3NxYXhsc0hmR0lSS0ZHR3FBTFZJam52YTAw?=
 =?utf-8?B?c3c3SXRlUHJNUjFUcXRvUjhzWnRka1F4QUVIaXkzck0ray81UzB2TkRzY1lu?=
 =?utf-8?B?Q29GSzRNTHcvK3ZxRjNyR1NweWQxVGlYTmdnaUJNWHRUZUpFOW5kOEh1WC92?=
 =?utf-8?B?dkRRYmhJQXdhdmJQZnFMTWw1OWdGZVhDS3loR3N2YzFncm5wa1l6VkdrSG9t?=
 =?utf-8?B?R0hOYklqZVRGeDVPWWg0VlhOZHgxU2NtTE8reWVJMUU5MkV5dlBRR1gweGw2?=
 =?utf-8?B?NkpZcmorSDF3QU0ySWJGdktTN3AxT1E3ZU5tZUR0WUI1WTVObzFOdUtOZHZ4?=
 =?utf-8?B?S2xVOEd4ZVVJbGw2RWtjWW91VHRmcGNEbVVhODhBY1NpL3MwUUVYTFVqMnl2?=
 =?utf-8?B?ZFVXVW1sSnJacTZ4TXJ6SFZyK3Z6d2dmckkwSmI3WElmN0Q4VUY3eHE0bVNZ?=
 =?utf-8?B?N25yWU5QL1lKMWVLZ1R0cVdFUXRUeG9LRFQrb1djRE83TUtzWWJNbTlOc3No?=
 =?utf-8?B?V1BwWkhWb3FPN0JSU3JPbmtZcjFIcGl3L0tVeFB0MWFBS0FYa2xzWGMwdWJZ?=
 =?utf-8?B?Mmd3T292Q2tlVkozZFN1V20wZXozZ3Q3N3ZXaXRrWTViblFSRjlrVG5qcHlu?=
 =?utf-8?B?bVF0RkR1OEU2b3ZVaHN6dlNUN2RzNEFsV2ZQbmc1c0xiTXovRlB3aUdSc1E4?=
 =?utf-8?B?UXhwc0tUaEorKzFJWmVZQXIvTngrclhoa21HYWx2SnREd2d3LzRCUi9jQ01t?=
 =?utf-8?B?Qzd6TEp6YVVRTmx3UUdVRUNkNVdScHhpWXpmMEVFaE5OeGZHZmhOYzlvUDF4?=
 =?utf-8?B?UnM0TFJEK3RaT2dpcGllWEM1TVJyeGVhQ0dxSXZxZDBSUlFscGphL0RmT20r?=
 =?utf-8?B?WjNRNEVDR21EbUN5aW8xR2tBR3V0ZEtpNFY0cWVBUzd0anh1Tng5VFI1SnVn?=
 =?utf-8?B?MDkyNWl6SVpHUzZnRDZKYjEwaFBnRGZmL0JLQkJMTUNXa3NPZGNwcDBVL1ZL?=
 =?utf-8?B?SU93eGpIU0tBRExzNDRiRzlSQTJJdjExWksrOUpmSmZUNnViYmZkcmMzRDds?=
 =?utf-8?B?bjc2MDQxVjNpRzlweGNTVDZHMU02UzgvSDMyZEI2MElZUkg1aW9SQ2dIYkFX?=
 =?utf-8?B?eUhhV0I4Q24vMEFwSEZrQk9NNklLTklNZHBOTXlVR1lYSHJIZGh6MkhzeURV?=
 =?utf-8?B?T1c0TE1LTFB3RktPOCtsSlZxVHpZYUMrSVh6V3FJekVNZzZRcTQ4V3dHeGc3?=
 =?utf-8?B?MXZBQlFqYjFHUWg3RkFvT3NEdG1zL2dkWjNBc2lFenhIZmVZNDR0OUNSNmxa?=
 =?utf-8?B?MXJlWmVGMm4vTU5SNWx6M3A0YlBzSlc4TmFuMEhPZUJLdW5Vb1BSQzMwdXVH?=
 =?utf-8?B?d2cramI0SlUzNkVNM0NWaXBpNG1GN1ZSNlZTSjhqM1FCQWNpdTNRd24wODZG?=
 =?utf-8?B?UzVOTWZJN3EyOHhiMmdaVHhRdVJ0WUx2Q3djUDRmamdDdUl4M256TnNiVFpl?=
 =?utf-8?B?K1lJczYzZTRsWU5uRkM5RkNLUUFlTkNpUG9OeHpvcnhrdzEvazF0dUxzZGtW?=
 =?utf-8?B?bUN4SVF2dThXb3MwVmMvSERyTklMR1RPR2xCSXpHdnlHZitYRUhJK1IzQjRh?=
 =?utf-8?B?ZTBZUEJEbC92OFVoVlRBK3JoK3lrTG91YnJQdkNNbXZRcjdvSDViUTIvNmZ2?=
 =?utf-8?B?RkdpQnp1eFB0bnVzODUwRGhUb0xKOWxKaDMxZ2VYZXdXS0JpQjc5SkIrK2JH?=
 =?utf-8?B?bDBCUG5tdGl4UUVNWTRqdmcremdTejEvN2VDM2g3ZkRHSm5keWtmUGJ6dnJ4?=
 =?utf-8?B?QkJyVzZyZmJPZzFiODM4bE5LZlZpaUYzUHRJS1d1NHlWa0tyc3U3bXM3VUNW?=
 =?utf-8?B?WlU0R0E2L0p5NTJPT1pmU0pEWm5pYUFGTUlvUWRkdzNSZHVwSVhrS2ttREx6?=
 =?utf-8?Q?qAII0za0hLiYePKEtnUk52I18?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: eabcd725-5ff8-49f0-8e47-08dc2e18d2a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 11:25:32.7621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YmfsAJKOS7FATLgAr83jRhhFFMmsIoDHmt7Mb08U+gsWjWxAJ9zVjeRdLD+gOc4Y6/z9e469bU93OYRzjuXZOAKc37Xs1/ouOaitWl6AM8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR10MB6881

WWVzLCBncmVlbiBwaXBlbGluZSBmb3IgYWxsIGJ1aWxkcyBhbmQgdGVzdHMsIHRoZSBjb21wYXQg
dGVzdCBydW5zIHN1Y2Nlc3NmdWxseSBsb2NhbGx5Lg0KDQpDbGFyYQ0KDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEJlemRla2EsIEZsb3JpYW4gKFQgQ0VEIE9FUy1ERSkg
PGZsb3JpYW4uYmV6ZGVrYUBzaWVtZW5zLmNvbT4NCj4gU2VudDogRG9ubmVyc3RhZywgMTUuIEZl
YnJ1YXIgMjAyNCAxMDo1Ng0KPiBUbzogS293YWxza3ksIENsYXJhIChUIENFRCBPRVMtREUpIDxj
bGFyYS5rb3dhbHNreUBzaWVtZW5zLmNvbT47DQo+IHhlbm9tYWlAbGlzdHMubGludXguZGV2DQo+
IENjOiBLaXN6a2EsIEphbiAoVCBDRUQpIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHYzIDAvNl0gQWRkIDMyLWJpdCBjb21wYXQgc3VwcG9ydCBmb3IgYXJt
NjQgdG8geGVub21haQ0KPiANCj4gT24gV2VkLCAyMDI0LTAyLTE0IGF0IDE3OjIwICswMTAwLCBD
bGFyYSBLb3dhbHNreSB3cm90ZToNCj4gPiBIaSBhbGwsDQo+ID4NCj4gPiB0aGlzIGlzIHRoZSB0
aGlyZCB2ZXJzaW9uIG9mIHRoZSBzZXJpZXMgZm9yIGFkZGluZyB0aGUgMzItYml0IGNvbXBhdA0K
PiA+IHN1cHBvcnQgZm9yIGFybTY0IHRvIHhlbm9tYWkgMy4NCj4gPg0KPiA+IFRoYW5rIHlvdSBK
YW4gYW5kIEZsb3JpYW4gZm9yIHlvdXIgY29tbWVudHMuDQo+ID4gQ2hhbmdlcyBpbiB2MzoNCj4g
PiAtIFNxdWFzaGVkIHBhdGNoIDIgd2l0aCBvbGQgcGF0Y2ggNSAiVXNlIHN5c2NhbGxfZ2V0X2Fy
Z3VtZW50cygpIi4NCj4gPiAtIENsZWFuZWQgdXAgcGlwZWxpbmVfZ2V0X3N5c2NhbGxfYXJncygp
IGFuZCBhZGRlZCByZWFzb25pbmcuDQo+ID4NCj4gPiBCZXN0IHJlZ2FyZHMsDQo+ID4gQ2xhcmEg
S293YWxza3kNCj4gDQo+IE5vIGZ1cnRoZXIgY29tbWVudHMgcmlnaHQgbm93LiBUaGlzIHN0dWZm
IGlzIGZ1bGx5IENJIHRlc3RlZCwgcmlnaHQ/IElmDQo+IHNvOg0KPiANCj4gUmV2aWV3ZWQtYnk6
IEZsb3JpYW4gQmV6ZGVrYSA8Zmxvcmlhbi5iZXpkZWthQHNpZW1lbnMuY29tPg0KPiANCj4gRmxv
cmlhbg0K
