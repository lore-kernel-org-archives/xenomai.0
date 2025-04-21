Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02059A2D
	for <xenomai@lists.linux.dev>; Mon, 21 Apr 2025 00:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745193856; cv=fail; b=nBOv+BRGz8SDCmzdB00wkTF2i1hRziV1QMyKKuVS+6wi/fCg4MK+ENsU+ADhdc4C4e64eV5GISa0cO7Ea3TpsNQACEGbsmGj86ftHhwBJ1LDwYYZ4Ue4+mdgBM1ITY9GJbKdTHXELaZIEwvWaUCX7eQN77zp87oCCBodOgNgeJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745193856; c=relaxed/simple;
	bh=Acs8YRuu+GGEH4v+F4PoLQMqxZkQ8PNrHk6jo56AFRw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LWGB9bi0A0U9jVEdK+QI5BaI4HOf0fChp6L92Sa3pRgbZ3wSh5DhuqUWXJjUUPiW4R+k/TLBrx4oS5M7XvyXF/Lh7qP9jQVnSD336Vex79d03bN6tMxy0Cs+3q9732QVZh2PYQESNZJxlabs9xyL1uAgX288vC37JebmsTiu5BQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jQdVugeO; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jQdVugeO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745193854; x=1776729854;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Acs8YRuu+GGEH4v+F4PoLQMqxZkQ8PNrHk6jo56AFRw=;
  b=jQdVugeOH3nEnup/KmUZ93w8Hh9WdSGxl/bQbOYlnUEKrGPGo4dsJ4Sb
   9HdzGqQZU1IfNSzsd28HdNYXT1WfKrS44rZ18JzjxUQ4uDb4eP/bVlmA+
   sLUMT4+RTe74MQIxeY9Mnebr4NnNvWU3q1IE2P7my33Y0NYKtRnilCYVf
   0bz3cQFm8XKTDYmG0rXO7sAn7RLndTYFjNywfadqqTWPLwhnqNGkH1kQE
   TkqFU/QnkxijCxJCsbMIfiDi8Df7Wkkcc7T010TrUSxiwoUoyZ/vP23VY
   Tw8Gko8KgBBM4w3vzDEY/EtMBOhKz9VA98t4IPAQfn/BWNfSyRpimYVvs
   w==;
X-CSE-ConnectionGUID: lT+DbbhJQgGi9bE/y5r5pg==
X-CSE-MsgGUID: EahutDtwTK2pQyd3sMTFhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11409"; a="50556168"
X-IronPort-AV: E=Sophos;i="6.15,225,1739865600"; 
   d="scan'208";a="50556168"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2025 17:04:13 -0700
