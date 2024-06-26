Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EA714286
	for <xenomai@lists.linux.dev>; Wed, 26 Jun 2024 02:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719370120; cv=fail; b=qyU/upl2hkWwaGMFTJ0h5cSfRyA4YYGHhw/wk9glZcId5mHd+0Y86pVCl4XsnK4Bod4QNKrLOFn3ZzTBwuj+g/+hK1XrdgfJ+YieHdSpBi4taBrrdN60hByu2BWiOEwczlBT5X936l4cDJod8yXtz74vfShyqujtHS0rbTFRAyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719370120; c=relaxed/simple;
	bh=yWZZ1gSCugCkhCdTp7wr5s4h3Iv300NFxbHrJtdz0pg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f0BTFA5O42J7+k8IKsG4lEw9e+VrjzMmv8w866ixB8EhA4G+z4iMpWhxaTsoqZu5a/V55iiDqoI6DE1NGcEXGK/jxgImOCQVxalXg9jcGpNG3dKiJD86o47b1pXcLe8G2IZeDgOSkxXwckgpzAU+RdCmE9IevRidVnpXYlpA6pU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IMMOI6xa; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IMMOI6xa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719370118; x=1750906118;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=yWZZ1gSCugCkhCdTp7wr5s4h3Iv300NFxbHrJtdz0pg=;
  b=IMMOI6xa9Lq7pdCsx+n09zgFATFapxyytlqwoPeR0+uxljyAsfF5jLk/
   2sP//xQEs9MeD+SFTBTtxPH3B0enlhERy3/6DxN5jaHvbyjYMUzTRJlDH
   uPwulidMDWt2Y+HPTsQtPX7fhz+PpFLei9AHr0UJMxj4YGVH3UHT7sNN3
   iFadQhs50LPR5VvlsTU+9BVbgqknK5SBDqEkWSiWi6avkIvhtUeF1zGuE
   esyd6Ko6/r6C3SKSBMSfWoe+GZvq9lqgmDJB+p6VCOYcWtntP6oOMTxLr
   Zp5sAF2k2+TxmRHJZ9aKRtdZqsq2i6teOnm6MKozD8zsfpjBX/i+Doca7
   Q==;
X-CSE-ConnectionGUID: mCWVR0QvQDqQAr8n4uWL7A==
X-CSE-MsgGUID: qwSmZx1tS36rw9RfTpIDCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="27824709"
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="27824709"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 19:48:37 -0700
X-CSE-ConnectionGUID: Zft7of23QLaeAK4fmbPyxg==
X-CSE-MsgGUID: zxltHDFVSYq9P5P1evdlJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="48828707"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jun 2024 19:48:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 19:48:36 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 25 Jun 2024 19:48:36 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 25 Jun 2024 19:48:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ef1j+J2nJPwWs2KjBvBN8xSGTvBcG7Lq0qxX5wYl8I83M9vjg0AF2q2/Pfpf1gvR6Rlhw0Egu5nOkNsoMaLvvnKd3HvHSztsTwn7Pr23zYZZFXP8KaJGOHmiI5M/vsoZ5wA8Gk1QNvi95l8OEOgknbVoEvHZudhVrfUMtb/6Z/kqGwN1AZQI3TZLpbdaNkyB38WUQalH9WCCyDdhGvHjv30NCFPHRxTopb+6d43UKY3PssIT4eBPigLPp6K4cCAH6XnN2U9duJt6ZI/oY3huw0Bt3xNwTd2XXAJuRBkV0a7XBZ549tm5SQRMz3LNda/2A2hYMUiS7nQ/4BJAE69RJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWZZ1gSCugCkhCdTp7wr5s4h3Iv300NFxbHrJtdz0pg=;
 b=cakvRRkxXBqNbk8H9PQcBONFN+OTYeHXWrPMqXpxb4LsmQYYERoTs6eCzQ38BseStDIMhALnQwSyGbirPTZ9/XCRhGOgCZHu+qjTwW3pFBM8qtLuG7zAZRn3hSqU67vLnN0NIJolll4GJmAUXWuYTKNbjdJ49YfpV40gVm5zkaYOl4EutEDdCxqp9NnWom/N91gwgJOAd8AL/ozTH6DDP3eqDxWlw5pkij3UKQ3UugR6QdRY72vLfOkjdpVcunek3H1dUtosIIOeSfhevGcGrQyyQJ6KYVE3XZs65v3l9buBl5BdUlCrp2uwz3qX2cjBkfnAd38T5F7Eoudg3FgDGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by IA1PR11MB6122.namprd11.prod.outlook.com (2603:10b6:208:3ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Wed, 26 Jun
 2024 02:48:29 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d%7]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 02:48:29 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday,  Jun 26, 2024, UTC
 7:00 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday,  Jun 26, 2024,
 UTC 7:00 AM
