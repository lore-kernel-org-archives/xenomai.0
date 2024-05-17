Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0863D546
	for <xenomai@lists.linux.dev>; Fri, 17 May 2024 13:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715950861; cv=fail; b=BWdtHIciH5C4bI7bQbE3Le8LDoeqAsmAutm1OcA5w0ynagLAXbjgbr71jwilABrvYV593DqPBhe8AgK0U/Mxe87ntsZpIsb043AIEOPqPJCYHWxQeqHzsHsb7r9xnMGZ+QXnFraSYDlwDgXSEPgJRMQSpfM3jQRrTZGizow8EFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715950861; c=relaxed/simple;
	bh=kiGcKcw8GUlN2UaU7mZ2YPxeicA/WlFt084bqpLhJXg=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nhvZXGlcYF23nXnTb53btGdjN5fY+KjqlEjgFN+3MQckbS42ehJPTXlOClph/5w597z4YPTtFLPyjHnFOJeIwgXKPG7jvlcYd6l9f5G1C/v5V5kUwcXqngn0k9MqQNW01dA9iSpcB8Q/Gr+bg0AHhhxCbqCk2m5wLqWhJ5vxZWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LWlkTmhr; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LWlkTmhr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715950859; x=1747486859;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=kiGcKcw8GUlN2UaU7mZ2YPxeicA/WlFt084bqpLhJXg=;
  b=LWlkTmhrhjSufgAAg+dZCAw8dN8c/07o1QMP/BSZJIpu169xv4FilS1y
   /SLraLJqlf62rmmdgp1/Ov4DolW7ofR9Y6ESlJGwOQf2gWSwwFDpAq27s
   VGHajweS8znrrjvL47Rg3QtGBVZ0ItFMYwPD84wWeGq+XhC2ZnN+npAqt
   PLcI+EylX0aS1aAtvb9pZQ/MmwJH3AzVdCBcy31dQhsS+aexGxJMrWoQy
   UXVWuPBYoVcFp4pw43yBIbnNI1xOd3TqCM1A2QhnFsuwbXH+PWA2vwS2S
   DJOJ7TmO3vZwiLLJFSamZZHk0yHX1QFUp5+NRWiv9bua2Pkd0by+cXQPi
   g==;
X-CSE-ConnectionGUID: AbkVDFvRQo2JDDs/Qa963A==
X-CSE-MsgGUID: JzGOfKt7Qoe2zZXWZaSm8w==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="29627947"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="29627947"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 06:00:58 -0700
X-CSE-ConnectionGUID: U6zfFY4fT+WSZyDIvcsBUg==
X-CSE-MsgGUID: fcswUFDxQWexw9jU8qr2Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="69232712"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 May 2024 06:00:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 17 May 2024 06:00:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 17 May 2024 06:00:57 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 17 May 2024 06:00:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nkhOKz9f6XYJm1xC7oK5fMfdzptiCIPIzrwOU51Rp0RSfH84gaUsYWmAd2XXIN3/euCNp9ByZoxv1IQjO3IMWdaHo1fqfhVSnvWW02mcfk8tcIUa0ZwsH9ltWcZB0gnaSlzyirYPEsRWqOmRmSCCOqbz9lszRkOdfAXXMLvDvOaAV9Ew6xWmRB+FVg2OXz46W86shRAvrwgj1aSfLLR5t3aOYOuK6pqPxCFeDzlYdX8zgHr9cOBtgBh/6HHgqYoSopGWSsycPnWTPV0y6KF3eKyQlIw+oMbTUASgJRa+J6jKSTvVdjvfwK0gLPaOiLmK/fSvibXDHPrcxI5bXYu3rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUsmmox7Aefd+bJ41JUgAIulj7BLgbFQhm1WiKGKF30=;
 b=FFwq7jB7chRxLyxdPU9WBzt93h4ZLOqw/fFrzBEbhtNPmh8uiBlBrwMLOkTzQ9nh5JNZO2EfIXld328/hkwKzXRaXJPpA1aCZnFEKQS+Yv2VQafDD701Au9Lf4zfnE11m/OD1uQyn0v3zC2/ZeJOskV6Vs6uFwQrs/x162+oKgtiyA3qz/gBzFH8j6Ju4p5le43fXa5U+hu+cGZDBbzkCfUbDvohcWcJRzF8Uj/KmpyNket6XTfBY1/nKCHAYoAvoCtZk96T1FGmrcNKKc5kirKofJxUco+4iRfYObXn8GUHY0Hs/9S3xS/CDIVO1cj42MAZSSBQS4+/ww4HJ59JrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5949.namprd11.prod.outlook.com (2603:10b6:510:144::6)
 by IA1PR11MB8245.namprd11.prod.outlook.com (2603:10b6:208:448::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Fri, 17 May
 2024 13:00:55 +0000
Received: from PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861]) by PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861%6]) with mapi id 15.20.7544.052; Fri, 17 May 2024
 13:00:55 +0000
