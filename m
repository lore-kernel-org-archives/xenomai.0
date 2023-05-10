Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2042.outbound.protection.outlook.com [40.107.20.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15082F37
	for <xenomai@lists.linux.dev>; Wed, 10 May 2023 08:19:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W65K2JupqDXcMkO7kPMKgnP8gKw4L6VwzSVheGNXbqzSJn3/dcjAGlMxj4g+RE9w5mefio8qKKuS+pYqwPuGkQ9UzqGahY0nX02wkENonX6Lhg8tm9zoJojY/dvxtuSJtYrPbAMuLF0kHQlc42ySgk4vRZWy0Okf2qfbolTITLNean+KcyyyrSpkfE0pBKdWVa0HWMfqk1gyaT961Un+8K7IGmQVxT/Mn7Y9oTp31G1o5WFq/KR/T8plk1/bKB5xEmyY21Ahh3asjN3pSp7QNjIBnIKTN/Oj2ZKk03iiL/wid1yB33/4ZGhjTtBKVcGw7UbC2gyOVK1iFdkPtS8QJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6R+k6Ka5qHS5LzUOAShIWOm2WrXuLWXemt7MOIAK7g=;
 b=RoPiFVLO6i494XGV/jQH7Lr6zIWsfmI6hDZg9sEYDOltq8WJfX/2LBXZq7zrXjw/QnXvm3zVkYvLRvX22zNOWNi0vfLGkLNs4Y8umOmAcFNkfwCckuw++AkDGpWxtygq62jfVwxma8rbGbyvptpHPVZZE+3IpD2m2Icp8G35lwqfSjxtDsdZKdIm3NnwerN34hyUyhTiksQytX7fMYdKcFBhd8j/TRcsxgM7pynEPFUAHJQzRk0dZ1Hgonh7ROsDp0WmNKxhXlS15U6h6R1Qe5Uwi+xzY+DMboq3luaGAoP0b7OsLVWqcVEf3g2XgMVHVfCbDHPMcWBkLyzcuFyGBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=boschrexroth.nl; dmarc=pass action=none
 header.from=boschrexroth.nl; dkim=pass header.d=boschrexroth.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=boschrexroth.nl;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6R+k6Ka5qHS5LzUOAShIWOm2WrXuLWXemt7MOIAK7g=;
 b=dok0c5sKGvEPmxo9s+mQgmVpvoFZMHjeIOTg3I0XqjTKw486OfZU1a8yCR1kvpdV4LQgmGWe+BsBWkiwZtoz6rEp27ChuBy27JNc3Ax5ar2Gr/IC+IfJvLit90id9E5fqjdngZTOhrfBxS/n80JApIn9BtUgC4iqbOxrzP1/xGA=
Received: from DB7PR10MB2459.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4f::29)
 by AS4PR10MB5197.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4b0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Wed, 10 May
 2023 08:19:53 +0000
Received: from DB7PR10MB2459.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b80:4de6:1500:d046]) by DB7PR10MB2459.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b80:4de6:1500:d046%4]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 08:19:53 +0000
From: "Schuman Eelco (DC-AE/ESW5)" <Eelco.Schuman@boschrexroth.nl>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: Question about a freeze under Xenomai 3.2.1
Thread-Topic: Question about a freeze under Xenomai 3.2.1
Thread-Index:
 AQHZfcVBA4GbIQ1h1EaRVS4jgWLnyq9Io4gAgAF67QCAAAxjAIAAAr0AgAAJPoCAAA4CgIAA/JuQgABr+ACABQHqgIAChQfQ
Date: Wed, 10 May 2023 08:19:53 +0000
Message-ID:
 <DB7PR10MB245939B8B568AFB4C7688959EC779@DB7PR10MB2459.EURPRD10.PROD.OUTLOOK.COM>
References: <5a8afa1e-d6d7-df9f-2895-6832ffa9673f@smile.fr>
 <189dee91-923f-131a-ccae-0afcccd06107@siemens.com>
 <7dfbe0c0-161f-0977-4332-75575f1a17ce@smile.fr>
 <9a48d273-5ebd-f557-7941-8532b7ec4b67@siemens.com>
 <5523da9b-bb44-a1be-9e54-bcad21867eb6@smile.fr>
 <CALLqZ8TeAeeu++UP499YS_XPwVYw05eMEYf-K7HPmyhXHBoACg@mail.gmail.com>
 <0e065176-74b8-b02a-29c2-30eb34a79cdb@smile.fr>
 <DB7PR10MB2459812A2291AB88A99ECBB5EC729@DB7PR10MB2459.EURPRD10.PROD.OUTLOOK.COM>
 <8060f103-6222-6df9-d478-bbac2b8807d9@siemens.com>
 <6814fa90-015e-91df-6941-db643e4d4229@smile.fr>
