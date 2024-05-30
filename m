Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9330DF9F7
	for <xenomai@lists.linux.dev>; Thu, 30 May 2024 01:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717031611; cv=fail; b=TBUUZvvNq4Z9HlQXAZAgfjzRD8/5yDcVKV3GaqM60Osw4rTvU6Yd36nu+mePS6nbBmje9LDFdkdiDt5cDRBzHphRmO/liU3b+ADWUU8X5WhjdF2dgSY2R7H7jsqk2N50sIotMtssxy0jDW7UscVUP/1VvdZRm0R+n6kAIv3tEZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717031611; c=relaxed/simple;
	bh=CcMFNtxZFEiM+kSiYOKSAti2tnIFbZNMgXV/BTw+IrM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Mj2eimxSlMqU8VPTnqBc5DLw3/16AdD3pCjdOqatXAvjTKflmzvRIEFz/cisniHUJ08TQLCeOVmYWoH4i/8hcD2RQMySwYnarIB9y4RhA/9qzUMJTPATaCWX2bgia/V+q2dtLxNhm38NWm+OcaoEhzqTUECKgLXYyNAtjCVkN8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nqPAkeGS; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nqPAkeGS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717031609; x=1748567609;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=CcMFNtxZFEiM+kSiYOKSAti2tnIFbZNMgXV/BTw+IrM=;
  b=nqPAkeGStbnN/GwXvS1HC4W8isghiP8Doy2GBtnp8CGdUrUAqJHo+hNs
   2SFKlF0zqPXB1i+Cu7UC53a1ZEuFmu+rOUxUpB0rK07HEy8dWjwe2n4jz
   Yqz7C2C/VJy4zNJLGryRMCsZ5ce8TToGd3tqIK36ddEbafvpXunyNTuMQ
   tgbyy1nzNkzEgQ4OykmdW5T7oU/HYSzFjvQPeLVQyRgUJNqwyWqhdcjku
   /S+4Y7CuiuaY1cF5eALAolABGdfQinbVyr5g7muzIb3TGd8QO04yEozNl
   uIh2aRiFRCkOH7130H3xDwhyjPVXHOLdMwAFqmJdPhcUoFKrMzLMgEoXR
   A==;
X-CSE-ConnectionGUID: 04+H6avgR9+WKeedED6zCA==
X-CSE-MsgGUID: T/pahjRvTpe2go7c4OMhzA==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="17269425"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="17269425"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 18:13:29 -0700
X-CSE-ConnectionGUID: r6+vXzeNSSG5Il8QWbKrLA==
X-CSE-MsgGUID: k4MssrsuT5uv0/nNZX4pkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="36267808"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 May 2024 18:13:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 18:13:28 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 18:13:28 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 29 May 2024 18:13:28 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 18:13:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHFRPHV27zHZ7xImhbrx3YNqt4SdaZcFvfp9KyM1FNS2xXfKqy/nmPzRH7untWg/zVc/xTOmUVKu4gtjzQslQ6Lt3JOiJSzOJzeloFotF51rwvEgvOGezk7fHnWdXXKrSJoSZrDbQhOuRo6IRYEM6NhC/5+CucycvFIKbfbkQBBitbgOCQ4PfQ53yFUeFsSGhxxX82n/hv5ObEk/m1pWUrtoWRcRzqa0fz+GL+iAKgQXkWPiyH1gsJDjFyTazza7DTmoG1JzVvE128HibKkAQj1FLGku6S9fxkeCDqEeIO+IQYjkHRBTG5ZTH9zTWmubEtR6RU6OBGiSRaQ5SlEEdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcMFNtxZFEiM+kSiYOKSAti2tnIFbZNMgXV/BTw+IrM=;
 b=Wd+VQRvBQgFC+4/sOq5sfbdmpf3ippd0/XytT7YNE1Di5lZu1841DgYVdrP024/CRcdpoF2dFON5QDehW/P5UtdNJi968nBTaIcjFSNfdttjlaKQ758oIpTFwFLJasBfV6ydO7UFRLGJYrB7S/aJQN57Th38Qlp7cjdkGZLK4IPx8+GwWXpiTSfdD6hCLj8oWOoJ7fkzZ8JO0MttagDitnaq6xNWWBm4So8ZbEYFwn8zrDglyu/YlHCWQSW7ADAIP5KmGnOxxIlUVHbaSNXcm2ynSp9hLY0Bo5Y5IMIrL/h86T7/XFeL0YantTder3qwGp9KNQhmol8au7Xto6FD5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by DS0PR11MB8231.namprd11.prod.outlook.com (2603:10b6:8:15c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.27; Thu, 30 May
 2024 01:13:26 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d%7]) with mapi id 15.20.7611.030; Thu, 30 May 2024
 01:13:26 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: RE: Xenomai Community Call Minutes - May 29, 2024
