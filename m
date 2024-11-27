Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FDB3D551
	for <xenomai@lists.linux.dev>; Wed, 27 Nov 2024 02:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732675174; cv=fail; b=LYl4caWU1m/XL20VQZjW9dga0EWIwaQvFBWypVJuAUBZTFKeBUryvB/NgAWsbPlpFdY1B6Oafg4Ch//Olvl06Z6k/nl040MlXSQCD0TNBxJRDS5XToixUyG4aBQyBw35SPhCjm8Yo8gQKp7kI1Fwracx52wkZESD3onGCJk7Lpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732675174; c=relaxed/simple;
	bh=bV0eYXLS0WG2vhnkf2RoyFuD+4qdaLWD1fYIgglvJ6o=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GkF4/s6fhNPK8bkSUm/qo6kFdtn7FR+AreRZAT6z8TY2nb+rkY6jyaRp2atDijodtTWhdwb2BQ0IDFxdBN9Wtt5/RS8Cf9nbJv/CAUodcnhuFPjnHCI1RfzZpEorrJgM7DzoqDmK+7abQ2SXX7joyqZBE4EdTvuhlqTOMbZkIDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NviQHJAS; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NviQHJAS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732675173; x=1764211173;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=bV0eYXLS0WG2vhnkf2RoyFuD+4qdaLWD1fYIgglvJ6o=;
  b=NviQHJASi2sYqG3Di6V8zzIuWk8c0JnZCppCRsAjVIYclGlQBFxwsrnH
   Xzh6kXDLKYQF6oPPlHkEdAyOT/acwDOsWO5Y2XxhvVYf9Z2bLM79xYX7j
   TpfqQ86TdYCWwqsRkH7CT9gm23YCAA6/qUCdMfXCmuUd4M4xe/02bfF2u
   4k/s4TC8JEXQxLbpCE7jNvXHSTY4YBxu6gb+HlUIUSAsGmznCp1rvd/Wl
   0lthYbIiy+JANYRmp3f4Bo85URyKu8eI+ChOXVKIwHMoff6/6JfekoMKE
   aQutHXM3zzG2Hp2t2LI8STVEwWZBvCiXQibP/rAbdn4qWE/M2Wm06me5c
   w==;
X-CSE-ConnectionGUID: uBZRWVzRSkKWMeLFAL+IHA==
X-CSE-MsgGUID: xMUa8F9xSFapt35FhumJSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="50390660"
X-IronPort-AV: E=Sophos;i="6.12,188,1728975600"; 
   d="scan'208";a="50390660"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 18:39:32 -0800
X-CSE-ConnectionGUID: BteGI+DDR62uBwAwPwnoqA==
X-CSE-MsgGUID: Kk0R2K7WRUK99bk9AlPM8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="96851542"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Nov 2024 18:39:32 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 26 Nov 2024 18:39:31 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 26 Nov 2024 18:39:31 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 26 Nov 2024 18:39:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y1QFG8UU2yD7IulKRKSGCMAZjFU/7rfBILvEZjKS3uvGFdtvY+0eD4ap+4ihUHO/wYG/tFVHEmRmrHdEaju/uJgql5+a0MNqb5BeSxpHaH+u/xRGHlZp+eOk7Lr88XGd2oWY0FThzgbr97wSwH3fYbmT+VlzO3kiKtvuhqYhBDBxGH8LYKUTAvkgks7lomxKh3L9//t7Z+IfP3wZFmO7/zkKJobDm7t6iPNLi2py2PdJJ5k3qsuO4TPcKX1qIhhk2zmZ/tIc8SYbCpe0hAd6e6D2BZC3WUsr5OU0Zkq5rWhE3EAlunSsY0bhTNet4MLDEVA1xZGlQ6uMkm0UiahkIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bV0eYXLS0WG2vhnkf2RoyFuD+4qdaLWD1fYIgglvJ6o=;
 b=g9rS1JPkNDr9AOpgRZl3wPNmIe0q4IyhtzbZlYqZI/O6ZFitA1nPQjYLonlS1atT6QMkm2vH+QwGxIpmt3YdkGCwEdAGVmXk1fizSkKoqZVikmtUyTk39yM8v1RALivWGJlvmwI01Zssza6UBpWYqRZqJA9NlQY1i0RIRl+7awmEgeXzQMd9KPebwTDkVHvvlYBG0r7TVKafL15aBZzGdIXGWvwuqp/qSMZk1h6KCYeX0+X+rX+u+QGVR6w98OAgLDiTqI8pKvJ1I8BpPq+PzZDKmVNwpCBkH3zurcMkkJX8PTGW+moSbkQfpAsXmcHcFhiBW5GOTWsZ/sXAwbaRLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by SA2PR11MB5164.namprd11.prod.outlook.com (2603:10b6:806:f9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Wed, 27 Nov
 2024 02:39:27 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d%4]) with mapi id 15.20.8182.019; Wed, 27 Nov 2024
 02:39:27 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Xenomai community call on Wednesday,  Nov 27, 2024, UTC 7:30 AM
