Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F048D7FC
	for <xenomai@lists.linux.dev>; Wed,  5 Apr 2023 07:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680679675; x=1712215675;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=nya6CZyCLE3vHlZ93WdPuHA2ltR8rz4v90NFvZ2oVWU=;
  b=i186D85d8fpTM8NcpCpGal0ziKRGO3jO4mhpJx4QQjWOGM22HZOk0JBY
   yPcBk++QVK8Us1lpuS1bnvVfXzXxcD3o2suppZvwFllkve6+NXb9e1wJj
   BEYdioUwsMDCuoteUfE8xKCMDzgBavBKvOOqtGdg2m4ssMMsbEznqN/Lk
   fkk2AHZk8tQaM7D9DfJpKOoLGZMo0rOThrkbhEQ09NWROvJUf8V8hvcZz
   0vZpitAunZPX6a6qbfUqePK/RadzSlCM8n5tC/RHGtHz3zWGly616Ep1b
   5L3iFMulAjrciHrtK2wjEceyySsR+0JIHj1qPPC0nDR94LlD0b4Orb671
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="339884584"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="339884584"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 00:27:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="810538910"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="810538910"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 05 Apr 2023 00:27:49 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 5 Apr 2023 00:27:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 5 Apr 2023 00:27:48 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 5 Apr 2023 00:27:48 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 5 Apr 2023 00:27:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kd3XBo3Hr3DZGk5FwUdq3gMaj0g4BftexerwFVrdGEVql0g6y5a4OjXkE9TTURzZXoIHU93MasMEn/yFuMV+/GgRzYY4ks8/HB07MBEYYGEmGsFI1cviBfhfP7qx0HbM48FBaMsNzPxbYToW4pZhqdcoNExWVviuSwRn+dFnhvFzbyD1rb1xtt9XR+9ukL87S1OJuv3/FuFigfFGSgVY3BfRCXhpRq9sLq9/BgOUgbbTC5hoPm/tE4FDP7Y9hylElMHQYYpMirCH/4WKe2D8li6V/LxLq9W7avsbbDA4h4WWFqFdP34AFVfEPvLu1tjqQW+M44gKoQj5lbKKVdl3/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nya6CZyCLE3vHlZ93WdPuHA2ltR8rz4v90NFvZ2oVWU=;
 b=fkNaj15SI0D+NATGZwxd6l3MCweBeMiu3PiY6FdwFWQoLSSUR+9BABrnDAdzcMegq3GMrQE+AfbNkrmt73mf+MWFbjZzYzIC9kcnJ+n/HU8jg7/lVLybezDAQLAnUfIP2SPrOtd5UluaNyQI6omkWJIKCrhlVV6i2EdVWwD8tf1Ju+qEYR9nqFGcGgnkvSClY5Zha3O9Q2FohiUpTSNVsaEZ8zf33aWaIuPgzkh1s4utWdratPfBtthggo0rf32rbOJmzx8GWbP5YbZ03Ejclj4fg25iJ0kXULp0thujxI2WSZ+3MNUZWB3QQfbCtvXE+wkrspdApPkUgCwGSs9+aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by PH7PR11MB6030.namprd11.prod.outlook.com (2603:10b6:510:1d1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 07:27:47 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::e1b2:52d4:e80c:dfac]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::e1b2:52d4:e80c:dfac%6]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 07:27:47 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Xenomai Community Call Minutes - Apr 5, 2023
