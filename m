Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854681381
	for <xenomai@lists.linux.dev>; Mon, 12 Jun 2023 01:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686533302; x=1718069302;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=/TDBUeEstoy2Z4pREQIvHDjvhj2ErCTl0LWUytrnvos=;
  b=MwSzdRbuuVtazYbCTElO/GrKvP7h5so3LbiV04lS+oKGngwHTSbDEPmt
   rHOR81yNeNI65o2kQOT0/PaRe20soNDF9BHKMLTngp7RraRVd0CgnywzB
   Xq4DX9fSSZOP47w4SBSeZRsCidj28+xqpwFqCBRqL/VxRKJJ7aJRCQ/Rf
   hc250+wWEXa4p5RprxTUdW5sgUr5aDPlt3Zoi3WUX3pd2RtspPoa5RWlp
   CE5D77ust5thIHLJSAGo1vKyWT9dRmkALAyWtTvnrVGHBipdo1ge6TKze
   RDyEfd4Uk4RW/CMrHjHGeXzrPbDeZtEVOx4ZhQT8+s5wf4B+zTEqA6KKX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="355415481"
X-IronPort-AV: E=Sophos;i="6.00,235,1681196400"; 
   d="scan'208";a="355415481"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2023 18:28:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="661404333"
X-IronPort-AV: E=Sophos;i="6.00,235,1681196400"; 
   d="scan'208";a="661404333"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 11 Jun 2023 18:28:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 11 Jun 2023 18:28:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sun, 11 Jun 2023 18:28:19 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 11 Jun 2023 18:28:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFhYLfl5m/ZWuBqmF3G7UVox/KIHXAbVACTjXlxIy0Hc2iHUuDSX+7aiIFYA4ufl/g4WNJUUe2OJoC7Js6gLKwHy+1ru+duqGxulhwFxFZGd1kvAsv841R6b/3D26i1H7z9UmgcnLIUd7AqQc29E6UhhlnQi0bWhAD7bZEOwGjM6O3O5JzwIR8wj/vS/gEjrn4FKuOfDWl1rwzpqYCrIQ1P5Y3jhwEK8EJcuyLrrj4P0OA5JF4cwajsZ3I0zEWLmkA1S0v6kjTgKA8fBA6lm5xvhHDxhQ8MAbsRm2aGRQEDKGI4fcQrwewEpiVHwmGfYDElnh6N8La951IdwqCzuWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TDBUeEstoy2Z4pREQIvHDjvhj2ErCTl0LWUytrnvos=;
 b=QFHJXDLKsgu/byODutLTuj6AUzZhS2H1neTZ+FhaeItm5oNBc02Qaeczk8qXhqq0n3KM9MyE62BYqCCfzHhdSXovpRtxSBeHwQwCZmUupeLHafSmPrpuaxp90M9w0btw5DH1zGL2ziDPUrp9Y44AYqTDFQ3p69lTDj7JYwij22YIVcPL3ZpfTKgjULOQZjcSu1AWM5B6VKLe8p5qQYsDBbOOQ2/s3XrRkxDX9REXKQaXJZ3pySVJMx5jWEkyQ3gKQwzLDpTlt/UtCIrA5YXJHQ2s8z2hLciwyd99AHTdmixr/O/Bz7T11bkZkDLuKz5TEwttEKDlswZf4eRZ4x7Clw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by CH0PR11MB5523.namprd11.prod.outlook.com (2603:10b6:610:d6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 01:28:17 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::56a8:e9c:284:f6a8]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::56a8:e9c:284:f6a8%7]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 01:28:17 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: =?utf-8?B?VGFtw6FzIFBhw6Fs?= <paal.tam@gmail.com>,
	"xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: Set irq affinity from a user mode task.
