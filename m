Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E32D7B
	for <xenomai@lists.linux.dev>; Wed, 24 Aug 2022 05:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661317905; x=1692853905;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=AreR+wQfGidnP5EaPt40sbLkXzSbBhRyXFx0n1F/Byc=;
  b=V3gmHJOAj9hHno5JB8w/Lr98gdoHsWbvkOR1LCJ7N6mhcv/GXbkO0AIy
   s3PtsmTbUiC6/lGHiAjcNQBOUrzT01fy5/WGJvkGVfyKBxoLgtqhak/3z
   VVItnMVnKXI/tP4AY76fYOZHHYj07NffoVmFTaDlHxGKt9DsDiRfhDxVE
   nRMfrZJWL+x2rWQi2z9zRKR2vKxtGLZwzgL5vJ3OTAM3pZ+LEyd73hRHF
   7NsUaxmyzjooYtjyjW0jzkg1NmBJ/jBPLKK6LLuucoJCS20ehLU6FoMh8
   FrrPg7W+fsdo8Pn8PacjtrFS1Ue8OrKhPSvyJ+qrimGZBG01uCYnF1qgH
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="357842455"
X-IronPort-AV: E=Sophos;i="5.93,259,1654585200"; 
   d="scan'208";a="357842455"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 22:11:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,259,1654585200"; 
   d="scan'208";a="560452233"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 23 Aug 2022 22:11:39 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 23 Aug 2022 22:11:39 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 23 Aug 2022 22:11:38 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 23 Aug 2022 22:11:38 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 23 Aug 2022 22:11:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAjsVuau+6dQkzXvqCtb3hOu9nohe+794rG/Ces/CQnFpVzq2fr/2c1otD0ylTKNTDuN+zrkAvSHQ5hM6k/k5p647QkzolpeyOR5ZQlgw7RmC4w9csy0k9wpbrMCQq6KYA14Vd3rJeCmH2QHyoTHk575xVvEp876NDolCxi7B9MBrfkzDTpKlHwQ/ekD3LCAPJyG/Fed2agzrjg+YQ6+5PcQGkColqZSSGi4/pqlYALs2KTppehJQwHvOfIWi0CqoEklRlVAhbGT3lPQ12PvZeNLPAeNzrfFx51QFHbVq3CUVVGExRe/sx/DZDE1y5HepbypiMyQP2IorlIYxzHr/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6GFvGdLKD6Kzx+33iK2HjpiAVEzeWBOcsVIGxKBEEY=;
 b=hQ4wwISqoF4+/9Z/vweqYm5X7W2QpUL+1rfjfl2cptDlcHYVmkvIhysYr3LWe5/7WE+bQU7Y/oCS+d472lYy2hFG6MCHovbAb6+/cKLoDhz9+gF7OR/seslLhiQN6NsEVseloGcmvjRIPyhi/9Z/U3AyOCK/tc4p08NQ8zELLNoALc7Sg6OSpqgGMtxRZf6MckQa5sZ4B7/OtgjrzmuLzOulLTy6Cd9RDodn20ismA6SX+FpsPAMZKkrGJxN7dKBFbNW5WtlcODqyXJQB6QzjKvuNg3QbhFKxgL69a2S4TiQNPNypUSE6LAJypd3VQ9x8/XfMa5zw87bqoHYArBCBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by BY5PR11MB3893.namprd11.prod.outlook.com (2603:10b6:a03:183::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Wed, 24 Aug
 2022 05:11:36 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::f521:4c9b:aa1a:78c5]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::f521:4c9b:aa1a:78c5%4]) with mapi id 15.20.5546.023; Wed, 24 Aug 2022
 05:11:35 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday,  Aug 24, 2022, UTC
 7:00 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday,  Aug 24, 2022,
 UTC 7:00 AM
