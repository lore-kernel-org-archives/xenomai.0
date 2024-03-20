Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621B4224C6
	for <xenomai@lists.linux.dev>; Wed, 20 Mar 2024 07:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710920664; cv=fail; b=FEnBhr+TzDmElQkjqJeUrRMbaXrz83hMROt0DBhXxtk9pQkvrVk6znMG/8pyci+pOqq+m5GL2103k9wJNdO8olNEPVRiWilTgPdl9UwDbNM3+3EWoyFqFyX7NgQkETF5sm6oVBnAqbFREvlMOr2QWgvafEurvSMO70zdtgNvO80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710920664; c=relaxed/simple;
	bh=7z/SlERWsLrh3kPvLCEWnpK26Xg5eGNqS9+ekwIn/xs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dmEjpOQoBayfCU0aRsMulsXL2negcdkOWsk1PEAsE9ToGm2UcLkDuwUAU2TqSxjw4g5uuyAz7rFBRiSVm5F3TOG7kDAEqEDYqujUDXXbad6JOmMBn7WBWy/yO8rcyHrHqNI6P30U64AdwLt3jYEkc1rFI0fB9SPBKtiCe2CYKAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=enCUvPS0; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="enCUvPS0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710920662; x=1742456662;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7z/SlERWsLrh3kPvLCEWnpK26Xg5eGNqS9+ekwIn/xs=;
  b=enCUvPS0NZyoG/EJ585mgNlbAUOf7UUlcLq5tMIz813yDmK2au+FHNhV
   1lmsf/a/Hzx3D53MOtYaJ9ut+bmNzay645kQVAHYZRJ+39mUD9xZtzLPm
   RcPybB55HKQXhoOaryxZxWwljlVPXXaxzi125MZSG8QawUZRTu+WrzU6h
   gYxyJnbDl6t9HybYPu89+P5qn+t5/HFL3n1sOVt5mnn8/qlhMxKvF2rs1
   m9fWcie18iMgFk/rTlyvZEaRO5uyFmj9LPy7Gn8SXIGLt8NgRYKcsb2Uv
   Qd/tvUtGIAPq/AD/ECKtp7TNOssfDQ4rqjmBqsDyM2mQfpJf0ZeVN+yNj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="5677850"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="5677850"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 00:44:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="45039748"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Mar 2024 00:44:21 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 00:44:20 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Mar 2024 00:44:20 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Mar 2024 00:44:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYJWht12eyl261ZRQsvKlaFzS9GYKhABYpQMG1gSg/knK6DeFKUi3bjORrXW4vllQYRuSG/IidiOdjaqckBVNFZvuBgyYwG5a3ttnvIh7EuEKbwHjIY3O1iLQHd5ndorBDUDEd2vvrpU/g+G2BOjrJkTc9NfpP4c4kfRv8Ni9D5rp0WOizishMxTJzE2PQphO44X58WDY8TTqR1AN3BPg1pJCHj/cpfDpyfFD3sMaYzwGfYIgO8qyt2ewNzjP+cC5ip6VmLPELi644eBdYa91nmtgyqk1hjtwct7HqJyKXPHTfmoKkdBZpL5G5Z1juCZrob3CuUuw8BRHM0/Ysoq+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7z/SlERWsLrh3kPvLCEWnpK26Xg5eGNqS9+ekwIn/xs=;
 b=ALWUyhUOahACDydn4Gljaq8I6tpKCKCAL8RBBAdZwA65vr17qAyq3jBe9kbgGtUV1tOm3WQ8saRGG8zE4FQ2J8/kML35VidyTwLmUMtB3zbbwl6iw/KOE40FkCcbt9lLa4Cx2dH/gksxl2SaZOlpUhzSuGRhTRq8yCeIi4ydniBuc7cRQKLhBgttFzVQWz9OnuM6An/hF1YUeR2/6f+0yoR2cIMN/QDoRplJbxr0vvap7ri2xsPpF7LSQw30ElFwcWKef06BtwwPTTfJRVQyVwNL2LCCYS6CjImvl9Kw3bV1/leogAyS1iByBjWR4nKEh7yIieaORGbiS7WuHtVzqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by SN7PR11MB8281.namprd11.prod.outlook.com (2603:10b6:806:26b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.17; Wed, 20 Mar
 2024 07:44:15 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::19d6:5ade:3ea:583d]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::19d6:5ade:3ea:583d%3]) with mapi id 15.20.7409.010; Wed, 20 Mar 2024
 07:44:15 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: Philippe Gerum <rpm@xenomai.org>, "Rosenow, James" <jim.rosenow@mts.com>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: Hang at "loading initial ramdisk ..." on Generation 11 CPU, Gen
 9, 7, and 6 work.
