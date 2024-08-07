Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AAE1C3D
	for <xenomai@lists.linux.dev>; Wed,  7 Aug 2024 04:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723006656; cv=fail; b=X/LhlfKSTI+HM52TeT05aSE7Y/jZN9ClFkVfY4n/BPIGR62S/he3iMiQEYSxiUazfxtVMS7vVMWrkoaEE4DFx4SsHe2c8cn4nxGIhaHnwKnfNN1oP1FXD7xcfBO428AwG1h0rZ4ekZinJpF5scrE/88JmzPEZBJisuSAb7cTEZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723006656; c=relaxed/simple;
	bh=lbgxgNnUOMFEFvLAcldWLv+PGWVReV7YmrNDlrIxNYM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R4RjNgIlD6hD2Sn0uPjwdcBezhc2/3B7VZ35IVxI9nxB/q0DmfCyIHS7Rak0tGb8INeS44H+uBllh0hNn+Rwq6QcWE5o7AugVMCtzEJ2XoLC2zTuNybcptu9o9fdtZeny6fvRlH9FACRwXb7EuuZFx9LfsUnusaWQDzB4Zhlv/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GfxlkuH3; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GfxlkuH3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723006655; x=1754542655;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=lbgxgNnUOMFEFvLAcldWLv+PGWVReV7YmrNDlrIxNYM=;
  b=GfxlkuH3lFaGuOZ6V/+iC5YPCBOfQuOe74PFLle7yZZRE+S/EvSL0cl8
   3bmU9CN+k5Mb5bFZYYqnJjSXiD9sFqZ2jiUHoZsF3Pn5KQCKEZ/T5qRxI
   2ZsxAZbeXTEZnK8nvtTZHKA5B4Mp7wfVPVjRVyP1LrTprpFjoUq8KHHin
   LROf30anUMphwGtgHfQbwLmFZf2UlveCp/FT5cMJqz+wPkcOfZrSheYTF
   CFL6/4hJLZaJhAliULJQxuLRjTYeOb542Q9/3ICLBT/xTU2Am8j84iaTg
   11Y4fFZejLP9UhiuGHi8HZEYsnPw8U3AKDECoavEEckCu55dDn2d3qm+5
   g==;
X-CSE-ConnectionGUID: iwd6Pa/jSk2LPe6fCB9nXQ==
X-CSE-MsgGUID: QwNWj/kgTsymxo0pocOLTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="21229412"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="21229412"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 21:57:34 -0700
X-CSE-ConnectionGUID: vXM9V8NERYmROxq+Eq++GQ==
X-CSE-MsgGUID: XtJc6v2WQOWhdi8YNAkYkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="60844802"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Aug 2024 21:57:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 6 Aug 2024 21:57:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 6 Aug 2024 21:57:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 6 Aug 2024 21:57:33 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 6 Aug 2024 21:57:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BKJxyRBWrpRttq5tjY5hjjd9GmhNwqNL/bZs7tw0RQ7XD9Z0lhaK81E2wnAe9W9jbJrSbUGozYz60xxmwzFnX10ZxWXRjwlUFQeeSBQiz224Oe++nn4VXD8uADuHyH8xExVkxlvAvy3nlBPTGd18e7re7HZSXdDLM5itGzluMA8tEYkt+S/Jl2G38pH4Hq/R1GGK7BOcxZL2OLLiULcnpKp1QheDf/ctCd0/OILKuBeL/cGSM/rokL75CbwqjtGVXFVNblrP7d+N/gn/W+uniGEggWPXIVTZuXIGTVofgSLk4m8AgL5Qlph2PCwLqLU+CLILiScAN5TuWWEy8vPuDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbgxgNnUOMFEFvLAcldWLv+PGWVReV7YmrNDlrIxNYM=;
 b=maKYgeJMYB8Ulefpg7lHFQjne5UwgobZLt6Z7j8THMFwQGOrGdKNdp2jiSKWeqVlugEEKGuDENw6kff6dShuQhM+dYeHppJmK3WvoFEBd8EitMpWxBjPX5xqNEmsc9Lw+0H3wVHNPxy0EW0CxFKPfGS/+SQIRBpq4FgXMMR1UVVf5knj9yHFsiZLvzxDs7oD3b3kBMjhRBZ9dsiytUhxoYmMTaaMwSUx4tvQ/M7SdANSXbZ1/reUh21G13BS8bTH2Aw+WIunVccjmUCW/toy+bDjW8GlEuvmw6LmTXMcHnfp4/Be4KELNrwEvFivUL8rrLgOk4Ju7/qJqTpcrpn59w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by PH7PR11MB7661.namprd11.prod.outlook.com (2603:10b6:510:27b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Wed, 7 Aug
 2024 04:57:31 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d%6]) with mapi id 15.20.7807.026; Wed, 7 Aug 2024
 04:57:31 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday,  Aug 7, 2024, UTC 7:00
 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday,  Aug 7, 2024, UTC
 7:00 AM
