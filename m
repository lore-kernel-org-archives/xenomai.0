Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2076.outbound.protection.outlook.com [40.107.249.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785F013F01A
	for <xenomai@lists.linux.dev>; Fri,  5 Jul 2024 11:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720178606; cv=fail; b=OgxnpckeDH1wZSaG8phaGHGDZJJoADE6vwqzbt/9AFmOzcnM5EvOZkHeYbOVuVjGIwaxpI1Ey9Ba1f+hk98RUCP434ZkWhegz9exCUnNUnQG2n7PqykDTpwJGyCyzOnI8BzV/4Z4RvZQuf2l9ITWrLcnPq4Ne2UVFmIB12EDQOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720178606; c=relaxed/simple;
	bh=6MBTVUjRoj+dgfJR6dcfj9it0HeFuEt52kHmPxij5g4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tNSoCzP/8qtJuIHTLcZsw7KW3OSgZAF74/p/+QeMAiWAYwLe7Ff5qEfJDyvFKC6l6qf542ffZehLGJHjrgeRB8K29IzhJZpuVoaulSd33lYkED4sPvZtIlrVKHJDjKBrNcn4jYwP+AfNlGqsKrcykIJ9YBNnbp8eR3r68v7V7So=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=xIPh8UqF; arc=fail smtp.client-ip=40.107.249.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="xIPh8UqF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgKmNn8WMnBoseg341gnAy1SGVq8pGC16YgICXhO1pzhajjb2EBUkldGTIVmYJulcv9lZSJ56M+aZIozk/sDIuX7PABgyUTkQWGzHNvteUny76ycGer2fR2ZzicaFr1DmfR7OWgmD34LF7D5hdImvjD6oAI5AfxeBSJxwL3UfqI8NoAbDprVflRdxsGtdiYYHnC/ynu9kvUhJZwaoVogLOoXjUbTmkE70AEFykuWqgd3RXGol6VHo5U/9+rl0J818vuPOl2wkO8ey59d5oSoDf3tnaRMFhMSja4di+ZCljZzhCxXh3V1ey3rgZAvB5CX/jb9Qr3new7mgc2eIgZrWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIYpmYkz3pMfz3HlW6ecjEAvWBrbwEsKBlwqPg9SCD4=;
 b=ObWOt42iuZn2y/1GiEsNu+i2jS1AbhsecTZqw1D+WbqhFK74AGTpqn5U5SlL6j8IkAxbveW/NsVixr80yMQJ7My6qA4YJFr+XJzIlbXAAmG718ydD0J8I9N44INmqm069CGVnWBxAmzIT1ESu50zX/Sb/7/L5kwS/PpqMxYUmt37iBZJshxlLTlpGHtB3ZsAhDTftRqpgQaCX+RZoyyqwKfUsw9NTtto4BDLyGdPFZ5hVdkF39083OwaAFaZAgzmYTfjB8sNoa2UY26f9EjxilhnJ8YWS/qxH/DU0FEkfY2ZcfCZSELKcmFfNMgx+aNxqyGp6QahNoc2agS7Ku5JEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIYpmYkz3pMfz3HlW6ecjEAvWBrbwEsKBlwqPg9SCD4=;
 b=xIPh8UqF/bwqkAGjd+AQYA8vIJHKvc4uVDq5V3FLxH+h1BK2NpeL7gA68Pdf155F33dvv61NAPXIqhr7LTY1krOaWAnLBhavtS71hjgfVMHoAtu236MIGR6sKDiJULkYdVOWpJi932SwY/lPqLpb5CO/bNQbC5+85u7Kz1Ac6f6xzfi7sPsWzQFJqtsLwQF2tjYVJW6QXv7prvvcK0/5DDVTQltlYY7BxDW3dMK4xyt2FhrHzGGb8FO0sSB0MGW39qkr4X8nnHATqN0qb5RSIb26Cz2vaVVulmMFvIQ/VEYNkecwvpP+OvPVsBAse6/IbBWJou6j96y/4Dh+/Y0gmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8657.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Fri, 5 Jul
 2024 11:23:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 11:23:16 +0000
Message-ID: <bcddf6d2-fed5-4be0-88ed-1c3393465886@siemens.com>
Date: Fri, 5 Jul 2024 13:23:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/33] drivers/analogy: Migrate from rtdm_printk() and
 printk() to pr_*()
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
 <20240702-flo-removal-of-rtdm_printk-v1-3-cc91bffdd063@siemens.com>
 <56a2015f-c36d-4836-9b63-881ff98dda24@siemens.com>
 <e5dfb611b7544f58adcdcac5e5f5051ab208df33.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <e5dfb611b7544f58adcdcac5e5f5051ab208df33.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8657:EE_