Thread-Topic: Xenomai Community Call Minutes - Apr 5, 2023
Thread-Index: AdlnkANWXn7Y5J0URMSVZsWsMzinKQ==
Date: Wed, 5 Apr 2023 07:27:46 +0000
Message-ID: <MN2PR11MB4285D1A702ED470B846A9E97F2909@MN2PR11MB4285.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|PH7PR11MB6030:EE_
x-ms-office365-filtering-correlation-id: 5ae17058-67ed-4218-8eca-08db35a740f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ElEkijoutHFm5TfESjUHUg3lNMHUAXWHfybTDxueK1kdWu+HSSUIPh3P5rl1PupGVTmHS2lFRm0C3KrMuqUgvUKUlDTtpvBnWw2ooFSPnY6q7tPNzB9wJHoRSFPiYgGSpHdp+2yTuuNT+jMWavT2huAtsHfZZFN6/C93Eqq3M0JHvyJVdox/dZoS4j8VeJPVH0VxIRKvHFOfOs7BPrM9O7qE2b4ep4+F+e6Ki1TkXtpubxCnbUeLYmhszV33IHt6kBMgl7Pmh7+nkLwG7l3vaPHAmCxjG/vgpbbGhJnZsB0Wi21oWeqEVEAZBc9a/SzpQkwaKyGSWCV8mz1QA69/DNskjdlOkiO2srT6WnprzQEHlhHDXEd1PAQqgccXRki4OiCaZvEjeP3lVtXvFjaOprjdZIFdQ0HXM1GZ8MeYav0LKZVvN67rqKQSNejgq0OhCQOSAcBRee71RFn2ECW3Nyg50I3EnoicxP/elsIbpFEBkkRCkPU+8EMb6mt//V2b6eMDQcMJ3ue11U1ZvhTpV2xYJ0Ciy5zfd22iMW7NLY4YQXHs/R1eOwOszg5wyTxQhY53ZH+t/VmwuG7aVesO7jRKe8BjoXKLwxrDIBxJCCO3ydA647VgyyyGPlZ17a4c
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(39860400002)(136003)(376002)(451199021)(71200400001)(55016003)(83380400001)(5660300002)(9686003)(6506007)(26005)(8936002)(8676002)(316002)(186003)(7696005)(478600001)(66556008)(66946007)(66446008)(66476007)(64756008)(76116006)(6916009)(41300700001)(33656002)(82960400001)(52536014)(2906002)(4744005)(38100700002)(122000001)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzNHQkpzcHNvZFUwMnM4OW5VRzFuRVhLaHpxeGxNQnVtcVA2Z0szT1E1aDFN?=
 =?utf-8?B?R3JaUVR0a1VETC84bmwwOFV3aS8reU5TYVFqN1c3YW1nZzFyVm9qRVNRK0J5?=
 =?utf-8?B?MFlGUkdoTHUxTzhwdFl4Tjc5Y0x3cjlIU1c0ZHR2SWNuMTc2dXFXL1A3N0Zk?=
 =?utf-8?B?M29McmQ5UHFuaVVwOCsvdXNrQ0V1MVlObkNldHhQZUIyVGU1RjkwWGZ1RFQ3?=
 =?utf-8?B?K01sUmFmZEUxZ29UN2N4L2hYUEl4aFdmWHcrbTVaWXJJeHpnVisvbE5EVFYx?=
 =?utf-8?B?anFQSWNkaU9IRER6ZXEzdm1QbEJCUUw5MEZsUmI0NzduSmtXRkdCR2NSY0lO?=
 =?utf-8?B?Sk9FVGlBc3Y5SmkrazV1WkdHSEhmL2RVWm5WZ3JwQnJibmJYVS9UdXlQWHZC?=
 =?utf-8?B?akNiWHFtY2lnRHdmeW9HVzMvT0xVNUh6cU03RDBPR3pGMWRmZ1EvZlV6dE1m?=
 =?utf-8?B?TGtHQXZWY0lsNnM3U2lHS285Z21RZGVmb1ZRTUNDTVdKcmRDVDFYRUs1RitW?=
 =?utf-8?B?ZFVPMlhvdXhWbFkxSWNwWEludUNHcUtKRU1nSWt5S1ZVU0VLY3h0cVc2TkFQ?=
 =?utf-8?B?Y0FCaHBIbW5uMXBHN2wwSGFFMmk5cHlqeDQvK2FTNWR6cmpwRHdOYzJVdGYw?=
 =?utf-8?B?ak8vMjM5c21JZUJETjZ6azFPRkgyenlvSWpJejZtbFB5aXBJWHVOeFQzN2Zu?=
 =?utf-8?B?L1NHaGswelh0Q0VobllDZ0JkSnIzUzcrRDZsb1BvdThJMFU3eDRyTEpzYVQw?=
 =?utf-8?B?a01kOHFTOHQyeWlPbnYyMmdmN2dnVEw0SmFoVTlnamQwWlpmQ05jZXhYVzJh?=
 =?utf-8?B?ZVpOZHRqRVJpTllQcFkrYWw1SC8yWHpWdDhGR0JSTHJpdkRvdC9xL2MrbG92?=
 =?utf-8?B?dGJxOU9VUnlUbnJZSmZuelVxdDRZVEZxTWlLekozRmovWm1ZU05CR1ZoTGtN?=
 =?utf-8?B?K2hNSG14SkF3MXF6d0tqVm9UZ2lrY2Q1QVdoWXhWMFZJaFFXVXNhRWY5SXNG?=
 =?utf-8?B?MkpZc2ovdzJGZ0UxaWJ2MjhGc0Y1MFAwdFFCSUllOEZzY0FwajA4U20yMWFG?=
 =?utf-8?B?NFg3UXlaVG1ScXBSZDl0aU90L2M4VW5tUXBEeFJHWk9BdEVjZXFJSmp5d1Vl?=
 =?utf-8?B?SWp4SW1hQXV2Vm1ITXd0WVVjRHpSYVNUaUYzRitmL1lMNzF4a3V2b1hpU2Z1?=
 =?utf-8?B?MUVQTmE3dHhZdFlxN1NrQ054R3BQdnptUklhem44RHBtbjhualZYejlXUHda?=
 =?utf-8?B?NGpndUpINEVXblVCdFlJL2JsbC95YXlVNVg1T3FXS3Bvc3dQV01UMHNPeWdk?=
 =?utf-8?B?RUdaWmFUWkYxZUJjZXZKU1l5Sk1mSXBmOEEwSzVtTGg3UDJ0UHhsWWNWTG0z?=
 =?utf-8?B?TWVDeS9jNzFtNkViY2Y0MWh2V3E0K2thZTgxdEJtRkoxdkkwYTZkV0ppOGJL?=
 =?utf-8?B?WkRuRVUrZ0xxd01WT3dSNkNzSFp2cWNZSWtjcTJQOTc4UTJIYjJqcXE1SStG?=
 =?utf-8?B?OXFxY0JBT0cvNE9pUGJ0SXg4S3ZXUmc5OXk4V0wwWEY5eUFZdklPbEpMdDJz?=
 =?utf-8?B?ekgxRk5uZUw1RWpVRVBNeWd1Ty9qUnF4Zy9OeWNnU2JwY3JFVzdwOHhMby9H?=
 =?utf-8?B?YVVIeE05S2xWNWZXUENpc1ptbWJRNS94SHIxdGV2bkRZR3J3dDlacTI3ZzBT?=
 =?utf-8?B?enZoZkJzZXVJQUVSc2VVOW9yNyt2YytjdWRxbkxwb3hDRSsrN0l1ZjdkTE9w?=
 =?utf-8?B?ZkxRM1ZlUHhZcXYxbUFMVy9sTTZCYkhyR1RMZXZXbEJTQ25vT3JSZDlqT05o?=
 =?utf-8?B?eldod09kVGZVMzlMNlpRSTRlSkltUW1OdHpDb0xwNGRWblByeXg0VHcvOXVP?=
 =?utf-8?B?T1d0NGRmQk9ES2RCREdUelQvN1pQN2I5V29GUFV0QnZzb1U5cFdKV2FPbkYv?=
 =?utf-8?B?YkFOOFMycnNrN3l5U21mZitnVUpJOXFFWmt5MDRaaDluMzF5UEJpN1dnUzVy?=
 =?utf-8?B?RXg2RXU4aUlsOURlUGx3ZWl6Nk1oU1k4QjRxQnRiZjYvNVYvWWZhLzdUVHIy?=
 =?utf-8?B?Z2VZVEI0QW10YjZZWm10Z2o0TFJ6QWpRUHNyeHhkMWdpTE40MVhzRVEwL09Q?=
 =?utf-8?Q?JOTVGtv5offvEHhcQFt/RKg92?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae17058-67ed-4218-8eca-08db35a740f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2023 07:27:46.8354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x3S4oEszhPMz1N/bw3N960Gy3e8pilcBFCpBBmJ++bvype0FMBnt0JYgQDc3uSSt9U0vZ7APJW78jgQ8f03i8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6030
