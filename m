Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D97635
	for <xenomai@lists.linux.dev>; Wed,  4 Sep 2024 04:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725424920; cv=fail; b=ayx4WR0G7FxvRg3NwWMJG2Vp8trrayd7g7Acue78vlvBn89g7CpB/kzIZd9j+fh9zawPieQIjO2ovvKIVlRkJpMLO1tFgVfSfN6aRrDrSKm/36jN/iulGQQ6Iu1IUJw2/KaxSfLux+el1+iSIC9ddrgZqnK/gzHts38Jr38yRWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725424920; c=relaxed/simple;
	bh=T8miHkXbvN7PY6FTpb3S0RuAl05GyN7fYJaY9fGwYk8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kSSXUHQlMY518BTOGw3G5EH0R4j1HdJT3N0qdlvU/aLHT0vHy7RglXHFZh/7adhdHgoiYto9V+2V1ejdcRwdUA6YCJ3v3lO5g6u3TyWeqARMTPrcbQV9t0f3L1LGnOoiJjhnPIn74xtNY5QLfQLcei678uPaTSdMjdUTf/4ztIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jNzlcX7C; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jNzlcX7C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725424919; x=1756960919;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=T8miHkXbvN7PY6FTpb3S0RuAl05GyN7fYJaY9fGwYk8=;
  b=jNzlcX7CAWNABNNySv/NaCpxRcwKog+B3Mn3pYNJt+ZG0XFGGgpyLP8B
   0YLQ7frCYGKajJK8Q6pEBX8steo9wp/0rTezUSKth3YoggkiZiTPYB1E9
   r2uFzugLl0rdfB+gdx+XecKITd7dUcbN0egCcIus69PaNK7WwT9FvwGUZ
   CgToq2PqMRexpLkKL1v2IMI3MKOreWAF1j7GKkVF85muUvL6AAwIUiyK7
   JNN4VpdZqtODgksXV1mu+3BKdPaw111bDhFtKKP0flzkt5XmQT0nbWk5M
   KexODbmZi3sqZE0XYPv/7YM62E7fwYnp0ZF87I9aQBItz2SAk1hGt9g1R
   A==;
X-CSE-ConnectionGUID: gZvKQz0QROGBcrAlQ9WEIw==
X-CSE-MsgGUID: i21A+G+0S2y83U/xVGyUEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="27850974"
X-IronPort-AV: E=Sophos;i="6.10,200,1719903600"; 
   d="scan'208";a="27850974"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 21:41:59 -0700
X-CSE-ConnectionGUID: lRTXUciYTCGSAaSXXSFacA==
X-CSE-MsgGUID: 8l5OvE/3R/mBysVwLor8+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,200,1719903600"; 
   d="scan'208";a="69766633"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Sep 2024 21:41:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Sep 2024 21:41:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 3 Sep 2024 21:41:55 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Sep 2024 21:41:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fUBr1uWLs74e0L/qZX45AaPItqPdTU9+FhxAkFpxn86G6wBOWnK3FrGb75haRTNjaQrPRanIwuQ/O51+qwjkUL9P/xiAFbCPhl1KqWydnMj0z46xeoN+UqDpewXYMnv7nSaufemT2mtcUeEQc8gV09IDAd9j10/tjfoXILMwbnGbFUxmSbYcv4UEd7tJTz3ZGENdT/dvw31UfsOQ0+BcQDoRyPD7KNVZfJyXv5tdsM2Hj+YcgKBo6RHjS8XaFUYpa+RERSmxzwO3eCWtjiClDU7AVPYg3XOvgIRF4OCDDpARKa4960KIT2FyjnVceRjgO5IYSvFFczRnw2xyfMytzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8miHkXbvN7PY6FTpb3S0RuAl05GyN7fYJaY9fGwYk8=;
 b=yFCEjXNvm1TuHahdswASP/fmUqOZ9PBD1F1URg9legp6XJ6NVvz95eGC9HDEENjeFAcBfvFjFSZexnXdgse2bQE4g8p/D2JnZMOTiniXD+iZqkqBGRkuERPWUy5xuiOUyqGTjMForNm/z+HbsRgOti0pkv3T/wxGzrDOW3SLEOcGY1zg9y6IHBRtOI2RE3nB1ymMS25XioP/4x13VRqv5wEKXiTO97Lsob3OaPu9pL8pR7tuIHH+ydmaIiIQz9y4Q8HvZW6lRLvYmoywhE66tzquYXYxH0CmKZ17P+phqHDPJJt+wHlRkR389RLW/mJdPnbZ/1TbeaphgmeV9kYH8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by DM6PR11MB4516.namprd11.prod.outlook.com (2603:10b6:5:2a5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 04:41:52 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d%6]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 04:41:52 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday,  Sept 4, 2024, UTC
 7:00 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday,  Sept 4, 2024,
 UTC 7:00 AM
