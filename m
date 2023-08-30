Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F20A2D
	for <xenomai@lists.linux.dev>; Wed, 30 Aug 2023 03:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693364756; x=1724900756;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=7mFMiu50GAoeslzX/Ysk25WhLBujgFrMXJMBqV4u4nQ=;
  b=P88YWckaPvfn0f79v8YdT1xfL6TB7+pUFwYEchlQRiv3N89s9ukJQ2m0
   Au/pCGszYmFaC8+aXOVpMRM993QLiuk9BHDUstCiG2DoVJ9JDZkf/CQ07
   LCkALYCCjBAuYQwuQU1P/dWUFDP7evyVqCxnsojEszCsRwszdoe2txsqz
   r114jVy0tSGzPphnYFPcFNDBVrf95z0XVuChypdIpnyDRmOdXJfuRz7RH
   tdcm4wRz0XgRhtBrijG/meusCGDWpgGrGnBRoVu/1qBMJ7PNkBBLbv1Bd
   0P2SMeJgvonZPQdRgjGrKg3a3ZM5h+smV5th9LcW0EhVrG1ZWQrfHSuVV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="355853552"
X-IronPort-AV: E=Sophos;i="6.02,212,1688454000"; 
   d="scan'208";a="355853552"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 20:05:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="773956682"
X-IronPort-AV: E=Sophos;i="6.02,212,1688454000"; 
   d="scan'208";a="773956682"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 29 Aug 2023 20:05:56 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 20:05:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 20:05:55 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 29 Aug 2023 20:05:55 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 29 Aug 2023 20:05:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1o6Uz/0fgYArzbb9Spje8B0krKjFDv8oH9TvtZvSOWdvcAblm5K6pyllg23Vo56BwRyNu98C41M7l6TtQwGXDk0lG16s1IuKqH4j6E1BGFFl/mueBP6oNbgOlcYGctCdGPXd8Jp4+XxW1ZA6T4GMWvip1q4tEh6+YBNbU+P3surICED0i+CQnfzWqStfSHpsd8SqmPz6O6kKUdfyOKdLrZsKhQjfw/pvmwr7/1xaa8pOsUzEJ3kNaZ6amZhzD117GOQ1dyMnK8+YrvSkyn9CMyAy+7ghNzilySkOZhYrV731SyGtjmonzU0YgbSRKkuQQcglytfI+4tTF8dhwb6Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7mFMiu50GAoeslzX/Ysk25WhLBujgFrMXJMBqV4u4nQ=;
 b=jJj31X5eTsZPIOI9LNHx8Z/hUKVfEn+VI6O6cSGmBHTdnbY++HkxvG303eGcACzv2CK2yxqgMRKjRzmhrbiwku6AtP87tVdqQHJRaW9M0Y0U3sm6AYBufDs+gIeY7iHN+6a9wZde8y1pJIKUx1FJnELyVVR6ST/s+eIc7tXJAnJA7XqqwQbQ+YH6ifeLgKCh3CyWyfVBqrwY3wbWituomsnV2aStrOCxCnpS71Xqql8JnwCzLRxhOwbTNgKmBRx7t0Pgoqtm3qToHcbTUpt3SIG0ICW8sVsjck+UvJuBGGy1Fw6I2YVUpDqHRb7TTalVCvvzf8Tjz5NVoRcJ876vBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by SJ1PR11MB6249.namprd11.prod.outlook.com (2603:10b6:a03:45a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Wed, 30 Aug
 2023 03:05:51 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::9f36:bd07:796b:9d38]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::9f36:bd07:796b:9d38%7]) with mapi id 15.20.6699.034; Wed, 30 Aug 2023
 03:05:50 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: irq storm on sd/mmc card detect gpio interrupt alloced from pinctrl
 device
Thread-Topic: irq storm on sd/mmc card detect gpio interrupt alloced from
 pinctrl device
