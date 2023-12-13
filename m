Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F1C139D
	for <xenomai@lists.linux.dev>; Wed, 13 Dec 2023 02:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nuJ+geOJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702433428; x=1733969428;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=9YMuDxFNVAXhyvbc+XMyBRrwNDqNxHnFTU/HdY7j810=;
  b=nuJ+geOJGWYYLSLTbG54pegVT+2n3znalZ+e9tHyawHlJNkDGvB9z73B
   8Luh+98SdHv93Zjlc1skmOjEs1Z5H2C8DpNa2qg2loyNDl0RfjbfSbLnK
   bkuyYubzjfBGGBBkc1zkkyhbnP0dUN/e5R9HBOkpWS/aX+l87N+Me/JbC
   h0BCBigak0V5ndK7s9USoQy7PaZ027/Ga+PPwX3x6tUHCP1dtBcYF83nS
   GQjxjcLjrJZYwJ5RMEFGSxBwJ8tBphjPIYLgVtmIcwqKpkTft9lqJpNoS
   uw22AmcC8s4TEfvwD+MtJ2CQr6ULBETzGUdrrAZJLkb00PSoQjOezzChY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="13596587"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="13596587"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 18:10:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="947004189"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="947004189"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2023 18:10:26 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 18:10:26 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 18:10:26 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Dec 2023 18:10:26 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Dec 2023 18:10:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NyYu1UIRfFGDx51TjQKUdlPIxYflt6iQb+KMkwjaPSoM8JVjerc2S2v7UJP5u2f+J10ELlMeJmGawOE8mfzaDm3UiTohHF0E+320r/p8vZIfssWhCfoYjLFZ2F2YXurFpSjgqHGu84WL6SSEg6JFm+XQQM4mqGgR+hMWm6VT+pxzfWXP6Z5Sa3h6OSsD0GF0VOXnQlIg9WwvIGlY/RszUXDOKuLBF9RYJWg2Il15ZkGN0OFkQVz04EQ3uwW5GgAODszIfLGZmy1gPR1tYI8uyERFebTWmSa37pB64qHtb+iOL5r77O97Rz1Sbruw5GlIo+zaXQ0CM9vsmOgFSKvEKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YMuDxFNVAXhyvbc+XMyBRrwNDqNxHnFTU/HdY7j810=;
 b=P/FQA604kuINz5jm1C0RcCUXXCjs65BAZ3dWyQJJM5YjIGAqnOg/CK7EfVN8DU8FQ7ZnKEuV79VJTokAvlaaxJhbSP+fM1AOE3rMjgKHXR/fWHAaV5BeLCashnkDS5FlTKWn9f2NjXQXt2O0z1Od5K4hm6DQAe7y6NRMsdEtkfFQRIZTnr4yFq5NQVAR25d21aZ5UK6hB8lChCbwVvyhaLcY3jCCjTh0c18gZuGrFHzgnHE7FnaWuRYCyCaY0jR63I25KIP58YePaF3ulw5mmci6UK0OJPYI9t4KWExJtPxnqk8Ch1aebriY3OHg2vDBY7Kndmbo+QkLne6njMbkNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by CH0PR11MB5538.namprd11.prod.outlook.com (2603:10b6:610:d5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 02:10:11 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::7b71:c300:be05:d512]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::7b71:c300:be05:d512%7]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 02:10:10 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday,  Dec 13, 2023, UTC
 7:00 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday,  Dec 13, 2023,
 UTC 7:00 AM
