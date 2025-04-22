Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B110A223711
	for <xenomai@lists.linux.dev>; Tue, 22 Apr 2025 06:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745303737; cv=fail; b=nUc5n4c3zMIjyY06aNdgTZk3eLMLNg965vo/LnpRdv/TDvA4eKtWVPT1RoSQOmOFFfYriBejosASZ4Xgr5wjYnNCs30v8otN6+m33h+x2uzk9umNGGfxSgiwIEEbF3BKYAGBl9VL9WZFkak7Qn15RaVs2Pv9QB27Vdj8RRUW+3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745303737; c=relaxed/simple;
	bh=Btq9HUsKPTb6vuqKRr2ci4oAde1DFNjAbTVNHtRCleo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fmKZ8DYNvLG2mXKsobUjD7VGyMhXxcfHHzS/HXmGdHo/GvRb5Wn/OY8mGy3OwuVA33Vpn+PoBqWiXYWuphV8cVb3CFt8ssKKsXx4NwM0+A8OtTtD71ZWB9dHw8GQV3ZmsQRPZQOI//8XlVthQDFpQTCTiyvTNK6HbnEaqfM32oA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hpa5UvBx; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hpa5UvBx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745303735; x=1776839735;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Btq9HUsKPTb6vuqKRr2ci4oAde1DFNjAbTVNHtRCleo=;
  b=Hpa5UvBxfuuepH8qnbhuvNboJNDYq4/WqPF090dsb05nJ6QxlC84h0EG
   Ez6mad56O4equLGZi+5beyZOCiwi2xCDMXhtlfS0gZt6yy3IQGCk+Wbm8
   25Un3v9y5EopZM01h+bO7Su4KJB0YQ0dJahzJ6xN8XWkRloPDSGTqzske
   qsBll31V0J0/eq48/pbqXlF8UcTkcn5xTABQQUOSmaYsQAFlkUPxl47zx
   8P7tGs3OuWL0tQD4DqyOcN/vVwQuEYd0yJosv617/a9XjrU8fNhwIz4+d
   PwUSGhTvCgk2Qf6jJB4YhgVTrkfG3uQ7CnlTf4R9CQuR8+oTpdR//oFBf
   w==;
X-CSE-ConnectionGUID: 8g5HsDEBRH2mMM3MG83vzw==
X-CSE-MsgGUID: aVCjFH2/TNGafyho1oOCCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11410"; a="57510838"
X-IronPort-AV: E=Sophos;i="6.15,230,1739865600"; 
   d="scan'208";a="57510838"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 23:35:35 -0700
X-CSE-ConnectionGUID: iUgrabsgSSOQeVvMrFs1Rg==
X-CSE-MsgGUID: zXXV4sx2Q8eL0YGXxZzKUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,230,1739865600"; 
   d="scan'208";a="132465313"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 23:35:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 21 Apr 2025 23:35:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 21 Apr 2025 23:35:34 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 21 Apr 2025 23:35:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uXJt75HNobkg4OdGIpwbbpcKNmZP0wsYh92PYaWpWmJ19LOI1LwkNgztFGofnN8lgUsRbzwFC3YoLSvfIu9PoIz1qCorfAG+VOyMNcclRNdhMs3yVy905mPIAmm7TC9lfqNTydghl/2w1VT0dvAyvJm1yCiBoo40ehmnntMFUb+pDw09tRVrOCqKeHSb+P1ej8IR5Mdl1rJCixKBXWqDuWYs+JiPVvho6tpSjKbZYiNIUapm7+9c2AuVcLmGWnC6mdif5yRSwiWEzjS+z3BunDEEiPIhGUn8R80tKTimQVaLwP0IIoXEO/GAD/sz5kfWuNUWUkLqgyhJOvfq6beMXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Btq9HUsKPTb6vuqKRr2ci4oAde1DFNjAbTVNHtRCleo=;
 b=U/u9UNtMoc8g4dYT61DhDoxFsn0kKUhnFM7ZHpZJKeGts1+kRkFbkRkHYvgXB5Iq8CYCWAFnRPWBH43TSCT1PQB0nqnKauWOwtJSYbF7K2JgMfojPpNy418lsn5y43FVANabtc2ABhMkaSPeEi4XUcGOIJtHjL8XvrNxbGTgQp4YABWpvrIIIrsuO7k2B+ktCMhPrifRBPJpikCsEse1zGrgcYy0w9ROYmkMzwpIE6kBcHHrCHZ2bfg9Yu0bxc0kaFzSSk8SIDDMvxg7W2Q1LWqutSseFs98YA0GHlVHF6E+4akBRTSVZ5Hoo+S5LeNRZYWe4LdlEcSbG1YAglYVxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by LV2PR11MB6046.namprd11.prod.outlook.com (2603:10b6:408:17a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Tue, 22 Apr
 2025 06:35:30 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d%7]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 06:35:30 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "Bezdeka, Florian"
	<florian.bezdeka@siemens.com>, "Qiao, Wei" <wei.qiao@intel.com>,
	"xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
