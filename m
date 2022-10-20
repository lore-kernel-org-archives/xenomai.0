Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03E528F0
	for <xenomai@lists.linux.dev>; Thu, 20 Oct 2022 07:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666252220; x=1697788220;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ePGOBZThfp9otQw7PNfeXlalEFhviDEdHZTmh6DiZkM=;
  b=gOx/4HgnwHFptP/asN5UKzIBDQEO5FE42zeVrdFx+vrvijuewwjHU3F/
   1cbn/uZveIbGUMPF3Y6cApFLJusny7SkXjRf7pBohr/UedZHJj3yDjwIW
   EM56f1piBvQHevo75XGyuVfp7gw2+RrH+fz9kMIGgoWicwLYWOWCELGWq
   vg8gxrcZ1AhyJ+RYaNakN6UKlEQ/3IdvN1DbK2wIa7lKiEiK7Xb6tcWuG
   ZBKiabfKTFl/qvbf3J4BBUPGchjjQV9bi9JkcuN/JM63y1y5A0DgF/FKC
   UDJnlXMUGpHHJpehXP55NAu929H5KSV0V4f6C3gAm/QTFLI6LCMf+REbM
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="304252989"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="304252989"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 00:50:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="662891231"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="662891231"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 20 Oct 2022 00:50:20 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 00:50:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 00:50:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 20 Oct 2022 00:50:19 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 20 Oct 2022 00:50:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QpwrwbLJz5sOkxxCThtvjSmsgJxpdKTjLsyLIgQpWGTRmHK/SLnt0YPaRWEuMuNWpbCKZaXjxC2VCh051mhAFunj8k3J1jdWNB0hPDtq5f8F6POqxpTZpMBqe4OwJ+S5DBqpsKUHRr78TpNymFe+QiFvb/7se8ubuNbOe/LIZKq7GIiT8RsyqseYO8iOHd1oA6y+tHBfie6WNvoTNfAnuja/ilDeYlDWemhn9GCt9NxFcpFEIKM22OF3ooDxx9QBjlHSDJD3TQnvSzq6uKgDY9S3nePITVtfqM0mKrPNUcMwzpgBk3H+mGB6uq7GJd7CqLfW1Q7RRWUJtri59TZAnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePGOBZThfp9otQw7PNfeXlalEFhviDEdHZTmh6DiZkM=;
 b=ZEvbnzPy7Zy/5z15tw+sY35SdaMqXMkSC0x5pohi8sfYcqOp8a68P4RjKq79PIIuWnvNQPGy58akxtBSeGJoEsfuRigM7WJEFLWgmXdzWOC4C/dslebISUPvBs4hyHzWgcQBmgpdIcnsVs4M3BoazOuRTb9ChOJ1C6nutwfyClt2LaFMJxsvNPAZvR48kw/6Bw2De6SWIa6lFpSk2dwuEikVNdl+nvDl2/zCDzfI4hd64pap5XkOIjIodHMA73DeA4uiXjp/6tZUBFLKCowuKGggLFBfNALrcmcS2IJyWSjfR8lS04d6om4iq8cYFWe2Y8oGavVoM4LO+5lry7K1Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by SA2PR11MB5100.namprd11.prod.outlook.com (2603:10b6:806:119::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Thu, 20 Oct
 2022 07:50:16 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::d2bf:1e23:6354:82b1]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::d2bf:1e23:6354:82b1%3]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 07:50:16 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "Zhang, Qiang1"
	<qiang1.zhang@intel.com>, "Heber, Stefan" <Stefan.Heber@zwickroell.com>,
	"rpm@xenomai.org" <rpm@xenomai.org>
CC: "Wang, Rick Y" <rick.y.wang@intel.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: RE: Memory corruptions upon strcpy and similar when being interrupted
 by scheduler
Thread-Topic: Memory corruptions upon strcpy and similar when being
 interrupted by scheduler
Thread-Index: Adjfx7M3PckxyrdzSbOwkv1vwf5NfwCO5U9AAGQTSYAALcPvAAAC6nvA
Date: Thu, 20 Oct 2022 07:50:15 +0000
Message-ID: <MN2PR11MB4285573D61B5CDF710C3B6BFF22A9@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <FR2P281MB2654CD4536C1F2D3592D874EFC249@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
 <PH0PR11MB5880489EA92CEF39E1EED88BDA299@PH0PR11MB5880.namprd11.prod.outlook.com>
 <MN2PR11MB42855402C55DCF4E97183C4BF22A9@MN2PR11MB4285.namprd11.prod.outlook.com>
 <78d8bbfd-99e9-2832-1cc7-3fac3f7452d2@siemens.com>
