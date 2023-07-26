Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650999469
	for <xenomai@lists.linux.dev>; Wed, 26 Jul 2023 08:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690358574; x=1721894574;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=aZ6a2u8zhjD/+kK+JrsLA14rY5vcScOOB9YuvBA6n1U=;
  b=jr1GUnZPd5saRL8MU2dI5Ubj92RWMsLEJ/39p7VXCdxuZggRDSgqB6BW
   K65o3gGjS0vbSO1x7f95UE63Kbnqf7NfMJLrcZAp2J7rRacnv7yf47gGC
   fkuaBdTf1Rfv3/LFqCiz3gUdz9DGLtrGnvTLzqcrX4yKxLQo4qk2YTSkp
   HOH7KxgkDfL3QwyTGxD6aNFXB2Nu4Zpp37p9j8rx2ChE5uhWP0r6G+O3h
   spse8DPVvxXR7brnyTjdNlsbNEW/8i2TVIAgl7JMyAaaqPvdD4sEXjyMK
   vCgJqBBHYq1fyHwTAyQ2Vx78eD8AgxjI2CSqAj+pwUI2J/kOCL3lCjqwT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="454325948"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="454325948"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 01:02:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="900323253"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="900323253"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 26 Jul 2023 01:02:52 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 01:02:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 01:02:51 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 26 Jul 2023 01:02:51 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 26 Jul 2023 01:02:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cjf8hUwhGWffF/y9snvMla0OBcpudkEis9IYqIceBKNlCPVs8tj3B/Y5MTFPheFmJ+0Oql9avKMNdPxm2pBffsZdWBWE805k++nCV0h9d51KSqFp+uJarID6hSaA4SipTs37fQzopa6LmjWhZFTlAJCji2HvpWVtKYpPGdvox7+Eygdy+VzsxMc5QVrrXKMg8Xk9T0lL3edtWgsYF9ZRf6lqizTUR+fjj9bOhZjwAaUoNF/i9DOkdbz4VbLhHh4u0h+JF9f1uVKKZLD4f1erLhoXlH+T6PWx2kvKfGJqtsP8D9hu+zWmQ/kVxJYG3O/zEQ/zRgWXx7oXJDTAUEOEfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZ6a2u8zhjD/+kK+JrsLA14rY5vcScOOB9YuvBA6n1U=;
 b=CY8TIBv+Dv0vHXKfitHxOwok02QU3UheKJJcZ7qewNlcPy5hkYK7lcTHNPtROqquAQiD6uEABDqTC6UqXR3AzrF2uOcwTuqz7TrmU9/3gEv0b3+bjBmJv7bIblAmpr0vJ1Y/NEZLaeO0BY1TEcl7Eb5dyb73mHMnXTf0IyausNCJ2YVHB0PUwbykCJW2Qu3MiZsb3j/UWt0rb4YAMgHZqKreEwFK5JdjHcQr5Ccggjt8d21mhqs8FibM4H/95sZeJ9QvL3Ym4Xh5mkD19JTBQkg6NaJ5T6Lv7J9aZmuhXIO9HkxgAiME/BsUnKHHgDBnuwuO5n6RSU1D8FLysZpTvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by PH8PR11MB7119.namprd11.prod.outlook.com (2603:10b6:510:215::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 08:02:50 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::431f:7b31:39c7:e9be]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::431f:7b31:39c7:e9be%3]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 08:02:49 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Xenomai Community Call Minutes - Jul 26, 2023
