Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E5CAD49
	for <xenomai@lists.linux.dev>; Tue, 16 Apr 2024 02:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713232928; cv=fail; b=f1TaeAYo9eNZ2CjdLfnHDUZDrUi1qDLjNe47oXszm1I+7ZMFJxevjZynShmNQ9Ts8Pmzz8V4oCRLnUO95YaHC1MeeBJOtOmgZB/LlY44g3VKKI5mCRy4s9ar5l1yfzL69B+uM2DqnILt1itX0rCzXzNNsM2m/LpXPWoHZ3kTq8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713232928; c=relaxed/simple;
	bh=8gS1MHj1ohprAY3DJxwLU0sO7FezLz+BeFB/XjDa6rI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=seaxYPGzYBrzzbx87FEqtSKIpO28PTjq1BKHnR86fNj+ElUJu1XhhJDBQHNDjYHhi/7xvkHhQPXXYT/hCF2eMm1Y7uM5h9fNjKu3FKieuwKFssC/qK9RlZpbhujmsW6eONObaVoiW6gNuSKFXDCTxF9xQPfhN/Ziw4UGr4TuJNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BG7nGVYF; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BG7nGVYF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713232926; x=1744768926;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8gS1MHj1ohprAY3DJxwLU0sO7FezLz+BeFB/XjDa6rI=;
  b=BG7nGVYFR7wyj/lEWlcFDs5Q+FKmykrWcNz1IwgtiAb1iKrH0Ji0F6X8
   322ih1M0Imkp5K6U5ao1R8k86hazIvkCgNv+ExzQyg6XkrywsfC2OKTJR
   3I224GUxqoXGcmYstREFUnuk/8K6ktoqV3YcV4JgW3oEPl4xcITS4smWT
   ToHjR3vy889+Fwy9RcwPPbJfDxpycC+I9YQcoosnv8zSUhKDZGREdol1F
   jfZb2b2JDOoyjGujDNyMiLHY+hGZO/40kAT8GjUhlp01rXCJShtzPecvQ
   kXBOuRV8/TFgGQx1j5C+a2AZkKan9ZYIKJG9Ndpc7gPHn0MEfj2MZTYxu
   A==;
X-CSE-ConnectionGUID: yjtGfsdQSJ6oBlnhK/idYQ==
X-CSE-MsgGUID: 0vW6pwZxSrSQw8R4EHZO4g==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8528534"
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="8528534"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 19:02:06 -0700
X-CSE-ConnectionGUID: 4WR7ZYvJS++T1LsCZJnCLw==
X-CSE-MsgGUID: AaKiVzkuTWSn/V6hIw29mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="26885414"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Apr 2024 19:02:05 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 19:02:04 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 19:02:04 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 19:02:04 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 19:02:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GRfcevGQFUEay0UfEGo7N6ZDUQpy6+nL2Ozf73jyc8pzsbSUFB4JvHd6w3cWBlx9mTg5ybHS532ejROvfg5xsQCTfneLCwS7J1qd6Md3ltbcIH5Z/4D5ms29JPXEcTMttIyYezmbpxgyN4B7x6suaSHLoH0zbx+kd1Pak+69/LKOgZbkJ0EEX5LDAG2MkJXpZQyI/wiEpzcNpXVCXwi9Kr+ar0frR8LIdshmTnbJ986NJuBSNxpndWCuDReuzB2M+iTER2xW4flR0nr4iRtFgrp3f5sHOfcNNZWPKJltp/ZixATY3Kh7kNanEXFncScl1co/ZIxDlXRVFnVq2Q7WOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gS1MHj1ohprAY3DJxwLU0sO7FezLz+BeFB/XjDa6rI=;
 b=cyqXJT35WnmYTQtmo03APl5ncjowriyBypCSBoUJAU2Gv0+UgO3GBxQ/YILPv6fw13jCjQUeIRpSJJRx/xK3PIuC+FRCsGP1lJ/7ZgJLEaZ9Cau7z4orXQrlHgbk/BTFtB6LLr84GzfiMjhJJhR8scPg/HnvZmUMrR4CSAAsg8M0WOeR/TpTPWFoSJvGNBOKwBDv05e+HiYfCZFjDutagQAlTlnATKt5Pln9AqRiyBULJiwmuCDhLFMLvHjgPne03d5qZQdOIfh/g71c4u476ARKcvPePtGpvVKfpQtbyVj/pLet9Uzrw/x/6XmE3PQcrUyJppBFBY5ngYmLSHZajQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by PH7PR11MB6055.namprd11.prod.outlook.com (2603:10b6:510:1d3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.43; Tue, 16 Apr
 2024 02:02:01 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::19d6:5ade:3ea:583d]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::19d6:5ade:3ea:583d%3]) with mapi id 15.20.7452.041; Tue, 16 Apr 2024
 02:02:01 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: Richard Weinberger <richard.weinberger@gmail.com>
