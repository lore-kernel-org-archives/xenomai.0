Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD00A20
	for <xenomai@lists.linux.dev>; Wed, 27 Jul 2022 03:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658892795; x=1690428795;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=rd7nLXXueBNY6ri1UPm9yT51Z4gDPVzFAPmgYE9ezOg=;
  b=U/U8BAI60Zhr3rno05JK+cx4th3Xa8X8wX/q9I6TNItjTUc9OJ4t1oe6
   6/GcYLUExf2q28RuaSDpx7XiKWsxwh5cSg/6lPrx5oM2Nm7GXMdrN0u3d
   Um0HghGwRBMk+F2iJ3er1xfWWC0wPwYxlBR3oBGBmVV4+FjVO8Sy4aB3E
   KFZs4+42rG5xCtobHhS2Mj13vnDl0Dk/i0Gjv1p2Q5TtCJ9pDM4gp2QPu
   awEyQB/r3GyUCAHGqnguUibFxo3LskW5IU8OlACtPc9ac+iYxCPLwAP1M
   iDe0APJutNiwWY7+TipDw5BcLl6/yxoCtqUTfZn8fYW7e9y3QTHxK8dQf
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="288144897"
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="288144897"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 20:33:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="633044585"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga001.jf.intel.com with ESMTP; 26 Jul 2022 20:33:13 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 26 Jul 2022 20:33:12 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 26 Jul 2022 20:33:12 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 26 Jul 2022 20:33:12 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Tue, 26 Jul 2022 20:33:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJhwqD+EhrB+thCLWO008TYm7o6TWOfSUPiAwnrRrxnnJiLAtLztks8Zs4SsdQ69N/BJGV7eKHmKZmSFfa2iPxulSJlDQtLtsmJsCG/kIpZWS9BE89ER1d9n00Nyum1Tka++/fScTwv4AvK4HDcSqBwnNBR6SjjPqdAEMHNJBummnS+bV/CKvP4vYZd5KVW6C6fvdN55/j8OBt724eIFDyZpqQyci0ngOQwObvq6zMmdIjOZgfXSLfBo9mCOsyaaYymGZA7/ny8vy3Jfanpx0NIdbPNcQep8wX/Da/pUL8b/lJbSSXQ0Bnk+97kAzUaim5NSGqEPLn9jjEu7Xo393w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tlujr9Nshls+iUXtCPYr58CkSM+zLC3OBfGsFC5D60E=;
 b=W0/te92lDj8Tp0tvwT1uhYIh87fDUYMtmFtYqgDrunx1C/0sEfXaz3fwCri2yciVuFPRTX9YAz1goPuzMHhbdv4PZa29OD7H6HRFbTRdDgeE4VS9Mm/Vg3uE9nptBDKqt2669aNkfp70BlmKDlmsu5M0ahHhoNmTj2NsJ/6QA2ZrBW6Y1U479Yd1eLkDZ8uViiau0oLPng2xZWysGSjfv9AcHM8yTMAof1Afo2nGyT6xNEDDvbAym2t/2QMahyBgCtE1RFcHQcefQeY49HBbndF3Yh2gqOvfwBGJojWnr1aWDYiPzL2cog7mh41Cai3nYCYLUyg7L2QnnJH2dQe72Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by BN6PR1101MB2355.namprd11.prod.outlook.com (2603:10b6:404:94::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Wed, 27 Jul
 2022 03:33:10 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::49c6:3feb:df48:3c6d]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::49c6:3feb:df48:3c6d%6]) with mapi id 15.20.5458.025; Wed, 27 Jul 2022
 03:33:10 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday,  Jul 27, 2022, UTC
 7:00 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday,  Jul 27, 2022,
 UTC 7:00 AM
