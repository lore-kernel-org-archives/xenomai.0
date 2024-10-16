Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80D415ADA6
	for <xenomai@lists.linux.dev>; Wed, 16 Oct 2024 02:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729045351; cv=fail; b=mDR8zexA8vGV67oWwvfNjTohRqlJfYhp3bqKiaAvHzbFViX107rN5nNnIzo00twbhU4y1BdIKecODMuMd4Do60rB6AxbplVZX7qLwRpQlQS82191tvy816yXpB9TPmtnR9GJxrLkJF/bDxLBpC2tQoVsBI87D56A69Vyz0F7Exk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729045351; c=relaxed/simple;
	bh=ikbsCx2RMXboGwofLV8Wcgxij+tC6KNb8P2wBT7RALw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TxMlOkHHPkeodfNv8Edl6COv4he3eQnZfsCk1OlqktqaBzo6hJMrhNttpKGcaZHD03jf4u1pr/MLzKmVrMRZHgomEbtwLlfawKKkATzU3TzW9B+x0zAWZpD705eoC6AzwM+ApdavkuFzQqP8h1iUcUaDZ7tu3nRaaIx6Iz0eY8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N2gHO9S0; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N2gHO9S0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729045350; x=1760581350;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=ikbsCx2RMXboGwofLV8Wcgxij+tC6KNb8P2wBT7RALw=;
  b=N2gHO9S0gpiD3lIGpufCVfsh7SZw/GFk9nppjgAGO013tgXIfoRpPQQI
   4/pgUDBnb0UAH9oVLQNNxcVW+NeX9KN51r9B/9SbLJT/1YaQiKMau8hFl
   eswSBKShqc/D+0e3hRW1ThMBQl6NJlQfay/8OhKDpRC7Mao7N4LVMEqjh
   Q7uKjixVVfboFX7FE/gheF25yeYo2jmU/+5XwskXS6jDZh02+r0U6Iylv
   ot0sUyPWhBUA3fmy8ayv0BiHo34KcDQc+YHXoNhVGTMi07EotqO3xhpyy
   iOjeih/Th5h+EP7zwgmcroabOOJORqC1BqWF943e6GoHasL12/G0jTFGX
   g==;
