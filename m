Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8EC7E
	for <xenomai@lists.linux.dev>; Mon,  5 Sep 2022 02:56:49 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::221])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 244E6C50E6
	for <xenomai@lists.linux.dev>; Mon,  5 Sep 2022 02:47:43 +0000 (UTC)
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 26570240003
	for <xenomai@lists.linux.dev>; Mon,  5 Sep 2022 02:47:34 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 766A4740040
	for <xenomai@xenomai.org>; Mon,  5 Sep 2022 02:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662346053; x=1693882053;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TTnjJj7YEk1G90NnmEwl0EGXw0mqWTvoWEB/X/feCUo=;
  b=G2IgS6j8OhNGWrUqkAln4gJjXRoYFhrAkFZhc2NJjXKk1H8qcWl3H1VG
   mN9ct0Nj2gjW1sTp+Ki4pAI807F32YV797sz/hhdEv/lV5Jyc7KEiMFPK
   FhubuMOSkJDr7/XxAp1ShIs37nX/47C6kg9Nav8ZWOMxlI5PqyCq4Cc9e
   krrPQNANCKoM18Pf46Ou4F4YL9VrgtPBzAmjq2De794pOhK1KBS+3Su1m
   E2zJsGVUE3b0mQbu6D2C7BIpAtFCnive23T/j9bT4KLcC2l4Htc6Tybdl
   D7VcQAza+8GClzR+zoQxvsTiGU2lqBvRsJ9mdb4GcLS6TAPkcAq0/PH3t
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="382592978"
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="382592978"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2022 19:47:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="616260893"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 04 Sep 2022 19:47:30 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 4 Sep 2022 19:47:28 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 4 Sep 2022 19:47:28 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 4 Sep 2022 19:47:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDIoZrsFESz0pTMJqP/+Q/eVhC80gk3caWi5IBAM3pUWbYTY8U7Kxltrbh73mWOIzOfyc5BIQ6R48LhiUc7sL5sA1y5ESp6HDN5kK/aKguyOVr2YZb4bhdMkxikNMN+6p1f1vXIH26GaV+5ZX65PwgeVQ8MUPlkOCOm9WE30WKlvhiT+2l7xRElccpyJXCzjcor3XFTghwEKwttTbhXB7lsA3juLfnfjCnuQUJdHuCc0ZC9Pq/G0puwhtT8/tN9tpj9FNCJWNBZUsQ3/2XlhrAFyrhJUZjMslrhTXgNhhgWJbgEM+dry5TRoCuPu4NrQqCUDQFziZMDGjbM+aWxaQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TTnjJj7YEk1G90NnmEwl0EGXw0mqWTvoWEB/X/feCUo=;
 b=hhzYaf47QgPswkzzEK+Jyr/Z1BgwkE/ScG8JF2Hx6QyJwOvBoXCxllLp4RFlY7McOYfh6dyBo9ds3WUXHuKibNLKeOseTAWImWRCSGJZ/u7hsYdyfBZYU8UfPQzyV7xsTgIXv9kaBUjunCyFHRrLJtePsu++iU4YYyVEjKJYtiAas3C+ra5QhEQL8yc/4QP+dtlr+dIsO6l8WhC0hZJUonu2winSxD8GUdxJapNs9pYOhAPIliGd7+dwKU5cj84CsGuOP+jcVchhL7m/jc1CIhHNVkKVmrfMYTxrGS/apXg/p4yHTFsj3E0Z5TerH2XsXZFT+di4FR3gHL/FR0HoNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by SA0PR11MB4559.namprd11.prod.outlook.com (2603:10b6:806:9a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Mon, 5 Sep
 2022 02:47:27 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::159d:a6de:f2b9:fc83]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::159d:a6de:f2b9:fc83%3]) with mapi id 15.20.5588.015; Mon, 5 Sep 2022
 02:47:26 +0000
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
Thread-Index: Adi2hA+8NshNMGH/S1C5hT38XRCzfAABQnKAAEPabkAAHYUU4AADTiNwAAcm6LAABFvNgAAqXeuQAAWtTIABMRjSEAAB/+8AALvKhbAAAd0CAA==
Date: Mon, 5 Sep 2022 02:47:26 +0000
Message-ID: <MN2PR11MB4285822F4C6778016489535BF27F9@MN2PR11MB4285.namprd11.prod.outlook.com>
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
 <MN2PR11MB4285C4A26329000A75BF96DBF27B9@MN2PR11MB4285.namprd11.prod.outlook.com>
 <SE1P216MB1509B8CAFA0E44DE487C3CB7B17F9@SE1P216MB1509.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <SE1P216MB1509B8CAFA0E44DE487C3CB7B17F9@SE1P216MB1509.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b940fdea-5fb3-41bb-4246-08da8ee8f7e7
