Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A77628
	for <xenomai@lists.linux.dev>; Thu,  9 Mar 2023 01:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678326466; x=1709862466;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=2Zi5G1yZK2VE8imInsH+P+ADC9ODE0qwJHEPb4FUwms=;
  b=XDaI6tMcYunRKe4V0dMsP9WYDLm4P2LnPrnxefZ8hqrrvC8r/ecvhgMH
   S6KbTmwfgCWnGi/3iioAvuXK5pRDWK6KNCvrSOcTFZACmUlMQ1fRnL2xT
   wACGrNf5QTiPpzSPqdp2hLQJQzpB0P32ERIaYgt5ftQJa9R0CuUpHi4e+
   ABUmzs7wELNquhTw2AQr8LOa4PpasXdTuyCzW/rEBldqNCPFis7qXfzNo
   BnmwLwJuAl8CvPnpyy0ocGR4qDVHsZnCfGfJS260GBG9uZyWp9YgMqOyJ
   HVq0n8pkGmM9y3hugIJieT9qhq2OXN7k4tgP1w5fL1oAf8N7cE4d/drKQ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="422600344"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="422600344"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 17:47:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="787368469"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="787368469"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 08 Mar 2023 17:47:45 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 8 Mar 2023 17:47:44 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 8 Mar 2023 17:47:44 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 8 Mar 2023 17:47:44 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 8 Mar 2023 17:47:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPiD/OUzlWl9+0cuP2M2WCR96Qczutb3B7VZp1Vsv14zaY0TOEC16LH9nsa7itBmSxkipMZwEKKqVp0n7gbhUHQOFjDONrVQvWCuVp4QW4c0JcbxaXYKTLuRP5eQjXz9ivsfabYdd4cJep+4q6Qn1dO/CorSUp3pR1Y+TzTmG7tleYWoYgbmhD601NTp6581jQdmNgHGCaKY30VfEkKxx04FlTaSVWMyE7BEM4JnOilphjMFeUdBwgw3F8vVZkCwBitenpyM6mP0yEo+a/ac00SC0guo2+t/C3OJdaxhpeuEBno0GNujqvtd8yK+Pk5vIvij5C8tpKMtUctBXl487w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Zi5G1yZK2VE8imInsH+P+ADC9ODE0qwJHEPb4FUwms=;
 b=flx+mhyuM+8ABde/l5CJg/Y2rQ2/MLVejsSg4X3Peo+ULsritsijhqK1LSRgKWs7HKV1qoOlSgNQKt9ddr6r07kM1U4eB2hQqxxSbgvfCcEOGSS/tjNYzCZ2bYHB6jhoCEmtjJb/TVdgktQLT3khkcSQJJtaMO6dqELCbqE50G6zp5ijKReQlz6RFfnUAjOep2anaObkT2TFy+9GBNDXh5xW0i1Cq5YsdmVabn+SVcKfgyRNb912g3KZ9q59rTPEZQ1Gh0ujgEzYEE+RWU6OAWP+AEgH4ygcr/z5S+fw5ozT4lGpgzj4p8zDtZWEk+QtWAnaHtsZfrGXn46qNgWYlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by BN9PR11MB5435.namprd11.prod.outlook.com (2603:10b6:408:100::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Thu, 9 Mar
 2023 01:47:37 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::e1b2:52d4:e80c:dfac]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::e1b2:52d4:e80c:dfac%7]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 01:47:37 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Xenomai Community Call Minutes - Mar 8, 2023