Thread-Index: AQHax3NTUZxvxu7Ff0usCZzgRK80RQ==
Date: Wed, 26 Jun 2024 02:48:29 +0000
Message-ID: <PH7PR11MB7499D816A0B79C85EF7CD712F2D62@PH7PR11MB7499.namprd11.prod.outlook.com>
References: <PH7PR11MB7499F7DDE006A3A7291F61FAF27B2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749929DFFDCFE47376883636F2572@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749988D3E2C96C4F21DAEBE4F2212@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499C4BB71E159B3AB98D686F2332@PH7PR11MB7499.namprd11.prod.outlook.com>
 <DS0PR11MB7482613E8A9D78229EA71D07F2EC2@DS0PR11MB7482.namprd11.prod.outlook.com>
 <PH7PR11MB74993A52AA247D08069980E4F2F22@PH7PR11MB7499.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB74993A52AA247D08069980E4F2F22@PH7PR11MB7499.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|IA1PR11MB6122:EE_
x-ms-office365-filtering-correlation-id: 50fb88ca-0a6c-4554-4218-08dc958a75a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230038|1800799022|366014|376012|38070700016;
x-microsoft-antispam-message-info: =?utf-8?B?UUoyeGI4OTVjTVRMUGNYVWxxbkViZnZHN1JPTmM0bG0zdXc1TGowNTRxSGdT?=
 =?utf-8?B?bkg5ZVVQWnRGWFhSd214RHNKUXh1U1ZvVHJxUm53eHVxeTE4ejVSNW0xYjNl?=
 =?utf-8?B?YUc0Rmd1M1dLcTl4eGoxc3B4Q3dnSUJ5ZFFpaFB3b0R6Y0NaOW5CMkVWZFV4?=
 =?utf-8?B?emRBS0dIZEZoM2Z3MXFDZlpsR0txSkZ5cDE2SElGWm1YUjB3WmY4TEdzYlpl?=
 =?utf-8?B?bGtUMlNJK1VlUTVKWDQxK1FiVjB6YThVc0IxemNpS3BBUmZEbnBCMFNSZ1lN?=
 =?utf-8?B?YmR6M1hoUkkwOUoxUGJZVkNOSW1KOHFlNEpmMk5TNkpHVGdQWFc3UUJkbWZK?=
 =?utf-8?B?UTFKUkxMNnVJaFcwUDNvVTZicjlQdHhhTUVUaXVvVzZqbDd1MGtuekV0N3VD?=
 =?utf-8?B?c2UyTXQzbFBYaXViU2MzVXhYdGxnZnYwaGhONWFnZFV0OHVYazJvZXhONGxv?=
 =?utf-8?B?OXVvSWlsNmRNSHlnbkNVcUpraHVCcTJ6ejlLVlFyTWVqdXZ5dTFkZkt0RnhM?=
 =?utf-8?B?YXRlUGM3aE9Jd3RXM0hsbFdYTEIwYTIrWk0zR25iSVhJZlFLaVZaSDYwS2hF?=
 =?utf-8?B?YThVOE0zRWI2TDJuRUZrci81Q2lzR3dWb29MR0NoNUllWk1YRlB6b3NXUzdu?=
 =?utf-8?B?T0IxSUxxY3JBbEl3T2VqaXJCV1lINGdGSHM1OW8vZUdPVVRTNGNvTUsrb2Vm?=
 =?utf-8?B?Q2JrbDZsQ0w1dXUwTDZDcHpxZk0wNGFCT1dMWlhwM1VoR0cwd3JHRVd5blR5?=
 =?utf-8?B?UTJ0NUlQaWxKbG13dnBxLzdIdThZZVFXcitPMWQvN3Y0dHg5NGdxSENDdjZ6?=
 =?utf-8?B?M0Noak1GMmF0NnVpY0NyVGt6NytmT2JZUGxqZHRLNHE4U3pzakxjQzlUZGVt?=
 =?utf-8?B?NE9RY2JNbFk4akVtK0g0M0k0Q2tQTitZYWF6V0tycS85c3dmNXYwR1NieGpV?=
 =?utf-8?B?OGhrUEE3SWtCY1FKZmhPQU14TFBNcWNMM3laQjVpT0h1QnJnRGxQRTFtTGwy?=
 =?utf-8?B?OEFaUHBySGROQ2lyTWlVYVo5VEs5NktpbjNjSXp4Q1dETVBwTkZTNHRJNy9W?=
 =?utf-8?B?S1BHYXUrSTZWTUFjSkFYSTdVYklSVFBkN1JiSmI5dUQ3VEhQcEgyLzhYUWhu?=
 =?utf-8?B?bGRRbEtnR1J6MUIrNFd1MFNPVGp0OU9OZ3l4Q3hOcWlhbU1iNXZUTktEdDc3?=
 =?utf-8?B?NitHdU5UYSswdXlGM2xLbk9mZXF4SnZaYk5PYmxZQmhDaUNTb042bFRFL2do?=
 =?utf-8?B?bUpkQ3hKZi9rMjNKRGdlTkVMaWltYW5oR2N0M25WN1U1OVM4RDZFOVNWZWZa?=
 =?utf-8?B?Y2hYRjR3THJ5RWp5RlBuK3kxWlY1M1JzUzhIeUxPdHM4bDFrdXZMOC90a0U3?=
 =?utf-8?B?WUZYQThsN3BQYkVpdzFnYUJ3eFNvbzBEdUhXblFiOG92WUJOM3JOeTBPUkhB?=
 =?utf-8?B?Mmx3MkxkNnczWjFRNWFPcnVxUm9LNVRPWC9JcWdHbFNra0l4cnJHTnIvMVBK?=
 =?utf-8?B?THE2aUdRUi9lV21EdTNQcFhjQlhDa0JDZjhaU0NCRWdYRnBKSE1YRHZFbHBJ?=
 =?utf-8?B?c3FvcWh3bUhqQ0FZcEgrYXNWUXM4ME04ZjFXK1pKWVlnWlp0QW1oTkRPZHlD?=
 =?utf-8?B?ancxQ1lJNVVRSGl5Um5tSS9sVTR6SGs0Uktrd0Rld3M5TzZJajB4ekFtemda?=
 =?utf-8?B?VWRXQmYvUHJvVHh3dE01WWxFdVJLUXAzYjFwYzJUWlRsTmxoSFM4NTd3a0dx?=
 =?utf-8?Q?2qL9BY1N3opRImSqzsQ2aX7BS1eaDvRPrG41XZ7?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(376012)(38070700016);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K085b2VsMXljZ1lacVZvWGZJRWVIRDRSNDQxR0xzMC9YUU90RTUyYnlIM1ln?=
 =?utf-8?B?OWlEV25vVnp3dXVNOXJTOFdlQkxVWC9qU25HMVpuYjFmOHUxbUNwTzNTSlR0?=
 =?utf-8?B?V0hXd1c5ckV4TVJKelU0blBuaXc0VUF3eXpKbnpMUGNPTlhjSXBBRW5nd2xD?=
 =?utf-8?B?R1phU1RDdENQRXM4ZEVJNGdrVXE4cGFVemQvRkZGaUR3TDJXSWkzaVFadEk5?=
 =?utf-8?B?RS9Lc0FDc012Nk5IRnZhbUNVNnQyYkV6UFhHY2hXczNKbG11QkVXNnpncCtU?=
 =?utf-8?B?enA2aEQvYllVem5MYlRyZ1E5OWtDaG5EcEJVRXFjVWRTVUhwQS90U2tSenoy?=
 =?utf-8?B?ODlYYTRnelFUOFZibnR3NWNNTW1Pd0liMFpDMWlKcm5PbmgrbDRweUlFdU9o?=
 =?utf-8?B?T2hJK25ob3VjL25Gb3VmRHlIL0x0VWYza3RUTjQ5UTV2dU1yTnp6cDY1TnhG?=
 =?utf-8?B?U1VpNHdKZDJMQS9IdzdubjEwajVscU9SUHpSS2YwN2l6dlo5b1NmK3UrU05Y?=
 =?utf-8?B?eE1SbWxjNHp3TEp3eWZZOEJ0NWRZNE5WTHRtcW1nUmE5djZsbCtLU1ZpdmV3?=
 =?utf-8?B?T2JpNVRFZCtjcGs2QWJ3czV3SWUrN1UwUXhjT3BRTHpTTHFxdW45M281aXpO?=
 =?utf-8?B?NGFSNlpjdUFTVkNBblJ2eWNaVm8rb2I0NUgwNDlKdEFkaVpYYjdHd1J0YVJm?=
 =?utf-8?B?N2UySUtqdytQWGU0NlpKdkpjOHU2b1dqS0taMDJVWmU5cGtmdUUrcE4zUytV?=
 =?utf-8?B?SzJ3bHJLMFlRbG5tV1BhbjhkdmxyUk03SGFqTWtlcEZRc3dBSEhXUVJqQjNV?=
 =?utf-8?B?aGpWN1BKcXNhait3ZzVYd2dzaWZaaEJ1U0g1Q1BCWW93b1Q5V28rQXN5cjNj?=
 =?utf-8?B?RTkwZU1lcHBxYUtZZmpQSzZneStVa1hZQXo2bm4zNHdaTlZPd3Y0dCtJZFFX?=
 =?utf-8?B?SVZidUI2d1JjYzJMV1dGQzBpcmh6R092OExOVWptQmxuVXdGTFNKMmw1YWxk?=
 =?utf-8?B?d0JVSUVtQWxnTzdzenE1Zm5FeEw1LzRhOXBkM0hySTNwQ1NHMkxtTUNiVnBE?=
 =?utf-8?B?S2VaVXVIS2Q4SmpwVS9LSVltWjFNbWtzdWVoNEhPWXhMdDNqRDR0cy9ZUUFi?=
 =?utf-8?B?eG15YlNDSy9IaUhPa0RSQVAyN1RiRE8ycU5YM2tjRzdsTERnWlVFdG0wT3FU?=
 =?utf-8?B?MFY3VHRpSkhucFZuTStlWkdkZko1MERPb0FHUGVJL0wvZFZhbGlVTEtyeENW?=
 =?utf-8?B?RnZjK1FOcmRBUjduRlBXblFYSVZuWE0wdE9ySVFTTWNpMWZKR0RHYXhFS29O?=
 =?utf-8?B?VG9Wd1hubEJsVnlDTndKVGRweERoWmhydERrQjFNUVNKZ3NnMzJ4ZlhqLzB2?=
 =?utf-8?B?SmhkSHNXT29OR2hEOFhtQUYydzdYNVM0bDc4RlZEb1RITGd1NWVCTGdobW10?=
 =?utf-8?B?QzhmU3AvOE5qOWJ4ajZ6eWZXVnBxdWU5L0c3c21XZzZPN2kwYUJ5WUFrOEdP?=
 =?utf-8?B?ekNCeUR2Y2tBUEs1bGpGbEV3QUt6TVUrK3llWTRaMmNsSnRST2QyZDAvZVI1?=
 =?utf-8?B?QTR1cHRZanFER3NGeHcwWEJTRWlnZ0xPZTh3eW1uR2gzTlp5WDNnMTZ2cHB4?=
 =?utf-8?B?ZUFoWXlLNFcyZ3dZcGlGbk9UcUZMYSsvdWZtN2RYUCtNN2dwM3VZdEZHS00v?=
 =?utf-8?B?SWttUjZUZGYrcXNPWURSMm1ZaUpKdCtDdDhmZXpLMkdjWm8yR3kyQ2R5eHRa?=
 =?utf-8?B?SWs4VzlOalhUa3p3dFVFcjh4QUJzMlBpN1gybDNibngwTFIwMHR5L1VDeElM?=
 =?utf-8?B?V3ZhaDFMa0NkY2x1QkpxYjVONUFoV3BBRlRyL3M3REdPOUdEenpBTlVhYW0y?=
 =?utf-8?B?YkZ6RitNUlZHZzVOTUQzSGhicGZtWHV5eWxnbzBYMEFKY1hDRGRMN3lLQnRp?=
 =?utf-8?B?OGkrRVFMd3MwSEpYWloydGRuQzFnbE9CUmpCditWQ21RSnl3Y3g2VTV2SXdr?=
 =?utf-8?B?Q3JLSXdaSUFSSmNiYTlOMHEyeFdFWEtHazFLdGltVUdwYVFMWkhxa3ZZT3dF?=
 =?utf-8?B?VTZENmhEb2JOc1M5eFByY0xVeDBBbkViSG03aktHdnprRmphenRqcmJPaTI5?=
 =?utf-8?Q?73n1SU+cBqv2FlT90rupQU5sH?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 50fb88ca-0a6c-4554-4218-08dc958a75a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 02:48:29.1122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pa6KusSkly90vhSIxWJ+ORNvQNh10WnQYa/KaTmIHR15JZTvDscw/ER0usvtv/a9vcg9GSbXTBwBaqmVZrhWuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6122
