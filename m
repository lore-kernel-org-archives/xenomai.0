Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D26FEDE
	for <xenomai@lists.linux.dev>; Tue, 18 Jul 2023 01:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689643866; x=1721179866;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=ri1jMzMDNa+17iTW0KWBYhOlrTM2pXPudlkRWW+GRg4=;
  b=bJdBJUiXdoCG59u3JGrJNq3oixj/Dfp2/XLgQjrAJhDm32w6jEoXaNKV
   xr0Az4UIn9kMdOCGWa++Nu7eRvqPkOGLBU5BnpvFghHryCGd1mkc9bPuf
   JtiWPK2p6J1E2KLp18Z3ANm+Ss6lN4PqnCAaYTDG4gqVdP/Id52JTXs95
   0GJkmLfyQZTgXyae9iS5c8YMePtt1BGXfhTdTMWTf7mGHsRwtZnwyk5Ic
   LgkM4ffvDvOgOHD3ex73Fk7bH7iLSA1DZHNzhQU1XlR7Pp8HljD3beRMj
   jJbXiU0XZetvqhx3O0V4kbaTzJaFG/mj99J/1OKb/uwwqCAxdeZWNZCWQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="429843678"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="429843678"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 18:31:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="726748809"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="726748809"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 17 Jul 2023 18:31:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 18:31:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 18:31:04 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 17 Jul 2023 18:31:04 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 17 Jul 2023 18:31:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgIZ3XGerKzh+4uJUbFf+8FV2XUaiOgtgzK+HgqCpKlZ88OQRTi1b4+Art2TgjJ6ePuKCBjqKCX9EsdnX48ZjtXZx9Ab3m0Mk9f+ZFJRNFQAiCHcE02bd42IFpaiSyA/Z3LKKF7ZdlRR+U/g5D/XbAdsnICLDp9v1z/LaHyar9fIrMv7ie9QHl38a7dHa4J10Iud5TFnxH0f64eLi2I0c/lw08DudoUdasNyE3mSREts5j206rwwR7/hPEkAH3UP3Nhjk/5NYLfceoL2O/90DeGeI3WAkxV82h2Gd8cI4v0bDoIgdYCcVsH4V0ausHWQFvP14+Qc9PhWbTtcXTnfJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ri1jMzMDNa+17iTW0KWBYhOlrTM2pXPudlkRWW+GRg4=;
 b=ag7QjrR3if4Ozp3kl2Pp4ZFDTWtf+L6Prr3OhqNceG8S/xdJeeCrTW0HYP0EG8s+ZJYB4dhsdoRpKtHsiKayu32YtxhVJB37gDZEigREr2lJ3G8jm2NTWglquRrRCI5lPJzafH6gc1b3elN6lUF38rsusJvZl4eSZuRE3o//XG22AN/qsh/FOxP4WaVE5yIdS/moluAhyaeqPlK/u26wqf7evmISvmWJl6R10U2HGdq672TW7mbkruWKvWP6EVATHbVGsIgABwjtvgF77rncADpIqWsJYkPCqs6epLmTNSyErifNnrVoE3LsYtCFyyoexhhsiUAzkZyQqMk6YKFVbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by DM4PR11MB6357.namprd11.prod.outlook.com (2603:10b6:8:b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 01:31:00 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::431f:7b31:39c7:e9be]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::431f:7b31:39c7:e9be%3]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 01:30:59 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: Yao Yongxian <yxianyao@126.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: RE: The issue of high CPU load
