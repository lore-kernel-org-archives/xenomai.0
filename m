Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBAF10953
	for <xenomai@lists.linux.dev>; Thu, 30 May 2024 01:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717031416; cv=fail; b=opi7oqro/TnO3fY4yzVDFIx+ur6JSu16IPhPMtOIQsgAfKi4SiiAfyF1gbjF3IKrGaJZSY+WRZysWPMWcjgICfNmNHeQKXCxB5/MZ0ABJsCNYst7+/NGdB+DyymqS+xnksU4NZwg11yldcPf5HZk5k1bishignRIkTeOzEwZY8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717031416; c=relaxed/simple;
	bh=XtjpDnkAUoKXn5ghKaTe3wmvXIhFqW/hVmBHgmIQtEw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LGt43QALSHdNRQSG9gEWE91+AEJ0TVod5PF3XfOaiFNcgbVuKaEoRxTatLxE0coIEqHVfQe3I5Eufw/GwgxKVjIu6WIN0da3OQmd1fqq0jLgsDqS5QMI2E2FLdX8hnA/1CwZppllYc5QZdHlf2TAP6EXFH/T9ImWAoSvquMasBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O2WTbXfx; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O2WTbXfx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717031414; x=1748567414;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=XtjpDnkAUoKXn5ghKaTe3wmvXIhFqW/hVmBHgmIQtEw=;
  b=O2WTbXfxaSOiVSSdwP+BCtR9VPdrZOsJJ2cSAm8i1rNsfU2d8hQWTL83
   rfbqBYwjEZTL2hAfsB0MK63etIBNYA6HgPNsGWjKOxKlwoovsUwWe8LvF
   BRFGVOtzCPTT1QoikN8VkvRDWy/Ks+ZnuDvTEm/G6qNmPrLH9PEs0P5Xv
   5fJahgNz1A+FXOBHaUFO26FkXTXpO7sHx0g6tpmK7OAbKhKD8C0vy2D4g
   MfW/dj63AXV+qSgxYf9Qc6vI2hH/QHmZEJviM4aRf7S0rLbsFkSUEFn5B
   AEVhrqB5g4HmXVkBTvnUoTAzho2K+dv64BXvxU8ANFfQpqMskUhmB1lEC
   A==;
X-CSE-ConnectionGUID: Ioly4rhfQJedzgN1vTdDDg==
X-CSE-MsgGUID: w4lfCmLSSyOwm1GHfptvMQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="24883891"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="24883891"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 18:10:14 -0700
X-CSE-ConnectionGUID: wm1/LT6KQpySo/5IMZDcjQ==
X-CSE-MsgGUID: Z+Htchj5Ta+HGTDaAXuN+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="58807658"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 May 2024 18:10:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 18:10:13 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 29 May 2024 18:10:13 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 18:10:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJYelnH6EjjFDNh+aD20iVaIuZ8GjEqp3edr5hHuChRPPtxATxSMrDRsDjarB1Z5fog25YOlLX9Vqa8y3Eo2NqYKyJz+lNMgCBNSRVP3ovdJFJRbT6jR4eWvc/45A8xQ2mXOWhMIOvhCo899CA+sSI23YVPs2AzuhDuL/ikG5fk2dWF5HqjUi+67pTOMCASZ5jQqEnoRxBo9kuc0VH9bKR0KpDSW81Yv7D0wu7z3ds+ck7+LjdzxDNCKg4khbEzuEZ5ZXqUbN6nf/MPwHYSJCadodwVM/4QcVI3ZQwtU7nZUnpr3BUy2frnb7B+nCWBeNXuydHXin5/rj8S2KVQiog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtjpDnkAUoKXn5ghKaTe3wmvXIhFqW/hVmBHgmIQtEw=;
 b=WD2AfZsinfnfQ8M6fA1jEz4VJQd16FnbBo7fbVMBPzTCAfZAXboryp6Gmvm6DRh2TBn1MPEuWjgweJrSudY4N7ICWBLXuJa7BbTNjJ1A1D2CmBql5KcFTASinMo3dejP/fPn5HS2Uph9nrGl8ivETNb1TSGbvrhhe9CeiyxPaDFnYzmDnJ4sTCD9gBLYbjiKHjvo0rdpnnIP5ZfNVLxSWknZaeS4NyyFjeeMtyhrMH8J/z7Sp/PwCLpWZpJm0rP0vhjlbrpb8nZCZ4J3tp361Ngmx5lguUygqbdBVxwg1xwYK2EO8/AiCM8cWIHjOtf8HoM07D+XxS7Q4OVSg7iIbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by PH7PR11MB8551.namprd11.prod.outlook.com (2603:10b6:510:30d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.28; Thu, 30 May
 2024 01:10:09 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d%7]) with mapi id 15.20.7611.030; Thu, 30 May 2024
 01:10:09 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Xenomai Community Call Minutes - May 29, 2024
