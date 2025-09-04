Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012001.outbound.protection.outlook.com [52.101.66.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB6D3090FE
	for <xenomai@lists.linux.dev>; Thu,  4 Sep 2025 17:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757006838; cv=fail; b=VAJjJmEF+tjzUbk2/PmgiVTD7ibbWXhWPbJWCEjqc6k+YnKe1lAzMCMRBotcnCsQEehWJjDjjpY7zCePmBducAHu5VYaakjVjhopgzem5DhfbLkjHoaUfJDqvCFI0H3nnNCa/OUk9L3N/nyOO7ye1vTrRkkiIgqTpAmgzj5y1Bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757006838; c=relaxed/simple;
	bh=O+C6/ufj7xZEF+W6isG1JvA7QRfIzqXMmIWs94L7q+g=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=Qx1VrkPIpErjzfY++DBrnUVnUtgO629/DcVH7Kyff/FzdVoNkIy5SoccPdqtjjGiIt8LCjIaQ/MfQiWhKqIADeTB0Cvocl0ES5JBRmYYf1Gqewr2puPorZdvl5pAWsJ5ffcpUa7YnhyLNR1LzjQlwWe6Otr2l/BKZlGNeifPPHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ppQY6Z2f; arc=fail smtp.client-ip=52.101.66.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ppQY6Z2f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fbykuaOwk54wPPnGUOcGOjmyiERT7nTpHFQT/eEV2d1GiMLNgZqQU95Dtuq69iLn4l8AZiT2tbvLoPO2eNvhq3honn/XGXkK2EC5y4Y4wYz1JG5QLLzSeVypV3Bh0/2B5QkbZ6LHzUz+DLCJgG4pBWsiCLF4I16sPtcpyCvTexNUmU1LpNLLL9Od5jFgJy9TzBwnRGoKwr5tp+TGYcbyi3ZuGhzY45ZOv7kfpW4CejQ191r0ObQAcCfl+XLr82QxCnmOul77K9GCNiX9qk7zBP0F4OQ4TnPSdne9f1o7zMjRQo1Ez1eSWP+DCOkJaI5qIgvMqJ+OvFkodMP0i/v3VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCXsV86Egne0nPRQBWQSESBuhQmyLx6y2Vq/1j/wqtg=;
 b=VgKajhQGjIF4eWapa9cy3aMbnkJrmdzKbESdew6n5uV/3XrnSAKjmFcTc3MTn8T4VyMkCUNeTTnqO9zFVYtINjPF4yeX3P+pbhVYr4XCoUiwkHAPdx+D72+3vGlC7RuJ55WNuyGAHWgyVOhp4qkoCqtbcslux7G+ZuI4n9QgEefJKm1Vxqe89JIiveTMhNek7eI4EAGQXO59OBRpb8cxYH+q8Pgoy4KbEMEyDocY/3bhE1FfbGrIJKlbSedHOPvRtmy/0zIQtvZQyQP/ZL5pYrey8kfUfunb0mKAlixt12kX1HMWSdYY6tzsBHZZsupmb1n36f/2AZ2o+LJ42fbzWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCXsV86Egne0nPRQBWQSESBuhQmyLx6y2Vq/1j/wqtg=;
 b=ppQY6Z2fpsQIOMpCDfzKKHITQS4DeDzGEYLx9V6c4XiORTjJLLMAlPuHWlHqfZlInw27q+6y6C8oX7pr2v8rVTFfhCFxE/Fwj/9ahgHl9yoJpYrlVU2gi8I88OOr2ST3sTuLdEJNBdgU2jeO94mxzREyVl60lhos0veTs+jTDV+/nXQo9QIgCVJOndERG44alfK7qHb0JQvUCk7PaxmuGTNiegoqEQIcY/XEPmQ/JFte9dyHUSxa/0yRb0hzUO3HZPEcRPiBHa/5rLqFi20Cpt4b6+GZLxDNQdiyRhjcW2vqZXD0jqNGzJWGsIwBHHFs38ony8EkSNJL2RJ3iQ7LMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DB8PR10MB3708.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:137::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 17:27:11 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%7]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 17:27:10 +0000
