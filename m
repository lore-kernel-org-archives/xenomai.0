Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCC7224C6
	for <xenomai@lists.linux.dev>; Wed, 20 Mar 2024 07:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710920542; cv=fail; b=cSPsT8K4IXUFq414LJa/ZTn4FS18utN5UvV5bXXRXIwQqh7Rqoy2/WKEo5PSvcQ864DdjbXcHKhAqlaRuURr7gc3AL7dgrvLkD7U+ofOa1kulkI6gTTQ02k9eerUFXy0JCxu08WGS3bouEmb7mOMTgqq3/9QKmQ6zOy4nybY6Hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710920542; c=relaxed/simple;
	bh=Ybqmq6oW6fNysvoXJoNAWX/CepAYocQtao/IVJmQq+w=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Svkj6x19r61/R0czRFSww4XIwrqebHGXXImFwLbyZScakhB2GW+Wg0b4GB1PUZfc2EjmDuiRV1TY4RfOAZYY1ZEcO/tmV7TV6x55egyTTuPYBJspPXHyBzWVqc+UOY6L4YIYTpM5K/g6TG21cz6NJElwIRe62H2/UrJkZDih5dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nfJAi7GL; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nfJAi7GL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710920540; x=1742456540;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=Ybqmq6oW6fNysvoXJoNAWX/CepAYocQtao/IVJmQq+w=;
  b=nfJAi7GLnbTsZq1NRjOmD6rETtTlZtZ7+sSgW+bOcIqGYE0eAcPs4Fze
   F+ScJBYBd1aj8AvSdZzWvNF4cQyXZ5IUiEXj+FmrYWa4bc+G4Q7TRrpj2
   FbpSTgPsWP4bwk4uaTvUvbY1FXm+wAoZ+9VJp6yV+QbzkMo7oXSjXD5gS
   gXgnGGBEZaBRFLtI1f8i+pcWvQO2N9elsa1GWBuPDzWdfEd3ltaH2MNHQ
   b88e9njywrGMylmASISEK+FJkyOGjttp/K8ibaCQtCXo8AyPj8uae3JuE
   JCaG9dBH8q+4ovXGCdGS8YyYZnx6gTzurrKDK0DchYd106kAAI0fYqxLO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="5677501"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="5677501"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 00:42:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="45039477"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Mar 2024 00:42:19 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 00:42:18 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 00:42:18 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Mar 2024 00:42:18 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Mar 2024 00:42:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bC3ZsHXqQ0WJnKZQgxi5nqoqb9R49MqjlXQfs8sqyDZ/zoBZrbThHY49lx5hNY0vRwzmo+/dlgUMG4uIYVjKteksTpPDJPLjwAGdqorEQw1t3WfNl3lm1DA4DV24A92zyiJz5OAvwdw8uoJoyEmhK6YfSd4gXxRgM+Ubw63b0TAwnMkiXVMndYzrOCHnEbBHmBIlEsQIDtt0k/4r/n+DSeg+rmYHJPoeXfCgQMSJbdFYwvwsU7BjptlKzECFQYr3ALJHMU4q4lrHBNrol/kwX3rnXkyqh88LVvUdITD+4ICKJEa5qVfjhgUdZO+syYE3/Ez/zSVAn5IxNv8Xz5ftSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ybqmq6oW6fNysvoXJoNAWX/CepAYocQtao/IVJmQq+w=;
 b=LOhx0QZePNYwAVBcP2gonYRFqzzxLOQZ3OcOWTiI+X+aAJaJsHVHdyvaZUh4BM9czAOHXfm5Ya0Nj5HmYL1wsdDiy8MlbGYyP35RlTUJvgjqvJya7N2Q6jJL/lOORkf1knJ+RZWF6RNSScfyEZYVinV+NTidt+Jgy+MjDt2IAYaE6shZpACykAWE1C0/8uAYqv/y4tpNZ4DFLtCHD51zhAjQZ+HcAsYPNLMjjXS1sZbHM1iEZcp+pfoF40ah8/vaWmp5EP9gV4v3p5XD5E1JVCG6Epa1wPkxbFdB0DgXTvf5RHK+We1Pax/Y0ZtcCaYB0cdwAPkki+YgiquxUQVgAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by SN7PR11MB8281.namprd11.prod.outlook.com (2603:10b6:806:26b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.17; Wed, 20 Mar
 2024 07:42:16 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::19d6:5ade:3ea:583d]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::19d6:5ade:3ea:583d%3]) with mapi id 15.20.7409.010; Wed, 20 Mar 2024
 07:42:16 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Xenomai Community Call Minutes - Mar 20, 2024
