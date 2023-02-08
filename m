Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3021437B
	for <xenomai@lists.linux.dev>; Wed,  8 Feb 2023 02:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675823231; x=1707359231;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=yxCAvU70U4rrtzGJ/bwCA8piKiVTPmJ9whMQk65g0SI=;
  b=K0IbsElP5QvkSvKGgmlYzQ8y6ZaxcIBy/lnQHIO0Xlvyzu3rw97EVVy3
   1DnyeS+8h9zpoIAyuJxGEiw2/OclfxyDq6WYz31URmOAP3xV6W/LhLBNL
   hrCVAf0FLnyT516HnBoHWy1+eTODo0KN38B6Skz7rn2VlkZlcRvevt9j+
   mT7VOPm2f8ZwjYI+JXaoWS6hq9g5XLa+M/p2fW/Zz8+8R5XsOl+9lbivr
   mJjCpQM0AN+/1naE7n30z/heg3ErjInxnuGXwL8jLQ/C1ehx+tja7UX8N
   5hORruq75D7WX5hjwXodppbBXgui8/BQ5EqGB8c26Iv7uvZTDoGehgLbe
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="317687517"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="317687517"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 18:27:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="644676016"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="644676016"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 07 Feb 2023 18:27:10 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 7 Feb 2023 18:27:10 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 7 Feb 2023 18:27:09 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 7 Feb 2023 18:27:09 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 7 Feb 2023 18:27:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYxXCWYUanzR/W+uY5786v5iQecijQxfNgvDbXiBAyiw9NEowEC3lGw84iQIQrvp/dQLTlmh6Nn3pxax043u0HBpES6zK2sWmAr+vEM+UDzYhuKbsyWz1nawffjMAQF7AU2kzTV+AYR5tt8BlY1FFSWk/FX90xTK44ctQUKYMACJ6hEWrLIh3hqO8yTClOLjCwqqQD33jkC6UdGkAgklXTlCNYqBFze6XSC3FnEWKY0bu2pxSzbdceNZ5APDiNmeCj2P1vOZbMHgQVkG52ZA5zTD8ETxrViQJAVv8HRNqANYwYn9oOq0vxBKCn4JTwuz/+++SP1V2EDUmpzGrWRe3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxCAvU70U4rrtzGJ/bwCA8piKiVTPmJ9whMQk65g0SI=;
 b=ajhcAFF3+vEm98kMSQD3eOiNSEKF1KTXFhdEaLy+6i+/JRbik18M50dSBfLlCrLPLSmXdhg3h1Y5djKEG9wVy3lhfChmrudfDYk2rNR3b0ZxhQ7vz7r2vQE6E+Yrez9cdE6HneU5QyiypAv6mC0LFj+XN8+4GbbSdbuhC5l2xYPfKHcLNDERSeH6toCZZ7UStSD5C2252FKPheDsnWY7RX187wPUgfKCMy9YY/jmTT6v2ZjW1s711SByNMpTV/j3RjmBk7CaM+BmaZQfG/wwsaF61le00FQI0UMN/O7aImBzd9GFesCa3hoPvtk0imNLrZjEEpFKmGpxM6JAhF90fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by MW4PR11MB6691.namprd11.prod.outlook.com (2603:10b6:303:20f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Wed, 8 Feb
 2023 02:27:02 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::7059:2eab:6d8e:5bb2]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::7059:2eab:6d8e:5bb2%7]) with mapi id 15.20.6064.035; Wed, 8 Feb 2023
 02:27:02 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: Mauro S. <mau.salvi@yahoo.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: RE: undefined reference to `fuse_main_real_compat25' when build with
 --enable-registry
Thread-Topic: undefined reference to `fuse_main_real_compat25' when build with
 --enable-registry
Thread-Index: AQHZOxXET3bui1J8uUKUnenppi9JHq7EUkgA
Date: Wed, 8 Feb 2023 02:27:01 +0000
Message-ID: <MN2PR11MB4285DF9642B16AE3F170431FF2D89@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <fc2f8e65-dce5-452d-3789-70ebc838abf2.ref@yahoo.com>
 <fc2f8e65-dce5-452d-3789-70ebc838abf2@yahoo.com>
