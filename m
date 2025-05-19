Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2040.outbound.protection.outlook.com [40.107.249.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F32D515
	for <xenomai@lists.linux.dev>; Mon, 19 May 2025 06:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747637092; cv=fail; b=nPmceLa3riwM8aBcC6wG+1wycZsVb5pl6d1JRWDVLn4kxvnX0vS7rGugAbCwIjFNHPu4nXZonDgPD90OFAC/AOCuHYOLQkiiavXcJhqpVPU2Tl4KCxYTujLcJJckwL7r8rr+M1Ubm2qp+FdjpHyk+4ozNibto8ZNPp5CQR9WA3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747637092; c=relaxed/simple;
	bh=Ofg31EyqhuIk1p9EZ+DEH/7EiPa93J59oYgvQlmVmMc=;
	h=Message-ID:Date:From:To:Subject:Cc:Content-Type:MIME-Version; b=hxiXgFxHh+UOBPgmRXNXYpXWlvCDZOucS8nhg4iDOMaBnCGd6nJ0shIsGOyUkRocpqOBNGS2toikbtdiNzD+bBiy3rm57GaAmqEHj7J6u3fh9YFToMb+91PFNGqxzjCJHPHx1GV1UNUuTrGwvlD7UQX3Sc+cqNXoZQcLuFBs/eM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=K3wAnS3C; arc=fail smtp.client-ip=40.107.249.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="K3wAnS3C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zhkzr1EFAG5F3HsOV+YRhErK69aWMmKhI3HusIZDHPhWfl3c72kx8oue+tn2xrlzxTTvt29Wf9+OfH1bv5jx/1IDfVuuRCYYhbtmNvO5d7T4jRPsPAI/Yasv/PQ0lhSSNbRblerKV9pRsWyqeq44v09/IIy6Iq1pXrmtSaH0wxABWtcl8ByYtH5Xc2OaRsNDKl8wXHB4BtcfD+vzhPoB1bZUYnrxk0d5MO8MUWT4MRNtGpyQiph7IpiOOqFXMl080m1wZYN3pNeJn1/GApakUo5QGJg7mTOexkinQSwFCpxZNTATeNC4LUoblRsF2K9kkQ5mi72gz7WHz6t5i4Kbow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GPrRhHlw3zRe2WILHxAz3YSYfBPblv+Vq8UxIZkBZY=;
 b=k5SLCj6UuJWzrFtHrooYEK5dNwLAFro9IKkCK1GYspA+BtyYZk9JnvEHoN6si7aUK8PQDp5W2JrojvZsLsO0jhzT9UO+RjbAc4n0qFvgCM5tA5+9K9WmiP4oOUjXpJWy9QKTUCxeH3OA3QtgV4Keq/8CHx1pwKEDTBG5/qe4sdN4WaVcfRt0W2rEcGPMqKwgyRWlAtnlzs0cEpUBo3SUPQuI/KLh1zO9sTg/YjkyKET7FMDUowQF3Lt7e6OU3C2k3mrsEB9bIT3vIuf3nON9zUgyAFuawl19Fw6cFpagEEK5noOwxP9VzntnB5BoJWX0V5CjPEOlC59i8c80QmjP0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GPrRhHlw3zRe2WILHxAz3YSYfBPblv+Vq8UxIZkBZY=;
 b=K3wAnS3CLCBEHGipWIJfKFcqtvuHWxS1/4T5b3RTpd1Gmy5DUnQQ6BNRMk32Uv7Vq7VCqt0a3wnT4ZBMHGT7DBlkOnIUKLVBCAbiAuHL6rSyDnTvu+K3B+ZsasmAsM1qV4rZKXlr9hGh7/pdP58XmNyzOtgRg1/EARVJkVeO579/LEf4W7ibXKrEpavClYgWcaBQSOWMH6Fycts3BZQlljwAzR3yX90lNu2LkuR/184ZLU26iLIxgE9eRGGj7PLVP0iQMhRmBlW7C7jjDmAxi+MdYP0U0SWwCNKajL1t8WUXY2rlqx8P0oLEX2Jae/E+zs/re4kCSyMTQDmX9LOBQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5798.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:505::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Mon, 19 May
 2025 06:44:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 06:44:47 +0000
Message-ID: <dcc04a18-af0b-4661-9a2b-f07674f2239c@siemens.com>
Date: Mon, 19 May 2025 08:44:45 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] lib/cobalt: Unbreak sigshadow installation for statically
 linked applications
