Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E988F40
	for <xenomai@lists.linux.dev>; Thu,  8 Aug 2024 02:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723083372; cv=fail; b=l4ijvXus+eFL9atKvt16XL3Tpoy7ZbkLbQCmoevw+44zE+ncRiZ8icidjgRbciho48Q8nxM8aq/8Tgm3aPvnLRmWgQ550yTOTG8qsBSwB/fBKTaPfQx3nrlmxWOkkPFRaBMrqcJCPJ3nJUcfuDPAQuK9Ip0LND4B59v4Cmbe4Xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723083372; c=relaxed/simple;
	bh=6CvF51vQYC3UYmEDwvvVidG04SmQyKuIK9Z2WB4VKIU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BVU2nujjSTKTz2iOdPjnMII4ZxxsaCSc3D/Bs6sbOvel82l4l4unEz2ekHpRfX/n5h0qiLkYrV/IJ3HIIxwj44R+pbcJkXZsEaZDfxfU8Hyqw0uvWqCCKOfbunqiaJ8ReEtZSI0XIE2yr/avBpA95nZ5J2sRj9OE24qQQg/W/+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RE1EQ14n; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RE1EQ14n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723083371; x=1754619371;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=6CvF51vQYC3UYmEDwvvVidG04SmQyKuIK9Z2WB4VKIU=;
  b=RE1EQ14nJ/+/cTMC6o6Kkozgy4ajjtFzr8M26tpmM1FmdJCsp2SM6q6S
   VY9mUoWo0jX/Q7GKZ9AI/uDZO2R5mr+bGdIrHN0laT02JADp1szBcPu3m
   /QS7bnp+JMhcAfm4WsNLvJAD6txwmYGsJ5l4PjJ7db0XD3th4jkdrwEaI
   NjUk9Ic0ZmqSVVh2bglA6y6v30Yl9ZjY6ubleXV7PjnLZ4wOpYCczrP20
   7MebxCKC4yyhSVT0BFQQCY0Exhm+dNKc34EoEhS2yEeKslab3LAbR9Jif
   mOxWsdP2JmYSZiOylyY51jhbtRTPl7BMOE/pbVbp+hexjopBn5DVQpAQM
   A==;
X-CSE-ConnectionGUID: 2CLdMwezTjuq6knVf7FiFg==
X-CSE-MsgGUID: iOMN0fpcSeitaM7F8kHsvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="31763281"
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="31763281"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 19:16:10 -0700
X-CSE-ConnectionGUID: 3Nyi+hMXSXG19TmhWj/tTg==
X-CSE-MsgGUID: Id5PP8BLSiu0s+CVhJL5IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="57291912"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Aug 2024 19:16:10 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 7 Aug 2024 19:16:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 7 Aug 2024 19:16:09 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 7 Aug 2024 19:16:09 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 7 Aug 2024 19:16:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G64bXvpssX2UhiSurrOUH1eWJZxYInQA9QjqXT7CDLfWOrXbt5qVw/U4LNcjrNUb4XOHD7Rek0dAZLgI5qeCklWxIVYHOD9iPTwREQBXBiymaLtuoRjV9S7bWB5IYPktpznl5+w5WxZuPYCnnhn1kkMQUgyEfk4P+vx5OcMbwISntLtx7FAqGyrNlH3SneqzRlhDYNtILXRmGEZKkbiDod+xqlVMjNUviPfJEHbwKo05oTbCoh3IhjBFFFgL8afhf/yy6Jdu8syOcsU5O79sYSRx2Bmbu02QdfrdtsQxJppW/ZDWmPt8jRZcZLkXioVRo4TOXSSUnvNdPddlyvTVcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6CvF51vQYC3UYmEDwvvVidG04SmQyKuIK9Z2WB4VKIU=;
 b=lTKtpOmyK5EYhEtDQ97Xit/6aGsJtOMLtcZhkVnOex5/JbVszrWxVg4ptV9ZdtAcOSjnxD1b2eaQIQPR3yz0RZ5EbT1ouKpKLV9OOGsFE0W3j7TOdDsF5imSsAz/zZBEhZMPWrGp4jHEkiIhnzJS6MsHr0kctV7jn4/PK9hFk1NRSFhk4WYGt6mcRnm0RAjHYaa/Wv7UcNjYxqzKiGBYeLRlFz2cI8zVjW9tn78n+Rg/FIBmCiSQGqXLn9DDfm4seh+zhsN4ValqodpzJck4bFUEwg7U7Hjm962nFQLLrCSX83b7kaKANu5V8A4APyBp9YCJ0x+p1ETrPJlMH7nsxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by DM6PR11MB4610.namprd11.prod.outlook.com (2603:10b6:5:2ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Thu, 8 Aug
 2024 02:16:07 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::ba6:b81e:aa33:bd5d%6]) with mapi id 15.20.7807.026; Thu, 8 Aug 2024
 02:16:07 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Xenomai Community Call Minutes - Aug 7, 2024
