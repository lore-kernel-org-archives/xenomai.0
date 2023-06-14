Received: from redirect.mail.gandi.net (relay14.mail.gandi.net [217.70.178.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56BF7F
	for <xenomai@lists.linux.dev>; Wed, 14 Jun 2023 08:16:27 +0000 (UTC)
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay14.mail.gandi.net (Postfix) with ESMTPS id A97001A0006
	for <xenomai@lists.linux.dev>; Wed, 14 Jun 2023 08:16:19 +0000 (UTC)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	by spool.mail.gandi.net (Postfix) with ESMTPS id D93917803D8
	for <xenomai@xenomai.org>; Wed, 14 Jun 2023 08:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686730578; x=1718266578;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FHEOCSFX/cNWIlJM2P7ypNa3TE4KwKM8gMWalPxtFAQ=;
  b=XhF+k0coNUM1MxbkO2PtlqR0rM4+biSdZkLAOVQrz0vt5yId4o1N7iCQ
   Mc10LxoeuC1jF8c0U0SotNquSZ4KWTl2m8hlqKTSdMXxblq9vGsRvj1Gi
   bBzN7XflpSIQFWOMpRTricJl3Uy23QYP3l/jS1jwnqMyUpPdjJeHPfRjp
   e1tp+hKy/0U8QzRxvexwfscdx9c4oLc2TE6KRz3TENC1pP9s0KLh1f+fs
   +Oj0IotuWMhzqMV9GjD0uteMQbd2EJMvcFKtyBGpepm7ZPvOAtCVqQdNx
   zKscKaE/90Q48H5xxxOVRceA2GsRY/n571DXqWrHvgrLOYxH5+5aMrXdl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="343249315"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="343249315"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 01:16:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="706130530"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="706130530"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 14 Jun 2023 01:16:04 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 01:15:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 01:15:55 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 14 Jun 2023 01:15:55 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 14 Jun 2023 01:15:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDUzWT9ANCCIE5blKzhRlB4TcUCWKTzRxwcT9tPkWVb1geKKNt24uN7XAkFGTv76MBa+lHoV7BnEvDYL4+/B7F8xKPI4DksOboibed3UkARRIwhljFJkgyKQAaq2mQsUdk/1Tlhni/fGhFQcmirAr1spaUDQKfk7lP/KVLtVjgTApLNJNudRvYG6pb00wIglPghPlNQ6Qo+/TQYuW5tgSBc3kAQ17eWa2UU1XTDQfofLFrNpVlq1UE9wtCNanL/z2IRNwpBXZNE9EOA+rI5i0IDDp79rfwk3PqVaQrM0oPzPLfNq5maLSoDqTmr3Qwt3d1mdzoKVlgvLCEuOO009rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHEOCSFX/cNWIlJM2P7ypNa3TE4KwKM8gMWalPxtFAQ=;
 b=Ww5dzTd6XXeeSFlSjH+D0SaF1AAn0kJF4Xt4m3Dly5+qjqXXX/YC4WOnR5GggmFDqHvISjBK5pDGotjJhKyuIKHFAoZjEldO0uvgBh5RPUfEYbHhZET8KE1PvIHJgTXrb4LVX41v5xCOKBXei/+Jid3qED5s8BSQanLJTi62d6ZkKUqwcF4n/QVEav+LFUfy/UCpZ/QHZHGCQ2URWTSqwNS1QIVbtfdRUPHShy1wf8AH/phiqlKWr8qLeCaSq/rzOiGvuSE4P0GS/1Fl7eizUn7m5D+lH5/lQuD1Pwa1PDGVvKfAtjF5DT82A8yC04QI6PlN4QR8sqrNQA+QmmVumg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by CY5PR11MB6114.namprd11.prod.outlook.com (2603:10b6:930:2d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Wed, 14 Jun
 2023 08:15:50 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::56a8:e9c:284:f6a8]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::56a8:e9c:284:f6a8%7]) with mapi id 15.20.6477.028; Wed, 14 Jun 2023
 08:15:50 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: Richard Weinberger <richard@nod.at>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
CC: xenomai <xenomai@xenomai.org>
Subject: RE: Massive variations of execution time on x86
Thread-Topic: Massive variations of execution time on x86
Thread-Index: ecxCFjAboALDcvYMCoVCc8urSYAceJq2B3qAAAFT3oAAPwLOgAAfSPhw
Date: Wed, 14 Jun 2023 08:15:49 +0000
Message-ID: <MN2PR11MB42852073A335361100FF8948F25AA@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <321584983.3714817.1686565517697.JavaMail.zimbra@nod.at>
 <dd6b33a8-f53c-8c51-a30d-2688ddac1709@siemens.com>
 <1832934245.3714909.1686568547516.JavaMail.zimbra@nod.at>
 <14248715.5206787.1686676799496.JavaMail.zimbra@nod.at>
