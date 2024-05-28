Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB7417E90E
	for <xenomai@lists.linux.dev>; Tue, 28 May 2024 07:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716881496; cv=fail; b=l/rAp43v3gawD8YS+2fuGudYSiNoecWhp0F1YjBqZiEicX50xfNtL1AHzzxlvqgFXc+H3YvZCUWXzVUj6OWKcDFINVEODr6mPRNbFv/NY7ILxsRzcCe79l/+zLxxocnrXGA2MIdgrIXTHKpXIAxX0HkQ1aVxIoFfh9krZXLD9VM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716881496; c=relaxed/simple;
	bh=ENidtREJom2sbgVDjpTzotTCKIarvmf51vWCFBo1wzQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WXsgOkVe03Sag7nFDJuN7gJC8E/LGq/KpHL/zNxPa7EZDPRIbHAcrnhSJpgeFrslW+QDPFFUHo86r8p76iCsfLUleO/iWChgDeLOwVX9NyrK69Vhs2o5+JGvWhH5zWMdemuCRZDdXNC1slzr/Izzd8BWIkrsvs5QxCCpp66Qnm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Aeyn8Iei; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Aeyn8Iei"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716881495; x=1748417495;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=ENidtREJom2sbgVDjpTzotTCKIarvmf51vWCFBo1wzQ=;
  b=Aeyn8IeiWDNWJ7OkbOZVds1dC1lB+r1QMOY+2wCnzPDQuWbnzd8oPgk1
   8gIIgveAj+hnk8t4P65Imvxu/gow+OkPq41aKtpkYAyT6WK11MdbtjwyM
   T2M73DLA20WJ51EAff+QLTy6GegI3sr6QSOz3xKGslxFfnKgepe3x1zms
   hBV2N6OutLSz6SHHy/uRlYKnvF0xmBPG63s2qlIdCOfwpAxy/klBO97rT
   P+cPY6sO2b3ZI61AzuYPkcTdXKIm5tSk874EstTHy8yHW7/CjHScFCue7
   MC3XpXMlRJTS/a68TvtmSLthAs970d7/NXT3d1inOmktMT941wR77NjN8
   w==;
X-CSE-ConnectionGUID: B8F7F6lQSTKv0nGnAsXaIA==
X-CSE-MsgGUID: d3CwbKMoQH6x+At4cfowlQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="17042205"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="17042205"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 00:31:21 -0700
X-CSE-ConnectionGUID: +tyeCEWkQgSD9A1/4BMIWA==
X-CSE-MsgGUID: rPqYnRxoQ5Gv5zq7hkE1HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="35039102"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 May 2024 00:31:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 00:31:06 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 28 May 2024 00:31:06 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 28 May 2024 00:31:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0lbLA1+YWrk2P5Vip8RvYb49UUkyaAbTeCvjhRkqkk9GX1fSfx2ylU+bavC1ydrsBOo/5EvicyeMMgvJyCKUjxWHzisI2EpQTBZbvVcSetNVv2Xv+mM/jkr2s5c9y7d8NJc1hPkT/vG9IdVFtIy3t4LS19GLrfywdEjpu7/JUX5cqoUBxKJ6Ev49e70Ax3L+rV0D4cybN3GIy9ruTO2o+yH1U4fj5jtl3OQJlVtmANqWeH0TVmqVpW7qUoj1ZAYNVZC4501cWD0rtC1uYObBodaf/JAs1TkQeYHexQcVsEzg/qgyxnZS8FzM8LMjlEB3YG6A9CeEpky6QsmJI3+OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENidtREJom2sbgVDjpTzotTCKIarvmf51vWCFBo1wzQ=;
 b=S1LgcOzxWV/8/Xp1nHhvbo3zzdvwxbJ9jLrJNqtO+/C2TvIla8pKokxHyENn0daHJFJzZ2K9kkcW+w8Nk1W68cXdXCQD3H3mYDs7YX7fnmqQU8jdX3X7uDTFdAurN84zCQOyyR6G3V00OTU74OIcw8nnBsu3Gk0hzUGJapimJr6Oc8UYb0duH6uEQ5HjRvgcURWqJL6hOP0DgW8H/SwWRqMhKv1NZPf9tWIXs/OtXYUgROU/wbxug9Yfngj+ukkeWKf9gnrviTcFTTlYPHriY0xvPJPqwJO7LUprCfTgW+OJ3yP9/nCzhDR0zh21nde/bY5lhHr3W+u5gFvdt7vxZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by DM3PR11MB8760.namprd11.prod.outlook.com (2603:10b6:0:4b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 07:31:03 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d%7]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 07:31:03 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, =?utf-8?B?VGFtw6FzIFBhw6Fs?=
	<paal.tam@gmail.com>, xenomai <xenomai@lists.linux.dev>
