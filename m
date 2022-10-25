Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE197B
	for <xenomai@lists.linux.dev>; Tue, 25 Oct 2022 08:24:35 +0000 (UTC)
Received: from spool.mail.gandi.net (spool3.mail.gandi.net [217.70.178.212])
	by relay.mail.gandi.net (Postfix) with ESMTPS id A50451BF206
	for <xenomai@lists.linux.dev>; Tue, 25 Oct 2022 08:24:27 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by spool.mail.gandi.net (Postfix) with ESMTPS id E1BFAAC0E48
	for <xenomai@xenomai.org>; Tue, 25 Oct 2022 08:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666686266; x=1698222266;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yxrJFv0ZMsHJtAiB3AlNYTcS3DOtXrze4UNhOTYG964=;
  b=NuH534yB9ACAS5AJ3D3U7qr24D98BCzjmv1JF3S3q7PcoRKjrAxsDUtf
   Vx+8a8zseLaP0hVxC8dgWHr2piKxm7Xg6BNZNhBIr9Pk0vNCZvkp6ok6T
   cIMN6Xk4QTafDnSLpfgvVFOYOYW0LapgD/AWaoXw16KgkGcCKLHWV42Dl
   zF065d5DR4yWYhdDNGZ5i1h6siThww51RNuib6NQ1Wna3ExbMZUtKuaI5
   A35hqx/DOn3CQw0bBn/dz/0PG6E8vc8+FsheyI/twGn+jRQ8/l/H9kGX7
   KdzOm3ZzXM39NWbQ0HmlUd9espbpUqmPZn5S2Zw9hYBImwlPF1awwZbZ8
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="307614183"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="307614183"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 01:24:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="806587158"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="806587158"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 25 Oct 2022 01:24:14 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 01:24:14 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 25 Oct 2022 01:24:14 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 25 Oct 2022 01:24:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlr2nRRZBdmVNk1o6HqbAu9MEsOGC3JP8OHM0oGWFLG1vDSf1ojlZWnEx3WA/7ladMyZwiV9BgCc0GonTpzlMSvBCXS2eNVRjUeqLAfy4joUOY8wU77LP/KIMpgHnhCY85SXtZEWEIz43EknR8dTyG675S2/mYPIoIxfoomqCuaTJcZTQLfAqo3CHuM25sUGWDjHts933DnCrGzzwOP4RDEzyQ6Oh4G1VGOCCHyKXZFGEr4DdbEsw6u0hBNP6fHGIdEnv/5SJI/D4Cnl3yWZjznIbTqYHB7I+N8+DaTHYR9mSBU1/IMxV36Hc1YAzPiCpigBFAwIZK6MAeLmxx+x8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxrJFv0ZMsHJtAiB3AlNYTcS3DOtXrze4UNhOTYG964=;
 b=MlqUso8+MslMvRJWl6KWNAm1SmqnsDgJ3W0HRP/cPuVPQprt0nSW/1GCry8wyTn2mV5V2+6S2vWOaen1rQn0cVlzAWIb7JRF9O3abs22kL4eRwgys+Y6zM5lnaqm3hIvsD8L7jn5lpTutuyZbI+/YNgmxVma3vyjUomAcjCMjNBWfNBUUguvSqXR4eGvTYxSBSk86I1j62cP95IH8MPJLoc6jymTkt3gIazdRBi5NX8ZrJOM4zCOOaA2AclM4YmyupXJHsKKQ9ViwLAS7WmTIgxhxEpFbkPWDxMUPhodKrKcYiDfNPJuGPVZHNWZkmYWKZdJ66xVE9+JkgxBUgkapQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by PH7PR11MB5983.namprd11.prod.outlook.com (2603:10b6:510:1e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Tue, 25 Oct
 2022 08:24:12 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::27cc:d8ed:9947:fecb]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::27cc:d8ed:9947:fecb%7]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 08:24:12 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: =?utf-8?B?6rmA64+Z7KO8KERvbmdqb28gS2ltKSDssYXsnoTsl7Dqtazsm5Ag65GQ7IKw?=
 =?utf-8?B?66Gc67O07Yux7Iqk?= <dongjoo5.kim@doosan.com>, "xenomai@xenomai.org"
	<xenomai@xenomai.org>
