Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E8F23A5
	for <xenomai@lists.linux.dev>; Fri, 26 Aug 2022 05:40:19 +0000 (UTC)
Received: from spool.mail.gandi.net (spool3.mail.gandi.net [217.70.178.212])
	by relay.mail.gandi.net (Postfix) with ESMTPS id E4729200005
	for <xenomai@lists.linux.dev>; Fri, 26 Aug 2022 05:40:14 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 55E4CAC0A94
	for <xenomai@xenomai.org>; Fri, 26 Aug 2022 05:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661492413; x=1693028413;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VfDw1wZO8LD0PDr7dsOxVFKf3RIMnCzAZCUhu2dbRVw=;
  b=axpj9FEUBO8qihOH7jLY2nobDkkL/dnzC9UkqJc6+NggblwQjiGfYmCL
   wDiJZ4Y06Uu/cxI+6/1Cokf++ec38oG81JagF8WvBiurzci/7WAMipEHe
   P/1ni0ckvWTnG6rSd2M/huUlnhA1I8NLjPJpk0t5CalfnD8arSuMvW5QS
   6lQhgPqHI0DpoMusc+YYDKzSc3qGRly25WhV9qw4quDQqVshWMn9ufJIf
   vrd0XEhJ8cMXVfx+rMe7dXOXIcOvPyNKbvv6QTUJXYt76GUHRqTOyXoiU
   dkPongfa++xK75jcsZ6EjkKOsN2IaWR8TgaBmPUajCuY/1wK/KPODEsr/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="358397306"
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="358397306"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 22:40:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="786273216"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 25 Aug 2022 22:40:10 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 25 Aug 2022 22:40:09 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 25 Aug 2022 22:40:09 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 25 Aug 2022 22:40:09 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 25 Aug 2022 22:40:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFBFwEPYGu3Y+CQ5FpIlHYkyU7hkkF41deSqoEAeZ5sw/Wj6pdB6OfXiG1sPoBkOsZuUJ94waAJXe9qHZKzOUKIAdQku3yPS2yHG+m3HqgLhOzfk1BkA8qC44Revpda+hiVsvI6wBNcey8H8Sl3hv7DBpbv1jqM9q05SQmG8qxXoeAKMXJPHl89exQukQJuKm3c+qcgd5Slpq+8C8LvetOTVU0cigAkdjyrSZm0YE30SE51iIdZnHE1MyF90VI+KoQLCynBuOpYAYiqWae0bF+foJMNgsj3eDmsvaF2Qbd+uiXFQdVJQYa099oPFh8eebSZ8TWFDB8BB2w5LuS9Xag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfDw1wZO8LD0PDr7dsOxVFKf3RIMnCzAZCUhu2dbRVw=;
 b=nZTHcPMGaDnve9tmibDmdXF7Izfz6JO7xs1oO1DYRDTh+fdT3+4ltdlymGbkgtd31xXrV95r3hF8z5bbsVnp1rj1D7qq06scG86M+Yo3gayZYPUZahDhLjsmTolmi6wOR7VqUspvpe9C0k5/rpo9CJP6Xv10vIPy8Td3oHoIhMh9b9Pesk3zIcB7zYof2XAaoWk9me46KSbeP9Irj6iAzbN8g0Bdpr/f1C+uqDld+sALx9GzlQrqEJQxPyH522YlbWSswTvWq60+gQc55f0MMAYAWzMe8BF38ONKD+pWNNfgk9FCWTi0gGmtecHWNOkLRe/i1/t3C5MpvKXUfVuxeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by DM6PR11MB4513.namprd11.prod.outlook.com (2603:10b6:5:2a2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 05:40:00 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::159d:a6de:f2b9:fc83]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::159d:a6de:f2b9:fc83%3]) with mapi id 15.20.5566.015; Fri, 26 Aug 2022
 05:40:00 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: =?utf-8?B?6rmA64+Z7KO8KERvbmdqb28gS2ltKSDssYXsnoTsl7Dqtazsm5Ag65GQ7IKw?=
 =?utf-8?B?66Gc67O07Yux7Iqk?= <dongjoo5.kim@doosan.com>, "xenomai@xenomai.org"
	<xenomai@xenomai.org>