From: "Nechita, Ionut" <ionut.nechita@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: WARN Kernel v6.9-evl-rebase - poll_idle
Thread-Topic: WARN Kernel v6.9-evl-rebase - poll_idle
Thread-Index: AdqoWfw8Y7O5/BzdQqKimOgS8hEcJw==
Date: Fri, 17 May 2024 13:00:55 +0000
Message-ID: <PH0PR11MB594952BA30D4672C8271E6A0F4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5949:EE_|IA1PR11MB8245:EE_
x-ms-office365-filtering-correlation-id: f775f901-d487-42de-4b55-08dc7671638d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?6m5sb/lfjTF0wA+MgVWUpJxUBAqaOuFTbhLVU7PhbY85xhPyyI4xnoE3e2UT?=
 =?us-ascii?Q?RFakE+NbV3GApIHLj5/zXFEmpY1gkdAIFSUHpusvQSSAyZh/5yRUUKIOlaMv?=
 =?us-ascii?Q?rWPiHSmQt1nxmqRdIobdlfpri+5lNRFVWwgtU/BNh/hjYUPX98j9/UyPJunI?=
 =?us-ascii?Q?aYmr/NVyX7Tik4UEvsoRu7i0ssduHURE1XZFnLOF8ryGHzDhqdC3e/bPoRK7?=
 =?us-ascii?Q?rtkrbrScWRJ8pLGBlXAjMyePLBa9wqR9621JeLwuvKTbWH1WQ+WfSwEDepRh?=
 =?us-ascii?Q?/lJY14CHH8bsIqxbjhUAk25v4+dUsg4G+mPa3fQNKZW+kBeyXqAMrlthaGow?=
 =?us-ascii?Q?ytSqp72WjVXoWWi775HaybF4wLb2AE0nLax/HfbZDtAgheTlGND8LQtQnLpH?=
 =?us-ascii?Q?WXJC1XxGTN7CYGj5HxK/iE+/kYTyAiksGaIn9AOD5yfyWIF4n4lZErOA/zBP?=
 =?us-ascii?Q?TCOqTiMth+AtabXpvHyMdAH4+qV5KNJ3PplM1nSHB3dKBF14/LE6IiPh5izv?=
 =?us-ascii?Q?x7o46368A3GbZbcecWmyvUuE3E2qiEjdvMNkAIOreMGUAttn+5J+NHiCvM5h?=
 =?us-ascii?Q?Inc+Y5eT6meHyLsSAzgY2Ty5JqNl6rjvvAQ0ZPJ3ULKUsNskMb/QPSO6TmhN?=
 =?us-ascii?Q?bmuDOv0p6RpFdg9RL7/BeFuphfU/iR1SkG/oXzQcGmScsyITGk3JC6Z2DZyI?=
 =?us-ascii?Q?z2b9B3+ezBAPDydSrzJLSW3BOvKOa+B0+H9tqU+79pY1zAAlygt54HzBjcx+?=
 =?us-ascii?Q?FTG7cuImZjKl23CokSkyYTH7NbhlUWnw268lzMmsWsvlWOKR6+B4QEYprQRA?=
 =?us-ascii?Q?cGIMP7z//QgE8WqflrDR317WwbiD1cHvhp1ITXXCGjkym1VV/XhPHhUvdsV2?=
 =?us-ascii?Q?8CfeQHq0vWcC/VvCu7cTCmK9phxpXAH1MGCLfgGcd+EmoYXTlcS5tErEmxgS?=
 =?us-ascii?Q?VauHOqBHPHLCbGd0OJeyBv6c9hRWFeMEvb6L3VPVmgVVy6+N/NVig6gp+xvk?=
 =?us-ascii?Q?/FTOYjBsOJJjepGj12WUyHIj4kWG3B8rWRRpL+veJjIH9iAZHfK7GSz86kIM?=
 =?us-ascii?Q?/SFB/oeWvLmwp3XeRE/OJX9JHUxSlvZmirGdqd2Sc6Tv/OzuR7xrYx0gx1Y6?=
 =?us-ascii?Q?Lnq+bNEb3uPnHkE7Ou6T10847ja7QNfR3xqLCjWS+KMTOf8PDzWtHTA2LR9D?=
 =?us-ascii?Q?x+AjZLBygBafL/qampbOF4G2xPeXHQsd9mS+HlDisf+nuxnkRZfuXcEvk8jy?=
 =?us-ascii?Q?utd0LKloaZFbjZYIYMe81mGdSfLOAKT9qNcizCQYfJhFn+HcfLVvhqHlIYCE?=
 =?us-ascii?Q?4czR7FC/79iTGTxSaoersOT4YnwtEnwiHX84TsVdFLMbxg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5949.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QSgeggsm3nSBB4yWTETRJ/2MO+flPj8eGoIsiUYACYHSc75XvC22hTK9Fqrt?=
 =?us-ascii?Q?UDuqkQy9tvM0d1IzhFn5M98dx8DrGb+ZaHsE6qkTkAJ/Y8z7AWc1NCbPNeIJ?=
 =?us-ascii?Q?ziEbU8krEbdHnM02vOTxV2bcpICFDoC1ibbH+YwLJVCg/Z1qBBgsumwIBbH5?=
 =?us-ascii?Q?Gy/XtSav0b+RRzT52QPiIIBrGTAYIK/1xQEJoDEM0xyMuRY8U+P2UwicGrZ2?=
 =?us-ascii?Q?49qg4x8AfnW8skZxz7QBUvbiEfzYj6lCGCbmHFQR0TxrvtE89yzgEheBcItD?=
 =?us-ascii?Q?B8tD92+U5iI+dwf06gT904G0HeOxloTmvpSfbnJsPLgcO9x6z+prEIlC0hiC?=
 =?us-ascii?Q?Y4uqkDat6T5eNWex4oN1RgX+mTXiA9KdG9ERgKJaq1Q5ohVSd9OMhD4vAssG?=
 =?us-ascii?Q?OH0TVhadgf0z60InGs5qaMIzudV5Vfm6GCp1J5dmh9ZZgXA2JCwl2wpZoPJ8?=
 =?us-ascii?Q?ZlO4Cn1ropsLVGwayIWr8+uSYujnipb4zIh7uqsG1zefbkEeCmu3maC1w+HE?=
 =?us-ascii?Q?/Gc8qt7phan3TIsQGBgW9hpt6pUoNkyDrhqkNm0vs+diMX9E2GXzfyWxp0es?=
 =?us-ascii?Q?Lf3rP1ay+P5rVqXzA8c5vwOGIc6lUiUG5rgwWnnmPdR7Tw70CubHqt4jsxXD?=
 =?us-ascii?Q?jwxupRDkoMl6RYoue97GQiLFFvtS4jpwkyGKi2qbrWT92Ah2yysqSnFXIthV?=
 =?us-ascii?Q?269EG9A91np4HGHMJuO5rtP6Utu+mpfk69sjSDKVS0uLKZJryfcA04IHRjQv?=
 =?us-ascii?Q?y3+swRVcUKs6aLxMcOs6H0qh6B9RryB9EqIk3RUoO54GzSIQiR93Gd1kTXtq?=
 =?us-ascii?Q?tlltXvNWPHuahm9b+sA/eeV3n5UrtOEjPalwPHNMOzhbUFLKMNriKjYvQaq6?=
 =?us-ascii?Q?zt7SGMU9s+t0EsVFmSZi9rN/ZSdA/RP5TizrrCvyXnUQhBqFsjreh3YLJJnp?=
 =?us-ascii?Q?4B95W99qbRXj3auEpCCujk6JyxCOm5xgwf8SmtYlfiBAn86bepEliZMJNrKN?=
 =?us-ascii?Q?snpyZ3ltqlrcvkD06mYBpRD2EXtAvYnvO3YmlK2tjf3ZVjpBJZV9VzhZp+ZV?=
 =?us-ascii?Q?G1byygD05sZTPUfccCuJ4t5kC3eUAnktN4lw+xqP3e2nLtIiX+a4XMFVQHlt?=
 =?us-ascii?Q?Aam9AnCsUb0uq4OcxAhKKfBRzEnB1vk7fvGZsQUUGkeOsSi17PtS+qP12yo1?=
 =?us-ascii?Q?yvkZe/SxMvzMG0OTW2iAR2gzVy55G98QvoUxCgoivaJ1qRWOUaTP1qtUppr5?=
 =?us-ascii?Q?zPVTVA0FfbVALpA2PO10Ev1a7Ih48S5wok6JprEIW3X0Jr4cqEBo8/g5we0D?=
 =?us-ascii?Q?Aa/ZcLOrGiD88YyKoyz9NWcLBtKlnNtjSUrQpWT3Y0K0ukU0YV9H6anf9h/4?=
 =?us-ascii?Q?tDHbJpu1HX53esHVsa2CdAMfp6EDH2zOpb5CwXDGytP6zsPIs/javW7+USrm?=
 =?us-ascii?Q?rgFRWxRy2ljAaRn2Jg0OVlj9OiAiQV0UQv03fvIOT3oEmeL/bklOOne5p+mX?=
 =?us-ascii?Q?0pXT7+QydgGYoB3QMs72jRoZ5UUD+L5nq8n4/8PRO992SblLA4b9yAGmqdbz?=
 =?us-ascii?Q?4Q5dz0nOwoKkmpBR9d1t8tkWEeHBjZUpQzaJXvFb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5949.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f775f901-d487-42de-4b55-08dc7671638d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2024 13:00:55.3099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PD/5IxETOb39fG6apHJW+dYZ5pzHCtPgerQU+jhvyzXGa9MINt4UqsGNLCiB4N34AfgdMUH3kelffDI9r+uUIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8245
