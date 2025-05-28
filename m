Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B56360
	for <xenomai@lists.linux.dev>; Wed, 28 May 2025 05:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748410972; cv=fail; b=RCcDRwJ3/Ze1AqE6D7JK4+olSMSrWat9MbZaOLfDzVeccj6LXuhAd5bSew+2r2JxwlkexJfCJ+Zu533LLlVwmiPeTd4vnoF662gvHYOD3zHUqRfq6OpHtvQPb1PSANOldjiYGy80emfHUG3dFTfieUPzQZ3IhliagfG+4dvFluc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748410972; c=relaxed/simple;
	bh=IEkJ//9Jm2tOyhkB4LfOZLagtw3azHcQ0Wiw7HEtzh8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iMIyrjy1fjGOy2JVI4lpBtQfIEU1tFzrc8XLpLsl9lfaU8LRb4QLeWzjXMPiYixtl3cA9A04D4+v5KB5noPB87AyPY/8mULMS6rWS73VcNtmHuGpO7L24iDvBrFhzX38psedWvSbXSnAR/3mrCT8KtUcCbN9Jn10azFrkxLZzho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jNmsf1tU; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jNmsf1tU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748410969; x=1779946969;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IEkJ//9Jm2tOyhkB4LfOZLagtw3azHcQ0Wiw7HEtzh8=;
  b=jNmsf1tUdFpQPbjNbJiWd+U6eREOHMjbZWTNH6q52vPAlkyv4Sk1oJ2b
   VAE9TJyPawv9s5xDsY0w8RKLFhkoog7r59UWq1mRTsLJLD7SgaQQNKLOv
   jpSdnxd6mbBIx0k+7hfeOYMiFBI9kHIol6RSe0RSN6KnlPnrnmUo5Fq9c
   q/fQ9kooInRtgwRh5w5rEfTntB5WIyw0wMdBjXO7CJpE5s+C8aiDmL6WM
   W0nBSxXF//TYg3XoEwO4rP0fwEE9s67FbONdEIn5ev9LuUhGULbxe0Y8G
   KUtQb1p0wnduuL39Jk6rqUQcTGRlbA94UupwIvYmJPhzlleMB+uwwqUbC
   w==;
X-CSE-ConnectionGUID: Z9ZnyTtbQrWT8QENxOHbhg==
X-CSE-MsgGUID: HglpXj+IRnOTpUswvoCHhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="61475681"
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="61475681"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 22:42:48 -0700
X-CSE-ConnectionGUID: R+GoXyC7R9aXMRatOZ3Ymg==
X-CSE-MsgGUID: u6+nWVrlS5eUrzhzPXMgPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="148261526"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 22:42:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 May 2025 22:42:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 27 May 2025 22:42:48 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.59)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 27 May 2025 22:42:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i8xLhthmo1Kf+iS5Q3yZ0H79sMlKcxk9LDcbYDIm/g8g2RmP2CRyBc7ZVg2ZwklYs6YB8C4Ku73zHdiAlD+piUcwWxoMQUSnDrd8vrtzuMX8VDDGrg9stcDIb3ZE4Byenu/MxDlZIECnOcQ9ihVLiLtdnsjifME55K+NmljsRs46cCYvHI0RwjsxYeB9fv3oxbwUxR0KSfyqbhMhGcZs9jsv7tBshjdC+uR8S3S0XZs2lUEeDQfe6cl99MPySoeJkcVXgGXyPwvqiZqWdbOGPe+NWcH42MnZOdWasN3JSTUPiW+Ki/jNu3/9thtlm+0aR8QFMbpEiV2Fguo6K267sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEkJ//9Jm2tOyhkB4LfOZLagtw3azHcQ0Wiw7HEtzh8=;
 b=hUqho1K7ETDbekgsnXQ6rR8RpWDqz9/eXaiWCWBQsTW4KFC02thGMBZ5tuvbpkjHiuPrVPojTh8fxB59BIUa3snqfhAHskrM+p3pw/ayON2nkZkqkBiBRpSwaLGcrzN8HzsqoSqodmX8Sj+cFxqnRVFxdl8JbRc8ZRFHV61iEPZxwi4SwRd22wkK421fnFkvmW5x2++dvRV2500V19aBAAcxzGLTsZliP0R6/+RyCmbhkTkn7RyS+b0hw0M224NCx7ZczT+Vg/HiVCMuROImCHkkvn6R6m3OyloEYKLY5LqtCZD94pYFc9NwDROy69tcE8triGtzn3BUMhtNuByv+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by SJ0PR11MB6671.namprd11.prod.outlook.com (2603:10b6:a03:44b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Wed, 28 May
 2025 05:42:29 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d%4]) with mapi id 15.20.8769.022; Wed, 28 May 2025
 05:42:29 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: =?utf-8?B?5p2O6IOk6aKJ?= <liyinjie@sinsegye.com.cn>,
	"xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
