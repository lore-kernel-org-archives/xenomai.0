Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06123FD4
	for <xenomai@lists.linux.dev>; Wed, 19 Feb 2025 05:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739941717; cv=fail; b=dvAL039Gom7Czm0uO92mMy9n2fyQQcWLezwOby67JwSCjWENzVChyldt/rC8q8uLiZYbHFpxmMNtnKzysad5Tm3dYgWZF9m22kBRz7pv9zokPfOVzUjEyrXfmY/4SVQgMyOKFafs7TYCk3MLOgg9WVwLIhzz/2e5uZaXOS+pg6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739941717; c=relaxed/simple;
	bh=AAVs3NG6o2mOXL25CYPjeggu59om4XgbP7bpap/7RGw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EMZEaioKJgm7dpHdjtFD9XEEIMavLDuKx5dkFyikdctjod7bPusO5cLbrjxn6WthOtj/gFkY56/T/FfHLUZflxpND4XQFA+XxQNWGoCoYE7hFCdg0b3cxjZyYtuOIb6vVLyEwD0MtmVgtwBM84sVuPN3YV9ouaiXUF8Mma4VjDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tkr/udOl; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tkr/udOl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739941716; x=1771477716;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=AAVs3NG6o2mOXL25CYPjeggu59om4XgbP7bpap/7RGw=;
  b=Tkr/udOlB0o2J7lkKJbqtSpOFQfbJl+OHri0IoINau3Hwn2pXBbYNfEv
   QbAWBSipjqRniahowSGzMhHetwQh52QViSsaMrYzQ9insqWH4djMJuuue
   zPYmWzqZ9jnPUlC0zuUrCnfHMD9d6fQORjhmMhS6vJapRF8R2Egg7lRyQ
   9yRtX6sdLkt3PEPVccZU6fDqrLiil++cVV7EifE3e42iPtQGZXxNP+XA6
   WuHdg3EFmAPTSq/pAsune1t6iM/zepcgk1ux/IokE8mBq1lEUHGjoOapZ
   AFijYicyV4SYCPEvJ7wcDyWdzQZ226Xocz6BvDnX6QHxlgpJXy0ykBsWa
   g==;
X-CSE-ConnectionGUID: z2gt3WZrQWyOHYXX2m2ldg==
X-CSE-MsgGUID: 3vlIud/sTvKZCM5J+6jgXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="28263131"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; 
   d="scan'208";a="28263131"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 21:08:35 -0800
X-CSE-ConnectionGUID: bQS76AQjRGyQCoXTgbelsg==
X-CSE-MsgGUID: FV53VZm3S4WWyBPkLeHPZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119808447"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Feb 2025 21:08:35 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 18 Feb 2025 21:08:34 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Feb 2025 21:08:34 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 21:08:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VBZG8u7t1/QjLt6dwrS8rkr/GA1O9P17oLfUa/zn/mXMfksj7avKqzh8CnczhFLXBeVB/7WT/U7L5XozQddpQhNjhCJo2C3vmwUzRXjnO/p4837ZBRA85r7NSYwh7qoJFmP6WtY7nciaZVa0BNzA+u4Bp9aIw9RQYqhSlfaC2SbJLSPS5c+YH54dH5wf1AH4VYFiyhvnQCjqPHsiXW8tLTT2rwe287HOH440UqzMp/dwHc9oKfiMyJWJ+fYIR4KGsgiOofRuRNrEkpZeceOeAui9qqahREOPcuiL2hccKFqxJNeoS1NGurVx7LxYmYTa2nJFGbpIWbv8QeXeu+/bTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAVs3NG6o2mOXL25CYPjeggu59om4XgbP7bpap/7RGw=;
 b=OhL8Uv+CJMXsLNQK/IyRHr0tQT7znMBmAMs/ds6UfZL8z70BJVqifgu3l1S4B6o2ZfRlk2+dUMQfkQg/wqWS4QUfAzMVbhQAm8zNZ5NGoyDQsxsf9MUs1st3hPGIhn6K+nxU3gIcHuhlugKSdqU8SQU3Sqgqg+tDuk+yBgbOi2kOdRjsnjq4GmAxMNqKmCSuVr63UXpHoEWub5pX9Cj8AxikG9uFzbPTGybay51p7N2Ps2xoMvF7j5DNwynX7cYjuOj0rqtFj3R6Z5pDcCwvIuieArk9MnGni/Fpbd8cIJ13LjLGDSo0IMm0QfOEnrYHe5nmJ1OLHvYK2Ep9qsz1Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 05:07:51 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d%3]) with mapi id 15.20.8445.015; Wed, 19 Feb 2025
 05:07:51 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday,  Feb.19, 2025, UTC
 7:30 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday,  Feb.19, 2025,
 UTC 7:30 AM
