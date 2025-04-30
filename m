Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991263D561
	for <xenomai@lists.linux.dev>; Wed, 30 Apr 2025 23:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746056825; cv=fail; b=aRtY7b3UneOL3ktElbl/R/epfss8OzIYs7khhGVHMcd+c+iX0lsn0XkE5opYTSSKoOLo7cjasZ9mHnDpsFI7YtfS+NM8+jYFaBlMXWtIMp9Co9X4hSHEsB/1I6X/axKh+OYJ8f5qOGoxu61fnoeiD/24+piOA/U4DbIHhBfgKcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746056825; c=relaxed/simple;
	bh=sbTiCnwqY6vsk4Z9XruuDf0Fq/H+knJ2cYE4lGoon6I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UhqE3kdz7eCQJlkAYjG/szAaAHVoIs+9XCkrZ1CV6L+SKwwbYpKSr4vOfVAM1KLXNprPpOTiJpOm9+0xhgQTTlii4Qf8vo7jFkbx8J+65+dWZw1enXF3rNuBEGHsZWw4WMN2v1EIFz/h9cC+3o1P6y3klhmlWUtHFY9Uhor7p/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H5D1rDqj; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H5D1rDqj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746056823; x=1777592823;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sbTiCnwqY6vsk4Z9XruuDf0Fq/H+knJ2cYE4lGoon6I=;
  b=H5D1rDqjfo9O2aTVekKCSu7pqBeI9y5N/uEplnT5N3LHaCzjFHnm8ZEc
   zZtDghcRFCFd2izPob5o4IH5W26Rj1wWa5SZX2kcrVQFGK17AmdEYKPtC
   nvYocauOJVIZgYtvxFirHH37N2X0hediWIH239SZQdbZNEJxFmNfSS0uH
   9W73aQhw+UWqdDO/GwP1bFlRXmSGcLmhlV8ue3VS/EdoHr6V1Hxi/Atrr
   KrcAqOn1Dgij4YESyUAoJ8B8ivwBgsQFgMRv2dyiCU/LaOTRD+mWZK9G5
   qiUH0OVwrCFEchWAzINfrhd96cvxeQMEmk8JC6jDe6KXicI0RDGXHAdUz
   A==;