In-Reply-To: <6814fa90-015e-91df-6941-db643e4d4229@smile.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=boschrexroth.nl;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR10MB2459:EE_|AS4PR10MB5197:EE_
x-ms-office365-filtering-correlation-id: 03ce9258-04a4-434d-c496-08db512f553c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 9fO+CwA0qP80tp3hsGT4j+uEVdUf1paZa4XsYP905nHO7WMxSdXgy3dc6ASpViqVDpWWFyOY5Z5NexfNV4if00CwQc7klrray26oVGmQcoxqP8jVl/u9ANV+/mqMSJqF+3rJs+WK4eJ+Wxk6YODgy6iNSiDuQxyJjyTMxw4fzhxPhPfIW5hQk//Oe+EPh1XYR2IHzcRgs+JoJDIJlAlLsB8GO0GkmdHZaeqrJ80Z+ZyeVpmvzWKRh7ZTDcYtD0RbBvIrRy+Neu6OVaCZRIkzDta+b4M93I84zruDCOoM3l+P9ZkUNO+W8awn/g7m7tJYPazwoNinhvE62mnaenN6ezHwiyQ/aSFl8/LdcCFD/NI0Rlt+nRjo/OZFDoedMj+L06JEnIBP41RS/wBrcJhoOicoceHIdLm0favzI6lXZKS1o4nWeHMFWOfkufzi6nWTuwg5x6TpfJpIVI33ib3+K/9N21QHOXKAp47qwcO8MU0MUBh5l7kJVcURKrCwwiyk6/e69bcl3qbBskw9GJ2/1PVRvrirDFCgQpnUn4xG8Q1/UDuDs/gwuAqtyJUBrRk9t2ODKaCMf8suCINUWCdepsMHASBXGmATuVCPjFHIMPMyhf/sVnpwKX+s28Dd2HW4
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2459.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(451199021)(478600001)(66476007)(76116006)(7696005)(6916009)(64756008)(71200400001)(66946007)(316002)(66446008)(66556008)(33656002)(86362001)(83380400001)(6506007)(26005)(9686003)(5660300002)(2906002)(8936002)(55016003)(8676002)(52536014)(122000001)(38100700002)(186003)(82960400001)(38070700005)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U1duazNUQUg3eDVacWUxcVRtalFKeElISmg2NVE3d3QraWxGckNlUk5rZWJP?=
 =?utf-8?B?bzZ6WDUzVXNzK20yTHp6YUJwL2ljNXJtdGQ5cUM1NWlvdFBMcVAzNTFUS2w2?=
 =?utf-8?B?d3piSjY1VWNJc2lFV2x4NTFGa1QxanMwQ3hIK3RUSVRaNW01OVROOCt6UjVP?=
 =?utf-8?B?YkEzNW1SNXVuaUZnWndhZE11UEc0bFdHZG5YSEtsVzJ0SGdFZkQvdDhRR0Ew?=
 =?utf-8?B?SEFnL0tydFZyOFBWVFZQem40cTRnTHpacUZSNy92VnRuYUtXcXlMelA0TXV5?=
 =?utf-8?B?LzVZWkJXK0hjaUdhaGQwMmtHd3pXREJqTFBkTWtpVFFXb3AxMlZvZWhzUGI1?=
 =?utf-8?B?UGxnOWFPTUxuN3p6cXFES0xHcTBMQUpnOVREeTRpbUNvK1BLaEl2c05ibmtW?=
 =?utf-8?B?SHNCOC9ZSjhEbTI1TTd6N3lqcjlnYUF5NnJ1YnExUHdEK3RMc0h1S3BucWV6?=
 =?utf-8?B?bmZEVUVCUWRhamlab0wrZzl3UWl4N1ByMEtLWUNkLzdtOXlxMFlHL3JYVkt3?=
 =?utf-8?B?eFNBL3o2WE5pSW1oaHBEMTFmb3BTWXZFazBKODlUZHdhQ1JqQWZQK09ud3Zp?=
 =?utf-8?B?WU9kOUY1dzBRZTBXMjVXTkJ3SHYyNnAwdFV3RWQ5OE1vaVA4VDYrKys2ZmUx?=
 =?utf-8?B?bU8yY1VIakc5bm41bGJLdlJ6QTlwc2o2L3h4eTl5QjF5SnFCR2VhRkltZjFk?=
 =?utf-8?B?R0dIazlKN3ZQcGZLSVRadmVTOFVENUtUd1V2bHJ4RnNTYm45aGxHUlljaUNY?=
 =?utf-8?B?eHJvNENpMzRvMFV1QzNjelZBSitxem1ZVENYRFVuN1lvVUc1TjJ5ZXFvenR6?=
 =?utf-8?B?empjbmJXOW8wekZVeDJURWFiTjAzQnNvMURCZUs1VXlMak43Wk5RYnVxdjJW?=
 =?utf-8?B?TFQ5alVLN3ZzbGZYU0dXbnNQZTlvSzR0R01iWFE3SmtiSUNjQUoxWlNuQXZH?=
 =?utf-8?B?S0o4bkJHKzFTdjdCRWRCa3JUUXErTVNMMHQ4RDFCUkhHQU1ab3JMVmRNU1NL?=
 =?utf-8?B?dy9iWC9nd0lmNklCR3luUW5SdlBpeXduRVdURXVHb04ydU9Ja2hMdmVSM29Q?=
 =?utf-8?B?SVRVa1dVREloYXllb3FJWTh2YWNpeUVUQlM3cjJheUJ1a2pDVTB1WXo5Q08v?=
 =?utf-8?B?QTNuWCtsSlkxOVN0QUdLV1hsZmVkcG1iNHgxVUtqOUZlaDlJc2tNVEFjL1po?=
 =?utf-8?B?b0VCYUR1OVR6aWsvODFCZlQ0bjB2REpLMmdOeE9nUk03WG5rVVpmSEhhUzJu?=
 =?utf-8?B?RkJscmxDMW5hekptNUs5SjcwRmFUQys3d0dEMlE0b0I3Q2daUWt6UVpnU3Zr?=
 =?utf-8?B?WERoNFgxTGVuZm9hVmNLNzV2YnQvdFN1NWNaSXpwQjZDWXM3SW5Fdm1QWFdt?=
 =?utf-8?B?RytSRmJRZVdWSDgwaWNNdWt5NzVxRE9EVGJ5bnFQMG0xdkdpQkhrOVdBd1NY?=
 =?utf-8?B?d2RMTTVlcVFWalNxclRzazhhK3ZQZjcrUC9lb3ZEd1lqZURXWERReGVFZjJO?=
 =?utf-8?B?eE8wUUtvQUk1QlNTQm14V0cvVXc2Y1RWbldEOEZuNjlPUVFNeDQwODRuT2lS?=
 =?utf-8?B?S3M1Vk95N1ZjNmxPWVVCVVFFS3NxdHRKMVFHRkZmd3dmVVUzaGlRTlZIV0tn?=
 =?utf-8?B?Q1ZVRE1kRFNZeUl2WTFqdEZCNlIvSXNVVDdKVFgvNEhsdlN3MWhScGllZkFi?=
 =?utf-8?B?d0RYZUFoU1Z5MldySTVGR0d5d2d4NVJDNDlEMFhKRDl2QkJwMGcyNThhejVZ?=
 =?utf-8?B?V2RHYXE0bmxyK042SzFYb1NTTENEY2ZXcGpIYXlQK2xHYjRMVWUxWWsxRFR6?=
 =?utf-8?B?L3QyRm45YVNVK285N2ptYU1hWFlrdjJsMDVzM1FmUmRmWjArOGxoMkdXM0Vu?=
 =?utf-8?B?c290QytNZ29PT1NveWk2QVNVbTBLUW03KytoQ3I5ZU5yWEo0N1VtQnRFK0pF?=
 =?utf-8?B?bi9VeTVzOENuL1l4ZGdDWXRlanhxUHlTbG5HRU1rTWtPUkJyYnNSNGdTWFUz?=
 =?utf-8?B?WE5sRW04R2ovWWdlOGZ5T0ozWlNrVGhjczh3ajR6ZHdYdHozVXdHTFU3a1lK?=
 =?utf-8?B?YjhQS2M2bUxUeFlYc0xaeHRrQzI2eWJvODBEOHphNnREV2RKRHdIYVpjNFhw?=
 =?utf-8?Q?7E7w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: boschrexroth.nl
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2459.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ce9258-04a4-434d-c496-08db512f553c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 08:19:53.8042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LxJtjRrriaPgVW+FQCW8Hqor4e9SrcQfkTFsXFNAa8h3yOIHL0loA/a5BT3RoX1OC1wtnszlQX2jj5Kg+E7Rhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5197

