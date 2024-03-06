Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3E2D52E
	for <xenomai@lists.linux.dev>; Wed,  6 Mar 2024 03:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709694960; cv=fail; b=SwE2IH0RUNHjrGrK5fC5GTIxWdJkbcIbmvL4vAkITWXtknlxsp5gxNcyVfm2Cua0Ajd0zKjqnupzcd+7CEU8WsxrGmx98vX6MdfIyN9315UHGa8yqCFsJyCOBGztWfb/XaRlOHTNkchYmryWB/LB+zhS49gB0vHbGq4kP/lJyVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709694960; c=relaxed/simple;
	bh=nvCs4POJvzyz3piOHy6Xk2A8VxY5tog6+tSG9UuaFSo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QDurU/0V4YoJqNv1t2tj8qT146NH7wrJg4/3IQJQdfB9AjaePlYeHQBvYxzyiTHiVj2ZFOeovyFKMfu0kK4ZtCJ5Y+GOtzxUI8dqgWSKIFHVVSCfQqQB9yKFHDUq3sWmCqHk+AaMnYPcYXKepYsEU4g9Gx0mxGBHE+5vfRqbqXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d2nkELmd; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d2nkELmd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709694959; x=1741230959;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=nvCs4POJvzyz3piOHy6Xk2A8VxY5tog6+tSG9UuaFSo=;
  b=d2nkELmdfRKQLNiiUXwsFpCPX8Hr50TGXLaE1Yp/aW9UFABsj9BE7z+S
   JH9l8qYigoCgOhpccIUqMMJZmOFf0ySnol3FP9gMQBqvBUgoo0DscSd1k
   7Iv0T80apXzpRIy8ZGxgOsjzCKq07LVrJC7acB1qfZdOcayUdhDGT8aC0
   ebVtCrQiaPjqf+yWk8A6TApkQyHiRUnfRC9hTKq8cBryJKJPGvbRlngyp
   tH87aNHJqi9vcr2cFU+2GtXwV40uVoDZdq2KYG3rs8bZq7bwxte2g0t9M
   ya6jiZLDR0lxH+MIzTqtIBuVKZMQzF+z4gnsLW4bZyrWBn1ktRu2wTmza
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4217648"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="4217648"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 19:15:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="9472303"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Mar 2024 19:15:25 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 19:15:25 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 19:15:24 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Mar 2024 19:15:24 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 19:15:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UATdGQXpoqXTlLDk6oLmGN/09EPe2Y+3l6eV2sGqztLTk7cDpBgzgzNPo0DcVPJmV/8dBlOCDtsLnaCsefGYJGZUg9ks5qZPoZYDv2lcq//4hGUtXAL2ZEnEQOShXE58t6Ula0qJi962EUm0gtwCVmEp7oc6QybUpIxJ7LWAZu8OeXSIdhCly+cQgu+QZs8JDKVcHEEHzeHX1rsJfRXBmQADxUJbUDILHooyvEs+jKEJj2weg7ra+eKCTKgV+GYLFgG8pQP8jt2wV2XWbhoXNG2NQ5aKPGeS8qkoyorWXEkimeOVdpsvWG4TKsDXlds0KhJP+Pl9LJSSqDbavX7JRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvCs4POJvzyz3piOHy6Xk2A8VxY5tog6+tSG9UuaFSo=;
 b=iMPrT7B0hxBq/FAOSihCdsA3swhcDZvB3EfQ+7TS9/3PzbVOOOGwSf27YEXaHXDy6PYSIjtth1uMeQehV0xFGuzwNz+4IVKz10GRFUEuVo8ucRm6RkVB/Xdr6NcgEH/kvufdm4hqhBm2A+M/mzt7O7DrVZ9hyP+aHFVQG69LyKXGtaq/9RKox3KINWmyjOwnjih+3+Ktx6HLZUrb2olYRfDEjs9OuXyggnCe6rJwhljhG2GUli2TGxI2M/JVBw8Py5Wc+UBm/qSiFqFRa4z7UDuOG5HPvL7lU8zKPXGycTJbKCtbRolPJuZ3D35NzwdD3P48n+1qu2ivMxt5Iciomw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by DM4PR11MB7279.namprd11.prod.outlook.com (2603:10b6:8:109::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.23; Wed, 6 Mar
 2024 03:15:12 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::16d:5f07:19bb:6900]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::16d:5f07:19bb:6900%4]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 03:15:12 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday,  Mar 6, 2024, UTC 7:00
 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday,  Mar 6, 2024, UTC
 7:00 AM
