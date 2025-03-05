Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBDC41C92
	for <xenomai@lists.linux.dev>; Wed,  5 Mar 2025 05:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741152652; cv=fail; b=nCAGCtg5b5aaR1KeJHpVEWn1Xrbo2spBmxHJQccqnT4l4J0+CDEjtowJuycr8XdYuZCliERHlQ7UBWGve9+Ik/VE3pBCwLFdDIY0Rb6EsPzN+EzJHfKpmjhwNRlsZn73LpiUO8a0SsOTribiaKjeI5D+Taw7ZEqdlV1I/vB6+uE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741152652; c=relaxed/simple;
	bh=zzadBl9wMy3EzlQG8T3qymY07HLxwng/HAKtwHTx128=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nbyhxJSA9wbdODgDh0Kqh4qDDO4gbHmL8y+zZn+QS3dkeLlLPLc5/loXxy1DAH9nWQgU2LTyBF2Se1TMwsqToIXKhVUuQtWFZEHhRN0V+kIRd9gIitjwzQeqVBPP/orRkTGkO3T+vVHP8sh6jdK4dMr/M+h4Njs+i+/NZE2PrTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UJ0dzv7E; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UJ0dzv7E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741152651; x=1772688651;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=zzadBl9wMy3EzlQG8T3qymY07HLxwng/HAKtwHTx128=;
  b=UJ0dzv7EVDtkN/XOSxFNm6lsjzKNPdu04xESpLDhj/EyU/D1UpRJEiR7
   rrUNIyCeIoBPvRUFNZ58js+DopJoKyWTLPqAsf48yhAYLUMqiNbh8yFDK
   As9obvwgc4ZHbzjExFzJUnAjOKVfsC20pLHl3LCLMVxZoOx/mBQYZrtmw
   Un/AENIrdSkug+gogJHzSQTfdkM6V1IyBJH/yoxxdXy7sa7U5iRJSz7zk
   14AR33HbeetvwzYc3xM/dUS1aoetMxgPKa+hd1mmWAF53Qh/bsFJ8JcJx
   LHmd34Fam1tObvrRGs4KwkbtY3Eizlt8tuvwxhuYRoP2oBuO97eESHUq6
   w==;
X-CSE-ConnectionGUID: 1fDC9vnOQi+3H2BPf225WA==
X-CSE-MsgGUID: WtDlPWO7SjqCM7sgwiEN9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="44908960"
X-IronPort-AV: E=Sophos;i="6.14,222,1736841600"; 
   d="scan'208";a="44908960"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 21:30:48 -0800
X-CSE-ConnectionGUID: pdygauhVRbmHHHa5bk8f+g==
X-CSE-MsgGUID: FvMpicCtRfCyPrTuP3H+pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,222,1736841600"; 
   d="scan'208";a="123689659"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 21:30:48 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 4 Mar 2025 21:30:47 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 21:30:47 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 21:30:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gm30nl7zPIZGl2OHlvIm8IgYf/1/s3sTXxt8RfFfMtuvhMo7LAN3kVAk74R/uUXPILbi9n1IznQHdr3+OR90XUaJkhXu2AMAm23dFj955h84SzRmfzE08QjPPi0FY8v6agdj+7lQZhVrJ/LFNf/Deet/9s+HzLgyMpsioIu9yiJEfrbxDYF/KhJiwmWL6eJ2PeG/dqyMANvC1bk28Yl5/a1q+FQIfgVprly/b76++oAAXsVekdGj7HQE5b38sq+4Pdwjpg2lQqoUKPwZt8ie1KmvZpjK70Zimfo4UdPtsM/znT5B/PEUUpab0PG2TwVbYpj8fhasJWFYuiwcOahoXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzadBl9wMy3EzlQG8T3qymY07HLxwng/HAKtwHTx128=;
 b=bIBjIRd3JSo9+HfjwOl/2Zd9the7zhZQIYDr5KNcgglaPXy/FyOG/ziWIxVs/jTDWxNB5ESYTBqVe8ZB9Z2y/In0MK9wEOz+Hi1zfVE9xtZBgBEZw5o+Ip7KQnn4MGQGsptKCi32wppGmSvcJzj8cvigYFbIrmzOlggKwmA87WIlMB/hafAtmhTheLVvIM34w8SXCfCT52wLHdfCyL7jGEPuFupsBr4bPKMVt6FZPSfSsHmrN7T/A+UViJjLVvg+kELLFfkswdeE/C6jSH+FnF4Jaceo9auvDTNvbwLlko5aeRqFKC/i9LGbx2mtMfbxDeuxzR11xQXlZjeXM+BCRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by DM4PR11MB6192.namprd11.prod.outlook.com (2603:10b6:8:a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 05:30:02 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d%6]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 05:30:02 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday,  Mar 05 , 2025, UTC
 7:30 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday,  Mar 05 , 2025,
 UTC 7:30 AM
