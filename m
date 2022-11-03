Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B20F7E7
	for <xenomai@lists.linux.dev>; Thu,  3 Nov 2022 00:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667436637; x=1698972637;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=4u8Nuqw853E0VJ/bCO7bBWZKA6JXjO7HofPIlbBxVxU=;
  b=OTC/+gJUarS3HBnHqSM2KEPLgyKPs8FJzD2A1AgMQn5HkgI41UYUJ8AA
   JK8ZYjOjSR96+kOKH302JaJw7IMU4VqfTBuHfKnOVfET0+FqMGqw1Pjjn
   N3DCSfaiIHi/Y5H8Ymwp7bHL0oU+bd2KlBq9eqnpgiom5ItgvWv6/jo20
   Sp7dgSNVIGNZZTXRJWvTxnnBcf8TGBCmLfQrScWYidnUQJtyxE/eZ7vj0
   8EoW2lLh+34uecOxR/4QY+HGHLJ+duZ2FkZhHSyB7JGM4ecaIcummKLQh
   o8Y7LiPxqu2rL7RmenGjl8lBcODnb4yF2OGRqjBEAIE2tBYmHs73CbijL
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="292873569"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="292873569"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 17:50:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="809476615"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="809476615"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 02 Nov 2022 17:50:36 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 2 Nov 2022 17:50:36 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 2 Nov 2022 17:50:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 2 Nov 2022 17:50:35 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 2 Nov 2022 17:50:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azby1j7Drk5zaFphS+7NbcQuvCQlfSqdOOBtc9NPaLhIwdxv1LhU/cAsZa5JAXDeF4fWCz4sqz4z5mivo28ItvRRp2CtkPthPvmxtcRtNqTaViehG3xqM5qlOa+eicffs3ObyGkH6lneApZRn9GiSAq9DqGZOdkbaw/w2Mav1H6LTUSD4E7B+YEl6tMo5Hi4QkKGrcrptF54DQRyvvT58WHq5L/JeRiOO7QNYXqkuz3yvfHq+rInGFtvshf0fN98Po5Oxj5EG0XoEGnLG4b/oSl27/odJSOMFUruBGebn9ng/yLtJItV5W+fyG6k/gm1Z5ML7mkfUd3fmgqye9LQEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4u8Nuqw853E0VJ/bCO7bBWZKA6JXjO7HofPIlbBxVxU=;
 b=EYAa//mF9zQQV4jbXXDDEW0v2JaQ5P3YJ0FBuCyO29FMjJrk3zOz4yqLmaRlz9W+aIG5hdO5K9MxmOyfybGeaDCslTCB7XeIR8MYLr9xx03r5vwztcaqiSXHoj7IjTax1q9J+6LouTny+qcr29jUuTt9ac5mSjVyla8Iwx0RNn/7Os1IT/XRNJWRWJdU1h+W7sRbvWjuNER8GrptnhLJJRlKXZcLtSERm/ffG6AmspDDJp9WK39OJO2feEfNM97IH1JBXsyd0zl5VDHtv5UzqcJ6694uKJ0vcraVcUF4CXKno4dKlNQaj0kbCsHwaB18ivvQF4wR2iHN/N9VwM8nHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by SA1PR11MB6736.namprd11.prod.outlook.com (2603:10b6:806:25f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.22; Thu, 3 Nov
 2022 00:50:33 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::27cc:d8ed:9947:fecb]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::27cc:d8ed:9947:fecb%7]) with mapi id 15.20.5769.021; Thu, 3 Nov 2022
 00:50:33 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Xenomai Community Call Minutes - Nov 2, 2022
