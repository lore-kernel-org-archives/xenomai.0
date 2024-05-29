Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8330632
	for <xenomai@lists.linux.dev>; Wed, 29 May 2024 01:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716945750; cv=fail; b=cbkw5mQMKj5Xiftoe0mvCT8j+A3pAGcz8GSFGPYzdgvXw9wPNgkHLcJSPLPUf6LifNe91uadyItVVEmd1uM8D5F54zMQdQZnVyKrnB7toI2SJruoNJUHQNw15l9e9TzKu6fQX89Y7hj3Nr9my+JM5bfWuIklcl3R7vWwixg0vzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716945750; c=relaxed/simple;
	bh=74T0nKtMSBnfwANYVNySL9D7+vZPE5OB2MTHLFsaNfM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VaGrXgXBebxAWnOKDQe3vz/DMhz+x9VJzcPwsv8iH3LFtveeGJhJXMRgEsBXxVwzJXHxIbO61vKlca9kGkThrSpKBKJvYPAUmWKZON757O3NgUSqz/YTF2i/m2sspVKqY7HqqL+tIjYThtG9OPoBZuCqnYWMSE6aatGiJXLW9jY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gvkZTIyo; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gvkZTIyo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716945749; x=1748481749;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=74T0nKtMSBnfwANYVNySL9D7+vZPE5OB2MTHLFsaNfM=;
  b=gvkZTIyo26DmaWL7qvqnIerIITtxjNMFCJiS1TzuG5o/Z1QQhhepPI41
   mPh7Isfbytv/vIbYs0b1MjK9fTJYnXSJYjGZF4d3e/jrh74BHV6+bzNXG
   jN33jKYgAWfqY0S0YDbOiJKW5s2KZnVygKG5J7sfH/kzGEXkXGKAyUc5J
   1OrHRCrX53fMGhEIL+RL8w+GjEN/HQdw2H0/kOb2y435nx8Z26UWO7KXd
   zP0LAQUojLcfEJPocDk+V6CfAEVZ1I9LRr6hzS4sY9B0YyAQqAXkXdH1L
   CfWEI1Dowgy3iuyQCkyjfMxXcfs2ifTzBv9kwRddhNrboLF22YVmZ7TNN
   Q==;
X-CSE-ConnectionGUID: RNds1F+ZS0ei1E8Rx3HHsg==
X-CSE-MsgGUID: jOLWT4vCQsajNgKEf3ZYOw==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13549227"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="13549227"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 18:22:28 -0700
X-CSE-ConnectionGUID: a0a4h4t8Qvy1rlg70V6EOA==
X-CSE-MsgGUID: R+wV2HxXRTmNDq9qPQM8Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="35174871"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 May 2024 18:22:28 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 18:22:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 18:22:27 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 28 May 2024 18:22:27 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 28 May 2024 18:22:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drQTsP2fcIMrQNqRk82Puvo4O2IOzvnawdIQWxL6p4gC365okoW3FCYwV/kjLf2YqXo+V0lKPx3lbbEtRF4tG/owuYyBOaF8gS5motbYlA56ouzgj8jxut3fNWuFfZxjOtq+tpWHtnEdYvVP+wA8+juvrZ2xu3K6BcwtEx8sH3yaSn6JcYbXARLNo0Kab6R1eut9nupCDeVpo/ymVRyiKmOEB7L6+W0XNxKME7P49blDRNHmHtM1TQc4W1Yyxh46OzsxQlqcKib9aewGJ4tBV8KtflM1gT+KUtrwlzkfIkKilBB9evOHky3d+F+VGt+WePt5v0AfQnLg4u75x7/cVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=74T0nKtMSBnfwANYVNySL9D7+vZPE5OB2MTHLFsaNfM=;
 b=ko+n8eD8Jnzp4gmpS5o2OrtWYx1Ig4SwutRT6ND3pN/+UT745kzD4jbEStEv6ar3ggdtFvLCGj8PNf/EUyIDdqd746c1wEkbBtZTKMFSASFEMHmbrqfHuZS7BdHkQnZWTHsCoblaiS98HMtR33fXtoZhUmdz/3R38+IXqusSo6u66J/eusEcS1GbVQO+0Np4/85/kithVrWYQvnpGOa6rW8wXDy5d1L7OPmpTxYUNlT5Uaw9cqBrp/fZrO7AZDYR5p9DsqxKU05Oj8j1Ww5xpuynkwACravaLCxiitM9QW28Xygt7xbtq8K3SO0f5YQj/MuwFBXlPWQdf5LzMVfc6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by SN7PR11MB7018.namprd11.prod.outlook.com (2603:10b6:806:2ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 01:22:24 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d%7]) with mapi id 15.20.7611.030; Wed, 29 May 2024
 01:22:24 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Xenomai Community Call Minutes - May 15, 2024
