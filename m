Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FD13E49C
	for <xenomai@lists.linux.dev>; Fri, 17 May 2024 11:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715946554; cv=fail; b=F3w7RfSx+syPylfxqiBsUn3QIPnTvgdh1ucwc31oJGc7QaMNt2A+SQw7uB0PCPKDDafCZodA0JR1r6cvxJEJhL9YzwsPBEceHbviSjWZN9GvvdL13U1iBvC4CmxBH9tHzZ6adOdJYZpi4bMkyDw3WkJVJ79Cv8rgPX5cDcqGgMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715946554; c=relaxed/simple;
	bh=/n+kTNNchGH3XSrlC7i6V7wqZI7z/D6lVgR44nvfDa0=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fj/+aMnp72bBk8tLZlQ4of8lSnCbAshMRqbyFSauccKBcHAoH+zMU7rQi4vFoOz+DDHICFHHctnc3QNUkUR7bJwN50g/QibDkpHUKEjYbJdpX4c2E/H5i22YOYifB05xDaYidR1qPxDV3m9BOyWP+jLtWqrLuu8GIyOfYJfKho0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QmZ1HliD; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QmZ1HliD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715946554; x=1747482554;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=/n+kTNNchGH3XSrlC7i6V7wqZI7z/D6lVgR44nvfDa0=;
  b=QmZ1HliDccx/3WLAv30wRsGY9BAeKqVM4aVterOc1Wcy1IEZoSZw62Vg
   aLj0te6LwnDEaA4rzEv64mcYiFOjy3yvO7xNBLrD005cbiK33JucsHhde
   yjMNmtaOx3hsc3xG+VXLruaNn0P/cKnyFaAimMjPFmAPSFBCQY0RsrWuJ
   DDfQRmbigAFSB3Kt+Ocrr5nSXRq2dv3I7dBUGn62l4FNGBJE65UvhlNuN
   3KnPP0iZxblFeo+1W4SSzghRZVyJ5zM0xYuQiK8+sposnXAzsUTz+01JT
   OsC8EEuIhvhM8zUI83IfAU6KgN9r/Ph5Rm1vjI4JCjThrhegoYYZSniG1
   g==;
X-CSE-ConnectionGUID: HzIZuik8T9CWtgBMN62nbQ==
X-CSE-MsgGUID: kIETHml7T6eUg5QzQ715QA==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="22697639"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="22697639"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 04:49:14 -0700
X-CSE-ConnectionGUID: QjFDx0OXQsKDGaVaoou15Q==
X-CSE-MsgGUID: 4SZOQwCDTniyVCoQdjWVWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="32186877"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 May 2024 04:49:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 17 May 2024 04:49:11 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 17 May 2024 04:49:11 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 17 May 2024 04:49:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRIJfSATg6EghbqAQn6Wt4yirW2kU8S1R+YDVfCRTxiF5YDnV017ZsZUjxE1r7pTzZfJVUEzKptZK0UeTyRWa6xxKeRmyh6BNFVj/NYi28/npTSIyNZ/cNVJ6/xMhgyq7kLYJxP6WU/Vj8mFVigpGZi8/M+RMKVrJvcYfNx3tHKjb9hYw64IIEdVmb4xKCytXtP3EGZr6zh/rPVcZAI8ewNnPCS+VzKoe88wNOP/7HWebZAmnNTXvy2bWb/US0HVAAItP6gddb5nbd6KDy1TKuyS08qQx4dn/NDCynV9urIYTNbpc9o97BIP0fnpQ/lW82o8xGKJPMvEnNk3kLm4Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLCyqzjmlCsHWLjmT4Tk8+OeQFyjNcU3Linlq5Cn0fE=;
 b=eL+nP0hFRKbGYQZi7n4CsBUAmspuiHPUhx1OObmEy0bn8iJi7k/3Pv/7JzftwTZmMeShQpDP3I00yrIlb+nF9qyHn9XhU71afEQHiNdW7Yziob3yP5OWOOcsMqQVzLfoigO6QHulvN9CsYEpR+CNsPvoDrYc+CBEC5e8bbKDIVsyxeMzm5VdVY8zeilA1ViXISRJf/HNXQxPnaX6TdhSmRM51JMOtZrI+Que0xDxQQun4gZPwPBEnoCdzrbEK1qMtuBMJCK4tGtpij0+Bs+UwW90WfVxffIGKDqix5PIEBYTnZvRSjnZWx2e53mQBVDg8WsBUG5m4o1qDNMf/HIwTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5949.namprd11.prod.outlook.com (2603:10b6:510:144::6)
 by DS0PR11MB7682.namprd11.prod.outlook.com (2603:10b6:8:dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Fri, 17 May
 2024 11:49:05 +0000
Received: from PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861]) by PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861%6]) with mapi id 15.20.7544.052; Fri, 17 May 2024
 11:49:05 +0000
