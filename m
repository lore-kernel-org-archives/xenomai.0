Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EB815E90
	for <xenomai@lists.linux.dev>; Tue, 22 Apr 2025 03:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745291802; cv=fail; b=Iic3WzxtscV8C0g0MHYFspG+AscEMjMgQbGya0ICYVn64o2IIazTB32tWTQEIN9bRZybysJKvvcw38vn0Ob8oH/j+UIq1Jsado3p5vb4XhywW9xQwDTm4s5WuIhgCkMPLguHSGgFEi1HtTMOsB4yCrBFQLIoSsP0OlThN0bWiVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745291802; c=relaxed/simple;
	bh=jOs1rIJ/TM2fuf+wMvBPb4uttqZZxhruWynuHrk5qUE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pzkRc9iuIZryM/LF4uo+70dCzDOiehUXaNk7x7ceqbxeRLE//Kr0Q8ktUKWyI5jxzDDsYyuij1E7hfmpDxtSG3iY0MZ5cXfPrcZrO67KvAyLBasXOQ8Y7Pdp4gjhE19sIQeVWSRzJ0xtNVzcMsdut/Gm9Bn9TBxWl3zmQpy4F68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=azUPvSAe; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="azUPvSAe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745291800; x=1776827800;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jOs1rIJ/TM2fuf+wMvBPb4uttqZZxhruWynuHrk5qUE=;
  b=azUPvSAe3K2r2ybNcml8vqRfXNFWMc9wUkKb4BJeJQDcPCbe/YTQCuT+
   nP80QYdudoly9ucebjBpsVv2y63EwZFxgghVtbGPvJSIqD640LN7IJS6v
   5VUHHSTptVatoG9wxzVcOZf/S1U+4mIgc++i9q8JuhcTOAfWl1eDgR6hy
   FzAwUV53pr2LboGd3Nk/XXZTyVhvZuNGRSf5O3K1yq4K8ZFq68wft+qDE
   42jpicXcikAAVSxOK3YARDpbHrulKGbHZqTHpXtouT64vcLdgZko3Wk+c
   t+l4IPdLOLEq4JPoxQ97uKC3UftE+XZBJxdPTHtrsCzqAk6U1YM/zsmFy
   Q==;
X-CSE-ConnectionGUID: Lv50KBZ2Q7qFYM0zJb4o9w==
X-CSE-MsgGUID: y7gFTNs+Siyf8c8vg/Gu5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11410"; a="46844573"
X-IronPort-AV: E=Sophos;i="6.15,229,1739865600"; 
   d="scan'208";a="46844573"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 20:16:39 -0700
X-CSE-ConnectionGUID: NgT4YXDmT+m10wxYeI8SuA==
X-CSE-MsgGUID: 28uWv0Q3RgeqDwSlZV74lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,229,1739865600"; 
   d="scan'208";a="131796140"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 20:16:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 21 Apr 2025 20:16:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 21 Apr 2025 20:16:39 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 21 Apr 2025 20:16:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O7ImtSdvWnHwmFWrQ3MafDo7WqVLpds4J78Qc1dX2tR0jJ+Q6jAtcXtPcwwWz/QNzct4tTgXHslsmmIbEavE4xPM7b4RQ961LchB5hLOFOQFJoU2rSjp+UscOH3H5F9WEzc/iNv/jfbZyas//HScE7vckx/J7Tn9FH1yq72BdxAQrIsk/I8xxyV1cAFzZ3uGbXn1YBRRT6T7S5UsQ08MJ55BIBVpX1hnhlxUsw7oRZOuPSOmLPDWFlAoavGd0RtHA+yClpOwhk4ucXVPYmPuzds4JXpTPVsRpun/dsB+uspWCCTjG9Dyaf0aDgT0HE+tLySHfO1G1VmuhDfWS5jK9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOs1rIJ/TM2fuf+wMvBPb4uttqZZxhruWynuHrk5qUE=;
 b=wRmK+C5d6Inj7IlblqxT5e/RCm1pWbDnQLGW8r6NSSNSWWxhSOLKysE2DNSjzOdlYp3vMQBxVu4SZmWUsLAYgBiwzbx2rvjBVzTPpDnXZT05AnCpuvr6LDUCLL+8wij5MMFMpBCPT5cP/whe673wHCZTj/0k+Z2DEUyx39Ht1mo7CJoT+ei0D5l0HbI8zF6JscfBScJnTXxIfHZVDFVhKtTuvH0sAzzAVqKw1CAs3Bx3EJav6tPBg++s4ar3CS/9P5e/ePbClWe3fuA/zKatrNtTp5/QxhoSWMtp1Rny2ZYvjkf96U5YHs12Lg3TF3GdDgAVKQmYlFOMmVRTSG2Bpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by IA1PR11MB7754.namprd11.prod.outlook.com (2603:10b6:208:421::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Tue, 22 Apr
 2025 03:16:18 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d%7]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 03:16:18 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>, "Qiao, Wei"
	<wei.qiao@intel.com>, "Kiszka, Jan" <jan.kiszka@siemens.com>,
	"xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
