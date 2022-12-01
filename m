Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26E5A28
	for <xenomai@lists.linux.dev>; Thu,  1 Dec 2022 01:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669859776; x=1701395776;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=qoNNGJq9dehv2bl5l1Az9mLJVJnLRPExDEffRBNh35Q=;
  b=MpX4LjMJ4shL3HHdL1giF2RcKIKcwF/OX0UOsPqbHwM6Wk52fUJiXSKm
   IrNrQP/izaoaOMgDOO04bW/+k5NWOPdk+7dGiC6zg1KNwbZ9+MKgBu1Iw
   ndCuoeqbhQwOh5FJD1ADufajEdFK9Glu2PfTueqPdes/73+ftYVUyQr/H
   HxoTEpCjJLD4ue/vNX1Lvv46YUsI4mek+/F2d9IqFHGRjom/l12SvKhWI
   aIpiGaRcAUgqcgqcQre4/wPw6/6YkGW5BjRb4WSVnq6ncIYNB4vPDt1JL
   DtlmB0CaZllimhz1HAv9Iw/Sl8HAkWHaQ4IqXhb9JAaV9Yt+4YXs4cwLD
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="316715027"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="316715027"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 17:56:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="769053274"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="769053274"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 30 Nov 2022 17:56:16 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 30 Nov 2022 17:56:15 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 30 Nov 2022 17:56:15 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 30 Nov 2022 17:56:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVWSZedgCPVna+oGcO2m1wXF3ulYu5NP7LDfR76C/s5/xYTjnMbtSf1dIxL4v6TBReDqfBRDl7xzQEUp/HI3GdEMaBKj79m3IqAEyHxh6faX7N9fMjU1CQIyJBr+osxSSCchkFcH9zvADC5fQF9pOgn5x0vbdjsK6Ik6hWee5MkIMBKkOH0f88aXanqGxsOKjDmKaRWIZS0zeT2pRyDSOxcWo35oAWBkyuLBM5ogcCJI2Vx5ym2X2gG8PweQoBTRNsV/jpGIegg5NPkkYwOPtYkx0zozufmvcHD2GD9NXjmmAlCRlEsHRGuB8t/SoyQgNa+llEkCSDK2nhGAiuwb/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qoNNGJq9dehv2bl5l1Az9mLJVJnLRPExDEffRBNh35Q=;
 b=I4sTmUiXzfeNZJZvX6McIIIMgw8TG/c7XjWudnG2Vhgcyd0NqFt3o16MrsUGuNhar1d1rAeNeWOCdjJeISmzy6wmffHcrDpR4ps2x6ZyWJVwDcxQ1/AW14k5cVJkk/SYqBjXqrB/gKrTI71mEy526KEkGF3ZEfikdvqz97aI9nzBOhABTRyXpDtdr6/4qoDZN80eKIzIUGJc6R5+grEgRltrOwcVtdoO4sR8MB0KWv7r2kNNZ7D82Hex/LdP/utvPn/ys8ouwYhOHodfYP90XAAs/hfKlhyRtxOrwZVXpRliLxa8/4AMi2178BrmRs5iQugyZcY88iDt4vIcUG88ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by DS0PR11MB7629.namprd11.prod.outlook.com (2603:10b6:8:146::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Thu, 1 Dec
 2022 01:56:13 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::27cc:d8ed:9947:fecb]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::27cc:d8ed:9947:fecb%7]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 01:56:13 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Xenomai Community Call Minutes - Nov 30, 2022