Thread-Topic: Xenomai Community Call Minutes - Mar 20, 2024
Thread-Index: AQHaepoh3+5Q0P7sh0KMLphr5tzLYg==
Date: Wed, 20 Mar 2024 07:42:16 +0000
Message-ID: <PH7PR11MB7499EACD21DC834251DCFBD8F2332@PH7PR11MB7499.namprd11.prod.outlook.com>
References: <PH7PR11MB7499F7DDE006A3A7291F61FAF27B2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749929DFFDCFE47376883636F2572@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499F4FFFC62E15096DFF8D3F2562@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749910600BAF97BCB41DC3D3F2202@PH7PR11MB7499.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB749910600BAF97BCB41DC3D3F2202@PH7PR11MB7499.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|SN7PR11MB8281:EE_
x-ms-office365-filtering-correlation-id: da7e0c35-6a3c-43a3-50f3-08dc48b143fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DrMobw2aMjvxJoGJqhFgf4zKtfUrl3cz2gWdKpp+yBKmJo60QhpDnBLWExHiusnaeHmRqGH8Os/bDuIUlEAtwCcB7XnCd9UIQsqJvDKdtV98/bHz0nBcJKo9ilkB1TrYeRjwXL2UnHuWXNTZClDX46ZIqzwczpIBDGll4G/8HFz+hs+P5KKQi/oY+0Sl3ZR5SaKk/nQSlqYvY7vm09tlvY3/BbqIrfLWx84crC53A0fyPslN9W+V/bjIlfZez84s+08nqCRkIcc3JKtobyvoouLZFiMJeLzYSbULUoENJSPU9vsucRUzKKj+HjOd2lE/hwyRxmflpOW2hRTqkaqUcA0++84p9VRMRZkjyCTsNepw3EDXmVxPpcWKRNK0TYVqH5Mzxmp496caViNg6fuxHMrvDZIJOtGnkqX2IgufssD6rLfio7PTE3BXmWp1ys8DFT8MJKnZch2DS/eg7uUyRLKQWsI7XKv1LNBQoQJVxTpRFhk6Dvm1kumseczRgb70Kkk1L6JAtdgag52pqA5n6zBabjD8oJl/3F3xxcAZuA9+gjyg7bi5RiZiqEB6d4PHq+KgtWzzKWC9hmj/3NDR1gcAvQ+m1TB1VeMg3zJCIBFXN4f0Fb2KubnceY9m3k7pMcgLnNi3VAAgCGBbCmWTmogvfjp8dHyA2jDenrlv20MT3I1OSTedJDVXKoUBUo8AcmuIiCqd8d7nZerqTNytkA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTE1a0VzZ0NHRm5lUlVnMG9PZjJGb0VhRERIQ3p2Vkx1M1NLcmt3b05oNEll?=
 =?utf-8?B?VGVlSGFuRExuY29rOTdaODJOVU91MjN5a2R6N2N1MkwxTCtFRUlub0ZqbDAz?=
 =?utf-8?B?UW1WNm9rc3ljQkdWRjFLRFAzWUVTOTdUNFJwaFVHcEZ0YTlLL01FR2ZCN0s2?=
 =?utf-8?B?OTNRREE4VXkydlk1MkJrZWdLdDBFY2FLOEg4elNHMjkrR1dkL1BKYnE3aFE2?=
 =?utf-8?B?alRqeTFuYld3TS9TdWl0R1R3VDg5WGJ1a3BlZ0syaFJka3VLd0szcFE0cWow?=
 =?utf-8?B?a3k4eGhWZno0a1l2cU1ReENJUTcvbmNOMU1wT3dqTUNsdmtReVhxQjlWMHBv?=
 =?utf-8?B?aGpvR3MrNHJTWitLcExBcHdHS0xZK2dzaEIvVXd1ZDNXYTY3Mys2TUVVN0Fv?=
 =?utf-8?B?NnQzVkh0dHJmWUZ2MjhoSzJlb05uZDFkSnBud2ZvQTF3aTRVbXF5eEQrejNx?=
 =?utf-8?B?bEd4M2UweE1sazRUdHljamI5dXpaZzNDY1dudlZCRGVYRmpSeHdnc3lIL285?=
 =?utf-8?B?cTJ3OGdMOFpFd1F4RGZ3bURKREFZYkI4UGlBdU1lazI3QzQ5Z3prQitBQ3dM?=
 =?utf-8?B?Y1J3SUFMWHJuNndwVHZWekt6NnkyWWFDL3JsM1F5enBRYTBMdEM4SG1qRjZE?=
 =?utf-8?B?SEkxemJ2T0NnN3JleWkveEFjQzRmRWlFRDl1dW80SjlETUI2czVBa29USWdq?=
 =?utf-8?B?WmZxT240WmlPcFRqSGlBWjVIQjRMcWh4Q2lKRDl6SlFuOXg0eWZuVWZYR1Bj?=
 =?utf-8?B?aUNHWXgxWUduL0Jvakc0ZkMzSVNvRjc1T2huYmY5TTIvdjUwWWFHYVlvaU9m?=
 =?utf-8?B?R3pWY1R3VjNRcnZkNVR1NWF1V3BsQk85L08weEllejdZbEc4L1ZEZXdpbnJn?=
 =?utf-8?B?QktNRitEZXJHT0RLSDZUNXAzdnhWeHFDYVJqc1NwNG5OcXNqUW85bUREWXpK?=
 =?utf-8?B?dXRROTZ5a05ZZy93YUJTZUpSQnJESDE5bjB6S0t4TzAvZll1SDU3RWNFam5T?=
 =?utf-8?B?ckNuQ2U2dlRPK3RyQUJSMG1wNEh0b0wwQXQ5bzJIS05Rb3dHVWdDQ0JZT3Jo?=
 =?utf-8?B?TE5TM2hxWEw2SUV5VUdWeXNJRDBwVW5uMnV0WUpwRzRReWlFN3F2b05aUXU0?=
 =?utf-8?B?SEY3MVc1VzJWM2hkb3cvbzNETUc3QmEzNnp2d0hkQkY3ZFpkQmduWkZyU1lU?=
 =?utf-8?B?U0lzTUpZckxKdjU3T0kvUTdiQm13dWFkWjArbTlHM0ZPMkZ6SWtTZUR1RGhw?=
 =?utf-8?B?Mkt3ZEpQcy9LYjVvS0xmZmJCajN6UlNQeHFURG5GVnNQZ1BMd21BdW03alpY?=
 =?utf-8?B?VlVPWitVb1FnWW5Ubk1DRHg4RHlKcnZXb0dxbjdtRWh5ZUlYOFFEQlM1UURt?=
 =?utf-8?B?YlRuR2tsKzhxWmlIa1NvMWQ4dm9rdHc1VUxLVWNOOFVZT3NSM0lNNkhLeU54?=
 =?utf-8?B?aS9wZ1ZQb2llRXRSY3VEQ2oySGRmeUk1SCtDZlhYTGU5RTNpT3JybitxbVJO?=
 =?utf-8?B?Zm5uTnBFMVdRaUVsOU9kb0hPVUFmaG1hcHlHbWdTd2pzOGxWbVFEMUtYZkpU?=
 =?utf-8?B?Tm9HbHVFcksrS0JNakFDWVZUc3BEelI0NlNkSDBEdUdnVE1waGQyeGFmVXl2?=
 =?utf-8?B?V2lYeExxdWh1RFB2K2IzZUR4WVlVWGpoemVBQTBML0lBMEVJdkR4elhvL3Bl?=
 =?utf-8?B?Zm1uRDZzdnNubzRSaWtaeU1mblhMT296SmdkekVXNWJaa2RPTHBXdkxMcHFu?=
 =?utf-8?B?ditqOEMrZ1VWb3ZESWdMa000aXMvUmc3anNGclFkZUFXdGxsd1l4T084WVIx?=
 =?utf-8?B?U3lGQUVSSW9PSmxLdTdKRTNDSmRlMXBiMEVVaTRmdkdod2lRaWJxdStka2pi?=
 =?utf-8?B?amdQV0xpbkZ6aStISnhhbUJZSGlxdmNVTit1eUJqOEtmc294ZFJJc2dLK0x2?=
 =?utf-8?B?VDgwRmpaeTZZK280Y0tGUENOTERBbmplQTROQ1p1b0NUOGJSMlhPNGkvN3p5?=
 =?utf-8?B?bjc1K1NWK2Z2NTZIR3h0VmhkeDNDQ1hjTUFHV2hROXMxMnpmMG8zUFpPM3dJ?=
 =?utf-8?B?RFBvbmUxUk0vTkMwREdNNFBLY2JWWi9TdGFUemdzSkQyV0psUjdFdnZhaWwz?=
 =?utf-8?Q?9Ge7lMOXmXAxMCQlXoyEh36Wr?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: da7e0c35-6a3c-43a3-50f3-08dc48b143fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 07:42:16.6736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gUJFce/IS5ycs+rm/bIYtZz/7xckPmYcPpZJlJiklqjp1/XRabzScabVW9hcnVKNGNPm9WzDkLRORD9NKbzlnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8281