Thread-Topic: Xenomai Community Call Minutes - May 15, 2024
Thread-Index: AQHasWap0oD48ctaGU2PoSa+4t9+FQ==
Date: Wed, 29 May 2024 01:22:24 +0000
Message-ID: <PH7PR11MB74999307830ABE8C6E622DB9F2F22@PH7PR11MB7499.namprd11.prod.outlook.com>
References: <PH7PR11MB7499F7DDE006A3A7291F61FAF27B2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749929DFFDCFE47376883636F2572@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499F4FFFC62E15096DFF8D3F2562@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749910600BAF97BCB41DC3D3F2202@PH7PR11MB7499.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB749910600BAF97BCB41DC3D3F2202@PH7PR11MB7499.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|SN7PR11MB7018:EE_
x-ms-office365-filtering-correlation-id: a04cbda6-3249-4623-4c44-08dc7f7dcb8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?aEtkeFBLdExmZmgwUGsyNElyT2dBRkdDUmhBZmdPOXdjR3R2VjhrbGEvV1RR?=
 =?utf-8?B?QWNsUjNPamo2QW1QYXkzUW5IcVhVZk9ocXF4RmpGTWllTG0wMnFRV1d2RzNY?=
 =?utf-8?B?cDgzVCsxQ284bjR3aEtOMENROFlNR1Y0OEFDdXUvUDljeElvUGNRQndYRkNh?=
 =?utf-8?B?RGNSRHpPRkR4bTRXVUZtTlhSY2NLYWJmRWdUaEVaSlZpbzNRc1FIb1U5a2J6?=
 =?utf-8?B?S1dYaGI2M0RZY25sZmRBNEZPd1ZHbU45aUdoNVJneFhKUjRiQU43YXRDTjJ0?=
 =?utf-8?B?aUhjcVBJUjN0ZU9mU082dXlxMVUyYUVjZTZKS1JML0x4K01ZeHZ3NXFYMlNn?=
 =?utf-8?B?VSsxUXB2L0t0SzBsM2RZNXdmQlVtTXhzaVJxT3VSbWgxWEVUQmM1TEVZKzVL?=
 =?utf-8?B?MEMrOStLMFo0ZDdma1RYOGNWUTAxNnhhOHVNeWYvaE1xM3cxd1VUTjUzdGpQ?=
 =?utf-8?B?QXlaempaREJCa1VUTlBjOG15UHFKZUhSMDZ6dVA4ZjVBUXk2V2FCdWM5em9K?=
 =?utf-8?B?K0FpNjgrV01qVzlPZzUxVHRSUDFLcXNVcDdnZHg3WUY3NFNJeUg2N1RwbXl4?=
 =?utf-8?B?dUFEVngvNXR0V0V1aU5oSnI3akk5RG9LMFVNRjYrTFhaVW9nZFhONWh5Wklh?=
 =?utf-8?B?czFxS2EweDJCb05OK3lFV001SW1oZHQ2Ny9KdXBiUVBxK2JHNlo5d3hmK1Yz?=
 =?utf-8?B?VFprVnMzd0ovWWJuSVFkZ3JRWDhhcUJRb0xuWFd5cCtQVGxORkRSNFoycnRt?=
 =?utf-8?B?WDdMUjNzSGU2d09YUVIrRUJLNm40SndyalZXRDZiSHVxRWZTR29HR3BNSHhM?=
 =?utf-8?B?bE9RL1JIUWFCbzhiRWUxeVlkUkZyYklZQVBJU2VQWks1YWV4STZUY0lOanJ3?=
 =?utf-8?B?dWYvNkhRMVFHRzNLMVhWdFBzTDg3Z3laWkl4RWMwRm5hNVdTSDU1YktjcXpO?=
 =?utf-8?B?VkdxbFMyMHNKaSs3SWpZb3ZXS3FNbDFBcUp5ZXZBWENIbnBiYkxkdE5ZaTNK?=
 =?utf-8?B?dE9jYmxtNXoySGk3cXQ0RlFlYVhCQWd0UGw3eWFtSXoyZkM4ekRJckh5TzVF?=
 =?utf-8?B?SWo0TFpnRC9ZOXg3TlB5Z0NVZnpGaWR5enJJM1A1c0p3RG5td1E3N1JHbWZU?=
 =?utf-8?B?N3g2ZlJNK2QyQlhmZDAyY3JUK0FYaVYyWnF1aDZlUm9QUzR2cUJMOU0rREt1?=
 =?utf-8?B?bUUvcmJQYVlYTVZUYWtGdVdORkZydGZuVEEyaG4xKzVPd04wMlZFZlVFdXNH?=
 =?utf-8?B?RzZGVGdEM1hReEo0alpzTFpjT3pmVjNndGdqSUd1dURTdkVMZ1RQdzRnd3lq?=
 =?utf-8?B?bGRVQ3pidy9xVm52cytQWXFjVW1tZ1RYemx5REp5S1FZR2JzR0kydWVkV2Nm?=
 =?utf-8?B?YTVGMnZUYlZWSWlIYUVXNnBqeFg4SWJubUxtd1NyQUs0Mnpqc3JWeWtYUXNR?=
 =?utf-8?B?N1lKMXdYcUdJUElzTEszVmlrN0M1cm8wazNaRnhjZVBoSlNWTW9aY3RwSEpi?=
 =?utf-8?B?VFRoVE83eE8rcmE1ekdvZDI2NWx1S3VTWVF1UWdYbnozelNPbXZwS2JZZjVv?=
 =?utf-8?B?QlQrODdMTXZOZEFMbjczeFlQcXIyelNBTmdQa0JsMmZDWUJySE9TdEZlSm1B?=
 =?utf-8?B?c3NWOE93ekRTbmhIYTI5T0RMdlVBcnJFN0pwTDIxVDg4WXRLTFM4emxvbXJy?=
 =?utf-8?B?eklWb1REYVUvTU9NdlBRcjBBc1VJTVh4eXBDVmc3RnB6RDhzSldvNG05MUtN?=
 =?utf-8?B?WW9IWThhTWlZeW9TTWVsSWpWNEQ1WnhaSzE0aTdZZlNvRXVCcWgzYjBHVlpF?=
 =?utf-8?B?bkJKRWpIeFhsMmw4d2lLQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UE4veWJZczBxdkRpaFJTS0N1aUdmYjc4SEF4a3ZzanRHSEI1TGpKeGhTNHpP?=
 =?utf-8?B?dUptbzVydmtYcXZBV0ExLzBvcFFrYWpjd09lTjY2Lys2MTcxRjVZUDRBV1hQ?=
 =?utf-8?B?S0cvSm5qTFdNcnpZTExlOUc4VnpPME5YekpGeHNhem1aMElBUklkWVc2VWtX?=
 =?utf-8?B?cnBVSjVkWXBRRmFNMWRWLzlBWHdHcVB5Vk45VjhpUXg0VlBwVUNxWDZJUjFq?=
 =?utf-8?B?M0pCRTNvK0pTZzhzNmpBZjVrNTJ0SFhqT3IyOFk4cVF3MWxsaEdOTHZQRldi?=
 =?utf-8?B?VmRqa05VQTdqQmlQUmg2YmprL25yOVlXSmYrM0pOdjc2SHNCVk5NL200cmlt?=
 =?utf-8?B?NEoxVnRvcGdQRjdiZzYzamR1cm5xenk5L0NacVdXVU8yUnlaem4rbDRSUk5r?=
 =?utf-8?B?WWhOUDk0U2lQOEFmZE50c2EybW12SVNKNnZvUFg2UGJYeGJEeXZTaFNKdjF2?=
 =?utf-8?B?dlJsNG05QW1qNWdqdnQrYmc2OXdOWFdEWmp0c2syZXBNdmJkQ0g5Z0VwKzdw?=
 =?utf-8?B?RHFoS3I4blhnSENJV2IzYXpGZTU5bWtIMHFNa1BkUkdCYTBmMmNjZWFVVTNh?=
 =?utf-8?B?a3I5dFlrcXJ4TEpBbmp3OTBQVnI1M012dUtDaE1DbXdORmpPRkE1aEJzNGUz?=
 =?utf-8?B?YTJyMW9GaXFkQ1NFZHZqOVdjTEEzbEtsUEJHWnBkMCtaTllKZ2wwL2NKQkQ5?=
 =?utf-8?B?ejlnMENXUE9zRml1eVpLc1Uzemtmd1EwajZNMWJ0OWNKT1ZZWXVXZHdvaEZ5?=
 =?utf-8?B?TFIvbTJUYmVFY1NDY09XaDJUTURMUHIreHRQVThmR1V1L1RHZzA1YkFiK0w1?=
 =?utf-8?B?K0MyaTV3K093THNta3JhcHVqT1VIaE1JazFSZHdzTTAwT2d4dzI4TGlkUjcr?=
 =?utf-8?B?elBYazZ5UndRL0hPbjhPM3J4UXc2cjZVUVNKUmdUa3B1bDkydEhURHk3MVF3?=
 =?utf-8?B?T0JNb2Jnc3B5aC9pNFJlOHdSL1N0RlJxZkdubWpMUjlqQXlVdUZndnU0SVF1?=
 =?utf-8?B?NnFLK0s2NXEwWWhvajZWUmdseXBCbE42N2JtODZoeFNRUkw5RXB6cHloKytC?=
 =?utf-8?B?ekhEbFE4UGkvVUlQSE5zRDVoL0ZkZXJ0cDk4UEE2em1hYWRpeE1Yd2dkWnUw?=
 =?utf-8?B?b1FqcTIrY0paZ3dESVJ6K2ZJNkdsWlhRRWx5SVRZUUZJeDlMb2RtQlhMa05G?=
 =?utf-8?B?QVZYeFFzNDRJZEVKTnZDN3ByTWdZcjBTM1U5cGVTSCs3RFlZVENRNWtPUXZS?=
 =?utf-8?B?bVNEMVJiMkhPczcxZ201Y0RGZmZSQjYxak5jZ0p4d3B2K2dBSmV4REtUczhk?=
 =?utf-8?B?a0lPWmgvSTlwYzgxcnpVdGlkOGc4SkVwSnFLQzRQcHZBV3o5V1YzWlpRcUxh?=
 =?utf-8?B?TFQwVnhLYWtQZjRyNHEzOUNnaUZHRkJjS09OMVAzd1RYTzFyUWwvM1E4bC9D?=
 =?utf-8?B?d2J0bnhGYjNwN3pXUVc1aEZRNVZ3U2haVlVKWmlWSmowcjQ4SmJFTU5EVnNB?=
 =?utf-8?B?YkJIR2JxakFHeXJObG9sUmQ0SkZMaDR5MDVIS2ZLQWtBOW8vS05udFpnYUg4?=
 =?utf-8?B?UUdRTkJNNjNwTmpoeE9IUWhHcGlEa2g5NzJxQzJxMFQrVHJRdkZkYXhhSG9G?=
 =?utf-8?B?bzFoSG9rZFVDZTh3cWxEVUdMSUQzdk9HYjZJV2ZtTTlCZGtZSElWQkdmU3Jj?=
 =?utf-8?B?UVpRb1Fnd1IyKytXYUFPd3U1SmIzUGZDdnlBNkpaV0hsRzhvYnVkdGI2dDJp?=
 =?utf-8?B?NHRENStkajhOWUUydi9SL2hVOURyMnZnWmE3MWhROXNKR2dDb2dKVVArNGZn?=
 =?utf-8?B?Wk81UU5PbXpIeVRrY3VFRkxIRG9SVnNkQjFoOFJlVFBRUnZqb0U4WTZpNWYz?=
 =?utf-8?B?L1A4TkJJTXlKOWxac2VHdHdzeXJyMWN4QlU0L0wreDhoY2lKNTZ3R1kyNXB1?=
 =?utf-8?B?RURTbXFZYWo3SFQwSkV0M1NBclU1aUYzdW9PWnRXQUhLTVBlSzlsaSsvNDRk?=
 =?utf-8?B?Y2N6ZUNEc0thOVhzc1F4QmZOQ21GNXJYT1lzcDNrQXJrV2V5N3B6QUxQZTFh?=
 =?utf-8?B?cXZxbFFEcXUvai9wMW93eGhRMW4yNE1QWHFpcXd3aEQ0b21ZWmFSUXVhbjdp?=
 =?utf-8?Q?ytUv8FVJLQorwNWTsu4npxiC/?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a04cbda6-3249-4623-4c44-08dc7f7dcb8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 01:22:24.2364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WWziFimuUFcI0bEDSRDELDZOMa9pc5S9bLDf1jiquaGcXfbSlIGXiD9AkHk3ZTJWIwt5yS23bKODv17K2D47fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7018
