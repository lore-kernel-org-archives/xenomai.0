Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA49710E1
	for <xenomai@lists.linux.dev>; Thu, 31 Aug 2023 00:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693442755; x=1724978755;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+e5GqLV6c7unj6EMsmlspkpwDiT6NM4TaKYARAoJicA=;
  b=SLtVSCeRV2VO8N4u9pWzlCXWv9uUN1pjNcNOtklvqtTq9zOCI3ZcZ1Lv
   KhSxbD0EDotuIXToXCxK7RE90YdpIfUEj/NAbg5uwkRSx/7aqkkbqHs00
   rjWdAJ8SwFlq2lR7LQbaafYzyTNvwUe2d9+DBoKbVaV5z1W/q0YshXtjl
   QGNYLmbv1uWUxqupYwhevxld3JGqDLZAJEf0cbRz+cT0sEyjGMbxjl/c5
   wmPnKUSjroFpO7l7kZqg5uf06YWXt2fyHL7q8Ao09FaN0+1eeAXSMw0Py
   kPryvtV61S6uyG88dyI8dapCXuOITigdrmII3XwiNtUqzScw5eKbde7a8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="355283376"
X-IronPort-AV: E=Sophos;i="6.02,215,1688454000"; 
   d="scan'208";a="355283376"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 17:45:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="768602696"
X-IronPort-AV: E=Sophos;i="6.02,215,1688454000"; 
   d="scan'208";a="768602696"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 30 Aug 2023 17:45:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 17:45:52 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 30 Aug 2023 17:45:52 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 30 Aug 2023 17:45:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmmxSduBi9Q2wUKdHX5rxJzbBxItrRo4YgVvPJJusapX6kNv++sZRUa7Xt7NAmA12m7gwSw1KeE0/GDPVo4vb6/YlZ0eJGOM7xK7aMnEwYT4cm787Rrjoo1VSCdqZvhFAcPc+KCAw+UOxNvtdBk+SEXUGBFA571HQKp0lHsw345wn6OHsXTppBsd4XbtWXlmO0UFTfJDusO5pGv1NKtg4vwsYe9i88So1a9+4dJ7QKuM5GgJs/08IQw07E5fCZiIGbcHQ7Ujh9wNHozxWocbk/PH9wv1MiAW3wGEG5OA2pBSI3/N15gdGGDLzKjQET27GIDMkMOHckHEJZQYuKF7HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+e5GqLV6c7unj6EMsmlspkpwDiT6NM4TaKYARAoJicA=;
 b=fHdLapz5ldyOfpf9zYk3VFdIo6AKzH+lyYrX620FnoH2BPr21f/rvh1vdHZYpVAtzsXmJLzfbJpbsCmdLlxOn4xtp+E/DD/ZmaGSn6YN8hza+YInZgmXs56ty9Ir7yg9KkIGzrJOS1Dv30T8D2ZDV7zd9lH+tr95HzKjIGC7kB6Zb117CzDWKBPrdhoPx9XjBpf1lY3+olHelJ7f+kog7H1gqB7PGWCJTMyJO5aiDqgY+ZS4ZLJycfxSM8pjWIP4RCuN6biGgvA9RldS0q40s6+0ArSo3aPgIV7wSq2FkEbWDMHVvSPOv1BQGB0lAt/8rwfdJ+zNnVKIH9tYzob0OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by BL1PR11MB5335.namprd11.prod.outlook.com (2603:10b6:208:31b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 00:45:15 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::9f36:bd07:796b:9d38]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::9f36:bd07:796b:9d38%7]) with mapi id 15.20.6745.020; Thu, 31 Aug 2023
 00:45:15 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>
Subject: RE: irq storm on sd/mmc card detect gpio interrupt alloced from
 pinctrl device
Thread-Topic: irq storm on sd/mmc card detect gpio interrupt alloced from
 pinctrl device
Thread-Index: Adna7t33BX+CE6qmT/ikjq1kbx2b0QAI4iMAAAETyqAAC50cgAAXhiDA
Date: Thu, 31 Aug 2023 00:45:14 +0000
Message-ID: <MN2PR11MB428547B97385F160CD2E4394F2E5A@MN2PR11MB4285.namprd11.prod.outlook.com>
References: <MN2PR11MB42855A234CF8BF7D17E9E2ECF2E6A@MN2PR11MB4285.namprd11.prod.outlook.com>
	 <d5505413fbbf778aacaeb40effe8cb0ea61107b9.camel@siemens.com>
	 <MN2PR11MB4285D68E3408171C181D9C20F2E6A@MN2PR11MB4285.namprd11.prod.outlook.com>
 <463948a9bd09ddf6062f879fa9746b0c70e6a9ab.camel@siemens.com>
