Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9F61DDC3E
	for <xenomai@lists.linux.dev>; Wed, 16 Apr 2025 03:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744775225; cv=fail; b=sypAem6xlg6MtuL9DuM/Wt/FORaj20AxP31ZXU0Oq78rjWvBVu5ngxizk3mnDlhY2dnQJKK6vG3HAETa0kSkWf1UMpo6yD6BYIM6GTSlnKtaRVQDthavbkrjSlXd7f2fYrlrt4opjUbcxHr31Qn2lQC9CwASWjHD8vQB9nPfzMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744775225; c=relaxed/simple;
	bh=zIegYAEVOmVtpZwYP7kfLVoVxFCDYgfarriir1ADf7A=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Iymcu6rUOCENbxZs5RYahpXETpwi1PoEjx/6hgJx7R5o3TCQfwYpIyqweiipukYwSlewFge2uGNNRQwbJ1NwNzAgQ4q+bOW50hHduXM/Y3+Igt3pYsTzMDWw5Q9k5lrsbMoVNGOfntAFQXyTXUost5orznsWTOlZsSyByO+s9ZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kG4b+Hju; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kG4b+Hju"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744775222; x=1776311222;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=zIegYAEVOmVtpZwYP7kfLVoVxFCDYgfarriir1ADf7A=;
  b=kG4b+HjuD7bfWfolrhiMYN9hXoAIpuysy8+q7I2HCwfiABXVXx/AfPGt
   H25OFHJxaaf9relQUJdOL7rGgHZ3GKc/5dxTHsfsw+2RSDfZFB/X59VS+
   QUedZ3PV98nIqEt03TBsZN2DrcKal2rNvlxp2gxw+Qb9H0UpwkoOQFXQe
   wrR+kMpDwLDetusKjBMlnuzGF3W+gvJG4r51qiAvPq1yN+BGrATCpELmJ
   ilbEIvWbw2mnF7kmsoJDencV8T+GlK9SszR9pIGv5aKuEMI+0gBtvXbKh
   GNixjBQfn2KyJRUibohfDAnJGV0AlEXxkDOB+4MZeWNyTd+LLZC6DVEvT
   A==;
X-CSE-ConnectionGUID: UKaT/CDJR9C1Iz87l4kZJQ==
X-CSE-MsgGUID: 0aeXOfeFSkWVqRad2nXAeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="46443596"
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="46443596"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 20:47:00 -0700
X-CSE-ConnectionGUID: 1tS+7NnTRDyP0/YT1wx+CQ==
X-CSE-MsgGUID: SXY7nPMSTPS65DbblJ9XXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="161272761"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 20:47:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 15 Apr 2025 20:46:59 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 15 Apr 2025 20:46:59 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 15 Apr 2025 20:46:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BwR+xKaQwrwKSw+LSkvk1e0HUNk7QPQdH0kFm/4Oi2TRS4bb7iAkxDsJEeFCFqbzRDVsWjV0t+9sxMynOlgfBGcZsomaqc4cVueXiFGaPlYHR5G1RvjgaTWU5u76epkGpxwl3JPRisob6sst7zUwCngnFPD2o2sy9ySj8lFijtJKtEkRZweh9n+TxX7jpEO4MXXjAab5Sm+OROGxqj4f/EuvCpI5wU233B2rxHJXlBzfUCZkY0a3V199ZLlynZfah0RIxacEFncwi9i2X9ir7lCM2ZsWOOJzYedbcUnp+NvyOjxzvq2nn/i9Y3su/b63KPDX36pL5CjXrylGxXOD+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zIegYAEVOmVtpZwYP7kfLVoVxFCDYgfarriir1ADf7A=;
 b=ZncPP7l5CgiD7CA2KNyVgKGR/2zoG6sKkL3YGrzfMzpCCidiEpLYiRTpIOqtOrZhTrEJDRT0rnVzvP5rVWuNEcp6NF7c5DEnNpfK7Jf09r4z3m2GylKR0KPV9ef5ZYicYjayyIjRjm+80WcAv93YyocxR1ZE/3JU8F+mMGeJQofeqrl7jm7+58VrPxvvwpAFDei7xo+xDVsjQhvGMFt3bVzauU9AD6iqYWaboZEa5eVEquSE7aOdxG880M6szFfnabBN4GLx6PbjdjyuvLbq35aHNKFjXVRP+LZDzd5yCjsSrQQRq3gIjqTg9PqAvqO4U4hifaLX9jkBtU53z98HuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by PH8PR11MB6804.namprd11.prod.outlook.com (2603:10b6:510:1bc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Wed, 16 Apr
 2025 03:46:52 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d%7]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 03:46:52 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Xenomai community call on Wednesday,  Apr 16 , 2025, UTC 7:30 AM
