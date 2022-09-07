Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B517E
	for <xenomai@lists.linux.dev>; Wed,  7 Sep 2022 03:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662520515; x=1694056515;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=OCJ32kFN0YETmQTir+otyqE+aKhcxTMQaeJFkBJ10OI=;
  b=PdlyixaaSuhXdPaHMbwqQQxTWyhY3/nHgq9Vp/5v7o1fb9wSnKtUd1uK
   KBZ6q3t3kyizTgyyZbtIIHDW7ggGFbTPezDfYCWl9Cml+vR6q2yh5TN4r
   U/dpEN/x3G0zA2gLWOHC0sllX6yYv+tDS0g+yUtbgNCTYqwUCrER8YqBi
   uJ8uJbecwVMZrdNCi2vtG/lQAxZfz9dIVA7QLBIeFliWpm46qttSsat1X
   OMA2XIIIzc8YU/3Bc0Jc0p2vIrf91kwQIwxO4c2GiRqpKWE1Ssc2m9+LI
   Y5cXywFmj4QhKyUA6jvVeGzQOsR7sXYcADWAKPg0ofwhUgjB6GxBTuU+L
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="358483020"
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="scan'208";a="358483020"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 20:15:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="scan'208";a="565341138"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 06 Sep 2022 20:15:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 20:15:14 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 20:15:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 6 Sep 2022 20:15:14 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 6 Sep 2022 20:15:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bcn1UepKsMeq/JnC6QlyAznX201jFygI4+fiaYuSQtKA64Rr9prYuxKCV90T3XcFRghtqbq3E9bkYW1ZlR8DJMz0v5gZOYa+l7mD6cNlYDVTx7/wiMNxOgC4HTLKBrrrB9Wd+DEvHyE7/LXJ6YyMNbTdlImGKJnYc8szcKmGQ7/yYzWBLoAcsrc+EAbIGqCXiRCY2+XarYHN8Alw04tFqIdlQEJ1q+29Dw1BWFTlsV7KDZDaIBO6ttM09KUmSs3WkVKwhPLWc6CZ8vKlMXTBFhjvfPehbHsvajRJe72TlW1q2bdffAoQlnjJLfrsbiNQnYpYQnlu6OqgVU4Iow3acw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCJ32kFN0YETmQTir+otyqE+aKhcxTMQaeJFkBJ10OI=;
 b=mOB3v/f+Ui9m5HLYEZyZ92+QG9jFWDgQdHwuQ/+flhcwFDyqiRZd3tH42+zQd9943y4lLvYf+nVhwzk5Hl0f+/N4xtKqCkCBz2F+G3FPTO7g6DTkJZmTJQNSJ2wiMtGs7B7Zgfn19DtaRtN47r3Vm0bDMdNC6A6epSR+aqrhJIEPM6kQM4txqCiM3vFOCSJjfTBwjlulclTIcw70tx30cblm2aYU8XlvVLs3Hm9Jhe1VCcjWkmdkZqLjYkUR5Q5HQ0AN1q2mT51aFGgV+1q2rXwj1W1drsvUjuXsN6JwQKH8qthRJfSJmt/Ee99ISl5bimGT8ToyipHDST0tiTXexw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by CY4PR11MB1464.namprd11.prod.outlook.com (2603:10b6:910:7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 7 Sep
 2022 03:14:58 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::159d:a6de:f2b9:fc83]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::159d:a6de:f2b9:fc83%3]) with mapi id 15.20.5588.015; Wed, 7 Sep 2022
 03:14:58 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday,  Sep 7, 2022, UTC 7:00
 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday,  Sep 7, 2022, UTC
 7:00 AM
