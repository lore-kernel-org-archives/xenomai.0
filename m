Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361172111
	for <xenomai@lists.linux.dev>; Wed, 30 Apr 2025 03:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745982040; cv=fail; b=p5NHYztK7+f/m8byu+qa6oGIyQo7Jy706myLF07hKtFi/tTP44bRrUFlF933w7prsst62949AXKjwyaqAbNYyEH5Ql/WgSQI4imMKL5kEFhqVaukJVbEswwSzvWqLls1VZyjaIbHwIXRqdHYgHYm1OOKdx5Dbrr8w2eLiNatEHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745982040; c=relaxed/simple;
	bh=NruIADhGAUwFbZGJGzMEsBUgpepZppVEa2LD1r+a1T4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jz2iwIta/VXlgxmOywDNaMaAhSM/ENy5jO+cLFsFaE0yT5YKRIVqic1xyQHYvQjaTSZ0ur3XHEuBn+lQ2Gy+E/p5BaFghHxViS3rxjld5uJ5OpX6rGejH0IWx6oFhVdDINwqngjK1MFnLWpgC+2FE920o/3ZGOnqKcrUnWCfNB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aDYgiJe5; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aDYgiJe5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745982039; x=1777518039;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=NruIADhGAUwFbZGJGzMEsBUgpepZppVEa2LD1r+a1T4=;
  b=aDYgiJe5C2ib0ZqHT/ReasJACwdiUbB6bLPb/8tLPGm2UYQmNb722wRC
   d8VaU8E7XnZAod8Bje3z/Sblu00SS0Ww3JuwyCO6gG4Q59c1WvkE5iNcw
   sjG7aUcY4MdVLaurmaQmG62CVMC4DyETFIToyXwPsF2seP0Rzu2XOsXek
   aMXA3/ruv1wFFJVN3l3EHn7TC3a8Ih2WBpouYo0AOx//UNXK+ZfzHw7IY
   exOMO1bmsZm9Azs2QdIxp8aGUcZYsSKB537RlV0N05JTj7w500Z6JsiHR
   LMu4+7R9xX8kOjaYwgBrsAiv5oC8Le4joxZE2RC/39wMdyu3yNGJj+yAl
   w==;
X-CSE-ConnectionGUID: 9sYZJSDkSVGAS/KNgNeNkA==
X-CSE-MsgGUID: X+ou5v7lTSGmxsfxHEc2YA==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="47537398"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="47537398"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 20:00:38 -0700
X-CSE-ConnectionGUID: +TQGP3ucTJmjIl3abCLMhw==
X-CSE-MsgGUID: X84N3+CxR6eKDoYpZ6IDIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="138971899"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 20:00:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 29 Apr 2025 20:00:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 29 Apr 2025 20:00:37 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 29 Apr 2025 20:00:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EGNydSJpWloblMD+fXTxdGuJio0Uo8jApbPlH8aMMVFaGtwvepmc716qc9l+Lu/PvKlg2cSQmyg06nRI0ktnYqX0HydWZ25DUIWcthWLozleq2kFs/gijkMufyTgYZ4+/SXy3AvoZQ/w+5hEmIXLUIg8JaTuphM712nY/e2D1ud4vlP0x9fS0/poFlAG3iiRrlDBGKrHnGfHRGU09iljmiy2jxauwQexkEr6JckSX/4X85ZMIKFNZitmczvnK5tShFmUg06m6VbKzat1qsZIfWca5ACB5xGNQPjzsbO8ZJvpuUxn64VTn/vd3cMB4kUwHkDIFtAnI77EiykfE7UWWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NruIADhGAUwFbZGJGzMEsBUgpepZppVEa2LD1r+a1T4=;
 b=mzvmSeVj856COGHSkWYXiK8A72smAwM4OhyKn9U+GWnFXJvf4OVzb1zBZNh2kK704pWxl9Yf/nFjV3HC5aaUSlzzf9Iy7kJzjVadXhK0ATHIFJinnf1+WpNCTWGHDJ1tvLYgxIzGMKCuQLDS70wVJysf1BJ9PyokQlj7rh8VrYXHHUVp5DLiot+XrtsFg4BMI8edqttZ1698xbztQlk6RPgwCnYIXgKTBqmejmm2l4so9Ir3rnnom7RDbQK1ESj6WYG+fAAxUsN0yW1Y5MkKA5dwQU0ahoFH3l6WVpDjoGnwLxfOc1ex2QqPOP/Kf4LDigo9hxJxkJH7uneicAQR9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by IA4PR11MB9395.namprd11.prod.outlook.com (2603:10b6:208:55f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 03:00:21 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d%4]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 03:00:20 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Xenomai community call on Wednesday,  Apr 30 , 2025, UTC 7:30 AM