CC: =?utf-8?B?67CV7JiB7LKgKFlvdW5nY2h1bCBQYXJrKSDsiJjshJ3sl7Dqtazsm5Ag65GQ?=
 =?utf-8?B?7IKw66Gc67O07Yux7Iqk?= <youngchul3.park@doosan.com>,
	=?utf-8?B?67CV6rK97ZuIKEt5dW5naG9vbiBQYXJrKSDsiJjshJ3sl7Dqtazsm5Ag65GQ?=
 =?utf-8?B?7IKw66Gc67O07Yux7Iqk?= <kyunghoon2.park@doosan.com>,
	=?utf-8?B?6rmA7IS47ZiEKFNlaHl1biBLaW0pIOyXsOq1rOybkCDrkZDsgrDroZzrs7Q=?=
 =?utf-8?B?7Yux7Iqk?= <sehyun2.kim@doosan.com>,
	=?utf-8?B?7J207J6s7ISdKEphZXN1ayBMZWUpIOyDgeustCDrkZDsgrDroZzrs7Tti7E=?=
 =?utf-8?B?7Iqk?= <jaesuk.lee@doosan.com>,
	=?utf-8?B?7J207JiB7J6sKFlvdW5namFlIExlZSkg7KO87J6E7Jew6rWs7JuQIOuRkA==?=
 =?utf-8?B?7IKw66Gc67O07Yux7Iqk?= <youngjae7.lee@doosan.com>,
	=?utf-8?B?6rmA7IOB7KSAKFNhbmdqb29uIEtpbSkg7IiY7ISd7Jew6rWs7JuQIOuRkA==?=
 =?utf-8?B?7IKw66Gc67O07Yux7Iqk?= <sangjoon.kim@doosan.com>
Subject: RE: What causes the latency of the rt_task_yield() API?
Thread-Topic: What causes the latency of the rt_task_yield() API?
Thread-Index: Adi2hA+8NshNMGH/S1C5hT38XRCzfAABQnKAAEPabkAAHYUU4AADTiNwAAcm6LAABFvNgAAqXeuQAAWtTIALzeIasAACKoYw
Date: Tue, 25 Oct 2022 08:24:12 +0000
Message-ID: <MN2PR11MB42859E1237FC5DCF1F928E9CF2319@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <SE2P216MB1394874A00E10A497FE73DE0C2709@SE2P216MB1394.KORP216.PROD.OUTLOOK.COM>
 <MN2PR11MB428519AFC0F522BB25FDA093F2709@MN2PR11MB4285.namprd11.prod.outlook.com>
 <SE2P216MB1394C7C6A067126F36022F23C2739@SE2P216MB1394.KORP216.PROD.OUTLOOK.COM>
 <SE1P216MB1509579188F44BA6C35E8547B1739@SE1P216MB1509.KORP216.PROD.OUTLOOK.COM>
 <BY5PR11MB4276CD67150EE6042EB1A849F2729@BY5PR11MB4276.namprd11.prod.outlook.com>
 <SE1P216MB1509E22586BCCE1E4899A946B1729@SE1P216MB1509.KORP216.PROD.OUTLOOK.COM>
 <MN2PR11MB4285E860217DB23B18016495F2729@MN2PR11MB4285.namprd11.prod.outlook.com>
 <SE1P216MB1509ED1D62553AC566FDA209B1759@SE1P216MB1509.KORP216.PROD.OUTLOOK.COM>
 <MN2PR11MB4285C21FFFA82081782F2CDFF2759@MN2PR11MB4285.namprd11.prod.outlook.com>
 <SE1P216MB150910153918CA5DA4FFC8B1B1319@SE1P216MB1509.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <SE1P216MB150910153918CA5DA4FFC8B1B1319@SE1P216MB1509.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|PH7PR11MB5983:EE_
