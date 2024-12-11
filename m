Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F81FC148
	for <xenomai@lists.linux.dev>; Wed, 11 Dec 2024 02:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733884550; cv=fail; b=KJkDy+pVVTQvEY7TMoxaeHFFTwkzbE//GJUSKu9lENaYb5ZJDR0Yml6HkKwwkz9h8eJ4WEMEAfexWGefaLsGjsN87Z+FW4Y/PkPa0wWcXzK9YddBZVymrLNuARnuVc/8fe05Bam0FgEJ7UCIq4Bsg4+BRl7bKp5AC4LpdUfEVD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733884550; c=relaxed/simple;
	bh=vkYUkPI1eJqEORfjyz/90aB4g0Rj0Hp0UBnxV0kQ/cU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GG/3Pon4qOOfqu6fgu6H5ucXhX3QDmV/nJoNrUOKc/8YCed4rNHbMio43zMUNXCwrhIUn26QxukABDKfpWogSAVmSdI2IUtCZCju+1EWlTB8TIk8FD/H3L5Vg12hSph9kNnz8elhvKcklkI24YKiqCRbfDjqR+PuDKLGJOwzSd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ecWxaV6W; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ecWxaV6W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733884548; x=1765420548;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=vkYUkPI1eJqEORfjyz/90aB4g0Rj0Hp0UBnxV0kQ/cU=;
  b=ecWxaV6W7+wN1WIk+NNEhpKpuO9TBqyOH1kmYl9JeSRwYs3BLpOqOjEJ
   a4fKYppuRv0N6Fr7FLqJN7aSXCja7MdD2ycsgTY5ALpWc0tIK3G/gp3Wz
   qbDLTzbQKs6D+Oc4ncXc6wvw5gmbArEI4U/20a8w3sLkuf5np02mBbd/u
   wG/XVYw7BIySQGNoKOvbTjYc33V8zBUmPEYPyxPb+SF7CdkfOj4I1dH7z
   B3qqEz6T+xdHjGqNB6riZ4O49P6zncUFdXwnmTVO/avCWFJc7vEQit431
   kYObnzRtPmo39kUMRTlhFWHNSct9PP5HxtaJQ3enwcHtz7/Dpq6FDSXVJ
   Q==;
X-CSE-ConnectionGUID: i+gtyYrJQEWcJAyly4lM8g==
X-CSE-MsgGUID: hicvXIc/RmewGJR2jTXwHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="59645452"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="59645452"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 18:35:47 -0800
X-CSE-ConnectionGUID: e+vVxLjxQJywfHbNJEk87w==
X-CSE-MsgGUID: mAAkqxYDRoablXqyJUe+MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="95680479"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Dec 2024 18:35:40 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Dec 2024 18:35:40 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Dec 2024 18:35:40 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Dec 2024 18:35:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JcsBucgpFhNqqjAv23Yf/SVBzhA4oFQAYGBhoXYaU1CaUGw6kDrHxGqBdLWqP7XouuevMT7KIjUWNvxyQJOUJFYSHKzZ11WfwbBZmX528/Uu8sHtDUNkKFTC8dPHnh26mmSclBn19Od5E5AxWzCpkUCJgs/N0oMHyJHaYGZ7sgTtJS9tG8kpSrD57mnXDlnXmb1OBX7wylPcm1u1+4ZQoCzbpqp1IpLqbnE/p6yj1ukn2f1m9oUFvs2bNCF5GBZy65nxKZmqmmTdsyMDsktOErt6506AQn8Rbix/jR1greQtHScILC2GwpT+qP3JmTSlAGzAbIZ9MelP+DCflUx6TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkYUkPI1eJqEORfjyz/90aB4g0Rj0Hp0UBnxV0kQ/cU=;
 b=Ig/sAUVzQgOZHOGTpCopCZpJldlNnWOTQsqv+5IcTkEqvBU8N65MLV1RfCEl92h/Qv7KjP7/g5bwnKxigZKIVQDqZs3B/U4HuDQeiwu5gJRVXKW0xuJEOollUO6+VTjnSDbacS7v8lKOOv76rV+/u49kSSAN6eJ1V1KcsbGrThZRjXSMqAzz0kSbD37oNv+skEdZPznAyj9dQQEGMveUDgz4i9WfZbP3gyHvfCYRq6sIPJFw+s/rq1ozqsS+ejle7o1d3ssC8ijIaF/gDD3KciMNSwUiX6wdewH0g4fIBU0mnWQ/y7HUG09Lg2Fx1kbyKImBqrHplSibJHGm56KQ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by MW4PR11MB6617.namprd11.prod.outlook.com (2603:10b6:303:20d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 02:35:37 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d%4]) with mapi id 15.20.8230.016; Wed, 11 Dec 2024
 02:35:37 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Xenomai community call on Wednesday,  Dec 11, 2024, UTC 7:30 AM