From: "Nechita, Ionut" <ionut.nechita@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: WARN Kernel v6.9-evl-rebase - do_int80_emulation
Thread-Topic: WARN Kernel v6.9-evl-rebase - do_int80_emulation
Thread-Index: AdqoUB42H/OnAc6gQSyqVaNVHGTu7w==
Date: Fri, 17 May 2024 11:49:05 +0000
Message-ID: <PH0PR11MB59492DDE7F2301CECFD2D8A9F4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5949:EE_|DS0PR11MB7682:EE_
x-ms-office365-filtering-correlation-id: e44ee534-ffcc-4d47-cf6c-08dc76675a99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?InEQy6UOOs11Szsztfj6PFl8JE/A/u3eXmyhHN630NAHtf3nS8xgv1tY1JuO?=
 =?us-ascii?Q?0KHKWTUY7VYyUPpj/5pHJKXGpX0TcZc83oGpD5ikHNWbuoram6xBeNH23plO?=
 =?us-ascii?Q?p277JyJNSh7Z9/JDyK+N9B7FJAdtSWkIX+7z59JLYru6VB2Ka60lowx8db+7?=
 =?us-ascii?Q?QKe7E4AURkBoYDmZ7v0HA4AZUk19zrjO9CqsMU1tIkd3sP9oupXC6isJK5mT?=
 =?us-ascii?Q?VBBCFlKq5bgdK53n/uqIknnmokh05zmRYngQYy3vQSY9hk1rA4eTREes3ikg?=
 =?us-ascii?Q?/X1dwfARrYgApIZJc47T9NAzC83zwv5ZYQWVoEZwpd9XSS9ZDUwC3nsCEICZ?=
 =?us-ascii?Q?2LsvKpgwwA7Rcq1BFk+fxbOqOHyWZcKenpeZFmXznxd/vzXA13+b1GeKGN3Z?=
 =?us-ascii?Q?XJuBgN3nHg4VNTpke7NiIWstlA52aiarvQ6qrx7yp2ANigBg4EvrPgSgbkV9?=
 =?us-ascii?Q?NNyiFAYcvAQjnNsFRYASVgm9wSK/9VY3QvGcsLMQzEbFCgFLneZP7PKBExfy?=
 =?us-ascii?Q?DyIpTkG3pkHg3rQpTmPKg8sZAA+zA77EzJB6IayMNIV/00dl20hSR+BE3RBX?=
 =?us-ascii?Q?z87z5JNDzKFwTA0ijfCjJXRGkYxGZENAAy7lmuShOHDFxFS30e56dEUBxIvY?=
 =?us-ascii?Q?uz6/spiDw36aBZLVMdgtquVrKQnytRhuEiFIPZiyHjoP/1CywINKehV9Qaow?=
 =?us-ascii?Q?tXYS/WODeYuFSUFngOCsTmur8ksqAu8L78LJOCsT3G8AkFrWQKtJx5v9Eooh?=
 =?us-ascii?Q?HXrr50pUoK3t4TJ45eNKEUaXQxczYMU9EFBe1UWacXpBohsahBhvfbQ/LbKe?=
 =?us-ascii?Q?atCRAL9ciWn4tsYepP+sgiV0RlFtLNxAsQJmlfsBD0lHE7H6wueihV7SU0UZ?=
 =?us-ascii?Q?GBvdRy/wrSTL8S4ygrV2s+iqxJ5alyH5nmUB9BYtHgUVc2+5kg/qYBMl41uE?=
 =?us-ascii?Q?MIQR39W2P6zBPV+/VdlO9w3v8aJglE4X9ww1bPCk/L6V55OrLyub0OXfNB0O?=
 =?us-ascii?Q?x2sNVOGjSizaGOW7xcuHLFW1jXVrmuKSL/VUtchgTfnziub178h4cT+GI4UY?=
 =?us-ascii?Q?0lQn/ODNPNYC8Fzno6hfr4MVPbtkuoiaysUsRktVJ0wGN0to8EjySH97w7Y5?=
 =?us-ascii?Q?BU0LU1Gt4B+2KUNETRxMydQ6b7OrqaheI9o9ibIXUJSnX34qgLxk3ldGPbu7?=
 =?us-ascii?Q?EA0f8icvQ+xfM9DXISuexVQmhB2CA9oEkgDd/m5ZaTV7nZcdbbwq8HT5LmiI?=
 =?us-ascii?Q?RmdLEhuabz93IP7wakFMkRQ/pUlMFQTRzBCsvaO6KXW6SApW0pE43Py85KiL?=
 =?us-ascii?Q?XX/FY3OdrXMegXPD89U9236ahXx605yMf0J7Eg8oOCbkZA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5949.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qoGdl/u66TDLJORF8wrMHZM6P2CqPzIMPMHGemr+vWHP6HzI6bEbEJvDxMXe?=
 =?us-ascii?Q?GUJUZbiPam1GFwnE0H07t3+4Y06V3HuJkUIfvR2VyVSip6hxMNXbEWH5dY8C?=
 =?us-ascii?Q?I8B55weLeyszYnjSf3lmuI+K2BH70YjkoP+/MX7EtpS4HlwdbjockJTdxKaG?=
 =?us-ascii?Q?WAvTib6n35WR2f5AIpxC4TRejwmjl4LyFhSYIXQ2oWHGud33Xh1acWzpC3VK?=
 =?us-ascii?Q?lBVvDFo8zc6/NEukDcFmVItMJKqw3TzcbOxuSjYK5DfLLI8K5G+7756w7lUL?=
 =?us-ascii?Q?IAEUIYbNxqGEvoJ2DP2a+UlXFrK9DlBuLEq9sHLHFnc9x6Yg4S/98Q/znh1N?=
 =?us-ascii?Q?HcxjG1WWh83SZYFD+WRJXXMW4xvDaORaqbS70RprFtZyiBmqzESC5yROzzhZ?=
 =?us-ascii?Q?AjKab/RSWZ0TXDELkt2QRgajByix2S3rqAMXnUot4+4TwdgmpkKIRrkyuYbM?=
 =?us-ascii?Q?4EHMpycKxR0PdFFvj/Ebiq0/8Zz++m990q0aOafkxJTW7L1lbsRfNCnzNF2d?=
 =?us-ascii?Q?iSMW+jbLlQjqV2NwGhqKieeFrFLaGiCpVcr///SFOxjqkbAik0JKELs228xe?=
 =?us-ascii?Q?YE4qHj74T1FNnuYk8GwL9eMNEi57ZOTMMQiTveHZG7//5ly5CwfyGfY7iWu0?=
 =?us-ascii?Q?cCUaENzjf4y40Emnl48yhWOU/Zm4XEvsa4Y+tF8CL4QznVzsRRmnYargngmG?=
 =?us-ascii?Q?2pJ64s88ctpDB75+qFPO99C4vJlR0HHs3cRxw29DibgpDe7MdalC367bDSQa?=
 =?us-ascii?Q?pBI553gEkwfo+YR49LyNZgNVM3d6EqfNYHWTkTLH32S1kF1HwMSafrY3WS9M?=
 =?us-ascii?Q?n8r53Z24XonLpQQ5YIWKoUmWSMpyLHuf0wZxhYsARO46TbHyyfv9n5xECgwG?=
 =?us-ascii?Q?1Xhudb4c8QLVmZ/498xXpZD5aNCVNW1D6OFEkBs29e30gOO81hSVzO2S2aNn?=
 =?us-ascii?Q?+PWQsVkdL0QSy6Ud4h0wiEpcRZEjPl8mjdcKZE8OlBPmc47zcEzR8EVykEwt?=
 =?us-ascii?Q?o9PFR6UBR1kpAsPJQGGBsZbxl85lQexRbl9Tbhb4PFVJh7nwZyTChY2SC3iQ?=
 =?us-ascii?Q?KnyCDHxe4/4dyT9CZbp8hsHnxhyoMqE3CBFZjrg02OYHvOkGiExVSVMZxQSr?=
 =?us-ascii?Q?0QVLDZVxbUuhN3KqFl74ZmvtXM2j3qX0wETEjtLrtkRVtJ/K0LNvlTRHoux9?=
 =?us-ascii?Q?woAI2HwgQFSWwpTxFwbQeURecsKlGnlqDJl7N2Ja2yUXZ3L2iam2olc7M9VJ?=
 =?us-ascii?Q?O0mrjBJLporhQYC6RtAD2h5XvLfrNsPLRyJ0zc8nDOp2irnu+07xU/yPIcJ5?=
 =?us-ascii?Q?3VENWHioslpdpIcXplKRrXLwJNYJraXpkKX1BMDGZGtWt3/6BLrLBuPNB8t6?=
 =?us-ascii?Q?47fHmNKt206oQdXGbFYNIiDnlStsqrHW3VxS9SAQgTa9n85jKClNXiN/0LZL?=
 =?us-ascii?Q?uSU3HCZhXAlWt6tXgpfHiKvbk2l+wFcRiisvjDaUd+uaG+z2+rCZvDsQPvCm?=
 =?us-ascii?Q?J9o+BWOzmYxkcv2eprx31A7BY7DmWCM2mrtyYb/lSaQPQDQ27Wq76l8/r5QS?=
 =?us-ascii?Q?fUNndD1EOe5F5IixSmPfH2gxv0KiBc88pAg4Rtjl?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e44ee534-ffcc-4d47-cf6c-08dc76675a99
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2024 11:49:05.3271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eTB5IxycGGp27F9TBIpeOU8i5vvM3hADd0wDEAmgyO6nOs8ODHGiocxX0h3Y9HSP7OEahOoP6/kit5BQlxQIiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7682
X-OriginatorOrg: intel.com

