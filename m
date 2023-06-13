Received: from redirect.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCB017C7
	for <xenomai@lists.linux.dev>; Tue, 13 Jun 2023 01:27:04 +0000 (UTC)
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay10.mail.gandi.net (Postfix) with ESMTPS id 5F9E8240002
	for <xenomai@lists.linux.dev>; Tue, 13 Jun 2023 01:27:02 +0000 (UTC)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by spool.mail.gandi.net (Postfix) with ESMTPS id DEE61940E9B
	for <xenomai@xenomai.org>; Tue, 13 Jun 2023 01:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686619621; x=1718155621;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TSBDrBcTP136JxiLxaNsu+0W/YiIzPMnRzgK/4Bqjt0=;
  b=H24drVOWSv+FmKkOg8BFAx7TkxCCUPoSk8yJPtD3LmtkbFk7U4VtuvAF
   YLIySoXpS6Dl4IYj2SXTKqyyQwrBzqSyRLGP18JoXi6rzLCORTxTp5w3x
   FLCSV7gDSsTVy7iaVOUmx1Ro/97wizof6iQK0RCIOONyzPFe9LAa39sZI
   uDVVUXRw8ZGtD9o7LDCSz30aT5BYVlCUq5xQeRQB0egZ9scuJM8gYm2Rd
   xCfh/t25DlxfpGTylrGnNm2BeRyoBQUTH7TP+zCaNpgtVLe+2rxJpxMv8
   mIM1EtY0J3+qLyPmP8TCiaveL6QkmXUkevWl45dWji7oEozn4WzWcYQTW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="444577334"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="444577334"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 18:26:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="744514000"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="744514000"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 12 Jun 2023 18:26:57 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 12 Jun 2023 18:26:57 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 12 Jun 2023 18:26:56 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 12 Jun 2023 18:26:56 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 12 Jun 2023 18:26:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFtuW4SnqVNx85jEpKCBFRAfYWi8FEawbGoetEQYtWdNDDuLC5z13wEAtaOVGHLpDExlogK7xKIaPxqQy+ZinABwJxuL3KvTitGq2VBfO+pCUmRurZXGOt1UzPW8z7U8mieKs8exdGY5326GEqu0GvqK8JyYxrzXh3lqr1nMCgFrvfqSNJOqoTYHzs77ezteYxtnMzft6Sr2oiSyF2YQ6kpEiO0s9fGNiDMxyfaKsQOvA2kWHK0mlRFfd3BDjTgFOtclQuo9zMjgjGHInGmGPItTYmzzZKhKzm8kAe0vuQtuOsMtNlXzRz0pIE1atghloj4WR94WNgEjg+8Q1+Whow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSBDrBcTP136JxiLxaNsu+0W/YiIzPMnRzgK/4Bqjt0=;
 b=Skr4hOS6lAB/tlEuqHu6Z2hyvCUvkE47ZO5LZ7vGCJZEyxRm4ANQc+fZOFWQbWdTjNO7svNh/RkQ6MFKp8mdSRTfHS4IJt/8THjJl4Mn/oVBE0GQGCjIYOk3EaisCAPGITdQ8F45vz38NjjC5HtPdN3fMiUWDns06CBrg5FAtw6jem6pBJIYgitP8/DnDVkzruEDGUeHQaGrQ6IGxiKJdW5DipT+mYfjntlLCXaDJJGLEaJd26XMgQBHOMbmh9QJTDj/vNJOOTQ3a8oTCp2n6jCMNiU9m067nHQRm2kGA2/yZAvBP0p+igX1AHI1PAz76adUu/SneQGIvvZmr8CFtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by PH0PR11MB4774.namprd11.prod.outlook.com (2603:10b6:510:40::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Tue, 13 Jun
 2023 01:26:53 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::56a8:e9c:284:f6a8]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::56a8:e9c:284:f6a8%7]) with mapi id 15.20.6477.028; Tue, 13 Jun 2023
 01:26:53 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: Richard Weinberger <richard@nod.at>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