CC: "Pirou, Florent" <florent.pirou@intel.com>
Subject: RE: Build error of kernel/xenomai/debug.c
Thread-Topic: Build error of kernel/xenomai/debug.c
Thread-Index: AduvcNIP6fYojmwUSlGjpzfO8h3ARwAA+zCAAACQPoAAK7b9gACF9hAAAATet6AAFDpeAAAAzQoAACPNk6A=
Date: Tue, 22 Apr 2025 03:16:18 +0000
Message-ID: <PH7PR11MB7499E92A39A41DC530A0A6F9F2BB2@PH7PR11MB7499.namprd11.prod.outlook.com>
References: <IA1PR11MB6513EB0131E06C8CC865E8EF8CBC2@IA1PR11MB6513.namprd11.prod.outlook.com>
 <72c2c5cb18b635f1145c35b6592c661cf55aeb0f.camel@siemens.com>
 <370f022e-d5e3-46f1-a19f-5448afeebb61@siemens.com>
 <IA1PR11MB6513A045F8ECB1186B65DA9A8CBF2@IA1PR11MB6513.namprd11.prod.outlook.com>
 <4342e7e1-a7d4-431c-8fcc-f7731d3938d9@siemens.com>
 <IA1PR11MB6513FC978522428982B0A30A8CB82@IA1PR11MB6513.namprd11.prod.outlook.com>
 <4abe85c4-1457-4137-9e54-ea1a8aa534d4@siemens.com>
 <b1f7b09e-344c-4320-a02e-24ea498a518d@siemens.com>
