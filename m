Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4143620313
	for <xenomai@lists.linux.dev>; Mon, 15 Apr 2024 04:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713155294; cv=fail; b=QMce758IZvgky8jbWr9uL9ECP8iTh0uNpndu6y62vDeovL/BTDBheYF4tbkUUEpHVpMJqvyJhJR+yRZeaqVCB3m6wfMcvnk3WWHaUKlchTgFvKwgyXqyn59EJiqDvGET9vHLUwmLOLvCBUI0Z3p8U7z3IliivWXUiRloq3bLgwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713155294; c=relaxed/simple;
	bh=dhMVp5vdE7SGVehtoZK/gTCQjF7ZsCAS0kZZ+EQPNMY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DYXEPdRZHRxpHi7zYZFA2+B9LphpMqdpA2q888WnRFxz3SXqEmnNeBJ/sjC+tW7Wr8WpqnGh36/egrGNkJVXdc9aoudgbbr11TUU31yyTNCvFw/U5BqI3iWAtJ+lU/HJ9Rj6yn/l+Nbc9xXEH0W2ipM7joIi7TMT6M4uMp/FEfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f7839IF7; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f7839IF7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713155292; x=1744691292;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=dhMVp5vdE7SGVehtoZK/gTCQjF7ZsCAS0kZZ+EQPNMY=;
  b=f7839IF7z4dDg4odE96Y/EkCvQLgBLKRErfDQPkKc7bxy2oML1pFdwpo
   awiLG2l8lT2InDo+YXD6ntVB8CSiRkxLEvaizUcQBg3WWqo4IIfghKVCH
   ToEOgM52afyGZZu4yS8R22o2y3E5uvpVYyeV9l3cpiQl18oe/QMSqQtXO
   GA/SeulOp5ecoXchgevKZV4LAveyhmJM/RNO+LMXdKHsyCStOTjcWnJGn
   Ool4rpaeYwg3xNs4rU5RkeovpgdxSyqNbdNfGgFD9LCUykg5GWBY2o5/z
   qFqwAg4ticPvFJygYzpk2gv1fx045XzNAIlfU9KY5+2QuQ/tP1Gj089W7
   A==;
X-CSE-ConnectionGUID: Kd0aYWwnSRW/3upU317uAw==
X-CSE-MsgGUID: uhYTd8EXRIKtwF750L+UNw==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="19671687"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="19671687"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2024 21:28:12 -0700
X-CSE-ConnectionGUID: SeGmowgcR32g4/Mo4WVHjA==
X-CSE-MsgGUID: tUnjdGp6Q+W1qYj+sF6GeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="22364525"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Apr 2024 21:28:11 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 14 Apr 2024 21:28:10 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 14 Apr 2024 21:28:10 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 14 Apr 2024 21:28:10 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 14 Apr 2024 21:28:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyCFIAp1IYPGo1RYHx4rsM29+gfgS5Ciemvw4SsQz6ELu3XRP1DNgMT2Ww06EsP+bVqB4c4RW1ktN0JNN4ao8lqRzZezq1U4YjE1lYulfujIUy7s8FieRzd2q41H9nq30kfZkICMCjywiF3Icz3hd2iniq9yTrGGp+z6vgcn/T7nIRKMwZUpn4BglnfiyARclw793N5KdT0gfoyyWWcH1FcQ9TwptZPdaZoHNogG0cbgYFHS9qHtTnTzJ6ddIGWTcdqQpTzx4sv8ByicviPpKKBP6RlTAe+uSwnkLQmmr2j5s/eEaHm3H5I8+FoT6wK8C5CAPYG4fByDvHCUzc8mOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhMVp5vdE7SGVehtoZK/gTCQjF7ZsCAS0kZZ+EQPNMY=;
 b=id5bXMP3NtNPjZfwPU9R+h5/XHZKJtVEPieFErMtse0eZYwx7UCpDhJcR8pUr5g+DE/XzEWLPvPAixjx46Z7oiQloLPfoOELM9ortBgLdmh4C/1mhF9BQJifKVanBF6mUVeedyqjbY+gjbOY1sVD40TKp/sKAfE63krZ6X8qc6dZRi3/3NZD4tfa/WeyV6JgiSF7NyD2L4K9g5AoGAt3zEuT2cTdG6pvgxlB/HWNkXfq1SBYvyjbXhnSPCgtnKD144Ie5TOLn+/IKZMziTq2MuPdLTQewg5mgzTeLMlT2wfN1aWAue6SxOutAAY4Nhs15T3L3zVMZeGVEkjJJTpr/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by IA1PR11MB6540.namprd11.prod.outlook.com (2603:10b6:208:3a0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.28; Mon, 15 Apr
 2024 04:28:08 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::19d6:5ade:3ea:583d]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::19d6:5ade:3ea:583d%3]) with mapi id 15.20.7452.041; Mon, 15 Apr 2024
 04:28:08 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: Richard Weinberger <richard.weinberger@gmail.com>, Xenomai
	<xenomai@lists.linux.dev>
