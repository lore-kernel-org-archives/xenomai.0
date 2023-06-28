Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD43833D7
	for <xenomai@lists.linux.dev>; Wed, 28 Jun 2023 05:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687931258; x=1719467258;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=CE4Z02Y150Clc4SGL1kI+AGGH14vF26nkGZGpum6cVE=;
  b=B1M4v9IXYaA/XaeDgdPbc7/hm2F6DgcKViYIv/HJPCpnqROFs2utyrlT
   Cgw8Z+Hyc8aX4LTkRSuyPj0K0S5LweXM6ePh35bHc8jTz6AWmVXH72gh2
   AHfjx/byosXc2Mve2u1S7RMcTStdxyM+oLT/1nWm6Qu6yvmPIr6dotRFj
   sjq5lsUrbd2oQXuddsH8PaYpgrWocxLdxAR26GFbF0757WskXtocz7arS
   3/liGnAXAQAbVrp8U5wCt+Uwn5Mt9f6hl1kYFWfUXNmUMsMi9HOvASqDA
   /q7iv1E/9H2AnJJCRY35QuULC+9sGrk+zOzxz6iNpYBHQC3hTaGqrrB7j
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="361798249"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="361798249"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 22:47:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="829945157"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="829945157"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 27 Jun 2023 22:47:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 22:47:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 22:47:36 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 27 Jun 2023 22:47:36 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 27 Jun 2023 22:47:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PgTKQJGekFGP0lnrc/hYVilmlXglzLZFZY1cVRdOftQNAtYX87sbsqDh0kb1lVliRqEOKtOND+gyeAdASsBgJvM+uK3tieBzvOpWsAXoIXlaOAgYIH1vw6UhLwbhyo3pKz5vRe+OKiLcy/mYJqxY4yZFW4l9DxQBI5/OjQYg56/T5zAoWeYLhM53syZEbH5Lre/iuruUKJANTFrjKSbrEsaQpepnQ2l7lFjDPj/gmhIoFRQbFRcij9wf+t+/NqU6LbrywJhMedJytKivx9hbAnw6IgPug9KJjCIgpwq9CUcsbVYK7NtwIyXUQ1Ornpq6XuaDp71XPhI0ZGcnV3MCNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CE4Z02Y150Clc4SGL1kI+AGGH14vF26nkGZGpum6cVE=;
 b=hQ6DjlgU2kgDx5LkGiu34e9AFkrQq8TGG38Cc9pj6iVdbnb0cNOIwCuoIY6gvjZiaqIr3Vm6HV2cgVyEMVHrtd2pJOXU5l3bj553CT74j34jcFmAX85HESpP3Ltg+7v5ajR6ofbM+BbXL44oXFLUm+RaaJw+hBe9cwx9zjq/pyuaF/WzMn9+YNu0DmUL/uxV4ugC3aOwTQoN8Z7ZoNTVhrb1GsxaMeiAcaXrcFpJjiJqOa9VlpFELxGRXafWixzkIuk7HNl8fiMaNliyMl+FexCIT9DHYPJDu8kvIdzGM1VScIHeb9xkyLRQpu1hNQEvs6gFuQlLqvBLKdxXQvRXOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by SA1PR11MB5825.namprd11.prod.outlook.com (2603:10b6:806:234::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 28 Jun
 2023 05:47:33 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::56a8:e9c:284:f6a8]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::56a8:e9c:284:f6a8%7]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 05:47:33 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: RE: Reminder: Xenomai community call on Wednesday, Jun 28, 2023, UTC
 7:00 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday, Jun 28, 2023, UTC
 7:00 AM
Thread-Index: AQHZqXvlUz2/DSD7jE20qojMhTtoW6+ftO/Q
Date: Wed, 28 Jun 2023 05:47:32 +0000
Message-ID: <MN2PR11MB4285836F206EED99142F23DBF224A@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <MN2PR11MB428522CC19E11D6760D4FDCCF224A@MN2PR11MB4285.namprd11.prod.outlook.com>
 <c30ba005-e071-467a-8462-6478010bf4ac@siemens.com>