Thread-Topic: Xenomai Community Call Minutes - May 29, 2024
Thread-Index: AQHasi4dG4M7PDFGD0CQUDcGyqiTew==
Date: Thu, 30 May 2024 01:10:09 +0000
Message-ID: <PH7PR11MB74999CE443EE8E36CEC314FAF2F32@PH7PR11MB7499.namprd11.prod.outlook.com>
References: <PH7PR11MB7499F7DDE006A3A7291F61FAF27B2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749929DFFDCFE47376883636F2572@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499F4FFFC62E15096DFF8D3F2562@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749910600BAF97BCB41DC3D3F2202@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74999307830ABE8C6E622DB9F2F22@PH7PR11MB7499.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB74999307830ABE8C6E622DB9F2F22@PH7PR11MB7499.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|PH7PR11MB8551:EE_
x-ms-office365-filtering-correlation-id: a619df2e-f267-4290-110c-08dc80453fdd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?dTRhWnZ1QUtMQnNiT1RFaElJd2oweEZkek9TUVViV2h4dzk0WDBLT2J5dzl6?=
 =?utf-8?B?dllsZG94KzhoODZFemZDMUxBRFpiSXZPdVBqLzJtSG9aZzhKUWZtaitNQ0tm?=
 =?utf-8?B?aFk2R2l3T3JMZ1NhOVY2cDRXTUg1UFcybDRPdm16UnhOclQvNUVMWmpBS1pH?=
 =?utf-8?B?K0ZZSlY3ZGppOGR6d1FabXdTUitFcS9MSFpveDV5MWRRMVBSVXBGcDlrS1dX?=
 =?utf-8?B?UXdiVEs4RFVVQS9xWjgwajdlZVNKamRqSGxYKzJsK0l3NjVHQ0hVMEJuK2xO?=
 =?utf-8?B?UW5OY0wxSExERnpXak1WaVhuTUNZMG5UVC9wMW9xMzEyVmtSbDRQNmdXOGcy?=
 =?utf-8?B?azk3T2luSzl5Q3hFcDhuM1lJS3BKTHVmNnhsM29RdmFLbHk2SVA3RXk3aktU?=
 =?utf-8?B?SEJOT2xUa2RLMHhFZHZCYWJqUGZvcHJOMlFFNUZmNlZuQmd2WEF3OWtEY3Aw?=
 =?utf-8?B?UUhYNVBEZmVUK2tTdDlsemdtNEZqYTBILy90OTdvOHFyT3RwQ3d5eFlXNXBJ?=
 =?utf-8?B?bUMrb0RmNHovRlcyRWZqNGlyS2k3RkJqL3EzUFhCWmFuYVRVV2krZUpEOVZJ?=
 =?utf-8?B?OG1KSGlib1k2OFN3bklSSVVrMWZEZU9tUE45WnFUMnlhZGI1K1V3RCt3K0hB?=
 =?utf-8?B?L1pHWXowS29mcTBrSGlUV0F5OCszTWlPNDcwRWxPNzZxeEFvclZwQ211bmxo?=
 =?utf-8?B?L2l3V2dyZm1FdWdjbkhtdGg2SFN4azFvbTI1S05DQSsvbU5lQnlqNXJCRTEv?=
 =?utf-8?B?WTh5ajFjd1lVcG1pT3hPaEpRWkR3TUpDNmpKV3QvT2dzUktIOTNNczd4NG5z?=
 =?utf-8?B?bFk4TUozZG5MVWNXT1RUZ0RId1RKR2tRdG1JQzUyUjYwMWZBWFQ4RDVNOU0w?=
 =?utf-8?B?OEthbHMyV0JOVEwwemRtQmZiQUVXQXJWbFUwRUxnRmtMZHpGaTR0Tmcyd3Vm?=
 =?utf-8?B?RVBEMkovNWx0SGhwc1lobnhMcCszaVE1aWtlUlQ4YUlaMDNlaWVZS3dzWjd2?=
 =?utf-8?B?bEJXWDNPa2lGaEhuTmJ0b2tYOGV5MzJXckNmcGZVb1hHcERlU1oyMDJhZVA3?=
 =?utf-8?B?djdSNzFENmM1enpYTXFPcUVhclhxYVM0Z0kyaTJSQ01weUtRMElidndyYmtK?=
 =?utf-8?B?M1U5ZnVDdFpjUlYrQmJTTnY5SXJScVpHNjF5ZHhTNFJmWlVvejFVR3JGcGM3?=
 =?utf-8?B?RkdpZWxVOCs2TDRIMHNVL2hkcVBvaVRWemtzZFFoL0ozY2F1WDNjZlgrVDBm?=
 =?utf-8?B?UFZHMVovU2t6S3RoQlV0Z3A4VG9xeWE2VEU1MzhKenZKM3hjNlYxZXVjRG9w?=
 =?utf-8?B?dnFmTFloSFcweEFpWFd3d2R1M0ROOVFSY0wwVEVjM3hoTS95M3BiVGVKa3Nt?=
 =?utf-8?B?TzI5RUh5YXA2QjcvMnNjMkpXaWtHNW5jNVVFUnVxVG53SUtzN3JhWFpldkJj?=
 =?utf-8?B?QlhTL1FvMVBtTTNabk8yUFNob0ZmaVJvTTFJMkRXUXlPYmtyakV3aEtwRTB3?=
 =?utf-8?B?cWM1TnVxM1AzckdGMC8wNkpjS2I3NEdRZXQxU0lWd1Z0eW9Dd3BGSnJKdkQv?=
 =?utf-8?B?TjRBY3REdGNKTEYzcXhQVktiOHRBMW9TZkEvS0hMQXdaam9kRlZzNmxiZlhp?=
 =?utf-8?B?OHpnNHgwam5uOGE1ck5weDZnTHpIemJlVy8yMXRiYjRSYlVXZFBQN0RzbVZ0?=
 =?utf-8?B?T1lTaXVwZk5hTC9UNGEwOVJGL3JwMVZDTzJ6amdsYmViRmhhS0tub3hOSXV4?=
 =?utf-8?B?Y0NBVzdmdWJwRWU4aXRQVFBBeGdzWTE2a2EvZW5jcnRGMnFSOVo2WkJXejJy?=
 =?utf-8?B?VEFhckp3RGI2UWFxa3M1QT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Skg3TFZyOVlwYmtFbFBoWStHajBlaEIxcGgwK2IvOU5oRXhGelJLTHdpTjM0?=
 =?utf-8?B?MG81cnhtRzNqWGRRalVnWi8raHpPTkF5a3VTZEpSVVhrSUx3RXhrWDFsOGNn?=
 =?utf-8?B?ZzRvUncvQjdqa1VnVE5Tbk5rSTFaNllLdE4wOG4xUS8xNDJhb2M3KzdRVFp2?=
 =?utf-8?B?WW8rUFBDYjc4YzBKRnpnaTBRWXpSYWVsR3NBcWNybkplQTkrY0JsOHA3OWhM?=
 =?utf-8?B?SGM3bHJWSVlNSlMrNG9rT29TN2g5OVFpMUlldlFYSk1NYU5PMTlzRHYwbFJM?=
 =?utf-8?B?VTFCeGNvMnR1dkhHZ1gxMjRZYTR6dEY2Z0tiWUpvTVhiTi93ZlZ4Ti9qODlV?=
 =?utf-8?B?UzNXSEEwYStZQ0hDc0dxMXRPZ3FYT0dUVUdLRG1uVzNEU0xDcnBaUHh0bWVN?=
 =?utf-8?B?ZStMckxWRGphbDRIaERjcHRrUGRMcWE5WWJlSlhTL21FYnlxS3ZQSGZtRWxs?=
 =?utf-8?B?MXV1UTQ1WGNSS28xVTVxYXhiMXZITHJDTEl1S212SlZOUjloR21qYUx3RkdM?=
 =?utf-8?B?OXdGT28zOExOUEJXTFJSVzVWeGF5VWNHTXBEV0t2N3VSMi9Kd0NLUmxtazJh?=
 =?utf-8?B?YXZ0eFBEMWtkNzZIUE9kOFpockxJZ1ZPY1dtTE1UTFJ2bm5lK1grMVh3aWx0?=
 =?utf-8?B?WE5LdjNoQ09qbmlkMEtyTitCemVUa2grQXVHLytYb0tQUkRIeVJDKzYvNDhQ?=
 =?utf-8?B?bHY2OFhVbnNtcWF6bTRYS3lPaE16OWx0R2IwWndCT0dFekNGYVJYNW9XVUpK?=
 =?utf-8?B?R25WY1A4WlVxOXkzbi9TRXcwSmtIQUhIVkI3REFpeUl1UXZrWmRWTEp3UWhK?=
 =?utf-8?B?Z2hCTjVZaXZvMk0wdExiY3o5ekVZTFh1SWprY01lalBueGphd2U5Y0M0dDQz?=
 =?utf-8?B?VllBQ0dWVitOL05qSFk1WXhUeWpCekR6KzZRRVdKS1YwOUpzY0ZhNUFFbXh6?=
 =?utf-8?B?L1N0S1FuQzV2MVBUSDFYalgzZDd2ZG04NFc5MUNUT2luamNLbDA3c3lVZjFK?=
 =?utf-8?B?VFpKQ2l5WmlOaTByR0RiVTU3MHZtNkI4OUtVWXNzdUZCQ21TbG5oUzFwbjN1?=
 =?utf-8?B?bzJmdVV3VWEvVkdKODJzREI2RW5JNlNrUUJqWmw1eHFSMjNrVzlwSUlvMUZG?=
 =?utf-8?B?SktOdnFpOW9WWDVLbURmb1VEcGwrcmgrWTJpSjFZRTF3QU5Fd1FtODE5NWFC?=
 =?utf-8?B?dU1icnpyb3pvQ0NJWlpZa3BCLzZ5UUtIemtHb1J5OFV4MzZIMXpRZk01ZEhO?=
 =?utf-8?B?dmxEQ0U2clVteklpbFFsRzZVZURXOW8vVEVxei9EWTFLZkpQZFRUSFlmRzlx?=
 =?utf-8?B?MmFhTG9UWHBoako4OGtlTUZweXdrV2diZW56a2RQY1JjZXoyNnVJRVZpUG5R?=
 =?utf-8?B?OXgxeWgxYkJOUFNVL1B1cCtFcXN5b0RqaXZrN1Jnd0lNdVUwQ1NqcWZOcjZF?=
 =?utf-8?B?SVdjZHNJaFNaODkwM1ZkNzNkeWRlR1N3TWkwNlk4SVU4N3hjTjlvQU1NcVc4?=
 =?utf-8?B?MWFDTTluY0xNbFVQVjVRaFhqejQ5UHIzdVM2bHVaV3gyVndWbG11VHh3U2RL?=
 =?utf-8?B?dlcxNmlNVlo0Yk54OU5ETEd2ZnUyc2Z1MnJKSVpYVlYrbzJiMnVaV2wxQ0c3?=
 =?utf-8?B?eTZlM1JyTFlBL09CWkpaeDVnMVZzT2dmL3pxd212SllyUU13YXpNVmFiT3Y0?=
 =?utf-8?B?UjdKaVV2VDBQb1JDR2pma2J0VU96ZmN4dEZXWVhvbnZyWGpVQXJZd2xiNTNR?=
 =?utf-8?B?dEthOXZ1V3U0UjhwY3dYSjc5YmdieDRRaFg0RER3QzJRMmNyZ3o1M1Jxb21i?=
 =?utf-8?B?Rkw0VU1SQkJyNGlMc2xyNGl3U1Q5cVhtTXg4dE0vcjd2dEJwS2NoUVluenR3?=
 =?utf-8?B?NHNYekZFNU5WWTVqY2syOXNNbjhLQ0RVdkNBYU1DNTQrWGNWR1pGTjZVM2JH?=
 =?utf-8?B?M0p0ZzlwWGNEZ1RCN3BUM1BmRjk3eitGa3pueU52ZmZ2TVZSbGFldlhUQndB?=
 =?utf-8?B?Z0J4UTU1S2FNYi84THBoQ2FVZjJDc0tKR0Ntenl5czdBbXVkWjVPSUNwRnRB?=
 =?utf-8?B?dTNhYzF4dTgraVFwMkN5S3dHelZOeStiNlhUWUkwamFoNzV5U3JCTVArRkI5?=
 =?utf-8?Q?l8F/Q0c689TYYaqyWXyiX6ibs?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a619df2e-f267-4290-110c-08dc80453fdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 01:10:09.1775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G28DgfUlG5FyldLAT2JYTsuFCUWL5BAt7AVROXL2PO9dvh3PAIIlnqqG1b5aI/hL1POx+cPUTmFreeQqPpJB9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8551
