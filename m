Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5336015AA
	for <xenomai@lists.linux.dev>; Tue,  6 Sep 2022 03:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662433329; x=1693969329;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=gmILi46nWmQ9QDX0S50qHg/bVvUuzvMwSB/Rk4YnUf0=;
  b=LS6GrFqtH25WldTpZN6WSORSKbqNfqoqdPoihGlL/mhk9XIxEmu0uNLO
   UMLA5AWMytAiLEDcCtzkmHXFwjyHbEd6OiXudQwWhbQvZpQVK7v5AzqSB
   BZ69wAcu63oB03bteKtpV82IB3ED2DTgrmSSPJu6M7sgwycEZWG9u2v8S
   bLGjJnSeeXnQmVh/jOJP78ONtXE+rocGArXzvwdhdmrTUgKVVxTLuZX5B
   rj1Esljn/CSQrgRjixHqy3IFhZBWD3MpwfB5O1DrXub0zzjVChcZxSxv7
   MhIV9ulXNcaUg1gXo6HJnScIfZq/xXqHDONKBGPaU+CvOqfB/mCLs3ZyG
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="294073984"
X-IronPort-AV: E=Sophos;i="5.93,292,1654585200"; 
   d="scan'208";a="294073984"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 20:02:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,292,1654585200"; 
   d="scan'208";a="643991286"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 05 Sep 2022 20:02:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Sep 2022 20:02:07 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 5 Sep 2022 20:02:07 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 5 Sep 2022 20:02:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZuYqXnFKPgbNpX5kjDJepIbooovcdMlbugqkrpVTudJ3DeOHwBh55ol3FQegVV/PXJyogUCdVvKWP28ja0djMXOsvN/xi3+AMjgrJBP+YKGQ6BTkM0tE3ltsfKsckmE9RXSw4S6/aqNSESZTR/nleNQQbvs1d9cbv4T75d0Jp0kcWxG0waslVDrg5BhIGvwoA+fEcW5+DJNuqYVDKNp2a9FGTXIo9p70328WBlNOg0jkqexxAKruFCvq0sv9Y9S5kayqiENSEqwu84Or9OOsNKEJ2leMleQ5rs9qPo1CC/eW4u5xi6Bbc9ejaC4VAMwozZa5ygdkTnzich66X4VCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmILi46nWmQ9QDX0S50qHg/bVvUuzvMwSB/Rk4YnUf0=;
 b=RW8Fs2RaQDVyXUz+ixrWk1yRPivVi9aK7k8t1cLwsCUS330wXmb9LwNgj+HcO26Jn2bWOEiXlIAdxopVNH/Ml0CPG/mJooRbO+NOa4SUs62NZ6ykMSfymYda8kuiQDbgZk+R6IaN1iuIePHK2ChUYnaI1ypSJ397ixAFlDVef42s71DzSisjuO96zwt46k+IOHC8Cw0hdETxfO+2hnwxLL8TT6SJWA4qoPSRc9MdUCODQNxo+h7/eUJAHrlktkADsGa7hZe2OoUfrFbTEPbVhDAJqFt0GZRALyF8TpUxMroRVWCAtPGZz7DHdvZH7quX5FXnnOyZwxR0lOmwePN8AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by BY5PR11MB4290.namprd11.prod.outlook.com (2603:10b6:a03:1ca::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 03:02:06 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::159d:a6de:f2b9:fc83]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::159d:a6de:f2b9:fc83%3]) with mapi id 15.20.5588.015; Tue, 6 Sep 2022
 03:02:05 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: Florian Bezdeka <florian.bezdeka@siemens.com>, Jan Kiszka
	<jan.kiszka@web.de>, "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: [PATCH 0/1] net/drivers: igc: introduce rt_igc driver
Thread-Topic: [PATCH 0/1] net/drivers: igc: introduce rt_igc driver
Thread-Index: AQHYtcgZgq7mtu1cZ0KhlErBpHBIpK3BZbQAgADtO4CAD3YNcA==
Date: Tue, 6 Sep 2022 03:02:05 +0000
Message-ID: <MN2PR11MB428517B5FBF8654E3DC1D242F27E9@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <20220822011821.21283-1-hongzhan.chen@intel.com>
 <ad5ac2e9-e662-ee94-94fa-c7d42b6e4b68@web.de>
 <675196c0-9c8a-9a36-3cc4-c292658337ff@siemens.com>
