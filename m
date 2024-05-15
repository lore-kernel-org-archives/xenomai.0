Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E326364A1
	for <xenomai@lists.linux.dev>; Wed, 15 May 2024 01:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715738201; cv=fail; b=tE1TIPx9qCj2M4lMD7MNsoAWUk25lkA404bFWjWV90w0Tmmhcpy6cRoTdhrDhlEnIup/wGInBszJszXOoFFUPs3MMTpTN8mUg28jCH9+ndz90q2B5SeBmus+kDef1Gr1EW3YB2YkwLNYrOPpZP+twMtvE1ZrdyYCMld9KxLwARk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715738201; c=relaxed/simple;
	bh=XjO5w43CGfhdm41QvEKliDJlfmolCMQOkCG44GCJGvo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MJocFxboMmLV2PSV0gztE/+sreqWGBlAzOP+YZKdmKFR8b41UF24s3hUTb4xAhaxr6LtKhOhXr1ji4JYNwkzrxzg8ONL/jwG7d5Y6mYaqn+oAzdJp/WVN0neUEeyvsKGg8/vXxC/VSC4ID/Nk5EvnzcKfliSj+hAJ5v1zaU2o6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lYNK4MIZ; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lYNK4MIZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715738199; x=1747274199;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=XjO5w43CGfhdm41QvEKliDJlfmolCMQOkCG44GCJGvo=;
  b=lYNK4MIZ0lvN13G0Q7TIzYtDsh9oavxaPHasKQQGa89Fe3smvok2xbJv
   kC5hzuz2I+LgNtvlcAEulj2FYUMVdwsMKsX1Xda0dCV0biCKc5UDuNe9f
   jG03YAXqOj53Npk86Z/8hDYoszZ9BR0v1uYFfk+s2/mp9KEXR6TBKwxME
   nItiWZZFEzQ0rPPGDsnVNEolhkzGj3IbFEZksP3arqUvz5dIBifA/KBHA
   sO2LVxzVe6Fjxags0YRHtfJDJyvT+Rt7caj8frD16zE0FHxzJ1AeBn3G/
   uwc8vLYAg4xpYkh8zWk9d0/3WkOavQhrWXkWYiR1dN4F6hO+srhMb+YZh
   w==;
X-CSE-ConnectionGUID: vV4e7D6nSPG1ubbiwywbLA==
X-CSE-MsgGUID: t1NvBJ/LTKKVLS52O7FgVw==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="22349134"
X-IronPort-AV: E=Sophos;i="6.08,160,1712646000"; 
   d="scan'208";a="22349134"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 18:56:39 -0700
X-CSE-ConnectionGUID: NyVwviAQTWi38qoiVwWCyA==
X-CSE-MsgGUID: SPrs/4oyR1m2y8GwOUqpcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,160,1712646000"; 
   d="scan'208";a="62069953"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 May 2024 18:56:38 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 18:56:38 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 18:56:37 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 14 May 2024 18:56:37 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 14 May 2024 18:56:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQ8D8EmI2pp21PWYLIrWnY+vlxrssdYCi3lkoLVGYX5u9kzD5r2KI9J2lPqPr8kjNC5cPqNIobTKVYEUwlZW35xtMLT95OlqA6+Gp6E/H+8MXgCLIDsP/CznDTdaqO/pPjyMTgtND9oeySCkVCf41J+GIEo1x4lfBEd0+TDy9nXlA+1eYJlaquWC23zKsQaDik61+O1SGZo0pwpmHIYdlrhbceShQxwWl19qQ5qXFmZPv4IddaO/g286BWdeCQY/ipr4OgtiZoxghAQgJ4NoH79NLIL3Xc79ocWeMHj8DUXiMKgFzS2HVBL1zxYasAdds41/y4wMQ0j0oHZ/OxEbQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XjO5w43CGfhdm41QvEKliDJlfmolCMQOkCG44GCJGvo=;
 b=ktw0sf6M1oSUwxRBtAbOJjkgeWfLI4UVO9a70zH1bgdXT4I46phZzTk47fswtCnFXwbTUIxsMk4jx/tA/mc+DTvHFh68QFmmc2WpdidbdameaUVLVVgbGpH/Oe6Byu+eA9ne7UxnOlDjZABcj+L666d9SL6tn0VwTjR5ZjhWHNOT0PGVtNd+g/G5tYrzLy+cUR7Xr9fzXMihoyNUEtjakiUNDz5cvMgd61cw+xoYb7Ug4QxeSdQfDiIG6jvhaEoE2Keb6qxd6Dl6d5eduCgx7j2sE2RBQ4kjeRzJSelCakKdOJ/s9LyRbbmsb8BgMSzyD6xtAq2kdsJdUO3SfyVPQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7482.namprd11.prod.outlook.com (2603:10b6:8:14a::17)
 by PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.25; Wed, 15 May
 2024 01:56:35 +0000
