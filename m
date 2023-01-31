Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79751640
	for <xenomai@lists.linux.dev>; Tue, 31 Jan 2023 05:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675141869; x=1706677869;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=6DUvrYOTrEoR6RqNREwo2m/r+omZreI8hBeNVsxI07o=;
  b=idEAvqUGo4wEUM29Fn/6Tm5yfQUTQqLQ5mNj9SslqtIIWvTcKyK9LtnF
   NP9BRyPNR5dmRmQzTLUoAzH7Kdlcyn6EHU1wDWEQ/eOGyEOc3yvv0XQci
   47gGjvnjZ7wXTkTaWd0GNcqA/tHl7m5an1BeEsx0TjXo0gZ71bJxyBxoI
   sZJxpnd3KBm+m4CfUJvHk5JI5E6v0P53hUWL64F8AXi3WFP3t7d6kjWip
   nnVkk90u54xycWpp5sbz5f7g54B/qpFP88s+/FDrlLTDhCql/e5y8O+Z9
   faVyWmsi8/nb+h4XoVLV2dG4nc/syNN+cz7nfeipxRqnp/AxWYa30J155
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="413969800"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="413969800"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 21:11:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="772819117"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="772819117"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 30 Jan 2023 21:11:00 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 21:11:00 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 21:10:59 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 30 Jan 2023 21:10:59 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 30 Jan 2023 21:10:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHC2GyO8qHRFf/jum1dWYcDOdZRSsuBdmm9gM5SQrmwiy11JXeq2/w5pARA8jvmM8U4nwwZEk1ex88jQZte6Qa2MO4c/Sm9rfnNxSg5zIt3nmz2g9EBMhRVfQHQR2bBhD8Iu9VmTwZPljV7PFp47w2dRoPXAZKHnBFcStKTxzn0ma7o6G8PX9n61nvCV+gnsD/iNHLgKPJqVZ/ekHNx2pYySjyoj0745BaRqrsllvWgdOMaxUzjN1bjQasoJwNJ5vyREFwTl8Xw/Myfup4On22crJH6YyT1UWIMSKzyIQnpuxbRUnOYhqTqt70kpCwlcBTX9xXbTaVTaZRL+M/yicQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DUvrYOTrEoR6RqNREwo2m/r+omZreI8hBeNVsxI07o=;
 b=Vme+xU2+07m9sKhqWwg7LSP0Nt6XWgGLuGk0RTDdBgk1wb/vdCTkoABX2kFGX61hT7vGlOdiN1XksYk1j/Zz/SnHOOBvTwt3lnQ/UDozOaZsL4NH+f9uOLJPzFAtDlMVoC+YwDhps/Cz3P5+lfcu60y80PHkO6canWTmm2AHNzFgAvzwWlp3NS1U+xUMeY/LTAsDb7ug+sFybA3B7CH3LhCI8LT8lIAkjyNFHtd0NsbUaqgMPxKdguMUNrxb80YUr+dTJDsB9f7dbDen1Le2rXsaoY0QGB6vFbNR34QFTvOCXiW9An4FL64cyoM+wpAC8HX9H0KVBiclvh2Kj/0mCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BY5PR11MB4276.namprd11.prod.outlook.com (2603:10b6:a03:1b9::27)
 by SA2PR11MB4826.namprd11.prod.outlook.com (2603:10b6:806:11c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 05:10:55 +0000
Received: from BY5PR11MB4276.namprd11.prod.outlook.com
 ([fe80::8c2e:9f4e:fc9d:c2eb]) by BY5PR11MB4276.namprd11.prod.outlook.com
 ([fe80::8c2e:9f4e:fc9d:c2eb%3]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 05:10:55 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: RE: [PATCH] testsuite: dpdk: Add l2fwd example which is based on
 DPDK.
Thread-Topic: [PATCH] testsuite: dpdk: Add l2fwd example which is based on
 DPDK.
Thread-Index: AQHZK0DxJO+BJi7tF0a0zXL5lPUFWq6kclGAgBOXzvA=
Date: Tue, 31 Jan 2023 05:10:55 +0000
Message-ID: <BY5PR11MB427681AA9D23FEFA04E1748CF2D09@BY5PR11MB4276.namprd11.prod.outlook.com>
References: <20230118130506.30418-1-hongzhan.chen@intel.com>
 <2893142d-70c7-eb2b-89ad-f2a7154f5eed@siemens.com>
In-Reply-To: <2893142d-70c7-eb2b-89ad-f2a7154f5eed@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR11MB4276:EE_|SA2PR11MB4826:EE_
x-ms-office365-filtering-correlation-id: df2c8393-e1dd-4406-98aa-08db0349881b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +5pdsIJSA8Cha/t3UGfLbgh0vbUIdEJG1cQ5cmPnRcZ0xTD4LhGP9Qh1OLZ90EDv+CVHjxTJ5evO3CDqS0YOzItXi3QPreOzy4pLa+SfJEUQX/gz/2Q5nB+j8rUKd3q0CV3P+KgqZrrEIWDjHduo4RvH1DpzYKNaPkCJhyX97IFNWEEi8bI5j5Qs+QiKhY02Zmhow2BogkDczo+FhUwYc/qGMCtaDoV4kbu+t+qrUwGU4UxJzK+plCajoJRZXPNO53b+mM5XaXDFZCUKgNohdTOm357+qg3QS5K/S/DWM/vBh2FhrPTT1hN0m/FD1DQfdvzuPi2quSUwQ0/M6GKxhM6MMYXFNEpBhOy+D3Vxw4tDN86LI/vYGnkt6QlT5fmT2Hv9EESZtvxZIsKQ6aPi9YA5Bc3h/A22vh6gxqowUyGvQ7Y26Av0cOr99BfuGrgIbD0S8pdTaeGQD+YzixcW0ZbdlGdH6ZnfNMwkpTE0Lfjs8uLwlG4B/GPXO48DR8LUtu8RFuIQhtYmJXl294htYvBFHIpaU1qfvXOzZgmNSl5u9TDNHLMZA65gOIhYE/rLiXzHiiXfRslqnWIJZjkaJD5cJuZjNWEsnTtS9wGfcoNJkP1mZDVQYRIy0xCuI4ZpdqMLFSXxyNMjUs17m5w/wwfv9JxslppMM3rmwAG4W41A9HlJBxcmurTdHzrffXgRxFL1LvLe5/ZbrqDtVbFN21aT3QZ5R79ci8CbNwdoSJ6OgBOzvg3pWVo1WwDcPszNF4a0PZkWLA7Vhl63INq6EQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(136003)(376002)(39860400002)(366004)(451199018)(86362001)(33656002)(38070700005)(122000001)(38100700002)(82960400001)(41300700001)(8936002)(5660300002)(52536014)(110136005)(316002)(66946007)(66476007)(66556008)(64756008)(66446008)(8676002)(76116006)(55016003)(2906002)(83380400001)(7696005)(478600001)(71200400001)(6506007)(186003)(9686003)(26005)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RG1QNXRPb0ZLck9NdW5QQzBwNHBJQ1IyU1JHdG5xMGpQVWJWVmw2N3FlS0xj?=
 =?utf-8?B?eGt1dEtoMSt1eG5NcSs5U3UyMUlJTXFDK3VqeDI5N0xQMTJqQmZyZFhyd3hN?=
 =?utf-8?B?VzkrdVBiU3dJYlN3NVJMa0hLdG5NQlFmZTZ3R0JmYzVBL1A3UXRNaHg3dUwv?=
 =?utf-8?B?eG5ld3MwUGhDM3lENTRPWVJ6eXBtLzhpUWxTQzQ5YzNVZ004bGxKRUxZV0Uy?=
 =?utf-8?B?ejZZMzUwaUtPcWNnR0hYa29wbXFYWG81OHRXWmJtUm5YWVBzSkRmSTh5MGFL?=
 =?utf-8?B?N2JvdUs4ZnpiZElXUlp0WUc0Tk1iaFZoQVpqWUZXQnR2cXk5M1hXRlp5Q0RB?=
 =?utf-8?B?LzdPbkJ1WGJ4VTE5YUFCN0xUN252c09HTUl0NEZjUjNEYm1tZlZRTFkxWUFu?=
 =?utf-8?B?K0ZNSjkrL0J5TjUva05EallCQ01kMVU2dzFBbnAxQXRSMDlpVVJid2FpWFgx?=
 =?utf-8?B?RDl3bUozaGRkTDl6ZHZqSk50LzJzd2xlUXhhaW14Zk11WUh5Q3BKNmxlTThj?=
 =?utf-8?B?anY2Y2VVUitYQnQ1UFVCbEZuMTY5aW12SFRLeTJPMVR1ZThzUUlxcUNqZXhG?=
 =?utf-8?B?Z1hUTWZobXdIZEhzTk9hSHFsTkpZVnJ6Ty9qaG9mSnFIaWJKQUlzczFGV2Nv?=
 =?utf-8?B?QXlFZ0haNmhrOXhrcWNnWE9CbWUwaG9POWxIbk9aY29yUzd3NVZnMWVhUExJ?=
 =?utf-8?B?RFkyNDExSkJvS1N4bTEyUGJwd1hIaXRwTEVNOEdjNFA5TTNESklYK0dmaWgr?=
 =?utf-8?B?V0xBQm1qS1M0YzhhT21wMmNDWS9MYUZEWFpzUTNkWDdlTFM0ejVWT29HRVZO?=
 =?utf-8?B?amZHYVNDdkFNMGliRmtaUDRuOHFnMmN1Z2xWRHRHQ25oNUphSFhFSU9RMHlD?=
 =?utf-8?B?ZThkNTVrZkxyUXRSWWNycEVtZE9rNmVBU1pCZ005R084amgweEs1MzhmWG9F?=
 =?utf-8?B?bDNMN2Iwak11aW40aUJ1aUs0M2ZWMllzSDZ5MjdYUnhOd0FPYkgzbFZ4a21x?=
 =?utf-8?B?MFpkcmFBWHlBUUFlQjVqRm5xRWxGUE5VeUU4czdQM3VUUk9aTG9pZi80TlpJ?=
 =?utf-8?B?OGM2TUtNaHVkQmc1TXBZU2Eva0JNSXBWOUxzS0JzMUdsUlArUUpYWUFKdW1Y?=
 =?utf-8?B?SGE0QmNDWlFTQXQybGJnTjJKbjdzZy9teTN4RGdzMnNZaHU2bHN0Zk8rOVg0?=
 =?utf-8?B?RWdPalNodjBUUGxvSFZrR2FlTDlOK25PUWYwOVg3c2pxRGoweDAybkJ4d3h0?=
 =?utf-8?B?OVRRVW5ibmppVklSWTF0Q1daQm9VQzJMV2VGVENidkh5QzB2dmdPVldCNUNm?=
 =?utf-8?B?VHIxTUl5T0RTTFZhdHptL3BVbkI4S1FMU21XeWFLL3VncURiZVdPQ0FRalNI?=
 =?utf-8?B?aHRiOEtiTGpiUE45UlJuaVZYQXlWc3Iza0NJWVNaRi9ReFZaRzA1V3VPZlR3?=
 =?utf-8?B?ZC81RG1kSzlhV25HZm1YTjNpMG1CZ1ZVZlhDbWhBMDBlOFA2SjMyQ2FONUs5?=
 =?utf-8?B?eFRvT2gwS2M0NmEwZ0JKZGE5YnNFRWlLWXl1ZGtKMXdsajdrVE54NEFEWFEr?=
 =?utf-8?B?blVjdVhXT3FiNXRnUVQwUExrSDFta0JZQ1FNQWVNTXZhL08vNnVYdHp6SElq?=
 =?utf-8?B?YjBESnM0bnJkazZIQnY2UzhVb1RMZ1kwSGcwY25Bekw2Ui9LcStMcTF5dHRF?=
 =?utf-8?B?UWlYTE43ZFpaUUJvWGRsdEFoN3JlV1MxdTIwWDdPOXdwbURmdU5WcERydDBr?=
 =?utf-8?B?QzV0MXh6M0FaUXF1b3R3Z1NTdk1JZnM1a2tZWVFneE9KbHYzV0V2ekFFcGpq?=
 =?utf-8?B?UVpRVHR1QktOSi9RTEpPMjJLSEY1bFJ4cmIxNnFBd1hEUUpDWjloRWdxOFFE?=
 =?utf-8?B?OHVpdDNBaStqRHRRd2JJWUtoZHNXNjVwczdTMjFKSkc3L0RJNHdXTldJT1BM?=
 =?utf-8?B?SXZXR3FwQ0haZVJrdHRHdjhQU2JFc2xiY2piMlYvTnBxY2k0SzhpazZmdkF0?=
 =?utf-8?B?bGQ1RHpOWVFTTjQ3eEZkeVpkLzhtc3FscUJ5YVhqTVBqQVREODg5ZFNYSkMx?=
 =?utf-8?B?MTNUYlk2OVozOFBRbC9EY1Z4YTExY1VSemx5ZEQxRXB6Ky8vQU1aNzZ5YlMv?=
 =?utf-8?Q?YuEYmxmo6So9tPihSGpMhMlNi?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: df2c8393-e1dd-4406-98aa-08db0349881b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 05:10:55.3906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 85ZV1lreTDP8BvFnUK6JMPp1J0c/aWcBg9x/Vipr900ji3jtGOQ7Sxd89Yeevgmi5xfv/wXXRC0kj6R/bd1bIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4826
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEphbiBLaXN6a2EgPGphbi5r
aXN6a2FAc2llbWVucy5jb20+DQo+U2VudDogVGh1cnNkYXksIEphbnVhcnkgMTksIDIwMjMgMTo0
NCBBTQ0KPlRvOiBDaGVuLCBIb25nemhhbiA8aG9uZ3poYW4uY2hlbkBpbnRlbC5jb20+OyB4ZW5v
bWFpQGxpc3RzLmxpbnV4LmRldg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0hdIHRlc3RzdWl0ZTogZHBk
azogQWRkIGwyZndkIGV4YW1wbGUgd2hpY2ggaXMgYmFzZWQgb24NCj5EUERLLg0KPg0KPk9uIDE4
LjAxLjIzIDE0OjA1LCBIb25nemhhbiBDaGVuIHdyb3RlOg0KPj4gVGhlIEwyIEZvcndhcmRpbmcg
c2FtcGxlIGFwcGxpY2F0aW9uKGwyZndkKSBpcyBhIHNpbXBsZQ0KPj4gZXhhbXBsZSBvZiBwYWNr
ZXQgcHJvY2Vzc2luZyB1c2luZyB0aGUgRGF0YSBQbGFuZQ0KPj4gRGV2ZWxvcG1lbnQgS2l0IChE
UERLKS4NCj4NCj5DYW4geW91IGVsYWJvcmF0ZSBhIGJpdCBvbiB0aGUgZW52aXNpb25lZCB1c2Ug
Y2FzZXMgaGVyZSBhbmQgZ28gbW9yZQ0KPmludG8gZGV0YWlscyBpbiB0aGUgYWNjb21wYW5pZWQg
ZG9jdW1lbnRhdGlvbj8gVGhlIGxhdHRlciBvbmx5IGRlc2NyaWJlcw0KPnRoZSAiaG93Iiwgbm90
IGF0IGFsbCB0aGUgIndoeSIgKG9yICJ3aGljaCB1c2UgY2FzZXMiKS4gU29tZSB3b3JkcyBvbg0K
PnRoZSB0aHJlYWRpbmcgbW9kZWwgKG9yIGxpbWl0YXRpb25zIG9mIGl0KSB3b3VsZCBzdXJlbHkg
YmUgZ29vZCBhcyB3ZWxsDQo+KCJob3cgY2FuIEkgaW50ZWdyYXRlIHRoaXMgcGF0dGVybiBpbnRv
IGEgcmVhbCBhcHBsaWNhdGlvbj8iKS4NCj4NCj5SZWdhcmRpbmcgdGhlIHBhdGNoIGl0c2VsZiwg
eW91IHNob3VsZCBnbyBvdmVyIGl0IGFnYWluIGFuZCBlbGltaW5hdGUNCj5kZWJ1Z2dpbmcgbGVm
dC1vdmVycyBhcyB3ZWxsIGFzIHVucmVsYXRlZCBjaGFuZ2VzICh0aGVyZSBpcyBvbmUgYXQgbGVh
c3QNCj5pbiB0ZXN0c3VpdGUvTWFrZWZpbGUuYW0pLiBUaGUgd2F5IG9mIHRoZSBpbnRlZ3JhdGlv
biBsb29rcyBmaW5lIHRvIG1lDQo+aW4gcHJpbmNpcGxlLg0KPg0KPkJUVywgd2hhdCBwcmV2ZW50
cyB0aGUgdXNhZ2Ugb2YgdGhlIFZGSU8gZHJpdmVyIHNvIGZhcj8NCg0KSSBoYXZlIG5vdCBsb29r
ZWQgaW50byBhbmQgdHJpZWQgVkZJTyBkcml2ZXIgc28gZmFyLiBMYXN0IHRpbWUgeW91IHRvbGQg
bWUgdGhhdCB3ZSBtYXkgbmVlZCB0bw0KZGV2ZWxvcCBvciBwb3J0IFZGSU8gcmVsYXRlZCBkcml2
ZXJzIGlmIHdlIHdhbnQgdG8gdXNlIFZGSU8tYmFzZWQgZHBkayBpbiBYZW5vbWFpIGJ1dCBVSU8t
YmFzZWQgDQpkb2VzIG5vdCBzdWNoIGlzc3VlLiBJIG1heWJlIG1pc3VuZGVyc3Rvb2Qgd2hhdCB5
b3UgZ3VpZGVkLiBJZiB0aGUgbWFpbiBkaWZmZXJlbmNlIGJldHdlZW4gdWlvIGFuZCB2ZmlvIGlz
IHRoYXQgdmZpbyBpcyBjYXBhYmxlIG9mIHByb2dyYW1taW5nIHRoZSBwbGF0Zm9ybSdzIElPTU1V
IGFzIGRlc2NyaWJlZCBpbiBbMV0sIGFmdGVyIHZmaW8gaW5pdCwgdGhlcmUgaXMgbm8gbGludXgg
c3lzY2FsbCBpbnZvbHZlZCBkdXJpbmcgcmVjZWl2aW5nIGFuZCB0cmFuc21pdHRpbmcgcGFja2V0
cyBqdXN0IGFzIFVJTyBjYXNlLCB3ZSBjYW4gZG8gc2FtZSB0aGluZyBmb3IgVkZJTyB3aXRoIHBv
cnRlZCBsMmZ3ZC4NCg0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQoNClsxXTogaHR0cHM6Ly9z
cGRrLmlvL2RvYy91c2Vyc3BhY2UuaHRtbCM6fjp0ZXh0PVRoZSUyMHByaW1hcnklMjBkaWZmZXJl
bmNlJTIwYmV0d2VlbiUyMHVpbyxVc2VyJTIwU3BhY2UlMjBmb3IlMjBmdWxsJTIwZGV0YWlscy4N
Cj4NCj5KYW4NCj4NCj4tLQ0KPlNpZW1lbnMgQUcsIFRlY2hub2xvZ3kNCj5Db21wZXRlbmNlIENl
bnRlciBFbWJlZGRlZCBMaW51eA0KDQo=