Thread-Index: Adi3d/G8kaMoa3CWSV6toaN92WalQQ==
Date: Wed, 24 Aug 2022 05:11:35 +0000
Message-ID: <MN2PR11MB428583D3C8F4FC92EF425A7AF2739@MN2PR11MB4285.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 8d119a93-f26f-4bea-f669-08da858f1dc7
x-ms-traffictypediagnostic: BY5PR11MB3893:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aJIeFVBlHDJ6syML8UiFvAgKuFGXK+1mCzvxLP54s4KactZTzziiVyvjzQ7fwqofUUYR2bnpQYtbQDrGngHF9IVW1rDkQ2K5pd4o5U4krDDoYdFEjwabfMekvy4qLij/wM5AJBaoYX/CDhHFly80bhHf2jHA4WL2CjFytwkn3sXfT6Y4Mtgx2CN/iVlL4DP8cBt9m0GAykAV6QnesdmP4x8QKUg72ATD0B4YmwV2fwC1+NZILls+cj2nbqWCSeqWprjOG00zUAo3L0wnxgnAJOK1xH6qxdKt0wvvodjEQywCx3T3eMrzq09b1Ct9sv1s9314QAb3MHBk5SDMw4TunF8Y9Xq0Rge7NBTR+HSrsSxdJjj56ycIyZiunCFS9kvL4zo7FSDlg9AQ/zlZ8ujCAXpeEPH+P5xaJ7qa1+gbdkULMvnUOJ/mL7fe2V+6hfSNEdCJVXaTEde7hSOflpgNuSqE8CFjnUqD5pdFZqr5dUDBAdifi8vn8H5HhuSXylquiwcx3FfCai8IqO0cuu+0/u/d2uWvcix1qW8E9KQDl7RMxy8Ja39OwyXrtvrckNVlYo6nUgqYJWf1BmOYBa2778Hntwy6RQX5POEZzQUnLXU1P5dF594yB4e1UUceiHe2EudZeM0ZdO7ZAa2MifFlz5JrFEuh05jqR+ZXBVHrjYR4o8kZ9iO9pTWOe2mFdpAbZLwTVVPT1IdL2VLUDZ/mEJHusAxRY0OY8iidtB112zyTqGiShTPeVCiMF68uh93HoCy+xO96C+wwGmRYYLG74Qyyq69tszQMnNMKzSqDsf74u2VKmM9NJ6LtH82NOuqPArgIbd0sBawbmIZ8hb7FUg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(346002)(39860400002)(366004)(136003)(6916009)(316002)(40140700001)(55016003)(52536014)(64756008)(66556008)(8676002)(66446008)(66946007)(66476007)(2906002)(33656002)(8936002)(41300700001)(6506007)(966005)(7696005)(5660300002)(478600001)(9686003)(71200400001)(26005)(83380400001)(186003)(76116006)(38070700005)(122000001)(82960400001)(38100700002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EMM6buxaWfwA4w6iv56S3xKQs5jvcVcj3IaKCykaXigwqA2wJrawlCngpAeY?=
 =?us-ascii?Q?torCA4vmHImIEA5N0sM9nLfRdxtWGAMUhtYoqD9AZLYCSDqq9j0z0OPOEOjb?=
 =?us-ascii?Q?0CRAaW/6Z/T4Am1mc6l7WRkJ5e2rolVFjWoz3tL0waeRtJFIYeEe8Ufc7Pit?=
 =?us-ascii?Q?aHWl/UwmTxXQ6Ipewbraf1Ycl8N7RgL5FqH6tAT1x+yaeHjcLlSDsOeINIFg?=
 =?us-ascii?Q?9LY24JjgBxCg2HaBkc4xgBnDyvAnL8UJPNX69QYV9wiwD8O2FvAE/nF6c13F?=
 =?us-ascii?Q?Vz0VV8VpcM3ZXfI/4U5BqkBGRtGG0pm55rCv+Ap7CtAbIN9mT5azu+Hr7ATR?=
 =?us-ascii?Q?FK1ZI65mrG1yLEWDR5LzYNM4VzSnPLngC5v6Gxt4pH/dkpJkj8SmiDbOz/Kl?=
 =?us-ascii?Q?MrEdzBR49lY6SGHRdQRuPt/sISbkD2ZdXBGDWpS+Sa2DzNUga/rvOICXYX6s?=
 =?us-ascii?Q?qljU0VcTpFXV95oE4pp4um8k61qM6doYRDwpl5+IvzaTvx2xeZCyPS5znyCv?=
 =?us-ascii?Q?eygMKq2sQYul+8PnhBWTzDTpPmtgI0Cl2tt7ep6j50osZgi5CKYjHESxgmma?=
 =?us-ascii?Q?2YuZxXopizjEa3Jx68lSkuytRS+frmqFBmNbGC/p33rA0Gl0HdpCpNXg7gi/?=
 =?us-ascii?Q?ZknQrlDdIInDBPYx+if7BnQdGZ4bHtiDRUeR+7D71rrUvlmEJB7Um/jP+T9X?=
 =?us-ascii?Q?+2VlDl1ByFkTOEzxIDHhhLYLV0IOtR9BHa7rDIyF5F3Dij5ClZcogl7pRfR8?=
 =?us-ascii?Q?mqs+4W5ZIlPAaNwMP4JrpqGuWnJyOz6j8JL0tUVDTwwPL9HGTE+slOePldgY?=
 =?us-ascii?Q?CeAva97GeC7/80fJJV1+7No8qI5IhJl+Rv3sk1PgP/nkOqBlCdICpyzUmKea?=
 =?us-ascii?Q?875Ar4wRJQld7rIgc0XQ16genmjJnLFEU4ssFfLoHsXAwk4u850d/9HOiXZS?=
 =?us-ascii?Q?UC0y7a1zW5TQ75SGgDTyMeT3s6YeoxV20QNPVUwtzPOYmi+W9DJdKRFWFmfh?=
 =?us-ascii?Q?LHMIci4+lsOTd3+lq4D9V2ZiBm6r2ONzwP34gWmCZED5eady6MTCOSnSewU0?=
 =?us-ascii?Q?rjNHlmCl6TUGcBNIOHpk3732K97hgfhUfeAYeJYFPMeO90KosYFs1vVUtYzQ?=
 =?us-ascii?Q?Dq9GybdfjmyoCGpzj7SMp7WP75/BTcUFyQN3o5Ya+n6ypfQAVbm9ZF9yKi2N?=
 =?us-ascii?Q?KSNqrLuQoduQHKusDCook0oo4AHvbPv8xdX32SrKIstEfGEphYSV0Cv7rUd4?=
 =?us-ascii?Q?We79fLUTvkkfaJc7QWvApzsTc9x0vDUb2r02jS8A1HKSBa18lsFfTclJENq0?=
 =?us-ascii?Q?G2w2Yhh7TSHvIS5tzKBmHbSI9SQzrRmA90Fw0nOfTkUs6WqarwmYnG4K7Pky?=
 =?us-ascii?Q?1KLfr3UsQJAf9nRnLzZNH+1krus9rKSgW0ILsg4vAvgI3MUj8+bFuqeOgvuu?=
 =?us-ascii?Q?c8kTj5yVMsd/M936BOjDGZhE0YwGfegdrBUMmXkrKfnL1ukUwnvk5SQ1gF95?=
 =?us-ascii?Q?JmhD5zjmQYyXPAEvvRcp8ZhAlsCrNTP0dsPJoG0xKimm9jFhy7M87EfOA/SA?=
 =?us-ascii?Q?2Y3Ma0YNmFZzV6MDTC4ykQ1Oe/AeA7G4bka0zqpv?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d119a93-f26f-4bea-f669-08da858f1dc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2022 05:11:35.2183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jK9amNAvQdmtc7ucTyNUu69xO8RatS5ISikBTj6jAQVJWxjHsJRpSYW+es5Am1QEniDvPI3SjQFVIQGI9Jk//Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3893
X-OriginatorOrg: intel.com

We have the Xenomai community call today.

Topics may include but are not limited to upstream/downstream project=20
plans, status updates, and technical discussions. It's an open online=20
meeting that anyone can join and ask questions.

Time:
Wednesday, Aug 24, 2022, UTC 7:00 AM
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
