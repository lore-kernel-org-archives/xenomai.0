Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2816625
	for <xenomai@lists.linux.dev>; Mon, 26 Jan 2026 00:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769386523; cv=fail; b=PUoExOHVE5RaSoNYrBU6IyArzXCFOp+eh1cIuYlkdOC5HxSihRsw21ght7gtQF7QI7I4snI2E6wn0y4SkjnuzOJ51SQQh/GvDPEYkCH4ROHvzd4GcTR03q+LAR878cJkWz3i48INOyTRMYMb1YcwgnnXR50ih/ZoxWYp2eA43DY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769386523; c=relaxed/simple;
	bh=zJjdOdzGbJVmAWv5dEGmNAuFYet6RCbDv3wfzsqPzOg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SYTxDevevzwMwA6D7VU+601GMImTJemN593gXmcxG+ZFUKlISdCW/Lcyw9jR78WF2+7nA4DE3P/rOopYsdvnR/grxazo+dzBW2oWTclrHMNo8+VgeU+UJ7xUm7qo9ugDwlRlyKdriXggUGqsMuRa4w7P5X9EL8Dq9UwOgELF0Ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BvXpXS2q; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BvXpXS2q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769386522; x=1800922522;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zJjdOdzGbJVmAWv5dEGmNAuFYet6RCbDv3wfzsqPzOg=;
  b=BvXpXS2qgWP2cVgI52hhioKe88gJ8jI6wAFkpjAQjl1oeMoR5Sv4xhOl
   3dE9TdZLTdCv5sl1LAsStU5nNJohIVXcRp3eeBvG09eDIJjR7j1KZyPiy
   vaRKsKEvfxZkDIAIFbpe7AsOmWweOlgxUf3s/YjCYYIiQHihoaVMjQ67Y
   7oGdNmLxuPf7VGvGFAdudXjsFzbCSOKYOcXDkcH4B1ez8YFOYQALE1BMR
   ekRaYEptmtTKw/2ael/54LMoqkywto3vWfllNeiSP+Xemp/O+6CixKJZv
   fphsTuKaLMOSaF7RCUeuj7WXfiGxRXyorA09Zrctu3GNgx4kK3Nf/4AXs
   w==;
X-CSE-ConnectionGUID: w9BZYOFxTWaH+om49EYXxA==
X-CSE-MsgGUID: +i8zCaohRyW3tpgJfBqhvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11682"; a="70725274"
X-IronPort-AV: E=Sophos;i="6.21,253,1763452800"; 
   d="scan'208";a="70725274"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2026 16:15:21 -0800
