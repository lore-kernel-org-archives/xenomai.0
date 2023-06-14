Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53196363
	for <xenomai@lists.linux.dev>; Wed, 14 Jun 2023 02:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686710895; x=1718246895;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=8bYF8RCYgXdL6yvFL87kUUQOO2uSjtCW/zjCiK3hcEE=;
  b=ecn8iYl9sQuai+kKYRUoOrpozSZXUyMQw6EY/b0k9KwJL2jScsbLJtDz
   GZTR2/+t6Fom3eoJu3i74JjyhnwfgYOwoica3Uk5BOFr4i5R6VTzKJzPF
   D95U3ijItq0nq64Ptst6LMoOJ6vPXALStkPniTGXpVyDbkttF9Lr8lDRJ
   SAQiQBuD+e/pN0TX2HOXOaPW/0pp+uCk9QeFe1hQfuJMU4pGtSS2oN7TG
   KK0tNGNqfxi3IDNSoiZYBOiYqTu/ZRGIaGWq/9/HUDG+mYmPXIj3CbZVF
   3DdM2bcc930Ft8pKgXmbcIyDtZJtefEDJKuYBJVH23nm5tJXgfiPBoAG/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="361874757"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="361874757"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 19:48:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="744916607"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="744916607"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 13 Jun 2023 19:48:14 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 19:48:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 19:48:13 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 19:48:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UnXju3d+Ks5GhHr/XE4xctpwC1LQMKmxtowW6U5SlFRTnz0oKIEm3KV+50i0lB2TeOn4lgK2X5rGN0pN31nPhn2k9cXvoCqDJSwOzPdNWYwcF8c12mes1KkNjtknO7OM34DT5w0eyEYE17dXysihpnmUuBzYh9OSPSgP53bcleboPhcZGucsLR8Kf0gga40sOdyiASFrMeyrtLyujGWjx2RgSyg2auqmIfNR3LkpYMWeXb40GuTDa9SX6eajXtd/R/LFLe8rvTEF86qT6mkiZ1qB7TMeti5kwtTB9dafjDxdvymbtswYHJ49K6BS6Z+zST61kGCarJ8S9TG5k99EQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bYF8RCYgXdL6yvFL87kUUQOO2uSjtCW/zjCiK3hcEE=;
 b=H8pnYqpPTYOlyepdaGDH2MeSH+iycUL4ykyeqQNrRIK0JSvASosM1Wkp2PRwJ6Zl+MceZsFDGiw405dL77lOn26m8LjfDKr4qp7SQxsdhwMZKPHl+LudcbtQEEptxFH8LMtam3HsBZ7Mha8e/qXicInb6bgDRa+ZWkAAwlb1DehORs18zVCsq5v08ryQMCyC3Vk4hY9xOMnEpHqBBcwrYPaiChUmovO1JQ3MukSQMFdOV0ByPEa4mIoUe7SnpCcC4tMaIO0GHG1mtjPiWHWEllfbhhKbCGxgUTfZrCKkgm29ir+62oS3CvgGvVtSGlVtXf+YPJpqpFV7cMkMtrHO4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by PH7PR11MB8477.namprd11.prod.outlook.com (2603:10b6:510:30d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 14 Jun
 2023 02:48:11 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::56a8:e9c:284:f6a8]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::56a8:e9c:284:f6a8%7]) with mapi id 15.20.6477.028; Wed, 14 Jun 2023
 02:48:11 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday,  Jun 14, 2023, UTC
 7:00 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday,  Jun 14, 2023,
 UTC 7:00 AM
