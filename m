Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F282AD00
	for <xenomai@lists.linux.dev>; Wed, 19 Mar 2025 03:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742355649; cv=fail; b=KmFhQY07UF6vF/t+bghOlM6jqp2pw0AcJUBRzZFaFP4fjYJWuKG5KZcjyxIghpyIcM70sVF5nPmZS4Ibeocc85zrnlfqd6VgilBgogMUGQpOQdxmgA7J6fwU9TjEzKFQCx0u/Jch/JR/G84gDP8ULm1AsioJrF+uvGDrljaecFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742355649; c=relaxed/simple;
	bh=UQjVstuu/2o+XcLXS2FZlh5B0DLK+UvSeaPa0rLHaeA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Paer3moTjNRo4eIwL1u2WU7gucOTQN+bvFNlybstL/N+OsVVXI8ojQ/Wov17wsEYs/Wle1aNv7uuJBqDP6JrDfaHSdOpounP9FPevK8eOPsUOlJa7qRLYUehs6rP0UYySqFZrZrcwCeZxwrgbUXCWNFKdONe+/EJ8ueg/JAPXaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=naWkQl72; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="naWkQl72"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742355646; x=1773891646;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=UQjVstuu/2o+XcLXS2FZlh5B0DLK+UvSeaPa0rLHaeA=;
  b=naWkQl72wzeFPGj405Z4NKmv/yWrFow8wqYlHQMrM0pzwPW76zgbseIN
   CSSlDcfu8ywtQzphMQjJsZGEFyG4En7u4Hwi+O4TRUeyc4UwXS6xlyoqx
   vgqiU9U9QYgCCn655OsZFqKmUYo9ibekFvOALksCsOLUAtv5zvzCmA9tO
   Pb0qwTqkZPnvv3Y68KLDA8yO0XzrmV5/zs8n3f/vHwt5xCUP5c8iOywGE
   E+FxZN2PyLMBr+k0KUPVoEwNngg9DAbzgni21wgpX5RjvColgUMP5XVw7
   tC7p1y8cvsWXNrNvkiiALL7pv9T/kVFj9QHSoGXQBYw/Y9kzocYOSY1O2
   Q==;
X-CSE-ConnectionGUID: mzrz9qz0Tji6T3Mcay45aQ==
X-CSE-MsgGUID: 9Y1IpAXfTMyIZCXEfwpu5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="53741169"
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="53741169"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 20:40:44 -0700
X-CSE-ConnectionGUID: 6ggiaTTPRg60FwuQm2meMA==
X-CSE-MsgGUID: EPEYzI82TzK612eMtEASFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="122928568"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Mar 2025 20:40:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 18 Mar 2025 20:40:44 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Mar 2025 20:40:44 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Mar 2025 20:40:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I1Fw2CialPfnkfiTV4qr/D/kZ6jZSOs27UBorQJMRpkigaTvxrNE6px5Tu0VEyRm5Wa/w0SH9U4DlTneX0k/6OOGEMbkBXTGcNShmz5Jar/DKUJTXKnwCgUmHHrtcFtPngk9XxDhle7jqTKfGtxJlNtSUxYTiKIvFFg4rFBHQ5J8OtpuY+EhEPWt9frMossu2RpJvILtQOKIhWZimVb+kwNrrww1blCUjfCnYA7vHuVffdUQt/aATX3VQjABoNHyK38fzW7TegBkGOJTuCmqMt7IIFs5gjQPBJ16qfAHSxb2EvvsnzCzsxU5sCemfSvJvz3ByzyzxNylkQxRf3+HZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQjVstuu/2o+XcLXS2FZlh5B0DLK+UvSeaPa0rLHaeA=;
 b=N6/AY7XHTrmO6CZJu1pka+GINatc9JxXdA7jCA7/B57bqYvU2EWoKsRkRNhBIPf271m6Ngqoa0MKvKLHruG4EHgETjdXKvW8n5jqUO6fnvgD9CsYxGNVRGDZ978Ujw/f5YVWkXLVLAv94HlFQFCNA3B0h8xdYypiTyiIYHWIxU3PAqKrGKEL/iJqcSk2urhfmsJc+te1DRNREzCIIsSSuhuCQS/fzaPsvusMoO6N27qtDX+SRkGj+Ow7doY95GnPU0PmR0p4OG1tYAWuhXTq3X25fxrj6KqUuhnP2yD4P3dzX4s8ilqLuNMUWN0RNlvnfWNcL2yKfBrcE41rDGzIjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by MN2PR11MB4646.namprd11.prod.outlook.com (2603:10b6:208:264::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 03:40:42 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d%7]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 03:40:41 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Xenomai community call on Wednesday,  Mar 19 , 2025, UTC 7:30 AM
