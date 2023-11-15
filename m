Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6126F441A
	for <xenomai@lists.linux.dev>; Wed, 15 Nov 2023 08:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZIJesVW+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700035522; x=1731571522;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=3CbEQjusZB9+KFP/NVuHYHV+h7vbk9tuqD4ptUKcBcM=;
  b=ZIJesVW+8B1hLV1pIL1lNbYvb05MFfPLUNmNDbD2Y4FmAk8YFAFtXIEC
   aHW5B5KmzPeiUaZ35/2NFOiGcvfDI4DExoHm9lCGOMYqKavBhQPvbgL8C
   NAamrn4exqSS2JydUrhy+37/bFGj4U305kFTeXQdPEYJWnXdiPOqz3rK+
   d+4ugRJXuVwq85KbWfdQMH7QiAg0vkXJB92zMUUa01OGjQenYWy9ST+gl
   XAagJksvgXoEKqFAorvFv3PUdu6O+d+p7YBZdGVhRG0yQ5Ui81K5cZBSo
   wKko/aBng8PH2pkZyHbEv3ukhSIkxj+hQ5iF1/Cwi2lQUl6Repk9ZMxBN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="421930794"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="421930794"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 00:05:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="1096378803"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="1096378803"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2023 00:05:21 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 00:05:20 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 00:05:20 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 00:05:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdUbqNvmwP50SluLjHe3BiZRbn6yD1+TQ2Nob1+FKysK12o8+1CXdb185sFuI0EPnrL8+mVmX979pWWKJFKonZ4D471jG9Td9Tw1V3lJG2tz8Gk+UsIIyZ/WK6b9i0orCwGVTAbAO5rBHtm6M3yj4MiLE1NdwAnN7h+rkffbInbe3bOwM8TeX6pKlFAxy8nWwAj8EZ8RGLNXuo98Zpfmk2BXCuLTDwHEUoUI52xVZD7+aiLe1dMSo19ZczHUHtQFJeY/JJEPc1zKiJ0dRkMlDPFjx02TgrCBkduJWK4HFuonkoO1/vPksfTWayYucy8TGMDE1wFuEBrdnl/gdZLhJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CbEQjusZB9+KFP/NVuHYHV+h7vbk9tuqD4ptUKcBcM=;
 b=H4DQ4CtPmD8ZjZ4lg+jpzNO2qL9BlKxTqkIy/udpD628X7Tlx7pie1hysKXjqotPYYO5roD1rcscXC7ehG167kGWwXc5hMTD/IZkQZWOOQOJMl1p469QW7RCtvlCcXwW+TGDg7YGA6R096l65GAyhhs6ZFf3G/kMPh9JQTSLT0AZqucNWGhfKX+L0GHpddHp++yckLOeEKCly0GAc18fnib4FxWMCvU4y6V/mUgkVg47hAUDSmrViCnMtK38+7kMcKtZcc8PpcL2USXv8kOvZe+Z5DSmYWaubd6tBFDbidwAozfyNNHPt0T5ID2qksNRXjY6XnPdomnElD6i/AyZRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by BN9PR11MB5388.namprd11.prod.outlook.com (2603:10b6:408:11d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18; Wed, 15 Nov
 2023 08:05:18 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::7b71:c300:be05:d512]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::7b71:c300:be05:d512%6]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 08:05:18 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Xenomai Community Call Minutes - Nov 15, 2023
