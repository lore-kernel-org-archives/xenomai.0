Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9A72594B3
	for <xenomai@lists.linux.dev>; Wed,  8 Jan 2025 04:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736310964; cv=fail; b=tfaA3lEoieEPpupKn8dxOUJakUl/jrFSuCrKBk0bRVh1COawcyw32Hjxi7lQPpnHYJmVlGzChhIIqJ/Ulk3N1Yy7ua+ZFuyrljQW6LC5YnRWXc2y8Df/dEwFmVNCy0wo/QG9LwVvK/KJlwNYh0zzlfUrINEv+/xEfim8B5ycYMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736310964; c=relaxed/simple;
	bh=AoEvyLVOoxcZHKVTozFA7X+nEvV4oK7DA3rhe6x84pk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C1BvxGnf2vAGwAklgkcEfgpVt9ni1l0KU4EqKlr8e7AIhb5AW61rZ7mD3hPPtBLg5oaMw49Zs9U0oHC4i30fn5QxZB5aJZbj8v7ry1+Ib2+OoC+D5vWTFHOK8U156BzppgWT+DWC6scIoqdVGPeb0M39cZ96Tl7XHxvgB+JjHgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hx/4DYRl; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hx/4DYRl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736310963; x=1767846963;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=AoEvyLVOoxcZHKVTozFA7X+nEvV4oK7DA3rhe6x84pk=;
  b=Hx/4DYRlq9HL2r+8VrjswuMauN20wvdjlQewkjrtqFL1eVwkxwNkSE1o
   d2Aei/kKSg0wR0Vsw+Enz51tl3Zv/E8HNjFTjLkCGgTXtOMnW7zEPGkJs
   dnd7gqkOImV9tX6zxW+9X8lsDwOaO8A8Qu7RowNke5y762wQm07EsMb1Z
   LHpvU2GM+bHh0Qv5tL4XJqXnyXflpUrCbtmYs8SeVO6UUajycH7QvccHv
   V90VL+OISCVK4pGxkrYxpTrY1l7j74GwqrkRSIRKEsIrKqPgAnHywThp3
   uj/jt7aQef9LadekW8BEfCcOznjNCp/6kgmYzpWkdeDnTm/l55PMttmx+
   Q==;
X-CSE-ConnectionGUID: pGWVeuF5SHWyfRfUYEi1Mw==
X-CSE-MsgGUID: tsVf/lX5QoWcZ6+IKqBOEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="47186412"
X-IronPort-AV: E=Sophos;i="6.12,297,1728975600"; 
   d="scan'208";a="47186412"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 20:36:01 -0800
X-CSE-ConnectionGUID: ScIf6zb2S9SJYnyIcnMAIw==
X-CSE-MsgGUID: mdVxtnsXRrieM7dl8OdQsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="140308867"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jan 2025 20:36:01 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 7 Jan 2025 20:36:01 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 7 Jan 2025 20:36:00 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 7 Jan 2025 20:36:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f3foG5hQhkvZUENZ/swsBi7yiOmu8OxTui71WlP7KS3xZTHToChePu1fwBsAL7brw5vQ7kxdoDh9Jzxr/5efJGk//1l0C70c1+58+x5NJogHdwlUcD8TRS4I3DuWiZsib/bMbULJGruUqwuV7hRpV2WQi1EY574lfQMSC6l5JwomTWHzaSS/tc3VxbjaJ90GEbyMH0J8EnaECpSsqqz9nuyZc3CWxL5W90J5EQTLWw2k2f+/bgiRah1pH2EieAG3jtjhnySLyoTdPqX/WZF7v3jSscgWWy0Sqw6usNYAM/+V5/sH6Ov2kbLuYMWgBATG1oWb/+Qfk1ifyrp8GIOcHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AoEvyLVOoxcZHKVTozFA7X+nEvV4oK7DA3rhe6x84pk=;
 b=r1dZvNWbRg4YJo9R2QH/45v+g8cSb+rfnXF0+EVMoCrP2SynlvdvvvoCcBQKFoZYKaAYfaPRjbAANHvjmAb+h28zLG7MZF7zt9u0T19FZagt9Y73wcMBulbbux7ocysQmSFXjFCBnucdAbaJT3j5TzY8kFRa6ual1iCFsCUDqyAxAdGP6c0+Yete280Kpe3gXAaUj9AnqNb+csKp9rwe0uP8uA0OpKWCan3zLtRmVc8jF93bVq3nNovXU0odKwGC2Ha28vwtcqw0G9SwGam4GnljpJQqKNcZ/bBt0+d+jMOHS7zNcyGuY+f3Ekr0oiSOvCebbYvY+8c1CVKNHpwYeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by DM6PR11MB4753.namprd11.prod.outlook.com (2603:10b6:5:2ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 04:35:52 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d%3]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 04:35:52 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "Auel, Kendall" <Kendall.Auel@3DSystems.Com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: RE: Output thread status to OOB serial port