x-ms-office365-filtering-correlation-id: aed820c3-b6d7-4908-1359-08dab6624bdb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HciOIzqkD430jPEBobIxddvuh86QgOT4B2w6zGdFf5pSrV8aoF/chosOmzAEmCBRxLmqRKGKosdXkst7yHIzLkSfZ8QyLGjoJp2fO52LSkI82SWgPvpbg6o9hpGaM2hxlhJIW5nASH49LL7g09uQE5b3ixaa8eT2j4LYxmnJkdXCH1mNoM2uVfW4J3f/Si6IVOcDYJ7aMeqXhSKWF4DRgQt8EmaabUvuUnKzeFWSMtKrZCw0x195FtQwKo2l8QRnCLjug1klP6inMMoOj8gv0O1RoaACSPwxx0TXsuwFfgwGqFHClaF/S0BCbRku8oH0FwauMltzE44tWM7A0fU2hhYcXiSn3unE57s2gW1i/Su8DjHJYhRR8XrmHtinapyLj+ji8w+NSKvmvXInbiR0+vCcuekfAcwLf8O643H51MvjjfoTjzXLUCew06rSiom+FTpccyR56fr/1SEJ401gZTAJd0KDdZsQ9Mlgx+yMi/vOS2UJ2iEOxe1FY1AViE8h5+eiIj6OYqpVaOORHoUfQgKrP2caea0XOx9gHG0ByjpGzyuS16u9iaVJQ9G5aWmPAH/uI9XvxEr70huTmTtnaanzqWXfGOI69m0WKESeZYW8YP5pma+K9U5++E0wP8SZ49+YxfyPh6R8MFctTnXM005GGKZPfs51P5dkfENm9GN0i4sSs2z7Qyo/i7nlpRT0R0am67nvADyxX3Kmom6Otth1jv/hFbZ7kmbJUCOp+egsfPjDEXA8+Le47J0wN9ypZNfGJz6oMCBiRnKeuk/QpEolfOof2c8mYpOvZpQGxno=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ko;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199015)(316002)(38100700002)(54906003)(33656002)(4326008)(64756008)(66446008)(66476007)(66556008)(8676002)(66946007)(110136005)(86362001)(122000001)(82960400001)(55016003)(76116006)(38070700005)(8936002)(7696005)(6506007)(9686003)(966005)(71200400001)(478600001)(26005)(5660300002)(2906002)(83380400001)(41300700001)(186003)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXFBRjkwWjZoN3ZKclJFOFcyN3NwNUtzVTFPdGh5Y2lCTENnNkpRUnBzQmpH?=
 =?utf-8?B?TXdDQld6em1qVE5idUQwa1NOVHV3Zk1lNitJMiszY0lZUUVHalZ0OEZFR2ha?=
 =?utf-8?B?S2JZcnRRRjdkYnRIN2xYc2xZemhHZThxaFpSQW14bTNub0twV0FEQlh6amJz?=
 =?utf-8?B?dnpWSmh6VncwQWNpSm11L2JFbi93eVVWSTlhNEZjbWhncVIzeERzanRFTW82?=
 =?utf-8?B?NzFyeHp5NXRSRFZYMjVTTklNdWlkRGx1L2lsbXJxRW13SWtocHpQZCtMZ2R6?=
 =?utf-8?B?MHJpQjNzOCs1RHUrWm9OMGRGTUVSZzNlMXQzUEJiWWlBekpPNnlNK0FNMjlC?=
 =?utf-8?B?aEJUOWl0bnl1WHUvKzlxOFA1VFdsZVoyNm9OdzRFSjY3ejI0bExlNmxycW9z?=
 =?utf-8?B?Tnh0UnRVeHV3VXJoRDNVQXo5OWp4YUFaUjF6RkprN3pqaUFJaWx0aGNlSnMx?=
 =?utf-8?B?REVPaFV1UG5CM1VFMXBiSHdOSjVsSlRBUEZxSHZoaFl0bkYyQm5qNVljRk0z?=
 =?utf-8?B?MFhicExqcUZ0RG05UkpGTTFBOVhPTHJsaG9QYnRkN3VKQ0pPZzV4ZGxZeDdV?=
 =?utf-8?B?REJ6UEZTM0tibDBBQWZZenRLZnZObGtiWnUrRFJCUDRPSS9QYWRRZ1NyWHpN?=
 =?utf-8?B?WU5LQ0plUnpLL1I1UUU0bmo2dmp4N0lPaHpEaTJXUUJYVlI0WTRyOHgzSHFs?=
 =?utf-8?B?SFQyNi9iaHZwMmpEeUoycGVMNUlVemdKcTFsVFkvb1pKenNkbkRxUU5PaEVt?=
 =?utf-8?B?dlR4VVppWCtIeXFXYkdKNVg5SHJOR01malFOcHRnSW1lMENzMWZSeGR5NUlS?=
 =?utf-8?B?WXBxRXNUZ0NqK3YwaFJzSUFsTEFYK25HMjZaZkVwRHV4YzQwWXdUVGJGQVc4?=
 =?utf-8?B?Ukw2bWFhNlFBL2R0ajVpcWN4YXNZdUNsVU9vakljRmQvcVNhSTI2U2k3Wk1n?=
 =?utf-8?B?QVB1NHhrTG5KbjFGbVJkNHZWaFNwSEVNNS9yOGpWS3dENXRXNWgvdlRXVDEv?=
 =?utf-8?B?UCtFelY4VFUwZTd1OW80eHh5OW1UVU5aSEVSYUVvbXNkVzN0ak5mVUlUYU0z?=
 =?utf-8?B?NEZIQ1NuWEdnZTJLT29uT0RMRXJrS1N6RnRvNmRibFlVVGljRXZRYzhsSlVO?=
 =?utf-8?B?WHZNZFNLaDFBTlJ0VUovbVhqQWsydzRNcW1JU0FGVE5JNE5FS2tkWk5acHli?=
 =?utf-8?B?VmU5a0gvbFdvWCthWThYRm1hRG15TkZ3QzkydXMwQ0dFc2RLTlhGajF5eElj?=
 =?utf-8?B?STdhelZoWVM5bStrK3h5OE9CR2VwVXdNVFN0dFdXU2dhN0RsUVJXWkJuQVF5?=
 =?utf-8?B?VDVZa2tyYzF4OTNicmthNS9zVldqbHlHWHRseVpDUW1MU2NrNFNIYWwrTTJU?=
 =?utf-8?B?QnFiTDhDTjJvMEx3OFNGeVorZGgyQlFQL3NPQjN3RCtNeUEvMnpYa2hXMVpH?=
 =?utf-8?B?bVRWRC9BSTJjTFJRbmRaWURPMHY2SnkxSWZUdFJEc2UvWEFscllzT1BlMzg2?=
 =?utf-8?B?dGJsNWhlZ1R3SWhWcEJRcXlhdHI1cWdlK3AybTQyQ2FHbVVwOFgzbGRKclFn?=
 =?utf-8?B?Snl3TEhtbU5jMXRlY2paSjFUeHM5MVlEN3RIK25obXZ6bzB1WW1hSzAwQW1w?=
 =?utf-8?B?TmNUZm9yZ2hoWmRTNnBCbUN6NVN4bDBCUTUvZEV3VHdrbjdEOENyWjE0UnI2?=
 =?utf-8?B?bTNRYnlRVGxneWxYcEt1OFUxbHB1dXF2RHpKWHVBZWV6ZGw5cW5hTnBpMy9B?=
 =?utf-8?B?L3V6RkVKSGE1REk3NnluK0ZUcDNkK09BZFplMFY5Z2NGaGsvUmVJTmdvRUsz?=
 =?utf-8?B?YnhpVTRFQUowN1FidnpJbXROYVdaR2gxVGlPQjFJeEhEdDFtZHNqRXNsU1hH?=
 =?utf-8?B?dDEwY3ZpbFNLSXdEOGU5UlY2b3ZxMG5ITDRIaHZkai81bjgwV3NQOGdwZHBi?=
 =?utf-8?B?VTB3Q1laUXJLY2tnV1JtR0JyOXNkZ0o3L1B0Z1BuRGhZWnkyM1RqUkRLMEgr?=
 =?utf-8?B?cEVQWTVDNXAwbFRlWVpUdFE1TFNCem5xZU9DUlNZbXBXWklKMDBtanBGdTJx?=
 =?utf-8?B?V21ITUpYSXZwdHNVUWUyUHRjOHBWQUhjZGVQck1xQ3RuY1hjSzJsb1RTT2c3?=
 =?utf-8?Q?4E6P/fXaYPT/8liMb4mBs+aNQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aed820c3-b6d7-4908-1359-08dab6624bdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 08:24:12.1732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gNY5YxHOCdeyILXv8tk9SoePw1f1owBkNtjkv3Dzpiz86itV8+vugV6dSiEQNx5I5s75wAHk+lby7wwKt/ZuKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5983