Thread-Topic: Xenomai community call on Wednesday,  Apr 16 , 2025, UTC 7:30 AM
Thread-Index: AQHbroIwNOnDRcmLOk6OZENuK5aKYQ==
Date: Wed, 16 Apr 2025 03:46:52 +0000
Message-ID: <PH7PR11MB74997D0A2A025EBDE30826D6F2BD2@PH7PR11MB7499.namprd11.prod.outlook.com>
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
 <PH7PR11MB74997A20364527E81370A33FF2122@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74998618D1F5B701C8C07330F2F72@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749901F0793C63043273F166F2C52@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499534189182B1B56FDC426F2CB2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499D5045E7CD5CC207EADB5F2D92@PH7PR11MB7499.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB7499D5045E7CD5CC207EADB5F2D92@PH7PR11MB7499.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|PH8PR11MB6804:EE_
x-ms-office365-filtering-correlation-id: f5bdb1ca-0298-4bb7-1d1b-08dd7c995339
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OS9FQ0ZBQnd5MEFQcHNpS0F0NmFmQ3ZyODNXYzM3MldrSzZkOU5ITkxiaTJv?=
 =?utf-8?B?dWFSWitQL0Q0OWYvY2ZpYU1NZGNURFhqdnRCL3BnMml1RkxGWVBDZnNGWWhS?=
 =?utf-8?B?RVNmUUhXZzMydjlMZlMrdVNiWTRiZ2VHemx1NVF0anYyaFcrMXdDdkNPL1Ex?=
 =?utf-8?B?dmh5VjhqeGJsYXl1RFVXUURZcktrUEROUldxTnM4TVdjbGVaVEdGQmdMbGkw?=
 =?utf-8?B?ZW53cngvZ2pHQ2l6TWw3NytqcitNYlBzUWI0eVNsZ0grSDY1a1VyNHdsSUI4?=
 =?utf-8?B?eVlRQTZDSU9oSlhpazFoTUZzUmF2Y3VGb1dCcHlub2ljUGlwZzZUdmZoUXYy?=
 =?utf-8?B?N1NmK3lQUDc4Smd0VDlOSTZ5MU5pZ2FYYjFEMjlqSlk1Rk5qK1luL0NSNzcv?=
 =?utf-8?B?dXVXUElvVlJ0SzNPMzNZbWtxS3lhM3ZzVG9ZUjVIK2xsRzUvandVb0loSWNN?=
 =?utf-8?B?a095OFJPNUxRZHYrZVhKTzdLR1ZVVHpnKzJ4U1FLck1jRWVzSVR0NzBRNlU3?=
 =?utf-8?B?TGdUc09EL0tQK0p6R2xCQU1zbHd3aVlmTko1K015NmwvRFY3SzRjTWg2R3Rj?=
 =?utf-8?B?VERqa2VPQVFJNlpxV3lsczFURmh1VnJMa1lPUk9SUGY2SnRwM2pYdUJUemI0?=
 =?utf-8?B?WFJzRnhKY0w5ZnNGSllSNTV6VXZzNWJqR0RDSktubHRUMy9aOTNqS1Q5Zllq?=
 =?utf-8?B?ZUphekxSQVhKcmhTL3BYdXlHVjZUTkttS3JxNi95QU12SnkvcWExaEErelpG?=
 =?utf-8?B?Wjd1RVh6YThKNlQvaVBRa3N2Uk5Gd3NDWmUvOFA2NW5IYWJHOE1Qb2t6cnBU?=
 =?utf-8?B?MWJqeWptUmR2T3FucVFOV0tDNHJwb2xmdmFqbXNzcHpuWWszWStMUUljdzVi?=
 =?utf-8?B?bjRaMCs2U0VSMXBOUU5mSmJVak9Bc3lBTm1neTk1Q045b3YzemRLTDJWUFBh?=
 =?utf-8?B?cktMVnBGVENIUE0xZ0RMWGI2bmhHQmZoYUVsTTlpQW5JTE5odzdZa2dtcWpR?=
 =?utf-8?B?K0hhd2NZay9IZlg0MExvdkdFOGtzR3Jkb01xSkhRVU5LUG9YNVFaNi9nYWph?=
 =?utf-8?B?MVZoMVRLZC9mZXNsUStGSk0vRWNrS0Q0eWIxOWhYYi94UGMvUGZlNXByakFh?=
 =?utf-8?B?amJCZjBoMEtxUi9adkxMRmVCc04vay84Q3QydmFtdmlVaU9FcWYzVklBbDhQ?=
 =?utf-8?B?cUZqREhZaDdVZWFpTzU3citsQ3R4WmRRc0QxaGhZeGZDZUJHNFlDeDZSM25J?=
 =?utf-8?B?eU1YRVJ2emxPV3FmTVpoa3Q1L0VQMjUzY1JOSjBRSE5TOXNrSTFNODc4aEJX?=
 =?utf-8?B?aHlSVjVxMXdTRjZyWkVFZ0dQa0xkQlVsVnYzbk9RYzhqaDY1RlErUndRZUNP?=
 =?utf-8?B?NE94MGpLdjE4b1BSSmRxeVRjbW9lSVdqamdMSjJjbnFLcTB3dWZQK2lzZCt5?=
 =?utf-8?B?Vm5kcHZFOU5vS2ExUEVsZWZMcVR6OW5CQ3huaDdGY1d5S2lwcmFMMkQ5UDdK?=
 =?utf-8?B?WHNUYW1DOGFubzd2bkVtemdkZmhPKzBsUEdyTDNLZ2NEb1c3Tnlwcms1NFla?=
 =?utf-8?B?c2FXdjVlc1NuYWcvTnVHVVBaY2VJNFpQSjV0N0NzN3liTzV6MmsyQzNhTHBi?=
 =?utf-8?B?NXZmRVRjS3paUHcySzl0Q0xjUE5ucklGYWNhbERWb3VhWHljWmU4SnQ3V1cx?=
 =?utf-8?B?SCtxNENCajdXc0FMZkhlM3FqS1pEclFOZHhCMnlYbm9jY1V4Zzg1TE9WRXM5?=
 =?utf-8?B?R1dkb1dYdml5NTFhbVU0aVpVVE9oSUF4d01KZEw1WXh6bXg3am03VnBvc05S?=
 =?utf-8?B?RjV1cUxwRmMyTjBGY001N1Y1VmV0aloyQXF6K0t2cFR2TGdQZEdjTXNlTWY3?=
 =?utf-8?B?dzV2aFp3L002dThTQkYvYzNBS0dMY2NIODlSUlhNV1ZpYmFVUytJVGpYaDNj?=
 =?utf-8?Q?iEmxN3UK2f4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUN3QzlQeC9IV0NheFlHZWdaSEV0bms2TE84amZRSjZwNStxOVV1ZUd6dkcy?=
 =?utf-8?B?cXRXU3lkSzFTeTduNkhqMVpFdlRZVm1FUzEzamk2dThXUnRxUG9SbHZ2NGl3?=
 =?utf-8?B?NlphVnB0aElob2krY28rMDdpQWRudXRkenZVVUNzeGduQVZxemdWYjFsSHI2?=
 =?utf-8?B?ZXNhajhLMTNHY2E1WEpCN05wWkZyWXVVSGFwUHNZVWlxeWdYVTZZb252K2Nj?=
 =?utf-8?B?bHNZREFsNnluN3RFd3Y0OWxzQ0YzTS8vSXlPK1ZMZmJWUkt1VVhobFFsdTFr?=
 =?utf-8?B?VjRYRnBBVlNpbXFGa1pFcWg5QlNyd1dCUWZwbjdzZjk2SVFWdkRWSjBFeGhW?=
 =?utf-8?B?MDRZKzcvMDJ3Vkd1MnNzUXlST1pBL0FVVk5LRm5kUU5ZNitkYnZza2lad2FN?=
 =?utf-8?B?Tm9pRDY2QWk2dEV5N0IyOU1xc0U3SkVXWlZWTzZQOWhOaGhwSmZEa1pVZm8r?=
 =?utf-8?B?Q2RqeFg3YkN3K0tMa3VuMU5tRkNkNTlVRGxOeURzT1h1SHp5YlFyWnd0UU5o?=
 =?utf-8?B?cHp1OGlGWDlKZUkwMVhWU2JwVWIvWE90TmVhNW9kYjJEaCsvMTZDUlJUR044?=
 =?utf-8?B?WHdPOTVldVpwcDlKZXdEMnlBaW1pRVZFNTlEaWx3RWdMdEE1cWQ1ODYyNS9o?=
 =?utf-8?B?d1cySDlSVVhNUDVvdUhlb2hEV0RJSjI3bzZtODRqNVQ3V0dHUkk2Y09vbEg5?=
 =?utf-8?B?U0NCVHhQYzlGY29VNzcyVkgrSzZxaHJ4WFAxSHROZXlod21McC9JUEVGRWla?=
 =?utf-8?B?WUMvbW1KeU5lTXZWRm9wNTltNE13NVJ6a2xreStyVUZKVHltM0xUcU9zckJ0?=
 =?utf-8?B?elRrZXNsbGxNbnFNbFBvT2k1T0hkRzNxbmJFVVJTa0lpY1g1TFE3ejNvbGxx?=
 =?utf-8?B?bXpMcXBxaWRpUGlvMURSeVo5ZmlXekVjU2lwZHBENlhvZjBZcVlXSVp0VEE0?=
 =?utf-8?B?Tk9rUXFCWHZSYURTMjNsQlNzTzZqR2xPclRsK3lrYXZxUVVJUWxkSmdvTFpH?=
 =?utf-8?B?VEpTZWxQMnBidHBJM3dRcXZ2NTVxZEFmdjU4YkN3RlhZL0VtUUpLQklZc2lu?=
 =?utf-8?B?YVRkb2lGVDdNYjBqTll2SkRUamYrQ0FIem5KTGF2S3FqVzNsNE80dElHZHlJ?=
 =?utf-8?B?SVlxVmF6N054SkpVT1hoRUxJUGs1dzB2cVBXWVJncEhpKzBweDd0bnNZTWJa?=
 =?utf-8?B?RW8rVVhpOVc5bXJkUXg1bWpleXJDQVkxSW1sSW5FUkJDdUxtVUpOdGVENmxj?=
 =?utf-8?B?VHNLVFhhZWVzbHFjdjZuTjBQWHpuSmNPbzB0TWVvR044YVU4SmpvY09NRzcx?=
 =?utf-8?B?RG1tcThMN1lnL29GRUN0a0YrQ3pSQWQyOEtBOVQwak40T3NWTC9zQTBoankw?=
 =?utf-8?B?RnR3RHJNajZOYjIxRERtQXdpTUVTaFFRNmdGQnNWR0hXWmpmdkpkNnp6eDhh?=
 =?utf-8?B?amN3Y0toSXpDNW1zT0lQd25kZHVqcTc2eXZQR3A2MTkyalp0ZzQxUTZVVFBp?=
 =?utf-8?B?YnBRRGt1RlBQaXdGUEtRUGhJQXZJeGltaGV6dDRhdUppNkdNMDN5WHR5YTRH?=
 =?utf-8?B?Sld2S2k0MEQwLzJNUENIUXdYV0pWOUhxM3VlcWtSVG81eERoTEJpQmJwS3R5?=
 =?utf-8?B?U1NMNUpqYnhCeHhjVDhQcFRCczJIbU5mMDU5N0VxbmFVY3UvK3llRGJsRnVt?=
 =?utf-8?B?RktBLy9QbHp3MmRLYmJlZG5jMjlUS1FqRytId0lZdVlLTkJBbkFsSkhDcHB1?=
 =?utf-8?B?d3p1eTA2ZVYrcHJ2T216Z1ZWc0F5WTBqUzhRVmVmbzFYL3dicWVMMFBtUEVT?=
 =?utf-8?B?V1hvaStUcFdmMTBEdHZPNWhtU2lBS2h0TnlxT1kxNmJhZmxuRFVXcGx1NFo4?=
 =?utf-8?B?Zm1TRnJEY1lsZW9WYTJmaXhZKzRiaCtyUUpoVnZOYmkwQ3hKd2JTYS9XMk5H?=
 =?utf-8?B?eCttRVhkcXJDbE5qR1lDelFsS1NqVzM3QXdtSGYwOEFKSWVZLzNDZ2lVa0c4?=
 =?utf-8?B?c29sSWxNWUxwZTF6SUtVVG83OUlSYk9rWG4wMUJXeTE0YnF6Sk5LOUJ5Zmhu?=
 =?utf-8?B?UnJ1dFE5YU5aZ1R5VGRwc1llMVVvTnZUdkxFa211R3ZHMmlSSVU3ZTE3TzVQ?=
 =?utf-8?Q?VDEDbJh6uKGZX6enkq5oAlyRT?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f5bdb1ca-0298-4bb7-1d1b-08dd7c995339
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 03:46:52.4040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OdUjVXnWtS6BREenwrilCag4k/gNlaieXDTsVeYuYKB+VfuF2P2Ip99CTAAllBX+k70vkfFdJhLQERRKjZb1vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6804
X-OriginatorOrg: intel.com