Thread-Index: AQHa/oTC0+lLWATSDU6fBnsTRRBBdA==
Date: Wed, 4 Sep 2024 04:41:51 +0000
Message-ID: <PH7PR11MB7499BDD1032C1C09D4107EE7F29C2@PH7PR11MB7499.namprd11.prod.outlook.com>
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
In-Reply-To: <PH7PR11MB749988D39A66B3EC8E9431E6F28E2@PH7PR11MB7499.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|DM6PR11MB4516:EE_
x-ms-office365-filtering-correlation-id: 1b6a5975-330f-4819-7aec-08dccc9be538
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YnVnRVdoVnBhUzlvb1lXelpLcmRheTJCMld3b2NCT0xGVk9OdWt5eTQxcGNm?=
 =?utf-8?B?eURlc3l2dmJueEg2ZWFpeGxhUE1lY3J4YVM3RlRMOG05eDYvQUJJcmNFNm52?=
 =?utf-8?B?QWgrdnJQWTdXcDRZeitPb2VsRCtoaEFpUFd4dEs5Rm1BbklSN25zQ1M0NDlN?=
 =?utf-8?B?OHFiNjU0OExFU2dKNHlVbldtVzNXWGtmczduUGlUTkUvR2xxd0JEWlFvbDkx?=
 =?utf-8?B?aHAwNGJPMTZLMitxNTk3ay9MKzYrVFdMUUNxMEc2cFliS3JxVVh1T05VOUN2?=
 =?utf-8?B?a2ZYKzk3b3ByYVZHRjNTZStPMzg4K09RdGdGUXFxNGJONWR0UDdtN3E1cklp?=
 =?utf-8?B?cTNhWHZaUnFiUThncnVkbEdSWmhnYm56OHRlQS84NmJBQkZKZ0FrWVlLZmV2?=
 =?utf-8?B?YWxEby9BWWlTSEc0OXduN3dYSk1nZXROcXU4Y1dPd2tIRzM5Vi9GWkZFWVZM?=
 =?utf-8?B?WFIxUEZIZ25DeU9YUC9zajVvSUFITGpidS9pTmE3SVZ4a3JnSXF4b05oV1pQ?=
 =?utf-8?B?UVF2a3kzUWxvNVZaU1BBNERvbi9GcTJ1dlRvaW9pZW1SaHBra0xtSzBVQ3lJ?=
 =?utf-8?B?ZEFIM3lpVW9TL3hodUYwU1dnbUN0S3poYTBxZi93aVU1REtCY3RhRUxGZUNS?=
 =?utf-8?B?TkdVYVI2aVcrSEVGMlg1enUvVXI4Z1Z5Q3pPVkhNSG5jUFNRRWxGLzhxbmJN?=
 =?utf-8?B?SDNFUDFOYkRUYWd3Z3VUZU5HRWFEMituYUt2anlWY1dFZ2VlTGp3WkdJeVdh?=
 =?utf-8?B?TzFqZTBJRmUxWXFZNWpZY0haRWJtQkZWWVpwZ29iS3JiL3BJNWFCbU14ekMv?=
 =?utf-8?B?LzZCMjUyOTVxbnUwajJTdWZxRzQwUllzNFRvUkNEUFRKc0hNUW82VlY3WWVj?=
 =?utf-8?B?VW1abHNBTjBVUWZXeEk0SURzcHlZWjFlN2ZWUVFDdWFLbmNualZhSzBTMmVH?=
 =?utf-8?B?RkRZRTA0d3oySkR4ek0vdU9OM20vdURhaERMc0xCQ1N4eGVQN0JHUlBzVU9h?=
 =?utf-8?B?SlQybFlEeXVjWGlaTlA1L0hHckM1aXcwVkhuT0Z3c0o0dFBGRnIvcTA3NmNU?=
 =?utf-8?B?YTRnK0NmMDVmcG0razFjZVBpSEw3eXNpdWkzRDdtOUtZMUlLTEhxb2trejhG?=
 =?utf-8?B?cERMM1NJTXhYdTd6aThBcFJucmRnUnAwWEZaVlNBeVpjaTRFbWVwSEtHdFNx?=
 =?utf-8?B?ZW90K3czSUJhS2FQK3hJRHpkcmNvdFBlTCtjbitmUHQ4YWFzQUphemdYNmoz?=
 =?utf-8?B?K1Y2ZkR3ZFcxRjB6VUVmbnVKUTFwRVNiVkt0YlBwUVkzdXhjNGZTcDg4aXBv?=
 =?utf-8?B?bHNUUmdIUnNyOVRualY0M2FMWGIrUWg1NyttMnRMYkwvQTk1bnJicE9qTDNo?=
 =?utf-8?B?eWpiYkdyY2V4Q3ZtVHhRVFZMWXRZczdRNzJZZWJUWUxTV0kyemw2bm0rTFlM?=
 =?utf-8?B?WVVIdk85cEljRVdIWGt1SWYrREZXem4wY2NXR205VjExT3hDT0RVZjRLRlVJ?=
 =?utf-8?B?WVZzOFpHK01CQ2V4SHVpbXk3bkJrWjgzaGtCWkgvdWt3dC9Lc0JpYk40TlRZ?=
 =?utf-8?B?MFRWR1JtNUV3eGFra3NORU9NRUxrWXZLbVBRRGl6WXBUTmRGZ0lXMGE4N0Q4?=
 =?utf-8?B?UHM4NEMwTTRXRjZ3eFI2MXYxTDJhSmhQQ0NFMzM4SVBuWms3SWNhcEJwcGxs?=
 =?utf-8?B?dVl4T2FNTnlaeVZFVzA5bndXQkl0d250V0JScEErcjNXRjVBT29QNWZ4ZSta?=
 =?utf-8?B?VGtwMVJTeHEzbUx4SkRKeTRKaVErT25KQTdia0J3V1I4NnhpSmpQcjc4OE9E?=
 =?utf-8?Q?ecgmDRS12SMhHsC9YKcJLnd6XLPPWpG4rdPPc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enpJL3ZxR2pqcjVpSExDQkhvNzBmNnk4cDdJRE8wdGFTVFFuOTUrWm9hNGhN?=
 =?utf-8?B?aHNXQ0swMW04amJpS2Q4TzlXYWZNTTB2eW1GelpERmJxdXRnVXYvdlpna25x?=
 =?utf-8?B?ZzRZRlJuWFBNN1pJQUxqdVNRT0ZuRWJFdmNVSWFpbklvaUlyd3VnRElPK0po?=
 =?utf-8?B?L2c0TXFINlFOd2ZyZ2MzazhUc2ZuSUp3aTFIb01xY1pkaVhhNTBOKzBtNHkr?=
 =?utf-8?B?TW1TdXJlRzE5MTZ6eWZNalB0c25uRGs2WVlaVzE4WTFRb0J5eElMZW9MakFH?=
 =?utf-8?B?QVhxdDV6K2pveEZrMDU2YnBCZy9DNWM2cGlMUjV5T3RkaXlnNFVWNzRpU25p?=
 =?utf-8?B?L25GQUduZmlYVXNBNERnM2l1VnNlU3VBVmNjL0YvMGFJaW85Y1p0NHVMNzFx?=
 =?utf-8?B?dFc4cVN5TTYrSzhnYU5PcE9JRnRETWdpQUg0WDVDYWw2b0FQOUc1em1UTzdz?=
 =?utf-8?B?ZGpJa01saUl5U2I0cWtiVE5IVmxPK09JYzhRZlJPUUhUSlZ5U3Iyb01ua0t4?=
 =?utf-8?B?UGs3aC94aFdpRkJSTjlhSkYybUtwRmlSWUFDeDJqcGpPUmpBaUIxT3lwLzdD?=
 =?utf-8?B?YVZuMGJYcERYNjhXQTYzZk9mUzIxWEVXNDZGOStMRFNvYkJCUU5pZXd1dDFu?=
 =?utf-8?B?WE5wV0dQYkEySDRqck05VEtIZ1p4T05kaXRrRlJTVmszTmJ6cTI3RUh6RUp1?=
 =?utf-8?B?WnloTVpMOHduUDRTTzdud1RyeHBTM1J3UGVwOHZqRWRZY01XMnYzZCtPZTU5?=
 =?utf-8?B?TU1icTJia3hRMTFCbGppZWZSc2lTc2FUM1RsQSt3cU9UUWdMSlZESzZjdG53?=
 =?utf-8?B?ZFJJeGpDOTR6MVdGTGdveGkwVFdlWlZ0dm9RckgwdDNxV21ucytFU1NvM0da?=
 =?utf-8?B?MVViMEFtVXJOUTFUZk43UFlzcWNaV2VzcElDalk5Y1cvNjNtZEZRU2JqYURn?=
 =?utf-8?B?RnkzMU95dFdaTFVNODhLT3Z6ekFMS0JEYm12aTdnN0FiNGR2Y0VOcXR1dVZw?=
 =?utf-8?B?dmFaMHU3enVhWnpJZk9xNUFBdmdMRjlTWXhxbStCY3lFS3MyTEc3OVkzbTVs?=
 =?utf-8?B?eHVTS0pnTFZPT0Q3a29KVVFndDZ5S01tcElaWHh0YnlvcHA4L2F2NFRUVnpi?=
 =?utf-8?B?Z1ZVL25QTDhCVVpyRFpES1VmbUNmWlBKYlZxZUpmZkF3S0srS2gwdG1OOFEz?=
 =?utf-8?B?emxOS3pSVE42SzNsdGkraUdncUNYOW9mT3VtVGVwWXB6bElxU2VheU10T21R?=
 =?utf-8?B?dlFmYkNkTXRNL2NhRkk5ZVM5RnJidE9VK29seFRUS2YwTjlsLzYvVGlUWFlD?=
 =?utf-8?B?VzRiZE1wUmo1L1U1TkFUaXpkcHA5RzVuSDNVL2IrWFU3UEdPcldMajJibVRC?=
 =?utf-8?B?eElOUWlObVo3ay9uVHQxeXJiOWxVNFVZTks0UU9OZXI3NEJPV2NBenNpWU0y?=
 =?utf-8?B?QUFMRW10Tk5WQzNvU0pBZGROdmRzUzZNenlXU1ZUcEh3MTlsQ1pKUHpkYnY0?=
 =?utf-8?B?Vzk4dE8yUWVMRmpoZnZObk80UkxmVE5lNDdaU2kwOVgvaTNhMWZCVkNPcEU2?=
 =?utf-8?B?RUFjNGhDZFRPZDhzbDVISk9KZnNSR3c0WTBoVXJxeEVFbnh5TENvRnNVb2d6?=
 =?utf-8?B?a21iSGMwcTAxVDkvNUpjRzhrZ29vVWF2dXZhVlBKRmd0T0JqWGNubGo2QWZa?=
 =?utf-8?B?R1pJYTQvR1lyOWFReHhGekJXeWs1cDRSeDhPblhzZXljR3BGYVdxNmtXL2Nq?=
 =?utf-8?B?MFN2c1NjZW9uL1RlRVBVaDhVZkU2eFo1dDZFQmtKY2d4V3pVdEFUMm5ydTY2?=
 =?utf-8?B?dDV5NytDK01vNEdpVDJib21rQ2NLbDF6UVg1eVVpNFpiUlJiV3ZQa0ZPK2JS?=
 =?utf-8?B?dkNraWlOWnpzcnlHU3R1ZTNOK0F6T0N5WE9Ib2Qwc0pzNWo1TldvUXVkRks3?=
 =?utf-8?B?YStxeFVzWGljb2dja2xGU3FyVitIR0xxWHdDdUFMRFhEam5vd2NqWHgzVEI4?=
 =?utf-8?B?MDFDeWNabXU1eE8xamxDd21lbk5MY1pCZWQ0YzR6RURDOXdCV0swcG5BK0RZ?=
 =?utf-8?B?NitVT3JMN0FpOXI2b3FNWlRkVEdKQkkwZU9DNGtnNHF6bWRwS0s4NTl4N2dK?=
 =?utf-8?Q?ADYttjufnc1aKm64nPVJ2sWgF?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b6a5975-330f-4819-7aec-08dccc9be538
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 04:41:51.7165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pWcqI97xWJOnCawA0hEFJg7b03WqEb20EEmtz4U5BC/seJVChA6GO0rgFmlLqt+ZS/Z45LJrouqtdG9JW5guxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4516
X-OriginatorOrg: intel.com

