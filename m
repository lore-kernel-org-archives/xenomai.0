Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34939254AF4
	for <xenomai@lists.linux.dev>; Tue, 20 May 2025 01:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=217.70.178.231
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747703461; cv=fail; b=MUccF6JFFuEa2g+q2LYbXJA5Z/urGzQ+IclHGwjtXX9DOUePHl/Wt1VXJnTuKihVNNexRNwNhheSDJehrUUwN8yf8rGZs3fGA+IJLAxazARZz69wH4t73hUJRxpn8hwBrn6m2OQUAoYFeyMdHZgcmQH/LZGEWrw9TqXABG8/H44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747703461; c=relaxed/simple;
	bh=2eOlZkVs81+KVVgB6Ggt+dJaDWQG8Le+5/QqiO20vW0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DZLwSA36ZgKfye/dtOSHH3WZuNt5LMcPEKizoiYFWMTZbSxVztTiMsHqykH1vmpsF2+WeJYEAzd2LUVsGwKwiNxjCxuPYt5UVCjg2ldFXvPua4FOJ27mC3aUuqjunCw8X8w6XdZ+lmLFyKgHMch4fwEvwO1MQCbwf+l+fFAe4js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doosan.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (1024-bit key) header.d=doosan.com header.i=@doosan.com header.b=M1WItVzR; arc=fail smtp.client-ip=217.70.178.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doosan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=doosan.com header.i=@doosan.com header.b="M1WItVzR"
Received: from spool.mail.gandi.net (spool9.mail.gandi.net [217.70.178.218])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id ADF9543691
	for <xenomai@lists.linux.dev>; Tue, 20 May 2025 01:10:50 +0000 (UTC)
Received: from PUWP216CU001.outbound.protection.outlook.com (mail-koreasouthazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c410::1])
	by spool.mail.gandi.net (Postfix) with ESMTPS id E796C43D81
	for <xenomai@xenomai.org>; Tue, 20 May 2025 03:10:49 +0200 (CEST)
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=doosan.com header.s=selector1 header.b=M1WItVzR;
	dmarc=pass (policy=none) header.from=doosan.com;
	arc=pass ("microsoft.com:s=arcselector10001:i=1");
	spf=pass (spool.mail.gandi.net: domain of junesoo.im@doosan.com designates 2a01:111:f403:c410::1 as permitted sender) smtp.mailfrom=junesoo.im@doosan.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aKaqIHAD3u9EXrhhG2fwReU3peNDHdqU05jGaPo2FBYsiJ0hJQAMtymNWraJbaedo8Pp8culM/E/Er0TOuUuQRxX07sETuEbC1oNOjjKqOvjwatiovfwLdMkojYKqr66f4XhwFQkm0tHqh5pbbqCJsHjx7g8ifDNmxKGr1771H5m7ighyO7jjmsujpS+GivCS3+KGm1iMWCl/FA3DKlgvG3ukcTlsU4k9CordpeJyw+ac4Nr/kphQ7l3yly7FG+lSrRxa9wcwU5kk07YYpiiperAoDGKWAGohx4GGR1GGpu1bds6oxVIdFMThzqIBXsVl5rKDqG5vDu+G1EVtIp+UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2eOlZkVs81+KVVgB6Ggt+dJaDWQG8Le+5/QqiO20vW0=;
 b=ToQIxFXReJPnexTbOU2ybO47lnA4juPn3VtonzfmD9byOBQuyEUn1WJ/yThO9TjmgfiGP/ZyruCZIGhh9OFF7gGsKDZVe82ayCIztJgUQgTUWKWiPbAep7tOYUK76MyrTbDJQX33OAPWuSAptxsyFmbAuzckTlHGRVt0I+Qhm65TY4Qo2zEZYnGVODjn6E6ICP6lFFAwOEflf2UtEtPlwkQNn8uNF6Ugbt0FoPBIFpHHwJtcuyJPD9OVjgVfsDNyyJqvN0yCxU2GWJj/Sly+H3J2RwUVRZmmf3HEFk4iYcZIMnhixqqbvp6YcWAp8JIkUaQE3tVwowUIl4i0jQVgAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=doosan.com; dmarc=pass action=none header.from=doosan.com;
 dkim=pass header.d=doosan.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=doosan.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2eOlZkVs81+KVVgB6Ggt+dJaDWQG8Le+5/QqiO20vW0=;
 b=M1WItVzRoLndk8VqWJT5d86BkIrFlnTBJ08nID9PQhafdtKmHaQeFAwEjvT0+V0BgAtR5oSHi33RvWV0k7/vOKr2mpBTrldyJadW5ojjz76C0HyQJ1A7hipCNJGsqJWnOxPZ6JYjStkaV5eOG1Urq+UU1GGwB6nKXyqImq3x144=
