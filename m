Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033B117EF
	for <xenomai@lists.linux.dev>; Wed, 11 Jan 2023 08:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673427184; x=1704963184;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=ftxS7J/MJpE7Gl/Jfev8VgFtBkJi+XawcATdGbIUt6A=;
  b=DhQH9RHXqeaMselbvHPFaUa6eFDFeaEZQOX1ATN4g1rr72McvA0pA1xs
   3D6CPEdKE3B25v2uE+cQdnXBIiiQZfBKodgoc1mILRCeoROlZnecJFEKZ
   TQLvbSgUwXoNg1Sq7YB/AEyM3RRTOaEz6DSQ9geGpCWLEp+PGXrgNi4Wv
   Oj8NmlsdJ4BEz/rnAvGR7+OKdQQA0uE4O91+V3te0EX3vVKxCJJg6SVVz
   5qWqR1lF4fRd0aSSxpee1DfIs+mZpk8PTnOYvqmo3Cn9breLSE6LzV0jT
   ezhPcPV7oyxGFmhbpRTDuDLrRY2AKKgH1Ht8UJUKED7VGtPO/yzSmWgIt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="387826283"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="387826283"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 00:53:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="659288074"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="659288074"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 11 Jan 2023 00:53:02 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 00:53:02 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 11 Jan 2023 00:53:02 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 11 Jan 2023 00:53:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dLGRIro1LajVd+tF+dtNkxzOf108Zr7qKd0cBOVNBq4nvtQa3G3ZNNZ9uNyBU/OvXUT2s18mdzX7ixNYrgHpB18txNnqEQuRWUmXIVeYjLDo3CSr9lMZM92jwLS1CVL6Jpn8hdqP80xcJW2jlmmGyZXeA6Q8qz6mXhxJVpsqRdsUQ73uR29wCvmqqeA57z2hLlw8ZcvfkqU7Z0nhRIrpLrSk17dg2Oki7CMvKg1XhxA2n0OP0m0437/iX3JH2TQ/bqdjJU3i7VGUtoU+3URqHyQ9gtZx0+UGgPGoKBXlII8hqloR5ApNad77Rz3Died6x4Sd5CmqbYEgc5ZOGSFTYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftxS7J/MJpE7Gl/Jfev8VgFtBkJi+XawcATdGbIUt6A=;
 b=g8XZfDePeZBqeGQq16Sr6eSWjLJePLYQKA41ri+WMalVo65LVpMeCY7bribepShU5XSVS2S3GcyU37sf3i85KaCcDTwjqgOFdCFZSEifW5M8e/UPl78d9gwcYBqCP6iCJUwkptC1Mj3dWdsKA7cyaZIeTFGSRKY1uwYDzS3iuVBnIchVMA5aKdaqtZoWXGTRwyFwZPtudzptW4cd9gF8Y/NnYI4f1T44MJOlF1x9cflmkNo0pruWjU2qY/FjqcfcVyVo91F8VDWhMcIwoUAXBUpoQbzcLkOozxxnKYbA/Qit0qwrTYdmSogl99oDBElzj3bGqIAXKAPp/AWF6A+i6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by PH7PR11MB6770.namprd11.prod.outlook.com (2603:10b6:510:1b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 08:53:00 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::7059:2eab:6d8e:5bb2]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::7059:2eab:6d8e:5bb2%7]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 08:53:00 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: Yxian Yao <yxianyao@126.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: RE: xenomai_init does not return