Received: from DS0PR11MB7482.namprd11.prod.outlook.com
 ([fe80::5064:fe55:1220:1aea]) by DS0PR11MB7482.namprd11.prod.outlook.com
 ([fe80::5064:fe55:1220:1aea%6]) with mapi id 15.20.7587.026; Wed, 15 May 2024
 01:56:35 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday,  May 15, 2024, UTC
 7:00 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday,  May 15, 2024,
 UTC 7:00 AM
Thread-Index: AQHapmsdmlPsUQfizUOPxaBPImg6YQ==
Date: Wed, 15 May 2024 01:56:35 +0000
Message-ID: <DS0PR11MB7482613E8A9D78229EA71D07F2EC2@DS0PR11MB7482.namprd11.prod.outlook.com>
References: <PH7PR11MB7499F7DDE006A3A7291F61FAF27B2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749929DFFDCFE47376883636F2572@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749988D3E2C96C4F21DAEBE4F2212@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499C4BB71E159B3AB98D686F2332@PH7PR11MB7499.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB7499C4BB71E159B3AB98D686F2332@PH7PR11MB7499.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7482:EE_|PH0PR11MB5832:EE_
x-ms-office365-filtering-correlation-id: db9eee6f-2513-4fc2-aeb8-08dc74824073
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?SFlTelFhM2RwZkhvL1JyWVBjenhobjFvcTNlTEtGUUlGd25ncEdGV2R2T25I?=
 =?utf-8?B?NkhGZGNidE9NYXF5dElycmRsTHFMVEVZNG1adldPSi8vZStqNDN5RTJxMkE3?=
 =?utf-8?B?L3NNWG1VRlZ2ZE11QVFYRGlWYjFCTjJBK3RnR3piM2Njb0VvZDk4Ly9sYjRW?=
 =?utf-8?B?SVlhSXMyM3NjbGVFMkVhWUZ1VVl1bnpzUElOS21ndGVXZnkxRkJrTnlzckNL?=
 =?utf-8?B?Y0RsMnNRNHAyeWE0Zy90ZWwvb2xUWEZaTGo1UnY1d0F6OWRyUnFqQ25aUUsw?=
 =?utf-8?B?cXBHcGtEd0MyMWllUTVNdXZJV0t2THRvejR4a0x4WW1ETUFtS2FyZTQ5VVQz?=
 =?utf-8?B?Y2VvTjUwVzBpeXVjTWNrNnZScEVlRVZ2WGRUTnVWSXcvQ3kwTEhpRGZKODhM?=
 =?utf-8?B?ejNTUkdGblJiNXpQV0VVY1BXa3h3ZWluejZsQVhjOU12NHRrNEFTMkFudVQ4?=
 =?utf-8?B?SEt4UmRWTk0yYi9GWTlsSDA3OTdjWldmWFpiY1lXQUxOcEU1SlcwQkVJZlUx?=
 =?utf-8?B?YzVLblN0RlFHakdaV21zWDdBcUEvVlZLZ2dHVWhudW9pNGRuVUpJL0lBTXZq?=
 =?utf-8?B?OTlNNDRKTlhwWUtWdGJNL1JzT2dzMVpYRkc1QWdBNWZxLzNIWVdudytKS1F2?=
 =?utf-8?B?RUQzaGQvZlJnQVN6WXdHQURwYlQ5d1lJL3VKNDZwTkFJZFM2QzJiV0wrZitl?=
 =?utf-8?B?US9jYVNXZFRCS204cWFDSnh2N1RtQm8rVHg3NXZCUXhTMTlsbWx2Sm1LRm1o?=
 =?utf-8?B?Z1R6ZE1aMGlrbGY2VEFhb0dYcW9LOGJtZkFPMmw0UkRkS0k4VWFqencvRTM1?=
 =?utf-8?B?Qjh5bloxWkVnYVQyOFJEd2RnV3BJVEhBYlFGcVpmMm5JY3EyS0NveWI4eUV2?=
 =?utf-8?B?MWpYcHhXWlZzWE5lYTJkOTRxcEZ0MTJGdFFXR2V5dWp4aVlGSmprZDJMNjhH?=
 =?utf-8?B?am1PN1NPV1BGTnBRb1JaSG9lcnR0c0tldW5QbC90NmEwRVZVWnNCdmdxQlRK?=
 =?utf-8?B?M1E2N3hkQTZENDFUcDFKbHdlOXJQcUVNS20wcHF3ekNxbHdFdXlIQkgvR0d4?=
 =?utf-8?B?bHJBYjUxc2kxQUgwUjVZaGM2R2ZmZDRqWWNHM0ZvYzFIMWJCVzhpdFlmVi9T?=
 =?utf-8?B?SVlBenI3NVcydEcyWElPd2trQlNLTGp3dzJvUUx4Ymp3Tzl2MlZRTUhicVNO?=
 =?utf-8?B?SVBDK2FveGJ4SE50MUw5SE4rSXR1SlRPOFJRUlJKdStabE5HSVJYT2xUaVV0?=
 =?utf-8?B?VFBwZ24xSUd2dTROQW9LM2VMM1NKRG8zbitsbjZGbXJ4N1lseFJUV0N4Q2sw?=
 =?utf-8?B?c2U2Mm0zSElLM00yS2xqNlNHaGoxNzNqa3NubGREMWppK2h6OGdKV2QwaGNa?=
 =?utf-8?B?N3U5K2YzdVFHNXpKVDlyRnVNeU5HeWlRTjUwS3l3UUdVUW90b1BRMDIwT0lk?=
 =?utf-8?B?akdLSUpKVHUxMmJsYkFQaGcrcTN5eXJzZS9CY2xxdmZYQk4wYjRsYWZ6Nk03?=
 =?utf-8?B?YlpFZ1hXRzJDTW9uODNabFVHTVlhUmo2cW5GeEJvblJvYUZCSFhUUHJzakZD?=
 =?utf-8?B?citrMGp0TjNRNGEvWXJ0ZnRzSU1wclp3MnZoR2ZleWNDS0UrdmE5bzB3ZCtQ?=
 =?utf-8?B?RXFHWmlNUXJydXNNTmtDeFpYd2xIQ2s3dVErRi9PTEZJRS9DaDB5alhpTUFV?=
 =?utf-8?B?RHRlSDdpbHVyWXNZb2lWSWdUWHM4NkNMMEZlQ0ZPNS9xMXVSUllNQkJBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7482.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STVLa0ZmM015bGk3VGwvTzVWQTlxL1FscmMzZXRzN2NHVHFuRk1kYUg5NjFv?=
 =?utf-8?B?elltS25BS3EwTmlxL3FpS0RRSC9kQWxBUEFzbjNrMlZsN28wTENPdG03RS9m?=
 =?utf-8?B?TkNCL3F0b0IxVzJkQXBmS0VxQTgrTmxsQzNIODJmUWovckljR1pWSFFzOFdh?=
 =?utf-8?B?cEozMnR5cmh4T0wwaEhDTlZkT2ZlRTJzZVNybUZGWG9DVlQxdWxURlZXc0Nx?=
 =?utf-8?B?dmNyUWFqVUFnWVB4RC9mZDh5ZHQ1TlBZWjVaZ0dKVjhUek9TWHEvSWlocDJH?=
 =?utf-8?B?aVQ1QTVYREswOW1SWm9nOEQwVzlqRWVXeFJrTldkMEdLbkU2aWdXdC9vT3d1?=
 =?utf-8?B?bnh1YmkyZmxsV012aS9vS3FVTVBiRUJWN05ycUltVy92Q1dxU0c3cDFqbFNt?=
 =?utf-8?B?a010K2tKbGFML3FYVnRzN1RTbnFKOXJFUjh3U2Y5YTZTWEIwTURKei9YWmxj?=
 =?utf-8?B?WlZjaFhaVUYxZ3NVVExRbHg5YjcvTnhuN0VUUG1YbnNWc1NBMHVueXV5dnFt?=
 =?utf-8?B?YVg5N2FlVHJmMFlRYndBTld0enV4ZFV1VDdWSFlIWExaNVp2ekFBTjdMS09i?=
 =?utf-8?B?S01nTnFpZ1JwQ3pXaThKMkw4VzBmd2lOaE1xZTdwWDcxWGhvVEhLTURVTXNQ?=
 =?utf-8?B?TlcwV2w5N1FxVjMvSUJmbEZvNGk2NWZQMlhOVVJkOXNQVStrTXhQdmlnMnYx?=
 =?utf-8?B?bjJDRG9wVEhlZTJiKy80S1pXV2l4azZrQWdHQnRUV25YUzB5OVpaNEs4ajAr?=
 =?utf-8?B?Q1ZIT1NqWTNwcUVpWXNnNG1qMldYNnhpZEtQUUZHcThnazZMbnZrbkNxKzlB?=
 =?utf-8?B?WUw3N2c1emRoMlNPSXMwL0Q4WldZQ2tkdldBdUE4ODRuVnlPU0NwZTRuelFV?=
 =?utf-8?B?QnNmZGZmV2tGK2hVNnloREpwZEFEV3hESWdsVVIyVEgwWm5sUDhkRHlXcFZ5?=
 =?utf-8?B?UDFMNVFFcWtIbGwyTjg5RXl4QXJrdXh0VGh5bDhhd1NxNHl4UG14ZmI3V29r?=
 =?utf-8?B?a29SSGp6ckNyb0xObG5vekxtbGVmVHc1S0ZqV08vV0g4eTM1MDBDT2hFanIw?=
 =?utf-8?B?ZHIvemRlMlAxT05wanlhaDFqTXk4cml4MlUyOHV3VHVaNFpZMnhpdXppTkZx?=
 =?utf-8?B?dWF0SHkyVTBDd1F0ZTNPaCtaWW5WWE1ZamJtVVZQZmxVOHBINjhrOVZWak9H?=
 =?utf-8?B?Ynl5NjF0MW1ndVpVUFZlN3R6TnpENmZTNHJDQzdkMUtINDB0cmdEOXZLMnU0?=
 =?utf-8?B?eGdGSHVrSXE1S09vMXFyNUVZSGc5ZkNEZWZSOFBJYmpUWFJnTVlUUlVHZjM5?=
 =?utf-8?B?MkdGVEx5akdDOGROTkJpdlprbzZtbDRaMHhRT01yQUREcGJFaFVRekgwcFFN?=
 =?utf-8?B?elFpeFFtLzlBcnUxKzNGZXJid0xUYTBnaytIdE0wamZrbG53c3R0eWZXcnVZ?=
 =?utf-8?B?ZURxOXp5KzNiYVcxTzJSWFVZdXdXeHFuMzBKVG5kVHdNTmRWTWdlUEJqSWVC?=
 =?utf-8?B?RXdMclpSNGlhNTZsMUJoUU44ZTR5bWxpU2JOZ1AxOHQ2UWtpaDBDRFhXWERk?=
 =?utf-8?B?R0tPdDR6eVMxV1c2VDlzUGtDOSsyK05zWWJ4eUl2N201S3VNbjFlRWN5dXF5?=
 =?utf-8?B?Y2NIQlpwMFVLZjlDaGM0YVRPeTdGZTRmd09NTEZIWURUbjhwNThKSjhYcE5a?=
 =?utf-8?B?dXQ4QUJxMUp5Ryt4RG5jUVZBMTI2WEhHdGhSWU1RRHI2Y1ZsK0xzYTJrdm1D?=
 =?utf-8?B?QlNtOHRUc2diUHd4bXc1RVFKdytIeTBNTXdVYk9FM1VGTnBLZFhSQUdEcUxz?=
 =?utf-8?B?VVJIRXJWaEx6MkI4VERMMEdzaWh2M3lVTTlKd2huUyt6VkR0Y0luYkdRaFFw?=
 =?utf-8?B?S2U5Syt1Q05PajFCRHR2d0RVMzVMMlpuMUdCR2F2THYyRlExaXdsZXhwb0Zi?=
 =?utf-8?B?R3pDWXVNR2E0RHlsRnV5aHVDc3hQQktHNFlNVUZQdGtGY3IvY0V0Y29zMS9S?=
 =?utf-8?B?U0ZYc0RGVUdFTm4zNmFST2NRdm9xOTJjVGhWUTN3NUxhU3dwOXhWV0NiSGU2?=
 =?utf-8?B?cXZLUkd3NjRWaTJ4NUVtbERFSTNDRGlEVFNqalplSTVpeHZOMGVkeG8wUVJP?=
 =?utf-8?Q?n+MaSZvpN9bVkunl01Vuo1geW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7482.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db9eee6f-2513-4fc2-aeb8-08dc74824073
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 01:56:35.5509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YAJ8AuS8K2gKd9QiUoNw+dR0SgdGxmX54Q/3UW2PWX3T6FyBNw5i5sLscSDZQITFA4lE62LcCDdJE3W6vGxvbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5832
X-OriginatorOrg: intel.com

