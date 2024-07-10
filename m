Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323095664
	for <xenomai@lists.linux.dev>; Wed, 10 Jul 2024 01:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720575253; cv=fail; b=PrklxcBQQfL9JPEvaibMXegLOgBvNQW4Y8v8q9j+0dBLHJzbTKEURrQwK7MC/k2vR0p4qcqQknENsfFGu9wGYWt6j+Og/la0l4QBQTZScdsVucQyyT/SY08lZwfnXq+3SK83SrEGqSUmGgxy4/SHoLVMNMyBjvgAPcGBvN4STJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720575253; c=relaxed/simple;
	bh=HRX+Jadq42IOEGiSmtFJGIGKLoUrgYI3XbBZfhIfg0A=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uZ4kZo8VVrnfp6tut386BDEFYG17ORVURu454fV7swizSUt5qc/nxZs23ReGlx78pzcMLpP5ABFsJmbf75aUyH8Z7HJSpjbjZzaTEOar3A4h/55Bymq7um3XxGEQxZ9pXvZWZ2cS5GepIxmk21b3Y0//l6EefiIPt9OI0A+ZnOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DU1Dsft3; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DU1Dsft3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720575251; x=1752111251;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=HRX+Jadq42IOEGiSmtFJGIGKLoUrgYI3XbBZfhIfg0A=;
  b=DU1Dsft3E9eZDo4uvxsS5cTGnS3V9M8LRgK58FCOsL8ivFUCeeGhfCSx
   A+ERSQd/dlyx/Kg3JPYDxnPB6Kmr4pe24QYjFa4rtQ6haAoUgJua3i4Ie
   lAlHhG6PJFQxcoOQVuar/uJ7NPa5YuWLQHzVKHg14Nvo2mOmfmqj/pGHe
   3/ydG2r3s0CSZAnbbZE4ZjhZqgn2sXzv7q2SnDb9RKyuD+4sH9qEgc+LS
   /H3QVKDsmqMnGkHe5btpcMp6IaaEfsjUQm06gj7lT6xeB3BqEVtGX4fgq
   GLUPnmxKyX/yyNaaI8pCXUlE4RT2NSjVTw92cG8nd6ZED5CTk6DlTmZ5F
   A==;
X-CSE-ConnectionGUID: h9J8eSNoR6ekndc8FaccbA==
X-CSE-MsgGUID: u1wLAAhaSB6rf6Vl6m52Jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="17705181"
X-IronPort-AV: E=Sophos;i="6.09,196,1716274800"; 
   d="scan'208";a="17705181"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 18:34:09 -0700
X-CSE-ConnectionGUID: L1TFdiRRSaKhvU80/RlHtA==
X-CSE-MsgGUID: tA0+/Q3+Roed93mGbobcWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,196,1716274800"; 
   d="scan'208";a="47919589"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jul 2024 18:34:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 18:34:08 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 9 Jul 2024 18:34:08 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 9 Jul 2024 18:34:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzaPRN4KYEEg26VRgDeKpt7VQ63Su5wOK3wd/mULGpfNJD5t4kq1WiWs7uShtqIPSKtVKmOHnRwMXkTrerssWKKifummrkfJHF9+P3NcnhyV6PtS7F5S7fcxwtsqch/af2psWneaWmHHnm9kWxq0ytx8jTF/hOrosh9khNqucUBsw7kQxO34XyZ5kkoZan3D2/U26U5FNKEp8u5m3NXOPBknOEB5AGw87edDFCzgcqWj01DzYn2acNpbmI1bgelsb9T5B3mP3XJolq/2UZAkCsbiJj1XYa8iEYG1pl+X5fGicBfiPQWLa9OE2/pQu4+QYOIz38ZncZ4k0mB3ykfU5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRX+Jadq42IOEGiSmtFJGIGKLoUrgYI3XbBZfhIfg0A=;
 b=FZb0xgYsA9pQ0zwejcvVIq2QDL52oS81RHHOEKwQK0jkJpvyWYSTklO/JxwWbD6Keu325hg2AjJq94ueY+/BzN2gb+rFRg3LGMAG0EbMHqf1NxLwZKNyfmipmpfjVIhDtkJHx/8WjVs5dMIBBgzGmeIO4U4aR8Nh5HAgM0h7zA5wBxjl7p5Kk9Cc0vEfOFEG3SQeyNWsDBntE11XozwP52vGFR3hnRKg8awdzB5PV8C8GwHRuzsdUeiMkCtmyeTkostO/NIbeEN5z6hq5q5FHq1EgGBsE77OOCnqRUHLEorZHNgTG7IlwsGJSlXoQFgR9xbQdjfTsqQgD5Za+ScAAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by MW3PR11MB4602.namprd11.prod.outlook.com (2603:10b6:303:52::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 01:34:05 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d%6]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 01:34:05 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday,  Jul 10, 2024, UTC
 7:00 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday,  Jul 10, 2024,
 UTC 7:00 AM
