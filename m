Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19934C81
	for <xenomai@lists.linux.dev>; Wed, 28 May 2025 04:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748405694; cv=fail; b=USZVfPgQjI46mcUtZhxZ3qgDscE3i52ZoietLGFT9gIzQ28TSyNETh6L7vn6iguVEtx/HNCW3bnbLw+0OB+MPdQ2v8yYTo3ICrWPViCcJ8a2omEcQIrM1j2Sj3Ag0ycosz87oubQSYBIJBjjy5EgA6n8UAqgsbPX7agKUDNirjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748405694; c=relaxed/simple;
	bh=SkHi542At5IxAPdtyKH8dsXZoPDCaUIrDfTunqzeHhg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D+mlrGNVdQEOJrkPQ8kRbTAQE+HNTg8DEqAuZOzPJLIor6n2w5YQYYdAeOTEJbXF6qxmG30+M8ofbTf3q8vf9YfIgI7g9lbhRSMuts40sgeL8g16/nZ3ukPWPBszt08Au3j0U8SNGzs2906VYMkz4cVVaWCdoCN29r4DEQeYJX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KXbgzRSd; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KXbgzRSd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748405691; x=1779941691;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=SkHi542At5IxAPdtyKH8dsXZoPDCaUIrDfTunqzeHhg=;
  b=KXbgzRSdUcW+5CudImfcorpZmU5WdOO8LzgELrpRwevDe8X4qk40KaE+
   gtvNXCWkm12J759tc1mPaPt7bah8/KKIchvIOwLugH//LDbuIg+YitQ5V
   hzpSqtk/D19RM0zftfrFAKhOfoxP95wDur86PdJ/k9ZIXSHgAOhy73o7Q
   CakUz39uY6Qj2oq9pSxHmU0xyhyp0D1oXt17R+1k4dRJ0q4f20jdc1Emm
   B3z/Z0LhCFDpgjdbt8o2ch2vVZWa/a4j/U2yJ8j1x9ea71pOkpHD/3zEx
   mYYf1PK+d4dA0ocE0KyBFOGx//jbM8SPSXRshOAli7eUB+6Mn6KdXuEvA
   Q==;
X-CSE-ConnectionGUID: IDFQiHvxREuW8HyNmhgrWw==
X-CSE-MsgGUID: WPoczuP0Sha+PgPsCInfCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="49530980"
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="49530980"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 21:14:50 -0700
X-CSE-ConnectionGUID: 8fbCaplwSJSyVjJdCNHccA==
X-CSE-MsgGUID: P2Ibks07QsSYu1vaIiveww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="143449166"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 21:14:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 May 2025 21:14:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 27 May 2025 21:14:49 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.56)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 27 May 2025 21:14:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JpwA4IM5yXNBbNMuk7ldKx4ynmYL+dQSvI+Qt1muac+JLOgDIm6wlEfuEViBnyIz3by0XfT2z6swNjsxfTiqB9XQMDuv8jL3ETWhRIXy9YPPuW1guJm3F3cl2lq4P8y9UOJP5y3TzT7M9o15oX2/zNOkhecQoNa8G8Dm4XVoQ8DkSwLMelWfcxZ9lhqS9iOXYm1qDFfD1Wj8w2AORW0TdcN4bmsKakwnYhEz0SQFDdpuM25l8tRkmxtIW/5H3PXtJoSds68Of0FbOJJRp/ILRTX7Q73ccSLUKyVwFM6t/HcYFM8NN/UTw9xStUkRo4j/vfbQl+6rU3p/9fkCGH7YKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SkHi542At5IxAPdtyKH8dsXZoPDCaUIrDfTunqzeHhg=;
 b=EqoowrjvGZ6CQf7om+NksuSAkdByfJpM7BlCMHHZy6uBZNtht2K7aLYH+uy+8zSu9ecwq+XHLV/PtM2rv/emD2PnvTqq9x1bChE1mnUaRWab5w7i+wf57JMpXktHQyQGh6DdyaG+M4xMoAB5UoaWMzdJjT51yFkN2oBstQWTu8ZObWPQ9USzenel5uf8WF6jYei0uIgMekR8olmU/lqFmUy0teCK63bg7/EHCGBgo4nu516/z8XXF4xxb616GlxHdqcPeZqDkRL/qLkpMvf24gWCfopbOhAU2po6f6G22fWc36wdXCypA7t+WQPEI3206377/KShrfjNopMTuHMz7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by CY8PR11MB6940.namprd11.prod.outlook.com (2603:10b6:930:58::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Wed, 28 May
 2025 04:14:05 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d%4]) with mapi id 15.20.8769.022; Wed, 28 May 2025
 04:14:05 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday,  May 28, 2025, UTC
 7:30 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday,  May 28, 2025,
 UTC 7:30 AM
