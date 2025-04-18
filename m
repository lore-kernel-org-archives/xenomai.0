Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E0E1CF8B
	for <xenomai@lists.linux.dev>; Fri, 18 Apr 2025 05:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744955521; cv=fail; b=gQ4eB2pyOjgXqLciDz/yCtj88O6RPUY6jrtoqfctyXOOWfUfCSdwY1BfUqkTZG58da91ZId2faWNDCkuUgs71vDv1ebHYuMFX4kT5Rw5+dQkKu9mcozCOlScBy7hqH7OBseeBtHdmwnXNnY1PgBu5U0YEJEwXJ8GObAeywjQq40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744955521; c=relaxed/simple;
	bh=WGzXN3BhcsVf9+X8m0SAo9XimhsbIEdRzuA1W8RFL/M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o4bBC/WUMYEEiliH0bKnMqYC26ncAM9uyP4oPw9pS/aGc2ljbyWVgr+fzW8ZyCHkHhucFxJoVgwK9uIsTMSHOgSzOoA2zFVFA1Ro6/zZXT0V+IErBUdXHf+gWY6YMgLDiCDufbAgLvNGulNhGfLHRPZ8jbmgrkZZZPP8fzYMsT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VonIsFX5; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VonIsFX5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744955519; x=1776491519;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WGzXN3BhcsVf9+X8m0SAo9XimhsbIEdRzuA1W8RFL/M=;
  b=VonIsFX5cf0m9gkiuQJj14zHfQcNN+IEs21PfDWpYEeWe8C/a6VQ2jGN
   9ikm6lItJ2+g8R8HtK7G90XQ9VbDhWrVECWdQgMaUEwojy7oMW/yv5ZIR
   C5RkRIG8TO3jKd3YYJYKPTP9/q2YjDYBgzMJnJyfdjKNAhLMlpSCW1tED
   NZd0RbCH4UpX/9TPvohmga9p/nEMZ8s3M6HRy7N0KtZZSGV13ibHplOX4
   MKR+I+tx85FoV6cvVE91ieOFsrkYm4dWExLqzRlAkODHAmjEAe06ErPCi
   SXNMnzcbRIqjKJf+1g7pKfqFX/MYwNE86yFXJRxA+mkOunHJtFUbqgqlO
   g==;
X-CSE-ConnectionGUID: MCterHfyQcyqtfrAaJUIFw==
X-CSE-MsgGUID: tZdYiUlfTZ+/JOLaPR/l/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="46500057"
X-IronPort-AV: E=Sophos;i="6.15,221,1739865600"; 
   d="scan'208";a="46500057"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 22:51:56 -0700
