Received: from redirect.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD321803A
	for <xenomai@lists.linux.dev>; Tue,  5 Mar 2024 05:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=217.70.178.232
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709615021; cv=fail; b=LyGeQnL92ZNebalVS+dupOat5U0Sc0Ka7dL9296y/T+tG0EPqx2X+j283hkDJMmIEenGwKEShdAEfUJRx4GE7JLbFOReH8A7X3FyndkbSKGIjbRF/uK67FfqXlE/aSa2bnZLKPAI8bXsHYQHNg9NAst/28rLDWd/HTWa5LHSJjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709615021; c=relaxed/simple;
	bh=VD0ZNtZn+bGBV74TpAR7wyr5Cq7IuiMqB30Aj+R+2Ac=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WV2XPbOjZALTBkp2fM5fwZzQbNyrO2cNqVIq52bMX9GAi83GBHHHHz7wSBt/7Y+7b+bee7vxfJejvDy3cvPTEmoYarjjqFbkCMxNm67JgcbZF0Olh/Gp5eVrA/fovnC7yrr9Q4gDjKj1XY86jyMxn6TLjW0DIF3gR6avCYn+QGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nqu2bie+; arc=fail smtp.client-ip=217.70.178.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nqu2bie+"
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay12.mail.gandi.net (Postfix) with ESMTPS id 4E587200005
	for <xenomai@lists.linux.dev>; Tue,  5 Mar 2024 05:03:34 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 96C0B941154
	for <xenomai@xenomai.org>; Tue,  5 Mar 2024 05:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709615013; x=1741151013;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VD0ZNtZn+bGBV74TpAR7wyr5Cq7IuiMqB30Aj+R+2Ac=;
  b=nqu2bie+OfcT/32TXgbjDa8rc149SL8irrvcQHG+hUZhKrBrZTQiR9vM
   4J2dUOb4bq0v9RcKoTPRE/IzPkDMGNx7aSEhX0YrMKnOoelprTklX2VX2
   amjR0SQFPGm65hc39vt6wjVC30+rIr8t4MyobdUueUiVpX1tZrTGcC7JQ
   0fts2sw4Uew1L+To0Fd0qbWR7QRbEesxG+0kWid5fpY5cnrjV9HiFheDA
   BfcVWiFZC4uqrb6fvZXEI7eyPWRaqJ/i/LTL4Z7PQISgs8OJOeuqyVz5y
   5EDfe0YZGp/xV3ylp8Ku7v3qidI8Aj0DFSDMnYEaAS4LPkKWOEGcL9lw8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4003311"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4003311"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 21:03:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="9192111"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2024 21:03:28 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 21:03:28 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Mar 2024 21:03:28 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 4 Mar 2024 21:03:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsBpJSu9Gyn2jIBe6CdK5SB1ePbBNiplkZBwp2Kp86gkb5Q4VyqhE8EMCNFzWqC3RfNQOqt8EUjOm8aMsRjE6IYqYHWFpWg7Q48CMtd5sRcIH2l43lYqA76xY1DXSSfsYNz0jK+Wlpr5NUnAlQ6/9j0cJfyCA1bG2WIbaAcUgeY84Lr24dkoWEhWaD5efM0ZxQbSRSLScIPPcfiAydeSsqIAp3ykMfkvf/o+mCa0Yrrt4pKe9dgQIqHlRoBIyiAvuiysMvs7f111Qp5uPDF1cme/Gfh/nXOkH0zeT+JyJY7LlCQVFOGUdTj+y9AZkSfo93WppRGENbx0sdExE8+d4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VD0ZNtZn+bGBV74TpAR7wyr5Cq7IuiMqB30Aj+R+2Ac=;
 b=JJd3Sa03bn7p1bQ+Mzhc50/5tGQVevHT5V2kKvWOLD1mIBOlzf0cJYCO1awgtng8JwTge4l6s0fAp9eMPQb9gDMgJXduxU/p25PZXZmgmvOEXn4+XIbtnWSjof+nhr9REaBVtm4Ayv9Tmp3aGD4EoDuSfeGsezUbJdQ/u3yoRcsBqQrYxkfP2T2qrWE1UHAjBqI1YW7z+te2k5kmXQLdHiWJvM2SjjfnrtIBh9hc1fFze3wq2SbX9dvh2SkQ/WLFuTSEN6nxZ+IjgmvBYLVFvV4XiRXnzHVoiR7QZnTnA415LWi6IDVMdBPSjbvndI52F3JoMDO7s0CsWqZPvT4+vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by MN2PR11MB4743.namprd11.prod.outlook.com (2603:10b6:208:260::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.23; Tue, 5 Mar
 2024 05:03:25 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::16d:5f07:19bb:6900]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::16d:5f07:19bb:6900%4]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 05:03:25 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: Pierre FICHEUX <pierre.ficheux@smile.fr>
