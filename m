Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92888479
	for <xenomai@lists.linux.dev>; Fri, 17 May 2024 15:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715959789; cv=fail; b=Fy4rl3G9PnH9pxkAbcu96Ud1hlNPlWeQgHd7HyFE+P13XvV9OA+GGPP4j6fYsImbvsUdIpSsdjWO8PLmNWXjydK8iBzYNsHWiL2NT9lUwis889uxuh67qvxF1+Z3kRDeTka0Oy8H3APC2L/nL6znCFRupblWIpEAyno2gYRzVMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715959789; c=relaxed/simple;
	bh=NPb1GxGGbh4JJ1m3hT3qITLd+nl2Jy87qGbMJOdFxGU=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Akyk1niMMMBi8s7NvzQLnUZjCWUTaDl+CjRGPR6ENd/KaSZtMC3YxLWrtqkjMVFAEq+ye+jlnZP3BPnvZOFbXNbUoMeVd7HF/x/itpPTGwsw6dw9wo3m/09M2peAzwrn1TUZ3A9mRXoQFdL9DP6oAB4EAKh6Vtgelbnl8whzuVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BR0pKYZ8; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BR0pKYZ8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715959788; x=1747495788;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=NPb1GxGGbh4JJ1m3hT3qITLd+nl2Jy87qGbMJOdFxGU=;
  b=BR0pKYZ8taulOfqTkPQjEgNIc7BRGxtLNcTjibP8nHjkgddT1vteEv2/
   Q9DwT9E0ohEyUYbsuKniTKlId5XwRa3ICaLSTxXMNHIfjLI+zT6IDAeAy
   RCe56hIkZ3734I8cWy1VtkmVexaAij0NUE45ouBHHiKZ2u+gShdly+aMy
   PV6ToUhvJI5XSP5Qrz3xwQKHIDNleVl642IernSIVzyUa7+wgAAUeQp85
   LoDjlxRDwAJZtk4ZqnFC7DRc6mi3jaz+juVjebY5FYEd1CFdFaRnwHYrl
   4hMpVuGbgSvlvvtJV8tH1KNwecSV98msgw98xX/TIPQ6u+PsFRGbPmZyI
   A==;
X-CSE-ConnectionGUID: Ng3rSen6TOen6laTN5jD2g==
X-CSE-MsgGUID: hbQq3EylS7OsRJFHfBS3Gg==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="11984449"
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="11984449"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 08:29:47 -0700
X-CSE-ConnectionGUID: 2oLpwPI+TC6HI6zpoi3Y2Q==
X-CSE-MsgGUID: vjV6yfv2Ree68V4KxC7d9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="36715122"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 May 2024 08:29:48 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 17 May 2024 08:29:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 17 May 2024 08:29:46 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 17 May 2024 08:29:46 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 17 May 2024 08:29:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYSxDkDTGoPZvaKH2AWgzuylb3ilUHc7dqk8oZSbsLcvTlme9ABmybYrZOrcjrsZAdbzQJyWiDdCl1FGzqNfIjGSWpxzAx+KAS2o9aDggRRz9MYy+3jHPIOBNf6xQD06C3UUJ4u8x1gXTwF+u1xz+cyh1Uz14rJUVSRpcfpUnYCLTj17QGsl9eal/ltSijGpm3zv02vS5kr8ELuUtz4r3xfuRw9HHr4l+RAe3A/tbAHPrjwvdeyRoohO1rPCs3Blj5VmqrKg9eyZ12XfDIJmIRn6vkh961AT5gMHtehWEBijCfeCKpVkoCJPpRN2VS1sMBMftHqHrjMdxlRtLR9fsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPb1GxGGbh4JJ1m3hT3qITLd+nl2Jy87qGbMJOdFxGU=;
 b=QmXgzYtd3mZs9g4AAf/EaNlliTkMLsb66FwlCu3ir0tx6Y0c0dpgDYJMnVx6sz4O3rzANXLjRuqixKvFQ1AwPtVTr1kTUIr5MmwsBx8sW7Pl/JBQWvoC8YkGGpjjUcrdGvpw/eeKDVVdMdggMXCiLStHTDrrlI+Qy3VSjtmapKPjDckxoTmjXjO2LHZ4VpsgolmPOAxj6QUo8XmwFWq2zU42scd+OmRWg/jhat/qQr+D9YywVqzZmzH86N7hzVZO576zgfYF+xgPGZM0PiyVR3zHTRXStAgVXSQmiUkSltGK1ql/6moeE8PcKsdvRbvca+9oLjq4sgPojCA1boK8VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5949.namprd11.prod.outlook.com (2603:10b6:510:144::6)
 by SJ0PR11MB4989.namprd11.prod.outlook.com (2603:10b6:a03:2d9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Fri, 17 May
 2024 15:29:42 +0000
Received: from PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861]) by PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861%6]) with mapi id 15.20.7544.052; Fri, 17 May 2024
 15:29:39 +0000
