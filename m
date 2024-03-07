Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691504C6F
	for <xenomai@lists.linux.dev>; Thu,  7 Mar 2024 01:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709774157; cv=fail; b=TanFcAjQ7QE4zyDCx8jRpONABXT+10ihdGh9GKgBx+bIIgXenMq1HPSMAQBTMiY2ZIpUaVIfEzJXrsySwHugQ2YOlYHDAgnUfY6zbR6T1wS8yIvZNoO3nyhml9QW26nL+ljd212+W+hFaU89IgBUJReDrW5wmFyz0wLhllGr9Qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709774157; c=relaxed/simple;
	bh=dzJLm9cNCnKBjNfxReSBHdAqS/sdwnvFdvplmznUQa4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JejufyMdMSXyUF1pp90DYuFSyNvP2vf20q+kFDy5ODrN7zJy0RU6Q53IGTJm0KOWwHhdqzBfp2PgbXZiIG2rh6dwI2OWGsn7q1ziNZAqSpHtl1N3woHGgCPeGwlWVGxXCBYvMA4o5pBuPwxiNmTSWXvePhbwGU2ENBeh5PILkQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EttmRqh4; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EttmRqh4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709774156; x=1741310156;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=dzJLm9cNCnKBjNfxReSBHdAqS/sdwnvFdvplmznUQa4=;
  b=EttmRqh4dvFYm0cLx28Qvs5IQ2ls01zU46gT0QcM8fWCGegq+PjGA+t9
   9ttTIKbt/gDVczkgIXm0XCaCTHAXyg/a7SzFXYmNvK0SsKIMJkGMW/rTd
   X2bTV0StPAh3T13DRWrYnWv9lfvB6GUQtmNTbqe3L0+N8IeG+PUsVvdxY
   GX+0VijQDNJ4keG7DqkiIZcPKeDLfh+fkWCFWIY27gYRH3wuTdOBa6irP
   KiYee+6LcCkY534Qa2axqXUTOgBAa1mGe8bZLRaMqEcB+WCeWJkEwPBJr
   4mgwXrdGxpP4OA9JUbWyDOoL/tXxEjNMeiMHjH0kcZLq3jm7wg/APMrAo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="4547337"
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="4547337"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 17:15:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="9925294"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Mar 2024 17:15:54 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 17:15:54 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 17:15:53 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Mar 2024 17:15:53 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Mar 2024 17:15:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BmGPidegzQAZVtirfp1/2k+7SPGJ9z34f7XL+EeWbov6RgPJVbQNXW5EPhlO3s5MCEZ4Rwbp/F5RD8naoQ35hhwFtSiZLOYnMuPHjMjvLy76LfMHIdcgglGyOXgLKEYNv/9RcIIMewe1VEcQOBfSNLnxsQa6qNUSXXKaNEbRFpKrvj9jWmf0zZgf7by5SS0qAT66h81qmWJaGlHV7qqfVEH3cGvJ7+aTtSa2sUu+2QnWl1ceT3VauZ1l9mtcsNVjlOtJW7LfIx/dbQwn9vEEiLJJS3w3QK/afbAedgQ/39l5QL+kLGu8I22pHqSFDu0OfQvWYJ0bMcx+mQWo6NkSHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzJLm9cNCnKBjNfxReSBHdAqS/sdwnvFdvplmznUQa4=;
 b=MYX33EGM6ef9sbF1BQbSmIZgwgwQpgntQtEZiLbLJnUBQ2+EbwFXin5LKeJuf+N6YWrR4LCLVHoGDjyKYMCFEEyMXwNoPraVft3Zor6kwnWUuk4Tg6p3TJjbiiL6244I3yOpiebUS+nrTyvDExuXO1KRwezYi62CihrgOWn7xZOkskqXBUgyZM7eAk2iBRhdOKMDfZOjoLE7JJ6Ngz7pNSoIm386ZpUmKEbTEiCxGLIlzV9ZxecXB8xpqsrav5R8ExptuQQx6Wzmrx1uYwTL8f9YXo6xfmUZ6fWp5lgdSUaE9lKyBnzNjkC4avaiz5rf3nL5v+wcsvTvWEixP93Khg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by PH7PR11MB7477.namprd11.prod.outlook.com (2603:10b6:510:279::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.23; Thu, 7 Mar
 2024 01:15:52 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::16d:5f07:19bb:6900]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::16d:5f07:19bb:6900%4]) with mapi id 15.20.7386.005; Thu, 7 Mar 2024
 01:15:51 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Xenomai Community Call Minutes - Mar 6, 2024
