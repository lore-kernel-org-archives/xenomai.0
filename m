Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013023.outbound.protection.outlook.com [52.101.72.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2D6313529
	for <xenomai@lists.linux.dev>; Fri, 13 Feb 2026 09:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770974601; cv=fail; b=AiNrvx+3QmaS7L4o6492Z2tpIgOxjH+PNq3oliZwNlLr8Sls9VGXB/kRcQyG96OsufqOJdmwJRO32oztbwht8k1NlYVHmGHUhTcBRGkBNNl6D4ciIms+BHGRl7uhBszsm4gsrhag4kTVkXknPECCmUjVUgLaBgV8dJOFyeqS9jM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770974601; c=relaxed/simple;
	bh=F63qt0WgKfxhJJuJaL5UlQI3ZhQUPI2FtHNsr4xuwzk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=evDS7FzanYn0Zkj4cUu6BmlkVVvJ8/KdGKvnzYNcMHunITNnAlNYUCLimjpo5lZ12/A8zVqBtw7h/bOHxRSRnoFp0VVpVPlECbUsPrdVwSEy5DQGI8PxqKmdx7+ZFdpNhlq9kdlGqbt6B6HJmW0oLeDgNwrZzEfgo3h1+L4modY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ClyI+2zH; arc=fail smtp.client-ip=52.101.72.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ClyI+2zH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ox7yKRR+UUewE73nPBeu3rWDRHsGji/KjRiRBA2fXfVBCUZiIdG6zyCAIE6VjZfNJKI5uniWx8WnSaL36CKkqmoCQGO08fl7APffKUTXB8ogpo/c/04kGkEY65jb9VCbJiBDMCT/AjDY/DQ7zvbHoERtEPZ350g95URG2Y+p49Qufc37ub8kPtX0wPzGOp3BQ1+q1Cq2ZrGBzbATJgC/ypdor6nHpNXAp0g6ta3ZF9fHT8RzucypKSnyHAqX2E3YZFhEeyyJA9yTcIR4OHXjOdqJHzi1nC+Smwus5npYgR3p5cS0Wwq8V8B8eyCcHL5B5b7sRNysXm6+tgfsgUxcBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8r4KGhX3PhNMZ/ZCWFZ1ngUwOVF15Nq7f4dkkNyYYXk=;
 b=iKHjtSr9enAc/DffD2WPwQ/uOD6GvlhwHXdXvdegTfz5N6ca9P4zeRh9IzSXeI9HwfN0dzh0iH6TCdP15YXoV0XVvILaWj81bJOuQMph8vCovKzPKnpqciLLhhPtV8UNCUR8ZacGMgOoaj2Ivt7Lqy0xunw6XOSoBoFmC2GiYEiunJVZiMnqVSCaDagSu9jz/wdSAgwiAToxH35NQe/dKNlJ5bc9dzAUyYpwV90nDnoHpk1WcMjfrKRek02p8qojwp5F0D6Kuf8CNX12p8b2JtjLJ2m72TeVWSo6JJgdjjGjU4rTqx4Fep7DtMrOslX3j845K5H9kmLqpaO5IzFlEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8r4KGhX3PhNMZ/ZCWFZ1ngUwOVF15Nq7f4dkkNyYYXk=;
 b=ClyI+2zHDYM+nct/iyhRlM8q3ejLCQLn7sgR+2eon9EnZ/cz1D+xqCKDoouJo27l+hHGXZJ2pfRAarW2QwkGPrZWmyj0yTXPBNUdFmcgCihe9/GNxFuSlASIUnABphEsDNdB6H6vhcQ/4hVePb7ZUIQIoTKpDtDYQSFYcA+j+nmNcJnAhdnqo68sbw+CKvJe2q0PkAZ53+mUVKoKCK9sHcTxKe9MDxxDwf8S6rvQTEwATEumznicIPFoAdBedKiDGw1vkYkd8tVlNq/IrPGgf2GwFE0UyK7ahPCcDug7juPtsvrqkW0JojmZ6oK2Vv2hxwUvvGA6UXEMt1l8iFguxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:740::12)
 by GVXPR10MB6323.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:16::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 09:23:15 +0000
Received: from AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::527e:14a7:bd3e:86be]) by AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::527e:14a7:bd3e:86be%6]) with mapi id 15.20.9587.013; Fri, 13 Feb 2026
 09:23:15 +0000