X-OriginatorOrg: intel.com

QXR0ZW5kZWVzOiBKYW4gS2lzemthLCBGbG9yaWFuIEJlemRla2EsIFJpY2hhcmQgV2VpbmJlcmdl
cg0KCQlEYXZpZCBPYmVyaG9sbGVuemVyLCBKaWFud2VpIFNvbmcsIExvcmVueiBLb2ZsZXINCgkJ
IFRvYmlhcyBTY2hhZmZuZXIsIEhhbyBMaSwgWmhlbnl1IExpdSwgSG9uZ3poYW4gQ2hlbg0KDQpD
b21tdW5pdHkgdXBkYXRlOg0KCQlDSSBzeXN0ZW0gaXNzdWUgLSBmaXhlZA0KCQlOZXcgWGVub21h
aSB2ZXJzaW9uIHdpbGwgYmUgcmVsZWFzZWQgc29vbg0KCQlHZW5lcmFsIGNvbW11bml0eSBzdXBw
b3J0IC0gb25nb2luZw0KDQpPcGVuIGRpc2N1c3Npb246DQoJCUNJIHRlc3RiZWQNCgkJQ2FuYnVz
IHJlbGF0ZWQNCgkJWGVub21haSBtZWV0dXANCgkJTmV4dCBtZWV0aW5nIGhvbGQgYXMgdXN1YWwg
DQoJCQ0KDQpSZWdhcmRzDQoNCkhvbmd6aGFuIENoZW4NCg==
