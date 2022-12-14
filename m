Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4606C7B
	for <xenomai@lists.linux.dev>; Wed, 14 Dec 2022 02:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670985066; x=1702521066;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=cDwMvX/cBmvmXPE+4BOfYkTaeuhllHBjKpZQ/Ft/q1E=;
  b=cGablOSVbI012Var54lrf3+3Q/Yay4JjPRdBOKZdk3KK5yVye2X2/UuW
   tQ+SiVEpm0BRsbYBWCaIhlyQP4Z/JtkBIAUaELdSEGvUu7OTaInuL1TsM
   dzre6tF+FlbvYfKXe5JUNYRr7NjYUfSTs85nXmtoU9zEH+B9UwNdfeE1m
   AXYKdKSkaWLKzJNfYpaFt//SZATe/va4z84bAtCz1rfnzB8Ds/C1O3ek/
   GBS3nffJrsJAKTqcFuo/QuOxyLtLJeSnpsBo7gy2SPf3Kxwiu/px+a3lg
   z5UvQesV1dnfKlcy9/8HnQAY7Rgnmyd2QKPMQ7WaSUHnPgqRPtloUJ47M
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="318335442"
X-IronPort-AV: E=Sophos;i="5.96,243,1665471600"; 
   d="scan'208";a="318335442"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 18:31:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="823104613"
X-IronPort-AV: E=Sophos;i="5.96,243,1665471600"; 
   d="scan'208";a="823104613"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 13 Dec 2022 18:31:05 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 13 Dec 2022 18:31:04 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 13 Dec 2022 18:31:04 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 13 Dec 2022 18:31:04 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 13 Dec 2022 18:31:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifz7KAuR/PRg879lOEbGLHOM3mxc4ifoa7aCqrL5eqQQSKFa9WIUKsbwvwjbOQ3yadQEcdvRXCSPKOLXfm1wSuamarrxw2f8zyJQ1TEgnrUbZHFMxeaGlIcCWfM11mmIKRx+k1f8twAzdVphDaPvz2CTfgBp0JSlmniJ4APrpfJel9A8bTumLFuw1oOWLEa+0c4J3nlu5+S/QudSu+HhUlnniUHY54NARZUIjAjMt0SGwPZOH7xTkn5qH7QYmiKjUo3GegJZmWhc/rGYSGIYqOdpuh5ocz1bQ50F4bU3t89NWGax+toPkl/UqxCcR1SQ1Ir0MraN//WtrWxXy1BxiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDwMvX/cBmvmXPE+4BOfYkTaeuhllHBjKpZQ/Ft/q1E=;
 b=Y7XZ9zlw2+u3lX5W5cJXH3ag5pVyC3o+CdkdypKGKxnp58eFyS7ISbSeSPhXqacIUII3WjanqKk8V+InabnUzeV5RJr3HUxtBRbBiE6RU2iLcomcafYQXjMZh9jwVKMmmLRB5pDygNHiVFJgOsMbuGf12UQ1oJgIKbP2dcDVhArcxZfE67vwJqUkcsIXrJopZ0a7ZdhwMWC9MNyc07uPTPuaAwHZis/Celk2C4fMtp8hr1a7TAm7RYOlno5zeOTEwpZiu8TAwNYe9ckR7CCjVO79MdVK53897VlwtJ4h5Odns8ZGvsZydgUr0aG7cig1o85i5S1PKydXhs1k3cCrDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by MW4PR11MB7152.namprd11.prod.outlook.com (2603:10b6:303:222::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 02:31:01 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::27cc:d8ed:9947:fecb]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::27cc:d8ed:9947:fecb%7]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 02:31:01 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday,  Dec 14, 2022, UTC
 7:00 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday,  Dec 14, 2022,
 UTC 7:00 AM