Message-ID: <85537095-c0b7-4985-982d-01bdb326bc7b@siemens.com>
Date: Fri, 13 Feb 2026 10:23:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH v2 4/5] ci: Add CI for libevl
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
References: <20260211131043.1185863-1-clara.kowalsky@siemens.com>
 <20260211131043.1185863-5-clara.kowalsky@siemens.com>
 <d653b7d0-4655-431f-9bdf-7f6baacdd5e3@siemens.com>
Content-Language: en-US
From: Clara Kowalsky <clara.kowalsky@siemens.com>
In-Reply-To: <d653b7d0-4655-431f-9bdf-7f6baacdd5e3@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR2P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::8) To AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:740::12)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR10MB9645:EE_|GVXPR10MB6323:EE_
X-MS-Office365-Filtering-Correlation-Id: a827b383-774e-49bb-c89d-08de6ae18430
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z25yZmt5SmI4TzBNZ3AvNEI1Y0VKejBJT2ZvSjFGdXVzNHlLYlE5MmdxTDJq?=
 =?utf-8?B?QnA1K0gxQ0NidnUvV0RrdkRKMlpveHprczNMZjFPVUJtYkowVndDYzZINS8r?=
 =?utf-8?B?aGZYR0l6M1hlc09mbDk0YkRmZXl5Y2ZSWVU3Uk5TQXVwblIvRldDR0J0QWVE?=
 =?utf-8?B?eVZac3RrUW5FTHpFb21HczhpSWtJcWdlSlFNblBCZzY2MWNFZUtxdHNKSmhI?=
 =?utf-8?B?SzIyYzRkRStXOSt0NTdsc0JoQmdsNlZoUUNTeDI5OHJ3WXNQTnNaSUVsK2w4?=
 =?utf-8?B?YW9BZFhGMm5BdFNkZHJkQnhtUEovNUU4OGxCenRhV3J2aDdlNzk4dDdZQ2pk?=
 =?utf-8?B?TVZjekFEaGV3UnI5SmZrU3lpR3JpT0lWb3RKclRnQXZWYnkwOVpBdUtRQ0NT?=
 =?utf-8?B?QlNucktrOE9xRkh3MTFmaWR6T1F6b0dxTU1lbXVVUmxob3R3cXlzdzJ5NUgz?=
 =?utf-8?B?UTNUUlIvcEwrR0ltS3BtQWZVSS9wQXJtYk1aMThEYkJJZmNMY1Zab3o3YXh0?=
 =?utf-8?B?bFpmcE56aGszdEt3REtERGdtcGNPUmFvdWdKUGxOT0hlbjlHb1VjdDMySXo2?=
 =?utf-8?B?TUY3QWxDSUdTbUY1V2lCU2tTeUdtUUNBYmFSdUxTdVR2NXQvWkFhb2QrTXBr?=
 =?utf-8?B?cEZpNXVMLzZQZzdnVzVjM0JkdWNNd3EzVU13Y1EzNExGQW5Ed3BVdXByNDA2?=
 =?utf-8?B?VXYxZjI1NDlPcGZNc0JpdXo5NlpyOUJmN1psamFNWFVlanJYS3RNd2N5M1lI?=
 =?utf-8?B?SUtsaDhpN25sUjVGcDRtQWt2empLejhzODRMaXFjaEcyRTh6dk9YSjZtYlZ2?=
 =?utf-8?B?VUR2ZmRyeDNmR0dHZU4zVEJ4THZKamFac3Y2aExiam5SVCs4T0l4L0E2bnBy?=
 =?utf-8?B?eU1LcTcwUzZlUjdvaWVjanUyMEUxbDRzOW9GNzZxZW9LeVJ5NHhxTjlYQ2E1?=
 =?utf-8?B?NHZxMFdabGRzbSt1RjQ3Wk5IWlc0cEtGQ0g1UG9QRE1QRE1EYUZpSXNQVXJM?=
 =?utf-8?B?NHF5QSsyNEdReVIwSlRHbXl4cXRVcWRsOG9MWmVIeGJLZXp4K0w5N1VmMFZo?=
 =?utf-8?B?MGRnL214aFFXWFI0R09nYTZoMVV6bmpKRlhXbWdXTFhJSCtDWTRPVzN5Rml0?=
 =?utf-8?B?RFB6VmJjdDVvbnFxWUx3SFcyMTVRU3ZuR2ZVRWUwUHdKWWhJNU5XaGRsejZn?=
 =?utf-8?B?UWRiZW5hTzR5MWNaTFhERnpTMWVueFhyVlhnV2ZRUDBmSDNjT1VYZmFUbUdw?=
 =?utf-8?B?KzQxcFp6bXFvVkxXSXk3OWFseURVWmVOZjZISitzY0h4TklycHdlb0FGUmVz?=
 =?utf-8?B?YWhGdUprTFBtcFBYcUNVd0prQ1YxUE1uQmxON1ExdHVpZUxnZTF6VVowOWJ0?=
 =?utf-8?B?UmNYREpvU045VjN5KzliRy9OenFhVm5tMnVnaWZic2E5aUtUTXQ0Yndia2ZE?=
 =?utf-8?B?UHpzTDl6Mll5MHdlN1NTRllseHRHQWZ4bXVmYWdMcjd2U1U3RFMrY1RLcHBF?=
 =?utf-8?B?N3FFaHJ3STdETFg4OGZLc1J0S09VMHNUMmxqVldDaWN5MDJMS3VxdzNvcGZp?=
 =?utf-8?B?Vzl6VW4xZE9NdzJaU2VPTG9wS0lYU2M4SUlLUktnTm1YeDlBUkJUY1Ywc09i?=
 =?utf-8?B?U25UcWhUMjEvajhDWG5qQlhaVnEzZ1BPUGF2Vmp2ODdURXR3QnVTMVNNelBN?=
 =?utf-8?B?Q0NGM1NRUXR6N3hJbUMvdjhWSnJjTVdQbDZPTDdGU1ZtVnU4b1hMNW16ZWU3?=
 =?utf-8?B?clFKUnIrbFBIUFI3cWlTZzJoSGtyYUI3Y3VOWW9sUjBZUTJ5QW1JS0VhZ3Rz?=
 =?utf-8?B?U3hRaFhvWk42V1crYjNtSVVDUmRaZW5Sb04vM29tUjhCeDQ0cVQrckJnOTRL?=
 =?utf-8?B?amw2Q2NkcE4zRW9XYWJ4eTBPU3hhQXdLanFaMTdhSDRoc3ZpNVJRK3Nka2to?=
 =?utf-8?B?RWFBM3FMa05FOVRhemY4NStZemVNMjhUTzVKSzJSQ0VLVkVOSUJzeHJqb2VM?=
 =?utf-8?B?NUg2R2I5SG1qL2FKRXk2c0VjRWk0amVIeE9Na05FMjV5QVd6SXJTN2NuNlRk?=
 =?utf-8?B?R0J1allwM05oakdHNEYvcm9rRXErZTkzTkhWd0VIWVRHdlZKYVkzd3RNbDhW?=
 =?utf-8?Q?jfT8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bW43Q2g3V3FTc3ZQdWNsZ2l5RTRQdFRsK2c1dG00UTZiZHpkZE9mbXJMOUsr?=
 =?utf-8?B?NGZEazZLbzROUDJUZG9rak90TUJPT2V4cklucVV6cmhNZVpYVE5pMkxwU3hX?=
 =?utf-8?B?REh3T0ZGdmd5QkhQUVRBaEVCT3R1ZXZ5UTNVNElXMVZvUUh0d1ZBNlFrbjV1?=
 =?utf-8?B?dEVFSk1udVZxWnUzaVZxdjdOdTVCdkVPRit4ZWJ6amZFQVVaUWFpT3g2Vk50?=
 =?utf-8?B?Vm9wR0FyKzh3OURjMEIySXhHRU9qcGtvamVxTFM1UlNDZm5xMGdwRGc0NWpn?=
 =?utf-8?B?eG96cUg0Mk1vMWZORk9aTFRqNXdUNnVVaWt2UThrZGV2NWZmTENOL0ltbnFB?=
 =?utf-8?B?MHdZWXltQVQrdE82eFkzR2o1VVFjV1Q3NHFkTXk0K0NWRXd6Q0pEdnZCQ0JV?=
 =?utf-8?B?OHEzZHJzYmtuYVN6SUZiOUNwbVNEOU5PUlM4eVVnRDRhaU1DTGI5bUdKcit5?=
 =?utf-8?B?VzREOE5ZYmxYYnZ2djZnL3BYVzc4bWRBOGx1TTk5ZytzRGxOMTNZc01UYkxp?=
 =?utf-8?B?V0pqNTVVT2d3TUMyZzJ5MXo5SUV0SHQ2Q1FIQ09UVGRoZ0FLRHNzMHNVTys2?=
 =?utf-8?B?ZFAyMVAvaXpsUEgrL3oxU0lTb1pRcXgzeVMzNGVpSG5sQkFnQXJqc2xEU0FC?=
 =?utf-8?B?UmIxSnVsMC82SFcvTGV1RDdZdTY1RmQ5ODR4T29ZMzhOMEJPdExkbkp5RzNn?=
 =?utf-8?B?MnhqdWNlRHVlajdqQnF3aVE5dHdYTG9zSlAxcVpwNk90UkZVZHlrY3VEWWtB?=
 =?utf-8?B?Z3JCaUJHVnQrSWp4YlpUNUhzTCtWMzNKQ1hrNU9lbmd4VDBrWUUrcjQ3NzMx?=
 =?utf-8?B?ekJQNi9YL3BjVzNTR2QzZnpKNjlrYWNkZjBxaU50ejhBc01EdlpzYytrNjFO?=
 =?utf-8?B?ZU5Sdi9qRkt3Z3YwR1VSeEtIS1IxeU1neEQ2Mi9wOVFHWWN2MTFseXhqRWR2?=
 =?utf-8?B?MktPSjBFRnVhbnA2UWFWeFkxalQ3R3pjUE5SWFdtRTh3ekdvZURiTlF5K24r?=
 =?utf-8?B?b25tUEVtNzFYVFNLVmF0SjV2ZXd3dE9nTjJhdFBMN3pxWmdycTY3RHF3VE9r?=
 =?utf-8?B?YlRkZnprMjhKMUhtYUpXTWhyRFFocGxBbENTbzR5a3ZyOTk0bnpxcUEwdFRS?=
 =?utf-8?B?VDhDQnNDanR0aExRczRvdXRsalU3Ymc1NVVNazJFalhmdzdRSDNRejlmRWFJ?=
 =?utf-8?B?V2FVVm5Db1l3TG1qNDlNSFQya2J0ZGlLcm91K0hkRWFKUGN3TnlNK0ZFNmho?=
 =?utf-8?B?VC9xcE53b1JYOFV3NXltWVVUcFRoSzZGVUk4eklyNDZ2dU43QlFzRFhJMTFB?=
 =?utf-8?B?T0llZXg2OE1TRU1VYjBkRnFzbDJkZlpXbGxBUS9hY0JNMzRTR2xmeCtmUGI1?=
 =?utf-8?B?Q3RKQ2tDSXZIcG9oYXhEYlozVzNiKzZPdm5lSWVpakZoOW9tYVpEeStWVWZ1?=
 =?utf-8?B?MGNvV0YwdzRVMXR1RFRoOFptUmQxeHNLMHJXR0NCTjQ1SSt2THpzd2lPajRS?=
 =?utf-8?B?UUNxeUtMTWwzNktXNVEwRVMzTWlqYWRkcVU5Y2FWTWg0RzlYc1gzZERCUnY4?=
 =?utf-8?B?VmRpQnp2VG5pVFdsUElqNTZreE5Sck9taVBqWjJ6NDNxVE9VMTY3a1BPSEhy?=
 =?utf-8?B?ZTZOOFc2WEVkRG9Jd0YwZWVEbnloR0taUUphUHROaUVpamc3U1ZyL3RoTHR2?=
 =?utf-8?B?Nkh0S1pQTUpyMGNhd1E4cDczSDM2ZHF5T0JnU2pjMmprc3IwMVROTEZwQXdy?=
 =?utf-8?B?bGFRQmtXbTNYUnhBTy9kcWNKcGtUeFVxOG1uSjMveHAyRnlzYjVQVlBlY3RS?=
 =?utf-8?B?NmRKYjJ1RVBIdmhjZks2U2UxblVnOHdoZDRsbTgzWXVqVERFeFBTMU9RS0Rw?=
 =?utf-8?B?K25kWDRLaVFNN1BtVkJqcG9zc01JaGk5cXBjeW1nODJIRXU2QWtnT0xHdngr?=
 =?utf-8?B?QXByak8yUnQzc2IrbUNmdEZWd1M2SHBUaVdrWmgvZUdGQkN4UTArb25KeEpS?=
 =?utf-8?B?TkNUbmNqNnRaR1BwM3A5bk5vclBZU3NRTGxYSmQ4d3N1RlpOdGZPeFlzQmpV?=
 =?utf-8?B?SVhJbmlGQm0zVU9KbGJHYllQRzR3VmR5Sm03WGRYcytxaHA3b3dBL05NcXhH?=
 =?utf-8?B?SS93RVBOYXJNMzJOdmowczQ4bTFJNFB3NEhWeGhETmIxc1NuWVlwMzI5REFC?=
 =?utf-8?B?WmZVeEFLTzBBQ3Q5aXJaeGwrM3BJd2Z1MlJnZTNUYU95UDhQLzFCbUxtaGxD?=
 =?utf-8?B?Y1VOTUxkVFV4K0R4YzBJS0txbUMrbnZGamxvKzBrUWJFa0tWN25mSWxpRm9Z?=
 =?utf-8?B?dFFhUEtaL0hqbSsyQWFyVkFIWWtuMFB3L0MvalkwN2h0SzdwL2xiWmN2TTA1?=
 =?utf-8?Q?Zi1o5xpL5GeoyWs4=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a827b383-774e-49bb-c89d-08de6ae18430
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 09:23:15.2052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U6OBstS6+THsubWOAS7NGk3/t+LmQzZnkyUVRmjZmJH4lo2FWfZEJn8i+RjhIArxcZ7BkYO6sx09rni48biiMqKykb04Q79w7/nWFnQT/Xc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB6323