X-CSE-ConnectionGUID: 8YDsJgr3TP62xuVguU2/Og==
X-CSE-MsgGUID: QSUuf4WaTaiJlLqrmU+1Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,221,1739865600"; 
   d="scan'208";a="135126546"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 22:51:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 17 Apr 2025 22:51:55 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 17 Apr 2025 22:51:55 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 17 Apr 2025 22:51:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IsX9L938C/R8SVhcIT4ly52J7C9BXo/4AUaTRIOoQV5Nww2UlS8H3SeY/b0izuGz7XWxR2hThAcskY3pszc5iLlNtl3xUfI8yzdEODutxsJCmgvMVn2QbFY9jb+8IvwdScDXt3dEuRzyxeraU59zfLD2OFDYV0vEhDRKLj/6H7EJUEJmwhkKRjwv+Y/SVtTTSIlYjIqUzLRY759O5y3f77uNg/cSfAR9Ur1h3BHX4W9mGhruy0zRXKC7rVbrbuDD7eFUTm8pRxhxP/plhZMDgZTyWgrlEu3sRVjOYK3BBRPROImPPWFmgf/cXDKghbyfIIdRxRLX5I/TbtxRpsu+qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGzXN3BhcsVf9+X8m0SAo9XimhsbIEdRzuA1W8RFL/M=;
 b=pUYYgjCr8wRwS/ZFPM+cmEUPIl7MO5SETyPfZUTP4mHntPzvIyKCR7oac0AG8FW0x9vcP5RTY4sdnph61pzDWaYEQhIoCdRTLKMPAnHe+A+rZXSEVH0Mx4bD/u3xvpgmj0v05FC1Lfo47RIIkt220G0+ezEiUxgaG0Naugie2D7OvV4WCVl4KDpDWQkVQ2D2joE1Qt3XLS7OjOG6jjxhG4q1bawrpH1E4MqAruegOVtpEAoibJCBOLccP+7bGVvprG8ryC1nuqh8imyPuDqxyZTHBM2grwztYaMeEZaizmQfwP2CDgcPsVU8WVeQGLCvFWABqoyPzIQVvTB34N3TkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6513.namprd11.prod.outlook.com (2603:10b6:208:3a3::7)
 by SJ0PR11MB5199.namprd11.prod.outlook.com (2603:10b6:a03:2dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 05:51:52 +0000
Received: from IA1PR11MB6513.namprd11.prod.outlook.com
 ([fe80::8012:e01:4c01:d824]) by IA1PR11MB6513.namprd11.prod.outlook.com
 ([fe80::8012:e01:4c01:d824%4]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 05:51:52 +0000
From: "Qiao, Wei" <wei.qiao@intel.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "Bezdeka, Florian"
	<florian.bezdeka@siemens.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
CC: "Chen, Hongzhan" <hongzhan.chen@intel.com>, "Pirou, Florent"
	<florent.pirou@intel.com>
Subject: RE: Build error of kernel/xenomai/debug.c
Thread-Topic: Build error of kernel/xenomai/debug.c
Thread-Index: AduvcNIP6fYojmwUSlGjpzfO8h3ARwAA+zCAAACQPoAAK7b9gA==
Date: Fri, 18 Apr 2025 05:51:52 +0000
Message-ID: <IA1PR11MB6513A045F8ECB1186B65DA9A8CBF2@IA1PR11MB6513.namprd11.prod.outlook.com>
References: <IA1PR11MB6513EB0131E06C8CC865E8EF8CBC2@IA1PR11MB6513.namprd11.prod.outlook.com>
 <72c2c5cb18b635f1145c35b6592c661cf55aeb0f.camel@siemens.com>
 <370f022e-d5e3-46f1-a19f-5448afeebb61@siemens.com>
In-Reply-To: <370f022e-d5e3-46f1-a19f-5448afeebb61@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6513:EE_|SJ0PR11MB5199:EE_
x-ms-office365-filtering-correlation-id: fc324b63-1c6e-4bb6-3649-08dd7e3d1e3d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TmhDV2xTd0lqSlM5R2tjSlVIUTZZV2MyNEF3SG5yU1RZNmJWcldmM0djSWJY?=
 =?utf-8?B?QTJLNmVtWHBtVFY0WXFyd2NQeC9vVnJ2eXVZeVhLZEJHUy9EVFFocXV6Y1Fu?=
 =?utf-8?B?MkxBK1NLVzQyMldrRXBYSnMxejFWeHFKb3FBcmo2SmFwZWNmU0wybE5RWWkr?=
 =?utf-8?B?Zi9KejY5MlN3SlZHKzBFZzdsTzJ5NHBvUnNXUmdzcFYxZzcwcWhVUVkzY2dD?=
 =?utf-8?B?ZTlkekxOMktyRTIxQmVodUtIVGFWbTg1QVpNdCsvRExkdEI1S1RLQzd5M0xj?=
 =?utf-8?B?OUVwc2NnYzN5QXpqRyttN1BzSEVnbzU5bnI2cys1ODVqSG9sVE5Yc1lwdlc2?=
 =?utf-8?B?eXJIZnUvVkUvTGp5SmhoWEpqQ3B1QjFScVM0QzVzVmNGMmFZVzNEeUVrNXVR?=
 =?utf-8?B?ZUtucGQwMDBsVFI3K25UOVBHV1JRL29rSDE4RlhHeDdjWlZ3MGFzNGIyWkN1?=
 =?utf-8?B?Q2lUMVlIcEFTcjdHTm9KR2ZGd2pYZDdNRDlaV2xFd3FDYkZCMGVZQjRrNjg3?=
 =?utf-8?B?ZnVITWNYVGROV2ZFOXppdnpGaGQzNHdQUm1QZGhBd2FuU1NoR3BZMEVDeFY3?=
 =?utf-8?B?dzZvOFgra1l3ZDY0YnpCNFJGNlJhSzFsdFoxTmVrUzIvR0V1bEJPYnpUaHhz?=
 =?utf-8?B?UDVjbFYyTmNHajF5MStCVmpBZkhkaWs5Ym9IOEZnQW13NFZsdEtycFQ5bnlw?=
 =?utf-8?B?ME5vbis0ZUZGUGs5NWUvK3ZOcjNGTFp1S21ZUlY0azhVZkRaWXdZM2puTVpN?=
 =?utf-8?B?UTVidDQxeUpidVRsZklNNXZEK05oaXI3Qzg2Z0sycXlsczVvK1NwaExNanJi?=
 =?utf-8?B?ODI4MUcyUWtMVXVRbmlvQURmSTFLUlRPVjAwWjlkV29ISlZXSG9WeEttaXZG?=
 =?utf-8?B?cStWUXViRHdQeG9JMVU1bXRuV0lRckx4dXNBR1dWeXZ1THRzSFkwWjlLTHZM?=
 =?utf-8?B?YXFXK0R6TzBPNTJCc0JlaEJiaDhrUzZPOXpPaXQxNllVdTZKb1dQZE8rbEhv?=
 =?utf-8?B?Nm5JTllsaHRvYkxtSktHOWZwd1NtRE1RNWxyTUw5ZVpFL0F5bTdVVWlHd1Fa?=
 =?utf-8?B?aFl4cDFuWG83S1IrMnhkK1ZheVNCc3laYlJ3bUJWK3BweG5JTjRYczVlWUNo?=
 =?utf-8?B?U0lhbk43WWI1QUZxV3E1cHFSaS9CeHBHNGdSWk9DcWZTZmd2bEV5RnhLK01m?=
 =?utf-8?B?YU1ISTErcC9EL3AreEwyVnpzWGpsUGJmdkhadDUvSG01QWs0eDBzcE00RVU4?=
 =?utf-8?B?UURoajIySWhUYVBZNGU3QWp6dFlmOUMwd05OZHBrUkpxZXg3bTVJZDRSOVVG?=
 =?utf-8?B?bmlWcVhvU1MrNy9PUE9UeXRscy9qeFVuM1l5bEtGMWVrTk85OFVpeXVKajEr?=
 =?utf-8?B?VkxiWEhYbjhOYVB1R04rbHJpenVMUTAvQnc3OG9leEhTSlM2OTZUWlVSOWVj?=
 =?utf-8?B?SHYxU1BReCtCUzF0aE5LeGdUYWROb2hnclhDMVVhV1BqYVljMmtMeWRZS2Mw?=
 =?utf-8?B?NElua0ExbGw1R1VJaWxDSE9lbW9DM212NHhaZ0h0czk3MGxoMmpjMFZuUTZW?=
 =?utf-8?B?amc0ajNUVFVMNnl4Yld4VjBZaVFlODVob1JqWUZUWks5RldyWkl3YmhkeFNx?=
 =?utf-8?B?VU5yTE5tVjF4RUxRaHJrNjJ5VURIREo0QUZsREdEVWJTekMxN0Q0RmNEdUhM?=
 =?utf-8?B?Q0FBWmRRQnNXaW1GTGlESmdxTjZzenZhZlZod3IvL0MreldTVGdKa2I5Tmp1?=
 =?utf-8?B?ZWR3ZXZZTC9WZmQ1bHo2OGJNYlFFREVldjRiczBadi9WaTNzT2U3dGRrZDc1?=
 =?utf-8?B?Ti8wSjlvOXZvMWNKazdWNiszQjd6SUhIMXRSV0Q4bVpubFlLclMyM0tXWHZS?=
 =?utf-8?B?WFZEeEpNR2lBeXNXSE1kUXpQeHFVSGtscC8yeXR2c3hFbi9VdXpoV0NtSFJn?=
 =?utf-8?B?MTFkWW1YYmprZldwQUVjTUl5bW5OVUlraUFEK3hGWWNueEU2ZGsva2M4R1Y1?=
 =?utf-8?Q?Ec94X1LrPVvgGapfG58YiG0a4wWItY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6513.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUxPZmQ0cVNqK1VJb1RYMVR6RUxqUndZc09qaHJ3a0lwS0Zvam56RzVHeEhx?=
 =?utf-8?B?K0tyeEtLdzVDb3RNS2ZUN1B0NUQwc1pveXFYYVlHYlFqTGVmcWlVaGZYUzUw?=
 =?utf-8?B?N3NUVGoxNGlvUDNpWUhTdzI1bWR3TDZtQU5UNHFFbHdkSC9tSGVUaUdOOFo4?=
 =?utf-8?B?UGZXNUd3WHZDYWwrOHpMNlhrdEExUW5ZWUpvV0xDY1F1RDRMNU9FVlNzaDdl?=
 =?utf-8?B?SmswTEV6amRRZjhSenhBUE15ZjQwUUp2SzQ1ZVVDRTFYditMUTIyOHYvb0FK?=
 =?utf-8?B?L2NzUFc0aFJYR29tMXZoZGtqVVZKNEU3bkp6ZWtlYkxFZFdCQko1dUNhZ1dI?=
 =?utf-8?B?S1B4WmZyVnJsNlY3bG9wMXlLRWVEV0JUOVBqaWUvVnRCaW1RN2ppbmlIcDho?=
 =?utf-8?B?N0pYRk12c2pnZVdkaEI0bk52aWZybHYwekM3bHU3K1NTYzJNSmtOdmZQSW1o?=
 =?utf-8?B?cUZyZWRqbVB2SWpTNElTSlRyUWxETkNrK0tJV2dIUjZZWFQxUWRvbmxYTTUr?=
 =?utf-8?B?VDZLejJ1RzRWRllFQmNvYXJnRTBRUm9Ta3NEdGZ0ZnRrb1VBU0diYnU3RUsy?=
 =?utf-8?B?OXV1cnFXdHVTT1RNU1dLakoyUTNQUTVmY2dhaWc1L0FOMU4zZjhBQ2pvR2Yr?=
 =?utf-8?B?OWJsWVZqK3hiVFNlcGhjV0d3TG1hcW9oUFFnR0ZFcG55YnFCdlpuMFFrTzV6?=
 =?utf-8?B?VzZsS29iZ25YN1hkMmVyUFhtN0JvY01vY2h6QkFrQStBSUtFdTljQkluK0g4?=
 =?utf-8?B?M2hvTUhTZXF3aWlOYjJDV0QybjhYcFBrV211cTF5ZWU5YWMzSlJiekRaSUty?=
 =?utf-8?B?R3l0QzB0S2s3NXlUMC9FWGozdXBuZlFoU1RDMmFoa0J6MXlPMDhNWWV5eVpq?=
 =?utf-8?B?ZXN6VkNpaVUrUjZIOW5VVGpaU1JPUHBBSGZId1FjaVlOeTVJN1NldnVxQUlW?=
 =?utf-8?B?cXBvTFJpYXBKN1h1UEZ3SXdob20zQmRjaEJPZ2xYTGJDbTRoeERNbXJ5OTV3?=
 =?utf-8?B?UG9BZTRJaVpoWDY5bTRqTVVpQkdEM0huQkRtTmJlVCt3bW1OVjNYcTBNZmlG?=
 =?utf-8?B?U3VJQ1lLTVdBZnVHQUwwcWxtTE5kalJjSW9ETTR2VlVYLzhZRmFmK2dOMXNp?=
 =?utf-8?B?VTl5VkQ0cmo3SHd1K0FBckFyNVR4SnFZZXpLVGdkdXpkN1RHVlpCV2JKQ1FP?=
 =?utf-8?B?UmVaNFYxYmJ5R2ZBTFFGYVJuMjE0bjBtYTFrcWlaT0h6TGJ3U0xkblJGMDF0?=
 =?utf-8?B?ekxHQ3BnK1R0QThjVTZKY3AxMHc5MjdkcG1laXlJdVEzWFJkSWt5a243ZFBa?=
 =?utf-8?B?TUl4ZHovMU1OYVlOK0hNOGg1TFJOMXE5dDhxTFV4MVpkaTAraE4waTR5SFFL?=
 =?utf-8?B?cFhDbUZSZFQwMjl0djBOR2pTWjFlT2c0Z3Z4TTlEUy9CZjNrL2pmelNiVUxD?=
 =?utf-8?B?aW9pUUNtQ21OajJsS1Fid1hrWmlxampyNjRMRUxzd3QyY2pZNjBLQU5mdmR3?=
 =?utf-8?B?Nzh2SlRhc3dWeGNGVzhkeFRzSWVKYTRCdVNmN2ZJcHZjVEtJOER4dUQxWU1L?=
 =?utf-8?B?VFdXSkp4MFM1a2NKRlVIcnd5ZDdnZWU3VDVHaHFHcU5qakVrZGVQWEJZb29h?=
 =?utf-8?B?c2RzcFhVcHMxTE9RR2FsUjQzeVNob3ZpaGd5OE9mTkM3RGZ4b0ErVlJ1YUdX?=
 =?utf-8?B?OFRpUkxDbGpnNGlZV1gxM09ZMnJWTmdOeUkvaTRBMjFOSkhlbXpKL0NLbHp1?=
 =?utf-8?B?VmNCOVNrVHVvcnpSRU1EM2dOR1lWQ3ZBbzNJZ0tFN1V4RkFRU1piZ05MenZx?=
 =?utf-8?B?TW9zc1VRUFhvblZkeHQ4ZUl6SHJGRTZpOFY1N1lLNDExT1ZtN0c0ckdtam5v?=
 =?utf-8?B?cllzaGMwcll3WlVaT3B1L2JTYjF5V1BMWFhUQUpYbCttUEo3MWZvaXFBSzB2?=
 =?utf-8?B?M0dlUHg3TXg4R3ZCK0Z6R3h1VlMwRmZxbFh6WER2WWZHSnVncjd0NStVdGlh?=
 =?utf-8?B?UzRUTXQzZmxhVUJLa1JaUjJFaGRQM0lJeVB4UnFFaDFUa0QyMXZLV20rNXJV?=
 =?utf-8?B?UnBjOFY5OE1PUWxaeFl4cWJybGcrMmxkaUwwVm1PbGJWOWg5UTA1a2tjeGgw?=
 =?utf-8?Q?rzeBI7Zgt1Tk1SVN4S6NHVOG7?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fc324b63-1c6e-4bb6-3649-08dd7e3d1e3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2025 05:51:52.1549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nRyzcWscWhrQBpZMYWdsLvrpkmOeMgI0CHOw71Nizwcriz1WVEJHkO/MhiVS5Js5iuUbqJ4MShLGwSDb8AQnKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5199
X-OriginatorOrg: intel.com

VGVzdCBwYXNzLg0KVGhlIHN5c3RlbSBjYW4gYm9vdCB1cCBhbmQgd29yayB3ZWxsLg0KDQotLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogSmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVt
ZW5zLmNvbT4gDQpTZW50OiBUaHVyc2RheSwgQXByaWwgMTcsIDIwMjUgNDo1OSBQTQ0KVG86IEJl
emRla2EsIEZsb3JpYW4gPGZsb3JpYW4uYmV6ZGVrYUBzaWVtZW5zLmNvbT47IFFpYW8sIFdlaSA8
d2VpLnFpYW9AaW50ZWwuY29tPjsgeGVub21haUBsaXN0cy5saW51eC5kZXYNCkNjOiBDaGVuLCBI
b25nemhhbiA8aG9uZ3poYW4uY2hlbkBpbnRlbC5jb20+OyBQaXJvdSwgRmxvcmVudCA8ZmxvcmVu
dC5waXJvdUBpbnRlbC5jb20+DQpTdWJqZWN0OiBSZTogQnVpbGQgZXJyb3Igb2Yga2VybmVsL3hl
bm9tYWkvZGVidWcuYw0KDQpPbiAxNy4wNC4yNSAxMDo0MywgRmxvcmlhbiBCZXpkZWthIHdyb3Rl
Og0KPiBPbiBUaHUsIDIwMjUtMDQtMTcgYXQgMDg6MTUgKzAwMDAsIFFpYW8sIFdlaSB3cm90ZToN
Cj4+IEhpIEFsbCwNCj4+DQo+PiBJZiB3ZSBidWlsZCB0aGUga2VybmVsIGluIHVidW50dSAyNC4w
NCwgdGhlcmUgaXMgYnVpbGQgZXJyb3I6DQo+Pg0KPj4gZnJvbSBrZXJuZWwveGVub21haS9kZWJ1
Zy5jOjIzOg0KPj4gSW4gZnVuY3Rpb24gJ3N0cmNweScsDQo+PiAgICAgaW5saW5lZCBmcm9tICdo
YXNoX3N5bWJvbCcgYXQga2VybmVsL3hlbm9tYWkvZGVidWcuYzo5NDoyOg0KPj4gLi9pbmNsdWRl
L2xpbnV4L2ZvcnRpZnktc3RyaW5nLmg6Nzg3OjE3OiBlcnJvcjogY2FsbCB0byAnX193cml0ZV9v
dmVyZmxvdycgZGVjbGFyZWQgd2l0aCBhdHRyaWJ1dGUgZXJyb3I6IGRldGVjdGVkIHdyaXRlIGJl
eW9uZCBzaXplIG9mIG9iamVjdCAoMXN0IHBhcmFtZXRlcikNCj4+ICAgNzg3IHwgICAgICAgICAg
ICAgICAgIF9fd3JpdGVfb3ZlcmZsb3coKTsNCj4+ICAgICAgIHwgICAgICAgICAgICAgICAgIF5+
fn5+fn5+fn5+fn5+fn5+fg0KPj4NCj4+IFRoaXMgaXMgYmVjYXVzZSBuZXcgZ2NjIHZlcnNpb24g
aGFzIHN0cmljdGVyIEZPUlRJRllfU09VUkNFKCA9MyBpcyDigIxzdHJpY3RlcuKAjCB0aGFuID0y
KS4gUGxlYXNlIGhlbHAgdG8gZml4LCB0aGFua3MuDQo+IA0KPiBUaGF0IGlzIHRoZSBmbGV4aWJs
ZSBhcnJheSBzdG9yeS4uLg0KPiANCj4gWW91IGNvdWxkIHRyeSBzb21ldGhpbmcgbGlrZSBiZWxv
dyAoY29tcGxldGVseSB1bnRlc3RlZCkgYW5kIHJlcG9ydCANCj4gYmFjayBpZiBpdCB3b3JrczoN
Cj4gDQo+IGRpZmYgLS1naXQgYS9rZXJuZWwvY29iYWx0L2RlYnVnLmMgYi9rZXJuZWwvY29iYWx0
L2RlYnVnLmMgaW5kZXggDQo+IDI1YjE5NGMyNi4uZDA0OGRjNzU3IDEwMDY0NA0KPiAtLS0gYS9r
ZXJuZWwvY29iYWx0L2RlYnVnLmMNCj4gKysrIGIva2VybmVsL2NvYmFsdC9kZWJ1Zy5jDQo+IEBA
IC00Nyw3ICs0Nyw4IEBAIEVYUE9SVF9TWU1CT0xfR1BMKGNvYmFsdF9kZWJ1Z192ZnJvb3QpOw0K
PiAgDQo+ICBzdHJ1Y3QgaGFzaGVkX3N5bWJvbCB7DQo+ICAJc3RydWN0IGhhc2hlZF9zeW1ib2wg
Km5leHQ7DQo+IC0JY2hhciBzeW1ib2xbXTsNCj4gKwlzaXplX3Qgc2l6ZTsNCj4gKwljaGFyIHN5
bWJvbFtdIF9fY291bnRlZF9ieShzaXplKTsNCj4gIH07DQo+ICANCj4gIHN0YXRpYyBzdHJ1Y3Qg
aGFzaGVkX3N5bWJvbCAqc3ltYm9sX2poYXNoW1NZTUJPTF9IU0xPVFNdOyBAQCAtOTEsNiANCj4g
KzkyLDcgQEAgc3RhdGljIGNvbnN0IGNoYXIgKmhhc2hfc3ltYm9sKGNvbnN0IGNoYXIgKnN5bWJv
bCkNCj4gIAkJZ290byBvdXQ7DQo+ICAJfQ0KPiAgDQo+ICsJcC0+c2l6ZSA9IGxlbiArIDE7DQo+
ICAJc3RyY3B5KHAtPnN5bWJvbCwgc3ltYm9sKTsNCj4gIAlwLT5uZXh0ID0gKmg7DQo+ICAJKmgg
PSBwOw0KPiANCg0KQSBiaXQgb2Ygb3ZlcmtpbGwsIGdpdmVuIHRoYXQgYWxsb2NhdGlvbiBhbmQg
YWNjZXNzIG9mIGFjY29yZGluZyBzaXplIGhhcHBlbnMgd2l0aGluIHRoZSBzYW1lIGZ1bmN0aW9u
LiBObyBzbWFydGVyIHdheSB0byB0ZWxsIHRoZSBjb21waWxlciB0byBzdGF5IGF3YXkgaGVyZT8N
Cg0KSmFuDQoNCi0tDQpTaWVtZW5zIEFHLCBGb3VuZGF0aW9uYWwgVGVjaG5vbG9naWVzDQpMaW51
eCBFeHBlcnQgQ2VudGVyDQo=