Thread-Topic: Xenomai Community Call Minutes - Jul 26, 2023
Thread-Index: AQHZv5eRG7If/02yAEeehT0bSYX8Ug==
Date: Wed, 26 Jul 2023 08:02:49 +0000
Message-ID: <MN2PR11MB4285B46D0510422E41688BDEF200A@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <MN2PR11MB428571D2636A8A0A7B4CEA6DF236A@MN2PR11MB4285.namprd11.prod.outlook.com>
In-Reply-To: <MN2PR11MB428571D2636A8A0A7B4CEA6DF236A@MN2PR11MB4285.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|PH8PR11MB7119:EE_
x-ms-office365-filtering-correlation-id: ea57776f-65b1-466f-b762-08db8daeb467
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GkBtzN5FbRMiWX3Sby8K5Yw4i7FkrFHPg0uteBbica3TL3leMgpLYK9T9BjekJ3stCPLyfKGwXQMEdN4XetVqfg2SCo1QcBb2DHWNeRbETv7cnBejkqZ/7KqVLR19wPgWycmVTtlGbKgaXBYhGAfUuMY1oC2QefMPFhSILw8hJPF5/3TojCFm5CO6QUmoYxQs/Omh49oNw2O1dm7jNCSAsfuQdbrsHStBiGHT+ux/hu6BD57u6foj/H50SK64k+ThJv0JRBL1FHMGuDeN6NZX27naGYEU5gh5j+aofULtmHvcrfT7RaLkNajXoEGZFgPg4jj94rY/Xxyql7AaDrDDvwyEufrQug30/hSSQ0uWWlpb9LjKvmAC7JdqDMgbAg6Pwc9C9qoxpcd6Tb4yEnkwWUOZL9yGDl0F8wDCjPw5tsWeeOhCny5FyySx/I8pv5f9vf9l2COw/1OFKKz1Yjz2s5gkKjUFXF87XvPxuhGjRjVjo3uYVsRp704lD0QRvgAJ6FnK2bhC7EM7rZjvCrC91Hpq6qCzjT9n4ddvmbe5UEr7y6tgqP+EuCSUj3O0FKF6FztUXvo4RTzxNUhfDWvjVA8+/p1oVL9rM5TTcd6B6IjX96S8rd6P+yMqgnzogJs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(136003)(346002)(376002)(451199021)(86362001)(38070700005)(33656002)(4744005)(2906002)(55016003)(186003)(83380400001)(6506007)(26005)(9686003)(478600001)(38100700002)(71200400001)(7696005)(122000001)(41300700001)(66556008)(8936002)(66446008)(66476007)(76116006)(64756008)(6916009)(316002)(66946007)(8676002)(5660300002)(82960400001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGlINUxiZU1vdlR2SHlIZmlBaDQveUNRaUVvbCtOSWJHY3JMSy9JTXNQUEtT?=
 =?utf-8?B?Sm0yVGxpSWhuM29OTTgwN21qMzJsSmpiNlR6TEk5SHpsTVNYdUttZFhVSUNK?=
 =?utf-8?B?K2ZBRG5YcGlPWHpsd2laTUR6djE2N2hndTVpeHRjZkFXSCtzdVA5TE04dk83?=
 =?utf-8?B?RUJtRHRRWURUbTFXd0RKQS9KbTYyVnRZNlJ6NVM5TDhMMkZZKzAvQkpPVllh?=
 =?utf-8?B?cXFmcTFNbFdIU0trT3VCaERGVWkwQmxIMktVcWhoeVVjRjZ0eHErUndwQXpT?=
 =?utf-8?B?bFlDTlp6SVRaN25uRTRGRGF0UEZ1bFhxWUR2UXdlM2pNdlEvNU1GcTBPUnR6?=
 =?utf-8?B?d090dG0rbjJTR0h4aHJSaTdtRkpuZ2hZbUtZck5EZ1NkV0d6SUh3b0I0bmtp?=
 =?utf-8?B?RnllVnROb0hweitnRlBkQ1UvcWorakxicDVmY2doTnhsSEhCUjJxUkI5NTBU?=
 =?utf-8?B?UmFuV3BNS0R0dVo4aVk3ZC81WDN3Q1FReWdpd0YrYXl6aXdxUWMvcHc3QnNZ?=
 =?utf-8?B?dWlTVjBNOHIycVQzZFdHcHZ0SGlDWXZrRnc2dGJLQUUwNDRJMGYrclFhS0ln?=
 =?utf-8?B?S2RzQzhKbkRhZXNXaDk5M1N4dmZpeENzN29MaVhTR2NyMWh4a21vZU9GalhR?=
 =?utf-8?B?S2dHNnMzTVl6QXk1R0VYb0tsVWRqUysyNUpUQkp6MkUrU1VBdmRxeTZzQnJo?=
 =?utf-8?B?eEIzUmhSM2loT2Z6YVJrMkpQZ0xjSkVyb0NWVWtETG56QWljK01QTHFYaU1N?=
 =?utf-8?B?Ni9XcmNyazNYaWhlQnYvQlZJWGgweUszem1JZDhwZE5nVWY1ZGIrSWkxaWJQ?=
 =?utf-8?B?VDMzTFJsSGErSWlTcGpuQmsyZjZhTEJ2MDd1V1B4TUNxb3JCaTYrYkhUNkpp?=
 =?utf-8?B?NlVIT1B5KzJNd053RkZiM05FNkpLb3paNkFRT25TRmRVUGgxcTBtYWFjNndW?=
 =?utf-8?B?Wi85MGpmejBLZnFXcTZwbEE3aEFaNkE0TUZ4UHYwTm1jaGpmVHg0R3BrdndR?=
 =?utf-8?B?V2dKRzZsaWlsYzhXZ3MxaDA2OFV2R0FaYjQvUG13aTFaejV5ZUpVcmRQT0U1?=
 =?utf-8?B?bkV1VEhtQk5lMDBmSTFPWjdISjhkdHRQdTBRN3lFQXpOdU9VY3YyV21VdUY2?=
 =?utf-8?B?NHNsL05YNEw5dXpBTlVORkxVM3ZuOUJvQ1RGZFJwekpYdnQ5NmphRUV5a05P?=
 =?utf-8?B?RFpUZ25LVmRqaW4vSm5WWEMyT01xcG0yZE1hcVlmVFZzdFNHaUo3TmNEcEVq?=
 =?utf-8?B?RjVxcFFzcUllT1M4TFphWEtXVTh4am1VMVNPRG1LQ1IvNlM5akZUU29ENUp3?=
 =?utf-8?B?Wm9wM0EwMVJNY1dkMXZSYmRGVzQ1UFFUakx0a0poMEtZMFBtQklrazZiYkZ4?=
 =?utf-8?B?UVBMbFQzUnREYUQ3eGozWUJYWmlzR3FKbWpJWVZickt5TFlxcldUWVo4dVdT?=
 =?utf-8?B?RXJxZ0c3Zmh3MGVZSjF6NjFncnNUM2ZqMTI3UUlMYUFXbThSaXBaRnVkcjdh?=
 =?utf-8?B?dTUzaVVmU2p3K3JOajI1Nlhpc0NWb3loOElXbWQ1VjdsSFlzUjhMQksxU1lz?=
 =?utf-8?B?NTlkc1NWdFRpWkRJeXdUbHdhRSsrWS91QUdtRGNvR29HdEhWYlpFL1NPenU2?=
 =?utf-8?B?R0lpVVk2MGhxZmJ3RDZSNjYvckdINHQwWlE0eVJUV01LMHVtaXFBRFpOQmxY?=
 =?utf-8?B?aXpRMHc5eFhUaDM3MzYyVXcwWHJjTFd6K0ZUR29hcWp6TmgzSytuei9ucTZ0?=
 =?utf-8?B?dkRmc2g0cTZwUFA3T2xqbTlRc2MrQktQbEFNSVFhOGo2WlFuVWFDTElhcUtr?=
 =?utf-8?B?RWl0K1YweUV6ekRocnRmR1Avb3Rwd3h0bDRVQmNsSy9WSnJPRFlLbWMzSTF3?=
 =?utf-8?B?WjF2UkFrakxZNFBVY2NqSWxXa0dyVGZwQ1N2dVdQOG1RTWFHMmFaYmhpbWpi?=
 =?utf-8?B?V1E4TW9SOXpEMmFJaitMeFZWK0RPQUdES0QyZHQvVzV0VEZHRWU4STZvc1Bh?=
 =?utf-8?B?OEVLSUNlL1JuY2NpTzU1bjdYNjZyVENETUV4MTdkVnROakdPVWdZeE9zd3ky?=
 =?utf-8?B?NjdPNWpOZXFJSE5xS3dTVGZBcStPWmVsVkhMWThLNVFqakFBK3hYOUVrRW14?=
 =?utf-8?Q?OQO3R7KscBCSZU/hUnzb1kKYh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4285.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea57776f-65b1-466f-b762-08db8daeb467
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 08:02:49.3457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hN7tlowKytV8/JQV5A5hfyYmtf8WrhZ1mp417n9WrSXyIPtFtfkqF0EGLcaN9Jug0D30hr6RzWDFfETqKB5nRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7119
X-OriginatorOrg: intel.com

QXR0ZW5kZWVzOiBKYW4gS2lzemthLCBSaWNoYXJkIFdlaW5iZXJnZXIsIEZsb3JpYW4gQmV6ZGVr
YQ0KICAgICAgICAgICAgICAgICAgICAgICAgICBIYW8gTGksIEhvbmd6aGFuIENoZW4NCg0KQ29t
bXVuaXR5IHVwZGF0ZToNCglZMjAzOCBtb3ZlIGZvcndhcmQNCglJcnEgc3Rvcm0gaXNzdWUgLS0g
ZGVidWdnaW5nIA0KCUlycXBvbGwgaW1jb21wYWJpbGl0eSBpc3N1ZSBvbiA2LiogLS0gcGVuZGlu
Zw0KCTMuMi4qIHJlbGVhc2UgaXNzdWUgb24geGVub21haS1pbWFnZSAtLSBwZW5kaW5nDQoNCk9w
ZW4gZGlzY3Vzc2lvbjoNCglXdXhpIG1lZXR1cCB0ZW50YXRpdmUgZGF0ZSBhbmQgcGxhY2UgDQoJ
QUJJIGJyb2tlbiBpc3N1ZSBvbiBzb21lIHBhdGNoZXMuDQoNClJlZ2FyZHMNCg0KSG9uZ3poYW4g
Q2hlbg0K
