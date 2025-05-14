Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFBF4C96
	for <xenomai@lists.linux.dev>; Wed, 14 May 2025 04:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747195961; cv=fail; b=Np7ATsz2LJ7aUotjJcTpk+sdjMtqX5dRkvvnIEbYY5C7+04rnd9SXxu0ipMkAwAqkhD6vNfnVi8WxSqArsvF1iy8bKTyJJH3oUsdSlscH++rbrAJS919tpnze02RubAjN+LNLwFGC5SS4yAsgtPvUWRUhOlZEn5Mp4hHcLrG4xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747195961; c=relaxed/simple;
	bh=wo79uOX2qHn/aw8mhFDU6PBdafdoDrO9BUtbjjrNfPw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DBFxe41c8/Q0xcGSpLHx84Yzk/RA5VmwFJRLfZiN6LrCQ3uJEhdhbNT+d2+T/tGpDV9YxFpjyYnD8FXNXn8vuPoewGvk0EWypG9dVbAywR1jK1f7HDPOPnZUatIUkquvNFlQtOeZe0PFg7ZoEZjVCxRy7aXyUfALTB3bUXKBYOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l1DQogRS; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l1DQogRS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747195960; x=1778731960;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=wo79uOX2qHn/aw8mhFDU6PBdafdoDrO9BUtbjjrNfPw=;
  b=l1DQogRSy2ZZYEKC+HlcD9AUWiGM9WcZSv4ySwsOUoLtr3pjXBFRpnyK
   dJ3DGHMIs7yAQFDNP/X6Do/+0gmMbEFRBuSfqgQAHcWAANcHRX7673Rbg
   agSqh6qbhzA/MWCnefykSyyH3mvjW0CJ9sqZLvsQ9tOJEtrPc4ObJFlj7
   AQoffcFcVmrDvfxIV6Wuhn/nPhwc39kUuL+6IXVDDUhL9G9GMfz5hDfCA
   oAI0qG1aQirC80Ac5PpU/j6OX256mqq/FM4pUoJELJIT0tHsqthdLOIk4
   yXVj6k26sEBKfX+f8hm+86CdQPj4Em9GpDyZoPA1TcCH4UX0Dh+ORkyXZ
   Q==;
X-CSE-ConnectionGUID: FIVK3t7lT+O+rpajaTEhVw==
X-CSE-MsgGUID: Hvvbm4GpTTuw6f/F8BaQUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="51717752"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="51717752"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 21:12:38 -0700
X-CSE-ConnectionGUID: CPPi3t2ZTny1JcoIuVusrA==
X-CSE-MsgGUID: 6UUVkdBZT5mxsuNDPWpC+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="142785828"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 21:12:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 13 May 2025 21:12:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 13 May 2025 21:12:38 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 13 May 2025 21:12:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d7Z5xby5OBElv54D2o6lEinCe9kmfLSnREUwKCevzSB80s3Bwfc+QqYAeQUQYK60L8iwuIybuJaK8VIVnwvJZYXOJAyti5AFmmd+IPHRMgRaKXBusBE5++BJyk+DY6VlR8JfKpS2nl2BzmiXMzzXDFBFLGHAyohxuejNPz0F+0zFjIZeT7rOvlijoN1gUmRnsJAZ//gG2+gXsV95TTSsPsNlJR/JlRw3rQWuiS7n3Y9pxa44r6OUqbi1NfF4izh3tUIVy6IpWWKaDhOgiGOJgNxC+2a4L7FVXszH0vBESMT0Vu0/4lqUqEb5FImgbfqGfCsqhMUIbmNw7qi+xQZMyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wo79uOX2qHn/aw8mhFDU6PBdafdoDrO9BUtbjjrNfPw=;
 b=Lz/iFSwF0zSKZ88aWXZP3gL+jcCoyR3qeVPo36BrXuqJ0Gt4sjRYG6MewhOP49PV1oBSELw93CAAiyN08dquQBke8/TLEFvXiT2mNisnqYPsT21Fs1eVWkkMVbymgiEUB+4GFZ0JQykDUbQr/x3ih/088xzbc6wpBnP3pxlIGZeSVEjbrl0TA7lrntA/8Pd4vf6FA8QSN5FdYm3MJ+n5RPs5d7tcKbF7/Silvwon/bSvyCABodegHcAD0WrgVwDd01tsnLrymNjrfvg9PL/mUjIrCvWd3CwCcGeO6kCOsTlMIxzM/LKYcA9rSxUUW8JH8y7r5FBGLHA1w4CXXFRIsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by LV2PR11MB6000.namprd11.prod.outlook.com (2603:10b6:408:17c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 04:11:54 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d%4]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 04:11:54 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: xenomai <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday,  May 14 , 2025, UTC
 7:30 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday,  May 14 , 2025,
 UTC 7:30 AM
