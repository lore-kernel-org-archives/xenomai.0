Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8796A2566
	for <xenomai@lists.linux.dev>; Fri, 29 Jul 2022 08:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659083736; x=1690619736;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=dJYUEKFC+pECRqThv6nVdSaPUSdOPeMpfBgbq9qMgto=;
  b=As+r0tJ4PneU57T5vn6kHlhg/1AE/Uyh02cD3xTDEunr5wkSAII8YwMg
   QBwC1ZcA2eNPclmvzeztzodtT/j8p3qjE0UdAd79Ho5s5LsvKTZEuQiFh
   qVAzQEzMwM/jdCqnZ0Ah75gIbBFsLuk+Q0zWWFRsw/7bUP1VL7e8JhfGq
   E0mfxGLeFeJ7ThPr1xY2gV7qrBe512gPW1VFEMmbHrVHEpAEPcgnzsnHp
   0NKY4ZXV30rCR/itmk3KIfL9QGQ6bS6ATJO4ZRaEHDoqXzjcSWH2aNo1a
   Z6rnZ0acidhDg5C1TtxBvsvtVH/8Wb1f2EMWu6QA1gdYESlNhnxGM57xD
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="288737248"
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="288737248"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 01:35:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="604902191"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga007.fm.intel.com with ESMTP; 29 Jul 2022 01:35:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 29 Jul 2022 01:35:35 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Fri, 29 Jul 2022 01:35:35 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Fri, 29 Jul 2022 01:35:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7F3pxSS6i76GkPxW9G2O2o5CCW83BnWBlDM2fcnT17jZSjNXdbhGzzHntMmh2D0A/rMRiHSYsJ1KvbQYezMYqfe57b5xQvA/a9PNmKlwF27rGnkrC2aSDNKD6qAPL2se25/5YeOAVN2UI/c00nOIUneIIy6xfAaUi3zwBWmsmAJM5pVk9MspziPFkVqGtD6krldTR1KRpPPwsBXXyT/i8xmM9NId6PjrN2s1PwOSKhqusQSamrgTtV1MYhfhGFRzdqSgPKQSiWxvI7eQlZxcMiEtcu7muSBwCzIifnpsQWS83qSa0bO3um+wImGsAeefGiRE7Ik+Tj8cuyX0OC5XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LS3jHdPcsy2Sqt5ShVAKp/L6+OZ4WmyPz8EOm7ehtdc=;
 b=ejgPLAk5b6N3ec4PDCPpQLaZo3/q2aUGP2Vt5NA1O63AMMVin/RSewmj27ewm3gVLgRHZyiiFiFUEUgpzFnS29zv7HiDYjuKE4YszSTSXmMLKiiIQj7NYWWVzm+Vug+dvWKWZ9VtoLNM8rdvOjG/DVc+Sh4w/RQcEPkjcu9s+kDkN7TabMeU2JeYp2cGPf0+qWY77d2EFsKyN+bH7ifdDH1okiSnZrWFx/rygXBaKetprcalyJI06kdGADkYFR2c6N4FDErgiNeOP6XOa/pO4AYBg8ztElQ7+dPUXrfToABndzQUM7JxqfTW+NcRO3cXiMPkcshXuKG+II+j0Qh2zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by PH0PR11MB4965.namprd11.prod.outlook.com (2603:10b6:510:34::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Fri, 29 Jul
 2022 08:35:33 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::f521:4c9b:aa1a:78c5]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::f521:4c9b:aa1a:78c5%4]) with mapi id 15.20.5482.012; Fri, 29 Jul 2022
 08:35:32 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: RE: would we merge tag v5.10.131 into v5.10.y-dovetail and also tag
 v5.10.131-dovetail for it?
Thread-Topic: would we merge tag v5.10.131 into v5.10.y-dovetail and also tag
 v5.10.131-dovetail for it?