Thread-Index: AdotaV37pA3490TqTmWjJthYEPpzOA==
Date: Wed, 13 Dec 2023 02:10:10 +0000
Message-ID: <MN2PR11MB428539147AA54EDFA1CFBEDFF28DA@MN2PR11MB4285.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|CH0PR11MB5538:EE_
x-ms-office365-filtering-correlation-id: a4ef8736-d7c4-4553-d0fb-08dbfb80a2bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nqyw3ndV3i2hhnmhs71C1WGf14TC7ND1PWckDrPCc4+eSGM3S0zFnVPztPXiBmUxcYgxUpoHXqdNmiI0J7VuGlbC/Wu0IOTs1Qt24wC3GAI7nOsjZGrpdRBXFAE/7FTENSfwDAf+tDTTDVOVDWLzd1TdjD5RboszPFELKLigRGAq7ENzrpUMG6tsnyRbns9WTYjmWQHUbVD6SAYEfkP5ugdzl9ms/qsCQs1JDY+g++jKANoWAo48FuvUaIsTUW1Ne9XgAzRcDatHOWG/6+TAaW9D4L+n+vDLFJZ/jz20+PmezzmlBzZYgkVs0CiAgUQdkl5xQa1awuIUoqzVhqaBbm3kj9s1hIox/pS4HFfxtfTBjNaNKZ545PVAOwFw2kILJx+K4YrfeSEQAib7uUZ1Z4DIkVxZfOmqTI+/W2+SlH6TyxmZ6znHVwkJIyqs73kFO7TbZD20olLDYMMK+NMYKNku2UzgLuJ2QYhHHad0PdgUjhXy1xFLPigRZ+KFTaEWt+9eyvcd3OYMkajgw//oPM9qsyk/bpeZBfaxXmkcbRz3ktMgerMLISZEN0zS8/eDgVDmiQmRNDXIobSPpFM9tFraPviDX+cHw+5+ceGZ2yGggQzGwKcAMXeS8lnLmpcFmVilNIANcXTKxvs1OeohzA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(396003)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(41300700001)(55016003)(2906002)(71200400001)(5660300002)(83380400001)(38070700009)(40140700001)(8676002)(8936002)(66446008)(64756008)(316002)(66476007)(66946007)(66556008)(76116006)(6916009)(33656002)(86362001)(478600001)(6506007)(9686003)(82960400001)(38100700002)(122000001)(26005)(7696005)(966005)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVA1dS9PelNOQkxBSGYrbmUrRWFvalVobENpUnBhOUxaV1JRVzRkeGFhY0RQ?=
 =?utf-8?B?WWJ1b3VXNmxYbDZ4YXhOdEhicFg1WUJteFlpT3NZWGw2K0JSV1hwdDdSV0pJ?=
 =?utf-8?B?OUFDOTNTSjc0TkpzN2R6Unl5OG1pNzZVd1NIbmc0cWEwY0hhdHIwc3JwRmYz?=
 =?utf-8?B?SzNsV3dxNCt6cEI1Q3krUm52Tm9PV0hnNFMvQm1mU3FlVXpsMDNKUnl4WlM3?=
 =?utf-8?B?aE8wSVNkc2tQMnBBQ1ZkY215blZ3TGF4QmNyWnMweXlUOHZQU2F0RnpTSFp6?=
 =?utf-8?B?Tjh1OUhIMzFaQUpqMnk1ZmpYTmpHaW90amQ0UEgvZzlQd3JLejU2MXZWWnJJ?=
 =?utf-8?B?WGpmZmMzZDBMYVc2NlVUNzBMZjRaNDBtNjZ6QUxmMmd3eTR0dC80NGMxd3I4?=
 =?utf-8?B?RTZsa2NxUEc1K1J3MEZTS0lKdUs3aEF4WnZLQllySzd1MG4vVXM0SkZTbFlZ?=
 =?utf-8?B?WGQzUDI5Tk1Kd3hyTjNZUVRXTnp6WENzSDcvbEIvWE5Zc3AyTkViVUhVT2hD?=
 =?utf-8?B?MjU3QWg4TjQvOWt3akpsTElqcERSYmF4K1Q4WTdhNkllbGtSdUNhdjhGWnA5?=
 =?utf-8?B?OUFjSTZxZEh6N2VpbjFyZ3NQSU5WQUQ1TXRBajVKSUxoNjRDSGJpdlAzMXBw?=
 =?utf-8?B?dFdZeTdxQ2Z0bUZVYndvWms4bVIwa3dpL201SjMvcms0bUwzQzNKV2Y1eGZl?=
 =?utf-8?B?L0lXUWlZQjJZMHdNbWREZmg1aVpkTW1qYjJraUdqOGZQVjRYWHdZeGtORDVC?=
 =?utf-8?B?dVBodjlUVGxPZVQ2TXN4eVNybmZUYjJHc1lpS0pBeldkbzVJb3hrMndWNXFR?=
 =?utf-8?B?T3pjOXpSZndUdldrNGVvdkRaNXRQRFN5NDZHbjZOcmF6NnpCMFAvblpEZm9x?=
 =?utf-8?B?Nms3K1cvSGVhazlxSTdRaXpTaHl0RWlYZnpBQUs3cTZtczBRanNzeHAwWEEy?=
 =?utf-8?B?WldzeWh3ZnZsUU1VSU4yeFRtanlScHJpRDV3eHJEOGRaWGJpU0tFYktOR0ZF?=
 =?utf-8?B?VEY2MGRzZzVlUE9OUm9hQ1E5bVlhemNEeG9BWDBSeDlwbW5PdTBZbjk5TGQx?=
 =?utf-8?B?NGxnYmgyWHlCV3Q1V3VscnE2NmZsdjVTRjlKRnhJRzBRMkY2T3V0VmtlbUpM?=
 =?utf-8?B?WkkyOG56UUpteGlSR1VUYWxTejlCQ2kzYVErNDZiS0dSOFRyM2Jhb21ydXlz?=
 =?utf-8?B?VFB4UVlPU3N2ZGVXQ0lwb1NONlVOQ2ljMU5ZVXBCRHZqVTE5bjFLaVVPK3p1?=
 =?utf-8?B?c1hwT2kyRWo2cDB3UGtKQW1jMENaZCtJcTdCUVVaNzZOZjUweW5XWk5HZjJM?=
 =?utf-8?B?OFUyNDY1a0pTem5MalFTMGNEVmNGVUZKMmd0S3dWS1RDTGM2bTBnYWgyRGxi?=
 =?utf-8?B?YURid2pIWUR6YzI0OTRRaWFxVC81bXM5VFd5NmtPbVFTQXZnOHJxd3prM3c4?=
 =?utf-8?B?SEtaWmxmOWVmNis3alZrSERGeWZDejhMOFo1OWROWXk1SVJnWjdDdDB0YlVP?=
 =?utf-8?B?SGNBSEwxeld2TTRaeDA1eUo4VWdRNGhXMWcxSW5POHpRMFFFZGZCTW90WFI3?=
 =?utf-8?B?bzNwT1pZS0s4RXM0Y1Y0elFRSHhwRVJldzMzaFMwWktmamNOSGw0VktOaHVp?=
 =?utf-8?B?bFlaUkNFcnAwYVlNQWtZb1lHQnFjWjhkKzk4M2t2ZU1jNkhzbFBHOEZ5VHRU?=
 =?utf-8?B?L3p6SVBJczdBYkRRd05DR3M1bXFVa2o3NWZqYkNUUFdSMkZGYTZRZ21PS0tB?=
 =?utf-8?B?NlZibThHMkZkYjlxQ29xbUdsbVM4YzROb09tdkhNOERTSCt5K2N2UnZienhM?=
 =?utf-8?B?a2R0Wi9nMDVtTkhkbXJQMCtyYVBKR25uQXF3Z0M2YkpvQjcvT01MeHJUM1Nk?=
 =?utf-8?B?ejdVbXlQc1pZTnFNMFV0eXp6SGJEcGJWTXZ4VUVIRzBjNWVTYmdpTDFNbDJm?=
 =?utf-8?B?VlRmQWVFSXZoK3QyV0NoK3pnRGdkT1lQeWpkYXZvSGc1MTBnWnpmUkQvWURO?=
 =?utf-8?B?Uk1EbjJqTzAyNlBGY3VLa3grbGRzUlp1UjNUMUJ3cURlZWVFQUNSSkwwaDNM?=
 =?utf-8?B?Sm1uY21hRVpNaGdoeUdRN0ZSUEtFRTl3ZGw1RFYvaHBMOHRhVmUvQ3lqVlpI?=
 =?utf-8?Q?j5ZCrhk0sgNpXNWegydMsNEze?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ef8736-d7c4-4553-d0fb-08dbfb80a2bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2023 02:10:10.7605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YUx/Bvyr4QI8td2FsBcwgEQsQ+QuTmL6iCIu++J3tOHNHldJUHb3/npjHCN/K9jUuGb6aKceOix0KaCxYjkmog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5538
