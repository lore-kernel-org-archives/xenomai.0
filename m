Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D513BBE5
	for <xenomai@lists.linux.dev>; Fri, 17 May 2024 12:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715949654; cv=fail; b=C2e5yLK9IPWAZkG83ggQi4Dk+yg8k5tBp2rZWH50OzaQa4iblrURuYbzrDDVFha0kX9nLzqjo8LCbd/obchrnrE1/FPYy9KOW2jSxZeTE+4FXJJgqvOkg8gmiZUPh040YVjNg9GXvrENPra9zMUwuYL6LKIowE7vG6UyTgilx9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715949654; c=relaxed/simple;
	bh=cpTOL7IGc8PXClyjoeubBzsJq2lnpTUV2yy8jl0Vw4s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZLJ72Tymi67UIhN4TIJAR0ocKkfJ7Fji12OvVfdsE2Ux+RUWgWSTKWh555Ls55kQMLd34l7R/gTQNnTDwIG9o2v5m9EExLMmOge2O4MyRbFcIfvRLkP6JDEUrpAxJdg5UQnYanPDq1/4YgkN25usWwb3QwK9cnX1dfXpygd1FGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ESLXOpVv; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ESLXOpVv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715949653; x=1747485653;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cpTOL7IGc8PXClyjoeubBzsJq2lnpTUV2yy8jl0Vw4s=;
  b=ESLXOpVv0vRhXxBM6tS+xdzWVR7nvVjNE08Lkc4JhLrlZgSv2PlvlC24
   ICIWEwdepNkupJRd49PoFJQyl/MBQBARdvNRjCHYCAbae7+5nNGmbxiFi
   R2kArCVfze/9WKKtGljGljlNNpiaEjuSMRhazHA4M3OdcwtDN/MAB0vLT
   +Lz9HH0bg1yh+cg6rvBy8wnRQsEdaupFS8fGjJEwcc0gO9bnHMhTAxwE/
   9HgmH6fjcBgOnMMrJZYyCvIj1QUX6jb20Sx6sfFmkjwVlvHGdALmHDDzr
   j+k7EBDUwmpIrbI02hZD+S4p+3LYb+YR3nh+vwUwFJtfycJQxwz5NSuLS
   g==;
X-CSE-ConnectionGUID: XRsTsY6XQ7CJUAQJAzFWiw==
X-CSE-MsgGUID: tC90GqG0SDGAmeVTEUDOAQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="12312125"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="12312125"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 05:40:52 -0700
X-CSE-ConnectionGUID: qzVxAP6iSJSvpdBPE+vh/w==
X-CSE-MsgGUID: j18pxqlcTHGYTax09q47Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="31795186"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 May 2024 05:40:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 17 May 2024 05:40:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 17 May 2024 05:40:51 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 17 May 2024 05:40:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lks17lqTOS+R3es3xzWrPKpFg3Ak+ny6zDvvvlhAzIjxjIMFqk8Amfdut3O680s7zEAEhQA0PmdJ8FMLOSfXW4NVruzSOrwTzskQPY+SU/b+Rh8rAj76czt+fDTukqy4mTM0czAeh8s20SSP7jAPsQuSgNbnXBD7lT+VGnzqTymIxVyUaG4LmhbPc+Ojtu7AXl1jttL2pNJH7q3QJyvrMyf2BYM9vnh6BJBhtiOKqD2bXaLRl8n3d6qBP0NIxj7b7z1/o1aAdkkepsv25KO1St7DTYnDLzVry6hH7sJGe6PIdnwf+VlKiI3Oa1ocfSz0SuT/K+C6l1jsxQPf/vqmFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLA5v8dnZCyFSzooOO1lz/0kMU9J1vs9QzcNsfP8wQc=;
 b=gj7mt+eUQCdJyX5PC+5JZv9dX/S4mcHYY5uPPAHClNtngS8CZygasdw9W91U/cUCKV2R9TREEcDJh07Fd/bAR1oCJZF8fYYYrEZb0lKHbIhqkVbcjJih0pYTKJP0EV0m/dBZMCjOrIH2HqoavcPQsqbfyxaTFRvh1v0mQjl8C54BLsB8p4E5UkN/KNMBqBkTeob6Ay/P0FV05NKbDQUwYG4kAsRaWAjxIFuvPciHhQqZ2YFr/EAy0WCZa0yt7daCjg2YBrSkErs3BIShJ2V4Z3pTXbPO5CCsy8K2o5pUVWkYGQZ7NmMM00MtNwgdHW0LAoJQfTI1Q5/c35LLSh8V7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5949.namprd11.prod.outlook.com (2603:10b6:510:144::6)
 by BN9PR11MB5260.namprd11.prod.outlook.com (2603:10b6:408:135::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Fri, 17 May
 2024 12:40:49 +0000
Received: from PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861]) by PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861%6]) with mapi id 15.20.7544.052; Fri, 17 May 2024
 12:40:49 +0000
