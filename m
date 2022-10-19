Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF601FC9
	for <xenomai@lists.linux.dev>; Wed, 19 Oct 2022 04:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666152223; x=1697688223;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=Q46hRTB0svvZxmfq/1tRgfMRS0sI8twk8Yyoco0hSgY=;
  b=HN0nDmgaSvz0eYRRPCWY6Gm3T8DQgbURAyiQKLg6cKV43SvJrZtcU/tD
   i9KyuaMGzhQ3Kl2OGnKgwdR4Aw5Sp9uiXdLCX7yx/eZy0A6m/pihyfGXh
   ODKxYiDcUTU0iWOGPhLuoI05yP0W2MWfdt0W+TJfiWNCTAODODoq0qwPV
   egs3kyapeRlhRN/E1i/3XcS15qp+ro+/kGDQThh4diMl3YtIX63rm3Jkh
   u2MEDsRnILvuC7gRamHcX3ZdtlTLzNQu+6VzzZmVwEhFeYd343I1DF/Fr
   dQAWWVghWW4m7o4Wkx47mVzB3D8RNYVNDD5InEfbBx6LxGkAuI3+L1y80
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="293695695"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="293695695"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 21:03:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="771563385"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="771563385"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 18 Oct 2022 21:03:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 21:03:37 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 18 Oct 2022 21:03:37 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 18 Oct 2022 21:03:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X93Zs8MkJCMPxBiW5unOi0c/xzpbziBE45wOhM4pbu5tejVjVxAfdumT5KvjF//gjGrKJPnJWtMDpZocd15ir9QXcSD52Yl+7v2mk559hI3HzaaN27s/qO19JQycTB33xFwknLZl60GJ3SpZ+JhZwmNQjMTz+HMbBxXCTNJb8GJ3n50yFINIoPUc/Cf7+lnWKKo+v9MK4JaErQl4BzCUhfSvxaCYFEw26BTsLNshXQk2Rgl7IUo7wbwmOK7sor8Tv4A/LpTc04A4A7Tsr9b1msfb0A4Q1OqmTzOUTsFdGDaDQFLX07C3iookdY5uNYFbk2nY5lMIG2gI67W593QBng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q46hRTB0svvZxmfq/1tRgfMRS0sI8twk8Yyoco0hSgY=;
 b=CE3mspRRxGuv384jzEa3SnpprrR7cc6M3xkVDJfJO7qeWdkEQeM7ljLg/0vMl/9WKxxK6TOtz2DNU9qI42JAWi4ePcMOJIunumB9nQ//+UoqQSE+dVXaPc2+3eDu6SWoUiS6nzGw7TQnWACYGN9fiZpy03wVRzdyvjAIqrQSv3lk3keqyIkokSZYW/ICyaQBOvrc9FLrvHM1ppOsbO8esmEz6UGe1LA8G6preswfPJAV1+7cGkVsAdqLhF4pl4Av69axFm05KMGyjMefqvv0f7BFiRcx4KDaUScrNk2VXguJAdp0G4RI+0W2AT5B6C/kUCt+68Ax6KM6iiH9oltZ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by SN7PR11MB7017.namprd11.prod.outlook.com (2603:10b6:806:2ac::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Wed, 19 Oct
 2022 04:03:29 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::d2bf:1e23:6354:82b1]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::d2bf:1e23:6354:82b1%3]) with mapi id 15.20.5723.032; Wed, 19 Oct 2022
 04:03:29 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday,  Oct 19, 2022, UTC
 7:00 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday,  Oct 19, 2022,
 UTC 7:00 AM