Thread-Topic: xenomai_init does not return
Thread-Index: AQHZINaJaeT+RzTGI0W7hWylAwSocK6Y8BDQ
Date: Wed, 11 Jan 2023 08:53:00 +0000
Message-ID: <MN2PR11MB4285AC3CEB4589B6A93EB7FFF2FC9@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <27c815f8.42c9.18580b3b14e.Coremail.yxianyao@126.com>
In-Reply-To: <27c815f8.42c9.18580b3b14e.Coremail.yxianyao@126.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|PH7PR11MB6770:EE_
x-ms-office365-filtering-correlation-id: d878ee43-e5a4-412e-538c-08daf3b13e5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SXKZmBESLfIAJviTj0DF7YC8cX9yct2KGVunDEyImt8RWSuGncQ+3sJUcsjXA+HvAF1ghGXSFeOSkres9ZKhwHgv+nArf8+HIUUuf+3eueknKsD2aTgWE3Oq9HvtCgskZOsjIG0OPsfsidvtvCopHTR9+s3kzZ7TBXtrFMfH1fqYI4J5WxKrKlHrxOwi8Z99LLcc4hN3ziRcQpTMgSnocLDGxG1UzMWy5X3jiIDLqLvfgL778nzxLWR0+ssq3pjdjhWo/mqrPMwm53+JpWdfdHDzB+WxvEa5FiETbdmxaxT8m4h/3OExgsxxERxGU+hFdriwhmE6UCcoqnxi5fPBXVLiUL5Xon/6z+r14fQZGEX9vgciRz6FJGRnzItdTZtTFv8e0GGGGdb1WZ+Cxp9u/zjLRss6O/hHER6MOtH0GNoyOYPOhdIMMhdoU9kUr27vzW7x/Zgak0zOqDhuzqyPpLyXj9vTW0QCZkkXYd0p4wbPnb3iaxHO6fEzfGIQe1LwxKmEXHFwDb1erVlsNY64gxOeqMVsMJlH47RmBxRX62cbjFYc87RKsad9Emv1gq/2visinyvj3OnkvSNF3/YipX6IPssG2pcnwv5ZMzvog+oRIhtD2UMbaVnGmtPEcNGwiCc2i1Lhkc2f3845CAcu4Vnn//z0whZaGwODlRf1vCYXB3Y4BKSIvPC/392T2ysIMgM80Li6VOVmDNTUQIVLDA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199015)(33656002)(38070700005)(26005)(316002)(5660300002)(478600001)(186003)(9686003)(7696005)(71200400001)(55016003)(41300700001)(110136005)(66556008)(66476007)(66946007)(64756008)(76116006)(66446008)(8676002)(52536014)(8936002)(86362001)(83380400001)(2906002)(6506007)(38100700002)(122000001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ditUNjhWTXJmYzlEYUx3NFVwWGhRQTNIb0NMU0FmMTRXVUZKNDhmRmZhM0pv?=
 =?utf-8?B?ZjVFODR6Tlllbk1yMUF2SGg0TFVwLzg2R2R6eStEMEpMTzBMTmM2MnRsZW9L?=
 =?utf-8?B?aWlOSHE4a1NOaFpWSDBRZjYwenJpZ2NLRGFvcG4wRDZEZDlXYmZGV3RFNW8w?=
 =?utf-8?B?cmtxQVM3MWcwbytWT2J0cmV5cnIrUnNYM1p5QzNxYTFZejVxUGVGNFlGYjRh?=
 =?utf-8?B?TmJTZDNiQk1rSmFoR1BKUjJKZ2pPQTVNQ2xqM3owSFVMWUNOcmgyTGZ0bnB0?=
 =?utf-8?B?WDhsd0s5TmJvNkdVWGZaVkhFeS9HazcrdHNBSDhOZFo0d0dYb2lQSWpaUWxo?=
 =?utf-8?B?UmpIbE5QZTZsNVVnbVFxb3lEeFgzMStjNzNLMW85OVZqZXpPWWRkR0RFZ1M4?=
 =?utf-8?B?cUdhMzY1Wnk0K0JVNnRNYWxEM2ROWUhidUJlaFBtbHRPM1ljZzVUYVR0VTE3?=
 =?utf-8?B?KzIzcUZSVHM3RlJHR2dIM21xTDdKeFZ5eWhxZ2hlUFU3TlNBZU5VMjBKaTVN?=
 =?utf-8?B?MGJ6eVl1dnRCR1ZvbHEralZRMUhSMVh1aytTVXFXdGw3RjJscVJtVVdGTTd1?=
 =?utf-8?B?ZWZya1J4Tmx0Y2VGSmJGMTAvWm0wS3Y0aUR2Si9pd2dDUzlYVm5BUTFxWUxi?=
 =?utf-8?B?a0UwaUVVREhlZURHdGd2enZwTlZEUEVRdEo0SmpPRzR0cTNPdmY4elI2ZVIr?=
 =?utf-8?B?UkdQWDNMMGhHV1JDNHNUTUtzbEN3eHY4dXh6R1AyZExCYnBicHRqbTZOblJS?=
 =?utf-8?B?bUYrWHZKY1laazEvbDNtdTk4ZXdVbXU4UmpILzQ5Umx3eld6cXpnWE12ZUJu?=
 =?utf-8?B?WjA2aC9Bd1NUTGJDeG01TkFGQ2pVNkVCeER2MnBZWWpUTFkwWHFuSGRCSVFP?=
 =?utf-8?B?VHpFL3RpSkxrMHNiR1kydTVoOTJTMEk1Tm96VUZMSERkZDNqWWlPM1h0YXAx?=
 =?utf-8?B?cHBDZXV3R1hTVGhxQ1dLVFBWRHA2MVIxS1JmMEh5TnQzUkdKRHA0cjZJWElL?=
 =?utf-8?B?M25Vc2FhWEFtUFpyb1p4WW5WWHRGZVpXRXQ2b0VvanJuMVluKzRKeDB1a2VR?=
 =?utf-8?B?K1IrMm8yaU82cDFPbEt6ZU9yZTdzT3hqNXJvUXZlc2ZhREtJWXU5Tmp1dXRL?=
 =?utf-8?B?MkNYSEdNMUR0SVJuME5QaXAvUHRFUXFsVEJObjYrb0k4T0ZGNTRna2Q4ejVB?=
 =?utf-8?B?K0JoSDl2OFRicS9nQXJxc2FRSnhDVFYzL3J2VXhpQVlhZnE5T2FqTU1qazV1?=
 =?utf-8?B?aGhPNnQybEV6aXRsNzcyVHZSbkoxcjZESWdFMWJLSHZBQWtJKzlzRTdRRHhC?=
 =?utf-8?B?SkFvZWJDWE8yL0RVdzFlM1A2OVFJYVdiS1pzc093ck11c0Y4TDNwUmpOL3d1?=
 =?utf-8?B?aXZyRUZHTmZvSE5kNGhyV1ZITHhaY1p2Wldzb25CTWZTVVppL09ZSU9OQThZ?=
 =?utf-8?B?dmg3bVBWVEJockl2dWFSUU5YVllrTzZ3Zk1ZUnkyMmdLaGJPWG1OcHFzWVRt?=
 =?utf-8?B?Q0t5aDcyRHRCbEoxNjc4Sk5kRDdNZWhiYVFJTm5lYkVuaGJLL0Jra0NMOUlt?=
 =?utf-8?B?UVhUY1RPdUJMTzlQQ2RDdGkyQklkakhRQlovVm11RS9ESmowNjR0VlM5L2po?=
 =?utf-8?B?OXRZTUg4K3ZhbERSTXZYSjN0bCtSQzVoaCtFTlMveFpKc3ZPcDNmWDlJMU1B?=
 =?utf-8?B?WS8vbUVJQ2FheWFnU1RQZGVjWDVLVHhkTGxYZ3pkQUNTRFAwZGROZXpGa1o1?=
 =?utf-8?B?bXlJaUIvRytaUm1QbSsyNmhlMzNzTnRLRThpQkgvVWVTVmtRUFUrQkc3OFNk?=
 =?utf-8?B?K0NSczhxUURubnoweENUa3EzcjVIZGNOK1dXL1g1bmFaMG9hd0VjVmF0eGJU?=
 =?utf-8?B?WWhkaTNQaUNmbnNaa3QwQzJxVmxQVkVCbDQxekdNclduQjNnUm1HQ1JGdVI4?=
 =?utf-8?B?Ris5a1dDekhoVTNta2JNelIyWnJhV1FBbEhTVm9Gak1BNkNjeVluakRqMjIx?=
 =?utf-8?B?SU5KNXVaK3VLbDZ2a2czeEJpVkVDVVhFOVlwdUhVUjFBV1gxSDRTUVdLZ2RG?=
 =?utf-8?B?OVM1RVhlNlNuL3VjL21veGhCQzQxdG5MdXZ2TTJMbWtLV0dYUk9tbVF3cmRy?=
 =?utf-8?Q?789alGpx6uPEuGxx8PYW1nutF?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d878ee43-e5a4-412e-538c-08daf3b13e5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2023 08:53:00.6811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: clScJhOljszmnt273dmpwiuRXwaHGZHjL1LiL0bqxYoQ+y4h7X5FTZbsC0W+/d0hWBEp90IB82h/6XRoVpoCog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6770
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFl4aWFuIFlhbyA8eXhpYW55
YW9AMTI2LmNvbT4NCj5TZW50OiBUaHVyc2RheSwgSmFudWFyeSA1LCAyMDIzIDI6NTIgUE0NCj5U
bzogeGVub21haUBsaXN0cy5saW51eC5kZXYNCj5TdWJqZWN0OiB4ZW5vbWFpX2luaXQgZG9lcyBu
b3QgcmV0dXJuDQo+DQo+DQo+SGksDQo+DQo+VGhlIGZvbGxvd2luZyBjb2RlKHhlbm9tYWlfdGVz
dF9tYWluLmMpIGlzIGNvbXBpbGVkIGFuZCBydW4sIHRoZQ0KPnhlbm9tYWlfaW5pdCBkb2VzIG5v
dCByZXR1cm4uDQo+UGxlYXNlIGdpdmUgbWUgc29tZSBoaW50cyENCj5UaGFua3MgYSBsb3QuDQo+
DQo+DQo+I2luY2x1ZGUgPHN0ZGlvLmg+DQo+I2luY2x1ZGUgPHN0ZGFyZy5oPg0KPiNpbmNsdWRl
IDxzdHJpbmcuaD4NCj4jaW5jbHVkZSA8c3RkbGliLmg+DQo+DQo+I2luY2x1ZGUgPHhlbm9tYWkv
aW5pdC5oPg0KPiNpbmNsdWRlIDxhbGNoZW15L3Rhc2suaD4NCj4NCj5pbnQgbWFpbihpbnQgYWdy
YywgY2hhciAqYXJndltdKQ0KPnsNCj4gICAgcHJpbnRmKCJFbnRlciBtYWluLi4uXG4iKTsNCj4N
Cj7CoCDCoCBpbnQgZHVtbXlfYXJnYyA9IDU7DQo+wqAgwqAgY2hhciBkdW1teV9hcmd2MFtdID0g
ImR1bW15IjsNCj7CoCDCoCBjaGFyIGR1bW15X2FyZ3YxW10gPSAiLS1zZXNzaW9uIjsNCj7CoCDC
oCBjaGFyIGR1bW15X2FyZ3YyW10gPSAieGVub190ZXN0IjsNCj7CoCDCoCBjaGFyIGR1bW15X2Fy
Z3YzW10gPSAiLS1tZW0tcG9vbC1zaXplIjsNCj7CoCDCoCBjaGFyIGR1bW15X2FyZ3Y0WzIwXSA9
ICIyNTZNIjsNCj7CoCDCoCBjaGFyICpkdW1teV9hcmd2W10gPSB7ZHVtbXlfYXJndjAsIGR1bW15
X2FyZ3YxLCBkdW1teV9hcmd2MiwNCj5kdW1teV9hcmd2MywgZHVtbXlfYXJndjQsIE5VTEx9Ow0K
PsKgIMKgIGNoYXIgKmNvbnN0KiBjb25zdF9kdW1teV9hcmd2ID0gZHVtbXlfYXJndjsNCj7CoCDC
oCB4ZW5vbWFpX2luaXQoJmR1bW15X2FyZ2MsICZjb25zdF9kdW1teV9hcmd2KTsNCg0KWW91IG1h
eSB3YW50IHRvIHBhc3MgLS10cmFjZSB0byBydW4geW91ciB4ZW5vbWFpX3Rlc3QgdG8gZ2V0IG1v
cmUgdHJhY2UgdG8gZGVidWcuDQpCdXQgd2hlbiB5b3UgaGF2ZSBub3QgYnVpbHQgeW91ciBiaW4g
d2l0aCAtLW5vLWF1dG8taW5pdCwgeW91IGRvIG5vdCBuZWVkIHRvIGNhbGwgeGVub21haV9pbml0
IGV4cGxpY2l0bHkgYmVjYXVzZQ0Kc3lzdGVtIG1heSBkbyBhdXRvIGluaXQgYmVmb3JlIG1haW4g
cm91dGluZSBlbnRlciBhcyBtZW50aW9uZWQgaW4gZG9jL2FzY2lpZG9jL21hbjEveGVuby1jb25m
aWcuYWRvYw0KDQpSZWdhcmRzDQoNCkhvbmd6aGFuIENoZW4NCg0KPg0KPiAgICBwcmludGYoIkV4
aXQgbWFpbi4uLlxuIik7DQo+DQo+ICAgIHJldHVybiAwOw0KPn0NCj4NCj4NCj5yb290QGRlYmlh
bjovaG9tZS91aWgveGVub21haV90ZXN0L3NyYyMgbWFrZSBjbGVhbjttYWtlDQo+cm0gLWYgeGVu
b21haV90ZXN0ICB4ZW5vbWFpX3Rlc3RfbWFpbi5vDQo+Z2NjIC1JL3Vzci9pbmNsdWRlL3hlbm9t
YWkvY29iYWx0IC1JL3Vzci9pbmNsdWRlL3hlbm9tYWkgLURfR05VX1NPVVJDRSAtDQo+RF9SRUVO
VFJBTlQgLWZhc3luY2hyb25vdXMtdW53aW5kLXRhYmxlcyAtRF9fQ09CQUxUX18gLQ0KPkkvdXNy
L2luY2x1ZGUveGVub21haS9hbGNoZW15IC1nICAgLWMgLW8geGVub21haV90ZXN0X21haW4ubw0K
Pnhlbm9tYWlfdGVzdF9tYWluLmMNCj5nY2MgLW8geGVub21haV90ZXN0IHhlbm9tYWlfdGVzdF9t
YWluLm8gLVdsLC0tbm8tYXMtbmVlZGVkIC0NCj5XbCxAL3Vzci9saWIvbW9kZWNoay53cmFwcGVy
cyAtbGFsY2hlbXkgLWxjb3BwZXJwbGF0ZSAgIC1ML3Vzci9saWIgLWxjb2JhbHQgLQ0KPmxtb2Rl
Y2hrIC1scHRocmVhZCAtbHJ0ICAgIC1sZnVzZSAtcHRocmVhZA0KPnJvb3RAZGViaWFuOi9ob21l
L3VpaC94ZW5vbWFpX3Rlc3Qvc3JjIw0KPnJvb3RAZGViaWFuOi9ob21lL3VpaC94ZW5vbWFpX3Rl
c3Qvc3JjIyB4ZW5vLWNvbmZpZyAtLWluZm8NCj5YZW5vbWFpIHZlcnNpb246IFhlbm9tYWkvY29i
YWx0IHYzLjEuMQ0KPkxpbnV4IGRlYmlhbiA1LjQuMTMzLWlwaXBlLTYteGVub21haS0zLjEuMS0y
MDIyMTIyOCAjMSBTTVAgUFJFRU1QVCBXZWQNCj5EZWMgMjggMDQ6MzQ6MDQgRVNUIDIwMjIgeDg2
XzY0IEdOVS9MaW51eA0KPktlcm5lbCBwYXJhbWV0ZXJzOiBCT09UX0lNQUdFPS9ib290L3ZtbGlu
dXotNS40LjEzMy1pcGlwZS02LXhlbm9tYWktDQo+My4xLjEtMjAyMjEyMjggcm9vdD1VVUlEPTY3
Y2UyNThjLWNhNGItNGY5ZS1hZTU5LTM2ZDIyMTJkMzY2ZCBybw0KPmNyYXNoa2VybmVsPTUxMk0g
eGVub21haS5zdXBwb3J0ZWRfY3B1cz0weGYgaWRsZT1oYWx0IG5vc21hcA0KPm5taV93YXRjaGRv
Zz1wYW5pYyBjb25zb2xlPXR0eVMwLDExNTIwMG44IHBhbmljPTENCj5JLXBpcGUgcmVsZWFzZSAj
NiBkZXRlY3RlZA0KPkNvYmFsdCBjb3JlIDMuMS4xIGRldGVjdGVkDQo+Q29tcGlsZXI6IGdjYyB2
ZXJzaW9uIDYuMy4wIDIwMTcwNTE2IChEZWJpYW4gNi4zLjAtMTgrZGViOXUxKQ0KPkJ1aWxkIGFy
Z3M6IC0tcHJlZml4PS91c3IgLS1pbmNsdWRlZGlyPS91c3IvaW5jbHVkZS94ZW5vbWFpIC0tDQo+
bWFuZGlyPS91c3Ivc2hhcmUvbWFuIC0td2l0aC10ZXN0ZGlyPS91c3IvbGliL3hlbm9tYWkvdGVz
dHN1aXRlIC0td2l0aC0NCj5jb3JlPWNvYmFsdCAtLWVuYWJsZS1zbXAgLS1lbmFibGUtdGxzIC0t
ZW5hYmxlLWRsb3Blbi1saWJzIC0tZW5hYmxlLXJlZ2lzdHJ5IC0tDQo+ZW5hYmxlLXBzaGFyZWQg
LS1idWlsZCB4ODZfNjQtbGludXgtZ251IGJ1aWxkX2FsaWFzPXg4Nl82NC1saW51eC1nbnUNCj5y
b290QGRlYmlhbjovaG9tZS91aWgveGVub21haV90ZXN0L3NyYyMNCj5yb290QGRlYmlhbjovaG9t
ZS91aWgveGVub21haV90ZXN0L3NyYyMgLi94ZW5vbWFpX3Rlc3QNCj5FbnRlciBtYWluLi4uDQoN
Cg==
