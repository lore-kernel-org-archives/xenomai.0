Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50763FBB3
	for <xenomai@lists.linux.dev>; Wed,  8 Jan 2025 03:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736306841; cv=fail; b=OZNVVJkBgLSDMFp1JPQMB3Y9qjCIyrf8FZGUWTeOaB+O2vJTkjBAIYyi+aqgHGo95zr0BD4PiBuDN6tkv84XgzgQqM/4sz/CaAD0gW1A052TQel0oCKxdZRKZWV6SgTJYjVMAGuMcuQuyaqg1r4BAXT8vbbIBEijdbqFYkh3R8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736306841; c=relaxed/simple;
	bh=GzpYGTSAq/kigA4U7w4YChKLxif6Wll417fUWK3nIYk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HLgBhBcSC5S5JPjtTa6S7ejN2JX8Kqym7tdAYwNWMuPF6etNjaaoAq7vRKnGFlMG/XBIb0KCxAJYI1Jv4q8r2yiiPJA1mLeFD4wrAL7paC9BBsNaOljXBX72Ws3BW7ZdjWiUZ/bUgwvNrhtKGB7/eJWzzy0HDbOscOktUbbPYiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jJQGO+DR; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jJQGO+DR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736306840; x=1767842840;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=GzpYGTSAq/kigA4U7w4YChKLxif6Wll417fUWK3nIYk=;
  b=jJQGO+DRVCQatgLSir6AdyrM7lt1nd/lwMbfKfaBRnOBXighaBMyMyBU
   L3I6YlVrEKz3zdVHK3eqAEz67DhVtn/iKjPCtq+51TSI1MGK3ax4daV1J
   s0i0M+UQ3KPubAFyT8tRx0uO6hg20JDrPj5KIiVudQCVnKOAd++bvqORO
   7dckC8mw8AZF5Ws414T7Y5vDx4Ko1mZVYxIn56Hz2CtU2NVjp7INzNw7n
   sG+Mu/eKSmkTUNkcJbkDp8FW/AaXjpZbVfsG2FOepF/9OynFAi1pNoBfV
   t4ZLSHAYe97XS/GUMovdYxyQf8iKWHRnmSR5Gbq5HH2gEoNK/+4cPCOKg
   Q==;
X-CSE-ConnectionGUID: nTKc3WBNTw62fdjpKEI+Tw==
X-CSE-MsgGUID: D2ZN/uikRlSV6jNsu678MQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="40463791"
X-IronPort-AV: E=Sophos;i="6.12,297,1728975600"; 
   d="scan'208";a="40463791"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 19:27:19 -0800
X-CSE-ConnectionGUID: y1ApjiT0QUGnsDcPsxxeaw==
X-CSE-MsgGUID: XgOOAbS3QHKHCudWCB+AmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102826245"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jan 2025 19:27:19 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 7 Jan 2025 19:27:18 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 7 Jan 2025 19:27:18 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 7 Jan 2025 19:27:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NCkv2MbSF4iuEQz3PABewxs1jo54ix09qYCLtRyvXBUraLFtPBSxFWOi5glWA0yDVqxHdEOaW8Piz1ICARE4FjsZONGPVSBvalC7jpaqzFv2bKyE9yWu4Dns+1ta5widftWwSTvZ8kobftTJOC3RCjokaD+Tod4zqo7Yq5qRXqgu5IhXeBnZAPNxpEc6Ja0eI/lWAEWvPG2vuSRmYj/JLtaJo4lcs2Xrs7odMTInXrANn/HXoNkx3dgHhN7ICuNcMsqCJ8NCtgQ5iJSG2VRGErYIRpj2y6KdDtwgt45JnGjM+tkDy1/Ii2GncBExCZyBrKng5eFpq067cEUkEVh/nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzpYGTSAq/kigA4U7w4YChKLxif6Wll417fUWK3nIYk=;
 b=Ws6859QTkIdiBzwmw/f6X8oyeRXKHuibXkT1CelOy/p9S8VsF+pAWuRYypEQWxftwjn4PtI3a4nYwJBYcQjvYujBH7TYZFrdydsOYFX6b2GXsT25GkA59ZYEOidiZS3gLvlhUyOvpfmlBkQUc2Op+Nwq7HfaGjBGYhgJJjTK37uiLzg3Do3jEd2fcEZlO9RXzVp3fosPL4+QXSGDsnWkpY/azbY/rCO7cN14v+UAAQtqFrE324V9V+WlYkCpAMogXu3G8hqMPh0FCQQJZGFVrKUOXlGla9ObRCLcv/G7b5fKfBYCkQN8JlH2JDwEX8eYpdCtsPYtVyHwr/jy4krLGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by SA2PR11MB4794.namprd11.prod.outlook.com (2603:10b6:806:f9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 03:27:15 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d%3]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 03:27:15 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Xenomai community call on Wednesday,  Jan. 08, 2025, UTC 7:30 AM