Thread-Topic: Hang at "loading initial ramdisk ..." on Generation 11 CPU, Gen
 9, 7, and 6 work.
Thread-Index: Adpz0VUl1sKmb9j9QoWV24Wq8Vg5UwAAnQbQAAAO4vAAAVDlAABhoNkgAATl34ABJz79wAAA2hGAACGacaA=
Date: Wed, 20 Mar 2024 07:44:14 +0000
Message-ID: <PH7PR11MB74993B22D254153A2B899D1CF2332@PH7PR11MB7499.namprd11.prod.outlook.com>
References: <DM6PR04MB538655375C57CF07EDDE5089E2242@DM6PR04MB5386.namprd04.prod.outlook.com>
 <DM6PR04MB538673AA2E912100093BBA7CE2242@DM6PR04MB5386.namprd04.prod.outlook.com>
 <DM6PR04MB53864A2698B4F2147B79413CE2242@DM6PR04MB5386.namprd04.prod.outlook.com>
 <87bk7kwu9z.fsf@xenomai.org>
 <DM6PR04MB53868485664BC9374914AC69E22A2@DM6PR04MB5386.namprd04.prod.outlook.com>
 <DM6PR04MB5386D31E1CB453165917BD24E22A2@DM6PR04MB5386.namprd04.prod.outlook.com>
 <DM6PR04MB538672EDF4ADC9538AB418FDE22C2@DM6PR04MB5386.namprd04.prod.outlook.com>
 <87zfuudybi.fsf@xenomai.org>
