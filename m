Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C426AB9
	for <xenomai@lists.linux.dev>; Thu, 27 Jun 2024 01:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719452451; cv=fail; b=B+9+FNCURYOfZnTYYCt6PsPrw1WHxiEzLyMhisw0cadZLqYt9l9V00r7Xo7VKV7ERKOb1meECWAIm5WOiXBh6hGEsYNpcNVFVgzlRV5oEGDvn7AcB4ZgjTgNahlHvJ+gqWIASIhkNy/unbWt+RRKVAx57/64FM5/oGZadOJRrvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719452451; c=relaxed/simple;
	bh=21PmDRYLZYhV+Jxj4mM6thfCXVp+ImpbvoPOTvnwvwY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kQ7BiNYZu3c0WYccHdlS/GQD1M9LXgNhvxA4rD803VMa88BhzM/+BpwgQdCau3m8zGeha1mJL2/YLtZa/O/wWqE7EVcmmtPX0QWEDcYamrKHzu835EKB+tkcIeDCUA5DBS/Ze+1oibDnhDh5oq9vpdulEM6Jdm0KX2ZqOKDjGlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fbWZ6tr/; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fbWZ6tr/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719452449; x=1750988449;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=21PmDRYLZYhV+Jxj4mM6thfCXVp+ImpbvoPOTvnwvwY=;
  b=fbWZ6tr/M2oGwGYNmrldVwC+SMSDNZMSQGgvHKkCDXmAZg3YO8//tEix
   FKNndyIQ8RBFFxyvPv5ykvd2zD1ARjfMD3uqITJxlxEgbSWD2ykEql/Sh
   p3GHpzq5WkAPLnjISUO1RAbRg8t1ggrFXTJlxEUsMlZIvHc3bdKD5XmGa
   8MjuNvfFbt9lwMNoL9qIEjWAUfgx/zTOYkwD6FSa1MkSQpTrIIA3ERqRT
   YzfeCfrMr2dgtDnct2HNcrPquzfollOmJ+hFaxQSaDbR3A+WSXWSxEPzG
   8nFVP9/AMDH8Hc4WOTOZKNGzEX2ybvMastx91pHW7R1btt1dhNQ91xT8w
   Q==;
X-CSE-ConnectionGUID: gNN1cXPJSiug690C9P9sIg==
X-CSE-MsgGUID: qCHWYlkQQwe6NekIvEymIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="27146987"
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="27146987"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 18:40:49 -0700
X-CSE-ConnectionGUID: XmfJXLRZRregwgpiV31R5Q==
X-CSE-MsgGUID: Z9oazNfzSaOdqIFqwjclJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="49137031"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jun 2024 18:40:49 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 18:40:48 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 18:40:48 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 26 Jun 2024 18:40:48 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Jun 2024 18:40:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4p9ivp4Jp3Z6NIoEIUGT9lncLwMmWAgD0qruTSSHTlVFfEct2x/XtWDoiFHZn/NQTT6vIkMIMQkGiaTBllCZ520eonsgSPewmSd2rH+HJXwaqk33qiJC9hPkbzvOIBsx5mYh18hR67/S//pcvGCL9j6ZDNN8bX/dGT8AyqsiuKhAmnSKNFZ0lNeexYXxFVlZQ/aYq4svyQNT79vAXWCEP1U3yVyCZchHRicdFjGB+s9Cwz/9ajFoIRhgnhUSFgT6vVe+LxblfqgtgezNXhb92muaRNnsfRCrJXCgMi3Ho+8HlIMAPDoEL1ceMEQlHrM3zhhxi3wsQ91zqtQl8gm7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21PmDRYLZYhV+Jxj4mM6thfCXVp+ImpbvoPOTvnwvwY=;
 b=IfJEXqKJgLmWGYoscA2YNCYlAyvMwnej584Hl2SEDFUJDHmJGytnH8hItHVm3BaTjL6aO2As7TshXcXWXrI6j8H9EsH/E1RLfOv7LbiP2xJmoNZdoWVvwmgyz74fDn69KoU/YzaWk3rjTiZiMf9Gw35AdFVxiZQIYYzhozT0jvhbHDmFKoj2dPvNn6fPJ5+tItE1FjxMy4QXobnx9B0ksvXauG89jF7mDr+jdiZ8FXvkyvyvdw6xjZTVVdNgyuF+/sQT91s7Erz0u2eKW202bhBXEaaugkFIncOjkgUuo1vQlXJHYtKNDNPpuiCVUbwBgGpIPZOghIdVeFuGUooNTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by BN9PR11MB5275.namprd11.prod.outlook.com (2603:10b6:408:134::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 01:40:41 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d%7]) with mapi id 15.20.7698.033; Thu, 27 Jun 2024
 01:40:40 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Xenomai Community Call Minutes - Jun 26, 2024
