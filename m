Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B642564
	for <xenomai@lists.linux.dev>; Wed, 19 Apr 2023 08:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681891201; x=1713427201;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+rQiRF4sqHAoLKOt8d3Jvd5CIpoZiFxTdu7OgV3fZoQ=;
  b=Ts5LTVxy48RiNJKMSwaFSl7fViYwH9nj276pcfdvoAOtLw56nLvkyMYf
   FNop/bvbCjDK9LfLy/OO6+NRmN29u4eLrciH613AUbmAE4nCyaq0eczJD
   xlm9NqB11SIn7LellTiIDMW/GEqbqqLJbieU0qw7OAoZdNUeCxDlVG4CO
   igXIVcjDlNYUkTSZ4I0I8o5rD2wqlw1nF6+v48Ip0KGtkKiSs4zWvs13x
   GH4+lEzrM35Qj4157KVNAqUh7jl1qei44LlnWlInYEf/RO3BA7dYX/hiT
   P6g1D9l6393vrzaWM4FIx0bSZJqshr1xoFcil/75VpUHA8EQTPeNzGE6L
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="334190286"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="334190286"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 01:00:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="721833004"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="721833004"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 19 Apr 2023 01:00:00 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 19 Apr 2023 01:00:00 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 19 Apr 2023 01:00:00 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 19 Apr 2023 00:59:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6C+gzqSJzLR4RMRcCmPHEBXTjmcUbqVtMgyGuQV4f9U6mPZXBxiSsPCcJiCtfjEIwYOBoLplMkqyZWG7cKwjLRVhaiOyYBMZqgblfU+RvtyjvUImeIxoz1DPOXfffa2fV/F4ImLdr9FqgC/yero7R8sz+Idoaoo11zhvYwogucRNOt1mnJI2DVrpjvhsZqnb74+syHruydQa9KYvZnD21Oop8GJL6owspQ0YVxoCLW3o+6Cmk3KNZtmeK4WEtOZ9lqFzmLp2uoYmnc0yPnN5pWwMYvd3E7+M8IBjU/5BuocGb80l8rpQcZaYoW1mduU5VFLMoKgDmDwA0+PQVR4sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rQiRF4sqHAoLKOt8d3Jvd5CIpoZiFxTdu7OgV3fZoQ=;
 b=igglWgfPTVX8xcXdNWh8DxFHPXLR7mZ/yofPjgc+2Has5gMGFWVz7jMJ33By8IMcx2GPBm9GQahOAFj3xhBWpri69j4iXma2gaEkdA3hOYKSLFNjFO3TTsJ5e8Y5ha/jYReJB7nI4PsSLskJ9wNwIxsx8Jg8Wo67gPehabgj4FkTveyoE+o4UknvpWTqe4GlCvsTU6r50A2nkQEyDh6DTcxpmyVgravyUWy+tP+Ofn5BzjqBsXycOGmJGwO5rzEnz90qF2JSWtbUD+7vf18ctTC2+rfglsc8KH8K6nYWoxl5a4B7me+vFDtH1I8CklW/2KExT5fliUsjbITFoGXr0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by DS0PR11MB7904.namprd11.prod.outlook.com (2603:10b6:8:f8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.45; Wed, 19 Apr 2023 07:59:57 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::9822:1058:3a7e:e502]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::9822:1058:3a7e:e502%5]) with mapi id 15.20.6319.020; Wed, 19 Apr 2023
 07:59:57 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>, Richard Weinberger
	<richard@nod.at>, "Bezdeka, Florian" <florian.bezdeka@siemens.com>