Thread-Index: Adjjb7bksXEsWo37TrqyZl1hw1V1mA==
Date: Wed, 19 Oct 2022 04:03:28 +0000
Message-ID: <MN2PR11MB428513B7AE2C6A4D51305602F22B9@MN2PR11MB4285.namprd11.prod.outlook.com>
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
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|SN7PR11MB7017:EE_
x-ms-office365-filtering-correlation-id: e058d2d0-140f-4237-0d91-08dab186e151
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K30PJh1BzoF8oVcbPM4iGfcCm6AU2Wxwc7bNYkI4cuKsQiAzvdHzr8rUf/Ll3TSqWnpIH0ADK8q9QyeJ4U5SDg0cz17/Ro2Zxjqf00qvGgtGnqokqCQS5vvrwSpr0bEes4svylUDunXY/C6z21uzwiJYZT6rl4hWV10HXtw06T3rT8b3fHwnEDqAPz2wNaqY1mOBXyV77oTTA1zDpjQMukdjCe7mbAnt5kf3f6sjAFsh+dI/1Di+GRTjQrioHqXpaVyIG2UX5xoDRjx+4D9xqemfk6rATf709eMeRKugmBEfOQ8vo3dwMb4qPvjSE4TReFfOylN7BLrIHM+J4c+uwqM/fSD2C2xdgxpPBXnYcSEkm9Jshst+uESaYIcFfBCD5KHRyae8MM3jgkS0KGGUCoCHeYD5+ruWkjfj/LrCk5EF5Nfd2VR0kPTyBKSO9OMPBo45JsC40GJwz5CVlFm1g0lehZDD1yHxg0oW3RBOxhRqVCQyjudKX8zH/W0d+pzwpGKgk+tu6QJgPmz15PMp00lIE6ddncbyEby/ff6Q+u9L4kGuS5mBLzprxDNuUFy/Z7jbU/8VWm5xiZP/ZH6Qz8uTansMtDWtzLGDxC9vcwoQR2RPeLIF37BPmtK7Y9sobDF1dONPt7dHWYgbvIAupM0u/ypo5aWczs4YTFDMBg3HmCDQzRPF0RUQS7MBM+omj/tlsC+9j7/MyHmSrTe9EhLVO9nY20oxY8HdJqZV2HsGTxPuIFIRwvlJ3mqU6mmJDhAi5zdweV9+ddRafXGbyn/JPY1qhWw82Ff89nQ3WwpfbIuU0/vDhaeiTJHJd8jGXHY2v8Jkj4krFB/EIP4hTw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(396003)(136003)(346002)(39860400002)(451199015)(122000001)(478600001)(26005)(52536014)(8936002)(9686003)(966005)(5660300002)(76116006)(66446008)(66556008)(66476007)(316002)(64756008)(66946007)(55016003)(40140700001)(8676002)(6916009)(33656002)(186003)(41300700001)(2906002)(6506007)(86362001)(7696005)(71200400001)(38070700005)(82960400001)(83380400001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTRlblZqQnFlNmVjTTQwa0pIdzFJcGxab0FRMm15QWZZYkJ2Q2FEeE1JTmMy?=
 =?utf-8?B?VUo5SWFSQkxHbE1wMW9KMUY2YTVjZmthV2RZS08vZTRwZTdNL0JFMHNXZHM4?=
 =?utf-8?B?Zzl1N2JGc2xJVDkxMHFBTXE3Mm93TmgrVDhXNHZSK2dtQWpoMnViK01qUGlu?=
 =?utf-8?B?eFQwdlloWmYySHJzeW5UY0tPcm1PYnFnUjdPNHZ0dFMyQ3dTSG5VckJTeWM4?=
 =?utf-8?B?YWg0MHROWGdZbDJNYzFUSEpQRWFUUkpNdVlDUHJRNmRKN09rbmZYaGc3b21p?=
 =?utf-8?B?cElsSWU3Yzc2c29MVW1vVVpscE80SUxqS1Z1QXVldm5BTDRkaml1SWhuZ3dZ?=
 =?utf-8?B?YWR4RHhZOU9PMndkZENQQ1VyKzQzWDlKMjNDOC8xZHBvQzRFa09YeDYrckFR?=
 =?utf-8?B?VVAwLzk2bjhFZUx3ZjFGc0FHbUI1QTVtdzRvTUFLODFUZktxSUVSdTZ6d204?=
 =?utf-8?B?N01VTStTQ3RDcUhza0hZeUhMZkdhQ041OGEzWHVWSWRZUFNQRG9obnorenll?=
 =?utf-8?B?N3lNOWdjY2owSEg5b1JkZWFuY01MVFN5K1VoVGR4TVVHZGc2RllEdHBQbWll?=
 =?utf-8?B?N2Nmd29IK2g3SktmWGhrRUtoSThQRHgwczJjWXRXVWFlUEpkZG9XWUdEcWFa?=
 =?utf-8?B?dFQ2UmlKdTdTeUI3V1NCaTI0UDZ6Kzd0Y2lpN0ZCTzdzMHZ2amNIZU85WktF?=
 =?utf-8?B?dm1teHQ5VnExaksxZmM4T3VwRzZGTFkvWjZsVE1TNmxKNUJjcW8xLzNtMFZX?=
 =?utf-8?B?VjA3U3pKaUtYYmFscmE1TWNTdVhxSnAxNFFUYVMrN1JlS0hWZmxvY1VNT0FH?=
 =?utf-8?B?Q3hlWFo2Y3V3N3BMTFV1S1ltOWJ6bGFiOGtZWnNJVlk2bTBKSlJTSlZKV091?=
 =?utf-8?B?VWZ6U1RoQ0tPQWNyeFE3TzRmclFpNDB4MVo3NXBTcXh1bU9HL0tXd1pBWExD?=
 =?utf-8?B?Nno0SVg2UjR2Q2NTNkg0NGNVSFptckpVTHNRbzZlR2RZbjlHYnJ1dnRMSFRa?=
 =?utf-8?B?N2NVTklWVnRWbFE4S0xSR0hCM1lGNysrY3hWZUxCSVpXc1RaUFlwdkRNYzZW?=
 =?utf-8?B?YXRjd3R6Y3RFV2ZJeGM5VW5QcmllRVdCUUpNTnN5dVFkczhmVEZzMXViUVRk?=
 =?utf-8?B?bWsvNWp4MlJBSDlIVDdnbUI3NGR4OFVIN05FNVREcFBUQ2JpbWF6c2Q0VitY?=
 =?utf-8?B?eE1vK0xDZ1FhRU5aSzd2cnBqZjdzT3kwZmM3MExvRW12eGttQ21qdFZIQlRm?=
 =?utf-8?B?ODBBaEdtUkExQ28xdUJsdG9icXFTYS8wYWhCM3Q1STFPOUxHbi9QclFseVpl?=
 =?utf-8?B?NzY1ZERwd1JNd0dDREpaK0VTMENwazdSRVFnbnNlZXBvVzdZQUREc0xnaUxZ?=
 =?utf-8?B?alNaQUNFYkhQcGlBNU1VbHFoRnpPWDFvYldFbFVSNWUxUEFiR1Yvd2hqYVI5?=
 =?utf-8?B?OFM1TENTZmt3TCtZbWVWQ0ZKWmVUcUJNM1g4a3NhU3ozN29ZZFlPb3NsZEs0?=
 =?utf-8?B?eG9wY2ZLeWhOOXM3TUJGVkVuazBpQTVRam83aFlUWktiTDlBMVAwQ2syM3dG?=
 =?utf-8?B?NnhHWGJybExTZUJRSHptT28rcHZ2SzV0em5tQW9RZEVBU00ycFBOem1Ka2ZZ?=
 =?utf-8?B?WHFhdDRIYnUzejAyUmdyblZ0U0UveStPVWJDcEdGRUlQOVhBYlQ2ZVEzcjFL?=
 =?utf-8?B?WXArR0NhSVNoOXNtQ0prcm1INUFrMmcyRFozVjhlcTlqT1J4UVNZUUc4OFht?=
 =?utf-8?B?NVZldDFaUTdpS0d2UmdGRy9IYXBpYjhVNFE4TW5zSnYzT2svNjhSTXRZTE85?=
 =?utf-8?B?Yi95Nkg2N2JhVzR6RTZUVDBXWmlXRmVESWcwK01jSWxyNXlVVzB0ZTcyVXBS?=
 =?utf-8?B?L2hhMEJRQm1PQllpbzA0L0V1VkQyY1ZMOTcxU2N5NVpaYzRWd0p5T2RxOUJZ?=
 =?utf-8?B?WTNuUVg1OVVkNTFzU2JkL1MyQkcyZnlEelBRb3l1UmJYVWVDdno5QmR2eCsy?=
 =?utf-8?B?dmNRRlYxbnR0MW9vRHgzbEZJekNqSWw2THZvcHkwbHlkeFBQOWxocWxnZEFM?=
 =?utf-8?B?UklJREMxMXR3WmJ6OVJNV2ZpT0RYQWRHckVvbmR1ZEh4UytodTRCUU05dmZp?=
 =?utf-8?Q?phvGOVvJ1ZqdQxkR4S24tabom?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e058d2d0-140f-4237-0d91-08dab186e151
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2022 04:03:28.9953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VhPuChjFEYyrkNtv5FTTgwzL/a1Dn+Z9/2L12LWGcTE0qfhMRGe7h3ujLKnEYBNCDpJ4AigZVpN7UBgbPPGmjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7017
X-OriginatorOrg: intel.com

V2UgaGF2ZSB0aGUgWGVub21haSBjb21tdW5pdHkgY2FsbCB0b2RheS4NCg0KVG9waWNzIG1heSBp
bmNsdWRlIGJ1dCBhcmUgbm90IGxpbWl0ZWQgdG8gdXBzdHJlYW0vZG93bnN0cmVhbSBwcm9qZWN0
IA0KcGxhbnMsIHN0YXR1cyB1cGRhdGVzLCBhbmQgdGVjaG5pY2FsIGRpc2N1c3Npb25zLiBJdCdz
IGFuIG9wZW4gb25saW5lIA0KbWVldGluZyB0aGF0IGFueW9uZSBjYW4gam9pbiBhbmQgYXNrIHF1
ZXN0aW9ucy4NCg0KVGltZToNCldlZG5lc2RheSwgT2N0IDE5LCAyMDIyLCBVVEMgNzowMCBBTQ0K
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
MzY3NTI4DQoNCg0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQoNCg==