Thread-Topic: Xenomai community call on Wednesday,  Dec 11, 2024, UTC 7:30 AM
Thread-Index: AQHbS3VczTkH3so9OkOEJFMKzIVcyg==
Date: Wed, 11 Dec 2024 02:35:37 +0000
Message-ID: <PH7PR11MB7499E7C229D3943554AE31B6F23E2@PH7PR11MB7499.namprd11.prod.outlook.com>
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
In-Reply-To: <PH7PR11MB74993347DB8F72364025EFEBF2282@PH7PR11MB7499.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|MW4PR11MB6617:EE_
x-ms-office365-filtering-correlation-id: dde667b3-94b5-4174-ea57-08dd198c7f0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cnRtcnNpbHFJanZoaHc4WERWR2xxTENVMjJ3WnRhK08rZjIvZWppa0pWNGF6?=
 =?utf-8?B?N1lUVHlDWE5zdzV5VzdUNDM5aEZRZGgxZ2djUytjeWIrZktSdUUwMWtXSC81?=
 =?utf-8?B?Ri9UMnF6cU9odXRNT25hQ3BkaDV5cDBZdFpROW4wR0xwU3FFV1FBcEhTeHlY?=
 =?utf-8?B?SEFnSE5XU09YTVM3bmNkeWVGVkJpekFVblBGTWtaYnNhSkJScWNNZHVoN2V5?=
 =?utf-8?B?cDJqTWpXc1o1Wnc2aFF1Rkk2NTNSQ3Z1WlQxVFpYQ01aVG1JclRBMUZvTG5r?=
 =?utf-8?B?UlRJM0NZYTlUZ0FCa2hpOCtWVnN6WFhnVjAzV2hGbjVJWkhhRm1yY3U2dG44?=
 =?utf-8?B?VHBqMU1mM0ZEeWdIblJ3N3RLd3pzTlBtdnprc1M5VnIvNzVOVUZaVUp5UnRu?=
 =?utf-8?B?Q0paQk1hQWdEN3N0b1RubGRLbGtHQWxPVkQ3ZWFLKy9CanI0anlUSHE3NmdL?=
 =?utf-8?B?R1R1cU5rRzBoVFpDWUZEck43M1FRWnNjWDlobWt0WG9xc0p5eEZKMW9SNjFz?=
 =?utf-8?B?ZEdYUGlaaDN6U2ZMVWlBelljcWhzdlRzSURHb0U4aTBSUC9RZmFzUlJYMFVP?=
 =?utf-8?B?ZzlXZHRyclprWUtPR2FKNy9nT1hUUS8wYzVhZWc3Syt1R055dUZ1TkpJcm1i?=
 =?utf-8?B?L3JaRUEwb1hIbVJnVmF2SnNWRlg2VjdmdUxFZ0xqUzhhMDE0Z0ZZSTM1ZHI3?=
 =?utf-8?B?NkZadkx6KyszblBGZm1MNTdrbkMrZzE4MXAxU3o2VlJMdndSQ0lCYkZNMWlP?=
 =?utf-8?B?VlcxbEs4cTNRc0VjR0Iyall6K3JWUXZtaHd0L2JaMkkvOGo1akw3eEZXaE9a?=
 =?utf-8?B?VUdSSnE0QUJLWFlmQzJVdkVMbk8wczRUVWlzdTh5S1VIK2JuVmxCOEI3dEM4?=
 =?utf-8?B?T090ekhMcXMwZG8zbFJGZXNndXp6WVdkQ0I5RmtVUUZyWi81UTFWL25ZZHRy?=
 =?utf-8?B?Y093UFZUZzdIbmV6YUwvaTNOeFV5WWk0OHFWMEN2Sy93em5OWGx4M05sK0ts?=
 =?utf-8?B?YlV5Z3Zmbld4MXVNbEhvcnRUQU9YeFZGUHFmQ1l6MURZRUg0VlF5VHlSL050?=
 =?utf-8?B?Nk9GeTVWd2E5VXFONlFzMGVDNWo4dTFWamhOZHRkVVMwT2xabzFFc09CaG9u?=
 =?utf-8?B?Qm54M0lxYW84ZW81QlZ6YWlrWkRTZU9xTWJqdW15bGQ5SU50TXk3d3pKdDF1?=
 =?utf-8?B?eGY4MWhjNGZ1VGM2dmNPaGJlNERJKzNrTThOWmdjWUVTaW9hZHUrNmRwMVky?=
 =?utf-8?B?VmNlS0tla096eHhHRlowYTI3MFR4RFBwN2gxRnVMTjhaVkVMSllBYzhubWhI?=
 =?utf-8?B?STlFWHVvZUFuYUMydndjOEJrSDVpOExSeFZWUkZPa0hTeDI4c1ZSSEkrNUoy?=
 =?utf-8?B?Vy82SHovUjRpV0VNUE8zdVlpMzlmNlVCcUxaVzF5T2FvNVVWS3FFMFZTWHJq?=
 =?utf-8?B?cDl5OEpkZjYrTE5mM1pkalZXaXM4TjVFK1JoT1ZESXdWVndRcXE1YVNJV3VY?=
 =?utf-8?B?ajkxaUNoSlExbnpYU0x0OGNaRW13dXFTTWNSUVZmQ1VKYitpZ1VEZ0FTMTVl?=
 =?utf-8?B?UFRzM2J0OGNTNnA2RzVNeEhMOGQzVTFyZGo0Qmo1dUhrLzhEMnRPMzdnQkVK?=
 =?utf-8?B?Q1daTGRTSVZRZlRWWGtpaCswRXV3WUFKazFDRGFlWmhwc0pmQ0pMc0Y0VVhm?=
 =?utf-8?B?N1ZweC9wNFVaM3FQTUMzVG1lM1ZJakpaL3RSRXV1WDJvUUY0bCt0RXhPMThV?=
 =?utf-8?B?Q1VKMGhWcVFQRmc5c3llaWI3N2VWaHMrOU9WbjBGVERiTHRHdG4zUExvR2dk?=
 =?utf-8?Q?vjFPJmdAJvVT1fygN2VqazLtLF2F1iDNnMs+w=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VngxamNwamtiQml6eEVlbkR3OG4rcVlMaS9GRFZVTWZyamhzNFkyY1FBR3JZ?=
 =?utf-8?B?QlBibDdZRU1NbVRDWU1XUWU5Sm9BWCtFY3loNFA2RC9aczRNRFFpek9ROTZM?=
 =?utf-8?B?Z2ZJcnB3ZDlmdlNQeFJ3eTFYSnE2bXVKMmhyamluTVVJOWN6TTBpcTQwVVNi?=
 =?utf-8?B?VTBIWWVOV3h5OThWWm1PVUlQTEI0R2pXTGlRcmx0VzhEOThWK1REZnk4U0xR?=
 =?utf-8?B?UjNUUDNiT1NaUSt4TVJHQWhheXhUbE9JWVNPaEIzRkxQczlBT2xyc0R0bmk5?=
 =?utf-8?B?QVVwdTF0Uk43VTNJdGJHMFU3cGFHNEhYeERDQzRSOFV2WHh1YWVZTHNLSW5Q?=
 =?utf-8?B?QysybDNzWWtoNGUrUnRhUjRqT0JhMW1vZk5jSVFualQ4eDlBbCtRUVR5YnhT?=
 =?utf-8?B?QndBc2g5bXhjb0l0MWdaa3IrY2VqQzgrN0RwUzVjVDUwN3grMTE5UGN1ZHNU?=
 =?utf-8?B?ckJIN1FWa3Z5Vzk1SlRuVzIyOFhmejBFVmIvTWFJVS96WjlvMU5jOU15aUY4?=
 =?utf-8?B?dVFCQk5yUE1ZczJ5S0d2Q3JvcGtBbWxPR0N0Q1BUK3ZjbGFxQ2wzV3BQZTRi?=
 =?utf-8?B?cS80bkowQ3pDbmExRmRUMmZQcEZBNFdCR29aSWhXUkFLYWw4Z0UxeE5zVHor?=
 =?utf-8?B?MHoxMjNKR1N3dVY4ejVhaGJTbS9PNTBJOUJQek9MY3k0cWVjd3NnNkRNUHZF?=
 =?utf-8?B?dHpjdWtLa3NjZWtIOFdWYnJUbmVlS2h2S0tTK3NCR3UwM2JRMWdQN2s2Wmc1?=
 =?utf-8?B?VWNsVmc2WkpmSk9xV3RvNlBkUzNmVXZhclhXK2FQZ2tmdWYxWlNLbVFxdEhQ?=
 =?utf-8?B?cXc4TjVtMTZKSHkyZXN0N2plS1owOVhNOStRczVkKzBFWTZtZ2xWZUphSHZZ?=
 =?utf-8?B?eGord1M1WTRlK3RGclNvU25vMmxqSFFzaXZaVWVIb1pIY2lsVmVMNzl2bG1x?=
 =?utf-8?B?STdzZzIydW0wV0tZODhsZVhpN1BHUnNLeVBNcGhkaCtNL0NnU0dxdHZOeWpH?=
 =?utf-8?B?QjdTOVFaU2hNOW45MHMzNnE3eHRuNHRCYmVIckNZUmt1QlJSdENRakovNEwr?=
 =?utf-8?B?ejVhT0VONi9WaWxJZFdjdmlCTnJTZjNpUnRUQUNINHA2REMyZjgrMTNlSmEx?=
 =?utf-8?B?N0g2b0tGdVNzM2ttQlVDc3lPT2FEZlZoQWdVK0JmQnpjcWViMVdTRnRWcU13?=
 =?utf-8?B?dWcrVG5mZVZldXNqTTF3enhOQUVNeTg3MGIrVUdrSUlaTUlqeE4vTUpndnZa?=
 =?utf-8?B?NW1uUTl2M0Y3bFBhaXdnZlUrd1NzaEFteld4ZnZSa1dEcGQycm43QXVaSmJ1?=
 =?utf-8?B?SEE4MmNtencxeFExWnNlTW5ObHRpL08vbmJqV1hBUFV1ZEt4aldVcG5Ecmt5?=
 =?utf-8?B?NW5TK1UrMSt0Wi94RnA0QmRhalh6cjNWMTFYd0dIeW1KNEQ5NlRSQWNLMUZr?=
 =?utf-8?B?MlBpdXZhVCt4K2lvQ3duazNmTXVZald3b3BMckFoc3JqWlg2QU1FK0hkRmJO?=
 =?utf-8?B?TlFyYitqRnkxYUtzOHhVdDQ2U3BWWmYrV2tSaHMxRzN3TmdCTHBxOWZHNk9B?=
 =?utf-8?B?SW1Cb2xyalFTb3QxQnUvYUdKMlhkREJMTnNTMnJKQllFSnNHdUJ4NVU1ckpG?=
 =?utf-8?B?aFV2d29HUmVIOS9Db3pwdWdBbzdWVHVnNE9KdUl4NEFYYkdSWUxlUGZuQm5i?=
 =?utf-8?B?L3E5UWRsNmFHTDNzRlJ5eHBldnkwK29uUGVma242c2d1c2lmb1FMSko3dk5m?=
 =?utf-8?B?RDNpVTZIVVAzREhLTDRZOU5EV3laNUZ5czFHb2pmV2JlV0FTd2lxYXBQNVAz?=
 =?utf-8?B?cXgxMVZodkdLeE1YSldyN2RNZ0F1czJrNzNONXpvcnM5QVVIV0RwZURZa3M4?=
 =?utf-8?B?N3ArWGc4TjRzaHhYMEcxTWxLNmNPaE12UU51MDlUNFJmamkrN2JGTUV1bkt3?=
 =?utf-8?B?SzQxV0VndHNDSFlmZmdjUSsrZHVvNm0zSk9tMVZicjBndW9ZMTJiS0V6STJ6?=
 =?utf-8?B?TXNJdDRIV1JhN2srMDJaUit0djUwSm9URWZyK1FqdTBlS1V4N0dZSExJTkRB?=
 =?utf-8?B?OXRyTHV6cDVuLzA3ckdpU1FOdEZkWjB1SXFQaEw4bTJybjR4R081T3M4ZFlt?=
 =?utf-8?Q?RhvPc13F13qg7EdY8ULkvGnLE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dde667b3-94b5-4174-ea57-08dd198c7f0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 02:35:37.3732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Tn7V/VBUiHSE5Q7XxAQu7BWeCzd+vJgFvfBtnqgZDh59oR+XATxU2CSpc63m3MuFjyJFCJGUU9diTwLbbybdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6617
