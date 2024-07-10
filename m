Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5B07D3F5
	for <xenomai@lists.linux.dev>; Wed, 10 Jul 2024 08:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720600456; cv=fail; b=qV8DSSz5mSACZ3qf84s1YREB3Zn+qSOK4K8D21j5b30/Ov5Hnc0M8fImRM7h5FSTiJOagTWsQ+wrHXBxlBfr/HoP1W2kD2+1TAdhg0DZ3rzVCFRRACaGq8ch3PsXuLVRnoMsy9zynrTs67VEOi1XIrFarcMPb8NljHTHieWorj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720600456; c=relaxed/simple;
	bh=SjHfFuQCA/JJA4MoLfN8FzrGWmpmUGa/+UBL+fRdxKA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cMd+sh/dWEjKlK+kNcdHZ8xZ9yfdgKM6QY0hkKxO8dm+O2vC2bJm3kt9fRIEo5YXA8LkDvuFG5QK30O+tCXIEJM0dsJulBTrAgRqoifAsx0uiJkHx0GJibSdL3C/PdBh+IUx0tI7W4no8in6bcf3UPZLLD2hb54FgsFEkN0rYPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e5aKCLIw; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e5aKCLIw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720600455; x=1752136455;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=SjHfFuQCA/JJA4MoLfN8FzrGWmpmUGa/+UBL+fRdxKA=;
  b=e5aKCLIwmcmtPAKtKoOk4xgj0ccJTJlJgmSlWh051G5gAHC3OhS3Gvyv
   2ypvEWrOEX2OvfEqJzkyDIO/1slVFU+mRmLEUUJVxC/RU0gCOknLZ95SR
   6HaNp+vm/MZnuKohBFJ4NetbfkvLcyt3Bzgb4yhberRea3sKW7owMq5Yq
   9R7gVc2S4ZXW7pFjHaK0+zqEd9Qb6zUEwjN+UuETJcC8FgSfsouvy/IZ9
   A/KZFs/SJiayikoIZ1UdcM18xSR4jEH+DnoxE5F1WfDq8gUvrtJpm7MQh
   rA3hBNHvOBwOB8jPhhvd3BVw0bSTcOQsgYAuq/CDVgGPCP2IXwWrjGc9n
   A==;
X-CSE-ConnectionGUID: YrIy+RRrQ++zuFmhYv/G8A==
X-CSE-MsgGUID: +nALOptpQ3uzVzxhBqMWEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="35337767"
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="35337767"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 01:34:14 -0700
X-CSE-ConnectionGUID: PwaEppIGTtejwhB5KIMKIg==
X-CSE-MsgGUID: HG5cW+L2R/inwHBLTJaSIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="48116286"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jul 2024 01:34:13 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 10 Jul 2024 01:34:13 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 10 Jul 2024 01:34:12 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 10 Jul 2024 01:34:12 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 10 Jul 2024 01:34:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKh5Gd3PJBHr9M1nA9thrEg4FEOaEE4MlbXYPcaYh05pTJ5SARlElHromExQeHUoMIqkmVLMT0EuGscGxH31yO44P0PUnOd5AGACHsTqQIcfLqpSnhn5Z/DEes7yMB4joavepyxdEKzQNmQIlH5ysD03AJbZKilnaYagpK1yD9WDyIjkIKwKzeeMyy3swa6bHxH4fPgZ+je1BtBmhjcXj+UOgjIH6xzbcB7jLHbUKjZBkaBp2HqosEyKQOf0zg7SWrX3JON1J/n0lYQ1E2G2gR16LPzExkdlONzuEDp7ip77NC7TNFSNPcE1itA/wTIXAegcZPGG0iNQBr3AXH5vyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjHfFuQCA/JJA4MoLfN8FzrGWmpmUGa/+UBL+fRdxKA=;
 b=kR0OnNpnmqqvdchEdKMq+MnXbYIY96gmV+DxcVLHQkdyElTHK4KIGc1fmbh7XHOB+czTmctzjAGChE10PFvwGbCdYr2ziFqTY3wqHDb+TI9p3XD+7U4pxyd8/+v0iTximLgssdkiUicPTN9fvLsyaheuj3tcCOYq6fswDdHlRb6tt6BQws9OPcb9Z99HkxA++tl7qz2zZfoQC9bq9swEA+oUoVfd0cEwFJ6+x9tDSAlXRVAWvXzphNhyQhBlnPgfecs2m9RieK9Xj2wssdS8tQLRoVLN/V6UuLdeSv1gX7f7lk+eBnsdnSHjoVLOJ8tDrs7E7QI9xVOkxDD9nqw/PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by CH3PR11MB8519.namprd11.prod.outlook.com (2603:10b6:610:1ba::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 08:34:10 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d%6]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 08:34:09 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Xenomai Community Call Minutes - Jul 10, 2024
