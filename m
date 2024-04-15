Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301E1393
	for <xenomai@lists.linux.dev>; Mon, 15 Apr 2024 04:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713155900; cv=fail; b=VtSc2o7B8EIqdSmyxay38AVGJG/J0Wotj0xZsC9WzN1aH2PxAPQ83/2bxFAqD5T+pZjX+I11mBw81x7cXqUCHSPP6dGTyGd5EUPqXpz9vU+OKipavXLJW7t83FwJPDPLQYI9jJ2nACNmbnr44BhrWjVdf8pxuyylh1mYeBRB9zI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713155900; c=relaxed/simple;
	bh=ACpS75DteOr/CLEr4SdDRoO8z8BlqFEvVjzt8zBOjEA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BDHEhtUYyXOvxBLWtu0CeGDqdYcWGUBMZIiG7oG99TUPqnC+12E85XV0wwpm/wqa7F/oDAeaWGxX0OUIxJOnZ9/aA0PcfNXa7pH5VbBx7k2OB/tNfO5Xw/reNu7sy3KHz8u3U02A4i2VF0LGciwcsB+Trr3WohuezVCT089T9AE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=buWXtgTS; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="buWXtgTS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713155898; x=1744691898;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=ACpS75DteOr/CLEr4SdDRoO8z8BlqFEvVjzt8zBOjEA=;
  b=buWXtgTSFTT5B+S6Ront9PSxyVkqR8ktD+2TSZLxjQMXRIGLWU/TeA3R
   xv3/CqFMcXFrTtsDEX8ZYy9rouY9MbBTowlJuVVbXEe1VtZHiw3EZwGcU
   iizCDNIVxY0cdBk20iot9bRm5HxDIFkUh49LF61oYjLFF9T6IR1NDeKrN
   kCPWQrs4JXBsT0LDwB9xA4TvvNE9C2cK1vW+CpYPLfScHXHJAyDDA+5Xo
   2/u0qxkk+vPJVjJpk2qOZ+OZKDvZHMxiVIz0HAbdUEd8DV9oQTd54ylLr
   kq/4Q5KuSkQ/hESqR5mzAppm6E10bpSBwNVYBMMpzhfN5CjSfWEx08QZ+
   A==;
X-CSE-ConnectionGUID: vW41NuH7T1mzlfapp0HkCg==
X-CSE-MsgGUID: NUs0m/gbR4SMO7+Z7TY1tg==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="19239856"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="19239856"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2024 21:38:17 -0700
X-CSE-ConnectionGUID: J5w3M/VaSwSyyQHC7pRtrA==
X-CSE-MsgGUID: Jw16t6d1R/CbT0/JBhMaZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="21780949"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Apr 2024 21:38:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 14 Apr 2024 21:38:16 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 14 Apr 2024 21:38:16 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 14 Apr 2024 21:38:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDo8fa9k1MSSDF2e7tkVeSoE4Mc+TcP0yW/0EHPgtSX19NoAAQ+wFPTchOzImaBWn5tpq4j+BpEg9T6iylNzmmKllqLLYFIux8xo1sTahYV1npdyE/8ueAeNB8cvnsTpNfA+9xgfdHr0mZ1QdXNpHZgBns7cfyzRn5wsRlq8O6WxEwLxTGgtNhVmXiH/+SLr/pzAYaQT43Wckc24JIlC26vl1C5qB6Ql0B45ru1XUoJsgJpMg1crElp5oPIi30nu9HnnVQdUGj9aqQWjoqXv+at8z2W+q/QLrYApVBhEIMIJozxCb9EHwbNdvJJDkF3jXf25anNlXKTlWev3C4HNhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACpS75DteOr/CLEr4SdDRoO8z8BlqFEvVjzt8zBOjEA=;
 b=FX7Hvb3XBvQEpiNydt5LEwLL+QmycmXDtNHdvyyuKXspkTgYlMCmmZBwgMWkckU0dpt67fuJMPRQz2oQCryiujogWm1uWxPmbkMq97TqHmiua1xSz7b+00aZbgbwIHYcPV/34SHtQT8vSzGtSbBxh/fOaaWOOvWtIKT8olRQEU+HWQxmSRurFFwgIWCDh7Ns7ed9e9PVzIYuzdifPAWvQ12Fbi97sA1NDwqvTRs/TkbBZK1m2Oux3RKWVgPWAhTObrtvacKo+cDlwvV9Gd71wLsLZNCLDu0eKfmNROShj9SISe7scvtHS9MFd1HBKa6SgIewhHrXTZfgES4/A4KB9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by SJ2PR11MB7518.namprd11.prod.outlook.com (2603:10b6:a03:4c5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.43; Mon, 15 Apr
 2024 04:38:14 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::19d6:5ade:3ea:583d]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::19d6:5ade:3ea:583d%3]) with mapi id 15.20.7452.041; Mon, 15 Apr 2024
 04:38:14 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: Richard Weinberger <richard.weinberger@gmail.com>, Xenomai
	<xenomai@lists.linux.dev>