X-OriginatorOrg: intel.com

Hello Xenomai Team,

I notice one warning message today in dmesg, when using 6.9-evl branch.

Output(dmesg):

[    0.447973] ------------[ cut here ]------------
[    0.447975] WARNING: CPU: 3 PID: 0 at kernel/irq/pipeline.c:303 inband_i=
rq_enable+0x21/0x40
[    0.447981] Modules linked in:
[    0.447983] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 6.9.0-x64v1-lowlat=
ency1 #4
[    0.447986] Hardware name: Intel(R) Client Systems NUC7i7BNH/NUC7i7BNB, =
BIOS BNKBL357.86A.0083.2020.0714.1344 07/14/2020
[    0.447987] IRQ stage: Linux
[    0.447989] RIP: 0010:inband_irq_enable+0x21/0x40
[    0.447992] Code: 90 90 90 90 90 90 90 90 90 55 48 89 e5 53 0f b6 1d 35 =
05 3d 02 80 fb 01 0f 87 ba 6f fd 00 83 e3 01 75 09 9c 58 f6 c4 02 75 02 <0f=
> 0b e8 58 ff ff ff 48 8b 5d f8 c9 31 c0 31 f6 31 ff c3 cc cc cc
[    0.447994] RSP: 0000:ffffa955c012be00 EFLAGS: 00010046
[    0.447997] RAX: 0000000000000046 RBX: 0000000000000000 RCX: 00000000000=
00000
[    0.447999] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000=
00000
[    0.448000] RBP: ffffa955c012be08 R08: 0000000000000000 R09: 00000000000=
00000
[    0.448001] R10: 0000000000000000 R11: 0000000000000000 R12: ffff998b1ed=
88c20
[    0.448003] R13: ffffffffad67f8c0 R14: 0000000000000000 R15: 00000000000=
00000
[    0.448004] FS:  0000000000000000(0000) GS:ffff998b1ed00000(0000) knlGS:=
0000000000000000
[    0.448006] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.448008] CR2: 0000000000000000 CR3: 00000005e2232001 CR4: 00000000003=
706f0
[    0.448010] Call Trace:
[    0.448012]  <TASK>
[    0.448014]  ? show_regs+0x71/0x90
[    0.448018]  ? inband_irq_enable+0x21/0x40
[    0.448021]  ? __warn+0x8c/0x160
[    0.448025]  ? inband_irq_enable+0x21/0x40
[    0.448028]  ? report_bug+0x1ab/0x1c0
[    0.448033]  ? handle_bug+0x52/0xc0
[    0.448035]  ? exc_invalid_op+0x10c/0x140
[    0.448037]  ? asm_exc_invalid_op+0x1b/0x20
[    0.448041]  ? inband_irq_enable+0x21/0x40
[    0.448045]  poll_idle+0x28/0xb4
[    0.448048]  cpuidle_enter_state+0x9f/0x490
[    0.448051]  cpuidle_enter+0x2e/0x50
[    0.448055]  call_cpuidle+0x22/0x50
[    0.448059]  do_idle+0x22f/0x2a0
[    0.448061]  ? complete+0x6d/0x80
[    0.448065]  cpu_startup_entry+0x2c/0x30
[    0.448068]  start_secondary+0x119/0x140
[    0.448072]  common_startup_64+0x13e/0x141
[    0.448077]  </TASK>
[    0.448078] ---[ end trace 0000000000000000 ]---

