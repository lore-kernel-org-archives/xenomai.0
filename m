Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709A37B
	for <xenomai@lists.linux.dev>; Thu, 25 Aug 2022 06:20:20 +0000 (UTC)
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 5CAFC240005
	for <xenomai@lists.linux.dev>; Thu, 25 Aug 2022 06:20:12 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	by spool.mail.gandi.net (Postfix) with ESMTPS id B8B737803D2
	for <xenomai@xenomai.org>; Thu, 25 Aug 2022 06:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661408410; x=1692944410;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HB66TwoJj2zmpjaPdURv/LOIGfkXVAO9sTGd9noA8pw=;
  b=TNdrx44vROC3Tdckgjd/r0tsUyJnCemkltMpekWRYW2QZz4X7nEaDgU0
   KacAVBsw79V+ip+H6Ow828feYyBPT+bwUTtMvWmSkWxoR90f4vGYSALey
   94vNL/x8s27idGaRgvQsAYZ+73tP/MhUPhEaW/NulRn6LZQdk+epTs0wd
   A9OVMaOF3RouQmbTgzASuIMEHdZRn5+ZkLp1cMrFxX2cMHXvDKeEjZxnf
   rZswiReFFe8/vZIkA+Kl2vPE0bAY7x8AJLcd1BkIt2Xt4nednxIJhz5Ao
   1n/jtjtJLp70M5fq12Nv71gy3cf+raoOjfkhRTJn5gMBmrdQqpHWkSJY9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="277178506"
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="277178506"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 23:20:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="639452562"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 24 Aug 2022 23:20:00 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 24 Aug 2022 23:19:59 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 24 Aug 2022 23:19:59 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 24 Aug 2022 23:19:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3FS2GkB22Uf/fMZi1QgVEcUa7InmyTTQidZcvVwQH/Z0GSUIiQwj+7mmuml6b0axsj6ePT51E3aQNo4nboli969vAHgO2DTEOYq746R/Swkv9RiElTROaWRu34HLmPnL4NNeF6Acwa5Fv9/I7H5WVigwNzFUkoQ+RhaI1mDsP9H/wFcaJVl4KcXMA9/+HSP8nW0kEiec6qEQ+d3I+/jLE1zdQ+xcFiTWd6zETC+u5v9ebMQEeMNspnyMKaxQjDt1YYPv3aXGiBGJlqfukShbvatu6q9RSjiv7EIixPVTrT0XKSqAH6LfsmNZY6eyuXt2KrgdVPXs0/4lXpCZymhog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HB66TwoJj2zmpjaPdURv/LOIGfkXVAO9sTGd9noA8pw=;
 b=ZO7OVhIlZgFZZI9W2VA6YC5hxaDPFT4HW+UePHTYFRI871cZO+92Er1po/JF3L964n2dUiNI6fXwgXPUOjM1Z6vU3c0IASO0WqRqHeNGc62lMLUpC9LcMr5Rgc58iRatZWX+V5JqQCHYwCuxcB6Hua5lFiv06YY8esbjTTTpjGp2vCaRxLLRJy4V0eIH9VrX+QFwNyubNMmZwEwDyPNS43zjrCwxiBXXsQL9Axx4sS6wYhbocMVyRrKWLpzswB1C1fRu49oSxpb5y17Cm6DK/DeUlg3AZtoVByBNOvioKKdPPfov6CZEc/vH2gCOjUBtjUK+Gezen66/rsmzfzfQ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by CH0PR11MB5475.namprd11.prod.outlook.com (2603:10b6:610:d6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 06:19:52 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::159d:a6de:f2b9:fc83]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::159d:a6de:f2b9:fc83%3]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 06:19:52 +0000
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
Thread-Index: Adi2hA+8NshNMGH/S1C5hT38XRCzfAABQnKAAEPabkAAHYUU4AADTiNwAAcm6LAABFvNgA==
Date: Thu, 25 Aug 2022 06:19:51 +0000
Message-ID: <MN2PR11MB4285E860217DB23B18016495F2729@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <SE2P216MB1394874A00E10A497FE73DE0C2709@SE2P216MB1394.KORP216.PROD.OUTLOOK.COM>
 <MN2PR11MB428519AFC0F522BB25FDA093F2709@MN2PR11MB4285.namprd11.prod.outlook.com>
 <SE2P216MB1394C7C6A067126F36022F23C2739@SE2P216MB1394.KORP216.PROD.OUTLOOK.COM>
 <SE1P216MB1509579188F44BA6C35E8547B1739@SE1P216MB1509.KORP216.PROD.OUTLOOK.COM>
 <BY5PR11MB4276CD67150EE6042EB1A849F2729@BY5PR11MB4276.namprd11.prod.outlook.com>
 <SE1P216MB1509E22586BCCE1E4899A946B1729@SE1P216MB1509.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <SE1P216MB1509E22586BCCE1E4899A946B1729@SE1P216MB1509.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd9c3807-4b41-4d7a-fd92-08da8661d219
