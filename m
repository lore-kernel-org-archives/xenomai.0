Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EDD1FB1
	for <xenomai@lists.linux.dev>; Wed, 22 Mar 2023 08:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679472064; x=1711008064;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=eJy7eIPGMfqhI0rE93kvQ6+c7X/puv6TOcJanRllrhE=;
  b=ewArFk5bLVF4HrxXiruxGxWEyCs0+8QVqcXwpimdlyzMOYuroqnSHWgc
   Mralf0G6raPp/r63RtJmAAApHaiOUixhpxjJAZ0cvNGuhUiJKCV3GDp77
   2FpnLJ5bcwHCSGKPJuR9MBmlNouaqWvTPGa2n9q0eofIW3sOWwGAPVci1
   eBTm7s5WUYjRc5uKOnMud5a4w1//QKvpQajc/uNd53E3claek8qqdTfXr
   +3bopoU2RDQ+IjWvC44mK4Eh+vLBjsm5RnVr5cCAt3xVS6S+COKxceHtQ
   yW3sxOnjdah1sjdU+aT1lTQwb2l8YlpPTw+vqbShnNv68qjyuahclP24J
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="336656647"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="336656647"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 01:01:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="746211103"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="746211103"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 22 Mar 2023 01:01:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 22 Mar 2023 01:01:01 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 22 Mar 2023 01:01:01 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 22 Mar 2023 01:00:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYYjhglASvOzLmtuVB9g9l25Vd7OHvOGxx26F0PQRnP5pbjuZimgeZYTbTPNkP37IjJybuD7drgV1F7wXr0g2LsaxrmGX8VqaXnUg+EtjTsjkX17GrMn1s5ZZGlAHHZjpEaV/BvPCEEgPYtrJXsIWabEi7V2EfQPxEYr2FixvzMkhJ1M9ONerR5m5Y3BgOxI2mTvH4/JVMxohWD5GHWvZMBV3htCmHkEbEeaAdeJjAWf7cjkEylFHIqWXYEtJICI/tk3enwLjloTx6nuF3r99ZRuyUMVtBo2uYGM3jTzfe1zXlFusmDAMmu0VrddWxvI/uPrZdzGVvr/fbMDTtm/9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJy7eIPGMfqhI0rE93kvQ6+c7X/puv6TOcJanRllrhE=;
 b=cSfpcJUr7AoS9S9Ca2xlKQFHf9h2i9r1vcqa4opVDNldza8llSBxbHd0weiwTde2WVuHaD4d1Lp7/wkxYlU+g8rdjRfKVFuGmYNPDcieW9THhezmCqyiNMSXzkk20MRp9inQkpXm7Z2qyyvADUqYz0Lv71YOJFo2qjoEizYfd+iiIKDOZUJ++5x8OCFXundY7lt8BbTAWpmRTHIlTYd0Pal8NQLptd2AYp3FQeR9/TpAUXoK9/szYm5AFbuduMPCZIPFuHn0LdByM4J8hlgs3VTvL/RraLBAeqg4ERp/ouzExI62/cBsk0dO9vXeu8rUhkz7H+yMjX7V7JYQSUxYcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by PH0PR11MB7563.namprd11.prod.outlook.com (2603:10b6:510:286::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 08:00:52 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::e1b2:52d4:e80c:dfac]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::e1b2:52d4:e80c:dfac%7]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 08:00:52 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Xenomai Community Call Minutes - Mar 22, 2023