Thread-Index: AdijFgQ8HUM7PWqmRiWyVKhFvpW9dQAD3pyg
Date: Fri, 29 Jul 2022 08:35:32 +0000
Message-ID: <MN2PR11MB4285E3BAF10B4C69374C5C4EF2999@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <MN2PR11MB428507EC01AE358D7369CDAEF2999@MN2PR11MB4285.namprd11.prod.outlook.com>
In-Reply-To: <MN2PR11MB428507EC01AE358D7369CDAEF2999@MN2PR11MB4285.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: b87bd8b9-049d-4f18-cfdd-08da713d4d34
x-ms-traffictypediagnostic: PH0PR11MB4965:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oX6d8bGTaEAINKpDoMaLFJp4ocPRmfGqQmZ8eAWMl0VnHuyS+GxGw4bWoJFdvBiF+Q3pVpOOgYGJN9a1+f7he3pfKGtrwouviGGZEPG25OIrgfY8p/gAWiG8bOBS22Eb8KiiWcc2Ki3A9b7+XH1bMqMTzN4BK3YeaqLpeFx7hAimrXAcjEDzijBqRWRm3Y9zgJ9R7Ha35SKfqdMXQMMedCRRoPvHwyf3siCS1eYmgDf12bG2+tKBm0b80ZCoot18P2nlPrrDO1cmRlElpXP9xXt2zd9wP0I74BsbjIe8PeMIOEYmPkNNd1qGZqUwmZZpMc5A4AyT8URilL7MK+ucc+/eGZUvcBCAekWxGuEX5biqXBWC1P7cy//UAfwQEGNto9w3FUEeUjaQOLJ1KfglVGhFMJhUWBDgaMnZIVb52pK9GhI18EoJt8TZ1brLrCCDZ0mJjyymJR4h2q53ykr7WkXkkA2SmiGKADC0zCvLkkVZ5rUet1xDVCWWuIZf8sqdvFTpzo3yjYMSfh/dYPQUV8H+tEkAq9QdYXjx5Pv3CwrWc2kgjoKbQmObMyA7gvqlxM38V68XEwB6WOGQDD61n5L5NSiU8RMHxuQdIxL9jYZeuK/xcObRQnvY6sEpdYyb4x6MbB88Mz5VOHq9E1D8XTy5VRpdrkv68D/smGrE8u3xpaQvueV3m0APjpQc+GiTkMetWfWLf2qkojUNvWbf4gnyvp8xu6DlgZPNqGlhiRLZm+yvjKlBvgpPhGf4gG0l0U7WjELLGqK06zIBU6SGw3Ms+EnZ1bCXE3XNcWeAB3ROT20nvrps1LpVKtKE8a8s
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(39860400002)(366004)(136003)(396003)(186003)(38100700002)(82960400001)(122000001)(66476007)(38070700005)(76116006)(83380400001)(8936002)(5660300002)(66946007)(52536014)(66556008)(8676002)(66446008)(64756008)(55016003)(4744005)(2906002)(71200400001)(478600001)(41300700001)(7696005)(6506007)(9686003)(2940100002)(110136005)(53546011)(316002)(26005)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VgpFdun6++VbIi58iPLZc7leCwYC1BVuKkOarDbMhAfTeI/ZPJFIB89wKABR?=
 =?us-ascii?Q?22wnxpc2d9NRqUJtpd9ikytpmG3NwIUzcV+ZK/CfOMDtc3qiFQtMTfQPSqrC?=
 =?us-ascii?Q?vRaBg3drYkHOWfEEXH8WQ2pHi6KuoKUXrRy7kn6LXWkiZ3yOg44hVnGwGReb?=
 =?us-ascii?Q?eL7Z40etItXTB7Ipp9LuP+AfAOZxwd2ZvGv+WpU2VgLkUbJBv+Pqy4MngMFd?=
 =?us-ascii?Q?f2AD9cfYZwDueYALsQ0YK0Fp8aLScdje62ZpSWGUE7ELX/tt/ShbkAJgPHBJ?=
 =?us-ascii?Q?0tNRtmrnt4lb1TQVq/xGWdTxT8q4kzW7S0zOpWt05E4LPg0AMhm7ooYOvVS6?=
 =?us-ascii?Q?CIq36WNJCtbjaWgtufA/ChWWiaW5puurB3tofnJWL0m/c242lEn6ANaJRjgt?=
 =?us-ascii?Q?tRI4M4OYkVG9VdlSsxWUfN9Ek3i3/nNL2X7G+uOKUnRFsrSrVgwMP7ZQNbF6?=
 =?us-ascii?Q?xD4MDq2c8xu1Eqf+D6euwURTQiOBR/orf3OBmBKXSyqmfQkBHkaPGbO8lT6G?=
 =?us-ascii?Q?2ynYE+afW/TA8aPtBLPhLBLXN6M9SSC47W0LF+KOcl+HalXr2Z60u7XVZR0c?=
 =?us-ascii?Q?Xiv3e+l+Nj5auR8UQvVMtjrjG/d9Eko/4L3xhCGNJWckSyARZ2sOLhRESL4k?=
 =?us-ascii?Q?p5biAWI/lmgOuuHoRRVGDEj881OPSc94K/9VsqHN/OqTboO3u8RXrOpWv8o4?=
 =?us-ascii?Q?BJnKmfjlDf/5yEr61cUPv2ceJegtoAWIirpqqgFhZIJ70TfwQCHbu0A9FZGu?=
 =?us-ascii?Q?E6rELVlunzOhfm0PumrVTVJlbCpYQx8fLHmSW60Tu9BMW6ZABs9RWI0Umitw?=
 =?us-ascii?Q?4PbtKwpc36sTLUIiTTQvGiJMZFxw2vZLUMIcSN2Tmzf5BLGvhQZnha91gqwv?=
 =?us-ascii?Q?fdCngeALi2+tukZRKkIFHzCqVTWhpVziaHP7zW5HH9dSseosvOXN7nC++vUY?=
 =?us-ascii?Q?WVCgCJJ9KBMMwq/OJsxyuMquc3aIB3LaZdkQ4Cs38CH1ROt8SZekoSbEhfbo?=
 =?us-ascii?Q?BuuOYdM6vm6gq06C6TGbfYNNkVFBKhNIr2KCBSs8dGH84f02KXT4+AVVYrms?=
 =?us-ascii?Q?rhLGdz4xHAQKqWeu205JXRDfN0kPNT1vNR2A5Pbh4Ky8vBksDLrFrbmaGJft?=
 =?us-ascii?Q?xx79jxv2LXbrgK+uJ7bq9wVDvo4OdNVKBFBDOjwhgB/kQPkgib/iIdAxsTkC?=
 =?us-ascii?Q?NGLPYuvbHn32wVISWzsklc8XNKpgdQD8FdogxgNenqoT4u7zm6TQwjfHgFqR?=
 =?us-ascii?Q?q4dxaljpoojY9T2VwWhQytc5dvBBOFNOG7MJrnhTWPEYqhjxpaKUBPbQxUP1?=
 =?us-ascii?Q?s3RCJcd6DOENAx4883OMSBfGCojEfo40VOQYfE14qJ+9jnLivO430BBM90Et?=
 =?us-ascii?Q?onvklp/YL0B/gyB/I2RhTTPjyQTiI3ywehaxxUswXkyaPVqiqtxo0arutQ0w?=
 =?us-ascii?Q?O0Bj5iqXlZux3ZSJUGdKCW+KITORlupgGNxXdvCPIJcDEaAAtanHWOntcz+t?=
 =?us-ascii?Q?ZZ16Pz0+Lhlq5U8YT1nw2K5Qlgj96JPTsOwm+N3x1WU5f7tCADZflOdnxKhH?=
 =?us-ascii?Q?cWhwSqXYWk//82fu5ZlDhfOrhK7O0YDGHle/uL1z?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b87bd8b9-049d-4f18-cfdd-08da713d4d34
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2022 08:35:32.8128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vkrCwxTCZ/7QjExBpIbZUDdMuyuClOQNhTmqfCHbhlxGBjDr9AtZNMgS/DkSbselo2zzwpR4L0HP7P9dTyEd9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4965
X-OriginatorOrg: intel.com

I just found there already had higher v5.10.132-dovetail1-rebase in v5.10.y=
-dovetail.=20

Regards

Hongzhan Chen
-----Original Message-----
From: Chen, Hongzhan <hongzhan.chen@intel.com>=20
Sent: Friday, July 29, 2022 2:55 PM
To: xenomai@lists.linux.dev
Subject: would we merge tag v5.10.131 into v5.10.y-dovetail and also tag v5=
.10.131-dovetail for it?

Hi Jan

Would we merge tag v5.10.131 into v5.10.y-dovetail and also tag v5.10.131-d=
ovetail for it?=20
I am asking this because we will base on v5.10.131 to do some internal rele=
ase.
If community can provide tag v5.10.131-dovetail for v5.10.y-dovetail,  it w=
ould be more convenient for  us
to merge code based on it in case there is confliction.


Regards

Hongzhan Chen


