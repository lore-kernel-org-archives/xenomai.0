Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FE122540B
	for <xenomai@lists.linux.dev>; Wed, 11 Jun 2025 06:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749624236; cv=fail; b=pQQl3IL6JEc2qGGSRFHUmiEXYXdoSP/j/bdPE/n7Ct3vc622RfIPO4+HoX2t20Meg3L9XoO1xR4d4lnL9r1C0hj/v4Sb/SD5hwTJ0cgZfLx7pUqx1xkkS7UbNc6M65Nniuag6txU9HQXDicXE9/WmkmMzMgRYEKh5Mh37Q0PPZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749624236; c=relaxed/simple;
	bh=P+4syppEx/PHy1vjUvojOA6N2DQm87cmOAqKm0f22I8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=crfQaUjk/xs4fNxK7scztacQWxqEwQyUY5Le8o5DymueZydchbvr9Y7hIAOcEOLz5HEEDGw3dFatvdx954KftoS3SiUXxuqWpheQRcfVuIRTchCGWp5FK0oP2f+kq3bjtfLkSQ6ySDKDk0or269Jt4mmO6l55jlV8RP4OLACJv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=npkdkcWC; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="npkdkcWC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749624234; x=1781160234;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=P+4syppEx/PHy1vjUvojOA6N2DQm87cmOAqKm0f22I8=;
  b=npkdkcWCAwDuZ+NqX2hi1emuSmgi3BV4WE9bb6Y0RN0XJ5aEgVZfzaht
   mTiUqCb8hlhynIOXCeoUmM13vSqgUgNCRT4UwB5PKbbzjJxQo+8OHR1N8
   EC4TIv+C8EwlVnY7CHxq1micBaEH5TnjQlCmEgWB1S5KNRN1smEmvh2MH
   6i7TfQcViDtVdrD3I9kSBAXEJsmiz7sgliPmYe3/Tu9iS5PsvKcB787tg
   9ixSHtR0/STnEdvj5Qb9s4mjisgDSFl/3Bw3mX+a2MZD4sF3jbFjehEeu
   LPaYmP2XY+X0BQe7tlljGTTwq6hRwK2cxk9r0gECNgF8f1ile4j3LxgkH
   w==;
X-CSE-ConnectionGUID: Hp4QUQz9S2S/wXC+tbK2tQ==
X-CSE-MsgGUID: ca9MMYWQT9KxGdb9Y/vphw==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="63164902"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="63164902"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 23:43:53 -0700
X-CSE-ConnectionGUID: 8RH2cuhFTnCp9HdZlhPjOA==
X-CSE-MsgGUID: Ijas6T7ARKWdHUfgabmvmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="147441429"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 23:43:52 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 10 Jun 2025 23:43:51 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 10 Jun 2025 23:43:51 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.65)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 10 Jun 2025 23:43:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oKiW+/W5tz0vdw9LFF0Sqvqk5cRHnch1QmqLASa6COcJUwDU7WPhFDp0ebTfiBtdNCUsAxFsOJBDIFawUF4WgPASuTa/nPSH86P8158Nx0KR3SE66HOICb8Hpl+pFB/BVbkVLZJjwzciq3TEsBvo6ffieNP18bFo/fJcm49L10zZzaPpExXyZ8Riqpp4AE15H5oHn1fMy0z6/7zi+U8pi4LvsO/RcTOAGLHPcm8BL7AFk0MhAneHw1jQK6cn/ElsilTCCkJs80i6+/NzHly5Y+M1ljeIheduaaiQwG+Bn40iGwVQEiITzayf+vHCO9bUFd5knPU85SxfT2UA2Ize8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+4syppEx/PHy1vjUvojOA6N2DQm87cmOAqKm0f22I8=;
 b=vDL1jzAxxqkW0TuFDE+P5+mlcnbl2OfuCui/i+25WT4QKWdh5KGg353Oqbit5MOHS28LSIAS4ozbMrToq8ggzS6/O/BqQxpauh93S59fhujBcFj4ZTkt2XrUMK4aKoossYjt0Xpg7Dfi8Cz7Y4L5dECYvwWs4LR1ZysT3zJxIA0QZUGpVGIBeOhST+Y+N+Q704GXU006uP9vVoppbaqyjZx3OS6pHPU6limTIAaBOKpUKJhO1zQnGfswdciesZbWcwUnCnzRycmGLMGMBUL2BcgahxAB9Ctcap+Ol7YJdGEAzxGI2/C7ajUqsvitJrdtJEuBnHhfJav8IRnIM8Yw2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by SJ5PPF6E320AF71.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::833) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Wed, 11 Jun
 2025 06:43:35 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d%5]) with mapi id 15.20.8835.018; Wed, 11 Jun 2025
 06:43:35 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, xenomai <xenomai@lists.linux.dev>
