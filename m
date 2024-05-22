Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B275C56444
	for <xenomai@lists.linux.dev>; Wed, 22 May 2024 16:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716394308; cv=fail; b=tMSEcGG0XMBe8bN1Sqxu14rd1Dfb8qft8pqPzLtKcvKuUX9pVOIvCQRaUoV63MQRQiUC8gKBH6D3I3k1ffj1lfxE7sM5yvyOEOB3Uo+vHEbwFxMUihj592K3zYBGWhShiuRbB8QD1IfJ+UkQppYRxrn/H6g2MsoDCzQKfXSJDzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716394308; c=relaxed/simple;
	bh=Jy1Hy28o+E23PlLVrE3h6gzp8P/eUli5dFWKvmTizbQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Mt6wSNaEple6UXz+oNu18WzOYl6bnXWXtaScMHWIXOQbIQZU6C7nwWAt0/tGmfLULXEoOW8Csj4SHqlr+rv0BgeZ/CwV3QR4LCNwsgq0FjToowMTRXNor2seaY5LxddbFwYkmNFlzbxEHUJ2jc/BCH2wDTJeKCcVAs6bFnYBpLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zntwitre; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zntwitre"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716394307; x=1747930307;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Jy1Hy28o+E23PlLVrE3h6gzp8P/eUli5dFWKvmTizbQ=;
  b=ZntwitrevbNCEYQ529oLJwV7JUVMbTpE6Z5WIBc3OMT5M4uP2aWwsm5u
   ufzl6cnt3jadYS0ojj/+mGBhr4Xn8MU3PFdDDZecDH+DT8idvVeKJWfpt
   yWAPO52UZiHiWk8SrBSqZQPW7OWMjdQ5Vzf7vDAb/KTxwQMJlTUtQIfcT
   9iQChAB5rYVL30qiyro/SHPahbaSJe6uSGrCxzVO+D/kTKeVeAZ4fa1wC
   Zm7GAs1CRGlKv0wYrErXmP1jZyVs7iTZyuzgyKrF0MS3gdUG2KBiiIGD3
   4LK6qYHW8JWGUiqi6lYkBziFF++MwQC0NSlJ7/jIumVdFFymVZUcjSjkJ
   w==;
X-CSE-ConnectionGUID: GqdwA31fTiCJUSAC8gYH4A==
X-CSE-MsgGUID: LQRqJoOISMGBfxciI1h3UQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="12598874"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="12598874"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 09:11:40 -0700
X-CSE-ConnectionGUID: QF/a8SVGSFWA3KDQPfvv7g==
X-CSE-MsgGUID: 5/dpxaYiQq+/CLOn+Sbe1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="38314223"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 May 2024 09:11:40 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 09:11:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 09:11:31 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 22 May 2024 09:11:31 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 09:11:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lB1bQQ06Txv5MzsUhWJztTJT4jcga5+ZNsc38ni2GX629r9OVTwEnl6RKQQZ2/YuGweLxCl8/D/BgZ3jvF8V91CTbbV5wLDk1suF1PBCSGi0TX0UX+oP/MYXoaY1YTEtqP+RT2EIwOxTG2P07gLLsbzK9MSgNGS1FvBNWZanGNtAXQygQSAhDT9e/chQuARWwK1/lITXKZSK+qKc1gxLhAOaLAvfs4LyhmrzeD+PFFF7kZ9bBs3xjsG5CtLS4oO+v2Bc0CBikSuLNJcAjc1aoVSQGWCohysV6D6vv7AhT05eJ9abT6or6fD9BuUlSWjGVUz9iMTUvYx49WbEVfAIMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGUsdMlMWuMtBY0Ht1tXBVGpV4UCcBtrn0h6z293qcU=;
 b=diq+OHpW1tn2CP4ZSfAkF4almAm/cOSw7aZEqzpJBifRIZXAKZh959Yw8FbX4mpugD7kq3INs3cJuRSX79Je1pVUhDCNIFgdEeMpcNTDR5xEAQ38MR1F8YzDBg1JxnvhQmHQAr/y+76odtOxVFtsgqdabGzeLT3ChCO9uAjC6adqGyv0dNPimyv4icW5yYL/jfA6Qdo/eJji0zQcHAXicZiPCDDJOJd6/qk4N30SeJd+PqdC2ho98Vs6nXpa4OgQAbY3gu0pyWNJq/7KXsxLgC+vDTwC4V/ZrwCTfOrMK1zSrcOTdJqGVj1HU5njOt9VGTilA5TFfYZqtOLKXxl6Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5949.namprd11.prod.outlook.com (2603:10b6:510:144::6)
 by MW4PR11MB6569.namprd11.prod.outlook.com (2603:10b6:303:1e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 16:11:05 +0000
Received: from PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861]) by PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861%6]) with mapi id 15.20.7544.052; Wed, 22 May 2024
 16:11:04 +0000
