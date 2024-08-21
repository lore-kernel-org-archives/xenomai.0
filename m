Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145662AD31
	for <xenomai@lists.linux.dev>; Wed, 21 Aug 2024 02:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724207496; cv=fail; b=qVVBbvCylWInCStDQNHAPpwkySRVZXkwRxBVKe2m61BudYY3NKNflZjpuA2TLqer9mrwQa/1MesC6gg5ndshxQ85PAfa3jG4ck5aSb1jzYvWogzeQ0tGnFOokedMuUDy42p/dQEOo4EeU+Z/ewBOqOa9jBZZiBrmZup9sveL5I4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724207496; c=relaxed/simple;
	bh=1EtyrebyrNmYUZHntllEpwc671IXoaeirh7GBlKPCu0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Cfs6F7delpd8zf382zeTAm94lKi2TYlDEbL2UJvbwGGhE4dNEvs2Rc8/sU+97GRYL2XFpUbT2WhyLtk7JCK/VejY+4HKu/znC9fmEoUbR/eIOS57sZlNK/FHZUwRNNRrixcbVARydZoi5VorGd7Na9x+jMMIbcjlW0BMrp2Nlmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZdQqoi+c; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZdQqoi+c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724207494; x=1755743494;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=1EtyrebyrNmYUZHntllEpwc671IXoaeirh7GBlKPCu0=;
  b=ZdQqoi+cVQcoaBH4+1VwvfPQqx+s+fdj06FUj5JTQfRXv+poneseOwWH
   DJbiwrBorS+IDtv6kOkChV4aTDrwfZAvLZW3aXB2lrzlC2V8FlpSGLR+Y
   9wh8SDUwex934MEgnZ8VVl+jfz5vJVKvsOeWBRRqplQYuS1GQFFCsXVoj
   r2Sbps20FvrQ6x0kp+cXX/oBwk5QWYKbXku7MRdziCc99180zElyqubNz
   MuweiUpTqP7JqSYEpDg3icf5qrsdwnSlt7o9WyFOnK5iGP9BsEG7xBpRJ
   KY8uZDu9aBP/1s8aND1UKd+bS6POLj8pBtvkobYE54ieT03WDnzSDc3bB
   Q==;
X-CSE-ConnectionGUID: CnODDtxVTJ2uNb6CjsiMiw==
X-CSE-MsgGUID: o2KCexWfSUSzx5frV15iEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="25442588"
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="25442588"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 19:31:32 -0700
X-CSE-ConnectionGUID: ynchiFr9RlqkpThHQM+nEw==
X-CSE-MsgGUID: nF0F8VhERAenknBM3ume1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="60795032"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 19:31:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 19:31:31 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 19:31:31 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 19:31:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vCddv7jlrAdOongD+5++Iqf6VXRQ5alaNTH3IaNk9fKKbs21VKpRl8gnR+T3zXWW7romu1Vg6IN4m1fa2QlZ832EQUsTikNmrR6J6u2PFkY1cdnLvfENm9hNmanLw3GE7Gu6cH5L1TboWcuojqmUP5LgYJMcjdONY1DXy29y6/ohDqBfkEjxxvxoA05oSSbpc1ihzzp8QCBLYlIUDauB5PAXNSWEcRf7cYnobVWLuvyxccuiWrTAWfbMqbH6U2OL/7lGDwGN3Xpu3zMNYFLzVFRWwQwsjLVT81X41jq60N/Bd1gcW3HyooNIRWnuMcc1KOW2DGPUin/AvwqYXp/BqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1EtyrebyrNmYUZHntllEpwc671IXoaeirh7GBlKPCu0=;
 b=YLRsWiW/W/T5uSSAGQ7oNSeRH3j9UC8GNIe58fmk028sQ9mojARdlY5ZB9r2EjBx8mdH+0SyKY7I0UGJbWmb+dZKG1tKPk9OuLaopbTaLFwuvS4kOuNPeeVV5KuLD8k7yOMt9ciXbTF/tD7xn2IDLRU/b6TWyua5BsFKs3jPYCYvuxYPXngKD4wru8vfIpb1rvrwMFDoTO7UOB8jL1ZXE2gK9uAcnGC8VSgBK++DLupLsHX5YPGXJsn5xBONRRBLC3omtYseql+4s91CUELD1CLAyvt1APxEFdAKUn6XV3AusJTcGr2DHFaKqrSjjjoqlcFAAJDKOi/AdYsQPgNr/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by SJ1PR11MB6226.namprd11.prod.outlook.com (2603:10b6:a03:45b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 02:31:29 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d%6]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 02:31:29 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday,  Aug 21, 2024, UTC
 7:00 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday,  Aug 21, 2024,
 UTC 7:00 AM
