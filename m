Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C45160
	for <xenomai@lists.linux.dev>; Thu, 18 May 2023 00:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684369463; x=1715905463;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=fPnXTo+eawGOUBr4abPwvlPht4jVEZA1hNhMs8gcdmE=;
  b=DSIECq8nTiCY3VTtin2/6QbyZ3mUUZj4o6yxrkf2AzRUPymuvWnr65/0
   M58OhaMUBT6F9kUThsQjkrqZGsXmhJ2irlUUpViO8WFlce8HcmpF0aAwC
   zSJLn14YUJONECN8Nr8gBY9/hw4Ew+JNOjfZfxvs2Zq1DGqsrjPnG6AK5
   Ya0TRePexiAr0EWKSJ9O7B3QaJvF02K0JpCntzdOJH7VHYc1nihnHh2IH
   5aDtuZNX6JmjpF+VgcGL+7MgTRuccfh5C7qM2dSKRkgj7fIy6vpB9E8gX
   uiVZpdfyPrnWWUksgBUerbgGJytVW4P7a5/mdOOTCkhd9KM/3Y8m8puw5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="351936393"
X-IronPort-AV: E=Sophos;i="5.99,283,1677571200"; 
   d="scan'208";a="351936393"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 17:24:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="766967231"
X-IronPort-AV: E=Sophos;i="5.99,283,1677571200"; 
   d="scan'208";a="766967231"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 17 May 2023 17:24:15 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 17 May 2023 17:24:15 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 17 May 2023 17:24:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 17 May 2023 17:24:14 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 17 May 2023 17:24:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xj1Ab3YOcNFS3wuZr/MtEVSXXDGmsVqP4ZGnewDNDSPI6l1qZKOmg7kSuZAbhqdsGysR3FRKwKWA0POuwm3UVhKq/EabpN145ZDAtNhSGRnMlVzKE4U5Ed2XAF+YD5JvPj+WFAJdsdhqsCSnqPmpBUQZy9MOdD8fa1m7Ex/NfbO0GLnbNugE33ezvSyhq2Yx8iA7OrGnF8emYHvnR6PwYTetfcj+IrG/1BYxpW5EyJYZVJutyPJgoW0VrFdfqD/P6jyQqF67o7L/U49j5OkCD2ZsKE0t7vQEXYyFO3pmS2BfJobTbqq2+ImPUWWw2ubXzjYdDRYe2yGTlKXmxsZyFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPnXTo+eawGOUBr4abPwvlPht4jVEZA1hNhMs8gcdmE=;
 b=NDOJE8fmOxksJrn81q0ZeV4LbWY+QXg3q0eGDiP9aw5+UnSwJxZgzFJP0I8l64vjEp+b+YCtKeo049JvJvj3t/tsiRaAk8IEkGGDib1ifDqFhDJFEgqwiv4jVQ979874OevR2TSM5PKfMSxOwuiszIbTGkTlr3DKHU0SO8bM1pam1cHrR8fH8KVJg+7B74tWr9bd8hotngjbojmWmxgKvc2V6irg1hULm47Kw2rndWcq5HVctpB90YHQMpp7VuK3D5k3femDrtNqU81BF0C7bR55nFsMYR5gntzIK+15b3f74pkfwW33SCKgjVfD8E/tBOAvv5b5gWN/Qe57HEIKiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by PH7PR11MB6428.namprd11.prod.outlook.com (2603:10b6:510:1f4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Thu, 18 May
 2023 00:24:12 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::56a8:e9c:284:f6a8]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::56a8:e9c:284:f6a8%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 00:24:12 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Xenomai Community Call Minutes - May 17, 2023