X-CSE-ConnectionGUID: nGENGLslTOOZUnSVN3ziSQ==
X-CSE-MsgGUID: nbS4XGAMSZSQaE7jZVO1IA==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="47876060"
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="47876060"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 16:47:02 -0700
X-CSE-ConnectionGUID: To1zvW3fT2aWxdTXZrSq1g==
X-CSE-MsgGUID: f7Sa+29BRIGp9iUCn0aieg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="139076155"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 16:47:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 30 Apr 2025 16:47:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 30 Apr 2025 16:47:00 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 30 Apr 2025 16:46:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Le3paAVr8vVKPzjsVDQOdpk6HsSFKflhrSlY/udPUtB0WIZMZtChOGF3B29AU2Vgdqyl0jm9JHXZJnSNd754u2fAEGeUDtYkFYh5sPEMZkV51TasItTcpasqnw9omNQVlvaJBSl2QSvV+Nss+mLbyyoo3McwmhK3hzGhLl5ouOiivi+1DttB+N1o0u3RSv2a3ZXwzC3pettFhA2ZRZ7G/jk9aGbe4ShRGuRmHTpflhJEWE6ZhmG8vNBD8g8Uk5ap9JK/1fB9KLl3koA4tElPtUg4OX1st/88ZLt3vwfRCqPOP6G6JuZcHVHrCFPpNmVDx/tNLGprWNNb+Zn7iEcGtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbTiCnwqY6vsk4Z9XruuDf0Fq/H+knJ2cYE4lGoon6I=;
 b=jjvPdjsWkVzHKb2HhFPC3z0g4srGW1MTziQ0Iz8gRkagXhdW2dsz8Kk5ebTdntAIDRDnYrLoKL8BlYJwXoM6eXADm3gJFhxhGKJ0PGsdJcnzrmllbTvILvR0WAoxgdFbmGoajhP85x5fu3CcwmqGshHVsYTilOhj+lXo5I7teMTs1gh5dwrZgumpq6iIlwzlt5uZRprPnEuuT224N49jrA+aOYBT7yxBaslM0noWao5NT+baE7qRe/ugiLj1ytppt8WIiOlGDxJP7s4HO1IPMFVjVKpximJSzn08PDCs1vz5ze6wjSdhEmfgCIlXKEUrp8b5Pi5W3okgj5yCow14eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6513.namprd11.prod.outlook.com (2603:10b6:208:3a3::7)
 by SA1PR11MB6688.namprd11.prod.outlook.com (2603:10b6:806:25b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Wed, 30 Apr
 2025 23:46:48 +0000
Received: from IA1PR11MB6513.namprd11.prod.outlook.com
 ([fe80::8012:e01:4c01:d824]) by IA1PR11MB6513.namprd11.prod.outlook.com
 ([fe80::8012:e01:4c01:d824%4]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 23:46:48 +0000
From: "Qiao, Wei" <wei.qiao@intel.com>
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>, "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
CC: "Chen, Hongzhan" <hongzhan.chen@intel.com>, "Pirou, Florent"
	<florent.pirou@intel.com>
Subject: RE: Build error of kernel/xenomai/debug.c
Thread-Topic: Build error of kernel/xenomai/debug.c
Thread-Index: AduvcNIP6fYojmwUSlGjpzfO8h3ARwAA+zCAAACQPoAAK7b9gACF9hAAAATet6AAFDpeAAAulatwAZZxU4AAHOXmMA==
Date: Wed, 30 Apr 2025 23:46:48 +0000
Message-ID: <IA1PR11MB6513BD2200559301D475BFF38C832@IA1PR11MB6513.namprd11.prod.outlook.com>
References: <IA1PR11MB6513EB0131E06C8CC865E8EF8CBC2@IA1PR11MB6513.namprd11.prod.outlook.com>
	 <72c2c5cb18b635f1145c35b6592c661cf55aeb0f.camel@siemens.com>
	 <370f022e-d5e3-46f1-a19f-5448afeebb61@siemens.com>
	 <IA1PR11MB6513A045F8ECB1186B65DA9A8CBF2@IA1PR11MB6513.namprd11.prod.outlook.com>
	 <4342e7e1-a7d4-431c-8fcc-f7731d3938d9@siemens.com>
	 <IA1PR11MB6513FC978522428982B0A30A8CB82@IA1PR11MB6513.namprd11.prod.outlook.com>
	 <4abe85c4-1457-4137-9e54-ea1a8aa534d4@siemens.com>
	 <IA1PR11MB651388E02D8925FB8EA908CE8CBB2@IA1PR11MB6513.namprd11.prod.outlook.com>
 <298a2bdeb3a4a15ccfbac1e7a37c68c8833a2fa3.camel@siemens.com>
In-Reply-To: <298a2bdeb3a4a15ccfbac1e7a37c68c8833a2fa3.camel@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6513:EE_|SA1PR11MB6688:EE_
x-ms-office365-filtering-correlation-id: 7c309d63-a854-4d85-e13c-08dd88414624
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|13003099007|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NU1YaU0zN3JKVnV3eEdicVhyeHl4bHAwbVhYYkZoZ09va1NtSVh5RVFuUzVD?=
 =?utf-8?B?UUQwZTVSSW1TMGJCb2lYaS81dHBNUXF2NnhDakpqMUhrQmFnVk9wQ2lSMTA2?=
 =?utf-8?B?QW5sNkxQN25CeUZPNHgrbXdZNDI1RWxBeXRRbWZHcTg4MzRzNHZXakhlVFln?=
 =?utf-8?B?dzRERzcvVThUcXpWQ3QrbnFVQW90VzhzZS9xcmE4TTZuOXpPY01Ud0VUeExI?=
 =?utf-8?B?bDNkNlZUcnN4SHZjd0Jxa1FWN3FVWDJ2a3ZKV090bkpDdzhISm5mcHZOVmtE?=
 =?utf-8?B?UCtuRDdWb1pWWTJkSWlTTXFCUGtxdG52ZlVmTmEzRms5OFJack80ZC9nb2M2?=
 =?utf-8?B?cFRiOHNwT051cW5xVGxtK0VXekZYWFlIdjNKNjNjY3FZZ2pJNVpqOFNXNW9C?=
 =?utf-8?B?WSsvTUtWWTZVdUlzRFZ1UUFHK1Y0UFZNMXozUHVhQ295QmcyN1RaOVNyZHpt?=
 =?utf-8?B?UHJ0N29sOE5NQkc0SVFjS21BZlBXaFpuYzZuYW1TcUJmZFZHV09BVjk1SkVk?=
 =?utf-8?B?Z0FXYkp2OElJdTgyYVFYUFpEbUZvbWRkZ2kwcU5YYTY5WnVUR00rNXJMQnl5?=
 =?utf-8?B?MFZSU1h1ZWRNOU9ONkNFZUg4czU0UzZRankrb01ST2V5eTlIbHAzMHQzUmxu?=
 =?utf-8?B?dExpektrYURGNDRQYXROS0RhU2E2bWtlWWNiMTdNMjkxNHVDbFo3SkhRSVdr?=
 =?utf-8?B?Y053Uy96ZG1pQXd3Y2ZCTXpQaGlIaUNYRGlzemwwc1FmbGZ6a2lkV0k1MWV5?=
 =?utf-8?B?RUhORVBFZ3lYSmk2UjltYWs2S1hEVUkxNjdDVkFPYWhHVFRualpUV0JJR3BZ?=
 =?utf-8?B?K0REUmR3aDdUWmxrS2dGYlpXVHQ0UFc2cWMxaEJqRTVhbHZMUzBYa2grVGlN?=
 =?utf-8?B?M1pkV3M1MUtNQi9VSE1tNnNvTUQ2WHpEcW5DcEFjaWhaQ0NaN1YrQU5DbnB4?=
 =?utf-8?B?Mm5WVHRjQ1NaVGp4WFdyYnkySkFqZlVYamRISmRpcTlzNUZpRkU1cExnbDY3?=
 =?utf-8?B?TnVJM1hyTDdqR0FZcC9HaVZJM04zS3N2ZjdvMnQzeDVQZ0g1U0hDR2FjYXFs?=
 =?utf-8?B?OTN0VFJkUmkrTXc4MmRwZ2t4dWdNYzVNUEJ2d2d6ZmR2d2xqakNTRlFqbDdM?=
 =?utf-8?B?WlZtaW5vZzhGNENqWXFCWGYrVjJDWm1LQW9SN0g4eWVCZlN3aGZpY0M5RVlJ?=
 =?utf-8?B?Umt5akxiWTJwK3gxMUVHSk9TU0lKY2F1RGJuSTJneFJaU1N6d2hydE5hZnVS?=
 =?utf-8?B?YkVtaUI0VHZKNUpKQXdkNEJXUWJ3N1ZkRWphRVkwa051NzVVWFYrZitXYnpN?=
 =?utf-8?B?WEpRTzF5a2J5MHFxVTJnbFpGcldiNEtQdXdvMFZPRlVpMjhqMVJwci9TQThj?=
 =?utf-8?B?SGV6eWFudzFRRFdXdm9Rekl6YU9oME9uRGRyTmhhL2c5TEFIKzd2WXc3RllR?=
 =?utf-8?B?Q1d3RGNuRS9HQUdHSElLQlhtL2JFMXh2Qzd5clFhcWl1TTJEZ1YrdUN5V1FK?=
 =?utf-8?B?RmJHbVlaY0h6VXhJOEFnc2JxNms0dFUrTWdIZ0N5NDA2YXFQcG5aMWc5SGw0?=
 =?utf-8?B?MnNTRWlseVN0MlpmZ2diS0JNdEtIdHhTU2JYZzd1LzFxWFYrNFIrRHN0RXR4?=
 =?utf-8?B?emtMVmpGWTRRZHpTd2xFWnV2U3FwRUwzMXYxYmdZWXNFL2oxWmpTNlVsMm5H?=
 =?utf-8?B?cWNLdG1iaHVYV285NEJPbHFTckhhZW9YT2tvT3NraUovZWowanVKQVV3Sml1?=
 =?utf-8?B?RGpTQU1OWnA3UlhOZjUyTHFKUWVNVWhoRm5jdjU5ZURVNGk4OUpLTXZDb2FH?=
 =?utf-8?B?Y0E4WTRVK1pOcUlhZTJJaEUzdGdEbzFDQTN2ZGs1a2NUb2xKUDA1M054Z2Qr?=
 =?utf-8?B?ekdWYkVQb0FpRG54eUVUcG52emVUTCtqVjBObzFwRkh1VXdheWE3eXRRbmtv?=
 =?utf-8?Q?lFhIdWMZLe4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6513.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(13003099007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sm1TSHNocHM5alBKV1l6ZzBIUU5CNE5VbXBsektUWXN0eTI2aC9oWHc5Wjlu?=
 =?utf-8?B?RXNiUDF5R0p3aXZDZlJENU9pZkdNQVVsQ2wzYjhXeU1UbXVhOHpQM0VLeFN0?=
 =?utf-8?B?dDZYbzdBRU91YXphR2xBbXZjS3BKWUo3SmY4eUd3V254cHNaSkhXdVpIdVNV?=
 =?utf-8?B?Z08vOWFNS1Z2SFF4YjJBcnM0amZhdGdrbDBNalpVdVMyQThlaytaMVdWVE95?=
 =?utf-8?B?d2NiVU5Wc0VvcG0wd010a0tQbnJ5TzZoSmNPajZhU0NkWThtVEtOVGpjb3ZG?=
 =?utf-8?B?TURwTUNKNnJTWE5uR2plaVdtVG9KNXIyeXNucnZ6eGVyRXpBcmdHUlBYTjB1?=
 =?utf-8?B?azMvdENvMTVUZ0UweGhIdTB2b2VLc244Wm5MemxvVXJmLzMwdmJSYVRZUXYw?=
 =?utf-8?B?bE1VVno1Tld4QTBIenVNSy9mdWtNVFlnUmFZSUlOOElkR3BjUFhia3RRU0h0?=
 =?utf-8?B?azNsVm5TemNVRXFmamRObEo2a0p0Z0dTSTNBcEM0TjVoR2lvTDY2UTMxZWx3?=
 =?utf-8?B?M3N0VU5pckVnRTdWNjd6RUQ1Q0V1TE45V2JSNjQ2RThXVTVKMDdzUW4xZ042?=
 =?utf-8?B?a3kzTUptRURiK25pd2FGUUFRcjNSalM5YzdRSzRrQys4d3ZJamhKUlBEOFZ4?=
 =?utf-8?B?UXN6aThlMWhQUUMzbzVWUVJOSnFMa3FYUzZwb2JLSDJoalZPZXdmNDN2R0or?=
 =?utf-8?B?S3F3YnZua0d1dnZRamtHZTVzcnlseHpXM1drRWNwOG1NTHpTclVIbjFFR2RE?=
 =?utf-8?B?VW0weFNVbzlWS09nNmlVZTRpaEZUdUhqOXdyR2p1K1l0MFoxMFBzSGJ1NThk?=
 =?utf-8?B?bytEK0VjOGRWLzNhRWE0MDVoNDlKOENIOURBTjBjSXJFS1Y1MTR1UmUyRU8w?=
 =?utf-8?B?KzFHS1k2NHNzbEY4dUhwLzRTK25GV25NZzFHWG5ZbldIVHY0aHNUSDVuUlVr?=
 =?utf-8?B?MXZRZTBhMlZ2SjhubmtESDBnM2ZaczRvbHZkMjFOZElrUTREYnQ3L0JSU3Jo?=
 =?utf-8?B?RDNKRmJYS3dLT0tzRS9tR3JuSHBtMWRiM09zNS9MN2U2ZUJBV3p1SWswMnZZ?=
 =?utf-8?B?bDB2NkYvNHdTYlJZTC9XbUpyT2tIemRlSWd2YVE4ci8rNXd4TStZOWN4eFI1?=
 =?utf-8?B?NEh3YytGYm5YYWlSWHZzWTZiTlhWWll3N2FocUcyQU5LQUtzVUhWYWJMUXJw?=
 =?utf-8?B?c01QMnRSTDVjR2UxNTlucU9JOC9rZVhoTnVQYkYvNS90UTdyVmlsNHArVG1R?=
 =?utf-8?B?NzByc2ZncXVaMTJCaWVMYk9YUlFiWVdLeGtnQ29XaE5jUkhaRVpJTVEwbVBa?=
 =?utf-8?B?WmdQVnNGa0YzMXlEK0FKYmNUM2FPMlFiaUtiMWVLU0h2d3h1Z0xkczlBZkY3?=
 =?utf-8?B?OWNIMzJVeVRNQ0hXamU0SFE2amNnZ0pRTkIzNVphUzNCSkJkM1dCUEtpUnpE?=
 =?utf-8?B?V2MyaVRQUkRvM2RnME5HTHRWOWhZY29oQlUwMlZ1aFprdGIxL0tQenFGSXJR?=
 =?utf-8?B?LzRTd2NCc1ExcTUzamxxRmlGa2tmT0hVUXcwOVJZYzhkODVRU0ZxL3pJZHhK?=
 =?utf-8?B?Mlo5Z2J5RFp2T0loTWo2MlgxRHcxamNmODhzMHc0TWYvYkNOWUZ2N0hnUGhD?=
 =?utf-8?B?NGtzMTdwZXZ4T2dJZUtWbTE4ajg0MWg3dlhsWjhTK0IrcjVuampIWVRiTTJE?=
 =?utf-8?B?OEtOTURmQURmeVFuTjh4SmpaVGhNQ0ZlSDRZejJGSE1LSkF2VGwzbnBoZnNC?=
 =?utf-8?B?YXJQMGNvRXI1aVhyMmFoRWV3V081M1RoQXAzYlQyN29aVEkzb1IrVmY3WHZu?=
 =?utf-8?B?TkRRakpCMGdqSTgwR2RzTVdrS1JCazhPWWxCeGplMnRiS21uSlBhQ0MvZFp1?=
 =?utf-8?B?TFNqM2Y0ekJ6Y0JYRDI3cU5KVStOYmVKR093SERmbVRFWTNlKzg1OWUxUC9p?=
 =?utf-8?B?cDkrTEx3ZFFxanpzL3B4SmxpUnJUcXk5ckxkTS9FNllSZDd3K01TNTNuRHpt?=
 =?utf-8?B?MFVtcUluRkM0QzBLYjNIMTVTQlFydHJ4WnRVdFgvQVpYVUhHc1RPd3BRWW9X?=
 =?utf-8?B?UXIrNzBWV3BlMC9kcEVDYkZ6ZTZxeFRJZ1pyeWNnd2g0S0hDUzAwVTVQUWds?=
 =?utf-8?B?L3U2ZXFvd25Pc2FQVmo2MkdTTExVb3dmMzhTZ25SdHREZUZMWEljUVRDNm9V?=
 =?utf-8?Q?lwEyXfJHBVRuMO/xeVOaR7I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6513.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c309d63-a854-4d85-e13c-08dd88414624
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2025 23:46:48.7460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JCt3/KsNIwKWot7usvMPi/nFITpeDQDUOYEEO/D68cxcUowxp4gpga1X524B9p3xITXfM2xQ3uikQIBc9q2tRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6688
X-OriginatorOrg: intel.com

MS4gaW5zdGFsbCB1YnVudHU6IGh0dHBzOi8vcmVsZWFzZXMudWJ1bnR1LmNvbS9ub2JsZS91YnVu
dHUtMjQuMDQuMi1kZXNrdG9wLWFtZDY0Lmlzbw0KMi4gZ2l0IGNsb25lIGh0dHBzOi8vc291cmNl
LmRlbnguZGUvWGVub21haS9saW51eC1kb3ZldGFpbC5naXQgeGVub21haQ0KMy4gY2QgeGVub21h
aQ0KNC4gY2hlY2tvdXQgdG8gdjYuMTIuMTktZG92ZXRhaWwxLXJlYmFzZS4NCjUuIGdpdCByZXZl
cnQgN2FkZDMwYzMzNWJjNiAiYXJtNjQ6IHZEU086IGV4cG9ydCB1c2VyLXZpc2libGUgTU1JTyBj
bG9ja3NvdXJjZXMiICAgICAjIHRvIGZpeCBidWlsZCBlcnJvci4NCg0KNi4gZ2l0IGNsb25lIGh0
dHBzOi8vZ2l0bGFiLmNvbS9YZW5vbWFpL3hlbm9tYWktaGFja2VyLXNwYWNlLmdpdCBoYWNrZXJf
c3BhY2UNCjcuIGNoZWNrb3V0IHRvIHYzLjMNCjguIGFkZCBiZWxvdyAyIHBhdGNoZXMgdG8gYXZv
aWQgYnVpbGQgZXJyb3IuDQoJOTgzMWEyMWI3IChIRUFEIC0+IDMuMykgQWNjb3VudCBmb3IgbW92
ZWQgdW5hbGlnbmVkLmggaW4gNi4xMg0KCWExNjY0MzU3MSBuZXRzdGFjazogcnRjZmc6IGZpeCBk
eW5hbWljIGRlYnVnDQoJM2UxNTc2ZjhhICh0YWc6IHYzLjMpIGNvbmZpZzogQnVtcCB2ZXJzaW9u
IG51bWJlcg0KOS4gLi9zY3JpcHRzL3ByZXBhcmUta2VybmVsLnNoIC0tbGludXg9fi93b3JrL3hl
bm9tYWkgLS1kb3ZldGFpbD0gLS1hcmNoPXg4Ng0KDQoxMC4gYmFjayB0byBmb2xkZXIgeGVub21h
aQ0Kd2l0aCBkZWZhdWx0IHNvdXJjZWxpc3QuDQphcHQgaW5zdGFsbCBtYWtlDQphcHQgaW5zdGFs
bCBnY2MgDQphbmQgaW5zdGFsbCBvdGhlciBuZWNlc3NhcnkgdG9vbCBzdWNoIGFzIGZsZXgvIGJp
c29uLg0KDQp0aGVuLCBidWlsZCB3aXRoIENPTkZJR19YRU5PX09QVF9ERUJVRz15DQoNCi0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBGbG9yaWFuIEJlemRla2EgPGZsb3JpYW4uYmV6
ZGVrYUBzaWVtZW5zLmNvbT4gDQpTZW50OiBXZWRuZXNkYXksIEFwcmlsIDMwLCAyMDI1IDU6NTcg
UE0NClRvOiBRaWFvLCBXZWkgPHdlaS5xaWFvQGludGVsLmNvbT47IEtpc3prYSwgSmFuIDxqYW4u
a2lzemthQHNpZW1lbnMuY29tPjsgeGVub21haUBsaXN0cy5saW51eC5kZXYNCkNjOiBDaGVuLCBI
b25nemhhbiA8aG9uZ3poYW4uY2hlbkBpbnRlbC5jb20+OyBQaXJvdSwgRmxvcmVudCA8ZmxvcmVu
dC5waXJvdUBpbnRlbC5jb20+DQpTdWJqZWN0OiBSZTogQnVpbGQgZXJyb3Igb2Yga2VybmVsL3hl
bm9tYWkvZGVidWcuYw0KDQpPbiBUdWUsIDIwMjUtMDQtMjIgYXQgMDg6MDAgKzAwMDAsIFFpYW8s
IFdlaSB3cm90ZToNCj4gTXkgdWJ1bnR1IHZlcnNpb24gaXMgUFJFVFRZX05BTUU9IlVidW50dSAy
NC4wNC4yIExUUyINCj4gZ2NjIChVYnVudHUgMTMuMy4wLTZ1YnVudHUyfjI0LjA0KSAxMy4zLjAg
dGhlIGRlZmF1bHQgZ2NjIHZlcnNpb24uDQoNCkFzIHRoYXQgdG9waWMgY2FtZSB1cCBpbiB0aGUg
Y29tbXVuaXR5IGNhbGwgdG9kYXkgYWdhaW4sIEkgdHJpZWQgdGhhdCBleGFjdCBjb21waWxlciB2
ZXJzaW9uIGluc2lkZSBhIHVidW50dToyNC4wNCBwb2RtYW4gZW52aXJvbm1lbnQuIEl0J3MgYnVp
bGRpbmcgZmluZS4NCg0KUGxlYXNlIGRvdWJsZSBjaGVjayB5b3VyIGVudmlyb25tZW50LiBNYXli
ZSB0aGVyZSBpcyBhIENGTEFHUyB2YXJpYWJsZSAob3IgYSBzaW1pbGFyIHZhcmlhYmxlKSB3aXRo
IGRpZmZlcmVudCBjb21waWxlciBvcHRpb25zIGludm9sdmVkPw0KDQpCZXN0IHJlZ2FyZHMsDQpG
bG9yaWFuDQoNCj4gDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEZsb3Jp
YW4gQmV6ZGVrYSA8Zmxvcmlhbi5iZXpkZWthQHNpZW1lbnMuY29tPg0KPiBTZW50OiBNb25kYXks
IEFwcmlsIDIxLCAyMDI1IDU6NDUgUE0NCj4gVG86IFFpYW8sIFdlaSA8d2VpLnFpYW9AaW50ZWwu
Y29tPjsgS2lzemthLCBKYW4gDQo+IDxqYW4ua2lzemthQHNpZW1lbnMuY29tPjsgeGVub21haUBs
aXN0cy5saW51eC5kZXYNCj4gQ2M6IENoZW4sIEhvbmd6aGFuIDxob25nemhhbi5jaGVuQGludGVs
LmNvbT47IFBpcm91LCBGbG9yZW50IA0KPiA8ZmxvcmVudC5waXJvdUBpbnRlbC5jb20+DQo+IFN1
YmplY3Q6IFJlOiBCdWlsZCBlcnJvciBvZiBrZXJuZWwveGVub21haS9kZWJ1Zy5jDQo+IA0KPiBP
biAyMS4wNC4yNSAwMjowOCwgUWlhbywgV2VpIHdyb3RlOg0KPiA+IEdjYyB2ZXJpc29uOg0KPiA+
IHFpYW93ZWlAd3FpYW8yOn4kIGdjYyAtLXZlcnNpb24NCj4gPiBnY2MgKFVidW50dSAxMy4zLjAt
NnVidW50dTJ+MjQuMDQpIDEzLjMuMA0KPiA+IA0KPiA+IEtlcm5lbDogDQo+ID4gdjYuMTIuMTkt
ZG92ZXRhaWwxLXJlYmFzZQ0KPiA+IA0KPiA+IGh0dHBzOi8vZ2l0bGFiLmNvbS9YZW5vbWFpL3hl
bm9tYWktaGFja2VyLXNwYWNlLmdpdA0KPiA+IHRhZzogdjMuMw0KPiANCj4gSSB0cmllZCB0aGUg
Zm9sbG93aW5nIGJ1aWxkIGNvbmZpZ3VyYXRpb25zLCBhbGwgd29ya2VkOg0KPiANCj4gLSBnY2Mg
KEdDQykgMTUuMC4xIDIwMjUwMzI5IChSZWQgSGF0IDE1LjAuMS0wKQ0KPiAtIGdjYyAoR0NDKSAx
NC4yLjEgMjAyNTAxMTAgKFJlZCBIYXQgMTQuMi4xLTcpDQo+IC0gZ2NjIChEZWJpYW4gMTIuMi4w
LTE0KSAxMi4yLjANCj4gLSBnY2MgKERlYmlhbiAxMC40LjAtNykgMTAuNC4wDQo+IA0KPiBUaGUg
ZGVmYXVsdCBnY2MgdmVyc2lvbiBvZiBVYnVudHUgMjQuMDQgLSBhcyBwcm92aWRlZCBieSB0aGUg
Z2NjIA0KPiBwYWNrYWdlDQo+IC0gaXMgMTMuMi4wLTd1YnVudHUxLiBTZWVtcyB5b3UgaW5zdGFs
bGVkIHRoZSBnY2MtMTMgcGFja2FnZSBmb3Igc29tZSByZWFzb24uDQo+IA0KPiBXaGF0IGhhcHBl
bnMgaWYgeW91IHN3aXRjaCBiYWNrIHRvIHRoZSBkZWZhdWx0IGNvbXBpbGVyLCBkb2VzIHRoYXQg
d29yaz8NCj4gDQo+IEkgY2FuJ3QgdGVsbCB3aHksIGJ1dCBnY2MgMTMuMiBzZWVtcyB1bmFibGUg
dG8gZGVyaXZlIHRoZSBvYmplY3Qgc2l6ZS4uLg0KPiANCj4gQXMgSmFuIG1lbnRpb25lZCB0aGUg
cXVpY2sgZml4IEkgcG9zdGVkIGlzIGtpbmQgb2YgYW4gb3ZlcmtpbGwuDQo+IA0KPiBBcyBJIGRv
bid0IGhhdmUgYW4gVWJ1bnR1IHN5c3RlbSBhdCBoYW5kIGFuZCBhbGwgdHJpZXMgdG8gcmVwcm9k
dWNlIG9uIERlYmlhbiBhbmQgRmVkb3JhIGZhaWxlZCBzbyBmYXIgYW5kIGluIGFkZGl0aW9uIGEg
bG90IG9mIGRpZmZlcmVudCBjb21waWxlciB2ZXJzaW9ucyBhcmUgd29ya2luZyBmaW5lOiBObyBm
dXJ0aGVyIGludmVzdGlnYXRpb25zIHdpbGwgZm9sbG93IG9uIG15IGVuZC4NCj4gDQo+ID4gDQo+
ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBGbG9yaWFuIEJlemRla2Eg
PGZsb3JpYW4uYmV6ZGVrYUBzaWVtZW5zLmNvbT4NCj4gPiBTZW50OiBNb25kYXksIEFwcmlsIDIx
LCAyMDI1IDU6NDcgQU0NCj4gPiBUbzogUWlhbywgV2VpIDx3ZWkucWlhb0BpbnRlbC5jb20+OyBL
aXN6a2EsIEphbiANCj4gPiA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT47IHhlbm9tYWlAbGlzdHMu
bGludXguZGV2DQo+ID4gQ2M6IENoZW4sIEhvbmd6aGFuIDxob25nemhhbi5jaGVuQGludGVsLmNv
bT47IFBpcm91LCBGbG9yZW50IA0KPiA+IDxmbG9yZW50LnBpcm91QGludGVsLmNvbT4NCj4gPiBT
dWJqZWN0OiBSZTogQnVpbGQgZXJyb3Igb2Yga2VybmVsL3hlbm9tYWkvZGVidWcuYw0KPiA+IA0K
PiA+IE9uIDE4LjA0LjI1IDA3OjUxLCBRaWFvLCBXZWkgd3JvdGU6DQo+ID4gPiBUZXN0IHBhc3Mu
DQo+ID4gPiBUaGUgc3lzdGVtIGNhbiBib290IHVwIGFuZCB3b3JrIHdlbGwuDQo+ID4gDQo+ID4g
V2hpY2ggeGVub21haS9jb21waWxlci9rZXJuZWwgY29tYmluYXRpb24gYXJlIHlvdSB0cnlpbmcg
dG8gYnVpbGQ/DQo+ID4gDQo+ID4gSSB0cmllZCB0byByZXByb2R1Y2Ugd2l0aCBnY2MgMTUgLSB0
aGUgbGF0ZXN0IGdjYyByZWxlYXNlIC0gYnV0IGl0IGlzIHN0aWxsIGJ1aWxkaW5nIGZpbmUuDQo+
ID4gDQo+ID4gWW91IG1lbnRpb25lZCBVYnVudHUgMjQuMDQsIHdoaWNoIHNob3VsZCBzaGlwIGdj
YyAxMC41LCB3aGljaCBzaG91bGQgYmUgZmluZSBhcyB3ZWxsLg0KPiA+IA0KPiA+ID4gDQo+ID4g
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogSmFuIEtpc3prYSA8amFu
Lmtpc3prYUBzaWVtZW5zLmNvbT4NCj4gPiA+IFNlbnQ6IFRodXJzZGF5LCBBcHJpbCAxNywgMjAy
NSA0OjU5IFBNDQo+ID4gPiBUbzogQmV6ZGVrYSwgRmxvcmlhbiA8Zmxvcmlhbi5iZXpkZWthQHNp
ZW1lbnMuY29tPjsgUWlhbywgV2VpIA0KPiA+ID4gPHdlaS5xaWFvQGludGVsLmNvbT47IHhlbm9t
YWlAbGlzdHMubGludXguZGV2DQo+ID4gPiBDYzogQ2hlbiwgSG9uZ3poYW4gPGhvbmd6aGFuLmNo
ZW5AaW50ZWwuY29tPjsgUGlyb3UsIEZsb3JlbnQgDQo+ID4gPiA8ZmxvcmVudC5waXJvdUBpbnRl
bC5jb20+DQo+ID4gPiBTdWJqZWN0OiBSZTogQnVpbGQgZXJyb3Igb2Yga2VybmVsL3hlbm9tYWkv
ZGVidWcuYw0KPiA+ID4gDQo+ID4gPiBPbiAxNy4wNC4yNSAxMDo0MywgRmxvcmlhbiBCZXpkZWth
IHdyb3RlOg0KPiA+ID4gPiBPbiBUaHUsIDIwMjUtMDQtMTcgYXQgMDg6MTUgKzAwMDAsIFFpYW8s
IFdlaSB3cm90ZToNCj4gPiA+ID4gPiBIaSBBbGwsDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gSWYg
d2UgYnVpbGQgdGhlIGtlcm5lbCBpbiB1YnVudHUgMjQuMDQsIHRoZXJlIGlzIGJ1aWxkIGVycm9y
Og0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IGZyb20ga2VybmVsL3hlbm9tYWkvZGVidWcuYzoyMzoN
Cj4gPiA+ID4gPiBJbiBmdW5jdGlvbiAnc3RyY3B5JywNCj4gPiA+ID4gPiAgICAgaW5saW5lZCBm
cm9tICdoYXNoX3N5bWJvbCcgYXQga2VybmVsL3hlbm9tYWkvZGVidWcuYzo5NDoyOg0KPiA+ID4g
PiA+IC4vaW5jbHVkZS9saW51eC9mb3J0aWZ5LXN0cmluZy5oOjc4NzoxNzogZXJyb3I6IGNhbGwg
dG8gJ19fd3JpdGVfb3ZlcmZsb3cnIGRlY2xhcmVkIHdpdGggYXR0cmlidXRlIGVycm9yOiBkZXRl
Y3RlZCB3cml0ZSBiZXlvbmQgc2l6ZSBvZiBvYmplY3QgKDFzdCBwYXJhbWV0ZXIpDQo+ID4gPiA+
ID4gICA3ODcgfCAgICAgICAgICAgICAgICAgX193cml0ZV9vdmVyZmxvdygpOw0KPiA+ID4gPiA+
ICAgICAgIHwgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fg0KPiA+ID4gPiA+IA0K
PiA+ID4gPiA+IFRoaXMgaXMgYmVjYXVzZSBuZXcgZ2NjIHZlcnNpb24gaGFzIHN0cmljdGVyIEZP
UlRJRllfU09VUkNFKCA9MyBpcyDigIxzdHJpY3RlcuKAjCB0aGFuID0yKS4gUGxlYXNlIGhlbHAg
dG8gZml4LCB0aGFua3MuDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGF0IGlzIHRoZSBmbGV4aWJsZSBh
cnJheSBzdG9yeS4uLg0KPiA+ID4gPiANCj4gPiA+ID4gWW91IGNvdWxkIHRyeSBzb21ldGhpbmcg
bGlrZSBiZWxvdyAoY29tcGxldGVseSB1bnRlc3RlZCkgYW5kIA0KPiA+ID4gPiByZXBvcnQgYmFj
ayBpZiBpdCB3b3JrczoNCj4gPiA+ID4gDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9rZXJuZWwvY29i
YWx0L2RlYnVnLmMgYi9rZXJuZWwvY29iYWx0L2RlYnVnLmMgaW5kZXgNCj4gPiA+ID4gMjViMTk0
YzI2Li5kMDQ4ZGM3NTcgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2tlcm5lbC9jb2JhbHQvZGVidWcu
Yw0KPiA+ID4gPiArKysgYi9rZXJuZWwvY29iYWx0L2RlYnVnLmMNCj4gPiA+ID4gQEAgLTQ3LDcg
KzQ3LDggQEAgRVhQT1JUX1NZTUJPTF9HUEwoY29iYWx0X2RlYnVnX3Zmcm9vdCk7DQo+ID4gPiA+
ICANCj4gPiA+ID4gIHN0cnVjdCBoYXNoZWRfc3ltYm9sIHsNCj4gPiA+ID4gIAlzdHJ1Y3QgaGFz
aGVkX3N5bWJvbCAqbmV4dDsNCj4gPiA+ID4gLQljaGFyIHN5bWJvbFtdOw0KPiA+ID4gPiArCXNp
emVfdCBzaXplOw0KPiA+ID4gPiArCWNoYXIgc3ltYm9sW10gX19jb3VudGVkX2J5KHNpemUpOw0K
PiA+ID4gPiAgfTsNCj4gPiA+ID4gIA0KPiA+ID4gPiAgc3RhdGljIHN0cnVjdCBoYXNoZWRfc3lt
Ym9sICpzeW1ib2xfamhhc2hbU1lNQk9MX0hTTE9UU107IEBAIA0KPiA+ID4gPiAtOTEsNg0KPiA+
ID4gPiArOTIsNyBAQCBzdGF0aWMgY29uc3QgY2hhciAqaGFzaF9zeW1ib2woY29uc3QgY2hhciAq
c3ltYm9sKQ0KPiA+ID4gPiAgCQlnb3RvIG91dDsNCj4gPiA+ID4gIAl9DQo+ID4gPiA+ICANCj4g
PiA+ID4gKwlwLT5zaXplID0gbGVuICsgMTsNCj4gPiA+ID4gIAlzdHJjcHkocC0+c3ltYm9sLCBz
eW1ib2wpOw0KPiA+ID4gPiAgCXAtPm5leHQgPSAqaDsNCj4gPiA+ID4gIAkqaCA9IHA7DQo+ID4g
PiA+IA0KPiA+ID4gDQo+ID4gPiBBIGJpdCBvZiBvdmVya2lsbCwgZ2l2ZW4gdGhhdCBhbGxvY2F0
aW9uIGFuZCBhY2Nlc3Mgb2YgYWNjb3JkaW5nIHNpemUgaGFwcGVucyB3aXRoaW4gdGhlIHNhbWUg
ZnVuY3Rpb24uIE5vIHNtYXJ0ZXIgd2F5IHRvIHRlbGwgdGhlIGNvbXBpbGVyIHRvIHN0YXkgYXdh
eSBoZXJlPw0KPiA+ID4gDQo+ID4gPiBKYW4NCj4gPiA+IA0KPiA+ID4gLS0NCj4gPiA+IFNpZW1l
bnMgQUcsIEZvdW5kYXRpb25hbCBUZWNobm9sb2dpZXMgTGludXggRXhwZXJ0IENlbnRlcg0KDQo=
