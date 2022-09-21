Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D081876
	for <xenomai@lists.linux.dev>; Wed, 21 Sep 2022 06:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663740367; x=1695276367;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BBbh5svMHxucfCeA1ICSWsRXUZsTu7wziCo9BiQ+N2A=;
  b=gnEsh9vzWOMjc8Q2WjAxHaSM/eUTUWfE1GuVrOGFDxkVTtf/yZfccKCu
   IGvo/MMqhy/46cr46twcNrB/x9rfKChg+wtUVf7zLz+l30Kdc5z3gyb+Y
   W3LaJ/o28DTJvTvTXq8OrrN/5niZKfGaRspB1sgdYhN8vI27ilTquzaiW
   +Mh62XLzAg2ySk8WJHHEr2E+dwM0TITTnP4HjdcEI/4JnbE8xhuXPJald
   Ty5ITpbJU3+d9yj6PLXa0xCq1WVa/vaO/shEANXUv87pHy8BkbPDaNDHU
   DDiGnUvO32CycPINUsI8w8B9mukaRuPuOcFXpLyLGjJD2aT4dNdc7x5iO
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="280284704"
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="280284704"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 23:06:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="794549244"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 20 Sep 2022 23:06:06 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 23:06:06 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 23:06:05 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 20 Sep 2022 23:06:05 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 20 Sep 2022 23:06:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMdE7DTpQxTIHJAOhvsRE/w5vbHoIHlPGUCFVfpdY2jDKCRm3/xOTU0LyFg4peNsFCO/Gn3fh9qAC+HAR9mXLkkgV61g5w3viWhL62jUL455Vl5zJXM+Z3eUqeE0Q4kayj+6zObN8ho/eyfK9Robl+X3NVpfnaZGf6KnoAwcUzMvZb3Yob+7XxaqDDQbN+3sZ9AIsYChePURbHSGPzYa3TF7lhRBgQpkvtp680oGjAA3qgqHVKGac/ICXlOxx6xc9dDDFAo0JjbFr6JvG4oe6Zg5Lmh6TaW2gyr3AaAsTDhxOSqoLr4/dz1qWPxQk/DbAI4HiBzWbr+grPHf6y8h8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBbh5svMHxucfCeA1ICSWsRXUZsTu7wziCo9BiQ+N2A=;
 b=aYTPGBY10nMEAWljwW4EAbmM3yBA7I7oQljBBtceCVpO5bk3ReY3bw7HZqQ3jHAKDQZECY254QxQdX2dwjygq55XTuj8WQI3jWKPppyWHAZG2CVyY9AsGUsO350PBklFfWkfUQycaU3CbyhKsFr1XSdeQlyzhKSrpvxQI0mXPRvNo2dwZvnn9YD4aewaK9brd1b9Qr5OcGDehJCtPva8lkFSNU7tTu0orurkeroC9ljPi5wQ1p32DfBCfO3dR/+N57CoY+T6Z55PVtKzrsVDodKn35w0s7J8nU8WzyL9Gkb1/mDx5bkQreBBJ4tvc8RLEjZQej1mbgubYD1M+Brq6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by DS0PR11MB7360.namprd11.prod.outlook.com (2603:10b6:8:136::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Wed, 21 Sep
 2022 06:06:03 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::d461:9280:aab7:e2f5]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::d461:9280:aab7:e2f5%7]) with mapi id 15.20.5654.014; Wed, 21 Sep 2022
 06:06:03 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: Emmanuel Pacaud <emmanuel.pacaud@lapp.in2p3.fr>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: How to debug realtime interrupt latency
Thread-Topic: How to debug realtime interrupt latency
Thread-Index: AQHYzAv4CNLljF6+OES35pLMXLUCVK3pJGjAgAA5xgCAAAO9kA==
Date: Wed, 21 Sep 2022 06:06:03 +0000
Message-ID: <MN2PR11MB4285D42BBAAAC59B3A4A0869F24F9@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <4WAGIR.N142QYZSDNER1@lapp.in2p3.fr>
	<MN2PR11MB42854F88BC212E32EA6D6885F24F9@MN2PR11MB4285.namprd11.prod.outlook.com>
 <CLOJIR.XNBWNAXO5BVE@lapp.in2p3.fr>