Thread-Index: AQHa83I6hjlSHPIzZkaDMvDOm7kA1g==
Date: Wed, 21 Aug 2024 02:31:29 +0000
Message-ID: <PH7PR11MB749988D39A66B3EC8E9431E6F28E2@PH7PR11MB7499.namprd11.prod.outlook.com>
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
In-Reply-To: <PH7PR11MB7499B238FF2BECBDD784752AF2B82@PH7PR11MB7499.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|SJ1PR11MB6226:EE_
x-ms-office365-filtering-correlation-id: cbc44806-1ac8-4d87-c546-08dcc1895cd2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YUw2UlRzNHEySGR3RXlPc3hmVWdZZFl6Y1JPNEE0TnRjNTh6WGwvTlZGWTJ1?=
 =?utf-8?B?eXIyZG56OTNjQ0hBTUQ1NmlOYmQ4Uk5pMmFRNkxWdlFsVURkSlNrdDlOaTlH?=
 =?utf-8?B?cUhtazhPZ2l2THdxWVkwZVJQcEU3L25ncnNCQWlxSCtHazVjT2laMkVOUDNE?=
 =?utf-8?B?K3BnYUF5WVlTS1NHZ2ZlTlkyZ25BeUF2S1Q3em9lQUZ5Vk1FZVoxb0F5S09k?=
 =?utf-8?B?eEthMUp4ODN6Y0lrdjNJRFNYZ3FGNDByMW0wcGZRUVFaL2IwYXRwVU51VkdP?=
 =?utf-8?B?R0h4K05Hazc2NDlVR0dNczVkOFBkclVoZkdCUkxIYTl3YkNNNGRKQ2t5SHov?=
 =?utf-8?B?N0RhZ2loN1R3UTZtamUzSFIxNXY3UVkveTUvbkkyWUkrUjVXc1g5TEtmd0JB?=
 =?utf-8?B?NmtsWlJoUGxsN0NGdWtZY0ZxcndsR0VJbFJxN3ViZlNZdC8vNlhCOGZFZ2h4?=
 =?utf-8?B?V0MyZEplVGtOMENwQ2kzZnBXTzhWL1R6N1hLRzZkWk8yM0JLaisvZlZza1Zh?=
 =?utf-8?B?SjEvc0ZEbHBsamhnbS80U2twVFRHQktmTVQ3RXhVUS9ybklWQ0pWUGxOTGJz?=
 =?utf-8?B?UDNXSGh1TENweXFYSXBDVGlVVENQNWtWTnFxcVlzNC9kQlA3aW5tWE1ReGhN?=
 =?utf-8?B?Z2VBcFJLWVJZbUVHQlpEWW85eWpuVTVFUjNvN1RzVE13ZkErNjUxSkhJbnR6?=
 =?utf-8?B?N21DcWlCbkFpUWpORVMyMnNZTkpvQzNxL1RvMHQvbEJqR3ZjTXB6a2VjRzJQ?=
 =?utf-8?B?aVI0QndpckJtT3ExNTVxNW1TT1BOaytGd0ZRTDJuOXNZMFFjcXh0R2pNODBH?=
 =?utf-8?B?aHVRNWxxWVB4RVFtaGhhaHBrK21OR1FqaUY2U3FXaVhscUY0S0xpYk5vWnZK?=
 =?utf-8?B?V1paMkkzVnRVMzVhL1JZL01udzFRN0NXSGZYTzlyOUxZNjF0anQ0QXFyK29u?=
 =?utf-8?B?OUhNdUl6V3VjZk1nVnNsNHdMK2dSL2xOWHY5R0xMdjR3K1MvNHRQNldMTFFP?=
 =?utf-8?B?SU1jczFyM2xPdG5Zbjl1ZkxMOS9LWUlvbE4yU3RocnZFdzQ4dXB6c0VIeExX?=
 =?utf-8?B?MThxQmVUallKZGYzcnNrNENUNHNIcjZnNTVaamNPZ1BEbE5xeHhIdGhjYlBv?=
 =?utf-8?B?cW1yenBwdUlDZmh6L2s2MjFmelE3dStEVDZudVk1NGMvd1VyUS83cERhYUc1?=
 =?utf-8?B?c0puVWxoYXI1QVZxSnVDQ1dtczRSa2k4bnZraUl3VTJDT2xmTUtOYTVweXJJ?=
 =?utf-8?B?NkFsQWR6NisxMzR6S1NPSWh6YWw0R1l5TFpXc3U1Q3FHV1ZpOFVJNVEzQTBM?=
 =?utf-8?B?UWpWS3hmeTZ5KzdOaE9Ld0ZMbTlleDNveFJ5Y0dIbmsrLzJYaDVuUzhXTFZI?=
 =?utf-8?B?VVFnaUU5YmcvK1p4T3M0U3Qra3A2OVVGVnhSVTRJRDRNSmxOeXlyTnJxb0ow?=
 =?utf-8?B?Q1VzbFNWNFhXbWtkS0pFQWx3OUJIYTR4ajhZcEZMbjV0ODh0Ly9aM0RjNEQz?=
 =?utf-8?B?S1pMSTBKME1ISnU5eGlEVzkwcGZlTnVzeXNHbTdwZTBvYndFQU4weXRGcXBG?=
 =?utf-8?B?NzBONlJJYklxQVRmWU4yMkhRdVZkRzd1Uy84Q0toYnF0M3ROcVhvbDg5dTlI?=
 =?utf-8?B?bGowdGxsSUIwRzRUZWl3ampKZTJNTGVYV2thVDZkN2srbkg5eFNHMjUvalFk?=
 =?utf-8?B?WGduaS9QV2FHeFJDcEw3aFF6Yk9sMFdYY0NQQ2c1SEQ5QVlmK1c2NkJkR290?=
 =?utf-8?B?VzVJV1hQZGVNYi9lTjA5K1dVK1Vzbyt6VjduRTUvaSs1blErYTY1WlpiVTF6?=
 =?utf-8?Q?DkM55mFlRCz+wbwvIK8oi+HCGuwgP2xwWcHTY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Yk0zamxCSk1YS00vKy8xL3JabU85UElUZFhNWTE5Y1FTdlRYSkpXN1pmRnZr?=
 =?utf-8?B?a3dUMVhxMVdTSXBXbDJSZ0pNUnhVZnJnb3pTcldyUlpySWtDWTd5N090MXlE?=
 =?utf-8?B?aGl6emNQZVJXQll0Nkl0WkdNQVpDTnIydGpsbGRRUWh0ekY5US85V0pDY3Y2?=
 =?utf-8?B?eWFMeFpIcTd3SEdyc3VPRTJzOUdUbWhVYXZ4UlloNTFJamFMdE05UXB4UlRE?=
 =?utf-8?B?U1lqMHNIUHBraDlyc3VjMVZmTXNBRGxLRVZYRDJQQUJWK2pUYjM0cFArcHJM?=
 =?utf-8?B?M1hkSnIzOUtZSTdRRDNjRTlleEc2THVmRUZDQjF4elAzZnRQbWsxaXI4Tlhj?=
 =?utf-8?B?Zjl6SzhBTjE2MDJwNnRRSmtqeEwwYzJRVGhlRFpXWUZaOGhWNW0vWDBkUlBH?=
 =?utf-8?B?Sm1oMzBld0JvOVF5UlgrWVpYN3NkMXVVR1V6cjZyR0tZdGVBY3lYQnVBOUVT?=
 =?utf-8?B?YjMvdnNRcFNSSDN3TGhINzEwNVpQTGh6MUNRcjFWNGtHazV5S1FvOFF2bFBs?=
 =?utf-8?B?cHNoOHJVOFdheld6UFlHdWFuUUJKdnh5UDV2YklhM1hML2tFb05qWDdvM3B3?=
 =?utf-8?B?M1pBNGJzNWRVeXVJN1NuWnMwUDhYczRORExmOXNVeHNkVE92OCt0ODU3dzZp?=
 =?utf-8?B?VjRPTU1ZazQzV2pxeWxMLzR0VTVEUkNTcnJCc2MydWEyOVY4bWFmQkVFQkVR?=
 =?utf-8?B?Q1V3cWtYcE5KSTJBMkxrTzJqZE5rbzFWUDNKZlNpUy9OMExPQTdUSFRJNFY1?=
 =?utf-8?B?aHJRd09EZU9tL0RpdFg4Sk5pSWtiTm9Jd09oWW1kNWlQSUVLVWRkQThURStv?=
 =?utf-8?B?MEpkaUIrbmxKM0hqSGtpWU1vTDFrbDVaVzVXbjNYOGQzVitEb2JpeXVHVnN0?=
 =?utf-8?B?aGNXZ2VzRUt1U2J2bUtTZUJXaVhzSHppNUw4RVdudGZWd01hdDBSMVB0T05U?=
 =?utf-8?B?NkMzWVd4ZXhJdUplNThsSGhkN3V6YWlIb00yNkhHaVlWZFRITjBBMkZSRjFO?=
 =?utf-8?B?cmdCVUQ3RlZvVEtnSUJHNVF2RHI4ZzZnZlB6NkJEeWpkcHZvbEFubVcxN0Yx?=
 =?utf-8?B?eWtuc0p6NnI0alpHNXBScFI5Zk5BYnBnOHl4VjhEV21iNkZyeFpZZUxXb1lo?=
 =?utf-8?B?NVA0MFhubDVVY2JyUHVpT2l3N2llY01pUWRVd1IyaDlzSzhYb0dZUmdyUk1R?=
 =?utf-8?B?dzM1Ty90NTB4VUVJbmlNSEJNZk92SUJ4SXM3UjQzTndsME9va1NuRlBiYVpN?=
 =?utf-8?B?R1owZlM0R2kwL0FBVHczblZVVnBtblp4VFR0UWs5WjEyaFY4TmhhQUhJMkht?=
 =?utf-8?B?QlJsZDcvbS85ZmdaQzZXK1VzSzN2K253Z1Yzd3VGM2N4aHZZa2ljMStrck1B?=
 =?utf-8?B?UkpFSmk4SW51dys3V29oTDlNUVk2cFNpU0tNSk03TjVxV1ZqSkF4MHFzUnNs?=
 =?utf-8?B?cXE4dlE2TUt5RGZ5VW9naVhQeVF3QTE5emQ2SnpCcGorR0p3OVl3ckRVdlkr?=
 =?utf-8?B?MHBBQm13ZTRYeStzTlozaUo4aU10N0VVam9VTzVYcWNNZS96WUJSWEFPWGxk?=
 =?utf-8?B?S2N1dmFidEgvTVdBK05XaFUyLzFiSFI5NmY0dGV0SU0wL3JWTFhWbmVmUWNT?=
 =?utf-8?B?bkpQR05GOWZ5NHJHdGtLWTh2TkxTdnh3RHZld0w0L1pqa2FPUUNxQkFGRDEz?=
 =?utf-8?B?SWMwVlg3eSswNXd1WGdiZlB4VlI2c3U3c25Mc3Z4YnI4MFlDV2NNd2Y0RWNj?=
 =?utf-8?B?eEJSRDFwb2xGNFZKcFp4T1dnY0RQNFVXNFRRU0N0UGdSYVYwQW9KZWthTDBR?=
 =?utf-8?B?MGYyVzhEUG9sbFNWcGM1ejdwRjhrM3JYTnB2cnQ5WEZjcUVKdWZHRGJKVC8w?=
 =?utf-8?B?ZFFyUHBFZm56c25YRjFsKzdoWnl0N05vZllxK1FtTzluaWpNSkx3YzJIQW5B?=
 =?utf-8?B?MGRuaTFqSHgrZ093a0UrYThmUFZNVUNnUWo4eFlkakNJL1l6aEQ0RkNINjVZ?=
 =?utf-8?B?M3BuTmsvS1FpMWt6MVBSUUNLcUVYc0dIeDBRc0NqcE9vc3FNQ1A1bXcwaVFv?=
 =?utf-8?B?S01xZXcrRW0yN05wWURCN2VZUzNUelphUnNBeFRDbTB0L3dtWXNsOWxucVpB?=
 =?utf-8?Q?Iifhoy6ETp8DXbTvCG91NlAFK?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc44806-1ac8-4d87-c546-08dcc1895cd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2024 02:31:29.1427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sxrAUR4uegcBCQkq+I+/Uk21z4aPvIxZb25AgCAHXwWNNMVKGUb9aTe027L+AM2F4bayp+pA2eCC13L8GI7i8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6226
