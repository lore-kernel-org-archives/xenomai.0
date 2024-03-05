Received: from redirect.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05071079D
	for <xenomai@lists.linux.dev>; Tue,  5 Mar 2024 01:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=217.70.178.232
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709601207; cv=fail; b=r52L9ZjoMnqkDh3aWq4CCCEXGIMT8iGg+aMMBg7hcOnfJHNRTng9pHWQA6+OMB2OubNaR/MY7Jo2lOWbEo+I4fum/e2WvfYow+HS2QrO1V223LLgNDf6556NzWkuhWtA/cxE+CV/5H4ys0iu4sVXED/zz1yL1zzB/lGvAwpEwkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709601207; c=relaxed/simple;
	bh=E5a7U8bJVHZZfH6LmKq83SNhvMBgnwlKLnUQAQmpW+U=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lhq5Mos6TVV5+ziQmWjef8IN9YmlIjNu1HTHmZ8Q5bIVeiL5FtKdr70X73n1EaNXOfd3RwNJ3nqe+xUyOGPigrWLNSw6UtWTDf6QFqAJlpbdOqES5f7768RCWB5dAOYBB6swcRWCigRN6eFe8jlq7yvgrCF8iWoll0rPFCYWHns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HiPZQuXM; arc=fail smtp.client-ip=217.70.178.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HiPZQuXM"
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay12.mail.gandi.net (Postfix) with ESMTPS id A13AF200002
	for <xenomai@lists.linux.dev>; Tue,  5 Mar 2024 01:13:23 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by spool.mail.gandi.net (Postfix) with ESMTPS id AF1CB740032
	for <xenomai@xenomai.org>; Tue,  5 Mar 2024 01:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709601202; x=1741137202;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=E5a7U8bJVHZZfH6LmKq83SNhvMBgnwlKLnUQAQmpW+U=;
  b=HiPZQuXM+8ewt2z3PDyAHRakNQIa9Q+L1NCzbbVXV5quMz7LEsKbpad+
   8g96flgCG1GSzIhjF3eBW2nEWd3PNUgG0DBnpf8xmxMQkgZhRuGJQb3Iv
   9x8iTSdmRQkBhq/Kz1I20vKHeuakAfC4ocoCes7+vSUyc9WbmhPUYozxA
   PxkmSgq2wfXvpeq1nYpfnwnqBjKEtxb/Yi4LA6Z0EfkTdWHu/bV5bOM78
   XvwK1b8UBgA5KntzH2QM4xmItf26snIguRr4x3MfimbeCm8UYaAxqny/h
   3shOvDU3wQVCzEWWW1YGKwOjI1FuVuZHgix4/ymfImiE5Foi65drkj4GS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="21582906"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="21582906"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 17:13:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="9606841"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2024 17:13:19 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 17:13:18 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Mar 2024 17:13:18 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 4 Mar 2024 17:13:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V47JXY1m7s2GaSLGlX3TVNZn9vrBgZ5sMbklr5kFECs/AxAUjIwAHe2A//Ih97ojpQ7sCr9YVPqT8K2YknZaOMrpTfsfrBR1Sbp2zropQWcbS46qeg3egW72iNedbsi7LBKLzFDagj3qyCTdmAsk1w0k5oWgpDvFVtokhA4RXEs1jqESrqdVx7e+EERIOP6hZwz0AcwDS/TiowC2evhYnLHAQPkT3xv/qfXcMlB+ti0B5y6D8Ax1E/zPYGSY4Qvk6Xi9Z0qTqWV3LaxdLQiGwmwiUvcJoVm04kikYVR6NVrzZenfUVCE2Pgx1Vr9seEYAApKd7nEmKetlacN2DNQdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5a7U8bJVHZZfH6LmKq83SNhvMBgnwlKLnUQAQmpW+U=;
 b=TcVkkSXNUyuNvexT1adMCPRhhCRIM+mZVcb/myWXTJeMhGSZnis0CAaZ22VFD80NFyjyiVnlMMq7HauFk6E4N7pfB1uiBl0tz+QMa9AJnbVK9pQS2F7AFcNRZf5/PpVZ/enhm+XBASOJJTI0GRLzW+MK44n+sRbDf4dpXjO9TcBd/IzUEYp21KPjtSaJFBSXCKhquWFxmR7aE+yAin++AWOeAAQcAXj+rzZ15XjvPgRioTSMh15MNjDNCfpstKJiIRpWnfRgb0HQ7l5wctIlZKeofeESGTAsCSD5BP524B7SUtKG3PG+Wtqi2bHqHprzvasZWnCb6byLiJclkf9haw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by PH0PR11MB5879.namprd11.prod.outlook.com (2603:10b6:510:142::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.22; Tue, 5 Mar
 2024 01:13:11 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::16d:5f07:19bb:6900]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::16d:5f07:19bb:6900%4]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 01:13:11 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: Pierre FICHEUX <pierre.ficheux@smile.fr>, xenomai <xenomai@xenomai.org>