In-Reply-To: <675196c0-9c8a-9a36-3cc4-c292658337ff@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3fdda1ea-a331-465e-c729-08da8fb42e1a
x-ms-traffictypediagnostic: BY5PR11MB4290:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y28SJ9rmrZDtR7e2Fb7i+2EhDjjKirh8P9V80AdqgxurbcN5smpbiDZyU2AlYiisu/ml/jgZfsf3/JZ5wPie6rgXxUNw3khziDx5f6boPA4KLwHHNqeI9+qD1ffjoi00F2yU+4CpbPMGEfQ0cgnv+uKkTQV7dC4q0XiJqVIQX+LFwmIRTu+T8V8fYQBXuNAzoKEnt/pcCKygrAWpGCcReSXsu0ejsHraT8CLZl8Mvb9vD8YsI/KVv6/UIUECEph/7Nhex6IkdxvWvNChDwtIHlXDK77CFNtYCc35jeP77FYCcy01rdegBvCOiK91HN0DyhzG9Wtlw9RbL8CsohtVw4i4QpnYxD8j94OdhaqhF/zDhvUoTyXYvFsNZw2/1vl4LumLe9pJlQSdtuToy7HDJ4YGkICn7vyL1TZM9rxrCp0gzBOG7/+RvmZ8jws3Iz0ouNanxM4/MfKUr47kn3SbV1B+6YoSC9VYJdZ12x6ox7jYG5IgM+9gDtmoZhEx/SLIQfSXtrJ+aPA+6lYcp+0WmYIAAnZe3xVfrR4+ywY5BVUdpYSfIbgChyGufYsi89VpwWYo1ZOi4Q0HzjL7AhPIi0iJxAnQnDT8P38gtr+8FYlupwLsirl2pq/2HsEPTPVGEL0Hhr7LGMcBsKxs3L/hF+3AgonbhJslhU+kKvD8IFwxMKiBnYmtfRZbszdo4sYRsiORScfkMiayr3DPwWWiHpBRNW5VocWSsb/HWUOans6QVcVKrp9uBff4LAGF2sItmjSBTElURHTDi/p7aXtWGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(396003)(366004)(376002)(346002)(8676002)(82960400001)(122000001)(66476007)(64756008)(66946007)(76116006)(38100700002)(66446008)(186003)(66556008)(52536014)(38070700005)(478600001)(83380400001)(8936002)(5660300002)(41300700001)(55016003)(110136005)(33656002)(86362001)(6506007)(7696005)(2906002)(71200400001)(26005)(53546011)(316002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWM1N0lHMU95R3VnYUNTTVNpT2NQMnVxTWU5SmtKK1dRSWlvQ2pMMkQ4c25B?=
 =?utf-8?B?MTc2dG9HRFdVUWlWN3FRRHlvNGtEY0Y5dlQ4dnBkNHBoR3pjWVN2aEh3eEhM?=
 =?utf-8?B?eVhCR1NXWlZRQlpwZDFkVHRPTkcyLzh4RTQyejl0RkpwYmNjeXVtT0x2alB3?=
 =?utf-8?B?R0ZrTTZZZGhsU1AyK2Fsb3R5QnZVbXRkZ01Id01Gdml6SnUzRkZ6TmVSa3pq?=
 =?utf-8?B?VnBseDlMa1ZLUmxjU2p5Z0pWdTlGcnNGNGNsaitXek5Ca0VvOXRieENJOUxH?=
 =?utf-8?B?N0YwdDlMWU1sVTFyN1NKSHhsbFk5Yk5uUWVOaEZWRXZTby9IYmN1ODV1aFQ2?=
 =?utf-8?B?bGFqVHJ6cTlVdnFlR05jbUVRM0dlL0IvK1Z3Y0RSK044SVlVTnByOXoyZWlV?=
 =?utf-8?B?ekpYVXRHZmJSUHRQczhWZE9XYkJ2aHlYblF1SlFSWHpOTUp2NlZqTmRPbEhR?=
 =?utf-8?B?bnJRQVFLQURCK0xPZlJWSkN5WjBrZ2F0aVl3anpQVHRrcnFzSTh3VzFrTk1t?=
 =?utf-8?B?TlQwd2ovZnNBZm9uZEM2YlZ4cCt6WHdITDFublpCYlFEM3ZxNktaN2MydHo0?=
 =?utf-8?B?K2p5QnVBQi9TTXUydGdxZ3dOT0R0REVGRzh2d2dUeGN4M1M2M2ZkV1YvbTd3?=
 =?utf-8?B?Z0V2eUxjQkN4RU5TSU11WDhyUi9sWVpTa2lqV2tBRTc3WEtZZnBKdmlERmZ4?=
 =?utf-8?B?UmlnM04rTkM3L0FyV2RUL1BmSTBUNnlLK1R1aHZxYlY3UncrcGYxZEhqT3E3?=
 =?utf-8?B?cmgyQjVMYXNQTFlZdFlhUFBSVjJLOCtGb2d3dXI4UlJicSt0czZIL1phRjdi?=
 =?utf-8?B?dTc1QTBnMHdXTEFheFhtUkxpaUtxN1BvV0ZKMEdvSk9LY1FTaTZmWlFncFU0?=
 =?utf-8?B?Nk8xeHpVU09JeXhjd09JR1FoQmdoTmVnRU1CRGZpWXIva3EvOTlKQ2VqSXg0?=
 =?utf-8?B?M0dQZktySGRrTjI0T25OdXh1ajBsVHFidWNaN2U5ZVIydzYvTjZrOVBBZGRJ?=
 =?utf-8?B?ZDNjVGdKUUM1QU8wMmNjamQwR216bW1mMFNDeTEzQlZIeHRwaHV4VkY2VkNm?=
 =?utf-8?B?LzRJakx4ZU04S0NDU3BuTnBIVi9qRmJBbmxUSkJyTWVaRjJxaFlkc293RlVp?=
 =?utf-8?B?bk1yeXh6YWxyWGxCMkkwbDQvMHZUTFRPd1JLSXFWUWVYYnFONldVdFp4Z3VU?=
 =?utf-8?B?b2RCZ2V5STRzK1JyTXVQOUpaeHpCNUhYeWVOZW5SYTZvWmxvSW1qWjYxSDVL?=
 =?utf-8?B?ejBHUnUvYVhLVm5FakxCbnB6MG80SGpCM3AwMDRZUDQzOWhjMXdrZkV3Rmo3?=
 =?utf-8?B?bkQ2bHZodWsyeVlvSUhHbWN5aUErZ010T2xKa2lXTW9McW14QzYyVnUxVGRs?=
 =?utf-8?B?UHBTTmRBcyt1Z05wT3FvRzBnOFBLTXlyU1Nyd0k3QXFTWVFyTk1pTTNYb0xU?=
 =?utf-8?B?U0VwVnpkb1BEbDRtM2R1eHFyZ2pER0gxTVFaYzRweUlIR1A0S2hRVmJtckp6?=
 =?utf-8?B?RTI5M1NCYWFxK3ZHTGVYT255dGZIUmVNbS96L2VETGJIV3RTM2Nha2VsYlU5?=
 =?utf-8?B?RVk4enZ5Q0xLSi9lNVNFckNLVWtvTG1Hbi8xRmJoMVRaR1pzUVNRTHgxVUlr?=
 =?utf-8?B?RWc5SVdWclgwNWE3OC9mZm1hemNCT3BjczRXR0RsLzBHaUVWNGJ1V2RnUVJY?=
 =?utf-8?B?dXVuVmJQTTNDLzRwbVIvMWNjSHIvQ3lTaGVZS1Jqb0Uwcms1ZnhSY2g0VktQ?=
 =?utf-8?B?eFZLZGFIR2FjTDZqalR5eFVHZDJ2anlPK2Y2U3pYOUVYakFCQTNyUDlNZ1ZY?=
 =?utf-8?B?b0k3R1Q4TjlRdGdFY1hSZTQwbndDMS9kNU5ocndvMFJQN0x4ZUFuNSszWjZB?=
 =?utf-8?B?dFFmN3NCV2lpbVpHTkVFMHduUWVtRW1ia3pZRjAwMlNjZ2ZqVTc4ODROS0RI?=
 =?utf-8?B?Lzl2cUUyL0ZFdnVwalNpc1JGaGlZbWpFbXNIWk5EcEFtR3cvQ1A0VmZPVGpD?=
 =?utf-8?B?aS8rK3lPajQrMnBqRnlPc2Nyd09wOURnUW5CMnh6MkFNWk0vU1I1L25jaWtI?=
 =?utf-8?B?YWs1ODAxdGlZYzBqc0gwZnNjK1d2UldtL3ZOanNQUnhnK2JyTHJ1SUpabTcw?=
 =?utf-8?Q?MWVuSjMD0vsuIWQFaPOPoEGi1?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fdda1ea-a331-465e-c729-08da8fb42e1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 03:02:05.6426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bS+/zz2mgF5k2cN+lNzBNrzUknx44Zs+ooEk+yWTIZxSnzgCMFcTjxGzB9Q7PHtrA969ZSZUo4jPkSEnqJ/hrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4290
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEZsb3JpYW4gQmV6ZGVrYSA8
Zmxvcmlhbi5iZXpkZWthQHNpZW1lbnMuY29tPg0KPlNlbnQ6IFNhdHVyZGF5LCBBdWd1c3QgMjcs
IDIwMjIgMjozNiBQTQ0KPlRvOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHdlYi5kZT47IENoZW4s
IEhvbmd6aGFuDQo+PGhvbmd6aGFuLmNoZW5AaW50ZWwuY29tPjsgeGVub21haUBsaXN0cy5saW51
eC5kZXYNCj5TdWJqZWN0OiBSZTogW1BBVENIIDAvMV0gbmV0L2RyaXZlcnM6IGlnYzogaW50cm9k
dWNlIHJ0X2lnYyBkcml2ZXINCj4NCj5PbiAyNi4wOC4yMiAxODoyNiwgSmFuIEtpc3prYSB3cm90
ZToNCj4+IE9uIDIyLjA4LjIyIDAzOjE4LCBIb25nemhhbiBDaGVuIHdyb3RlOg0KPj4+IHBvcnRl
ZCBiYXNpYyBuZXR3b3JrIGZ1bmN0aW9ucyBub3QgaW5jbHVkaW5nIFRTTi4NCj4+Pg0KPj4+IDEu
IHBhc3NlZCB0aHJlZSBuZXR3b3JrIHJlbGF0ZWQgc21va2V5IHRlc3Q6IFVEUCwgcmF3LCBkZ3Jh
bSwgQnV0DQo+Pj4gICAgSSBkbyBub3Qga25vdyBpZiB0aGVzZSB0aHJlZSB0ZXN0IGlzIGVub3Vn
aCB0byB2YWxpZGF0ZSB0aGUNCj4+PiAgICBkcml2ZXIsIHBsZWFzZSBsZXQgbWUga25vdyBpZiB0
aGVyZSBpcyBvdGhlciB0ZXN0cyBuZWVkIHRvDQo+Pj4gICAgY292ZXIuDQo+DQo+VGhlc2UgdGVz
dHMgYXJlIHVzaW5nIHRoZSBsb29wYmFjayBkZXZpY2UgaWYgbm8gZGV2aWNlIGlzIGNvbmZpZ3Vy
ZWQNCj5tYW51YWxseS4gWW91IGRpZCB0aGF0PyBZb3UgcnVuIHRoZSBzZXJ2ZXIgcGFydCBvbiBv
bmUgbWFjaGluZSB3aGlsZSB0aGUNCj5jbGllbnQgd2FzIHJ1bm5pbmcgb24gYSBkaWZmZXJlbnQg
bWFjaGluZSB3aXRoIHByb3BlciBjYWJsaW5nIGluIGJldHdlZW4/DQo+DQo+SSBqdXN0IHdhbnQg
dG8gbWFrZSBzdXJlIHRoYXQgeW91IHdlcmUgcmVhbGx5IHVzaW5nIHRoZSBIVyBhbmQgbm90IGEN
Cj5sb29wYmFjayAob3IgYW55IGtpbmQgb2YgbG9jYWwpICJvcHRpbWl6YXRpb24iDQoNClNvcnJ5
ICwgSSBqdXN0IG1pc3NlZCByZXBseWluZyB0byB0aGlzIGVtYWlsLiBXaGF0IHlvdSBjb25jZXJu
IEkgYWxyZWFkeSBhbnN3ZXJlZCBpbiBhbm90aGVyIHRocmVhZCByZXBsaWVkIHRvIEphbi4gDQpZ
ZXMsIEkgZG8gbm90IHVzZSBsb29rYmFjayBkZXZpY2UgYnV0IHJlYWwgaGFyZHdhcmVzIGluY2x1
ZGluZyBpMjI1LSBpMjI1IGRpcmVjdCBjb25uZWN0aW9uLA0KSTIyNSAtIEkyMTAgZGlyZWN0IGNv
bm5lY3Rpb24gYW5kIHNlcnZlciBhbmQgY2xpZW50IGp1c3QgcnVuIG9uIGRpZmZlcmVudCBtYWNo
aW5lcyB3aXRoIHByb3BlciBjYWJsaW5nDQppbiBiZXR3ZWVuLg0KDQpSZWdhcmRzDQoNCkhvbmd6
aGFuIENoZW4NCg0KPg0KPj4NCj4+IElmIHRob3NlIHRlc3RzIGV4Y2hhbmdlZCBtb3JlIHRoYW4g
YSBoYW5kLWZ1bGwgb2YgcGFja2V0cyAodG8gbWFrZSBzdXJlDQo+PiB3ZSBhcmUgbm90IGxlYWtp
bmcgYnVmZmVycywgdGh1cyB3aWxsIHJ1biBvdXQgb2YgcmVzb3VyY2VzIGFmdGVyIGENCj4+IHdo
aWxlKSBhbmQgaWYgeW91IGNoZWNrZWQgdGhhdCB0aGUgcmVwb3J0ZWQgbGF0ZW5jeSBpcyBjb21w
YXJhYmxlIHRvDQo+PiBydF9pZ2IgZS5nLiwgdGhlbiB3ZSBoYXZlIGEgZ29vZCBpbmRpY2F0aW9u
IHRoYXQgdGhlIGRyaXZlciB3b3Jrcy4gVGhlDQo+PiByZXN0IGlzIGZpZWxkLXRlc3RpbmcuDQo+
Pg0KPj4+IDIuIEluIGFkZHRpb24sIGFub3RoZXIgdGhpbmcgSSB3YW50IHRvIGRpc2N1c3MgaGVy
ZSBpcyBUU04gZnVuY3Rpb25zIG9mDQo+Pj4gICAgaTIyNSBoYXMgdGhlIHZlcnkgc2ltaWxpYXIg
ZWZmZWN0IHdpdGggVERNQSBub3Qgb25seSBmcm9tIGNsb2NrIHN5bmMsDQo+Pj4gICAgbWFzdGVy
IGFuZCBzbGF2ZSBhcmNoLCB0aW1pbmcgbWFuZ2VtZW50IGJ1dCB0aGUgZGlmZmVyZW5jZSBmb3Ig
VFNOIGlzDQo+Pj4gICAgdGhhdCBtb3N0IG9mIGZ1Y250aW9ucyBpcyBpbXBsZW1lbnRlZCBieSBo
YXJkd2FyZS4gV2UgYXJlIGNvbnNpZGVyaW5nDQo+Pj4gICAgaWYgaXQgaXMgZmVhc2libGUgdG8g
aW1wbGVtZW50IFRTTi1lbmFibGVkIFRETUEtVFNOIGRyaXZlciB0byBtYWtlDQo+Pj4gICAgdXNl
IG9mIGkyMjUgaGFyZHdhcmUgZmVhdHVyZSBiZWNhdXNlIFRETUEgaXRzZWxmIGlzIHJlYWxseSBo
ZWF2eS4NCj4+DQo+PiBZZWFoLCB0aW1lLXRyaWdnZXJlZCBzZW5kIGlzIGJhc2ljYWxseSB3aGF0
IFJUbWFjL1RETUEgaW50cm9kdWNlZCB2aWENCj4+IHNvZnR3YXJlIGFsbW9zdCB0d28gZGVjYWRl
cyBhZ28uIEknbSBub3Qgc3VyZSwgdGhvdWdoLCBpZiB3ZSBzaG91bGQgbWFwDQo+PiB0aGUgY29u
ZmlndXJhdGlvbiBvZiBUU04gY2FwYWJpbGl0aWVzIG9mIG1vZGVybiBoYXJkd2FyZSBvbiBpbnRl
cmZhY2VzDQo+PiAoUlRtYWMgJiBDby4pIHRoYXQgd2VyZSBkZXNpZ25lZCB0aGF0IGxvbmcgYWdv
LiBJZiBpdCBoYXBwZW5zIHRvIHdvcmsNCj4+IG91ciBlYXNpbHksIGl0J3MgYSBuaWNlIGV4cGVy
aW1lbnQsIGJ1dCB3ZSB3b3VsZCBsaWtlbHkgbWlzcyBvdGhlcg0KPj4gdGhpbmdzIChRYnYgdHJh
bnNtaXNzaW9uIHdpbmRvd3MgZS5nLikuIEFuZCB0aGVyZSBpcyBhbHNvIHRoZSBxdWVzdGlvbg0K
Pj4gaG93IHRvIHNldCB1cCBhbiBvcGVyYXRlIFBUUCBhc2lkZSBSVG5ldC4NCj4+DQo+PiBKYW4N
Cj4+DQoNCg==
