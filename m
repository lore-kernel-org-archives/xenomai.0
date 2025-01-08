Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5E011CAF
	for <xenomai@lists.linux.dev>; Wed,  8 Jan 2025 05:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736315593; cv=fail; b=ZUhGSt8Xy6UmToHd7a+qbMhR/D2rFxfqZ/BrSDqex5AX/gUEn0fQ45qnJ0YZ8NGd7/ft1E0pB8l/LIE0loAYYNMhSeAD32IwZ4FFJtDX7iZI+DH4g+YRmzFS85Ir9jx8Hro4L07xy/jHIvBdLvHIFbAQSxS284fwaUManbQ6rFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736315593; c=relaxed/simple;
	bh=SnpgvmikmaxgN7F9GmDXmBNXRPhRM5D3NlzqIh2flqY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s90Epx6Rxdo04zWMRGWOmGtPHciCvUm/6PAr7JdWUS1s/Yu80ozwmm/3F7Pm7t61mRkvfArIYzQUg+oe+KEPI/93fGJ7ByjlXWgqUi8JPpE0ynl5C5VQyYPuF4WUgO5Fcb6dLVXadsayWZr14Sh0RuO1arsEtnHJOtK1bmn0QMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bLT1UD7V; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bLT1UD7V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736315592; x=1767851592;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=SnpgvmikmaxgN7F9GmDXmBNXRPhRM5D3NlzqIh2flqY=;
  b=bLT1UD7Vf77KCXIoSsopcrZGp4qfetXFdpuaNQchKEMtyuKBVgYzYZAF
   rPFJplkeo8VAlMmJvFddmFO1NwrFm0mi7cTu++GLOS7zXdiHnm0pdgi02
   hhUE+ckJ6Hal0qEe0PTfuxNqkzTeOHk711Lxumk4rXNzY//V0pfIDaz65
   561Waa0xdABxaVDVY1gO2aJHzctCX8V81Du09+3V3+pCrBFpHifYzQ6AH
   GR7fWU6nLSUJg8WUWXBMfbS15vZ9e+x1FLYGgMo3VrVB+RN/x/HKWAZvV
   K6L6YYJmsmxK4PBV46JS+DSkEsRA6CPqNkQSTOjcyDWN1CJLedNWaqdjf
   Q==;
X-CSE-ConnectionGUID: gpxrvfrlQBOppigvHHyF4w==
X-CSE-MsgGUID: mSyKJjTgQK2hgiisgDFU+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="36641587"
X-IronPort-AV: E=Sophos;i="6.12,297,1728975600"; 
   d="scan'208";a="36641587"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 21:53:12 -0800
X-CSE-ConnectionGUID: TT5oMFa7TkCQxxmyVFZNYg==
X-CSE-MsgGUID: XmDMJdT7S+mkjMHMYhh9Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103506448"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jan 2025 21:53:11 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 7 Jan 2025 21:53:11 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 7 Jan 2025 21:53:11 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 7 Jan 2025 21:53:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mewVZbC9frPmRXNzERpfaaFBz39thCtNaazUOcyLCibufwtWuMC2GW4+WqsOmBvr4JOIEEomp4sXKMzez8CEHIBCgHOVvfhyzWi3nzcweqZCunlAjFSghoIZAu3p0fYM++bPPgptWZpljvu8Kn34uu5Q4jarD7oriZjHKsa9moXTfKRKvDpIOhE+J4qChJjAqgNXWQsK4gZt/9LScdwYSmL4XSDArq3166VhRowrC0P/+y8vCUDcgP1DXaA5jVS3i7IloxfkwsIyWxY9tsQ4qeZjBm0YJ6HkDn6daI/ltgcKhWI8k4M3pq/gbFm/t5EC/3lIGZ4bVrI1X8a8455rjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SnpgvmikmaxgN7F9GmDXmBNXRPhRM5D3NlzqIh2flqY=;
 b=epws51nTOaJBA+U+69w7nUMWqKWxB4B35AXhWNc/2EdfxKxtf2BreYBokC3ftcLEYrsOQX78dht/6lnZ8wz8zY35LaRpTR9fm61O7rJkiWF+i928hocU64XdiyNygfIesG9RBcqSiq8KN3aMujWIOa/89JDbMS0/msBBoeLTa61EDw146mbhkzB5MZ9VP6B3QAkSRNem4lkWs+WzOqapM/4r3lIX3uJj7VBaw66fdm6vfb4ylLvmAtPdPFef0PTR5m+nDvd48qDZQO/0iHQFY+hIJlTNiZ1oVON+SsD/z8jFMWiTwNX2hnN2q/F3CJPrqj0S+M78FObARGrbKpx0tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by LV8PR11MB8722.namprd11.prod.outlook.com (2603:10b6:408:207::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.20; Wed, 8 Jan
 2025 05:53:08 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d%3]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 05:53:08 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>, "Rosenow, James"
	<jim.rosenow@mts.com>, "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: Relax tracing not working for me