Thread-Index: AQHab3SA6qTdObB/Pk6zgWDaOHk2ag==
Date: Wed, 6 Mar 2024 03:15:12 +0000
Message-ID: <PH7PR11MB749988D3E2C96C4F21DAEBE4F2212@PH7PR11MB7499.namprd11.prod.outlook.com>
References: <PH7PR11MB7499F7DDE006A3A7291F61FAF27B2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749929DFFDCFE47376883636F2572@PH7PR11MB7499.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB749929DFFDCFE47376883636F2572@PH7PR11MB7499.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|DM4PR11MB7279:EE_
x-ms-office365-filtering-correlation-id: 2aec6e55-1eb0-4216-9c20-08dc3d8ba319
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xocDRWx4N4jz7lrWsnnsJkhRmEScLt2V61RzD8FzsVQH11a7YE84LLt/5TLAr0zhZd1ssXHCuhFzT9gUZjfREJIjlNswZbDqPSEGS6aAal+pWr6xQb1HzPzaVnlgO24zshtzyzs+Wf5GStQYlvpUO09pmddZzsregLo2XylZwTDJVEvnhtKQ85+0zdJAOwGdenqvAHfvxYoUt9ykSMH53NhqiITiLeh1WcXbCBPxspK7LNhugNh9U8YzrOCeQqIHKpJ8SEsZWiQSS5ptfB2I2o6WtKMjYKpq26R3om/AUnMqnsT0qnfzpj7wPh9NUwqqmPUcM6x9tM4pLal2dkCWbUmtQL3pEB8ou7UVrZecLWqZo9OU2brmRjO5CDB5sdmsIQ15/9739bB+8ElMXGm31lhsVvE0BVKpv7fJ+YmAB1HCtKxlzIwnPSpKU/sQMuKwtxViytuFzsOBLeZdVtxhqEeXwDThfIu1Y62Yyu2sL+6G6KbM4m30eJYfsEWDpQGzZWg9GdGsCmaKzPOmB/wJP42/38LsT0HTv2J49jNUjnOVoolHW0xZsfHdjemljDfMT3AOl9DpqJw9YeviJ1UyZrN+s1OHVKfHcWkBv+VFqKxZN8FCo0NWnEWKcsAQQX9eSQLLP4hLVUEL2P2G427EnTL+L+U32jAH6eUVkcGRzvbBchKjsF2mS3WWiYG49c5j
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ukk1Q0JUY1dRRVdrcVlGcS9EMjkzUXZoaktWSllBWGE2VGIwMzREcDRHQU5Z?=
 =?utf-8?B?a2o1YlI5Z0xBK0liYjdRekQ0RVB2YXVvUVQ5MFhyVjdNWFJhS3A2TGRUbXRU?=
 =?utf-8?B?WGJEdXJZN2tFWnZxcFhEeUdGNDF1ZnlFbitJdEFsc05scXR1KzRrenJJeDBS?=
 =?utf-8?B?OGVFR29xSEVuaWtDZm5saUxzd1BqeG5pNnBJNnZmN3diMk5sYlBzR0tlV2lj?=
 =?utf-8?B?dlNDSFM1SWZES1BaSDNrSmdJSzFQOGRvVnhLOGsrZHJIakdWaXdZVEdvZExi?=
 =?utf-8?B?a2pleDA4RXVEckFuUGlEaFRaVHVLRjFNWTN5bDRsdm81Q3FVdTlHZXYyT2RI?=
 =?utf-8?B?RUxjanVlYm0yUDdveW54YXFkVDVsUWtaR0d2ZVJ1eTVtUi9JYldFWXRsRkdF?=
 =?utf-8?B?NXZXR1dBbHFxRkJiaWdHaVBaNFNqb3EvZzAyUFZHSzJpbXo4WFpQb0pjZEdH?=
 =?utf-8?B?ZldCUzVrOEpUOVJuT080RGNYTitnck53NkFqdnBLTkdJYXhTQ0tnTUVVWHN3?=
 =?utf-8?B?eUZRMFA1TFBHbmFDR0k5SVpGejRqcFhLMlFqb3ZhQUdBTk9CUzc0NVZzZ2Zr?=
 =?utf-8?B?anl3by9XZEdhSzdXaGc3dkwyL3RUQm4yR05XS2F6Sjl1RmxvVjNvckkvNjRn?=
 =?utf-8?B?ZlZaaVE5dkFLcTZXYzE0d3FjZU83ekVRRW5yMW0xRm9TNEdWV3pMYnVJQ0lW?=
 =?utf-8?B?bkN6d0NiT1h5YnhJZWphd0J4MktrN0REV0dMVk5WTmhOdTAwVlcrSFF3VDNk?=
 =?utf-8?B?L29PdjJqb3pIMHRjWDAvWE1hbkpkdS83akoxaWluWC9qbmF3bnlyVXRJT2po?=
 =?utf-8?B?dVo1RkpSWVBEZ0FzOFVvN1Frc3d5V24vTkV2b05LbUtlSURscHVsbDl4ckx4?=
 =?utf-8?B?aFdWM3BNTlhYOUhmRXkwczZ6aTJpSHlzS0ZWV0JNQjNqandETUluWUlMSE5T?=
 =?utf-8?B?T3VkVjk2bUJxSTJLUnZHU2ZjWnlick5GaGZLdlNaQnVxVEVGVm8zNU5VNWZr?=
 =?utf-8?B?QXN2bXh1dHZ1M2VXT3IyVWU5dXJZNTBCZWRPRktKUGNUbXF0MFdUalNua2ky?=
 =?utf-8?B?a0ZrTEZybFVLMGpSeXZod1lyVW5GV1VmZ0lvcUZmdGsxVU9mME83MEs5WE4y?=
 =?utf-8?B?azcwd3JlYlpvRjd6VytxM09KcjVldVd3dDdHR1U2NFdyR2JVOVdPbDdxZGI4?=
 =?utf-8?B?NVBOUkl5cmlHSytKVkFydE9ZZHFLNWwvU2plaEhjaHAxNkxYT0dSRjd4Nm1Q?=
 =?utf-8?B?QTlmQkVqRTRaSTFmV3lPZGExV3NLRmJJYUh2RzdLOTBBZ3c5eEEvTVMxS3RU?=
 =?utf-8?B?N2pneGlobEIybVFJYnZOSkFTS2hNK05xcC9MNHpWV3dCdW5JdEtTcUJpSkZy?=
 =?utf-8?B?ZWtabXQ3RmhyNWVIeHlrbEZsZ2xERzhPMEYyWWMrcEJVajA4YnU0OHpYaWli?=
 =?utf-8?B?VDhqMW5GZ0x3N2dMZWdRSlBTLzVnVGF6Tmo5eXh3anBqQmY1NTdxN0gxOWpm?=
 =?utf-8?B?anVJSm1lczVKL1E1bk9Rc05MMTdwV05nZklEQStFLzhEbjJTQXpUYjR3cXEx?=
 =?utf-8?B?ZDBYa3ZkSW55ZjZPYlF0RnRjTXp0VkdIWjI5aFlEU1docWhaM1oycEJUT2h5?=
 =?utf-8?B?UHo3L3BieHdnbHZtSUVoeVhiaVJFUVROMCtXZm5pdUMwNkpQeVlPSEVWbWcv?=
 =?utf-8?B?RzRSMzNRQkN3UlREZmVMMW9YVVUxRmtra2lsSnZaMHoycDI0cUY0Z0RCQnVs?=
 =?utf-8?B?M0NzSi9EWmRlTjhRT1A1aDdKeU5LQUxzWEgxeWJlR00xbFR3WlBFT0txZUVS?=
 =?utf-8?B?VUNkYXFlVjhvaE5iV1Fqa2l0eityeVR6UzFBSWRaVkxGYUtUVEs4RzJmR0JN?=
 =?utf-8?B?enhwOGRSQVFXRlpDSzdocyt5MmNPZU02R0tuc1dVMyswOFVQUC81YUxaUUJs?=
 =?utf-8?B?VnI3ckJyTHBtaVN3WjhEVW0rMW1haytrOTFYOEVzSGd1elM3NW1jRWFPNlp0?=
 =?utf-8?B?ZnZUbVZVU2ZlaUordVljdnp1MWl4YWdzd01GeUs1cEdQZU9UMDJLMjRJcUcr?=
 =?utf-8?B?eUFjZk00U3VyelhYRVhQMkZMRjBrcGNMbEJEQ2h1aFRraEpJVU51WXBhWWIv?=
 =?utf-8?Q?Oi9+nZK+Ziihc6k0qVyIpO90+?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aec6e55-1eb0-4216-9c20-08dc3d8ba319
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 03:15:12.5823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ceIG3LIM/3+K3RvKamO0O3quOrz5mHJAaSpR2n6diSrQRQIJnt1O5iB+8yeV9AQusmcEASXB2qYaTlgo9ZXvOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7279
X-OriginatorOrg: intel.com