X-OriginatorOrg: intel.com

DQpBdHRlbmRlZXM6IEphbiBLaXN6a2EsIEZsb3JpYW4gQmV6ZGVrYSwgUmljaGFyZCBXZWluYmVy
Z2VyDQoJCUNsYXJhIEtvd2Fsc2t5LCBEYXZpZCBPYmVyaG9sbGVuemVyLCBQaWVycmUgRklDSEVV
WA0KCQkgSGFvIExpLCBIb25nemhhbiBDaGVuDQoNCkNvbW11bml0eSB1cGRhdGU6DQoJCVRlc3Rz
dWl0ZSBwYXRjaGVzIC0tICB1cGRhdGVkDQoJCVRocmVlIGlzc3VlcyByZXBvcnRlZCAtLSBuZWVk
IHRvIGZpeCANCgkJTmV4dCB0d28gbWVldGluZ3MgLS0gY2FuY2VsbGVkICggM3RoIGFuZCAxN3Ro
IEFwcmlsKQ0KT3BlbiBkaXNjdXNzaW9uOg0KCQlTaWduYWwgaGFuZGxpbmcNCgkJSU8gdGVzdGlu
Zw0KCQlTSUdERUJVRyBzdGFjayB0cmFjZQ0KDQpSZWdhcmRzDQoNCkhvbmd6aGFuIENoZW4NCg0K
CQkNCgkJDQoJCQ0K
