Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1891392
	for <xenomai@lists.linux.dev>; Thu, 14 Dec 2023 00:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lNcpuBzO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702514680; x=1734050680;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=PuugRfewXPM10Ub8MObg/dCfGIZU7X8ASeZOJDpItEo=;
  b=lNcpuBzO7WAtDqqlXXsIRYch3ofn8fMgdAXZvfabziKInaf90fTcLppG
   eIpxdKcJoYW/fCe9UsehVusaNOTLd+A32lysRafE/kBkk+R13AGsann7f
   qUu/TdkVSLE+xKdQDVbzJ8f3+1Wpmjg/Nyw48A5CBHNUMHO6VR+HEo0Do
   OZcsl85Dd25oeOWXLeSXHZfbulObR2Bc1WnP4rWKUJ5AxEVTHXeuacMwC
   pnZgbTxIj1VLLPZIlyTW9TL5bym8UX8QA1LC7V0xYLHi8iKdGbz/LzlPM
   owdhzjn57llk3NAblj11p1LEG4CZt3Ge5T3krV7dwLgKiuQ3wuPVul5qX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="461517076"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="461517076"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 16:44:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="750322990"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="750322990"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2023 16:44:38 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 16:44:37 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Dec 2023 16:44:37 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Dec 2023 16:44:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XlJEtdBXgOa/RigKyQ1mXzTInoeksUKYRG9z/HpHtfQ8ugd30WvWN9slqQHfZAetoXEHfCNBev79M0/TBD5rOa1IeXIucmiAuZ0G8fnzH1G0ZPQCrEGg6Y/Q5aRajx/qvSnPCi2hB1BKBVbLe+68ICUxEO3NTk8aaYNvrsHYfqiDcQcbw2aA5sv48hQTx+tMA2qVcE7KwXcadNqUtgiaOEX3+hrsluf6FJOnfKJNGG0kdP9qxismzk+1zewQm7kiqiJNgP2U3+gDZdjWzPjbU0R4tiBRs7izuZekUBhRi8nJ4dD6ejgIgRfHJQiwwT7vrW2bda8+dzlmjWmbPoaaRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuugRfewXPM10Ub8MObg/dCfGIZU7X8ASeZOJDpItEo=;
 b=WyvgnKflMqTc/Z/iB5tu9WB9jpl62O53+N4pvpxaVdiY9qqqJyxWeDsmR8C/bFo0aic75khDk88BNTjhBVfAwVH9ZPV2hNt+K6cPajWHsTqkhmX0X5CyrrlnKBUGi3aROjzAuzl/xu6iP2aoHwSf1bTBqOXjAp3TAAzfSs02cl4iMFVZQuBXk1DEayxVF5ytKLmNoeJP8r/E+nal/AY+48oQSFHY7fRhOkXggDIrambc0lk1kJkX/zyzZuUNNPqKRiP3znMn39VSOSnxi9IkwLYnEmcMuX1EJvJhPM1nun7Tb/6jfLg8stXS4ANxsJTVF3xhMMbrGVBQOe0JbT+4Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by PH0PR11MB7165.namprd11.prod.outlook.com (2603:10b6:510:1e9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Thu, 14 Dec
 2023 00:44:32 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::7b71:c300:be05:d512]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::7b71:c300:be05:d512%7]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 00:44:32 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Xenomai Community Call Minutes - Dec 13, 2023
