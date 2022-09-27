Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5DC7B
	for <xenomai@lists.linux.dev>; Tue, 27 Sep 2022 01:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664243806; x=1695779806;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=j2n4oXTtqGZrs16EA1u5dCc4BkWAt0243bZzvu83lV8=;
  b=ZPOyYg1lIf0KDttXtmvNAk961vT86h3nBa+IATN4fLtdELwcGyMpoSGX
   zPm3/80B4JoNnFXzQMtPlDZw8pQponFXF/HDw42BVL0IpDjrqlgD24bTS
   5UX5BiU4jCDM6EPM5j1S0PRIx1neZ9+Q3Nb3wvWsLL+MR8aLj73ow1fvZ
   Pnmj418YcOEylJiUNOOg08aBzC5lSK6DjfkPJOQpNf68qzuO3+1MRvqi5
   l7FhvK3dtLmssJSlD7sGNJsrJlbiQ4q+9mPH7s7BFqPl1Dih3pyh/2MN8
   BbI3K8UMD+EonU4q0FYjfF09ZSf+SZal/lqlW9PU2mGI2DVGGjKTP8b9E
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="302095191"
X-IronPort-AV: E=Sophos;i="5.93,347,1654585200"; 
   d="scan'208";a="302095191"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 18:56:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="710368052"
X-IronPort-AV: E=Sophos;i="5.93,347,1654585200"; 
   d="scan'208";a="710368052"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Sep 2022 18:56:45 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 18:56:45 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 18:56:44 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 26 Sep 2022 18:56:44 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 26 Sep 2022 18:56:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=benvukR9IQSoRyGNeUn6F2iVv0QdDMtVm+7m3+uvy8vVgblutxsqwGKHH1Id+9LVBrww+EFpf14VvVuylw6EESKwq/qUSGsLQTi8bvge4+9YeEHND6LOK0kAajAV60OGYaTfukJl+ruCbAgEAN4q1ncekOtycPX4ODkUQd25PkP7wi/jG751j1JOIIQp8oAvir6EF6z4RX7jzWNNpeBBFkOPbr45EKPaoKNJ67RFcFQeXthbIxKZawbv1ihyFmj3JWUfiuLqqbpTXtrarhYOE0/86W3aNeAXpaJigg59cGGsjvt8eHx8jeoM2DXx31iJBH59SQ+6p3J/K0I3aSyPGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2n4oXTtqGZrs16EA1u5dCc4BkWAt0243bZzvu83lV8=;
 b=idJDRjmjXAHENUgEurbPCSzEOw/Mj8MWiCrbWuKJdFZutz2ApRuaSWBOSPkKVsthcQqW7pdYAu/+kj0Hxp7wzTfp4PtGKoEG1pdgp/TyQHAAOgYUk0eLAF8jM1CLwbnHM9ZvFshqfvpnW13E5qA/KIfJj5gMsUWKhTOwpfo+k9mXNN7QuoOxpK173vHmUXLraHWPnHPPcUbVVzPk1424XLlicwlwzCJ/8edgHPB/Tb1DiltXcPCF7C9f09tHU4W+E3o37vWOD+PeGmg3IXgHPsGhYh3SJMPifEQh1L8lTqOxlpVRRGgXjo3wQkX0DR+7hH3EjR0vDJgsLSxNSF3mnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by MW4PR11MB6715.namprd11.prod.outlook.com (2603:10b6:303:20e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Tue, 27 Sep
 2022 01:56:37 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::3d0d:2390:e16e:3ab8]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::3d0d:2390:e16e:3ab8%2]) with mapi id 15.20.5654.025; Tue, 27 Sep 2022
 01:56:37 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: C Smith <csmithquestions@gmail.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: RE: Secondary Mode stall during IDDP communication
