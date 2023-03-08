Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864B97C
	for <xenomai@lists.linux.dev>; Wed,  8 Mar 2023 01:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678237948; x=1709773948;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=wrDozFKbyfQ9Bw4oHEHMM15GxudUpeQyqdKQXJjzjgQ=;
  b=Qw1L/KilmFIEJlq37kFb60G4ShE/rt1RpZd7y/YlIYv998ikTJz+ho8u
   u/OzHF72CcovtTYlZXGeUQkPeC+dyBXOipwVMBWltMmX2s4BxSWgFp/bB
   gpE4d+fSXSdZCccfS2SNYWGNbZfQGlE20W8q6XGWYZWpzCmN6qL7H+9OD
   i5wSWxgoPjAaExPJz3x0+Ps+2BVaCDXDLn+qVOBAjZZIAv3zeV3/6F/Ur
   Ys1zOVq64gpm7cQ2rWj9Axp5TKaui/tSI4+b9ZzkC5qxHwCbnZ0eZq5VL
   fA0I5vEln60LL1wqDXlktMVGsyf1qG7xHX1Gmf2z4ucCICaDYHq1XXNRb
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="337539281"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="337539281"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 17:12:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="819990258"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="819990258"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2023 17:12:24 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 17:12:23 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 17:12:23 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 7 Mar 2023 17:12:23 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 7 Mar 2023 17:12:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6/xW45eKLbK0K0opRpz/U82DmkK3uUac7LJGNVD2AKc+sIZDqLghQLirJy7cl0ZvE0/4GmXnets9oSNUXNN6q1cduAgU5FgBawJri5VCC/B2D49/5fmLEubjPnR5enEkra03siaPb/ipvWOBiFPwAMMkwsY2mXTYoQ415Hfo44ZB++ysii5DsgveBLaczUGcHc3vYTXR3WyemhT+h9FoglampdmQodzJqDIa2Nt7YP7M+mWGvQhB4QMjsJ4SMbVI5TEltZXKu311oTBfW0PSBi8pAlm/JJ6550ozn26pww3EqaT/Jhng7CQTqA7Ih9Juv/kkuYp9x5cTLk94SBaSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrDozFKbyfQ9Bw4oHEHMM15GxudUpeQyqdKQXJjzjgQ=;
 b=GyvbF3s3wqYeAay1GN1rF7FlVE0jRrcPUBWwyNu74PQ3/n0dBJ304PggoO7k+09RO3aMYwZz5+YE+k0aQm8ga0dcfcQtqFNlgHBCu5qStsD/Bh1EUJk4stg//OWc9ewepzxABly1qy1Ca0lWGBKHyMs5zYuOol5aJiGtqDz9ZosLCoKcCa0KTHBj1O8axerdiWYXoeIXbf+UjVQD2d6ZjzzHl5kHmr679QAPHXBbXrITY41DrUpM0ZAjairiMZV27Y+CugQgBDgLGjK2DwMeddYx3qfu1IUtyjTG5cw4K63Xr8SNNb7nBdPKEkGQfb8oKQAchmbM5FcsSY92SX8k1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by CY8PR11MB7338.namprd11.prod.outlook.com (2603:10b6:930:9e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.16; Wed, 8 Mar
 2023 01:12:21 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::e1b2:52d4:e80c:dfac]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::e1b2:52d4:e80c:dfac%7]) with mapi id 15.20.6156.028; Wed, 8 Mar 2023
 01:12:20 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday,  Mar 8, 2023, UTC 7:00
 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday,  Mar 8, 2023, UTC
 7:00 AM
