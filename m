Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D01D70838
	for <xenomai@lists.linux.dev>; Wed,  8 Jan 2025 05:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736314059; cv=fail; b=j9yxEGL6g6GzKfCs8u8ERU0MFWKy0TdpkAxwapTEm1mzmpvQnM6qcsS4pXT7dtLhpEBzgi3bQ7hkTJGxhu1fHFCqxKStLqb7GsjRLmH37C0GI8eb6kKjAbRfCWrDIQUuZ6N4XyZl0aAWsL1rBscceOqvgiEMZl5TYWLY+uGqUOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736314059; c=relaxed/simple;
	bh=te8ozCW1EcrG4E289lxc1e4tySQ64g3kOD3AY7yqnO4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QEvf/VR37dmEDuqoqN/RIci+/k2y+wsqyTSIy2DsAHNcXztf4HU8FwrUQ3I0rwpukzIgcSH3T7hQK1tNRunVTifa6cvg0PkVT/EMT0oWQmEhVB6+io8XAYUyKq5eslnwVzffkjKg3UcOnxZuK+49sqK2wJPqou5fiUHQMthyQyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kxnf4z82; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kxnf4z82"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736314057; x=1767850057;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=te8ozCW1EcrG4E289lxc1e4tySQ64g3kOD3AY7yqnO4=;
  b=kxnf4z82kBmk6OoHBsM8Oas9fEeEnZynbMv70OSXBc8qE2mGVfgtDelz
   YMzhoCFeXhdcLdmzrj2RSt3lksN0cG74HKHR70xVxE6qIlXAHioSGICTD
   iudb22BrQT8NZW1z9bYraSjE5+c3rJLY5WhhbEGTSxTqqGa7/5xiKitu3
   kpgDnWSCPLeVgX5rkRRbcswnAkZ3Zp9LmVcZ8vFVNQiwqROUQCZfHdrE3
   MxviczShqOsihSflnuEP7SmF0VU3D5Fx+/waOMcpOf/jTcgsNatNxkvXr
   OyRQX0mt8xt+JHVbJGc7LArhn/EfHS1jigEoIZ4/8VRt1lFnpu0PNJUvb
   g==;
X-CSE-ConnectionGUID: xXLDDUAxQcOecHuJiDSmDQ==
X-CSE-MsgGUID: 1HX6oowQRD+GnziqglvL7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="36684797"
X-IronPort-AV: E=Sophos;i="6.12,297,1728975600"; 
   d="scan'208";a="36684797"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 21:27:37 -0800
X-CSE-ConnectionGUID: syCBdDePRDy4gUkOTIP82g==
X-CSE-MsgGUID: gakoFqdzSXeITQP4aX1qpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="107611990"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jan 2025 21:27:36 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 7 Jan 2025 21:27:36 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 7 Jan 2025 21:27:36 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 7 Jan 2025 21:27:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gj8F4+3R8ObsFXQAxIaOj8fhdGNdmcsSuGQIIzu1GrTmGTC1u8OCrZvgu267/a2Vg7o9LwzeST2QPxtV8UKYOjzAfULi6JUfVf+Mf3Tf56GxNe3ZyI8THV6VhLU5+LIms9WJvWXVQdF2D7NI5f02a0dM65jNTlw9RULVZwD6sSs1Qf65+6Y3Fig7L7B9QUUhEzMNAKQX3GCbGYyw2348GMpm0DMKKbxphJQJNVUKiRUqeL26Qu5Z+C0tfupauaoXW2Kk3uNOylmGnNGi29CVoK/+MdxCU09DMsHsTGsNz6bElDQP1AnqjJf5CU7BzU8s/qT4LQvQu+VT1cXxX0adhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=te8ozCW1EcrG4E289lxc1e4tySQ64g3kOD3AY7yqnO4=;
 b=RY+bs6DeHYTeEnVmgihSHDeEwnP+kYAqiBR4M1xOd3Bml244pcoRY0TppxYNVAmQSsuG1mGQlEFBCXzPhJ/+q9IZrCObfy9JQW9+ycTWn+S0kKOmb0ujFvnOp3O9cGJLQc2iupik1F8h0LhTn3BX6KsMjSEKRALaarhYHWuHShksB7GpeKY2+OOlP/D1vxnJ9UgJtnc2drrEX2Hwo9GA7yMRgC0tEhPTwPkrtJhnu+0P4gWwL2IgjPZ1yG5Sj+hwPA6VQMQoPfvKZ7eu3NOX4KDDx7UTuynqOngxzZVGkv9Km74LWvY5OugjFjOkiNkS2wW9rOgTiIfklNt6y0E1fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by CYYPR11MB8406.namprd11.prod.outlook.com (2603:10b6:930:ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Wed, 8 Jan
 2025 05:26:57 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d%3]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 05:26:57 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "Rosenow, James" <jim.rosenow@mts.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: RE: Relax tracing not working for me
