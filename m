Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E243D378
	for <xenomai@lists.linux.dev>; Thu, 15 Jun 2023 00:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686789707; x=1718325707;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=dcjBr5YG0CFJDQBfnCrS7Oedu3eCAHYH9T+3ZiecdpU=;
  b=cV8PnfJLgGp2eAHHSb0UV5xFuORHKGBzT5vs2t4VqHAElhE4IVM93Vf4
   cAbaNqnyaC49r9hAK2Egpx5I3iBGuV3XP7EfOorrLCZb8VqFb1JrKbILv
   DroNzzW8SBIOzqBAumTSwfBvNFVux4o4wsra6rRKFjlghVzvcTFcEljdg
   hRU9L+1XHbtk8XCBTHXKn7fDXqaPLSCkXVdbJ0eBYRAVcJu4ymC8lNi5r
   eoJOUkBINdTu0VFuPA99p+ifSi8lQQkMeXIDP4Tlin/iwa0B38qveX8iC
   UAD8f3Rp62GQhkL2KNNQkRD0dKFXajNGum2bFZIf5Iw51qvWXYupvMBPy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="445141790"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="445141790"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 17:41:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="742035064"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="742035064"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 14 Jun 2023 17:41:45 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 17:41:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 17:41:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 14 Jun 2023 17:41:44 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 14 Jun 2023 17:41:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFo+dtbBwu6dTIk4yTAY+5RSD6M2iBIiPKlbhBecJLGuzwPAk16N1CRbtJWyuYAMZxPQ0qhCEZeoZizIjLcoyQs4VPMFZLCUmtCE1zUsZFwgrRBRGhPdclAuiPWmJU5uNEeeH1UIJvtZuz5mUT78snFfsItzD661F8fJl5gPbM6gNtz0xkfRIm6PBxvYGE9+rggmWPHSxh5ZC6lGs4JBBAsVkGoem0YTblsrktABP6eoW3IE/CPUa1Ckmtf9tTWqNoZy6OveK33keOebzxqcVS9LCZQSXnokvGZBZzZTiIQ0Ka7jNAJYG0788nZIhhFeym9q8NkaI5tFy39PpZ9o4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcjBr5YG0CFJDQBfnCrS7Oedu3eCAHYH9T+3ZiecdpU=;
 b=R1YGq0E6utX0aQD4npY/aASm17nYY/02olrB+M+YMUhhMl1VAfy7mlF8DxOU+3Vx8rkFG2VnpHNADhGC1oqTbKV8Rji0RYoX628+HkukHK6K8lgSgxFvUtKFGBC0XReAusiYxcw9fyZYnWbLZwARXjaSSb1cx296/t6GB70/LTax32V7U5QpbN6/crP3FcYXG+g2t7t/HdvwzmCni5KoPQXmd8RoggATMcpQxv10ABgZ7jL1QY3P4DwylLFIglJYxILYy9Ebqft1aZwt68MzPGhIBToxZuk6hd/Glbb1F7/GGvpiDgWwodXi1Yw4TFKzitY/8j26E5L52kG2Pu5Tag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4285.namprd11.prod.outlook.com (2603:10b6:208:191::32)
 by DS0PR11MB7786.namprd11.prod.outlook.com (2603:10b6:8:f2::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.29; Thu, 15 Jun 2023 00:41:42 +0000
Received: from MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::56a8:e9c:284:f6a8]) by MN2PR11MB4285.namprd11.prod.outlook.com
 ([fe80::56a8:e9c:284:f6a8%7]) with mapi id 15.20.6477.028; Thu, 15 Jun 2023
 00:41:42 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Xenomai Community Call Minutes - Jun 15, 2023