In-Reply-To: <CLOJIR.XNBWNAXO5BVE@lapp.in2p3.fr>
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
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|DS0PR11MB7360:EE_
x-ms-office365-filtering-correlation-id: 83ac5b0d-3977-4c4b-7d7e-08da9b975d8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RS44E0ylQGgeoz2CVFz7zHBFNsL2ipeohXo3Qp3tck9ye85OwsYcfpxhWI/BmjfoUIxyOdSeHc7du9puZlZDt7YZJjTOBOHYR56WJYHwREd6f8/8q7g5pAVt6BjTo7kRcNdZLrdz23AHFtrhtmxWhNzbh99ju6/tifJQBke0Y8KhfMQ76DQKmRvD0qkjycX5kZsO4eKhhLgSXoF89IvhxKJYNpexGCCVY1ee8NqCsab8jH/X962LekjT7YTpi0uU76QMQHzGSD8o0b8m+hBAfySz1Y3EWGfmUktxebvfZ7qhUD+WD5MvZ91M15yE91ZSes0LJSCf6Tq0J3sXzwcIfss9siRz72VFL+iIB5Dw/tPcVs6hE5+rbpjw4uGtLRJAOqsit6k4cJ4DdkRcdUYLePuikQDPm8mhaEufHLhZ6g4DAGlYIjuIoS7PdWld11gvxvTopHb+p5frBaHiBfrmUdu35GiDdidKffYaq0GwKcIIU3yV5Ea08Rq6Tp/AFjvAkxfG/X46YXT80O4CkDvPBhQ5V4kbW2Je6l9WRTfeG+Ez15zwqKm7YgWKzqxBUGEaAlqYJJ+Fy2ZFfYqw+D1UXZLaIfatexmCQLYLBntW/++JXKXoQWhA9z681LqaW9yh/nC333Au1MIgpNIPP7lX/+q8/6im/QNYjDzQykR83l3tKZw8SB3m2XZ+m9TS83EwuFiRrl2sSZTkJFZmCLzbKOE2BqO26m+WZG3X0OUY/Qt8HVaPJLDr8/2ZdP6fBxk3OYiYc+BL4UuWXzfr18QfhFMPzv77SRdq1ZNcCinXDes=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(366004)(346002)(396003)(376002)(451199015)(52536014)(2906002)(5660300002)(66946007)(66476007)(66556008)(64756008)(66446008)(8936002)(4326008)(76116006)(8676002)(316002)(33656002)(38100700002)(122000001)(41300700001)(55016003)(86362001)(82960400001)(478600001)(6506007)(9686003)(26005)(7696005)(6916009)(71200400001)(38070700005)(186003)(83380400001)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUZBVjBrZGR2ZlZqRk5pU3gwVXdES293d0s4OXdidW5CaTlZclcxOTdRYllP?=
 =?utf-8?B?RGRZREFWczEyR1RiYjZXTlpvaVdVVXYrZ0NPMGdRZENyRjgwQzgyaHk1WlFD?=
 =?utf-8?B?aFAwK1pWczh2eUdMTjNZRjQwVFNtMmlWbHlpZHZJOFNwRThWN1N6Qk94dGlJ?=
 =?utf-8?B?V1k2a2l0ajJ3alM4N3RhNTgvcmVUZ0VISDBzb0IyQTc5WGR6VjVYV2xGR0Ny?=
 =?utf-8?B?eDNYeldtaFNjL1hicHBOYlZpWkFYSFE4MVJMUy9WdjVnZmZrNExqdlNHUWNL?=
 =?utf-8?B?U2pZdzB0UEh1ZXd5NzN0Mjg2OXRtN2dFMWpYQTVsWWdtaDcwMUdBa1IvYWhN?=
 =?utf-8?B?R0FiajJSUmdDTVR0b2VmaWFkWmpZM0ROa2ViR0Zpc0xHSjREbU9GcnFYcHEx?=
 =?utf-8?B?WFJvWXRoU0QrRlVEWjVvMG9NamV5UHEvTjdGc3pqYTRqQ0hJRjM0eHlub3Js?=
 =?utf-8?B?NTZydHBCbG1LaU8yZkY3RTV2Kys1czRmdDB2QnBBZkdFRjFLQ0xHaWRMTmVO?=
 =?utf-8?B?SnlIN0cxckdEbG1LZlRObDd0ZC8wbDNTa2xvRmhHL2dycU5kNnErT2VIYS93?=
 =?utf-8?B?bWYrWmhHSUYvdjk2NGM1YklLOW1lcWxOL083Yzl5M0JzNytVQWlWQVdpdGpC?=
 =?utf-8?B?YTMrRGY5QmJNRitmalBmZlJGaW52UzJDWDBJZUt1WXlQdW00anJNdG9IZXRB?=
 =?utf-8?B?R0M0UVRhejl3RXlKd1g1S2ZJK2p1eEE2UGVlNU0zTHljM3MrZkozOGZnQ0Vv?=
 =?utf-8?B?N2ROYTJBcWpKWVNLZll6NjVSSUJQQlhJTHVXZ09SU3dJK0dmdGV3T0xlOFVD?=
 =?utf-8?B?bnhMamJyaUlmTjVsdVN3MFA3ZlhuK0krMng4NDZtaHVJQUFtWHJDYzJxZHhZ?=
 =?utf-8?B?VEg1eXlwNEl1VXljMWhicUJRT29ibEZ6cWJkTWVyRGErOVBYT01xajlxTk02?=
 =?utf-8?B?WkdwSXdiaURtVDJCRHJ3MkMwYXBKTi9HOVBGd3BLcFR3OVRRcHE2bXB6R1RY?=
 =?utf-8?B?aG1jb1RoSGhEek4vcWxOTnYwZ1BnVERlS3lMNktVaXB2Qkgzb2RyOEFIanBx?=
 =?utf-8?B?OVFpTFRzVUdQMkpiZ1kvUTgxK1ZERndZN1E1aU0wRmI4UkpMV05uNk83NWJH?=
 =?utf-8?B?YmtaODdyN2ZPendkWC9wbkFCS3hWbnBBQXBNNDlZeis4WHJXS2hNTW40bUZJ?=
 =?utf-8?B?dkpGT2dCMjVOa0IwVTkrdWw2Nno1SFUwd1hXa21MTUh1MWo2T0EyWVhrUVNP?=
 =?utf-8?B?N2pHSC9HYmRxQVpVZUJsd2t2eVl5OXBpWlN2TFhYOHRBL2lqc3RZcWlLR01V?=
 =?utf-8?B?bWNQQXVTUkJucmMzckZwQTIwemdPemVCdkFjU3pMMXlja2gvdk9tQkNkSXBl?=
 =?utf-8?B?bEFIbzhISmRyS2JUM2JBelZnZjRibCt5KzNxaGxEQ1l4UVB5dUFzV0doV3Zt?=
 =?utf-8?B?UkRCSXdFV0FiZTN2dnI1cVh5aHdkckNrbnZ5VHRaN0wxeENHUFNYVXVhb0x4?=
 =?utf-8?B?MC9yYVd0UDN2ZGZsVFBHNjF1SFpzU2twTENndXF6MkZBSjlPSm5LWWl2bk1J?=
 =?utf-8?B?U0txMDJEeFZKcCtieGtsOS8rL3hNejVlZTZEK2tQRlhUZW1jOEpZZnQ0WnM1?=
 =?utf-8?B?dHQ5MVAycWtreEZKUGNlVWFLVUhnUDJic3FXV0VXaGU1MnQveTdkYjR3Wlo0?=
 =?utf-8?B?UEdPSUpjSDd2a3NNa3laM2ZEZXF5SmFFT3l1VGJWQWRWNVpIZVNSLzBOVmRr?=
 =?utf-8?B?a3UzZk9YMEM2M0RNTHhiZWRXU2JicmwxWHBhWWZrRkVrbytZQksrNTROZW1X?=
 =?utf-8?B?UFRSVGgwYWtWT3NTWXdSdkdlaVJ3Q3MvaDhWbWNFZTJRaWEyK29CRVlyZW1r?=
 =?utf-8?B?TmYwN1dGVVpnOEFNMmJKaHRPZmVVV3F1cXlXMllTQ2N3dHhvTWl1b2FUbGdD?=
 =?utf-8?B?eG1yOW1oS21XbjcrN0NkWkYyaVlhcXZGalVUZGRpZnc5Y0pkdVZsNTJjamdK?=
 =?utf-8?B?M1NGSmxlOVJZU1llNkNJcmVoZ2cwNzExSVcvbnVoQkE0Ymh2MUN1QTJaczlW?=
 =?utf-8?B?QURLemtmNDZQVDdSZHhyYlFLbVV3c2t3NitIR1NSWE1lUzZ6OTllQ3E4RXJB?=
 =?utf-8?Q?vN1rdttTS+pn5CVUeT9mUTSN3?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ac5b0d-3977-4c4b-7d7e-08da9b975d8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2022 06:06:03.7823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2r1LTdojbMjmb6iE+eCkyMConu0a9xOp7e1Kx1kwgJX12sso5zRoQ1srV2csFcOICEesjuqsCQvWVbZZN/0msw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7360
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVtbWFudWVsIFBhY2F1ZCA8
ZW1tYW51ZWwucGFjYXVkQGxhcHAuaW4ycDMuZnI+DQo+U2VudDogV2VkbmVzZGF5LCBTZXB0ZW1i
ZXIgMjEsIDIwMjIgMTozMCBQTQ0KPlRvOiBDaGVuLCBIb25nemhhbiA8aG9uZ3poYW4uY2hlbkBp
bnRlbC5jb20+DQo+Q2M6IHhlbm9tYWlAbGlzdHMubGludXguZGV2DQo+U3ViamVjdDogUkU6IEhv
dyB0byBkZWJ1ZyByZWFsdGltZSBpbnRlcnJ1cHQgbGF0ZW5jeQ0KPg0KPkhpLA0KPg0KPlRoYW5r
cyBmb3IgeW91ciBhbnN3ZXIuDQo+DQo+TGUgbWVyLiwgc2VwdC4gMjEgMjAyMiBhdCAwMjoyMjo1
MiArMDAwMCwgIkNoZW4sIEhvbmd6aGFuIg0KPjxob25nemhhbi5jaGVuQGludGVsLmNvbT4gYSDD
qWNyaXQgOg0KPj4+IFdoYXQgd291bGQgZXhwbGFpbiB0aGUgbGF0ZW5jeSBkaXN0cmlidXRpb24g
b24gdGhlIERFTEwgUjYzMCArDQo+Pj4gWGVub21haQ0KPj4+IGNvbXBhcmVkIHRvIFJUQUkgb24g
dGhlIHNhbWUgbWFjaGluZSwgb3IgdG8gaXRzZWxmIG9uIHRoZSBvdGhlcg0KPj4+IG1hY2hpbmUN
Cj4+PiA/DQo+Pg0KPj4gSXMgdGhhdCBwb3NzaWJsZSB0aGF0IHNvbWUgaW50ZXJydXB0cyBoYXZl
IG5vdCBiZWVuIHRyaWdnZXJlZCBhcw0KPj4gZXhwZWN0ZWQ/DQo+DQo+SSBndWVzcyBpdCBpcyBz
b21ldGhpbmcgSSBoYXZlIHRvIGNoZWNrLCBidXQgaXQgaXMgdmVyeSB1bmxpa2VseS4gV2UNCj5h
cmUgdmVyeSBjb25maWRlbnQgaW4gdGhlIFBDSWUgYm9hcmRzIHdlIGFyZSB1c2luZyBmb3IgdGVu
IHllYXJzIG5vdy4NCj4+IFlvdSBtYXkgZW5hYmxlDQo+PiAvc3lzL2tlcm5lbC9kZWJ1Zy90cmFj
aW5nL2V2ZW50cy9jb2JhbHRfY29yZS9jb2JhbHRfaXJxX2VudHJ5DQo+PiAmIGNvYmFsdF9pcnFf
ZXhpdCBldmVudHMgdG8gZGVidWcgc3VjaCBpc3N1ZS4NCj4NCj5PaywgdGhhbmtzLiBJJ2xsIGdp
dmUgdCBhIHRyeS4NCj4NCj4+PiBEb2VzIFhlbm9tYWkgcGVyZm9ybSBzb21lIG90aGVyIHRhc2tz
IGJlZm9yZSB0aGUgcmVhbCB0aW1lIGludGVycnVwdA0KPj4+IGhhbmRsZXIgaXMgY2FsbGVkID8N
Cj4+DQo+PiBJIGRvIG5vdCB0aGluayB0aGVyZSBpcyBvdGhlciB0YXNrcyBjYW4gY2F1c2Ugc3Vj
aCAxMHVzICtkZWxheSBiZWZvcmUNCj4+IHhlbm9tYWkgcmVhbCB0aW1lIGludGVycnVwdA0KPj4g
aGFuZGxlciBvbiB5b3VyIHBsYXRmb3JtIHVubGVzcyBvdGhlciByZWFsIHRpbWUgaW50ZXJydXB0
IGhhbmRsZXINCj4+IG9jY3VweSBjcHUgd2l0aCBpcnEgb2ZmLg0KPg0KPkkgaGF2ZSBvbmx5IGlu
c3RhbGxlZCBvbmUgcmVhbCB0aW1lIGludGVycnVwdCwgYnV0IG15IHVuZGVyc3RhbmRpbmcgaXMN
Cj5YZW5vbWFpIGhhcyBpdHMgb3duIHRpbWVyIHJlbGF0ZWQgdGltZXIgaW50ZXJydXB0cy4NCj4N
Cj5gYGANCj5wYWNhdWQgb24geHh4IGluIH4g4p2vIGNhdCAvcHJvYy94ZW5vbWFpL2lycQ0KPiAg
SVJRICAgICAgICAgQ1BVMCAgICAgICAgQ1BVMSAgICAgICAgQ1BVMiAgICAgICAgQ1BVMw0KPiAg
IDY5OiAgICAgICAgICAgMCAgNjU0MTk1NTU2MSAgICAgICAgICAgMCAgICAgICAgICAgMCAgICAg
ICAgIHRvbG0NCj4gNDM1MjogICAgICAgICAgIDAgICAgICAgICAgIDAgICAgICAgICAgIDAgICAg
ICAgICAgIDAgICAgICAgICBbc3luY10NCj4gNDM1MzogICAgICAgICAgIDAgICAgICAgICAgIDEg
ICAgICAgICAgIDEgICAgICAgICAgIDENCj5bcmVzY2hlZHVsZV0NCj4gNDM1NDogICAgICAgICAg
IDAgICAgICAgICAgIDEgICAgICAgICAgIDEgICAgICAgICAgIDENCj5bdGltZXItaXBpXQ0KPiA0
MzU1OiAgIDYxNjE5NzE0MCAgICAgNjc2MjkwMiAgICAgNjkxNTM4MCAgICAgNjkxNTIyNCAgICAg
ICAgIFt0aW1lci8wXQ0KPiA0NDE5OiAgICAgICAgICAgMCAgICAgICAgICAgMCAgICAgICAgICAg
MCAgICAgICAgICAgMCAgICAgICAgIFt2aXJ0dWFsXQ0KPmBgYA0KPg0KPkFyZSB0aGVzZSBpbnRl
cnJ1cHRzIHN1cHBvc2VkIHRvIGJlIGNvbnN0YW50IHRpbWUgPw0KDQpJdCBpcyBub3QgY29uc3Rh
bnQgdGltZSBidXQgaGF2ZSBsaXR0bGUgaml0dGVyLiBYZW5vbWFpIHRpbWVyIGludGVycnVwdCBo
YW5kbGVyIHdvdWxkIG5vdCBjYXVzZSBzdWNoIDEwdXMrIGxhcmdlIA0KZGVsYXkgcGVyIG15IHVu
ZGVyc3RhbmRpbmcuIFlvdSBjYW4gdHJ5IGxhdGVuY3kgdGVzdCBjYXNlIHdoaWNoIFhlbm9tYWkg
cHJvamVjdCBpdHNlbGYgaGF2ZSgvdXNyL2xpYi94ZW5vbWFpL3Rlc3RzdWl0ZS9sYXRlbmN5LGRl
cGVuZGluZyBvbiB5b3VyIGluc3RhbGxpbmcpIA0Kb24geW91ciBwbGF0Zm9ybSB0byBjaGVjayBs
YXRlbmN5IHZhbHVlIHdoaWNoIGluY2x1ZGVzIHRpbWVyIGludGVycnVwdCBoYW5kbGUgbGF0ZW5j
eSBhbmQgWGVub21haSBzY2hlZHVsZSBsYXRlbmN5Lg0KDQpSZWdhcmRzDQoNCkhvbmd6aGFuIENo
ZW4NCj4NCj5DaGVlcnMsDQo+DQo+CUVtbWFudWVsLg0KPg0KDQo=
