Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012016.outbound.protection.outlook.com [52.101.66.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C7A347FF8
	for <xenomai@lists.linux.dev>; Mon, 26 Jan 2026 16:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769446550; cv=fail; b=c5w0elYyWvZvlLjveR9Io0WWjH7FG0Tfhe+XYqZjLcCRvQulkn3icb2vi6VZ8RqQEtjzg9sg3UUXwWSxH+MAkc2jOL5DmiOm7Zgd+rPqSN7Y52sY55e2L8EfLtyfe8HjS1hsvF6oif1pQ1Tjz55IK4xOP/+QjJ1P4cPrZXHr1Vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769446550; c=relaxed/simple;
	bh=v9dXlC3e18YLRktLuUN8EefXhgzRHcXR6HDcINw1mOM=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OOPWQ5HMUIrPLFynXTPumEzVI3ZQxSKe8UYfQJqyp+3XJm04IIYuRKjL12uhzF2/si7CvG2TsGxb6dOs7IKTEbejT7iAchirWtUeN6pFh5xf+gAvLxNTtJVF0qgd2/dtFPUnzc0Zaeiy9YX4jG2IIM0BM0DectGgQRwfsXjWSeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=VTatSO8g; arc=fail smtp.client-ip=52.101.66.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="VTatSO8g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/cuDeLJ/SIMMi3kOMnk135yNfJmSN44rtLF2VKx0gAxM5EOumCZKjIy35+Gs/Jkzg4IYaRsTvU/1leSMsNuiYdo+Yaze7SJuWFsLSY6nYgfVbJ3hqi8dcGh7oO1/93roDeuHEmtR/z3dhOGXYE0uWRvB91hk8ot/O/mhERTC4nMq9M1bDX/6KyV9PeSELMaE9ejmcKUUgOjfFKRzx1r1Ib/v4W1mFnaNHCiL4R874NPutksMWqn9mNLA0CEyMpXfWv0pbxPCbvlvCmW4V19Pe+8prWxZzIc0l6X88uNaA3aWcpKxTLoXaUxJ4+jeRcbViOFTwOLLL22TiC3I2JAQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vukwACTODOjAZom5xRcA9SElYGZ1TAtlM2Mv/agsMpU=;
 b=U6U+7QXqlfDZ5P8J2vlEhOEXDGnfdFigR0+vcNy0cQ2neW9RkGXX17+DKDtk0y4uEH9EnNNsm9NuR5sGEGqQl4xlz+HkjRdvQ+1xmpNfhHaOSimrbG7WEZlfCtoppmeZSDut0VO/ngj/s9Oirm049nZDqTdyX7JFoqKeDucX9ak4ak3PGs5jnn+nadVZjqrddtlx5pmzi8kmnpKBiavnmSvKGgX23cs4pZAwEAcyzDsxQIEgcJG2hyyp7qIDwzeYmWGvIiPutR1GQM1XTOdn7R4SBUZ7t9lMEbG0neCTfLR2W89aSZzmTnegcq87SMjkLNF2XtSMXM81c7DcTWn9Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vukwACTODOjAZom5xRcA9SElYGZ1TAtlM2Mv/agsMpU=;
 b=VTatSO8gwNDJWBkuRi3p9fnZYQkHM5NrwwQLtdGyteMDRkBDXXsG4C2AUCl7RcmsfFnDE+yV1g9r6p2jQVOxrtH0M/LBNvWXezZkLM9Kh5ECxjHMlEWeFGkJsaFV4d3MiqJbtacekTFBDJu4zaJj3pZde0bG6AquEGETLKbj/V4qn1Y1kR2DmhiQH64ifineLsuKrWWIp6BK5lydsNbef+Lx1aA+eSMY8svXNkGfh/+4WVkk9qLY62T3hg/c6k+77IHa3P2Yn/VZU8C1EqRa0OBPvpkBCjvDAAOsg3J2DwMeM+ZXbxE3Yh4JTIhJNg0nNor91I4DrI1NTSj56ILJ9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB8383.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:231::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 16:55:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 16:55:44 +0000
Message-ID: <75010358-1588-421d-aa8e-25337710dd3b@siemens.com>
Date: Mon, 26 Jan 2026 17:55:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH 2/3] ci(xenomai-images): Add build job for
 dovetail head
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
References: <20260126161445.349483-1-clara.kowalsky@siemens.com>
 <20260126161445.349483-3-clara.kowalsky@siemens.com>
 <a0773141-3551-41e2-ad7a-0ef90b505e58@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <a0773141-3551-41e2-ad7a-0ef90b505e58@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0247.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB8383:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c72015e-1b4b-465d-8f82-08de5cfbbe66
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZjJjK2lXQ2UzLzlndmxOejRSemZpOGsxeDlEYmw4Uyt2QlJMeHhnQ09USXNZ?=
 =?utf-8?B?bThrR1NtYndqZm0vNlBibXJVeXlLZ2I2NUUvelRBZFgweVdEaG1MekVnTDhF?=
 =?utf-8?B?cnc4NUQrc1lEUTlmTmxBM2JrekthdEdwT3l5OStNMk1QWndENmREd1FtNk5M?=
 =?utf-8?B?anpQRm93WUVsaXZJaWVweVhteWNHZTBKbGx6b2hSUWVuMW5yblpHMzY2YUpw?=
 =?utf-8?B?Q1RqWDhiZXgvWVNnTVpUaTVSUzN0dU5FY2FPTUsydGdidXhjbUc1VmV2NlpC?=
 =?utf-8?B?YzlnRVVNRHFJby9kbVBxZ3JENUVaOTUrMTZrWUd0N2pWQTM3RzVJQ1lyOUNj?=
 =?utf-8?B?Wm52S0Z6ZUNTMG03aU5abFRwc0lsalFBUG5pNVNaa0xqRXJmdzZxYVA0UVlY?=
 =?utf-8?B?a1ZrdVlPU2xxUE5ucThzcDZwN2FHRFhFSEFtVzhSWW1CVHhVUG5YTnpOdm1x?=
 =?utf-8?B?U09INkN1eEFScW9NL3pIRW16R2dBUFFubTR5dmlYUU43RWZWSHRFM1J6K1Bx?=
 =?utf-8?B?emttYXBRdXdjTkIxZUNYZHR4cjBPYlZLNjE1VWVTMlpPUVFiOHlmQ0x1Z0JH?=
 =?utf-8?B?a1lIV2FHZHpKRWh3dzQ3SzBmSXg3T09QcjdHQ1BqQ3lWRjhjbXJJVjNkL2x0?=
 =?utf-8?B?ZXJhdWRuM05NY3hGRGtCZC9DeHJHM0JFaWYxT1UyMi9hS3k4bVFndFR5b04v?=
 =?utf-8?B?SjEydFNoNWVIcXBCTmhMdGJUNURIblo4VjlDSVVqYTJxTHhaVDhQUnp0d3J3?=
 =?utf-8?B?ajUya2xiMklzT3BxbVY4dUx3a1VaYXdMQSt0Z28yUDIwaFdZckNqcmlZY25m?=
 =?utf-8?B?cUZsRzBKSmdzb293TFNvOXY2K01nblhWYi9uUWc2N3Nac3Y5ck9ZU1NUdVVO?=
 =?utf-8?B?bUZIR3RLM0tYR0FCK2w0bVhQSnlmMGthbUdadk9DSXkxWE5vNFZPWGQ5bkVU?=
 =?utf-8?B?UU9IUURTczRJZDlKaHM0eVNod1JPd0hIV05kWk1pM2RqVGx2WVc1UEVjeTll?=
 =?utf-8?B?ak5VaDJqa2JFQk9UMjQ4dWJhUmQ3SEY0bnk0M1ZtMlBlQW9wS1FGMTNBMFND?=
 =?utf-8?B?RVlydjRtT2hZYk52emU2cEI5SFM1NHBHV1JOdmNodXo0NU9zZ1FqcEh5bHhj?=
 =?utf-8?B?MGhHbU96Y3BNVzFYanNsK2p0NG9nQlNMYnBSMEdQeXRPNUFOYmN5U0JMdVBu?=
 =?utf-8?B?eDMwMHNFb0tTdjJtc1g3cUlhWTY0ZlBjQ0RPL0ZWZGZRcEZjeHU1Yi9PQ2c3?=
 =?utf-8?B?UmxrZkpWSXBYM1UyR05DUmhPVTdIMGw0bG12Y2c2d1hvSmpVaHBGL2Y0T1l0?=
 =?utf-8?B?UmhoVkU0NUFEWkFmL0ZyUTd0TXIxVDFlNVRRWFZOaGhIbWY1aFZrUHh2VDUy?=
 =?utf-8?B?NDNnTzZBV2tRNXhTUHEyRmZSTTlrV00zbzc5R280c2VxeERVRmpzV3RqMzVP?=
 =?utf-8?B?VEJKd0w0VXdLM2NJUTgzbkFIVEtSMzgrSGl5eEQ5dVZzVGliMngxMXM1UHU3?=
 =?utf-8?B?T2hOL1hDZlhiMkZYY0RoTXJwZVFiaWx6RWVjdDFueFNGbG1rQnVxcFNkSDkr?=
 =?utf-8?B?SkVpNDlEaHhmc0JTSnVsYWVuTXowbDY3cnVRV2hyZDJaMEpicmYzVkVlZllu?=
 =?utf-8?B?UlBVR2VtWG5aWnVLeHBSZkN2WUtuMi96VnNqTWVzS3VnT3RMYlpOSkVqa1ZC?=
 =?utf-8?B?ZGpacGQyblBQS2svOEk3RU14QXFaTGVmNmhtTU8rK3B1NXJOWUxUWHpYU044?=
 =?utf-8?B?cGRPbkpVUTh6V0ZDd0o4Q1Z5a1pUZzM3M2xzeS9QOGhESTBEdyswTEFubUNR?=
 =?utf-8?B?bEQ3M0o1UUwzZndHdVFaWG5XbkZaVFI2RWNnQ2NrNzVvYzdtRHZISE0vTjNr?=
 =?utf-8?B?cmREUWpoeUJxUGF5ZUhlT0lxOGxEQ1N6SVhueTY4eERnaUg2NVFwRHprWDBX?=
 =?utf-8?B?VnJZTElqTHRHbU0xTklSdmU3NEo1TFNBaU14T21KR1RQMSt6TXB5dFp3MEdW?=
 =?utf-8?B?SVo5aDlKUkl3WitUL0lxYVo1QWxjZ29KdnllcFFTbkVLbTdRdkgwRXhTek5a?=
 =?utf-8?B?UGc3amFVbkEyR2pRWElDTnVVUkJOV2JHcDJNWW54Z1VmNkx1a0hhNmEvNkRs?=
 =?utf-8?Q?LqY4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjU2OTIzcDFVUGMyTmttVDExLzlYV2JxRis2THVsb0F1MGQ4aFZ5ZnVmZ2pC?=
 =?utf-8?B?eEdFaGdsaUtNbGpEREV3Z3pWOUJLRHdSdjdWUGJQd1hhOEJIa1JlSFJ5bXNY?=
 =?utf-8?B?anpObW1rQ0xaYmlveXI3VTB0aDEyN2I4UTl2Rm9kOHFqcDY5cFZVeVFVK0VF?=
 =?utf-8?B?eVgrWXptY0NDU2UvbjUwOHRCa2FMcmcvb3ZqMVQvNURKcEFxVGxER21CUGdn?=
 =?utf-8?B?clE4Y0tPZVVVbE9aQis3VTV6ZHd1ZngwVDl3YWFiTDBhQmVXL25Yc3lsTkhm?=
 =?utf-8?B?VjBWUjRQaDY5S1UrRHQrdzdTdFUrZGh6dWpjWm1zSUlpRVRmcHNrK1hVNlpx?=
 =?utf-8?B?UEFiNjRJV2lZczBzamtuYkdXR3R5bHNwTHlFUW9Qa2orakJyZGVhYVpxUXFC?=
 =?utf-8?B?cktZT1BsV014Um5UMHVUY01sajYrODhvMGdpWVdRcjA4Nm1oaXdCWmxPSW0w?=
 =?utf-8?B?clVzajJNWWRWaitybWlJTnNHSTZVZ1c3VFFwTkFHR2NwT3VRZExoUnBBQjJB?=
 =?utf-8?B?UXVnSWlmUzY3c0ZDT1RydndlUTVyT1NUcW5lZEZuajg1VzMvQmRrQW9Fd29p?=
 =?utf-8?B?RU1mKzV1aURrREJHNUR2OGxkS1ZJZ0ZpcTlleW0rNjNuVHlHNmUrOUhRNUZO?=
 =?utf-8?B?VjJDMzE4SW9sQU9JOU13TjdIVDVkWHUwakJPc2xYR2ZmVHl1dThwVmJiaUV2?=
 =?utf-8?B?SXdGbEJOVytIbTk5d0lPRjlwREZGMWJ5NzIzSTdxUkZtdXVKOE1oVGZDa014?=
 =?utf-8?B?OUVKUzdUT3k4TEIyTDJKV09IakF6dTFZR2pxbGgvSjBuaVVidU05Q0drdE1R?=
 =?utf-8?B?bERPMVM0UEIxejhNbUtPUUlGT2l0eGlOZmhNdFN1S0dUWkhwN3FLYnhZcjR0?=
 =?utf-8?B?RHo1b2ppLzZzQmovcTVEMVBtYloxOTdSZnNOR1l4Vm1heG1CRi9uRmRETlp4?=
 =?utf-8?B?QVd5V2pTVkdtWWxHZnBoSWtIc3Eycjd5ZmgvRjBPOE5RelFzWEIzL2dBVzEv?=
 =?utf-8?B?dE9OSjB4U0l3cG8rZEdMOURZU0JyTmhkOVpKZGc0RndsZG8vb0pTUzhvWkoz?=
 =?utf-8?B?dnNtc0oyVmRMRHFwdkc3SnVxc2I4bUN3SXVoTUxpYVFyaUs2YmovcUpzNmFn?=
 =?utf-8?B?VnhhUE5vbnA5VWZ0N3h4NzB6MHByK2RuV053eGs5cjZzajNwY2xBbGl2SUgv?=
 =?utf-8?B?SXQxUENWZ3VqM0szcVVUcWFDNGx3NUdHd21qUjNuVm1GcGFqMFJWVlpIa2c5?=
 =?utf-8?B?RFNxRFc0SzdmVW9uZUJHNGFlSkhxbUtmMjBpU1czZGpYMnB3cWpxY1NmT1Jx?=
 =?utf-8?B?TXAwTVcybjBJVjJDcWlmK0YwbDgrSDVKME5DYVQrYi9pV2RlZmZXZUdJUHpx?=
 =?utf-8?B?emdIbXc1WG9ybkpZMjA2b1ArcG5NajcrUStvYW1HcTd2cDI5QkJkck8xS0I3?=
 =?utf-8?B?MDdxSHRSNWIvTkw0NldLWCtXamxpSjBSODBUeWVIbW0wcVhVUUpacWdCUGI2?=
 =?utf-8?B?eDhEbXJwWVNjZTNIS0JyV3VXdEROd2ZDTWpiVEhub2UvcjcrN25GTEVmbGFT?=
 =?utf-8?B?NEZ1Y3l6ZmcvRUM1SkxHMGFLT2Z6WWdXSDBJcGMxc0dzZ2JEeStaV3huZXNK?=
 =?utf-8?B?TFVXaDRqekhWVEtOVGVMOC9zSFZENmVXMmZJeWpLZTB2dkY4K242ZE9mR1ZJ?=
 =?utf-8?B?ZlFIL0JKcVA1NXRZWUpPd2VnQTkxQUd1WXhpb21yY2djZDBhWksxOWh4ZjZv?=
 =?utf-8?B?ZGllWldtZWd6RTlkOSsxak5LYnNOWkF2cldnRUloV1JTRTFzWC9iSEVYYlU0?=
 =?utf-8?B?SWMwSHJ2LzVnQlk2Z01Cd0hpazI4S1NFWjlwRjQzejR1aVpuMHJuR1NpQlZi?=
 =?utf-8?B?ckxXaDZQS2hwdFV2Tmx0OXh2c1cwSGV5RU1YVUpOMEpNWDl0cFFSK3FRQzlG?=
 =?utf-8?B?VjMrNkFxTzFBUm5kdjFEYllzdlRGdnJnREhIWVREQ0hUby9VS0VGNWxlYWhB?=
 =?utf-8?B?U0J4ZEhZMUlUdE9SWlJGNEs5aTc0SXhLQjRRVzVIS3NFaFpDUmtFa2FhSnY4?=
 =?utf-8?B?L1hadm54Tlo2YjNFNFVDUkdXZm1PVWlSOS9lRWhFNzVFaWFGTTZLbmtmK3py?=
 =?utf-8?B?K0NVT1FWT1R3aUVKKytXNnlDd1p3aFg5czJ4OWtPeTFqTEUzVzFQcXhaNkZV?=
 =?utf-8?B?amxzTVduaitPQ2RTVHM2R1RML0ZWNnBIekVsY3ZRU1BJVXJIQ0ZMaWh4b29l?=
 =?utf-8?B?WW13M2RFSUl6dTgwVldDVUJoOVRuUk5IY3hnL205VjFrZko1bDgxRW13bzc4?=
 =?utf-8?B?Qzg3TUZiZHpnb3lnQnBsV1R1MmFZTkNqSWUxVm9jYVlURk1qRHNOdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c72015e-1b4b-465d-8f82-08de5cfbbe66
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 16:55:44.0732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r7nO+RZFPyRKEW9fhPKvpBys7y7MHGg+WEbXbfBNtTSe5RcgkdY8coUb3fRA+uweKCvP76lIuuwy6zV84gD+nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8383

