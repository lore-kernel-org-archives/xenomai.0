Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEE67F
	for <xenomai@lists.linux.dev>; Tue, 13 Jun 2023 02:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686624088; x=1718160088;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=JAEX5aG79SQ+8qX/uPFuDpueISisOqkNj0wzt1eU68w=;
  b=TReZpRMoSDITlAtc6+JLIC5PZsWrnwEPVRM/YKbgcf1wX4VwOHVwG44j
   z74AnRmdYxzi4LvkWZ7P686lx/g45pyng9V5OgxMMgPreECo2UDCjh5WG
   9mJ7XvsnzaY0sbBh89BC8UD9VDtrYwL0vowxnA2Q4tD6ca8fJbAZCIPbu
   bSzmMHDq+LJuwYUagXeVqjXJfbIFpqgxGIrVaX4TMXvraIYjMuKmW77Is
   LFN6wz5Anmnzdl+uINHAK6Xf45lixqX8eRhxnb08d+d3XYmA2+lWR/zfJ
   h64ZF9upgy2AHevx6GsN1AQjfmwdXP4KFvaOmNIW6GnuP/fzDVw3pvNvV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="360692964"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="360692964"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 19:41:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="688850860"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="688850860"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 12 Jun 2023 19:41:20 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 12 Jun 2023 19:41:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 12 Jun 2023 19:41:20 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 12 Jun 2023 19:41:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMOJeBgg68ZzygQCpa1Rlw9e3ijjH6rIEL39dZMUmQOoU7kiTGf8ls9SgNtgRtjZVydxI1wHGywzMQ6I1X5RzZBAvDcwwtQvD5zUn4y9PHcXSoiBxqsalXvrmv8nqJYcLWzmCc7gheoWr3pyVsBN1O6jFuwGLyzmrNi0YH2SY4i0PGeZN1J8TWgHt5NWx4r/y1Qcbf8geYAl7zXtCoMPM8YZQcqrWIaJJYxv0m49TvLujEOKUCuIuwOB5OFbsmEC6hAShbAKrkAf/rzrIP0eHrd4paIApUW/+1wBW4sdB0mE67q4qF9zEQ96/zFlc8St1C8CDU0MEZeaY0kHg69OqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JAEX5aG79SQ+8qX/uPFuDpueISisOqkNj0wzt1eU68w=;
 b=d7NTVHW2XiaIGcvONDBHHBTTDmzNPTAl0IY/e+YFi2AwsxbL4Fc/tCqLAAsYNY+qPdoWTyGjRB9vRkPzmARMX2zCiMsayrBhXcOhToE8/PJUGTMuvdZB7EDRmxZNlPh1B6hdXPCcSni+S0I0VdH94SJBI59L2o1FZypHtBF/gDg5xNfXlkIBFfvP3bP73w/w/fWa9Wf6ifc4FJVQGsWo8PzxZdYhBRRrYGija5kWkDr+KWZrjDBpw2599dAXaEACTNjqLDNJ00R4ILhqJHekzKy/PFR2XEjLNPcPGxa9s3BA+PgWXBsjLRiRYGjGsS04wt9JSGhMSGRAmEyEZG8bGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by BL1PR11MB5446.namprd11.prod.outlook.com (2603:10b6:208:31e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 02:41:17 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::56a8:e9c:284:f6a8]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::56a8:e9c:284:f6a8%7]) with mapi id 15.20.6477.028; Tue, 13 Jun 2023
 02:41:11 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, =?utf-8?B?VGFtw6FzIFBhw6Fs?=
	<paal.tam@gmail.com>, "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: Set irq affinity from a user mode task.
Thread-Topic: Set irq affinity from a user mode task.
Thread-Index: AQHZmqacZH8yjUa55UKgB6Rk2LuItK+GYZNQgABvWICAAS3vgA==
Date: Tue, 13 Jun 2023 02:41:11 +0000
Message-ID: <MN2PR11MB42858F2D30FEE5C28D9A8970F255A@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <CAH0t8y0j9zdJNo6X9SfsYGAJx2WJiGtvw866EgqMnRQwB0pOvg@mail.gmail.com>
 <MN2PR11MB4285E1DADCE543CF4966F4D2F254A@MN2PR11MB4285.namprd11.prod.outlook.com>
 <28fd5233-3dcb-8860-55d9-5eedc0b7e4ca@siemens.com>