From: "Nechita, Ionut" <ionut.nechita@intel.com>
To: Philippe Gerum <rpm@xenomai.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: WARN Kernel v6.9-evl-rebase - EVL: invalid out-of-band syscall
 <0x43564d41> - Firefox browser
Thread-Topic: WARN Kernel v6.9-evl-rebase - EVL: invalid out-of-band syscall
 <0x43564d41> - Firefox browser
Thread-Index: Adqobt1wsEThW759TTGOhdgp/60cKwD2+6CAAAAhQ+AABC7IUAAAPt4AAAFbp1A=
Date: Wed, 22 May 2024 16:11:04 +0000
Message-ID: <PH0PR11MB5949B24CB222FBB2D387BF24F4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
References: <PH0PR11MB59493E21636F9CA955E2DE8BF4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
 <87wmnmq8v9.fsf@xenomai.org>
 <PH0PR11MB59491C18ADB51F5FEAEF4B3FF4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
 <PH0PR11MB59490B50D2D2717B8155EFCDF4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
 <87h6eprhbg.fsf@xenomai.org>
In-Reply-To: <87h6eprhbg.fsf@xenomai.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5949:EE_|MW4PR11MB6569:EE_
x-ms-office365-filtering-correlation-id: 8fc3634e-53d0-4a2d-4db1-08dc7a79c832
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?/wNopzmeXKOgUOi/vbufX+aNhCK6J38AXyP37o5A7Wi2byg9MSj4dWaFMR/e?=
 =?us-ascii?Q?I03H0Syln7cMl0kr7LZ4vqiS4TKUoO6ENgPmHMOnSpx/dupyItUJPJVNhyeD?=
 =?us-ascii?Q?ZVatVVYzhkDH0lPBnu2LPOMYg/g1esSr8Nyc8zce5rmfp+5zXRywkn5QnbwX?=
 =?us-ascii?Q?H2EAkdAE0HoLVZ5/5XZ6L47raQ2gxgKEwHcP4qOBtNX4w1Gy4N1D2KxFAx70?=
 =?us-ascii?Q?Ji7KAKRP1MbKPZFFjjq0CKGzEvCiFiFixAFoHvqSqEny5KkFscHVktTAygfs?=
 =?us-ascii?Q?gK0wA6KhK0eZ3lXvE1502UhdTJlu+GE1DxI4+4JmVtHmJfTcPRkhrp5DSPh8?=
 =?us-ascii?Q?kx80d+SxJIROF5abPxLvSebxUUQfFlBcG2nNQsWchODp8nZAB+nSPb3vBAWx?=
 =?us-ascii?Q?LXdSFxyBmQFzzMsSzZyACLZWKodq0ZhW9NcOXyINGmL/PkMh6cl16hkB5e4X?=
 =?us-ascii?Q?LIU+iuvSKArGrzLoyAQ7I/0y5aHE+oZM3liPc1IOSJUAZWZipCBw8WShGQG9?=
 =?us-ascii?Q?cabPG7zZhHUaL0ZqILb87EJGyJxa7OlAlR0yVP3zaWKk+2b5nsB+xldxIMLh?=
 =?us-ascii?Q?3mWVmSGhg5nL6ROCIKrK5AO1pjD9uHaqN95Z6tsHhr79qM2VQ11EYgLCiHXM?=
 =?us-ascii?Q?qmQmGiB6KJMVyTbU4e1qSw5PYOQs55o39871nKM5LO5JkBaKaXZJ6tZkP3CK?=
 =?us-ascii?Q?oO+D4zUgLrGl5Bgv7gjWSPz4u1mgQN9MJ62YXxmMKFxIr6fMfAhzsKY8TSEy?=
 =?us-ascii?Q?EKyHFwr7V/WawFuGY03r6UitQJOFfbAaz7OlG3jSIwFoavQs6kQ4ktRTO6/L?=
 =?us-ascii?Q?17+rfLHq4lIwoZl0IBGM35A8x753oCJQ2yWLLBpU0Bf7lvnV9GM7+Xfchxi0?=
 =?us-ascii?Q?H/8G4tlpIB0R9kugZXpo3zfBZ3pARPc0P3i+VbCBDAsEz2qll1CjpfJSxUto?=
 =?us-ascii?Q?lQn8a2QeVMyJDtCO0SGFsXc9xdhB2ElCPDUqldBM3ADzah+BbPBsA3IuBtP/?=
 =?us-ascii?Q?RLarDLzScJzJWRgr4FwFlbnCkpfq4rlr8abk6XUEX09++NN1+MDJhAqnPTG5?=
 =?us-ascii?Q?Zi6M3oy+FExG0ll7YdX8SidIQuDG6I00PtVqnMJE0S1j1ZNV35HH0eIrEV+p?=
 =?us-ascii?Q?1m9gUpwy400CgJjWmDyTo3ylxSI7cctf4eIPq40fTwxAM739lKjUTLeho0IM?=
 =?us-ascii?Q?SUSKgBQHU8ipVmITa9gK9yphRzYDNj9rcp2e7mzsKfIBNTDLa6w3mmy2yYl8?=
 =?us-ascii?Q?sPY8PpbYHY7LsxzRo0uP2m5ImPtohOxcVhj8sPBhVd3mBlShcAz7KjW+EgoN?=
 =?us-ascii?Q?8RFQQ1oPxMhPh0XBEyL7uZXBW+36GXDjuD6xpayXxuj3Eg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5949.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8gfwwEYYJcb9gc73Et1deiy19K/etu2Fpajc5h+1eXzjwk92lz5o33kPqbAs?=
 =?us-ascii?Q?HbW25VWqzN8tXDPgocZDex2AHpizvqPzzbAtLc+iPObPHOIyybE1AcUnjTuU?=
 =?us-ascii?Q?pI/5RjMoNzxRI9bxUB9EO4H4757HQf8aeHXj6ZGR8Wallz3K7gd9Y2oYjMyr?=
 =?us-ascii?Q?Wyy0X2x43soSfRbpE+wc5UbORAiQ/b8oIHEKo6JUAC2RSM2m64owto5YRbQ8?=
 =?us-ascii?Q?qtOLLsX+DNg+K/Yu8VQXjIAUNnWa/QaWjEF7QtRzrFNlKrTFwwcDTRqVmCrp?=
 =?us-ascii?Q?fBqBI18QuBZihG4Oj3r39EcLqyYDPF439OEwxsu+9es/cqStUy3HIoDSxE5i?=
 =?us-ascii?Q?MaY0im+sHwB5FmyMJPZ/Qu1uz6cfIgJ2cHxoCX12k4qoWgz141O5ZFUu2Q8Q?=
 =?us-ascii?Q?wcIShOeCwyaGhFBojlzlqsOKLZH6ouvBfCoBH+C/0vtR9iGYSFH5ku7wYCv2?=
 =?us-ascii?Q?eQTpHon6TZ5eyfI2GWM4gizYIz1XwgWb++TsbY1leJL5B6LxKYxDv7B5tb1d?=
 =?us-ascii?Q?yIwsA28YvJ+i3HsivkNmYTerr46xFPxLtDfc2tJm0DJVMkqtvYp3GVbUtF/4?=
 =?us-ascii?Q?xO+/iWXqsNuei1XEEHlaiR87TtemHiSwOjLvzJQ/dqriw7kcExh2GlXVtvWC?=
 =?us-ascii?Q?SUpO+kHF+AYy3Vj4G8k7NB4ZFWgIXzGYQKgQFqv2mT8Urk9WZZJVt3HyzKAn?=
 =?us-ascii?Q?ZYFKkTTqqUSZGb/8zhC6jLnOAxzKkZ7f9KRK4SJa1sRNrqB6+PfoSCH03QpA?=
 =?us-ascii?Q?P90xuvK8D0rA6SMmVOetWcaOUqFqH8B+IJdZuQaw45jbpzI30ARNzR3qzFvW?=
 =?us-ascii?Q?gPlT9tw7Scgan1RQ73IojHG22h5LRsp9dNSOTw/X/LJV3tKQ+/GK9NoJBbKn?=
 =?us-ascii?Q?vVM/UCljwLoNHh7wog8ZvDyjQ4Qi3aNEyxrgSRNd74nGukSE6FwdUtvXs4jm?=
 =?us-ascii?Q?+nsZ8T96MpLdjgvWpBxHhwuKeimnjHoMJXh8poTh360jVu8FCpzAgz/QtwZC?=
 =?us-ascii?Q?piz5w58hbyyXCwMV6EYoA5/2rK/pBiT5Irh45rgfYOQLmF/mSd2Qb+PK4fuS?=
 =?us-ascii?Q?+ebDmyXsjGi0rjkHJdZP/+WmcbMTeD/EJv1tQn++4LwEGrkow3i5TOfcZhag?=
 =?us-ascii?Q?rHsyLPXKAzVAxfsvBRbR1EssZMWuM4ELHySrTd96lR4G2x6574ag+N0CeMF7?=
 =?us-ascii?Q?vSAQaKn6NMyrGrw7AGdAl+0o4D/V0w0tlcaJk4A1f78wZRZp1gd3/VFZz21S?=
 =?us-ascii?Q?Axl2eMvZf88GPaODu0AF4kfX8bJsMDRlswTsY3KjmQ/D0Re/SqCcvhvVPMYS?=
 =?us-ascii?Q?cY41nl23qQ1OynLmL0t0X4OhaMVxHdyPGH3p69uDtMmxfZJUxu+ffb22/k3y?=
 =?us-ascii?Q?vklttf4bXT2YxgYnL8z3XT/tvNLnqQB+2sFd/84AG+q088LYdJnziqzQlOWr?=
 =?us-ascii?Q?Alz2+a7xMADQ58+4mQywLh7Z5M066mEuQlhYkSLFBg6zGBDVxhHzw63N3RVt?=
 =?us-ascii?Q?4L+lktnrfKB1jH5D2YMkoHZLMqDu0X/3BaO5q+TEbEEJdBqhdmbWhD5jZijm?=
 =?us-ascii?Q?QUOIGGYIFZsJZO7QE+zHItdcnwkMapFUQekE57YJ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc3634e-53d0-4a2d-4db1-08dc7a79c832
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 16:11:04.7799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aJW848fRrrf/LiQYBsEyIjRmDnbCj89skd46nNRdf6DhEQqnUJ6YEiqr9JGvmJ8d8G9a/HY/ZCwTXkwHCTeRlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6569
X-OriginatorOrg: intel.com