CC: =?utf-8?B?5a6LLCDlgaXnjq4=?= <songjianwei@sinsegye.com.cn>,
	"liuyang@sinsegye.com.cn" <liuyang@sinsegye.com.cn>
Subject: =?utf-8?B?UkU6IFhlbm9tYWkgMy4yLjMgLyBLZXJuZWwgNS4xNSDigJQgUGVyaW9kaWMg?=
 =?utf-8?B?dGFzayBvY2Nhc2lvbmFsbHkgc3RyZXRjaGVzIGZyb20g4omINzAgwrVzIHRv?=
 =?utf-8?B?IOKJiDM1MCDCtXMg4oCUIGlzIHRoZSBPT0IgTEFQSUMgdGltZXIgdGhlIGNh?=
 =?utf-8?Q?use=3F?=
Thread-Topic: =?utf-8?B?WGVub21haSAzLjIuMyAvIEtlcm5lbCA1LjE1IOKAlCBQZXJpb2RpYyB0YXNr?=
 =?utf-8?B?IG9jY2FzaW9uYWxseSBzdHJldGNoZXMgZnJvbSDiiYg3MCDCtXMgdG8g4omI?=
 =?utf-8?B?MzUwIMK1cyDigJQgaXMgdGhlIE9PQiBMQVBJQyB0aW1lciB0aGUgY2F1c2U/?=
