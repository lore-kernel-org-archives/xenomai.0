Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011005.outbound.protection.outlook.com [52.101.65.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FC8224B0D
	for <xenomai@lists.linux.dev>; Fri, 23 Jan 2026 17:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769190835; cv=fail; b=ZIjphCMkXjw46fkl9l+6Z71v3p/c8nXUBbv5O0NLAq9EbKpK1GaXFjaWBPS/fK0ERZtFxtev0FQ8xmgGL9rh5gxRW8trtCI4kGQDst/naNoY2I2iOkybq3uUL47Rn0soL6agEAIEg3QYvSUvBBcAVs0FWcNiijU+53PXstDEpO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769190835; c=relaxed/simple;
	bh=G/4srcvE9kzlsicrh9DuvY3J/AruV1RTOfCfHtu+Dco=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eSJscTLDEyPe3eFLOnW+VY/ai8heBZwDD6Kz7JsvqmcfGIaIvGXblbu5M/UhAPniXOpKSxshaXflNwysvfaNp0H2zEhA9wE9hsu4hPmHjqe0bwTmCxm25INDNYFU1AzTn4TW14v9KFkKDkTedG5VB0cgNtTndACF0pCsHENlWqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ogNcFOjF; arc=fail smtp.client-ip=52.101.65.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ogNcFOjF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nCTFBXvOR4neQwj4VeIkZjy4rXLLEs0VHnSUpZCg+bwPKfMSRXyOKP/kSzEv/VyaxHwht4Jl2GP3S9SSR1LR+LL0A65Df/x+yPSh0RR7K3TOm9/wJJnJkIv26mTKex7QmhDrBygdSQneTJizab8YnRazDdYm7z2l1LNSQ3VP6hYCHkWk54P94W1hR0ZTo8mmV7yK8BQZ4u2Kb8ItmuUcpvBNIbpeLJo6QhM38IVgvHnsZXd1hf4Gq7cWkho5he+bvn0Da+hEtQU3CLBXdOg2bFdaT2if8p4gmrqXopHt01K1riU0dCtZJyO6zbeh6Pqn0PQ3p+zMlRW+rCuFI2uS0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzSQ0kv9YnTKM5OXv0RBZeR8RFvdoSy7pSZ9LHvG69U=;
 b=pYkUAxqrMAIWJ0MP4v2H0XZx8aiF6mUx96bLKpSjV6ICGIl++9jFDu/68xTPJyEmOhrjfjjnkev9BH2NR7aVnXF1NvMAVwbwuZK9AFXSgyr3nJyNpgZe8B8fT1jyqxMIVyYPmqZcfKKDz+vYG4nkiPUkuA3O5MBDAEmHk4Bg1nWevWSQCHIkY4ns1UWYzbNLmXTX7sLAm0AhiFrUOg0sODPU6S47UZ4BWgUfm0rDuR8yphzqYrHh+M70o8krb3h+yNiu2vyfNRtuV15yG4J7VPyYsLiq46IEVqtXF5rnSPHSa2g46bBB/NoqAWQ/+0qotKj/uq1okoQhc6l27VeGAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzSQ0kv9YnTKM5OXv0RBZeR8RFvdoSy7pSZ9LHvG69U=;
 b=ogNcFOjFPAY40ii7TWnjx2e/lKOvgcqHEmxeovu511bIe6kmuLcAXmafT7nRzffROYgxLwM0PAJ231YHpfmKWbeI7+HME4j8t0AcT+1qSQ2LZ/ulWI8ee2xyrIFEVP7cXj8BMo5i7oWbLSUSSxdcxRf/bX22WVJNX5M81VVwHdsJot0TcCUi7ykd+SDpE5ERRpc/ftOkU9WTru7RDgzxg0aBSQKwnfL4ZI7b8si6L4tsmb9MYZZNQT6tBXPlClx+DMRGRv+VecG9jIAwXMwhZ3M0XCbActjK7TNpRlIDcaisPjGto+PEk8QWS4sj465oW3ip0OLOO867Fj8kV6a8SQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6069.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:38f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 17:53:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 17:53:47 +0000
Message-ID: <cc8c601c-a651-48ad-ae98-364b9cc62506@siemens.com>
Date: Fri, 23 Jan 2026 18:53:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images] libevl: split libevl into libevl and
 libevl-test
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
References: <20260123141501.1871775-1-tobias.schaffner@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260123141501.1871775-1-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: ead19e1b-f2cf-49cb-03c2-08de5aa85bac
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a3ZTeDFTSElpN2U3c2N5MEFqQVZZaFNCS1pFMmJVYStnNjVmcHRXTXovSmJK?=
 =?utf-8?B?YmtPSmhCREQva0R5K3hYZGo3RUNqd0RUa0FPTHRqQ2cvaGE0VDBGbzdhQ0xF?=
 =?utf-8?B?WG5TM3JUa2xiSXdjQk1qTDFNUnVjQTU3MzJlSzlSN2ZINTZSbkxRR2pMQTlL?=
 =?utf-8?B?ODhEYk4xZWgrNCtnazNndXdYMXJUZVZOWFBGT0svNVk5KzRDM3R0b0dMU0J0?=
 =?utf-8?B?aGlYRnRNbXZ1dVV6cklUUmR1OEwxa0V2cmRpUjc4b1dwNXVLTjJ3Ny9YdXJO?=
 =?utf-8?B?V1BQK3M2U3ZCdU92TFlUYnhMT3l2Z2paVmNTMFFGZDJqRXNYc1RWaFlYU2NU?=
 =?utf-8?B?Z0kvWXgwT0hGRC9WV1pVcDVPNWk2YjcrNGQ5UDgwcGs5TW1sd2Y2aHQ0S2Rz?=
 =?utf-8?B?cklpMDhSWlR4VG5yMzJ5VGhlaUZsR0tFanplZGppNStJOTdPRW9McTJVa0Zj?=
 =?utf-8?B?OGE4aVJVSTROS0lNejFBL3ByMGh4U1JTSXR6cnFZeGx0alNQdUU3ODJjK0hL?=
 =?utf-8?B?b05DRFAxby9nK3hTMVdWbGJ2YjdtZkhUemZlTmFhQzJUWGFvbEY0RUNhbm9L?=
 =?utf-8?B?dDBXUzVxVFhwODNSRXE2Z1NkZ3ZZVFVhbWF3TjdQT1FuVlZiU1JnOERBZEgz?=
 =?utf-8?B?RmU3OTI5a0NDdHAxOU9ZOERhbWpkMTNXSWFyaW95ai92S0tidG8vSDRJOE5l?=
 =?utf-8?B?RXVIN2EwbGpFaXRxVVREb0QwbjhUOFNHallvL2FQdDZUYnZmbncweEtycGtx?=
 =?utf-8?B?WU1YTjRRMHRrbHZpNytpUnhZU2tqWExGZlVxbThRMG8wWU1WcEUzbHVMWW56?=
 =?utf-8?B?RzJjT2k0Tzc2WU9lRHJqUER1OVVFd3VlS1lpSEJEMU9jWjFXc01DQ3AzVlpF?=
 =?utf-8?B?Z2RUMGdrYVpPQXRIaXI0WTlPWUVwNldVRHc1TUJlYkZIbDQzZGhxZGoyK0FS?=
 =?utf-8?B?QTVxQm02R21nL3NJWldzQSswaFh5dUZEa0xlNFBEOVYzdHJRVXJscThmK2lr?=
 =?utf-8?B?YjUxMXYzS3BGU042M0JLNnNyNW1WcHBpVVd1OW1reHBwVExJQUJnMFFWdlJU?=
 =?utf-8?B?WnVWZzNvWGVGeDNScTFyRlhZOVlRSU5iM3Vld1VaVzJOTS9qYjl2SXM3aFRy?=
 =?utf-8?B?bndqYkI2TzVmNk5UekxreVJQalNneWI3WDlSSGg0eTBGS0lYeU0vdXMzNWpU?=
 =?utf-8?B?dzBJR1dIVkNTODdPRXBpclNvck9kS096bHlRTkhENkUwbXZFZ0VQY2d4OHRy?=
 =?utf-8?B?S3NPRkNheVpYa1JzYkhNejR6RkJSV0oxVkVCQmJPV1hWcm1YUUFDQWYwRUF2?=
 =?utf-8?B?TFdFQzBPQm9CYjRqbEdMVUc3VjNVbjNnVlRCaFJuUGlaQ1ZkUUQyS3hWNks0?=
 =?utf-8?B?ZzRQdUdkYVZPaDBjZG04QWtiTnBybUNscXB2TEJtVXE1Qyt0OVFPUjdQWG9m?=
 =?utf-8?B?eEkyOHhpYzhWMW5CRW85NklsKzl0dTNIbjJtU3dxcjlKYiszVThKRkcyUWw0?=
 =?utf-8?B?MEpFc3dPV216cWVLYUFwaXlMZE5aUHlwQitESUx4eUhSZm05eS9DRCtwOXVV?=
 =?utf-8?B?Q2dZNnovMUxXM2tYNno1b0l6RmpkdC8rZ2ZJb28vWUVONzhJNUlIUGd6VjU5?=
 =?utf-8?B?bDBCaGFMdHBidzFGYjhEeEIzSGNWRXhCdFA0bHZRT0d5bm5vRGhFSkRPWVNn?=
 =?utf-8?B?cWlpbzkwZzFNd2NyaXN2dnhKa1FzUFdHWm1oM2Z6dDhodk9uT3Y3a0FPUHZ3?=
 =?utf-8?B?M25ua3lOU09KRUIzc09uVUR4N1pkUGNtUytvaHJCYWR0TVJOUjIwTllDYVhK?=
 =?utf-8?B?MDFkamhRUnhIazZYdW5FUE9qWDZxRWdCdTZ5WmE4eHk0M2lIRXBCN1Q2RXo4?=
 =?utf-8?B?TGRsOUFPMWdDK2l6dFNQN2dqbmFuM3AyeC9qZzYxckt4Z2kvdjN4NnA2UUMv?=
 =?utf-8?B?SCsxZE1NK0RuMzhkeG9rSzJiOXpzTHdYSjZRMDh6cWJ4blY1bWF1WGZBcUdZ?=
 =?utf-8?B?a2lqdGw1bGFYd3ZMT3NOQjJ4dVVpbFFXR0xqWFUwSVZacTVIdEdaMzQ4TXVv?=
 =?utf-8?B?SHVsQ0dLRHZaL3ZQUkptUmEyS3ExdWhwMkkyZzcyNFoyWERNaktrQkRQRWtj?=
 =?utf-8?Q?D5u0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1hYUEdxRStIOFo5MmRBUElIVENmNlovdktOc0dWRXRUeG5IZ2IvUy9uQ1d3?=
 =?utf-8?B?My9jRWdMdFdMaGNHMm4rRSt6TTJrcXpnSkZrbVVtcWtBNjIxYk91aGhQblNV?=
 =?utf-8?B?d1QzWDRJZHp6WTZQaU5NUVBwWkFtRWl1Wjh2MUdOaG1ucTh6b0R4ZnpsTEli?=
 =?utf-8?B?NEhHbW9NK1BSeDZaSS9lVVY5YTdraDdaY3RpOFEyWnU3WHFHTHFCNXRXMXFJ?=
 =?utf-8?B?c1E5SkY1cGZ6bHR2WWVpZU9OSGwzejdkdUtqUG1ORUpIQVl0NWgvdlVIVGtC?=
 =?utf-8?B?MDFLK3lXTjF5b0krb0cyQXRFc1QxMHAyNFRBOTFNd1c3dlUweFVGUU9jS0l5?=
 =?utf-8?B?UnFuUGU1VTZaM0t5YkRONllpeDdMQlFsL2JkVlRYZGt0MWpUOXdIVSs2UjAx?=
 =?utf-8?B?dHRUcWpnNzRITkFlS1A5L202RWVjNmpiaU1BeitGSVJ5bEEzUXA2a1RweUpj?=
 =?utf-8?B?MWJTT3NWcDBKMDR6L2dHN0tLbW5JZk12b043UStLKzByaVlZSjRRQ1B5MmNX?=
 =?utf-8?B?VWNDSGEyeDRkOHZLKytnQ21NcXgzRXdEN09wdHIwbWZJVlVRSlFkWkN5d0FE?=
 =?utf-8?B?M2FuVkxDS0hMQklXa1cxSGU0TXhQb0ZoUW1abHR0MFNxYzUydythSlNlRTVH?=
 =?utf-8?B?YVVVcnl4bUdEc2tveURNbElPa29ZblV2K0RMR0lIV2Y2MkNFYzVmdDdFNG40?=
 =?utf-8?B?MlRGeXdUV3l0K0tBOWlFbVVjd09xdHdIdEFMYWlDWkxRWE5yZms4WWVQSUIw?=
 =?utf-8?B?YW1UWThGcnZHeEFJTTY4NkpzTnhrUWZ1UTRqZmVNbjlUcjZKK2JsblhaNDZU?=
 =?utf-8?B?RjI3bFAvZ2NXR3hrYmM4SGowL05LSDFDVWRINSs1OW5wQVBIRkVscEY2eTFx?=
 =?utf-8?B?ZHF0STdRT0d2VmhiM01KMm5GSndhVlBWTGJQN1U0OCs2Und3Q3kxZU94WlY5?=
 =?utf-8?B?bUZucXcyOHRqYkUzQzhxcGI4d1kvQ3NicEUzNVRNVDlHNXpmSDhnYVI2MGJ5?=
 =?utf-8?B?bVc5OU5YZVRrOG5vTWpxOGpYWk1rcy9wc0lja2pzcHpHYm42SVdZZGFUcGQ3?=
 =?utf-8?B?b1Z4dGhlMTh0ZmlQaHhBUTFUeEVvSG5OKzhiQVc5WGZoRTluMzJUc2tLZ1Ny?=
 =?utf-8?B?R1Q4SjNtdFA4OFZQRFhUT3BBUXYyT1VNM2hmdzFRZEk5bHMrd05LM3dIbjNI?=
 =?utf-8?B?V2xBVHc4bHppYmw4ZHoxN2VYZ3U2ZUtNSzhaT3N3c2tYZEtQVjJpRkEvZlJS?=
 =?utf-8?B?TXErWlRwNEhyL0xnQ0Z5cEpBZXdUeUlhUnRxcXVuekJBdkc3aXd5ZHZiaGVW?=
 =?utf-8?B?TVNCaFNKelhDY0hSVEQxbGJGenVDcldkb2tHNTMyUHBCYnZ4VU5FZzBnUG5D?=
 =?utf-8?B?Mm1yby9ub0cvZXNnQjJzTGN1OUgvVHhHUU9oazBFaXZIcVBFUDNhRDlxcVpV?=
 =?utf-8?B?dEkxTmlIREREdEpncEx2MFNuMjhUdk8zOGtxNVUyYVdtV0ZZekhXR3VkbkFL?=
 =?utf-8?B?VTRhc1JyZTYvdzJWK1dhN3llb3p1Y2FGemFsWFdwalc0c1IvekY0ZzdHNmRI?=
 =?utf-8?B?TjNIcmhxZW5rVGxyaFhybjcvSThPTDI0QS9xQXlXWXZ1WHpzZEo4aWJENzlU?=
 =?utf-8?B?UHVIa3JFdmNCMjJITmtpMUpLVUJUZXZTZUNvRWo1bWVmK2ZqVmhZR0ZKZXY1?=
 =?utf-8?B?SVl0OWRKeXhxMDYwT3ZaelVBQTFLeGloMGtZdkFBeEU3eVZWam53eDlEK09P?=
 =?utf-8?B?OE4reVlzQ3NVQm9CMjRFNlkxMUVRNy9vRjhzVlp2Y2VGSFcvaWVaMUtYQnNs?=
 =?utf-8?B?QStzVVdLNUg4SWRGMS9SbVJ3VEtEM3g0YW9rd0NXZmtQdjEyUVV1dnowTFhj?=
 =?utf-8?B?K3BaMTVUVXoyOWdxdXBmajVWM2Z6STM3OXJhZ1gxK3dOQitmQTMwQmNZdENV?=
 =?utf-8?B?MlpuRis4cExQZ0lMRlhaMjYreWluZGdRU2JiRmtYTGkzcnhJdmNxRzBScUFE?=
 =?utf-8?B?Z1JURGRPMDlwS1cwZmNZRStEVmgzdVJKSWthbWx5QmdueWJNZk1ZdncvYlZ2?=
 =?utf-8?B?aklSbmNnbHVKbEMrMFBNS0FFV0tndHphZDcyUXJKWFFHSzBiMkNPSTJMMExx?=
 =?utf-8?B?cElRaEVBVkM0U0pmeUhjMzg3V01WemZIVWFEUndlc2pJNFJwRlhzS3p5SGY2?=
 =?utf-8?B?TCtXVCtLMk1iZDBRRk51bHA0bXptVlE5ekl6NDhGbitZZk5BUjkzQ0Y3ZzZz?=
 =?utf-8?B?V2hOSUllK3c5UzAzRlB4enJQaU9pUkVJd1lVb3Vqa2dzcEo2REZIK0lVVC9o?=
 =?utf-8?B?ZFdJemRJVkpwTXBSb0RIbXRMM0gvT1dVeS92QXRNQ2ZiZXpSL0l0dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ead19e1b-f2cf-49cb-03c2-08de5aa85bac
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 17:53:47.3575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jBxZKLK24TU2+mZYUvv9B/WNwlo/KkHHJCaYVHtqT83815E7NgzZffk9WrpfwiBy1+RPKVteJS40G6EZX/Vkhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6069

