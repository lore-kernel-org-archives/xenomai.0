Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581061CF289
	for <xenomai@lists.linux.dev>; Wed, 30 Oct 2024 05:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730266450; cv=fail; b=cerVjpBGnx3tLSkMtNcXVQrnARUUiQTUUuXRwkc8PuCw0EjdiIvVZToslnLHL4tIS7ZOOsnczlvFsqVEP8xp/yTMKWDp5gYAaphikauDw4239zbXZtHxU4o77fpaD0aGHgIRa7CiaC9J6jf12CADFfQCozqHBdfREa2MyfGDRFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730266450; c=relaxed/simple;
	bh=kuINQpU9feDRdYs/ZljXQojPEDmPqtw7SwZ1dvFQBPY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uQj25LEU1Nei0YsawJ+SANI7ln8MpR7Hn5l48RIv3synDtp+uHwLlzL9xx2rt8BdRideXbDbypmaodtdOcY+6pGAwbJSrffcV3aQ6/HZbf6yWLQpVoHi5BRQgBr+ZqIJvLzNr/6khPCebVg/rDhqKR6LUWdF3VpbcK2doY0KA+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Suo02+Ko; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Suo02+Ko"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730266449; x=1761802449;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=kuINQpU9feDRdYs/ZljXQojPEDmPqtw7SwZ1dvFQBPY=;
  b=Suo02+Ko6ymxwmIoPGjc/fi0JmaNVADGCJ73TyHi8Z2lolCLxxPRW2tn
   xwYKKbsCORlZHVKBKIniacpfbVga3Z4BhvKytaNufdbHBT/FlMbmVg3/r
   5zDBjMgPysgzkNj+aHhVWE5QF8Zz5YaJw5I9e/VC047EZKG732C9h4x9Q
   SXC7RerHgY/41dFIQsSFNIMi2yiXv4sE5LmlfPIPGa9fSQ5OvIvdQqil1
   YHvzi3TsgW8tPeT/mdxr9K8LfZwNoRnb95AHUWkyyLIAibvLV9Sp/RHCD
   5BqyQrfJjRFt0pks3epKKEzg5D0Olc/wza49RV1k10zxYP8zXyKLsuY+u
   g==;
X-CSE-ConnectionGUID: /a2N/reeSomVtedSqWgbXg==
X-CSE-MsgGUID: nWt0atI3Tm2svv+CzPnlnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="33748341"
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="33748341"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 22:34:08 -0700
X-CSE-ConnectionGUID: 4HLDls9wQcezvPguwizY9g==
X-CSE-MsgGUID: pNyOiUxHT++bzwXNklhxuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="82283364"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Oct 2024 22:34:07 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 22:34:07 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 29 Oct 2024 22:34:07 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 22:34:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UDrrVyNHTA0tQ77CXftGhZjHrOUa8vCmoimJtlCf79b++75l+tHP6XylXCwmuH9jmsCPchkmOXlqTehyhx2C5fOgtAm+FheUX+IyvmQzaT2/gOS/360m9l0VdIaw89KXz8H9LHl6saeSCOcrPbn1vevMKgtbziAgyOoNfiTSL1i5wQC5S8jM3Oh/g4RSYA1W5Re8BDt9oC5TFnxICe7KWqt/B+msYNVKuZwuOn/EGS0zlpfBYAdXf69ra47Zv7NJre3rhMXDmX1qL/caS8apqHo+iTQO4jpcGwYbBV7InyPgaJcrODnh9XKS9oT9FhGJyV5ypBgDpABH76u7HUz2Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kuINQpU9feDRdYs/ZljXQojPEDmPqtw7SwZ1dvFQBPY=;
 b=V1lA04gNBUtcbUgNWLtU3WagFucVc0JrQOUTjaUhtlYeIYvJI+YFpioRv8qCkMnmHVOrytenMoyLBkNsw5v8bOjbBvFoHl9CUMoW1p5LhkcP/RPEn+0Psn15pEHO7jL2YQGOd896TqLjy/UxvXgc2PWMjX+MTNigxoO07X1LQPzeZpoEGM4qB93hvYHz20JMq9geWSMqf2MKtd8bUVnSbqWmxI2a7oRE5s4N44ZdWHBKf+iPCXqHEoWwjHvnsTCckjtfWOogoRl2snDwOiWrK1rXfRb81qlwnZnZfS+niEFJ4SOaUrio+6dmEjeVlpGzFn1gNHLWwwrWgR4IPiso5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by PH7PR11MB8251.namprd11.prod.outlook.com (2603:10b6:510:1a9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Wed, 30 Oct
 2024 05:34:00 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d%4]) with mapi id 15.20.8093.025; Wed, 30 Oct 2024
 05:34:00 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Xenomai community call on Wednesday,  Oct 30, 2024, UTC 7:00 AM