Subject: RE: DYNAMIC_FTRACE and I-pipe patch
Thread-Topic: DYNAMIC_FTRACE and I-pipe patch
Thread-Index: AQHabo34hokV5CaVXk6scU481XjucLEoVDjQ
Date: Tue, 5 Mar 2024 01:13:10 +0000
Message-ID: <PH7PR11MB74998DAE5D29AB428EAC3BB9F2222@PH7PR11MB7499.namprd11.prod.outlook.com>
References: <CAFc1U0sy7hK6-4_BiC6npmSduU2XMJNQjBAR3GnkX9bqkW4MVg@mail.gmail.com>
In-Reply-To: <CAFc1U0sy7hK6-4_BiC6npmSduU2XMJNQjBAR3GnkX9bqkW4MVg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|PH0PR11MB5879:EE_
x-ms-office365-filtering-correlation-id: a376953b-09a7-4a71-515e-08dc3cb16c9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /19sLVubk36Q3gj1Bm7OadBpRDrZzhoLJHxgH0jGIpQs6DHhEPbRMUFZre5AbtNDgzcl20SCuyQ3caeQ+/Hu52FdhrM+O/s//hDTzd75lG1bZl1yaRt1g0dBQrTqeshzF1I5jyxzpKBkhgt8bW8d7zh1Pizh6JIQR4OLX99VMTjiUDifS6E/xd22yJEw+Ov881R82pmGUijBTGB98MvC4XDuTXh9G89kaaCMzzv6S2kn5ADm/S4fYrXYl3C2XayLu4jX+BJz2/6776SFZBUB80NkVZpVQ6Vk68yKukQTMBudxxOUEh9PcVRZPDgbEmRJ5ab251XOaKTWfblI73D/xJAIu6SRwhx1EXCo+G6lRya075koafMzRENPDTAkfNooAEiXBgdgFdn5nqfU/UKdC+Mtex0R0AZekZRMJuC1jxzCVgQj6OOi3IjAQX35VoyJby6+VuEPP9w3g5SHxFtJNz47SdpSVTcSmuvpOSNdugVc4iewrFWE8CTpgg9fdj0owD1fE/6FPkZHpUlQTJE3PgqTyQIwrsQTuZJIq56LFe8mC5rXrLnZbpoQ3GQ2ICMi/LHEzo10ywlGIj9BbbLXKmqYK4qwOgHLKU2aaV19UhKicZyxt8DSd49gf2zO8Xizoj5I9YhT9ECdNa3Wkrl4D8nXaKcPEpMo6AP93m0FHLU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZE1HcXBTQ3NqVEhmdml6K0VNOGoxb0p2L0lQNnlXNEU3TjN1Qm9OaWRCSUc0?=
 =?utf-8?B?dUI3MzU2TzZIOEloZXYvNVZWUTF6ZUo2YW9aY0QzRFZTNjg4QU9seHhRVHl5?=
 =?utf-8?B?WTN3R1hSWUljMVVNblA4V0VNcnVvOFNkMjB1b1h3K3NodWs3RDdUTTVtdEc1?=
 =?utf-8?B?bkIrMFVZV0ptdzhYeXRZa0RtVWZRVHR3N3kyYVI4bnc1UFZrazVsakxLZkto?=
 =?utf-8?B?dnFBQ3EyaEd6d0F3eEJKdWZLVWFuRVRXeGVCV3BYQnA3YzhGN2NvQmRZZXJH?=
 =?utf-8?B?SzhGZGM4MjNSdFpNcGJSZE9ENTV2L243UDZKM3g4NldSeDNtRHpCNUlaVVY1?=
 =?utf-8?B?QU5CWHkwNU1ESDluUzZvRjNyQTlqVzNhMFpjY0ZWbW1FQXF1azVSUDJ1MlNk?=
 =?utf-8?B?YXkweXd5a2hGTXhkdnYxNkh6cDlKNlRzZ0l0cWFvTGU3OFV6alJabkJYY2JR?=
 =?utf-8?B?Vkh3TEJsY3NKTUJZMW9YaG83UHo1ekhaTHg3WGJDR2ViNm1DaFJJalFOMWdp?=
 =?utf-8?B?cEhEVTZ5c1N2R0dQTVF4ZUdrOW9vYnprZ1ByOGQrMWRiY3BQbDVaSzhYV0VZ?=
 =?utf-8?B?eVJpSGxVV2Q1TElZLzdMbnJpTUhVQk0rcGZIZzZKUUVWY1YvRXlVZXY5clNE?=
 =?utf-8?B?YTk2NTFDVy9SM0x3cUM2d2M4VFQzZ21lVGZuNjdjK0VTcGVQQ0tDWm1IaDV5?=
 =?utf-8?B?OHpuaGNFcmxtUE1mTGswSXVvM3RnOUsvaFFJYkhMOFlXNzQ3dlBjQ2dCMmpq?=
 =?utf-8?B?Qk1rN3NUYnVvREVmOTRiMDYrTDBiOTErRzRJU1p0dEdlQnNrYkVGRFpsQWxL?=
 =?utf-8?B?d2UxUmIraXBRVDBXeEpyeFdPdkc0Zmlvc0JTblRDSU5qUlNhYTV0SlVRNHF4?=
 =?utf-8?B?aFpkTGlZOVk3RklHcVVWNmQzcGhaSnBpZFpVNysvQVd1Qlczby9rL3d2WkFR?=
 =?utf-8?B?Rnd3c2FnV0pzSmhZZkM0WkJQR1hVNFFVN0FjU3pkdzNvN2ZNclZOS1grSmIy?=
 =?utf-8?B?QXJJUzQybEhzSFV1N2hVZTZlK2x5S056c2JjblhpQVo1d2pBbXlRcFhSUnlM?=
 =?utf-8?B?d0t1MGt4bXhOdWpMcE5USU9nUTY0Wlk5aFNhQncyMW1UR0piaWUxNGk5TlJI?=
 =?utf-8?B?ekJzbk8yQm1MeW9QL3FxTGRHYWtRQjJvb1FReGNNdUpRbDNOdTlENjB2bklv?=
 =?utf-8?B?THhVWXlCcDl4bEZDSzFmT2pia3dWY01zVzMyeHBrWnZYRHZrRXJUVXdjNXYv?=
 =?utf-8?B?SUFYQzlGWUhnbmlUUm50NTJKNlFWRXJUcy94akN2Rzl0NklUTEJDV3U1MVhl?=
 =?utf-8?B?REF3cFpwbDhheVp5MnJJd3o4K2FhTSthL2NRYkkyTWp5SjY4ckt5OUxkNmFx?=
 =?utf-8?B?a2phZmRQU0E2elVpMmd2K1NUZDJ0R2hFaDlUTlpuZkY3U0FZTTRBTG1pazNn?=
 =?utf-8?B?a3puYldMSDRxMlBEUWFJZ1hwQzQyNkxleDRnOVN3Z2ZHckZTQjhRZFVDOU56?=
 =?utf-8?B?TE9PMUduR2h6N24vbFdzV2tFSGpIaDdzS0REN21VS1JEajEvU2ZwZWNCbGVv?=
 =?utf-8?B?YXBQaGZST08rVkd3ZkJXWnc3Ny8vaGdXM1VOelNkc3E1T0c5K0hBdm04QlM4?=
 =?utf-8?B?OTdJMG5OajRmMFJDZHRRMXMvU3ZCcWpxZjJMT1dnWFhnc1lSSkdIV0p0T2FQ?=
 =?utf-8?B?MWNmeHI2VlFiOVVxZEFRZWZRYmVuT1ljQWJ6NWp4YmdsdWZ5alR1aWNYUmU2?=
 =?utf-8?B?RlFtVnI1bUJDTnhFcmFvODdVaWl0OTNtZ0VDc3VJNGo5Rkx5UVdWb0FNZG5h?=
 =?utf-8?B?Ky9hZGFzSVp2RXZkS05wckdTczI1MDBMNm15YnNTazdnbHUvbzQyUlhpeXVU?=
 =?utf-8?B?bTExWlhuZ0NXZUNzLzhOc1Rwd1dFeGlFeWVQZGg4RVVQYVNhcWdoRmN5K3I0?=
 =?utf-8?B?eFk4QVcyT1VuQ1drUDdNa2RXK05XQzNPSXlYQTU2Wll2TklWblBHenpWMHlw?=
 =?utf-8?B?OENlMGlkMk52QzZaazJmR2I3YXRBQWxpRVRGaWpuREJRcVR6elBnRTNYemxi?=
 =?utf-8?B?dmNUdDhQNDVCM1BwN2FmK1RKQ2Vscnhjd1RwSUthMHJrZXhiS0VnTm96WHB0?=
 =?utf-8?Q?7AWaHWUA/47lJtDwXRHzl2mX4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a376953b-09a7-4a71-515e-08dc3cb16c9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 01:13:10.8426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nXZ9bgKOx5b5HfwIPdq75R5GltpqkE/Ak2NuMvbH70027PsCVd50w4XLkstgyAY61DBObx8sHCTgVRZzXkyHjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5879