Thread-Topic: Xenomai Community Call Minutes - Jun 26, 2024
Thread-Index: AQHayDMEXWdbSb6Hh02hnuAWFqz+NQ==
Date: Thu, 27 Jun 2024 01:40:40 +0000
Message-ID: <PH7PR11MB74992D53E248664E6D075779F2D72@PH7PR11MB7499.namprd11.prod.outlook.com>
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
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|BN9PR11MB5275:EE_
x-ms-office365-filtering-correlation-id: 5cb38c9b-7a11-49f8-16cc-08dc964a26ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ejd0eCtnQmFmTXFmSHpYTXZFWWR5OE1kb094cGhCSGhUazdsZFB3b1Exclha?=
 =?utf-8?B?ckFBeXFsT1J0RUZPbDJqV1dSeGhhNHFHQ0laQW5Rd1I4c0RSUzd6NXlZdGVM?=
 =?utf-8?B?TmNzcm9rNEw4andqckdsRnZ1ZVpsZVVjYzNvb3R4ZFFwUHlPUmF2S2Z3UGlS?=
 =?utf-8?B?RHltazI1VVY5cHJvdDVRRzdiVDJXczJrUEpwZS9EY2JFc1BoYWxYWjUzM3pP?=
 =?utf-8?B?YUZBMHp6QVVucjZTd1lDd1RadUVtNy80OU1HRHpKTVZxNEE2UldQU2pvRUNl?=
 =?utf-8?B?VktQNWQ0UW1SczV3eEtYalBjQ2VMdUxrbHFDQ1EraXc4dm9PODlGWCtXYWFY?=
 =?utf-8?B?RS9pZ0ZJVzFpZmd1Q1ExckdnTllxUEwyUDZXZ0NVYnpUYWNXSnQrbmx5dFN6?=
 =?utf-8?B?RklyMnQ3OWZOWVBCZkl5d0RwdUZRODBJZmRzeHVPZ2w5Uk1YWWVKejdEcHFp?=
 =?utf-8?B?eHhBWEU5VUVEMDdhM2lRdm1xbVBCTmNLMExNcEtJNmZYWHo2QjhRVGdIUkF1?=
 =?utf-8?B?UHZGZS9Xb29sNGNoamxtSkI0bGMxdEFOb1VNN2ZZUzVvM0c1NUxrV1p6NjJ1?=
 =?utf-8?B?SUZFL3pBZHBjaDZVNDlYS2tCWThKa1NaMUU4YmFubHFSRzVDOHNzR0R2VjBP?=
 =?utf-8?B?YlVUMjAzbWZpZi9VOTZ1SmtYZ0kxRmNuYUQrOXdyNTlNZEE0aXQ2ZzFBUVgv?=
 =?utf-8?B?aTFCYUE2MDdqa1AxdXREYlJNVzZZcmVSOTZHbWgyZWFsTHZWMklZUkt3T21D?=
 =?utf-8?B?L2E2YjFCMHlNWDllRWRPQk9MM3B5V3QyY1NWeVZmZ0lzRWh0eGpNN2hzMzRQ?=
 =?utf-8?B?WHcvZ2pzdXdtZy95TGQxNWNkU1pIVm02Zk9MSnJ4VytJWjdvTHIzTG91QTlt?=
 =?utf-8?B?TjVhcG1abDBqa2F5UEorUDhuZW5EdDZCNWtSRkZhOGpKQ1d3cXlyN3BaVFhW?=
 =?utf-8?B?dVNTMnVqdnVDc3psaVprNXUyaktnc3krYlF2bUx3NDJIWW5Ob0RsSmtYbnVJ?=
 =?utf-8?B?enpsSk1Kc3p2emYzN0IwL01ibEc1anBVM3pQTzNocjk1Q29TTUgxZ1lFKzFJ?=
 =?utf-8?B?UjN4VVhTOEY2bTU5cndNYUxGVFppNnVXdXNHZGl4V0l6UEJBTXVLaTQ2RWFU?=
 =?utf-8?B?ZGNYMTlSU2tsd3hlc1d1TnpsZk1udE9yU202TUdSNXhhbGlSWUV6MUJsWVk3?=
 =?utf-8?B?RFdBK1g4TUxTUmNoMi9FcmJBQ3ZTZHZZVDdEUEYvdTExNEp2RDVma1lxK2xR?=
 =?utf-8?B?WXFXaXM4b0V4bU5ReklvN2F6dkh5U3FsQmdjQWhWc3FqdWRNQ0pWS2JPdU14?=
 =?utf-8?B?Q1hJaTZPNjdlWVFTN1dubjIwL3hybml4Y0JuNE9IRnhFelJMWjR3NUpJSHFZ?=
 =?utf-8?B?cmZvN05KVHl4YXZmaTdMWEtRL21pTE9LZ2c0WGd4VlZmL0hVUUVVMWpGTTYv?=
 =?utf-8?B?bmQyd0tDMWxtTWFJWXBibnRqWXBxQXpCbWZtdmRpeDVML3ZYY0hPT0t6bDlT?=
 =?utf-8?B?cFQ0UFRsbVREVG1sSUZ4RUVicXdVZmVadlJOQUpGbDRycXZ4UmhBaUg0QlQ5?=
 =?utf-8?B?bDNnaGlEMXNGR3hTRlpUbjhIbmFWb00rRmlkRmdKVGhyUWFBV00vZEV5dVFC?=
 =?utf-8?B?VUxyYURQMTFRcS9KZks1WTJQYzhna1R6Tnhpdy9xTGU5dzZTWUtOMXI5S2M0?=
 =?utf-8?B?dkdwWnFlWXpsci9kNUlyV1FCMTNUWXczSlF3elZ0SzJQVkhwMlJyZWJ1VXYr?=
 =?utf-8?B?SThWc1Y1WnQ4L0YzVlk4S2pFbDlIS0k5OGs5NU5qUDlHQVBpaFMrR3lkelU4?=
 =?utf-8?B?aGN0Y3dsQk45ZTc0aUx2NDVDdW1OYm91SE94S05xaUlPV2FGOFVUQ2w5ckRq?=
 =?utf-8?B?L2IzZTcxdEpid0xoSm5nQysvMHJFYzJWWEFzQWRCTnQ1QXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUFoNzYyZy9IaEtrbFZGaUxvVXFHNjVxcTBNNSt1alpQTUJ1dC9TVVBJWG1Q?=
 =?utf-8?B?T09CbmN3UmpxQ1krcllnVWJaN0liOEtZMEZzU2t2Z3dTYkJkbGlCV3NiQkZL?=
 =?utf-8?B?ajhvS0VPcmJkOTBzN1pXSzBoNzdZUW9ueUVha0tteTZtdnRPUWxWRkNpd0Ir?=
 =?utf-8?B?bWpDeUczNlJoL0dUcGFlSktLMlE5Y0dUSFlvTGdzblg4MmJMd1N6elFqNUhn?=
 =?utf-8?B?SjNYNGdBSDJsdS9UeExzeVY3dHNBSzZNT25nd0xDVEY2TXVXbytEVWc1MEtV?=
 =?utf-8?B?MzE5Z2xZUWtSanNxbUtYYkJ0T3VBWExOOVFvMURHOEN1SkhMMnY3d0MxNmZW?=
 =?utf-8?B?ZzZrUUhWc1loSW9UK1gyVzlNbFZZbjh5eXN0RjlibCtyY24zRVhPVXVNVXBo?=
 =?utf-8?B?K2J1Q0grK01sUzFQRjVlZkdOQTM2eVgweHBFd1RtZ3BEb3dmTXE0US96ejNy?=
 =?utf-8?B?bXpFQTIvd2c1aTBSYlhxa0RsK1ZOaW9FcTBvTzRuUndQeVdURW1qRkppOUNC?=
 =?utf-8?B?eWFRaVNNNXcyeEJyQXBhNzNaZm82MDhKWngyUnVSSnh0eFBuV1NWamVEN25Q?=
 =?utf-8?B?YzNubVoyQjF5TnZBTVZvK0tVQjREOGNBVG1ScEJMdEJqSnFPSCtmM25HYkxw?=
 =?utf-8?B?eHpvVld2Q0JzaS9aQ3NXeWZ2RXRheWt0ZHVrYXprZGVaOCtKbDBhYWlTVDB4?=
 =?utf-8?B?UDVOb2JtMk4zU3c1ZENuQU13L1U2UWEvTkpEb0MweDBhK2xFL0YxWDRaQkZT?=
 =?utf-8?B?blRHNkNyQTNhaHRBRDZMem1XT0dpMzdTemVIbVREaTk0YnBzdFhmemtGVUF3?=
 =?utf-8?B?RW9UNWV5UFo5VHk5NGxGdldtd00rMzFhdFBDZGVtdjI5TUlCaDlrdXlXMDRZ?=
 =?utf-8?B?RHVHVktVYUNrSG1lcWNYdEVtNitTSGJJVXFCSENGZ0JEZmsyWVdyaDJOQkNU?=
 =?utf-8?B?ZUxpc1VMNmpOUThJSTBtd2I5ZTY1Tlc5YW9lUE01NGhZbnJvcFp6cTcyTlFV?=
 =?utf-8?B?OTNRWTdiYjlBWVN0VHA2VHhTZzJDNXQ3U0F0TXg4b1NIMVVzcDBjYklZdlhT?=
 =?utf-8?B?ejdUamxyU3N3WHpnc01VN3ZZdDhBUS9FTFNMby9pOGRCRitFMWlYbGNyLzZW?=
 =?utf-8?B?dkVPcnJ2Y29UU0xOM0p5VnZuclh2eWcyVU1ZeHREUEcxZWVOWmVXek0wbVFT?=
 =?utf-8?B?MHEreS82cjRib1hPKzJpOE1rbG5sSnVmdmk1dzFyUTlCTEQrVU9wbFpCMEht?=
 =?utf-8?B?ZGw4ZHlKaEhnTXF5aVQzc2Y0d2lVMzl6SGpRdktnN1FWOGlZMXZqYUFHVzU0?=
 =?utf-8?B?YzQ3UUo4d0xodDJ6Q2g0OFJ4bTE2OUJEMU14ZzJhOEpGOFl2QUthdVNDOFVD?=
 =?utf-8?B?UlpRSFAwUWU4eCtVaFBXeldZVi9qOGdHVEtETVBqT3lGTy9OM1ZRcmJHUWVl?=
 =?utf-8?B?T3RIUnBRMzBNS1ZBb2d0QUF6dENXMlFyVjdBaVJwWnprbStYeitKOFhTRXZr?=
 =?utf-8?B?bDFHWGtVV1BaVHVRamxvVTBLNm83a2hjd0czeEVJWS82Rkx3TW5rcTRScS9n?=
 =?utf-8?B?ZkhKSXU1UHBjK1c2YlozUW5sLzUxRHBFSEFOR2FFek1nTy9HVnNZZDhMeFlq?=
 =?utf-8?B?UlhrM2NCMGdUdGhPRmdPUVVEd3BFdmR6UzB3ckFMZldLZjMxLzdRSDNJdVRq?=
 =?utf-8?B?M3E1dHQxYnBQTHhNUjhHdVRmN3JJMzRjVmZYdFdjY0RON2hsVEk5Sk9aYjBk?=
 =?utf-8?B?N1FMcjZ2ODVsL29vTXk5c0FxdWdGQUtBOU03WnpGRFZuUGNGZy9TVmQxdXI1?=
 =?utf-8?B?MFU0ODVXd1RmYjhhRmxReUo3WHQ5UjgvYW9XQ0o5d01MVzAwMEJDMTJWem5C?=
 =?utf-8?B?ZEs2REZRVXBma1ZwVUR4QnFER25hT3YrdEpTL0U4TlpFU1ptbW9oWEM0UHlB?=
 =?utf-8?B?L3JoeEVGQ1pCaHlUbGlTU3p1WGs1cGxqVUhYSzhoNExLWDlLN0x2YXlzYnpQ?=
 =?utf-8?B?OWwrWVJmOEE2NVBWV25OUjdoRVgvOXlvMVVpZzNoUE1xbTA4OWhPR0tkQU1H?=
 =?utf-8?B?SzlUQ29acDdjREhsTllYVVV6WEhzeHR5Skx1RmZtdVpad1Y3SEVZN1laUU1m?=
 =?utf-8?Q?K5x9SNGNe9QjYPBAR17y3EtVT?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb38c9b-7a11-49f8-16cc-08dc964a26ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2024 01:40:40.4318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VPyJu5OEajyDmIQG6mQolEwN5Y65nburSYxwwQGk4J9adST3xbODaF4tm6t33/LaM+WlVB+yAhjp6+Jf4+3jSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5275
X-OriginatorOrg: intel.com

QXR0ZW5kZWVzOiBKYW4gS2lzemthLCBGbG9yaWFuIEJlemRla2EsIFJpY2hhcmQgV2VpbmJlcmdl
cg0KCQlEYXZpZCBPYmVyaG9sbGVuemVyLCBMaWFuZmVuZyBMaSwgQ2xhcmEgS293YWxza3ksDQoJ
CSBIYW8gTGksIEhvbmd6aGFuIENoZW4NCg0KQ29tbXVuaXR5IHVwZGF0ZToNCgkJWGVub21haSAz
LjMgcmVsZWFzZXMgc29vbg0KCQlYZW5vbWFpIDQgdGVzdCBob29rZWQNCg0KT3BlbiBkaXNjdXNz
aW9uOg0KCQlMVFMgbWFpbnRlbmFuY2UNCgkJWGVub21haSAzLjQgcGxhbg0KCQlpR1BVIGluZmx1
ZW5jZSBvbiBSVA0KDQoNClJlZ2FyZHMNCg0KSG9uZ3poYW4gQ2hlbg0K