In-Reply-To: <28fd5233-3dcb-8860-55d9-5eedc0b7e4ca@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|BL1PR11MB5446:EE_
x-ms-office365-filtering-correlation-id: 3e5dc79e-60eb-4839-3660-08db6bb7a60e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2Zn5NZuwVYcpGV1Q8BuwPCtu8nTgp5usgQKHDbFpihmaFEoaKjlmrcLuxADtSbm3tKo65uORFxu2vvje3GuMgpj4D2bLIjPnjmlPOlX/o1L85B7e7Mp5prbTPbDZEzr1JL508PxVlNdgmNUoSQ3p1xuPrvKC9Uz6l/uXBDeT9ViFix336XU7YC+ogsFlD4md9XqSJ4+x3bs5ltbz28cEqadf3MN7gNNPXE6OBNQS50RmC+DDEvu/JZRahkscXqVgfNdWObyqtS610RAjcR04Ym56/XltbFtYslK4q2ZBVa544AUcIT52+eW2grOFIUZA7dYyCj9yDszcft7paJ/8pbR6010lfV63fzYX1ClZxcaUDwoS0ZArXnsOUjf00L7JJ/XMJbMn0RhU5x7wcrJOgSTPcy084djPHE54cbel+3bPgm+Tvm996NJCOra09GHChAnogIr8d47pwBt0rEowgN2pTR/llEt0DTk+eZX9Tcr7CuwoYcTvY3PfOCg9Tv6MexHdLoHHKvliHSgO6+UteqDByapnMJWv+XFL5duVtTTDGDTyos3RYlzL0HY/xpNChpif+dGNd8ccKI8dMFC5Dx0jVs8TzrQPVisEvVnCnk4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(39860400002)(396003)(136003)(451199021)(86362001)(7696005)(316002)(8676002)(41300700001)(82960400001)(5660300002)(83380400001)(26005)(55016003)(38100700002)(6506007)(52536014)(33656002)(71200400001)(9686003)(8936002)(122000001)(38070700005)(66446008)(66476007)(64756008)(66556008)(66946007)(76116006)(478600001)(186003)(2906002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wlh4WDladi9pSWFzTUtNRlVJZlFYUTMvcGxUa20wWmVQKzhZT1dRKzZxaUpG?=
 =?utf-8?B?cDZMWTZ6MUd4OW5sQ1NzcG45bWJFdFBQR3p3R3FZTnJ1RGRRTTFvaUthdHgw?=
 =?utf-8?B?YmY4b0d0RVQzeDAxcW9PVkc0aFZ5Nk1ET1h1YjBJRklGdEljWE5CZUdua2E5?=
 =?utf-8?B?c0RXQ0lTZEhiRFVJcFVZSG9sNmFVb1dndWRGL3pIUjczOFlZRVFYUGJwN3lB?=
 =?utf-8?B?dk9WeGhBQ0xpWW1ibWh5VUc1NHZwQ29sbUdYaS8zNENIVWFIMjVIOTdreVBr?=
 =?utf-8?B?anI5Z1dLN242RHl5SXhlVjVZME83azgvR0JnZ3M5ZU0vUTFHcW9XWUpHWjFE?=
 =?utf-8?B?enhURVZrYVhIaGdCcThKR3hZZk9uTjlXUnV4dkFUVFpZbkZ3TjBnUlN3UjVt?=
 =?utf-8?B?cU9EMVVlU2pjSllSdDYrd2ZSUzEzR3dqb2dOM2ZLRFJNOVFzMW5WMWQ0TlNF?=
 =?utf-8?B?L3ErdmxYOXA0cEVlNDcrODdJcDd6YVFEVVYrQnp1czB4cUZ5TjhZM2hJQ3dE?=
 =?utf-8?B?M3A3S2tzaHdFV1dEbVpTTk5CbTlOcnJ3R2dOSlAyS0N6Vi9sbWt3SE5RU1Bx?=
 =?utf-8?B?WUZNTkpKb2JyQjZ0ZVRrQWw5L21DbXp5Y3U3RWROZ3JmUDNVMU5zazZsTU80?=
 =?utf-8?B?Tit0clhOUDZ5VHg4bkNSTEZVa0pLZlFiRWZQUHV4d24vZG5WcGF6bE1oSTFv?=
 =?utf-8?B?aFdLUVd1RGY4MUp1ZmtCZ3U2QlJaTG9Sa0ZrY3pxc3FzcHJ2WnFDOWZFd0Zm?=
 =?utf-8?B?VWNMYWpvdFM3dlVVNXlVVWdOdGZ3NmovRnB3UDA2RzNobTJ5OFVINEFTK2p2?=
 =?utf-8?B?UUxVNVo0VTNEaHBLNFVlQ0ZBUVlVK2lteVpIWkdTYjlGWi9BMENjczk1RUVj?=
 =?utf-8?B?eURuek9YZjFNUVQzTHBwVjdHa0VoZDdaUHNkb1NEdjduMmt3S0pkRzYwZ3U0?=
 =?utf-8?B?anhEVXp5dXZQbGRTMldOTENMSk5VbGQxVHFmMG1QUzlXajFqQWFndmlGY2pU?=
 =?utf-8?B?K1hkaXAyaHNjLzFXdmxSNUpZQnk4bXpkVHpUVEhPeFJtZzZVMjA2TVFDRkgw?=
 =?utf-8?B?dEs3bFpXUTdITHEvOTI0YW9IcEVMWXdTT3MrNFRvYkZ3YmhlMUdmNFBNTERt?=
 =?utf-8?B?NUpSVmpyY25qaE15MWFHMUI1SldlQml4ZjFiNjk0SWwvL0xrUmlTZ1Y2N3pR?=
 =?utf-8?B?QWlFTTVDTTFJM0lOVUdSbkJNekpUUDZFTkpJR0t2aldqNEhVcG5xRzM4ZTRz?=
 =?utf-8?B?V05FV1lHM2kyc2F4enpFYld6bVJUNVQ3UXJud0Y3akl1TjV5SWZnTDRMOE0y?=
 =?utf-8?B?Z29ZM0JzdkhFOHhxQ2l3aVJmUCtLakxKS3RWYjJCamtkTjNabmJ0enRxZDAr?=
 =?utf-8?B?akJ2c29pYmNnd3lsMGdDVUI0YXBXUFNYZHllNkpiSzNGMmRXamdwemxCdkpl?=
 =?utf-8?B?Wlg4M1IybDJ0aFNQS2lMRlNCT2ZtQUlWWW93NzB4R204YVZHY1JXd21JSnRS?=
 =?utf-8?B?S2M1blRsWTlQRWlDNDIzeWtIQkNHU1Mxa3VLblNJdHUwVUQxb3FQa05CZzly?=
 =?utf-8?B?aUhtemlWNmkrTWlGdVdabndBVEo1bDFCWFVwSFh5YVhac0toaGpxNE5PUVVN?=
 =?utf-8?B?Q1JpTDdzQmdHYkhiOFZORWtyeXZTa0UrNkxkaGZZa3lFOE0xUUk4bHh5aEgv?=
 =?utf-8?B?b09yOU50OWNrdUgrSkFPaVdSRDFoMlQ3b29laTJVd3F0SW1zYTRPV3VsTGow?=
 =?utf-8?B?dFEzTXU1NVdabzNNZVFQaGVOU2ZTU21SVjJmN2pHOVhZZ1lLdzlxN3hEUy84?=
 =?utf-8?B?dWVEdGluTTZQOHpyRG55TmJudnVJdlFHcmJpTHZmUGdvVkZrWDcvVmk0OHNk?=
 =?utf-8?B?L1h3eHhQRm41Sm9pU0o0am1raUcyOFdqVmRCeW5BVkdMSkowcStCRDBkenNz?=
 =?utf-8?B?eGFOMlZyVStVblJwOTcyVE9RbXlpdzZxcDZmWGJPNzFuTUxWRG1ZZm8vbE5S?=
 =?utf-8?B?UUppU01GQ1RKTnh0U0FWMWpLOUNNcCszcE80RmZHWlBHVkRxVy9PaitaeDRk?=
 =?utf-8?B?MkdGQnk0YUNnRGhZQU9MWUVWMjBhWFd1UElNVStsQ2R3MGlxb0I5cDFYeTBx?=
 =?utf-8?Q?XOzAmQgJqSekrzEot3N94kV9J?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e5dc79e-60eb-4839-3660-08db6bb7a60e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 02:41:11.2026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d/hLSn9wNXUt58Zu3k5/yJVBhaJNnNQhTKc6Lwl2VB3EAvUthwHTMLRToMw3bxan2ouuTUiPBdo5tkVu7ubiCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5446
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEphbiBLaXN6a2EgPGphbi5r
aXN6a2FAc2llbWVucy5jb20+DQo+U2VudDogTW9uZGF5LCBKdW5lIDEyLCAyMDIzIDM6NTQgUE0N
Cj5UbzogQ2hlbiwgSG9uZ3poYW4gPGhvbmd6aGFuLmNoZW5AaW50ZWwuY29tPjsgVGFtw6FzIFBh
w6FsDQo+PHBhYWwudGFtQGdtYWlsLmNvbT47IHhlbm9tYWlAbGlzdHMubGludXguZGV2DQo+U3Vi
amVjdDogUmU6IFNldCBpcnEgYWZmaW5pdHkgZnJvbSBhIHVzZXIgbW9kZSB0YXNrLg0KPg0KPk9u
IDEyLjA2LjIzIDAzOjI4LCBDaGVuLCBIb25nemhhbiB3cm90ZToNCj4+DQo+PiBJdCBzZWVtcyB0
aGF0IHRoZSBjb21tdW5pdHkgIGRpc2N1c3NlZCBzdWNoIHRoaW5nIGxvbmcgdGltZSBhZ28gYXMg
aW4NCj5odHRwczovL3hlbm9tYWkub3JnL3BpcGVybWFpbC94ZW5vbWFpLzIwMTctTm92ZW1iZXIv
MDM3OTE0Lmh0bWwgLg0KPkFjY29yZGluZyB0byBkaXNjdXNzaW9uLCAgaXQgc2hvdWxkIHByb3Zp
ZGUgZ2VuZXJpYyBBUEkgdG8gc2V0IGlycSBhZmZpbml0eSBmb3INCj5DQU4sIHJ0bmV0LCB1YXJ0
cywgU1BJIGV0Yy4gQnV0IEkgY2FuIG5vdCBmaW5kIGFueSBjb2RlDQo+PiB1c2luZyBydGRtX2Nw
dW1hc2tfdCB1bmRlciBpbmNsdWRlL3J0ZG0vKi4gIEkgZG8gbm90IGtub3cgd2hhdCBibG9jayBp
dHMNCj5pbXBsZW1lbnRhdGlvbi4NCj4NCj5Tb21lb25lIGhhcyB0byB0YWtlIGFjdGlvbiwgSSB3
b3VsZCBzYXkuDQo+DQo+QnV0IEkgd291bGQgcmF0aGVyIHN1Z2dlc3QgdGhhdCB3ZSBjaGVjayBp
ZiBEb3ZldGFpbCBuZWVkcyBjaGFuZ2VzIHNvDQo+dGhhdCBhZmZpbml0eSBpcyB0dW5hYmxlIHZp
YSBwcm9jLCBqdXN0IGxpa2UgZm9yIExpbnV4IElSUXMuIE1heWJlIHRoYXQNCj5ldmVuIHdvcmtz
IGFscmVhZHksIGRvbid0IHJlY2FsbCBBVE0uIEluIGFueSBjYXNlLCBJUlEgYWZmaW5pdGllcyBh
cmUNCj5nZW5lcmFsbHkgbm90IGFwcGxpY2F0aW9uIHRvcGljcywgcmF0aGVyIHN5c3RlbSBpbnRl
Z3JhdG9yIHRhc2tzLg0KDQpZZXMsIHlvdSBhcmUgcmlnaHQuIFVuZGVyIERvdmV0YWlsLCB3ZSBj
YW4gbW9kaWZ5IC9wcm9jL2lycS9pcnFudW1iZXIvc21wX2FmZmluaXR5DQp0byBzZXQgaXJxIGFm
ZmluaXR5LiBJIHZlcmlmaWVkIHRoYXQgaXQgd29ya3MgZm9yIHJ0X2lnYi4NCg0KUmVnYXJkcw0K
DQpIb25nemhhbiBDaGVuDQoNCg0KDQo+DQo+SmFuDQo+DQo+LS0NCj5TaWVtZW5zIEFHLCBUZWNo
bm9sb2d5DQo+Q29tcGV0ZW5jZSBDZW50ZXIgRW1iZWRkZWQgTGludXgNCg0K