X-MS-Office365-Filtering-Correlation-Id: bb11bf63-52b5-49cf-4792-08dc9ce4dd7f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVFoVlZJTG1ZMy9SSktIemFIYVZEYkQzcVVXRUF1bDR6b2dxT1g4L09qK2Vm?=
 =?utf-8?B?dTFzcjVkeVNiV2V4TXlpazZ0WWdBRG9xbzh5WEs1V1VKdHFCTC9McU9qMUNE?=
 =?utf-8?B?Z1EzVzAxMkdlWThmSUN1V1ArN0l0N1VyK2JleldWN0FXSmdWREFlVWlQcnRQ?=
 =?utf-8?B?T3ZBZFlXUWNJajVFNzFMZ3d3eEZRL1NpNEp2Sy9PYUMxd3Flcmw2N2hrMEdK?=
 =?utf-8?B?Z1pxUThmVTU3RGhDSjJEUGZvWDc2aUZOZUVBTENwdXFjR3pjWGoyclgxWk15?=
 =?utf-8?B?WDZXV2h1YlhYVUVQRVRueW1sNGEyL2VDWEg1UVF1VzhvekJuWVdQWWFKelpX?=
 =?utf-8?B?VTJuZnR3K2RRNEZIK3NiVE8wV1ljbnE3dGdLZHYyU2dNQ0NMTEQ4NVpLRGNB?=
 =?utf-8?B?YVBBZHVWRmd2Z3lZbUVaYmtPUUN6ei82SktRRTl3YnhURHBpdG1oUDZpWENH?=
 =?utf-8?B?WGwzNnU0OVRkOUJGRGlTNlBabHRiVmMvUnFIdkVaRFJMbjErVXQ1MGJ3Qisz?=
 =?utf-8?B?M0ZFd2U1SGVUdHRmUkVWYjZQVmhCZStTNkR3Mmp1dnZmQi90R0xwcGNXQ2lZ?=
 =?utf-8?B?YmJjdzJzMHF5SjN1N0hPRkt5SDE3dEtsVEowbGNkb2NzNjd2MUhnVDlPeng2?=
 =?utf-8?B?Uk1hSmZyamtiR3hmRG9QamtOcU96M21NUmN1N21QdmxZS2QrSStTejJWaUxz?=
 =?utf-8?B?TXl2SkxxYk5XZlZFU2lPWlNXUm83aE9vRVZQVkQ4ZFI3ckhqNTdWRGQwaFV5?=
 =?utf-8?B?NWZQWGxoNTM0aU9VV1B6ZmR5UlUwdUhxK2Jua25XNW1UbU8xNlNvK2Fwa0Ey?=
 =?utf-8?B?TnZZZk9vY3FqZjBDNFBqYWZqMFdDcVg1WnFVOWxFYytmSUFoTGh6RnpHYjk3?=
 =?utf-8?B?QWEwWEZGRkxpTFRzS3lVa0NQQWxvQlZtMzVRRzRDSkx2bG5VY0c4SmMvWXl3?=
 =?utf-8?B?OCswMEFGeWtJNDdmZlBQMHhlNDBRbDZ4OExvb3VHdjBUY2ZxWGFTSTRoZmxh?=
 =?utf-8?B?NWJtOTV5QkxpaEtDZkNyYzA0S0Nzck5oeU5pSHk0UExGRmprcmY2VHVGUGND?=
 =?utf-8?B?MVhEelU3Q2p5NDBORG9xZ1RGTmJYMGJjVW1UbTQ5bXVDUE5FY0dOUWFmWU4x?=
 =?utf-8?B?UXk1Q0tpczFvdVA0Mk5XOVA0aGhVS0F4V1pldWpDV0h5L29Sc0RKMzI1NkQ4?=
 =?utf-8?B?cVVvdUJHWm96RzBLMzMrdFVxVUlybzl2MTJwcjNBMHlUbGM1V0NqVWh3aWt1?=
 =?utf-8?B?ZHBjYXZYY1NsTXQzdi91QzJWR1RVdGZlMkNjdmpqVjd3SkJXMnl5b1dMa3hU?=
 =?utf-8?B?d0M0U1dhZ2hkOFYyTURhcTVtWE9MVVhQN2RvQkRPZnJCTXQ3dUkzYndtOWRh?=
 =?utf-8?B?em1UNXVZY2s0d0VIVGpKRnRtMDMwRlVjTytlRjZvNnM1M3RSTWl6QUpxZ2FY?=
 =?utf-8?B?TGFnVldUQnFlbUU2QVRDdzQzREpXb3UvbmVpSElaa2tjL3BPRnEvNVBIL3pl?=
 =?utf-8?B?Q05XVG5PUkc4eC8yVmcvb0RmYnFNKzdyVFlyRTVWV3BlQWs1VFd1RjJaVWNZ?=
 =?utf-8?B?ZW9hV2VRZmJ2dmJXcjB1VWRNRHd6TXZJUFhDUVVTaThPL2NPc1lreCtPRzRB?=
 =?utf-8?B?VmF1NEZTRDlEVFBaTTBoLzlsTVZMWFJERU0zTGlIRjZMV1Bpdk41K2dzK05i?=
 =?utf-8?B?NmQvWVRadHlQUll6UkVEQ3pCR3lLbjkzRThrSlNaNG9icCtSZTdPVzBua3Iz?=
 =?utf-8?B?R1NkRTA0YVp2TTQ0bFBSZzdWYnBmMkdKRmxiOENkc1RaSGRneWRrZytGdUhU?=
 =?utf-8?B?bVZ5NFZraWpESXFkYTYvQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ny9nYmNCWWplVDA4aWhRUjZiTEFwcVA1NXdJWjc2bnI1aVRtMEFpYjVURWlU?=
 =?utf-8?B?TjZRZ2lLZUx3ZnVPUnY3amlNbTB1NnkybXRnTVlBWW9nWmtlZklONG9rRWxz?=
 =?utf-8?B?cENsSWExSVJncFJhTmtHU3lqOUx1SmxLVGFDSUxwdnZHSzJlTFpvRjJUdG1D?=
 =?utf-8?B?Rld3UjJLWTZPRTVjeWZ1bDdoaGl1STE2djE3Sm1nUVpzQlJ5cmQvUnhQRmNm?=
 =?utf-8?B?MUNWNXFQN0VNQVdYbFYzSWEvMWV0NTgyZTdsM1B3cTRVb21Hc25jT0tBQnVG?=
 =?utf-8?B?MHdCbmxiTGJ1aUdmRzhGSHZGMnJNSXV1dDBqaHM3ekszelhNMGhOWWZKT053?=
 =?utf-8?B?VlNXaGhEUmhTMDc3Rmo3MzdaUFQyK1pSblhPem9wSEhqZzVJcm5HT1BLbllx?=
 =?utf-8?B?TEZmS2JCL052NW9IWEp3OXpvdityTUlGTnAxZ1ZZZHZQUUNiY1Z4enc1UFUr?=
 =?utf-8?B?a0JmM2FNbnNHZEVXS3Yzbkc5VDVub3ZXRGtCWDVFdzN3TURuNUdWNnhzVm1s?=
 =?utf-8?B?RlI5enFQQXhQUk5GTGc5NFZkVnNxdGpINit6NTh0UW9ETzZQaG50Y1lPa09j?=
 =?utf-8?B?NHdkVlZ3NTNTaFdxZVNvcytDdjlFbVR3UzMwc3lPOXd0Z3VERmZVWmFFTzZ1?=
 =?utf-8?B?c0RJMDJUVitmdWswaTBZdHp2T21uY3RENVR3M3pHaFNUUklhMXcxb0swV0VG?=
 =?utf-8?B?N3UxcXhQdW1Ec0pDclJNVGdKaXJubFY0WGN4MTJGWlAyd1FzeE44Ym40dmVZ?=
 =?utf-8?B?eW9sMDAyWXVrcVpXdnBTeEEwK0dFK3M3SFpxcGV6WXhPZkV4bU42bXpPek5Y?=
 =?utf-8?B?dURUaGVxZzc5bFRBYS9oTGl2blpidnVEK0dXZkJQcUZFK0RTRGd2SkROUjMz?=
 =?utf-8?B?R0xvZm1BT2hlZVhUSTA0MnlGNlY1UTRteWVGeWxNUjM0RjQyU1VMZDlWb2w1?=
 =?utf-8?B?SXdNbUZ2dk43a1U0eHcvdHFEd0dpYUxVaGxqcWlnUitEaURZQ3RIOGcxenVO?=
 =?utf-8?B?L01QeVgvU0ljTUY4SVRDMzRXbHZoNHkrWExvb2cvSUl2cGNXaGtXZFpJdElu?=
 =?utf-8?B?K2FWa01MSlRRSWtCUnVZMml1eDNzK0Evck9ac2VEZUdNUmJ5VkRPSmFXNjlN?=
 =?utf-8?B?Qjg1dWs3NEZ0YlJTbEI3UWs1TGhSMlh4blhaZEE4T29ic3RLL0psanJQVWRp?=
 =?utf-8?B?Q3krTDFHS1pEM0Uzd1RNeHZ6OWg5d0ZGNHNYZDdxL3lqenRPbzJ0b2ZtYzNl?=
 =?utf-8?B?VzhuYU90VXhkdVliNVQ3dTMvdUsrK2VBcXYrR251MUdyYm5OeDdtOFNqL1Qw?=
 =?utf-8?B?eTRiUXdHSGo3NVY2VkxNaWFoQ21NZWFNM0tPKytPNG14c1V1cmZQWXpVWENa?=
 =?utf-8?B?b1diNlR3dlg5ZWhOOHo5YmtxUkVEbmdnL3NZdUxPZ2d0T2ZBd3I0dDc1M1R6?=
 =?utf-8?B?MHNEZTRCWnZSWFQ0L1VocHVOQUxVVEpsSmtJREhIMHdUYjljOEhsQ0RFNzc5?=
 =?utf-8?B?TUptRVpEeTBNak9CSjlrM0tNZ2N1RHFwZ0hyVktLZVNaM1FkdnppNEZVcWUw?=
 =?utf-8?B?aDl1eTNmUVFvNFpKR1NXUFpYUTdsZ05BZFNhUnlNWWJOUmo5YjV3QzFSM3Rt?=
 =?utf-8?B?c2FZVTRiRzhYODZFbi9CRW1zQ1NOdVdvZU9SaFNKd2Y1NkJ2K1dKeGNqQzJW?=
 =?utf-8?B?NHBXWjRRZjJHdWdVUSs4S24vSC9aWG96ckdYemhidEM5cFBRUGlKOFdhN2E4?=
 =?utf-8?B?OTMxV2FyK2RSMmloNTV3RzNCOFVVKzFKSk9UeWdVQUNreUo1T2M2OHBUS0ht?=
 =?utf-8?B?cEdiVXhzYmRFSUFqUzd5eXNJY3BMRzZNRVZ6c2hNVWx3MUdHK0NNZ0ovTmdj?=
 =?utf-8?B?YnUvSWZWQVBFZGlqbEhaekd3SWVOcmhDVEhOZy9paHIraHdLVUN1UklVTUQx?=
 =?utf-8?B?d2VtOS9JRThUM1VFTmpDVG5FL0NtWkFWY3Z6Y1MvVnZ2MlowWkxybE9SNXIr?=
 =?utf-8?B?Y3NycG1Yd2k2TlRrdXV6c1lvZWRTYUZ3dk5aZkpXRVVCK0pxcGo1TGFzS0M1?=
 =?utf-8?B?Rlc4aHJnOU53WWNxSnk4aDZjZ2IvbmlNQXdzTWVHenBTRXZhRHhtQjdzNWVn?=
 =?utf-8?B?TCthUVFCVDg4SnJsMFJRVFE3V1VHbVhERlFkZkNYOFAwN3l4b1BBYUxaS2M4?=
 =?utf-8?B?Z0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb11bf63-52b5-49cf-4792-08dc9ce4dd7f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 11:23:16.3343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ALT2yKEL6VCUC4H9tgIJwv2flHf1vXE4+vlDjBrg6Ik62XjulWOUCfkG4y7ytboKhPMIfxj+C0UpAmTzRb8p9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8657