X-OriginatorOrg: intel.com

VG9waWNzIG1heSBpbmNsdWRlIGJ1dCBhcmUgbm90IGxpbWl0ZWQgdG8gdXBzdHJlYW0vZG93bnN0
cmVhbSBwcm9qZWN0IA0KcGxhbnMsIHN0YXR1cyB1cGRhdGVzLCBhbmQgdGVjaG5pY2FsIGRpc2N1
c3Npb25zLiBJdCdzIGFuIG9wZW4gb25saW5lIA0KbWVldGluZyB0aGF0IGFueW9uZSBjYW4gam9p
biBhbmQgYXNrIHF1ZXN0aW9ucy4NCg0KVGltZToNCldlZG5lc2RheSwgSnVuIDI2LCAyMDI0LCBV
VEMgNzowMCBBTQ0KUGFyaXMsIEZyYW5jZSBDRVNUIDk6MDAgQU0NCkNoaW5hIENTVCAzOjAwIFBN
DQoNCkpvaW4gWm9vbSBNZWV0aW5nIA0KaHR0cHM6Ly9pbnRlbC56b29tLnVzL2ovOTEyOTcyNzky
Njk/cHdkPVdtZHdTMHBET0RSTk1TOXRRazU0WTFkdmJGbHFVVDA5DQpPcg0KaHR0cHM6Ly9pbnRl
bC56b29tLnVzL3djL2pvaW4vOTEyOTcyNzkyNjk/d3BrPXdjcGs1MmE5Zjk2ZDk4OWU3ZTIwYjYy
OGMyYzM2ZTQ4YjY4ZQ0KDQpNZWV0aW5nIElEOiA5MTIgOTcyNyA5MjY5DQpQYXNzY29kZTogMzY3
NTI4DQoNCg0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQo=
