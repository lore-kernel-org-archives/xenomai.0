Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A479F52F80
	for <xenomai@lists.linux.dev>; Fri, 17 May 2024 13:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715952197; cv=fail; b=Y19jJ7GABjGAxXM1rSLblX9TkvtVaAqGEgwy/32B0BzwK4wqpKGuMJ5WpSxB3c9oixan197O7gXSBaXnHukeJh8wu2jEWZc4Z3qO9umY8+IbUhuXt5oduOiJ+3P8zL0cdVWtMXt0JNwV1Oev5MwBRCfIH3+E7CoiuCgrjWh4WAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715952197; c=relaxed/simple;
	bh=MPJZt0niaG9DGos3iPVjj36BDIxfYNVM4HExyrUnY84=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AvBuaHpEBW5YTIGgHxx/g2Wv1u1u4sbQNEdQqSzp8VgbHKRbUs0SrmuIeGbOEHV1D7fb/L4bWlD5Vwj+KlJRwBBQx0fVGcrAev7GUUB+NsnIzTYSBEiSIvkPibPr6RE4fByW1cudH75xaiMSbNoerTRT417gu8ixDqGQPedzqtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bXjgP9xn; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bXjgP9xn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715952196; x=1747488196;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MPJZt0niaG9DGos3iPVjj36BDIxfYNVM4HExyrUnY84=;
  b=bXjgP9xn44wW3gf3+fpSuYEr/WQXP6REuoFcBZC+R4GnGkY2he9Dahjc
   U/akmK9ctrLyZFwfeVSF0JdJdUGupH8zHG73NLVKc4UQi9sSghOtF3Zzl
   VSjTrPxGhT09jGd6Xv27GCduvwctDAk1aVZ1pF4KLYr2nyYaRlNm/DziZ
   RHyRjguHdVI5WMi1scQ3+obN5xdsdhwPKpslvV4p8tQfCngyEBn5aYrp7
   lngOmkn4Y/51GJ7auhwmLAQSzPxq3o6FdyjCe+HiGlBmqR+uYcjsch/LJ
   TX7ganXPjmIAxBg92fnq9omg4mjB6iGsvzpnGONyP8lhAIndw2ERxjdFC
   g==;
X-CSE-ConnectionGUID: uTm9lRcFQ+CQwzeCfRfVUg==
X-CSE-MsgGUID: ZEgoqf1WTgGbQtB1EfbBGg==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="34642453"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="34642453"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 06:23:16 -0700
X-CSE-ConnectionGUID: oVxC0DcyTkqT9YPFLbI2vw==
X-CSE-MsgGUID: 0qd1npjVQOa3X3VsXRsctQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="36536598"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 May 2024 06:23:09 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 17 May 2024 06:23:08 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 17 May 2024 06:23:08 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 17 May 2024 06:23:08 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 17 May 2024 06:23:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/Kmyfvzzbb2f28LaU/yO4CiSyaC9lXfWLX2CKikscfGcUM8JrC9JKYkkvthNhCuqyamw46t5ryYmavGe6b3n4MM7xqF1a4dAstrk9DvEccRnZ55ayipVKaJH/uMg8iWGpJHrQb2y6E4Ptf8Qh1nuQVh6gZ+qxclmqngwrUGdC3a2/7HVfgyQPkjcQt2yW6CjPjWD0pV9u4lUtGpf9IhRFnSKcln3iOBUhH28hyPrPh0TpOxfM6eGer3uvC3Eis8Xs91sMe1dgYScgwwKKatDUWRjKnE8atYaVlOY7oNuMBSwKZh5MezG1JTAbVeBLZ3ylMW02gqBaBZ+ctfkK0LMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPJZt0niaG9DGos3iPVjj36BDIxfYNVM4HExyrUnY84=;
 b=AbOjhyrdRisVI3OkUOW/jnQ1oNRan511K7KzmxAzC5HJgPShsjmM/mw4ihzfsqVN0uc2hANVzPPNp9Dg25SmECQ9+h3ZkfsVJS2I8jXwaY1U1mtVjfbQPwQZ4wmI3TcPDJ+KXHn4N7UeYS74XAEHQnKiYEh8k6O66h1eswbTvK6dRbyA+B5fw14f/Mr+up4rF4dm7T7ZilPsaCmIU8gi+5EMYjQ/lQgONHvhVdndYsNsd4q9sObSe4v9v4MNjcNEI5Ypkv1SSLCgDm7oPck28tIXWozEuNabDEoFH6Go1qsWSN5KNveVuyIY3OMrWeDraF7+Y7SOi5dD7OGvF/8lIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5949.namprd11.prod.outlook.com (2603:10b6:510:144::6)
 by MN6PR11MB8218.namprd11.prod.outlook.com (2603:10b6:208:47c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Fri, 17 May
 2024 13:23:05 +0000
Received: from PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861]) by PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861%6]) with mapi id 15.20.7544.052; Fri, 17 May 2024
 13:23:05 +0000
