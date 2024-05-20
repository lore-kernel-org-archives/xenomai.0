Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B668A4596F
	for <xenomai@lists.linux.dev>; Mon, 20 May 2024 09:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716198561; cv=fail; b=uIwQ/lfE2YiuTcFNiZGEy9cV2zrW1rCwF28byv9ZeJsF7muOeSRHuUM9xOa0HfTqKueEszvHttmII5HyMV6fFLO9KZ6yftO9da4QSraVCnNML8bNKvSJP2w5f7zVnYkjVHJ4oVCfnCC5eZPKUm/o0jBY89wda2mmMVA1sLILpH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716198561; c=relaxed/simple;
	bh=Ggpo6va+Ews+pi95e5BnDifFAWsegx2e9od8n+jauuo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wv24yU5S4XCcJhEM54hF0kxht+aCGqAJulVU+3Fi2eIF5LmyCN4dOGTRZjXCPNBemF8GU6cWhFe6P0oDJrWuOtOB90LflAo+80qC7Ac1zz2nDd+99bfc556qXAu5u1cdC68KrPyW8EGhNlLsftB8bO1rKghJd6GR51OL2x/v1xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hOD+duqN; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hOD+duqN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716198559; x=1747734559;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ggpo6va+Ews+pi95e5BnDifFAWsegx2e9od8n+jauuo=;
  b=hOD+duqNDT7MhcZk2Txl51b1S8gSsS2wYLeHdb5Sqf1+fVG1tBCTDH26
   RVi86iJftWIXvs83qSCt6BW/oSKvovJ7EAseavCDhyK9m9hobMHbCskFc
   JuU0nOPDj6mZPPvGvzKs2gSGo5mURRk/o2J1GVGvVO6R9XPSCecF9c6wW
   yUI/uMyONJR0breERMQfR2COY1EA6vCvWCHGZGVq7F+DGLHX7d2f0wSvt
   NPBaIrD+gqk8cssew5uRnxeu44/aY7WsYGIucn/I1BW/9tzRmX31kNQRf
   4ym/rck1jnIfnCY9EX9K1dKa6EI9XssjAv2KN6SnWoDFz8ot8ySJTxfz5
   Q==;
X-CSE-ConnectionGUID: pDVwKhUsSRmlpWpvIE3KJQ==
X-CSE-MsgGUID: l84sWdCxQ9WPuYEyblTLjQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="12506668"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="12506668"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 02:49:18 -0700
X-CSE-ConnectionGUID: ik84Nh0DRFGIUwdmkGfH9A==
X-CSE-MsgGUID: dhXAJimRRSWll1pOw/3gHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="32463466"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 May 2024 02:49:18 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 20 May 2024 02:49:17 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 20 May 2024 02:49:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 20 May 2024 02:49:17 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 20 May 2024 02:49:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=csoNNyawIfFBcGagO6ef0NVnctSFVcCTLrrY1owgC6WXYgXbWNGbI2HM0ATMvFfmYF0QgNla0Sn3ocuDsG35A/+EJDj8In6YumITbGmhh4y0COti5CUN7t24YVTQyfjfPi5z4ZSJjing/FD5pThBRrRqcKJSFfJPFaL20xRvxic413jep5WZUR5K+sqERYQSsYHCFisTBQNM1XVIxp6Gv3H2iocQPsUXX+n8plHqUiTlFg3gTSyF0D6WrQ7UjOQ6Z805Ixpp2IMud/0OYZoDzbEaVNqR2Y88EEIOkoqihOaBJRb9eEA0J8/yoXjWTtWPs/faA+/MVI/sTrHgoovreQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+KeEeY4+lDDQTteISXRhw1HqtDgMK3Xro1q1qAhxSw=;
 b=jOUAs3AIoXX7rEDNld2cUb+TrXvhFZXGeKXvOusQlNO2xc6904ZkMiyds3RnhDV9umC18mHWyF7df4P87tnEziFJTR43dC2AhdUl4szbynqFmHEHNEtrtPGVRP5VEfQ6r0QFtO0WRWSWnYkU/hV1rH9h3Br+hxRZ9s2jb40gJ765uYekF+LQeoharA/TITSD/wTRmP0gxzVT965izV2nB+cfT8QaqXWN/Y/L7QLTUmSu6UUa7fFgW4cr+vN7Yu0RYRS00bEREJTZpTyqTn3217zHL+hEiwWAfGAGKbqCn2pSbBF4RKvXRwnxGSr4PnjKhBIXswflxycLTVP/GN+OMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5949.namprd11.prod.outlook.com (2603:10b6:510:144::6)
 by DM4PR11MB7206.namprd11.prod.outlook.com (2603:10b6:8:112::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 09:49:14 +0000
Received: from PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861]) by PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861%6]) with mapi id 15.20.7544.052; Mon, 20 May 2024
 09:49:14 +0000
From: "Nechita, Ionut" <ionut.nechita@intel.com>
To: Philippe Gerum <rpm@xenomai.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: WARN Kernel v6.9-evl-rebase - do_int80_emulation
Thread-Topic: WARN Kernel v6.9-evl-rebase - do_int80_emulation
Thread-Index: AdqoUB42H/OnAc6gQSyqVaNVHGTu7wAA2ngAAADkauAAAU+/AAAAI7fAAACbpVAAjtw04A==
Date: Mon, 20 May 2024 09:49:14 +0000
Message-ID: <PH0PR11MB59496A3A9FFCB39B7715813AF4E92@PH0PR11MB5949.namprd11.prod.outlook.com>
References: <PH0PR11MB59492DDE7F2301CECFD2D8A9F4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
 <877cfsskke.fsf@xenomai.org>
 <PH0PR11MB5949EC28B447C7534BF8292DF4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
 <87y188r32a.fsf@xenomai.org>
 <PH0PR11MB5949CA43AC47E322BE97B5AAF4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
 <PH0PR11MB5949D3CFA8AD77346C36097FF4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5949D3CFA8AD77346C36097FF4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5949:EE_|DM4PR11MB7206:EE_