Content-Language: en-US
Cc: Haiyang He <aspirestro@163.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0278.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5798:EE_
X-MS-Office365-Filtering-Correlation-Id: 4774ad8b-c41a-4e9f-8388-08dd96a0a569
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?STRpZmFZR0E0VWs5NVo1dU9lTDV2bWo4R2NJS25rZjU0YlRMN1h1V242VTlO?=
 =?utf-8?B?V2Q5KzFIejFXdit5cEk1OTNhZnF5My9uT0lSanh2NExtK0dBM0U1bThBa1oy?=
 =?utf-8?B?NGROZU1yR0l3eUdSd1ZPYUJMVmF4VmRtR1JJV1lIT0lLMS9xSkdEazI3TmhW?=
 =?utf-8?B?bGNsc0U3ckRLSStBdkZvK0RlRmw1QytCWm9BOXhrcXVtMlJXRXVaK0lNV0oy?=
 =?utf-8?B?OFQraVg3Nmk2M3NpZ3FtcUFqVWVrZ1FlY2lqZjNNMnFMQ0xrbG5UWkZ0a2Rz?=
 =?utf-8?B?SStTb3ZyL2dxSXJuaWV2Nm83Yk5wVC9qMFdPNVo2S2NyWE5aNllOeXJ3UGlu?=
 =?utf-8?B?WUE3ZGM1Lzg1cnUydCt5UWZ0UTFQNW85dmVDZ0FpU2EveVNtRlB5Q3QyMXBT?=
 =?utf-8?B?ZnVwbUxmS2ZNenZQbUhieEliOGZVeDA3SzMyaGo3NzVXTHFHVXRhSk14UWNo?=
 =?utf-8?B?ekxBWEU2Uy9zL0NSelR2ckpRa3dYeldUdmdWdytIbHBPVUhHUzVVQkpCaUht?=
 =?utf-8?B?UE9kM0cvODdtTSsrYy9Uc2V3M1loNVNLOEdrSVFmMEJpOC9SVmV0U2wva3JO?=
 =?utf-8?B?b2ZQMFZ1VVAvbTU1ZnFLd1p4NHZNVlVLV1M5M3Zad2k3Z0UzUEJnL1FJUE5U?=
 =?utf-8?B?TzE4bTVDdk4rNTV5MlFueDZXZFFwbnlHZlg3RU5ZWWp3bEdZREFaV1hLbm4r?=
 =?utf-8?B?WmRtRFJiZVdXcjFSekN5cDBRNll0cVEzV2VYc0ZjVXl1eWlLZVMzcXhDVWVB?=
 =?utf-8?B?NExsNElCcnNDcGZGTEhQWEJwUzVoNyt3R2Q0S3hvY2F6SVlpb2ZVS2E4VEtv?=
 =?utf-8?B?cHM1QUlKclJ2dkQwM0preXRqaFl1aThkZGRTanhEME40SWVhNGJ4NE02NEdl?=
 =?utf-8?B?QndPMzdUUWRxeXdkdHFROU1BOThzNGdjSW1IQUZjVU1MeWVhNGhlSU1tQ3Bp?=
 =?utf-8?B?NDRkOUtURG9iNE5HeWRwazJjRyt6akMvOHJ2bjVFckhRc0xabjJKYmRGSE53?=
 =?utf-8?B?Ym16cktXVXIvRnIwdDZQM2JJU3FuQmhQT1R6amY2bWlVMWk2d25YUTFCa0Vw?=
 =?utf-8?B?TXdvVmpzYkwwQWhnYnNLU21YZ0RMOG1WeTVkVnhMWi9zMEhRYzFyOTRvSjgr?=
 =?utf-8?B?SVkxb0p1UDRpTWpZRXBXdUJMRnorQy9VOElBQzUzcWNSUGRlbTBvTHNjd3p6?=
 =?utf-8?B?M0IzSkRLRXhaRjFJKzAzL2VwTWsxK05TWVhMMXlYNkJzcWRPWmp2d1ZiU09I?=
 =?utf-8?B?bXNLaHhNKzRuR1p4UFVhYmlaQzUreTBYT2craFp2YlNnWUFIYVdyVS9odm5E?=
 =?utf-8?B?MDg3TXcxUm56MExpV2N1TnZ4anJIZ2pncDNncHhjOW9qODdMZndXOHJMekNn?=
 =?utf-8?B?cUI1aDNzUi8rSVYrWm9kV00rMCttd1FzTC9qcFZKTEVocFU1MllkSkw1MGpE?=
 =?utf-8?B?cTl4Y09CdVFMYy85cnBINVlhR2xxcDN0SlY4M1pQeHhjMGJieVk1SHNVV3Vn?=
 =?utf-8?B?Z0MrUS9GZEdCaHZoQUVTRy9JaFdGYWVjOWgzcFVadTZWamljU1Flbi8wWG9u?=
 =?utf-8?B?M2lFUEUwaEFSck5OQWl2STZ6UXFrcUpFSkxSaDhJZHE5TUZQV3RPUHNqQWRy?=
 =?utf-8?B?dTNkdHZlL0NoRGxMZ2hiR2syajZvWFNseTJBRHl5M294UXFnOVZucTZzNGp5?=
 =?utf-8?B?ODVPY3dIVCtmYkQ4bkNwaVplb2tjZTNZc2lWU2UwRHo4ZzlvNjkrNm9ndy9Y?=
 =?utf-8?B?TWVzeXUwR0FvRDVvM3VyUEcva3VscW45VFI4Y1c5NEhPRjlrS3ovMGJ6V3ds?=
 =?utf-8?B?UzRYQWVWRDFhWlVqMGROOXkwSTlIMzlnWGNBZGE0RVVPejA2RW9CbU82UGpW?=
 =?utf-8?B?ME9ueHBHeUxFWFZDM0ZMdWpoMnN0NEZkR1hDVXRoOGRXY0tHK21tam9iTHp6?=
 =?utf-8?Q?ZVlVdxgSOG0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHdIUjFIdldrbC81MC85KzhHdFNoNlhLRmdmYWM4RW9Zb1F4VVlWcjU1VzNw?=
 =?utf-8?B?d3l3ZStrb1BqNGpnYUk3TUZRUXFWbDJoaG0xSDFCV3VMMkYzeEpTVGsrQldC?=
 =?utf-8?B?bzM5MDRmaTRuZ2V4d0RzKzh2WnM1UXh3b2psa0J2ejVOSmt2VzBuc2ttUGN5?=
 =?utf-8?B?MTdtWERyeWthRTNNSzRDK0dCa05GWm52ZFA5TU1EcU13WmhCb0YrRGhTRUND?=
 =?utf-8?B?WXJuK2pGeWZxYzNyUmNmd3poYkVqa0JBQ0o4V2VlUlljbk1kZi9lOE9GcDZM?=
 =?utf-8?B?L25BODlvbGp5ZVBPejRlSnh2UkxTZklGRk8yUWF5em52cFJuaUNXNnpVbXQ3?=
 =?utf-8?B?QVMyUWNRdWpJTlZvVWxNOTRXMmNqckRSY3V4NHFITEVuaFBJOGphVThnTjFs?=
 =?utf-8?B?c25aRUd3ZTBGeTROaG5BdTBUS1cwa2hreFMxTC9OcG90dVFob3NSOG45MW1O?=
 =?utf-8?B?ai9OSVFHb2dadmxKMjUrdk1VdmZxeEc2bXgwQ0dmNnNLa1JDblNtb1hiaUpK?=
 =?utf-8?B?UjNpMUI5WDdoWTBpSDF5bjlvK0MyUVcvemM1NE5STnpjcjlJcXFEWWtSM1RP?=
 =?utf-8?B?RzZHS0ZQaXllSlozZ2Z2eE82KzJwVldJdlMvVjZzN3hoS2hWUGhkTXVVcHJt?=
 =?utf-8?B?cmxDNE16OVV0ZmsvZ21wR3dGQktyc1BKMEtOWG9rV0NpVEpzeHVRL0ZaRU1o?=
 =?utf-8?B?aXJ0bG1BM09jeEFZTTh6eUhTc0xYQ3U2cFdwUGl5eTcrWDUvNVBvOS9tTlRt?=
 =?utf-8?B?MGJyaWFaUGN3UVcwQjc3L01PUDkzV1dNem9MSVh2a0FUdUVRZWFLaHJKbXc0?=
 =?utf-8?B?ZlY0VmJ0eGlobll6Y3pJY2ZiQzRrR0FwcEc0YThDWEsrWkRnSno5Wk4wZER2?=
 =?utf-8?B?WFFoNFVwQ0dmZkRVbTJOV3FQTFFzdFJoVGV1cFBrejByVG5qUmtpeEcxKzBo?=
 =?utf-8?B?WjRhVkdSUm1nWW4xYWlXa0tPRW05aG1INmpCSVpjbDhVU0Q1RnRjSFE4MXdO?=
 =?utf-8?B?OWJ2a3FiMlZzdnpENU5ycldraEhqT1U1RjFhd21qUFE4bklIeFJEZWxTVXVk?=
 =?utf-8?B?WFhmTjZsa01pTlRPNytkVDZnb24ydVVoN0hhQzVxK1NuQTFNbkhVUHVGRzNS?=
 =?utf-8?B?RlMxazI5cWVIWk55cEhRN0UwbDRGOVRrNlhyZm1ISHAxR1V3N3RZeUUvc0Mx?=
 =?utf-8?B?OHY5ZjVHQnRaN3BzTjBFZUJJM2ZGL3JlNDM0WURqR0J1TkpzWjdUREQyRnVB?=
 =?utf-8?B?N1JIZzBjazRTTXk2K0ZlUmk2NVprVkFvQnE0aVBKWDREcFowWTRxVEczTmh5?=
 =?utf-8?B?VXpkd0laYTR3WllGYjRjZW9Sc3VTdVZyWWJ3Z2IvNk1NZDB6L0JyWE5XeFE4?=
 =?utf-8?B?d0FQbTFPWkU3WFI5RStvUXFrMi9MZ1FyWkJDMk5GU1VxQnVKY3VVNC9JUm5p?=
 =?utf-8?B?YXRNWVMyVFlLNWl2TVo2b21Vc2tmbHNsaHhweVFUYzRpYnZrZm1sUlcyMTJi?=
 =?utf-8?B?MGZCVzcrWEhQVllITjFIU1VlbzZFSVdOdWZIWXNUUzVZTi9FRHFzTEhBWkRi?=
 =?utf-8?B?eWhYZ1dicm1pNkdmcStoWDdPN2F4WVFiMkFhYis4b2xybFVWUjJyOTUyNjVu?=
 =?utf-8?B?ZW9JS1ZUNjB4SmtCS1VKd2NOR1pmYmt4SWZ3dWxzRjlqeUR3bTlmNkwveVZ1?=
 =?utf-8?B?UWZIZjVsNnFXemhQd0ZTUVhlbk9CeUpubGdHandHalNzclZ6NzdENkVSSy9y?=
 =?utf-8?B?SEthb2p2cmM2NmhJT0JySFppZ0FneXN5U0dxRERYL1hGaGw3NjI5ajZmMEpr?=
 =?utf-8?B?bEJrQi9jbU03UHY3SnpuZytUNFk2NXFZZnhMbE9OVWZJUFZ2dVpxdFNBYS9P?=
 =?utf-8?B?aFdTL1dLcnlSMWJLN2FqZXdRODcxUHVkZGtvMjNJeFplWHlJdjArdDhneTNY?=
 =?utf-8?B?S3Iva05jTmFlaHdVdHVmZHNTTGRVbDEvWnV6T0w0SVV6VUdENWpVZWlZNmdY?=
 =?utf-8?B?bmpqdCtyb0VRVVlsdGpzbHd3c0RjRnFoMmhvaVBSV0lyWENwMjZVM1JZdkFO?=
 =?utf-8?B?Wlk4QkFCbDVIZGNhblVhTG9JbHl5QUpjcU0reFNXK3g2QytiYk5IaEsvY3Fm?=
 =?utf-8?Q?EHhJHamIbiVrexNtncbi3QVMv?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4774ad8b-c41a-4e9f-8388-08dd96a0a569
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 06:44:47.2374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BILYQG5knE6YVgpJPpwJTKWEaye4EKnq3oRXgmzcpev1/URElfjEBIzcIg88YAyKphIzOAe11ThJvcIXLhwaOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5798

