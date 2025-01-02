Received: from SEVP216CU002.outbound.protection.outlook.com (mail-koreacentralazon11012053.outbound.protection.outlook.com [40.107.43.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DB728FF
	for <xenomai@lists.linux.dev>; Thu,  2 Jan 2025 02:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.43.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735786327; cv=fail; b=NDDix5dnkD3AH/KmpT2qw2fn0WNYuc+EKcs5/+l5app1hCm9NgWFv57eOl8BPG4rS5qI2XWalFMul4wVgGAy4/ZFmFtXD8k5yj3owaLSpBnnDUkQvs1/9bX3xUXikhona2B831hBJQ30POpjAmIWx2I8KV8MUJdX2UG1TbxYbUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735786327; c=relaxed/simple;
	bh=+U1YJaFwPOdzldJOqZQoa6VJRhKpwrxtRwFZslWhwTI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XK+5SMHolD0ShQp3c0TsS+GbKcXj1R/YFuo4OEAXYWeOvjZHlhySg7eb1sGeLWN3NMe571axHJ779ccPXvCIkwbWRrYf5oX6T/sWgJfJekRQi0Yrie3md1lpxGhpxaGoXwL+9ukg0xoOsP7+w4cj1XwdpEJu2qORJleT6lNT91o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doosan.com; spf=pass smtp.mailfrom=doosan.com; dkim=pass (1024-bit key) header.d=doosan.com header.i=@doosan.com header.b=TaiOcekm; arc=fail smtp.client-ip=40.107.43.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doosan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doosan.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=doosan.com header.i=@doosan.com header.b="TaiOcekm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y4jUlzYJoIpZpHnWMqFdTKk6h+FU0DLLDi9eL1HUcl9Ko/v3Pfr07zuoiY5QKJvmKQEM8O1gUUC/jnloAYojNkDcZyK9LNu5tLR864Mmyi2yCtOgeRW5chFKnTXEtN8vxEZsPrzrPlY1UQF2j9bLBpGk2AughXJ7P6xtCMsd0ol99wGPzpO2s4RTIC8l4pMKUUANKDQq5vSEep3K+vXCPdjx//JDxH788CBHqM20E/pbxBul/0dWYLDPOl9iBxYYxnGo9+WVluKUfx+/cK3iP82eLKA447mwLeHCGLRdGPGa+aVdwKMGobdpeB0C5Ow5XeZm6lBO2+7ergVd8dqw2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+U1YJaFwPOdzldJOqZQoa6VJRhKpwrxtRwFZslWhwTI=;
 b=gRGNfDQnrBXcWifE+c6bq93Qk2ZANollzxHffsra9jLWwd0yrGlcpoixWLBN5FTJdQ9yT9eh4SV1GT/qrzl5SVk4T/8yys25bCiTUWwsmjAPY5jhyU5cPX05nlLZwjvMfJyJGhRSiTScoWkaXR5zvxHLfutDl1tkQJOAYM6mwuRFYO+bBAqJAbps9Q9Y4wh1bl7YXjebT8v37iyMMJTA7KXLS1PbS4hUhjcSK5umhXMmWO4cWWouq1pbYwPHml+REcE5vZgZNPdyIleY9ulENZ7gQx0jJu2gWd9iaTY5odv9uLB3aEyjaDeWD0dp64S5LPnRBex10w5yqMBlKSF6Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=doosan.com; dmarc=pass action=none header.from=doosan.com;
 dkim=pass header.d=doosan.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=doosan.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+U1YJaFwPOdzldJOqZQoa6VJRhKpwrxtRwFZslWhwTI=;
 b=TaiOcekmi3il/5uscPGPT3bA8+Cc15oJ+aFvkkhWvJK7h4d4uvVmYM0/rSsJy+mJfW4YNWPTHbbDzF5qYJAZi8mz2erde98nDpxpL6Yj//0dEYkpj282t1l2f0Tzjuqi6XaI0XWOmasiyeCFRdQRgtLM02USkxsa/NwUCRt98I0=
Received: from SL2P216MB2274.KORP216.PROD.OUTLOOK.COM (2603:1096:101:151::13)
 by SE1P216MB2082.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Thu, 2 Jan
 2025 02:52:01 +0000
Received: from SL2P216MB2274.KORP216.PROD.OUTLOOK.COM
 ([fe80::a9ab:83f9:e987:37d4]) by SL2P216MB2274.KORP216.PROD.OUTLOOK.COM
 ([fe80::a9ab:83f9:e987:37d4%7]) with mapi id 15.20.8314.013; Thu, 2 Jan 2025
 02:52:01 +0000
From: =?ks_c_5601-1987?B?wNPB2Lz2KEp1bmVzb28gSW0pILz2vK4gtc676rfOurjGvb26?=
	<junesoo.im@doosan.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
CC: =?ks_c_5601-1987?B?udqw5sjGKEt5dW5naG9vbiBQYXJrKSDGwMDlILXOu+q3zrq4xr0=?=
 =?ks_c_5601-1987?B?vbo=?= <kyunghoon2.park@doosan.com>,
	=?ks_c_5601-1987?B?wMzH/LyuKEh5dW5nc2VvayBMZWUpILz2vK4gtc676rfOurjGvb26?=
	<hyungseok3.lee@doosan.com>
Subject: IPIPE Kernel & Xenomai matching version
Thread-Topic: IPIPE Kernel & Xenomai matching version
Thread-Index: AdtcwPJAZLm3NHC9RvqVAfV7Ax1H+A==
Date: Thu, 2 Jan 2025 02:52:01 +0000
Message-ID:
 <SL2P216MB2274C60D2E87BA84D06C3E7EE0142@SL2P216MB2274.KORP216.PROD.OUTLOOK.COM>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=doosan.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2P216MB2274:EE_|SE1P216MB2082:EE_
x-ms-office365-filtering-correlation-id: 6c52a1e6-985f-4e8f-b654-08dd2ad86e7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?ks_c_5601-1987?B?WUR3UnNMZFdKblFJN0QxV3Z4dTZaVFNBdUp0ekppSlNYd1dtbWRz?=
 =?ks_c_5601-1987?B?K2x6MnFWL09zZVJnc21zZVhZMW5COWdGQnZoQ2FsVWhJSUx6TWd5?=
 =?ks_c_5601-1987?B?bzE5TjBTK0tRN1pSQ3kvMk4vNzdQWlRxL05XVjB1U1FOY1VtM0tp?=
 =?ks_c_5601-1987?B?M3Q1VURBSVNtSURxUUxDeWthMGVZcDJLVHhmMmF1Q1BuTUhQc3B4?=
 =?ks_c_5601-1987?B?SFhhNHd2VjJXUUVCTE9IVThGYkFoWlArK3pFa1lnWWdQR0drV04w?=
 =?ks_c_5601-1987?B?aXpZLzhOaWhaVHlWTU9kbjZ3N3NxblpZK2FSc0k0dW1CLzBVZzN5?=
 =?ks_c_5601-1987?B?bkJndGx2U0IyUS9STWk5azV6aEdaenhWZmxjOTRvM0w5RG5sYVQw?=
 =?ks_c_5601-1987?B?QW80RW13TFpkZnk3bkV4OUpLc05oeE1QT2FPWklBTGNQVUd0V0gx?=
 =?ks_c_5601-1987?B?MW5BWXhXYmJaZDJ2UjdYNG9jWjF4YXQzblRQcWt3ZkYvZ093WDNp?=
 =?ks_c_5601-1987?B?ZitCcHZrRWVMdzJrSVNpN3RUOW5oQVdocDc0Z2Z6U0pEL082RmxR?=
 =?ks_c_5601-1987?B?bkdSQUZIeTNwUTRHZE9QUlpIKzhsM1RuRVlab2FsR2h5YXNLN1dP?=
 =?ks_c_5601-1987?B?MVVhQTdnTDhrSE5uV2NwclJqMllzdm1WWjhLSUNoeFNZNE1TMFdD?=
 =?ks_c_5601-1987?B?UytrVGFWTDlMYWNpS0lPNXRSd3JxYVpZRmxTTmRrZDduanJNeTRt?=
 =?ks_c_5601-1987?B?Rk1MQjZQN01aNTFVK0tHQ3pzeGtUcmlWci84Vk1leXpCbjlXbWZS?=
 =?ks_c_5601-1987?B?Vm1GUFg2K0p6NzZScEZ3Y00vcGJRWmVaWGo2am1ubDdKVCtwYkpm?=
 =?ks_c_5601-1987?B?WWh2c3FtbFgzMktCM0pJeVBpcmVpNC9kS2JBQVVoNVZnK1ppU1JL?=
 =?ks_c_5601-1987?B?ZFhaalQrMFhhRTdHWGJxWklZUURxZXhsampRNGN4cTlYOEg1WEV4?=
 =?ks_c_5601-1987?B?ZjFLN1Q3UEF0NjNvZG1BNGJsZ1JOT2NQNE9EdXViY3E3cmpoK3lP?=
 =?ks_c_5601-1987?B?ejl2V0FkSC9sRnNJNUg0YnlnSkZ2YXNNaVI5WE9pclhwQkVpVUxS?=
 =?ks_c_5601-1987?B?R0VqQXR6WklGVDhiMGhtY0dwSmJxWDYrNjg5M3FqdkdHYXJGWDd2?=
 =?ks_c_5601-1987?B?QnF0REsweGV6OXRvQUppVlNnMWxMVzhtdWVrY0FLUVFTRUZLUXpZ?=
 =?ks_c_5601-1987?B?SmFzL0FCc3F5TjhZc3lSeXNKZUlkTUhhMXFiSDRIQitvSDhJRXdT?=
 =?ks_c_5601-1987?B?OVV5TERXRk1GTENhL013ckQyUGo1TDA5Z3BqQkJoS1ZTZVUrdjMx?=
 =?ks_c_5601-1987?B?S2p6bWRQUHgraThHbXB0UUwzejBTUDEwM21SL3d0Yi9RS2RSQ2tk?=
 =?ks_c_5601-1987?B?NXVxOFY4alhHSW1hempNVFFaS25aTzYyVmkwVVY0WDZwY3NFTGtD?=
 =?ks_c_5601-1987?B?SlJsQVhYdEN4MHljbzFyZWRkU0FFaDFmRGUrdEU2cVVsaUxTNCsz?=
 =?ks_c_5601-1987?B?VlA0YUlFUVV0ZzR3N2tZNHN0cWVLMzdRbi93Z3RjeVJFTExLQ2tv?=
 =?ks_c_5601-1987?B?S1B4V2xQOWtXM3VsQWkrL2xBTitUMVNvK0Y5WTZJbU5GeTI2TUJo?=
 =?ks_c_5601-1987?B?YXcrOG1IZTZuM00vUVVPcUlNUUI0WTBKU0JsN2JpUDRIYm5tZjNh?=
 =?ks_c_5601-1987?B?SGRoMnVSTnZqQ3l6TmRhMWo0YW9SNDJGdVk2b1lMZThkK2dJSmla?=
 =?ks_c_5601-1987?B?R01YQ0s3SFhoWTJWeXJhMi9DQVI2alc1bmNrKzVid2ROU3hwdUZD?=
 =?ks_c_5601-1987?B?c05iczliVzQ3MVg0blVyaVNKdmxPUm5adUlhdnpZQlFlZ1NvZC9u?=
 =?ks_c_5601-1987?B?Rk84TFhVOWE0TytVL3c3WVlrdktJK1N0eU5hbFc4TUkyUlQxc05C?=
 =?ks_c_5601-1987?B?UVBIZ2VuT3hNcHZnNGtDZE05ZitDMmxzR3lqRkoxL0NjK1NkcnFY?=
 =?ks_c_5601-1987?B?YTRiSkRUVjhkVXQ4SVc0aWhNVFNVWGt2aUNqTjlQam5YdzRWM2FC?=
 =?ks_c_5601-1987?B?UFNGMUg0djM3aFlqNmhxU01vdm9NTkdRdyttRnA1QXFOR2lOMUcx?=
 =?ks_c_5601-1987?B?dFprR1NNQ3RwSVNySGxteVRsWmw5blRMVzdXY1RVK29EUzJ3Y2h6?=
 =?ks_c_5601-1987?Q?wC3h2VnIxtow/l3xHDz6xMbnLjvCw?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ko;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2P216MB2274.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?ks_c_5601-1987?B?VHNZYUg5dWREajVlUGM5TWVpRlVJSXE3ZzAycVNESm9peS9heHRa?=
 =?ks_c_5601-1987?B?Wkc1THJiME1IU1gxVFdHbGp6YVNlcVlWY09NbHN4ZWEzVFdLYXEz?=
 =?ks_c_5601-1987?B?Umh2VDlJRFhDeHMvaVFtam52Zk1WK1VrZENOVzdNaUE4Uk9OS1ky?=
 =?ks_c_5601-1987?B?MDRSNWgrb3VLZC9zRFpXL0hENDRzQmZnd01jUUtNYnp1UjdTNzJP?=
 =?ks_c_5601-1987?B?NmtiWVFVZWE0YTVINCtBSWZidEZGWHR6M2lzRUYxeGxxMWp6azdp?=
 =?ks_c_5601-1987?B?UkQzS2ZSMWI1bkdUNll6MElVRjR1dm1nclJhSlZEbTRuS0hwY1Nq?=
 =?ks_c_5601-1987?B?VmFTd0VvRWQ4THV3dW5JZGFKbXJ3TVdLcTRJeDlxTVVjcXpUbis1?=
 =?ks_c_5601-1987?B?TmVSVUdIaE5ZbDQ3M1BnOFN3eEsybS9qN09HZXZRSXFoNGdyaHRJ?=
 =?ks_c_5601-1987?B?aTRmbXgvSW5LRXdJUGFSLytPNDBoZ0Nzc1didDEyNWF2RUxEaXA2?=
 =?ks_c_5601-1987?B?bHk0OGFrSEJYTFpSeUU2NnVCZkNHQ215eC8waDF5czFqN3Y4dHdO?=
 =?ks_c_5601-1987?B?MzdYKzdnWC8yQkJtZmR5WExaajJWV0lRRUYzdkJRMmVFcGtyd25j?=
 =?ks_c_5601-1987?B?bWNXL0pWY3AxQk5OL052Z0NPS2tiVW5HZzhWWERBZTRiOWFickkx?=
 =?ks_c_5601-1987?B?eVFnZWI2M0tTYVBYU2pyd3JDTE5mNTJqNGJVSXI4cXlNVXZDSDRE?=
 =?ks_c_5601-1987?B?MnpQTEZENEFvZkYzT3FrNm5VcFltSGdFK2NFTVMyMHFtblcxTXNz?=
 =?ks_c_5601-1987?B?aEJBRllNS0dZdEVvRmR2VXJ3K1MwN3hlTlNDVWFJd1VUdldWaDJN?=
 =?ks_c_5601-1987?B?L0tZdjRiaDI3OVVHT2daWW9YSXFaSjZzQkY2Yi9XNkY0S29WbnVZ?=
 =?ks_c_5601-1987?B?c2VBUW5GdG1uVkJ3NmE2YUhHWlVkOEZxVzFrbmZ6cXB6NnZ4eEZ1?=
 =?ks_c_5601-1987?B?ZWk4cDZPUWx3NWZDRlVmakIxZzBYMGtScVc4Y3h6czFQVHBsYkpJ?=
 =?ks_c_5601-1987?B?S0NXS3VZSXJWMHJuM0ZVUGhOeDBCbjR0ai80ME14bDd5RkR2L3pp?=
 =?ks_c_5601-1987?B?R2hMMnlpQTJFekJuNzJJdkxXc0dJQWdtODFBYnNYTUxkbjNlTHNO?=
 =?ks_c_5601-1987?B?SlYydHB3ejlTWWVKdWhGU011NnR0SGdnQURuTTJYL1ByN3BZOUFp?=
 =?ks_c_5601-1987?B?dEZ0NW0zUTBqWDFzNjRyNGJZRFc0VUs0OUlXemJSQXI2TVZQWFBM?=
 =?ks_c_5601-1987?B?NUluaE9mdnFlUFhNOGppME5BOGRXWC8xaVNyV21LZnhPdGRkcWxN?=
 =?ks_c_5601-1987?B?VkVhbWs3aFVrcmxPaE5XZ3ZNTWdyZ05TdjZVZUx4U09ETy9oSkFz?=
 =?ks_c_5601-1987?B?c3UrangvZ3NSVDVGbG5mSm8zYVpKV2NUSG9FN0xBZUlweExiRGl1?=
 =?ks_c_5601-1987?B?WFFHSTV0akVaOXZsL3Rvbkc5UVdCWXNWbmFWZ2NQRVhqem5Dc0JP?=
 =?ks_c_5601-1987?B?MkxLdXBEdGljQWVxMmFhZ2w0WENRWDFYMXU2cTRlbUE0OUZTZHZz?=
 =?ks_c_5601-1987?B?OGJOL0lvU0loNTNNdGY2VGdwTW5sVklOWncrWXlha2RnaDByYnpE?=
 =?ks_c_5601-1987?B?Zkg1SW9QQ3l4SyttZHJnWWswRnlLcTQzSnVtZ0tFcE5QNHk0RzV1?=
 =?ks_c_5601-1987?B?cUM2UC9MM0wvQjQwVlM4SlRLYkdWOU45OXRTbWwwRlZ5L1FVMmZ5?=
 =?ks_c_5601-1987?B?clFkaTNxS3hicFpZTFF0a1c1bWFYQVg2eFV5Q2hhc3RIQjBrNWJK?=
 =?ks_c_5601-1987?B?ckJnT3JQYjBWa2F2TVlGK0IyZjIycjA3RnBJSFR4U1MvdTFLTzdk?=
 =?ks_c_5601-1987?B?RmswSkFaMHpWYkhVYnE0L0QwL3FsOEV5ZzJHZ0FZNldMYVNnTGF6?=
 =?ks_c_5601-1987?B?OVQvalhVZWVkamhlMXlXcFg3UlBpYVFZQXZzR2VPQVZoK0NrZTgx?=
 =?ks_c_5601-1987?B?b2RFUTI1K3lPeDZ5RE5KMG42OW1TMGZFbVBZaFEzT25OaE9sZUUz?=
 =?ks_c_5601-1987?B?citiLzQwdDZnbHJvSFZBR1liK2JrSTg1MG1KSTJrTXYraXMvb2l4?=
 =?ks_c_5601-1987?B?Wk9SMkEwMFZCRGpjdGQvbkQ5V1ZIdGdVbHpkWHd3eEZIK3QrdUkr?=
 =?ks_c_5601-1987?B?eWsyc0lWRDhHbWNNUlk4TXNsc0JRb05rUUxPWTJwWkdhT3d2UGFt?=
 =?ks_c_5601-1987?B?SG5tM1lYYUphY2Q0UHozaTczVzl3ZE1UbmFnWDFqMXY4UHpQY0Fu?=
 =?ks_c_5601-1987?B?SEhxSmpTWlpjVnN1eENFbm92ZWhMS2YxTm9XbExxZzVzUFRiM2pV?=
 =?ks_c_5601-1987?Q?DlSdLwNNnq1zx3gu3oVJbxRXo0rZm4LV1g5U6ULr?=
Content-Type: text/plain; charset="ks_c_5601-1987"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c52a1e6-985f-4e8f-b654-08dd2ad86e7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2025 02:52:01.1315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1b3610-9ab0-42d5-93aa-46150d723d87
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /+nlq3/m3nx9HucPS5wxiOSg2KNSqPGmbsnU/Yz7MftESgrk6Pe2vY7YcDJ00jTJ+m0AzKoljfWm0nc/CBh8Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1P216MB2082

SGVsbG8sIHRoaXMgaXMgSnVuZXNvbyxJbSBmcm9tIERvb3NhbiBSb2JvdGljcy4NCg0KVGhhbmsg
eW91IGZvciB5b3VyIGtpbmQgYW5zd2VycyB0byBtYW55IHF1ZXN0aW9ucyBzbyBmYXIuDQoNCg0K
RG9vc2FuIFJvYm90aWNzIGhpZ2hseSB0cnVzdHMgWGVub21haSdzIG92ZXJhbGwgZnVuY3Rpb25h
bGl0aWVzIGFuZCBob3BlcyB0byBjb250aW51ZSB1c2luZyBpdC4NCg0KRG9vc2FuIFJvYm90aWNz
IGlzIGNvbnNpZGVyaW5nIElQSVBFIGZpcnN0LCBhbmQgc2Vjb25kLCB3ZSBhcmUgY29uc2lkZXJp
bmcgRG92ZXRhaWwuDQoNCg0KVGhlcmVmb3JlLCB3ZSB3b3VsZCBsaWtlIHRvIHJlY2VpdmUgcmVj
b21tZW5kYXRpb25zIGZvciAidGhlIHN0YWJsZSBtYXRjaGluZyB2ZXJzaW9ucyIgb2YgdGhlIEtl
cm5lbCBhbmQgWGVub21haSBsaWJyYXJ5IGZvciBib3RoIElQSVBFIGFuZCBEb3ZldGFpbC4NCg0K
DQpGb3IgeW91ciByZWZlcmVuY2UsIERvb3NhbiBSb2JvdGljcyBpcyBjdXJyZW50bHkgdXNpbmcg
SVBJUEUga2VybmVsIDUuNC4yNTUgYW5kIFhlbm9tYWkgMy4xLjQuDQoNCg0KSGFwcHkgbmV3IHll
YXIgYW5kIHN0YXkgaGVhbHRoeS4NCg0KQmVzdCByZWdhcmRzLg0KSnVuZXNvbyBJbS4NCg==
