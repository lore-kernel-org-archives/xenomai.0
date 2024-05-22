Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCF882480
	for <xenomai@lists.linux.dev>; Wed, 22 May 2024 13:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716384194; cv=fail; b=Hy6Ay/Iaf3BdlDDd6HaB1HKvid1caLuZB0p7WYRgZsgPusmbkn6lERnr+lp3dcZEJ+q1fJ/ROrhjrhkM8Af2Pk/2k3qQyh52AOt49g/jL4RD2hYtuQZsXFfSlCAMSy/R7lwr/netd4PJ59BWBhrnyBfQUEAhbunn97TziN06iiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716384194; c=relaxed/simple;
	bh=X4jOQer01D1zzXJqku2vPcsvYD91R1SeaTLDUsJD1W0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FjwAD8o12w30avTHUpOIPAvCBe/klNHyJxTWtzcwUApa0GGlaR+9omVCoif/3p/7a+gSJZUK/DYRHRbkabhbsLr91B0Jf7+aRvd2LGzPEdSBozJI//0Y8aj9ydPPLUDOkDSNe8WImFM9WaZjs61/gumolwikPIB0J+wRfEzU0nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HM/jqE/N; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HM/jqE/N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716384193; x=1747920193;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X4jOQer01D1zzXJqku2vPcsvYD91R1SeaTLDUsJD1W0=;
  b=HM/jqE/NMKGJgaBgy9IXw/HeC6CHnj+Ix4xpz4HpUovoOniMp8yyriA2
   O4k5ZJuSBmDlFyHYXzpTBN/LZllFAfJSet1xlTtYCFiu9BPKfgZvvmR9D
   l7lAvXIMjiGN4wvn0KsADRmCfxkmx0dXHitwuE5fvr64/blmgv5WHuyzB
   i6OhuMLe1Q66tBOa3RVEdJqWssWFymaRVCu50Q5CwN8/6oKQuNiZh2SW3
   K8MvMjy2ZR9vPevM9GGOo7lAhDxf8mfRv8P2QWzgy7k63IHZnMQ3v6KJR
   mBOlyPDilfr440vSzVKQHm2ybk73n2SUUFxnam0YxYj/Wb4WApVl85cED
   A==;
X-CSE-ConnectionGUID: ymOdvN3wQDCFYJujcJMH2g==
X-CSE-MsgGUID: bjtuTlVfT0ibaZqor+PH2w==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="12575502"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="12575502"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 06:23:12 -0700
X-CSE-ConnectionGUID: 2TbUexGTTcuE19+TuKYGkA==
X-CSE-MsgGUID: M9Er4X9xSxmXwBAVCJg0ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="37868797"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 May 2024 06:23:12 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 06:23:12 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 22 May 2024 06:23:12 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 06:23:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOICIzJ9KyrOUIye8j6bf3y+A1Mgv2uFZGowWVnqObGFl4bMh7k5amIg8av2Iy9227UPVydDXoAFtJucHs49c4W17Y+1rVW3i9fjdPEo1cc2YHy60bexJQE+p0WHsia9ew3Q24lx+KrHSLhqV+2jEd/Ucc57x2CnTALFx707J37inj7U7xmNyAKuTi8duyTLKlpngQh1rjWwmympDaMmVBhh4i+qj1+ANBHSYZYcX+dq1gCJXVUDoJ8U9uG0s3XFZ43TsNu1bRxm8gPktFu2jW3PQn+U8nr62nWKAu7jEmC/mNyMjMzFQOh4ZlnIFQKVMLUlIrC7VjAj+ISiiocUrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTmp8JtiMXK6BubuFFFdcWS5agjq4402QJYsGiUbJfo=;
 b=RLvWcqzXUjd0BE7vnDsWW6YfVZ/lai2TcNXWE8L2TDXuycmRxXfH9VEH8wEYba8FfcPSkZ9N0oHcr2W7pYpK1nI07UwcaFrCG+x8wxbEZt2obvK/LtFdoJMysPKuzr4UTsqDarAn3HIjgDO8Ryk7dxRiB6gSzjKBVE1ZBeASngH/l7YkUfaxJ6PIifcrkDWOGt0iccZjvGvpM4uqvAI3wAFdtDbulBeYJAHDJ4SeJVRF6he2UFjZ+99cJlSxWGQ6wMtJtEj9TuOSmro0Sz1ehDlu8Q7XeujjRWQO8paHodVI4Qd7YNLuoMiUXypR4b+I42R+NVdwiksWOlW1ZZ+IgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5949.namprd11.prod.outlook.com (2603:10b6:510:144::6)
 by LV8PR11MB8722.namprd11.prod.outlook.com (2603:10b6:408:207::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Wed, 22 May
 2024 13:23:09 +0000
Received: from PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861]) by PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861%6]) with mapi id 15.20.7544.052; Wed, 22 May 2024
 13:23:09 +0000