Hello Xenomai Team,

I notice one warning message today in dmesg, when using 6.9-evl branch.

Output(dmesg):

[    9.807115] ------------[ cut here ]------------
[    9.807119] WARNING: CPU: 1 PID: 1473 at kernel/irq/pipeline.c:303 inban=
d_irq_enable+0x21/0x40
[    9.807126] Modules linked in: xt_conntrack nft_chain_nat xt_MASQUERADE =
nf_nat nf_conntrack_netlink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xfrm=
_user xfrm_algo xt_addrtype nft_compat nf_tables libcrc32c nfnetlink snd_hd=
a_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_com=
ponent cmac algif_hash algif_skcipher af_alg bnep overlay snd_sof_pci_intel=
_skl snd_sof_intel_hda_common soundwire_intel snd_sof_intel_hda_mlink sound=
wire_cadence snd_sof_intel_hda snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_s=
of_utils soundwire_generic_allocation soundwire_bus snd_soc_avs snd_soc_hda=
_codec snd_soc_skl snd_soc_hdac_hda snd_hda_ext_core snd_soc_sst_ipc snd_so=
c_sst_dsp snd_soc_acpi_intel_match snd_soc_acpi snd_soc_core intel_rapl_msr=
 intel_rapl_common snd_compress ac97_bus snd_pcm_dmaengine intel_uncore_fre=
