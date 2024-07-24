Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39E428FA
	for <xenomai@lists.linux.dev>; Wed, 24 Jul 2024 01:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721785193; cv=fail; b=s9w+ivV4afLndo1o6e3Jxh6tzwqB93i8AFCgvrWLsyswFtA33exyamwPBmXoZopmpqZFElfHjiORCfU/BnCMIW2CkPAfzxorDYcUqIJgsXC1dfMWFc81DIDhS6Eali5s3buE4cbm6bN9wO8+QQrQOX0JJkvmSWEdVKivK7XrNaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721785193; c=relaxed/simple;
	bh=Jc78ByjRvnwwcL2QtCr1b66ohZeb7bg1y2ZIkKK2EgI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=daC0tyyOudd9sBaHmVnmwGnLkTmNqnD6EvWoAp3C09idNs9MVrNFXh8XlCcCTQtaRO7YJbAaRkV8X0HszMqfNlVn2IW7dM2VbbSGdLBatG/GTeRuvagn6jgtcF6OusbniYlHxt/VeQSjymh9+Fhytw8zs63m8hIMSnvgT4Qg9Nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CyBNXB5X; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CyBNXB5X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721785193; x=1753321193;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=Jc78ByjRvnwwcL2QtCr1b66ohZeb7bg1y2ZIkKK2EgI=;
  b=CyBNXB5XnYuw2qC9Y/oxvDbHXg7nNb5cAugCrOPg78AkA884Woucwsxf
   EzCo+FO+jZ4U+fAbG1c/8hRskcBeDmtrVAnc8K/zU8tPo3nC52ehLEaaQ
   H+Tgr6rsLGgTjUKrPQnL2umnfI0zWm7nWDdhy+ZzYyCqei4QDH1WnHVsU
   9TPVvfZLAiz9cxVTtwPm5UBhnB6yNsehGEtne4ZO/1Yp3YPd81JniD/Gz
   ouvR/tUC0GAaOHdONnEVv5HyqJvQv4s4dQMfFy2gAuUPBfLigz/3fWiHA
   sTABbcxGpTa6VMax+k81DqdqfGq5j+2VbT8O/hnjhTvir3jI+r9G6CfYE
   Q==;