In-Reply-To: <78d8bbfd-99e9-2832-1cc7-3fac3f7452d2@siemens.com>
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
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|SA2PR11MB5100:EE_
x-ms-office365-filtering-correlation-id: d7fdc601-06ec-4ea0-f8ab-08dab26fba17
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ibNm47DNlMfnGoisN2xfeEEblRYSTYunntmaiyQtrF5MHahmHm3nyhITNh3EFUCyFo9IQmY/P9v3tp7fVf8tM+YbM2l9P/8+QeOjfMPCBIncIQjT0gams/4itPve1q0wXPnbXSiZOHhqKsFaPxn/eJ62sBSpYEkuwoXd0jukXe1eUOX80tYCunjVVJy91CiYS3HDjcBQFjrErxbzh2An4Z+WcRsdBoQHvojUKxbZ2A847WjxXZce/26CyK4sCXYr161ElY4wGySqEFOht0w/akq/wj3H1hDRWCWA31pvm4sS3SjUQcOtW+534naP48PZpYuOx/fibYQVr4uSIP/O8Yegu0VxuuwFbiuYRP0E6xRezHsGI6pT0giaEFuiWgVMF6xawcifR6XSc43cijVyrtolQngV0sCZtfK14ApCqZjQHrzAiy1YVsZjJS2ggPnface/Vziqwmzgx4LvC4Ci+EY4R8Jj3xZTMV+57XYmqw3fvNmEvKNHGmMjg+QfxWesh2oQ/f6BF0mv3tykiUyM5m95XqIpdETu6IotXPdV1qDGXd4df5eC3Msxyjr6xNLV59uoOjX1gwu80w06euD8FhgYuuQdbDYPXLbUg9zkweYI3N7sRsqMikWsZQjG+c3soS6BsA4HgNpQQN1aLF5tYoVA2RBFz3aLwuO+vYCNyX6u9eTFIjhGI5QavL0gic26B5vxMBBkIPXA2uiXQISAIIokvwSJSpOZ7yKFfSaEuNLAZ0s1VG0RUrcYShJtxL/prSWmYqzNoE84v19hR7Bblg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199015)(186003)(82960400001)(38070700005)(478600001)(83380400001)(33656002)(6506007)(54906003)(110136005)(316002)(52536014)(7696005)(55016003)(38100700002)(8676002)(4326008)(26005)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(122000001)(71200400001)(86362001)(2906002)(8936002)(41300700001)(53546011)(9686003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEFHMXZWdFkwb3kzVlJzUGdQK3dhbllpVTBYMDFUVDU0UU1nb0NrQklSRXFq?=
 =?utf-8?B?S2J4TVVTVzF5SXJMeUc2c0FoanBDczRGdFQvbFVTZTRlMUJ0VkhzR3BOR0V1?=
 =?utf-8?B?bEtMSHRPeW14VEY1TlVmQ3FaU0M3QTYvaHdVOFh2eEhLWko2ejJvVnU5bEVx?=
 =?utf-8?B?SDl6dzhxOFd0R3Z3a0lCWDRZOUJ2eDJ0Y3ExMnNac1RHZW5uNW1oSkhRY2Ro?=
 =?utf-8?B?RFJwaTNHRGI2SFRYeUtYdWZBTStJaElHNmJiOWVJYU5wWGM2NC9MRTVmMTBN?=
 =?utf-8?B?cjc3b1BZVllzK3U1ZFE1MzJNT1Q2NW9kQ2F4ZlRNNVdYdlRyRFNGcEtVZjZ5?=
 =?utf-8?B?TjgyTVdUK1ZPRFVUODg5Z0ZsR0F1NEFPVVI2NG9TaHErL1FNelIzQzVGcWdm?=
 =?utf-8?B?eGRRK3BybFhoeXZzREN5NVR5UVBiY0NOTnIxczA1MG9QeXpZMStIamlTL1F5?=
 =?utf-8?B?MUVrdHBYckFNQkxqSGM5Nlo5TTBmT3BobDl4eFhLMTJtZDljcjY4d2xlWHp2?=
 =?utf-8?B?MXdzOFR0MytneEx2Z1FsN2QyeCtQeE9sLzZUNElLSVc5YkNvTUVWZnd1SXdt?=
 =?utf-8?B?TmNhanRYMW5tbERlbnFKZUdMR0xGYi9NMVlUc0xyUTF6S1l0Tk5GTmI3ZFRV?=
 =?utf-8?B?L2lyRFlWUHhpUlUzTWtkNkduOXVicjlHMXlhRmpVNkU3MDFqZ3ZYeWJQUkxr?=
 =?utf-8?B?Slh4SnFnbWVpMFlVbUpackozSWUxUk5wd3VPUjBhYmVCNzg5Z1lRU25wcGEv?=
 =?utf-8?B?NlZidGNNbWxHV2lJakUzSFRObE5HNmEyU1lYME9oem16b2lWQzQxS3czN1JW?=
 =?utf-8?B?azNPL1FsSjhsYVBYNGY0RndMUCt5NTdrY2NwbGhnczlDUTA1dDBLS2dpNzg2?=
 =?utf-8?B?eHkycFFkWXl4bmFNeE1Ua3BYK0hJVndkL2FySkFXcTRQRDVjdy8rMDJsd3Iw?=
 =?utf-8?B?aGNGNFA1SzgvRTRtYStoZy9xeHM2UGdMV0o3ZlgzbGl0SHNobGp4TXF5OWZH?=
 =?utf-8?B?VVpMbnM0TmdKeEhBc200LzF6bm8zZE1EUHg3ckkxVmJTMzRpdjhwU1ljMUEz?=
 =?utf-8?B?bmRhMnRuSDZ2TGRVcXVEOThubXB4VmZsSVJHZDlXUUlISUc3MWJVYzM5L0xB?=
 =?utf-8?B?bzR1U0M1ZUxsVFRWVEYyVGhyUFVKdkg5NDVTK1M1VEF1N0dpNTd5M040U3kz?=
 =?utf-8?B?cVVoQ2R0QkxEUUFQRzBNYU0ydENWa0xZSGtFaDhxbXpxdFNQVzdhaklRSnk4?=
 =?utf-8?B?UFMyelFXWjlvbnJVWXY5UmMvWCtSWE1VdUs3eTZSOFFQMHlaMVBmUWJpZmo1?=
 =?utf-8?B?ZkgxbEFtS0w3bXp4UlF5Sk5XempqQ3dmMDFwQnhZdjZ5bm95S21iN1hhSFAv?=
 =?utf-8?B?ZFVKaWNxVkxsRERtVUVoemxPakF6c1VBTW05eDFoZmNleERzdjFKTi80bHR0?=
 =?utf-8?B?bTdWbHZ1RjBlcGR2TFBxQ0ViWmRRYjVFTVRpWElJbHhQRnNxeXQ5TDNFempa?=
 =?utf-8?B?Z2UvejNrb0R4UkhSYTFNQWx5dGh5L1o0OW93T2x1T0wvZ003NjY4cXltUHVB?=
 =?utf-8?B?WUJrSk82ZmpRTWNoOUpIRGZkZGE5UzNuWjN3TnJKeTdWTWNvd0hPQTZWUEI0?=
 =?utf-8?B?QkpTTTJ2MTVETHU2cXJhUmtLYnB5cC9EeW85enhTVW9QSHprNGZEdUlNdXl0?=
 =?utf-8?B?Y2hLSllEZDJIbkF3UCtBQVd2RkRpQ1hRVEh6OWpNbFNSSW5qRFhMYTEvYW52?=
 =?utf-8?B?bS84RU1iZmFFUTVHa0NZOGN3ZDZMMVdtMUYxeURvSnZoYkpxbFUzNWNzc3ZJ?=
 =?utf-8?B?SGdHUmRTZnpkdUZMR1Q1VzJRT0xoTTN3enE5UkcyRWc5YS9yUU42cnZLeDBY?=
 =?utf-8?B?ZktFTUFnMU1sdjJBaFN2ckdWSlNOVG5jUVY0b1duTzBLUTIzQ0Q0NVJtK1NG?=
 =?utf-8?B?VlhPenZUK1MyQmlhZExkVG9CYW1JaE1zZ0dMZTR1NGZ5K1NLcW1sd2RYelRJ?=
 =?utf-8?B?Z1BIc2MweVJyNnh3YlUxcHpZL1BYZ2xuaU1tZFpoNDZkbzA3aVNXd01PMCtQ?=
 =?utf-8?B?Ung2bXpLaWxaMDgxbU1WaDdMa1pxelBiRnBDMC9MTTZwWkJCVWdwSkRXaW4w?=
 =?utf-8?Q?LkSyRxOyIFvr0DM2QwNLurwtN?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d7fdc601-06ec-4ea0-f8ab-08dab26fba17
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 07:50:15.8968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k3OCACPTaH0/Dxc+WHL0bUoyDL9tpX0+fRxcyNfESp7M9ooBLpPegBiQKY8IYzuHDLpzqU+Z3aQmPUmPs4z9Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5100
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEphbiBLaXN6a2EgPGphbi5r
aXN6a2FAc2llbWVucy5jb20+DQo+U2VudDogVGh1cnNkYXksIE9jdG9iZXIgMjAsIDIwMjIgMjox
MCBQTQ0KPlRvOiBDaGVuLCBIb25nemhhbiA8aG9uZ3poYW4uY2hlbkBpbnRlbC5jb20+OyBaaGFu
ZywgUWlhbmcxDQo+PHFpYW5nMS56aGFuZ0BpbnRlbC5jb20+OyBIZWJlciwgU3RlZmFuIDxTdGVm
YW4uSGViZXJAendpY2tyb2VsbC5jb20+Ow0KPnJwbUB4ZW5vbWFpLm9yZw0KPkNjOiBXYW5nLCBS
aWNrIFkgPHJpY2sueS53YW5nQGludGVsLmNvbT47IHhlbm9tYWlAbGlzdHMubGludXguZGV2DQo+
U3ViamVjdDogUmU6IE1lbW9yeSBjb3JydXB0aW9ucyB1cG9uIHN0cmNweSBhbmQgc2ltaWxhciB3
aGVuIGJlaW5nDQo+aW50ZXJydXB0ZWQgYnkgc2NoZWR1bGVyDQo+DQo+T24gMjAuMTAuMjIgMDI6
NDEsIENoZW4sIEhvbmd6aGFuIHdyb3RlOg0KPj4NCj4+DQo+Pj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4+PiBGcm9tOiBaaGFuZywgUWlhbmcxIDxxaWFuZzEuemhhbmdAaW50ZWwuY29t
Pg0KPj4+IFNlbnQ6IE1vbmRheSwgT2N0b2JlciAxNywgMjAyMiA0OjQ0IFBNDQo+Pj4gVG86IEhl
YmVyLCBTdGVmYW4gPFN0ZWZhbi5IZWJlckB6d2lja3JvZWxsLmNvbT47IEtpc3prYSwgSmFuDQo+
Pj4gPGphbi5raXN6a2FAc2llbWVucy5jb20+OyBycG1AeGVub21haS5vcmcNCj4+PiBDYzogV2Fu
ZywgUmljayBZIDxyaWNrLnkud2FuZ0BpbnRlbC5jb20+OyBDaGVuLCBIb25nemhhbg0KPj4+IDxo
b25nemhhbi5jaGVuQGludGVsLmNvbT47IHhlbm9tYWlAbGlzdHMubGludXguZGV2DQo+Pj4gU3Vi
amVjdDogUkU6IE1lbW9yeSBjb3JydXB0aW9ucyB1cG9uIHN0cmNweSBhbmQgc2ltaWxhciB3aGVu
IGJlaW5nDQo+Pj4gaW50ZXJydXB0ZWQgYnkgc2NoZWR1bGVyDQo+Pj4NCj4+PiBIaSBTdGVmYW4N
Cj4+Pg0KPj4+IEkgYWxzbyB1c2UgeGVub21haS12My4yIGFuZCBsaW51eC12NS4xMC55LWRvdmV0
YWlsIHRvIHRlc3QgaXQuDQo+Pj4gVGhpcyBwcm9ibGVtIGRvZXMgbm90IHRyaWdnZXIgd2hldGhl
ciB3ZSB1c2UgbWVtY3B5IG9yIHN0cmNweQ0KPj4+IChub3QgbmVlZCB0byBjaGFuZ2UgdHhyMTkz
OTF0ZXN0ICBjb2RlKS4NCj4+Pg0KPj4+IEl0IHNlZW1zIGxpa2VseSB0aGF0IHRoZSBwcm9ibGVt
IGlzIHJlbGF0ZWQgdG8gaS1waXBlLg0KPj4NCj4+IEkgZm91bmQgaXQgd3JpdGUgd3Jvbmcgb3du
IHN0YWNrIGFkZHJlc3MgaW50byBhbGxvY2VkIG1lbW9yeSB3aGVuIGlzc3VlDQo+aGFwcGVuLg0K
Pj4gRm9yIGV4YW1wbGUgYWZ0ZXIgcnVuIHR4cjE5MzkxdGVzdA0KPj4gY2F0IGl0cyAvcHJvYy9w
aWQvbWFwcy4gSXRzIHN0YWNrIGFkZHJlc3MgaXMgZnJvbSAgN2ZmZGFkODhlMDAwIC0NCj43ZmZk
YWQ4YWYwMDAgbGlrZSBmb2xsb3dpbmcuDQo+Pg0KPj4gN2ZmNzg0NzI3MDAwLTdmZjc4NDcyODAw
MCBydy1wIDAwMDAwMDAwIDAwOjAwIDANCj4+IDdmZmRhZDg4ZTAwMC03ZmZkYWQ4YWYwMDAgcnct
cCAwMDAwMDAwMCAwMDowMCAwICAgICAgICAgICAgICAgICAgICAgICAgICBbc3RhY2tdDQo+PiA3
ZmZkYWQ5NmEwMDAtN2ZmZGFkOTZkMDAwIHItLXAgMDAwMDAwMDAgMDA6MDAgMCAgICAgICAgICAg
ICAgICAgICAgICAgICAgW3Z2YXJdDQo+PiA3ZmZkYWQ5NmQwMDAtN2ZmZGFkOTZlMDAwIHIteHAg
MDAwMDAwMDAgMDA6MDAgMCAgICAgICAgICAgICAgICAgICAgICAgICAgW3Zkc29dDQo+Pg0KPj4g
QWZ0ZXIgcHJpbnQgMTYgYnl0ZXMgb2YgdGhlIGNvcnJ1cHRlZCBkYXRhICBpbiB0eHIxOTM5MXRl
c3QsIHdlIGNhbiBzZWUNCj4+IGRhdGEgbGlrZSBmb2xsb3dpbmc6DQo+Pg0KPj4gMHg3OCAweGNi
IDB4OGEgMHhhZCAweGZkIDB4N2YgMHgwIDB4MA0KPj4gMHhiMCAweGNiIDB4OGEgMHhhZCAweGZk
IDB4IDdmIDB4MCAweDANCj4+DQo+DQo+SXMgdGhlIHN0YWNrIHBvaW50ZXIgb2YgdGhlIHJlbGF0
ZWQgdGhyZWFkIGludmFsaWQgaW4gdGhhdCBjYXNlIGFzIHdlbGw/DQoNCldlIHdpbGwgY29udGlu
dWUgdG8gIGZ1cnRoZXIgZGVidWcgdG8gY2hlY2sgaWYgaXQgaXMgaW52YWxpZCBhdCB0aGF0IHRp
bWUuICBJbiBhZGRpdGlvbiwgd2UgYWRkZWQgZGVidWcgY29kZSBmb3IgYmUgbW9yZSBxdWlja2Vy
IHRvIGZpbmQgdGhlIGNvcnJ1cHRpb24gaW4geG5pbnRyX2NvcmVfY2xvY2tfaGFuZGxlciB3aGlj
aCBpcyB0cmlnZ2VyZWQgb24gb3RoZXIgQ1BVIGJlZm9yZSBhcHAgcnVubmluZyBvbiBDUFUxIGZp
bmQgY29ycnVwdGlvbiBhbmQgdGhlbiBzZXQgYnJlYWtwb2ludCAgdGhlcmUgYXMgeW91IHN1Z2dl
c3RlZCB0byB0cnkgdG8gbG9jYXRlIHRoZSBwcm9ibGVtYXRpYyBjb250ZXh0IGFuZCBmaW5kIHRo
ZSByb290IGNhdXNlLiANCg0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQoNCj4NCj5KYW4NCj4N
Cj4tLQ0KPlNpZW1lbnMgQUcsIFRlY2hub2xvZ3kNCj5Db21wZXRlbmNlIENlbnRlciBFbWJlZGRl
ZCBMaW51eA0KDQo=
