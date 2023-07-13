Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8C37F8
	for <xenomai@lists.linux.dev>; Thu, 13 Jul 2023 05:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689224838; x=1720760838;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7rqVUzspSC6UJYOBIt987mrGKJ7otvVwdUMvrWDLPDM=;
  b=FxgwP1TYsuhITcsud554kd3UlHRupprsptDB0ceHdZHZvReWGO8q4gzB
   eBlNrSaog4usLqjDVDeDo+rSS/nxBDhq9sMoXjxUWxVHZXnuJnpJHJNJP
   D1V8Gnff9EuR7l9JgKyB1rnkdrRVyqhmSFiPJVgfo2ar0yB3V4gU5PQXe
   bpGLYLMvdLs8m4cbrU8JRztGswitE42g0QjhxOzG46SAmuVPf1QZZqcxc
   n9pUphMyCj7AmRMaMljaVSKFfyGi9W7Aoj2hKwJnSsycmrLKd+1r8k2ay
   FcaW9VGjWn+aWYpPff8/hbu3eXnw323ruUKot4gt/XbdL3rqrpFEUk10B
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="362552521"
X-IronPort-AV: E=Sophos;i="6.01,201,1684825200"; 
   d="scan'208";a="362552521"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 22:07:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="699116057"
X-IronPort-AV: E=Sophos;i="6.01,201,1684825200"; 
   d="scan'208";a="699116057"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 12 Jul 2023 22:07:12 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 22:07:12 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 12 Jul 2023 22:07:12 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 12 Jul 2023 22:07:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BazQ/5IHjsD0AHqoCmLCpig49IVbDmoWN+vQkU1o10Qh7ML4SN5KuRJTA76rxUcowKVF0xzBHGiKnq5D9Gzt442+N+ZgcmrLNM0fLjVcpX9/IF9fGjCR1PCYcSdj6IDN55QtT4SSlgeM+1uBV5LAQawz8Lxmr3ZywDm+WFUBrw/IUOwf7u5Dk6EzCSzeNiKrAerpma7m95ORAJjx1rSWecEwPkxl9Cy8sh3Y5+jRv66e8h/SlmjfFWj+SQ0iby6hnHUKIrRVcH1ZYVoenTkEOKj0QUS2onhkp9IdBIVOk3T4WFP07xQVfQB2GoP4ONLviQf3SFuUTov6bwG8hP+WOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7rqVUzspSC6UJYOBIt987mrGKJ7otvVwdUMvrWDLPDM=;
 b=J4Av9I2mSm7geMU3WPD1U71F7BeXnaOidfzJ9D3QzK5Rv5Y4llFdsC3dzeFGvT1OLvC9xEu3NyHD45IrV4pzrbWirdn8nG176oHrOdkBZzMNJt/CPXdv8troiEBqTURj7yFcE8gkhN3nki9Sx8l2snmISVqGRnGvgW0nn9m3oh0R2drYrjrg4Fe0q8YeYw5u+mTzumH1h8Cwc8oUW5sT3qkSim00/qndMDEQP0clRmffNznv75u7t98jaZl8UzgLg3/x255wCbX9QuuQaovkSD0UZN4A8jbEVHNecQyb6xTrTPDkSYDoU4NpQVSNty7+MW6wVy2g9Gol/rbU4pyUyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by BY1PR11MB8053.namprd11.prod.outlook.com (2603:10b6:a03:525::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Thu, 13 Jul
 2023 05:07:03 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::800d:cc89:23b4:e4fd]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::800d:cc89:23b4:e4fd%3]) with mapi id 15.20.6588.022; Thu, 13 Jul 2023
 05:07:03 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: Richard Weinberger <richard.weinberger@gmail.com>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: Xenomai Community Call Minutes - Jul 12, 2023
Thread-Topic: Xenomai Community Call Minutes - Jul 12, 2023
Thread-Index: Adm0mBvI/2eEZU2aTySwfMq552RBmgAaiN4AABFObWA=
Date: Thu, 13 Jul 2023 05:07:03 +0000
Message-ID: <MN2PR11MB4285F135AE965848DB6DB2D2F237A@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <MN2PR11MB428571D2636A8A0A7B4CEA6DF236A@MN2PR11MB4285.namprd11.prod.outlook.com>
 <CAFLxGvzhE6rZ2aa=9Qwhyo06PytCQEqam_Yq9scQdJ1cLY13vw@mail.gmail.com>