X-CSE-ConnectionGUID: eviie8MuQKygVeDudWLGdA==
X-CSE-MsgGUID: KUE3p0NcTYO4Y3DaME99ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,253,1763452800"; 
   d="scan'208";a="245157431"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2026 16:15:21 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sun, 25 Jan 2026 16:15:20 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Sun, 25 Jan 2026 16:15:20 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.27) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sun, 25 Jan 2026 16:15:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RdQMp1Xj1VGaoOVvysl84XO49QgdGWwKj391NXIjB/gu3WnPxWaR3gLAHKH/I3tXWU8VHn4ONocfJZqMidjQPaM3enRgRI3+vKhvuucUBYeQMq02WjFtBdZvVU4UvyzAFkSBs/a5X1VPpXRRZUwLWgsPHL+IU5SqE72TpUqscaCnKQZZrs/6nPxieJTniab9NbFGNBOqoYqJe9yOcFbYuxPoLgzm3V0+1btMEyMrTiv0BkY4MdZfBN2zU+sw6FpoXXm5gsDaXpimMEgAx4mzLiMNglygUykLq91BhQt+9LC5G/tpv0PzQCToOysXrLfsCRmcx5OC7chpFqRbVLXaQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D91omYCy2gZP+XhBmxy7Nfr4Kt+AzXSe30BuaHDWz8E=;
 b=emHMOwvirKWr7/sBLOXpweqcGLQ6wKNkT1x/8cWW2PbnbnYofA9Il36FrpIkrK0zzxcuq0PA34w9z2n66mFyalFqXrbqip3fUPwOigauulv2Daiii1W3aa+nrUI35b1vWBIoxgO4bnljaAFTT89SubPnX8/SJ0S4u0a1Cpe/6o+gKlb0Ht3Vgz5UMF1/7ntq8HHmUc1ieStmNRVOTnEdEbkH8OI6uLQyyn5QnUA1ejqHWlIwGlPeFiHbPi/KzcpktbBrdaWlXiR+zXBvJmVGnMFoIiQb4R+ZBmjucnUd9TcgCwCiIdWp0Lupri2kZWMNdhjJXdxhbERDGYkxKr5kNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8134.namprd11.prod.outlook.com (2603:10b6:8:15a::9) by
 IA4PR11MB9082.namprd11.prod.outlook.com (2603:10b6:208:56a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 00:15:18 +0000
Received: from DS0PR11MB8134.namprd11.prod.outlook.com
 ([fe80::d95d:cb19:df8f:1610]) by DS0PR11MB8134.namprd11.prod.outlook.com
 ([fe80::d95d:cb19:df8f:1610%2]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 00:15:18 +0000
From: "Chang, Junxiao" <junxiao.chang@intel.com>
To: Philippe Gerum <rpm@xenomai.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>, "Wang, Yuan1"
	<yuan1.wang@intel.com>
Subject: RE: [PATCH libevl 2/2] tests: ptrace-sync: only integrate ptrace-sync
 in debug build
Thread-Topic: [PATCH libevl 2/2] tests: ptrace-sync: only integrate
 ptrace-sync in debug build
Thread-Index: AQHcjF4OLUYWIaFriU674WiN24Y/PbVfv5F0gAPWw4A=
Date: Mon, 26 Jan 2026 00:15:18 +0000
Message-ID: <DS0PR11MB8134BB62524904A194119EF3EC93A@DS0PR11MB8134.namprd11.prod.outlook.com>
References: <20260124114232.1186577-1-junxiao.chang@intel.com>
	<20260124114232.1186577-2-junxiao.chang@intel.com>
 <87ecng1ms9.fsf@xenomai.org>
In-Reply-To: <87ecng1ms9.fsf@xenomai.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB8134:EE_|IA4PR11MB9082:EE_
x-ms-office365-filtering-correlation-id: b82a4cc7-f25b-435d-1103-08de5c6ffc8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?3YUzQCdsoh9RQCxMYvG2bcduqyv6RJobCTcGL3HP5C9wUmsN9TAK53tG+0ZK?=
 =?us-ascii?Q?C4B0N7xeN/v8JzLy7l6T2M+6/bFCYO30CM4BBVbvvCjPebw06nKWTlRRVR8p?=
 =?us-ascii?Q?ux2Dq9v0ebxErSxwh5xCwgMf/wO8cNOHYxyhdHuJG7r+u0gnMhJ0K9AeTxqU?=
 =?us-ascii?Q?QH1ULOjFu34f6jniEGbUcooqiJDKLI5mkKwInTb3ZpoSyRdIHxj8WotKdNNC?=
 =?us-ascii?Q?T4Hoyk1OGdasqTXvNq5M2T69lUoXRJxwjOWNTUZzNugsK7Mo5gIIcv5Qaz01?=
 =?us-ascii?Q?iahKq3qHKOVhh6cTKspa46iicePXWG+C2dTVeU4jDm9ejlbJ6gyckj5moOE4?=
 =?us-ascii?Q?jcgPAgzEYZON6I96roWLJvU2AAmeQArax7fWiofckUnz4CONGWzut4vzBvJt?=
 =?us-ascii?Q?taksDL44UtAHffaf7Cr8K4LDQoPc6yPECvSM6MU3t7Oz5TIjosuZ9il6AHqe?=
 =?us-ascii?Q?m5c0AhJxVjFjfjPCmZJHKrDt9hSZfrk88t1vLNSQNVsPhbyaBuaJq4CKWSLg?=
 =?us-ascii?Q?1pQ1/nKZnbgCCT6OBfbIkYKQ2ekXtDsMZYpQODcyzPiWmum6gyI7k47TeQE+?=
 =?us-ascii?Q?mmkVcvZADUPoJUI0qYjhwUV4/FuOlJ0HtXZaq0Pz6416j0eeweBT5Vm0M/0E?=
 =?us-ascii?Q?RTzfIDQFif6TuBQS5DiDluoyqrposEennsagoWdMZclOZZR2377lxhYaoeLF?=
 =?us-ascii?Q?c4gUcWGev6NRgZn4KSKmZgHG3DnfhIcBzvMjVfhd4VGxMpwQ7j1txd3xOG0b?=
 =?us-ascii?Q?PuV6wZCFgu7fxrMFKIH+gZQYXlXFmvKAGaEOh01hgE2V1SW4iHrammyOJCy3?=
 =?us-ascii?Q?NQ16zhSXjVyYhMaLN9++Qud7yO+Y7pig6cAUh//Tnmcxo8X0r38NIYuoY58x?=
 =?us-ascii?Q?DY1lj1JwKoDeRAZ4kwNtkOmXtiDjS69oWhod8YI2BuE5JmiyhR5UplGSio6y?=
 =?us-ascii?Q?QyAc83tMOAyLw3AifTreoAv3khXVMrl3J9NrvwkchdInM+DSXwJFiO3IpEqK?=
 =?us-ascii?Q?EsiGADAWZ25VC/OcrN/y9A14c5SlbKOAjzylqlgzH8GFFS3nUj41OU435u3L?=
 =?us-ascii?Q?LLa+g/jl8UhoFdSiKuFfOmNcv9MjJRD3B36OgiyRYHWEIJuvgeKTrbjRE5Q9?=
 =?us-ascii?Q?ULpabXtL7a8xT2BKNbWTGG+5MfS4M24ev7kY/BJaPgzsErpMJvS1fyqsV+zz?=
 =?us-ascii?Q?z7eOL2alNIteP11FKPPJ3JGEW+OpQACbRgxf9/DenEiSpSynTHV3nOfJ3x8p?=
 =?us-ascii?Q?y3FI+ApLfkKXZT4SDW4NAeDxzAIqPo1imegPGBfXLgB33bob74ChO3grc3g6?=
 =?us-ascii?Q?/coh8onWwemvqIfQjMA8hFP1HnZeoyjJruSA9HXe8Rqg8GYlpnMM5ZS1VjDh?=
 =?us-ascii?Q?Y+V2FzmQmDTvsFP1js/1GRLx+K4sYTy2MUKC/5aifu8DnklCZ+rMxYm7C/YX?=
 =?us-ascii?Q?19Zs+5x0Ucr+GllmWllgPJp+rsE2ALSZQV9Mu2mDbQ724Jn37SX1DrX9MdeS?=
 =?us-ascii?Q?n18dGqcCvjnB+ZxGjfiF+dyW7U6HbA9XxzRs7k2QGb5vw8I/DiMU/W6ltI0p?=
 =?us-ascii?Q?7KIocmgSnZaCRUiLdkS9b9xxPTihhMs3P4DSs4v0s6jiDRqMXC2kea5o8uXb?=
 =?us-ascii?Q?+Snv/cpfiX8T9h1I7/Bio8k=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D3XeAriVhEEn2Zm61BEU6LH0QFoQvV0eROvP2UZy9zTEnW738+Utm4e0yEiy?=
 =?us-ascii?Q?+bq2icnLupg5CeIyCiojP4i19Qw190yMBiF1KYpUbmWyu8HIcEMXAx+pT7E3?=
 =?us-ascii?Q?KMWmdPCvukgU0MRJb9bp4tdJaaxIN+5/eggyOjpE28BnZiH2MmImJVlnJ/5b?=
 =?us-ascii?Q?GwJQoA/Q+OFfRThgf5hmMqeeeVSyXqsyqNKLa+ODLUJw4iicaDZZrYvBTiZV?=
 =?us-ascii?Q?1dvOnUjqQ+dS1JHs6qN3A0/3iwXMt+2606CAwqP8iz2xLBQ7DautnSppikE3?=
 =?us-ascii?Q?0txIFfV+Sf6gJdjvF6Zdn+ZegqTjbwbviRIeM0plq7yK2etRMhYnNPCSuT++?=
 =?us-ascii?Q?6mB2hq3F/uPSnK22NGmv6jRAbgSe9bDnA8w45Dl51yt6Xi8xY13Q2+jPde1u?=
 =?us-ascii?Q?pCVNym//6Tvx/2rfyIJ8ARlObHXp6kQLFIY7+qMDOuZ0F0a7P1WJBWWxsCog?=
 =?us-ascii?Q?ixk4O/KhXbe2NN1qlLp0KIizsX81MjAKtMcJbKFw6cL5S7S9reUPbNzwtfkx?=
 =?us-ascii?Q?tqGPfD1pZYi8YBo+V2xDmBgRrkJSmB1Zi8tDcwzIlTc7EIQvQZkPcyLyjbCL?=
 =?us-ascii?Q?yjNxmFENHQYDZNAAXOVxjKPpoFgkC+2SoDrQpSx1YA9mpgrw93phUtJSM3Ln?=
 =?us-ascii?Q?XIF+4DxdnNVwVRoLO7ReDrLkJIY2pOdyJUXyzx7ecxmC8aP+GCwomD522DQS?=
 =?us-ascii?Q?oPj6CdONFUGLIDQlGFaHkRMbXNP4vmaa/Hg/Up3uhRDFeMjmLltu4ffdlLpj?=
 =?us-ascii?Q?DV2pNv1DaImc5cd4459KMtjZ/8IbpvoRVsu2dTabpIHlWOS6u0atoEaDscZw?=
 =?us-ascii?Q?eOUGcAyE9Wfkx8OHfF1HsaiDHtTtNUxjDRLXTwh0uGYRmJmIcQtKa8H1eu2Y?=
 =?us-ascii?Q?8rO/06EgAL1azsXqvaGgAEn2rU/NhtYVS+wVKMBWPp94AbtIEmEXJrXFCUDC?=
 =?us-ascii?Q?FWgEguIgZPR4lu3/SSpNRTaImxaCA9WAyqrXM08KHVuf85u6m9Wjw1D3tv5a?=
 =?us-ascii?Q?ioNnGcNOcXJveXbX79a5AdmWd9u9FFjyCxaETueIr+7xncI2hfP3ticu6X3m?=
 =?us-ascii?Q?5jqXUXZfd4/SaZVyID5yiJsFphh2VQucwHlFoEVfeaMzYwYL63WV392yplig?=
 =?us-ascii?Q?03ptHvXQ/qPSkKJd7fPakE6j2lBEl96HbmTIfaXQG+ppKucW+KcPme2w5y/8?=
 =?us-ascii?Q?m5hkcu/2J3Rcu3EGKAtuODkdts5C7xsR+EzHOg60LW+ygVYudLBGVlQpClMQ?=
 =?us-ascii?Q?rRE7GX8Pr4Oe/x4k8FduAzFx69QMuz8QCcPNAUukWyrNDfLLI95s3JV9WR51?=
 =?us-ascii?Q?piHIo+zauRmjRr/1kR+Lb+Xb1fKZbm6zPuS7m3tUbVOoePf1dWsAxLA8SHGr?=
 =?us-ascii?Q?qn06j8FMr56rckEVynchWhwOnJukIpgdsTXE7r4lPZDPfYcPC9UyLh5YHxBC?=
 =?us-ascii?Q?fBLaBjFYLlab5nV5fsUMApS+s8ykbXhAqsQ3e4qHxtpyjfFbuLvFywLi3sXA?=
 =?us-ascii?Q?AE5Ww4RoQ1qkzQp0C9yVyzKQAg99R6fwzZ1cg9VIJvZjdLGLyzsZwBvHS7Tv?=
 =?us-ascii?Q?9cCUHKtxgh39JepQwC0X7ovxkAkL3JNz8YAmqgebOCEU3wRlbI6iiGshubZT?=
 =?us-ascii?Q?fQNbE9corf3xjvvtctKx2tyYjxIqAq/nwLWYVrKrBb5/WBuZLvrGjjWMhSOV?=
 =?us-ascii?Q?gk2PpOOZ5WCv7Mhbg5fFLvqSYZRUQp3l0/sXwrGFgyKeyTNhWjVOt7fIwXCk?=
 =?us-ascii?Q?rWerZ8yCdA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b82a4cc7-f25b-435d-1103-08de5c6ffc8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2026 00:15:18.1086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KsOKpQPlmq63CV7tLKGPUJ/DmOZnZjPoSpdMzMtzKM1RCWiwoohSSwGjEJiJ7zZTqBTqHNzMjddTwtPe+fV+pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9082
X-OriginatorOrg: intel.com


Philippe Gerum <rpm@xenomai.org> wrote:
>Junxiao Chang <junxiao.chang@intel.com> writes:
>
>> ptrace-sync test case needs to load debug symbol in gdb. There is
>> debug symbol in debug build. If buildtype is release, this case should
>> not be integrated because it doesn't have debug symbol.
>>
>
>I don't think so, -g and the optimization level are unrelated in this day =
and age
>(have been at some point though, many, many moons ago).
>
>This is the output log of an x86 build for ptrace-sync.c with --buildtype =
release
>passed to meson, -O2 and -g are both set.
>
>[111/226] x86_64-blade-linux-gcc -m64 -march=3Dnehalem -mtune=3Dgeneric -
>mfpmath=3Dsse -msse4.2 -fstack-protector-strong -O2 -D_FORTIFY_SOURCE=3D2 =
-
>Wformat -Wformat-security -Werror=3Dformat-security --
>sysroot=3D/var/lab/sdk/cpc/x86-corei7/blade-2025.10/sysroots/corei7-64-bla=
de-
>linux -Itests/ptrace-sync.p -Itests -I../../../../git/xenomai/v4/libevl/te=
sts -
>Iinclude -I../../../../git/xenomai/v4/libevl/include -
>I../../../../git/xenomai/v4/libevl/lib/arch/x86/include -fdiagnostics-colo=
r=3Dalways
>-D_FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch -Wextra -Wpedantic -Werror -
>std=3Dgnu11 -O3 -pipe -Wstrict-aliasing -Wno-unused-parameter -Wno-pedanti=
c -
>D_GNU_SOURCE -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -Wshadow=3Dlocal
>-Wstrict-prototypes -Wmissing-prototypes -O2 -g -pthread -g -MD -MQ
>tests/ptrace-sync.p/ptrace-sync.c.o -MF tests/ptrace-sync.p/ptrace-sync.c.=
o.d -
>o tests/ptrace-sync.p/ptrace-sync.c.o -
>c ../../../../git/xenomai/v4/libevl/tests/ptrace-sync.c
>
>~# file /usr/libexec/evl/tests/ptrace-sync
>/usr/libexec/evl/tests/ptrace-sync: ELF 64-bit LSB pie executable, x86-64,
>version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux-x86-64.so.=
2,
>BuildID[sha1]=3D7b1a13b097bccaf82b65d49b221ef8c0dd450887, for GNU/Linux
>5.15.0, with debug_info, not stripped
>
>Stripping the ptrace-sync executable may be the actual cause of the issue.
>
>--
>Philippe.

My OS is ubuntu 24.04, kernel is latest xenomai 6.18.2. With " -Dbuildtype=
=3Drelease", there is no debug symbol after installing, and the test case f=
ailed(with next branch, "remove gdb prompt escape" fix integrated):

intel@intel-NUC13ANHi5:~/code/libevl/build$ readelf --debug-dump=3Dinfo /us=
r/libexec/evl/tests/ptrace-sync
intel@intel-NUC13ANHi5:~/code/libevl/build$ sudo /usr/libexec/evl/tests/ptr=
ace-sync
intel@intel-NUC13ANHi5:~/code/libevl/build$ echo $?
1

With "-Dbuildtype=3Ddebug" or no buildtype definition, there is debug symbo=
l info. Test case could pass:

intel@intel-NUC13ANHi5:~/code/libevl/build$ readelf --debug-dump=3Dinfo /us=
r/libexec/evl/tests/ptrace-sync | more
Contents of the .debug_info section:

  Compilation Unit @ offset 0:
   Length:        0x23d2 (32-bit)
   Version:       5
   Unit Type:     DW_UT_compile (1)
   Abbrev Offset: 0
   Pointer Size:  8
 <0><c>: Abbrev Number: 61 (DW_TAG_compile_unit)
    <d>   DW_AT_producer    : (indirect string, offset: 0x1d7): GNU C11 13.=
3.0 -mtune=3Dgeneric -march=3Dx86-64 -g -O2 -std=3Dgnu11 -fasynchronous-unw=
ind-tables -fstack-protector-strong -fstack-clash-protection -
fcf-protection
    <11>   DW_AT_language    : 29       (C11)
    <12>   DW_AT_name        : (indirect line string, offset: 0): ../tests/=
ptrace-sync.c
...

intel@intel-NUC13ANHi5:~/code/libevl/build$ sudo /usr/libexec/evl/tests/ptr=
ace-sync
intel@intel-NUC13ANHi5:~/code/libevl/build$ echo $?
0

Maybe as you mentioned, debug symbol is stripped during installation.
Thanks,
Junxiao
