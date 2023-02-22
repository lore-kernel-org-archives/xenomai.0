Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA861C17
	for <xenomai@lists.linux.dev>; Wed, 22 Feb 2023 05:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677044108; x=1708580108;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=k8dS3k1U8JgtEX9Gb3nxa5i2zH02o4Mb5CRxcTPy0Fk=;
  b=Wooz6DrYCS70g/Imkf0Ph3Nf7rO7L3ZRgIQsnh8FCI2TSE/RVWOmQZpF
   2M/zhEAnMniV9ouZcAtbAveXLox2R1qoHdThPHH/G1L6JUp5JoDwa/niz
   gvGpg0+8x72kdjkjQt/JKUCJnp2TKA39kPMPV0GPODG+IDuXeDpY0gToT
   jZy/MZJ5ieCMmiuBgJTRHfxavV5nfSx29DAveeio/2DWumraM3iDHrEu9
   g5vzZ8MWybJMacrphHXQgftqbHpLWpakKTqelZpYZ5QievAkLsMn1sCf4
   kgwLNXprG2FU+tw4t3WWoALA6O5Pmiz+BDgagx6yBSTcrMKRIZG8O0Bl0
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="395322741"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="395322741"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 21:35:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="917451069"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="917451069"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 21 Feb 2023 21:35:07 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 21 Feb 2023 21:35:07 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 21 Feb 2023 21:35:06 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 21 Feb 2023 21:35:06 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 21 Feb 2023 21:35:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQBdQyJo6oxpUqMjy/Z1ktLeQe9ORTNlRv0+nAqjtLUVRBzJpR48LakqO55g+nK8nqmhRpsTFbP8AJC2/OWZMpL0pE4PNVdvN0Y6jJZp9Hefpld49fAeXQUfNa6bOCLjTRWPiOi5Uii8NniOod23aCoAcQYcmWFR9uh3LDSbn8vT7IQ0CW3wS9wU6chaDNFXO/F0LemNIrd9CjItetRppfn+sXTQTveoKdIs+lgMVEXx7BEhUtJsOcBn4M4YPnYcoYj+orBTbcIZH2ruTP0yhK7VlE4UXqQ3fdobGckx/spjkOhwMgkT6pRZ9lLvm+YVG2ZM8HCjSmCDum+RNDYE9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8dS3k1U8JgtEX9Gb3nxa5i2zH02o4Mb5CRxcTPy0Fk=;
 b=n/bQTseFt+iQfuZ/68s5GCV4ogC27lJhC2dwc4oeahjhqZhxeUC1vQYvXuMR4X4r1LZWOvx5L89exabltvemw04r/UnTFRODiW04o6YjJuNxcCuAEhtKP4t4X+Tkvg7AjhguGTSYBdSQ9D2VMk0UQy1dAv9k4rvHpnCN7Ea9oMfKV5HVNrnmR5goVciHX3Tiv5wMX41Z8k7OE/yz6lqG57mBaaBt3VMrIaqR2wVMz1dBexdW7hdenU7sdBZMotn+QhJ38HRddrq2kMOnmfPv2mpoxWFQirZlAfkAGsE9ofa7B9Ej+48N6HHiP/WVQWxgA2ojFvNR3165E/77/RC8VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Wed, 22 Feb
 2023 05:35:04 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::a906:2493:ed48:e0ef]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::a906:2493:ed48:e0ef%4]) with mapi id 15.20.6111.020; Wed, 22 Feb 2023
 05:35:04 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday,  Feb 22, 2023, UTC
 7:00 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday,  Feb 22, 2023,
 UTC 7:00 AM