In-Reply-To: <b1f7b09e-344c-4320-a02e-24ea498a518d@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|IA1PR11MB7754:EE_
x-ms-office365-filtering-correlation-id: 00b8d219-8930-4530-ab1e-08dd814c0c87
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eUswUHNmNDVmQktYNlNOdHViWHlwVjBWMG1XdGhNYnBYc2ZiSEtTbmdScjZp?=
 =?utf-8?B?S0xkVXp1alBMZUVHTVoreVAxd0NEVTVxK2xzWWtnL0F0a0tJTE5ZM3FnZHVJ?=
 =?utf-8?B?b0Jud2I3SWljemdqZS9KMTg5ZmNtaGNIZWZXRWl0OG1qWmpBeWx1YkRseUMr?=
 =?utf-8?B?cVJITlkveVliZVphcnZCVld0RjlLd1UvQm5BdlI5bXZSUWRuV0NsNVdWWFdD?=
 =?utf-8?B?SzZ4dDlZR2JlUWhJeVEyT1hjWmZCeXZNenVsSUt4VHYzZFZvOVdWMFpxS3dS?=
 =?utf-8?B?MEFKTmgvbVZVL2dxOGVBRzNTeGdobjZ4Nk9LQWNmcHhiYTRkdi8zNGY5N2N2?=
 =?utf-8?B?aVVwb2tmUDViQ2JMMDkvbkVxbWNVdkxFQW13bnFSMStCcTRpdUppTlV1RTUw?=
 =?utf-8?B?SE9XaE9JM3BXWTRrTGcxSS8yQjBUMWpLemNpLzBDWDFVMVBzelJJaWdTRUp4?=
 =?utf-8?B?Tnp2TWlwY2NnQ3RtMEg1ZDQyMFhYS2Z1YmZNVUFrMm9vaTBsT1FzYlRLRWJS?=
 =?utf-8?B?bGJsWkxxbEhrWTlZMjBKb0F2MGMvQUlzNXQwRFd4U1JHQkl3ZFdQTGFNdERY?=
 =?utf-8?B?UDgvNXhodjlwdnNuMXE4ajVEVGwyMG53aEFoUDNFdDU4M2k3YWFHNnBjU2Fo?=
 =?utf-8?B?QkNlT1RYSGx0SGtBV0d1WnZGRVYwcjFJOEJGNXYvR3hzaUdpRVJmWkYrNFla?=
 =?utf-8?B?Mlk3bFlaZlc0WVJsOWQwbS9WSHhZQ09sVTdEd09hQVVUUTBJbytVSEg0cXZr?=
 =?utf-8?B?UUFyODRsUjIyR0pxSnZBZzFNakZPUlVtVVpIT2ZWSTkyZjJJWlgxY09hS213?=
 =?utf-8?B?SEdwaFRXZmVBRTgrU05veVlmTkt2aVNadWc3ZDdZclphZ0dITS9ZbXJDZnh2?=
 =?utf-8?B?d2pIMjJhY2tNUStpeEtFdU42Sjg2ZmJIcjV5bWpwcXdRMGRxQmREZTVrVkx5?=
 =?utf-8?B?SWdDRWFFMzV5VTRLMTRNZXIvMEFJZkQvSFlJSzFlOXBzL0UwcUE1anFxZTVv?=
 =?utf-8?B?a1Jzdk9KSmVteWdmM1JGeS8vOGJrSk5mbXZBNWxVbXpjRjYxa2taK0dOVHBD?=
 =?utf-8?B?TVRmYnRPcUdUdmt5Y3VEdkV1dmRtZ29PajZpQUVYT1Bub3lOcnlQVUlBdlNC?=
 =?utf-8?B?dktoOGdxelljeWM4VWtkSjF5VmhiR1VvOHJ2azNFQjBZMCtsU1V6ZFBoLzRt?=
 =?utf-8?B?TkhpazNLbEp1UnBNMkdMT0xXVXN3ZGoySldmQkxkNittbmI4NmlBQ01Fbk9u?=
 =?utf-8?B?UHhUeWFPOHVKZEhkVXNaS01CMGRMQVNVcmRSWXVOS2FSSHRXQ2lNM1g0TUZL?=
 =?utf-8?B?SlRTdWFiU3pEZGJuSHJWWlppOU9NaGp4WVlMZHVyem9sSTYzNGhjSmRiMEZO?=
 =?utf-8?B?LzM3QjNkbjZlN0pnazBodzhqdmdoSXJRY1NBWHJPUFdla0xUWW1ZQ2djNFpt?=
 =?utf-8?B?dzJ5T1ZCV3FjTXVOWFNndkc0SEFyK0VXNjFZSFRuUk5zclgvWTQ4S0xBMCs5?=
 =?utf-8?B?K3FuMmNNMnZaa0l6WS94YkMySnpxRnB1SlplZURLUk5mRmxSZDdPbmpsZTFu?=
 =?utf-8?B?aWMxNktKZVZxMkVJM0IrVklKTmE2K0Nzd3UrUkVsbmpHN3hOWHJoeFRSd3cr?=
 =?utf-8?B?cDNTMU1Id0Q1SkM5RHI3OUk5WThOQ1dKcEZqUEVZdUtNOUZhZ05LUlZsNVls?=
 =?utf-8?B?RHZpcW1CN0hYTzBCVVVVbEJUcjlCcVJnVWNJYjV4Ry9rbWNEaExmYWN4UmVL?=
 =?utf-8?B?VlFpNmpzYzc5YkUrazF0dE1MdFc2c2ZLZU1GQTQzV3N1cURkemhXNUFUWlUv?=
 =?utf-8?B?WWVheW9JSGQ5SWRMb01CejVscXNYRVFXaHZnd1o1ZXg1V1hOSDNlRXd2UHpj?=
 =?utf-8?B?VTNtTnFNbkpXU09xY1ZPeDloM2UzWkxyV05wa3J3ekJEQ0pWQzlHOGoyQWNU?=
 =?utf-8?B?cUhmSjduby9pYzFWTTdWQmdHTS9wWDRDQzY4SSs3ZExxOHppaDR4T21VZVBJ?=
 =?utf-8?Q?y91JHVoZKfh/NxHJl0lrLM9bohVqO4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjQ3ZHlBQStwSkRyK3JUSklUN1A0S1hrQmJSVVlRMW5qYWxHOFhlUGxpUDRQ?=
 =?utf-8?B?N2lxVU9ZVDlyTFBKWjZXbkVNWGd6aXdTK1Y4ZkhrNllKelFQdFE3ZE5hQ2lw?=
 =?utf-8?B?MTZ0em9iNHB5V1hzMEtSSkRCL1lOaHlvMnNPVFN0RE1EU2hzcWdmSTJZS1FI?=
 =?utf-8?B?MGR0empkVUl5elNreEdRby9NMUsyQkZUbGpzeUcyZEMvdlNsSVg0RVBuUSt5?=
 =?utf-8?B?eG54TFpLTkExdldDUlAxL2kvbURiNmp4Z053NzJhYUM0RTYyRmpHYkRaRVhv?=
 =?utf-8?B?ZllLK0N0THlwUGJlcnI3aU84ZUVjUEx3QzFQeGQzSExmZ3Q5a0IzU2t2eExG?=
 =?utf-8?B?UW5IdjVJSXBkbitQN014SGVJQUVOSUhPL1BCdTNUekdOTXpNc3VCWTNjdjlZ?=
 =?utf-8?B?b3RDRWsvdngxRDRWcXRyK1F4U053WS8zU2thNlRXSGVJaDZrVFRiOThob0tU?=
 =?utf-8?B?Tk9qeW85eEovWFkyZXlhQ2p5cVlqV0ViTVhhUXNUd3AxN1cvQysvZjRFaFY4?=
 =?utf-8?B?UVhIYzRCQVZYOGUzUEdLM2I5T08wVENYQjFpa3dpTDRiRmFCWkJpTlJSK1pP?=
 =?utf-8?B?eTRObFNDWnU3a1lHdVFqa2VlcDM4eDZHRDMySVdPQlgyTmVRcmVuZUpFMmNU?=
 =?utf-8?B?STR0R3cyb2xaNUs4QS92RjRROUR0aHk2Vk9nbkJ0UTNPL1VDN0hMajVqUU1S?=
 =?utf-8?B?TWp0Sm5ya1l4WXZ5OGZtT3dhQjBaSEordmdTM1F5M2oxSitDdXdSaXNSMGFT?=
 =?utf-8?B?SXA3eVhWS1B6a3RxRndoQllTSThVMmoyRjlDVE9zR0JDaFFDN1IxQStyOWsy?=
 =?utf-8?B?M1JUcGtINW5PL053bUVoWGxKcGlvNmhYQzdhMkx0c2kwSjlCcnV0MWRlOFJK?=
 =?utf-8?B?eVNQTjRkVGhaVWtnTWJPZXR4QXg0cHplNlhaNUtzdTA3ZmVXK1RpZ0YxMjhs?=
 =?utf-8?B?VDlGaHhRUjFHYmJJTGZxQnFUd0c3UWhudngrUUJKU3pMbXJMOUo3UUNuT05Z?=
 =?utf-8?B?MDlhQWZONWhFb3dTT09SUURweVI5c2VDVm10QTIraDZtZUMvcHEvNDlDRHFJ?=
 =?utf-8?B?aDZTK2RsejRCZU9CM0NBRWV2ME1mdVVlVDNmNTBVQ0FJVWU4RlRIcFBCNnNv?=
 =?utf-8?B?ZUxyb3pBdllNZWEvaDdkSVhjWjZ2YmU3djB4RTE4dXR0VWpYZmFtK0JTdGw2?=
 =?utf-8?B?bE1scTA5cFFkUTJDVWJOdXhidmd1cGdLd1RSSFQ4NEkrUml4TjRERTNjUGNU?=
 =?utf-8?B?bkN1eXFUdnJCdEVBdnNnOGUzQjZNaXhiUThRWnpkeGRtN052b1l0MU1Ed0pr?=
 =?utf-8?B?Y0RMbXRrcTFXQUNZeUFnQ1ExdmZERGNMQjNFZjAxRHRKQitrZnFybDNRbXhj?=
 =?utf-8?B?SkFHdWFZNHNjeHhJbkJiajNOcG1JU1BYKzlDZDlZVUNHRVZtakFJNlJqZ0Rs?=
 =?utf-8?B?KzFDajRna0JwRjFJck14dmZ3TzZ1dnBBNFdMWGE5QnIvUWk2amowcnZTWE9r?=
 =?utf-8?B?Wk9tQVpwZjlnY0c1QUVYK3FUcWtSbm1tN1FIV0VrME1EL3dTOWM3SE1GM2VH?=
 =?utf-8?B?QlRqUkZhYVJSaXdXc2o2WVhFSVpld1RyS1czWUVJNDNSSXErdXhpcDgxOFN5?=
 =?utf-8?B?VW1DcXdaNk53aEVnNHNtMDEvcXo4Nndrb2xCWHJFWnMxRUxzZ3M2c25xWVow?=
 =?utf-8?B?cVdwOHBUMTNuUHVLTjF3VEQ4Z3I2amt5MlNlQlJuSzFmRWxVb3Q1S1V5ZTV4?=
 =?utf-8?B?SXZ3WnBlWTBuRThZeGVtQ3E3VlNEVDFpRnlhTFBvZHk5aUJsVXI4OG5iZnhD?=
 =?utf-8?B?eVZWbzVadUxRZXh2bGg0Vzg0OXhDemozbXhGUW1YN0g4NUsreks5ZE9abEZk?=
 =?utf-8?B?a24rZ2ZZVEs2Q3cwNHEvSFMwYzI3RnJvSk5la1pXYkF5OXhFeDJKU0VxZ2Z1?=
 =?utf-8?B?QXNWbjVTV29RTks1ZWx4aktMODVUSkNhWVA0OU5FL293Q3pDYU91VjdwNjRG?=
 =?utf-8?B?dDd5Zi82RFV0elU2b0VuWGVsZVR0WWZHTmpnQmxkVHhkYnE0bmJ4ZE5QMDRl?=
 =?utf-8?B?aDdrNEsxZXNpVml2OTdHRDJjT1o4K0ptNUxFUFdPci9XZzhnUnZpQXV4ME5T?=
 =?utf-8?Q?3qQKNTN+Kr22iuJ78KxgLt/+0?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b8d219-8930-4530-ab1e-08dd814c0c87
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 03:16:18.3811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NrnhPTru7KOcdnD9WPaVRTpbjVDpGWZJ/EZZ7pBPae6ltdyo5F2ytCAhEXqjdI0jJ4XNV8LlM9F7iLmjBHT86Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7754
X-OriginatorOrg: intel.com