Thread-Topic: Secondary Mode stall during IDDP communication
Thread-Index: AQHY0gtH9Lv5JHjblEa44ee1cGBJWq3yemZg
Date: Tue, 27 Sep 2022 01:56:37 +0000
Message-ID: <MN2PR11MB42859A4BB019A053D2782430F2559@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <CA+K1mPEGDrQ=8NvyD_SK=CJTDj6TVphQRvKxM0BRcrcuKHkQHA@mail.gmail.com>
In-Reply-To: <CA+K1mPEGDrQ=8NvyD_SK=CJTDj6TVphQRvKxM0BRcrcuKHkQHA@mail.gmail.com>
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
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|MW4PR11MB6715:EE_
x-ms-office365-filtering-correlation-id: 87660943-e612-4dc4-5c5e-08daa02b8345
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r9UmoWQ5MRPw/CKeXZv+6UZwZd+2ISjp6LOVyFigbqtUykwVvgIiIIlH3B30Ff/h/z3bXsLXBeaVruUj8aDgdfuto65Y63zDy3krwSfpRXbwYCpph0yqSmuHCr4vXrpLRx5S+PTozp+dDxLQM+urnaMd6JiJPglYi074FfK6gW8oojna5sK2yHdw1k3y3cFgbl/Wwl2ZcIND/RbxJnQBAAtVZ3TxKspTRN1ecvp/wyXHRHG8Vw8WjaJASSb825Pa2unpXjnZHjh+a6SFx8dbb5A7i19/XZj48pZkwpmQeZsXtGcRpqPKubNVP57Q4z6E2dgKt+zWQluXrcGa5qZLx7nsRFg57dhHGXtjb4GbLKT1OIAMxgjVG72gJy3cqvdtpgJHbidfhEjXWXnSZOGd5lgaOUSbZAILpRIFs5M2FZc8O3Rx7xKeMcZl/FfUMrj53eEjhmFpXx2TpQdT90KVXhkYY3+XvY8aOxmUiSrHtAHKNmBho6lHalSUaNifMrCV10nEn8iRkBSgGtqhKlZtAHBKJUD0Mo7dNPOGxCdOYyKmiFTOsTC0aXp2IAF2v35dIJHd7TGwgaWnMQecuc72b6gpKFqqU3a3bXfwxn4nGr4DPUIb0Xu2B1eYpDkwv48FKcjoMFPNK2dIMHCzRbEMZSqWp6tC0eaoCazhiWRwc4bRGVdJ8X2KY9htPxVV1KZNXv7HL2jyxSof2+zSCoGKJ51RCpZUpErOrZAhL5ZVgJ8CCrFoM6rOkTv4bPYDqbocZYtxniEwzvnQEt42zIYYew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(376002)(39860400002)(346002)(396003)(451199015)(66556008)(5660300002)(8936002)(38070700005)(52536014)(86362001)(2906002)(71200400001)(26005)(41300700001)(83380400001)(186003)(7696005)(9686003)(478600001)(6506007)(76116006)(66946007)(82960400001)(66446008)(64756008)(66476007)(316002)(8676002)(122000001)(110136005)(38100700002)(55016003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWVvSUhhSlJHSWZqYlgzTzdPRFYvSkJTbm9QNGJ6VnVDR1JCc3hwL09BdHJu?=
 =?utf-8?B?bHlFNWpxVExDTlE4d1p2c3ZwdEF4aXFGdTczZnZRTjdSc1FIVnJzT1ZyK1hO?=
 =?utf-8?B?Q3hvUkwyTUFVUXV5U2ptdStwaHpvblU4OXdVVnd6azlYWHJNRjcvQWVNSlAw?=
 =?utf-8?B?c0p6SXNESFdiUjNlMVQvOHRjRjZoYy9xL3Z5N1NNUE10ZE1EYTMwYm0yOGJP?=
 =?utf-8?B?RGNiNWhYUGpqeEZrdThzT0dMQlozNmdaY3p3ZG9LK1Q1UTU1a3ozUnExbitV?=
 =?utf-8?B?a0o4bmZQZ2s5N2lkMXhuZzFqV3dlaXRHTExzZWRzZVRZWE9yMWYrWi9ZWStS?=
 =?utf-8?B?NlhqL0FZMHN4UUlXR2dQd3l2bjNQSTYzRlVEMjlNRmdsdmlubG1PZDR2b0wr?=
 =?utf-8?B?OUNmK28vakJ0dkhUUUVLcG5qTlA1aSsrRWhETEpiM3VtUHBFWXdWb2dYdkI5?=
 =?utf-8?B?RTA5K0NSRVoyeE42WjkwQ05sK0wvUDVZY0YvSkdKenNPS3FLbmMxWTByK1Ez?=
 =?utf-8?B?V3FyK1dLMzgzZ1loRy9MQk5HcUpNUlFnQVpzdVpaY0NHckpURVA1SXZBYmNW?=
 =?utf-8?B?NjNxU3RXUWtiZG04WmNNS3RqUGhNdS9XUHd5dmhMOUp3dnBRSXY2akhIQkxE?=
 =?utf-8?B?dXFKZG8ybEl5RVZVZ2VsMTNKRmVUcTJoSFBxWXNLZ1pXYlFLcTlJOEl1TkpH?=
 =?utf-8?B?WXF3eDF0MlgxL1FWdVhHNm5jWm0xZFh2b1VpZ2YrVlBrcSsxRVovY1l3c1FX?=
 =?utf-8?B?YWhVdCtYZUlOYk8zdVJRc0pRdG5kWlN3TjNTeTdjMUxMRHJQd0p6dlZJdXJq?=
 =?utf-8?B?WThkSG9FMllxQzBZd3BNZjNTKzVJN2VRVXE3U0NyUGxHRWVFeXF1ek1TS1gv?=
 =?utf-8?B?N09FZSt5S0ZSTTlPRnd0eCtybzFtZFhVbzR6RHRXSFlqYkFSOU5nYnZvWnlx?=
 =?utf-8?B?ckpNY2NvT1FUQzVzMEZ0ajh6QXJWekhqajU3R3UxU2lFeDIweHhQdmpsMkQy?=
 =?utf-8?B?N0dUYW41LzhkTlZCODBacnNXdEV3YTFORlBiRVZpVjAxdi84M0ZSUCs3dG5t?=
 =?utf-8?B?VldpY0RLSHVzTmZSbHRXMlZJTWZYRFgvRlVma1B6MTNMT1J4RndEU0s1dkVY?=
 =?utf-8?B?Z0pCUEE0b3dhMWhCQUxZdWRzeXpPOThhN015amN6VkZ6N2xJWlorU0ZaSEgz?=
 =?utf-8?B?UU5IN3cyOFVWcGNEcU1NYWtRR0F4QWs1OEo3WUE1azNIUjRNRjI1TXJmWVBm?=
 =?utf-8?B?MWxzRmZLeEhLSVNJaWxpclZDZ0NUQVZvODNBVXc3UXFHeE9MMys1Z0s3bGtk?=
 =?utf-8?B?TDZnTFVNS3ZZSEV0SlVVY3dwaHhKaTZhU2lzRG1CcGhKM20xdTlQMFZ5YVJL?=
 =?utf-8?B?MGlKNEh2bytjeVd6TzFjN1kvTzZFWmxSRnBwU1FPLzZvTkhNcjM5bHNIWnF0?=
 =?utf-8?B?dllwZ1djYmlMTGtDempTOHdrdmViZEg0a3V1RXFkR3QydnNNblh2RHB4bDN3?=
 =?utf-8?B?Z1I3UUJsaDlYUU11dG8rVEN1VGhmMTZUVE1ZT2pxdGtseGVwUmhiY0d1aHhX?=
 =?utf-8?B?cUFDS2RjaVovM05aZDVoaTJxWXJQYVhHVEFWNlJaOXVWK2xrUDlIdnVjd2ha?=
 =?utf-8?B?SVpXSXFoNWtlVTRZaHlTeHQyZlYrVjM0NGV5dGdubGpIdi83a0xEaUJLd1lN?=
 =?utf-8?B?T013d2UyRWFqSGFWVENaaEtFeHBuZFlsdVZzVk9wMmozMlhXdkVLWjN0b3dP?=
 =?utf-8?B?dXM0L045ZWJYQjdHWllGU0NnMmFoUklFdzhDbVRzZUlnUGs1eEcwTnNCb0Zw?=
 =?utf-8?B?WVZwRVN6WE9vME02K29DVlgrZFBTSXl4RVpWNjNzOWlXcXVGQzh4dWZBRGg5?=
 =?utf-8?B?d2ZZd0RnNTVHTXlBdzhNU3owQkgyck5qa1ZPVlluaUN2M3B4SWlGSzlpaEZ1?=
 =?utf-8?B?ZWRCTWlERWhRdnEvbi9vK3BiNXI5MzNUNmpsWHpYZndmclhVNFlRTGlZTE1N?=
 =?utf-8?B?RVBNRVAwNWs3Sm9SVnVCQTc2NytIMXFwMDFyMGlKOU9IYTcwVElLRVl4a29E?=
 =?utf-8?B?WDJWMFNVUlJqbXZCdHE1ejgwMitRQU5DNGdScUVXYitSUUdQWnJtU3Z0WWhr?=
 =?utf-8?Q?ymANCVASHG2sMJnRRar/2e6n/?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 87660943-e612-4dc4-5c5e-08daa02b8345
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 01:56:37.2432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Iv2E04qYF0yTT83/xmqRRgoSW3QafwIBVDHNM7PGYcoq9CnE0M85hcs/8FDA6FiPq5XA8vHVhZ/1I7ZKZcaxTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6715
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEMgU21pdGggPGNzbWl0aHF1
ZXN0aW9uc0BnbWFpbC5jb20+DQo+U2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDI3LCAyMDIyIDg6
NTEgQU0NCj5UbzogeGVub21haUBsaXN0cy5saW51eC5kZXYNCj5TdWJqZWN0OiBTZWNvbmRhcnkg
TW9kZSBzdGFsbCBkdXJpbmcgSUREUCBjb21tdW5pY2F0aW9uDQo+DQo+V2UgaGF2ZSB0d28gUlQg
dXNlcnNwYWNlIGFwcGxpY2F0aW9ucyAoYXBwQSBhbmQgYXBwQikgY29tbXVuaWNhdGluZw0KPnRo
cm91Z2ggSUREUCBzb2NrZXRzLg0KPldlIHJ1biBpbnRvIGEgcHJvYmxlbSB3aGVyZSBvbmUgb2Yg
dGhvc2UgYXBwbGljYXRpb25zIGRyb3BzIGludG8NCj4iU2Vjb25kYXJ5IE1vZGUiIGFuZCBjb21t
dW5pY2F0aW9ucyBpcyBoYWx0ZWQsIGR1cmluZyB0aGUgY2FsbCB0bw0KPnJlY3Zmcm9tKCkuIEhv
dyBjYW4gd2UgcHJldmVudCB0aGlzPw0KDQpUaGUgd2F0Y2hkb2cgdHJpZ2dlcmVkIGtpY2sgdGhl
IHJlYWwgdGltZSB0aHJlYWQgb3V0IG9mIHByaW1hcnkgbW9kZS4NClRoZSBSVCBhcHBzIG9jY3Vw
eWluZyB0aGUgY3B1IHRvbyBtdWNoIHRpbWUgbWF5IG5lZWQgdG8geWllbGQgY3B1IHRvIGxlYXZl
IHByaW1hcnkgbW9kZSBhbmQgDQpsZXQgc2Vjb25kYXJ5IGRvbWFpbiBydW4gYSB3aGlsZSBmb3Ig
ZmVlZGluZyB3YXRjaGRvZyB0byBhdm9pZCB0cmlnZ2VyIGl0LiANCg0KUmVnYXJkcw0KDQpIb25n
emhhbiBDaGVuDQo+DQo+V2UgYXJlIHVzaW5nIFhlbm9tYWkgMy4xLjIgb24ga2VybmVsIDQuMTku
MjI5LCBpcGlwZSBwYXRjaCwgWDg2IENQVS4NCj5JdCBpcyBhIDY0LWJpdCBrZXJuZWwgY29tcGls
ZSwgYnV0IG91ciBSVCBhcHBsaWNhdGlvbnMgYXJlIGNvbXBpbGVkDQo+MzItYml0IHN1Y2ggdGhh
dCB0aGV5IHVzZSB0aGUgImNvbXBhdCIgbGF5ZXIuIFNpbmNlIGEgdmVyeSBsYXJnZQ0KPmFtb3Vu
dCBvZiBsZWdhY3kgY29kZSBpcyBub3cgcG9ydGVkIGFuZCBzdGFibGUgb24gWGVubyAzLjEuMiB3
ZSBjYW4ndA0KPnN3aXRjaCB0byBYZW5vIDMuMiAob3IgRG92ZXRhaWwpLg0KPg0KPkhlcmUgaXMg
YSBiYWNrdHJhY2Ugd2hlbiBydW5uaW5nIHRoZSBhcHBsaWNhdGlvbiBpbiBhIGRlYnVnZ2VyOg0K
Pg0KPlRocmVhZCA0ICJjb21tdW5pY2F0aW9uIiByZWNlaXZlZCBzaWduYWwgU0lHWENQVSwgQ1BV
IHRpbWUgbGltaXQgZXhjZWVkZWQuDQo+W1N3aXRjaGluZyB0byBUaHJlYWQgMHhmNzAzZWI0MCAo
TFdQIDQ2NDEpXQ0KPjB4ZjdmY2ViNjkgaW4gX19rZXJuZWxfdnN5c2NhbGwgKCkNCj4oZ2RiKSBi
dA0KPiMwICAweGY3ZmNlYjY5IGluIF9fa2VybmVsX3ZzeXNjYWxsICgpDQo+IzEgIDB4ZjdjZDQ5
N2EgaW4gZG9fcmVjdm1zZyAoKSBmcm9tIC91c3IveGVub21haS9saWIvbGliY29iYWx0LnNvLjIN
Cj4jMiAgMHhmN2NkNTIxNCBpbiBfX3dyYXBfcmVjdmZyb20gKCkgZnJvbSAvdXNyL3hlbm9tYWkv
bGliL2xpYmNvYmFsdC5zby4yDQo+IzMgIDB4MDgwNzk4ZTEgaW4gSVBDX3JlY2VpdmUgKCkgYXQg
YXBwbGljYXRpb24uYzoyMjYzNA0KPiM0ICAweDA4MDc5OWVlIGluIGNvbW1fdGFza19wcm9jIChh
cmc9MHgwKSBhdCBhcHBsaWNhdGlvbi5jOjIyNjk0DQo+IzUgIDB4ZjdkMDFmNGMgaW4gdGFza19l
bnRyeSAoKSBmcm9tIC91c3IveGVub21haS9saWIvbGliYWxjaGVteS5zby4wDQo+IzYgIDB4Zjdj
ZjE0MDUgaW4gdGhyZWFkX3RyYW1wb2xpbmUgKCkgZnJvbQ0KPi91c3IveGVub21haS9saWIvbGli
Y29wcGVycGxhdGUuc28uMA0KPiM3ICAweGY3Y2Q2ZDM1IGluIGNvYmFsdF90aHJlYWRfdHJhbXBv
bGluZSAoKSBmcm9tDQo+L3Vzci94ZW5vbWFpL2xpYi9saWJjb2JhbHQuc28uMg0KPiM4ICAweGY3
Y2E5ZTk5IGluIHN0YXJ0X3RocmVhZCAoKSBmcm9tIC9saWIvbGlicHRocmVhZC5zby4wDQo+Izkg
IDB4ZjdiZGJiNGEgaW4gY2xvbmUgKCkgZnJvbSAvbGliL2xpYmMuc28uNg0KPg0KPmluIGRtZXNn
Og0KPlsgMTA1Ny43ODk4NThdIFtYZW5vbWFpXSB3YXRjaGRvZyB0cmlnZ2VyZWQgb24gQ1BVICMw
IC0tIHJ1bmF3YXkNCj50aHJlYWQgJ2NvbW11bmljYXRpb24nIHNpZ25hbGVkDQo+DQo+VGhpcyBp
cyBob3cgd2UgaW5pdGlhbGl6ZSB0aGUgSUREUCBzb2NrZXQgaW4gb3VyIFJUIHVzZXJzcGFjZSBh
cHA6DQo+DQo+ICAgYXBwQV9zb2NrZXQgPSBzb2NrZXQoQUZfUlRJUEMsIFNPQ0tfREdSQU0sIElQ
Q1BST1RPX0lERFApOw0KPiAgIHNvY2tfcG9vbHN6ID0gMzI3Njg7DQo+ICAgcmV0ID0gc2V0c29j
a29wdChhcHBfc29hcHBBX3NvY2tldGNrZXQsIFNPTF9JRERQLCBJRERQX1BPT0xTWiwNCj4mc29j
a19wb29sc3osIHNpemVvZihzb2NrX3Bvb2xzeikpOw0KPiAgIGlmIChyZXQpDQo+ICAgICAgcmV0
dXJuIEZBSUxVUkU7DQo+DQo+ICAgdHYudHZfc2VjID0gMDsNCj4gICB0di50dl91c2VjID0gMTAw
MDsNCj4gICByZXQgPSBzZXRzb2Nrb3B0KGFwcEFfc29ja2V0LCBTT0xfU09DS0VULCBTT19SQ1ZU
SU1FTywgJnR2LCBzaXplb2YodHYpKTsNCj4gICBpZiAocmV0KQ0KPiAgICAgIHJldHVybiBGQUlM
VVJFOw0KPg0KPiAgIGFwcEFfYWRkci5zaXBjX2ZhbWlseSA9IEFGX1JUSVBDOw0KPiAgIGFwcEFf
YWRkci5zaXBjX3BvcnQgPSAxMzsNCj4gICByZXQgPSBiaW5kKGFwcEFfc29ja2V0LCAoc3RydWN0
IHNvY2thZGRyICopJmFwcEFfYWRkciwgc2l6ZW9mKGFwcEFfYWRkcikpOw0KPiAgIGlmIChyZXQp
DQo+ICAgICAgcmV0dXJuIEZBSUxVUkU7DQo+DQo+ICAgc3RyY3B5KHBsYWJlbC5sYWJlbCwgSURE
UF9TT0NLRVRfTEFCRUxfRUMpOw0KPiAgIHJldCA9IHNldHNvY2tvcHQoYXBwQV9zb2NrZXQsIFNP
TF9JRERQLCBJRERQX0xBQkVMLCAmcGxhYmVsLA0KPnNpemVvZihwbGFiZWwpKTsNCj4gICBpZiAo
cmV0KQ0KPiAgICAgIHJldHVybiBGQUlMVVJFOw0KPiAgIGFwcEJfYWRkci5zaXBjX2ZhbWlseSA9
IEFGX1JUSVBDOw0KPiAgIGFwcEJfYWRkci5zaXBjX3BvcnQgPSAxMjsNCj4NCj5UaGUgY2FsbCB0
byByZWN2ZnJvbToNCj4gICAgcmV0ID0gcmVjdmZyb20oYXBwQV9zb2NrZXQsICZidWYsDQo+ICAg
ICAgICAgICAgICAgICAgc3osIDAsIChzdHJ1Y3Qgc29ja2FkZHIgKikmYXBwQV9hZGRyLCAmYWRk
cmxlbikNCj4NCj5JbiBhYm91dCA4MCUgb2Ygb3VyIHRlc3RzIHRoZSBhcHBzIGNhbiBjb21tdW5p
Y2F0ZSB3aXRoIGVhY2ggb3RoZXIgZm9yDQo+YWJvdXQgMi0zIHNlY29uZHMgdW50aWwgQXBwQSBk
cm9wcyBpbnRvIHNlY29uZGFyeSBtb2RlIGFuZCB0aGUNCj5jb21tdW5pY2F0aW9uIHN0b3BzLg0K
Pkhvd2V2ZXIsIGEgZmV3IHRpbWVzIHdlIGhhdmUgc2VlbiB0aGUgYXBwcyBzdGF5IGluIGNvbW11
bmljYXRpb24gZm9yDQo+bWFueSBtaW51dGVzIGJlZm9yZSB3ZSBraWxsZWQgdGhlbSBub3JtYWxs
eS4gV2UgaGF2ZSB0cmllZCBjaGFuZ2luZw0KPnRoZSBjYWxsIHRvIHJlY3Zmcm9tIHRvIF9fUlQo
cmVjdmZyb20oKSkgYnV0IHRoZSByZXN1bHRzIHdlcmUgdGhlDQo+c2FtZS4NCj4NCj5UaGUgZ2Nj
IGNvbXBpbGUgY21kbGluZSBmb3IgdGhpcyBhcHAgd2hpY2ggZHJvcHMgdG8gc2Vjb25kYXJ5IG1v
ZGUgaXMNCj5hcyBmb2xsb3dzOg0KPmdjYyAtZzMgLW0zMiAtSS91c3IvaW5jbHVkZS9saWJ4bWwy
IC1JIlNPRU0vIiAtSSJTT0VNL29zYWwiDQo+LUkiU09FTS9vc2h3L2xpbnV4IiAtSSJTT0VNL3Nv
ZW0iIC1JIi4uL2luY2x1ZGUvbmFub3BiIg0KPi1JL3Vzci94ZW5vbWFpL2luY2x1ZGUvY29iYWx0
IC1JL3Vzci94ZW5vbWFpL2luY2x1ZGUgLW0zMg0KPi1EX0ZJTEVfT0ZGU0VUX0JJVFM9NjQgLURf
R05VX1NPVVJDRSAtRF9SRUVOVFJBTlQNCj4tZmFzeW5jaHJvbm91cy11bndpbmQtdGFibGVzIC1E
X19DT0JBTFRfXw0KPi1JL3Vzci94ZW5vbWFpL2luY2x1ZGUvYWxjaGVteSAtSS91c3IveGVub21h
aS9pbmNsdWRlL3J0ZG0gICAtWGxpbmtlcg0KPi1ycGF0aCAtWGxpbmtlciAvdXNyL3hlbm9tYWkv
bGliICBhcHBsaWNhdGlvbi5jDQo+Li4vaW5jbHVkZS9kaWFfZGV2X2FwcC5oIC4uL2luY2x1ZGUv
Y3JjX3RhYmxlLmggLi4vaW5jbHVkZS9kYWMuaA0KPi4uL2luY2x1ZGUvZGFjZGVmcy5oIC4uL2lu
Y2x1ZGUvYXBwX3ZlcnNpb24uaA0KPi4uL2luY2x1ZGUvY2Fub3Blbl9kcml2ZXMuaCAuLi9pbmNs
dWRlL2FkY2RlZnMuaA0KPi4uL2luY2x1ZGUvYXBwX3ZlcnNpb24uaCAuLi9pbmNsdWRlL2FkYy5o
IC4uL2luY2x1ZGUvYXBwLmgNCj4uLi9pbmNsdWRlL2Nhbm9kZWZzLmggLi4vaW5jbHVkZS9wcmVw
cm9jX2FwcC5oDQo+Li4vaW5jbHVkZS9hcHBfbWVtX21hbmFnZXJfZGF0YS5oIC4uL2luY2x1ZGUv
Y29tbV9kdGFfYXBwLmgNCj4uLi9pbmNsdWRlL2NvbXByb3RvLmggLi4vaW5jbHVkZS9xdWFkLmgg
Li4vbW9kdWxlcy9ydHN5bmMuaCBxdWFkLm8NCj5kYWMubyBhZGMubyBTT0VNL2xpYi9saW51eC9s
aWJvc2h3LmEgU09FTS9saWIvbGludXgvbGlib3NhbC5hDQo+U09FTS9saWIvbGludXgvbGlic29l
bS5hIC4uL2luY2x1ZGUvbmFub3BiL25hbm9wYi5hICAtbHhtbDIgLWx6IC1sbHptYQ0KPi1sbSAt
bGRsIC1MIlNPRU0vbGliL2xpbnV4IiAtV2wsLS1zdGFydC1ncm91cCAtbG9zaHcgLWxvc2FsIC1s
c29lbQ0KPi1XbCwtLWVuZC1ncm91cCAtbG0gLVdsLC0tbm8tYXMtbmVlZGVkDQo+LVdsLEAvdXNy
L3hlbm9tYWkvbGliL2NvYmFsdC53cmFwcGVycw0KPi1XbCxAL3Vzci94ZW5vbWFpL2xpYi9jb2Jh
bHQud3JhcHBlcnMNCj4tV2wsQC91c3IveGVub21haS9saWIvbW9kZWNoay53cmFwcGVycyAtbGFs
Y2hlbXkgLWxjb3BwZXJwbGF0ZQ0KPi91c3IveGVub21haS9saWIveGVub21haS9ib290c3RyYXAu
byAtV2wsLS13cmFwPW1haW4NCj4tV2wsLS1keW5hbWljLWxpc3Q9L3Vzci94ZW5vbWFpL2xpYi9k
eW5saXN0LmxkIC1ML3Vzci94ZW5vbWFpL2xpYg0KPi1sY29iYWx0IC1sbW9kZWNoayAtbHB0aHJl
YWQgLWxydCAtbTMyIC1vIGFwcA0KDQo=
