Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519D43A29F
	for <xenomai@lists.linux.dev>; Wed, 12 Jun 2024 03:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718161244; cv=fail; b=MprYKl2vWSmE6kCz7Qm6dHJsiI0aRr5H0J7WgqNdbnZllMzWNUDzluyVQvL2t/QRRykhWPcEuPeFDYpAyN/MEbCKF74I/q9fxw4ft2Rzzn8+kBjStGASpLTl8+1WKpFqIP6jWvGENaAHEKWp0EXYTWfccRLW66PLytRAp0oZZlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718161244; c=relaxed/simple;
	bh=hU1ftUOP5jbk+FXXK9zmSf1/lCTTduzm9QaaeJbkHPg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MP4nqu4e0UJiYnN0f7s3m98Upxy+AlnVXRY0lKHsy6hDBywOZx2uBJrNPiL0xB4kJkzK4M7+0d3jP882lWsmvpJ1Pd+BRGolymhQbgPSXnwevVXmPmYzYglJRWPqoSKrwUeQgkckXtxOKtvKbaBxfUqIowXpZs74Ojs2ZCFC3M4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XpMs6d9G; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XpMs6d9G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718161242; x=1749697242;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=hU1ftUOP5jbk+FXXK9zmSf1/lCTTduzm9QaaeJbkHPg=;
  b=XpMs6d9GTVZ6ZY7rm1Qf7IvOIerV+ReqWmUcawsjLdBoLzX2rjjShixK
   hdxsyGFqthguFBuHP4mw9YQu49fyS1gkqXJMOKZiYnSgVzbNTgQZEd898
   3NVf2m5ZNaXSzNDYjsrxtToiSXjwdm2N4LekMPuIdllO+FOE4PRTmPujc
   DiuHTd01JjmsrNTzDyhkmWG/6Nvodx3xhd4chTl3DIWYn0LFp5mNZDFze
   APBzHMClMQU4aPbUm4FytEQ5kBgTGryObHPiPklwu9TmccBGmrG0/A741
   g0G/gA2dsqEUjuAEZ6ESfiCpxLyxz5Oe90DvGLicYQZsHzvwQb8Gx/fny
   w==;
X-CSE-ConnectionGUID: +ivFfUqcQxyeApXDW/Plfw==
X-CSE-MsgGUID: KmTCztdjRXWUmzK3WIMKEw==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="18685881"
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="18685881"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 20:00:41 -0700
X-CSE-ConnectionGUID: m0XV3JYHQVCy+zdkvj+BvQ==
X-CSE-MsgGUID: Z2AIEwyTSJmUj4WYSW4+Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="44771983"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jun 2024 20:00:41 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 20:00:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 20:00:40 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 11 Jun 2024 20:00:40 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Jun 2024 20:00:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSxyAOSSKY56jcgOKJTbMt59M2cL+OaW2ohmo4rqvPGsXMuTywbOQIsW1ziJuswxdJcDVFtCkU05WiIC9Xa9lPJHGdEZNvEPIK68f5S1aB8iQs6Km6MWSWvoMFs+1QS1utEsTSf5fIxbAAZ0B7FRTh9fwOul3qNJgWkSEpcQIlYZ+mDSmdDha7SZ+Q4EQRQnA6S8vsrcC2ZY+KRf4J7IFeouvJtTm0ZZXjtW1E0FYfaTVuwGK4MU0bi1ZRxuWMqJuIXTTo9/dNizcWPiFVHLx1DWu+28661+Nigwv5wZZ+Vy1Bb9CCHtKYF3vyD0gAerNrJmxYcecn8CjGpU0syK7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hU1ftUOP5jbk+FXXK9zmSf1/lCTTduzm9QaaeJbkHPg=;
 b=l2VkXYs/HGvWfHfK4HBvyjh0/c/EZSPqexTtuJ8cUHZ+E92wckjrL8ENA3crViFr0tuHL8tkHW4cj8PhcmY0DSjfeJgPTzc5ofQJaX3b/pKCt98bhvgYb3t6g6i6Lfumt76R5Vow9lgNvYb1iQgw2zrTeM4Q+wj609xYuQjdcza+polMt5ykeV+1nIVIWr8TTvJ3X/YVb8US8ph4KVMkhSEF1bIq1Gfrw0b5L61jQ/NW+eaZ57/h4Ve/PGLW5TxWhqYr0nDTeoTsSDic/UX0UrdhI1gu3PhLkt9Ri3jLGMKf/+qsHbu9MQGvlRSv/SqA+BCBZEqyFObFwfLmfck6tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by SJ0PR11MB5166.namprd11.prod.outlook.com (2603:10b6:a03:2d8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 03:00:37 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d%7]) with mapi id 15.20.7633.036; Wed, 12 Jun 2024
 03:00:37 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday,  Jun 12, 2024, UTC
 7:00 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday,  Jun 12, 2024,
 UTC 7:00 AM
