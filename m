Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8624EC2C6
	for <xenomai@lists.linux.dev>; Thu,  5 Sep 2024 01:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725500427; cv=fail; b=VAmfdXF6cr4NGrSafyVQJ2FoAlef9ho0gNEBmcSSX5GxWEEkmtgjXhW1qzHiIlyNMyvShnpoZ/s+OAPWko1rtqQQeJ9dPjIoZCvcm7wtUol+Vd5+7kY0YsYEZTRIay3AhhqVC5N+f3Id09FKOj4+DOhpaEvt4gvlkdv+64PkzVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725500427; c=relaxed/simple;
	bh=VHq6roRtNY5mfSerPPDH3NGjqyeX/RIrhfNbIAX5CMk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GQVJBrPR9OQkvI0Dwmurpaoon2XUP2xoI7v3CS0gBsw2kMgV5zgEwjM0oOVJQwXLRdNfo7UxlO7Ao3Hh9qZci+GKozCPYkluwzCSrFJDdx5Q9X1xQCUjVm4EcAgwh29osPIkg8PIjRWGaYtcOxiMTHp5gGbkuadveloRYEMz3zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nh8jZpyp; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nh8jZpyp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725500426; x=1757036426;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=VHq6roRtNY5mfSerPPDH3NGjqyeX/RIrhfNbIAX5CMk=;
  b=nh8jZpypmDoSUbROfKRsTDIbo2YIupapl+HDw1CC2UN99aEi4PxS6vAA
   MEJCGOuBBT9tciz+kAHs48L9Z9CYi2Vgdhcgt0k+xWAWEKAnADmPn1Nv5
   XzNC5qEchPL7MopqigWXX+qaNAom6SZCUo5n9BXyNl8khE00nUWqQ1rJ6
   rCQUdhaG69Nhm5fPEma6cwnWccc0gpf5wsLHok3oCOvNYxkjIMXDsWktY
   2ADesq7iBaIBYeLGHlf3TeTknHRYE++3IgSrKlaGKk0rYO06dCvxBHaAU
   gXIPZO3ueT2VXGq58nz3B2CSfkHnYlX7JgI9uej05qilEzIIIQku0IK5w
   A==;
X-CSE-ConnectionGUID: Lvl8mX3kQLKzu+xv15RsJw==
X-CSE-MsgGUID: rBRnjGeySBS+ciW+GduvOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="24351757"
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="24351757"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 18:40:25 -0700
X-CSE-ConnectionGUID: e983nUf5QXevTr9zqGD+fQ==
X-CSE-MsgGUID: IY+XU3rpTSeo+m//NWMfOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="70256796"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Sep 2024 18:40:24 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 18:40:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 18:40:23 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 4 Sep 2024 18:40:23 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Sep 2024 18:40:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r409pKGAVxFaYyZpWSFneVBc1Uomx0YU/ynk5wtgecYFJL97I4RnAholaUYCimSMVhmZ5wmnovTf0dG5soap80Hlww5JxwgKId78AuKxFEJKcq+nBulO5uqEMMeEh6ItO8iBs08WVmR5nFP/2NcETKk6cGgF7260fH7ou86MLu0RvHRfJl3iF0J1U29iPtd+s3hlJZuy8DipicufjwAQVGEraG6Kt5tnhpxbiJSXM1m3ExGS2iQ7RKvz2ZchH2bzP5hXpEPkQz5/oqfvapRhE7XmFpKKF7qnH+M4JD7eXk6L/cLTHzUEg4CEZtTaLce8zEql4tNG5ACdmi4c9awriQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VHq6roRtNY5mfSerPPDH3NGjqyeX/RIrhfNbIAX5CMk=;
 b=wUCO/j9MXoja0hrqNr6g4rzPbRcgDF572IbGahUrsm21DhwU0otHLcc4HTTMLKtnnSIRDwX3mCSFREB5SeI8+dAyx0GAAA8qpu3K1nlbs6ks0FCcNRPHLNDhFeNfJWf52heKbPW8SURszPq1sb6tf8wVjvZexX9MCGv7agMw5cRcsnTSmLVN5lEQbMwRHxfbgCgZUD0qrIv4t2dcLnZOtqXAbjbMSQ2PkECvu6gwSnCKpAV4GmHAhNRmxwoXshhtYLmzsLAJvk4s7fsx52fm0AE0xPihN2YD8YLaHEZNfr178QLRYmu7dLIr1hZawJW4c7UMCiMCjjJoBa8vL9MTdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by CO1PR11MB5108.namprd11.prod.outlook.com (2603:10b6:303:92::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 01:40:22 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d%6]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 01:40:22 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Xenomai Community Call Minutes - Sept 4, 2024
