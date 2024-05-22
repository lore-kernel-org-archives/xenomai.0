Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7F155C3E
	for <xenomai@lists.linux.dev>; Wed, 22 May 2024 15:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716391536; cv=fail; b=UUb/W0jbTabD4XP5WiST6bLB4aWNv6CpUiCnh5zIoq2nr9cIZBC0ItJkfeCvmui90JsTD7kJKtNkIWWghG9hGrHejaXpQfxoUD05DnAqB5XgXpduAP4AVWRogk5nZUPRRZEIUZfVOukKL1PShe8Aejs4AT1/K//jWYU3J4m5rrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716391536; c=relaxed/simple;
	bh=MVdJoBwnJoVTmdTLSv7GPHJaTyL/UEuUiLvNVmyAkjY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gCny6x53GrVQJgxClEpmaACOrJUWOXc7RHDHIIJhIdBgcyFtn9oATJaZ9gdiZ8gA6YszPOzq1rf9qz6si7eEFMV5sYaxfwjKthJkwNWi4vrLpHQGQcLVXqFDpKUHkUlilI2oCpYqVKUZQHO1dukGJED2w0JPgcLezekqoqQHfEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NHsIedOg; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NHsIedOg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716391534; x=1747927534;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MVdJoBwnJoVTmdTLSv7GPHJaTyL/UEuUiLvNVmyAkjY=;
  b=NHsIedOgqZVv8DaswRPuS7/kmFLMW5gm6Hrsn7/WRxhKBCQWL/YYrKfh
   WBjonDx9N0vCiEN62KmIsaWqknQui36xj+Svtq5h52BYBhZ+6qrzX5dap
   HhG+FzeDRtd9w/6L8xDVlidrJ+VeeaLO9MHfwNLc3cjq+BnPMN6nKTwR1
   AxrRngiJiwaW1bOoKf/fZM09iS5X97jzZh8wGvl4nemAsQPE9JFBTgegg
   I8EiCHBXGCo0Vmtya0eeQBsanIaHj7HzWUYlMr1JSpbQoMCyYyYQrFOqi
   7/dCeHIIvhSuekvsKDqPbKpzHCjCri3aGpuhbUhycIpSX2w9OhGT0vHg6
   Q==;
X-CSE-ConnectionGUID: Nt+pJJwTQp2mlQlskzhM/w==
X-CSE-MsgGUID: UAfzFxqVQsmLg7gFdlBbDA==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="16494109"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="16494109"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 08:25:27 -0700
X-CSE-ConnectionGUID: uXbsmgt0Sk2gkZwrlWpSpQ==
X-CSE-MsgGUID: mgaFBWhGRRqf4PkcWYWfOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="70730469"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 May 2024 08:25:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 08:25:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 08:25:24 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 22 May 2024 08:25:24 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 08:25:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUobaGfwOBWlFlnjQCcxdHee/qGZ7EBGa5R7unUh8tfgHfXY93oDF78na93ikvwuqU44lVgna07kqKvA/T1uoO9832xWh1PYp7mkL8S6WJ/Ne6xPNdlFdkbUyRVAHrs5pUQ8zXzI1xXb9A0AT4+tNnmSv2KKhH5/sqsT6TKk6cjVG5OHpl6Yc+TwBsodzkFMPf8KYz6j1h/xurByGeKUDkIGFGdejTpBV/mlqp7SnEBU0xMCjx0YRRzV/SdtkPObo5HWzej7cbBq5opcxxgugAeCVhGLh30aE3fg66Rp8wreazUxsVVQpjnmbN21dW3g6caIa3z7ILH67YqrEyAVEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9iKPERNeTeHRcycDfnJhsS4n1GJo9Xd8VR7EKfYR/A=;
 b=JwLNywSw7eKnNpEO/RgoQ7N+UjNpbYHI0NLg/NoLkhxm4+Qbmuo/JIElrNO2GAf3tdcUaskFvPmYWujFRKv0IoDdpkarXnwnYtf7t8e8mqt9bZ3MQBXso8w0EsHqKn405IWHyrQaxet/Xhj5Vsc7G7JovVu4505bTzQ1BD37up9+gPPyC7cvmK/ThVufYf7HE80MKQEoEl+S5K6oCkx+Jp9qhGdpnZJnfNOgGBLqmFZSqYWum/+dVEUOhv845I/Xm7NqTT6a/MFQ14oH1XX0D22UMM9N5eDhC71/AwNlhBeirh5yXFHcqnpX+HvBS8xiKewDGQ+JxKjxma489eJIHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5949.namprd11.prod.outlook.com (2603:10b6:510:144::6)
 by PH7PR11MB8503.namprd11.prod.outlook.com (2603:10b6:510:30d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 15:25:22 +0000
Received: from PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861]) by PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861%6]) with mapi id 15.20.7544.052; Wed, 22 May 2024
 15:25:21 +0000