Thread-Topic: Xenomai Community Call Minutes - Aug 7, 2024
Thread-Index: AQHa6TjtcvxcH/jMxEiEmiDqKCGqXg==
Date: Thu, 8 Aug 2024 02:16:06 +0000
Message-ID: <PH7PR11MB7499FD09B7B037D05288165EF2B92@PH7PR11MB7499.namprd11.prod.outlook.com>
References: <PH7PR11MB7499F7DDE006A3A7291F61FAF27B2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749929DFFDCFE47376883636F2572@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499F4FFFC62E15096DFF8D3F2562@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749910600BAF97BCB41DC3D3F2202@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74999307830ABE8C6E622DB9F2F22@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74999CE443EE8E36CEC314FAF2F32@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74992D53E248664E6D075779F2D72@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499B96C3A6A82AEE69DC40FF2A42@PH7PR11MB7499.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB7499B96C3A6A82AEE69DC40FF2A42@PH7PR11MB7499.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|DM6PR11MB4610:EE_
x-ms-office365-filtering-correlation-id: 0b0ee7b6-2251-4713-567e-08dcb7500fd4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VUp4ZEVWVzBkN1VxZ1luSFdsdkxCUk1pVk5uQWk4UGt1cXV0cmtnZGZyRVpt?=
 =?utf-8?B?RE9YUWZ4VURvQjZEa21qeFFJT21hWFh2djFjbjRhYjc5bjhkS0NGeVFqWnRU?=
 =?utf-8?B?RTdiNHF5aHJuNFBILzZNVy9URUswSFFFMlRpbm02UG5Qa08vbERQOWZ2Mm9K?=
 =?utf-8?B?RnJHNzI5Q1FxY01VMXBoUncxbDUxdDNuQ2ZuZjR2RWJSaXUvaWZVbnlqVndW?=
 =?utf-8?B?UG11Rk9saS9HaFlOR2tralR0WHErdXFMQmR6MFRtRU00bDVpdHdaN0RiTmlJ?=
 =?utf-8?B?YjZpUUxJM2E4TFYzQTd5YWcwWHBodzVYcmQvekJ1VHNORkdnU3Z1cmM0UzBs?=
 =?utf-8?B?dlZiVzN3Q1U5bFkzVmxaUW5PRGp1bGhPYVc5b3ZKZXZkbWYvQU9OUmMvZStR?=
 =?utf-8?B?aWtYbkdPQTViZEYrQVp4alI0T0ZMTWtTWmt1eUtxTmhab0lYYzV5MHJMOEtD?=
 =?utf-8?B?dGR1b1pBTjFyblUvK0FtN0ZFVFFlc05lZDY1RXFydFY1WUFWdnRFa05mOVZw?=
 =?utf-8?B?ZjN6QWdsZ2FzdjFHMk9YRG1nczUrUDFFVE1wNnc3eUxaRXFLL2JZRmlueDgv?=
 =?utf-8?B?aXBFeFdKK3VybXBURmhiQ2prR3pVQmVoclk1R2pPRDFjU3czYkhSL2psVnhE?=
 =?utf-8?B?N0s0MGN4SnlPYktydHVGVmRNQTExR0taN0lBRld4TGUzbkcxMWl0WUZqNUd4?=
 =?utf-8?B?alo4QUI0QTEzdk10c2NodTBla0gra2kydzBmODF0QkRjS3R2dVBkdEhaREt6?=
 =?utf-8?B?eWVqMHpiK1NLcTVZbVh3blNkRDBmRHlQdmZTdElady81dzZ1SlR1QkVSM2lD?=
 =?utf-8?B?b01mRlZ2RUlZVVd4TXJETTFhMG96UGxyTHFSeWNsaTM3dFY1WmxXcU1JNGx3?=
 =?utf-8?B?aFhCVTY0cFJHZDVrNGtnVllVUW91MjNWSGNyZllpZ1NESCtodEpGdkNEa25m?=
 =?utf-8?B?OUNTMVFiS2pCOUFQNFRWWFJJYWNscFFWK1Y2RGU2dU1PNlZBYzdTUFdhYnRG?=
 =?utf-8?B?UGJ4VmNlQzVJblB2WHd2dUZUemJMNHlnU01XZEE5WThQRmNJN0hiQTRYT01J?=
 =?utf-8?B?WHZuUk9LZXg0TFJOT2NvYS9tMWk1aDVpV2diNXVhemI0dUhvTzZBWjJJdnFl?=
 =?utf-8?B?Yi9jd0ttazlZd1Q3Z05xVHp5ZW81cVhxMVRWaGVsMENqUFY5U1V2SE1YdjZz?=
 =?utf-8?B?SW5XaGd3WS9HeUJOMytUV1VYa1c4QlQrM2orbjI3YXZOMEdERi96eWVOc1NE?=
 =?utf-8?B?eXlwYkV2OGNBU1VwS29FdjJvQmduSnR6RzA1aGdRMU9mT25qL3ZIK21QR00z?=
 =?utf-8?B?ZzBDNDRSUU9CTElDYXpXS0VyZFU5NFVpZDhxYUdGaHNKcXc2WDc1akZRKzVP?=
 =?utf-8?B?QldQZlkrcFpwRXNSaFl6c0t3WG9ZYUJFT3I0SGw3THV6RWwyQ1IycURNNUll?=
 =?utf-8?B?dVU1dlcxRmtZUzU1Zk40UFFYOHQ0VTIrVzdSTlBuTFlrRkxaZHRlN2U0dW5n?=
 =?utf-8?B?OHpzZEcxTWl0V0ZGZDR4Vjd6bHgxY09tL1RGZmJiVXlkWnFLZzR0N2dLRnpu?=
 =?utf-8?B?VXRrRlNUaTNRY3Nrb0svNmJIdWpJNmRQQXVDajU4YzRzcTNnQzgvdXBOZjNx?=
 =?utf-8?B?MVJsYlljSjVFcm01TTdiWHkrWUVSbUJhWGhnM0RYb3VjL2dWdWROMCt2ajBy?=
 =?utf-8?B?SHZDaUpzSnJPaUgxTDhmSkExbTNNbWRrTitVcHoxR2kxTkk2UEZIZkFFNFBw?=
 =?utf-8?B?eFdYY2c3cTFtcDNhazh4cCtrYmFGYi8rS0pVZnpSYTJwbWhrL1FDVDhFS3pi?=
 =?utf-8?B?SFJQRUVHREh4SVdhVmxZQ1F4eEREa2Q1U3poWHVvclV5b0g2TEVaYk1SQjBS?=
 =?utf-8?B?dG5uK0dHMjJqNDhiOWNOd1MvSGc5MjMwc281SWFKRWFqaEE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2NFajlxUk41eU40SHBqMnVrUFBKVW1yMEUvZFFZK3gxaWFGQWtnRThYV0hP?=
 =?utf-8?B?V1Y1UTI5aENPT3lQVnVINEtXbnB6VnB6UVkzSitDWm5ZT0VsRGFQRkhZbUNS?=
 =?utf-8?B?ZVljZEk0d2RudCtlaWlQeHg0NHlYTWgyU3ErK3lUcnhaYlJ3L0E4c2VPUHhB?=
 =?utf-8?B?YmJHOTBzbkN1SVJLOFBNbWQzd2xnQnNHSVhDS2VjMFJsb1ZOVG11ZzU4dXQ4?=
 =?utf-8?B?SUx0cEI5eGpBRU4rOXEzbzgrMEVkbFBwMFFuR0dtUzQyR1BmRXpDa0NhcUFF?=
 =?utf-8?B?SnE5U1c5VlNvcGtaSUJQdTJBM3VLbHU3Z3NUVkhjckMzNHc1NFBSd29iN3lQ?=
 =?utf-8?B?SmZGSUhzRjMySUZXbFE1QSs5ZUVtNGdQYTBzK0hOVklZcWJBbmIwTEFvVXhF?=
 =?utf-8?B?elF1ZnI0WlE0eEVraGEvaitBTlRIWlVxTW9QWHN0ODF2emJuWitmYkp5aEtN?=
 =?utf-8?B?eVZBaEFoUmFTenA1SWtmSEVzcTlvZ3A0ZFQzU0pTRmh3VlYvYy90SUdMSlF5?=
 =?utf-8?B?b3NiVHFCTWlmL3d3WFVTc1JwdW4vZWNleTJ0WWlhYldyb1NSRkpESGJTNitE?=
 =?utf-8?B?UmUxYVZKM3UwTXFUOXVtTG81Q1dzcWgxaWhGT0V5b2dlbjJpWlVtRDBFTUNn?=
 =?utf-8?B?MER2UEpiMWRRZFlJYTRNNjJPRHRzRFBDTWFWOFhEbU84cTlnOURjbGJmNjZv?=
 =?utf-8?B?YThXMzh3THIyNUMxMFpicFVVemdmTWJMaEZYMGxZLzh1NUFNaUJDczJQanhF?=
 =?utf-8?B?cEdCRGlsOTFiOU9rQ0J2dEZoZTJQamRpNFhWSzR6Mm56SmpSbTBXK2dYaUZB?=
 =?utf-8?B?SFNoRzcrdGxFUVlmZnF0ZFA2R1V1ZkZYRGptNDFCTEpmalhIS3NXdjQ0dDVt?=
 =?utf-8?B?ZndmaWFVOG1aZ1doRE5HazFQblNVTlBGWUxVUFRHa3FUYXNacHV0bnZjYmM1?=
 =?utf-8?B?S0tXeTRXbEdnbUQzc05oQ2JJd3ExaHRCNGszblZIMDZ4OXdVc3hncnd3cTk1?=
 =?utf-8?B?Zm5Ga3VwaTZsd1VrTk92NDVEZ09EMWd1dHN4L0F5QnFudXQvYXAzRFBOTjBr?=
 =?utf-8?B?SkpjVklPcjNWRFFHdTh1c1ZMcjlISlgybVNjUjZHKy9HMnNUMW4wOGNKb2Vy?=
 =?utf-8?B?OHB6dWJ0dWlnbEJMRWVhSFQ4bFMvbmRLTXp1eWdML0p4ZmJjaU9wNm5GUDdv?=
 =?utf-8?B?S2VCZ3puNWhIZmVKeERzMzA3UFRyV3VCK2R6cmZMN1Q5S29iYUY2WnNVRTFW?=
 =?utf-8?B?OEpRWGt5cG1QKzdaeXg0VHNDSHQrNHcxQStnSkw3NnRBM3R6OXBxU2JSWGRZ?=
 =?utf-8?B?RVhlWUR1eWl5SkUyRW9SM0ZZL3YvUFU0dE90VWxQYjdUNVR2WlRPalcwdDNj?=
 =?utf-8?B?M3hmNk56M2R2aXhiYjF3YkJNVllCRzlFVi80K0IrYW5QWGdCV0RSdjdzd0JQ?=
 =?utf-8?B?VkhyZHF3MVlBTk1aOC95SHdJbWJmSTlZdWNGZFNCVmpHY2UzNTQrRGptWFRM?=
 =?utf-8?B?cUJGalhSaGtDZVlwZVAyMVpXSGxrYmxqMzl3dHFEakVDUml0SEZ0ekRvbTl1?=
 =?utf-8?B?SHEycDFkT2tDV0FUcU9PdzhXQjRIRG1yZmN4L0R2cHdrLzJmdjhaSkFKMjRz?=
 =?utf-8?B?enZ6ajN1LzNJa3g5MmZLSUd2MTgwQjZOV0lickNGd2tqOXJvMFFzV29rOUVx?=
 =?utf-8?B?UkhVMm5ucWpxeHhiMGtLWlFySG1oY0JWcytROFZvdG1Lc2JWN2JaUEtMSGRQ?=
 =?utf-8?B?SS95clNqdUpCMGtGSEZneFZ0TE5SaEc3eGFjN2FxeWEwQXFTcGF0Y21sQXFt?=
 =?utf-8?B?WUVleUJDYS9ZRXZlL2hQU3lpNXJPOUxHRUE3K1BtdlkzeFA5OUlRWEkwU2V4?=
 =?utf-8?B?OTVqRXZ6a2JqSEFyOFYzeGkwU3JUQ2s1bTBXNUgxWm9iazJDZ3BsVFVYQlRO?=
 =?utf-8?B?S1Q2aVNvWXlJeFhqeGhuOU84dWJudXZETXoxeStUSFBQRS9rd2RRTlFLTUhx?=
 =?utf-8?B?NlczTzZKYnUxdnRwOC9ONytxSEc1NnIzSExtcUpWWGdtRmZ3bVFZcXpIQ3JF?=
 =?utf-8?B?aDVhSGkyTzNLNXFkajZnSWEyNDJaWWFVSHFmQ05EU2xCUDNOTnJ4SFl5cmg2?=
 =?utf-8?Q?BRAtydRikA1TuKzM7MUg4gshQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b0ee7b6-2251-4713-567e-08dcb7500fd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 02:16:07.0318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lb/PBpPRCPTTsQPYWX2B68W848tpJQAf2RkbCOMeI+2vUO3ujOhOes06LHr5gTlcAdYLlrto4sFn2GsRrXRJIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4610