DQoNCj5wYXJhbWV0ZXIpDQo+Pj4+Pj4gICA3ODcgfCAgICAgICAgICAgICAgICAgX193cml0ZV9v
dmVyZmxvdygpOw0KPj4+Pj4+ICAgICAgIHwgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+
fn5+fg0KPj4+Pj4+DQo+Pj4+Pj4gVGhpcyBpcyBiZWNhdXNlIG5ldyBnY2MgdmVyc2lvbiBoYXMg
c3RyaWN0ZXIgRk9SVElGWV9TT1VSQ0UoID0zIGlzDQo+4oCMc3RyaWN0ZXLigIwgdGhhbiA9Miku
IFBsZWFzZSBoZWxwIHRvIGZpeCwgdGhhbmtzLg0KPj4+Pj4NCj4+Pj4+IFRoYXQgaXMgdGhlIGZs
ZXhpYmxlIGFycmF5IHN0b3J5Li4uDQo+Pj4+Pg0KPj4+Pj4gWW91IGNvdWxkIHRyeSBzb21ldGhp
bmcgbGlrZSBiZWxvdyAoY29tcGxldGVseSB1bnRlc3RlZCkgYW5kIHJlcG9ydA0KPj4+Pj4gYmFj
ayBpZiBpdCB3b3JrczoNCj4+Pj4+DQo+Pj4+PiBkaWZmIC0tZ2l0IGEva2VybmVsL2NvYmFsdC9k
ZWJ1Zy5jIGIva2VybmVsL2NvYmFsdC9kZWJ1Zy5jIGluZGV4DQo+Pj4+PiAyNWIxOTRjMjYuLmQw
NDhkYzc1NyAxMDA2NDQNCj4+Pj4+IC0tLSBhL2tlcm5lbC9jb2JhbHQvZGVidWcuYw0KPj4+Pj4g
KysrIGIva2VybmVsL2NvYmFsdC9kZWJ1Zy5jDQo+Pj4+PiBAQCAtNDcsNyArNDcsOCBAQCBFWFBP
UlRfU1lNQk9MX0dQTChjb2JhbHRfZGVidWdfdmZyb290KTsNCj4+Pj4+DQo+Pj4+PiAgc3RydWN0
IGhhc2hlZF9zeW1ib2wgew0KPj4+Pj4gIAlzdHJ1Y3QgaGFzaGVkX3N5bWJvbCAqbmV4dDsNCj4+
Pj4+IC0JY2hhciBzeW1ib2xbXTsNCg0KQ2FuIHdlIHRyeSBtZXRob2QgIkRFQ0xBUkVfRkxFWF9B
UlJBWShjaGFyLCBzeW1ib2wpOyIgaW50cm9kdWNlZCBpbiBodHRwczovL2RvY3Mua2VybmVsLm9y
Zy9wcm9jZXNzL2RlcHJlY2F0ZWQuaHRtbCN6ZXJvLWxlbmd0aC1hbmQtb25lLWVsZW1lbnQtYXJy
YXlzID8NCg0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQoNCj4+Pj4+ICsJc2l6ZV90IHNpemU7
DQo+Pj4+PiArCWNoYXIgc3ltYm9sW10gX19jb3VudGVkX2J5KHNpemUpOw0KPj4+Pj4gIH07DQo+
Pj4+Pg0K