Thread-Topic: Xenomai Community Call Minutes - Jul 10, 2024
Thread-Index: AQHa0qPvmPh1BPfN20qjk4q7gRQ8xw==
Date: Wed, 10 Jul 2024 08:34:09 +0000
Message-ID: <PH7PR11MB7499B96C3A6A82AEE69DC40FF2A42@PH7PR11MB7499.namprd11.prod.outlook.com>
References: <PH7PR11MB7499F7DDE006A3A7291F61FAF27B2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749929DFFDCFE47376883636F2572@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499F4FFFC62E15096DFF8D3F2562@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749910600BAF97BCB41DC3D3F2202@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74999307830ABE8C6E622DB9F2F22@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74999CE443EE8E36CEC314FAF2F32@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74992D53E248664E6D075779F2D72@PH7PR11MB7499.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB74992D53E248664E6D075779F2D72@PH7PR11MB7499.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|CH3PR11MB8519:EE_
x-ms-office365-filtering-correlation-id: fc3dcf8d-5fcc-4515-cb22-08dca0bb11d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bXkvNzhObVpvSXBEVVVxN0xiRzdOVU9LS1F6TDNTekVQakZZVkNRN29lTDlx?=
 =?utf-8?B?WjQ0aUowYWpubTlaTGhVMEFaRFJaS2dNRnlCd3ZURVJjZTF5alVOdno5WTZ1?=
 =?utf-8?B?WTJMaU5WSXYxM1J4V2JCeG1QdzdkY3Z3V2NSMlZzT21GMXJDT2l4RmxwU3N0?=
 =?utf-8?B?dk9jRldoT3ZnUE1IeXlxUzRJM3ZrbGMxYkpGaDFYMlpqS3hLS0lDVVM1Mkp2?=
 =?utf-8?B?LzlnY1E4M2NVaHZ3UmdPMjlCWENlRE9Fd0pDaUZzYWJBQ2lQUkxZSFloRzI0?=
 =?utf-8?B?WUZWT1pjQmhoQWV3S2hxV0l0SUpYUkovQ2krc2pUekhXYWNjVm9mZ2k3Y3M1?=
 =?utf-8?B?OGFwTkJMb0hIQTkrUmFleURxeTRqb3V0K0k5RnF4S1kxMHdWalQ0eGpWbk1I?=
 =?utf-8?B?RHhIVzI1ZWU3VUVOWTFuUEY5eU5UdVhySUVTR0NpRi96dWlQWGRSazV3K2V4?=
 =?utf-8?B?ZUVvYlQvREZPb3p6akpiWlB4cmtIRkxyUTJSTG4zNnNZMDJHN1NUTDJoYW9S?=
 =?utf-8?B?ekVsZXNTazJEamJSUXFNaTIzZHV1WG5OSTRVb3p3RXRNRTlQc0xyQW9mOXlI?=
 =?utf-8?B?aFRBVUdXQ2YvUm0rdCtKNU5BMlZlTDNYcnY3L3V5ZWZmSERyYzBlQXhEL3No?=
 =?utf-8?B?Q1JySDZKamQrTU43WTdRNXNvWXJleEpxeFEvZGNQQmpwbFYyck9RMFBjSjZQ?=
 =?utf-8?B?VlhkS3dET2Y3Rm01V1AyT0JHVjdjM3hSWkRqZXh2NUkvbHVyNSs4cGVNRHZS?=
 =?utf-8?B?bmN6aVZkUURwVW83anZBN09RbWFPTytNVmYzTVZ5b1dUVXh2RUU0aVc5WUR4?=
 =?utf-8?B?RXAxY1h2V21xbTFRWnl2YnBtOWhvdUZvVDBLZnByS2JJM3BXeWh0VDhtZXhM?=
 =?utf-8?B?VDg0MEsxTDhWenplRk1QWGtGR0JscncrWnJZRHF2ajkwblNjem5xTW9pZ0s5?=
 =?utf-8?B?MDJoZVJGUG5rUGtsbUFqS1pVUFpoejBzcFZtR3E2UW5wS3pIR20xMEI2SjRW?=
 =?utf-8?B?eGpveHNtR3ZzWmpOMGNnejczbk5RV09Qak55a3VOY0E0T2ZHRzlJQWgzVk5C?=
 =?utf-8?B?T2Ztc09NR2hWMkRVRFc1SlNsaXpPenRXRUlLekZUYVRSVjA2QStkeThIMDBF?=
 =?utf-8?B?K3ZyeGdENXJnMmRpWW5GREZwY2tjT2Ziays1THk3amxnQjE0aSs0WGlrd1Ax?=
 =?utf-8?B?ZmtRaWI0K3pxaGMvV0pKWGhjNDNBK1ZzNkwzZUZnZ2FHMmFVWWFXMzV2eFVP?=
 =?utf-8?B?NFNOekxVNHNsSU9RRkVoQ0t5NXBCNG50VnRxamoyc3hvOXBib2YxUTBVVG1J?=
 =?utf-8?B?dmc4bXZYQ1JTZTc2NVdhV3pTR25IS2xyRTU0aWlKdGFBT21nZG9CVmVGY1hV?=
 =?utf-8?B?c1lGTEVJd2ZDbmtJOWg0Uy9sRGxFbE12anZXZ0RJQzVHOXhhTUwzb1BnZ2Uw?=
 =?utf-8?B?T014dDZvU2E3UUNyYUJqeDIvQkJoME1UZy9WNTl3eUhvUTVrVmtpQTdTVGsv?=
 =?utf-8?B?ZUh0eGFmSTJ1VG5hQVR3bUZVUGxXY0xYVlNsMjFOeUhTRkFEdmFiMnpaWDl2?=
 =?utf-8?B?ek42N2tLMENvM1lhQjFrbjBkS1dZVjlUVE8rZ1VRTEVmeit5VnNCRjJiUFBB?=
 =?utf-8?B?cFYxWUhuVXFYSWc2VEV1OXk1ZzBpa2lkYUVvR1doY2dFNVBmOG8zRVVwUTJB?=
 =?utf-8?B?SkNCRUplRThLaHdDemRhSWQ3aXFheDNJUVNqRDJzemtxSnViR0syTDVVRnlU?=
 =?utf-8?B?MXZWbGxuYUhaSFNySHhtdldJYWhhSG0xRzNqbGhLWXFRanNkbU5HT3RnUGNS?=
 =?utf-8?B?Sy83MURMVW9RR3FCNmFDY3h1eS9oTWpXcjJTRFZvbmlLSzI5T1l2OHVYeVRZ?=
 =?utf-8?B?cEY3WS9PMThocTRBeHB6a0tIVWJnYlp6WEVoRmJld1BsTmc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmluS203SlRFUFFkc2pTbExhWnpyNnZxR0VWNzViQVdnWjFsQjB3Wi80ZWta?=
 =?utf-8?B?YlpZbU1jbExGdDlFVjg5bVluQ1RhS1JOL1ppMUh5REdBNTlPc0ZrVllXS3RC?=
 =?utf-8?B?TjlYSmY1K3A2S0dKOWJvMkg2ME0rOVpDVmFiMmhBTUVNOWh2dlduelZnbkx0?=
 =?utf-8?B?eTF2V0xLR1d5dGFsNEhvWE4vUkNQQjFTVnRXejVDZ2NpNVRXRDRwUXZudmgv?=
 =?utf-8?B?VzZpNFVacFdTQzVmRExhaGRsS0Y5eWU0cWp3ZjdxMGhDUGhHSVBZRjhVem5F?=
 =?utf-8?B?bEZobTRudVRWR2RkWUdKYldMN2VIOWdKYmlkaEFLVHpxaHZvanFjblZLY1hw?=
 =?utf-8?B?Q3diSVNBV0s5bHpkMU9oa1BJaGw2M2FKL2Y0M0xxRWpFYUdxcW5XNmd5eVkr?=
 =?utf-8?B?eWZHckZqV1VqcXZ3YVBCSEg0MEg0dlhmREZjbXVabjRsdG9nZmt1RWwwSVo2?=
 =?utf-8?B?RCs5enZKNFMyZWFWR0Zxd2w5V1FmSWhNbkc2aFFSV2M4TEFBTHNqMHFENG5P?=
 =?utf-8?B?MFVxRWxta3dXclRMQzlKS2pmY3ZxZzFTeG8zVFhZWkxJc01PYTB6cWdXdXND?=
 =?utf-8?B?OVNDR1hmSDhNUW9zN2tBempWVWxNVHJsYXAvOC9jMmdiekRyWUxhemloT05i?=
 =?utf-8?B?YVpHelZXV0ZZTE4vZDNLTTdySW4xTjBROTJPaUVvRDdPYjBNeUUxUjk4Y3Ni?=
 =?utf-8?B?UVZHMDVxVkxNMUo3SGZadWJzY2ZRY2NxTjM3bnRXOFRWRXJyUTU1eml6dnR2?=
 =?utf-8?B?NU1GSEtkVDZILzFMYmlXK1U1akh1NEtpZVIwOW9HTHgrTW15cm5OQ1hYQlAx?=
 =?utf-8?B?cXQ3OGJRbUFXM1VING1xZC9MUGg1RUt3N2pvWnJaTjNvelhPdzl5VjJySlFt?=
 =?utf-8?B?R3ZwZzNuSWR1citnUE5WcU1laUhycUc1RzZRWnUvb3ZVeXVDeDJOR1lBS2tk?=
 =?utf-8?B?Nmx3TVJyWmJuanhSMjVsbExMa3ZYUXpidk5zZml2YVVvaTZpUkY0a1RxT05G?=
 =?utf-8?B?NUwvclhGQklCR3ZlMlBzVUg2allUaVR3WnZJT09WU250ZHNrcUZadkhFSG03?=
 =?utf-8?B?SDFyV1dkWUtmcGxidlJmbU44NnM0MktERkVVczNtUE14MFhiV25QSFNrSmtJ?=
 =?utf-8?B?dFhFeUl6bnhJcENXTFlxaC9qNmh1QkVaOS84bkRtcEkxcGN3SDN3NnZuS3d5?=
 =?utf-8?B?cUZhdUxRRnk2TlVsVlliOWkyb24wc3FoY2NvUkc0cXo5OHlvdldyc1loWWFW?=
 =?utf-8?B?eTFYeFM3ZnlWZVk5ZGUraHQ1REtxdGs5WVpFUklnNzdONUw0aXZ6bFAvcnZj?=
 =?utf-8?B?amJhNlJCalp2eVRmZmdkdGUxME80WHZDS1BsR1I2VTFtZTk1K01nL1FXV1lV?=
 =?utf-8?B?Q2w2eDBXMWJLWHoweUIxaWF1ZkRjc0I4MjBqaEkzR0FyTHIxaStYbEZHUHJa?=
 =?utf-8?B?OWE1ZmJITkRnaGlNWnR1Lyt2U3BmaXdiQ0p5MUxmSDVyL0JSb1V1OVJqRHBY?=
 =?utf-8?B?Wlg5aVRVMjRzSWVXdFYzTTJRd2xmQmpzNHRzMCtyU1NjeW5tRzNvMVhaUzR2?=
 =?utf-8?B?OWdyVmRqSStNQmpRV2RMNStwTlRMdVlYTWlhM2djOXdMRzVReDVzNzRyZlFV?=
 =?utf-8?B?ZUxuQUxxdTJoRFl3cFVKMDdLZEQ5anBFazVXQkJ2eXJkbUxqWEo4UHY3TW83?=
 =?utf-8?B?VWdKTWVDRndGZ1k3K09KZXBUVC9LMTNSdktnUm02YzFpOHNDUnZ5WVNsYlJI?=
 =?utf-8?B?bVVqRGJqZHJKMEdVUWVMVCtNNUxjS3VGWnN3VWYzYjQwc2FJb2RHd1J5N2Qy?=
 =?utf-8?B?NnBMWnBabDJreVo4THRxRzlTSnN3QU13MmMvckhjeFQwT21KNUk1QUFham8w?=
 =?utf-8?B?QUhXTTFqNGhQbE83OUtrbzFUaktLVHpYTHZzV0FLSFc2N3ViekN5RU5yN0VW?=
 =?utf-8?B?M3ZJeDJ4UytpQWkvVUVBYys0T3ArOWppTUdwZ2dHdDFBL21KZU40YWk2YU5B?=
 =?utf-8?B?M3ZpZjNRQ2NxSjlPdy9TbjFjdHg2SnBMeHNLcnFlQUxJbXJubmRRNFZJc0g0?=
 =?utf-8?B?TGxQTVI2ZmJqcC9JbVF1eFJGaFp0VDVscGVBbXUxL0FaSkhxem9VV0ZiVEc5?=
 =?utf-8?Q?AxwzPa+KvTC1epoEg6Ck8ELqE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fc3dcf8d-5fcc-4515-cb22-08dca0bb11d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 08:34:09.8309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bEpG8bc2tqOrR9UVRAb2jUiz//PYP1Qa6u/Tm8bdoYVDYqe3SqVFtmLCk3lMcn+ubNM3I7i1256syBe1Gv/yNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8519