From: "Nechita, Ionut" <ionut.nechita@intel.com>
To: Philippe Gerum <rpm@xenomai.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: WARN Kernel v6.9-evl-rebase - do_int80_emulation
Thread-Topic: WARN Kernel v6.9-evl-rebase - do_int80_emulation
Thread-Index: AdqoUB42H/OnAc6gQSyqVaNVHGTu7wAA2ngAAADkauAAAU+/AAAAI7fAAACbpVAAjtw04ABr89SAAAAbP3A=
Date: Wed, 22 May 2024 13:23:09 +0000
Message-ID: <PH0PR11MB59491ECBE8A1CF6C2D7586F6F4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
References: <PH0PR11MB59492DDE7F2301CECFD2D8A9F4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
 <877cfsskke.fsf@xenomai.org>
 <PH0PR11MB5949EC28B447C7534BF8292DF4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
 <87y188r32a.fsf@xenomai.org>
 <PH0PR11MB5949CA43AC47E322BE97B5AAF4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
 <PH0PR11MB5949D3CFA8AD77346C36097FF4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
 <PH0PR11MB59496A3A9FFCB39B7715813AF4E92@PH0PR11MB5949.namprd11.prod.outlook.com>
 <87a5kirnjs.fsf@xenomai.org>
In-Reply-To: <87a5kirnjs.fsf@xenomai.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5949:EE_|LV8PR11MB8722:EE_
x-ms-office365-filtering-correlation-id: cf2cc2cf-f83a-4e2d-760a-08dc7a6252c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?PA2SThFihLO1TDtTQx57O5WRRmDWvpNszoONTKyZO2THeh7iCSQEz11wvhs2?=
 =?us-ascii?Q?QYb8jhYJtxLa1FZ06eIiK1yFLWoBpgaWNedeARAzG1DkSyvN2HJvBmk4Bbce?=
 =?us-ascii?Q?I70jw39GMlqGur8IifQ+Pl2QW7ypbWYzPYRZy1udKWHEYPeXW8nKgYGnQMj9?=
 =?us-ascii?Q?0lwADvoSEzz1z8Cc2GtCVuHDjQClYdZVJA7eNY8NMITwktNhBvQ7LMcNPcbI?=
 =?us-ascii?Q?K6qDY4PA9qz70Utzg9SxcTQ2oe/WuDisrlcrLEsYgznmUog+bXZhkY0X3Sf3?=
 =?us-ascii?Q?i5DO1W1IfHWwIh7xLRXsNRUXqC/Mq7yLO0Bw9iRFEdzKyZH93F/WXYG40nUP?=
 =?us-ascii?Q?we4uU7CKx6nGBU4USZQTfKLnE/8wjLaMdo9gUDhZ82mY3wFyQz2ZcicS0Uj6?=
 =?us-ascii?Q?eUZw2eF24J0m6MQqOhTNOxiPwSWMTNJ8wuOd4j8wKJfi4Vj9xRfjFxdCdl0X?=
 =?us-ascii?Q?cwy28d9oJ0bNb/+AOAMyPeFDgWxN5kbGT9aW9k4cDQVJqL6q1Qz6mkotCfGe?=
 =?us-ascii?Q?lCCU23+SNv4FRIbPZOZcgDDvOhb2QIMCizhvX/CyootQnZsS/lgmiVpkI7sh?=
 =?us-ascii?Q?LDaYNo6jNSZMXxJ4+Zh/mqKTL7VP9mHoVhKvoxa5MO/MVZwsgZ6Ynsbj3Mrv?=
 =?us-ascii?Q?5JLZ/onAEvtVridmpn/bG8QGHFF2uYtWBao90raFFZ1Us41l/nDiY//nhMcI?=
 =?us-ascii?Q?+tJHL/CzrRJS4i5VCgexsrt+YcTnyVKRVuU9oru0zGMcZoOHccLU9iL7W1W1?=
 =?us-ascii?Q?RFyBlllo4wZtcZ5rjqba5J0WDx5pmk2hCLF+fpLWp4IOiPC/spG2Mr8+xlf+?=
 =?us-ascii?Q?ujNE2sotp/44Dte4nOyLvVaD1nwNj7tniGZSV+rs4Sb9rNtourbT2+pzYw0r?=
 =?us-ascii?Q?Fj11MVdhIbRUcAvRg0cCUIqjOOC7aycvqU0RPZTUB96/r0XbCeagtqsqfsir?=
 =?us-ascii?Q?1+nXbIlhQ6eaBxZTMaKQskMyFoUA5ylngYzExDxJRknJnwcP/Y5nG4XAZl/c?=
 =?us-ascii?Q?L6DuakHI6YJVAXV8X9uFESRE8WMtO+8JC1J6JOBhM+ZnsDy9zAOwpi2n0LKR?=
 =?us-ascii?Q?xa/CVj9N8fGgRwrEKZiDP2uRiCl7VJJfQGuVkWYoBf9Nm8jUUW0rS2vt4as+?=
 =?us-ascii?Q?224npJ/oneXPfTU6yq+LU8gZvj1n45nSwgAixv4q9da1j+f69xBbVDcwZaQn?=
 =?us-ascii?Q?t5pj9I+NegT7sazbLuoiaPWhURIJx8MHErKHEvzS7BfiRowlfPIdktrYRUeL?=
 =?us-ascii?Q?wBDwY4wsTLfqTtMIaLOTjYRB/rkGjjkZ0ypd1jK6am8fAh0joaJkEmgAKYC5?=
 =?us-ascii?Q?HhsgjDVr5bFdfREpsxL3S8SStY5ZB48s5HvGJyRhq4N/ag=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5949.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?d8UoBwTb7bUPxWxPUsUVldUQ7NTGBWw2K7X8j40qNbHqscs5CENpcURXgrzo?=
 =?us-ascii?Q?hV6ONmarKCElovAC8PoPQC42o5N91VrsuBd3GJynr8S/5ZGUrMzhm/cxbaIc?=
 =?us-ascii?Q?y4wqXrFdrOVbR8ACTaggPN5ITzxQ74PlYOYKpj9ozHxTJrgaUJ3Tv2Y5bhly?=
 =?us-ascii?Q?Sm48O4lorM7EsFm2QjkFU+/1E4kRmpJ8CzvicmyBL7JYty0Kq8DrzaRqa04E?=
 =?us-ascii?Q?8X9QEj0F7jDRrBluZI2AJ8QJQYUXoc8WOEQOLqW7A9l1VkskSVEWsU/hVCsA?=
 =?us-ascii?Q?fHlGLIuGdqpyzA+/JHqR3V00KLOF7V2E+sYjjB2RppyKHrNRKlw9aFvMfEq2?=
 =?us-ascii?Q?JXOVHjG+NcFWkZkMS2SulMZkKAdmhYdVP3VNjZ/DB6oVKyWOBIJrXO82q3bs?=
 =?us-ascii?Q?uNXPSTxBmtJTPeLcEOB1pkyh2rVfA+efus6w3TMh5Nafkdy3zlJHh1n6K/nt?=
 =?us-ascii?Q?SPWQbQaVMrJOJEiHhgR1XfIzvshEX8XjAw0cWYLfTjAmyFlo+vXGQSCCuXm+?=
 =?us-ascii?Q?FMZcw/hSFKYPTaOx3N/CNHs9/pidOoD4c3tcsvsQHaBz8ITMklo8zMS5X3hO?=
 =?us-ascii?Q?jYNLKYP3K5caM2/z2amoK7YA0OAAU7Jl/jOuw6d8DdQkHjLhd4/nLuOpNX9W?=
 =?us-ascii?Q?tZQIjGQ/fFD+mcMA47mE/r1xuCw2VYdamrG+YBGfpBYP7m+PnldDF0XWryi9?=
 =?us-ascii?Q?L5tnVaoapvF6V8e74ReD1p58dNXzJ0Izya1fbWmkQHhq8y1GiucAUReeeHWE?=
 =?us-ascii?Q?/6o/fnd2rucI+fXXvYmDH/YGM2RfEamnIs4m50UqxFbx+Ed6sUneNhaXSizs?=
 =?us-ascii?Q?v8wkGjKcPSQs0qLutqjqhH+wQUNkrSJz9IG3DCEuSzfWlKC/h/foxHg/71cA?=
 =?us-ascii?Q?WVNtUqKkmhskG0j+x2/vYSOylmYflyxodKyoeCHPF6lWehxoYfe2+1zugB1G?=
 =?us-ascii?Q?KKJLNdaVrwUMpHgIPhoaZAn6w35P+4q8bx93s8RPdH/1Ey7KUQPOjFsnywnC?=
 =?us-ascii?Q?b5b4VwT/Esp5ewEX9M2VlOjrHl0msS0KjVbZcb0fZFpzkqTTldQpwPDTk0Ym?=
 =?us-ascii?Q?SS1U0xbSFyO58jYhbsgilLpI25w9+BHnNV7Z4do4y8TCQEvZG2k5TcOCbpjd?=
 =?us-ascii?Q?LtqvaJWmj/n4iiXDCLlay72wsxMqT912lKu/nY+eBkyZyoNnE0/5ueQ6LAb0?=
 =?us-ascii?Q?4m4sdwGI3j2Sgt9PMUEHdevJEmE5Tw2AgmAGBwu7rYyM5GX7uV7qgGsCxvQ4?=
 =?us-ascii?Q?zx1p+pdQA5U6PV3m0GA/jDVfhWSXDcgMo0jZpU/hvV1EwcLOSFV6Tih3gk0g?=
 =?us-ascii?Q?yOMe7Y48gGIZK5Th85Pv7ai/hNjwb/JZonATI6JcWLFyiXdaX9KeWZh924bP?=
 =?us-ascii?Q?pr9zDuU3DRrz9P4mXn0dFvZVZrlhOSCoV/ysewprvhEsRdQzvORIvc/JauS/?=
 =?us-ascii?Q?IBJI2QdeQB9wkRcJeEZTons4LDTBZMSehqvYsfv7RVjFEGqSTxlgbKttjAra?=
 =?us-ascii?Q?4gwrr1SAd8VYArCVg+wF47iXyzo8pG7xMiWNA0A5m5S8degNqIV6uWF4Tlsw?=
 =?us-ascii?Q?8mlXSr9Fu/o2Om92Y7OnLheb02N7WgawuPLT5ixH?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2cc2cf-f83a-4e2d-760a-08dc7a6252c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 13:23:09.3581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pNdPj+M01Nw5lRfyyDmXZHABMYYp/Ph5Na+JCnKiHWcd8Icy8yIwX0aZeATZp3r+TPEXH/Wtcu8B07Qu8uAvkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8722
