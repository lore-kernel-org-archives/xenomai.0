Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2060.outbound.protection.outlook.com [40.107.21.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97CB1C68F
	for <xenomai@lists.linux.dev>; Mon,  8 Jul 2024 07:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720423807; cv=fail; b=q0a02x7Ev4v9G9ruHoFO4jGF5ksiyy05tj8bCBwYCtASh8dep2LRQx+thkq5mgy8Ft0QiQ6+z8/VjOgBaW3laLKVWB0jEcQjdM49IDPYLRjxI7OrSnl5ILKtgAY5F1UpxEqThJHCky6zr6T8w8TfDzM/tpy3/IWzoTsQDB6RWkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720423807; c=relaxed/simple;
	bh=dGWstJ/R7dIxWMcp8msA7MK+Fh7uCX+5U1G45X4m+gA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sDVbAuFFe1nubDgBj266v9sforBOjePgvm5roUicEv6d3WTcuaGRSAJwbRcHYl2IxH+wH7b8QYd3AnxVDXZLT+qP+U+UrJhVnmA/ca8IXfeDX9/0vWROl1SxTLILS7I1et7GFkohp3KlZbWnt813zsbi1oMXtKeanxtanwIpak4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=I704Ulwu; arc=fail smtp.client-ip=40.107.21.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="I704Ulwu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2aIcjUHP14gsyURixmPykQaZ1TSXaJCt9at+l36bVwg4SCbAKBPiSG0S/srkjx8TRQpNRjl7uvcDxm1FwReloG8APcCpeqgHR2bDwQNNDkXSQRL++Pu/RqEkqe5zWX8MnHQy4kRV6+KOwp/sQIpPrYe5t1jtDEMLHA5tzjT/zETfZD7OjqMJw74XMGWJcRFT6AAW2I3nvqYj37soSd7xTqaLPtGJdsyqXB6o3pALOYEZoeGfeYFBbyqZHwE3MuhjJmTBq8T7r/+c455HbmU+EbM8IGYnYBDUQj+AZL3auBFaPtx6EK5LU4uT3xnG12Ec2tkoKKICMPuXzDgFgqYxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2N6sOWroMDIZgQiucHKQiL+zLcrBnL5tmwNRv47kOcw=;
 b=UcSysUsrxyt8gVCZAZx4viDx+06RK0GnhVw16A7E2wku4ej2JKa3qcy7P2qEYfUy4U8fgiFzOKDxEC8D9hsm2tQ8ycqntoDF7z3Zp/xU3s5NY8YXCdmm3GFH38AYxZQPuuzbQYxmyuNN6ondO86/grKjYNWp2xjV/joQaTeHrni+cso+yACqh4YmrUCx87X8ehxZzGnT6L89icy9gbidhgBI/46dy9ibtgAGvIBR1IkEP6mcOsa8HC5t3OqoAk19JRMzv+IPIPX5zvlyeCFHz/s+Q1YZ042F9QbfrgRJJIyVgmo69FjgSoG8lx5bEFiSN/D5qaDBqx3XK1UUjePYig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2N6sOWroMDIZgQiucHKQiL+zLcrBnL5tmwNRv47kOcw=;
 b=I704UlwuhWWCZzXTzXy0r3qAgVfIAqYkJy/W+svkIb3cTChlsMBc5bIBrw4jwutunNGYZr6XDend95SX/CRU3vVhKUGQ07nmdGWyjG7mdehgTNCGDoQ7xpyxTMnaZBQmCVUNAHDxb1zz8CkexgqDc2/BatfRJB2DmqrDaYIKHUxTeqWusGMaIrJJ8Z1G8WNWzaSHqdLLwojLCbE+/Rx8j0i7UWq0YK2OiB2eMoi0Cc6LDthR9qUMkIkvt9zuGCESzvqCvrN5Uo6B0M0lE4o0xmkv52MQtTcbUhJ5ReL/y78mlqBPtyf7ai51JO/xwYGcGXgKtP+MgX7HjqCmLLTi+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3588.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Mon, 8 Jul
 2024 07:30:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 07:30:01 +0000
Message-ID: <92566754-82f2-4f09-a870-4d0ce4f68648@siemens.com>
Date: Mon, 8 Jul 2024 09:29:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: KernelOops xenomai3
To: =?UTF-8?B?TmluZ193ZWko6Z+m5a6BKQ==?= <Ning_wei@sgssemi.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <3f2cdc0ae2804139b7d7ff4112466647@sgssemi.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <3f2cdc0ae2804139b7d7ff4112466647@sgssemi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0181.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3588:EE_
X-MS-Office365-Filtering-Correlation-Id: e5864e40-234c-47e2-6e23-08dc9f1fc74e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VFJMbzlaUzkvazNzeDRSai9NbVhkRnpVRmloaE8vYkFWK04xbVI1RFY1UGVh?=
 =?utf-8?B?dG9GREhoL28rY3NiWnBvUHBZd3dqWjRZclFYRUVMeEg1RGNqRjJacnJLM2VH?=
 =?utf-8?B?SHZvSWZVa011REd3VFU0cFkwWDJyNm51MkhjdHdhdEd0Rk9XZmErMjgwQ1hM?=
 =?utf-8?B?UDFKQXdUMGc1SnZiZGdMTFRQR2Y4VmlrekRkTHFsOVQ3dEFZTW95OG0wcVZR?=
 =?utf-8?B?aHJOa1ZjZmg5VVpUd2hXM1A2VzJ3TTd6OGNqVXd4dzdlSDNIYU85eXp6T1ZR?=
 =?utf-8?B?NW1DWTU5bUFkWDU2YU9RK1BJdG9MK3BHVHhneU5yZy85QW8yTGVWRmpFYWo3?=
 =?utf-8?B?a2xscEd6MVlJWjJDdzNKSnZLcFZCOUVhSnB0ZGVPVlpIOGIwK1BrWEJOTnV0?=
 =?utf-8?B?UHI0UHoxVmdjV2xXSXUrbWtzM0s3d0JGMXUxYnZqZ2hzMHNzSGYrbkpWNWI0?=
 =?utf-8?B?VHduWFFLd3lYUnZlMFNMOVdYbEo2cGxZWjN1Mmp3V2Y4eVVhUWNGNjVKQmFK?=
 =?utf-8?B?NitmY3ViTTJHbUdVNEFQd2w1N0w5dnB6VWpEeHp1QjVBT2FqVEdacmVvK0c5?=
 =?utf-8?B?ck5pU1dMWTJ2ZFp3elpZblpFKy9IeGV4c3JjRnE3Qlh3L2xNRm9xWXY3Q25l?=
 =?utf-8?B?NDZCaHB3MCtJalRPQi81ZG5LSjk5T014S3BZbWVGWXN0b2l5UFQzL3BpTURS?=
 =?utf-8?B?eDFNaXhzWVlXNmw0amdqQjV1a3I4NlRaaml0RkVQNC9KKzRyaVZpcXFwOVpX?=
 =?utf-8?B?Uy9jZ3lTK3pJVTQ5R3pDdm12OEhrT0RkRXV1SU92WnhWbVBJbTRJZmJFeWpQ?=
 =?utf-8?B?bk1WNEFkdm0yZjIvL3RpN1BRd2E2dGp3TFRReFVFVUcrUFNnMG1neDFsaGc1?=
 =?utf-8?B?QVJBK1BzTFpHdkhUQ3JqaUhrUWNrNmtnaDlQQUhSMUxvb1NCVTEzYTRrU0hv?=
 =?utf-8?B?TU96QkQ5QlJzYVoxdHkxYUJtVEFVcFE3YndZT1J5SktlbTdOY0N1bFQ1S3oz?=
 =?utf-8?B?RjZQbnFEOG5uaENJOGhuL0VtT0tRUWlSSUVxUGdJV05sZURFOE5SNk56TFVr?=
 =?utf-8?B?Y21ZME1QSTJwc3N4UUdGQm1ScUs3OWMwM09BVlhKVWtWdUdpbjZPUG9BL1lB?=
 =?utf-8?B?aUlPcXVJcjFnZ09KZksvOFRWbWhVeG4rL3RIajk2aWp1NTlNT2V3dGhEbXFX?=
 =?utf-8?B?alJVUjZ1SWpsd1VTeXVXaFkyZFIyYi84T0d4L0ZKYmhHaExpMnVwVy9IY2hp?=
 =?utf-8?B?NnB6bTdoeHQ4b1g1NVdHM0h1QW9rOWpNMkd3bTR1ZjU2RU1LS0N6WnMzenVK?=
 =?utf-8?B?TjBDTG5FQ0c0T0tFc2NEVDJNYldrbXNmMTNQbW5DY3JiUzM5VzVrbk9NTW4w?=
 =?utf-8?B?TzhWZDJCWHFWTmltT1lWNldtV3dtOXFnbHNQK3JqRmV5em9XTTllN01qQXFU?=
 =?utf-8?B?ZDhXaUppY2pnK2Y1SXV4Z2lsc2kzSjRRM0pETFZUelBhMStVK2F1LytKZzNX?=
 =?utf-8?B?N2VrdURUWVVOWEFqRHRIZjFyeTR4YUlSNGpaRDFrTjE0eklMVENaT1hGZVVl?=
 =?utf-8?B?cVdvMjJ1MnRxdjRDOEVycXNySXRQV0JtcEFtNXNiWnlTZ3lQNVFlYmtPSURq?=
 =?utf-8?B?c2ZvMlNvdWFxTFlYU0hhRzJDeVJTSmZvOVBsYU9sOHpLUFo0SGFSNGRDRmlj?=
 =?utf-8?B?ZnJsUml5bDhBcVhMQXZvanE2ZFFMc3VhQndXWVNrUnFTdGpLM0RzVm1KMmlk?=
 =?utf-8?B?cHppVytvWmZVZnB3b09GZ1AreCtKYnQ5TnpzSnVPYjB0ZkJsbXRGNnlUTUV5?=
 =?utf-8?B?eVVDcUZldXVaQld0WGNJUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEJwRGpHVFhoaExDNDdSZUVNSGc4S2wydGZHbDF2SUowdkoxYzNIN0FNWi9o?=
 =?utf-8?B?M1BObUVEVmRmT2FuR2RZaThpK1V3Z0xCaVBqbCtVWVpvTFNERWNwcnNhTjhU?=
 =?utf-8?B?T1V1eUdmMlozOUVZcVlUSk1kbGMvSUloTlNabDV6cDRTVzFNSWoyV0xwNEhE?=
 =?utf-8?B?Y0JJQ0d3Q0NzUE55OHl1Uit6dWpFZUdaQUtEN1Z5eUZMamVMSENYcmZWYVpv?=
 =?utf-8?B?MFNGVTVGTUNOTVU0Nno4c0s2OENQdHNocTdCYko0MU9jSjVycS95RmdzVStk?=
 =?utf-8?B?MStaYWVpM3d5L2U3WTJKY3VaMGpPcGtwcGg2OHplTG5JNStsbjFVMkRsUFJP?=
 =?utf-8?B?TnRJKzgrMGtRQTFiYjlnYWI2cTcrOWF0TGlPOCtCVkpNYUhCYVg5ZWpidlpq?=
 =?utf-8?B?WGNxUjRDWDlYZ0RMRFNPMlJhN2VUdnMvUmw0WjM0aWNSbmhZekFCdXZIVG1M?=
 =?utf-8?B?ZGRvdHlXN1lJZnpsNXIyamVadThOR3JXV3lJUFo2MVNWRTJETnJub3R2aUVs?=
 =?utf-8?B?RnRxKzdKVHhCdms5MllVMGZvYmdIWWRrTGR3NkR1bE5lamRDOC9tSlU2U1dZ?=
 =?utf-8?B?ekZnL1JEQVpCbVh4QzIxYUxJMlFWMjJvMjNOZGxGSUU1WCtvTURUR1RHUkwr?=
 =?utf-8?B?TkxNTWdoYnpRRXdsZkNCeHdiSkp0VElueXdxa0lXcWt2SG45K3ZZTnF6Uy94?=
 =?utf-8?B?VFdhUmF0Y3dmMXRDL3hRNnJEeWowQ0VYczlhY3Zpb0NsbUU0K0FmYTFtTTRp?=
 =?utf-8?B?ZFlEQmVTVnI2MHI0bmFSUzRRbWVkdG9neXl3YzczelBiNTczVERZZE1EZkpr?=
 =?utf-8?B?U3BUMXVkZUFBV0lJVFFlWG9lSHd5RndxYkRETm5GaWhLQ09wUk1zR01obUY4?=
 =?utf-8?B?dHFETjVpR1JtTThDb0Npa0c4VDNsM0FJU1ZBODhKU3krYnJkSmxmc0FZbDZF?=
 =?utf-8?B?Y2I0SytaQmF4ZDdTbUtBeSswbU5ybzYzVTVyL1F6NHI1V1h6TlBFTzVqNEhU?=
 =?utf-8?B?Ny9NN0JZUkVCeVV4RE5vSlpuWVZvS3luZVZ6QTZ1L1Vmbkk4bzhlcjNmSXhr?=
 =?utf-8?B?L1ZVODI0aytvdGRMenBZQTN0NjNzdnFvQlJYMWlENUZpN3FPTkVOdytlOVQv?=
 =?utf-8?B?T083bVNGZEtnL0swY05vUTdReDlSVCtxa1RtNnRaZ2EzeGw1dm9LMzdwcWNv?=
 =?utf-8?B?N1k1NUUyak12STQ4YjRWNUF6VTBiODFpZzU3b0gzSmJMUVVTdlhaTmU2MlF5?=
 =?utf-8?B?YktaVitPN1BaQmdYbmdrbnRRVVNFa0JYMzR6KzQ4N0x2N3JITTV4SnMwb2hZ?=
 =?utf-8?B?QVpHZExwQm9BdFZqelBmanZBNzZYR1kwYzl0L1BTQWw1OVVzRDlCY1QyU25U?=
 =?utf-8?B?SjdQZVNtYnYrTlhnWTZZV2xYZjdCUHB1ZXF4WnlnSTUyZG1iWkFZTGhEOEdv?=
 =?utf-8?B?OE1oWjZBaDhrdlJ1NUlzbXB0UmFCaDk5NEI1c3VMVDdRaGVtcEhuQkZnWi9X?=
 =?utf-8?B?R2d5Skt2REJRaUVXQWJaTGlWZVc1MW1jUjZ2dTBmdVhBdUM3bGVBVVoyUlUr?=
 =?utf-8?B?TUdTSHgrcTBqZ0YxQkI2R3BRMmg2M1N4VXV3ZEJtdGFQTTVCR3dTaTZZT2FW?=
 =?utf-8?B?ZlRPb0dldkVQcTZIQWdKTnJCa0hRTlRvRkJMM1AvMjhvRFpoc0s3c2phMTFC?=
 =?utf-8?B?YVRBMExOd0RZU09uR29nSFN3UXpONy9oeXRCL0FmRkF6cmF1WWI3dHYwV3pZ?=
 =?utf-8?B?MUxYNUE1aGVNSjloN2dxNWhlYWFlaHZ5Z3p3OTh4WXI0enVhSi9VeFJnck9Z?=
 =?utf-8?B?aEhVL296Z2ZHQ1dadFRNWVMrZ0V3N0ViZHhrOS9LQXJNa1JhWWI2QXZ1VHh5?=
 =?utf-8?B?NERLZlh2MXExRVMrVWtRdXA3VW9ydUVRMmpFanZQN3E1Qm9EVGNOWDZELzNO?=
 =?utf-8?B?bENtQkpQK2JGaS9RZGJFRElrRS9qdm1UWUJvNDJuRkQxaE16UkxBR2w1NDVx?=
 =?utf-8?B?UHExT09SbmlZakZwQ1RlQnN4ZElZcHJ0SFZvOG1qNlNEZWZhZkxVNHdwSGd5?=
 =?utf-8?B?RE9tZStFdDl2ODlSQVUvaVJNWDNoQ0tCYlJBRk9XTmVFblJWRzBYWUxPSkZR?=
 =?utf-8?Q?Mo81B5mOK8g20pLe04AtSWXX8?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5864e40-234c-47e2-6e23-08dc9f1fc74e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 07:30:01.7477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CxK1s9E/MsQ/bCIJO2yc4l0aipO8VcA+O0SvqaO61x7vlwiDsJe88Nx4ndeD2C/WFhhA5hQAEhMfoGEchQq2ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3588

On 08.07.24 06:00, Ning_wei(韦宁) wrote:
> Hi all,
> 
> There are some KernelOopses when I run IgH EtherCAT master. 
> It seems the oopses did not impact the system and the process running.
> I attach the .config file.
> Could you please give me some suggestions?
> 

Sorry, but you only shared what that Ethercat stack reported, not the
actually kernel oops. Please provide the kernel log itself (what dmesg
reports).

> 
> Kernel: 5.4.102
> 

Latest release of I-pipe for that kernel is ipipe-core-5.4.255-x86-15.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

