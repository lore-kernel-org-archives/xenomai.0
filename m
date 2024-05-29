Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A74632
	for <xenomai@lists.linux.dev>; Wed, 29 May 2024 01:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716945894; cv=fail; b=ocG8wshggpwVb/lG6se+BRm0fpc2Jm0iOAqjd3E9ELxRmPkcmHThWhptBxmfA+ZhIGXf1oCZjfhQubCK1s/N7Jq2IAie68+IpazGbb9ALbeVls8ntbPSbOWxDBRx6Ji99B+dmz+ou6I6XJ7CwjB5dLi5R9Gmg/D/Xah9sjFlWYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716945894; c=relaxed/simple;
	bh=ChWusjGB/d21ATGuUg8jXaXUBuTWcfBGzdCRMo2Y1p0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J3433CZjqH2ODMExkleCTUtjBtpqMmwnHZQrOJYEX//xluPt/WuYMUsj39oLXHhAMuA2A4Tjng26S0gBBwTasvDFjlvP0YVmJUHZomaadfAJaboTldRrQxbeP0VVcW1YmkC9UGGVyl+iFRX4OQz2URXjNgR7Rr+ejkcyjsdqHbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I2pMTJvD; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I2pMTJvD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716945893; x=1748481893;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=ChWusjGB/d21ATGuUg8jXaXUBuTWcfBGzdCRMo2Y1p0=;
  b=I2pMTJvDYixAPPdl/0GKDXxur7zn6nhCNesTMpVP4oDZx6OMU8VnPwxH
   q8OR6YXTzq/r38KL+VRjIsfD4R6zeubGtSTnT7Nm+sC0uI5KZfbMYRMIQ
   jXBe4FbsTA4xJcONwA+BnOrEkgZQDgr/xxd6Qxjk3iR8NXlHA/CA777wu
   kpNyaGCKB3KZg81TMTD6hNOnQRSRNGp2TYEIX8x6OtoqlAg1N32MVI/7m
   3zrFNFryun7VglRvlQosee6bQN3DdLjai/kgQIQS17FaZnvy1g6k5gTRX
   qYZFKH7qL71kLGTNWDhOxojp3O6dpYwdEAczDyYcMsUoP+nD4J57F+SVF
   Q==;
X-CSE-ConnectionGUID: 4CptAkbVTGWPhIiP/PDEZg==
X-CSE-MsgGUID: 17qNp0idRP+w/36/WNL3bw==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="38709599"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="38709599"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 18:24:52 -0700
X-CSE-ConnectionGUID: NNaCJ5RGQvWX0tI8l8IEyw==
X-CSE-MsgGUID: juEx0ru2SGuXOuGGo6Fcqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="58434086"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 May 2024 18:24:52 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 18:24:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 18:24:51 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 28 May 2024 18:24:51 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 28 May 2024 18:24:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aCLwGb6N+w49u90dpFb0TOLTTzWSikRxTv5W0UALi6QZiUICX3oCqT4NJnDFzPMUZL1XfWRywmap1gBSdPCA8aXi7vdhPvu5cIgjdrjf5m4/SaC28LkEjV5V0ku3SrR6EGXgHBy+i+4OlFaySbBVJw/iWCNKGRSnKpNuGNTdqDd+ohklQ5OG+3rO3QvPM9hcwzX7nUx3xbQUSQ6djBVMlc3nEGwVhbnuD3lSLxcuOAI7k4d6xfM15W1YxgewpJ7dKWmkzG56IHcfNb20jUef4xSj7mfR9TgaLWVfZ0c5YtAH0UMPAb6n0ZeiSoPCxPAM8/xkOkz4TGmr/hwrVgbNQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChWusjGB/d21ATGuUg8jXaXUBuTWcfBGzdCRMo2Y1p0=;
 b=mvrjGRV7k6rjFTaa/dw0sxbvYjplRTtjyIddy8/HUgCqF9Y3XyBUgeenZhkTClngg72xcfkKLHQdaYNT0Lc0ujc75f8LNAaW1DKAziYAuF0bZHF/2Bi8xoTCqxd2PnnAew0Kq+dGuiyNZGync3dbos7wehcF1vLDEudmr+g9SMKuoFhg70krB7K82kQ5zvdwabLoDzXiwCaawByMT6Wtyx8oZh/7A0gTMixkcRPcKwzIoOxiCIlbmAJHOfUkFxDuEEeg/80tK3t9Bwc4YPly4oHqNxOgP+Qp4BrsFhCZPDBzRnTrsRb3+DOP2pFQ7r439kF6ET9wMTZK1944Vbh9fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by SA3PR11MB7535.namprd11.prod.outlook.com (2603:10b6:806:307::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.31; Wed, 29 May
 2024 01:24:48 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d%7]) with mapi id 15.20.7611.030; Wed, 29 May 2024
 01:24:48 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday,  May 29, 2024, UTC
 7:00 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday,  May 29, 2024,
 UTC 7:00 AM