Thread-Topic: Xenomai Community Call Minutes - Mar 22, 2023
Thread-Index: AdlclFctnGFi34L1TzawniAtEMau5A==
Date: Wed, 22 Mar 2023 08:00:52 +0000
Message-ID: <MN2PR11MB42855BD403A029EE72C6640DF2869@MN2PR11MB4285.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|PH0PR11MB7563:EE_
x-ms-office365-filtering-correlation-id: c8253acb-bfc3-4169-bac3-08db2aab8e7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vYnTi8he26ZmcSboQAfd44ws9YoJCPcc+yA0Z/LsUXEH6f85cCC+y4EmMu5WBq7DAg/T1gBJJzO46Y+gjVh9pqRxxlVUwUNtPsSraaGKFCw4DZH7p8owhVoyxPte4uC4avUngFSrjCNjuzv/j8YVE2bDMZ6acGy5+Ovcq5pLKZambXhtZPdLHYKJipymK4xzKq4XNiS3MimeYqxw+CTx7ByBBP7pQfXEHPKuQz9tdgt3FtYR46EMtW/sNGFrXO1dDdX04x+oy9sWLwIEYkJs/+G1SfRJ9jMj/KUAK4fcmH7RQ+f5Nvn/uiXUXSH1nmYTB8TNY73Ha9epnEWs66zezZNRrTdLCwAX4sqTRkO8PGLVtSvtrbTV7lMfZh4Vk+eTM9CkQHTMC1mCv6oc4xLu4OEzubnGZcDv4ARMieq/jfe30G3JU844kzFMZ6XIW3qx/9YsRIcUrP6bbtyZGFJqjQjuS6gawRyEgqZC7zs+1et+VphbiIfymCDEevOFfF1KGdN1bSV9JeBNgFkyyxlGUcFmShu//HAv/6AMb51UsCMZuIJMDZ2B00DtATj1+LzGwJjRQppjCn3fnYRrsYb5B05w3jI5zez9u24DOmkqhA5bIJIxjW+BDpKpW5RcK4zr3hJX5T1eVUhuOL1Q/OYZK6RhoeVSKZR+qa2MnVy0WLAJFGTMxiCOwtu99hQLRV8eJXfNwG7QPEIGfpj0EGUqnQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199018)(6506007)(26005)(64756008)(52536014)(6916009)(76116006)(316002)(71200400001)(66556008)(83380400001)(66476007)(9686003)(66946007)(186003)(478600001)(8676002)(66446008)(4744005)(41300700001)(8936002)(5660300002)(82960400001)(122000001)(2906002)(7696005)(38070700005)(38100700002)(86362001)(55016003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHFqTUJNdkZKbmtNSnpHN3M5aVYxdzV5aGd5NXdaN1huQVB4Nm8rcFIrd0ps?=
 =?utf-8?B?QjZKWVd4VnVieVNaaVFiVWVIZERYdUkzWWdWdEVLWS8xSjFHTTdESURndVk1?=
 =?utf-8?B?cmFUYzNzWk9EZzRHRDZYNzc1NXI4Z1hid0duUUlMN3JpNHlQblR4R2tOaHV6?=
 =?utf-8?B?b09SbVBMQmM3NFJlRmh2YUV2bW1Cc2JxWG1aVURza0QwckVwcVFEbFh2TmlQ?=
 =?utf-8?B?YWd1dGs3NlAySmFaT1haRzA3L0RHN2ljOUhTM010WTgwZjN1T25RTGhvQ2Zh?=
 =?utf-8?B?MTZOb0puamVKQ3UwQ1R2RmJVaG9IS3RjZUQyUWRtdk51VXhRYnVibTEyMk5P?=
 =?utf-8?B?MHByNW9MWCtENEJncnFURVJTSTdiNk5icVpzazJTVDVqY1hXTnJDMmhpcnk2?=
 =?utf-8?B?Z1hMN1VORWhqUi9Ga0o0SVJZOWdiY0t1Zm1wSFlISmMzck83NWZYQzdUcmk0?=
 =?utf-8?B?SWRCNEJOM0p6MHJldGFySGYxSVVpeXBrNDVFMjNYR3ZEaGVHTHBMaG1DMW1V?=
 =?utf-8?B?NURKckJuTndhYnVQQmY1cWJmeHlhZWJxSWFJT1UwU0FHRVFZTi9Od1IzRlpR?=
 =?utf-8?B?VWNiL2dJZ2hYU3QvTDNnYWVzUmpmdC9DZ1IxTUQySFR4K015Z2lGQTFoZFlI?=
 =?utf-8?B?a1FUdEJKd3RkTTdieTY3R3ZjUDcyRjNsU0g2R3dKSGZUbllKYzhBbk15NWVv?=
 =?utf-8?B?bGhTSGtTM0c0NlV4RVR1d2pKK0lBVUdLT0owNnJuQWk3bThhOEdEK2VBMWNj?=
 =?utf-8?B?VGRuZHJneFUrSkxJeVE2NlNsdkZUWjMyQVZDelB2c2VpSGl3TVpDRkhKeE5h?=
 =?utf-8?B?QnhhNUd1VVUrSko1enNCWW5jc21rMW9XTVpQTktmMjNsY0l1UUMyeUlxK1hj?=
 =?utf-8?B?bUhpeDBmRG1xc3E1MGV1dTdzMTgwNDJzRGhhcHJoWFl5cml4U3ZWNHpPcTky?=
 =?utf-8?B?M2xMOWg4YXhQUVBLUnV2bnBTNE1kQS9qVTdNakdoQWRoYUtPQ3lPUTlQTjZy?=
 =?utf-8?B?S1VTV1kreDNaUXl4MC9abk9IdEUyS1EvR2d1dy9GRVdEeWhBdjJjWlllNUxs?=
 =?utf-8?B?UnZ3SDhEOWlwR1NFTkw1dzVUNzJuTHNOajBMRW5hdDVSS3NyMU9iR25UMFpa?=
 =?utf-8?B?dzJPaHpoV0Y3TnhEaUFXT2ZBeGVwNDQybWxPckxYZTZNV3dMcmN2Y0Vsc0l4?=
 =?utf-8?B?V2xCWkdCYklVTUZmS01KRTdXQUJGbTJTQm1HbmhMdDNaMngvSzhEd0txYU1O?=
 =?utf-8?B?M0s1VHVmSUdVajZqWm1GWXdON0IwSm10WmovOUplVmR6Smo3RDdQeGNxa0lP?=
 =?utf-8?B?aU1BaTN1VDhIUk5QVGFERzgrYnZ2b0R6enN5Y0poVGREc3lQUkVLU1dBdk5O?=
 =?utf-8?B?N1duWFd2WFN2cTgwREY1MXQ0S3VOMkx1MCtHTlE0bS9lWnBXTFFINkdwU2dn?=
 =?utf-8?B?MHNNem85TTE0NTlRV1ZtSjN1WUtISWFQd3BtenVVQndXcEFBbTJhOG5SNU85?=
 =?utf-8?B?RzJLQXRSTzR4SmJQWnFIWVV1R0V5R1VZZlRpVG82d0FoaHQ0K3BGWFBISFhz?=
 =?utf-8?B?WHllRVE4b2dBbXQwUW5IOG5uR2E1MWJrQVpPd2FtZWhMNThVd2tSZ2dVdW9Z?=
 =?utf-8?B?WkR2d212TjlmSzVmMHlqU2hrNTZGSFNzQS9YSTcxVTR0QXRCcWhzRFRZZ1B5?=
 =?utf-8?B?OWp6MDVhaFpWMVlLaDNSU2hteEtqT1dGeWkxeUYrMkovRU0ydE5ReHFqNTZW?=
 =?utf-8?B?VHNMN1ZjdHJibFVsTG5jS2RTSjBWeW00U0hORUZJcWR4TmFLaTVLY0FobUxE?=
 =?utf-8?B?azRLYy9iTXBMTjBpbng0NnZkVHVWc2JHYS9jS3FUTTRwYTFOOGZtZUN1U0N4?=
 =?utf-8?B?cGhHYlNrS3RtbmU5RkxkSDY0QnBGeEhmWkN5RTRTVE1VS0tZZ2dsbVl3V2Js?=
 =?utf-8?B?V092b1hMcWdIRVlNUk93aXVWVmRoaXdpMTMrL0t4c0h3Nm9HY25iWldDOUVI?=
 =?utf-8?B?MHdIbm1NVzI0Z2NxaDJ4SVQxeFI5Vk9ZL1FHTm5YM2FIMUgxeVRVUk1EM0Rz?=
 =?utf-8?B?ZjdYbklPa3gxNXQzMVJoWHJKN1RVNzNGa1Vxbkc5UTlZdGdvUjlLR3pra3l3?=
 =?utf-8?Q?vBZX72GCarw+uvFc88sjBNylZ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c8253acb-bfc3-4169-bac3-08db2aab8e7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 08:00:52.0614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rfn9/zUXYDjo6PjcUNxPntHhlsCsRScQWYnV7SbUaoB1sI8VQ2/N+dgS7f0kIQ+YwEz/zpQOBsLyIpLrAbIxdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7563