CC: xenomai <xenomai@xenomai.org>
Subject: RE: Massive variations of execution time on x86
Thread-Topic: Massive variations of execution time on x86
Thread-Index: ecxCFjAboALDcvYMCoVCc8urSYAceJq2B3qAAAFT3oAAHbkSsA==
Date: Tue, 13 Jun 2023 01:26:53 +0000
Message-ID: <MN2PR11MB4285A757D474F8E0FF2AEE75F255A@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <321584983.3714817.1686565517697.JavaMail.zimbra@nod.at>
 <dd6b33a8-f53c-8c51-a30d-2688ddac1709@siemens.com>
 <1832934245.3714909.1686568547516.JavaMail.zimbra@nod.at>
In-Reply-To: <1832934245.3714909.1686568547516.JavaMail.zimbra@nod.at>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|PH0PR11MB4774:EE_
x-ms-office365-filtering-correlation-id: 3704667a-3479-4862-d035-08db6bad4504
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UZM1ADwm/ooz80Xs+ZuMMXgpY11ckNF6c01z3ibo52VZaY0Tzl4gwx3UquF6ajqGyttaAGcL5yrnhh7WQE5Q4+bzOssUuE1aD4ggETZk3e5dNIgI716f9yJMGewhzEq0+Uy7yRyTtd9UUBJZet+Oo5nLPvh0FjoEZZ2xlk4AuAZa8G/AspFbsD6wKo8Te96++MEchGmgGKRuevOXv6IKTqIj4EyQsr44OBuwzZLkVM34wIhF7NjLpeOzbbxomhkzEEj2ui5eCgrSZG2FRuYZBpvsC31U+CPVGZKNz+lGKozgjde21QoMQzGpRNtm4Cq4dd78EExjYdczyIbCs5PS7irTYOElrlsniNr0v0pXeZQfPd26ZCmNji34dd1Zs+GuSFjiCIae/em4oC4o3NfMZylyCaqhnNCvYuc7IpIAHCoZzRDCDPFgoT1oklbB/rUPX2Ylm8DKFAfP7wOAVfsDzDsRDddf/tdfSfIFD/FIYiF/EHD5VGa6REzyKiLIc5AVmq0FIcy26yHmTsLBucSfase5OXfoohXV/vNMXHHlq928/pTDNg5Epz6pgyfjfzdIADXhogTfNnFHDNpWIiWqcI2/PoMD5K9gl9jZNyVdpen4Lu5a8wPi7Td6hru1tdIU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199021)(86362001)(33656002)(55016003)(38100700002)(122000001)(82960400001)(38070700005)(7696005)(478600001)(71200400001)(110136005)(8936002)(8676002)(64756008)(66476007)(5660300002)(4326008)(52536014)(66946007)(66556008)(76116006)(66446008)(316002)(41300700001)(4744005)(2906002)(66574015)(83380400001)(6506007)(26005)(9686003)(186003)(14583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejJDQmpPTEVoRHBFMnRaNlJPTkJHK3dHRHJBZkpSMWU0SVhITG5pVTRleXVo?=
 =?utf-8?B?MGlpVUJYVm1WOE5FVEJLWXVxMnBUd1ZQTEhRMGo1dndFcEU2bzhxODNrdGpz?=
 =?utf-8?B?Zm4vZEdUdG95VXQwSnpJTUM4bFpjQVRQcU5EZElWOWJPYUZFNGNlY1Rua2dv?=
 =?utf-8?B?cUpmVXlQRUYrM0FtUExxUlN6WEkzYk9ySXJNUFBxcnhXNjhETC9rYWwzNHd6?=
 =?utf-8?B?bU5WNk45Y09pOEVRYTNldGxTcmNmNXRFQ2tDVUZxWnFuYlNlRk5nZDhHRy9D?=
 =?utf-8?B?NklMbkw3eElkY1d3QnhSS29jdk1nZjU5Q1RqNXVZZWJQeFdEdDNySTk0bjB4?=
 =?utf-8?B?MjloaktBb3MwUWlqUWVWTVNXZjJmMHFGdXA1OWJaVHA0NUlHbXdSdFNLeVE5?=
 =?utf-8?B?NHBZOUhaMDhZdFdqTXVqbEVCbGU4STFRV28wVXh2RVhtNUE3MG9XZjMxcDBJ?=
 =?utf-8?B?VlpJVEVYWU5USzAxbUJ5MERBcks2S1VDcW50YVd4MFIvaEV5bFNRN0pwcXd3?=
 =?utf-8?B?UndhcW5TSG1TQWNHUlVEZEY2Mk1vMW83d3hCWWF1S2pSaVVZSDFhWmtzekJr?=
 =?utf-8?B?eVdoRXQ2U0IyaUp3aXNsRVdwczk2ZGpDYzNhSEhFK3pzYmloTVU4L1dSQ0tS?=
 =?utf-8?B?bEpvR1h3Y0puTWw4Mk9JTzFIVDVHZVlIV3ZGeWJBbGhpYVFGOGx1dzVURVZL?=
 =?utf-8?B?b0xBRk1raXhINHBCYWNJQTFGKzlsRC9sbjZZRnlzeUk4VmVMbmppbjFGcDdv?=
 =?utf-8?B?N3haU2ovaWs1MTNGMElkTFVNdkFqNjVwSmhwMlgyOUhNZFpyMlBvUEhOTkxD?=
 =?utf-8?B?QVJKSXhsL2k1ZjhSMEpweko4ZFhLQytDSExBbkprTk1OdHc0RVk0NzdIZ0pi?=
 =?utf-8?B?dllocW1TOERQMkUyMDlLM0x2OU52cWJVeHo1L1d2ZVZtZ2ZvbllZU2FRUGsv?=
 =?utf-8?B?aDVnUEpnMHhxR1h6aDZ0QVNlbmVvWDU0VHlHT0hNUUhDU0NpcHViUFRqVXUx?=
 =?utf-8?B?bTQySS94TEpsWGt1ZjkrdEN2a28yWitmZUhsK0lmMlZ1ZXZpNGd2RlVlQTR3?=
 =?utf-8?B?SURCZytNQS9KZkNzR0F4OWU2MXEyRFNhcXRkelAyZHVkZCt0bmQxNXMxUit5?=
 =?utf-8?B?eHRzUGtGd1EyNkFZQjQzRm1yV2RFb2x3Q0RjUGRCNzFNbllpK3k5RFJLaURr?=
 =?utf-8?B?ZW5YMUJWRXVYbysybC9mdkpraWZzN2pSU0MyeVJyQms5cmkrTzk2T2psS3JF?=
 =?utf-8?B?TGtRaXBDUzl3MThBUEVCMHJVK1ZoQWx1OGg1RFhmdDMrUDVYUkFHTVNBelVE?=
 =?utf-8?B?Sk1wbUs4cFQ1M1IwVi9vOFduaXFyTFVuYkZ1Tkx2VjB1dnVQVkpkY3AzbXNT?=
 =?utf-8?B?Nnk0aHp6YzVaTnpUdkN4RW9sdVJvRHQyVWsvWitvUGYranFzbkYwc1FtMFg3?=
 =?utf-8?B?djE2WlY1bnpJWm1QMWNLT2w0UGJJcjZhMTFmdm1aNjJYREJNV3lkeUhVR05S?=
 =?utf-8?B?bzY4Y3d2YVJOb21sT1orUXdybWRsa3pPcVJQK3I2bllhTFp0MnNQWFFZZnZv?=
 =?utf-8?B?ZkZpbFprTVdhSEtBQ1BlamUvTjdudFJuem1nYTNheVJCemRoL3Y2V1IwY0JL?=
 =?utf-8?B?NzRacHFNWDBkSkZDTHl3NHJvR1EzMnNIdHZpQVBDUnVUUHFyREVCdnlEck9M?=
 =?utf-8?B?eDNkVGJIdUlBNTdMTkV2SWNDYXE3aGtBWnF4bzl3YUpEb2dibEh5RDhXbFBS?=
 =?utf-8?B?bm4vVmJvZENWdGljTUdvYjFRUHFySDZHZVVRZDIya3pYbUM5REI4aHErbjNs?=
 =?utf-8?B?VDg4V1FRMlZpdU9lbFBXUXpjaDR4dmRBd1VkY2RlS1IzcVpabXg4WnZoem8y?=
 =?utf-8?B?djNLcW9UY1JYY1JnNHlZdTR5S0RCSjI3bmpUUnRHMHpRRDJMenI2ZytFQjdt?=
 =?utf-8?B?UGFkMEVWM1R5bXZOekVZL3NVY3duNlp0UXVaRVFvaGxLWWJ5ZXU0ekhBdGc5?=
 =?utf-8?B?WDQwOWNXSVVoRVhPUk9KOTYzWEZrOWtNTk8vZUtXTzJLTncvVlFXTzdhZmky?=
 =?utf-8?B?TWlqWnFiUjd0OS9aNTQ4Q3pUV2xqREtsZGJjeEZMaWozeFlTM3dxNENybGp4?=
 =?utf-8?Q?qQCRmc7pv0IFMLoYkSG0YNcQo?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3704667a-3479-4862-d035-08db6bad4504
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 01:26:53.4298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: flW9mvvEcSEg6J7o9EeoYxtzae1MlHmmqaQxO1MCKxBE+cKcfF3gzt7ojK4sz+FeUugfZ4O7C3Q3/2DpqhzlNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4774
X-OriginatorOrg: intel.com
Received-SPF: pass (spool1: domain of intel.com designates 192.55.52.43 as permitted sender) client-ip=192.55.52.43; envelope-from=hongzhan.chen@intel.com; helo=mga05.intel.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=intel.com header.s=Intel header.b=H24drVOW;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (spool.mail.gandi.net: domain of hongzhan.chen@intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=hongzhan.chen@intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFJpY2hhcmQgV2VpbmJlcmdl
ciA8cmljaGFyZEBub2QuYXQ+DQo+U2VudDogTW9uZGF5LCBKdW5lIDEyLCAyMDIzIDc6MTYgUE0N
Cj5UbzogS2lzemthLCBKYW4gPGphbi5raXN6a2FAc2llbWVucy5jb20+DQo+Q2M6IHhlbm9tYWkg
PHhlbm9tYWlAeGVub21haS5vcmc+DQo+U3ViamVjdDogUmU6IE1hc3NpdmUgdmFyaWF0aW9ucyBv
ZiBleGVjdXRpb24gdGltZSBvbiB4ODYNCj4NCj4tLS0tLSBVcnNwcsO8bmdsaWNoZSBNYWlsIC0t
LS0tDQo+PiBWb246ICJKYW4gS2lzemthIiA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4NCj4+IFRo
ZXJtYWwgdGhyb3R0bGluZyBvZiBhbnkga2luZD8gSXMgdGhlIHN5c3RlbSBwYXNzaXZlbHkgY29v
bGVkIGFuZCBtYXkNCj4+IG92ZXJoZWF0IHVuZGVyIHBlcmZvcm1hbmNlIHNldHRpbmdzIGZvciBw
b3dlciBtYW5hZ2VtZW50Pw0KPg0KPkl0IGlzIHBhc3NpdmUgY29vbGVkIGJ1dCBhY2NvcmRpbmcg
dG8gaGFyZHdhcmUgZW5naW5lZXJzLCB0aGUgdGVtcGVyYXR1cmUgaXMNCj5ub3QgZXZlbiBjbG9z
ZSB0byBhIGxpbWl0Lg0KPg0KPklzIGNvbXBhcmluZyAvc3lzL2RldmljZXMvc3lzdGVtL2NwdS9j
cHVYL2NwdWZyZXEvc2NhbGluZ19jdXJfZnJlcSBhbmQNCj5zY2FsaW5nX21heF9mcmVxIHRoZSBj
b3JyZWN0IHdheSB0byBkZXRlY3QgdGhyb3R0bGluZz8NCj4NCj4+IEFsc28sIGRvIHlvdSBzZWUg
c2ltaWxhciB2YXJpYXRpb25zIHdpdGggc2ltaWxhciB2YXJpYXRpb25zIG9uIHRoZSBzYW1lDQo+
PiBoYXJkd2FyZSB3aXRoIHByZWVtcHQtcnQgKHByb3ZpZGVkIGF0IGxlYXN0IHlvdXIgc3ludGhl
dGljIHRlc3RzIGFyZQ0KPj4gcG9ydGFibGUpPw0KPg0KPkkgdGhpbmsgSSBjYW4gZG8gdGhpcy4g
QnV0IG1pZ2h0IG5lZWQgc29tZSB0aW1lLg0KDQpEaWQgeW91IHRyeSB3aXRoIGRpc2FibGluZyBI
eXBlci10aHJlYWRpbmc/DQoNClJlZ2FyZHMNCg0KSG9uZ3poYW4gQ2hlbg0KDQo+DQo+VGhhbmtz
LA0KPi8vcmljaGFyZA0KDQo=
