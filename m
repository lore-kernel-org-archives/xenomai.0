Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2077.outbound.protection.outlook.com [40.107.104.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F36D17FD
	for <xenomai@lists.linux.dev>; Wed,  4 Sep 2024 16:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725466695; cv=fail; b=P1KUpLu9dqvqq9AURGxUbeBdsO1ebvpW0ZgcV487xIax/X/E4w2ae3x4cLLkwRmgLYUfg9mUYQ2QmVx1EExBSxBbyHx2UPsqOZLRe4FUMKLsz0v/JEAfIH6gRh0MPnoSZZO71x1vgqNN0wziNgc0JIFChGb2FgPcDIVoPsfIG8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725466695; c=relaxed/simple;
	bh=5YdU3LsPHD8zsYUr0GcKyRDEE40fB5SwSPzn1ADH178=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f20qwkG2Z/Qd/dxE77BuFX/YS6yEwLV8gQo1eTRMZIfswXlNmdgJN5JMJY+uYmllPjl6AieA3Rmv+8hpazhDL5EigxqQf/WrY9lM/xQp+LYFSj+wHSXBcQm5mcvdsrisuZYIfx8qNQuvNjRglSjvYauqkM4jCsBNsQlsX4Hojic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=AilGcsxY; arc=fail smtp.client-ip=40.107.104.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="AilGcsxY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=enrIwwlB81D5zkOOhvKBnGrZHwU+fjzBN3ZeJTXJAtneJWPi5Bzq/RPQNJeAjNowSRo/GFsMVzcxFEKCNA8hWQw/qp/awALH976uRru30xGzmMn8cEgoneGh/6GtSjn4uTzo1c+2vh/61QvNkYc4MMiJYE3S5fqsjGqaBrmmVG+6pxMQELSUatJJkNKnlOBXIfQiKhe3Lb+WKDM0bfhY145ndycE9E9b62Php/B4+dTuvqGHZ5G+KctZPhiK4K+TUE9lFbVOGvpL7DOE8fjYQ6pjLW15gCNvtWka5LrrI+nXxA5SAE/NAMyvz1+XSE/ULNeabePSvXegBVS6L0Gfyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qCup98q+W+0QuwP9+vyOPFrTJ3f24QivNvRMP+pSwo=;
 b=OBCP+n9lDbivbJcPD5lmb9BxuEMCL+LNWBqJyNy1JEVMW/cehDMQAio/qvprfVxFJgI2exUQXQGB5+n0zqQDGCnn1PkmfNg0Ntyn/knuefGNacFLDwrtghTDAihYDdJySPEiv2ElIB+kvqzEmZkK/TLD1dL/rm/hWtXgPBiPkDXRhQJ/ztcEVCC7J9sJBhcDlhem5YjS3d+E2h7GuenENfDNyqsqdnKTI0/PXChTXGG1IB03RvZqHPEMn5PtIq2cqAsdlYDv6yf/lXCliZJfFOH7cQqITp7qi/IPz7CB0HQfKXw1gJGfC3KXrcjP03ikeAFIsZGnzvk0bFJuJ/WAPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qCup98q+W+0QuwP9+vyOPFrTJ3f24QivNvRMP+pSwo=;
 b=AilGcsxYO6ImAjlXjprvsfwvMpYojHKYOTZ3T8tkmiaA3gmUQ1UkfvYc6sSKn/rVy+AxFeftkA4APgjxLDGoqCPEF9eIMVI0N8lE/avl1Zkzt544Uw7sgyUpb1jxlb4lb+jyMiT5LsjTVwJ71yz1oyB5GZ/bSh1ylvhM8Y26E0aK4baUjJlOo9jsS2vXufmE3jlH1Yr20PimGzS/bk45cyoen40xNmNHV+l+3bDGRJNNDhq8bz2qdtnbpdyed48MdWIESLHYD0aHy77ZPq1UARO/ftMwLYhbdFDJmr6NwOmNaJSABFrJJ2V//ZOh6wffo3Wy+hyKKsOZWIdnKqdfBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB7063.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3f1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.26; Wed, 4 Sep
 2024 16:18:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 16:18:09 +0000
Message-ID: <1a0e0318-95e5-49e3-812d-aad59fa4c19d@siemens.com>
Date: Wed, 4 Sep 2024 18:18:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Process stuck in cobalt_monitor_enter
To: "Mauro S." <mau.salvi@yahoo.com>, Xenomai <xenomai@lists.linux.dev>
References: <9d5bb262-0646-451e-a5af-82c0473a3003.ref@yahoo.com>
 <e5efbf9d-9054-46d3-8deb-aa321146068e@yahoo.com>
 <1b8ec985-8ae2-4bd2-8964-23f97cac7ba4@siemens.com>
 <CADBp9xn4OGi99e57phnv58NtCbxzO62bhrkJhSns-FUbbt4_pg@mail.gmail.com>
 <6fb4564d-3d39-4be1-838c-423a865638b9@siemens.com>
 <2d41fc43-db7d-4070-a769-bb37083cb414@siemens.com>
 <2e779a4e-ce60-4487-9dbd-7d40726b2d9e@yahoo.com>
 <0d9b6cd5-4b95-4b28-bf06-9e98d7d6310d@yahoo.com>
 <46a1ceb0-0684-4bb8-bcd3-5f71456c2d10@siemens.com>
 <0363a40f-ac3a-4024-a9bb-e37841625cb8@yahoo.com>
 <7707fef0-b164-4a79-913d-6ddcce6600d5@yahoo.com>
 <4e5fe5f2-44cb-4578-b47a-89980173eac9@yahoo.com>
 <e48a247d-db37-4c78-ae35-0d1a35646aeb@siemens.com>
 <f8361e27-2fed-4aa4-9348-bdc64760f7e5@yahoo.com>
 <6af7ce37-f6a5-44f1-9f48-18120baa831e@siemens.com>
 <12e3bbed-a0c8-4995-8320-cc6036efb0d0@yahoo.com>
 <f3493320-9f77-456c-9c57-1b35492ecac6@siemens.com>
 <4dbeb5b9-da91-4aa4-9cf2-06d6776effef@yahoo.com>
 <867f2e49-3621-49fa-a9d7-83a8093cb224@yahoo.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <867f2e49-3621-49fa-a9d7-83a8093cb224@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0305.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB7063:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c0323cf-e206-4e10-b006-08dcccfd2a66
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UTFXL0hvbDFtY3I4MzNvbklzclcxQ092VXFVNmpNYWZaT3IxMkc2aUZRTEhD?=
 =?utf-8?B?VTFBekdobEFhYURsbnhub1lqNDF4VUJjelBmOW9nMUlzN1Fnd3ZFSllGRVJv?=
 =?utf-8?B?MjFYblhOd0lSbDhkT0NnNlU2NnVEZFFKS3VOVHRIZkRSRmVVWGF1T0huaUlE?=
 =?utf-8?B?ejlaUDBhMndIdjlYcVVZSS9tQTEvNzdGamw3Nk9TbmoxMnRVT0tVT1RxelQ1?=
 =?utf-8?B?YmFLTkpSVm1UMWVDYUZFZE9DYjNSVW0vVXZxR2I2QUxwYitHYTFYSHNMMFF3?=
 =?utf-8?B?OG1zdEdaV2ZKNDdyRzNxc0YrMXJpdjRFK29WVk0wY1FDTHFLOXl1bEhDRnl5?=
 =?utf-8?B?SHBtaWREMklqRlJMWmYzZ1Q3UHhoNU1XZDBIWE9pempWbEMySE5RTFBUTnlQ?=
 =?utf-8?B?MzZBTm5NUVlDK0t3dW51bFdTQnY1OGl4OUxoZ2s5R0MyWmRxcUErRE0rNGl2?=
 =?utf-8?B?MnFNd085ZkJBWDV1U2IwMUJINENtU2lzZXQ5MW9QWFNIdkVBbkZ2L0ZsWDhi?=
 =?utf-8?B?c240MEJNRUJOM0VEeXhobkUxZ3h3VWFRbVUzalhPaktIWWNFUkFoNUY4R3BV?=
 =?utf-8?B?RitxZXpRREQrNkY3ZXlTYWh4aEhKbFhXOHhFSG9TR01GRDRZN1dyRXJhbWZS?=
 =?utf-8?B?Y1V0RjBKUnVzRllJaXR0YzJGMVFkRWh3MkUveHVJT29VWGdlYXRyUkJZSUtQ?=
 =?utf-8?B?d1JXanpEOHNTY0kwMzRMcmJjZUZmbm5xRVJHZzIraUkwdHZFS1dWbTNiamFt?=
 =?utf-8?B?SWtQUk10azFJbHhoR01VUk5TVDU1RzZjT242WEwxWlAvZ01MQ0ZwTVRQM2hv?=
 =?utf-8?B?cjF1VitJZGhZR1FGcGdiYjlPZk9KcCtkdmk1eWVhRk81VGlPNlh6YWNNdThv?=
 =?utf-8?B?a2FVbytmNzgyUFhQUjBuRzRCd3VUZFZXMG9XQS9FdFZVT1U3aFdQeWRXZGcw?=
 =?utf-8?B?cmxlZ0tEM1FieERDcytDVXA2ZlZXZm9makdPOENnbFlHa3dPNXZCZVh3QlVq?=
 =?utf-8?B?QTZweXN1SEVJLzlTS2xSeVNOR0pLajNERVNSTHJNaUhEeHVXS0dWODNieVlj?=
 =?utf-8?B?Vkc2d09SNGkyZ0VFRGVmazRSS1pjcHp5amI2dnNuZUxJdHNGaUVoZlNIUUlT?=
 =?utf-8?B?QnI2WWdhamRkM1ZtN1RpekNtZVpQWGxYOUhFeXN5R1MyNm5kbjNSVFZSTlYr?=
 =?utf-8?B?dlZrdk9kdzFBY3dDTWs5Snl3bWJTSHJJd0Y1ZnlpUmNQOHovbjhSQUM0T2ls?=
 =?utf-8?B?N0YzaE9pWHJHUW5Kd3dHZDdzQ0pEODl0U29GTk4vZExZVys3VEtuRlpheDNT?=
 =?utf-8?B?dHAyamlCVnhKcUhLRVlSUDFJYjB6dnlrcXFUVVFCYUJPTGxldmlEaFp1YVdG?=
 =?utf-8?B?UlBVemYvTDUvQlZkRFFQVlFTb2N4amVrMDNnQXVhM0N4K0hXMmRxd0Erckdh?=
 =?utf-8?B?RFp0aDMzbmhGTmgzdzJlLysrY0VxMFhsRnBwSmFjOE10RXdYYkNFV2hqdktG?=
 =?utf-8?B?L0FNK0Z0NUFIM2xEZlBVaVAzcEl1c1F6TDlGZWM2bStOWURQb29xVTVvZUhm?=
 =?utf-8?B?MEtXR242dkVLWW1JRjV3WDhoWUs2QnIrZkdtQ00yVWF2ZVBwbUJlcHlLbDZC?=
 =?utf-8?B?b0w2dHgxZVBCQTVGY2MySHNjVjMvNzFldllaVFB0SUllTThQSjgzTnFUcFBJ?=
 =?utf-8?B?L0hlZlM5bGJqMzgremgrcXc2SEtCVW1yUnVKaG9GODhvMWtZK3Vkc3hab1Q4?=
 =?utf-8?B?MlNhQVpjVW5SaUljR3dnRjVVbm03UHFodTBRSHFYVi8zYXBCNW5QSCtiSnNM?=
 =?utf-8?B?Wi9WVFFrcXJDUWVXTW1rUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NU90YVJGa0pWb0s0TnFXNy90Q3VMSXBQaXlPVzR6eEdWeXVuaTdQajRDcjQ1?=
 =?utf-8?B?eFdjME1ldkZ1dkJLZDFOR3FrSmlUa29RM3BKYmNDMG1qWXQxMlUvYngyWjVP?=
 =?utf-8?B?aFdBYkJkZnFDeW5NalIzUmQyU3J5WkwxbVQ5dkpCTnhrbGtUVlhJdk5RY29N?=
 =?utf-8?B?ZU41QVRsZ0NPLzhFazBranJhUnI4ZDRMeC9ibUdpak43N2xyYUQwVlU4bnRp?=
 =?utf-8?B?WWlhR3NsMnZlTjVJdGNtMy9yMy8xTEh0Qkl1NmNjZ2FQbmw5QVdJTW1nbkJS?=
 =?utf-8?B?ckJPTzJBeUFhdWVHcVBIa3BzY2V1SjVLYk8xR3hxdC9tSm51QVpVZFhPRmFP?=
 =?utf-8?B?S3dvem5MZ3hGNnJWdDIyTW81TU1hbUlONVVBQk1abXg2RkVxWXFQM3Z6REtM?=
 =?utf-8?B?cGJ6dGVxdFpOVkVDcllrelZsakxWbk43QjdZd0RBZUZtQnpQQXBpVUh6Ymx5?=
 =?utf-8?B?emFPNzRXVjdLbVRVUnJnQm1pQU40YWdaNmU2cTZhU2MyUWRkZzlhWmZMd1pS?=
 =?utf-8?B?eTJHbGY0MW1mdnVkc21GRzNGKzcySlpxN0tYazc0dmFVajZCaGRCTUpGVFZU?=
 =?utf-8?B?bGx6SG0zZDZMUGc5ZTNYS2tTRE1sbm9qT29wZ3JEb0U5RCtTbGhMU3pjMU5C?=
 =?utf-8?B?Z3h1TFVodG1WbXFUQjlKV2s2dWVFbWF6cVRyalVWNjd0a0ZOTkdmZlJFNk8r?=
 =?utf-8?B?RWE5R0tXNUNyRmZtNytiM0lZWVMwWXgrZnBEZWhpM2hTNUozVlN4alk3NXd3?=
 =?utf-8?B?M2daZHdvc3NSWE1PWVY5azFyL0hRZUtOWEM4Wk45MG1JNm5HOWYvYXFnWUgy?=
 =?utf-8?B?TFdITVlJSnZVWGNVNTRubFpTdE9mNTc4MDNsZWYyMy9TYmFNMGJCekVCUmhU?=
 =?utf-8?B?dEpqNnE3a0JJdTVlTXdUR09DbUJKUFVFZVg1TGhhVmZBdjRaNW5RWi9TL0t4?=
 =?utf-8?B?cllQVUk0RUtKczdkNE0xMERZRm1iYkpzVEN2OEttQ1B6SjBpT2lRdEZRUFpy?=
 =?utf-8?B?OHRONCtvSWJvN2dCZVBLQmZ3c1BLVjhmdWU0YjhyckxQYVVRL0k5a2U4citD?=
 =?utf-8?B?SFhzR0VoNDVjUDNRR0YxSDVnWkUrZ0pwMzlHbWViRlZ0Yk15a25SNnE4aHFr?=
 =?utf-8?B?dUhCNncyblo3QjFyL2k5MVlkVGsxSUtqekVJYm92a0E3WU1TZk10ek1lMmNy?=
 =?utf-8?B?alV0UmpuSy9mRGNtT1YxTUYxaWJWRHZxeU9VYTJNY0NYY00ydWhheXZ4aTlj?=
 =?utf-8?B?bER6czFZa1ZvaDA0SGZlTVppWDgrWXFUNG9hSDg0YjVtcmlVRGtKWjF4VW01?=
 =?utf-8?B?MVdVckRDZ29kRU1BTWFVd3p3M3E1QmpBWXJHbVBuQkNBeFZSR3JFNUYyQ0dM?=
 =?utf-8?B?UDdQZ3hQRnVvY08vYU93czNRckVPVkVVL2xKRFdraVN5ZHlyM1lRTnYvb0FH?=
 =?utf-8?B?MmoybmdXUWZRUWR5d3F5Yy9na2Jyd25nbjhpbDd1NjBvT0VwVm1McXNUYkZF?=
 =?utf-8?B?S2Jna0xXNUdQY1h5QkZHZmlvS1JiVytWMTJLQTR5SmFrcVplQS9XbmVWd0pp?=
 =?utf-8?B?L1QxOHhaRnVpeDF4K3FJNEwvZDQ2UGJleGpRQ2NTS3VVUi9jSVhJK0FiOVZQ?=
 =?utf-8?B?eGcwazg5aThhdm5ZYkZoQ1I0Z3BlS2FiNlhSTmJUZW1nODBydmVkQXRBS1c5?=
 =?utf-8?B?Zm0zMlh0ZHpENUVoWmtRUGtBMDluamRWV2paVmxvMkNNQjJDbkVHMFpvN1Y1?=
 =?utf-8?B?U2hWVU9iOXdYSVJhRnJzeTBBb3dKdTI5T0FkTXNXNnBuVmh3am52S3h5QjNn?=
 =?utf-8?B?aFErR2FIc2NtSG0rdWFqbnp5WmoySExiQnR6TnhuM3kyVmJNckN3VEZuMkJF?=
 =?utf-8?B?OGRGTUtZUjJQL0RMeWp3YlE2VlNsaU1haGkyMUZESjkxYUNlVzBHLzFqWE1k?=
 =?utf-8?B?TkczOUhjaTlMdlpxUlQzdWVUaTA2YWRGNFpLU0ozMU56VFViRldLS1dLbktk?=
 =?utf-8?B?cndWbDZXNkdpS2x2ckFsV3luRy85UnQ2ZWtydEZkTEJwSHpGNDZDbjhKeFN5?=
 =?utf-8?B?Ly9UM2h1dk1KQm1ybVYwRERvTWRQM2NOTEt1STVZQnBsNHpwY0hqWXdpNUds?=
 =?utf-8?B?YTlxYXhpcVlHNEdTK0xyekdXVklkTUFpWXVqMDFVUXVEYm83OTdTL2g2U3dn?=
 =?utf-8?B?VXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c0323cf-e206-4e10-b006-08dcccfd2a66
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 16:18:09.0980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hu3ciKPsPglGs7z9dH8gqDdXQslV0Ax7Sy64d+MADZSeauplZPSB9rg+Nx0dbva8x3BfwCnlC23GntjudIpSxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7063

On 04.09.24 11:55, Mauro S. wrote:
> On 03/09/24 11:01, Mauro S. wrote:
>> On 02/09/24 12:26, Jan Kiszka wrote:
>>> On 02.09.24 09:08, Mauro S. wrote:
>>>> On 30/08/24 14:00, Jan Kiszka wrote:
>>>>> On 28.08.24 16:32, Mauro S. wrote:
>>>>>> On 28/08/24 15:40, Jan Kiszka wrote:
>>>>>>> On 28.08.24 15:05, Mauro S. wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> I'm back after doing more tests also on real hardware.
>>>>>>>>
>>>>>>>> Here is a summary:
>>>>>>>> - custom image: kernel 5.4.255 + xenomai 3.2.3, built by Yocto
>>>>>>>> Dunfell
>>>>>>>> (GCC 9.5.0)
>>>>>>>> - xenomai-image: kernel 5.4.228 (and its initrd.img) + xenomai
>>>>>>>> 3.2.4,
>>>>>>>> built by isar in xenomai image (GCC 12.2.0)
>>>>>>>>
>>>>>>>> I confirm that the problem shows only with my own kernel + rootfs,
>>>>>>>> both
>>>>>>>> on QEMU and on real hardware.
>>>>>>>> Other combinations:
>>>>>>>> - xenomai-image kernel (and its initrd.img) + xenomai-image rootfs
>>>>>>>> - xenomai-image kernel (and its initrd.img) + my rootfs
>>>>>>>> - my kernel + xenomai-image rootfs
>>>>>>>> don't show the problem, both on QEMU and on real hardware.
>>>>>>>>
>>>>>>>> Furthermore, I compiled the xenomai-image kernel forcing the
>>>>>>>> 5.4.255
>>>>>>>> version and using my defconfig: the kernel became identical to
>>>>>>>> mine,
>>>>>>>> then I expected to see the problem using this kernel with my
>>>>>>>> rootfs. But
>>>>>>>> -surprise- the problem does NOT show.
>>>>>>>>
>>>>>>>> xenomai-image uses xenomai 3.2.4, but I don't see relevant changes
>>>>>>>> between 3.2.4 and 3.2.3 (mine) in code linked into kernel sources.
>>>>>>>> Then, could really the problem be triggered by the GCC compiler
>>>>>>>> version
>>>>>>>> used to build the kernel OR the rootfs?
>>>>>>>> Actually, my kernel with the xenomai-image rootfs does not show the
>>>>>>>> problem, then seems that the problem shows only when using GCC
>>>>>>>> 9.5.0 on
>>>>>>>> both sides.
>>>>>>>>
>>>>>>>> Or is it a dormant bug that some versions of GCC hide?
>>>>>>>>
>>>>>>>
>>>>>>> One option. Did you already try switching to a different, likely
>>>>>>> newer
>>>>>>> toolchain while keeping the rest?
>>>>>>>
>>>>>>
>>>>>> No, for the moment: I should port the whole custom meta layer (that
>>>>>> contains kernel and xenomai recipes) to a recent Yocto version. This
>>>>>> means that also other userspace components will change: would that
>>>>>> influence our testing?
>>>>>>
>>>>>>> But it could also be that the compiler brings in some noise to a
>>>>>>> rather
>>>>>>> narrow race window, widening it so that it becomes much more
>>>>>>> likely to
>>>>>>> be hit.
>>>>>>>
>>>>>>>> I can share with you my rootfs and my kernel and the QEMU startup
>>>>>>>> args,
>>>>>>>> or other things that could help you, and I'm open to suggestions
>>>>>>>> about
>>>>>>>> other tests to do.
>>>>>>>
>>>>>>> Problem may be that we will have to be able to reproduce
>>>>>>> variations of
>>>>>>> both in order to try out instrumentations.
>>>>>>
>>>>>> Right, I overlooked this aspect.
>>>>>>
>>>>>>>
>>>>>>> I'm also still puzzled that it takes both your self-built kernel and
>>>>>>> userland to trigger the issue. We only have similar but not
>>>>>>> identical
>>>>>>> code for both when it comes to xnsync_fast_*. Hmm, maybe it is
>>>>>>> worth to
>>>>>>> compare the disassembly of lib/cobalt/internal.o...
>>>>>>
>>>>>> Yes, this really puzzles me too.
>>>>>> Attached the disassembly (obtained with objdump -dSlf) of the two
>>>>>> libcobalt.so.2.0.0, with the two libraries too.
>>>>>>
>>>>>
>>>>> There seems to be a difference between the two toolchains in the
>>>>> selected TLS models. Could you check for both CONFIG_XENO_TLS_MODEL in
>>>>> include/xeno_config.h?
>>>>>
>>>>
>>>> Yes sure.
>>>>
>>>> GCC 9.5.0:
>>>> #define CONFIG_XENO_TLS_MODEL "initial-exec"
>>>>
>>>> GCC 12.2.0:
>>>> #define CONFIG_XENO_TLS_MODEL "global-dynamic"
>>>> (I got this from build/tmp/schroot-overlay/isar-builder-.... in
>>>> xenomai-images build)
>>>>
>>>> For completeness of information, in my Xenomai recipe I have the
>>>> following configuration flags
>>>>
>>>>    --with-core=cobalt --enable-smp --enable-pshared
>>>> --enable-debug=symbols
>>>>
>>>
>>> OK, and does the issue disappear with your setup when you add
>>> --enable-dlopen-libs?
>>>
>>
>> I added --enable-dlopen-libs to the recipe (rebuilding the rootfs and
>> the toolcain and recompiling the test application with the new
>> toolchain), but the problem still happen. Maybe it takes a bit more
>> time (about 30 minutes) but it happens.
>>
>>> But it still did no make it appear on my setup when I removed it. We
>>> might be unlucky that there are multiple parameters with the right value
>>> needed.
>>>
>>
>> Yes, probably we are unlucky.
>>
>> Anyway, the whole config flags passed by Yocto to Xenomai lib's
>> configure is:
>>
>> --build=x86_64-linux --host=x86_64-smitec2-linux
>> --target=x86_64-smitec2-linux --prefix=/usr --exec_prefix=/usr
>> --bindir=/usr/bin --sbindir=/usr/sbin --libexecdir=/usr/libexec
>> --datadir=/usr/share --sysconfdir=/etc --sharedstatedir=/com
>> --localstatedir=/var --libdir=/usr/lib
>> --includedir=/usr/include/xenomai --oldincludedir=/usr/include
>> --infodir=/usr/share/info --mandir=/usr/share/man
>> --disable-silent-rules
>> --with-libtool-sysroot=/opt/yocto/dunfell-x86_64/build-/tmp/work/corei7-64-poky-linux/xenomai/3.2.3-r1/recipe-sysroot --with-core=cobalt --enable-smp --enable-pshared --enable-debug=symbols --enable-dlopen-libs --disable-static
>>
>> Thanks, regards
>>
> 
> Hi all,
> 
> I made a "minimal" Yocto setup that allows to build an image which in
> Qemu shows the problem.
> 
> Yocto image is built into a docker container, to allow the maximum
> reproducibility. Test application is compiled by the SDK generated from
> the same Yocto.
> 
> If it could be useful to reproduce on your side the problem, I can share
> the Yocto setup, and the Qemu start script to run the image.

Sure - provided you used kas ;)
(just joking, I can translate myself)

Jan

-- 
Siemens AG, Technology
Linux Expert Center

