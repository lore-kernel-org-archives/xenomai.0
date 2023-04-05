Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEED4624
	for <xenomai@lists.linux.dev>; Wed,  5 Apr 2023 02:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680663212; x=1712199212;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=Kv69X9eo8MlYoUYeCPzlw4cpzfUxEhXypvnfG7y7JDM=;
  b=mV21Z23Js04S2FZM0A5HW1yUZMwRVBnDKPK1O/jLJxwvvAKiG1BVi/4W
   PLmcQN3Ll7EqhyY+V2j+Yd+nq0vEbyS/vklRlbE8cXKQZIx/KuAd1N6Pr
   lY9fzHoahCFkg/IbTqGCiqFq5ykA1eL7Kt1nOQIisPFMVpvHZ9E/U2TZ8
   Mn4w2wUrVn1C17t13YNUyup5Ua3JW9mGzUGu3wtxGe8VM1YljaKqwxqT1
   62LDBHLgaFW0TJ1sTAIO6w3n+cPNYkq/oGth7i47D5uqM1arVI2ghDHFg
   FZwOPWCsBsgJ64JYrP6cDPd+I/MJzD8LHUINI9cWvX1eYUtQrRqNsz/hO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="330954756"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="330954756"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 19:53:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="689109099"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="689109099"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 04 Apr 2023 19:53:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 19:53:31 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 19:53:31 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 4 Apr 2023 19:53:31 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 4 Apr 2023 19:53:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEADfmGe05cHAycvKZjd5KbbqCPOUd3RFfUY2GzQnI1FfXx19wTBQwcfcAdtoahLSQYhemgi5SZEZG2pXTKdOSZiOF/hd49ZtxCft0H+Jn6oE5z7kSoWX0MxctxD7JaEZXHYw8fbenYYJohABbIhRV2evp8E+/3AZxDIa89sTySnXk++aHFG4MaOEG3noLK/8/8tQ5HhORCKikrWAqBT8SYEYtCWKeRubhVI5rCUFz+flUpV/zgjvOmpRFG+8Omqj4zmUETr7Iw3xx2k/LbtJQEeKds9pgaZIdtSIdM8LjfRdqsxZ9dvhovtbo2HmIVavAumsDtIo8QbBwlqMock2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kv69X9eo8MlYoUYeCPzlw4cpzfUxEhXypvnfG7y7JDM=;
 b=IUD0InjjHREDD+zXChS8EgbPvfA2mAaGKrpEK1GrMoSHxCmWteutru/hDTA21/Ch0XXsI2RwX6NY2oy32+tSXb+LjNEciB53PFlHIE6O7mtnh+koMg6j/B6aZYHulhRvTUq1rz5AG4nGW351kfxqbcHbmCbmpPiq/7EauD53Ot+Pn/WI2eV9oQsie4SF5ZmzrQrlitV3SB5OWhlVX3vUpYP66Os7L0USP+05leyoMActjIMlVmPf3D+5mh7fHodlQdXOVsrE2rtp8cFVich14E4KZ9sgcCELK05MJ28WPANzd8aGB3Ab1Jxa5ibyFrfGPu22d+kfGICG2fHZAiYw+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by SJ0PR11MB7154.namprd11.prod.outlook.com (2603:10b6:a03:48d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Wed, 5 Apr
 2023 02:53:23 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::e1b2:52d4:e80c:dfac]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::e1b2:52d4:e80c:dfac%6]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 02:53:23 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday,  Apr 5, 2023, UTC 7:00
 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday,  Apr 5, 2023, UTC
 7:00 AM