Lscpu:
Architecture:             x86_64
  CPU op-mode(s):         32-bit, 64-bit
  Address sizes:          39 bits physical, 48 bits virtual
  Byte Order:             Little Endian
CPU(s):                   4
  On-line CPU(s) list:    0-3
Vendor ID:                GenuineIntel
  Model name:             Intel(R) Core(TM) i7-7567U CPU @ 3.50GHz
    CPU family:           6
    Model:                142
    Thread(s) per core:   2
    Core(s) per socket:   2
    Socket(s):            1
    Stepping:             9
    BogoMIPS:             6999.82
    Flags:                fpu vme de pse tsc msr pae mce cx8 apic sep mtrr =
pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe sysc=
all nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good no=
pl xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64
                           monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 x=
tpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsav=
e avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb pti ssbd ibrs i=
bpb stibp tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc
                          _adjust bmi1 avx2 smep bmi2 erms invpcid mpx rdse=
ed adx smap clflushopt intel_pt xsaveopt xsavec xgetbv1 xsaves dtherm ida a=
rat pln pts hwp hwp_notify hwp_act_window hwp_epp vnmi md_clear flush_l1d a=
rch_capabilities
Virtualization features:
  Virtualization:         VT-x
Caches (sum of all):
  L1d:                    64 KiB (2 instances)
  L1i:                    64 KiB (2 instances)
  L2:                     512 KiB (2 instances)
  L3:                     4 MiB (1 instance)