Thread-Index: AQHa0mlA3z4OGlZDB0qXoJ4rw3+drQ==
Date: Wed, 10 Jul 2024 01:34:05 +0000
Message-ID: <PH7PR11MB7499161719AD2EC0D1651C48F2A42@PH7PR11MB7499.namprd11.prod.outlook.com>
References: <PH7PR11MB7499F7DDE006A3A7291F61FAF27B2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749929DFFDCFE47376883636F2572@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749988D3E2C96C4F21DAEBE4F2212@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499C4BB71E159B3AB98D686F2332@PH7PR11MB7499.namprd11.prod.outlook.com>
 <DS0PR11MB7482613E8A9D78229EA71D07F2EC2@DS0PR11MB7482.namprd11.prod.outlook.com>
 <PH7PR11MB74993A52AA247D08069980E4F2F22@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499D816A0B79C85EF7CD712F2D62@PH7PR11MB7499.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB7499D816A0B79C85EF7CD712F2D62@PH7PR11MB7499.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|MW3PR11MB4602:EE_
x-ms-office365-filtering-correlation-id: c3f7798b-dac2-4ea6-a982-08dca08062c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bTk0eFd0YnY5d1V0MVQvQkdVeG5hSTkwVjhFNXgwRG5GSGorVVY2Z1BHb2ZL?=
 =?utf-8?B?cjIybFcrM3FLTlZ1QjlybWozOThBck04SUtvVmlXTUwyNGNoaVZ2SkJ4Q0N1?=
 =?utf-8?B?WExSNVd4dUFkbXlYWlJPd1p1K2RzbEVhQXl2RTNYNkpaMk1KSlYyTmJPRjJX?=
 =?utf-8?B?WnFiSnB2MnNZQzJreDVHYXEyanQ4amhFNlp4UjFSak9zeXREVnJVdDQxb3Ja?=
 =?utf-8?B?T2FnTjRGb2NGZlBoUlJOdFVFcHVWT2M5clZkbHBmWXVOaVljMGpZNGtrVHIz?=
 =?utf-8?B?Q0NhVitFaUVzdGN0d3JHYysrZU5EMy94eTdRY1ArUEdJUElhSXZzV2ZxT0xa?=
 =?utf-8?B?M3VqdnVLQUc5ZEtlSDRxaURUYXJsWjIzbzFVMGsvM0t5ZHJtSDdsMTV5K0M0?=
 =?utf-8?B?TGxkRXgxY0Z5Zm9nYUNoUFlSU3ZGL3djcVEvTjd6MW1ScWdBTGhjN21rMEhM?=
 =?utf-8?B?MnJRZXR5cHJPWHd5NzFPVExneThNUUZMYm9JVThEbnF3R0tlSDNzSkNyMEZW?=
 =?utf-8?B?cnpyNnE4dDNUUFNUNTYxNHEyYy9ySytSVXBrSE03bUN5OEpnVyszeGlvWUVW?=
 =?utf-8?B?N1RHZXl0L3hpbkNaalRjQ3FvL3pOQTVQNHBqQ29kS295bHFTbEJxMjllcW5K?=
 =?utf-8?B?ZXJYN2x0TERPLzJwaHdacGdEQWxqNkMwcFdTRmZwVnlEd3lCMkdIZzYxQ0Jx?=
 =?utf-8?B?b3pVeVpxR0x5NWZzTldLQnkxMXZoNFlHb2xtVnB2QVd0NGFTWGZBL0lhQ3Zi?=
 =?utf-8?B?c0V3eWxxUVV2WTRSSXN0Q1JxcFI2aG5IQW81MVdBZWNXcjVHaWJldHNFb3Jn?=
 =?utf-8?B?OE0wY2JvT0NjRERnczNKbkhseFd1TVlRTDk0M1hET0xHV0lWbDNNUkk4SDgy?=
 =?utf-8?B?UnRhM0tqU1VKdVNrM1J3Nm9CZXJHa1Nybkc1WlNjTWdJZjJRNzVGN1lNQ3Ji?=
 =?utf-8?B?OEZTTTZhaHlFSzIySHVrZGJhTXpBY2dLNUhLQjFycVBtZXp3OWJaclc4YmVx?=
 =?utf-8?B?Z3Q1RXNKdHVHR2doUGZsUU1VMGZKYU9manVnejMyamwzYmxUVFI3VU5GdUNl?=
 =?utf-8?B?OFZINmc2VUVhT3ZLZHN1bmdLbUtPQ2JFbEhSQ3FMbW1wNWRkQUxzTVBZakFN?=
 =?utf-8?B?Z2RHc2V0U3FORkpNUDc4S1FGMU80S0FHbjR5OW00b1ZVakF3L29lYXB5Qkdn?=
 =?utf-8?B?ZFBsNjg1YlZYaG9Zd2hjV0E5UFJwYW01RlRvRkxSd0szMURvMWkwVkJWekFx?=
 =?utf-8?B?SlFDV09FdmVGL2VyUmwzczFaUnYzZkFSTEVXKzZ1RHFrSGhWWHdqNkRMRjh4?=
 =?utf-8?B?T3IrWi9GaUtPbVJZY2h1VkdoYysreEtoR2lRTVRLM3RZanFHeUpuSHlvTVhS?=
 =?utf-8?B?WUdOQnVjcUxzM0NYNVgxWVVJTGxJQjFWYWhXeDlOcHJQa00xc2FWQXRxOEJJ?=
 =?utf-8?B?RUJRa2V0S0JoMFM0aHNkRzJGTFc0RHpwcjhDY1BkaXNFMnQ0VTVkNkZaSXNF?=
 =?utf-8?B?cGUrMHU5K0FKckRpdEFWQk9NMTRMNjZ6aXE0NE1lWnhVS0ZFRHJ5TXh4dHBm?=
 =?utf-8?B?NlpqMGZ6OFJxRzJnK1dQdEpSbUcyNTlIc1lFSGhTRkhhd3pCOHdrUDFneVIw?=
 =?utf-8?B?QW1MRThsUE5EbEFhYzRzZlBlaG02SDJMcW82YmJGL3gwNTFkQXNsa2pZQzBO?=
 =?utf-8?B?UTl6RTN3d3pBUnhrbFdLcUhYeDdaOWZWRUJuQmpDYmo3NjQ5SVFqU2N2MjRt?=
 =?utf-8?B?enBmVEE0a0RVWW80ZTkrN3Z4V1pSM3hoSGY3Q0lvVHltQ1RKZjdkZHQvYkFC?=
 =?utf-8?Q?tKyLXdN8GkgGoU4CtgcfxZME2WRSyuy4ErxVs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UEVEQlFGTWNHL2hTbXc4cllxTWg2cVN1N280dmhSMGQ0c3drS3doZEdzc0Fj?=
 =?utf-8?B?V1g5ak83cGRWM3RTWWRnME81NkNBZjVnaG96L2puZXhnMTF2K05WbDNCeWpM?=
 =?utf-8?B?WkVya0NqZEZqZkhLYnNsNFBpeCt2Z3g2bG9ORnRyYldYU1ZENVFHZEJ0ekNr?=
 =?utf-8?B?YXllNXdGT2dhUzdRcGdBRFgrY05acmZyL1BKZnRhRUJ5a3FYVXN3NSt0S1oz?=
 =?utf-8?B?STJrL3JjbGlaVHpwVy8ydi9jUEYvZ2I2d0orcnArMEZpMU5tb0lSS2JEMUVY?=
 =?utf-8?B?SzBuUHNoa1hDTm4rZ3BwWU5tSTFXZFVNN1lpY0tuNW1HUTNvdFlQUU9HRUlN?=
 =?utf-8?B?T2U0Z3FuVVRjMFNMTjdwQi9lUDBXZXIzTlRHak91UjRJc2ZQeDJYbkFrYlRi?=
 =?utf-8?B?MlZIUXpSNTNWcyt2aHlvSmhiMW5FWFVFNXZkZWVqRVpvQ0pIcEhHTU92a09J?=
 =?utf-8?B?cnQwWDJKWGZ3V2gybXh4WjBIODljTTQybHovdEVRWnJuWkEvbjRrSHpQVURV?=
 =?utf-8?B?NFVuYlBWVWJPUnBsM0ZoR3NqeVowVXdQZG16Y0xGOTVoUHFZdjk5U3lpWFhr?=
 =?utf-8?B?SllvZFE4UWJBSmk5UjJzQlRTdmJocTlCK29DVXV1dlJjVzNibFBBWVpmL0lZ?=
 =?utf-8?B?TlY0ZVdycUJJa0l0aE1hTktpdjcwNnFZNzJPQWJOVi9ZVU9panhjZllkaUJQ?=
 =?utf-8?B?UDlRSFJGekE1ZVhZNFVEaGJLSnZ1Zml0WU42WjNZeFVEdzJRRnJyZnVVM29L?=
 =?utf-8?B?OUR6M2NEQ1pXbVJVT3pramFOQldVdVY4YWtVR2U0RzZpN1ZmNnhOREJmM0Vt?=
 =?utf-8?B?bWpBTnJ5amxDRkNGOG4xK2ZQK21pSVJLWEM3WndLM01LSDJFRCtvcXhEbzlp?=
 =?utf-8?B?U2N0Y2dDdFFLTktmWkpuNnpZOElzeG51WW9PTWpGS0paeU5mSzQraURla2ww?=
 =?utf-8?B?cUFDd3BiNmVFMW8xdXFjbHpBMG5rWlR6amF6UWVMNTVIVXJaSENxRTF1VHVS?=
 =?utf-8?B?SjIzOW1TellZSGQvSEdhSks5SW9tNTA3dmdLU29SYVh0eC9NTXNqMDdDTjRK?=
 =?utf-8?B?clpveHkwQVhuc2dvT1VnQ1FldGFMNUwycnlLNmlERWJSdi9KcTVpTU85WGpu?=
 =?utf-8?B?ZDY3R3RFUC9obDdPUFlPM25CYmxwUVRqVzdBaXE0UWdaME85NE12OGNCWENy?=
 =?utf-8?B?aDBYZEVMZ056UWpNN1NLejQ3VE1MK3JoKzZQNTR6UmJQM2t5YTBGSFVpVllj?=
 =?utf-8?B?TW5MZHhENHBNWkUxeWIxcndBNElyVW4vYVpEUU9TeDBVUEwrUmxIMS9VTUxx?=
 =?utf-8?B?Qk9tdlFKZ01hZm5yaEN0Q2dIM21HVE02SjREaU9oUUtjeXNKcU44bWFLZG5m?=
 =?utf-8?B?TEV1ajUwVHk4SnBmSVUwbEdlMEp3Rlowa3h0UFVnOU5NMnJodVlNeDVoSzR4?=
 =?utf-8?B?RThNRGNsSXB6RVVoSE5wbXdWQUxUTVMxdS9pYnJrbm4xbjRxejMwQ2JYNHRs?=
 =?utf-8?B?OFpQeUo4RmE4NERlN0c1SitJRW1WMmVaYy83c3R3NCtrWnpTNWRaU1J0TkVB?=
 =?utf-8?B?NHc0Z3NNQXVMaVZ2ZVJraFI3azd2SEYyU3B4bUp0aXR4VWh5OFZXTVlJQmJN?=
 =?utf-8?B?S1A1M1BUQkU0Q0RaWXVrcVFMVm9PVTJ1WlZRcXdraER5L0x2ODBwNG0zTHB6?=
 =?utf-8?B?Rjh1MVNSajhpNnNISmo1WDBOVVpLNmpnU1I0Q0w5N3MwNkgwVHBTekdpenJT?=
 =?utf-8?B?a1NuQ1hBazdpTnBQSXlJMGI2cEs0Q2I3UmJnNVUzZnFRNGFHbTdlWnFtTFha?=
 =?utf-8?B?aUJpVjRxcitOYmd0Y2c2MWNXd3Y5SCtMZ0gwZUJ0YlFxREYrc3doOXRuTmdO?=
 =?utf-8?B?NnB6dHBVYUV4YVhHcGxNVitzVFNUTWhTTlN5L0xsRW43THZPQ1NSYkI3S2NZ?=
 =?utf-8?B?bE9OTDE0aCtSQjV2QUFmWlpGYXlQcUxhczRibFVHaHRVYytxSTJqaFU2cDRk?=
 =?utf-8?B?WVBPYWlTbWhMckFSTGdKcWZRSmtkeGxXOUxBOHBDMS94RnBqRkxlMTJyYzlL?=
 =?utf-8?B?dzZTeGx2RmZKeTZWZG9FdWlrWExUQlJXK3l1VW5wNk9JcC82UFYvY0ZWdTJP?=
 =?utf-8?Q?WSEZofjBEMZ2uuKOyI4v2kjlC?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c3f7798b-dac2-4ea6-a982-08dca08062c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 01:34:05.2557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JWMpf3n/I1t2dhkwLqP377mU44URPdo+FdDTxuklPr/fsm14xomiuGp0pcKCw8uSG+vMtxTl+VFwrDZZXa+Fxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4602