From: "Nechita, Ionut" <ionut.nechita@intel.com>
To: Philippe Gerum <rpm@xenomai.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: WARN Kernel v6.9-evl-rebase - do_int80_emulation
Thread-Topic: WARN Kernel v6.9-evl-rebase - do_int80_emulation
Thread-Index: AdqoUB42H/OnAc6gQSyqVaNVHGTu7wAA2ngAAADkauA=
Date: Fri, 17 May 2024 12:40:49 +0000
Message-ID: <PH0PR11MB5949EC28B447C7534BF8292DF4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
References: <PH0PR11MB59492DDE7F2301CECFD2D8A9F4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
 <877cfsskke.fsf@xenomai.org>
In-Reply-To: <877cfsskke.fsf@xenomai.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5949:EE_|BN9PR11MB5260:EE_
x-ms-office365-filtering-correlation-id: 28f0e136-554d-4dce-0033-08dc766e94b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?6WZLjwxtkbFhS3misHD5Tqtwr0dwGo5zVMtSP2s5nzz1EeiCTHurqexv/nQd?=
 =?us-ascii?Q?A93Z/0K+//GlXo3qJyTwahBUUwsK7Loejjs7bl3fS+hjB7ZiEAhXBFEAa3t1?=
 =?us-ascii?Q?Vr7DTfYp6Sldi0C1/GBMUZdv0qA87Sdh1tYBbp85p003EnGVkBxD3f8ePp6d?=
 =?us-ascii?Q?e5es5rmHGRfEHAPHRcR5ZQKvl0f1n7bi+l8v+k5AHR/07mXyiG5BDZX45uOD?=
 =?us-ascii?Q?j1/ymHJ5byL/SM4OGzYdN+s05tus0lZipUpvyJBMuT0roN7Euuz0Tips78r0?=
 =?us-ascii?Q?B/Ilv4zXsUlude6hjgFvzHRtRvlX071y2bqpR8ViBUYnimAJ0VyTkG+6wPf8?=
 =?us-ascii?Q?4UfJ4BSPTq2mYeZSY+nLmQu59+tPfMC4c9CFvIyLu2QfAGW5SWQjPwp3kZmr?=
 =?us-ascii?Q?PZPwXxo8UQA0dSxBRUOPswM/GR4C9EFPUFNwpQt0qjYBnOrJMNmlq3yuQq2r?=
 =?us-ascii?Q?tjfqd6AqAm1dXb6TzmaneqJG1pJdSJcRPAb9zZ3hj377K8Fp23wQC7W1nXqh?=
 =?us-ascii?Q?xnbYrzxQhNnx+4hK3cyVoBLjnd1aPM1u8HrkVlUkUvp7YY7Huis2shOXnpDv?=
 =?us-ascii?Q?DWw1wJqyiTauWmFS5NAHupbZ1p/dWWhGVi+a43MvxONEw0vj2Jy5k7o4sRjE?=
 =?us-ascii?Q?Pa7evw14SBTB9AWy3Yz3sQXIuaxw/SsaRqUNlPjM/Kp5a2uAIAi7DTso2PpF?=
 =?us-ascii?Q?btXvsE+bgTF5aPVQ/696KwZx4ljY3LqUQuAn89RMqa6kupbwtWWoqeO5d6Gf?=
 =?us-ascii?Q?fNgNfbUQdvQoCxSYK72Frr/gDpLQ5uHBCDVD57/QYGy0ysRfaIitS5YCJXUE?=
 =?us-ascii?Q?+Oly5Mi69t+RQtuODnFNkDBRGKJo+7B+HEuzORLJLEOXFEdrFNRc5UsFhhil?=
 =?us-ascii?Q?+dnN9mkyP45ZLcvUHxp/l+Czfr5gcaiyUtx9TMiKEZ0G8aE+cysS5fJ5MwU8?=
 =?us-ascii?Q?BbgM7Yr11FwWb6P+GLyrUYntoL6MwX/rn3hzREyaq4TO09fzYex19i7l8ux6?=
 =?us-ascii?Q?nz8Gg9i6g9pu7qUjClBG7xw4oj+sk4LN5aovrc21HRHhcy9OsUrwOE95FBaE?=
 =?us-ascii?Q?kbZcOT7pZr+QZFF93rP6KGXJ4ZPNdyjLOAfgahhYX1TjJz2jqlbI1Uym/iEO?=
 =?us-ascii?Q?XnT0onOj2oeFoYE1YJHzCNfhkVZ2KNX7dFw0C6Jlh7/r373uJ/7MA0mOVkq7?=
 =?us-ascii?Q?dlcWufriffmLOpnHjKOq/847dIlRsTficjQLY+lbx1jPsfxQPXypfVX9HFH9?=
 =?us-ascii?Q?jqADAyKQmv8IUBQiL2StuS85domq7ZiNViuzDRLCOZP+Lf37fL9PWAzkDGUL?=
 =?us-ascii?Q?DXgyeMJtHMhTRWAHTfHHlkuWdZ5Zw/ileXdx2gQjQHw+aA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5949.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nWc0B0ODF2J/2YSZLz9yUu7KKsSZRcOlHXC94c21lunEREC4V5s1ve7cgyk+?=
 =?us-ascii?Q?GqF9K9CZ8qH/bi5zOA59P/jdRKc5MsyWYZYoma/dtgUXP2CfTsY5+zmKzfwS?=
 =?us-ascii?Q?dNdQn4rxim9F4JovaFMFHbFwYAKYrJdzE+OxUQkrMC7X6n/HmKm1VnOicNhV?=
 =?us-ascii?Q?QRtPXFgsegcldCasHszAJd9Y054hNFphWunSgoUwQIUPWZgeuEhldciciiiC?=
 =?us-ascii?Q?0aFbBsUn4YZ0CPJVKDOw2r3XG8s4fZuaVnzGoOZvxckhz8MICfqNlf4alo1P?=
 =?us-ascii?Q?4vVWqpWcik+L+WhkvnF/nAx62Gbz1CmNeSG371jzrdS3WqRj8AxtQccnhQzD?=
 =?us-ascii?Q?ToKDbgFpIaDo7f9Ix3EC0AGoe2ftqyVh42FCtVVGJ8gnUxge6iZKmJamzTfJ?=
 =?us-ascii?Q?AchfNQpJoWBHX0Fa/UJtNVkYcS2rwoPFacBXFqOQvFwKVW/T+9OhDwNV0dI+?=
 =?us-ascii?Q?yzKwtiO+0AMtgzXpxf3l+RJzMbKoqp7iwtO3Hd6vgH9rN9IEXHvOophsa4Oa?=
 =?us-ascii?Q?x3a+p4YyWfDbOfMD/iKlddAItBnWkPw8akMDmHBRyoA5CTFa+vfIQiFbBZXW?=
 =?us-ascii?Q?oggzueuxfQfnp+3eDu7GqtkxFHT/ROlz5fcRW+aycfKxoJJOKfXjaLMz4HEd?=
 =?us-ascii?Q?yDYRKeZm3gk4VQNJ36Oc8O4ffnUvGVwSUovppLiZjSV3ykT/NSN50GxyW1cq?=
 =?us-ascii?Q?GjjVZXRBzC8iwsJ0x9osEmP93/wi05H9dgPzE3vttfKObD3UUTd1fdgC/cPn?=
 =?us-ascii?Q?UXnaWKtkDq11FlTK7EbNm7HR3iTcNInqBFUu3MhxyuZBB2EGytb1UbvOPbPu?=
 =?us-ascii?Q?rDx9zukLL91QQ4uxGnrqcoVqDcZhjHDDSXkPo9bzw9BnaiubnMl5Z2x65GOG?=
 =?us-ascii?Q?kLofG4GhjItwGXV/JPLIQzcstRUo1kaPLuqM/9WDNa70Agl0icXaK8zebhDY?=
 =?us-ascii?Q?Rtq1DRd1XRhQmLxZ0vcwps7WH6cA5KhQJ7cY20SyuIXS1FRcLvt0rJFMsuzb?=
 =?us-ascii?Q?D1J20CaOFIe+j7rTY+B4NQqH3jNVevhqDC7EFRdZrvGPjOgL16x1n365DgoC?=
 =?us-ascii?Q?Ssv2ifZMV56daqOtMhxT4n9JvX1XgJFQErO8wEoQGr64AmnX7inqcmZOgeL5?=
 =?us-ascii?Q?SKyTDh++ryLKOmlNyHRBd0J1TrqNRKN1CM7UrdUmfAHutkZtB7lJPeYdtgfD?=
 =?us-ascii?Q?PesXT2BEE9+ILMNDI6MC2/WRgQiwRDoaucogoi7TmaLtw39wsT3dP+Y67rn0?=
 =?us-ascii?Q?l2WtbdAqbiJAkPoNGpo3s3rOplAYzNtNzFcyicFlDZEPs4v+EWyftn5xM02O?=
 =?us-ascii?Q?ke12P5JCpGkRz8Z2fOgvoLlqM7sjXL3cR5O/ve+BuDWe4nbPkDzrHlC0tgBa?=
 =?us-ascii?Q?tSw/OOgQ3RIgbxMSrRdYdRTN8LbwbFFs0Nbkb2qlcvBvX8qVoZ8HOvPGwZp4?=
 =?us-ascii?Q?KPRVCFGW1sAVcmOggvQsEgERsc1x4uYG2AYmdy8rWzKbjuTm4ilQDXl5PU8e?=
 =?us-ascii?Q?vPMpw5yX5Jt8IpbqfjIayj+sQyQaEKlGOCWKBn3s3BMHHD6/9VScQpkq3/dH?=
 =?us-ascii?Q?9k4JaZWJAMHfzIdxTJqKRinBcGxdb9gjR56mGaWd?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f0e136-554d-4dce-0033-08dc766e94b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2024 12:40:49.2692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vfLhlFGgiUZE2OcJOmI4s8eioHsRBqiUkZhbV0XepgmKjPI9xtAnrwSMxfRIphTg60UW+WudtsRDANCs6To8jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5260