Thread-Topic: Xenomai Community Call Minutes - Nov 15, 2023
Thread-Index: AdoXmjCyUx4CLSvmR7STLmKO8x2vCA==
Date: Wed, 15 Nov 2023 08:05:18 +0000
Message-ID: <MN2PR11MB4285258D3E547D941BAB1739F2B1A@MN2PR11MB4285.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|BN9PR11MB5388:EE_
x-ms-office365-filtering-correlation-id: 0c0f173b-4fda-4899-9432-08dbe5b19b8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fPneCORJvpZkJj3TlVxFYqyxNb2EA2DA3BSiOJYdsNaCyxoJxClRUc0iF4SczYrwfMMEipRkUq3fl42jglSP16LJ5sn4f02cr3WsLxHo3J19INxjsI0qrXVKk3oeSkn57mzlEChXy3a65BGuDNPI87GnKWWoFrDP07PqFg7+OuhYnIHTN5CtPbEvd3gcrdgqerROUz8UVpOoDGivenfmwSdrlXOAJDmsGbmCB6rK1RljvN7K9Ndy1/WiZfDeWVZeU5GGDJSVdanT/b0G5HrZuO3a/QWcLbbOPbKqeqn/OXTwln9MQn88I84HI98niwtH7JLYytTb19+L4Q/jLbRJ+XeItSBFyNxHFWLgLKv0/OI2JCWZ3bggjjA+tATpeXoAKviAUWBBv54si+PCono4+2RHE+Vu83eElbyS66Vp+Ep5a1ZfeFHlLDTmX8CfhkTXOPLnf1KLG3WubP7LU9QDY3ijNrRSpp6YMxE/jbrdMUwFmubMcR6d4tDVPQrx8uQ+BbZH95JJnoCbhvBGthme981n9rj5IEVS2ie4uojDgtTL6dzkfmmsYa0V2WQ7ZPfUeeXmo54oTL/7DraH4gU5oRBM9lnl3czKgLt++TYgUJ+FpfauRFzd1FodhhmpdUVZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(396003)(136003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(478600001)(2906002)(9686003)(5660300002)(6506007)(7696005)(86362001)(71200400001)(558084003)(8936002)(8676002)(33656002)(52536014)(76116006)(6916009)(66556008)(66946007)(66446008)(64756008)(66476007)(316002)(41300700001)(55016003)(38070700009)(82960400001)(122000001)(38100700002)(26005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0R4WGhxNnYyalB0eDUrU3VhNWFDRnpGaUxDOWhaS0RzMXNyV2FKSHpISUJa?=
 =?utf-8?B?MXZTVlVPV1MxdFRVb0V6SVVDb09yemVNSk9kL2toaWh4L2hUcEpJT1lGTml6?=
 =?utf-8?B?dmllTHl3NnRnY2NuekpSeEtTT3k4cEFFNExtaFk0a2h1ZjdZeERIcjhUQW9V?=
 =?utf-8?B?cTBzeGdVUFExL081b3N6VnBvOU1vZXhWaFlZcldkejlXcGQzajI5djdXWlZL?=
 =?utf-8?B?QUM4Wkk0MWV1S01DZFFleXdxUnFVVmhCSzE4dDJiT1ZZRngvSVdCV2ZlU3Fv?=
 =?utf-8?B?WUFERTI3QWxDeUdUUkFqQnhBMFI5M2dFOFJoUmhabWpmRSszL0ZsaXlqWkw1?=
 =?utf-8?B?TmVUVTVoWnoreEVMVWhRNWdJMk1GVituUisra016UFZWMzlrL01JeFY0bzZV?=
 =?utf-8?B?QmFpelN0MzhxbTAzLzVtZ3lhMldFT1R1NUlvZVVoNGFBVnJrbmJWU3crZXdK?=
 =?utf-8?B?L0trQXNIR2k3OWtDVEJqTWZaUnBnMFNqdFBlMWtpaE5vdGRaTkdwVjAxMXlj?=
 =?utf-8?B?TkpYUHJrdGg0NE1QZDhtZjErQXFicTUxWGZOcnVWbDZYNVc0U2JrY3plK1RR?=
 =?utf-8?B?dHRjdGIrSUh5MlVXem1YWk9HaWp0cjNBVjFrREhyTXlOdVlEMHo5S2NCWXpP?=
 =?utf-8?B?VEpCQWNsdVR3T0NkS1oySlZXOG1uOVFxdk1NQ3hLenNOK0tabTJDdmpYSjV5?=
 =?utf-8?B?T0x3QXZXUzZBa0lRR01Xay9ZTzNHZ2Znc000OURaUlcyVGNrbkhoZU1tSG1i?=
 =?utf-8?B?RW85UGltbWU5M2VDbmRqbTZCeXAxblJwQlZ6dTBnV3FPKzJKb0FZYlZiMElr?=
 =?utf-8?B?UTVaNUh4RVJJdEgvZlJpNDI3cFBLYUlDTGk3TGoraExvNVJranBicmdIOXd6?=
 =?utf-8?B?V3MxTkhWYnNYMzhMNEZwN29GZndqVHFURmVETlZtbXVzOHJUMS9GdVZZaWZD?=
 =?utf-8?B?TDRrdlBnQkc1MDZsV2FONVdPU2MvYnRJQTRBNjE5NTBONDd0WnRUQVNPZ0V1?=
 =?utf-8?B?WXQ3WEphbDZBWEhHdnAxSXJXcnRmZzRsSFJnenJ2clNpaFM1a2RWOHoxeDZm?=
 =?utf-8?B?M3BrSHJhOGxjbUJxUFFnU29BcGZJaGVpdXk2cFlrNmJGVVR6eEk1bHJ2M1o4?=
 =?utf-8?B?Rkc3RkFqSVRNM3UxYmg2Ynl3VDZjMFFaSzMvaU5jZEpGMktHMkNuYmxzakgx?=
 =?utf-8?B?RW9aaENQSjdmbEFnbG45ZjRIYzdVb2RNakxMOUxiNE9KQjREemZoeWRyYXgw?=
 =?utf-8?B?ZnliVzk1VG1pclBNZWhmQTI5V3RrK29tUkwxSTc2MUc1TXBERjdhak5HUHhC?=
 =?utf-8?B?RkhHRUxtM093eHdCOENqM0xqekxEemp5bzdVTHV6UkMvbE1hdFJWZUpWWWpt?=
 =?utf-8?B?TW5sMlA0YjQ5RmlEbkRvYU9UbmdsdnY3YlMxWnFMSG5iSWcyL2dYMzRpS0RL?=
 =?utf-8?B?NVBUb29CQlNGajg0TnAyQWVBcDA2b1Y4c0V2eHA0YkFIbEEyS3dZZ0RNVWNm?=
 =?utf-8?B?dHIybEt0TzdsR3JXNXRNanl0eDRSWkdEa2tpV0pJaUVPTnlPZXgyTzYzSUxn?=
 =?utf-8?B?ZFZvZ1NUWkdDVFZ3eTFkUUM2Q29ySGwyMU9aTHNtUmV3SWc2NC9DanFCcnVt?=
 =?utf-8?B?UWxjbkZVeG9KQlpPK3pJOEo3VHBvcXVOV20zUS9DT2YvMnZVMTJzcTBUZnNH?=
 =?utf-8?B?UElSQUpsVlBBdHM2c1puaGU3TGdYVFoyY24zSXcrRnB2OEVGdXc3NHFjeFpm?=
 =?utf-8?B?ZEJRandFeE92TldLUkVua2xKWitaWHBQTForQTZralRIOEZQWWswejl5Wll6?=
 =?utf-8?B?b3JnNUg1RHdUNmZXV1JYVk9QQmtXeXc5UHFEc3B6c25NeGwxd0NJMW4wQ3Vw?=
 =?utf-8?B?bm02STgzWExDQnNWbzJYWCtiMG4zbE9uWHJKSVdiMUI3dE5oY3Z1Ym9uWS9D?=
 =?utf-8?B?MlJQNHVWMmVDbFlOZndxb0hranR2UTBiR0xWT2Fac2NaWHFTUUVHMzJSaUl4?=
 =?utf-8?B?RFNsVjhaaGkzQmFqWU1jQm51U1NLMGRuMDFIV2lHc01GV1BteHcvOXlwWGto?=
 =?utf-8?B?RGVXMGNka1ZkK3lCWWwxcURqSFJkWHpQL01UbWkzVVppTzIzdjNuOHFrbTZV?=
 =?utf-8?Q?qRLNUcmLx7G9F5tb3SFmObK+g?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c0f173b-4fda-4899-9432-08dbe5b19b8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2023 08:05:18.4169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GblTgVy5z/cmDMnucWIl+Q/INl13iuiXSGCzcPzt8vyzek+VBSAgBM/f5HVo+bNfRshdKTCiNSxeX8WKbxqYvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5388
X-OriginatorOrg: intel.com

QXR0ZW5kZWVzOiBKYW4gS2lzemthLCAgQ2xhcmEgS293YWxza3ksICBSaWNrIFdhbmcNCgkJIEhh
byBMaSwgSG9uZ3poYW4gQ2hlbg0KDQpDb21tdW5pdHkgdXBkYXRlOg0KCVRlc3Qgc3VpdGUgY2xl
YW51cCANCiAJYXJtNjQgZG92ZXRhaWwgNi4xIHBhdGNoIC0gbWVyZ2VkDQoJRVZMIHRlc3QgLSAg
a2ljayBvZmYgDQoJTmV4dCBtZWV0aW5nKE5vdiAyOSkgLSBjYW5jZWxsZWQgDQoJICAgCWJlY2F1
c2Ugb2YgMjAyMyBYZW5vbWFpIHdvcmtzaG9wDQoNClJlZ2FyZHMNCg0KSG9uZ3poYW4gQ2hlbg0K