Received: from SL2P216MB2274.KORP216.PROD.OUTLOOK.COM (2603:1096:101:151::13)
 by PU4P216MB1424.KORP216.PROD.OUTLOOK.COM (2603:1096:301:cf::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Tue, 20 May
 2025 01:10:45 +0000
Received: from SL2P216MB2274.KORP216.PROD.OUTLOOK.COM
 ([fe80::a9ab:83f9:e987:37d4]) by SL2P216MB2274.KORP216.PROD.OUTLOOK.COM
 ([fe80::a9ab:83f9:e987:37d4%4]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 01:10:45 +0000
From: =?utf-8?B?7J6E7KSA7IiYKEp1bmVzb28gSW0pIOyImOyEnSDrkZDsgrDroZzrs7Tti7E=?=
 =?utf-8?B?7Iqk?= <junesoo.im@doosan.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@xenomai.org"
	<xenomai@xenomai.org>
Subject: RE: Please recommend the appropriate Kernel and Xenomai version for
 my hardware.
Thread-Topic: Please recommend the appropriate Kernel and Xenomai version for
 my hardware.
Thread-Index: AdvE1hezpDCCPZ86SYGuLq6OIRavHwAGVLEAAEWrX1AACMDQgAC8iCmg
Date: Tue, 20 May 2025 01:10:44 +0000
Message-ID:
 <SL2P216MB22743BCEFFE944092372BE8BE09FA@SL2P216MB2274.KORP216.PROD.OUTLOOK.COM>
References:
 <SL2P216MB227453A028F3203C05B5A8B3E091A@SL2P216MB2274.KORP216.PROD.OUTLOOK.COM>
 <14e0c75f-9f4f-4035-8bed-5f798bc164f4@siemens.com>
 <SL2P216MB2274E85F2E9ABB2A869F54B7E093A@SL2P216MB2274.KORP216.PROD.OUTLOOK.COM>
 <149e9ecb-4b46-499a-9205-ca7641e4bf7b@siemens.com>
In-Reply-To: <149e9ecb-4b46-499a-9205-ca7641e4bf7b@siemens.com>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2P216MB2274:EE_|PU4P216MB1424:EE_
x-ms-office365-filtering-correlation-id: fc072ccc-c0c1-4ffa-2825-08dd973b25e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z3lMQktlMXRpYjIxeGw4bkRQVmp5Nm5IdWQraDRvTWEzTGJKZzJ6TUI5c2Z1?=
 =?utf-8?B?dFR1TDV6T3JZQmd4MnAvdzRWS1FJVStudksrMmcyRHVuWjhsNUwwKzJrRHdv?=
 =?utf-8?B?OFA5ZEUwL2N4RUtGR1F5a0FxQURDNHBBRkRmUUlveTFvRnlPYURjd3lxd01m?=
 =?utf-8?B?MWJHM2c4WUZWQzRsdWRHbHlhTWU5WkRXMzE1cmlJRmdmUVJOaUVvOUdibksv?=
 =?utf-8?B?OWNhd1lKYmR2MlllT0FtQ21razNyTGFHZlBpdFV6cWlQc1ZJTURneE1uYmpX?=
 =?utf-8?B?RmM2NUoveUZwd2t2RnhnV09EV3U3RU5mZUxNRUp4ZGRMOU5KRDRkait5T0Fv?=
 =?utf-8?B?T3ZOWFNzL1ZINVlraXRYMStWTi9iOFVQRTVtekMrMjhHQm4xWHJBb0lUdHJ6?=
 =?utf-8?B?WmJRTkRpeW9ER2d3VXVxS1FzZ3FkSW9MSkxGUFRJMXUxNUVrRUFmL1BrQnZH?=
 =?utf-8?B?cm1ubGtydEUzZDRTMDZsVnZCVzgzN2pib05RbXp5SHU4aktaYnlKMnlCRXhp?=
 =?utf-8?B?VE1wYUppWnY2S2dzdGtGV3NOMkdpbjg1dFVHOC83cjM3aHFLVVQ3YmNNLzZv?=
 =?utf-8?B?dmp1ZUNuNDdZQ3hDdHNhaFlPcThVR1pBUVZEN2VNYkhnT1g4TGFGUW9waWRD?=
 =?utf-8?B?aGdLaXRQNFVLRW90V3oxZUFkTWJSQ0g0YWpHK2IvZmpRZ2tvd3czQ1RiMlZl?=
 =?utf-8?B?M0laL0dwcHp0QWlTV0MrOTArajdaZkQzNUZtWDg5eWk2UktERG10T0RmQVlU?=
 =?utf-8?B?bTNCeWRNaFB6YkxOWHl2QkxiUjBkWHJkdWtRa2lnVy9MMXB1YWN2TUtNNjh0?=
 =?utf-8?B?eDFrTk1uZGN5ekQveDVmUFRnczhVZERZYXNQdjJGU09tUHlRVTZsbjZha2JS?=
 =?utf-8?B?OFlkRlpBc0hWZVFVa05qS0U0Ky9UaC84VGRQUjRZYU5jNHF5bngycDBQWjVz?=
 =?utf-8?B?dWd6WUNtUFp2bzlHLzYvWDErVjhPRkJheUYra1ZDbG9QQ201TERvYWJGcFBQ?=
 =?utf-8?B?QXZYdHNnSDRXdGFLRlhhNnJWdWtjaHV5ekZVK2d1VlBnT0tvWVQxOFhSMjZO?=
 =?utf-8?B?dldEdUtqOGZyYzVlaGw3bkVBVmhialo1RkhKYk5xam51SDJVc1JUeVpzdmtX?=
 =?utf-8?B?b0ptaE0yYlhBUSszdWIzVUJDSENPRDBGNkVtcjhCdHU2YzlkNC9hUEg1eVhF?=
 =?utf-8?B?UmNsdkhCL2drdWJMcGs3QzVWT0puR3ZTREluMTVFWk4vd1UzQVhicTlpN0x3?=
 =?utf-8?B?dUVsQi96Z01wNjFON25PZzc0WEZHT01qQll0a2VlSUlGU2xDM0todk00WnBk?=
 =?utf-8?B?STJXbGpmOFptZjVab1pzM3BCS1ZQU2ZibEhaYTNwbktvU3IwbGtiUjNLNmxn?=
 =?utf-8?B?WnFFTlM0YmZxUjlDeFNJM2orQ0JlS2phRVI3NGVWVU50Ujh1VzhTMEsrV25q?=
 =?utf-8?B?UmZmUmozTXVZRVZRdVpRUy9ocTZtV2tqaDNPTDZCalVhbGhxdzBtR1BaMG1s?=
 =?utf-8?B?Y0lySmFSSElLVm12VEl2dzZnSGlzLzRsM3lNMFlyeHhXTEdTWStmSithVlRV?=
 =?utf-8?B?MU1mOEtDbzV1N05EeUNmTEEvcmQwcDNpWjR1NUswWjB1cTMrWWJtMHlRWTdX?=
 =?utf-8?B?OG8xZ05QdWFpaUdhcnI3U3U4L2lObTFVbUlzR2Nrc1B4US9McHVjb1B0QWNv?=
 =?utf-8?B?MUhlQ25ydmZaZkh6V2hhOTJXUHhPRnR1TExnUUtobVgyamMvb2NDcDlwSHFK?=
 =?utf-8?B?OUJjUnl2R1JjY0JGOFVjVkhLWTRFMXcyaFQzMktkVUJMWktBbVp0ZVZlUmcz?=
 =?utf-8?B?K243dnFncUhQWENoOFhoTlhpZisxZ0Q4Sms5RVdRbTU2ZHVtNTV0UnRKREtQ?=
 =?utf-8?B?VEpqZTd0Q2s1NS9XRTlJMTFjZ3VNWTUrckNzTnQxUmVZRzFIOTBoVjc1Z3lt?=
 =?utf-8?Q?qSvcufz2mK4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ko;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2P216MB2274.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TDZHWjRYdFo0a1ZzTXRpL0w3WWRqYzgzamlFazdNOG5SN3FWZ0diTkVyUVhM?=
 =?utf-8?B?Ni9RS3QySWpCQ2F3ZEdPOTdhUkRqdDFhR1VXdm82RlIzcG9zVnVueHc3Nms4?=
 =?utf-8?B?RUJabDZRNlVFdkFrbWJhM29JS09XRG05bUE3a3NINnRNZ2FBbkJoNTg1VXNn?=
 =?utf-8?B?cjdvUGpXV1krSzRmcjVZT0ZmczhnMGtaLzRPcU4vMEpkUzdlbUowZHVoOVJw?=
 =?utf-8?B?aDBRdEMyUk50WXpmdzBLalkybmFTdXdQVHNJeEZkNjBLNjRoL1ZOSE9abVZI?=
 =?utf-8?B?NlVNTFJHVGVOc3ZGUEpTM1l6aThXSzhScFpKOEIyQVhJVHlsZzJIV0hFeGNZ?=
 =?utf-8?B?OS9xTExOaWlNcWxtTWNIeXVVVGdpczM0QUY2SndJMi9ucWZwbEFKMEJZVVFK?=
 =?utf-8?B?cktHU2I2aGNHWHZTQTFsT09JTk5VYzg3bWlmMjMyU3F3Nm1FdVZrbGFBU0tt?=
 =?utf-8?B?dzd5bmhyd0NuRWthL0NtNVAvUUF0ak1oc1ovL1dManZEVTBDZ0JNM2xBTFpa?=
 =?utf-8?B?WnIxVFhLeGZNV0w2YnNFK0hkQzNkZE9HV0t4Yld3YU1MdjZTcVU1dGFuOWJa?=
 =?utf-8?B?NUdTS1l1eTVWTW5OQ2UvVHNtR2ZZY0tneEZhTjZzS3ZjaEhlQXFlb0dKb2xt?=
 =?utf-8?B?WUkrYlRNVjJmY2NYZEJYRW9ETStabGJvVTg5b1NRektYSUZUTmExR2FNK1FB?=
 =?utf-8?B?eVQxN2VBZy9CcnhySVEzMlJLc0hlQW9CSy9qMS9NU3pKSUlMYXFYY2VtT2RP?=
 =?utf-8?B?SGlZVFdFOE1WNDA4RUI0dlgzVkQxZHR6S1JRMFNGdGhkcG1NMUhzaTAzM1dQ?=
 =?utf-8?B?U0FCOTg0UnowcnlzeGJaS2QwL29JdHRheThlbnlsM2QrZk1sU2R0NHBzMUp0?=
 =?utf-8?B?NDh0RE5tOEdMTEdhdndBTXpvWEt2RG5aY3FqQVpGczdMS1A4N3pLekRMdlFM?=
 =?utf-8?B?c3ZlZkdhcTNZTzhiTno0d0pYQ0F0YlpoZU1xR0hYMmozYVpCaGVkRVNuODFw?=
 =?utf-8?B?ckdqMng3MWQ2UElZN2JhRjRlK2k0aitVYndicjVBYXF2c1FERVErbDllT252?=
 =?utf-8?B?VkJ3RDVMc2lBK0xnZWQveWJjRWxUSldQbFUzMHNMMUxpNjRPZGZ1dkt4bzJy?=
 =?utf-8?B?anFHOXpjYzhJSlBCUDJjZ01DQkkzdDNkTVJQYm82U0lzMUsyL09LV0RLUldh?=
 =?utf-8?B?bVVvUzgrY2dieTVGU1JXM0pORktsRlVoS2JhUFFiKzNkR0xhbzZaWi91WHFK?=
 =?utf-8?B?cTR2SlJuTS9UWTNNMENoUzlYUzdVMkVDdVk0b2xEWG1TTEZsQlJINTB3Y1ZS?=
 =?utf-8?B?OUlQbnM4N0hXZm9WM3lFNG9RT1dKREovSjdpLzVxVkF1YURzWlB5NVJIZk1N?=
 =?utf-8?B?MlNuSUROUkNDTXVxYU1yaVVoeit1WlpvaHhoRWtMT01WbzNMNDc2REplRnRi?=
 =?utf-8?B?a1dMREp4SjdEVmhpOTBSUjhXT2I0Qm4yQkNOSkhnM3ZkOXQ2WGxiVUJGR2tX?=
 =?utf-8?B?OWtSYThTWmorSHhjdGk0dUZ6NDFESWFENmdpSE0xT1dwdGVYcmZSMUoyVVFN?=
 =?utf-8?B?KzV2eUxCRkRkV3JPN24rOHZ2aitwdXB1dXVpWDQ3MnBxZTMxRVJXZVRYTjZG?=
 =?utf-8?B?T0pBampTSGlCR0U3eDMxMmFxdUJ1SG5zRzlrNmlCMGI2K0RmOGQ4dGZxMTBW?=
 =?utf-8?B?YmNjRkRaNHJvV04weVNjSlRJN3JiT255M0lyMVBZdWttaWNNZC96eGpOV29N?=
 =?utf-8?B?Mkd3MEIyRVY2OFlTZnFvekVQbGZ2MjdjYlpueG5HNzhXYTlXQmpBV2ZGMFpM?=
 =?utf-8?B?cWNLRS90KzJYYkxYSk4rbFFTN3d4N1FuVTB3cFRQeWQ0c3FWSk1tb0NrbU9W?=
 =?utf-8?B?SjlrMHBLRTdrSC9meEhDN0JDK0JyNUF6QXJ0dXBTWk9vTVI2a2FVeEl0Y0th?=
 =?utf-8?B?VkprUkVFa0ZxemRQYzM5L0U3N0FFZ1d4REIrMWs2MUpyd0xQWXFrOTc0bWFQ?=
 =?utf-8?B?VVdURnBXdlJIMlJTNDRPei84aXkrVzVQSktsWkIxN1RkVHNQM0phMmRvNzlV?=
 =?utf-8?B?MWRGcW52R0tESEJTZFkwYkVLUGgySzRiSTRUc05mLzhLSEZ0Vkw0Tkd1ZUxu?=
 =?utf-8?Q?EC2INMJviMN9G85TZbQJqLJLM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: doosan.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2P216MB2274.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fc072ccc-c0c1-4ffa-2825-08dd973b25e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2025 01:10:45.0458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1b3610-9ab0-42d5-93aa-46150d723d87
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GXti3D0fSCqyICeaForbdT9/ni7MsR4icCuBdEB5whxfvf4FDoQ0/pqSFtDJHuJG/UbtHswkFK/zGQHnf9COeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU4P216MB1424
X-GND-Status: LEGIT
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddvledtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjggtgfggsehtsgdttddttdejnecuhfhrohhmpejnnjjnldfluhhnvghsohhoucfkmhdmucjnnjcunjjnnjjnnjjnuceojhhunhgvshhoohdrihhmseguohhoshgrnhdrtghomheqnecuggftrfgrthhtvghrnhepgfdtteeiuedtgeffuedtieetgedutdfhfefggefhheduieekhffhffehiedvvefgnecuffhomhgrihhnpeigvghnohhmrghirdhorhhgpdguvghngidruggvpdhlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgnecukfhppedvudejrdejtddrudejkedrvddukedpvdeitdefmedutdelieemuddtudemudehudemmedufeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudejrdejtddrudejkedrvddukedphhgvlhhopehsphhoohhlrdhmrghilhdrghgrnhguihdrnhgvthdpmhgrihhlfhhrohhmpehjuhhnvghsohhordhimhesughoohhsrghnrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvh

SGVsbG8sIE1yLktpc3prYS4NCg0KDQpJIGFtIHNldHRpbmcgdXAgdGhlIGxhdGVzdCBrZXJuZWwg
KDYuMS4xMjgtY2lwMzctZG92ZXRhaWwxKSBjb3JyZXNwb25kaW5nIHRvIHlvdXIgcmVjb21tZW5k
YXRpb24gZm9yIFhlbm9tYWkgMywgYWxvbmcgd2l0aCBYZW5vbWFpIDMuMi4zLiBDdXJyZW50bHks
IEkgYW0gY29uZmlndXJpbmcgdGhlIGtlcm5lbCBtZW51Y29uZmlnLg0KDQpJIHVuZGVyc3RhbmQg
dGhhdCBJIGhhdmUgdG8gY29uZmlndXJlIHRoZSAiUlRuZXQiIHRvIHVzZSBUQ1Agb3IgVURQIGlu
IHJlYWwtdGltZS4NCg0KSG93ZXZlciwgd2hlbiBJIG1vdmUgdG8gdGhlIGZvbGxvd2luZyBwYXRo
IChzZWUuIGJlbG93IFtNZW51Y29uZmlnIHBhdGhdKSwgSSBjYW4ndCBzZWUgb3B0aW9ucyBmb3Ig
VENQIG9yIFVEUCAoSSBjYW4ndCBzZWUgYW55dGhpbmcgYXQgYWxsKS4NCg0KQW0gSSBtaXN1bmRl
cnN0YW5kaW5nIHNvbWV0aGluZz8gT3IgaXMgdGhlcmUgYW4gaXNzdWU/IENhbiB5b3UgaGVscCBt
ZT8NCg0KW01lbnVjb25maWcgcGF0aF0NClhlbm9tYWkvQ29iYWx0IC0tLS0+DQouLi4uRHJpdmVy
cyAtLS0tPg0KLi4uLi4uLi5SVG5ldCAtLS0tDQoNClRoYW5rcw0KQmVzdCByZWdhcmRzLg0KDQot
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogSmFuIEtpc3prYSA8amFuLmtpc3prYUBz
aWVtZW5zLmNvbT4gDQpTZW50OiBGcmlkYXksIE1heSAxNiwgMjAyNSAzOjEwIFBNDQpUbzog7J6E
7KSA7IiYKEp1bmVzb28gSW0pIOyImOyEnSDrkZDsgrDroZzrs7Tti7HsiqQgPGp1bmVzb28uaW1A
ZG9vc2FuLmNvbT47IHhlbm9tYWlAeGVub21haS5vcmcNClN1YmplY3Q6IFJlOiBQbGVhc2UgcmVj
b21tZW5kIHRoZSBhcHByb3ByaWF0ZSBLZXJuZWwgYW5kIFhlbm9tYWkgdmVyc2lvbiBmb3IgbXkg
aGFyZHdhcmUuDQoNCuyjvOydmDog7J20IOuplOydvOydgCDsmbjrtoDsl5DshJwg67Cc7IahIOuQ
mOyXiOyKteuLiOuLpC4g66eB7YGsIO2YueydgCDssqjrtoDtjIzsnbwg7Je0656MIOyLnCDso7zs
nZjtlZjsi5zquLAg67CU656N64uI64ukLg0KDQpDQVVUSU9OOiBUaGlzIGVtYWlsIGlzIHNlbnQg
YnkgYW4gZXh0ZXJuYWwgYWNjb3VudC4gUGxlYXNlIHRha2UgZXh0cmEgY2F1dGlvbiB3aGVuIGNs
aWNraW5nIHRoZSBsaW5rIG9yIG9wZW5pbmcgdGhlIGF0dGFjaG1lbnQuDQoNCk9uIDE2LjA1LjI1
IDA0OjI5LCDsnoTspIDsiJgoSnVuZXNvbyBJbSkg7IiY7ISdIOuRkOyCsOuhnOuztO2LseyKpCB3
cm90ZToNCj4gVGhhbmsgeW91IGZvciB5b3VyIHJlc3BvbnNlLg0KPg0KPg0KPiBUaGFua3MgdG8g
eW91ciBleHBsYW5hdGlvbiwgSSBoYXZlIGRlY2lkZWQgdG8gdXNlIDQgY29yZXMgZm9yIFhlbm9t
YWkgYW5kIHRoZSByZW1haW5pbmcgNCBjb3JlcyBmb3IgUG9zaXguDQo+DQo+DQo+IEl0IHNlZW1z
IHRoYXQgSSBuZWVkIHRvIGFwcGx5IHRoZSBEb3ZldGFpbCBwYXRjaCB0byB0aGUga2VybmVsLg0K
PiBDb3VsZCB5b3UgcGxlYXNlIGxldCBtZSBrbm93IHRoZSBtb3N0IHRlc3RlZCBhbmQgc3RhYmxl
IGtlcm5lbCB2ZXJzaW9uIGFuZCBYZW5vbWFpIHZlcnNpb24/DQo+DQoNCkFsd2F5cyBsYXRlc3Qg
c3RhYmxlLCBzZWUgaHR0cHM6Ly94ZW5vbWFpLm9yZyAodGhpcyBpcyBub3cgYXV0by11cGRhdGlu
ZywgdGh1cyB0cnVseSByZWZsZWN0aW5nIHdoYXQgaXMgbGF0ZXN0KS4NCg0KPg0KPiBBbHNvLCBw
bGVhc2UgcHJvdmlkZSB0aGUgVVJMIHdoZXJlIEkgY2FuIGRvd25sb2FkIHRoZSBEb3ZldGFpbCBw
YXRjaC4NCj4gVGhlIFVSTCBodHRwczovL2Z0cC5kZW54LmRlL3B1YiBkb2VzIG5vdCBoYXZlIHRo
ZSBEb3ZldGFpbCBwYXRjaC4NCj4NCg0KTGlua2VkIGZyb20gb3VyIG91dCBob21lcGFnZSwgeW91
IGp1c3QgbmVlZCB0byBleHRyYWN0IGl0IGZyb20gZ2l0IGluIGNhc2UgeW91IHN0aWxsIG5lZWQg
YSBwYXRjaC4NCg0KSmFuDQoNCj4NCj4gQmVzdCByZWdhcmRzLg0KPiBKdW5lc29vLkltDQo+DQo+
DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEphbiBLaXN6a2EgPGphbi5r
aXN6a2FAc2llbWVucy5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBNYXkgMTUsIDIwMjUgMTo0NCBB
TQ0KPiBUbzog7J6E7KSA7IiYKEp1bmVzb28gSW0pIOyImOyEnSDrkZDsgrDroZzrs7Tti7HsiqQg
PGp1bmVzb28uaW1AZG9vc2FuLmNvbT47IA0KPiB4ZW5vbWFpQHhlbm9tYWkub3JnDQo+IFN1Ympl
Y3Q6IFJlOiBQbGVhc2UgcmVjb21tZW5kIHRoZSBhcHByb3ByaWF0ZSBLZXJuZWwgYW5kIFhlbm9t
YWkgdmVyc2lvbiBmb3IgbXkgaGFyZHdhcmUuDQo+DQo+IOyjvOydmDog7J20IOuplOydvOydgCDs
mbjrtoDsl5DshJwg67Cc7IahIOuQmOyXiOyKteuLiOuLpC4g66eB7YGsIO2YueydgCDssqjrtoDt
jIzsnbwg7Je0656MIOyLnCDso7zsnZjtlZjsi5zquLAg67CU656N64uI64ukLg0KPg0KPiBDQVVU
SU9OOiBUaGlzIGVtYWlsIGlzIHNlbnQgYnkgYW4gZXh0ZXJuYWwgYWNjb3VudC4gUGxlYXNlIHRh
a2UgZXh0cmEgY2F1dGlvbiB3aGVuIGNsaWNraW5nIHRoZSBsaW5rIG9yIG9wZW5pbmcgdGhlIGF0
dGFjaG1lbnQuDQo+DQo+IE9uIDE0LjA1LjI1IDE1OjU3LCDsnoTspIDsiJgoSnVuZXNvbyBJbSkg
7IiY7ISdIOuRkOyCsOuhnOuztO2LseyKpCB3cm90ZToNCj4+IEhlbGxvLCBJJ20gSnVuZXNvby5J
bS4NCj4+DQo+Pg0KPj4gSSBhbSB3cml0aW5nIHRvIHlvdSBiZWNhdXNlIEkgaGF2ZSBhIGZldyBx
dWVzdGlvbnMgYWJvdXQgWGVub21haS4NCj4+DQo+Pg0KPj4gSSBoYXZlIGFuIEFkdmFudGVjaCBQ
QyB3aXRoIGFuIEludGVsIGkzLU4zMDUgQ1BVLiBUaGUgQ1BVIGhhcyA4IGNvcmVzLg0KPj4NCj4+
IFExLiBDb3VsZCB5b3UgcmVjb21tZW5kIHRoZSBhcHByb3ByaWF0ZSBLZXJuZWwgYW5kIFhlbm9t
YWkgdmVyc2lvbiBmb3IgbXkgaGFyZHdhcmU/DQo+PiAgICAgKklmIHBvc3NpYmxlLCBJIHdvdWxk
IHByZWZlciBJLVBJUEUgb3IgRG92ZXRhaWwuIEkgdW5kZXJzdGFuZCB0aGF0IEktUElQRSBvciBE
b3ZldGFpbCBhcmUgbW9yZSB0ZXN0ZWQgYW5kIGhhdmUgc3RhYmxlIHZlcnNpb25zIGNvbXBhcmVk
IHRvIEVWTC4gSSBtaWdodCBiZSB3cm9uZyBhYm91dCB0aGlzLg0KPj4NCj4NCj4gSS1waXBlIGlz
IGluIGRlZXAgbWFpbnRlbmFuY2UgYW5kIG9ubHkgYXZhaWxhYmxlIGZvciB2ZXJ5IG9sZCBrZXJu
ZWxzICg0LjQtY2lwLCA0LjE5LWNpcCwgNS40KSBvbiB3aGljaCB5b3Ugc3VyZWx5IGRvbid0IHdh
bnQgdG8gc3RhcnQgbmV3IGRldmVsb3BtZW50cy4gQSByZWFzb25hYmxlIGJhc2VsaW5lIG5vdyBp
cyA2LjEyLCBhbmQgdGhhdCBtYW5kYXRlcyBkb3ZldGFpbC4NCj4NCj4gV2hldGhlciB5b3UgY2hv
b3NlIFhlbm9tYWkgMyBvciA0IChFVkwpIGlzIHRoYXQgYW5vdGhlciBwb2ludCwgc2VlIGJlbG93
Lg0KPg0KPj4NCj4+IFEyLiBBZGRpdGlvbmFsbHksIGZyb20gd2hhdCBJIGZvdW5kIG91dCBvbiB0
aGUgWGVub21haSBzaXRlLA0KPj4gICAgIGR1YWwga2VybmVsIChDb2JhbHQpIGlzIGJldHRlciBm
b3IgNCBjb3JlcyBvciBmZXdlciwgYW5kIHNpbmdsZSBrZXJuZWwgaXMgYmV0dGVyIGZvciBtb3Jl
IHRoYW4gNCBjb3Jlcy4NCj4+ICAgICBJcyB0aGlzIHRydWU/DQo+Pg0KPg0KPiBUaGUgc2NhbGFi
aWxpdHkgbGltaXRhdGlvbiBvZiBYZW5vbWFpIDMgaGFzIGJlZW4gYWRkcmVzc2VkIGluIEVWTC4g
U28sIGlmIHlvdSBoYXZlIFJUIHdvcmtsb2FkIHRoYXQgYWN0dWFsbHkgbmVlZHMgdG8gbWFrZSB1
c2Ugb2YgYWxsIDggY29yZXMsIHlvdSBiZXR0ZXIgaGF2ZSBhIGxvb2sgYXQgWGVub21haSA0Lg0K
Pg0KPiBSZWdhcmRpbmcgInNpbmdsZSBrZXJuZWwiOiBEbyB5b3VyIG1lYXN1cmVtZW50IHdpdGgg
UFJFRU1QVC1SVCBhbmQgY29tcGFyZSB5b3Vyc2VsZiBpZiBsYXRlbmNpZXMgYW5kIG1hcmdpbnMg
YXJlIHN1ZmZpY2llbnQgZm9yIHlvdXIgd29ya2xvYWQuIFRoZXJlIGlzIGFsc28gdGhlIGFzcGVj
dCBvZiBjbGVhciBzZXBhcmF0aW9uIGJldHdlZW4gUlQgYW5kIG5vbi1SVCB0aGF0IGNvbWVzIHdp
dGggYSBkdWFsIGtlcm5lbCBidXQgbm90IHdpdGggYSBzaW5nbGUgb25lLiBIb3dldmVyLCBpZiB5
b3Ugc3VmZmljaWVudGx5IHVuZGVyc3RhbmQgd2hhdCB5b3UgYXJlIGNhbGxpbmcsIHdoYXQgdGhl
biBoYXBwZW5zIGluc2lkZSB0aGUga2VybmVsIGFuZCBob3cgdG8gdHVuZSB0aGF0IHByb3Blcmx5
IHNvIHRoYXQgUlQgcGF0aHMgYXJlIHByaW9yaXRpemVkLCBQUkVFTVBULVJUIGlzIGEgdmFsaWQg
b3B0aW9uLg0KPg0KPj4NCj4+IFEzLiBJIHdvdWxkIGxpa2UgdG8gbGVhcm4gbW9yZSBhYm91dCBz
aW5nbGUga2VybmVsLiBDb3VsZCB5b3UgcmVjb21tZW5kIGFueSByZXNvdXJjZXM/DQo+Pg0KPg0K
PiBTdGFydCBmcm9tIGhlcmU6IGh0dHBzOi8vd2lraS5saW51eGZvdW5kYXRpb24ub3JnL3JlYWx0
aW1lL3N0YXJ0DQo+DQo+IEJlc3QgcmVnYXJkcywNCj4gSmFuDQo+DQo+IC0tDQo+IFNpZW1lbnMg
QUcsIEZvdW5kYXRpb25hbCBUZWNobm9sb2dpZXMNCj4gTGludXggRXhwZXJ0IENlbnRlcg0KDQoN
Ci0tDQpTaWVtZW5zIEFHLCBGb3VuZGF0aW9uYWwgVGVjaG5vbG9naWVzDQpMaW51eCBFeHBlcnQg
Q2VudGVyDQo=