Thread-Topic: Xenomai Community Call Minutes - Mar 6, 2024
Thread-Index: AQHacCz+VOHwRcngoEiUEv9WSMvtjg==
Date: Thu, 7 Mar 2024 01:15:51 +0000
Message-ID: <PH7PR11MB749910600BAF97BCB41DC3D3F2202@PH7PR11MB7499.namprd11.prod.outlook.com>
References: <PH7PR11MB7499F7DDE006A3A7291F61FAF27B2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749929DFFDCFE47376883636F2572@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499F4FFFC62E15096DFF8D3F2562@PH7PR11MB7499.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB7499F4FFFC62E15096DFF8D3F2562@PH7PR11MB7499.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|PH7PR11MB7477:EE_
x-ms-office365-filtering-correlation-id: b5d30c09-1922-4e6c-ccd9-08dc3e44215d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6HmxZnL8H/srF0Zmdp4hELXVEsIXyNIr0pY3wmEhuLvvU05XTIHLZOjZZ0e1vQMjPhPFcIWKdUVbD0CZr6SCpF0Q8SNUD/TgfXWlfRwtiNNOjAVCOI8Cj5VnrXt2Gbd3QVwoAkIN8o5fgExsf9IH9sUY5pR8fkeOCZCe1qDd0Xxj6i5mbbQCVzZdL4xAl5ZZlb2N6gMVVRShsTvASMlZL9hr5xZYg0fU73eLNixklH2d7XJi/OBqjT6oj3EkVcZjpADxhADMQ6DtnFzeVSK+RUGf9ok9+1h2dYYdXlU2sflI8QwvfTNbBwCWKzO/kdR140Lhe+HkpBsF1IIgSFy2dQEiOwvmUSgFxq+w8M1ArU1bFEzCkk+PFEmDhTy71IdqK1tX5cMR/d+vL0rKbdLdCe1XLsvqK0cTe/3+oR5aYuvkOW37qmN3tGjThep8LI1G0hcnTyZR8eqR0AZan1C1o9BIJQW0u946YcjiN2Mdy/bBEUY4s1CmumuK/G6qN80svi5jkqfcpWHkTPuRJeaKvj5ebzTQQ5yXLnIvbepoNRgosTnLmj/ezLBQMJ4vPUdH68s6st5ZVEf3ju4j5hn5EDpZi/61J+Fg9TDzavkFYXqZvYB80iEkgY1IfVGqy1baVJhJvbAArR4HA1grwQMJReWetOjnNruE4Osqy2K/BJQpQw1wlCnUNhVQwXPxsdv2nyRTMw1ihm/5+xe1kqhbtQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OExtd0JaRW1veDV3MnZoT2x0aEpFNFFRTjE2MjUwaGwxdG84WStpMWQ1N0ta?=
 =?utf-8?B?d0VmMXF5cy8zdU9BOE4xZW0ySDZnajFGOVJHa012dlNqbWNlWStoY2N0Z0Vp?=
 =?utf-8?B?aVZoTkJtYjFTamY2K3NTeXBha21MU1ZqUEF2MnhtMC8yRS82czJ6RHFLc2RJ?=
 =?utf-8?B?UFRkQXZBWUhBc0hzUW0zWjVhZ1J4ZzRoWlF6N2lGazk1YjFJZmtyS3RKeDlv?=
 =?utf-8?B?MXBNMm9INTdYY2UzdkNxdG5mYkpTdGRtQnpHSmhqdW1vRnMyZ2xmYmVIMHhS?=
 =?utf-8?B?TTkwUFpUQ1hGU1djU3Q0RGlKbGEyMnlIeGg0cjVHTkYvTU5SaXBPZkd5WjRk?=
 =?utf-8?B?U2tHbmxNVTJ5TE9wRHpaQnRZUDcwNVRGWTRvbWxtK1dZZlpIcktMQldYV0ZJ?=
 =?utf-8?B?NEYrZHNMR25udW5COXRYc1hROGhGWVc1dy9LQktXcE55OTdwYThUUExEOXZE?=
 =?utf-8?B?ZjZMU1BOMWZaVUxKMGg4UnNlakRkQmQzZjdTWTlDNjE1ekdWaEJBQXA0T1cy?=
 =?utf-8?B?T01hNEZlRVMvU242MXZ3Qmx4UU1OUjZhQ1luaGp6TjFyTVVIZlRBcVdFR0pq?=
 =?utf-8?B?NHIxeEZDejFPM0dJRHBlYnNkSWtCZzdvMmRuVklFS05CZ0RPMkhTamJsZFNF?=
 =?utf-8?B?b2o2R1huclYwK1BmZ0R3K3dYWGVpYStjblZUOCs3VWxhLzAybStLd0oxV0dx?=
 =?utf-8?B?ZnFnU3JUS040MDdoVFhsa2tkeE82Y2xpZUlVZDhBVng1eEdnbHhUNm51TGRC?=
 =?utf-8?B?b2ZOVS9tT2VuRXZmcDltYlZEYnA1bFBtRVJTM0FmTkhTL0J4eEN1bDhKSVRW?=
 =?utf-8?B?M1lhYUpMWFNlYUgrcDdmcE00UG14MW9WM0NpejViRkMvdTdaK08xTytNK2ZE?=
 =?utf-8?B?eFhKMnl4RllMRThoVzhmeVlGanFPczJHd2JZSXYxaFhYTGFBR1FGa2RzUnFO?=
 =?utf-8?B?a0NadGV0eWlZaG0zQTVLUjdyVmRvUXo4QzVwWjY3c3NITVVZRWJKKzlNZXdi?=
 =?utf-8?B?UWlIZml6c3orQldQWnZFdEdYeG9jNndXOXpmYVhFNEoyRUN0VXkwSDV6SmJo?=
 =?utf-8?B?b0NCamdoSDJ1MVdVTFhQa1F0a3doaThqQXRzc3FLNThXMHFUb2YySlFKa2dB?=
 =?utf-8?B?aElyaUR0YVQyWm5lQzZzZVo0TzQ5T2dzYThTNFFiMUpFQU9RSE5leFFxZTVN?=
 =?utf-8?B?ZXozUnJRc29qMmxzcS9pdExiMExTUndod2w0Z0ptSVFmR2VwYUxmeVp0eVFt?=
 =?utf-8?B?Qmx5NGsyOEQwK0lWbkhzSHNBZkxDRWNBUXZZSzEwUERuMnBpWVU4ZHVCazRC?=
 =?utf-8?B?bm85M0xRVy93bmNEMzJ2bGFOZi9lb0RaUVE0T2lXNEUwcFZPTFliTnQ1a0R6?=
 =?utf-8?B?RTcrWWZkR1JlRHpJdFZyT2gvMVZJN1U0SWx0TGQ0QTRuc1NBb3NhanNuTTFU?=
 =?utf-8?B?cnh0RTlnd0RCeDRsRnZWT25QanZ0YkI5dGs4NVl5eFlYWktYNU1iTENlbjRK?=
 =?utf-8?B?ZVY5QW1qR0Uwa3JjL3pGYzY2YytZYkIwWVJ4aVp1MTZsVHRtZ1JMSU1VSWR1?=
 =?utf-8?B?ejlzSVJVVUxGamplYmpaT0psekRTVHplWStBbzcyRkRMWmxiN0NkT3Rlc0lE?=
 =?utf-8?B?WS84bXBvd1I0WGk2OTdlTDZWRU9LWmRTY054S2ZsWkViTzJGQmhLcE1nTmR4?=
 =?utf-8?B?TksvV3JKRzlhQURtVkRWOWEvdmUxeFhKTE1oSTlBRUpZeExDamxhenlzbzA2?=
 =?utf-8?B?N05XMDVNRFRFYXovVlJQMk1VZURmS1JZcGYxbHB4OTJNZEJWVXF4K2MvRDdZ?=
 =?utf-8?B?VzdHWndMSVcxU0VFZUQxY3ZxRUZRSDFmcS9aTUFHWnZ6K296M2J1RGpRQms5?=
 =?utf-8?B?RGw0L3lqdGhrNi9sR0FoQ21yT3EyOE4waXpYMU5ySm5hdW13c2hoMUpXNWlu?=
 =?utf-8?B?VldJRW1CZDFDNFdJMDhXa3phamhSZVBvc2U2VjQ5RHVnV1RpR25EYXNIN2pk?=
 =?utf-8?B?TlZDMFJKQjF2K3k4cHp3MnBZSVVoZW02MERVUFhSUmVRMlp1UjlXYm0zWFY0?=
 =?utf-8?B?TkdWU2RZK0Z6a1VNOUNQWEhmR0hyaEVyK3RsMlZRZXRiRjRURk5JUkR0UUhU?=
 =?utf-8?Q?2rXEOaI9eKQUO+tI0QbfY04bF?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b5d30c09-1922-4e6c-ccd9-08dc3e44215d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 01:15:51.8075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8MGWyeuT72Wf93scpKD4Q5HZaPdDTFGezVAM6JxImwvmZNhmD/IQC4aXCu+kkEv45NzUyBilRobmTY0x7p75pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7477
X-OriginatorOrg: intel.com

DQpBdHRlbmRlZXM6IEphbiBLaXN6a2EsIEZsb3JpYW4gQmV6ZGVrYSwgUmljaGFyZCBXZWluYmVy
Z2VyDQoJCUNsYXJhIEtvd2Fsc2t5LCBWaWthcyBHdXB0YSwgSmlhbmJvIENhbw0KCQkgSGFvIExp
LCBIb25nemhhbiBDaGVuDQoNCkNvbW11bml0eSB1cGRhdGU6DQoJCUFybTY0IHByZWZhdWx0IGlz
c3VlIGRpc2N1c3Npb24gDQoJCVByY3RsIHBhdGNoIHVwZGF0ZQ0KCQlEb3ZldGFpbCBrZXJuZWwg
bWFpbnRlbmFuY2UNCk9wZW4gZGlzY3Vzc2lvbjoNCgkJUHJlZmF1bHQgaXNzdWUNCgkJR3JvdXAg
c2NoZWR1bGluZyBpc3N1ZQ0KCQlQcmN0bCBiYXNlZCBzeXNjYWxsDQoNClJlZ2FyZHMNCg0KSG9u
Z3poYW4gQ2hlbg0KDQoJCQ0KCQkNCgkJDQo=
