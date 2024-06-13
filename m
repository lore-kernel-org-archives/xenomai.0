Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7897F20E3
	for <xenomai@lists.linux.dev>; Thu, 13 Jun 2024 01:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718240826; cv=fail; b=b6kQn2h/ANIgzaioP+41riOW536uwszMYxE9i/tyDCRzMGjg1hPqOhrcvpKfCggwUJY6F8mnAqFXWiJtKK5BnOs8+yuiYzl2Z+dSkMFGUK3uAHgfdbohunTovovaezN+21G0KnMcYlACD+7qD9C/ghUV36yMLO8ak22UwIS+uQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718240826; c=relaxed/simple;
	bh=jc7IGM4P6l5RovRo0xfOpbF1cK20RLad1lnpif7y2C8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SRvJnq1q0OjrKsg2hB7YBd5nNNdcLmvld4aIm1gN178YGuDPmaPJz+3mxGakybK46Mt2cZcXuqwWJ8vpPq16Ko8EgY8y/TzA9x8saGbJNmgzX/hbrtRbmFVuDSq8rdYvqyxjNAFPw73jOQKoBjLvEkCboa+5E82CpWBK2MBgyIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BJSyZUoY; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BJSyZUoY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718240825; x=1749776825;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=jc7IGM4P6l5RovRo0xfOpbF1cK20RLad1lnpif7y2C8=;
  b=BJSyZUoYtTK2kvFYbM9huwcTHapP6+cLQcA3F3CRL+3gjuAU7g6SgqAy
   Oe0Hn+f5Vwy5mFLE/GyhaZdtTai1UglXHv0iK7+E890wwn7JUN02yYCa5
   lFej0G1iAulHzXAoAmxS2ceMnlvk1eGhRz1udiqOYRYWeyOhPUYQiziJd
   +UV47hUCRCoCay2A0zI5q8QgWEdStkjeeJLo1fpvTh2IBoMEVo9yFXFpS
   MIWPknO8oZaZUyx0gUvYHW7GPIX9oOTGvFEmin0LseK59aUuH6/sCHS0Y
   SWITRup1Z9jtXlpaleJp4nMTCeAS3jNmiZbAZ6tksMh7Zcrj/Is/OqgdM
   w==;
X-CSE-ConnectionGUID: VOXH2uvGSu+9/PC8DHraQw==
X-CSE-MsgGUID: ocomq61vRd+q/XZCmZQ/5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="12043181"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="12043181"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 18:07:04 -0700
X-CSE-ConnectionGUID: +dJxbNQCRJyOMxh21pHj1Q==
X-CSE-MsgGUID: oaiA0bk/QkijQ35mde4giA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="39886786"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jun 2024 18:07:04 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Jun 2024 18:07:03 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Jun 2024 18:07:02 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 12 Jun 2024 18:07:02 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 12 Jun 2024 18:07:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLxd4zx9Zbjv2KhLN6pqb3GrwLFnSC39cINRLgUjBrh6dYcfIi6DvV5vuA2/KSTeXuWF7pg1ZylWG0F9hIYDVOXfGVdS40xDRiVj6Z3nbLWN9ybCe65FsDkFFvBwX/mXFN3qdm6QobWD4vj6bzqoYDzXN/lVGLopdkPqo5nZC0LZo2oSO+qCZyXs/MbiXet0eGf8EnBqsy3Nw6canL1bf/WBnYXlMh3z3z6O3n+LSD6WCfXGcmXCh95x/eyKvJVd+1vWo7LcvzanigKMwf+LMVUukkrzqfq7PgM8FL9LLKhhIo14qibrj9PsStM0lzUICqRRluInNA8nOBBuQluI9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jc7IGM4P6l5RovRo0xfOpbF1cK20RLad1lnpif7y2C8=;
 b=VQ9HcaSRhfmoltzg3I9rg5vBcQ62jyqFMjPAf+svkw7CO0xyWX4wB4kUjRg1Oe+fwttzj3L8mujpLQzO57G21/gjK6ygEywYSvACQAAjCqN7ccXECCpE2nbFc0cusGklzsoYxKHIr96mgvIMuLOJYxQQtbwCsRkdbnp9nx7uEapOQmLhGIrk1QMa01F8ITXVHEAnjpOMkXcx0L+JsJfk5gsrKt5aSxovH/snn+ezGAufHk+t/vAuqphrqLU3HmDe3Dqjdg30XWsXRysPKEZmJ/PmX3/UC05mcskfruVS3VjLsd/FGBTp2KVIwgS8KhXLdX7sXviwj1Tf2KAbsZ6lgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by DM6PR11MB4578.namprd11.prod.outlook.com (2603:10b6:5:2a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 01:06:57 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d%7]) with mapi id 15.20.7677.019; Thu, 13 Jun 2024
 01:06:57 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: RE: Reminder: Xenomai community call on Wednesday, Jun 12, 2024, UTC
 7:00 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday, Jun 12, 2024, UTC
 7:00 AM