Thread-Index: AQHbxIZTuOCofNYeW0+7vRlXIN0PDA==
Date: Wed, 14 May 2025 04:11:54 +0000
Message-ID: <PH7PR11MB7499BABF9BDA783C86090B60F291A@PH7PR11MB7499.namprd11.prod.outlook.com>
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
In-Reply-To: <PH7PR11MB74998FCA330C96F94503AF18F2832@PH7PR11MB7499.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|LV2PR11MB6000:EE_
x-ms-office365-filtering-correlation-id: 189fb84e-13ba-49b8-78b2-08dd929d75f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?S3B4OHIvRW5Fd28rd2t3b3JlWEtkTE1tZGs5cExWUDkxWUpWZ2YrakZ1ZERo?=
 =?utf-8?B?TDFHYkNDR2xyVjFKTHdpN3FUcTZhWlBtVjRqaFRHN1J6bFVUa21IaGhCdVV4?=
 =?utf-8?B?ZkhsL1RQYnNTSWZlTDB6M3RDd1grVm1uV1pORkYyN0Jmckk2T1ZDNG00UWJw?=
 =?utf-8?B?Zzh3czBPUmo2TDJnaHhISEd1dGlnbEUwdmJEeGNJdVVFRDBQVStmMk9UanE2?=
 =?utf-8?B?dElWUk5rMXh2UjRGSGJ0L1ZoNTFxcHRrbkpwUFVzcitlQm9JYzFkaWFyQlM0?=
 =?utf-8?B?UFh6NzVaMmsxbENGUHRwV1BZeXJNM0NyelJTTkI1MmxvSlJ5WGI1RXU1dUtX?=
 =?utf-8?B?RDF1R2FKT1pxWjZqeXJHUWZuK0U5MlJxbHI1Yy9uampOWUo5bnpJRHYrWjdI?=
 =?utf-8?B?dTZaQThVd3lwaGFOaFZ3WTMzeEhuRUV2NTZIYXQvVS91V0hPLzhiaWs5SGZl?=
 =?utf-8?B?RzA4enI3dUdOSDhQaFdhbHFnRS9lV3lsNnMxa1FSQ0Nvd05KcWV4YWJvbGhn?=
 =?utf-8?B?WXJlSlh2aTJ3ZzlEYU1ydlBqU050Q3FuNG9LOVFFQWpOWUtnSWYyZTBWU0NP?=
 =?utf-8?B?ejZFY0YrM2Vldi9aMm5YNDNkQzg1Ri9RNFAyUHlndTc5U2Y5U2twd2JGVVRD?=
 =?utf-8?B?Nk9jZkp5bVRSTE5oRExxOHhpMDdSeXJFUnF0cVozaFNCQnFwblRxVVQwd0wr?=
 =?utf-8?B?NytTR2tiVmw2MHJGdklNVGQ0R0ZpcXJSV1BwMmNlWUpTdkt5QWZNU0tTcEZH?=
 =?utf-8?B?aG41ZEtrM1VsdnQydnJwYTdRSC8xbXJrOGF3VHRXS2wzN0hXeERkZ09tZXky?=
 =?utf-8?B?bTRyQzIxN2ZlbVF6bjBJSU5hWklhT1gwcjFOTVo2RDAzZUZ0TkdJY3V5Z3dF?=
 =?utf-8?B?UW5xM3ZrME50ZmVvb3MzcU42d0xIV01yRllReFNPUE5yMkw4RldNV2IzLzlN?=
 =?utf-8?B?bHQzZ3VqZGFLOTlVVnlMd0xjeGZuQk1ubi9mUWdreFhUNlc2cXdBR1Z1cjFT?=
 =?utf-8?B?MDFLWTRIcE1oTXFPYklpMytLK3dKZFVtSUhLaS84K1UrQnJsRXVmNUJWMllB?=
 =?utf-8?B?NnphaGJRK0JnK3Jhb3lzM3pEOHFvOU9iRlN4NnA1dFY4QTVSMDJtR0tUU1Zn?=
 =?utf-8?B?YmtkUE9IWEI5eVVPcEl2UnNsRVEyRzJLVjBMNTJCTTdvYWRtbmg1Yk5IVEty?=
 =?utf-8?B?VE93dnd0clFmOWNUKzhCK3hldjF6dTY4V24rMUppYXJtT0xONG9acEdLVDJy?=
 =?utf-8?B?T1RBVmFkOENPNTI3allUNzZERnZxTE1aZGVacmRndzk1NGl1TXAxR2xuaEd1?=
 =?utf-8?B?dDhJNDdZVzFoQmF4UzVYTVArMkYyVDlMbGk5MkVnUlpHOS9FWXVnVzlFU0VT?=
 =?utf-8?B?eXdENjkwMStZaUxSa2dveTd5SGhQYWxuMEZBbG0zZG9TSDVIdlo5eDJpMThK?=
 =?utf-8?B?Rm95ekdrRHg1Nm0vNzJDSlROQ051SGJZaXJ5NGgyekt2Snpqdjh2NnRsNVh5?=
 =?utf-8?B?TEpySmtwQk84U2d1MUJvRWF1ZFZCSDZJVHhjcGh6VWJPOS82WUtRelkxVjRh?=
 =?utf-8?B?REozNmsxRkRZaVhxRDZ1eTJxMmxkQVErUzVkMHhmNG5oMVRHcjdGeG9acWEw?=
 =?utf-8?B?SUxzTnpoMFVaRVZ6VWMzYkJaeGdTcjdCS01RZTNqNXc3Zmhrc0FCbk01bzNY?=
 =?utf-8?B?Sm5lS20rRk5Xc3RZV0phVUE5UFNORHJMVlRldjBRR2s1N1VQVm1aK0dRa1hW?=
 =?utf-8?B?RmswL08xOG1TREtvK2VwQ3oyTlo2amxzK3AvRlB3RlBiR1J1NVdScVNRQjRG?=
 =?utf-8?B?SFh4UFROaHhVZU1xN3pXTERJUXFMOWVIM0oxSSsrYXZ1cFFNU09wN25WeUZw?=
 =?utf-8?B?TVBaY3g5c0FiZUFkWW14eERKTExTdStpNDNuTzBCMmIyUUg3ZzdrcnpNL3FO?=
 =?utf-8?Q?7wdLCYXJwjs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGRmU24rak9Edlh6aTNRQnhtcnpEd2NaN1pNQW5iRDl3SnVpY2N4UEJZMXBF?=
 =?utf-8?B?RkxQWXRHQll1V01xbzBZU3Z4YklCMHpiVmVVVzg1d3BnNkRNRjJZa2Z5M0pK?=
 =?utf-8?B?dkt3akdURVpMN0JFa2JBa0ZpSCtkTUowaVFKZXUwU1RlbmJuK1NoYmNSYStT?=
 =?utf-8?B?S1kzUzdCS1JCWjcreHREalpTbzVXQTNWSGRZa2k0OE43Z3VjY0NiMmIraWtQ?=
 =?utf-8?B?a3lLQjRLSldlMjYwd1lrOGljZmp0YndQY3pmN1JlcDN2UEJ5bnA4dFkweDFi?=
 =?utf-8?B?ZUhJeGxGeGJjSlhkT3I5Rmx0djMwV09VVnhVVFdDTDNwSzNwOU91SCszY0lV?=
 =?utf-8?B?ZWJodWxxOU9rSDFPS2N4QVFyRFpNVFRBMElvYVBCc000ejl1MlIydzgyYW1h?=
 =?utf-8?B?amRWbjR5SkZNZUlqd1lOZDFXcVI4MkdvcmVYYk1hY0EzcXM3amJrUHA4cnQw?=
 =?utf-8?B?RW05Q25ST0ovb3VFRStrSXF1SytsSzgrRTBKaVJEVDM2ODQ3V3lDMnlMVzBi?=
 =?utf-8?B?ZFVPY1IzR0ZQUmxWT3Y0eEVzcHpNVDNHRUxFMTZnZzRkSjAxVXZmZkRWOTZH?=
 =?utf-8?B?NXduNVgrOW5pUTJKL2JBWjdZZ1VEUlYyZzJqUzc1Vm5YdXBobG5qS1BQVE1m?=
 =?utf-8?B?b0FuQXhYNFBNMm9FYjgrVmM2RGJkNEtGQTZzWDFvZ3VraGl2U3N1RkdMb0ZY?=
 =?utf-8?B?SW56ZnBBYWxRSDNjNE1UQWxMS0lDT2tXWGVtVUxZamRjWjJKUmFOSlRVeDJq?=
 =?utf-8?B?RHM4bGZuVk1KNWxlT05jazZ5emswaXVwTVdXQnVHWFdFTTE0elFwR0E4VTRF?=
 =?utf-8?B?dkpBa2M1SWQyT1lIeXNqbVNQdXFncDFNc3pxbFhKOFh1SUc3NE5HendrVVhk?=
 =?utf-8?B?LzVvN3ZxQ2ZmMDZRYkkxOFBXSVJOS2VkSkVoMzN3ZlR0ckk0T3FSeEtNa1p6?=
 =?utf-8?B?enFmL3duSXJaOStWbk0xdyt3RDVlL3dnbm9rZUVhZzFYdTNCNVVWei9rbnVn?=
 =?utf-8?B?REovRU1oWjVZVVpncHhIMlhFWnJWUzhJSFZpdmg4UHFKOWtUTEo2WGsydHp4?=
 =?utf-8?B?Tk5oeWJ3SGtrL3V2Y0pvMld5eFE1TVp6MDh3UGtYb3JZdEZneWR5QlZxclZE?=
 =?utf-8?B?MGhTMmpkOHdjeCs5cWN4K2JKTDBNNU1VRC9MMk9UNlNNcHB5YkEvZG9kaXNF?=
 =?utf-8?B?RnVPRVYxY1RncXJEU0FURnViQXZnK05YaXBYczRhSDBwWEJzOWpub2R4TFVE?=
 =?utf-8?B?RFVUU3JsQkhQaWNNWkhHQXlXRHlkbjl6QVdoSDRSd3lVUXFtc0txOXFqTy8w?=
 =?utf-8?B?bVJMOUh4RDI2NkU2SW1WcUNaYTJnKyt6Uk5MQmozU2hVdytucGdMaTRnQlo4?=
 =?utf-8?B?V09aR1Y1Y0ZlVHRKYkZtVFFzUW9WTWJwYUdpbENjTy9mYWRpVTMvVndqd1o3?=
 =?utf-8?B?Z0pudU1WVzU4eDFyUStrSitiTzMwUkxPeUUreElHc2J3NXl1ZUdwNG1CWExY?=
 =?utf-8?B?OXFYdHE5ZVhlTS82RHRJN1BkNnJDcXVVTmRxZE5RL0dLSmcvTUp6b3AzWFBz?=
 =?utf-8?B?M25BY2dMWDB4UmlwTmdqYUlYWVFxdngyVTdoR3JDYitKMWJhZGFURktPdVJ5?=
 =?utf-8?B?cFZDQkRrVVVCeGtmQ1ErQ1cvNk1NSkhFRkkrMUhmZWVmdjdQdk1xZjNXZ2hI?=
 =?utf-8?B?NGk1OWhKZUppK1dYZlZHSHgrQ1FpNWFoSzhjMTRrc1pqOUxLcys5SVQvYytz?=
 =?utf-8?B?bXdOdjVEdk9rUm1xQlU0bFlBbTB5ODRMMFJYN1NjVXlNT0NJVFlud3VmY0pq?=
 =?utf-8?B?eXVQVmhGMVhJbHYwN1NOUUhmRlI4c0tvRjZQU3I0M0c5WkRTRU9JV1ludEk2?=
 =?utf-8?B?LzQ4dFFzS0t6NkFZZjA1SjlpZWZYbHVZU2lVQkkyTWNBYW1pVVJ0K2tiNkw5?=
 =?utf-8?B?Q1JnMVdlQ0xTZ0l3V0R0VE5vbDFPQUtrbDJlL2FlckN4ZDdqcGRXSFVxVzdw?=
 =?utf-8?B?U2ZSbE93dGJETldRNzduOGNaZ3dtQ3JRN1BVaFBRTjd0NDhWWDlCY2VWUzg4?=
 =?utf-8?B?NW9zYjRMYmRMOUovd0lEakZBQk9wVitsKzk1SVV5elQxcFBmU3FyYVQ0dUwv?=
 =?utf-8?Q?FTeuLpsfq8n0WYRXtj9UZlT8b?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 189fb84e-13ba-49b8-78b2-08dd929d75f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2025 04:11:54.2387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nnGbD/OyYiXTdtrNmoX/wbIrvDbaLKLrZBkF6mh6NoMIVp37PnsUsfmNg3OddmRXQ34sPyCz9+feuC7GTA2QVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6000