Thread-Index: AdlRWuv36kaNbDhDSjijl5TT3GLjlA==
Date: Wed, 8 Mar 2023 01:12:20 +0000
Message-ID: <MN2PR11MB42851ED30762110B614F12F9F2B49@MN2PR11MB4285.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|CY8PR11MB7338:EE_
x-ms-office365-filtering-correlation-id: d64c12d6-f89e-41e1-6e44-08db1f722adf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nGygmH75U/fbGGEwvG7oGA4fiWSLofpEdpupVvOj8OgUJkGolS5yqKIQ4peddFLZV7NpoWn5SbzKzp6DRKjYLKQ/EpfagpYPZy41cmXwITiPT/DQ7SQ5jy2j3LQDbD0tVcsPH9TtV/uPo3c/2L+i8i3fAlpIanBxp1jycbD/m4iuDOZleyCltFFtvNTjcI/IwX7T+CTd/bWjRV+/JEVHt6583/FmqU8NoUi3WcbLltf4J6QjrxeuA3qvQc93b6EwN3M2KuFWEQuhP1LCbTydr6YtKVSAh5znYss+KUeQdxmFAHrL1e6min28dnQ/MIYgJQ8sKZA+q4+RaH18fFloydPm+O3PF4DVrRO7o/r6jYYAn7icAgnESxQ30JhVRELNnAnmitoGRPXuZAe06r4rCJ1sTQvUJYCKFFpRSHe0hWXXt5nmIsz1yLUSpG3P1890E2SRF4FFdR0O7ww2JSgahjywNbEdOO8v9Zkf5Np2tDlZhy0Zmz7RPIcw/nEubuG6AhvmPMqXRmOlkLrcbFz56Ip1DMzLkdJtZUKJS68KsyytdfIgv8PQS4vrscM88jUCIT9H0hB0WdVVoPuKRg2UTa0kju4xyZIX0Xooa2YW4acsQUGthXyXBb00DaKIku9D1E/+Fr0kdio8xa8PUgZtBC2B+1lG2PdFmOI3dQ5+hkhajUhJizS8nNjACsuW0OSWgs8dia9PYrZVqr1CsyD5tG2xpkGeZMnGX41jo6bTnO8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199018)(71200400001)(8936002)(52536014)(966005)(7696005)(9686003)(38070700005)(83380400001)(5660300002)(186003)(478600001)(26005)(82960400001)(122000001)(6506007)(40140700001)(316002)(33656002)(41300700001)(86362001)(55016003)(66446008)(38100700002)(64756008)(66556008)(66476007)(8676002)(66946007)(6916009)(2906002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TE1TY2dCNWZaQytDdW53Vlhka0tnWDkrWFZUb3d5TVBha2NTeUNNeCtWWlN2?=
 =?utf-8?B?aHBEdldCSy9wRkdoeGNXWlRPOWJIZm5NaW0wWjBuMHpYai9mZzc2VFRRKzhv?=
 =?utf-8?B?N25uVlloR1dnb0MzRXpKSHJhWmdIN1dOMEQwQ0NiRk9SN24xOG1CRkMyT0VS?=
 =?utf-8?B?bEdkc0Vld1JsaUFZRElkYVl3OHVLdW5pN0krLzVYTytkbS85QkpVSTRuQlh1?=
 =?utf-8?B?V3FrYXh2NlpHSTlGSWdBdUp2N0FMeDVVMENuT3FsMDVGQ3BMT0RaZGo0T0tx?=
 =?utf-8?B?ckFiWWZIZzBKemJZaktoR3lma01yQTVaVThEbERyck9WSlc0a1Z0QnJydWRH?=
 =?utf-8?B?d2ZaUjh0TGxyMjNjRDFrelJlRHhwTWozaW9WM0Y5YmlPWXNpMzlpOWlBYVpW?=
 =?utf-8?B?OWM1a3o3UWVET2krV2p1ZTJJQUtvcXBuUFl3eXNJY3VIL21sSXVnU2ZrZ251?=
 =?utf-8?B?WjBoVS9iaGpXQ0ZvVzBTYWhlR0lEU2NqcU41bGc4N2MzVkpISFVHa3VXOHJ0?=
 =?utf-8?B?VVdGaEVrbUk3MkJMcm11b2xtSjlsY21POWdoV0ltcXRDd0Y2ZGw2VjBaY0R5?=
 =?utf-8?B?V25JQnBYVm4wMUZlOEYycjcrN1M5OGQvVFR2OGxKL296NmFUOWR5K0xnZG9u?=
 =?utf-8?B?MEJEZHI2YmpGUUd2MDJOOTh1L2p2Z2pwR3F5MWRtdkI2d2Zybi9RZVpzME5i?=
 =?utf-8?B?Q1d0TnlkM2VsMUpYVTNsdy9GSjNjWGVYRVMxV1loc1RkZktBb01FK295RW1j?=
 =?utf-8?B?QjZPSGhZOXFOZ1hEemRrM0dJdEoyZjBraHFkZElWN01UK2JJd1VLclpNa3ZP?=
 =?utf-8?B?NDRpVE1jRWw2cVM1M2I5SUQxMjNveWZ4N1VhY001MS81WUVOYnNxUVF4QXhS?=
 =?utf-8?B?YXFNNjBTMS8rSW1KR1dQT2s3K0RsYUVXY3dIT2VOMnA2a3pTQU9IVlFiWkJJ?=
 =?utf-8?B?azFtZWVBaWRkMTBjaWt1L0g0OEVNYktmQW1GQ243WldlOVlTWDc3cFNFc1ZF?=
 =?utf-8?B?c0o1bGNsa3BleWQvUkNIbWV4VXVKNjQrQzNTampuSHh6R3dOaHUrRFdwZm9S?=
 =?utf-8?B?RmoyVk80VEpRQnJUdzRkZjNjbldsazVLWURCTmpOTEtVdDRRckxGaHMwWHkz?=
 =?utf-8?B?VEZNbzlZb1VFN0xTRmxLc2NteWIwUU90cGRwRVFSRjFIaDFHZDd1ZVFaTHNI?=
 =?utf-8?B?SEd3VXVNRVJadG9tS0Nnemtnd2t0R043NjBPdlFhRXpKWURGWE03dzdEUGJX?=
 =?utf-8?B?eWdPeDBtZ3BFT1R5N1VmRW03NnFrUE1WRHU2ZkZWeEtDYmVwSU9UbUhpcC9O?=
 =?utf-8?B?RFJLZDMrRVF4UkphckY2anFMQk44Rkt2UjdsOTh5enhkcGpzbG54VVlOM00y?=
 =?utf-8?B?SlI0Q3QyRkNodktKNnBMNWNxaDlWUFN6cnRhOTNwWDZTU2lYQWdId0xVWnJk?=
 =?utf-8?B?MGM3clBETVlrdklpeEVPdUZjaGUzMnRiUVRzV1JTb1BteTZwa1gvTnlVTlpO?=
 =?utf-8?B?aGpNTVpneFlER0hVeU9Uak9jODlUSlZTWi9lWjlwWWsya1dJdTIrblNDNFk1?=
 =?utf-8?B?VURuUHdoejlkOUFyWGpvc3RiMDAyVHZJZFNtTHZmK0tPd0JHeUt0TjZFdzhi?=
 =?utf-8?B?MDBValVBdkoyeTlxcWxKdW0yaXowOE53Rzd0WXYrZW9XUVVQSFpHbHpCeGJr?=
 =?utf-8?B?d09BWHJjK1pHOVc2Q3M2ZzJpeW11eEJ4cExlZmI5d2FRUXRHbExpYkVNenow?=
 =?utf-8?B?Q25QUzh1SXVXVmR3eGVvM2RidjIrclVybHc4Nm9sMUR6dnYxSjB3QTdnUllP?=
 =?utf-8?B?YkM2aGxOVElVcXk4REN1dE1OclJpRUFjYVk1Z3dLa3B4dGhmTVJneTNHNVNa?=
 =?utf-8?B?aGhabTExUU1YZkY3NnRuRU0xWUxHTHNZdWpLdHkzek1BZWRqUER3aXpkN3Mw?=
 =?utf-8?B?Rnlnc25LbTNiWXEzWko5ZkVBekF0UlRHVjBWYkJSL2d3ZmY0bGhRcVRNcWFX?=
 =?utf-8?B?enhLZ2VsWW1pUC9MS2dqcTJqY3piQ25ZaUxVdmZFTyttTHNaSXBJZFBydncx?=
 =?utf-8?B?QUNJSSt3TzlXVVJEaTlqcjR1YUk1Rmg2SWpzYXNkVnB0b0JyNUNYdExya2VY?=
 =?utf-8?Q?3b2NgIfGXsgBX/Yui9IrKj4No?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d64c12d6-f89e-41e1-6e44-08db1f722adf
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2023 01:12:20.8763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N3g6qg9BHvvvdz4v1vwy2t1QH5wLx2cjOgQXF6W/OnkuUcqG+YlJMw5WIloJyfg64TiHft5PiK+jGOiDK/7Xlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7338
X-OriginatorOrg: intel.com

V2UgaGF2ZSB0aGUgWGVub21haSBjb21tdW5pdHkgY2FsbCB0b2RheS4NCg0KVG9waWNzIG1heSBp
bmNsdWRlIGJ1dCBhcmUgbm90IGxpbWl0ZWQgdG8gdXBzdHJlYW0vZG93bnN0cmVhbSBwcm9qZWN0
IA0KcGxhbnMsIHN0YXR1cyB1cGRhdGVzLCBhbmQgdGVjaG5pY2FsIGRpc2N1c3Npb25zLiBJdCdz
IGFuIG9wZW4gb25saW5lIA0KbWVldGluZyB0aGF0IGFueW9uZSBjYW4gam9pbiBhbmQgYXNrIHF1
ZXN0aW9ucy4NCg0KVGltZToNCldlZG5lc2RheSwgTWFyIDgsIDIwMjMsIFVUQyA3OjAwIEFNDQpQ
YXJpcywgRnJhbmNlIENFU1QgODowMCBBTQ0KQ2hpbmEgQ1NUIDM6MDAgUE0NCg0KSm9pbiBab29t
IE1lZXRpbmcgDQpodHRwczovL2ludGVsLnpvb20udXMvai85MTI5NzI3OTI2OT9wd2Q9V21kd1Mw
cERPRFJOTVM5dFFrNTRZMWR2YkZscVVUMDkNCk9yDQpodHRwczovL2ludGVsLnpvb20udXMvd2Mv
am9pbi85MTI5NzI3OTI2OT93cGs9d2NwazUyYTlmOTZkOTg5ZTdlMjBiNjI4YzJjMzZlNDhiNjhl
DQoNCk1lZXRpbmcgSUQ6IDkxMiA5NzI3IDkyNjkNClBhc3Njb2RlOiAzNjc1MjgNCk9uZSB0YXAg
bW9iaWxlDQorMTI1MzIxNTg3ODIsLDkxMjk3Mjc5MjY5IyBVUyAoVGFjb21hKQ0KKzEzNDYyNDg3
Nzk5LCw5MTI5NzI3OTI2OSMgVVMgKEhvdXN0b24pDQoNCkRpYWwgYnkgeW91ciBsb2NhdGlvbg0K
ICAgICAgICArMSAyNTMgMjE1IDg3ODIgVVMgKFRhY29tYSkNCiAgICAgICAgKzEgMzQ2IDI0OCA3
Nzk5IFVTIChIb3VzdG9uKQ0KICAgICAgICArMSA2NjkgOTAwIDkxMjggVVMgKFNhbiBKb3NlKQ0K
ICAgICAgICArMSAzMDEgNzE1IDg1OTIgVVMgKFdhc2hpbmd0b24gREMpDQogICAgICAgICsxIDMx
MiA2MjYgNjc5OSBVUyAoQ2hpY2FnbykNCiAgICAgICAgKzEgNjQ2IDU1OCA4NjU2IFVTIChOZXcg
WW9yaykNCk1lZXRpbmcgSUQ6IDkxMiA5NzI3IDkyNjkNCkZpbmQgeW91ciBsb2NhbCBudW1iZXI6
IGh0dHBzOi8vaW50ZWwuem9vbS51cy91L2FURUEzN2k1Rw0KDQpKb2luIGJ5IFNJUA0KbWFpbHRv
OjkxMjk3Mjc5MjY5QHpvb21jcmMuY29tDQoNCkpvaW4gYnkgSC4zMjMNCjE2Mi4yNTUuMzcuMTEg
KFVTIFdlc3QpDQoxNjIuMjU1LjM2LjExIChVUyBFYXN0KQ0KMTE1LjExNC4xMzEuNyAoSW5kaWEg
TXVtYmFpKQ0KMTE1LjExNC4xMTUuNyAoSW5kaWEgSHlkZXJhYmFkKQ0KMjEzLjE5LjE0NC4xMTAg
KEFtc3RlcmRhbSBOZXRoZXJsYW5kcykNCjIxMy4yNDQuMTQwLjExMCAoR2VybWFueSkNCjEwMy4x
MjIuMTY2LjU1IChBdXN0cmFsaWEgU3lkbmV5KQ0KMTAzLjEyMi4xNjcuNTUgKEF1c3RyYWxpYSBN
ZWxib3VybmUpDQoyMDkuOS4yMTEuMTEwIChIb25nIEtvbmcgU0FSKQ0KMTQ5LjEzNy40MC4xMTAg
KFNpbmdhcG9yZSkNCjY0LjIxMS4xNDQuMTYwIChCcmF6aWwpDQoxNDkuMTM3LjY4LjI1MyAoTWV4
aWNvKQ0KNjkuMTc0LjU3LjE2MCAoQ2FuYWRhIFRvcm9udG8pDQo2NS4zOS4xNTIuMTYwIChDYW5h
ZGEgVmFuY291dmVyKQ0KMjA3LjIyNi4xMzIuMTEwIChKYXBhbiBUb2t5bykNCjE0OS4xMzcuMjQu
MTEwIChKYXBhbiBPc2FrYSkNCk1lZXRpbmcgSUQ6IDkxMiA5NzI3IDkyNjkNClBhc3Njb2RlOiAz
Njc1MjgNCg0KDQpSZWdhcmRzDQoNCkhvbmd6aGFuIENoZW4NCg==
