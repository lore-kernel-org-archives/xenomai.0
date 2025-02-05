Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F912116F3
	for <xenomai@lists.linux.dev>; Wed,  5 Feb 2025 05:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738732500; cv=fail; b=Uj+FYdPgRqsPeFmgGbx47cU87j9A9+WV5rNskEZmnj+KkJjI4h6/sROgRbumrYuIBQm3QC0gPbegis2qWuZIkaIFFBeO1aZjJHdQn0K4fVsuZR6z6zTI+wCh+ldJOk9hO5UC9NagdxcW9/SJGwFPB4fijf6cTk5pKMbpPDxVeJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738732500; c=relaxed/simple;
	bh=UBZwefJVZJHSi9v5saCjbXkmdWXklvV0g6t7Etqz1Gc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ww1pnHrzSRlOUuzwUtd3fp9TZtErt2rOb891SUy+G5JbWMDwHg5q/kFUMWjQASCo7fXRn17yX9cy3CS6efNTI5FZ4BwS6Ix6QRHj+uC5yy7pLp3yTp4IslwDkQqQn24WaszboHdbkfaL3vsVxK5aL9eT30GxykPU8ui4tAQXUZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JzWpyu8N; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JzWpyu8N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738732498; x=1770268498;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=UBZwefJVZJHSi9v5saCjbXkmdWXklvV0g6t7Etqz1Gc=;
  b=JzWpyu8NUtlsXqLMDUGTrk+nFT1KMuuSBDbklQqdiK7HXVMMckmjEcpO
   kNrcU5peGjxOKTsc6T587KOa/weHeq/KGkGiqQ6pI5nZZvBmI7UfoD4d+
   3zdXkn/LMMei228r3477ztp5eo1kFBeL8jEdODiMxamDWHLtJ3Lt5PTT5
   uKsJm0R+Xxr7EhlHTiKQhyJfTRS3ezO1DUyei3c4KDbN3/T/E+sYHyP3g
   eT3gqHr4+xsam04fSzbx2hrcCDccpVxcX5U141oK74zGtnuJbllH6kSrI
   qUWXUb38Vph/7gGi3tMbrtKb7qsdM1zIB8vrpYZsCx/McI1u/0UlZael5
   g==;
X-CSE-ConnectionGUID: //EbYotATIahnX6e75A1HA==
X-CSE-MsgGUID: KjU/9M03SlS3VlIBtiDPJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43034230"
X-IronPort-AV: E=Sophos;i="6.13,260,1732608000"; 
   d="scan'208";a="43034230"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 21:14:56 -0800
X-CSE-ConnectionGUID: cH9bVv0EQEeZBxYIvUwLtg==
X-CSE-MsgGUID: Q6xq/Ao0T1idltLw9MfUOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,260,1732608000"; 
   d="scan'208";a="141656420"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Feb 2025 21:14:56 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Feb 2025 21:14:56 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 4 Feb 2025 21:14:56 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Feb 2025 21:14:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fy9lFx3E/ARbkJsZ4lfdxQDyqiytI3Qlrs6RLPZqRAd9aHDtqLWTUX/HZ6RyHyCASGjUuWwqYQC+0kCWCgXUXoQ0jzZ9aZlNPpzhrsOgyrbqf5N73aTMilt2okP20m0K9/NczsZn25KAFue6B0EU52Me4fOpntpLbOeURCTXvR0Xtv616M9rJDK6wgkrYjTWDBoDp/I8Yl03G+bLHp1AcUO4a1AnK70pP8Pik4DlhRw3R3NXsNVUW8nQSHwGcl2SVhI0SqmGfUG/s1dkolCB0ZcT0xt+FJTSrH5l/0w+1Q9u1PMx6bN5VrUQYPHt5t+fWkFBizpX63jvGGkeRSADzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBZwefJVZJHSi9v5saCjbXkmdWXklvV0g6t7Etqz1Gc=;
 b=PN+YzNf8laSYD3f35xPkAIuqNUAPKX7+ByLIXiGYLUjjanx6rg1hpvGbYNDf35MpSohB2BkGow1tuav7Gb9tqzEoIy6S77E9d4khwsS3+qxyZfwjsUPa/yV1rHZ29kBPH0/vwSh2VK9NlmlTXXZJm/F8kunmVEZS+DSO1YgNCk7Rcg0mKMtKXrhFkTFidxlw57sFy5cyudrtgiORQ+aE+L/cdHTYZTabL9orlCT4nASUkgsGEpWHt8UT0t+cmeoY819MZulR9ERdDzazjSPwbVUK9Wx6ca9/RtleAtPa6XjoFWtqUqAIyuunbQXhYAR4cT24PE+z1ClypHcHohfPFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by CY5PR11MB6317.namprd11.prod.outlook.com (2603:10b6:930:3f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 05:14:48 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d%3]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 05:14:48 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday,  Feb.05, 2025, UTC
 7:30 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday,  Feb.05, 2025,
 UTC 7:30 AM
