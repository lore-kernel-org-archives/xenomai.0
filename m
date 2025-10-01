Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011041.outbound.protection.outlook.com [52.101.65.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD50323C8AA
	for <xenomai@lists.linux.dev>; Wed,  1 Oct 2025 04:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759293331; cv=fail; b=QFWMguuwMUYKMfWcSSKtcFFGlbe3i7yG3UAF2xZDkyfGmPZyg1w4HzGnXNHshe45itoKj9w09yLW7Mg/B3c/4I+WfmWjpI/cur61i6+UxKUj3qbtIedTsU5jG2T1nMI223+dGyVNa/4j51vWKM2v7CoHY3adOJy+uWBMRq/7cms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759293331; c=relaxed/simple;
	bh=VW2Pe/gdNL/7BEVCoFnUlDQT29S2MGKKf410XD4b47Y=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=sHU0WNawT0IxC3CivNOyDg4pb81OTuxtZFw19ezoyUZsbpGbZPPvXFBIjq3rT6I8/XLGa/sUEza/EDYQTMsNDMV7wK+Xb5UmOyofQd3FUzXpW2Pf6vaD73tDdNKZUTrj6XeqZUjWJw6iwbKfZg8jLCtEV3uPqVcZWFz75Sv+Uso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ky3Yj+0t; arc=fail smtp.client-ip=52.101.65.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ky3Yj+0t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iiwqpqEk4r3l1BfEEv4h9LB3Q4/7LEUHhDlDOAoswepL6djuo+wz0CK0oRMqQBKSmvPJrxqaMSAbL3px+8dRaAB4WWv/kOS9GjiBJYGyEZ3kvHqsV4kEYQqpuNyZWcEEkraXkI91jD2R1YVKXazXzapi0zexwTsuELMvHFfahzIl5xrrigk+86JHQlVFnSrl+GVA8xNm8GwyxTZ3tSv6exuc144ecasxP+FcycuipbsXZmQ3fyQAGsC4yUOpm1YNU3jboPPzDUxLXWRKnd62GVJF/Se1Lh+r79Pcg7YB/FEcF6dSn+Fwu6CrfXSmIGg5EfmvtuESnV8AH+0yUweZow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMtW0MXXZBXUbsoe/+7R53Un19pyh9p3Mjvwg3rt6tM=;
 b=Kay+HrXVxMPFZGkCAra4V0hfKexemRjm7t4t0aVm7nTBi4/Ld7PMY11Rfg5NHU8elviBv27tqtK3+P7yncKAHsKjmrnEJKRvSYiJZDEvo44Ab360R5eojLdQnG/B8giFUgJKnzkbzrKSR3W6a5T7sIQ3+EfyEk+jhiamrl/sRqrlFvEcOnErKCoT0hS5ZY+wDtWRYOnbZWXEdRr85FJx4opIytvKvYoFH3c6jS8vwC/acfat8ZatZh0AC5+JYePS32FLGBolA8Ulo89p2sETCXkFoU3MP0lRNu/Ub6iRLrocByug/yvH4kCm4RN5+6N1ks6T60QcjFWBrNKlI+n8ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMtW0MXXZBXUbsoe/+7R53Un19pyh9p3Mjvwg3rt6tM=;
 b=ky3Yj+0tddbiiUOT7q11OWyOmWn1QYttHLCJszcvQtrA30vVIpuQbT+OE5H2dLDds4lzSQlf9cINa8MtV7zYJhXIDFxV2/9Qjtd3I7C7T2X5/abGCbcGVaDW1kVZ37j6bBoN25EaATHAtTZUaiqkIG4XaUxGVjjSMlpqkh0I7GePBbPZDOMhOHrIT1OBA56HOKvpQLPQNQM/g8coXyehvFzv8fcvD73AGxPO5PQMPc917LxBfVvEYh1mhkqR6lQtANKlnmcw+z5WHq75Q65MlgKiOWy6/v9EbP9RTCPIGqN83SZiKRC2HkeDGs6vCIJeB4jHs32WidtqXfwfaMKy4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7876.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:62b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 04:35:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 04:35:24 +0000
Message-ID: <9ab2e829-a6e6-4689-8ede-739fdb18cdfb@siemens.com>
Date: Wed, 1 Oct 2025 06:35:23 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Xenomai community call on Wednesday, October 1, 2025, UTC 7:30 AM
To: Xenomai <xenomai@lists.linux.dev>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7876:EE_
X-MS-Office365-Filtering-Correlation-Id: 2557433c-bbc4-47d5-1f8a-08de00a3f065
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TERnR3gvRU00YjhMR2RnQkNlVlNXL3dCMW1LTnhCd3A5Y2E2a284Y2pPZ0VQ?=
 =?utf-8?B?QWVaVi9qdWs5UFd2YVRpb2RKZU9ZRVhIc21DakxvbG9UcG9sWm9PLy9yRE9E?=
 =?utf-8?B?S09rTzJrZkpXaTFIcDNrT1BNdmZKSnF0Nnc0ZDc0U1NYbW1RcW5MdnQ2U1hB?=
 =?utf-8?B?VEJNdWFrdWRrT3lpaWwxMUY0TUkvZEU1N280NHVsNVJsVkhRYnFhQnJEc1BQ?=
 =?utf-8?B?TE0yMTVVRGRKaU16T01JY2tvL1pXWFRrazh3c2UyeWFENUliejFwZ1lvWVd2?=
 =?utf-8?B?VGhUR21CS2p5d1prMTNFcVlFNEtjQ2EwcVhsSXJqbTA2d0FYYWRleDA3R3cr?=
 =?utf-8?B?b2t4aGg2UXdxY0h3VC9mL0VTaGVteEF3Nm1qemhEQTdpOUFKbXI3U0lrMFNZ?=
 =?utf-8?B?aDB4eGEwSHRKaXJJbWVCbkZEdjExVUVGd0NYNWdVTGR6YnY2Sk41MS9DdDZR?=
 =?utf-8?B?RzNZTEdVcEZsbkx3c1ZNYXliNUhzWC9oZk4yR2Nxa25DVUR5YUZ3a2pUTGZ6?=
 =?utf-8?B?K1NKZzRBTit1Zm1pc2dwcHdFeHJlK1dCdjN3K005RlBIQ3RwUE5QRlIyS3Vv?=
 =?utf-8?B?Rlk3REIraTA0QldyZVBCRGcrTGF5QnpEa0tSaWdnay9lRzFlVFc1RHljaUJ6?=
 =?utf-8?B?QkptWkR2bHJBclRVUjBmdy9iai9VVzQvdDdHVDR4dU1lWU5BbC80ZStOQjJK?=
 =?utf-8?B?NmtaNDhLUzJoK1g4ak0vM3k4bXQ1RUZTV3BUSTl1N0ZsQmdnbFJURmllRkll?=
 =?utf-8?B?NmswNUJrTUUrT25OR3o3a09JS3RISDBkTkoyV3VTaHZCTkIvM1h4S2dxNXor?=
 =?utf-8?B?eGxSZWtrNlMwelRncXlwbGFueWtzcS9mSDJxTWczcGNjVlF2VVFJYTdTYnE3?=
 =?utf-8?B?N0ZhbXN6NTdRbGdJcDNBcXZDQ091QzAvT0dqNGtUd2JmeFcvMVN0YVM0SG9o?=
 =?utf-8?B?RkRPZE54STZNb1RBampscldvWGpuQ1NMWlNsVUhwcDhxdnlPSU1xWUNuSjFF?=
 =?utf-8?B?Mmc3Vk1URVFzTEwrUE9ENnJSRzNvVXFBUVc1dks4U0UramxiM0F1VFQvelcv?=
 =?utf-8?B?ODkxK0tRcjllWWE3UTR6Ri85bnVFOSt4L2d2bE9OOU82b0pLY0s2STJSU3NF?=
 =?utf-8?B?Mjh5RWtNc1g2WTVRZFBtYm1GUUY1bXd0bHNiazVBVGduaVdrUmhKVWUzOVZt?=
 =?utf-8?B?VzhCRGcrTitBZEZRUVY4QkNQSGNaWEFVY1pvUC9NRWE5ajRsRlJvV2F0eDd5?=
 =?utf-8?B?cDF4RVdMMXFLQ3N3NFpxQWNCUDlNMmFzVUlTZXRqY1hSaUVqM21jbmFTU0s1?=
 =?utf-8?B?Mys2QUlHTCswU2NyYUI1SjluY1Z1a0hvbnFnd05vUncrOFdZRmFGZi94ZFlj?=
 =?utf-8?B?N1ZHNEJyNk8rZ0E1TVVuYW8vbFFUd3dhcG5sYmtUSFNPanRQbkNDNEUrS3Qr?=
 =?utf-8?B?c0ZnK212ZEpKU3JpTEpoaEJZdE1EaGJUWWJWZzlQUXA2K1VGeHJ6dUFlait3?=
 =?utf-8?B?SUVRUDdLODJIazhkdzFFcis4YllIdWc5dXErUWlJVVN4QTRKVXVmVHdtTU5T?=
 =?utf-8?B?RkxkRXNCenNoUldYUlN6ZnFiSUJRV2hGL2tQcXdXMWhXS3g1eVlIWnBQT09Q?=
 =?utf-8?B?Wm1HYVdhYzkvc2hmeUxHWE1vN1pXcDBXMXc3RmU2dW5iamFabExxUktabUFR?=
 =?utf-8?B?Y1RSaUs4bzNWb0tCOERpSjhmU3Q4Um8yeEFFbFhONjlKaWF4M3hIaWpuUHBw?=
 =?utf-8?B?OGMwTDdVRnAvaWxvQW1FWVZtcHFZc1l6cnNiL2RCV0Mwc0luWStvVlJGY3hH?=
 =?utf-8?B?K0w4Y3l6S2I3T1JzaFBIZ2lvUUQ2WW9QUlNuOFN2MnRsOE9RM0JMOGpCa2RH?=
 =?utf-8?B?ZDVqR0JrR2ZyWHIrV2FtZFlUdmFYSlh5M3lzbVhBV1pEaTMvWVFsTFQ2L2tC?=
 =?utf-8?Q?+cW6BnLJAhWgA/pcwboX8Qe9ykLMvIrK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjY1N1ZPOW1IbENta2Q1cXlOb3RGT294RE1TczJzVHE0dkh5WlQ1TFV5QmZl?=
 =?utf-8?B?L2E4eTdEbHlCMGtpTWdJeGJEOFNLYmxoRk5sSVhWbFc4TFhQc21pd2V3d3h1?=
 =?utf-8?B?Y0Jla2diZlVNQU1uN2g5aUNNVVF1RlpQQy9VRi9rQmd6SG1YRENRa2JzVDh5?=
 =?utf-8?B?czc0dlphS21uNENZUDVTOE80SlFuSVlMSTRsc3krWllaM2lTbjZkVVAydVVM?=
 =?utf-8?B?TUFLY3lrdTgxZDhPZnRoVGVYTFhJa1J2cnUxNjRnV0p0QzM5dkZzNTU1dDh5?=
 =?utf-8?B?c0htR2lIYTdXOTJpMVI5Y1VFRFowU0FMbWU2dnBJTG1yRktPdkN2azJNcGk2?=
 =?utf-8?B?Z2lKZGNWRnU1UVJTY0daQlpVUFgzU2ZTZ21ZTnFCZVN0RXNKc2ZIN05vd1JD?=
 =?utf-8?B?RDZYNStnZWFZWkluRnYxZ3lhUVViVjRxK1hvZTdqQVdxeURweWdBK1IzUVhL?=
 =?utf-8?B?NGFqVXRicktqTGl0ZCt3K2ZMVGltN0xXaEpQU25pZ1A1QTVWZk5RaEpBb1ll?=
 =?utf-8?B?SlhlWk5ZYTZtZGtxVmZLT3ljYWJJUWVNTmR1aG9tbGIwemtmSGFWYXJrczh4?=
 =?utf-8?B?WmxBc2N2WUhLenlHcll5d083Ymhub3lyMUtEUEJ1aXM4UHZ3QmF2WCtlVUc4?=
 =?utf-8?B?U0ZJQThHS2g3OStsL20vbmFtT0FTNlA2L3ArKzBEeEVZQjlXa3o0aEt3eDM4?=
 =?utf-8?B?bWhKSVNRVGF3WWdyRTNXT0s4RThUajlOaVhrUVpqcnVMcUFncnJRYWFlZWYy?=
 =?utf-8?B?OUpoY20yVjhSNXBkYktoUlRRS2tyYi9pRjNUYzBwY3pNeUp5alNTTkJ0c0ND?=
 =?utf-8?B?aVBMM0Q4YXJtTFR6NDlOVmxRVS9OUWxKb3ZlZXhGcDlFd1Z3aVdmeUlzaFY3?=
 =?utf-8?B?YmxNbzBEbGl5VVU2ZSt0S0tjWlpnQklkeDFoSGpnS2l6aFI4YXQ0cE91R0dz?=
 =?utf-8?B?OWlkVGFkSEdoYW92MUlsZkVLcEZIZndmcEVmdkkxOWlYeUtJN2d4bE8ydWdX?=
 =?utf-8?B?VzZrYWtoMk8yRDlud2hzTktOVlFiMWFYZXRLc0lRT0t1bmwxUjZqc1RGSitm?=
 =?utf-8?B?bjFxbzBvbmQ0aHFDTXFnRTRJUk5wNC92MHo3WUhPNXRQcDdWdnFnZmdqUWZl?=
 =?utf-8?B?dkhYWHFMeE5XVTJZQ2tFSkJ5UEpEVUFvVDZTbTlEdGxNTGRObklnaXhoaldO?=
 =?utf-8?B?dWgxR1o3VzY1VWNlY1JndjhkWlN3aU5WNkdJeTRsRi9HQmU1dEdnREZCWFNS?=
 =?utf-8?B?OHIrNmVPRTRrRFRVREFJdmxNT3JWOFFrYkZpbENxbkMzTk1DOXA5d2tyZFVP?=
 =?utf-8?B?SmhGZm5lL29wcEQrVVZTaTZVejNHeXdnSGU1dFV2V0F1VmZUN1JFQUVSRUFE?=
 =?utf-8?B?MWVVUXNOMFZ1WGZWNEV6MU9WblFDaGFvZmd0U0dlYmtPckZXRDBMRE4zZXl4?=
 =?utf-8?B?YTk5L3lKcnFtNmhvZy9YbUNJVC8rdzlQcGxzNXRQamVXcWpuSzNDTkoweEJB?=
 =?utf-8?B?Vk5LV2VIbWZpRHV4ZVF2VWRmR1Y5L1ZLNmhKZ3NkbnBTT2hITEdlamtwOER6?=
 =?utf-8?B?aWVoaFZXOCtrNzd1NmJpemVyNnMvUzBnakF1OEFScEd1ZFptN0FhMmlLSW11?=
 =?utf-8?B?elozcEFqU0k5c0lMenBsazNwa2dSUXZhRlloUGFZdmQ0ZUdFMDdGYjNUNWdO?=
 =?utf-8?B?R0piUytqYXdvU1dQNXNkdXdpZkVZWXdBdmlLNzJkd2RrdWFLTW11ZVU1ZTV3?=
 =?utf-8?B?ejNydUMvQ2NCeWgxa2duYTJha09xakVLVkdzTmhmMHNXeUhkcEZuSGRFME91?=
 =?utf-8?B?NEhqV0hPWGZZQk9USERYRlF1alNieHZSRldta3JnQ0UrVWlNWTZkeFV1dGJS?=
 =?utf-8?B?c3ZKc2w0dFVIUkZZQUdxTnd0Z05hcHpnQ1F5cHFGRFoxZ2tVQllJdFJ5RW1W?=
 =?utf-8?B?dFpiRkRBa0V6T0xhcVpZTUJLT3l2SnpzRU1YZ1BRVVgxaE04bUFYZGlPeGtq?=
 =?utf-8?B?S3JmMXFzNEhQQW5pOC9oYy9SSTFaVmdUZCtENnEzNFRlMVM4eWlUTXhWTEEx?=
 =?utf-8?B?ZCtHRkVUREp6WTlhUTM0bTJqQkxncG0rSWViU0tLZitibitwUWRkdDdKYTlz?=
 =?utf-8?Q?jcoqNTDuZtIWTTT+ZAhicFEqi?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2557433c-bbc4-47d5-1f8a-08de00a3f065
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 04:35:24.8097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9dAdlP6ooLipJdWfTJ8UmqqSLrCoh9aX+Bzx0VCVnaIX+V5AEHDeVn1LUZVYxTmJCJkQpd3hS5bcnshUMq5S4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7876

Topics may include but are not limited to upstream/downstream project 
plans, status updates, and technical discussions. It's an open online 
meeting that anyone can join and ask questions (you may have to wait for 
the organizer to let you in).

Time:
Wednesday, October 1, 2025, UTC 7:30 AM
Paris, France CEST 9:30 AM
China CST 3:30 PM

Join Teams Meeting:
https://teams.microsoft.com/l/meetup-join/19%3ameeting_NmQ4NjFlZmItZmE1NS00MzZjLTk3OWMtNzc3N2Q0N2Y2MzM4%40thread.v2/0?context=%7b%22Tid%22%3a%2238ae3bcd-9579-4fd4-adda-b42e1495d55a%22%2c%22Oid%22%3a%22058073ef-2de1-450d-b434-70a67389dcfa%22%7d

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
