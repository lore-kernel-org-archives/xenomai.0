Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36D9A3B
	for <xenomai@lists.linux.dev>; Thu,  1 Sep 2022 07:49:15 +0000 (UTC)
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 3C02140003
	for <xenomai@lists.linux.dev>; Thu,  1 Sep 2022 07:49:07 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 4E15CD8102B
	for <xenomai@xenomai.org>; Thu,  1 Sep 2022 07:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662018546; x=1693554546;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E65zHqNEfVnq/J8a6lzGU+hz0r8azf2Gf5I83Y64UyI=;
  b=KomPM2buDZpXpnTMzeY3wqQJt5JDHacea/duB+fMlGNhecGuM1/NkkRe
   val6JySmLuL72rlSkaX3XCRsP/M4nsQKpS27/aUscrW7RGhG65Re1Weyx
   98412JNAi+DgbZvFRyGicutXIbLxAmNRHYqesCBCm3vy0FQNJMFTdiSHh
   rjZFgmJIWzYSAAic1PKdEd6zIMB6EPsQdqZMXzZf9/nn6YwqWb1Taz/IL
   1LqqherWicjgeNOI0Vqw9DL0P20kgUH8VcoUntz/mZki8kl/ic8oFZa7X
   xKcRn15MO2B8JHXm9R2mB5bXxHgtp6Pay/TKJhE1keFbZwo7YtjCZX0Wg
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="282623185"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="282623185"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 00:49:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="673734054"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP; 01 Sep 2022 00:49:03 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 00:49:02 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 00:49:02 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 1 Sep 2022 00:49:02 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 1 Sep 2022 00:49:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLYm0AoQAEs/zmR5hsehrxwRzxO887/IqaNWgarjVcZnPbhmHJf3IKYJBlyzfQ8isPv/iLsUjze2L5I2fyWZlL9v3OkWNDk02OEnKiCEtb0NYsfIqs9SwO3atHiqYri44lVKiFmwnxXtqg2N+HudxiN+ePju4PnEWw67tsiQNgHkKtxaYDrAywhqDnWF3qGG5zYtwt1wO+hO4jEVe3UkE+3GTj1PYOxKZ/Tta3FNSA7QV//gLVy9vdwYipxmiKOceI7yS9shuRmetaEMZhasmLP7CEcmvCDMRk96GRbAfcDqVHuZ+zzFpVGKLBTtQL7onLhER5u5qziBxwZKbz9+8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E65zHqNEfVnq/J8a6lzGU+hz0r8azf2Gf5I83Y64UyI=;
 b=lsWLaJRjr1Qztnfw7oO/Pd2oUKbdovvWroV1wvm55RKSbeBlbvKiYVaTHuWYsTIEqcvWvWhEVsDwGqFJszu8zJMlOEJCOhWZSrKh+HLp5G1VntoaaD/bOlpD7xGWTiGEVcqg+jbhXtnrnAzI7LjbgtEFw2kBCdZGAGa6TxuAiEDAmR/3Tfs6jslEAurvOzvl3Dl1SprKP6D81JntebL9bo8NbFFbQ96gIHMyB5EPJl7HLW4I9FKslJiaOl3N1+oIzah3SmjPv5lwmv7u58cMHyXPfAAXJXVZihyowyXbQPGwNS4SmuNeBJer/HFD2/FEzAnMKE9kZhlhxjNebUeGnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by DM6PR11MB3258.namprd11.prod.outlook.com (2603:10b6:5:e::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10; Thu, 1 Sep 2022 07:49:00 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::159d:a6de:f2b9:fc83]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::159d:a6de:f2b9:fc83%3]) with mapi id 15.20.5588.010; Thu, 1 Sep 2022
 07:48:59 +0000
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
	=?utf-8?B?6rmA7IOB7KeEKFNhbmdqaW4gS2ltKSDso7zsnoTsl7Dqtazsm5Ag65GQ7IKw?=
 =?utf-8?B?66Gc67O07Yux7Iqk?= <sangjin5.kim@doosan.com>