Thread-Index: AQHasWb+T7+N3IGO00C+BRitY2zfIg==
Date: Wed, 29 May 2024 01:24:48 +0000
Message-ID: <PH7PR11MB74993A52AA247D08069980E4F2F22@PH7PR11MB7499.namprd11.prod.outlook.com>
References: <PH7PR11MB7499F7DDE006A3A7291F61FAF27B2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749929DFFDCFE47376883636F2572@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749988D3E2C96C4F21DAEBE4F2212@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499C4BB71E159B3AB98D686F2332@PH7PR11MB7499.namprd11.prod.outlook.com>
 <DS0PR11MB7482613E8A9D78229EA71D07F2EC2@DS0PR11MB7482.namprd11.prod.outlook.com>
In-Reply-To: <DS0PR11MB7482613E8A9D78229EA71D07F2EC2@DS0PR11MB7482.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|SA3PR11MB7535:EE_
x-ms-office365-filtering-correlation-id: f63ab460-af87-40cc-cb04-08dc7f7e2175
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?dzFtc1I1MDdtend0VEJKOEo5SWVRbnovNVdKa0svK1JlT3ExOFpVN2QwRXBU?=
 =?utf-8?B?TGJYTm9GVWRYNFY3cFlkV2lQNXBTWitDRVJlN1BPRXprQ05NdlhkWkFXdTFw?=
 =?utf-8?B?TFRsYnIwbEZYelZ0NXR3UDJMWWhISzBOQW43bmNqdWFhc2pwRkVqUlJEclRS?=
 =?utf-8?B?M2tOS05VL2dHQUJ2eDh4NEU5ZEF4RTNUeGt1V0VmMTIyeUMvblVCdGIxdEFJ?=
 =?utf-8?B?aHBiVnRhcGNISHNZQkZNSkcxZmtGd1g2RE04ZDVKbGNzZmR3Y09CbkRNbnVI?=
 =?utf-8?B?eStlWFRXYnl1WnYyV2U3Wk1SOXMzYWNpeXJvd2xjQ25yaFhlZlRGRzFQQWpC?=
 =?utf-8?B?T214dFl1TTM4ZVViMGFDeTNzamVaaERZU0JkeWt0NDBBZ2RKZFZLUHdKLzUv?=
 =?utf-8?B?c2Q0eElCdWRoUEdXZFZreDVOblVUcG5KUFZpUHM3K1NERmpBSXJOSjNrL1JH?=
 =?utf-8?B?TUQ3bUdqSzF0TmJVekVzaFhlb0Z5djFpdkN1OHc5QlBBbXJ3ODZsV3R1S0xk?=
 =?utf-8?B?UWl2QVNBK3ZMbTkwVzJqWkRVZGRaWGw2QzVvMjRqZ3hGZGg1VlBZNDdYOWE2?=
 =?utf-8?B?SEpTVVhZL1NQYWhzNjNaM00xZjlISGxpeTFKNnlCcXNhdlVWdU1tcWphZjlq?=
 =?utf-8?B?Z2Q2akxYR3o1eGtOck0wQnJSSTF1OUVCYTlQNHI4UnVJWkd3elpDcVBBbVcw?=
 =?utf-8?B?RkQ4QjlQTjlvaDNweUZkblZQUHFrcUN3MGp0cnJ4cUZ5Q29pNDVhNzdjOWYz?=
 =?utf-8?B?RGV5b0pMSTcwajh2WkZxa3RMZlRRRTVGMHN2cFhRZHBXQzlSeTF1MldKU1JZ?=
 =?utf-8?B?UExBZHNQRzFCeEk5QlMzcTAwZDR0bTVTMUFGRmtVUjdMc04xWmhwaUxnN1NG?=
 =?utf-8?B?UFNzSXVpS2RQcm1ja1FTQmNlcVlNb1BlNTRXbmFMbVJ6SXllaGVNZCtnNWZr?=
 =?utf-8?B?eEJORFJsVDV0emczcUVDOW15M3dMRXZQa20wZGpPVDlxY1dQQWdIN084Q2lx?=
 =?utf-8?B?ZUhscHFtTFVHblROaG9uSTU1VHFEcUlKc3B1MFhhS3pWNGdrWjlyNUtuVzRK?=
 =?utf-8?B?a25MVVFiVVZicDIwRU9pbmMwcS8xMnFkY2xicFdaYlFXVGdsbWFaWCtGYjdp?=
 =?utf-8?B?ajFEeU1MRjJiNElHSHpKVG01L0FVekE2YU1TV1k3b3ZlMmNuQklBbk8vMmt4?=
 =?utf-8?B?VGVSSFRVdUxSVHVIL2RJVUpQUnlIS0dOcmYwUG5OcjN6VVZLZFpTeU5GaTVt?=
 =?utf-8?B?MnI4Wmk4ckZ5WERQK1pvdXB4M2p2UUd1bk8xZVRVNEVsOHI4ZEpwaXNvejFn?=
 =?utf-8?B?b3BiTk5nN29aQWdyajZqSGpld3l4NmhxcE9uMzhEWGJvTDdsRXU0WWVMZEsy?=
 =?utf-8?B?RnM5azlXUWhOL2lTSHp5VzZUVEFqalBOKytLZDZtT0RtOHA5WDNjSm5jVFlR?=
 =?utf-8?B?ZXV3RzF6TGtMOTYrUE8yZU1zMmRqSW5BOWJUTC96L0pwVE5tMzdrUHJUdlZz?=
 =?utf-8?B?WFZIZlUwbmI5UE53UVdXY0R4UjNmTm9SWTJnTlR5SXFTUDNEbjBoUHlwaGRK?=
 =?utf-8?B?dU5CWDZDanVENzVVWkk5REs0SWgyZHE2bStHMzBhOU5UTWczV2x2RnJWajh2?=
 =?utf-8?B?ZndqaURoY2NuMmY4UTZIbHp3S29VNTBqNDlMVWVYSXE2YVEwWXRkOGRBMzdp?=
 =?utf-8?B?ZjczZ2RxTGtSN1dYQ3IxWWFiZEpsemR2cU1MUVkwS2U1U3R4SWpycHJBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tms2NkMzcjIwZFJxRmNVd1dxU2FLUkQrTWQ0TDFNNkxpQ0tDa0pzUmNQeW5E?=
 =?utf-8?B?eXQyVWdJcUdwOER1MmNkeDYvL0V1bTd1OG15amRpeHNqNEJBQzVBTXdmVXJh?=
 =?utf-8?B?ZURCVUQrejBhVzJIRzQ3aFNOUmlwanV2VHI1M1NSbGJmeG5uQ2NEMEQyYTRl?=
 =?utf-8?B?a1QyRm56clhNMHhjeW1IL0NPKzVOVGs1TWtHQzFGVGhFbDNnc2k3c01zK3JM?=
 =?utf-8?B?Nkp3MDB6OXV6Ym16dHJ5N2lZMk8zTVI0cUpLUHA1S2k2ZDkvRnNIR1RvTjFH?=
 =?utf-8?B?clJVYTQ2aFRiTGN4N2x5NXR3dmQ5NGt5a3hNaG8vNUZ6ZVMrR2dicjVxUDlT?=
 =?utf-8?B?Q3BYUHlUeWcvWFBna0dzZWEwSmt1d2dDQmVEQVJmZ1dRcUptQ0RHNmNYeWFj?=
 =?utf-8?B?Q296UkprYWJZY2RZQWF4ZmI4T1VNR3YyYnVmN3hYdmZMd3FnYVQ1OGFyYkNR?=
 =?utf-8?B?bndTaUlhd0hJRlY2WWFXT2poZUQyMjdHZ0dDeUZCaThPQzNFYkNVb2luNDVP?=
 =?utf-8?B?cFp3blcxSmY5TWMxNUwwUnYwQ1dWOVpuNUFZbUx4NEpXZm9xOWcyOEZBTjdn?=
 =?utf-8?B?cW1JZXRZMEJPQXRXNDdob0I5aFZWazdZaCt3RUFXbFViaFRSekRHZDZZS2lw?=
 =?utf-8?B?R1VCMlNiVXhBbllFRFNnbmQ1VTltQXd3eTA3R2JqYTlaVlVaKzMzVVZzOFU4?=
 =?utf-8?B?cU12SVhWRFJYOTJGNnEyRUtXZ0pRYTMyV2ZPdUh4UmFvZmxUYnM2UFVSWFJi?=
 =?utf-8?B?MC9pR2w5MGNhclFNd1NWR2VqSEYwY0hQV1dkbVhzRi9iUzdxdENtWmp5V2E0?=
 =?utf-8?B?RFBYcFo2UkZKeDkyYStJQWw4dTF4a3NCSk5icEVYQ2FtNEd1RWZXVlNlRTJC?=
 =?utf-8?B?dEo5ZFFIdjFleDNiSkgzamYwTmdVZHFxK0VBWkFzejZHdHBvOVFiN3JsOFlX?=
 =?utf-8?B?MDZYWjNuV2FuK3M5Z2lnVVptcWY4ZTB4UU0rN09zZGlPR3QrUWtGeWhQOGNp?=
 =?utf-8?B?OE9oOUR2b251RXJGN0ZWZ2VFVVBFS05pbDZLdERocUMvemJRcGlMKzZPRFZY?=
 =?utf-8?B?LzYwTUpyNm44S1ZoOW9USUluelVzYWRvZ3dnbmFxendHcjdSYkNFeXBwQ0Z4?=
 =?utf-8?B?S28ybFh0VWtTS21DWUR6NE5QWHIyNFFZbHNvQmRZVVZJTmtHUFlVRnVjRGhV?=
 =?utf-8?B?U0RyeS9KcGFOWVZUYnI0dHdjUXhEdDFZNzg3RU9NYkxYK1dSUmg4dzNXSURK?=
 =?utf-8?B?eFFZMWRzNUJ1WjRQcjk1OUE5aEwxUWpmblBYNEhaTDhNay80aW5oMnlBSWx3?=
 =?utf-8?B?Mmg5dTRoSlA1eEFOZnZSWlVWYUJFeDVRd3dMdzQ3OXFha29pOWhJR2xybCtX?=
 =?utf-8?B?S1EyVkpPYzhKMXBtNEpHNkdkOXVDNjZ3L0RkMGNpM0lPZXlHdVkyOTFLaUJ6?=
 =?utf-8?B?cTJpcndZRytmNmI3UDlsMDM2Wlo5eUdzbDc2Q2JvdUZQZXFkSGxBQjhQdm4r?=
 =?utf-8?B?blFBa0dBMC9DL1NLak9ySFpuKzhvZ1hYblA1UkdUQXNwTlA5YUgrNkN3ZEUz?=
 =?utf-8?B?NC9hNVFvakNFYlN5OHplQmN6TlBnQktKdFpQVGtCWWlTYWtnZmVCSzZOaits?=
 =?utf-8?B?ZGVzcEVEWWtnaWJKODRyWkZJaDZML0Z3Z3Nwc0dVcHQ1V1d6MVhqSnJWN21n?=
 =?utf-8?B?VS9KejQ5VXI5T1UxUTM2bk14d1RrQVkrR3lwakhmOEtGR3d3TFozdllYOUxT?=
 =?utf-8?B?OVJiSVJzclBBZkprSldZZzFCSEhabnJROW41UDlyV2loNWl1UWxXL1Y4KzVM?=
 =?utf-8?B?ck1aOGtoTjRvYXV5OWlKQkhBUlFEbCtFTGlDUWtsbURjWUtDbnpSclAvUUFC?=
 =?utf-8?B?RS9XZXZjWnhNb2NvSXJQOFZkQXJRSTZtdmw4WTVrS1VyQmNsckI1MFMvOXc0?=
 =?utf-8?B?MllhZVYwNjFtcmZ4blVmN09McGtyazdQYk9zcWZDYmFwUXdWbmRMU01xTS9X?=
 =?utf-8?B?UE5OUDBjM3dHWEs2NHBlTWtITGpsbnFVd1lzdVJrdFN3TzdoQ1RFWWxXT0NV?=
 =?utf-8?B?Q3QxZ0ZSVDBudFhzcmJkQ3hhb0hodGlPWnhkWGluSXlEZ3pLMS81RHBKMWw3?=
 =?utf-8?Q?LtuXm5SJLX00ktWwhe0Rubt8u?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f63ab460-af87-40cc-cb04-08dc7f7e2175
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 01:24:48.3553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z+j1nqmp5/zfzLintZzw50WT+fGi+oDqJXfNH3LdTtpPbv/vLmRYO4VD17Wq+sc/ID3SXG1thfUTIeSC/Kl2LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7535
X-OriginatorOrg: intel.com