I delete workspace and I recompiled again.

And I have this now:

...
[  163.204266] ------------[ cut here ]------------
[  163.204270] WARNING: CPU: 0 PID: 4270 at kernel/evl/syscall.c:272 do_oob=
_syscall+0x191/0x360
[  163.204279] Modules linked in: input_leds hid_generic usbhid hid rfcomm =
xt_nat xt_tcpudp veth xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat nf_co=
nntrack_netlink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user xfrm_a=
lgo xt_addrtype nft_compat nf_tables libcrc32c nfnetlink snd_hda_codec_hdmi=
 snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_component cmac =
algif_hash algif_skcipher af_alg bnep overlay snd_sof_pci_intel_skl snd_sof=
_intel_hda_common soundwire_intel snd_sof_intel_hda_mlink soundwire_cadence=
 snd_sof_intel_hda snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils sou=
ndwire_generic_allocation soundwire_bus snd_soc_avs snd_soc_hda_codec snd_s=
oc_skl snd_soc_hdac_hda intel_rapl_msr snd_hda_ext_core intel_rapl_common s=
nd_soc_sst_ipc snd_soc_sst_dsp snd_soc_acpi_intel_match snd_soc_acpi intel_=
uncore_frequency intel_uncore_frequency_common snd_soc_core intel_tcc_cooli=
ng x86_pkg_temp_thermal intel_powerclamp snd_compress ac97_bus coretemp snd=
_pcm_dmaengine snd_hda_intel snd_intel_dspcfg
[  163.204331]  snd_intel_sdw_acpi kvm_intel snd_hda_codec kvm snd_hda_core=
 snd_hwdep binfmt_misc btusb iwlmvm mei_hdcp mei_pxp crct10dif_pclmul snd_p=