Subject: RE: Reminder: Xenomai community call on Wednesday, Jun 11, 2025, UTC
 7:30 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday, Jun 11, 2025, UTC
 7:30 AM
Thread-Index: AQHb2oiDcrn8q/S4tUSyZ89kHI2pDrP9XkeAgAAk2kA=
Date: Wed, 11 Jun 2025 06:43:35 +0000
Message-ID: <PH7PR11MB7499E06F17FE11333D3CECFEF275A@PH7PR11MB7499.namprd11.prod.outlook.com>
References: <PH7PR11MB7499F7DDE006A3A7291F61FAF27B2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499E7C229D3943554AE31B6F23E2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74997A20364527E81370A33FF2122@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74998618D1F5B701C8C07330F2F72@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749901F0793C63043273F166F2C52@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499534189182B1B56FDC426F2CB2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499D5045E7CD5CC207EADB5F2D92@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74997D0A2A025EBDE30826D6F2BD2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74998FCA330C96F94503AF18F2832@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499BABF9BDA783C86090B60F291A@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499C2C6A4E4E6239A05C979F267A@PH7PR11MB7499.namprd11.prod.outlook.com>
 <SN7PR11MB7489BEF822E21923EE582FD1F275A@SN7PR11MB7489.namprd11.prod.outlook.com>
 <89f06095-d612-41e6-a86c-6ad9e7d16aee@siemens.com>