X-OriginatorOrg: intel.com

DQpUb3BpY3MgbWF5IGluY2x1ZGUgYnV0IGFyZSBub3QgbGltaXRlZCB0byB1cHN0cmVhbS9kb3du
c3RyZWFtIHByb2plY3QgDQpwbGFucywgc3RhdHVzIHVwZGF0ZXMsIGFuZCB0ZWNobmljYWwgZGlz
Y3Vzc2lvbnMuIEl0J3MgYW4gb3BlbiBvbmxpbmUgDQptZWV0aW5nIHRoYXQgYW55b25lIGNhbiBq
b2luIGFuZCBhc2sgcXVlc3Rpb25zLg0KDQpUaW1lOg0KV2VkbmVzZGF5LCBEZWMgMTEsIDIwMjQs
IFVUQyA3OjMwIEFNDQpQYXJpcywgRnJhbmNlIENFU1QgODozMCBBTQ0KQ2hpbmEgQ1NUIDM6MzAg
UE0NCg0KSm9pbiBab29tIE1lZXRpbmcgDQpodHRwczovL2ludGVsLnpvb20udXMvai85MTI5NzI3
OTI2OT9wd2Q9V21kd1MwcERPRFJOTVM5dFFrNTRZMWR2YkZscVVUMDkNCk9yDQpodHRwczovL2lu
dGVsLnpvb20udXMvd2Mvam9pbi85MTI5NzI3OTI2OT93cGs9d2NwazUyYTlmOTZkOTg5ZTdlMjBi
NjI4YzJjMzZlNDhiNjhlDQoNCk1lZXRpbmcgSUQ6IDkxMiA5NzI3IDkyNjkNClBhc3Njb2RlOiAz
Njc1MjgNCg0KDQpSZWdhcmRzDQoNCkhvbmd6aGFuIENoZW4NCg==