quency intel_uncore_frequency_common snd_hda_intel intel_tcc_cooling snd_in=
tel_dspcfg snd_intel_sdw_acpi snd_hda_codec x86_pkg_temp_thermal intel_powe=
rclamp snd_hda_core coretemp iwlmvm snd_hwdep kvm_intel
[    9.807164]  mei_hdcp mei_pxp binfmt_misc snd_pcm kvm i915 mac80211 snd_=
seq_midi libarc4 crct10dif_pclmul snd_seq_midi_event polyval_clmulni polyva=
l_generic ghash_clmulni_intel snd_rawmidi btusb btrtl snd_seq btintel sha25=
6_ssse3 btbcm btmtk sha1_ssse3 drm_buddy snd_seq_device aesni_intel bluetoo=
th snd_timer iwlwifi ttm crypto_simd cryptd rapl drm_display_helper ecdh_ge=
neric intel_cstate wmi_bmof snd cec intel_wmi_thunderbolt ecc ee1004 cfg802=
11 i2c_algo_bit mei_me soundcore intel_xhci_usb_role_switch mei intel_pch_t=
hermal intel_pmc_core intel_vsec pmt_telemetry pmt_class mac_hid acpi_pad s=
ch_fq_codel msr parport_pc ppdev lp parport efi_pstore ip_tables x_tables a=
utofs4 rtsx_pci_sdmmc i2c_i801 ahci e1000e crc32_pclmul rtsx_pci libahci xh=
ci_pci xhci_pci_renesas i2c_smbus xhci_hcd video wmi
[    9.807209] CPU: 1 PID: 1473 Comm: check Not tainted 6.9.0-x64v1-lowlate=
ncy1 #2
[    9.807212] Hardware name: Intel(R) Client Systems NUC7i7BNH/NUC7i7BNB, =
BIOS BNKBL357.86A.0083.2020.0714.1344 07/14/2020
[    9.807213] IRQ stage: Linux
[    9.807214] RIP: 0010:inband_irq_enable+0x21/0x40
[    9.807216] Code: 90 90 90 90 90 90 90 90 90 55 48 89 e5 53 0f b6 1d c5 =
86 3c 02 80 fb 01 0f 87 36 bc fb 00 83 e3 01 75 09 9c 58 f6 c4 02 75 02 <0f=
> 0b e8 58 ff ff ff 48 8b 5d f8 c9 31 c0 31 f6 31 ff c3 cc cc cc
[    9.807218] RSP: 0000:ffffb419821ebcd8 EFLAGS: 00010046
[    9.807220] RAX: 0000000000000046 RBX: 0000000000000000 RCX: 00000000000=
00000
[    9.807221] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000=
00000
[    9.807222] RBP: ffffb419821ebce0 R08: 0000000000000000 R09: 00000000000=
00000
[    9.807224] R10: 0000000000000000 R11: 0000000000000000 R12: ffffb419821=
ebf58
[    9.807225] R13: 0000000000000001 R14: ffff9aea847e29c0 R15: 00000000000=
00000
[    9.807226] FS:  0000000000000000(0000) GS:ffff9af19eb00000(0000) knlGS:=
0000000000000000
[    9.807227] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[    9.807229] CR2: 0000000008049000 CR3: 000000010ec94001 CR4: 00000000003=
706f0
[    9.807230] Call Trace:
[    9.807232]  <TASK>
[    9.807234]  ? show_regs+0x71/0x90
[    9.807238]  ? inband_irq_enable+0x21/0x40
[    9.807240]  ? __warn+0x8c/0x160
[    9.807243]  ? inband_irq_enable+0x21/0x40
[    9.807245]  ? report_bug+0x1ab/0x1c0
[    9.807249]  ? handle_bug+0x52/0xc0
[    9.807252]  ? exc_invalid_op+0x10c/0x140
[    9.807255]  ? asm_exc_invalid_op+0x1b/0x20
[    9.807261]  ? inband_irq_enable+0x21/0x40
[    9.807264]  do_int80_emulation+0x87/0x1d0
[    9.807268]  ? do_fault+0x36f/0x530
[    9.807272]  ? __pmd_alloc+0x12c/0x200
[    9.807275]  ? __handle_mm_fault+0x746/0xe30
[    9.807280]  ? inband_irq_restore+0x33/0x40
[    9.807281]  ? handle_mm_fault+0x22c/0x380
[    9.807284]  ? irqentry_exit_to_user_mode+0x91/0x310
[    9.807287]  ? irqentry_exit+0x4f/0x100
[    9.807289]  ? exc_page_fault+0x9b/0x1c0
[    9.807292]  asm_int80_emulation+0x1b/0x20
[    9.807294] RIP: 0023:0x8049009
[    9.807298] Code: Unable to access opcode bytes at 0x8048fdf.
[    9.807299] RSP: 002b:00000000ffee7b80 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000001
[    9.807301] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000000=
00000
[    9.807302] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000=
00000
[    9.807303] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000=
00000
[    9.807304] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00000
[    9.807305] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000000=
00000
[    9.807308]  </TASK>
[    9.807309] ---[ end trace 0000000000000000 ]---