Thread-Index: AdlnaYqXaYMQ59EsQ2WlTud83CW0hw==
Date: Wed, 5 Apr 2023 02:53:23 +0000
Message-ID: <MN2PR11MB4285644B9A79E1354871C918F2909@MN2PR11MB4285.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|SJ0PR11MB7154:EE_
x-ms-office365-filtering-correlation-id: 68db7296-f080-47ec-dcf4-08db3580ebec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Of0Mid1jACORYOAdIPGlxUk+4aqk0Timg07lCvOAdE78a2WjlVixNn8cwFskR4CzE4mLmY+bMKAgCq/nrFlt38NLO7VSWicmDsuTsS+jPCmU8HWMbUhg2RW1GjTat65uYVtZftDa5SfRENfplEVX6hQma+nx1CGxMqXAj+ikfeRztKB9jMAY3bhRrxAu63mHje83xmnkIJWEreHLnJ9VEpJArmvvP0G10xRuIaMv1gmA4vf+NOZ6b1AbW99YQ7BPxrzDK3mdSSwRWWoCzKKs9wMG2Ng0JBkL4/3I45c+h3pjKahO/7RhpRxucl7fGyVo8eo4TXadEVyKAnaTynRoiZG+P6frJXSCzVmM+2ej2ucRcWJU9xhVKKQxPxNjLX44vYYJ80YHwzSWngM1G49D5i9Dg9TDRXbJr2ilL63bsxQYR22mIIlLmaqP40oA48sCPG+M7Q9EAnyDXsU3HRzwgItOZE3QbAdlwE0O7d5c8NLJJKPbFmtU20CkYEPtczObXvEOpa9eeDErLItAtWEaUIfQTOf5UHB2q4kmr6bzmLGhLQWrsGu1P2MDECBwFjUbnhAkAnHu3/6LtYd1LUCW/uQ6AQvOur9TJMcjqmmw/IBNmAAK+QtuZYkIaE88BPOr9VnR08dXSYZGVPuVimieig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(136003)(39860400002)(396003)(451199021)(186003)(55016003)(41300700001)(8676002)(66556008)(64756008)(66476007)(66446008)(66946007)(6916009)(76116006)(7696005)(2906002)(71200400001)(38100700002)(966005)(38070700005)(122000001)(86362001)(33656002)(40140700001)(82960400001)(5660300002)(316002)(8936002)(83380400001)(52536014)(9686003)(478600001)(6506007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGZxU1ZFTGYra3BVM29zdDlYU3hUQ01iYjdacHpRMEoyS2xFRlRLY1J5ZzRK?=
 =?utf-8?B?VXl2MkZ1YVpadFZwZXdJVGJEeEthdmR6TlA2VHNzNDNFV0NtbHptOFNMUHFL?=
 =?utf-8?B?T0gyY1VZc1N1N3pQaTgzSnVaaFVrWFl4Vkl5WkZsS3FWb2JjTWs2eWZWanFG?=
 =?utf-8?B?NzJMdE0wY2ljeHAyV0daUEM1R0lNL3VrVjBEUlROZ05YTGI4WUZOMVpFMGNP?=
 =?utf-8?B?aWJZOEZnZklFU1FrQmgzeUt2TU42bmowTUV5QXhaMG9sdTlrM3VIWXB5eWFa?=
 =?utf-8?B?MWFRSVZJZWVDelR2dWFFUE1IWUpZTjJEZEcwNjFPNFZvTG9XSXg1U25YQnda?=
 =?utf-8?B?SG0yTERNZGZ1aG15UjlIbE8wWG9DbE9kcUxtSWsrQkhkanJlRkpOWVVJVjFl?=
 =?utf-8?B?eW1WRjNZUkJ3SUFRbktWZEJoWWlwQ2dQVHM5K2pGQjlENnh6TEs3NWRoSkVY?=
 =?utf-8?B?dHFmL1o2Q082ald1ZDdUV2F4YktpY0k1aTZNWnM2ZG5oemZ0bGw5U3h0Vmdy?=
 =?utf-8?B?aWRERW5DNk9xSGxQemlrbEtQNzJFWUphMkZreHgvUVJaOWtKZDBtVGFSYmE0?=
 =?utf-8?B?SitxNVRXRUYxSm9zV01QU0xCb3haZm5UbmhITHR5dlpveERiUGliTHh0Y2gz?=
 =?utf-8?B?ZXNqTGk0NjRKVjI2cXB3dVk1ZWE4cEI0OU5uajZDbys3dUpreHcxbVYxRFEr?=
 =?utf-8?B?aTdpQ2IzVnRUNDcwWGZLMDZreUh2RDAxd0NiVy95QjhYYThKN2p0NDM5d0hS?=
 =?utf-8?B?QzVDZ3k0TFpmMlRNR1dhV1lDK3hwZUQ3QUVyOUZ2V3lnT2FkOVFvdW5XT1RZ?=
 =?utf-8?B?NEVFM0kyOXpoOWRJMXpZTmpQSWpWY21aKzRsT21jZXRwVkVLcTlPZlMwZ2hC?=
 =?utf-8?B?R0c1a1RCOXl5b3lkNnJwVmwwdWZUVlUrczhGcVRjVk16a25zeEtVUTRBenFi?=
 =?utf-8?B?WW15ejJrcTBOUE0wR0JabjUvSHFzYWNxR1N4STBaNkV4VmJTMGFkN1plZTBL?=
 =?utf-8?B?RXUwS2NCb0dXbGhWN3IrbGRMbDRUKzFaV0NDVlZyOVJub0dqNEd1OGxRSHZ5?=
 =?utf-8?B?NitYSFBxaFRrOHcrNnREUkh1ZWNabVc2RCtpVmY1YVVEenFlWk5ubmJrSGFU?=
 =?utf-8?B?dzhDcHBmaHA0YXVtQUtHOCtFTEJiUjNnMGVjTTk2Y3NGaCtSRDFDVnZrZ1lZ?=
 =?utf-8?B?WXR2MkVpOWpNSzBsV1E3VTFDVXhpeitabEFjTE9kYW1ZZk1VLzVBcGhURjE1?=
 =?utf-8?B?R3dUQzBGdjAvSWZwN2FOR0d0S3MvclBJaDNiL2NqS1JOeEU2TmwvVmROWlFO?=
 =?utf-8?B?dUJZVU0wVGZtSGFmWXBUQ0JBRjZkNmpMZnB6bWlTWHZSVDZZUlExVWlMMURI?=
 =?utf-8?B?ZnhMZTlZRkREK2FXRlpQczl5Rlk3WlZkTDl0Y0lUOGZNMWlUYk04QU9WVE03?=
 =?utf-8?B?Q1RWbENOVGttTlEyVXVNRFVCUUJSb0xNaWJuQUQ2MGY5dDNJKzFOWFNZa0hI?=
 =?utf-8?B?ZS9DclM2Mng4UDRWYjdKcEVDRmx4OHFEMkZPNTZuclBrK1RtcG9SdTR1Y2hT?=
 =?utf-8?B?WFduWDhDSCsxNXRrVzEwUVBKVXRhVUZ0b1dxZVVrZjQ0VWZhcVlPVVVhTFd2?=
 =?utf-8?B?U0hCT1lRRUtublJDcXZCS0RRRUVGTzRJTmo0MkVwRjRlUkxGUmZLaWhwbStS?=
 =?utf-8?B?OWlVSG5nbTMzQmhoR0hCYUpmVmNiVFRiUHd4YXU3YTl2MEVQcmtkbEs2Umtx?=
 =?utf-8?B?MVVmeGpkbjA3QTg0VkkvWlZockMxQjNFOCs0SUZ6bVE0bEFRN2pNb1p0bDlU?=
 =?utf-8?B?TlFqNGRiaWVmS3F4WlcrOFd1M3B6NzBNQmtUN1ppWmZiWEs1VjRxaTN1Vkwz?=
 =?utf-8?B?WXl4WkticjFRaWY2ckU5Y2NiOFNxR2Z5aURuME85YlNQNWlMN0UyVXhGUEVY?=
 =?utf-8?B?V0w2Ym1JR2xDOE1LbVc5N1ZGR3pDVlRFOU1tL2tYYVMzVlNFRTRjZm5WR1FQ?=
 =?utf-8?B?aDk5ajg5bE90U25MTXJ4ZU9GMFBKdWZnQzFXRUlqU09LbHIwUERET2h5V2pS?=
 =?utf-8?B?YzV3b2ZmK29Ya2Q0UTFOQUFNd3MvdkRZQ1N1eWY5WG5aL3EzYkdQaVBhRFkv?=
 =?utf-8?Q?pNgTNtBPiZ+V5Lfu+O4DzqpcR?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 68db7296-f080-47ec-dcf4-08db3580ebec
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2023 02:53:23.2719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eFT/y2NbJkj/rVQmXkqx+DitN6rLXGy4Z8wh5rmvP+HJ9qJEMEEKIhXLTwZQ07US1fGKag4ZA5uumFmRVu+4Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7154
X-OriginatorOrg: intel.com

V2UgaGF2ZSB0aGUgWGVub21haSBjb21tdW5pdHkgY2FsbCB0b2RheS4NCg0KVG9waWNzIG1heSBp
bmNsdWRlIGJ1dCBhcmUgbm90IGxpbWl0ZWQgdG8gdXBzdHJlYW0vZG93bnN0cmVhbSBwcm9qZWN0
IA0KcGxhbnMsIHN0YXR1cyB1cGRhdGVzLCBhbmQgdGVjaG5pY2FsIGRpc2N1c3Npb25zLiBJdCdz
IGFuIG9wZW4gb25saW5lIA0KbWVldGluZyB0aGF0IGFueW9uZSBjYW4gam9pbiBhbmQgYXNrIHF1
ZXN0aW9ucy4NCg0KVGltZToNCldlZG5lc2RheSwgQXByIDUsIDIwMjMsIFVUQyA3OjAwIEFNDQpQ
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
