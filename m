Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC47C36BCE8
	for <xenomai@lists.linux.dev>; Wed, 14 Jan 2026 06:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768371208; cv=fail; b=nDYq/4UqmHrjjk7/XAuZ0rStGpbaz0MCigv31HCbxfZnYXeEB3jGi2H6/xJQOo9voUiZXVx8ZrUCRgbSaNY09kM9QgPcj5yZ0yyg9YjdDmJNncI8TCaCniObn8CSZijw9q1llsqf54a4zyhQTh2oDxCZla6xLBRtMaAjbyxFvjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768371208; c=relaxed/simple;
	bh=qY+o5eEFX/JgOL1sy1UGJF8W7IP+KuEdAI0CzDGwz0I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rnjv4jvLfBELV/qlZzjXD6cjKpi3BEF/GlvuDcLo4Y3jAZrzl8s6fa8lSnVhoLofLR+iwCwHzHO//9gksdqNyZtBNelcuUOdJ+lir6OjhtFZeMkEa/Bj6l/ZorCUDoUYVFUwAA05NDb/0oUY1nbVkZq1w/rVVh3oYMJ1wCa/RcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XP8DUPoD; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XP8DUPoD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768371202; x=1799907202;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qY+o5eEFX/JgOL1sy1UGJF8W7IP+KuEdAI0CzDGwz0I=;
  b=XP8DUPoDDB7liwT/z/Pjnwg2CXwPo6WZwUj4xg8OenhXh5sASHcpZFfi
   bc/lmIvH5IaEsPLQw/rBeJRLje0FXcnxDubvjd0UoFMyrWTsXNGbIKJJw
   EEsNWr11ReDxmn+rZjht8Czfl4hIkDG6tDtMJ134eN9O5BuwWpplFI7BG
   YdAp5CrXvqDtjBlvAJOKL+IFnaygxq9mWOOyvD5FH2rXIW8+T/KfR32sL
   zEckZaezDpBqw2Re+ragubH0WKOihHw1GPqCM8oeDi/O+EYrzorbBbcP5
   kLAzzVnq0JkrmDAtOIyeh9bPkNGd0yMhokZtvF0a5LkJMkJleAW4FrO4t
   g==;