Thread-Topic: Xenomai community call on Wednesday,  Jan. 08, 2025, UTC 7:30 AM
Thread-Index: AQHbYX027pkn38rqzUuJWOJuVXV/Jw==
Date: Wed, 8 Jan 2025 03:27:15 +0000
Message-ID: <PH7PR11MB74997A20364527E81370A33FF2122@PH7PR11MB7499.namprd11.prod.outlook.com>
References: <PH7PR11MB7499F7DDE006A3A7291F61FAF27B2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749929DFFDCFE47376883636F2572@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749988D3E2C96C4F21DAEBE4F2212@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499C4BB71E159B3AB98D686F2332@PH7PR11MB7499.namprd11.prod.outlook.com>
 <DS0PR11MB7482613E8A9D78229EA71D07F2EC2@DS0PR11MB7482.namprd11.prod.outlook.com>
 <PH7PR11MB74993A52AA247D08069980E4F2F22@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499D816A0B79C85EF7CD712F2D62@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499161719AD2EC0D1651C48F2A42@PH7PR11MB7499.namprd11.prod.outlook.com>
 <DS0PR11MB7482106CBDA92B4A595D7363F2AA2@DS0PR11MB7482.namprd11.prod.outlook.com>
 <PH7PR11MB7499B238FF2BECBDD784752AF2B82@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749988D39A66B3EC8E9431E6F28E2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499BDD1032C1C09D4107EE7F29C2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499E15D2AD5555818A6E5C4F2462@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74993258CAA8CDDA598B287DF2542@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499E32BB1968236810DF6B3F25A2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74993347DB8F72364025EFEBF2282@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499E7C229D3943554AE31B6F23E2@PH7PR11MB7499.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB7499E7C229D3943554AE31B6F23E2@PH7PR11MB7499.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|SA2PR11MB4794:EE_
