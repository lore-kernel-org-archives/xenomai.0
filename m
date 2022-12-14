Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25ED217CB
	for <xenomai@lists.linux.dev>; Wed, 14 Dec 2022 05:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670996815; x=1702532815;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=1tsIkGF1oGqY/pxT/gX3smqgmObmfqsRzY/+qckx1RU=;
  b=X+wNQhhrDIaM7gsDVvvou0ECkodD5DZKTBMfj/Hp2QtNF8K+WR/l707Z
   JUbwVZvxrfk+HlhPhU7MzyZgYh09gDr5SiNorOkHc7BQSClQ7FAcYa0Zl
   rzLfHRyNwLPyAU86SY9HM6OjkN38x9riCidN8/Z6RJXkeKJYZxTFh6yde
   xbHgn7Gf1dwPmqtsLaEhBiPA0IZdjiu42clvRcyIzlDrTIUTdXATrdicl
   mT4sJf0FXT58XNvXvAvfR1j5oalbLDZzMvoZTnI+4pjAp3AuX4H7zQ94K
   EHkzil9g90iBX5x30G1Hqofs2oHbdeeLc5gwQMLAaHmdNIyWqtgPUnTVF
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="301740239"
X-IronPort-AV: E=Sophos;i="5.96,243,1665471600"; 
   d="scan'208";a="301740239"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 21:46:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="773216075"
X-IronPort-AV: E=Sophos;i="5.96,243,1665471600"; 
   d="scan'208";a="773216075"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 13 Dec 2022 21:46:53 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 13 Dec 2022 21:46:52 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 13 Dec 2022 21:46:52 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 13 Dec 2022 21:46:52 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 13 Dec 2022 21:46:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/vWMOaTSI3Oh470lVosCwQdSkeElku3mtORxeGRrQKZtlc36fP2nGSA17XnOIbxTJRTxHIZey3XG+I2afr1cL5xAcB3KR3hU6Eu5kKecVYc+ZJto7IR71EakTCLJuUBfC8mVJJAIsn2tEemn77ez78ywKxagnzZ9KOEmC7hd7tMuoSaX/o/wQQpgC7pP78J8aHOdPHpJiUD7UaNmbJN8RDfiFCeLXakm2coM631fjZYiOxGAV1iKIdeERYRozZIO/PAE5Y/85oyHzYytOZVFyumPR5yk++LUZPPA87K2KlvarlzEgQi7av5slJrrH1cTrvIilpUNGLg+TNwFxj+ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1tsIkGF1oGqY/pxT/gX3smqgmObmfqsRzY/+qckx1RU=;
 b=ijgBq/6uTkeNlWvsPhIJVYGZHNIfNP3FUwVBYo1pUk4pK10SD0+sOfn7VeiSz7ewevEfMeYeB8G9CvariNBtKnK3BXT/Ce0CuH7x5uz/If2L5CiQH/1nc7L32lAkoUNmTetljKTTeKWZslND8jvFVeAlQE9jE+SAy0fnikiiGrap1/Fx98NNh3jkEpv9Bjr3oepbIYcndvqk3r99wFNPcqbEjBQBB9cgP+oS+hqSrE3w4I0ckZkRFtCQOP5iNX7B/Wg++p5wkb1akQJZG2sEMkrAJIGZraQ7I4agj1SheM/juLPBP2SCpqEDIswsZj2jTUpKiU4iacwN8tOLyonbEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 05:46:48 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::27cc:d8ed:9947:fecb]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::27cc:d8ed:9947:fecb%7]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 05:46:48 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: RE: Reminder: Xenomai community call on Wednesday, Dec 14, 2022, UTC
 7:00 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday, Dec 14, 2022, UTC
 7:00 AM
Thread-Index: AQHZD308oTv699yiFkGorIuNzKkLw65s347g
Date: Wed, 14 Dec 2022 05:46:48 +0000
Message-ID: <MN2PR11MB4285F9EB11748D3A3137D919F2E09@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <MN2PR11MB4285BDEEACED1195EAC700D3F2E09@MN2PR11MB4285.namprd11.prod.outlook.com>
 <42c1ea5f-e648-8a00-6a5d-151c8d1550ff@siemens.com>