cm i915 mac80211 snd_seq_midi polyval_clmulni snd_seq_midi_event polyval_ge=
neric ghash_clmulni_intel btrtl libarc4 sha256_ssse3 btintel snd_rawmidi sh=
a1_ssse3 aesni_intel btbcm crypto_simd drm_buddy btmtk ttm cryptd iwlwifi s=
nd_seq bluetooth drm_display_helper rapl snd_seq_device ecdh_generic intel_=
cstate intel_wmi_thunderbolt ecc wmi_bmof cfg80211 snd_timer ee1004 cec snd=
 soundcore mei_me i2c_algo_bit mei intel_pmc_core intel_xhci_usb_role_switc=
h intel_pch_thermal intel_vsec pmt_telemetry mac_hid pmt_class acpi_pad sch=
_fq_codel msr parport_pc ppdev lp parport efi_pstore ip_tables x_tables aut=
ofs4 rtsx_pci_sdmmc xhci_pci crc32_pclmul xhci_pci_renesas ahci e1000e i2c_=
i801 i2c_smbus rtsx_pci xhci_hcd libahci video wmi
[  163.204394] CPU: 0 PID: 4270 Comm: firefox Not tainted 6.9.0-x64v1-1-low=
latency #3
[  163.204397] Hardware name: Intel(R) Client Systems NUC7i7BNH/NUC7i7BNB, =
BIOS BNKBL357.86A.0083.2020.0714.1344 07/14/2020
[  163.204399] IRQ stage: EVL
[  163.204400] RIP: 0010:do_oob_syscall+0x191/0x360
[  163.204404] Code: 1a 41 8b 95 70 01 00 00 89 10 49 8b 85 40 02 00 00 41 =
8b 95 74 01 00 00 89 50 04 49 8b 74 24 50 0f 1f 44 00 00 e9 0c ff ff ff <0f=
> 0b 48 c7 c7 b8 fe 43 9a 89 d6 e8 ef 53 e9 ff e9 59 ff ff ff 48
[  163.204407] RSP: 0018:ffffad2bc3ddfdb8 EFLAGS: 00010216
[  163.204409] RAX: 0000000000000000 RBX: ffff934d7b378000 RCX: ffffad2bc3d=
dfe08
[  163.204411] RDX: 0000000043564d41 RSI: ffffad2bc3ddff58 RDI: ffffffff9a7=
59fb0
[  163.204412] RBP: ffffad2bc3ddfdf8 R08: ffffffff9a759fb0 R09: 00000000000=
00000
[  163.204414] R10: 0000000000000000 R11: 0000000000000000 R12: ffffad2bc3d=
dff58
[  163.204415] R13: 0000000053564d41 R14: ffff93545ea52040 R15: ffffffff9af=
682b0
[  163.204417] FS:  00007fcdd4d9d780(0000) GS:ffff93545ea00000(0000) knlGS:=
0000000000000000
[  163.204419] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  163.204421] CR2: 0000582e42dcb5a8 CR3: 00000001147fa003 CR4: 00000000003=
706f0
[  163.204423] Call Trace:
[  163.204424]  <TASK>
[  163.204428]  ? show_regs+0x6c/0x80
[  163.204433]  ? __warn+0x88/0x140
[  163.204438]  ? do_oob_syscall+0x191/0x360
[  163.204441]  ? report_bug+0x182/0x1b0
[  163.204447]  ? handle_bug+0x5e/0xc0
[  163.204452]  ? exc_invalid_op+0xe6/0x110
[  163.204455]  ? asm_exc_invalid_op+0x1b/0x20
[  163.204462]  ? do_oob_syscall+0x191/0x360
[  163.204467]  handle_pipelined_syscall+0xb1/0x390
[  163.204472]  __pipeline_syscall+0xaf/0x260
[  163.204477]  pipeline_syscall+0xbb/0x190
[  163.204481]  do_syscall_64+0x74/0x210
[  163.204485]  ? irqentry_exit+0x40/0xe0
[  163.204489]  ? exc_page_fault+0x99/0x1b0
[  163.204493]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  163.204497] RIP: 0033:0x7fcdd4ec6381
[  163.204500] Code: Unable to access opcode bytes at 0x7fcdd4ec6357.
[  163.204501] RSP: 002b:00007ffff1a5a260 EFLAGS: 00000246 ORIG_RAX: 000000=
000000009d
[  163.204503] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fcdd4e=
c6381
[  163.204505] RDX: 00007fcdd4c9d000 RSI: 0000000000000000 RDI: 00000000535=
64d41
[  163.204506] RBP: 0000000000000000 R08: 0000582e42cb7148 R09: 00000000000=
00000
[  163.204508] R10: 0000000000100000 R11: 0000000000000246 R12: 00007fcdd4c=
9d000
[  163.204509] R13: 0000000000100000 R14: 0000000000000980 R15: 00000000001=
00000
[  163.204515]  </TASK>
[  163.204516] ---[ end trace 0000000000000000 ]---
[  163.204517] EVL: invalid out-of-band syscall <0x43564d41>
[  163.204550] EVL: invalid out-of-band syscall <0x43564d41>
[  163.204589] EVL: invalid out-of-band syscall <0x43564d41>
[  163.204626] EVL: invalid out-of-band syscall <0x43564d41>
[  163.204647] EVL: invalid out-of-band syscall <0x43564d41>

