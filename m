Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E37B2564
	for <xenomai@lists.linux.dev>; Wed, 19 Apr 2023 07:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681890905; x=1713426905;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=yrJgNAchRubxTSrJ5Bp/53nGxwxJwFzL1+jujmpZqYg=;
  b=YS4iTz6CG6m3XJYc6Rm0iIFEF4ssVyti9MyyGQetz9F4QXJaqpvzg6Lb
   tUQ3wN/munqM5tFgiBxJzF13PT6U2KtWPhR7tKyKKB0f5aEVEJMFa883U
   iWK/T32AkvGUGPyC6Rjx87a3Kn7FKo7AFOkJiPYe85C3WUyXCpkdOttHz
   kMT+P4Ya3RCGGTsBhzhamXk9aVQpVGnuxMk/Astu9jUkc6LWHspMaEGCy
   jwqN9YkQd1RgeEhDEqX73XdoKDB7F5i1dwhnyUesi8LvMM87ASmTgK4QK
   EGPOWPTtPQgRnOYNWQ4rXZnZ4qXiPUPgcAZabZ4s/LX2j4uj+PyClAGko
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="334189006"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="334189006"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 00:55:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="693955126"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="693955126"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 19 Apr 2023 00:55:04 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 19 Apr 2023 00:55:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 19 Apr 2023 00:55:04 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 19 Apr 2023 00:55:04 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 19 Apr 2023 00:55:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YjcukdmvtdO343NsvbL9HpzO09cKBWAZykuSnnKPO8VKcXem4JUVoIqsCA7hMlq7e4vKzf1fI8irXODIAVtcFXxSvoUn3yoKCzGk7gCaKLLM0orV0bw6Xekr/y4oEYyCBS+ohGLT3AfZw0vKiVzSbD5/Jl1JCJPmL3ky84r3DUmHMQ2UocBUH1uGAwZhqQ2Tb2r3VW0CQO29824v4LKKTQWVEJWSiiBak/P9CB1Y2vk8WG2g+KnEPodIIG5QVHBh3mAVmdxEnqSbMpCtiHAB+dNK4tgckjlWtT1FQq9t7YfNRz9wE5YL9N5cr4FDhNcaZtLi5tZ2IgvS660epEIo0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrJgNAchRubxTSrJ5Bp/53nGxwxJwFzL1+jujmpZqYg=;
 b=D5EOY2zpUgUY5Drhzug1HIvvvvLoKtZYt/BBUlR2aMllA+tBb4zWxngE5BPc/P4tYrpcGQ5Dkfj+bPytWBsDJi0gYwUAJFAmQc6XlbVqqXpvL/TKSjRH+dORPAXK4dRw88JangWbaRzBFBt2D5ePfRWnG7+klrPd1rmJr3Q8Yhn2cuAoVP8b6aypeHerR6147Qnay5yLlw9b1bV3/G1/yRRH7eVzXSvpWzjVDYl0wXe0TcSMLMESephR22JQLt7S2ID9GH0oYvvmNfx9NXC8m0seC7pY/I4znz33VWXg36+9oGFI7HIT6qSinElmJGOopUdR+OdnjI0zKqe96aNTmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by SJ2PR11MB7503.namprd11.prod.outlook.com (2603:10b6:a03:4c8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.21; Wed, 19 Apr
 2023 07:55:02 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::9822:1058:3a7e:e502]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::9822:1058:3a7e:e502%5]) with mapi id 15.20.6319.020; Wed, 19 Apr 2023
 07:55:02 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Xenomai Community Call Minutes - Apr 19, 2023