X-OriginatorOrg: intel.com

QXR0ZW5kZWVzOiBKYW4gS2lzemthLCBGbG9yaWFuIEJlemRla2EsIFJpY2hhcmQgV2VpbmJlcmdl
cg0KCQlEYXZpZCBPYmVyaG9sbGVuemVyLCBDbGFyYSBLb3dhbHNreSwNCgkJSGFvIExpLCBIb25n
emhhbiBDaGVuDQoNCkNvbW11bml0eSB1cGRhdGU6DQoJCVhlbm9tYWkgMy4zLXJjMiAtLSByZWxl
YXNlZA0KCQlldmwgaW52YWxpZCBvdXQtb2YtYmFuZCBzeXNjYWxsIGlzdWUgLS0gZml4ZWQNCgkJ
ZG91YmxlIHVubG9jayBpc3N1ZSB3aXRoIEktUElQRSAtLSBvcGVuaW5nIA0KCQlzdHVjayBpbiBj
b2JhbHRfbW9uaXRvcl9lbnRlciBpc3N1ZSAtLSBvcGVuaW5nDQoJCTMuMSBicmFuY2ggcmV0aXJl
bWVudCAtLSBvbmdvaW5nIA0KDQpPcGVuIGRpc2N1c3Npb246DQoJCVNlc3Npb24gY29udGV4dCBv
biBYZW5vbWFpIDIgJiAzDQoJCSANCgkJDQpSZWdhcmRzDQoNCkhvbmd6aGFuIENoZW4NCg==