Thread-Index: AQHbd4zgGNozaybuvEO252c8gHRtXg==
Date: Wed, 5 Feb 2025 05:14:48 +0000
Message-ID: <PH7PR11MB74998618D1F5B701C8C07330F2F72@PH7PR11MB7499.namprd11.prod.outlook.com>
References: <PH7PR11MB7499F7DDE006A3A7291F61FAF27B2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749929DFFDCFE47376883636F2572@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749988D3E2C96C4F21DAEBE4F2212@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499C4BB71E159B3AB98D686F2332@PH7PR11MB7499.namprd11.prod.outlook.com>
 <DS0PR11MB7482613E8A9D78229EA71D07F2EC2@DS0PR11MB7482.namprd11.prod.outlook.com>
 <PH7PR11MB74993A52AA247D08069980E4F2F22@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499D816A0B79C85EF7CD712F2D62@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499161719AD2EC0D1651C48F2A42@PH7PR11MB7499.namprd11.prod.outlook.com>
 <DS0PR11MB7482106CBDA92B4A595D7363F2AA2@DS0PR11MB7482.namprd11.prod.outlook.com>
 <PH7PR11MB7499B238FF2BECBDD784752AF2B82@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749988D39A66B3EC8E9431E6F28E2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499BDD1032C1C09D4107EE7F29C2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499E15D2AD5555818A6E5C4F2462@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74993258CAA8CDDA598B287DF2542@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499E32BB1968236810DF6B3F25A2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74993347DB8F72364025EFEBF2282@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499E7C229D3943554AE31B6F23E2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74997A20364527E81370A33FF2122@PH7PR11MB7499.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB74997A20364527E81370A33FF2122@PH7PR11MB7499.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|CY5PR11MB6317:EE_