x-ms-traffictypediagnostic: SA0PR11MB4559:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dgOtPBj3pyWSt8XyonPAyTGrcXTO3Thg43EzlIFW85bouvY2cbS+Y7LcnXffjjFq9GPKmjCDKtw/RLLEdArdHbhykfXBXHDyd5SJY4+8LQ0bDfkcodz8w2XMuCdzPhmJFu06B7OAROZ9PQ/ZnnT/toOOW3aPlCzZfUAGtpjAjqTlFvGdRaR3ZNqPpAW9DTfCMMes606HXCFsixa+qjC4BfY7GWpY4iimNIK4nVcBFjR/MWxa211S/sptR54Kx6nGlyGzV1rvHQ6ZxkCdQ/nx6wHAh3WATTFbZf2wqG9mf9T2xEAOnQLGzvHKvQBLZeWYncsEMB9yUd5rLTVXvaplTUtoDD/KmrFEjvnl9WJK2VzhPd7etAjkVO17VYTz5FFBOy6+EZt1USYZDu20nOjFZelYbt0Dajohn/VuZJsv+tKKEMUW6bpsrmYSGhOvr6fdwjTuHuMIOczpmibbrvsw5q9uz1DZp+ojp581Bh3a2Zk+r6QOLaCHKOCZ5jU724h98xGg+tHWqoPs9jzf4COtqFC9dnAGShbMmla0oXY0xfT8MNVFiTq8lSBPdJ1gTUmYWcpEo3ZbB7vuGgKaTmY67/TOtslHbcojAERfaCfyO7e9W76iP5DBFrMV1StM/6ULa25xw5aZcspAeqv7oQU5s2MHnbruLTBI4WMhGfPVazVI/04ng07PLTm6/RfNUIwVCigT13VYvxBJ+j22IDC6H5LksSnJV11r7rg9pUQNw1Cwc8b2Y+4odNR8LKhfvPuFlKPVMDQBa/zrtulJGYl9fQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(366004)(376002)(136003)(396003)(82960400001)(316002)(38100700002)(38070700005)(122000001)(4326008)(64756008)(55016003)(66446008)(66476007)(76116006)(66946007)(66556008)(8676002)(110136005)(54906003)(2906002)(8936002)(52536014)(5660300002)(478600001)(9686003)(83380400001)(186003)(71200400001)(6506007)(41300700001)(7696005)(26005)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1BIVGRBMFNwYnk2dmFqK0NQTFJEbDFyamNIN1I4VUdKMGNVUUw3VmQ0TTA3?=
 =?utf-8?B?b20reW01cmU5WVRwcDR4VmR4QWtML2d2RlArQVVTa3NNbkM2NjdXSGFTeE9K?=
 =?utf-8?B?cjlTRzF3NDNxTWZzVUdXRDljRDhQWFhQZWJCZU1ueVZrVkM2cDBpWERISFZ2?=
 =?utf-8?B?cEp2TVY4RGg1Qkg0Qk1mdzFaTTdjVTVBV3p3Nk51ZnUraTFQeEtQdUYzUm4r?=
 =?utf-8?B?cU1KV0pRd28zVCtuRFJhNlNwT0hFNFNkVEYwM0RySUlrV0dhZkU5azV1MTJK?=
 =?utf-8?B?VFUveU9tM3Q0ZW1OT0NwQVdHMWVFd3dmMlhXR1ZWM2hKdi9BaG02alFIUTAx?=
 =?utf-8?B?Zm0yc0RUK0EwNVVCRVBqVmdaV1FIclE2UnhMYzFVMjNzWjBIN1FqVmczdkVH?=
 =?utf-8?B?UmYxOEdsUStoMVNnamI1UEZzQlhWRFAvaGwydm1PZlM3NExzdnNFd3dGMmw1?=
 =?utf-8?B?MjVlV3pOdjNDYms0OVJRL2RvbTVOeWZVN3VKalpiUnkwQWQ1THY5dXpyelVP?=
 =?utf-8?B?OWY5RGdiNW4xTFNpcWFkcDVKS3FyUmRJelpPcU1BbGxWSEhZdG95OXdVc0dq?=
 =?utf-8?B?THZ1cVZ3NmRJSHV3QVVGZ1lINldSSm5sNzZhU3lZaTB3U1N5ZS9QNGhETkhp?=
 =?utf-8?B?VEdTTXd5TTJoWEY4NHFBZ1hjRis4aVNYUitpa1JtcEswSkxBaGU5dm5oZms3?=
 =?utf-8?B?YkUvWDl0UmczM3ZhSkwwUFQ2UW9vV0hEaytKRHZ1b20xK0VaeGRXQ2pRR2Ry?=
 =?utf-8?B?K2NISStnbnI2VHc5ZGx0YnpZM1lRb1hMOW9CMUo2MGQ5ZWVDRTRnRVhYVi9t?=
 =?utf-8?B?NlkwNTM5N3BUa0lnR3dzakFoa0FMU2VCMDNtUTViUUJSQVp6TmRvU2s5Mksx?=
 =?utf-8?B?NUlFajdCSHRNRGxmalZnS2dnSFp6RUVGb0ZkclViSGNab2tZbE1vSkFCUlRx?=
 =?utf-8?B?b2JkdU5YV21ES3RQY2dCbkFZTTdXYTF0RXlvcVlqaEZxRm5yN3BqWmZNNHRs?=
 =?utf-8?B?YTNKZmxDZVhOM2loSUpOcCtHOTg1cHRDV2FBL3pmR09INFI5S0hDSkJ6cHpo?=
 =?utf-8?B?OGdDeWdzb1hUMmJUV0YyNWtKbXJvWTFDQWRuTHdZS0kweEpEcmhDU1VLSVl0?=
 =?utf-8?B?RmtJcnNLanFVMHkzMzZNWExuQk9vZlJiYzM5RWRJUGNFeXdMVnRNMVQ4K0dE?=
 =?utf-8?B?S3h5YkFwT0hzTTAyY1JXclV2UCtzcGZaTWVEbktiS2xUa1QwNlErRUs2ekhT?=
 =?utf-8?B?TVl3ekkrYTNQTTdwQlBIMG8vNjd3c2Zmc0ZJL0hCUmM2WDZjeFR4UzBDSzdP?=
 =?utf-8?B?RnhWaWhwYTZvbUpEUVM3VkZLRTROQllsanNhdzN5aUhLQmhKUEFPVWp6QXlw?=
 =?utf-8?B?c245K2ltbnRoZVkrUXBsY3RqMGZwTytRMk9aS1Rud0xuQlhoZ2U2aTJrRmRm?=
 =?utf-8?B?MnFqZzFYRDhETnVtK2hmUUp3WXB2dUVnNGJheUxnQ29Da3c1NTgzK3RXajRN?=
 =?utf-8?B?WGsvY3VXWXNvcHVzeTNLWFJkcGtaN1ZmR2Zuc282cFlBYlhiT3d2dmFOdGhx?=
 =?utf-8?B?Q2xHcHlqWnR3SW90TGtKemt1NW9UcHpJbk9jQzlKaitvaWxVM3dDRm42Z0hD?=
 =?utf-8?B?QStvaFNIMzMvYlQ5cmtTa3FsUS96dWgxQ0dENnUrK1dVaktldGFuUjRYaVdm?=
 =?utf-8?B?R3B0NVJZUW5UdzBNNkVzam91czF6ZndWeUVsa3huM3ptR2RjSW4zNm5aODRN?=
 =?utf-8?B?NU9EOE9iR2NXZGJOeFNZZ3BMRSt1cEdsQ3lvazVZamF3N3cwMTNQNS95YzRF?=
 =?utf-8?B?MlkxZjhHelU0RTNTQW9wY1U0RDdGdEhSUnEzSUg5OXB1T0kxSmYrcjZhcVk3?=
 =?utf-8?B?YmU5STUwc2NOT3hHT1FLZEZJMTJiaFpvaW5Qczlya3dxbkxTR2lJYWY5b2ha?=
 =?utf-8?B?YmpaVGNoMGQ4TStCSWY5ZHgvUTVHTUZxRGxmZ0w0a1FZNEN5OWZaQTNGVUxN?=
 =?utf-8?B?b3AydTNpWE51d1V2bklra3NpRlE0QTVuQnJqano0Vzg5c1V0YXpMbitmMnlO?=
 =?utf-8?B?czBKT05IRnkxdkEzWmhpQXUxL2FvSnplQzkwL3dKMFBiOStYQlF6Z1ZOK3lH?=
 =?utf-8?Q?uVRlcvhA7z/6EYnVdfe48rVmv?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b940fdea-5fb3-41bb-4246-08da8ee8f7e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 02:47:26.8562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IfwTApoB+IxGT/auM+xOXIkj6/FAfIJjcSBs71jbqzdxjGUTk8ZzBVWSsIAtTU3d/0vCH0+BzTSkZzxUfa1kLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4559