Thread-Index: Adna7t33BX+CE6qmT/ikjq1kbx2b0Q==
Date: Wed, 30 Aug 2023 03:05:49 +0000
Message-ID: <MN2PR11MB42855A234CF8BF7D17E9E2ECF2E6A@MN2PR11MB4285.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|SJ1PR11MB6249:EE_
x-ms-office365-filtering-correlation-id: 745b9e60-9113-4445-b96d-08dba906039c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EzijAOtvyr8CVsw8Svh0oirDYaBrFPYTQERZTNRjucKN5jLxXjT0LIPJCXgluaMDW4gNEv2z2HUgr8icyNqZTJ3NBHU3OZNPlYF2HnSNxfJpRAtslZF8xls/rd0Cc1RFicCKOmO0Yq8F+NGomfqdZeBCvR6J9mv6sdVNCdwTNhcQR1MzHxZ7rr/6BnKQcxBaJl9JKMc9VsGsuPbFJYavlohjHzdUnbbA5hoRn6m4gVygqbdKmPHPQnl+mQ1cijLNRmLkslm9EXTDzA1JGtAKA5xdqkJIKRi6IviScdZ2BZZfkwRh8jo0sDW1MxwT9egFr3l6B8KI1Ja7ZI3ZGEezAV4tP+ipcBnmVrOtKQcDBPkydhuJ89aL7Smhnw8y+DPDH/KNkiRDI0J/sd5lf6uJf5q2yzeJAlFip2CVXjXYpaGUqC9XMFwNnzBPvOS9M+/Nrl6g21WaV11e1nETZog266P4u3haJkqNaLvWEL85GS6ARZ6P0QQTnsODny9QLetfZb3hRDjYts1KjkPSG08REjAcvEnnH/CaMgb4rjZE4pkljt92Olt4yooVQ097CbTAowqdg/GaPgzQi3EvukTNp1XTb95uVeU4C4KWaleEmjKscChYFNqE6rfCDoEfea/U
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(376002)(396003)(451199024)(186009)(1800799009)(71200400001)(5660300002)(7696005)(9686003)(6506007)(55016003)(4744005)(2906002)(66946007)(86362001)(33656002)(41300700001)(66446008)(64756008)(66476007)(76116006)(8676002)(38100700002)(8936002)(52536014)(316002)(38070700005)(6916009)(66556008)(82960400001)(122000001)(478600001)(83380400001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K09hRVJMOHJVZEhtb2VOaVdsL2tEMW5RdHZCcmwxK3NISEtKdk5yZW9vYUEw?=
 =?utf-8?B?VFhNNmJUcFkxWXBZdmJvcFcwOVZHTE1mY2didTYwYVAva2xhbElSakJDaHY5?=
 =?utf-8?B?OXJtS0hlNmMvQkpJMkpkaFFoSWEvb3ZJSGIyNkNkSTBHT0E4bUVEdG1HMVdQ?=
 =?utf-8?B?RjZaUzV1dWh5TWZxR3pEM3hHNUY4aXV4RFc0eWltemRqUkNQdmpBVHhUOFJy?=
 =?utf-8?B?UlNWZmZIbTZnRStVdk13RlpXWWFFK3RDV0xIdnYybERBdTdsL05vUytDRjRq?=
 =?utf-8?B?bXhNUENYZmczNUIvQzZFc05Nck40K001bDRPaEZxZDEwVkRLZGlqZmNUaXM2?=
 =?utf-8?B?ajI2dXR3RElzUm1XYXpyaVpFNXVRNFpyQThvNzlJY1BMQ29tbWlUVWFLY1I0?=
 =?utf-8?B?M2FaMXFkNG44emZDdkZ3R1MyYkx0aU9hR25PQkxVMnRBek5XVHRlclJjemg2?=
 =?utf-8?B?aGluRWRNdmgxVUFoY0tlczVRMTU5UHN2T1NhbThxa0RzYW5KZ2ZqSVpOdmpw?=
 =?utf-8?B?eEp0RTd0YjdXcnBLcDRDUFJ4UFRzZm5kbk1PaGdOcGZRNTRyT0JQYWFKT3lv?=
 =?utf-8?B?SE03ODFzaFdMd290OXI1aDRFSWt3QTRENUVscUpJYXVYOUZXaVFXeDZacW1j?=
 =?utf-8?B?UlpReHZQOEpYM05wS1duWjFXKzExV3VQNzVBQVBTVmc3dDJTZUExb01NcDd2?=
 =?utf-8?B?M3JaUkhQb0o3MFgwZDNycnc4R0lLVXlFNFFxcjlQL05WTmJqcTlwTi9qWnhW?=
 =?utf-8?B?RlFCOElQaC9TOWlwOXJSSWJoQWdYTURGK3NKMEFxUitsb2QxdkRqcXJONnZY?=
 =?utf-8?B?dHNZWFd6dUhzdXVjUEhkY0lxM1FnMmdQc242NDZOVUlEQlc2TjVXUXQzd3dF?=
 =?utf-8?B?QlRrREUwM05jTWpkU0R6OEhjMVI3MTNXYTh2ZXY4RHV3R1VHNm91QWpBTUtN?=
 =?utf-8?B?NGI1eFRPZy81MXoxemhYWTVPRmppbzBVSEFXM3h1cnBkd3JFRnU2VTl3UURZ?=
 =?utf-8?B?UHZPWFYrUVR6MmNBNUFGKzRCbmUxbUo0M3RydWtobXFtbFNEUFdqTHVSUENL?=
 =?utf-8?B?MjVhV0ZqTk4xYWh3UzFkYU9iWUVuZ0FNbVpiTXFnNkNEbURIMk1ZSXltSXB2?=
 =?utf-8?B?UkJlWGRtNEFvcksxSkRXekFhcGVqNmhwYnUycDRwaVJMMXBzV25GK2hUK3dy?=
 =?utf-8?B?V3FJbSsvaVNKRUNMT3ZuRkJReUwwc3dUaWJkeHdZQ2EvWjZXMTVUSkxkekNh?=
 =?utf-8?B?ckdRVFVBYlBOeS9MdXJVRWJVc3FJOEFHTjA4ZktQcHc5THpwS2FYRWFQVFlq?=
 =?utf-8?B?cU9XbE9zNThvZXdVeVpwbThaRFVDT05iQjc1bmhaLzNZU3pyN0F4Tzh2RG9O?=
 =?utf-8?B?bTJtUXZMMHh6azRYT3VTZUFGYTlOZk9aWnlFVC9DQ0xPVWh0bTlLcGYzcUVm?=
 =?utf-8?B?NTBOOGRCSGpOSDI4Q2lta3gvM1RJRG1OUU9Fa1h4T0d1dWpLYlIzYU8yTlJj?=
 =?utf-8?B?WjlnSE82Sk1TLzNXYzZtMHRKcERicUNkbGtRc1dCOWx0SHpqc0NEY1RwL1V5?=
 =?utf-8?B?T0xTQ21sUEZuejVMK3RTYWE0UnZUL1QrSWtXMllnajZmek5OOVBFWENQZEs3?=
 =?utf-8?B?Q041NG5Pc3p1OVVUVG5raXFhQTkvcXRoZzNXOURXTEdSYVo5dllhNjBXeEEv?=
 =?utf-8?B?SHoyWHkzRXQ4Vm1JSklDV3IyOUNxUGo1eFdwVlVoMi9LTFRSekpMM05mb1Vv?=
 =?utf-8?B?NWpUaUVhSUc1amtzZElYK0J5NE43WXVLcGxQSXAza2gwUnk1M2lxdDZ4Vlgv?=
 =?utf-8?B?a0V2d3NkcWlmcVRZVUtBU3BPS21ka2pINlcwc1pZRUllVjVBajBKejVOODBE?=
 =?utf-8?B?Z3VKdnhzeXplUlNpWG9NOWJSYS9oNUV5anpKb2xrM3FhajF0L0JxYTRTdDF0?=
 =?utf-8?B?WjNFUFJUSC9kVGxRVXRPa2VWdlFmaDZZb1FOVklkdFVjUzJ3d25pdVFYT21q?=
 =?utf-8?B?TDlLYWhRVDZsZWt0dUN2STN4TXFZL3dYR1VoVGp6ZGJibWk1b3R6QjUwREZF?=
 =?utf-8?B?ekJFTUI4THdKRnk5M2FhdnlVRmRhNDJWVG5udnpFWUZOZHIrVXM2WU9Cd1Vl?=
 =?utf-8?Q?Hk1tBXN0lCx3e7KTiXTMFG1H0?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 745b9e60-9113-4445-b96d-08dba906039c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2023 03:05:49.8421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vbg5qlxr/KOKZBK2Xm9b4/Iqtl4tjr+Cdk1WQLem7Df+NbzlnT49ITyUPC7Bf0n+wzvo+RDiwbGtpi3g/YiHOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6249
X-OriginatorOrg: intel.com

SGkgUGhpbGlwcGUvSmFuDQoNCldlIGZvdW5kIHRoZXJlIGlzIGlycSBzdG9ybSBpc3N1ZSBsaWtl
IFsxXSBvbiBzZC9tbWMgY2FyZCBkZXRlY3QgaW50ZXJydXB0IGFsbG9jZWQgZnJvbSANCnBpbmN0
cmwgZGV2aWNlIHdpdGggWGVub21haSAzLjIgRG92ZXRhaWwgNS4xMC4qDQpBY2NvcmRpbmcgdG8g
b3VyIHRlc3QsICB0aGUgcGF0Y2ggWzJdIHdvcmtzIGZvciBzdWNoIGlzc3VlIGluIG91ciBjYXNl
LiBJdCBzZWVtcyB0aGF0IGhhbmRsZV9lZGdlX2lycSANCm5ldmVyIGFjayB0aGUgaXJxIHRvIGNs
ZWFyIHRoZSBpbnRlcnJ1cHQgc3RhdHVzIGZvciB0aGUgTGludXggZ3BpbyBpbnRlcnJ1cHQuIA0K
DQpJIGFtIHdvbmRlcmluZyBpZiB0aGVyZSBpcyBhbnkgc2lkZS1lZmZlY3QgZm9yIHRoaXMgcGF0
Y2gsIFBsZWFzZSBzdWdnZXN0Lg0KDQpSZWdhcmRzDQoNCkhvbmd6aGFuIENoZW4NCg0KWzFdOg0K
Y2F0IC9wcm9jL2ludGVycnVwdHMNCiAgMTQ6ICAgIDI0NDAxOTAgICAgICAgICAgMCAgICAgICAg
ICAwICAgICAgICAgIDAgIElSLUlPLUFQSUMgICAxNCAgICAtZmFzdGVvaSAgIElOVEMxMDIwOjAw
LCBJTlRDMTAyMDowMSwgSU5UQzEwMjA6MDMsIElOVEMxMDIwOjA0LCBJTlRDMTAyMDowNQ0KMTI4
OiAgICAyNDQwMTkwICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAwICBJTlRDMTAyMDow
MSAgMTEyICAgICAgMDAwMDowMDoxYS4xIGNkDQoNClsyXToNCmRpZmYgLS1naXQgYS9rZXJuZWwv
aXJxL2NoaXAuYyBiL2tlcm5lbC9pcnEvY2hpcC5jDQppbmRleCA2YWNhNmMwMzZhZGEuLjRkMDhl
YWYwNzZlOSAxMDA2NDQNCi0tLSBhL2tlcm5lbC9pcnEvY2hpcC5jDQorKysgYi9rZXJuZWwvaXJx
L2NoaXAuYw0KQEAgLTg2OSw3ICs4NjksNiBAQCB2b2lkIGhhbmRsZV9lZGdlX2lycShzdHJ1Y3Qg
aXJxX2Rlc2MgKmRlc2MpDQogICAgICAgIGtzdGF0X2luY3JfaXJxc190aGlzX2NwdShkZXNjKTsN
Cg0KICAgICAgICAvKiBTdGFydCBoYW5kbGluZyB0aGUgaXJxICovDQotICAgICAgIGlmICghaXJx
c19waXBlbGluZWQoKSkNCiAgICAgICAgICAgICAgICBjaGlwLT5pcnFfYWNrKCZkZXNjLT5pcnFf
ZGF0YSk7DQoNCg0K