From: "Nechita, Ionut" <ionut.nechita@intel.com>
To: Philippe Gerum <rpm@xenomai.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: WARN Kernel v6.9-evl-rebase - EVL: invalid out-of-band syscall
 <0x43564d41> - Firefox browser
Thread-Topic: WARN Kernel v6.9-evl-rebase - EVL: invalid out-of-band syscall
 <0x43564d41> - Firefox browser
Thread-Index: Adqobt1wsEThW759TTGOhdgp/60cKwD2+6CAAAAhQ+AABC7IUA==
Date: Wed, 22 May 2024 15:25:21 +0000
Message-ID: <PH0PR11MB59490B50D2D2717B8155EFCDF4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
References: <PH0PR11MB59493E21636F9CA955E2DE8BF4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
 <87wmnmq8v9.fsf@xenomai.org>
 <PH0PR11MB59491C18ADB51F5FEAEF4B3FF4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB59491C18ADB51F5FEAEF4B3FF4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5949:EE_|PH7PR11MB8503:EE_
x-ms-office365-filtering-correlation-id: 4d780944-0514-405c-2712-08dc7a736551
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?hmpyWUUy/Zs+qhYjIYr1I1W0xOw7H18Z0O814MUj0PBLkOrHO7YPYbsgdY6Z?=
 =?us-ascii?Q?OrD5fioxeqIH8dKlSYiUubGxk4uV7nljjUFpaGELjz3d8hs2kmKuiUWd3jSp?=
 =?us-ascii?Q?JiRCkr59EDi4pbiW7OYcjUF2N8UE4OzJtMje8Vxe3GUx13hSSc5JAvAJZl4H?=
 =?us-ascii?Q?m/f+XSTDCTU7eyAzeiONgRTFBM0vNxbvfTbwO28GN90XWx2CnVEhCL04V84K?=
 =?us-ascii?Q?7l1tGE+4iMfAzFBWincLjzJpUPSm3Dcc1SPlnsFprq7PA3cYDYlg/bk8p+OW?=
 =?us-ascii?Q?XAE6YNunqDOp53Yc8y20jTGNPDwGt6ud6N+Ivz4Fse1or+sE7DPBz+fdgwMy?=
 =?us-ascii?Q?6D+8nGrrrP4oo0VABgmsYHxGOVxI5cDCozhYcGEBOjOkpgBmH79FHAYYiinr?=
 =?us-ascii?Q?FgCEXOvwP5i8Maa5ByG7slUmrxeJ5FjCjRgIT+fcsW9aChgiwBtNpFbhvRwq?=
 =?us-ascii?Q?7rjP3cNl3cDV6KeImZ657pRrRYe5HSxModJ4WSGnpUIw6C9ZWMZNuBa8Dnk3?=
 =?us-ascii?Q?earIgJKCpko8DVtw3i3u7/bys4J2qW9cBmPHGhY0Qloejfo8iny+UcrOkwle?=
 =?us-ascii?Q?xCdBzBGlZ1TM5zm7ZPM8GGoWj3MXF/ZiE/rsXDWFcrrjdMRvvCM2Q7j9OZcC?=
 =?us-ascii?Q?uXSA1kA4F14cLTmHaTZsIexWiR5go9HQhyewn9r0SqGCST8TqFcbrTet+7SB?=
 =?us-ascii?Q?9LMU8glNartbrJzmAhy+vsoe7pB7v+1VduANoZOVTHsRtzUSYa+/0Rbf899a?=
 =?us-ascii?Q?P1uKk7//8/ujWAEGO8StHyytixZmvcs8gcnEM2HwcR0j9r6XKjnGabPzbsza?=
 =?us-ascii?Q?BS6p/hqxrG4N1vfoDv/BmYcMVHiJ9dTdDvUpUUyuAdVJ/nr/tqxRVTJX7eib?=
 =?us-ascii?Q?eRM+hOmVpKef09eOMqfxI6sUcR3HdW4CqIADV/yMytwv844l79vK9Hpd9rVC?=
 =?us-ascii?Q?BlVkSWGovhMvaLu4/JvXRKHL1KKZZO7Koy6I/GYr3yoZBoINBm6ERs9sz8mj?=
 =?us-ascii?Q?4Tl6+x8Ec2n/DS7/TgTAyE0N6djoMT4pUbmXvYwv+yunKgjpr/yUk9pnZRDi?=
 =?us-ascii?Q?SzGNpDFc32I/i+hZCSz83OTxRaVsZZozkvVeRZGyhO4iMvkWRUDu1psnh0cb?=
 =?us-ascii?Q?oIUc7zSoJwGvhgBime7m1LshpHl0YO8iTck/xTlxQ8odCj12G2BfR/DrStAF?=
 =?us-ascii?Q?ZCc0kQ9mcfA0pnGHsxj5BQiq9c0vJ6hxq68rlfCx/D+widEmfzNm0z4htlIw?=
 =?us-ascii?Q?Qr48GpGffZd60F2KHjm1sBucCxcbLqPyNvP+tf1uy+N/woNzhb1VWBxk7wfb?=
 =?us-ascii?Q?77AXlfyNDZ3Sd2XOI4uwQu8kKXCoREDwSgOjW+EQmyHtDA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5949.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6HwQOaXMkl+HgR991PfAptb0SfJl94KG8TQM8zlNavytBW5o194m39xtSsiy?=
 =?us-ascii?Q?5SjhQXuDFq+m17sQaB9yzFtYO7yJX/Vc1CZkmMw5HIGHaPF0DiFkhbxQdYCB?=
 =?us-ascii?Q?X389ge6M6s6VpdOrBb4wAyTySSqWxB//zFlvdcRxKU+XN1sag8n1d7hsvuSQ?=
 =?us-ascii?Q?eCbSRUHq65IKypPOGn89pzn+2hojnMopeTRCx9bB7WTuEEuxpqhDC4Kzg33+?=
 =?us-ascii?Q?AgZqYXB4Qp0CaetCwJAVBOC4AyxHv7HG5Izcph/uvF1zwwNRTqf+hVfHEYCc?=
 =?us-ascii?Q?Puaowh6xN/Iwhzbh/wLgVHCFW9VwwqnUhTrxrS2EPi7GgMKdxZ1t9G9LjrDq?=
 =?us-ascii?Q?OAneLf1t1G4F3EdtZSQUI1cGWRF2uliDXuNcdMbotIILBE0FOoWL3myMZb5t?=
 =?us-ascii?Q?5Cm6tqZu2RFMEoUhbwtFLcxIDp8NYGCi7l+Rg4lp9GF6/gYmPxrbVMo/aBbJ?=
 =?us-ascii?Q?xkwp13VoA65K/O9sIGyMXuhcoxhuifZ4I6+AkgIZOC5vxrYPyYR/80AqPFKP?=
 =?us-ascii?Q?AtSpcKmWtJhQZCOJOEnU7ZA1h5MahgB3KfZCdgcYhZgqsUSzeTC2skKmtw5h?=
 =?us-ascii?Q?LxSRqM5Jjgy+J982nweDZrU9oD/bJIG/ZAbj68N7+REfNR/MI8Wx7HY1bN1r?=
 =?us-ascii?Q?2qiZIi7Jvn7a0XrVC4hZe4pzgtTfm1ElmZr9TSmg3YgHhUXcnev/Zf1MkSHT?=
 =?us-ascii?Q?gnI7E5QdBuVfL1i9YjMjiQmORE6UhbtlTQAKU/o7OWFoOweN/Zw/93kbafQg?=
 =?us-ascii?Q?I/SmJBPi0Y0ZjqFdR3EA8NELlA+Tpwy4wERhfZWOy3R0tm2c2P0RiYChoajU?=
 =?us-ascii?Q?oVH5yaZK2wJnNVb0xMChvbwCxS5pFvwOYqSjiVPlwh0YoZaiZPLwimK/08G4?=
 =?us-ascii?Q?VSPVMY2TO21HDp1EqIfAEntHod45Q7FnzrWr6jeWTl8FnXUiwe8b15KGA65X?=
 =?us-ascii?Q?JSS/vameAq3ze/e68WKvxCtQCLnJiW/AU+JSitsgPoUGdQJJusotlz8dtR8S?=
 =?us-ascii?Q?4FCJzzyIVo/OniqT+bVxpAkYCZKqXZom9Juqgdx5yl939UNQAW4uJI0Pxamj?=
 =?us-ascii?Q?0Sq7DSdGYFL8x8I2yfjjIx9rxjlWeoaiRlXrnR2SXpDFddC7qTnE4+y2biix?=
 =?us-ascii?Q?ZJ2oBm+WS5/wIQ2RC/6HuTQnmkqaQ9s0atHWMA2hnUF32SAhgLyz6g9I7Xjp?=
 =?us-ascii?Q?9Dn3w+8me7k+DDGZwz9DnNB3fxvO+DPXlBUzzUMSspXDiCtT969v+ZYM5O6y?=
 =?us-ascii?Q?DVCEnlXdIYjOgveSXBp7OknErZpGvMErLDJd7AFBSj3LjCAwku7RYBeWjNzU?=
 =?us-ascii?Q?0112dBhiguix0FGoW316Mx6q4+iOJSKMw+2CcnHXY0b6FSJjhJ2D5QjjlEnj?=
 =?us-ascii?Q?WTMv69YKZNoEDnTNTHFE3FW5m5hmgXMlp6SFNTqDlczX4cxO7kMt4cK3oH6N?=
 =?us-ascii?Q?1Kb3oHFhhvF+kOqD3Yezr1wankfEVPnEf4EH1MSzZq5b5nqfD34myzuv1phE?=
 =?us-ascii?Q?GuoMqSr95+O9flqquOk2ZqpaslgU9kuzGPKtNd//8o7vLXwzPiC6ddO6pR4G?=
 =?us-ascii?Q?AjTBIxvIQJealMiNh9tVRgXQ4dzqd1ZtySCxn3QG?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d780944-0514-405c-2712-08dc7a736551
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 15:25:21.8906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /eqopvsGVsfdUgb2ExaFXyDJN+t84igwFJaOQNCNv/zSG9OXc9hUVEs/AyuUmUJpO1hhAKq1oEPToqh5EEA0yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8503
X-OriginatorOrg: intel.com