Thread-Index: AQHbz4bz6J44PeR/nEmCyTkT19i78Q==
Date: Wed, 28 May 2025 04:14:04 +0000
Message-ID: <PH7PR11MB7499C2C6A4E4E6239A05C979F267A@PH7PR11MB7499.namprd11.prod.outlook.com>
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
In-Reply-To: <PH7PR11MB7499BABF9BDA783C86090B60F291A@PH7PR11MB7499.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|CY8PR11MB6940:EE_
x-ms-office365-filtering-correlation-id: 987e6325-9969-469f-574f-08dd9d9e159e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bWVmdDZHQnU2MHlBWU4vOWR4UXZSSmdrNk04ZjkwV3pQNXpyVXZYVFdPVHYv?=
 =?utf-8?B?dDNGdEVoVUhGbGlxN2p6VTFJRE5wWHA1TEdjdnlkT05sb0xmWC9kMlpyTklL?=
 =?utf-8?B?QUg3SHBoWEQxV0ZmblNSRnhRTGtpOGQvOGVqazZ0N1JFOTFUNVdJZ29uOUxH?=
 =?utf-8?B?MWx5cDRVZUZjMm9ISGc4MWRITG9SNlQrT1ZLbzlWTUIrZHhzTHRYQzRmRzlK?=
 =?utf-8?B?RHlhMTFMZlhYMXZiYm1NZ1JSVjY4cXh2dUlOK09CaE9WMUdEQlJ5cUdwOENB?=
 =?utf-8?B?RjlNUUVsbEZ4dGplZUt4RHk5RlVwWUpaTlZwN29PcjQ2OWViK1M0U3YwREgw?=
 =?utf-8?B?UHFmZkVETnBNZkdZOEw2RHdmZW43b2t5b3c4dW56cGpwYTk1RjdPMXQ3WGVU?=
 =?utf-8?B?d1NQM3JPMXZDVlpHaXhhK2ZMZ1lVNVc4Qi9GQzVPZkpLTGgzbExMMllKalJp?=
 =?utf-8?B?SUdOVGdaQVZreFo4KzZUQ29KQm4yQmcyV0RPYmIxNVNNY2JER0d6Qno3KzRJ?=
 =?utf-8?B?bmpId3VIdm5SNXdBV2I3SEZtMjlIeFpnUnBLWWRyVFBNbWVsK2JUZXVVVTI0?=
 =?utf-8?B?d0sxR1psWXpNMG1WQUtzTjZyWUpMeEdkNmJHMXY0R01sQysycmQ0bS9LMDI3?=
 =?utf-8?B?clNneEcrY005L0MzSmN3cWRvU3c0WVY2UUE0bU1WUjROSkwxNWdyVmtRWkRo?=
 =?utf-8?B?bXZYc25oeHV5TlloOWFBS3VuNnBianc5dHRIeHl6Z2VpSkF1U0J3V1NoL3pp?=
 =?utf-8?B?Sy9wME4rWUV2R2VpbFFQaVBSVnZDeDFjL2p1Szd4dnIrb25jYk9TaFdWdlNu?=
 =?utf-8?B?Y1V2UmlEQytTVjdQVWNLYTIvQjUwL2ZidVlTV0NkdkhUbGMxY1Vjc0I3YjJ6?=
 =?utf-8?B?UGMvcWxIajRyQWRwdW9xMnpZSXpZc1ZnNlpFenhhbTJWa3VlbDBRWVB3bkpx?=
 =?utf-8?B?N3V6Q2JGcm10S0xqU2t5TnozTnNhU045NHhGTTZuNU5UWDNkcVZmNTlmS3Nh?=
 =?utf-8?B?V0dSQXh4WDRiNlZpck5FOU5telV6QlpmUFlKMmZzMk84d2JUeDBJQ0M4cW44?=
 =?utf-8?B?ZStOdC9XTHVmS3J1TzZmMkFTeWVPOVdvcURPL25PTHZZWWoxd09DN0thR1dY?=
 =?utf-8?B?a2xOams2N3NsbmZ1akZTUkxoMGN0VnNpU2RJNlZPQ2VWbE9YbGRIaGtNQ3cz?=
 =?utf-8?B?TWN0ZmJtSG5YbFJWS3JnRE5TK2JBeWk1Y2IxNTA5WFB3bDkwalVLdEt3M3RF?=
 =?utf-8?B?dG01Qm14QmdLTTlIY1NBWFFHZjRLWjBReU1saU9zUkVVZWpwN1R6a3lJWWFZ?=
 =?utf-8?B?R2lRSHNPT3V5VUpXdG5XaVh5Mi9Jd0hONTlyc1czSmYwdVhxMUpKdWF5cEdl?=
 =?utf-8?B?VERORDB3VmNISGNodXlJanZucUo1aUVDTnpqeGVHNVNSRlhlckNrNjE2bk92?=
 =?utf-8?B?cWxaQWNDb2lrb3oyUHFVajRxL0htaThOWDV6c2ZBc3oyQmxxZi9rNjlHdDBF?=
 =?utf-8?B?allISFpEOVkyeC80THQyYS93RUNBRWp3UlVvMFJNNHg1Rm9paW40UUFBL2R0?=
 =?utf-8?B?SGVjQmNrQlJxblI4aHhkbUR5V2xJdmlSMjA3VlRCZEpwK0poQ0hDWnlOcGNn?=
 =?utf-8?B?c2J1UXZDc2k3d3VTNnE2aUxwY2JvNTYzYTFLZDFyd0ZPQlFBMHVndWhxK3dr?=
 =?utf-8?B?Y1diejloZFR0alJSbkZUV0VQODh0WTJsUG96bjQ5ZnhRcEkrK3FERkllOHVl?=
 =?utf-8?B?WkF6RFBXaDd4bzVuZlRuUmhKZzJhSHFGbDBlTjB6aUpiWXczQTFEZ1VrTUU4?=
 =?utf-8?B?OEhBNzFjWHh5VnN6TUJFNklTTTJKd0xucjNTeHJwei9lbk94TDlWM0I3Z1Qy?=
 =?utf-8?B?UCs5VzZkZkxZVXJTKzl2R1AvRjFWTlFUSTJYallTcUZNbUszdFRHcks1cE1L?=
 =?utf-8?B?MGM3YmpNT2lmb0I2UmYwWWFDVU43eEJRbUdUWktJRU5QaG12RDJHcFhadDJF?=
 =?utf-8?Q?S6Db1UmqSs2NCL2JXhH7cL1PdI1KZU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDNHaTBPZXNScTd4NlAwcFk3NWFvSTdKbXF4b2JVTmpwOWxsZkMyOVR6NCtM?=
 =?utf-8?B?TVdtMk1JSXhkaS9qOWhmbmp0QllMTXd1THFJdDk2WTZqcGc1ZnhobFZBVndn?=
 =?utf-8?B?NHNZMyt0REFhWnNQZ0k2RXQ3RjV4MlF3OTJ5T3RFK05jUHJWZXVvVm5IL0NI?=
 =?utf-8?B?M0JoN3ZCYkc4ZUlVdXBxQmxHbXdIdldHVjFPYmRSanZJV0lIQnJ2VXlaQyt6?=
 =?utf-8?B?SDF1UDY0VmkyMVRKYXhNVFRVYzJuZkpBWGFyeUJqVFFtTkQyREdmaFhiWFFT?=
 =?utf-8?B?NEV2NTRtdFROQUNHSzBzQ3NxQWdRQmR6R3Zuc21jU2VRbUY1dkIxZE9yWC9W?=
 =?utf-8?B?OVhaK0twekRZNytzYWNwSktaUEhTVHVMNVJzaU9pK2ZiU3NnVVNsTmhXcVNI?=
 =?utf-8?B?dktSdmVFMVVZKzN5U253WFdJVlpYbGJrYTRtYVVwbGkwQ0p0dmtFRjJiUTJJ?=
 =?utf-8?B?amRrWEFzczJGQ2llVjhVUWJlTlYxN0xNVFdHeTBlRTl3Z1drTTZ6aWk0MDFS?=
 =?utf-8?B?bFFKeHBXSitZNWFMeVNpY25PM01vYnlBMGQwU0lIMzQ2Yk9zYjlIQUFScDdZ?=
 =?utf-8?B?WnlsTFBpSEhuR1AxeTNRNkpJVjdmanA2RXl6OURPVmVOb0FKTFpwam4vYVoz?=
 =?utf-8?B?TVhIVFZHY1lwMkg0NkRxRVUvQ2w1eGV3cktmQmRSbGdSR2I3M0pQeThCcU9O?=
 =?utf-8?B?VzRWQXRwdWhmOW5FUEo5MHp6N3BvYnI3YjFSc0VMZ1ltUm5ZYVNpYmhMaGZx?=
 =?utf-8?B?N2VnMkxkWTNOY1cwVlY5emNmdEU0NWNSV2tpQmlZeFlBbUtDT2pyN05MblFC?=
 =?utf-8?B?NWtFdkZ1V3RqOEcrUzV5cHJqUkh6MEJMTVE0VjRvRkc5M09OcFhqQUFFOHhj?=
 =?utf-8?B?WEZCWHRoUnBKR2lNenNkR05XSDBFcGpIY0g0VHlCb2E0Z3NPWkJLbzdIMDNp?=
 =?utf-8?B?cCtKZEdqWk4xTTBrcFRSdnczRCtjc05aaWVqNnVKWS95Q3FQUHN1UEMrb1d0?=
 =?utf-8?B?SjB5ZzBzZTlrVjk0OWZrK0IxOVg2d0xMaUpIYTlMSnMvd045QWpaS2ozK3Yr?=
 =?utf-8?B?Q3VhYWtxSEtYZWZnRlEvQVhiUGNuM2h3SllocEFDR0E3Z01pZGZOUWdKZEs2?=
 =?utf-8?B?MStsWWRXS2thejFQUUtqRmpObm1WVGxoVzVucEN3b0FZamhmWHFxdGJvVnRK?=
 =?utf-8?B?YTcyY084UytUbHB0bHN1Kzk4K3pyYzIyVlVZVHZhaEVXSDMvcmpxQXFEd0cz?=
 =?utf-8?B?bEJPUHpES3RTS1phSmYrZFQrdE9lenVEVVlsMWFwbFRrSXAzeHNQU1BCZzQ0?=
 =?utf-8?B?RDEzcFVnUjhvNEx0QVJ2WGNDRDgwTnpEUEZVMU5NbWJLV3diTklTZ0RFZmo2?=
 =?utf-8?B?aUxVRC9EMThrcCtNWVM1aXF2VEtpWlBiMjRyMW0wODZEclVYeUJTL1ZISWJH?=
 =?utf-8?B?eDNUeTJLSXA3WVFkQXRxU3BTbkNObHBkMHdnV0RDaFZKcUh5MFoveVBkcURL?=
 =?utf-8?B?WW5yTWp2VVdyVDlSSDVhVUhsY2hkdTdXRnN6ZE1hbW44V3BJVnpDemIrQVFs?=
 =?utf-8?B?TmVCMjZoTjNyMHgzaUg5N2dDV0JsT081YWcwcmVUUWxFbTB2RUg3UkRsa2t4?=
 =?utf-8?B?aVkwKzZjNTJpc251NkN2Nm4xb0d0NUgrdncwZ2xnRmRHWTN3eXBpV2d5b3Zx?=
 =?utf-8?B?TVdMempqdnAyTVFpOFJYOUxSM0Y1YjVqRWhOVEVwbEp6RndteHltbU50MkRX?=
 =?utf-8?B?VDdEa2k0d0svTHEzd3NlY3RIc2JSMnNmcTk5bGV1QXE1OE15dmtBQnJRQjhN?=
 =?utf-8?B?M0lacWluR0s1bTJUVDVKRXJ4WERtNEoyVkxIY0lLK1k5TVhBYkpOcDA1TnEv?=
 =?utf-8?B?L1pNNzZrNFpqbjZIZjZsSTl3U2JWM3phS2dCSGRwRDYvL0E1d1haS0xyOXdQ?=
 =?utf-8?B?bXFSSWtOdkhuSTN6SHRjakhRSVpYQkp2ZmJDTnFoQ0FSbkRkUzRqWTg4SE83?=
 =?utf-8?B?S0NSWHpkb21NamhWcmRBR2hCSnd6RE9wbElWTWJBZC92VUVQU21PVTI3S3BN?=
 =?utf-8?B?R21OQTdLaGd2M1NTVitTUFBQSDloRnVaeWNuRVRibkZPMGNLTDJ3Q0xnNXRO?=
 =?utf-8?Q?M/u+KUHZqrnhVFTy7qYs7hvw9?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 987e6325-9969-469f-574f-08dd9d9e159e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 04:14:04.9410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l2OU7G+5rqzxMUiWr6jiINNuxFp5TqtRAEtyv/JtXH8Rc3AW2Dk+MBbMpPWlcTLimvVsUPD9e3JoboqOhAoRlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6940