On 05.07.24 13:09, Florian Bezdeka wrote:
> On Wed, 2024-07-03 at 18:49 +0200, Jan Kiszka wrote:
>> On 03.07.24 15:25, Florian Bezdeka wrote:
>>> There were a lot of (rtdm_)printk() calls with missing log level
>>> information. The default level (= warn) does not fit well for most of
>>> them.
>>>
>>> Adding log levels is addressed by migrating to the pr_*() API.
>>>
>>> No functional change.
>>
>> Besides the rewrapping topic below: By giving the outputs a log-level,
>> you do have a functional change. Some messages may now only appear if
>> the system is set to the right loglevel. Not agains the change, just
>> against this statement.
> 
> Yep, I wanted to make clear that there are only log level changes, as
> some of the patches are quite long.
> 
> I can rephrase that in v2.
> 
>>
>>>
>>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>> ---
>>>  include/cobalt/kernel/rtdm/analogy/rtdm_helpers.h  | 16 ++---
>>>  .../analogy/national_instruments/mio_common.c      |  3 +
>>>  kernel/drivers/analogy/national_instruments/mite.c | 68 +++++++++++-----------
>>>  .../drivers/analogy/national_instruments/ni_660x.c |  2 +
>>>  .../drivers/analogy/national_instruments/ni_mio.h  |  2 +-
>>>  .../drivers/analogy/national_instruments/ni_stc.h  | 19 +++---
>>>  .../drivers/analogy/national_instruments/pcimio.c  | 21 +++----
>>>  7 files changed, 69 insertions(+), 62 deletions(-)
>>>
>>> diff --git a/include/cobalt/kernel/rtdm/analogy/rtdm_helpers.h b/include/cobalt/kernel/rtdm/analogy/rtdm_helpers.h
>>> index 1de219f96..2adcb15b5 100644
>>> --- a/include/cobalt/kernel/rtdm/analogy/rtdm_helpers.h
>>> +++ b/include/cobalt/kernel/rtdm/analogy/rtdm_helpers.h
>>> @@ -35,14 +35,14 @@
>>>  
>>>  #define RTDM_SUBCLASS_ANALOGY 0
>>>  
>>> -#define __a4l_err(fmt, args...)  rtdm_printk(KERN_ERR A4L_PROMPT fmt, ##args)
>>> -#define __a4l_warn(fmt, args...) rtdm_printk(KERN_WARNING A4L_PROMPT fmt, ##args)
>>> +#define __a4l_err(fmt, args...)  pr_err(A4L_PROMPT fmt, ##args)
>>> +#define __a4l_warn(fmt, args...) pr_warn(A4L_PROMPT fmt, ##args)
>>>  
>>>  #ifdef  CONFIG_XENO_DRIVERS_ANALOGY_DEBUG_FTRACE
>>>  #define __a4l_info(fmt, args...) trace_printk(fmt, ##args)
>>>  #else
>>> -#define __a4l_info(fmt, args...) 						\
>>> -        rtdm_printk(KERN_INFO A4L_PROMPT "%s: " fmt, __FUNCTION__, ##args)
>>> +#define __a4l_info(fmt, args...) \
>>> +	pr_info(A4L_PROMPT "%s: " fmt, __FUNCTION__, ##args)
>>>  #endif
>>>  
>>>  #ifdef CONFIG_XENO_DRIVERS_ANALOGY_DEBUG
>>> @@ -53,10 +53,10 @@
>>>  		trace_printk(fmt, ##args); 				\
>>>  	} while (0)
>>>  #else
>>> -#define __a4l_dbg(level, debug, fmt, args...)						\
>>> -	do {										\
>>> -	if ((debug) >= (level))								\
>>> -		rtdm_printk(KERN_DEBUG A4L_PROMPT "%s: " fmt, __FUNCTION__ , ##args);	\
>>> +#define __a4l_dbg(level, debug, fmt, args...)                                  \
>>> +	do {                                                                   \
>>> +		if ((debug) >= (level))                                        \
>>> +			pr_debug(A4L_PROMPT "%s: " fmt, __FUNCTION__, ##args); \
>>>  	} while (0)
>>>  #endif
>>>  
>>> diff --git a/kernel/drivers/analogy/national_instruments/mio_common.c b/kernel/drivers/analogy/national_instruments/mio_common.c
>>> index 7cd57ecf2..ae9af547a 100644
>>> --- a/kernel/drivers/analogy/national_instruments/mio_common.c
>>> +++ b/kernel/drivers/analogy/national_instruments/mio_common.c
>>> @@ -42,6 +42,9 @@
>>>   *   as yet. Terry Barnaby, BEAM Ltd.
>>>   *
>>>   */
>>> +
>>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>> +
>>>  #include <linux/module.h>
>>>  #include <linux/slab.h>
>>>  #include "../intel/8255.h"
>>> diff --git a/kernel/drivers/analogy/national_instruments/mite.c b/kernel/drivers/analogy/national_instruments/mite.c
>>> index 2f2014bcd..736656f06 100644
>>> --- a/kernel/drivers/analogy/national_instruments/mite.c
>>> +++ b/kernel/drivers/analogy/national_instruments/mite.c
>>> @@ -41,11 +41,13 @@
>>>   * ISSUES:
>>>   */
>>>  
>>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>> +
>>>  #include <linux/module.h>
>>>  #include "mite.h"
>>>  
>>>  #ifdef CONFIG_DEBUG_MITE
>>> -#define MDPRINTK(fmt, args...) rtdm_printk(fmt, ##args)
>>> +#define MDPRINTK(fmt, args...) pr_debug(fmt, ##args)
>>>  #else /* !CONFIG_DEBUG_MITE */
>>>  #define MDPRINTK(fmt, args...)
>>>  #endif /* CONFIG_DEBUG_MITE */
>>> @@ -254,17 +256,14 @@ void a4l_mite_list_devices(void)
>>>  {
>>>  	struct list_head *this;
>>>  
>>> -	printk("Analogy: MITE: Available NI device IDs:");
>>> +	pr_info("Analogy: MITE: Available NI device IDs:\n");
>>>  	list_for_each(this, &mite_devices) {
>>>  		struct mite_struct *mite =
>>>  			list_entry(this, struct mite_struct, list);
>>>  
>>> -		printk(" 0x%04x", mite_device_id(mite));
>>> -		if(mite->used)
>>> -			printk("(used)");
>>> +		pr_info(" 0x%04x%s\n", mite_device_id(mite),
>>> +			mite->used ? " (used)" : "");
>>>  	}
>>> -
>>> -	printk("\n");
>>
>> Hmm, no functional changes...? Is there a reason to rewrap the lines here...
> 
> I just merged two printk() calls into one. Other option would have been
> to migrate to pr_cont() which is not SMP safe, so I tried to avoid
> that.
> 
> We have a line for each device now, so the trailing printk() is not
> needed anymore. Maybe I should follow the same pattern below.
> 
>>
>>>  }
>>>  
>>>  
>>> @@ -399,7 +398,7 @@ int a4l_mite_buf_change(struct mite_dma_descriptor_ring *ring, struct a4l_subdev
>>>  				   n_links * sizeof(struct mite_dma_descriptor),
>>>  				   &ring->descriptors_dma_addr, GFP_ATOMIC);
>>>  	if (!ring->descriptors) {
>>> -		printk("MITE: ring buffer allocation failed\n");
>>> +		pr_err("MITE: ring buffer allocation failed\n");
>>>  		return -ENOMEM;
>>>  	}
>>>  	ring->n_links = n_links;
>>> @@ -716,63 +715,62 @@ void a4l_mite_dump_regs(struct mite_channel *mite_chan)
>>>  	unsigned long addr = 0;
>>>  	unsigned long temp = 0;
>>>  
>>> -	printk("a4l_mite_dump_regs ch%i\n", mite_chan->channel);
>>> -	printk("mite address is  =0x%08lx\n", mite_io_addr);
>>> +	pr_info("a4l_mite_dump_regs ch%i\n", mite_chan->channel);
>>> +	pr_info("mite address is  =0x%08lx\n", mite_io_addr);
>>>  
>>>  	addr = mite_io_addr + MITE_CHOR(mite_chan->channel);
>>> -	printk("mite status[CHOR]at 0x%08lx =0x%08lx\n", addr, temp =
>>> -	       readl((void *)addr));
>>> +	pr_info("mite status[CHOR]at 0x%08lx =0x%08lx\n", addr,
>>> +		temp = readl((void *)addr));
>>>  	a4l_mite_decode(mite_CHOR_strings, temp);
>>>  	addr = mite_io_addr + MITE_CHCR(mite_chan->channel);
>>> -	printk("mite status[CHCR]at 0x%08lx =0x%08lx\n", addr, temp =
>>> -	       readl((void *)addr));
>>> +	pr_info("mite status[CHCR]at 0x%08lx =0x%08lx\n", addr,
>>> +		temp = readl((void *)addr));
>>>  	a4l_mite_decode(mite_CHCR_strings, temp);
>>>  	addr = mite_io_addr + MITE_TCR(mite_chan->channel);
>>> -	printk("mite status[TCR] at 0x%08lx =0x%08x\n", addr,
>>> -	       readl((void *)addr));
>>> +	pr_info("mite status[TCR] at 0x%08lx =0x%08x\n", addr,
>>> +		readl((void *)addr));
>>>  	addr = mite_io_addr + MITE_MCR(mite_chan->channel);
>>> -	printk("mite status[MCR] at 0x%08lx =0x%08lx\n", addr, temp =
>>> -	       readl((void *)addr));
>>> +	pr_info("mite status[MCR] at 0x%08lx =0x%08lx\n", addr,
>>> +		temp = readl((void *)addr));
>>>  	a4l_mite_decode(mite_MCR_strings, temp);
>>>  
>>>  	addr = mite_io_addr + MITE_MAR(mite_chan->channel);
>>> -	printk("mite status[MAR] at 0x%08lx =0x%08x\n", addr,
>>> -	       readl((void *)addr));
>>> +	pr_info("mite status[MAR] at 0x%08lx =0x%08x\n", addr,
>>> +		readl((void *)addr));
>>>  	addr = mite_io_addr + MITE_DCR(mite_chan->channel);
>>> -	printk("mite status[DCR] at 0x%08lx =0x%08lx\n", addr, temp =
>>> -	       readl((void *)addr));
>>> +	pr_info("mite status[DCR] at 0x%08lx =0x%08lx\n", addr,
>>> +		temp = readl((void *)addr));
>>>  	a4l_mite_decode(mite_DCR_strings, temp);
>>>  	addr = mite_io_addr + MITE_DAR(mite_chan->channel);
>>> -	printk("mite status[DAR] at 0x%08lx =0x%08x\n", addr,
>>> -	       readl((void *)addr));
>>> +	pr_info("mite status[DAR] at 0x%08lx =0x%08x\n", addr,
>>> +		readl((void *)addr));
>>>  	addr = mite_io_addr + MITE_LKCR(mite_chan->channel);
>>> -	printk("mite status[LKCR]at 0x%08lx =0x%08lx\n", addr, temp =
>>> -	       readl((void *)addr));
>>> +	pr_info("mite status[LKCR]at 0x%08lx =0x%08lx\n", addr,
>>> +		temp = readl((void *)addr));
>>>  	a4l_mite_decode(mite_LKCR_strings, temp);
>>>  	addr = mite_io_addr + MITE_LKAR(mite_chan->channel);
>>> -	printk("mite status[LKAR]at 0x%08lx =0x%08x\n", addr,
>>> -	       readl((void *)addr));
>>> +	pr_info("mite status[LKAR]at 0x%08lx =0x%08x\n", addr,
>>> +		readl((void *)addr));
>>>  
>>>  	addr = mite_io_addr + MITE_CHSR(mite_chan->channel);
>>> -	printk("mite status[CHSR]at 0x%08lx =0x%08lx\n", addr, temp =
>>> -	       readl((void *)addr));
>>> +	pr_info("mite status[CHSR]at 0x%08lx =0x%08lx\n", addr,
>>> +		temp = readl((void *)addr));
>>>  	a4l_mite_decode(mite_CHSR_strings, temp);
>>>  	addr = mite_io_addr + MITE_FCR(mite_chan->channel);
>>> -	printk("mite status[FCR] at 0x%08lx =0x%08x\n\n", addr,
>>> -	       readl((void *)addr));
>>> +	pr_info("mite status[FCR] at 0x%08lx =0x%08x\n\n", addr,
>>> +		readl((void *)addr));
>>>  }
>>>  
>>> -
>>>  static void a4l_mite_decode(const char *const bit_str[], unsigned int bits)
>>>  {
>>>  	int i;
>>>  
>>>  	for (i = 31; i >= 0; i--) {
>>>  		if (bits & (1 << i)) {
>>> -			printk(" %s", bit_str[i]);
>>> +			pr_info(" %s", bit_str[i]);
>>>  		}
>>>  	}
>>> -	printk("\n");
>>> +	pr_info("\n");
>>
>> ...but not here?
> 
> I think this never worked as expected. I will apply the same pattern as
> above in v2.

Missing KERN_CONT...

Jan

-- 
Siemens AG, Technology
Linux Expert Center