Thread-Topic: Xenomai Community Call Minutes - Nov 30, 2022
Thread-Index: AdkFKAhqNOvls3pDRqWc4nqAWnxaEg==
Date: Thu, 1 Dec 2022 01:56:13 +0000
Message-ID: <MN2PR11MB42855CF4ADD545D7097A6D8CF2149@MN2PR11MB4285.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|DS0PR11MB7629:EE_
x-ms-office365-filtering-correlation-id: 5328650a-9ca6-4034-a083-08dad33f39c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JHyg+b1OSrRhJqwf4Ty+pVG2kSRgjS1DoXBByVMPqWetBK0LkkDwKkYtZ9Mo0TSDOAO7vE1g1c8iMRCTS/+BMUFfs2Q07h16Q1IaliIToXLThR4gwlWw3a0vt6OJjEuejoBLrNfpxH10ueR5IpA3Z/Uuzxf7sHLRTFO65JshepG94SjglAIdbdjMuOR70C1o9bMwvCls/gJkuzG1nuGhKzja2SqceXmHlXqUonUw+yARlB34hYUjYzRXMrb5aeSzvGa0iYpn+Uw44ss78vCVLtM8QQzLaH/9WNzNao4WYGjoRGV8csfpbjV/k1S+R2V1cAmcq+j2G38vmu/lgWoN40ioMjNUoqyOA0Ctv8O5lXox7OK+xTlxxSzVhpE5FTNOu1n6WQH1JjpkbLVdlAYpnIbkF3E4n10o5Etxzp3q7KqkJLWul7D2cIfTLwwiL676VWQUwB/+lbypiatLyKWFZ2IYY0k1bcM7VlfwYkhcYMGY90hu8pR+fBaXfYnimGSKMehu+Fklr1u4SQUCwz5RBHf3Rr4G6p3hBPdcadSnrbUnsvASxXhg3Z5H/NcVtpjPyF6J6fqSnCa2GsidC0PdAFPnrjMeCcd/TX6DoNI/w2LZ6YWAP3Tz6lLrI91gBK44t3XVFSybxUYLwDK1NveT+TXyC6i4t6nRKjJgkh009/r/B+YLDkhbkcRwfBWIi+NRetjYeG7QIEQA3NxOqgwNwA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199015)(186003)(6916009)(316002)(478600001)(82960400001)(55016003)(38070700005)(33656002)(86362001)(122000001)(83380400001)(38100700002)(9686003)(7696005)(6506007)(26005)(4744005)(8936002)(2906002)(41300700001)(71200400001)(52536014)(8676002)(64756008)(66946007)(66556008)(66476007)(66446008)(76116006)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGVqWHF3K0J4bDErS1JzWUVna29XMG83WFQ4Uk9sRzFsOUpkeTUweHVqYXdP?=
 =?utf-8?B?SFhtYUowZzVJeHNlVlJOSFo3SkkrN09aNUNnZGxYZlJ3SkhEV0dZWmdieDEw?=
 =?utf-8?B?MmplU0xUUG4vczFpalpGM09FQ3E0Z0xiWGd4aVhmNjVHOUt0dEdzZ2hWaUF3?=
 =?utf-8?B?MDRBMVZXU2JFYk5lc1FrYWZmM2NlYkRtbmp3Ukt4OGJmNVdUTlVheDhVb0s4?=
 =?utf-8?B?eFU1OEJiVE1oVmpvVFk1WCtFMHRDUFVvWnFYTDFkb1IxZFJLVVR3Y2E0Rll0?=
 =?utf-8?B?L09ha3BYalQzWTJpcUkwRVhqVU5EMHQ3NnBKZU5RQXRrS2RVa2w1RHFaUjBQ?=
 =?utf-8?B?cHgrRVk3QVBDSEk4QmZEdTlFakF4NlBoY2dZUW80eTNGUUZmT1hhKzRLRkJx?=
 =?utf-8?B?YUdHV0d1cFAzK2xUa005TEZiTkNJRUJGbWVUK1JtbDFEZjhGN0RZcmI3ckpn?=
 =?utf-8?B?K1J3NGJtRHM5aVdWdmg4S05mYkNaUXJtV2YwN2gvSTRnanlUckc0NU13ajBW?=
 =?utf-8?B?YkFjNWNNZFZvNEdxNEJNYWpPR0c5dEdiWWNheWwzWCtkaXhFQWVsS2VBSHZF?=
 =?utf-8?B?Tkp5cVV3REhYTnNvMEtQYk5jRFg4cGNsTEVSMDhEaEN5a3Y1MjBFVmNGckRX?=
 =?utf-8?B?eEtFUjZ1TytqQmxLM01SODl1KzV6NENrS09TT1VyTXg5N1V5OEpHMTRqZU5M?=
 =?utf-8?B?eUpyNyszWXpmMm15Uy8wOW5ENENyVnZnWUE2WFRXVGNkdzZZbTJ1QVZ1dTRL?=
 =?utf-8?B?Mnl5SjVzeDZvSHp5Z1d1ZXprKzlSUFpqb3lqQTQ1Z0k1VTNWUUZxeHRSTzNF?=
 =?utf-8?B?WlhiaTBGMjI2WVRNZzBwRnU0aFFKNGRJVWZteStKUnB3Vy90OFloQU8zejZP?=
 =?utf-8?B?ajR1UzVwYU11cjB5ZzNrMkF2eVRJcHJRMlJsWWJrUXFVVjVzdERxN3NiOXZv?=
 =?utf-8?B?ZkpUS3lrZS92U2JqZDBVVVBrNVU4b3ViTFMxWng1N21aZVRYWDBVNVpBNmJM?=
 =?utf-8?B?elkyQVYxdzZWTldoalFrSWFlNHFnd1cwbEZScHZrb0U5THM1cDJ6c1NBUXc4?=
 =?utf-8?B?Tm1oWUZ0N3J5eWxDWkNjNE9USHcwY1pkRmU3ZUwyaktyL2loVFJwcUQ5ai9K?=
 =?utf-8?B?YmpRKzgrYk9lRFhDNlpJM2ErTnlYa0ttTGZmWXV6SVBNWGtxMGNteXdMTHdR?=
 =?utf-8?B?bklpOGpkMStUNnNQMktxbG5kT2JRdWJTMER6dUhxUlRyY1EzbUhWRWpmeGV4?=
 =?utf-8?B?Y2gzQTYySnNJQTRNVkpNbGU2TGI3eVFpelJXbytVOWN3MnQzaVJKeDNxcTJI?=
 =?utf-8?B?OGxEbGhzU3ZlT1JyOXMzTyttdzlTNitySXY1UUFyVG9uVlAwcGUzMGN5TW5G?=
 =?utf-8?B?b3Vna3lwQVAvR1ltdUgrU0piODZmbUxGWlA0MjRpeTNCa3paTWphT1hJUHln?=
 =?utf-8?B?Q1VhanJ1S0dlTEpyRjEzdDZ1RkY5TnhPaFZuL2dCT1JORHhoZHpHMUg4WDRJ?=
 =?utf-8?B?aDNWUDczaUJnTktDUUtSZWVaemRzVWlIVUE3cCtJRlEwOVVXNlRsejdaczE0?=
 =?utf-8?B?M2J0TVdtNnkxYW5jNzc5VmE5OVJOckMvMFNSNCs1emN0bnBVYm1DMCtERy9I?=
 =?utf-8?B?NUdicjNwcTdVVlM3QjE1RStKSVpibmpBQ0RZN3RUb2hyR1k1SDU4dzdmUm5L?=
 =?utf-8?B?WG1IYXo4REVkZGJpZXVKMGE2WXl0dm9scnQ4clVpWnlCdzBqRzFBdmZXSzFO?=
 =?utf-8?B?WFFQQisyajdZbzJZOEFKY1V5ZWJWOFE4MnowUHVuTjdLUi9HMmx4c3ZpT0tI?=
 =?utf-8?B?OVhjSE1DZC9tNmNha1g4MzlieHRxTTQvcVJTRjg0SExZelZaRnNVZi8vOHQy?=
 =?utf-8?B?aDJhdXVaSGRWSnlDZWJqUEFLTDdUMWNKQ0RoVFZnVTRrZTB1bWFwOE5FbWlM?=
 =?utf-8?B?MmV0SFZMRnI5Z1F4RHRrQkMzdm53WEJYelVkRWNhS29ER0NsV25LYzNNLzJx?=
 =?utf-8?B?djljcVJUWDdKZkF2STFBY0R4em5tWnd2T25rN2FMNEM2SGdJaG5xdG9oeTdV?=
 =?utf-8?B?VXJNNW45MFZ2V09wOUJ0Wm5jdjIxbXNlR3BuTnRoNHFyYzlSdGlNeCs1Tm5J?=
 =?utf-8?Q?lBwGNqXtXhh8GFk5kQ1AfHt2G?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5328650a-9ca6-4034-a083-08dad33f39c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2022 01:56:13.1949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yz1sWNP2h+zw+HtYh0o0Y4SrpqgN7FmekGEzEfAJOv6IIHN9dFsXFqF26JLuQDDNvENDnj/cubN1VFeUa7+7Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7629