In-Reply-To: <89f06095-d612-41e6-a86c-6ad9e7d16aee@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|SJ5PPF6E320AF71:EE_
x-ms-office365-filtering-correlation-id: fd17f719-73bd-4e73-696e-08dda8b34a08
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RHBtZmNMRk9OaHBKSHRGaGNMc0Jha1hqS05OSlNoeTBWUDlsdnV0RGc2eEx0?=
 =?utf-8?B?QzB2S1FLeHpNQ0dMblBSTmJnNE9ubWM0blVVYTl6UFoybmlJaXhFeEZLMG1o?=
 =?utf-8?B?MVVrWWlDckN0TThWYWlFR1pyaSt3anI2TFpTUnluYkVLbEYyMGk4YzlWN1ZJ?=
 =?utf-8?B?Q2g2WW5NdlE4Wi8rMFlLUlBkdHQ2VzZHb2RpRkN3NHVRZUZuZnJ2MHpaRU1R?=
 =?utf-8?B?WEZIK0lJSVhEMFJqcThlVEd2QnlEM21taWhCUUgrMXhlcUE2eWx1Rjk1R2pC?=
 =?utf-8?B?Y2dVSWJyTm1UU0RmMnVxZ1c1S3VraGlkcm1UT3ZydXBrbTJMQ3JlLyswUzBh?=
 =?utf-8?B?VG55WStiVWpLMU1iVFR2THJIaXpzMUNDZUFDZTA1ZUwwUGJQbnF0WXZCbVlj?=
 =?utf-8?B?Zzh3N25UN2FLMFZsQlo1WDZJaXFzZHRlU2g1T3Vxd3pIeHBvYXdZdWhyM1ph?=
 =?utf-8?B?TEM0VW1EQmhCSHJER253VlBFU0EwMDFXNkd2OVZvMHJhcXJBd1FaTVgrVEwv?=
 =?utf-8?B?czkyaXVvbXY5RzBOZmRYZURKK3ZCbE1SQlJEa0I1enQwWlROdC9TMEpjTWVk?=
 =?utf-8?B?Q2w4N3B5eE9JT3hEZjd5Q2pKb3kwYlJFdmlBWmRtZ3VIVUhaVHBtTXIySnRu?=
 =?utf-8?B?VGpuUVdlODkvd2FPb0w2ZmdGZ0gvdWZQT1RTTndHTGRQbmVGMWdIRENwTFVD?=
 =?utf-8?B?TzQ0d2pnSlJoZUNEa3FqMGFVYXN6RnluYWVLN0lIdklXTEErVnljTkVRNFRu?=
 =?utf-8?B?V25wOEZaNHJYSXB0cXkzc1V3VmdGSU43NE9hWDR1a1Z4SjcwNWo1UW9RdWtN?=
 =?utf-8?B?SmtjRVdlVy9NVVVPOHlDc0MxK2dIUDlRc3ZsWkYyaDA0L0QxMnp4aXlCRklQ?=
 =?utf-8?B?eWZ2V2VLRi9SVitYWk92Um9hVGRlNjdLUnhTQ3JaTytPTFBhcEJQbUlHNFBF?=
 =?utf-8?B?T0FSRGoyaEVJMDQ3UzVFcGJIL0V3Tml6SXprR0hKTjUyY1ZrSm9NNlA3VkRN?=
 =?utf-8?B?QzM5VkVUWGtONlZ4cG5wdWYwaitsZlZSeFhPNmFYMmt0VEEwQmF6K0RsWk4z?=
 =?utf-8?B?NWFBcjRRajFKWk1temd3OHBMWnhZMlBGWWRQK1VEREdEbzBSMVl6RW1kTUFW?=
 =?utf-8?B?b1hRYnphYXd0aUxwejdsK3d5ZzVZRFBPVWtCN2tYQjNTcW1MMkZ0UE82cWYr?=
 =?utf-8?B?dzNxV1RaRW4zTFRLM0JIc2RGWk9mWWc1QVRRd0t3ZkhrVjJzaW1udEc3ZXZ3?=
 =?utf-8?B?ZDRSUTNQS0FHNWUzS2dPRFRMd2lIR0Z5eVNBNndBZWpDaFVSTjB0THR3ZEdv?=
 =?utf-8?B?ZjVndmRZUzErSnptK2JLMlE5R0JJbk8vYVZhUVpJaHJ5OWFQMUh3MCtMeHRs?=
 =?utf-8?B?dElKclBDc2dIYzJjdXFTT0dFakdWVWUyNm96cEpkVHFCRmhtZU1SblBNajBS?=
 =?utf-8?B?VTBHeWtUeTZHRTFwOS9pNzhWMEgwY01tZjJlSTF1Z1JTcUhzU1VQNGdFU0h3?=
 =?utf-8?B?T3B1Y2FRbVV4WXVJQW1CaEEwR0dKVFBVMUlVUm56azJHaDZrVzFmOHJzMTJw?=
 =?utf-8?B?ZXM3VzVrUVRrdkQzZ3ZzbDNMQVcxdm9reVZnNmZPSkxrcWg4a01iTUVlNE91?=
 =?utf-8?B?NVF2ZCs0bHRDTDJCdVNaM1ZZTXhyeXdacXlTWDFQeXg4aWRCbjhHU2tvb2tS?=
 =?utf-8?B?dWdXeS9TbU1SV0o5TDdrT2F2V2dyQUZxdkVUbXNwR0d3WE1lNnhLR1BBT05v?=
 =?utf-8?B?eVlYNVNXSUhkcms1ekZvRG1kNGVwTzlZZEt0c05uMWtHbk1TN3N5ME10Q3hq?=
 =?utf-8?B?V2p2VHZsaTlRWm02RTQ1Q1Q0cm5WNnAzUHhDVk1VSjlqSDVtc3p2OGt1N3k4?=
 =?utf-8?B?SHY1dnFaVllGbm1YVGZhYzVQUjRCV25Vc3g5SDYrMlFTM1l3dGJZd0JBaFRQ?=
 =?utf-8?Q?GMmQqWI/jwA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0pEZ2hMNGU4NWIvWTlYbWNra25qOWZRRUVTSHpqNkZOZ2FQWnRTcDF1bHE0?=
 =?utf-8?B?enZ1YXV4YXVMR3ZBRy8xVlRORWZWUHVoaXpwTWY5Y1R0and3aUM2TzBUNUxV?=
 =?utf-8?B?dXlZUEoyZGtvSlhmWUJkeFBoWXF1ZzJMNU5UblNlZTJGcWM4VllEU3VUd2NG?=
 =?utf-8?B?YUZ2OFFWNER4N3ZIVkt3QjNRUVorZHpJSzRuT0owKy9yOEJ6Y2JaQXphOEdE?=
 =?utf-8?B?UHcySThGR0NXSy96WXBDWEpLc2VPSGxRajJvWUwrWG1veWxFbDRRVkpqaE5k?=
 =?utf-8?B?UWhtMytWcU5iZWd1VzdXUmIwNGVzMkxnbWcvd2tIeWVKdnpYck5wZWVzUDhO?=
 =?utf-8?B?NE9Rc0ozdlNvQUJ3VDF1SXJDSzNzQlowTXBDbEhhaUQyWFQ4M3BvUmZ3NTdT?=
 =?utf-8?B?azNtbnBmSWh3WEJMVUJSckhHZGFEVCtKOFB6U2Z2a1FiSVhFM3RJUkVPSS9h?=
 =?utf-8?B?N1hhc3hSbkZ1WmlWYkhEVjhwWmNUcDJPNHBmU3BQV3BiblN3NnhpdGptS0Vu?=
 =?utf-8?B?RVVwRFZNMldWOWRsRDhjNkFNVG5aK21jVGZTNFpQeDJwQ2lqY2JrZk5YMW5i?=
 =?utf-8?B?VVowL2NCcm5MQTIvQXZrOExWVnA4TlhrWXdkT2J2Zi94cmdWN05FaXlsWE91?=
 =?utf-8?B?TktDcU84czBJTFhMcWtHVDF1cGVBZnVtOFVQKzc3Sy85UWpVVmZvWUtUQzht?=
 =?utf-8?B?Umw3UjExbThQRWZMdjNuMkt0b2lpVm1TcDI1WFFjelFTbDhQMm0xWmpIUHMv?=
 =?utf-8?B?TThyU2d2UGhJcHVZei9OKzUxTjJ5c1BHRm1ZTDNlZVQ4dzB0a0dEemFUWk9k?=
 =?utf-8?B?bTlEMW9yZnR5cnpVOWpYMGtoTU9zNFNicVl0S0lXeXNwNW92UnRocFdUMk8v?=
 =?utf-8?B?TVVhQ1ZWUlJHdEFFOGNUbHdFc3RadDJxOXFYSG5DUTBnNmtwZ1pEOU9qNDlX?=
 =?utf-8?B?LzZMMXM3Ry9iWGpYOU1ZckxnWnRDeDJSOUZid3RhWVRKR2d3ZUNMNVoxeG1l?=
 =?utf-8?B?RWRwamNNMm9QZ1dGbGpkQUxrKzN0WEFYYWtDaFEzNWRnRDJBZ1ZIQVB3ZW1I?=
 =?utf-8?B?S2c3bE9FaU5pajJOR25HeGduQnRiZHdmRDlnaFRJbzdJdzVzYVcyZWI3SlRn?=
 =?utf-8?B?dUJLL3JnWWVxTmxqdkoyYkVHcmlSK1NrOEI5YlVCdldvTDZGSGxBbUZDZmZq?=
 =?utf-8?B?WjRHbjVwWTllMFlkM2pNaTJtOVFPQms2QlFpOU4xWDdES1B4Mjc5Szh6VFZm?=
 =?utf-8?B?SUtvaUVZMkc0eEs3NytyU0RNd3hsTVZnQ3VoWXQxazB0MzNVNmYvVGxPTE84?=
 =?utf-8?B?b3RzTXVyOXc2MW9SYlBZSTVWaXFWNXJCbHJyTTgwOHN0RHM3YkloQlFxZmpj?=
 =?utf-8?B?VE1WVHB2UTZZZSt6WUFXbVBTdkpWSkhjQVJzVzVhUFVXUEtMd3dRWEo1Sis4?=
 =?utf-8?B?RVZDTHFHT1RmQVp0OTMrNGV0NWZwRUh1MEd0Snh5SkNCV2hUbHR5MkRLTzBt?=
 =?utf-8?B?dE5HL2VjRnB4K1NIQnZvaERaQVd3ODN5UVZ1Z2t2T0tybHBCU241WVZQNXV6?=
 =?utf-8?B?V2VWNFVZbGg5RHBvSHN6NjMzRmRVZ2NmNDlJbGFQaXdqTmZOMm0xYW5LME43?=
 =?utf-8?B?U2phY1hjT1IwdUNVL0ZScXNLeUtOWjV4S3Q5MCtjZU83VSttOWhHcE9HakJn?=
 =?utf-8?B?aTN2MTVrWFhVTEtwQ0ZKdFpKRU1ucWY5cjlPYmVwYjQzaGdCSllYU2xoUEZE?=
 =?utf-8?B?VmVvdEducVNzMHphVFVlL1R5YnU5cE5WMkRpUjBybk9lQ0pJWVpDNmkySFor?=
 =?utf-8?B?QStZbmtIYkVsTXAwWkZiTEp0enJRUzQrWHFEaWQwZk5hYktXUjI2dWx0VkpJ?=
 =?utf-8?B?UjF4UGs4V1BLeVk3ZE8xZllPNGFQY0NnQ0VMOU1YZHlDOG9nSnZ4MzZ4b3ll?=
 =?utf-8?B?M3pFcEpLRkJZeTU2Rmo1VnMyWEpnYTRBRytVNUNkelNBU216ck1iNGNOY3RZ?=
 =?utf-8?B?NEFWSzV5Y2I1ZDBDY3ZsMXdrS2pHeUFrTmRIbVpmdVlVT05KbHlDWWxwQ2ZQ?=
 =?utf-8?B?bFFpZU1zWWpWc0J1am1NblBQbWNzMnZ2REhVSVJjd0lQeXlVWDJza0ZCQlNC?=
 =?utf-8?Q?uqyJsnzPIm2o7nVh562mt9V2f?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fd17f719-73bd-4e73-696e-08dda8b34a08
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2025 06:43:35.1075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FUom1C9kpT2zwnGw2XLyeUT1+6E4PoTWgy7+SxuCJYNXnuQliHXBPtrSod1haUUO4R0bs/f70SsGEul4hAKYnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF6E320AF71
X-OriginatorOrg: intel.com