Thread-Topic: Xenomai Community Call Minutes - May 17, 2023
Thread-Index: AdmJHsp79UJ3CkwOSwK/TqiXWJW98A==
Date: Thu, 18 May 2023 00:24:12 +0000
Message-ID: <MN2PR11MB42855A25C00199E2CFCAF8E9F27F9@MN2PR11MB4285.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|PH7PR11MB6428:EE_
x-ms-office365-filtering-correlation-id: fbf73cf3-d659-464b-902b-08db57363478
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0ljD8IHuIp5kJIAlKv4DNEN/R4+EnelIcYYu8bxERkq3TaCBq/ha/gmXQcgiajsxkJAIFHwKf8GIxXdNc+AJoZBRWbcbfX6AGvFZGcGRsBpIJNfU385DPD3oMl7LZx5aFM4emfyXSd7aTaOJ/PUyP9Pww9j01fN0h/oDBSsPaG7mEgfOlyUy265ofoVrz20rsiwwGXCjVHXth1VsqytLIZHQNgZyFrG12l0nrohJZLy43Iv0unvBeF96hJ/SRIauDQV0FddEvvATz0GL/JQzihcIKdaO8UQqDJsXQL/GRzgXXlnky7Nx/eVEKIyVjtO8+Vu3tM1XuaGcBiMVMIA3AwyD1cbsEhgF6I2ouYbh6iPs1JffPoecAtyTjdxtQdB//B07iB8X+gO2we3MPROz3TcPW7iciDcDdCt7pVaoEK0ABmu6fk+L5zYDaNNWvctLysOK6BRpPrqR3hlbSKFdaZ5b1bVAncecPPdAM0kHkpvFfKa8M6Q55R6VYiHsHf0pI5mcr/Wi6VfA/YXa/nyKuI4S6BJA4g0acfp0ZOC4dxGx7+C9VmGqpZyBflig1TSbo6Tkc7Cnhyol18HvPPI39M1s93b8MSxLUwMbnombtdNln4QLtSTEsmja2C46qHb7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199021)(8676002)(478600001)(41300700001)(66556008)(82960400001)(122000001)(64756008)(66946007)(6916009)(66446008)(316002)(76116006)(55016003)(66476007)(71200400001)(8936002)(38100700002)(186003)(9686003)(38070700005)(4744005)(2906002)(26005)(33656002)(6506007)(83380400001)(5660300002)(7696005)(52536014)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUorUFlYYmlJdDNsVjh6RDRMd2RPempqa2orRWo1TXVDU2dNTyszbWFpLzhO?=
 =?utf-8?B?UUNab1hPZ1FQaUlKUWtIekRQbndKbjA5ZTdjb1RBYzFYa01wQVNZU1RySHJk?=
 =?utf-8?B?bDdiY2VJVm1QM21nczZkaVRSWVlvYzVCOW43Uk1iM2R3a3gyc3ZSaHg3YXEw?=
 =?utf-8?B?bEJJZWdFbk9JY2R4ZGNqS1dtMUZ2Uy9hUzU4R1NlbzN3Rlk3aHFSdU5Eelph?=
 =?utf-8?B?Z3dhbUhaQWp4YXlrUC82bENFOWJFR2U2TkoyV3Q4MTZtYlhlai9YZ3B4clB3?=
 =?utf-8?B?a2xSY04rc0ZHNzhkMkh5Q3YvenVzK3VXSkN3Yzdoc0ZVMlNzbjdpT29LdkFh?=
 =?utf-8?B?ZVZFTjNHMGFHdHBXVmJFU24vYW85QkNUWTc0S0trRVV4SWM4MXJjSjVUSXR0?=
 =?utf-8?B?Z2Nmdkt6UmhSZC9pd3IrQ2JKZEd0bTc2aHBCMmFqeWUyWEZ5Yzk0ckhxRTNh?=
 =?utf-8?B?RUNwNkNtNUluYnpzVmRHRnZhbFUzOENxYUV2anJvQjRCdlVvK29sSGphZGhr?=
 =?utf-8?B?WmRPS1dtVGxpS1ZiRGhnd2RSUXpuOVlIak9CTzVnYU9YQldQMVhQcVB2aVdy?=
 =?utf-8?B?T1BYTk9RZGYvc2w3azB4dmJTempIVmp4amxXcGJjaklqaG5mVjIzeFBtblZV?=
 =?utf-8?B?NGRKQnBZdzViZ00vTG40dTZraE5xYXBnT0FlbVc2YmRpUXFiMGU1NUhZMlJI?=
 =?utf-8?B?QVdHRENTRUtCY295VkxlK3hzcWRSSnJKQWJYUkxlT1hQc1A3ZEJPSHpSSjAv?=
 =?utf-8?B?SmxxbmFqMkdVUDBGZDBHRWNnenl0Y0VIajdzZ1U0d2gxTHRhNWV0VEdsSVlr?=
 =?utf-8?B?cWhhYlRRKy8wVUFROHlWVTF4N05vZ1dNeVBlWG0yWFR5bDFYNTNERmhpSmV1?=
 =?utf-8?B?QUNYV3kxUkdlc3h3cEdsRXRSOGhFTGp2VVNFWFpQN0xZbmZrbUhYYnlQS3U1?=
 =?utf-8?B?RXRQQS9HRXpMOGQ4YjBkTDhLdVI1cXdYcG9kdlNMVWNUVzdmYkc3S2Y5SWg3?=
 =?utf-8?B?VkJxbGRQRGlnZS9Rem1BcktZQWw4Q0lRQVRVTkN0Z2xUMkVpRldmdWNwQjZI?=
 =?utf-8?B?QzA4dkVlN0czOEFWSXhTc1J0MGRuNXRhQjBvY1hKeVRUbEovV3ZkOEdhQmFJ?=
 =?utf-8?B?S0ZRMnNwK0RnRmxhZEpYTHVlQ0dBZE1EdlhjalczUDRMMUF2RXVHZHlCMzgy?=
 =?utf-8?B?Z0tOdUpSYVZITnR3M2RWZmF1WjRtcUJLMFRQVzFxUDZIMjB0MldQMXovSUhW?=
 =?utf-8?B?S3lhZ0JLSlRaa2dxQ3ZlaDMxaFBNZlkwTTIrOHdGbVZicEgzL0ozMmgyY0tX?=
 =?utf-8?B?c0Z1YTdqYnNYdnZheFFHWlp0b0NYWVNLTUF0MmpHeEdacEtlK2RjVDYrNVJU?=
 =?utf-8?B?bTZSWkU5ZlBuODJ4WjhiallEMS9hSTBBZVNQOWhsWDUrVVprdE54bUdqRnk5?=
 =?utf-8?B?bDRPdU0vK29XMC9XOEJiWnh0ZlVZdE5HS2NFYXF4WkFwVE5zcFNWQ0I0OEdp?=
 =?utf-8?B?dUZsUDdUTEpGNmxsMElZc3N5UUJod2ttNi80NE5JQk1WQWd5QVdzcERHTEM5?=
 =?utf-8?B?ckN6bmFkS1Z5QnZKTS9jYlg4Z0RHOE9mekR0MW1sQTJGalV4YTdUTTZUN3cv?=
 =?utf-8?B?Qkx4MzExVmFJRGFBNzAvYzBBbENBTnhleVdLWGtKUUJCNWxmTzcxTmNrbDBl?=
 =?utf-8?B?bm5sNXRrWDFBU3EwaEJjWC9qOElneGJEWWNrTHB5czdGM3R1MHJKNEZ2ajVJ?=
 =?utf-8?B?Q0ZMdlAwMncybktsM2RHTGs4cVkxa0hNQnBoclJjMGF5WjNUZHFIRWltMGF2?=
 =?utf-8?B?REVPblpIeUhRZTV6SmxaNiswL3NReTNkcFFROXk4d2EyQkI1UHM4V2VzY3or?=
 =?utf-8?B?S1hzakJLU3RveUlSN25PZTkzcysvQWRVQTdWRGVQOFpUR2JKb21DSWpVM1Na?=
 =?utf-8?B?TG1nTEFKaEVpOExWc0IzYnRGWTE0NzlWZ0pueHJ1V1NFNkdSano5N3d3YXd0?=
 =?utf-8?B?NEtkSXNSenRKMDc2SzRIR0VieVAzUW1lUnhDV2xTV3JiTDVZdEdXMDQwc0dw?=
 =?utf-8?B?WVdJSHlNOUovd0p5MS81VjhRWHJUNHFpOWtJQytiam9zUUpQMThhZlRDVFNG?=
 =?utf-8?Q?m/x1oLe4fbSdgfjwVsn9zvLPC?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf73cf3-d659-464b-902b-08db57363478
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2023 00:24:12.2727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qRXZcK4iNhtQGXkqCqAP6R6e9fFidvm3H9CBy7S3z6kROtbDQ5d6Qry2oXwo4TKU4l+EZpLPO1SpMuIkTn7YEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6428
X-OriginatorOrg: intel.com

QXR0ZW5kZWVzOiBKYW4gS2lzemthLCBSaWNrIFdhbmcsIFJpY2hhcmQgV2VpbmJlcmdlciwgQmV6
ZGVrYSBGbG9yaWFuLCANCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRGF2aWQgT2Jlcmhv
bGxlbnplciwgVG9iaWFzIFNjaGFmZm5lciwgSGFvIExpLCBIb25nemhhbiBDaGVuDQoNCkNvbW11
bml0eSB1cGRhdGU6DQoJWTIwMzggaXNzdWUgIGlzIG5lYXIgdG8gY29tcGxldGlvbi4NCglSVCBz
aWduYWwgaGFuZGxlIC0tIG9uZ29pbmcNCglFdmwgcmVsYXRlZCBpc3N1ZXMgLS0gb25nb2luZw0K
DQpPcGVuIGRpc2N1c3Npb246DQoJWGVub21haSBtZWV0LXVwIG5lZWQgbW9yZSBmZWVkYmFjay4N
Cg0KDQpSZWdhcmRzDQoNCkhvbmd6aGFuIENoZW4NCg==