Thread-Index: AQHbjY+lOzAihF4r8E2VOUsVm4WAAg==
Date: Wed, 5 Mar 2025 05:30:02 +0000
Message-ID: <PH7PR11MB7499534189182B1B56FDC426F2CB2@PH7PR11MB7499.namprd11.prod.outlook.com>
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
In-Reply-To: <PH7PR11MB749901F0793C63043273F166F2C52@PH7PR11MB7499.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|DM4PR11MB6192:EE_
x-ms-office365-filtering-correlation-id: 2e26db1e-1bb2-458e-952b-08dd5ba6c78e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cUtrcFlzQ1ZTZk80cjlqUWV1cUNNUWRYNVY4MVBDUXhtNk5EY1h0T1Foa2sr?=
 =?utf-8?B?cUZNRWMyODZwL1hDYk8xYVlQeDZQc0lIQ0NaU2t5bVZJcTkzVFNuUmxzYjRX?=
 =?utf-8?B?OUNKZ05ZNEdZVC9namc4bVRiMXZsaXRyaXcvQXpPYVQweXBCRkovcTkwem5O?=
 =?utf-8?B?U09PQ1V3YXZBTmtwMUtWNFNGWStoR0hRWktiN2xWZitLMnVpeFhFR1JzVG1T?=
 =?utf-8?B?RXJXdW9MTjZmMFo4ZjNuS2ZGVU5VWUExL0toRDJVL3RjNCszbFR6K3NzYWE1?=
 =?utf-8?B?RjUvMFhIMit4ZmprR0lJZnJoNzlhd2ZtQWpYOUtkRjNpeDdLczRwby83dW5z?=
 =?utf-8?B?MVpIK1ovQ2VHbnhxVTBCVTFjOU5ucGtweTRNTHBQTEhpajBnejRSeDQrTnc3?=
 =?utf-8?B?UlFJeWZxWTMwOXFBY3FGWnJxeWhMNDFqNGdrcWNsUWpvTkljRXIyb3lTcitj?=
 =?utf-8?B?Y2ZJT0V5SC9FWmxHczVZQlBQZDVCQ2RaTVNYNllPZm80L1ZERkdYVnJrYm1r?=
 =?utf-8?B?RXpEQ2RtUFc1WEtnRUFxanJjYnVoTzQvOXB6KzRPVUZRN0xKNzYwYUl5emNT?=
 =?utf-8?B?Zy9JR3ZaUGVSY3g2UEUreGxFbDlSZkhMSnpPV05JSlo1VHhvM1hMK3FrVFpp?=
 =?utf-8?B?RDdzblorNTRNV0xFMGJURWgwL013WDIwZGM0WXlzT0ZNdW5CeDlSVjdmckQx?=
 =?utf-8?B?a0h2M0tiVXorNFJXbnZUV2NuWlZFSTVLUUcvVnRPR21JKzgyMGpseEYrdTVy?=
 =?utf-8?B?eWpHVEdVRjlIbkJkYXZsR0JQa3hEaHJINjlMSVNyajNMUVdWRWVUOTVnUm15?=
 =?utf-8?B?cFVKc3BXZVFKcGdGVkZmRENOZGlSWW9MWkhxbEUxWGtvQXBxMVBrQ1JvWUJr?=
 =?utf-8?B?TlVlWHYvVzY0b3M1MkRCRjVWYjEyTDJlZUZvbGk5S25xZVByd1dHaTVwME5v?=
 =?utf-8?B?bzlmUFh1d2VDVEI0TEt3aVhVVkJkem1JTlhkNkYzcDE1bFJsMXNMcWNrekxX?=
 =?utf-8?B?bTRQbTIyQTFFQXFQNkh6cTlYRVQ4by8xV1hKSWJzWStuYzZDUVJPaVBXSFBt?=
 =?utf-8?B?UVRJcVZrOUZDaS9IcFVkZFlTQzdLc1loNFExYWJqN21rdEZpWTY1TUJaMHY4?=
 =?utf-8?B?Mi9BakV6dmU4a1V4VE15emZIU2xuTTVDODdsUHR0VC9XaTRNUWhod0VFTVlL?=
 =?utf-8?B?ak9vWkJCSDdTbE5nSDV6L1YxaVJUQ3BjRDdzbUNLSXZZa213NWVyYis0V3RD?=
 =?utf-8?B?NjRCMTh6aGxlZUVpZmxOVTAyNk4vSmk4N0srdnFJYnI2NDlqYm5iRUxjUi9x?=
 =?utf-8?B?VUlhbis0SXpzUkJlNmJoUkt4UFUxdGdQVktjWmFYZ295MFhOSThBNzNUblBh?=
 =?utf-8?B?dTVRZGViQ05rTVU2dGJGUXE2WEdHZ3lpQXVlT0ViSGNnZTNVdjE2bTRoZUNs?=
 =?utf-8?B?RHVnTnI1K0p4cUN2OGEwUE5WanpiY2RZQi9icFNsaXdYeFhKNUg0TlpZd2wr?=
 =?utf-8?B?VTJvLy9PeTc4SXVnTTNnanJaYnZ2RExlQVZFYTZITGJjR09ZSFNmWmZ3V1Zw?=
 =?utf-8?B?bGJ0dHYwS3RrMWh2UkJ6M3prK3dXeG9RR29hRzlnbUNyRU5tWHE1U3c4aXU1?=
 =?utf-8?B?alhMd0tPbnMrTE40OEhkanBXaGpmNllwMzlXb3cveDdhRDQrWTA4STBobENV?=
 =?utf-8?B?anFVUXR2RnpTZmpVWHdyYjY1NDFqK3g1UWhMQkZkYTVtczBHWFhLKzBvSkxW?=
 =?utf-8?B?bDRwa1VadU04WWVyTCtyYUk0aitiQUNuN3I5b3N2Um1qYWdMK2lkcC9CNHAw?=
 =?utf-8?B?SGU3TnNCbEpaajVZUGJiNWV0OUpveDdGQXJYRkRTNktVVktpNExCTzhIWnF0?=
 =?utf-8?B?V1VuZzFSZXdmWE00MytyZEt5SitFTWErQkFwYm1sZ2lPdUE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bEN3Smxab25SZHVvRUI5T05TZE80WnRuMk1tT241VEpxSmpiZjJ3eVNGUzZ3?=
 =?utf-8?B?ZVhiSFVDVGdxZlNYUERGZjlJVjQ5VWxFQ0FYak8xb3d3eWt0MTlMYW1xN0F6?=
 =?utf-8?B?eE1HWFcxejJSdTUwaUJvNFc5UmxIdnFWZzZJZGc4djFhZHBmaWoyQWNJYVNp?=
 =?utf-8?B?c2NySlJpOFlrS1FjQjBwUnZKSFNRdjVjTFNRTGhtYk5KTFpIWjVOMFRXeGp1?=
 =?utf-8?B?cTFGZXEvWDBSSDhwM2tMK3pmMnRuTk52dllQaGVhVG1MRENNTEU2K29qVGNn?=
 =?utf-8?B?RE5PWjZJRkhyVE9WSXdRdHFaRDg3QlZFZzg2bzBjL0dIcmROSWYxYm9hVm5r?=
 =?utf-8?B?WUNKR2VpdDZxenpiTDZ0Mkd6Y1VSeVdUTzRYMDRPM2ZJYUlkL1pnNzEvTlE2?=
 =?utf-8?B?SElJOUM1Qm5sanZSZEgxNnlSancxdkFycXVaTVkvZFo4WWpja295a2ptcVgr?=
 =?utf-8?B?c3M3T0JNQmg2RGlRSlFxV3h3ZGo5eW1mdU5yeStmYlNGTWVGZUFGKzF6TWhR?=
 =?utf-8?B?dElad1Q3cDFRL1Z6cWlKbjVpVWhTY3lyMFFGbklMUk5LYXVNeEswTXlteUpB?=
 =?utf-8?B?dm5tMFMwZ3pQd0s4S2taQWJnVFFkVVQ4MmJCQUdXVnNidEZZbzJGMnFLMnJO?=
 =?utf-8?B?WlFodDN2U0JQVnE3MUR6eTIrblVWc2NCL2M4S1J0UkFjaTB1RlMyVTZSNXBN?=
 =?utf-8?B?VGtLaVNQcmZlaCszRGRhS2RRS1FzT1JzZWk3Y3N2eXFReENYNDNWOUJZaWRy?=
 =?utf-8?B?bENMUVhkV1RiVjAzaSthQ3JxeExmY1M0OFkwSWVCZmFQemx5TWwzem0ydXk2?=
 =?utf-8?B?ZHZmdDRkeC9BVmRRRERPSlR2aEx3M0ZLVVl1QmJRdFpYczFNSkdOSERHd3pM?=
 =?utf-8?B?WkFQTld5bkx6dlVoVU8xcEI5YkJDdnJTdGlUZU52WDFOK3hGL0NHV0Zudk9x?=
 =?utf-8?B?N0pIVFlPU2UwZEJERWtzNW5zYzlSUE1WcE44bTBrT2JoOFNWY3pjRzc4ckRm?=
 =?utf-8?B?VWhEblJrOHBhSnh3bUg4dWplcWxYWjdmVkl1QVdrbHd5d0doeHllVVhOb1lt?=
 =?utf-8?B?SWl5WDg5eE5aTkQ0L084MHNrWkNzSDVIOVJCSzIrb3BaM2RCbFMvV1oyOW9z?=
 =?utf-8?B?NVVONUFLOUlkLzBxeFUya2pMcnFWMElNRUx1clVuZXlUOWpyOVd5UkxTc3E5?=
 =?utf-8?B?UmZ4N0xyM0NCVC95eThOR21kWisybjEwd1p4UjFDbTllTk9wR2Y0bmdLVGR3?=
 =?utf-8?B?aHJPb1E4UXlzamhmUUJNMnlrN3pEcVFiQi9Jc3dzKzZWdCtZRXp2a2p3eEhG?=
 =?utf-8?B?U2ZuWWpQUGlaTnR0a0FDWHVwTVhHandrS0dvczhVQlFKVFZicExhZk9QTkxK?=
 =?utf-8?B?VUJxSjV3cElFWVAyeEkwdzRTNVZnT0dJRHdmVDVNckcxZnlRbkt4TjN1UGI0?=
 =?utf-8?B?KzBjVVRUQktZU1FuN1NJK3YrTXhOdmRpZ28ydzRoLzdSTVhHZUZGRWsybDNo?=
 =?utf-8?B?RCtPenFqSzZ5Qm1Ma0VGOHRkaGFDTXN4Zi9aZGRRSnNqeE9NazVkT2NLbUZn?=
 =?utf-8?B?bUJYM2FLS05oZVdMaGVIWWNNYzdudlZCTy9qSnRBS3lPZFl4Z3dDVlcvOGhu?=
 =?utf-8?B?dkJnVW5xblQyR2ZuK3pQNDE2N202ZWRkbVduNzNBejRVL0diaGo5WUdlclBt?=
 =?utf-8?B?NTVJaVl1U01QWUFrQkU1bFJENEw2KzRLdFJnUkxLL0xMOHJkMHJwWjA4bTly?=
 =?utf-8?B?K1VuUDE1V0Zmdnl5TlhIVEJ6Y1hDeEQ5R3JybjFJdjhEMEFSd29pSk5tODBF?=
 =?utf-8?B?Tjh5VlMvZHF5RE9DVlhaWXN1YjNTMVNKdmtPSlhzMFlMaEh6c1pVT25LZDh2?=
 =?utf-8?B?SFV0ZWV1NzVnNlFDWEYzMXcyNnphTW9tSUhiSGhZZUpEbEhzcEZ1UFZBQ1F4?=
 =?utf-8?B?Mld3eWJCcEFCdm9vamNDVWRTV3JVa0RMWXJ6NklETG1QZDZpWWpMQ1AwbTYy?=
 =?utf-8?B?OWxrdlE3RGNabFM3THhmYkhaamRQQXpGbFJxVmJ1S015S2YyRmlpMFVOZUh1?=
 =?utf-8?B?RDEzWkNtMnU3S2pUUFZkTEVPdUVTeDFlNnZLYVRJbjVKS1hCN01LVkt5S3pQ?=
 =?utf-8?Q?Jx38Fzw1kRGNbNuIsinGu0zhy?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e26db1e-1bb2-458e-952b-08dd5ba6c78e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 05:30:02.6654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ir5MZJ8qqKf6CK2oaFF0TY9qee2+tViopmCn3L1JDN3tCjKy5LPqdxuumsjndcAIDBDsFv+dRB9TCgXrJETB5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6192