NUMA:
  NUMA node(s):           1
  NUMA node0 CPU(s):      0-3
Vulnerabilities:
  Gather data sampling:   Mitigation; Microcode
  Itlb multihit:          KVM: Mitigation: VMX disabled
  L1tf:                   Mitigation; PTE Inversion; VMX conditional cache =
flushes, SMT vulnerable
  Mds:                    Mitigation; Clear CPU buffers; SMT vulnerable
  Meltdown:               Mitigation; PTI
  Mmio stale data:        Mitigation; Clear CPU buffers; SMT vulnerable
  Reg file data sampling: Not affected
  Retbleed:               Mitigation; IBRS
  Spec rstack overflow:   Not affected
  Spec store bypass:      Mitigation; Speculative Store Bypass disabled via=
 prctl
  Spectre v1:             Mitigation; usercopy/swapgs barriers and __user p=
ointer sanitization
  Spectre v2:             Mitigation; IBRS; IBPB conditional; STIBP conditi=
onal; RSB filling; PBRSB-eIBRS Not affected; BHI Not affected
  Srbds:                  Mitigation; Microcode
  Tsx async abort:        Not affected

Lspci:

00:00.0 Host bridge: Intel Corporation Xeon E3-1200 v6/7th Gen Core Process=
or Host Bridge/DRAM Registers (rev 03)
00:02.0 VGA compatible controller: Intel Corporation Iris Plus Graphics 650=
 (rev 06)
00:08.0 System peripheral: Intel Corporation Xeon E3-1200 v5/v6 / E3-1500 v=
5 / 6th/7th/8th Gen Core Processor Gaussian Mixture Model
00:14.0 USB controller: Intel Corporation Sunrise Point-LP USB 3.0 xHCI Con=
troller (rev 21)
00:14.2 Signal processing controller: Intel Corporation Sunrise Point-LP Th=
ermal subsystem (rev 21)
00:16.0 Communication controller: Intel Corporation Sunrise Point-LP CSME H=
ECI #1 (rev 21)
00:17.0 SATA controller: Intel Corporation Sunrise Point-LP SATA Controller=
 [AHCI mode] (rev 21)
00:1c.0 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express Root Por=
t #1 (rev f1)
00:1c.5 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express Root Por=
t #6 (rev f1)
00:1c.7 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express Root Por=
t #8 (rev f1)
00:1f.0 ISA bridge: Intel Corporation Sunrise Point LPC Controller/eSPI Con=
troller (rev 21)
00:1f.2 Memory controller: Intel Corporation Sunrise Point-LP PMC (rev 21)
00:1f.3 Audio device: Intel Corporation Sunrise Point-LP HD Audio (rev 21)
00:1f.4 SMBus: Intel Corporation Sunrise Point-LP SMBus (rev 21)
00:1f.6 Ethernet controller: Intel Corporation Ethernet Connection (4) I219=
-V (rev 21)
3a:00.0 Network controller: Intel Corporation Wireless 8265 / 8275 (rev 78)
3b:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS5229 PC=
I Express Card Reader (rev 01)

Linux 6.9.0-x64v1-evl1 #4 SMP PREEMPT_DYNAMIC IRQ_PIPELINE Fri May 17 15:51=
:27 EEST 202 x86_64 x86_64 x86_64 GNU/Linux

Best regards.
Ionut Nechita.
