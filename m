Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0647113DBB7
	for <xenomai@lists.linux.dev>; Wed, 22 May 2024 13:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716384300; cv=fail; b=Sg8icr3Pl7gpy2SEWOgVBN9w7bP8OsBiQeb6EolytZqgk8FBqIsoLfgnVYMcLr/3jGOVzd6/btF3tjf9BTyotM2ZBfsND6mp5+YXAS7vNnZYOTbs7lOX2dnoMaCWsDQ7FRR1ErcOa7YIc2uDMRoWvSwWD5XdrPyFw1VCMSdz8cY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716384300; c=relaxed/simple;
	bh=OErlQ/PBuPU1dQd9ngii8ZlKNUSJL2LOkHbSmuFOzRI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bqiWYM7Mfxbezeau/wU59heiX3IopA3oTwjEDRId7Q+XtOM8wEZZt1Xk7S0FG5mO/NmU8Rw73Vj1f1HzhnsvUFQv0DpxnHZkEYzJtv2iE6T0SmhegzUyuRv/2aJyxS5dDspwvjf/Vlku1sbosQAGuDuwFM+ce+LABILHlfKByTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ik+MhDn4; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ik+MhDn4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716384299; x=1747920299;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OErlQ/PBuPU1dQd9ngii8ZlKNUSJL2LOkHbSmuFOzRI=;
  b=ik+MhDn47jp+tboIxyqbZD0635SEFxm19CoXy0AlfxtGvgQVpOv3Atl5
   gSPezoubXwuV7ZtLIWwMhBCjlVyQDKv9u3HzEi4DIrwrpVYSZPl8kh4Pz
   TZMuGP0WoOIR3WrOQGPUYvIpVSPcYlm5nZ3iYjz680Cp5cSCrwfznsDlQ
   9+7sN70jQ57ChQb5QorlzFDaWEaAf9re90XbDxBaZi+U64mWdprtzybjl
   qa/WFixG+QNrL/YtMU/SkMMI/ifWzlSWjmuDscEBe5ApA//HiCs7S7N7A
   11yJXBmnT4pzxinH0oQaS8PQiOBTuwwADsfUt3Xdbgeo12Omb2SwjKV4a
   g==;
X-CSE-ConnectionGUID: c2tOp1SiQa2XsOX2mvcmdw==
X-CSE-MsgGUID: NOHB7A59QAeTkM3ezivVuQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="16425268"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="16425268"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 06:24:58 -0700
X-CSE-ConnectionGUID: NCxHb2PdTjW8/J/JYgkqjQ==
X-CSE-MsgGUID: nzFYkWDTQCO76k6fSeTF1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="56529146"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 May 2024 06:24:57 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 06:24:57 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 22 May 2024 06:24:57 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 06:24:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qc+yc0FNltGal+aKqA+tUDj8cEd82ELCwOPa5gYJ/k2UTN9FHOjZKs2Gja6+j7+zbGG1hJu/8Ph+2kkx+b22Fe7C4aIeeiqrN9aP2X162MbHhSbT6uCV8GRzT4evYc28FUSVzf/TrVQ5nczBHChTheGkwI8Y0z5bdudc2GuexlQLIEqi23XsaIWViJkXCjF7A9a0eP+uRJZ6KZhHQKwX03rJuXJd+0CzE50QIDyiB3hUO9RTtenr0bZtBv3xGRZQyYd8n6xdNYJSy1gIXFnOmhtif4qc4h2dey0Ri190RWzUiJrmqUa7oIeEBe+MYXeYg36iAo+FUmNaOyhKShxUgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVByJhW4lrA8MGYgb3l8QmnTg2TOg+1TLaUO0ORG0xc=;
 b=aIQtDkS9Fnr2bwWuHM2gAYGGKPftO+vFvrZpunGTBQJraU/jaU3DcJITF2RNAVI41tnnKbQ5jNnxod0FHyl1oYmezgbADs0pJMtn3dCxTr60Ear9YzZ1C5UmbPxYJlOFk3sWr2zLjJHWzN41VLH9pyuEE6kAR36nT0/bpia6aumvk9oQxlcAHhyHQX2wEWhvClFgIOqYbttVGv791c9Ksiq67nGvUFeNNR4CZNceTSrTHN8Ky1T0wt4y5cuo3iYfbq1ZzrbJoqLxmO42P1bEIw7cxutz5LZPht1l+IFnMgi4q5wo1kN9E+EEY1cqauFBBCxeDSJ1/tTnORQeBQYMWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5949.namprd11.prod.outlook.com (2603:10b6:510:144::6)
 by CH3PR11MB8156.namprd11.prod.outlook.com (2603:10b6:610:165::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 13:24:55 +0000
Received: from PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861]) by PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861%6]) with mapi id 15.20.7544.052; Wed, 22 May 2024
 13:24:55 +0000