CC: =?utf-8?B?67CV7JiB7LKgKFlvdW5nY2h1bCBQYXJrKSDsiJjshJ3sl7Dqtazsm5Ag65GQ?=
 =?utf-8?B?7IKw66Gc67O07Yux7Iqk?= <youngchul3.park@doosan.com>,
	=?utf-8?B?67CV6rK97ZuIKEt5dW5naG9vbiBQYXJrKSDsiJjshJ3sl7Dqtazsm5Ag65GQ?=
 =?utf-8?B?7IKw66Gc67O07Yux7Iqk?= <kyunghoon2.park@doosan.com>,
	=?utf-8?B?6rmA7IS47ZiEKFNlaHl1biBLaW0pIOyXsOq1rOybkCDrkZDsgrDroZzrs7Q=?=
 =?utf-8?B?7Yux7Iqk?= <sehyun2.kim@doosan.com>
Subject: RE: What causes the latency of the rt_task_yield() API?
Thread-Topic: What causes the latency of the rt_task_yield() API?
Thread-Index: Adi2hA+8NshNMGH/S1C5hT38XRCzfAABQnKAAEPabkAAHYUU4AADTiNwAAcm6LAABFvNgAAqXeuQAAWtTIA=
Date: Fri, 26 Aug 2022 05:40:00 +0000
Message-ID: <MN2PR11MB4285C21FFFA82081782F2CDFF2759@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <SE2P216MB1394874A00E10A497FE73DE0C2709@SE2P216MB1394.KORP216.PROD.OUTLOOK.COM>
 <MN2PR11MB428519AFC0F522BB25FDA093F2709@MN2PR11MB4285.namprd11.prod.outlook.com>
 <SE2P216MB1394C7C6A067126F36022F23C2739@SE2P216MB1394.KORP216.PROD.OUTLOOK.COM>
 <SE1P216MB1509579188F44BA6C35E8547B1739@SE1P216MB1509.KORP216.PROD.OUTLOOK.COM>
 <BY5PR11MB4276CD67150EE6042EB1A849F2729@BY5PR11MB4276.namprd11.prod.outlook.com>
 <SE1P216MB1509E22586BCCE1E4899A946B1729@SE1P216MB1509.KORP216.PROD.OUTLOOK.COM>
 <MN2PR11MB4285E860217DB23B18016495F2729@MN2PR11MB4285.namprd11.prod.outlook.com>
 <SE1P216MB1509ED1D62553AC566FDA209B1759@SE1P216MB1509.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <SE1P216MB1509ED1D62553AC566FDA209B1759@SE1P216MB1509.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60a96d8e-d8f9-49e4-c4d2-08da87256aca
