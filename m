Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06CE165F1B
	for <xenomai@lists.linux.dev>; Mon,  5 Aug 2024 21:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722894107; cv=fail; b=po+GkS4qBVSnOw8btcnItb20d8vkJmSnFX6uSBITKGeUxTyuft2cQQOkUDaiYVDj3N4POviLJo/ELYxTIU/0dwIWHFJzYwguNuPDSNgdYN+WmdsG/plBlvhRgXQR8WU+3fT5SFEGHjUziCJgMKVwMrkmLYy9B/oU8P2yPA7hhHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722894107; c=relaxed/simple;
	bh=cbObs1PLcY+eq29cLbLdj6g2/CZncsw039R6GL+X1dg=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fbjA5nxu8rYrMLokWDEgwZnvXLGNuqdXKD0BvLza+LJE2DbgNrL04C5Ui9cA3ZWvIErFrwdvOeHDq9dbLWrebbQqUx53c86L87pfpIOAZKRCjrNd7ae85AAvmwEAMUMvOAWiIrghyw+juiPPnvgBMOPjlRB25+dxgw6Lq7jwe2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=FJvRdRVy; arc=fail smtp.client-ip=40.107.21.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="FJvRdRVy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SdyOUfFGdmhD1D+TVJkPddT7kpRm+qfegTq2C2Bm1ZEZTU6ERyM/zf4bKj4G20GA+o558MPApLl0q1SrB+rogoUMzq+9ycXeRtr4HJEzyCFfrUtOEbovgZkgJSiyGT9R6X3c6VALYKARm7p7viUYj0RrrRAoBrpFN1hABgHt7DW3aU0B89uB12q6N3tx/rtifKZ7GI0n3KX5SdRuaagpuPlKr0YRYhRO6CIK8Wy3+0W1cNxz49Nwgv3rOzsTJq4LU3DDCpfDjPWoSgcjJ66hH/ItGL/0JsY6+m3h2HhIj7G+ZkQX22FFa+vtS3IeqUgs9mPABY0KrlSbxoK080vFTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=II4eoLcH9AdtDvOTFgcDWwV0QZfZFrUaavfiBQVXxNA=;
 b=C20aSHHo7aKJUSQ/FCYzncTjCbLKUDno24j6KJtan8ssmU83Z5yE9pOajhwfYpOqdRqZRmm0b2atSZ8PGEz/r3scDSnh6qGdKj/ZLXbKZhq5Zb20W9pZwWB+dqRkVQ3LI5/Kbel8OkOqwyBhMGnuL8KA/R1OHqJxZe/Smjk6mc/f18QsjDc4BYj8/LhsydQMXTuIdsdLsXcDlaB5khz1e1lNyZWHNstbm7e4pEMFhVtfET6YzBMMuiZF4dq9S2XdUw8PS5JWTe6nasRrUKF7Z8ps8xgtmaH0prhFxkgtwnlcZB1RnHMSLZSMDZpPa9zYrLutDs/rEkq24KvE7CMj+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=II4eoLcH9AdtDvOTFgcDWwV0QZfZFrUaavfiBQVXxNA=;
 b=FJvRdRVyAIO8vcFrB3rR7PY6JtfjJVyMffs82j4E4BwSKuTdwJ6thEVfOGYunfT/TPgHKR7emdm3ycgAABSUdl+HiY3koV5pV1UtyUjJpx/ovS2MDHumASAXdh9dp5JZHl0RHXMRMbbOQPpi8KBMcXtGwwJMj5X15Yc7wgHacuISFBIbDwqYQm8eVM6nXMhGNJFWoTIIQ1ITE0kfaAhs/IYF4IaVzNsnAAIeeAomkyS1E1AlLKAem6Gb4Z09jrTDkN7ZwouDDsqLdROsrrzGzJMGXjy5g9CX5ywTdp7Y60uxHwXcWhtGt1uO/VAliFhuXNoVj98msXLpuapmUec+Dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7169.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:459::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 21:41:41 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 21:41:41 +0000