x-ms-office365-filtering-correlation-id: d58a6c36-dfe3-49bf-eac2-08dd45a402dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Zitlbjk3R0o4UjRvYkIzOE1CQklTYU1NaGZ6TFk0WkFrTkZHYmF6T2RQckZJ?=
 =?utf-8?B?OXNKeWJCV1lpZDhNU3pacEd1QTVkZUhXbEp5NytzVGt5QUl2WmJIRlkxclR3?=
 =?utf-8?B?Rkora053alpjaWE0cDFUSVRpZTRVdW9QYXdwYnJRTE5vQUZ6SU02UU41azFv?=
 =?utf-8?B?OWtmZTZvcHl1bUZWbitTK2kvWkU0R05HZzIzVXh4WHJrZ295UDVGam10bm5u?=
 =?utf-8?B?aWthTkFDSnh6czN2ZEtaYzBTRFpROE5pMEMra0ZZclh5ODkzT0RqbzdiWkx2?=
 =?utf-8?B?Y0lNbElQMHEvZlNPRFRGSWtUUTE1M0dQdEc5RlYzZm00WkFuSkQrVitsWlVD?=
 =?utf-8?B?ZUZNSGdXVVIwRFFuWWZmTlp3UWIyb25oblVJYjFueXFDKzNnQmR0QXUxVTR3?=
 =?utf-8?B?VDI0ZkkycE16b2V6SUZZK2J2eVVuN2w0R0hoOHFXOGJBZTROaElZenJxWGtV?=
 =?utf-8?B?bFN1Z3JXeXlnYkMrdFFENUpPa1NUU0t3ODhCMUw3Y1cwL0RmbGhKMm9jWVJQ?=
 =?utf-8?B?NWVGeWE0STcwc1EwREd0b2VmOVlxS2Z0a0tLVEIzUXdoYkVVV0szQW8vUlZH?=
 =?utf-8?B?T0Rhby9WdWtrbEh4RW5TNTcrSDZlUGdrZC85UXdxTGpkZGQ2L1FrMkxkOFJh?=
 =?utf-8?B?K1ljSEZ4TzhNdThjWEErUHcyZk1XL0Z6alN0VUtIeE5xTDBOQWpZWldHSVJn?=
 =?utf-8?B?UFNRUlJVN3hjZUdDUDYvQmovcENpaS9zUW0yMlF3ZzBYNWY2ZEl4NWVPVUVp?=
 =?utf-8?B?MmJUcUxCMnJDT1Z4cnZwajZ5ZFNqMFRkR1ZoMTI5TTZFdldPN3lXTzJoUDdk?=
 =?utf-8?B?b1FnSHZkTVQwTGhSZWFYTWl6YStiMjhRU3FCSTdURW5HSUZuaG5iblNDVHRO?=
 =?utf-8?B?elYzd1Nmb1VSemJpWGdsSEtLMnBFaEswQWFKei9CZVQyemRLMmJuaXNFMFc1?=
 =?utf-8?B?Ull2WFcvUEx6TzNOVnVRUUwwcitNRFYrVHhOVlpRdFl0cUpyVVA4Tm5XZWdW?=
 =?utf-8?B?Yjk2VTlBQ2FLVlNxeFRwTmhiM0xtRjlvTzlwUHJVcUV1SHM2TSt4RVhpN0Ex?=
 =?utf-8?B?b3lmQ1VMb3N5OE1QUFdNMGtsSjJiS3NrSHE5WmNia1B6ZXp1L0gvN2JMZW1p?=
 =?utf-8?B?em5HWFdReTIrNGVvNXZoTXdpajV0V1d3bmIyVEpwWlRmNXJOMXluYlJpNWZG?=
 =?utf-8?B?aHNWbXJOWnNwb01rSlFCQ3dnbUcyY3I3TWkrUGlMbmVadlh3OUxabGRiSlVU?=
 =?utf-8?B?djd2UGVlN3FXN0tSSitjSTBOL2kwRDhtQm8rSEFtbUR4NG5VSjNPNUR5dGx2?=
 =?utf-8?B?NEtocW9GM3VBajh6S2lsbjZXRjQ3OW9yckJRYXhnbmJpTW4vZGFDaXhZR09K?=
 =?utf-8?B?d3pORzhwcUlZNVRUWnZUYlNHdUdhVGFxUDNVMXBlb201NlpzNjc5MjFjSFk4?=
 =?utf-8?B?QVREc0ppblZDejZQVitEa2lQTDRaSFV0WmJVQU1vNThUV0lEaEdrbWpXdktJ?=
 =?utf-8?B?ZTBObE5OZWlQL0JLSW0vZ3ROMFk0Q1J3TThxZ0ZRZk5jaG1iakNtOVcvVm0v?=
 =?utf-8?B?NzJ5UHVIMXF2RG5oWk55OU1iby81R2d3YnNtQWxsSFk5TTRkQi9WcnNURlBP?=
 =?utf-8?B?amY3aWlHSjdFQjV1bThnSDhXYnBGSEM3VmJ1eUQ0dHRnUUY5V0YyRjdKSWl4?=
 =?utf-8?B?emdMMkNNSDdrMS83MUU1UHJYZ2dYeW1Db2E0dnc5SXpta1RTWEQ2ekJvQlVP?=
 =?utf-8?B?ckdIRm4ySEVobHhtY2RRaEFMcnVKdkpkZDc1N2xBRU9NcXAzV0pWa0N3ZnNm?=
 =?utf-8?B?c3VKNEtEUDVyaFVreDFzZGFtUWFpVFdKd0ZuRHBuSUpZQ0xoMG9kejFWSUhK?=
 =?utf-8?B?YjQyb3F3eEFleUJEUVBLNW9CMElROGR0NjRoZGpISkVvK0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVlKRTNuclJmRjVHNDIxVEdPZC9PQ0VjZWtQd0ZVYWZqRmUzYTgvOEs2aFFI?=
 =?utf-8?B?akdXbkFBNmt5RjdybnIrZU9XMU9GZjFjUDF4NlZ0Ri80OHlvZVJ2aWVzckt1?=
 =?utf-8?B?S01JT0Vwdy9VMUhjRUN2TWpzT0FuQzRUd1VsMzBhOTVkNHVFdjNvS21keGZT?=
 =?utf-8?B?eHFzcGZQWXRSL3hRb3dUQWpmTzNFM1FsRFJ4UEc0WWRxVVdKWGUwMkdVaE9w?=
 =?utf-8?B?MWxSMlY4ZlJJWWJ3VkJleUF4YkVJeFUyQWJCSnc4UThLV2JuU2dnZHFQUFJH?=
 =?utf-8?B?d01BbEZWM1BiTTgvTTFjd0J3anZHVmFidlVheEtBTnMzWHJGYk9yS3JmNkRt?=
 =?utf-8?B?K0VUOENYQVFGK0l1YlF1SkVMS1JsMm1KSlFKMGM0b0xWV1hQYytteWNlakJk?=
 =?utf-8?B?VTNTcEg4eldrcW9ld0J4bGVUdkc3ZUV1N2dkbjBYMnVyQ2IzWFJOSGpIeU5i?=
 =?utf-8?B?MGk4VEZSbmU3RjgrcUx6T3ptZEREd1dPU1F6dWRhZWhDZ2VKblFETTY4OFNU?=
 =?utf-8?B?WVR6dVNJNWkrVnk4Z21WUmJNb1FZTWhwZ2k0STRMckZyc3hoOVk4ZXFHZUVH?=
 =?utf-8?B?UDUrN3dzdTNkUWJad2ZBZ0ZqcFhjaXZOd0loZUEwMURya1NlbWlRVXlVZTR6?=
 =?utf-8?B?c0o1akcyTkZFazB6WHpXSlpJczEyTTlTdXNLSmtlQW1WWXZNVDhwZkRwRXky?=
 =?utf-8?B?M2tQRDV6TlZsRXZaY2dlKzdtRzVMaG9iZDg2STczQlZJVElqMW5Ra1FIcHhF?=
 =?utf-8?B?bC8rUklwVnBIbnd3WnRIOFJJbnVtZE11K3ovWUFyUXI0K1FZS1Q5cEttU0FY?=
 =?utf-8?B?ZjFySzNRckpzRGZNTVpKcTRpY0xXWHZNNTF3TEhPdHd1dVcvOUJ1RW84a3kv?=
 =?utf-8?B?ekNMQXBsQWZWNTZPdmd2UFhsVWFOK0NIWFQ0MTRKQlJjcnpBSGhjOGVzckdK?=
 =?utf-8?B?SERrMXZHcFZGN1FaOE84RFZDUjdleko5UHBuVVdpYU1hMW9ZZUdZVnBMT1Jp?=
 =?utf-8?B?eXRFaHNxTHdvYThNQ3NrOXlTUlZhZjVpNW85RFg0Y3NITTZsWUR4UWFSQWh6?=
 =?utf-8?B?T1NxU0plMGhuWVNFdSs1eWp3MlFRUDRWK1ZGYlZoVTJRSGsrMkFUU2Rrb01D?=
 =?utf-8?B?MW1ndnhyNXQ0dzFlQ2FlUHpYbURnQ3RuVFBrQzhTekV4UFBMRGRkSG5tNmw1?=
 =?utf-8?B?Z0k5dS9EdU41cXV4eHRoSTFUak1CeHV1WWJ3b0hWWEVyampsUUtYQkZGQVE3?=
 =?utf-8?B?RExRaEZ0aFdjd3JvKzh1c0NFNUNKSGl0RVRieTd1bUNQMEhwZTVjWkhaMkVp?=
 =?utf-8?B?dDJpVVEvZ0czNDZaRXk3REFFUmpGMVRNeG8vdlVSY1h0dytRdWEwdzl3OHVh?=
 =?utf-8?B?T3VER2dvWDc4SWIycGVQUXlyNGZYU0dzZTJTMll1UFR2dmVzeTZ4YVRBc3JB?=
 =?utf-8?B?dVc1M2F4OHA2d3o1LzhFSkliMVJteGRwUFV0Uy9Bc0VGV0dSay9PN3RiaDJk?=
 =?utf-8?B?U0lMUDRrMkVhU1BkVWkwQnNCUjd4WjdTSHdhNlAwaHJ1bEJpeVJsMWFmV2NC?=
 =?utf-8?B?Y3ArUnlpd3lEeUVrVkJEbnBJRmE1NHh3M3dTVVVVMkhaeHpwaFpGMm15RGVk?=
 =?utf-8?B?UHBTNGI3ODRCOTVac1V2eng4ZmQ3Q0tqcTFuektVMG1PS1FWT1E0MkpBY2xK?=
 =?utf-8?B?S2xTcE9LOGlHNmhKNlhKQ2kyZ0pFMDF4R05hNktlQ2FRMkkzOExYai81empB?=
 =?utf-8?B?VGNMQnYrcXVWT2E5K09UT2NjZTh2Z09FQVduR3JnT1ZzOU50UG5HcVNQVWxT?=
 =?utf-8?B?MDlpSk55S3V2T1c4b3EveW5zdHh4VVpwS1YyUDNTLzlRRU1lWFk3Rng4VWFy?=
 =?utf-8?B?cnZsTHFGTERWUHdoaG5DSWRpNHhOSUZ1QnR3WTJiNnlKK1lKL0lTLzRjWGRL?=
 =?utf-8?B?ZVJPa2NsTFF3YmsrUGlWSE5lanNEMjJIci94a2ozMU1VQ1ZyS203Q3JSN3hr?=
 =?utf-8?B?UmdmZFQ2K2hXNG1vL1h0UWljL3hPKzhuNCtJTGFxd3FjRFMrTnVEeVp6b3Vl?=
 =?utf-8?B?T1QrRXhOdFQ2RWs2czBUbi9Ib2V2NURBL25MS1NNVjg2YTU1VlI1NWlta0hL?=
 =?utf-8?Q?HnVTCYrzIWDNcW5eQGKvKsthn?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d58a6c36-dfe3-49bf-eac2-08dd45a402dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 05:14:48.1417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k6y6cvzJbkmteoIvFc5n9IHTqUEBGKwN/fGFJhPhNQovaiq5M/igpWTcWNrGvveIk6sqHEBWfVCzlX+TnjBJKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6317