X-OriginatorOrg: intel.com

Hi Philippe,

Thank you, will try today to check this.

Best regards,
Ionut Nechita.

-----Original Message-----
From: Philippe Gerum <rpm@xenomai.org>=20
Sent: Wednesday, May 22, 2024 4:19 PM
To: Nechita, Ionut <ionut.nechita@intel.com>
Cc: xenomai@lists.linux.dev
Subject: Re: WARN Kernel v6.9-evl-rebase - do_int80_emulation


"Nechita, Ionut" <ionut.nechita@intel.com> writes:

> Hi Philippe,
>
> You are reproduce this issue without CONFIG_EVL and CONFIG_DOVETAIL enabl=
ed in config kernel?
>
> CONFIG_EVL=3Dn
> CONFIG_DOVETAIL=3Dn

Yep, this should fix the issue. This bug might have been there since the in=
troduction of scoped guards for hard spinlocks. Checking and backporting fi=
xes if so.

commit b51c3afd66c8763bed7a4b8258cc5cf5c8ebd719 (HEAD -> rebase/v6.9-evl)
Author: Philippe Gerum <rpm@xenomai.org>
Date:   Wed May 22 15:16:52 2024 +0200

    irq_pipeline: provide placeholder for scoped guard w/o IRQ_PIPELINE
   =20
    Signed-off-by: Philippe Gerum <rpm@xenomai.org>

diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h index eb8b=
4d386e942..545368b045e52 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -612,7 +612,24 @@ DEFINE_LOCK_GUARD_1(hard_spinlock_irqsave, hard_spinlo=
ck_t,
 		    hard_spin_unlock_irqrestore((raw_spinlock_t *)_T->lock,
 						_T->flags),
 		    unsigned long flags)
-#endif
+#else  /* !CONFIG_IRQ_PIPELINE */
+DEFINE_LOCK_GUARD_1(hard_spinlock, raw_spinlock_t,
+		    raw_spin_lock(_T->lock),
+		    raw_spin_unlock(_T->lock))
+
+DEFINE_LOCK_GUARD_1(hard_spinlock_nested, raw_spinlock_t,
+		    raw_spin_lock_nested(_T->lock, SINGLE_DEPTH_NESTING),
+		    raw_spin_unlock(_T->lock))
+
+DEFINE_LOCK_GUARD_1(hard_spinlock_irq, raw_spinlock_t,
+		    raw_spin_lock_irq(_T->lock),
+		    raw_spin_unlock_irq(_T->lock))
+
+DEFINE_LOCK_GUARD_1(hard_spinlock_irqsave, raw_spinlock_t,
+		    raw_spin_lock_irqsave(_T->lock, _T->flags),
+		    raw_spin_unlock_irqrestore(_T->lock, _T->flags),
+		    unsigned long flags)
+#endif  /* !CONFIG_IRQ_PIPELINE */
=20
 DEFINE_LOCK_GUARD_1(spinlock, spinlock_t,
 		    spin_lock(_T->lock),

--
Philippe.