In-Reply-To: <CAFLxGvzhE6rZ2aa=9Qwhyo06PytCQEqam_Yq9scQdJ1cLY13vw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|BY1PR11MB8053:EE_
x-ms-office365-filtering-correlation-id: 76dd27e1-a62e-408e-d07a-08db835eff50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rYwHxWhEIoyFO+tFCJU+/6xhn8psNedy8Vbj/1SeiyoNQ5owZiZIalTFrkwxsy2Jb7pgELSjqyKISy+qg2WMP/1PRw60eQahWpBuLgwIzH4LXWw/snIYHCTIJGyxxG0sO6GyU98HJfRPrWA0fuh1dssKiK2+La2H1bxjIppwc7Hf6+Y+R18EV0SXnoUmtdADIpYAVgIt0NBiQdEBiplJjlF7fbkP4/jaxrRDP/3E4ffFHezM2lgAQU0V2T1HT8qzD73cZ1cBybA4EmkA/fAlFUmJmyDUKWNsQL5W4qxtQ2nG9b/aii/vVHTP0lWEd2CkEYTqc9hV7tVKWpVMKWrkncMfY19XKxwgYpC2TYLtWHYXEV+MBajNFLfu6KAwmamDT3xHm6FiwmxveXwJ7aULmyxx1f4KbT8Kjbtrd0qfJhEtoM21iBvqa+2FLQqVTGw7FDiZSVRvB5n8jMSxi9AgFeqlHT355UYcEeHIUuasQ/QfE0tHOodpQ4ZCqxyCt3oQCSHlGpfOfjDlAtjcu4IB4HG1FvetjOf8Ymb/tWHMfGUMqz8n4OWX07iqx0Ny4AdMVVEMt0EawIY2Nkxs5iq3C4XpbRPBzFikvvUOZAU16KiqMiDAJ3w/cMyUNnI2i8uz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(396003)(39860400002)(346002)(136003)(451199021)(4744005)(2906002)(5660300002)(41300700001)(71200400001)(478600001)(7696005)(8676002)(52536014)(8936002)(33656002)(316002)(86362001)(4326008)(55016003)(38070700005)(66446008)(64756008)(76116006)(66556008)(6916009)(66476007)(66946007)(83380400001)(122000001)(38100700002)(82960400001)(6506007)(26005)(9686003)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVpFRmFMemVIMzRielh2dDMvODlUSk5XdWtDSStQTU1ibVYyRjBKanRzQWM2?=
 =?utf-8?B?OUZWYVpXVzlTVlhmQnZjZXBPenM3SkhRTUpNWUFrWjR1K1RaWVNkTC9jSE5l?=
 =?utf-8?B?U2dsUm9RMndtOEJ4Z3JhTmplaHpsR25ZNWh0TDhlK0MrK2FMdFVjSDhGU2FZ?=
 =?utf-8?B?Qlg1MzQ3QkRUWEJnaXBxT0FKaUcwTUNoYWZuTUpGeCtBeHl6aEVSUmwxaURm?=
 =?utf-8?B?ZlFDcVNyOUFxREgrRGxKSSt1QlptRUthSG5WM3V4ZmF3Um51S29sSlY4VzhC?=
 =?utf-8?B?TFZtYWNMN29qRzVQbEdraHpMaEtSRjZtajBzOEFBWnVUUDk3dEdwdDVMYzVN?=
 =?utf-8?B?QzBQekRmWjdxL3RhSnRqVWJnMW1jTVdldm8zL3FvVDJqQUVWbzlVK0Q2MDFi?=
 =?utf-8?B?eHpWRGxTZ2ZJL21IMlZRRVVzemdqOTRXME9ucnhkZGp1UmJ6bHJTRUJ4Qzgv?=
 =?utf-8?B?cWdsd3UxclJHcmNaUVVlRlprRVZlejVQZzRkNjBMcXF4dS9tU1V3bEVnZkYz?=
 =?utf-8?B?Tk5rUUIzUGE3a25FNE11ZjQ1MU1yNkdPL2QyNkl3RTduK3BkZ0dMTFJYcW01?=
 =?utf-8?B?RUd6TTNlTnlJYm4yVUpQc0tPRFFBOVRKaDJvcFVna3dTSGdieE01Umw0L0NP?=
 =?utf-8?B?YXAxbmdNUjloTmJLL2ZQQ3ozZ1RRNEtadEJWQVh5ZTZoN0lvSGdWWmJnb1hh?=
 =?utf-8?B?ZGFFZmMzeWk2VzFETENXSmIzZkdqV2FxMzJ3NENTSngxOXcvUEJjVmtwTlZ1?=
 =?utf-8?B?ZEU5ZlMzODlEVmtHTndqYXgrTU5scnhTdHpQSEIxTE1Hdk1DYmhuOHVNbVV6?=
 =?utf-8?B?Y0pQdldBWTJjaDRRbzUzc0pRVVFZWXp0TkFCeFBwZHZtSE9FdTlNRXRTWWFh?=
 =?utf-8?B?MktIaStSdkxiRlh4WnkxbHd0K3dRZ2ZqazYzMitLZWxJQjNpekMxbmVSeXl6?=
 =?utf-8?B?MUxWcU4rT2xHdU5wcGl1Q2ErTEJzc1BNd2YzWDBmVGZmMjVJVURNSy92cWpQ?=
 =?utf-8?B?bUVGSlBPNkFVZW1BTS8wRlh6K0pFNE1KZFBCV25nQXZQeVNDWmlvQXB3K2ds?=
 =?utf-8?B?R0tCS3QrR0VkYjFSbXpXU091OERxQ1dVQXpydHRJVUZoK1YvY3JpYkRweVhH?=
 =?utf-8?B?cVIrNU9FVHNsdEpkaVNuR0RYRkZOeGhqcFMyanlYb2NGWnVmM1hRQVBsZDhP?=
 =?utf-8?B?dkFORmFuQTJ5Y1pjbSs0WDNUeGRTMm4rbGhIaU53aTluZXVUQTJJb0I3cnRZ?=
 =?utf-8?B?eVU0OTdBdkcxMkxIbzZLMEFGWGZ5UTQxQjIwS0tOZm1qSDBIc0s2QmdjQW9E?=
 =?utf-8?B?aXVyOEtaRjl6U2hhODlGeHBXRnlYMmcwRGpVOFFBY1ZvVDF4VmRpTlowVlQ4?=
 =?utf-8?B?V2dJNzhPOUcvNzk2UVlXZ1lSZEFFa2p5dkxFUjh5TXQwUXhVYzJRb3JLKzVm?=
 =?utf-8?B?RkJlWDVNa2I4WlVMOFF2WlZDbUs0M1ViaHJ2SE1KUGJhQWZVa0xxWHNDR2x0?=
 =?utf-8?B?MERqbENUUkxjbm14dng5a1FkTkVmTXZudmJJSC9LUE5mZ1k4QTc0dFptT3NO?=
 =?utf-8?B?Umc3VmRmRDM3ZFprZXBWc2J5K1NrY3NrdUdnMUxrRUcvam1WeTFVR3BsL09S?=
 =?utf-8?B?dndlbzRPSnlsS3YxNlQ0QXd5S3lNVXBtZCtWTHVSRHJodmVVRldDNlBGaWdx?=
 =?utf-8?B?TDg4WmdMbEJlcitvUWFFM0dZUDkwZmRtRnhweGZ6SXlIOW1ZYzNmSkVNZUNP?=
 =?utf-8?B?Z2I2blpzMndnTHpCWEZrZ2pYT3lJRzQ4SW5VK250aHNrc2UvSldYZFlVZWF5?=
 =?utf-8?B?OXZrZHdOeVJLNnN3TVh0MzgyMG8yOTlzWTluTnU0NXhDazE2RTdvK1JYUERT?=
 =?utf-8?B?YzBWWFlVSlI3VTU3amJ4YUwzblYzaXZWejRoUUFMMytrLzVVWGhwUmhkenAx?=
 =?utf-8?B?anBXN0V0Z3Z1MEtCTCt6SU1YZlZzcC9YcXZ5TXNEdEE1VUIyU2ZNNVJycnM4?=
 =?utf-8?B?OGszWUhwWjd1bHVWd0MzVW5ZVGpZclRncHBFcHVxWVJ1NDBvM05JMHFjaCtv?=
 =?utf-8?B?c1ZhOEJjVDAwOTVNS1psSEk2a3VtMkdTMDlrbEhFNXpNbEMwWDk5QlNBOU9y?=
 =?utf-8?Q?27HitDxsP6TJO0FPkKVDmKh9D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 76dd27e1-a62e-408e-d07a-08db835eff50
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 05:07:03.6135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w6QuH5yqZBB8MfnfSGp4r+MlBxOQ2damfWwtHuxd11MPECOxKTryyMDCGN8FMRAuwfuFIt2iydVcpVnDXuPQmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8053
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFJpY2hhcmQgV2VpbmJlcmdl
ciA8cmljaGFyZC53ZWluYmVyZ2VyQGdtYWlsLmNvbT4NCj5TZW50OiBUaHVyc2RheSwgSnVseSAx
MywgMjAyMyA0OjQ5IEFNDQo+VG86IENoZW4sIEhvbmd6aGFuIDxob25nemhhbi5jaGVuQGludGVs
LmNvbT4NCj5DYzogeGVub21haUBsaXN0cy5saW51eC5kZXYNCj5TdWJqZWN0OiBSZTogWGVub21h
aSBDb21tdW5pdHkgQ2FsbCBNaW51dGVzIC0gSnVsIDEyLCAyMDIzDQo+DQo+T24gV2VkLCBKdWwg
MTIsIDIwMjMgYXQgMTA6MDnigK9BTSBDaGVuLCBIb25nemhhbg0KPjxob25nemhhbi5jaGVuQGlu
dGVsLmNvbT4gd3JvdGU6DQo+Pg0KDQpBdHRlbmRlZXM6IEphbiBLaXN6a2EsIFJpY2hhcmQgV2Vp
bmJlcmdlciwgRmxvcmlhbiBCZXpkZWthDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICBE
YXZpZCBPYmVyaG9sbGVuemVyLCBIYW8gTGksIEppYW5ibyBDYW8sIEhvbmd6aGFuIENoZW4NCg0K
PkZXSVcsIG15IGNvLXdvcmtlciwgRGF2aWQgT2JlcmhvbGxlbnplciwgd2FzIGFsc28gcHJlc2Vu
dC4NCg0KU29ycnksIEkgcmVtZW1iZXJlZCB3cm9uZyBwZXJzb24uIFRoYW5rcyBmb3IgeW91ciBy
ZW1pbmRlci4NCg0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQoNCj4NCj4tLQ0KPlRoYW5rcywN
Cj4vL3JpY2hhcmQNCg0K
