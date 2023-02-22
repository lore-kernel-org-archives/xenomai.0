Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356F81FB5
	for <xenomai@lists.linux.dev>; Wed, 22 Feb 2023 07:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677052328; x=1708588328;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=k6WA4LWQ9EqzMaJfPYVPF/F9ka4UCSLkD3eZz1bmQi0=;
  b=M8TNkGLZY13fofWPh0q1YErUxh8QfprYNNqLdeqD8lpk+n9R9zXKxT9S
   zyiCY+Oa+2ZUnDbLIaeTLwzp8iO7x4ai/ul19x7qxA+fj4wEG1PA6KUrJ
   871Xe1BZCQti6iTDAszo5fPw0mmrUY9OQXQalln2YB8W53BDA0pypp4c7
   tfIhFzsABNhAAvyO/myYVC/fM8Wk4wJEGubm8yYEimIR0oU9n4SK3+Hg3
   O6G11Itnb1/vSv2M41+AyYWn/u6O2RFhEWawDfsHl0TZZ14YlLD5+K8FU
   8i+9X82zO/8h+nyS5I6I4sbu5woU1h7w72cZkK0tq7/D2sUasHsrabE/+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="313234098"
X-IronPort-AV: E=Sophos;i="5.97,318,1669104000"; 
   d="scan'208";a="313234098"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 23:52:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="704365695"
X-IronPort-AV: E=Sophos;i="5.97,318,1669104000"; 
   d="scan'208";a="704365695"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 21 Feb 2023 23:52:00 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 21 Feb 2023 23:52:00 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 21 Feb 2023 23:52:00 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 21 Feb 2023 23:52:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfnvcAMRcOkMV3IDxL6bhTE5KC0yyIzoGApn9RGjAgW/vgWoCjpOgeWIIuGcablb+hDUjRj5J+zJcrzA44QxWVfJy/UkLIGv75woVreVQACZ7acHPqcnbLwj+XRuFjCTad6T5TQytJLBW3puHsB+7+jzqsgFaqODN41PKp1TRUjp8HJzde9rax+Jgx50GFPvE9sjJ6qzMdcou8TXz8vWaP/vNj2QYgKRjIvzIPXfJJU+G8sQaW8BD/8YZGBY5v6IPuh3OsxJ3GQeiCmtJfmQZmaSVmp7jWygO5HGIc9x+8jFoF1dtHnkwopsU3OO2fHBIBtuEJXN/5rghuxHErfI2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6WA4LWQ9EqzMaJfPYVPF/F9ka4UCSLkD3eZz1bmQi0=;
 b=DutBQQ+8+P+bkx8+GS8ngPTXyYKsZMP+HkKmxHj8XF6SZKfotsYkgrNCUNUrBcyGOuu6EpXs8qhvMxHkDAReRL91fBFZHfjY67d2YTlNfcwO0b5tz9Oe5xB17sdF2WkHFhlamyQakJsEDHzdbecTXzUe8m8KQ0nKEKg1q9WFTIUITirtv11TJmR9tIogDoA4aONcTw5gSb6IH+mEGvTVDNoQifwFUy6ZSUBh1dzDRo46QKWbwTQTDKiLjCmjvcZvzSk1A14H3fPHcUkw7LK2fLycNfJzv5MQ/5BRqaDBekMI9UnravQCIlEnaIdJa7ULgChkdXMexnqOraaDJ3+v1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by PH7PR11MB5862.namprd11.prod.outlook.com (2603:10b6:510:134::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.18; Wed, 22 Feb
 2023 07:51:58 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::a906:2493:ed48:e0ef]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::a906:2493:ed48:e0ef%4]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 07:51:58 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Xenomai Community Call Minutes - Feb 22, 2023