VG9waWNzIG1heSBpbmNsdWRlIGJ1dCBhcmUgbm90IGxpbWl0ZWQgdG8gdXBzdHJlYW0vZG93bnN0
cmVhbSBwcm9qZWN0IA0KcGxhbnMsIHN0YXR1cyB1cGRhdGVzLCBhbmQgdGVjaG5pY2FsIGRpc2N1
c3Npb25zLiBJdCdzIGFuIG9wZW4gb25saW5lIA0KbWVldGluZyB0aGF0IGFueW9uZSBjYW4gam9p
biBhbmQgYXNrIHF1ZXN0aW9ucy4NCg0KVGltZToNCldlZG5lc2RheSwgTWFyIDYsIDIwMjQsIFVU
QyA3OjAwIEFNDQpQYXJpcywgRnJhbmNlIENFU1QgODowMCBBTQ0KQ2hpbmEgQ1NUIDM6MDAgUE0N
Cg0KSm9pbiBab29tIE1lZXRpbmcgDQpodHRwczovL2ludGVsLnpvb20udXMvai85MTI5NzI3OTI2
OT9wd2Q9V21kd1MwcERPRFJOTVM5dFFrNTRZMWR2YkZscVVUMDkNCk9yDQpodHRwczovL2ludGVs
Lnpvb20udXMvd2Mvam9pbi85MTI5NzI3OTI2OT93cGs9d2NwazUyYTlmOTZkOTg5ZTdlMjBiNjI4
YzJjMzZlNDhiNjhlDQoNCk1lZXRpbmcgSUQ6IDkxMiA5NzI3IDkyNjkNClBhc3Njb2RlOiAzNjc1
MjgNCk9uZSB0YXAgbW9iaWxlDQorMTI1MzIxNTg3ODIsLDkxMjk3Mjc5MjY5IyBVUyAoVGFjb21h
KQ0KKzEzNDYyNDg3Nzk5LCw5MTI5NzI3OTI2OSMgVVMgKEhvdXN0b24pDQoNCkRpYWwgYnkgeW91
ciBsb2NhdGlvbg0KICAgICAgICArMSAyNTMgMjE1IDg3ODIgVVMgKFRhY29tYSkNCiAgICAgICAg
KzEgMzQ2IDI0OCA3Nzk5IFVTIChIb3VzdG9uKQ0KICAgICAgICArMSA2NjkgOTAwIDkxMjggVVMg
KFNhbiBKb3NlKQ0KICAgICAgICArMSAzMDEgNzE1IDg1OTIgVVMgKFdhc2hpbmd0b24gREMpDQog
ICAgICAgICsxIDMxMiA2MjYgNjc5OSBVUyAoQ2hpY2FnbykNCiAgICAgICAgKzEgNjQ2IDU1OCA4
NjU2IFVTIChOZXcgWW9yaykNCk1lZXRpbmcgSUQ6IDkxMiA5NzI3IDkyNjkNCkZpbmQgeW91ciBs
b2NhbCBudW1iZXI6IGh0dHBzOi8vaW50ZWwuem9vbS51cy91L2FURUEzN2k1Rw0KDQpKb2luIGJ5
IFNJUA0KbWFpbHRvOjkxMjk3Mjc5MjY5QHpvb21jcmMuY29tDQoNCkpvaW4gYnkgSC4zMjMNCjE2
Mi4yNTUuMzcuMTEgKFVTIFdlc3QpDQoxNjIuMjU1LjM2LjExIChVUyBFYXN0KQ0KMTE1LjExNC4x
MzEuNyAoSW5kaWEgTXVtYmFpKQ0KMTE1LjExNC4xMTUuNyAoSW5kaWEgSHlkZXJhYmFkKQ0KMjEz
LjE5LjE0NC4xMTAgKEFtc3RlcmRhbSBOZXRoZXJsYW5kcykNCjIxMy4yNDQuMTQwLjExMCAoR2Vy
bWFueSkNCjEwMy4xMjIuMTY2LjU1IChBdXN0cmFsaWEgU3lkbmV5KQ0KMTAzLjEyMi4xNjcuNTUg
KEF1c3RyYWxpYSBNZWxib3VybmUpDQoyMDkuOS4yMTEuMTEwIChIb25nIEtvbmcgU0FSKQ0KMTQ5
LjEzNy40MC4xMTAgKFNpbmdhcG9yZSkNCjY0LjIxMS4xNDQuMTYwIChCcmF6aWwpDQoxNDkuMTM3
LjY4LjI1MyAoTWV4aWNvKQ0KNjkuMTc0LjU3LjE2MCAoQ2FuYWRhIFRvcm9udG8pDQo2NS4zOS4x
NTIuMTYwIChDYW5hZGEgVmFuY291dmVyKQ0KMjA3LjIyNi4xMzIuMTEwIChKYXBhbiBUb2t5bykN
CjE0OS4xMzcuMjQuMTEwIChKYXBhbiBPc2FrYSkNCk1lZXRpbmcgSUQ6IDkxMiA5NzI3IDkyNjkN
ClBhc3Njb2RlOiAzNjc1MjgNCg0KDQpSZWdhcmRzDQoNCkhvbmd6aGFuIENoZW4NCg==