x-ms-traffictypediagnostic: DM6PR11MB4513:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZJUyBCs68mJVU6/S9STf3My4T7EFW/XGzhFcdF3M4o7Nl0x/vWbkKpPsm5wgXTmTI3BGNuBFyZoleO6nw53VujJhqIAawkarFPyzM+IpehO/OSLJCRNDCshIqz8CEqnz2oiDS5lWQwkAdH5vlKDH1bN9LdSzkjAVOMer0wVbaqVBcJ/g/tVtEMAk3wrJ5HMcDIoZpvj0Ad7S6nEIUTZiWxATnMdt2SRa6YRs1fetP281bDSkAxK5FrdPov6wjOxp1m8tJ9FeyKwfv1eo01FJmZkSw4hWavug006vZs/rCFiVoeXpGajFVqZfiz4lloW/v/vTYZed0oPOHqquNxjqHMF22KqZ2X55x3RPd4pkn25b+mlnLEKEQmXY5PfrL5PtfZf2izqHveU9M3u7jIrrGS+6pNGpiAD0us+DZBIgUxnMucprNP8qbIz1XveKfsrsxJRTJXBNFG3GHCgX32Ik8vki2ocN1WW5iheQOQ2gO2uui6iniESCD8iEpr5tr9cuKN5tj39kUH+emmUjgSIoxbx0asQeF894Oe8Wlx3ettvlILEPkEbjAas4w5Gn3BIDLnHcc1kqXxlds9mLOxb+oLhapZE5jWjvpqaPfcZb6HBF4A3qr9SY7tSK70qcnYEX5XMIz02swITbmGMbVk/f91NvjPHdGnh2tCjxF1YGPZ05P0orpwL/K2lJQQDBd5Osqf+mXuP4OiSjmRRUvQCmrdrUXXkeO/jG7FWN0fz0uz1pDFcQi/5GAObCLvAq/couGAEfR6pegnaxj5FbeTjbtA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(346002)(396003)(376002)(366004)(38100700002)(7696005)(122000001)(6506007)(86362001)(316002)(54906003)(55016003)(2906002)(71200400001)(110136005)(82960400001)(83380400001)(186003)(41300700001)(38070700005)(5660300002)(52536014)(8936002)(26005)(76116006)(66946007)(66556008)(66476007)(66446008)(4326008)(64756008)(8676002)(9686003)(478600001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azg5MGtEMEQ3WTBnREFNSE1vK0hhUTRFMW9rcnRqSDhQc0tKeGsxSEhTYVRv?=
 =?utf-8?B?YmlPL1FvRDhsbUF3ZjM3Q3Y3RWpBT29ESDhNb1E2US9pTTBsNC9HTDNsQ1Nu?=
 =?utf-8?B?VUsyeitQS2d3WWxhTDQ3UWpQbEV2dUJGRFFhQ2RaNkUvcG1ESmdjeVF3UFIv?=
 =?utf-8?B?aUhUYWQ5dWNHeDM1UjEvREtvbHdnWTZKRFJyajdtdXZpUnAzbXpDK3pUeFY5?=
 =?utf-8?B?TXpoVGI0d3BXbit3SHRvcmlsMjBuT3U0QndNNTJaZlpVdGVDNVZpeWp1VVJw?=
 =?utf-8?B?ZDFia0wrN2RjYVl5Sy9hdUVndmxydGpXWXZYMVJlSjlTTzNqbUZSQ0E4NnFI?=
 =?utf-8?B?SXY2aUUwaHRkWTBNcGlGbW4yTXhzejArMDRSeDdiSDl1WVc5WVhrZXp4ek8y?=
 =?utf-8?B?NWdyV0xtYngwTyt6Q0hibGdiM2VYRUxRUXZiZkFzeWljS0t6bzc4VUZtYk9y?=
 =?utf-8?B?Zkt6OVFnL0pFeUo4RWN3ZFltZ3FnYWdtSEhCc3ZWZFVpRlpCVDRUSjhValZj?=
 =?utf-8?B?R3pRa0ZsLzNCY1JpTDVEM0xzU0dPK0hpUzdoa093Qjg0YzB1Qk1tdlNDaGtE?=
 =?utf-8?B?NzRQK284T2VKNmFvMG1ITlN5TEl1cngvY3FHUFQ3UHNCd2lHYlVSNWtwU3hX?=
 =?utf-8?B?cnpHYkV1d2pPOTFTVzJVU3NGVkNNNGFNMHlSTXg2aXhucjhGRCtpSGprNlp2?=
 =?utf-8?B?OVZmUytDdk15d3Q0UWkxYmFINUhpMmhpVVV4NG9mbU5HZitrK3dDQTladmt1?=
 =?utf-8?B?QUd1blNORi9tZ0M5RDY5NGh0b3F4eDUvRWpKcnNhS1JhTStYRno5MHZVazhi?=
 =?utf-8?B?ZTA1R1Fad1I4eFlQUzlIYlY4QjFkSEg0TWdZdTQyL2FUeEdOQlczSWVhZjRz?=
 =?utf-8?B?QkFOV3NXeDJOWXA1aUdCbnFGSTh1ZjFrRHhyZFBQMWc1Tkd0UCtwK0VSalRm?=
 =?utf-8?B?cTh3TjZDL0NvaGlsTnNsNmNaa0U0S1YraUhZTFRmcEU4ZVo5UEcyTFZqT1NB?=
 =?utf-8?B?OU5FZ01KMWdsWmkya0g3WEtrQk5rMnUyNlFvUkpEdUdwMmp1bXRLbWRlNnEr?=
 =?utf-8?B?K3pLK0w3a2FlbGVidHdWR3AycGZzOGlqckJMaUFTRm10QXRkbVVUQUVES2xY?=
 =?utf-8?B?cXN5U0t3K0dhTzZrcjNpWjZZRUpPWDd6YVlmdUFXRjlnUnNCMFloeG1HenZS?=
 =?utf-8?B?OEk2STU4ZG5tV2hRUVJGS3VIUGRialFOT2hyblB3SktjOG4yL1pZcmJaelps?=
 =?utf-8?B?bGczNHFGeDVsL1pXaktEc1J1V3VXRjFNdE56ZVNFek90ajVlekIzUDBwZlhj?=
 =?utf-8?B?WkIwekVrNFZhS2JZREppQkI2VCtjdmorejI5VXg2K2hSNFlHNmZRRHVBT1Bu?=
 =?utf-8?B?akZiZG1uZ3UraU9NV0VlVlhiRldSOGhJK1c4RkgvS0JWc3hhUEIxNzNidE9o?=
 =?utf-8?B?eEViOWEvZGx6VFVZMkI0SmoxQkRFWlR1K2dlUmZRV0ZHQVBxZUJ0M2pxN0R1?=
 =?utf-8?B?NFpVVVphS3VWLzBicm9SYXZGMWZ1L2psUGpUcHNadGlMeGc1b095NkJScW4z?=
 =?utf-8?B?L1Bzc2syRTNqYUpLTzljbi9OZGl2SjdsOGZBLzB4QkVrc1c4a0dGWllUTjB6?=
 =?utf-8?B?VkI3M2k0c1QwaUxHVkMxZHh1TzZYYVRQSmJYVFFyaCs4Y1RqU09oQWJLaHRL?=
 =?utf-8?B?azN2OFdkaXl2U3RRY0lseGljZDVBaG56SXhabThUNXIzWkcwZlpWY095ZmQ5?=
 =?utf-8?B?WDBTVG9lbDErbVJSQnUvNnBVcFNVTUx3ckV1aEdNM050eHcwS3UvbmVoNC9v?=
 =?utf-8?B?a28yYUJUUlk4RTRuZzYwcEo2SWUrR0NKOWwzVDM5Y2VrWFZWUXQzeHQ0VzJm?=
 =?utf-8?B?VHV6QW9IbUF1M2lxaXlZMStXaU4wN3AyT2cxbGxCYjdGV0NpMXRwZzNSelRD?=
 =?utf-8?B?NlI5QTJQVXlML0dRZThQU3l0UEU1bWR2cU9hd0FUWE5UaEJGTlFScmRtTzVu?=
 =?utf-8?B?UlNlOWtqcVZSMm1DcTBhUnpGWjVRTmF4bUhPNDNhM3E2VHA1K0pXVDhHdDdx?=
 =?utf-8?B?dTdCWk9MUWt4b1VCQlJmb2JnMjRWZUtwT1JrYkZZSVhaNEpUNU9OeWtmVmRn?=
 =?utf-8?Q?x42sr3VEXsRSfQfjvPT/JF8td?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a96d8e-d8f9-49e4-c4d2-08da87256aca
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 05:40:00.1091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6pV9obz9ZpsyP80+8oewpUGkudVzt9yvUUvrXDRzjXbOsvNofIX1qZE14V1sOVKW7B7gj0fQk5Ik2390ZYHD/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4513
X-OriginatorOrg: intel.com
Received-SPF: pass (spool3: domain of intel.com designates 134.134.136.100 as permitted sender) client-ip=134.134.136.100; envelope-from=hongzhan.chen@intel.com; helo=mga07.intel.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=intel.com header.s=Intel header.b=axpj9FEU;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (spool.mail.gandi.net: domain of hongzhan.chen@intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=hongzhan.chen@intel.com;
	arc=pass ("microsoft.com:s=arcselector9901:i=1")

DQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiA/Pz8oRG9uZ2pvbyBLaW0pID8/
Pz8/ID8/Pz8/PyA8ZG9uZ2pvbzUua2ltQGRvb3Nhbi5jb20+IA0KPlNlbnQ6IEZyaWRheSwgQXVn
dXN0IDI2LCAyMDIyIDEwOjQxIEFNDQo+VG86IENoZW4sIEhvbmd6aGFuIDxob25nemhhbi5jaGVu
QGludGVsLmNvbT47IHhlbm9tYWlAeGVub21haS5vcmcNCj5DYzogPz8/KFlvdW5nY2h1bCBQYXJr
KSA/Pz8/PyA/Pz8/Pz8gPHlvdW5nY2h1bDMucGFya0Bkb29zYW4uY29tPjsgPz8/KEt5dW5naG9v
biBQYXJrKSA/Pz8/PyA/Pz8/Pz8gPGt5dW5naG9vbjIucGFya0Bkb29zYW4uY29tPjsgPz8/KFNl
aHl1biBLaW0pID8/PyA/Pz8/Pz8gPHNlaHl1bjIua2ltQGRvb3Nhbi5jb20+OyA/Pz8oRG9uZ2pv
byBLaW0pID8/Pz8/ID8/Pz8/PyA8ZG9uZ2pvbzUua2ltQGRvb3Nhbi5jb20+DQo+U3ViamVjdDog
UkU6IFdoYXQgY2F1c2VzIHRoZSBsYXRlbmN5IG9mIHRoZSBydF90YXNrX3lpZWxkKCkgQVBJPw0K
Pg0KPkRlYXIgWGVub21haS5vcmcsIENoZW4sIEhvbmd6aGFuDQo+DQo+SSdtIGRvbmcgam9vLg0K
Pg0KPlRoYW5rIHlvdSBmb3IgeW91ciByZXBseSB0byB1cyBvdXIgcXVlc3Rpb25zLg0KPg0KPkFu
ZCwgV2UgaGF2ZSBjaGVja2VkIHRoZSB2YWx1ZSBvZiBUSUNLX05TRUMgaW50IG91ciBzeXN0ZW0u
DQo+DQo+I2RlZmluZSBUSUNLX05TRUMgKChOU0VDX1BFUl9TRUMrSFovMikvSFopDQo+I2RlZmlu
ZSBOU0VDX1BFUl9TRUMgICAxMDAwMDAwMDAwTA0KPkhaICAyNTAgKCBNYXggMTAwMCApDQo+DQo+
VGhlIHZhbHVlIG9mIFRJQ0tfTlNFQyBpcyBkZWZpbmVkIGJ5IGxpbnV4IGtlcm5lbC4NCj5BbmQs
IEJvdGggTlNFQ19QRVJfU0VDIGFuZCBIWiBjYWxjdWxhdGUgdGhlIHZhbHVlIG9mIFRJQ0tfTlNF
Qy4NCj4NCj5TbywgVGhlIGN1cnJlbnQgdmFsdWUgb2YgVElDS19OU0VDIGlzIDRtcyBiYXNlZCBv
biAyNTAgSFouDQo+QW5kLCBJZiB3ZSBjaGFuZ2UgdGhlIHZhbHVlIG9mIEhaIHRvIDEwMDAsIFRo
ZSB2YWx1ZSBvZiBUSUNLX05TRUMgbWF5IGJlIDFtcy4NCj4NCj4NCj5XZSBob3BlIHRvIHByb2Nl
c3MgYSB0YXNrIGV2ZXJ5IDIwdXMgdXNpbmcgcnRfdGFza195aWVsZCBhcyBsaWtlIFhlbm9tYWkg
Mi42LjUuDQo+DQo+SXMgdGhlcmUgYW55IG1ldGhvZCB0byBhY2hpZXZlIDIwdXMgdGFzayBkZWxh
eSB1c2luZyBydF90YXNrX3lpZWxkIG9yIGFub3RoZXIgeGVub21haSBtZXRob2QgPw0KPkFuZCwg
SXMgdGhlcmUgYW55IHByb2JsZW0gdG8gcmVkdWNlIHRoZSBkZWxheSBtb3JlIGxlc3MgdGhhbiBU
SUNLX05TRUMgPw0KDQpJIGp1c3Qgd2VudCB0aHJvdWdoIHRoZSBpbXBsZW1lbnRhdGlvbiBvZiBy
dF90YXNrX3lpZWxkIG9mIFhlb21haSAyLjYuNSBhbmQgZm91bmQgdGhhdCBpdCBpcyB0b3RhbGx5
IGRpZmZlcmVudCBmcm9tIFhlbm9tYWkgMy4wLjguDQpJZiB5b3Ugd2FudCB0byB5aWVsZCBhYm91
dCAyMHVzIGZvciBjdXJyZW50IFJUIHRocmVhZCAseW91IG1heSB0cnkgY2FsbCBjbG9ja19uYW5v
c2xlZXAgLg0KLg0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQo+DQo+DQo+UmVhbGx5IFRoYW5r
cy4NCj4NCg==