Thread-Topic: Xenomai Community Call Minutes - Feb 22, 2023
Thread-Index: AdlGkn09LUq1Rw0nQwiw6MIJFRsCjA==
Date: Wed, 22 Feb 2023 07:51:58 +0000
Message-ID: <MN2PR11MB428558414A873F5C484F8F55F2AA9@MN2PR11MB4285.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|PH7PR11MB5862:EE_
x-ms-office365-filtering-correlation-id: a1dd21e3-7798-4adb-1f7c-08db14a9acf4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KXO46OXJUerlUQCXWV18BtGl6M1os0YHsFLD1PW8cG9S1RKN/AHMuWRva67qJGvFNIn9n0J9E1Qfn2M4f/p4qXLPsB/c40CsYiTjBCL2/4N20bLFyBhu5PwXQsu7UE+XSHxUrBNtLzDRilyzE3NanCOWQyw4Jhm6+dX8ZU4W4zmQvWudKb/78unUWRc2JEw7KHToXo67NiWrXGGeNaD1jjgSLlT+1KzHWWiEaJ0vGkYboJ3413KGAS/0mQFWvTm9kAtN5OOGnMnWM0/Hppxd/tFE+g39HaiUQSQg5yCxEukk5+b85ot1D0VaZvjUSfGEAyzjS+km6nUnlPUdzQr+oS8hGVxY5EqFY3JtmKRiKSpeAoXYjUMDN/lNjBgjk/1s5116wf+NECa8AMU1XKkfq2dzL7VtYAbXtkLAC4c9ovMPguyoFLZO97cdpQUXfC5vRh3sCvJv6oe5oA6Wflp7g2vPWYH34lHZj/T+bUyDt+V0OYzTWYe7H7bROcx5LIVAoK2dUVdjJLtz8+g6gstEV44YZQ/oAkN1lcSf4nkrKxKQwXakdPKGPLayYTvWlz5McYnpj2/1ItuWZ6lska9vLoGTLeAoYg05JLHBRd8piDFEzyFXQ9OQCYqpbqmbD54/UVT0GZBcOUmmfHHb3G9SXL58zip3XRR5xxtIkwwQFPvEwRrvn8m+RYN0hOCI1VROZJSTIR2ZfVVfuLKxxsTVyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199018)(66556008)(6916009)(8676002)(8936002)(66476007)(64756008)(55016003)(66446008)(66946007)(2906002)(52536014)(5660300002)(76116006)(41300700001)(82960400001)(38100700002)(33656002)(122000001)(38070700005)(4744005)(7696005)(316002)(86362001)(478600001)(71200400001)(9686003)(6506007)(83380400001)(186003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Yjl6Z1ZyWTdFNktHdmRNTkZqYnJHOTJMR0wrWkU3OXVLcGFiZkZSS0Fia3o5?=
 =?utf-8?B?OU1RSzlFT3JGY2lrQkk0cG16VmRUMXRZUXI4Y0R2N05RN2RMb1lYOENUT0o3?=
 =?utf-8?B?VUk0dGVNb3ZxYXJ2a0FzZTFrejM5cHBKOHB5aHFuaVlEclRON05RZ1AzRVNi?=
 =?utf-8?B?N1lkVjA3TjQzN2ZiNUtIclBkZmwwU2hWLzlCSEZoV25qMEQ3UkZ3Nko3K0pX?=
 =?utf-8?B?V3lUbjh4RWJ5R2NsbnIrbFFxdTB6TG54aUl5OG1jdFg2SE04cVYydGorUm9G?=
 =?utf-8?B?ODQrNEJ4R0FuQjk0ZkRHZmxxQjVLd3UvMFhsdktpMW4rOVpsMHNJUUlmY1E1?=
 =?utf-8?B?UTVvUDF1T1hVWlA0NTEyekJvT2dyZjVIU3dSMFNyalpZaGo1OFRMczBRWGtB?=
 =?utf-8?B?bUdQZ256YmJMRVJLaGRmcDlFTkpBR3MrV0dtYkk1TjFDVzRvUnBTdmdzYzlE?=
 =?utf-8?B?QVluMno3Y3lPS2g0T2JaWU5SbExpRmVPMUViL3dkWDMveUY5azlvVWI2R1FX?=
 =?utf-8?B?OHE2aVd2TDUyajcrd2xZTXo1emVXRWtVNW5EaUdibFd5YnVpUDg4UkdzcWpj?=
 =?utf-8?B?ejZDZ3pIZ085c3kxeTUzM0daYzR3TGo5dlJ3YTlHcjU3dGh6bDlUMUFOckRq?=
 =?utf-8?B?OTlqQUdZc1k0SE4rSUIwZlBmZEdFT2ZiRkZtc212QWhPS1R5d3dUdjhZVHdR?=
 =?utf-8?B?ZXlwWG9WMlNwSVoxU2pJNlpwd2F0OUlueHNBS2RkMjI5Q0tnelRjclNVUjN1?=
 =?utf-8?B?M3hxbDhKTGhkL0pReGQwOWFtWVF4TlpFeUNNQjZDeHI1VnJTMGR5VmF5SHY3?=
 =?utf-8?B?cmJPYnRZdjhvQStYRGcwTGNFQnFlWnRKQm9uT05ZYlNxOWN1dzVPdmV2VERM?=
 =?utf-8?B?UUJ5cW5IMGtsNkxaYlc4Y0ZaZWU0SWFsM0VKWnV6dFhML1JNbzhwRENnNEx0?=
 =?utf-8?B?a21HUUZCakh5MGtuV2NEcTFVRFZiYy9iWGY3SUtqTjNJQ3NsS01wQUtpMnlO?=
 =?utf-8?B?a0F1bDJ4T3N1SG1SYjFwbTdDdjJIV0VSWUVLY1MxaUh4K2plRVhHMzV4VjdT?=
 =?utf-8?B?aWJmNWs4T2h6T0F1ZEcrQXBsOVRsNUtZbnFoMUJvTm95cVVNQXhXRmRtVmdJ?=
 =?utf-8?B?bWFDSDllWUN3ZTFGRGtEOTJjclQvT1ZjMTMwY2JybGUyZUJFMy9ra1hCaW95?=
 =?utf-8?B?NVpxdHRkVkRCRS9odGNkVmh0WHRzR01rWUx6WHZzQVZJMVJOcEJvVVBEQzZj?=
 =?utf-8?B?dmlZRGFDQ09FM200dWxYK0ExMmNEWEFjRHlXeW82dWdNMTNwT21sZWtJeGti?=
 =?utf-8?B?OXU4SE1UbUdOalIyMmRGZndQaHBmWk5tdXhKaEc2M3E0cHYraEVLanNnbUxL?=
 =?utf-8?B?WEIrMk5QYXNwUkpKak1aSDQ2QWcyM1YxZmdjQzFwaWFGbzMzQnZheFJQVXVj?=
 =?utf-8?B?NldrYmZOODgydzhqaGFCdi91SG9kQlRKYU1uNk9PMVRhQXE0cWJWSWpRa1BT?=
 =?utf-8?B?SEsxWllqbXd4QjZXN0lYZHNPL2ZOSFpseHpLUXdQMnY2cktyM1lwNE96M1VN?=
 =?utf-8?B?czAzQmlkSGNOd0ZUQ0I3M3pYMEhweUI2Ti9ycU91M1o5T21vMW9kbkYyUUla?=
 =?utf-8?B?MHByK3JXZkZnVmhVZDByRFpQNEZMTWpCQ3RyM2hkdHlHOW12dVI0djZxYmhm?=
 =?utf-8?B?WVRvSGxIQW1rVzRQYktsV2RVV3Y0a2tPNEllbkpWUUxFaHNDN25tWDNDcEFX?=
 =?utf-8?B?S1dLbWlxS0czaWlmUWFocGNhYjYzNlpBQlZuUTNMZ3I0ZVJ6Ykh6dUd3MnpD?=
 =?utf-8?B?dk9Da1BEeDRiVDNyWXI0cUFGc1grNHduQUxOMFNxL2hEOE5kblNaNURtQ0ly?=
 =?utf-8?B?TjExVEdGV01MR3BqSHZqTi9qMG1FVm1rSmFVYWhUTWZhUktDUjlRQVBMUGw5?=
 =?utf-8?B?ZDJ6Wi9YQVowL0pPSyt4bVNpS0RCY0FTWlZTc1ZXNW5zVUtqaVI0MnlQVk5z?=
 =?utf-8?B?Q2xPenJ2d1BRMElLN2MzSkp5bWFNOCtmWlRqdUJLQkF2ekt0Z04ra3dEMTla?=
 =?utf-8?B?cVE0V25yVmJtVXBQK2UyZU54YTE0SUNxR09zVFRHanhKbUJNZS9uVnd4R3Q2?=
 =?utf-8?Q?IIjsyuyqX29Xh8LguPMId/3zb?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a1dd21e3-7798-4adb-1f7c-08db14a9acf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2023 07:51:58.6296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jslmdxb+PiAWjAIfIvrwAsDsrWziS0/9RNsBPk3wVCG1S/MwZ3hqv9whg15itHJ5oP7wcb5qwGaylAa3RiooHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5862
X-OriginatorOrg: intel.com

QXR0ZW5kZWVzOiBKYW4gS2lzemthLCBSaWNrIFdhbmcsICBSaWNoYXJkIFdlaW5iZXJnZXIsICBC
ZXpkZWthIEZsb3JpYW4gLCBIYW8gTGksICBKaWFuYm8gQ2FvLCBIb25nemhhbiBDaGVuDQoNCkNv
bW11bml0eSB1cGRhdGU6DQoJMS4gU3RhYmxlIHY2LjEueS1kb3ZldGFpbCByZWxlYXNlZA0KCTIu
IEktcGlwZSB1cGRhdGUgd2l0aCBrZXJuZWwgNS40LjIzMSBvbmdvaW5nDQoJMy4gWGVub21haSAz
LjMgcmVsZWFzZSBtYXkgdGFrZSBsb25nZXIsDQoJICAgIFhlbm9tYWkgMy4yLjMgd2lsbCByZWxl
YXNlIHNvb24uDQoNCk9wZW4gZGlzY3Vzc2lvbjoNCgkyMDIzIFhlbm9tYWkgZXZlbnQNCglLdm0g
b24gWGVub21haQ0KDQpSZWdhcmRzDQoNCkhvbmd6aGFuIENoZW4NCg==