Hi Philippe,

I tested today with your change:

git diff
diff --git a/kernel/evl/syscall.c b/kernel/evl/syscall.c
index c2a3f13ebe37..1d02b9d6dd38 100644
--- a/kernel/evl/syscall.c
+++ b/kernel/evl/syscall.c
@@ -269,6 +269,7 @@ static int do_oob_syscall(struct irq_stage *stage, stru=
ct pt_regs *regs,

        nr &=3D ~__OOB_SYSCALL_BIT;
        if (nr >=3D NR_EVL_SYSCALLS) {
+               WARN_ON_ONCE(1);
                printk(EVL_WARNING "invalid out-of-band syscall <%#x>\n", n=
r);
                goto bad_syscall;
        }

But this is not working properly.

...
[  261.152827] EVL: invalid out-of-band syscall <0x43564d41>
[  261.176994] EVL: invalid out-of-band syscall <0x43564d41>
[  261.177020] EVL: invalid out-of-band syscall <0x43564d41>
[  261.177042] EVL: invalid out-of-band syscall <0x43564d41>
[  261.177082] EVL: invalid out-of-band syscall <0x43564d41>
[  261.177099] EVL: invalid out-of-band syscall <0x43564d41>
[  261.177118] EVL: invalid out-of-band syscall <0x43564d41>
[  261.177133] EVL: invalid out-of-band syscall <0x43564d41>
[  261.177145] EVL: invalid out-of-band syscall <0x43564d41>
[  261.240273] EVL: invalid out-of-band syscall <0x43564d41>
[  261.240295] EVL: invalid out-of-band syscall <0x43564d41>
[  261.240327] EVL: invalid out-of-band syscall <0x43564d41>
[  261.240344] EVL: invalid out-of-band syscall <0x43564d41>
[  261.291722] EVL: invalid out-of-band syscall <0x43564d41>
[  261.291746] EVL: invalid out-of-band syscall <0x43564d41>
[  261.291776] EVL: invalid out-of-band syscall <0x43564d41>
[  261.291792] EVL: invalid out-of-band syscall <0x43564d41>
[  261.320078] EVL: invalid out-of-band syscall <0x43564d41>
[  261.320109] EVL: invalid out-of-band syscall <0x43564d41>
[  261.320125] EVL: invalid out-of-band syscall <0x43564d41>
[  261.324083] EVL: invalid out-of-band syscall <0x43564d41>
[  261.324106] EVL: invalid out-of-band syscall <0x43564d41>
[  261.324132] EVL: invalid out-of-band syscall <0x43564d41>
[  261.324155] EVL: invalid out-of-band syscall <0x43564d41>
[  261.354447] EVL: invalid out-of-band syscall <0x43564d41>
[  261.354471] EVL: invalid out-of-band syscall <0x43564d41>
[  261.354500] EVL: invalid out-of-band syscall <0x43564d41>
[  261.354528] EVL: invalid out-of-band syscall <0x43564d41>
[  261.390334] EVL: invalid out-of-band syscall <0x43564d41>
[  261.390383] EVL: invalid out-of-band syscall <0x43564d41>
[  261.390403] EVL: invalid out-of-band syscall <0x43564d41>
[  272.577937] usb 1-4: USB disconnect, device number 4
[  274.576422] usb 1-3: USB disconnect, device number 3
[  291.209115] EVL: invalid out-of-band syscall <0x43564d41>
...

BR,
Ionut Nechita.


-----Original Message-----
From: Nechita, Ionut=20
Sent: Wednesday, May 22, 2024 4:25 PM
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
Subject: RE: WARN Kernel v6.9-evl-rebase - EVL: invalid out-of-band syscall=
 <0x43564d41> - Firefox browser

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