X-OriginatorOrg: intel.com

VG9waWNzIG1heSBpbmNsdWRlIGJ1dCBhcmUgbm90IGxpbWl0ZWQgdG8gdXBzdHJlYW0vZG93bnN0
cmVhbSBwcm9qZWN0IA0KcGxhbnMsIHN0YXR1cyB1cGRhdGVzLCBhbmQgdGVjaG5pY2FsIGRpc2N1
c3Npb25zLiBJdCdzIGFuIG9wZW4gb25saW5lIA0KbWVldGluZyB0aGF0IGFueW9uZSBjYW4gam9p
biBhbmQgYXNrIHF1ZXN0aW9ucy4NCg0KVGltZToNCldlZG5lc2RheSwgTWF5IDE0LCAyMDI1LCBV
VEMgNzozMCBBTQ0KUGFyaXMsIEZyYW5jZSBDRVNUIDk6MzAgQU0NCkNoaW5hIENTVCAzOjMwIFBN
DQoNCkpvaW4gWm9vbSBNZWV0aW5nIA0KaHR0cHM6Ly9pbnRlbC56b29tLnVzL2ovOTEyOTcyNzky
Njk/cHdkPVdtZHdTMHBET0RSTk1TOXRRazU0WTFkdmJGbHFVVDA5DQpPcg0KaHR0cHM6Ly9pbnRl
bC56b29tLnVzL3djL2pvaW4vOTEyOTcyNzkyNjk/d3BrPXdjcGs1MmE5Zjk2ZDk4OWU3ZTIwYjYy
OGMyYzM2ZTQ4YjY4ZQ0KDQpNZWV0aW5nIElEOiA5MTIgOTcyNyA5MjY5DQpQYXNzY29kZTogMzY3
NTI4DQoNCg0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQo=