Thread-Topic: Xenomai Community Call Minutes - May 29, 2024
Thread-Index: AQHasi4dG4M7PDFGD0CQUDcGyqiTe7Gu+GXg
Date: Thu, 30 May 2024 01:13:26 +0000
Message-ID: <PH7PR11MB74994E3C748944CD2DD5B6F9F2F32@PH7PR11MB7499.namprd11.prod.outlook.com>
References: <PH7PR11MB7499F7DDE006A3A7291F61FAF27B2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749929DFFDCFE47376883636F2572@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499F4FFFC62E15096DFF8D3F2562@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749910600BAF97BCB41DC3D3F2202@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74999307830ABE8C6E622DB9F2F22@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74999CE443EE8E36CEC314FAF2F32@PH7PR11MB7499.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB74999CE443EE8E36CEC314FAF2F32@PH7PR11MB7499.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|DS0PR11MB8231:EE_
x-ms-office365-filtering-correlation-id: cf005e57-3396-42c4-bd57-08dc8045b563
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?U3BxZ3hRNTVGejdVNnFjazhEZExoMWdXL2Z3QW1UVUsvbXpwQWNNVUpXSUVq?=
 =?utf-8?B?d3BIcHVmT1NTOEltaWp2UjJydUZiWG51cy8zT292WG9uV2dGcG5mUlFiUGdK?=
 =?utf-8?B?bERYekZCNG5ncnNxNURrekozVHRrUGN5bTl5VTdVcFZwVksraXdOS0FzR0ZC?=
 =?utf-8?B?aWY1Tm5hZjhKdWVhSVJuSnMwQlFGZGRPYlY2ZUVETFBIOEpoUjlyS1N3Zjc2?=
 =?utf-8?B?ZVo2RE1ac1dsWmIyWGpiME9IRndCMTlua2xBdG9jRjNteUcwazdhbGpLbzlM?=
 =?utf-8?B?dFkyLzdWQ1lNZ3pDMWpXTmF1TDFDSlhaQ0dQMXhZd3g1Tm11dXh1T1BOc1o1?=
 =?utf-8?B?VEtKdm5tb1hISmxwYS8xb3pJazBIWjVFTU1WamtLdUZMci9SNUEvSDUwMllW?=
 =?utf-8?B?Ujk3bnlwMVptQkdVWkZoZWtFMklGQUNOQnJkNSt2ZjgwL1Z3VFF5WXBsVzcx?=
 =?utf-8?B?bmFhZ3BKSW1CZ29ZUndHQitDeW9PVlVKejZYMkdZYStJYzlKa3RMMUY4TWZB?=
 =?utf-8?B?eW11MXY2bXk4YWZGYWNFYnlHMDJWU1kzWld1WFlEalp0NzdNZ0lhVVJZN3lY?=
 =?utf-8?B?TUpVUktNSExnSFpKWXRCTG14N0pIa05lS0RPSDBTYmtNNFg5RFZCSEI4OWtm?=
 =?utf-8?B?WGVzZ0F5V3pkclVUeFd5MTNlb2hvUGpaN3RYQVJqdjBnQVIvb1lObDdTS25U?=
 =?utf-8?B?Um9ZeUdsWGU5VTM1ZmxzMWt5aTI2RW0vVDY0NzVLemxOZ0tYcUVCUFpQMmVy?=
 =?utf-8?B?aWcydk5leW1ER05FbVo2VEJDcFJPNWR6ZzJHRUtzZTNCZTFnUFhsTDhTUjZK?=
 =?utf-8?B?YmFvM2NZSVVkL0pjbUo1Q1FQNVRITENzeWc3dXlEK1Aydm45alUwMjN4TTha?=
 =?utf-8?B?TnI0TGFmMW9kMVhGNlpaSjVKWjBMNVgyTkpSVmt4UGV1OGRIbENMeHE1YjFO?=
 =?utf-8?B?eTJvVnNVZjBIQTlEZ25qMUN5Tm1DdU9hOC9LcDlDVGpoL1NyMFV6cmgwUklV?=
 =?utf-8?B?cEUyQ3ZGQ3FTSUNwei9iSCs3MXJ5dHpMSkJjSkxHZVdLQ3piUVN5QzdMYmpF?=
 =?utf-8?B?OVJWZWtvMHdFVUN0bHpBWWlHb2VDTTNGZjFBTm9pZkJ3andZdm11dXoyTzVk?=
 =?utf-8?B?bjZ4cndKazF3eFBsYjI3WXFkNFNRR0orRGhleGxvaWdBL0dJcnZVOW0wTEF2?=
 =?utf-8?B?N2pqbUZOSEl3aER0dEFobWxuVzROamNyR3l6MGZGNm1iUENSL2lWK050L1Jp?=
 =?utf-8?B?Y3IxdmxYbVd1Ulg1VHVKelhGd2psdC9LeXlvTXV4b3BuOUdZMmsyTi9oaGhF?=
 =?utf-8?B?eDJOdzJGTWRRNVI2WThMUG5iYkxhZkNYdTJZTGFzallnWWdLb2dMMUorOFpl?=
 =?utf-8?B?cDFMSlVIdFpKUm5WVTEySExKVEZPV0llMDJpeVF3eXRaNWJwYWN2MzdOMW1K?=
 =?utf-8?B?K3BaRjM2dDNaekw5TE5VbGh1UldkenRYZFhCNWJ2eWRoZGFwQWRMeUE3N3Fv?=
 =?utf-8?B?UzNrOEZkSG1RQnI3RmlyT2ozdHZtVWtXb1FqbHlEM040cmFmai9Ld2lvT2VY?=
 =?utf-8?B?VVlFYlBSNURWdjZaZmlBc1d1M3duVXdwQ21hWVRJdzkvQ3NtMUNFclI2L2l3?=
 =?utf-8?B?RXJQbmFUQmFEcUZoQmdFQyt1M25NMm9JaXVDc21PWHc5MUNySXBBRzhORkZT?=
 =?utf-8?B?WURLd0krTmdxRWVzM0Roak1MUkVwNUh1Q2gvMnU1b293b2U4aVBwa1k5bmtU?=
 =?utf-8?B?N0tnakZjbkMrdWlaS2ZRVDkxMHRleURYZDFyWlNGQ1dzUjhOaEZra0tOUWhI?=
 =?utf-8?B?eE9rNndsckovVWQvTEtTZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWF4OW94N09VbThWRlo4d0l5K1o0VTlFMzArZnRERWM5ZEJxOTB3dWx3cDQv?=
 =?utf-8?B?eWw1d3BndEcydCtpMzlKbmhFc2dDSng5RzJIYzQ3Q2RCcmZBOEtORm9SeTF3?=
 =?utf-8?B?OCtOSk93cUlhZmNMNGVXejFZTGZkOW1zTUhBRWl6Tkg1UFlWM0FtbjB4NXlk?=
 =?utf-8?B?WGNZZUViWW44T2UyTzJ5N21ZdXJtakpHN2VJZ09BM0ljL0RldlRMRmJucTJS?=
 =?utf-8?B?Z0pxeUFubVhPU3FqNVFHUGpKeVF3Qmh0TDN6M3FOc2FzWVpRd21jQVVodnhV?=
 =?utf-8?B?UVZRZlNMdFRhNVlsOVBmRmhrSkZvK1kzNWxqM0YwMFVjZnBFRTI5K0VkMDRU?=
 =?utf-8?B?TTlzK1JDd0tRSzhQQkZ2dkZFRFhqOEV1QXpJQUkvbFZmVSsyd2lDWXhxb2d1?=
 =?utf-8?B?ZXZGTHFVU2EwRDRFSEVzT1RlR2ZRdmV6QTg2YXhUeHNpdlhpdDUxK0M1NTYw?=
 =?utf-8?B?enpOWUNFQ3R0aHFFanJWaFdLZVBRUHZsMXZVQ3p1M21zQjBzZkVWRGtNNVZJ?=
 =?utf-8?B?V3ErekFBSXZlTlI1SWFvNFJsOCtpclVVR0xoLy9hYU45SVRaeWlhT3F4dmt1?=
 =?utf-8?B?SW96NmtYVHc0MjNWTWhRMGlCU3RIYXRpMUhQRmRTTVY0TkhLcEVMa00ydS9U?=
 =?utf-8?B?SnlIWlJzcWJDY0dMNkQrdmNtZmFoLytlNDJVNHBNV1BqNFpQdVAvQjNhNmNw?=
 =?utf-8?B?M2ltN2tZUmZMdEh3TnFNd1BmQTZEY1cxSVJOVUZmYk9OWmRiOXRINXB4SzZ1?=
 =?utf-8?B?c0JuR0R6OGExZktJQ256WG9zWmNGOHZJcldDMTB1V3RhZnNmMjZpU0ZRSThn?=
 =?utf-8?B?K2s2L0o3KzZLNmMvTDZkbWRHa3Q4Nzc4ajYvZndJNUhZYmZkbHVwSUZHZGd1?=
 =?utf-8?B?OTdGRTh6cVE4ejhSaDdxZnhWYTk0dW5UaGZ6UXVHWkd5UENRMTJORERDRnRx?=
 =?utf-8?B?Rnp3Q2pSM0Z2MXp3ZDh6MWZVRTA1THRNYVE3ZVl3aUpRMHVTTXlhVEJIWEhp?=
 =?utf-8?B?WjV3RjBsS2xDd0hxSTZWT28xUUVubjYydEZ4OVFUR3R3d1NZRVhSMThadE8y?=
 =?utf-8?B?blA2bldhN3pNMEQvdTl5dXVPVzJVTklVK3ZvRzFMT2FyQlFrc1lhNExyZWdx?=
 =?utf-8?B?eE1lTVFYNjUrRTV1MGRjMVBZd2VENmZPdHJFODZHQ1JpVUZCQk52anNsUnI3?=
 =?utf-8?B?MmRTTW5ITGpEL3pFNEpzZEJzTXlIYWQ2c3BZbWV3MlVmNnkxbnlYeDd6b2VR?=
 =?utf-8?B?V0I2ZFg5a2lPdHZtZ29PSDBsTVUxTldpL0Z6aXFMR1VrdVB2OUZhbXc3dTBW?=
 =?utf-8?B?aFQrY2xUZWFNb0JSVkVYL1VVU3RsOWhoU1VkMy8rTVdKMjhjWnAzMzF4azBM?=
 =?utf-8?B?ZUh6andLL1FwcXFXTzlVcklFZ25ETXl0UDBpZUFBb1pWb0J5WWVmWkFoYTRU?=
 =?utf-8?B?b3FYZEdGd2FOVjFiYyttVHBmSFZFSFU1dUtGTlRLZnkwajJvMkxVZmxaVzNs?=
 =?utf-8?B?RjdkRytFOWZrbEd3Z2N6UXFHSFFKOTVpNHVrMFJHdUVpaVBQVFRkeTAva3Zx?=
 =?utf-8?B?eU5lN3NZeHJsNVlRMTMwZ0ZocHZxUEhBclBMUHBZWlU5ekZXeCtNNk91RlBD?=
 =?utf-8?B?amthUmx2VVJUWUlXajdxaTZ5YkVuQTRld0RkWTFmOFFUS2U4ZTVycm5jU29V?=
 =?utf-8?B?REdpMWFwUWx1OEVDdmc1YlR6REVLQ2ZFNGhIcklNaUFjRTQ3a21yZXdYbHhG?=
 =?utf-8?B?Zzl2ZlVOV0luYk9KTXYySUx3QXZjVmVYcW5Xc2k2MXY2OEhXa0NNQVRhU2Q3?=
 =?utf-8?B?Z2pUbGRja1dNNkgzWDVqZjlHdS8weHlsMVRkWjFGdXNlbm9kT3h3eU9KRit5?=
 =?utf-8?B?VWlhc1c5RHdHTWdpSExCZzRMWWs3UnNQUk5IZzlEWnU5ZHdKWlJueVRGcUdw?=
 =?utf-8?B?eWlHdUJDcWdmUytiV1hPMFJZY05LSXdBUU1jZUV1RWlzNjYwN3NTN0dCOHlm?=
 =?utf-8?B?MllPSDdheWlzd2tXUS9WRzZTT2s1a0N0VTd0VmdEMVRqb1pMKyttVGhoaXpv?=
 =?utf-8?B?SDh4alZrL24wZ0I4enY4OWprWkJkVTgzazJhRUFCZEFwVUJlMk12TXYyeG16?=
 =?utf-8?Q?fxohVw7Oiu5YoSiNDD7FQm02r?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cf005e57-3396-42c4-bd57-08dc8045b563
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 01:13:26.3972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: desLBYKUG9lhzv6YMouCduZV7EJELPfkpqExq38ogwYx5HScIf9dmFLTcIF9xiUzMk6YFXZq2Br8y8B+U4gR+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8231
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENoZW4sIEhvbmd6aGFuIDxo
b25nemhhbi5jaGVuQGludGVsLmNvbT4NCj5TZW50OiBUaHVyc2RheSwgTWF5IDMwLCAyMDI0IDk6
MTAgQU0NCj5UbzogeGVub21haUBsaXN0cy5saW51eC5kZXYNCj5TdWJqZWN0OiBYZW5vbWFpIENv
bW11bml0eSBDYWxsIE1pbnV0ZXMgLSBNYXkgMjksIDIwMjQNCj4NCj5BdHRlbmRlZXM6IEphbiBL
aXN6a2EsIEZsb3JpYW4gQmV6ZGVrYSwgUmljaGFyZCBXZWluYmVyZ2VyDQo+CQlEYXZpZCBPYmVy
aG9sbGVuemVyLCBKaWFud2VpIFNvbmcsIExvcmVueiBLb2ZsZXINCj4JCSBUb2JpYXMgU2NoYWZm
bmVyLCBIYW8gTGksIFpoZW55dSBMaXUsIEhvbmd6aGFuIENoZW4NCg0KU29ycnkgLCBNaXNzZWQg
TGlhbmZlbmcgTGkNCg0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQo+DQo+Q29tbXVuaXR5IHVw
ZGF0ZToNCj4JCUNJIHN5c3RlbSBpc3N1ZSAtIGZpeGVkDQo+CQlOZXcgWGVub21haSB2ZXJzaW9u
IHdpbGwgYmUgcmVsZWFzZWQgc29vbg0KPgkJR2VuZXJhbCBjb21tdW5pdHkgc3VwcG9ydCAtIG9u
Z29pbmcNCj4NCj5PcGVuIGRpc2N1c3Npb246DQo+CQlDSSB0ZXN0YmVkDQo+CQlDYW5idXMgcmVs
YXRlZA0KPgkJWGVub21haSBtZWV0dXANCj4JCU5leHQgbWVldGluZyBob2xkIGFzIHVzdWFsDQo+
DQo+DQo+UmVnYXJkcw0KPg0KPkhvbmd6aGFuIENoZW4NCg==
