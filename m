Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BE5C128
	for <xenomai@lists.linux.dev>; Fri, 26 Jan 2024 05:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706248232; cv=fail; b=ZyOd8Jm3U2Elj1I9VFOerean56ezwOk2HeWG7w3nMJoLhdr37Ch55vsE5e+zHkhSPiX6xs9QkVdR/QUTQI01KBBaQ2Xwm3I00kKyFDno9vG0qJ4D4b675KLpdkK0uq2hWWykHz9/s6gnQapZO8nETCZNDFV1zroA44jen5CisaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706248232; c=relaxed/simple;
	bh=ui185LatqZLO6Z/Q5NE5BiCZjhebL7Owg+PnSvFDSZE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TooxHcWbGtGLz64WGzhQRppXDj4v4AWA+3/x0ULVDmSOoMTjvLJZihfGXktjU9dhbKkJhbTpYkkf+9fB8ai+CDwBPut0zsGbv/KPPupcF6CXFI2WG9U23UKw24YgWQaraFvt/QoGCsalfQ37yRLyAaiiD58r82NOHMPudShS/w0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kALOzIBI; arc=fail smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kALOzIBI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706248230; x=1737784230;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=ui185LatqZLO6Z/Q5NE5BiCZjhebL7Owg+PnSvFDSZE=;
  b=kALOzIBI5CFMScDpRF+xsCOmqCgLBeLil2rFQb5dZY0GsnQsQu1aRqyO
   PCTEp8lwqQYdb6yl5U6OFeEcZ/m4Hc745wcGV9A4HSq4Iz5ARnAcvDMMD
   S70KlGUdH2B4yOgpJ51tepbof4jJujR95YFLNCaZcPJ3vwigvSjLyGSx5
   BHEqfxSPIRyz3O4vX9oSmzuJgATpTgOKQfu7Ewm5W+wE9uSwutGRhxcyc
   pQ1gIk2eLeEt8+47kFSxeLgvye9OFNdrrNhrN6TKprZ9DWpvTwkt+c3e5
   QuIPlQb7rjfGVKZtzUUsIpHeY+5nsw/9dqic7lw0T2GoE6Nh0lVW8qwAd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="392824826"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="392824826"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 21:50:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="29031097"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jan 2024 21:50:30 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 21:50:28 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 21:50:28 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Jan 2024 21:50:28 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Jan 2024 21:50:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IvHsuqtuQ4v34x0soYSq4YV8M5t259ORcHwDWTGZKMi1a01iin+z9TjCIfiX2FQMferGeJUeuLIuxakY9gTnsznzhFr66B8wPrNIopHVcsTe4fFpKnUWrhCKwcESA2x4M5cEBcPrMYDHI/anVxXa4WHWKH1ywcdXSitBPb39DcaWyATNsN85OLe/N2Yu8dDp1sWCIjK2G2sfXITs83SUeAY6RPkOezT5eUQLph6q4Yx+b88KMQcfm+dZdrE0f+JdMqIG2wke3mfoH4R1envGtx02L3WUHPd/aNYfeSKhC8o3eecBnZ3ADfDlh4FwOgDfA3CkRqL4mvXrnu596KPU0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ui185LatqZLO6Z/Q5NE5BiCZjhebL7Owg+PnSvFDSZE=;
 b=A6OXZ7SnKiAhJpSLtVB8mfCggTKSA3OzBV2m9N/53nqmX1VnQmPRNNEXafJ9f7oHU16wbMokZNm2NnkkBOlHgyzSwNkxz15GlgtD0qVYk0HSMZELf4Ztc46GiOQzQBcTIjHE4NnTLMUEKnlwR5H8jW/epJSGiKAmrDr5XjxyjcFHCkxx4kE2TqUxnJxIMnRjEtE+hqq904z8v7DdGnW0laBRPsoT1uVxGdCKw6R/sz1E3eth3+yhTo+S/j9c16o7tUn+qML8TE5p7hwJ9X5Sp+4qDtIzH3rmYESsNwOWEfiTlVK+u3dmtwV6ozNUnyo1j21BXnSUXry9kCgEKAAhYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by PH0PR11MB4933.namprd11.prod.outlook.com (2603:10b6:510:33::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Fri, 26 Jan
 2024 05:50:20 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::8900:99b9:a57c:839c]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::8900:99b9:a57c:839c%7]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 05:50:20 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "ivan@rtxi.org" <ivan@rtxi.org>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: RE: Troubleshooting x86_64 evl bootup