Subject: RE: What causes the latency of the rt_task_yield() API?
Thread-Topic: What causes the latency of the rt_task_yield() API?
Thread-Index: Adi2hA+8NshNMGH/S1C5hT38XRCzfAABQnKAAEPabkAAHYUU4AADTiNwAAcm6LAABFvNgAAqXeuQAAWtTIABMRjSEAAB/+8A
Date: Thu, 1 Sep 2022 07:48:59 +0000
Message-ID: <MN2PR11MB4285C4A26329000A75BF96DBF27B9@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <SE2P216MB1394874A00E10A497FE73DE0C2709@SE2P216MB1394.KORP216.PROD.OUTLOOK.COM>
 <MN2PR11MB428519AFC0F522BB25FDA093F2709@MN2PR11MB4285.namprd11.prod.outlook.com>
 <SE2P216MB1394C7C6A067126F36022F23C2739@SE2P216MB1394.KORP216.PROD.OUTLOOK.COM>
 <SE1P216MB1509579188F44BA6C35E8547B1739@SE1P216MB1509.KORP216.PROD.OUTLOOK.COM>
 <BY5PR11MB4276CD67150EE6042EB1A849F2729@BY5PR11MB4276.namprd11.prod.outlook.com>
 <SE1P216MB1509E22586BCCE1E4899A946B1729@SE1P216MB1509.KORP216.PROD.OUTLOOK.COM>
 <MN2PR11MB4285E860217DB23B18016495F2729@MN2PR11MB4285.namprd11.prod.outlook.com>
 <SE1P216MB1509ED1D62553AC566FDA209B1759@SE1P216MB1509.KORP216.PROD.OUTLOOK.COM>
 <MN2PR11MB4285C21FFFA82081782F2CDFF2759@MN2PR11MB4285.namprd11.prod.outlook.com>
 <SE1P216MB1509F3EB0B85BBA7A7787A5DB17B9@SE1P216MB1509.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <SE1P216MB1509F3EB0B85BBA7A7787A5DB17B9@SE1P216MB1509.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b13b7f38-0a35-4cb2-91cb-08da8bee6e2c
