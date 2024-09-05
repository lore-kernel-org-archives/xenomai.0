Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCE3621
	for <xenomai@lists.linux.dev>; Thu,  5 Sep 2024 05:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725515350; cv=fail; b=tUkPmJLOx428oaC+rljDyvNTZXC/KOyVnbgX3UqifHCfbKPuJ1yGMlOOkw7o42uBhxeGe3Tyl5xVMXrJMrTYEzRwKSOIRvLC5pJvK4LA/YaXK4D0WZspRuYbaWdh2M5VBQYVdbTGQUQJmgdoi5vqs+XFLSJJRBNVBn+ZtPu+gXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725515350; c=relaxed/simple;
	bh=1593AJJfESNzzs28lyrh1dEsmHbezp5wSugHEGduJuI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SLyRqU+1NIukA3Vw/+fSoqT7+Rp3UfarsfP6uU8fGLfJXLDowPXgEaZvV34qgAw5upDtqezqJwlfwBTio1bdPf/mtG4g7qBz0N1Pc1yjx+wTjgIAQkKiRXSefRdGY6FZoxP5vyYnWW+3/Pl3VPGTbxt51NXMpAbNXr31SgYtsJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zm8BSEsC; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zm8BSEsC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725515349; x=1757051349;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=1593AJJfESNzzs28lyrh1dEsmHbezp5wSugHEGduJuI=;
  b=Zm8BSEsCXTCTvFnnskHoK0R1M/trGHTN2hykxiFKjtYrcn4xG+MNV8TR
   OQAtA/A5sm5MQgqJEEtGAWK+ckSvUNcf+mGN4BDzIMbJE8lAHmJR/ogYT
   Off5+0IPtCGgLCz0iD85LJW9Pe6sGWmisDHSU/T85LVGy0X3cAwxOiCzb
   xv74xbzBPH0oO6D3WY9Wm15ACL0xZOfT0mGk64nO6/kEbuoYb2YxLHByb
   pMFxCPaKxWAIRC8+gytmHbdDEZZr/5yJcKnbTVC7W/DlVCqg70LFlCupF
   y1amat2CbBuEFDUdT3C1qM0aEtYV8QcJq0s+4RHq00jwz+4ChJD5W5rkU
   Q==;
X-CSE-ConnectionGUID: farpMHbeRnmVdugrPBLqQA==
X-CSE-MsgGUID: G4jdqaaITdSlpLLxz1sYKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="24354740"
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="24354740"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 22:49:09 -0700
X-CSE-ConnectionGUID: LHTkDritQm6NjYqFZwTUqw==
X-CSE-MsgGUID: OWZnwdTsQ6ShleIZJESK6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="69912801"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Sep 2024 22:49:08 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 22:49:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 22:49:07 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 4 Sep 2024 22:49:07 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Sep 2024 22:49:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4gMaD6YN02IlMv30hXruGyzSGzI4sugfuuXp8ixwCCelM2lRFQay4MK73hHjU0uxsbe/NX2VnkrTlLrvuRqPSAlfCD2ulQoVP5n0CywRiZnS+B8gxtby9i9okyoxM/0Gigl18Aji+YIXmsx3cJUJS7AYORu6NtDPaXt/oqrUhTyocGqzhpbCMtipP8wr1kLS5OKgda0atYsnHKbjZF+WQ76bjuAcnxWCPwTRFEJOQeNXFCNwFu7g9XhZf+XnoWeOz58vesLqz+ECEk/+H4uORQdET5xoDAj/1CZMtTI0XF0tmTcl/mznRAF4KLCSitEEqtyGVq7H8GkFLrdc2EEvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1593AJJfESNzzs28lyrh1dEsmHbezp5wSugHEGduJuI=;
 b=aW/aruk1NTNrIjzPA42JtNvptH7gvjkLIGh1Pa+nggz4kH95EItOiZWzHYhapExCQfnlzXbJ6YZ/+wyQY6RtzzdGg3jeQeMUqJDizTABd+hEVvfyw0kl+zmRUW6p/ffe9UwsJQNdMDifETdJf30PxcUFvYhq4oICIp2OWboQ+epGoIP2Lb0tTbwewGyxh+2yYWny5xvXuIv3C1dOuwmoUieWwNF5pN980csP6nT5Vbcq4Kg7XGX124Hk8oC111P8Mhg84iFTJUkq2WUC++eYzWGeHyzWNrD/NxkVsN8KmJ9NLFQAYEPCB75SJ3JH5fHfueaewTnR9vVfe5E8c/i6xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by SJ2PR11MB7713.namprd11.prod.outlook.com (2603:10b6:a03:4f6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 05:49:06 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d%6]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 05:49:06 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: Xenomai Community Call Minutes - Sept 4, 2024