Thread-Topic: Output thread status to OOB serial port
Thread-Index: AQHbYW2rGEJ2BdeuPUy+XTJgDgWksrMMRnJw
Date: Wed, 8 Jan 2025 04:35:52 +0000
Message-ID: <PH7PR11MB7499C353C96215449BE033B0F2122@PH7PR11MB7499.namprd11.prod.outlook.com>
References: <MW3PR12MB446043BCF431010AC84E4ED1C2122@MW3PR12MB4460.namprd12.prod.outlook.com>
In-Reply-To: <MW3PR12MB446043BCF431010AC84E4ED1C2122@MW3PR12MB4460.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|DM6PR11MB4753:EE_
x-ms-office365-filtering-correlation-id: 5c463f1d-792d-472c-68bc-08dd2f9def4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dlVYV0w2UXd5ZDdTUDJyMzU1M1lIYm9PeUg1RGFkT1Y0YXJRYmloN3JHOE9s?=
 =?utf-8?B?eG5STWhLWkxOc29uQ2FnOVJlVHF1dWZLemtXR2M1dGxFOG4zdGtCZExBZ251?=
 =?utf-8?B?Y284YmFPclkySmF6akorcFE0TDRUUzA2VkYrT0x5NEJtWU5FY3k2TXFhLzR3?=
 =?utf-8?B?TzMrb0hscGRhd291SnNvNm5wMkxad0hmanlHbDk2L3RKTEI3UWEzeXoycHM1?=
 =?utf-8?B?UVZEUy9TMjBVTGRoSStQNFRhWFVyemhEaWlnZmVqUk9Pbk9Pc0tkUEIvZGdh?=
 =?utf-8?B?bktseGlnY3R2S0VyZ1dPUzZPM3VmYnpvdHRQdFoydHljTW14bGNYT2krdVdQ?=
 =?utf-8?B?aXdmWm9mVnNxbWljWUZURE00MEdRN0tGZGdlWVh1QW15alU2ZnhGUmt3aTlS?=
 =?utf-8?B?T2pVTnJzSDcxMmppV3A2enJOWUt2cURFeTZxT3dRdnR6elVRMUdqd29jN1Y3?=
 =?utf-8?B?UFNxNEFtRTFxbUVJRWRGaDdFdVNCWm54S2V0NDlrTW01cVZpdXlSUjhYcUFm?=
 =?utf-8?B?MjVjZUNEK3RLT2pESFZuSnkyK1RlRXhCYURhazJjWGc0a3MvKzA1VHhKNkRI?=
 =?utf-8?B?QkkrclBRcjFtdHF4aS9jSllLSXBZNjF4TUp5WENrb1JRMGlESURjODROUEpD?=
 =?utf-8?B?OElJQmNoWGh2QTBVNzN2ZUdPZzZxd0hjUC9DVDVzRU5lTjNlMVJpdDhXNHRw?=
 =?utf-8?B?NHRiTUxYYS81M0R5ckVERk5uYlpnaTNMd0k5L1BZYlpOZGlTVExtOHNkWlpL?=
 =?utf-8?B?TWZVVHBDcFN0S1BFTEh1Q0xNeFM0YXl2QXVQODgxVk9Ceis5NVkrSkFLS05l?=
 =?utf-8?B?TzNZUkk0M3VGUW1keTFTZEFBbTFGSHQ2WTE2cVBlVnMyQXVIQVppSGJ1T3RL?=
 =?utf-8?B?cDJoZTMvYTRoQ3gyQVZkczJHOGpaNHFnOEozSllrOWJHcWRQQmdZeW4wUFFk?=
 =?utf-8?B?bnZucU03SDNveExPOFFzOTJmOUxGVjc5VXNsVnBYODduWTJVTmpLR3ZRamhW?=
 =?utf-8?B?OU01L3J3Y29rTTU1RVVtUENVRVBEQm51elpvTkllWTRQSERyelp4SzdnQXR4?=
 =?utf-8?B?c05CUnN1UVI1M1ZUUVRmanpmNnZTekdUOGM4TlBlbnJpS0FuY0dzdndUZXIz?=
 =?utf-8?B?TmVOb2FzR011cHF5aWxMb2kvNnhuRnRKQS94YVNITzhpSGJzMjQ0eXZvVmY4?=
 =?utf-8?B?WEE0OTU0Y1Q0Zk9DY3A0Mmw5SjhUdkoyS0FRSTMrWFl0OWJKSFZBTkNGZERo?=
 =?utf-8?B?TzNSVStETEtIQkdwQlpqLzhiL3VvWHVHMnBPMjRJcFhCamthc2FMZ0YwOHRL?=
 =?utf-8?B?eHpWUU1XOStTd2FnMVZPdEQ2VTNsT3hBZkNNRmlndXdZSVFLaXU3RGtDUXhS?=
 =?utf-8?B?ZkNiSHVKeU5XcUxMN0hqTzNDT0JVd3Z0N09xUUFmUDV4czd0c3ZMRnV4Q3Fl?=
 =?utf-8?B?RzBOaHQwYjVSWVpDa3RpODh4YnBIWVB6YlZMNEdWbUJYbko3QitwV2dkenBq?=
 =?utf-8?B?SWJxRWt0V21YQmJ6WGp2dmdSaXNZeU10bkRrUkJMSXNXN3JHaFN2aE1xdVFE?=
 =?utf-8?B?Lys5eHY5T0QwMTlKcTBHb2NUYXQ3QmIxSWlDQnUwUFg3bjFkeG91YWkyODM1?=
 =?utf-8?B?U0gyMHNia3AybS84K2tvMFYwT3hoM2ljK1FTVnVoclVRQ2FxQ3hNTlU1Rkhj?=
 =?utf-8?B?dG5aS0NlMG5VYjYxdmdGekorR2tMZHBicVFsYk1zM05kWjBRL2JLNnExN1VF?=
 =?utf-8?B?RkxsUFExMVZzWS9aNHpXVFJnUnlqaTVVVmZuZUxmczNBS2E1VmFBdWVSaElI?=
 =?utf-8?B?RWpLNm5Vb0tKN3lML21QVUptZGdManhobnJWRE1Rb3BhTGs0V3ZFUTdTY1JP?=
 =?utf-8?B?VHRmS2ZEa0M1anhMY1VoNnR0L0h5blZtQ1l4cmprOTJQMVFxMldHb0IwQkVR?=
 =?utf-8?Q?ZdAALBKiOHGYCbgl0BnxZAFG7xF2ditx?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d28yZW5nZEdOZVNDSEFnVkFOVE5Nb0ZvbzlNcEJCc1FzL1lZY1RPNUJpQTVY?=
 =?utf-8?B?ZzNhMU1wMUVjK21tN0QvTzRISXowanJSUHpiRVpwQjVzK0s0M3JKRENmbUl6?=
 =?utf-8?B?QkdWVi9XU0Z0amJqT2RQd3RDTDZJcm5QbUdacVhvNlFYbzJWYUp3QU5UeFVr?=
 =?utf-8?B?UUlUUzZCc005Rjc2b0orVEtoNmxtVGgybWFhdnpvd29SS0RDVlN6Wk1jNlA4?=
 =?utf-8?B?c3BOd2xTRUJLOSthQlZxRmxRL3M0T3QxTTBDUmhINlVkZS9yYWduSjFleVJa?=
 =?utf-8?B?b3dKQ3Q3allmTkVvOFRnS1hSa1dTeVdrMEFqalhaL0psSmxYNlFMcXA0V1ZN?=
 =?utf-8?B?cks2VEhxQWdZY1IybUxKNUZvbUZQdkU2cWtHMG5sOG9HMS9ZMGlGaUI0ZzF0?=
 =?utf-8?B?NTRQY0pQNVJXT09uK0xWODVtQm5YdytjQmZHZlFFRUJrTmRjdHJRWVYweGsy?=
 =?utf-8?B?NXB6WHJXYnJDdEtORGNLMDBGNk1LWlBzRXNIYUk1T1BrZHZRc2h6N1hVYnB6?=
 =?utf-8?B?V3R5d0RlUS9kdVpDNjdiYXFRTWgxYVB1RTNIZVl6a3RZTWNpaDkyYkJJdVRp?=
 =?utf-8?B?aC9semtWTGpKVDdnSEk5eDJ5NEF3Qnc5bUhTVHNLeHczODF6SnR6YVRhc0lP?=
 =?utf-8?B?eWFCejZxcW5jS1hFc1pONCt4c0lKaks3aDZzN09TbjBacHIvbTNjblA2SytF?=
 =?utf-8?B?SXp4SDgrU1hSaVBGZVY5aFkrVFBqZDRsbkFEU0Z4Rlk0cy9HeFZ5RXh2M1NI?=
 =?utf-8?B?bHYvdWF2RXY1VHZDcU1kZUxWRWMxZ21sZFpGNmY4OFYwbTh2NXhvdHFZKzk2?=
 =?utf-8?B?bzNCU3J2UDBBZlA5R2Z0UHhnVEcrdkIzSC9UZHdxZnlqbndHUW5LU1k2VURh?=
 =?utf-8?B?NVZBazkxTkRVQ3Nhcm9IM252WDIxMERUbzN4WlhEcE5IeFpwVzRGZm1CdDhi?=
 =?utf-8?B?MTRiSjgzSE9yVmx6ZWZsQ3JIbDJ0WkxJSmtFYkRCSm1ReXRjSU9nUkNqUUND?=
 =?utf-8?B?MHJBZFlKMFVXU0tSY0EwMVlWTDFYVTdLeWg2VlUwQmhDZUExbVcrV0RDRFNw?=
 =?utf-8?B?QzBieXViZ1hjdjJYQ1BMVFk4SDJQNEVmRmpNRkdwa1IzZis0dUpoWStTa3cx?=
 =?utf-8?B?TGpGL3NpV2g2S0pQMFJaZGhla3ZoQ1I2Zi9pZ3B3anhUVXRycEMzVzZxZjBm?=
 =?utf-8?B?WjRLMHpzT2ZsRUhBK1FFbXNEYUhrZy9nakxqRlV1QktURE9HYW5NckV5SzFD?=
 =?utf-8?B?U0hPN0xna3dhWUN6SExuQVZoUFJoR0t3UXdWelY3NEljN0cvUlBuQkF1aUFi?=
 =?utf-8?B?MUR3V1dQKzFvT0xJaW9qUGJCbEM0bjJYakJDS2pDZkQ3TldjaStPUzZ2NU5G?=
 =?utf-8?B?UjQ1SXZwOHllcVBGVDZ6MTBZT1pEZmpoNFE1TUtxQi9MMzJKNjFZTGRCY2Fq?=
 =?utf-8?B?K3Jxck02bTJLb1NQNzlIYTNZUDFZYzF0MUJrdVUvUXJHN0EwTFBRSCtQVGxC?=
 =?utf-8?B?V2t3QUZrcGgzZnBYZ1NXSmYxTmNIM3hicTJod2pud0lMSWd6dWU1U1M3eWEw?=
 =?utf-8?B?c2REWFFJUUhXQmJCdjV4VTMyRWFzT01KbWd5MEVwS1IxQ0VvR2diMDVaKzhX?=
 =?utf-8?B?R3RZUTdIeHJoVXVyRVNYVFUxRHhKZHppLy9IMDZuQ05jZlNIL0VWbmlZZjNy?=
 =?utf-8?B?QzV2YXVvTTUzWTVOUnZseVE4SUJaQjV6M2p3YzlaMEJtbDRkWE5ET0YrcThT?=
 =?utf-8?B?M2pZc3lJRFdwS0RUODlPanJvNjJIblNmNWQ0dmpJa2U2eHZtZGFtblowb2RC?=
 =?utf-8?B?ejliZVc0Y0ZMcVZHL3hLTC9Ba1FvaVJSYWdIbXNqeXN3b0d4SE9HdHhRb0dz?=
 =?utf-8?B?RTR4NDM0VWt5enJjdE84M1dteDNYeW4yQUpCK3l4QXUvTGpkNGtYMHV2TkNV?=
 =?utf-8?B?c3NrZFdjOC93YTNQeTZMSHNrcVUzejJ4c3lCMCt2bC85aExlR090alN6RnJz?=
 =?utf-8?B?VjZ2cG4zMFpOaDQzNDJZZ1d6WFR1NmVDMHY4amZCSE5aZzNmOE4xWUh5YVlw?=
 =?utf-8?B?TEJ2WnAwTVJxVTV1T0o2WGVabVI3SlMxTDhNWFlYMFdyN3grbEFURHlmRXRr?=
 =?utf-8?Q?yEhQPa5q5FP6xStz1DB8geNLE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c463f1d-792d-472c-68bc-08dd2f9def4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2025 04:35:52.7447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7WFybY4YFtu2CVh3wU2JA9SgsB/KbFObltCk3OJ730aRuY3zu7s4u1XtBaPs+Y2WGT/MBMPmmNMh22exbe35yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4753
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEF1ZWwsIEtlbmRhbGwgPEtl
bmRhbGwuQXVlbEAzRFN5c3RlbXMuQ29tPg0KPlNlbnQ6IFdlZG5lc2RheSwgSmFudWFyeSA4LCAy
MDI1IDk6NDEgQU0NCj5UbzogeGVub21haUBsaXN0cy5saW51eC5kZXYNCj5TdWJqZWN0OiBPdXRw
dXQgdGhyZWFkIHN0YXR1cyB0byBPT0Igc2VyaWFsIHBvcnQNCj4NCj5JJ20gdHJ5aW5nIHRvIGRl
YnVnIGEgdmVyeSBpbmZyZXF1ZW50IGxvY2t1cCBvZiBvdXIgc3lzdGVtLiBJdCBvY2N1cnMgb25j
ZSBldmVyeQ0KPmRheQ0KPm9yIHR3by4gVGhlIHN5bXB0b20gaXMgdGhhdCBhbGwgTGludXggcHJv
Y2Vzc2VzIGZyZWV6ZSwgYnV0IHRoZXJlIGFwcGVhcnMgdG8gYmUNCj5hY3Rpdml0eQ0KPm9uIGF0
IGxlYXN0IG9uZSByZWFsIHRpbWUgdGhyZWFkIChhIHBpbiBpcyB0b2dnbGluZykuIFdlIHRyaWVk
IHRvIGNhdGNoIGl0IHdpdGggdGhlDQo+d2F0Y2hkb2cNCj5idXQgdGhhdCBkb2Vzbid0IHRyaWdn
ZXIgZm9yIHNvbWUgcmVhc29uLg0KPg0KPkF0IHRoaXMgcG9pbnQgd2UgaGF2ZSBlbmFibGVkIHRo
ZSByZWFsIHRpbWUgc2VyaWFsIHBvcnQsIGFuZCB3ZSBjYW4gc2VlICJoZWxsbw0KPndvcmxkIiBm
cm9tDQo+YSBoaWdoLXByaW9yaXR5IG9vYiB0aHJlYWQsIHdoaWxlIGEgbG93ZXIgcHJpb3JpdHkg
b29iIHRocmVhZCBpcyBydW5uaW5nIGFuDQo+aW5maW5pdGUgbG9vcCwgYW5kDQo+dGh1cyBsb2Nr
aW5nIG91dCB0aGUgaW4tYmFuZCB0aHJlYWRzLiBNeSBuZXh0IHN0ZXAgaXMgdG8gb3V0cHV0IHNv
bWV0aGluZyBsaWtlDQo+L3Byb2MveGVub21haS9zY2hlZC90aHJlYWRzIHBlcmlvZGljYWxseSBv
biB0aGUgcmVhbCB0aW1lwqBzZXJpYWwgcG9ydCBhbmQgd2FpdA0KPmZvciBhIGxvY2t1cC4NCj4N
Cj5Ud28gcXVlc3Rpb25zOg0KPjEuIElzIHRoZXJlIGEgYmV0dGVyIGFwcHJvYWNoIHRvIGRlYnVn
IGEgbG9ja3VwLCB3aGVuIHRoZSB3YXRjaGRvZyBkb2Vzbid0DQo+Y2F0Y2ggaXQ/DQo+Mi4gSXMg
dGhlcmUgc29tZSBjb2RlIEkgY2FuIHN0ZWFsIHRvIG91dHB1dCB0aGUgdGhyZWFkIHN0YXR1cywg
b3IgZG8gSSB3cml0ZSBvbmUNCj5mcm9tIG15c2VsZj8NCg0KTWF5YmUgeW91IGxpa2UgdG8gZW5h
YmxlIC9zeXMva2VybmVsL2RlYnVnL3RyYWNpbmcvZXZlbnRzL2NvYmFsdF9wb3NpeC9jb2JhbHRf
aGVhZF9zeXNlbnRyeSAsY29iYWx0X2hlYWRfc3lzZXhpdCAsIGNvYmFsdF9yb290X3N5c2VudHJ5
LCBjb2JhbHRfcm9vdF9zeXNleGl0IHRvIGNoZWNrIHdoZW4gaXQgZW50ZXIgcm9vdCBvciBsZWF2
ZSBoZWFkIGRvbWFpbiBldGMgYW5kIHRoZW4NCmNoZWNrIGNvcnJlc3BvbmRpbmcgZXZlbnQgdGlt
ZXN0YW1wIHRvIGZpbmQgIGlmIHRoZSBSVCB0aHJlYWQgZG9taW5hdGUgQ1BVIHRvbyBtdWNoIHRp
bWUgYXMgZXhwZWN0ZWQuDQpJbiBhZGRpdGlvbiwgeW91IG1heSBsaWtlIHRvIGVuYWJsZSBjb2Jh
bHRfc2NoZWR1bGUgYW5kIGNvYmFsdF9zd2l0Y2hfY29udGV4dCBhbmQgY29iYWx0X3NoYWRvd19n
b2hhcmQgZXRjIG9yIG1vcmUgb3RoZXIgdGhyZWFkIGV2ZW50cyB0byB0cmFjZSB0aHJlYWQgc3Rh
dHVzIGNoYW5nZS4NCg0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQo+DQo+VGhhbmtzLA0KPktl
bmRhbGwgQXVlbA0KDQo=