Thread-Topic: Xenomai community call on Wednesday,  Apr 30 , 2025, UTC 7:30 AM
Thread-Index: AQHbuXwCSWo9P0AqjEGW9qSM2tAsww==
Date: Wed, 30 Apr 2025 03:00:20 +0000
Message-ID: <PH7PR11MB74998FCA330C96F94503AF18F2832@PH7PR11MB7499.namprd11.prod.outlook.com>
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
 <PH7PR11MB74997D0A2A025EBDE30826D6F2BD2@PH7PR11MB7499.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB74997D0A2A025EBDE30826D6F2BD2@PH7PR11MB7499.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|IA4PR11MB9395:EE_
x-ms-office365-filtering-correlation-id: 71acd83e-870c-4d40-d4f3-08dd8793250e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RW9vZmI0TVlVbWk5NW5WNFVnUUQzVmZIUUFDVEN1TmtsKzJkbjdMOTA0V1Zn?=
 =?utf-8?B?Rk9iR09HVTRTRGttOWdyOTg3Rm9NYUpyeDZXdXhiU0kwTitBOUQrWC80Z2M3?=
 =?utf-8?B?S2pZMmpZMkQ0MWNqeUVONWFYRmlsOTA3SVNDZkZQcVZBdFRvZytLckphWm5E?=
 =?utf-8?B?VGxRb0FuTTQwdW5PS3R0QnZaa1FRNW1vMnFKakNUaE1WQUlCWlQvcm9LeEho?=
 =?utf-8?B?VUZyTmJEZGJ2N2VjcE9wa01LTjBxUmk3MDh5Mm5hRUcwM1JSTy8yMnZvYUI3?=
 =?utf-8?B?MW12blI1V1pra2NEb1RJZTJCUlFabXMvZG8yQ1d0UEpFYU5rWk5Xb2gySUpw?=
 =?utf-8?B?K05WbVo5UTF2NFB2dXRGUDhNV1pkVVNQS0h1SCtaTDZBZFF2NXZIR0ZNSktq?=
 =?utf-8?B?WUdVUldoUm1Rdlp0elNrMWc3MlpOUEhVNUM4SjFwNGppYUNLaWZOMDlQTDJU?=
 =?utf-8?B?SGZyZFMrcGJ2S3JuWEJFT1lmanY2bzZNZ0I2REMzamJxUzNSaXpCa1VmNlJE?=
 =?utf-8?B?aFhIMUhja1VKVnE5TG95RDVPekFEdTZDczNHR3hNUHArVlhDNEpGcnhWOHdw?=
 =?utf-8?B?UDJ4VEg2N0U1M1lDODhGZnFjRVFkMnA2Zk5IelhVZmNrY29zaUxoUDNNbmwv?=
 =?utf-8?B?M3BUcDJuc3pZT01ERUNsQmw1YjhZcUc4T2ZYYkl0UlQ4eVpCL1dBOURiQUdF?=
 =?utf-8?B?dUwzRE13NE9wZjU3MCtjYk00c2hBMC9zWkZqcjUwb2xhNzVScVNqcmJhMWxz?=
 =?utf-8?B?M0ZlR0hYZk9FbGUwWWVsMHFxdEtGWUNXTWplVnhCWTZTMHQ1Q1NkTnRpc0lM?=
 =?utf-8?B?VkEzQmlDdDdlWFVGTmoxZDBGWUZqRkN0cElQM1NyTkd1MjdybE9SNnlOR0Vu?=
 =?utf-8?B?bkRmdTdGRmNad2V0cHJpYlV4MWg4N05WSWdLMHpvbmZSQkFGMjVHS0ZFVzJa?=
 =?utf-8?B?d1BRbnFPeUJINWRETzBpbFlwejV0Ymx1V1pCL2dRaG5Jd2VuL2tOb3B5cy9B?=
 =?utf-8?B?dzBRcUR3eHZZaUh0S01RM3YzcUs5bk5GdzRJRzBOekhjK1E3bUtmVWNENDV5?=
 =?utf-8?B?N2ZJTXVaeWhXemovSUt5UCsycFJLWHkyQmpjRkJtb2dpVVo2eittdEQ1TmpP?=
 =?utf-8?B?WDFMRi8wZW1URzdRS3Z5bHRsRXl6MVE4cVNRN2VvbXlqSW9hZkprMDZnajNr?=
 =?utf-8?B?NmI4RGFMVXQ5R0tOWVZTSFpxQlRwQkNDUUxpVU9WY2RidUNGQnFvalB0RnFX?=
 =?utf-8?B?RS9TS1JFRmJIR2kraDIxSzViZHRyeFdtR1F6KzR6dllQY09kY09MQWF1ZlBx?=
 =?utf-8?B?dnc2eTBiWmlpWmxsQmJML3dsVDBuMEMwS3N3QlVVKzBZMHVpd3NsU3pBb2NT?=
 =?utf-8?B?d0N5ZElEZXl3UmZYSG12NTNsMHVqQjhHQkYyYmJVNXk1Y0J4VHVHa3drRWxX?=
 =?utf-8?B?UTliQ0hNRWcrZ2ZrRXE1cExvSUV4TzBrU0lVRjV6WHhaOVlRdGdIUmtWWU5t?=
 =?utf-8?B?REF2ZkRRK0FoWFdETUZoUitPQlo2M21IblBaQXpXb2NHRy9xdWRZL2gxei9J?=
 =?utf-8?B?QXNtbUlmZ1p2bktrd3FtRFhEY2piRFA4SC9nNjFhQVdNYTFSK3F6bWt2WmRZ?=
 =?utf-8?B?OGVQYytjS0JZK3pmNjR4ZTg4YmZqMDcwYTZZSCt5MnFBVi9IaVZxbzZXYWc3?=
 =?utf-8?B?VExJMEN4b2tvVSs0SEFZT1lORmNyaS9nN0poaDBaTzltcFBIT09XYlBQeU1D?=
 =?utf-8?B?eUVHQXJ5bmNRZk4xUnNwbW1tbHBRZ25ySGdrY1Y5aUlFTFZzNDNwZ29uLzBQ?=
 =?utf-8?B?N3F4SnhLVXI1eGlCMzNQelh3dzhvc1EzTEZXQ2M5ZVZRV1k0eUxNNXpJbVhh?=
 =?utf-8?B?SDErdEt3U2RJaWVsVDBoZ2RhamZNMUNmRFpRNHNyYWg0TWhWbWR1Q2VQZ1dU?=
 =?utf-8?Q?E5k/tUrbQOY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWpOUm9nUUsydzRPVUl5TWQzaGtDWE5Va0pEeXJTakZQVFZ2R2JWb0t6TWRK?=
 =?utf-8?B?dEFSUExybE1hRXIzaTJsb3o2VDJtZmJEQ3VRc2pCNFhGMGtoOE92RGd5S1Rx?=
 =?utf-8?B?ZmVVNnNCMUFaMHpGQU80U21PREJmS0d2V0VoNjN5WHA5MUl2VnlOVW01MUJQ?=
 =?utf-8?B?cVFFNHpDY2xUTUpoRGtXcGpERUJSKzNNTm5wanlQT2JOZnd4ZW5aZmVyQ2tu?=
 =?utf-8?B?SERONFM2MC9kNG9mcjJMU1J5L2pPbkFDYW5HTktsMXFjaDhZRVhQZTdLdllK?=
 =?utf-8?B?VWhmOWdLY0JVUFYzTFBtWTVkRWYxQ3l0WmlheUpBRnBneTkxcGgxU1R0NjJ1?=
 =?utf-8?B?QU5kTHhBSjBRQmFwelorM3JsWElsd3dNc1JjTU9IUm1pQ2swRG5kanR3RGFK?=
 =?utf-8?B?bm9TOGt0ZEg1d1FSOUpRVFdDVEk5MFVyRjZQdWNkSU5kTkhKR2FKQVgzRlNi?=
 =?utf-8?B?dWk1c1VyNVpwN0dOVjZsNGVqY2xSSlI3MWV4QkFYOTJyeEhqQ3hFdUx0Titq?=
 =?utf-8?B?SC9xYmIrT1VZZ0tuTHlZVnBHcVMyUHVNK0Z6cTFqd09qVExKZEU4Y2lNQmVW?=
 =?utf-8?B?dTJ0Z1VIRERHNURYRGZDNzBqUnQ1OG9pZmxwUyszMnZ5K1N4dzJXUmJSb2Rz?=
 =?utf-8?B?aUppQ3ExNjNrdDdkMUNoK1plUUpsem40SERXVWlLMm5ISzdHVHBsSzBrWDEz?=
 =?utf-8?B?dlVNVW5yZGRraGQ4SUNJdDAzdVBmU0ZaS1hONmIybkx6bzRXYldscXVkdkF4?=
 =?utf-8?B?VW5ERzFMSGw3Z2hWYmR4aGwrc01vcHVpTEExQ3dINU9VZ0tUWEd2enZlZ0hQ?=
 =?utf-8?B?dWRuZDhlZmovcXNXRitoQnJjT1o3UjJZTERFUi80aXV6MVAxdHJMc1BCMU1E?=
 =?utf-8?B?aDlaTklCWGFBWVVDeCtzaisyei9JWXcveDA2R2VpT2EwTjlienFMS1NlL1B0?=
 =?utf-8?B?cFBrcVBydEVQR0hJMFNMd3VqZDRKZ3ZqVmxXNGw4ZURrT3JacE1mR3p1eVA4?=
 =?utf-8?B?V0tYbXZKbnVmQXFXWGNVRUQvVEpDZkJFck84UXQ3WnpzOWFBYXBWR0tseC9a?=
 =?utf-8?B?cm9JNXNpdFkvVmtYVmE1L2xROVlMc3BpU0V4QWR3aGxrQXZYNWlKK1ptSGRi?=
 =?utf-8?B?SWRsek5SVDJTc2ptcmk2SncxdG84Z245R3pCelBEZFpLWnRDQUNlWjBRT2N1?=
 =?utf-8?B?akJSUUVCZjE4YUtzWGpLVXBBRTcyTVY2bzBYSis0dStmSVlidWRVNHhOSDMw?=
 =?utf-8?B?RmppMmwxMUZXRGJoZW0wNUx0VHNDZVZMWVNRSHEyejQrVGcxL1NXa0hWVUdp?=
 =?utf-8?B?bDh6K0dGTTN2eTlRZGoyUFg3TTVtZG5lNWlIR2RKM3I1VmsxNGxpT3BzZ3Jt?=
 =?utf-8?B?dFZqbWc5Nno1blUwd1c1UWwxYWVlbnUxZk8rMGloUzNzNktVQVQxV2hPNml5?=
 =?utf-8?B?TUFiWGZXU1g3YjljVHVBMzZlMjhib1FqVDZrNktLUjh0eldwQ1ZlR1d6SExV?=
 =?utf-8?B?RlJvYlZKSC94K2prY0lJcHN6dm9lOXREa2RIMWQwZVZQbFQycCtaZ3U5djlM?=
 =?utf-8?B?VWlTNzhJYWdldWhudytxalJxak04Wk9MSG1IbWtwUEt3U0l4RjVBZnpJeXdF?=
 =?utf-8?B?cmRrTTFJWWowZTVmR3dvcEdzcnZaVVczdGhOZmM0azNrdXdHbkVTSzQ1Zkto?=
 =?utf-8?B?RTN5UjRicUdJZ211U1B0SXZsSHlycDkyWXkwSXdNZzRBUUJ1Mk4rMGNNT3dH?=
 =?utf-8?B?eDZWZk9GbXVmUksvbXhONzBKd0RWVkVjNXdCWnlSeFJ2Qnc2dmNuNzNqc1JE?=
 =?utf-8?B?a09jZXN6QXhneUdWRHFJVjgwYmoyTFR3dzVnZGxaVXhMTFJyRDhMYktVQUFX?=
 =?utf-8?B?b3AwZFNJdEVvM1dVUXQ1TmJFQlhpbzhHVTVEYllqRmQzcFcvUEVBdzg0QXN6?=
 =?utf-8?B?dHNXVnIwN3ZQc0hTdW96TnVJd0lxSWkzS0pKWVluc1ZrblJpRTFPRHB4bDZ2?=
 =?utf-8?B?bE5wNktJRmFqak9sUktpSVQ1bTJuOU9PWGRFVTRoN0F4Qmk0SDdpRndwT1RT?=
 =?utf-8?B?Z3BIcWJrODhUSUV0bGx0STdOMEtzYXAyVUZpTzdENWZ0V3Z1dytxT3ZRdzJs?=
 =?utf-8?Q?J0LnDtCXys5FMou9VGaF6DOmH?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 71acd83e-870c-4d40-d4f3-08dd8793250e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2025 03:00:20.7893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CkWzMCsQ+ofRB3u4GnQkRVkimVqvtqKdq55XJcKGI43bdCp4qpBjrSXPi3PiUnmNAaYyGCvsROTbq3TWEg5JHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9395
