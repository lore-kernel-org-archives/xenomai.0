Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2058.outbound.protection.outlook.com [40.107.241.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B711320CCC8
	for <xenomai@lists.linux.dev>; Thu, 27 Mar 2025 09:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743067873; cv=fail; b=tlWUtqm/9g+UCpwTR+Jy5ClIH+wQ0Q+aqpdf8qr8VkINCnk3Zjt4F3jnbPry2S6SEYVIZJ15Ik0XXyoiBwr8DaKK4+L9rKsg4XNkCQnJJPe60vZgiJsjXAEW0LyOqMMYjh6yitajqcMRGvNAfECfFSFk0lYmtMfk8dySSQKtGHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743067873; c=relaxed/simple;
	bh=mMl31AKxKeFkdRPSZua+4XG7JuoAVZwu4uFlk9MlZYw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JpCQqFZZ6Q7sHlD84vtfW25S1Ym+VZNE73KzljRPVk2jvpTnysurq0CP4/T9NQFfMjEYkHEBmIlHcs36qweWh96Yf/2fEqkPKKFLZ8maP3oNJhdi4PdNs+tR86vnfq4KUDYzliY1t49TlRjmrs1vu4YR98Zj6/ckKOxWvrJkpTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=fTKgA7dM; arc=fail smtp.client-ip=40.107.241.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="fTKgA7dM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i27ImGEq4vlDnMjj6yB2fR7mCJjt3GToFqqN3xwvvoIjvxmySWTDRQ6sWCf21207CRKdR7FiYqekdULRC+RdZB3YLC1YgRD4ufIW74sw5Q0FE6tX26rEVfrL48dxHSy8m4JkzK+JvsyRqfR9qpVKLIxxVrinAn+92qadk1sfEQIFS/Ow+deU6dG9xbU6AOnRU1vWdJ4zEzedSX1Tm/xLmRr40lIoc8w9ardI1GVAlUO+LVKnPYIc5fh79hI2rd2lhb71rqnQ1Zu+tElYsKn1FFOCLMV4edHajdBczjqs54a4w+FD/KlpXLCJVnu+3gYRxbQfzeb6uwiCpvWanur3MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EqezaAODXgzpZLWu4xna1cHB95gcHJy/j/UbMI0Fg8k=;
 b=KPMxHr+dpUHDTH6RCbwb3LDg9+cUZ9L1e3ZFnTudPD0na3XGo1Cutkh8rzIqGWUI5ywcbBCdkwzwpC8baacQp9mq6Autvsrb2DkYPNjg+zE9hKvRRvCpBfZR9zVyeIUTHD3Ce7eEPnqJ4peEOgBkRJ93mGw1gADoy7sWCUsReTA8tx6vdAFy2RKGYMD0PZa1BZr1OehUSQPbJ9WQ42ugOYVwGS/c/KHYRrxy6nPA4CvId2t1VlHGJPUUjIx+9djmjr4x3ZoF9PBBVc/SJTeAaoMxjilXlCDqKCUgMuMYB8f0O4gHabbJwVmU7vTwam1TdxnmTqJF4rBpf5ya+SOuRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqezaAODXgzpZLWu4xna1cHB95gcHJy/j/UbMI0Fg8k=;
 b=fTKgA7dMDuqEFsM76RMroRfcCEDjoeNVTTS5waib6lBfwBHMCpNLqyM11FCreXj23KyVuB4s4Vi8kmMcdRjuOFxFfzfz6tuaYYyYP4N0sNyZVXbpg+IZCWoOI1QQ+F9FXo2LdJO6mSFfrPkbwEu6lMLo5l7/a+GaJl+S5NHUEm61JLJbhJy/JjHsecwFDrn1HiQ+aaNDibpAQj9EaI5fHdzIiZjUQGh3dEq0A0+ZTRTr8vd8yhuhN4mKyX/QNF+enSYvooc4B1MJ3NspN0lLJwf8qupjAnkvuAnL4qBwBIQlzem0/1YYIoVd401APG6rj3hOPwlTy0iVdsw252k9Cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6024.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:52b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 09:31:06 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 09:31:06 +0000
Message-ID: <249fe83f-0e95-44cb-a473-73b0ea4452eb@siemens.com>
Date: Thu, 27 Mar 2025 10:31:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] testsuite/smokey/y2038: replace gettid() function with
 a wrapper of __NR_gettid system call