Thread-Topic: Xenomai Community Call Minutes - Dec 13, 2023
Thread-Index: AdouJoJnZoL7H4VLRJGIlb/qMdYuJA==
Date: Thu, 14 Dec 2023 00:44:32 +0000
Message-ID: <MN2PR11MB4285C158ED1EC93B028962C2F28CA@MN2PR11MB4285.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|PH0PR11MB7165:EE_
x-ms-office365-filtering-correlation-id: ad28259a-b977-4943-604b-08dbfc3dd65a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rm+Qf5wEYHDz7CZBz/N9xsjytfSAGPXN86a/+IlNaACHZfe9xFIdjnbr4VyRaPJlod5aLFcABfL8si4hWJv7HzaPDwvu9Xowzeb6DZoKjTehnoSd7TaEaTs6ejHBPeRVSwaz3nVpjVraazMtaOJ1OjfYABgCudOYC5DZPG7ES/+ByAmvv9KVmdHZDAkEf8CWx5GeYLFGBlLzJu2Kaa3dwx671R1A/8Tm3RePHnVurwV+Iv+TUn2OIWZ75vN7WI648A2SS8xHSx9Qr+pLHwAy3ewPWKW27W6KRFL5s12NAtqwHLzLBGrwvIHFewUCbsmWau1rqTgnZ1TPIGp3NalqAOLjyBe6s0KywHHeDWN3BNiSW0GTqxVRjb5MQnJkYCrbdoNF5MdUZE6zeIvYSLQyNhcxMjN7LLhao8WgZb4+3KQapBhSu3jPYbdHgvISl7pxNffKAxI6wRp2K6qqrR+L62QLyxT0AiS7ReNGR2mRivVNkdLEiidx45dKA/hFmecdGZFEZ86Sq61OcxIV/EHOlz/LOeE03dqDSrrtYGOXejKH+76Kp8bHmcLs7i5Eg2pMommX6QdaOO/tPCjqmilDHJ+uupZrWCD5hgDXLVXOQYQeN0Z025dIOVvpPmDsKi7g
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(396003)(136003)(346002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(83380400001)(9686003)(6506007)(7696005)(8676002)(8936002)(5660300002)(52536014)(41300700001)(4744005)(2906002)(71200400001)(478600001)(64756008)(316002)(6916009)(66476007)(66946007)(76116006)(66556008)(33656002)(86362001)(66446008)(122000001)(38100700002)(82960400001)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjU0ZGJ0U1ErSjN4RXJNbGpyY0R6Z3dnR01BTDRwRk1SUEl2b0owQVIxaHVU?=
 =?utf-8?B?S0dFV3ArNnpLdUc5Q2NkeVpnQ0NJNjl6MHRheWNRbFNROTlDUnpSa3c1b3Vl?=
 =?utf-8?B?Z0htTG9IWDIzUVQyVGRiMkdFelB1TTNHQ1VTMDdQak8zcUgxS1BUSFdiNENj?=
 =?utf-8?B?dlphSDN6QmJUZkhmeFJBUldkS1VEektlcFlXZGUvSEdRNEFMVThUc1l6Mzhj?=
 =?utf-8?B?YldPU2JhRU8xc3FzL2ZES1kvTWFiVlAxTjRDaTlWbGk5eXowZ3lxYVVwZWFa?=
 =?utf-8?B?eVhEb2paTEpoUklOSlEzZEppNlVIcU5tNDNHRUxSRlNtSGl1SUducmNMb0pC?=
 =?utf-8?B?T2Yxb3hkajcwblZQYkJBZjlxUlUrSGxHYkh4K2Z5RlpsUEplcnhWaEE3SXdN?=
 =?utf-8?B?YmJWSzNqUEVRNVhKZ0E4S0ZiSlVFeXQ2c0RxNmRYQ2ZsdjlRcHBIcVNLQi94?=
 =?utf-8?B?SXgxbVU0cW5MQyt2OXlmVFVLcFVnQzFHYjZGR2VrQWV5MUk1b2krY0xOazZE?=
 =?utf-8?B?c2kvWUsxYzRhR215L3FuRnNoNFJrSUlRR2NQOHAxaWdrSlozS2xsR0thRXUw?=
 =?utf-8?B?UTJpWUpRQ2pYbjdrS0M3d3dvdTFZY0UwSVZydGkxYkl0SzAyMWpnQXl5blBq?=
 =?utf-8?B?c3FxUHBZT2x1ODhJcnZzSFZqaE9IRmJoeUU1N201UGdFVVhtbzFnd2tac25k?=
 =?utf-8?B?NEM2aVg2QnhjTkZSQnJ6eklQdUFiZVFXWmlxZFNJaUpKR3VLa25nc0ZUeWdm?=
 =?utf-8?B?TGl3NWRiQVRwaEdaUHUxK0MvaDl6RjlncHMxQ21oUjRFNVZKY2lGYStlSGFa?=
 =?utf-8?B?aEkwbHlvTDhwVGtXbTN3eHRiM2VsRDEyTzBRc0kvMHlweitVVGRtTHhJSDZH?=
 =?utf-8?B?R3llSWFDQTJCRWJvcWhvSnJRTUpGNktXeHV0STRXZFYyY3VTRjdMVXkrdmNV?=
 =?utf-8?B?Rm0xYkVQNXFPaFBLYnB5dkF6NVBobkZoSUNTMVE0Y29rY3V6TUVqc0xtK1lW?=
 =?utf-8?B?cndBZmdJSmFIbVVCKzZvYnBra0hheHk2TURaUVlINnAzQXVNdlh6YXNjeUxx?=
 =?utf-8?B?MkRVeGpybGthcEwxaVMzMzF6QitvMkdWYVlFeGdLdFpqY2t0NkNxcXJkaGg5?=
 =?utf-8?B?RytEV0V3ZVJmMHloOGNDdHVjaVU1SStaSlJhaXNWdUdMUGs4NHp2UUtaS3BK?=
 =?utf-8?B?MldtT2dlODhudFFPNFhubXVNOVc2VTFnS1VQc1JMaVhoandjUUVJcEdCSGlm?=
 =?utf-8?B?RjFnWDhPdGZKbm1LVldCcHhBdFhvaDFHYlRSekJXUTREQ3J1b1YvNjVQanNo?=
 =?utf-8?B?MEg3ZU5DMlMvdTkrWFZtQ1YrQ0szRURKRXBOK1I4UElqSlMvdUc2K2hIcXNH?=
 =?utf-8?B?Q2pjTkJyaWFUMFQwZWw5aSt3TlJWa2hJVDBWVFV0NTgzVHhKazBzVUFPQzFa?=
 =?utf-8?B?NzNRS0NaVVBwTS94aXM3SFRuSElDWWkzUnNiVnVJSGZnL3BlNE1NSU5MRGox?=
 =?utf-8?B?UUFrdDBxRERJQm5hM0xyZllYNU9RWHk4Vi80bGt3c3paZkd6SWZteEF0TGE2?=
 =?utf-8?B?RXRMUTVRV2VxU0tyaWJOeExnRDZjck9rbGJ4Q2M2Zmp3Nks4SlFhb2c2QXZI?=
 =?utf-8?B?YlU2VU16RUc1dEZsSS9kTUJCQXJxVytJNndmazJDMTRLVFNIa1IrVEtTUjRG?=
 =?utf-8?B?RzhBbUFNZjVsanVOWDlaQ3JMaEhOaFlyZnV1ZGZiNGFEMmRMWTFMSXQrdDJU?=
 =?utf-8?B?V2svbitkR2tKcFFXRUdhdHBWcE5OM2JIT2dWblNKMjIrSlJuZVVXbVlVc3A1?=
 =?utf-8?B?UmhLTmRvY3d5MmdUcTcxMEQ3cVRTVHJibmQ4V0FndjFLb0lucFNGSmR1d3pj?=
 =?utf-8?B?bGdKV2ZlUjVFNEZBUVQ3dW1MaGhaRDJDeDI5SldGYzNQRUhvWVMrZjdGSVR5?=
 =?utf-8?B?UFhub1ZZSkF3NGsxQUFRSDMrazFoVy9GYi90T215K2hQMEp2UFdUU2E3cEM4?=
 =?utf-8?B?em5xc1laOG9nN3hoV0t5QkxDNXZBRnlTem85Ri9EKzlWaEYydnBQUU9pakFO?=
 =?utf-8?B?c2MxNDVzVDlmNk5nd3ZwT3U2VHh4MnYwNmhseS8ySXdEWGZLSVlsSStPR3g4?=
 =?utf-8?Q?XrRm6JSGkUdsVxVoUiVSUrpVE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ad28259a-b977-4943-604b-08dbfc3dd65a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 00:44:32.2191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vEUhgXj8vNHv0w2F268dRlWGXBNrDIZXdszmrqeepOUbxST5ik8MvW9YB/cNmPw61HJa6jDTLtMUEsHmMHHlfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7165
X-OriginatorOrg: intel.com

QXR0ZW5kZWVzOiBKYW4gS2lzemthLCBGbG9yaWFuIEJlemRla2EsIFJpY2sgV2FuZw0KCQlOaWNv
bGUgQW4sIEppYW53ZWkgU29uZywgWWluamllIExpLA0KCQkgSGFvIExpLCBIb25nemhhbiBDaGVu
DQoNCkNvbW11bml0eSB1cGRhdGU6DQoJCTIwMjMgV3V4aSBYZW5vbWFpIFdvcmtzaG9wIC0tIGEg
c3VjY2Vzc2Z1bCBjb25jbHVzaW9uDQoJCUNJIHN5c3RlbSB1cGRhdGUNCgkJWGVub21haSA0IGlu
dGVncmF0aW9uIGludG8geGVub21haS1pbWFnZXMNCgkJWGVub21haSBtaXJyb3Igb24gZ2l0ZWUg
LS0gdG8gYXBwbHkgZm9yIGZyZWUgcmVwbw0KCQlOZXh0IG1lZXRpbmcgKERlYyAyNykgLS0gIGNh
bmNlbGxlZA0KDQpSZWdhcmRzDQoNCkhvbmd6aGFuIENoZW4NCg0K
