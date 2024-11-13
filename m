Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80E716DEB2
	for <xenomai@lists.linux.dev>; Wed, 13 Nov 2024 05:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731477419; cv=fail; b=GUmNDtdMzJ0+9TthUV1a6SUxD8Zt97JuYt2HuP44O7IxRK7UAwqN81UEjtnd8VA3vZ1koF7lWBNPNky85N9JfqWrKrt9eu+lYiSJHSGGy902pbsMjsHqwAKmZ5oKxmoE4hgzA3zARFAbFrg1SJeXFvYOh0y7G/vY3UdlGVGkkyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731477419; c=relaxed/simple;
	bh=zNTaW9f8/sU1MZBB5XvQtDviSElhUS1O4r6zJ6lf/ac=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F1bDn+en26IlExjiSMlxn9hS1eale8yhmCT1w8ssZ0g8+q8p4UnJ1W5nfihU0XtQUGEamGkP8E1Pe2GCBnWn//AWEVKSGFuKKEkn8xXtu8bSd8Uk+QnjS4hXIIVuBnoakUX15J1g7ftIsgXrzEdxqHUb81AEy0zPfBBaADnJDw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l/i7Luov; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l/i7Luov"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731477418; x=1763013418;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=zNTaW9f8/sU1MZBB5XvQtDviSElhUS1O4r6zJ6lf/ac=;
  b=l/i7LuovWh47hM1ZmP26fFju+sI+N6Zm672VEYviYkVCJcDrL/1rfHAk
   xCp3v7HANlfOyQwBANZHVfMNzz5GIe3Wg9RZ9oKGtGbf4clnkF36CyB7Y
   OyS2o2UmhLBQ4CdWDAefuMskehfpP1Q22B/orwS+0+3pdqc88I6DIQBgt
   wnIPr4rhixtxIdqV2Dj9aMUXatsU8X2b4NrtVxk1o39RUhDJKpxtt8MHy
   6CzndmxUZITgODlxSD2jP3QUaKdFL28Y0EnvOTLcRS6pOO/65wcw9h5Hb
   y5bqsNrrWTIWdW346w/CBnZwzYSdxlix6mnh06qYn8ILYGBIDgEF8HJ11
   Q==;
X-CSE-ConnectionGUID: XWMNg5lmS+m5g4N6s+OEeA==
X-CSE-MsgGUID: U7VwHZGnQvWxqAtybwFkPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="56743439"
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="56743439"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 21:56:49 -0800
X-CSE-ConnectionGUID: XdA2ReRcQxaJO7t3Ee24zA==
X-CSE-MsgGUID: jsC9TSZ3TT+KjHh1fgEm6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="92714402"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Nov 2024 21:56:49 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 12 Nov 2024 21:56:48 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 12 Nov 2024 21:56:48 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 12 Nov 2024 21:56:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o539vD8cMG12fHDUTtB7q3HDuMQKvTy6P1Ub1V0g+il02xdaL1UPudtbkChIGpu+2owvrOlY3wRZgOV1KyV3ab0asPsahYKTBDutMolK4Ed+4OuPoif8sQ6vAtHYE3wsdLG9Wf2JdWEmiDS4O2q/H0JVz/ITnuebTNzZ6s6Wt1g7nFNhDFo836bma97B1zPL83+NMI95JEKADZEnCIRs3UsbW+inCIURUf+Udu1eUdayQZiwn2kRFQhi7UhBwvLvheAkpGqTqlp0fGoBeymwo4h9KXez1fDofjA5OTJY8l3SQX8RfftKy8Ue/wgPv0kuzRafYoXX0w5QZHO+lQLHww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNTaW9f8/sU1MZBB5XvQtDviSElhUS1O4r6zJ6lf/ac=;
 b=kEe6z5hFwa+5vYu9UR1kUaVebyMdTJ6yjTt5uGffPJZljtyg6PDzQTuvQLSoWZ6OWV8Wvs68kr71jOjlm/FW/W7jxvXo8inJnxfzd8MnlCc+Sy6lrJGnot7Nnxqtqonm/t914qU8c8Ghr4ElAbNw0xat+/3bYFTwtI3Gxfiv4r5bCBiAbOJXRsloE5a2QCioq7T4cp+AAa2FzNMafIRfK3mseQuAaC2dkq8lYNUp6xdCofcTbFw7ZpC7LIR0cR9TJZuv5Hroakdg3kUjbcee2DLH6s3ZGnA9LtNtpfZyS58LgT7PNHMMqVudgAwLwZcCJaOCOnjb3dM2F+g5/j9FSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by CH0PR11MB5316.namprd11.prod.outlook.com (2603:10b6:610:bf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 05:56:46 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d%4]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 05:56:46 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Xenomai community call on Wednesday,  Nov 13, 2024, UTC 7:00 AM