X-OriginatorOrg: intel.com

QXR0ZW5kZWVzOiBKYW4gS2lzemthLCBSaWNrIFdhbmcsIFJpY2hhcmQgV2VpbmJlcmdlciwgQmV6
ZGVrYSBGbG9yaWFuLCANCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQWFyb24gTWFyY2hl
ciwgSGFvIExpLCAgSG9uZ3poYW4gQ2hlbg0KDQpDb21tdW5pdHkgdXBkYXRlOg0KICAgICAgICAg
ICAgICBGaXhlZCB0d28gaXNzdWVzOiBhdXRvbWFrZSByZWxhdGVkIGFuZCBsZWFraW5nIGNhdXNl
ZCBjcmFzaCANCiAgICAgICAgICAgICAgU2lnbmFsIGhhbmRsZSBjcmFzaCBwYXRjaCDigJMgb25n
b2luZw0KICAgICAgICAgICAgICB1cGRhdGVkIERvdmV0YWlsIGtlcm5lbA0KICAgICAgICAgICAg
ICA1LjQgSXBpcGUgdXBkYXRlIG9uIEFybTY0IOKAkyBibG9ja2luZw0KDQpPcGVuIGRpc2N1c3Np
b246DQogICAgICAgICAgICAgIFhlbm9tYWkgb24gS1ZNIGFuZCBBY3JuDQogICAgICAgICAgICAg
IFBDSS1QQ0lFIElPIGFjY2VzcyBwZXJmb3JtYW5jZSBvbiBYODYgYm9hcmQNCiAgICAgICAgICAg
ICAgMjAyMyBYZW5vbWFpIG1lZXR1cA0KDQoNClJlZ2FyZHMNCg0KSG9uZ3poYW4gQ2hlbg0K