To: Ethan <aspirestro@163.com>, florian.bezdeka@siemens.com, rpm@xenomai.org
Cc: xenomai@lists.linux.dev
References: <20250327082452.383145-1-aspirestro@163.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250327082452.383145-1-aspirestro@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0065.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6024:EE_
X-MS-Office365-Filtering-Correlation-Id: 89128afd-296e-4598-cc07-08dd6d121970
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qnk2RWhhcWRhdTNtQ3F4ZlZOYVlpTHp5ekRURHFhNUtHQlAxRTZybWhCd0ht?=
 =?utf-8?B?bEhpbGRrRDIwYmpVdEJMSkZNaSsvd28wc3RobEhKSEtrWVpzczEyUGRrS05Q?=
 =?utf-8?B?K1FIUDFML1A4a2FxTXhQcWZ4QzVsRDlCanE2SGphaHVMNlFiYWZmRS9qL0VO?=
 =?utf-8?B?eDJaZ2xRRGF1T243czZ5MVcyUzdEVzhuZXVMaWc3ZHdYcWU2d3BYYXNBOG8v?=
 =?utf-8?B?SmdpbGxIenl1VWxUNzYzTmVNc1l0Y3JnMDJTN3dsSTlvb1ZIRlZab21Telc1?=
 =?utf-8?B?V215S2tmOW1Ea1pvT2ttT3VXYnhzYkN6TGpvc0JndGk3ekNaMnNkOGFVdDRV?=
 =?utf-8?B?U1ZIUHZqVStqTVRvZDVtUmVsbDhjc012RWJ2aUZ3b0hWb0RkL3ZDQkxXTnFv?=
 =?utf-8?B?a1FlRTlKS2N6UEprbitEVVVuZ2RhTExRb0dmNXFzL1NYNyt2TDlndW9BN1Nn?=
 =?utf-8?B?M1N5RTVJU1prNHVRNnlNRTBWdnZjbDRNOW91cFkzV2R0ZzBQTHBBNkdGNTRB?=
 =?utf-8?B?S1VERnl3bFliUGF6M1RsZlRKNlN5WC9MaGtmTUxmaUlxQk12NzZtMlZaTzZq?=
 =?utf-8?B?ZUNOVGpPZzFjb0wvZ3UrWVl3REhtckxkdXlSdUwyRTcwQ1YyanZjdjNmWDdU?=
 =?utf-8?B?MGExNGoxWlZiSDZFMVVEbEFwbUpvS1g4ak9KZHIvNUl0OHV1Z0N3Z2xCVzhT?=
 =?utf-8?B?ZXhHT2F6UUc2b1dVa3NFRWtRMmtGcGxEYU51SmlEUzBZWXo4ODhpWWhwQjlw?=
 =?utf-8?B?RHdkVFpVM3M4TEY4dzJ2TVFGeGdhRVFVU29hZGVVWnl3YythL0dtc1VQWDRi?=
 =?utf-8?B?ci9VckpRbStZb2FlY2lISEIxZXllLzJqdHEyQnpSZGIyV0R4RlFobGNScEpF?=
 =?utf-8?B?a1gxaXltYzhrTThhVVl6RlFPeVFSM3lEd1Yvb0lVREdHM3BBYTAzMk1yQWN6?=
 =?utf-8?B?TmFHN1ljK0lQdjU1eG1iY1B5blFSNEtQNm1ZVWZIaTg4UUozQXRkK1c3WW5H?=
 =?utf-8?B?T1dBaDlqRm1ReEJiYTZxSkVGT1A5OHB4S2NSdVJqRjdXZ0xGMGVpQzVMSjkv?=
 =?utf-8?B?ZG1VTUREYkxUQTU5a0oxbW1OcW1EQUg2QXBUQ1E1TmE1UDV2SDVnbUpGWTdz?=
 =?utf-8?B?WkQ4ZjQxcElCV004bHdueDlCOHhFZmVtcDZYUjJzeS9zMXNtTjgyeFVrU05a?=
 =?utf-8?B?VVUzeE0xUUwvOWEydDY5Y0JkOE1hZWI1bjBpM2VTSW5PejVnWGsrMENmVUpZ?=
 =?utf-8?B?N2wzZmI2aUZVaWJxUkd3SGNLeTFRQ1IwZzhYT3pEK3F1L1dIS2llWGNEbklW?=
 =?utf-8?B?eVZJYjBNcktRejBLdEJkZnRjNkJobFdXQnF4M255R05ZZEVOeEY5bFVBSzlU?=
 =?utf-8?B?Z3ptK0VmcFVJc1dkVVhTSmMzdlNQSVNLVThuZjB0bFdhTzJocWRNRU1nc0dl?=
 =?utf-8?B?NFhHc1RtcFk5U29hUjVNZVpXNWpCWnVLNUZFR1MxRTVYM1JuN2hNZ1R3WDZa?=
 =?utf-8?B?N3NIVHZPcVBuRGxkZnlNTGJjNENocGx0UjFGRjJjcGY4RndUYStlckhCRndJ?=
 =?utf-8?B?MVM1RWVYQ0lRYSs0dmpHcktTdDhhVVpnUDk2eWRza0piNHpBQU5vVWNPTldF?=
 =?utf-8?B?UUtGMmd1dlpzRHdFYnpwR0N3NGozc3pVQ0pFR3IybEg2S28vK3YyTFByT1p0?=
 =?utf-8?B?T0lMZm1vQnU3SjNEMU10OS9wL0dtakpmUEU4d1JNcXJwRkpXUVJLTTNsRzNG?=
 =?utf-8?B?SWV3TTZzZGtheVplRUU2bWJFemMvZ0NodWVYYm9SUi80VjBIUFJhaUROeVpZ?=
 =?utf-8?B?QWU0M3ptT05IK1VDOWdLOEpMTXQ5eGNGT3RmQ1hMYUJibjRXWnRsZTNQS1F0?=
 =?utf-8?Q?lyJxM04t4pzxC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmFzd3B5MEpvS0h0OC8yNVk3c1p2cEZjbjNJY3lHdktta0g5OXVudUViNVlH?=
 =?utf-8?B?RmNmc3NHaE1VaEVha0FqQVRXQVI4QkZPQlZ5dE8raHVLMnh1cDIreUdDNmRS?=
 =?utf-8?B?S3JySStweEVZUHA5NjkrRVAvRUZqTDNVYk9RVFpMakVpaTh2VlBLSlZia2Iv?=
 =?utf-8?B?TENRYmNMb2hmU24xdTlvRHI3MzJEY1RTMFBxWVJtcGVyTTQwQ2QxL0RTdUpi?=
 =?utf-8?B?cWhtMXNBQlpqOTVhbmc3c00zUDhwTUJuTDJoSnh5RXlZQWNwS1BHUTltUks5?=
 =?utf-8?B?MjBGZXhhTXJPcnRXd2xjdVJ4a3Y2RFhjWXNlbDU4UWNoRXAwUENmS3hHZFBz?=
 =?utf-8?B?SUZtYU5NNTZHYnpzYS9EdlVhbXdwaEwxclZIWjVhbmhNdDVzMjRjQTdUbXZX?=
 =?utf-8?B?alhrR2FBYTd4dG1NNWFYcG1pZ2dQMlFxOTVuV3d0dTVKUVI1bFdJL0xsdUIy?=
 =?utf-8?B?ejlNbTFaRXFpZDFNbDZXUEFGWCtXTk9oVlNodExXOCtobUluc1NqZzhDQ3hh?=
 =?utf-8?B?NzB0YVYxb1FMeEdaN3JMVjIva0l0NzRIaVZPdzdtMmhzeElYdGRzMEJ1M0NN?=
 =?utf-8?B?S1FDNURPL3Bxb2ZHc3phVHFqME9wbGZtN0dRNXJqa3JZOFM1ODVKUlV4S04y?=
 =?utf-8?B?SGNKSW5yWWJFSDBkTmdYczdRRU1kNlRLQUluUDk3Q01xMHArdVZOZkMrampB?=
 =?utf-8?B?TGVJMG9Ub0x0WEozdVV0Z0I4dFBKaU92YW9zSlh4cHMvWmJwcFZhdGtYMGZm?=
 =?utf-8?B?dkdLTDV1UDNzcmFjc3YvaFo1dU8wZ3FzK3lBbDFPNTlzNEtwTkpUUHIrNFRo?=
 =?utf-8?B?enNxczUxVDhEOUxoOEJFVjRGWUQ1R0Z0K0FJNmVTOEJOc29jWC95UTZTVWxY?=
 =?utf-8?B?SmUxL0IwZGlvclo0YXF5TUoxQjB2UUhMdWpPdFI1UnNkOVRQWDJRQXE1R0ZI?=
 =?utf-8?B?djhPbXIzNUphdkdqYm81T05CNzFJVjhJMDF1OWhSRFpuOVEvNEtjczl4TVlN?=
 =?utf-8?B?NXpWRGoreDhPclJjZGhPeUh1WjJwNWRSS0NxZHNWcVFsZWtrTGdwcTZDSE9w?=
 =?utf-8?B?bGtrQnhLMVdhdTVZRkR5NVErK0U5ZzF2cmhrKzNKVUF0eXhWQ3htL3VPR3F5?=
 =?utf-8?B?SWlxZzZRNzcvVHc5S3RqTThEVVZXd1lIWUl1UEIrdXp0Y1BaQmVudXZKMHZE?=
 =?utf-8?B?QWJOSmROWndXVThiQ2FXS2hSZ0k4RE1oa3QwdXBpTUpKUmNUQ2U5VmEvN1p4?=
 =?utf-8?B?c3pISTBBRGZaOTJZOHFtYmd2cHJBcFExUXBjbmJheGx4SVZPb0tXT01VeDZx?=
 =?utf-8?B?QTI4V0k0aFZwdG43dERsWTFaQ3dPSS9mdi9kdFJmN1U4aDBjMVd3YmFTa1U3?=
 =?utf-8?B?TlNzZlJUbm4xNEZZZUxWQkkvOFJ2MzRYMXJUK0lVNml5bWh1ZDdLMFZUNXor?=
 =?utf-8?B?bWp5UjlMRTRxQWlJMEtKY2RkbUtYRjJRWHk4ZC9qUllwNUZlTTVCZnZPR2pZ?=
 =?utf-8?B?L1g5amlNRnNaRlZmNHhTUmFVcXlMb3oyUmZHdWdyUytVSWdoR0YzcnlnY0M4?=
 =?utf-8?B?dkJDRllOYTlNOTlEM1ZDbVV4M2tISG5jOG9JdWFPaGlIVklvcXoyNnlITGFa?=
 =?utf-8?B?M0ZLcUh2djAyTVh4Zm8vekw0VU5FS1Z1anhRVXVSSzlicWwvOFhMcG9OUFha?=
 =?utf-8?B?QmVFWS9vSmdvNUN4Z25WSzlNTS9hcGUycldkQVA1a3VkR3VPVlVQZDYwaUdU?=
 =?utf-8?B?YUxLNDNZbXk4NHdjaDNINTIyRHorckdKZXhIQTQ0UURiK1hvMUtWaUkzd1Ru?=
 =?utf-8?B?VWF5MjNveG02Y1VIdmJ3UHhjV1FwMjdxRmwrbEJONzBNM0J0eXBMVGlEeWNw?=
 =?utf-8?B?RXBnRUdLYXBiUFplUFE5Zm03VWJrRnM5d0cwcUN1eVlXYzFSQ2ZKOXkwM1p1?=
 =?utf-8?B?emQ5TXZMa1dpeitzYmh6cFhRVzNTYW1TaWRNQTB5REFqeS9paGs1UTBkeVlw?=
 =?utf-8?B?VDR3eGROSzRac3JpMCtQL2JOSk15RkhsQko5dVB1NExVM0VBT2RDOVJVNHpW?=
 =?utf-8?B?TndiL01TcTFSYVBSUFo2dHFkdWxVL3p4LzVDanRDMDZWN2ZGWkNrN3MyYzVi?=
 =?utf-8?B?dmV6YVlwRG1ubW9GM1FrWHRIVDVRWlhBRHliYnM0Qng5YzErOVRGeVFBOTZB?=
 =?utf-8?B?bkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89128afd-296e-4598-cc07-08dd6d121970
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 09:31:06.2835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nh1B0p4V7EYYvHhfuHudqT37+rZMISQ8sU+HRjCpzvRNU6DG0agbZVP6L6JF4Sxjactp36ccqgFHjRuuWk8X3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6024