CC: Xenomai <xenomai@lists.linux.dev>
Subject: RE: i915 GPU woes
Thread-Topic: i915 GPU woes
Thread-Index: AQHajq3zsi2ZmLu9sEGDKKyoZN+YZrFoul4AgAAEapCAASB6AIAAPEFg
Date: Tue, 16 Apr 2024 02:02:01 +0000
Message-ID: <PH7PR11MB749982301BE568CE531BB6FEF2082@PH7PR11MB7499.namprd11.prod.outlook.com>
References: <CAFLxGvyY+T1qQTq6gZ5UKfbZsxcan8adyj-Y95BCEA8SYe31=g@mail.gmail.com>
 <PH7PR11MB74999755B34FF7230FCAE0F8F2092@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74998A90B5CD2F8E507A20E9F2092@PH7PR11MB7499.namprd11.prod.outlook.com>
 <CAFLxGvzU6c9fz4DAATcq19iLK+B5o6Sjtovacfu1ikr935-1Uw@mail.gmail.com>
In-Reply-To: <CAFLxGvzU6c9fz4DAATcq19iLK+B5o6Sjtovacfu1ikr935-1Uw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|PH7PR11MB6055:EE_
x-ms-office365-filtering-correlation-id: dc158ca4-1d53-451c-0294-08dc5db9349b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lpjjQHa3DqBFMt3u6gXnc5ErWnvSzI6z7UP9rXGLoQEtYRripJJOQ/GhOrSh1dElMs8gXT0qZEYovyZL4ehIX2lCu5QLOX//f7vyQDn2SjshevK/Pr0YjmjxErAMAe2t60HB9XJJnHoubV0sQx8FKfNj9HpwLQPg4ezDTY372aqHcN7aY4PT9g+VfXQ7joNatx7/C20NK7g/FYzeFGkx/R3MqHez+sreO6ox++cOlf0DWWxoHc2NZSpW4dEf89e+kxMZNYVvnyej4gd+IPEJg3U1C/zZVC/nJ0OnBGqnUPIIyhlpKxDtSr7ipRSmMCEYVEY0mhcmfrwUwrm0CKQ7nxW1GR+uaeOOQ5dwHm5dwpZswM2JP7HNadcsGOMm/ClN/SI652KWMv37XG2YpUfEwwHtamTwnQ9Arv5+lCLUCzZYX9V+DF5OWOLOgyPYioPhOBmVsQcw1dqvuz49GDOSfRp6Y3mzFepar46B2qWZMpezP49PGQssU2qrjKNNt/7ZQXU+ddw4XgLBlwHaAn6E0v/QiQsXyAk4Tz86z1Iv3zdHGB3AK49snJ9DOxUlWTbc8WGwjWzJuAatzrAHHjcXVXruxmiH9ivHXX+gdDRinYR/GGkAcjDYfr331qklGHEYy+l1U+c5Q6mmvkUr/khFfuCw/jD/tSbMLVnGwSX/YOq+4oMr0GJTKms/UwIy0PRviMrTNs7reb+rZyge0zcP4upouDDmPCyQEeQEqAnagVc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mm1UOVBrTVlJRXhZMXdDeVBHWE12Sis4Q1Z6empmK2ZyZnVFSDhaWW8rbG82?=
 =?utf-8?B?S2JqUm9nWkI0MHI1REVHemJHNE1ubk9ZeFBIUEx1cnNwV0hUWVRDQzh2aVB3?=
 =?utf-8?B?NUtMOVhjM0N2citYZDkvQUN3d3pRVmUxMVhxYkZlYkd1SmdLTzQ4VTFQZmhB?=
 =?utf-8?B?TjlCRHBYb1lBTEtHQ2h1c0t5TDhPSjBuK0J0OHJZdjl1NVZjd01xekZqOXpq?=
 =?utf-8?B?SW5IOVpCdFA0ZzJKNlRubTNHUXFrdnlLOE8zamJaMU1iUE8rUU5rci9mS1Jy?=
 =?utf-8?B?OVUwa3lkcms5ZlZITFFsRHdycWtwZnBXZWxiYnRZZXgxRzF0QlB6RnNUWWRO?=
 =?utf-8?B?bVpCa0haQ1NXTjZUNXUzQU16encyNVYrVjlXSWtrYWp0UURTV2J2SW5FQXho?=
 =?utf-8?B?SmdKQWpqdmhkUVBxUTRFa084RHR3dExRVUlvUjg1NHhzTjlaVjNaN0tvUHdF?=
 =?utf-8?B?L013R29IcVFrWXZzdVozbXQwNFVZUG5GK2R6dGE0cHdZSCszemVYZTNOL2pJ?=
 =?utf-8?B?cTFJdzV5WGpWejFkR21sZzkydUc2cTNORmQzVTV2ckpLTVFIS0RtTTJrSXhi?=
 =?utf-8?B?bFJOYkdBUEFMZm9qUVoyR2xoV21YL253TlcyQ1RRc2EwYUpQbDBCWTUxeHJG?=
 =?utf-8?B?eGFNdjNFWUo3OFMwYi9UajZyMUVDTFhrUVpNd2tZVG13SHpGbERiTFFaVGhJ?=
 =?utf-8?B?OE1XN05OcmlRSVVLSisxN1ZQcG5sUXc0alAwbWZvSE9sMGloN25QL0UwcTd2?=
 =?utf-8?B?bzVzNzIxaERBYXBmVldwTVRBWVhBZGQwV3I0SEVEbmJlbEZVcFR6bzh2cXZj?=
 =?utf-8?B?aTdVZTNETzd3UHdaTTZ2UFk3UXF6cGgrOFF1RUZFdDBYUTBCY1pORzU0QStV?=
 =?utf-8?B?UFNsdzM3c0kyVW1IOWRkNkhEaEcvN3BmbUJWRUdZYW5TcmN0NTROU0lWdnJI?=
 =?utf-8?B?YWtwVCtyY3ppL0Q2bWd4TW05UDBZcEx2WXVqLy9Ia01MT3ZxQ1dEMm8vZGRn?=
 =?utf-8?B?MWQvVm1BTHlid01ZTkFRWEFaN2YzR1FRRkZ4d09pWnQzbVR4SDVUT3I5clpz?=
 =?utf-8?B?L2J6UVpYVE1ib1VGbTJDS1NyTXRSMUxoNWdXeUh4dFVuY2ZCWXJYM1hPNjgr?=
 =?utf-8?B?SjZUa0tMaC9OVWNHbnRJWFE2NUdLem9hL1hodXZvVUk1UStDN2t0clpVSk9E?=
 =?utf-8?B?T2RzMFNLZmc5K3BLNXIzZUpGMC9HanJ5S3loNkdNNU5BbGpjNitHVFhWaURM?=
 =?utf-8?B?ekR2ODZFblNBOUdSZGJGOTlpZHBYODB1WEpXRzR1RThyN0gzZklBZ1IraGN1?=
 =?utf-8?B?WmxJazYvN0c3MnNxWGwzVFJ0TWNXRlEwOUo0MEVBZ1p0MEdFa2x1Z0JpUnVM?=
 =?utf-8?B?ZTFJOWxXYjc4b2d0QW52ZkJKdXo0dkFycVZ0UnZYVXpqNlpFSDBBZnU5OVgx?=
 =?utf-8?B?WmkwVy9KNzRNZFNMRm0rQk82d0Mwbm1LUG9KYmNEWklzN0FVQ0cycTZMMXZa?=
 =?utf-8?B?V3FjcWhyajN0ZnMxazJ4V2VoelI5SzAxRzZmUG40Vm9OdDluWUpld1hYN0Rz?=
 =?utf-8?B?aHdkSENSVTdQOVE2Z1dNL3p6RGdreVM5NDFPUWt6SHdoVFgzK0ZkcmprdTZo?=
 =?utf-8?B?Mnl6TWFOUzgvN3Bhb3F5M2pXVm1wN3VKVXlWK3pFL2w2V1BCbXhaS0NTU3pR?=
 =?utf-8?B?amR4ZFRzUFBDQnhWUWFnRitmaDM4VWoyTXZmV05LZ0QxQk1KT1NaeUFNeUVG?=
 =?utf-8?B?Skg1WjFmdHZMQmJzSTRzdzhYWVZiemh1SHNIOWU5aUxPTEUrRUJSWVZQWnY4?=
 =?utf-8?B?TEtNNzk0cEdUYkpZMzE4NlY3amlDcFpRblQ2ZDB4K3U0V2lFemFwMGZoak5i?=
 =?utf-8?B?U3p3UGJuenF3bTBLdEdFNUx1N2I4N0g0VHRFL2tjUXZ5OW13WEdQUm1YOEhY?=
 =?utf-8?B?ZDBCS0QxaXBmNGhtUmV6RGt2Z0Q4cm1sWVZMekVKZjVDVGg1NStqMEV6SEMv?=
 =?utf-8?B?RDBiTGx3SUVCbmpnSzhaQmFTUlBUcFNXdml0TEx1dXBlSEdnVkxpbkRZY0d0?=
 =?utf-8?B?SGNzWjlRVFc3MFhvaDg4eTl3V2ZUd1JhWU1jSDF4eFVPQWdoY3FxalJZVTY4?=
 =?utf-8?Q?7FqcXsIscCzKiX9z84U+4q+FI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7499.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc158ca4-1d53-451c-0294-08dc5db9349b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 02:02:01.2407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hsp56GCxVBhC0bQH1WtbZq10Q0zE60cyBGKSvicnJq+rDu9TEGqOj6/l5EtDGJre3fYYIsTG7uiGTZtXQ7JytQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6055
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFJpY2hhcmQgV2VpbmJlcmdl
ciA8cmljaGFyZC53ZWluYmVyZ2VyQGdtYWlsLmNvbT4NCj5TZW50OiBUdWVzZGF5LCBBcHJpbCAx
NiwgMjAyNCA1OjQ2IEFNDQo+VG86IENoZW4sIEhvbmd6aGFuIDxob25nemhhbi5jaGVuQGludGVs
LmNvbT4NCj5DYzogWGVub21haSA8eGVub21haUBsaXN0cy5saW51eC5kZXY+DQo+U3ViamVjdDog
UmU6IGk5MTUgR1BVIHdvZXMNCj4NCj5IZWxsbyBIb25nemhhbiBDaGVuLA0KPg0KPk9uIE1vbiwg
QXByIDE1LCAyMDI0IGF0IDY6MzjigK9BTSBDaGVuLCBIb25nemhhbg0KPjxob25nemhhbi5jaGVu
QGludGVsLmNvbT4gd3JvdGU6DQo+PiA+V291bGQgeW91IGxpa2UgdG8gdHJ5IHRvIGxvY2sgR1BV
IGZyZXF1ZW5jeSB0byBtaW5pbXVtPw0KPj4gPiAgICAgICAgZnJlcXVlbmN5PTIwMA0KPj4gPiAg
ICAgICAgZWNobyAkZnJlcXVlbmN5ID4gL3N5cy9jbGFzcy9kcm0vY2FyZDAvZ3RfYm9vc3RfZnJl
cV9taHoNCj4+ID4gICAgICAgIGVjaG8gJGZyZXF1ZW5jeSA+IC9zeXMvY2xhc3MvZHJtL2NhcmQw
L2d0X21heF9mcmVxX21oeg0KPj4gPiAgICAgICAgZWNobyAkZnJlcXVlbmN5ID4gL3N5cy9jbGFz
cy9kcm0vY2FyZDAvZ3RfbWluX2ZyZXFfbWh6DQo+PiA+ICAgICAgICBlY2hvICRmcmVxdWVuY3kg
PiAvc3lzL2NsYXNzL2RybS9jYXJkMC9ndF9pZGxlX2ZyZXFfbWh6DQoNCj5NeSBzeXN0ZW0gZG9l
cyBub3QgaGF2ZSBndF9pZGxlX2ZyZXFfbWh6LCBidXQgSSBzZXQgYWxsIG90aGVycyB0byAyMDAu
DQoNCkkgYWxzbyBmb3VuZCB0aGF0IHRoYXQgdGhlcmUgaXMgbm8gZ3RfaWRsZV9mcmVxX21oeiBv
biBteSA2NDEyIHBsYXRmb3JtLiANClNvcnJ5ICwgSSBkbyBub3QgaGF2ZSA2NDEzIG9uIG15IHNp
ZGUgYW5kIGhhdmUgbm90IHZlcmlmaWVkIGl0Lg0KDQo+U2FkbHksIHRoZSBzaXR1YXRpb24gZGlk
IG5vdCBpbXByb3ZlLg0KPg0KPj4gSW4gYWRkaXRpb24sIHlvdSBtYXkgbGlrZSB0byB0cnkgdG8g
ZGVjcmVhc2UgRFZNVCBQcmUtQWxsb2NhdGVkIG1lbQ0KPmNvbmZpZ3VyYXRpb24gZm9yIGdyYXBo
aWNzIGluIEJJT1MgIHRvIGEgcmVsYXRpdmVseSBzbWFsbCBzaXplIGxpa2UgNjRNDQo+Y29uY3Vy
cmVudGx5Lg0KPg0KPk15IEJJT1MgaGFzIG5vIHN1Y2ggc2V0dGluZy4gTG9va3MgSSBoYXZlIHRv
IHRhbGsgdG8gdGhlIHZlbmRvci4NCg0KT24gbXkgNjQxMiBib2FyZCwgSSBoYXZlIHN1Y2ggb3B0
aW9ucyBpbiBiaW9zIHRvIGRvIGNvbmZpZ3VyYXRpb24uIEkgZG8gbm90IGtub3cNCmlmIHRoZXJl
IGlzIGFueXRoaW5nIGRpZmZlcmVudCBmcm9tIDY0MTMuDQoNCj4NCj5XaGF0IGRvIHlvdSB0aGlu
ayBhYm91dCB0aGUgaTkxNSBtb2R1bGUgcGFyYW1ldGVycyBJIGhhdmUgY29uZmlndXJlZD8NCg0K
WW91IGFscmVhZHkgc2V0IGFsbCB0aGUgcGFyYW1ldGVycyB3ZSBzdWdnZXN0IHRvIHNldCBmb3Ig
aTkxNSBsaWtlICIgaTkxNS5kaXNhYmxlX3Bvd2VyX3dlbGw9MCANCmk5MTUuZW5hYmxlX2RjPTAg
aTkxNS5lbmFibGVfcmM2PTAiIHdoaWNoIGlzIHRvIHByZXZlbnQgaW50ZWdyYXRlZCBncmFwaGlj
cyBmcm9tIGNoYW5naW5nIHBvd2VyIHN0YXRlcy4NCklmIHlvdSBhbHJlYWR5IG5hcnJvdyBkb3du
IHRvIGdyYXBoaWNzIE1NSU8gcmVsYXRlZCwgSSBkbyBub3Qga25vdyBpZiBpdCBtYXkgaGVscCBp
bXByb3ZlIHBlcmZvcm1hbmNlIHRvIGxpbWl0IA0KbWVtIHVzZWQgYnkgZ3JhcGhpY3MgdmlhIERW
TVQgYnV0IHRoZXJlIGlzIG5vIHN1Y2ggb3B0aW9ucyBpbiB5b3VyIGJpb3MuDQoNClJlZ2FyZHMN
Cg0KSG9uZ3poYW4gQ2hlbg0KDQoNCg0K