Thread-Topic: Xenomai community call on Wednesday,  Nov 13, 2024, UTC 7:00 AM
Thread-Index: AQHbNZDSWBAAeWZUnESGvE1yBFUGJA==
Date: Wed, 13 Nov 2024 05:56:45 +0000
Message-ID: <PH7PR11MB7499E32BB1968236810DF6B3F25A2@PH7PR11MB7499.namprd11.prod.outlook.com>
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
In-Reply-To: <PH7PR11MB74993258CAA8CDDA598B287DF2542@PH7PR11MB7499.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|CH0PR11MB5316:EE_
x-ms-office365-filtering-correlation-id: e28daf7f-6bfb-47a4-ba11-08dd03a7f4e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WVBpdUJQSGVhKy9ib2NwUDJpb2FRaDFqd0Rma3YrRk1BSlRHdUUyaWUvbHY1?=
 =?utf-8?B?M1ZZMFFlMDBTc3N1L3JobEYzSlFlUmhlTCt2Y2hGOFp6Q3pWb0M2TmxQVmYv?=
 =?utf-8?B?ZDFDb1Z0RHBwQUZYUlRGaU8yZjZOQ3VERUZyRk5CUC81TWtTYldaUkJPUnh1?=
 =?utf-8?B?TDRUeXZRRnRPczNOZEtqUThmc0kvcno3TTZ5cTB1aGUzMVBUOUVmOEJKSlBl?=
 =?utf-8?B?Q1ZjNGNzRVM1RW9HeFMvSFNoNGgxUlQ3enZ2dG1JdStzeE9ySVdkdHhsbXph?=
 =?utf-8?B?RFJ6d3FHWlQ0elFybGd4WXU1UWk5K0J2U0JBRFZRK1Q2Q3R1QUlhS1hHczV1?=
 =?utf-8?B?ZzNHYTg2b3VObWV6dDlBUG9Zd3BFK3NtNDFMRTFWdmp5b3JkSWtZVmNESW0z?=
 =?utf-8?B?aEdNRW91bzA3ZVFENHppMDVEbTd4bWNBTjRNdG5kRGRIUHdBMmdtYkRCalVp?=
 =?utf-8?B?SElWdytJT1Uvams3NmlRb2p2SS9VdElua3RhYytuaXlMOXVUKy83eExHajcz?=
 =?utf-8?B?SGRpNmZ1a1ptOHhpRm5GRSszNlllUUpyNjd1VGpDRkFZdnRNSmwrL3A3R0dD?=
 =?utf-8?B?SDNlVkdCeW5YbVR3UWpMeWhxZmVabEpjTkd4MHZFUU9qd2hMdFA4bmlRamY4?=
 =?utf-8?B?RjFqK3VPR1RHSTRzWEh4TmpIZ21la3NuMFFDcU1xNjUzN05vdVVxWmdweVQw?=
 =?utf-8?B?ZWtNd3o1YnV6OUdBU1Rqb0w3ajZVQklGdHR0QTgrU3lsRnpqWVNoOXZRVzVI?=
 =?utf-8?B?cy9DUE1iNGYvbDg1VVR6WXFBZ3JDNHRSdDZHNTZ5V1psSnRNRlNyTitaRHhS?=
 =?utf-8?B?d1NmeWJrSXZldFpGOXVVZHJibm5qYjlUbzM2RXczcWtGRUdPWlFvMWp6dWNC?=
 =?utf-8?B?ZCtCOEN5aGU1T0tENjBJc3dYK2x5aXgvQjRESVkzaGVoRk9ZL0FqTmcwUE1B?=
 =?utf-8?B?UWVYcHc0bjRvenZuRkNZZFc2bVRSWkJjWXROMnUrTlYxUERHdzBUWnRIamlJ?=
 =?utf-8?B?T1lNdVVlYjB0ZmZlTzY3OGlxU2h5TlRUSy9wRElpa280Mno5ditLNXROZVlm?=
 =?utf-8?B?RnBHMWtjM1gvaW5NbGUyZEp1aTZxaUhQbTUyLzZMWjFDanZBSk44dUppc1Rk?=
 =?utf-8?B?bEVGVk56a1ZQKzkvNlRtWXY2M01GSVJ4Z1I3VWM2K0hySU1DeHE1a1drZ0Fy?=
 =?utf-8?B?QjJoWEhVTGprZXJnb3hKb1liQlZhTmdOTXlXWU5lamczdXBFT1VCT2FQT1Va?=
 =?utf-8?B?Q2xTWHE3ZzJ1eXZZaGhiVEhRWDNOeStiaE4yaEw1ejNYelBjaFRrdVJZbEZn?=
 =?utf-8?B?NDFOS2RsMkpQckd0SlAzRzJYQ3puQS91b1JBWW1BbVVtZU9HWm0zSktVay84?=
 =?utf-8?B?WUdaSHBuMjM0ZEdMcGhhWHJZdzdEZzdLWGJXOFJyNUExUUVLVnlCd2JDdDJR?=
 =?utf-8?B?MWVaSDdvNXdjbmtxYW1kUWpDS1RsRkRWSW9Idk9UVmxXYkFLQXRoYi9lQ2Fv?=
 =?utf-8?B?dXd2WHh5MTczdWxtdnZIbjlnbjA5Mlg4bUJxbFRVaVc1WVljeHkzUkEvN1RY?=
 =?utf-8?B?QnMyZkpYeER1NmZnaFBsWVVRdzJpTDBFOFBkZk9YRHFONVUwdlZQLy84UjI3?=
 =?utf-8?B?NEYrWGltWCs0MHBlakwxUGIwbFQ2VU56OEJZbmZHWmpLc1lUeXgwc0xMTVRo?=
 =?utf-8?B?QnVVTE1iejl0bWxSRTVIWVY4L0swUC9yMlJoU0V5VlNuQkFQa24xcEdZeTh0?=
 =?utf-8?Q?NOmnRVZ2tLHOhTN49JCuGMPmY0BsltlQkirpGeL?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnR0Sm10eE1ScUlJQVVhc2RGaWNOOHZjOURsTWJLN0lpaHdtNVd6RjdaNi9B?=
 =?utf-8?B?Q1pneG45MHFYNit2KzBhMnBzQWZ1ZHhzRFpGckxOcm5OaDEzMUdXaFR2TWxh?=
 =?utf-8?B?SHNhZEY3ZzF2OFVnZytpeGwvUnFxNTJ2cVd3dTRMbjdWSjgzVHFTMTF3SE5C?=
 =?utf-8?B?VHRjQ00zL3VuQnA4MEpTb1ZwOUNnbjJDa0xmZEpnU0tsdjlNYW9RUjZvMzBi?=
 =?utf-8?B?U3BwR2tLZzVZR0IwTTVZcmRHY2NETnJCOGlJbkR3Rml6bXNnZ1lIU0VRRVZK?=
 =?utf-8?B?b0d3RmZnVDdKMXpUdVR6T2tJdTBaUXNmd2hTSy9VZVhvS050Mk1qVmpycHNs?=
 =?utf-8?B?SG5sTjdZNWxaYUh5akUzY0tFNENuZjhjbWtZMVNyRmk0bjJza0JUdGhIek9H?=
 =?utf-8?B?eXhFcmk2QWkwbU5mZnlTOTRaMURHdVVCZnpBZFFYMkhPQ1dkNzhTcDRoTmpJ?=
 =?utf-8?B?VjE5cUU0anBNVnNYMzlYcXk4QVN3dGNJTnpHdkJaem5PbXE1YStudTVjUlla?=
 =?utf-8?B?cGN2RCtCOWU3dVhJMXJ1RE1aMDlmQ09hMjlQelFsWjdkMVVUREw3UUlHcU9H?=
 =?utf-8?B?VlFZZW9BbVZ6U2JlbWsxZzd3L052a1drNVZDSXJrcUc0VXNjb0FGLzhGZXdj?=
 =?utf-8?B?bnQrbTBteFBXcVBZL1hNb2tlaDl1TjVocTA3M0RlYzFxSlZTZFJPTGxYK2I2?=
 =?utf-8?B?SERicVgxYzhOWnJ0TTZoc29OMUJsYnM0alpqQk1oTkxoSXBvUGcwbnZtaXNq?=
 =?utf-8?B?Rkd2QXh1TDJyaGRtR2JjMHF3YlVLVG1QV2FHMFljaldpMWhWajRNemljbVFa?=
 =?utf-8?B?Y0dOTzJKSkpnM1U1TDd6Y3l1aVV1NFhWbUkweWdLdlI1OWZSWlZTR2owWWNB?=
 =?utf-8?B?VFBCeFBRNWYxWWViYVZLMWV1VHExVUdqblFEaWhwVVdBcFJ1aFVNemtBUEdO?=
 =?utf-8?B?ZXc2SnRTMWR5R3QrQk81NHZqSnRodGxQU1dPZ0tUQ1hGbE41NFpuNzVLUjZy?=
 =?utf-8?B?TFF6RjByeHlmanNXMm9POEdIY0h0UWpLWGRJeC9tbTVGUVJRTFVGUlQyVUZp?=
 =?utf-8?B?MW5IMU9NSko0a0o5ZWNKUm5OSkUvNG1VWlpBMHRWcWdaUUo4b3gxck9nZTF0?=
 =?utf-8?B?TkJBVzgvY3NKL3J6dGFaRFlROHNnaU9UYlVacE9DYmFPOWtnQVRjWTFZdjRY?=
 =?utf-8?B?bVY5MFpleU04TGhoK1JjK1FudlgvcWxwTW9ha1JGbkJHaFgxWjVBNG8vYjh4?=
 =?utf-8?B?SXhmdG1scUNSaTd4TGpkc2RIdUhLT0pqR2hIWEN1QXJ0eHczamFwUzdFemhx?=
 =?utf-8?B?UDJNVzlXWml5OFVESExxc1YvbytEVmh2Withbi9GbXo4N1BrUmFpR0d1VHVT?=
 =?utf-8?B?c3JVWElySG9NcG9nc1h1Sy9HSWV5cmJaNGtoS1pXZkdSVlErT3JWWHd3UnU4?=
 =?utf-8?B?RW9IYnF1OWRUTnh1dzNTODlTZmtIYVcvVm9lcUo2dFUyY2ZBRHBvSWwwa1Nn?=
 =?utf-8?B?YW1YTVpySGwweVR4T21ydU4xSkVoNE9LL3BzeTVxYU1ZNXJvYXBYalM4Z3VO?=
 =?utf-8?B?RFR1WllSL096eHhzcmRLMk5NMmFzMUVKQTZjSENqOGI3VEZqZGlJMnU4T3dZ?=
 =?utf-8?B?c3JrNGpncURJdENseGZoWVJ2VEJNd1dQclpvcE9FenM0MEVGb3dmZmdMRGdx?=
 =?utf-8?B?UGtrMHhVN0EzTTBaVXJVOGpkc1lENXNUSnMxT1hjU212Z05KRWZpSDBLK2xw?=
 =?utf-8?B?eEFobDBUZmpYdG4rc3hyOFBCam53SVpla1FSd2Joc1Z0NnpVblFyOG91NTQ2?=
 =?utf-8?B?Y2RadG1KQVNBNkEzWDZ0QTZGd0MwaFpGTjFWS0xSNktBYUlPSEQ2MW9maUUv?=
 =?utf-8?B?RThwcy8xbG82MjVKaEFKc1RsQXJLcllUcUFQQ21EdFJtK1pCL1VMaE9EMTR4?=
 =?utf-8?B?dVZRT3BHazRHaFZ4SzBFODNOTE9Wd2QzY1Y5RzRsd1NnUkREbnZzZEVINTVv?=
 =?utf-8?B?S1ZJanNHRnRSejI0ZG1UTno3QzhobzMzUTRUNjhtdS9UaU9RR0VwMVRDbno3?=
 =?utf-8?B?V0dybi9COTNyRnpvZzIzdTB0SEdVY0pKektIcHJKMmdVQzBIM2hEcTc1Tlg3?=
 =?utf-8?Q?wniAzIlA5qD1KDS5fWjVXvIWl?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e28daf7f-6bfb-47a4-ba11-08dd03a7f4e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 05:56:45.9286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WZMBNNQ7QOyG4wW23i/17Uk5cawhQ8b5qZOW050e9Z3hKcL6oLgL/mRAu79lORKa/k7JpbGDM5xkQO3QTnUOBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5316