Thread-Index: AQHavLUi7vAwjlnkOECXZMpNcaN9bLHE4DGQ
Date: Thu, 13 Jun 2024 01:06:57 +0000
Message-ID: <PH7PR11MB74993A768F1D777F56F1D422F2C12@PH7PR11MB7499.namprd11.prod.outlook.com>
References: <PH7PR11MB7499F7DDE006A3A7291F61FAF27B2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749929DFFDCFE47376883636F2572@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749988D3E2C96C4F21DAEBE4F2212@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499C4BB71E159B3AB98D686F2332@PH7PR11MB7499.namprd11.prod.outlook.com>
 <DS0PR11MB7482613E8A9D78229EA71D07F2EC2@DS0PR11MB7482.namprd11.prod.outlook.com>
 <PH7PR11MB74993A52AA247D08069980E4F2F22@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499EF7C4A0FD89D089B63A1F2C02@PH7PR11MB7499.namprd11.prod.outlook.com>
 <eb43f35c-dc27-4f10-98ec-c9c4971c0043@siemens.com>
In-Reply-To: <eb43f35c-dc27-4f10-98ec-c9c4971c0043@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|DM6PR11MB4578:EE_
x-ms-office365-filtering-correlation-id: f1b6de1e-c810-4bc9-ef8e-08dc8b451f76
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230034|366010|376008|1800799018|38070700012;
x-microsoft-antispam-message-info: =?utf-8?B?a0JabXlOejQyWk01SHNSdzkyUnpIVHBXc3lKZ1lHcWdJVHZoOWFTbDBaSlNq?=
 =?utf-8?B?SGI2bXRCRGlCR1RWaTR3UlBVb3lNMlFCTm0rYWFjWTExUlg5ZjArSHBLdFBP?=
 =?utf-8?B?N05VZFZxMGJ1dmN3ZnlIVzZNazU2UDNMQnpUL3kxaDdGWjVDRzhvSTlnS2lj?=
 =?utf-8?B?aWVjRzZoRjFhWTh0Y29hSVY1QndLWjBQVG5WSTNzVy9DNGdZR2dQOURpZ1Zy?=
 =?utf-8?B?ME5za0FDaUdoV2w4V3FPbmpHNGFNRGg5NTRUbG5ORjlCMkpPdlk1ZSttOUlR?=
 =?utf-8?B?cE11UDdpNTRDSXZPYUgzbjVMc1o1QXJONVp4RUJLaGdqOFFCWHJjeTF1QWg1?=
 =?utf-8?B?QkcySHZOd1lUWTZYcnlaNWxNRyswMG1iVWFHYUlWb3JYQ3d5dmtyS2NHaGFw?=
 =?utf-8?B?Q1l6a3VGV2hzejhTNUZ5bk5FbkVHSzhCYWlSMkI0b3ZxUzJLRUd0RUY5czdo?=
 =?utf-8?B?dzFKRVJXKzBmTlJXb1lOZGc2SExDTGxxWVIxcHNTeDVmUjVGWFJSaXdTc1dB?=
 =?utf-8?B?dnlEUnpybUU0UEhrRXIxbExvbm81ZWZIOFlFcURwUjNTMUQ4MUl0ZHRXZk9r?=
 =?utf-8?B?OE5Hcm5XMTdEa01jRzFlZnoyR1RHQVYxN1M0ZmdGWDhSbEtiVEZ0VUFHckxM?=
 =?utf-8?B?aW9sTDkxNjBHZFFDMXJuYnAzVGdMM3hNS09OY1NTYVc4VFhuMzlpZUE3VXdT?=
 =?utf-8?B?R094MGFxUFVkOGxDd0s4cnVqK2NCQ01XMnhzSXJyMitId0t1UmsvaW8xYWs0?=
 =?utf-8?B?OUdCWXIvN2tJL21IMHJCdEFGWTdrQWlUZGphUVlqbWZpdWpSYmt5d2F6cVJn?=
 =?utf-8?B?cnZxZUthRTRpRkdjR09TcjE5VXdTT2U5K0JlbmhkMEpBMnJKbVBodmJURWk2?=
 =?utf-8?B?enhMMWhPc0FmTmVKUDhRdnJhN0h5YWNJK3NDQVgwRHV3UmVINFRJRFRYRDMx?=
 =?utf-8?B?Q2o4Z1VhY3VEMHhmVGNKTFp5Um5Xc1ZjV2lFRVRneHMxWlJzbTBZOFV0b0ZX?=
 =?utf-8?B?RVQ2MnJZUHhFcWJHcGNkUlltb0E0NFZUdXFEQUdkR1pmRG9ZdnMxQVpLWi9L?=
 =?utf-8?B?ZXdqb3FDTXJQdEVUS2d3cXBBQ2RTeE1SYTE3bldjOUFYaTZDR2Y4RUkyWHBS?=
 =?utf-8?B?eUVlTkpFaGNqaDg2ejVWSXEveGR1TGNTVHlHMVIyNm5nekZVUkVVdWFPdzZ4?=
 =?utf-8?B?b1preFdKYndMY3ROS1hrRFBXYWRXQ2NORm5KeDgzSHFCeU05dllMU0p5dU13?=
 =?utf-8?B?M1JZZElHZXN1TFVUS3l1dnNDV3lwV09Ya3JoeklGcFVyVS9raE5VWjY1MW9F?=
 =?utf-8?B?ODQyN09NQ0p6WnlKWFprNllGZlUrdWpoSTVjejh5RzZIY21qUlpDOW80Y2VI?=
 =?utf-8?B?UklCZVlwMTFHVTd0d2o0WG5hSEVCbzQ2VVdPYzBuMWI3bFJhZVozeS9WTmtD?=
 =?utf-8?B?OVNxbVZJWldwQ1M2cElya3ZqZExVOUI5TWozNWRzZkJjTHA4U0c4VGZWMUdk?=
 =?utf-8?B?bk9jQWZJdkNRb1Bvb1dWU1NBekpES3MxS3lvTmVnSWZFelFkcGoxQVZFUi9N?=
 =?utf-8?B?eFgvN2taY3NsUWVtaklNaUtKd0VDaFYrRkFuWk9yUkpmd2JOanJXTW4xV2cw?=
 =?utf-8?B?eVh2M3BtUnVMc2c0ejlqUXdLRmdyTlpUVXBnSUw3U2NFTGdaMTQ4MXlVM0Ft?=
 =?utf-8?B?R3BuSmFDbTJsMzEvMHFJc2RtZ2Vsem13U25ZNnI1YWU5NENNUWZwNjJ0bnEr?=
 =?utf-8?Q?/ltVQ03Cm2t42Sg9kTEQIv2pbBeZ6AFcSaJUDz5?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(366010)(376008)(1800799018)(38070700012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXRmZ1N6MjdNQUIzMUVRQkxYdzZMTzlodmR2c2dpVWNxSE9OV2lOcFhPZkMr?=
 =?utf-8?B?clFZOTZjdTJ6MmNGa3djVVJXbkJBWmFtMkx5b1VQUzNZMTREd1BjSzl4R2Rn?=
 =?utf-8?B?VXlmazIrSmFBSmFQaGR1eFpFRjFmZDd4MjNtR0FkTDlVMXFVZjhrM0tveDh6?=
 =?utf-8?B?ekkwdTBMcUhaZUlBbklzMVR0TmVxcWlhRm9XOFIyQk93K0N6VUVNaFNvaDhz?=
 =?utf-8?B?Mmp5M1lpYytUTENFTEE3Yk91aDhzYkJHTXdYQU44NzY4TlNxMzRyOEdnMFUv?=
 =?utf-8?B?aGhhaUd3ZkFWd3Y1VWVpRzFRVlhSS25xbXkrTTNNdDgrcUMwUUdiRGdoKzNW?=
 =?utf-8?B?ajJoRndSZDNVdGcwUDFBMWNPanlNOXNPaFdHNWV5a1p0U29Ubms2ODNGSU9k?=
 =?utf-8?B?ZnM3bVphVE5QemhVbDFmTkE3TlkrbjNWYVQ4K0FCQlZxV0VabTdMQ2pMSzhO?=
 =?utf-8?B?VkZReWNqVGxEUmczSGlzb3VTbEM2QS9GaXMyWEJpWWlpemNraUZFS3BxWURo?=
 =?utf-8?B?T1ZzMjFIUmpzVlloY3ZUa3ZNYUNMSW5zbFQ1QVdROEtGa0w0eDh1dEdEYlQ2?=
 =?utf-8?B?cElYdHFvOGQvRDJhbDVhVHpoOHo4N2hwc1Vwb0gyS0NUTHpBZVNvY2tYNXlq?=
 =?utf-8?B?QVZlaGh3eDBLNE9Mc3VWWmFGUjltRUZPK3VPVzd4SEQ0SnJDRDZUSkVwaUpQ?=
 =?utf-8?B?a3daQ2VuVHdaNjZHTU53NjVQQkRJMGJhWHlHUXRVUURGVzBmeE44cVlaMmhK?=
 =?utf-8?B?REh2Z0tnSXdwQUFtRzB4NURVZDNZOU0yS3JZd2VtRHI1ejZXaWdVcjdTZGtj?=
 =?utf-8?B?UU9QQllTR2Ztd1ZKZkZkY21ZQ2VNdzc2SmNmdWJYYWdOa1NxSjRKQU5WanA4?=
 =?utf-8?B?T2RqWkJsaUZLY2dPSm5ObXpONGJBZHBUcWZmUzhYMVQxVVNCNzlqdXR5MHQx?=
 =?utf-8?B?aXBDTXB0RUh6UFpZOWhDdkNZVkJCUVRnaUk3VndJd3haTkNTVzRGTzFTMG82?=
 =?utf-8?B?WFd4S3lncVA5aGFMN3FlTThCREs3ZC9UQ09DRVU4azRBdVRCR3J1Rm1HT25Q?=
 =?utf-8?B?U3RqV3Zad3hTOTBySHE4K202TUdHU2N2SDNjeHovUW5RRCtNc2pXaXk4YnpE?=
 =?utf-8?B?RlJERHd6S1dFVFRRRWFvSWhXakQ4amJQcnJJemdhUSt0Z1pKZEp4Y0wvR0Fu?=
 =?utf-8?B?aEtIU3AvZjNmbnRCN0FaOFJHR2ZtSE5TWHlxbndtd0dwQzk2SjZaT2FLRUFz?=
 =?utf-8?B?TUdGSzNNN2FlSDN2YmxtZUNXc3RUYk5sRHBGUWc5QUtFaUVmeEl4YmM1U3ho?=
 =?utf-8?B?dGRscG9lbm9kOVZRMTc5cDBEZnJYdFBCZURDUmF5Tm5oR21keUlkU1hESEZi?=
 =?utf-8?B?dnlZcnlKbG11UFdWUXVCQ0I3cVhvMG41UVdmeEJ1UldZM2t6ZmpGcFVjRCt0?=
 =?utf-8?B?R3BJWXc3ME9RN2RCY2JCM1RzenkrUkVidjhvZyt2cSswckR6NlJhekFlU3cv?=
 =?utf-8?B?dGE4TzdRVW42Rmt0cDNnT3AwUVlETFNTL09CNjNsKzM1MnY2ODNNbDR3RjJC?=
 =?utf-8?B?K3dtMFRtWG5EcW9DOEdZd1pERU0yWGFpdHVyc2s0c3JQR1RVNXgvekNiTHdF?=
 =?utf-8?B?dVJwUjBEWlVkRlYvc3dpb1FFV1dyRjN1QVdveVo4V2kvNWtraDR3WmFaQkNy?=
 =?utf-8?B?cmp4OEdNL2ZaUjBHY3JUaFRlb1YrSGFvUEl4Szg4ODlpdE5zaDF0cENCa3Bk?=
 =?utf-8?B?ckJ4OG1zMFRnbnd0azdEQUFMVzU4ajV2Q2hyd1pPNEMyRWVuRFdjUkltYzhD?=
 =?utf-8?B?U3h3MmZaRjdCYmQ4YTZLdm16aStjVUhCbzRxbVdMZFBWVWs3TThpWDdHU0h3?=
 =?utf-8?B?OTlBOXhPcUk2TmNGNmcyTzlxb3RPclphaUE5akM5TStrdUpKalpCenl5aUIr?=
 =?utf-8?B?eGJOOW00WFR4YTJ1aDVyRFJPL25zL1hMZ3ZRODU4UGlreHI0TXR1NkJvVEFE?=
 =?utf-8?B?R1crZVdxSnlaK0h4WTVHanpOcG1wQ09jUDhyVzlIT2tnRG1zNWErdzFGTWhH?=
 =?utf-8?B?RHY1SDMzbFlRM29kZXpnb1loYTZ0UW1kK1ZoenZqQi9BM0lyYUN0OVdXNjVF?=
 =?utf-8?Q?zhkWHdogN1x1cF6bt1XEdh13q?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b6de1e-c810-4bc9-ef8e-08dc8b451f76
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 01:06:57.6219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tS9r1RAdjJFmafs/1IGSbM6yMJqOSDvQ0yyTS18UzOP5Pj9PjSUvmllr/v++siekRa7GfRZ99duibx8/jbtAtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4578
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEphbiBLaXN6a2EgPGphbi5r
aXN6a2FAc2llbWVucy5jb20+DQo+U2VudDogV2VkbmVzZGF5LCBKdW5lIDEyLCAyMDI0IDY6NDEg
UE0NCj5UbzogQ2hlbiwgSG9uZ3poYW4gPGhvbmd6aGFuLmNoZW5AaW50ZWwuY29tPjsgeGVub21h
aUBsaXN0cy5saW51eC5kZXYNCj5TdWJqZWN0OiBSZTogUmVtaW5kZXI6IFhlbm9tYWkgY29tbXVu
aXR5IGNhbGwgb24gV2VkbmVzZGF5LCBKdW4gMTIsIDIwMjQsDQo+VVRDIDc6MDAgQU0NCj4NCj5P
biAxMi4wNi4yNCAwNTowMCwgQ2hlbiwgSG9uZ3poYW4gd3JvdGU6DQo+PiBUb3BpY3MgbWF5IGlu
Y2x1ZGUgYnV0IGFyZSBub3QgbGltaXRlZCB0byB1cHN0cmVhbS9kb3duc3RyZWFtIHByb2plY3QN
Cj4+IHBsYW5zLCBzdGF0dXMgdXBkYXRlcywgYW5kIHRlY2huaWNhbCBkaXNjdXNzaW9ucy4gSXQn
cyBhbiBvcGVuIG9ubGluZQ0KPj4gbWVldGluZyB0aGF0IGFueW9uZSBjYW4gam9pbiBhbmQgYXNr
IHF1ZXN0aW9ucy4NCj4+DQo+PiBUaW1lOg0KPj4gV2VkbmVzZGF5LCBKdW4gMTIsIDIwMjQsIFVU
QyA3OjAwIEFNDQo+PiBQYXJpcywgRnJhbmNlIENFU1QgOTowMCBBTQ0KPj4gQ2hpbmEgQ1NUIDM6
MDAgUE0NCj4+DQo+PiBKb2luIFpvb20gTWVldGluZw0KPj4NCj5odHRwczovL2ludGVsLnpvb20u
dXMvai85MTI5NzI3OTI2OT9wd2Q9V21kd1MwcERPRFJOTVM5dFFrNTRZMWR2Yg0KPkZscVVUMDkN
Cj4+IE9yDQo+Pg0KPmh0dHBzOi8vaW50ZWwuem9vbS51cy93Yy9qb2luLzkxMjk3Mjc5MjY5P3dw
az13Y3BrNTJhOWY5NmQ5ODllN2UyMGI2Mg0KPjhjMmMzNmU0OGI2OGUNCj4+DQo+PiBNZWV0aW5n
IElEOiA5MTIgOTcyNyA5MjY5DQo+PiBQYXNzY29kZTogMzY3NTI4DQo+Pg0KPg0KPk9oLCBob3Bl
IHlvdSBkaWRuJ3Qgd2FpdCBmb3IgbWUgKHRvbyBsb25nKSwgYnV0IEkgdGhvdWdodCBJIHNhaWQg
bGFzdA0KPnRpbWUgdGhhdCBJIHdhcyBibG9ja2VkIHRvZGF5Lg0KDQpXZSBkaWQgbm90IHdhaXQg
Zm9yIHlvdSBidXQgYWN0dWFsbHkgUmljaGFyZCBhc2tlZCB0byBrZWVwIHRoZSBtZWV0aW5nICBp
biB0aGUgZmluYWwgZGlzY3Vzc2lvbiBvZiBsYXN0IG1lZXRpbmcgc28gSSBkaWQgbm90IGNhbmNl
bCBpdC4gQnV0IGFjdHVhbGx5IHRoZXJlIGlzIGZldyB3ZSBjYW4gZGlzY3VzcyB3aXRob3V0IHlv
dS4g8J+Yig0KDQpSZWdhcmRzDQoNCkhvbmd6aGFuIENoZW4NCg0KPg0KPkphbg0KPg0KPi0tDQo+
U2llbWVucyBBRywgVGVjaG5vbG9neQ0KPkxpbnV4IEV4cGVydCBDZW50ZXINCg0K
