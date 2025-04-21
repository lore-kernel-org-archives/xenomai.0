Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E0BA2D
	for <xenomai@lists.linux.dev>; Mon, 21 Apr 2025 00:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745194116; cv=fail; b=duA4O6oOsBBbfaARcqkpUxlHcJZ5pq6mD+t39jztHVfpYR2avJK42kDwik3KP7UsC/2cgadRaAaksfunZTwYFcKqghVgGbXkgH6A4xP4Kh7cjsShIo7yvW+uzW+ZFLX2aetvXoyKLkSQGHqzmkcCoA2bJLHfQckEME6kZQKEZ/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745194116; c=relaxed/simple;
	bh=A2IART67hKNLZ3M5zViZYkoRJO4hKSG7h3lWw0q9d9g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aHJqO6HDcHrd5bVxfxNAR9LbcKdeEiJ+WtqhOsrKrUlgH6bLIoOOani/34jMWrINs6UfjkFay2cWfml2ejASK+z4MSrzk17Fx7uq7pX0dMHUjR2y18l6EdCZVdz2skrONzy492350A2eZADvuxo3uLJMLvgxAE8R0NQbAIGofuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UGAF64pW; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UGAF64pW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745194113; x=1776730113;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=A2IART67hKNLZ3M5zViZYkoRJO4hKSG7h3lWw0q9d9g=;
  b=UGAF64pWBUUlipHJ+K0eRlEqZWZZ7+LHLoOUjO7wG+bepSNJdP6fxeEV
   dNHvf4R83MytFInO/mrRQArACsNlnzKIi81cR5abyw/ZRnI4S8Qm+PYFb
   GS/aph9A73OUZKKWTpaEJ9QrjsblYCxqDdp5MwphFP02ZuyqD74FTBkpX
   uwPRk7u+7prkINqrCzAe7K747nLmROg56GrLzCc0wC8FeFvBQajSOPKHy
   qsqAPBnP/O5IJuO/+goqhwl8akKIKTbokYYY+O77VY4rbD0xqXT2HdrCu
   j5ndPrUeOGZmSYhVgrW2bAHTTUdIDeNE8JKFRO/lyX3J549l3BvGyOsE9
   A==;
X-CSE-ConnectionGUID: jv/HnBjCR4GpKA7niRDz9g==
X-CSE-MsgGUID: UdeStO0sTkiOL2iXjlqH/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11409"; a="46431945"
X-IronPort-AV: E=Sophos;i="6.15,225,1739865600"; 
   d="scan'208";a="46431945"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2025 17:08:33 -0700