X-CSE-ConnectionGUID: OMrRCSA+QXS6mqQ8/FTQGQ==
X-CSE-MsgGUID: n12BNn0LQyuA3N4F2lIJ2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="30820744"
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="30820744"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 18:39:52 -0700
X-CSE-ConnectionGUID: Z7a2fVLZQWCdJBvV4BTQuA==
X-CSE-MsgGUID: Jv02nXkKQ6Kv+KYhXlZMLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="52659903"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jul 2024 18:39:52 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 23 Jul 2024 18:39:50 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 23 Jul 2024 18:39:50 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 23 Jul 2024 18:39:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p8RVPt5C9BEEXW2tWTdvoLNLvrHLC/xJJqI1UF8PGbpm1HjSiBQ/j7swjQY+Ywy/9IbhNZtaQxMFng8zG2nbypwJuolxwPJ9piGw0AZ056lHanm9QAAyWKok9guHleFr0LUgbXCqFfg5LXiLBJrRdo5UWc+Plhn8OhqBtqDevHIqyLL8nFwzoLWUqzNIYoznxOo6IGlr2aMs5cGGVa/atcRwWVMgN1b184T4S1onJzwAuhdU66DvKH3yCBYOVH8HTf0VsiqKBNBzxA7UIBGPWOiVkSX3a+yNM2VIYFHDl8g1XLpX0DWTcwb77Gdv3iiu3W0bzWchYr2GB2yW4Dymrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jc78ByjRvnwwcL2QtCr1b66ohZeb7bg1y2ZIkKK2EgI=;
 b=KzxAHJ3iPiwkjYDJEc7Dojjp4sc9XJr5NcjD41JDj7jh5n7QwcetbuL6KdIwc/FLn0KZTj4Eq9kfikRVgAJ03SgwHwv6hOhWRC8YgooHuf5GOf4+jGrl9oqc1A+qZb1zOSAmRxzyHf1wWrZux9vX+EyAlgM+PnUb58Hgvh6JfmU+1YWkUX+uGGPqW1dZASx5SH0eCfqt6O+tBhvYOo6v8NGCXB0ZIQAEeRBeOloaZpt5BPoPuB6ICZScY5pSLWoWzglEmxl1oqrtB2qrS1cKixtrJVj9vtsy4viA7AyEZYpCR99qd4aXzNvYEdTalX4A1dEj+VfwkXScDVbW7/Cwmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7482.namprd11.prod.outlook.com (2603:10b6:8:14a::17)
 by DM6PR11MB4530.namprd11.prod.outlook.com (2603:10b6:5:2a4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Wed, 24 Jul
 2024 01:39:42 +0000
Received: from DS0PR11MB7482.namprd11.prod.outlook.com
 ([fe80::a9d0:ca45:17d:4abd]) by DS0PR11MB7482.namprd11.prod.outlook.com
 ([fe80::a9d0:ca45:17d:4abd%5]) with mapi id 15.20.7762.027; Wed, 24 Jul 2024
 01:39:40 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday,  Jul 24, 2024, UTC
 7:00 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday,  Jul 24, 2024,
 UTC 7:00 AM
Thread-Index: AQHa3WpaGemTk9E50UK2WkRtFUF3qQ==
Date: Wed, 24 Jul 2024 01:39:40 +0000
Message-ID: <DS0PR11MB7482106CBDA92B4A595D7363F2AA2@DS0PR11MB7482.namprd11.prod.outlook.com>
References: <PH7PR11MB7499F7DDE006A3A7291F61FAF27B2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749929DFFDCFE47376883636F2572@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749988D3E2C96C4F21DAEBE4F2212@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499C4BB71E159B3AB98D686F2332@PH7PR11MB7499.namprd11.prod.outlook.com>
 <DS0PR11MB7482613E8A9D78229EA71D07F2EC2@DS0PR11MB7482.namprd11.prod.outlook.com>
 <PH7PR11MB74993A52AA247D08069980E4F2F22@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499D816A0B79C85EF7CD712F2D62@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499161719AD2EC0D1651C48F2A42@PH7PR11MB7499.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB7499161719AD2EC0D1651C48F2A42@PH7PR11MB7499.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7482:EE_|DM6PR11MB4530:EE_
x-ms-office365-filtering-correlation-id: 346d2958-eab6-483f-1ecc-08dcab817c9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?L0Q3L1lxdENaQ1FZWDk4ZHBCSDJyWmdUU1EyM0luaWFRSk5DVTZabHQ0UVNH?=
 =?utf-8?B?cWZGbU1pVzlIVzIrSXludEpncGNOci9XVkV1enNiRXFrR0Jkb3BRNDkyU0tQ?=
 =?utf-8?B?MU14d1BubGhNWVJaUW5VVFlZdCt2WHFTc012ZnIzVm5NblVuMkFiVUFSQWJx?=
 =?utf-8?B?Tm9GenlRbzVVNnlkbHY1WmF6V0VnR3N3VHAxaUYwYi96N3Jhc1kyTnNRM2U3?=
 =?utf-8?B?ekw3amZxR1pEYWQrMnhCN3hiR0pFdjJSNXRLeHBNbmVPYnRKYkFPR3JwaE4y?=
 =?utf-8?B?KzU5aVR3UW0wdHgxNDlwd3djci9hb2pCS0dSOXBhME04alM0SEVTdjgyUytt?=
 =?utf-8?B?MzNHYW1hdzE1bHQ3dzNvOHVraEkrbVJhaE16bmZ3Y0ZKUlhMYW1BWkkxeXpL?=
 =?utf-8?B?ZktwT01FcGZFNWxnZ2QzV1p5Umd5bmx5MkEzLy9aWnZGdnZLSnRncDY4N05z?=
 =?utf-8?B?YWlpcU1yY2xycjcxWi9ieVMyNUNqWmljNXhSNU9UZ3hvcnREWUF3Z0NvZzA1?=
 =?utf-8?B?TFQwbjRHd0hOTk9ha0tBc1lBeU1rYVpXR3RIUDNGeWhJZHh4dmh2TGIybjJq?=
 =?utf-8?B?R3BnMTVUcW1OUGFYNnBESWpnNHFPUC9WaFFSMmpiUmNVbGVnTU9wbUhmNHZL?=
 =?utf-8?B?N2tJdzlVQkJDOGFFdVJ2RE5lY1IreG9EWFc5enk4RE15TG5MUzdJSGtUbWhy?=
 =?utf-8?B?MEdsN256TzViV003S0dMdTNlYS9FdFU0bmx2Um1yQytkTVFTTnErVFZSaEhw?=
 =?utf-8?B?TXhzR0YrYUFqVk9GR25DVzhsVlN2MkswWGMzdTNneWJpV0JJKy9ndTNNK0NF?=
 =?utf-8?B?SDlybkJmWjN1c2g0NTdPWm9sRnNUWkliT0Jsb2JVMU9ybEt0MmtXb0VlRloz?=
 =?utf-8?B?NzZEKy9WTHk5UXRybnRhWnVpcGpGNUI4UUcxZ0RwazM4ejQ2dmdvYUdXQkhp?=
 =?utf-8?B?Wi94a0t1d2xyYzkvUkNzTy9ydTdyQTl6N3ZzMDlKYkkrYXZaMEZSS0E3QVY1?=
 =?utf-8?B?VDRyb2FyQ1hidGY0WGpBQzQwWWF2LzZTWHpKVzF2RVNkVU1vZ2lLSUROQWtT?=
 =?utf-8?B?QWl6RUlEWVh2aWIrb1MrekIzamhiUnloVUxMR2ROTktXc0VQdGtFa2UwMy9j?=
 =?utf-8?B?cTY2TjdENXdTUURPc3UzUXpwS0N4TG5jSHJSa3dHU2doZmk0L1o5UktRTUFO?=
 =?utf-8?B?ZTRFNzNQYkIzU1FSYWNuMC80a3V5MWNBb09uQ1R1MEw2Mkl1SlU2TklRRzlq?=
 =?utf-8?B?aTB2NUlpNjRLbks4b3AwMS9lR1pUVjlnZml3Q0FMbHcwWEFvMjViS2UrbFkv?=
 =?utf-8?B?OWFaeXl5WnJCd0pxY2g1dEY2Zk9NUTRzdUNiS0JvN1ZxN0dZQnFoU05sbklu?=
 =?utf-8?B?S0x0UnJ0c3RQajVqb3VhZW8xUE9uZi9HdWZWU05OUzJiV1l1eUZKWG1sL0hE?=
 =?utf-8?B?ZnZZK1dYeUpaS1JBK0QzT2h0SVFsTkFMNG1YaXFvbHJ2bEl0d0dsTDJEcnFQ?=
 =?utf-8?B?cmJ4NzhZczNpWk5zRWFyNURVdHhTTWt0Qmlja2Q3UzZZNFBHWUhYVXB0UGNt?=
 =?utf-8?B?b1lKTm1FVVRlM3owNnN1MWN5UCs5L2VtN0c0TjBNUzdBUStVWGZLbmo2eUxt?=
 =?utf-8?B?bXlVVi9ZQVNFUlZzK3MvL2prN3lsUnVIUU91YW1WNGdQZXZoV1JpeFNZSno1?=
 =?utf-8?B?MjU1c3BXd3R0OU84Q3JjS0x3QkFWc2ZvOWVDa0krWjBUZEhPNTlVNXpzYkpx?=
 =?utf-8?B?b1JjVVp1ZHlSc0VqK08zOGdYRUE3QkI4b1I1WThpcHNxNWgxYzNTWlNVK1dJ?=
 =?utf-8?Q?FT3BW6oIjaTEDuyftBnlaUmgFGgXcLCXU2T0Q=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7482.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amtQNWQ5VmpQVDFhb0toOUZnM3R0cXk4S2N1TkxibnlST2ErUU5LYzJNWU5a?=
 =?utf-8?B?QWRtVFlsZEZ1V01YbkloN0pOalJEcWFhUkp3RVdsa0xQc1psYlNYcGtvcCtP?=
 =?utf-8?B?UjFtenM1Y3NiUkRwQ2w5Njd3cnBxem5CR1VZM0hKS1JnbXJKNWNST3Z0N1dJ?=
 =?utf-8?B?eitPMjRFZUR0YTRmNE1Lb2dFcjRYbGRReUNGWXpDa1JRYytaRHAydFQ4ZEZY?=
 =?utf-8?B?UnZ5azBYSmY4TFh6ZUp4OGpFQjdQM2UyYVZ1SWtibkNsQ2lMNUxqU2Z4UC9R?=
 =?utf-8?B?SE8zcHFIR1dpVUI3NG5lTTNSdFNWMEpUS2N4c0JreHVwV3lnSGszMlJzdHc2?=
 =?utf-8?B?NG5BSktVNXFEcFpSaUxzNXpsMVhab0trOFN3UGNuUWdEc0JrTWNOQ25Zak9O?=
 =?utf-8?B?alJMZUplNjhwVlVlQ2pzaHdPZy9LTncrT1EwTjBMU1MrMnVlMUJDYS93cEZK?=
 =?utf-8?B?bTV2L2tXU0EzTVorT21QQzExUi9MZmxTaXBmbDBpYndITW1URkxzQ01vTXlR?=
 =?utf-8?B?Y2Q5aUJUR3JlUUpsbW5semdxQWR0M3l4YUQ0VFZrcXZUM2tGZjdrdDFrRUcr?=
 =?utf-8?B?b2NuSWNJa0NaQ1B6YXFEaGlvdC9pRmdOSFJOZnNLTCtZWC9ocmdYekNQOXN4?=
 =?utf-8?B?N1RWakxQUFZvcVFCbWFQaFBSSHVDblluMGF0K3lYSXUzZk5pRGk3K1U4bkx3?=
 =?utf-8?B?RUg4NGcwVCtQY2lXbG0rOERmcXE5NFFPNFcxZlhoZE0wa3dpYkRTaEdtclpE?=
 =?utf-8?B?bDJpcDdheDJYVDJ4c3RiSy9WYXhjaDR2TmgxYWFTcUtXcmtkbVkrd3NMSVdk?=
 =?utf-8?B?SmNBVGdVZmxSMTBBV1RpTnppNW1XWnFlZ1hTVldQRy9Hd2V6U1FyYVRoMmZQ?=
 =?utf-8?B?RkpkZGk3ZnV0MEJ3bUZtM0VWaDEyb3JNSWhock5ycVk3Z2poaVdZYVpVRXhz?=
 =?utf-8?B?L0lTK1dUeGpHU2hBZTdFaHlnbzk0SGtvRUJtZ3g3dVJOaHgvNTVBMU9ObnFF?=
 =?utf-8?B?dUs1b1dZNmdudFAwT0U4RkpHWmJXeXc4aGdiKzhvek5UZkRvS04rS3RETGty?=
 =?utf-8?B?TWNvenEwTmlhcnFQTlVrMDRGSFRnUDNydjU1VDZZTVhQSEl5Vzk5Z3NjdXdy?=
 =?utf-8?B?UXRYQlZLdlVmTXlCUzJmVWFicmdyT3BkbU1tQzhzQnFxV3BuTVZWNytBN3E4?=
 =?utf-8?B?R3pFOWg3Yjk5ZmdGZ1VadkNpTVpoRC80b3BhNDBhK3UrRlEwVDAvZ0F2eVYr?=
 =?utf-8?B?aXB0b2s3N2FDUnhnWmJkWUpvL1QzQ25qRXcxYityWEYrQWtoL2pBeWU5QSt0?=
 =?utf-8?B?VGRhNjNuRmsvSVhtZ2tGODFSVklEZStwUEViTzhFalM0MVRTWlphUjRzK1ZZ?=
 =?utf-8?B?TlJDSUVoYzdSMEsxMkU5aGRWcThSZnNVVDhCdDZVTW9lZldTU2dkTG8rZW1K?=
 =?utf-8?B?NnlOWkpMZjNtd1RLZkpYTVNRNDE3UDExWUc1TkpCUkNDdTA1Q1l5OWlidnFn?=
 =?utf-8?B?UnorbGZNWExaVEVncmRZMHhWcWZpczE5bDU1N3BNalRQT1JReDlzT094NkRn?=
 =?utf-8?B?WVJoYlE3ZnF3QmdrblVjdHhvajgxVWxlNkFBMzQ5ZHVYRmRYcXNacitJL1Z0?=
 =?utf-8?B?aDJycEZDTEJPc0wzVWpreHQyby9oM3hiMVZpb2hWNnNxQVJnTlk1ZkFPd0F4?=
 =?utf-8?B?Qzh1YzNUSzVVQjhwajIxTGl4Z1ByeWZVZ091NVhtdlhmYmM3WU8rWEFrQ0Ru?=
 =?utf-8?B?dDlkazBiMmFXUlkxS09oWmR4WGRDRXArMHd4T0UrZUc5TlBPTzcrWXVKZ3pD?=
 =?utf-8?B?bHl4Y2hLZFZHTDBzS0wzZ2EwRVJYNHREUXZzOUgxaTJMWDcrMlQ2TmVDay9l?=
 =?utf-8?B?NWlhaGZXNG0vd3VjVVc0NmtibE1mUE5oME0rbGNKVGJHdjFwVk9KYmx3Y1FO?=
 =?utf-8?B?TGc0ZmJIOGp6a2dHTE1iRGVUaFFUMnVBQlQ4OURvNE1SKzFLQWYrNWF2cGR5?=
 =?utf-8?B?c3Q4Mmx3bWQwWUZvdFg1bnlzbUFiYmtackdmRFowTDNDZ1lublNraGhpVzdw?=
 =?utf-8?B?WVFtWGFpcmozU3VlWDBmbUF0MmtQY1ZidVpHVkRZUjgvZGNrWkpRMlYvYjN6?=
 =?utf-8?Q?izAWmOPRuCn8DG+FGDPWoMZ56?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 346d2958-eab6-483f-1ecc-08dcab817c9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2024 01:39:40.9343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RQbhxgOt3GeiduBFVR8qZAzWggNQcQ8+PM/DtKjjTTUOdUZJi6kvNR7pJBTli5NlMI2ya7RUwfD46v6T122+Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4530
X-OriginatorOrg: intel.com

DQpUb3BpY3MgbWF5IGluY2x1ZGUgYnV0IGFyZSBub3QgbGltaXRlZCB0byB1cHN0cmVhbS9kb3du
c3RyZWFtIHByb2plY3QgDQpwbGFucywgc3RhdHVzIHVwZGF0ZXMsIGFuZCB0ZWNobmljYWwgZGlz
Y3Vzc2lvbnMuIEl0J3MgYW4gb3BlbiBvbmxpbmUgDQptZWV0aW5nIHRoYXQgYW55b25lIGNhbiBq
b2luIGFuZCBhc2sgcXVlc3Rpb25zLg0KDQpUaW1lOg0KV2VkbmVzZGF5LCBKdWwgMjQsIDIwMjQs
IFVUQyA3OjAwIEFNDQpQYXJpcywgRnJhbmNlIENFU1QgOTowMCBBTQ0KQ2hpbmEgQ1NUIDM6MDAg
UE0NCg0KSm9pbiBab29tIE1lZXRpbmcgDQpodHRwczovL2ludGVsLnpvb20udXMvai85MTI5NzI3
OTI2OT9wd2Q9V21kd1MwcERPRFJOTVM5dFFrNTRZMWR2YkZscVVUMDkNCk9yDQpodHRwczovL2lu
dGVsLnpvb20udXMvd2Mvam9pbi85MTI5NzI3OTI2OT93cGs9d2NwazUyYTlmOTZkOTg5ZTdlMjBi
NjI4YzJjMzZlNDhiNjhlDQoNCk1lZXRpbmcgSUQ6IDkxMiA5NzI3IDkyNjkNClBhc3Njb2RlOiAz
Njc1MjgNCg0KDQpSZWdhcmRzDQoNCkhvbmd6aGFuIENoZW4NCg==