X-OriginatorOrg: intel.com
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=intel.com header.s=Intel header.b=HiPZQuXM;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (spool.mail.gandi.net: domain of hongzhan.chen@intel.com designates 198.175.65.10 as permitted sender) smtp.mailfrom=hongzhan.chen@intel.com;
	arc=pass ("microsoft.com:s=arcselector9901:i=1")

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFBpZXJyZSBGSUNIRVVYIDxw
aWVycmUuZmljaGV1eEBzbWlsZS5mcj4NCj5TZW50OiBUdWVzZGF5LCBNYXJjaCA1LCAyMDI0IDc6
NDQgQU0NCj5UbzogeGVub21haSA8eGVub21haUB4ZW5vbWFpLm9yZz4NCj5TdWJqZWN0OiBEWU5B
TUlDX0ZUUkFDRSBhbmQgSS1waXBlIHBhdGNoDQo+DQo+SGksDQo+DQo+T25lIG9mIG15IGN1c3Rv
bWVycyB1c2VzIGEgNS40LjcwIGtlcm5lbCB3aXRoIGFuIGlNWDhNIGJvYXJkIGFuZCBhDQo+Y3Vz
dG9tIEktcGlwZSBwYXRjaCAod2l0aCBYZW5vbWFpIDMuMSkuIEl0IGxvb2tzIGxpa2UgYWxsIHRo
ZSBJLXBpcGUNCj5wYXRjaGVzIGRpc2FibGUgdGhlIERZTkFNSUNfRlRSQUNFIG9wdGlvbiA6DQo+
DQo+ZGlmZiAtLWdpdCBhL2tlcm5lbC90cmFjZS9LY29uZmlnIGIva2VybmVsL3RyYWNlL0tjb25m
aWcNCj5pbmRleCBmM2YyZmM4YWQ4MWEuLjk4ZDdjNjRiN2I4ZiAxMDA2NDQNCj4tLS0gYS9rZXJu
ZWwvdHJhY2UvS2NvbmZpZw0KPisrKyBiL2tlcm5lbC90cmFjZS9LY29uZmlnDQo+QEAgLTUzMiw2
ICs1MzIsNyBAQCBjb25maWcgRFlOQU1JQ19GVFJBQ0UNCj4gIGJvb2wgImVuYWJsZS9kaXNhYmxl
IGZ1bmN0aW9uIHRyYWNpbmcgZHluYW1pY2FsbHkiDQo+ICBkZXBlbmRzIG9uIEZVTkNUSU9OX1RS
QUNFUg0KPiAgZGVwZW5kcyBvbiBIQVZFX0RZTkFNSUNfRlRSQUNFDQo+KyBkZXBlbmRzIG9uICFJ
UElQRQ0KPiAgZGVmYXVsdCB5DQo+ICBoZWxwDQo+ICAgVGhpcyBvcHRpb24gd2lsbCBtb2RpZnkg
YWxsIHRoZSBjYWxscyB0byBmdW5jdGlvbiB0cmFjaW5nDQo+DQo+VGhhdCdzIG5vdCB0aGUgY2Fz
ZSBmb3IgYSByZWNlbnQgRG92ZXRhaWwgYmFzZWQga2VybmVsLg0KPg0KPkNvdWxkIHlvdSBnaXZl
IG1lIHNvbWUgaW5mb3JtYXRpb24gYWJvdXQgc3VjaCBhIGxpbWl0YXRpb24gPw0KDQpNYXliZSB5
b3UgY2FuIHJlZmVyIHRvIGh0dHBzOi8vc291cmNlLmRlbnguZGUvWGVub21haS94ZW5vbWFpLy0v
d2lraXMvRG92ZXRhaWwuDQpJdCBtZW50aW9uZWQgIiBUaGUgSS1waXBlIHByb3ZpZGVzIGl0cyBv
d24gZnVuY3Rpb24gdHJhY2VyIGJhc2VkIG9uIHRoZSBGdHJhY2UNCmVuZ2luZSwgYnV0IHN0aWxs
IGR1cGxpY2F0aW5nIHNvbWUgb2YgaXRzIGZlYXR1cmVzIHdoaWxlDQpyZXN0cmljdGluZyBvdGhl
cnMuIiBidXQgIEkgZG8gbm90IGtub3cgaWYgaXQgaW5jbHVkZXMgc3VjaCBsaW1pdGF0aW9uIElQ
SVBFIHdhcyByZXN0cmljdGluZyBidXQNCmRvdmV0YWlsIGltcHJvdmVkLg0KDQpSZWdhcmRzDQoN
Ckhvbmd6aGFuIENoZW4NCj4NCj5UaGFua3MgaW4gYWR2YW5jZS4NCj4NCj5yZWdhcmRzDQo+DQo+
LS0NCj4NCj5QaWVycmUgRklDSEVVWCAtLy0gQ1RPIFNtaWxlIEVDUywgRnJhbmNlIC1cLSBwaWVy
cmUuZmljaGV1eEBzbWlsZS5mcg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaHR0cDov
L3d3dy5zbWlsZS5mcg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaHR0cHM6Ly9zbWls
ZS5ldS9mci9vZmZyZXMvZW1iYXJxdWUtaW90DQo+SSB3b3VsZCBsb3ZlIHRvIGNoYW5nZSB0aGUg
d29ybGQsIGJ1dCB0aGV5IHdvbid0IGdpdmUgbWUgdGhlIHNvdXJjZSBjb2RlDQoNCg==