Thread-Index: AdlGf2H+YS2O1NR+R+qUsOrFM6zBrg==
Date: Wed, 22 Feb 2023 05:35:04 +0000
Message-ID: <MN2PR11MB4285351FE537359D3DE4DB88F2AA9@MN2PR11MB4285.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|MW3PR11MB4684:EE_
x-ms-office365-filtering-correlation-id: 66394e8a-f2ed-489f-0668-08db14968ced
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mYpolmzznjH+RiTtLS97cjp6Wn8YNO/JiHjnaw78TK1CEfGls74XmRAXFVHQ03yE5KDItGZqB3bHD51HagcVmScKfIhSoEeKeY06zgXrvas0vYblsr99Ss9SoFxdm8ECSKrSJnYOkKfft3PPFKGqCzbgnaq3ccpPkr4c/RaAkojNQ8vMbZ3IuYgrWqaXVFR10qnKGBEzzVcWoRMVP4xlcOqo1E5b+7aYmuuh+/jPXqlyDP5YfpXLgY27iG4v5Dw979U49G8hDu03Cqk/ypEBftvcpo9H16cgcpJbk6/O4cnQp6vYvbPuK2MuaOh3iEegoI1Y7pq/VYXEXe3/7Qhzd7YmZ0buebCfih2AkxYll1Zwm/+0SrUzA+QKO4Sa0N4badATr5F5+0F0t/LWcOalvGc2Ii0+s05Wr1psG0VbL+aTbsxj62ZPDlK2nz/y2+onZwBL7QuGdvTNqrOx5okvUkMvDeOEYkYXGtBIWOeR2N3snlBfy50VJAWCmfwwWrZOVmiHcpvIstn2IV6hYOsphx/VrcawqC0fSOhJxCNgkJN8yjgJ0jrwwhoqJVHff9VyoxFRE9ByhBLA0j7NWJdLHU0qdV+BTbDQnzXmnv0rzcVlTFXmmaMnUZ/4OA9GJ9L/O6gZn09bRSIA8vd5eWZOUPv/UAKftPtmKn9S+oe06gck+uC7YkFXTixpE2X59cMWDTo/samfGW/OueSlq3hf5wK9ThLceQQ6MppMX8lrK98=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(136003)(39860400002)(376002)(366004)(451199018)(6916009)(83380400001)(38100700002)(5660300002)(33656002)(55016003)(2906002)(122000001)(86362001)(8936002)(40140700001)(82960400001)(38070700005)(6506007)(966005)(478600001)(7696005)(186003)(9686003)(66946007)(52536014)(66446008)(76116006)(71200400001)(64756008)(66476007)(8676002)(66556008)(26005)(41300700001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mng0eXVLYk9pbk81bXRRY2dETWN3bnpIUmZvUTdpVFd5K1pxcHVLT3ZHOGhV?=
 =?utf-8?B?akFLRVRHSTFBUDE5OE5GaWNva1pUckVrU3dkTjhxeU1ZY1ZlMVpQL1o3QjZW?=
 =?utf-8?B?WE9McVZobCt3WFVKSjVKdGszdEtsOHlhVEFlZDlvcG5WK2pIY0dkWVhpOHpn?=
 =?utf-8?B?cnRqbHVmVHl4QkJkamttRWJVbmpMRTYxSlNJbkgxUlB3VzVPU2ZIRC9KN1FI?=
 =?utf-8?B?azMzRlQ3dHd1V1NSZ0N0QXRFOW11R0tYOCtoSnJsOFNCUFlqQUlteWVKY1c1?=
 =?utf-8?B?bmJkZnhDZDlDM0NwZlJnNHVZUjRRNmFoQUM5MTEwTkNSb2xhUE91eTduZGh0?=
 =?utf-8?B?RjErOGljZmFlNlBmUmpGeUljMXMwMndoS2RvdkwzMWNIb1hRZkZpMkoxR2xC?=
 =?utf-8?B?bGVUWWlJOU1mNmJvbFhVTEtSWEU1WU1HblI0ZC9UZUxaUHlTZzlvbWs3SXJD?=
 =?utf-8?B?N2RvSWtHdUl6VEpmZCsyaEQvU01FV3JJV1VkK3RTK1pMeEtwTThZZHQ1YUdN?=
 =?utf-8?B?UXVuc2t2cWpyQVBzcHBjSkFhSzN3ZlR6Z0txaEN5cmwrK2YzbXZDTXlwRjY3?=
 =?utf-8?B?Z2x0bTUxVzFXeUM5WDFqQzZiaTZOR3lWTU5qRjV2TWRtVmJtcXF3M3hZdUhR?=
 =?utf-8?B?Nlp1MFJWd1NoeDUzRmRpQzJvblJ6d0FoYmFqbHBIbkRITkpZT0dVL08xMlhX?=
 =?utf-8?B?cjMvT2txeEpuaTZBS2N3KzNOSEtsazgraklWSmVMdGtBNmRtUVlJMXF1a3Vh?=
 =?utf-8?B?cnpMU1RqK1lzbkY3MjUyaGlkNXZOYmFFT08vV0tqN1J5UEs1SGhTUkk4UElI?=
 =?utf-8?B?SjFlVkhhSjRmSHU2TzNNMmplUVlWN0dKWThsaFQxdVZBR0VOcmUwenhqNENn?=
 =?utf-8?B?bEdxUUkyNnV3UTJXRjNXNXVqSnZzRkhSaHNHdTdIb0ltVVhnU2EvNUQrQW1v?=
 =?utf-8?B?eVJIMURqOVlaK0JrVGNiVXZxaXlvY0VFVEVvcHVvVitIQTRlZ1JrUlhHbTM4?=
 =?utf-8?B?K0IzQkxkcFptQWNMbnc5WjlwVjhIcjVjRkorSE5KZ0dhQnV0dEswU0gwbTlU?=
 =?utf-8?B?elVYdXhBYVZ3SlJqT2NTd29oNzVERTRxQjhVbmZMQXZsSUM0SWhvdEF2VndC?=
 =?utf-8?B?d3I0dkUxeEhUMGhUQmMxZDRudzV2NTJTVlhqVWtGcXR0TUtHNXZrMjYzekYy?=
 =?utf-8?B?WVU5Y2ZQQkpyNXNhQVMyZ21QUnoxRUthdGh4TnJzeFlDdFFFcVNUOHZXM1R2?=
 =?utf-8?B?ZlZyVDRVMWlPTW9IbDViYnE3NHVLaENtQ3c2WEwrWUFmdXRhMU5aYWZUZ1Ey?=
 =?utf-8?B?aE1BNExWRG1yMmY2bkozcGR5T280ZG05WFVUSzIxR2tIb01sdVcrUTk5bjhW?=
 =?utf-8?B?RkY3Rk1pMEt0MGdGNWxQT3M0alpNb2I3MldQODFvTm1MemJYRUxsRUhrNkRr?=
 =?utf-8?B?OXdGVDZ4WXlUVmZYcGwvYTMwTmsvcGtSVGVZY3BMVGo0SUlJQ1JaSURuMExH?=
 =?utf-8?B?c2x5QkJ6RWU1ZTl3RXF1MDQrQSt0c2RSYTZNS1JudURaRWUxNTZ6Mis5MWNl?=
 =?utf-8?B?cGJEeGVreW91SFlZcjZCd1lKS1ZFU2phYnZKTWQrNWhQdHFOMy9GK0kxT2hl?=
 =?utf-8?B?RklLUHNEdmh6cHFzd1E3d0tKUlJqNGVHcURhSTg1Q255OUJZT216eG5wWmVE?=
 =?utf-8?B?QUt0ZnVLWUVaejFZK3AwVHFNK0pqRXlBZEt1K1J5Qmxod2g1ODJ5TnlHd1pI?=
 =?utf-8?B?REtiVHNFOEpDb2k3SzNiK205UjByZHdCbG02aWV5OHdQMFpXMDVpRit3VG9x?=
 =?utf-8?B?aVBCWVEvMjArRXl6Z2kzVzBjMzBqK0RMdmtGdkhnQ3Y0YU00ZndIVGE1OCty?=
 =?utf-8?B?QkVaNnlETmFRSnYvdnpaVi8rQWdYdmwrSURUNXF6QmQ2V2ZsQ1JFbXZWYk8v?=
 =?utf-8?B?Qk43NWUrazJLSFJXczQ0VlZLcTQ3M2JpSm1vQ2szUDNlMmU3Y1ovYktaeTAv?=
 =?utf-8?B?MDVoSlNNdVo5UXRnWS90V1ZmSUk5ekh0YmhDU1J5TXk4ak15Vit0NkdmbHhp?=
 =?utf-8?B?aVVtZ1NzSTN5TVRVYmNGempBSm1mblpXTG1xUVdmS0hqb2JlU09jU083SnlG?=
 =?utf-8?Q?QMPF3JeAKICWvZXINKQ3s1XW0?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 66394e8a-f2ed-489f-0668-08db14968ced
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2023 05:35:04.4582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mitz+7DKdDAn2kFI8QdtCkkln5fxXMqZVsyOQEJRGZ3hff2JYLGXJHZE/cE57reYuyxQeFQ0U6vvJDvyC6vGfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4684
X-OriginatorOrg: intel.com

V2UgaGF2ZSB0aGUgWGVub21haSBjb21tdW5pdHkgY2FsbCB0b2RheS4NCg0KVG9waWNzIG1heSBp
bmNsdWRlIGJ1dCBhcmUgbm90IGxpbWl0ZWQgdG8gdXBzdHJlYW0vZG93bnN0cmVhbSBwcm9qZWN0
IA0KcGxhbnMsIHN0YXR1cyB1cGRhdGVzLCBhbmQgdGVjaG5pY2FsIGRpc2N1c3Npb25zLiBJdCdz
IGFuIG9wZW4gb25saW5lIA0KbWVldGluZyB0aGF0IGFueW9uZSBjYW4gam9pbiBhbmQgYXNrIHF1
ZXN0aW9ucy4NCg0KVGltZToNCldlZG5lc2RheSwgRmViICAyMiwgMjAyMywgVVRDIDc6MDAgQU0N
ClBhcmlzLCBGcmFuY2UgQ0VTVCA4OjAwIEFNDQpDaGluYSBDU1QgMzowMCBQTQ0KDQpKb2luIFpv
b20gTWVldGluZyANCmh0dHBzOi8vaW50ZWwuem9vbS51cy9qLzkxMjk3Mjc5MjY5P3B3ZD1XbWR3
UzBwRE9EUk5NUzl0UWs1NFkxZHZiRmxxVVQwOQ0KT3INCmh0dHBzOi8vaW50ZWwuem9vbS51cy93
Yy9qb2luLzkxMjk3Mjc5MjY5P3dwaz13Y3BrNTJhOWY5NmQ5ODllN2UyMGI2MjhjMmMzNmU0OGI2
OGUNCg0KTWVldGluZyBJRDogOTEyIDk3MjcgOTI2OQ0KUGFzc2NvZGU6IDM2NzUyOA0KT25lIHRh
cCBtb2JpbGUNCisxMjUzMjE1ODc4MiwsOTEyOTcyNzkyNjkjIFVTIChUYWNvbWEpDQorMTM0NjI0
ODc3OTksLDkxMjk3Mjc5MjY5IyBVUyAoSG91c3RvbikNCg0KRGlhbCBieSB5b3VyIGxvY2F0aW9u
DQogICAgICAgICsxIDI1MyAyMTUgODc4MiBVUyAoVGFjb21hKQ0KICAgICAgICArMSAzNDYgMjQ4
IDc3OTkgVVMgKEhvdXN0b24pDQogICAgICAgICsxIDY2OSA5MDAgOTEyOCBVUyAoU2FuIEpvc2Up
DQogICAgICAgICsxIDMwMSA3MTUgODU5MiBVUyAoV2FzaGluZ3RvbiBEQykNCiAgICAgICAgKzEg
MzEyIDYyNiA2Nzk5IFVTIChDaGljYWdvKQ0KICAgICAgICArMSA2NDYgNTU4IDg2NTYgVVMgKE5l
dyBZb3JrKQ0KTWVldGluZyBJRDogOTEyIDk3MjcgOTI2OQ0KRmluZCB5b3VyIGxvY2FsIG51bWJl
cjogaHR0cHM6Ly9pbnRlbC56b29tLnVzL3UvYVRFQTM3aTVHDQoNCkpvaW4gYnkgU0lQDQptYWls
dG86OTEyOTcyNzkyNjlAem9vbWNyYy5jb20NCg0KSm9pbiBieSBILjMyMw0KMTYyLjI1NS4zNy4x
MSAoVVMgV2VzdCkNCjE2Mi4yNTUuMzYuMTEgKFVTIEVhc3QpDQoxMTUuMTE0LjEzMS43IChJbmRp
YSBNdW1iYWkpDQoxMTUuMTE0LjExNS43IChJbmRpYSBIeWRlcmFiYWQpDQoyMTMuMTkuMTQ0LjEx
MCAoQW1zdGVyZGFtIE5ldGhlcmxhbmRzKQ0KMjEzLjI0NC4xNDAuMTEwIChHZXJtYW55KQ0KMTAz
LjEyMi4xNjYuNTUgKEF1c3RyYWxpYSBTeWRuZXkpDQoxMDMuMTIyLjE2Ny41NSAoQXVzdHJhbGlh
IE1lbGJvdXJuZSkNCjIwOS45LjIxMS4xMTAgKEhvbmcgS29uZyBTQVIpDQoxNDkuMTM3LjQwLjEx
MCAoU2luZ2Fwb3JlKQ0KNjQuMjExLjE0NC4xNjAgKEJyYXppbCkNCjE0OS4xMzcuNjguMjUzIChN
ZXhpY28pDQo2OS4xNzQuNTcuMTYwIChDYW5hZGEgVG9yb250bykNCjY1LjM5LjE1Mi4xNjAgKENh
bmFkYSBWYW5jb3V2ZXIpDQoyMDcuMjI2LjEzMi4xMTAgKEphcGFuIFRva3lvKQ0KMTQ5LjEzNy4y
NC4xMTAgKEphcGFuIE9zYWthKQ0KTWVldGluZyBJRDogOTEyIDk3MjcgOTI2OQ0KUGFzc2NvZGU6
IDM2NzUyOA0KDQoNClJlZ2FyZHMNCg0KSG9uZ3poYW4gQ2hlbg0K
