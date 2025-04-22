Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E9C230273
	for <xenomai@lists.linux.dev>; Tue, 22 Apr 2025 08:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745308935; cv=fail; b=M/dW08FGAzV31LE8R2AY43ZHXbq9sGjlmC5c0/0TKO4dcOJ6ipbxhTYfgxZc5PRcdMMBufXfvZ57vOOpoJpnz3/2wu33xPbbNDoU+TauBiSU2a9xXAvHNRBFTQWnkiwh8N2HvR1XlAOVoUMMqSv2fC1MbZy/JFabvQ2W9Uumtd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745308935; c=relaxed/simple;
	bh=ftSIjHKWx1tSq5GXJ8lZyMGCNzTM6j6+2oEflF59ojQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=to4m5Q/hoOIe7v5T/BMxHvXWkw/7yDEyxpqhbv4Kpy0/Hbf02j59KdVc4DVDkgvPtKnfjVC7kLlq5cjJMzD3cPU3onA0II1Zu5YVun4W0w/02mKt0SaeFi+t3gH9DKpey3TQGa4sPrKUR3BHruHdtwpqRSqumoWIJo4cVZds+Ic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c0Xfr27e; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c0Xfr27e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745308933; x=1776844933;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ftSIjHKWx1tSq5GXJ8lZyMGCNzTM6j6+2oEflF59ojQ=;
  b=c0Xfr27eSdRnak5C82yssrtSzWgtOT4czZh3WUo2UDifv2r512Iwr40p
   omAlxYQDqXGkRrhB+A8S+vpHMjMe+qDWdNB4u667N7ijkhgP7YObSbHAk
   zE0mVv/H5CMAmuuVI9pOTEJymfWQpwjFzAINJl0JvTtAla/n6SPWnqU4F
   n0krkCJi52np9CSu8eBypqsHCLHKDsl8Ec8EY6kX86zadEIsOum17bbmr
   RCZnoMwAXdUPev6maSboVsDch8Gt1ChuY6we7GuFGj4yiIX2z5JC/bm0A
   XdcUlTpd7Ef0GxsI4eCCUJR+14U1NNn9cVUxDJkc7a3mHOXPawiE/o8Vj
   w==;
X-CSE-ConnectionGUID: Udg19jI3QsytTi2Kx+gSAQ==
X-CSE-MsgGUID: CSYMIFngQniPG5tnOEJqog==
X-IronPort-AV: E=McAfee;i="6700,10204,11410"; a="46090248"
X-IronPort-AV: E=Sophos;i="6.15,230,1739865600"; 
   d="scan'208";a="46090248"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 01:02:12 -0700