Thread-Index: AdihaVOsCZj7ESRzRFSNqDTE+JlXQQ==
Date: Wed, 27 Jul 2022 03:33:10 +0000
Message-ID: <MN2PR11MB42859008B495F6A4745CBA80F2979@MN2PR11MB4285.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 84a7b0dd-a61b-4169-bb5a-08da6f80ba8f
x-ms-traffictypediagnostic: BN6PR1101MB2355:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YkJRcxuI0N7Y9x9pgOY/0a/lDj0sdysUjQRztq4nb60GAw6olv6mSTzj2FLm62ewLmy7DK/6zgpiWwPJTWLDp9LjTifmJzTOdTM6epk4G8QPnlay1YeJvzT//PWwIb6ABM5YAvqTRINJCvzfAVUiE/Y6iO+MnBWorZ5h1mPQJ8vpMOScnF4boYX0Q+h/GhbQodlzznvgMU8se6EHLkKjg9dkOI4C97OuEZaKONXNnHWL3q/uBJGVjOkauJnydjRZOpqZnRTpBKFtAKsd2QVAcnZtdCCWC/dnckPGG9oOx2JkMiI8w5KF6mR3AdCjg6kuvwIdgKZyxyaOv5STbYAcKA1OEGixyPbSz12/5gClQPWEFthzweiZb0ESj8SMCHoiaO0nnThXf9imedqpKT+syAjeMnd8W2kpDsvszewX8y/LofoafHmr/oQisjDj7I9kel9rgiN6FS08MIY6sAZwC3eHgKKQdZ2to86bCCi9qCCp3QS7vL5MRRxukyZd805JMvVB96U206e8mTCaygwr4iqCuueRprzwwYV53HE5lL9C080n/y/cVyfoLz6KFb2hpQS/khEIcp2mdanyRQJ6+OL4use2M+c84sGltVgTJb6oSVfE/hZsx2tVWioeMuhXdR54GVX+OpBm2C0ZNz1jLGAjClsjWDanixZolTrMGAJIVavMkhMBiD1ZSC8hp06MNeZJU1gklA+CVFuZt1GA3rhmQDGlMwKv00VRzK/slXr6mhezaJJXdhttWRoX9/BMji0R0RKwat+XvlOcLgdQRx4fD5gnhnIbNiHlVWM9CIxzRFZQmfrZ045bUdjguZFE0aw24NKk+FYBqGIymI92SDkl1mSle7eDPxYwxs9vjQZ+Cy5Rh2mtPH232J10htwl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(39860400002)(396003)(136003)(366004)(122000001)(966005)(33656002)(38070700005)(86362001)(38100700002)(40140700001)(52536014)(82960400001)(478600001)(9686003)(5660300002)(8936002)(316002)(64756008)(76116006)(66446008)(6916009)(71200400001)(8676002)(186003)(66476007)(83380400001)(55016003)(2906002)(7696005)(41300700001)(66556008)(26005)(66946007)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aLrF3gmbpZ0aaW+zIhEVv8FOQUCg8Xydex1Kee3ioLnPmX4Cz0FrAPsilof7?=
 =?us-ascii?Q?wJxF5WvHZkECpBaG025jHxrsRN17accDTZMe8GB+h6PZtLIFdDjXBRv2dzjX?=
 =?us-ascii?Q?sigA9MbhXI5rHpZ7hXMvx7EUor7lOaUYlaOdEH33diYmaF6AeLbe/3sVbNYL?=
 =?us-ascii?Q?53cice+63Uwax1lgvW1PKkPYWRtgDPc+qqpGgNhUyMAkEU/XGl0ZMrJNnA6G?=
 =?us-ascii?Q?p/qd7yWtNpusqA85remjDvq2qMtfRMHdeEGfIsyjJWA7tiTD+g4262TE4Fqr?=
 =?us-ascii?Q?MQTz+oTM/htOmk3PD7jzExHep2FCPjr7OLbpqLCekIhylWV8DxcIf/O6R19d?=
 =?us-ascii?Q?sLeiYAbq5y8c9aeI0211pU8dhsgji76tiPkodN5qEegjhlYVmeWDrjkmbq3+?=
 =?us-ascii?Q?3ObMwN4ABKtV842cw272xFzMr36vGOGvsxJi7KoxN2tndifRxbMp99G5yt8D?=
 =?us-ascii?Q?ldXCzVL71OWqyicJ7SNj1s2Q0OybgednP8pp5d6A/7TjYdnawHDGLbLba2aY?=
 =?us-ascii?Q?/DVaSVyZppNUI1SNz+bZ0yiQ1mW/wo6PEkcDCok9lVcb3ybWIboO6rsIsKyO?=
 =?us-ascii?Q?feNh4YKklrBy5Xzgqn7tblcl2nGO7EHUVC+TE/GV3tWs0EsH+wDcpCmKMGOk?=
 =?us-ascii?Q?4zjgj+Caevb5O3Q8L4V6pYJ3tRLPBrZV9ECb8O2rNa09CaPYAeaHcWDdDztX?=
 =?us-ascii?Q?8V0NsWrH/un5XrNlBFo6S68cTs9ELVJMmleII5vj9MVZnOcE3IiisEnOuzeb?=
 =?us-ascii?Q?1uA7UtFase+6gpon2Fzrfk8mCp2TuZBcdVYTSwBT2pjFnV4VNyne862NHpBi?=
 =?us-ascii?Q?974wwl4xyqIneYZMObasR8Mt6vr8b1xLbw8nWsOLLOzPDRWjdUZ/ZOPjP2jP?=
 =?us-ascii?Q?UJtlVv6gZVNwM7Q6SnHpbskxBsFXNZaAOOeLPXp9irafKwbT3OpSFOm7bHmo?=
 =?us-ascii?Q?HBbmyQGS98zUdwULwHe68UY+9tt3/3dN3iaNUfK150vlqM7C2vo5WsHXZDPS?=
 =?us-ascii?Q?5BsqQKR4J6YqtGGTYRGVNscCF2w4xIuXRvf+JZYLromHGkfls4dochmFOlgw?=
 =?us-ascii?Q?3mB7aiAimBAE86qFzokiNyr3mUHOLQiP8s0/9C3LJZdZx7Ikd5OSOPx5ci9b?=
 =?us-ascii?Q?CmQ0fSmMOQdGeNNyXXFlxF3ZfT+312USZD+/1eIBYsYV/itz1qsetdn7atkV?=
 =?us-ascii?Q?N0CfWCbhLLBEicyQJF5RHyUVAukniyRdVijeVDWwkPEYyvTVoiraMkn06r38?=
 =?us-ascii?Q?7QfGd2ss4R+XDvGbCdBFNv9JsvbLNxwu/7DI/sCzD/gPrGqoawk9hhD3k0bQ?=
 =?us-ascii?Q?07D6A62mLtKs2AcPPM88DnGXYhW9fjjlqOjg/fwbIA4Xo/aUduY7KkpBfxaw?=
 =?us-ascii?Q?PMv+wXo/GJ1WfuEGWMZc8V8Nuc7AXWyzhIQhEVeYTM39wW7Tc56zQbHLS9sW?=
 =?us-ascii?Q?VlcDDwZiE6/mpKITqxB/A5lUCSue79YH2A1o/VR7jn1WdlZ18PftUOAGU8Bh?=
 =?us-ascii?Q?7Q+aRLJ/nyvRv2K4Oz3VJeJscK2hJQe/dsylXhG0nNoVH3PlDEEW1kb+5hkb?=
 =?us-ascii?Q?zSz1spXoTGHANve8gIFD2vyn4/PgYynOwYx1YH+s?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4285.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a7b0dd-a61b-4169-bb5a-08da6f80ba8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 03:33:10.2669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OxjR6tdWuFhkjLuqNoHpxl2fEqrEzGYehP4GbVPN59b/SZE0BudJsype7MVEJ5ShT+gGpu3AhNQTMZi6CZhmvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2355
