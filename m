Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0C61865
	for <xenomai@lists.linux.dev>; Wed,  1 Nov 2023 02:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NQ1063rM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698805876; x=1730341876;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=JGIZKrrMzb5Lb5xmqxdJZ4w2+PIwcgIZcG9NQYIHu00=;
  b=NQ1063rMW8WLtKIT3IGUncuy0Tog7Q8MNeXRR2yXq9nQ+UO8UPlCwyHY
   pInlRx0/ZrT8KqP9igb84ce5Dz/Ze8VBRGFQCEkQF7EnBKeQUQzUClBPw
   VSCBSQ2KHikeD3N/mXRRabpon7++IwV/DbZtaDG9/jKap07yTb+8Bzwcw
   sQ97p+f8oLIxlR2a07HazHFNdifvuCWx7vs0KDjz40+F9U4PC5LLHToBx
   q9sKO66aHKJaZRv/wxobktaIpLlF8ibVvWww7ZwSPg3T3ixKVMDjVMcD9
   MfNPzrNigsu3H8VJRYB3tPhkjSzdyLJtabMGyCsZDvnGGw+ZnULLFqYSa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="387303133"
X-IronPort-AV: E=Sophos;i="6.03,266,1694761200"; 
   d="scan'208";a="387303133"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 19:31:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="877719321"
X-IronPort-AV: E=Sophos;i="6.03,266,1694761200"; 
   d="scan'208";a="877719321"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Oct 2023 19:31:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 31 Oct 2023 19:31:15 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 31 Oct 2023 19:31:15 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 31 Oct 2023 19:31:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPZR9zEo6uacGAUWv7SDR1QGe/0/btx9oQmArYdPLmk9v6CAHyj3/m0YZ5WMn8EPEPlJ4cAQb5pqi0yVBtB7kXQ6KgG/rEFDJ09OT80+TFf5ewTJTwSvAFg0vNf9+6w+y7Pi0m4ZhnB5f1qGC8xBXN6k5ezKUmBLQckzsxh4GzyzHNnpqd4xEDop1W3cHB9S05k1fER+TAXHg0TmiWKsKxSbFoNtQJS2QANPpsFFaloo0WTLR5omueABQhQmMfNK8OEWovdqG/fJiyw+VKD2qNVfAmi0+yDrd0D71LtX40oBQ0ZTp69itedyvFC1TNOBWns4Gc6nZSNo0rUrd4mmzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGIZKrrMzb5Lb5xmqxdJZ4w2+PIwcgIZcG9NQYIHu00=;
 b=BCx9Ole6VNTRMYVtp2ZZtCOgcOT8xyLsV9dXhH3Txf0iHRJo1M5u8EtW+11380+XJE/CVEyJOr+5qXQArWbjXzYptmWm5HOW3mY4PmG4gwitI17jYb5C9GNHGInBs3ualwjeDmW85iOjcIkZHLkYS1pGtmh8RDIB2PBnjqWYjW/43ky3dRbA7Nskv5c5MZ/Wi7Bp000dMQQGXuPuFCQWKMFiHh6dIr/a4lUoWb+hngO6NeDVoBHX1HmpOdTWLUvUrQ45qpsgofBFU59XOQTL+5oW8YiHSvob8SPMXO4RbvYaT9sHgWXz6be2zcJdEuXwT72gB7feyL+anOLoWXGQyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by SN7PR11MB6995.namprd11.prod.outlook.com (2603:10b6:806:2ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 1 Nov
 2023 02:31:13 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::4d28:3c6a:97dc:154e]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::4d28:3c6a:97dc:154e%6]) with mapi id 15.20.6954.019; Wed, 1 Nov 2023
 02:31:13 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday,  Nov 1, 2023, UTC 7:00
 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday,  Nov 1, 2023, UTC
 7:00 AM