x-ms-office365-filtering-correlation-id: 6b8fc781-ba34-445c-3e41-08dc78b21bab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?Wi5trXmbyejwCsuo5tgyJBXuT64QU62yZC7kw2PXVVPu5qumLxopD0Gqn0/9?=
 =?us-ascii?Q?wLjgsdFVUcVcqEHwDvcmvi5oWKuf7HDqyX1d0YTi2l8wWMXI3tCN5TDC7gNs?=
 =?us-ascii?Q?qycXPvJEsZtx42X/H+bh6T4tptJLutGS3mR77kdTqzpuyG/XLn0gsTFapA+a?=
 =?us-ascii?Q?XT2coVpP8pBvC/aMybXQpNGCT0qcg37aySyipMflb5wwmb1lt5oO+FghzHqv?=
 =?us-ascii?Q?C8ntRmgZUVtoetkKvx+9ZZh+0yZLeerU2SBYfrAyC4pcIvakZKxCJDIY0pk3?=
 =?us-ascii?Q?VYaCBQJHj0HCLxNQKhzrS8NGZSmbzE+g+YKKdEch0b8qGdxBbvqjGpIJStxe?=
 =?us-ascii?Q?GOghUILri9ueSNTnddeqzoJbxly26RwlWbK7bC/y9Opp7lEREinMBsuTrkkK?=
 =?us-ascii?Q?oxWCRD8sYviwAC2LtFevfZiAjfmE6edf330VAmQGMpPuRKXAr+eUHoek/BNU?=
 =?us-ascii?Q?kIeWgDb6hdnkmtq04m+ZIGspuxCmvZsnBpmdBKveF1PXwdYgSmk6vySF4+Li?=
 =?us-ascii?Q?57YHdHr2iKMk4B3K/Ai7B6qIeyhVIm/IpAq027zwDXu3DUw1MFX+xDXvM3Ku?=
 =?us-ascii?Q?2I6OqIy43itImYxBQFFkjTnF43J4lhomgqLTc+dncYsRRuABgZqkcM+eLlMJ?=
 =?us-ascii?Q?Ho0YYerxx9MZWBjWXdqcfN+xGKLLRLvIUTNvyvqpg/Eo8jxFgTGebp783KFe?=
 =?us-ascii?Q?D7Q2i2ifWyuw8Ww7BlHDRqQ6uVEV2YQ/kJntPmwwW/a9WN+GSwmVuOMD5SrK?=
 =?us-ascii?Q?OseRz9R1+tewCgGsekw0d9B4hG2xrXA1JPZ/10QpUdHcKHPWafn91WxKdGP6?=
 =?us-ascii?Q?Iy5PRo3MigkgpGjiEdPxB1KisSW2lNTsprp4lC3iKrRsi5dPMrcIMe+5uRoJ?=
 =?us-ascii?Q?l7zvCdfiPp2Hanp5GrjAScPVuamOWmWXMBDpcUcKV3VJGUfW5eiwQqIpVvCf?=
 =?us-ascii?Q?dEc2b0iKXqjn/ks+4iM2PJDZNy0UX40nqlPQ6UFPWvYGaYKlbdL5xmSESQQ6?=
 =?us-ascii?Q?1LiHU0SqRm3sE2pTToNTxCtVs9IRTeh3s3qANtOPwnUMyZ0TLDkUw3yj1vL4?=
 =?us-ascii?Q?xhAy00LhWM1+8jr3kjPGLQ5NMjJtTf1damfJrJ5WE6JnPtXeW25TGuDfPqhK?=
 =?us-ascii?Q?M5SbxC5WDl1zo60ujWvpbVbLfPIAgG6eJYiy7WkXPGQRVHILDttGeE3xdL5X?=
 =?us-ascii?Q?63Bpz5tt8D4lGZJdVwmc12DZF9vH9jwzXv7Yr2wLbRsQE5L1JVR2wdCFGQzV?=
 =?us-ascii?Q?Z5Eg0q0v7ftr2hLWXR/EwEOg132ZUQgS+Za/Cn681vF6FMEcjaqvstBigIpF?=
 =?us-ascii?Q?6h+EaxShzoaGp0Hs9Z1tYIbbCmmKxGqQhbcQREHL1dRFVg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5949.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Tz1HoB5PD2e1HSF62gqLNcia6j+alI6D0kGDZb9v0OHWd0VNSIJmXzlBQqgD?=
 =?us-ascii?Q?dIFBzzh9kbWAjBRC7eGwK+kIBKitApj7WeIuxH7ZcT4rbCRYmIBz5WPa+Eiu?=
 =?us-ascii?Q?IqXmBEa8C2PkisAiBaDcQXg5f+FFBK8SI/bv0sWFX36LGc26ypjeAqE6u8Nh?=
 =?us-ascii?Q?2WvaHxFm2C8yeBRXDYCfQvE6LlZ9HOq6LQjZQzTgUZXqtR+Hbasib+aRERQS?=
 =?us-ascii?Q?Cuc269HAweedTEQ4NaB+/po68iwkkWxas5QPfXnPw4610QOlu89CPW01RFHR?=
 =?us-ascii?Q?yaWkfiafXwp4DSrl5HDySdXWLu0bZ+Nqk+Z38Rd/H9tbKbbDjazTdAtEW64B?=
 =?us-ascii?Q?CaJY3ukqFQFR+oD21k+zDpkT0edw1iariVnqYLYmJdWemJuuTu9XWwvupkNr?=
 =?us-ascii?Q?GrKZg70o/1SCbi7mY7R2TUEygaQbmD8ekbutTcbOsiltZV+2NxuTOHnchsYw?=
 =?us-ascii?Q?a12/TcZc+495d0zp2blhG6ZdU5y1HWeturlj/kV/N18CbdYGkVmVtOogin6x?=
 =?us-ascii?Q?+lmQ3AmIYA4zfWv90OGwYa6budLhi6Q//1m4RisotmzzhjYKoyXq5r73Owd9?=
 =?us-ascii?Q?a+kS+FT/kQd1qtwZbqCphf7YUHgdHZWoe3LxiEm1r3cyh9Uiajx7gBe6tCAj?=
 =?us-ascii?Q?mEou50DiNIm5vXXtSP70WhB7hPYvSfM7js8jgG0udkUTbgOhgTeV6Av92XP0?=
 =?us-ascii?Q?3+WCFbO/s45fXC1STjawzAi8YYsWJSuoHC6PjBc2Z3l+zVCbcKPJzO8+XpzQ?=
 =?us-ascii?Q?k1m3xlbgMKt8GHRhrEnbyWl70FpULeEQTseAIkeEOdsY9hsCNFAwHS96LY+2?=
 =?us-ascii?Q?cx7zHoefKNgxCzBoRz32uaFWcfPD46iiVOeaekqsL8W0FwWsDbe/Tl/QEPNV?=
 =?us-ascii?Q?pr1tZCMCp7Ir/Y7W7GU4FHdbNKHzkQcyBeSZWIFR+P4HT/HuuNjUKOHr3Ztl?=
 =?us-ascii?Q?XqIe40t7K2gJg9ygnNesI3RRSWdhgSsLE73TanfRMFu/F0NsauHZAUxu1kGb?=
 =?us-ascii?Q?YYhIcf9siDRpplGNt6iSFH912i5/7r10aoee7+UhCfYNUA4sTLwaRpBmIrGk?=
 =?us-ascii?Q?iBSb5jj4f1Wz5+A0Eps3UAilhZAu4kV/ZwBlGFFmKdmbQDoHUlOjylKWyzAg?=
 =?us-ascii?Q?72H0Ogt7O7k5nM2RMSQ1Z1ERSeUjV3sUWke0zu5fg+PynXn687/8kWiiuTkR?=
 =?us-ascii?Q?pg3R6TjZXA8uvMTOkcXMTLRC+y7TCFGiLLj8Ac+iNfLWcAf6zZfp+xfgbSHt?=
 =?us-ascii?Q?+7KJptAaK8u3OkSpyjhvOmE8jVveJFbsIycY8EtsewKOzpdFbVVUXd9sbNI/?=
 =?us-ascii?Q?7svsa9mUIYNpp8kcPjyAg7Q01n5VIv+VzHOZGemBNOGG5TehMCgGj33dNdcf?=
 =?us-ascii?Q?O0LMHnN0QA3Yp0OeyPOVhOf3dT95EpV8ZKU23uzW17kIxyAjIV9unyHnLwh/?=
 =?us-ascii?Q?2vHFdHhzTrsh/9SJWtw5vDm0rc0gKXpp2kzxQizF8lYEWhwWTCchIP4ycFma?=
 =?us-ascii?Q?3Nt0p4kQ9whAy38yfuNfnk5hqZ5k0nE7vxNnCGtu6bLvqZgLxYfr1KQGl14X?=
 =?us-ascii?Q?ocXdCcBhjzE1ZBL2lpXm0sPD0xlMBWdAuQO8JT7Z?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5949.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b8fc781-ba34-445c-3e41-08dc78b21bab
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2024 09:49:14.2966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uBAwonmIGxjHu2P4H+vxie58z2BHljnKktkUF2HmL1Dc3Q6t/pA/Rh5RfeZm5OMInGfqEKoqqfK7+pBP6zXy2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7206
X-OriginatorOrg: intel.com