Thread-Index: AQHavHSzTHUQ0lq20keOpx4Jo5NYew==
Date: Wed, 12 Jun 2024 03:00:37 +0000
Message-ID: <PH7PR11MB7499EF7C4A0FD89D089B63A1F2C02@PH7PR11MB7499.namprd11.prod.outlook.com>
References: <PH7PR11MB7499F7DDE006A3A7291F61FAF27B2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749929DFFDCFE47376883636F2572@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749988D3E2C96C4F21DAEBE4F2212@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499C4BB71E159B3AB98D686F2332@PH7PR11MB7499.namprd11.prod.outlook.com>
 <DS0PR11MB7482613E8A9D78229EA71D07F2EC2@DS0PR11MB7482.namprd11.prod.outlook.com>
 <PH7PR11MB74993A52AA247D08069980E4F2F22@PH7PR11MB7499.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB74993A52AA247D08069980E4F2F22@PH7PR11MB7499.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|SJ0PR11MB5166:EE_
x-ms-office365-filtering-correlation-id: 20ffccad-60c0-4f04-e89a-08dc8a8bd603
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230032|376006|366008|1800799016|38070700010;
x-microsoft-antispam-message-info: =?utf-8?B?QzhKSmp5RFlFc0NGK0g1Y1R3NjhzZ3JOVHZielV0TmFsTW5xNS8zODJ3RDF1?=
 =?utf-8?B?ME5BdnVXMUVkMjNCZWxXSlNIV28yb3F2K0EzWENQZlVDQUJlNmVYK3pYSEhz?=
 =?utf-8?B?THBQRVdoZXdUZ0J1VE9QL2tkS2pEM1NZMnFxVnJrYWJoSUtKNURwNSt4NmZ5?=
 =?utf-8?B?ckFFd044Rkl4RXpFNy9IVVlPeWRRTk40UFlYZ2d5amdieDlkME5xSjB5SU5Z?=
 =?utf-8?B?RDdoNXorcVlxelluNnJGc1FCV2dqR3JURlJxdGJYalcrdG83bUhlZytVS3Fj?=
 =?utf-8?B?NGFYYU9JazNFWWhnSS9zY3dQd0ZraVF4eGdUR3NyNStpVEM2akZKb0JhdFNI?=
 =?utf-8?B?eHY4Mm9aRlNMRGJCWFNlNzJ5Z3krbjBPUW9tTDdXV0lMT0wycjRMUjFxMmVL?=
 =?utf-8?B?bHRYaFBtZ2xCR3NXa1Z4SlYycG5wOHd1aUVPS0RJUnUxU1l6dWpoSkxZaTdz?=
 =?utf-8?B?K2ZOTE5ZenllbU5GN0xHMENNRERPY2pyT2VGeGZQVDd0eDdnazljd3cxV1Zx?=
 =?utf-8?B?cUdCdDVYcXNheXJQR1NSdWtWeDZ0TjFXVG5wd3RLZ1ptUEpLQ1JXelpqZ2d5?=
 =?utf-8?B?ZmF0MFdjZXBudmFkdmYrWGY2SDJzR2R1cXRzcnR1aEN0SFRVS3BFOUFETHVr?=
 =?utf-8?B?bGZhZWtOSXZpN1ZGZzhaUm05Z2tWOUtWT2hOTGJVcW5kYjVwdHUyYXJ3RUZt?=
 =?utf-8?B?NHJDK0p6RFlKS3c0VGhmcytBaE45ZFpmQ0ZaRUhPakxub1ZDUkJrNEJoREZV?=
 =?utf-8?B?N1cwQlByS1BXM0NLM1J4bEovMzdnNTZrakxvc0t4TkFXNWl3aFRNZnRRRmpY?=
 =?utf-8?B?OXg1alBkVFJBejlMSG5lRTl4RXZKbm1sS3FWbC9obUJjYXYyUjVZM2NWb3RH?=
 =?utf-8?B?R0VYd2NFc1NrSC9NcHRQNjFEaEtpRHJyY1gyemZhNWJWejBRamJFNm5aMys2?=
 =?utf-8?B?Kzg2Z2h6UXJnMDJkQTlhRGkrSWJ5SmJDRW5nOU1KYXlHcWF2ak1QZzg1U2RF?=
 =?utf-8?B?ZUhQUmZ5NXZUN0l1WFMzbmdncm5EcTRMU2N6SUdBMERydm1jS2c5WThneS8x?=
 =?utf-8?B?Qm51QTRSMEJBb1I4S3U5akovanNEQzB3ZFRZMlk0WXE3ZkwzeUtWUStiZk9Z?=
 =?utf-8?B?R2NYSkVRc3IvMDNac0pmOVRBbzNOSXFocWJBUmZiOWhDS1g4YnFWQ3MvVkpt?=
 =?utf-8?B?ZlJ5K1JTYTJBRVFGY3pqNGxSaFFPRHlhb0lBcHNoNXk1enR5bERleWJWRzVC?=
 =?utf-8?B?eGpUTldjbjdJWUU5ZmtqS2tIdGJQa1pySytRc2gyWjZZM3pXWmdVL2o4QXU4?=
 =?utf-8?B?dXhLRjhLYUt5dngyNTZZNmVkRDZHTkZPank2ZFJ6OWJQUGRKTmxCalZoRTJF?=
 =?utf-8?B?bXJNSjBKdkpLNFR3MkZnY0N4c1BURWRUTjFwbExaUnFpYnpNbUppNEkyOGRY?=
 =?utf-8?B?TFdGRjE3TE9rWWxpYWVETVY5MTVCQ3lVenk2ZmZEcG5HNUp3SkhwT0V6eVUz?=
 =?utf-8?B?R0FMb01lbmQ4V2phMklIdmQ3ZDl4UERJOFV3cVNYQm1HZHdUQTJxbDl6OHA4?=
 =?utf-8?B?S3VsaTdkUkdIeThkQU5iYTQvSmxNUUl1Q3dDcjVZMnkyL1FPb1B2Tk9NM1BN?=
 =?utf-8?B?SXlZNitxTlhlZWRTQ0hacGRBSEpWdHlXNDJ2WDhna0tTWUlsUkF3M0ZpRERa?=
 =?utf-8?B?RmRhd2VBTDluU0tiWmZ4eWJ4NlFMVHFUSzRnMFB6RG9WVk5pYlg0d2hvSGlF?=
 =?utf-8?Q?dgH6PJ2CTO1k5wgkLUFH2bJ3VaqoUQDOgYsNvjU?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(366008)(1800799016)(38070700010);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmhYd3NUYkYwVkhMNm5RNjFvYitBbTJGZkU4RnJUZDhGNVZRWHc1WDVKWWo5?=
 =?utf-8?B?K1JGS1lacWJUWTlvVmVxOFZoYjVoaGZmaStONk1zcGsvd0dURFMwc000ZTVC?=
 =?utf-8?B?SWdmU0o4OU5Od3hSZS9XUUJYMjBKRVh3RFM4YmcwZzlLMVJiVmkzVU92eGRq?=
 =?utf-8?B?dlRobElUZVh5RDlSaEFZcTMzUjMvSzE0MnFZMFNNbit4bWlGUGFteDRldUxZ?=
 =?utf-8?B?UHBxVXRnQXo5RjNFZFNWY2lIRGVBRld6STJBc3hvU2R2RVhBUGpIRkdidER2?=
 =?utf-8?B?QXpHS3QxRU81SHYxL2EzMlhtSUp4aFIwTzg2UzRNakZSb25OZkYxUkZmeEEr?=
 =?utf-8?B?YUx6ZHArWkF2MkxEbmVYbEVSRmswMHltUnR3WWo5bGpqK0J0UEVsR0E4bHUy?=
 =?utf-8?B?bjF3QjBpUFk2T1pmWE1iRTNLaTJUcm1WSmhESS9GcU9ZVWs0c1hwUmYvUzdK?=
 =?utf-8?B?TUNBNlRMRHhvbi9DN0pvM3N1cm9kdEhVV3BrQzFlSlE1cTBCV0d6dUNudG0y?=
 =?utf-8?B?Y1Z0d1QzaGtLRVpNWHZyMXZGMjF2Qy8wbXhRMjlkVysyQk45Y3FYSHoyeEU5?=
 =?utf-8?B?azhINUk5a3UwNkFjMUNWTGJkM3VtOXU5d1JJUXhjNWtpZm5uaUttRHdTc01O?=
 =?utf-8?B?UTlJbktVZmphYTJRUEVObmc1U3NrZS9kQm82ZkNXU2p1MFB5NDVpbE9RMTV2?=
 =?utf-8?B?RGVSUWF2RjJIMFBteHFFOEE3VUpkQjVjZm1VNHJDVnhpNUlud1hieGhGTzJx?=
 =?utf-8?B?WENqMmowODlMa2RVM1p6SmZ3eGFyNExCbEdZbW1HQnVBT0dNQkt3akQ3ZHNM?=
 =?utf-8?B?a1hpbUlDdGJ1YzRtd2NaUThFV0FDd3FoNERpQU9FcGJ6OEg2V3VvVVUxM3RT?=
 =?utf-8?B?eFVFbDV6WWNPcWxDYjJQdk1GeW40a2xsdFRVczRLZEdqbHFHcDltUUtQTHdY?=
 =?utf-8?B?RmgxanIwZloxY3o3L20rL3RsS1ZqTXNnZXd4emZkanZabC85ZldadGpQTlFj?=
 =?utf-8?B?c0Zqc1gwbVZqZWE4cjFxQUxRVHJSMFN5V2xIYzFMNytWQnY2czV0MU4vS05Z?=
 =?utf-8?B?VVUyeVRwdlVpWDIwK09qcDQrcmhNc2xqT3JGRENmVmtyT3VQUHdNMStiS21u?=
 =?utf-8?B?TXpmYTdNZVNXYU5MM21HSVlMZVh5Uk0vR0FtMmtFZC9ST3grUzB5UzAvS2Zv?=
 =?utf-8?B?bHlzb3RyNFVqYklyakJ6ZnVVSndSbEZ2UjY1YUxyTzZXb1JVRjZJZjJ4MEhE?=
 =?utf-8?B?Z3FJcExoVGN1UVByRncyUmdjMmEvdkNkWjlhejdSNnRSaEVDNjM1Vk8vQ3lo?=
 =?utf-8?B?NEY4ME94RVFGRTN4S09CZWY1dGJmQy9DSWo4ZVF5MVNqM0tsQzZ4eFE3Q05l?=
 =?utf-8?B?UndYTGpsSFFDT2hta3Joczc4U083L2hzUTJFd2FLS0drUmdOa3VsdkVMQlV1?=
 =?utf-8?B?VEZOYjQvdW4zTjNiTkEvaUxUcGJPNzZXd2VtNzl2NXpqYXU2R05HQkMyWG5C?=
 =?utf-8?B?SVA3RVY2LzRCRU5KQnZjd29COHE0RkVXQ1RBczNlbnFreTF0Q3U2RWIvSmVx?=
 =?utf-8?B?ZWR4b2U3YlFvaENsV0Z6dEgzV2ZLbGxKbzdKdG9vUis3clU4ZHVaN0J1Ym9n?=
 =?utf-8?B?R2c4NVNiR2xBbXlBL2xBbWJoNDNDazlaWktZUHVxbXJCSVBnelY5RVQzblJU?=
 =?utf-8?B?Mm1tczlJQStDUjEvdk52bzk3R0VWaXVYa0w1RTlvaHc0N2Y0aHJpdVZsdGJ1?=
 =?utf-8?B?OEFuUlV2ZWtQbGJCZjhPb1NPaUNrZWtNa1RRM1h6azhWcjg1SzBFdlJhNDZI?=
 =?utf-8?B?cUM2RGJHN2VucGo5ZFJsM3FJY2s5QVB5ZEV6RDhUcHE4SzhPSXhOaFIzeHNZ?=
 =?utf-8?B?TmRadXJabmRUUDBJR2I5RWdsQ2Q4K212QXVuR1h0VW92b2pPU29oZGxrK2Iw?=
 =?utf-8?B?QTU1bXowclNZNWNPanBTbmR1Sm4rZ0NWanJTbDVoNFcwdWMzeUFQc2dLM3oz?=
 =?utf-8?B?N2N0SkUrRzhlR001ZXFVUGNydDRXcDdKaU14cjFQMk01NDJRdVJXRm9YcGFH?=
 =?utf-8?B?WU9qVExsRnJ1SnpYOWF0NFQ1b3JaT01GSU12U09jYzR2UVJNWmxwRVIvdU53?=
 =?utf-8?Q?SsIVkxXHjDx203sPN186pdGhp?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 20ffccad-60c0-4f04-e89a-08dc8a8bd603
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2024 03:00:37.4924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WEWIpSJVwrT+E+2c/maiD/7eK6IAfbiR7TDM3iIU6Sa+DXjcvGMckQtRylVNbo/LuyRDv7HguPKffs2yPVEUNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5166
X-OriginatorOrg: intel.com