Thread-Topic: Xenomai Community Call Minutes - Jun 15, 2023
Thread-Index: AdmfIiJ6ucfrcoMCSqG9/cdqTsCiNA==
Date: Thu, 15 Jun 2023 00:41:42 +0000
Message-ID: <MN2PR11MB428561CBB26542A0DEF73B7AF25BA@MN2PR11MB4285.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4285:EE_|DS0PR11MB7786:EE_
x-ms-office365-filtering-correlation-id: d7a046e2-6328-475e-1c11-08db6d3949c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NXo0BEMzwERoaP/LjbIm2kHKFj03emsm30kuYIornpRrWGWDn17Jlq9Xtd9ZF1DtY5dCbxQOlnZrUg/KmcBqW+8Nbx10zxaWBHr38yS6B42LijfVcKQD6v60Y/Ny2g40ZZSF31P8Hq+atEROjBuBaSLrJTEcTunsh2Fozkz6LljlyVsuVXgIh+Rbg49cQJKRri1Kv4hE/RQIXE7GwMhKGERQyUH7jHVqkbHL246oUR3rvNqQqfq6DI97r2QcBgygU6XiEpS8kZJN6HoQ5o3KzXLqeOUnhtXb9aJ4MIr0Bp6H3ukPpjLsY6TK7GI0SeNt8KmBTzrAn76FoOXDUlu/zDRztOmoQtQeJDvtQe8VubMreK6MTQaq7im/ejua6OjMZ8PhdaD4KA2lUEPDnr2IAYFy5Ms3UHYykXrhf+i8O+miJiD+4RYKATWrVG7VAGiAO3WdpE50I69SbAgkkmLvohsBkuQYvigKvAwW7EdYWZ1ABjoMlsThuR/GI6BuclrB/qocbeIJwZiifAha9r7RJ1LuhFEgF5Qtbq+dttXgGNBLQ//qbTvdWzdaC9a+bVYZ+BYQkx6TTtZqdpBb2zm456P/38RV2Dlk3Ef7EOpGaDgZwhOW+OndZ7JSnkz2cwlT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4285.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(366004)(346002)(396003)(376002)(451199021)(38070700005)(83380400001)(82960400001)(558084003)(33656002)(122000001)(86362001)(38100700002)(55016003)(478600001)(7696005)(71200400001)(8936002)(2906002)(8676002)(52536014)(5660300002)(66446008)(66946007)(66556008)(64756008)(66476007)(76116006)(41300700001)(6916009)(316002)(186003)(26005)(6506007)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1hWYUltQ0VFbHR1aUxTblhDQTNlTG15TExtaWFpM0tCZmdjbTVucVdjRmdG?=
 =?utf-8?B?U1ZPN09nM2NVUEdabHZaZlZWSVc2dXd5cVRTR1UvSnRIK2RheGhHZitoYTQy?=
 =?utf-8?B?VDZTM2l4LzlmWXFzZm1OTUpuRHg0WXRkT0hHc0toTXpoR2FpK2IvSXUyU0w4?=
 =?utf-8?B?a0cwb3BYNTE3bHNuaHR0MUVMcW16NFk0N1crdUx1L1RleEhadXl3bjNTVFUw?=
 =?utf-8?B?d2xTZlB4RE5GWGZncE5uanBEOTIzTXJ5VnMwQkpvelhIQVVLbitWeDhLNHFQ?=
 =?utf-8?B?SWp1bEpzWENrTU5lN2t6aUxVUnAxcThjN3NweXdqU3ovQlJkbXFQZnJzbTNE?=
 =?utf-8?B?ZlFRYkVYVTdUa3pNY0JyRU1TNExxTE81d245ZnpwRHhjekNTcSt3ZDk3RG9U?=
 =?utf-8?B?QXN3UzdVa09wT29VQnVZSG51aVFOSXFXcXpzUXBFWWFLdWl2VUw5RTMyTW5s?=
 =?utf-8?B?bUdxcThkV3RFWEhMRk1tV0txeThOaUR1MXZKU29GMW9yclhYTG1SVmM4b1dC?=
 =?utf-8?B?YmJNSWtCVnNnMzlWVnZmR2sxN0UxaS9Ldmt1alJDaTBmMTRJcXpQdTRidXEz?=
 =?utf-8?B?Wm50aW5IaHhyWEN5eTJzcFNNWHBKRmpSUjY4OXM0RE1UTHd4cG1SK0dFeUdG?=
 =?utf-8?B?RTNaMXJJSHJTWStSaklkaWNCOG5JTU5lT2NoQTNLcG5hTXZyYlYrSG9mWGF3?=
 =?utf-8?B?bUllVHA3bURuOEFtUWJGU29Cai9qN05UQytQSmdPVUFYMFJ6alZxMEJ3d2Iy?=
 =?utf-8?B?cE5PcWhGNm9nZjE5NTBVZTBDQlNSWEhzVVBNdUYvQk5yTWU1a29HUkJXb3Vm?=
 =?utf-8?B?Z3BxZ2NmcGpNQlZLSTRmWWNjOGtXTnJSMG1WaWYrSnVRVVA1U2trRjhqOG5E?=
 =?utf-8?B?eW5Hb1JkN29uQ2R4QmVpb0laYmRpek1sUG5IVCtyUWg1amxQa05ZU3JreW8z?=
 =?utf-8?B?Rlo3Um1Lb1JJZTJmL2E2OWVsVTVaUU9Vdi81UzdMU1ZYRXlsbG4zZVJuckhQ?=
 =?utf-8?B?ZTZSelV4cG1WMWR0dGhpMVV2M0FjTFlZMHBHbCszcXcySm15MDlRdTZ1U1Ex?=
 =?utf-8?B?aW5rUWFpVGJyUDUxMzV5MUxGNDRySHMyc0RzMld0d1E4b2Z5MUJvaTRRNzdu?=
 =?utf-8?B?djF4ck9sWXBqVFZTci9Zb1lRQWtMVDByaG1JdGx2dlpTODRsSzZhamNJYUZs?=
 =?utf-8?B?cS9lSzVremxRRGtFVCsyc25Xb0xhMzhxUTkyckVTRW95ZG5VYjY4azB1M1ky?=
 =?utf-8?B?ZGE4WTlPZDUzZE5kRzlYaTJPc3BKeW85TlJPS2ZrSGtNWGJiN2loR0N2ejhS?=
 =?utf-8?B?NGplWm1GQ1hpZ2ZPcXlQdmEyOTR0V1o0UTRYei9wZFlMUk4rTTBFMkJzQWVn?=
 =?utf-8?B?K09PQmdRNUd1aDd6NFNNeTlVRG8vdjZ3bk11Wlk3MDJrQmxXYW9WcnViM05I?=
 =?utf-8?B?b1RLVFFoQ0Q1cmEzNmpUYld6c3dhMmRXTGpaUUQ0VnEyT01lbWF1Q1Y1Lzho?=
 =?utf-8?B?bGhsTDhYODc5UjJCdTBSMndhWVNITlR3RUEzc3g1NWZhWklFdHFMdEdtYnht?=
 =?utf-8?B?d2ZoUUlQMjJneDRyY2Q3NXplZEZkNlpVSFVlakRzRHROV2xUSjdZTEtSVlFK?=
 =?utf-8?B?cUF0UkpsVm5Sa3J3d1RwQmxZUm5HTG94bjMrWjlHQ3RsVkZSODBmWmhxRlBD?=
 =?utf-8?B?NWhTTlhaWHlHMng4WHo5UXFmeXJlb0ZpM25Jd0tJV0owd3NtcUhNM281eHRk?=
 =?utf-8?B?SHhhOWpWM3NKeXJBcnY4RmVPNTNmTWpKREpYMGs3TnB1MFg2Q0QyNndVK2dJ?=
 =?utf-8?B?M1l0Tk1mcGVoblFhTDJPNWJGM0pteE1tNHg4V1VwQUZXRFZVVlhNc3daNXd1?=
 =?utf-8?B?bkM4KzZBVmhEUVNTbEQ4ZlprN2xzNlBTNkpPM1VxNzViQzlmY1VpSDhYcWN3?=
 =?utf-8?B?SjJyck5YSFJvQ2R2aWd4a1Q2dDZRUTJvZENMZXRxWDkrZXdEVnFqZHBLKzFi?=
 =?utf-8?B?K1JPM0RzdVdURytxV2VuTEQ4UHBXQTM1eEhyRW45UjhWK3FveklTUVBsS2Rv?=
 =?utf-8?B?UVVybjR5MkdBOEhOVnBKTjdmREFTNlBOS1hCMkl5ZjFiNEQyL1lLemIvVjBU?=
 =?utf-8?Q?26WEcmSyJgfoim8wXi9kym2K7?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a046e2-6328-475e-1c11-08db6d3949c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 00:41:42.1186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xwEEcG7R8nHqE9KfFSnIC/h2MpQ5QPrKQN093Jh/KPt46HklURrJl2FIInuJ6ICIChTKCQYshk3M3uomar+ttw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7786
X-OriginatorOrg: intel.com

QXR0ZW5kZWVzOiBKYW4gS2lzemthLCBSaWNoYXJkIFdlaW5iZXJnZXIsIEpvaGFubmVzIEtpcmNo
bWFpciwgDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgIFRvYmlhcyBTY2hhZmZuZXIsIEhh
byBMaSwgSG9uZ3poYW4gQ2hlbg0KDQpDb21tdW5pdHkgdXBkYXRlOg0KCVkyMDM4IHZhbGlkYXRp
b24gZmFpbCBhbmQgZml4IGlzIG9uZ29pbmcNCg0KT3BlbiBkaXNjdXNzaW9uOg0KCVBvc3NpYmxl
IGNoZWNrcG9pbnRzIHRvIGRlYnVnIG1hc3NpdmUgdmFyaWF0aW9ucyBvZiBleGVjdXRpb24gdGlt
ZSBpc3N1ZQ0KDQpSZWdhcmRzDQoNCkhvbmd6aGFuIENoZW4NCg==
