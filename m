Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F131376
	for <xenomai@lists.linux.dev>; Wed,  9 Aug 2023 02:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691546954; x=1723082954;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=mPsWvIse8t7MxpZ7EeBoW7QIGgbx/XIp6qq9YYpdDm0=;
  b=liP85q8befuGn6iuxxhL6QFd0lBOOdNO5NgAbTR5XmcIL3nHKsL2Uf89
   frKfJzQOGQVqYvOD3DPEUxPPMlixGINkx9/m3UjEy79q0Qf7wlayVTIJ/
   NNDih4hMPu7X5cycSvYjkRdBtW7NO3kENtqj1Ukox28tJpi7wgTyQtAOy
   qHYAhQSCZhjjKPLSxX0fYWmYB9qg5wPakYjd1bpt/5C7qnCkDihT5B2OD
   TTjSjcAz02cwiIEe1BLruGfkjY3KaN7G2xjdBfKp2uev6c5ma2XssyB+W
   zW2Ha7LMVhOtGPPb53vG+QfmCZITOMM6cTwwAgoKIlGruR66NSG+90LVZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="369902143"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="369902143"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 19:09:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="821644073"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="821644073"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Aug 2023 19:09:12 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 19:09:12 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 8 Aug 2023 19:09:12 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 8 Aug 2023 19:09:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fI9XSRephDqdJXicO4HNiZWy0ntcIjWar3SyhR7iv7kvy4UPhRoOeqKpfSWXLxEgX39nMraV2D8dd+gVGHnt/W+sdKBmsrO0+FmbGv1y+ELjzBlg8bAbjY8ldUT2dWXTHsi5kYiStKQX8vl+Hiv5PgDAmy/RgEt6uRpXFdw84k+durabnNwHiphW2vZVkZIqendWvjtkDh+1q611V5p4WkuK3zoUCxrk9o8QJ7Fc1O40Kw4gLGrPfm7R+q1tFh1efsCH2knXpNIXYCwwkMHni3zX4Ddbas4nV90F7Vo4GOl5+P6Ov8xtGe0tDqlTrTuXJV6K89iJG7lHrgfkBVq7Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPsWvIse8t7MxpZ7EeBoW7QIGgbx/XIp6qq9YYpdDm0=;
 b=oO91R+Aq6ldkVNG9K+KfQizr3dc0OyYrb+fa2zndkUqeyKnmiFanC75NWPoBqfl4+iLTM5ywMpNMSw4ZLRz3mnCTNS9svovjkAzYXt+kl6g/dq3CiHyIzYkCgVy4SPWf8OYITdAA+bLFyV32cp8Mp/RgxhXCNspuVlNDrHx4a/Q2h3HR51QgujlldL/5DRsO3HVkl2WdyXP0ILkOA34I2dhYR+WkFI77NYXNT17mdDIo6TGHUo63WJUbfzQyXl6Jjon0+x1u2DLedDgpc5oFbEQt3OzxCgO7whlI5dpsxaeo7E940x4a8S1wsRhr96GHIgoc0Be0Jp56mibwOzEfnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by IA1PR11MB6514.namprd11.prod.outlook.com (2603:10b6:208:3a2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Wed, 9 Aug
 2023 02:09:09 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::9f36:bd07:796b:9d38]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::9f36:bd07:796b:9d38%6]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 02:09:09 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday,  Aug 9, 2023, UTC 7:00
 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday,  Aug 9, 2023, UTC
 7:00 AM