X-OriginatorOrg: intel.com

DQpUb3BpY3MgbWF5IGluY2x1ZGUgYnV0IGFyZSBub3QgbGltaXRlZCB0byB1cHN0cmVhbS9kb3du
c3RyZWFtIHByb2plY3QgDQpwbGFucywgc3RhdHVzIHVwZGF0ZXMsIGFuZCB0ZWNobmljYWwgZGlz
Y3Vzc2lvbnMuIEl0J3MgYW4gb3BlbiBvbmxpbmUgDQptZWV0aW5nIHRoYXQgYW55b25lIGNhbiBq
b2luIGFuZCBhc2sgcXVlc3Rpb25zLg0KDQpUaW1lOg0KV2VkbmVzZGF5LCBGZWIuMDUsIDIwMjUs
IFVUQyA3OjMwIEFNDQpQYXJpcywgRnJhbmNlIENFU1QgODozMCBBTQ0KQ2hpbmEgQ1NUIDM6MzAg
UE0NCg0KSm9pbiBab29tIE1lZXRpbmcgDQpodHRwczovL2ludGVsLnpvb20udXMvai85MTI5NzI3
OTI2OT9wd2Q9V21kd1MwcERPRFJOTVM5dFFrNTRZMWR2YkZscVVUMDkNCk9yDQpodHRwczovL2lu
dGVsLnpvb20udXMvd2Mvam9pbi85MTI5NzI3OTI2OT93cGs9d2NwazUyYTlmOTZkOTg5ZTdlMjBi
NjI4YzJjMzZlNDhiNjhlDQoNCk1lZXRpbmcgSUQ6IDkxMiA5NzI3IDkyNjkNClBhc3Njb2RlOiAz
Njc1MjgNCg0KDQpSZWdhcmRzDQoNCkhvbmd6aGFuIENoZW4NCg==