From: "Nechita, Ionut" <ionut.nechita@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: WARN Kernel v6.9-evl-rebase - EVL: invalid out-of-band syscall
 <0x43564d41> - Firefox browser
Thread-Topic: WARN Kernel v6.9-evl-rebase - EVL: invalid out-of-band syscall
 <0x43564d41> - Firefox browser
Thread-Index: Adqobt1wsEThW759TTGOhdgp/60cKw==
Date: Fri, 17 May 2024 15:29:39 +0000
Message-ID: <PH0PR11MB59493E21636F9CA955E2DE8BF4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5949:EE_|SJ0PR11MB4989:EE_
x-ms-office365-filtering-correlation-id: adf68c89-caba-4c50-ab19-08dc76862ac3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?5TDL83H76eljWwCcijg49ZTQx6WA5CJzwLSU1NzvXNGZcnr9F4QpkX7Jz/j3?=
 =?us-ascii?Q?mwE7SJe3Tor43WiSbWIY8F0irGqolknt2M6uUU1zEAukHW+SXOYifrxmvwKU?=
 =?us-ascii?Q?cR6to/XMhaoWE5wBrSjN4bSo+dwZn5iw30sam8h4sxIJyYXhG44wr3a8XEb3?=
 =?us-ascii?Q?/pksFExc8FFGOUh/c3wmXhlT0sNQL7tjokEOFkP3mxGqouz2fQyk5X83WAcc?=
 =?us-ascii?Q?s3wbZl+XoF8FqiJRL0prLsSV6jflgIUttt0OpsRyekVIzlc3Uo61HmjvmuLT?=
 =?us-ascii?Q?W1WiEAN/UXxPVh5hrJpH0n17UbJ+txY0CiLF+qu13KDIWrYylj2X+Vo1ywW9?=
 =?us-ascii?Q?yRfOK2OGCN9Wol6HMeK+Qji4dRanScNa3veHD6NKTuAIkXW580oeep2bLSCY?=
 =?us-ascii?Q?yJ08WBMeAbY705Y04EyQlGgkNS3lvrppnrukvOJ8rqFu1Z/LGspe1jKFxBgE?=
 =?us-ascii?Q?eznyYqTNplM2VyAHvGqMxefPRbtS1yXI6BQsT964yX/fw+d3ncQh2YUy5SJn?=
 =?us-ascii?Q?fp51OYALLbAXfPmIwiohdRqweGgQUcra33bMftZj0va7VdL0E12Os+XiNgQT?=
 =?us-ascii?Q?C43oH/wLnXOFgWJuf84eiOxBuQxaHGayrK/NO+aAZMaKHlOHEEkyJrFQ7coT?=
 =?us-ascii?Q?v3UizJT8PwvG/U1F7zUra2r3JZQMi8LvicBRNKz/jzB49L5s1V74WLzHeAdV?=
 =?us-ascii?Q?Nrzq+MyR3fnGEA7yrgiZUeiKj/T/iwYNM9RWBSIbcOoPTZGmWJt9D+5WDp+D?=
 =?us-ascii?Q?+jPusFb7YdCeJFCeuxeTFbqTLH6WPUYcX+Ekre5IMrz+JCraEbCTS4OojdDw?=
 =?us-ascii?Q?jRN77xfiUECm1/p8fQI/ZIyS15k6cD20RmMLnU0eA+v6+AHQ1oI1o+6JD+Mw?=
 =?us-ascii?Q?c7llauLyGFt24q4R+vPko0NX8jWXfKwf3kO+OSrgyszfcfAvH6tIWA3jYwbz?=
 =?us-ascii?Q?m/cAjmAjDubOWZ62GXC5gWLodICtF7LAX/0/ECdIMNnarMMm1ipeyT5Pdyov?=
 =?us-ascii?Q?GEjbWO4RFip5FwKcKdAqBF24qCRXswwjgWxHBXlFaEg3TjI59wBPWH/U4gBv?=
 =?us-ascii?Q?lL3ExkUpgwSb0FcMEu6YwMxIlHDPcGu8/Etfe5JvY5AVIt9lcqxDpDeAIUnA?=
 =?us-ascii?Q?llLJGu30eftxMk6IWdxRFVhJeix46NW+/Cojp4CI3Os/XsoxlkvfeLWYdN7G?=
 =?us-ascii?Q?oBd9jqI2IuwRNR4Qm1ATcDWG87kgunZuwZMguX2Lp0r1g1Z0DlCLvPG4vTxW?=
 =?us-ascii?Q?cfc+ZCQqPv/RvNC0tF9BSLNFVA0qzsB4v6Y0N9xm3AGd5nsVn4DdvjhR2XPl?=
 =?us-ascii?Q?zsd4/RfZVV7ZTngQWCbJxG/dWIM36l+dCdn9UjOvUJSfhw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5949.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KilzNnRgj0wI0ZA73Yh5DMjKqWDjEZ+G1Ftor9X16fyCtKmk4upKGzCTXYeN?=
 =?us-ascii?Q?6RdmrFYHC1ag9/pkIap0iuf2s4nbLpiMzkTgQcMVrgmbqA1Gs6xhJOJPQrTH?=
 =?us-ascii?Q?dEmiuhio0ubLrb0aCB4ZwJuvZqNypMMGuKFUdf8ORRx2wEOKD0sPSUErGQ+9?=
 =?us-ascii?Q?uLCvXR+hNhVbpPhWUM3Y9RrEV9KmB2DxbcIdBN86hhjeqf9pEdukuykI1A33?=
 =?us-ascii?Q?6OksJ1m42I0UlfyUSJzCmdyEQRaqbvC0XQNz+NlBuR+Q9qbdguN5+dRUzQad?=
 =?us-ascii?Q?GBWNwxHh9Ziz/Gr+jqgDTEbEYpvCf88+I3HQHI8zKW0gVp+9h5hiOQSsjE6W?=
 =?us-ascii?Q?8uYDnyi3s37AjjZsN/WF5aol0bHENBLzxrzbADIXSL1/npc+mp3JfMEkRKm3?=
 =?us-ascii?Q?WIJgzG8CvKyEAaN4VMBFALIT15BbdBdRgPtth/j5b18i560jFzSnRIhrD3Pp?=
 =?us-ascii?Q?3kA3VPDEsYKw1RfqYMPfGQOCxq5W/QeYV9bLuQ8uKFaJlYFaiydbDFSFKmwW?=
 =?us-ascii?Q?pJhPkP4TWVKEnwldS0cRVQLgvK4rf9DlQdXRrQ6f81CvngA26//xpGPevXzL?=
 =?us-ascii?Q?Q5OK+u8xDedqj8YVjg01pcmvLmenhM0X5jMXYmaKkheo9J6nv2N/QNr28E4e?=
 =?us-ascii?Q?fc3Fw6BvHsJ+HoeTFYDcQzPaA6o07DSEn0ojQQQW98MP44VV9GXfeOivKoAN?=
 =?us-ascii?Q?RM/i+3XSq1JRfoJ+6xVfnUzTVSd6CLAsda7ooOM+xVRze0FhXWwoL0jBPoHg?=
 =?us-ascii?Q?56LdPEvXDAYVUeasE5TevAN0MgmG1YgJzAl1+bq41DkNT7TNd3Rjbjp3t0WJ?=
 =?us-ascii?Q?0A31N/hAFK/pBIpYCFbqKTmbv/zow13NZoRzXVoS+6MVktdHeajDmdrYvJwf?=
 =?us-ascii?Q?u6Szhuafh81MKqABTSaB6XRrYbON0O09q5q0ycGuncrNkQV2Faxe4WA1FiFA?=
 =?us-ascii?Q?Svv7MbNhLPQve3B3QPMqLwwPrnob4AFw2KO59zflF1DQLXiFWCZz81Jrz+xR?=
 =?us-ascii?Q?ZmifAuGvsBpne/+yvh8DaSJ4oGxzi02JDsKwD85mzyhPpjFdtKIfL6Gk3IkG?=
 =?us-ascii?Q?9gOa8Yua7qyFG9BBMBeW3S8AWmBGOyvLBGi9+7gbXa5bzQTadfK+Oioil1qt?=
 =?us-ascii?Q?wggJB+HwP6XpWWGGWT+Boq5IW4B298BXWFXbpdIYpB8ImjWhzYFEAMT+ZMZS?=
 =?us-ascii?Q?iMnjp1E2/hnxStcG/zn1nWk4BU4jAMateiCmisEXz6Uemqj3KxranG52yq7V?=
 =?us-ascii?Q?XQ4wGxlumjq9lsLNWB+lc03auAoVWEf1QbQCHJNLXPeCbER+OZaKzjuwmOEw?=
 =?us-ascii?Q?sW+/iJeqsCgWvIzLC5pKsyuTi4jeTKWcUyFLswb85wrSK7ZJa6a4iIxdvbYX?=
 =?us-ascii?Q?ujytSN1s5Z+3toU53SXHN3Sbq2IAGqBrToRg8st+YezFdbO3tiymc/4rfDOp?=
 =?us-ascii?Q?jzmZwsjiK7CjeJcg/tYZUXr3QLVhNSw0Pg+HolGJFPrhgmyOVT5AJg1wr4F0?=
 =?us-ascii?Q?kuTEBaCMok5YZZKWtPpCuWjttLC0pK/Uglkfe8PWp/kTEyFhFAjfbr64i1LT?=
 =?us-ascii?Q?SPYqOoUfnZGJJBcpf4nvG3Dd3dxv6xCsgsdUj+qZ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: adf68c89-caba-4c50-ab19-08dc76862ac3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2024 15:29:39.4628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5/IWyhY085hkEqAb08IOomRhezXQw6Z+8TgMNJ9Tsgs1czdTjn0+s/LZxq/6VFD6cquIJTs4J6hqgDQcVmYgMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4989
