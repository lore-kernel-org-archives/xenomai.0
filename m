Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06961779B8
	for <xenomai@lists.linux.dev>; Wed, 11 Jun 2025 04:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749615823; cv=fail; b=ihYMfrW9U4z/uCPXzfLrSxnxiudDEBFM4Zbmqbf2KI/VCJAkiryahq93Hhm5WPhbYAJw049LVeQrbVM90wUngyICPKu5XAqqjFrM438CZImTgXuJ9ZttUcnoN5BqFsb7cuCLLmqHk+FOsAk1zGSf39Ge7sG34fo2xCoLnW+SqTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749615823; c=relaxed/simple;
	bh=7PgFQqQnG6HQ4TNF9Fp8vwsP4K+rZrO4vcpvXdj9qmY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m9GhvYBqByyPy4/HnIWK41cXFhQd+Qigl2gX9A3pnyjmLEbUm20pR7bPXK1W0I34tEP2TFg6xErszbrvvldol+P8vQlah8Z41yoLvleNrR8Pnx/iTYfvAx/G1w9cUnCwt7HixwiJVK623PVVRMjXoosR0bVmEFUHSiASz/dxOhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D9U0OArD; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D9U0OArD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749615822; x=1781151822;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=7PgFQqQnG6HQ4TNF9Fp8vwsP4K+rZrO4vcpvXdj9qmY=;
  b=D9U0OArDjxE0ZFWb84nItWx+PeyxxX2WMZ1fRwxRoR8UszBEp51sYTu5
   VIiRJMaxkKEnfXMXRfP+a9cHyrAGysAMV9TFu27JwdgJnCdCmF4S6FwCI
   DgnG03ptFb9zhbEAlEKvfsPilvGqJ2gonhOi4YYmO6Q4nbhrqIjPBnMe/
   5TbtYHiIShQqtG4lVDQZysQBKUYHRoYthSLVA7kI7fdvkNrq4jSHAlg3v
   K1Q5VObP/V+SFQTtKE8VyIt3u1T/mPVxfSy3bDDyYTMUxqwoxIbB7CvIo
   J7TTxWIRa5YRBaKjSD0hUEfg449/RhhI1b9Yc8vxgOdyr5jLRcNvjhWg0
   A==;