On 2/12/26 20:07, Jan Kiszka wrote:
> On 11.02.26 14:10, Clara Kowalsky wrote:
>> The libevl repo uses this CI/CD configuration file, as configured in its
>> settings. If new commits are pushed to the libevl next branch, a CI job
>> is started that triggers the xenomai-images CI in combination with the
>> linux-evl head branch. Build jobs on the physical targets as well as in
>> QEMU are run.
>>
>> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
>> ---
>>   README.md             |  9 +++++++++
>>   ci/trigger/libevl.yml | 28 ++++++++++++++++++++++++++++
>>   2 files changed, 37 insertions(+)
>>   create mode 100644 ci/trigger/libevl.yml
>>
>> diff --git a/README.md b/README.md
>> index 00a62e4..e6535be 100644
>> --- a/README.md
>> +++ b/README.md
>> @@ -72,6 +72,15 @@ as specified in the settings of linux-dovetail via
>>   `ci/trigger/dovetail.yml@Xenomai/xenomai-images:next`. In the triggered pipeline,
>>   images for the corresponding linux-dovetail branch are built and tested.
>>   
>> +### Xenomai 4 CI
>> +
>> +#### Libevl
>> +
>> +Pushes to the [libevl](https://gitlab.com/Xenomai/xenomai4/libevl) repository
>> +on the `next` branch trigger a pipeline in this repository. The GitLab CI/CD
>> +configuration file for libevl is located in this repository under [ci/trigger/libevl.yml](ci/trigger/libevl.yml),
>> +as specified in the libevl settings via `ci/trigger/libevl.yml@Xenomai/xenomai-images:next`.
>> +
>>   ### Local CI Execution
>>   
>>   The CI build can be executed locally by
>> diff --git a/ci/trigger/libevl.yml b/ci/trigger/libevl.yml
>> new file mode 100644
>> index 0000000..bbd4e13
>> --- /dev/null
>> +++ b/ci/trigger/libevl.yml
>> @@ -0,0 +1,28 @@
>> +#
>> +# Xenomai Real-Time System
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#  Clara Kowalsky <clara.kowalsky@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +# This is the CI/CD configuration file of the libevl repository,
>> +# as configured in its CI/CD settings
>> +#
>> +
>> +stages:
>> +  - trigger_xenomai_images
>> +
>> +trigger-xenomai-images:
>> +  stage: trigger_xenomai_images
>> +  variables:
>> +    ONLY_RUN: xenomai-4/evl
>> +    KERNEL_VERSION: head
>> +    KERNEL_VERSION_WITH_QEMU: head
> 
> Hmm, this only tests the latest libevl with the latest kernel. I think
> we should rather trigger a larger kernel set, like we do when triggering
> via xenomai3/next.
> 
> Jan

That's what I had announced in my first email on this subject. I'll send 
a patch where 6.1 and 6.12 are triggered as well.

Clara
> 
>> +  trigger:
>> +    project: xenomai/xenomai-images
>> +    branch: next
>> +  rules:
>> +    - if: '$CI_COMMIT_BRANCH == "next"'
> 