CC: xenomai <xenomai@xenomai.org>
Subject: RE: DYNAMIC_FTRACE and I-pipe patch
Thread-Topic: DYNAMIC_FTRACE and I-pipe patch
Thread-Index: AQHabo34hokV5CaVXk6scU481XjucLEoVDjQgAA8uACAAAT2wA==
Date: Tue, 5 Mar 2024 05:03:25 +0000
Message-ID: <PH7PR11MB74990E278E333490012A9ABEF2222@PH7PR11MB7499.namprd11.prod.outlook.com>
References: <PH7PR11MB74998DAE5D29AB428EAC3BB9F2222@PH7PR11MB7499.namprd11.prod.outlook.com>
 <1591F599-3AF7-4BEE-9742-56DBCD4DADAF@smile.fr>
In-Reply-To: <1591F599-3AF7-4BEE-9742-56DBCD4DADAF@smile.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|MN2PR11MB4743:EE_
x-ms-office365-filtering-correlation-id: 840658aa-4c8f-4569-fa7a-08dc3cd1969e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PE/Bi/TgAgu9p52Zl/T+GdG5N9bwYcX9rwP83HMjENxJs7LQzbdO4EXfjUOwxT5twb90pRuLVFVhneOyRYhkxOtWpC3XBvPPResGL0q73Egv9Y/ahZNlfYTwtLp7oiU9Xv7a584HnlBgn3EmczNjRwqPYPGtYRZxgv56XuneKT9g6jkZndOwUUqvUGeHKqX87Y2BHrNa5ZmNWj1hsn6wbTZsvLyNLmgtGaFzui6ojzZjO+11aJEvubUD/7fKGNcFYVDxymRl45g6yd2zDtQA32HtRro1LMqLW0d3uP9DTgotBitflMRwXezdwpVmUNW22nyWKK8I5P9IpyMPFykI7dkzB1hMrQIT/zpi2SedzYQXVOSRguiqzhRKeHnIwZI9N27F/L5SUv3VpJu9mPDo9lnSCixNmIbwKqZn2B5v4O9PQwoq6MPYJHT3j8G1LLzd4o4cteJco2IqGQArNd2QFr8KXu4iNQ6UOOp0vCcNkGV9u1jnCAvTs1C7NDy7uRnlFKoY/eH66DIX+7uAd33C2URBuEgaCRq7Iad7Kac/kPLA7yb10rRhD0ms9MV7jcwDc9NVVDsQzbH1QtdHiq4luQhrkN/LpAKgy7maYsxLq9vr1xZd9QmA2qqNOp28tjt0YRewSvocLc6fNEOGsplI9eClLOYST6mdus3M4ByZb9dVJtyTB69bks+Tg8yA9ZYG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGoySEhvUUdnc1E3ZGMwbnpkVEwxcEp4RlhvS3pSdVJmZVBqRW8wNWQ3WTZu?=
 =?utf-8?B?NkQrUkI1UzdjV2ZWc2FjSGNQMXVZdklkZVlud1NIWm9GU0RCOWJiN2hOVExG?=
 =?utf-8?B?MFZhbXNYN2RPYW4vdEZHeEpqT2JHa1l6SElrR01oYzJyc3dVU1hjMXhsN0NU?=
 =?utf-8?B?TkNjbkRpR1NYVDE0OVZQOVFIQ3B3bDFVcXNkK2hEQS9qd2YxTXJWWVJTOFI4?=
 =?utf-8?B?bHpZc0ZsSDlZSCtFRnZJMysyczZLSzhEd3J3ejMrMGpGczFacDhKeGlmUVln?=
 =?utf-8?B?aTRxMlBwbDE1YXFOOUYrNDdzcG9vMURGVTdhV2JmUmV3VW9Nd2ljNkhpY0cr?=
 =?utf-8?B?cXBSeW95ZG5QVVN3SG9HRkVqTzZFcnlrRjdidEtvdHhpQTBaTFlWdUZPcnE0?=
 =?utf-8?B?WDZKVXpBTDhhQmZ3S2FtdWRVNzIzU2IyMkJjZlprNmdxMS9nRUNrZHcxc3c4?=
 =?utf-8?B?bFY1MmxSR3VXWVdJRWRHWWJCaWUvQyt0aWNQNTROaEdFMk1CdFJ0eWJPajZR?=
 =?utf-8?B?MW9yaFZOaXVIaXNLMzVqTXhISTdLc1NVdlRmT2tCT3JWRndCd2N1V1VwTmJh?=
 =?utf-8?B?WGVZVExhSXFaYkpHMEFsblh4UjI3RENtaFdQU28wSXJuaFUreUJaRU16LzI2?=
 =?utf-8?B?dnlXZHU2NFB6dXE1SHcxVmVUamp3SXVldFBkQVg5bGJzNm5oOWJCVHVOWkU4?=
 =?utf-8?B?K2pveW15dGRxWVMwSFhtTHhHcEJTeUZsdGpFSjFOTXpoYUxxZEZKb00rc0lQ?=
 =?utf-8?B?OVFjVjZjMzVyUGpjUllZcDZENVhrOHRBRmxzUG02UWNvR3FpRjFNT3FWVHRm?=
 =?utf-8?B?dTJFTEhBV1hTUmN5QTluOVJYeHkxbFk2K1pNcXBIdUEzZzNZb01DbUtsZ2Ur?=
 =?utf-8?B?bGVDSEl4VHZ3WVh6MVRtcDkyM0lqTGFoRjZvYWI5V0EzbGk1TEg1bUVDM0E1?=
 =?utf-8?B?OGN4WE5tVlMrL0pKR0tCNnMyM1FQcHVaRFUxaUU1bWVTTk9lUDN6WnFoeGF1?=
 =?utf-8?B?N28xbGdUZHFkQ0plRnFoYUZZOHc3b2drUEN1L2hJczVLV0tEVjBTQjk5TTk0?=
 =?utf-8?B?c0FyWjhacEljczIwSlk4SW5tcW5GM0ZCMUZhNzgzVFBRa2lxWmhJZ01OMU5G?=
 =?utf-8?B?dmNTMVo5MVJmZXdjYzBnbTZJL1dudWJhZGVwcS9yUmp5SUF6c2U0bE1oTi93?=
 =?utf-8?B?a2pmMXoyQ1hBeXAyUkdTOVd4NVVVZm95U2lhQTUzOGpiQXdOYVN1MGY2UnFF?=
 =?utf-8?B?SUl3MHFMdnR6bUlYL05Eb1pXSFpQZk5DT0xKVGw3SUJQNjMweVdxZVpDdjYr?=
 =?utf-8?B?Nm9LekgzN2c5L24xQkthL2NqWFlHaC9vWnFIUm1WRlNGclJnelhhUEVNVUth?=
 =?utf-8?B?VUloYXNUUXFoaVQvcGFzZEhyYnNiL3E4bmM5Szdaa0hZMHhDL05CZTNab2lk?=
 =?utf-8?B?ZE8yeUZZTStSZnlBRzVDUm9nQmpydTRGdkVJYmVWc093Z1lvWjNkbVF1MHZp?=
 =?utf-8?B?ZnFHa1dodlJKNktldytTTGZjOGhEKzdPdEdLanFVbS82UFY4eVhRQlVqL0ZP?=
 =?utf-8?B?RE5zNno2UnJ4dUpncFJOZzVXemkwank5VE42SW9kTkVWc3VmNXVPTmtRQlVs?=
 =?utf-8?B?SFRvRSt5V1kyTTljZm91NUNJSnJvWkRYTzMyR0x5ZGUyaElmZjhVYWxpaFFs?=
 =?utf-8?B?azgyUXNqOEM4RCtZdllwWTBrN2xYb204Y1A3WlA0UXhBVnBNT0praG9OVW5m?=
 =?utf-8?B?VCtDV2lNRnc2SGpFYXFMdFpuSDRCNWI5U2VDb3JxS2ZnTmd2VEtaTC9vRUFO?=
 =?utf-8?B?NE5uMm9QZUxBZUZSZTczTWU2VnJWTEFVcFkrT1hRei90OHhEZXdyb2ppVjBa?=
 =?utf-8?B?aTZocGxLQUpickZ3aHhyMjRicjRycDE0TmdDS0o2Vmd5ZytxVUFPcXJ3TWRK?=
 =?utf-8?B?M1JkWnRhS2sxaHNDOHpQSzdiekVNeTdkblpXTUc1dWlaSGluZ1k4UlVISkRY?=
 =?utf-8?B?WlEwd1k3WXNWc2hDcnhzb09KUGVRNkxmaHpGc0pHQy81WW91cDlOMUtNdzhO?=
 =?utf-8?B?a0dPbjc2ZGIrNi9wbWdBazdXcWFlOExlOHUwOURJWjFKb3ZnZUJsbnU5ZGlR?=
 =?utf-8?Q?PytnKjZxi2dVNed5L0dca3onj?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 840658aa-4c8f-4569-fa7a-08dc3cd1969e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 05:03:25.2097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Km5dufTNJFUjbSD4IDGzkjGc950inYee4T3hBdKVyB+4/bhE5Gd9X/IIntMzMSJw8CdubXcC21HAVd6yhy3jqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4743
