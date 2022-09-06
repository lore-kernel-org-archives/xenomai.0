Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECE6173
	for <xenomai@lists.linux.dev>; Tue,  6 Sep 2022 02:03:34 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (unknown [217.70.183.195])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id A6A77C5686
	for <xenomai@lists.linux.dev>; Tue,  6 Sep 2022 01:54:48 +0000 (UTC)
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 28D3860002
	for <xenomai@lists.linux.dev>; Tue,  6 Sep 2022 01:54:39 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 5445B74007C
	for <xenomai@xenomai.org>; Tue,  6 Sep 2022 01:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662429278; x=1693965278;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MjtNj0A8hb/zirmfZcL45BauwI3VtfbpbsFzJcG6KBE=;
  b=ew8lmoeFBn3Ig3hZ5S0iA7SeTIe1SC1PPxycFSgjUDj4+TpXRgKfkzcy
   kHfShIKxy23vcFT9Bot1B9blXKW350AQtuHSAg6Hu5LEcKWZaw/YdUxeo
   KgK8NEdMp3VXtPxDYc8cn46QQ0kQDjXMPvpBwC/p+PiJnYThZCbfoLYR6
   Yy3E7TA906DpxVyMmNbOA7tUAhsmSNgOoPRyaM7CT6PZYM5zQ9x8hP2XQ
   cB5z1NqypPyZmF0ddmH8PEaDOHHTPjsQzfCjaO552VqH7jvLLAYBPMP35
   KFMu1Pzuzurk+9qxDlRSMikfELIrtnA9c0nOdly7k7oj+ZcVjVhcIVKqf
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="294063831"
X-IronPort-AV: E=Sophos;i="5.93,292,1654585200"; 
   d="scan'208";a="294063831"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 18:54:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,292,1654585200"; 
   d="scan'208";a="859094923"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 05 Sep 2022 18:54:36 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Sep 2022 18:54:35 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Sep 2022 18:54:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 5 Sep 2022 18:54:35 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 5 Sep 2022 18:54:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LYUSiF6mEI71clPLrKO89iAywdSpBQH+uwN/Kz6UKcydVif3KIClLNGuP2QGaX+XbNgvXEXjWsJc58fD6k6B6C6aPXK6KSpjvI9uuBVkxQn8nBX/J1LYtXknmlZRP1e5gOaim8U7fsw8Xf7us0EdenL9Ahx6gcc5ZB3YZdpB5XyZ6TH6iJFTMzRzFrzg8dV/R0+0/L9A9kB6QCc480CIgKunKqFzhbNE+6Kgt3Aw9dssCsHmrvcN2Qz3GQgny9yxaQ/cYq+CAiv78UEflIlYy5fTKi7NSrsTcO5QTcGRbrMM2jWbk00+urR2eTtE7wdfEUB/gPlSJOQq1ChuULz6zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MjtNj0A8hb/zirmfZcL45BauwI3VtfbpbsFzJcG6KBE=;
 b=jlZsXbWPVwPLHMY6kEJg68vx+jn/K61+C8XvGUCipLgbIXtK2L/ReFXBFE5nhsj41gUs+cXZzmtCmeJuUgEkC1p3ZbMMShrGY1MjLoz09SqoE4kY8fpmy5rr86z7oh0NbADgTA7I/A/Oq3befws88o+613KZN/oiY43xv1mr1RboUcjA7pla6GttK+l+wVTj0RmS39Vf42UY3V7Ex7j2Mn6sOAcnowsWX+9a0fw9wssyDVDJcrjP2uGwMOhoytk6FgjX+ilRyF9KN+Q+mAEUzo10DEhPVZXWe/TUIyS5VplPeyp0aaeZnERv/QmS5ckjF+LLjTHrMKCT8nb/fk9yOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by MWHPR1101MB2192.namprd11.prod.outlook.com (2603:10b6:301:59::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 01:54:27 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::159d:a6de:f2b9:fc83]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::159d:a6de:f2b9:fc83%3]) with mapi id 15.20.5588.015; Tue, 6 Sep 2022
 01:54:27 +0000
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
 =?utf-8?B?66Gc67O07Yux7Iqk?= <sangjin5.kim@doosan.com>,
	=?utf-8?B?7J6l7Jqp7ZiBKFlvbmdoeXVrIEphbmcpIOyxheyehOyXsOq1rOybkCDrkZA=?=
 =?utf-8?B?7IKw66Gc67O07Yux7Iqk?= <yonghyuk.jang@doosan.com>