Thread-Topic: Troubleshooting x86_64 evl bootup
Thread-Index: AQHaP0dvbvy3YgVbckqQbMbRUJWjOrDeuYgAgAB9fwCAAoE8AIAEnsGAgAT4twCAAGcwAA==
Date: Fri, 26 Jan 2024 05:50:20 +0000
Message-ID: <PH7PR11MB74990292FF1690BBFCF4CBFEF2792@PH7PR11MB7499.namprd11.prod.outlook.com>
References: <37d6d286847eb0126c938a1c5826ed13@rtxi.org>
 <34ba04db1b45f6c546a2195f0a8e0ad3@rtxi.org>
 <e70b0272-8c4a-479e-b7f9-2dbfc6771389@siemens.com>
 <ce6d6d1504bb7d589daa14d03fd81d76@rtxi.org>
 <4e81f900746c1d6580e4d2711782cd25@rtxi.org>
 <d124b161f9a2e830efc03a4aa4336921@rtxi.org>
In-Reply-To: <d124b161f9a2e830efc03a4aa4336921@rtxi.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|PH0PR11MB4933:EE_
x-ms-office365-filtering-correlation-id: 27ec7a79-bc43-4813-8653-08dc1e32ae76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QMupeOoPAL/51hXvpyfyvDgB0N2PtVj5aT+F1RE558NKr5iEP4hYZDpM4H7Tq9Sjr5dsYSwYnOavutlvOrlmpih34Jv+cZ2k3ZP6OsgvMfn32j/UR51lrs6+UPIg3WyuGpkaKlDRmPygIlaChTzNQDyVEk3MaIejNOLHOZPJPy++QmAx6QiE5zACtNq71NkGgKiMKD5sSzr+gZzPIPZM3q1kvKmFU1EdCvGC13NW4mg1ZBQrabOYdeYDV7Nr1SXhQAjR35WPZGV4bU5FVsGrOZGTGJL9pIHk62TH4P8X9XO7U2GjRfLABydR7a+jb+ojJd6TLl+SvAC26d/BuTwOLn7QnaVHr2znD4UKnW9Eoq8O6l3dgQIA7YBRNBDGKYMAtOPWPS/w7rS6KVL+XQfJ7IfVbL8/2fxW4EAPdvSAegDMDTM3rULnzeoQAi3jec5TBhYcc2Fyh2fWynKp3RueyuLznOpUhwuKJw7eTei4Eoz7rZjlBZH2GchhhjI2gir0ksgEDtw/5kDImRcedUz0xnER7UXitBWbA6hqNdmUjIFtyHqVunJHUFUcgpT2TaBebUS962xvDK5JMwYlZLV3qydKqj73mFsvmDBT+juP0p8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(376002)(396003)(39860400002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(26005)(83380400001)(64756008)(122000001)(7696005)(53546011)(38100700002)(966005)(66946007)(52536014)(8936002)(110136005)(66446008)(8676002)(66476007)(5660300002)(478600001)(71200400001)(316002)(6506007)(9686003)(2906002)(66556008)(76116006)(41300700001)(38070700009)(86362001)(82960400001)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVhDeDRBVG84TVBldHRKMlZmdUNEbVBPbk16TkFQdUY1ZUtaS2NvV1k4bjcw?=
 =?utf-8?B?UGtVM3NmUTkyZnlJUFhqTjBiLzRWQkZsTjBVZEtLS3habVY0QjRFZGJQRXMr?=
 =?utf-8?B?cTNsbGVkWDNJOE1JYzF1M3NXVmMzemdQbmVUaGUwU2FFUGpRdnhzSDNySm9X?=
 =?utf-8?B?K1FYNWozZ3I1ZUhUTkp6bkF0YUdkNm43b1IzQ3IzTE5lZGZLcWZKTmNXZXlS?=
 =?utf-8?B?MUF0cTBXc2VnblJsOEw0QnNNVE9BK3pRYzhUdFczdUJtcHoyeFpXSEI5amRJ?=
 =?utf-8?B?MEwwSHN5UUM5bFYrNkV4aWI4dFhYdEV0bUtyK1dwQUpQdkhYUnNZTXhHK0RR?=
 =?utf-8?B?eHFlTHJlTHBFaG9GQi9jSTltN3lQMVludkJZS0ZwT1VMTmdOcElQOWU4TURq?=
 =?utf-8?B?MDdNcFA0UDRMVDRXM3lPRytRSU02M2NtMUNBUWFCMFNIcmR5aThLNlZOcUlP?=
 =?utf-8?B?cDR0Njc4RHlBajZKVHF6Uk1PcnUzOUthR05ZMkFIMVVCNHdJSUIxeDdRNUY3?=
 =?utf-8?B?VFY5c21YempZVUxkcnQwcVMwQk5Bcm5uSU5tUzJUTytlN2R4MXU5ME1Nek9z?=
 =?utf-8?B?a3p3STExZ0oyQUppTGxaVXRiVjlWMm81NG1rMEJJQm41RmE3VEtocWF2YVh1?=
 =?utf-8?B?azF0ekJOV05pQ3lKNVVIVHpsZFZnOWJnS3MrZWV4YjZiem5VejBJR3dsc1V3?=
 =?utf-8?B?dHN6L3d6K253Zk1MSGRLYkhRQlhuZDhKSzJCVzFLSENRRXVaRXBkTVhTTnl4?=
 =?utf-8?B?TU5adkx3K2pZS2hDMEI3VWsxTVVCZHJJN2N6amtsb1c1eW8xUmdkS2R6YTVL?=
 =?utf-8?B?WXpUYTNQUjB4ZU1Yd3lKOUUyUEhid091MWxVUnFyMllJMithalY3NXlmK1hk?=
 =?utf-8?B?R2ZxMndMcXZkMXk0TlkwQURiRExDRGxTRDRoL3hKL2ZmR1pDVzBRNmF4YkFl?=
 =?utf-8?B?WE9zcWtBNW1hK3gzZk1zUWpuT0orVVBaSVJXbnpveTVkdldRTVYxQXhVbk9S?=
 =?utf-8?B?WTF6M0o4TTFRSXRZRk1HM25FS3AwallkMmVMd0N6MXdSUFVTV2RwMXBiRDFm?=
 =?utf-8?B?RzU0YmhBVFZJRjExc0lyVmFNeGRsVkNiRkl0Q0J4V0JZaGFSUWdFS3c4RXdD?=
 =?utf-8?B?OC9xZEg1eXJmbjBoNEFkR2cwZ3A4MlJEZkUweEQ3SDNTamc1VEhKUUpReklG?=
 =?utf-8?B?YW9TbGdEMXhIQVdCUm9XYXhRWlFLR3MzempVMjdEM1RVV1I3WW51czJWWGNI?=
 =?utf-8?B?OGNSV2VxRlFMaXUyZTExMVJFdTM2bEl4ZWZ3VWwzbDVHbGNYQkk4aVMzd2xJ?=
 =?utf-8?B?eGRHUlFvWFE2anpLTmRQR3drM0JmMTIzQ2FNVHZwOUh1bWhhbjRkc1NBZXNv?=
 =?utf-8?B?cjhpYWpMdXZLNy9TVG83VFNzM1NIeGFaQWdkK1JvMmhYVEZmS29ZTGUvQ1Jm?=
 =?utf-8?B?aDVJQnhjY3pHa293ZDUvSzVJU2VrQnFHZnpmRHJxazc5UVNlbElXVEdQMmsv?=
 =?utf-8?B?Y0RsSXh6N1MrU0FLOU1ZQUQ0YUNVL2tqYURoWHA5aXRSc0ZJNm8rYnlnT3lN?=
 =?utf-8?B?eWJNWGZ3R0MzSUROOXEwZDJOSVVFRys0L3FkdjdMaUFENXlvQWVVYTdIa28w?=
 =?utf-8?B?Q1RNOEs5U09WZVM2SStSbFNiRGFQUEFXODlsN1Z6d0xQQzZ0MFErQk1uNjRq?=
 =?utf-8?B?WEU0Yk54LzNnaVRQK0ZuZVVWVDBuRlFuMDM5ZHhGZEV2QVFad25sR1Vodmxr?=
 =?utf-8?B?UzFXdXpTTUV5ZHVKZm96c0dhZkwwZlI3Tzl3VWduVDMyTUI5LzArd0dLYnUy?=
 =?utf-8?B?QkdneE5WYWc3RWp4ZmpYZTZZYm5Hb3ZaVitKNFBwVmRmdXZWb2FJOUN1WHRq?=
 =?utf-8?B?VnNwcnZpbUxYY1hubmdvbzF5NU9laDFEdEJTWmpTVmJkci9ISjRCLzJ6SHgw?=
 =?utf-8?B?eHQ2VEJOUkhmV0xsUnBSdzYzRmFXNXBuZTN6WmlTaDJlZ1lLVC95L0JkUjRs?=
 =?utf-8?B?STBaaVlSYTAva2srcnBLUFFvbHRVSG9BbG9WZ3B0OTNMencyVWtWL0N4RWtY?=
 =?utf-8?B?bW5UMjBiOE9aaUR6LzB1d0kyMnF5WW1lZmlVNXAyYmtkVkdmeHByRk9Cclhv?=
 =?utf-8?Q?3v8FMkdTsBj/15usLCbd2x0vv?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ec7a79-bc43-4813-8653-08dc1e32ae76
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 05:50:20.2862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oJ5sVE9YiaXiJJgKKl/aaXXaUhtGRiTMwZSIZIWk34ViQthek41Vysdc4wfgVH5y9QQKUZaTk+AHZuXah0LYqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4933
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IGl2YW5AcnR4aS5vcmcgPGl2
YW5AcnR4aS5vcmc+DQo+U2VudDogRnJpZGF5LCBKYW51YXJ5IDI2LCAyMDI0IDc6MzUgQU0NCj5U
bzogeGVub21haUBsaXN0cy5saW51eC5kZXYNCj5TdWJqZWN0OiBSZTogVHJvdWJsZXNob290aW5n
IHg4Nl82NCBldmwgYm9vdHVwDQo+DQo+SGksDQo+DQo+V2hpbGUgdHJ5aW5nIHRvIGlzb2xhdGUg
dGhlIHByb2JsZW0gSSBjYW1lIGFjcm9zcyBhIHNldHRpbmcgdGhhdCBzb2x2ZWQNCj5teSBpc3N1
ZS4gUGFzc2luZyBtYXhjcHVzPTEga2VybmVsIHBhcmFtZXRlciBzZWVtZWQgdG8gZG8gdGhlIHRy
aWNrLg0KPlRoaXMgaG93ZXZlciBpc24ndCBhIHBlcm1hbmVudCBzb2x1dGlvbiBhcyB0aGlzIGZv
cmNlcyB0aGUgY29tcHV0ZXIgdG8NCj5vbmx5IHVzZSBvbmUgY3B1LCBzbyBJIGtlcHQgbG9va2lu
Zy4NCj4NCj5JIHRoZW4gbm90aWNlZCBzb21ldGhpbmcgd2hpbGUgdHJ5aW5nIHRvIHJlYWQgZWFy
bHkgcHJpbnRrIG1lc3NhZ2VzOiB0aGUNCj5jbGsgc3Vic3lzdGVtIGRpc2FibGVzIGFsbCB1bnVz
ZWQgY2xvY2tzb3VyY2VzLCBidXQgcmlnaHQgYWZ0ZXIgdGhpcyB0aGUNCg0KQWNjb3JkaW5nIHRv
IHlvdXIgbG9nLCBpdCBpcyBqdXN0IGRpc2FibGluZyB1bnVzZWQgY2xrIG5vdCBjbG9ja3NvdXJj
ZSAsDQpjbGsgYW5kIGNsa3NvdXJjZSBhcmUgcXVpdGUgZGlmZmVyZW50IHRoaW5ncw0KDQpDb3Vs
ZCB5b3Ugc2hhcmUgeW91ciBjb21wbGV0ZSBsb2cuIEJlZm9yZSB0aGlzIGxvZyBlcGlzb2RlICwg
aXMgdGhlcmUNCmFueSBvdGhlciBjbG9ja3NvdXJjZSByZWxhdGVkIGxvZyBwcmludGVkIGVhcmxp
ZXIgc3VjaCBhcyAiY2xvY2tzb3VyY2U6IFN3aXRjaGVkIHRvIGNsb2Nrc291cmNlIHRzYy1lYXJs
eSINCg0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQoNCj50c2MgY2xvY2tzb3VyY2UgaXMgc2Vs
ZWN0ZWQuIFRoZSBvdXRwdXQgbG9va3MgbGlrZSB0aGlzDQo+DQo+Li4uDQo+cG9ydCBzZXJpYWwx
ODI1MDowLjA6IGhhc2ggbWF0Y2hlcw0KPmFjcGlfY3B1ZnJlcTogb3ZlcnJpZGluZyBCSU9TIHBy
b3ZpZGVkIF9QU0QgZGF0YQ0KPlJBUzogQ29ycmVjdGFibGUgRXJyb3JzIGNvbGxlY3RvciBpbml0
aWFsaXplZA0KPmNsazogRGlzYWJsaW5nIHVudXNlZCBjbG9ja3MNCj5GcmVlaW5nIHVudXNlZCBk
ZWNyeXB0ZWQgbWVtb3J5OiAyMDM2Sw0KPkZyZWVpbmcgdW51c2VkIGtlcm5lbCBpbWFnZSAoaW5p
dG1lbSkgbWVtb3J5OiA0ODQ4Sw0KPnRzYzogUmVmaW5lZCBUU0MgY2xvY2tzb3VyY2UgY2FsaWJy
YXRpb246IDI2MTEuNjQ3DQo+Y2xvY2tzb3VyY2U6IHRzYzogZnJlcTogMjYxMTY0NzAwMCBIeiwg
bWFzazogT3hmZmZmZmZmZmZmZmZmZmZmDQo+bWF4X2N5Y2xlczogMHgyNWE1MzZkYjJmMCwgbWF4
X2lkbGVfbnM6IDQ0MDc5NTMxMDQ3OSBucw0KPmNsb2Nrc291cmNlOiBTd2l0Y2hlZCB0byBjbG9j
a3NvdXJjZSB0c2MNCj4NCj5hZnRlciB3aGljaCBpdCBoYW5ncywgdGhlbiBvdXRwdXRzIHRoZSBz
dGFja3RyYWNlIGRlc2NyaWJlZCBwcmV2aW91c2x5DQo+YXQgNjAgc2Vjb25kIGludGVydmFscy4g
SSB0aG91Z2h0IHRoYXQgcGVyaGFwcyBzb21ldGhpbmcgZ29lcyB3cm9uZyB3aXRoDQo+dGhlIGNs
b2Nrc291cmNlIHNlbGVjdGlvbiBhbmQgc29tZWhvdyB0aGUga2VybmVsIHRyaWVzIHRvIHNlbGVj
dCBhDQo+ZGlzYWJsZWQgY2xvY2tzb3VyY2UuIEkgcmVtb3ZlZCBQb3dlciBNYW5hZ2VtZW50IFRp
bWVyIFN1cHBvcnQNCj4oQ09ORklHX1g4Nl9QTV9USU1FUj1uKSwgYWxvbmcgd2l0aCBvdGhlciBs
YXRlbmN5IHJlbGF0ZWQgY29uZmlncyBsaWtlDQo+Q1BVIEZyZXF1ZW5jeSBTY2FsaW5nIChDT05G
SUdfQ1BVX0ZSRVE9bikgZnJvbSB0aGUga2VybmVsIGNvbmZpZ3VyYXRpb24NCj5hbmQgdHJpZWQg
YWRkaW5nICJjbG9ja3NvdXJjZT10c2MgdHNjPXJlbGlhYmxlIiBrZXJuZWwgYm9vdCBwYXJhbWV0
ZXJzDQo+dG8gYXZvaWQgY2xvY2tzb3VyY2Ugc3dpdGNoaW5nLCBhbmQgdGhhdCBjb21iaW5hdGlv
biBib290ZWQgdGhlIG1hY2hpbmUNCj5jb3JyZWN0bHkhDQo+DQo+SXMgdGhpcyBhIGJ1ZyBpbiB0
aGUgbG9naWM/IEknbSBub3Qgc3VyZSBob3cgdG8gcHJvdmUgdGhhdCB0aGlzIGlzIGENCj5wcm9i
bGVtIHdpdGggdGhlIGNvZGUgb3IgbXkgbWFjaGluZShzKSBhcmUganVzdCB0b28gb2xkLiBJJ3Zl
IG9ubHkgYmVlbg0KPmFibGUgdG8gdGVzdCB0aGlzIG9uIG9uZSBtYWNoaW5lIGFuZCB3aWxsIHJl
cG9ydCByZXN1bHRzIGZvciB0aGUgb3RoZXJzLg0KPkF0dGFjaGVkIGlzIHRoZSBrZXJuZWwgY29u
ZmlndXJhdGlvbiB0aGF0IHdvcmtlZC4NCj4NCj4tSXZhbg0KPg0KPk9uIDIwMjQtMDEtMjIgMTQ6
NDAsIGl2YW5AcnR4aS5vcmcgd3JvdGU6DQo+PiBIZWxsbywNCj4+DQo+PiBJIHVzZWQgdGhlIGNv
bmZpZyBmcm9tIHhlbm9tYWktaW1hZ2VzIHN1Z2dlc3RlZCB3aXRoIEVWTCBlbmFibGVkIGFuZA0K
Pj4gdGhhdCByZWFjaGVkIHRoZSBsb2dpbiBzY3JlZW4hIEl0IGlzIG9idmlvdXMgZnJvbSB0aGlz
IHRoYXQgc29tZQ0KPj4gY29uZmlndXJhdGlvbiBvciBtb2R1bGUgaXMgdGhlIHByb2JsZW0sIGJ1
dCBJIGRvbid0IGtub3cgd2hhdCBpdCBjb3VsZA0KPj4gYmUuDQo+Pg0KPj4gV2hhdCBzaG91bGQg
SSBkbyBuZXh0PyBUaGUgb25seSB0aGluZyBJIGNhbiB0aGluayBvZiBpcyBzbG93bHkgc3RhcnQN
Cj4+IGVuYWJsaW5nIGFueSBkcml2ZXJzIEkgbmVlZCB1bnRpbCBJIGhpdCBhIHByb2JsZW0sIGJ1
dCB0aGF0IHNlZW1zIGxpa2UNCj4+IGEgY3J1ZGUgd2F5IHRvIGZpbmQgdGhlIHByb2JsZW0uIEFu
eSBzdWdnZXN0aW9ucz8NCj4+DQo+PiAtSXZhbg0KPj4NCj4+DQo+PiBPbiAyMDI0LTAxLTE5IDE2
OjA2LCBpdmFuQHJ0eGkub3JnIHdyb3RlOg0KPj4+IEhlbGxvLA0KPj4+DQo+Pj4gT24gMjAyNC0w
MS0xOCAwMTo1MSwgSmFuIEtpc3prYSB3cm90ZToNCj4+Pj4gSGksDQo+Pj4+DQo+Pj4+IE9uIDE4
LjAxLjI0IDAwOjIyLCBpdmFuQHJ0eGkub3JnIHdyb3RlOg0KPj4+Pj4gT24gMjAyNC0wMS0wNCAx
MzozNCwgaXZhbkBydHhpLm9yZyB3cm90ZToNCj4+Pj4+DQo+Pj4+PiBIZWxsbyBldmVyeW9uZSwN
Cj4+Pj4+DQo+Pj4+PiBJIHRyaWVkIGJ1aWxkaW5nIGFuZCBpbnN0YWxsaW5nIHdpdGggYSBuZXdl
ciBrZXJuZWwgdmVyc2lvbg0KPj4+Pj4gKHY2LjYueS1ldmwtcmViYXNlKSBhbmQgaSBnZXQgdGhl
IHNhbWUgZXJyb3IgZHVyaW5nIGJvb3R1cC4gVGhpcw0KPj4+Pj4gdGltZQ0KPj4+Pj4gaG93ZXZl
ciwgdGhlcmUgaXMgYW4gYWRkaXRpb25hbCBtZXNzYWdlOg0KPj4+Pj4NCj4+Pj4+IGNsb2Nrc291
cmNlOiBTd2l0Y2hlZCB0byBjbG9ja3NvdXJjZSB0c2MNCj4+Pj4+DQo+Pj4+PiBBZnRlciB3aGlj
aCBpdCBoYW5ncyBmb3IgYSBtaW51dGUgdGhlbiB0aGUgc2FtZSBvdXRwdXQgcHJldmlvdXNseQ0K
Pj4+Pj4gZGVzY3JpYmVkIGlzIHByaW50ZWQuIEFtIEkgZG9pbmcgc29tZXRoaW5nIHdyb25nPyBX
aGF0IGFkZGl0aW9uYWwNCj4+Pj4+IGluZm9ybWF0aW9uIGRvIHlvdSBuZWVkPw0KPj4+Pj4NCj4+
Pj4NCj4+Pj4gWWVzLCBrZXJuZWwgY29uZmlnLCB0byBiZWdpbiB3aXRoLiBBIGNvbXBsZXRlIGJv
b3QgbG9nIHdvdWxkIGFsc28gYmUNCj4+Pj4gbmljZSAoY2F0Y2ggdmlhIFVBUlQsIHBsZWFzZSku
DQo+Pj4NCj4+PiBBdHRhY2hlZCBpcyB0aGUga2VybmVsIGNvbmZpZyBmb3IgdGhlIGJ1aWxkLiBV
bmZvcnR1bmF0ZWx5IEkgZG9uJ3QNCj4+PiBoYXZlIGENCj4+PiB3YXkgdG8gY2FwdHVyZSBlYXJs
eSBwcmludGsgbG9ncyB0aHJvdWdoIFVBUlQsIGJ1dCBJIHdpbGwgYXR0ZW1wdA0KPj4+IG90aGVy
IHdheXMuDQo+Pj4NCj4+Pj4NCj4+Pj4gVGhlcmUgaXMgbm93IGEgZGVtbyBpbWFnZSwgYWxzbyBm
b3IgeDg2LCBnZW5lcmF0ZWQgdmlhIHhlbm9tYWktaW1hZ2VzDQo+Pj4+IChjdXJyZW50bHkgb25s
eSBpbiAnbmV4dCcpLiBUaGF0IGNvbmZpZyAoWzFdICsgWzJdKSBtYXkgYmUgbGFja2luZw0KPj4+
PiBzb21lDQo+Pj4+IGJpdHMgeW91IG5lZWQgZHJpdmVyLXdpc2UsIGJ1dCBtYXliZSBpdCdzIHdv
cnRoIHRvIGNoZWNrIGFuZCB0cnkgaWYNCj4+Pj4gdGhhdA0KPj4+PiBvbmUgbWFrZXMgYW55IGRp
ZmZlcmVuY2VzLg0KPj4+DQo+Pj4gSSB3aWxsIHRyeSB0aGlzIGFzIHdlbGwgYW5kIGxldCB5b3Ug
a25vdyBpZiBhbnl0aGluZyBjaGFuZ2VzLg0KPj4+DQo+Pj4+DQo+Pj4+IERvIHlvdSBzZWUgdGhp
cyBib290IGlzc3VlIG9ubHkgb24gdGhlIFBoZW5vbSBoYXJkd2FyZSBvciBhbHNvIG9uDQo+Pj4+
IG90aGVycz8NCj4+Pj4NCj4+Pg0KPj4+IFRoZXJlIGFyZSBhIGZldyBvdXIgb2xkIG1hY2hpbmVz
IHRoYXQgc2hvdyBzaW1pbGFyIGlzc3VlczoNCj4+PiAgIDEuIEludGVsIFhlb24gdzM2ODAgKFVz
ZWQgdG8gaGF2ZSBYRU5PTUFJK0lQSVBFKQ0KPj4+ICAgMi4gSW50ZWwgQ29yZSAyIER1byAoTm8g
eGVub21haS90ZXN0aW5nIGxhcHRvcCkNCj4+Pg0KPj4+PiBKYW4NCj4+Pj4NCj4+Pj4gWzFdDQo+
Pj4+IGh0dHBzOi8vc291cmNlLmRlbnguZGUvWGVub21haS94ZW5vbWFpLWltYWdlcy8tL2Jsb2Iv
bmV4dC9yZWNpcGVzLQ0KPmtlcm5lbC9saW51eC9maWxlcy9hbWQ2NF9kZWZjb25maWc/cmVmX3R5
cGU9aGVhZHMNCj4+Pj4gWzJdDQo+Pj4+IGh0dHBzOi8vc291cmNlLmRlbnguZGUvWGVub21haS94
ZW5vbWFpLWltYWdlcy8tL2Jsb2IvbmV4dC9yZWNpcGVzLQ0KPmtlcm5lbC9saW51eC9maWxlcy9l
dmwuY2ZnP3JlZl90eXBlPWhlYWRzDQo+Pj4+DQo+Pj4+PiBUaGFua3MsDQo+Pj4+PiBJdmFuIEYu
IFZhbGVyaW8NCj4+Pj4+DQo+Pj4+Pj4gSGVsbG8gYWxsIQ0KPj4+Pj4+DQo+Pj4+Pj4gSSBoYXZl
IGJlZW4gdHJ5aW5nIHRvIHVwZ3JhZGUgYSBkZXNrdG9wIHRoYXQgdXNlZCB0byBoYXZlIFhlbm9t
YWkgMw0KPj4+Pj4+ICsNCj4+Pj4+PiBJUElQRSB0byB0aGUgbmV3IEVWTCBzeXN0ZW0uIENvbXBp
bGF0aW9uIGlzIHN1Y2Nlc3NmdWwgYnV0IHRoZQ0KPj4+Pj4+IGtlcm5lbA0KPj4+Pj4+IGhhbmdz
IGR1cmluZyBib290IHdpdGggYW4gcmN1IGVycm9yIG1lc3NhZ2UgZm9sbG93ZWQgYnkgYSBzdGFj
aw0KPj4+Pj4+IGR1bXA6DQo+Pj4+Pj4NCj4+Pj4+PiByY3U6IHVubGVzcyByY3VfcHJlZW1wdCBr
dGhyZWFkIGdldHMgc3VmZmljaWVudCBDUFUgdGltZSwgT09NIGlzDQo+Pj4+Pj4gbm93DQo+Pj4+
Pj4gZXhwZWN0ZWQgYmVoYXZpb3IuDQo+Pj4+Pj4gLi4uDQo+Pj4+Pj4gQ2FsbCBUcmFjZToNCj4+
Pj4+PiA8VEFTSz4NCj4+Pj4+PiBfX3NjaGVkdWxlKzB4ZDc2LzB4MTk1MA0KPj4+Pj4+ID8gc2No
ZWRfY2xvY2srMHg5LzB4MTANCj4+Pj4+PiA/IHNjaGVkX2Nsb2NrX2xvY2FsKzB4MTcvMHg5MA0K
Pj4+Pj4+ID8gaW5iYW5kX2lycV9zYXZlKzB4ZS9VeDMwDQo+Pj4+Pj4gc2NoZWR1bGUrMHg2OS8w
eDExMA0KPj4+Pj4+IHNjaGVkdWxlX3RpbWVvdXQrMHgxOWEvOHgyZjANCj4+Pj4+PiA/IGRlbF90
aW1lcl9zeW5jKzB4NTAvMHg1MA0KPj4+Pj4+IHJjdV9ncF9mcXNfbG9vcCsweGY5LzB4NDcwDQo+
Pj4+Pj4gcmN1X2dwX2t0aHJlYWQrMHgxNWEvMHgyMTANCj4+Pj4+PiA/IHJjdV9ncF9pbml0KzB4
NjQwLzB4NjQwDQo+Pj4+Pj4ga3RocmVhZCsweDEyYS8weDE1MA0KPj4+Pj4+ID8gc2V0X2t0aHJl
YWRfc3RydWN0KzB4NTAvMMOXNTANCj4+Pj4+PiByZXRfZnJvbl9mb3JrKzB4MjIvMHgzMA0KPj4+
Pj4+IDwvVEFTSz4NCj4+Pj4+Pg0KPj4+Pj4+IEFmdGVyIHNvbWUgZGlnZ2luZywgdGhlIGV2bCBw
YWdlIHJlZmVyZW5jZXMgcG9zc2libGUgaXNzdWUgYXMNCj4+Pj4+PiAibG9vc2luZw0KPj4+Pj4+
IHRoZSB0aWNrIGRldmljZSIgYnV0IGRvbid0IGtub3cgaG93IHRvIGNvbmZpcm0gd2hldGhlciB0
aGF0IGlzIHRoZQ0KPj4+Pj4+IGNhc2UgaGVyZS4gVGhpcyBjb21wdXRlciB1c2VzIGFuIEFNRCBQ
aGVub20gSUkgWDYgMTAzNVQgcHJvY2Vzc29yDQo+Pj4+Pj4gYW5kDQo+Pj4+Pj4gVGhlIGtlcm5l
bCBicmFuY2ggdXNlZCBmcm9tIGxpbnV4LWV2bCByZXBvIGlzICJ2NS4xNS55LWV2bC1yZWJhc2Ui
Lg0KPj4+Pj4+IEFueSBzdWdnZXN0aW9ucyBvbiBob3cgdG8gdHJhY2sgZG93biB0aGUgaXNzdWU/
DQo+Pj4+Pj4NCj4+Pj4+PiBSZWdhcmRzLA0KPj4+Pj4+IC1JdmFuIEYuIFZhbGVyaW8NCj4+Pj4+
DQo+Pj4NCj4+PiBUaGFua3MsDQo+Pj4gSXZhbiBGLiBWYWxlcmlvDQo=