Thread-Topic: Xenomai Community Call Minutes - Sept 4, 2024
Thread-Index: AQHa/zSSHQQMZKCrd0OEwtWY+YW/w7JIry8A
Date: Thu, 5 Sep 2024 05:49:06 +0000
Message-ID: <PH7PR11MB74992DC1CCB4F56F88D745B8F29D2@PH7PR11MB7499.namprd11.prod.outlook.com>
References: <PH7PR11MB7499F7DDE006A3A7291F61FAF27B2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749929DFFDCFE47376883636F2572@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499F4FFFC62E15096DFF8D3F2562@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749910600BAF97BCB41DC3D3F2202@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74999307830ABE8C6E622DB9F2F22@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74999CE443EE8E36CEC314FAF2F32@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74992D53E248664E6D075779F2D72@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499B96C3A6A82AEE69DC40FF2A42@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499FD09B7B037D05288165EF2B92@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74991CE5212F456DC69548DEF29D2@PH7PR11MB7499.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB74991CE5212F456DC69548DEF29D2@PH7PR11MB7499.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|SJ2PR11MB7713:EE_
x-ms-office365-filtering-correlation-id: b6df5558-d1db-43be-8fa5-08dccd6e745f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MXo2eUpMMGJpZERSL2FBelhnUGlCQ3Evb0NxRW9FandZVTl4SU5OUlZxUjMy?=
 =?utf-8?B?bzd1aXlrTHY0VHIyK3FmbU1Rdis2c0RiNDd5djU1R0RjSWwrVEg4TW4yWVN3?=
 =?utf-8?B?alV0cWJTeWhiNis5cHFFUlR3WEUvNjhoU003a083L216RE0rWVJtY25zaG84?=
 =?utf-8?B?Nnp5UnE2Z2NqWHhheEZaSXBzYTlhZkFrcDZqbjFUWjdneGphbndiZHNjWGJn?=
 =?utf-8?B?QVJCT2N5bGRLUHNGdXQzb3Q4NmVYVDJvVmhTcGNoVFZZN1U0U1BqeVZIRVpn?=
 =?utf-8?B?TXN6Z0RBdzFjZVRxTEJsL3dnVmJSY2lXTjY2K1d1UEtIbGVIWEdzWFZpVTBy?=
 =?utf-8?B?YXNkWVhraVRXTCthbzl6dDRJZjhsYk9CODZoQlJ0MkRCT01kcENzUjZCQkRz?=
 =?utf-8?B?VDNUL3dINWg4NGg5RHM4bUVSRTk3dkN2aVFMWFJ3M1ROdDJYZ0RpNG9McW1X?=
 =?utf-8?B?YmExaFRqamZSNHZnbGlVT2lwSFovcGc0N09zaW9hOUU5SGRkcDNpZ0tlaEFS?=
 =?utf-8?B?TWI3WUFMM1d2b01SaFYzbVRhZ2NuUi9ScE1SUGI4UEZyQkhlVGxBbnR4Uzdp?=
 =?utf-8?B?bkpKNTR0ckNMdEFDZ2hGNWsyMWJ1cDBTTXVQVnY1VlNTTHIxNkROK3BBU0Zk?=
 =?utf-8?B?TXNUejRsWlEva3NndmtyUzBJK2N0bjRSR21oMFd4WVpOeVBTTUo5eWZJdWoz?=
 =?utf-8?B?ZzFwcHZkVmtNNFVsZGhvb2lMSUd3anhKWmFKUEszeEczV0FGYXg0M2l3UHZS?=
 =?utf-8?B?RUU0RHRVR3kwL24rTVd6eWtmRVgxMW5HVzdLVTVhNHR4S0prdVhobXQ4bGZk?=
 =?utf-8?B?bHpZT2VER0Q3TVZNNGNLcXJoR1BSdUFrWDRlUkVEb2N1d3haQnV2Tnovb1BQ?=
 =?utf-8?B?NXp2L3l3SHhNU2Z0a0Y3SmlQYU92eEY2Y3poVjRIaTNBOEk5OUZxcnB6cGU5?=
 =?utf-8?B?eGs4eitmZG5LNmd1ZXVzbmtqMjhTMWkrc1UzSkVGeGN2VllZK2doRHNINnY0?=
 =?utf-8?B?MktIcVNYb2RKVTVabHZtU0hZaWM2N0MyS1ZyZDRaNHFGaVdVU3hnT1VsaXFF?=
 =?utf-8?B?TnJLV2tXTHROZUsxMUUrdTNtM0VoYWlzOHdmVzBsRW81UGs3Z216RmVrR0Q3?=
 =?utf-8?B?eTVjcmN2clhid25OTXNwb29BQ0M4L0h0eHhUNG1takVJb3dZeE16YitoaGQv?=
 =?utf-8?B?bG5tYUdmMWk3SVJsMWVLUHBRQ3JvM2YvM25FN3FRQVVkenVveStaOGs0QWow?=
 =?utf-8?B?UUhUb3MyTmxwbUJmM2lyNXdjOEpnRU1kbFpVSGI3TXBDZWFLbkJlWFpwYit0?=
 =?utf-8?B?amZPaVBhNlp1bG8rU0FkMUlPYUpxbW9GVWtkRVE2SWUyNVR0TjRJMlMxY1Nj?=
 =?utf-8?B?MUtzcEw0RVF2SEwyZlZiU3prbUQ5NjNucU52UGlYNlJIK3I5UVhaQ0NmRGpC?=
 =?utf-8?B?MGlla2N5ZTJtRC96K1MrS2duL2dwWktFWU5ma095VnZKcXJLZERUVDBDSThB?=
 =?utf-8?B?Qm8vZUJuRVRYb3h2a0RxeldiL2Q3dkt6SmgwbkdjbUhYQkpBT0p5QTk2T1ZM?=
 =?utf-8?B?aWVpY0NRQS9YUXE2TWlLek40eVpnSlAvTzF2SFR6cFl3TmdhMDRZUndtekwz?=
 =?utf-8?B?dUxHWkhneVNjbU5sYTc2OGJQVkJUMWE3OGloMEI2a3V5Y0tLRlhGNVNYWWsw?=
 =?utf-8?B?L0NjT2U2WjQzQUNuQ1lmN05qUU81OVc4dWU2Yy9CU04rS2MwZU5OOSt2cHJ6?=
 =?utf-8?B?RHIyTFFiSW81cmh3Y05DTWNCVDlXWHZQMzlkS3VveUptUDhlV3BpT3VOK3E3?=
 =?utf-8?B?cjd2OE14bm9xc1p4TjhnQ3pFNFc2WWE2QjBpazRwWU12RkhYbnhXa1owRGQ2?=
 =?utf-8?B?R0RSc1JLdWdKYlNKZ0FtTUt3TkFOUVpwMWFHUnFPd3IwU1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qmw3Vjc0RW8zME9VZHd5WGdpMzBJWWcxeTlJYlhRK05jUlVLL0pJMUJqelVj?=
 =?utf-8?B?Uk5JZ090Qi9jdjNSVUNyVkRlZXhTTnAxS2xYaHF6WTUrdnh2RXNOMGkxMHlv?=
 =?utf-8?B?dWduc2I5cHl3ODlDNkUvRk1VbGRSZHI1bGpqODlMRm5ZUXFnRTJjYlJWdzlZ?=
 =?utf-8?B?NFFJd2tuQWJoNlY2bkNIMmpnSXVsSzZLUjhnZFBUZmVKYkJpOCt4aDRmNWl0?=
 =?utf-8?B?SVJycVhjSnA3UFBJMmllUnF1K2haalprd2hlMm0zT05MZDdtWUxQYkJzQmNZ?=
 =?utf-8?B?NTdOa0pUL0l6S2dESkZReldBREpZRFg2aGpsVkpvRElFUC9zbmZ4T0dsU1Mx?=
 =?utf-8?B?WEtpTzdlOURaWGN3VHlQNzlHQWZKdUV3ZW5hMGFYNzArTmNUR0crQjM5SUd0?=
 =?utf-8?B?cTdMNDBhT2xZSlg3T3A3OERLbTE3M01XL1Rzb20zMkVNdkpTT0RvVjdCS1VB?=
 =?utf-8?B?WlRQZlVsa1VWV2liT0drV1lPbmg4VWFYZ2x4ZnNJampBQUExRjZ3SlQ0RDhY?=
 =?utf-8?B?a25DUExVTXA0dzRudG9yc1NrdysvZVYrV1RjeHhPNzZJRmx3T2pNcnAzUW40?=
 =?utf-8?B?REtKSVlGVUpLZEFBK1dsTVAxOEFmUkk5R1pUaWdPY3hHUnVBbHNyRndFd0Rm?=
 =?utf-8?B?djQ1N1UvdUc1TGFoQ3BRVXF5eU5YWEp1bUdidzh3YXNkN2NSblZpY1ZJUG85?=
 =?utf-8?B?YVB0bk9yeFhUSTJ6NG94T3FIeStjc0VmS2pYb3cyK2hGbzN5ZWYrT0xTa016?=
 =?utf-8?B?N3BRcUJtSlR5ektUTHIzTkt5a09XeUh2M0d5SlRadkl6S0s3UWx2bjZQdC9l?=
 =?utf-8?B?NElhaTV1UGt3NFVobnpvTUN4Q2syS1lTSGhoTUFOZjNpZ1kxRThZUVg0OVhM?=
 =?utf-8?B?MzJnNU0rVnNZaUZoZmgra1BzSk4wOHNpK0hQNFdSZDVZT21mV1dCUHBOcTR6?=
 =?utf-8?B?elFFL0xDNUNuUHZTSnV1VVFIWE8zVDIyN0FPYWtXL3VPMVdZMzIySTVMeWZN?=
 =?utf-8?B?d2N6QXMrdlpsd1JkVFZVN05La1FSSUlkUzh2Y2RhQk8rSFFSL3NPdngzSTBr?=
 =?utf-8?B?dVp6b0FtZHhjOE40eFl6THNmV29aWUJ2NitLUFYxNWRlS1dmMU53RFM1OVhK?=
 =?utf-8?B?TnFWaThzUHdFNGx0ZnI2cXdjT3g4MlFOQWlzRUNYdGkxTkF5S2hmS2VuTFJt?=
 =?utf-8?B?bmFKdm8wOVlCNlYyYi80aDAzVXhQQmZHcUUrUFBCa0tqSXhDNUVzUjNkV05o?=
 =?utf-8?B?TGtaQi8wMWZiZUxlS04rbkxsb1Nab0FmSis2YXVGZDg4a2RZdUdXL2FkN0VG?=
 =?utf-8?B?ZUJ5a0pRaXp2cXk2eCsvQzdaQ2I2ZWFTdytBckxRYWtwbHRYLzBVY1I5bkll?=
 =?utf-8?B?VFVyQzR5eTE3dlhTWCtuN2NIb093UEVKWU1WM0dSWlV4RkRqcmNleGlnR2tK?=
 =?utf-8?B?azR4OGNIRU1SVmZxUktXSW16Y3dFNENnS2ZFbjA0cU44MFU3c2duT1lDRFJm?=
 =?utf-8?B?V2xxYVpxZ3E5RUc0SUV3cUxPYzNGZXhWcWd1ajlxRUh4dzBCcVM1dmhTZzNL?=
 =?utf-8?B?bDFRcWliSDdxMkpkU0FlWjZFTk9mWVhuK0QwQkJjY0FsOGhnN0Iwc2VXb2FV?=
 =?utf-8?B?SmMzb2s1TXJYcEsyYnY1Z3JRM3lWbXpHTzlUVERpVkdOVWNwdHpLQitBUnFk?=
 =?utf-8?B?VmFrNW5UdHRNRjdUc3RsejZ2cjJVTjJIaU9LdWxoMzdub1p0ODR2eGl6NnFy?=
 =?utf-8?B?NUdqbW4rSzBoNDdhSlh5eHE4OHpROFR6MllLa0JKWkhuYTRNU3l1YWdlT09X?=
 =?utf-8?B?dC82VXoxU1N3OGU5R2RQUFhDWjE5QmhwZWJBUmd4bld1OW93dldiYkJWMGtu?=
 =?utf-8?B?WDFVY1VWWGlZdGYxc3F1QTQyNERiTXVZcWJJdCs4UlRHNE9yQ2hQeXloejVa?=
 =?utf-8?B?c1dOUDBNZXlpTCtmNm5mTk9vODczYTZBU0xJSmJaUzB4TkpnUnBEbmpHWXhF?=
 =?utf-8?B?aXN5NUJwS0NqQURwdFFadG1vd1VxdWQ4cmNZZVZaUjRISElmWkFSbFU2Y0U2?=
 =?utf-8?B?NjFmRUxWN2tVN09TRUZHK3N3aVg5aWIyT1ZpeDVQWTdJeXFLMlA0dm50eHc1?=
 =?utf-8?Q?4BqV80eX2MzUoNZfsGwm6/CMB?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b6df5558-d1db-43be-8fa5-08dccd6e745f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2024 05:49:06.2249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2MBGq9nX/xX4e03g0Uf2yavP9d9H02oHh2/3Ucvd0t/vPqztSQ03jZR211zorLMFNqqiPvElVsiv+uS/meypVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7713
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENoZW4sIEhvbmd6aGFuIDxo
b25nemhhbi5jaGVuQGludGVsLmNvbT4NCj5TZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDUsIDIw
MjQgOTo0MCBBTQ0KPlRvOiB4ZW5vbWFpQGxpc3RzLmxpbnV4LmRldg0KPlN1YmplY3Q6IFhlbm9t
YWkgQ29tbXVuaXR5IENhbGwgTWludXRlcyAtIFNlcHQgNCwgMjAyNA0KPg0KPkF0dGVuZGVlczog
SmFuIEtpc3prYSwgRmxvcmlhbiBCZXpkZWthLCBSaWNoYXJkIFdlaW5iZXJnZXINCj4JCURhdmlk
IE9iZXJob2xsZW56ZXIsIFRvYmlhcyBTY2hhZmZuZXIsDQo+CQlIYW8gTGksIEhvbmd6aGFuIENo
ZW4NCj4NCj5Db21tdW5pdHkgdXBkYXRlOg0KPgkJWGVub21haSByYWNlLWNvbmRpdGlvbiBpc3N1
ZSAtLSBmaXhlZA0KPgkJRG92ZXRhaWwgaW52YWxpZCBzeXNjYWxsIG51bWJlciBpc3N1ZSAtLSBm
aXhlZA0KPgkJQ29iYWx0IHN0YWxsaW5nIGlzc3VlIGluIGNvcm5lciBjYXNlIC0tIG9uZ29pbmcN
Cj4JCUlERFAgc3R1Y2sgaXNzdWUgLS0gb25nb2luZw0KDQpTb3JyeSAsIG1pc3NlZCBhIG5vdGlm
aWNhdGlvbjoNCk5leHQgbWVldGluZyggU2VwdCAxOCkgLS0gY2FuY2VsbGVkIA0KDQo+DQo+UmVn
YXJkcw0KPg0KPkhvbmd6aGFuIENoZW4NCg==
