Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825831363
	for <xenomai@lists.linux.dev>; Thu, 25 Aug 2022 01:07:35 +0000 (UTC)
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 049F6200003
	for <xenomai@lists.linux.dev>; Thu, 25 Aug 2022 01:07:30 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 51762940838
	for <xenomai@xenomai.org>; Thu, 25 Aug 2022 01:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661389649; x=1692925649;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=j/OQwx4hBjB1xSyLAMbxKlz2IiXvGoe3Ny3biBFLD8k=;
  b=QBVE2nrhaxcR6KIIM4XXgBXiQYw2SPtgixb9xe2V2aor0ffZJ/sEmGRv
   C8AsvsLBL67QLm7uD5YCx1xusIujdQCNHPpK1TIracoKWzki6xr9Tbw4n
   F8s8zXVXpssZN3hnU5bBVjekNTJnHgVFqcQunmDwzXFEBrI3jIOf27D1t
   mxnHqUJOQr3rOLHfWIDKu0qLs6fZw/Xj4NKCN4vVvgeTlVylWG35RUu54
   iGG11/D2IH3hHwKptPMIsCiAIXIa3/wN0KrAsNZ5UO5KF8+B1eOQWt2PO
   2fYw/hxDhQUOV6OralkgaF6NFmsDkeVR4zlfm+ngtH1ZNdlVNuVgUbFzs
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="295393340"
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="295393340"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 18:07:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="752286787"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 24 Aug 2022 18:07:25 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 24 Aug 2022 18:07:25 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 24 Aug 2022 18:07:25 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 24 Aug 2022 18:07:25 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 24 Aug 2022 18:07:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R56OTIHF3ToY5w/mxyQymNJ94X1pJNZC8RAACGrm/ipEIV2i1GR6Y2WR321kBZORHj+xwDdl2jBk+JL3LBb4TQdoxpXpv1v0vkR/jW7bykHwZGXtf8xWQ7YXgRpxwf7YOtTlpReGnY/uZqin6Mp0hEoj/UqIvLHIkIZgLKlH7MkQ/fq8S23jfPyHJPXULA0QQstmtznGShyME2mI+O99u1wY2Tu3yHaS6OPYTKvDGnru4qD4A/9ZNxCrFbkmTeRi/2O3Zyv15tCoCSr/Daa8tBPmj4jsaioLql9RGB9r6whufKItl0fERTKUVfckDeE4YTw7RNKh9X2YRrkQOVMTFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/OQwx4hBjB1xSyLAMbxKlz2IiXvGoe3Ny3biBFLD8k=;
 b=Cl+XNvJe4/bFo4LeQnMOE4TpTr9/WBPTKOBRgD8vTnSWfxOlt/OgLVYcqWn0ABz3pPSrsCMTT6lh/8FoJhaFsOWboqXebLZNS1r485VQefO50tjE05IYyyVvdqe4RjjqjK4nuwOUnA6RAJigFlOwOJ83sVEPaRsivGslBDy0jyOjz/x1NIFFJVcd6/I8BZpmYwVStyC9lJbldjsTZ4bqXiPm0dVSM354rRtN94xO4iXlT6NPG4MuwbnabIHUdGRESs5SU92VM6YCdF7l1rVW1fzRewZsdB7dXuqLrWmSVvdvnhP/SIAd+12kIH/XgvJ64oI3/fmK45n6OWL8NgdvPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BY5PR11MB4276.namprd11.prod.outlook.com (2603:10b6:a03:1b9::27)
 by DM5PR11MB0026.namprd11.prod.outlook.com (2603:10b6:4:62::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Thu, 25 Aug
 2022 01:07:22 +0000
Received: from BY5PR11MB4276.namprd11.prod.outlook.com
 ([fe80::a165:c057:5dce:80f8]) by BY5PR11MB4276.namprd11.prod.outlook.com
 ([fe80::a165:c057:5dce:80f8%7]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 01:07:22 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: =?utf-8?B?6rmA64+Z7KO8KERvbmdqb28gS2ltKSDssYXsnoTsl7Dqtazsm5Ag65GQ7IKw?=
 =?utf-8?B?66Gc67O07Yux7Iqk?= <dongjoo5.kim@doosan.com>, "xenomai@xenomai.org"
	<xenomai@xenomai.org>
CC: =?utf-8?B?67CV7JiB7LKgKFlvdW5nY2h1bCBQYXJrKSDsiJjshJ3sl7Dqtazsm5Ag65GQ?=
 =?utf-8?B?7IKw66Gc67O07Yux7Iqk?= <youngchul3.park@doosan.com>,
	=?utf-8?B?67CV6rK97ZuIKEt5dW5naG9vbiBQYXJrKSDsiJjshJ3sl7Dqtazsm5Ag65GQ?=
 =?utf-8?B?7IKw66Gc67O07Yux7Iqk?= <kyunghoon2.park@doosan.com>,
	=?utf-8?B?6rmA7IS47ZiEKFNlaHl1biBLaW0pIOyXsOq1rOybkCDrkZDsgrDroZzrs7Q=?=
 =?utf-8?B?7Yux7Iqk?= <sehyun2.kim@doosan.com>
Subject: RE: What causes the latency of the rt_task_yield() API?
Thread-Topic: What causes the latency of the rt_task_yield() API?
Thread-Index: Adi2hA+8NshNMGH/S1C5hT38XRCzfAABQnKAAEPabkAAHYUU4AADTiNw
Date: Thu, 25 Aug 2022 01:07:22 +0000
Message-ID: <BY5PR11MB4276CD67150EE6042EB1A849F2729@BY5PR11MB4276.namprd11.prod.outlook.com>
References: <SE2P216MB1394874A00E10A497FE73DE0C2709@SE2P216MB1394.KORP216.PROD.OUTLOOK.COM>
 <MN2PR11MB428519AFC0F522BB25FDA093F2709@MN2PR11MB4285.namprd11.prod.outlook.com>
 <SE2P216MB1394C7C6A067126F36022F23C2739@SE2P216MB1394.KORP216.PROD.OUTLOOK.COM>
 <SE1P216MB1509579188F44BA6C35E8547B1739@SE1P216MB1509.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <SE1P216MB1509579188F44BA6C35E8547B1739@SE1P216MB1509.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb7d67dd-e9f4-4a74-bab3-08da86362a8a
x-ms-traffictypediagnostic: DM5PR11MB0026:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SKHCnsYJJBgqu3LawRrlHSR7crOq+G8iQuujKuWOO72l/aB8vuqcN+qAWqw7Dv+mu5/rODPh/bLnXZOtstIGu6CPSAIZVpuQYRJzsgnNnsyXzpj7uc6okcVvOA4i3+r0ceqwp09efso29XOayBvXq5CiRDoMyagnMOjZK/P3NvXAae60GUTc0uuT0OgpJvDaTcCF1hTHEcHSmFqi3snskwwa7tbZ2KxroNzy6gtqLd1mtK1wAMWWNdwYzasB3g/qkA/EAR8osnlmpaL8qeJe81VlrTJdi2Nr1SmuHVBRWb6bdZFYl2qEZxc1DNs6W9oe8KUOTJkNcxfXsWEKho2Mi9f+8X9zu3KtY3NMUVFU4xKYZwZcll2Jg7m4GA2d/1RYUpVSsA6P59A8EfPVnZAkPv0DC1ovPKLMLZ1QLTQkYSAj5IK2xQbpEd0RkVI+inpvWrWNzs/t4bc9C/8R61rBQgYiR5PcuATTp18E74XLq7WDwZSsB6Nr4b5VnxvX+IC94Sn+wf2mjzr8SgceK0G81+PBUiFd9eI38cw/s4hP839HrohZf9Pm3FHfvPm3KGQs8B4GeekeyizpgJrplLr174r2EM2bxwJK2d4hXCm12ksNQfDOBggkmadWmcp91U8GXVmm0kOWoEzS1mp7/UcatSbuaaTg2jG1KrqQeLO7q2x1nAxc5tiAZwlQyCa7BAiryovARyMGkqLQ2SFtGy9O5C8dCM/vy7ieAEUMk0mIvqHJwL2HL8mNrWQmBmsIMmFaUF/3+15vAqOJms4OZMS/SSdJHpLQ/XpubHfdapS2X3I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(396003)(136003)(366004)(376002)(83380400001)(55016003)(38100700002)(38070700005)(4326008)(33656002)(66556008)(64756008)(66446008)(122000001)(66946007)(66476007)(76116006)(8676002)(41300700001)(110136005)(8936002)(6506007)(26005)(52536014)(478600001)(5660300002)(316002)(9686003)(82960400001)(7696005)(186003)(2906002)(71200400001)(86362001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RzlUdS9LT01pWllvTlZicUw3Q3c1a0grUERRNjFLQ0dmOUJDdm9XMmlTN3hU?=
 =?utf-8?B?OUpyQ0hqMVZldXFvdGk5ZHlDZzV3VnFJdUs4M3ExLzBPK2RGYkhZMDVKY0l1?=
 =?utf-8?B?QjYwVVBuQlN1WGcwRysyU0xpVE02UkJGUnFjbUtKL0Z1VHJLNkl5RFZSM1Rv?=
 =?utf-8?B?RUtxVDNTS28xWDI3bGtaKzdTdU1BL0Jtb0s2TmczZVcxc2hhUWJueDI1Y2Vp?=
 =?utf-8?B?ZndlQlYzZms4bFo5bEVvcjFGUTQyc2VyaVFPa1RqV1N4amFWV2J6MVpZMkFT?=
 =?utf-8?B?Q3NQQWorVVduZHdoR1F3Q2ZPaTFMMmVHbkZscFpFcEtESnJaTnlVMFR5a3Bj?=
 =?utf-8?B?S0hUc0RiWS91VTZTODZPcUQ0SVBIdUVNT0NFaE00NS9DcjJHeVk4cVpvdGho?=
 =?utf-8?B?aUVpeXp1VzZuSzZ0Z2RiRmJqbmJlTjVlTDhNU0Zyc2FJUGczWVFRcEhGYlVh?=
 =?utf-8?B?Y2gwY1U0TVcyTW11RzI0TkpTMURUQnBXa04yV2M4SDlySEtwdFlveWIrQ1pT?=
 =?utf-8?B?Q0RHR2RXOWpnYWsxNVFISHY3Q2ltUG11WkRZSjV1Q0kzMFE4cDFFaUVKb1px?=
 =?utf-8?B?dFJUczRRWEZGRVZvT3lsYy9ldUxsWHkrYWphd0dEdEJBV2pmUTVsMWNubGYr?=
 =?utf-8?B?V3lobFRZV1NOTzFSSktLanphUmo5ZTNYdnk0Kzc1eENYbldoRkQvbnVXNVh0?=
 =?utf-8?B?Z29henBQQ2JqTVpUTlR1V245RnRCZDRISkRnMW5qTVBtQ1hhWE9tT05aYURH?=
 =?utf-8?B?VTVKSDZmbHJLOEtSK25kbE5MNHlGMGlqV21VNmJUSGI4OWFFZzViclV3T1hz?=
 =?utf-8?B?V21Rd0JhREU1LzR4aXpDaWtSQVJ4M0RhMDd1eWw5dkVqV3luT3ArVUJCeXNn?=
 =?utf-8?B?ZjNuNHM4WmJQUk0rZUJvSGZma2oyMzdrRzBPMUlOWlFvMHU4NUcyWjZLY0FO?=
 =?utf-8?B?eFovaUF2N2lYNUl0UVNlVjZ0TE1hTVF4WHZBVWFsam1rMEpLbjVuYUkxYnBL?=
 =?utf-8?B?QnljMGRDaGozN2Yrd0xpZjFCUHNvS2FkYlV2TC9hM3ZCRWhBSzR4WTRaYUFy?=
 =?utf-8?B?NGJ2K3hUYmQxTVVsTlVEYjUrSHlVa2c0cWpCRThoTXdpbU15Sm1rQXZJZEhS?=
 =?utf-8?B?bm41QjJ6eXVXT1psaXJSTmRIbzNvT2Y2Wm1ETEhwZE4yY05sOTBZMGc0aThz?=
 =?utf-8?B?eDM3QUNvYzZzekhkSXh6Y2tkOXRBWnZuQXloRkF6amd3YW1hd3pBd1NJVGFl?=
 =?utf-8?B?eDUzS08yTGF6WEU5MXAxSE9XQjhoWEl2NEx3ZVRtOFBaZGhwZVN6b2ZkbDRD?=
 =?utf-8?B?SjlBR1k1c0pqbENVVVpSc1JBQmVrUjBRa1lhUFExM3BhUUpvbG1jMXB0UWpv?=
 =?utf-8?B?UzVkODFuWTNKcnNRNGd0TTEycFFLVVpuQnYyc0NlQzhUY21sZkZNdWd5aERN?=
 =?utf-8?B?WnV0ZEx5QnlDQnZwNDNXM0FSZzBTWEtHZGFrZ0E5VGdZSzh2bTRnOEtDemJj?=
 =?utf-8?B?U3UvNXdaSDFMQmRWczVWQW1hbCtQWmtueFhzWXp1eDAza3JGbjhzYWszaHlP?=
 =?utf-8?B?NzJiS1Q1TWM1aTloQnVqbnBzUHdMbVdzTk4xSnVIL1RNd0thSHg4b1JsbU5u?=
 =?utf-8?B?Z2dKYjVwd1VMQ1dLalcxMThKTloyZ3pGdDJBNGN6Ukl5cU41OUQ1ZlpaQjJR?=
 =?utf-8?B?RksvMk1iblJtMHhxUFJoV2FrYkM3RHl3eDhGSVlNaHZkK2pCR0xVWll0NENG?=
 =?utf-8?B?UmxTazhTWDlqb0VGcTVsVlNSVi92Qmw4cU90YnA2d0ErTUg4S1g1UHVqYWY4?=
 =?utf-8?B?MVFLYUFtZFB4UTJScXN5OWtuc1AvTUJTZnJKZzlaSUVzM3A0WjNIOWd3Rmdy?=
 =?utf-8?B?Ujh4bzZFd0R1dXRZWDV2MTdheEtrU2JOcE1oVHZNRmRES3QxTHNPSU5pZVkx?=
 =?utf-8?B?QXR2R3dobjhMcytENkVDdUEwd0ZrNE9jTVFYZUxIbHZueGZLdUlXWEJ3TkVB?=
 =?utf-8?B?dXVUaERaT2hrYW8zUHEzMmpiL29xaWI0R3Rvd0ptRk0rRWQ2bDkwd0pCajFz?=
 =?utf-8?B?cXFiQzRwOFZDSmEvcllEdmdaVTFDT3NlUEVSbXE5RVBoSXdCUnFKVU02QTJN?=
 =?utf-8?Q?lUeRdtr3jLAqTxc/mKmQzyaL6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb7d67dd-e9f4-4a74-bab3-08da86362a8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 01:07:22.5812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dnbwF4cGK65wjXFxqn7rf8J02ypHlIoz3JGaz/7SpyJ6q3oWmClCfF1uczbTDaL6gbkSlQMYAJyT3F14CiO02A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0026
X-OriginatorOrg: intel.com
Received-SPF: pass (spool1: domain of intel.com designates 134.134.136.65 as permitted sender) client-ip=134.134.136.65; envelope-from=hongzhan.chen@intel.com; helo=mga03.intel.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=intel.com header.s=Intel header.b=QBVE2nrh;
	spf=pass (spool.mail.gandi.net: domain of hongzhan.chen@intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=hongzhan.chen@intel.com;
	dmarc=pass (policy=none) header.from=intel.com

DQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiA/Pz8oRG9uZ2pvbyBLaW0pID8/
Pz8/ID8/Pz8/PyA8ZG9uZ2pvbzUua2ltQGRvb3Nhbi5jb20+IA0KPlNlbnQ6IFRodXJzZGF5LCBB
dWd1c3QgMjUsIDIwMjIgNzo1MyBBTQ0KPlRvOiBDaGVuLCBIb25nemhhbiA8aG9uZ3poYW4uY2hl
bkBpbnRlbC5jb20+OyB4ZW5vbWFpQHhlbm9tYWkub3JnDQo+Q2M6ID8/PyhZb3VuZ2NodWwgUGFy
aykgPz8/Pz8gPz8/Pz8/IDx5b3VuZ2NodWwzLnBhcmtAZG9vc2FuLmNvbT47ID8/PyhLeXVuZ2hv
b24gUGFyaykgPz8/Pz8gPz8/Pz8/IDxreXVuZ2hvb24yLnBhcmtAZG9vc2FuLmNvbT47ID8/PyhT
ZWh5dW4gS2ltKSA/Pz8gPz8/Pz8/IDxzZWh5dW4yLmtpbUBkb29zYW4uY29tPjsgPz8/KERvbmdq
b28gS2ltKSA/Pz8/PyA/Pz8/Pz8gPGRvbmdqb281LmtpbUBkb29zYW4uY29tPg0KPlN1YmplY3Q6
IFJFOiBXaGF0IGNhdXNlcyB0aGUgbGF0ZW5jeSBvZiB0aGUgcnRfdGFza195aWVsZCgpIEFQST8N
Cj4NCj5EZWFyIFhlbm9tYWkub3JnLCBDaGVuLCBIb25nemhhbg0KPg0KPkknbSBkb25nIGpvby4N
Cj4NCj5UaGFuayB5b3UgZm9yIGNvbnRhY3RpbmcgdXMgcmVnYXJkaW5nIG91ciBxdWVzdGlvbi4N
Cj4NCj5XZSBhcmUgaW50ZXJlc3RpbmcgYWJvdXQgWGVub21haSBDb2JhbHQuDQo+QnV0LCBXZSBh
cmUgbm90IHVzZWQgdG8gYXBwbHkgWGVub21haSBDb2JhbHQuDQo+U28sIFdlIGhhdmUgc3R1ZGll
ZCBhYm91dCBYZW5vbWFpIENvYmFsdC4NCj4NCj4NCj5Db3VsZCB5b3UgZXhwbGFpbiBvdXIgcXVl
c3Rpb25zIGFib3V0IFhlbm9tYWkgQ29iYWx0IGFzIGxpa2UgYmVsb3c/DQo+DQo+SWYgeW91IHJl
cGx5IHRvIHVzIG91ciBxdWVzdGlvbnMsIEl0J3MgdmVyeSBoZWxwZnVsIHRvIHVuZGVyc3RhbmQg
YWJvdXQgWGVub21haSBDb2JhbHQuDQo+DQo+DQo+T3VyIGlzc3VlIGFib3V0IFhlbm9tYWkgMy4w
LjggKCBMaW51eCBrZXJuZWwgNC4xLjE4LCBpcGlwZS1jb3JlLTQuMS4xOC14ODYtOS5wYXRjaCAp
DQo+DQo+Tm9ybWFsIDogWGVub21haSAyLjYuNSAoIExpbnV4IGtlcm5lbCAzLjE0LjQ0LCBpcGlw
ZS1jb3JlLTMuMTQuNDQteDg2LTEyLnBhdGNoICkNCj4NCj4NCj5XaGlsZSAoIDEgKQ0KPnsNCj4g
ICAgICAgIEEgZnVuY3Rpb24gKCk7DQo+ICAgICAgICAtPiBBIGZ1bmN0aW9uIGlzIHByaW50ZWQg
ZXZlcnkgMjB1cyBieSB1c2luZyBydF9wcmludGYgZnVuY3Rpb24NCj4gICAgICAgIHJ0X3Rhc2tf
eWllbGQgKCkgOw0KPn0NCj4NCj4NCj5Jc3N1ZSA6IFhlbm9tYWkgMy4wLjggKCBMaW51eCBrZXJu
ZWwgNC4xLjE4LCBpcGlwZS1jb3JlLTQuMS4xOC14ODYtOS5wYXRjaCApDQo+DQo+V2hpbGUgKCAx
ICkNCj57DQo+ICAgICAgICBBIGZ1bmN0aW9uICgpOw0KPiAgICAgICAgLT4gQSBmdW5jdGlvbiBp
cyBwcmludGVkIGV2ZXJ5IDRtcyBieSB1c2luZyBydF9wcmludGYgZnVuY3Rpb24uDQo+ICAgICAg
ICBydF90YXNrX3lpZWxkICgpIDsNCj59DQo+DQo+DQo+MS4NCj5XaGF0IGlzIFhlbm9tYWkgQ29i
YWx0IEtlcm5lbCBhcyBsaWtlIGlwaXBlIHBhdGNoID8NCj4NCj5JZiB0aGUgc3lzdGVtIGNhbGwg
aXMgb2NjdXJyZWQgYnkgdGhlIHJ0X3Rhc2tfeWllbGQgZnVuY3Rpb24gaW4gdGhlIHVzZXIgc3Bh
Y2UsDQo+SXMgWGVub21haSBDb2JhbHQgS2VybmVsIHRvIHNjaGVkdWxlIGEgVGFzayB3aXRob3V0
IExpbnV4IGtlcm5lbCBzY2hlZHVsZXIgPw0KPklmIG5vdCwgSXMgWGVub21haSBDb2JhbHQgS2Vy
bmVsIHRvIHNjaGVkdWxlIGEgVGFzayB3aXRoIExpbnV4IGtlcm5lbCBzY2hlZHVsZXIgPw0KPg0K
PkknbSBjb25mdXNlZCB0aGUgYWN0aW9uIG9mICBYZW5vbWFpIENvYmFsdCBLZXJuZWwuDQo+SXMg
WGVub21haSBDb2JhbHQgS2VybmVsIGEgbmV3IFRhc2sgU2NoZWR1bGVyID8NCj5JZiBub3QsIERv
IFhlbm9tYWkgQ29iYWx0IEtlcm5lbCB1c2UgTGludXgga2VybmVsIHNjaGVkdWxlciA/DQoNCkNv
YmFsdCBjb3JlICsgTGludXgga2VybmVsIGNvcmUgPSBkdWFsIGNvcmUuIENvYmFsdCBrZXJuZWwg
IHJ1biBpbiBwcmltYXJ5IG1vZGUgYW5kIGhhcw0KSXQgb3duIHNjaGVkdWxlciBhbmQgaGFzIGhp
Z2hlciBwcmlvcml0eSB0aGFuIExpbnV4IGtlcm5lbCB3aGljaCBydW4gaW4gc2Vjb25kYXJ5IG1v
ZGUuDQoNCj4NCj5JZiB3ZSB1c2UgcnRfdGFza195aWVsZCBmdW5jdGlvbiBpbiB0aGUgdXNlciBz
cGFjZSBvciBzY2hlZF95aWVsZCBmdW5jdGlvbiBpbiB0aGUgdXNlciBzcGFjZSwNCj5XaGljaCBp
cyB0aGUgZGlmZmVyZW5jZSBrZXJuZWwgc3BhY2UncyBhY3Rpb24gYWZ0ZXIgc3lzdGVtIGNhbGwg
Pw0KDQpXaGVuIHlvdSBydW4gaW4gUmVhbHRpbWUgZG9tYWluLCBydF90YXNrX3lpZWxkIHdpbGwg
dHJhcCBpbnRvIGNvYmFsdCBjb3JlIHRocm91Z2ggY29iYWx0IEFCSSBkaWZmZXJlbnQgZnJvbSBM
aW51eCBjb21tb24gQUJJLg0KDQo+DQo+DQo+Mi4NCj5BcyBJIGtub3csIEZ0cmFjZSBpcyB1c2Vk
IHRvIGRlYnVnIGFib3V0IGxpbnV4IGtlcm5lbCBzY2hlZHVsZXIuDQo+RG8gdGhlIFhlbm9tYWkg
Q29iYWx0IGtlcm5lbCB0byB1c2UgRnRyYWNlIGZvciBkZWJ1Z2dpbmcgPw0KDQpZZXMuICBZb3Ug
Y2FuIGZpbmQgYWxsIGV2ZW50cyByZWxhdGVkIHRvIGNvYmFsdCBmcm9tIC9zeXMva2VybmVsL2Rl
YnVnL3RyYWNpbmcvZXZlbnRzL2NvYmFsdF8qDQoNCg0KPg0KPg0KPjMuDQo+Q291bGQgeW91IHNo
YXJlIHRvIHVzIHRoZSBmdW5jdGlvbiBpbiB0aGUga2VybmVsIHNwYWNlIGFmdGVyIHN5c3RlbSBj
YWxsIGlmIHdlIHVzZSBydF90YXNrX3lpZWxkIGluIHRoZSB1c2VyIHNwYWNlID8NCg0KSWYgeW91
IHJ1biBpbiBwcmltYXJ5IG1vZGUsIGl0IG1heSBjYWxsIENPQkFMVF9TWVNDQUxMKHNjaGVkX3lp
ZWxkLCBwcmltYXJ5LCAodm9pZCkpIGluIFNjaGVkLmMgKGtlcm5lbFxjb2JhbHRccG9zaXgpIG9m
IGNvYmFsdCwNCnlvdSBjYW4gdHJhY2UgY29iYWx0X3B0aHJlYWRfeWllbGQgZXZlbnQgaWYgeW91
IGVuYWJsZSBpdC4NCg0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQo+DQo+DQo+Rm9yIGV4YW1w
bGUsDQo+SXMgdGhlIHRoZSBmdW5jdGlvbiBpbiB0aGUga2VybmVsIHNwYWNlIGRpZmZlcmVuY2Ug
aWYgd2UgdXNlIF9fUlQgKCBydF90YXNrX3lpZWxkICkgaW4gdGhlIHVzZXIgc3BhY2Ugb3IgX1NU
RCAoIG5hdGl2ZSB0YXNrX3lpZWxkICkgaW4gdGhlIHVzZXIgc3BhY2UgPw0KDQoNCj4NCj4NCj4j
ZGVmaW5lIENPQkFMVF9ERUNMKFQsIFApICAgICAgIFwNCj4gICAgICAgIF9fdHlwZW9mX18oVCkg
X19SVChQKTsgIFwNCj4gICAgICAgIF9fdHlwZW9mX18oVCkgX19TVEQoUCk7Lw0KPiAgICAgICAg
X190eXBlb2ZfXyhUKSBfX1dSQVAoUCkNCj4NCj4NCj5UaGFua3MuDQo+DQo+LS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiA/Pz8oU2VoeXVuIEtpbSkgPz8/ID8/Pz8/PyA8c2VoeXVu
Mi5raW1AZG9vc2FuLmNvbT4NCj5TZW50OiBXZWRuZXNkYXksIEF1Z3VzdCAyNCwgMjAyMiA2OjE0
IFBNDQo+VG86IENoZW4sIEhvbmd6aGFuIDxob25nemhhbi5jaGVuQGludGVsLmNvbT47IHhlbm9t
YWlAeGVub21haS5vcmcNCj5DYzogPz8/KERvbmdqb28gS2ltKSA/Pz8/PyA/Pz8/Pz8gPGRvbmdq
b281LmtpbUBkb29zYW4uY29tPg0KPlN1YmplY3Q6IFJFOiBXaGF0IGNhdXNlcyB0aGUgbGF0ZW5j
eSBvZiB0aGUgcnRfdGFza195aWVsZCgpIEFQST8NCj4NCj4NCj5JZiBydF90YXNrX3lpZWxkKCkg
d29ya3Mgbm9ybWFsbHksIHdoYXQgaXMgdGhlIGRlbGF5IHRpbWU/DQo+DQo+DQo+DQo+DQo+DQo+
RnJvbTogQ2hlbiwgSG9uZ3poYW4gPGhvbmd6aGFuLmNoZW5AaW50ZWwuY29tPg0KPlNlbnQ6IFR1
ZXNkYXksIEF1Z3VzdCAyMywgMjAyMiA5OjUxIEFNDQo+VG86ID8/PyhTZWh5dW4gS2ltKSA/Pz8g
Pz8/Pz8/IDxzZWh5dW4yLmtpbUBkb29zYW4uY29tPjsgeGVub21haUB4ZW5vbWFpLm9yZw0KPkNj
OiA/Pz8oRG9uZ2pvbyBLaW0pID8/Pz8/ID8/Pz8/PyA8ZG9uZ2pvbzUua2ltQGRvb3Nhbi5jb20+
DQo+U3ViamVjdDogUkU6IFdoYXQgY2F1c2VzIHRoZSBsYXRlbmN5IG9mIHRoZSBydF90YXNrX3lp
ZWxkKCkgQVBJPw0KPg0KPj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj5Gcm9tOiA/Pz8o
U2VoeXVuIEtpbSkgPz8/ID8/Pz8/PyBtYWlsdG86c2VoeXVuMi5raW1AZG9vc2FuLmNvbQ0KPj5T
ZW50OiBUdWVzZGF5LCBBdWd1c3QgMjMsIDIwMjIgODoxMSBBTQ0KPj5UbzogbWFpbHRvOnhlbm9t
YWlAeGVub21haS5vcmcNCj4+Q2M6ID8/PyhEb25nam9vIEtpbSkgPz8/Pz8gPz8/Pz8/IG1haWx0
bzpkb25nam9vNS5raW1AZG9vc2FuLmNvbQ0KPj5TdWJqZWN0OiBXaGF0IGNhdXNlcyB0aGUgbGF0
ZW5jeSBvZiB0aGUgcnRfdGFza195aWVsZCgpIEFQST8NCj4+DQo+Pg0KPj5DdXJyZW50bHksIEkg
YW0gdXNpbmcgeGVub21haSAyLjYuNSB2ZXJzaW9uIGFuZCBhbSB3b3JraW5nIG9uIGNoYW5naW5n
IGl0IHRvIDMuMC44IHZlcnNpb24uDQo+Pg0KPj5XaGVuIHVzaW5nIHZlcnNpb24gMy4wLjgsIHRo
ZXJlIGlzIGEgZGVsYXkgb2YgYWJvdXQgNG1zIHdoZW4gdXNpbmcNCj4+cnRfdGFza195aWVsZCgp
DQo+Pg0KPj5BZnRlciBjcmVhdGluZyBhbmQgc3RhcnRpbmcgbXVsdGlwbGUgdGFza3MsIHJ0X3Rh
c2tfeWllbGQoKSBpcyBzdGlsbCBydW5uaW5nIG9uIGFsbCB0YXNrcy4NCj4+DQo+PlRoaXMgaXMg
YSBwcm9ibGVtIHRoYXQgZGlkIG5vdCBvY2N1ciBpbiB0aGUgMi42LjUgdmVyc2lvbi4NCj4+DQo+
PklzIHRoZXJlIGFueXRoaW5nIEkgbmVlZCB0byBzZXQgaW4gdmVyc2lvbiAzLjAuOD8NCj4+SWYg
bm90LCBpcyBpdCBhIGtlcm5lbCB2ZXJzaW9uIGlzc3VlPyAoVGhlIGN1cnJlbnQga2VybmVsIHZl
cnNpb24gaXMNCj4+NC4xLjE4LikgSWYgbm90LCBpcyB0aGVyZSBhbiBBUEkgdGhhdCBjYW4gcmVw
bGFjZSBydF90YXNrX3lpZWxkKCkgPw0KPg0KPkkgc3VnZ2VzdCB5b3UgbWF5IG1ha2UgdXNlIG9m
ICBmdHJhY2UgIGFuZCBlbmFibGUgZW5vdWdoIGV2ZW50cyBmb3IgZXhhbXBsZSBzY2hlZCBldmVu
dHMgdG8gY2hlY2sgd2hhdCB0aGUgZGlmZmVyZW5jZSBoYXBwZW4gYmV0d2VlbiB0aGVzZSB0d28g
Y2FzZXMgaW4gY29iYWx0IGNvcmUgYW5kIGhlbHAgbmFycm93IGRvd24gdGhlIGlzc3VlLiAgSSBk
byBub3Qga25vdyB3aGF0IGNvZGUgZGlmZmVyZW5jZSBtYXkgY2F1c2Ugc3VjaCBpc3N1ZS4NCj4N
Cj5SZWdhcmRzDQo+DQo+SG9uZ3poYW4gQ2hlbg0KPj4NCj4+DQo+Pi0gcHJldmlvdXMgdmVyc2lv
bg0KPj4NCj4+WHVidW50dSA6IFh1YnVudHUtMTcuMTAuMQ0KPj4NCj4+TGludXgga2VybmVsIDog
TGludXgtMy4xNC40NA0KPj4NCj4+WGVub21haSA6IFhlbm9tYWktMi42LjUNCj4+DQo+Plhlbm9t
YWkgSXBpcGUgOiBpcGlwZS1jb3JlLTMuMTQuNDQteDg2LTEyLnBhdGNoDQo+Pg0KPj4NCj4+DQo+
Pi0gY3VycmVudCB2ZXJzaW9uDQo+Pg0KPj5YdWJ1bnR1IDogWHVidW50dSAxOC4wNCBMVFMNCj4+
DQo+PkxpbnV4IGtlcm5lbCA6IExpbnV4IGtlcm5lbCA0LjEuMTgNCj4+DQo+Plhlbm9tYWkgOiBY
ZW5vbWFpLTMuMC44DQo+Pg0KPj5YZW5vbWFpIElwaXBlIDogaXBpcGUtY29yZS00LjEuMTgteDg2
LTcucGF0Y2gNCj4+DQo+Pg0KPj5Mb29rIGZvcndhcmQgdG8gaGVhcmluZyBmcm9tIHlvdS4NCj4+
QmVzdCByZWdhcmRzLg0KPj4NCj4+DQo+Pg0KPj4NCj4+DQo+Pg0KPj5TRSBIWVVOIEtJTQ0KPj5S
ZXNlYXJjaGVyLCBSJkQgQ2VudGVyIENvbnRyb2wgRnJhbWV3b3JrIFRlYW0NCj4+DQo+PkVtYWls
IDogbWFpbHRvOnNlaHl1bjIua2ltQGRvb3Nhbi5jb20NCj4+V2ViIDoNCj4+aHR0cDovL3NlY3Vy
ZS13ZWIuY2lzY28uY29tLzFjSnNvOThnel9obkdaR01QRUFRTjBsaVNabkRVUk5vcHY0WjFFbkN5
QXkNCj4+Wk5NQUs3MnBHN25fMkVOSUVNQlF0ODZvZ3JqWkQ0V3J2TkRNWXpsb190a2hHLTdTNldy
LWFTay03QWRPTV9UdkM4dEVEd2YNCj4+emhybmRLX015MGQ4bHp5QnpIM1YyT2xMRXNtR2ZvcWwz
TWd0MEJWN054WjZWb2Z5SFZWWWs1SDhCaDVIeWF2YUQwbkJBQnENCj4+N1ZTSzBiaW1sQTJCWW5w
YUxDanVKQUJDdHFfcmcwZGp3VmY4bmZPTFA3bmlyd0RldlBIT1NTSGp5UDNFTU5xb1hXZ255dXoN
Cj4+MGs5YWFNaF95UnFNaHUwRVJUZ3k4SXBuOVMxdjR3akxtODBFSFY0b1VIaDlFSVFpX0V6Nzlm
dkFEMUZ1N25kNjIvaHR0cCUNCj4+M0ElMkYlMkZ3d3cuZG9vc2Fucm9ib3RpY3MuY29tDQo+DQo+
DQo+VGhpcyBlLW1haWwgYW5kIGFueSBhdHRhY2htZW50cyBoZXJlaW4gbWF5IGNvbnRhaW4gY29u
ZmlkZW50aWFsIG9yIHByaXZpbGVnZWQgaW5mb3JtYXRpb24gYW5kIGlzIGZvciB0aGUgZXhjbHVz
aXZlIHVzZSBvZiB0aGUgaW50ZW5kZWQgcmVjaXBpZW50KHMpIG5hbWVkIGFib3ZlLiBJZiB5b3Ug
YXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50KHMpLCB5b3Ugc2hvdWxkIG5vdCBkaXNzZW1p
bmF0ZSwgZGlzdHJpYnV0ZSwgcmV0YWluLCBjb3B5IG9yIG90aGVyd2lzZSB1c2UgYW55IGluZm9y
bWF0aW9uIGNvbnRhaW5lZCBoZXJlaW4uIElmIHlvdSBoYXZlIHJlY2VpdmVkIHRoaXMgZS1tYWls
IGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgYnkgcmVwbHlp
bmcgdG8gdGhpcyBtZXNzYWdlIGFuZCBkZWxldGUgdGhpcyBlLW1haWwgYW5kIGFzc29jaWF0ZWQg
YXR0YWNobWVudHMuIE91ciBjb21wYW55IGRvZXMgbm90IGd1YXJhbnRlZSB0aGlzIGUtbWFpbCBp
cyBzZWN1cmUgb3IgZnJlZSBmcm9tIHZpcnVzZXMuDQo+PyA/Pz8gPyA/Pz8/PyA/Pz8gPz8/ID8/
Pz8/ID8gPz8/ID8/Pz8gPz8gPz8/ID8/Pz8/PyA/Pz8gPz8/PyA/Pz8/Pz8/ID8/PyA/Pz8/ID8/
Pz8gPz8/ID8/LCA/PywgPz8/ID8/ID8/ID8/Pz8gPz8gPz8/ID8gPz8/LCA/ID8/PyA/Pz8gPz8/
PyA/Pz8/ID8/PyA/Pz8gPz8/ID8/PyA/Pz8gPz8/ID8/ID8/Pz8gPz8gPz8/Py4gPz8gPz8/PyA/
Pz8/ID8/ID8/Pz8/ID8/Pz8gPz8/PyA/ID8/Pz8gPz8/ID8/Pz8uID8/PyA/PyA/Pz8/Lg0K