Lscpu:
Architecture:             x86_64
  CPU op-mode(s):         32-bit, 64-bit
  Address sizes:          39 bits physical, 48 bits virtual
  Byte Order:             Little Endian
CPU(s):                   4
  On-line CPU(s) list:    0-3
Vendor ID:                GenuineIntel
  Model name:             Intel(R) Core(TM) i7-7567U CPU @ 3.50GHz
    CPU family:           6
    Model:                142
    Thread(s) per core:   2
    Core(s) per socket:   2
    Socket(s):            1
    Stepping:             9
    BogoMIPS:             6999.82
    Flags:                fpu vme de pse tsc msr pae mce cx8 apic sep mtrr =
pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe sysc=
all nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good no=
pl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64
                           monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 x=
tpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsav=
e avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb pti ssbd ibrs i=
bpb stibp tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc
                          _adjust bmi1 avx2 smep bmi2 erms invpcid mpx rdse=
ed adx smap clflushopt intel_pt xsaveopt xsavec xgetbv1 xsaves dtherm ida a=
rat pln pts hwp hwp_notify hwp_act_window hwp_epp vnmi md_clear flush_l1d a=
rch_capabilities
Virtualization features:
  Virtualization:         VT-x
Caches (sum of all):
  L1d:                    64 KiB (2 instances)
  L1i:                    64 KiB (2 instances)
  L2:                     512 KiB (2 instances)
  L3:                     4 MiB (1 instance)