Message-ID: <2d41fc43-db7d-4070-a769-bb37083cb414@siemens.com>
Date: Mon, 5 Aug 2024 23:41:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Process stuck in cobalt_monitor_enter
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Mauro Salvini <mau.salvi@yahoo.com>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <9d5bb262-0646-451e-a5af-82c0473a3003.ref@yahoo.com>
 <9d5bb262-0646-451e-a5af-82c0473a3003@yahoo.com>
 <035a65bc-c064-40c2-9fcc-b3fd6104a233@siemens.com>
 <4572a391-4c06-4aa9-b92e-66e9da6c23ed@yahoo.com>
 <44ffbd9c-fc28-40fd-849f-a77fee15866b@siemens.com>
 <CADBp9x=310edtayP3nEeDSc2D318E=qA1a=5ceG0krd3r2VN8w@mail.gmail.com>
 <87e3bc23-4eba-43c4-bb5e-ffce9139c075@siemens.com>
 <CADBp9xnL46vC0KiYt2MSv+XxYcgb675S5X6geQWSv8KsKG9+xg@mail.gmail.com>
 <CADBp9xn_Gcu9TCaiZHZvo3hwT4JzzTxE4ueMH3dt81KJWF8qOA@mail.gmail.com>
 <67ce5b0a-1013-4ab2-9617-0723c0dc0809@siemens.com>
 <d1b99e9a-5bc6-414c-9f5d-972134f60c31@yahoo.com>
 <bea3518e-5d72-4a86-a5b9-ac71a59c235b@siemens.com>
 <e5efbf9d-9054-46d3-8deb-aa321146068e@yahoo.com>
 <1b8ec985-8ae2-4bd2-8964-23f97cac7ba4@siemens.com>
 <CADBp9xn4OGi99e57phnv58NtCbxzO62bhrkJhSns-FUbbt4_pg@mail.gmail.com>
 <6fb4564d-3d39-4be1-838c-423a865638b9@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <6fb4564d-3d39-4be1-838c-423a865638b9@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0131.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7169:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d75b7f0-2fc0-4626-105f-08dcb5976475
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzJmKzNYZ0szcVlZVjhvazVhbmVRUkFWWVpFeVRDRUs5VnFidWFiaEhlTDdv?=
 =?utf-8?B?d0htcjVIdStQUi9MUGNBdXdNYVVoTjhKcXlaQXloSVNRWFdTRks1eituK0Ra?=
 =?utf-8?B?U0dRdUlSeTBrTXl6ZU9Vem9VVUVvcFpKekhzZll3MGgxSTltYmJkTDdocjVp?=
 =?utf-8?B?RmVLdW8yYnlrUmNpUzlxb1JRcXZiRlVFekJCR1ZJQkpqalZjeWFrVVdRUUh1?=
 =?utf-8?B?MWlNbnpBdk4yNWM0Qzl6QWI2VTJzUzRCOTU0QThhQUdaSXpIK1NOckt5bnRL?=
 =?utf-8?B?Njl6SHNHWlRYNnNQdkcyS21YYXVyQjJSdk5xUllOUlB2MVVOWjB6dmhRMjZU?=
 =?utf-8?B?WHVXTlZGQUFUTjkvVGRWekQyS21USlY3elNhWkVDN05yeXZMRG5Lc3BFbVdw?=
 =?utf-8?B?aHh1UVY1dXJFdVBmdVA1Y1hvS1JOQ2dCREQyeHB3SnZteUpacldlUHdUZFhD?=
 =?utf-8?B?RzBEWHN0Z2ZsbU9iaDU4a2dhMmpBaklzeU9iTG5qbHVKOSttTjVteXRNSi9l?=
 =?utf-8?B?RERMejNjenNSVGh5TDFGMzllL2V2c3NjVHVnbE5Sak1FTmRhQ0NEWGZpWk5Y?=
 =?utf-8?B?RHN0Y3Jza2gxOGpXYlE0OUdsUFhLNWtsRHpXaEhKcWhNTE5UUXh1VkNrcFdJ?=
 =?utf-8?B?dXo0RjZGRForWlErM05WcVpTdkNGcE10TEcvV0dRRkRLaG9jd0Y0N3NwUHhZ?=
 =?utf-8?B?eU1EZTFKREdxd2JGa2xWZVVXbEdOcCtkRExsQ1d0cE5yVWlneW5PNVlmdlQ2?=
 =?utf-8?B?aGVEWXpFSlU2OFZ0OXppaU9QRkhkbHcrUGlvcms1RXJrVWJ5bHVIeEp0VFdy?=
 =?utf-8?B?Z0tuVzB4ZVJoT1RLS1hsajdKVExWMmp6KzY3QUNlRmJjRGtjYUtFTzFzOHE4?=
 =?utf-8?B?MjFTT0MvOWtqdWF3ZCtEdFBzVGhrSzNxVGpsRTI5ZGpUOVpZajR2KzVEZTV2?=
 =?utf-8?B?QmdFakFlSkI2ZFZxcEdjbENkYzAzdWMzV1V3Zzh3YUUvZlVxbkhFeW1Ldm1P?=
 =?utf-8?B?OU5WY1R2Mzc5eFFpakQrRy9oRlVjN3hXVmdHa0JjbFJ3aW56RUVNdzR3SVhV?=
 =?utf-8?B?UkEyellUSTEveGU4SVM1bU93NlhyT2VrU2ZKWUQ4b2YwRmV4cThsZVlUdWpx?=
 =?utf-8?B?S1AzdFZNVVVCMFhzR2tOdzhnQ2lROHJIaGdkTW1WUXl0MjU5NFBzU21aalZ3?=
 =?utf-8?B?MXI2cG8vUEJlOEJQWU8vT0dkV3NnYVltTXVCVXREc1dCS2NpSTNrOXM0N3BR?=
 =?utf-8?B?eGI5WEQwbHE3NFZYSHBhdzhwZ3gvb29xdGVjQnJoNVl0aVB4QUs4Uno2ZmlO?=
 =?utf-8?B?S1dBcjlJK211bUk1dWhTeUVJY3AyZkhQbWVuUWI5YjlkUVVTdm03T0JLY21m?=
 =?utf-8?B?NHFnOStDb0VKem1ubzZlTnJpdUNTTk5JTGp0eVpJaFAxcG0zdXpIVWs0bkw0?=
 =?utf-8?B?N3o4YzEwY1M4UnovK0xEMWdWQmd1QUdZSmk5dXJaWFVyeTZMejFEQzhlcFBT?=
 =?utf-8?B?QnhuKzhsZE9BYmcwS2ptQzYxMC9jZTlPVk9LV20weTZhU091SDNnejFheFFj?=
 =?utf-8?B?SkZDRzhoM1o1TjdXS1N3bjhrWVF6Zm1qc1Jla1lUZXJaVVZzVXRxOGt0dkwr?=
 =?utf-8?B?UVdrZHBJK2llVmQ0Wmx4OXNoMERoVXZGSlAwVnkzaFNDN2ZqRk1HZEw2Rko4?=
 =?utf-8?B?cGZXR3haK2ZkN1dQdTNOQ1dRcWFhMDNiVDJJaHRUSXZPVlhha0NmL2tEbjQv?=
 =?utf-8?B?YnVuU2d3MUxoOExXcVVNZDVTaHdRZ2RSSDkzUVg4dU1veGxOM0tWQ3V3NVFB?=
 =?utf-8?B?ajc0ZnozUGpJa0lGWnZNQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVpWNEdWMlVORyszL0tlbWZEd2plZ3JIaC9sL2tlcDkzVWd2OXI4MU5ORFdk?=
 =?utf-8?B?QkRxTXVpUTUzRzR1aGNrS2xJVmNvdExDVjhPR1g1VktiVmRISGpSbStXVDVL?=
 =?utf-8?B?YjdNZFRQcUFIbTZrRTZiUS9jcUFHMUxGVlk2WHorSUpCVkdJVlJtdUxudkor?=
 =?utf-8?B?VlE0WUtURHExYmVBbGY2THFIcE5tVzZ1MWhvUG1GeDdnQityNHpkS2Z6MVho?=
 =?utf-8?B?eGVMenlENVZTUjd5UmdpNE5xakV4VjhwZ1V0ODV6aUlQNkVjV1kvREZaQXNJ?=
 =?utf-8?B?RjEyYmVXNXMzREdxSDNHU2lXTFduWTV0UFBkVzBJcE9qUHVjOFQ1QkJoSHJB?=
 =?utf-8?B?QVM1aTZ0MHVsZk95SWVrOHdzWFZ5UGRkcm1qcE1hTVpvdThmVWYrS1c2b1hp?=
 =?utf-8?B?cU5GSlRWMUorTk43MTF5T1VvV1dKajIwR3ZDTGppZi9PZ1JhMllCY3hMaVFE?=
 =?utf-8?B?TTlBQnh2bm5odlE1K1FRWms0d3NVMnJyczNEQ0lmRXdOcW91L1h4VHpXUVRm?=
 =?utf-8?B?a2xoNGpRVUlKSGdoWUdLakdKclZ0VHdMcHk5UEROVXlhSFUzdXdQRXVteEQz?=
 =?utf-8?B?dHJBR1kvSWJ2VXByOUdYNTl0V3F0eUh1dXR3d3JoWG5WakgvYzFPWnhObklR?=
 =?utf-8?B?OXZrQ05saEJoRnkzRUI0SHdQSUI0RkxBS21NTXRybldLV2RlQmxxNVh0d0Fi?=
 =?utf-8?B?aE5Kc0dvbTRWQWVYVW5sNUhReXNDVy93VkZKQzdSZXMzSVdVWWdLNFJ5Z0pP?=
 =?utf-8?B?U1R4TC8rMjltYVVVQVJxa1hVWmMwMWpGamVPWmtwR2RxSHNQc3o4WWRQc0t4?=
 =?utf-8?B?cmpRT3U0eERSQ2JWMWNpWFlWdXhvdDFiWnFYUFpndzV1cHJrTHlHUFdqWjBT?=
 =?utf-8?B?elBYNnBrUkFralVzc2xsTTNMMmpvOUlzdHhvdTh1WHFrcXYrRFREV1lmM3hR?=
 =?utf-8?B?RlU3Zm41cVE3WDBraEx5WUprSmVNTzFXTWJkQ3VNa2ZzUE9CQzNEUWxCWDNN?=
 =?utf-8?B?aGtRVWlNWW81c3FjZVJUa2dyQ3ZsZ0xlUThFT1A5YXp0bmQxUGdWcjFYQlBy?=
 =?utf-8?B?cEpPWmhwWHpINjZTaytGRm8waThxcTQ0WFAxbzA2RU1xQ2k5VEhQZlUrZUVG?=
 =?utf-8?B?cFhTV2NtVG0vaUxmbHRNd1Fua04zYngwSHNTV3lycDRGZE0wNVBzOXZ0czNN?=
 =?utf-8?B?VklEQ3A5b0JpWDVDbFhSZEpBNVhYZTZNM2ZZWDVHTjRFaHlSUy92RzVpZDlS?=
 =?utf-8?B?NzdHUmJRd0JQYW1qTCtvdW9jK25lY2JPaUtlb2NKVXNjbGE3SlV5SDA3REQy?=
 =?utf-8?B?U0JWZjNWbmJQOWZuRzVFUmRQM090dVJvOHNOV1o4cWZTUEl4TUs5WFJ2cVlr?=
 =?utf-8?B?djc1UXlXSjhDTE1yQjBlWDhaM3hsQWVUbGdNak5MdXV5T2tHdXFwVTJhbWVl?=
 =?utf-8?B?Snc0aktjcU1PemZhdU1sQm0rbDVKbTNaY2lNTXhNQnlOUkcvb2Q1aWlNRFZU?=
 =?utf-8?B?MWZML2MxTmVoampJc0lGanhRUnc2eW5PeW5FVndPa1FNc1ViZFJpOUhvcXY2?=
 =?utf-8?B?cVlkOEpLMlZkdDFSUUdGcEJIMG84ZE9QMTk1NzgweVNMQ0xycEVoKzdYZkxH?=
 =?utf-8?B?aEZzeSs0VkY5ay8rRlBJa0M1dC9lRFdqUFZxdStJOEtJdnpXd25ESU4reEtP?=
 =?utf-8?B?MmJydU1wMW0rNWdQUExTVlhmNXM4bjRQWDNLY1hScXRHQnRkcC94OXd1TERn?=
 =?utf-8?B?dmNIRjV5VldiNXYvS3BMMElQTDhKdVVEbWYrbmdZZGFlMlpOb0x0MFhqcWtv?=
 =?utf-8?B?VkVuKy93UXcrb054bVBjWHQ2SnlpSjU0SkpMSjdMcUpiQjBuK05GNVBQbE9K?=
 =?utf-8?B?OGVzenk1UGFKa2ZzZUREUjhhejFuekZWbW5keklzcU1kbmR1eVFyTERyTkk2?=
 =?utf-8?B?bnA1WGhyZ3JWeldpRzhzWlJDN205bVdncjRZY2NBYXl0VFYrZ0ZkbEd4Witr?=
 =?utf-8?B?eUNSQWxhOXZZaWUvK1N1QU1LMloydDBwMnZDM0t5VmZvbG9KQkU0RXBZUmNk?=
 =?utf-8?B?QUxueWZ4djRWVTFEY0VZME5sQ0wxWkRYQVViYmpoYitRZ2pDYUNXVGlkNU1s?=
 =?utf-8?Q?RVi65R9OUVThkVyfWg0R+4meb?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d75b7f0-2fc0-4626-105f-08dcb5976475
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 21:41:41.0899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n/K/CA6dz/KvCKvPBC/b2DK9Bl9jA5IWv2hWDknZHNCWjEP5vxaJoBUcN/a0pmZ+AtTC1ZDBPDt+5x0DNsVs+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7169