Subject: RE: What causes the latency of the rt_task_yield() API?
Thread-Topic: What causes the latency of the rt_task_yield() API?
Thread-Index: Adi2hA+8NshNMGH/S1C5hT38XRCzfAABQnKAAEPabkAAHYUU4AADTiNwAAcm6LAABFvNgAAqXeuQAAWtTIABMRjSEAAB/+8AALvKhbAAAd0CAAAu4gsgAAK9TdA=
Date: Tue, 6 Sep 2022 01:54:27 +0000
Message-ID: <MN2PR11MB428545973EC5F5A06A05E9BCF27E9@MN2PR11MB4285.namprd11.prod.outlook.com>
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
 <MN2PR11MB4285822F4C6778016489535BF27F9@MN2PR11MB4285.namprd11.prod.outlook.com>
 <SE1P216MB15098FE3F2E5AFC3CA4AD949B17E9@SE1P216MB1509.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <SE1P216MB15098FE3F2E5AFC3CA4AD949B17E9@SE1P216MB1509.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4055622d-1f3f-4172-2c30-08da8faabb4f
x-ms-traffictypediagnostic: MWHPR1101MB2192:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JMoXC7Rk44ElYMK+ie+C+Qgq2fz0I1FtFw7waKysKqWMNSaLPsbQJGfpgyDBMGprF2Qx6KfF3cSkClKpedLk62Ppt3X20T+wwDhQslHgoNyf2/oLCvAtZs4DvRye0lkElyDbdublR+M12/3gp1OgBNmpKh14AFdrUn6GlwhCLkkymYlE91+LIMogkECJdUioQG2+fpDp0qfoQ9mou5wmSp3z9h4o6lFSRn/ujl7HRI7S42blGAsqLvxeRt2bI7/vENz8LdAdEihZb5CJYDVz7k9dyVZplSiLw22Mc6z7CpBVbAXqsCb7UHQyFKK5ZRWpaA6jDLGAZvcTS7aSq1xO5TwbXPc01FjC4PEIFj9JedFfbrwpe+KQwBOPeiTJdc2T9U4fVHgaeRRAs+YH+Zebx/rpPGv6g/HMriHUF/CUaH+0ZQlPxIWjvimN3asPPVwe5BdOhTeI1XhEQSVatcgZea2tFVXS5raALNNNVj24Cwz2hmvIHz4BR2JZ3uPF8vOj19RKa0Sb/gQL9UzwCZduwXHiaLS9yAQ+bpaJNlu2O3s0/tM6jo9WnhhQmxbZG0bpTpIbxDa6n7Miq4lGA1C6jwTii6XFTCe7UjRrdunlMzyAhh8yhdvRdqcMn8jEcsFimt+5INQDp+699mZ781EgVrnpHKfxKP3qLoUIdXUDgBlTfAsFUNPQ+a21xvLsLC2cz3ZumQ9UYoW3E87XH3qmtaXYuaMcYVenrRmlwkKWp/+INyqkUzCASv6jvOzoiiNxBNGRHkpxzMWtzktmZXXhts/gBIg4ymd1PDZMJuiqCZk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ko;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(39860400002)(136003)(346002)(396003)(8936002)(66446008)(7696005)(8676002)(2906002)(83380400001)(4326008)(66476007)(64756008)(66556008)(5660300002)(76116006)(33656002)(66946007)(186003)(52536014)(966005)(478600001)(26005)(71200400001)(41300700001)(9686003)(110136005)(54906003)(55016003)(6506007)(86362001)(122000001)(82960400001)(316002)(38100700002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXNlYjdSQ0VLMDhOWnBmcHpzb3dhUWU3cmNhVmJYUG4zUWdSR2NCTTBLMEZC?=
 =?utf-8?B?ZC9OSHl4dUNxVmFXZU5pdXBXTHFKaTR4bFJleXJnZzhsUkpuWGVCRFVXYy9U?=
 =?utf-8?B?T0Zyd2lIbUtGeVFxaTRtMS9qZHNyZFRyNFd5Q1FPNGFZMERrZ285YTcrc0Zw?=
 =?utf-8?B?YTlTNno5NXl3alM4V3lNSU8wdHUvNS9oVXpGSzY2LzR6YUJnYkw1eHhMTmQ2?=
 =?utf-8?B?NE9wODlKMlY3eHZzNU9zbGVCd2JRTitUQWJrNVAyQnAwZFF6c2UyUWNGV1ky?=
 =?utf-8?B?YkZ5bkZhdkhvNWhWdFJ3N3BnUy9rUnJsaFNjb0tOR0tWV2ltMnBlbWpGQStz?=
 =?utf-8?B?Z05HRTZVM1RPRDhFN3NxYldzQjlxVU03RGZ2R3FrY2NXUXNoRlBZWlcwWlFF?=
 =?utf-8?B?L0lUaDJQMnVBTG9JZnRodDJ1YkVMSU1aWVJjRm5TWHR3WHNHM2V6V3hFck5k?=
 =?utf-8?B?R3RCZ2hUbE5wZ00xMHgxREoxVDNia0s3UzluSXRGendzZTI0c3pUSHB4dFBU?=
 =?utf-8?B?NFZBT2IxaTZlZ2x2NWVWT1kvTjg0ZTJNRURMeTI0bWE2WTR0RTlnRUlGTVpE?=
 =?utf-8?B?eDY5OXVNVk5zRnJLQUM3QnJDNWc1ZU1IcXBJenBvTlZSWXBadTJab0xRZVNJ?=
 =?utf-8?B?M2pvUHNiMDFvNHVQMVJTbGlselVaM0VJeThKaTNCTUdNdmQyZ3ZtMnJrZk5J?=
 =?utf-8?B?ZHdJeWtsRkl5R0ErcTY5S2NaMk1FNktvdnFGR1poODdta0dDRlMwbVBPbURy?=
 =?utf-8?B?K3YxbzBXZmFKM1FJSGZHYUVnRzNaNVIyRjM0Rm1LOU9ybEtEYVBiTk5kaFZO?=
 =?utf-8?B?ck1GQ21DNWgyeTFhZy9EUG5WaUwycU40ejhlZGdkeHgybWw4WVh5b3poSzNo?=
 =?utf-8?B?SW5VdFdWdjUrOS84VmVXSVZtUnZEZjZrZE84TXpRWmZjbkF3a0NlQTgzZU0y?=
 =?utf-8?B?SnR1YXNWLzRla0dXdngrVG1Oem4yK1lHcXgyOXdYazh1cnkxaEp4M0Zia1Qv?=
 =?utf-8?B?QTcvcWlHdEhqbTN6cklGZjNnZGVYUjk3YkozeVo3U2RQR3BaRW1Zb0ZOMEJm?=
 =?utf-8?B?clJsTUhUcVpWa0xTUkdjd3FKM0JHdVFTcVg3ZkwxNVV6L0YwVUl5ejZBMEJh?=
 =?utf-8?B?MkZ6TVExL1k3S1RmUjQzN3ZQNHVSS05kcHNGeS9QNEFVejR2emw3YUVqNXlK?=
 =?utf-8?B?NlpMOUtna09xUFVTSXdEekQvTTdwb3J1b0lSZ015US9ISUs2V1llcXBzVmFI?=
 =?utf-8?B?RHFXeElTaUpaeFUvd2RLMkRWejlKY3VacUdveFdkV1hGMElNb0tIS3llcnhN?=
 =?utf-8?B?VktBR1ZvSEhUQ3VJRm81WjZtT2hlM1cxSTZwaTFvTENPYWhRQmlVZ2l1RFJS?=
 =?utf-8?B?RW1lVUcyLzZhQVpVZlcxRlF2OFVQYmxDZVd1YW81QUpiNGRtU2VLM3k3bC9m?=
 =?utf-8?B?a0dBM1FYNkxBRytmQzQzT0dSMjJmNCtHOERsc1l3V0JxNUEydWhPMTNhMmVY?=
 =?utf-8?B?UzROTWc2V1BLb0JtS05KZDA1cFRiRkJSYys4MVh0c2ZZMUg1NWFBR3NqcHN5?=
 =?utf-8?B?M3Bha2xUUHY2RFdpbWhEQmtTaE5CTHNnTFVmL1JyQXo4Wis0ZGJwelpTeEor?=
 =?utf-8?B?QmFDa2VnR2V6ZzZKWDhrRXJqRDhMZFlIQWRib3BGSVV2RE84Y0FCQllSTm1W?=
 =?utf-8?B?TDZXQkZLQ2QvbUZ6WHJuZlVidElTd3JWWXFYNmUvWWphVDRXS3VhU3BaQ2dE?=
 =?utf-8?B?a1crWEt5eWlraGxUdUNXdTJiOU15d1pZUXdmU2puY3BhS05GN1ZqK1ZSd0l4?=
 =?utf-8?B?akF4R3gvWll3c1Y2MkZCVnNqNDZsa1pZTy9obHIzQTVPc2MxcHQ5K0Y2amlZ?=
 =?utf-8?B?TmYxajFreHZvU0V1YWptT29hSFVzRklIREdFV2I3MGpGWW0yUldiaDhkNm8x?=
 =?utf-8?B?anBRZ2VpUStqc055bjl2d3N3RkpDNk1oYjl2ZzlXWEVKamNMalFGaFNlbzNN?=
 =?utf-8?B?MmsrZHpTQnJIc05oMmt1bWtST05IaDRGd1NnV0VJUTBib0FyU3FSbWNPN3Vs?=
 =?utf-8?B?SitFc3dHbS84dXVpY0RlRDRnOFpJMWV4MHNkbGxnYUhubG5mTVpHYklZQUZY?=
 =?utf-8?Q?djET/VKSqdQbfoO8mpKVdjj8I?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4055622d-1f3f-4172-2c30-08da8faabb4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 01:54:27.5774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NDdAJKSlT71N1SWb2iGqpd6384tHQ4sKkAdJb3rHRxdGcZEuDNDtwesLn8I60cD0cCxQIjvFviJijyXHeLoC4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2192
X-OriginatorOrg: intel.com
Received-SPF: 
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=intel.com header.s=Intel header.b=ew8lmoeF;
	spf=softfail (spool.mail.gandi.net: 192.55.52.93 is neither permitted nor denied by domain of hongzhan.chen@intel.com) smtp.mailfrom=hongzhan.chen@intel.com;
	arc=pass ("microsoft.com:s=arcselector9901:i=1");
	dmarc=pass (policy=none) header.from=intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IOq5gOuPmeyjvChEb25nam9v
IEtpbSkg7LGF7J6E7Jew6rWs7JuQIOuRkOyCsOuhnOuztO2LseyKpA0KPjxkb25nam9vNS5raW1A
ZG9vc2FuLmNvbT4NCj5TZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgNiwgMjAyMiA5OjA5IEFNDQo+
VG86IENoZW4sIEhvbmd6aGFuIDxob25nemhhbi5jaGVuQGludGVsLmNvbT47IHhlbm9tYWlAeGVu
b21haS5vcmcNCj5DYzog67CV7JiB7LKgKFlvdW5nY2h1bCBQYXJrKSDsiJjshJ3sl7Dqtazsm5Ag
65GQ7IKw66Gc67O07Yux7IqkDQo+PHlvdW5nY2h1bDMucGFya0Bkb29zYW4uY29tPjsg67CV6rK9
7ZuIKEt5dW5naG9vbiBQYXJrKSDsiJjshJ3sl7Dqtazsm5ANCj7rkZDsgrDroZzrs7Tti7HsiqQg
PGt5dW5naG9vbjIucGFya0Bkb29zYW4uY29tPjsg6rmA7IS47ZiEKFNlaHl1biBLaW0pDQo+7Jew
6rWs7JuQIOuRkOyCsOuhnOuztO2LseyKpCA8c2VoeXVuMi5raW1AZG9vc2FuLmNvbT47IOq5gOyD
geynhChTYW5namluIEtpbSkNCj7so7zsnoTsl7Dqtazsm5Ag65GQ7IKw66Gc67O07Yux7IqkIDxz
YW5namluNS5raW1AZG9vc2FuLmNvbT47IOyepeyaqe2YgShZb25naHl1aw0KPkphbmcpIOyxheye
hOyXsOq1rOybkCDrkZDsgrDroZzrs7Tti7HsiqQgPHlvbmdoeXVrLmphbmdAZG9vc2FuLmNvbT47
DQo+6rmA64+Z7KO8KERvbmdqb28gS2ltKSDssYXsnoTsl7Dqtazsm5Ag65GQ7IKw66Gc67O07Yux
7IqkDQo+PGRvbmdqb281LmtpbUBkb29zYW4uY29tPg0KPlN1YmplY3Q6IFJFOiBXaGF0IGNhdXNl
cyB0aGUgbGF0ZW5jeSBvZiB0aGUgcnRfdGFza195aWVsZCgpIEFQST8NCj4NCj5EZWFyIFhlbm9t
YWkub3JnLCBDaGVuLCBIb25nemhhbg0KPg0KPkknbSBkb25nIGpvby4NCj4NCj5UaGFua3MgZm9y
IHlvdXIgcmVzcG9uc2UgYWJvdXQgb3VyIHF1ZXN0aW9ucy4NCj4NCj5XZSBoYXZlIGNoZWNrZWQg
dGhlIGtlcm5lbCBjb25maWd1cmF0aW9uIHVzaW5nIFhlbm9tYWkuDQo+QW5kLCBNb3N0IGd1aWRl
IHJlY29tbWVuZCB0byBkaXNhYmxlIFBvd2VyIG1hbmFnZW1lbnQgb3B0aW9ucy4NCj4NCj5JcyB0
aGVyZSBhbnkgcmVhc29uIHRvIGRpc2FibGUgUG93ZXIgbWFuYWdlbWVudCBvcHRpb25zID8NCg0K
UGxlYXNlIHJlZmVyIHRvIGh0dHBzOi8vc291cmNlLmRlbnguZGUvWGVub21haS94ZW5vbWFpLy0v
d2lraXMvQ29uZmlndXJpbmdfRm9yX1g4Nl9CYXNlZF9EdWFsX0tlcm5lbHMgDQpmb3IgbW9yZSBj
b25maWcgb3B0aW9ucyBkaXNhYmxpbmcgYW5kIGV4cGxhbmF0aW9uLg0KDQpSZWdhcmRzDQoNCkhv
bmd6aGFuIENoZW4NCj4NCj5JZiB0aGUgZ3VpZGUgaXMgcmlnaHQsIFdlJ2xsIGRpc2FibGUgUG93
ZXIgbWFuYWdlbWVudCBvcHRpb25zLg0KPg0KPmh0dHBzOi8vcnR0LWx3ci5yZWFkdGhlZG9jcy5p
by9lbi9sYXRlc3QvcnRwYy94ZW5vbWFpMy5odG1sDQo+DQo+UG93ZXIgbWFuYWdlbWVudCBhbmQg
QUNQSSBvcHRpb25zDQo+ICAtLT4gQ1BVIEZyZXF1ZW5jeSBzY2FsaW5nDQo+ICAgICAgLS0+IENQ
VSBGcmVxdWVuY3kgc2NhbGluZyAoRGlzYWJsZSkNCj4gIC0tPiBBQ1BJIChBZHZhbmNlZCBDb25m
aWd1cmF0aW9uIGFuZCBQb3dlciBJbnRlcmZhY2UpIFN1cHBvcnQNCj4gICAgICAtLT4gUHJvY2Vz
c29yIChEaXNhYmxlKQ0KPiAgLS0+IENQVSBJZGxlDQo+ICAgICAgLS0+IENQVSBpZGxlIFBNIHN1
cHBvcnQgKERpc2FibGUpDQo+DQo+DQo+VGhhbmtzLg0KPg0KPi0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+RnJvbTogQ2hlbiwgSG9uZ3poYW4gPGhvbmd6aGFuLmNoZW5AaW50ZWwuY29tPg0K
PlNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDUsIDIwMjIgMTE6NDcgQU0NCj5Ubzog6rmA64+Z7KO8
KERvbmdqb28gS2ltKSDssYXsnoTsl7Dqtazsm5Ag65GQ7IKw66Gc67O07Yux7IqkDQo+PGRvbmdq
b281LmtpbUBkb29zYW4uY29tPjsgeGVub21haUB4ZW5vbWFpLm9yZw0KPkNjOiDrsJXsmIHssqAo
WW91bmdjaHVsIFBhcmspIOyImOyEneyXsOq1rOybkCDrkZDsgrDroZzrs7Tti7HsiqQNCj48eW91
bmdjaHVsMy5wYXJrQGRvb3Nhbi5jb20+OyDrsJXqsr3tm4goS3l1bmdob29uIFBhcmspIOyImOyE
neyXsOq1rOybkA0KPuuRkOyCsOuhnOuztO2LseyKpCA8a3l1bmdob29uMi5wYXJrQGRvb3Nhbi5j
b20+OyDquYDshLjtmIQoU2VoeXVuIEtpbSkNCj7sl7Dqtazsm5Ag65GQ7IKw66Gc67O07Yux7Iqk
IDxzZWh5dW4yLmtpbUBkb29zYW4uY29tPjsg6rmA7IOB7KeEKFNhbmdqaW4gS2ltKQ0KPuyjvOye
hOyXsOq1rOybkCDrkZDsgrDroZzrs7Tti7HsiqQgPHNhbmdqaW41LmtpbUBkb29zYW4uY29tPg0K
PlN1YmplY3Q6IFJFOiBXaGF0IGNhdXNlcyB0aGUgbGF0ZW5jeSBvZiB0aGUgcnRfdGFza195aWVs
ZCgpIEFQST8NCj4NCj7so7zsnZg6IOydtCDrqZTsnbzsnYAg7Jm467aA7JeQ7IScIOuwnOyGoSDr
kJjsl4jsirXri4jri6QuIOunge2BrCDtmLnsnYAg7LKo67aA7YyM7J28IOyXtOuejCDsi5wNCj7s
o7zsnZjtlZjsi5zquLAg67CU656N64uI64ukLg0KPg0KPkNBVVRJT046IFRoaXMgZW1haWwgaXMg
c2VudCBieSBhbiBleHRlcm5hbCBhY2NvdW50LiBQbGVhc2UgdGFrZSBleHRyYSBjYXV0aW9uDQo+
d2hlbiBjbGlja2luZyB0aGUgbGluayBvciBvcGVuaW5nIHRoZSBhdHRhY2htZW50Lg0KPg0KPj4t
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj5Gcm9tOiA/Pz8oRG9uZ2pvbyBLaW0pID8/Pz8/
ID8/Pz8/PyA8ZG9uZ2pvbzUua2ltQGRvb3Nhbi5jb20+DQo+PlNlbnQ6IE1vbmRheSwgU2VwdGVt
YmVyIDUsIDIwMjIgOToyNCBBTQ0KPj5UbzogQ2hlbiwgSG9uZ3poYW4gPGhvbmd6aGFuLmNoZW5A
aW50ZWwuY29tPjsgeGVub21haUB4ZW5vbWFpLm9yZw0KPj5DYzogPz8/KFlvdW5nY2h1bCBQYXJr
KSA/Pz8/PyA/Pz8/Pz8NCj48eW91bmdjaHVsMy5wYXJrQGRvb3Nhbi5jb20+OyA/Pz8oS3l1bmdo
b29uIFBhcmspID8/Pz8/ID8/Pz8/Pw0KPjxreXVuZ2hvb24yLnBhcmtAZG9vc2FuLmNvbT47ID8/
PyhTZWh5dW4gS2ltKSA/Pz8gPz8/Pz8/DQo+PHNlaHl1bjIua2ltQGRvb3Nhbi5jb20+OyA/Pz8o
U2FuZ2ppbiBLaW0pID8/Pz8/ID8/Pz8/Pw0KPjxzYW5namluNS5raW1AZG9vc2FuLmNvbT47ID8/
PyhEb25nam9vIEtpbSkgPz8/Pz8gPz8/Pz8/DQo+PGRvbmdqb281LmtpbUBkb29zYW4uY29tPg0K
Pj5TdWJqZWN0OiBSRTogV2hhdCBjYXVzZXMgdGhlIGxhdGVuY3kgb2YgdGhlIHJ0X3Rhc2tfeWll
bGQoKSBBUEk/DQo+Pg0KPj5EZWFyIFhlbm9tYWkub3JnLCBDaGVuLCBIb25nemhhbg0KPj4NCj4+
SSdtIGRvbmcgam9vLg0KPj4NCj4+QWZ0ZXIgaW5zdGFsbGluZyBidWlsZC1lc3NlbnRpYWwsIFhl
bm9tYWkgY29uZmlndXJlIGVycm9yIGFsc28gaGFwcGVuLg0KPj5Db3VsZCB5b3UgaGVscCBtZSB0
byBzb2x2ZSBhIFhlbm9tYWkgY29uZmlndXJlIGVycm9yID8NCj4+DQo+PklmIFdlIGluc3RhbGwg
Z2NjLTQuOCBjb21waWxlciBiYXNlZCBvbiAzMmJpdCwgWGVub21haSBjb25maWd1cmUgZXJyb3Ig
ZG9uJ3QNCj5oYXBwZW4uDQo+Pg0KPj4xLiBXZSBpbnN0YWxsIGdjYy00LjggY29tcGlsZXIgYmFz
ZWQgb24gNjRiaXQuDQo+DQo+VG8gY29tcGlsZSBnY2MgNC44IDMyLWJpdCBwcm9ncmFtOg0KPg0K
PlBsZWFzZSBtYWtlIHN1cmUgYWxsIHRoZSAzMi1iaXQgZ2NjIDQuOCBkZXZlbG9wbWVudCB0b29s
cyBhcmUgY29tcGxldGVseQ0KPmluc3RhbGxlZCBmb3IgeW91ciBjYXNlOg0KPg0KPnN1ZG8gYXB0
LWdldCBpbnN0YWxsIGxpYjMyZ2NjLTQuOC1kZXYNCj4NCj4NCj5SZWdhcmRzDQo+DQo+SG9uZ3po
YW4gQ2hlbg0KPg0KPj4NCj4+Mi4gV2Ugd2FudCB0byBidWlsZCBhYm91dCBYZW5vbWFpIGJ1aWxk
IGZvciBYODYoIDMyYml0KSBUYXJnZXQuDQo+PiAgIFNvLCBXZSB1c2UgdGhlIHNjcmlwdCBiYXNl
ZCBvbiBYZW5vbWFpIGRvY3VtZW50Lg0KPj4NCj4+My4gY29uZmlndXJlIGhhcHBlbiB0byBmYWls
Lg0KPj4NCj4+VGhhbmtzLg0KPj4NCj4+DQo+DQo+DQo+VGhpcyBlLW1haWwgYW5kIGFueSBhdHRh
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