On 23.01.26 15:15, Tobias Schaffner wrote:
> Split libevl in a pure lib and a testing package to make dependency
> handling easier and to allow soly installing the libs.
> 
> The ptrace-sync test uses gdb to resolve and set breakpoints at some
> named symbols. Add gdb and the libevl-test-dbgsym as dependency of
> libevl-test.
> 
> This is a substitute for "libevl: allow gdb usage for ptrace-sync test"
> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  recipes-core/images/demo-image.bb                       | 2 +-
>  recipes-xenomai/libevl/files/debian/changelog           | 0
>  recipes-xenomai/libevl/files/debian/control.tmpl        | 5 +++++
>  recipes-xenomai/libevl/files/debian/libevl-test.install | 3 +++
>  recipes-xenomai/libevl/files/debian/libevl.install      | 9 +++++++++
>  recipes-xenomai/libevl/libevl.inc                       | 2 ++
>  6 files changed, 20 insertions(+), 1 deletion(-)
>  create mode 100644 recipes-xenomai/libevl/files/debian/changelog
>  create mode 100644 recipes-xenomai/libevl/files/debian/libevl-test.install
>  create mode 100644 recipes-xenomai/libevl/files/debian/libevl.install
> 
> diff --git a/recipes-core/images/demo-image.bb b/recipes-core/images/demo-image.bb
> index d0a1f42..7ea4dbe 100644
> --- a/recipes-core/images/demo-image.bb
> +++ b/recipes-core/images/demo-image.bb
> @@ -48,7 +48,7 @@ IMAGE_PREINSTALL += " \
>      lsb-release auditd"
>  
>  IMAGE_INSTALL:append:xenomai3 = " ${@get_package_names(d)}"
> -IMAGE_INSTALL:append:xenomai4 = " libevl"
> +IMAGE_INSTALL:append:xenomai4 = " libevl-test"
>  
>  IMAGE_INSTALL += "customizations sshd-regen-keys expand-on-first-boot"
>  
> diff --git a/recipes-xenomai/libevl/files/debian/changelog b/recipes-xenomai/libevl/files/debian/changelog
> new file mode 100644
> index 0000000..e69de29
> diff --git a/recipes-xenomai/libevl/files/debian/control.tmpl b/recipes-xenomai/libevl/files/debian/control.tmpl
> index 36eb68c..89c871a 100644
> --- a/recipes-xenomai/libevl/files/debian/control.tmpl
> +++ b/recipes-xenomai/libevl/files/debian/control.tmpl
> @@ -9,3 +9,8 @@ Package: libevl
>  Architecture: ${DISTRO_ARCH}
>  Description: ${DESCRIPTION}
>  Depends: ${shlibs:Depends}
> +
> +Package: libevl-test
> +Architecture: ${DISTRO_ARCH}
> +Description: ${DESCRIPTION} - test suite
> +Depends: libevl, libevl-test-dbgsym, gdb, ${shlibs:Depends}
                    ^^^^^^^^^^^^^^^^^^