Thread-Topic: Xenomai Community Call Minutes - Apr 19, 2023
Thread-Index: Adlykx17jWGaRpxgRsGIPRdd7lTvpA==
Date: Wed, 19 Apr 2023 07:55:01 +0000
Message-ID: <MN2PR11MB42855D4E852BDC75CCC51471F2629@MN2PR11MB4285.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|SJ2PR11MB7503:EE_
x-ms-office365-filtering-correlation-id: b0a5efa2-4456-4b93-8250-08db40ab6126
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Duf2Gg9uJfhY3AyGxC5G3Z/JTbzRqs9IFskSs+ueexdin7sIfCZ741KRq8ozj1qQmmYrwrmNvyCvCBAaKOyHBsCZA8OrzbHelE4jjW7NBLNIpr+pG+2brOKBtEQl27pDkO73mW6Cd0DJerEkWBoJaYmasH0fkG2JFLX/IBvw5TWOD91XR7RtI+Tin3LbtLUzSSh8D50SV4FdfKrX/5eM8l0Nc22lwcAwaI5TexWFQ0QbouI5fBgjIkwXhZPtboYeWUF/yJ8otz9Ch7Wks6B1UVMbjDJNiaDKO11p+HlyML0RSPjBxG+fSZKKbzdKvld/INVzU0T0bU7htCgXUmOTgve17pol6JQjhSK0k6kX2b0XBexUZqGirb0Y30mDCf6WDiQnx/Sv3ZCi45btMtFc9WMBOzjGEiqWRebyoNsaHCXerOwadHTPvG2md3thmoCndcNWtRFBgDaRydcqHtMKZSdNgn26uZlpdQgDQeBMg7WbXABoSGzyc/is2aW1bFoqg8i32ZFjZVKkBZDE7ncxPB0qI05SPWL4tdipFSl4OsGgmTKsTfW2q95T1ZC2yw1lpQe1nAXmYmZN7QUcX3Ygq6Xmm+/J+HTsaD0GKyqO0EpZXwsuchEYwvLYwQQjIz+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199021)(52536014)(5660300002)(33656002)(478600001)(8936002)(82960400001)(55016003)(41300700001)(8676002)(316002)(122000001)(38100700002)(66476007)(66556008)(76116006)(66446008)(64756008)(6916009)(66946007)(2906002)(4744005)(9686003)(26005)(6506007)(186003)(38070700005)(7696005)(83380400001)(71200400001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VDNkc08rT2Uyb2lhOHVQZmFqVHo4NmZDMWxXa0VrM09UMmsxZGdHMVNOaGI5?=
 =?utf-8?B?Q3czTDlpTVIvL2ZSK1BxcitsN3VqMHc5ZkR2bDlxQ2wrYnhxZmJsaDRPbnRi?=
 =?utf-8?B?L09qTXhTem5HNTJnMDlnaCtDU0MvcXVFblJMQ0pZOVl1dXhvcnpBVE15d3dI?=
 =?utf-8?B?TzhvVU8wVk0rb3AxK3NURVBQdWJON0NNNi9xRHZxZHl4V3k2OUZwNzhiUmVO?=
 =?utf-8?B?VzFHSGpGM01YVFBma3dYZWFyZTZZaEtzVWtTS2JnalllRFE0dytVMjNGT3Zl?=
 =?utf-8?B?YmFCTmpYS2pDWTcrcGxBNTVFaDh4MFY3VnhNejhuSi9mODdNdHcyalNrM3Fj?=
 =?utf-8?B?dDE2WUtlY0kvUDd2UDdXZHNIWC9FNVdIeE5pV01hSWhncCtncWlFZUdmcmRM?=
 =?utf-8?B?c01TQ1ppb04yZHVaUmtVM1B6UjBhNUVxZG1VbTdSeFdNZEsxWVlRM3MvM2hw?=
 =?utf-8?B?OVFINWVZOGpwSVJieVNFbHJGLzNZazZ4TGlKMGUvRkd6a3FKQjRIUzhMdkZs?=
 =?utf-8?B?S3dlY29jdzJrcGQyREFBTXd5a3o5Wmx4dlBxT0NLOHFHNFR0ajZYeFN5Q09q?=
 =?utf-8?B?cUxRZTk2Rm0vTVFGOCtkcUFwZU1YZEgzU0lMVWYxOHJNL2cwQmhrZ3NybGVa?=
 =?utf-8?B?Y0dpZHFKS3VzekQzRXpEZ3dHUmoxMWtOYzVDMitwN0xKR2lDenVMQWdsYXMw?=
 =?utf-8?B?dmpOaHJ0MFo5b1NiYzYxU245WFR0QjBDMWM5eVJFSzRPTE0wL3E0SmkyNUd5?=
 =?utf-8?B?WUxpU2FKalViTFJEcXQvdG50Q3ppVzJXbUREYStqVllPMEoxNDNwb1FUcjB6?=
 =?utf-8?B?NnZKUEtaS2NSRVhMeHROd05GSi9kV1hmL1JtOTFCdTl1bHpvaWVDbmlZOGhK?=
 =?utf-8?B?WVpmSTNWMkU3dGZiN09UaHRQSzFXeGU2YnYrRWxLMGJ1WUZYaTlmdEcwT2wz?=
 =?utf-8?B?aTJzVnFOUlBvd3EvcHB0ZkdRRVdhM21SQTd6aWZkbnBVYWdUM3NiQUZwcnJH?=
 =?utf-8?B?c3hCdUFmcVhsYkZFZHFQLzVkQTdSa2lhRVNJQmJmc3drT1RtRU1MTTdyL0JU?=
 =?utf-8?B?amJFazBtdGVLY2psMHdaVDlZcG0vdGVKV3ZlclBGaU5nUTdZT3Z3ZmRWVXJW?=
 =?utf-8?B?WENaVXFkd0RFbjh5aGZxN1FQNGF5eWNjMVNmM3RJdDZlNC9Nb0lTYkJHQ0xs?=
 =?utf-8?B?Wm1MWE1lWDJjMXVXSFF3aFdnU29jV0ZXMFdDdExMaWYzbmxnRWRPeFY2bHAv?=
 =?utf-8?B?MUNmQVhuakV4VG9uSjhQME1NeDIvUVNhNDg2UXBlTGdqNjZ1SEh5cnhSNVZm?=
 =?utf-8?B?NTR2MUhzK3haY3owalU5dWJZTTlVT3ZjU29haFRXcTRCSVpiRC9LbXZBdFdl?=
 =?utf-8?B?NGhoeUZGaW9oeGtDUXUwZUNLc25YSEpNU3BUZmxTck51N3pzZ1ZPM01XWHAx?=
 =?utf-8?B?S09GSHFLM2hWR3J4aitqQ1RVUnV5TjVKdG00TlZpeDlWczRSZmJVSEo1L01t?=
 =?utf-8?B?TFo0Rjg2TXlrY3NSeVFmVXV6OUZZcFVFVytvUDB3SnFXcTE5aHZNVUUyQmRw?=
 =?utf-8?B?M1ZPamdTZ2p2Z001T05sWVEwWnIyYm9aQndXZmNVL2FhU0l5MlJ5cS8zdGhL?=
 =?utf-8?B?VFY4bWhpQUZiMjZaR0VKTDFvVzFJNk9hWSs5emMxL0pNM0dXZ1oybDdZVEJY?=
 =?utf-8?B?clNzTSt0Q2JIQVg5cHk0cHVWMDRONGM0T3MrNnZzak1BMktFWXYvUDVleS9W?=
 =?utf-8?B?TlRyTzFHK1BJTGVCZ1ZJSVBPNVpWc21qdFhpb1ZQMEpBTTF6NkNIYWJHdGxP?=
 =?utf-8?B?bzBENVNBaVlDRTJoLzk2UHpaOUt2VTBYTDdtWjFiS3pIbUJ3d205U2IwOU9K?=
 =?utf-8?B?VGd1RlRVWXZtL0c0ZWNHREZsTmpZeVBlYVRadUVXaVZzdldKaEFOL0NTUjZ0?=
 =?utf-8?B?MG1Camp3dUlVdjYxYmpzWG5HMkgyTmhqM09oLzZ4czJrbW94TkUrYnpUcmJF?=
 =?utf-8?B?S0M4VU1FSERTRVJ2bUtZN1NDZVFKbjA3RGZjY1NXbmhSTEl1REtsOWx0ZGVi?=
 =?utf-8?B?R016T1UvY1lUYXU0aGNZbmdnK2t1Tncyd21TcmJ0RWtLenFURktXMXpxNkM2?=
 =?utf-8?Q?dssLRzfgjcloGWK4DcqyRUTEU?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a5efa2-4456-4b93-8250-08db40ab6126
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2023 07:55:01.6082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F+FkTlyd6ogp7TOdth5os/mQ6qgzR/bnBRLHlXZ3jagPWNWEciQrea8/l5gYfUJZsRrXLUMiVEfMRFnvmVlOVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7503
X-OriginatorOrg: intel.com

QXR0ZW5kZWVzOiBKYW4gS2lzemthLCBSaWNrIFdhbmcsIFJpY2hhcmQgV2VpbmJlcmdlciwgQmV6
ZGVrYSBGbG9yaWFuLCANCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRGF2aWQgT2Jlcmhv
bGxlbnplciwgVG9iaWFzIFNjaGFmZm5lciwgSGFvIExpLCBIb25nemhhbiBDaGVuDQoNCkNvbW11
bml0eSB1cGRhdGU6DQoJS2VybmVsIDYuMyBidWlsZCBpc3N1ZSAtLSBmaXhlZA0KCUFsY2hlbXks
IHBTT1MgYW5kIFZ4V29ya3MgdGVzdCAtLSBpbnRlZ3JhdGVkDQoJU3lzdGVtIGhhbmcgaXNzdWUg
d2l0aCB2aXJ0dWFsIGh5cGVydmlzb3Igb24gNi4xIC0tIGZpeGVkIA0KCUNvZGUgbWVyZ2Ugd3Jv
bmcgaXNzdWUgb24gaXBpcGUgYnJhbmNoIC0tIG9uZ29pbmcNCgkNCk9wZW4gZGlzY3Vzc2lvbjoN
CglCaWcgJiBzbWFsbCBjb3JlIHVzYWdlIHdheSBmb3IgWGVub21haSB0YXNrDQoJU2lnbmFsIGV4
Y2VwdGlvbiBoYW5kbGUgYW5kIFNpZ25hbCBiYXNlIEFQSSBhbmQgaXRzIHRlc3RjYXNlDQoNClJl
Z2FyZHMNCg0KSG9uZ3poYW4gQ2hlbg0K