Subject: RE: i915 GPU woes
Thread-Topic: i915 GPU woes
Thread-Index: AQHajq3zsi2ZmLu9sEGDKKyoZN+YZrFoul4A
Date: Mon, 15 Apr 2024 04:28:07 +0000
Message-ID: <PH7PR11MB74999755B34FF7230FCAE0F8F2092@PH7PR11MB7499.namprd11.prod.outlook.com>
References: <CAFLxGvyY+T1qQTq6gZ5UKfbZsxcan8adyj-Y95BCEA8SYe31=g@mail.gmail.com>
In-Reply-To: <CAFLxGvyY+T1qQTq6gZ5UKfbZsxcan8adyj-Y95BCEA8SYe31=g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|IA1PR11MB6540:EE_
x-ms-office365-filtering-correlation-id: 486a7b01-4562-4906-9432-08dc5d047388
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KlTauQLFPDDgUJKV1f270xhfaBN4JFVU6Enz1DEplnrIEC3dW8kPU0gsmwZOCq9VaiXVm2fVmwJCcPcHgmtpGXEF/xPLdqFz/8/BMYi+ldLR0VdMdVVzrmhsw5fuTmGyf9ReN9r5fyaN1pexKB0ZkTljANpkMmV7cMOIilQ2PPpOTfQaDOvIkhG8GMRAoereUGu4p8m9Tt+3a19WOq52z65EN8/E/v/mKQfyZ8Q0x9CLFyFWv1gWF3uHcfpZHYIq/GNzDPSAiYzc31FQJua/gLkcnKhubFrroHLUyQDEiFoRRaNutTigdAsznTthXlm9RzZr6r/upqSU9FY+R6ELbOzPAGAvbDNQIZKZMz1BjaHNhUiiWGycFzrN9b7QNVkBUMVgPc7D9lHGfiTEk9v1Ops26zMXE7c8ohlyUtBCp91eux7OcQE1eUTd1kDHe3ComeHYxR8Hk64twL4+yisQnDAUjudepP5zRHpYr/d8T4D1QnbwgPoNiorykknvtbGr45/eMsboPXyW/huPnFDN4fRJiQdZbeGQkn7J/A1WnH5FEjpkDtWh9Pw3s8HmlWeikq2n5PHGfHMUUEzH0ROkfGbQI6F/fAg3HKRQ9e0RxZjGPYF/uKXwq/qETef3uo/Ng0iAzEswh1eDhX51/PPgkt9Kdh9eR++DHZmr0BWqfni1Fv4QkKU9+pAnYleeQ0mk2WsVA+y//YKst0GtulqtqA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmVyK3kwTjBra0h1UFpabk5WcHI1YnNoaXA0dFRJN1Fsb3VwWVVLYXdENVBr?=
 =?utf-8?B?T1hmS3E1dzArT3FoT2YwblRVSEtEU3JZYnQwdXd2VUhnbG1XdWhkcURla0E0?=
 =?utf-8?B?T3RRSXArL1pUcXVZTEg0RmpXZ2htalFSRytMRTA4em1WWC91YnM5UFE4YjBN?=
 =?utf-8?B?YVN5TU9aNmgyYmJya212RTBlUXQvL01LNURKS1QxRm5JMU10dmM1QWxPN1hC?=
 =?utf-8?B?d1ozUnZPLzZTekoxSW9Ob25xVUJHakkyYnJQZHZBdktqcHFueEd0dC9sSFBF?=
 =?utf-8?B?Qm0yajJOMjE0NWdVd2JsZjRCNnhkNituMi9iZ1Y2c1ZsYU1LM0tCTkhLMW9B?=
 =?utf-8?B?aWRmQUNLQ0k3ZlpwT3A4dnRWTkV6em5aaDRXZ1dDblVsVit0UE9abVp1amk2?=
 =?utf-8?B?NW1lcGNZZFVlN1NrRU9oRkVYcHpXUWVTdGFSUjc2QlBxd2YyK2dINlZISWl3?=
 =?utf-8?B?UjZvMlQ2TlprM1NmbFZFRzQ4aVFyYkRQNnJKOE43eXlVdTRYK1d2N2N5K0Fs?=
 =?utf-8?B?dFpiS0RWZ29RR0Vsd3c2VFlhVS9EUnBVNnlXZTBaRHFoS1lNdndiNzF5UXJT?=
 =?utf-8?B?dDl5eHl3QzE5Z1hteHc4dndtcXovZEU1bmRRZGV0K3hubnhKcFQ3QnNZVWRr?=
 =?utf-8?B?ZEJIeGVJTmRKWC96bWRkblZkZ3hjN1dxWWpFbE91YUJ2UzBQeGpNcnlVd2JJ?=
 =?utf-8?B?TzNEWWptcWwvOU11djFzcTluL1hBZStHTjJhcDhEL0xxQmNabnhqSFBuUTcr?=
 =?utf-8?B?R0IzbU1zNnVaUHFQOHlwejZNNUJEZTQ3MTV0eDdEVDlsc0VrY2VxTWNrZXJ5?=
 =?utf-8?B?a0xJUXlhanZuenUyc2JZZll3RkM5V3JUcDJuOGtySUVUd0JrQXlFZDg3dXN6?=
 =?utf-8?B?VXNWdkI3ZUhCNHJKSDltVTU3clFVaUNhNVN5WkwyNStmU0Q4S1RUc2t2MGRD?=
 =?utf-8?B?aWtoeTFBSkdsQzdDK3V6UlovV1RpS2dTdWJheHg5VUlTSit5d0E0eCt6WWhF?=
 =?utf-8?B?Tjl2YjVaMWZFcW9jeDY1MHgzVzRHUDlNc3lIaFUxT1Z0OTFwc1V2N1dsUWNs?=
 =?utf-8?B?RTRVOERKM1ViSjFIVFpBNDdjS0NEcUNnMTBaMmtQd2ladTFWVUlsYXRndlhS?=
 =?utf-8?B?clVyY0ZZZnljWVFUVVFkM0RYZmN0VTM4ODA4Ykppd1JHU0x5dE5uRk1QSmpU?=
 =?utf-8?B?RWQxcUU4TFBmZ1MreWkwdnhQd3hVL2lUbitxVzVUMDhaRmlPc1BCSHVJUC9z?=
 =?utf-8?B?L3JOaWtrOWtLcG9WYmE1U0FYQU5tVGQ5RUJlR3IrVHl5dWRkRkgxaWhwdGt4?=
 =?utf-8?B?cDNma1dHZkpGVkZJemdjeFFja2ZMeWM5WlN3aDJkdHVYVHd5YTMyaG03Qk51?=
 =?utf-8?B?VkFKdzdYc3ZXSjZiT2ZWMzBYQXcwNXFVR3Y5ZjlLdlZhZVRuN3ZtS0NKWXhV?=
 =?utf-8?B?UlY1M3YrOGdEdXp3WXhzSEdCaFhFK1RYV0NxSGpHOFNnWHRPQ2o4SFNVNnpN?=
 =?utf-8?B?cHI5b0xQR3hpb2dsdVFDVUw0WlBCd0wrMVcweDl3YXhETm5GdWg3WW5KRnpV?=
 =?utf-8?B?ZVVnampMWktMekhBSFhvTmJUR2lNYy9QaGtwWkZva1hLMEFweGRVZkdTQ29M?=
 =?utf-8?B?YmFQM1Q5SDhmTWNiY2FMR2JCZ3UvQ0g3L2ovbzlQZHpnTndyd254Ly9FT2FY?=
 =?utf-8?B?b2lPSzRyaG5hYlR1SWFQU3VpUkp2SHAvKzVCditsNWZCWWlCQytBakxlRFJO?=
 =?utf-8?B?RFQvdUdiNHpUQ0dOVUs0RWttOTVpZi9kak5GYVdEZjBKYWtkN2Nvbi9CdE9l?=
 =?utf-8?B?VXFEaUltL1VDRDhoaEZ6L0Z6RkpQMjhBQUVmSDVCb3hsUWlGejJSUE9zSHNZ?=
 =?utf-8?B?NUNZb3pONVpONUhYNWNXVEdwMVJjdVYzTmwzZmRlei9nT2tobzJHTTE0ZFVn?=
 =?utf-8?B?emtVa1ljS1IrZTNCd01PZVpnQks4eFZlT3VjVnR2Rkt2QnBFVmFaR2pqN0hr?=
 =?utf-8?B?WHpDSDlvSmNFZjhzVldYZ1R3UFdJbmpaZFpyYkFodHNzY2NIWWlpc1cySWNs?=
 =?utf-8?B?YnlKUlR1LzZmckFwT3NYTm0wSENpOHZOZlNucTI2OUtjUDlGL0VWNlc2OHo2?=
 =?utf-8?Q?Kxkd4mHK20LIf3RBdR/Te9/7q?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 486a7b01-4562-4906-9432-08dc5d047388
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 04:28:07.8896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ij09e2pSdZT4v3rOnMnCdldl0uy64y5KZRvDxVkDLCfd5cAmFZr1/j2UgQJezoy7ZVUC7WtqjosPH2lN/l7qJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6540
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFJpY2hhcmQgV2VpbmJlcmdl
ciA8cmljaGFyZC53ZWluYmVyZ2VyQGdtYWlsLmNvbT4NCj5TZW50OiBNb25kYXksIEFwcmlsIDE1
LCAyMDI0IDQ6NTQgQU0NCj5UbzogWGVub21haSA8eGVub21haUBsaXN0cy5saW51eC5kZXY+DQo+
U3ViamVjdDogaTkxNSBHUFUgd29lcw0KPg0KPkhpIQ0KPg0KPk9uIGFuIEludGVsKFIpIENlbGVy
b24oUikgSjY0MTMgNC1jb3JlIHN5c3RlbSwgSSd2ZSBvYnNlcnZlZCB0aGUNCj5mb2xsb3dpbmcg
c3ltcHRvbXM6DQo+DQo+QXMgc29vbiBhcyBhbiBYMTEgYXBwbGljYXRpb24gcmVkcmF3cyBmcmVx
dWVudGx5LCByZWFsLXRpbWUNCj5wZXJmb3JtYW5jZSBzdWZmZXJzLiBJbiBzdWNoIHNpdHVhdGlv
bnMsIHRoZSBpOTE1IElSUSB0YWtlcyBiZXR3ZWVuDQo+MjAwIGFuZCAxNTAwIG1pY3Jvc2Vjb25k
cywgc2VlbWluZ2x5IGJsb2NraW5nIHRoZSByZWFsLXRpbWUgdGhyZWFkIGZvcg0KPmFuIGVxdWl2
YWxlbnQgYW1vdW50IG9mIHRpbWUuIFNpbmNlIHRoZSBpOTE1IElSUSBpcyBhKSBvbiB0aGUgTGlu
dXgNCj5zaWRlIGFuZCBiKSBwaW5uZWQgdG8gYSBkaWZmZXJlbnQgY29yZSB0aGFuIHRoZSByZWFs
LXRpbWUgdGhyZWFkLCBpdA0KPmRvZXMgbm90IHNlZW0gdG8gYmUgYSBzb2Z0d2FyZSBpc3N1ZS4N
Cj4NCj5XaXRoIGV4dGVuc2l2ZSB0cmFjaW5nLCBJJ3ZlIG5vdGljZWQgdGhhdCBib3RoIHRoZSBp
OTE1IElSUSBhbmQgbXkNCj5yZWFsLXRpbWUgdGhyZWFkIHN0YWxsIHdoZW4gYWNjZXNzaW5nIG1l
bW9yeS1tYXBwZWQgSU8gKHRoZSByZWFsLXRpbWUNCj5hcHBsaWNhdGlvbiBkcml2ZXJzIGFuIEV0
aGVybmV0IGNhcmQgaW4gdXNlcnNwYWNlKS4NCj4NCj5JdCBhcHBlYXJzIHRoYXQgdGhlIEdQVSBp
cyBkb2luZyBzb21ldGhpbmcgdGhhdCBkcmFtYXRpY2FsbHkgc2xvd3MNCj5kb3duIE1NSU8gYWNj
ZXNzIGFjcm9zcyBhbGwgQ1BVIGNvcmVzLiBXaXRoIGdyYXBoaWNzIGRpc2FibGVkLCB0aGUNCj5h
cHBsaWNhdGlvbiBydW5zIHNtb290aGx5Lg0KPg0KPlRoZSBmb2xsb3dpbmcgaTkxNSBtb2R1bGUg
cGFyYW1ldGVycyBhcmUgYWxyZWFkeSBzZXQ6DQo+aTkxNS5kaXNhYmxlX3Bvd2VyX3dlbGw9MCBp
OTE1LmVuYWJsZV9kYz0wIGk5MTUuZW5hYmxlX2d1Yz0yDQo+aTkxNS5lbmFibGVfcmM2PTANCj4N
Cj5JJ20gY3VycmVudGx5IHVzaW5nIFhlbm9tYWkgMy4yLjQgb24gTGludXgga2VybmVsIHZlcnNp
b24gNi4xLCB0aG91Z2gNCj5JIGRvbid0IHRoaW5rIHRoaXMgZGV0YWlsIGlzIHZlcnkgc2lnbmlm
aWNhbnQuDQo+DQo+RG9lcyBhbnlvbmUgaGF2ZSBzdWdnZXN0aW9ucyBvbiB3aGF0IGVsc2UgdG8g
dHJ5Pw0KDQpXb3VsZCB5b3UgbGlrZSB0byB0cnkgdG8gbG9jayBHUFUgZnJlcXVlbmN5IHRvIG1p
bmltdW0/DQogICAgICAgIGZyZXF1ZW5jeT0yMDANCiAgICAgICAgZWNobyAkZnJlcXVlbmN5ID4g
L3N5cy9jbGFzcy9kcm0vY2FyZDAvZ3RfYm9vc3RfZnJlcV9taHoNCiAgICAgICAgZWNobyAkZnJl
cXVlbmN5ID4gL3N5cy9jbGFzcy9kcm0vY2FyZDAvZ3RfbWF4X2ZyZXFfbWh6DQogICAgICAgIGVj
aG8gJGZyZXF1ZW5jeSA+IC9zeXMvY2xhc3MvZHJtL2NhcmQwL2d0X21pbl9mcmVxX21oeg0KICAg
ICAgICBlY2hvICRmcmVxdWVuY3kgPiAvc3lzL2NsYXNzL2RybS9jYXJkMC9ndF9pZGxlX2ZyZXFf
bWh6DQoNClJlZ2FyZHMNCg0KSG9uZ3poYW4gQ2hlbg0KPg0KPi0tDQo+VGhhbmtzLA0KPi8vcmlj
aGFyZA0KDQo=