Thread-Index: AQHbzhb3EffUzdfI80WA5QVYxDJX4bPniNrQ
Date: Wed, 28 May 2025 05:42:29 +0000
Message-ID: <PH7PR11MB7499780E664D13C798955C07F267A@PH7PR11MB7499.namprd11.prod.outlook.com>
References: <A843D8BF-1964-4E87-A2EE-1B8D8E067BE0@sinsegye.com.cn>
In-Reply-To: <A843D8BF-1964-4E87-A2EE-1B8D8E067BE0@sinsegye.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|SJ0PR11MB6671:EE_
x-ms-office365-filtering-correlation-id: 325d9e47-7e04-4085-888f-08dd9daa6f4f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZUdtMkRUc3ZOY21CdW81TCtic3VPMHk5VlBTK1YwcUhYMFpQYmZKT0RXTkdE?=
 =?utf-8?B?MjlJM1d1eFl2MElKUlN1MEJ3cUhRTXMxUFIvWEJLRTlIVDRZQ2o0enBjcHhY?=
 =?utf-8?B?bzM2VW85Sm1sRW9FS3MxVElRemxJR0JxcHJLSEQ5ZnYvc3RiZTVLMjlXYzVQ?=
 =?utf-8?B?eXBESmhVSHpLdXVTNjBERU9uNmVhVmlWbmlUZG5QMlNLM0hXSGszSXg3Z3Jy?=
 =?utf-8?B?OVYyV0pnREpGZ1NnT3ltSC9zN0xQbkRiWENYeWkvWWVTaXhXVERiQnNSOHFC?=
 =?utf-8?B?dFhHaXVzaVU4bHZuZDFzTVZWQUJVTzJOQmJwNjE2VHgvNDUwUW5yL3JuUlhs?=
 =?utf-8?B?bXYvS24wZDF4WXJUR2IrSUZWS2oxTU1OdjI4V2o0ZUZZTWtBNllxU3AyM2xD?=
 =?utf-8?B?S3BKUHMzV3c3dTZFc2gvYU1xaWhHVHplK3QvL2g3SkUwbmZQZmIxRGFRZmJY?=
 =?utf-8?B?UzFSQmVtTTZickJmeUdjU0hjZG5SM25ZcU5ZRmRxd25DaDlNalQ4a3Q4MU1a?=
 =?utf-8?B?NXNYYjhmMnVlc2lHZktOQWxZWFJpMjZBbFVJVExleTJwM2pzQmZCWXh6czB4?=
 =?utf-8?B?SnhnaFMvREFwNFluWHFDWVdQdTE4d1hWY0VucDRrVTk4bXp1R3h3UkxuTFdp?=
 =?utf-8?B?d2E1KytZczZxZEd5ZUJLanRsUll4R0M5Q3JEbGNEUTVoUmZab0lLazdJd293?=
 =?utf-8?B?WG9TOFVCSXlmSFVqaElET3pIVTRvZm1SYjJaR2xQSnQ3bmo2UVJrQUdodlRr?=
 =?utf-8?B?VjRnaWI2OERaNEUyM1h1WVhoZmpVczQ2dkQyVVNRMmhobW1TTTNGUERPQkxx?=
 =?utf-8?B?dXJvSlk0OVh4UHFqZWFEa1Y1TkNGUHFTVGxrZFVUUll4ellvWDJCWEFqV1dY?=
 =?utf-8?B?eVBNNXpaZWI1NFhORHE4NmpoNDNYK01lclgyRkcrRVJMVXd0L1F5cTNHNXFa?=
 =?utf-8?B?alV5ZTF2REtsMDNyYTZ0QzB2T05CV3oxMllzR2RNRUNNZnZ5bjNHbGpEbkJC?=
 =?utf-8?B?enlQdEVwS3pkVGVNbTZIakI4T2lnRDJTakExVWxGU2hQOHBBUC9iaDRkQ3JI?=
 =?utf-8?B?SU1UY1kyckIvQjNpZU9kSG5obVRacU5JT21uTEFOeFZhUGxreFFIS0J2ZzRT?=
 =?utf-8?B?aXo4RHpYYjFJaVUrLzdpQWdDdGo1L0lKKzRZelY1VlpNQUJWRzJwTjBvd1Jq?=
 =?utf-8?B?TmlUV2tVemhMdTA4enB4RnJOUHlVNGFFS3UydHZuaGRiUjlNeXUxdmZDK1E5?=
 =?utf-8?B?aXpFaXRDeStFOWh6NVNIVUYrUXNUbkpqcDMyMytnNDYyUXo4bzVLUjU4bnla?=
 =?utf-8?B?SVJtOGFBMWRPTEFaeFYycUoranlwb1NjaUpOblR1SjJnR1h5TW1ORnRTb1V0?=
 =?utf-8?B?anl2cUZSSkRHK3pSbnFrc3hXWERYamRUR0s3T0lVSklFMFZDSXFtem8rcHRF?=
 =?utf-8?B?b0ZFaStMa040S2tVaUdBN3NJYzFOOERwdm5mM2lPN2Iwc1Z3VXQ0TDJvM2lL?=
 =?utf-8?B?L1F1K3ZVZmV4dHYwbkdGbGpkbHp4OVRlZDJ1a3dEaGhUK3BzTjVpQU42SWN5?=
 =?utf-8?B?RUZ4OWNVeEppZHc2NURVQzFMNURyTW5FN3h2MUhybG5MSW43eTUyZEI5bWJi?=
 =?utf-8?B?OFIxRkhUaWlITHl1UzJQVEhWVW9YMDZubHpzSVVPREVteWdpY1EyTTVmb1dz?=
 =?utf-8?B?NlA0Um41b2tRd1pWU1pqZXJHSkxheDVuaFp2MWZDb0JPZk10eW44VjBadVVo?=
 =?utf-8?B?U2h0cnpFOTl3VkFKK1ZBaGQyUm52R1NjS0JDU2hxRUtIdjZpWDFGMG9MaStW?=
 =?utf-8?B?M0theEo1Mno1eUZkdW9uSUhwS08yTXo3c1ptNE55aVRKQXUwdXNGdTl2Q1lx?=
 =?utf-8?B?NnZFV3hKRGF3ckR6eHhMNGRYNmswT0pHaDFNaDAwSm9JaVJpYmRnZVJnRE1j?=
 =?utf-8?B?V1lPVFhSdGwvejkvSFJaSkpvVHNUdGlBZWNwOTY5eFhvTlkwS2UxL0hRemFj?=
 =?utf-8?Q?1bH/SjuE8BdAR5mQNkZzGJ1uQpR8NQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWZFc2lEcnowZzM5TzJYMndvQkZNRjJHVjczNFY1ZWlUR2tYMkJoeVZaQXcy?=
 =?utf-8?B?SUUyeldnWUsybmRqMW84WFozSWxKblhBOWVwNlRvNEUwYWRhOUx2eEh6SGpv?=
 =?utf-8?B?MGd2Z1dpSnNpR2lGVnVCeDMvQnJMWFpnZWhGRktOUEpoSWlFdmsxSHRnZkly?=
 =?utf-8?B?UXhsaDBUOFhoMDQ0bU8zSmZRbENmQnlOc2RvZjNPWUgrQzJrbDVhRXlRVTBI?=
 =?utf-8?B?aVdMd1d6MFI5ZHFLaG51N2dEcnU2YkxMUjdXNS9jSDBkVnJjTDd2dVlYNHBN?=
 =?utf-8?B?VEQxWjUzVFFGd0s5Y1pxeTAvaStwd01kY0RIYVVwUjNsVEhIcE91TkswNnNP?=
 =?utf-8?B?NjVjZDhvRXJpTUNSREJlVVF3TzhUZzN3aFlGQkZXZEE1QXFlcWRjeXJRZEJY?=
 =?utf-8?B?V0JFMk1zd1hCc1BxajRXdTRRNVVXcm9HbDNWT3dtZGdLL0NSZ2pHL1lYeEQ3?=
 =?utf-8?B?ZW9DQU1FQ3BZNUxFc1ArWXJEN1VJYjRSWDZtemNPZm9HenY3S2UwdWtmZHly?=
 =?utf-8?B?WHMrNzMvVGdTOEVtcThaQlgxbnN6OXE4SDQ2UkN3d1RXWTRjVGVzU1lrbWlX?=
 =?utf-8?B?cHNxRnRROWNYVXBNZTVBbXZQODliY0ZUcmRBaHNMR2lDNHhzZFYrYmhjamc3?=
 =?utf-8?B?VnhWTjc5NjV1K1l3MGFGbjM2akdheWplcmdoM1lTUit0eW5uQ0xacXJKMXF4?=
 =?utf-8?B?eURhSDR5Uk83MUdWbCtsbXJkNXV5MnAvcUxzQTdVK25ZN21aVWpEdURDdk94?=
 =?utf-8?B?cUtqMnhnSFF4WkU0NXFMOHErUlh2QXdIT2phaXR6RVZwOE92OXJGcDB0RDBW?=
 =?utf-8?B?ampleEh4VmdsdzlZa2RJVnV1dEJkRno5SUQ4dnRTRWpacFdVK2pWWGFvSUhF?=
 =?utf-8?B?OFNSRTFMQ3BxaDNOcG1IckRSVmoxZ0JqZS9wUmxIbnV3VTFQSUl4LzVIWWp1?=
 =?utf-8?B?RFA2Z0N6TjJLK0pobktYcWpUNWEwUUtpcWlGMk1QMHhNUkdKcDZDbE91UW9i?=
 =?utf-8?B?NWFLdDlxa29OM1hCdDZuV29teGFnQnpuSHBBWUZwR2lmaDVjdGdGeTdzSVp1?=
 =?utf-8?B?aTVwVE0xN3pSV2p6QUxkaDAvUG1xWmZKamJudHNYMU9wQzgrb3AyOHlpMk8y?=
 =?utf-8?B?Q0FTYnZzTXI1bEJoN1ZST3IrY2JOcjJTWitDbnplVU52UnA2T1hyYmpTeWMy?=
 =?utf-8?B?eW4rL254OEZGRitCTDY5clIzSVhUNU5TN01hT045ZkovYmIxSGMzTXF5SGlT?=
 =?utf-8?B?QUlXa3ptUzZWVDBUbjRMWFRyTDRaYmFhS2YrdjZ5WGFiYnRvZHVMcjh4aXhs?=
 =?utf-8?B?Sm4yeTJOcHNmMWc5aFZkK3pCZnhCR3pRazQrSFFTN2YyL0tSL1A3WUFQZkV4?=
 =?utf-8?B?TUJrRkRCY2V1aE0zcVpqYklzQlZGdzNUUVpCV3N3RCt4Mnk5TS9OMjYzN2Vv?=
 =?utf-8?B?d1o4eWY5MkhrM1NnRS9pNW5KV2pUN0ovWFFNN0VyNmE4Qkw3eVkxSENMd2F0?=
 =?utf-8?B?VFFBcDdyUEdHbnA1RGoySmJ4cEVMdXpaS3BjL3Z2Y0V5UVpjdGt1Z2g1Sjl2?=
 =?utf-8?B?am8yMElqdGlBaUVIYmxKem5SRWoxUHIxTmVZWEdiVldRdHNBbGdhamwxMllu?=
 =?utf-8?B?UExvYk02cWxyV1pNNmR5ZGg0ajU3NXhvS1RiQjlqMjYxNi81dXFzd3FxYzFU?=
 =?utf-8?B?WUZrNlowTWpwWFdudnVsRlBOaHduczFIbFJsM1JuYkVhK0FFRUhUajVweUZE?=
 =?utf-8?B?ZlVTUVlYemxVVkVoZ2xCK1Y1c2J3MWcvZkQyZFpiRElwTmkxZGFRWlE1ZFZJ?=
 =?utf-8?B?dWl4QzhQU3pocmlaK0FUTEZsYTkvMnY2d09BZ2dSazVaaFZLNDVqMDlaSUNy?=
 =?utf-8?B?ZCtFYWk0VXhXWEltR0t3QXVjcHcrUUFsNVhjc1pmYVlHdVVZVGtKQjhKb1JM?=
 =?utf-8?B?dTJjYW1OK3c1QXdIQW5OdTVsaXh1S3BYZmltUWVXYmlHMzJ3SWRYcFBFMDRZ?=
 =?utf-8?B?WmRsZnVNZXFkRklHL0lkSHZWbThpNXh1TCtiYlR5YnhwY09DakRYZ09wN25M?=
 =?utf-8?B?VjlxbGRlTmZqR09VT1YxTE1ZU01JRWwvbk1XdkwrbjlwTVJLT1BvUDVydENy?=
 =?utf-8?Q?f9H5cnFWHi+SkO1d2suhSAa6h?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 325d9e47-7e04-4085-888f-08dd9daa6f4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 05:42:29.3578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ang49hfwzaiiLarnQDbHK3NXV3YDKN6DOpg2YBDsiAtPjN6aZAwWFCRxMWj9PKArVRN6bFzO+zWZYi+azbmqRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6671
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IOadjuiDpOmiiSA8bGl5aW5q
aWVAc2luc2VneWUuY29tLmNuPg0KPlNlbnQ6IE1vbmRheSwgTWF5IDI2LCAyMDI1IDQ6MTkgUE0N
Cj5UbzogeGVub21haUBsaXN0cy5saW51eC5kZXYNCj5DYzog5a6LLCDlgaXnjq4gPHNvbmdqaWFu
d2VpQHNpbnNlZ3llLmNvbS5jbj47IGxpdXlhbmdAc2luc2VneWUuY29tLmNuDQo+U3ViamVjdDog
WGVub21haSAzLjIuMyAvIEtlcm5lbCA1LjE1IOKAlCBQZXJpb2RpYyB0YXNrIG9jY2FzaW9uYWxs
eSBzdHJldGNoZXMNCj5mcm9tIOKJiDcwIMK1cyB0byDiiYgzNTAgwrVzIOKAlCBpcyB0aGUgT09C
IExBUElDIHRpbWVyIHRoZSBjYXVzZT8NCj4NCj5IaSxhbGwNCj4NCj5FbnZpcm9ubWVudA0KPuKA
oiBYZW5vbWFpIHZlcnNpb246IDMuMi4zIChDb2JhbHQpDQo+4oCiIExpbnV4IGtlcm5lbDogNS4x
NS55DQo+4oCiIENQVTogSW50ZWwgNi1jb3JlLCAxMnRoIEdlbiBJbnRlbChSKSBDb3JlKFRNKSBp
NS0xMjQwMA0KPuKAoiBCb290IHBhcmFtZXRlcnMgKHJlbGV2YW50IGV4Y2VycHRzKToNCj5pc29s
Y3B1cz0xIG5vaHpfZnVsbD0xIHJjdV9ub2Nicz0xIGlycWFmZmluaXR5PTAsMi01DQo+aWRsZT1w
b2xsIGludGVsX2lkbGUubWF4X2NzdGF0ZT0wIGludGVsX3BzdGF0ZT1kaXNhYmxlDQo+DQo+VGFz
ayBkZXNjcmlwdGlvbg0KPlBJRCAyNzgwIGlzIGEgcGVyaW9kaWMgaGFyZC1yZWFsLXRpbWUgdGhy
ZWFkIHBpbm5lZCB0byBDUFUgMS4NCj5JdHMgcGVyaW9kIGlzIH4zIG1zOyB0aGUgYWN0dWFsIHdv
cmsgcGVyIGN5Y2xlLCBtZWFzdXJlZCBpbiB0aGUga2VybmVsLCBpcw0KPm5vcm1hbGx5IGFib3V0
IDY1LTc1IMK1cy4NCj4NCj5PYnNlcnZlZCB0aW1pbmcNCj5Vc2luZyB0cmFjZS1jbWQgKGZ1bmN0
aW9uX2dyYXBoIHRyYWNlcikgSSBtZWFzdXJlIHRoZSBpbnRlcnZhbCBmcm9tIHRoZSBmaXJzdA0K
PmNvYmFsdF90cmFjZV9waWQgcGlkPTI3ODANCj50byB0aGUgY29ycmVzcG9uZGluZw0KPng4Nl9m
cHVfcmVnc19kZWFjdGl2YXRlZA0KPmZvciBlYWNoIGN5Y2xlLg0KPkJlc3QtY2FzZTogNjUtNzUg
wrVzIChleHBlY3RlZCkNCj5Xb3JzdC1jYXNlOiAzMjAtMzYwIMK1cyAob2NjYXNpb25hbCkNCj4N
Cj5UeXBpY2FsIGxvbmcgc2xpY2UgKGFicmlkZ2VkKToNCj48aWRsZT4tMCAgICAgWzAwMV0gICA4
MDQuNDg4OTAzOiBjb2JhbHRfdGltZXJfc3RhcnQ6DQo+dGltZXI9MHhmZmZmOTM4MTJmNGRkYzY4
KFt3YXRjaGRvZ10pIHZhbHVlPTMwMDAwMDAwMDAwIGludGVydmFsPTANCg0KV2h5IHlvdSBzZXQg
MzBTIGZvciB3YXRjaGRvZyB0aW1lb3V0ID8NCg0KPm1vZGU9MHgwDQo+ICAgICAgICAgICA8Li4u
Pi0yNzgwICBbMDAxXSAgIDgwNC40ODg5MDQ6IGNvYmFsdF90cmFjZV9waWQ6ICAgICBwaWQ9Mjc4
MCwgcHJpbz05OQ0KPiAgICAgICAgICAgPC4uLj4tMjc4MCAgWzAwMV0gICA4MDQuNDg4OTA0OiBj
b2JhbHRfaGVhZF9zeXNleGl0OiAgcmVzdWx0PTANCj4gICAgICAgICAgIDwuLi4+LTI3ODAgIFsw
MDFdICAgODA0LjQ4ODkwNDogY29iYWx0X2hlYWRfc3lzZW50cnk6IHN5c2NhbGw9c2VtX3Bvc3QN
Cj4gICAgICAgICAgIDwuLi4+LTI3ODAgIFswMDFdICAgODA0LjQ4ODkwNDogY29iYWx0X3BzZW1f
cG9zdDogICAgIHNlbT0weDE0MA0KPiAgICAgICAgICAgPC4uLj4tMjc4MCAgWzAwMV0gICA4MDQu
NDg4OTA0OiBjb2JhbHRfc3luY2hfd2FrZXVwOg0KPnN5bmNoPTB4ZmZmZmI0MmMwMGI1NTIwOA0K
PiAgICAgICAgICAgPC4uLj4tMjc4MCAgWzAwMV0gICA4MDQuNDg4OTA1OiBjb2JhbHRfdGhyZWFk
X3Jlc3VtZToNCj5uYW1lPVNjaGVkUHJvY2Vzc29yTCBwaWQ9Mjc3NiBtYXNrPTB4Mg0KPiAgICAg
ICAgICAgPC4uLj4tMjc4MCAgWzAwMV0gICA4MDQuNDg4OTA1OiBjb2JhbHRfdHJhY2VfcGlkOiAg
ICAgcGlkPTI3NzYsIHByaW89MA0KPiAgICAgICAgICAgPC4uLj4tMjc4MCAgWzAwMV0gICA4MDQu
NDg4OTA1OiBjb2JhbHRfc2NoZWR1bGU6ICAgICAgc3RhdHVzPTB4MTAwMDAwMDANCj4gICAgICAg
ICAgIDwuLi4+LTI3ODAgIFswMDFdICAgODA0LjQ4ODkwNTogY29iYWx0X3RyYWNlX3BpZDogICAg
IHBpZD0yNzgwLCBwcmlvPTk5DQo+ICAgICAgICAgICA8Li4uPi0yNzgwICBbMDAxXSAgIDgwNC40
ODg5MDU6IHdyaXRlX21zcjogICAgICAgICAgICA4MzAsIHZhbHVlIDEwMDAwMDhlYQ0KPiAgICAg
ICAgICAgPC4uLj4tMjc4MCAgWzAwMV0gICA4MDQuNDg4OTA1OiBjb2JhbHRfaGVhZF9zeXNleGl0
OiAgcmVzdWx0PTANCj4gICAgICAgICAgIDwuLi4+LTI3ODAgIFswMDFdICAgODA0LjQ4OTE1Mzog
aXJxX3BpcGVsaW5lX2VudHJ5OiAgIGlycT01MjQ1NDYNCj4gICAgICAgICAgIDwuLi4+LTI3ODAg
IFswMDFdICAgODA0LjQ4OTE1MzogaXJxX2hhbmRsZXJfZW50cnk6ICAgIGlycT01MjQ1NDYNCj5u
YW1lPU91dC1vZi1iYW5kIExBUElDIHRpbWVyIGludGVycnVwdA0KPiAgICAgICAgICAgPC4uLj4t
Mjc4MCAgWzAwMV0gICA4MDQuNDg5MTUzOiBsb2NhbF90aW1lcl9lbnRyeTogICAgdmVjdG9yPTIz
Ng0KPiAgICAgICAgICAgPC4uLj4tMjc4MCAgWzAwMV0gICA4MDQuNDg5MTU0OiBjb2JhbHRfdGlt
ZXJfZXhwaXJlOg0KPnRpbWVyPTB4ZmZmZjkzODEyZjRkZDMxOA0KPiAgICAgICAgICAgPC4uLj4t
Mjc4MCAgWzAwMV0gICA4MDQuNDg5MTU0OiBjb2JhbHRfdGlja19zaG90OiAgICAgW0ZBSUxFRCBU
TyBQQVJTRV0NCj5zZWNzPTgwOCBuc2Vjcz03MTkwOTk4MDIgZGVsdGE9NDIyOTk0NTgwMg0KDQpI
ZXJlIGlzIHdlaXJkIHdoeSBuZXh0IHNob3Qgc3BhbiA0IHNlY29uZHM/DQoNClJlZ2FyZHMNCg0K
SG9uZ3poYW4gQ2hlbg0KDQo+ICAgICAgICAgICA8Li4uPi0yNzgwICBbMDAxXSAgIDgwNC40ODkx
NTQ6IHdyaXRlX21zcjogICAgICAgICAgICA2ZTAsIHZhbHVlIDFmNzY1ZDFkNTRlDQo+ICAgICAg
ICAgICA8Li4uPi0yNzgwICBbMDAxXSAgIDgwNC40ODkxNTQ6IGxvY2FsX3RpbWVyX2V4aXQ6ICAg
ICB2ZWN0b3I9MjM2DQo+ICAgICAgICAgICA8Li4uPi0yNzgwICBbMDAxXSAgIDgwNC40ODkxNTQ6
IGlycV9oYW5kbGVyX2V4aXQ6ICAgICBpcnE9NTI0NTQ2DQo+cmV0PWhhbmRsZWQNCj4gICAgICAg
ICAgIDwuLi4+LTI3ODAgIFswMDFdICAgODA0LjQ4OTE1NDogaXJxX3BpcGVsaW5lX2V4aXQ6ICAg
IGlycT01MjQ1NDYNCj4gICAgICAgICAgIDwuLi4+LTI3ODAgIFswMDFdICAgODA0LjQ4OTI0Nzog
Y29iYWx0X2hlYWRfc3lzZW50cnk6DQo+c3lzY2FsbD1jbG9ja19uYW5vc2xlZXANCj4gICAgICAg
ICAgIDwuLi4+LTI3ODAgIFswMDFdICAgODA0LjQ4OTI0NzogY29iYWx0X2Nsb2NrX25hbm9zbGVl
cDogY2xvY2tfaWQ9MQ0KPmZsYWdzPTB4MShUSU1FUl9BQlNUSU1FKSBycXQ9KDgwNC40OTE5NTU0
MTEpDQo+ICAgICAgICAgICA8Li4uPi0yNzgwICBbMDAxXSAgIDgwNC40ODkyNDc6IGNvYmFsdF90
aHJlYWRfc3VzcGVuZDogcGlkPTI3ODANCj5tYXNrPTB4NCB0aW1lb3V0PTgwNDQ5MTk1NTQxMiB0
aW1lb3V0X21vZGU9MSB3Y2hhbj0obmlsKQ0KPiAgICAgICAgICAgPC4uLj4tMjc4MCAgWzAwMV0g
ICA4MDQuNDg5MjQ3OiBjb2JhbHRfdGltZXJfc3RhcnQ6DQo+dGltZXI9MHhmZmZmYjQyYzAwYjRm
NGIwKENNSG9va3NUYXNrKSB2YWx1ZT04MDQ0OTE5NTU0MTIgaW50ZXJ2YWw9MA0KPm1vZGU9MHgx
DQo+ICAgICAgICAgICA8Li4uPi0yNzgwICBbMDAxXSAgIDgwNC40ODkyNDg6IGNvYmFsdF90aWNr
X3Nob3Q6ICAgICBbRkFJTEVEIFRPIFBBUlNFXQ0KPnNlY3M9ODA0IG5zZWNzPTQ4OTkwMTc1NCBk
ZWx0YT02NTQxOTYNCj4gICAgICAgICAgIDwuLi4+LTI3ODAgIFswMDFdICAgODA0LjQ4OTI0ODog
d3JpdGVfbXNyOiAgICAgICAgICAgIDZlMCwgdmFsdWUgMWU1ZjZjNWIzN2INCj4gICAgICAgICAg
IDwuLi4+LTI3ODAgIFswMDFdICAgODA0LjQ4OTI0ODogY29iYWx0X3NjaGVkdWxlOiAgICAgIHN0
YXR1cz0weDEwMDAwMDAwDQo+ICAgICAgICAgICA8Li4uPi0yNzgwICBbMDAxXSAgIDgwNC40ODky
NDg6IGNvYmFsdF90cmFjZV9waWQ6ICAgICBwaWQ9Mjc4MCwgcHJpbz05OQ0KPiAgICAgICAgICAg
PC4uLj4tMjc4MCAgWzAwMV0gICA4MDQuNDg5MjQ4OiBjb2JhbHRfc3dpdGNoX2NvbnRleHQ6IHBy
ZXZfbmFtZT1UYXNrMQ0KPnByZXZfcGlkPTI3ODAgcHJldl9wcmlvPTk5IHByZXZfc3RhdGU9MHg0
ODA0NCA9PT4gbmV4dF9uYW1lPVJPT1QvMQ0KPm5leHRfcGlkPTAgbmV4dF9wcmlvPS0xDQo+ICAg
ICAgICAgICA8Li4uPi0yNzgwICBbMDAxXSAgIDgwNC40ODkyNDg6IGNvYmFsdF90aW1lcl9zdG9w
Og0KPnRpbWVyPTB4ZmZmZjkzODEyZjRkZGM2OA0KPiAgICAgICAgICAgPC4uLj4tMjc4MCAgWzAw
MV0gICA4MDQuNDg5MjQ4OiB4ODZfZnB1X3JlZ3NfZGVhY3RpdmF0ZWQ6IHg4Ni9mcHU6DQo+MHhm
ZmZmOTM3ZGQ0Mzg5NTQwIGxvYWQ6IDAgeGZlYXR1cmVzOiAyMDMgeGNvbXBfYnY6IDgwMDAwMDAw
MDAwMDAyMDcNCj48aWRsZT4tMCAgICAgWzAwMV0gICA4MDQuNDg5MjQ4OiBjb2JhbHRfdHJhY2Vf
cGlkOiAgICAgcGlkPTAsIHByaW89LTENCj4NCj5RdWVzdGlvbnM6DQo+MS4gSXMgdGhlIG91dC1v
Zi1iYW5kIExBUElDIHRpbWVyIGluZGVlZCB3aGF0IGluZmxhdGVzIHNvbWUgY3ljbGVzIHRvIHJv
dWdobHkNCj4zNTAgwrVzPw0KPjIuIFdoYXQgcHJhY3RpY2FsIHN0ZXBzIGNhbiBJIHRha2UgdG8g
a2VlcCB0aGUgY3ljbGUgdGltZSBmcm9tIGJsb3dpbmcgdXAgdG8NCj5yb3VnaGx5IDM1MCDCtXMg
KGFib3V0IGZpdmUgdGltZXMgdGhlIG5vcm1hbCA3MCDCtXMpIGFuZCBob2xkIGl0IG5lYXIgdGhl
DQo+ZXhwZWN0ZWQgcmFuZ2U/DQo+DQo+DQoNCg==
