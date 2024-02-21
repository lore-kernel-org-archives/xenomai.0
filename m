Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C0A3B787
	for <xenomai@lists.linux.dev>; Wed, 21 Feb 2024 05:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708494349; cv=fail; b=mUVM3Qfp/JcqyWbwmiJvyi/dlrc4tQt9uQJLfRdeyp7EbFYh4J07CwGKlf52ihOjIw9pEt1x9Ffylzh1Y6NWlKEzvfbi6WAqrJs91wZzxqPGMy1Iroa60F+61sS2ekPYw1xvrGTGnzXvYUBXioZ/Tvja0hQNC/bpHNhwF2ho0KQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708494349; c=relaxed/simple;
	bh=tRdCR6+FPkF6kW5Cn3ti9EGzMqWzDMHNrqWWHEiLPxw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AeHbAN+t6VI+z8wqXQe12MMQCRcyH8nQgJ2SaFJYAtqL0d7llShPDYb8+/GJpaIZYI60CSuVCGpxC9PRiunlBzqnq8KGAJgf6jscOtLAExYUnTBaT4UbR80oGnAMS7GIwT39WLKpxlgBeO+cumTfpuxXziR20oyfvD47IybgBBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hp2Vq1Z4; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hp2Vq1Z4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708494347; x=1740030347;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=tRdCR6+FPkF6kW5Cn3ti9EGzMqWzDMHNrqWWHEiLPxw=;
  b=hp2Vq1Z4lyw+j+f8uqm/euADTDI1nKahiYEXMv/qm5svByFYcHU1Bzv3
   d1rUrV1wiRmAZl5eXMah1P8ClS+302TpNwNJmByQT2vbUUfM4wSMbB9Ix
   pAKzv9NHCuTzxok7o0P/v7w4wHdq0Iu8IMwMUOwAM28R9YiYJaukBali3
   2NeaNBTPZXxP1D6UT91Dy1X2BnGiHG636NETcbX4zUE3Jku3FGSTMBQur
   fDoKEDOdZxHMrUfaO97Y2g5RJoFZtuRsS6Vbi17uUON/gJxQS/3EZrRqK
   yMpVb7qq3chiPlph5sEZMqKHdwZs2e3/epFeeTx2JBDaVDDutUkceVNNz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2749843"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2749843"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 21:45:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="28173193"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 21:45:45 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 21:45:44 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 21:45:44 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 21:45:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSwZOgGyW02bry5VRLbeQRlDGK0qjF1LZa+mjr2fuqJicgUwtOAFmRMZEJHtIg+8TPTQUQzLNhl4xbXZYA/hd0B2Uh/oF23JYqyu0m+vujESjzCD1cgnV6eS8EjljQSCbcmACg+aNtJ0sKfWl3shN+vNyIeEjoOCYHBJgkr45CEf8xo68RMUCYlYSV7fwGrftmf98yQ8kBEUq/gMS4I1lODKx0xCVZcezxDTDyYOnkOoEjEVlr/o/W5fGA5eu9+rLvzy9eBk+X40EApAy35lfs97FtMkX8+x1zMnu9S7AZ+o4Q6TNm+SKaGq/1pOQd77ic6CmbYVtOrohjoEMfMluA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRdCR6+FPkF6kW5Cn3ti9EGzMqWzDMHNrqWWHEiLPxw=;
 b=lGPvkbKh1WFKKWLduWePatfPMpRqgrJUFVEQ4Jb7fppUUpUpRtT+u+9H4ih6aa5YWmWKXz0wMQJ8kwNhxmUNwPcbMxPTcmchK7H1OIMbAF+Bherrx+ZaOhrbtPcMsLOQ4o0xKNTP3kV8o9x9luOma9u0NsXz1oB/GzO1gHIELkrJTLa7ArQiJFUlvaGLLWdMUQv+1O3eF3hudtBuASMXP1YYrB54DX5mLeFevE0nghMCL7rBl72trGrXH485u30mWdT+S/1pABjVLkX7mc9SSqm3AyH+FkB1Yo0dqs9oQ8+34BGG8a5sigv3sAg2E1axq1eZ4dfx8DpRN4TW5576mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12)
 by SA1PR11MB5779.namprd11.prod.outlook.com (2603:10b6:806:22b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 05:45:43 +0000
Received: from PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::8900:99b9:a57c:839c]) by PH7PR11MB7499.namprd11.prod.outlook.com
 ([fe80::8900:99b9:a57c:839c%7]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 05:45:43 +0000
From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Reminder: Xenomai community call on Wednesday,  Feb 21, 2024, UTC
 7:00 AM
Thread-Topic: Reminder: Xenomai community call on Wednesday,  Feb 21, 2024,
 UTC 7:00 AM
Thread-Index: AQHaZIk1OnvoSnziSU6P3Vpm4P9/IQ==
Date: Wed, 21 Feb 2024 05:45:42 +0000
Message-ID: <PH7PR11MB749929DFFDCFE47376883636F2572@PH7PR11MB7499.namprd11.prod.outlook.com>
References: <PH7PR11MB7499F7DDE006A3A7291F61FAF27B2@PH7PR11MB7499.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB7499F7DDE006A3A7291F61FAF27B2@PH7PR11MB7499.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7499:EE_|SA1PR11MB5779:EE_
x-ms-office365-filtering-correlation-id: e46aadfc-ca48-46d1-1e4a-08dc32a057d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6sRfmJwKcyB0lypiMhgOBClWA3fCHlF9Q0fJ8DIF1IYgfBZPxVOPx/IurttD1RCSNLevbpMzZFP0SKVBw1rcoPQdoCpvKALVgmvFGTkSxAwa1ZlDXsWYip3wCsGRYVCxV6xGA0TH6RFppQsaOM4Vy/na4DfsvQjtimzvQ+YLGLNArQB9QFZMJdv8Tova0dRJcObNYYVlLpqVPppZ+FMEQp0j3tHR519EFpX4BY2nC14JgAc/iad38k7jMXc/jsssO+od3UjqwKSSrzR7Ajsroc3Zk5uYqGs7N+phl9jTj4vMewPk0Qgg1/VWTDCSNkSGFLOtmafrXDIt8Pr1zmQ3z5aI3iMSbcFbEONjqGyG9854ozMNuJdjzqFoeIH/PUA4KS7BKC5Nw49kmK0o0AKXkGK5lhE48HDk9nktaFty1FgezcaEvoiMpZQwIn3erUuhrHCQm6f7NtAgA3Mt7U/p1aGsanQBECPTGNsWQViKwnTomGqLQAHfDG4jpfF9PQ17exRZ5h6vukjSCWdJ2WjNuXi4U6qPa4GGLiwqlVqImyiU2YZiD3AuRgX0kM6wlJyrZCDam6iQPC2ZbApJd0y+oEkGWFl+MRHRodJm9hlwgjU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7499.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWJRcjJuWVpiSy9kOGEwUXFKd0JubkFpQ00vU3ZDaCtkQ1MyYmo2Y3M3Yk5s?=
 =?utf-8?B?YjJDR09JTXJGV2JtRHBXazc2a1FveW5XVGlLbExCS0hLazd2a2xWK1BqUGhx?=
 =?utf-8?B?bzBGYzZHeEZjdVNZSHNpUy9JQ2pjdGlYRmNZZ2tUSWxpS2R5c1d6UmdHU3Za?=
 =?utf-8?B?MExtdGhNS3VoL0dXM24xQVJkRGJQY1JtQk5VQXZNYVU0cFBLdEQxVzFpaHpM?=
 =?utf-8?B?NUI3YytEVDhZKzN0MWoyWGN0NFNpQkJGeVlMaXdjbjAxRDdrZzRJaHdKTGdn?=
 =?utf-8?B?Z05Gd2huditHZ1NXRVI2YXlRYUp4MmdUT2djS0NVVHEyRHJHOS96ZER2N01y?=
 =?utf-8?B?dm5YbjVkbHljM1BnOHk2cTViZUZsTTYzd3BpYUptMUVadVB1dFJ6bnVQZms2?=
 =?utf-8?B?SVlqUys1NDJqWndmVExjS0xOZWxmeEhYdTdPdDhJQ3NWQmkyUmIzMkN3QlZr?=
 =?utf-8?B?Z3ROeUI3MjdQOUtUeXluTFdwcyswOTl3eldGbVFRSndKUkxUZVZwZ3d5U0cy?=
 =?utf-8?B?aUxyRFZtU21JWVh0WUtLbEJydXprM2lDSWF3VVNOQmxzUTRudXlOblRMc0s4?=
 =?utf-8?B?bDQ1S3VmU1dkcUdxTisyZG9VeENZMHlEc2xDd1poU2s4KzZLd0RHWExadVhU?=
 =?utf-8?B?bS96bm03WHk3T0dHQ050OHVlaWpzZlBSOVFtY0U0VVl3NUdyY2lBNUEyWUU3?=
 =?utf-8?B?L0g2VEdvM1RFYnZkZ2RGc1JsYThrRmUvVXlqUzJEMzJYd2c3WG5COURENlBC?=
 =?utf-8?B?Uk52eVdIV3UyaGtVcGRGUnNhRHppbnBtSzNrQWlRV1pBdTRHanNKZ2xQRWh0?=
 =?utf-8?B?WUdlMnZNWnpyaXRvWlg2b1VDc3lmWGlXR0FIdG5KbnRLWmJFZ2gzV2ZTWVJL?=
 =?utf-8?B?VXR4NWNEUnZsSHk3Sk9paWhNK2dYTGlYdlpvbnpWOGppeE44SnpjRXdvT1lW?=
 =?utf-8?B?eWpQL0F1SHdQWWVqOGcvcUlpRll3aWIyTThwaFJNVzIyeFFpMUlvbXZ5Ymt5?=
 =?utf-8?B?cWhtemZ0eERzYVhnS2trVFBReVY3UG5nRWZLck95YmZhZFlZOTZ3RlFCdXZt?=
 =?utf-8?B?elhaUWxYM0JKNlgxRzJkODlXZ3ZkNG5zY0ZkV1JuVWo0YlBndThLZXRrWm91?=
 =?utf-8?B?a0JuY1h0ZnJkTzlMcTZSREgvL2FCOGkvbXF2MzNCS00wTVdWbGZKa1N4QklX?=
 =?utf-8?B?RTJEejZrSkwzVFVQYzVyNDdGTkpkZ3o4WHRORVc0aWpWL21SZUhKSi9rS0xH?=
 =?utf-8?B?UnpoVmdjb2dGOWVYZk9heG95QzJ0UGVuS0lwZytNd3VJQVRZOXZGN3pkTy82?=
 =?utf-8?B?R05XemtRdGdqVjlKSGhqVVdIS3E5bHByL1RxTEZrWnpnemJLMmlKbUNEWXRO?=
 =?utf-8?B?TDF4VEtsSzFBbnEzTWhRZ01jbGMzb3J0WDd6SGpqOWNZaGwyOWRTN2lOazVC?=
 =?utf-8?B?bVJsaEM3M0Rua3FmQmd0bHJsUGNWTmt6RDdGYmVwVnhmUlB4OEFWRVoxSHhS?=
 =?utf-8?B?L1poczNxOHpHZ0JnODMwSmovdGoza2FicnhDRHFHOHcyRnUraFQ1bFMvRDdR?=
 =?utf-8?B?R0czQ0ZsZ1JmYkU3ZENYaUF3SWlTZm1DY3BJckt6bEVuNHBBUFlYTVMvdXV2?=
 =?utf-8?B?Y2ZnSkNYblJ4LzNGc2VTbHUxVHMyb29INFNYVHBLaFdrVkQ1V3E3OVpnc2Vx?=
 =?utf-8?B?ZCtsbWFpYStodnZabWo4Z0dIMTBKdThnZkwvSGxrNkZaMndxNWlzWDdiN3dn?=
 =?utf-8?B?MzBJdVRiV2xiaEsxYm1OM0pHRTBwMFZWZTZkaTJOR0FSMkpwanlJOVdlSFBm?=
 =?utf-8?B?Q2JraG5LeDI4MlJ1RTAwZlNLZ1B4SzNXNWZRUGtKQ2ltRk13UmdwWFFCMEc1?=
 =?utf-8?B?RzR3azhxeWJVODExd1RkMy8xdFQvWjN6VEhObFdWY1Y5ZWxmRXhzVkxWSFJw?=
 =?utf-8?B?M3ZxWDBDRDNvTythQm1mWWo5UDY2b0c4MzAvZ3B3Si9ESXpJRXRwd05JamY5?=
 =?utf-8?B?VFpQMjRRSVdsM3VBNU5qbGhMVlhzaHJXbHpqL0dkZjhoMStsWVVvV090SlNV?=
 =?utf-8?B?YXpEaVJxUkJSWFlobS9HMFZqUFpiak1BUm9VUVRITFZVS0FUTkhXOUlocDUz?=
 =?utf-8?Q?RdPZ6MZ7ZecMIwzrvBvqsI5IR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7499.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e46aadfc-ca48-46d1-1e4a-08dc32a057d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 05:45:42.8700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /n7ta1qDpPj2FEGR1e+VQ6C/OopqvKW+g7QZ3CLOTNCkXJ0jgJ++4lXYmSWgnGKS+xOJM8Yfnah1BWid5w+djg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5779
X-OriginatorOrg: intel.com

VG9waWNzIG1heSBpbmNsdWRlIGJ1dCBhcmUgbm90IGxpbWl0ZWQgdG8gdXBzdHJlYW0vZG93bnN0
cmVhbSBwcm9qZWN0IA0KcGxhbnMsIHN0YXR1cyB1cGRhdGVzLCBhbmQgdGVjaG5pY2FsIGRpc2N1
c3Npb25zLiBJdCdzIGFuIG9wZW4gb25saW5lIA0KbWVldGluZyB0aGF0IGFueW9uZSBjYW4gam9p
biBhbmQgYXNrIHF1ZXN0aW9ucy4NCg0KVGltZToNCldlZG5lc2RheSwgRmViIDIxLCAyMDI0LCBV
VEMgNzowMCBBTQ0KUGFyaXMsIEZyYW5jZSBDRVNUIDg6MDAgQU0NCkNoaW5hIENTVCAzOjAwIFBN
DQoNCkpvaW4gWm9vbSBNZWV0aW5nIA0KaHR0cHM6Ly9pbnRlbC56b29tLnVzL2ovOTEyOTcyNzky
Njk/cHdkPVdtZHdTMHBET0RSTk1TOXRRazU0WTFkdmJGbHFVVDA5DQpPcg0KaHR0cHM6Ly9pbnRl
bC56b29tLnVzL3djL2pvaW4vOTEyOTcyNzkyNjk/d3BrPXdjcGs1MmE5Zjk2ZDk4OWU3ZTIwYjYy
OGMyYzM2ZTQ4YjY4ZQ0KDQpNZWV0aW5nIElEOiA5MTIgOTcyNyA5MjY5DQpQYXNzY29kZTogMzY3
NTI4DQpPbmUgdGFwIG1vYmlsZQ0KKzEyNTMyMTU4NzgyLCw5MTI5NzI3OTI2OSMgVVMgKFRhY29t
YSkNCisxMzQ2MjQ4Nzc5OSwsOTEyOTcyNzkyNjkjIFVTIChIb3VzdG9uKQ0KDQpEaWFsIGJ5IHlv
dXIgbG9jYXRpb24NCiAgICAgICAgKzEgMjUzIDIxNSA4NzgyIFVTIChUYWNvbWEpDQogICAgICAg
ICsxIDM0NiAyNDggNzc5OSBVUyAoSG91c3RvbikNCiAgICAgICAgKzEgNjY5IDkwMCA5MTI4IFVT
IChTYW4gSm9zZSkNCiAgICAgICAgKzEgMzAxIDcxNSA4NTkyIFVTIChXYXNoaW5ndG9uIERDKQ0K
ICAgICAgICArMSAzMTIgNjI2IDY3OTkgVVMgKENoaWNhZ28pDQogICAgICAgICsxIDY0NiA1NTgg
ODY1NiBVUyAoTmV3IFlvcmspDQpNZWV0aW5nIElEOiA5MTIgOTcyNyA5MjY5DQpGaW5kIHlvdXIg
bG9jYWwgbnVtYmVyOiBodHRwczovL2ludGVsLnpvb20udXMvdS9hVEVBMzdpNUcNCg0KSm9pbiBi
eSBTSVANCm1haWx0bzo5MTI5NzI3OTI2OUB6b29tY3JjLmNvbQ0KDQpKb2luIGJ5IEguMzIzDQox
NjIuMjU1LjM3LjExIChVUyBXZXN0KQ0KMTYyLjI1NS4zNi4xMSAoVVMgRWFzdCkNCjExNS4xMTQu
MTMxLjcgKEluZGlhIE11bWJhaSkNCjExNS4xMTQuMTE1LjcgKEluZGlhIEh5ZGVyYWJhZCkNCjIx
My4xOS4xNDQuMTEwIChBbXN0ZXJkYW0gTmV0aGVybGFuZHMpDQoyMTMuMjQ0LjE0MC4xMTAgKEdl
cm1hbnkpDQoxMDMuMTIyLjE2Ni41NSAoQXVzdHJhbGlhIFN5ZG5leSkNCjEwMy4xMjIuMTY3LjU1
IChBdXN0cmFsaWEgTWVsYm91cm5lKQ0KMjA5LjkuMjExLjExMCAoSG9uZyBLb25nIFNBUikNCjE0
OS4xMzcuNDAuMTEwIChTaW5nYXBvcmUpDQo2NC4yMTEuMTQ0LjE2MCAoQnJhemlsKQ0KMTQ5LjEz
Ny42OC4yNTMgKE1leGljbykNCjY5LjE3NC41Ny4xNjAgKENhbmFkYSBUb3JvbnRvKQ0KNjUuMzku
MTUyLjE2MCAoQ2FuYWRhIFZhbmNvdXZlcikNCjIwNy4yMjYuMTMyLjExMCAoSmFwYW4gVG9reW8p
DQoxNDkuMTM3LjI0LjExMCAoSmFwYW4gT3Nha2EpDQpNZWV0aW5nIElEOiA5MTIgOTcyNyA5MjY5
DQpQYXNzY29kZTogMzY3NTI4DQoNCg0KUmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQo=