X-OriginatorOrg: intel.com

QXR0ZW5kZWVzOiBKYW4gS2lzemthLCBGbG9yaWFuIEJlemRla2EsIFJpY2hhcmQgV2VpbmJlcmdl
cg0KCQlEYXZpZCBPYmVyaG9sbGVuemVyLCBMaWFuZmVuZyBMaSwgQ2xhcmEgS293YWxza3ksDQoJ
CVRvYmlhcyBTY2hhZmZuZXIsIEhhbyBMaSwgSG9uZ3poYW4gQ2hlbg0KDQpDb21tdW5pdHkgdXBk
YXRlOg0KCQlYZW5vbWFpIDMuMyAtLSByZWxlYXNlZA0KCQk2LjYgRG92ZXRhaWwgIC0tIHJlbGVh
c2VkDQoJCTYuOSBEb3ZldGFpbCAtLSByZWxlYXNlcyBzb29uDQoJCUV2bCB0ZXN0Y2FzZSBpbnRl
Z3JhdGlvbiAtLSBvbmdvaW5nDQoNCk9wZW4gZGlzY3Vzc2lvbjoNCgkJSWRkcCBtYnVmIGxvY2tp
bmcgaXNzdWUNCgkJZnRyYWNlIGRlYnVnIG9uIEdQVSByZWxhdGVkIFJUIGlzc3VlLg0KCQlYZW5v
bWFpIHdvcmtzaG9wDQoNCg0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQo=