X-OriginatorOrg: intel.com
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=intel.com header.s=Intel header.b=nqu2bie+;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (spool.mail.gandi.net: domain of hongzhan.chen@intel.com designates 192.198.163.17 as permitted sender) smtp.mailfrom=hongzhan.chen@intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFBpZXJyZSBGSUNIRVVYIDxw
aWVycmUuZmljaGV1eEBzbWlsZS5mcj4NCj5TZW50OiBUdWVzZGF5LCBNYXJjaCA1LCAyMDI0IDEy
OjM5IFBNDQo+VG86IENoZW4sIEhvbmd6aGFuIDxob25nemhhbi5jaGVuQGludGVsLmNvbT4NCj5D
YzogeGVub21haSA8eGVub21haUB4ZW5vbWFpLm9yZz4NCj5TdWJqZWN0OiBSZTogRFlOQU1JQ19G
VFJBQ0UgYW5kIEktcGlwZSBwYXRjaA0KPg0KPkhpLA0KPg0KPllvdSB0YWxrIGFib3V0IHRoZSBJ
LXBpcGUgdHJhY2VyPw0KDQpJIGFtIHRhbGtpbmcgYWJvdXQgdGhlIGlzc3VlcyB0aGF0IGRvdmV0
YWlsIHdhbnQgdG8gYWRkcmVzcyBhcyBQaGlsaXBwZSBkZXNjcmliZWQgaW4gdGhlIGxpbmsuIFRo
ZSBEWU5BTUlDX0ZUUkFDRSBsaW1pdGF0aW9uIHlvdSBtZW50aW9uZWQgd2l0aCBJLVBJUEUgbWF5
YmUgb25lIG9mIHRoZSBpc3N1ZXMgdGhhdCBkb3ZldGFpbCBhbHJlYWR5IGZpeGVkLiBUaGF0IGlz
IHdoeSBpdCBpcyBub3QgdGhlIGNhc2UgZm9yIGRvdmV0YWlsLiANCg0KUmVnYXJkcw0KDQpIb25n
emhhbiBDaGVuDQoNCj4NCj4tLQ0KPlBpZXJyZQ0KPg0KPj4gTGUgNSBtYXJzIDIwMjQgw6AgMDI6
MTMsIENoZW4sIEhvbmd6aGFuIDxob25nemhhbi5jaGVuQGludGVsLmNvbT4gYQ0KPsOpY3JpdCA6
DQo+Pg0KPj4gDQo+Pg0KPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4gRnJvbTog
UGllcnJlIEZJQ0hFVVggPHBpZXJyZS5maWNoZXV4QHNtaWxlLmZyPg0KPj4+IFNlbnQ6IFR1ZXNk
YXksIE1hcmNoIDUsIDIwMjQgNzo0NCBBTQ0KPj4+IFRvOiB4ZW5vbWFpIDx4ZW5vbWFpQHhlbm9t
YWkub3JnPg0KPj4+IFN1YmplY3Q6IERZTkFNSUNfRlRSQUNFIGFuZCBJLXBpcGUgcGF0Y2gNCj4+
Pg0KPj4+IEhpLA0KPj4+DQo+Pj4gT25lIG9mIG15IGN1c3RvbWVycyB1c2VzIGEgNS40LjcwIGtl
cm5lbCB3aXRoIGFuIGlNWDhNIGJvYXJkIGFuZCBhDQo+Pj4gY3VzdG9tIEktcGlwZSBwYXRjaCAo
d2l0aCBYZW5vbWFpIDMuMSkuIEl0IGxvb2tzIGxpa2UgYWxsIHRoZSBJLXBpcGUNCj4+PiBwYXRj
aGVzIGRpc2FibGUgdGhlIERZTkFNSUNfRlRSQUNFIG9wdGlvbiA6DQo+Pj4NCj4+PiBkaWZmIC0t
Z2l0IGEva2VybmVsL3RyYWNlL0tjb25maWcgYi9rZXJuZWwvdHJhY2UvS2NvbmZpZw0KPj4+IGlu
ZGV4IGYzZjJmYzhhZDgxYS4uOThkN2M2NGI3YjhmIDEwMDY0NA0KPj4+IC0tLSBhL2tlcm5lbC90
cmFjZS9LY29uZmlnDQo+Pj4gKysrIGIva2VybmVsL3RyYWNlL0tjb25maWcNCj4+PiBAQCAtNTMy
LDYgKzUzMiw3IEBAIGNvbmZpZyBEWU5BTUlDX0ZUUkFDRQ0KPj4+IGJvb2wgImVuYWJsZS9kaXNh
YmxlIGZ1bmN0aW9uIHRyYWNpbmcgZHluYW1pY2FsbHkiDQo+Pj4gZGVwZW5kcyBvbiBGVU5DVElP
Tl9UUkFDRVINCj4+PiBkZXBlbmRzIG9uIEhBVkVfRFlOQU1JQ19GVFJBQ0UNCj4+PiArIGRlcGVu
ZHMgb24gIUlQSVBFDQo+Pj4gZGVmYXVsdCB5DQo+Pj4gaGVscA0KPj4+ICBUaGlzIG9wdGlvbiB3
aWxsIG1vZGlmeSBhbGwgdGhlIGNhbGxzIHRvIGZ1bmN0aW9uIHRyYWNpbmcNCj4+Pg0KPj4+IFRo
YXQncyBub3QgdGhlIGNhc2UgZm9yIGEgcmVjZW50IERvdmV0YWlsIGJhc2VkIGtlcm5lbC4NCj4+
Pg0KPj4+IENvdWxkIHlvdSBnaXZlIG1lIHNvbWUgaW5mb3JtYXRpb24gYWJvdXQgc3VjaCBhIGxp
bWl0YXRpb24gPw0KPj4NCj4+IE1heWJlIHlvdSBjYW4gcmVmZXIgdG8NCj5odHRwczovL3d3dy5n
b29nbGUuY29tL3VybD9xPWh0dHBzOi8vc291cmNlLmRlbnguZGUvWGVub21haS94ZW5vbWFpLy0N
Cj4vd2lraXMvRG92ZXRhaWwmc291cmNlPWdtYWlsLQ0KPmltYXAmdXN0PTE3MTAyMDYwMDQwMDAw
MDAmdXNnPUFPdlZhdzBJWEhxemVvcnVIZXU2bG5oWWNQUXcuDQo+PiBJdCBtZW50aW9uZWQgIiBU
aGUgSS1waXBlIHByb3ZpZGVzIGl0cyBvd24gZnVuY3Rpb24gdHJhY2VyIGJhc2VkIG9uIHRoZQ0K
PkZ0cmFjZQ0KPj4gZW5naW5lLCBidXQgc3RpbGwgZHVwbGljYXRpbmcgc29tZSBvZiBpdHMgZmVh
dHVyZXMgd2hpbGUNCj4+IHJlc3RyaWN0aW5nIG90aGVycy4iIGJ1dCAgSSBkbyBub3Qga25vdyBp
ZiBpdCBpbmNsdWRlcyBzdWNoIGxpbWl0YXRpb24gSVBJUEUgd2FzDQo+cmVzdHJpY3RpbmcgYnV0
DQo+PiBkb3ZldGFpbCBpbXByb3ZlZC4NCj4+DQo+PiBSZWdhcmRzDQo+Pg0KPj4gSG9uZ3poYW4g
Q2hlbg0KPj4+DQo+Pj4gVGhhbmtzIGluIGFkdmFuY2UuDQo+Pj4NCj4+PiByZWdhcmRzDQo+Pj4N
Cj4+PiAtLQ0KPj4+DQo+Pj4gUGllcnJlIEZJQ0hFVVggLS8tIENUTyBTbWlsZSBFQ1MsIEZyYW5j
ZSAtXC0gcGllcnJlLmZpY2hldXhAc21pbGUuZnINCj4+Pg0KPmh0dHBzOi8vd3d3Lmdvb2dsZS5j
b20vdXJsP3E9aHR0cDovL3d3dy5zbWlsZS5mciZzb3VyY2U9Z21haWwtDQo+aW1hcCZ1c3Q9MTcx
MDIwNjAwNDAwMDAwMCZ1c2c9QU92VmF3Mlg1UXlvU0xyTWZPb25rR0JTelg1Yw0KPj4+DQo+aHR0
cHM6Ly93d3cuZ29vZ2xlLmNvbS91cmw/cT1odHRwczovL3NtaWxlLmV1L2ZyL29mZnJlcy9lbWJh
cnF1ZS0NCj5pb3Qmc291cmNlPWdtYWlsLQ0KPmltYXAmdXN0PTE3MTAyMDYwMDQwMDAwMDAmdXNn
PUFPdlZhdzNOMXQxQjFRbFp0NjhEQTZNWWJpUUoNCj4+PiBJIHdvdWxkIGxvdmUgdG8gY2hhbmdl
IHRoZSB3b3JsZCwgYnV0IHRoZXkgd29uJ3QgZ2l2ZSBtZSB0aGUgc291cmNlIGNvZGUNCj4+DQo=