X-CSE-ConnectionGUID: qtOic8LjS0Cv9DbHsBKc8A==
X-CSE-MsgGUID: ka4SI6iYQeKORmFiwIX6+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="79962556"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="79962556"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 22:13:18 -0800
X-CSE-ConnectionGUID: PyeJDh2HQ9CZf33Z8Fpc4Q==
X-CSE-MsgGUID: OTKJIRn6RySKJBg1vBFVgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="235308955"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 22:13:18 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 22:13:16 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 13 Jan 2026 22:13:16 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.69) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 22:13:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=khQnYYpnKOxQTejkZ7KtMaTUuwHSTUvQVFXDw6p/kjgwUgtdoCtNqeHWdSQXFLgf1AzRxI8HruYQzADMTqJMEKJiWbF0ofiEciMnhHAi3GY0d//OeeD/OuDT9Hw+OuZUDed4OkWw7KaPC+U5JfHwgfqFWOMWzhx9VFCH9BCrDS9OjPQOLYx4cg8Ff35UnNxKbz9xB+WQLJHFiLkHaf/pT6oBiEnPcC44WgODTADVDzftClc/tLmZZV707TlmAY5aVfxX23M2eyyGyF9pARek2KdEtQogH3PhHiiGyFJtd5dHefGucmza54wiyJhFRH7iVtN+ppKKXagJL993cgLYzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfDERsISZA6bdRLqVZelGhUMhc2/uas0KLL2GUUrc5k=;
 b=Ugy9ktSdMKBwMGbP62Wd8Y9Ygs5dmRNMkxIRfHtMLS2ZOHxN/EFebgUdYAUfQLlL0lXn6AIlsIPrSLyYD+oyIcxJPmrlhRg2UJU20oWcI7MUZLiXs+JCYdzSNvWDmJwH/ZMnbgrIj49t0BUQEvC5OMkK70MeVDalp1Hv+damkPNl8ELop11elHzqHIawN95S1ZEpvolnmJ+StkPvq4eh1pQ6niYpTroQocylKfyJbGzKWeSpCmTq1XNpJdCu7ZL3vk1NYGo3k+1gZn5Dw5KWt6BP2Ks1SflC1HxI2TeV/X5P2sLzH2KYcuWgop4ZYBSenJMAkHgz2Za95tVS707emw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8134.namprd11.prod.outlook.com (2603:10b6:8:15a::9) by
 CY8PR11MB7267.namprd11.prod.outlook.com (2603:10b6:930:9a::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.7; Wed, 14 Jan 2026 06:13:13 +0000
Received: from DS0PR11MB8134.namprd11.prod.outlook.com
 ([fe80::d95d:cb19:df8f:1610]) by DS0PR11MB8134.namprd11.prod.outlook.com
 ([fe80::d95d:cb19:df8f:1610%6]) with mapi id 15.20.9499.005; Wed, 14 Jan 2026
 06:13:12 +0000
From: "Chang, Junxiao" <junxiao.chang@intel.com>
To: Philippe Gerum <rpm@xenomai.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>, "Wang, Yuan1"
	<yuan1.wang@intel.com>
Subject: RE: [PATCH] evl/net: export sock_oob_bind symbol
Thread-Topic: [PATCH] evl/net: export sock_oob_bind symbol
Thread-Index: AQHchG90mY6qjUCSeEKXCDaOfDomhbVQL9lngAD3JJA=
Date: Wed, 14 Jan 2026 06:13:12 +0000
Message-ID: <DS0PR11MB8134CDAE8606193786327437EC8FA@DS0PR11MB8134.namprd11.prod.outlook.com>
References: <20260113094852.2806192-2-junxiao.chang@intel.com>
	<20260114092711.3204218-1-junxiao.chang@intel.com>
 <874iop36pf.fsf@xenomai.org>
In-Reply-To: <874iop36pf.fsf@xenomai.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB8134:EE_|CY8PR11MB7267:EE_
x-ms-office365-filtering-correlation-id: dc155746-5657-4a10-bd9a-08de5333ff87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?RfXONKzn+m4+YYnint/7MYS21OM84/oI/1Np8g203er1wKHBNPOlWkDviimg?=
 =?us-ascii?Q?fKV4b5wutK9UxIOQx8NGZW6M+7Z7FQePBx6gnbhAd7zwl9arMOafejuSL9Jv?=
 =?us-ascii?Q?LsMnlHiZrFLssVROpl88slgyFIMAFmvrreYgj3zzNckee9akIKvBywYDpdkM?=
 =?us-ascii?Q?iGz6PdkmBrSMjs9qC7iTlvYp6134ZJhc0eqCcbSli5eJKSIKpkgCGdHDjh5U?=
 =?us-ascii?Q?msCsoFmGH9IYvEMj/ESpX/n9/o2Mexf22mKchYAsVQ8oENjV4vSnw69uv/7C?=
 =?us-ascii?Q?2D1RWXwbHUNFt+mhpyvxstsIAw+ZOYgQZDtSD6tOoejf6SxVa9Na0U+isr1J?=
 =?us-ascii?Q?jXd8l63zec0ZfieEHyKNM96Y1YwsBiKyguJVUzWrVsOxpDw0W/nk8VCLbHAO?=
 =?us-ascii?Q?+kibyUFcybPOYgHqhUScLvJKT2BMBdtc0I78UiSe6bBmGTBKs96KYU0w2KFf?=
 =?us-ascii?Q?s9IexL5lQ6YQfAk7W1BTV66DKLzIhXW0gsa0t69yhkhlR5vh5rQTIlFbr6nl?=
 =?us-ascii?Q?dGbJFchX1lgvZFh4n4la+EDxLpPGekzWoOc69zi0zdm5l2kFSCn8QdqMnpyh?=
 =?us-ascii?Q?XwhZ42n/c2UFMJfiyxSx9/tsMuWS/suPkqXQuoo2I7kiISrnVhgawpPV58ec?=
 =?us-ascii?Q?/+gnJaVkTlIbWnbxwXiIa2kCumo7VqAuWw9wdFtkWzDBj2ntuJ0sHv/odKp2?=
 =?us-ascii?Q?FE/R3edQVNK93t959QWeUMsTwoN/K8p81fasYujJcbVUB8gSf1EG/rjnNxDz?=
 =?us-ascii?Q?qfzqnm4d6Be9p96r32PhOLSXAfWTvgyIYdkHt76i2W9b7qJ3Jyar0fXe8AjC?=
 =?us-ascii?Q?xhCRDMEZzHegWz2EnPoVsR4GSUMdW/4hI5Y8k4rgwY97JFloA5K2CAJD9q4o?=
 =?us-ascii?Q?XpRveuqinhJUu8gh67VNfbB2ssZxUEfAG/RpekmDAoTljRpEMeDpYKcO7m4p?=
 =?us-ascii?Q?1SE6yveFhFav2JHmDXycf2Q492MVQUN1p0ENXdfNaA+cTmhc59DE7+/lFt4x?=
 =?us-ascii?Q?V6/g58fE+3o0ogbnxFpXaXq2Ef9ET0YaDjtJ/WuVsSpvCKGRiaAGlfXICHjL?=
 =?us-ascii?Q?x28MobBn6pQEMSQiveyZ1AXqJuRLWalUKX01G2+VN7NR+nsvT00WxFhXEmJ3?=
 =?us-ascii?Q?6Km1Yb36NXMYPanUWMkIVHa7dyv9JzbNAFmBddHkLJoaRafrENNKJziEImDk?=
 =?us-ascii?Q?/DM0MdNZnQZkuNaXhmTQUylfZKutvMqI3at/QNVZNq1lPWQ6eZAMXZ+Ycb55?=
 =?us-ascii?Q?O/Ds3Qxbnp1r0V+0fF3ao52ixs5dC5KVUUCmtTYYR1xOQigjQSvU47ecZKQk?=
 =?us-ascii?Q?aMRD0QgsRdoL8CpV9GXY4t4GSyi6fFHwwA8gBAwPJkbS65LMj16cT43ml+IG?=
 =?us-ascii?Q?wZU7aLE9ix75Ankn6y/YKFcQyPBHSqt230nf088xkGpXqa6Yo83yzHQ+3frX?=
 =?us-ascii?Q?LI9pkb8xkMEI+s5ybANnpIE6rVtVFlNbyHxaTJauwt+BXgGsvjMM0PkptAeY?=
 =?us-ascii?Q?zo5n8cpHHWqfD5AhcU8SO/m+Z2Hp7hJrnf1p?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fp8MxcEQvqChCBsNxmZWpucoyrNNbv6tN1n/iFAIA0R+kobO5kyrR/0Nj8fn?=
 =?us-ascii?Q?PqgSqM3CPyDJHaFoAS1lKvb1otLMpEmshxbA80YEm8LHfQI4yolcgvTAlrug?=
 =?us-ascii?Q?eDE3sB2+klQI7vy3C2raMpSDFCDaohRS38Ru3fNa2++1Pp1Mrli0yMbkZtgN?=
 =?us-ascii?Q?iTJuoWmk7eFuVSeQcyuNBUlkw8MzzzdCo9klOfwW9yJDkYYkMK4w8OkVZOf0?=
 =?us-ascii?Q?b+mpqAjgFwpk86FcW+aJwhvUjXqfw4OKAJD9d+iPqOQZ2tK0uYyVCrF8lP5u?=
 =?us-ascii?Q?q9DjILiQWgd4CbMY+GMoR9nx8vbLnhuuxxn2qY+AMzp4BsxL48oL+kYutw1k?=
 =?us-ascii?Q?Xa+VwrCk596eZDM6mzFBDgBWtcu1dj9wizqu+aQ/H/r6u4SylXX4DlyEtXTp?=
 =?us-ascii?Q?C/tN1mdusaK/2t88uBdX8iYvsG3UIsZ2WervpQ8orrHzOjFMW6gOJb+oRnmY?=
 =?us-ascii?Q?fNhioh55FoiH4wGLEsmuJnsLCXP8TPsCM7rVWQyJV5McBDll6+lAnQhqX9nz?=
 =?us-ascii?Q?0r7xqG0whn4mxMbEh1xT1tdjz0++CcAxUJHeIEp9vGCZlva5fDGPSnWiSRWS?=
 =?us-ascii?Q?uGXTmkQuN/NpHGO5ent4FwCzChbiRcgQB0oqszc2/czLjD4fjV+1zZ51AfZp?=
 =?us-ascii?Q?SYDvV7y4nDH0vLU3Mncv4AN+SbmEmbaMsEUEfn5YlDa5kJIKzIGbqr/+CgD5?=
 =?us-ascii?Q?R128PZLJVSPoA+zyD6SGx9DmNzgc2EvvYlfmYMK0PAO/jitoNVDsQeViX3vT?=
 =?us-ascii?Q?U31NiTzxwiuNg46A9PcwHfIYeabelRqvmdvoTQX6s9LwPGesCsEPhWbNTNjJ?=
 =?us-ascii?Q?Jm0iwi0B5oSIu7YOYQrr4+TRNZFVjYJZcQsHeene5wDixefXkNRTau6K+duC?=
 =?us-ascii?Q?BX3k0CK5qiFkp9kbYYhZK/R++wDN5dNWsHUVcep9pNIIov46FzoXn/En2SUO?=
 =?us-ascii?Q?ZnVmqa1TSVl+p2QD8VS3fBK+1WpyZ7pmSkm1wMLZ2iHgqrK851Qa//xztq5p?=
 =?us-ascii?Q?7BdMGKj3WNAFb1vzzYontroxBing6D4Q7/kdQVaOXr+o9RIItkrOXx+ZREVL?=
 =?us-ascii?Q?bhRAIPQEUJWX+N9ecGS0hTy1Nz4VeKhkYgvYF8zdsDfFPoXt+h+TSHqK6l2x?=
 =?us-ascii?Q?RS3V4VfhlfZYpwqWsPFuDqgYhZ+gJvmiV7HrqRzVleT6qZlcVpf9nSkQmv0U?=
 =?us-ascii?Q?rytIYyq8kxeL5Jc0372HVXJSoDLwNvVPNtKMgsCKbqndfgLZDrWYAIeM2CM0?=
 =?us-ascii?Q?EakTS6gEwwZq6ER+jWBlQoPhzUMeMT1Un/st4XkO/wqCUmUKegDvA5nkpYH1?=
 =?us-ascii?Q?GL2vHbzaYrSPwctwmzLZ5qFLTa3n0SqESh0T63WwYTryX35FG2KX1yn9UIL3?=
 =?us-ascii?Q?qr3V6mRkek+rAYYz8itVD+EzDVIW3Tvjf/4CXVyzDeoT4QwhQjy4nmejPLd5?=
 =?us-ascii?Q?8lJh7vzuvNgtIWwvNFzARu8qAO1iH8N4NvTDLs0DQ0RwQWV7jLz+8twQcS+/?=
 =?us-ascii?Q?Tn5+Soep/VXGvfXIpowlwgiYW+DAuuZZ6KVJDaYguvGsslbU6xdAPWQu+rxz?=
 =?us-ascii?Q?Dy1SCIFCDSe633P6GIhiGrbPeyhqjVonlBTOsKwOl5q6pZKK5fM+Q4R4Z5Ly?=
 =?us-ascii?Q?xSCHELFd0m5S2iiGFgI48bGnC92xNGbzBnSsF3BiFkU5f7x+KNIgHo30K1iU?=
 =?us-ascii?Q?gP9jZ2wwJwUR5csa+GnciSkSALqIf98Do9e96g1HWnpDlHMjCOAb30SpX84k?=
 =?us-ascii?Q?WBMSLsEDYQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc155746-5657-4a10-bd9a-08de5333ff87
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2026 06:13:12.7714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Eps05zu0MJrUBJB+uVmnYFPlo2JH+2At/41QmXxGUjHT8qDfCFyXre4C6dUFacrZYyTRg5jybOC3QunCJ0mSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7267
X-OriginatorOrg: intel.com

Philippe Gerum <rpm@xenomai.org> wrote:
>
>Junxiao Chang <junxiao.chang@intel.com> writes:
>
>> API sock_oob_bind symbol should be exported because it might be used
>> in other kernel modules.
>>
>> Fixes: 9afaf877fa08 ("evl: add net core (EXPERIMENTAL)")
>> Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
>> Signed-off-by: Yuan Wang <yuan1.wang@intel.com>
>> ---
>>  kernel/evl/net/socket.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/kernel/evl/net/socket.c b/kernel/evl/net/socket.c index
>> 4c61a1c1f6d0..69593470d62b 100644
>> --- a/kernel/evl/net/socket.c
>> +++ b/kernel/evl/net/socket.c
>> @@ -449,6 +449,7 @@ int sock_oob_bind(struct sock *sk, struct sockaddr
>> *addr, int len)
>>
>>  	return esk->proto->bind(esk, addr, len);  }
>> +EXPORT_SYMBOL_GPL(sock_oob_bind);
>>
>>  /*
>>   * In-band call from the common network stack to shutdown the
>
>Almost there, I just figured out that there is an even better option thoug=
h, so
>that we can keep this hunk in the code which actually defines the interfac=
e. This
>patch would sit on the dovetail side (not evl):

Yes, below patch makes sense. For evl/dovetail, your suggestion is that we =
should submit below patch to below repo and branch? https://gitlab.com/Xeno=
mai/linux-dovetail/-/tree/v6.18.y-dovetail-rebase=20

>diff --git a/net/socket.c b/net/socket.c index 1ecf67b656c51..ba00e99b042c=
f
>100644
>--- a/net/socket.c
>+++ b/net/socket.c
>@@ -167,6 +167,7 @@ int __weak sock_oob_bind(struct sock *sk, struct
>sockaddr *addr, int len)  {
> 	return 0;
> }
>+EXPORT_SYMBOL_GPL(sock_oob_bind);
>
> int __weak sock_oob_shutdown(struct sock *sk, int how)  {
>
>--
>Philippe.
