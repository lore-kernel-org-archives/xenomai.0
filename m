Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643A61108
	for <xenomai@lists.linux.dev>; Mon, 16 Jan 2023 05:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673848435; x=1705384435;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=X7rwwXX2CjV0e+AuEi1/C2uRVXRMtAqVvNSbKKyMjXw=;
  b=FmQmCaL1XhrTz3YfbW2I/h8QRhtWReJblpLWSMZ0VnwK0KLyi32JT7Im
   DH5+u+04ZOVgW4d44zdxLyJcX2kbjvq8jKQ8nhOMyZa9bfNxk5ILiMCtq
   CctBVUg+5Hix3A4xSMrxPP8L6KELNlZGrnYTkritP8VQGl3EyddczFFPx
   FKCahkLEg16EfTi7aJm1D2VpYgmeDfCuwiV0PPCK2sx87Um5EPyp9kybR
   3gEaBOW9niNj/Ms8bocKvw0fXxyvAIh060jGhNX5DEs4N2QXzvzsNzoXT
   FlLc0EngjtHe9NgGbkfJofFBkKIxL4KIVI6w7PXTaiSCsTubxeMlyoBv0
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="324449420"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; 
   d="scan'208";a="324449420"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2023 21:53:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="904214481"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; 
   d="scan'208";a="904214481"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 15 Jan 2023 21:53:54 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 15 Jan 2023 21:53:54 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 15 Jan 2023 21:53:54 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 15 Jan 2023 21:53:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CL5dxPZwEKa9aBwyOjgy5uUMsNQ5BbAwzDx22NwXfA7sOT1HxGTSbiqFQysSoqM+YzbYh00tHa5tUw5H5+9DZYP7VYQjZDifRfCuFAHfgw/gh4C+SeOrjuw5/ldyRnEiFrQbyfJgD1bOiuD6+Owj26hlHoHqaec7XoVi8jJTgh0uTxbwhixdB3OrLvC+kD8rfPcJ6HXSIHIX/VU6Ri5i54r+Zj2KwvqLxM5eqPmIudyzjuzBUq0GyikFH6NUkZ3evwybnmIR98ifRSSnl+TG/WIUUzpNCoU+/5aAtO9eAVM/yfsJcNago/3bujh6AISSvJl/XeHR/VsvVQpisdsXgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7rwwXX2CjV0e+AuEi1/C2uRVXRMtAqVvNSbKKyMjXw=;
 b=dBcG0fUqrNGQI4MzGtjSgRs7qYSRyPFYnqR+A+r1Rbomr0Uyhgm+KrW58x+p6+CZnbZvx3k/4ye6uQFyYHgzbGRTs1/j9zYhb1ywhT84IUBHvN2OxCJC5TEzBITIRtgCYGyrMaJUW4v9+BXD6PLTCXOkaePxlSAq2Qzv86LjnZK+AVBnNKTeBphxwPV1B20K8ClPBi3bo5d0+dA+XMyHrgNV4n+uAtm+DIRMOjBLLM1TXryiWI4TKR3dsfNrE+bYxulhervAPI30SXPmqr5m5x/FrEWvFBJfqsbAjFSQ3LCYBeJfpqfIzW2swX+GUacjdkiYkaMB3ksVWppG0cFZYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by DM4PR11MB5344.namprd11.prod.outlook.com (2603:10b6:5:393::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 05:53:51 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::7059:2eab:6d8e:5bb2]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::7059:2eab:6d8e:5bb2%7]) with mapi id 15.20.5986.019; Mon, 16 Jan 2023
 05:53:51 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, Yunjie Gu <yunjie.gu1@gmail.com>,
	"xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: while loop in a multi-core cpu