X-CSE-ConnectionGUID: aFq1x8O4ThieXfFItwfJPg==
X-CSE-MsgGUID: 0Z3+zwX7QuGQjggUGUJZ9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,225,1739865600"; 
   d="scan'208";a="154738797"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2025 17:08:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 20 Apr 2025 17:08:31 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 20 Apr 2025 17:08:31 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 20 Apr 2025 17:08:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+42fgeJndK2f7nT+KSerdMGjBRcoBYouOgu6qSkvamN+e/ARmybQ863VC8lkbQ8hKl06s8KHZkejzUC0c7OPtpXl+rBthHiH7j5CH60Fu9iv83Vo5TEKgbTFlphTAMcm9AC+4CPg8+rWH+/mGfXpsmXBXJEiEw3jbo7JlF9Oie6GpQC5jcmkhLxyrfBqnKYyVwc8x7Zzls+CSuWGH5m6s0MiSOg0d6B01t/aUr+Jf9ddmWaGkBHKGoAHx9t5z8Jn+tre7LIr0JwnutjJCzVFWWkuXswKrnzI3foZlgd2nwQYqh1Xon0WZpYKfINDbwDUAnIHPoG97GtfjDmWK2gZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2IART67hKNLZ3M5zViZYkoRJO4hKSG7h3lWw0q9d9g=;
 b=ndemvpSpVdi9Vku2BiX0ze+lECmDgqzQhx3RCmTDkpX1b+QdhEq+My/GwDDbj0xhcm2j46ebCWBWnMVM4KmeF/4NbQzHLfANUxn+Lxq+tRRfj1x1D3Eh2WJFEvtCNCnW+SV/hyrJNFLwYQFeoKvIOVrCOhlG3xb3rVuWEiX7s0mmh5nzCxIXq9RuJSw6VyM4XUQGlHdjX5WJPDL8HuJOi3y5jwYgGXGlpzbBM/lULizoWEmBorePo0IhCPNz0yjoyuM5yPu9i+rpN91zcUtg8tKWUzQur5DYuYtb7v6dCe3OnOkvHZRAYBQq3ub5+YQtEXobv8RUfzlVM+u9+JfozQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6513.namprd11.prod.outlook.com (2603:10b6:208:3a3::7)
 by IA3PR11MB9327.namprd11.prod.outlook.com (2603:10b6:208:57a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Mon, 21 Apr
 2025 00:08:29 +0000
Received: from IA1PR11MB6513.namprd11.prod.outlook.com
 ([fe80::8012:e01:4c01:d824]) by IA1PR11MB6513.namprd11.prod.outlook.com
 ([fe80::8012:e01:4c01:d824%4]) with mapi id 15.20.8655.031; Mon, 21 Apr 2025
 00:08:29 +0000
From: "Qiao, Wei" <wei.qiao@intel.com>
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>, "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
CC: "Chen, Hongzhan" <hongzhan.chen@intel.com>, "Pirou, Florent"
	<florent.pirou@intel.com>
Subject: RE: Build error of kernel/xenomai/debug.c
Thread-Topic: Build error of kernel/xenomai/debug.c
Thread-Index: AduvcNIP6fYojmwUSlGjpzfO8h3ARwAA+zCAAACQPoAAK7b9gACF9hAAAATet6A=
Date: Mon, 21 Apr 2025 00:08:29 +0000
Message-ID: <IA1PR11MB6513FC978522428982B0A30A8CB82@IA1PR11MB6513.namprd11.prod.outlook.com>
References: <IA1PR11MB6513EB0131E06C8CC865E8EF8CBC2@IA1PR11MB6513.namprd11.prod.outlook.com>
 <72c2c5cb18b635f1145c35b6592c661cf55aeb0f.camel@siemens.com>
 <370f022e-d5e3-46f1-a19f-5448afeebb61@siemens.com>
 <IA1PR11MB6513A045F8ECB1186B65DA9A8CBF2@IA1PR11MB6513.namprd11.prod.outlook.com>
 <4342e7e1-a7d4-431c-8fcc-f7731d3938d9@siemens.com>
In-Reply-To: <4342e7e1-a7d4-431c-8fcc-f7731d3938d9@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6513:EE_|IA3PR11MB9327:EE_
x-ms-office365-filtering-correlation-id: 261bd268-e762-4b89-acb4-08dd8068a56e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VmgzRUdXdkN3NGV0YU0vdURQZTFXbjg3TVVVOW0wMXhNdkdCRGdrMkxqdGR5?=
 =?utf-8?B?VHVoYkd2U2h5c0FKUlBGclkrR2RTRFR6M2gybnRDWkhndEdzOEVlekRSNUk5?=
 =?utf-8?B?Tkk0bjNHVlN3dkM4SjBKOVFkSXhxckw3QXRmOWpYekUwOFpKd2k3elgvd1NE?=
 =?utf-8?B?RDRwUytBcDlKNFFyTHI1UnZSZUJpMTlqRnAwN1dUaTVnWG85N2FWeWRaZk9V?=
 =?utf-8?B?UDlVOG10YUtmZmo1dkNoTTNqTzBQVXBTL1ZxdGRHaGhoRUo0eHduTDVOMWZx?=
 =?utf-8?B?byttQlZZVkszRVo2VHVqU1ZKWEdKVFRCcTdKaFZ6dDBGSGVyTDd5eFZST1pD?=
 =?utf-8?B?bjNPQTU3WTVpTjcybEV6bVV3aFc1aFJTT0lSd2xiTWVRVEFZaTl0bWh5Z2dK?=
 =?utf-8?B?ZlV0dnBWZ2ZPaU1lZGVYUXVRWHpqRG9YZzJwZXBKUVRJUkpuUndzRG53cldV?=
 =?utf-8?B?TVhJL0hEeGNqNkpVTzRHYk90ZFgxWWZvNSs0ZEtyYUg0V1Rhcy80bEJ3MVEz?=
 =?utf-8?B?ejFVTUNIQnVleWQxYWlUTm5qYWtmK3ZzY0ZGOWhtVGFEcTBRRjg2ZXpWL3B3?=
 =?utf-8?B?OGFJZjVkOUJ3eVBlaFJaV1Z4VmQwVFRjTXQ0cURnQUdJVXZlNi9wNEE3SEYv?=
 =?utf-8?B?dUpKRWNzUXBsQzhHRGFJM2t3Y3dCRWFRT2hoZ0pFRTRsSGhpMUk3OExSVUlv?=
 =?utf-8?B?Qy9oMmNMNXRHN2ZVdnBncS91RWtleHpqQWJ1aDNObFU2MkJIQU4vb0VPSjM4?=
 =?utf-8?B?TnY0Y1ZLNHN6U0hGTWE3eGpzRk9ZeHZvdCtIQWh1RTJlOXhmaHZQMW9UQVA2?=
 =?utf-8?B?ZkRtMUJ1NTFQQS9yNWhKNVNTYVRiWWFITEFqczV3NXhBYjZPemVycm5TOWll?=
 =?utf-8?B?SGFraEZTbVNKWHNDTUFCaGhKaDE4bzNtZ1IvVEh4K3E0RWRJTm1DMGxIZFVr?=
 =?utf-8?B?Q3pNRm1aQUMxaStkT2hqMkI0UUY2SGwvZVFsMU8wc3VIUjJPWFJCWHdzMUc4?=
 =?utf-8?B?V2FXRURiR1J4OEoxT1VYSzJ4d0FMU2pqeGxDbG5rZlJybWlGcE9kQ1BJbjlI?=
 =?utf-8?B?Z0xBb05sODlsditiV0JJY1hwTTNkSnVGcGxFaE9lUVVWTkdYc3BGKzMzTGRa?=
 =?utf-8?B?RmRpRDRqeTZVNlhNaWJ6MDAxWkNFRXVvaW5FQjM2NlNYV2tlVE5Rd3lwWkNT?=
 =?utf-8?B?ZXR6VFFKNnE5d1pjcXB1RnhrbW5hSi9LQW9hOGxnRzljZmQvQ1NmVXU3Vjlj?=
 =?utf-8?B?V3lqTUJpUFF3U1k0am1kblgwa1o1T1AzUUtLbVdkTGdCL3F2dHZMWXlSd1FG?=
 =?utf-8?B?ZWQzUm1hQU5xT01IaTlvUjVIeWxGcVE5NEFJTDFIRFUxNFAraHhYNEpERXJp?=
 =?utf-8?B?R0hiWWdDZFJMbFJXYWwwd2pGQmdvSmJiUUR3U0w5TXNtTjV3dXNHZWplMk9s?=
 =?utf-8?B?aHczV2hwUzRtQkcwQjFadkFWd0tvYWVtYTVoVm00bjNvcUdjZS9UTklUNXln?=
 =?utf-8?B?S2UycjNxTHR2RGxXQ21RbGloOWhWd0p3VlRGOHkyOXZpZTMxUGZNU1VWeGQ2?=
 =?utf-8?B?WEJvTmlGKzE1L1hFYUJseFJGeGo1TzNsck9vWTcvSU5IM3dzMGFOdFZsUlNt?=
 =?utf-8?B?THFjWmQySUtPNzM0Uk81NHozWWNyMmVnVURudCtNTndKdzllbVZzQjgzVisy?=
 =?utf-8?B?VUFOMnVVSzkyM1VMYjBtQm1PMUZScTU0MVgrdHNKekE4bms0azhaRW9YWWty?=
 =?utf-8?B?bzFuNU5zeTAzTjZCVzBibzBDQkY3b3dkejRoWS9YMUY1bHZzNjkxRnQ2am1H?=
 =?utf-8?B?S0Jxb3VuK2NmQUhaVDNBaW9pVkQ4bjIzUGVWZjRtcHhxTEJaT24raGRqTm1B?=
 =?utf-8?B?S2JWUXl1Qkc0NTRpeUZzSlAwYW5kVUwwTy82UXltRjdhS1dKTzNsRm43SkZo?=
 =?utf-8?B?aFl2NmMrdTlJQVhmMmtCVUJOTmRLeUl1SHlmZi9xSTRBSWpDeHJIa25FWC9j?=
 =?utf-8?Q?+Uv0Tm2ayplg9WOpzjkU1/A54MThlU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6513.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3ZzUXNkbkxBbCt2MFJNTnFuMTVWTFJuRU5Pa3FyRlJsektrOXRTN0c5VTUz?=
 =?utf-8?B?TjJ3cVpuR0QrQWlvV2MrcEoxRWcwU2Exd0RQdlRiRmdudW13Ym1RRWVIZnUv?=
 =?utf-8?B?MjlvUTB1a25INCtRT093cUdhbFpadUgxSGZmOE15ZWVZRkFlbFpmMzJqQkJB?=
 =?utf-8?B?UUtwU012SU5JdGZxKy9MQzRTTzcyNkdSVVJ4VWM2TVpRclFodmpMYkYxVXhF?=
 =?utf-8?B?ZUZoTzdjVE9aNHhrc3VadHIrU0VZMGxzMHU1S1FHeVY5KzFuTTNGUFhxWUFI?=
 =?utf-8?B?QVdKRExFRHZZR3lEWDRrRXU2Z0lyLzNvM3kzWTFwS2tGQzJCSGRZcVNsNmhR?=
 =?utf-8?B?SXR2NUZ0UkI4cEd3VEh3Q1V3MW16MXhFaCtYcXZhQkhjYWUwNmF2QThZRW5O?=
 =?utf-8?B?aEFsQ28rTzJ5WWNTcGRXUkJ3eUNseXc5aGo2UXFmdjdvZlEya0dLNnU4U3ZY?=
 =?utf-8?B?WS92OHRjUGszMmtqK0U3aXEzN2xUL0Vnc0NLNWFPZ1hXcitJZXVuYVZkQ3Jh?=
 =?utf-8?B?Z2RTWnlzeEpveGhWQnVhYXhrREpJTGFKNzYwMTN3azlWOUxqbXdsMlFlV2V5?=
 =?utf-8?B?T3hEWDBTV05GMENxN3AySXppK1BMUEYxMG9wbHArdGs1bWMyMGUwRGdQN01r?=
 =?utf-8?B?KzlqUmpxL0t1ZDkvNm9uODlCVWgwL2R4TVVyYWlIUk1PUWR1YWg1N1N0RkNW?=
 =?utf-8?B?eDRZYm55c2t0ak9kVHpuR1N4enF3NUpGRURyMkNvdXE4ZmNKTXQwa0VEZUxz?=
 =?utf-8?B?Z3hFeXNRMDBVNjVjZ3RMelVUNUQ1aml3TFFkcjhoRy9IZEhSK2RaWVZuVk1W?=
 =?utf-8?B?d3lEVGl6T3NucUd0aU9FOU5CSGt3UTNVdWlYSi9GSUszSnN5bGo2UzNhUER0?=
 =?utf-8?B?alpJMGZUV0M0VlpTdnJtOWlFL0x0WGwyTlkzdjdrek1aT1FGMGhxamhSQ0dw?=
 =?utf-8?B?dUVmeC9oMDE5c3ZJV1FDNnYvanJjNCtLTlFISi95cG1pZkNYRUJtUXRidDNy?=
 =?utf-8?B?cWJNUTB0UU1RUHJ3Q3JBRk11SlpLWmhlbzNBTWF5eFB0ZmZ4eDhVR1ArZlFk?=
 =?utf-8?B?UnFKVDEzVVVGWEk3Q21JUzQ1WnBURTBXajBLQ3NBK3BJWnppVW4ycUpYMVkv?=
 =?utf-8?B?YzFvbXNKaStpSS9aUWZ6SkdjRFNmRVo5SnExeFlmYTMxemQ4WFdwbW5JUGRZ?=
 =?utf-8?B?MktFZDhhQlVYMjRORkJwQXVCdEpRUHhOODhOZnF3ZGtGUS9TeStJYU04L2xP?=
 =?utf-8?B?TENDTWxjQnVkVld1dnU4Nk9vTXU4KzZEdlFCWFVOY05QVzFreUZwWTJkMU9P?=
 =?utf-8?B?VExPQkVhL1JuMno3eUo0cVkxNHlrWStqQWY1cFJvQ1VzSS91SVFZSXRjcUNL?=
 =?utf-8?B?bzVkR2R1bklKc0pKSllyL0VkZ25QRzViYVRuMVlxTWpVWGZwODkxL3NlUytl?=
 =?utf-8?B?WVprQVhjVW5NMTdSaGczZWFDMVdBT3dYMUJlM09JWTdCbk9tRGpEblAvWVhS?=
 =?utf-8?B?cCt1TmJSdEtYNG8zSytzMC9tWjIyMXQrYUhTajNzNnc2aFMvcElRcFkvVDZz?=
 =?utf-8?B?TmREZGFOU0g3UkExcC95SGNKakloRzU2NDVlc0gvM05ocVNwRGFybldWTmpW?=
 =?utf-8?B?MnBHcmZ4eGJyRkptaUw5WlJEeWc1VThCYnhHSXRKd2pOMXhudlFkVXdnVTBq?=
 =?utf-8?B?d0s3SzlncEU3T2wvSUtTUFp5RnQvSDJwb1lqd2R0QXhobnZDVEhabGYyeGNv?=
 =?utf-8?B?RWIxbDZRbXNCQ3BzUEx6TzFrOE4zUE1Dc0dlZ05XY1RIQU1uQUhuQXZmeWZH?=
 =?utf-8?B?Z2RrZWFmUVE5b1ptRlJlWDF0MUYwZFcwVGU5U0JyWU9WdElqOEZGQnoyR0NJ?=
 =?utf-8?B?ZDNiZFNPQ3dPQkhvWmhPRVhUd1NVZzloSTFFZTRtYktiNk9IZjZuWmVzWjB6?=
 =?utf-8?B?VlVSOEJvaXdZckc4QTNwZ2kwckk1dTRuSXQwQ3hvSERGVldYN0swQmY4d0V6?=
 =?utf-8?B?czZiSDY2NjA5SlN3UHV3b2FWSVJNSGNPMUo2VjViWVpMK2U4cElySWdITjdO?=
 =?utf-8?B?b3IwQTRwZkI3R0xqQXJjVVg2VVZVYjl3Z2N5T1ZtSnBxUUlWMjQvNDlKY1ht?=
 =?utf-8?Q?Ix3dkoHZvywaNXXi9YintWBhX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6513.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 261bd268-e762-4b89-acb4-08dd8068a56e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2025 00:08:29.6885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E9lLHziw+FniMnbDnrTDAJlh109uqWx6IUHPXJNoZk8A+0/WHv90ZirzDZvHaQkz2htZfgFjtVVnslqKHG6kog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9327
X-OriginatorOrg: intel.com

R2NjIHZlcmlzb246DQpxaWFvd2VpQHdxaWFvMjp+JCBnY2MgLS12ZXJzaW9uDQpnY2MgKFVidW50
dSAxMy4zLjAtNnVidW50dTJ+MjQuMDQpIDEzLjMuMA0KDQpLZXJuZWw6IA0KdjYuMTIuMTktZG92
ZXRhaWwxLXJlYmFzZQ0KDQpodHRwczovL2dpdGxhYi5jb20vWGVub21haS94ZW5vbWFpLWhhY2tl
ci1zcGFjZS5naXQNCnRhZzogdjMuMw0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJv
bTogRmxvcmlhbiBCZXpkZWthIDxmbG9yaWFuLmJlemRla2FAc2llbWVucy5jb20+IA0KU2VudDog
TW9uZGF5LCBBcHJpbCAyMSwgMjAyNSA1OjQ3IEFNDQpUbzogUWlhbywgV2VpIDx3ZWkucWlhb0Bp
bnRlbC5jb20+OyBLaXN6a2EsIEphbiA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT47IHhlbm9tYWlA
bGlzdHMubGludXguZGV2DQpDYzogQ2hlbiwgSG9uZ3poYW4gPGhvbmd6aGFuLmNoZW5AaW50ZWwu
Y29tPjsgUGlyb3UsIEZsb3JlbnQgPGZsb3JlbnQucGlyb3VAaW50ZWwuY29tPg0KU3ViamVjdDog
UmU6IEJ1aWxkIGVycm9yIG9mIGtlcm5lbC94ZW5vbWFpL2RlYnVnLmMNCg0KT24gMTguMDQuMjUg
MDc6NTEsIFFpYW8sIFdlaSB3cm90ZToNCj4gVGVzdCBwYXNzLg0KPiBUaGUgc3lzdGVtIGNhbiBi
b290IHVwIGFuZCB3b3JrIHdlbGwuDQoNCldoaWNoIHhlbm9tYWkvY29tcGlsZXIva2VybmVsIGNv
bWJpbmF0aW9uIGFyZSB5b3UgdHJ5aW5nIHRvIGJ1aWxkPw0KDQpJIHRyaWVkIHRvIHJlcHJvZHVj
ZSB3aXRoIGdjYyAxNSAtIHRoZSBsYXRlc3QgZ2NjIHJlbGVhc2UgLSBidXQgaXQgaXMgc3RpbGwg
YnVpbGRpbmcgZmluZS4NCg0KWW91IG1lbnRpb25lZCBVYnVudHUgMjQuMDQsIHdoaWNoIHNob3Vs
ZCBzaGlwIGdjYyAxMC41LCB3aGljaCBzaG91bGQgYmUgZmluZSBhcyB3ZWxsLg0KDQo+IA0KPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYW4gS2lzemthIDxqYW4ua2lzemth
QHNpZW1lbnMuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgQXByaWwgMTcsIDIwMjUgNDo1OSBQTQ0K
PiBUbzogQmV6ZGVrYSwgRmxvcmlhbiA8Zmxvcmlhbi5iZXpkZWthQHNpZW1lbnMuY29tPjsgUWlh
bywgV2VpIA0KPiA8d2VpLnFpYW9AaW50ZWwuY29tPjsgeGVub21haUBsaXN0cy5saW51eC5kZXYN
Cj4gQ2M6IENoZW4sIEhvbmd6aGFuIDxob25nemhhbi5jaGVuQGludGVsLmNvbT47IFBpcm91LCBG
bG9yZW50IA0KPiA8ZmxvcmVudC5waXJvdUBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBCdWls
ZCBlcnJvciBvZiBrZXJuZWwveGVub21haS9kZWJ1Zy5jDQo+IA0KPiBPbiAxNy4wNC4yNSAxMDo0
MywgRmxvcmlhbiBCZXpkZWthIHdyb3RlOg0KPj4gT24gVGh1LCAyMDI1LTA0LTE3IGF0IDA4OjE1
ICswMDAwLCBRaWFvLCBXZWkgd3JvdGU6DQo+Pj4gSGkgQWxsLA0KPj4+DQo+Pj4gSWYgd2UgYnVp
bGQgdGhlIGtlcm5lbCBpbiB1YnVudHUgMjQuMDQsIHRoZXJlIGlzIGJ1aWxkIGVycm9yOg0KPj4+
DQo+Pj4gZnJvbSBrZXJuZWwveGVub21haS9kZWJ1Zy5jOjIzOg0KPj4+IEluIGZ1bmN0aW9uICdz
dHJjcHknLA0KPj4+ICAgICBpbmxpbmVkIGZyb20gJ2hhc2hfc3ltYm9sJyBhdCBrZXJuZWwveGVu
b21haS9kZWJ1Zy5jOjk0OjI6DQo+Pj4gLi9pbmNsdWRlL2xpbnV4L2ZvcnRpZnktc3RyaW5nLmg6
Nzg3OjE3OiBlcnJvcjogY2FsbCB0byAnX193cml0ZV9vdmVyZmxvdycgZGVjbGFyZWQgd2l0aCBh
dHRyaWJ1dGUgZXJyb3I6IGRldGVjdGVkIHdyaXRlIGJleW9uZCBzaXplIG9mIG9iamVjdCAoMXN0
IHBhcmFtZXRlcikNCj4+PiAgIDc4NyB8ICAgICAgICAgICAgICAgICBfX3dyaXRlX292ZXJmbG93
KCk7DQo+Pj4gICAgICAgfCAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+DQo+Pj4N
Cj4+PiBUaGlzIGlzIGJlY2F1c2UgbmV3IGdjYyB2ZXJzaW9uIGhhcyBzdHJpY3RlciBGT1JUSUZZ
X1NPVVJDRSggPTMgaXMg4oCMc3RyaWN0ZXLigIwgdGhhbiA9MikuIFBsZWFzZSBoZWxwIHRvIGZp
eCwgdGhhbmtzLg0KPj4NCj4+IFRoYXQgaXMgdGhlIGZsZXhpYmxlIGFycmF5IHN0b3J5Li4uDQo+
Pg0KPj4gWW91IGNvdWxkIHRyeSBzb21ldGhpbmcgbGlrZSBiZWxvdyAoY29tcGxldGVseSB1bnRl
c3RlZCkgYW5kIHJlcG9ydCANCj4+IGJhY2sgaWYgaXQgd29ya3M6DQo+Pg0KPj4gZGlmZiAtLWdp
dCBhL2tlcm5lbC9jb2JhbHQvZGVidWcuYyBiL2tlcm5lbC9jb2JhbHQvZGVidWcuYyBpbmRleA0K
Pj4gMjViMTk0YzI2Li5kMDQ4ZGM3NTcgMTAwNjQ0DQo+PiAtLS0gYS9rZXJuZWwvY29iYWx0L2Rl
YnVnLmMNCj4+ICsrKyBiL2tlcm5lbC9jb2JhbHQvZGVidWcuYw0KPj4gQEAgLTQ3LDcgKzQ3LDgg
QEAgRVhQT1JUX1NZTUJPTF9HUEwoY29iYWx0X2RlYnVnX3Zmcm9vdCk7DQo+PiAgDQo+PiAgc3Ry
dWN0IGhhc2hlZF9zeW1ib2wgew0KPj4gIAlzdHJ1Y3QgaGFzaGVkX3N5bWJvbCAqbmV4dDsNCj4+
IC0JY2hhciBzeW1ib2xbXTsNCj4+ICsJc2l6ZV90IHNpemU7DQo+PiArCWNoYXIgc3ltYm9sW10g
X19jb3VudGVkX2J5KHNpemUpOw0KPj4gIH07DQo+PiAgDQo+PiAgc3RhdGljIHN0cnVjdCBoYXNo
ZWRfc3ltYm9sICpzeW1ib2xfamhhc2hbU1lNQk9MX0hTTE9UU107IEBAIC05MSw2DQo+PiArOTIs
NyBAQCBzdGF0aWMgY29uc3QgY2hhciAqaGFzaF9zeW1ib2woY29uc3QgY2hhciAqc3ltYm9sKQ0K
Pj4gIAkJZ290byBvdXQ7DQo+PiAgCX0NCj4+ICANCj4+ICsJcC0+c2l6ZSA9IGxlbiArIDE7DQo+
PiAgCXN0cmNweShwLT5zeW1ib2wsIHN5bWJvbCk7DQo+PiAgCXAtPm5leHQgPSAqaDsNCj4+ICAJ
KmggPSBwOw0KPj4NCj4gDQo+IEEgYml0IG9mIG92ZXJraWxsLCBnaXZlbiB0aGF0IGFsbG9jYXRp
b24gYW5kIGFjY2VzcyBvZiBhY2NvcmRpbmcgc2l6ZSBoYXBwZW5zIHdpdGhpbiB0aGUgc2FtZSBm
dW5jdGlvbi4gTm8gc21hcnRlciB3YXkgdG8gdGVsbCB0aGUgY29tcGlsZXIgdG8gc3RheSBhd2F5
IGhlcmU/DQo+IA0KPiBKYW4NCj4gDQo+IC0tDQo+IFNpZW1lbnMgQUcsIEZvdW5kYXRpb25hbCBU
ZWNobm9sb2dpZXMNCj4gTGludXggRXhwZXJ0IENlbnRlcg0K