x-ms-traffictypediagnostic: CH0PR11MB5475:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x7q6oaF33jMe+XT/u7Eaj3fLDvuUQN0QQ+byuoXYd03bNmv6pwMyNbs63tXZbSDgQobXB9qf3uG6o57WrKoa2UDjGeo/jbzLqhG82t2144wnwCJwGPWgKby19WxH3F4WCdGtL6ZErEjgfSNLbOuY+bLQ8bQWe8oiGz4KcDiQ8dnQzXMaxlVQJzR3vnK4Y48xCW/BsJb/rKWLPO20vfVBN+wqMXptTp1H0GEK75+PrG9PuBPPtLzHS3CD7Nko9IgW1pxJ8zQGS6S24bSqWrkeVg96ddW9E2bY3Kkz+oFDiYCURemRlVsIBUtwfHoxl03ZKd7NnlUvvARzikJTGnXlxfCzEo0aQDPqqh92d+tS0hD4fyUigxbXIR5GYOI2migqaCTfCmOsURlfDm5dSo5SYyRpPebivwdhVrkhZVlrh8XCajCFLjFN1urtNzvLV5rJcC60f3UnOxnLqT8AJ8CV3W5M3k+9lCi803/eKyv5+EHUgzH8k+ZlWV+Mr2Z1j+DiQTtQQjBQrTfk8pDga60XmGxJi7kD9hNxxXIRuR4kTIormxLl/AKG7H55N4s9myGcrJ0M9PX4bNdoXU0twkoTX/Qp6tuiLGKJKT6vXhVt+UeBTqU7HQxU6LR20vakTYvH9BBFY4op9VWYd3GT6HMwZ7tAbxIQeTx/fNzpMOIrWNJqkn+EpT0ZEwGCfGWyDT7VfgDWRyWau41AedMB4jHo61w8Zp/CSHy0A9LCrPGppvW0u/twut4Mee/gElpTaEn2OGJ0gcboGBcpvXFRyJWVIw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(396003)(366004)(376002)(346002)(86362001)(54906003)(7696005)(2906002)(55016003)(82960400001)(122000001)(110136005)(6506007)(26005)(38070700005)(9686003)(316002)(66946007)(71200400001)(33656002)(478600001)(186003)(5660300002)(83380400001)(66476007)(66556008)(41300700001)(66446008)(64756008)(8676002)(4326008)(76116006)(52536014)(8936002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TzBlQUJtUExZY09hZ3FmNDVKUE9CcXJNK0F0RUJSSncrZlU0UlpyZDU2UEJC?=
 =?utf-8?B?dmkwRjRUbXd2ellNNWowUVBHOVc4U1h1TTFPVTZsRE9PNEpaRmFGckJSNEow?=
 =?utf-8?B?eUdtK3ZDb3dWdlFTTEFOaGNuYWlybkJXR082TlV4SmEvMzBuM0R0SHBJamt6?=
 =?utf-8?B?aDJyaVRNelNadDJheERiMXl6N0hVUmJSVjJwYUc2YXgrcGw5ZnUrRUNzSkg3?=
 =?utf-8?B?dHl1TGVLZ2FnNEpJTjkzOHFidnpLU1hYSTlKb29OaTlQOUVHdXhPblBDY1Jt?=
 =?utf-8?B?eGhlNVVQUEt1LzlPdWVra0ZDY1g4a3VqZGZoMWFyLzZ2RnRGRzVVRVFYVG15?=
 =?utf-8?B?bGZBVG5hMDhtN3YvcU1FVHFINFlkR0hPVFVEQ2FLdWtBVWJPRmpIWldCd0V1?=
 =?utf-8?B?MXJDYlVDYktZa1djcXZZSmNKMzlyUWVtS0J5WHQrUDZsRUNsQjhKMVpFSDlt?=
 =?utf-8?B?WmNaQ2E3aUcrNkZEUVlRK01saGs5TDM5WVRPK2VBcjlReEtwOHRvZi8zWU9j?=
 =?utf-8?B?djMzWlJWZEJ5aldXVkI5NThES1hBTGZQMEcwWDRieHQ3QnRwTnVkQ01VdkRS?=
 =?utf-8?B?RkZoWEhCVHdEdnFneW1WU0R0Y3pxeC9TL0M5aDE2czVLRUV5b21ERXB0elNB?=
 =?utf-8?B?ZW41ZG9wUGpnOWJkbjUvZytIbHdlZ3ZaV3p5K0FBWHo5Q1UzTHlMaXhldVR4?=
 =?utf-8?B?VmlOTmErL2taM3pjQnJVMVB0Q2M5YitjeTRwSk5DMmxYYWJGaERnOWFJc3lP?=
 =?utf-8?B?OWU0R0RHYVBtbjNuSnErMjJYWTRKamdLdzQwTVZwclBtektwNThZQTdDc253?=
 =?utf-8?B?MERlelM3V3J2U1Z2Yjg2OWo0N1pGVTFkaFBqOHk3VGVySmhyL1F2WEduZDFu?=
 =?utf-8?B?eGJtMUtHYXlxT2FSRXhYNUc4d282VmNzRVN4enVTakJsaStYNTRFTVV5YkFS?=
 =?utf-8?B?eDZqVFh5U1lBQjVIeFFqMUJkWXBlc0NNRjBieDlZRVowVGdERUR5Zkk0amNF?=
 =?utf-8?B?RmpaWm1FU3kxeFQwOXFRRHIvNGl3RXVOQ2tvdFJ2aFlCZWQwNzBlbmQraENJ?=
 =?utf-8?B?ZDlSL2pFbFVabHB0dWF6cEF1c0xXTjVuakowV252NDh4R2c4V1d6U3psUE82?=
 =?utf-8?B?WkEzT2lSZzN4VGpNSThVM09OOTJUeTBJMXV0Z054WVVkd3g0SnRlTUFkQWJt?=
 =?utf-8?B?SmVqdkREaTdoM1VUUVYvSFR2VGtZMkJJQ1o1SUcvVmVhZm5mTzdkVnZGNVdr?=
 =?utf-8?B?ZHZRWU9YL3dyVXQ2MTZiSGZaMnZld3lnRFZjaXdjMld6RVVrVlJ1MWNRQlB3?=
 =?utf-8?B?UTg4SmVDUk4yalFubWJxZmhFUlNPdU5kK2puaUdmUUxIQmdkWWkyWWxUU0w1?=
 =?utf-8?B?NXpmSVRZSXNpamN2SHphRE96NTJBSldEMytlUlJ3R0cvc1doNUVmdmpRNnVF?=
 =?utf-8?B?L3QyZlJrZEcyckU5UzBwd1RKSE5RMTBGQnZMM3BubWpWU2NNQkZyU1FWQll6?=
 =?utf-8?B?cENSRFVCRENrT0pMVU82WTdXU0ZvdXduSURZZlQxc1Zxb0sxbERsTUgrNDZp?=
 =?utf-8?B?UjZwbExCQi9YOVg3eU1LdHI0b056eUU1aWhhRW1JNUlhTjM1OFVrN2xHWjFa?=
 =?utf-8?B?RXFKY1E1R1JqMFNvMmQvbVZNY0ovclZ0cXZkS2xkTGs0WkNOR2t1WS9kRlZZ?=
 =?utf-8?B?S3VYRGJBS3UyR0gwZnpSRHJ6OXMwQ3dySWdBZU1nbExrY3F1SU1KaitKaDdN?=
 =?utf-8?B?RHMzb1M3WkRvRVFPOWt5OVV0VkZZNkxLS1RYL3Fvb2VRYVBCamlYVXRRdTJo?=
 =?utf-8?B?QzFqelJrekgzc1FHT2lydlhDNGEwcFh2ZWcxaks5ZDNYUnB3eVZFUmp0TWYx?=
 =?utf-8?B?N3BIbVI5blZXWlJhdFp0ZEZ6blk5YmpUTDNLN0szQjU1MTQzUnlxZ0dEOTdF?=
 =?utf-8?B?QTU5ekQ2VGY3YkYvLy9SMzZ5V2hVOHNnOThab1hDTmpwR1VpRVBiMTlOSndq?=
 =?utf-8?B?eS9vVUNma3hoRXBzQmpKQkxyZm5QTCtuQnJQYm15QUdoaXdsT1lPekhzUXZs?=
 =?utf-8?B?ZW1rVVRLeFlyUm04VXdoY0RCUkt1c2EzTlFraWhqMkpkTjU1enQ3S2hycEhy?=
 =?utf-8?Q?UkRl935DYD7zSIdss8lxIB4MT?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dd9c3807-4b41-4d7a-fd92-08da8661d219
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 06:19:52.0746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dcN/kt73LTEFgyNTjTZL+5BOr/YeHI9AnbeIkXoY1mdGayvFiDADIoMlAxEW6FR/d33UTeDG8fpXUtaLMIE3cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5475
X-OriginatorOrg: intel.com
Received-SPF: pass (spool4: domain of intel.com designates 134.134.136.126 as permitted sender) client-ip=134.134.136.126; envelope-from=hongzhan.chen@intel.com; helo=mga18.intel.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=intel.com header.s=Intel header.b=TNdrx44v;
	spf=pass (spool.mail.gandi.net: domain of hongzhan.chen@intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=hongzhan.chen@intel.com;
	arc=pass ("microsoft.com:s=arcselector9901:i=1");
	dmarc=pass (policy=none) header.from=intel.com

DQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiA/Pz8oRG9uZ2pvbyBLaW0pID8/
Pz8/ID8/Pz8/PyA8ZG9uZ2pvbzUua2ltQGRvb3Nhbi5jb20+IA0KPlNlbnQ6IFRodXJzZGF5LCBB
dWd1c3QgMjUsIDIwMjIgMTI6MTggUE0NCj5UbzogQ2hlbiwgSG9uZ3poYW4gPGhvbmd6aGFuLmNo
ZW5AaW50ZWwuY29tPjsgeGVub21haUB4ZW5vbWFpLm9yZw0KPkNjOiA/Pz8oWW91bmdjaHVsIFBh
cmspID8/Pz8/ID8/Pz8/PyA8eW91bmdjaHVsMy5wYXJrQGRvb3Nhbi5jb20+OyA/Pz8oS3l1bmdo
b29uIFBhcmspID8/Pz8/ID8/Pz8/PyA8a3l1bmdob29uMi5wYXJrQGRvb3Nhbi5jb20+OyA/Pz8o
U2VoeXVuIEtpbSkgPz8/ID8/Pz8/PyA8c2VoeXVuMi5raW1AZG9vc2FuLmNvbT47ID8/PyhEb25n
am9vIEtpbSkgPz8/Pz8gPz8/Pz8/IDxkb25nam9vNS5raW1AZG9vc2FuLmNvbT4NCj5TdWJqZWN0
OiBSRTogV2hhdCBjYXVzZXMgdGhlIGxhdGVuY3kgb2YgdGhlIHJ0X3Rhc2tfeWllbGQoKSBBUEk/
DQo+DQo+RGVhciBYZW5vbWFpLm9yZywgQ2hlbiwgSG9uZ3poYW4NCj4NCj5JJ20gZG9uZyBqb28u
DQo+DQo+VGhhbmsgeW91IGZvciB5b3VyIHJlcGx5IHRvIHVzIG91ciBxdWVzdGlvbnMuDQo+QW5k
LCBXZSBoYXZlIGNoZWNrZWQgdGhlIEZ0cmFjZSBsb2cuDQo+DQo+V2UgaGF2ZSBsYWNrIG9mIGtu
b3dsZWRnZSBhYm91dCBYZW5vbWFpIENvYmFsdC4NCj5TbywgSG93IGRvIHlvdSB0aGluayBhYm91
dCBvdXIgdGVzdCByZXN1bHQgNG1zIGRlbGF5IHVzaW5nIGJ5IFhlbm9tYWkgQ29iYWx0Pw0KPklz
IHRoaXMgcmVzdWx0IG5vcm1hbCBvciBhYm5vcm1hbCA/DQoNCklmIHRoZXJlIGlzIG5vIG90aGVy
IFJUIHRocmVhZCBvY2N1cHlpbmcgQ1BVLCB0aGUgZGVsYXkgc2hvdWxkIG5vdCBiZSBsYXJnZXIg
dGhhbiBUSUNLX05TRUMuIFRJQ0tfTlNFQyBkZXBlbmRzIG9uIHlvdXIgc3lzdGVtLg0KDQpSZWdh
cmRzDQoNCkhvbmd6aGFuIENoZW4NCg0KPg0KPg0KPk91ciBpc3N1ZSBhYm91dCBYZW5vbWFpIDMu
MC44ICggTGludXgga2VybmVsIDQuMS4xOCwNCj5pcGlwZS1jb3JlLTQuMS4xOC14ODYtOS5wYXRj
aCApDQo+DQo+Tm9ybWFsIDogWGVub21haSAyLjYuNSAoIExpbnV4IGtlcm5lbCAzLjE0LjQ0LA0K
PmlwaXBlLWNvcmUtMy4xNC40NC14ODYtMTIucGF0Y2ggKQ0KPg0KPg0KPldoaWxlICggMSApDQo+
ew0KPiAgICAgICAgQSBmdW5jdGlvbiAoKTsNCj4gICAgICAgIC0+IEEgZnVuY3Rpb24gaXMgcHJp
bnRlZCBldmVyeSAyMHVzIGJ5IHVzaW5nIHJ0X3ByaW50ZiBmdW5jdGlvbg0KPiAgICAgICAgcnRf
dGFza195aWVsZCAoKSA7DQo+fQ0KPg0KPg0KPklzc3VlIDogWGVub21haSAzLjAuOCAoIExpbnV4
IGtlcm5lbCA0LjEuMTgsDQo+aXBpcGUtY29yZS00LjEuMTgteDg2LTkucGF0Y2ggKQ0KPg0KPldo
aWxlICggMSApDQo+ew0KPiAgICAgICAgQSBmdW5jdGlvbiAoKTsNCj4gICAgICAgIC0+IEEgZnVu
Y3Rpb24gaXMgcHJpbnRlZCBldmVyeSA0bXMgYnkgdXNpbmcgcnRfcHJpbnRmIGZ1bmN0aW9uLg0K
PiAgICAgICAgcnRfdGFza195aWVsZCAoKSA7DQo+fQ0KPg0KPlRoYW5rcw0KPg0KPi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ2hlbiwgSG9uZ3poYW4gPGhvbmd6aGFuLmNoZW5A
aW50ZWwuY29tPg0KPlNlbnQ6IFRodXJzZGF5LCBBdWd1c3QgMjUsIDIwMjIgMTA6MDcgQU0NCj5U
bzogPz8/KERvbmdqb28gS2ltKSA/Pz8/PyA/Pz8/Pz8gPGRvbmdqb281LmtpbUBkb29zYW4uY29t
PjsgeGVub21haUB4ZW5vbWFpLm9yZw0KPkNjOiA/Pz8oWW91bmdjaHVsIFBhcmspID8/Pz8/ID8/
Pz8/PyA8eW91bmdjaHVsMy5wYXJrQGRvb3Nhbi5jb20+OyA/Pz8oS3l1bmdob29uIFBhcmspID8/
Pz8/ID8/Pz8/PyA8a3l1bmdob29uMi5wYXJrQGRvb3Nhbi5jb20+OyA/Pz8oU2VoeXVuIEtpbSkg
Pz8/ID8/Pz8/PyA8c2VoeXVuMi5raW1AZG9vc2FuLmNvbT4NCj5TdWJqZWN0OiBSRTogV2hhdCBj
YXVzZXMgdGhlIGxhdGVuY3kgb2YgdGhlIHJ0X3Rhc2tfeWllbGQoKSBBUEk/DQo=