Thread-Index: AQHa6IZP4GVJnhIIO0i55aMpz6PFwA==
Date: Wed, 7 Aug 2024 04:57:31 +0000
Message-ID: <PH7PR11MB7499B238FF2BECBDD784752AF2B82@PH7PR11MB7499.namprd11.prod.outlook.com>
References: <PH7PR11MB7499F7DDE006A3A7291F61FAF27B2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749929DFFDCFE47376883636F2572@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749988D3E2C96C4F21DAEBE4F2212@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499C4BB71E159B3AB98D686F2332@PH7PR11MB7499.namprd11.prod.outlook.com>
 <DS0PR11MB7482613E8A9D78229EA71D07F2EC2@DS0PR11MB7482.namprd11.prod.outlook.com>
 <PH7PR11MB74993A52AA247D08069980E4F2F22@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499D816A0B79C85EF7CD712F2D62@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499161719AD2EC0D1651C48F2A42@PH7PR11MB7499.namprd11.prod.outlook.com>
 <DS0PR11MB7482106CBDA92B4A595D7363F2AA2@DS0PR11MB7482.namprd11.prod.outlook.com>
In-Reply-To: <DS0PR11MB7482106CBDA92B4A595D7363F2AA2@DS0PR11MB7482.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|PH7PR11MB7661:EE_
x-ms-office365-filtering-correlation-id: a0334339-50d5-446b-68e5-08dcb69d7196
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?d0VKRTN0K2ZYSndVV2hJVGs1ZG1xYk1OMDkraW5FUGpBVnNHZDh1L01UZXI0?=
 =?utf-8?B?Z0kzYWNnSkQ3SG4rS0l2TW94T2RDRE1mMEhFQWg0M3IwRDJ1ZFk4UGVMUk03?=
 =?utf-8?B?WlhickhQMlgrR1hMUDBzMnNWSzlHRG1LS2gzMHFIcnY2Mnp6K3JldGNmSmRa?=
 =?utf-8?B?Y01sTUxla0hxdDNrRFlQNDNWaTFGaGRKVWlqUzAyN1FlRDByUktjbEZJZHBL?=
 =?utf-8?B?SktQdGRnWVFuR3dsaDFXUVBxc3VVMjNzd244NW5qN2k5SURLSlltekR3emlx?=
 =?utf-8?B?aVQvWVhnV3ByaFJiZXRyMzZETmExaFJPaks3bUc2NmtzNG42aWFvSHpPU0hP?=
 =?utf-8?B?bUR1Y1RURCsxWGFwNG5lMU5yWU5DaktzSlpTZmQzMFVwVFpmYlFPT0EyeTlW?=
 =?utf-8?B?UkZyZEN6ZUQxVUxXN0dtd2hrYnhwNDZ0a01mTlluNUthL0pxbTYwMDRKc2pj?=
 =?utf-8?B?eUZjbDZKaTE4ckZqbURKOE5wN3RXczBNdm5icTdpekJQTjBmTWtNZFdBcmQ2?=
 =?utf-8?B?dmRXYWZabDNFWjFVQ1hkbi84czZneFVpdE0vUUc3SnBWVlhuRTdCeFlMU2I1?=
 =?utf-8?B?UkxKczNJSlBucXpKM25SWXE0R3VIUXBzR250ZlZGVkQvTHNudisrdXBUWk5p?=
 =?utf-8?B?d0c0Ykpwdk1hYkF4R3ZWekZteThqeHRZbmdWMGhnWUtvMWxPdnQwTHBRVmM1?=
 =?utf-8?B?bVRwblFlc29uY21hZUh0Skc3M1Ftb0Rma3NzTkg4cHZ4UDRweHVqRVBPOGhw?=
 =?utf-8?B?NDNZUWExa2tYTWhkaVFrRmVSc0VmL3h5N2YxZlF6b1o4QlkxVFNZak9RRXUw?=
 =?utf-8?B?ZVNXVWJlTzVmZ1Bld21MUlVTSEdva3Q0ZHl3TzNZSDFkWGdpdklraFVMTTJr?=
 =?utf-8?B?L0h2Z1l6U3BDdko0cU4zaXRTQnAzdUFlR3h0STFyby9nN1lIbEo0Qk9CWjRs?=
 =?utf-8?B?MFlOV2RGc2tZQkZEeXVSMUdFWXFxQS9melZLS0k2dm5JKzNRM0dnQyt4TmdK?=
 =?utf-8?B?U1N6dmRwSVpNU2g0S2UyYXgwUHlKQzNpalAxTG9sNHp2K1dPRUw5L3RjTmFI?=
 =?utf-8?B?VHp6dU00VWxZekVOTnIvR1UrVU5QOFZNUDFldVRURVR4TFdPeFJ6NFUyK25T?=
 =?utf-8?B?THdNcFk5Si9UOXFLTitVZVBLa3F1ZjVyTGFkRmIzRkxVMEphY2J5NFR0MzNN?=
 =?utf-8?B?cFE3VjkwNVBxYVRKR2t0R0lOODhBT2VqajR1OXJuM1RrN1hMRTdVQzNpYmo4?=
 =?utf-8?B?V3JBOTRBNk4zcVlaRC9aSmJsTjdsanpFZWtWb1dLeVNIemVYSGhBZGV2RTNw?=
 =?utf-8?B?SmVjUGR2VjFQdTg1YWZsRDJGZ0pKNmgyckZJUEwwc0J6VG5UQ2N5T0pRTGZP?=
 =?utf-8?B?dXRIWnhKWGVjSG1MUDQzbHF6VDMyVkZWZTFJODVhd3BTTElmSE1EZ3VWVEJl?=
 =?utf-8?B?eWs4WnF5bzhkVk5BdWhWOTh3TE1SK2FSOE5GY0FMUHVWZVJ3MWlObTVSTUtW?=
 =?utf-8?B?R3lIVHlZUnd5ckRIS2hpT0w0R2tyc21zMmJvRTFkeVVndU1TV3hjOUdmZ2h2?=
 =?utf-8?B?SVl5VnAzOVNTaGdoRG8zNTFodzZxcW5LVGdyNnU4WEZZcmRCWm1ibUhVclRI?=
 =?utf-8?B?QzJQc2JTRGZHclhCZ2lxWGdINHZmU2FNbmdqdWFGRXhLaWJEZUQ1Yk9xbXJn?=
 =?utf-8?B?NUc0NjJqRmhhMzhhbWNtSi9UbjlOblRKc3RKbmtkSlVYY3pnbDdBa0hPR2xX?=
 =?utf-8?B?T2dkbFk0eVJLSFoweHdyeDgxcnV1RXc1QnRzOE5uWnJFV3M3djVCTFhsSEVq?=
 =?utf-8?Q?QwiOKpsskdgEriyLavyoz16WLicuws/CKJsw8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0NmQnNrK01aY1llZ0poTHZWZ0R4U21aWnJZcFQ3UzFmc2NIL2E1RU00cE9S?=
 =?utf-8?B?TTJKcWt3VFRyaWZtS2J1TVlmZjJzUEVoQ3JMYnd4VHVzRzRLNHpTWk9tYklh?=
 =?utf-8?B?RWNwc1VmNUR4bllwUDFYdW5UclNDak0vdHkvK0s0RVFKRkp2Y1ZDcUNLZGhy?=
 =?utf-8?B?QldqeG5aa1MzY1pKMG5aeFFEYmF3Tkw0RXhlTG9NSXJWT25HbDk1ekVtNWZD?=
 =?utf-8?B?VmtuWVVueFVlT2toNXcwcUVpbDBmNnlTbkIrTmVXZnNPTVVaTmZwWnRWTjk3?=
 =?utf-8?B?MyszdyszVEFwWDVpOHlYVkZUQW5OVmk2NW96eWREM0I1TmtnNHBiU1pLVHV4?=
 =?utf-8?B?UTgxL05xZWYwWHkxSU1jSS9ZVjcyYVl2SGEraGd6YkQrZjVLZmM2N1RFUUlF?=
 =?utf-8?B?ck5XSnlXSVhZYVIxWlFyeG5JRGtVbyt2Z3FFTzdlRUdpMzNmSlZGa1owbHdv?=
 =?utf-8?B?bXN6MUk1ejFUcnVQNHlFS0ovcnFZWlZkUUFFTld1blhzNnBRSFRLcHlITmZU?=
 =?utf-8?B?VnJyYjhIV1NhMEtqdTh0OWFWa0NPUFpoZ1hOMUsxR0ZHaVJqR0RraVpETHhN?=
 =?utf-8?B?Zlk3TTJyWmRxUFYwM0RJT2dobGM3UWp4b2F0K2xaeERPNUhlSWhralRRaFJQ?=
 =?utf-8?B?ZHY0elpxVG5aRFNkbmNBL3NXb0xRRXNLUUdOZGdFdUNxTGNRNFNIVitHTDJD?=
 =?utf-8?B?N01HeTVwOU9kajVPSHdGZTN6RFdlQWVxbXFrUS9FVC91di9oNGFGaitOc3pG?=
 =?utf-8?B?M0d6RWF5M2VsaTg0U0FyT1hFMUUwS0dxNkc3SERYNkhCNTlyVGQxcFVxQVJ5?=
 =?utf-8?B?clg5d2tJRHdxRi9MeFlEWjVXNWZJRGFhTEx4K1BIVjhqYlZQSVZ2bHFmeEJ4?=
 =?utf-8?B?NlJxcnhiNG9sMXZ5aTBuOFh4cS83Q0IrTG83eW9jQTJyeUVKZGNydzg0YmtP?=
 =?utf-8?B?MzZ5K2F4dzVYbUtTNXNJZ1BtZEpPSGxCczIrMDhuV3R2NXpsV2pqSmJiOHJo?=
 =?utf-8?B?L1VaTytKZmZyeGpIbUZNRlhwdmdMMG9wUXIzSXlQWVN0Z0FkNzlzY29zUXlU?=
 =?utf-8?B?RHlQT29sSnFtV2RFRFBlTjVRL0xZM1g2L1dKWXkwRU5oU1Btd0lnZWtsZXY3?=
 =?utf-8?B?WnZxSjRLUWd0S2xjVzFxbS9vUCtmeG5ZQ0hCMUdpTjNxOTdMMVJZOURTdHJk?=
 =?utf-8?B?YmlwN25sY24wSFg4dVh4K0dNRWxxMVJCV0ZaOEdoajBmZmhNYWF6cTlISlIz?=
 =?utf-8?B?M3R1SDNBK21VTUJpZXovYTF6TU1QVFdsRlpYV21yVzFCM0VaQlhCLzlFdUp6?=
 =?utf-8?B?Y3JPTStwUUgvRERSQk9wSVo1dG1ZZ2NhcDViKzdQcXUraHZpa2k1d0RDYzVE?=
 =?utf-8?B?VHlic1gxWUVURFNMcXNhRDY0aUJTWDNaRWVabHNJNUI5c25BZDJHa0h2YXl0?=
 =?utf-8?B?bVkza2VSVVpFSDdGbjlMVHFhbHpmbnZiNUVZVHNxcXl3V1YyelNqQWQ5VXVz?=
 =?utf-8?B?a2NSUGdJR0Y2L05lL1M3emF1OU1oOG9BejBwQnlDQ1Q1WDRLYXF6K2ViWitO?=
 =?utf-8?B?TkF3QURiV2ZHVkJDQXR1U1VVMGI0bWVTeEdVVmdwcDlqNFdrUStIU0VmTGl2?=
 =?utf-8?B?MVJiRSt2a29aNXBzVGJoM2x4T1BtbUNxR29Ib1NuajFFbzFxeGVUSU1hMlh6?=
 =?utf-8?B?TDQyVnBSbFZlWUtnNjI2V0I2dDBqR0ZKem9GblE3aFlXUHVvRkJJN3BKeXg3?=
 =?utf-8?B?SlVicDBBRDBoYk14d29jRithaWFQWm81aG1VTmltdU5zazVoUWRUYUFWeE0v?=
 =?utf-8?B?QlVCV3J6cE15dmNKbFNZY3NFUmRZR2psRmh6ZlJTcTFUWGgxOVhpWGQ3L3dk?=
 =?utf-8?B?bXZnamhxeHQ5YVZEM3ZOdWEzTGV5VWI5dHJSZDRIWVREbk94OVBNelFZS0pC?=
 =?utf-8?B?QzdGNDI1b295RVJFY2xocmowbXBLUzZzV0QySkNTUGRBeHgvYytCUmlFNlRa?=
 =?utf-8?B?eHZxcThNeXBLZUVuM296M0NSZjdCbkVEYm9rWEpNUVQ3alRGc1cxdCtHYlZQ?=
 =?utf-8?B?YmZ6VVlBdEdIWkQrUWVOalNJS0hoTk1sSzZ6SEY4MU9UWnlMTHNld1hhMlBr?=
 =?utf-8?Q?70xyOKHkEZX3tGqCAt4yvs9vG?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a0334339-50d5-446b-68e5-08dcb69d7196
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2024 04:57:31.0992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jUjUWCn+jRfQhiNN/Z38rxOsHXHPlU7Q2e+MfNeUzOUJNV9IXZYBntvvGpNHALXnof/qKZ+ttGpIbBJcUCfJOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7661
X-OriginatorOrg: intel.com