Thread-Index: AdkPZAjdGt/WYXFpTACvMcPNBmKJSA==
Date: Wed, 14 Dec 2022 02:31:01 +0000
Message-ID: <MN2PR11MB4285BDEEACED1195EAC700D3F2E09@MN2PR11MB4285.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|MW4PR11MB7152:EE_
x-ms-office365-filtering-correlation-id: 70f4f18a-1a08-4abb-b6e3-08dadd7b3d9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KA6s5KIMmfm1yJ/KirS6u4H1oOCuX6l5Z/QGvQm20Fwpr5hWD3YJNl30E9OHnqxE68/hgIvTkZsG4RYceVSR3jFCWBoEQOPWNJiWMdXJ1PlBZCvRaV2BavcnlCLtjWLhRhyT3EvM6/4PSXGCzS1UkHYyjWTM2gSs4rN3C+pMipk4dMcR8+MXC4quDJY+/0TRv4maRRbLWcJcYKpqGcd3BfTAAsNUGgdjK3NrEuUbOoqHMK1MwVW8mVZDOA+7hwqOTyzkQ1P6YER9Bc13FJsnkzlAneEPfmvW8Ijc0XIDB8D6B59wAxdBHrpcZ6npInF+QPha1nqbGMnwWDx3pKacrnpWPqWm4ltqm8lB0xx0W301eJLeDryxny6Up/KW3/uIOwQR5I1uF5/5AKdjtA5ddVzM+YQhnKhSUMw6c+42aflJukFS4zEJ85sU80ZS9e4n/ZEEYmX5fZdLjCXjfXypwGDq4g3zj1iiEbYe/Pobn2uhuDr+CjOm+3vni/ajmnV2Db/g8aFxuRwa6U7hHH3ybDVNWsVU3rAUeBMPfyoaU/5n3Pgl6s/Xo550NchLsiK+qQ4f0zz99IWFGElNRMJ/In1BBTj5OcTuiGEU8ZdzlefwMbbCm+VS1p+pyMWUkLXmmv3I2gn6N8PKnYxag0kyfSx8ty3SgHNBdl0n7VicWz/AgTWy4nA0QoLtlQ3h4n1NYxlZF4QJiysmqxdgXBCwBdcsSRp3XD0Ohat0RKnb4iltSREeiTj/onastqvu4tjcQd+hYIriiU4j5zyavvKzUg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(376002)(39860400002)(366004)(346002)(451199015)(2906002)(66556008)(40140700001)(33656002)(76116006)(64756008)(66446008)(122000001)(186003)(66946007)(8676002)(66476007)(5660300002)(41300700001)(52536014)(8936002)(26005)(71200400001)(6916009)(55016003)(316002)(478600001)(38070700005)(82960400001)(9686003)(7696005)(6506007)(38100700002)(83380400001)(86362001)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnJkdFN6RFBUSjVITlZuQzIvYVpZZUZaQSthaytiVWxlZE9DSVNCR2ZlUjZ2?=
 =?utf-8?B?UDJpRUxhQzF0UWZ4NEczanVSeEpoKzB4VFMxbFZYZ04yZ0FmN2xEYkdlUmpl?=
 =?utf-8?B?U2lSNUttb3ZEK3NjZml0MG1oMGZIVEQ0SUpSZmJyNDM0bXFhY3dha1Vmbkw5?=
 =?utf-8?B?dUJvc2lhM0R6ZnI0UkR4ZDlVZ2RlVllJWmw4QXVhL01BM284dVZvSlR2TFVn?=
 =?utf-8?B?VmRZVDBIQ3Y3dlBZdGloTnEvRkVjdWxUa3Z6WGRCWjBZcEQvSmdJMERNRnZH?=
 =?utf-8?B?YjRydHUxTldHcUMvc3JCaUhTVkdIeERzSDR0SUx2VWFHRTducUhvejVCeUZi?=
 =?utf-8?B?UjkzQ1F1MFVHWXlVWTl1NzlTQjZJR1FkYStmSnUzeUlOc2UrbDNiNUN2YUtT?=
 =?utf-8?B?aFhXMXEyVUhIY2k1ZVIvYkNIRmUrOG10cWtyR0xnTXNzdmgrdFE2NHh0UkU1?=
 =?utf-8?B?eEc5ZGcwRGh6QzRrYk5LR2xYYmVUdVVRdHQ4K0JHRDQ0N0g1djZCeUhWNG95?=
 =?utf-8?B?ZWRtd0ZVVm1pWEtFOGFlWCtTclc1QVhUT0wyRU0rWDVuZUIrbHIvSWhIR0Uz?=
 =?utf-8?B?bkNKRVA1UWY1YlZLZWVQQ1pjUWFGaGc3ZUd4QUtYUHdCbGs3aWhpNkw4Z0RD?=
 =?utf-8?B?aDlaUkxhS0lrblZsK29aNkd3WlRLeUo3cFVSbUdhV1o1YURFd2ZVdEVaSjNC?=
 =?utf-8?B?eEQ3YkFKTWNNdTZwS3FtQ0FqMnI2b1p4cTRKUTN2ekR6eHhLc01lT1QxRU1U?=
 =?utf-8?B?NndlbW9wUzkwdnJFZ1d6Uk5PeEMwNGIwMWZKUzNoWmRhOXpPT3U2bURNMFVN?=
 =?utf-8?B?blNZL1Zobmk1eXE5MDcyMnExRDZCSWZjMXA0Q1N6K3FodU9WSlJJaVV6T1Aw?=
 =?utf-8?B?QXQ3SEovNWh1WHc5RE5yYkY0RGR4MW9lc0NqMXFDTm05WE0xanpTUGNRRTQ5?=
 =?utf-8?B?WUxnbllWSXRzWTFtYWV4Ym9STEQvclF3OGIxZWVBQmt1V1QwWEJOdUZ4b2Nw?=
 =?utf-8?B?UEpIYkM1dWhOVW1Xd21IRFNkQXpKcy9IN1JkYzVlWkdYS0Fvb0pTalcvK1U3?=
 =?utf-8?B?UGhoNXRzNWhIUDRnb21aUCtrK3A0Q0FKVitOa0FhbWdoVmpQazYwSUs3ZUx3?=
 =?utf-8?B?dXhtREdRVDJRS1ZqRVIwRFBXYUNCSC9PWGd3S0RaOEkrN0NkYW15VS9hRG81?=
 =?utf-8?B?eGQ3ODdQSkMxM0JUNitLNGthcGZ4NkJTSFY3SmdCYUl3ZW5TQTZJVDNaVHd4?=
 =?utf-8?B?cWtKRnk2Q2xpWGQ3bVU4QitPQ2t1OFM4SGl3ZXZTSTUxNXZiOFBzOU4wbTRT?=
 =?utf-8?B?M0I3Mkw5azVydVgvOUEwQm9QcHRiWlNHZmZ3QUR6WDI3d1hocnAyL1dTempT?=
 =?utf-8?B?VXA4TThFOHkyQ2RKdEl6RWsrNjM1ZndRRFhHTEVKLzdwM014aTlrRHpMcUM4?=
 =?utf-8?B?NXV1ZndrZEJpOXNuMXVNLzVOUmNEZ0pxSTFONERpL2dhbU40SlR1Y3lmbTQ5?=
 =?utf-8?B?dDQxOERDZ2pwVFJ4cjV3WVNJcTRBTkZGM2xZUlVGaWVPU2dVZXcwb0xTTHZZ?=
 =?utf-8?B?eUlxdzNjUGJ2T2pHd0NJL3NSc2tVVVRydzJBZjNQS08xTktuRHlHRlJEdmU0?=
 =?utf-8?B?ZFJSYndSNUlOSWozU2Q5elpWNGRqUVo2K2ttMzl2OXc3ZWV0R3U4R0dZK2Vq?=
 =?utf-8?B?Q2p5TWtoZmNoMWE4TmcxbytiYkwrMTZ6VTNURDA1RjJsdVVkb3duU29TTFNW?=
 =?utf-8?B?amhzNkV6R1BZVWRDc0VhMVVQRkpxV3J0eUY2ZnRXZ2tBVkt2cjlJR2Z0bllM?=
 =?utf-8?B?RGVlZXVoWEJRL1ZoRkY0OFdBbmN1aTU3ME5reUVRNTg0dWV1ZEZ6YWpBQklR?=
 =?utf-8?B?a2dTVm84UHduV1NveWplRzduRkxpM0hCb1JCazNaRlhFc2VtY2lWVmtrdzhF?=
 =?utf-8?B?TFJPTTVjcVpzd3FBcFFydzdYRWQxZDlqL2s2SExTRG9KQ1ozNmk4a0Nud041?=
 =?utf-8?B?czlxd1VkeHJSZ2x3bGJURjZnV1V5ZjVWcmxFQkdRdkVCSjU2TUJqVndjZTd5?=
 =?utf-8?B?cElTTU9hcEwxTkN5alR2eHZZT09aaHpyU1RiT1psR2p6V0FUYmwxbEtsNzFL?=
 =?utf-8?Q?gopQhHcweYynGhAZj4oUwXyrE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4285.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f4f18a-1a08-4abb-b6e3-08dadd7b3d9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2022 02:31:01.0470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /34pOs6NZMkCmAvv3b7SrLzffgbuI0BVLh9yluC8aHrSNEnfAgcWFqhnw7a0AQEizDCntmLJM36AXsfLIPhq3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7152
