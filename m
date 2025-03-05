Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011019.outbound.protection.outlook.com [52.101.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7D5191F75
	for <xenomai@lists.linux.dev>; Wed,  5 Mar 2025 05:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741153685; cv=fail; b=tp8wvBO2BC8sAESOSXsFyM3D1K4cFDSFHepKEKY+vVhO6cS+xFP2jfqusd7LBLLwodw4gAI1Oln3iIQrbXjqEWSpq+oKezZRcFTXWOLC2GXUKFvxuxunBjaBEFSy3oWgJ+sh5JamnZ5nNSlK0Eu0/HmCipLq/qCb5wmeHSkjEa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741153685; c=relaxed/simple;
	bh=T4vwlLc4k/dhT1d4eMgw75nCJ3W2TK08GV27ZWn343s=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZqMAOgC8KP08LhjaDL+STwkmRptY4V6oe2BsKqs9VviMxSPLHGgGoAkGF5ISe24L4L/og5hk9A3ogYgful6cIcnHeaPJLOw2ALQF5FBVbY0J1LzNvwdE6cZ5GzmqhDMeVX5UA3bWDlEvRFxTMr6htv+KkqGHdudHVuhp2YtJv8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=BOnHthc5; arc=fail smtp.client-ip=52.101.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="BOnHthc5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P8cZ3yv5I/MTYZKAQANt/a1HSbM8blhW/gSkeALOY6bfJPZlPAlIIIkjmQ0DvQbWgxk9mGiOGz/s35BTKJYD2UCUfh3dMkPLDNswdix0CP36wu30HsgugS5kQXOpbJIt0DMPQ9Y588zifDRdBrINyxj4AnKUGeE+6vffiV5+WGdqnaiDNQ52bxZ4tg3pWtMGUyZs1GMsC41CmfwCfBiqAvsevXWg2zhcKmgcSS2/R2w+3V6Ho+WvsNzhy4+5OpbWxmOkOdAMVRPr6VupYPqiJA/vvwMJfCMxNp4MQwfSzBVeXpX4jkzKcl2rwaETZXX/Yf68RD1EzQ8FQnB7W2Je9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0rTLzM5E9Ysup8AD4mSQlDzDTpMYyjIYeE+pQnw68Y=;
 b=RQFdsXcrJhKGZpZVez1UAR8XDP+VU0GhJwIv3opCzSyFI0SCIRYCUc+O/AglbiWzwxxRtNjw/oyoAFN8aPTgCgnjoN0YAmoLyvrfjn0urwwP2C9u3V29Lfb/UnsqZjJdE9IgHyqwdlOA8odp5IFCkeai0KiqgF2CtoNHPIn6I3NZwR3GxF6KIzA0tjqFWqCvkD2yHpJAvBNXmx9JUbgOptaFS02zDxvHHgsc/MgrsNj2xg0TNLfWk6klmNRyF5BBch752+qyb65ivDACSzywDcmSnE52yxnEc7f4AIfT9CtALstGcbmdRUKCKTaHZtFCS+R7kqn4C/9OTaNwD2aFvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0rTLzM5E9Ysup8AD4mSQlDzDTpMYyjIYeE+pQnw68Y=;
 b=BOnHthc5T2l2pAf0ZMKQUo4Rkxc+S9eZw4NmYS3Iz87YZ/1eBP6WhMNyshIDMWe7FgW/9PJ7PCCBhJbmYs4DuueSLz1NdeRBVCuP5RYGJBtk+p/mns/ZCGpQA/z1m6wTnMBDVb417vrtEDEux5OR22HuczEyUbnqpgy9srP1XJ4QfoGTSy1ZN8iJX8eYWykzS90xHch96SnPojxR/NxIyO2eK2+E4gizr0GwNgit0N5WvEJFfj2y5voa2NsZwOrmBBOPwFx9GCAPeQpCSeAowhB/PjfTBHKpt0vazNuyl8Jyn2unc5maJqcaGWWHuh/j1ryjSnCYAMha11VrXei7VA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8728.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 05:48:00 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8511.015; Wed, 5 Mar 2025
 05:48:00 +0000
Message-ID: <73082b8b-cca7-46c1-939a-754307c7bcd5@siemens.com>
Date: Wed, 5 Mar 2025 06:47:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/via-rhine: Fix a build warning in
 via_rhine_init_one
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20250227120258.85692-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250227120258.85692-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0195.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8728:EE_
X-MS-Office365-Filtering-Correlation-Id: 5db580b4-5c56-4f61-49c9-08dd5ba9495c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?am9DTUR4THdNc2pTcEE4dHNYSUR5OXI4aWdYYTZGWVpPVjVRSGtyaXZWYURj?=
 =?utf-8?B?cU5wcURCWXB3Q2V3TllIZzV0ZVNhdGFsNkM3UWJYMXZwcGZlNHNLUG1iTzNY?=
 =?utf-8?B?cGFjbUpOVjk3bG82MVRyYzZrUHljcnRVUVBjZzFJbGMxSUU1bXF1V051N1cz?=
 =?utf-8?B?QUh1Z1ZnbitCdjBqcGkzT2ZCWDdSTkhFeWczc2FrekYrMk5mZjdRbFRSbWpu?=
 =?utf-8?B?UEVsbU5zcmNJdHRwNUtWZEt6OVJSbkN5dmZJd1VveFpLc0dDaCtUSk9HRWpI?=
 =?utf-8?B?b2VLN2YyT3VHRTcxQ2FkQzJtUTJLUmlPQUYvN255SFlvK0ZQRmFKaE9UYlBs?=
 =?utf-8?B?eEZLK21Iazl3UTJyTjY1VVRCTnZhRmVoUUxnL3ZaRXNZQ2RCamx1T1VOTFpZ?=
 =?utf-8?B?U2pXRW0zT1BLdUN6RnRISGZKRUlLc2dkeXZYUFlsUnhCekpLb0tJLytTWnJ1?=
 =?utf-8?B?NDVuVDM2ZDl6a1lhc3FMbGhzRitSMXlWTlVDSnBOUFEzNGs0UHUzNXZmamJq?=
 =?utf-8?B?dGo4VnhOOWs4WEJpOHFsNFZ2NmNTd2ZVMGdNbFBlM1hWb09oeldrMFdUM0Rm?=
 =?utf-8?B?MjdJalV3QkVZNmU1Z2dPRVVsZVpDZmUyNG02RUxIMmRib1FrMUNsdmROR1NI?=
 =?utf-8?B?N3JuQ3dQOFZzNW9xaTJKMDhNOENRcGZjL25YVDlQLzFHS3I1cmFVMkUvNWRl?=
 =?utf-8?B?UnZDVFJZbi9QcFdFeG5sVHd0dUg2K1VvaEd5aElqUEdyY2RsdVoxZmNYbWVM?=
 =?utf-8?B?cVM2N053eHlmaDNXNmFtYUd5NVNIMGRLUjk1TW4wc2ZYbnQxRTJxdEl2bU1j?=
 =?utf-8?B?YXRhVkh0ZzcrOVdmMGd1bWM4S1lkVGpsdCsrSHBPZmI2dXFxWmxRQjFER0Rz?=
 =?utf-8?B?ZXdXZXZrU2RibTRZbFJXWVVWWjhwN3NjaG1DYU0rQURKbm1TeTc3c3lxaVhV?=
 =?utf-8?B?Vi9GSmp5T0JxYW0xaUk4Z2VmMGtJSWZabytMelpJTEdFTkliMkcwdGMwN3BG?=
 =?utf-8?B?dG0yZ2dpRTFVQ3doSlJzYnJPblNmMXFmcVNGUlhTblNtMzdITHUzMWxZSDY0?=
 =?utf-8?B?Y01kZEcrdjQ2WFRVNkIySUJRa1E3Zjc1S1U3UmZFaDIyZU9CVTZBZHU4eFVK?=
 =?utf-8?B?V1p0Y3lYZHFXUFQwQXFjM3hOaEZZVmY1aTdNN2pIdmR4V2xkNFVaQ2hwUWJE?=
 =?utf-8?B?b0pQckkwbnhKUmh4bjZwUklENkd3aUVSZE5OdkNhSjExaU01YXlRRVZCY2Yz?=
 =?utf-8?B?M0ZvVWl2amwvQ0d6V3JZY3orYjNwM3EvdHhocjUvZjBuNmVMTFNsNW9tUkhK?=
 =?utf-8?B?b2tDamdHRklLSFRmK3pqT1I2SDNZK2xPa2Q4VkVXQ0tIMkFkMm05aGlKWnR2?=
 =?utf-8?B?YnY4VktBQTRTa0o3UU1lNVJZMlAvSUxJSFZHNzNJaHFWUC85dXNmN3VwTWFD?=
 =?utf-8?B?TElGOWg3cVNua1hDOE5maFdEcFRCM3VRNWlGbVBNZFZvajVDT0o4YjJqcEli?=
 =?utf-8?B?NlhKbjdRM1BJdEo2cE1UY3IxdmpBa3Fta3VIZk9KU0JDOURPZ3BqUG1zU3pq?=
 =?utf-8?B?Q0FtekVtc05EQmI3ZUtKVTh4RXhZRlc0THFqUjdWMEdlMlpUeml1SFJCY2xV?=
 =?utf-8?B?T3hXS2FBYU9MUjJRMytsMlJCZUtPSzRadnlVM0lLSmszZDZzMTk2TFhOZXhD?=
 =?utf-8?B?MG0xcDVhc0w0TFZ5M2p0Wmo1b1NtYTFiYXNwNlFIOTZwRnpxUmlCQ1ovT1Fp?=
 =?utf-8?B?RnV5M05BYzFEWkE1cHFsZkt2bGQxLzQ2MWR1enZybjk1Mm41ekpiUGtBZEdU?=
 =?utf-8?B?bEh5ZDFjUUcvVzN2V2NLS3FvUGJtZk5MYzk1ZWxWZ1pRZVFIRnYrbHpVZnVL?=
 =?utf-8?Q?pgb16i/vfXGyQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmVuRndyMkJCd2tudFpkSVlkQWVncTcrUFo0cEo2SzVlSHRObVFOOUIyT1c1?=
 =?utf-8?B?TDZudllZTkV3T3dkdlhxUVRCLzR1bzgzNUFUSkoyRVQrNTZrOXNML08xcGFH?=
 =?utf-8?B?dGRzWTYxZklXYjZ0c3dVaE1BK3k3c1hydXNHVGxVcHRqQzBTOWFHNTNXZ2VV?=
 =?utf-8?B?WDh6aVREbmRPaVo2NHJEL2tuRzJOeXBIOVBFYmxVY3NzbHhkaXJYUVptMHB5?=
 =?utf-8?B?a2cwOGdxakNZdE9mWldiQ05DTjhhVlhCK2x3QlRxTHZrWTRNUk1ha0JERktY?=
 =?utf-8?B?YVZVUHdObWVZSmdoL1AxbTBEcU44SWUvaU9kZHVwdDdUd2N4MmNtU1Z4T29C?=
 =?utf-8?B?TTNnUHZwUk1FVzI2MlNNb20rM1h5MS9ZelJDK0tiNjhFdVdjNFl6VTlNblFY?=
 =?utf-8?B?U1JpekkwMWZMZndCNEFFRzlkWjZOU0FQV09HMzBTbWtlT2dDcU9EbmlBdVZv?=
 =?utf-8?B?bWE2VmlkUFR6YnlKbmJsc1NYK0FmRFhjUXdkbW5UUU1lNTZwSjdMU3h5ZnBs?=
 =?utf-8?B?UzU2RXpsNjVxUXBCenNnTHRnRzdKZVlRTEsvdnZIMnYxVVBtYS9sZVZDZ3hv?=
 =?utf-8?B?bmR1UUZUSzFIOU5oZ1R2eFhYajlzREZ4NHZWQ3AwQzhJSnpsUGVCMGpWZ0Ex?=
 =?utf-8?B?aVV5enJkbU1RTmdBcVRlWmF3WXNXQnVaTnoxVC9WZmtldzBzSjE0NS80ZWxL?=
 =?utf-8?B?N2NhZWtiTUJ2YnJHV2h0djhUNHI4MGExY2JURnk0WGF0ZTFsWXE4ZkJFV0lq?=
 =?utf-8?B?N1ZCNkVLWWViL3c3Y1lnSWVkdW5JTXNlRFhmZkNGRkdsRVBBNGRMU09Ma1BV?=
 =?utf-8?B?R1FsTkZGcXZ0Q2ZVRHVWVkJaQ2xuZHpqRFZSWDQ2TlcyVHZObVdBQm9UcVJq?=
 =?utf-8?B?VzNTYjhxRDVKLzIvVXoxWmpFMHFqYVV1WnUwbjF4WE5YZUpDZVFTa05XME9F?=
 =?utf-8?B?VGdORHlseUNDNEZ0bjFBM0drQ2JSSmhSRTRmRWs5TVBjYStiaVpVOU9MUzYv?=
 =?utf-8?B?NVB0VlFRZHRHTW93cjlMclByallxMk45SlJOdnpTemNiMERuckFweDdZdTRH?=
 =?utf-8?B?N21OMjJyK1E3dmpQdDkvZGFwL1Y5WnN6ZFBiTWFFQlM1YmxEK0FnS044OW1s?=
 =?utf-8?B?ZXM4Z1hWT00yZmpRRnBMRnJub2Rpdk9NMENOQ2dmdkc0RUE2ZlR5dlFaK2JQ?=
 =?utf-8?B?a0VHeEljclBaTGdNRlU5Zk9lb1dsNnBXT3Yrd2h5YXo5YnU4eDBZREpJSlg0?=
 =?utf-8?B?Wk1GbEIrYzc2cWRTYnZTbFI2bmxSdzlYYjFpaTI0QlFDWHM1ZzJIcGMzQ0RL?=
 =?utf-8?B?T1M0UTFrblo5aUN6TU5HVjJCeXI5SVF1Y2FaNjhRTTVIZnNDaXhHNlQ5TDZn?=
 =?utf-8?B?Q05zQmR2SUhsY21xbDhEWlZPQ3kwUE8vOUthK0NteGZGbzJaY0Vkbm9SZUpa?=
 =?utf-8?B?TDdvMFZwN2JUQlNsdXFsM0dnb3p1UXcyL0xsdTY3bGFWNmRBTlJHNDEwZmJy?=
 =?utf-8?B?SDZoRnAyQTVzdXZKWXdNV1d0MmR2R1o1MlQyNGxRV0VFQTZOM0Z4cEFYazk3?=
 =?utf-8?B?cTgvUlpaRGdqZ1hMSGtvbURvK2NzVm1kWkUxbld6L1BrK05GNVJrVHRrbnZq?=
 =?utf-8?B?T3RuOSsxNGlIVm5VZDA2dEozL2N4N0pHUWZoR0R3enBBWSttUXIzc0orV3Rn?=
 =?utf-8?B?SU1pL0dLeUpGV0p3ODRrbU5NYzBURjhxYlJGZ1RqWDBPeE54RDNNSVdrd09U?=
 =?utf-8?B?dWpFUzRMQVZ0N3NYczhVcHV0cnV1YURhN2E1RTdGbmhKbkdtZnhDZmxmbG9I?=
 =?utf-8?B?TTh2QVFkVEYzQWZiTE9HZ2Zwa2JaL0NNV1RzbDZ6SFhFMGN1NzdPcUhMd3Nx?=
 =?utf-8?B?MG5JVDI4cUhmYUgvWHBlclE4bEpyN0ZGM2hTUWtXNm1hTzRZT21xZzdFUjVx?=
 =?utf-8?B?Zm96cy91V29GMDdqVXAxR29adFNQMFV4ajBRVkZEZEk3RDF0d2dsUDRzS1Mz?=
 =?utf-8?B?aWZrNmRIeVJodW9OMFpaQnBiVXFCUSsxNFBBUE5FNGxwbER5eTJpRkJ4ZGls?=
 =?utf-8?B?ZnR2ckpaU2lzVlpiNlVXbDhucG94TXZrdXFFT0g1emp0d05EWk1XTG9FQTVY?=
 =?utf-8?B?VGNOWEhYOGk3OVUyVDRkUzJYenZvWFdCeGFWQWc1ekdOL3YzaEwxaU93QmhU?=
 =?utf-8?B?NkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db580b4-5c56-4f61-49c9-08dd5ba9495c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 05:47:59.9953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sERLzbF7jyakFupP3LNmJDgwPTSAHP+PO1gh3Qy/Sl0V3af65syDvih2GjXzQpg/EJtbfGkE+QokFJ6a2o9sWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8728

On 27.02.25 13:02, Florian Bezdeka wrote:
> Fixes the following build warning:
> 
> drivers/xenomai/net/drivers/via-rhine.c: In function ‘via_rhine_init_one’:
> drivers/xenomai/net/drivers/via-rhine.c:677:18: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>   677 |         ioaddr = (void *)pci_resource_start (pdev, 0);
>       |
> 
> Inspired by the upstream via-rhine driver.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  kernel/drivers/net/drivers/via-rhine.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/drivers/net/drivers/via-rhine.c b/kernel/drivers/net/drivers/via-rhine.c
> index 9b6a40188..8aac777d8 100644
> --- a/kernel/drivers/net/drivers/via-rhine.c
> +++ b/kernel/drivers/net/drivers/via-rhine.c
> @@ -630,10 +630,11 @@ static int via_rhine_init_one (struct pci_dev *pdev,
>  {
>  	struct rtnet_device *dev; /*** RTnet ***/
>  	struct netdev_private *np;
> +	void __iomem *ioaddr;
>  	int i, option;
>  	int chip_id = (int) ent->driver_data;
>  	static int card_idx = -1;
> -	void *ioaddr;
> +	long pioaddr;
>  	long memaddr;
>  	unsigned int io_size;
>  	int pci_flags;
> @@ -674,7 +675,7 @@ static int via_rhine_init_one (struct pci_dev *pdev,
>  		goto err_out;
>  	}
>  
> -	ioaddr = (void *)pci_resource_start (pdev, 0);
> +	pioaddr = pci_resource_start (pdev, 0);
>  	memaddr = pci_resource_start (pdev, 1);
>  
>  	if (pci_flags & PCI_USES_MASTER)
> @@ -697,7 +698,7 @@ static int via_rhine_init_one (struct pci_dev *pdev,
>  		goto err_out_free_netdev;
>  
>  #ifdef USE_MEM
> -	ioaddr0 = (long)ioaddr;
> +	ioaddr0 = pioaddr;
>  	enable_mmio(ioaddr0, chip_id);
>  
>  	ioaddr = ioremap (memaddr, io_size);

Oops, forgotten. Probably because I was wondering if we shouldn't run
some cleaning round in rtnet, dropping everything that is older than,
say, 15 years...

Anyway, applied this for now.

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
