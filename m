Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F4C7E
	for <xenomai@lists.linux.dev>; Tue,  6 Sep 2022 07:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662451027; x=1693987027;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=QlwtpXzbzj4Ga4o1BuLv/TYw7gSaS6yvXLCIEN63PBQ=;
  b=LxEV0CGHmTtelEP/BdM435s7XDpkavOpOLDpDrSHVXcX5Mmcx3U/HcRl
   orvixrQWaRrs13BZQAGE/sPnTZ5IkJ2npL7FrG4w0QtjT/2kDr3quiHBU
   PbYCYUvZCBN6gMZStYJRUZRshiYtsnIAlCrTE93WxodiUDueM1yh8w94g
   bvZo5Q0qsMhI9eewn5WKeYEnK5glIdG0PFh9k8jefO8H6NgaxnXt8Jq08
   +ivj538FSZBfgKaTsTLFg03OlCp3r7qobLojrDDZ7PAaWEmBxHJxzcfGN
   dNYfLusLfUSpjlkTj0a+C5NE1o3gRy6dan/IrDSRqM1Im9FtnMHE0kVYS
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="296532680"
X-IronPort-AV: E=Sophos;i="5.93,293,1654585200"; 
   d="scan'208";a="296532680"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 00:56:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,293,1654585200"; 
   d="scan'208";a="675580520"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 06 Sep 2022 00:56:51 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 00:56:51 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 6 Sep 2022 00:56:51 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 6 Sep 2022 00:56:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HrgveTXOr/mN9XK10a4AjgJTWNE+hMwuGOQKb5U/dRNdYBrDI01l4d5BwHrZeeEStPnFChR/bCdbXBDmHWEXTW1N8UFZ9IMif2/XK4M/7Eduf71FoycPeRxqUiWU7Pr5zc7e/OTsQeUFPpAmV9vYP6viWpu9QPxfjP3Cpy1zyHLklFxNT6CzyE1b2oIgFU638u+j6uLeUyudUmDmd5s0nUxTYenRK4u2jzS3LCAxH41pz/8c2MO7UNIpPiX9Jp2Igj7fefKRjcvMIR0viZ95c9l2rYoa2SqC9BfQR1cVmYtB7BxgeJKwCIgpgGHzyGneZLsVk17N/5V5PUfZqm6A+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlwtpXzbzj4Ga4o1BuLv/TYw7gSaS6yvXLCIEN63PBQ=;
 b=GEuIZP2C+WGt9rLLQFBAOumiBi39KVtE3NLEKfJfZVCp/2BAmLaRyHD8sWL2PefQF2kUK2jFL45LwRu1BajtHPW0wORsDYIEj94uVNoyPB9JqPxyXjaEsU0oYCkkWTBgci8aClMQOAeNwT0cow8dwo/xNYyHOn0lVfbhhDh/iUJz3HKb85YniHINEv0rtBnAFsFGtdqZ52WUovr6u+NXKSxT+Fgwmbboi4CvLHasPEYqvvF/EF57JNRyATRjdZ3dg8Cru/uH7zEHjoNBcD1+X3SsnfSnDLaWEVC5LBhV/Q+iGmWTyKPJ4XwnQE/14vCnEg3CKOTLMMOGp/ApUr0Z/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by CH2PR11MB4440.namprd11.prod.outlook.com (2603:10b6:610:48::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.16; Tue, 6 Sep
 2022 07:56:48 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::159d:a6de:f2b9:fc83]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::159d:a6de:f2b9:fc83%3]) with mapi id 15.20.5588.015; Tue, 6 Sep 2022
 07:56:48 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, Jan Kiszka <jan.kiszka@web.de>,
	"xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: [PATCH 0/1] net/drivers: igc: introduce rt_igc driver