On 05.08.24 16:40, Jan Kiszka wrote:
> On 05.08.24 16:28, Mauro Salvini wrote:
>> Il giorno lun 5 ago 2024 alle ore 14:10 Jan Kiszka
>> <jan.kiszka@siemens.com> ha scritto:
>>>
>>> On 14.03.24 15:22, Mauro S. wrote:
>>>> Hi Jan,
>>>>
>>>> finally I managed to have a piece of code that makes the issue
>>>> reproducible. It's not exactly small, but not too big either.
>>>> I hope that this makes the issue reproducible also on your test system.
>>>>
>>>> The zip contains:
>>>> - a little main program (test.c)
>>>> - a little library (in mylib dir). Some pieces of code are never
>>>> reached, but leaved to avoid potential compiler optimizations that could
>>>> remove other relevant parts (maybe cycles?)
>>>> - a script (build.sh) to build the two components above
>>>> - a script to launch the test (start-test.sh)
>>>> - the configuration of the kernel in use
>>>>
>>>> After building the program and the library with build.sh, you can copy
>>>> on the target:
>>>> - the start-test.sh script
>>>> - the built program xeno-test-session-hang-on-exit
>>>> - the built library libmylib.so.2.0.0
>>>> and create the library link /usr/lib/libmylib.so.2
>>>>
>>>> Start the test with "./start-test.sh &" and follow what happening with
>>>> "tail -f log.txt": after a time that varies from a couple of minutes to
>>>> 25-30 minutes, the log should stop on "~~~~~~ RECEIVED SIGINT ~~~~~~"
>>>> line: the hang is happened.
>>>>
>>>> A small recap:
>>>> Atom x5-E8000 CPU, Linux 5.4.255 with Ipipe 15, Xenomai 3.2.3.
>>>> GCC compiler used: 9.5.0 from Yocto Dunfell 3.1.22
>>>
>>> Can you only reproduce with this setup, specifically with this compiler
>>> version and only on real hardware? If you rather use xenomai-images and
>>> qemu/kvm target but still the same kernel and xenomai version, the issue
>>> does not occur?
>>>
>>> I'm trying in kvm right now, also with different compiler. Iit would be
>>> good to align / rule out variables if my first setup turns out to be
>>> unhelpful.
>>>
>>
>> Hi Jan,
>>
>> Sorry, I never tried on an emulated system like qemu, I did the tests
> 
> qemu/kvm - that is CPU-wise not emulated, virtualized. It generally
> gives similar execution patterns as on real hardware.
> 
>> only on real hardware (using different samples of the same hardware,
>> just to exclude hardware problems).
>> I can do a test with Xenomai images on real hardware if it would be useful.
> 
> That would already be useful to rule out the toolchain as contributor,
> yes. When at it, testing in qemu-kvm would also be nice.
> 

FWIW, I've pushed ipipe-core-5.4.281-x86-16. It's not that I expect
positive impact on your issue, but you never know (until you understood
the actual root cause).

Jan

-- 
Siemens AG, Technology
Linux Expert Center