In-Reply-To: <42c1ea5f-e648-8a00-6a5d-151c8d1550ff@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|PH0PR11MB5013:EE_
x-ms-office365-filtering-correlation-id: 7eee05e5-19af-4279-8e5c-08dadd9697c3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BFSkznvLgWCvtVdiD88JFnLpED7xoeBJIdA9Y+ZIbMSO8bRTJKbf8uh+N9PFaN47As+yeBtWrWOxVGrRqo5/BNJz0lYfQTmYwx20LxLZzD/I44M/x71mmIp43mixj383RlIvXQugk0Dia0EXjM4mnn7TsQh3D3gVhl6Qap8JBgIUaX3H3gv0ol8kbzXwnTBRtkZxEPMmYFNztneAHeYRaBfqronofG0S5rzXWJyj4kdlXDJri6F/zcKab3HgrvI3fVFdJ1TgXdPImeyI9xWLi592Bkhv5YRAFkKxob/wllw8kIE9RwLlPr/iDVcoXvsBK1jR2P52MWkI2DrzW1XhI4/lZKYocJw1XxuuairICOKaMNIhQ25sVXuD+7B8ab2HSsj3sG6l8jhdYSrDygvTHiC+XSj0eEYdHOJxeOxhlXdRkOpv+BO+5e1LOUIGP6cWREjkVQQGXqrB9nelOVYciXOxVcMHJ6wS6wwoNZydiEGIDykw+UFTqUhdz1KHavEKW6BEKfV0jfzHGEK5csCbcX+f/AZJQBwRy7yUaos5MctLHSHKWBgVF3tc3rrcc5i9zNqNdv9B/r3IXwbEBczlKhH+dI7rzptV1IRJp2QhKTIcY4S8eP+xDbPDStIT+aZMII6V9uA4oAavZtVrJi/EY8OerdDvAF1+mvj09M66ddbnfGeP7IY2J9stI6oHPrR1mcKDuy1lkPpnqVdrF9cSMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(366004)(346002)(136003)(396003)(451199015)(55016003)(186003)(122000001)(38100700002)(82960400001)(2906002)(38070700005)(4744005)(5660300002)(66446008)(71200400001)(66556008)(9686003)(33656002)(64756008)(66476007)(26005)(8676002)(86362001)(41300700001)(52536014)(8936002)(478600001)(83380400001)(110136005)(7696005)(6506007)(66946007)(76116006)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cno4bU9BNmRrZk9ic29kYVBrNzV5cW92QzJ2YlVYQ1FWQkZmNmZlbkJDRzFq?=
 =?utf-8?B?YmhmNE9sZGlMYVlteG9tZitFZGY2dmNKb25Xd0Y0RUVXOUNVdW55ZFBJQXB2?=
 =?utf-8?B?Ym1qWFUxd1h1elc0YkpIcFA1UzRDc2RLNDBhSFc3cUpOcVlNMS9VV21TK1Zw?=
 =?utf-8?B?MGxGTjJmdnZIbnIrRStEc3pwdnlZcGl1YlJ2bC9penBYdVJud2h1VGRqa3Zi?=
 =?utf-8?B?UnlsQTF4R1pCZVpmWC9EM0xnL2ZWSWNGRTVrZ0Z3a0pGejJMdDNEWGdjeENU?=
 =?utf-8?B?RlNTaGFRMWxUVk9ud3NJUnN2eHF6dVlaSVNENVNJZ0ZpZDMzTzBicmdGUDZ5?=
 =?utf-8?B?akJVVWdCN2dOS0ZXaFlDWlV2RjcvZDhuSjBuRERFdjlXUkppenRpZ1hrS0gv?=
 =?utf-8?B?WUxhUjZ6RFcyUHhSK2J6ZTNKOTV5MENsMDhUNEI4Mk16ZU1Wc3J3eENFWFpL?=
 =?utf-8?B?WDgza3ExRjFINHBFdU5XbUVtMHIwbDBSdkhXOFVrTjdGcGtrRVRQUmFWZkpy?=
 =?utf-8?B?UytUWEtIUmtnd3FVT0p1N3czdWVrYkI4KzlwTTdYb0FEWnZVcGRGMHZFZmo2?=
 =?utf-8?B?c2FoRGVFMlltYUp0ZmpsbUY0Wm95ZHpJeWd6Z2dkc3ZiOEVZY2duRld1b09i?=
 =?utf-8?B?Ylp0UU84S3BWdUlVUmIwVWVwVS91eDNHeE12ZDVzSkRxaUNxNTAwN09wZG1y?=
 =?utf-8?B?UW5EVm40RDBKV3kxTlVCQzRuWDdhYjhXdXVMaSs0MXFKRjFURWlPMDNHelpB?=
 =?utf-8?B?aUp0dVlIQzlnK2pCUkxLTzBGNFIwQjRJcEJCUWp5SXR5L2NSL3J0OGlOSGJt?=
 =?utf-8?B?NDlSTXA5UURreWZpa1RlUlNxc1o2SXk4L3lFcU1KeGhqRzk1dnFJYVRvaTEr?=
 =?utf-8?B?L3N0SE9SanZIZjFnUGlLRmlGOHZZRmhTcXpuYk1LUGtaMVVUU2ZEa3lNcHZR?=
 =?utf-8?B?bDNSeEtYYW5ZR3FLejUzY2pTNGVYUEhOcXJmTkYxeUN4K0dJL3Z4LzJsZ1kw?=
 =?utf-8?B?TXFCekNJSml0eHREdDJzSGl6bzY2YkhvWjEzcDlRNzZScko4SEVnTG4rVExm?=
 =?utf-8?B?b1JVbUlndDNnM0hCRFJlN25DTktvcmFWV1pmRzAxVDFUV0dRaVJqaTBQWkdR?=
 =?utf-8?B?UDZSQVR3djlOeVVlTVM1S1BUeEpNVER2M0JQWFhLUmtuYkZvd1cxeWZmMWZx?=
 =?utf-8?B?SkRHdnV0NmFVaHRrNVVNeURkMG9mQ3ovNDF6VEljVjhwTGRGRVlMU1ZpYnhl?=
 =?utf-8?B?SDQwZ0k5Yk9Yb1NpWWRoYm1WUE9FU0R5Y0pIQmpoRkpRZSt0WlcyRHZwazYr?=
 =?utf-8?B?UEY1bTh0K09pbVRlZGRCdC9iL2pvRGJxbTRCWm1YSVpXNkR3d29vcVlhQzR4?=
 =?utf-8?B?Qit4WHFtSTdtVVdBdVJIRDVQRHl3bVptald3NFdXSGFmMUdVc0JuUk10VUVI?=
 =?utf-8?B?SnJHSklDVytUNHQ1YjF0RWhMcC8vRmlNazFOKzRSNWxYcVg5dkdPSkFQdC9N?=
 =?utf-8?B?SCswN0FPK0NMdTJqRUhoMGJ2dE13allyVXNtUytoakJ1QUZTRi9nemMwaHN6?=
 =?utf-8?B?SWhFMytHbWhHaXFIRXVlNWFSak4ybGFQb1F1RDRPMllBR3VKQ0MrRDZWcFJB?=
 =?utf-8?B?UVVoaGo4dGtIVUY5VmpZbkNZdUV6UTFZOFRKZjk3VFUrb1pPUXF6QWs2QWlo?=
 =?utf-8?B?UHozOUI0VVVldWNXMFFzZHYzRmFOeG04QjhHYUptckowUE05aUZSVzJqMnF0?=
 =?utf-8?B?aG1ycFpCbnJGM2wxaVEwZ3NyakFGYVRQY2lLR0M1ekRJUVNsaEJIZXg5RW16?=
 =?utf-8?B?K0xPT0hiWnZnNERFUzNaalhkUzB6blJjNDRuZG1PQzljamNKSytUd3NlaGJB?=
 =?utf-8?B?NXhBaTJRNGlMeFdSRVpTTDR5aHlWRm5kcm1KZlRnY1Nkai8rS1hvbFRoQmFm?=
 =?utf-8?B?S3MrTWxMSXNwSndYVk5yVWdQR0NiRDBwQkQvcGRmNmdqNVE5K1BwUVplVFd4?=
 =?utf-8?B?K3RKbTJpSGh5c3pIM2lydDM5ZDVPOXNuZ1pvcldIZkQ3dHdLMzBwWWFBdjRZ?=
 =?utf-8?B?Vk5LM3ZXYWdaRGpoNTNMdVJpVDZVYkppd1hMcnFkSUJuajc5WmljVDljRUoy?=
 =?utf-8?Q?8H5Th6muR7Ryz9b9aqsk+ebu9?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eee05e5-19af-4279-8e5c-08dadd9697c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2022 05:46:48.7198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Y0RtkLsnHU+t7HXgO0ZOm6nOHuLYSvfaXlTqS85IGzJ6iI4lwaYMjyUanTW1Y4XFUDEJ2WWdDYCCJm8OYqELA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5013
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEphbiBLaXN6a2EgPGphbi5r
aXN6a2FAc2llbWVucy5jb20+DQo+U2VudDogV2VkbmVzZGF5LCBEZWNlbWJlciAxNCwgMjAyMiAx
OjMwIFBNDQo+VG86IENoZW4sIEhvbmd6aGFuIDxob25nemhhbi5jaGVuQGludGVsLmNvbT47IHhl
bm9tYWlAbGlzdHMubGludXguZGV2DQo+U3ViamVjdDogUmU6IFJlbWluZGVyOiBYZW5vbWFpIGNv
bW11bml0eSBjYWxsIG9uIFdlZG5lc2RheSwgRGVjIDE0LCAyMDIyLA0KPlVUQyA3OjAwIEFNDQo+
DQo+T24gMTQuMTIuMjIgMDM6MzEsIENoZW4sIEhvbmd6aGFuIHdyb3RlOg0KPj4gV2UgaGF2ZSB0
aGUgWGVub21haSBjb21tdW5pdHkgY2FsbCB0b2RheS4NCj4+DQo+PiBUb3BpY3MgbWF5IGluY2x1
ZGUgYnV0IGFyZSBub3QgbGltaXRlZCB0byB1cHN0cmVhbS9kb3duc3RyZWFtIHByb2plY3QNCj4+
IHBsYW5zLCBzdGF0dXMgdXBkYXRlcywgYW5kIHRlY2huaWNhbCBkaXNjdXNzaW9ucy4gSXQncyBh
biBvcGVuIG9ubGluZQ0KPj4gbWVldGluZyB0aGF0IGFueW9uZSBjYW4gam9pbiBhbmQgYXNrIHF1
ZXN0aW9ucy4NCj4+DQo+PiBUaW1lOg0KPj4gV2VkbmVzZGF5LCBEZWMgMTQsIDIwMjIsIFVUQyA3
OjAwIEFNDQo+PiBQYXJpcywgRnJhbmNlIENFU1QgODowMCBBTQ0KPj4gQ2hpbmEgQ1NUIDM6MDAg
UE0NCj4+DQo+DQo+U29ycnksIGZvcmdvdCB0byBpbmZvcm0geW91IHRoYXQgSSB3b24ndCBiZSBh
dmFpbGFibGUgdG9kYXkuIEFsc28gaW4gdHdvDQo+d2Vla3MgKGhvbGlkYXkgc2Vhc29uKS4NCg0K
Tm8gcHJvYmxlbS4gIExldCB1cyBjYW5jZWwgdGhlc2UgdHdvIG1lZXRpbmdzIGluY2x1ZGluZyB0
b2RheS4NCg0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQo+DQo+SmFuDQo+DQo+LS0NCj5TaWVt
ZW5zIEFHLCBUZWNobm9sb2d5DQo+Q29tcGV0ZW5jZSBDZW50ZXIgRW1iZWRkZWQgTGludXgNCj4N
Cg0K
