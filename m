Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2052.outbound.protection.outlook.com [40.107.103.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137651E7C2E
	for <xenomai@lists.linux.dev>; Fri,  8 Nov 2024 12:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731068447; cv=fail; b=mv08IrvKWcGFB6rbtBN5ezjeHl6vmjVUuyi5+2xfsNkBYC7yvLf0ckJX6p0XQ9bCPal4MQTvghjuJUngNQFwnaP1v2IfWG/dmHhQLF62oSZ8Pjd0b4l0AkrD/hMUJKHMotH/j01DiAZ/POKPXA4UJ2GEUrEvZeSnZCbo469BzQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731068447; c=relaxed/simple;
	bh=qiwCHqb6+f0FH7YkELf7sH6Hn3dPeMaZDXrkkVJm9c0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fO6ChZRHW32xdYBl/n1l9cVVe7HA4m6Sh+MO0U+i+gwyIQmh9M7onKinbVNd6yGGA5Ky/nKaiUgL2/PYBOIHT+rt+ogwzvNd4wAfvKXHk0VaQ1pTAjakjxwGFEuN3YlXTxjcl4pLaDL1xu1NZrRR2VnUnlgKxayBbvMJ2T+IT9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=UodDC2h4; arc=fail smtp.client-ip=40.107.103.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="UodDC2h4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D/qwRwKViZAlSGNocq3dLVX42qG49lxp1/8kfY9xJNy9VCRQqopnD2/QulPY6lrfGRdl6bDarRTf+BnQQzy5GdZIH/PYVjovnW9H6iuINTM5K/kIE8T8IbPHshzcOvhd5usnpHRORxdI0k4y0gwDKijYUAReMZ44BXQ7jO/VGSOQNjKi4QWJhJ/0BhH38TdOkngdQ73qmmRnhepo/UhGcp8yRGBaYe4FXbNBd9N2L2jUxtnBiL82O/r6rIrmYvxjtt1G1e1TzLNfe9pBKzKvUGLE1xfAbrd17JSV87SRzrll8y/5GYPGE68SJwnlvGCkLoQr4iGGu4jhrb1UUwwz+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZZe6jkbcxzjn6yZysAO6JChqHrqDjOLt9WfJAoEVG8=;
 b=rv1TejHezQzeCB0+xQQXUD6sK/SNHMkgsfXredVFGWUS87cfB/Bs0r11FkwynEARDj1/eC2l1s6bAfQjdEjZLayjypyx1l3Mf4S0YnbzZElq+c8xPN1QPkWuvjkeENU1vlBzScWpR/cXzj9+L/+1zItCd4l/GJ6eHa1653h9QOltUlFiFWOE89UxpLYPAN2qR4pojZunhtmgQ6Zy4URIPy9rrE87gw0l2r1jkWoO2TjAy62zVreSdQ2iQgSDhIqy2kDwmpejtP4XNTH12AimNMPjbQ7CY1V49TL19jsj7oSuaSywUnF5SNxLAjkAAPU91DSdvl2pmRIe2JpMm8YcvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZZe6jkbcxzjn6yZysAO6JChqHrqDjOLt9WfJAoEVG8=;
 b=UodDC2h4xQDiBJ/ZTrdEn4zEdj0+QNiIotRtoj7KABEXglmzGcKjk5lmBYn4uZdqtCJApfEOyp8mXTf5wbn1i0Svq4MQYcKHlr+/ONkFle0AxQlLkY7UcyKHhpAnkCz7aNNfpxayxCtXPkuig1Stw3BjjypTKwjpZeJN5nuNVT1T2p534FhvNVVVFLRaVI65f7AXopcXmRcmYmELkFe4CTiKAVfHXmmT8CUhrQia1WUJufCL4BkXN9KEukhEiXZCzTO3v64ftCxo4z1ShpE4MVDXsyEoife8KF7QnSCbkCp6w7+XmzhYLdo2ly9sK3jq0SwOu/yc5OHRcwO4tgPhCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6928.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:578::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 8 Nov
 2024 12:20:41 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 12:20:41 +0000
Message-ID: <7e9410ca-ed38-449e-9cfa-1e024637c1fc@siemens.com>
Date: Fri, 8 Nov 2024 13:20:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cobalt: Remove __xnsched_run_handler(), no longer needed
 for dovetail
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20241108121450.3950604-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20241108121450.3950604-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6928:EE_
X-MS-Office365-Filtering-Correlation-Id: 323cc113-d6e1-4240-fc6c-08dcffefc2b0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2pGeTlPU0hISDhsczJNdDZDaFNSOVJJSWFCYzIxRUNJSHVHMFJLcW9yVmVK?=
 =?utf-8?B?aDRRMUZpQnVNSUp3UHZnelNnQWkvWHJjaXE0UGlPVUY3SDFoVWVqaHF1em5K?=
 =?utf-8?B?MmhOSUE4VXVvdncyWGxEOWZCeTc5YzRNMGlrd2dsYzFLcktVd2cxdGlZZ0Za?=
 =?utf-8?B?a3lyRXh6MWdhYzN5a29DRUlyVGw2aU4vb1Q5dTl3ZUlZOUQxeFFsQXg4aGZI?=
 =?utf-8?B?SHpUQzMvOUNPTFJxRUEzQlNJdU5TeGdxeHI3K0U4TktiVld6WTQwUng4ZkRj?=
 =?utf-8?B?L0ErZFRNMjcycE9YdkxYOFJRUU5xVFJGY2svclpLWXFrdnBDcG55VzBOQ3U5?=
 =?utf-8?B?emdteDNiTldybXJKOHV5cW1wSmpyS2FKWURpUllhQXpxZ3IrNi9LcHBrQmpI?=
 =?utf-8?B?cVB1ODRyS1JtQVdSTnliejVZUk83azlpTWJGRVVZbWpKQW56UEZ3L1duZGhB?=
 =?utf-8?B?eTcxb1RlZkdRalNkeTJvcnJNcnBROW1uMXJobmxhZnc1U3p0NnJQdWpqcERX?=
 =?utf-8?B?MTVVN0F6bHlZdjZkbjV3bE16OVR1Qllpb2x4c0M1cG1BZnk5UlMwU1p0aGJC?=
 =?utf-8?B?Nk9OaWI1QTZlY0RCNkgyTHh2YllOeEFlcUNoL2Ryck9mcWJZQkwzZGpCOHE2?=
 =?utf-8?B?N3EzdFJhY21NTzU2VnVWanpEV3cwcy9BTEIzbVRYUnF2bnhRTVQ0ckpDTzF4?=
 =?utf-8?B?OE5NWXFvcDVrRlEwN0lSdUZnYlcvMGw2TER4NXV1bWt6VVZsMEJrR1lGb1FB?=
 =?utf-8?B?U1FaYU5CWG94WlgwSmt1VTRNcDA5QkFpV3prUEVTRGcvVXp3eWo2Q3h6RGNu?=
 =?utf-8?B?Z3REWGVBNmZINFIycXpaeFV5OFpqc0RsbCtobVRldVVRK2FmNXUyOGVYelkv?=
 =?utf-8?B?QlM2ZzMzZTQ1OW5DVFlwL2VDVUtZQXpwNDZITHA0emEyY0RxQXBxUGhRREJs?=
 =?utf-8?B?RTVKdldTZUorMFd1a1dMSUh4bGl0TGwrcWV2Ri9rNTNwRW1jc1NkMjJqUWxD?=
 =?utf-8?B?UUp1d0VUc2VneE5hNlAyZ2o5N2Q3S0RORmNkT3NpdHJkb2hrdHRMT2UzWUdD?=
 =?utf-8?B?YUYwK2NIMitqdUxYSER0M0J6b254MTI2WDd1SGplRTE4NUZ4djlIR3NhR3o4?=
 =?utf-8?B?WStQcWtDYndnUlg2NDVIbmo1OXU2Yk5oMElsY05PSFYrYXRVL3poR0h1dXdo?=
 =?utf-8?B?MjcycVIwcVIrUDQ3YWh5WVpGdW8zdDFMS0w4WnBjWFFGa0M5aGROTTQ0ZFVC?=
 =?utf-8?B?T1FGeE1KVmlUaFI3MCtRWkRxN3N6STVxWk9obVJiLzJwQTRDZmlJRUUySjRD?=
 =?utf-8?B?MjEzNGRaSjJMMmtXRllHQkVQdEV4S0JLd2dEbHBRWDdBNlBIQW9jZGNPNzZi?=
 =?utf-8?B?TEFub1VYQmRobFFIaE9TNVZ5dStKSmdVcG5nS2ExUmUrcUcxRjFaMmVoMUcw?=
 =?utf-8?B?ZzVwdzlVMlU5UXRTOHZ3MmtZYTM0anpycEtLZkMxWGNyOXJpekRlWUlrV1or?=
 =?utf-8?B?bS9SQkxNdFhhbEtscGVJVGZzU1RPRGZ1SGhmR05UanpQSmVZa01pbzBReGpN?=
 =?utf-8?B?K0N6UWhta20vV1d0OWhybytWQnU1UWEvT1VYd3RaZTI4QysrRGRFakNtNVd2?=
 =?utf-8?B?L0ZhdGJOZDVPakpNdXByNllyWSs2b0xRMGtMZC9vYnFoSEJlNWJQem96cXpY?=
 =?utf-8?B?RXBYU2YrbmhWMWxZSThpQVhQYXVMVTZlNFhGL1Y0OTNsQWJFcncyVWJLL2l2?=
 =?utf-8?Q?K2UjwTGcnpMQHUvwrFNA2Z49mx/tRTn4EHsXJrU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVNyeGgxbXUwZ1ZGcHd2T2xsc2xRWTV5bHB0MUtCWXk2M3I0N3VmU0tTZlJ5?=
 =?utf-8?B?TGsxdGRwZ1RhSnk0aFFGZ2NjY1FCWElsUXI2bDR6YTRGR3FRL295Q2NxcTY3?=
 =?utf-8?B?RHJwT2doQlJJZkdCSDNnN2Fqc2RHR040UUN3RkRKZGFHRGxEckZ0eklxWjNl?=
 =?utf-8?B?ZTlXelcxdWxTZ3psOXBSTk9QZmd3bk9qeGlveTdlUFdvRCs5RDRWSkdiVmdW?=
 =?utf-8?B?c3AwbE9WZHBLbDJUS05id0hOeU1rYnp2OEFsSTNZUXFGOWN3SklzTVpRUXNm?=
 =?utf-8?B?aE4xMEZZekhvN0I2U3FGSTd1d1pzRnRxa1Fuait0NWFZQ0YxZjNNL0p5SnBm?=
 =?utf-8?B?dStzT2k0a0V2NzRBN1E0RXlsaTNiNW1pRUQvUGd6UmE0RXRtWFBac3BVaVVh?=
 =?utf-8?B?Q3l1U1ZQV1VGcXlLUEx2ZWF0cWZEVkdwUHgyTW80d1Byd0NoZ3RFWk5ublI3?=
 =?utf-8?B?VFJqcFNoWHZVcGhROTJ1aWpDV3h6aWdVaDZhYlo0MDhaMDd4bDFkUVNIUG1R?=
 =?utf-8?B?Y1lPK0lKS09DV2M2Skh0Zm9xZmdWUVYzY0QwajY2Uy9yUjhLcUNEZ3RLYW8r?=
 =?utf-8?B?aHNMQnhoWE90aUdaQ3JNeitTTmJiK2FmV3BrK0JhQStVb3FTcmhoVXQzT0VU?=
 =?utf-8?B?NXJJSGNieENVODZEQzZMSzRobGpzRmdPTWY1NDhLcXhLRmRmY1R1TjZZL0tj?=
 =?utf-8?B?RHRUUmRsUGlldG1ucEZvWGt6YStFNUdUbFBrU2FzQkp0dDJCZ1ZVL1Zyd0Z2?=
 =?utf-8?B?WmV3eTR5NFpsQWd4NGxRbmNOTEhKSGZjV2lRRGVBa1FrZkNPSWZ5Wm5GMHcx?=
 =?utf-8?B?aFM1MUtwTkpMK2dlcWRkM1ptTlcwTnIvajg1cW5JTGxaN1pLNzRGN24za0JJ?=
 =?utf-8?B?N0NybFNDemNTb3hXcHcyci9YWGhEN3crZ3N0RG1ycWJ0b3dHVnV0MUdCQkxL?=
 =?utf-8?B?cldkckt3MTdNS1JEbEwvWW1mUUF1ck9XKytqWTVibTNrUFlIVWR5cWZPbnZT?=
 =?utf-8?B?Y2p0TVZHcXVkbjdjU2p6RytVSnNVY21SWm55RG1NOXdEeW00RFIzYkdHWTJX?=
 =?utf-8?B?OFNkdVZpMG5IdnJtNmw1QnFROTlQdUZRcGZKRHVuRVZWVkVHVUlZemJJS2Rt?=
 =?utf-8?B?L2lMWmV5K0xvS25DTjB0QUMvN2NzdjB6Wm5UQUl5dGNzYkR5b3RNdlAwbGlo?=
 =?utf-8?B?aEVxVCs4WnFuUHlPQ2xWVitSZUFwTStuZ3VBTi9zaFJTRk53enJ1UWZrT1B2?=
 =?utf-8?B?Ui9meUpLZngzNGNDdDBzeFNOM1YrdWJNc2o5NVJFTU0vdjVOdlA3MS9NOHNx?=
 =?utf-8?B?QTlOb3BWaE9FUlVtblJoeHk3UnRKYzZtV2ZocUJaWndBd3pGZ0ZjTmRwdGk1?=
 =?utf-8?B?Yi93R1RFWTMrVjBzTTJndmxxRG40dHBDSVh4bDhyTTVSemk1bHlnbnZuSjBn?=
 =?utf-8?B?VjNrZkZ1d3R0ZUVPRHBVeXdDTmNMSURzSS9GeVAzZmFlM2ZGbDJabUFQVjdl?=
 =?utf-8?B?RHo0S28zMi93YUZJWWtsWm5uTE9oV1IzNjF0eU5UQkRVd0VJZ2RpVGNibDQz?=
 =?utf-8?B?VzUxdXZSNHY3RXkyNVIyQjM4Z1FvM1hHVEZxZFNKTG1TNCtSeFJaRTltZUxi?=
 =?utf-8?B?U0dQRWFvWjlIV3QwYm5KeVZXN25vV1ZEbWZ3ZGFocUlDSGFFYUdmZ0gwdWVC?=
 =?utf-8?B?TEJiS1JnMEt5d2dvV1JSaWQ5OHFVVjZoRnppTU9JRURheEdpOXQvQkJzYVNV?=
 =?utf-8?B?NGdwS2xNbnN5anRiR3pZd0R0RjhPR0Y2cVhnNEdsc29yMFFvek9QSWpMWnFs?=
 =?utf-8?B?THBlRHFxVmlYNGJLVWlIV3JrdVdHejE1VDVpbnl4UWtkbkJWc1pYcFo0MmxF?=
 =?utf-8?B?cnY1MlNyb3RsU2ZmdTJZU1BESENrZndIVHNJd2ViOFB4OU9pQS9salQzcTRL?=
 =?utf-8?B?bU4rcEhjVStNK09ZU0JXRXpVeFhWVUNmcGErSW5xdFNWZ0t4Nm5panhlcFNG?=
 =?utf-8?B?Ykp1LzBmbi9aUjRtei9FVnVKZVoyc21oMmptM3NGeGdsemJ2NHRYUFJTb0RV?=
 =?utf-8?B?VjA0TCs0QlFXc3BvbTh0dTUvL0sza0RyRS85ZlU4Y0FySk9VZXRnbXRTb041?=
 =?utf-8?B?S21pZjEwelJZTnl0Q1YzZHdMSU1rWHJZdTJOenp4RktMVVhRTGxLNDFjSlNr?=
 =?utf-8?B?cHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 323cc113-d6e1-4240-fc6c-08dcffefc2b0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 12:20:40.9800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9AyqGjhF5ukp2LaeAqN4/Y/V2VbnN8KHvbILmpFB77+t2aicOC1TEKRMDI5Nr38sfPXINcgvvtiyYLZLz5RutA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6928

On 08.11.24 13:14, Florian Bezdeka wrote:
> __xnsched_run_handler() was unused as the parameter of
> pipeline_request_resched_ipi() was unused as well. That parameter was
> only necessary / in use for the old - and meanwhile removed - ipipe
> abstraction.
> 
> Cleaning up to avoid confusion.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  include/cobalt/kernel/dovetail/pipeline/pipeline.h | 4 ++--
>  include/cobalt/kernel/sched.h                      | 2 --
>  kernel/cobalt/sched.c                              | 8 +-------
>  3 files changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/include/cobalt/kernel/dovetail/pipeline/pipeline.h b/include/cobalt/kernel/dovetail/pipeline/pipeline.h
> index 478580fc2..2e6e66a2d 100644
> --- a/include/cobalt/kernel/dovetail/pipeline/pipeline.h
> +++ b/include/cobalt/kernel/dovetail/pipeline/pipeline.h
> @@ -36,7 +36,7 @@ typedef unsigned long spl_t;
>  
>  irqreturn_t pipeline_reschedule_ipi_handler(int irq, void *dev_id);
>  
> -static inline int pipeline_request_resched_ipi(void (*handler)(void))
> +static inline int pipeline_request_resched_ipi(void)
>  {
>  	if (num_possible_cpus() == 1)
>  		return 0;
> @@ -75,7 +75,7 @@ static inline void pipeline_send_timer_ipi(const struct cpumask *dest)
>  
>  #else  /* !CONFIG_SMP */
>  
> -static inline int pipeline_request_resched_ipi(void (*handler)(void))
> +static inline int pipeline_request_resched_ipi(void)
>  {
>  	return 0;
>  }
> diff --git a/include/cobalt/kernel/sched.h b/include/cobalt/kernel/sched.h
> index aa24d5442..e0b4249a4 100644
> --- a/include/cobalt/kernel/sched.h
> +++ b/include/cobalt/kernel/sched.h
> @@ -294,8 +294,6 @@ static inline int xnsched_threading_cpu(int cpu)
>  
>  int ___xnsched_run(struct xnsched *sched);
>  
> -void __xnsched_run_handler(void);
> -
>  static inline int __xnsched_run(struct xnsched *sched)
>  {
>  	/*
> diff --git a/kernel/cobalt/sched.c b/kernel/cobalt/sched.c
> index 62db291a7..f1c799bba 100644
> --- a/kernel/cobalt/sched.c
> +++ b/kernel/cobalt/sched.c
> @@ -235,7 +235,7 @@ void xnsched_init_all(void)
>  		xnsched_init(sched, cpu);
>  	}
>  
> -	pipeline_request_resched_ipi(__xnsched_run_handler);
> +	pipeline_request_resched_ipi();
>  }
>  
>  static void xnsched_destroy(struct xnsched *sched)
> @@ -888,12 +888,6 @@ static inline void leave_root(struct xnthread *root)
>  #endif
>  }
>  
> -void __xnsched_run_handler(void) /* hw interrupts off. */
> -{
> -	trace_cobalt_schedule_remote(xnsched_current());
> -	xnsched_run();
> -}
> -
>  static inline void do_lazy_user_work(struct xnthread *curr)
>  {
>  	xnthread_commit_ceiling(curr);

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center