From: "Nechita, Ionut" <ionut.nechita@intel.com>
To: Philippe Gerum <rpm@xenomai.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: WARN Kernel v6.9-evl-rebase - EVL: invalid out-of-band syscall
 <0x43564d41> - Firefox browser
Thread-Topic: WARN Kernel v6.9-evl-rebase - EVL: invalid out-of-band syscall
 <0x43564d41> - Firefox browser
Thread-Index: Adqobt1wsEThW759TTGOhdgp/60cKwD2+6CAAAAhQ+A=
Date: Wed, 22 May 2024 13:24:55 +0000
Message-ID: <PH0PR11MB59491C18ADB51F5FEAEF4B3FF4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
References: <PH0PR11MB59493E21636F9CA955E2DE8BF4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
 <87wmnmq8v9.fsf@xenomai.org>
In-Reply-To: <87wmnmq8v9.fsf@xenomai.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5949:EE_|CH3PR11MB8156:EE_
x-ms-office365-filtering-correlation-id: cbc3dcd2-903e-4461-d244-08dc7a6291ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?iQbUtIByd+BOGibHLFdIUahd/gQ95m+oofym+hQCtNjFyPaMuMb8/RKXxikX?=
 =?us-ascii?Q?shUg8hJePEJFYLcGP2VCAh+mYgCtF3JXYil7dl9lPqlICTa0x0g2e0kwzG//?=
 =?us-ascii?Q?0Y1TRUhArIBM64Y0ed1FV2BygvTaSfirRwPiiKRdn+o4X4lk2n8uo/Ci6JMy?=
 =?us-ascii?Q?lqc1T3rasQ8+CeOwEew9iySlQc+4KloqqDuVVIvXn0IM/WRiGnHLvdoYXXIX?=
 =?us-ascii?Q?2ta3UkvTLAt07LOdw9heHxnkBOy/2FVFuJNVJUY45XrpyDdx7zuHGLtjJv7y?=
 =?us-ascii?Q?Aprb2hBVWJ1cEBs95+P+Unsou/vURgmUFda78gaLl6j2M65lwRwUA6yTAlxK?=
 =?us-ascii?Q?XzSzzshzhi7z/JPcIoHH+FrZPdv/MOJAhcbIdch/u6XZ/EZxrHuLSVKD5pX8?=
 =?us-ascii?Q?XinTBXfdueMvaoExdCB+Df3adDLhzb9a8QvwcGq+gMM7s7VPG5jqyI2ZPhnZ?=
 =?us-ascii?Q?36Z+fhY5XS4OTBVECvb3o7r8IpSMCz6+8DRUMNNDAOJXD9b0Q9BGao0uQOxw?=
 =?us-ascii?Q?SeKp9OcSI0n1eCQNgvVQ0EPkyTlssyd3dgRcRItN74y7Fi1Z8W7Fwo7emIKk?=
 =?us-ascii?Q?UxfOMOzrc8jVniz7wInlQGkwxBAoUYmju46eIxjUPwzcj3fnUWdKZIXbE/3M?=
 =?us-ascii?Q?XiC87AHxsydr8PJdF6cWEgk/7/eKAm2RYtrk4qz0wc2C+L+XFFk36qcPnn/P?=
 =?us-ascii?Q?arOOMp4xe/gdRJ5GfN4KXF9PyElkXXrgroDGKt66cy/RrL64htSbfxtuAUiA?=
 =?us-ascii?Q?xtCAGNuBc9PGDOH6D+WC9Lrw1LbgLyJut+/mMHnrXvmT+kX8y2w/AREbF4Nm?=
 =?us-ascii?Q?EejNfVGz1nKGW9G3wwvVjf/3wuAosbhMK1rLTBNy0HvMnfLSpshpEWDM4GGl?=
 =?us-ascii?Q?oCxXhCRSoOuxgBYHgXX+kO4p0AJUvurJgOR4L82QzsfuTAtpfBFg1zziir1O?=
 =?us-ascii?Q?EeVCJjRAayYwmZwWqYkb/1G30EQqlUP24XSd/6OOU0njmIuVCntSgOBUDDFR?=
 =?us-ascii?Q?PLTw8Whu8HUd8jmldEKzWAKOknfxvVx7adkHLVSNm9tsHYv0JbO+WVJPGbXS?=
 =?us-ascii?Q?4mINujz3qIuvMLOkgDEf01ueffTyJNXdVdGlSn84FdRnNevzXIsU6fZPSbxU?=
 =?us-ascii?Q?AewwNhcjFwBwwcAW9qyRJnL8N7DsiMjpKg6tSMgeeTnaCDdEVVFPXmrzs+3Z?=
 =?us-ascii?Q?hZPhy9ygER6qPCOyyEtJE4cAGYAKiMZb7DZSRw4wAIX4Zb0o1ys9qzqUrQ99?=
 =?us-ascii?Q?qmj8Ya91zId48kkbphUCK/BVgUg+OBahnPJsm1GiMP7Uz3nSM/RzzQECGE0Z?=
 =?us-ascii?Q?7SStJdP2LO5MmikKhV9XDDzZQr5iGmDrEISXYQ4KJeodxw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5949.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Zi4MXQNR5N2fSHPUkxxecJ3tSnJ/wAguZdsHtLN8r0Hps6Fat1KpPZmOnCE/?=
 =?us-ascii?Q?k80Ao1n1LdSv13btLcyiheUCCm7IMVCYO5w30ttorq2599xrcvC4kl2k64zA?=
 =?us-ascii?Q?PryBaIB249UZ2bfAdNO9yyam8KV7KedVTYtYgpit3h+/2G6PkM25oT1SVOY5?=
 =?us-ascii?Q?IMpsrWi0iUJ5Q4tXM6MuOIq4euK+yZdXQ/3HDniUGZGKlz59HVzrlh0OMKKm?=
 =?us-ascii?Q?3XZ9NKjQOy2fNC3ig3qWRPI36y2e25z9bxHkbkdqy4oYc1nLn3+IbaGsniA9?=
 =?us-ascii?Q?LjajgfFLnCuALY1kVztyO5fAQvWvd9JD4b5GfzKjDfUVmRwFuZCIXXmMB6TZ?=
 =?us-ascii?Q?de7ZCXIQuAR4Bs9fpPnIxFewLnO5wujHCPs68RGINb7xjzZaqNkvCcXTCNYP?=
 =?us-ascii?Q?E7xBXmcDMGzXEXI0H9ZqDSzYXPGMSx0SuOEp6k1LY2LNULPOLHxNeEfHIMFR?=
 =?us-ascii?Q?7jYN7ahJbPkG5R1cVWWO8oVS0/sqvlbczd2YY5Hbq9pJWIDVh3raKcYqhW0V?=
 =?us-ascii?Q?k6DjPZEPtujv0vDK30sRrxGaF0owsi8hLa5MCUuOz+x5ExjtJJTW+lrCIVwQ?=
 =?us-ascii?Q?+xfa8Ik88CByYkT5JPAt52Kc5KsjGsVEi9bq/Ff3ejW2NOSMdQIK5uZgbstU?=
 =?us-ascii?Q?4nKz+FAsRe7Wtpq26mH7WcN9QH4StH2zV/WoZuUFObErAkTKYLCPaZmI2PM6?=
 =?us-ascii?Q?GtaERvP6Hff+BY37sJJh+htmEzBGY0dFOiGKBDQimaHoOv7ZoBVHxADXcNV2?=
 =?us-ascii?Q?9jNq2lnacCVPTkCZNp7N2xMScucBELkxNd2qELHhTGhVqO7DIcVMPj5xLT1o?=
 =?us-ascii?Q?CSDV1OoDgUxQughYd2rG6a1SHly0eOCmH/yQFPVtKohE6GoJevL6yd1J1j5b?=
 =?us-ascii?Q?yecdRYpCr+umHF1lcmPr5RHJIpu1PXgzV34bnsu3OioHX7KoPJXbgBb369uM?=
 =?us-ascii?Q?u8qNMj1PnxW8Gkx6xDyWYVbmqsm1YTaZUmbASLRULVHxFWkAgQ4gN2VWdSlP?=
 =?us-ascii?Q?Uxu+Etx7VbywuUXDVRVQXG0lVV6mVlbGY/puu1ezQkm7d9SmbrLoTgPDTV97?=
 =?us-ascii?Q?CjnYhcDqoqGBg2w2/waqf/fJLyTuU69C8NSq6hXUXbjIEBF4C+5fC9P1u4Pt?=
 =?us-ascii?Q?wArijHpblFWAJ8eyWXnAssesuMpi5BkO4dH9kzWI41jDDOYJOUtiYe+cDyVG?=
 =?us-ascii?Q?lnnUDvCyJHtbjT2/ttdCh87KcTomagtMaLc2zLb6J0V4kNeF8YRfmvYMvY2w?=
 =?us-ascii?Q?CZsGPPMbfDY5OOvbXs4Y3iGUW16TRp1WMGQIm9kwSuRyiDXdOqeCMYzDgbon?=
 =?us-ascii?Q?i4kGxaDyRPWt8xiEbnrb63loKhfyqRFVeYoQ7cOhi5Vb4/j+ACBiX2zx4lF8?=
 =?us-ascii?Q?DkshFsF3GkoaIblaGJTY8m+Msjy2tKhyIR8VfNt9gPKbP041Via7t7pT7Ef4?=
 =?us-ascii?Q?Uwx2xWe4y5CsmJKANNMwPt0oqBXzxfbsi4saWE3hs+b9gYCRcFIFfdRR7PGr?=
 =?us-ascii?Q?hdq1ohmCw2zVSzINIV1XfbgMiLN08vlufaQmW6nl19G/JyIwdC61W60TcYT0?=
 =?us-ascii?Q?7YdPyPuJvP4j58oWt/Zw5TVmdgPDytS4pGOIUQvm?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc3dcd2-903e-4461-d244-08dc7a6291ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 13:24:55.3242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TBoVk6KCUJ6Vd8wm/jY0/ncLxSqU5QIc08L/gQ8rWDO2jJSNmPo9jKMIrdSV8qgnc37g2OWjnprsShyD8+0kKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8156