Thread-Index: AdmeaotJWm3iHt7BRUeCV1D7zhEZPw==
Date: Wed, 14 Jun 2023 02:48:11 +0000
Message-ID: <MN2PR11MB428526FEFDA678B9AC1F06DEF25AA@MN2PR11MB4285.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|PH7PR11MB8477:EE_
x-ms-office365-filtering-correlation-id: 62e8ba2d-4998-4ec3-20ad-08db6c81cac6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /iIc1WY9VIsjXMXpUsE47llX1DXeOtuMcroMrXdkPOENScYZr0N4BTyGDCHrQE5ebGcOIVIVZL8JSVIxhEqJq4SHhEh0NRDzMnzNkldiRiBiEIdkdy/29Z35yw8HMbHyTXcvtkcxFmWPxnhD4bwqsiFETrCPbjbrpZCr1FQPoI2A0Jh3K3yooI4SxFR60+JkPhZBxc0irs2e1zBIVZa5FHJCOM5J+yK4UodrkQXgCx5ogtKf8HnIfd/sqEAy7tP1VXwWW5m3INhmcDrLwNJbA+3WNxHq01czPcR4ittcas9bsJ7wTM4M0VH7mrF4a09N7NGj7N/4o8xPJStIRwYb4ShnEy+I9nBJZS9H+Y/4Urwvf4jqMU0N77YfnMXL+LA/OfDuwjE400GWiQrSjvLymeU6WoOQ3tjy1SRekHXFSiDJQFPwdwbYzIAoc83m+xd7kQcxtj+Tecn+Kgyw51Q3D/NBMMNtSvUqVHg/iPNwAFzUXJxbjsoosKvLICw8EYxjQ1GFCt0bTyFmewwVgDY7BInD1btz7zWHWvazb2Hvbjwka1UO2l3g2gX6jnHDaxMxpr2agcXvKz/YusoeCZo/9CspIwhfUinLtSOtuNOnaZuxMlnhav400Z+fG4ELzxRVRBxcfzm6YXkAyqoL/DJYwA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199021)(55016003)(86362001)(122000001)(966005)(2906002)(52536014)(8936002)(316002)(41300700001)(38100700002)(33656002)(6916009)(82960400001)(7696005)(5660300002)(66556008)(76116006)(66476007)(64756008)(66446008)(66946007)(71200400001)(38070700005)(478600001)(83380400001)(8676002)(40140700001)(186003)(9686003)(6506007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjJKT2hhUU1ycEJHZXRrZEdXOEhvT0FHTXdRQWo0NGN5a1o0b0NNcGtSdjk3?=
 =?utf-8?B?aVh6UWlJcW9JNEV5S2Z4MnhUK2JNczBKdElCTjQrZUZrangzWFNIQWFWVzVR?=
 =?utf-8?B?OG44bGRycDRhOEp1ZHhWTGdtRFIyQU9nUit0amczdUhXL01OUllkODJqTnBa?=
 =?utf-8?B?cFBpNENRVFdsek41MVpzTFlpdENaZmx0dTl4Sk50dEwyNzd0QXllVUhZZzBX?=
 =?utf-8?B?Q1RLWGIzWkpzcUx6SWpMUlZJbW1XZE1QdnRzMituVFVoc05HMkF4UUlrdE41?=
 =?utf-8?B?NFZkekJGUEZUVDJ1QzVwWHJzUU1CWjM4TTA0cnFKb2tJR0JZc3QyQzRCS2Yx?=
 =?utf-8?B?SVJRVFh6T055ZlhVMWdiNE1QVzZCNW1KV1hBQ0NTdEptRC9yajlROHZDejZL?=
 =?utf-8?B?djhuci9hT1cvbkRTdFAyOGNRYXQ5SFZGUWpoVEFtVEVZRExPQXgwR1FRdzFG?=
 =?utf-8?B?YmV6UVpoZ1VzZ0l0djBaRHdpUU41Y2gzcDBBVHdNMjFaMmtQVmQ4aDZBdGdu?=
 =?utf-8?B?dUJ0QXNMMGJBSzJ2YytoUVpzRHBGY0t0V2xEeXp3KzA5S1hUL1FFNExGdDBk?=
 =?utf-8?B?dGRicFJaTHdvMVVZZ3crV3l5dXNsS0VjNWFPMEFHS1JrSXAwT2RtY3hvUHR6?=
 =?utf-8?B?cndtMWZHZnFhbTJ5NnZDRFFtakcxU0FqVnhjai9LQlBCNmxBYnpxSFVRZ2Fu?=
 =?utf-8?B?WVZXNVZic0FmdmU3YVQwNU5SREk3Z2Zibnlqb2lGZlJzamhkckp2M3E5U05m?=
 =?utf-8?B?WkhjUzdGUithZ0ROWkdJTnlTKzNSclVZSXpZQUxQOXRwR2U4Q3drSVVUbFYw?=
 =?utf-8?B?aVB4Ymt0R1Rvd2JCQWtzUGlyZ0UwdHhBdiswNGk4cHJYOUtMMDI4ekNMeitm?=
 =?utf-8?B?TUNkcVRrUVoyTTNPM3ZSYlVXMllFS2F4SUU5T1FSZ2FJcXBxbEZXVXJhcDRh?=
 =?utf-8?B?dXdkSEVFZlZCTVJIb2k4SGx5UDVjZzcwcFVUOVF3NnVsa3lVclNocWVROGhn?=
 =?utf-8?B?bVQzMXJPSlEzRVQ0L0NvaE1YLy9yb0ZyQWQ1Wm5Jd1UrbTNSMFl0YllRMVAw?=
 =?utf-8?B?YWU3R0IvTmM1MnNoRTl1UnJhelVZZ0N3UVNZcG4xS0YvdndPV0dzZXJiVnRt?=
 =?utf-8?B?OG9JUlJhM3RRaHFIdVN1bCt2clhNR0FJN3hRUkNQZ0FaNDI3WkRoUzdGNzB6?=
 =?utf-8?B?aTVGa2pXNDYrWTJVR0FvUVAvemdIVVFBMnZKM0szSjFFT3U0T3ZlWGtmaktk?=
 =?utf-8?B?UFlWV2F2cjNmcEd2UEFpS20xMlpXeEJBV2Zsc2QxUUJ6OGZFQWhjd1U3Uzlh?=
 =?utf-8?B?WVdmZVRydWRmdEw5c1h1UWpMaktjNjZLZ3I3RnRJTERuc3Rnb3hqQWxSS21S?=
 =?utf-8?B?Q3ROeTJUNm1RV1FjOTV6MlhtSHhpUFl3cDF2ZStqYmsxR2NaRFpGN1dGM01z?=
 =?utf-8?B?VytJWXprQ0pOdytONHd3WHljOHowbnozYzZ2WjgvTTZSQmJaalRrbGNoaUhL?=
 =?utf-8?B?Qi9Oa0lGQkQ2YTZCc0RsRzNKNkZ3bHN2anMvTmNBMmJZMFdGOExnbDNMdk1M?=
 =?utf-8?B?WXcyanVURjUwOHBtZTFEcmN4cDh3ak1zendYUkJjTGZ6M1FVTXl5cUVHenQx?=
 =?utf-8?B?djRiaTQ2R21GcWkyV3U5MFdxbWlESEQzemwzQTVQb2szaHc2ejhESS9DditP?=
 =?utf-8?B?S1pITUJ4OE5tVXVYZTQ4MDNRRmpVNktXVk1mQkV6cCtqbVlmemFDZDlrSDRR?=
 =?utf-8?B?NzZzTGFsZVlNb1V2ZVRFQ1phMEJtQklyNC9zanhjTkw5a2xkSU44aUFSejNH?=
 =?utf-8?B?SFB4NHcrTG12N1N1L2R5Mm4yL0g0TzQxaHpCM0Vxby9pZEdJcXAzMUc0QmFD?=
 =?utf-8?B?d0NMM0NIUHh2S0J5U0NlMys0MWdPaFdLWHNKSFlMUDAxRERveVZXazk0WFVu?=
 =?utf-8?B?VXNwTGdESnVhZHBKYUkwK2FYZjh0MW95c2pYdmpEbm1mUjFlS2tDc0VtNlhT?=
 =?utf-8?B?RExDZkdEZjcvN1FybDBNcFp5dHViUGFRM1d2WEhIcm1RVWliblYxMklrRnhW?=
 =?utf-8?B?L011RFpxVXdUTjZ4eENBUU5FVHFpK0FYUUpwc0NxRWRuNVZrTzg1aXhJbGhR?=
 =?utf-8?Q?5Z/gLAQf0VEESMETm8/7W8oxG?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e8ba2d-4998-4ec3-20ad-08db6c81cac6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 02:48:11.1218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bmpqwcabiN/kcrwnroXVmCAtWitHZKKMX5PLay9tbHhmGBgyhwxaA3tIZRLK5kv85TXUcnLWQiFoDWUjz3cKPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8477
X-OriginatorOrg: intel.com

V2UgaGF2ZSB0aGUgWGVub21haSBjb21tdW5pdHkgY2FsbCB0b2RheS4NCg0KVG9waWNzIG1heSBp
bmNsdWRlIGJ1dCBhcmUgbm90IGxpbWl0ZWQgdG8gdXBzdHJlYW0vZG93bnN0cmVhbSBwcm9qZWN0
IA0KcGxhbnMsIHN0YXR1cyB1cGRhdGVzLCBhbmQgdGVjaG5pY2FsIGRpc2N1c3Npb25zLiBJdCdz
IGFuIG9wZW4gb25saW5lIA0KbWVldGluZyB0aGF0IGFueW9uZSBjYW4gam9pbiBhbmQgYXNrIHF1
ZXN0aW9ucy4NCg0KVGltZToNCldlZG5lc2RheSwgSnVuIDE0LCAyMDIzLCBVVEMgNzowMCBBTQ0K
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