Subject: RE: Xenomai Community Call Minutes - Apr 19, 2023
Thread-Topic: Xenomai Community Call Minutes - Apr 19, 2023
Thread-Index: Adlykx17jWGaRpxgRsGIPRdd7lTvpAAAU91Q
Date: Wed, 19 Apr 2023 07:59:57 +0000
Message-ID: <MN2PR11MB42856A94F6F6CC7E39D66478F2629@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <MN2PR11MB42855D4E852BDC75CCC51471F2629@MN2PR11MB4285.namprd11.prod.outlook.com>
In-Reply-To: <MN2PR11MB42855D4E852BDC75CCC51471F2629@MN2PR11MB4285.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|DS0PR11MB7904:EE_
x-ms-office365-filtering-correlation-id: 611d0ef0-891c-417e-a40b-08db40ac116f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MHaLIGHSwbA88tAgELT15ofHtDzwe5up67hruARugKDUIOGP5CylF8GMRlbpsm0A/+95vXuDkLEVMNVx8AJrxySda5YT1TIcnMOdJQFRuMEduWC6x7195Xo7FCDBc+EtlDF0FN/7hebczqNXPU+qBkJylCQwZ8eajsLTf2Wh44nqFii0rzitiXTOwi/C7PoomHz2D+1vtfmf/otl/gECslcJ8AWAK9Bkd+YUSr/hAS7agzjW7LacT0FaNMnsynBFapLeBozMDoOC48VfteRl1bYmAdWz4pQ1k1Zq6/mkUj+aBs1ZfIFRcJrDpRU7H/oQ++7Zi5onZu+UG/HIV15hpuqvpB3mkCocoE5eNnzUJJWz0ZO35ymVv+spxpjdlc3V5kfMJvOlcDQS2vei2JRGpRebF5QyW7T+dQ/+43j6UTrNqChjQLq+ZBL3C58uASqfwcItNixFa1hCCTRyoUsI/4+6zFmdUfgbnVhWjbH5IxVOv42vzfWQDD1VTZXN52KxCnaaLob3ujmDIMepzKKEA+ifRLg/43dpyN6matl1D2Cr8AN0AbwaB8sZ8IKquGImI2K4OusVJzst1n4Ao5DB7weCZcv4xr7FefNCoFLbShDYNZmfI0eLMi8zjvaTKpbt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(39860400002)(396003)(136003)(451199021)(6916009)(478600001)(71200400001)(38100700002)(8936002)(8676002)(316002)(82960400001)(4326008)(76116006)(41300700001)(66476007)(55016003)(66556008)(66946007)(66446008)(122000001)(54906003)(2940100002)(186003)(4744005)(2906002)(9686003)(38070700005)(6506007)(83380400001)(26005)(86362001)(64756008)(33656002)(5660300002)(52536014)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SE1mdDNMcHQwbk1pVW1qMjNReG14MTJtYVFLQWlod2hkeVZhd1ZTTkh1emF6?=
 =?utf-8?B?SG5GN29LNllQTnRGUGNCTDg5VkFMRkx6M3BZZkQvTzBkcWJ3azVGKzZodWZM?=
 =?utf-8?B?cFFDWjd6cmVnNzJDM3VpQkw2dm91TmhoSXhqMUE4UFEvSXk1T0h0T2svSkJt?=
 =?utf-8?B?bTRrUktLVDVnWmw3L3ZwWlBoajY4azRMV3NrUm03OXMvMDlUM1B1eXRsd2E5?=
 =?utf-8?B?YW5rZ25JM0tuVVR5QjZIUWgzTDFNMFMrQk5raTExK2xad3lnTFptZHYwMWw3?=
 =?utf-8?B?WUExQmFTbXNkRHoxT2R1MERhc0JQNm1sWFdlWDJ3Y0VWeENRenJsUCtEaG9Y?=
 =?utf-8?B?WjUvckpnSUx5RGppYnY3SS9nSmo0cjhYcnFpbHJoOUVPcDMwVUZZYnhNb0p0?=
 =?utf-8?B?eDh4VW14dSs3cWJoZWFoTnpMTGRxNmd4eTBjU0xoNnByQ0JvS2lwRWVkNHJS?=
 =?utf-8?B?dXRIeEhqWnpsc3R0czk4OFYvd0hWbzBGc0VPalYvdkRrQ1lmSkdJN251WHNz?=
 =?utf-8?B?YVFxejNXZXlIMUVaMUlsdUNSSnNNWnUrbzRueENwVTh6SkJoZXErNkRUbG4v?=
 =?utf-8?B?ZlV3N3p2NzNtdjd6czlXdmc2MGpDSFUxbTNHbmsxdllnVGV1Mi9qVW90Zkcr?=
 =?utf-8?B?cXVkcGtydVhCUGZPWktFQ2wzem8yc25uUjZia3kzWDhEZWYrVFhHUSthdzVF?=
 =?utf-8?B?OGRLYmhQWjAvN1ZVL0NqM1hQdS9TWjNBVEtkNWpXTVhjajZoQUVleHJxZTRZ?=
 =?utf-8?B?SlVraGtEUDNoVXNRaXY1bmhKL0QvdndMdThvQUFzYVlPeUs2Z2R6SVo0WUdR?=
 =?utf-8?B?RWRVaW5hRlh4ZXdUai91ckxkTXoxVmdwSzZFRjhDMHFKdzVGWks5djdrdk1O?=
 =?utf-8?B?UFJaV3FEemJoS3lqT2NnN051azE4QnFMMHdHdXdyRDErQ0k5eE1mcTJRa0E2?=
 =?utf-8?B?dnE1bC9mOWFUVmRCTzd5Y1ZWazFaZEdzL2hoVlRyc0QvMWRobDE5ZCs4eXdY?=
 =?utf-8?B?Zk9PWmozQm9ZWDJtSWxOTGdVNXhJYUJOZ0hqaytMbDcrY3BOR0JPNno5alhI?=
 =?utf-8?B?eWtYelZFN1lDTnVBeW9SZVJOZWsxVTJaemdJdkNQeFJnSVpmYkJ1WVRIM0xZ?=
 =?utf-8?B?RGdpSUZDQ1JIbnhXQmpEOEhXalZwV2FkczUrekt0SzNyaHh3WnM4NDMvcjNY?=
 =?utf-8?B?cU4vMUkwSUVsZjhXR0JCcEI2QXdycFlLdDFlM016TFlNeHVLMHBtVmVpUHVn?=
 =?utf-8?B?YWYyOXpjcDlveUplRkRUcTh5RGFXM3hUQUIxNjZxd2duQzhjY2tVbGNjOE5u?=
 =?utf-8?B?c0M3QzFHSGxiUjc5VElKQkZMRjB1QnF3cE52MTFlQ1FVTTdlTjI1bDNKZUYr?=
 =?utf-8?B?MHVMdVREMUo3ek5IU2RPaXNZWFBrODdqdndvcWwvS0kycWhEdTZWVENBdjBz?=
 =?utf-8?B?b2ZmeXg1VG5KdmJyaXFRdDNaRFhBZ1YvYUxSQ0V3YlZjYzRGN3hLQXMxN2li?=
 =?utf-8?B?andpTCtYSVpGZHFkM25paFJINjAxUzBhbkJWRk5SQWF4OWErVnl2V1N2azcw?=
 =?utf-8?B?WnBaNmlsQXFhZjlNZFMxb1NtaDlBbUtUeUJHckNuUjVRSGdUQ3c2WTY2TnZU?=
 =?utf-8?B?M3dlK2RhTFRXZTZSenNCczdwNk1hOUlUR290NWgrc1ZmaU5zdUxTZU5XSXFr?=
 =?utf-8?B?SUx3QjloRGFhWVk0bG5TSk9BSzA1NDQwQ3hTbkNzQXNpa3UzMStSQjd2OE4y?=
 =?utf-8?B?Z21UTitsakRwNllFQmhCT2U2UStEekdDdkw4bHhndnhpeTR5M3ZIR3ZUV3Aw?=
 =?utf-8?B?eHJBU2ZHcjlKeDd3S0J4bEVGZnFiM3B3NUFJT0VyamFsT29XNG9SQ0VISm12?=
 =?utf-8?B?aXJjcVpRZGNGVHVlNkp2Z3BBbHBrS3lHdGpDQmxIQ3M5ZWFFYnJITjBIaTZO?=
 =?utf-8?B?bi9xUnhxTnpML3Y3dzU5WTl5bXNkT3hLeGFBRTlhQXEyMEltczNjSWtBbGp0?=
 =?utf-8?B?OS9oTmJhWW1SWmh6UXhXam5pS3licVNrelNUV29UVm1MNmdMbkl1cXEraWZM?=
 =?utf-8?B?aThJNHRMNTdpaWFOV2FqUDNzOXdjQ2VobFNNRlZBTzJDMjh6NlBHd01VSW1x?=
 =?utf-8?Q?jcWueVhMUII8Na+7QITNSFQxI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4285.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 611d0ef0-891c-417e-a40b-08db40ac116f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2023 07:59:57.3615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ubaUGHcUz7+V/7buwyDBKelhwe/c2AlLAUI8DFfIHlDkWEXosBOlIJoIgR5MTuYA8yLED2czD0SzA7r0BBIsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7904