Thread-Index: AQHbgow55bl4dd/3UUm7Tg6rR15w1g==
Date: Wed, 19 Feb 2025 05:07:51 +0000
Message-ID: <PH7PR11MB749901F0793C63043273F166F2C52@PH7PR11MB7499.namprd11.prod.outlook.com>
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
In-Reply-To: <PH7PR11MB74998618D1F5B701C8C07330F2F72@PH7PR11MB7499.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|PH0PR11MB5782:EE_
x-ms-office365-filtering-correlation-id: 6283e1df-5933-468e-3014-08dd50a35c22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WUpCcm5BRVpKTW5xYnplMTkzVUQ3N2o5Um54dkhMN2xkUlNUQXNxVkc0WG1D?=
 =?utf-8?B?MVpoVDI2MW9tYUs2ZDM4K1dBRFh6MmZiMXA1eG1xemxNTWNlbTg1d29CaXFj?=
 =?utf-8?B?eEVLUjF5bGZMSUhkTUZsNjhCT0xHaUxkSVUzdHEvNnZNRGhQMlFLTlUwWGNk?=
 =?utf-8?B?bURFQWhxeWtVWTRuaHNHb0RSNExoa3lHSFQyeCsyQWNLek5qT1o4YWJYUElt?=
 =?utf-8?B?L01YQk5RMUxRV3h6Q0p3dUc1cmNwYmRCVTRzMWUyZGZvL3JRaExKRHE2OUho?=
 =?utf-8?B?czNVNjFNbllGR3JPbldJVmNRNUZCcWlaM0FqazNwTy9wdktCeFVUeGZlQmU1?=
 =?utf-8?B?QmNOdkZpcGRGVEpaeUJqaCs1VVZEYkFnT0czR2VxVGdSbGpETnRDY1Fwd3or?=
 =?utf-8?B?QjNwV3YxTUMrZjVmOEhjR0RLb05rejRPZXVtQmhUanNzZGlORUpQUkFiUUZV?=
 =?utf-8?B?WUtOai9sdHJVeno3dWsrUzBORThVV3UvOVFNdGJVN3E3RWdjTHloSUN1WlNP?=
 =?utf-8?B?eWJvREhHeU9ROHhmTUZqdTJXTXFrWU54enJHaVp6RU12am9TU05DVWozV3Ex?=
 =?utf-8?B?L0drUmJ6c3hyMThHL1ZCYklrejlSdUtNeGphMCtOdEtIbmVWVzN6OTFqT2Jo?=
 =?utf-8?B?M2ZLdENYaG83RzRpcU5nOEFGZ2dtbkMraWxOYjBKNkxrV013TGxZTVhzOEVk?=
 =?utf-8?B?MytvRnFYeTI4KzQ5Y3Btem9kK2VDL20waWlLaUpxS2s0bWhzR29NeE82NWpl?=
 =?utf-8?B?Q2NPYXduMkZvdzZ3cThhbHo0RWxJY1UzdlUzSk5UZzN1MTI0SnllZXRvdXpw?=
 =?utf-8?B?UVV5NC9vUGtBTndMTVZMaTNvMlRybUR0L2ZYVTZERXBlKytFa1RDVm9pajQ1?=
 =?utf-8?B?VmFHOXFlYjcrRURENTVnMVNvNHorOXdybGlYSE40MEs5MGsvMjZQWUFtbWhj?=
 =?utf-8?B?RVpiQTdkRjJpWVpORUx6NnBzcG13eVVIYWdHM0V5c09uMlZaTXV1THFqaHZw?=
 =?utf-8?B?MG1KRlZrRG13U2RmODFOZG12eTVZbVhCRCszUTJrN3M3VXBhYm9TTEtIM2dJ?=
 =?utf-8?B?UzZTRkZ2N3RIUEQraXJoVndLUUpMR0w5akQvTzlJZWVmZ0E3bTBaK1hkaEdC?=
 =?utf-8?B?N2IxeHpObVNCMitpZkd5U1dsNlQ5QnFTT24vRW55SVVtVTQ3Z0ZSNkRrREUx?=
 =?utf-8?B?VkpBa3crelhyd25xelRvZEw0TWF2S2dXc09kVW9PeUFyQlNlTjJJVkloZEM1?=
 =?utf-8?B?a1lSL0ZYNVFHTlk5ZGg0YVZKbzdOYW1Vbm1nSmFadVI4enpWRG1QWUZDeVdN?=
 =?utf-8?B?QzQ5b3QvYi9LZ0JKNm04R1FzUWU5eDhNTDlrR0ttem96eHJoVlZrSzUycjdE?=
 =?utf-8?B?VG5GWVpySEF0NlZkaE5teUErY2FYaUtIK0lqM1BuS1F4bllDVytCcDZWSDRm?=
 =?utf-8?B?TDQ1dVJiTVVmNkMxQU1UQTU1L3I5b05ac1JIRUgrMmdPSzZNWEJjR0RiQXB4?=
 =?utf-8?B?WlhxWXpWVTVOUm1COC9KU1BxZDZrcklzMWZHN2xMNGE1TlRkUHZBWXZHVkc1?=
 =?utf-8?B?SVM0S0ljcllYbGt0TWoyZVpTOUxJT0l3enFaR0MxNEtJaXRZV0REcm5Rb1BX?=
 =?utf-8?B?WTNaMVlROWlWcU1OMUJXcFhaL2R1YXZPbkppbkFuRldZLzhlS0g2N1dQVUxI?=
 =?utf-8?B?VzNwWDN3Ti9zN3gvZ21Zc3h2YW9WSFNBM045T0paWlhvYkdZMlZGQ05rWCs2?=
 =?utf-8?B?LzE1cEk2cytFNnZ6YTFTZTF3MjNSeFdLMVZCU2NlK2Z1SlJWUE1QVzZoaWlO?=
 =?utf-8?B?aTAyMnptak5Id1F0ZXBXd3pBeXkwcTBLWDl2ZEQ5RDNPc2lBS3EzTjIvWTNp?=
 =?utf-8?B?VUZCc000aXN3eUx3dDZQWTY4ZW55MWRNbkJDS0s3amhBWkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFlZMTYrUllRNnpCTlZ2Y2pHS3ZUNm1wdXpBSUtMUFluZkVSSDNsRE92d0xF?=
 =?utf-8?B?WTI4N1lLRE1mZ0ZpdTRXdTJTTWxkaHRFck5ZNlZqbTJVSDE0RGhObmlJVHJj?=
 =?utf-8?B?L3ZvdWgwYVZJTC9qR04xMHRBMm1PeCtWQjlrc3BUNHBDTmxFMmtTM3k1QnpR?=
 =?utf-8?B?Z0ppR05heVdxeC9zYUFRVFEwdVJqVEFENU1YOEV4cHBEUHZuRmV5ZlFEQjc3?=
 =?utf-8?B?OEIyb2ZaazlNZC81djhPdktRVW1NMGpSN0RtaEpvUENNUE91dk5DUE9VQUFv?=
 =?utf-8?B?N0U1RzZobHl1YmxRWVp6MlVwdG9aS1ZkcHF5ZTl1RmRTZUw2SmJoWVRrMDRW?=
 =?utf-8?B?WTlrSkRNSFZncmh5bHJDalE5U1V3b1FOV0IyVC9nTlBjWUZ5Q3FRWExLZlJT?=
 =?utf-8?B?VDI5K1BaaE45SEEvNUNmbkxKQlN2TXM2cmZqMmFDanE0MnAwQk56aTI1NU1G?=
 =?utf-8?B?TkV2UXAwQmxYRUc2KzdDQk0xbUtqMXIxU0QzdmgxWXNYaU9tVjVrQ3Q5elYr?=
 =?utf-8?B?WXRSZHNjbzFSbWtROUdSRVJEUnFURHJHbFpQWVJNZjk2ZUZZVW1kaFhMOXJH?=
 =?utf-8?B?WVAwallBK3FRZHVLOVllczc2dU85QTc3d3hlNks1bEVhcmplOEd6Q1BWcVAv?=
 =?utf-8?B?d1Nid1ovNHVzdHdKQ0lQN2MrVHp0WU5MK3ZrLzFYYWVrR2VLLzN3aXJEak1n?=
 =?utf-8?B?S0VMN044ZjZDKzh4MnJ2TDk4UzdMSFoycFF2RkQ3MGl3clBWOGlqQmJpUWtx?=
 =?utf-8?B?RXFvN3FKeDdDZ3VmRm11UkxNZ0FZTGRDWUFWdWZyeFNrNXpZN1FPd0lHWXRj?=
 =?utf-8?B?ZlRmc2JmWldSc0FWdlp3dk5yNkhnS1I2aDJEUEJRaUh3UlB3VDhpRCtYZGQx?=
 =?utf-8?B?WmxFUWxUWjJiMHh6VDhxSmd4TlRWZHBmdlFCUDJTTmdLVEtKZUFNVkYyRU0z?=
 =?utf-8?B?OHdFNGYyaEJkazFJVVcxdEZpRXh2M1NXcCszWGtoOUZWeWlqQUVKK3EvYlVp?=
 =?utf-8?B?a2Z3QXN1WDVLRUkzYVYyV2tEVjRxcUVqUHN5KzhsM1V4TitKKytkdWxQMlVD?=
 =?utf-8?B?OGx0M2w5OTFPWXErWWZWSzRjY0JKaFQ2UFdRbHF3TlZmTEtyb2ZyZDQzS3Vv?=
 =?utf-8?B?VFpoOEZoL0hOMzBTUTlqNklMbWh3MCtzSjZaTkZPU0ZQOTdGd2VHQ1daZWdU?=
 =?utf-8?B?WSswZFkxNUg0NllzUVRtWlQwNk9WQzBKdUZ5VVMyeWZqdURyeWswTDkxV3F3?=
 =?utf-8?B?a1hTTkVlR3RGQ01SMmVlTXFKc0I5ZXBRU2Jvb1ZjQTZzNXpNZ25vWkFhY0F5?=
 =?utf-8?B?WjgrZXEyOEFYbzVGTEo0d2ZkUkwxZ2Y1aldZdU95eUJ4Q1owelI4eW44TE9U?=
 =?utf-8?B?dEpaV2dMQU8yQlBkZkdNM2FwUTRMLy9YMDZDQ3lsd1FmNGpBbjdMNjczTWE2?=
 =?utf-8?B?dlV6MWJ5djVXM0FjSGlvdjAxUzJFRk1BaG1NMU5vSkRrZll0bTRmc09vQm1t?=
 =?utf-8?B?L3ZkaURVUzZ4cG8rb3RidGpRYmIvM0hHa3FlbllFZ2ZrU1djYnJ5MkZGT0Zr?=
 =?utf-8?B?QW9uM0Rqd0Z1eHZ2SlZhZ1ZadTJzQm8rZjY5MkJ3N3NVNTNLankwZTRYQ2Jy?=
 =?utf-8?B?b01tc29FaWxMb2xSUS9SNHhaLys1dWU1ZThiaFpVQWhPZDNpblBUQyszTmJu?=
 =?utf-8?B?ak1NU2Iwc2hBdzNjYzBHRDVNRHFDNlZnbDlMcXdhTlhQWUpWSkc5NUxKLzZq?=
 =?utf-8?B?dmxJRzVmZzl5Z3FZUmdZekFvemZwNFhqNHdVVUxLUkpKYU9kZ2JwZ0twNmVi?=
 =?utf-8?B?dmlWM3h0VWV4NFpwaXVUSWlwdmNCWFVISEtOaklURVE4QWZ2Q0owanRaTUxw?=
 =?utf-8?B?TngzNVhMU2pBaEMrWmg5MTlhNk5kcjU2Q1Y2bFpPNGRma1l6d1JDckxRNXJM?=
 =?utf-8?B?MmNNS3dhUlRQTFFNVUExVklmdUNsMU5sQ3dqVi9DTjlKTnJuc1JTR0Jmd3h2?=
 =?utf-8?B?bC9PRnliQVkxcHc4QTAra1Z2ZnZWblplei9HUHNBZEp6aDlrYnF1Z0VrM29J?=
 =?utf-8?B?eWk1RTZJOGp0TUV3ejhDNGI3VlQzeko4ZzNDVDJvejdmSHFGNTZycmNnTWdk?=
 =?utf-8?Q?0OG4XXCy2KlHSotmHp0hy+w6E?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6283e1df-5933-468e-3014-08dd50a35c22
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 05:07:51.2089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +9eV1WMHag6KKYVbye2AASrrYlYnm6GAN2TFdrpWMDcwQ9YcwRX4vU6efTZjv/LVVo0FVw+7vXA5RMpcFjqHSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5782
X-OriginatorOrg: intel.com

