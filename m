Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADF14C70
	for <xenomai@lists.linux.dev>; Mon, 21 Oct 2024 01:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729473893; cv=fail; b=ShWmoZu5VHrMXMYMdAZG6iG7Nfqok7nywCi2KGefz+M0jbSfvvyid48IFyBvjkcOOlbzhmNcScFYe0NtyPLiApUjUe6liwg7WGuBhbD+BC3WLEHi5m71Pm/JMhdEWuLUsy3ud2xPxzgKycqzTeprQvGuoYQI6l4Lp3Jpbw4bo2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729473893; c=relaxed/simple;
	bh=CRGqQaG+AzqgWlZlJSNqK+qaO4ykHjr3EzlDKq5CtkE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MADaKh4ttwqA1+ckyr/l3X+AR3zj8E3rNMyib1yN8Zanso6exHmMwCK5H2mTuvjGAxz0G3zxAKO9BVy/ofnObPmC9DBnqf3znHB91oc1EBIbwEZi9X4ixAN8YPX6hqJcT6ocHE4LpAcp4jjXnQE6Jfy2PPilkV4Gignwpq99PMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m5qKAifD; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m5qKAifD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729473891; x=1761009891;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=CRGqQaG+AzqgWlZlJSNqK+qaO4ykHjr3EzlDKq5CtkE=;
  b=m5qKAifDXgAuSgz3UfkrNZxOszJ5ehoFIOwBA0oRQVVFFB/acY2Fh6W3
   imxk1gBHrv1qiaoFXqbhJo3fTn5dXv/j0ApL6Sl7GzmM8UhCUsgHZYZiL
   VD6gtipBl2/3xxXY114rSAEozZO/SqslMPEkjTBBuAOu0KwiQcJEsjjDS
   IBJQscw2sgrWBVg2saNENtzyEArsxBn6mx9dsKZXYj87GaJ92cDzuegKk
   8Q/iq0Rv5xuwWD6hkUey1TjyrKrf5I8MPcxIWL82TGYfFLjItHknE6SbB
   OjlBSsqeZQAgNl9ECb2IgfNVos8otpDmVkL34gmIsveoxXdBxlXZFFXuh
   A==;
X-CSE-ConnectionGUID: 0rLO9xsRS5yGUhqiEMTkWg==
X-CSE-MsgGUID: iiPBYH3GSt6q6qm/pDj4og==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="39563572"
X-IronPort-AV: E=Sophos;i="6.11,219,1725346800"; 
   d="scan'208";a="39563572"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2024 18:24:51 -0700
X-CSE-ConnectionGUID: BvUM5GlqT6iTjQQT4iad2g==
X-CSE-MsgGUID: vvTKntbkSzCdDfS/aQRrkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,219,1725346800"; 
   d="scan'208";a="83995401"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Oct 2024 18:24:50 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 20 Oct 2024 18:24:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 20 Oct 2024 18:24:49 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 20 Oct 2024 18:24:49 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 20 Oct 2024 18:24:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aK2cXO4oZIK2F2VbVHk6Pfh1eFpUCiQImvcpAMYqYHW3LfM97XkR13J8xKG6KCnYoEoWvAGB8pUclk8IBkYkZyqCEY44Api+1CYJUkV3hGIuANqC8pobiIrWm8i08gRezf8Isac0UudesCKYgi5YuJviLlivqNZx92jGh076LsztvpnKqRGzQGtU4e6HFMm6+mY2p/Jm8gLNit/cHOzbhg1/lRKLr9ER4AKUX79b+d6g2NULO1FxVFTLcZ0iIgPX75a6SN+gE462dGS836UK9SPLFfYfMWlYA9Cy7H2tW+34eayW5+bfRlKqBnviB16tXLyUSFTPAUQxg+7MJTRcuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRGqQaG+AzqgWlZlJSNqK+qaO4ykHjr3EzlDKq5CtkE=;
 b=URxt1Qj0BaQIpnSJwNcLzrOPv8xfkgnuAoX1C5BLKpk93TNOFYkLfv2u1+iNQydu54aqXwEAifuv+eHVnSNETvUr7jNCZMEuRi8uucebiQDpAYWn/ph2VgWhzWqmCvwVilW3F7+07yFfA9DQiLaJ0MB9JCd1LuGUaGYgqYirkl57EVIY4dKnsQoDg8s24ZTG1QpDx9dFEvHAejvjLxsPGN4t87fWviZoAE/iO0RjlRlp0JLxe+iaCc721742q1wn15vRePQb4SCVXJ2fqbQJo++e6OEpiwfl+6Xa+6FA43JIBOptnbvIh6LpqlYNmacEZHhGa7o507tonnKVr76DDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by LV3PR11MB8601.namprd11.prod.outlook.com (2603:10b6:408:1b8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Mon, 21 Oct
 2024 01:24:47 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d%4]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 01:24:46 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Xenomai Community Call Minutes - Oct 16, 2024