x-ms-office365-filtering-correlation-id: 74147960-fbce-4975-acbc-08dd2f94592b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UW5pZFBSMjNnemN2QVRqTi91U1RraGhsTXNjR3d2bmd4bzBlVm4wQ2U1cG9C?=
 =?utf-8?B?WUlGRG9LZzUweGFBWDFVMDk3Z3hqU2R5MmtMa1Q0eVM3a2NPRkRaVTRUd0NK?=
 =?utf-8?B?d1pacm9MMk42dTRQWkVteWYwdE5iUG5JYStRNUw0NEoyOXNlbFpyay8yaGhY?=
 =?utf-8?B?TDlqN3k3OEROa3pyRWJZd0gyeFY2S3FRK011eWZmVEx2VUVPWC9ML3haMmZw?=
 =?utf-8?B?NDFVb2UwT0RDaERMaEVyUjM5VFpWWVFsWWVqZlFiTkV6MS9VNWQxNy95dy9H?=
 =?utf-8?B?NkhVL01rT0diYmZJR01oRFl0L0M2UENCclBiU2JKVytDdmpzMHJSMStFTGZC?=
 =?utf-8?B?dGkxV1Y3TkYweSs5UlFmK2E5UVo2S2tQNlM4cXkxNW93VllYWm4wOUtvdXBV?=
 =?utf-8?B?QzlGYkE2ZGlRZEx4dGNSOTZoZnFvU2FIdTBqU0M3WEZMWGFkR3BVa3BMWmtV?=
 =?utf-8?B?eVdNcklwYlE4NjlLd0ViVnRkdEIvSnlUYUttV1pudklYRjJtczNxWHhlZ1Jv?=
 =?utf-8?B?eXBNNjQ2QXlBNm5sK0N1Q2dMN1cybDNIdmlNc0VkU3FKZ2NyZ0p4ZnppK2RR?=
 =?utf-8?B?OGpJRm9FVlVWZjlzU0wrQm5BaGNGZUhUQzRjVHRpRmFLSE9FTUxyQ2FXTlQ1?=
 =?utf-8?B?bStzMFBMOGl6dmo4Z3BiTkVneFdhbjJtODdxTzVFN1d0VkxPNVRzWEVVb3Jx?=
 =?utf-8?B?dm9rZFMwRHQ0enREVHV3NDcycjloWWpWVXVIcForL3AyaGFSY3Zqbi8yNW9U?=
 =?utf-8?B?WFpXS1JvQW1Ec0U1eGVPOXVmeGQ1LzhSK3NJL0N2Ym9hSmc5ZEJtR1drdDdX?=
 =?utf-8?B?WWZhYU1VWGNpNWNZeXh1Q3RHQ2YxV0hWSVMrelFKalI4YThqVjF4QkVhU3V1?=
 =?utf-8?B?eE9mcStnTmplSEh5eGl6ZjNBZWlJYVBMZHBFc21YOE9ESjFUR2ZXQTBhRmh6?=
 =?utf-8?B?M3F0K0FiUlkxSXhoKzN4N2N4K2Z0U3lRUTdjNGZhYnVlNU4ycU1zZVFNQ3pa?=
 =?utf-8?B?aExJdXZ4NUFUVnNXRzRtbUpSbmx3U3BzMUh4ZWV6ZXlnWmtQc1ZtM3FqcGM5?=
 =?utf-8?B?UEtJb2lQSkI1QmgvNHJHOGJiM0lQcGxnRTFGTWtKdkRWR2hrM3lYdzNTWFZH?=
 =?utf-8?B?N3V3U0g5L0lVMld1VHBWandNNUlhMEJldkpOZ1ZDRDc4bzhGK21WcWZzb25Y?=
 =?utf-8?B?ZFd3V05raWFCWlhXM2pMTEFiUUVGZ0ZMc3c4Q2c0YlFTUkQyME1xS2UvSkxX?=
 =?utf-8?B?UUNNVjRLR3pkd2piVEpXV245RXRKSStGOTFqalZ0U1VnUWo1UHB1RkZvWWlv?=
 =?utf-8?B?NDZNeUFOT0tQK0dZYzljRWJyNG1mMEJ6Y3UyUDJZaVRTd2xsc3ZzVDAxeGxw?=
 =?utf-8?B?L0k5cGZKVUZnQmhaVE1kYnpJMElENUhEclNMdHhWb0hrcG5GaEZGYkR4M0R6?=
 =?utf-8?B?cWM0REFwMHJldUY0WTZLcDNmbkhNYW9NdzdINWZqeTdteXd4cGVCaTYyRTEy?=
 =?utf-8?B?aG5aVUZsdTVzZ0JXZ0Fod1lwMWNqUCtHd29maytuUFNNZXhLK0RLc0cyM0FN?=
 =?utf-8?B?THNsbFUwNFJLaHByc253NzJKb3dhbi9GZVRINzkrWGhQeWRibW02WWdXTmpi?=
 =?utf-8?B?eFlKQmxXdVV5cDRXNitiTTBJdHlDMDJ4dVJZZnNDYko5MFArNllpblZkNnho?=
 =?utf-8?B?cmY2bkV4NlRSdkszVXZZMVdOSHk1aTV2d1VkWVVjeGtYQk9rTHVIV2o4cVps?=
 =?utf-8?B?SHlpK25VL2UvSDZscTZrRUpuMTdiVjM1WHNlWGhXbStCd2lHTmNEbFFHTUxt?=
 =?utf-8?B?L05hRU1rNGRqN0tXQ1pad1FYNEdwa3V6aHV1Q1ZhazhBSFJQZmxhTzFEUDV1?=
 =?utf-8?B?N3g0T0cvLzZVNEhYZHZYWjcwb1dYY3dVTDRXS3J0L1ZJQnc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WE02OVlwZHZVQkl3c1JvR3hKaHU0aGtsNllScXppZGN0V3ZiZ1V0UjFhTHZH?=
 =?utf-8?B?ZUFYTzJxczNUV0loRmxNN1JQUmF3NTB0ZUJCenpsUm42L0kwR3lYUGlUTFRz?=
 =?utf-8?B?NjBlWVlGQWRINlUrWEFMb3hGM1JSSmk1R212TFdtSk5PSzJxcGRMU3ZwRzlU?=
 =?utf-8?B?aGk1UVFiUW1IWlp3c3FkOVFPSVc4UUNlTzdoT2d4TnRPR0JXVmVpdTdwcEM3?=
 =?utf-8?B?Nmhhd0xMVmxJZ2ZDVW11Vm0xWDkwTzdjWGV4TUh5YUp1MXJiVFMrZFlVN2VO?=
 =?utf-8?B?Ty83MmRHQzI3Mk41Ykh5cWV0M21qNnJ4TkxlbGJ3bFNQVzgxZU5VQjNzY1Ez?=
 =?utf-8?B?RXpyMDYvcjA3a3lOZEJvQkpISFp3c1ZHdzZOZGRBcnVxRUNqZWw1Y1FTbjJR?=
 =?utf-8?B?R1J2TjJjOFF1dXlGcE9CM1lkVDU4M0F0QXJiWFdJWkdHNmQ1V2ZOSUN1dUhs?=
 =?utf-8?B?S3BkbzhOazUzU2M3V1AvNDFWMHhqUGxTeGhuSFNrUXUxZVluaE9QM3FNaS95?=
 =?utf-8?B?cGhiNXZYVTFhUHNJK1R2TnVacDlmQW5lZEloZE5qWnhDbzJ0QVF3QTFURnJI?=
 =?utf-8?B?d1VCekFKVzZnS3YzbnFPTTJUWjUwR3pGMGpzZWkyazNOcHVFYmZQMjV2SUIv?=
 =?utf-8?B?eGFNeDBsc3ROYzVudklJWFdjbG1yQkhXMER5VkY5ampTR2Vsa0FkY05xcXVU?=
 =?utf-8?B?UVRmSDM4dHlvaE8zaXV2NDBSeFBYSkYyQmNNaWtVVWQyV1FGRWx6b09pVGJB?=
 =?utf-8?B?a00wdmZFekRuVERveXpXOEsyamNQcDU0RFA2cUFDNUx4VGUrUXdxQzJ5YldK?=
 =?utf-8?B?c0QzYXNVSmZBeEN5czFIazhUMVpUazg2RTlHZVVOTGgvUFNyRnFPVWx4RDhv?=
 =?utf-8?B?czlwTWYwOEJDTlRlVWJkRzhkV0dxaG9oM3JtUDFGLzl2T2R5alNmRytsNFhh?=
 =?utf-8?B?UjlteThuZXZFTWY1c0MzcC8rZm1BNGZQNThOOE81a2FmV2Y2TGIyVm5MTEEr?=
 =?utf-8?B?VVlyWGwxU3gyOW9CNENXdzVSYzhYeE5xYWxmZ1NKZ0U1b1k4RFowSnJJRzlD?=
 =?utf-8?B?bkZWYzRaOWFkZ0x3L2pObnBnUHV3WWhOZ3QzQVlpMmhKaFE0OExBenpPa0sv?=
 =?utf-8?B?Z3JsOVlkaVoxUlFrMkdCbmlGamJwa2ppcDhlcWQydWJOc2J2RHpQaEFkbG9D?=
 =?utf-8?B?NXhYNTYrNFZ1QjFNaUZJV2x1aEg4aGh6UU5YRitMNXF3bzFYeXUrVXJrdDhh?=
 =?utf-8?B?dm1SVnN0MDhDQmordjM0VmlGR0xmelVrSXl6MUZTN0tURDZRNkx2RUxyOGZC?=
 =?utf-8?B?TlJ6b1M0a0hwejdxYzJDWXE5NmlOcW93Z3pEZ0tFTm1kTEs2YXpvcGk2aWhK?=
 =?utf-8?B?cFJrVFk3Wmd1UHl2bndtbUZvVXUweFYwVkROT25XdWNPWVRNZmh5RU5najFs?=
 =?utf-8?B?NHhDNVVRMXVEcnRaUml4cUpQM1FZd3g5NTVKelg1aXAyLzZsTVlXV3R3bW5t?=
 =?utf-8?B?TlNhWUVyUlNmSzRvUGZ3d2MwWnhJV3RMeitlOGNicjlKSHFybU5PS3NCWkR6?=
 =?utf-8?B?UHlJN2ZWMlVJdWRuc29xTU1ZS0ZiODIzS0RQdVlFNm1EK2Y3UStTS1kyRCtZ?=
 =?utf-8?B?bk0vSlBRa3IraU52bFBUMk5RSjR4SUZhMHVNSWNGK2ZLeDhSV1l4UndnMzNj?=
 =?utf-8?B?emFDa29jMlRKRkVHdnV5ZGZXMUEzOHFqRGFtWVU0QTJ2bGdscVFrVDJmUjNw?=
 =?utf-8?B?MCtxdWRURU9XVndDR2ZMMGNHcG9EOVFNbEVDS3BxWnpkWnZiRkFwakc2RCtw?=
 =?utf-8?B?bllHTEI2UGNyQStaMUxlM2RBcGR2STM2Wm04ME9ITWxCV1pGZlQ4MjNhc3hH?=
 =?utf-8?B?WnRCeDdNY3lTL1RzSk9WQTdENEdBeU4zbWNBNk05c3BhSHI5WHlJVUNERUpi?=
 =?utf-8?B?anpQcSs5L0NENDV3L0ZlRnRSSlQ4YlUwUmtFUDh6Q1NCSTRueGhWa3BzOWlF?=
 =?utf-8?B?Q201SjVoZlk1QmhJV2lmbmw3bkdWSzJieWg1S1pQUGp4VU1KOC9rZHJMVFI1?=
 =?utf-8?B?NDNSL3c5YXh2YmhzRG1BV0Y2M2xlcHpLNmFFY0J0SC9QajcvK2JzSmdldlh2?=
 =?utf-8?Q?M8Y9dxdS14tBnu/7OTm2nloDq?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 74147960-fbce-4975-acbc-08dd2f94592b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2025 03:27:15.3574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PbeW2s0lmHrBfZCECUtb6aUv7JIpFVmHO6/4ORGexdVc+POKCkjamf14abxvVRLGNxua8CvVWkJxmlIycvxKbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4794