Thread-Topic: Xenomai community call on Wednesday,  Mar 19 , 2025, UTC 7:30 AM
Thread-Index: AQHbmICw6KcUry7hMEqxS2BmPqwfDw==
Date: Wed, 19 Mar 2025 03:40:41 +0000
Message-ID: <PH7PR11MB7499D5045E7CD5CC207EADB5F2D92@PH7PR11MB7499.namprd11.prod.outlook.com>
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
In-Reply-To: <PH7PR11MB7499534189182B1B56FDC426F2CB2@PH7PR11MB7499.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|MN2PR11MB4646:EE_
x-ms-office365-filtering-correlation-id: 43af04e5-f47a-40b9-45fc-08dd6697d2c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZStVTWRaSUFMUi9lRzk4S0hGTjU0VGNUcCttWUxRY3lITGNjSVlMQU1CYUZh?=
 =?utf-8?B?OE5qQUlwY3gvOXRVOXRwSXR0c1dvcVZ5WVVzZXBqZG5KNm1acnpjbU9lZkx5?=
 =?utf-8?B?WFdaUDFhOFkzMEJTWlJhbFpac1E3M0RyZm9YYkdCR1UzM0F4eGt4TWFZd1NS?=
 =?utf-8?B?VEU5MFd3RURNUytyVnRtMWtPMVF1bGRiVEptN0dUck16R2o5SjZDOXNyZVgz?=
 =?utf-8?B?UW44aXFHQVhXRWQ1TjBhUXZvaWNLMXVsV1NJMkpicmZkdWd6WmxxcjVNVW1Y?=
 =?utf-8?B?eFc0MGRwa29SeitNWUVCOFp0ZnZqcmNydWpIV3JlYnEzUzNvbmdmRVcxd3dX?=
 =?utf-8?B?cHUvYlBtdWMyeVVDM1pESVJkc1pzbTA1L1R6cnNLU1F0MXlXSUVuYnFteFha?=
 =?utf-8?B?cDVvRHpXL2taS2xIUWZDcWRmVDQwRzZTZXY4ZXltd0lWNjFNa0pZK0cwNGtC?=
 =?utf-8?B?RWRKTWt6TnFoYWQ0TmxmQVo2eENPRmxyTE5HNGRmcTk4NTZiZFZuTVRTYlpw?=
 =?utf-8?B?bUJSdnllRysvTnFYbHl1MFN6N0tzWnA5TFd5TG0zYmxzOGNMN0Z6SzQ1SEc1?=
 =?utf-8?B?TkZ6VFNtME1PUU1qU21DTHhudkI4eWRqemovMWJQZmkvZG5uWjZ0SGVQVHZa?=
 =?utf-8?B?RmQxdzZxQlRTQk4vN0NIQllCbWJ3OXV4bXo1Zk9BdlpOcC93SlB6U0NBM2w3?=
 =?utf-8?B?K0hZM2ZJejRQTVY1ZC9kdUNWOFREZm9pOVZrVlIyOE81a2NqN3JBT3ltUEpP?=
 =?utf-8?B?MnBLamlqOXg3WkxlTGRrb3diMlRxTERpV1dpdit2Rkxmek5ObS9kanEvUncz?=
 =?utf-8?B?K0NGOWM1T3UybHpJajIybVovWWkrQmR0ZitlUDN4OUNkWkVwYkJ2ZmEzcDJL?=
 =?utf-8?B?Ym5vSXRkVFVVS2lhWi9vTFZWSzdhYThnK0p6QW9VMVFYNnBYaWp2OGZDdXFt?=
 =?utf-8?B?blZXekxNREZGdTBHUk5vNGJlTllrNnl2bm5od2Z1eEhCb2UzR3U0VFVsVFZo?=
 =?utf-8?B?MWtxM0JZdmMvcGlXUW8zTmhXTHkzcDJyWnpwS2h6cjNVYzNFZjByZGRhQ1ZK?=
 =?utf-8?B?SnlBRUlIQXNxUnRrNTBIbFpIVEdPczQ4RUlRcE1JTEZNOVRITDhkclJ6TXE2?=
 =?utf-8?B?RDd4d1hPa0htOHV2cmJwbHVTc08vTU8yZSs2MVlKWVRSbllXb3pveEF6Wi9C?=
 =?utf-8?B?VVBwZFNERkxGa2laVk83Wm9qQnAzV09HUHI2YVNjZUpvOHdsc3VxcU9GM1FE?=
 =?utf-8?B?bTBJYjIrY2MrSzFNWFhoRkYwMjNwcVlKUG00Y1piVXNObEpjVHdyUW8wMTV5?=
 =?utf-8?B?VmtKOFRyMjlHRGxOcUdmalcwNDA4LysxZkFxRW8vcHZFNGEvbGQzWGxaQUhk?=
 =?utf-8?B?c1QyMW1pTzhMR3pNdjEySGlBTTQ2cVJkTTMxZmdyZncxTjFhRmJ0TFJFdWZk?=
 =?utf-8?B?R2NzSmQzUkJYZFRUL1ZGa1pRN09mWXFjQkpUaHQ2Q0hlM1JYOG16YzgzbFFu?=
 =?utf-8?B?M0I0ajU2c0tDTk5ucHJ6MmpucEVHejdHcHR2UlZBbzJsNDhFYmMrYnFXa0xj?=
 =?utf-8?B?ZHFGQUVOZjNuNUJyQWpFVnQySS8yMjFmNEFWN2FhS2lzaUphSzY1cXBlYWtM?=
 =?utf-8?B?TTdFakJ6UlJTVHRkdzQwUFd0UklVWTAwZEtaWm85UzhKNStiTmRaemZhblp4?=
 =?utf-8?B?ano4dHQycFR4V2FqaHltVm93Rld5KytkakdtOFVPZVdGL1ZKNTBkUkJKSHlB?=
 =?utf-8?B?bGJkeThPblhDQVdVdXNleHBBaUF5MDRaTXVzSFcyK3RFd2RzOGZ5MDY5SHBv?=
 =?utf-8?B?SldZVTRiQ2pXck9iVzBqY1hZRHEvcXRrTERCeEtzaWdmc1RvZlFEZFd5czds?=
 =?utf-8?B?LzNJYytDS3VxdG0wWkJZMFZBcGFRL0MvcDRscXhkZVJrRkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0FYQmJGVjFsV1Rubmp4ODVYVmljQy9lQlEydTZVeXdQM2YxMFkwYUJUOTY0?=
 =?utf-8?B?TzVYbk9aNG5FSzFYK1FpY1c2ajREeHZiQ3pucE9LTVNEY1VXZUdtUWZycFdX?=
 =?utf-8?B?YnE1R0ZyZnBxQmJhLzhrQml2UncrOHJqS0h3Rm92c01waTlaOFVWMmJSUjNB?=
 =?utf-8?B?bUlxMXZKaGpTTlZLd3JkRzgrNlliRHN6QjQ4QlBEUmpRaEFqWC9ESThJWWF4?=
 =?utf-8?B?ZDFYeE5SVXYzT0xpbWNIQm1KenJYcitwK3Rlem14N0J4UFVqVWxraXdKWitB?=
 =?utf-8?B?bzI5SEJ0Szh6NjMvM0t0ajcxNTlyZTI5My9ZQittbUZpNTJFMHJ2cVp2UW9o?=
 =?utf-8?B?Skc2dTBSQjZpcHB0V1JFQTdnWFkzUEZsZkhvWXQwbWNYalphMEZxRldvMFox?=
 =?utf-8?B?ZVFhSk5mZWh1R1l5LzJrS0VmVVFoa2txeW5ZZ1JuSExwaGVWeHM0R0wxaGNq?=
 =?utf-8?B?U05zdFkvcDZLMEU4YWVKbXVaVGtvYk5lOXVpNmVhT2VPbTRjYit4TVVrNmM5?=
 =?utf-8?B?ays1Vm9EbG9sVzhheTA2RGVXMDhBaTM5dks2NXp2N0liYXBoMWY1b2JYNGpz?=
 =?utf-8?B?R2wvSTlhbzgvZ1E1TE82d3hPKzdlVUlPK0hETUN5K0RNVkNGdlU3RCtrcDR0?=
 =?utf-8?B?cHlPRlNnT0xWdjV4eW0zSU9VdjZmNlpVM1JxUnU3dXkrbS9nREFvaVZKQmxH?=
 =?utf-8?B?QXF0UFJnNC9mYUc3NnRBR2ZtWk1QbWEvM1ovZTVRZklvVlNycGg4MWhRWmpT?=
 =?utf-8?B?M0pxZUVyaTR1TDIySWpzVGowaUxTM2phY2xoMVFCeVk3UWd6OExwREhtZnVQ?=
 =?utf-8?B?TlVVZjQyRmE0NWF2RFBSbndnWHdPSE9wcFlaSVNxeEo1MG41emhGSzF2YTJp?=
 =?utf-8?B?ejM2bXlYb21tUjRhZ01mVWUwc3lnUWl3WUZXNjY5L1dRYTFnL2NKVTRaWkJr?=
 =?utf-8?B?RC9jZ0pMQTBYQ29MQ1g3VlpjMVM2RzRYSnAyREdJbnJuWVFGYTRHUnkyTFdt?=
 =?utf-8?B?aXc0M1Y5L3QzWTRJcW5FaXhXVTdNcUNkQ1NEa01PMUtlN1l5Q1c2OUVDcWpa?=
 =?utf-8?B?RFQzaXQyck53YkxCUUcxcU5OaUpxZ1RvRFpmSENEL1FmWU9TNk5KQjNyV3BM?=
 =?utf-8?B?K0xWYkRPeXhQY04zQmJIV1VsMGNVbGt6akZnaHFNbHllOGE2aWw2Y0ZrMGJ2?=
 =?utf-8?B?a3Z6VHRkMFdHVHRoYUhhZWlNQWVoV2lyajkxUExyTVdnYzlOK2J6UDRLdDdj?=
 =?utf-8?B?R21EeHZRL2xVdzVsdDlEeUt6K1RrZmJZdUJLUUZoL2hyZHVWckdCdGdYY2w2?=
 =?utf-8?B?OXE2NmgzVTl1OWRpQlUrMER5NTNCangreUxYcDcvdXBvZ0d2aWNNbGtLWW1U?=
 =?utf-8?B?YXpFcVg3MWtWVDZWQ3pBTEpJQ0U2SXR1a1IzREFXUTlWbXpRSVo3WVlJdTFL?=
 =?utf-8?B?Z3ROejhjc01WcVE0TWRXMUZIYTVTemMrYVdWZ2Fsdlp2bmIxcVJISER6Smh6?=
 =?utf-8?B?Rk1sZ3c5UFpqMXJXMVpvTnVzR3dyY0NIdU50bFNJd0pPU2lucEo5b2hYeHJZ?=
 =?utf-8?B?NllSaitlU0xQZHVPZURlMWxrdGp0SDFmd1NJdktHT3lIV3FZTm1JVnQ0VFVR?=
 =?utf-8?B?R0tHSXFKQzJLaEIreXFRZG9uSGt3c2hFLzhzb1pEZTg2K2JPWTVheVE2V2k5?=
 =?utf-8?B?bGJQYUpaZFJRQVMvZ085a244VHpnbG5BalFvYmpiOG90MDRtd0ZVeUw4ZEh0?=
 =?utf-8?B?Q2c5VVMrays4a3d6S0xxUHltZi9mU2ZCVm1DeFI5bVpVZTVGOVZRUzFiUmlj?=
 =?utf-8?B?b1lFM29MMzNXaFRENkpDeW03cnUrbERzanZ1VlZFVnRNMFAzRi9HRlhVRWsy?=
 =?utf-8?B?MjhNaVdnQW9BTnl4V0V6TENlejR5bzM4ZGxRa2tTc3lkYnNhRlZBVFQ0c3o0?=
 =?utf-8?B?TWVDTWxkUEZyVHV3VWpMb3FScHlkdHNkejBZM2VVYUVOU1E0RFRGNXBwakwz?=
 =?utf-8?B?Y0prTjVzUWlEUk9xM2pWK005WmpZYTBYZ2hJN1lybDBjTGZjSUgzNEJENjRK?=
 =?utf-8?B?azh5bmhBWVM4QURZdnhQamU5SVZ0M0hIVEJHUmh3c01NOW1TSVNZLy9hMk5U?=
 =?utf-8?Q?CRXsuczMIsaa0R/GlFZwSuehz?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 43af04e5-f47a-40b9-45fc-08dd6697d2c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 03:40:41.8474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6dErtxdgJpKQ0y99t2mZdUW2pEq2Dpo2Ep/3uy123CyZMlwzWVyaCXLUUgulTghGH8/HkQDGSn0hY9CL74uTaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4646