Thread-Topic: Xenomai Community Call Minutes - Nov 2, 2022
Thread-Index: AdjvHd6w3KLhSvUdSHexbjgUEjq44Q==
Date: Thu, 3 Nov 2022 00:50:33 +0000
Message-ID: <MN2PR11MB4285FB4FCBBCDB852AB97556F2389@MN2PR11MB4285.namprd11.prod.outlook.com>
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
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|SA1PR11MB6736:EE_
x-ms-office365-filtering-correlation-id: c2a61658-8bfd-451e-f395-08dabd3569d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 33koqNevvIlXQec2DYg+D/w3zvPzjKxt99uEmOKOet6RyHLfF2t5CqtJoan5vMyr5PyzQSUVaYA/8By+L1OjYLaY7CqSKg7/RsjGjjUy6Uy7JJQBHSYRowsGbIsp6Uh+tFa6TGsmIh/AXzbpbmlnRfUcYTJxIXD+srelBlEI2QXzGq7fhpDW3cn9ApCy46CyN76/tC1HYgkujnKt+4xUtzWpeJ3lpTEcShXOGh8vn/SsRHVyroSOElLqI9Rw78Xelq4tWb8wG7wbm6EFCnus77GbeJQNTikxB6PG37D025pOUAvQmPxsvBBWK/MoMa7MzcFLnjJRmM2n0LKWRUrpAiD3fsuBtp5x6/SO+YMzNHZbtrZyX0mXi5wuvwiWwemVixIO+ah2uYHMnm2CXLNi4kKO0+4qa+U1sWWsd+Hh+o6KzrXXREQtbMkuqCo0+jxVWxyoJTrcrL0l5PyGcS9CAlAT7LXM31Uia32IWJFTjGTznyQzoOO/VCNTR0CZDqe0yaP1w78gdpAaq4ZGGz/JErqWaxqZY1ziwi36E9EQ9k0Oe1t9KA86SJo84RKe7ci3TVCEv6PN2jon5XAUWFgfSEaTEU0tjzYNatEqu8P8qrOcQrOhFONC4BE7/tXXRGAXRvJ74qvltn/4zFhD9TcdKMOYoSqMJsasmAfsDDROTaHT2C42kaAxHxjLZyxtDzuvbwDUnfwK8z9QTKTQvycP61tBTpn8DGkByJz9ddhihu1t6iiVcqgGlMg/lgFxoa+YuUeAgtAm3tbqrtNW4a9Y4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(346002)(366004)(376002)(136003)(451199015)(6916009)(186003)(478600001)(7696005)(66556008)(6506007)(66946007)(8676002)(71200400001)(26005)(66476007)(9686003)(41300700001)(2906002)(4744005)(52536014)(5660300002)(8936002)(76116006)(83380400001)(55016003)(38070700005)(38100700002)(66446008)(122000001)(64756008)(316002)(33656002)(86362001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkM3bkdUN29jLzZydWhUbFJYMVh3OGRpa04zdGIvb0paUGxLdW0yOE5TVzZn?=
 =?utf-8?B?ZldPYW9FQmxFbEliQ25aNmt1NVZERlFDTGovNTd6c1RJeWlTZnJoV3NRWmVh?=
 =?utf-8?B?NUVNbDQrSUhBVVpHVGlYOXJLeXF6TVZTdGFIb3ZxZlJhQ3g1VW9ZR0gxUW9U?=
 =?utf-8?B?bHF2b200UFFPMWI2bkZHUldRT3A3UnVyWDJrSGUrMk44SUU2bzRKNFplbVh4?=
 =?utf-8?B?akxMcGtEUEgyWHgxcFNPVENLbFlUTkdCeFNvWVVYNm9uTGhuSkMrczJJRWhY?=
 =?utf-8?B?U0xEaWtoWUI2UkdvVzVmWVhycjNTcUxRcy9Xclh4cnZxSE5UanNuMTNNT1pK?=
 =?utf-8?B?K2xINmMyclMxMVFWWDR6RzVic3o2Y0wzS3gvd2RpTStFQVZYQmpjWmQ2dGZ4?=
 =?utf-8?B?VklOQlNWcGdLYTA0Qk1kbGdXdmx4M2hGd1Y0ck9FdWRrSTBKU2ZYZEg4WGZF?=
 =?utf-8?B?V2RGeFkrTHg4WmcyQzNST2RRQlFScEdEaVBEcGJmOU1CWUZFK09wWEZteWFl?=
 =?utf-8?B?SGpLbUFtdTBUMXJLMjVRWVl1YzlMa0w2bE83bGQvd2JkYVBUcWdOMkQ4K2N1?=
 =?utf-8?B?WXhPeVhOY2IvMEhUNEJjM1FlVi82WmZvejVwSkZnL0FCK29HN0NZWHRKSmpQ?=
 =?utf-8?B?TUNpTFFwbEJOcG5KQ2RRTDhYRlp0N3NyR3NuaVdJQkgzOEtiNHpJRDRpckpt?=
 =?utf-8?B?K1ZtV2cxdGFrM3JIcjd5RDdYbGUxK3JiNG9TOG9zMkFsb3pqN0RpQUp6cXRM?=
 =?utf-8?B?N0VsL0c3VkJmMGJhSU5jOHlOemRlYUVPY3laMWgrME5sL2xTcHlBQ2ZOK2NC?=
 =?utf-8?B?SXFlM0VNNGRzaHgrUm1wYnRkTzdBaHZPS3U4enIwWXR5ZEtHNy9SRHZrNXRy?=
 =?utf-8?B?Z0lvSVdyb0NFKzBTOEg1WTc3SVVtUzlIQnNrdHF0Rkx0SnlwSlNzdEl1WElK?=
 =?utf-8?B?aXh6clpML3hVK0hPakU2Z3NsZkQ5ZXlJU0Y4UDc0UkF1cnlVY1c1WkFYS0Jy?=
 =?utf-8?B?VndRd2FXNjlFeXVKZlcyWWk2YXFodHlUZSswZ29BczRnWk1oYytxeXU2d2JB?=
 =?utf-8?B?R3F3a0FZdDlEU3RYcnk1YjFuL3VNMTMwRlVGZ1EvaE9kUFZCQUxRSEhUTHV3?=
 =?utf-8?B?bytqem1oeS9JektjcnBhNnU1QktWcFFvYytJeEhaZm1uSUNxeDBySklxYVpF?=
 =?utf-8?B?Z0wzWjdRaXlCL0t0RzlEeCt4YnVVdjRGNzlhcVlBNWo4NzdNd0huZ0x5SVY4?=
 =?utf-8?B?YTNtYk5EM1lBVzB1TjJubGJIYmU4WGFidUFKYzdLMTV6a0NTbVZ6VHQveW9v?=
 =?utf-8?B?SC9TYzFVaDZvUVE1RWwwaDBrR0ZYd2JDYXFiMlR6K01PdGdkcWRjVm1SR0g2?=
 =?utf-8?B?Um5lWFUzYkh6WVFvalM0endBV3ZaRWJwcjJENHl6d3ZUSE14dC92enZzT3JM?=
 =?utf-8?B?eGpUUDZUOFJrdHlFOVJlb3crOTFPZFE3SGxLcWE3UjgyZFVjMWNobHkyNXlK?=
 =?utf-8?B?cEI3cm5HTHNJTGVid3NMWVo4eUcyZkplT3NoRmdpM0FRV0lMUHZQWGJRU1J4?=
 =?utf-8?B?bUJrY0xNNVdEZHdQV0QyQ2QwYzQwOGpZdEVEV3BtTFU2bXhjK1dxaEx6WjVW?=
 =?utf-8?B?MDBkVU4rV3ZaRnQzc1hmQlpGbkM5a3N1N01ScnI3Z0gySWF5L05JdlZ2Ujl1?=
 =?utf-8?B?R21LQ0NHaU1vUzBMUGhWdGN6L2ppMDVET2UwdHA1emtod3hHQnJ4SmhvY1Fj?=
 =?utf-8?B?d2ZvUGZMdnJFdkN5RUp0U0U3SXMyWDBCN25nOVlBR1VzQzR3ZVRXeUdQSmdv?=
 =?utf-8?B?elFEZkxiWUd5Sll2VGhpWlp1SkdGa0c1eDBkRW5DUFJFczhTeldpcmtPVmo1?=
 =?utf-8?B?ajhkRkFmWGI3TjFnamZnalJZaVRRN1FmVEdzTndKTmV2VWRrdEt0TUw2Rlhu?=
 =?utf-8?B?UU12andvaDJSSjhPZ0FzbjlrZXA0TnJieXpnTUNkemNmUE4yQy9uYnhUMkhn?=
 =?utf-8?B?Si9JVjR5MmxoR05LVGhzdjFPOGJqRWF1VTJyNmJsckhyR2wzY3dWYVVyUS9j?=
 =?utf-8?B?OGZ5OUw2RmFLY2NmNlg1elRKOW9oU1ZhbU1tckU4dzlJTDNXcUw2V1JwUzY0?=
 =?utf-8?Q?ldg1RKTWy91aJFKi7UM+Rro0u?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a61658-8bfd-451e-f395-08dabd3569d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 00:50:33.2110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j+07pE/13RzKQZDK9Q2WV2hAOUsHNEa0tmpu9NJv3ebZKy2f8Oi/SaVJvzaqoKixvyJEDy7A6YrmOUzLYQKUlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6736
X-OriginatorOrg: intel.com

QXR0ZW5kZWVzOiBKYW4gS2lzemthLCBSaWNrIFdhbmcsIEZsb3JpYW4gQmV6ZGVrYSwgUWlhbmcg
WmhhbmcsIEppYW5ibyBDYW8sIEhvbmd6aGFuIENoZW4NCg0KKkNvbW11bml0eSB1cGRhdGU6DQoJ
TWVtb3J5IGNvcnJ1cHRpb24gaXNzdWUgLS0gIEZQVSBzd2l0Y2ggcmVsYXRlZCwgcm9vdCBjYXVz
ZSBoYXMgbm90IGJlZW4gZm91bmQsIG9uZ29pbmcNCglJLXBpcGUgaW50ZXJydXB0IGlzc3VlIC0t
IG9uZ29pbmcNCglDSSBidWlsZCBpc3N1ZSAtLSBmaXhlZA0KCQ0KT3BlbiBkaXNjdXNzaW9uOg0K
CVBvcnRpbmcgRFBESyBpbnRvIFhlbm9tYWkgLS0gbmVlZCB0byBkaXZlIGludG8gbW9yZSBkZXRh
aWxzIG9mIERQREsgaW1wbGVtZW50YXRpb24gZm9yIHBvcnRpbmcNCgkNCg0KUmVnYXJkcw0KDQpI
b25nemhhbiBDaGVuDQo=