Subject: RE: i915 GPU woes
Thread-Topic: i915 GPU woes
Thread-Index: AQHajq3zsi2ZmLu9sEGDKKyoZN+YZrFoul4AgAAEapA=
Date: Mon, 15 Apr 2024 04:38:14 +0000
Message-ID: <PH7PR11MB74998A90B5CD2F8E507A20E9F2092@PH7PR11MB7499.namprd11.prod.outlook.com>
References: <CAFLxGvyY+T1qQTq6gZ5UKfbZsxcan8adyj-Y95BCEA8SYe31=g@mail.gmail.com>
 <PH7PR11MB74999755B34FF7230FCAE0F8F2092@PH7PR11MB7499.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB74999755B34FF7230FCAE0F8F2092@PH7PR11MB7499.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|SJ2PR11MB7518:EE_
x-ms-office365-filtering-correlation-id: 422e5dca-afb5-4ea5-36d7-08dc5d05dd10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FGwJfGerbqCdjpfIOhFCFMPfKYHKdaRGEX74QKGE2AnqJgaNxqDQOGWEsvdCQgdppaLXi6GrBF5k85clP6wRom80HXqZKzJqM9GLsMny+KImX6GghqsTyXWyrfN8H1t5lwtKHQJG5fLVM2NnKP5Ix52rOzZSXT9dSC+mz8VDbZJ7C/Mq9xh0p+kLL1OOPs+xfS6KTUrW2jSTwv1j3E+Ewh9FmMuGAsxfnoVMQ3DxInzR7940SoNwZ8YjFueGhX3RKGOikq0Ukp3Ai7um2etkhaiyKA0sYUHCkHQHsxPcdbxcw27w7M8Tk6LF53zQEtyeLAXNv27gnvI/l+L1wNGdDTcLJlZTMORImTVeiSQnOt6D5yxi90yxHlYEaOysxRSV11sNoipDbLT8cZK9eKmoV7NNOjVZ5tMCuWk/QcUc6QHLOFj1RmQeqRtUwKIxmFg50zAhsTx3Fl1qQ22fBpqTRMtr1NbIyW11pNw2rL2zuqA5w8CADRYhAel+jnxcAuFfZHs99BI0zzpX9ehww4kv7dH9XgCFyIZzx/838fSscU3emX6XLvj8+bTnYo5lRdAIsQxPxfwInq0vNLfvaYg1v4BW/Rnns+1gTKanvNeoUvSd1VDn6FNrmI6uG5K+ZbYUI33p+A0Lku+0u7NxwclsH6dg9d8U2rgl9kA2HDGcjyJ7sFIIs8oIOz2hPlZ/F0jV7wJOUst2+fkskGWv1KGFvg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmhHN2ttUzRkUUpOWGtLRnI0RDc5Y1M5OEhPVTRYV3dWRGdXcXhOZVBmQU95?=
 =?utf-8?B?YnlydlhISTJCeXhOTGc0OEFobGliNVRiV012WDV6TEhLNDJQVm9aY3M5UU5i?=
 =?utf-8?B?SnJTWU1KMU5xcVV4cU5wclFOQjV3ZUVmMWdtTEt1blpZOUJBd1pZL0c4ZUcw?=
 =?utf-8?B?MmZKM0ExL0pPcG5JcU5BQXhtQ05XWXpuYlB1Vm9LQ0hma1RmaFZDZlVqd1VL?=
 =?utf-8?B?N2g4ZzUvM015R2NJWlBOV0c5YVhuMjF4VWx4UFB1ZWQ4UUU3SVRzbzBtNk55?=
 =?utf-8?B?RDFUYlY0Z2tWVG5QRVEwdGNKUnJrTThDTEwzT09sYzMrZUdvWnBKMk13UVNM?=
 =?utf-8?B?cDRRY1U2b0RSWjluKzZFTlRHSFNsS3ZCSHNOYVRmbllKSmZybCswWldXRk56?=
 =?utf-8?B?THF1cW5McUYweldTTzk1VTZ2aTJmTWlLMjZPQW9TY3ZEcHJqVzZ2eFNhL005?=
 =?utf-8?B?NFBRR1Q5aUpPVWRGTFFRa0NOY0tML3k5V3RKeHJiMFRGYnpMMXd1VlpsTEdU?=
 =?utf-8?B?NTdNdk9mTFBmbXZ4MGtaQkR6MHBOdkVtSnBZd1JrdFlYekw4V1RJY2MvanNt?=
 =?utf-8?B?ejV3TWhYamdEeElGVzAwUlM3U2dQWmJMeFBwWjdYTnNVMzc3SWpDcklPNHR4?=
 =?utf-8?B?dEt3aEY4aTFFbklrZk5WbmU2TmxRZGpKdjFsZTIyR1hJa3g2Ykg0c052OFVJ?=
 =?utf-8?B?cTZVSTYyVVJFRHJWQ3FJaEZlYmJJSXdxUDRZWk1wUU1rM24wREhhK0UwU1Yy?=
 =?utf-8?B?S3M5WExGMFhFaENZNFgvTnp3U0ZBL2toa1ZkQ0tIS3JEUlNzSXFnSEdHNmV4?=
 =?utf-8?B?cEJjV3RDS3lJNnVvK3NJU0lFSE5FTUQ4VFdpaGdjUzZDaUVucXd6VUZVVllO?=
 =?utf-8?B?UGZrS2pMcFpNWko2SENSTFc5eEhZVnNiSEtQdkRyWVYzTjhvVTVRRlczOTQr?=
 =?utf-8?B?WWZ2T0V5VEVIemszT29Lc1F3emhRSXdrU0FlYmNjNDJFcnRlSnNoZHRsUG1p?=
 =?utf-8?B?YnZlUG93U2k2ZHhyMERGL0V0bE0zcmd6MTlMSzhGVVZ5ZzFkalJuM1I2WjJk?=
 =?utf-8?B?TFFQdU9FcHBCWXA5S2w0Yzhka3Q1ajVzYnhzYmdQNEdNenVBVk8za0NhdVlY?=
 =?utf-8?B?Qi8rV0JOM3hwRGFGTVdqK0RmakdFOERkMHZiUS9Ud1Y4N3NKaStSQWlRRnNh?=
 =?utf-8?B?eTJnZU9Rd1V2alJkTWNYZVpuNmd4VUxvcmFKL0tmUnJxV0VWMW5lSlRIQjBT?=
 =?utf-8?B?VzBzdmh0b0Q4Zm9RYm5NMi9DbERLeEJQenFXc0hYdFBDV1VQVzFiN0VUeHNl?=
 =?utf-8?B?czVvc1JXcXBrYzFFd2dneU8rRkNTQWd6b0d0SnRyaThYOFdUWGRkcDR3VDZM?=
 =?utf-8?B?OVhUWnFCcXFFM04zTUVPMFBaLzBqNGM3NWQxUkhrU1R2dFllb0N1d0RLTzN4?=
 =?utf-8?B?c2ZOM0trMzUvS0NjVFhLdCtUS2MxeHlTY0YwUGkybEdRaUlTY3NHanNiaGVP?=
 =?utf-8?B?UWF5S0ViSVVkOG5OS1U1SElRbGNnSHdKOXdCVE0vODE0S3I2Qy9tRVBmT044?=
 =?utf-8?B?Um4rQ0xoNFVVbGhMZkx5NS9tVE9yRERkcWtBdncvU3pPaGlOWXl2dmI3eitT?=
 =?utf-8?B?MUVITXlLTUx3R3dpbXc0STRwQ1IrMk5GcjF2b2IzYmhBRHZpM3UxRm81NUlY?=
 =?utf-8?B?U1YzR3R0ejZKSm14aldMWEhienhlcWZUemt1OWg1VXB4cVNQaVU1Z1pld2hV?=
 =?utf-8?B?RE5NTEdmQndlSTdudmNvc2RISzF2bHVkK1ZqamQ3Z1g1V3RVdEwvT3ZjSElk?=
 =?utf-8?B?MHg0TEJZMHpKM20vblBoU2RwRjU3L2p3VVE1ejZWRmt2cnJaVktOMjM4Mzds?=
 =?utf-8?B?ZFh4eloyQ1JTdWgvMVNFRkwya3lVQkpXZzNkdXNmWGZxa0NrNFoyRWVRNTdW?=
 =?utf-8?B?a1JaUlRqNTQzeW0zYXhLUzA5anRlVUM5czl3MzJ6aEwwR01YbU1RMEF6UG90?=
 =?utf-8?B?OWRrOTljaGFtUHNrbko3VENLRlFRS1ZYQitCeVpOaGFqMjYxaUN6U0ZHcTAx?=
 =?utf-8?B?amtnNW5YeVEzbHRiaE1INlo0amZINW9EVnF3NER4VTkzVnVVWlVxZk9DZlpN?=
 =?utf-8?Q?dOebZXTGenNlgvO7Y5iQwYMFP?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 422e5dca-afb5-4ea5-36d7-08dc5d05dd10
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 04:38:14.4448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4/RLeNsRCT3MBvZk+DB3bSRKGQG1RVYLdMjyPcdTV4OkqXRou0wON+o1ASebLl3gdnxXwkqLNDIYwwQQos8k4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7518
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENoZW4sIEhvbmd6aGFuDQo+
U2VudDogTW9uZGF5LCBBcHJpbCAxNSwgMjAyNCAxMjoyOCBQTQ0KPlRvOiBSaWNoYXJkIFdlaW5i
ZXJnZXIgPHJpY2hhcmQud2VpbmJlcmdlckBnbWFpbC5jb20+OyBYZW5vbWFpDQo+PHhlbm9tYWlA
bGlzdHMubGludXguZGV2Pg0KPlN1YmplY3Q6IFJFOiBpOTE1IEdQVSB3b2VzDQo+DQo+DQo+DQo+
Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+PkZyb206IFJpY2hhcmQgV2VpbmJlcmdlciA8
cmljaGFyZC53ZWluYmVyZ2VyQGdtYWlsLmNvbT4NCj4+U2VudDogTW9uZGF5LCBBcHJpbCAxNSwg
MjAyNCA0OjU0IEFNDQo+PlRvOiBYZW5vbWFpIDx4ZW5vbWFpQGxpc3RzLmxpbnV4LmRldj4NCj4+
U3ViamVjdDogaTkxNSBHUFUgd29lcw0KPj4NCj4+SGkhDQo+Pg0KPj5PbiBhbiBJbnRlbChSKSBD
ZWxlcm9uKFIpIEo2NDEzIDQtY29yZSBzeXN0ZW0sIEkndmUgb2JzZXJ2ZWQgdGhlDQo+PmZvbGxv
d2luZyBzeW1wdG9tczoNCj4+DQo+PkFzIHNvb24gYXMgYW4gWDExIGFwcGxpY2F0aW9uIHJlZHJh
d3MgZnJlcXVlbnRseSwgcmVhbC10aW1lDQo+PnBlcmZvcm1hbmNlIHN1ZmZlcnMuIEluIHN1Y2gg
c2l0dWF0aW9ucywgdGhlIGk5MTUgSVJRIHRha2VzIGJldHdlZW4NCj4+MjAwIGFuZCAxNTAwIG1p
Y3Jvc2Vjb25kcywgc2VlbWluZ2x5IGJsb2NraW5nIHRoZSByZWFsLXRpbWUgdGhyZWFkIGZvcg0K
Pj5hbiBlcXVpdmFsZW50IGFtb3VudCBvZiB0aW1lLiBTaW5jZSB0aGUgaTkxNSBJUlEgaXMgYSkg
b24gdGhlIExpbnV4DQo+PnNpZGUgYW5kIGIpIHBpbm5lZCB0byBhIGRpZmZlcmVudCBjb3JlIHRo
YW4gdGhlIHJlYWwtdGltZSB0aHJlYWQsIGl0DQo+PmRvZXMgbm90IHNlZW0gdG8gYmUgYSBzb2Z0
d2FyZSBpc3N1ZS4NCj4+DQo+PldpdGggZXh0ZW5zaXZlIHRyYWNpbmcsIEkndmUgbm90aWNlZCB0
aGF0IGJvdGggdGhlIGk5MTUgSVJRIGFuZCBteQ0KPj5yZWFsLXRpbWUgdGhyZWFkIHN0YWxsIHdo
ZW4gYWNjZXNzaW5nIG1lbW9yeS1tYXBwZWQgSU8gKHRoZSByZWFsLXRpbWUNCj4+YXBwbGljYXRp
b24gZHJpdmVycyBhbiBFdGhlcm5ldCBjYXJkIGluIHVzZXJzcGFjZSkuDQo+Pg0KPj5JdCBhcHBl
YXJzIHRoYXQgdGhlIEdQVSBpcyBkb2luZyBzb21ldGhpbmcgdGhhdCBkcmFtYXRpY2FsbHkgc2xv
d3MNCj4+ZG93biBNTUlPIGFjY2VzcyBhY3Jvc3MgYWxsIENQVSBjb3Jlcy4gV2l0aCBncmFwaGlj
cyBkaXNhYmxlZCwgdGhlDQo+PmFwcGxpY2F0aW9uIHJ1bnMgc21vb3RobHkuDQo+Pg0KPj5UaGUg
Zm9sbG93aW5nIGk5MTUgbW9kdWxlIHBhcmFtZXRlcnMgYXJlIGFscmVhZHkgc2V0Og0KPj5pOTE1
LmRpc2FibGVfcG93ZXJfd2VsbD0wIGk5MTUuZW5hYmxlX2RjPTAgaTkxNS5lbmFibGVfZ3VjPTIN
Cj4+aTkxNS5lbmFibGVfcmM2PTANCj4+DQo+PkknbSBjdXJyZW50bHkgdXNpbmcgWGVub21haSAz
LjIuNCBvbiBMaW51eCBrZXJuZWwgdmVyc2lvbiA2LjEsIHRob3VnaA0KPj5JIGRvbid0IHRoaW5r
IHRoaXMgZGV0YWlsIGlzIHZlcnkgc2lnbmlmaWNhbnQuDQo+Pg0KPj5Eb2VzIGFueW9uZSBoYXZl
IHN1Z2dlc3Rpb25zIG9uIHdoYXQgZWxzZSB0byB0cnk/DQo+DQo+V291bGQgeW91IGxpa2UgdG8g
dHJ5IHRvIGxvY2sgR1BVIGZyZXF1ZW5jeSB0byBtaW5pbXVtPw0KPiAgICAgICAgZnJlcXVlbmN5
PTIwMA0KPiAgICAgICAgZWNobyAkZnJlcXVlbmN5ID4gL3N5cy9jbGFzcy9kcm0vY2FyZDAvZ3Rf
Ym9vc3RfZnJlcV9taHoNCj4gICAgICAgIGVjaG8gJGZyZXF1ZW5jeSA+IC9zeXMvY2xhc3MvZHJt
L2NhcmQwL2d0X21heF9mcmVxX21oeg0KPiAgICAgICAgZWNobyAkZnJlcXVlbmN5ID4gL3N5cy9j
bGFzcy9kcm0vY2FyZDAvZ3RfbWluX2ZyZXFfbWh6DQo+ICAgICAgICBlY2hvICRmcmVxdWVuY3kg
PiAvc3lzL2NsYXNzL2RybS9jYXJkMC9ndF9pZGxlX2ZyZXFfbWh6DQo+DQo+UmVnYXJkcw0KDQpJ
biBhZGRpdGlvbiwgeW91IG1heSBsaWtlIHRvIHRyeSB0byBkZWNyZWFzZSBEVk1UIFByZS1BbGxv
Y2F0ZWQgbWVtIGNvbmZpZ3VyYXRpb24gZm9yIGdyYXBoaWNzIGluIEJJT1MgIHRvIGEgcmVsYXRp
dmVseSBzbWFsbCBzaXplIGxpa2UgNjRNIGNvbmN1cnJlbnRseS4NCg0KUmVnYXJkcw0KDQpIb25n
emhhbiBDaGVuDQo+DQo+SG9uZ3poYW4gQ2hlbg0KPj4NCj4+LS0NCj4+VGhhbmtzLA0KPj4vL3Jp
Y2hhcmQNCg0K