From: "Nechita, Ionut" <ionut.nechita@intel.com>
To: Philippe Gerum <rpm@xenomai.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: WARN Kernel v6.9-evl-rebase - do_int80_emulation
Thread-Topic: WARN Kernel v6.9-evl-rebase - do_int80_emulation
Thread-Index: AdqoUB42H/OnAc6gQSyqVaNVHGTu7wAA2ngAAADkauAAAU+/AAAAI7fA
Date: Fri, 17 May 2024 13:23:05 +0000
Message-ID: <PH0PR11MB5949CA43AC47E322BE97B5AAF4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
References: <PH0PR11MB59492DDE7F2301CECFD2D8A9F4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
 <877cfsskke.fsf@xenomai.org>
 <PH0PR11MB5949EC28B447C7534BF8292DF4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
 <87y188r32a.fsf@xenomai.org>
In-Reply-To: <87y188r32a.fsf@xenomai.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5949:EE_|MN6PR11MB8218:EE_
x-ms-office365-filtering-correlation-id: b2ad3070-d11a-46cf-3175-08dc76747c73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?hDutdtl/S+T4viJnp9KxBfg+NO0fgu/F2MJm3f13WOD5o0lD5f9VZRzA1iV1?=
 =?us-ascii?Q?8YjGvsv3w02U4YOdHhNCufRjIKrfHplX6kEUZJN2z+sEG7fYkqL5V30a2VMn?=
 =?us-ascii?Q?2AqhB+eaRl2fxZqMjJaHULZ+2nMWKTYTaqHKUa/gtjUmx38YfreqO5g7nnGn?=
 =?us-ascii?Q?U/cS+1aKgpNR0kxXYiFL5F6FiBRdIbiJsTkOrP+3K6/0OlxvfHtqA1U1rCyM?=
 =?us-ascii?Q?e53O322ANQ/182iaTPOvncKZu5q6cZU/RR2NGcx5DDpFA8pYtu6dVdD5/bKT?=
 =?us-ascii?Q?7+HO/JrrQ5Vf6QML8GQsS/7+RHd99HQDr/7SlR9ZJBqT/lTIMbwzjtSIITgw?=
 =?us-ascii?Q?jybWYw0hA4ENNrUTiaZ8IGmbaSJLLs1qoz6Wgz/Y8pYpzOCyNIlNHB2/pxS4?=
 =?us-ascii?Q?TNPYOfzwDqBzbZdhJ5gOOOjeXBH/k7S2E5RKhWZ9N7z6dF3rNEgNF8r7biDO?=
 =?us-ascii?Q?F/4YUsrtfVYpMKEGcfixrYe/Ni3E1fSgb1CGmZvPFVMEQkKMIPd5IjS0gb6k?=
 =?us-ascii?Q?8QuJTtYDAGmFzM3a+lSFqGu9bGsA8LOSDAYUtsf585yCXi4CVUpsiwyTfp5g?=
 =?us-ascii?Q?zjIO6n62uvnU2jG5qy+zvf2ydX26ZogMWjcRmIV+HmSNiF+KKDCvVesgllgF?=
 =?us-ascii?Q?QKx/k7JEUrYU3EyFkYX1RQTYvj4gcnqe0AB2SNjkdNTegkP2ai6pEJZLwHyZ?=
 =?us-ascii?Q?c55gNA4PJp9SEcUFWA3Ync1l2p4059W3jxvfqQ5GuU38KzOUrdkl1E3zObsJ?=
 =?us-ascii?Q?erpaCm16ZYD9mJWDUfdYFxcql0wqr2+37cAaEV4J+c9SkfIaz+MWr6XB8vRK?=
 =?us-ascii?Q?IpYg+BG7Cg4FlVoYBz4iLK+j9izRxEstJDpJkcdcz1EZk01Gisd9yyxwWLLJ?=
 =?us-ascii?Q?nbyt8GP8bDfA5mRZW6aPqGQaJS7gjajnC9gYVrgPVbdQiBH+rrlgiLt/na2t?=
 =?us-ascii?Q?EAjlqvua8KXzkL4LnTiwwbybrsSMD5SrAsx1aCXVt4sXw47fz0St06yj6hhW?=
 =?us-ascii?Q?uNsXK3KarFLLiQomJgK7ahh2FwKjorDBXjuFqMdwtMszFCcMRR7brYRUZUir?=
 =?us-ascii?Q?zAWdCCfZCY41jXQkm7gnJBYrgWPa3SyylndK5HNmtPEL1jxH+2Fz/kVg5b8i?=
 =?us-ascii?Q?YcTw+R+PM3mDkKIR3fyd1Cd8crlaoI8+q0KW6Up3+NtQLzlg7GWLWhajFgoU?=
 =?us-ascii?Q?lyrTE2BItwsZqEWwFSieyikLYD2zpz79ACosjrEbc3HNmLaqy5nwKIkCWsEw?=
 =?us-ascii?Q?TMELmB/3eO8u8zNsCD6CtRu/emg0H9z7sxW4OPFcRkBoDKLFcZJznN47OaRq?=
 =?us-ascii?Q?dL+DjH488omcQEP0izR2pUxP/uhiYg84hZXv8DfNSOtCtg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5949.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WR7o96BZovT/ze7c75b4p3aNVec7MoqIHL0nN8Cn6UnNo97Juey48KU641lY?=
 =?us-ascii?Q?f4zlWw5mUAXKqnutSmV6ey4k3GUAB/hrW6lvE0ffjY5JdvE7zTqcHD01EuuP?=
 =?us-ascii?Q?2XEM/XU64aoKZ07rY+fS3bbO69bBf0XFb2ww2T+iSK560eRN9V5RMaPZQh/P?=
 =?us-ascii?Q?Swa9TG4aBqfdOfQ+y9lJdOtdIvoSFIeM06kVsLVObRMw7YcuYjyDQGh7wNOq?=
 =?us-ascii?Q?HKnTzrRB8XkXis9YBJHVbT3xz1ni8cRnEuAX4bk4tkyqiLzH4rf+D+tJ9Q0M?=
 =?us-ascii?Q?geRi6VxsBS7zuGZdumw+RQhQHxKTuLm/sHesz4SSsmU5NM97v3pu0AKUxPf/?=
 =?us-ascii?Q?QAv4zmZKIDPvmZzH/zxCAgEMXvLcm1IoiYw2asDczNb9b1SssmZWy8g+ltsR?=
 =?us-ascii?Q?bF+XLFI2p9AoHPyhHzNtFrjx85eh60Ss5LFCKaXIMPPudXwYAL7h6VYwgggb?=
 =?us-ascii?Q?Z/K3ecvP3kyT68ok3ZRW/0Z0EcQj7L5jpGvyDIKv0vGpzvJO1xQfLTOb9tiN?=
 =?us-ascii?Q?cN/Zuug4CHXjEmYeKFHWAigtkg8s95Bx/SzYQOhy9SgOCQodgh0M//TFvg1c?=
 =?us-ascii?Q?0ZUmN8RYmx1XCZF0RRcdka9X1qrWFmRdB9Gfjwqb/hns4jLsIOSpNwnbWaDO?=
 =?us-ascii?Q?6jpsv/qF9e6B3JGC8eIE+YjFCI5hDcE+ak5pUaZKnjVI142WR0VBKst7DiAS?=
 =?us-ascii?Q?rxaWC42spiVB7mLNfLsnradEXonypTrPtk//yH4Vqs83TcGIv4KK5ueGmLjn?=
 =?us-ascii?Q?bpZQPS3pXfw8lWVLIPjltJW6jeivU7wsz+8p5QCwus3IwF476M4c+cDNuVB1?=
 =?us-ascii?Q?XdtLaftLGX0dzE8lCUrR/2Ps/FZOI/mTqWWNdFGXth7CBFVOjva0ElPXXgbi?=
 =?us-ascii?Q?Z2RcKNLEtEZbV2ZIy42f/T3tAGrqJe7JPzDZr9k90wayPDTXYulsV8A50Ubf?=
 =?us-ascii?Q?DAqWSyH6ST2B5Oh80J/PtJQHN+QY1ShGXjSC0ThWYcnJJ4kP3CdQURT6FHBY?=
 =?us-ascii?Q?eHfYwi9ZwIocICsw+a4ujtP9WzF+sT3l8izBuELngnc0EKo5Gy7wq56jbgJw?=
 =?us-ascii?Q?kDKGFNeS7AEwT8qLxT+q4ImEjIu8Nzl4TedBpCipj42RNlFCidWSOZusP00G?=
 =?us-ascii?Q?rv8JIO0R28+oQOIjwy6MdHZ709va2ILsdJei+Oy8PfwtEQHyAsuvHUmNviP4?=
 =?us-ascii?Q?0LjKwYFPzJKhLZ/FQim/2Fm3TAH8W2MIftAFJlAj0/i8+iJMcdHMKxytJnQS?=
 =?us-ascii?Q?R5HyHvNOtKzStN+uCYAt9VVs3JTvk/d7ZFg4ax9y1dk4HhWO/CzPLJ+zf0h5?=
 =?us-ascii?Q?E7uwj4Ygow7Q00kzwWNgczUQFO0bVaPcpWzyge9GB/ujf9uPlDxu18W2vyca?=
 =?us-ascii?Q?Y/zWnbBnvPpkV29IuhofTD2uGPz4jnSNpFbiNoNZQhgGN9PL8BTsZGVX2Uqx?=
 =?us-ascii?Q?4ZVJK1khpYawbjT4wY3dU015NWOmMaNJ8TTTrX4hvt8AXf4qRddkTE4tf9jO?=
 =?us-ascii?Q?WG5rtwxQuczVp/5/6/R2/EIiGKxjKoC5Cfpomm2wbkH97H8iNw/pEJnKSoxe?=
 =?us-ascii?Q?XEJJ+uvwVOIDnfksYL5pZnqVp9I1NJUUh5O+48Ub?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ad3070-d11a-46cf-3175-08dc76747c73
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2024 13:23:05.5525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pR+Vak13h5hDVhjEVgBDBMbufsUw06LB5rfzxqlBi+CY7gxO7bUdk5fpOBwBKKEZbxYnPl+I2LfZ6iltjECbLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8218
X-OriginatorOrg: intel.com

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