In-Reply-To: <14248715.5206787.1686676799496.JavaMail.zimbra@nod.at>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|CY5PR11MB6114:EE_
x-ms-office365-filtering-correlation-id: f9ef905f-c870-4239-1bae-08db6caf9021
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hYcLq9fGeXhAhqeSchXZnsYrwiYLGYseQv0S35tUdzMvjmE3e4LzWJJK17i72gIqX/coeEZE4xzGxgbZyvioRlJaI+JEtwvZ1bFhFzzmXsuC6GifJnr2lzL/XTJFFhoA2MLt474C9/RBvWPURb7O6hRVY0xJc+O3YlqddK/e2LSnhJaL9zT7vrMYNvlXV+w23ToOYcM0/SUZQasXyC08S4PzBZ3lvBLvMQ5GtrOpvyBjKYJ9Qy2IQ765rbnaT4v8RgMkVrR+N3wmYtI2e9p3zT4OXiy5b9QEQOaQ+K27eo0Iz1IhGFEhHUeMx9vadHrGeeFTFqxOxOdnPN/0SkVTcemKlOZ6hP544Y/EsmOSruIfeJQeKS/8wEvnQP46lxA1m8iyMpPN3rQKql6qYoHMahi6LHcpRWtm681HjufVZRw/Tp1gKCymidHeHX2d9t6tglgjxYctoZueHgju52in3o+umg3QOFX7b02h9qNEDSH8GHnhnb2qkmzi+ji/gjPhFy9hXN72xcW+9g8XrhUQUgnMpPMzGEIRDvLdrmfFD8sjOzYH68SlHrRRx0pVb69VipdvCdxT+p6RRMG9Jm6WLZfXOluqDV80FxCz+kXVJlPu8LaZXbvWmshk4iIYQLzP6gnva0qkkHOyVxzMR0odCw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(346002)(136003)(376002)(396003)(451199021)(76116006)(2906002)(66476007)(64756008)(66446008)(66574015)(83380400001)(52536014)(5660300002)(8936002)(316002)(8676002)(66556008)(71200400001)(33656002)(122000001)(478600001)(41300700001)(110136005)(66946007)(55016003)(7696005)(82960400001)(86362001)(186003)(9686003)(6506007)(38100700002)(4326008)(26005)(38070700005)(14583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkFlZHY1VnUvd2JDWGtGdWZRT1NOZ0F2MThBU1VaK1R5emN3dXlYS1pnNDlS?=
 =?utf-8?B?dWVQR0lEQTFsbUJtMGRxK0Y2ZWpGL1Q2RENiSjdzMHhlbU9tR0JWTC9FUkNN?=
 =?utf-8?B?Uy80emxxMGRWb3dJMldHNUpRdTlYamh1d1FUeTl4dzh4SlMyVk0waDlDSC9U?=
 =?utf-8?B?VUVhYTU5U09RR0R2NzBqR2hsV2dGTVlGQlJHVWZHY0FNMnNHSG5jQVhBWTFV?=
 =?utf-8?B?V2dUZUpDY0ZMOHdhalRvVktRWS94Y2FHRjE3MjdkcHNONmZQRGV4TUx1ZUM2?=
 =?utf-8?B?K2wxcXFPUnhOTnJOV09nTjJSUXQ4dDR0bHlRODhBcjBIR2R3SHcwcDAxeXpo?=
 =?utf-8?B?QXh1ZXhIcXk0eFY2bVQ2UGRDMmkxZ2pTN0d2M0xMc2gzZUdLMlFZMkpFczYv?=
 =?utf-8?B?RHNuaFRSWEhSdWR3OXloTEVJYWtyWkxTZmIranFVYjdjenYvV1NEajNqSlhL?=
 =?utf-8?B?L2FUTW5HQjVCdlJ2OHB0QTZDRnQzTzhUT3Jtcyt2YXZtaFhwd3FjS2pxTTZR?=
 =?utf-8?B?TmYxUTY3TC96aEJwQ0NtVU9FUlJoZFlYRHcvV29oczZuNEd5TUp0bnN0OUNB?=
 =?utf-8?B?Zy93Z0xXem5ob1FNNEVuQ2dyNVYveUl4eFhtYjVMUU1MRnNRcElCUXh6RG8x?=
 =?utf-8?B?eHRlZjlGSys2Nm51RVFyNEsxTzRTcUt2VGdScThtSzN0Q25XZURLT1ZlV1Vs?=
 =?utf-8?B?ODdUZE5pUWRMWHdpNlRxazFObXR0LzR0eVFZODIzY2QzUkM5cGFSQ01vTDdp?=
 =?utf-8?B?NTZ1WHpyU0ZXdDdoWVlpUVRLVTdKUmFjZ3Z4eFh4NnNpb2g1WmZnV3crL3hz?=
 =?utf-8?B?aEs1TEY5ZUJjRmM4WnZxRkVMUkdRVTVaY0N0OXo4NHlSSkFOcmQ5T3ZGK3FF?=
 =?utf-8?B?QXJkM1I2QjV2Y0I0Zk5GWnBTOWwwQkZyR1MzNGZTYkd2TmNsaVF5UGo1WUlE?=
 =?utf-8?B?VE4rSDV0ak5ydXlQRVZsbVprTFBselpFUWZ5QlhIcGZ0a0dPdTBvdXZXemxj?=
 =?utf-8?B?MkJJSUVKOEhsMkRvM0VlR0tMT2pLTUJrTXh6SVd4aFZZcS9EL05PZ0EyUXpS?=
 =?utf-8?B?SEV3d2lnWjBLSlZwS1duYkZ5VWhlY3VodVlWbnltdnlrTzc5bmUxazRzQTVI?=
 =?utf-8?B?TVZIRW5jQXZNRWVrWnZxUXQ0aFBiT1N4ZkdHUnl5NDRiakFDUEs5R1hUUm5i?=
 =?utf-8?B?Y3dXMTM5VHFuRDVndTltcVRoaUltbUJpYldMeHFaVWQ0dnBNY0l5cXM4S2FJ?=
 =?utf-8?B?ZlFENG9MMTZSS1owT2pEZzhCLzFUVkNWeFdIUUY0Y3pVSEhqeXU1RXQ3cnZT?=
 =?utf-8?B?Yi9yUERiYmFkbmVDeEJKTFpNcmxmZmhjRkxPR25kNThzYUlQeXBEdk5NWDY5?=
 =?utf-8?B?OXkxWkd2azVRYU16VUdQdSt4cVhSQVg2Z1lpRFZoQ2FneTR4czh1a1BEY2xv?=
 =?utf-8?B?NTNkTlp0NlFmRUxMMHNNamY4aThObkJMVjRNNlk0TVpZT3dKSzd6YXU1OFJu?=
 =?utf-8?B?RFhOeXhlblpraGJRSmRhUkhma2RtSjFvS0FjbitpbS9TUTNPWHJNbWdXZlV2?=
 =?utf-8?B?R09iazN4cHRjaktWc1c5dXo0U1gySzM1alRyVFQzeSt2YWV0QVIrZm85bFFq?=
 =?utf-8?B?ZzY0U2lSZWc5cjIwUENwSDhnVVQ0YzRpbWNPWXkyOTBrZEtyQWduaGFGSFRK?=
 =?utf-8?B?d3ZRS3BQMEY3Q3FXT1pET1EyWVFtOUhzU2E5VTBNQWNHcVNjd0hoNkhhek1k?=
 =?utf-8?B?WXZIOFg1RHBsdkhhVlk3TlIxbUQ1WU1YS3phaklVdmNwK1Z1WlhvUDhXMWZs?=
 =?utf-8?B?ZmQvUks0ZHFJTkttWmNSdXpBVHZXOENPYnN1dkU5NEpVK1FoaGtKMzBMVlcw?=
 =?utf-8?B?OVkyaURqNHdXYS9oMEpDZTZ1MXN3TVRJbnRXMERiclpuWkNZTEVjdjlSQ2xa?=
 =?utf-8?B?YjNSUVplMnJkQ0hrVlFiRmc1R2QrcnJFOHhUNFBrWmFoTkYyRnVwNVB1WlZC?=
 =?utf-8?B?MDZyT1Buc3IrSzZXRSthSUEwenU3YmhtamVWdlNSa3BIWmRFcnFiNkxpOHE1?=
 =?utf-8?B?aHFDc2I3WEdJWFowSzE5MUxwSlFPcXY4WkQvTzZYZDUwWHZxWS95VVRjSXN5?=
 =?utf-8?Q?khD8lBua3T0slvS9NZoHae7k7?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f9ef905f-c870-4239-1bae-08db6caf9021
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 08:15:49.5614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aQU7MN0dJycdXeYpmHEVzPJWEjGmNxSUvcZnMWHT8ytnx6c5gUnSbEz8TSc9sHEYuI+CcpPgqPY27WW19kmjew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6114
X-OriginatorOrg: intel.com
Received-SPF: pass (spool4: domain of intel.com designates 134.134.136.126 as permitted sender) client-ip=134.134.136.126; envelope-from=hongzhan.chen@intel.com; helo=mga18.intel.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=intel.com header.s=Intel header.b=XhF+k0co;
	arc=pass ("microsoft.com:s=arcselector9901:i=1");
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (spool.mail.gandi.net: domain of hongzhan.chen@intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=hongzhan.chen@intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFJpY2hhcmQgV2VpbmJlcmdl
ciA8cmljaGFyZEBub2QuYXQ+DQo+U2VudDogV2VkbmVzZGF5LCBKdW5lIDE0LCAyMDIzIDE6MjAg
QU0NCj5UbzogS2lzemthLCBKYW4gPGphbi5raXN6a2FAc2llbWVucy5jb20+DQo+Q2M6IHhlbm9t
YWkgPHhlbm9tYWlAeGVub21haS5vcmc+DQo+U3ViamVjdDogUmU6IE1hc3NpdmUgdmFyaWF0aW9u
cyBvZiBleGVjdXRpb24gdGltZSBvbiB4ODYNCj4NCj4tLS0tLSBVcnNwcsO8bmdsaWNoZSBNYWls
IC0tLS0tDQo+PiBWb246ICJyaWNoYXJkIiA8cmljaGFyZEBub2QuYXQ+DQo+PiBBbjogIkphbiBL
aXN6a2EiIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPj4gSXQgaXMgcGFzc2l2ZSBjb29sZWQg
YnV0IGFjY29yZGluZyB0byBoYXJkd2FyZSBlbmdpbmVlcnMsIHRoZSB0ZW1wZXJhdHVyZSBpcw0K
Pj4gbm90IGV2ZW4gY2xvc2UgdG8gYSBsaW1pdC4NCj4+DQo+PiBJcyBjb21wYXJpbmcgL3N5cy9k
ZXZpY2VzL3N5c3RlbS9jcHUvY3B1WC9jcHVmcmVxL3NjYWxpbmdfY3VyX2ZyZXEgYW5kDQo+PiBz
Y2FsaW5nX21heF9mcmVxIHRoZSBjb3JyZWN0IHdheSB0byBkZXRlY3QgdGhyb3R0bGluZz8NCj4+
DQo+Pj4gQWxzbywgZG8geW91IHNlZSBzaW1pbGFyIHZhcmlhdGlvbnMgd2l0aCBzaW1pbGFyIHZh
cmlhdGlvbnMgb24gdGhlIHNhbWUNCj4+PiBoYXJkd2FyZSB3aXRoIHByZWVtcHQtcnQgKHByb3Zp
ZGVkIGF0IGxlYXN0IHlvdXIgc3ludGhldGljIHRlc3RzIGFyZQ0KPj4+IHBvcnRhYmxlKT8NCj4+
DQo+PiBJIHRoaW5rIEkgY2FuIGRvIHRoaXMuIEJ1dCBtaWdodCBuZWVkIHNvbWUgdGltZS4NCj4N
Cj5JIGNhbiBjb25maXJtIHRoYXQgdGhlIHZhcmlhdGlvbnMgYXJlIGFsc28gb2JzZXJ2YWJsZSB3
aXRob3V0DQo+WGVub21haS9Eb3ZldGFpbC4NCg0KU01JIHByb2Nlc3NpbmcgY2FuIGxhc3QgZm9y
IGh1bmRyZWRzIG9mIG1pY3Jvc2Vjb25kcyBkZXBlbmRpbmcgb24gc3lzdGVtLg0KSSBrbm93IHRo
YXQgaXQgIGFyZSBhbGwgZGlzYWJsZWQgYWNjb3JkaW5nIHRvIHlvdXIgaGFyZHdhcmUgdmVuZG9y
LiBJIGRvIG5vdCBrbm93IGlmIGl0IGlzIHdvcnRoDQpkb3VibGUgY29uZmlybWluZyB0aGUgdmFs
dWUgdGhyb3VnaCByZG1zciAweDM0IHJlYWxseSBkb2VzIG5vdCBpbmNyZWFzZSB3aGVuIGlzc3Vl
IGhhcHBlbg0KYnV0IHdlIGhhdmUgbm8gaWRlYSBhYm91dCB0aGUgcm9vdCBjYXVzZS4NCg0KUmVn
YXJkcw0KDQpIb25nemhhbiBDaGVuDQoNCj5UaGFua3MsDQo+Ly9yaWNoYXJkDQoNCg==