Thread-Index: AdoMa0oDTyeOya28RYKojBUOl1EPWQ==
Date: Wed, 1 Nov 2023 02:31:12 +0000
Message-ID: <MN2PR11MB4285469BB8EFBB032F4F0DECF2A7A@MN2PR11MB4285.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|SN7PR11MB6995:EE_
x-ms-office365-filtering-correlation-id: d295fa18-df72-4efe-5b45-08dbda829dc7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HzYBpbKUhMLcri8wuaIvFyO3DIoIZuvW9/KldpOuwI/X5n4UA1CrC7U2HRuGYXerKiT+tdf9Vc9WdHaFPtu+Ugn+WcQeh8OdlV1tvGmAkb7m/bsQagWK8v80ORD1grDlijHLhSSCVUmH+DfMDoA4bhXsn+KYBBgFX7H0vl3PPdDAqPh6mjxBDz2H0nSrpUno9Ub+GFk+WFBf26QLqKu4j38OB7slOyKUfxLCg8lzxtZG3kMOwVb+iHYn1yeAv3rXpwgLvD9DpJo4VzeEgMgxmRRwyU4qbaDcng3M1pB/LNlTX6o1TGmTSS+UZI1Iku/1btTHDeo2ERYxPEqrS7a9WYY7cNonn7uTxBpnHKBK4tSXYcawjm6yVmDeEX0Z/QENJeiYvS9EjaEjbxj+XgC2maY3aNiWHC1sVL8kKqESlSHKvHZLat9WVNVyUra1XForoSU1BEXsXUpgHI162Pq9gX/1Lk8Pc4LWntVfjJjLKnn6+SmT3mhj32rUkqgVu2mN5kUmecAhaYgC3EISNfbnN683PJFguecxDcpoLwEFwAz87wDLxEA9sXnjW3E3giiwTfHgLS/FTsDfBGDnpIx/Q3Rkp0GzwMlgqJvJSsELPldRKzTqFV05GPQD9FmVii7RoTDG8tT3rJwNwoUOve0UHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(39860400002)(136003)(366004)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(316002)(2906002)(66476007)(5660300002)(41300700001)(52536014)(55016003)(8936002)(64756008)(8676002)(26005)(83380400001)(6506007)(122000001)(76116006)(38070700009)(7696005)(478600001)(6916009)(966005)(40140700001)(66556008)(66446008)(9686003)(33656002)(71200400001)(66946007)(82960400001)(86362001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFh3Mk9OVlJjdGV0a0hZckMyeGkzc2k5UG9FOWV2Z3VIZzBSeHZoNmdEZmF4?=
 =?utf-8?B?SzNsOUFpSFZ0Z2V5OWtDV0huZzI0Mm5LdUhEQ1d5ejQ4ZGhsMTYxdURxL0tu?=
 =?utf-8?B?Ymg4MTh4SjAxWFhMNEpuNTZRT1FUZllUTEZkQU9lSVFtWHpXUC9RNXBQM0xk?=
 =?utf-8?B?cWp6Q3ROV3JuZXRibTZ3TDZqa2xHT0RVK1FwWkwxbzhRZng0cHpaUlYyODFm?=
 =?utf-8?B?aEFFbFdtTVZhWi8xMUxPczlDUCtaMFpLOFpESVdsT0Q4NjFwVzlzRStIZlg4?=
 =?utf-8?B?dElwWDZLT2ozLzlnVWJHRjgwaXU1Z2NPNHN4WWRoNnlKT3BBK3F1YVhFTk50?=
 =?utf-8?B?cGxtZFQzVmlteC83cFl5TnJIWk9qUmpwR1ZPdzNRRDlSWHVvOVdiV3dmZWpy?=
 =?utf-8?B?My9pM1NwTC8rZ0RLWHNUSGpqcU8ycllZS0F3NTEwN3E4eStpcS9CVnVxVk45?=
 =?utf-8?B?c0JKQTJQMTBLemVrb0piVXR2OW5CZXU1eTBFQUx3QTcybXk5UDRBYU9TMlJs?=
 =?utf-8?B?ellyNkNmMU00OThiNmxBbkZqWHJiZGIzRSsyUGhGTWwwMUZUNVR6YXdHb3ds?=
 =?utf-8?B?dWw2Z3h4NVIxWndjaVkzRDI5OTNRNmZpKzN3QU9QQU1KcEhoaUhjSGc1dG5X?=
 =?utf-8?B?ZWNqSVhiTXdsSlp4MThOWFFxYUZMcXRHNGZNN3BwM0RiM1MyRUUvR0VJRUJY?=
 =?utf-8?B?Ni8yb3g4cW5HNmtXamVzd3RKVXpJVi8yMFhmUFNyQWlyQkRlVXR1UEZxZ0VW?=
 =?utf-8?B?MDhjL2p5UHNZbldwNm5qb09aT2tGUUFRcEswZmQ2ZmNtOUxQMUZLVFd0UUZV?=
 =?utf-8?B?ZHdMMUJ6Nm45akRsUHFBNDJnNFBONXNLYUdWQ0lQdmhXN2xkTTZZM1B6Wmkv?=
 =?utf-8?B?M0U5L2lINjM2RlZmODVJZzVJdnZFV1JCaDUvbTQxd0FWclVpMjBTWFQ2eDVP?=
 =?utf-8?B?NERlWGJBbHkraFZCL1BHMERRVGRZY0xwZnpRZVF0czZuelFvUDVpSFpIQjhS?=
 =?utf-8?B?eVp6RnNYcjBJRDBIY04xcHp1UlRsaG5qMTZVc1QyZ1Q3ZEZybUNsQjFJUnFw?=
 =?utf-8?B?L2VCdGIrcDdDczBSMFQ0bVBKTlRIL1djaUprb2VHMnA0WHo2MHlyMHpvZDJ0?=
 =?utf-8?B?NWJCeWpTQ1BVd0VYOTRNVnRuWFZoVXhSbjlxLzZxK3NnSGRyK09Edy9WMC96?=
 =?utf-8?B?TjE4S2V2ZW5sajBzZ1pRSU1mRXpSczlndmNiMVpyaFE0SVVBOUJzZkZ3cTd2?=
 =?utf-8?B?STBEdlJjRE84T0c5RXVJdFFZc2NJYzgwMTF2QlZtbDhsbER4Ykt6d2t0Snlo?=
 =?utf-8?B?SHI3QkxqUy9ZWVZySEZTVGhiOGFadFNYd0ZKbzNSYVVYRE9sNWR3VXZKSUEz?=
 =?utf-8?B?THh0d2QwaEJ2YnY2UDFvMjRQeWYvN2w4ZWFkYUxBaU9hLytJVHkzYWMrcFJq?=
 =?utf-8?B?c1MzTFFweG5lZXVmREcrYjZNUmk1RU1nUFJtN1pJekFqMWhqVXhERnM3TDhq?=
 =?utf-8?B?RU5CVXBhTmdCS3VxQllqZ1hVVm9qNmZ4bVNnNG4rcnliWTd5alB5RUtKblVO?=
 =?utf-8?B?a1BXZmhVNGNrTWgzejliYkVoOWd5NGw3L3hoUmNRc3cyNkh0VWFhdm1EdmUx?=
 =?utf-8?B?OEVEaUNpYkxXT0JKV0JSVTZEWHRVbEN2K1NPVk1WRytzZmpzZFBkSmRqNnRX?=
 =?utf-8?B?VDVKSFFLV0FzN1dtVCtEQjRzQnFINEZXNWJzLzhvRFh5VC9zblMxQmJDOUxw?=
 =?utf-8?B?MUtYZis2YjRUc1ZidTgyQ0VzY29DY016Wkd5SzNjS0I1SHVRQTBPT0xDNDZX?=
 =?utf-8?B?Z1dSVEI0ZmEzczhleEZSM2VsQThFU1o2UjhhSlJmaDcrdGE0bVZaaDR5UkZH?=
 =?utf-8?B?cXpOZUd3Wm03b1dmUzNKdGluTzVGWFF3L3p6WmdFczNxTjNsSlV0M1MxZ1Rl?=
 =?utf-8?B?NmZrNTZ6UGFVVDZyY0VQMWM5QXU0elFaZ3JKV1ZRUEh5ZHZzZmxON1pFMC9Q?=
 =?utf-8?B?cjFYMXhiU2REN20xcTNmTWl0cHMvamMwd2pVVDMzR3g3aHM3V1Z2V3U5alBm?=
 =?utf-8?B?OHhKUXIzMWFnTnZJcXVwNDVRd0dOV2F0aTEwSDJhZVFZT1VJcC9nUWE1NkRj?=
 =?utf-8?Q?nfjHIiGvSjsjrlpwUHDnrGS1Q?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d295fa18-df72-4efe-5b45-08dbda829dc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2023 02:31:13.0197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hWA2rPbjnxfdWr8Y3/SUJEZwlpSg3yBQSIRZHdw9QUKqs8pkavIw447JekKbz65PxgsTxOZVFJa30DjTv3wk6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6995
X-OriginatorOrg: intel.com

V2UgaGF2ZSB0aGUgWGVub21haSBjb21tdW5pdHkgY2FsbCB0b2RheS4NCg0KVG9waWNzIG1heSBp
bmNsdWRlIGJ1dCBhcmUgbm90IGxpbWl0ZWQgdG8gdXBzdHJlYW0vZG93bnN0cmVhbSBwcm9qZWN0
IA0KcGxhbnMsIHN0YXR1cyB1cGRhdGVzLCBhbmQgdGVjaG5pY2FsIGRpc2N1c3Npb25zLiBJdCdz
IGFuIG9wZW4gb25saW5lIA0KbWVldGluZyB0aGF0IGFueW9uZSBjYW4gam9pbiBhbmQgYXNrIHF1
ZXN0aW9ucy4NCg0KVGltZToNCldlZG5lc2RheSwgTm92IDEsIDIwMjMsIFVUQyA3OjAwIEFNDQpQ
YXJpcywgRnJhbmNlIENFU1QgODowMCBBTQ0KQ2hpbmEgQ1NUIDM6MDAgUE0NCg0KSm9pbiBab29t
IE1lZXRpbmcgDQpodHRwczovL2ludGVsLnpvb20udXMvai85MTI5NzI3OTI2OT9wd2Q9V21kd1Mw
cERPRFJOTVM5dFFrNTRZMWR2YkZscVVUMDkNCk9yDQpodHRwczovL2ludGVsLnpvb20udXMvd2Mv
am9pbi85MTI5NzI3OTI2OT93cGs9d2NwazUyYTlmOTZkOTg5ZTdlMjBiNjI4YzJjMzZlNDhiNjhl
DQoNCk1lZXRpbmcgSUQ6IDkxMiA5NzI3IDkyNjkNClBhc3Njb2RlOiAzNjc1MjgNCk9uZSB0YXAg
bW9iaWxlDQorMTI1MzIxNTg3ODIsLDkxMjk3Mjc5MjY5IyBVUyAoVGFjb21hKQ0KKzEzNDYyNDg3
Nzk5LCw5MTI5NzI3OTI2OSMgVVMgKEhvdXN0b24pDQoNCkRpYWwgYnkgeW91ciBsb2NhdGlvbg0K
ICAgICAgICArMSAyNTMgMjE1IDg3ODIgVVMgKFRhY29tYSkNCiAgICAgICAgKzEgMzQ2IDI0OCA3
Nzk5IFVTIChIb3VzdG9uKQ0KICAgICAgICArMSA2NjkgOTAwIDkxMjggVVMgKFNhbiBKb3NlKQ0K
ICAgICAgICArMSAzMDEgNzE1IDg1OTIgVVMgKFdhc2hpbmd0b24gREMpDQogICAgICAgICsxIDMx
MiA2MjYgNjc5OSBVUyAoQ2hpY2FnbykNCiAgICAgICAgKzEgNjQ2IDU1OCA4NjU2IFVTIChOZXcg
WW9yaykNCk1lZXRpbmcgSUQ6IDkxMiA5NzI3IDkyNjkNCkZpbmQgeW91ciBsb2NhbCBudW1iZXI6
IGh0dHBzOi8vaW50ZWwuem9vbS51cy91L2FURUEzN2k1Rw0KDQpKb2luIGJ5IFNJUA0KbWFpbHRv
OjkxMjk3Mjc5MjY5QHpvb21jcmMuY29tDQoNCkpvaW4gYnkgSC4zMjMNCjE2Mi4yNTUuMzcuMTEg
KFVTIFdlc3QpDQoxNjIuMjU1LjM2LjExIChVUyBFYXN0KQ0KMTE1LjExNC4xMzEuNyAoSW5kaWEg
TXVtYmFpKQ0KMTE1LjExNC4xMTUuNyAoSW5kaWEgSHlkZXJhYmFkKQ0KMjEzLjE5LjE0NC4xMTAg
KEFtc3RlcmRhbSBOZXRoZXJsYW5kcykNCjIxMy4yNDQuMTQwLjExMCAoR2VybWFueSkNCjEwMy4x
MjIuMTY2LjU1IChBdXN0cmFsaWEgU3lkbmV5KQ0KMTAzLjEyMi4xNjcuNTUgKEF1c3RyYWxpYSBN
ZWxib3VybmUpDQoyMDkuOS4yMTEuMTEwIChIb25nIEtvbmcgU0FSKQ0KMTQ5LjEzNy40MC4xMTAg
KFNpbmdhcG9yZSkNCjY0LjIxMS4xNDQuMTYwIChCcmF6aWwpDQoxNDkuMTM3LjY4LjI1MyAoTWV4
aWNvKQ0KNjkuMTc0LjU3LjE2MCAoQ2FuYWRhIFRvcm9udG8pDQo2NS4zOS4xNTIuMTYwIChDYW5h
ZGEgVmFuY291dmVyKQ0KMjA3LjIyNi4xMzIuMTEwIChKYXBhbiBUb2t5bykNCjE0OS4xMzcuMjQu
MTEwIChKYXBhbiBPc2FrYSkNCk1lZXRpbmcgSUQ6IDkxMiA5NzI3IDkyNjkNClBhc3Njb2RlOiAz
Njc1MjgNCg0KDQpSZWdhcmRzDQoNCkhvbmd6aGFuIENoZW4NCg==