X-OriginatorOrg: intel.com

Ok,

Will be today to check this.


Best regards,
Ionut Nechita.


-----Original Message-----
From: Philippe Gerum <rpm@xenomai.org>=20
Sent: Wednesday, May 22, 2024 4:20 PM
To: Nechita, Ionut <ionut.nechita@intel.com>
Cc: xenomai@lists.linux.dev
Subject: Re: WARN Kernel v6.9-evl-rebase - EVL: invalid out-of-band syscall=
 <0x43564d41> - Firefox browser


"Nechita, Ionut" <ionut.nechita@intel.com> writes:

> Hi Xenomai Team,
>
> I installed today v6.9-evl with all patches suggested by Philippe to reso=
lve RIP warnings in dmesg.
> But I notice other one behaviour regarding EVL core.
> My system have desktop environment - Ubuntu 22.04 LTS(Gnome Default Deskt=
op).
> I started Firefox Browser to search some things, but i notice more warnin=
gs in dmesg when Firefox is started.
>
> Is normal to have more warning in dmesg for Firefox browser?
> Is only happened when have Firefox browser is opened.
> When Firefox is close at process, messages in dmesg not appear any more.
>
> Output(dmesg):
>
> ...
> [ 4767.957239] EVL: invalid out-of-band syscall <0x43564d41> [=20
> 4767.957260] EVL: invalid out-of-band syscall <0x43564d41>

I may need a bit more help for this one. Can you patch in this snippet, the=
n post the output it produces in the kernel log? TIA,

diff --git a/kernel/evl/syscall.c b/kernel/evl/syscall.c index c2a3f13ebe37=
2..1d02b9d6dd38d 100644
--- a/kernel/evl/syscall.c
+++ b/kernel/evl/syscall.c
@@ -269,6 +269,7 @@ static int do_oob_syscall(struct irq_stage *stage, stru=
ct pt_regs *regs,
=20
 	nr &=3D ~__OOB_SYSCALL_BIT;
 	if (nr >=3D NR_EVL_SYSCALLS) {
+		WARN_ON_ONCE(1);
 		printk(EVL_WARNING "invalid out-of-band syscall <%#x>\n", nr);
 		goto bad_syscall;
 	}

--
Philippe.