X-OriginatorOrg: intel.com

V2UgaGF2ZSB0byBjYW5jZWwgbmV4dCBtZWV0aW5nIChNYXkgMykgYmVjYXVzZSBvZiBDaGluZXNl
IExhYm9yIGhvbGlkYXkuIFNvcnJ5LCBJIGZvcmdvdCB0byBtZW50aW9uIGl0IGluIHRoZSBtZWV0
aW5nLg0KDQpSZWdhcmRzDQoNCkhvbmd6aGFuIENoZW4NCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+RnJvbTogQ2hlbiwgSG9uZ3poYW4gPGhvbmd6aGFuLmNoZW5AaW50ZWwuY29tPg0K
PlNlbnQ6IFdlZG5lc2RheSwgQXByaWwgMTksIDIwMjMgMzo1NSBQTQ0KPlRvOiB4ZW5vbWFpQGxp
c3RzLmxpbnV4LmRldg0KPlN1YmplY3Q6IFhlbm9tYWkgQ29tbXVuaXR5IENhbGwgTWludXRlcyAt
IEFwciAxOSwgMjAyMw0KPg0KPkF0dGVuZGVlczogSmFuIEtpc3prYSwgUmljayBXYW5nLCBSaWNo
YXJkIFdlaW5iZXJnZXIsIEJlemRla2EgRmxvcmlhbiwNCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIERhdmlkIE9iZXJob2xsZW56ZXIsIFRvYmlhcyBTY2hhZmZuZXIsIEhhbyBMaSwgSG9u
Z3poYW4NCj5DaGVuDQo+DQo+Q29tbXVuaXR5IHVwZGF0ZToNCj4JS2VybmVsIDYuMyBidWlsZCBp
c3N1ZSAtLSBmaXhlZA0KPglBbGNoZW15LCBwU09TIGFuZCBWeFdvcmtzIHRlc3QgLS0gaW50ZWdy
YXRlZA0KPglTeXN0ZW0gaGFuZyBpc3N1ZSB3aXRoIHZpcnR1YWwgaHlwZXJ2aXNvciBvbiA2LjEg
LS0gZml4ZWQNCj4JQ29kZSBtZXJnZSB3cm9uZyBpc3N1ZSBvbiBpcGlwZSBicmFuY2ggLS0gb25n
b2luZw0KPg0KPk9wZW4gZGlzY3Vzc2lvbjoNCj4JQmlnICYgc21hbGwgY29yZSB1c2FnZSB3YXkg
Zm9yIFhlbm9tYWkgdGFzaw0KPglTaWduYWwgZXhjZXB0aW9uIGhhbmRsZSBhbmQgU2lnbmFsIGJh
c2UgQVBJIGFuZCBpdHMgdGVzdGNhc2UNCj4NCj5SZWdhcmRzDQo+DQo+SG9uZ3poYW4gQ2hlbg0K