Thread-Topic: Relax tracing not working for me
Thread-Index: AdthVp/pSYw8A5rtQ5GCNa1Z0i9TVgANRq7wAAFBjQA=
Date: Wed, 8 Jan 2025 05:53:08 +0000
Message-ID: <PH7PR11MB7499EAE9E88E8846C8BC4605F2122@PH7PR11MB7499.namprd11.prod.outlook.com>
References: <MN2PR04MB6255403DD160D9EDA3319AA5E2112@MN2PR04MB6255.namprd04.prod.outlook.com>
 <PH7PR11MB7499A235E242492C3FB23DE2F2122@PH7PR11MB7499.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB7499A235E242492C3FB23DE2F2122@PH7PR11MB7499.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|LV8PR11MB8722:EE_
x-ms-office365-filtering-correlation-id: 1802a145-16ae-42ae-7769-08dd2fa8ba2e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YSs1WThrOW1xcms4a0RpN3h5L0xWb3BQUS9ocEUyKzhSc3ZvMlZLNDNuVktH?=
 =?utf-8?B?Y0taZlRuaTAyeUVKeHFBbHRGUmxBR3FWY1Z4bWh3Z0UrL0o4bDJiRkxkM09J?=
 =?utf-8?B?L0Y3c1ZyRWVJVVFTUkgrZXZxRkoyT2pPZUFCMFB2ODBpa3k5VERWNEJWUlVq?=
 =?utf-8?B?a09jSGdBTnhIcHpabFEvWXNtMmxDQnk5cEhPWDg5K1hxVW8vd25oT05WTEU4?=
 =?utf-8?B?MjRvLy9xeFg0UDMvYkJWcE5PYjlnczF1dHdPVEd3T3VBUlBBTDdRUGkvTFBQ?=
 =?utf-8?B?cHhkUUwxcEd2OERZY2xnQWpXamRyRWRhcFJSNUxCbS8vcG55ZTFtYmsvSjlS?=
 =?utf-8?B?Z2NGN1RHWDhWU3ljdXFTR2tldElzb0sreU1FUWJ5Q29BQ3VOZENXNzJ5b1Bn?=
 =?utf-8?B?MDZ0WHE0VUlCN0xBdXNoK1lobTBwcXppT25QbXdiSUdxU08zVmNaTWR3QUF5?=
 =?utf-8?B?dVZZSmh5S0JSZmJQR01pRmNDZkhyNGlKcUFlenJaRGRObnQreWhlTWQzNkZX?=
 =?utf-8?B?dWJEUTN6WW8zTnhkUytLcTllcThUNVJ0di9paEJiV25IaU5nRjk5c1BwZ3Bj?=
 =?utf-8?B?SmxrOEM0OFdubi9iZUlSclRTMjYzS2FQWEJZMk9iN0lVSnpSVVFoeUJtMnJW?=
 =?utf-8?B?eUVINnpXWjhCODB0R3BpOFVHMVEvSjBJSFo2dFFMYVBXNjM2cmdkRnhBMkJ1?=
 =?utf-8?B?UitIWXBEV2xQWVJET2ZNczNPM1JDU1QvSVkvYzBDSlAxWHI1UkhZS1BIekFy?=
 =?utf-8?B?bnBleXd3SzNtUjR1VzU4NEk4U3lrUnR3OXE0ZzVUMmxKcy9uajU1SVc1Nld0?=
 =?utf-8?B?NzVtbHlHNkEvSmlOU3ZNK0NMMEdjdERYcU1BU2V2OXhlVjlyeGN1RzdSYnRq?=
 =?utf-8?B?aHNMczZ1cUlSVzY1ZForWUMrSVBMbENxSUlVUW9UV1VaTEw3bGprR2hpb1hI?=
 =?utf-8?B?V3Nrc3Q0NTdSL2JCTVc5Q3RkbnpwSDQxYnNuYkxFVkpycnJ5YXhNZmp4VlhU?=
 =?utf-8?B?ZzM4UUJnSllNVG8zWjBJaTRoOU9FNU41SnhkWUs3T1h0a3NRQ1R3VU5uYlN0?=
 =?utf-8?B?cXl5QllVaXdSdWlDQXdsQ0R3SU85U0RrcWFFS3gybzl6TDh5Sm5ETldoakJn?=
 =?utf-8?B?Qm9CekIwUmduZ29EQW8zRjlQajNNaU9ETU4vcE5HU3lUWDh6RHMralNwbnhr?=
 =?utf-8?B?bDNWK3VBZmhYWXhoRUNwRHJiUDRwc050dVFPOVZFMDVzaTg1SE9DOTd0QU40?=
 =?utf-8?B?WXVFZWtEUXB0NDFRMGlGOUVPMU9oTDJJSVVsdjJQeVRkckhmdVVvRDNqVENK?=
 =?utf-8?B?YTRNeGZRbmw3UTFJMUIyQWxwdi84Z1BwQ1RnM0Y4cDV1ODNlTXVlUlo1di8x?=
 =?utf-8?B?V3JLZ1NLL2lPRlk0THdiRkZ4aHY4N2JpQnJiYWRleERPckRtWkFtVmdpODdF?=
 =?utf-8?B?dHZhUUFtQWdONzFVNFo5eXZBNkZaOGtTaVJjaG9YRXJRY29BTmNYTnBtNGZU?=
 =?utf-8?B?b3N6MXZmYjVUQ2FsS2xSaDFvRWN5SnQwaVpXZFB1K0tNZy9ETXhob1ZOTEcz?=
 =?utf-8?B?NlNUREFLL0NWRDV3REtZQ3NmY05odmg4TU0wTXliR1dPcmxZalRVK0dFRGpM?=
 =?utf-8?B?aWE0ZGl0N0tNS1ByeTBKREx6ZkRvRzM5ck8rbzM3V0xKSFNjSkNaWitUM3N2?=
 =?utf-8?B?Ykl3NnVuencwbmNTZTM2ZVNoenR6ekxIQTdrQk9aSnRYRjdxWmtDdDZhSnZs?=
 =?utf-8?B?TEQ1WERZajJvUUttK2lwOU05K2ZDUlVjUlVCZ25TUDMxQkFyblJDU1crSUs0?=
 =?utf-8?B?M0hSWkxKcUxuL3ZTZFRGQStrUmlmQ3hoWm85WkxhMldhUUtIMSs2blZFTEFO?=
 =?utf-8?B?OTVqbDFENDI1a3RYUndLQ3ViR0dGalQzUngzTXdnbWZ3TlE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkVMQzkvdFJ0MlpLVENGeWRyaHBEZXdmNktaR2Y1UjlxZUdjbHZ4SzNnQjFK?=
 =?utf-8?B?U2NFREVYY1FLTCszOTUvRnFJbzZzNXl6Y25WVDl1TFdoWW9jTUQrUi8yNHZq?=
 =?utf-8?B?UXdGUDA1TVlld3JrSXRDb0hTbGRRcjJrREswQXBpajk3TWVybVBXSDVZcjd2?=
 =?utf-8?B?bTI5T2RrK3MzeEpMTm9MYXhpcTZsRUUwV2lSY21rZXRubXVDRzlxWUxpbnFu?=
 =?utf-8?B?NnhMQmRHa3dDb2ljSjdjaGVOa2kveVlnUUJrMk9qNHlGdFdNM3JmdFNJcE1l?=
 =?utf-8?B?N1Q3SmdWSzBYZ1A4SndRQ2haSW1SUyt4b1NuSlJSZ08vRGRYbEhLQ3dUUkZ1?=
 =?utf-8?B?SjYyNlI2TStBb0hzWDJnWk1JTGFubE40ZXN0MFRxRFFKb1RxSFFmbkpwdTZu?=
 =?utf-8?B?QmNqSkxpRUJ4QTB1OTlVdmUrWlZ6d0g3ejFXUk9FUHBMZngwZFdKbDJtUFFp?=
 =?utf-8?B?cWpvTDRLOW1DWTAvNGlxdlNpYndLcUJYSDRzRXc0b052c3JxNGNSSkVScTFN?=
 =?utf-8?B?ZVJvTmlKUTgyQkpENjc5ZFhhZmdTWm92cHRBM3ZXYnRtVlhiNSttQlZTaVVm?=
 =?utf-8?B?bDltWnVqaUsxNVhKUnJqUHlXaWlvVXBrODNqVHFBa0hEdmQvVkNVN3AxUnZz?=
 =?utf-8?B?eWh0TTdNQVI5WmVsbjlUMTlIVVNwaTFNT3FxamtFUHFaYytsNFNMWW45Q1NS?=
 =?utf-8?B?TTAranhZS05HU1NWYjhFR09TbXFFSlozb3Q2WnJDeFQ5eTVwa0ZIRlo1cWQ4?=
 =?utf-8?B?L0QwRmdzL0NEdmsxdnQ3c3BjSysrKy9HK0pjeS8wdlZOcDh6TVBrMzlLcDVI?=
 =?utf-8?B?SUJVT2dtYkJXZlJRQ05FcVp5aEc5RWp3Y09tbFRKQ3luZUV6c3FOV0ZPZXVZ?=
 =?utf-8?B?ZGJJdFhPck5CMVdiZ3pDL0hZMDZaOWJkM3hteExrVWZMT0xCR0dQYlVOaGtN?=
 =?utf-8?B?NGM4cWNEcjQrbXBtazY5N253ZFdFemxTbitRNDMyUWQzYXFHZUZ3UDkzbkla?=
 =?utf-8?B?VXNiQUgrenNramVmMzZvdDhQTTJQeElrS3UyNEZCVW5uL015TkpnY2dWV1N5?=
 =?utf-8?B?Z3BWd1JqTUVwZkVjcGp2N0VQTk9TY1Z0ZzhUb3Q4M0EyZjIySEhsQUZhOW9X?=
 =?utf-8?B?VTgzNkRYdmtSUE5DaVFMMWxSNWJtZFlsMWwvNkNXV2NkK3RneWlidVhrSklq?=
 =?utf-8?B?dW9xb1l4Z2paZmNJRDlhWlowMnBnenkrNnpLSXhXdHFsTCtmZ1A3MjVCUncv?=
 =?utf-8?B?TWNlU2ZQN0pZL24zQUk0cjYybThucVNmb21xMExtUzlub003aXRzY0pRYkVG?=
 =?utf-8?B?aDBjem1abGVzWXgzNWVPSHpvT25MMXNhL0lWUmJuZmtwV1hMMllrUEowdGVW?=
 =?utf-8?B?V2xydlhsMGxEMFFGK0VuenlZUEMvMnRLci9ya0E1U1FaQnQyK0VvT1MzTklF?=
 =?utf-8?B?UllkUjhXZ1pPOGkxWmMxT2JDekgrM1ZjVkRURkNBamtMUk5vZVltOVFGeCtW?=
 =?utf-8?B?eTdma25xQk1xaUtVeFpqZWRzL3dsRFJzSVFMbXJWUHhPaENhRDlzZ0Zvby9w?=
 =?utf-8?B?TFQxK3pNLzR4R0VNSnRMUG1HOEdsUlBweDVTQnNWTTdFUTBMaVVzNUxRQThV?=
 =?utf-8?B?Sk1YU2lCOWpRYzhJbU9mcXFXRFd1aGJKL2hldUtuNHhSZ1JiQW8yZWhmMDNO?=
 =?utf-8?B?UnZjZmk3czFCNEpnRGFjZUJ3MTRRbStka3ZWKzVCT3gyWk9pQlkrMVBBeVE1?=
 =?utf-8?B?KzRVSkxJWE1HeGY3b1NUQjBoc3hBczczTXNyTWsrenA4LzZaYW53TUhIdCsr?=
 =?utf-8?B?Q2pzQ29pcFZHSGhmZWJkMEpsbVp5TVlKNFNCTCtBcjJiR2pVYWdDRDA4M2VP?=
 =?utf-8?B?RXRmZHBHRGpja1F0ZWhLOGtJSXpFMlFkTGZYamdlL0tUc3pRZFkzdnh5dUwz?=
 =?utf-8?B?bmx6MzUxWURUZ1R4NU91MmNOVStTWGhIQ0l2T3htNDhOUTFmaktiZTBIVjdR?=
 =?utf-8?B?YUJYTFJ4V2xIWEJMUnVMV0EvYkFQWnVqTlEwbkxKZzBOeXVMVVVLbWtMNnFl?=
 =?utf-8?B?NFBhL1ptSURUMmdZb2c5N2crS2dxUFJqaUNMQWIyMWlLcVZVREVCdnNDUnJ1?=
 =?utf-8?Q?gylBBPN4T0AlDST3kdQRQRf1a?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1802a145-16ae-42ae-7769-08dd2fa8ba2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2025 05:53:08.0433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nvtfTh88TxiCF1FfNqjmvdDa3GPnsgb8+w4YAjjnav+/G47E7DQX1D7OHMlfaE607YUXgubrAZAcqjYs6kEHmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8722