Thread-Index: AdnKZkn+jQk3qSbeQleY/o/+Deh7Xw==
Date: Wed, 9 Aug 2023 02:09:09 +0000
Message-ID: <MN2PR11MB42855413AE2471A61A9F28CFF212A@MN2PR11MB4285.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|IA1PR11MB6514:EE_
x-ms-office365-filtering-correlation-id: 2fabbdc7-94ba-404e-6255-08db987d9dfb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8e8Ebjhmlr+ur8Nrg0PKrT0vwCzmE9pHf08x5Tm7FrunCSOfj+uG1prNTL+aHnbtSeaA7of+95IUPYbUQZX9IjA0HsKLOu4rfDAKz93bFR6WJNtHunJAHIdfJMejEIMfcDsnTChKc5uEWLr0W4+7/Uyp4O9IQ+h4Oz1D4bKIlhLUXrAAea5A9EjqEZzX3StBFeGbT5Mw9VuNguogez8RzplrBkd/UugtH9P5ld7w91hcL3kAvbzM5WR8SpfPpa+UuHUxK96SHN1b29hb1jcogyaFUMy40STJ62ucFcUPIWSD48gwHSgrr6ETzKtx8kbwAv2V/HdGnGqpFK0oLylFri43FGx5nkHZ0caT++aTyioEEmB10I+1y5Iuoz+gDBndFt3igj2hJzZpb/mMZpNJQHzHZ1Vr10nE/mXPC7AxKS+anXhamtpgPnY8QG0igHUpa8e57D/YpoPaugQ5DJtI1h2OKIzWyuOoN3L/a4tpkn0n5ItQNbjuMm9vO1m48ifplccXz3PTjpU1cba2IRSSJW/Ilp4XOZnrai6q8FKN5W7GLPaqjxZTmpOEW5MGCO12jIy69zR3MMvMwCztfUPw1egYIcFfQIF+JQUkFZbmRU6/I+t/s5/e6JsS6diRlnSHVtP4claVcJlRd++oFYuU0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(396003)(366004)(346002)(376002)(1800799006)(451199021)(186006)(40140700001)(9686003)(55016003)(7696005)(71200400001)(478600001)(86362001)(966005)(82960400001)(122000001)(33656002)(26005)(6506007)(2906002)(41300700001)(8676002)(5660300002)(38070700005)(52536014)(316002)(6916009)(66556008)(66476007)(66946007)(66446008)(64756008)(38100700002)(8936002)(76116006)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0p1MEVzUUFFK1NXU2tmUVQ1RjV6b1l0Z1IyZzBvVG5ZblM2NVN0d3NHZEV3?=
 =?utf-8?B?S00zdEdtZ0tnRTF0ZTlFUDBoWlI2d2pvd0ZwT3FKNkpJdGNoOHlNK25ncDhv?=
 =?utf-8?B?TTlsU3pPT2dBbkMwd24wVldFZHlmUmZHNkpyeTQrRm1YSDZ5S3VGbmI2SnlO?=
 =?utf-8?B?L2w4dGRleFNZbjY2cWI4QldZZ1ZjTldVYklOanNGRzd1OFJIcmUyQ1VhOW03?=
 =?utf-8?B?TkN0NkVXZms2UGQvUDJCL2tmdENmSExmU0gvSjc4anRsUmlUdkxRRldubENV?=
 =?utf-8?B?WFBtMnNiNzNPcVZEY2oraWYzbXc4T1dDNnVwZ0F2Qy9PYlZueUdISUdpZzl5?=
 =?utf-8?B?b3FxMm9Jd3BCYVFLMHlVOWNYM283c05mcWxCdVB6M2JieXloZUpnQklIb0No?=
 =?utf-8?B?VkZhR254SmgzREpTaVlOQlhBWnFaRGlLamdydW5tMWRmQlA0VHp4RHJNME81?=
 =?utf-8?B?eWF5cHNzVmd2bGEwWHM4cTFqaU9PSlpqVU5vWVg0MEtLRnFoUytsOVJEL3Z0?=
 =?utf-8?B?WFhuZVNyYi9KakZ3N0VRNmxWMHcrM3dkRWZkU3FBUStXOVN2NlZ2bXNyMVhL?=
 =?utf-8?B?UG0wZGRsQ3JpNWFUcldkVWNBNlRFc01EMmcxdDZnMVVqdFJGbWlTaFpuSzZ3?=
 =?utf-8?B?UndzVUt4UjhkMUdDTEZCRVh0ZWRlbnhiajd3WWljSFNIUFd1NWhHbDlRK1J4?=
 =?utf-8?B?eWxhMUwrSDRUR0dOYzdiYzA1NGVpSStTSkNyZXFpZVV6cG1QOUNPYWREU0s5?=
 =?utf-8?B?NjlYY2xtVUpJRUVBbjZsS2JsYUt3QThDVlBYUmJiaHZDamFxZmdOZkcwdVhu?=
 =?utf-8?B?K2Z6OFhvZ1hxWFFCL2E5YnloWkZDWWhKbzdXMFpNcG1PUzdZTzdHNFlmeHFU?=
 =?utf-8?B?SGNGMVZ2bHo2Qm52R2ZEdENNNlcvN3ZKT2RkK2U4OUtIUkpMbkdUMlcyREFI?=
 =?utf-8?B?TDZReGtTckc0NGRpZHFTT2diM0xJVjZTQXp5alNzUkRQNHV1QTBBWUhOTmpH?=
 =?utf-8?B?eldibkVjODZFQzc5UklmdUkrZlE1aENlRXB0V0hobGNZM2F2eXpDL1MwT3FO?=
 =?utf-8?B?UTVZdDlQOGVyVnBiS0F0cUVjRGlzR2xpeHdIRGdpVzlGdUZtMDBOZUE2UWRn?=
 =?utf-8?B?VFdxcDlFM0xjMndjTExZNGlwVFdtLzA2TlFhV09qT2d5YjZINGNxNWlDR2FI?=
 =?utf-8?B?dlZzZHIwVjl2TlpZTWJUN1FlTEp4V2NBakxZYUxkUmNHMzRqRGJTeWI3OVB2?=
 =?utf-8?B?M0ZFY2pDSUg5Q28yNmpiWGdBQnc5MjZ4WWNUaEZJSTZhakZrT0thUUU5MUpy?=
 =?utf-8?B?bTU5QTlUOUtsUFRVdXp5dm1PVGZRdGNyMExzU29lZG56SUxQSHlZOEkvQWN2?=
 =?utf-8?B?bk8rMVRIQlVGS2FYZXhUaWxSNFIvTDJTcDZLMVJlbVV1Mk8zSU5IQlRKZ0U2?=
 =?utf-8?B?WW1qQUdPQ0M4WkthQ3FqS0lvcjA3UkVKajZWMkN2YzFIQ09XS2o3SGU1Tk9i?=
 =?utf-8?B?VW5XSXVLYzlmbUIyVEMvY3lBV0NrOUpkTWZqMkl1R1IwNFdJRURKQVlmTmNO?=
 =?utf-8?B?cnJTQ0ZUSG9SNnpLS0tmRDZ3U2dTRGpkYlg5VFhqOUNTb1hmc3lsUlNlYmhQ?=
 =?utf-8?B?MEU5OFlaQ2F6Ymw4QXVXR3RrQ2tqSU5GbUJnZ1hsR2VYNE8xWlhSZDNzRVlT?=
 =?utf-8?B?Y2tnRnFlT3ZVRWRPTWZFRjFHNVhvQUppbDJSTHhNTkZYMk16OXFoU2k0T3ZV?=
 =?utf-8?B?SjFJZjFHcXhHMi9BSFhSUzU0WFhIWjQvaWQrdFp0blVndlc5dkFOYnJaRlpI?=
 =?utf-8?B?WElBSXV1eWM1MUVRKzhNV25FSGU4eUgrVHdnL3VUUklnL05VdE9nN2taM09Y?=
 =?utf-8?B?Ri9mTjFWOG4wUG9OQUtlSkpaSGdQcWthblhHRG4wdklIdURSTGRnSDZRZU5Z?=
 =?utf-8?B?aWVyaVp5VmtXTXdlSjVkTmFQTDZDY3VrVHg2NFJjeEYvTVFKUlVEajFRVGZl?=
 =?utf-8?B?Sm1mUThOd292ODhjWVRvR3N5VkZnUmVHZDVaVFZjMGV1dkdMSlFhNXM0Y2Uw?=
 =?utf-8?B?d2Rwcm9DRHlLMm4wZkIvNGw3RmR5OWJYcVdRTUFLdC95UmczSUF6RmZ5RFgr?=
 =?utf-8?Q?d001vQ8ILz2DTnKsz4Uix1ZZk?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fabbdc7-94ba-404e-6255-08db987d9dfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 02:09:09.1546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eyj+0BTjy2wBHOl4VShHKTYOfyzkLudqaAf+taH3EZ85LIyqVdHwpO9T6+ME/Bjky+qUzsI5bwOkJZk/2fe7ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6514
X-OriginatorOrg: intel.com

V2UgaGF2ZSB0aGUgWGVub21haSBjb21tdW5pdHkgY2FsbCB0b2RheS4NCg0KVG9waWNzIG1heSBp
bmNsdWRlIGJ1dCBhcmUgbm90IGxpbWl0ZWQgdG8gdXBzdHJlYW0vZG93bnN0cmVhbSBwcm9qZWN0
IA0KcGxhbnMsIHN0YXR1cyB1cGRhdGVzLCBhbmQgdGVjaG5pY2FsIGRpc2N1c3Npb25zLiBJdCdz
IGFuIG9wZW4gb25saW5lIA0KbWVldGluZyB0aGF0IGFueW9uZSBjYW4gam9pbiBhbmQgYXNrIHF1
ZXN0aW9ucy4NCg0KVGltZToNCldlZG5lc2RheSwgQXVnIDksIDIwMjMsIFVUQyA3OjAwIEFNDQpQ
YXJpcywgRnJhbmNlIENFU1QgOTowMCBBTQ0KQ2hpbmEgQ1NUIDM6MDAgUE0NCg0KSm9pbiBab29t
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