x-ms-traffictypediagnostic: DM6PR11MB3258:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FMIuURhunq5QrVQZ6x8j7bWGCrBP6s5NO009ZbxeDVTP/PKl1vaZHxAoY4Z9jEgdCHf/6mVQqAVl3G6MKb/e6dKjzt/i1KpipUf5EasbELFBXAh8zdiC8voZFOkAnj2pGp8Im0JBkUWtPqBl2jSTMhaE8bvIU4BMB1qCrurWKwCqhC2wIWeYeKKBupKyQnDACayGeIPJxV6WH2dNkIkSTSoiAZZwD6hL4uxrrdczbwXwmmxnGiEebKAgiFWTPGdfPSUxsUah2QuuhzrvD4xNRZ644LbYRt959NTjyCEguOBpXrGqGqO68OfyhPSja/qpuXpAT4OPeosVsA3696BzQt2XQvQE64ZMsDWwZwhIYYDPKjYY4CckhMXxvuZp3faN7+gTPh1ziFDuDMo4uWveWncwtfohysliO/uQ0rAdYNvcD0XVaLz4sfqr72yjaTWdWMzkbUuEWaRVX+G2KSoEHSPGFQ6w4IRk+/0kxS5OiqeOf/a6YNZTy+8NylVH+OjTxVxYwaW8X/Lex2OoO24/HnKX134AQ0iE/2gYvgbrIVnmqbpAp2Wm3Cn++ckE46RWfGdWbYd28r7JhlnVsEY0AgwYLExcin7HhPxs9Z52dTZ1jn87PiX8gM+dosiPzVBdJKaeRxjVN5IIgH3dcw+R7Bcoia8y+hMQ67FhL34noaOi+3McOvbWditGyclOLQi4uC2NkwdFWR/px97cSUICHoX87aVHB21wPnK7jvrQjG6kLFGJSmTIDZMrttV6U/0Ikr2wu+nuwIBPsHfJmfqirldbQa97lAiYZ4F7mpCPV1k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(136003)(346002)(39860400002)(376002)(82960400001)(6506007)(26005)(7696005)(86362001)(9686003)(71200400001)(41300700001)(966005)(55016003)(38100700002)(122000001)(478600001)(66574015)(186003)(38070700005)(83380400001)(66476007)(33656002)(66446008)(64756008)(66556008)(66946007)(8676002)(76116006)(4326008)(316002)(110136005)(54906003)(5660300002)(2906002)(8936002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OE9oVWUybkc2TkRaUDc5bkZBRHIzbTE3QzU4cjYzdGtnbGRZbWJQc0krdDlB?=
 =?utf-8?B?QVh2WUw2bXpRRU1JUlUyRnllOG1GbHVvYXZPcHBXU3AzSURwUVQ1eUVRdG9x?=
 =?utf-8?B?WGxFRFoxM05qNUJIYWhZaVFUeDJ4YmRqQ0NyYnVyNUt2TkhIVGJ4UWVTenpE?=
 =?utf-8?B?UnE1UDVRNklxNDFYMFVTVlgrQUszekVGQk55V1ArOEMvdlRWUk5DcnZPSkx1?=
 =?utf-8?B?YVlRaTRRcGpkNWVPNm5heG9ac2E3SHNOK21kVzA0aWozSUQ1YnVrSjFlcWFD?=
 =?utf-8?B?bnEwbUJ5bkI2RHlMTWFHNjN3M3FVZnp6czE3TjdSTk5qcjRTTXpmK3JqS3JO?=
 =?utf-8?B?MXhVQXFYUm5OZGhEaEtlQUNqR2hBQW82VHA4YmVtSDNzZ0VyTlMxZ2UwRGFF?=
 =?utf-8?B?RW9KNG1wa3FxSllNNlVjQy9pUGw0VHJUNDRKRDk4bGx1Q2taSFZFTW80ZGdI?=
 =?utf-8?B?c20rWTlycWt1Sm44Ykd0SjFvTzZjLzlMZ1JucEc0OTA3U3hLZUlIYmNFZXdP?=
 =?utf-8?B?VUJMcVRlVVNpeC9SYWVmcEJKUG9lVW9XOTVQVHhpWWtVNmhyb05ta1BmNW5h?=
 =?utf-8?B?ZEtrRzRWQ0RUM21lOGd4WEswV0NsS2h0VnJNOXI5RHZnTDNLejRoMzBMQS9M?=
 =?utf-8?B?UStLYTBHQW5VOTlRQkorNGN5RFdNcTNYTWwvTGdtUy9LYjdHckE0VUJ3bDNE?=
 =?utf-8?B?R0x3K1c1SStOZkdUUWhEWVZBaitDcnRRL0hKOGpraHQybjlWaTlqZEhsZkYy?=
 =?utf-8?B?OTk1ZG9wK0JOYzZyRWpqcVlvTWdLdDFqa1BPSkxZWktyR2lvM1ZWWE9DTlB2?=
 =?utf-8?B?QW1JVml1U01wWHdseXg5WEZ0NDhhN2NMNSt1djI3TlZpWG15REswaG1TM2pU?=
 =?utf-8?B?VUliZE9TK0RWZGxzSldKWCtuS1JycG5QM056bTNZcDhscHk4bXV1cUc0bVZU?=
 =?utf-8?B?Q2NTY2tJUitIQzJuYXl4TGcrNWgxTE90Y3lTa3ZKSmJKUXJJUldBVFVBbXcz?=
 =?utf-8?B?UHMzSXBzYjl2TzR0VERzM1RsOXNWcHJnakgzOWRoQnkvOGF6Z05tUXVGTmh3?=
 =?utf-8?B?MExMUHdOMjFJTmJJS014c2I4MU9ZN2t1Q1A4RXdCUjhDT0NRZWtOeW1ZbXZ6?=
 =?utf-8?B?ZHNTYTYzM2VPNDc5QXNOK1VjM1A1enQrSWdoSSs4SDliZkZVNitpQlEyZEw4?=
 =?utf-8?B?NDVPcG1CZHd1TXU1RUVpaHBMTnFDZlNaaTZJZWFIdmNQWUhHN2wySE52V3h6?=
 =?utf-8?B?QXo0OC9QWVFhSmtyekw4VisybUdhbEw2V0M5WkoycDZIUlQ4WmZnK2RXSGZs?=
 =?utf-8?B?SDQwRzN3TzZKcjhIR2ViTmpsSktNUFdLazZKUjByVzRscm9xZy9UNFdIaGhx?=
 =?utf-8?B?bnovR09vbVpURjRMcmZqbXZvRExZbDRLR0h3OTlJRkZHV2FmVVBCSU1UVjZH?=
 =?utf-8?B?VVlma2QvNERRbEFKaldCejRnMzI2YVRkYnNFei9GczAzcU9HUUd3NWtxVUZO?=
 =?utf-8?B?L0wvM1dIUmN1RXUvNk8yQytRZVpPQVdveGNITk11TDYwSStsYlZUcm5aQ0RV?=
 =?utf-8?B?b0ZPNWVFR09VRit5aU90K050cVN0dCtjQ1B2UlBva20ybEtRUWFHbXBGdjdk?=
 =?utf-8?B?aHBoMkhDdU9yYlk1cS9JTWQ1cnByQ2hOQjVjZXdRWTJ5Q2FaM096RWhiTFpP?=
 =?utf-8?B?UFhzSmJIZmxFRjl6R09DZWc0eHJSNmprVDB4Y1ZxbEQ5SC9VWExvRG1zdFlk?=
 =?utf-8?B?NGJPa2ZXbDJTOWtEUVdHREt1ZU9CanYwZ0NvOTRhb1BnUmFOSjF0OG16UklE?=
 =?utf-8?B?ekVpSnliUktvSkEvNlZJRWlJcTY1MVZyeDlrQm4yTFp4Sk51NDhQa0Q0MmFH?=
 =?utf-8?B?OUE3enV0SFBYdnNsYkZrK1R0Q0tMSWtWWFV3UjE0MnFQOXZhUkVzQlZWWGR2?=
 =?utf-8?B?YWtDMWZ1NTA4SnNwRytoRDc0Q1RZb3NlZzcvam5MZlNVR1h5d2RXZ3NEUmhw?=
 =?utf-8?B?bkl1TGw1V3Q3Z05RdEs3V2UyMDNRWXNqRkxBbTN0NDdCaW1hazlaNEtyRnZt?=
 =?utf-8?B?ZFlwSFhFdEpiblVjek00RjJVOUQ5U1lINVBBNDdIS3QyZ1N2ME1GQjRrSGkw?=
 =?utf-8?Q?UzmpeIjodVzfLL6IHuoxjuC/Y?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b13b7f38-0a35-4cb2-91cb-08da8bee6e2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 07:48:59.2613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NM9ffqHP1Upa37pduMOjdWpke2uWbsnBphdiOTgFwxSLY+hJ/RWttsKoggEtKj8wAvdOQ5YS14BlZH1go3sI6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3258
X-OriginatorOrg: intel.com
Received-SPF: 
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=intel.com header.s=Intel header.b=KomPM2bu;
	arc=pass ("microsoft.com:s=arcselector9901:i=1");
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (spool.mail.gandi.net: domain of hongzhan.chen@intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=hongzhan.chen@intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206ID8/PyhEb25nam9vIEtpbSkg
Pz8/Pz8gPz8/Pz8/IDxkb25nam9vNS5raW1AZG9vc2FuLmNvbT4gDQo+U2VudDogVGh1cnNkYXks
IFNlcHRlbWJlciAxLCAyMDIyIDM6MDAgUE0NCj5UbzogQ2hlbiwgSG9uZ3poYW4gPGhvbmd6aGFu
LmNoZW5AaW50ZWwuY29tPjsgeGVub21haUB4ZW5vbWFpLm9yZw0KPkNjOiA/Pz8oWW91bmdjaHVs
IFBhcmspID8/Pz8/ID8/Pz8/PyA8eW91bmdjaHVsMy5wYXJrQGRvb3Nhbi5jb20+OyA/Pz8oS3l1
bmdob29uIFBhcmspID8/Pz8/ID8/Pz8/PyA8a3l1bmdob29uMi5wYXJrQGRvb3Nhbi5jb20+OyA/
Pz8oU2VoeXVuIEtpbSkgPz8/ID8/Pz8/PyA8c2VoeXVuMi5raW1AZG9vc2FuLmNvbT47ID8/PyhE
b25nam9vIEtpbSkgPz8/Pz8gPz8/Pz8/IDxkb25nam9vNS5raW1AZG9vc2FuLmNvbT47ID8/PyhT
YW5namluIEtpbSkgPz8/Pz8gPz8/Pz8/IDxzYW5namluNS5raW1AZG9vc2FuLmNvbT4NCj5TdWJq
ZWN0OiBSRTogV2hhdCBjYXVzZXMgdGhlIGxhdGVuY3kgb2YgdGhlIHJ0X3Rhc2tfeWllbGQoKSBB
UEk/DQo+DQo+RGVhciBYZW5vbWFpLm9yZywgQ2hlbiwgSG9uZ3poYW4NCj4NCj5JJ20gZG9uZyBq
b28uDQo+DQo+VGhhbmsgeW91IGZvciB5b3VyIHJlcGx5IHRvIHVzIG91ciBxdWVzdGlvbnMuDQo+
DQo+V2UgaGF2ZSBhIHF1ZXN0aW9ucyBhYm91dCBYZW5vbWFpIGJ1aWxkLg0KPg0KPldlIGluc3Rh
bGwgVWJ1bnR1IDIwLjA0LjUgTFRTIG91ciBsaW51eCBidWlsZCBzZXJ2ZXIuDQo+VGhlIFVidW50
dSAyMC4wNC41IExUUyBpcyA2NGJpdCggWDg2XzY0ICkuDQo+DQo+QW5kLCBXZSBhbHNvIGluc3Rh
bGwgZ2NjLTQuOCBjb21waWxlciBiYXNlZCBvbiA2NGJpdC4NCj4NCj5XZSB3YW50IHRvIGJ1aWxk
IGFib3V0IFhlbm9tYWkgYnVpbGQgZm9yIFg4NiggMzJiaXQpIFRhcmdldC4NCj5TbywgV2UgdXNl
IHRoZSBzY3JpcHQgYmFzZWQgb24gWGVub21haSBkb2N1bWVudC4NCj4NCj4NCj5CdXQsIGNvbmZp
Z3VyZSBoYXBwZW4gdG8gZmFpbC4NCj5JcyB0aGVyZSBhbnkgbWV0aG9kIHRvIHN1Y2Nlc3MgWGVu
b21haSBjb25maWd1cmU/DQo+DQo+DQo+aHR0cHM6Ly94ZW5vbWFpLm9yZy9kb2N1bWVudGF0aW9u
L3hlbm9tYWktMy9wZGYvUkVBRE1FLklOU1RBTEwucGRmDQo+DQo+JCBta2RpciAkYnVpbGRfcm9v
dCAmJiBjZCAkYnVpbGRfcm9vdA0KPiQgJHhlbm9tYWlfcm9vdC9jb25maWd1cmUgLS13aXRoLWNv
cmU9Y29iYWx0IC0tZW5hYmxlLXNtcCAtLWVuYWJsZS1wc2hhcmVkIFwNCj4tLWhvc3Q9aTY4Ni1s
aW51eCBDRkxBR1M9Ii1tMzIgLU8yIiBMREZMQUdTPSItbTMyIg0KPiQgbWFrZSBpbnN0YWxsDQo+
DQo+DQo+dXNlckBkZXZlbG9wOi9ob21lL2Rvbmdqb281LmtpbS90ZW1wL3hlbm9tYWktMy4wLjgk
IHN1ZG8gLi9jb25maWd1cmUgLS13aXRoLWNvcmU9Y29iYWx0IC0tZW5hYmxlLXNtcCAtLWVuYWJs
ZS1wc2hhcmVkIC0taG9zdD1pNjg2LWxpbnV4IENGTEFHUz0iLW0zMiAtTzIiIExERkxBR1M9Ii1t
MzIiDQo+Y2hlY2tpbmcgd2hldGhlciB3ZSBidWlsZCBmb3IgQ29iYWx0IG9yIE1lcmN1cnkgY29y
ZS4uLiBjb2JhbHQNCj5jaGVja2luZyBidWlsZCBzeXN0ZW0gdHlwZS4uLiB4ODZfNjQtcGMtbGlu
dXgtZ251DQo+Y2hlY2tpbmcgaG9zdCBzeXN0ZW0gdHlwZS4uLiBpNjg2LXBjLWxpbnV4LWdudQ0K
PmNoZWNraW5nIGZvciBhIEJTRC1jb21wYXRpYmxlIGluc3RhbGwuLi4gL3Vzci9iaW4vaW5zdGFs
bCAtYw0KPmNoZWNraW5nIGZvciBpNjg2LWxpbnV4LWdjYy4uLiBubw0KIGNoZWNraW5nIGZvciBn
Y2MuLi4gZ2NjDQo+Y2hlY2tpbmcgd2hldGhlciB0aGUgQyBjb21waWxlciB3b3Jrcy4uLiBubw0K
PmNvbmZpZ3VyZTogZXJyb3I6IGluIGAvaG9tZS9kb25nam9vNS5raW0vdGVtcC94ZW5vbWFpLTMu
MC44JzoNCj5jb25maWd1cmU6IGVycm9yOiBDIGNvbXBpbGVyIGNhbm5vdCBjcmVhdGUgZXhlY3V0
YWJsZXMNCj5TZWUgYGNvbmZpZy5sb2cnIGZvciBtb3JlIGRldGFpbHMNCj4NCj4NCj4NCj5jb25m
aWcubG9nDQo+DQo+Y29uZmlndXJlOjMwMTc6ICQ/ID0gMA0KPmNvbmZpZ3VyZTozMDA2OiBnY2Mg
LXYgPiY1DQo+VXNpbmcgYnVpbHQtaW4gc3BlY3MuDQo+Q09MTEVDVF9HQ0M9Z2NjDQo+Q09MTEVD
VF9MVE9fV1JBUFBFUj0vdXNyL2xpYi9nY2MveDg2XzY0LWxpbnV4LWdudS80LjgvbHRvLXdyYXBw
ZXINCj5UYXJnZXQ6IHg4Nl82NC1saW51eC1nbnUNCj5Db25maWd1cmVkIHdpdGg6IC4uL3NyYy9j
b25maWd1cmUgLXYgLS13aXRoLXBrZ3ZlcnNpb249J1VidW50dSA0LjguNS00dWJ1bnR1MicgLS13
aXRoLWJ1Z3VybD1maWxlOi8vL3Vzci9zaGFyZS9kb2MvZ2NjLTQuOC9SRUFETUUuQnVncyAtLWVu
YWJsZS1sYW5ndWFnZXM9YyxjKyssamF2YSxnbyxkLGZvcnRyYW4sb2JqYyxvYmotYysrIC0tcHJl
Zml4PS91c3IgLS1wcm9ncmFtLXN1ZmZpeD0tNC44IC0tZW5hYmxlLXNoYXJlZCAtLWVuYWJsZS1s
aW5rZXItYnVpbGQtaWQgLS1saWJleGVjZGlyPS91c3IvbGliIC0td2l0aG91dC1pbmNsdWRlZC1n
ZXR0ZXh0IC0tZW5hYmxlLXRocmVhZHM9cG9zaXggLS13aXRoLWd4eC1pbmNsdWRlLWRpcj0vdXNy
L2luY2x1ZGUvYysrLzQuOCAtLWxpYmRpcj0vdXNyL2xpYiAtLWVuYWJsZS1ubHMgLS13aXRoLXN5
c3Jvb3Q9LyAtLWVuYWJsZS1jbG9jYWxlPWdudSAtLWVuYWJsZS1saWJzdGRjeHgtZGVidWcgLS1l
bmFibGUtbGlic3RkY3h4LXRpbWU9eWVzIC0tZW5hYmxlLWdudS11bmlxdWUtb2JqZWN0IC0tZGlz
YWJsZS1saWJtdWRmbGFwIC0tZW5hYmxlLXBsdWdpbiAtLXdpdGgtc3lzdGVtLXpsaWIgLS1kaXNh
YmxlLWJyb3dzZXItcGx1Z2luIC0tZW5hYmxlLWphdmEtYXd0PWd0ayAtLWVuYWJsZS1ndGstY2Fp
cm8gLS13aXRoLWphdmEtaG9tZT0vdXNyL2xpYi9qdm0vamF2YS0xLjUuMC1nY2otNC44LWFtZDY0
L2pyZSAtLWVuYWJsZS1qYXZhLWhvbWUgLS13aXRoLWp2bS1yb290LWRpcj0vdXNyL2xpYi9qdm0v
amF2YS0xLjUuMC1nY2otNC44LWFtZDY0IC0td2l0aC1qdm0tamFyLWRpcj0vdXNyL2xpYi9qdm0t
ZXhwb3J0cy9qYXZhLTEuNS4wLWdjai00LjgtYW1kNjQgLS13aXRoLWFyY2gtZGlyZWN0b3J5PWFt
ZDY0IC0td2l0aC1lY2otamFyPS91c3Ivc2hhcmUvamF2YS9lY2xpcHNlLWVjai5qYXIgLS1lbmFi
bGUtb2JqYy1nYyAtLWVuYWJsZS1tdWx0aWFyY2ggLS1kaXNhYmxlLXdlcnJvciAtLXdpdGgtYXJj
aC0zMj1pNjg2IC0td2l0aC1hYmk9bTY0IC0td2l0aC1tdWx0aWxpYi1saXN0PW0zMixtNjQsbXgz
MiAtLXdpdGgtdHVuZT1nZW5lcmljIC0tZW5hYmxlLWNoZWNraW5nPXJlbGVhc2UgLS1idWlsZD14
ODZfNjQtbGludXgtZ251IC0taG9zdD14ODZfNjQtbGludXgtZ251IC0tdGFyZ2V0PXg4Nl82NC1s
aW51eC1nbnUNCj5UaHJlYWQgbW9kZWw6IHBvc2l4DQo+Z2NjIHZlcnNpb24gNC44LjUgKFVidW50
dSA0LjguNS00dWJ1bnR1MikNCj5jb25maWd1cmU6MzAxNzogJD8gPSAwDQo+Y29uZmlndXJlOjMw
MDY6IGdjYyAtViA+JjUNCj5nY2M6IGVycm9yOiB1bnJlY29nbml6ZWQgY29tbWFuZCBsaW5lIG9w
dGlvbiAnLVYnDQo+Z2NjOiBmYXRhbCBlcnJvcjogbm8gaW5wdXQgZmlsZXMNCj5jb21waWxhdGlv
biB0ZXJtaW5hdGVkLg0KPmNvbmZpZ3VyZTozMDE3OiAkPyA9IDQNCj5jb25maWd1cmU6MzAwNjog
Z2NjIC1xdmVyc2lvbiA+JjUNCj5nY2M6IGVycm9yOiB1bnJlY29nbml6ZWQgY29tbWFuZCBsaW5l
IG9wdGlvbiAnLXF2ZXJzaW9uJw0KPmdjYzogZmF0YWwgZXJyb3I6IG5vIGlucHV0IGZpbGVzDQo+
Y29tcGlsYXRpb24gdGVybWluYXRlZC4NCj5jb25maWd1cmU6MzAxNzogJD8gPSA0DQo+DQo+VGhh
bmtzLg0KDQpJdCBpcyBjb21tb24gYXV0b2NvbmZpZyBpc3N1ZS4gWW91IG1heSB0cnkgbWV0aG9k
cyBtZW50aW9uZWQgaW4gWzFdIGZvciBleGFtcGxlIGluc3RhbGwgbmVjZXNzYXJ5IHBhY2thZ2Ug
dmlhIHJ1bm5pbmcgIHN1ZG8gYXB0LWdldCBpbnN0YWxsIGJ1aWxkLWVzc2VudGlhbC4NCg0KWzFd
OiBodHRwczovL3N0YWNrb3ZlcmZsb3cuY29tL3F1ZXN0aW9ucy8yMDY3ODAxNi9hdXRvY29uZi1j
b21wbGFpbnMtYy1jb21waWxlci1jYW5ub3QtY3JlYXRlLWV4ZWN1dGFibGVzLW9uLWxpbnV4LW1p
bnQNCg0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQoNCg==