Thread-Topic: Set irq affinity from a user mode task.
Thread-Index: AQHZmqacZH8yjUa55UKgB6Rk2LuItK+GYZNQ
Date: Mon, 12 Jun 2023 01:28:17 +0000
Message-ID: <MN2PR11MB4285E1DADCE543CF4966F4D2F254A@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <CAH0t8y0j9zdJNo6X9SfsYGAJx2WJiGtvw866EgqMnRQwB0pOvg@mail.gmail.com>
In-Reply-To: <CAH0t8y0j9zdJNo6X9SfsYGAJx2WJiGtvw866EgqMnRQwB0pOvg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|CH0PR11MB5523:EE_
x-ms-office365-filtering-correlation-id: 9b95294f-bbd0-43fc-0c61-08db6ae44c8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IGJ7QOk8X/KpkkgHesJUgxq21dEn0q7zjxUXP3jryhSM/q7a0h8sQTLsS3T5e7zexj7suCN0iq6BfbWpH7Qr5BCMHqknZQ0L5tNB1CZgabRZqylsx+a2jNFvKBfA63G4txymMUQzFPFFqo6oLOnTd6qILoojj3q/Q6gfc0MAEPEryWuEovcrotovkYjQQGJ7R/3ObBFYIZjqHl+ebXbjbnsd5vpGXAjN74zc66FGv1a3NDV2AEBVyvYHXzq81ghQUa6BvtlnTWKRT6jgmTqgR4eR6pK78AkdlFTy2kywSxHfDQdENtiZemYQAU13iVv6+Hi4Bf7+WC1eLnBt0rT/LMu73sKPYkg4z8w+mhBmPmJP63/uqDlSOx88vDKGZhNvWlhqHBvLVS9oU+B0LY4DWqE2YSP58DvP3O7b3Q45xQklJj8D/tchtMNH5ur2QavQ2ttFOIvc8bln4gaGLCVgVCXhUKPSIaVEXG3LL15fdOi6kTWSS8h+jqJZfTf0eZspgs+5YxTZ1y+bRu7C48MpehOGnwketUtRKQOqt5NRnaJdoy6bP8d30c0YE9E0SPfVP0ExC3gKnEYDC13APFuCmLD5t4mqCy+nHRsraa+Kd3s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(136003)(396003)(366004)(451199021)(7696005)(966005)(9686003)(83380400001)(38100700002)(86362001)(38070700005)(82960400001)(122000001)(33656002)(6506007)(26005)(55016003)(186003)(4744005)(2906002)(110136005)(66476007)(64756008)(316002)(66446008)(66556008)(76116006)(41300700001)(5660300002)(52536014)(71200400001)(66946007)(478600001)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bk5wVmNCaUxmVjhlSndJanNXOWxZamlLVzZxOGRWWWpHaWp4aGxhNXlXcCtQ?=
 =?utf-8?B?MkUzZFVIdTUyYjJuN0pBU3QybEtLdmpuQUx4dlpic2c0SjhqbnVlNkx2TGNw?=
 =?utf-8?B?c3ZiMldlcVQwT2tpWnJTRlAwd0lsNERPSThXOUZrNis3KzhqdDZLMzZiZWpa?=
 =?utf-8?B?MlgxQ3haNGxBZm1TSXg5RC9yaTJHWlZ3amxSMGJtcW9XVW9EOURrcHYwcnBF?=
 =?utf-8?B?YUt2Y3RSM0pxMDg1MGxDVFlCSHUyMjZ6QjFwVmJsRVhyMmt0a3JsaTZ5UjNV?=
 =?utf-8?B?bWVZNFhZL29VRlFtaUxLOXJ0NUZ3Q1h6Tk5UTHp4aGNpVDd6ZUZXN1pJdWRN?=
 =?utf-8?B?VXFVdEE1bDV6RUljVzVxT2VXYmRvdUJsT1M0U3luNVdZajB5UDRkR1VPMHZw?=
 =?utf-8?B?eTZnN3djZ3FZOFdoeitKMGs0c0F5V2FRSVVBNWxsTTdxc25mcGY0d2FNUnQ0?=
 =?utf-8?B?OFVxN2NmdUZvRlQyM21LRC8xWkpJODM1MXB5N0tQV3RXSlpzNEliWHRpZzVm?=
 =?utf-8?B?Q1d4YWRMbjdIN2dFT3BLK2svL1ZlZkRVemFGVzFESlRRUEJaUlJWOW5KdGw2?=
 =?utf-8?B?ajBlZmNNaXY2V1hxRFNEakdNZzNRa1RmT0huM3Z1TVFtQ3pvYm1Db2tMSlpH?=
 =?utf-8?B?MUNoYmFycEYvc2pRVVR5d3ptdW9XVHRJOFdnQjVBd0tlbC9XWGlPWFlmTi9D?=
 =?utf-8?B?bm9qS3EwcnE4RlFFaVJRMkdNcWdvSHJUUGdJZmdTZG9zcldkanpJRWFuM0JB?=
 =?utf-8?B?WVR1MXUzdHFYdFI5bWNYcG4yK0pacVAzclZ2RnBrZWR3QnhUNnkwd3VodnJB?=
 =?utf-8?B?MGQ0WVVyYnM3bmF2MFZLWmlMb1NPbHlFRkRjeEp6RTJGMnp3YkVzZkd0ZEVo?=
 =?utf-8?B?K1Q3OU5rUGw2eC8yOEkrbmxtYkdPZkpaVVRoMUhZTVFaclRUS2hXalJGZE9o?=
 =?utf-8?B?WHFhRVBEOEFLajd6eTdHekQ4ci9iY3dUNkphTkdpZW1BbHdGT283UEZzeTBE?=
 =?utf-8?B?NmhLYmo1d2Vnd1FFaUhnWjFiWE5RZUZaMEJoRFhKVkJpSjFYQndjWmdWbFpi?=
 =?utf-8?B?SjY4cTJyM09BVGxwTXFFRVJYYm5UQldWdkxzd0E3bVhid0Z3S2xqY3FZNWE3?=
 =?utf-8?B?d1ZHQ0FDV084a1I3Q241aVo1a3h3dkhHZFJFbnRFbG82MzcvSGEvMDVXMjJO?=
 =?utf-8?B?UFZOYUdkTWtGSmxuY2VMVVphZkc4Qkpwd2xNU0RsRWtNb0RTWWN5RVFYYk5r?=
 =?utf-8?B?N0svczUwZHFUTThXRW5aTUdkemFyeVdmTExyZ0FNclpwSElsWGNiNzF2K04w?=
 =?utf-8?B?aVZFbTF6TjRjV2J1YkxtamExeENNUmRuZStzNmpBWFB4M1NlTXdWUDFMeXVm?=
 =?utf-8?B?SmhxUmdQMElicmVpQXpmVDVnYmtycG1ZdUlxaktiL0F6bmVkbnFCeEo4aVRm?=
 =?utf-8?B?ZEJXTkJ3R2pkbENBVGx2L2FRSmtUUW5oMkJUa0JJR3I0K1B6cEZVS2dCajdP?=
 =?utf-8?B?UXN4cVVUMm5ESzhRaHZYYlBnS21LOE1JTzl2MWNEQmdYNGMza0pZU0hBRys1?=
 =?utf-8?B?RjNhbGN6d3N4M2pPVUEvdDdvMkF5WWZObzM3ZThTQWFhYjJqN09OSCtreUVQ?=
 =?utf-8?B?Y2tMVk5SaW9mdVFIOE1sbTFnT3BvYTYvZkk2VmMwNWxzNWd2TkFWU2VpSGJv?=
 =?utf-8?B?eHdCOTdlak9LeDF0bXN0Si9aOXpJVkFTc3F3ZlZCVEZpOFBBZ1RVbStRanh3?=
 =?utf-8?B?WjNRVU9OcEhuOGNlRjgrOUxORzQzTXV2Zklrek5NY1dNbVZJcmJKekEzVzgx?=
 =?utf-8?B?L21uREcvUUUyMFRSMElvQXh4WXl5c0JDMG9PbDlpeWhqTUVSd3UwaWFNWDRU?=
 =?utf-8?B?Tnh6S1pjYXdQTDVCS3lqNnlHV21CNmJ0dm9oQk9hTjBGMUxNaDYybXpDaU9O?=
 =?utf-8?B?QzRwRFlWekc0Y21wc09PKzJCbTBmKzZnMXhXOWhCbTdxNWMwSTBPNFFoR3Ry?=
 =?utf-8?B?L0lQcTYwbmF4NU16ZTZRTDJNb1MyUGlCcERKUm9EVmpNZkJhNU41M1lIaXVV?=
 =?utf-8?B?b3ZqaGs4Nm4wMXVnRk03clVTeklraWNLWjhJcU9DaVlsNzZTQnNsbEpIRm10?=
 =?utf-8?Q?FIU7WtyIQfUWxpjhfiu53wqM6?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b95294f-bbd0-43fc-0c61-08db6ae44c8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 01:28:17.2261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z0BVlUIR4mqDtVqfLMQJOEHQEOIn3gXvTdvGJi/2w/anGlZ1I1Zn+Rg1Io6bFBMmdo524/mJAce3Bva5D823xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5523