X-OriginatorOrg: intel.com

We have the Xenomai community call today.

Topics may include but are not limited to upstream/downstream project=20
plans, status updates, and technical discussions. It's an open online=20
meeting that anyone can join and ask questions.

Time:
Wednesday, Jul 27, 2022, UTC 7:00 AM
Paris, France CEST 9:00 AM
China CST 3:00 PM

Join Zoom Meeting=20
https://intel.zoom.us/j/91297279269?pwd=3DWmdwS0pDODRNMS9tQk54Y1dvbFlqUT09
Or
https://intel.zoom.us/wc/join/91297279269?wpk=3Dwcpk52a9f96d989e7e20b628c2c=
36e48b68e

Meeting ID: 912 9727 9269
Passcode: 367528
One tap mobile
+12532158782,,91297279269# US (Tacoma)
+13462487799,,91297279269# US (Houston)

Dial by your location
        +1 253 215 8782 US (Tacoma)
        +1 346 248 7799 US (Houston)
        +1 669 900 9128 US (San Jose)
        +1 301 715 8592 US (Washington DC)
        +1 312 626 6799 US (Chicago)
        +1 646 558 8656 US (New York)
Meeting ID: 912 9727 9269
Find your local number: https://intel.zoom.us/u/aTEA37i5G

Join by SIP
mailto:91297279269@zoomcrc.com

Join by H.323
162.255.37.11 (US West)
162.255.36.11 (US East)
115.114.131.7 (India Mumbai)
115.114.115.7 (India Hyderabad)
213.19.144.110 (Amsterdam Netherlands)
213.244.140.110 (Germany)
103.122.166.55 (Australia Sydney)
103.122.167.55 (Australia Melbourne)
209.9.211.110 (Hong Kong SAR)
149.137.40.110 (Singapore)
64.211.144.160 (Brazil)
149.137.68.253 (Mexico)
69.174.57.160 (Canada Toronto)
65.39.152.160 (Canada Vancouver)
207.226.132.110 (Japan Tokyo)
149.137.24.110 (Japan Osaka)
Meeting ID: 912 9727 9269
Passcode: 367528


Regards

Hongzhan Chen
