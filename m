Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980DFA940
	for <xenomai@lists.linux.dev>; Wed, 31 May 2023 07:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685517935; x=1717053935;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=uSqddtbp35zNj/qX4jBGPj7L3wRE1zbN73uqu9ivQNw=;
  b=QIzm1HodSSH2lAJQNQl+9+Jt5tQ9C/VOG3CfpQGhbmAbwn7tyZK4aZEr
   C9pTjfV32kbK2WVbx7yI+o9CdIP3SlYkPj2GZ0fqM+Rh1f+YMq6ktgjEn
   e0WJbfBjq3eATNjKVFWHagRmvsLMqOKEZbcs3aTmkoC9oGaguHRuayx6j
   7pHfTp2RgYNlDaiTCWdKCpkdbakgpD91qJF7SKXHDERwKNr+EPkxhCWcb
   89MGOCWDyGYwKJ0P3LSWjT1SA0pjZNMM/T0IfarLnXOTPiDdMG/f6Qehs
   UBZ/66kNWnxf8e9892u3SMlAe2zCiha+9eZcvZH7ZCL2A2FnesItkz/us
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="354006689"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="354006689"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 00:25:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="684297412"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="684297412"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 31 May 2023 00:25:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 00:25:22 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 31 May 2023 00:25:22 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 31 May 2023 00:25:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JzasZI7xpbWcwX2Sn6rhAjVqfn4lLF9m6oNlioNv+vbf9kuqqTNEJ331t5QCRFSS+F3ZaD4FB7oxd3WoJIYDun4rIqomLCh9fCXGQH1LFFuQ1CFnLhuEn8gsUULlekHJ+70Rw3/i2+COMSr4PvqSKjxgr5IfXVDYXsbUMGKgvWbwCGRc2YTFuYRLM/eetMxD8FXVuoUc0EpYpwYiWh7OdYkxZq7X9nXQBc+x6mA/kwvrzePsK8ZpTt8DavW1W/jIPaNvOE0aFMMEBWPz/22TIVQ8pLVMSiSQpzEaQOdhZM//PvYIji7lIjDGls5AKb6QE7/NncrmQsnWPw64Xca03w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSqddtbp35zNj/qX4jBGPj7L3wRE1zbN73uqu9ivQNw=;
 b=iEZVAZoWkkrir2yx2503kVsjak2ZxdlruKQ4TG/XkP1xBDNuO9oGWpEItAJHy8t8YeSgKrrF+/L80vK+ByG1eNoBsnnLCBQtuY1ihKi4YJzvVAzQo7U5wnu6Co8ICD2bOyl1p1nUDL/X+SBjQ+aeVcYZoMqCx1msyXAk86gzRa3f1iO/TPdyFHDL9nycZaUx2N3R0Q4cSEW3h+PtW+BLZ+/PL32z0hST/OoixRZPHDyt8H3hB9lRVF2cJlhzBA9r6E25skvgGxPWDqrqU/MQcqA4MHSYhrpIRSc0/F5hydmGpWwxskZWm8QAiL6JGh560vRJpaDV9pWavrp6ZKCLFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by DS0PR11MB7287.namprd11.prod.outlook.com (2603:10b6:8:13f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.21; Wed, 31 May
 2023 07:25:20 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::56a8:e9c:284:f6a8]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::56a8:e9c:284:f6a8%7]) with mapi id 15.20.6433.024; Wed, 31 May 2023
 07:25:20 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Xenomai Community Call Minutes - May 31, 2023