X-OriginatorOrg: intel.com

Hi Xenomai Team,

I installed today v6.9-evl with all patches suggested by Philippe to resolv=
e RIP warnings in dmesg.
But I notice other one behaviour regarding EVL core.
My system have desktop environment - Ubuntu 22.04 LTS(Gnome Default Desktop=
).
I started Firefox Browser to search some things, but i notice more warnings=
 in dmesg when Firefox is started.

Is normal to have more warning in dmesg for Firefox browser?
Is only happened when have Firefox browser is opened.
When Firefox is close at process, messages in dmesg not appear any more.

Output(dmesg):

...
[ 4767.957239] EVL: invalid out-of-band syscall <0x43564d41>
[ 4767.957260] EVL: invalid out-of-band syscall <0x43564d41>
[ 4767.964495] EVL: invalid out-of-band syscall <0x43564d41>
[ 4767.964517] EVL: invalid out-of-band syscall <0x43564d41>
[ 4767.964537] EVL: invalid out-of-band syscall <0x43564d41>
[ 4767.973630] EVL: invalid out-of-band syscall <0x43564d41>
[ 4767.973649] EVL: invalid out-of-band syscall <0x43564d41>
[ 4767.973662] EVL: invalid out-of-band syscall <0x43564d41>
[ 4767.981397] EVL: invalid out-of-band syscall <0x43564d41>
[ 4767.981408] EVL: invalid out-of-band syscall <0x43564d41>
[ 4767.994573] EVL: invalid out-of-band syscall <0x43564d41>
[ 4767.994598] EVL: invalid out-of-band syscall <0x43564d41>
[ 4767.994611] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.002334] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.002362] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.002372] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.008124] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.008145] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.008156] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.019824] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.033785] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.130543] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.181969] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.206025] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.234148] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.238021] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.482234] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.566334] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.566531] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.566831] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.566851] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.566917] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.567020] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.569456] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.570929] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.571208] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.571315] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.571333] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.571366] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.571419] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.574266] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.576491] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.576690] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.667500] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.667520] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.667756] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.733754] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.733767] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.734012] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.747761] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.747783] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.747796] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.841513] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.841531] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.841549] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.841573] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.841588] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.841603] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.841611] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.841620] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.865061] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.865081] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.865100] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.865133] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.865146] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.865160] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.865169] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.865176] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.924726] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.924750] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.924761] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.944287] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.944304] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.944324] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.944356] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.944368] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.944381] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.944390] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.944397] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.965413] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.965427] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.965451] EVL: invalid out-of-band syscall <0x43564d41>
[ 4768.965461] EVL: invalid out-of-band syscall <0x43564d41>
[ 4769.052723] EVL: invalid out-of-band syscall <0x43564d41>
[ 4769.052741] EVL: invalid out-of-band syscall <0x43564d41>
[ 4769.052763] EVL: invalid out-of-band syscall <0x43564d41>
[ 4769.052772] EVL: invalid out-of-band syscall <0x43564d41>
[ 4769.095874] EVL: invalid out-of-band syscall <0x43564d41>
[ 4769.095889] EVL: invalid out-of-band syscall <0x43564d41>
[ 4769.095910] EVL: invalid out-of-band syscall <0x43564d41>
[ 4769.095929] EVL: invalid out-of-band syscall <0x43564d41>
[ 4769.122300] EVL: invalid out-of-band syscall <0x43564d41>
[ 4769.122327] EVL: invalid out-of-band syscall <0x43564d41>
[ 4769.122346] EVL: invalid out-of-band syscall <0x43564d41>
[ 4769.180437] EVL: invalid out-of-band syscall <0x43564d41>
[ 4769.180468] EVL: invalid out-of-band syscall <0x43564d41>
[ 4769.180482] EVL: invalid out-of-band syscall <0x43564d41>
[ 4787.485320] usb 1-4: USB disconnect, device number 4
[ 4788.710873] usb 1-3: USB disconnect, device number 3
[ 4798.970592] EVL: invalid out-of-band syscall <0x43564d41>
[ 4798.985661] EVL: invalid out-of-band syscall <0x43564d41>
[ 4798.985677] EVL: invalid out-of-band syscall <0x43564d41>
[ 4798.985698] EVL: invalid out-of-band syscall <0x43564d41>
[ 4798.985715] EVL: invalid out-of-band syscall <0x43564d41>
...

Linux 6.9.0-x64v1-evl1 #8 SMP PREEMPT_DYNAMIC IRQ_PIPELINE Fri May 17 16:48=
:38 EEST 202 x86_64 x86_64 x86_64 GNU/Linux

Best regards,
Ionut Nechita