CC: "Pirou, Florent" <florent.pirou@intel.com>
Subject: RE: Build error of kernel/xenomai/debug.c
Thread-Topic: Build error of kernel/xenomai/debug.c
Thread-Index: AduvcNIP6fYojmwUSlGjpzfO8h3ARwAA+zCAAACQPoAAK7b9gACF9hAAAATet6AAFDpeAAAAzQoAACPNk6AABOjlAAAB+hMQ
Date: Tue, 22 Apr 2025 06:35:30 +0000
Message-ID: <PH7PR11MB74999B4F0A2CB106586CAF1FF2BB2@PH7PR11MB7499.namprd11.prod.outlook.com>
References: <IA1PR11MB6513EB0131E06C8CC865E8EF8CBC2@IA1PR11MB6513.namprd11.prod.outlook.com>
 <72c2c5cb18b635f1145c35b6592c661cf55aeb0f.camel@siemens.com>
 <370f022e-d5e3-46f1-a19f-5448afeebb61@siemens.com>
 <IA1PR11MB6513A045F8ECB1186B65DA9A8CBF2@IA1PR11MB6513.namprd11.prod.outlook.com>
 <4342e7e1-a7d4-431c-8fcc-f7731d3938d9@siemens.com>
 <IA1PR11MB6513FC978522428982B0A30A8CB82@IA1PR11MB6513.namprd11.prod.outlook.com>
 <4abe85c4-1457-4137-9e54-ea1a8aa534d4@siemens.com>
 <b1f7b09e-344c-4320-a02e-24ea498a518d@siemens.com>
 <PH7PR11MB7499E92A39A41DC530A0A6F9F2BB2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <afeb146f-169f-4ad1-813a-74f58d73b14c@siemens.com>