Thread-Topic: Xenomai community call on Wednesday,  Oct 30, 2024, UTC 7:00 AM
Thread-Index: AQHbKo1Sad8ynYCkfEWWpaQHrWNkAA==
Date: Wed, 30 Oct 2024 05:34:00 +0000
Message-ID: <PH7PR11MB74993258CAA8CDDA598B287DF2542@PH7PR11MB7499.namprd11.prod.outlook.com>
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
In-Reply-To: <PH7PR11MB7499E15D2AD5555818A6E5C4F2462@PH7PR11MB7499.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|PH7PR11MB8251:EE_
x-ms-office365-filtering-correlation-id: 27418019-b640-44d6-7008-08dcf8a47532
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UVBCcjBrT0VLMUVqU29xTEprT0MrVTRrRFA3ZGN3YXFVM0RUNyt2MzQwWUxx?=
 =?utf-8?B?ZWZDdU82U3Q4VUE0MDRKK1pXbDlLZVFIMVpmTkZhNTVPU1ZJTU1QbHFUQ25x?=
 =?utf-8?B?c0J4NzZvV25PSk5FT3FwY0xIZzdZa2VsOFVrcWhZRTBEcmFFeHpuY2Fxdnl0?=
 =?utf-8?B?QnRvaUJjRmZTTUg5N3BlT0JTelF6Q2tzTmhySmR3TElBczF0Y3dsWW8zazhW?=
 =?utf-8?B?R1ZrYXVBM2paZnV6aysxTWdpNUE0MFNrc1FLdmxoakw2c3hMaHdCWWhWOVpj?=
 =?utf-8?B?RmF1VlVUZmQyTG1HeVpXNmZEM01IR2FHL29aVXhJQXlkU1hYVGJ6NVhxc1Zq?=
 =?utf-8?B?clBjWjBDNXRPajZnQ2hqTEJtOW9UYmtPSTdHa0xiTTQ3ZTdFS2RRQlE4TG85?=
 =?utf-8?B?Z0E4SkVnNkdDUG1rM1NYVTlBWWszZTZ5c3BhbkwxTWZLSGszeW1IaXRaTzRp?=
 =?utf-8?B?UXBMa0lScUJRRTBmZlQrNGNXVjZZTlRHQlZtTXkvQkZ6RkYyV3hqdG9keWkr?=
 =?utf-8?B?RVdPd1YvaG9xSEo0OWh2bVpSOG9ObDIzZ2twNlhGNzhCS0FQUlJmSWR5dzRJ?=
 =?utf-8?B?NzRVSHdNaUhlb1dlWkRzY3h1clJ2dnF5T0dFM3NveXZEWm5KVVlJbHo5c1Yv?=
 =?utf-8?B?a2k5YVFQQ1R1N2hTZTB3QzE3UVdYdHl4Y3hRTGtTVG1LRDc4WkVBRFVXNTRx?=
 =?utf-8?B?ZmRxR2haYjY0VXFiRWJPZVBvd2xVV0tqYkZ5NjA1QVpRNCtYTjl6eVU4dGRG?=
 =?utf-8?B?OGhHajBnSmZDekMyUG1hVmJxUHZkVTRBNkJLSXpCbnJWMFFqcENkMzhxYSsw?=
 =?utf-8?B?eVdzdnludVRjcG9wRjRaZDBZcGRGemR5cUdXWHhkMXNteHAzcUJlUzJJMVdq?=
 =?utf-8?B?L3BLUkNtVXVzMlZwbkpjcXd6M3JlTnVnYUtOZ0JLUlIyendKWW5lck5ZclNT?=
 =?utf-8?B?bkRPd0w4dExVaGRtRWpoVkU5WFVSdHNidzlLMC9uM3N4STBYVEJMSXE4MHh5?=
 =?utf-8?B?Q3JjS1F6WVdVMFdCY1RGdVBwK05zNWNyeDU5STVrMy9ET2Rvd2RwdUs3Y3M4?=
 =?utf-8?B?K0xGeElOT3lWeGQ5SjUwcHoybGFVWFpFcFRneG9xelIyWmNreDEvS0hqeDdD?=
 =?utf-8?B?eWVXeDU3ZVcwaExNOVBOL0drNzZNNm9zZFZDTlE5eWRKeDJRdmVkcFgvYkhS?=
 =?utf-8?B?Ty9uNnNBeWVYMDNWQU9UOG5YckhHaEJ2Ty9QNURNUDBFWWdkSGtHeGZ0WHZ0?=
 =?utf-8?B?QVdpTDJwT2tQV05mSEZadHNKV3hta0pNRnEvTGdLcXBiaXJsemxydVY2YkRr?=
 =?utf-8?B?TTRVYXNEcFRqeVBremN2L1FnTHlVK3lHMlQxUnJHVmluTzBud1ZoVTIwN0sr?=
 =?utf-8?B?aHNkYWZJa21iU3lDM3N2VlhTeUNia1pCaWV0SXp1NUlZVytSc1N5VGswSDlW?=
 =?utf-8?B?UUk0K0tRNVNEdFdaMVlHL3RRYURQeVAvSXBGM0lCYy8xbFluQS90c01ZMFJ3?=
 =?utf-8?B?OEpBN0Y4aEFlUGhiZHFIeXBxWVcrSEFDalpOUGZOb1U0cW9JbS9XTTArWldh?=
 =?utf-8?B?N01XakJYLzgyUWFpZ0xucklpUzNoMnNSOFBUOXU3RzE5MUNhbkVsenZ1Y25x?=
 =?utf-8?B?a0RCV212Zjl3eSt6QThEdi90cGV2Z29hWWI2c3Bxbm5ybEpEM0c5TDRodFVz?=
 =?utf-8?B?cThXeU9MdlEzRE01TmJYVkxSQXgyaWptdStzMm1DR0wvaURPcUpkMDFiVVIy?=
 =?utf-8?Q?/MuPiLXUEMI+vKw4sY/+EKanZ73rOSGzlY8BXGX?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUJnaUxibHJieUtxWVUxS3dDYUZWeG1wRkY5S2c2dm1OakFEaDZkUWV5emhG?=
 =?utf-8?B?UHFKZVY3NEhONkNMajV4WC9XSWQ2RTdSUWV6ZkFXcHlzSHdiRFVORWhoUVpn?=
 =?utf-8?B?VmF5bTh2WGZYTkI0WllXK0JsUk9TdkU5ZGlnSmFxK01RVENHazlJSE1URW11?=
 =?utf-8?B?OUlOaVlFNmRRcFBGTFR5dUVjU0pZdjJxdGRXRGx3T2hNbUl5RkRNMmdzWlpO?=
 =?utf-8?B?RnNKVjdYcmpsWjhXdUJyRUhHOFhpVDFMeWlXSkltd3QvdnNDa0tvVGMvRTN2?=
 =?utf-8?B?WXFCQUJxSUh1OUpDWG5Vc2JqVktmTm9xTmYvZWFRQlhkb3g5Qysxd2Nva2xj?=
 =?utf-8?B?QU1tZXVZM2RpNUMvWXZmaDAzbHZteDhOVnMzMWhNaVR3Um43M3VuYjRnbGV1?=
 =?utf-8?B?Q1dkUVJlLy8ySVRHWjhwM0Ztdjk0OGdobEk1dVdxbjB2bGhFMHNHTzkvQjBh?=
 =?utf-8?B?NWlTUHRLbnY2R1hSbWdwVEYwa1F3Wm9lejd6YnZFd0ZRbGEzMTh4T2pOZXBi?=
 =?utf-8?B?TTVhWlFmdExwcFg3bXdVMkVKNVVzZU9wMlNpbWwvSGI5c1dJemd0dm9BdENu?=
 =?utf-8?B?QWhzY00wd0JrQUVtN1dTdHFGc2hUY21uQjhvbmxsNkdnZlBJcXl4ZmlWeGNt?=
 =?utf-8?B?U2VTSnBVNnR1bVFsUkdaYzZaSE9pbmpldjZHM0lVeFBDM2w0RWJGbGwrTjBu?=
 =?utf-8?B?Y2xDS2pTSXUxNzFIaEk2RHBDSFJOQStLb1E2TGE2d1VPeVREMTl3WlZjbGJs?=
 =?utf-8?B?WmpUcCtYTkI3bzlSUkMxOTVrajUyQSs5cXBlbjBkQnlkZnJ1WDVQRG80b3Rz?=
 =?utf-8?B?RDJRa2Q0OFhrcTJyVTl3VUJkWXkzVjU3NGFSZjhWU0s3NWhoL0dWT3JoazVF?=
 =?utf-8?B?VjRnMm9hNWpSNUo0ZnhDV2hWZFUwY0U0a29zMFM4dWJINUNFeWpYbzRQc1RJ?=
 =?utf-8?B?dHhQaW9CM1ZRNlE4R3BnQW9QY204ZzZSMDVMZHpFeUNrUmsxSG51Z0dubTE4?=
 =?utf-8?B?eEpHOGtLRVp4MkNiL1JqTnNiZ1NtOVlIV2RwR0FzSUFLMi9vS0ljR0JXei92?=
 =?utf-8?B?TnVuaXJwUEFyTDlOUm90YnBRQ1RGU0VFczRYNnh3WkFLVzZ2dkMrVExDT2Vu?=
 =?utf-8?B?T2pkYmdjRHo2cVdzeFBqMzRFVk4reXVLUTBId3lOeWtoNDhjcDEvSjVrK1Rj?=
 =?utf-8?B?ck16YUNYQVAyVmNJa1FKMDRXcjZJZEU3d2RKcFJYdDZWd3p0cnVhNXJ0bzla?=
 =?utf-8?B?WFp1eGpMVCtqdkxMRmQ2QUR1Qi9jamk0QTNoZ21sWklxcjZIVytFbS8zbS9H?=
 =?utf-8?B?dm9GSEk1b21uODlwZ1g1cEcvbzJEb1ZraDJVZytjVEFqemdTT1ZrMGpybjhl?=
 =?utf-8?B?cHBuVzkzbUtLK2lReFlVZmFPUFhkb1ZiLytCWU9LanhyOHF6T1lkVE4rVG9a?=
 =?utf-8?B?STRxWWZqcHAvMTJLQllET2hZbW5PcDJJUjZHZkFTOUxnSnU4ZHppbnJwenRK?=
 =?utf-8?B?QmdvOEdOcEJSSmhTeVp6VnhiYStsZ0d1SkhXY3BrK3NFM1dRSDdTSGpENkNl?=
 =?utf-8?B?Nm54WWwvb2pFSy94bXZtcnhsVnNMWkY5ajhVV09QalZncksvNTZpcHBxdVYw?=
 =?utf-8?B?Nk9WMGFpdnAra2lkOGFNZDhCRHB0c3I5Z3lPaksrRUc0ZjJFcXJXMTVOZWpU?=
 =?utf-8?B?R2l5QTRwbEJxbUxWY01QSHFVc05sbm1TNzN6K3E4dlBOcWtNWVY4THBMMkhs?=
 =?utf-8?B?c0dNcU1QUzFCY1lmVTJJTllvOXpLV1M2Y3hVL0NHSWY5RGJzSktxOU9xckRS?=
 =?utf-8?B?cUc0MVZMUkNJMXE1Y245bDdSTWFubyt0NFBUci94OTZKaXVpR3JoT0FCbDRj?=
 =?utf-8?B?UnlJZWpNZ2x3S3I4SUowVHZaTEpnMWhHN25rQkF4Q0orK0NDOU5KbDBWcFZ4?=
 =?utf-8?B?Z1F2RnJaUFB0dzN2cm0zU0k0R2hReURHTE5VWVhzVzhDTW9lT0RIb0t4UWV5?=
 =?utf-8?B?b1dKcFB5eENZTXlRME50by9TV043UDFybVFzMkRqbEVHTjNRVzUya1luOUZD?=
 =?utf-8?B?SjhFWEpZMTNDWTlldHBaSEZwWi9NcXNsVUxRS1FnTm9TTWxyVzRscTBMNjJG?=
 =?utf-8?Q?GU4EJAXNFqkoFoyllohlmJf+7?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 27418019-b640-44d6-7008-08dcf8a47532
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 05:34:00.3697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sihZhxA5SPGdzDZ/GoE6D4EwhYZwlboBdW6fzw9BYY7mzd2QDJAlc0vxJP8uZ62KzwGYdlhss7Fo9yv08hZI1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8251
X-OriginatorOrg: intel.com