DQpIaSwNCg0KPldpdGggeW91ciBzdWdnZXN0aW9ucyBJIGZpbmFsbHkgaGFkIGEgd29ya2luZyBz
ZXR1cCB3aXRoIFNNUDoNCg0KPlRoZSBjdWxwcml0IHNob3duIGl0c2VsZiB3aGVuIEkgcHJpbnRl
ZCB0aGUgb3JpZ2luYWwgdGltZXIgdGhhdCBpcyANCj5wcm94aWVkIGJ5IHRoZSB0aW1lcl9wcm94
eSwNCg0KPk9uIHRoZSBub24tU01QIGtlcm5lbCB0aGUgdGltZXIgaXMgc2V0IHRvICJhcm1fZ2xv
YmFsX3RpbWVyIiwgd2hpbGUgb24gU01QIGl0IHdhcyBzZXQgdG8gImxvY2FsX3RpbWVyIiA6DQoN
Cg0KPiBGcm9tIHdoYXQgSSB1bmRlcnN0b29kLCB0aGVyZSBpcyBvbmUgdGltZXIgcGVyIENQVSAs
IHdoaWxlIHRoZSANCj5hcm1fZ2xvYmFsX3RpbWVyIGlzIGdsb2JhbCB0byB0aGUgc3lzdGVtLg0K
DQo+RGlnZ2luZyBhIGxpdHRsZSBtb3JlLCBJIGZvdW5kIG91dCB0aGF0IHRoZSBsb2NhbF90aW1l
ciB3YXMgaW1wbGVtZW50ZWQgDQo+YnkgdGhlICJzY3V0aW1lciIgb24gdGhlIHp5bnE3MDAwIHBs
YXRmb3JtLg0KPkFzIGEgZmlyc3QgYXBwcm9hY2gsIEkganVzdCBkaXNhYmxlZCB0aGlzIHRpbWVy
IGluIHRoZSBEVFMuDQo+DQo+V2l0aCB0aGF0IHRoZSBwcm94eSBvcmlnaW5hbCBjbG9jayBpcyBu
b3cgYXJtX2dsb2NhbF90aW1lciBmb3IgYm90aCBDUFUgDQo+YW5kIGl0IHdvcmsuDQoNCj5Ib3dl
dmVyLi4uLiBJIGhhdmUgYSBiYWQgZmVlbGluZyBhYm91dCB0aGlzLCBpdCBsb29rIGxpa2UgSSBk
aWQgbm90IGdvIA0KPmRvd24gdG8gdGhlIHJlYWwgaXNzdWUgd2hpY2ggaXMgdGhhdCB0aGUgc2N1
dGltZXIgZG9lcyBub3QgZ2VuZXJhdGUgDQo+dGltZXIgZXZlbnRzIGFzIGl0IHNob3VsZC4NCg0K
SSBkaXNhYmxlZCBvbmx5IHRoZSBnZW5lcmF0aW9uIG9mIGNsb2NrZXZlbnRzIGZvciB0aGUgZGVm
YXVsdCB0aW1lciAoIGFyY2gvYXJtL2tlcm5lbC9zbXBfdHdkLmMgKS4gQm90aCB0aW1lcnMgYXJl
IHJ1bm5pbmcgYnV0IHRoZSBnbG9iYWwgdGltZXIgaXMgbm93IHVzZWQgZm9yIHRoZSBjbG9ja2V2
ZW50cy4gSSdtIG5vdCBzdXJlIGlmIHRoaXMgaXMgdGhlIGJlc3Qgc29sdXRpb24gb3IgIGlmIGl0
IGhhcyBhbiBpbXBhY3Qgb24gcGVyZm9ybWFuY2UuIA0KDQpzdGF0aWMgdm9pZCB0d2RfdGltZXJf
c2V0dXAodm9pZCkNCnsNCglzdHJ1Y3QgY2xvY2tfZXZlbnRfZGV2aWNlICpjbGsgPSByYXdfY3B1
X3B0cih0d2RfZXZ0KTsNCglpbnQgY3B1ID0gc21wX3Byb2Nlc3Nvcl9pZCgpOw0KLi4uDQouLi4N
CgkvL2Nsb2NrZXZlbnRzX2NvbmZpZ19hbmRfcmVnaXN0ZXIoY2xrLCB0d2RfdGltZXJfcmF0ZSwg
ICAgICAgICAgICAgICAgZG8gbm90IHVzZSB0aGlzIHRpbWVyIGZvciBjbG9ja2V2ZW50cw0KCS8v
CQkJCTB4ZiwgMHhmZmZmZmZmZik7DQoJZW5hYmxlX3BlcmNwdV9pcnEoY2xrLT5pcnEsIDApOw0K
fQ0KDQpUaGlzIGlzIHdpdGggbGludXgtdjUuMTAuMTUzLWRvdmV0YWlsMS4NCg0KRWVsY28gU2No
dW1hbg0K