On 26.01.26 17:49, Jan Kiszka wrote:
> On 26.01.26 17:14, Clara Kowalsky wrote:
>> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
>> ---
>>  ci/dovetail_xenomai_3.yml |  5 ++-
>>  ci/kernel_head.yml        | 70 +++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 74 insertions(+), 1 deletion(-)
>>  create mode 100644 ci/kernel_head.yml
>>
>> diff --git a/ci/dovetail_xenomai_3.yml b/ci/dovetail_xenomai_3.yml
>> index 3ba027f..1628af2 100644
>> --- a/ci/dovetail_xenomai_3.yml
>> +++ b/ci/dovetail_xenomai_3.yml
>> @@ -25,6 +25,9 @@ include:
>>    - local: '/ci/kernel_6_12.yml'
>>      rules:
>>        - if: '$KERNEL_VERSION == "6.12"'
>> +  - local: '/ci/kernel_head.yml'
>> +    rules:
>> +      - if: '$KERNEL_VERSION == "head"'
>>  
>>    # select xenomai config
>>    - local: '/ci/dovetail_xenomai_3_3_x.yml'
>> @@ -32,4 +35,4 @@ include:
>>        - if: '$KERNEL_VERSION == "5.10" || $KERNEL_VERSION == "5.15"'
>>    - local: '/ci/dovetail_xenomai_3_next.yml'
>>      rules:
>> -      - if: '$KERNEL_VERSION == "6.1" || $KERNEL_VERSION == "6.12"'
>> +      - if: '$KERNEL_VERSION == "6.1" || $KERNEL_VERSION == "6.12" || $KERNEL_VERSION == "head"'
>> diff --git a/ci/kernel_head.yml b/ci/kernel_head.yml
>> new file mode 100644
>> index 0000000..fa109a5
>> --- /dev/null
>> +++ b/ci/kernel_head.yml
>> @@ -0,0 +1,70 @@
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
>> +
>> +build-head:qemu-amd64:
>> +  extends: .build:qemu-amd64
>> +  variables:
>> +    LINUX_BUILD_OPTION: ":kas/opt/linux-head.yaml"
>> +    CACHE_KERNEL: dovetail
>> +
>> +lava-test-head:qemu-amd64:
>> +  needs: [ "build-head:qemu-amd64" ]
>> +  extends: .lava-test:qemu-amd64
>> +
>> +build-head:qemu-armhf:
>> +  extends: .build:qemu-armhf
>> +  variables:
>> +    LINUX_BUILD_OPTION: ":kas/opt/linux-head.yaml"
>> +    CACHE_KERNEL: dovetail
>> +
>> +lava-test-head:qemu-armhf:
>> +  needs: [ "build-head:qemu-armhf" ]
>> +  extends: .lava-test:qemu-armhf
>> +
>> +build-head:qemu-arm64:
>> +  extends: .build:qemu-arm64
>> +  variables:
>> +    LINUX_BUILD_OPTION: ":kas/opt/linux-head.yaml"
>> +    CACHE_KERNEL: dovetail
>> +
>> +lava-test-head:qemu-arm64:
>> +  needs: [ "build-head:qemu-arm64" ]
>> +  extends: .lava-test:qemu-arm64
>> +
>> +build-head:hikey:
>> +  extends: .build:hikey
>> +  variables:
>> +    LINUX_BUILD_OPTION: ":kas/opt/linux-head.yaml"
>> +    CACHE_KERNEL: dovetail
>> +
>> +lava-test-head:hikey:
>> +  needs: [ "build-head:hikey" ]
>> +  extends: .lava-test:hikey
>> +
>> +build-head:beagle-bone-black:
>> +  extends: .build:beagle-bone-black
>> +  variables:
>> +    LINUX_BUILD_OPTION: ":kas/opt/linux-head.yaml"
>> +    CACHE_KERNEL: dovetail
>> +
>> +lava-test-head:beagle-bone-black:
>> +  needs: [ "build-head:beagle-bone-black" ]
>> +  extends: .lava-test:beagle-bone-black
>> +
>> +build-head:x86-64-efi:
>> +  extends: .build:x86-64-efi
>> +  variables:
>> +    LINUX_BUILD_OPTION: ":kas/opt/linux-head.yaml"
>> +    CACHE_KERNEL: dovetail
>> +
>> +lava-test-head:x86-64-efi:
>> +  needs: [ "build-head:x86-64-efi" ]
>> +  extends: .lava-test:x86-64-efi
> 
> You forgot to set KERNEL_VERSION: "head", thus no QEMU jobs will be
> added if the head pipeline should run them.
> 
> Jan
> 

Fixed up in next, pipeline(s) running.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