X-OriginatorOrg: intel.com

DQpUb3BpY3MgbWF5IGluY2x1ZGUgYnV0IGFyZSBub3QgbGltaXRlZCB0byB1cHN0cmVhbS9kb3du
c3RyZWFtIHByb2plY3QgDQpwbGFucywgc3RhdHVzIHVwZGF0ZXMsIGFuZCB0ZWNobmljYWwgZGlz
Y3Vzc2lvbnMuIEl0J3MgYW4gb3BlbiBvbmxpbmUgDQptZWV0aW5nIHRoYXQgYW55b25lIGNhbiBq
b2luIGFuZCBhc2sgcXVlc3Rpb25zLg0KDQpUaW1lOg0KV2VkbmVzZGF5LCBEZWMgMTMsIDIwMjMs
IFVUQyA3OjAwIEFNDQpQYXJpcywgRnJhbmNlIENFU1QgODowMCBBTQ0KQ2hpbmEgQ1NUIDM6MDAg
UE0NCg0KSm9pbiBab29tIE1lZXRpbmcgDQpodHRwczovL2ludGVsLnpvb20udXMvai85MTI5NzI3
OTI2OT9wd2Q9V21kd1MwcERPRFJOTVM5dFFrNTRZMWR2YkZscVVUMDkNCk9yDQpodHRwczovL2lu
dGVsLnpvb20udXMvd2Mvam9pbi85MTI5NzI3OTI2OT93cGs9d2NwazUyYTlmOTZkOTg5ZTdlMjBi
NjI4YzJjMzZlNDhiNjhlDQoNCk1lZXRpbmcgSUQ6IDkxMiA5NzI3IDkyNjkNClBhc3Njb2RlOiAz
Njc1MjgNCk9uZSB0YXAgbW9iaWxlDQorMTI1MzIxNTg3ODIsLDkxMjk3Mjc5MjY5IyBVUyAoVGFj
b21hKQ0KKzEzNDYyNDg3Nzk5LCw5MTI5NzI3OTI2OSMgVVMgKEhvdXN0b24pDQoNCkRpYWwgYnkg
eW91ciBsb2NhdGlvbg0KICAgICAgICArMSAyNTMgMjE1IDg3ODIgVVMgKFRhY29tYSkNCiAgICAg
ICAgKzEgMzQ2IDI0OCA3Nzk5IFVTIChIb3VzdG9uKQ0KICAgICAgICArMSA2NjkgOTAwIDkxMjgg
VVMgKFNhbiBKb3NlKQ0KICAgICAgICArMSAzMDEgNzE1IDg1OTIgVVMgKFdhc2hpbmd0b24gREMp
DQogICAgICAgICsxIDMxMiA2MjYgNjc5OSBVUyAoQ2hpY2FnbykNCiAgICAgICAgKzEgNjQ2IDU1
OCA4NjU2IFVTIChOZXcgWW9yaykNCk1lZXRpbmcgSUQ6IDkxMiA5NzI3IDkyNjkNCkZpbmQgeW91
ciBsb2NhbCBudW1iZXI6IGh0dHBzOi8vaW50ZWwuem9vbS51cy91L2FURUEzN2k1Rw0KDQpKb2lu
IGJ5IFNJUA0KbWFpbHRvOjkxMjk3Mjc5MjY5QHpvb21jcmMuY29tDQoNCkpvaW4gYnkgSC4zMjMN
CjE2Mi4yNTUuMzcuMTEgKFVTIFdlc3QpDQoxNjIuMjU1LjM2LjExIChVUyBFYXN0KQ0KMTE1LjEx
NC4xMzEuNyAoSW5kaWEgTXVtYmFpKQ0KMTE1LjExNC4xMTUuNyAoSW5kaWEgSHlkZXJhYmFkKQ0K
MjEzLjE5LjE0NC4xMTAgKEFtc3RlcmRhbSBOZXRoZXJsYW5kcykNCjIxMy4yNDQuMTQwLjExMCAo
R2VybWFueSkNCjEwMy4xMjIuMTY2LjU1IChBdXN0cmFsaWEgU3lkbmV5KQ0KMTAzLjEyMi4xNjcu
NTUgKEF1c3RyYWxpYSBNZWxib3VybmUpDQoyMDkuOS4yMTEuMTEwIChIb25nIEtvbmcgU0FSKQ0K
MTQ5LjEzNy40MC4xMTAgKFNpbmdhcG9yZSkNCjY0LjIxMS4xNDQuMTYwIChCcmF6aWwpDQoxNDku
MTM3LjY4LjI1MyAoTWV4aWNvKQ0KNjkuMTc0LjU3LjE2MCAoQ2FuYWRhIFRvcm9udG8pDQo2NS4z
OS4xNTIuMTYwIChDYW5hZGEgVmFuY291dmVyKQ0KMjA3LjIyNi4xMzIuMTEwIChKYXBhbiBUb2t5
bykNCjE0OS4xMzcuMjQuMTEwIChKYXBhbiBPc2FrYSkNCk1lZXRpbmcgSUQ6IDkxMiA5NzI3IDky
NjkNClBhc3Njb2RlOiAzNjc1MjgNCg0KDQpSZWdhcmRzDQoNCkhvbmd6aGFuIENoZW4NCg0K
