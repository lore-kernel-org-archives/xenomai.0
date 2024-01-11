Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928B37E4
	for <xenomai@lists.linux.dev>; Thu, 11 Jan 2024 01:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ApTFbFom"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704936009; x=1736472009;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=FTH6oD2s0IC1t7LCNUY4/DII43oHoBaM3eAaW7xKxZ0=;
  b=ApTFbFomNqkudyimeetfcaTVBN0UEtjF6VOnk4dVlzXZ92/BOD6no6qS
   Dgob8dAfBv2FrohnumbGbG/WqOfFRZMMSQ7IW78nFUAGQc32VzOcVTqRH
   6VdmYeCvMmWDvsJZjAsRH+GHJRHh3AJf/wYLCI+x41JeTkWXr5H+dX54e
   8Z2RYV7CI710KOx6d7H9eww+96NtxKbty+j7eyFewUKfFj+c0XhRAJW2O
   k6mxxuq7L5t7KCovA7YiXON/a4sruaOFjmoj7g9sMSBDQr0aCzQ8MfhBM
   sid73pNTxvYGvLY2Qr6rlcz2fzGactKr1Ro0z90+19Kg6s6aCQx6G7m/S
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="484881527"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="484881527"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 17:20:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="905751916"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="905751916"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jan 2024 17:20:08 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Jan 2024 17:20:07 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Jan 2024 17:20:07 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Jan 2024 17:20:07 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Jan 2024 17:20:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRVfpzVT3Er6j2qf9gJ+hVItEWHUnHHWNFoRZLjpxLukxEI8atorIadEdhSrfeCsvQZpyllNDsPJBsJ93suz4qjQebizfdPbDmYRRfEkHxbkpmJv9Z+XyC7oRBbC3wYGZiO7qM7ouxvmfO8tN0qmSFi8u+1JrGHhkNvp7wZ8CkaVSUIvYxOJxLNyJF4jngKkH87G6lLgLdxPQHINHILtfuzsU3cj1nuDMK5NZUXN1LHFyPAotA8C6khGqVEyCnhiniaF2JEK1JDtmQAJWs4LHC2t72aa2mIFSLvDRh+MEg2CMknyrTdfhlRno9QhPyud7OLJ7XmbVu9omhl2S9HcqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTH6oD2s0IC1t7LCNUY4/DII43oHoBaM3eAaW7xKxZ0=;
 b=aqnouz2U8H8Gn/WrduoslPbo/ukquFCpc+5dikNivAzl0iNm85M3QiJPhH1N6LGocQQ4HEu+98nTznpBHo7wApQdzGKl5G3wT8j2BDpU71+UJwbcmhq6Fh94rPEKIYB/UJOMrHaMinVNHSSh8RBXf9XGGR/cLdvYEiw6Ks39mcdY1Uf4kYulN1svHox0HaVeXJDnZ5RQyIrsFdd9GOV/d5dlZ61LcEB5tjb3oLhKWA4XNiDZDkve2FrXdvkSFCjVRWyaKJQFaxUEfycw3xT46VWz05t9PZNXiHOgc3/4Jschn7XlhP51N2HZv/dEHCKC7ZS3PI7XQNycOOROYdFNvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by MW4PR11MB8268.namprd11.prod.outlook.com (2603:10b6:303:1ef::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Thu, 11 Jan
 2024 01:20:04 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::c885:af6:b3d6:4d9f]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::c885:af6:b3d6:4d9f%2]) with mapi id 15.20.7159.020; Thu, 11 Jan 2024
 01:20:04 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Xenomai Community Call Minutes - Jan 10, 2024