Thread-Topic: Xenomai community call on Wednesday,  Nov 27, 2024, UTC 7:30 AM
Thread-Index: AQHbQHWUmDNJ3CSxWkuqesCEtdUscg==
Date: Wed, 27 Nov 2024 02:39:27 +0000
Message-ID: <PH7PR11MB74993347DB8F72364025EFEBF2282@PH7PR11MB7499.namprd11.prod.outlook.com>
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
In-Reply-To: <PH7PR11MB7499E32BB1968236810DF6B3F25A2@PH7PR11MB7499.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|SA2PR11MB5164:EE_
x-ms-office365-filtering-correlation-id: c12da932-ad3c-46b2-cd0c-08dd0e8cb687
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?M2Uvc2RVL2VpSUVUcDBvSnMrWmF0Z1hIOG9pKzlRa0NabzY1dlpaMXhwOHpr?=
 =?utf-8?B?TDNqT0cwRGt0ditBc0E0UEdodG9NcVY2K0dkL0RpMWxMWVlhOTA3Y1lNaWdX?=
 =?utf-8?B?YldrSG1BOU1GTVUwWU4vQjdWUUZxaUdDbkk2aEFlMU5jb3Q5VlR5ZXVaTm1s?=
 =?utf-8?B?QnEwbjJsMmgrR0tnSWIxWjRjaXU5SEZrMzMvQmxRWVdpL0dWenp2d1Q1MWNn?=
 =?utf-8?B?STV4bDVsbTkxSmJuV1MzS2JYL2MzdWJvbTBvL1ZlRzBFM2sxUy92Ym02QXVy?=
 =?utf-8?B?RXhIUFNtWWQ4ZkFlY3hoOVVLN2xYRUdXMXlpdFZQaUxxMVAvRFlsUENNc1hl?=
 =?utf-8?B?VjhiSk9acUJ0RjRJd25yM25VemlmUVAvMmU4L0xMK0hqcUk3S1dWTTlCQWhJ?=
 =?utf-8?B?ZXBRMFM4N3d1QlFGaU5ZdzRndmYyUG5qZTFjcHFWWjlXRFZCMWdJTFdMNDdm?=
 =?utf-8?B?eTBPN2pHN1NtMTNnUVZrM1lZMzh6bUVsdXlXQ0wvUmFUQUJZa1Q5NWM5V3Az?=
 =?utf-8?B?eHRyc1hUbjZXSjY0Qi9wYUlmQ0FlSTg1Z25abjZadXMwS29YU1JjM0tCcE9I?=
 =?utf-8?B?MXgzMU1ibWFSR1A5UysxR3A1ekhqOW1vYmhzeE9ab0xSQTJVbzB1RTFtR0kx?=
 =?utf-8?B?eFRUb2puN3pLT2ZEVTVzc2RSQ3JXOFJFWkhoRlhxV01ML0NjaUE0YUdEckha?=
 =?utf-8?B?bnAzUHJIS1pLenBVQUk2aG5tdEZtQU1GYmp5THBPMGRLamd1aDJiZ0dZSitV?=
 =?utf-8?B?YmFJSDl0T1hoNUNiUm5mWWpGN3M4dU5wcThsTVlOZDA1eGNBMGlJWmUyUGU1?=
 =?utf-8?B?c000bm1OOEQrc0JaYitRQTVKMkluRDVtRk40RC9qUTBoa0xTSkYydmxudXZy?=
 =?utf-8?B?Ukh5aW96cExkMmFrVUR6eTlmb0t1dGt2NFE3RlJJVjZHUm5KdEJUQk9JVTla?=
 =?utf-8?B?YnRaMW1rcE10SlVEYzdycWtEM3BNaTZnc29zU2ViTHd2M0FaNUtualp3bVht?=
 =?utf-8?B?cHkxaTFBTXpiVHFQS0JvZmIxT3VZRlV1T0ZzSFN5ZGliTk1sNTJYdFhVRnFi?=
 =?utf-8?B?d0krNzYrMFVTbDRHUnhUQWFPcE4zdzQ3REhsR1RZTDh0VHNzK0tjOFJBejBv?=
 =?utf-8?B?dTdReHRsVFVnVFFNNXNybkNGLzdlMXdBenBRanZUa09JdkFPY1Q1RmxvVGlp?=
 =?utf-8?B?MFhrNkUzTFg5Y0VSZkxvdU55Uk5jb0RyTVJxZG1uSk9vZE9FcWVZMTFyaFVs?=
 =?utf-8?B?aGZaQTdidk91K0hzUDN0OEIrVk8yMWQ5SGdxdWhxdTVRTDNkR25TeTRCVkhN?=
 =?utf-8?B?bWxya1hrck4wMERIZGYvMWFLQkRuK3hyQzY0UExheEdzT3gwVWFLRXh1dnpj?=
 =?utf-8?B?QkRmNzZkNnU3M2NldlVydUV6NlZBVlZmbGVXNzFIbzJITHpZVkdadHdPY2lh?=
 =?utf-8?B?Y0NpNkRCbW9YUEpiQWswNDFKTzArS2VXKzN5dVFLN2N1S2N0OC9pYVFSb2Zn?=
 =?utf-8?B?d0hlUUtySlpGYjA0UXhtTk9xWU1TOVRkWVkrdGcybHVtNm1HREpLZjdCbDJy?=
 =?utf-8?B?VzFseThubDN0cHRmOUR1YVA3N3FBd3NabXd5bStzakJyVS9ZeXRWQlYwUFQv?=
 =?utf-8?B?OERWQmJTcU5hUTlhUXFwRnJ3RkwwU3BkWU1YZkZlL2NhNjJibUhjdjIyVU0w?=
 =?utf-8?B?bmk0OEl1aWZONXAyWXNnNkx5ODMxSjlTaFE2QS9wV0dVS3J6dUJaSHY4T2J1?=
 =?utf-8?B?bEp1ZzY4dVpzQUVHVzN2R1grKzVXSHZ1YWhwbWVhVmxRcnc3WVMva05XVWpH?=
 =?utf-8?Q?nKbO3Oi6RDOnOo5WnPLTVmyqNgpPi/h74hbfA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RzcxaVUrK0czOHF4YkpWdk53VGo2MFFmd0dIblpoWk9mdjJud0ZPdExKcXVI?=
 =?utf-8?B?WTZYL0ZqZk1qMXdqUkRHY2NyQmhGUEF6MmRLNDV4NnluZkdaUVBzWDU5UDNE?=
 =?utf-8?B?TkZ5R3lsRzlNSGI1anBwU0lBTXpMQjlFM3pWVWtFbmxuTzZIaFpzSHR1enBH?=
 =?utf-8?B?YTk1SDQ5TjFhZmRsOGpaNDRrRzY1aXF4Z3hMQ0JHRXFjeFNzNUpWaUJ5ZmZD?=
 =?utf-8?B?MjA1UkdTMlY1VllwZnBSWldjWXMxU0FxSXRqRENXczQzZFA4RXVRN1Uxb3BX?=
 =?utf-8?B?anpRcGJYRlpQTm9iLzZaS0gyMDZJeXl4RktSbGNjN25VaW1NeTlkaENQSXF1?=
 =?utf-8?B?Yk1rby9ZZHRaWk9wYUs0eXB1RzRqZU5INXZEWmlBZXdxVnhVT0lnNjlGTk5P?=
 =?utf-8?B?UDBMM1F5VVBiVVd4SlFmV2xOZUlKdXFHSVp5UUx5OU1FandzYjQ1bW5YYURl?=
 =?utf-8?B?YlNIeXAyM2JXeURWL2g0cHZzdzhxbmFIRW5aTHdONFRUcDFoUFdpTTdPcm1U?=
 =?utf-8?B?Q1Y5ZnF5UzVTc3RKMVlaa3M4UVZBRDJjYjBINm16TG8yT3h5d2xaZ2x3TXp3?=
 =?utf-8?B?VnBQQTA3VDI2SWpVMzUzaFV2WmdRSGcrencvNnM0VDRPbEV6S2dyMFg3Y2xD?=
 =?utf-8?B?bFdtUFRhNHdSLy9uSzhIald5TmRrWldUNWQrSmVMczhXSTZYWWM4TEdKVEdv?=
 =?utf-8?B?ZnprNnVDb25MbVdyTkRlV09uMExRendyZ1hja2FKSVJqeDhJVE5oOGJqZm9M?=
 =?utf-8?B?SzZkalo5cmlmM2J6RDZ5T1dGVVg1dndBdEZ1QzhLNk5ia0FhMVpyNlFNamRC?=
 =?utf-8?B?bGtQb1JtemdpQWJsUGxEQVJCQkJOYnZDWHVMWEhkTzVPeDdiSEJGT2tEaXJs?=
 =?utf-8?B?QktYalQreTk0b0FQbDdrSnlCWXhTeGpsOGRHRHRIOEkyWE5XRmJrOXhHNVVO?=
 =?utf-8?B?S3pReTR0Q3FFVkh5ajlIbGhvQit2clN6cHZMY1Q1cGVSeWRpL2hLRmx1K1U2?=
 =?utf-8?B?bFpxQ3VRUENobE41RkxRUGd3ZEI1M0c2MEkyRzU4aEkzenVLRTFkNkNpN1pa?=
 =?utf-8?B?RXVKU3RlSytCMnV3UVQ2bW1Za3FmUTBVZUpZdXRkNnVoNVNaMVR5Vm1qQzFh?=
 =?utf-8?B?czcrdm5sNFpnT0kwd09kMUFGLzlVa0pHY1lTRVZWbXVqUndodlhpNnFxYkpx?=
 =?utf-8?B?MnlIZUJQdisyaFA1UUR3SFU5VjAvZDJVZ25pWHdWclltZTBXMWNPcUNyV1hP?=
 =?utf-8?B?OURqSHY4Y1JpUTlJd1BOK2gvdFZqS05RY0FuT0lxbDg0SndVQ09FTW02TDUx?=
 =?utf-8?B?eTB6b3NYTVlrWTZsMUczS0FjZXFxdEhyQkdHRld5RldGcFlEeXNjY0pPaXdt?=
 =?utf-8?B?Q3hVZnBHWkZkSERDVjZWcXhQSmJFUUpoWFJZdlNYdWVuL1dmQ3pPa2sycVNz?=
 =?utf-8?B?TWdlTGJHVWVKMU83Nzlab1l0YmwvN1ByWk1jN3Y5ZjZZTGxFc24zZ3A4TTFX?=
 =?utf-8?B?MmJuQUhYSHFMcUxYTzdvUThRVHRSUmNvbjZTYWIrdmdHZUY4UmRxaFc5RlZi?=
 =?utf-8?B?V0UzWXVPRkhhaUQ3Tlh0UTh6OTd6QjArdFJnN1ZVdFptTVpta0JVTjlDYWNi?=
 =?utf-8?B?djFlT0d1cFdzclYwWjBaOHRmaWF3NFdaRWkwWHBpN3lEaEJOY3djeEVOQXcx?=
 =?utf-8?B?UzNDQm1PaTF5OTFBdjUxcE5jb3JFVFcvZUZFNWJQVWNVdzU5S2x2c3lzQUFz?=
 =?utf-8?B?NUZhcEJXczdvMG5LKzdEbDhNRFJIYUZsZ3diVXA1RlVWL2RicTBXa2ZBT0xh?=
 =?utf-8?B?SENvV3pWOEdiL3hINlcwNUlWbUpKVHBDazVIV2wyeXRyMkFUM1Y3VWxYTysw?=
 =?utf-8?B?ZUsrZTFwcDB1TTZtYXhXbXF1STNzbzJDelAxRzJ2QnVDaE53cSttWWhQRUcx?=
 =?utf-8?B?TTRqSnV2ck9pWkRIbzZQd0pZa1ZlczVVbjdlMXB1OURwcFN5OXFlUkU1a3hn?=
 =?utf-8?B?c3ArVGlUQ01KOElyYnhpaWdnOFdiVmFOOEhHUFBuMzIwTytlUVVpN1E1UVZs?=
 =?utf-8?B?UE40VGN2blo5WkpSWk8wWHNtRlNWcTlCN0JnK2oxK0RtVkF5SHRQT3puT2ZK?=
 =?utf-8?Q?M17Iy4tRgibxMjZ4UiiVdD86p?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c12da932-ad3c-46b2-cd0c-08dd0e8cb687
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2024 02:39:27.6958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nkBKawROiit5XYBFs8vZX6MeLD6O8GwTFp9vq/MPph/XgC8Mfix2ZvCOCp3GI2UX6XJdc7/Y5r6uzBe7KzGijg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5164
X-OriginatorOrg: intel.com

