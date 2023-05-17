Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7618017C8
	for <xenomai@lists.linux.dev>; Wed, 17 May 2023 01:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684286231; x=1715822231;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=JZUc5zUn3WNTUmiNibE55a1jtjpnQ16xaZhRV4i37aQ=;
  b=aP7KUh8YVP4Uptc2hYDmZ6+V7KMdJ4VxTQmzgHcWPyiALqWJbSyS+AvU
   xcL9uEiqTORc4+J8tGsmGjm+PnGmie3wUQiOVC+KkN5qOy83SNOGpVlUk
   TY0xLKkwaJpcep+DXfD/Ye4PSWcQNgMf3yd6JjoBVOu/KsBWXW5GQUWRF
   JL0HYCwLVt6XHN1xIjt3itWfZfHImNSgp4Q7MnMxXn+2jRIcBrOlxsBsR
   lxmAxLzbvsCuPm+Nje12Eu46Dvd5ZD/RwyYVBqZMCWY3PnChzWrhNsCvM
   wSHpNXT99t1jyDb0ufTBtSjP+I+oH6x6gyvhd1Wts40zVoEQzA1jTfeuZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="351661377"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="351661377"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 18:17:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="771276435"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="771276435"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 16 May 2023 18:17:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 18:17:10 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 16 May 2023 18:17:10 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 16 May 2023 18:17:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PyCXc6/WqV8v+9FiSiGdao2+C8z/0IKUrG4mwS5YZQmpc03UkaDHstCIZ5VPVqGTwP/quOGtFyy/ieKsD+ah0e+1ihJ8bKOnBd6H0LNOtS1JNX8ZnGv/g/Jy1/K6iichZ5EE3Q74592EyVMzXKPWA2UyYf4wecBiOj7aJoyL3H3sVDupBgJIiWZ1eRfx7QWTbVV8rXnSJztOOdB/9Lmy7Lz4vMlBgPA9q6FVYZrSYMggAH7OKMQR41XkzVS0/AibMLK1lx/8E9DUZkizG48RzfDPy+sYBmpHRXQrydR6ZvQHCH/tBj8zxFeXeMcfn9uwtf2C45nmFacOE47o3rDWaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZUc5zUn3WNTUmiNibE55a1jtjpnQ16xaZhRV4i37aQ=;
 b=AQNe4YLXJFTUZl/gw6Xj182h4XSsg1PTi41DKXOLOD/RcKSS/xBqe7K1UkHADEScOyJRDgT/++vIQp+ZQuyBuOYqsfokAr/R23lSw4HM3QplD+Yj+v1Up/+anrWR7mEwHoMn2iB5EYrcc3jg4MBhEzFYTgAD8uOVeX4aZZm+2GhXHtIsM+SSGhyMRUOBE7gi7/3uWUqHhxiSiFrd15VbSSt78KRvtkAcqF13S9CWmc92rdDs5wJsYQR4p2gNMIV9FlCXGYiYKWlIGcTMMuJ7UCbQwiNC2rkoqxi0RyDcW3OD1lxve28lt+gpAiZNdssd3vSJikbmwbB1ad1MjxVcBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by DM4PR11MB6141.namprd11.prod.outlook.com (2603:10b6:8:b3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 01:17:07 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::56a8:e9c:284:f6a8]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::56a8:e9c:284:f6a8%6]) with mapi id 15.20.6387.030; Wed, 17 May 2023
 01:17:07 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday,  May 17, 2023, UTC
 7:00 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday,  May 17, 2023,
 UTC 7:00 AM