Subject: RE: rt_igc fails to bing an i225-V Ethernet device
Thread-Topic: rt_igc fails to bing an i225-V Ethernet device
Thread-Index: AQHasDdwBZFKY8hLkkygWgh1EF0me7Gr/UHQgAAgQwCAACOHcA==
Date: Tue, 28 May 2024 07:31:03 +0000
Message-ID: <PH7PR11MB7499FB6B26032D1645F9BDD6F2F12@PH7PR11MB7499.namprd11.prod.outlook.com>
References: <CAH0t8y01h5W8Hsa=xvUJCyQM5VeA8CSTftBvLYrzbzQHenv7zw@mail.gmail.com>
 <PH7PR11MB749952ADE786FE1D78EA1A91F2F12@PH7PR11MB7499.namprd11.prod.outlook.com>
 <5de1a72a-ce0c-492a-b5ba-5bdc659df4a7@siemens.com>
In-Reply-To: <5de1a72a-ce0c-492a-b5ba-5bdc659df4a7@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|DM3PR11MB8760:EE_
x-ms-office365-filtering-correlation-id: 7a257443-16d5-4ba7-8d0b-08dc7ee82103
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?ZXdYTm0wZzRvSnhuT1BDOTd3TElscURPTFg5b0lXeGFSMW1maEpnd0RzakE5?=
 =?utf-8?B?RkxjRTZpR3RRUnBWOE14aHZRa09pUzg5VHZiYlp5SjhFQnBxYllXNjR5TjNU?=
 =?utf-8?B?cWdWMHpMeWNySGtUU25GckpiVHRWS2JsejRpWS93UW5RZXZwMDZIQzZkNFFH?=
 =?utf-8?B?MUhYNmxTTHVNSno4T09TUHRPU0k0OU5SMXhvUnZGMm5ZdzF1ME1MclR6M3F5?=
 =?utf-8?B?bjY0V1IyUEZXcmVvS2p6TGF0WmQ4MmxyK2RzTlB5bFZ2d29YRFNtSTZQUC9x?=
 =?utf-8?B?TlU2UTZTM25YUXltU2dhQVdrTWZVTDdtL3Y1SytzYWFZQ3F5SzhWZlowVzhR?=
 =?utf-8?B?SjFxdjBNekY3YU82VFNTUEhrMUR6a2ZiQTNVcHBtamQ0RWVIN2VqYXNtK004?=
 =?utf-8?B?V3pRY1IybnNKbnFDWkt2UFBKUzUxcVVOZENrd0hnVFM4d2tnd2svc29oTmQ5?=
 =?utf-8?B?WkFCclF1ekJHSXp4czNxRWd6cU9sVm5pZ1FUZ244VTBSOUlzWFRwTTYwQWJk?=
 =?utf-8?B?UDdkZVRoYzNMbDErVUdyekQyL3hUUUE1WDdxRzFyMXcxUzNDY3o3amh0TS9W?=
 =?utf-8?B?VmNXclhPQW8vV2IwL2UxdnhCSmpqY2hTTE5hbDFBRklkWmpyelE3clRCcXZ5?=
 =?utf-8?B?UEt6R3FFWEV3Mk1WSDYwbDVKTWpqYytFcjBhUk1KQm11QU5za0kyMEFwR0JL?=
 =?utf-8?B?UVRYbzcvWThhM2ZmMXV4RnJrQ3NyMTJYcFRKdERUaktkOW5uVnF4NmhCLzFh?=
 =?utf-8?B?VVp5dnc3T2NCdW1zd1RveUkxdmFBVFRiUlpMTkFHeEI5TkFtOUdKZmxPUjhW?=
 =?utf-8?B?eXplR3JmZDZxOHdYbUplcWNEL3dtY2NOOW1icy9TQVZIQVMvbTJaVzlMUFJ6?=
 =?utf-8?B?ZnNsYlJYQ3RvL1Axcm5RV3JBNDZSZEkwQ21mbDNMdWZWeUZFVE9rdmNhcnMx?=
 =?utf-8?B?WlJQbExOdk1zT04rRlRMOTdsMEd3Vzl0ZTQ4Q3M5UVdscXJxMVNCdkNaNU83?=
 =?utf-8?B?dWpqczhTcG93Q0Y5ZDFHK2MxLzA5dHZXejlDeWcrakRsczVSTHpKVkFxZC96?=
 =?utf-8?B?VTJFY29zRXdoUHpiaitscmwwcGFnSDc5Q09nMmUxaXFIUzhQQjQrajF2UllC?=
 =?utf-8?B?Y0F1TTZYV0FOaW9oeWdsNjBUcm03c2FBbHZyam1Mc0RvSFI1L2hCVWFNK3l0?=
 =?utf-8?B?MXlzU082cmY0LzJqVVk1ZGIxcTZyd3AyWnZHaHFXZHZieC9ST0x2Y0JDWFRL?=
 =?utf-8?B?dDVCSXpKWEVCc3lrUjdpeGs5NEtIN2Q0U05pbVN4ZFNwU0FZTCtBT2oyd1do?=
 =?utf-8?B?N2phMEM3UEJZQzRFRSszb0gvR2ZPV0w0K0VQQ09vZ2txWVNGYmwwVnRmb1Vo?=
 =?utf-8?B?RGw2U2I0clczb2NRUDA0YmNOVnhBWVNLSnZNN2ppNmh0cndKanlRdzBZVmpH?=
 =?utf-8?B?MDdrT1pwVmZhRDFjNE1LNWxsMVZMem5kSlZ3ZXFvc2xVUm1kYVo1ZERlS0ly?=
 =?utf-8?B?dEwwMVpKTHhKRzYycHh6bkdyeVpnZllkSll1NmFiTktWL1ZkQXRjNENKN2dM?=
 =?utf-8?B?ekhuNGEwWEgyZEI0c1NHVjlEakJ0NW45ZEhXWVVqamxDYjM0TFRydGZnMG5p?=
 =?utf-8?B?L0c1NHBkTllvaEpFck5aR3lvNEd1eG9vTFhpVytuNVlDUGVhV1o3bmNtZTZi?=
 =?utf-8?B?VjM3b2pEdzJEeGhYZVRzazhsVXdJazdqclcyN3o4NkhvbUtRZm50MlJWbEFM?=
 =?utf-8?B?NGg2MlN5RlViRUdDbmZvR2hqemxub0VFc1ZTUW5JcHZaak5OU0hyK04yK3Zp?=
 =?utf-8?B?eStRZzNaeW1URURjZXJrQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkI5aWlSK0cxc2dhL0F3b2Vzc2RGcHpVdlhoSHRQc010Z3FZWVBpWWZmWDJV?=
 =?utf-8?B?M3ZTUFg0ZzBPZnJ4cW9VV0pkSTM0RnRXTjRtQ2dsekJIMlR0aVJ6b3NQVCts?=
 =?utf-8?B?MUo3ZThKYUJod2wxODFhdEFjcmRteVVlVDFtNjkzUEFtU3RJOWVUUG92NGZx?=
 =?utf-8?B?K2dyTzVGYk05M2gyc3lUT1RmVXBaN0VsT1F0NjgvcVYxZFJMWm9oOWxTTks3?=
 =?utf-8?B?VUkrN2xzZWpETDZSV0Ura2ZEQytnMU9GUE9mZFNtUEFQNTdESVd6cGplRkFC?=
 =?utf-8?B?UEZYMmUxUXRoUDBtQzkzZkY4V3pTYjF0aHRDTFRzeUd1QU5yUHQxcjYwTnha?=
 =?utf-8?B?SWpLU2RxZ3JNVnMwbUN2Q2U0YUYybXk3bUpQdGtvT3VLNzVIbFJrb1BFU2l0?=
 =?utf-8?B?NEdIOFdtd3hFV2NtY2diVnYvcDFQbVYzaG1Va05pNGRXWmhickg1UDhTMTl2?=
 =?utf-8?B?YnJHcW9IOVhEZGJnRWpLUkU4NjgxSjVOYWtKM0NQK1Q0a1lFWE90VnQxODVa?=
 =?utf-8?B?MWE4Q2M5R01rKzlRa21DR1V3eGhLcUlxeGNid21iSWszT2l2Tncyc0RPbEww?=
 =?utf-8?B?L2RRVTdQMktIRzYyNzRKTElLZUM2OHZNSWdHL1UvQ2FQSW9LRE9DdnlNejY0?=
 =?utf-8?B?Rm8xTHJ4TU5kUzFhYWVHTDB6S3dwS2JCdHEyZ1A3OEZhY0JNK0xENUlwL2Z0?=
 =?utf-8?B?L3hyUndFbDdrMytXSFdGUnpJanBuLy9PTElRUThnakh1cmRqVk9SQWNsR3ZE?=
 =?utf-8?B?Ymd6bkwxTXM2SW5PejVCZGx3VlZsUU1sTEV1bzRKYTlibE1xTGkxWHBoeTNP?=
 =?utf-8?B?N0UyRGl3TFAwdTM3Ri81ZHV6ajdTQ2FMc1hwd3d2aUk5Z3lCeVRHTC9EbWh6?=
 =?utf-8?B?S21hVko5Q1pyT0JCUEdMd01aK0J0dWxkUFg4K2VVYUFKQldCUDVrV3kyL09t?=
 =?utf-8?B?SUtwK2Q3V2pKaWZPOUVUd083aFJtMWVzRDBXOFByNTJXeUdneDNOQnRDRzdw?=
 =?utf-8?B?ZkdOL3ZndDZhN2dRTHhpb0JCMHJyRjBCbUxlMFRscUxmeUNvTk5kbTQvbzBl?=
 =?utf-8?B?emNock9jYUM4b1RTODZFSTJ2V3h6NTl0R1N2bjJINFVFZml0TjFjNkx0V3Z2?=
 =?utf-8?B?cjNENzJ4UzRQTFRzem1xTWdFTWNrYnpXU3RiNmxYaDVtcjI3c09LR0tFKzJG?=
 =?utf-8?B?Vk1XbW02VlN3bVhJbjZRNlRDd3VCTDkxaTJSRXFRSDBuRzc5dnNmUkJFbSt1?=
 =?utf-8?B?dFo5VXFndTVOQ1hhMGZCTWR6eHowTzY4QUVoVHpTNmpZalUyS2JGWEZXSUJp?=
 =?utf-8?B?SWdzeTR6aFQ2T0pPc2FzanpNa3NFVGJNcjFPYzU4Q2dmUVRqc01qYk1HaEpr?=
 =?utf-8?B?bGpabjJOR2h0dWdrQUlZRlIyZS96WGo1NzluOVk5Wm1aZEJ1RXdiQ3dXdGZK?=
 =?utf-8?B?b2JxN2g1U1JXeklsUmtqem1lNk96cmwwcXdjT1c3a3dtdStiRUxYZkRrb2ZY?=
 =?utf-8?B?eUZoWG9Kd09tZVR6QXYwbEZDQk8xTkNSR2sxUlJmZmcrWWlXb285NW9FLzRH?=
 =?utf-8?B?bGsrOUovSG1qeUs2QkY1ZExNMzBBZGIxNlpIb2VDck1YWHVWbTIwQ2pOb2lm?=
 =?utf-8?B?QlYrWXBJUUFwcTlobW4raXZhMWVsTWFhOEEydFlHTVBWSU03M0ZqbjVEUXQ2?=
 =?utf-8?B?YVJXWGNYYm9CbXpYci84VFRjdWtSbXFRR3htakpVdFk1ODhvamVYUktSNTl4?=
 =?utf-8?B?bE5UMm9kb29NN2tVWkhBd2pQdm1UeUkycytXbkR3aG1JSkdSemp5ZDlxZWp2?=
 =?utf-8?B?ZFp3M0R2QjZxbm0vOWFWSW9uR0IyUVJpaWt0VHhiRzZBb21iME9xMmk5blpX?=
 =?utf-8?B?dVpJVWdVa3BBVnFmUFArRTVBT2JrOU5NeWJnNm5YVlZTaFQwQnhXVkh6eXFt?=
 =?utf-8?B?ZUxvNldpVnZHNU9hTXVzemJZVm9uTy9mTFdZT3I4OXRNVDFwcjFOY0dhR3JH?=
 =?utf-8?B?YTNtVzdtM2xxVXFBbC90VjhHeEdMYURBdFd1RmxFc2xLRDdnSy9HRlNadmZR?=
 =?utf-8?B?d3JLNzNOdmRmU01RUVpsaGFNMjAvR0MyL2FlNHRmK2Z3Q28wbFBXSWJjbXl5?=
 =?utf-8?Q?FrT63rmXKd4YwWDLnN9ed68nQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a257443-16d5-4ba7-8d0b-08dc7ee82103
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 07:31:03.0975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KoE147Is1KuWsiHjB1FGMTg3Jq4cXP3Q3+K3kGmn6kMBpawjw/qAliehCXzVb3J1cQe3XQV277s7pEp1tXkwkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8760
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEphbiBLaXN6a2EgPGphbi5r
aXN6a2FAc2llbWVucy5jb20+DQo+U2VudDogVHVlc2RheSwgTWF5IDI4LCAyMDI0IDE6MjIgUE0N
Cj5UbzogQ2hlbiwgSG9uZ3poYW4gPGhvbmd6aGFuLmNoZW5AaW50ZWwuY29tPjsgVGFtw6FzIFBh
w6FsDQo+PHBhYWwudGFtQGdtYWlsLmNvbT47IHhlbm9tYWkgPHhlbm9tYWlAbGlzdHMubGludXgu
ZGV2Pg0KPlN1YmplY3Q6IFJlOiBydF9pZ2MgZmFpbHMgdG8gYmluZyBhbiBpMjI1LVYgRXRoZXJu
ZXQgZGV2aWNlDQo+DQo+T24gMjguMDUuMjQgMDU6MzAsIENoZW4sIEhvbmd6aGFuIHdyb3RlOg0K
Pj4NCj4+DQo+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+PiBGcm9tOiBUYW3DoXMg
UGHDoWwgPHBhYWwudGFtQGdtYWlsLmNvbT4NCj4+PiBTZW50OiBNb25kYXksIE1heSAyNywgMjAy
NCA5OjA5IFBNDQo+Pj4gVG86IHhlbm9tYWkgPHhlbm9tYWlAbGlzdHMubGludXguZGV2Pg0KPj4+
IFN1YmplY3Q6IHJ0X2lnYyBmYWlscyB0byBiaW5nIGFuIGkyMjUtViBFdGhlcm5ldCBkZXZpY2UN
Cj4+Pg0KPj4+IERlYXIgQWxsLA0KPj4+DQo+Pj4gSSBhbSBleHBlcmltZW50aW5nIGFuIEludGVs
IE5VQyAxMiBQcm8gc21hbGwgUEMgKE5VQzEyV1NIaTMpLiBJdCBoYXMNCj4+PiBhbiBJbnRlbCBp
MjI1LVYgRXRoZXJuZXQgY29udHJvbGxlciwgdGhhdCB3b3JrcyBmaW5lIHVuZGVyIExpbnV4LCBi
dXQNCj4+PiBJIGNhbm5vdCBtYWtlIGl0IHdvcmsgdmlhIFhlbm9tYWkgKENvYmFsdCBjb3JlKS4N
Cj4+Pg0KPj4+IEkgZG93bmxvYWRlZCB0aGUgbGF0ZXN0IFhlbm9tYWktbWFzdGVyIHRyZWUsIGFu
ZCB0aGUNCj4+PiB2Ni44LWRvdmV0YWlsLXJlYmFzZSBrZXJuZWwgdHJlZS4gVGhlIGJ1aWxkaW5n
IHByb2NlZHVyZSB3ZW50IHdlbGwuDQo+Pj4gWGVub21haSBhbHNvIHdvcmtpbmcgYXMgZXhwZWN0
ZWQuDQo+Pj4NCj4+PiBUaGlzIGlzIHRoZSBpMjI1LVYgZGV2aWNlIGluIHRoZSBzeXN0ZW0gKHRo
ZSByZXN1bHQgb2YgbHNwY2kgLXYgY29tbWFuZCk6DQo+Pj4NCj4+PiA3MjowMC4wIEV0aGVybmV0
IGNvbnRyb2xsZXI6IEludGVsIENvcnBvcmF0aW9uIEV0aGVybmV0IENvbnRyb2xsZXINCj4+PiBJ
MjI1LVYgKHJldiAwMykNCj4+PiBTdWJzeXN0ZW06IEludGVsIENvcnBvcmF0aW9uIEV0aGVybmV0
IENvbnRyb2xsZXIgSTIyNS1WDQo+Pj4gRmxhZ3M6IGZhc3QgZGV2c2VsLCBJUlEgMTYsIElPTU1V
IGdyb3VwIDE2DQo+Pj4gTWVtb3J5IGF0IDg0MjAwMDAwICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFi
bGUpIFtzaXplPTFNXQ0KPj4+IE1lbW9yeSBhdCA4NDMwMDAwMCAoMzItYml0LCBub24tcHJlZmV0
Y2hhYmxlKSBbc2l6ZT0xNktdDQo+Pj4gQ2FwYWJpbGl0aWVzOiBbNDBdIFBvd2VyIE1hbmFnZW1l
bnQgdmVyc2lvbiAzDQo+Pj4gQ2FwYWJpbGl0aWVzOiBbNTBdIE1TSTogRW5hYmxlLSBDb3VudD0x
LzEgTWFza2FibGUrIDY0Yml0Kw0KPj4+IENhcGFiaWxpdGllczogWzcwXSBNU0ktWDogRW5hYmxl
LSBDb3VudD01IE1hc2tlZC0NCj4+PiBDYXBhYmlsaXRpZXM6IFthMF0gRXhwcmVzcyBFbmRwb2lu
dCwgTVNJIDAwDQo+Pj4gQ2FwYWJpbGl0aWVzOiBbMTAwXSBBZHZhbmNlZCBFcnJvciBSZXBvcnRp
bmcNCj4+PiBDYXBhYmlsaXRpZXM6IFsxNDBdIERldmljZSBTZXJpYWwgTnVtYmVyIDQ4LTIxLTBi
LWZmLWZmLTVmLWNmLWQyDQo+Pj4gQ2FwYWJpbGl0aWVzOiBbMWMwXSBMYXRlbmN5IFRvbGVyYW5j
ZSBSZXBvcnRpbmcNCj4+PiBDYXBhYmlsaXRpZXM6IFsxZjBdIFByZWNpc2lvbiBUaW1lIE1lYXN1
cmVtZW50DQo+Pj4gQ2FwYWJpbGl0aWVzOiBbMWUwXSBMMSBQTSBTdWJzdGF0ZXMNCj4+PiBLZXJu
ZWwgbW9kdWxlczogaWdjLCBydF9pZ2MNCj4+Pg0KPj4+IFRoaXMgaXMgbXkgaW5pdCBzY3JpcHQ6
DQo+Pj4NCj4+PiAjIS9iaW4vYmFzaA0KPj4+IGlmY29uZmlnIGVucDExNHMwIGRvd24NCj4+PiAj
cmVtb3ZlIHRoZSBkZXZpY2UgZmlyc3QNCj4+PiBlY2hvICIwMDAwOjcyOjAwLjAiID4gL3N5cy9i
dXMvcGNpL2RyaXZlcnMvaWdjL3VuYmluZA0KPj4+IHJtbW9kIGlnYw0KPj4+IG1vZHByb2JlIHJ0
bmV0DQo+Pj4gbW9kcHJvYmUgcnRwYWNrZXQNCj4+PiBtb2Rwcm9iZSBydF9pZ2MNCj4+PiBlY2hv
ICIwMDAwOjcyOjAwLjAiID4gL3N5cy9idXMvcGNpL2RyaXZlcnMvcnRfaWdjL2JpbmQNCj4+PiBz
bGVlcCAxDQo+Pj4gL3Vzci94ZW5vbWFpL3NiaW4vcnRpZmNvbmZpZyBydGV0aDAgdXANCj4+PiAv
dXNyL3hlbm9tYWkvc2Jpbi9ydGlmY29uZmlnIC1hDQo+Pj4NCj4+PiBUaGlzIGlzIHdoYXQgSSBz
ZWUgb24gdGhlIGNvbnNvbGUgKGxpbmUgOSBpcyB0aGUgZWNobyBjb21tYW5kIGZvciBydF9pZ2Mp
IDoNCj4+Pg0KPj4+IC4vc3RhcnRfcnRuZXRfaW50ZWw6IGxpbmUgOTogZWNobzogd3JpdGUgZXJy
b3I6IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkNCj4+PiBpb2N0bDogTm8gc3VjaCBkZXZpY2UN
Cj4+Pg0KPj4+DQo+Pj4gVGhlc2UgdHdvIGxpbmVzIGFwcGVhciBpbiBkbWVzZzoNCj4+Pg0KPj4+
IFsgICAyNS4zMjU4NzJdIGlnYyAwMDAwOjcyOjAwLjAgZW5wMTE0czA6IFBIQyByZW1vdmVkDQo+
Pj4gWyAgIDI1LjM4OTc5MF0gcnRfaWdjOiBwcm9iZSBvZiAwMDAwOjcyOjAwLjAgZmFpbGVkIHdp
dGggZXJyb3IgLTINCj4+DQo+PiBBY2NvcmRpbmcgdG8gdGhlIGVycm9yIG51bWJlciwgaWYgaXQg
ZXF1YWwgdG8gSUdDX0VSUl9QSFksICB0aGVyZSBzaG91bGQgYmUNCj5zb21ldGhpbmcNCj4+IHdy
b25nIHdpdGggcGh5IGluaXQuDQo+Pg0KPg0KPklzIHRoZSBydF9pZ2MgY29kZSBiYXNlIHdlIGhh
dmUgc3VmZmljaWVudGx5IHJlY2VudCBmb3IgdGhpcyBOSUMgZ2VuZXJhdGlvbj8NCg0KTm8sIEkg
anVzdCBwb3J0ZWQgZnJvbSBvbmUgc3BlY2lmaWMgTGludXgtZG92ZXRhaWwgdmVyc2lvbiB3aGlj
aCB3YXMgdXBkYXRlZCBhdCB0aGF0IHRpbWUgd2hlbiBJIHdhcyB0cnlpbmcgdG8gaW1wbGVtZW50
IHJ0X2lnYyANCg0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQo+DQo+SmFuDQo+DQo+LS0NCj5T
aWVtZW5zIEFHLCBUZWNobm9sb2d5DQo+TGludXggRXhwZXJ0IENlbnRlcg0KDQo=
