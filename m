Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683F7187D
	for <xenomai@lists.linux.dev>; Wed, 28 Jun 2023 02:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687920953; x=1719456953;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=tKIf7277T5xsKo4j3QUXx5lsAAgIeP2VtT2WAv3MqwU=;
  b=mz/Znhr1FHQMNhehwuB37N+hwVs4f4nkWhpapJakAoHlSwSthpiAPMNq
   G/iyidaj8ph4wfVM5FW0wdlrLE3xZr6dHtLJfXqGTYF2FslhMWg0P9tsa
   gJceGwW7D/DW5OOBUQCl85o7cCM9JcUuxNJDcuQopc/Y2q5fl0lvFngr6
   0lYw+2m+GwdDmZ+M3fBIAEGNhOg6i/ph+offVzUx17c0E7CtUajBotUtz
   ppNPyw6MJnwCva44ANyAZj8wh+JY0UwQSZLR3yh3RKA30xCWn9+mwGNwc
   Hq0IqxxAWh74QbyBNWSYYaI+76LExLWjicMwKOUicyshYddxXOe/7+cRU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="359228113"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="359228113"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 19:55:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="861331340"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="861331340"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jun 2023 19:55:52 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 19:55:51 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 27 Jun 2023 19:55:51 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 27 Jun 2023 19:55:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVqC77k/+uY5f+Yo7cVhn/9oGn0U2/HyhkX4ZsoG1GQB1L5kdri8qP1nq26Cl6SG7aWpez9xq/jvz6gnuINxhUOyTeygpeOePGFgYeJgRZEf4Nvw4Wa/SyLpE10e3cgHdJns5vhjQBPnIuzFr8Dd6fYJwyaonnqfh884MewQO2twS/bPQ8XyzZFbIr6OYNQRtR0BarD4lReMBYkDJbya7jw5OpDIlgCza6TnDXBgxDwosPhidNv6rOpFA6ApZqKwjD4dUzqjb8MY8Rux0heuZaZ4JF5okbJMtpIlp/YfVYwhrDvAMDbuwaOFIF2aMz7+x66mW3AjnGg7UrWyfsoGQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKIf7277T5xsKo4j3QUXx5lsAAgIeP2VtT2WAv3MqwU=;
 b=WAuUDaveVr42qRafkQPkbk885KVw6ItvcsoNpQmKi4EYSsgcMjkP4EvIw01rgLBa599qKQYbEi/O5il4dspDilnN8xiFwFfBpok4Y3pRFBbY5yADGet9PeQiilyd8LHg0KVf8/lbw46X616LDiC63WUN1y72ZvtZGFheprbTqADHG3fTlNkRbis7W+UlzgOBSfywc5QS0ie/Xas1QsPte1PgWK/+oN+birLvl6Hqk07sQNHxB1MHEgSYkxpbzD1dHKSg8Yw42r+o83fqr5KNqxsnBAQ7zvu6wG6WPQbPpaskGQgSPw46Ncs9dpsaQPsnNZ6gTFUG+ja0TH5NCCijcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by PH7PR11MB5915.namprd11.prod.outlook.com (2603:10b6:510:13c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 28 Jun
 2023 02:55:48 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::56a8:e9c:284:f6a8]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::56a8:e9c:284:f6a8%7]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 02:55:48 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday,  Jun 28, 2023, UTC
 7:00 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday,  Jun 28, 2023,
 UTC 7:00 AM