DQpUb3BpY3MgbWF5IGluY2x1ZGUgYnV0IGFyZSBub3QgbGltaXRlZCB0byB1cHN0cmVhbS9kb3du
c3RyZWFtIHByb2plY3QgDQpwbGFucywgc3RhdHVzIHVwZGF0ZXMsIGFuZCB0ZWNobmljYWwgZGlz
Y3Vzc2lvbnMuIEl0J3MgYW4gb3BlbiBvbmxpbmUgDQptZWV0aW5nIHRoYXQgYW55b25lIGNhbiBq
b2luIGFuZCBhc2sgcXVlc3Rpb25zLg0KDQpUaW1lOg0KV2VkbmVzZGF5LCBTZXB0IDQsIDIwMjQs
IFVUQyA3OjAwIEFNDQpQYXJpcywgRnJhbmNlIENFU1QgOTowMCBBTQ0KQ2hpbmEgQ1NUIDM6MDAg
UE0NCg0KSm9pbiBab29tIE1lZXRpbmcgDQpodHRwczovL2ludGVsLnpvb20udXMvai85MTI5NzI3
OTI2OT9wd2Q9V21kd1MwcERPRFJOTVM5dFFrNTRZMWR2YkZscVVUMDkNCk9yDQpodHRwczovL2lu
dGVsLnpvb20udXMvd2Mvam9pbi85MTI5NzI3OTI2OT93cGs9d2NwazUyYTlmOTZkOTg5ZTdlMjBi
NjI4YzJjMzZlNDhiNjhlDQoNCk1lZXRpbmcgSUQ6IDkxMiA5NzI3IDkyNjkNClBhc3Njb2RlOiAz
Njc1MjgNCg0KDQpSZWdhcmRzDQoNCkhvbmd6aGFuIENoZW4NCg==