Just realized that this works fine here, but if someone uploaded this
package to an official repo that has the debug symbols split off (unlike
isar-apt), it would fail.

Maybe it is better to do a targeted strip-disabling for the test binary
that needs this.

Jan

> diff --git a/recipes-xenomai/libevl/files/debian/libevl-test.install b/recipes-xenomai/libevl/files/debian/libevl-test.install
> new file mode 100644
> index 0000000..e4118fd
> --- /dev/null
> +++ b/recipes-xenomai/libevl/files/debian/libevl-test.install
> @@ -0,0 +1,3 @@
> +usr/bin/latmus
> +usr/lib/*/evl/evl-test
> +usr/lib/*/evl/tests/*
> diff --git a/recipes-xenomai/libevl/files/debian/libevl.install b/recipes-xenomai/libevl/files/debian/libevl.install
> new file mode 100644
> index 0000000..7efc9b7
> --- /dev/null
> +++ b/recipes-xenomai/libevl/files/debian/libevl.install
> @@ -0,0 +1,9 @@
> +usr/bin/evl
> +usr/bin/oob-*
> +usr/include/*
> +usr/lib/*/pkgconfig/evl.pc
> +usr/lib/*/libevl.a
> +usr/lib/*/libevl.so*
> +usr/lib/*/evl/evl-[!t]*
> +usr/lib/*/evl/*trace*
> +usr/lib/*/evl/kconf-checklist.evl
> \ No newline at end of file
> diff --git a/recipes-xenomai/libevl/libevl.inc b/recipes-xenomai/libevl/libevl.inc
> index 1783042..4c048e5 100644
> --- a/recipes-xenomai/libevl/libevl.inc
> +++ b/recipes-xenomai/libevl/libevl.inc
> @@ -14,6 +14,8 @@ inherit print-revision
>  
>  DESCRIPTION ?= "libevl libraries and tools"
>  
> +PROVIDES += "libevl-test"
> +
>  SRC_URI += "file://debian"
>  
>  DEPENDS = "linux-xenomai-4"


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