In-Reply-To: <fc2f8e65-dce5-452d-3789-70ebc838abf2@yahoo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|MW4PR11MB6691:EE_
x-ms-office365-filtering-correlation-id: c1a6e334-5150-448c-c300-08db097bf63b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EYWgn0H54Fv7UTC3FP2wyRC//4JcCZpSY6+Te3GVix2DlRw15haaQVY7zDVQwuBttSygBt+XHu7NMLFfI6BiYYK4Naa9gaQT2S4lWzWNWumgue/m9hlIA71Vjkaq+XQV5/qEFPaOtiqfPjV9Xf/AduGiQwhGLZDpi7XtFqY/PyLjkNsVwX2UkrCFtnjD4cjx189uABdfEIiPEPBaXh2M18ecfWEchqTgNFTZxLB/TqpmsDWoNzF0AQQ2YHRZGpoi3fqSuqB+jD97C5p56XRyWt6YDMyfqPzj9bAbLZ97J7OAR4U5/RwRxiW1Cc+EYG8I/+lVBLt3xPWFr09yhyo+P/X4S+HkeKH0WkBnDcJ7BpJ9awQX1qDkeUcBw+LnzhW8mmC/W+hd8xpMNUVB2Dv5HBH++lM5t3I3XKSp9P0gDf1aUHNCb0Px3ISOh23iNNMZI3MzUKdn+sj+sQA+gbSC23mDFBptPv0bEa7oKe15wlxlrfssb0FPGXSKBPr8HOESB3wYSkfy8EOS6ozdCye5ro6WCsffr/UH4p1DgPzE0q2vGn1PKiAhnLDZEfm4wSlZTrKmweM12inE22vrwv0HlAbceHbVO10/d+usyMXy52dJ6WapH7aFbPHa2/hnvHvGcIErgIlaV0LLXuKuCrjpXkh5YPN0eEPGJhY4Rddbi4knaw93AqK+3cZhYqFh5K+YMuWzWKMcYQT6ciDoIuplLldrThg0pSAXIXG9F5e3VXU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(396003)(346002)(366004)(376002)(451199018)(55016003)(38070700005)(33656002)(2906002)(38100700002)(82960400001)(86362001)(478600001)(122000001)(110136005)(316002)(7696005)(71200400001)(52536014)(41300700001)(9686003)(6506007)(66476007)(8936002)(76116006)(83380400001)(66946007)(66446008)(5660300002)(8676002)(64756008)(186003)(26005)(66556008)(81973001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0dBb2FXS2Q2bjBjblZab1dYRDlZTjBOOWhtNGt0NkRYL3hZeXJmWlFNSlJN?=
 =?utf-8?B?ZUJ1TnRQZ0JZdGEzVXBEajlSVy9DQ3J4ekMwcUdJcWdDYmU0WFc1SEF6L0U0?=
 =?utf-8?B?MERYQ2Izdmx3RitpVFV5dW53Mk95QjZHRTZJOWFCaVIrT1BvYzAzUFdUS0ln?=
 =?utf-8?B?UHlBa1hmb3dHWVdhNm81Wm5NdkFNaUNrRk5YazJGVmVkWjVVbGY2UXcvcmZC?=
 =?utf-8?B?cVViUWZpNjFZNTNXR0xXU2ZKTVlBWmFoM3BxQS94bkRISWJrRWFuL05tU1Js?=
 =?utf-8?B?SzczQ1pCQUlzalJha1cyVTI4NkNWTFdGUGRMRkRnK3BteE0zcmt4Yk9TcHBQ?=
 =?utf-8?B?dUN3TmNsMDBzRm8zSmlWNEVYMjF2UHcwTDJKakN5LzIyT1NjWmhoM1lEcUp5?=
 =?utf-8?B?NXE3S1d4WXAzNGtKd0s4eEVhSFZEd0Ywek54VG5DaVVvZGZoV0JKRlVDMXlC?=
 =?utf-8?B?cG5lYXRrRmpjUXBjMmVrZzRTSHg3WWYwV1o1OE5mbmNWVUZzREkvV3RaSEVE?=
 =?utf-8?B?c1RtK0J0UU9zamRqdFp1UTR4NFB6NUVmTzl1bEFoTTdQbmhOMWsxck1uQzJP?=
 =?utf-8?B?enBNb05FOTZzR004dkRZTmdjR1lGcGRaeEMwWHg0MlZCQkU4NDJHQU9oYXBr?=
 =?utf-8?B?Tlo1UTBVUDBnVHNUZnR6OExleHFFQ29OeGk2eTNZbHBIYUIvMEQzM0w1OVIx?=
 =?utf-8?B?czJkZW5RbmdNcHdBeFY5QklPRkFqd29lZDI3djlibEtWZ2d2VVppOFZFdlpS?=
 =?utf-8?B?MjZ0Z1NMd2Z6UWRFdmNlb3lsditaSTVUVU5EM1IySzBkWmpuS1Z1R3BQMmVj?=
 =?utf-8?B?a2psZHBQUjliS3d2b3oyQklDK1JnNHhGWGVWTkx6Z2czWExYK2Yyb0l3dEhq?=
 =?utf-8?B?WXZCMkNqWFd3VGJsRG9wM0tNSUo4bDlwY1l4T0xaTHQ4WWZ5c3I5ZDhBb0Vn?=
 =?utf-8?B?Wnl2WXZlcUtpdFg4QTFsT3Bla1RTNWlwMWJ5WEhId2g4VnVXRFF6UC9YblRB?=
 =?utf-8?B?RmVRbFo5WVo3emNmY3NGVjZDRXJKWnR1VzAxU1hjZEhWWnFJNmViMFRGQjVp?=
 =?utf-8?B?dTljdzdCT29yN3lkSXM2YmlSUkRCbUlRdEQ1UmJBOE9BYkFQWDlEcUJJZGZE?=
 =?utf-8?B?T0RpUjI0bkpXa2wwUzdtZEN1Slc4elI3RXF3aVZOaStiMnlHdVVWcmJrTHdY?=
 =?utf-8?B?Z284VXJmZnhibk5RZWpKUE9MdnZzZnIxRFRweFNGdHRUWDNNUTdoY2g5c1Zh?=
 =?utf-8?B?RkoxcE1wcEpUTmNTOVk1YU9oYXJMR2FTSkcrT0FnMittQTQ2ZEVKejhPREJx?=
 =?utf-8?B?eU9idEczTFpYNmZYMlZydS9XcmF4V3NZNXk0TmdmWWRDVUZpQzE2aHprQ2du?=
 =?utf-8?B?N2RjTEQwYUlIdEc0RWgrM0U2WHFrL29jc1VCaW9zZnBUZm1adm9MMEwzazlz?=
 =?utf-8?B?Tm1SWFlLUFpHT3ZKN1YrNUxoS2htbVp5VFQ3R1pHNWZKbndVTk1LQVQ0SUU3?=
 =?utf-8?B?bmpnc3Byc05jdVptMDBkcER2cGZrNENoQWg2V1hBS1FQOWdhQUxuTURqSk44?=
 =?utf-8?B?bURTNkFScy82cmxYV1BIYWV5RVBzdUdBUlprYWg3ZExmdWZOVlpZanNXYUlT?=
 =?utf-8?B?aTRrajR2WDNGb0FhZFRjaGJiWnFFaUViVytRWkpMdTZaSE9zNWtRSWpPUThI?=
 =?utf-8?B?Nm9jenQ0MG1IRFVvNi9ER0luR0pTNTA4NGtqcXpCd0FEeS84Z296Y0lwTXV1?=
 =?utf-8?B?dmxsUS9BLzRXTEtsYWtjTEV3UXlGUWlqaUtRRjA0M2NkOGdhMjlESG9XY0Ja?=
 =?utf-8?B?bGQ4Q3cwZEpZcEE4ZTRiZ3kxVDF2TGt6QVVWSElwdE1oYkRGbDkyeExUY3Fl?=
 =?utf-8?B?aFpXV2V0dE1RS0FUSU05cG4vNUY2UENOcisvUStsMUY5bTIvMjBlNkZKWGlD?=
 =?utf-8?B?ZEdFZWRCTzJnVlJXRVJoU1A5WWZ4amJwSnA0aFN5eUEyL0FhenhZc0xqNXZV?=
 =?utf-8?B?TS9VazZiZmZHUWt1dm1Cb1QvTldGeWIweUFaREMybWFmbzIwV0Q2U0lScmVN?=
 =?utf-8?B?RldBTEM0cmZ1WXVyTjhEbkZ2VzdteWZaTVR1YW5kamZWd1VMaVRYTXh3VUhG?=
 =?utf-8?Q?iY8DA18I2UynGTI7TsiSfQMgu?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a6e334-5150-448c-c300-08db097bf63b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2023 02:27:01.9640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MupaXDjAh5RD3SaWGolijRdudguE+mP59MIBxrkH6hDAursx1ioio5O7o3BK8pSHOfboDX9j3Ybs0o7Tc4aGuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6691
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IE1hdXJvIFMuIDxtYXUuc2Fs
dmlAeWFob28uY29tPg0KPlNlbnQ6IFR1ZXNkYXksIEZlYnJ1YXJ5IDcsIDIwMjMgOTo0NiBQTQ0K
PlRvOiB4ZW5vbWFpQGxpc3RzLmxpbnV4LmRldg0KPlN1YmplY3Q6IHVuZGVmaW5lZCByZWZlcmVu
Y2UgdG8gYGZ1c2VfbWFpbl9yZWFsX2NvbXBhdDI1JyB3aGVuIGJ1aWxkIHdpdGggLQ0KPi1lbmFi
bGUtcmVnaXN0cnkNCj4NCj5IaSBhbGwsDQo+DQo+SSdtIGJ1bGRpbmcgWGVub21haSAzLjIuMiBm
b3IgeDg2XzY0Lg0KPg0KPldoZW4gSSBjb25maWd1cmUgdGhlIGxpYnJhcnkgd2l0aCAtLWVuYWJs
ZS1yZWdpc3RyeSwgSSBnZXQgdGhlIGVycm9yDQo+DQo+ICAgLi4NCj4gICAgIENDTEQgICAgIHJ0
Y2FucmVjdg0KPiAgIGxpYmNvcHBlcnBsYXRlLnNvOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBm
dXNlX21haW5fcmVhbF9jb21wYXQyNScNCj4gICBjb2xsZWN0MjogZXJyb3I6IGxkIHJldHVybmVk
IDEgZXhpdCBzdGF0dXMNCj4gICAuLg0KPg0KPmxpYmZ1c2UtZGV2IHBhY2thZ2UgaXMgaW5zdGFs
bGVkICh0aGUgY29uZmlndXJlIHNjcmlwdCBmaW5kcyBmdXNlKSwgYW5kDQo+aXQgaGFzIHRoZSBm
dW5jdGlvbiBmdXNlX21haW5fcmVhbF9jb21wYXQyNSBleHBvcnRlZA0KPg0KPiAgIHJlYWRlbGYg
LVdzIC91c3IvbGliL3g4Nl82NC1saW51eC1nbnUvbGliZnVzZS5zbyB8IGdyZXANCj5mdXNlX21h
aW5fcmVhbF9jb21wYXQyNQ0KPiAgICAzMTg6IDAwMDAwMDAwMDAwMWE1MDAgICAgMTQgRlVOQyAg
ICBHTE9CQUwgREVGQVVMVCAgIDEyDQo+ZnVzZV9tYWluX3JlYWxfY29tcGF0MjVAQEZVU0VfMi42
DQoNCkkgZG8gbm90IGtub3cgaWYgaXQgbWlnaHQgYmUgcmVsYXRlZCB0byBmdXNlIHZlcnNpb24u
IEluIGNvbmZpZ3VyZS5hYyAsIGl0IHNlbGVjdHMgZnVzZSB2ZXJzaW9uIDI1IGJ1dCB5b3UgYXJl
IHVzaW5nIDI2Pw0KDQppZiB0ZXN0IHgkdXNlX3JlZ2lzdHJ5ID0geHk7IHRoZW4NCiAgICAgICAg
UEtHX0NIRUNLX01PRFVMRVMoRlVTRSwgZnVzZSkNCiAgICAgICAgRlVTRV9DRkxBR1M9IiRGVVNF
X0NGTEFHUyAtREZVU0VfVVNFX1ZFUlNJT049MjUiDQogICAgICAgIEFDX0RFRklORShDT05GSUdf
WEVOT19SRUdJU1RSWSwxLFtjb25maWddKQ0KICAgICAgICBBQ19ERUZJTkVfVU5RVU9URUQoQ09O
RklHX1hFTk9fUkVHSVNUUllfUk9PVCwiJHJlZ2lzdHJ5X3Jvb3QiLFtjb25maWddKQ0KRmkNCg0K
UmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQo+DQo+U2VlbXMgdGhhdCBkdXJpbmcgWGVub21haSBi
dWlsZCB0aGUgbGliY29wcGVycGxhdGUuc28gaXMgbm90IGxpbmtlZCB0bw0KPmxpYmZ1c2Uuc28u
IEkgdHJpZWQgdG8gc29sdmUgYnkgbXlzZWxmIGJ1dCBJJ20gbm90IHZlcnkgZmFtaWxpYXIgd2l0
aA0KPmF1dG90b29scywgc28gSSBnYXZlIHVwLg0KPg0KPlRoYW5rcyBpbiBhZHZhbmNlLCByZWdh
cmRzDQo+LS0NCj5NYXVybyBTLg0KDQo=