X-OriginatorOrg: intel.com

SSB0cmllZCB0byBydW4gbmV0Y2F0IC1sIC1wIDY3Njc2IC1jIDwgL3Byb2MveGVub21haS9kZWJ1
Zy9yZWxheCBhcyBpbnRyb2R1Y2VkIGluIGh0dHBzOi8vdjMueGVub21haS5vcmcvdGlwcy9zcHVy
aW91cy1yZWxheGVzLyB0byBjYXB0dXJlIHJlbGF4LCBidXQgZmFpbGVkIHdpdGggZm9sbG93aW5n
IGVycm9yLg0KbmV0Y2F0OiBpbnZhbGlkIG9wdGlvbiAtLSAnYycNCnVzYWdlOiBuYyBbLTQ2Q0Rk
RmhrbE5uclN0VXV2WnpdIFstSSBsZW5ndGhdIFstaSBpbnRlcnZhbF0gWy1NIHR0bF0NCiAgICAg
ICAgICBbLW0gbWludHRsXSBbLU8gbGVuZ3RoXSBbLVAgcHJveHlfdXNlcm5hbWVdIFstcCBzb3Vy
Y2VfcG9ydF0NCiAgICAgICAgICBbLXEgc2Vjb25kc10gWy1zIHNvdXJjZWFkZHJdIFstVCBrZXl3
b3JkXSBbLVYgcnRhYmxlXSBbLVcgcmVjdmxpbWl0XQ0KICAgICAgICAgIFstdyB0aW1lb3V0XSBb
LVggcHJveHlfcHJvdG9jb2xdIFsteCBwcm94eV9hZGRyZXNzWzpwb3J0XV0NCiAgICAgICAgICBb
ZGVzdGluYXRpb25dIFtwb3J0XQ0KDQpSZWdhcmRzDQoNCkhvbmd6aGFuIENoZW4NCg0KPi0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ2hlbiwgSG9uZ3poYW4gPGhvbmd6aGFuLmNo
ZW5AaW50ZWwuY29tPg0KPlNlbnQ6IFdlZG5lc2RheSwgSmFudWFyeSA4LCAyMDI1IDE6MjcgUE0N
Cj5UbzogUm9zZW5vdywgSmFtZXMgPGppbS5yb3Nlbm93QG10cy5jb20+OyB4ZW5vbWFpQGxpc3Rz
LmxpbnV4LmRldg0KPlN1YmplY3Q6IFJFOiBSZWxheCB0cmFjaW5nIG5vdCB3b3JraW5nIGZvciBt
ZQ0KPg0KPg0KPg0KPj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj5Gcm9tOiBSb3Nlbm93
LCBKYW1lcyA8amltLnJvc2Vub3dAbXRzLmNvbT4NCj4+U2VudDogV2VkbmVzZGF5LCBKYW51YXJ5
IDgsIDIwMjUgNjo1MSBBTQ0KPj5UbzogeGVub21haUBsaXN0cy5saW51eC5kZXYNCj4+U3ViamVj
dDogUmVsYXggdHJhY2luZyBub3Qgd29ya2luZyBmb3IgbWUNCj4+DQo+PkkgYW0gdXNpbmcgWGVu
b21haSB2My4yLjEgb24gNS4xNS41Ny1kb3ZldGFpbCBhbmQgSSBoYXZlIHNlbGVjdGVkIHRoZQ0K
Pj5mb2xsb3dpbmcga2VybmVsIGNvbmZpZ3VyYXRpb24gb3B0aW9uLg0KPj4NCj4+LmNvbmZpZyAt
IExpbnV4L3g4NiA1LjE1LjU3IEtlcm5lbCBDb25maWd1cmF0aW9uDQo+PiBYZW5vbWFpL2NvYmFs
dCA+IERlYnVnIHN1cHBvcnQNCj4+WypdICAgVHJhY2UgcmVsYXggcmVxdWVzdHMNCj4+DQo+Pldo
ZW4gSSBydW4gbXkgYXBwbGljYXRpb24sIEkgYW0gZ2V0dGluZyBNU1cncyBvbiBvbmUgb2YgbXkg
cmVhbC10aW1lIHRhc2tzLA0KPj5pLmUuIHNlcVRhc2stMDAgKGJlbG93KS4NCj4+DQo+PkV2ZXJ5
IDEwLjBzOiBjYXQgL3Byb2MveGVub21haS9zY2hlZC9zdGF0ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdGVzdDogVHVlIEphbiAgNw0KPj4xNjozMjoxNCAyMDI1DQo+PkNQVSAgUElE
ICAgIE1TVyAgICAgICAgQ1NXICAgICAgICBYU0MgICAgICAgIFBGICAgIFNUQVQgICAgICAgJUNQ
VSAgTkFNRQ0KPj4gIDAgIDAgICAgICAwICAgICAgICAgIDM1MjY1MTEgICAgMCAgICAgICAgICAw
ICAgICAwMDAxODAwMCAgIDk5LjggIFtST09ULzBdDQo+PiAgMSAgMCAgICAgIDAgICAgICAgICAg
MjIxNjY1NDcgICAwICAgICAgICAgIDAgICAgIDAwMDE4MDAwICAgOTguNyAgW1JPT1QvMV0NCj4+
ICAyICAwICAgICAgMCAgICAgICAgICA2ICAgICAgICAgIDAgICAgICAgICAgMCAgICAgMDAwMTgw
MDAgIDEwMC4wICBbUk9PVC8yXQ0KPj4gIDMgIDAgICAgICAwICAgICAgICAgIDAgICAgICAgICAg
MCAgICAgICAgICAwICAgICAwMDAxODAwMCAgMTAwLjAgIFtST09ULzNdDQo+PiAgNCAgMCAgICAg
IDAgICAgICAgICAgMTIgICAgICAgICAwICAgICAgICAgIDAgICAgIDAwMDE4MDAwICAxMDAuMCAg
W1JPT1QvNF0NCj4+ICA1ICAwICAgICAgMCAgICAgICAgICAwICAgICAgICAgIDAgICAgICAgICAg
MCAgICAgMDAwMTgwMDAgIDEwMC4wICBbUk9PVC81XQ0KPj4gIDAgIDMxMSAgICAwICAgICAgICAg
IDIgICAgICAgICAgMCAgICAgICAgICAwICAgICAwMDAwMDA0MiAgICAwLjAgIFtydG5ldC1zdGFj
a10NCj4+ICAwICAzMTIgICAgMCAgICAgICAgICAyICAgICAgICAgIDAgICAgICAgICAgMCAgICAg
MDAwMjAwNDIgICAgMC4wICBbcnRuZXQtcnRwY10NCj4+ICAwICAzNDIwMSAgOCAgICAgICAgICA4
ICAgICAgICAgIDU0ICAgICAgICAgMCAgICAgMDAwNDgwYzAgICAgMC4wICBjb29wc190YXJnZXRf
bWFpbg0KPj4gIDAgIDM0MjAzICA3MTQ0MjAgICAgIDcxNDQyMSAgICAgMTQyOTc1NiAgICAwICAg
ICAwMDA0ODBjMCAgICAwLjIgIHVzZXJDeWNsZQ0KPj4gIDEgIDM0MjA0ICAyICAgICAgICAgIDIg
ICAgICAgICAgNTcxMTg0ICAgICAwICAgICAwMDA0ODBjMCAgICAwLjAgIGNsb2NrSW50ZXJydXB0
DQo+PiAgMSAgMzQyMDUgIDEgICAgICAgICAgNTcxMTgzICAgICAxMzU2NTU5ICAgIDAgICAgIDAw
MDQ4MDQyICAgIDAuNCAgZGlzcGF0Y2gNCj4+ICAxICAzNDIwNiAgNTcxMTgyICAgICAxMTQyMzY0
ICAgIDcxMzk4MiAgICAgMCAgICAgMDAwNDgwNDIgICAgMC41ICBzZXFUYXNrLTAwDQo+PiAgMSAg
MzQyMDcgIDEgICAgICAgICAgMjg1NTk0ICAgICAzNTY5OTMgICAgIDAgICAgIDAwMDQ4MDQyICAg
IDAuMyAgc2VxVGFzay0wMQ0KPj4gIDEgIDM0MjA4ICAxICAgICAgICAgIDE0Mjc5OCAgICAgMTgw
OTYzICAgICAwICAgICAwMDA0ODA0MiAgICAwLjEgIHNlcVRhc2stMDINCj4+ICAxICAzNDIwOSAg
MSAgICAgICAgICAyICAgICAgICAgIDMgICAgICAgICAgMCAgICAgMDAwNDgwNDIgICAgMC4wICBz
ZXFUYXNrLTAzDQo+PiAgMSAgMzQyMTAgIDEgICAgICAgICAgMiAgICAgICAgICAzICAgICAgICAg
IDAgICAgIDAwMDQ4MDQyICAgIDAuMCAgc2VxVGFzay0wNA0KPj4NCj4+VGhpcyBpcyBhbiBpdGVy
YXRpdmUgdGFzayB0aGF0IGlzIGV4ZWN1dGluZyBhdCAyMDAwSHosIEkgZ2V0IDEgYWRkaXRpb25h
bCBNU1cgZm9yDQo+PmVhY2ggcnVuIGl0ZXJhdGlvbi4gIEFzIHlvdSBjYW4gc2VlIHRoZXJlIGFy
ZSBtYW55IE1TVydzLiAgU2hvdWxkbid0IHRoZQ0KPnRyYWNlDQo+PmJ1ZmZlciBiZSBmdWxsIG9m
IHRoZXNlIHJlbGF4YXRpb25zPyAgSWYgSSBjYXQgdGhlIGJ1ZmZlciwgSSBzZWUgbm90aGluZy4N
Cj4+DQo+PnRlc3RAdGVzdDp+JCBjYXQgL3Byb2MveGVub21haS9kZWJ1Zy9yZWxheA0KPj50ZXN0
QHRlc3Q6fiQNCj4+DQo+PldoYXQgYW0gSSBkb2luZyB3cm9uZz8NCj4NCj5BY2NvcmRpbmcgdG8g
dGhlIGNvZGUgWzFdIG9mIHhudGhyZWFkX3JlbGF4LCBzeXN0ZW0gb25seSByZWNvcmQgcmVsYXgg
dGhhdA0KPm5vdGlmeSBpcyBub3QgemVyby4NCj5BZnRlciBzZWFyY2ggeG50aHJlYWRfcmVsYXgg
dGhhdCBwYXNzIG5vdGlmeT0xLCB3ZSBjYW4gZmluZCB0aGF0IG9ubHkgdGhlDQo+eG50aHJlYWRf
cmVsYXggY2FsbGVkIGluDQo+a2VybmVsL2NvYmFsdC9wb3NpeC9zeXNjYWxsLmMgd2lsbCB0cnkg
dG8gc2V0IG5vdGlmeT0xLiBUaGF0IG1lYW5zIHRoYXQNCj4vcHJvYy94ZW5vbWFpL2RlYnVnL3Jl
bGF4IG9ubHkgcmVjb3JkIHJlbGF4IHdoaWNoIGNhdXNlZCBieSBzeXN0ZW0gY2FsbCB0aGF0DQo+
dHJ5IHRvIHN3aXRjaCBwcmltYXJ5IGRvbWFpbiB0byBzZWNvbmRhcnkgZG9tYWluLg0KPg0KPkFs
bCB0aGUgcmVsYXhlcyB0aGF0IHlvdSBvYnNlcnZlZCB2aWEgTVNXIG1heSBub3QgYmUgcmVjb3Jk
ZWQuDQo+DQo+UmVnYXJkcw0KPg0KPkhvbmd6aGFuIENoZW4NCj4NCj5bMV06DQo+ICAgICAgICBp
ZiAoeG50aHJlYWRfdGVzdF9zdGF0ZSh0aHJlYWQsIFhOVVNFUikgJiYgbm90aWZ5KSB7DQo+ICAg
ICAgICAgICAgICAgIGlmICh4bnRocmVhZF90ZXN0X3N0YXRlKHRocmVhZCwgWE5XQVJOKSkgew0K
PiAgICAgICAgICAgICAgICAgICAgICAgIC8qIEhlbHAgZGVidWdnaW5nIHNwdXJpb3VzIHJlbGF4
ZXMuICovDQo+ICAgICAgICAgICAgICAgICAgICAgICAgeG5kZWJ1Z19ub3RpZnlfcmVsYXgodGhy
ZWFkLCByZWFzb24pOw0KPiAgICAgICAgICAgICAgICAgICAgICAgIG1lbXNldCgmc2ksIDAsIHNp
emVvZihzaSkpOw0KPiAgICAgICAgICAgICAgICAgICAgICAgIHNpLnNpX3NpZ25vID0gU0lHREVC
VUc7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgc2kuc2lfY29kZSA9IFNJX1FVRVVFOw0KPiAg
ICAgICAgICAgICAgICAgICAgICAgIHNpLnNpX2ludCA9IHJlYXNvbiB8IHNpZ2RlYnVnX21hcmtl
cjsNCj4gICAgICAgICAgICAgICAgICAgICAgICBzZW5kX3NpZ19pbmZvKFNJR0RFQlVHLCAmc2ks
IHApOw0KPiAgICAgICAgICAgICAgICB9DQo+ICAgICAgICAgICAgICAgIHhuc3luY2hfZGV0ZWN0
X2Jvb3N0ZWRfcmVsYXgodGhyZWFkKTsNCj4gICAgICAgIH0NCj4+DQo+PlRoYW5rcyBhbmQgcmVn
YXJkcywNCj4+SmltIFJvc2Vub3cNCj4+TVRTIFN5c3RlbXMgQ29ycG9yYXRpb24NCg0K
