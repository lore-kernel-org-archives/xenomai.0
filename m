Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013014.outbound.protection.outlook.com [40.107.162.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6725C224AF0
	for <xenomai@lists.linux.dev>; Thu, 29 Jan 2026 09:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769680414; cv=fail; b=lvdmjBLBR69V2CmeRXfCI2vUFEAreF77P1KUORNMVFNDo7CF4PyD0BmTZa1qClNnnTpuaLRa+nacXIhEA2pi70FtTZTVZnAAVwV4wEhJLw8aw1dsiGbnPuiYuzSHO/txx0bN/i2SEAk/lt/8/3mNMkIioXLvYKy/nqaV90rVRV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769680414; c=relaxed/simple;
	bh=Chp1caY++aJPlrM7VuGIInnTxtYuszl5RHtM8pF3Pyo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qg+tqKkE3c5XHovorYg4soLvUcZdoxH8vDUqhCRcV7GT8ib/i4A/9+OiC3i49+EfUIwD7vfylUABTidoNRebtLq9b/GQUoxDCCnlWbh7MupyyC2kLxPDBOr4o9lSmhRONKDCuXzxPJlvcuhFgc5dmdjtiNkHt+pjp5mU/J5EXxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=zD/IMKlW; arc=fail smtp.client-ip=40.107.162.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="zD/IMKlW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TzrkSm2cod4n/7y/RfD3onIg+MlFcjpB6bx9Ie7vMpLAjvVhHlUqABVjuCynbM8lVr1Oumy1J6vTJ3y7LE4dNJvOlmfTZxUNWujpsuVoaQKpo90M067rPsB4TjyveTYfaFum8mtAExks1N4c5Kdbu/Fijm4hB7dxk0KSu2NLJ9Qms46nigFOWjJt0qQbjamcUfH9+wKfG7CId/QXNS8g/HxgWeFtTosO8gxreqtnT9ISSNGzBdM8WG73X+5s26bZzOhAQU+NlZ65TEs7j8+e3H51HATwS4wBXthdA98bM+nOPAGWKC7Q3tFXws090zhLX/6K5/MpIXsgctzgqM3tVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UAg05oW/ekJcywcpgGpK6t54XEEHdHDrd1Bu0o2D24=;
 b=b1tX3sispcFTVQLN/ldzT0MVEeodZExhm5QSbvQtodohS0CArlUnCVvXu3lLvme8SvjSZeCBnj0iP6eBQLwrWvkfj3cUGiPO9xrbucBzcjPEzh7VBIJteqW2gqQgo1oRX6HAr6eAzcYRcyjyULMKHICrT7rXylsXi34CAo8sqP8MsWZnEdW6NIB3aix/WBsuFI/GzsKRzuSySAA9BCzoCW35PRfHWv6XxfI3HUem6SHWgZAJRxsILHRJwFoKCVpcEU/yW7ic5oJIgsLaLr3wugpJlGvnhPJrprU7D39PBq0ICFeDQsOTVeIl4kW9t/J2sFkFIi8QNMLG54hWsPOlLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UAg05oW/ekJcywcpgGpK6t54XEEHdHDrd1Bu0o2D24=;
 b=zD/IMKlWNFJEd5swkjhNem3nVU/dv18VyXpHmo1sL6IM+fzq0JcIrvCFCfJ7+hiJ2UqMPx7Sflv8aZT7e4g5IAbb2MEFHbuZv5NXtyZcEgbZVKkRWRAo8FdanqslAWQMzNTgYz5gfQ0EutxP3Lnh6mPkyqPmO4h/0LNMrZtdvbA5nl40/z6dHmNovMMF+P4zLLJFnu080sclIZm4ws6U9qqEJ0FD4unjjdSWmbxDDcSe/PTokSUe5S0Owl7ooyQc0LObQAXfaRvJ8ifix2DVniOMd71ITBvq42cpYJBbpq0hjGMRowD32a3ggSHJ8Te+blvjh4TwxYdbGi0LykIPAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VE1PR10MB3759.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:168::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 09:53:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 09:53:27 +0000
Message-ID: <423a423d-3379-43b4-8113-27235a19bef7@siemens.com>
Date: Thu, 29 Jan 2026 10:53:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] Allow specifying CPU affinity in rtdm_task_init()
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at
References: <20260128112821.1232-1-richard@nod.at>
 <20260128112821.1232-5-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260128112821.1232-5-richard@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0P309CA0006.EURP309.PROD.OUTLOOK.COM
 (2603:10a6:20b:28f::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VE1PR10MB3759:EE_
X-MS-Office365-Filtering-Correlation-Id: 303617c8-2c2b-4cab-3c0c-08de5f1c3fd2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWxNazVYTFR3RFlqdTJFSWQ4NzU5MjlOdU10VDhzVHVwZmR6VGh3NHd3RndT?=
 =?utf-8?B?dFRoVEtDeWpmV1JVYkNaNUprZVRSSXRwTnpyTTJ5QnF0YjBkNFZqMDJ1MFZY?=
 =?utf-8?B?UzNZTGx0ckE1bWZEOXFISjJSRnZHUVBPRWNjTHN4V2dlUkdQZW95bkh1QjVS?=
 =?utf-8?B?ZUFsaVMxYVF6R1JNTDNuRFd5MG54c0laZkdqM0RaeFNtUkNwZXozbHpSdnYr?=
 =?utf-8?B?NFVYckE3Qi9iTHQ1bW1VdHdJQnNFemZESTNMZ0J0NnJmaml0bVIwUG1pd2Nh?=
 =?utf-8?B?b3B5QzQxQlBMeC9ZY1g5T3h4ZzZZeVNUaFVrMllLb1p6d0xmZEM3L3RPbis1?=
 =?utf-8?B?RWtMbzRPWG4zV2VXKzJUM0grNWlwS2l6SklucHV5L0tSREpFUlFrb3F5YjZC?=
 =?utf-8?B?TlpWaW1leTNzNGZJdEoyTFpBeXNiWW1WOC9sL1lSMFdTZitDU2hiT05reEw1?=
 =?utf-8?B?YmtMd1VwcEUzZmJqUlRBeWtLT2NIaXJKS1p2Y2wwRFlnQkhOMTdOSUI4RDlC?=
 =?utf-8?B?NUNDNVpJdVllaVE1bmdZa295M2V2Sk5VSUJ0bHpxR2s0TG5FbDEzOFhORGZC?=
 =?utf-8?B?cXlHODNpVlpJSnJoTFd4YmNDaHBYOVlaL08vcENJOEp3T3Bya0VwS0RZOVE5?=
 =?utf-8?B?WDBqQzRvZEVzdlN0ajJETSsxZEI1cDE2d0ZDdFJKWXFkc0NrKy8vNGlZYlg4?=
 =?utf-8?B?Ky8wKzdJbXNUYldEZW5kb3R4Y2dneUtSTnRKRGVBblBFR0NyU2tkM2xvMzBY?=
 =?utf-8?B?R1hLVmVJM1lIMWZoR2liOXdXeWFnaDVCRWhVYzkwbG91R253VE9EYVhaN09K?=
 =?utf-8?B?R3pnRklFSE9ic1pqd0ZsbTg2RE1DOGF3VUg4dWhDb0tnUzBJMHRCYzB3d2lB?=
 =?utf-8?B?dG5lNlJTUXI0U1FlS2lxeU5tOHdZcHVKaXlhOG9UMzYwcjdiY0xtSEkrV1p6?=
 =?utf-8?B?Y29kVTFOWWNsa0xkTHM4Q0FjbFV1cHIzMVRPYlZ5Zm1zanZURlMza0F0RHdq?=
 =?utf-8?B?RGROcm9OQXhzdXFuR096TmVrTnZRczlqQlpOWFNLVm9kTUtnU0llb3Vna1FW?=
 =?utf-8?B?NnhtTXJXTnNDc1hhNGFNYnVGMHVVeEY2cmt1MEUwMjErZ3A2UGU1TlF3S2Qw?=
 =?utf-8?B?L3FRa3RZckdLd09vQkFWK056WVpnVjlQV2dsSklEeEJUUzBTaElhbWptQjIw?=
 =?utf-8?B?MG9LeUhmait4VURGZDZwZXVLMG5YTys5TWhBaUJqTXV2c2NscWRMb0JEVndB?=
 =?utf-8?B?bWl6aCswQzRRSTNjbkV4YUpWVXMzazV0OVZVaHJoaFpNYUJ2WitZemFjS1lJ?=
 =?utf-8?B?WjdaeGdUTndaWEY0V2FGaHNONThHbDJldDhyMTJiMGpjUTVEWnN1MjNRU2Ir?=
 =?utf-8?B?NGpwc1N4TmxyT1FCSm9KdTBsMXNIa043cVFNQnQ0NyttUzc4dlFKWExFMDMr?=
 =?utf-8?B?ME0vWExoTTc0N3NHL1YzNFpJc0FpWU93bE5BQzcxeVNSZWdjZ0dka1IvY2hR?=
 =?utf-8?B?Zm5HdnpIeHdYdTZYNXpYbGU4S0lVc2QrWVd4TEhacVV2eVRqRlR2Q2MvbVZv?=
 =?utf-8?B?NU9VUTZJSUY5YnRHakIrUzFITTYzMFE1MHpUeE9WMU1tNk9tZkx0VXd6TEc2?=
 =?utf-8?B?bXI1SmhLRmJ1UVdKUk5RSm5Ec3diNGpsSHpQOW9MTjBDMFlTTUFRVDJkN01N?=
 =?utf-8?B?UEpFN0hFVC83OFB1MUVGTTJidyt6VEVSTmpiWmFTSEpCUXV3WC9HU29SUzFv?=
 =?utf-8?B?dGQxank0MGJEeVVYZ01lZ0RwaC9GR0tlbmE5VUFiSEdXQjMzdlUwZkpyL0Ji?=
 =?utf-8?B?cGtRUW5nWTBNWnV3TVZwOTdxdjdrOEljYnYxYUNIYzRiVGtKRU45OHZpMk90?=
 =?utf-8?B?YVpEZWxlWnRtdlpyVU5OSFdrZlMwSytzWmtwaFlSSWJIcGtqQlNkdGhXRWlV?=
 =?utf-8?B?ei9USjJtdGJhTEs4T1VEWG53K2xrWDZDWHpjWlhHWW56SEpRUzIyZThTdmpn?=
 =?utf-8?B?MXd2Y0E3L0JaalB1N3BVMysyTXdTUUc4Z0FsT0czRHZ0NGxub0lsSWVHK3F2?=
 =?utf-8?B?SC9zNGNRK0s3c2tLM3B3ckVzOTE4NWlLd254NEdVcDZ0K0JENDk2dU9Yamgx?=
 =?utf-8?Q?IY9U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXV2VEFqM1EzaXlqWVBaMndSMWhlZlRLZVk4TGorOFhKcCszRWRGeCtWZDE3?=
 =?utf-8?B?SElPUW5qYnNXbk5lUXZaMHBmbVVXYzR4UkNrWTh1TGdsWWdOTUo2QW5XaFB1?=
 =?utf-8?B?R0kzSndoNzBBRWEwQ2R1QlJhbWFqV0VsKyswL1ZaNENaUG5MZnZBRG5NeE4w?=
 =?utf-8?B?ZHdvWVpFbVZXUzBTejlCc1hIa2RaR2tQYldJQ2RSV2dLTXdpQ0dUaG85cFhk?=
 =?utf-8?B?UGRFZlBwZVlFOFp6M0g1UXZQSHlESkt6VEIySzczbmNSYmNIazVjV3Nmd2I1?=
 =?utf-8?B?dDlISU9aZ1F6VklUZ2dtd1hnQ2NrcTBDRFpUZnZHRFRtRjlOcEwwcW0vWW1H?=
 =?utf-8?B?c1U5UVN2MWxQUktFUGZEcFlzZXh4MFhPMXJOc3R2M0QwQU5QZzhLQXRYVEg4?=
 =?utf-8?B?ZmdkZGFUdXYxZTZnQnF2K1BNa050VXc1WTQvQmM0UmlOd1IwL0N5NFJBVHBE?=
 =?utf-8?B?QXc2RVhvVVFIaXcyWHNFcjNLMDYwVmtadUNNcDNrTUlzM2doT0tqaElSWEFH?=
 =?utf-8?B?ZDNFMnVGdDBDYklhdEx6M0pwTWdLS2FNVXltVVFmc0VKWXQ5cEZvQkpzcFRU?=
 =?utf-8?B?WDBQM0JaVDgwS2pSUDYyKzlGaEkxV2x0aURRZ0RuSUhzZTdxZGMrZlEzMkZv?=
 =?utf-8?B?Q1pqeHdnU3BZY3VtU01LaUVPTnA1TkNoL3NaSkVMRHdLNFhiSVVSRm13aW9R?=
 =?utf-8?B?OGVLSVRmK0pVcmRYdktRNmo3Z01FVFZSVkxuN2t6VE9VZGxqWEVsVWNFTUc5?=
 =?utf-8?B?OUZuUTN5TlFkUDQwbmpjZXFVSUZVWjVTeFp2Tk0wajZySGx6NGZFdjRlNWJj?=
 =?utf-8?B?SkcwUXh1REZyMHgrbmk2Zkd2UHBCOWFGbEMrRnlzOVhsU2p4RnpwMXBOZlNw?=
 =?utf-8?B?S295TjE4ZE9GMkd1dktUSUJuQjdGRUVkQUdzQjl2TE5Ta0NuTHpxNWEwZi8x?=
 =?utf-8?B?RFFrc21iR3lFZU01UjJLWHVqa0hwMXZPaDZsYjJLOVEwV0tlZkY5bkJIeWFP?=
 =?utf-8?B?Qlh4WmJnOEYvZ1EvaXEzZjM0QUpHS3VsTFRVdzVXL3o1aVpQV01hWEVkZnQ0?=
 =?utf-8?B?QVo0bGI0MGs1OVRid01Va3dSRG1KR2FvMXBwZklNdnNvVVlvdDBCWHEwMVpr?=
 =?utf-8?B?MVJtc1RBSllQZXBZbUN2QUdKRXBxZTF1NGlFWk1hSGZ6RDBZVXNKbUVaQ3J5?=
 =?utf-8?B?c21BWnI0WWtwNXBaYzFtdnEwVlByWSt6QXhacHJpWngvczJhR3lFQWdBaCs0?=
 =?utf-8?B?SnVmZFNWYWJKazdxTUEvZEpVenYxMkp4cVZ5bS9aNmc4WjBQaUhlSlJIQnF5?=
 =?utf-8?B?cEFCbmlFdkxjZEJSM3NUc1ZJSUttajloRnFGLzZCdXhra1V0Q3o4WHc0cjNw?=
 =?utf-8?B?L3JydnVIa2VJRVdLUDdpcFF1cWZKa0k0VHB6VmhubFlhQzlVWmtzMkJvbnM4?=
 =?utf-8?B?SDZheVF3T1Vld2IyTzZOY21XbDcxUXpWNTNnbHJIcGsvU3R5RU83bUtlOHhQ?=
 =?utf-8?B?THpoMGk2M2lFZ0pCZEZZdXpkVTQvWVdLa0M5K2Y1aWpPSE1hNjhMVXErYjIw?=
 =?utf-8?B?ZnF2dkI5T1F2bEFzNXNhclpXaTZUNTRMcCtycWNyZHliblZsZXo0ZHJabGg5?=
 =?utf-8?B?K0hzNUUvTXBMQWFKRFVaMEUwSzJoU05aYWhJK090MXpBd0F1YTdTOWMzZmhi?=
 =?utf-8?B?UUhZZDdXcklSOFFnenUrYjVVdW80ZWtXOHlieUlqM0lhWHRiTTlGTTNQSll4?=
 =?utf-8?B?cTBybDVjZVE3WHBMWVIrc1BYRXdvcWRDMkhnS3FYYlVVa3FLWnMvNW1tSmlC?=
 =?utf-8?B?TGNvamFKcnl1Sks3WE56V3hkUlJUTi9iOFVGdVVWMHg4QWlRT0F4V3R5TjZR?=
 =?utf-8?B?YndZcnBBc2x2ME9WamVyTFdTdWFlQWpMZTY1VkViSXRrcTB2Z0h6Z0luOGdn?=
 =?utf-8?B?ckRLajRDZHBpMk9mYlYzK3AyQTJZWE5NZ01BcThQRTFvdXZLaFJjcXF0YmVy?=
 =?utf-8?B?d1h3T1VXVkRkOVk2dENaeGlBQmVJM1o4bnAyV0dlQ3I5N3F4NFpOcDhkVUlJ?=
 =?utf-8?B?VEtBazk5WlZGV1BBdjhxL3dwU3NtbjNRZHZpVUdtUFFCTjZYZXRYaUhuT2li?=
 =?utf-8?B?c0l5WDlINmp6SzhKMU0vRXRjRG1OQjdBTVQxekdjYTlpVlFhUWRtU2Z5WXNX?=
 =?utf-8?B?eWJtanlJMkhoQzhZcTNudzBKUjZ4SjVRcEljcy9XR0hldUdxWHovU0xjcmxs?=
 =?utf-8?B?WTYzY2JFOWhUeW5ZRkFKVkFiWFRDKzZUUVlSYnc0WXo2NDNlZFpPSXBSeGVD?=
 =?utf-8?B?WFRJZXR0eUxhOWIzWW5kdFM1bTJ3TDlUNUFINklCYU11eVhETVFtdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 303617c8-2c2b-4cab-3c0c-08de5f1c3fd2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 09:53:27.0063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lH9NtcLMGfq4VA6teOmObMaThLHjydDcFeIMc0EnjyPHFH9XiHyTRt/eDk5GO7mxCJnZzu9BXJ5k7fks17I51w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3759

On 28.01.26 12:28, Richard Weinberger wrote:
> Previously, rtdm_task_init() did not provide a way to pin a task to a
> specific CPU during initialization.
> 
> Update the function signature to accept a CPU identifier.
> Passing -1 results in the default behavior, allowing the
> scheduler to automatically select the CPU.

Please provide a telling constant for "-1" (RTDM_TASK_AFFINITY_DEFAULT
or so). Also explain what "automatic" means at this chance.

> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  include/cobalt/kernel/rtdm/driver.h                |  4 ++--
>  kernel/cobalt/rtdm/drvlib.c                        | 14 +++++++++++---
>  kernel/drivers/analogy/testing/fake.c              |  2 +-
>  kernel/drivers/autotune/autotune.c                 |  2 +-
>  kernel/drivers/net/addons/proxy.c                  |  2 +-
>  kernel/drivers/net/stack/ipv4/tcp/timerwheel.c     |  2 +-
>  kernel/drivers/net/stack/rtcfg/rtcfg_frame.c       |  2 +-
>  kernel/drivers/net/stack/rtmac/nomac/nomac_proto.c |  2 +-
>  kernel/drivers/net/stack/rtmac/tdma/tdma_module.c  |  2 +-
>  kernel/drivers/net/stack/rtnet_rtpc.c              |  2 +-
>  kernel/drivers/net/stack/stack_mgr.c               |  2 +-
>  kernel/drivers/testing/rtdmtest.c                  |  2 +-
>  kernel/drivers/testing/timerbench.c                |  2 +-
>  13 files changed, 24 insertions(+), 16 deletions(-)
> 
> diff --git a/include/cobalt/kernel/rtdm/driver.h b/include/cobalt/kernel/rtdm/driver.h
> index 3fc5573cb..dcfbccbdf 100644
> --- a/include/cobalt/kernel/rtdm/driver.h
> +++ b/include/cobalt/kernel/rtdm/driver.h
> @@ -1032,8 +1032,8 @@ typedef void (*rtdm_task_proc_t)(void *arg);
>  /** @} rtdm_task */
>  
>  int rtdm_task_init(rtdm_task_t *task, const char *name,
> -		   rtdm_task_proc_t task_proc, void *arg,
> -		   int priority, nanosecs_rel_t period);
> +		   rtdm_task_proc_t task_proc, void *arg, int priority,
> +		   nanosecs_rel_t period, int cpu);
>  int __rtdm_task_sleep(xnticks_t timeout, xntmode_t mode);
>  void rtdm_task_busy_sleep(nanosecs_rel_t delay);
>  
> diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
> index 08e113904..f68b1089c 100644
> --- a/kernel/cobalt/rtdm/drvlib.c
> +++ b/kernel/cobalt/rtdm/drvlib.c
> @@ -101,6 +101,7 @@ nanosecs_abs_t rtdm_clock_read_monotonic(void);
>   * @param[in] arg Custom argument passed to @c task_proc() on entry
>   * @param[in] priority Priority of the task, see also
>   * @ref rtdmtaskprio "Task Priority Range"
> + * @param[in] cpu preferred CPU to run on, pass -1 for auto selection
>   * @param[in] period Period in nanoseconds of a cyclic task, 0 for non-cyclic
>   * mode. Waiting for the first and subsequent periodic events is
>   * done using rtdm_task_wait_period().
> @@ -110,8 +111,8 @@ nanosecs_abs_t rtdm_clock_read_monotonic(void);
>   * @coretags{secondary-only, might-switch}
>   */
>  int rtdm_task_init(rtdm_task_t *task, const char *name,
> -		   rtdm_task_proc_t task_proc, void *arg,
> -		   int priority, nanosecs_rel_t period)
> +		   rtdm_task_proc_t task_proc, void *arg, int priority,
> +		   nanosecs_rel_t period, int cpu)
>  {
>  	union xnsched_policy_param param;
>  	struct xnthread_start_attr sattr;
> @@ -124,7 +125,14 @@ int rtdm_task_init(rtdm_task_t *task, const char *name,
>  	iattr.name = name;
>  	iattr.flags = 0;
>  	iattr.personality = &xenomai_personality;
> -	iattr.affinity = CPU_MASK_ALL;
> +
> +	if (cpu == -1) {
> +		iattr.affinity = CPU_MASK_ALL;
> +	} else {
> +		cpumask_clear(&iattr.affinity);
> +		cpumask_set_cpu(cpu, &iattr.affinity);
> +	}
> +
>  	param.rt.prio = priority;
>  
>  	err = xnthread_init(task, &iattr, &xnsched_class_rt, &param);
> diff --git a/kernel/drivers/analogy/testing/fake.c b/kernel/drivers/analogy/testing/fake.c
> index fd88ed99f..8daba1047 100644
> --- a/kernel/drivers/analogy/testing/fake.c
> +++ b/kernel/drivers/analogy/testing/fake.c
> @@ -637,7 +637,7 @@ static int test_attach(struct a4l_device *dev, a4l_lnkdesc_t *arg)
>  
>  	/* create the task */
>  	ret = rtdm_task_init(&priv->task, "Fake AI task", task_proc, dev,
> -		             RTDM_TASK_HIGHEST_PRIORITY, 0);
> +		             RTDM_TASK_HIGHEST_PRIORITY, 0, -1);
>  	if (ret)
>  		a4l_dbg(1, drv_dbg, dev, "Error creating A4L task \n");
>  
> diff --git a/kernel/drivers/autotune/autotune.c b/kernel/drivers/autotune/autotune.c
> index c11d18057..970ef6fda 100644
> --- a/kernel/drivers/autotune/autotune.c
> +++ b/kernel/drivers/autotune/autotune.c
> @@ -291,7 +291,7 @@ static int init_kthread_tuner(struct gravity_tuner *tuner)
>  
>  	return rtdm_task_init(&k_tuner->task, "autotune",
>  			      task_handler, k_tuner,
> -			      RTDM_TASK_HIGHEST_PRIORITY, 0);
> +			      RTDM_TASK_HIGHEST_PRIORITY, 0, -1);
>  }
>  
>  static void destroy_kthread_tuner(struct gravity_tuner *tuner)
> diff --git a/kernel/drivers/net/addons/proxy.c b/kernel/drivers/net/addons/proxy.c
> index c3e5ce1c9..8398e4787 100644
> --- a/kernel/drivers/net/addons/proxy.c
> +++ b/kernel/drivers/net/addons/proxy.c
> @@ -380,7 +380,7 @@ static int __init rtnetproxy_init_module(void)
>  	rtdm_event_init(&rtnetproxy_tx_event, 0);
>  	err = rtdm_task_init(&rtnetproxy_tx_task, "rtnetproxy",
>  			     rtnetproxy_tx_loop, 0, RTDM_TASK_LOWEST_PRIORITY,
> -			     0);
> +			     0, -1);
>  	if (err)
>  		goto err4;
>  
> diff --git a/kernel/drivers/net/stack/ipv4/tcp/timerwheel.c b/kernel/drivers/net/stack/ipv4/tcp/timerwheel.c
> index 209e45924..a7b259ffd 100644
> --- a/kernel/drivers/net/stack/ipv4/tcp/timerwheel.c
> +++ b/kernel/drivers/net/stack/ipv4/tcp/timerwheel.c
> @@ -205,7 +205,7 @@ int __init timerwheel_init(nanosecs_rel_t timeout, unsigned int granularity)
>  	rtdm_lock_init(&wheel.slot_lock);
>  
>  	err = rtdm_task_init(&wheel.pivot_task, "rttcp timerwheel",
> -			     timerwheel_pivot, NULL, 1, 0);
> +			     timerwheel_pivot, NULL, 1, 0, -1);
>  	if (err) {
>  		pr_err("error on pivot task initialization: %d\n", err);
>  		kfree(wheel.ring);
> diff --git a/kernel/drivers/net/stack/rtcfg/rtcfg_frame.c b/kernel/drivers/net/stack/rtcfg/rtcfg_frame.c
> index 70318ad3c..51cd2313e 100644
> --- a/kernel/drivers/net/stack/rtcfg/rtcfg_frame.c
> +++ b/kernel/drivers/net/stack/rtcfg/rtcfg_frame.c
> @@ -545,7 +545,7 @@ int __init rtcfg_init_frames(void)
>  	rtdm_event_init(&rx_event, 0);
>  
>  	ret = rtdm_task_init(&rx_task, "rtcfg-rx", rtcfg_rx_task, 0,
> -			     RTDM_TASK_LOWEST_PRIORITY, 0);
> +			     RTDM_TASK_LOWEST_PRIORITY, 0, -1);
>  	if (ret < 0) {
>  		rtdm_event_destroy(&rx_event);
>  		goto error1;
> diff --git a/kernel/drivers/net/stack/rtmac/nomac/nomac_proto.c b/kernel/drivers/net/stack/rtmac/nomac/nomac_proto.c
> index 6cdedae2f..9cf48c245 100644
> --- a/kernel/drivers/net/stack/rtmac/nomac/nomac_proto.c
> +++ b/kernel/drivers/net/stack/rtmac/nomac/nomac_proto.c
> @@ -116,7 +116,7 @@ int __init nomac_proto_init(void)
>  	rtdm_event_init(&wakeup_sem, 0);
>  
>  	ret = rtdm_task_init(&wrapper_task, "rtnet-nomac", nrt_xmit_task, 0,
> -			     RTDM_TASK_LOWEST_PRIORITY, 0);
> +			     RTDM_TASK_LOWEST_PRIORITY, 0, -1);
>  	if (ret < 0) {
>  		rtdm_event_destroy(&wakeup_sem);
>  		return ret;
> diff --git a/kernel/drivers/net/stack/rtmac/tdma/tdma_module.c b/kernel/drivers/net/stack/rtmac/tdma/tdma_module.c
> index 3c516d23b..eb65f27d6 100644
> --- a/kernel/drivers/net/stack/rtmac/tdma/tdma_module.c
> +++ b/kernel/drivers/net/stack/rtmac/tdma/tdma_module.c
> @@ -206,7 +206,7 @@ static int tdma_attach(struct rtnet_device *rtdev, void *priv)
>  		goto err_out1;
>  
>  	ret = rtdm_task_init(&tdma->worker_task, "rtnet-tdma", tdma_worker,
> -			     tdma, DEF_WORKER_PRIO, 0);
> +			     tdma, DEF_WORKER_PRIO, 0, -1);
>  	if (ret != 0)
>  		goto err_out2;
>  
> diff --git a/kernel/drivers/net/stack/rtnet_rtpc.c b/kernel/drivers/net/stack/rtnet_rtpc.c
> index 16dd84979..6d362c8d4 100644
> --- a/kernel/drivers/net/stack/rtnet_rtpc.c
> +++ b/kernel/drivers/net/stack/rtnet_rtpc.c
> @@ -240,7 +240,7 @@ int __init rtpc_init(void)
>  
>  	ret = rtdm_task_init(&dispatch_task, "rtnet-rtpc",
>  			     rtpc_dispatch_handler, 0,
> -			     RTDM_TASK_LOWEST_PRIORITY, 0);
> +			     RTDM_TASK_LOWEST_PRIORITY, 0, -1);
>  	if (ret < 0) {
>  		rtdm_event_destroy(&dispatch_event);
>  		rtdm_nrtsig_destroy(&rtpc_nrt_signal);
> diff --git a/kernel/drivers/net/stack/stack_mgr.c b/kernel/drivers/net/stack/stack_mgr.c
> index 82e8412dc..eb3e720c5 100644
> --- a/kernel/drivers/net/stack/stack_mgr.c
> +++ b/kernel/drivers/net/stack/stack_mgr.c
> @@ -249,7 +249,7 @@ int rt_stack_mgr_init(struct rtnet_mgr *mgr)
>  	rtdm_event_init(&mgr->event, 0);
>  
>  	return rtdm_task_init(&mgr->task, "rtnet-stack", rt_stack_mgr_task, mgr,
> -			      stack_mgr_prio, 0);
> +			      stack_mgr_prio, 0, -1);
>  }
>  
>  /***
> diff --git a/kernel/drivers/testing/rtdmtest.c b/kernel/drivers/testing/rtdmtest.c
> index ca29ec54b..cf5b6a927 100644
> --- a/kernel/drivers/testing/rtdmtest.c
> +++ b/kernel/drivers/testing/rtdmtest.c
> @@ -167,7 +167,7 @@ static int rtdm_actor_open(struct rtdm_fd *fd, int oflags)
>  
>  	return rtdm_task_init(&ctx->actor_task, "rtdm_actor",
>  			      actor_handler, ctx,
> -			      RTDM_TASK_LOWEST_PRIORITY, 0);
> +			      RTDM_TASK_LOWEST_PRIORITY, 0, -1);
>  }
>  
>  static void rtdm_actor_close(struct rtdm_fd *fd)
> diff --git a/kernel/drivers/testing/timerbench.c b/kernel/drivers/testing/timerbench.c
> index 75da6bfdb..a96be5331 100644
> --- a/kernel/drivers/testing/timerbench.c
> +++ b/kernel/drivers/testing/timerbench.c
> @@ -289,7 +289,7 @@ static int rt_tmbench_start(struct rtdm_fd *fd,
>  	if (config->mode == RTTST_TMBENCH_TASK) {
>  		err = rtdm_task_init(&ctx->timer_task, "timerbench",
>  				timer_task_proc, ctx,
> -				config->priority, 0);
> +				config->priority, 0, -1);
>  		if (!err)
>  			ctx->mode = RTTST_TMBENCH_TASK;
>  	} else {


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