X-OriginatorOrg: intel.com

DQpJdCBzZWVtcyB0aGF0IHRoZSBjb21tdW5pdHkgIGRpc2N1c3NlZCBzdWNoIHRoaW5nIGxvbmcg
dGltZSBhZ28gYXMgaW4gaHR0cHM6Ly94ZW5vbWFpLm9yZy9waXBlcm1haWwveGVub21haS8yMDE3
LU5vdmVtYmVyLzAzNzkxNC5odG1sIC4gQWNjb3JkaW5nIHRvIGRpc2N1c3Npb24sICBpdCBzaG91
bGQgcHJvdmlkZSBnZW5lcmljIEFQSSB0byBzZXQgaXJxIGFmZmluaXR5IGZvciBDQU4sIHJ0bmV0
LCB1YXJ0cywgU1BJIGV0Yy4gQnV0IEkgY2FuIG5vdCBmaW5kIGFueSBjb2RlDQp1c2luZyBydGRt
X2NwdW1hc2tfdCB1bmRlciBpbmNsdWRlL3J0ZG0vKi4gIEkgZG8gbm90IGtub3cgd2hhdCBibG9j
ayBpdHMgaW1wbGVtZW50YXRpb24uDQoNClJlZ2FyZHMNCg0KSG9uZ3poYW4gQ2hlbg0KDQo+LS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBUYW3DoXMgUGHDoWwgPHBhYWwudGFtQGdt
YWlsLmNvbT4NCj5TZW50OiBGcmlkYXksIEp1bmUgOSwgMjAyMyAzOjQxIFBNDQo+VG86IHhlbm9t
YWlAbGlzdHMubGludXguZGV2DQo+U3ViamVjdDogU2V0IGlycSBhZmZpbml0eSBmcm9tIGEgdXNl
ciBtb2RlIHRhc2suDQo+DQo+RGVhciBhbGwhDQo+DQo+SSBhbSB1c2luZyBYZW5vbWFpXzMuMi4x
IG9uIHg4Ni4NCj5JcyB0aGVyZSBhIHdheSB0byBzZXQgdGhlIElSUSBDUFUgYWZmaW5pdHkgb2Yg
dGhlIHJ0X2UxMDAwZSBFdGhlcm5ldA0KPmRyaXZlciBmcm9tIG15IHVzZXIgbW9kZSB4ZW5vbWFp
IGFwcGxpY2F0aW9uPyAoSSBtZWFuIHdpdGhvdXQNCj5tb2RpZnlpbmcgYW5kIHJlYnVpbGRpbmcg
dGhlIGRyaXZlci4pDQo+DQo+VGhhbmsgeW91LA0KPlRhbWFzDQoNCg==