VG9waWNzIG1heSBpbmNsdWRlIGJ1dCBhcmUgbm90IGxpbWl0ZWQgdG8gdXBzdHJlYW0vZG93bnN0
cmVhbSBwcm9qZWN0IA0KcGxhbnMsIHN0YXR1cyB1cGRhdGVzLCBhbmQgdGVjaG5pY2FsIGRpc2N1
c3Npb25zLiBJdCdzIGFuIG9wZW4gb25saW5lIA0KbWVldGluZyB0aGF0IGFueW9uZSBjYW4gam9p
biBhbmQgYXNrIHF1ZXN0aW9ucy4NCg0KVGltZToNCldlZG5lc2RheSwgTWF5IDI5LCAyMDI0LCBV
VEMgNzowMCBBTQ0KUGFyaXMsIEZyYW5jZSBDRVNUIDk6MDAgQU0NCkNoaW5hIENTVCAzOjAwIFBN
DQoNCkpvaW4gWm9vbSBNZWV0aW5nIA0KaHR0cHM6Ly9pbnRlbC56b29tLnVzL2ovOTEyOTcyNzky
Njk/cHdkPVdtZHdTMHBET0RSTk1TOXRRazU0WTFkdmJGbHFVVDA5DQpPcg0KaHR0cHM6Ly9pbnRl
bC56b29tLnVzL3djL2pvaW4vOTEyOTcyNzkyNjk/d3BrPXdjcGs1MmE5Zjk2ZDk4OWU3ZTIwYjYy
OGMyYzM2ZTQ4YjY4ZQ0KDQpNZWV0aW5nIElEOiA5MTIgOTcyNyA5MjY5DQpQYXNzY29kZTogMzY3
NTI4DQoNCg0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQo=