X-OriginatorOrg: intel.com

Clean now in dmesg.=20
Warn message not appear.
This patch is fine.

But I notice issue on compiling CONFIG_PINCTRL_CHERRYVIEW at builtin option=
.
Kernel failing when CONFIG_PINCTRL_CHERRYVIEW is =3Dy.

I use CONFIG_PINCTRL_CHERRYVIEW=3Dn to compiling your change.


Best regards,
Ionut Nechita

-----Original Message-----
From: Philippe Gerum <rpm@xenomai.org>=20
Sent: Friday, May 17, 2024 3:13 PM
To: Nechita, Ionut <ionut.nechita@intel.com>
Cc: xenomai@lists.linux.dev
Subject: Re: WARN Kernel v6.9-evl-rebase - do_int80_emulation


"Nechita, Ionut" <ionut.nechita@intel.com> writes:

> Hello Xenomai Team,
>
> I notice one warning message today in dmesg, when using 6.9-evl branch.
>
> Output(dmesg):
>
> [    9.807115] ------------[ cut here ]------------
> [    9.807119] WARNING: CPU: 1 PID: 1473 at kernel/irq/pipeline.c:303 inb=
and_irq_enable+0x21/0x40

<snip>

Could you please try this?

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c index 3d7be5=
7150174..8f5a460d7fc00 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -259,7 +259,7 @@ __visible noinstr void do_int80_emulation(struct pt_reg=
s *regs)
=20
 	nr =3D syscall_32_enter(regs);
=20
-	local_irq_enable();
+	local_irq_enable_full();
 	nr =3D syscall_enter_from_user_mode_work(regs, nr);
=20
 	if (dovetailing()) {

--
Philippe.