X-OriginatorOrg: intel.com

DQpUb3BpY3MgbWF5IGluY2x1ZGUgYnV0IGFyZSBub3QgbGltaXRlZCB0byB1cHN0cmVhbS9kb3du
c3RyZWFtIHByb2plY3QgDQpwbGFucywgc3RhdHVzIHVwZGF0ZXMsIGFuZCB0ZWNobmljYWwgZGlz
Y3Vzc2lvbnMuIEl0J3MgYW4gb3BlbiBvbmxpbmUgDQptZWV0aW5nIHRoYXQgYW55b25lIGNhbiBq
b2luIGFuZCBhc2sgcXVlc3Rpb25zLg0KDQpUaW1lOg0KV2VkbmVzZGF5LCBBcHIgMzAsIDIwMjUs
IFVUQyA3OjMwIEFNDQpQYXJpcywgRnJhbmNlIENFU1QgOTozMCBBTQ0KQ2hpbmEgQ1NUIDM6MzAg
UE0NCg0KSm9pbiBab29tIE1lZXRpbmcgDQpodHRwczovL2ludGVsLnpvb20udXMvai85MTI5NzI3
OTI2OT9wd2Q9V21kd1MwcERPRFJOTVM5dFFrNTRZMWR2YkZscVVUMDkNCk9yDQpodHRwczovL2lu
dGVsLnpvb20udXMvd2Mvam9pbi85MTI5NzI3OTI2OT93cGs9d2NwazUyYTlmOTZkOTg5ZTdlMjBi
NjI4YzJjMzZlNDhiNjhlDQoNCk1lZXRpbmcgSUQ6IDkxMiA5NzI3IDkyNjkNClBhc3Njb2RlOiAz
Njc1MjgNCg0KDQpSZWdhcmRzDQoNCkhvbmd6aGFuIENoZW4NCg==