Hi Philippe,

You are reproduce this issue without CONFIG_EVL and CONFIG_DOVETAIL enabled=
 in config kernel?

CONFIG_EVL=3Dn
CONFIG_DOVETAIL=3Dn

BR,
Ionut.

-----Original Message-----
From: Nechita, Ionut=20
Sent: Friday, May 17, 2024 4:39 PM
To: 'Philippe Gerum' <rpm@xenomai.org>
Cc: 'xenomai@lists.linux.dev' <xenomai@lists.linux.dev>
Subject: RE: WARN Kernel v6.9-evl-rebase - do_int80_emulation

Snip log for kernel build:


...
  CC [M]  drivers/crypto/intel/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.o
  LD [M]  drivers/staging/most/i2c/most_i2c.o
In file included from ./include/linux/preempt.h:11,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/slab.h:16,
                 from ./include/linux/resource_ext.h:11,
                 from ./include/linux/acpi.h:13,
                 from drivers/pinctrl/intel/pinctrl-cherryview.c:13:
drivers/pinctrl/intel/pinctrl-cherryview.c: In function 'chv_pin_dbg_show':
./include/linux/cleanup.h:119:9: error: unknown type name 'class_hard_spinl=
ock_irqsave_t'; did you mean 'class_raw_spinlock_irqsave_t'?
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |         ^~~~~~
./include/linux/cleanup.h:169:14: note: in expansion of macro 'CLASS'
  169 |         for (CLASS(_name, scope)(args),                            =
     \
      |              ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:632:9: note: in expansion of mac=
ro 'scoped_guard'
  632 |         scoped_guard(hard_spinlock_irqsave, &chv_lock) {
      |         ^~~~~~~~~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:632:9: error: cleanup argument n=
ot a function
  CC      drivers/mmc/core/host.o
  CC [M]  drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.o
In file included from ./include/linux/preempt.h:11,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/slab.h:16,
                 from ./include/linux/resource_ext.h:11,
                 from ./include/linux/acpi.h:13,
                 from drivers/pinctrl/intel/pinctrl-cherryview.c:13:
./include/linux/cleanup.h:120:17: error: implicit declaration of function '=
class_hard_spinlock_irqsave_constructor'; did you mean 'class_raw_spinlock_=
irqsave_constructor'? [-Werror=3Dimplicit-function-declaration]
  120 |                 class_##_name##_constructor
      |                 ^~~~~~
./include/linux/cleanup.h:169:14: note: in expansion of macro 'CLASS'
  169 |         for (CLASS(_name, scope)(args),                            =
     \
      |              ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:632:9: note: in expansion of mac=
ro 'scoped_guard'
  632 |         scoped_guard(hard_spinlock_irqsave, &chv_lock) {
      |         ^~~~~~~~~~~~
./include/linux/cleanup.h:169:9: error: declaration of non-variable 'class_=
hard_spinlock_irqsave_constructor' in 'for' loop initial declaration
  169 |         for (CLASS(_name, scope)(args),                            =
     \
      |         ^~~
drivers/pinctrl/intel/pinctrl-cherryview.c:632:9: note: in expansion of mac=
ro 'scoped_guard'
  632 |         scoped_guard(hard_spinlock_irqsave, &chv_lock) {
      |         ^~~~~~~~~~~~
  LD [M]  drivers/staging/most/net/most_net.o
  CC [M]  drivers/hwtracing/intel_th/acpi.o
  CC [M]  drivers/platform/surface/surface_aggregator_cdev.o
./include/linux/cleanup.h:166:28: error: implicit declaration of function '=
class_hard_spinlock_irqsave_lock_ptr'; did you mean 'class_raw_spinlock_irq=
save_lock_ptr'? [-Werror=3Dimplicit-function-declaration]
  166 | #define __guard_ptr(_name) class_##_name##_lock_ptr
      |                            ^~~~~~
./include/linux/cleanup.h:170:28: note: in expansion of macro '__guard_ptr'
  170 |              *done =3D NULL; __guard_ptr(_name)(&scope) && !done; d=
one =3D (void *)1)
      |                            ^~~~~~~~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:632:9: note: in expansion of mac=
ro 'scoped_guard'
  632 |         scoped_guard(hard_spinlock_irqsave, &chv_lock) {
      |         ^~~~~~~~~~~~
  CC      drivers/devfreq/governor_performance.o
  CC [M]  drivers/pinctrl/pinctrl-mcp23s08.o
drivers/pinctrl/intel/pinctrl-cherryview.c: In function 'chv_pinmux_set_mux=
':
./include/linux/cleanup.h:119:9: error: unknown type name 'class_hard_spinl=
ock_irqsave_t'; did you mean 'class_raw_spinlock_irqsave_t'?
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |         ^~~~~~
./include/linux/cleanup.h:164:9: note: in expansion of macro 'CLASS'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:671:9: note: in expansion of mac=
ro 'guard'
  671 |         guard(hard_spinlock_irqsave)(&chv_lock);
      |         ^~~~~
  CC [M]  drivers/ufs/core/ufs-debugfs.o
drivers/pinctrl/intel/pinctrl-cherryview.c:671:9: error: cleanup argument n=
ot a function
In file included from ./include/linux/preempt.h:11,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/slab.h:16,
                 from ./include/linux/resource_ext.h:11,
                 from ./include/linux/acpi.h:13,
                 from drivers/pinctrl/intel/pinctrl-cherryview.c:13:
./include/linux/compiler.h:189:45: warning: unused variable '__UNIQUE_ID_gu=
ard484' [-Wunused-variable]
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                             ^~~~~~~~~~~~
./include/linux/cleanup.h:119:27: note: in definition of macro 'CLASS'
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |                           ^~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:29: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                             ^~~~~~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:37: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                     ^~~~~~~
./include/linux/cleanup.h:164:22: note: in expansion of macro '__UNIQUE_ID'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |                      ^~~~~~~~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:671:9: note: in expansion of mac=
ro 'guard'
  671 |         guard(hard_spinlock_irqsave)(&chv_lock);
      |         ^~~~~
  CC      drivers/devfreq/governor_powersave.o
  CC      drivers/extcon/devres.o
  CC [M]  drivers/staging/media/ipu3/ipu3-css.o
  CC [M]  drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.o
  CC [M]  drivers/pinctrl/intel/pinctrl-alderlake.o
drivers/pinctrl/intel/pinctrl-cherryview.c: In function 'chv_gpio_request_e=
nable':
./include/linux/cleanup.h:119:9: error: unknown type name 'class_hard_spinl=
ock_irqsave_t'; did you mean 'class_raw_spinlock_irqsave_t'?
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |         ^~~~~~
./include/linux/cleanup.h:164:9: note: in expansion of macro 'CLASS'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:747:9: note: in expansion of mac=
ro 'guard'
  747 |         guard(hard_spinlock_irqsave)(&chv_lock);
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:747:9: error: cleanup argument n=
ot a function
In file included from ./include/linux/preempt.h:11,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/slab.h:16,
                 from ./include/linux/resource_ext.h:11,
                 from ./include/linux/acpi.h:13,
                 from drivers/pinctrl/intel/pinctrl-cherryview.c:13:
./include/linux/compiler.h:189:45: warning: unused variable '__UNIQUE_ID_gu=
ard487' [-Wunused-variable]
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                             ^~~~~~~~~~~~
./include/linux/cleanup.h:119:27: note: in definition of macro 'CLASS'
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |                           ^~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:29: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                             ^~~~~~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:37: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                     ^~~~~~~
./include/linux/cleanup.h:164:22: note: in expansion of macro '__UNIQUE_ID'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |                      ^~~~~~~~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:747:9: note: in expansion of mac=
ro 'guard'
  747 |         guard(hard_spinlock_irqsave)(&chv_lock);
      |         ^~~~~
  CC [M]  drivers/staging/vt6655/baseband.o
  CC [M]  drivers/staging/sm750fb/ddk750_mode.o
  CC [M]  drivers/pinctrl/intel/pinctrl-broxton.o
  CC [M]  drivers/staging/fbtft/fbtft-core.o
  CC [M]  drivers/staging/sm750fb/ddk750_display.o
  CC [M]  drivers/platform/chrome/chromeos_laptop.o
drivers/pinctrl/intel/pinctrl-cherryview.c: In function 'chv_gpio_disable_f=
ree':
./include/linux/cleanup.h:119:9: error: unknown type name 'class_hard_spinl=
ock_irqsave_t'; did you mean 'class_raw_spinlock_irqsave_t'?
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |         ^~~~~~
./include/linux/cleanup.h:164:9: note: in expansion of macro 'CLASS'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:796:9: note: in expansion of mac=
ro 'guard'
  796 |         guard(hard_spinlock_irqsave)(&chv_lock);
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:796:9: error: cleanup argument n=
ot a function
In file included from ./include/linux/preempt.h:11,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/slab.h:16,
                 from ./include/linux/resource_ext.h:11,
                 from ./include/linux/acpi.h:13,
                 from drivers/pinctrl/intel/pinctrl-cherryview.c:13:
./include/linux/compiler.h:189:45: warning: unused variable '__UNIQUE_ID_gu=
ard488' [-Wunused-variable]
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                             ^~~~~~~~~~~~
./include/linux/cleanup.h:119:27: note: in definition of macro 'CLASS'
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |                           ^~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:29: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                             ^~~~~~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:37: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                     ^~~~~~~
./include/linux/cleanup.h:164:22: note: in expansion of macro '__UNIQUE_ID'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |                      ^~~~~~~~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:796:9: note: in expansion of mac=
ro 'guard'
  796 |         guard(hard_spinlock_irqsave)(&chv_lock);
      |         ^~~~~
  CC [M]  drivers/ras/amd/atl/denormalize.o
  LD [M]  drivers/virt/vboxguest/vboxguest.o
  CC [M]  drivers/mmc/host/sdhci-pci-o2micro.o
drivers/pinctrl/intel/pinctrl-cherryview.c: In function 'chv_gpio_set_direc=
tion':
./include/linux/cleanup.h:119:9: error: unknown type name 'class_hard_spinl=
ock_irqsave_t'; did you mean 'class_raw_spinlock_irqsave_t'?
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |         ^~~~~~
./include/linux/cleanup.h:164:9: note: in expansion of macro 'CLASS'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:811:9: note: in expansion of mac=
ro 'guard'
  811 |         guard(hard_spinlock_irqsave)(&chv_lock);
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:811:9: error: cleanup argument n=
ot a function
In file included from ./include/linux/preempt.h:11,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/slab.h:16,
                 from ./include/linux/resource_ext.h:11,
                 from ./include/linux/acpi.h:13,
                 from drivers/pinctrl/intel/pinctrl-cherryview.c:13:
./include/linux/compiler.h:189:45: warning: unused variable '__UNIQUE_ID_gu=
ard489' [-Wunused-variable]
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                             ^~~~~~~~~~~~
./include/linux/cleanup.h:119:27: note: in definition of macro 'CLASS'
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |                           ^~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:29: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                             ^~~~~~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:37: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                     ^~~~~~~
./include/linux/cleanup.h:164:22: note: in expansion of macro '__UNIQUE_ID'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |                      ^~~~~~~~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:811:9: note: in expansion of mac=
ro 'guard'
  811 |         guard(hard_spinlock_irqsave)(&chv_lock);
      |         ^~~~~
  CC [M]  drivers/staging/sm750fb/ddk750_swi2c.o
  AR      drivers/clocksource/built-in.a
drivers/pinctrl/intel/pinctrl-cherryview.c: In function 'chv_config_get':
./include/linux/cleanup.h:119:9: error: unknown type name 'class_hard_spinl=
ock_irqsave_t'; did you mean 'class_raw_spinlock_irqsave_t'?
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |         ^~~~~~
./include/linux/cleanup.h:169:14: note: in expansion of macro 'CLASS'
  169 |         for (CLASS(_name, scope)(args),                            =
     \
      |              ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:842:9: note: in expansion of mac=
ro 'scoped_guard'
  842 |         scoped_guard(hard_spinlock_irqsave, &chv_lock) {
      |         ^~~~~~~~~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:842:9: error: cleanup argument n=
ot a function
In file included from ./include/linux/preempt.h:11,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/slab.h:16,
                 from ./include/linux/resource_ext.h:11,
                 from ./include/linux/acpi.h:13,
                 from drivers/pinctrl/intel/pinctrl-cherryview.c:13:
./include/linux/cleanup.h:169:9: error: declaration of non-variable 'class_=
hard_spinlock_irqsave_constructor' in 'for' loop initial declaration
  169 |         for (CLASS(_name, scope)(args),                            =
     \
      |         ^~~
drivers/pinctrl/intel/pinctrl-cherryview.c:842:9: note: in expansion of mac=
ro 'scoped_guard'
  842 |         scoped_guard(hard_spinlock_irqsave, &chv_lock) {
      |         ^~~~~~~~~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c: In function 'chv_config_set_pul=
l':
./include/linux/cleanup.h:119:9: error: unknown type name 'class_hard_spinl=
ock_irqsave_t'; did you mean 'class_raw_spinlock_irqsave_t'?
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |         ^~~~~~
./include/linux/cleanup.h:164:9: note: in expansion of macro 'CLASS'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:922:9: note: in expansion of mac=
ro 'guard'
  922 |         guard(hard_spinlock_irqsave)(&chv_lock);
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:922:9: error: cleanup argument n=
ot a function
In file included from ./include/linux/preempt.h:11,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/slab.h:16,
                 from ./include/linux/resource_ext.h:11,
                 from ./include/linux/acpi.h:13,
                 from drivers/pinctrl/intel/pinctrl-cherryview.c:13:
./include/linux/compiler.h:189:45: warning: unused variable '__UNIQUE_ID_gu=
ard490' [-Wunused-variable]
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                             ^~~~~~~~~~~~
./include/linux/cleanup.h:119:27: note: in definition of macro 'CLASS'
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |                           ^~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:29: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                             ^~~~~~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:37: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                     ^~~~~~~
./include/linux/cleanup.h:164:22: note: in expansion of macro '__UNIQUE_ID'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |                      ^~~~~~~~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:922:9: note: in expansion of mac=
ro 'guard'
  922 |         guard(hard_spinlock_irqsave)(&chv_lock);
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c: In function 'chv_config_set_ode=
n':
./include/linux/cleanup.h:119:9: error: unknown type name 'class_hard_spinl=
ock_irqsave_t'; did you mean 'class_raw_spinlock_irqsave_t'?
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |         ^~~~~~
./include/linux/cleanup.h:164:9: note: in expansion of macro 'CLASS'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:983:9: note: in expansion of mac=
ro 'guard'
  983 |         guard(hard_spinlock_irqsave)(&chv_lock);
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:983:9: error: cleanup argument n=
ot a function
In file included from ./include/linux/preempt.h:11,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/slab.h:16,
                 from ./include/linux/resource_ext.h:11,
                 from ./include/linux/acpi.h:13,
                 from drivers/pinctrl/intel/pinctrl-cherryview.c:13:
./include/linux/compiler.h:189:45: warning: unused variable '__UNIQUE_ID_gu=
ard491' [-Wunused-variable]
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                             ^~~~~~~~~~~~
./include/linux/cleanup.h:119:27: note: in definition of macro 'CLASS'
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |                           ^~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:29: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                             ^~~~~~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:37: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                     ^~~~~~~
./include/linux/cleanup.h:164:22: note: in expansion of macro '__UNIQUE_ID'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |                      ^~~~~~~~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:983:9: note: in expansion of mac=
ro 'guard'
  983 |         guard(hard_spinlock_irqsave)(&chv_lock);
      |         ^~~~~
  CC      drivers/interconnect/debugfs-client.o
  CC [M]  drivers/pinctrl/intel/pinctrl-cannonlake.o
  CC [M]  drivers/staging/vt6656/usbpipe.o
  CC [M]  drivers/staging/vt6655/rxtx.o
drivers/pinctrl/intel/pinctrl-cherryview.c: In function 'chv_gpio_get':
./include/linux/cleanup.h:119:9: error: unknown type name 'class_hard_spinl=
ock_irqsave_t'; did you mean 'class_raw_spinlock_irqsave_t'?
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |         ^~~~~~
./include/linux/cleanup.h:169:14: note: in expansion of macro 'CLASS'
  169 |         for (CLASS(_name, scope)(args),                            =
     \
      |              ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1104:9: note: in expansion of ma=
cro 'scoped_guard'
 1104 |         scoped_guard(hard_spinlock_irqsave, &chv_lock)
      |         ^~~~~~~~~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1104:9: error: cleanup argument =
not a function
In file included from ./include/linux/preempt.h:11,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/slab.h:16,
                 from ./include/linux/resource_ext.h:11,
                 from ./include/linux/acpi.h:13,
                 from drivers/pinctrl/intel/pinctrl-cherryview.c:13:
./include/linux/cleanup.h:169:9: error: declaration of non-variable 'class_=
hard_spinlock_irqsave_constructor' in 'for' loop initial declaration
  169 |         for (CLASS(_name, scope)(args),                            =
     \
      |         ^~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1104:9: note: in expansion of ma=
cro 'scoped_guard'
 1104 |         scoped_guard(hard_spinlock_irqsave, &chv_lock)
      |         ^~~~~~~~~~~~
  CC [M]  drivers/staging/vt6656/channel.o
  CC      drivers/mmc/core/mmc.o
drivers/pinctrl/intel/pinctrl-cherryview.c: In function 'chv_gpio_set':
./include/linux/cleanup.h:119:9: error: unknown type name 'class_hard_spinl=
ock_irqsave_t'; did you mean 'class_raw_spinlock_irqsave_t'?
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |         ^~~~~~
./include/linux/cleanup.h:164:9: note: in expansion of macro 'CLASS'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1120:9: note: in expansion of ma=
cro 'guard'
 1120 |         guard(hard_spinlock_irqsave)(&chv_lock);
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1120:9: error: cleanup argument =
not a function
In file included from ./include/linux/preempt.h:11,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/slab.h:16,
                 from ./include/linux/resource_ext.h:11,
                 from ./include/linux/acpi.h:13,
                 from drivers/pinctrl/intel/pinctrl-cherryview.c:13:
./include/linux/compiler.h:189:45: warning: unused variable '__UNIQUE_ID_gu=
ard494' [-Wunused-variable]
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                             ^~~~~~~~~~~~
./include/linux/cleanup.h:119:27: note: in definition of macro 'CLASS'
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |                           ^~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:29: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                             ^~~~~~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:37: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                     ^~~~~~~
./include/linux/cleanup.h:164:22: note: in expansion of macro '__UNIQUE_ID'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |                      ^~~~~~~~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1120:9: note: in expansion of ma=
cro 'guard'
 1120 |         guard(hard_spinlock_irqsave)(&chv_lock);
      |         ^~~~~
  CC [M]  drivers/pinctrl/intel/pinctrl-cedarfork.o
  CC [M]  drivers/extcon/extcon-adc-jack.o
  CC [M]  drivers/pinctrl/intel/pinctrl-denverton.o
drivers/pinctrl/intel/pinctrl-cherryview.c: In function 'chv_gpio_get_direc=
tion':
./include/linux/cleanup.h:119:9: error: unknown type name 'class_hard_spinl=
ock_irqsave_t'; did you mean 'class_raw_spinlock_irqsave_t'?
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |         ^~~~~~
./include/linux/cleanup.h:169:14: note: in expansion of macro 'CLASS'
  169 |         for (CLASS(_name, scope)(args),                            =
     \
      |              ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1137:9: note: in expansion of ma=
cro 'scoped_guard'
 1137 |         scoped_guard(hard_spinlock_irqsave, &chv_lock)
      |         ^~~~~~~~~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1137:9: error: cleanup argument =
not a function
In file included from ./include/linux/preempt.h:11,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/slab.h:16,
                 from ./include/linux/resource_ext.h:11,
                 from ./include/linux/acpi.h:13,
                 from drivers/pinctrl/intel/pinctrl-cherryview.c:13:
./include/linux/cleanup.h:169:9: error: declaration of non-variable 'class_=
hard_spinlock_irqsave_constructor' in 'for' loop initial declaration
  169 |         for (CLASS(_name, scope)(args),                            =
     \
      |         ^~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1137:9: note: in expansion of ma=
cro 'scoped_guard'
 1137 |         scoped_guard(hard_spinlock_irqsave, &chv_lock)
      |         ^~~~~~~~~~~~
  CC [M]  drivers/crypto/atmel-i2c.o
  CC      drivers/mmc/core/mmc_ops.o
  CC [M]  drivers/ufs/core/ufs_bsg.o
  CC [M]  drivers/staging/sm750fb/ddk750_dvi.o
  CC      drivers/of/platform.o
  CC [M]  drivers/pinctrl/intel/pinctrl-elkhartlake.o
  CC      drivers/mmc/core/sd.o
drivers/pinctrl/intel/pinctrl-cherryview.c: In function 'chv_gpio_irq_ack':
./include/linux/cleanup.h:119:9: error: unknown type name 'class_hard_spinl=
ock_t'; did you mean 'class_raw_spinlock_t'?
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |         ^~~~~~
./include/linux/cleanup.h:164:9: note: in expansion of macro 'CLASS'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1179:9: note: in expansion of ma=
cro 'guard'
 1179 |         guard(hard_spinlock)(&chv_lock);
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1179:9: error: cleanup argument =
not a function
  CC [M]  drivers/ufs/core/ufshcd-crypto.o
  CC [M]  drivers/crypto/ccp/ccp-dev.o
  CC [M]  drivers/platform/surface/surface_aggregator_hub.o
  CC [M]  drivers/crypto/ccp/ccp-ops.o
  CC      drivers/dpll/dpll_core.o
  CC      drivers/devfreq/governor_userspace.o
  CC      drivers/dpll/dpll_netlink.o
  CC [M]  drivers/pinctrl/intel/pinctrl-emmitsburg.o
  CC      drivers/mmc/core/sd_ops.o
  CC      drivers/of/property.o
In file included from ./include/linux/preempt.h:11,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/slab.h:16,
                 from ./include/linux/resource_ext.h:11,
                 from ./include/linux/acpi.h:13,
                 from drivers/pinctrl/intel/pinctrl-cherryview.c:13:
./include/linux/cleanup.h:120:17: error: implicit declaration of function '=
class_hard_spinlock_constructor'; did you mean 'class_raw_spinlock_construc=
tor'? [-Werror=3Dimplicit-function-declaration]
  120 |                 class_##_name##_constructor
      |                 ^~~~~~
./include/linux/cleanup.h:164:9: note: in expansion of macro 'CLASS'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1179:9: note: in expansion of ma=
cro 'guard'
 1179 |         guard(hard_spinlock)(&chv_lock);
      |         ^~~~~
./include/linux/compiler.h:189:45: warning: unused variable '__UNIQUE_ID_gu=
ard495' [-Wunused-variable]
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                             ^~~~~~~~~~~~
./include/linux/cleanup.h:119:27: note: in definition of macro 'CLASS'
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |                           ^~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:29: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                             ^~~~~~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:37: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                     ^~~~~~~
./include/linux/cleanup.h:164:22: note: in expansion of macro '__UNIQUE_ID'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |                      ^~~~~~~~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1179:9: note: in expansion of ma=
cro 'guard'
 1179 |         guard(hard_spinlock)(&chv_lock);
      |         ^~~~~
  CC      drivers/dpll/dpll_nl.o
  CC      drivers/of/kobj.o
  CC      drivers/mmc/core/sdio.o
  CC [M]  drivers/staging/media/av7110/av7110_hw.o
  CC      drivers/mmc/core/sdio_ops.o
  CC [M]  drivers/staging/rts5208/rtsx_scsi.o
drivers/pinctrl/intel/pinctrl-cherryview.c: In function 'chv_gpio_irq_mask_=
unmask':
./include/linux/cleanup.h:119:9: error: unknown type name 'class_hard_spinl=
ock_irqsave_t'; did you mean 'class_raw_spinlock_irqsave_t'?
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |         ^~~~~~
./include/linux/cleanup.h:164:9: note: in expansion of macro 'CLASS'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1192:9: note: in expansion of ma=
cro 'guard'
 1192 |         guard(hard_spinlock_irqsave)(&chv_lock);
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1192:9: error: cleanup argument =
not a function
In file included from ./include/linux/preempt.h:11,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/slab.h:16,
                 from ./include/linux/resource_ext.h:11,
                 from ./include/linux/acpi.h:13,
                 from drivers/pinctrl/intel/pinctrl-cherryview.c:13:
./include/linux/compiler.h:189:45: warning: unused variable '__UNIQUE_ID_gu=
ard496' [-Wunused-variable]
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                             ^~~~~~~~~~~~
./include/linux/cleanup.h:119:27: note: in definition of macro 'CLASS'
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |                           ^~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:29: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                             ^~~~~~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:37: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                     ^~~~~~~
./include/linux/cleanup.h:164:22: note: in expansion of macro '__UNIQUE_ID'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |                      ^~~~~~~~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1192:9: note: in expansion of ma=
cro 'guard'
 1192 |         guard(hard_spinlock_irqsave)(&chv_lock);
      |         ^~~~~
  CC [M]  drivers/crypto/intel/qat/qat_common/adf_cfg.o
  CC      drivers/mmc/core/sdio_bus.o
  CC [M]  drivers/pinctrl/pinctrl-tps6594.o
  CC [M]  drivers/staging/rts5208/rtsx_card.o
  CC      drivers/devfreq/governor_passive.o
  CC [M]  drivers/extcon/extcon-axp288.o
  LD [M]  drivers/crypto/intel/qat/qat_dh895xcc/qat_dh895xcc.o
  CC [M]  drivers/staging/rts5208/general.o
  CC [M]  drivers/hwtracing/intel_th/gth.o
drivers/pinctrl/intel/pinctrl-cherryview.c: In function 'chv_gpio_irq_start=
up':
./include/linux/cleanup.h:119:9: error: unknown type name 'class_hard_spinl=
ock_irqsave_t'; did you mean 'class_raw_spinlock_irqsave_t'?
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |         ^~~~~~
./include/linux/cleanup.h:169:14: note: in expansion of macro 'CLASS'
  169 |         for (CLASS(_name, scope)(args),                            =
     \
      |              ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1244:9: note: in expansion of ma=
cro 'scoped_guard'
 1244 |         scoped_guard(hard_spinlock_irqsave, &chv_lock) {
      |         ^~~~~~~~~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1244:9: error: cleanup argument =
not a function
In file included from ./include/linux/preempt.h:11,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/slab.h:16,
                 from ./include/linux/resource_ext.h:11,
                 from ./include/linux/acpi.h:13,
                 from drivers/pinctrl/intel/pinctrl-cherryview.c:13:
./include/linux/cleanup.h:169:9: error: declaration of non-variable 'class_=
hard_spinlock_irqsave_constructor' in 'for' loop initial declaration
  169 |         for (CLASS(_name, scope)(args),                            =
     \
      |         ^~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1244:9: note: in expansion of ma=
cro 'scoped_guard'
 1244 |         scoped_guard(hard_spinlock_irqsave, &chv_lock) {
      |         ^~~~~~~~~~~~
  CC [M]  drivers/mmc/host/sdhci-pci-arasan.o
  CC      drivers/leds/led-core.o
  CC [M]  drivers/extcon/extcon-fsa9480.o
  CC [M]  drivers/staging/gdm724x/gdm_mux.o
  CC      drivers/hv/channel.o
  CC [M]  drivers/mmc/host/sdhci-pci-dwc-mshc.o
  CC [M]  drivers/mmc/host/sdhci-pci-gli.o
  CC      drivers/mmc/core/sdio_cis.o
drivers/pinctrl/intel/pinctrl-cherryview.c: In function 'chv_gpio_irq_type'=
:
./include/linux/cleanup.h:119:9: error: unknown type name 'class_hard_spinl=
ock_irqsave_t'; did you mean 'class_raw_spinlock_irqsave_t'?
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |         ^~~~~~
./include/linux/cleanup.h:164:9: note: in expansion of macro 'CLASS'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1336:9: note: in expansion of ma=
cro 'guard'
 1336 |         guard(hard_spinlock_irqsave)(&chv_lock);
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1336:9: error: cleanup argument =
not a function
  CC [M]  drivers/pinctrl/intel/pinctrl-geminilake.o
In file included from ./include/linux/preempt.h:11,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/slab.h:16,
                 from ./include/linux/resource_ext.h:11,
                 from ./include/linux/acpi.h:13,
                 from drivers/pinctrl/intel/pinctrl-cherryview.c:13:
./include/linux/compiler.h:189:45: warning: unused variable '__UNIQUE_ID_gu=
ard501' [-Wunused-variable]
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                             ^~~~~~~~~~~~
./include/linux/cleanup.h:119:27: note: in definition of macro 'CLASS'
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |                           ^~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:29: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                             ^~~~~~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:37: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                     ^~~~~~~
./include/linux/cleanup.h:164:22: note: in expansion of macro '__UNIQUE_ID'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |                      ^~~~~~~~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1336:9: note: in expansion of ma=
cro 'guard'
 1336 |         guard(hard_spinlock_irqsave)(&chv_lock);
      |         ^~~~~
  CC      drivers/hv/channel_mgmt.o
  CC [M]  drivers/vdpa/vdpa.o
drivers/pinctrl/intel/pinctrl-cherryview.c: In function 'chv_gpio_irq_handl=
er':
./include/linux/cleanup.h:119:9: error: unknown type name 'class_hard_spinl=
ock_irqsave_t'; did you mean 'class_raw_spinlock_irqsave_t'?
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |         ^~~~~~
./include/linux/cleanup.h:169:14: note: in expansion of macro 'CLASS'
  169 |         for (CLASS(_name, scope)(args),                            =
     \
      |              ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1408:9: note: in expansion of ma=
cro 'scoped_guard'
 1408 |         scoped_guard(hard_spinlock_irqsave, &chv_lock)
      |         ^~~~~~~~~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1408:9: error: cleanup argument =
not a function
In file included from ./include/linux/preempt.h:11,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/slab.h:16,
                 from ./include/linux/resource_ext.h:11,
                 from ./include/linux/acpi.h:13,
                 from drivers/pinctrl/intel/pinctrl-cherryview.c:13:
./include/linux/cleanup.h:169:9: error: declaration of non-variable 'class_=
hard_spinlock_irqsave_constructor' in 'for' loop initial declaration
  169 |         for (CLASS(_name, scope)(args),                            =
     \
      |         ^~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1408:9: note: in expansion of ma=
cro 'scoped_guard'
 1408 |         scoped_guard(hard_spinlock_irqsave, &chv_lock)
      |         ^~~~~~~~~~~~
  CC      drivers/of/fdt.o
  CC [M]  drivers/staging/media/av7110/av7110_v4l.o
  CC [M]  drivers/ras/amd/atl/map.o
  CC [M]  drivers/platform/chrome/chromeos_privacy_screen.o
  CC [M]  drivers/crypto/intel/qat/qat_c62xvf/adf_drv.o
drivers/pinctrl/intel/pinctrl-cherryview.c: In function 'chv_pinctrl_mmio_a=
ccess_handler':
./include/linux/cleanup.h:119:9: error: unknown type name 'class_hard_spinl=
ock_irqsave_t'; did you mean 'class_raw_spinlock_irqsave_t'?
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |         ^~~~~~
./include/linux/cleanup.h:164:9: note: in expansion of macro 'CLASS'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1599:9: note: in expansion of ma=
cro 'guard'
 1599 |         guard(hard_spinlock_irqsave)(&chv_lock);
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1599:9: error: cleanup argument =
not a function
In file included from ./include/linux/preempt.h:11,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/slab.h:16,
                 from ./include/linux/resource_ext.h:11,
                 from ./include/linux/acpi.h:13,
                 from drivers/pinctrl/intel/pinctrl-cherryview.c:13:
./include/linux/compiler.h:189:45: warning: unused variable '__UNIQUE_ID_gu=
ard502' [-Wunused-variable]
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                             ^~~~~~~~~~~~
./include/linux/cleanup.h:119:27: note: in definition of macro 'CLASS'
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |                           ^~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:29: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                             ^~~~~~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:37: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                     ^~~~~~~
./include/linux/cleanup.h:164:22: note: in expansion of macro '__UNIQUE_ID'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |                      ^~~~~~~~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1599:9: note: in expansion of ma=
cro 'guard'
 1599 |         guard(hard_spinlock_irqsave)(&chv_lock);
      |         ^~~~~
  CC [M]  drivers/staging/rtl8712/rtl8712_cmd.o
  CC [M]  drivers/platform/chrome/chromeos_pstore.o
  CC [M]  drivers/extcon/extcon-gpio.o
  CC [M]  drivers/extcon/extcon-intel-int3496.o
  CC      drivers/leds/led-class.o
  CC [M]  drivers/crypto/intel/qat/qat_c62xvf/adf_c62xvf_hw_data.o
  CC [M]  drivers/crypto/intel/qat/qat_common/adf_isr.o
  CC [M]  drivers/crypto/intel/qat/qat_common/adf_ctl_drv.o
  CC [M]  drivers/crypto/ccp/ccp-dev-v3.o
  AR      drivers/staging/vme_user/built-in.a
  CC [M]  drivers/staging/pi433/pi433_if.o
drivers/pinctrl/intel/pinctrl-cherryview.c: In function 'chv_pinctrl_suspen=
d_noirq':
./include/linux/cleanup.h:119:9: error: unknown type name 'class_hard_spinl=
ock_irqsave_t'; did you mean 'class_raw_spinlock_irqsave_t'?
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |         ^~~~~~
./include/linux/cleanup.h:164:9: note: in expansion of macro 'CLASS'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1712:9: note: in expansion of ma=
cro 'guard'
 1712 |         guard(hard_spinlock_irqsave)(&chv_lock);
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1712:9: error: cleanup argument =
not a function
  CC [M]  drivers/staging/rts5208/sd.o
In file included from ./include/linux/preempt.h:11,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/slab.h:16,
                 from ./include/linux/resource_ext.h:11,
                 from ./include/linux/acpi.h:13,
                 from drivers/pinctrl/intel/pinctrl-cherryview.c:13:
./include/linux/compiler.h:189:45: warning: unused variable '__UNIQUE_ID_gu=
ard503' [-Wunused-variable]
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                             ^~~~~~~~~~~~
./include/linux/cleanup.h:119:27: note: in definition of macro 'CLASS'
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |                           ^~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:29: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                             ^~~~~~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:37: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                     ^~~~~~~
./include/linux/cleanup.h:164:22: note: in expansion of macro '__UNIQUE_ID'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |                      ^~~~~~~~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1712:9: note: in expansion of ma=
cro 'guard'
 1712 |         guard(hard_spinlock_irqsave)(&chv_lock);
      |         ^~~~~
  AR      drivers/powercap/built-in.a
  CC [M]  drivers/staging/fbtft/fbtft-sysfs.o
  LD [M]  drivers/crypto/intel/qat/qat_c62x/qat_c62x.o
  CC [M]  drivers/staging/pi433/rf69.o
  CC [M]  drivers/hsi/hsi_core.o
  CC [M]  drivers/hwtracing/intel_th/sth.o
  CC [M]  drivers/accel/habanalabs/common/mmu/mmu.o
  CC [M]  drivers/pinctrl/intel/pinctrl-icelake.o
  LD [M]  drivers/crypto/intel/qat/qat_dh895xccvf/qat_dh895xccvf.o
  CC [M]  drivers/parport/share.o
  CC [M]  drivers/staging/fbtft/fbtft-bus.o
  CC [M]  drivers/staging/rts5208/xd.o
  CC [M]  drivers/parport/ieee1284.o
  CC [M]  drivers/crypto/ccp/ccp-dev-v5.o
  CC [M]  drivers/accel/habanalabs/common/mmu/mmu_v1.o
  CC [M]  drivers/staging/rts5208/ms.o
drivers/pinctrl/intel/pinctrl-cherryview.c: In function 'chv_pinctrl_resume=
_noirq':
  CC [M]  drivers/staging/media/ipu3/ipu3-v4l2.o
./include/linux/cleanup.h:119:9: error: unknown type name 'class_hard_spinl=
ock_irqsave_t'; did you mean 'class_raw_spinlock_irqsave_t'?
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |         ^~~~~~
./include/linux/cleanup.h:164:9: note: in expansion of macro 'CLASS'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |         ^~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1739:9: note: in expansion of ma=
cro 'guard'
 1739 |         guard(hard_spinlock_irqsave)(&chv_lock);
      |         ^~~~~
  CC [M]  drivers/accel/habanalabs/common/mmu/mmu_v2.o
drivers/pinctrl/intel/pinctrl-cherryview.c:1739:9: error: cleanup argument =
not a function
In file included from ./include/linux/preempt.h:11,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/slab.h:16,
                 from ./include/linux/resource_ext.h:11,
                 from ./include/linux/acpi.h:13,
                 from drivers/pinctrl/intel/pinctrl-cherryview.c:13:
./include/linux/compiler.h:189:45: warning: unused variable '__UNIQUE_ID_gu=
ard504' [-Wunused-variable]
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                             ^~~~~~~~~~~~
./include/linux/cleanup.h:119:27: note: in definition of macro 'CLASS'
  119 |         class_##_name##_t var __cleanup(class_##_name##_destructor)=
 =3D   \
      |                           ^~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:29: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                             ^~~~~~~
././include/linux/compiler_types.h:84:22: note: in expansion of macro '___P=
ASTE'
   84 | #define __PASTE(a,b) ___PASTE(a,b)
      |                      ^~~~~~~~
./include/linux/compiler.h:189:37: note: in expansion of macro '__PASTE'
  189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), =
__COUNTER__)
      |                                     ^~~~~~~
./include/linux/cleanup.h:164:22: note: in expansion of macro '__UNIQUE_ID'
  164 |         CLASS(_name, __UNIQUE_ID(guard))
      |                      ^~~~~~~~~~~
drivers/pinctrl/intel/pinctrl-cherryview.c:1739:9: note: in expansion of ma=
cro 'guard'
 1739 |         guard(hard_spinlock_irqsave)(&chv_lock);
      |         ^~~~~
  CC [M]  drivers/parport/ieee1284_ops.o
  CC [M]  drivers/platform/chrome/chromeos_tbmc.o
  CC      drivers/platform/x86/amd/wbrf.o
  LD [M]  drivers/crypto/intel/qat/qat_c3xxx/qat_c3xxx.o
cc1: some warnings being treated as errors
make[8]: *** [scripts/Makefile.build:244: drivers/pinctrl/intel/pinctrl-che=
rryview.o] Error 1
make[8]: *** Waiting for unfinished jobs....
  LD [M]  drivers/virt/acrn/acrn.o

...

Best regards,
Ionut Nechita.

-----Original Message-----
From: Nechita, Ionut=20
Sent: Friday, May 17, 2024 4:23 PM
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
Subject: RE: WARN Kernel v6.9-evl-rebase - do_int80_emulation

This is happened when CONFIG_DOVETAIL is =3Dn and CONFIG_EVL is =3Dn in .co=
nfig.
When using disable this and using generic configuration/flavour; CONFIG_PIN=
CTRL_CHERRYVIEW with =3Dy is not build.=20
Maybe rebase is not fully completed on 6.9-rebase-evl.


Will try to append kernel log build.

Best regards,
Ionut Nechita.

-----Original Message-----
From: Philippe Gerum <rpm@xenomai.org>=20
Sent: Friday, May 17, 2024 4:16 PM
To: Nechita, Ionut <ionut.nechita@intel.com>
Cc: xenomai@lists.linux.dev
Subject: Re: WARN Kernel v6.9-evl-rebase - do_int80_emulation


"Nechita, Ionut" <ionut.nechita@intel.com> writes:

> Clean now in dmesg.=20
> Warn message not appear.
> This patch is fine.
>
> But I notice issue on compiling CONFIG_PINCTRL_CHERRYVIEW at builtin opti=
on.
> Kernel failing when CONFIG_PINCTRL_CHERRYVIEW is =3Dy.
>
> I use CONFIG_PINCTRL_CHERRYVIEW=3Dn to compiling your change.
>

There must be something else at work. Builds fine here with CONFIG_PINCTRL_=
CHERRYVIEW=3Dy.

The failing build log would help.

--
Philippe.