Thread-Topic: The issue of high CPU load
Thread-Index: AQHZuF/6lH3cHLH/D0azNkYpJUOD8q++s6lQ
Date: Tue, 18 Jul 2023 01:30:59 +0000
Message-ID: <MN2PR11MB428578B713BAF8CCD9E5E3B2F238A@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <19116d90.26f0.18961de2924.Coremail.yxianyao@126.com>
In-Reply-To: <19116d90.26f0.18961de2924.Coremail.yxianyao@126.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|DM4PR11MB6357:EE_
x-ms-office365-filtering-correlation-id: 0b1f38d4-1f88-4e93-1322-08db872ea469
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YYPRWcPseIGMFX/bpsmT2t10ilIc0llYvJk1bQ7kgwylQAfJgJI3XZ3L8zFKQwfLA00rgth0fWub0QOw0RGouZbdVs4M8Gz2kTYhiK+EPSnofy4R0qhzJ68wlr7ISYxBPJRSwIogzwDRbzn+mGqeoF9+UhWPBqKzIf9qO4ty5mmVxN8SRbjkfQWOOFKUiP75US9+f1biYsG3mMhQ8syRYjukm7EIdkOKD9udTRUXbQpuU7aWIDTnHw5wVKb0THsFrlGAlBIPtzDzo81fg07ZrQfiffdHRt0vSiTcR8I9s9ygg6pZXWcY0KlsZHiNBr8gq0kfUoDhuoc0EOi06bvtEeSD8wkmXLaYXR9tXpcJI6yAsRzUYLrE0sTDAcrYDU8jAkVuO2bjBe66K6hXJ60CxcnGoEX0VFy8ChF/rMI0qas3U6R9sVGMgq8PB0QaCfvoyw9oA8abRd6A8MKWn7HB0BO/qBOVrD39ZmwoIQU5amOQZdZK/ypzNP+kSshEaoEjFYPn0GVv1dq4YFfXUauCIKGqwAqQvHrBehgvvRoZ052Z8UWSmlEApH3vMB++MhOPMNIYBVyb9H9h4CXEMFJY+XRAp+c/DQCRS3mzjWckEl0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(366004)(136003)(346002)(376002)(451199021)(478600001)(7696005)(71200400001)(110136005)(6506007)(966005)(186003)(316002)(2906002)(76116006)(4744005)(9686003)(52536014)(41300700001)(66476007)(66446008)(66946007)(5660300002)(8676002)(8936002)(66556008)(122000001)(82960400001)(64756008)(38100700002)(26005)(86362001)(38070700005)(83380400001)(55016003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFJXM1ZqZ25qY3RESllaTFZjWTJqck5YQlJJbjNXWWxROWN2L28rTXhGWVVk?=
 =?utf-8?B?MEVHNjF1OW9BY1BQdWp2R3VLazlMODgydG5KLzNZbDFFNTdUSzhkc3BwSHhX?=
 =?utf-8?B?MitPR1djU2E5TVdjUnNIU1hZd2hIdWtZSGZpVUFPa2hiQTdzZnJmRHBXbGxL?=
 =?utf-8?B?TFphNldHeUlFNFlnQ0NzTmZ0aENwQzJ2U3lVdEdTTnZsc2dSVVJ2NXJkRUdV?=
 =?utf-8?B?S1lMK3VMdjBZRWN6aGF3TXEyK2pWQlpSQitib09WYUZ3ZEdoTHR2VnU5TTFn?=
 =?utf-8?B?NlB1T2trMWl3MTYzWkNtc01HYkMwenVpV2JOQm9GcXE4c0lWNndBaHA1NTB4?=
 =?utf-8?B?S092eVVKNWFyOGE4VlBzR0MxQmZsemdtSVNxYVprZnQ4L1F2dXBJdXVZMjV5?=
 =?utf-8?B?N2VZaGMzb0FCOTVtMHM5V3p2MWJ2NkxWREwvdnR2elFQbTVaZ1oraUsxRktr?=
 =?utf-8?B?ZEdURDJqOFBuVG91ZE9nYTZvMU9zM3U4bERZRmwwQkZkNVBIVE1VTDJlemR2?=
 =?utf-8?B?RkZaWi96UDdabzNVZ0IxdzRhcGZLUzJ2OC85emJDYjVTUDJiMnczdXk0N3Mv?=
 =?utf-8?B?WTh0NGNkakVpTFNrYllwTkpwR3VWVHVKSi9VMHR3WXRSMmtIYndFamtwWEYz?=
 =?utf-8?B?b0NqWEt5QjBvbUIxY1Z1K3FRMHlHWkpySlZNb0U2WVRRUXhwYVo3dUtHWXBZ?=
 =?utf-8?B?MWJHVis0N1h3TC9wTVRWMGpOS0dsdDVkL1ZmWjBUOEFma21WVGZUSEZEdnIx?=
 =?utf-8?B?TzdJeUxhZlhPc2F6SGdtZktiMTRHNzVrdUhVcHJkYi9GV2JMempDQmMzMUU4?=
 =?utf-8?B?c2RlVDcyejNnT2RRbmZIUlJueTRWU1prQy8vSkJIS1Bld3dmRGJScDI1OFRK?=
 =?utf-8?B?L2tIbUJXZEphUVE3eTA1ZTAzd1E4d2Ira1BEUXhxUnErWkxSUWxOQ0JZbmE1?=
 =?utf-8?B?blVjdzVDYk9BY0xNWEJxS2JjTXRkS2sxK3gvVkk4aFlEeUwrb2xSTCsyMndr?=
 =?utf-8?B?MlNkaURSR2RqME1BeXY2RnB0b1NQai9jU0t1dTNUdnRrL2VFUnJxY1g3MXhi?=
 =?utf-8?B?ZUZxU2dKYU04NEZTOE12elZMOFFyejBhODhJS0ZIcWkxLzNZdjRkNXBSOG1B?=
 =?utf-8?B?ZGFDUkNXT05GaWtvNm5TQ202TTU5Vm04WUk2YlR1S2xIaUNuWmhWNnFLOXIv?=
 =?utf-8?B?ZFR1RURuTldNWERydW14d0x3TW5nYWVJcTNWVGFvT3NvVjVmU2lkVXBBcG5x?=
 =?utf-8?B?MlFJZ3Q4QldEeWx2amR0b0xBM21UN3VXUGs0K3FrQVRNeFRaOU9kNVNpdmZB?=
 =?utf-8?B?SzVRN3F1UHNheldHemdvbzlodzBvYU9TdEl5Z3lxVU9vTXY2R1Q2dFozQTlF?=
 =?utf-8?B?SnZnZnZCQXdGUVQzVFZkS21DNUc1bmhPS3pQOFZHYUFmMktnNEhvYmRFdjBr?=
 =?utf-8?B?Tk96U3A0aExNelRHbDdTT2E1bWNZUnF4cEpqM3U1MDBvanRxNW0wQnlONGlR?=
 =?utf-8?B?RjNkTEhDdnhzU0xEWWRpME0zRUJJdjk0TWhrbi9nNjhWSGtaZ3Q3bWt1bGp2?=
 =?utf-8?B?TzZaZG1OR2diTzFnS2Nib2J5bStxUm5tZEkwYU9xTnJBaUQ4QlFhcWVEY3gx?=
 =?utf-8?B?NUNJczdrUDZDYW5EWHJLd1NzbmJYUGVuMmo1WDBYYzFYVWxTUnVkRmFlekND?=
 =?utf-8?B?cjVFVVRmWWhWbUw2SGU1VkROYkUxdlZMbC84cENwanBhQkQ1d1pwZEg4Q3ZD?=
 =?utf-8?B?TmVGUUtlQjdwQWxaTFBxaFpuSXJmL2R6N0pYOGNGMzkxU21YcmFQLzZqWmx1?=
 =?utf-8?B?eGFKOFZPdi9wNjhYbW1VUStxTEMxTmNxY0tKMW1idnNIKzY2VGlIeWcyVmoz?=
 =?utf-8?B?b3BLbmhnUjdEU1FKdFg1NWJzQ3gyakZUSi84bHlwZU9aQlNtUm5QRklvYXdp?=
 =?utf-8?B?Wm9pSGdYMXFvdzRDaFgvK0Y2cjd5bGQ1bUlkRWhadlQ4ZTlZZjZXdlBEbGN0?=
 =?utf-8?B?WFpuSXlUNjZjcVZra2xTcFFJSys2cE45TGIrLzNwMUR2cGFkVEJrcTJ0dGxo?=
 =?utf-8?B?bWp4SjFrV0RQdytkY2Zwc29lbVlOaG9uZi8rNkUrNW5kNVdaZXJRRENUb1c3?=
 =?utf-8?Q?aDg2Ys34VSMM8Xxfhe7+FDs0f?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b1f38d4-1f88-4e93-1322-08db872ea469
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 01:30:59.9288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xkT3v8uvL4rt2J43q56Vpcxwj1qn7BEFd+OaZ31s7nDwl2Fhcl5TLAxfafTJcClg6WfyRV+iBY495lc0sdRdow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6357
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFlhbyBZb25neGlhbiA8eXhp
YW55YW9AMTI2LmNvbT4NCj5TZW50OiBNb25kYXksIEp1bHkgMTcsIDIwMjMgMTE6MjIgQU0NCj5U
bzogeGVub21haUBsaXN0cy5saW51eC5kZXYNCj5TdWJqZWN0OiBUaGUgaXNzdWUgb2YgaGlnaCBD
UFUgbG9hZA0KPg0KPg0KPkhp77yMDQo+DQo+SGlnaCBDUFUgbG9hZCBvbiB0aGUgcmVhbC10aW1l
IHRocmVhZCBvciBpZiBhIFhlbm9tYWkgdGhyZWFkIHJ1bnMgZm9yIGEgbG9uZw0KPnRpbWUgY2Fu
IGNhdXNlIHRoZSBzeXN0ZW0gdG8gYmVjb21lIHVucmVzcG9uc2l2ZSBvciBldmVuIGNyYXNoLg0K
PlRoaXMgaXMgYmVjYXVzZSB0aGUgcmVhbC10aW1lIHRocmVhZCBtYXkgY29uc3VtZSBhbGwgYXZh
aWxhYmxlIENQVSByZXNvdXJjZXMsDQo+bGVhdmluZyBubyByZXNvdXJjZXMgZm9yIG90aGVyIHRo
cmVhZHMgb3Igc3lzdGVtIHByb2Nlc3Nlcy4NCg0KWW91IG1heSBmaW5kIG1vcmUgZXhwbGFuYXRp
b24gYWJvdXQgc3VjaCBpc3N1ZSBpbiB0aHJlYWRzIFsxXS4gDQoNClsxXTogaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcveGVub21haS9DQUtjb2hQeGRoQ01vaEpaZlNOYUwyRXZFRGNMZG04Q1JnZHkz
aFV1c0N1OVk1amV4eHdAbWFpbC5nbWFpbC5jb20vDQoNCj4NCj5XaWxsIGhpZ2ggQ1BVIGxvYWQg
Y2F1c2VkIGJ5IG5vbiByZWFsLXRpbWUgcHJvY2Vzc2VzIGFmZmVjdCB0aGUgeGVub21haSByZWFs
LQ0KPnRpbWUgc3lzdGVtIHN0YWJpbGl0eSBvciBsZWFkIHRvIG90aGVyIGlzc3Vlcz8NCj5Db3Vs
ZCB5b3UgcGxlYXNlIGdpdmUgbWUgc29tZSBkZXRhaWxlZCBleHBsYW5hdGlvbj8NCg0KV2UgZG8g
bm90IGZpbmQgc3lzdGVtIHN0YWJpbGl0eSBpc3N1ZSBvbiB4ZW5vbWFpIHNpZGUgY2F1c2VkIGJ5
IGhpZ2ggQ1BVIGxvYWRpbmcgb2Ygbm9uIHJ0IHRocmVhZHMuDQoNClJlZ2FyZHMNCg0KSG9uZ3po
YW4gQ2hlbg0KDQoNCj4NCj5Mb29raW5nIGZvcndhcmQgdG8geW91ciByZXBseS4NCj4NCj5UaGFu
ayB5b3UuDQo+DQo+DQoNCg==