Thread-Topic: Xenomai Community Call Minutes - May 31, 2023
Thread-Index: AdmTkIjvKVUydsVyQImk7FJuj5yzzA==
Date: Wed, 31 May 2023 07:25:19 +0000
Message-ID: <MN2PR11MB42858F3B6BC9FBF0CAFA5F10F2489@MN2PR11MB4285.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|DS0PR11MB7287:EE_
x-ms-office365-filtering-correlation-id: 6cb4eb6e-8d55-49c1-77d1-08db61a8306f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MMvwNkAf/lP4MGAMTVkAcAYg8ck+MkL/7GZ0olE78P9KXCqERsCB+PB718OukhqdLIICJtUq48GHJ/2nezPK/w2YZcahZnTu8/gMeRPhSdY6x/nI/GAJLctJn+eFZWPrxaK3PMqJhmu4OpXFgiWCKMXbmOp1LmIvdbN8i86CsPo4+sfuDxn9McIMpzU050mjnU06FD55vjgIDaPeViVy4cbc1ohTZ47sUzood5VmV2XtfpcbiHV5Oa89fbMJ/5qpK99MCjsbWslfn6mA4Imnv60tAErKoAezDXLQvAbtEgisfyGHNwrzm3yrH9rFpWQ0xqoh31VBWtY3bpu+XJEC60iLnbUd0BiyDxe4Oi1hGMpLIKzFycY1MqO2WCSO6a+pR0mtZ4zdWAG4p284VlITdzAAesCctmv51W8VytlFG53vTgEHhEO83bJce60Q5BKIFaR8tLtTNZ8uGTCXIs6OhKol0fxUxE+HOocDvcXmsGqbiqruXZNYw670uAjgAQLCuSgBLFUX7ODYA4ONEbF4gEQuoVWhVH6L8f/CQ99k5gaB0akNT0ATxpvS/ML0iTRV2ml9Jmlw3Pdqo05M7kQsibX7rf73YJczgvVU+E/WUDOTMI1mKxaTke1N7dqSNQJ+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199021)(316002)(71200400001)(82960400001)(38070700005)(38100700002)(41300700001)(122000001)(55016003)(52536014)(86362001)(478600001)(66946007)(186003)(83380400001)(7696005)(6506007)(558084003)(5660300002)(2906002)(9686003)(26005)(6916009)(76116006)(66446008)(33656002)(64756008)(66476007)(66556008)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z29VNUh1aGZBQVRnOEd5a3Qzdzh2OStOc2hmYy9OcGdzTzF0RHVvMlh3dzJy?=
 =?utf-8?B?bElYOGNjRkdqY3BBbnlyQ1Jua216elR6K3JaZ1ljU2FSVXBIdDdrUmxITVhX?=
 =?utf-8?B?TW9rVGZyYVZQWTJKT01XanFoT3huK3p2c3hlVFZDSHZRR0k3THRubTZkVktk?=
 =?utf-8?B?WkE0WTNsZUJWVkFzRDV1TFZUcFFEN3lIenBwNW9KeHc3ZG1HUGE5dHZwY3NH?=
 =?utf-8?B?Ri9xZXJxMEtsZDc0Ukpud2lQaVJVWFBlWmJVZThpeTdoak40VitFam1DKzdq?=
 =?utf-8?B?cGk3TlZkMWxIc29iMktXTnpkRUZWSkQ5cEVoT21hWEFMamtIZFE2N2labmlO?=
 =?utf-8?B?U2c2bFFmOUtJcmVpdExMSU9lYXVZOTBWd2pJSS9CenpDT2N4UzJObkNtMG5B?=
 =?utf-8?B?Vk9EQjEyZ2tMQnR2ajZJSTlzVTVQLzFlYmlGWmhoQ2p4akphYUczVTdxYnli?=
 =?utf-8?B?OTZ2WWY2YStON3ZTaXlRNFMxNG5qcG5UNUFReEVPNjNBSXNnMk5DNXdsaEJT?=
 =?utf-8?B?SVp3S0h2TUpsdGFPdWdKWHhlNUNHWTM4OWVFV0FMOE5BdkZ3UEJLbkhGZTdJ?=
 =?utf-8?B?WjBQdXdvRDJmbEdpeTJjWlRCY052SzMvTDZOaGlTRkk4c2s5MGtsZ0tGaU9q?=
 =?utf-8?B?ekNvajNSU20zNnNXTTZ5Zm8ybUZjelhVVytxekx6VjlYVy83QVVuQUJIL0t4?=
 =?utf-8?B?ZlZUZEZzZ3Z5MExXSTRUc2JGOTlyZjc3Zmk1bzd0aGdZbUJndENHUGk5UmdG?=
 =?utf-8?B?MW1JYzArVHVFY04ydUtuSFlvVE12MW1zSktsM3A5b3BiVFpqbzhzMGo2bllY?=
 =?utf-8?B?ckFpbys2UHRhamhzaDRvY3ZXdmxJdmR6YWJHVlIxY2NsM0x1S3JBdnVHRFZJ?=
 =?utf-8?B?RHNjeTR5bDRJb3EvQjV3dHBab2pOa1cyUUQrS2k0NXo5Y3lFbmVycFlPTmNB?=
 =?utf-8?B?NGhVMWlOSmJIREUyT1JDTG00bFNVY0d1eDZHcVJieVdNdWpPSCtyTGFGREJn?=
 =?utf-8?B?UnRoQWVGS3NlYldhMGVDQ0lpcDJlWXl2Q2tBZGpDRXFnaFgvN2JTTlhESDNw?=
 =?utf-8?B?Ui9YWHUreWJUM29Va3BCU0hPZGhhQ0pNZlI1NmlEbHcyNGo2ajdjQ25UTDVS?=
 =?utf-8?B?TnE2Z3dLLy9WaEFGRnVHTm9YSGRDSHd3SW5UeWg5dzFmT1ZTL1ZRN1Z4NXQ1?=
 =?utf-8?B?Q2NicTBuaGNKRUtaelZXMnRHV21vQks0RHI3eDdTSTh3enBiY0IwODdVUGpo?=
 =?utf-8?B?MGJ4RzBLOXJXeUNFNnJDNEwxQmxIRVozWEFkN0Y2ZjRsVzk3K0RvaldyWkRU?=
 =?utf-8?B?TnQzL0xsQkVzd0FXKzA3K2hjMm0ycm5taHpKbUpaMFFtTTZmb1ZselJ2RHk5?=
 =?utf-8?B?dCtJcysrQ3JRazNGeDZnZmMxWDJvVGFCdjlXVlE2N200UVBWSlZaN1c2N2ZT?=
 =?utf-8?B?RUdVMkF6OW5LNS9aUi9pT3B4YVArN015RnFjdm1SUXFjcEpXUjc0dytobWdI?=
 =?utf-8?B?Q2VYUzRXVU42b0EyZTVPYUxpbFpsVGR6eDk3WGZJMHZKZmNWajhOV2VjN2k4?=
 =?utf-8?B?bkN4WndtNko1d3ZWaEs1YlJuYklHa0IrNng1ZXRQS2xaWnZCZXlwM2NXZWE4?=
 =?utf-8?B?UzFhYVRCZHg5akdMSkwzZmJvL0x0MEFMM3lqNThLZm1YbjhjbkhlNzdyOU14?=
 =?utf-8?B?QXExNkNPUWcxSDBESS91QU40bER4dHNPaG5Mb0gvcWFyNHhVbk92WUdzdStI?=
 =?utf-8?B?OHUyWVZjV3pDRUhaZC9reVJFd0RGVWZ3Q2QvZDd6b1BGRlVVZlBlNCtudThw?=
 =?utf-8?B?ejgrK0J2WVdxN0Q1WTR4VDJIVlZXK2NrU20wa3pPU2xJNVVYMW5VeEI2ek0y?=
 =?utf-8?B?aHV4TXFsNXVlNW16aE5SZFkzV2NWdzZRalVUQ3RQWkFDMkZMZG1zdkRFOVNS?=
 =?utf-8?B?R2ErcVc2UVozUC83Z0Nua1ZtN21FMGY1SUYyWEFTQnQrSHI1eVFFWGRSaEsw?=
 =?utf-8?B?YWdNNVV3Sm5ucmhFWHZ1amRXRTVxK2JJN0hjMlNHanNVRjBwL0NUWWhTaHc5?=
 =?utf-8?B?OTNXMTB0U1lxS1VDRWFjdHVqTFpyUENSNVpmc1d6cGhCd1RUSmdiOWFHdVNC?=
 =?utf-8?Q?3tcHuA70J/sQIkCd6t1F/LMTG?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb4eb6e-8d55-49c1-77d1-08db61a8306f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 07:25:19.7564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TczJmRiKLzsdjr6b1gqXqGh2BXluTr90oMM6US1XD2Dq+R4rCa2vw5pcIONDZGUOToMm+cVQzLRdZ4lEGGe8Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7287
X-OriginatorOrg: intel.com

QXR0ZW5kZWVzOiBKYW4gS2lzemthLCBSaWNrIFdhbmcsIFJpY2hhcmQgV2VpbmJlcmdlciwgQmV6
ZGVrYSBGbG9yaWFuLCANCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVG9iaWFzIFNjaGFm
Zm5lciwgSGFvIExpLCBIb25nemhhbiBDaGVuDQoNCkNvbW11bml0eSB1cGRhdGU6DQoJWTIwMzgg
aXNzdWUgLSBkb25lDQoNCg0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQo=