X-OriginatorOrg: intel.com

VG9waWNzIG1heSBpbmNsdWRlIGJ1dCBhcmUgbm90IGxpbWl0ZWQgdG8gdXBzdHJlYW0vZG93bnN0
cmVhbSBwcm9qZWN0IA0KcGxhbnMsIHN0YXR1cyB1cGRhdGVzLCBhbmQgdGVjaG5pY2FsIGRpc2N1
c3Npb25zLiBJdCdzIGFuIG9wZW4gb25saW5lIA0KbWVldGluZyB0aGF0IGFueW9uZSBjYW4gam9p
biBhbmQgYXNrIHF1ZXN0aW9ucy4NCg0KVGltZToNCldlZG5lc2RheSwgTWF5IDI4LCAyMDI1LCBV
VEMgNzozMCBBTQ0KUGFyaXMsIEZyYW5jZSBDRVNUIDk6MzAgQU0NCkNoaW5hIENTVCAzOjMwIFBN
DQoNCkpvaW4gWm9vbSBNZWV0aW5nIA0KaHR0cHM6Ly9pbnRlbC56b29tLnVzL2ovOTEyOTcyNzky
Njk/cHdkPVdtZHdTMHBET0RSTk1TOXRRazU0WTFkdmJGbHFVVDA5DQpPcg0KaHR0cHM6Ly9pbnRl
bC56b29tLnVzL3djL2pvaW4vOTEyOTcyNzkyNjk/d3BrPXdjcGs1MmE5Zjk2ZDk4OWU3ZTIwYjYy
OGMyYzM2ZTQ4YjY4ZQ0KDQpNZWV0aW5nIElEOiA5MTIgOTcyNyA5MjY5DQpQYXNzY29kZTogMzY3
NTI4DQoNCg0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQo=