Thread-Topic: Relax tracing not working for me
Thread-Index: AdthVp/pSYw8A5rtQ5GCNa1Z0i9TVgANRq7w
Date: Wed, 8 Jan 2025 05:26:57 +0000
Message-ID: <PH7PR11MB7499A235E242492C3FB23DE2F2122@PH7PR11MB7499.namprd11.prod.outlook.com>
References: <MN2PR04MB6255403DD160D9EDA3319AA5E2112@MN2PR04MB6255.namprd04.prod.outlook.com>
In-Reply-To: <MN2PR04MB6255403DD160D9EDA3319AA5E2112@MN2PR04MB6255.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|CYYPR11MB8406:EE_
x-ms-office365-filtering-correlation-id: ae52b0eb-8828-4648-d1f3-08dd2fa51206
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MGZId3pZc1UvZXp2N3hvWWFQaUhPTmpjcEFVanozNFRpL2pFTHN6RmYyR2Mz?=
 =?utf-8?B?MmtkR01KSi9BMHNrTVE3eFZqUkg3VlYrUGRoUHBVSlRwQXBiTUIyQmVPbThT?=
 =?utf-8?B?OVlVWmFmMWdqYm1qcHhvWmVnaGpFZjVFQld1KzFLSmhtSlU4cFRHUXNaTWxr?=
 =?utf-8?B?Z2lZQVJoTGdlSDdhRGRaQXFvNUI2VldtZmFPdFJrMlBmeE1rcGhoRWl2MzNY?=
 =?utf-8?B?OG1mSVJZeTRsemRLanBwRlk0VHNDNDNmc252RUcvZnF2cWYrNnErQ1ZHVUIw?=
 =?utf-8?B?ZStRcnFzdE0wekNUQTAwTnphMTlnRHd4ZmEvZ0d2L1F0aFhRWUR3K3J4M1ov?=
 =?utf-8?B?MkxGL0xWdERFYzlWVGM2S2NONzFJTkZ2MU9JOUtNMWxPd3BJM05NVzY5UWlx?=
 =?utf-8?B?YzZCdTRXRWVqVHlWOWd2M1p0V1FWWm1GcTJVbkZlamJ3c3lFbnNRL3pxNmth?=
 =?utf-8?B?RGViK0ZySFlzcVVGMnYyNCtzSzdvOXM4TkQ5Ylc0NURMQVZEci9JTlo5dFBk?=
 =?utf-8?B?YlhOc0cyWTZyU3ZDejFBTTJEZ3I3b2I5Y0xDR3pURm1kZ1pGaWZTcDhkanJG?=
 =?utf-8?B?c1JoQXRjUXNkR2JMRWYvaVlCekh1OXpCKzBWNUVzK1QrOFd4TEFIT29CcGJK?=
 =?utf-8?B?emVTKzhmbnJJaXJYTHZjYmN1cW5JL2h6VG5YWmNUNVdYSzk0RUtqOUhOTmI3?=
 =?utf-8?B?VEVCU0ZEYS8zYUZsNWFtQmhOU1JDOENBU0hsbzBmV3IzS2tsSkI1Z3gwRG5z?=
 =?utf-8?B?UVRUNXVPMXEyQVRDTHJ4MHNXeUVFcnp2bjMrZHhPcUhoY0dJZUJwT3dLc2Fl?=
 =?utf-8?B?bG80MllreGdWaExHZEE1TDhhMndIOVZmOWNRRzNoUWJnallqVUpFbE9kVGRk?=
 =?utf-8?B?TVplN3NHMmd3RFBQS0RsaFZ4NDNYNWVnYTVnVFpGR2E3ODArUE9QTUIvcCtP?=
 =?utf-8?B?RmlDaXY2U3pOVmlQeksxUWw1cjVzbk9UYXU0M3hzcHZoMDN5VVp3MW9WU0g5?=
 =?utf-8?B?cGlRZlBHcmdlSEhMZzF3MVhZQUM4UlluaGtCeCs5NlZsVDBoYm9xckVteXZ5?=
 =?utf-8?B?cHk0Zis0aDY1bFhhU01DdmV3MUJMTDFmTXNzdG93bVE4bjZxYUV3WGsvNHpN?=
 =?utf-8?B?MWJlbmpZd0dTODFOa25sMDNJZzBLcVFiQmhRZkdaM3c4NEtiV0lOOG9mTjEy?=
 =?utf-8?B?UmdieHVuc2U1eUlhR3pTcy8vQ2xVOHArQTJ6SUw3TEZENGpQSVY5bzVFQUty?=
 =?utf-8?B?MGNjcTlYL3U5ZXdhUmhzTGdlRjdLZlZqVnBUeFBhWTJCOU9qZXQvTVk2UENj?=
 =?utf-8?B?M3JUMFJ5T0xWYXVUakFGTG0xK01FY0gwMWxrZGE1MCsyMnNQN1hQTUJLbERT?=
 =?utf-8?B?ekZRdmw4d2R3NWQvTG1iVytobUc0clBHVmI3Qnl6dW83NTFCZFZUeXAyYndM?=
 =?utf-8?B?UFJheWNnVUxsVHFlQXdPRGM2cGZJY3QvSHNJZC9xVEZqWHhuYjg4YkUyK1hn?=
 =?utf-8?B?eW9BazBPeFpwVy9JNHZWdENPS25KU0FaMkp2Z2FDOW5obG5TdW85YW8vQUhO?=
 =?utf-8?B?UGZESStDdHZZRFRQWUFxaHlnRDR3TmRXdUhlTWlwZmRDak0xV1IwL3YrOUJn?=
 =?utf-8?B?NnJPcTVXQ0JpMmNtNjl1dGNJQ0YyTlRGNmptNjZrbTJ3WFJROFFoT2lSNjRv?=
 =?utf-8?B?WC9KZW1NNklLSmwzVTBSVGlDREVWbC92SXgrYmhtL1VOZjVxQmZ1UUVaNkoy?=
 =?utf-8?B?aWZ1Q0YwUGovc2dOVEpUSlRzaW5sVHZvekRVWmlncjk3K29vZHEwR1c1Z0ZV?=
 =?utf-8?B?N3ZvWjN2QWI1MlFvNUY4UHFFYWpxQUhVNk84RHJock0vbUpsZzVDa2RPZ0lX?=
 =?utf-8?B?VVFTWjlDL0dmdFJXdEpWeFg0R1YwM0pxVGdYVWhHNjZHeHJ4MmZQZFZiYWJt?=
 =?utf-8?Q?uLH0X71kORyJbbyjre2/WXSZOMQOkuHi?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3VveUdteU5nbWZTblFJcGdQbzZsQmFkRkFnT2ZaaFR6eWJPMUgzdTFUY0dC?=
 =?utf-8?B?VHllVU5Td1UyR05rVFV4N2dZTk5qTlNvd1BFTGRQQ3dFS210eW1MeE0ycjhx?=
 =?utf-8?B?THQ3ejlhcTJUajAzSExqa1lTcXYwd21NYk1aR3NxdXphanZqU3BSRFNnTEY2?=
 =?utf-8?B?NkJHc2lUY1VOdjBCNEt3N1dZN2duRlJuT2xTSkszQVNGSTFIaXRIY0ExWWg4?=
 =?utf-8?B?OWpIZkNMUGdDdTAyWXVHWi8xVEZJaTZvZEo0Z3AxK2tSdnluMnNRNjhYeU5R?=
 =?utf-8?B?UlNuWGNvSktoRUkrUDd1Ym8wbDFMYlM4T2xnWFRRMzViak1wTHlKUFFVUjUv?=
 =?utf-8?B?cmhHdVRMem1SSnNQSDg0NC9HNHJiNC9Ka2tyN3poRGhPVXp4MXRqYk5nV3lV?=
 =?utf-8?B?b1lwWHdXNlZxWDA5QlFaWFVKN2kvT2FuSXk0MUl3RkJTZXZjaWlyMUhYaUFL?=
 =?utf-8?B?TzJSTTVvR3RlWlU4SVIxdXpRTU93cmpjOWZvcWRzeFkvWUlwWUJNTklTZE5n?=
 =?utf-8?B?cDVqa3BuQ0EyZnExNEFEQUI4ZWlxZWNoK1ZtR3NnNGp1L0thNkVSR3VWbzUv?=
 =?utf-8?B?WWJHelh5NEJyeEx4VTVzc3pKWHRLS0M0SlRQc2NuRE5IbVVmK3lJdUdxak55?=
 =?utf-8?B?eG1udFlocVNQMFZ6QlRkc2xGM1dJZG1tK1RLMXFlUy9SdFhGbVFNREV2R1lm?=
 =?utf-8?B?RDhMVUxHdTE0RTBEeUd1SXR4Z0RYQ3J5YmR5WEE5ajRIQ0p2Z0tWa2d6aHhm?=
 =?utf-8?B?SHZxVE9VaTk0c1ZrekdXOXZxdk1HbmtOT0VwWGtpbjJiTXFiaDAxZjh3a1I3?=
 =?utf-8?B?a2ZWdGNLc2ZwTUN0VFpiVXVvbWlwL0kzSkx1VktGR0JYcTdiUkZWV0UvTnQ2?=
 =?utf-8?B?K09vQnJ6N1hEN1J5RW5XQkJXVDlRWTkwRG4rVVNWQ2gvbmdoSnZuU2lRSU5s?=
 =?utf-8?B?VThQRUJUR3NRZXFhR3ZXWnJyTnpCWDNsY3lxTTlZNHJSYTFOMEpKcExBWmRU?=
 =?utf-8?B?eU0vaE9WTmt2KzNqbjF6c0NjU3Ixc2JVM3BuZUlEOXBJRDExRmRUV1BneGNr?=
 =?utf-8?B?WFBnUk5tTlZOSmJXK1oxQlhyc0pwaW9OSE1vL2ZVbG1rQlQxL2wySk04cjBT?=
 =?utf-8?B?bm12cXUzNFF0bUljdi9FZWhNZGdZazZuTUZYNTl4ZU9xOUlSdmpnNkN2Y2VT?=
 =?utf-8?B?a0thNDBnQXZiQm1MTU9YVURXc09rc1NrQktmZER1b0tJSUZrdy9LMDBZRVY2?=
 =?utf-8?B?azNVVlpUQ0NTcFZtSWg1UGEvTmhhOGhoSkZYYUdJR2pXOW5VVXE0MkJlMDl2?=
 =?utf-8?B?SE15L1hoaDZFWHpub3dEdUJLRm5iaEdjK3BBYWxzSk9zLzRHOUdsaWl1N1Jm?=
 =?utf-8?B?ZXFoYkVicHBLZEFuZ2RoMDlqcm5qQ3g2dDVQQzNFVnl1TTcxSnNLNmNWZUJG?=
 =?utf-8?B?L2tsY3d2R1FQM05JM3ZUVlBoY1laTElEU0pRMkNscGkwSE0rTXM5QkUzUWF2?=
 =?utf-8?B?emZqRWp2WG9PVENDZmc1cjRhalM2T3U1dGQ5VXc1alpCVi90VTV6SDN3NFhz?=
 =?utf-8?B?cGJYZlNLc1lPKzc5am1Bb0RLOHl4UnJIaFE3TlNncmw2VG1hWXNQOVkxYUpZ?=
 =?utf-8?B?U2o2clA0Umw0ZWNoWnlRQmx0cnZ2NnlhRWNzaTdLcVE5QnFscGtETzFKRldT?=
 =?utf-8?B?SEErd1hhRUtkQTlob0lMd3hVcVRjUGxUOEcrUHU0Y0JPNlpIRXJqZytzN2JH?=
 =?utf-8?B?djJoRE1BZUlQQzNJWjlxcllHRTMyUTlLSDZhNy9UeG1NbUlmcG1PRFJjYk9i?=
 =?utf-8?B?NG5qUlpSVEpraVk5UEpqcnlyOFNEd3VLcDZ1QTBoK1REZ2t5ZS9XQ2thUEFO?=
 =?utf-8?B?ZXhFUUtYZGFtMENPeGt5K3JBWDhOcHRpYjlVandTa2Q0UlVySll4V2haQ2Ju?=
 =?utf-8?B?ZGVGN1BxWnBzV3FSUlJ3NkNCOWVYay9RSWhPNUtXL2x0eFRtcTh3ayt0WjRv?=
 =?utf-8?B?SHZxejBwN1ZiSVdyQk4rNFpnT3FuRFNJQk5ORm54Z21hbmI0YlRYWGlhcFhn?=
 =?utf-8?B?Y0tuYXJWdU9FRy9XY2FTRGxwaFFJS2E0aEhqRFFRcE11M2xyY0xMS3E3MGQ2?=
 =?utf-8?Q?FaM1JV5mPNejaPvWDfL6We7wM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7499.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae52b0eb-8828-4648-d1f3-08dd2fa51206
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2025 05:26:57.4514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4I5DvHwUPypihoNwxxqQ4p6xsC+C/cbMFQYgo/JQBMNKKQDX8mAtSiFOLUMs88gcIvYKwI/7MWJp8PTOWY1l7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8406
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFJvc2Vub3csIEphbWVzIDxq
aW0ucm9zZW5vd0BtdHMuY29tPg0KPlNlbnQ6IFdlZG5lc2RheSwgSmFudWFyeSA4LCAyMDI1IDY6
NTEgQU0NCj5UbzogeGVub21haUBsaXN0cy5saW51eC5kZXYNCj5TdWJqZWN0OiBSZWxheCB0cmFj
aW5nIG5vdCB3b3JraW5nIGZvciBtZQ0KPg0KPkkgYW0gdXNpbmcgWGVub21haSB2My4yLjEgb24g
NS4xNS41Ny1kb3ZldGFpbCBhbmQgSSBoYXZlIHNlbGVjdGVkIHRoZQ0KPmZvbGxvd2luZyBrZXJu
ZWwgY29uZmlndXJhdGlvbiBvcHRpb24uDQo+DQo+LmNvbmZpZyAtIExpbnV4L3g4NiA1LjE1LjU3
IEtlcm5lbCBDb25maWd1cmF0aW9uDQo+IFhlbm9tYWkvY29iYWx0ID4gRGVidWcgc3VwcG9ydA0K
PlsqXSAgIFRyYWNlIHJlbGF4IHJlcXVlc3RzDQo+DQo+V2hlbiBJIHJ1biBteSBhcHBsaWNhdGlv
biwgSSBhbSBnZXR0aW5nIE1TVydzIG9uIG9uZSBvZiBteSByZWFsLXRpbWUgdGFza3MsDQo+aS5l
LiBzZXFUYXNrLTAwIChiZWxvdykuDQo+DQo+RXZlcnkgMTAuMHM6IGNhdCAvcHJvYy94ZW5vbWFp
L3NjaGVkL3N0YXQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0ZXN0OiBUdWUgSmFu
ICA3DQo+MTY6MzI6MTQgMjAyNQ0KPkNQVSAgUElEICAgIE1TVyAgICAgICAgQ1NXICAgICAgICBY
U0MgICAgICAgIFBGICAgIFNUQVQgICAgICAgJUNQVSAgTkFNRQ0KPiAgMCAgMCAgICAgIDAgICAg
ICAgICAgMzUyNjUxMSAgICAwICAgICAgICAgIDAgICAgIDAwMDE4MDAwICAgOTkuOCAgW1JPT1Qv
MF0NCj4gIDEgIDAgICAgICAwICAgICAgICAgIDIyMTY2NTQ3ICAgMCAgICAgICAgICAwICAgICAw
MDAxODAwMCAgIDk4LjcgIFtST09ULzFdDQo+ICAyICAwICAgICAgMCAgICAgICAgICA2ICAgICAg
ICAgIDAgICAgICAgICAgMCAgICAgMDAwMTgwMDAgIDEwMC4wICBbUk9PVC8yXQ0KPiAgMyAgMCAg
ICAgIDAgICAgICAgICAgMCAgICAgICAgICAwICAgICAgICAgIDAgICAgIDAwMDE4MDAwICAxMDAu
MCAgW1JPT1QvM10NCj4gIDQgIDAgICAgICAwICAgICAgICAgIDEyICAgICAgICAgMCAgICAgICAg
ICAwICAgICAwMDAxODAwMCAgMTAwLjAgIFtST09ULzRdDQo+ICA1ICAwICAgICAgMCAgICAgICAg
ICAwICAgICAgICAgIDAgICAgICAgICAgMCAgICAgMDAwMTgwMDAgIDEwMC4wICBbUk9PVC81XQ0K
PiAgMCAgMzExICAgIDAgICAgICAgICAgMiAgICAgICAgICAwICAgICAgICAgIDAgICAgIDAwMDAw
MDQyICAgIDAuMCAgW3J0bmV0LXN0YWNrXQ0KPiAgMCAgMzEyICAgIDAgICAgICAgICAgMiAgICAg
ICAgICAwICAgICAgICAgIDAgICAgIDAwMDIwMDQyICAgIDAuMCAgW3J0bmV0LXJ0cGNdDQo+ICAw
ICAzNDIwMSAgOCAgICAgICAgICA4ICAgICAgICAgIDU0ICAgICAgICAgMCAgICAgMDAwNDgwYzAg
ICAgMC4wICBjb29wc190YXJnZXRfbWFpbg0KPiAgMCAgMzQyMDMgIDcxNDQyMCAgICAgNzE0NDIx
ICAgICAxNDI5NzU2ICAgIDAgICAgIDAwMDQ4MGMwICAgIDAuMiAgdXNlckN5Y2xlDQo+ICAxICAz
NDIwNCAgMiAgICAgICAgICAyICAgICAgICAgIDU3MTE4NCAgICAgMCAgICAgMDAwNDgwYzAgICAg
MC4wICBjbG9ja0ludGVycnVwdA0KPiAgMSAgMzQyMDUgIDEgICAgICAgICAgNTcxMTgzICAgICAx
MzU2NTU5ICAgIDAgICAgIDAwMDQ4MDQyICAgIDAuNCAgZGlzcGF0Y2gNCj4gIDEgIDM0MjA2ICA1
NzExODIgICAgIDExNDIzNjQgICAgNzEzOTgyICAgICAwICAgICAwMDA0ODA0MiAgICAwLjUgIHNl
cVRhc2stMDANCj4gIDEgIDM0MjA3ICAxICAgICAgICAgIDI4NTU5NCAgICAgMzU2OTkzICAgICAw
ICAgICAwMDA0ODA0MiAgICAwLjMgIHNlcVRhc2stMDENCj4gIDEgIDM0MjA4ICAxICAgICAgICAg
IDE0Mjc5OCAgICAgMTgwOTYzICAgICAwICAgICAwMDA0ODA0MiAgICAwLjEgIHNlcVRhc2stMDIN
Cj4gIDEgIDM0MjA5ICAxICAgICAgICAgIDIgICAgICAgICAgMyAgICAgICAgICAwICAgICAwMDA0
ODA0MiAgICAwLjAgIHNlcVRhc2stMDMNCj4gIDEgIDM0MjEwICAxICAgICAgICAgIDIgICAgICAg
ICAgMyAgICAgICAgICAwICAgICAwMDA0ODA0MiAgICAwLjAgIHNlcVRhc2stMDQNCj4NCj5UaGlz
IGlzIGFuIGl0ZXJhdGl2ZSB0YXNrIHRoYXQgaXMgZXhlY3V0aW5nIGF0IDIwMDBIeiwgSSBnZXQg
MSBhZGRpdGlvbmFsIE1TVyBmb3INCj5lYWNoIHJ1biBpdGVyYXRpb24uICBBcyB5b3UgY2FuIHNl
ZSB0aGVyZSBhcmUgbWFueSBNU1cncy4gIFNob3VsZG4ndCB0aGUgdHJhY2UNCj5idWZmZXIgYmUg
ZnVsbCBvZiB0aGVzZSByZWxheGF0aW9ucz8gIElmIEkgY2F0IHRoZSBidWZmZXIsIEkgc2VlIG5v
dGhpbmcuDQo+DQo+dGVzdEB0ZXN0On4kIGNhdCAvcHJvYy94ZW5vbWFpL2RlYnVnL3JlbGF4DQo+
dGVzdEB0ZXN0On4kDQo+DQo+V2hhdCBhbSBJIGRvaW5nIHdyb25nPw0KDQpBY2NvcmRpbmcgdG8g
dGhlIGNvZGUgWzFdIG9mIHhudGhyZWFkX3JlbGF4LCBzeXN0ZW0gb25seSByZWNvcmQgcmVsYXgg
dGhhdCBub3RpZnkgaXMgbm90IHplcm8uDQpBZnRlciBzZWFyY2ggeG50aHJlYWRfcmVsYXggdGhh
dCBwYXNzIG5vdGlmeT0xLCB3ZSBjYW4gZmluZCB0aGF0IG9ubHkgdGhlIHhudGhyZWFkX3JlbGF4
IGNhbGxlZCBpbg0Ka2VybmVsL2NvYmFsdC9wb3NpeC9zeXNjYWxsLmMgd2lsbCB0cnkgdG8gc2V0
IG5vdGlmeT0xLiBUaGF0IG1lYW5zIHRoYXQgL3Byb2MveGVub21haS9kZWJ1Zy9yZWxheCBvbmx5
IHJlY29yZCByZWxheCB3aGljaCBjYXVzZWQgYnkgc3lzdGVtIGNhbGwgdGhhdCB0cnkgdG8gc3dp
dGNoIHByaW1hcnkgZG9tYWluIHRvIHNlY29uZGFyeSBkb21haW4uDQoNCkFsbCB0aGUgcmVsYXhl
cyB0aGF0IHlvdSBvYnNlcnZlZCB2aWEgTVNXIG1heSBub3QgYmUgcmVjb3JkZWQuDQoNClJlZ2Fy
ZHMNCg0KSG9uZ3poYW4gQ2hlbg0KDQpbMV06DQogICAgICAgIGlmICh4bnRocmVhZF90ZXN0X3N0
YXRlKHRocmVhZCwgWE5VU0VSKSAmJiBub3RpZnkpIHsNCiAgICAgICAgICAgICAgICBpZiAoeG50
aHJlYWRfdGVzdF9zdGF0ZSh0aHJlYWQsIFhOV0FSTikpIHsNCiAgICAgICAgICAgICAgICAgICAg
ICAgIC8qIEhlbHAgZGVidWdnaW5nIHNwdXJpb3VzIHJlbGF4ZXMuICovDQogICAgICAgICAgICAg
ICAgICAgICAgICB4bmRlYnVnX25vdGlmeV9yZWxheCh0aHJlYWQsIHJlYXNvbik7DQogICAgICAg
ICAgICAgICAgICAgICAgICBtZW1zZXQoJnNpLCAwLCBzaXplb2Yoc2kpKTsNCiAgICAgICAgICAg
ICAgICAgICAgICAgIHNpLnNpX3NpZ25vID0gU0lHREVCVUc7DQogICAgICAgICAgICAgICAgICAg
ICAgICBzaS5zaV9jb2RlID0gU0lfUVVFVUU7DQogICAgICAgICAgICAgICAgICAgICAgICBzaS5z
aV9pbnQgPSByZWFzb24gfCBzaWdkZWJ1Z19tYXJrZXI7DQogICAgICAgICAgICAgICAgICAgICAg
ICBzZW5kX3NpZ19pbmZvKFNJR0RFQlVHLCAmc2ksIHApOw0KICAgICAgICAgICAgICAgIH0NCiAg
ICAgICAgICAgICAgICB4bnN5bmNoX2RldGVjdF9ib29zdGVkX3JlbGF4KHRocmVhZCk7DQogICAg
ICAgIH0NCj4NCj5UaGFua3MgYW5kIHJlZ2FyZHMsDQo+SmltIFJvc2Vub3cNCj5NVFMgU3lzdGVt
cyBDb3Jwb3JhdGlvbg0KDQo=