X-OriginatorOrg: intel.com

VG9waWNzIG1heSBpbmNsdWRlIGJ1dCBhcmUgbm90IGxpbWl0ZWQgdG8gdXBzdHJlYW0vZG93bnN0
cmVhbSBwcm9qZWN0IA0KcGxhbnMsIHN0YXR1cyB1cGRhdGVzLCBhbmQgdGVjaG5pY2FsIGRpc2N1
c3Npb25zLiBJdCdzIGFuIG9wZW4gb25saW5lIA0KbWVldGluZyB0aGF0IGFueW9uZSBjYW4gam9p
biBhbmQgYXNrIHF1ZXN0aW9ucy4NCg0KVGltZToNCldlZG5lc2RheSwgTWFyIDE5LCAyMDI1LCBV
VEMgNzozMCBBTQ0KUGFyaXMsIEZyYW5jZSBDRVNUIDg6MzAgQU0NCkNoaW5hIENTVCAzOjMwIFBN
DQoNCkpvaW4gWm9vbSBNZWV0aW5nIA0KaHR0cHM6Ly9pbnRlbC56b29tLnVzL2ovOTEyOTcyNzky
Njk/cHdkPVdtZHdTMHBET0RSTk1TOXRRazU0WTFkdmJGbHFVVDA5DQpPcg0KaHR0cHM6Ly9pbnRl
bC56b29tLnVzL3djL2pvaW4vOTEyOTcyNzkyNjk/d3BrPXdjcGs1MmE5Zjk2ZDk4OWU3ZTIwYjYy
OGMyYzM2ZTQ4YjY4ZQ0KDQpNZWV0aW5nIElEOiA5MTIgOTcyNyA5MjY5DQpQYXNzY29kZTogMzY3
NTI4DQoNCg0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQo=