X-CSE-ConnectionGUID: eKALkWARRm+W+8x3Sfk9cw==
X-CSE-MsgGUID: yEJNo0fYRZmuH8lkxK7NiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="62782310"
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="62782310"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 21:23:37 -0700
X-CSE-ConnectionGUID: n4o8a/CXRHSCmibiOqIA6A==
X-CSE-MsgGUID: XZs5NkztTK6e+pnhK2OfMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="146946131"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 21:23:35 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 10 Jun 2025 21:23:34 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 10 Jun 2025 21:23:34 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.48)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 10 Jun 2025 21:23:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LwxMoJlxCmQ1W5oUlBNjtzB89gcyHcMyF4bUXgpatpFNKlHfFHSEPp7bvaGk8jg14lJSQG+7zONdu5/ByqF4YV+uE4c89iAWCxHLmlTcC0khp2HMQrsVVKor3tSFpQyMojelhiF0qOfp0acb/t/nrn9/OGEMwmArFPLMc/3KplQFuso1FkBnVWztRLOXexyu4u+1YFcvtvAtLz2qBFludWb4Py8+/8DzyKjpVPx49YU0WpozBlbKx2Iu4yzleH7X76Yz8Aa5U9+L+1BnaF1WZfkc1dgMcuYxJcoN9jxGiBCZbFJjmoFyYUZWGbfBnVOfq0ZiAekEvLZ1/oREPtt6zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7PgFQqQnG6HQ4TNF9Fp8vwsP4K+rZrO4vcpvXdj9qmY=;
 b=w7VIWDKzvbKKbXjUjcAtIbltKPRFu5TiZg6LIVviFD9n2qGVMiSBqiV+GkjJYdccQFsbAE2JNLpWFWMFDnEoWN2v564ZfvbCSo/NdUMRS6IPWFcU5hjyXHVHGhl4lbG+D4MvztL1OgIgim0a7KgSMGbNSNqxBUMitItlGfekAMbCrthCD03I4EHomZGWgT3n8k+kqbhAwoqgarzG8zlriJWMtUg0od9ZEptwGRBw406ovtjHYqfbM8NJP3FB5In1X0kmS/65fZcBp3jX6M9WJ1zZpvhKm9InzYg7cLl1OtQhzh66bzvHYDoCMDAkquGBIm4SGQyGCjMX4SafNnov7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7489.namprd11.prod.outlook.com (2603:10b6:806:342::14)
 by BL3PR11MB6388.namprd11.prod.outlook.com (2603:10b6:208:3b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Wed, 11 Jun
 2025 04:22:58 +0000
Received: from SN7PR11MB7489.namprd11.prod.outlook.com
 ([fe80::7a00:833c:79b:5e48]) by SN7PR11MB7489.namprd11.prod.outlook.com
 ([fe80::7a00:833c:79b:5e48%5]) with mapi id 15.20.8769.031; Wed, 11 Jun 2025
 04:22:58 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: xenomai <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday, Jun 11, 2025, UTC 7:30
 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday, Jun 11, 2025, UTC
 7:30 AM
Thread-Index: AQHb2oiDcrn8q/S4tUSyZ89kHI2pDg==
Date: Wed, 11 Jun 2025 04:22:58 +0000
Message-ID: <SN7PR11MB7489BEF822E21923EE582FD1F275A@SN7PR11MB7489.namprd11.prod.outlook.com>
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
 <PH7PR11MB7499D5045E7CD5CC207EADB5F2D92@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74997D0A2A025EBDE30826D6F2BD2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74998FCA330C96F94503AF18F2832@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499BABF9BDA783C86090B60F291A@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499C2C6A4E4E6239A05C979F267A@PH7PR11MB7499.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB7499C2C6A4E4E6239A05C979F267A@PH7PR11MB7499.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7489:EE_|BL3PR11MB6388:EE_
x-ms-office365-filtering-correlation-id: cee74984-543d-4da1-7857-08dda89fa59c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MlBsVWsvUUtBbnMzMW5BQXIxcURxTHozQVRFK2dyS2dUZkNxaFVFRnFQdlc0?=
 =?utf-8?B?MTZ3SnlmeElKMXdPRjV2YjVXZnlJVjZWbEhLUFR5K21QdHdPZTV4aEVYZExD?=
 =?utf-8?B?L3hLK2dtcklLdi9aK0ovUFJqampEc2Q0b0NWUldWUXlOMTVrV0NiZjQrakFy?=
 =?utf-8?B?ejROVElMaUplcnQwNlByZDUyTnV3OUVXaW1vcnlnZVFEZGNTSjJaUVpRaGNH?=
 =?utf-8?B?NEdUWFN4a0l6NXA2RVc1eHArTUVsN2RjMlpaQ29FU09sV3BqQmtNY0JhcStP?=
 =?utf-8?B?QUEzU1JQQWNhMlo4d1VOYnM2VXJvbU15ODRCS3piVEtmbE9ZL3JDanVOOXZa?=
 =?utf-8?B?bVhYUXg3VWFUQVpqRGs4a0k0RnBDVENORHlKbGdSRjYvZFhobWI0OHRpTVpJ?=
 =?utf-8?B?MWpoU3JXb09MeGFNN0hCY3MycnJXQTNTK1R3aWhyR25rVTBRcmk0d0VYL1lp?=
 =?utf-8?B?dUEwOW1LYXY5TXNaVmdoMXIrYnRSMXk3clhVdzRSNFFHeEdyUmJJV1Ywb2xL?=
 =?utf-8?B?VSs1WnpTSmFoejlNa2t3Vzk4cDUreGdTaG1JUGF1WllQL01mSW1IcGllMXNI?=
 =?utf-8?B?ZjVQQnY0TjNrQ1VMSmcyaFdtZ2l6RnBiL042U29ZaVZVZUJrZmZxMTJ1eTAz?=
 =?utf-8?B?dHQ3SHN2a3dTTU5iODdTSlNibzE0L2M0YzlobURUTHJ5OWRmRWxmVG00V2lS?=
 =?utf-8?B?alM5Z1F1NFlZc0YxakI0MGpSeDh3bmNtN2xFNVBoSzZ2cmxLM2pqM2UrcEsw?=
 =?utf-8?B?L204QzJqc0R0QTdNSDhGUkNySFVWRXFONFNLTVd0SXZxZE1KZGd6cnNaUGZq?=
 =?utf-8?B?bU1aRkxGMXpBdFQreXJQeFRlZXc4Q2NSYkVtd25tcXlOUGI2OWhvbWk1YjZa?=
 =?utf-8?B?amhWaGVnNzFCWnptM3k2TjFTWncySkZYVE9UcTFnLzg0ODFDMEpTdjVtOVhs?=
 =?utf-8?B?aHlhQTYxUkhlZHhSMlQrT3JKNXBjY3MreGVSeVZjMU9VUzNKSU9qV1JDMUpR?=
 =?utf-8?B?NDJ0WUpkOHJlQU9XWlhQbUIyZVZwYng4ckFjZklRNThzVzcyQU5CMlhCejVs?=
 =?utf-8?B?dVp3NHVGcnBML29uTi9FRmNwOHd4N1VMY3RGeW9pL2U3RkNRTllUUWVCMDlL?=
 =?utf-8?B?Tm1iRzhmdTdxKzdIWWcxTUhrY210WWdSMGx2TzJGblRCczRGYlJ3bGZIWDBi?=
 =?utf-8?B?dkF2ZFVjZWtCaHE3blh5Y1AwNXorcDhHNUFTSVZIQWZlS0FtUDdhWHVVeGtw?=
 =?utf-8?B?c1BINjVEZkl5VDQ1QS9wMXNaZXNJRktYVEw3eHUrZzJvemcyQW1QSnFldmNx?=
 =?utf-8?B?Mi83NXZJa0h0YStkVldIOUh1N2t4cHB3YzducmpUOWRpcExXY1pqdXBrY2pD?=
 =?utf-8?B?OGE1bnBMclF6Q2xBejZDcUNNZks5ZHpMOU9JOURxY0NwVTFSYThNQ29LN0Z2?=
 =?utf-8?B?OHZBVG5RdmVQTEpZaFgydDFIdUlWaGpFVDhmQ2tlSjJKWHRiMTdJZmwrSnVK?=
 =?utf-8?B?clpKRUlPdk9EV3hqNlAxaVkwKzlwUFh2L1BMYjVickEzNDBRTXVyV3NQWmtD?=
 =?utf-8?B?K21OZDZBN0hkNkhWSzByb3pCUUxTeDhPUlpraGtYbnJLZXpoY1JBMW1qQ2Ji?=
 =?utf-8?B?d2hlWHBmQnlGc05YWDBLT01Xclc0S1lrWkhRZ0JQNTJkc1UvZG1HdzJMTTNj?=
 =?utf-8?B?T2VuMmFSUG4yQkZ6TVB0ZGFneWxuVXYwV2NnRUp1dUUxNFo4VzFNaEZ2YkNt?=
 =?utf-8?B?MWNUM2F5S3paeExaVnd3ZlFlU0h1U2dCVGJhRTAyR1ZEUndIenpsaXl3WlRk?=
 =?utf-8?B?SHFpcVdIejFUOUw0Ti9acWs0eFJDYjBpTWJ5ZUJwN3hkNWtXUWFMSWpocDBX?=
 =?utf-8?B?VUZPTDFpMjJHdFNtaFRqZ3Q4OUN5ZFE0em9aNzhYSTFNL2xjQkx3blJWemdP?=
 =?utf-8?Q?xxCffd+IOqQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7489.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXNSVzNTMEY4dG9ndEZXT1gyWlFaRkoxQ2tJd0dzOTYwdEJCTkg1YThjaHE4?=
 =?utf-8?B?aGhVamVBcXVNRFVXSFpHeXZvanFIeDNVMVRxVithZ2ZtajZmcjRzSlhmdTNZ?=
 =?utf-8?B?RU1YdnBUWUVKZGsrdGtIdml2cmJCTmJLem5WOTF1YUI5OEwzN1FMakdNOXFq?=
 =?utf-8?B?c0x6eXBkQzlxdEdyU2o3RVhVRnM2QmRoTGNmdnpjWXhVM25Ud2FSSXJSZnAz?=
 =?utf-8?B?TjhIeXpNS3JLOTFxV1dUMXdFQ2F2bzdOaXM4MmUvTE93cEF0OGIvSmhsU3lm?=
 =?utf-8?B?TGg1SkxqLzNGbjdIWDQ5ajRubzJFUFE2eU8zK3E4VGloNzZJTmZkQkNnMVkv?=
 =?utf-8?B?ME9ZTnR5YlRGUTFQZE9LQWxlaHRjOGU3RmRPeThrT1lQMWpmeXIvY3R4YWZs?=
 =?utf-8?B?cGRNQjdJbFNwU1hhTGNBUk9IVzFkSjQyUmtDbWJ3MUY5bGMvVFBGeG5MMzZU?=
 =?utf-8?B?S1hOWEkrUEF0QlhnUitaSms2N0Y0dnd5R0VxejdhS09kOHFTcXM4SWhRM3gr?=
 =?utf-8?B?MmlLMXNJSlBBN21FQU9HM2VHRkZ4VmtEK3Q0bGRVMUJiUSs2QmlSYlFLUE5u?=
 =?utf-8?B?N2lUTm5pczVjWUl3Mk9kUXZHeDh0RTF0NHJZMURFZks1ajNoUWFWU1pndktV?=
 =?utf-8?B?aGV1aU9MSU4waDJDRGFUcEhaQ3lUQjJVbXl5UXU2T205R2NoMFRXcVRFQU5V?=
 =?utf-8?B?V2xkSm5WRFVDSVJ2N1VEWlloeDNoblNHMkVXMUc1N3hxOCtmSU9JbDZYMVEy?=
 =?utf-8?B?ckNTbFU0cC9ON2NTZDJLYnl6TjlxM0hmbzNkbUY1b2hTZFFkcHBzbjRUV2No?=
 =?utf-8?B?SENXa0FVdUxETW12M1R3R1dRWTQwSXh2ZEIwSkM4b21xTklxRG44UnVSUGNK?=
 =?utf-8?B?dWRHQU9ac3Rmakg3NThCQXNmZ2VjeUpZOHczM0lrTjYzVlpMbzZYbDB6djhI?=
 =?utf-8?B?b0ZkM2J1Nm0ycWRmRVRpYzdVTHhCUTRWUHMvcTlFRUdIZ3ZpUHBDTitSWjJK?=
 =?utf-8?B?SnVhMGNKQlJibEZBb251eDh1bWNKQ1RZd0NPODVPVTFDeVpPNGlld3MyR0J2?=
 =?utf-8?B?cUpMNk9uZFN1TmxzRHRidWsyK1kzVnl5VEpXT3pFWHIvYUticWNtK1J2NFFU?=
 =?utf-8?B?NXlNTTBBTjdpU0pRekVoQ3g3ckhIbjI1VGd3MkRkQjA5aFA0VHZqOG8yNk5O?=
 =?utf-8?B?clZVaHN2R0FvUEU1M0Y2V3N1Z2NpWWNOaGRuQXM2RHpKdFBNL0U3VmorN2Vz?=
 =?utf-8?B?anVqT0JqWnBlY0JYRHFsT3hEUlZ3ek83OWhVU2VSVEpJQUtDQjNJa3V6TnNw?=
 =?utf-8?B?Mk5Vb203WHZRMVUzYVZQcU9CQ1JUR0RzNzEyRGRDbHJuQTAvdmgrdkdiOFhJ?=
 =?utf-8?B?N0JwNlJYWTJlUDVkZFkyWFpkOW4zczFFV0JIbWkvUW5lU0l3WXdWY1hTeThB?=
 =?utf-8?B?VHBoOG93RDFzUkNLdnhPVkZMMUR5MFh6KzZoejFVOWdNNkphN1FDMVZ2RGhP?=
 =?utf-8?B?Sm5XWFVPbmxVcStIUTJQUm9qbzNJcjBZcFRvc3ZRNXhHMDJPNFgxZi9BZHI5?=
 =?utf-8?B?OUhDcmJPRWJVOHNtVnlVSGRUb1NveEp2RnpiK1Y0U2dPNDBzVHR6WE9RdEdH?=
 =?utf-8?B?MW1mWituWDVROSsvRkZNNEtRUzNvTWJaS1lnd01Ja3VJT0JoMk1OTEZ2WkVV?=
 =?utf-8?B?ek5kb3FIZE9GR09VQzBGSENlMlJqTzF1bklRY01IUjRjdVN1UzVyTUpaZFRZ?=
 =?utf-8?B?dSt6S1hhVGJyRnhLWmtkanRXclpjbjF0VkFoTDZxRk02em1DYTFib1krbSsz?=
 =?utf-8?B?amhvZGdEU0hHWDAyK2RUc2xvcGphSm8zbUkyYThZak0wTzYwVm9QSEFvZFhu?=
 =?utf-8?B?S3ByNHN4K1RyUzYzUUlyeVQ3ZU5oUHhCY2V4VGsvamlDRFNMK012d1AyQzNO?=
 =?utf-8?B?RFRUNUpHOUQ5cGNhdlAzL2Z1azlTcGF6azVod0Y2VWZGb2dWa3hXbHNjMGd6?=
 =?utf-8?B?WUUvUDZQM3RwRmNwTEdvWFdveE8vaGt6S2MrUzVwaFdtQ0wrN1VLMklBVXBM?=
 =?utf-8?B?QndMbVBXRlBLQ1B1djMzaUppcW93QzljTnN3VVhkczRDUGttbVFjRnFVOWor?=
 =?utf-8?Q?rXMSu97mRj4RkjDVAc2kVXdou?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7489.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cee74984-543d-4da1-7857-08dda89fa59c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2025 04:22:58.7544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VMKC+0fq+ylQWNb8Aq/thwo3aenG/sHzqz1uo2X1zu86xG4sFqAxaLu9Yrp1v84kszYlHUZwlyewfXM1HaKUSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6388
X-OriginatorOrg: intel.com

DQpUb3BpY3MgbWF5IGluY2x1ZGUgYnV0IGFyZSBub3QgbGltaXRlZCB0byB1cHN0cmVhbS9kb3du
c3RyZWFtIHByb2plY3QgDQpwbGFucywgc3RhdHVzIHVwZGF0ZXMsIGFuZCB0ZWNobmljYWwgZGlz
Y3Vzc2lvbnMuIEl0J3MgYW4gb3BlbiBvbmxpbmUgDQptZWV0aW5nIHRoYXQgYW55b25lIGNhbiBq
b2luIGFuZCBhc2sgcXVlc3Rpb25zLg0KDQpUaW1lOg0KV2VkbmVzZGF5LCBKdW4gMTEsIDIwMjUs
IFVUQyA3OjMwIEFNDQpQYXJpcywgRnJhbmNlIENFU1QgOTozMCBBTQ0KQ2hpbmEgQ1NUIDM6MzAg
UE0NCg0KSm9pbiBab29tIE1lZXRpbmcgDQpodHRwczovL2ludGVsLnpvb20udXMvai85MTI5NzI3
OTI2OT9wd2Q9V21kd1MwcERPRFJOTVM5dFFrNTRZMWR2YkZscVVUMDkNCk9yDQpodHRwczovL2lu
dGVsLnpvb20udXMvd2Mvam9pbi85MTI5NzI3OTI2OT93cGs9d2NwazUyYTlmOTZkOTg5ZTdlMjBi
NjI4YzJjMzZlNDhiNjhlDQoNCk1lZXRpbmcgSUQ6IDkxMiA5NzI3IDkyNjkNClBhc3Njb2RlOiAz
Njc1MjgNCg0KDQpSZWdhcmRzDQoNCkhvbmd6aGFuIENoZW4NCg==