DQpUb3BpY3MgbWF5IGluY2x1ZGUgYnV0IGFyZSBub3QgbGltaXRlZCB0byB1cHN0cmVhbS9kb3du
c3RyZWFtIHByb2plY3QgDQpwbGFucywgc3RhdHVzIHVwZGF0ZXMsIGFuZCB0ZWNobmljYWwgZGlz
Y3Vzc2lvbnMuIEl0J3MgYW4gb3BlbiBvbmxpbmUgDQptZWV0aW5nIHRoYXQgYW55b25lIGNhbiBq
b2luIGFuZCBhc2sgcXVlc3Rpb25zLg0KDQpUaW1lOg0KV2VkbmVzZGF5LCBGZWIuMTksIDIwMjUs
IFVUQyA3OjMwIEFNDQpQYXJpcywgRnJhbmNlIENFU1QgODozMCBBTQ0KQ2hpbmEgQ1NUIDM6MzAg
UE0NCg0KSm9pbiBab29tIE1lZXRpbmcgDQpodHRwczovL2ludGVsLnpvb20udXMvai85MTI5NzI3
OTI2OT9wd2Q9V21kd1MwcERPRFJOTVM5dFFrNTRZMWR2YkZscVVUMDkNCk9yDQpodHRwczovL2lu
dGVsLnpvb20udXMvd2Mvam9pbi85MTI5NzI3OTI2OT93cGs9d2NwazUyYTlmOTZkOTg5ZTdlMjBi
NjI4YzJjMzZlNDhiNjhlDQoNCk1lZXRpbmcgSUQ6IDkxMiA5NzI3IDkyNjkNClBhc3Njb2RlOiAz
Njc1MjgNCg0KDQpSZWdhcmRzDQoNCkhvbmd6aGFuIENoZW4NCg==