Thread-Index: Admpa/jdBzkrhj3iRGi92q7pgvjGEQ==
Date: Wed, 28 Jun 2023 02:55:48 +0000
Message-ID: <MN2PR11MB428522CC19E11D6760D4FDCCF224A@MN2PR11MB4285.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|PH7PR11MB5915:EE_
x-ms-office365-filtering-correlation-id: 5e077c67-b61a-43a9-73d8-08db77832cf4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NXoeJQqeVZms/DwiKwHkBxJutjJpV7P52hL+MoTo3e0PeZWRGMfnc3pgNDnxlvIFDP0fPthdwcJP9k+20ZbjLXzlr2FXUdl7YfcAn8T/gLlf/NwtWPvbps61cl/Z27NtFqL1Q0nN37pD2VoH1+f1kf8sdIb7t5xxtOzPN2KLoR43z+Z+8y+ZDrUKLcydpoA9WrOYERhs1ANOoRa/fVUjpaMryfjpAz3b0OAp6G8to3g7B3bkPYPsyZ8uvOfqz2ht8PZmsF9XfiszG7udp9ASjCrLnXX2+wZiI1Tx2NgFRrH2BS5uqSmKbQcVA9M6keZzwo+cv3333A1wLMqf2lQYtBZOChwhAkQQQtah48lIaJw2lZTRlYHp+fXaF8bOJnUDDQouDtKdmbZp6WRakv6quZ+Q6J+ez/menYc+M4yskfAPKub0GoLeLdc0KD8aJyOcrsC2VMNx6g/x46D8VYVGtRLyRG6Yzv8rIAV+FK//IFOzqV3XmTc37GIt01/kyqP3httiy/LGvw6yRBUoZNE4srIRTSYp8XcuqtQ56r9CPd4neE0tVgKCfU1LBUkcBuWJPR2Xv/XvsUUPp1dtuCGkJ4D7xrykx4/jvOJOIURwISq101ddmbZqEzBj9CtgIMoMbLNpjHXgUwqAksTzfdSLEQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(366004)(396003)(136003)(346002)(451199021)(122000001)(82960400001)(38100700002)(38070700005)(40140700001)(83380400001)(33656002)(86362001)(478600001)(9686003)(966005)(71200400001)(7696005)(8936002)(316002)(76116006)(8676002)(66946007)(55016003)(66476007)(66556008)(41300700001)(66446008)(64756008)(6506007)(26005)(186003)(6916009)(52536014)(5660300002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NnRFd1hOUTRIS3o1R3lENnZpemtmVVRsK2JiK1REY0Jtc21vWFdNbk0vODZD?=
 =?utf-8?B?eVNXdXlhd1Z2eVBoRFB6WGsvSkVHaXhDUmhPdzNHaC95WGVRRFZVMWJMY2lY?=
 =?utf-8?B?V3IzSmZ0cEFXcXhPdk5hSFdKb2RhbmsyeEpaT1MrZURVWTE1akJUWGM3TkhB?=
 =?utf-8?B?WU8wZ0ZqM2wwYmhKZ2IxcjdaMFBzVzRUWThFSzBTb2VkZjd1RDBDejQ4cDhw?=
 =?utf-8?B?ZlpQMWpBR3NjRXcyUXVWdGFNblduY1dIV3Q3cllpSVVpb05RK01LTWlmRkNw?=
 =?utf-8?B?WkdEL1krYUZsN3hpMmpOQVBFblVRSmxVdmVQNVl0VFRuOEt1RGc0Nng4Z0ZD?=
 =?utf-8?B?cHZlVGVVQ3JwUXN1Z0x6QnY0bU4vMGlzT2xxcGVwaUZzUnh6MWpBZHJTbVZU?=
 =?utf-8?B?MVBYRHkzVDc2VklzN2ZUaldFVG55dmFTQ0ZIbXZNZVg1ejB2bTV4MThMRTRs?=
 =?utf-8?B?c21YSWlYMytOZzNOZHBJS3QvbFNOckVzcmphOHdQZE9nMWJPUkdvV2ppSWpn?=
 =?utf-8?B?M0tVUjJqUUpzaStXMlE0VXg3SWZTc2RXRFJhZ1BCYkozZ0t6MUszRWdpL25P?=
 =?utf-8?B?cG1pRVhVRnVrdGdLbHlkaW4vUFNyVE90NFMwWU1hQVJJWnBhZTFOcnI0ZE5W?=
 =?utf-8?B?V3UzWDk2dWtUa0hRSXNOTk42VmdmeXl2TE5mM25BUU4wUUpLWUxxb0srZ3Q4?=
 =?utf-8?B?TXpTT3Z3VWFYbDFGT1Q3Szg2RllXU2NGMzBzNENtWWlRb1pMS2Q4NTVEQ3p5?=
 =?utf-8?B?TzJRNEpzZi9YdzhkL2tjNzEzeEltOFZjQWRUaWN3OEZqOGI0d0kyVyt2SG9E?=
 =?utf-8?B?dVpCUFBaU3RpOVl2WnhvTG8vUU5ablJaaXJJV3kvclFpOVE1WmNHWlREZ2NI?=
 =?utf-8?B?a1BrYXUxRFRTTm9wZk9LZlpQenlydjNDK0h4eVlsOHhSUElUUUdyZ3oyWll5?=
 =?utf-8?B?SjNUU1ZxOENrMkNZTEdaamNUWWFlZzNNekR4MzM4bkpnazZYb1Z6bTI3MGN1?=
 =?utf-8?B?Z1RNME91ZnY4Skt3WGtKajIwU1ZybGpCNjdNbG5qY3NtS3JteHY5RFlOUjZH?=
 =?utf-8?B?MENLOVZEcm9GZFU2VWh0YUFWcjRqYjdQSGVlYm1BSGgzZWF0cVp5eGV3Sjc0?=
 =?utf-8?B?MDRMUUp3TG5PTzhjanpXNFFrU1J4K1htNVBVR0NPdGFXZWhodThkWGpjdUd1?=
 =?utf-8?B?NndYVDAyNGhOZExHbmdObkJYZHNsTkExcTIvUXJhUGlQNjcvMW5CRlh2dkVm?=
 =?utf-8?B?TVR3M0RXS29tY1J3eTFGalBGdjd2Q2ZrK3FEeUt3S0gyZnBLTUx3TWhOSWpY?=
 =?utf-8?B?a1NySE1JL09SRnMweklXUG1RQk8vcDNxc3dMOVNsbjRhK3NkQWNQYXpxeXJP?=
 =?utf-8?B?RWp5Yk1xQURqTFZrZ2FxSWx5RUR3SmNNZ0crLzk4YU8vMUFYQTlFWmhuVmFV?=
 =?utf-8?B?Vy9nK0VaSXNIbi9Hb0N4QmRYT0swOTZtc3VYRSs1dmZYakNqOWtqZTlLQkcy?=
 =?utf-8?B?cHZjQkR6WlN0YzB3ME43SkE3dmlTODVjR0R5c1c3VE8xaWZRUkN5TTJMTWpx?=
 =?utf-8?B?R1VDNTBXckFvcURzV1J0UEIxeElhVFFjb3lGeUFSd2llRG9OMkwwTHFPRHJz?=
 =?utf-8?B?ay8vMVJnY1ByN2pucC9ncGJZalJBVXhjODNhREtZbnliNUJrUmN1bStRMS93?=
 =?utf-8?B?bnk4UjhPT3dLNTZuWjVOaitHMkwvdUx5MDZTY08yMlRjTDlWSHg0THBnN2Uw?=
 =?utf-8?B?cXdnZUp0bnFQeWFvRDYxaVl4ajZvM0tQeTA3d1VvcHpBVFc0ZlBnRndtWGlO?=
 =?utf-8?B?NVM5Mnh2d2RTM1E0V3V6R0pzME9JaW1WQkVhYWRWM29NZHR4MDZsNHdYOGZa?=
 =?utf-8?B?NW5LNzE2VTAzVFhERmg2VkpkMSttZXRtVlJWUUs5VkhUVkkzV0FZUVhWcjJj?=
 =?utf-8?B?VkhGeVU3eFNnK0NBMGxUNldPNVQ1QlhaUmQrK1ZsT3hsNEVuVStpOHRmRkov?=
 =?utf-8?B?ZlluVGE2VklmVEVWZXlERG9GVTBQMWNTS0h3NWozRkZ1ZHQzcHdlanhpZGN2?=
 =?utf-8?B?VzFqOWxxc2d2ak1DRlRWK3NpSW8yanVNekhqSHVFVEhKVVZwYnJlR3kxL25N?=
 =?utf-8?Q?ZIkmSFutTLgCc+Pxa2bj6N6hL?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e077c67-b61a-43a9-73d8-08db77832cf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2023 02:55:48.1161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BEMnc/AQG3d7X3PhxbtHKkEnQNezyVknRrn0ayfZdPGsHXGw2k/tpptfY5rNOf/wkrkdSodyngRpcyZjcjaKaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5915