Thread-Topic: while loop in a multi-core cpu
Thread-Index: AQHZKPuJYrpVvpaAY0Snx/eP6+qfq66gWcgAgAAnu4CAAAlM0A==
Date: Mon, 16 Jan 2023 05:53:51 +0000
Message-ID: <MN2PR11MB42855B83E5F981669B6B0ED9F2C19@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <1673779013-11742-mlmmj-00f27513@lists.linux.dev>
 <CAKcohPxHzbQvztgQMQaFq-EoXGbpfQxi1HpPV9nogBUaQ+PUSw@mail.gmail.com>
 <CAKcohPxdhCMohJZfSNaL2EvEDcLdm8CRgdy3hUusCu9Y5jexxw@mail.gmail.com>
 <MN2PR11MB42854A69C41937ADA0F29CDAF2C19@MN2PR11MB4285.namprd11.prod.outlook.com>
 <e8f0810b-7104-18a2-9931-a1df6ede2917@siemens.com>
In-Reply-To: <e8f0810b-7104-18a2-9931-a1df6ede2917@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|DM4PR11MB5344:EE_
x-ms-office365-filtering-correlation-id: 31db0b3d-ecd9-4c59-4d74-08daf7860b5e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jBg2Q7rTrjsATnZE6lpqI7lIy/Q1dEZ67yGNByMrReSc+yDjcp07vDRt7OVMyD/ZKx8qjKuY4Z9I4kE1DutDvG9hBvAZuX4iCz9XSfkXCk34GhFPuUS/ihbVlpVEijKz7KMn0uG+J/gKRGvdk5yHmW75NRymK5odJn27tDgks2663BxdbdAVEm4OGSkcXebsDzExHMyFkLQPqHsaSTGplg0oQ4YL9l+yicK6XOkM6oNjQ2jO/YX+TpNZ5ynEKyVZkmD25enROQxjbXJFSvjkmZcxZIOSxOiGGn+5reFML8zfKEDLSTCBjj22gQjWZYyC3q3jsGrhUk2dDqXU9Us77rkHtXm8lKQdz0JFsc7pjWgXmp3zN9/kqCVei1adD2JlGNuDqEd7Yooo/cNtRHxZjGBT/kpDQF4z5kUxoE82WVfk1iV5XKmH7OcBb5WSJXhkn8XWlDHbfpC8NKAl3NjIth3kyAAbcwb0ZFd7MSt3q3+tJ+9ykaxl90WjrCt4faZvQeV89HCfehSR00Vig6bMLIziSP738xMcX39zbc8VJONlFiehh9jTVC3ZwVHUnlg47DBCAGvcy+S49iK9QcyTs0XfgRsLofexz6oOfaVzM8F+0Xndpwu0D8G/GwXMIydAjyfhFxw2o3qw1M0gDg9JLm194T2sI1woA42n9hDN3TZHFbu8zDdxsBllOlxwM5l1VANQuz3iWk87h+VrtDvWMg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(39860400002)(366004)(396003)(136003)(451199015)(86362001)(53546011)(33656002)(26005)(186003)(9686003)(8676002)(64756008)(66556008)(76116006)(41300700001)(66476007)(66446008)(66946007)(316002)(71200400001)(6506007)(55016003)(7696005)(110136005)(478600001)(122000001)(38100700002)(38070700005)(2906002)(82960400001)(52536014)(83380400001)(5660300002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzFyQ2laMVZXb3c2V2FqUkZMOTZmK2pIUTY0VHNCQUtadUpWWnRHdlJJVDV1?=
 =?utf-8?B?clFsRVB0VHdCZUU4OVY1TkdSSWl3aXZHZ1huc2MycmU3bzNyUzBNWTNXenJ6?=
 =?utf-8?B?MWg5dmxNcUNzVkxFS28vRy9sTER0dzBQL29leXBub1NaZDlYL3I1MVRPYVY2?=
 =?utf-8?B?d0k0ZlVMRlVGQ2VqOUxwb2h6RXFNZXRYeW81RXpNWFI2ZExMQjQza0dCS2NM?=
 =?utf-8?B?aWh4ZUU5bk1YeHU1bHlpeFhkOTY0VmMxWnhhZkpWTmxwbDFxc04wODNIVG5H?=
 =?utf-8?B?RVZVWWhhSHc3TUpoTkkxVHBNVlFRcEVjRDhkTGppUW9jbExvU1dpV1d5SFJH?=
 =?utf-8?B?d3R5RkxJNWZRTGtrTnFBaG9DU1gwVGpxN2NpeWtpcEYzNFliTGUvS0lER0lr?=
 =?utf-8?B?OUdoUlJuUGxZRDFMaFAvc1YvTWNPaHJnSnhVQzUxOFJyN2ZvM3g2YzZQV1dp?=
 =?utf-8?B?T3d0QnlacnQ4UERYYkdsUHRRa0FsbC9jZXdtNkp4SkV4bmRSU1RnemVraEhl?=
 =?utf-8?B?L0EyY3JBSWdYVUN2TEhsRjJHTWdYdkk3TUN6ZFF4cmdKZjVrTTc5WVhCZ0Mw?=
 =?utf-8?B?aExSdE5uV3oxRkFTUjdwbDhwTHhFemJMRUV4Zjh2bTlrWU0zUnBoWlFJSjNk?=
 =?utf-8?B?N091cXBpZUQzeVBTM3d6ZUdPc3FSL1NkOTZJOVlMUE1DUlpvMzlsM056OHlU?=
 =?utf-8?B?Y2pQcEtYOUt4NHg3Smc1NWN1WklNNXFqVWc5RXNnNEt6U3VUb2hEQnpPaThi?=
 =?utf-8?B?bzMzOUl3eEZ2cGxGRGhJTEVFK0hsb1BuWDdxZm1VZm12bklQckFBajRYNTNq?=
 =?utf-8?B?eHQ3Zm1paXRQdVhWbVhIOTJCY1VrYzM1V1FNcndkOEhCdDFyOTJyMEFDU1du?=
 =?utf-8?B?eW8wWlFPVW51Q0h1cnMxeHJ3RUxOZlJGMmdPNlRjT2RuV3h5ZmJoOUhNdmky?=
 =?utf-8?B?Zmt6ZzJISUU2b043Z081TFFhM2srSFlQNWFFOVQxNis1WTV2eWtnQ3J4c2k3?=
 =?utf-8?B?SUIzMU9aOUJ6OVJKYXM2SXlHdFBSWXFxeGVXcnZKaEsxeElzSG83U3YvNnJT?=
 =?utf-8?B?YTZTNzVDSVVXQlNXR25MMTBzYlM3ajc1TEFzc1Fjc1VhWmdseGhPbG5UVTM5?=
 =?utf-8?B?K0l2QTdNUC9kSStRRE50bjBQMGRYRDRJYnJQRktQc3M2OVV5a0dzVFpLbU5O?=
 =?utf-8?B?Z20rbUdGbFpmcWF4ZEZUaHpGOGsxQVFCcU1VT2V3RTZvWEpNR21WVG1Yc3VS?=
 =?utf-8?B?K2VtNU5zYkJRbWdRbTQ3Zk9XTVQ3VUx1VU1UZjB4aXZpOEJZMUhwdVhrRTl1?=
 =?utf-8?B?MkNuNUUyVUdwbGRHcWRyaS9UREQyZ0ljZHRqR3h4SVVhT0hJZ1RCUDFGTDhq?=
 =?utf-8?B?NHU2Y3ZkK3ROOFVOc0pJcnFZUkhaNk9JSHFZd2dla05QelkwYXkwS0JNd1pX?=
 =?utf-8?B?VFh3M2dvUGYyaWREL3ppbnNwajRQZEtqSitmTU5WSW9yRWxyZHlNMmdpWmtK?=
 =?utf-8?B?N05EUXI5cFdNYXM5WTlDd0Zya2pUaURBNUVkQ0lpdHNVTXNOaTR3cDlneFlx?=
 =?utf-8?B?NC9mRlNPZDBFUHBHeGRIYWZzdTJMTndBcTc1Z29UYjNsRzg1TmhFREVNbXNU?=
 =?utf-8?B?c1hQMm4zNDl1ank3NXYzV2xCbFFmUXNzOTRyeUJudWpOcG0rekhnQzNRUzNE?=
 =?utf-8?B?WEt6cVlHcC85WlRydVJyQWl6SGRCcWZ1Ukc2Zm0zMXpEcFZ6Zm9xd3J2T2kr?=
 =?utf-8?B?ZkF0YVJST3RDMG1qSXp3cjhJN09Md2FXSEZvVDhhaTgvUTFXRDdrbVVBMFBx?=
 =?utf-8?B?RTErcmwyUkJKMFVIQ2MzM3l1YzJuRjFvMHk4VGJ5M296Yk1JczFqejZkRDFv?=
 =?utf-8?B?RlNSU1NGV2VlTjNOdGpHZjcyd2pDVmZXckVlWVQzaWE0Y0g2b0F0Y1cxUlIw?=
 =?utf-8?B?K2Mydy9JdGZrRmswc3F0cklYTXFrbDdPaUFicWtFUWlabng3MW9BVzFITDhl?=
 =?utf-8?B?UHZ2WUdUT3FUNldWb0ZDSjdpbXN6QzVzbjBYOWgwNWZkV1hHaEVzQ3ROZHNH?=
 =?utf-8?B?Y1lqNXozZ2JMVWJzNTJreWhmZWYvalc4Zkg1cTZjSXFjcG1PTVdTY1ZJV0pt?=
 =?utf-8?Q?gTVTsoNAks2WHFKKKebGBt4ff?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 31db0b3d-ecd9-4c59-4d74-08daf7860b5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 05:53:51.4441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4eEidUvRKP8/hx2MXz7NlE4maIXZ/foWiX3EFXAIHL0H9+uo9TqLRRjyxvVPAOX/7U2mDgFWEJUV6OUP5ozZfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5344
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEphbiBLaXN6a2EgPGphbi5r
aXN6a2FAc2llbWVucy5jb20+DQo+U2VudDogTW9uZGF5LCBKYW51YXJ5IDE2LCAyMDIzIDE6MTcg
UE0NCj5UbzogQ2hlbiwgSG9uZ3poYW4gPGhvbmd6aGFuLmNoZW5AaW50ZWwuY29tPjsgWXVuamll
IEd1DQo+PHl1bmppZS5ndTFAZ21haWwuY29tPjsgeGVub21haUBsaXN0cy5saW51eC5kZXYNCj5T
dWJqZWN0OiBSZTogd2hpbGUgbG9vcCBpbiBhIG11bHRpLWNvcmUgY3B1DQo+DQo+T24gMTYuMDEu
MjMgMDQ6MDUsIENoZW4sIEhvbmd6aGFuIHdyb3RlOg0KPj4NCj4+DQo+Pj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4+PiBGcm9tOiBZdW5qaWUgR3UgPHl1bmppZS5ndTFAZ21haWwuY29t
Pg0KPj4+IFNlbnQ6IE1vbmRheSwgSmFudWFyeSAxNiwgMjAyMyAxMjowOCBBTQ0KPj4+IFRvOiB4
ZW5vbWFpQGxpc3RzLmxpbnV4LmRldg0KPj4+IFN1YmplY3Q6IHdoaWxlIGxvb3AgaW4gYSBtdWx0
aS1jb3JlIGNwdQ0KPj4+DQo+Pj4gSGkgR3V5cywNCj4+Pg0KPj4+IFdlIGFyZSB0cnlpbmcgdG8g
ZGV2ZWxvcCBhIHBvbGxpbmcgbW9kZSB0aHJlYWQgdG8gc2tpcCB0aGUgZGVsYXkgb2YNCj4+PiB0
aGUgaW50ZXJydXB0IHJlc3BvbnNlLiBUaGlzIGlzIGRvbmUgYnkgYSB3aGlsZSBsb29wIHRvIGNo
ZWNrIHRoZQ0KPj4+IGhhcmR3YXJlIChzYXkgYSBncGlvIG9yIGEgdGltZXIpIGNvbnRpbnVvdXNs
eS4gV2hlbiB3ZSBkaWQgdGhpcyB3ZQ0KPj4+IGZvdW5kIHRoYXQgdGhlIHN5c3RlbSB3YXMgZnJv
emVuLCBtZWFuaW5nIHRoYXQgdGhlIG90aGVyIGNvcmVzIGFyZSBub3QNCj4+PiBmdW5jdGlvbmlu
ZyB3aGVuIHdlIHJ1biBhIHBvbGxpbmcgbG9vcCBvbiBhIHNpbmdsZSBjb3JlLiBCdXQgaWYgd2Ug
ZG8NCj4+PiB0aGUgc2FtZSBpbiBhIG5vcm1hbCBMaW51eCB0aHJlYWQsIHRoZSBzeXN0ZW0gaXMg
bm90IGZyb3plbi4gSSdtIGp1c3QNCj4+PiB3b25kZXJpbmcgaWYgcG9sbGluZyBtb2RlIGlzIGFs
bG93ZWQgZm9yIHhlbm9tYWksIG9yIGlmIHdlIGRpZA0KPj4NCj4+IFhlbm9tYWkgdGhyZWFkcyBz
aG91bGQgbm90IGRvbWluYXRlIGNwdSB0b28gbXVjaCB0aW1lIGluIGR1YWwga2VybmVsDQo+Y29u
ZmlndXJhdGlvbi4NCj4+IFdoZW4geGVub21haSB3YXMgZG9taW5hdGluZyBjcHUgdG9vIGxvbmcg
dGltZSwgZnJvbSBMaW51eCAncyB2aWV3LCBjcHUgaXMNCj5saWtlIGRlYWQNCj4+IGFuZCBMaW51
eCBjYW4gbm90IGhhbmRsZSBpdCBjb3JyZWN0bHkgaW4gc3VjaCBjYXNlLiAgSWYgeW91IGVuYWJs
ZQ0KPkNPTkZJR19YRU5PX09QVF9XQVRDSERPRywNCj4+IGl0IG1heSBub3RpZnkgc3lzdGVtIHRv
IGF2b2lkIHN1Y2ggdGhpbmcgZnJvbSBkZWJ1ZyBwb2ludC4NCj4NCj5UaGVvcmV0aWNhbGx5LCBh
IHN0YWJsZSBOT0haLWZ1bGwgc2V0dXAgc2hvdWxkIGJlIGFibGUgdG8gdG9sZXJhdGUgb24NCj50
b3AgYSBYZW5vbWFpLW9ubHkgc2NoZWR1bGUgd2l0aCBmdWxsIENQVSBkb21pbmF0aW9uLiBIb3dl
dmVyLCBhY2hpZXZpbmcNCj50aGF0IHVuZGVyIExpbnV4IGlzIGFscmVhZHkgbm90IHRyaXZpYWws
IGFuZCBJIGhhdmVuJ3QgdGVzdGVkIGlmIExpbnV4DQo+aXMgYWN0dWFsbHkgZW50ZXJpbmcgdGhl
IHJpZ2h0IHN0YXRlIHdoZW4gb3V0LW9mLWJhbmQgRG92ZXRhaWwvWGVub21haQ0KPnRha2VzIG92
ZXIuDQoNCldoYXQgZG8geW91IG1lYW5zIGFib3V0IE5PSFotZnVsbCBzZXR1cD8gSXMgaXQganVz
dCByZWxhdGVkIHRvIGNvbmZpZ3VyYXRpb24gb3IgY29tbWFuZHMgcGFzc2VkIGZvciBsaW51eD8N
CklzIGl0IHBvc3NpYmxlIHRvIGZpeCBzdWNoIGlzc3VlIHRoYXQgd2UgZG8gbm90IG5lZWQgdG8g
bW9kaWZ5IExpbnV4IGtlcm5lbD8NCg0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQo+DQo+SmFu
DQo+DQo+LS0NCj5TaWVtZW5zIEFHLCBUZWNobm9sb2d5DQo+Q29tcGV0ZW5jZSBDZW50ZXIgRW1i
ZWRkZWQgTGludXgNCg0K