On 27.03.25 09:24, Ethan wrote:
> It fails to build testsuite/smokey/y2038 because there is no gettid() function
> in earlier glibc than 2.30. The commit that added gettid() function to glibc
> can be found at [1].
> 
> The following build failure is detected when using glibc 2.27 on Ubuntu
> 18.04.6 LTS (Bionic Beaver):
> 
> syscall-tests.c: In function ‘test_sc_cobalt_timer_settime64’:
> syscall-tests.c:1211:31: error: implicit declaration of function ‘gettid’; did you mean ‘getgid’? [-Werror=implicit-function-declaration]
>   sev.sigev_notify_thread_id = gettid();
>                                ^~~~~~
>                                getgid
> 
> [1] https://sourceware.org/git/?p=glibc.git;a=commit;h=1d0fc213824eaa2a8f8c4385daaa698ee8fb7c92
> 
> Signed-off-by: Ethan <aspirestro@163.com>
> ---
>  testsuite/smokey/y2038/syscall-tests.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
> index 29e9c66c0..bb1bf0686 100644
> --- a/testsuite/smokey/y2038/syscall-tests.c
> +++ b/testsuite/smokey/y2038/syscall-tests.c
> @@ -12,6 +12,7 @@
>  #include <smokey/smokey.h>
>  #include <sys/timerfd.h>
>  #include <sys/utsname.h>
> +#include <sys/syscall.h> /* For __NR_gettid definitions */
>  #include <mqueue.h>
>  #include <rtdm/ipc.h>
>  
> @@ -1208,7 +1209,7 @@ static int test_sc_cobalt_timer_settime64(void)
>  
>  	sev.sigev_signo = sig;
>  	sev.sigev_notify = SIGEV_THREAD_ID | SIGEV_SIGNAL;
> -	sev.sigev_notify_thread_id = gettid();
> +	sev.sigev_notify_thread_id = syscall(__NR_gettid);
>  
>  	ret = smokey_check_errno(timer_create(CLOCK_REALTIME, &sev, &t));
>  	if (ret)
> @@ -1271,7 +1272,7 @@ static int test_sc_cobalt_timer_gettime64(void)
>  
>  	sev.sigev_signo = sig;
>  	sev.sigev_notify = SIGEV_THREAD_ID | SIGEV_SIGNAL;
> -	sev.sigev_notify_thread_id = gettid();
> +	sev.sigev_notify_thread_id = syscall(__NR_gettid);
>  
>  	ret = smokey_check_errno(timer_create(CLOCK_REALTIME, &sev, &t));
>  	if (ret)

Thanks, merged on top of next (please use next as basis in the future).

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