X-OriginatorOrg: intel.com

DQpUb3BpY3MgbWF5IGluY2x1ZGUgYnV0IGFyZSBub3QgbGltaXRlZCB0byB1cHN0cmVhbS9kb3du
c3RyZWFtIHByb2plY3QgDQpwbGFucywgc3RhdHVzIHVwZGF0ZXMsIGFuZCB0ZWNobmljYWwgZGlz
Y3Vzc2lvbnMuIEl0J3MgYW4gb3BlbiBvbmxpbmUgDQptZWV0aW5nIHRoYXQgYW55b25lIGNhbiBq
b2luIGFuZCBhc2sgcXVlc3Rpb25zLg0KDQpUaW1lOg0KV2VkbmVzZGF5LCBNYXIgMDUsIDIwMjUs
IFVUQyA3OjMwIEFNDQpQYXJpcywgRnJhbmNlIENFU1QgODozMCBBTQ0KQ2hpbmEgQ1NUIDM6MzAg
UE0NCg0KSm9pbiBab29tIE1lZXRpbmcgDQpodHRwczovL2ludGVsLnpvb20udXMvai85MTI5NzI3
OTI2OT9wd2Q9V21kd1MwcERPRFJOTVM5dFFrNTRZMWR2YkZscVVUMDkNCk9yDQpodHRwczovL2lu
dGVsLnpvb20udXMvd2Mvam9pbi85MTI5NzI3OTI2OT93cGs9d2NwazUyYTlmOTZkOTg5ZTdlMjBi
NjI4YzJjMzZlNDhiNjhlDQoNCk1lZXRpbmcgSUQ6IDkxMiA5NzI3IDkyNjkNClBhc3Njb2RlOiAz
Njc1MjgNCg0KDQpSZWdhcmRzDQoNCkhvbmd6aGFuIENoZW4NCg==