T0suIExldCB1cyBjYW5jZWwgdGhpcyBtZWV0aW5nLg0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj5Gcm9tOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPlNlbnQ6
IFdlZG5lc2RheSwgSnVuZSAxMSwgMjAyNSAxMjozMSBQTQ0KPlRvOiBDaGVuLCBIb25nemhhbiA8
aG9uZ3poYW4uY2hlbkBpbnRlbC5jb20+OyB4ZW5vbWFpDQo+PHhlbm9tYWlAbGlzdHMubGludXgu
ZGV2Pg0KPlN1YmplY3Q6IFJlOiBSZW1pbmRlcjogWGVub21haSBjb21tdW5pdHkgY2FsbCBvbiBX
ZWRuZXNkYXksIEp1biAxMSwgMjAyNSwNCj5VVEMgNzozMCBBTQ0KPg0KPk9uIDExLjA2LjI1IDA2
OjIyLCBDaGVuLCBIb25nemhhbiB3cm90ZToNCj4+DQo+PiBUb3BpY3MgbWF5IGluY2x1ZGUgYnV0
IGFyZSBub3QgbGltaXRlZCB0byB1cHN0cmVhbS9kb3duc3RyZWFtIHByb2plY3QNCj4+IHBsYW5z
LCBzdGF0dXMgdXBkYXRlcywgYW5kIHRlY2huaWNhbCBkaXNjdXNzaW9ucy4gSXQncyBhbiBvcGVu
IG9ubGluZQ0KPj4gbWVldGluZyB0aGF0IGFueW9uZSBjYW4gam9pbiBhbmQgYXNrIHF1ZXN0aW9u
cy4NCj4+DQo+PiBUaW1lOg0KPj4gV2VkbmVzZGF5LCBKdW4gMTEsIDIwMjUsIFVUQyA3OjMwIEFN
DQo+PiBQYXJpcywgRnJhbmNlIENFU1QgOTozMCBBTQ0KPj4gQ2hpbmEgQ1NUIDM6MzAgUE0NCj4+
DQo+PiBKb2luIFpvb20gTWVldGluZw0KPj4NCj5odHRwczovL2ludGVsLnpvb20udXMvai85MTI5
NzI3OTI2OT9wd2Q9V21kd1MwcERPRFJOTVM5dFFrNTRZMWR2Yg0KPkZscVVUMDkNCj4+IE9yDQo+
Pg0KPmh0dHBzOi8vaW50ZWwuem9vbS51cy93Yy9qb2luLzkxMjk3Mjc5MjY5P3dwaz13Y3BrNTJh
OWY5NmQ5ODllN2UyMGI2Mg0KPjhjMmMzNmU0OGI2OGUNCj4+DQo+PiBNZWV0aW5nIElEOiA5MTIg
OTcyNyA5MjY5DQo+PiBQYXNzY29kZTogMzY3NTI4DQo+Pg0KPj4NCj4NCj5Tb3JyeSBmb3IgdGhl
IGxhdGUgbm90aWNlLCBidXQgSSB3aWxsIG5vdCBiZSBhYmxlIHRvIHBhcnRpY2lwYXRlIHRvZGF5
Lg0KPg0KPkphbg0KPg0KPi0tDQo+U2llbWVucyBBRywgRm91bmRhdGlvbmFsIFRlY2hub2xvZ2ll
cw0KPkxpbnV4IEV4cGVydCBDZW50ZXINCg==