Thread-Index: AdjCZ92FzNSBIbFGR6mIt7uKA0co3Q==
Date: Wed, 7 Sep 2022 03:14:58 +0000
Message-ID: <MN2PR11MB42851C96E75936255DFC4874F2419@MN2PR11MB4285.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 163d278f-c9df-467a-c5c5-08da907f2513
x-ms-traffictypediagnostic: CY4PR11MB1464:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MNTyvGTZ+SyM6kLoizmGJ0ZP4TfjZd4qyqYhczDgf8ddDmtGJNHKboZHC1q1+odK54yJv8G59lLPcUcnw7ozZZYAh7sWCkNZJmi5rvEKJu69rCo85yEYIC8aLrN23RCXCg0T8h6ksA7dNgD0jPZzUfIO1CySluIv8y+sXwo8fWh0Iy9haBukfF1UmB5I2FEHWPHWpf1yYNqh50LmfnKOLseiXhThtQV9FFXFRBdYLzaqIP97G0n23tUo4biAeEKIaph8wjJLYCT0qU6klj3g7ZfMr4hZJKWz9WdPgypOCncEnPweBXAS75xg8aZhqgUmw+unHt8vNATWmb3kGgGB8KKD7ZJhlL5c2ys4dVGXZwyyyBtUUcJmZdVr7ojCBSdkbopaoTveLkC0VgCaMwSZHjgE+qGI6C5DGXEomMx7N9JfUp3OFG3JUkeU3Zhvp7/jiYgLpJS3tyKhLHy66v21Mj4GwmZZKVjAxDjEI+OylTsWUFluuY103VOdYmsFscLbIzYCA0HcB/bfnJUIiZrZlowFHc7z+KJAXDN21075bNeQ4P1whbcH0mpRY8gVxRb8+XX19ZwgSQF2WHl+sGfGUAiswMqaBDwzTDu4uT0pSyHBy7aptKNtqK7kPIEBlKyQIeGo76fNA61bBHzRK8cTcHtxc1sG+vcmhxzxAeL98YQ5qu84yGXgXT9QXL4WM2GvFaKX+qpcTdAP2orNBHEY1ALuyqHH5B+ChUjf/TyvYhqV/mPf4zbW7fMy7njtbNW+kph4V4BBOA4eDblT4eUWu7Zg3QLIak9AXa7agtnC3wU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(376002)(366004)(39860400002)(346002)(40140700001)(52536014)(41300700001)(9686003)(966005)(8936002)(122000001)(26005)(2906002)(33656002)(478600001)(38100700002)(66946007)(66556008)(66446008)(64756008)(66476007)(86362001)(76116006)(8676002)(7696005)(6506007)(5660300002)(82960400001)(38070700005)(186003)(6916009)(55016003)(71200400001)(316002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUlsS0I2UEVVUkQyTGZNVlliWFI1dmk4RjJGTllMRXdYOFcvRVVRSXZkVERq?=
 =?utf-8?B?T0hUYmZEcnRJT0haNE1kekdGb0xZa2h5UTIySGN3SUxJSmhtMXh4UEVDWjFI?=
 =?utf-8?B?Z2NwaEFENmNoc0NRTGduMWh4VTdJWlUyd0U3b3F3aFMzS1RqeWVpZXJxWFFJ?=
 =?utf-8?B?MUlwQXBpa2dqTkZGcXZWR3J2Z0JYVE45ZGJtY1QwT3RHY0o0Z3dQT2NpZ29T?=
 =?utf-8?B?aGptQXR2clBidldFSmxpWktuVHJoUEZKdjFld0JJdEVTUGc2QStZUzNqalBM?=
 =?utf-8?B?MWEzNnExUkduZThWbHVQU2pvWk1HYzRaT3BJVEI4L0xmTWdySnJFdnY1RXBB?=
 =?utf-8?B?YzI4eUhCc2l6L0FCRzBqL29QQ1JKK0ZYVllnRG9wQThKbnNibkhidjJBNEkr?=
 =?utf-8?B?Rk1GSjFrbFZFNUppTjlwakJLOGZ1QnhGbUVPNXlRcm1Edm4zZkpxZi9IenZN?=
 =?utf-8?B?cG9RLzA0UUxBUkVndjRoamFjODFMMWw3S1l0V00zTDFsbkRUeTg1N1puOXY2?=
 =?utf-8?B?TjlXZDRSUU9EdXhHNldyTlhjTnVmU1N1dFlZMkU2WWl5YjRycFFDTkhJSkYz?=
 =?utf-8?B?SUd3SVNON2lYNHFLL1haRTNBMU9UK0xCNG4rWGdBb3NucXJBdzNhZXZmaTJI?=
 =?utf-8?B?QUFaWk5Kc1lwNHRUTlFuVjM3eGJkdjlFYmF3Q2Q4VmRySFRWS0xpUGZ2TFFG?=
 =?utf-8?B?T3RJclhlYTJJWW1xMFR5SmNaSEFvb2lkR2RDcHluVkNJc3hQa3JmZDk0cGY2?=
 =?utf-8?B?cGhCd1hEOUZ6NEVranpvUG9aVVBNSEtwUC9ReFJrZ09ob1UwTlZzZ3UwUjU0?=
 =?utf-8?B?RFlqRWtFTDUrQmdkZXhmWStzUzlJZHZZSG9WcEQ3L2NBT1B4SkNMTGpYK2dY?=
 =?utf-8?B?Y2J6UDJqb202ZHZJTU4wNVhGS1E2aG8xMGVpTVd6ZVpZSnp1cjNObEIyN0h4?=
 =?utf-8?B?Y21yLzljbUtVZis5STNuK283QWVOZ2F2MENaaDBpZ3lsMTZzVFJCNjAyR2s4?=
 =?utf-8?B?QlhWSHJTSG9hcy9rVG1FRVlaM0J3UUIrdkxZVHpXeThtd3k0VFViT0d0V2FS?=
 =?utf-8?B?RXlwaDZPZ0MySGxaQ3BhOWM0Wkc2RzZFcnQzc3k5VFB6N2VJREJIemgrdkFv?=
 =?utf-8?B?YlRCRTI0R3BIMjZUMTljdmhRWXlsaWs5R3hydEJLNGNtRXJMUFA1eXJzeHRF?=
 =?utf-8?B?SW1PQnRsMVBXVmE4S2FadHVEVWVHZ25Rb3FMR0dwZVlhdDZCc3JJZC94TXRF?=
 =?utf-8?B?TmlFVW4vZnNSYStDU0NpbStteUpObysrQ3pXR2hVSWdMc1FiUmNSUk5tckgv?=
 =?utf-8?B?YTZCMDBaeThGL0ZlMjVCSDB4NlBMTjF5Nm1wRGJ0dVJDREc2TTZ0VlhYMzFi?=
 =?utf-8?B?dWVuZjZmdmpBNjZhRVZwbnpISlF0VDdRMlovajVRSXRjZU52THBjRmhpSGJP?=
 =?utf-8?B?SjBtSWlrR3FSMVNYODJiOXJWdnlaRXlnMTFMckJRMk94RldObFQrZ0NsVEhp?=
 =?utf-8?B?TytWTkFOck1rTHlWTkJ5RGkzRVFWRmJGWnp0RHlOQjh4cCsyM0dPVDkybHV2?=
 =?utf-8?B?VkJFZElxelpTUFRqV0hwdlhidHBZOE05dGZnVWJEWk1oeDl5bGFITHE2YmV1?=
 =?utf-8?B?MUxiVlFTRnZLOHVveXVYR2JWenVnWnBsOFN6WlhsNzVubVFjNi9VNVRPalZH?=
 =?utf-8?B?M3dCd0pMdGJ2WVR1NjBlS2xGeDJzVVI0bmtoalNmYnlqRkpVS3VZTFQyOWxx?=
 =?utf-8?B?b2RvaWVCV2xyYjNCa3IxTWpJR3drM0U4VGM0cGxHaFpOZ0ZYREZveFlMNjZV?=
 =?utf-8?B?TUVCQjZXZi94QnF0ZW00ZFRzNlpSQ091UzZoSHpRcXF2cU5XOURlbktYdS80?=
 =?utf-8?B?RnFOTXFlUEhHNkRlTFJSaXdyazZ1QnRUNDVETzVrYXc2TjFNNlBxZnpscUZC?=
 =?utf-8?B?cWNDbmY4UUlxTFY1cEZDTCt1K3pBSWtoYjZoTVFXeUd0aDJyMEdqRHE2b2Mx?=
 =?utf-8?B?azBOcENHY1BKMHlQbjVEanhCTERTWmhHdDk2NjRaUm5MaDJQbjRiUGtnc2Zr?=
 =?utf-8?B?MTU3WVhDZm5RSHp1RjdVMmVqTFM5UERhWmtKeUcyQ0Jpa3l6cXcraWJpbmlC?=
 =?utf-8?Q?Eou5ZirqvoVe2wtc9JJXlfV4q?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 163d278f-c9df-467a-c5c5-08da907f2513
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 03:14:58.3333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JlvltS636OTAXgNCAcjwYcvPQ6Ci4AloTeLzPYQhc51YJP88MItb1FobJDS2BV/lMgLy/Hz4FULNZ9QA1ZloDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1464
X-OriginatorOrg: intel.com

V2UgaGF2ZSB0aGUgWGVub21haSBjb21tdW5pdHkgY2FsbCB0b2RheS4NCg0KVG9waWNzIG1heSBp
bmNsdWRlIGJ1dCBhcmUgbm90IGxpbWl0ZWQgdG8gdXBzdHJlYW0vZG93bnN0cmVhbSBwcm9qZWN0
IA0KcGxhbnMsIHN0YXR1cyB1cGRhdGVzLCBhbmQgdGVjaG5pY2FsIGRpc2N1c3Npb25zLiBJdCdz
IGFuIG9wZW4gb25saW5lIA0KbWVldGluZyB0aGF0IGFueW9uZSBjYW4gam9pbiBhbmQgYXNrIHF1
ZXN0aW9ucy4NCg0KVGltZToNCldlZG5lc2RheSwgU2VwIDcsIDIwMjIsIFVUQyA3OjAwIEFNDQpQ
YXJpcywgRnJhbmNlIENFU1QgOTowMCBBTQ0KQ2hpbmEgQ1NUIDM6MDAgUE0NCg0KSm9pbiBab29t
IE1lZXRpbmcgDQpodHRwczovL2ludGVsLnpvb20udXMvai85MTI5NzI3OTI2OT9wd2Q9V21kd1Mw
cERPRFJOTVM5dFFrNTRZMWR2YkZscVVUMDkNCk9yDQpodHRwczovL2ludGVsLnpvb20udXMvd2Mv
am9pbi85MTI5NzI3OTI2OT93cGs9d2NwazUyYTlmOTZkOTg5ZTdlMjBiNjI4YzJjMzZlNDhiNjhl
DQoNCk1lZXRpbmcgSUQ6IDkxMiA5NzI3IDkyNjkNClBhc3Njb2RlOiAzNjc1MjgNCk9uZSB0YXAg
bW9iaWxlDQorMTI1MzIxNTg3ODIsLDkxMjk3Mjc5MjY5IyBVUyAoVGFjb21hKQ0KKzEzNDYyNDg3
Nzk5LCw5MTI5NzI3OTI2OSMgVVMgKEhvdXN0b24pDQoNCkRpYWwgYnkgeW91ciBsb2NhdGlvbg0K
ICAgICAgICArMSAyNTMgMjE1IDg3ODIgVVMgKFRhY29tYSkNCiAgICAgICAgKzEgMzQ2IDI0OCA3
Nzk5IFVTIChIb3VzdG9uKQ0KICAgICAgICArMSA2NjkgOTAwIDkxMjggVVMgKFNhbiBKb3NlKQ0K
ICAgICAgICArMSAzMDEgNzE1IDg1OTIgVVMgKFdhc2hpbmd0b24gREMpDQogICAgICAgICsxIDMx
MiA2MjYgNjc5OSBVUyAoQ2hpY2FnbykNCiAgICAgICAgKzEgNjQ2IDU1OCA4NjU2IFVTIChOZXcg
WW9yaykNCk1lZXRpbmcgSUQ6IDkxMiA5NzI3IDkyNjkNCkZpbmQgeW91ciBsb2NhbCBudW1iZXI6
IGh0dHBzOi8vaW50ZWwuem9vbS51cy91L2FURUEzN2k1Rw0KDQpKb2luIGJ5IFNJUA0KbWFpbHRv
OjkxMjk3Mjc5MjY5QHpvb21jcmMuY29tDQoNCkpvaW4gYnkgSC4zMjMNCjE2Mi4yNTUuMzcuMTEg
KFVTIFdlc3QpDQoxNjIuMjU1LjM2LjExIChVUyBFYXN0KQ0KMTE1LjExNC4xMzEuNyAoSW5kaWEg
TXVtYmFpKQ0KMTE1LjExNC4xMTUuNyAoSW5kaWEgSHlkZXJhYmFkKQ0KMjEzLjE5LjE0NC4xMTAg
KEFtc3RlcmRhbSBOZXRoZXJsYW5kcykNCjIxMy4yNDQuMTQwLjExMCAoR2VybWFueSkNCjEwMy4x
MjIuMTY2LjU1IChBdXN0cmFsaWEgU3lkbmV5KQ0KMTAzLjEyMi4xNjcuNTUgKEF1c3RyYWxpYSBN
ZWxib3VybmUpDQoyMDkuOS4yMTEuMTEwIChIb25nIEtvbmcgU0FSKQ0KMTQ5LjEzNy40MC4xMTAg
KFNpbmdhcG9yZSkNCjY0LjIxMS4xNDQuMTYwIChCcmF6aWwpDQoxNDkuMTM3LjY4LjI1MyAoTWV4
aWNvKQ0KNjkuMTc0LjU3LjE2MCAoQ2FuYWRhIFRvcm9udG8pDQo2NS4zOS4xNTIuMTYwIChDYW5h
ZGEgVmFuY291dmVyKQ0KMjA3LjIyNi4xMzIuMTEwIChKYXBhbiBUb2t5bykNCjE0OS4xMzcuMjQu
MTEwIChKYXBhbiBPc2FrYSkNCk1lZXRpbmcgSUQ6IDkxMiA5NzI3IDkyNjkNClBhc3Njb2RlOiAz
Njc1MjgNCg0KDQpSZWdhcmRzDQoNCkhvbmd6aGFuIENoZW4NCg==