X-OriginatorOrg: intel.com
Received-SPF: pass (spool3: domain of intel.com designates 192.55.52.115 as permitted sender) client-ip=192.55.52.115; envelope-from=hongzhan.chen@intel.com; helo=mga14.intel.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=intel.com header.s=Intel header.b=NuH534yB;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (spool.mail.gandi.net: domain of hongzhan.chen@intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=hongzhan.chen@intel.com;
	arc=pass ("microsoft.com:s=arcselector9901:i=1")

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IOq5gOuPmeyjvChEb25nam9v
IEtpbSkg7LGF7J6E7Jew6rWs7JuQIOuRkOyCsOuhnOuztO2LseyKpA0KPjxkb25nam9vNS5raW1A
ZG9vc2FuLmNvbT4NCj5TZW50OiBUdWVzZGF5LCBPY3RvYmVyIDI1LCAyMDIyIDM6MjkgUE0NCj5U
bzogQ2hlbiwgSG9uZ3poYW4gPGhvbmd6aGFuLmNoZW5AaW50ZWwuY29tPjsgeGVub21haUB4ZW5v
bWFpLm9yZw0KPkNjOiDrsJXsmIHssqAoWW91bmdjaHVsIFBhcmspIOyImOyEneyXsOq1rOybkCDr
kZDsgrDroZzrs7Tti7HsiqQNCj48eW91bmdjaHVsMy5wYXJrQGRvb3Nhbi5jb20+OyDrsJXqsr3t
m4goS3l1bmdob29uIFBhcmspIOyImOyEneyXsOq1rOybkA0KPuuRkOyCsOuhnOuztO2LseyKpCA8
a3l1bmdob29uMi5wYXJrQGRvb3Nhbi5jb20+OyDquYDshLjtmIQoU2VoeXVuIEtpbSkNCj7sl7Dq
tazsm5Ag65GQ7IKw66Gc67O07Yux7IqkIDxzZWh5dW4yLmtpbUBkb29zYW4uY29tPjsg6rmA64+Z
7KO8KERvbmdqb28gS2ltKQ0KPuyxheyehOyXsOq1rOybkCDrkZDsgrDroZzrs7Tti7HsiqQgPGRv
bmdqb281LmtpbUBkb29zYW4uY29tPjsg7J207J6s7ISdKEphZXN1ayBMZWUpDQo+7IOB66y0IOuR
kOyCsOuhnOuztO2LseyKpCA8amFlc3VrLmxlZUBkb29zYW4uY29tPjsg7J207JiB7J6sKFlvdW5n
amFlIExlZSkNCj7so7zsnoTsl7Dqtazsm5Ag65GQ7IKw66Gc67O07Yux7IqkIDx5b3VuZ2phZTcu
bGVlQGRvb3Nhbi5jb20+OyDquYDsg4HspIAoU2FuZ2pvb24NCj5LaW0pIOyImOyEneyXsOq1rOyb
kCDrkZDsgrDroZzrs7Tti7HsiqQgPHNhbmdqb29uLmtpbUBkb29zYW4uY29tPg0KPlN1YmplY3Q6
IFJFOiBXaGF0IGNhdXNlcyB0aGUgbGF0ZW5jeSBvZiB0aGUgcnRfdGFza195aWVsZCgpIEFQST8N
Cj4NCj5EZWFyIFhlbm9tYWkub3JnLCBDaGVuLCBIb25nemhhbg0KPg0KPkknbSBkb25nIGpvby4N
Cj4NCj5BZnRlciB3ZSBkbyBhIGFnaW5nIHRlc3QgYXMgbGlrZSBsYXRlbmN5LA0KPldlIGdldCBh
IHN5c3RlbSBoYW5nIGFib3V0IHRlbiBob3VycyBsYXRlci4NCj4NCj5BdCB0aGF0IHRpbWUsIE91
ciBzeXN0ZW0gZG9uJ3QgZGV0ZWN0IHVzYiBtb3VzZS4NCj4NCj5BZnRlciByZWJvb3Rpbmcgb3Vy
IHN5c3RlbSBieSBmb3JjZSwNCj50aGVyZSBpcyBubyBzaWduaWZpY2F0aXZlIGxvZyBpbiB0aGUg
a2VybmVsIGxvZyBvciBzeXNsb2cuDQo+DQo+Q291bGQgeW91IGhlbHAgdG8gdXMgaG93IHRvIHNv
bHZlIHRoaXMgaXNzdWUgPw0KDQpKdXN0IGFzIG1lbnRpb25lZCBhcyBpbiBodHRwczovL3hlbm9t
YWkub3JnL3BpcGVybWFpbC94ZW5vbWFpLzIwMjItQXByaWwvMDQ3NDk1Lmh0bWwNCjEuIEl0IGlz
IGhpZ2hseSByZWNvbW1lbmRlZCB0byB1c2UgYSBVQVJUIGFzIGtlcm5lbCBkZWJ1ZyBvdXRwdXQu
DQoyLiBlbmFibGUgQ09ORklHX1hFTk9fT1BUX1dBVENIRE9HIGZvciB4ZW5vbWFpLCBzeXN0ZW0g
d2lsbCBiZSBhYmxlIHRvIHRlbGwNClJUIGFwcGxpY2F0aW9uICJoYW5ncyIgKGluZmluaXRlIGxv
b3AgYXQgaGlnaCBwcmlvKSBhcGFydCBmcm9tIHJlYWwgaGFuZ3MvY3Jhc2hlcy4NCg0KUmVnYXJk
cw0KDQpIb25nemhhbiBDaGVuDQo+DQo+DQo+V2Ugc2V0IHVwIG91ciBzeXN0ZW0gYXMgbGlrZSBi
ZWxvdyBzdy4NCj4NCj4xLiBYdWJ1bnR1IDE4LjA0IExUUyAzMmJpdA0KPg0KPjIuIExpbnV4IGtl
cm5lbCA0LjEuMTggMzJiaXQNCj4NCj4zLiBYZW5vbWFpIDMuMC44IDMyYml0DQo+DQo+NC4gS2Vy
bmVsIGNvbmZpZw0KPiAgIFdlIHJlZmVyIHRvIHRoZSB4ZW5vbWFpIHBhZ2UgYXMgbGlrZSBiZWxv
dy4NCj4NCj5odHRwczovL3NvdXJjZS5kZW54LmRlL1hlbm9tYWkveGVub21haS8tDQo+L3dpa2lz
L0NvbmZpZ3VyaW5nX0Zvcl9YODZfQmFzZWRfRHVhbF9LZXJuZWxzI3VzZXItY29udGVudC14ODYt
DQo+cHJvY2Vzc29yLXR5cGUNCj4NCj5UaGFua3MuDQo+DQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj5Gcm9tOiBDaGVuLCBIb25nemhhbiA8aG9uZ3poYW4uY2hlbkBpbnRlbC5jb20+DQo+
U2VudDogRnJpZGF5LCBBdWd1c3QgMjYsIDIwMjIgMjo0MCBQTQ0KPlRvOiDquYDrj5nso7woRG9u
Z2pvbyBLaW0pIOyxheyehOyXsOq1rOybkCDrkZDsgrDroZzrs7Tti7HsiqQNCj48ZG9uZ2pvbzUu
a2ltQGRvb3Nhbi5jb20+OyB4ZW5vbWFpQHhlbm9tYWkub3JnDQo+Q2M6IOuwleyYgeyyoChZb3Vu
Z2NodWwgUGFyaykg7IiY7ISd7Jew6rWs7JuQIOuRkOyCsOuhnOuztO2LseyKpA0KPjx5b3VuZ2No
dWwzLnBhcmtAZG9vc2FuLmNvbT47IOuwleqyve2biChLeXVuZ2hvb24gUGFyaykg7IiY7ISd7Jew
6rWs7JuQDQo+65GQ7IKw66Gc67O07Yux7IqkIDxreXVuZ2hvb24yLnBhcmtAZG9vc2FuLmNvbT47
IOq5gOyEuO2YhChTZWh5dW4gS2ltKQ0KPuyXsOq1rOybkCDrkZDsgrDroZzrs7Tti7HsiqQgPHNl
aHl1bjIua2ltQGRvb3Nhbi5jb20+DQo+U3ViamVjdDogUkU6IFdoYXQgY2F1c2VzIHRoZSBsYXRl
bmN5IG9mIHRoZSBydF90YXNrX3lpZWxkKCkgQVBJPw0KPg0KPuyjvOydmDog7J20IOuplOydvOyd
gCDsmbjrtoDsl5DshJwg67Cc7IahIOuQmOyXiOyKteuLiOuLpC4g66eB7YGsIO2YueydgCDssqjr
toDtjIzsnbwg7Je0656MIOyLnA0KPuyjvOydmO2VmOyLnOq4sCDrsJTrno3ri4jri6QuDQo+DQo+
Q0FVVElPTjogVGhpcyBlbWFpbCBpcyBzZW50IGJ5IGFuIGV4dGVybmFsIGFjY291bnQuIFBsZWFz
ZSB0YWtlIGV4dHJhIGNhdXRpb24NCj53aGVuIGNsaWNraW5nIHRoZSBsaW5rIG9yIG9wZW5pbmcg
dGhlIGF0dGFjaG1lbnQuDQo+DQo+Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+PkZyb206
ID8/PyhEb25nam9vIEtpbSkgPz8/Pz8gPz8/Pz8/IDxkb25nam9vNS5raW1AZG9vc2FuLmNvbT4N
Cj4+U2VudDogRnJpZGF5LCBBdWd1c3QgMjYsIDIwMjIgMTA6NDEgQU0NCj4+VG86IENoZW4sIEhv
bmd6aGFuIDxob25nemhhbi5jaGVuQGludGVsLmNvbT47IHhlbm9tYWlAeGVub21haS5vcmcNCj4+
Q2M6ID8/PyhZb3VuZ2NodWwgUGFyaykgPz8/Pz8gPz8/Pz8/DQo+PHlvdW5nY2h1bDMucGFya0Bk
b29zYW4uY29tPjsgPz8/KEt5dW5naG9vbiBQYXJrKSA/Pz8/PyA/Pz8/Pz8NCj48a3l1bmdob29u
Mi5wYXJrQGRvb3Nhbi5jb20+OyA/Pz8oU2VoeXVuIEtpbSkgPz8/ID8/Pz8/Pw0KPjxzZWh5dW4y
LmtpbUBkb29zYW4uY29tPjsgPz8/KERvbmdqb28gS2ltKSA/Pz8/PyA/Pz8/Pz8NCj48ZG9uZ2pv
bzUua2ltQGRvb3Nhbi5jb20+DQo+PlN1YmplY3Q6IFJFOiBXaGF0IGNhdXNlcyB0aGUgbGF0ZW5j
eSBvZiB0aGUgcnRfdGFza195aWVsZCgpIEFQST8NCj4+DQo+PkRlYXIgWGVub21haS5vcmcsIENo
ZW4sIEhvbmd6aGFuDQo+Pg0KPj5JJ20gZG9uZyBqb28uDQo+Pg0KPj5UaGFuayB5b3UgZm9yIHlv
dXIgcmVwbHkgdG8gdXMgb3VyIHF1ZXN0aW9ucy4NCj4+DQo+PkFuZCwgV2UgaGF2ZSBjaGVja2Vk
IHRoZSB2YWx1ZSBvZiBUSUNLX05TRUMgaW50IG91ciBzeXN0ZW0uDQo+Pg0KPj4jZGVmaW5lIFRJ
Q0tfTlNFQyAoKE5TRUNfUEVSX1NFQytIWi8yKS9IWikNCj4+I2RlZmluZSBOU0VDX1BFUl9TRUMg
ICAxMDAwMDAwMDAwTA0KPj5IWiAgMjUwICggTWF4IDEwMDAgKQ0KPj4NCj4+VGhlIHZhbHVlIG9m
IFRJQ0tfTlNFQyBpcyBkZWZpbmVkIGJ5IGxpbnV4IGtlcm5lbC4NCj4+QW5kLCBCb3RoIE5TRUNf
UEVSX1NFQyBhbmQgSFogY2FsY3VsYXRlIHRoZSB2YWx1ZSBvZiBUSUNLX05TRUMuDQo+Pg0KPj5T
bywgVGhlIGN1cnJlbnQgdmFsdWUgb2YgVElDS19OU0VDIGlzIDRtcyBiYXNlZCBvbiAyNTAgSFou
DQo+PkFuZCwgSWYgd2UgY2hhbmdlIHRoZSB2YWx1ZSBvZiBIWiB0byAxMDAwLCBUaGUgdmFsdWUg
b2YgVElDS19OU0VDIG1heSBiZQ0KPjFtcy4NCj4+DQo+Pg0KPj5XZSBob3BlIHRvIHByb2Nlc3Mg
YSB0YXNrIGV2ZXJ5IDIwdXMgdXNpbmcgcnRfdGFza195aWVsZCBhcyBsaWtlIFhlbm9tYWkNCj4y
LjYuNS4NCj4+DQo+PklzIHRoZXJlIGFueSBtZXRob2QgdG8gYWNoaWV2ZSAyMHVzIHRhc2sgZGVs
YXkgdXNpbmcgcnRfdGFza195aWVsZCBvciBhbm90aGVyDQo+eGVub21haSBtZXRob2QgPw0KPj5B
bmQsIElzIHRoZXJlIGFueSBwcm9ibGVtIHRvIHJlZHVjZSB0aGUgZGVsYXkgbW9yZSBsZXNzIHRo
YW4gVElDS19OU0VDID8NCj4NCj5JIGp1c3Qgd2VudCB0aHJvdWdoIHRoZSBpbXBsZW1lbnRhdGlv
biBvZiBydF90YXNrX3lpZWxkIG9mIFhlb21haSAyLjYuNSBhbmQNCj5mb3VuZCB0aGF0IGl0IGlz
IHRvdGFsbHkgZGlmZmVyZW50IGZyb20gWGVub21haSAzLjAuOC4NCj5JZiB5b3Ugd2FudCB0byB5
aWVsZCBhYm91dCAyMHVzIGZvciBjdXJyZW50IFJUIHRocmVhZCAseW91IG1heSB0cnkgY2FsbA0K
PmNsb2NrX25hbm9zbGVlcCAuDQo+Lg0KPlJlZ2FyZHMNCj4NCj5Ib25nemhhbiBDaGVuDQo+Pg0K
Pj4NCj4+UmVhbGx5IFRoYW5rcy4NCj4+DQo+DQo+DQo+VGhpcyBlLW1haWwgYW5kIGFueSBhdHRh
Y2htZW50cyBoZXJlaW4gbWF5IGNvbnRhaW4gY29uZmlkZW50aWFsIG9yIHByaXZpbGVnZWQNCj5p
bmZvcm1hdGlvbiBhbmQgaXMgZm9yIHRoZSBleGNsdXNpdmUgdXNlIG9mIHRoZSBpbnRlbmRlZCBy
ZWNpcGllbnQocykgbmFtZWQNCj5hYm92ZS4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJl
Y2lwaWVudChzKSwgeW91IHNob3VsZCBub3QgZGlzc2VtaW5hdGUsDQo+ZGlzdHJpYnV0ZSwgcmV0
YWluLCBjb3B5IG9yIG90aGVyd2lzZSB1c2UgYW55IGluZm9ybWF0aW9uIGNvbnRhaW5lZCBoZXJl
aW4uIElmDQo+eW91IGhhdmUgcmVjZWl2ZWQgdGhpcyBlLW1haWwgaW4gZXJyb3IsIHBsZWFzZSBu
b3RpZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseSBieQ0KPnJlcGx5aW5nIHRvIHRoaXMgbWVzc2Fn
ZSBhbmQgZGVsZXRlIHRoaXMgZS1tYWlsIGFuZCBhc3NvY2lhdGVkIGF0dGFjaG1lbnRzLg0KPk91
ciBjb21wYW55IGRvZXMgbm90IGd1YXJhbnRlZSB0aGlzIGUtbWFpbCBpcyBzZWN1cmUgb3IgZnJl
ZSBmcm9tIHZpcnVzZXMuDQo+7J20IOuplOyLnOyngCDrsI8g7LKo67aA7J6Q66OM64qUIOuyleul
oOyDgSDruYTrsIDroZwg67O07Zi465CY7Ja07JW8IO2VoCDrgrTsmqnsnYQg7Y+s7ZWo7ZWY6rOg
DQo+7J6I6rOgIOygleuLue2VnCDsiJjsi6Dsnbjsl5Dqsozrp4wg7KCE64us7ZWgIOuqqeyggeyc
vOuhnCDrsJzshqHrkJjsl4jsnLzrr4DroZwg7KCV64u57ZWcDQo+7IiY7Iug7J247J20IOyVhOuL
iOudvOuptCDrgrTsmqnsnZgg6rO16rCcLCDrsLDtj6wsIOuztOq0gOydgCDrrLzroaAg7Ja065ak
IOyaqeuPhOuhnOuPhCDsnbTrpbwNCj7snbTsmqntlaAg7IiYIOyXhuycvOupsCwg67O4IOuplOyd
vOydmCDsnpjrqrvrkJwg7Leo6riJ7Jy866GcIOuwnOyDne2VmOuKlCDslYjsoITshLEg66y47KCc
7JeQDQo+6rSA7ZWY7JesIOuLueyCrOuKlCDslYTrrLTrn7Ag7LGF7J6E64+EIOyngOyngCDslYTr
i4jtlajsnYQg7JWM66CkIOuTnOumveuLiOuLpC4g7J6Y66q7IOyImOyLoO2VmOyLoA0KPuqyveya
sOyXkOuKlCDsponsi5wg7Iah7Iug7J6Q7JeQ6rKMIO2ajOyLoO2VmOyXrCDslYzroKTso7zsi6Ag
7ZuEIOyCreygnO2VmOyXrCDso7zsi5zquLANCj7rsJTrno3ri4jri6QuIO2YkeyhsOyXkCDqsJDs
gqwg65Oc66a964uI64ukLg0K