NUMA:
  NUMA node(s):           1
  NUMA node0 CPU(s):      0-3
Vulnerabilities:
  Gather data sampling:   Mitigation; Microcode
  Itlb multihit:          KVM: Mitigation: VMX disabled
  L1tf:                   Mitigation; PTE Inversion; VMX conditional cache =
flushes, SMT vulnerable
  Mds:                    Mitigation; Clear CPU buffers; SMT vulnerable
  Meltdown:               Mitigation; PTI
  Mmio stale data:        Mitigation; Clear CPU buffers; SMT vulnerable
  Reg file data sampling: Not affected
  Retbleed:               Mitigation; IBRS
  Spec rstack overflow:   Not affected
  Spec store bypass:      Mitigation; Speculative Store Bypass disabled via=
 prctl
  Spectre v1:             Mitigation; usercopy/swapgs barriers and __user p=
ointer sanitization
  Spectre v2:             Mitigation; IBRS; IBPB conditional; STIBP conditi=
onal; RSB filling; PBRSB-eIBRS Not affected; BHI Not affected
  Srbds:                  Mitigation; Microcode
  Tsx async abort:        Not affected

Lspci:

00:00.0 Host bridge: Intel Corporation Xeon E3-1200 v6/7th Gen Core Process=
or Host Bridge/DRAM Registers (rev 03)
00:02.0 VGA compatible controller: Intel Corporation Iris Plus Graphics 650=
 (rev 06)
00:08.0 System peripheral: Intel Corporation Xeon E3-1200 v5/v6 / E3-1500 v=
5 / 6th/7th/8th Gen Core Processor Gaussian Mixture Model
00:14.0 USB controller: Intel Corporation Sunrise Point-LP USB 3.0 xHCI Con=
troller (rev 21)
00:14.2 Signal processing controller: Intel Corporation Sunrise Point-LP Th=
ermal subsystem (rev 21)
00:16.0 Communication controller: Intel Corporation Sunrise Point-LP CSME H=
ECI #1 (rev 21)
00:17.0 SATA controller: Intel Corporation Sunrise Point-LP SATA Controller=
 [AHCI mode] (rev 21)
00:1c.0 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express Root Por=
t #1 (rev f1)
00:1c.5 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express Root Por=
t #6 (rev f1)
00:1c.7 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express Root Por=
t #8 (rev f1)
00:1f.0 ISA bridge: Intel Corporation Sunrise Point LPC Controller/eSPI Con=
troller (rev 21)
00:1f.2 Memory controller: Intel Corporation Sunrise Point-LP PMC (rev 21)
00:1f.3 Audio device: Intel Corporation Sunrise Point-LP HD Audio (rev 21)
00:1f.4 SMBus: Intel Corporation Sunrise Point-LP SMBus (rev 21)
00:1f.6 Ethernet controller: Intel Corporation Ethernet Connection (4) I219=
-V (rev 21)
3a:00.0 Network controller: Intel Corporation Wireless 8265 / 8275 (rev 78)
3b:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS5229 PC=
I Express Card Reader (rev 01)

Linux 6.9.0-x64v1-evl1 #2 SMP PREEMPT_DYNAMIC IRQ_PIPELINE Fri May 17 14:29=
:03 EEST 202 x86_64 x86_64 x86_64 GNU/Linux

Best regards.
Ionut Nechita.