VG9waWNzIG1heSBpbmNsdWRlIGJ1dCBhcmUgbm90IGxpbWl0ZWQgdG8gdXBzdHJlYW0vZG93bnN0
cmVhbSBwcm9qZWN0IA0KcGxhbnMsIHN0YXR1cyB1cGRhdGVzLCBhbmQgdGVjaG5pY2FsIGRpc2N1
c3Npb25zLiBJdCdzIGFuIG9wZW4gb25saW5lIA0KbWVldGluZyB0aGF0IGFueW9uZSBjYW4gam9p
biBhbmQgYXNrIHF1ZXN0aW9ucy4NCg0KVGltZToNCldlZG5lc2RheSwgTWF5IDE1LCAyMDI0LCBV
VEMgNzowMCBBTQ0KUGFyaXMsIEZyYW5jZSBDRVNUIDk6MDAgQU0NCkNoaW5hIENTVCAzOjAwIFBN
DQoNCkpvaW4gWm9vbSBNZWV0aW5nIA0KaHR0cHM6Ly9pbnRlbC56b29tLnVzL2ovOTEyOTcyNzky
Njk/cHdkPVdtZHdTMHBET0RSTk1TOXRRazU0WTFkdmJGbHFVVDA5DQpPcg0KaHR0cHM6Ly9pbnRl
bC56b29tLnVzL3djL2pvaW4vOTEyOTcyNzkyNjk/d3BrPXdjcGs1MmE5Zjk2ZDk4OWU3ZTIwYjYy
OGMyYzM2ZTQ4YjY4ZQ0KDQpNZWV0aW5nIElEOiA5MTIgOTcyNyA5MjY5DQpQYXNzY29kZTogMzY3
NTI4DQoNCg0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQo=