X-OriginatorOrg: intel.com

DQpUb3BpY3MgbWF5IGluY2x1ZGUgYnV0IGFyZSBub3QgbGltaXRlZCB0byB1cHN0cmVhbS9kb3du
c3RyZWFtIHByb2plY3QgDQpwbGFucywgc3RhdHVzIHVwZGF0ZXMsIGFuZCB0ZWNobmljYWwgZGlz
Y3Vzc2lvbnMuIEl0J3MgYW4gb3BlbiBvbmxpbmUgDQptZWV0aW5nIHRoYXQgYW55b25lIGNhbiBq
b2luIGFuZCBhc2sgcXVlc3Rpb25zLg0KDQpUaW1lOg0KV2VkbmVzZGF5LCBOb3YgMTMsIDIwMjQs
IFVUQyA3OjAwIEFNDQpQYXJpcywgRnJhbmNlIENFU1QgODowMCBBTQ0KQ2hpbmEgQ1NUIDM6MDAg
UE0NCg0KSm9pbiBab29tIE1lZXRpbmcgDQpodHRwczovL2ludGVsLnpvb20udXMvai85MTI5NzI3
OTI2OT9wd2Q9V21kd1MwcERPRFJOTVM5dFFrNTRZMWR2YkZscVVUMDkNCk9yDQpodHRwczovL2lu
dGVsLnpvb20udXMvd2Mvam9pbi85MTI5NzI3OTI2OT93cGs9d2NwazUyYTlmOTZkOTg5ZTdlMjBi
NjI4YzJjMzZlNDhiNjhlDQoNCk1lZXRpbmcgSUQ6IDkxMiA5NzI3IDkyNjkNClBhc3Njb2RlOiAz
Njc1MjgNCg0KDQpSZWdhcmRzDQoNCkhvbmd6aGFuIENoZW4NCg==