X-OriginatorOrg: intel.com

QXR0ZW5kZWVzOiBKYW4gS2lzemthLCBSaWNrIFdhbmcsIFJpY2hhcmQgV2VpbmJlcmdlciwgQmV6
ZGVrYSBGbG9yaWFuLCANCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRGF2aWQgT2Jlcmhv
bGxlbnplciwgSG9uZ3poYW4gQ2hlbg0KDQpDb21tdW5pdHkgdXBkYXRlOg0KICAgICAgICAgICAg
ICBLZXJuZWwgSXBpcGUgJiBkb3ZldGFpbCB1cGRhdGVkDQoJS2VybmVsIDYuKiByZWxhdGVkIGlz
c3VlczoNCgkJU3lzdGVtIGhhbmcgd2l0aCB2aXJ0dWFsYm94IG9uIDYuMSAtLWRlYnVnZ2luZw0K
CQlGcmVlc2NhbGUgbmV0IGRyaXZlciBicm9rZW4gb24gNi4zIENJIC0tIHRvZG8NCglQYXRjaGVz
IGZpeGVkOg0KCQlnZGIgYW5kIGludGVycnVwdCByZWxhdGVkDQoJCWV4Y2VwdGlvbiBoYW5kbGlu
ZyBpc3N1ZSBpbiBkb3ZldGFpbA0KCUV2bCB1cGRhdGVkDQoNCg0KUmVnYXJkcw0KDQpIb25nemhh
biBDaGVuDQo=