X-OriginatorOrg: intel.com

VG9waWNzIG1heSBpbmNsdWRlIGJ1dCBhcmUgbm90IGxpbWl0ZWQgdG8gdXBzdHJlYW0vZG93bnN0
cmVhbSBwcm9qZWN0IA0KcGxhbnMsIHN0YXR1cyB1cGRhdGVzLCBhbmQgdGVjaG5pY2FsIGRpc2N1
c3Npb25zLiBJdCdzIGFuIG9wZW4gb25saW5lIA0KbWVldGluZyB0aGF0IGFueW9uZSBjYW4gam9p
biBhbmQgYXNrIHF1ZXN0aW9ucy4NCg0KVGltZToNCldlZG5lc2RheSwgSnVsIDEwLCAyMDI0LCBV
VEMgNzowMCBBTQ0KUGFyaXMsIEZyYW5jZSBDRVNUIDk6MDAgQU0NCkNoaW5hIENTVCAzOjAwIFBN
DQoNCkpvaW4gWm9vbSBNZWV0aW5nIA0KaHR0cHM6Ly9pbnRlbC56b29tLnVzL2ovOTEyOTcyNzky
Njk/cHdkPVdtZHdTMHBET0RSTk1TOXRRazU0WTFkdmJGbHFVVDA5DQpPcg0KaHR0cHM6Ly9pbnRl
bC56b29tLnVzL3djL2pvaW4vOTEyOTcyNzkyNjk/d3BrPXdjcGs1MmE5Zjk2ZDk4OWU3ZTIwYjYy
OGMyYzM2ZTQ4YjY4ZQ0KDQpNZWV0aW5nIElEOiA5MTIgOTcyNyA5MjY5DQpQYXNzY29kZTogMzY3
NTI4DQoNCg0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQo=