Thread-Topic: [PATCH 0/1] net/drivers: igc: introduce rt_igc driver
Thread-Index: AQHYtcgZgq7mtu1cZ0KhlErBpHBIpK3BZbQAgAc9FiCACC+sgIABS1+g
Date: Tue, 6 Sep 2022 07:56:47 +0000
Message-ID: <MN2PR11MB4285CCC83FA4619C26FC9744F27E9@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <20220822011821.21283-1-hongzhan.chen@intel.com>
 <ad5ac2e9-e662-ee94-94fa-c7d42b6e4b68@web.de>
 <MN2PR11MB4285D85CEB6935A1CC30EE64F2789@MN2PR11MB4285.namprd11.prod.outlook.com>
 <c932287e-0574-3681-f7e1-b7066c94e547@siemens.com>
In-Reply-To: <c932287e-0574-3681-f7e1-b7066c94e547@siemens.com>
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
x-ms-office365-filtering-correlation-id: 3ef7876d-fac5-453f-6dc7-08da8fdd5986
x-ms-traffictypediagnostic: CH2PR11MB4440:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GUrHlyNI7loX2OU4IlyqwdVmHyuq6qPuMmKAk1wzdmfLKvnrZyLPmQ1i1ccipmAIitAOF16lb0OzB5h3y3aQg3xRSj86rH/8BlII2RVCnS58N5K91FhVW93JZXg4bkb9AgXu7I4ShmdpCpB3KJOEg0UFCLQM0yhW0/jI+QGzdSXAfOVuB9EAz0sHyXyZCfvklqQNMJW7EdVX15uYCUfb8IrmgSlpady6AA4hV/5o6/D3Q7gUA7LX502OBkqMuwgVyPczrRZahQ4vGCnE0NYJSqld+1oDLbL8IEsMjBUO/BlChD3gO4TLJ8LAhbU44Z5Oq8QnEmRN/E4E/CGLAMgvTFYFmGxclexwg4yPADjRdz+8iEZmzyD1O02CEcIs3okzS+kqbA7Abxpna/rIq5iaHic+lGhNINCYDUI4OdjR42z8JPWa16oaxFZLXQ3ES4sR7dzF6zidSh88ZTHfxGsbD5ZU5SQ0ZENwmQdBBssJmFnHJlBNvFOVgPzlm8QjqSYUEnxiRtwb54ds8x98iHxQKjZyFnzO/jzs3GfioEhSMDQXv2Vc1cuZE318sG34dSukMDDsFKKvrb3jE/u+Fo64EU4HqAT+6Q5sdixLj2zIx2TT7mGkMYf7K4Mo92+Tarl2yLiS8ltKV/NWMfEDP6F598H0oR6MjLL2H9J+n4eiExo6VzdI0Z2Alc4ZSPaGSsyImMpX/+pHk621znNOJ79K5/2iw96rIvmdKOvbMcj7hIvMZTdJWJe+O9jB87iLVBS8BWTDHgDi2Dan3dvdFgh5lA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(376002)(39860400002)(346002)(136003)(76116006)(186003)(122000001)(38100700002)(82960400001)(8936002)(83380400001)(5660300002)(52536014)(64756008)(66476007)(66446008)(55016003)(66556008)(66946007)(2906002)(8676002)(478600001)(6506007)(26005)(9686003)(7696005)(41300700001)(71200400001)(110136005)(53546011)(33656002)(38070700005)(316002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHRXOWdFK3JPMDNZN3RSTHEyUlJrazExZVRZYUw3aVIrTG1mbmVXVmNZZHlT?=
 =?utf-8?B?Vjd0WDlZOHJDakp6QnpPT0ErbERZNzJJNy9YSmJ2SWhLVlkyblJrSTRTSDkw?=
 =?utf-8?B?MklGRzZxMXp0ZnFUZ0VPZW02cGhnT2oxcmR5ZzlCZ29ZbGY0NjdndG1DSXU3?=
 =?utf-8?B?ZWZRM3FrYUxucEJ2Z3NTNm55T1M5T0h2c2pvQlgyclBLSDlXR1RWbTlwY0Ja?=
 =?utf-8?B?VDZ4M0t0ajJLOUhZOXcwQS9OMHBPMWYrSnptVnN2UlJwa2k2NEVXZWFtN2Jo?=
 =?utf-8?B?RXVBVDRCMXNMN1RRTTJyenUya1J1RUNiUHBrY0tQajY2ek9URTZESjdUenVz?=
 =?utf-8?B?Q2hOdkh3MERHSVJ2Y1FaRHdza1E0M2ZVTitkRC9teVBPOEFST0VYc24ydGJR?=
 =?utf-8?B?WTJBclZaZk5yYnpNYzMydlFhOC9lbFVNTW1nZlRua3Z3NWZRSVN1WW9NNmtn?=
 =?utf-8?B?d0I5OEVteGowQU9LckpUOFRkRGcwRGdCS2hjSnVrN1FUdy9GUmZJcWRyK290?=
 =?utf-8?B?REJuM3IrYnFnWUJibzFWNEN1RmdmT0J4aFpydTV3dWxnYk9PbkN1WWRjRXJs?=
 =?utf-8?B?eW5hVGtDS3dwcWQ4cDBSTWxZa21hbGMzMlRwTS84WGRia3pMeDM4OWovTXhI?=
 =?utf-8?B?enZ6S2VFYnZrYlJUZkRWMmtWVEo3MlFaQ0dMK1F5ejBpUnlxMWlsZFZaM3dM?=
 =?utf-8?B?dzJLMUc2VldiWkpuQVV5ekoxL01kWkFhZXdwOU5NcUF1eTd1cjRtcVllMEhn?=
 =?utf-8?B?bVdyVkVjck5mS2FzeUVJUVczbnl3OFhFSEg3T3NqODNZNitVUG9NSDVaelQz?=
 =?utf-8?B?Vit6ZnRyNWZLYktQQnlDak9RM1ovMWhHZUtRZk96Q3JqaTFEZWlEY1FDVmk5?=
 =?utf-8?B?ZElIUjF2MjZHc1R2bXd3WnFKNUJkY0xFNy9UTG4wSXpsOWxvaHRaVVlUd2Jo?=
 =?utf-8?B?VFBJUnNSUjFJNVFrRE9zdEZwcTcvZjVXaDJVdUxjeUYvQjdycXVUbWVzZnhr?=
 =?utf-8?B?V0k2cEFvbFVCZllJSXpzSHRUby9TK1dXeGtKS2kyVnBvTGV3OU5qSFkydjl4?=
 =?utf-8?B?YzdOcGFzNTgxN21QT0ZTMDJJenJ1NVhWZWJLV1QrdlRFMlF5QzUycHpHOFJv?=
 =?utf-8?B?R0I3R1AxK3VHVWpGTGQ3VCtPdExJYXBQUlpwQi9BTVFkU05HQk81eUhuTzNw?=
 =?utf-8?B?M0VwS2tjcy9LZFBKU21aMHF0aFFvY2ZPSGEzN0FyelMxR3I1djFEbG95TWlK?=
 =?utf-8?B?WE9QZjZjR0VSYnFUK1lMdUV4dWdVMjUxd0RaQlVUY2Frd2Evb2FCNXIzNTVk?=
 =?utf-8?B?VVhuUTkwNFFUc0lxK2ExYXp3MGFJMTFPN0Erekx2bDNxN2xRendZTTl0Vjkr?=
 =?utf-8?B?U01LV1VvZTVTWG54M3NPdEJ3QlMyT1pQSk5KYi9aSmlMczVuajlsWEY2NTVK?=
 =?utf-8?B?b3ZXV01FZ1A0M0FYUEgwRmpGMDFKdWNHTXhSdURuUlJOS3M5RXVXL0ZiWnlt?=
 =?utf-8?B?VFZpbjFjaW5zZXNWb3pCNk9HYXEzT1NPSFh3aU9OSnlGUGJMN2JOTElTZ2M2?=
 =?utf-8?B?Mmo0a1RVbC8wdjZGbUtldTRzQTFkK0E1NXRrUDVCNDc5alNCZlprNG5HRmpm?=
 =?utf-8?B?U1Zyckpac0NvWkZseUVoTnJBY3REOGZNam1zRTE0Z3FUQ3RnRTdDemFCb3R6?=
 =?utf-8?B?OGNPZ250cWIxbkxCSG5BMHJCZ0JBb0JUKzhlLzRHRW9BNjR1N0lRZEZCVzg2?=
 =?utf-8?B?SEJ2eXVMYnV3MXlLZVBKM09IdmtWVDVSY3JhUHVyVzkvWFVSWGpDeW5EeVdV?=
 =?utf-8?B?Y1E3SGQ5bkVuSS9odlBCYmpGdFd2RlVGcTBSbXRGU3FDNEt1SERua2Z2RHRL?=
 =?utf-8?B?dHhLL2xvcFl2M2p5S1BZV0tjcmEvY2psMEFmc0NUTDRzYk9TQ2tUYXBneXY1?=
 =?utf-8?B?Uzgzemc2dGFwMDRVaFdKc0haVVNJaHNhVk9KQTEyNmg3VTFtaVZMbXJkYkhR?=
 =?utf-8?B?K3FqdzgxOFpnNkZIaWxHWE93RnFUZnpURDB2L2RXNXRadkVnclJaL21hekN2?=
 =?utf-8?B?clF4TWd2aHlia2l0UGZ4THZBZWw0NjlVQkx3RmdVcE95ekhzdXc2dmdaNGpl?=
 =?utf-8?Q?YTZDxNVSGnlf1s5Z5+E5v/BMF?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef7876d-fac5-453f-6dc7-08da8fdd5986
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 07:56:47.8404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dK1PE5shi5nuz12UvIEYfpQqF+5Nr/tIhrqIpt55zF+3XuJ7SKyk8CFTx4z2xnSkB3VUEiKYwVYOh9YBFNkVgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4440
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEphbiBLaXN6a2EgPGphbi5r
aXN6a2FAc2llbWVucy5jb20+DQo+U2VudDogTW9uZGF5LCBTZXB0ZW1iZXIgNSwgMjAyMiA4OjAw
IFBNDQo+VG86IENoZW4sIEhvbmd6aGFuIDxob25nemhhbi5jaGVuQGludGVsLmNvbT47IEphbiBL
aXN6a2ENCj48amFuLmtpc3prYUB3ZWIuZGU+OyB4ZW5vbWFpQGxpc3RzLmxpbnV4LmRldg0KPlN1
YmplY3Q6IFJlOiBbUEFUQ0ggMC8xXSBuZXQvZHJpdmVyczogaWdjOiBpbnRyb2R1Y2UgcnRfaWdj
IGRyaXZlcg0KPg0KPk9uIDMxLjA4LjIyIDEwOjI0LCBDaGVuLCBIb25nemhhbiB3cm90ZToNCj4+
DQo+Pg0KPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4gRnJvbTogSmFuIEtpc3pr
YSA8amFuLmtpc3prYUB3ZWIuZGU+DQo+Pj4gU2VudDogU2F0dXJkYXksIEF1Z3VzdCAyNywgMjAy
MiAxMjoyNyBBTQ0KPj4+IFRvOiBDaGVuLCBIb25nemhhbiA8aG9uZ3poYW4uY2hlbkBpbnRlbC5j
b20+Ow0KPnhlbm9tYWlAbGlzdHMubGludXguZGV2DQo+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCAw
LzFdIG5ldC9kcml2ZXJzOiBpZ2M6IGludHJvZHVjZSBydF9pZ2MgZHJpdmVyDQo+Pj4NCj4+PiBP
biAyMi4wOC4yMiAwMzoxOCwgSG9uZ3poYW4gQ2hlbiB3cm90ZToNCj4+Pj4gcG9ydGVkIGJhc2lj
IG5ldHdvcmsgZnVuY3Rpb25zIG5vdCBpbmNsdWRpbmcgVFNOLg0KPj4+Pg0KPj4+PiAxLiBwYXNz
ZWQgdGhyZWUgbmV0d29yayByZWxhdGVkIHNtb2tleSB0ZXN0OiBVRFAsIHJhdywgZGdyYW0sIEJ1
dA0KPj4+PiAgICBJIGRvIG5vdCBrbm93IGlmIHRoZXNlIHRocmVlIHRlc3QgaXMgZW5vdWdoIHRv
IHZhbGlkYXRlIHRoZQ0KPj4+PiAgICBkcml2ZXIsIHBsZWFzZSBsZXQgbWUga25vdyBpZiB0aGVy
ZSBpcyBvdGhlciB0ZXN0cyBuZWVkIHRvDQo+Pj4+ICAgIGNvdmVyLg0KPj4+DQo+Pj4gSWYgdGhv
c2UgdGVzdHMgZXhjaGFuZ2VkIG1vcmUgdGhhbiBhIGhhbmQtZnVsbCBvZiBwYWNrZXRzICh0byBt
YWtlIHN1cmUNCj4+PiB3ZSBhcmUgbm90IGxlYWtpbmcgYnVmZmVycywgdGh1cyB3aWxsIHJ1biBv
dXQgb2YgcmVzb3VyY2VzIGFmdGVyIGENCj4+PiB3aGlsZSkgYW5kIGlmIHlvdSBjaGVja2VkIHRo
YXQgdGhlIHJlcG9ydGVkIGxhdGVuY3kgaXMgY29tcGFyYWJsZSB0bw0KPj4NCj4+IEkgc2V0dXAg
dHdvIGVudmlyb25lbWVudHMgdG8gZG8gcnRfaWdjIHZhbGlkYXRpb24gbGlzdGVkIGluIFsxXS4g
SSBhbHNvIHNldHVwIFsyXQ0KPmVudmlyb25tZW50DQo+PiB0byBjb21wYXJlIHBlcmZvcm1hbmNl
IHdpdGggaTIxMC4gQWxsIHRocmVlIHNtb2tleSB0ZXN0cyggVURQLCBER1JNLA0KPlJBVykNCj4+
IGhhZCBwYXNzZWQgNzIgaG91cnMgbG9uZyB0aW1lIHRlc3QgaW4gWzFdLkIuIEluIGVudmlyb25t
ZW50IFsxXS5CLCB0aGUgbGF0ZW5jeQ0KPj4gaXMgYWJvdXQgNjB1cyBiZXR0ZXIgdGhhbiAxMjAg
dXMgbGF0ZW5jeSBnb3QgaW4gWzJdIGluIFVEUCBzbW9rZXkgdGVzdC4NCj4+DQo+PiBbMV06DQo+
Pg0KPj4gQTogSTIyNTwtLS0+c3dpdGNoIDwtLT4gSTIxMA0KPj4NCj4+IEI6IEkyMjU8LS0tPkky
MjUNCj4+DQo+PiBbMl06DQo+Pg0KPj4gQzogSTIxMDwtLT4gSTIxMA0KPj4NCj4NCj5PSywgbG9v
a3MgZ29vZC4NCj4NCj5PbmUgZm9sbG93LXVwIHF1ZXN0aW9uOiBJJ3ZlIGp1c3Qgc3BvdHRlZCB0
aG9zZSBodyBzZW1hcGhvcmUgZnVuY3Rpb25zLg0KPk5vbmUgb2YgdGhlbSBpcyBldmVyeSBjYWxs
ZWQgZnJvbSBSVCB0YXNrIG9yIGV2ZW4gUlQgaW50ZXJydXB0IGNvbnRleHQsDQo+ZGlkIHlvdSBj
aGVjayB0aGF0IGNhcmVmdWxseT8NCg0KSW4gSUdDLCB0aGUgaHcgc2VtYXBob3JlIGlzIGp1c3Qg
dG8gcHJvdGVjdCBhY2Nlc3NpbmcgUEhZIG9yIE5WTSByZWxhdGVkIHJlZ2lzdGVycywgIHdpbGwg
YmUgZW5jYXBzdWxhdGVkDQppbiBwaHkgb3IgbnZtIHJlbGF0ZWQgb3BlcmF0aW9ucyBidXQgbm90
IGRpcmVjdGx5IGNhbGxlZCBvciB1c2VkIGJ5IFJUIHRhc2sgb3IgUlQgaW50ZXJydXB0IGNvbnRl
eHQuDQoNClJlZ2FyZHMNCg0KSG9uZ3poYW4gQ2hlbg0KPg0KPj4+IHJ0X2lnYiBlLmcuLCB0aGVu
IHdlIGhhdmUgYSBnb29kIGluZGljYXRpb24gdGhhdCB0aGUgZHJpdmVyIHdvcmtzLiBUaGUNCj4+
PiByZXN0IGlzIGZpZWxkLXRlc3RpbmcuDQo+Pj4NCj4+Pj4gMi4gSW4gYWRkdGlvbiwgYW5vdGhl
ciB0aGluZyBJIHdhbnQgdG8gZGlzY3VzcyBoZXJlIGlzIFRTTiBmdW5jdGlvbnMgb2YNCj4+Pj4g
ICAgaTIyNSBoYXMgdGhlIHZlcnkgc2ltaWxpYXIgZWZmZWN0IHdpdGggVERNQSBub3Qgb25seSBm
cm9tIGNsb2NrIHN5bmMsDQo+Pj4+ICAgIG1hc3RlciBhbmQgc2xhdmUgYXJjaCwgdGltaW5nIG1h
bmdlbWVudCBidXQgdGhlIGRpZmZlcmVuY2UgZm9yIFRTTiBpcw0KPj4+PiAgICB0aGF0IG1vc3Qg
b2YgZnVjbnRpb25zIGlzIGltcGxlbWVudGVkIGJ5IGhhcmR3YXJlLiBXZSBhcmUgY29uc2lkZXJp
bmcNCj4+Pj4gICAgaWYgaXQgaXMgZmVhc2libGUgdG8gaW1wbGVtZW50IFRTTi1lbmFibGVkIFRE
TUEtVFNOIGRyaXZlciB0byBtYWtlDQo+Pj4+ICAgIHVzZSBvZiBpMjI1IGhhcmR3YXJlIGZlYXR1
cmUgYmVjYXVzZSBURE1BIGl0c2VsZiBpcyByZWFsbHkgaGVhdnkuDQo+Pj4NCj4+PiBZZWFoLCB0
aW1lLXRyaWdnZXJlZCBzZW5kIGlzIGJhc2ljYWxseSB3aGF0IFJUbWFjL1RETUEgaW50cm9kdWNl
ZCB2aWENCj4+PiBzb2Z0d2FyZSBhbG1vc3QgdHdvIGRlY2FkZXMgYWdvLiBJJ20gbm90IHN1cmUs
IHRob3VnaCwgaWYgd2Ugc2hvdWxkIG1hcA0KPj4+IHRoZSBjb25maWd1cmF0aW9uIG9mIFRTTiBj
YXBhYmlsaXRpZXMgb2YgbW9kZXJuIGhhcmR3YXJlIG9uIGludGVyZmFjZXMNCj4+PiAoUlRtYWMg
JiBDby4pIHRoYXQgd2VyZSBkZXNpZ25lZCB0aGF0IGxvbmcgYWdvLiBJZiBpdCBoYXBwZW5zIHRv
IHdvcmsNCj4+PiBvdXIgZWFzaWx5LCBpdCdzIGEgbmljZSBleHBlcmltZW50LCBidXQgd2Ugd291
bGQgbGlrZWx5IG1pc3Mgb3RoZXINCj4+PiB0aGluZ3MgKFFidiB0cmFuc21pc3Npb24gd2luZG93
cyBlLmcuKS4gQW5kIHRoZXJlIGlzIGFsc28gdGhlIHF1ZXN0aW9uDQo+Pj4gaG93IHRvIHNldCB1
cCBhbiBvcGVyYXRlIFBUUCBhc2lkZSBSVG5ldC4NCj4+DQo+PiBZZXMsIFBUUCB3b3VsZCBiZSBh
IGhhcmQgdG9waWMuDQo+PiBJbiBhZGRpdGlvbiwgdGhlIFRTTiByZWZlcmVuY2UgYXBwbGljYXRp
b24gSSByZWZlciB0byAgd291bGQgdXNlIHNvY2tldCBvcHRpb24NCj5mb3IgZXhhbXBsZQ0KPj4g
IFNPX1RJTVNTVEFNUElORyBidXQgcnRuZXQgIGRvZXMgbm90IHN1cHBvcnQuIEl0IGFsc28gdXNl
IHZsYW4gdG8NCj5kaWZmZXJlbnRpYXRlIHByaW9yaXR5DQo+PiBmb3IgZGlmZmVyZW50IHN0ZWFt
cyBidXQgcnRuZXQgZG9lcyBub3Qgc3VwcG9ydCB2bGFuLg0KPj4gVFNOIG1heSBtYWtlIHVzZSBv
ZiB0d28gbW9yZSBOSUMgcXVldWVzIHRvIGRpc3BhdGNoIHBhY2tldHMgdG8NCj5ndWFyYW50ZWUg
ZGV0ZXJtaW5pc3RpYw0KPj4gZm9yIGhpZ2hlciBwcmlvcml0eSBwYWNrZXQgYnV0IHJ0bmV0IGRv
IG5vdCBoYXZlIHNjaGVtZSB0byBkbyByZWxhdGVkDQo+bWFwcGluZyBvciBzY2hlZHVsZXIgdG8N
Cj4+IHR3byBtb3JlIHF1ZXVlcy4uLg0KPg0KPlllYWgsIHRoZXJlIGlzIHF1aXRlIGEgYml0IG9m
IGZ1bmRhbWVudGFsIHdvcmsgYWhlYWQgaWYgd2Ugd2FudCB0bw0KPmVuYWJsZSB0aGF0LiBSaWdo
dCBub3csIFJUbmV0IGlzICJhbGwgb3Igbm90aGluZyIgb2YgdGhlIGNhcmQuIERvIHdlDQo+aGF2
ZSBTUi1JT1YgaGVyZSwgYW5kIGNvdWxkIHRoYXQgaGVscD8gSSdtIHRoaW5raW5nIG9mIGhhbmRp
bmcgb3V0IG9ubHkNCj5hIFZGIHRvIGFuIFJUbmV0IGRyaXZlciBhbmQgY29uZmlndXJlIGV2ZXJ5
dGhpbmcgdGhhdCBpcyBuZWVkZWQgdG8gcnVuDQo+dGhhdCBWRiB3aXRoIGRldGVybWluaXN0aWMg
dHJhZmZpYyBvbiB0aGUgUEYgZHVyaW5nIHNldHVwLg0KPg0KPkphbg0KPg0KPi0tDQo+U2llbWVu
cyBBRywgVGVjaG5vbG9neQ0KPkNvbXBldGVuY2UgQ2VudGVyIEVtYmVkZGVkIExpbnV4DQo=