Thread-Topic: Xenomai Community Call Minutes - Sept 4, 2024
Thread-Index: AQHa/zSSHQQMZKCrd0OEwtWY+YW/ww==
Date: Thu, 5 Sep 2024 01:40:22 +0000
Message-ID: <PH7PR11MB74991CE5212F456DC69548DEF29D2@PH7PR11MB7499.namprd11.prod.outlook.com>
References: <PH7PR11MB7499F7DDE006A3A7291F61FAF27B2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749929DFFDCFE47376883636F2572@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499F4FFFC62E15096DFF8D3F2562@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749910600BAF97BCB41DC3D3F2202@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74999307830ABE8C6E622DB9F2F22@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74999CE443EE8E36CEC314FAF2F32@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74992D53E248664E6D075779F2D72@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499B96C3A6A82AEE69DC40FF2A42@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499FD09B7B037D05288165EF2B92@PH7PR11MB7499.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB7499FD09B7B037D05288165EF2B92@PH7PR11MB7499.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|CO1PR11MB5108:EE_
x-ms-office365-filtering-correlation-id: 4d9c8fa3-21ce-4104-6739-08dccd4bb4ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MFJYejB1WkUwQ3FRRmNsNGVXMllVbFFJcGZZVEkxckxicUpjTHFCQlZqLzJU?=
 =?utf-8?B?TGpRNmU1dFFNcjNCaDZpR2o4QmNVNi9HOG83NnVnQ1dnejZtMzJRNFp6T2VV?=
 =?utf-8?B?bGswc3ZzTFlDOUs2UUVoYnpubk1JL3lRU3hFR3JhS3ZWQXFNU0xUK3NBMTJi?=
 =?utf-8?B?L00zMzU4aFNFeVcxVWR2LzRMU2JyUjZZZHZWYnNQcTRZeXp4dStBRlczQ0t3?=
 =?utf-8?B?RW1BTXNVTTVuR0lCZEpvS1BaQkU5VGJqR0kvSnk1azlkcHJDdm9IUDFjSWVX?=
 =?utf-8?B?NVlmRTZlbmNkRk9GejI2WkJxVDcxOE16ZUpnbmtKSFp1cExnbUp2RE1MSml4?=
 =?utf-8?B?elVRalM2UG5Qb1JtSWRnSEV5SFd3VjRSenpuRlo5djZXKzVrVzBZNWpFYTVs?=
 =?utf-8?B?SGU2QnlOMDB1NjVVSlNtSG1QZ0ZFVWwxTHN2aFIzcG40Z3ZUczRRMm5WL2dM?=
 =?utf-8?B?QTViZ0ZUU2hTeWhQazZvQmhNcWdFbmxoZmtEZGFOeXlYbkFmN2JMaWR2TnpM?=
 =?utf-8?B?R002UVkrOEJqT2Q2ZHNDNEI4RGlhN0pZbFpMR0l3dzYzMFZ5OWRqdWZWMnQr?=
 =?utf-8?B?NXZWZ3dJaEVmVnJjWGhiSTlFUmdUbG92Rng3Mm5VVmppMi9HazdOVVJOUzlq?=
 =?utf-8?B?TXloTit1aGM5L0tseFdEVjhnbDAydFBCTCt1ODVlamJRV084a05zYWI4NThW?=
 =?utf-8?B?R3hISElhajVrV2FFNTV4NXplK2JxaDhFNXpXeklZYmN3QVE2eXVMdFlLbjRJ?=
 =?utf-8?B?bkxuS2RvMll5bVlUNHMxdWV4UStQQXEwWGZaZms0b2ZZSFFiWmEvVHF6ZXBr?=
 =?utf-8?B?dnFsYjhwMzVRWlB6WkIwbmZEQWlqcW5rTjd1UEtTVUhVeWNDK2ovSnA2Ykht?=
 =?utf-8?B?Zmd0TnlYRGMweUhRWll3Y0xuOU0yanVWaTYyYjUvU2hURno2TlpOUkhheW9K?=
 =?utf-8?B?WU02Tm13bS9RV0x6azFoQkNOWDZYTWY3MVF0T2JLWVVoLzNnQmYvaUxJWWh1?=
 =?utf-8?B?eFU0SDlvSUJYNXBFRVFqeHpxeU9mNzUzY054d3djbU1QRHFyZVB3RnJGNlVw?=
 =?utf-8?B?aGNRSGtTMVhqWDdiMTJjQ3IxM0x4OW0yM013bkhmemhKQ1BKUGZ5T1hpWG5N?=
 =?utf-8?B?RldUd3lpVUcwdzU4Wi91THVQbG8wVEJ2THhnRHhkY293TG9YTnZtUnBXb3Jm?=
 =?utf-8?B?MDhSdlAzYS9uL0lSSytCY0Mwdko4Z0Y0TmdwK2tOSm5RZElvdE5ub3B4VWY1?=
 =?utf-8?B?dGg3aTMzdmpTemcvWWgrUUdlam9HOTV2YnFuUkNpS1VzSTdVRnIxTUh1K1JG?=
 =?utf-8?B?SHdNV0tyaTZKV3ZWZitMODROd2hXK0dFcWc4aUFqRVZEdjkxd2JGZkh0bnVr?=
 =?utf-8?B?TFpVeXNJZmE5Y2FPeWk4ZUJQRWpHU24rS1EzYWpQRFlSY2hpamNZWWM5NXE1?=
 =?utf-8?B?TGU0V1VPUXllV2dOVkQvb1NtUU55RkhBZk9JRUtTajFVTzJTN2dxY0p2UGRR?=
 =?utf-8?B?YUZKS1FMQm9SY0cvWUwwb0R6YkR5dEhwN3JNOU5LbGRrczB5LzdNMFM2V0ZP?=
 =?utf-8?B?VnNHS3VUbUcxVW1TRDQ2Z2VoU2E5YSsrZ0FkZ205TVlSdUlmSE9UMFliKzc5?=
 =?utf-8?B?S0RUTkJ3U0FkQlpESGMrTkh1N0ZzcVA0bjZONVUrOHVNd1FkUjN6REpjTDEx?=
 =?utf-8?B?R1pHaFk1TFRvK0N2c2hocVlGWHBkYmNjQmp4L25TdFNTUDFjcndBVDBDOEdI?=
 =?utf-8?B?eWZVcE5mT3ZZVUpZb1l0THpOdEVsUEh1TGRBSEtia0l2Z1N3akFPWU92enNI?=
 =?utf-8?B?RFUrNlh6YlFsTzg3cGxkSkNZSFNDZ0xHNDNnYytpUjRVS25xRjBvam5xM2lE?=
 =?utf-8?B?STJUQUxLTFJ6OTJrRXZDdXBqMmdBM204ZDRxMFdJTDE3Y2c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTU4YVV0MWtrK1lSUXlOcXV1SDNaMnFhdWJGblFFMkt6VWhKaGxCcEM4SEhE?=
 =?utf-8?B?REltazFSanVSWmgxMFN3cnBTSkFJM3NkYjFCSFJUK2xyeGdsUW9KaWJFOTRG?=
 =?utf-8?B?aVRuR0pUZmU4NVJKdVhQczNZaUhJV2Q0dkhpTVhOSXZ0OC8rZ0hEY3BGejB4?=
 =?utf-8?B?RGRYOU1kK1ZGamozVHlKcXJlRWtkMzFxN0hSd3pyUEkxSFRYZjFvb3Z0TmJy?=
 =?utf-8?B?Tm5Gdk1yVks3aWZ1R09Nc0d1Qk94Y2xyNVRpeFZwQzFPTUFvZE9GeVAxUmI5?=
 =?utf-8?B?dThqbTU2UjFWbVZ5cHZMbzUwdE1qYldLd0N2OExkRUR6TFZZRDI4MnhWUXh6?=
 =?utf-8?B?N0xyNnJWcGZzSDFHMlpQOGlqMG1CMFNGNWNqaDR5eUlwZllKWUR0eXBYK0RK?=
 =?utf-8?B?N1FKemwvT2lUYWF2RkR6R1Zack8vaDhjaWlXWEhqVzdsc3dodnRSR09VbEpZ?=
 =?utf-8?B?MktYVWFQUS9oL1lmQUI2ejdQUU9hL0VTcENxTVFmVy81Tm1kVHdvN0dReDZ2?=
 =?utf-8?B?RHdTZUcySnJ1SGhIc01GcnV5VTAxdlQ1QitmdnMxbzlkYnFybi8xYWcvcFhJ?=
 =?utf-8?B?ZUt1c1M2dWJFVWt6a2YrOTFETnNaN2hFM0s0M3BET09LSWo1R3M3ZVZPekp0?=
 =?utf-8?B?eDdFNjZqYStiNTBJMkV0c0puMVBJbm9PdTJ1S3JTeWdBTmVZZS9qeGVsWWNM?=
 =?utf-8?B?bVBQVTlZTFR6L2lGTTJhUDZYNEh5QUI2Qy9xT2syckFkNHIrOTY0MGZna2ZN?=
 =?utf-8?B?UXhPbGZQSjVaSVgrUUVpVkZrWStpSklTeG9WQ3c3YlMvNFJGdlgxOEE2bXpH?=
 =?utf-8?B?RTB0M3lhL1gya0NPODcraEYrWTNKQ3V0ZU5wYnhiNDRXODdWUTZ6REFRejRu?=
 =?utf-8?B?U29Yc0R3RzVLVUlzQ1A3REtXN3RXTWJRRld2TldmSi9OY0dSNElhRUVQYVJR?=
 =?utf-8?B?K1pzOGdSTUJPT21sNU81Y2I1N3BVaFI0OVhnUkw5RldsMjhQT2NYejVadEkv?=
 =?utf-8?B?dHBjZlFFbVdvTDU4djkxdG51M3J4ZERVZ005L3EyTkx5SEdPbjJITmMzc1NB?=
 =?utf-8?B?cktKQVRCMmcycHoyNlVySk5MOExpVjhYc2NjSUhJZm9ueElFS0wxb1VjODhS?=
 =?utf-8?B?UDVWNWhGR1FVcjhwMGlldkE4elNVQzd6d2dCdkdiVFZ1VlF0dHNTWi9yZ3ll?=
 =?utf-8?B?TGVZUmJYOEU5REZQUUZLeTlrOElmdmNMWmVaK251VVVhNnFENHllV1JjZ0JJ?=
 =?utf-8?B?dDN5QksrNjREc0JEemdxb1BzQmlQWTAvODJQRHd4VWp0cDZwMjNGOFkzL05a?=
 =?utf-8?B?Q2IyY0x6NEpGNHBVakRRR1ZOd1l5T1ZGVTBTNmliSVl5YzFSdnlILzZRalBs?=
 =?utf-8?B?SlFvVG5BQkRGSitIMXk5VklUeml4V25tcnhYbDQzbVY2M2NudCttMXVqdHVH?=
 =?utf-8?B?dXR2NDF0Q2p3SEdFMlhmbDNsTG1DeE12c1BPR0lkSmZTaU9iMUg5ekF0K05h?=
 =?utf-8?B?bHRtdU94S2tsVmhuT29nWTYxdStPWHZGTHNHWElZdUVuT0ZmeldYeENJZWlo?=
 =?utf-8?B?Z085NXZEckFvTjZ5NmRnVlEyV0lHRTNNNWhWSUVpQy9NNXZkZUlzUWNTWDNF?=
 =?utf-8?B?VHVQdGVxaFc5TXVESFFsMUpNTHJLczVWaXhUK1QxcWZDMGd2SVo3eSswUjMv?=
 =?utf-8?B?VUF3T1hyMkt1MDBGY0d0M3k4c0VsY1FjTnFyRFZETzJDcFZBNysvUW1Oa3lI?=
 =?utf-8?B?YzZUZnlGZDJHOU9JdmwzYUNLUXBLVTcwMllFaUIzMWZ4Lzc0a0JEVjdpSnFJ?=
 =?utf-8?B?UCtRY1ZVeUxISVlMM1FBeFgwQi9wQXVzN1pNRzlxVDZSbTN5akoza3A0QkNQ?=
 =?utf-8?B?Zk9LR0xSVHpPNGNnbk5uMmlQQWlVU3REZkZwTnQrdXZxLzA1WWRiR2FpdTh2?=
 =?utf-8?B?QUlmdkIyMHBqaUdET3JWcjFVejIrS2c2NjUxNmdFWk83TnljSFFmZElOWGxY?=
 =?utf-8?B?VUo1VFpGTGZCSFp0Q0JLMVl1SVhrdkdJSERmUDR6RVhKS0l3QjNPMm1GdVlD?=
 =?utf-8?B?V3F3ZW9ZVHBGS3h3UXlrSFVsejZZVmhrMGkwRC9pbU5jQWN2QldTU1NhWW94?=
 =?utf-8?Q?Z6xLPuA/tj99Qf20PuSocnTU7?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d9c8fa3-21ce-4104-6739-08dccd4bb4ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2024 01:40:22.1425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ndoAqfX4syeyu6h8Yzz3XDrau+NfEsbpJO7PI3YJlas1JliP63x52/N2Su/xfnhrlvrVvvzV/vhfT8pf5hSCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5108
X-OriginatorOrg: intel.com

QXR0ZW5kZWVzOiBKYW4gS2lzemthLCBGbG9yaWFuIEJlemRla2EsIFJpY2hhcmQgV2VpbmJlcmdl
cg0KCQlEYXZpZCBPYmVyaG9sbGVuemVyLCBUb2JpYXMgU2NoYWZmbmVyLA0KCQlIYW8gTGksIEhv
bmd6aGFuIENoZW4NCg0KQ29tbXVuaXR5IHVwZGF0ZToNCgkJWGVub21haSByYWNlLWNvbmRpdGlv
biBpc3N1ZSAtLSBmaXhlZA0KCQlEb3ZldGFpbCBpbnZhbGlkIHN5c2NhbGwgbnVtYmVyIGlzc3Vl
IC0tIGZpeGVkDQoJCUNvYmFsdCBzdGFsbGluZyBpc3N1ZSBpbiBjb3JuZXIgY2FzZSAtLSBvbmdv
aW5nDQoJCUlERFAgc3R1Y2sgaXNzdWUgLS0gb25nb2luZw0KCQkNClJlZ2FyZHMNCg0KSG9uZ3po
YW4gQ2hlbg0K