Thread-Index: AdmIXTxhhoAjTOAoRPOcAdLAofpO8Q==
Date: Wed, 17 May 2023 01:17:07 +0000
Message-ID: <MN2PR11MB42852432A8950628A07DF610F27E9@MN2PR11MB4285.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|DM4PR11MB6141:EE_
x-ms-office365-filtering-correlation-id: 1e53a61d-90bb-44bb-e872-08db56746ea2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dTXkEpYnMP5aTUjnQfNY6FknOLIakc6Us33A/eUx0/wfvPwV5HWZSOwwgJLoP+tNIPpkpfzxYh2Y5MJzBgwdVuatWb5Y44x6XGNAOC+kzI2Gn144MrE+MWnSC+1RE+OVqFaAdL93VCl2CR1Xukv+oy29EMePbcyhnLJ8FP5gLo0d4r72Xcd3OUkFLXCsLN4s2mInnezjK34w4SK9tkMdy+duJo9XiLEfDHrEviIiGn2ThD/qkWw73BRwjk28qmrDbai9JbaZvTlbMuD7KIP8qI4eK5R4/GUPSCr5CfFbs1m3EaE9eyOpsHs1X1avH1kfJdW2ZM0tvkVeN330w2Di2bQkR972vWF5Pu/wWQe1AlvrxoUNucqsvabtIOx5MovMx4gjogMnTcL6ufoaQyhabTaL70VR2QUP3X9j9vsHoYxo+n/uFBKRGizOOmuQCMP7GLNpnmOdIhVWek3RRrbgTme35dSzAy9UAOxaXagIMJA9W18sIqnaBwfvqyyFXlyuK3BIXaKAvOgxHrzfz0ut0X5SgmcDHOqukSaaPLBq/Op+aZ30b7qXDgndVqcAApVNfoEVM/PJ/xRlDRSH/uzQP85XZMXw6IgLNcHFASod97f1CT4KiSRcOy9ZxqKz5jBiqGu20asgMTR9G2aYrttk/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199021)(38070700005)(71200400001)(122000001)(38100700002)(82960400001)(55016003)(6506007)(186003)(26005)(9686003)(83380400001)(40140700001)(33656002)(41300700001)(2906002)(52536014)(5660300002)(8676002)(8936002)(478600001)(966005)(7696005)(66476007)(66556008)(66946007)(66446008)(76116006)(64756008)(316002)(86362001)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXlIKzdNcFJzcjZ0S2Q1MFRlWng5WE51L3BRUHFnMHRwUXFSN3IvWDErZ2lh?=
 =?utf-8?B?NnY1ZHZ0SzJRaW4va3ZLaFJBUDRTNlhKaG4wa2kxdWw1VWNuNTZxSkhhUXFZ?=
 =?utf-8?B?cFgvTDFNUUhDYmxtRTZFK3FGMUV6T3hidGJpUFdPZTNSU085OVpka0JoRVF3?=
 =?utf-8?B?UFRadUdxbkFhSlhSUnkrMlhJcjdYSm5TZ214N1FxZVpQZGthekdEN29vQzdn?=
 =?utf-8?B?NUpTM2lrWmFNY3M0anAycVZPOVI3eHo0ZGtZL1VSb3ZtZjVIa2RWbGl0d01C?=
 =?utf-8?B?N0x3cVVGanVwdnRONmtuYjk1WG9wTmxaMnEzMk5VaW9hb2UxTmQxSWZsMENl?=
 =?utf-8?B?ZFREckEvYmpNLzQ4YzVSZzRyczVhVm9VeUcyNDV2bGduR1oyR0dpYTl5UjBp?=
 =?utf-8?B?ZHBHQ1B3RFZxMTUrc05oZjF1M21PWWtLeEFmcFlPY0Zzc0NLZ2R6MllBTndC?=
 =?utf-8?B?V0gxa2JGaWVDdmdqR1dGeU9iNTlQTjU2NlpyQmNOaVhsbW52bE81bVBpMTlz?=
 =?utf-8?B?V0dNYzNIUndCR0xtT1hpV3RxeEJBSXFDWEJZUHhPVGNjejQycGVMU0xsVmdj?=
 =?utf-8?B?cXBJcjhmK0laNzU4RzhtR0hqZk92c3d5SGtzdGg2TTg3a1hadHRIMW1rQzNV?=
 =?utf-8?B?S2hSaEZDWnNHUHV6dW9UY0E0YVQvMU1Fa0tHSUxDRDZRbFdVZlJjSjF4S3NY?=
 =?utf-8?B?cCt2dnVYNUJTYzhPYkNIcTZFNCsyYkZ3ODN3QWErc0c0UzR2ZDBnVmRPdEZT?=
 =?utf-8?B?UmJBQ0VBWExCTStkMUtwcE9CbWwwZ3VXemNoVzd3TVpTeS9sNksreVE4STJE?=
 =?utf-8?B?eUJ1ejk4eEJHMmZSTkZWOHRYNklWTkZMdVNSRlk3bndDNUdFWHU1bWFWbE04?=
 =?utf-8?B?NHFPWnFhK2FCVWovZnFkdm5QdnJxdXh4V0RZTUpuTEt0WEx1NG1Mc21ETDZl?=
 =?utf-8?B?UXQ2bDNXNHdWTEYveGZZYzNtc0M3SHk1dCtNV2N2Mmw4Y2Y3SnoyN0U2azlN?=
 =?utf-8?B?ZDZPRVJyakdhMWlMbXhEM3crMnJzc3RxYU5RZjNOVk43NXJMSHZ6RDI3UDVQ?=
 =?utf-8?B?N2lkTmJiRTFEeVFiQjBVK1VPa1lkOU54ZXpjQ2NCL0dCMFpET1E4dTZ5Q2d5?=
 =?utf-8?B?ZjNqNG5Gb01tR0xlWm9BN3NhTWpCaVh5OU5BdC8rVHJML0l6anZEOUZlSjFM?=
 =?utf-8?B?eDFxc3UvaDhiQktOb1FkdzZIMzlxUTZzYjdreHE4WHk4eFoyNHNiUUJmM3Av?=
 =?utf-8?B?ZFA4TDJLRy9qVUlGRGxvMTBkS21uVmFRczE3aVRJckl2clFWaUovSFBpcDFE?=
 =?utf-8?B?eGVXcVRyVERPK3BkVkFUb0JRZ1QzUWtrMG1MblJwZFFBQ2VwNWpDb2lzYXpY?=
 =?utf-8?B?QVpNSXJMeHQ5cndmUE4wa3lIaFYvc3lQVzkvcnlnRWk4OWFSWmVodEQyTWFU?=
 =?utf-8?B?S0k2NnQvQkdCQlpXVUVmS0VzVDd1eGVYZnR0T3lEdm14TUhKd2RPNlh2Q0Nu?=
 =?utf-8?B?L1NTcUoxMUwyNnNNeGEyQmIvQ3A0dDNLNGZQR0tGRUg5TWpJdEtEMEJIcGFP?=
 =?utf-8?B?RnJiTVphU0xFZG45VTZCbEk3R1NjY1F5ai9wbGpETEFXdHZTWkY4dE4raTVB?=
 =?utf-8?B?UGhnT0lXUkh0ODBPaTE2cWcxdDVrVm9rcGVhcWw2N0RsV2NreFl1Z0ZhOUhu?=
 =?utf-8?B?N21uNEtXYTZhd3BJR2JxVmFqbHdhV2tNdllyUyt4M29EVmN3azUrOHhZQUxW?=
 =?utf-8?B?UlNIaVdlckNZTGtRNkd0SVhycmdIWnFSZTQ1MmhSS0N3eVoyV1pCeVUraDZC?=
 =?utf-8?B?a0NsT2xxWFBQR0trMmttT1F1YXBQK2dMU1M3NHlqaW5CNDdMN3kvWjM3OVB3?=
 =?utf-8?B?TGdmWldJKyt1eUg5T3h6TWc3MnVVQnpZVklDYlNRZ1FYckE4NUpxckRoL3Vm?=
 =?utf-8?B?Sm9iL2dWT2xTT3d2ZWduTzNvd1c4ZHE2Zm0vTlYwWmFLTm5MZnBiOUcwb1FY?=
 =?utf-8?B?R3V2SGFWckhLOUhhZzdxM2REK2YxNjVMNFFmcGFvQ3FsMk5lY2NMOWN1d25C?=
 =?utf-8?B?RmZrc0dUVWo1RlJaSlluWXFBdTcwT2RjS1hCeTNWalhGbWxJRXFRcDFXWGRh?=
 =?utf-8?Q?afGf3WA+N6XFiGdFVzXlbM7z8?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e53a61d-90bb-44bb-e872-08db56746ea2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 01:17:07.5193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UWv5I/E35D2BAobusIL4tgR+mSSXPYcmLm7lIKagcN/nt3kKo8UnciojekRJK8Uwb/lPN2IH9Ilu9R01QCgnIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6141