X-OriginatorOrg: intel.com

QXR0ZW5kZWVzOiBKYW4gS2lzemthLCBSaWNrIFdhbmcsIEZsb3JpYW4gQmV6ZGVrYSwgU3RldmUg
Um9zZW5ibHV0aCwgUmljaGFyZCBXZWluYmVyZ2VyLCBQaXJvdSBGbG9yZW50LCBRaWFuZyBaaGFu
ZywgSG9uZ3poYW4gQ2hlbg0KDQoqQ29tbXVuaXR5IHVwZGF0ZToNCglHaXRsYWIgQ0kgbWlncmF0
aW9uIC0tIGRvbmUNCglJLXBpcGUgaW50ZXJydXB0IHN0b3JtIGlzc3VlIC0tIG9uZ29pbmcNCgkJ
aGF2ZSBub3QgYmVlbiBmb3VuZCBvbiBYODYNCglpcGlwZS1jb3JlLTUuNC4yMjMteDg2LTExIHJl
bGVhc2UgLS0gZG9uZQ0KCUVWTCBpc3N1ZXMgc3VwcG9ydCBieSBQaGlsaXBwZSAtLSBvbmdvaW5n
DQoJDQpPcGVuIGRpc2N1c3Npb246DQoJTWlncmF0aW9uIHRvIFhlbm9tYWkgNDoNCgkJLS0gRm9y
IHVzZXJzIHdobyB3YW50IHRvIGRldmVsb3AgYXBwIHN0YXJ0IGZyb20gYmxhbmssIG1heSBkaXJl
Y3RseSB1c2UgRVZMLg0KCQktLSBOZWVkIG1vcmUgZmVlZGJhY2sgZnJvbSB1c2VycyB3aG8gd2Fu
dCB0byBtaWdyYXRlIHhlbm9tYWkgMiBvciB4ZW5vbWFpIDMgdG8geGVub21haSA0Lg0KDQpSZWdh
cmRzDQoNCkhvbmd6aGFuIENoZW4NCg==