X-OriginatorOrg: intel.com
Received-SPF: 
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=intel.com header.s=Intel header.b=G2IgS6j8;
	spf=pass (spool.mail.gandi.net: domain of hongzhan.chen@intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=hongzhan.chen@intel.com;
	arc=pass ("microsoft.com:s=arcselector9901:i=1");
	dmarc=pass (policy=none) header.from=intel.com

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogPz8/KERvbmdqb28gS2ltKSA/Pz8/
PyA/Pz8/Pz8gPGRvbmdqb281LmtpbUBkb29zYW4uY29tPiANCj5TZW50OiBNb25kYXksIFNlcHRl
bWJlciA1LCAyMDIyIDk6MjQgQU0NCj5UbzogQ2hlbiwgSG9uZ3poYW4gPGhvbmd6aGFuLmNoZW5A
aW50ZWwuY29tPjsgeGVub21haUB4ZW5vbWFpLm9yZw0KPkNjOiA/Pz8oWW91bmdjaHVsIFBhcmsp
ID8/Pz8/ID8/Pz8/PyA8eW91bmdjaHVsMy5wYXJrQGRvb3Nhbi5jb20+OyA/Pz8oS3l1bmdob29u
IFBhcmspID8/Pz8/ID8/Pz8/PyA8a3l1bmdob29uMi5wYXJrQGRvb3Nhbi5jb20+OyA/Pz8oU2Vo
eXVuIEtpbSkgPz8/ID8/Pz8/PyA8c2VoeXVuMi5raW1AZG9vc2FuLmNvbT47ID8/PyhTYW5namlu
IEtpbSkgPz8/Pz8gPz8/Pz8/IDxzYW5namluNS5raW1AZG9vc2FuLmNvbT47ID8/PyhEb25nam9v
IEtpbSkgPz8/Pz8gPz8/Pz8/IDxkb25nam9vNS5raW1AZG9vc2FuLmNvbT4NCj5TdWJqZWN0OiBS
RTogV2hhdCBjYXVzZXMgdGhlIGxhdGVuY3kgb2YgdGhlIHJ0X3Rhc2tfeWllbGQoKSBBUEk/DQo+
DQo+RGVhciBYZW5vbWFpLm9yZywgQ2hlbiwgSG9uZ3poYW4NCj4NCj5JJ20gZG9uZyBqb28uDQo+
DQo+QWZ0ZXIgaW5zdGFsbGluZyBidWlsZC1lc3NlbnRpYWwsIFhlbm9tYWkgY29uZmlndXJlIGVy
cm9yIGFsc28gaGFwcGVuLg0KPkNvdWxkIHlvdSBoZWxwIG1lIHRvIHNvbHZlIGEgWGVub21haSBj
b25maWd1cmUgZXJyb3IgPw0KPg0KPklmIFdlIGluc3RhbGwgZ2NjLTQuOCBjb21waWxlciBiYXNl
ZCBvbiAzMmJpdCwgWGVub21haSBjb25maWd1cmUgZXJyb3IgZG9uJ3QgaGFwcGVuLg0KPg0KPjEu
IFdlIGluc3RhbGwgZ2NjLTQuOCBjb21waWxlciBiYXNlZCBvbiA2NGJpdC4NCg0KVG8gY29tcGls
ZSBnY2MgNC44IDMyLWJpdCBwcm9ncmFtOg0KDQpQbGVhc2UgbWFrZSBzdXJlIGFsbCB0aGUgMzIt
Yml0IGdjYyA0LjggZGV2ZWxvcG1lbnQgdG9vbHMgYXJlIGNvbXBsZXRlbHkgaW5zdGFsbGVkIGZv
ciB5b3VyIGNhc2U6DQoNCnN1ZG8gYXB0LWdldCBpbnN0YWxsIGxpYjMyZ2NjLTQuOC1kZXYNCg0K
DQpSZWdhcmRzDQoNCkhvbmd6aGFuIENoZW4NCg0KPg0KPjIuIFdlIHdhbnQgdG8gYnVpbGQgYWJv
dXQgWGVub21haSBidWlsZCBmb3IgWDg2KCAzMmJpdCkgVGFyZ2V0Lg0KPiAgIFNvLCBXZSB1c2Ug
dGhlIHNjcmlwdCBiYXNlZCBvbiBYZW5vbWFpIGRvY3VtZW50Lg0KPg0KPjMuIGNvbmZpZ3VyZSBo
YXBwZW4gdG8gZmFpbC4NCj4NCj5UaGFua3MuDQo+DQo+DQo=