VG9waWNzIG1heSBpbmNsdWRlIGJ1dCBhcmUgbm90IGxpbWl0ZWQgdG8gdXBzdHJlYW0vZG93bnN0
cmVhbSBwcm9qZWN0IA0KcGxhbnMsIHN0YXR1cyB1cGRhdGVzLCBhbmQgdGVjaG5pY2FsIGRpc2N1
c3Npb25zLiBJdCdzIGFuIG9wZW4gb25saW5lIA0KbWVldGluZyB0aGF0IGFueW9uZSBjYW4gam9p
biBhbmQgYXNrIHF1ZXN0aW9ucy4NCg0KVGltZToNCldlZG5lc2RheSwgTm92IDI3LCAyMDI0LCBV
VEMgNzozMCBBTQ0KUGFyaXMsIEZyYW5jZSBDRVNUIDg6MzAgQU0NCkNoaW5hIENTVCAzOjMwIFBN
DQoNCkpvaW4gWm9vbSBNZWV0aW5nIA0KaHR0cHM6Ly9pbnRlbC56b29tLnVzL2ovOTEyOTcyNzky
Njk/cHdkPVdtZHdTMHBET0RSTk1TOXRRazU0WTFkdmJGbHFVVDA5DQpPcg0KaHR0cHM6Ly9pbnRl
bC56b29tLnVzL3djL2pvaW4vOTEyOTcyNzkyNjk/d3BrPXdjcGs1MmE5Zjk2ZDk4OWU3ZTIwYjYy
OGMyYzM2ZTQ4YjY4ZQ0KDQpNZWV0aW5nIElEOiA5MTIgOTcyNyA5MjY5DQpQYXNzY29kZTogMzY3
NTI4DQoNCg0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQo=