X-CSE-ConnectionGUID: xSQ++wY3T0iTLHIJMTEmpg==
X-CSE-MsgGUID: bJKGZ5YBTaKDHegZHm5tJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28261830"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28261830"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 19:22:30 -0700
X-CSE-ConnectionGUID: wCBIomq/RB2/Gk/SX4BKBg==
X-CSE-MsgGUID: VihcqXJxQYOOrVgMjpbQtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="108824588"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 19:22:29 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 19:22:28 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 19:22:28 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 19:22:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZV+Wpa60psrnDnqa3pVjzYa6VuOZ7ZHwNQQ3WPTYZ8CUo4/XSX2q0sxhh3OnaZxWUSFEANzrcJGLkBvrAjvvn2gcOrXqhpRmL/TVyzLIFAYI7Twk1/hOjs/Hlx++tpZOozMHmjZy26nW6T5jWykA3zn6K87BODnLRWMYm//6kOpZFbtsdPSt5P08nJxR2Pk2jUDV/tn1GqVEMOy4HrN4AuMuEfKwMFozt03cdNYDPFjC9ieir8z9OtBQskdteEkn3RxcBg/Z91pmbsXwHIxfFrOe1DGYdN/UsbEKtOsrAdpDwKRiZ/4Ff6EMP+LITCxypR0YVabTsyR3q2ZTT/oxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikbsCx2RMXboGwofLV8Wcgxij+tC6KNb8P2wBT7RALw=;
 b=ZERgEL1nTUWZj4IGgHqmIbposIunlJL7mmrzGIqxVupNM2i6nU9JPDfvCrgoSScopdlRbGhORS37ddSrrwobNV5v5wx/UMaxFCT5C3Wi5cEe4lCjhUkNcc9CISb5jc9HXRVeFtsMLrNIiRdvJjp2p7P7zAVCzxvkfIAU1UN7nBltPTJk5tDgAaOWcXot4r7Ubal1kIr3YiYiE7NTMbBT4KDR/ZI27EDPOwePgJmDmH8fePO5/9Q1qyNOx7E1gh2ODF1AvcX5B9XLE7ncnO7b0lQaKczpTPaVdTyqmVn+UpuW2Gh4ip5mYg6REB7eDlkBJY33EiSMtITAzkv18GAzBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by CYYPR11MB8330.namprd11.prod.outlook.com (2603:10b6:930:b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Wed, 16 Oct
 2024 02:22:26 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 02:22:26 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday,  Oct 16, 2024, UTC
 7:00 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday,  Oct 16, 2024,
 UTC 7:00 AM
Thread-Index: AQHbH3I9fI7pfNfOm0muDcir9p8W8g==
Date: Wed, 16 Oct 2024 02:22:26 +0000
Message-ID: <PH7PR11MB7499E15D2AD5555818A6E5C4F2462@PH7PR11MB7499.namprd11.prod.outlook.com>
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
In-Reply-To: <PH7PR11MB7499BDD1032C1C09D4107EE7F29C2@PH7PR11MB7499.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|CYYPR11MB8330:EE_
x-ms-office365-filtering-correlation-id: 3a870987-5d0e-4468-2d5f-08dced896056
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eFVwVVFWRXZRTi9LTk5MZGp4eUo3TlAwYUdXQjExRDRiUHFMVzBHTjBVMkcx?=
 =?utf-8?B?a1RuWDZvTCsrMEJxVVkzZjc4YnNTUDRJMEdhZ1hYK0Y5Z0lwV3JXT1JCOE5V?=
 =?utf-8?B?NnF2aUlmWndKaXA0MDhnSXJBc1lsOHVQVzVEU2ZESzdmYkRRbTNUNlFEQXQ1?=
 =?utf-8?B?azJVUGw4NDYrMFpsdDRVMytWdGZBbVZtR1RYTmNhckVtaGxzVFQ0OHJDT0lZ?=
 =?utf-8?B?L0FVd0hMZnQ3clpkd1Q3MndOMlIyNWRlcTduc2lFYkhiZFh5RWd4ZVFOV2k3?=
 =?utf-8?B?TW80aWl6cm5kUHkzRkk5K003d2lONFFubWNHS0JmRmp1SkJoWm5ReG1RYkhT?=
 =?utf-8?B?SHdDU0JKWkFxTC9MaTU0VEkwOURPdHZSbTFhd0NnYUtITEtiYVRyNTlYQktz?=
 =?utf-8?B?a05hWDlMczVKWVJRUC8xaEExVnArUUlucFVSRFpEOFk1U3MybGNPT085OHBV?=
 =?utf-8?B?dVc0OExSUnYwU04zSW83ZzIxNFJhK3VsbWpRaHJraWxaci90aVZjaG91NGo3?=
 =?utf-8?B?Y1EyRmFHdDlXK3pENS9ROVUyRVdHRCtwcDJiVDdlZktUcGIwcG43bENZMjZl?=
 =?utf-8?B?RFM5U1ptaDFDbmtURm1aYVkwSlhVeGhUbllTSE05R09vMUZlUmg3dWZpQUNy?=
 =?utf-8?B?cmhwNTVLbmFMa2V2bjdGUVowdy9qVXBZUmpzaDZLSWh2UWpGa2dZZHV3Q1BX?=
 =?utf-8?B?V2x3L1RjVVV6NDBhNmp6RmRMRG1lM2IrS01icnpwMlVLbkJYQ3AvU0VqREFy?=
 =?utf-8?B?Q0NjTFpkeFZrNk9jWnlRTWxGUitoM3pUajRpeHptS3dKaWthaTc1b1U2czdM?=
 =?utf-8?B?aDhvRHVTckxFWDg5WHNXemdYeE55THBLQVpka1IrK0l3M1UwYXFHTXl0NVpv?=
 =?utf-8?B?SXJGZFdYRHhLYVQ4TGlWckpacWtzb3JKbXRBSnVLbVdqUWZWZUZyQnJ0aXNU?=
 =?utf-8?B?b0poK3A3SmViU2lxeGd6eUd2WXdUSFpGYVZETzh2cWpUUDBCZ1BoNENUV0w5?=
 =?utf-8?B?RFNTMkVCQjVCS1g4T3BWZXRvVlNBcWtJR3duSy9XR1ZFTFdDRm9CU3F3dDZy?=
 =?utf-8?B?Q2l2SE9ZM0JTSllqRWR0QmJpbkdlUnBmWEV0ZjNGdUhWamhBOEhkSytnWkhO?=
 =?utf-8?B?Mk5LbGp0WUhLRlUreEJQY0xpQ1hhaU05K1dxblN6UC9YTjlyY01rUUpHRHlG?=
 =?utf-8?B?SDI5STQwRVJwU1MxUkJ1TnYxSUZvbzNFNVRyZ3cyU3k3RHU3aEpLenYrVHo1?=
 =?utf-8?B?MDRpQ1FRTXJNQ1MrUTZObFdmQmREZFlWcDBZUWprQ1JnbjVTeWRJdFRaRW1Q?=
 =?utf-8?B?SHNYTHk1RVdSem1adkt6R3haOXltMjRhYnhDUjVpOXZRVU0vK1pMWHRESDhj?=
 =?utf-8?B?Y1JCRy81L0VOb3NZZ0NMV1dma056Mkp3eGVQU3ZIUnRBMjVZYVpneDdQTWRu?=
 =?utf-8?B?dzI0WW85eGpFU2dCdE9NblBVTU1za1pmWXdHdHJmRjJZVzMzYWVVOXM4Z21l?=
 =?utf-8?B?QTBXN2thZ3VPOC9MS205K1pYK1lyVkh0RFJoVmJJNUM0R3A0V2VXRU85ZFhH?=
 =?utf-8?B?VVo2djhUZFBucHBHcTcvSzBDL1ZFdU1VVDBoUkRWODE5ZzB2SXdmYmkvVFJP?=
 =?utf-8?B?aTg4OFlOQ1BOazMzelNrRlhJZnl5M09jWStDTCtlQy9kakRWbnNVYXptU1Q5?=
 =?utf-8?B?Vi81cEtHTC9pVVBGRHVRMDRNbEtHUFhERi9YL2JpMlA0cjVXR2J4UkE3RTZK?=
 =?utf-8?Q?gjnMdhCiCaCJm7j73M=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekl4d1JzUXlsdi9ILyt0RU1wZkJrVUwyOEV5REFGWVBwNnVxVnVUSUlqdTZN?=
 =?utf-8?B?MEc2eU15Ym9ERnZWZDRjUk15UXlzYjBDcTZLbnh2K05kOS9qVVN1QW1PTk4w?=
 =?utf-8?B?S1M5NmtHOE5OaUdLVTlZdjJWU0V3MXMwcE54S2l4MDFtbkY0bHZNbGJnUnFr?=
 =?utf-8?B?ZlFEMUN3bElpZmtpL2RsRGszdWFIRFBDYzE5aVAxdkRlWHl3VkZZTHpOR1c2?=
 =?utf-8?B?cUtoOWZGcVQycGZ3Y25ZZ2JRWkVDNWFheURxZk1kYnhEdkFwZXY3eXR1bGJr?=
 =?utf-8?B?WFNoK2VudFI0S0ZuMlYzUlFnbGtHRi9vWkhZRHR6K1VwUFZPWXlLZHR3WWpH?=
 =?utf-8?B?ME9KZUR1NUlYNUdrQStmazcxN1ZCcVpCZ2xudkxZMWxtL1lZTk44RVc4aVp3?=
 =?utf-8?B?dDkySHVzelh5T3JlU21XSXJQNDFyenhoZk00L0VPRW82bEg4MjBpVXc2Ung3?=
 =?utf-8?B?K1J4QUJueG85N0F6dHNISFJxVGdidTQ0Z0ErM3hmWXJCWXYxSVliQ0NXMmlH?=
 =?utf-8?B?b1ZxK2d1V1VJV3BXM3pLYVRDY3ZLVmtSY3FLcndOS21maldBUGdURmpLWnJU?=
 =?utf-8?B?VlBtdDBJWHQvaHBiYlFjTGQ5Vk5YKzlyemRXc3J6L3R3aTlBT2ZzRlhMSS9E?=
 =?utf-8?B?clkxMEdsZnMrVUU3M254NTVoRFh3YzUraUZTV3luVTZCMWRFbHkyRTI2M1Fl?=
 =?utf-8?B?a1lJZ21ETURKZHNxTWFkYWJMcmpJUERPQ0VQVDJQSnhycXY3L1hqQjJ4UnJ1?=
 =?utf-8?B?cDRrZi8zMG1saStFczBremRiWG1ZOGJ1YXhXMWlPNjRQdHRSQm1CRHp2S1Ax?=
 =?utf-8?B?eERKUVdBRWM1ZGFHU2l0VTFxVkYwWWZuRktJSG00UWV0dWt6WjBmYS84Q21Q?=
 =?utf-8?B?YkRYdjNQdk9zdlA5WEpYaHdRZzNwMitBckc1RkJOSDIwcTFPeW5vQ1dtbjZT?=
 =?utf-8?B?TFdSTmNFUGc0cDduaFVTcnR6RW11U2JKdC80Znp3anRFeEh2SnczSnk3cXVm?=
 =?utf-8?B?eE4rQ3pLa29xbjZ2b3Y2Q08rVTlVZkVTR1FjV01PeXQyNVdaTDN6VG9jM2M0?=
 =?utf-8?B?cTZFUEVLRVkyQjROWGJnZXlid3c2M1dPMjNuZSszaU1SRHJQMldYNGlFMm91?=
 =?utf-8?B?Sy9Sa1lNbWEvbEdsYzZ0bFk5aUxvZERBWXhSejIrcXE2UkdVR1R5NnZHL2hB?=
 =?utf-8?B?VTB1VEszclE0RHF1dGZCdm0zbmdEdURTOEFHSVluRXpTNmRkem40dWhWZ0dC?=
 =?utf-8?B?Qmt0YnlORmVsRTBiY0tIMFVoaGduSlpFaTN3VHlPLzc2OTdBcjVPeWNjU1lJ?=
 =?utf-8?B?bXZGWnFpUkF5TmZjYTF5bnZxS2FYQmJWV2hlaG51L0I3aXlhUmIrVXh4WHpy?=
 =?utf-8?B?WkFXOUhoQ0dPK3NsMjZOYU00WERzNmk3RkZVYks0NVd4d2N2QWU5eXo3R3NH?=
 =?utf-8?B?cWhoOFFIZHdsclJybUpYK1B5TTVHK3FkdWJwbmIyT1JyMWJic2F1dVdQRTFh?=
 =?utf-8?B?YUhYZ1RUWWV0RzlseVBDekZZWG11NTh3bFRjTk5QQW42czVEWTBSblZ5TnJv?=
 =?utf-8?B?MWhNdnBQcTNmbEZrdE1HZnA5MUhZL0txWmh5NzhOVUVJaW51SG8xUFFnNElH?=
 =?utf-8?B?eTJuRkxiNW5DeVloRzMxL3ZQTGRBaTIzejRValg3a0ZCL3FOdlZRM0JoeHU4?=
 =?utf-8?B?enppZmlHbmJvZkxOSlFYS2cxZ0RMQndlME5oN0J2N0VOVWh5Ni9TbExuejhE?=
 =?utf-8?B?QnVkYlpIdmZUT3p0dDMrQVlFUnExTWZoUlVVelVpY3lWSlpNWENDMHZwZlZv?=
 =?utf-8?B?RW1NdE5HYWZkQlZZdlgxT3ptU2lSUE9TYzlYQUxHVGFINjNxc3FMdWJ0NE90?=
 =?utf-8?B?dUJpeEt5bEpCNUs5Q29DR0xDeEpTWkdha3QyV3BQNzhYL2krcXNyejVVblJu?=
 =?utf-8?B?MkJhd0x5RGRpeUtYSUZ1SVA1ejhvcVJvZ1RVMnljMnVtNmVIdFZyQ3ZNMGRS?=
 =?utf-8?B?NzdpSTA3akx6OVFtWVAxQkxTaHhEZFlDaFlObzVLVjc4NUVlOFpKK0k0Nmo3?=
 =?utf-8?B?dG1nRmozb2JVSUs5QWFiZ2pFRHFtRTZ0bWxpaERFYkpNdGw2NFZ4VGhtR25X?=
 =?utf-8?Q?QIxwD4ExZufjHrCLwfahARRUt?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a870987-5d0e-4468-2d5f-08dced896056
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 02:22:26.2197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: afvQrSE5qVIqTfi402wikG7oKOsJ+lrrk4EKmb/2PigSIsLtJGTrcYvGQq1+nqUga3uwMwK2278GvlDuvztdwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8330
X-OriginatorOrg: intel.com

DQpUb3BpY3MgbWF5IGluY2x1ZGUgYnV0IGFyZSBub3QgbGltaXRlZCB0byB1cHN0cmVhbS9kb3du
c3RyZWFtIHByb2plY3QgDQpwbGFucywgc3RhdHVzIHVwZGF0ZXMsIGFuZCB0ZWNobmljYWwgZGlz
Y3Vzc2lvbnMuIEl0J3MgYW4gb3BlbiBvbmxpbmUgDQptZWV0aW5nIHRoYXQgYW55b25lIGNhbiBq
b2luIGFuZCBhc2sgcXVlc3Rpb25zLg0KDQpUaW1lOg0KV2VkbmVzZGF5LCBPY3QgMTYsIDIwMjQs
IFVUQyA3OjAwIEFNDQpQYXJpcywgRnJhbmNlIENFU1QgOTowMCBBTQ0KQ2hpbmEgQ1NUIDM6MDAg
UE0NCg0KSm9pbiBab29tIE1lZXRpbmcgDQpodHRwczovL2ludGVsLnpvb20udXMvai85MTI5NzI3
OTI2OT9wd2Q9V21kd1MwcERPRFJOTVM5dFFrNTRZMWR2YkZscVVUMDkNCk9yDQpodHRwczovL2lu
dGVsLnpvb20udXMvd2Mvam9pbi85MTI5NzI3OTI2OT93cGs9d2NwazUyYTlmOTZkOTg5ZTdlMjBi
NjI4YzJjMzZlNDhiNjhlDQoNCk1lZXRpbmcgSUQ6IDkxMiA5NzI3IDkyNjkNClBhc3Njb2RlOiAz
Njc1MjgNCg0KDQpSZWdhcmRzDQoNCkhvbmd6aGFuIENoZW4NCg==