DQpUb3BpY3MgbWF5IGluY2x1ZGUgYnV0IGFyZSBub3QgbGltaXRlZCB0byB1cHN0cmVhbS9kb3du
c3RyZWFtIHByb2plY3QgDQpwbGFucywgc3RhdHVzIHVwZGF0ZXMsIGFuZCB0ZWNobmljYWwgZGlz
Y3Vzc2lvbnMuIEl0J3MgYW4gb3BlbiBvbmxpbmUgDQptZWV0aW5nIHRoYXQgYW55b25lIGNhbiBq
b2luIGFuZCBhc2sgcXVlc3Rpb25zLg0KDQpUaW1lOg0KV2VkbmVzZGF5LCBBdWcgNywgMjAyNCwg
VVRDIDc6MDAgQU0NClBhcmlzLCBGcmFuY2UgQ0VTVCA5OjAwIEFNDQpDaGluYSBDU1QgMzowMCBQ
TQ0KDQpKb2luIFpvb20gTWVldGluZyANCmh0dHBzOi8vaW50ZWwuem9vbS51cy9qLzkxMjk3Mjc5
MjY5P3B3ZD1XbWR3UzBwRE9EUk5NUzl0UWs1NFkxZHZiRmxxVVQwOQ0KT3INCmh0dHBzOi8vaW50
ZWwuem9vbS51cy93Yy9qb2luLzkxMjk3Mjc5MjY5P3dwaz13Y3BrNTJhOWY5NmQ5ODllN2UyMGI2
MjhjMmMzNmU0OGI2OGUNCg0KTWVldGluZyBJRDogOTEyIDk3MjcgOTI2OQ0KUGFzc2NvZGU6IDM2
NzUyOA0KDQoNClJlZ2FyZHMNCg0KSG9uZ3poYW4gQ2hlbg0K