In-Reply-To: <afeb146f-169f-4ad1-813a-74f58d73b14c@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|LV2PR11MB6046:EE_
x-ms-office365-filtering-correlation-id: 40de0c71-0c82-4541-8654-08dd8167e04d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?R3RZRVJpMURMZDNmRmVCRkNhcWNHeEk5R2VONUxHdDRvVEhMdG1UMVg0VFZZ?=
 =?utf-8?B?YjN2VjdocEl5YXMxTlREWEtnb3gyWEdYYXM3dGNxdDduN0hjZVVUOGdzVmVV?=
 =?utf-8?B?UjBBT0VSMGF6Z3pBa2s4TVJBQ2dSNEo3WHY1azhPSWJVcjhmT3lBaWp2SzFF?=
 =?utf-8?B?YnoweTBZekpsOEhaMHV2TGZXN25mQUtNM3REamJReENSUkZIR051SW5NVUJh?=
 =?utf-8?B?MkNyVENhdkNrUUFZSkVaZlcrRkxUQTZiSTZaZnFrNXBaQjVUWVVTUVZVbEUz?=
 =?utf-8?B?Nnk4S1hhN0UvVFN1NCtGT05GTkxFL1RDMWZDdlpBbGdTS0h5UzNBcnpRQ1p4?=
 =?utf-8?B?U0g5TmpKM0FoRmxJM0lBZE54N0NlMnR4S0loUDVtNFNGbVlFZ0pZd21BcXpl?=
 =?utf-8?B?RVJVUldIL0ZzUWlUOXh1alZ1aUpVZjNjVU51TVhGSDFlSkFMNGdyTzhGL21J?=
 =?utf-8?B?SWRHVmp3RURFeDdWb3ZzUitVOE45RUJsdnpvcFZvdWVwQW5Yb1ZqcXZNQWdG?=
 =?utf-8?B?WmlSTzlXRldqZmlJUkppYTIvSlF2azY5KzBXT045WHpBbUpkTzJwWi9YSTNL?=
 =?utf-8?B?ZWNXeFNkRjRyaHlkY3YvSmZNYUpCTW9PcFZoRUgxUUFSV1Q3cDhLMHN6VW96?=
 =?utf-8?B?b0FiRnU1ekwwWk1OSXlqTEhyR2FRRXB5ZTJKZktHQWJ2RUFLM081bFQ0bVJz?=
 =?utf-8?B?L3c0b3IzL0c3Zm1GTTJQR21TNXhMSEdLakltdEhPMWhOSTF2Z29adlZNWWhr?=
 =?utf-8?B?S1pQR2ZrQ1JkYjF3eW5TRUtXVVF3TWJPWndzRWRTRUdwQkFlYlhjM1BUREpF?=
 =?utf-8?B?cnZhRFRyYU1rQU81QnNPcUdUR3J2RnBWMG85dXB4enhiMHp6c2pPMFBodm8y?=
 =?utf-8?B?SXIzVml2M3p5T2lvYVpQUWdpS3ZRaitKYWNNQllGZ2FYTHUrWGRPVndJZHN0?=
 =?utf-8?B?QmFhUndrY1FaRWVzVU1hR3hZWkFQYVAzaFExa2lGcjZ6YU5VbjFRNkx0ck5n?=
 =?utf-8?B?S2NEZkRUQThtb3RIbE5YcTBneTFvdFpMYWh6WUFWNHlDdjNyd3YzTVJQS2ZI?=
 =?utf-8?B?M1BMUDlvdlp3Z3FBQzJCYlhKekRWR05mS3d2c3pOeW9Rb3pVeEU1VXJtV213?=
 =?utf-8?B?bUV3ckVwakRudXV2M1ZOblNwVnRTYWFQWmY1UlJjYmdVaUhIbE1kVFFlYVg5?=
 =?utf-8?B?OFQzU1hSWDEwOTZFL3k3dkRTNFRCR3pUdWlPSFpoYjhiVC9xOWJrTCs2VnNO?=
 =?utf-8?B?bFIxR0tTZVpiaGoyMCt1eThmem90dmtPSEgwNExmbGVUTGljSit1ZkU1U1JO?=
 =?utf-8?B?RXppQXNUd3NGNUZCNmJ2SXpiNERRZlFqbUJyNXdhUE5sd0F0aDZqaEM2UHpY?=
 =?utf-8?B?R3M4TFhjRVlJWDNxT0FsTkc5LzBieGJNek44dDZxb1NwYzZWNzlicW5KYmRW?=
 =?utf-8?B?ckhrVW9FOWVudllLUnJ6cEFycUdCVVJaajBUb0lvUFRQektaVVhlNEZDaTZj?=
 =?utf-8?B?OXBnd3N5UXFHc2tmTXROTFl0YUxhK3NGeWxBQnp0aVB6RE0vd1EzcFRMT0FO?=
 =?utf-8?B?Q1c2VE1MK0FudU5RMFhaRVJ2UmlxVm03Mm9td1NuUHpDanJ0bGIwczdMUTB2?=
 =?utf-8?B?WERxOGdTb1crT3RzVUUyTkV2SFdYSDJFT0JIcU9HWTJaQS9VNm90M3FzYk1B?=
 =?utf-8?B?MUFZdEZPNlEyd1lzN2NQQTB2dmhCNmdJZUR2OGowWUZvTVM0ZkhpTVZDS3Uz?=
 =?utf-8?B?WkU2cHdTTDZDMnJLVHpUTll4ZWY4akwwVEFVaGhZWjkvREQrYTVVUTdmSERu?=
 =?utf-8?B?MCtLelJLOGY1NHk0WHJHMWozZUxYRG9HY3l5dHBmblNzaFdLYnBwMDd4Yk5w?=
 =?utf-8?B?dFhUaEY2QmVKWTdYYU9oc1NUQ3k3a0xsMUFHcnhMNUJTaUZkQWU0ZVZtZ2Rz?=
 =?utf-8?B?YUxjNUdaRGUzRi9zdkEzckZXUFFLdkpLeklyWDRNOWRNMHMvQVZoK0l5dzNR?=
 =?utf-8?Q?wViJEqYEejFO2pIgnDywApQ1p75R5g=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2JIRXVaSVMxaU1tWXJ3VFhmbjhKOU5DMUZNRHBIM05OYnVIZWdFOHZXMVk3?=
 =?utf-8?B?ZUx4WU0veGZKWmhhTUg0TjVQTHZ5TGcxQlpjZmp6bHJCUEhZNC8wdm9Cc0Yz?=
 =?utf-8?B?RFVleTdoaGVJZmFxMUpBbjhxdkp0elpIYmIxa0dnRUNqNWZWSlNVbVpzZkdX?=
 =?utf-8?B?MkJSak8wK2djODh4TDFObnpVbDhJcUxVNmo2dUlpOVZGejdGTDlFMXFEbHpE?=
 =?utf-8?B?d2YwakJ4R0Vtc0U2NFR2NjJVN1BIRHh1UlRDem91VCtxSGNaaE4vRmNrbmFI?=
 =?utf-8?B?bFIveC85M2tJcVlPbVQ4dUVRTFhCeHRISTQzSGlTMG9kRTlxOS8rdXg3Tis1?=
 =?utf-8?B?TWNYNlQ1S0d3Rmx4Y25FZEkycTNaeWlsWkpENjN3Yzc1a3dwSXB1amhNOG45?=
 =?utf-8?B?VUF6dUNjeEdMWmllVitUdmY4aE0zd2VFVUhpYXVoOWlQVU5jV09yMjY3NjRH?=
 =?utf-8?B?WGZJcDhqS3lsWTFwUFFmSCs3ZG1uVW95ejM1MlM4SGFzU2JMVEVxWitCNlgx?=
 =?utf-8?B?aHJhL09iUTgzZWh1dUJZMzJJVjdQZ3Z5dkVscVg2SXB1M08wSmJ3Y2lBODQ0?=
 =?utf-8?B?aTRnYmk0aUVlSzZOSmcyN3lkM2JRY1d5eU9USUNXSW5vTU1xZXdJdndsc21X?=
 =?utf-8?B?ZXZ3enMrdUtkTUxESDhpYVhJdDRmLzg4N2R0cmtvbW5qQVVCcnVyeVQxR2FQ?=
 =?utf-8?B?bXNHdEpKN2tYSy94SWtNWmxGdjJTYmhtZDdmZEhPRDFqdXQ4SThKdDhsWEFH?=
 =?utf-8?B?Z3BNdEVEK2lBNlFRSlloYTlrQzBTeXpVcFBrN3R3ZDBHbHBid2JiZkhjcjUw?=
 =?utf-8?B?ay9zdWRURnNhRy91MTNQa0MxbkladHFVQ2Vmb3lXWUViY1JScjB3YTA5RHJE?=
 =?utf-8?B?WWt4dy9HaTZVMDQvT2NTT3pWVUc1eW5XS3FCSERKRm05a3hLT05ZUmllam04?=
 =?utf-8?B?bTQ0T29URHNFR3haRVBKcC9yWTZscVZCTkU1VzI2bHAwRzBTbUlwU0h6V2l4?=
 =?utf-8?B?U0x3SmxiNFNrQzBCdEF0bDJ0VVhRRE1QNkJCRnRtWWgyZjBIRFRmbXZCUDl2?=
 =?utf-8?B?ekZUZlVWVFpXakZCVkdnQmtDTkJDd3dpVWlGTStrczgzOHJpZG02OWpnTUJJ?=
 =?utf-8?B?TzhOd3F4ZDRrQ0UrV0tnLzFDbk9zdEJkOUsrZjJrRkUxY1BKZHErdTZYaUtE?=
 =?utf-8?B?RTcyanprdjduVEp0c2l3Yk9iT2lpaDNBcDBIVHovUkNaaHM3a1pBQk45RXll?=
 =?utf-8?B?bm52RDN0QzVQcElYZ1NkNGhiQ0l5QjdsOTRLK2Z2dVA3dVpldktOY0tld1RJ?=
 =?utf-8?B?RTI2bHBZaGFkSzB0dWFWQXVsQm1pM0xqN09rZFBSc0NmV2owa09zSkhKeGxX?=
 =?utf-8?B?TVNCK2s2M0t0WXhXRmUxZW9vSDM2cXFqTXlkdnhvZnNmaDNsOEM4L2x6eS9I?=
 =?utf-8?B?TlF3ekpHb0UyQ2pmMGhQQmptd25SOG1PSTFkYU10dDNnNFNWcXhULzdId2w3?=
 =?utf-8?B?YU9vNCs2c25leDVEYXJEZm51dFNMSXFZWHN3UlJkSi9aaU5pblpVOS81cEJE?=
 =?utf-8?B?L0RJNDRhVkE2SVhYL241N1R2TER3SEdGcm8wL1dWUDNsekZDS05IbGFYMTV0?=
 =?utf-8?B?MWkxaFZxazg1S21adTcrSHUzODIzYlNTRC9OREd1K1NZWGYxNlBXVUdLY3c4?=
 =?utf-8?B?UGNaSDA0ZWNHUFJsL2FUWUZFOGZsZjNTL1pkYW42Q1YyUERGRHFBeHVmWFFX?=
 =?utf-8?B?L0Vaa1M5Ykl5RXQzUVhzQnJubVRUczRLKzRRTkxiUWs1eTduWjlpUkZsVW4x?=
 =?utf-8?B?ZGxFMUl1RjByVGhGNGlQNGtPWUlUdWk3RkRuTUJLRlhHUU9WVHBzamloYjAx?=
 =?utf-8?B?WFFIczhiTGtubkVORHdFN0o0MnkwNW82aWFMK3poNy9XcVFobnVDQjc2ZHdx?=
 =?utf-8?B?ejV2SUQzbHhCQUtwclJwdkVxYXI3K1ZCMWZIQlNEWEpET2NKem5FTmYyYzIr?=
 =?utf-8?B?RzhvZ3hCOVpmS2lUR2RhM2FCNlJDbmtHS2xFbkhMTzJ2YW9wQk9FN05nWjdz?=
 =?utf-8?B?Zm1QWHhQSGc1VFVaUk1Ec2xkNGJXaFNjc3RPOXNLRlpUVERhNUlzbUdtSmxO?=
 =?utf-8?Q?srf/AHpRqYCetime46kevUcI1?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 40de0c71-0c82-4541-8654-08dd8167e04d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 06:35:30.0800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: srBAuZ2ulsrxhepJKFzAFjBrVU9ZppoDLVNFeNzq2r5NtwLlDboLUFvFavoAVE+J357es4akVupn8fLk76kXsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6046
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEphbiBLaXN6a2EgPGphbi5r
aXN6a2FAc2llbWVucy5jb20+DQo+U2VudDogVHVlc2RheSwgQXByaWwgMjIsIDIwMjUgMTozNCBQ
TQ0KPlRvOiBDaGVuLCBIb25nemhhbiA8aG9uZ3poYW4uY2hlbkBpbnRlbC5jb20+OyBCZXpkZWth
LCBGbG9yaWFuDQo+PGZsb3JpYW4uYmV6ZGVrYUBzaWVtZW5zLmNvbT47IFFpYW8sIFdlaSA8d2Vp
LnFpYW9AaW50ZWwuY29tPjsNCj54ZW5vbWFpQGxpc3RzLmxpbnV4LmRldg0KPkNjOiBQaXJvdSwg
RmxvcmVudCA8ZmxvcmVudC5waXJvdUBpbnRlbC5jb20+DQo+U3ViamVjdDogUmU6IEJ1aWxkIGVy
cm9yIG9mIGtlcm5lbC94ZW5vbWFpL2RlYnVnLmMNCj4NCj5PbiAyMi4wNC4yNSAwNToxNiwgQ2hl
biwgSG9uZ3poYW4gd3JvdGU6DQo+Pg0KPj4NCj4+PiBwYXJhbWV0ZXIpDQo+Pj4+Pj4+PiAgIDc4
NyB8ICAgICAgICAgICAgICAgICBfX3dyaXRlX292ZXJmbG93KCk7DQo+Pj4+Pj4+PiAgICAgICB8
ICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn4NCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBU
aGlzIGlzIGJlY2F1c2UgbmV3IGdjYyB2ZXJzaW9uIGhhcyBzdHJpY3RlciBGT1JUSUZZX1NPVVJD
RSggPTMgaXMNCj4+PiDigIxzdHJpY3RlcuKAjCB0aGFuID0yKS4gUGxlYXNlIGhlbHAgdG8gZml4
LCB0aGFua3MuDQo+Pj4+Pj4+DQo+Pj4+Pj4+IFRoYXQgaXMgdGhlIGZsZXhpYmxlIGFycmF5IHN0
b3J5Li4uDQo+Pj4+Pj4+DQo+Pj4+Pj4+IFlvdSBjb3VsZCB0cnkgc29tZXRoaW5nIGxpa2UgYmVs
b3cgKGNvbXBsZXRlbHkgdW50ZXN0ZWQpIGFuZCByZXBvcnQNCj4+Pj4+Pj4gYmFjayBpZiBpdCB3
b3JrczoNCj4+Pj4+Pj4NCj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9jb2JhbHQvZGVidWcu
YyBiL2tlcm5lbC9jb2JhbHQvZGVidWcuYyBpbmRleA0KPj4+Pj4+PiAyNWIxOTRjMjYuLmQwNDhk
Yzc1NyAxMDA2NDQNCj4+Pj4+Pj4gLS0tIGEva2VybmVsL2NvYmFsdC9kZWJ1Zy5jDQo+Pj4+Pj4+
ICsrKyBiL2tlcm5lbC9jb2JhbHQvZGVidWcuYw0KPj4+Pj4+PiBAQCAtNDcsNyArNDcsOCBAQCBF
WFBPUlRfU1lNQk9MX0dQTChjb2JhbHRfZGVidWdfdmZyb290KTsNCj4+Pj4+Pj4NCj4+Pj4+Pj4g
IHN0cnVjdCBoYXNoZWRfc3ltYm9sIHsNCj4+Pj4+Pj4gIAlzdHJ1Y3QgaGFzaGVkX3N5bWJvbCAq
bmV4dDsNCj4+Pj4+Pj4gLQljaGFyIHN5bWJvbFtdOw0KPj4NCj4+IENhbiB3ZSB0cnkgbWV0aG9k
ICJERUNMQVJFX0ZMRVhfQVJSQVkoY2hhciwgc3ltYm9sKTsiIGludHJvZHVjZWQgaW4NCj5odHRw
czovL2RvY3Mua2VybmVsLm9yZy9wcm9jZXNzL2RlcHJlY2F0ZWQuaHRtbCN6ZXJvLWxlbmd0aC1h
bmQtb25lLQ0KPmVsZW1lbnQtYXJyYXlzID8NCj4+DQo+DQo+RG9jdW1lbnRhdGlvbi9wcm9jZXNz
L2RlcHJlY2F0ZWQucnN0Og0KPg0KPiJUaGVyZSBhcmUgdHdvIHNwZWNpYWwgY2FzZXMgb2YgcmVw
bGFjZW1lbnQgd2hlcmUgdGhlDQo+REVDTEFSRV9GTEVYX0FSUkFZKCkgaGVscGVyIG5lZWRzIHRv
IGJlIHVzZWQuIFsuLi5dIFRob3NlIGNhc2VzIGFyZSB3aGVuDQo+dGhlIGZsZXhpYmxlIGFycmF5
IGlzIGVpdGhlciBhbG9uZSBpbiBhIHN0cnVjdCBvciBpcyBwYXJ0IG9mIGEgdW5pb24uIg0KPg0K
Pk1heWJlIGRvIGEgbWVtY3B5IHVzaW5nIGZsZXhfYXJyYXlfc2l6ZSwgaW5zdGVhZCBvZiBzdHJj
cHk/DQoNCkkgZG8gbm90IGtub3cgaWYgbXkgdW5kZXJzdGFuZGluZyBpcyBjb3JyZWN0IGFjY29y
ZGluZyB0byB0aGVzZSBjb21tZW50cyIgKiBJbiBvcmRlciB0byBoYXZlIGEgZmxleGlibGUgYXJy
YXkgbWVtYmVyIGluIGEgdW5pb24gb3IgYWxvbmUgaW4gYQ0KICogc3RydWN0LCBpdCBuZWVkcyB0
byBiZSB3cmFwcGVkIGluIGFuIGFub255bW91cyBzdHJ1Y3Qgd2l0aCBhdCBsZWFzdCAxDQogKiBu
YW1lZCBtZW1iZXIsIGJ1dCB0aGF0IG1lbWJlciBjYW4gYmUgZW1wdHkuDQogKiIgaW4gaW5jbHVk
ZS9saW51eC9zdGRkZWYuaCBidXQgTG9vayBsaWtlcyB0aGVyZSBpcyBub3QgYWxvbmUgbWVtYmVy
IG9mIGltcGxlbWVudGF0aW9uIGZvciBERUNMQVJFX0ZMRVhfQVJSQVkgb25lIGluIGFyY2gvYXJt
NjQvaW5jbHVkZS9hc20va3ZtX2hvc3QuaCBhbmQgZnMvYmNhY2hlZnMvc3Vidm9sdW1lX3R5cGVz
LmguDQoNClJlZ2FyZHMNCg0KSG9uZ3poYW4gQ2hlbg0KDQo+DQo+SmFuDQo+DQo+LS0NCj5TaWVt
ZW5zIEFHLCBGb3VuZGF0aW9uYWwgVGVjaG5vbG9naWVzDQo+TGludXggRXhwZXJ0IENlbnRlcg0K