In-Reply-To: <463948a9bd09ddf6062f879fa9746b0c70e6a9ab.camel@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|BL1PR11MB5335:EE_
x-ms-office365-filtering-correlation-id: 13e6c087-32c8-468a-e7f5-08dba9bb8a45
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y24pEJMVlSuxkCv6JXVe6rCZYSV8qZa9AOxo71fpF6syCM10VdGk1KuVxB0tqXCt6TM/g0Y8TLuTRA4zQt/+1HsDq+JzfYkIFDFMHJAjHQsLoO2TCfb1fTjhRKEQdiSjLXjuaIyJ2LKyU6/NRxA43X3zesK1FdfTS0MFvIA7JQCQvfdvIT9h2dctkoU9ni6EOIpOpeKMKCLwUYAWZvZXv53MI9uwT7KM3QtEFhPrFfT4AWszzDvvoGzRPIQwx59y9VRHJZ3ol1PRTCmKwQk9jVGeuEUK+ojK3+VpI1J0WqOiemJplSXQJ49q5ILwUu1gcxQI7AKaU47IhEzCn/HTPsN1WeeCSnVMLgF1XEJfFAFJEgQtWIiKpfeq/6sAe0PSRZ+I6X+gKWimlpoD6PqLabe8efNfng0dlB9+WDAyX5G2fFUzIohHnpkbW2sP82bRr2FJ+qGjSj/ciyT4P9D/GjfRxDZ6aIwMkQAVY9URL33hzXrYci/N09Kdd4bxUXxDubJOTtLw7YtfMu3C+R+/KO5EB9A8rP49Nc6nUFN9PIUwg1BnwFaGNtsnaWG/PPG25iLFCVEc1kk1P69DmgABoRcI48BRTi6esrwUKh0uInockm6KmK3Pc2aEdARqgqKt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(366004)(39860400002)(186009)(451199024)(1800799009)(33656002)(55016003)(52536014)(4326008)(83380400001)(41300700001)(86362001)(5660300002)(8676002)(8936002)(53546011)(7696005)(26005)(6506007)(71200400001)(9686003)(38070700005)(38100700002)(478600001)(122000001)(316002)(66556008)(2906002)(64756008)(54906003)(66476007)(66946007)(76116006)(82960400001)(66446008)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUg2R21WNU9rQnlpSkF0eEgzVUJSUTZJamMxOHA1bHpoR3V6d3FHMFdnZEQ4?=
 =?utf-8?B?SUUyQUNwRzUrQkZvelZ2ZjFsRitpWVc4K2xuaHlWMUJaNmF4OGg2WWtvbzdz?=
 =?utf-8?B?UjRrYXRYV2pwV1pMdGZuOWRxeFIvR2NwakRJL2ZHdlJHTU96dkNValkvNzdC?=
 =?utf-8?B?cENmY1puSDVaM2ZDamEvRlF3U3lyOXQ5U1dSUVJmV1NFTFFUcXU3SndEZE5Y?=
 =?utf-8?B?MFBTL2ZjSy85WVhjcFZVcTBVbW9YQ0d0WDhMTEw0c1REcWlwY1poOXFKLzhW?=
 =?utf-8?B?Qkp4VTlZT2JOY3FOdDY4cVFjcVpPcFdnOTNaSUl1dTFHVVhwalY2V0h2T0Rm?=
 =?utf-8?B?RVF6OHBIM0RhQlhPQmEvWVNiZ2xib04yR1VkSkc2TTJqL09qTkNkTDBGamNE?=
 =?utf-8?B?ZmZCYTh5TG5FMU5vVEl5Ti9mZkhER3k2MmdZcHpieWJpOXFxZ1FoSDRDT25E?=
 =?utf-8?B?SGtpS2VhaGNMVy9UM2dpWFN5dGFQWml5c3NNQzNlUlZDcEZtUGJvMUQ0K3pv?=
 =?utf-8?B?ZkJNeFoxeWhpM1pDNWFPcG9iTWpROWxXeEFXQll0cWIzUGpLdmRJZmw0bXNY?=
 =?utf-8?B?L29RZTJKeHlCa0Z6Tk9leU9BemVxM3ZGZWhpeTlUU2EyYU95QVBhMk1yY0Jq?=
 =?utf-8?B?cUVCY1JWRHhFVEM5UmVLUFhWR0VZSVg1Y1dVM2JDbWkxbC9nOEpBelR4dEl5?=
 =?utf-8?B?T2FOdTUzNVc2aDFYVlB2ZFpmUTdNcmM0dkR5SEVnQVFGb0xISFNSc2tHNURG?=
 =?utf-8?B?MkZNUVMzZ21NendIemZqdjU3ekJHQlZjWUhqZEJVanpHZ0gxVFhtaFUzeE9I?=
 =?utf-8?B?Tk5PNkR4NDZTNVFVVlh4Zk1DL0V0andQWlFwaUFJZFVMSmFvdVRoNytKVjgx?=
 =?utf-8?B?YlVQQno5cnprOWUyNkJ4Y2RCMTVJRWp2ODMwVkZRbU5rYkQzUnlwY0g4NUZM?=
 =?utf-8?B?djlOSlp5cHM1ZFBZUThGM0Y1SkdNNTlFYU5SQzFROVl4d1dyMEE0RjFtV29l?=
 =?utf-8?B?RjJ5QnBFdFFWUkQ1SVhFaHVqVXpNOXQyN0lSanBTZVREMjArVXFyYUhiUzVu?=
 =?utf-8?B?dW5Mc05aRzRiMHo3VjNEQmJSWVloNGZ6Ti9lRG5PWTNXSUM0d3l1UnN1L2o4?=
 =?utf-8?B?L282M1RwaWN1WTZudjBvMVpWaGRFSVdwR292NE1tdjhaS2EyWngwamtUVHlj?=
 =?utf-8?B?TXBFYkpBTFg1eUw2Tno5RWhDbkhFOFlHQ1gvOVJ6WTQ1RUVMb0dOOEV6Q1Rv?=
 =?utf-8?B?a2toRzRyNXpWdHhEY2kvN2wyZDFqa0RvbUtIZXJNelVKaW95ZEhtRzMwb3Z3?=
 =?utf-8?B?LzJuY3pCQ2srQmRnbUlZb05ZdUI4a1pwbzBacEE2b28zQk5mck0wN3BDdXU5?=
 =?utf-8?B?cFdUU1QyMldGV05sYWRYT040OHVwUjNqejBhR0t5VGVzUUJBUmV6b0kxeWts?=
 =?utf-8?B?OFVvWWFKc0FUM1N0NWE5eEJ3Rm40YUp3RG1CRHhtYTFTdUxDVDVHV0E2RWo0?=
 =?utf-8?B?S0ZwTWhXRkQ0RTIvQ21Vam9MMi8rNjlYSkpjbFRqY3FrMmlYVmxxTUx0VjAv?=
 =?utf-8?B?bm83ejRoeEROMDNSbnArRy9YcTh0Q3BMbUs4eFhmNjlkUzR6SGoya2g3U2tR?=
 =?utf-8?B?eUU5SUNoblRNeGdiMW05MXh3UGRUeEduczVoUFRPYzJ2OGpENTRUTGZRaUtC?=
 =?utf-8?B?Q0F0cWxLVktkU3RpU05wU3o0bnZucGpXYnBSNFpqVEFEMFpqcEFMemV5RjJ3?=
 =?utf-8?B?dGVSMlEyQ2FHTEcvRkZPbWYzei9sWWpzVVhrcWk4Zk1CczIwb3ZVSDcvdlc1?=
 =?utf-8?B?ZisrZE4wdUxaZUNKUW53a2JuSXNqSlI1c1RHbElPb1pFZTBYdHRtdVRJQ2sz?=
 =?utf-8?B?UW5sQ0xCaWRwWG4rWDFKeWZFdGVHWlpzVHIweFAraHczUzRQWC9IaVpVNjNl?=
 =?utf-8?B?Sm9lU1ZmZ0VRTCt4UDZZbS9kK1greUlCQlRIQ2VKM0I3SlkwWUdnQnBhSlo0?=
 =?utf-8?B?bC9KYWI1QmxuVEZNQVAvb09uaVdJajVlK3NqN2k0TXkzSEs1ZXB0Nm9XUnNL?=
 =?utf-8?B?ZVRJM2NpTlZCdlpwbmd0ZENTcFZTc1hsbVZLWDU1ZjhCRnBUZ2xWQmdPT092?=
 =?utf-8?Q?en6NcxBE5USgYkZWFpXI+fObw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e6c087-32c8-468a-e7f5-08dba9bb8a45
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2023 00:45:14.6330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MUO/sMyPg34gdhvX+8qVdUetQjeJ2oFiQofGRSZtvg0osuVisem6PcFrpV36nR0L80mY/1//TAFpSDEBbRxwiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5335
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEZsb3JpYW4gQmV6ZGVrYSA8
Zmxvcmlhbi5iZXpkZWthQHNpZW1lbnMuY29tPg0KPlNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDMw
LCAyMDIzIDk6MjMgUE0NCj5UbzogQ2hlbiwgSG9uZ3poYW4gPGhvbmd6aGFuLmNoZW5AaW50ZWwu
Y29tPg0KPkNjOiBLaXN6a2EsIEphbiA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT47IHhlbm9tYWlA
bGlzdHMubGludXguZGV2OyBQaGlsaXBwZQ0KPkdlcnVtIDxycG1AeGVub21haS5vcmc+DQo+U3Vi
amVjdDogUmU6IGlycSBzdG9ybSBvbiBzZC9tbWMgY2FyZCBkZXRlY3QgZ3BpbyBpbnRlcnJ1cHQg
YWxsb2NlZCBmcm9tDQo+cGluY3RybCBkZXZpY2UNCj4NCj5PbiBXZWQsIDIwMjMtMDgtMzAgYXQg
MDc6NTQgKzAwMDAsIENoZW4sIEhvbmd6aGFuIHdyb3RlOg0KPj4NCj4+ID4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4+ID4gRnJvbTogRmxvcmlhbiBCZXpkZWthIDxmbG9yaWFuLmJlemRl
a2FAc2llbWVucy5jb20+DQo+PiA+IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDMwLCAyMDIzIDM6
MjAgUE0NCj4+ID4gVG86IENoZW4sIEhvbmd6aGFuIDxob25nemhhbi5jaGVuQGludGVsLmNvbT47
DQo+eGVub21haUBsaXN0cy5saW51eC5kZXYNCj4+ID4gU3ViamVjdDogUmU6IGlycSBzdG9ybSBv
biBzZC9tbWMgY2FyZCBkZXRlY3QgZ3BpbyBpbnRlcnJ1cHQgYWxsb2NlZCBmcm9tDQo+PiA+IHBp
bmN0cmwgZGV2aWNlDQo+PiA+DQo+PiA+IE9uIFdlZCwgMjAyMy0wOC0zMCBhdCAwMzowNSArMDAw
MCwgQ2hlbiwgSG9uZ3poYW4gd3JvdGU6DQo+PiA+ID4gSGkgUGhpbGlwcGUvSmFuDQo+PiA+ID4N
Cj4+ID4gPiBXZSBmb3VuZCB0aGVyZSBpcyBpcnEgc3Rvcm0gaXNzdWUgbGlrZSBbMV0gb24gc2Qv
bW1jIGNhcmQgZGV0ZWN0DQo+aW50ZXJydXB0DQo+PiA+IGFsbG9jZWQgZnJvbQ0KPj4gPiA+IHBp
bmN0cmwgZGV2aWNlIHdpdGggWGVub21haSAzLjIgRG92ZXRhaWwgNS4xMC4qDQo+PiA+ID4gQWNj
b3JkaW5nIHRvIG91ciB0ZXN0LCAgdGhlIHBhdGNoIFsyXSB3b3JrcyBmb3Igc3VjaCBpc3N1ZSBp
biBvdXIgY2FzZS4gSXQNCj4+ID4gc2VlbXMgdGhhdCBoYW5kbGVfZWRnZV9pcnENCj4+ID4gPiBu
ZXZlciBhY2sgdGhlIGlycSB0byBjbGVhciB0aGUgaW50ZXJydXB0IHN0YXR1cyBmb3IgdGhlIExp
bnV4IGdwaW8gaW50ZXJydXB0Lg0KPj4gPiA+DQo+PiA+ID4gSSBhbSB3b25kZXJpbmcgaWYgdGhl
cmUgaXMgYW55IHNpZGUtZWZmZWN0IGZvciB0aGlzIHBhdGNoLCBQbGVhc2Ugc3VnZ2VzdC4NCj4+
ID4gPg0KPj4gPiA+IFJlZ2FyZHMNCj4+ID4gPg0KPj4gPiA+IEhvbmd6aGFuIENoZW4NCj4+ID4g
Pg0KPj4gPiA+IFsxXToNCj4+ID4gPiBjYXQgL3Byb2MvaW50ZXJydXB0cw0KPj4gPiA+ICAgMTQ6
ICAgIDI0NDAxOTAgICAgICAgICAgMCAgICAgICAgICAwICAgICAgICAgIDAgIElSLUlPLUFQSUMg
ICAxNCAgICAtZmFzdGVvaQ0KPklOVEMxMDIwOjAwLA0KPj4gPiBJTlRDMTAyMDowMSwgSU5UQzEw
MjA6MDMsIElOVEMxMDIwOjA0LCBJTlRDMTAyMDowNQ0KPj4gPiA+IDEyODogICAgMjQ0MDE5MCAg
ICAgICAgICAwICAgICAgICAgIDAgICAgICAgICAgMCAgSU5UQzEwMjA6MDEgIDExMiAgICAgIDAw
MDA6MDA6MWEuMSBjZA0KPj4gPiA+DQo+PiA+ID4gWzJdOg0KPj4gPiA+IGRpZmYgLS1naXQgYS9r
ZXJuZWwvaXJxL2NoaXAuYyBiL2tlcm5lbC9pcnEvY2hpcC5jDQo+PiA+ID4gaW5kZXggNmFjYTZj
MDM2YWRhLi40ZDA4ZWFmMDc2ZTkgMTAwNjQ0DQo+PiA+ID4gLS0tIGEva2VybmVsL2lycS9jaGlw
LmMNCj4+ID4gPiArKysgYi9rZXJuZWwvaXJxL2NoaXAuYw0KPj4gPiA+IEBAIC04NjksNyArODY5
LDYgQEAgdm9pZCBoYW5kbGVfZWRnZV9pcnEoc3RydWN0IGlycV9kZXNjICpkZXNjKQ0KPj4gPiA+
ICAgICAgICAga3N0YXRfaW5jcl9pcnFzX3RoaXNfY3B1KGRlc2MpOw0KPj4gPiA+DQo+PiA+ID4g
ICAgICAgICAvKiBTdGFydCBoYW5kbGluZyB0aGUgaXJxICovDQo+PiA+ID4gLSAgICAgICBpZiAo
IWlycXNfcGlwZWxpbmVkKCkpDQo+PiA+ID4gICAgICAgICAgICAgICAgIGNoaXAtPmlycV9hY2so
JmRlc2MtPmlycV9kYXRhKTsNCj4+ID4gPg0KPj4gPiA+DQo+PiA+DQo+PiA+IFRoYXQgZG9lc24n
dCBtYWtlIG11Y2ggc2Vuc2UuIEEgSVJRIHN0b3JtIG1lYW5zIHRoYXQgd2UgdW5tYXNrZWQgdGhl
DQo+PiA+IElSUSB0byBlYXJseSBvciBmb3Jnb3QgdG8gbWFzayBpdC4NCj4+ID4NCj4+ID4gQSBm
b3Jnb3R0ZW4gQUNLIHdvdWxkIG1lYW4gdGhlIElSUSBzdGFsbHMsIHNvIGl0IHdvdWxkIG5ldmVy
IGJlIGZpcmVkDQo+PiA+IGFnYWluLiBObz8NCj4+DQo+PiBBY2NvcmRpbmcgdG8gdGhlIHRlc3Qs
IGl0IHNlZW1zIGZvcmdvdHRlbiBBQ0sgd2lsbCBrZWVwIGZpcmluZyBpbnRlcnJ1cHQgaGVyZQ0K
Pmxpa2UNCj4+IGZvbGxvd2luZyBjb21wYXJpbmc6DQo+DQo+VGhpcyBkb2Vzbid0IG1ha2Ugc2Vu
c2UgKElNSE8pLg0KPkNhbiB5b3UgcHJvdmlkZSBhIGNhbGxzdGFjayBmcm9tIGhhbmRsZV9lZGdl
X2lycSgpIGluIGNhc2UNCj5vbl9waXBlbGluZV9lbnRyeSgpIHJldHVybnMgZmFsc2U/DQo+DQo+
VGhlIElSUSBzaG91bGQgYmUgQUNLZWQgb24gcGlwZWxpbmUgZW50cnkgYWxyZWFkeSwgZXZlbiBp
Zg0KPmhhbmRsZV9lZGdlX2lycSgpIGlzIGNhbGxlZCBhZ2FpbiAoZnJvbSBMaW51eC9JbmJhbmQg
Y29udGV4dCkgdGhlIElSUQ0KPnNob3VsZCBhbHJlYWR5IGJlIEFDS2VkLg0KDQpGb2xsb3dpbmcg
c3RhY2sgaXMgZHVtcGVkIGFmdGVyIHBhdGNoaW5nIG15IHBhdGNoLiBXaXRob3V0IHBhdGNoaW5n
IHRoZXJlIGlzIG5vIGludGVsX2dwaW9faXJxX2Fjay4gSXQgaXMgY2FsbGVkIGluIGhhbmRsZV9p
cnFfcGlwZWxpbmVkX2ZpbmlzaCBmcm9tIHdoaWNoIGl0IGFscmVhZHkgY2FsbGVkIGlycV9leGl0
X3BpcGVsaW5lIGJlZm9yZSBzeW5jX2N1cnJlbnRfaXJxX3N0YWdlLiBUaGF0IGlzIHdoeSBvbl9w
aXBlbGluZV9lbnRyeSByZXR1cm5lZCBmYWxzZSBpbiBoYW5kbGVfZWRnZV9pcnENCg0KDQoNClsg
IDI5MS4wMDkzMzBdIENQVTogMCBQSUQ6IDAgQ29tbTogc3dhcHBlci8wIFRhaW50ZWQ6IEcgICAg
IFUgICAgICAgICAgICA1LjEwLjE3OS1pbnRlbC1lc2Utc3RhbmRhcmQtbHRzLWRvdmV0YWlsKyAj
MQ0KWyAgMjkxLjAwOTMzMV0gSGFyZHdhcmUgbmFtZTogSW50ZWwgQ29ycG9yYXRpb24gRWxraGFy
dCBMYWtlIEVtYmVkZGVkIFBsYXRmb3JtL0Vsa2hhcnRMYWtlIExQRERSNHggVDMgQ1JCLCBCSU9T
IEVITFNGV0kxLlIwMC41MjA0LkEwMS4yMzA1MTgwNzU3IDA1LzE4LzIwMjMNClsgIDI5MS4wMDkz
MzJdIElSUSBzdGFnZTogTGludXgNClsgIDI5MS4wMDkzMzJdIENhbGwgVHJhY2U6DQpbICAyOTEu
MDA5MzMyXSAgPElSUT4NClsgIDI5MS4wMDkzMzNdICBkdW1wX3N0YWNrKzB4N2IvMHg5Mw0KWyAg
MjkxLjAwOTMzM10gIGludGVsX2dwaW9faXJxX2Fjay5jb2xkKzB4MjIvMHgyNw0KWyAgMjkxLjAw
OTMzNF0gIGhhbmRsZV9lZGdlX2lycSsweGU0LzB4MzEwDQpbICAyOTEuMDA5MzM0XSAgZ2VuZXJp
Y19oYW5kbGVfaXJxKzB4NGIvMHg2MA0KWyAgMjkxLjAwOTMzNV0gIGludGVsX2dwaW9faXJxKzB4
MTFmLzB4MWMwDQpbICAyOTEuMDA5MzM1XSAgX19oYW5kbGVfaXJxX2V2ZW50X3BlcmNwdSsweDc3
LzB4MTkwDQpbICAyOTEuMDA5MzM2XSAgPyBoYW5kbGVfbGV2ZWxfaXJxKzB4MjAwLzB4MjAwDQpb
ICAyOTEuMDA5MzM2XSAgaGFuZGxlX2lycV9ldmVudCsweDZjLzB4MTAwDQpbICAyOTEuMDA5MzM3
XSAgaGFuZGxlX2Zhc3Rlb2lfaXJxKzB4ZDgvMHgyNTANClsgIDI5MS4wMDkzMzddICBhc21fY2Fs
bF9pcnFfb25fc3RhY2srMHhmLzB4MjANClsgIDI5MS4wMDkzMzhdICA8L0lSUT4NClsgIDI5MS4w
MDkzMzhdICBhcmNoX2RvX0lSUV9waXBlbGluZWQrMHgxMWQvMHgyMzANClsgIDI5MS4wMDkzMzld
ICBzeW5jX2N1cnJlbnRfaXJxX3N0YWdlKzB4MTU3LzB4MWYwDQpbICAyOTEuMDA5MzM5XSAgaGFu
ZGxlX2lycV9waXBlbGluZWRfZmluaXNoKzB4YTIvMHgxYTANClsgIDI5MS4wMDkzNDBdICBhcmNo
X3BpcGVsaW5lX2VudHJ5KzB4ZGIvMHgxMjANClsgIDI5MS4wMDkzNDBdICBhc21fY29tbW9uX2lu
dGVycnVwdCsweDFlLzB4NDANClsgIDI5MS4wMDkzNDFdIFJJUDogMDAxMDpjcHVfaWRsZV9wb2xs
LmlzcmEuMCsweDNhLzB4MTEwDQpbICAyOTEuMDA5MzQyXSBDb2RlOiAwMCA4NSBkMiAwZiA4ZiA5
YyAwMCAwMCAwMCBlOCA3MiAzMyAyOCBmZiA2NSA0OCA4YiAxYyAyNSAwMCBhZCAwMSAwMCBlOCBh
NCAyOSAyNyBmZiA0OCA4YiAwMyBhOCAwOCA3NCAwYiBlYiAxYyBmMyA5MCA0OCA4YiAwMyA8YTg+
IDA4IDc1IDEzIDhiIDA1IGNjIDZiIDAxIDAxIDg1IGMwIDc1IGVkIGU4IGYzIDIyIDJhIGZmIDg1
IGMwIDc1DQpbICAyOTEuMDA5MzQyXSBSU1A6IDAwMTg6ZmZmZmZmZmZhMTgwM2VjMCBFRkxBR1M6
IDAwMDAwMjAyDQoNClJlZ2FyZHMNCg0KSG9uZ3poYW4gQ2hlbg0KPg0KPkJ1dDogSWYgd2UgdXNl
IHRoZSBkb3ZldGFpbCBzb3VyY2VzIHRvIGJ1aWxkIGEga2VybmVsIHdpdGggcGlwZWxpbmluZw0K
PmRpc2FibGVkIHdlIGhhdmUgdG8gQUNLIHRoZSBJUlEuIEkgYXNzdW1lIHBpcGVsaW5pbmcgaXMg
YWN0aXZlIG9uIHlvdXINCj5lbmQuDQo+DQo+QXMgSmFuIHNhaWQsIEknbSBzZWFyY2hpbmcgZm9y
IGEgc2ltaWxhciBwcm9ibGVtIGZvciBzb21lIHRpbWUgbm93IHRoYXQNCj5JIGNhbiBvbmx5IHJl
cHJvZHVjZSBvbiBWaXJ0dWFsQm94IFZNTS4gSW4gbXkgY2FzZSBJJ20gc2VlaW5nIGEgc3RhbGws
DQo+bm90IGEgc3Rvcm0uIEkgd2lsbCBnaXZlIGl0IGEgdHJ5LCBsZXQncyBzZWUuDQo+DQo+Pg0K
Pj4gQWZ0ZXIgcGF0Y2hpbmc6DQo+PiAxMjg6ICAgICAgICAgIDIgICAgICAgICAgMCAgICAgICAg
ICAwICAgICAgICAgIDAgIElOVEMxMDIwOjAxICAxMTIgICAgICAwMDAwOjAwOjFhLjEgY2QNCj4+
DQo+PiBCZWZvcmUgcGF0Y2hpbmc6DQo+PiAxMjg6ICAgIDI0NDAxOTAgICAgICAgICAgMCAgICAg
ICAgICAwICAgICAgICAgIDAgIElOVEMxMDIwOjAxICAxMTIgICAgICAwMDAwOjAwOjFhLjEgY2QN
Cj4+DQo+PiBSZWdhcmRzDQo+Pg0KPj4gSG9uZ3poYW4gQ2hlbg0KPj4gPg0KPj4gPiBDb3VsZCB5
b3UgcGxlYXNlIGNoZWNrIGlmIHdlIGNhbGwgdW5tYXNrX2lycSgpIHdpdGggSFcgSVJRcyBlbmFi
bGVkPyBJZg0KPj4gPiBzbywgSSBoYXZlIGFuIGlkZWEgd2hhdCBpcyBnb2luZyBvbi4uLg0KPj4g
Pg0KPj4gPiBGbG9yaWFuDQo+Pg0KDQo=