X-CSE-ConnectionGUID: yjOLIRHwRb2K8Xi6Bosypg==
X-CSE-MsgGUID: CQkrphJnTaOm98U3D1n57Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,230,1739865600"; 
   d="scan'208";a="137031493"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 01:02:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 22 Apr 2025 01:02:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 22 Apr 2025 01:02:07 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 22 Apr 2025 01:01:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eRugTrFNm6dspYqihnRmjJxnzIwYi6pjA2T0IFVGM92mTjyqLINyE0x2dZLYiHE9FAHtSTJ29fugeNFb/LIMRFtuqm3p5zxJgya+xt7zB8NIeA1dRFC64Kwz4/BChl14QDrRibS8RM68czGkv+2sCimmWeNNgHnOUliVqwuV4pqtUQq/nd1ihCW/daK6xPujAAuqLy74gyctPIeLA2mxazQM8sziFyOlfDhrSyZ4/k2ID4qV/4fBy+uFPQPv7LUJVVtK1ExEX4ZOH3pXns4lrfU2pVjMOEud7pAlvlvhFSQl1mKDlD2+YxL+ByWAgQzEX3KtLFT88dgLsq1MVsOvJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftSIjHKWx1tSq5GXJ8lZyMGCNzTM6j6+2oEflF59ojQ=;
 b=L6O7MsjCi3/pJYPCGxBGhc0FuioDTc+cPGXW95fPD9V5IqQE+CfDkL26ANTwzipOFG4ppiyBKNvO5a0WYPFWOPFyg7KmxJEu34W6/AQ97C2jvaMsExoptOpndp9iY1u4TTGX2Y1xLo27eCaFO6rQrZ+g1GaodwCiDZ1mpZs+OTvA4eg7Wqam2ZGxTyEPpWYMlb8lGf5P3yZG15Fs5pwjNROtDFe95AMLBwQ9P1XgYhSvjVED3kYhjJx9h+Mg3wu1S6eNPCauFSocBVmdNxMMnADEod+W7o7gqDDtNSgS3cHejoHA/A08Xh5yhL0SN/TWLH42YgLtBfezl+eQHyjupA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6513.namprd11.prod.outlook.com (2603:10b6:208:3a3::7)
 by SJ0PR11MB6743.namprd11.prod.outlook.com (2603:10b6:a03:47c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Tue, 22 Apr
 2025 08:00:39 +0000
Received: from IA1PR11MB6513.namprd11.prod.outlook.com
 ([fe80::8012:e01:4c01:d824]) by IA1PR11MB6513.namprd11.prod.outlook.com
 ([fe80::8012:e01:4c01:d824%4]) with mapi id 15.20.8678.021; Tue, 22 Apr 2025
 08:00:39 +0000
From: "Qiao, Wei" <wei.qiao@intel.com>
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>, "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
CC: "Chen, Hongzhan" <hongzhan.chen@intel.com>, "Pirou, Florent"
	<florent.pirou@intel.com>
Subject: RE: Build error of kernel/xenomai/debug.c
Thread-Topic: Build error of kernel/xenomai/debug.c
Thread-Index: AduvcNIP6fYojmwUSlGjpzfO8h3ARwAA+zCAAACQPoAAK7b9gACF9hAAAATet6AAFDpeAAAulatw
Date: Tue, 22 Apr 2025 08:00:39 +0000
Message-ID: <IA1PR11MB651388E02D8925FB8EA908CE8CBB2@IA1PR11MB6513.namprd11.prod.outlook.com>
References: <IA1PR11MB6513EB0131E06C8CC865E8EF8CBC2@IA1PR11MB6513.namprd11.prod.outlook.com>
 <72c2c5cb18b635f1145c35b6592c661cf55aeb0f.camel@siemens.com>
 <370f022e-d5e3-46f1-a19f-5448afeebb61@siemens.com>
 <IA1PR11MB6513A045F8ECB1186B65DA9A8CBF2@IA1PR11MB6513.namprd11.prod.outlook.com>
 <4342e7e1-a7d4-431c-8fcc-f7731d3938d9@siemens.com>
 <IA1PR11MB6513FC978522428982B0A30A8CB82@IA1PR11MB6513.namprd11.prod.outlook.com>
 <4abe85c4-1457-4137-9e54-ea1a8aa534d4@siemens.com>
In-Reply-To: <4abe85c4-1457-4137-9e54-ea1a8aa534d4@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6513:EE_|SJ0PR11MB6743:EE_
x-ms-office365-filtering-correlation-id: 68ec3313-f047-4e32-462e-08dd8173c5d3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RzkvQVRyaklJRTNFa0I2Q2pNK2hPcmg1MHV5VDdtQWltV2h0VGN0YWFTb0s4?=
 =?utf-8?B?VTltNEJMWVVLSnBiVlhoUnpvTk4ydWxNUGYwVmY1RlRPNVZVakd6T0dDVXhp?=
 =?utf-8?B?M3FHY0pjOWU5WjlkM2hLRnFVUHQybncxMlRKVVZSbytkTmZMN2xrOUZ6cGxq?=
 =?utf-8?B?MU5FWTk1ejlOUEpjSGRHcjBrcWw0Z0RBYk9ZblkvWWlBRlZaOXFoMkNkQyti?=
 =?utf-8?B?WUNOWmppVjZXaVJtWEl6NTFnRjVrK3FPQzJKc0RQK2hkVWFya21sQXBsL3lW?=
 =?utf-8?B?UVJiWlM0YjZOTFNCSlh2N0t0VGgwZ05vekZsUzF6ZlRSUG8vakVQd3U4YlJw?=
 =?utf-8?B?bXBLbEI2Uml0MGQxTXJTYk81QWF1a0VsRkpDWkhYaThNcm5HTFErWDNkSmls?=
 =?utf-8?B?T2NPUnRVZ1V0WjBGTkl1cFJUamJkaFNEendTZ1hCR0xUZFlxZnpOODZRbzAr?=
 =?utf-8?B?M1JvWHpoYmRyR3grZ0FjVEhTeDJGcnZ6MXJzcHF0ZWRHTjZZZEpVcXJqbStE?=
 =?utf-8?B?Y3JlK2xaUm5BNjdHMGxwOTk0aWUxSUc4ajJiN3IxZUVnL2pZS2U4YVpRUHBS?=
 =?utf-8?B?SjZrQXVpbWdzMGRGSHdSVk1MUngweFZIVTRxSWEvSXhDVzZwVnNNS0Nwa0xG?=
 =?utf-8?B?SGZGaks1V3pPM2c1Zk5KdFk3UndFMlVRQkhYUGw4VTdZMytybG5Ia1VlRGJn?=
 =?utf-8?B?SGNTamErRkJsaUExV3FmMnYvR2JaRzFPeVIxbUQ5SW5LTmF1anhiV0dvOTEv?=
 =?utf-8?B?MlZ0bUQwMTZLT3NwclpTWDFFcHBtVEg3Zm9zaEQ4bnhpV3pWbXJJWW9rb1pH?=
 =?utf-8?B?WUV4N05Sd1p5YXpUMjFPUWZ3c002SlBGSUNlbVY2NHB1Y05uOVNJdld2Vnlv?=
 =?utf-8?B?Y3c5ZTNSVElCcy9RMFhES21STit4bVo1OUJqSkZtb1AwVTdpSTdVRGtlWnB4?=
 =?utf-8?B?QWdQbWhlWFZ5cy9TZC9HeEFKN3lNM0wrNU5HVHFTVnZDZGZkMHhDRDVmQzhP?=
 =?utf-8?B?bFVuM1V4R1ljR0tTZU91cVFXVVFXTlRKajgzTGwrR0Q1TFBwZHZWRGdsTjVu?=
 =?utf-8?B?SmVaQWNiU1VFWGF5MklYZjhqQ1lQK0t4N0xMR0w3REhmMG85anZOQXRjekkr?=
 =?utf-8?B?K2h4YnJ6M0dlS0Y2VUt0Wkh4bFZGTE5CaFRnK1NBTXBWUGdPYkYvZ2NmWkk3?=
 =?utf-8?B?eVQ5eFlKUGVqZkY2ZHg1c1J3bE0zandUVkhqcjZEbGI4NnZZZTcrcFFNMFRF?=
 =?utf-8?B?bDZYQys1WDgwWSsxUFhNbzg5YUdvbU13UHdjWHVYbjhxQnFQSFAzWHl4NEEr?=
 =?utf-8?B?UUNyTDRzNU9FREtPZHh6eDBJcTJCR0N1VzNyVDRLdHRNb0dLNHI2VVI4a1Zi?=
 =?utf-8?B?b2RTeGl0VjBnaGJRMHI3VlpGaG5DRWNXVXQ4WmgwMW5lT2NEZ2xMT2YrYjVS?=
 =?utf-8?B?NW12Rmk1VmM5WmhGdGxGMUZONjBrK2dHbjRDYVFBUjMrdkRXbnBFL0Z2NHBD?=
 =?utf-8?B?aU1JazVGUitoeC9oOGJ6M1FnL0d4WkZ1WnRTcmZhTHpQNnYzK3hKOEhnbGNV?=
 =?utf-8?B?cVBHQkFxRFg5c1ZNOGFyTnU3cHJLc1psRVNnUStYOEJXSHQ1bHVEMnB1aldZ?=
 =?utf-8?B?U3NhZ2pBamliNmx1WlBwenp2emlvVTVEZ1dmaEZjYm1GYnlwanlpcGxoU2Zn?=
 =?utf-8?B?bnVMVFRDYXk2WnF6ZjJ2TVNrMkplRVNySklVblVhT2xDK3E1VURLT0Q2ZVhy?=
 =?utf-8?B?cEs5UWNwbkdicDk0cFFCNGgyWTJ2RFgxeG9oeklHYzd5ZDRNRTBaK1VMR3JW?=
 =?utf-8?B?MWJTSTExOGlBaEx4UDYvUGVrWWNsVVg1YnZpZmE1L2R0a2ppcE5yT09DVFZj?=
 =?utf-8?B?YTFIWjNuTWVLRHNCdzVGLzVkcWdDT2xTOVVLTytRKzc5TnlOL05BLy8xZGF5?=
 =?utf-8?B?REUxZzhCZUNNbVh0aUxZUHBpT2pLSmYrcEpuM3NuZ2JlaHRVYm9SbWR4NlVB?=
 =?utf-8?Q?je/SkVbYW8g+li3CumuP70gVUwpUp4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6513.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RzZsUURMeDZmdGFzUWFTUE13MWZlMmNSbzhMWHJ3MWZrQ2xMRExmUlpaY0VI?=
 =?utf-8?B?NlZaYk1XcStvQ3FrMWp2eTdJK0l2ODgwZFIySzJBSHdETGpNc2x5cmptTFF1?=
 =?utf-8?B?RzVmTjJkK3I5Vm5NNFRJa2pHc1FOaklTaEpHa3lpck9KM29aS1BtMXRHUmEz?=
 =?utf-8?B?aWJFaFd3Um8wa1Zkc1FMcTdjaXF0Z0ZYd1hoMnNTWDV6aWM3N29UV3F2c0pM?=
 =?utf-8?B?bGphdDJMU3YrNkR6aU5wUW11TVljUE02anJWRlpnNEM1QVZ5WE40VVdNT1I1?=
 =?utf-8?B?ZFNCVkNJa1Nqc2tKVXJtTGRUMlBnTnhuNGNBVmJLVHRmek45dXdhSFNUdXBN?=
 =?utf-8?B?ZFgyR2pwZzlScms3QkxDdWZIam5nZ3JRMXZGQVEwekpBZHlCdEpXcWFzVFky?=
 =?utf-8?B?dXFYeGJQVlVqUVJ1NE5ocGUyVFUraUpYZnpiTjBtZ2JhL1lQbld6M1Fxc3FL?=
 =?utf-8?B?czhXelBBSEZ3YmlYNjZna3RUTmNqZGxZTDJYSVc2WVd4VzZwMmhsd1A3blhy?=
 =?utf-8?B?TjlHemNFRXdhMnloWURDL3QyV0pjdDJUTmg3M2hObmg4emhyN0FLdTA3RkRU?=
 =?utf-8?B?bVYrQkN5Tm5oS3lTNGx2OHgrekhCSkQ1WjRiR01zL3hJZVRKM3FWNUNuc0d1?=
 =?utf-8?B?TVRQSlUySWxidEZwckFnbFozQ0w3bWtROHZjTVJXdk1KOVk1ZU5Dc0txTW13?=
 =?utf-8?B?MHZMK0ErV21RdjFFclFnMXpTQXovZEw0R3Q5ZG5ldWIzU0dCb08rTmp6YkdB?=
 =?utf-8?B?bFlScmQvY0xFeGpuME41eS9ZRnBqZ2JVN2hVYmFOclIyU3VsR0dhbXBKYWh0?=
 =?utf-8?B?clVSMVREcmZWRExuTzVsdlRMU2QrdXNLUHJkK29SNUR1M0pYMXlQY09KVzNQ?=
 =?utf-8?B?SlYrOXcyYXIzWmt0QkdaS1F3VzVJaUJGM0pIN3o2TzlIRUI3dmd2SlI0ekIx?=
 =?utf-8?B?Q0RDU2VQQzI2WURmSUF1SjBRbnVxYW5XUVdPNWZybjZjQ1JHdzNFMEt6K0Vi?=
 =?utf-8?B?djdpbUF0U0p2UFJIdXpzV2U2L3V3dG1VdDJNdkZCVGNWMkhpS25aeDBkblU5?=
 =?utf-8?B?OGcxRC8yNjBoNUpSYXlGbC9qZ24xMzRNVjN1YXAvVUFkd08yWThhejFvRHYy?=
 =?utf-8?B?ZVFWc28wSld6c2xVcWoybENiN1IweGlhc3IvUnJ1WStSMDJCc1JmWGhrbFd2?=
 =?utf-8?B?OXRtTXMvMEd4U3pFZk9FWmdyVWpWczBMZVNGY3dzZ1JBVEZqZlRHQ2ZGZWU0?=
 =?utf-8?B?SmF5OXBSTkN0NmJNczlJK1RnUUFmKzhlMU1RSlU1YmpsNUl6RXRrSFdJMjdC?=
 =?utf-8?B?ZHpJZFFDeE10MFUrTS9ONjZ1NTZmanFVZTZ0NTVQR0t6THpKVEFzNG0xcER4?=
 =?utf-8?B?eVZTNG5FVWNUMld3d3ZhT1NPMzcrUEgzRUg4Q05Od3F5WUhGWTNQQWJXRTlP?=
 =?utf-8?B?YWxYd200bzVyeUg2SFlUVmlieFVpdjFSUVh6aUZrR25KRmFKZW81b3dUeXpV?=
 =?utf-8?B?ZnVSaFp5RUVUb3lXM3pNSkhVM09uRjY5MC9yM1dGNU5MajU1LzJJWndOYUVF?=
 =?utf-8?B?cEk2d016RWwyS2NkSjBkZ1hNMTY0dFlURTJpdlVLSlpzMnV1TWdYaWxxTjEr?=
 =?utf-8?B?NHJKSXpCcDVWOElZWUFiVk1zcmlJUjVxbHVUb0JmTld6Z2UwbURYekVROFJ4?=
 =?utf-8?B?SlVyTWRUTlZqNW5Uck5zVHIzR1ArMG9rWmZKMTBEQXNkY2hlWHI2bWRiejhS?=
 =?utf-8?B?M2lYTzdxbmwxK2lUTXA2Q1ZQTGJYYTNjbzZrOUI4c29jZEV1dEpDTTdwUGwy?=
 =?utf-8?B?QjZCMVc2T213V21MWFNxSjZ1NHVtZFptcW1hQTYyTGNGTm4zb1FRYVBOWnh3?=
 =?utf-8?B?MFFNTGNiNVZDL3Zhd0h5QkpoMFl0TTBqMVlrZXc4Y3BQVXNmQkdRNjkzdVkv?=
 =?utf-8?B?b09TcS9aVW1Fc1ZiUEcrZFB0MTl0L3FCOFVIaW5ROXdZcXJ1VXJDbW5CMDhq?=
 =?utf-8?B?ZEJubzJCOFRSdVFBR0pMaUtrUEIvdkZkWVhYcTdyR1JiMS9ZL1l3aTMxWWtT?=
 =?utf-8?B?Z21LRHQ0bjdrM3A3WHFvNWdTYnVyNkxVZnhyTjdDZUU0Q2xsS3pEdzRKVnN5?=
 =?utf-8?Q?9zBOpyNaaicZ0dXNnsxHZT+n0?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ec3313-f047-4e32-462e-08dd8173c5d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 08:00:39.6108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UnLa2fhvDRhqk8ymLAgnR2WbGY7pPb9vh75l03xjbcypSgVrqLPhu8Ui4Pv+PfpahS+tliN/FOkNGVXBe9uVaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6743
X-OriginatorOrg: intel.com

TXkgdWJ1bnR1IHZlcnNpb24gaXMgUFJFVFRZX05BTUU9IlVidW50dSAyNC4wNC4yIExUUyINCmdj
YyAoVWJ1bnR1IDEzLjMuMC02dWJ1bnR1Mn4yNC4wNCkgMTMuMy4wIHRoZSBkZWZhdWx0IGdjYyB2
ZXJzaW9uLg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogRmxvcmlhbiBCZXpk
ZWthIDxmbG9yaWFuLmJlemRla2FAc2llbWVucy5jb20+IA0KU2VudDogTW9uZGF5LCBBcHJpbCAy
MSwgMjAyNSA1OjQ1IFBNDQpUbzogUWlhbywgV2VpIDx3ZWkucWlhb0BpbnRlbC5jb20+OyBLaXN6
a2EsIEphbiA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT47IHhlbm9tYWlAbGlzdHMubGludXguZGV2
DQpDYzogQ2hlbiwgSG9uZ3poYW4gPGhvbmd6aGFuLmNoZW5AaW50ZWwuY29tPjsgUGlyb3UsIEZs
b3JlbnQgPGZsb3JlbnQucGlyb3VAaW50ZWwuY29tPg0KU3ViamVjdDogUmU6IEJ1aWxkIGVycm9y
IG9mIGtlcm5lbC94ZW5vbWFpL2RlYnVnLmMNCg0KT24gMjEuMDQuMjUgMDI6MDgsIFFpYW8sIFdl
aSB3cm90ZToNCj4gR2NjIHZlcmlzb246DQo+IHFpYW93ZWlAd3FpYW8yOn4kIGdjYyAtLXZlcnNp
b24NCj4gZ2NjIChVYnVudHUgMTMuMy4wLTZ1YnVudHUyfjI0LjA0KSAxMy4zLjANCj4gDQo+IEtl
cm5lbDogDQo+IHY2LjEyLjE5LWRvdmV0YWlsMS1yZWJhc2UNCj4gDQo+IGh0dHBzOi8vZ2l0bGFi
LmNvbS9YZW5vbWFpL3hlbm9tYWktaGFja2VyLXNwYWNlLmdpdA0KPiB0YWc6IHYzLjMNCg0KSSB0
cmllZCB0aGUgZm9sbG93aW5nIGJ1aWxkIGNvbmZpZ3VyYXRpb25zLCBhbGwgd29ya2VkOg0KDQot
IGdjYyAoR0NDKSAxNS4wLjEgMjAyNTAzMjkgKFJlZCBIYXQgMTUuMC4xLTApDQotIGdjYyAoR0ND
KSAxNC4yLjEgMjAyNTAxMTAgKFJlZCBIYXQgMTQuMi4xLTcpDQotIGdjYyAoRGViaWFuIDEyLjIu
MC0xNCkgMTIuMi4wDQotIGdjYyAoRGViaWFuIDEwLjQuMC03KSAxMC40LjANCg0KVGhlIGRlZmF1
bHQgZ2NjIHZlcnNpb24gb2YgVWJ1bnR1IDI0LjA0IC0gYXMgcHJvdmlkZWQgYnkgdGhlIGdjYyBw
YWNrYWdlDQotIGlzIDEzLjIuMC03dWJ1bnR1MS4gU2VlbXMgeW91IGluc3RhbGxlZCB0aGUgZ2Nj
LTEzIHBhY2thZ2UgZm9yIHNvbWUgcmVhc29uLg0KDQpXaGF0IGhhcHBlbnMgaWYgeW91IHN3aXRj
aCBiYWNrIHRvIHRoZSBkZWZhdWx0IGNvbXBpbGVyLCBkb2VzIHRoYXQgd29yaz8NCg0KSSBjYW4n
dCB0ZWxsIHdoeSwgYnV0IGdjYyAxMy4yIHNlZW1zIHVuYWJsZSB0byBkZXJpdmUgdGhlIG9iamVj
dCBzaXplLi4uDQoNCkFzIEphbiBtZW50aW9uZWQgdGhlIHF1aWNrIGZpeCBJIHBvc3RlZCBpcyBr
aW5kIG9mIGFuIG92ZXJraWxsLg0KDQpBcyBJIGRvbid0IGhhdmUgYW4gVWJ1bnR1IHN5c3RlbSBh
dCBoYW5kIGFuZCBhbGwgdHJpZXMgdG8gcmVwcm9kdWNlIG9uIERlYmlhbiBhbmQgRmVkb3JhIGZh
aWxlZCBzbyBmYXIgYW5kIGluIGFkZGl0aW9uIGEgbG90IG9mIGRpZmZlcmVudCBjb21waWxlciB2
ZXJzaW9ucyBhcmUgd29ya2luZyBmaW5lOiBObyBmdXJ0aGVyIGludmVzdGlnYXRpb25zIHdpbGwg
Zm9sbG93IG9uIG15IGVuZC4NCg0KPiANCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
RnJvbTogRmxvcmlhbiBCZXpkZWthIDxmbG9yaWFuLmJlemRla2FAc2llbWVucy5jb20+DQo+IFNl
bnQ6IE1vbmRheSwgQXByaWwgMjEsIDIwMjUgNTo0NyBBTQ0KPiBUbzogUWlhbywgV2VpIDx3ZWku
cWlhb0BpbnRlbC5jb20+OyBLaXN6a2EsIEphbiANCj4gPGphbi5raXN6a2FAc2llbWVucy5jb20+
OyB4ZW5vbWFpQGxpc3RzLmxpbnV4LmRldg0KPiBDYzogQ2hlbiwgSG9uZ3poYW4gPGhvbmd6aGFu
LmNoZW5AaW50ZWwuY29tPjsgUGlyb3UsIEZsb3JlbnQgDQo+IDxmbG9yZW50LnBpcm91QGludGVs
LmNvbT4NCj4gU3ViamVjdDogUmU6IEJ1aWxkIGVycm9yIG9mIGtlcm5lbC94ZW5vbWFpL2RlYnVn
LmMNCj4gDQo+IE9uIDE4LjA0LjI1IDA3OjUxLCBRaWFvLCBXZWkgd3JvdGU6DQo+PiBUZXN0IHBh
c3MuDQo+PiBUaGUgc3lzdGVtIGNhbiBib290IHVwIGFuZCB3b3JrIHdlbGwuDQo+IA0KPiBXaGlj
aCB4ZW5vbWFpL2NvbXBpbGVyL2tlcm5lbCBjb21iaW5hdGlvbiBhcmUgeW91IHRyeWluZyB0byBi
dWlsZD8NCj4gDQo+IEkgdHJpZWQgdG8gcmVwcm9kdWNlIHdpdGggZ2NjIDE1IC0gdGhlIGxhdGVz
dCBnY2MgcmVsZWFzZSAtIGJ1dCBpdCBpcyBzdGlsbCBidWlsZGluZyBmaW5lLg0KPiANCj4gWW91
IG1lbnRpb25lZCBVYnVudHUgMjQuMDQsIHdoaWNoIHNob3VsZCBzaGlwIGdjYyAxMC41LCB3aGlj
aCBzaG91bGQgYmUgZmluZSBhcyB3ZWxsLg0KPiANCj4+DQo+PiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPj4gRnJvbTogSmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4NCj4+
IFNlbnQ6IFRodXJzZGF5LCBBcHJpbCAxNywgMjAyNSA0OjU5IFBNDQo+PiBUbzogQmV6ZGVrYSwg
RmxvcmlhbiA8Zmxvcmlhbi5iZXpkZWthQHNpZW1lbnMuY29tPjsgUWlhbywgV2VpIA0KPj4gPHdl
aS5xaWFvQGludGVsLmNvbT47IHhlbm9tYWlAbGlzdHMubGludXguZGV2DQo+PiBDYzogQ2hlbiwg
SG9uZ3poYW4gPGhvbmd6aGFuLmNoZW5AaW50ZWwuY29tPjsgUGlyb3UsIEZsb3JlbnQgDQo+PiA8
ZmxvcmVudC5waXJvdUBpbnRlbC5jb20+DQo+PiBTdWJqZWN0OiBSZTogQnVpbGQgZXJyb3Igb2Yg
a2VybmVsL3hlbm9tYWkvZGVidWcuYw0KPj4NCj4+IE9uIDE3LjA0LjI1IDEwOjQzLCBGbG9yaWFu
IEJlemRla2Egd3JvdGU6DQo+Pj4gT24gVGh1LCAyMDI1LTA0LTE3IGF0IDA4OjE1ICswMDAwLCBR
aWFvLCBXZWkgd3JvdGU6DQo+Pj4+IEhpIEFsbCwNCj4+Pj4NCj4+Pj4gSWYgd2UgYnVpbGQgdGhl
IGtlcm5lbCBpbiB1YnVudHUgMjQuMDQsIHRoZXJlIGlzIGJ1aWxkIGVycm9yOg0KPj4+Pg0KPj4+
PiBmcm9tIGtlcm5lbC94ZW5vbWFpL2RlYnVnLmM6MjM6DQo+Pj4+IEluIGZ1bmN0aW9uICdzdHJj
cHknLA0KPj4+PiAgICAgaW5saW5lZCBmcm9tICdoYXNoX3N5bWJvbCcgYXQga2VybmVsL3hlbm9t
YWkvZGVidWcuYzo5NDoyOg0KPj4+PiAuL2luY2x1ZGUvbGludXgvZm9ydGlmeS1zdHJpbmcuaDo3
ODc6MTc6IGVycm9yOiBjYWxsIHRvICdfX3dyaXRlX292ZXJmbG93JyBkZWNsYXJlZCB3aXRoIGF0
dHJpYnV0ZSBlcnJvcjogZGV0ZWN0ZWQgd3JpdGUgYmV5b25kIHNpemUgb2Ygb2JqZWN0ICgxc3Qg
cGFyYW1ldGVyKQ0KPj4+PiAgIDc4NyB8ICAgICAgICAgICAgICAgICBfX3dyaXRlX292ZXJmbG93
KCk7DQo+Pj4+ICAgICAgIHwgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fg0KPj4+
Pg0KPj4+PiBUaGlzIGlzIGJlY2F1c2UgbmV3IGdjYyB2ZXJzaW9uIGhhcyBzdHJpY3RlciBGT1JU
SUZZX1NPVVJDRSggPTMgaXMg4oCMc3RyaWN0ZXLigIwgdGhhbiA9MikuIFBsZWFzZSBoZWxwIHRv
IGZpeCwgdGhhbmtzLg0KPj4+DQo+Pj4gVGhhdCBpcyB0aGUgZmxleGlibGUgYXJyYXkgc3Rvcnku
Li4NCj4+Pg0KPj4+IFlvdSBjb3VsZCB0cnkgc29tZXRoaW5nIGxpa2UgYmVsb3cgKGNvbXBsZXRl
bHkgdW50ZXN0ZWQpIGFuZCByZXBvcnQgDQo+Pj4gYmFjayBpZiBpdCB3b3JrczoNCj4+Pg0KPj4+
IGRpZmYgLS1naXQgYS9rZXJuZWwvY29iYWx0L2RlYnVnLmMgYi9rZXJuZWwvY29iYWx0L2RlYnVn
LmMgaW5kZXgNCj4+PiAyNWIxOTRjMjYuLmQwNDhkYzc1NyAxMDA2NDQNCj4+PiAtLS0gYS9rZXJu
ZWwvY29iYWx0L2RlYnVnLmMNCj4+PiArKysgYi9rZXJuZWwvY29iYWx0L2RlYnVnLmMNCj4+PiBA
QCAtNDcsNyArNDcsOCBAQCBFWFBPUlRfU1lNQk9MX0dQTChjb2JhbHRfZGVidWdfdmZyb290KTsN
Cj4+PiAgDQo+Pj4gIHN0cnVjdCBoYXNoZWRfc3ltYm9sIHsNCj4+PiAgCXN0cnVjdCBoYXNoZWRf
c3ltYm9sICpuZXh0Ow0KPj4+IC0JY2hhciBzeW1ib2xbXTsNCj4+PiArCXNpemVfdCBzaXplOw0K
Pj4+ICsJY2hhciBzeW1ib2xbXSBfX2NvdW50ZWRfYnkoc2l6ZSk7DQo+Pj4gIH07DQo+Pj4gIA0K
Pj4+ICBzdGF0aWMgc3RydWN0IGhhc2hlZF9zeW1ib2wgKnN5bWJvbF9qaGFzaFtTWU1CT0xfSFNM
T1RTXTsgQEAgLTkxLDYNCj4+PiArOTIsNyBAQCBzdGF0aWMgY29uc3QgY2hhciAqaGFzaF9zeW1i
b2woY29uc3QgY2hhciAqc3ltYm9sKQ0KPj4+ICAJCWdvdG8gb3V0Ow0KPj4+ICAJfQ0KPj4+ICAN
Cj4+PiArCXAtPnNpemUgPSBsZW4gKyAxOw0KPj4+ICAJc3RyY3B5KHAtPnN5bWJvbCwgc3ltYm9s
KTsNCj4+PiAgCXAtPm5leHQgPSAqaDsNCj4+PiAgCSpoID0gcDsNCj4+Pg0KPj4NCj4+IEEgYml0
IG9mIG92ZXJraWxsLCBnaXZlbiB0aGF0IGFsbG9jYXRpb24gYW5kIGFjY2VzcyBvZiBhY2NvcmRp
bmcgc2l6ZSBoYXBwZW5zIHdpdGhpbiB0aGUgc2FtZSBmdW5jdGlvbi4gTm8gc21hcnRlciB3YXkg
dG8gdGVsbCB0aGUgY29tcGlsZXIgdG8gc3RheSBhd2F5IGhlcmU/DQo+Pg0KPj4gSmFuDQo+Pg0K
Pj4gLS0NCj4+IFNpZW1lbnMgQUcsIEZvdW5kYXRpb25hbCBUZWNobm9sb2dpZXMgTGludXggRXhw
ZXJ0IENlbnRlcg0K