From: Jan Kiszka <jan.kiszka@siemens.com>

When statically linking, we do not have a .eh_frame_hdr section. If we
then call backtrace before frame_dummy was invoked during late
constructions, we abort. Address that by moving the backtrace warm-up
call into a separate constructor that is armed earlier by
install_sigshadow, or call it later directly if install_sigshadow is
running after the construction phase.

Reported-by: Haiyang He <aspirestro@163.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 lib/cobalt/sigshadow.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/lib/cobalt/sigshadow.c b/lib/cobalt/sigshadow.c
index 092cadb08a..abdb6b5491 100644
--- a/lib/cobalt/sigshadow.c
+++ b/lib/cobalt/sigshadow.c
@@ -33,6 +33,9 @@ static inline int backtrace(void **buffer, int size)
 
 static struct sigaction sigshadow_action_orig;
 
+static bool request_backtrace_init;
+static bool past_constructors;
+
 /*
  * The following handler is part of the inner user-interface: should
  * remain extern.
@@ -96,19 +99,35 @@ static void sigshadow_handler(int sig, siginfo_t *si, void *ctxt)
 	pthread_sigmask(SIG_SETMASK, &saved_sigset, NULL);
 }
 
-static void install_sigshadow(void)
+/*
+ * Kickstart backtrace() so that it may call malloc() from a safe context right
+ * now, not later on from the sigshadow handler.
+ *
+ * We can only trigger this after main() started or very late during
+ * construction because, when statically linked, frame_dummy in ctrstuff must
+ * have run already.
+ */
+static void __attribute__((constructor)) trigger_backtrace(void)
 {
 	void *dummy[SIGSHADOW_BACKTRACE_DEPTH];
+
+	if (request_backtrace_init)
+		backtrace(dummy, SIGSHADOW_BACKTRACE_DEPTH);
+
+	past_constructors = true;
+	/* ensure visibility of past_constructors after init phase */
+	smp_mb();
+}
+
+static void install_sigshadow(void)
+{
 	struct sigaction new_sigshadow_action;
 	sigset_t saved_sigset;
 	sigset_t mask_sigset;
 
-	/*
-	 * Kickstart backtrace() so that it may call malloc() from a
-	 * safe context right now, not later on from the sigshadow
-	 * handler.
-	 */
-	backtrace(dummy, SIGSHADOW_BACKTRACE_DEPTH);
+	request_backtrace_init = true;
+	if (past_constructors)
+		trigger_backtrace();
 
 	sigemptyset(&mask_sigset);
 	sigaddset(&mask_sigset, SIGSHADOW);
-- 
2.43.0
