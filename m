Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A6962A
	for <xenomai@lists.linux.dev>; Wed, 29 Jun 2022 04:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656478160; x=1688014160;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=Uu2EQdrJBwxyJwYyVDh4wAGK2kyRIgiykGruR9OgcMU=;
  b=CnKp3/c/PJGfMoBtMYNrPrcnADKLn334vCt+h+GOUZ7tPb/+fSgcHnKD
   ApgNxqseGvE+nKdRDat+c8mB1pZFFMgLmqzE6p4uYY75/GU/LZ+HmvRG9
   uZtJpuxObiEE+Y52Oeg8PsyUB3ZsFdj3f4suNydyfW5AgDEkBJqh0ekw2
   QsahRWjJUD8SL6FmrrFTVr4Gp/UIX7HYAPFzXRoWg++DS/KAcGT0eY5+6
   6plG4yVlHne674/G8e22sioACLFmyPMsKLdr8qRRzHWWwxVw0BAoJW+f9
   FmxqIeZUdzGzwPZvIwoEdtA2w0CofstBBllCiNGLTUetjoNx9CkjJxO9/
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="343610119"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="343610119"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 21:49:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="595079856"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga007.fm.intel.com with ESMTP; 28 Jun 2022 21:49:19 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 28 Jun 2022 21:49:19 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 28 Jun 2022 21:49:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 28 Jun 2022 21:49:18 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 28 Jun 2022 21:49:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gk8HgIwbBlnECD/cjPZr0hWY53OYj32tYud9GW7EargDguCeIZTXhW/xNVZS00ALX0EYr+uSQbPqN5BtSZ7YklTdRZEt/pxlANFszt86M/1BoeekJseeahFRjSzP0ZT9SnXHaFYK8z5HcgZuLXEXyPH5BtvmZuoU1EbMY0KwjuRy3l5UgVLdfagjX+twqw/zysHlmpx4CCLgpOf+APEjVuiqfptr+uwpldUMOGDa+IVgi+URDmEJ2y3++sopCMfLe4IX5kuxXmHyW6WwVzo4qJ8ZS7L56bNB5ro0ZsAAZmCUl4sU6jb0NUG+gQh1CoyDr2nOuXfyoT7+stGwO3J2ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YWjY8DUa1CyIEufJoWcSUriP5hupTc2pXklE5K1X2W0=;
 b=kACMiog5zMqPvVIbfYdiAUXXZPQ8+h3uKfOaRJNa6eGT3r4IBzsOwmX/IBDl0EtfUjfQl/NDA8Zh+VX7+BUQqxOErZBhjFvbcMh/fG9z5hzoheXV0dhJPk+Os30ISlfXy7pUI2lYoFk3XQMdsiOS3s45gLUyFAyrITlTXrzzrKWycgOpIV+/YAX50ipId/GAb+cornaU53a7u/NAnPFIbXNu5G5XOpo7xQC2DGrLrBXk0I3x2rYZ5tp6pRrUtQy3E6N8oA2pTi1AvhhbLvFEcrTGljw02kq27B2BUQi+/n81QHaKIxW195/kK26jvigbtvx7qDAOmlSPgSFYX/WjqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by BL1PR11MB5480.namprd11.prod.outlook.com (2603:10b6:208:314::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 04:49:17 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::49c6:3feb:df48:3c6d]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::49c6:3feb:df48:3c6d%6]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 04:49:17 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday,  Jun 29, 2022, UTC
 7:00 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday,  Jun 29, 2022,
 UTC 7:00 AM