VG9waWNzIG1heSBpbmNsdWRlIGJ1dCBhcmUgbm90IGxpbWl0ZWQgdG8gdXBzdHJlYW0vZG93bnN0
cmVhbSBwcm9qZWN0IA0KcGxhbnMsIHN0YXR1cyB1cGRhdGVzLCBhbmQgdGVjaG5pY2FsIGRpc2N1
c3Npb25zLiBJdCdzIGFuIG9wZW4gb25saW5lIA0KbWVldGluZyB0aGF0IGFueW9uZSBjYW4gam9p
biBhbmQgYXNrIHF1ZXN0aW9ucy4NCg0KVGltZToNCldlZG5lc2RheSwgSnVuIDEyLCAyMDI0LCBV
VEMgNzowMCBBTQ0KUGFyaXMsIEZyYW5jZSBDRVNUIDk6MDAgQU0NCkNoaW5hIENTVCAzOjAwIFBN
DQoNCkpvaW4gWm9vbSBNZWV0aW5nIA0KaHR0cHM6Ly9pbnRlbC56b29tLnVzL2ovOTEyOTcyNzky
Njk/cHdkPVdtZHdTMHBET0RSTk1TOXRRazU0WTFkdmJGbHFVVDA5DQpPcg0KaHR0cHM6Ly9pbnRl
bC56b29tLnVzL3djL2pvaW4vOTEyOTcyNzkyNjk/d3BrPXdjcGs1MmE5Zjk2ZDk4OWU3ZTIwYjYy
OGMyYzM2ZTQ4YjY4ZQ0KDQpNZWV0aW5nIElEOiA5MTIgOTcyNyA5MjY5DQpQYXNzY29kZTogMzY3
NTI4DQoNCg0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQo=