Message-ID: <37fc449c-4046-44a3-8674-5cc50f9fa0c8@siemens.com>
Date: Thu, 4 Sep 2025 19:27:08 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] Add __percpu type tag to xnclock::timerdata
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0162.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::12) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DB8PR10MB3708:EE_
X-MS-Office365-Filtering-Correlation-Id: d69a34c4-844e-48d7-e799-08ddebd847ba
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K21PYTBsVVBZWlZsWHJkbXRtejI2ZitmZTFTcmhkNFZvaTVqU2dObStGSmVJ?=
 =?utf-8?B?MUNqMFY4YjNIdkd6ekwwREkwdVU4d0dOOW83dDBWTEF2LzdZSXNOK1VSUlpx?=
 =?utf-8?B?T04wUzlvVVFpbk9uandLTklya0EwRkI2bjUyM3ZTVGhEN0tNVW5IMnEyQ2h1?=
 =?utf-8?B?c0xaMWJKUzRlNCttZDFieVl6RGtydm9ld0Q1ZW83VDllODRxOVd0TFFBbWFt?=
 =?utf-8?B?TTNKNnV1N0l1YTN0c1pFRGhJQ0xZQjY1UmIyV2JGVjZaSVZScC9WQnp6NHor?=
 =?utf-8?B?S0dpRm5vdmw5UkVuT25kYXcvem1uaEwya00yRDI5dUhLOW4wUTk4ZE1LcHUy?=
 =?utf-8?B?Q2xaVjNsK05DZ1kzbE41L0RoalJnT0xMeHpNcjJmbDNTeUNFQVh5UHRjODN0?=
 =?utf-8?B?MW9iQm9aNjkvd3BYaFFjWVNiWWFhOWd6d1pxblFBc2dzTGV3LzJxbmxCSHBM?=
 =?utf-8?B?QWtaTnhMWTB1YjRyNGtCSXUzSlBjT0RGUHlhQk5hUGtzUUhDRk5MMlBFUzNM?=
 =?utf-8?B?R2JwV1lSN1ZpMnhibkx0Yzc1bzhvQ05MMlhrWnUvQVBybEc2Mk9yVHlBd2Fw?=
 =?utf-8?B?dTB4NzN3WUh4c2xHTnRsRHRRdkd6QjNJNy9DaHloMEUyaFpTSkR4TlllUUla?=
 =?utf-8?B?dk8rbW05NkVIdmlKQXZJbW10TFAxUDUxOEtlK256bytaQjBkaGJvb3UzY2Ru?=
 =?utf-8?B?TGFxaHdlcnA2dkdVaUZqMDIrSXN6M0tiSXo3ckF3R290d2lwb0ZVL0tVWE8w?=
 =?utf-8?B?Q3JzSE5pRUc4UlVmMnAxcE1TQUZhTXlwelhNVFVKdE9mNXJEQy85ZTFWYmNV?=
 =?utf-8?B?UHBCcVZldWl6ZVRueEd6MW1TVHN6WWppMUFiR2dDbGdYNHkvU0Vyc3V0elNL?=
 =?utf-8?B?dWp0alMza3ZLaml3L3ZBN0JCRUR3cjkwcWg0N0V1ZlYzUzhnYlh2d24vbGRy?=
 =?utf-8?B?aXlyY2RxVnNjNkJhaWgvMzA2cEV6aFlBcXhFWjNuK0pjamp4VUNRbHpUcFVI?=
 =?utf-8?B?R0xYN2MzcE1HSDRrUDdBMm5vY0ZTOEdUSzlPd2dFUlY5aTBYTzZ6Zkl0WnFK?=
 =?utf-8?B?dkVFTXZrZXltUTdlb3U4TjVYeTFKL1dMZE0wdENVSlhsSlh6eDhMd1pjT21y?=
 =?utf-8?B?S2d4VmY4MEpHWWZ6UGdPUnhoK2FhWTlmdzV3V2VpY0dVQjhSQXY1dmgrWGxQ?=
 =?utf-8?B?ZlBNNVo1ckhJZS9wZHljak1rS1Y1dTFRNERYb0xDZjhQS1A1ZzBhU2VEcHd2?=
 =?utf-8?B?bUd2ZVUzaUplbTd1V0NETDFDcmtHYzlQQmZvUm90K0p0WWVIdzdUN0VKSG1W?=
 =?utf-8?B?aEp3MWFsWHZQTEJFYnBtby92SUkxeVp4TzJxTGljQ2ZaTFI5TWNTQWtMV0Na?=
 =?utf-8?B?dkhoSzFFNzA4UzMwNTcrdHFCYVBuTHpaa1EvRU1hTzNiZlJqUUd5eWtJcGpa?=
 =?utf-8?B?aEFVZ0dCWkpveVVkVHRobGprbHBkS0haYXFVSE1YUjA3N2dZM1ZUdGtVQXdH?=
 =?utf-8?B?SWpmdmFxSy8rZlBjVnI3US9BbHhkSWJYaG1Wbk9TRlZ5WHRpN3dXMlkxZHh2?=
 =?utf-8?B?WkQxeHVkRFhHaERQaTFmV3IxUnBvZU9BTzNncVdaQkVidEc4ZzhLM0JsaEpY?=
 =?utf-8?B?MlJpZHlvUWViTmloT0VjdzVtenpSU1NUOE5xMlloY2thM3RqQTlxYkg4YjBK?=
 =?utf-8?B?UnJ6Q1ZiM214TmdJNE9XMWlGOXFuRXcydW1QNGRBb0Z1VDNYcG5oUjF5bEMv?=
 =?utf-8?B?RkFkemlqOFRmTFhvczF6UWpVZmtCRndzbzZPdC9EdTBVT1QyYndJYTh3dHR2?=
 =?utf-8?B?V0l1bEFlTXdVb0pJWFR6ZGFnZ2pyMWg4dURqd1FCam52S0VDelFBYkZRdVVS?=
 =?utf-8?B?eG92NnBnOTI0dmpmTmlsaDJHM1pJeFJVSFpNajZFTkhBZnJMNmZlSGU3cERw?=
 =?utf-8?Q?79bwKe5AKs4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjVoVlJuVkZKMmxaa3UvRlNBeE1FMXJuTExjVWFYZG80NlpWWndlNHpDZnRE?=
 =?utf-8?B?cyswNVRoWktCT3REWU41dGVhQ21wWWVOcFZLcEw1NHdjZFFjU1FRZGljL3Jt?=
 =?utf-8?B?SHdWNDhqUUgwTzQ3T0hCTi9JNXFwbkl3UFgrU2VrYWZlQTJ6ZGVDTXBoYzRT?=
 =?utf-8?B?bUhyVldSZlp5YVhQbHV5SUp0LzhxNkZ1WVlWMEs0dG4xdnMvUnBrcmtuOFM1?=
 =?utf-8?B?UkEwbUdxRTVHcCtvS2xFS2JmL1JONkNUQUNsM0ovQXc3MDhCaHJaV29TeHIx?=
 =?utf-8?B?dDlGWEF3NG83ZXJ4TmxWRlgxOXdlRkFSNHpjLzBTcmFJb2JxdnVSUWI0eDZq?=
 =?utf-8?B?MHQ4c0ZOZ0QzRlVKSFpSekxQbzFJamJXWUdXdmhNVzZNMjUyRDhhMFNXK0FT?=
 =?utf-8?B?RzZCV2NKb296RDRtVzlvQ0xTOVdicVF2eVJPWnBiMEUzZVRVUCt1NFVNeGVm?=
 =?utf-8?B?dTdmVms3RTE4UmJ6bVZWVVR0TTg1R3R5QktvVHNjdFk1QVhpSzRTWXlSRHFK?=
 =?utf-8?B?QXZKSDRYWjJsc1hXSFl2eVo2UHVRVUIySWtNbDIvbUtWRXNLWm94TVFYUWRE?=
 =?utf-8?B?K3lrcGc3Nzk2N1k2RURuMkVOUUo5cUR6L2Q4ekFuNkVLRENvcVJYSzdDbEFv?=
 =?utf-8?B?cFpXTlZCQ2dJTmovOElyNDhVMExrcmpETlNNUTRIc25GL3pWa3FPSUNpWVJs?=
 =?utf-8?B?b295MlRheXNGUUVheGNhN0kybXBGRW94bmorcEZrbWYvZm02elYxUFpxRzZv?=
 =?utf-8?B?a25qeXpKamErK3hwdXJlRE9UZ2J4ZVdaUFdmK0VDMXpyV3o1L1VDVFUxbCs5?=
 =?utf-8?B?Q3lOYW9DYmRoMWNXb2dFa0lrSC9SdHBQMEM3dTloYnVaQm1XZ00xWEVzVXUr?=
 =?utf-8?B?ZnoxR1ZiNDFuZU1VNmF2MzIwMXQ2VFg0K2VLOGJBdHNCNUUwSkNsZ0YwMXhW?=
 =?utf-8?B?QzY0Snl0UkVVZm5GcFpzb1RCQ1RYUFdkMVZ3OGNNNnZqVTJUT2F5SWRXSUpT?=
 =?utf-8?B?blYzZHZlVUhOR3NjUFptbE9iQ2s0ZmR3bC9GWlB1TGpVK3VLUWlHUWRacEVl?=
 =?utf-8?B?dFJMTHVERDIyaGtneUxXTTFBWGNYdk5xa0JaaE8vaXBUVDVhRWRXemd0Z3M3?=
 =?utf-8?B?STlLR1cvSTVuandvamhoWG9YK2FqY0tCRWNkWlNmeUI0NlBMcTZVU2s1RFlX?=
 =?utf-8?B?TlFUcklhSVRHOWtKQzhlWGtWWFd1L2hDN2V3WVVyNGdIU3dGQnJyL0xOcWth?=
 =?utf-8?B?QzBFSUF4ckowVkpiNHpyVHBObDBKclpCdWQ5SWxNY1E1YWxrakRIeHU5Qk1s?=
 =?utf-8?B?NDZSRmVjYmpFem5hNGFQYlNuWFJRa3dLUFVVdmZRdThIeUptaGhacGpnK1hQ?=
 =?utf-8?B?VXprd2p5c0h5YnFhakV1eVRVNVppK2dqNWtvaHZYYmhUTmcyWUxXb1NOOER5?=
 =?utf-8?B?TmF1ekI1YlpKeURrcjFYUFoyZE1EUkhMR3ZmbFpkNFdzRDdiWlJmOENOUGNq?=
 =?utf-8?B?amw3RUZzOC9la1AzUjVheHVHMi9tVy9vSE9RZXJEaERiWTBXQXpxeEpDQlY1?=
 =?utf-8?B?VEpEa2hnUTBpT1o2MThHTzQrOHRaemROaXI2NEkvOGtGb1dvNVpXbjB0NUJ5?=
 =?utf-8?B?UzFoczMyWVdZNk5XWER6TmVUdzBKUXlHRU54cXZ5UDl5TU8xUkxZeS80QjFH?=
 =?utf-8?B?MWNZUW1vVFI5TERsSHhBcFJuaENIcGZmcm1KeHpJQkZtY2hCb1ZUcWRWclZQ?=
 =?utf-8?B?MmdnZFIweXhxSFpjTmpLUE9DQjhsQ3J2UWJGbkp6QmJLVHo1UFJ1bjNnRWw1?=
 =?utf-8?B?dXg5SGVBM2Y4MVFvTm93WFhBVFd0T2RjRDFBcVF3eDBpcXpvdHhwbGM1cEhq?=
 =?utf-8?B?RzhKeFpvS2dvL2s4NzBjcHVWL1g3T2dZZFZ0T05aVnBiU245T25SMVF2WFM0?=
 =?utf-8?B?eHFJc1RiTTNTUjdDNTJZbUhWTkZWU3liNUkwRDk1bDJVRzZGYkRWRnZFSWtu?=
 =?utf-8?B?dlJVM2NDTXFrL3FpbmJsa3I0Y2srWlh4eHQ4YWdnengvbzRFRlZVMGc3NC9I?=
 =?utf-8?B?UEZqUTc0WWNITldCcW9KMUtDb01TejVRVXp2VjlLZVNNb0RaZEpQcERTTVkr?=
 =?utf-8?B?Y3dNaUU4S1BINW02YXRZT3NRNjgzVEVvd045Q2dFUEFrT0hxM0NoRytwT0hl?=
 =?utf-8?Q?aL7lccDVw30GJEjkf3NdFkn3mzepGFaSpR0MMN845t2w?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d69a34c4-844e-48d7-e799-08ddebd847ba
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 17:27:10.8677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4nMlwENLwrzxlyF92OdEVoHPFSqWcIEFSLgz/bobZj7u5j4tcHDvE4js+8ko31eV0dUywAY6ZGutcuBEh++JMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3708

From: Jan Kiszka <jan.kiszka@siemens.com>

This is needed for recent kernels (6.16, maybe earlier) and compilers
(gcc-14, maybe earlier) because they perform a per-cpu address space
check. So far, only sparse should have found this.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/clock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/cobalt/kernel/clock.h b/include/cobalt/kernel/clock.h
index 2f7b714046..63841b96ca 100644
--- a/include/cobalt/kernel/clock.h
+++ b/include/cobalt/kernel/clock.h
@@ -78,7 +78,7 @@ struct xnclock {
 #endif
 	} ops;
 	/* Private section. */
-	struct xntimerdata *timerdata;
+	struct xntimerdata __percpu *timerdata;
 	int id;
 #ifdef CONFIG_SMP
 	/** Possible CPU affinity of clock beat. */
-- 
2.43.0