Thread-Index: AdiLc4X2AoaWkB8cRJitebSTAKvXzQ==
Date: Wed, 29 Jun 2022 04:49:17 +0000
Message-ID: <MN2PR11MB428586FB57D59C5AA1DCFDADF2BB9@MN2PR11MB4285.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 737bee9b-6cd7-491f-577a-08da598ab908
x-ms-traffictypediagnostic: BL1PR11MB5480:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4HIqdtzw9pe3Dkgcm+/VibeTCWQxsexYydLQQ7DjoWx2aCdMYQ2RUyRvN+8F6Gd8yBh6YmlQaUu/Og94dJYBs9j0olVx7YO/x5BycZCDr3Ss5wVgD8IKB7HGm1YGn6ex9Z2OF3hKIorEBWzQpSNHqkRGH+m21oG+VsY2xevyeczttx5//nLgGfcumWWUJCG28gtumjgbnIEve0R4sAzE4NknYHPAWLYdBGTQRAZfopkfbi3RsjA0/zMQJ43l1AV4dpCvTMTo1GtJxyo/qlLqC+FFRpAY9OVTlBinzW+k2XUNLFftZCZmcSgGKmXgHYFpjolqPI8FcF6/cEUo5XvNYibw7pkgYqQXo4Np470fpU9t38/eCDK+TjDU/WOBpuQCVUQJ4xoR1bV2ZwTPVU5okIb/aYkGr/jODgvC56DK5D+K4tKYQ0gbYz07v76q0KFUBu09oTMedMiQEcqEHx3YhRUA/arkZuxZWhJODIXGuThvrhE5bDMHotDt9ThvPArtP2Ur0zZi56EpCKYZrMejRWhibV8LEV0QWuXSKdPyTYfjklSOWePFKi46UOMGogfI+Z6khNC1PsDYY+WEGno5xwyzr0cNPOUUpJPa2jwVCdUzILvBIWRJOLi8631Gon2l8nU68Vww9yfIjk4YI2rOemEpgoJkzvaiHJ+ccid+fQ8fg+2qsh/R81SV3SGUoZsv9tdeAgsD2ZQgjsObSCKktfYEtssk0ZVvw58rsN++/4ESjYq/FbUSfEKyDrl396ifMDUZ/oVGtqS5D/AmANb4/Bur+84yVGZ6FaOp9CNpFGvmw+wBOtc7Evm+JnadbrEhnEDzTUxsc5YrBtdnagMmic11zL0NSRTLt+PZpfy5dZfpoE6XD+eRuinH8Z36teJ1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(366004)(136003)(376002)(396003)(83380400001)(6916009)(33656002)(40140700001)(7696005)(6506007)(316002)(71200400001)(26005)(9686003)(86362001)(55016003)(41300700001)(966005)(186003)(478600001)(8936002)(52536014)(82960400001)(38070700005)(122000001)(2906002)(66476007)(66946007)(66556008)(66446008)(64756008)(8676002)(76116006)(38100700002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UJoP6Buxy0ZvjGU+DhMq2B/gahOF4peo6WKAWoEiVYyFfSsb/tTx+uSfClWe?=
 =?us-ascii?Q?zDWi/xFCVW78GsF/yYoUstGz2naa6Mc+ZbWrINm+keq6NR0fVumOW9aT0bLc?=
 =?us-ascii?Q?yvYVBF7skMKhiwSajsjiJ3K1opfx8XxMWPQPbU1Y4xGvxf0DNeNh6w2OUC+a?=
 =?us-ascii?Q?Ii10NEjKcVAngtAKPo8mXO1NuXs4i6Z/MgDkFVNREx5kLIzw11IyMt+AWLz+?=
 =?us-ascii?Q?v2hftRW7fgI/8FFLupCx9WjxM8rvIhHpa7LyiHiD67nNAVA7mlU/aAzD04Zo?=
 =?us-ascii?Q?RkargCOemF4J2NZv6T/rZQJyebbSWB1RUiqV5Cevb1tq4TtZjwHVTZ3/nQ4M?=
 =?us-ascii?Q?QaCaOt2trihq9ylK0uSo58eL4VTmRxLqoNd9VCo1VOHquHGEUtO/FuHgaMwh?=
 =?us-ascii?Q?mU78suK3oAdrtBnxcA34OJs9VOtYLDl6D/fuUppUOXSYLtvu77TTVV2bJDtb?=
 =?us-ascii?Q?T/nPY7OGqomdbBH1u0i+bS5v7YRttbsb8Tv982HAmBBJHvEUQTLk0VUrXTi7?=
 =?us-ascii?Q?PajQYhjwkQpehhkaz33n0vmkHExyU82TOuQuXWaJQAo8owlOJcCgyjktqMC4?=
 =?us-ascii?Q?uT0B1MnX3jpeYj/BDHTAqq5E88Pkgl6oG5DWhYWd/CeYZeEoS2zfzooNcz2G?=
 =?us-ascii?Q?fsdP/M+sCWLuS2EAOGyR3Sy0ACvapA9EM2dY9u6+eXaNnYz9W87RW06Oglph?=
 =?us-ascii?Q?wqMw5NMmhjRQHoCx11asOdZsCKa5Of/D2LLGkm/NteQEX8rvGX9zvL7H4/5j?=
 =?us-ascii?Q?2tIiaYEmGC3a8GuWfx66ko7mW+Or/j2N4AtRsS8SI4eNodpVYf79q/C6uC6N?=
 =?us-ascii?Q?HQYtb/NhF9gK2DQ6tifO/nVrjb+9547w9lq69uIu/GeYD/v2BDiAdZ6cPnkP?=
 =?us-ascii?Q?yyEbpQyS3WbgAXanGNabFeKbFraM/+1FwKs0fK4XigdymwiggTJpAdeAPDb+?=
 =?us-ascii?Q?LcYpOvGEM8fYsJ9eaVHYEwwoB6pdtENdd8Wm/TgzH2PHbe3njs8m+xc4xWiV?=
 =?us-ascii?Q?D+EQkRF2x1ifxMdoomhLQeYaDJW2sEWiinl+XWLEU8HfmmKlRc/8IuTjNpW5?=
 =?us-ascii?Q?uvwQCha2EeVDzhapsf7X3Hvg7S3d8AwvVLEuB034rSZCqKao+fuUau4qk7OH?=
 =?us-ascii?Q?5/jUeg24bSt4HhBcoOc1hI2QnjuPlhToLZIetgV0Q94mM3f3/SzdrLd0OCmP?=
 =?us-ascii?Q?PnHz5ZR05jfrDYcg+fcreraJM3rqhWv1gyi9iuVyXBnjyLRQNdZUYoHT8us+?=
 =?us-ascii?Q?0vvgavCY8thClRDip/LD92Uqs27KOaNs+9NTVobGmEugEkiTmIulPSk9AtzU?=
 =?us-ascii?Q?+cFptFn/PRzXpaLpovQgdQ/OPFtc1J5yIvsMdMmC1Hljpw/pUa9XsH07Bj2L?=
 =?us-ascii?Q?AN1uQWb6cLIVLiC5IT1sVsMgNBdw3LlufQJHTRiAnPxFcXjiUYozYS+i7ypg?=
 =?us-ascii?Q?Dvr/YxRg9flcHkU7/LGn+O3pSgF5mqoH2iIePiQI9fTe+oO9jH5eof9d7HTV?=
 =?us-ascii?Q?o7/yheW6kCwi1YBLVeQO8dHFnTUFEkutcUGRMcbKTYFnViA/N6IEy0m9XiBk?=
 =?us-ascii?Q?cueMb/PYVttKT9ZfbRgqXoYPEdhQEda0WJqaDD7B?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 737bee9b-6cd7-491f-577a-08da598ab908
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 04:49:17.0412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZCygS4Eaw7Z+8GffWtlNaoqT99I84mW1a0DChMeiNHDGGIrkThQPVgwlaXVH3dLKtEz2TTHRE2D8sg4Ii4obLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5480
X-OriginatorOrg: intel.com

We have the Xenomai community call today.

Topics may include but are not limited to upstream/downstream project=20
plans, status updates, and technical discussions. It's an open online=20
meeting that anyone can join and ask questions.

Time:
Wednesday, Jun 29, 2022, UTC 7:00 AM
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