X-OriginatorOrg: intel.com

V2UgaGF2ZSB0aGUgWGVub21haSBjb21tdW5pdHkgY2FsbCB0b2RheS4NCg0KVG9waWNzIG1heSBp
bmNsdWRlIGJ1dCBhcmUgbm90IGxpbWl0ZWQgdG8gdXBzdHJlYW0vZG93bnN0cmVhbSBwcm9qZWN0
IA0KcGxhbnMsIHN0YXR1cyB1cGRhdGVzLCBhbmQgdGVjaG5pY2FsIGRpc2N1c3Npb25zLiBJdCdz
IGFuIG9wZW4gb25saW5lIA0KbWVldGluZyB0aGF0IGFueW9uZSBjYW4gam9pbiBhbmQgYXNrIHF1
ZXN0aW9ucy4NCg0KVGltZToNCldlZG5lc2RheSwgTWF5IDE3LCAyMDIzLCBVVEMgNzowMCBBTQ0K
UGFyaXMsIEZyYW5jZSBDRVNUIDk6MDAgQU0NCkNoaW5hIENTVCAzOjAwIFBNDQoNCkpvaW4gWm9v
bSBNZWV0aW5nIA0KaHR0cHM6Ly9pbnRlbC56b29tLnVzL2ovOTEyOTcyNzkyNjk/cHdkPVdtZHdT
MHBET0RSTk1TOXRRazU0WTFkdmJGbHFVVDA5DQpPcg0KaHR0cHM6Ly9pbnRlbC56b29tLnVzL3dj
L2pvaW4vOTEyOTcyNzkyNjk/d3BrPXdjcGs1MmE5Zjk2ZDk4OWU3ZTIwYjYyOGMyYzM2ZTQ4YjY4
ZQ0KDQpNZWV0aW5nIElEOiA5MTIgOTcyNyA5MjY5DQpQYXNzY29kZTogMzY3NTI4DQpPbmUgdGFw
IG1vYmlsZQ0KKzEyNTMyMTU4NzgyLCw5MTI5NzI3OTI2OSMgVVMgKFRhY29tYSkNCisxMzQ2MjQ4
Nzc5OSwsOTEyOTcyNzkyNjkjIFVTIChIb3VzdG9uKQ0KDQpEaWFsIGJ5IHlvdXIgbG9jYXRpb24N
CiAgICAgICAgKzEgMjUzIDIxNSA4NzgyIFVTIChUYWNvbWEpDQogICAgICAgICsxIDM0NiAyNDgg
Nzc5OSBVUyAoSG91c3RvbikNCiAgICAgICAgKzEgNjY5IDkwMCA5MTI4IFVTIChTYW4gSm9zZSkN
CiAgICAgICAgKzEgMzAxIDcxNSA4NTkyIFVTIChXYXNoaW5ndG9uIERDKQ0KICAgICAgICArMSAz
MTIgNjI2IDY3OTkgVVMgKENoaWNhZ28pDQogICAgICAgICsxIDY0NiA1NTggODY1NiBVUyAoTmV3
IFlvcmspDQpNZWV0aW5nIElEOiA5MTIgOTcyNyA5MjY5DQpGaW5kIHlvdXIgbG9jYWwgbnVtYmVy
OiBodHRwczovL2ludGVsLnpvb20udXMvdS9hVEVBMzdpNUcNCg0KSm9pbiBieSBTSVANCm1haWx0
bzo5MTI5NzI3OTI2OUB6b29tY3JjLmNvbQ0KDQpKb2luIGJ5IEguMzIzDQoxNjIuMjU1LjM3LjEx
IChVUyBXZXN0KQ0KMTYyLjI1NS4zNi4xMSAoVVMgRWFzdCkNCjExNS4xMTQuMTMxLjcgKEluZGlh
IE11bWJhaSkNCjExNS4xMTQuMTE1LjcgKEluZGlhIEh5ZGVyYWJhZCkNCjIxMy4xOS4xNDQuMTEw
IChBbXN0ZXJkYW0gTmV0aGVybGFuZHMpDQoyMTMuMjQ0LjE0MC4xMTAgKEdlcm1hbnkpDQoxMDMu
MTIyLjE2Ni41NSAoQXVzdHJhbGlhIFN5ZG5leSkNCjEwMy4xMjIuMTY3LjU1IChBdXN0cmFsaWEg
TWVsYm91cm5lKQ0KMjA5LjkuMjExLjExMCAoSG9uZyBLb25nIFNBUikNCjE0OS4xMzcuNDAuMTEw
IChTaW5nYXBvcmUpDQo2NC4yMTEuMTQ0LjE2MCAoQnJhemlsKQ0KMTQ5LjEzNy42OC4yNTMgKE1l
eGljbykNCjY5LjE3NC41Ny4xNjAgKENhbmFkYSBUb3JvbnRvKQ0KNjUuMzkuMTUyLjE2MCAoQ2Fu
YWRhIFZhbmNvdXZlcikNCjIwNy4yMjYuMTMyLjExMCAoSmFwYW4gVG9reW8pDQoxNDkuMTM3LjI0
LjExMCAoSmFwYW4gT3Nha2EpDQpNZWV0aW5nIElEOiA5MTIgOTcyNyA5MjY5DQpQYXNzY29kZTog
MzY3NTI4DQoNCg0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQo=