VG9waWNzIG1heSBpbmNsdWRlIGJ1dCBhcmUgbm90IGxpbWl0ZWQgdG8gdXBzdHJlYW0vZG93bnN0
cmVhbSBwcm9qZWN0IA0KcGxhbnMsIHN0YXR1cyB1cGRhdGVzLCBhbmQgdGVjaG5pY2FsIGRpc2N1
c3Npb25zLiBJdCdzIGFuIG9wZW4gb25saW5lIA0KbWVldGluZyB0aGF0IGFueW9uZSBjYW4gam9p
biBhbmQgYXNrIHF1ZXN0aW9ucy4NCg0KVGltZToNCldlZG5lc2RheSwgQXByIDE2LCAyMDI1LCBV
VEMgNzozMCBBTQ0KUGFyaXMsIEZyYW5jZSBDRVNUIDk6MzAgQU0NCkNoaW5hIENTVCAzOjMwIFBN
DQoNCkpvaW4gWm9vbSBNZWV0aW5nIA0KaHR0cHM6Ly9pbnRlbC56b29tLnVzL2ovOTEyOTcyNzky
Njk/cHdkPVdtZHdTMHBET0RSTk1TOXRRazU0WTFkdmJGbHFVVDA5DQpPcg0KaHR0cHM6Ly9pbnRl
bC56b29tLnVzL3djL2pvaW4vOTEyOTcyNzkyNjk/d3BrPXdjcGs1MmE5Zjk2ZDk4OWU3ZTIwYjYy
OGMyYzM2ZTQ4YjY4ZQ0KDQpNZWV0aW5nIElEOiA5MTIgOTcyNyA5MjY5DQpQYXNzY29kZTogMzY3
NTI4DQoNCg0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQo=