Thread-Topic: Xenomai Community Call Minutes - Mar 8, 2023
Thread-Index: AdlSKJFXvd/I2WS/SXC7kLSUONFASw==
Date: Thu, 9 Mar 2023 01:47:36 +0000
Message-ID: <MN2PR11MB4285B6057B958686CE47E3ECF2B59@MN2PR11MB4285.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|BN9PR11MB5435:EE_
x-ms-office365-filtering-correlation-id: 8521d69b-7aa9-4dac-7744-08db20404294
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: epUfs6fgqiWnSSy5/Kaj5WJaA4p87pRgdUPFRgaF0CU48/K9aMgwQunA3CgeI+khOl34fkz3C6ASm/BtDNdopHI5G/HA+b96uwkzgucCcB+4Z1rWPRFjSxqdgw/j36J/8Ryxd+248tJjkHZxSZ2GHTmwdlrmAU9VIiMLEKkO/hEqP14s1T9uLCvvrvfAgHTDMql98zdtSZQy7+3PJzoNmBToUIHiFYL/SLl1U18RVwvHpswRcCmhPzfWUp2GKcZTNJYaO084y1K40JnUN2KC3vsI8Et/VyVXrwpSOt+xT34Gj+3GfSsAB5x3lD3yxQcmwV/25GyeW476IK3f6CtFHOW/gfTZz5nNHamHZGDA7esW8M9hPFaYTtjhQRlPXZTNANFYG8lkp2IXIugEegeDxnF0tJDDhNBYghwYTP8JY/RnS+vyL8fPYwmtWVikC1rSS81a4LxjVrs5fFEmOWKIle8HqNTPFmDsc7bbamSfXNNZS6PFAOaaIgTnzkc0ZS7FFLfy8XOHYMbQpm0uOHceL5SR/dvPndq3xYFInb0JAdd++Pq5rHVGYWbPcA9yW6sh1zjXzcBqRd/GeETl4lb9qnluarE7MK/rimQhz+qECO4eAHbSvfUzUnf/7KqyZwzqcsLCoYRLxLAha0H/NGJVXy4RC9CPVIqTpQGJeAT9FYXEl6jWEaVbFKfQwMzEAOKTK6GMnIzl0B17qLKuIwmCXA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199018)(2906002)(38070700005)(5660300002)(66946007)(26005)(4744005)(8936002)(52536014)(66446008)(76116006)(64756008)(33656002)(8676002)(41300700001)(6916009)(86362001)(66556008)(316002)(7696005)(478600001)(71200400001)(82960400001)(122000001)(66476007)(38100700002)(55016003)(9686003)(6506007)(186003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWhkM0dsWFloV1pxMkozT2VZVXkvdmxLdnV1L1dtS0dTZllzeXBBTWNHM0tw?=
 =?utf-8?B?K21rcEVUN2doVDEvQlcrcFpxc0JxS09xS1FlYVZTRktvbloyVDZLR1pYTURW?=
 =?utf-8?B?eVNIVnV6TU1TRTh2bnhGUllhNmhmVmZscmg0aVZhcFFJOFJyU2E5SVh2V1lH?=
 =?utf-8?B?N05lamZsbExCb1VFdTVkUjZjRXFaYVhnZTVqV3c5UkRHa1ZmYUg1aURUMzNX?=
 =?utf-8?B?ZWJrWnJ0Z0RWUzloOWJrajNGK01OT1BFamlGMnc2VHN2OGc1TG9Eb1V4WWR3?=
 =?utf-8?B?cFdsUklMazRyS3FhS3Jkblg2OHl3U3MzT0RYTEJyWUVuTEZYVjh4L09NeUVr?=
 =?utf-8?B?SDFVaEEybElVRHJ0dEZ1eFdzNjBRU0VkaWhDVEQrU1U0RGR2M0Ixc0d5N2w4?=
 =?utf-8?B?TS9jV3BCSHRFQ3Arclo0aUhiUDR5SkFGM25SUUlZUkxTR25MbWJkanhTUjI2?=
 =?utf-8?B?dENaSzBiMW9sOTI0MWxaY3EzRXdlVXcxaFkwdTdiWGU0Ri9FNGxpNmErWUF0?=
 =?utf-8?B?NDJWU2ZPQ0tlaUhDbmkzcFBsUFRBbVFWNjFrcmFCNXBlMTNoRHdxU09Zd0I0?=
 =?utf-8?B?WU9uREFrY05UNVZDdU9Dcm9pTXlwYnFDZzUrVWJRQWlvY1VON1RZVWpLTWtH?=
 =?utf-8?B?Y1ZvWi9uS083OUY1MGpBZ3ZSN3B1azJydlpXTW8rMG5YYnAzc0hxSTJFUkVQ?=
 =?utf-8?B?cEF0dGkwWGd0UDJIQ251MVM0Yy8zeENWcTdZSEljNWJieUtvbHFod0FEcFky?=
 =?utf-8?B?YU5QMmswNEdXME5tSWErUXB6clVmZGJFN2VnYlN2T20xaXRzL2twUDlmbi9a?=
 =?utf-8?B?NURlSk9qdW4xMjJzT01tdytMT1JmbjJKKzBaM3FncEpxeWVJV3BiRWI2VXFp?=
 =?utf-8?B?bVB0eVhNTnZqcDFveFBTWFVka3hyeXZDVlkwMk9QYWJvakZhbTRrenJ6eHFH?=
 =?utf-8?B?L01mRDRFa2FEQnJLMk45OCtVVlN1bWpGOUE3cUtycHg2OHVxUlVGa085Umgy?=
 =?utf-8?B?VHFMM29JMTh6MTNackc1T2wrQ0hTYlEwa09VM2wrYi9CT1U4Q2pzUzY1dys3?=
 =?utf-8?B?elRKZC9HOGs4M2R4OExwN2VCV2htbkRnekhsZVlIL0N4dFpFZGdmSlo2UVU4?=
 =?utf-8?B?VDBnOER5S2E5YVJLSEltSy9XYWdDU3RjVTgwK0JaK1pxOGFYMU81NytNMU1W?=
 =?utf-8?B?elludDU0aWxCSjArcGpQRngyYXhjWkhBejF3dkFMaEN1NVpDRkcwaXJVYUYy?=
 =?utf-8?B?MGphMkFBcTRHZm54Z3ZDaitCSmplVi9VWTJwaENCNHF0ZmI0QnlvVVVFcWtx?=
 =?utf-8?B?ekQvK1dqRm5lclZZcjRDTERTZ3RqNkdTdExGbzNzVndXWXpGd2dMNWZPMGNx?=
 =?utf-8?B?STVyUGxzdDZLWHE1Z09aclNNVSt3a1lEakZya3JzS0g2T0IwNnZaQzVKYjBB?=
 =?utf-8?B?Q25Bb21GK3F0VEU5ZzR0WktuWVg2dEg1SXZrYXo5NUxBUytuZUN6cWlaTmUz?=
 =?utf-8?B?R2MyMXgwWjUvMGU1aWovcU40ZTc5N3JybVJMY0pmZ2lYbHM1MU9yUExEbmZD?=
 =?utf-8?B?c1h5U01mMkhXSm4vaklGUHFibUZvcFExcXNzZWh0K3BJTFUyS0VTQzRIM2xo?=
 =?utf-8?B?bFhSS3N5VGRWREV6ektpWjZQV0MzV3dKTVNEWThjdWNwbjN2SnZUYWdaMWJR?=
 =?utf-8?B?ekRYNEJmVUx0UmNGTEpyTjhvRWxNQ3h6d1VtcFdzR0JOMit6ZUtJNForb3B1?=
 =?utf-8?B?NkRvbDRNeWI4Vk5oZ3c2KzRRRXhFZkprS2U3S3crMkw2bkxYdmE2elFxWDVs?=
 =?utf-8?B?NXZmekpJdnVjUnRNbC8rUGJzeUJqT3lZZlZ6WTBTdmEza1lmbGozTldOWXl0?=
 =?utf-8?B?MU0yelJYdm5RTlBUMU9VM1FOL0UzNGIwR21uU1lSdDZzSGgxNWU1M2RvTG5P?=
 =?utf-8?B?OHMrbmwyVzdLcSt6VE9XS1JHTHRTWHBYWjAzQ21PbERmTFhjbWJLaW9ENEcx?=
 =?utf-8?B?NnB2ZGRlTHh0WGFVZGN6cWhUQ29waUg1azliZTMvOXFsZ3ZOa05ZZEVVbDZ1?=
 =?utf-8?B?cXU0RlovbC9FRStQVGZqSXM4WFI3T1NPaGc5aUVRblhNVVlsSi9HV1BnSVdU?=
 =?utf-8?Q?Fn7r5/8V6Yeh89PFxqTATGJ9Y?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8521d69b-7aa9-4dac-7744-08db20404294
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 01:47:36.9610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QxVBJyBtAdKyEM4Nt1mbypWiBnZLRkfl7bFmtP//COPZB20njKfdAOTdBIqrkPxqy8xYCXkidISkOfaTTBiYEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5435
X-OriginatorOrg: intel.com

QXR0ZW5kZWVzOiBKYW4gS2lzemthLCBSaWNrIFdhbmcsIFJpY2hhcmQgV2VpbmJlcmdlciwgQmV6
ZGVrYSBGbG9yaWFuLCBKb2hhbm5lcyBLaXJjaG1haXIsDQoJCURhdmlkIE9iZXJob2xsZW56ZXIs
IEhhbyBMaSwgIEppYW5ibyBDYW8sIEhvbmd6aGFuIENoZW4NCg0KQ29tbXVuaXR5IHVwZGF0ZToN
CglDb21wYXQgc3VwcG9ydCBhbmQgaXRzIENJLXdpc2UgZXhwbG9yaW5nIGZvciAzLjIueA0KCWFy
bS9hcm0tNjQgaXBpcGUgcmVsZWFzZSAtIG9uZ29pbmcNCglzdXBwb3J0IGFuZCBjbGFyaWZ5IDMu
MiBjb21waWxlIGlzc3VlDQoNCk9wZW4gZGlzY3Vzc2lvbjoNCglSVCBzaWduYWwgaGFuZGxlIGlu
IGRvdmV0YWlsDQoJRmVhc2libGUgc2NlbmFyaW8gdXNpbmcgcG9sbGluZyBtb2RlIG9mIGRwZGsN
Cg0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQo=