X-OriginatorOrg: intel.com

DQpBdHRlbmRlZXM6IEphbiBLaXN6a2EsIEZsb3JpYW4gQmV6ZGVrYSwgUmljaGFyZCBXZWluYmVy
Z2VyDQoJCUNsYXJhIEtvd2Fsc2t5LCBEYXZpZCBPYmVyaG9sbGVuemVyLCBKaWFud2VpIFNvbmcs
IA0KCQkgTGlhbmZlbmcgTGksIEhhbyBMaSwgSG9uZ3poYW4gQ2hlbg0KDQpDb21tdW5pdHkgdXBk
YXRlOg0KCQlUZXN0IGxhYiBkb3duIC0tIGZpeGluZw0KDQpPcGVuIGRpc2N1c3Npb246DQoJCVJl
YWx0aW1lIFBlcmZvcm1hbmNlIGlzc3VlIHJlbGF0ZWQgdG8gR1BVDQoJCU5YLXByb3RlY3RlZCBw
YWdlIGlzc3VlDQoJCVhlbm9tYWkgbWVldHVwDQoNClNvcnJ5IGZvciBsYXRlIG1lZXRpbmcgbWlu
dXRlcywgSSBqdXN0IGZvdW5kIHRoYXQgbGFzdCBlbWFpbCB3YXMgcmVqZWN0ZWQgYmVjYXVzZSBv
Zg0KZm9ybWF0IGlzc3VlIGFuZCByZXNlbmQgaXQgYWdhaW4uCQ0KDQpSZWdhcmRzDQoNCkhvbmd6
aGFuIENoZW4NCg0KCQkNCgkJDQoJCQ0K