DQpUb3BpY3MgbWF5IGluY2x1ZGUgYnV0IGFyZSBub3QgbGltaXRlZCB0byB1cHN0cmVhbS9kb3du
c3RyZWFtIHByb2plY3QgDQpwbGFucywgc3RhdHVzIHVwZGF0ZXMsIGFuZCB0ZWNobmljYWwgZGlz
Y3Vzc2lvbnMuIEl0J3MgYW4gb3BlbiBvbmxpbmUgDQptZWV0aW5nIHRoYXQgYW55b25lIGNhbiBq
b2luIGFuZCBhc2sgcXVlc3Rpb25zLg0KDQpUaW1lOg0KV2VkbmVzZGF5LCBPY3QgMzAsIDIwMjQs
IFVUQyA3OjAwIEFNDQpQYXJpcywgRnJhbmNlIENFU1QgODowMCBBTQ0KQ2hpbmEgQ1NUIDM6MDAg
UE0NCg0KSm9pbiBab29tIE1lZXRpbmcgDQpodHRwczovL2ludGVsLnpvb20udXMvai85MTI5NzI3
OTI2OT9wd2Q9V21kd1MwcERPRFJOTVM5dFFrNTRZMWR2YkZscVVUMDkNCk9yDQpodHRwczovL2lu
dGVsLnpvb20udXMvd2Mvam9pbi85MTI5NzI3OTI2OT93cGs9d2NwazUyYTlmOTZkOTg5ZTdlMjBi
NjI4YzJjMzZlNDhiNjhlDQoNCk1lZXRpbmcgSUQ6IDkxMiA5NzI3IDkyNjkNClBhc3Njb2RlOiAz
Njc1MjgNCg0KDQpSZWdhcmRzDQoNCkhvbmd6aGFuIENoZW4NCg==