X-OriginatorOrg: intel.com

DQpUb3BpY3MgbWF5IGluY2x1ZGUgYnV0IGFyZSBub3QgbGltaXRlZCB0byB1cHN0cmVhbS9kb3du
c3RyZWFtIHByb2plY3QgDQpwbGFucywgc3RhdHVzIHVwZGF0ZXMsIGFuZCB0ZWNobmljYWwgZGlz
Y3Vzc2lvbnMuIEl0J3MgYW4gb3BlbiBvbmxpbmUgDQptZWV0aW5nIHRoYXQgYW55b25lIGNhbiBq
b2luIGFuZCBhc2sgcXVlc3Rpb25zLg0KDQpUaW1lOg0KV2VkbmVzZGF5LCBBdWcgMjEsIDIwMjQs
IFVUQyA3OjAwIEFNDQpQYXJpcywgRnJhbmNlIENFU1QgOTowMCBBTQ0KQ2hpbmEgQ1NUIDM6MDAg
UE0NCg0KSm9pbiBab29tIE1lZXRpbmcgDQpodHRwczovL2ludGVsLnpvb20udXMvai85MTI5NzI3
OTI2OT9wd2Q9V21kd1MwcERPRFJOTVM5dFFrNTRZMWR2YkZscVVUMDkNCk9yDQpodHRwczovL2lu
dGVsLnpvb20udXMvd2Mvam9pbi85MTI5NzI3OTI2OT93cGs9d2NwazUyYTlmOTZkOTg5ZTdlMjBi
NjI4YzJjMzZlNDhiNjhlDQoNCk1lZXRpbmcgSUQ6IDkxMiA5NzI3IDkyNjkNClBhc3Njb2RlOiAz
Njc1MjgNCg0KDQpSZWdhcmRzDQoNCkhvbmd6aGFuIENoZW4NCg==