Thread-Topic: Xenomai Community Call Minutes - Oct 16, 2024
Thread-Index: AQHbI1gDCS59hkJXykmCOLaLsTWqvw==
Date: Mon, 21 Oct 2024 01:24:46 +0000
Message-ID: <PH7PR11MB7499BC997599CB87D1BBB576F2432@PH7PR11MB7499.namprd11.prod.outlook.com>
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
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|LV3PR11MB8601:EE_
x-ms-office365-filtering-correlation-id: ecf76c43-6f31-42a9-8da5-08dcf16f2675
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cjJIOERBTjZOSHpwVTRhZDZvcERhZWpDQnJTWUZjM1Zjd2wwdUx2M0pHYnpX?=
 =?utf-8?B?MU5oZjBIOVZadlgyUHJNSkl2d0Vkc1U2Sy95ZGlTeGhIYUVOdlp4Mm9oUnlq?=
 =?utf-8?B?QmswcFNYa1RLQmptbWM2S0d2N2xkdDU3a2hwL0NDUnJuZ2lVSllUeXVuMDBX?=
 =?utf-8?B?QWhCbnlwYUdDTWdVMGNUbzEzaVV5cHBaai9MeGhsYmprYy9GNmkvSkRKZXFy?=
 =?utf-8?B?dHIycTJsclZXQ1pHTEFZanBmNVgzb2RtWVZKaEdDV042TFpwakV2KzVUazll?=
 =?utf-8?B?a09DMjZVL0lvR3FYUlBLZjRpQ3dySnpEYjVQTmtrTU94K0ZERzJkMUIzVHVF?=
 =?utf-8?B?MldKUkttZit1WnRma1BnOWN5Um0rdlVCSTJDSUp6REVaVHFKcmF6MjlxZVpm?=
 =?utf-8?B?bG4xVW14aUNXWEhocm5uT05NWHlSUW1aN1o3RTJEeWF5SVJ6VTdKS254S2tZ?=
 =?utf-8?B?YjFDTDBGTGZFUHZvWHRHLzNpY3Zhb0E0UllvQVA1Q2owOTFIakNMSklIUHZj?=
 =?utf-8?B?SWdSdHBNeG5DYUt5ektHbnpVWS9ndlh3TlpCdXEwb3RKK25qSVNGT2piQitx?=
 =?utf-8?B?eVhiVmVHWERxakdNU2ZUbnBnZFRjZFR2a0VxVWNydG9YQXRraUwwZDZUNWhs?=
 =?utf-8?B?UlRISUNHL1MveWszQ3BVN09QQU1YallMTXkvZjhpaE92Ly9vdVMySXI4NFN3?=
 =?utf-8?B?amZBbm9FZWU2Nks4SzJ4d2JFZTRnS2VadTNWQVRGaGZsdGY4NTVXM2M0aUhm?=
 =?utf-8?B?amwzbEl6a1E0UXFwNjM0TWJrT2tuM2E0eUczSkJ2Y0JOdVJqdUFFS0RrZ3Jv?=
 =?utf-8?B?RzVUdkJ3Mkl0RnFCTDZWbWRLVU9lYnJLSHY3SVdrVUZUa3F1UklpaE1ud0Fv?=
 =?utf-8?B?OEI4TnhaaUV5dkM5TkhCUWZvcy9kOW91YW5GTVhEZzJoZE1DelU1dERnR1lL?=
 =?utf-8?B?emdBMmVTbFNRL0lWd3FFRFRybDN4U2NOTjNjRURIWEtPVks5MjZCYjZndnRB?=
 =?utf-8?B?VGlOamtNQ1NrY1ZzYlFtOVBFVGRzVVAycm5zejhIblZsVlZBU092NmU0MzA2?=
 =?utf-8?B?bnVVc0U4b1JJU1dLV0hYQlByRzVVUzAwa2poRnFNWlgzamcvY2ZIaGcvallV?=
 =?utf-8?B?ZUhreFZrK1p0YllvN1Vxb2p6UU5EZmU1cTQzYkc4cjc1eVkwblRPU002SlpI?=
 =?utf-8?B?TFJ5ZlZyYnZWZlpMRDR3RzFmeEloK3FFVHBhdEEvc0l3RktkYW9LYXhpei9m?=
 =?utf-8?B?QlJoOThLaDFTNVo0RkJXd3crZy9nY3pMWmkwT3hzUzB1UEQ3cGpYbU5uUGV2?=
 =?utf-8?B?QzVwNHkvWHM4cEF3TENSWFU2emdiNmN3MHRuU29hQ3FBWWZpOVY4ckpNSnVX?=
 =?utf-8?B?M2Jpdko2aUl0Sy9IRm5zb1B0eGJoU25QNWpZdlZ2U1FFaWVOZjZxMDdaSjZr?=
 =?utf-8?B?WlVCWUxCb2x3c1l2MnBtSzNkS21LZThJSTAwWVhtNVFHOVY4Q2VtSWxOZ0xN?=
 =?utf-8?B?aDN3VXV2eEFXd1FjV2FlNmtkRVAwa0FCaWorL3pFVEEycEhQN1hKeXRvSUVY?=
 =?utf-8?B?TEtna2Rkb1NWK045YWJ4UUM5S0tDNGMzakNBaUpmbzlMSWdmeHN4alJkd1Qr?=
 =?utf-8?B?b1I4c3ljNExYd1IyblByRUQ0cCtNUFd4b29aRW05MDE0TFIwTHZka3VRT2tZ?=
 =?utf-8?B?d3lyZVlKVmk5RTYyckw5NERxcmNzWXZkSFZaUU52VUZiSzE4TzZmWDdRejE1?=
 =?utf-8?B?ZzYyTkhsY0JpVXduUFcvT05qZEpCai82dkhqZHZZQU5NcWV4elBJZ21ZNVZ4?=
 =?utf-8?Q?FFF7DfcW9StZfH/l5XuAN7wNnAthuOmlSFNnU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTNXUjJYUTNWcW9Uem1SMURPTmFJaTAybjc2TGxIV0prWHZESFVxOHpnbG13?=
 =?utf-8?B?azNpazU4UGZ0dVRsYW1TcFF2VmxOVGNkU24vNFl2RHI0OGMwVU5HQjR3eHRy?=
 =?utf-8?B?dTNySzR6UlhqTC9VbktkQm4xKytCRUVwZVhxSGV0ZUwrODZYTGV5QmRKT3Q1?=
 =?utf-8?B?QkFyajA4aEhka3hpU3h3Y3VXS05IbkNJeU5EclBqOVFqcTZuWXkyTzgxd21m?=
 =?utf-8?B?M0xwWXQ0UW9oWmt0SjhMOFFpZ3lqTm9xUEY1a2M0Z1h5NGJjcUJ2aDE4TGwr?=
 =?utf-8?B?RmoyZHZsL0NMeEYvNEpYNGNsbS9lQzQ2U1djMGxCTjRaWG1aUzhIY2EzaFZv?=
 =?utf-8?B?U0lUOVVsK3NCU21NMHdXMVlLVGVQNWNzSWlTelp2eklvWnFiazN6bjJaQWph?=
 =?utf-8?B?VUtrS2dVRW5Gd2JoSFdDZW0wSEd6S0E2ZEx5VTlGR0xDSGU2UWlFa25UN3BS?=
 =?utf-8?B?SkF1eGI3RmVSdi9Nd2N0QTJiZWErdEFnS2V0bjVZSENKT3p4QTJyL1FMSitX?=
 =?utf-8?B?T0RURityblRwVzVkM0NFVHlBam84UGZDZnBCeGxJTndHWXlrOXIwWVlZUk92?=
 =?utf-8?B?TnpOalp6QWhIbWpjR2xBTGZpNk1ja0FjN1ZScWZJZVFNNkNqTG9RU0pObmhM?=
 =?utf-8?B?eVJEMUc4bUc3aXR4VWwzMUNnMU1iQzNoclJqa1JONDhPUTFibUZLVEgwWUUy?=
 =?utf-8?B?RFpzaHFiYllGQzhFRFUwVzZWK2RGL2tqWTd0bHFXNDBJQWZXV09wZUs5eDlm?=
 =?utf-8?B?dVlGVVRsRG1sa1ZTUHBSd29aRDl5QTVsNURNZU1lM2IrWlE5S1I0N29RQ21o?=
 =?utf-8?B?UWFZdndrd3VMMWRvbnJ3R09ObmFRSXMrSmVxU0FGTFUzTVArNjkrenZBVGYz?=
 =?utf-8?B?UXd6U2ZRZ3JLZWVkcnlDdGxtdlFPSWFwc0xQMWRjZFNocjRwUWFUQlFkNmht?=
 =?utf-8?B?K0wxdy8xVHF0R2RKRVNXWGxVQVoreGRpTDNjVWNvbFVsQjJITlZWOGRZOVlp?=
 =?utf-8?B?U05ZczlwSjl6YWNtOFl4UXVFcmZ6T296WTQyQ1hxVEtmZ1Q2d2FZNnZoU3dD?=
 =?utf-8?B?enVRczVJLzlFc2JRUUxUSi92WWNFZW5qT0ErazhSUDdxRjFzM1NTclNEUVB2?=
 =?utf-8?B?YVhXeUpvQTB6ZzkvaEdrcG5LUEFYTVhEcWRDUXk1TGNDbFF3Z3hDZ21xZVZM?=
 =?utf-8?B?RlpMMEtaeXBPa3dzUjYvTWdZTFFYM25obVZ3SytPUTNzdW1GcVhRbTVUcUdG?=
 =?utf-8?B?cDFhVXBxWDlyODNWMDFlaWEyV0hLcjkwblA0WmtZMGNwa0xFcDVoSnhIMlFz?=
 =?utf-8?B?SWV4ZGo1Vi9YcTVCQVFKbXl3NU1FdTlUMXUvUXpycHFEUFltQ1BibktHejgy?=
 =?utf-8?B?ajB3SW9WOEMra2VRYlJ0VktndWdTbnRZY2IwZE9FWWxuc1dZdXE1M1dkUzFi?=
 =?utf-8?B?akFBcVFCMUZnUmdZRVhpTHRsS1VkRDVaZjZsb1lqa0hpN09mS3A3aEN4Qytx?=
 =?utf-8?B?MnppbnFUWS84eUw3TTJCbnVDQzRseTNCUHI3Zll1d2hVTWJYRkY5U3VicStL?=
 =?utf-8?B?NDBjQXdkUW9sZTRwL0lmeWhFTDRHMDBPZGFkV0djMjZtT0NjK1g5YWhqb3hI?=
 =?utf-8?B?OTB4THcxbE42OENCSVdjWTBEOXlaVHVCVmV0OHdSR3FQclJmYnJLNC9kK3FB?=
 =?utf-8?B?VVlZbk1nUURKWFczWUx1MkZvZ0RGSlZ4aGcyakM1ZDJLcFYySm5iVWxSVEN5?=
 =?utf-8?B?S2hOTWZIRDZJUi8yREtPRUVRb1VTb1NybzFUUEZNWUF3Z21tVXhYYzQwV2hM?=
 =?utf-8?B?cis4L2V0YlZHWjladnYwOE5rY3FXNFhNN2JCUkRVQy8yTEZPS2RXZDV3MUhp?=
 =?utf-8?B?MDZ3alg2NDE0eSt0ZHFIT3llVjdiWlIybTRoWDR1aHR0YmorOHd5RlVBbGd0?=
 =?utf-8?B?cHlkek9iNTFqc2JmRWNpUE91T0dKWDl0aW4vUWNNL2NENFFhdSt5b2ZNWDcw?=
 =?utf-8?B?a3VtSjJRaWhUWWg1OXI1STRDZHhOODE2T2NSRExGR3JYWmw5VmJzblVkelRk?=
 =?utf-8?B?VzZYUThIaHA4YS9NSVVrR3JuMnlzbVNFOWNZNnNnNG9Xako0eW1BVGU5WTZX?=
 =?utf-8?Q?diGJ5ylvt/xbO1zpxB7Bp9jLG?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ecf76c43-6f31-42a9-8da5-08dcf16f2675
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2024 01:24:46.8062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lCk8YyxInay2FMgmPWx8z+PUA+hPOHYCvLMviv9x/gZH3Z7l9U4OxSU+FP/jTbHMM57HONxGWaXIfoa9tisVxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8601
X-OriginatorOrg: intel.com