In-Reply-To: <c30ba005-e071-467a-8462-6478010bf4ac@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|SA1PR11MB5825:EE_
x-ms-office365-filtering-correlation-id: 52d622c2-df8c-49ac-a7c8-08db779b2b12
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pg7dCBup54ySL5NINjd24I6cz4E+DzP5TO5SsbVbZ5Rrlnl1CoyZ4QgeCC+yXBludHyrDC1ychmVT7/DLtxGm3NaFHCwgSVcaM9Yxvvqyo5iNdUt0TIK82RSOOyz7rVfR26wO1wIqI5GTzRgtFlPdG7UF/MmiNlGwqt/Q4Z4Cono3BZjlZ3mLGw2Hfh7dnosg9ixakoHFXhPA0T4/d/niEaIjjJUWeaFwIxXoqV7TwqAsS0zO42Z7ygq//8NYB93sjJVcSdRGaoWHKlQB7WqMVQ/RU8WJ4kbaJf1tNDcztdSgyzkPMNzCat4/JyUhpwVJHuojgbYfT6fRAFNgVwdxXAkyYwmGwExX9KO30kiBKZ5xS33vy60utWmBtARDUPdrm9wFIaCWyYDijN/ko6/MvtGFqyZNNVbKeSUgvbAj4iEaSXT86CPDOTHh/kKzAY6D0jXLetKRdxzjDiBcgx/RVeGw+pef5dfjEk/9XBTHtSQbvDWVmt1aRBJCTOCchlrBIKu9fLcYVqjARBIynRpM+ybahfohcOUkwXS3iAh5dOMLFPS254f8e4mwXF9BG3rosEYbH+lHiyrhOSevOCtYZbwWSxC+YScL62i3TSO4kN0i55QSemf4abRKfteIO05
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39860400002)(346002)(376002)(366004)(451199021)(66556008)(66946007)(66446008)(33656002)(316002)(64756008)(66476007)(76116006)(38070700005)(478600001)(52536014)(8936002)(5660300002)(8676002)(55016003)(86362001)(110136005)(41300700001)(7696005)(2906002)(4744005)(9686003)(186003)(6506007)(83380400001)(38100700002)(82960400001)(26005)(122000001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFB0bCtqRURVYXlGVzdwdzJkZk9xanBiVkE2aDI5dnM3UnA2VlVpcWw3VUdu?=
 =?utf-8?B?NVhkc2s5ZEg4TlpYMmZEbWY0dGxzWnc4M25OeVNpVnFhd3VrZnUvTmhjTTht?=
 =?utf-8?B?bXpGN1htTjhQWGU1a25NL3FQa3ZUMnlwaVM1cVBKeHd4Z08ya2owMjA2UUx1?=
 =?utf-8?B?cXpBcHRrV2h0aWZOemduTGo0c2FDMmVodC8vQWh3YmszUTF6d2VHREVPWTZm?=
 =?utf-8?B?dG5sTTQwdkdrcTYwOUFzQ2Zzc0dsWVdBdEhRN2RsSk9pSjVsdjRuMmZvNHRZ?=
 =?utf-8?B?QzZHUHJPcEtXUEh5RVNlSTQ0STBjOGl6OWQya0xPaHZpaW1rSjNkWDJzZW1h?=
 =?utf-8?B?dDRudDJjVlNQVVFSdkpGcEs5bEVoWlpOM1dJSW1tc1NrQnlocGpvbTRkcXh3?=
 =?utf-8?B?WHpCa0N1MzhOWnB3SjJMdloyaWY5cllOcC9VWEtUV3NCOHhkY3BTOFRQZ0tw?=
 =?utf-8?B?SC9QSTlxM2N3SHdackVETk1Dam9LTm5nbCs1a3JmOHpkcTZIeHBVR1QyVlJu?=
 =?utf-8?B?VUQ5TkJkeUh3eXJIL0lXZ1cvbWdNZndXd1pSVWZRdEZONGpQeFBEWFA3U09s?=
 =?utf-8?B?K1laeTBPcS9tOUovNlo3dHdGVjRQdGc0eWxrRjBFWng0bVlXblJzQ2dDd0t3?=
 =?utf-8?B?QitJdW0rWTRkb0ZWSGRVMmlhTHIwT0RmT1ZWQktwZDF0WHhFaWY5L3cvTmsr?=
 =?utf-8?B?OCtiNnQ1MVdVTWQ2Nk9MYWY0VjJ4NE1NSWFrSmtETVFsZCtZZWlzWWQ1MWJE?=
 =?utf-8?B?NDc0aUljUEYwdEVvWHA3K0xiWG1kVXluamFIdVRBQnF1cFpuVjZ0VUhuWEdP?=
 =?utf-8?B?bUJCaXROUmd3VFBUTGZBMjc3cFk4YjkwVk41S1pzdUg2REZQUHVGSmp2cCtX?=
 =?utf-8?B?bUNSYjF5eVZiQU5idnN1S21PKzNIa0MrSUdpVnZVbTVQdC9qNFNLcmxEOVdV?=
 =?utf-8?B?VFBXZFVXOW5WWEdyZkFOMnMxUm8xUmczRGpMb0hPVG1SUG9YbGNMVzRVSGl1?=
 =?utf-8?B?eGZtYWZvMVNmNE9rRzRLbUJQZE1ONmZtdzBkNUlOdmtZZEFNMXYwcU5MWGhM?=
 =?utf-8?B?Yjc2T09pd2QvYlJxWTlqOHB3ZVlCQlZqODBabmZCODFPYkM3WGRWN3VVdUZX?=
 =?utf-8?B?cGgzMWRFcU9naWhXVDRSbmM1b2todk1RUTlCOWdVYTIvaXBaRGNma0UwMjF5?=
 =?utf-8?B?dmQ3c3dCanhUcTJqT1F1VlR1TzcrQ1FHRXJENTg0OXIzT3B6SVZGVTREcDdX?=
 =?utf-8?B?M3VjanFrNmJ6aXhhUkZ4MTJuUnNsVUlNdTNvYjBUbVY2SEJ5TFNGaGNsMTJH?=
 =?utf-8?B?RHBNWDE4bkIyTGRkdXJWMHZwbjR3T1RzNnFIMGt3RkxsVjQ3cFJuUFJpeW9r?=
 =?utf-8?B?c01hOStzV2UxVzJQeDV6dG4vZUNPWHRCNWtSRDM1NjcxR2wzV0dTZFYwZUlX?=
 =?utf-8?B?OUJ3c1htdG0rd1p1QUJGdmV0b3BkZGEzVGZmMUE0cVlQTVVCWFlNVEFGcVVK?=
 =?utf-8?B?Q2VJenVlYmRROHg1NWtldDkyTllNWlVPODZ0OVBNQkNERlZCbnFyeVNEWnZy?=
 =?utf-8?B?VVRiajZsS0QrSnVOSFF4NjFZVzhNOXVjSlNYRThxaTFhYU96U3p2S2ZnWkp5?=
 =?utf-8?B?dHo4REJ2VHBuS2NDbWc3ZVVVbUlTRCtVNE5nUlpSeXVMcWJrbUlWSWNlRjNk?=
 =?utf-8?B?OEJzNG5ocmNRcitEQUZKRFlxbXBYZGpveU1FTW5BYnZIck41WGRwbVoxUk43?=
 =?utf-8?B?UlFBZGUxWU1Za0RuZURPU0pWNllJSDROMHZNRTduTnROOUpBSnRCaTBMc2Za?=
 =?utf-8?B?SjNzZ3MvY1JsUEtKRlRMWi91ZGY0OUN0eFVscjlHTUg1SjVxYTVUNkFGRmpD?=
 =?utf-8?B?QnJlU0xqd2gyaTVEMkhLTk9vZGMzTWhjM09TZllYeklFQmxpK0hWZkVGakZI?=
 =?utf-8?B?akJjWTlmMGRrRklYRm16cEliU1lYdGZRQWR5NlN1WUU0dTNSbmg5WlkwSmZZ?=
 =?utf-8?B?c29ybG9UWGM3c0RvL0FUTlJNU1YzV3hSQk93dDNDeHc2cWs3UlUwdy9YdjN6?=
 =?utf-8?B?aHZZTm5USEdxQlI4OWhNcy9sL2JScnpOVCtvQ2hxclBBakFoYk4vTFBZTUZw?=
 =?utf-8?Q?5+BkkrtrichEYgmtqH+94j87Q?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d622c2-df8c-49ac-a7c8-08db779b2b12
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2023 05:47:32.8841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gV8eISVyPnfAXm6FvNUR2KY2p5cDunrtZxgXuxnZS86SonkU0nW3MHx/RuygZusaQ1OpwqqBrLguYRFgMUlN4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5825
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEphbiBLaXN6a2EgPGphbi5r
aXN6a2FAc2llbWVucy5jb20+DQo+U2VudDogV2VkbmVzZGF5LCBKdW5lIDI4LCAyMDIzIDEyOjQ5
IFBNDQo+VG86IENoZW4sIEhvbmd6aGFuIDxob25nemhhbi5jaGVuQGludGVsLmNvbT47IHhlbm9t
YWlAbGlzdHMubGludXguZGV2DQo+U3ViamVjdDogUmU6IFJlbWluZGVyOiBYZW5vbWFpIGNvbW11
bml0eSBjYWxsIG9uIFdlZG5lc2RheSwgSnVuIDI4LCAyMDIzLA0KPlVUQyA3OjAwIEFNDQo+DQo+
SGkgYWxsLA0KPg0KPk9uIDI4LjA2LjIzIDA0OjU1LCBDaGVuLCBIb25nemhhbiB3cm90ZToNCj4+
IFdlIGhhdmUgdGhlIFhlbm9tYWkgY29tbXVuaXR5IGNhbGwgdG9kYXkuDQo+Pg0KPj4gVG9waWNz
IG1heSBpbmNsdWRlIGJ1dCBhcmUgbm90IGxpbWl0ZWQgdG8gdXBzdHJlYW0vZG93bnN0cmVhbSBw
cm9qZWN0DQo+PiBwbGFucywgc3RhdHVzIHVwZGF0ZXMsIGFuZCB0ZWNobmljYWwgZGlzY3Vzc2lv
bnMuIEl0J3MgYW4gb3BlbiBvbmxpbmUNCj4+IG1lZXRpbmcgdGhhdCBhbnlvbmUgY2FuIGpvaW4g
YW5kIGFzayBxdWVzdGlvbnMuDQo+Pg0KPj4gVGltZToNCj4+IFdlZG5lc2RheSwgSnVuIDI4LCAy
MDIzLCBVVEMgNzowMCBBTQ0KPj4gUGFyaXMsIEZyYW5jZSBDRVNUIDk6MDAgQU0NCj4+IENoaW5h
IENTVCAzOjAwIFBNDQo+Pg0KPg0KPlNvcnJ5LCBJIHdvbid0IG1ha2UgaXQgdG9kYXkgZHVlIHRv
IG9uLXNpdGUgbWVldGluZ3MgYXQgRU9TUyBoZXJlIGluIFByYWd1ZS4NCg0KTm8gcHJvYmxlbS4g
IExldCB1cyBjYW5jZWwgaXQuDQoNClJlZ2FyZHMNCg0KSG9uZ3poYW4gQ2hlbg0KDQo+DQo+SmFu
DQo+DQo+LS0NCj5TaWVtZW5zIEFHLCBUZWNobm9sb2d5DQo+Q29tcGV0ZW5jZSBDZW50ZXIgRW1i
ZWRkZWQgTGludXgNCj4NCg0K