X-OriginatorOrg: intel.com

VG9waWNzIG1heSBpbmNsdWRlIGJ1dCBhcmUgbm90IGxpbWl0ZWQgdG8gdXBzdHJlYW0vZG93bnN0
cmVhbSBwcm9qZWN0IA0KcGxhbnMsIHN0YXR1cyB1cGRhdGVzLCBhbmQgdGVjaG5pY2FsIGRpc2N1
c3Npb25zLiBJdCdzIGFuIG9wZW4gb25saW5lIA0KbWVldGluZyB0aGF0IGFueW9uZSBjYW4gam9p
biBhbmQgYXNrIHF1ZXN0aW9ucy4NCg0KVGltZToNCldlZG5lc2RheSwgSmFuLjA4LCAyMDI1LCBV
VEMgNzozMCBBTQ0KUGFyaXMsIEZyYW5jZSBDRVNUIDg6MzAgQU0NCkNoaW5hIENTVCAzOjMwIFBN
DQoNCkpvaW4gWm9vbSBNZWV0aW5nIA0KaHR0cHM6Ly9pbnRlbC56b29tLnVzL2ovOTEyOTcyNzky
Njk/cHdkPVdtZHdTMHBET0RSTk1TOXRRazU0WTFkdmJGbHFVVDA5DQpPcg0KaHR0cHM6Ly9pbnRl
bC56b29tLnVzL3djL2pvaW4vOTEyOTcyNzkyNjk/d3BrPXdjcGs1MmE5Zjk2ZDk4OWU3ZTIwYjYy
OGMyYzM2ZTQ4YjY4ZQ0KDQpNZWV0aW5nIElEOiA5MTIgOTcyNyA5MjY5DQpQYXNzY29kZTogMzY3
NTI4DQoNCg0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQo=