X-OriginatorOrg: intel.com

V2UgaGF2ZSB0aGUgWGVub21haSBjb21tdW5pdHkgY2FsbCB0b2RheS4NCg0KVG9waWNzIG1heSBp
bmNsdWRlIGJ1dCBhcmUgbm90IGxpbWl0ZWQgdG8gdXBzdHJlYW0vZG93bnN0cmVhbSBwcm9qZWN0
IA0KcGxhbnMsIHN0YXR1cyB1cGRhdGVzLCBhbmQgdGVjaG5pY2FsIGRpc2N1c3Npb25zLiBJdCdz
IGFuIG9wZW4gb25saW5lIA0KbWVldGluZyB0aGF0IGFueW9uZSBjYW4gam9pbiBhbmQgYXNrIHF1
ZXN0aW9ucy4NCg0KVGltZToNCldlZG5lc2RheSwgSnVuIDI4LCAyMDIzLCBVVEMgNzowMCBBTQ0K
UGFyaXMsIEZyYW5jZSBDRVNUIDk6MDAgQU0NCkNoaW5hIENTVCAzOjAwIFBNDQoNCkpvaW4gWm9v
bSBNZWV0aW5nIA0KaHR0cHM6Ly9pbnRlbC56b29tLnVzL2ovOTEyOTcyNzkyNjk/cHdkPVdtZHdT
MHBET0RSTk1TOXRRazU0WTFkdmJGbHFVVDA5DQpPcg0KaHR0cHM6Ly9pbnRlbC56b29tLnVzL3dj
L2pvaW4vOTEyOTcyNzkyNjk/d3BrPXdjcGs1MmE5Zjk2ZDk4OWU3ZTIwYjYyOGMyYzM2ZTQ4YjY4
ZQ0KDQpNZWV0aW5nIElEOiA5MTIgOTcyNyA5MjY5DQpQYXNzY29kZTogMzY3NTI4DQpPbmUgdGFw
IG1vYmlsZQ0KKzEyNTMyMTU4NzgyLCw5MTI5NzI3OTI2OSMgVVMgKFRhY29tYSkNCisxMzQ2MjQ4
Nzc5OSwsOTEyOTcyNzkyNjkjIFVTIChIb3VzdG9uKQ0KDQpEaWFsIGJ5IHlvdXIgbG9jYXRpb24N
CiAgICAgICAgKzEgMjUzIDIxNSA4NzgyIFVTIChUYWNvbWEpDQogICAgICAgICsxIDM0NiAyNDgg
Nzc5OSBVUyAoSG91c3RvbikNCiAgICAgICAgKzEgNjY5IDkwMCA5MTI4IFVTIChTYW4gSm9zZSkN
CiAgICAgICAgKzEgMzAxIDcxNSA4NTkyIFVTIChXYXNoaW5ndG9uIERDKQ0KICAgICAgICArMSAz
MTIgNjI2IDY3OTkgVVMgKENoaWNhZ28pDQogICAgICAgICsxIDY0NiA1NTggODY1NiBVUyAoTmV3
IFlvcmspDQpNZWV0aW5nIElEOiA5MTIgOTcyNyA5MjY5DQpGaW5kIHlvdXIgbG9jYWwgbnVtYmVy
OiBodHRwczovL2ludGVsLnpvb20udXMvdS9hVEVBMzdpNUcNCg0KSm9pbiBieSBTSVANCm1haWx0
bzo5MTI5NzI3OTI2OUB6b29tY3JjLmNvbQ0KDQpKb2luIGJ5IEguMzIzDQoxNjIuMjU1LjM3LjEx
IChVUyBXZXN0KQ0KMTYyLjI1NS4zNi4xMSAoVVMgRWFzdCkNCjExNS4xMTQuMTMxLjcgKEluZGlh
IE11bWJhaSkNCjExNS4xMTQuMTE1LjcgKEluZGlhIEh5ZGVyYWJhZCkNCjIxMy4xOS4xNDQuMTEw
IChBbXN0ZXJkYW0gTmV0aGVybGFuZHMpDQoyMTMuMjQ0LjE0MC4xMTAgKEdlcm1hbnkpDQoxMDMu
MTIyLjE2Ni41NSAoQXVzdHJhbGlhIFN5ZG5leSkNCjEwMy4xMjIuMTY3LjU1IChBdXN0cmFsaWEg
TWVsYm91cm5lKQ0KMjA5LjkuMjExLjExMCAoSG9uZyBLb25nIFNBUikNCjE0OS4xMzcuNDAuMTEw
IChTaW5nYXBvcmUpDQo2NC4yMTEuMTQ0LjE2MCAoQnJhemlsKQ0KMTQ5LjEzNy42OC4yNTMgKE1l
eGljbykNCjY5LjE3NC41Ny4xNjAgKENhbmFkYSBUb3JvbnRvKQ0KNjUuMzkuMTUyLjE2MCAoQ2Fu
YWRhIFZhbmNvdXZlcikNCjIwNy4yMjYuMTMyLjExMCAoSmFwYW4gVG9reW8pDQoxNDkuMTM3LjI0
LjExMCAoSmFwYW4gT3Nha2EpDQpNZWV0aW5nIElEOiA5MTIgOTcyNyA5MjY5DQpQYXNzY29kZTog
MzY3NTI4DQoNCg0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQo=