Thread-Topic: Xenomai Community Call Minutes - Jan 10, 2024
Thread-Index: AdpELEGN2TLnTP0PRbaE9x9u0wePxg==
Date: Thu, 11 Jan 2024 01:20:04 +0000
Message-ID: <PH7PR11MB7499EDEAA5E1EB85632975CDF2682@PH7PR11MB7499.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|MW4PR11MB8268:EE_
x-ms-office365-filtering-correlation-id: 77d3dbdc-f640-47d0-7fe2-08dc124370c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aInitF372MkhRMnHVedVv24seotCEZb7Wj2FWK/VesjhrzGSnLC1OXpz5rpOA4zneiPJDpjPwYfYJsaMmKDHxSlLQgSY9bNtzcwkgn6tt3hgxSvzuRLVkNVmOBVsLwwV/FS8LGUQW/WA0jLSj4AgwBPJfSggsMcJr+NlNxihKqLowd8TnUm8x9hr72xml9rPSD+yS8zKKJcRmRs6rMlIjMsqfc9uK1Zq1CRSYy5RnHeNCt42wwKHw3cT1c4+3BgX4oFKcfBAE63ckbLAWUgUNF3QgpebWcOuOqojfcuumxYm2vPCxbcUWcvQIiJvLhpLTSUHNk/b1HCJ25+dCMItdEqbQapZw0DrgLdBbeihaZl7D/NL6hdz90wBUS6+91xADMOeVHkZtPr2TFBDBK048ik8MeaC0RfFHpamj9T0L45+wU/syhskRqTbvqALYKuJMJs10o+tb9JY/+267XbmsWit11zwqiO3leiEDwpvORMu3MUTpy594IX/0tvo0kp832eQ0GYQTS5kduAiM83tYZmBI05m0FE6dx5f+jEOMsoY/mX7pkrDi6uvi40I8GuMGjeIeD5OwqjJRLr7KgJ8HPsZWgnpS8+wao4z7Tk1RkVOyKcNC9teH+zHCldIl8FL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(366004)(396003)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(122000001)(316002)(558084003)(8936002)(8676002)(71200400001)(7696005)(6506007)(83380400001)(33656002)(66556008)(52536014)(66946007)(76116006)(55016003)(9686003)(66446008)(64756008)(26005)(6916009)(66476007)(478600001)(38100700002)(2906002)(5660300002)(38070700009)(41300700001)(86362001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXd3VWQxdlJxZER4SmZuL3JKaFZhV1h3Mkd0MWt4RGZMTWQzZm5abUFZalBp?=
 =?utf-8?B?SkxsSUhIVXZycEpXdEZwYVlCOVpFOFd1N0JBSk1xYmxMb1orQVRyeTc2RGRN?=
 =?utf-8?B?eEFkcHR4aDhSQnhFdXNYb2pOTjhLcDdtMkdoUklkemtLY2lQMkM5Tkh5UHRy?=
 =?utf-8?B?b1FhRm5JbE5yNmNvZ0FRTlo2Z0Z2cG1Md0Q3L05rNUFQYXlKRDFjSlpLa2Fs?=
 =?utf-8?B?MnUwcWxQRE1ka05jaFUyVlVmcG1kbjEyQTFyd29BbUFBT2JyS2RnMkl5elM1?=
 =?utf-8?B?bG1zQ0FNeUQwQmhPMlRLRnBNSDhoeE9xcVpsNUY2cElsQ0t5WUtyc1RQSFZH?=
 =?utf-8?B?OEE4RnBMQnpJYnk3d3VZcUt0TVh6U3FVUjZWbEZibGt5S3J2UWlnc3V0N1R2?=
 =?utf-8?B?M25iMmtQUXFzcExYRGJzZ1E3bks4S0lZZzgwd3JNL2JtSUtheFFaNVFOQlhE?=
 =?utf-8?B?MncvU1daeFVCV2IzQXVXYnpTeTlNWXovbkNMS3ZqUWQ0ejAreER0UHdoa25u?=
 =?utf-8?B?d3hZVXVSbmh1VUF3cUJKcTVXMFlxU0FvbHFjRldOMDNTbnpRK3JVMHlMR3NK?=
 =?utf-8?B?QWR6TWEzVlo2Zkxia3cvcnVOSno5U21MRVJOcVJ0RVErVHBxSWVXZXFOdCtu?=
 =?utf-8?B?NUxFdUZKTjF2WS8vb2dOOUI4SDAyTTR4YjhWd2ExemZ5dTBITUVIS2kzSW9T?=
 =?utf-8?B?cUZOVDhSQzVMclFtQmZkUGI5TitteWFiTDE3SkkvUlVBWER5ekJVcjM0bTMv?=
 =?utf-8?B?ck9UVTlnZ3RHTWYyN3YwWnZmNlVsQnE3S2lhanc0dFRpWlEwdXZRV1ZORGgw?=
 =?utf-8?B?c2dXeFMvKzl6bGVFdnVhVHV2SjBrTjIwNHdwYTlzTithb0pOZVZSdTVONzhy?=
 =?utf-8?B?NlE1OWhqZlMvMHBESVNkZ0xVMmU4WEsrNVJtSm1PdThWTkc5S1NUZWdvZGp5?=
 =?utf-8?B?QmNVM1VSL3NmYXBKdzhoc05MMEJ2dm1DTi95TW13eE1KVXFBTkFWOWZvMUx2?=
 =?utf-8?B?NXVJdVdDd0o5QlhMTFJmNHZ0TXAwTUVJb2dlaEpMQzFaMVZvZXNub1N5S2RF?=
 =?utf-8?B?VkVRMFZjS090eUlXMnJ1VTA0Z29JdG0vUm41dGhNYnJLelZrTFh6TE44OHM0?=
 =?utf-8?B?MEJjSnlwTFRjQ1hTeFg1eTR1K1NPU3VWZU9VYTV2L0ZMemhoQ1VkaktHL1M2?=
 =?utf-8?B?VXpvVXJXaUsybUVudkQyUktoM29UdG5JcG1tRVBCSUFFUXVjemNCTmhsU2k3?=
 =?utf-8?B?Wk9qVmc2ZmhUWEloMlQybys1bGsvMENWVzc5d1JYZEZ4UmZWTDZhZGc4azR0?=
 =?utf-8?B?c3FlMElDQVhDTnpteEc3L0NKZHJWbWQyTXVGa1dldFBNeG94dmJzK1l1UDd1?=
 =?utf-8?B?bTFwQ2tla213MXlVb0tTbjFjbDFOR0xYU1Q3Qk5sYlFQcGN0MnA1QWxHOUlL?=
 =?utf-8?B?MXI5VCszbE1YUFNvNCs0eGRkU1dlVlo5c0lPMkczanNRamtWb2pObFJnc3Qr?=
 =?utf-8?B?alNCQUJUemY4SDZJL0lpZWFyYUQxb0Y2WVV5Zm8reGpsZE9hMnQ2dENlUnhi?=
 =?utf-8?B?RlkyN2l3UmNjTTZFTW5zeWhFVmNuRkU3M2d1b3cvUm95R0NoMzlVQU1wellK?=
 =?utf-8?B?bkQ1NDlGTzhzR243NmR4NXJDckZIZFRoc0NkWTkyRlFpY0xXQUtKVnlEaVhS?=
 =?utf-8?B?YzVORXRRa3J0WkFDNmxWQ3JQM3Bkd1ZUYWxucDV2cmhWQ2pFVENQa0NCa3g4?=
 =?utf-8?B?bmE3TWZ1eEw4aGFxK2w5NDdRUnQ3WDhjcTRFUk94R1c1ZEk3cHdNRFhHbkxl?=
 =?utf-8?B?cThJYytrRDlzNmpSZXdqN2ZNQ2kyUkZIeW9majc1cHFsZUxQR0RBMTJxczhv?=
 =?utf-8?B?MjBZZ2RCeFhWTmEraWJOWG1VNDlYN1JZcEZCN1VqaGZtS3VybXhzQ0FreVoy?=
 =?utf-8?B?bVFCVm02amN5WnFxWTZnU2NhdG1PMjVJS3RCNFhtVGovYkhGSHdPcENNV0Nh?=
 =?utf-8?B?c1JJMkdXTXRuaXlRRmZKeExQZjdKYkJ0YitDazZtbjJ5aFdGTXBGR3FhR0Rl?=
 =?utf-8?B?MWNoYkZZcklGSCtRSWR5cXFXWFRuL3JBQ0wxeGRkOURHTDB1Z0l6ZGRXMmZw?=
 =?utf-8?Q?TGJ+OSRhsVTHH8Mq/QXwnVHeY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 77d3dbdc-f640-47d0-7fe2-08dc124370c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 01:20:04.3981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0OHl5KzlpHtOumd8FFGIUFZJXJegyLJbkW5gKsXy4nsiwUxK66mjVxUAMOi5BZbOkhIfXxCmN52+5EaXcCIlqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8268
X-OriginatorOrg: intel.com

QXR0ZW5kZWVzOiBKYW4gS2lzemthLCBDbGFyYSBLb3dhbHNreSwgSmlhbmJhbyBDYW8NCgkJIEhh
byBMaSwgSG9uZ3poYW4gQ2hlbg0KDQpDb21tdW5pdHkgdXBkYXRlOg0KCQlYZW5vbWFpIDQgaW50
ZWdyYXRpb24gaW50byB4ZW5vbWFpLWltYWdlcyAtLSBvbmdvaW5nDQoJCUNhbGxpbmcgX19nZXRf
Y3B1X2Zwc2ltZF9jb250ZXh0IHR3aWNlIGlzc3VlIC0tIHRvZG8NCg0KUmVnYXJkcw0KDQpIb25n
emhhbiBDaGVuDQoNCg==