X-OriginatorOrg: intel.com

V2UgaGF2ZSB0aGUgWGVub21haSBjb21tdW5pdHkgY2FsbCB0b2RheS4NCg0KVG9waWNzIG1heSBp
bmNsdWRlIGJ1dCBhcmUgbm90IGxpbWl0ZWQgdG8gdXBzdHJlYW0vZG93bnN0cmVhbSBwcm9qZWN0
IA0KcGxhbnMsIHN0YXR1cyB1cGRhdGVzLCBhbmQgdGVjaG5pY2FsIGRpc2N1c3Npb25zLiBJdCdz
IGFuIG9wZW4gb25saW5lIA0KbWVldGluZyB0aGF0IGFueW9uZSBjYW4gam9pbiBhbmQgYXNrIHF1
ZXN0aW9ucy4NCg0KVGltZToNCldlZG5lc2RheSwgRGVjIDE0LCAyMDIyLCBVVEMgNzowMCBBTQ0K
UGFyaXMsIEZyYW5jZSBDRVNUIDg6MDAgQU0NCkNoaW5hIENTVCAzOjAwIFBNDQoNCkpvaW4gWm9v
bSBNZWV0aW5nIA0KaHR0cHM6Ly9pbnRlbC56b29tLnVzL2ovOTEyOTcyNzkyNjk/cHdkPVdtZHdT
MHBET0RSTk1TOXRRazU0WTFkdmJGbHFVVDA5DQpPcg0KaHR0cHM6Ly9pbnRlbC56b29tLnVzL3dj
L2pvaW4vOTEyOTcyNzkyNjk/d3BrPXdjcGs1MmE5Zjk2ZDk4OWU3ZTIwYjYyOGMyYzM2ZTQ4YjY4
ZQ0KDQpNZWV0aW5nIElEOiA5MTIgOTcyNyA5MjY5DQpQYXNzY29kZTogMzY3NTI4DQpPbmUgdGFw
IG1vYmlsZQ0KKzEyNTMyMTU4NzgyLCw5MTI5NzI3OTI2OSMgVVMgKFRhY29tYSkNCisxMzQ2MjQ4
Nzc5OSwsOTEyOTcyNzkyNjkjIFVTIChIb3VzdG9uKQ0KDQpEaWFsIGJ5IHlvdXIgbG9jYXRpb24N
CiAgICAgICAgKzEgMjUzIDIxNSA4NzgyIFVTIChUYWNvbWEpDQogICAgICAgICsxIDM0NiAyNDgg
Nzc5OSBVUyAoSG91c3RvbikNCiAgICAgICAgKzEgNjY5IDkwMCA5MTI4IFVTIChTYW4gSm9zZSkN
CiAgICAgICAgKzEgMzAxIDcxNSA4NTkyIFVTIChXYXNoaW5ndG9uIERDKQ0KICAgICAgICArMSAz
MTIgNjI2IDY3OTkgVVMgKENoaWNhZ28pDQogICAgICAgICsxIDY0NiA1NTggODY1NiBVUyAoTmV3
IFlvcmspDQpNZWV0aW5nIElEOiA5MTIgOTcyNyA5MjY5DQpGaW5kIHlvdXIgbG9jYWwgbnVtYmVy
OiBodHRwczovL2ludGVsLnpvb20udXMvdS9hVEVBMzdpNUcNCg0KSm9pbiBieSBTSVANCm1haWx0
bzo5MTI5NzI3OTI2OUB6b29tY3JjLmNvbQ0KDQpKb2luIGJ5IEguMzIzDQoxNjIuMjU1LjM3LjEx
IChVUyBXZXN0KQ0KMTYyLjI1NS4zNi4xMSAoVVMgRWFzdCkNCjExNS4xMTQuMTMxLjcgKEluZGlh
IE11bWJhaSkNCjExNS4xMTQuMTE1LjcgKEluZGlhIEh5ZGVyYWJhZCkNCjIxMy4xOS4xNDQuMTEw
IChBbXN0ZXJkYW0gTmV0aGVybGFuZHMpDQoyMTMuMjQ0LjE0MC4xMTAgKEdlcm1hbnkpDQoxMDMu
MTIyLjE2Ni41NSAoQXVzdHJhbGlhIFN5ZG5leSkNCjEwMy4xMjIuMTY3LjU1IChBdXN0cmFsaWEg
TWVsYm91cm5lKQ0KMjA5LjkuMjExLjExMCAoSG9uZyBLb25nIFNBUikNCjE0OS4xMzcuNDAuMTEw
IChTaW5nYXBvcmUpDQo2NC4yMTEuMTQ0LjE2MCAoQnJhemlsKQ0KMTQ5LjEzNy42OC4yNTMgKE1l
eGljbykNCjY5LjE3NC41Ny4xNjAgKENhbmFkYSBUb3JvbnRvKQ0KNjUuMzkuMTUyLjE2MCAoQ2Fu
YWRhIFZhbmNvdXZlcikNCjIwNy4yMjYuMTMyLjExMCAoSmFwYW4gVG9reW8pDQoxNDkuMTM3LjI0
LjExMCAoSmFwYW4gT3Nha2EpDQpNZWV0aW5nIElEOiA5MTIgOTcyNyA5MjY5DQpQYXNzY29kZTog
MzY3NTI4DQoNCg0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQo=