In-Reply-To: <87zfuudybi.fsf@xenomai.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|SN7PR11MB8281:EE_
x-ms-office365-filtering-correlation-id: 79dd7545-ca6f-4cbe-2bae-08dc48b18a79
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9hvYPlqzEDRQj3ST/exZ3xZk20pxxElipL2SWj+SQ23VSuoLpV2tMPWixqZzS96usrmA5CRe4d1k9s7n3OGf7za2tmCMj30aUQigxwsBpiJfQrOFphvExZtDWLfLXfKFE+U+yO0XeRxhw+iCAibys86Fav3cgDAhqJSvMbFMydyVBvzC9cAExlx2GP5LGGDoeSgHFk1naGVtfS4NoJXgQpbLqCv/9Ue40rHA1kq2rpYP1oyWZtvpKRdgxbIRaNyeQjhi72FsjhUk1i3N+lGg0zew2dTyK4daMVUH77kTqrPtx8vPWiVigFrROojfBGt3d/CKMbXpBOTrIPmhyLxacXIB5RMMClYZzAZjKCi2Y9vk/eRXCbngMymeod1hvZ/DFIRf7CN9RIUOSmUCCtxplEvj5p96guaPuJhqtrqP3NCJcGprK2kxqdfZ/VjL6EG+TxqRe3+oVITyAfOWp7s1LWYvErVDxQTmCiCcOi67uOE+yObH00Gqzry/c2rSfUB700ZpsvNaXnwCyfEmNhQtpqzqTKUY3kekGU9Zv1ebQm2mm3riA7q9XCDT7cmF1aWtKD7ZbjSgdT9GMJwvfrOfJou/06G/zlIrfcixjYuLBt7iMf13yWSVLCG5p0CsrEQa8ucIZuErnObTcUKfMpAauzok10aRermVx6lR+kjLArx+iDfJuWMbGMgPijtEaaNdcVgUydajYQdJjR5kqE8xYFa29HaXBwriXwt8Ug4b9g0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2MrTFdXbERxZ1owM3JUdE4yY0tEUXNtYlAvcURqNHVMT3ZkYXZUMmRoMURJ?=
 =?utf-8?B?Y3F6dHFuVTI4NmROWklOaU04Nmdua01nWGN3R2NHdG5kU2tkckpZbUFSUXlY?=
 =?utf-8?B?V0RlZlNiU3d6Tlg1MVJwT25qdjRFQ2R4cVZoWWlzcE9RQnpvbzNIMXhUZlNJ?=
 =?utf-8?B?MVp6cituRHdUTi9XMC92LzFIeWFCdEQ3VXVTNG1LL1BYdlVrbWQwamRHK0FS?=
 =?utf-8?B?bWVVNG8zSnYyKzBuZWZwV2FBaUEyZ3dPMUJUc2xRQWRoWWw4TW4xaFY4UGd4?=
 =?utf-8?B?UjlOZDM3eFByRnU1a0NHdmZ3YitkWUxiZ1JoRTNuVkVIZWYwb3drZ2FoN3hB?=
 =?utf-8?B?Y3pBSFpUVExJM3NGaWQ0TUROV0x5YVQ1MUdrRVVBTEJvLzlxOFFyUVdRcXl3?=
 =?utf-8?B?bnQwUHpMMU4wNGRobys3Y29SKzFIcVVhRnlvaUhUWVhLMW5WUzgxUGFzaXYz?=
 =?utf-8?B?NmxlbHd1ZlBVdkF4eFdIcUNjdUdvcy9mSlAyK3BRWUZOSTQwNlQ3TGQrZC9l?=
 =?utf-8?B?dW5wTHowdmRVdFBzdTMzSGV4OGdUKytsUXE1S2E3MjR3bWZ3ekRtRjRyNU5C?=
 =?utf-8?B?Vm84ak9zb1ZjR05GblRmS3FzWkZTWG04aUlvUUJnYzAvMFRGcTNvQ1BqYkZr?=
 =?utf-8?B?aXVxRmxRakYvOC9rKzdnOFY0bDdySXdYdElFVUg4a3JzcEdhTlVHMzVsNGxH?=
 =?utf-8?B?a2dIV2o0djkySTh0SGpWT2xhbEZwam53VnVhbmRhS0JNR1U1NVZZMEJFU3cz?=
 =?utf-8?B?cjlLdlh5VHp0Nkh5MTVkNkROaU5RYnJEdFlSVTgzTnJUUW1MWGxxWWxyRnc5?=
 =?utf-8?B?aWg1bUhZdnFEdkxLbDFFeEh6dGwxLzUxSm83czV2UkhXT3ZNNU5jVHE3OXl3?=
 =?utf-8?B?eG91cEU0ckY5aFd4azdmMW5UL1RjbnhaSlVqbTdPS05yUGdBSU12WmE3Zkl3?=
 =?utf-8?B?ZDlxWlV4ZCs4Mkhzb2RDNFJxazlESUo1emNJWWpVbDU0ZTdSdlFKek1RUExP?=
 =?utf-8?B?L3NacTViTE01U0hBbEdUMmdqdFBDWHQ3ZDlFTldHaXVHRklNRGFvbmhpMllo?=
 =?utf-8?B?S2tsYzExVUd0SUxXS1hub016REpRZktYd0U0eFdsMkJzQTJsaVRUUHNxQjZ6?=
 =?utf-8?B?L0IrUFVseTc4V0ZKc2NuRExiQ1BIZ3UwZzEwa01TMkkyRVJ5bnlGc1NVbmox?=
 =?utf-8?B?MlZtQUw4MC85WGxjSnNzQ1ZiUFRxR1FQcm5RdzhVOGs0MTAyMHNQYmZTMGlQ?=
 =?utf-8?B?aHhZa1QvbDVoNWUraWVTQmJ6akxIazY5ZFhmYUo3Nm1SYXNmNDZyTFRHaDlo?=
 =?utf-8?B?MjhXVkNPU3Yyd3JiVGh2TzlPejdRVDRneGNBL2ZCMmp3eDZ5TE9tTEkwUFYv?=
 =?utf-8?B?MkpFdmZpZ2JucFlEVmI3dDBwejBVZllubHphSFJ2aWRidUlXNG5YNzhRSEZV?=
 =?utf-8?B?L1FiUTZrelJBZHA4Q2NMNjRhMW1VVlZ4ZE1DQ01vd0hCTFYremErZXpqZmNs?=
 =?utf-8?B?dHlnMVpQTEEwRDdGZ2R1M3FjVHlCM3gvTUlQVjgxWEJmZDhYTWlVRWFWUkM2?=
 =?utf-8?B?S21GVkZHVmwwWnVJVkJCWFlCb2I5RzVHdjlrb20yMER3eUFEbCtDdEc5SmFL?=
 =?utf-8?B?bzljNkdUQ1dYRi83c21SLzlzVkRZZWo2R21BYjVIWWVwMVVVb3U3SnZSeExN?=
 =?utf-8?B?SVVvMTFxeVU2RmFmUmtwYXE1eXhFckw1enFuOS9QVHp4SHljVkVzYmQrODNZ?=
 =?utf-8?B?WmZwZWpKZE01MVM5TS9zUW1tSkpIZm01bTZGdFB6eHdERnk2SnduOG5VVHVR?=
 =?utf-8?B?aFRsYUlqNDcwdEUwRUpRanN0Zk9zNUZ3Sm5NRGxLbFBWZlFwSDVXMVFyVzRC?=
 =?utf-8?B?TEovTUp0ZkVFUFZGQkNrS0hYUE8yRWZmZXR5TlJ4ckNPQ21KdmUwV0pzeDdr?=
 =?utf-8?B?Wk9XemlUbmxYRmpSdDc2MElJQkhjMUpCdjVUZDhuN1hDK1ZHZW94U01vTk1V?=
 =?utf-8?B?WVFXbGd4NURZMXVJSElnWWhkUnNnVktqMnNyUFpaYXV3T0VHczFCN0sreFVZ?=
 =?utf-8?B?MlVnYlNPUGlFbUpwN2pXSHowREw1UEVBZnlHNWViS2dRUHl3eVZuSVN2Q0lL?=
 =?utf-8?Q?usTRIYCNX3mhhpWpQrzkfwe4C?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 79dd7545-ca6f-4cbe-2bae-08dc48b18a79
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 07:44:14.8888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EUCdMYY+UwGEJUtTme0LYgqEjhWoodgU11AF0AtT93I8fzoLKEXSvtDtsk+Qz8fZlxQDDQOcsVQwJL7vWi7Qkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8281
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFBoaWxpcHBlIEdlcnVtIDxy
cG1AeGVub21haS5vcmc+DQo+U2VudDogVHVlc2RheSwgTWFyY2ggMTksIDIwMjQgMTE6NDEgUE0N
Cj5UbzogUm9zZW5vdywgSmFtZXMgPGppbS5yb3Nlbm93QG10cy5jb20+DQo+Q2M6IHhlbm9tYWlA
bGlzdHMubGludXguZGV2DQo+U3ViamVjdDogUmU6IEhhbmcgYXQgImxvYWRpbmcgaW5pdGlhbCBy
YW1kaXNrIC4uLiIgb24gR2VuZXJhdGlvbiAxMSBDUFUsIEdlbiA5LA0KPjcsIGFuZCA2IHdvcmsu
DQo+DQo+DQo+IlJvc2Vub3csIEphbWVzIiA8amltLnJvc2Vub3dAbXRzLmNvbT4gd3JpdGVzOg0K
Pg0KPj4gQW55b25lIGhhdmUgYW55IGFkdmljZSBvbiBob3cgdG8gcm9vdCBjYXVzZSB0aGlzIGhh
bmcuDQo+Pg0KPj4gVGhlIHJlcXVlc3RlZCAvcHJvYy9pbnRlcnJ1cHRzIG91dHB1dCBpcyBiZWxv
dyBhbmQgdGhlIHN5c3RlbSBkb2VzIGhhbmcNCj53aXRoIG9ubHkgQ09ORklHX0lSUV9QSVBFTElO
RSBlbmFibGVkLg0KPj4NCj4NCj5JJ2xsIGhhdmUgYSBsb29rIGFzYXAgdGhpcyB3ZWVrLg0KDQpJ
IGFsc28gcmVwcm9kdWNlZCBzdWNoIGlzc3VlIGFuZCBhbSBsb29raW5nIGludG8gaXQgb24gR2Vu
IDExIENQVS4NCg0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQo+DQo+LS0NCj5QaGlsaXBwZS4N
Cg0K