...

This patch is not complete now.

BR,
Ionut Nechita.


-----Original Message-----
From: Philippe Gerum <rpm@xenomai.org>=20
Sent: Wednesday, May 22, 2024 6:31 PM
To: Nechita, Ionut <ionut.nechita@intel.com>
Cc: xenomai@lists.linux.dev
Subject: Re: WARN Kernel v6.9-evl-rebase - EVL: invalid out-of-band syscall=
 <0x43564d41> - Firefox browser


"Nechita, Ionut" <ionut.nechita@intel.com> writes:

> Hi Philippe,
>
> I tested today with your change:
>
> git diff
> diff --git a/kernel/evl/syscall.c b/kernel/evl/syscall.c index=20
> c2a3f13ebe37..1d02b9d6dd38 100644
> --- a/kernel/evl/syscall.c
> +++ b/kernel/evl/syscall.c
> @@ -269,6 +269,7 @@ static int do_oob_syscall(struct irq_stage *stage,=20
> struct pt_regs *regs,
>
>         nr &=3D ~__OOB_SYSCALL_BIT;
>         if (nr >=3D NR_EVL_SYSCALLS) {
> +               WARN_ON_ONCE(1);
>                 printk(EVL_WARNING "invalid out-of-band syscall <%#x>\n",=
 nr);
>                 goto bad_syscall;
>         }
>
> But this is not working properly.
>

Please, double-check that you are actually testing the right kernel.

--
Philippe.