DQpBdHRlbmRlZXM6IEphbiBLaXN6a2EsIEZsb3JpYW4gQmV6ZGVrYSwgUmljaGFyZCBXZWluYmVy
Z2VyDQoJCURhdmlkIE9iZXJob2xsZW56ZXIsIFBpZXJyZSBGaWNoZXV4LA0KCQlOaWtvbGF1cyBG
dW5rLCBMb3JlbnogS29mbGVyLCBIb25neXUgTGksDQoJCUh1amlhbmd0YW8sIFNhbSBDaGl1LCBM
aWFuUGhvbmUsIFl1eHVhbiBTaGFuLA0KIAkJU3VuIFppdGFpLCBIYW8gTGksIEhvbmd6aGFuIENo
ZW4NCg0KQ29tbXVuaXR5IHVwZGF0ZToNCgkJWGVub21haSAzLjMgYW5kIHNldmVyYWwgb3RoZXIg
c3RhYmxlcyB3aWxsIHJlbGVhc2Ugc29vbg0KCQlWaWVubmEgWGVub21haSBNZWV0dXAgdXBkYXRl
DQoNCk9wZW4gZGlzY3Vzc2lvbjoNCgkJU2lnbmFsIHBhdGNoIA0KCQlXdXhpIFhlbm9tYWkgbWVl
dHVwDQoJCUV2bCBwb3NpeCBpbnRlcmZhY2UNCgkJTG9vbmdhcmNoIGFuZCBSaXNjLXYgc3VwcG9y
dA0KCQ0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQo=