X-CSE-ConnectionGUID: UvyitiKSQmSLaaV/8bQ14A==
X-CSE-MsgGUID: 1HxKP/9WSdmQ8FC240Ojmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,225,1739865600"; 
   d="scan'208";a="135668066"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2025 17:04:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 20 Apr 2025 17:04:12 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 20 Apr 2025 17:04:12 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 20 Apr 2025 17:04:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BJ+/bz5r1zBhSA3YXTZlu0PdgTceOo+U0ZurpyB3ANEP2lE8816q/41fD0j2BR/tqiyT5NaW+EZsvvQcXIApwd8CLS6a2EH6ii21aVIk6Vm+eSBQchvxgK5j2EvWcFMwwcG5eii4XCCYjjl8Cvlw+tTO2rBbhvWVDrOpqg4QcX2i4uK6MUA0RaD19ftC0rfOmygkLfXdgbLKD2ZXXq6j5VSSJf6SbsKUBhD+uvVLtRd3UvoyBAmWbv6mn4iBcJal90uYNJAwj1rYz9nAXTmLoUgY9OMpjMAdpVL8GeUr267XfEZw+5KRrHjB4tPC7/nj+6j5XQ/hVtPKxG9VYMHDpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Acs8YRuu+GGEH4v+F4PoLQMqxZkQ8PNrHk6jo56AFRw=;
 b=WJvR0k6CZyoXwI4/HKE0DCR6sO5A+G1/3+60g7h5S4gR5cmQt6xknqFN+6mmBIA/vNo3CyOTAC9R1/edmvt3Vf5ipQTAqjWW8Ob2VmSVzMKnIDeGOBIZjGTNsMDMOKB28UGWKWGHvDWCtEUIB5sSSE2Qnge+9RqcJa0qW/Rqkmq9Gs3A1X//Ta3PDAxZoAywnmfdxQYB6ykuGgfW7V//6RhdKCVlg4kA4FQUup9NvWfxzjv9NNk8vHjSfi97W19v23DPscdNmU+cEakznmE8X5KxvF42iubhEsvsc70PJQ/lslELeoZRDSmytwWHkKQeWzChcdR/H9HQP84ohxd3/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6513.namprd11.prod.outlook.com (2603:10b6:208:3a3::7)
 by IA1PR11MB6441.namprd11.prod.outlook.com (2603:10b6:208:3aa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Mon, 21 Apr
 2025 00:04:09 +0000
Received: from IA1PR11MB6513.namprd11.prod.outlook.com
 ([fe80::8012:e01:4c01:d824]) by IA1PR11MB6513.namprd11.prod.outlook.com
 ([fe80::8012:e01:4c01:d824%4]) with mapi id 15.20.8655.031; Mon, 21 Apr 2025
 00:04:09 +0000
From: "Qiao, Wei" <wei.qiao@intel.com>
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>, "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
CC: "Chen, Hongzhan" <hongzhan.chen@intel.com>, "Pirou, Florent"
	<florent.pirou@intel.com>
Subject: RE: Build error of kernel/xenomai/debug.c
Thread-Topic: Build error of kernel/xenomai/debug.c
Thread-Index: AduvcNIP6fYojmwUSlGjpzfO8h3ARwAA+zCAAACQPoAAK7b9gACF9hAAAATGcPA=
Date: Mon, 21 Apr 2025 00:04:09 +0000
Message-ID: <IA1PR11MB6513E0EAE939198016B5F9858CB82@IA1PR11MB6513.namprd11.prod.outlook.com>
References: <IA1PR11MB6513EB0131E06C8CC865E8EF8CBC2@IA1PR11MB6513.namprd11.prod.outlook.com>
 <72c2c5cb18b635f1145c35b6592c661cf55aeb0f.camel@siemens.com>
 <370f022e-d5e3-46f1-a19f-5448afeebb61@siemens.com>
 <IA1PR11MB6513A045F8ECB1186B65DA9A8CBF2@IA1PR11MB6513.namprd11.prod.outlook.com>
 <4342e7e1-a7d4-431c-8fcc-f7731d3938d9@siemens.com>
In-Reply-To: <4342e7e1-a7d4-431c-8fcc-f7731d3938d9@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6513:EE_|IA1PR11MB6441:EE_
x-ms-office365-filtering-correlation-id: 2b06087b-8071-4d0c-c9b0-08dd80680a6b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VEZ3Rkk3WEQ0eXR1TTNoSEpueHN4WEZRSkNDQzh3bWM3UytxUFNsWWxWbElV?=
 =?utf-8?B?UW8yTnJYUXdPeEtXaUtreG1pQWpUazdCcHV5Ny96dnhGcUh0SE0wS3ZHWmVy?=
 =?utf-8?B?SFNpOVdSZGFuNTViUXdxOVhjUUhLVmtrVGMyUVJTZ3BpNFN0Yi92emFaNmI0?=
 =?utf-8?B?b2VreDEwektWNlFORjRyN3RVWllZK0lneGxUaVFiZkpxUjJjMTZjcHduVFJP?=
 =?utf-8?B?bnhhcnFRZmJTTTlwZlMvWG1IdHZUMk1wcisvWXhBR3o5V051MHJ4NSs0cnN6?=
 =?utf-8?B?dVJPc1pjeHphZEo3NnZUQjlMWHRqVlpwMkRSWjNTUHQvcFBCUWV6b2xDZ2U3?=
 =?utf-8?B?NEFVSEJFRWpBNkNBWUtOOTc1V0t2TlFRR1puSlArSDRoU0QzMGoyS3FDRnhR?=
 =?utf-8?B?YUVDeVRrTytxY0VTTTBKa3ZPeklJWnB4cThldzdXUlY2WW1Nb2YxcEZyTEZy?=
 =?utf-8?B?TDRFUTFYdE41SVo5bHJQL3JsTmtTMWdJL3dyd3RLV2VxQ1NXZGQwa09WWnpZ?=
 =?utf-8?B?cFNDS1p3MWpqUW04NnU3SE5kSGFoR2hTd0xtSlk3QTFXUURCOFJQMHBqOEl0?=
 =?utf-8?B?ZWRwYlE5Y1BqNUY5SkxIbTE0cHdVTTAvdmhCc0FmdldIOVFSaDgzT0hpbk4v?=
 =?utf-8?B?NU1RVkNlckIyU0QrbzBsa3pvMkhJZXVuWU1KK0ZLT3UvQ1dBNEFFMWN1ZmpY?=
 =?utf-8?B?WmRoUThrYk45RnorTjY1Y01uZjN3ZHdNeG8rNXJoUXBWSHpIamN5NDJTZ0M2?=
 =?utf-8?B?aWdTdUcwMnR0a0Q1SHpDdnptWW9VaWRuOWc5eWxEYmhMeFZ1NHFiMldaaExK?=
 =?utf-8?B?bkRDVTIvQ1Y4QlJTNjh4cTk2SisxVE13RHlrS0E4N29VWFR0K1lBVTU0NlRu?=
 =?utf-8?B?UWVTY1JHZnpDN0NSU1JmZE1GSStLeXRWYUgxSGZZNGVrYTluRlhCb0dBc3J1?=
 =?utf-8?B?YVQ4V3pXN3F3NTZIQk5QMG83RzhuYmIzbnpXTjl4aFRFWDlhWkF4RXRBQ01Q?=
 =?utf-8?B?eURHSnByVVhsYVVxcTNKSzhRNDEyRFlIZTJJbFROaE42OUxSODlHQkZRY0tK?=
 =?utf-8?B?Q2F1RTNnMEFBN0pMUFEzVVYyYXhaelFaem4wVURTaFJRU0R2NlZVSm5DUEpW?=
 =?utf-8?B?djFGZThTcHJudHlKWGJXRkExbk9MVGhkVFRaU3BvbnpoZkI4K2kzaVRaQ0Z4?=
 =?utf-8?B?eC9Iazg2UTJTb0tXNHZmY0xTS0xobDB0TFd6bExuREJIcnp6SUpkdkFQSXlS?=
 =?utf-8?B?cDVrTUlxMEp3Vjh3QkRRTTZNSDhrSWpxTmFoZ0NKUlMzVEVoMXBZMmNYK1A4?=
 =?utf-8?B?MGtpSGZLSngxTE1LN1V0Ry9NdXoyUC9VY3QrTE16RjdERGQzQWN1amhkVS9i?=
 =?utf-8?B?MkdFMXNsYzdFY0pUODRZTE40S3pyeHJFRWpwWWd5NlNmeEs2c0c2c1NCZHRi?=
 =?utf-8?B?RVFBakJpWFU4UmlZSHRrTzFOTTJHV25VV2ZxODhLOVkvTEk1bitCN0ZQT05W?=
 =?utf-8?B?ZXRmWHlIQ0o3NmVUQkxhWmtoWnJEQmVCb2JkejNNeGxCNC9wOWgwd25JMitO?=
 =?utf-8?B?ajF5RFR5TDFsMlJIamdIQ0F0YWQyTE8rSmFhNVpTRUhSemU3Q2lLb1FsVHVK?=
 =?utf-8?B?eUFtMTJEUzhYUjlUQkNhdWFCMDFiaHRkdHZ5b0xldjlkQzhuMDRwMXBSY1dU?=
 =?utf-8?B?NXM1ODFKMzN5T3hoNXd5cXNRSlFNVUUzSWM3MHVvNURWanZhYjZ0MXlzTTYw?=
 =?utf-8?B?Wjl3OGY0SDF5Z3pNaDBOcEdrckhpYUZVU0JETHMyaU5reGhRVGN6c29PaUlk?=
 =?utf-8?B?c3Y4WncwVy90eHM1N3pPS0wvdjRLOWdwS2RldVdYallZRjBLY0NPbXRNOENl?=
 =?utf-8?B?QmNoQjFENzRHM1ZTSE1YTkc1cllYWVI1czB4SExLRmNNSXJ5UG9JZ1NqRUtP?=
 =?utf-8?B?OW9udGd4K1V2bTJMS1BGb21DbDlzQjZmTnJ5a28xcFFiRExVRWpOcERmQ1I3?=
 =?utf-8?Q?GOwUBSd8txri2PKz0dG+n9hL3oVChY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6513.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGRjS3F3NnlCTnVySVBoVS83RkJXR0tudFN2dFVyNFB2RnNGUzUrK2hhMnB3?=
 =?utf-8?B?VU5CS2RBTFZNSncyR0VwWi90YmorUG9wTzNIOERKR2ZSWFczSXlsMm9oRW5Q?=
 =?utf-8?B?dURWdzRLR2ZKRGxqZXhtMnh2Ni9VU1o2VnBkNEc2Q0Zwei9ZNVZHTVlOQlF2?=
 =?utf-8?B?ZHNOL2hodWdYS0x4YmRFMGhLVk84aC8wcnRJRWN2WEpCQnM4SXk3Sk81YWNy?=
 =?utf-8?B?QXp6SkhNUW44Tm1iUVNJZzdac1c4VGZHWUF6dUZpR0d6UUtjVEo1Vk9pdHll?=
 =?utf-8?B?Y0JKQWtQQ1hCYXdlL2hWN1U3U2ZlWGg0ZGlxWVFFTFNoeDdQQWVFSm01WGhy?=
 =?utf-8?B?TFhLZk9CQW1wdXBVZXd3S2s3RXdWaDlXRTBEQWUwVHRoN1pkNUVnT0U3bFFi?=
 =?utf-8?B?SXB2REc1YzBnSTRlYlprS3JKWE8vSDZscTgvaElvanZjTTUrSm1Ja0MzRjZk?=
 =?utf-8?B?QmVnSVdPZHNDY1RvSXZFZTRzQ2ZGQjZPY1Qvd0ErVHdoWW5lT0ZObG5IZlRV?=
 =?utf-8?B?VE40VVVBeDI4blBDcCtKSWRmSGxOR3A5dFBBUVlnUzIxMzRKb2xVVkRqVVFa?=
 =?utf-8?B?MTdlRXBGWVdKeXp1QXZhVEJOUkd1azJlSm9qb20vQitEbXM5SG8zUFV1ZW1q?=
 =?utf-8?B?NE1lT3hudzFzb2l1UkNsZ001RGtUbVV4bWxTWWFYcFdzWWFzT3ExdUtOcGE5?=
 =?utf-8?B?STZyaDZCM2FjSWxWVHVIWEFDa0xiSE9iWmQ0NytJZk9EeEl3WkZQcTBNRXZv?=
 =?utf-8?B?MFhNTHYrVEdXSGI4TFFhSnBWQms3S1JSd3dHOERxMmZFQVNxd1ZBK3VJN0Z0?=
 =?utf-8?B?b0xLRW9KUG5KaDNEY0hMWlQ3WU13WGFMWmNXYmY3YlZzR2hpNDNQN2FvRW5p?=
 =?utf-8?B?clRoYzNlNEw3V2JFc013ZkxKR1JhdjF3cGxZM2NZVm5mQ2NEMmZ0a1pkd3py?=
 =?utf-8?B?bWppZkVMNUdUR01XVGp4N1J0aXRneGRwK0Fka1RuME5SOTBnd0N3TzRKR2xi?=
 =?utf-8?B?RWpPbTZHOVhnYmhNNnp1K09PaktjVXA5UFMzNXBFV0VjQ1BCQXdiMUdXVzFM?=
 =?utf-8?B?WERSYlFZQ2U5L3Z1U1lIQXVwSjVKZTI5czVjZnI0ZlJES01TUjc0bVc5amFQ?=
 =?utf-8?B?VVhpSzRHbWlSUkhTbUVGTTJyM0lPTHA3SzZoVjk1TkFVV3B5c2tlazZTUFox?=
 =?utf-8?B?UmdFS0tUdHBoZWVEc08rRFVGb2Iyby9janFzMWZXOGZ0bWpHZk5zWENTTytw?=
 =?utf-8?B?WnVmRVVJdkRtZTVqU1QyWE83aGNid0Y1NjlObXhTS3d4ZDRCbVNzQ3c1c1JO?=
 =?utf-8?B?Z3JCTFBlNW9zM1FTMXNGdVhDcURxaHhxaXRJQktJeEdyYVVOS1AzelhtUk14?=
 =?utf-8?B?VlRXaG5BWVJtaFl0ak9TTnR2aTRvcy9yV3NSOTVNRzAxb2h5NU51bFB5Y0Fn?=
 =?utf-8?B?R1lrSEpkMU5JNDd1UW1weUw1UW5QVDRrNGk5c1BOcm9rSkNCMnlJL2hycmxr?=
 =?utf-8?B?bTNHY0I3VTk3YXdERlJKR0ZmaVdtbEFIWThwdXNhcGVOUUc5VGptOVlmbVNF?=
 =?utf-8?B?VVlXMy8xOWxDK01TeFFYbC9lRmdtaGZTSG9WY1ZkQUpYL3ZVTUhUeDdHTDFT?=
 =?utf-8?B?UjFJaUJQSzE3c0poS1RWMG0vczBnOEFZRkxVZ2Y5djlvYWE1OHZhTzNybDhJ?=
 =?utf-8?B?MmxJeFNEOW0wY0xPaXQ3RjBSRUNuYUZWTmdCT1NQcjlFK1R6aWlMcGtNWVNR?=
 =?utf-8?B?MXpJZGxKY0dQMWNHSE1IdGJvdk8yQXY3NmlRbXNLYTBSSnJrYlhFZHNqQ3Jo?=
 =?utf-8?B?c29wOHdhcXowenNPVTlDZTd0bUxHZVJ5aWlpcWNISGU3VVc2WkVIa3pVaE5m?=
 =?utf-8?B?R0RBeE55WU93SXlDNGdiajFaSGNNUkFzcWM2YkU1NEpxQ1U1d0hBNDN2M1Rw?=
 =?utf-8?B?Q1EvUXhzZFpDaU1QU0hSUmZpK2xVUWY5VUFmQnpXNVBSVGR3YWlPVTNJYmZ4?=
 =?utf-8?B?dGk3NHNGWE5nL1MzZ01nU2ZFdSt0MWRQanNqNm5rWndNeFI4RGNEVnMvK28w?=
 =?utf-8?B?TVRxUDh3b2xsSXlRREoyOEhBT2Y0UUR3UzgwSjVEZFBXWWYza2VhNWpaeWVQ?=
 =?utf-8?Q?fQzLZPaPhZb3RubpIZURxkwBS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6513.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b06087b-8071-4d0c-c9b0-08dd80680a6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2025 00:04:09.6235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GyQ546R7Pi1LB7g9GMB+x5D+2x6zcAtj/BcrYOKM4Fh5pgU/fJs9zIwDzaRF6nTnr6EfDAlvBVC/qnRBMredYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6441
X-OriginatorOrg: intel.com

VGhlIGdjYyB2ZXJzaW9uIGlzOg0KDQpxaWFvd2VpQHdxaWFvMjp+JCBnY2MgLS12ZXJzaW9uDQpn
Y2MgKFVidW50dSAxMy4zLjAtNnVidW50dTJ+MjQuMDQpIDEzLjMuMA0KQ29weXJpZ2h0IChDKSAy
MDIzIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbiwgSW5jLg0KVGhpcyBpcyBmcmVlIHNvZnR3YXJl
OyBzZWUgdGhlIHNvdXJjZSBmb3IgY29weWluZyBjb25kaXRpb25zLiAgVGhlcmUgaXMgTk8NCndh
cnJhbnR5OyBub3QgZXZlbiBmb3IgTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFS
VElDVUxBUiBQVVJQT1NFLg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogRmxv
cmlhbiBCZXpkZWthIDxmbG9yaWFuLmJlemRla2FAc2llbWVucy5jb20+IA0KU2VudDogTW9uZGF5
LCBBcHJpbCAyMSwgMjAyNSA1OjQ3IEFNDQpUbzogUWlhbywgV2VpIDx3ZWkucWlhb0BpbnRlbC5j
b20+OyBLaXN6a2EsIEphbiA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT47IHhlbm9tYWlAbGlzdHMu
bGludXguZGV2DQpDYzogQ2hlbiwgSG9uZ3poYW4gPGhvbmd6aGFuLmNoZW5AaW50ZWwuY29tPjsg
UGlyb3UsIEZsb3JlbnQgPGZsb3JlbnQucGlyb3VAaW50ZWwuY29tPg0KU3ViamVjdDogUmU6IEJ1
aWxkIGVycm9yIG9mIGtlcm5lbC94ZW5vbWFpL2RlYnVnLmMNCg0KT24gMTguMDQuMjUgMDc6NTEs
IFFpYW8sIFdlaSB3cm90ZToNCj4gVGVzdCBwYXNzLg0KPiBUaGUgc3lzdGVtIGNhbiBib290IHVw
IGFuZCB3b3JrIHdlbGwuDQoNCldoaWNoIHhlbm9tYWkvY29tcGlsZXIva2VybmVsIGNvbWJpbmF0
aW9uIGFyZSB5b3UgdHJ5aW5nIHRvIGJ1aWxkPw0KDQpJIHRyaWVkIHRvIHJlcHJvZHVjZSB3aXRo
IGdjYyAxNSAtIHRoZSBsYXRlc3QgZ2NjIHJlbGVhc2UgLSBidXQgaXQgaXMgc3RpbGwgYnVpbGRp
bmcgZmluZS4NCg0KWW91IG1lbnRpb25lZCBVYnVudHUgMjQuMDQsIHdoaWNoIHNob3VsZCBzaGlw
IGdjYyAxMC41LCB3aGljaCBzaG91bGQgYmUgZmluZSBhcyB3ZWxsLg0KDQo+IA0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1l
bnMuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgQXByaWwgMTcsIDIwMjUgNDo1OSBQTQ0KPiBUbzog
QmV6ZGVrYSwgRmxvcmlhbiA8Zmxvcmlhbi5iZXpkZWthQHNpZW1lbnMuY29tPjsgUWlhbywgV2Vp
IA0KPiA8d2VpLnFpYW9AaW50ZWwuY29tPjsgeGVub21haUBsaXN0cy5saW51eC5kZXYNCj4gQ2M6
IENoZW4sIEhvbmd6aGFuIDxob25nemhhbi5jaGVuQGludGVsLmNvbT47IFBpcm91LCBGbG9yZW50
IA0KPiA8ZmxvcmVudC5waXJvdUBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBCdWlsZCBlcnJv
ciBvZiBrZXJuZWwveGVub21haS9kZWJ1Zy5jDQo+IA0KPiBPbiAxNy4wNC4yNSAxMDo0MywgRmxv
cmlhbiBCZXpkZWthIHdyb3RlOg0KPj4gT24gVGh1LCAyMDI1LTA0LTE3IGF0IDA4OjE1ICswMDAw
LCBRaWFvLCBXZWkgd3JvdGU6DQo+Pj4gSGkgQWxsLA0KPj4+DQo+Pj4gSWYgd2UgYnVpbGQgdGhl
IGtlcm5lbCBpbiB1YnVudHUgMjQuMDQsIHRoZXJlIGlzIGJ1aWxkIGVycm9yOg0KPj4+DQo+Pj4g
ZnJvbSBrZXJuZWwveGVub21haS9kZWJ1Zy5jOjIzOg0KPj4+IEluIGZ1bmN0aW9uICdzdHJjcHkn
LA0KPj4+ICAgICBpbmxpbmVkIGZyb20gJ2hhc2hfc3ltYm9sJyBhdCBrZXJuZWwveGVub21haS9k
ZWJ1Zy5jOjk0OjI6DQo+Pj4gLi9pbmNsdWRlL2xpbnV4L2ZvcnRpZnktc3RyaW5nLmg6Nzg3OjE3
OiBlcnJvcjogY2FsbCB0byAnX193cml0ZV9vdmVyZmxvdycgZGVjbGFyZWQgd2l0aCBhdHRyaWJ1
dGUgZXJyb3I6IGRldGVjdGVkIHdyaXRlIGJleW9uZCBzaXplIG9mIG9iamVjdCAoMXN0IHBhcmFt
ZXRlcikNCj4+PiAgIDc4NyB8ICAgICAgICAgICAgICAgICBfX3dyaXRlX292ZXJmbG93KCk7DQo+
Pj4gICAgICAgfCAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+DQo+Pj4NCj4+PiBU
aGlzIGlzIGJlY2F1c2UgbmV3IGdjYyB2ZXJzaW9uIGhhcyBzdHJpY3RlciBGT1JUSUZZX1NPVVJD
RSggPTMgaXMg4oCMc3RyaWN0ZXLigIwgdGhhbiA9MikuIFBsZWFzZSBoZWxwIHRvIGZpeCwgdGhh
bmtzLg0KPj4NCj4+IFRoYXQgaXMgdGhlIGZsZXhpYmxlIGFycmF5IHN0b3J5Li4uDQo+Pg0KPj4g
WW91IGNvdWxkIHRyeSBzb21ldGhpbmcgbGlrZSBiZWxvdyAoY29tcGxldGVseSB1bnRlc3RlZCkg
YW5kIHJlcG9ydCANCj4+IGJhY2sgaWYgaXQgd29ya3M6DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2tl
cm5lbC9jb2JhbHQvZGVidWcuYyBiL2tlcm5lbC9jb2JhbHQvZGVidWcuYyBpbmRleA0KPj4gMjVi
MTk0YzI2Li5kMDQ4ZGM3NTcgMTAwNjQ0DQo+PiAtLS0gYS9rZXJuZWwvY29iYWx0L2RlYnVnLmMN
Cj4+ICsrKyBiL2tlcm5lbC9jb2JhbHQvZGVidWcuYw0KPj4gQEAgLTQ3LDcgKzQ3LDggQEAgRVhQ
T1JUX1NZTUJPTF9HUEwoY29iYWx0X2RlYnVnX3Zmcm9vdCk7DQo+PiAgDQo+PiAgc3RydWN0IGhh
c2hlZF9zeW1ib2wgew0KPj4gIAlzdHJ1Y3QgaGFzaGVkX3N5bWJvbCAqbmV4dDsNCj4+IC0JY2hh
ciBzeW1ib2xbXTsNCj4+ICsJc2l6ZV90IHNpemU7DQo+PiArCWNoYXIgc3ltYm9sW10gX19jb3Vu
dGVkX2J5KHNpemUpOw0KPj4gIH07DQo+PiAgDQo+PiAgc3RhdGljIHN0cnVjdCBoYXNoZWRfc3lt
Ym9sICpzeW1ib2xfamhhc2hbU1lNQk9MX0hTTE9UU107IEBAIC05MSw2DQo+PiArOTIsNyBAQCBz
dGF0aWMgY29uc3QgY2hhciAqaGFzaF9zeW1ib2woY29uc3QgY2hhciAqc3ltYm9sKQ0KPj4gIAkJ
Z290byBvdXQ7DQo+PiAgCX0NCj4+ICANCj4+ICsJcC0+c2l6ZSA9IGxlbiArIDE7DQo+PiAgCXN0
cmNweShwLT5zeW1ib2wsIHN5bWJvbCk7DQo+PiAgCXAtPm5leHQgPSAqaDsNCj4+ICAJKmggPSBw
Ow0KPj4NCj4gDQo+IEEgYml0IG9mIG92ZXJraWxsLCBnaXZlbiB0aGF0IGFsbG9jYXRpb24gYW5k
IGFjY2VzcyBvZiBhY2NvcmRpbmcgc2l6ZSBoYXBwZW5zIHdpdGhpbiB0aGUgc2FtZSBmdW5jdGlv
bi4gTm8gc21hcnRlciB3YXkgdG8gdGVsbCB0aGUgY29tcGlsZXIgdG8gc3RheSBhd2F5IGhlcmU/
DQo+IA0KPiBKYW4NCj4gDQo+IC0tDQo+IFNpZW1lbnMgQUcsIEZvdW5kYXRpb25hbCBUZWNobm9s
b2dpZXMNCj4gTGludXggRXhwZXJ0IENlbnRlcg0K
