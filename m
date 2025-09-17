Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011011.outbound.protection.outlook.com [52.101.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7037C2741C6
	for <xenomai@lists.linux.dev>; Wed, 17 Sep 2025 07:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758093479; cv=fail; b=DAMN264fXf/YHwU8Fiht6uutPt81ShaS2ZiPQV92YDBHXb6tpxXjo5I1Rbb80/ta5J2PEnwqB3jGy4GKHnnzhL8MmZB7hqrHgbGRc8NCcQ3NYYtMhkwFr+QJo/uVG2jy8IzOyRR9jUhW2gO25kRohCrC/5LOf2aEPj4x3zUNyS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758093479; c=relaxed/simple;
	bh=Z/2FsyysLMiaD0U+2M1cSrPybTS30Yg27u5HpLZn8vs=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=oUPgNKKlo2YhOjQJnMUhKn3iTHBkf73sA5JW0aFSA48JLPVKZfLmxnIPdErnTVMJjRTMsmHjmY3UGDHLfiSs9WFh+WCYwkZtoKaJL2N+d/O1nMTo/Ry3Ee0cJmnRcsmvcFTqajzMlx+g/ww7Y63c1Ey2UMVeBb4aGvi+hl7Xz5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=xKfNfbfQ; arc=fail smtp.client-ip=52.101.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="xKfNfbfQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t0Vv4gIAjKe721F+oPojK12Rg9FlCoD5wkczJL9/tpeCIx2ugwmNkiHWJmmsSqaZk2LnwOw3Ria4ZmY6wBqdDqxqEgEnv/Yl1crjpOwJXtseyoDgRPgMvbKfzEFxFZrDst+fjjXufsgBnaobyzD+09LEU1Jetii3RdMyc1WxZjSRG2ZlaQbw02Cy5Tz9c7+e/R9UvUVtVxXlD9h3NgyYzLseyBzvBbf4lbtCXgk28dqLr0DjKgn0hQyfJaXj+WVbGNhpisODYQWPfzeWmF890KnPRqKbmx/S587fzZ5XZcgGDy6AMEi1VLke/xAksuxNDnTeWlo+TNNAGQmXLH+KJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PaKjafyCp12Y2i7SPSi/E7seKe/dazicSr1SBOOeGn0=;
 b=TfJpfLUNcA9eYpIJsBmbdCrDgKOv/1i4b8saKAnRF7gmmkLlH0zlk4fISsFwDzjkz/tjkP2BGsx6uaXZPztDEmC0qXOGpaXjmeZGIl87I0m0yc6sbOSXt4B7/c01qPg3pFqXxmpta5JwDX7nAMzvKKhQ9kDxIVyCi+CTMlGr95/fz5XwWZxzYPyIEf8X/JFLG9EcUHfIvSiVZ39BwOg0Op7M1Lw13QpCaqjmwpyfmAsBQ4A2DyXbPsMlo/m2ra0U2s8NJrK/iaLbrJXrww1cJjI/nryTcpB+MzQk4T/c0lXwWN6hf/mIie/hYwoL57b6Dyzyz0hefzJQgBrdCNaWZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PaKjafyCp12Y2i7SPSi/E7seKe/dazicSr1SBOOeGn0=;
 b=xKfNfbfQap5XS+PeyLheB6g4bfeU3kgnCs4fCyG0eh1IShQXGNyduF22+R/SOq9sGJqObo2jlsw8lafIB46b1lCru7kOsTBjNRqimc8z/prZSl7Le9w0GqNBd4N6c/W0icSANRR0Ha01ctHhgSCJgxj0YH8sDnJTXg4Hmvg8dKC61P64rbzqkBNxxfzzUH44ACLX/pZYqVrJni7PvMZaVzMqg/UdM87uGtH0hq6o3L2WJC2eS2lZbyvr1UEVfwo3FkHR/hu07Ua3dHBUC/N5X38TZG9ac1NXoAVOzh/hNf2jht3Xjmm7nHgCdySQ6WI36uknXKt3w4r2GeQ7iT3zEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GVXSPRMB0019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:123::10)
 by DU0PR10MB5217.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:345::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 07:17:54 +0000
Received: from GVXSPRMB0019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a044:9fae:32f1:8aeb]) by GVXSPRMB0019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a044:9fae:32f1:8aeb%4]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 07:17:54 +0000
Message-ID: <8c316d3b-3de0-46d6-97ef-5b4be3f52a75@siemens.com>
Date: Wed, 17 Sep 2025 09:17:53 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] testsuite/smokey/alchemytests: Make task-2 test more robust
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::20) To GVXSPRMB0019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:123::10)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXSPRMB0019:EE_|DU0PR10MB5217:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ad2a846-8636-48d3-1505-08ddf5ba51af
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHJBNjBLTXdzNTh1VE1SK0JjcDZTOUlhcXBKdzEvYmJWNlFWYnFSSTdDOG5h?=
 =?utf-8?B?Ymk3bGZlekVBUG85QUJUemxMZVpWcklMRVQvY1NKL01qcDhKTTRMTHNQeHNI?=
 =?utf-8?B?SW13WFh6MEQ1eHRaYTRuZ3daeGcweUkwN2QzNHRiQzkrUlJtMytOVFdGcUVJ?=
 =?utf-8?B?ZjdWRmdLd3JlZmY4ZmNSaFcyM2huSXlKdXVDcnhKMmhWWlBFeERJMWc1RWRY?=
 =?utf-8?B?OU1EVjlmT1lPam85WWdBNTArZ3ZYUFVKVEpMVUNibGNGekd3REx4MHhxc1BO?=
 =?utf-8?B?VHZOUTcvSjBLMUVObWd0Z2dZc2RvOE4rbGkxYWJqcjFwRnY5dnhUM2IxQ2xt?=
 =?utf-8?B?dm9tZGFSVXlZd1RHenJDcXJvSnJuRG1BRG43OTZOOTlITFdEQzZrMWNWZDZL?=
 =?utf-8?B?R2tLTHdwbjdQTS9KU0xDdGdwR1lxd3JCU0FibU5SUmtTTHVtd3ozQWpKYnlF?=
 =?utf-8?B?RHhzdHhJYkdHTlJvQ0FBOVNwY3Zzc3RJUkZrWXZPbkFUamNMeHZXc3BrdHp2?=
 =?utf-8?B?bk1IU1p3Nm1pMG9tQ2Mzdm9MRk44eGEzR2k3ZFRZeXViWXRDeGplS0I2SGpp?=
 =?utf-8?B?V0dGUUsxNUpCNkVRdDVIUkc0RlhXakRnTWo3bjZxQ0ttQ2ZqN1BFTGNzc2hD?=
 =?utf-8?B?VFllRnlTVll4c2JsM3FtNnMwWmdRaTJrZ3pHRGR4T3BkYURtMzE4Uy9HTnNZ?=
 =?utf-8?B?QnRKay9YMDhSUzFRVDlFdC9xcmdMMUN4N0NuUkxvVEhGZ00rSUdlNnByMDF1?=
 =?utf-8?B?SFhFNFJDV1doY05RbkdUb1JNQTRTd1ZHL3BrYTdLS2ZBbTJVU0s5MG1ydTB2?=
 =?utf-8?B?MVJXK3JpMHo4cUZMQlgzWUNQV2NaVkEyRWJjOE0rYVRHSkdBK0w5dE5JdS9C?=
 =?utf-8?B?UG01eVdmUWJzOG9qeUU1dURqNnp4UFFSZzNOMlhrUGxmaDMzaXNJK3pRNThw?=
 =?utf-8?B?NndsbkhVeUgxeWdKbkNmRE91MXM1ZHEvYllRZHQyeVcvMm5sdmNYaWVuVXNL?=
 =?utf-8?B?K1JBZkpaT1VFSUpTdXFQWmk2L1gwd0pJY0JaS2J1VzdkYTIycllVazhJNkcv?=
 =?utf-8?B?S1gyczNvaHFPMEtVRUhuRW0xR3krZXdWUWlZQ21wTnpWaXY4Ym4wcS9uT1Nw?=
 =?utf-8?B?LzQ5MjBJbUgrNGVISWN1NktWeFIydmcybWlqdzhCNWVVbjFBUlFsamhoeVlZ?=
 =?utf-8?B?cThUSnRsaDJPTUJwMWRUOCtBQWZubXVzNEVlZ2M4T1IrZTZpVy9zY1oxaklJ?=
 =?utf-8?B?Q01KNFg0ZEdTRXc2V1piZXBtZ2xjR05MM1JrR1NOTllEckpFaFhkbWprbVdE?=
 =?utf-8?B?cXFrNmNNdCs0SStNcGpFTTJmZGk1UEdSR0g1NXY2V0x6WTA1RXVEL1hYSXls?=
 =?utf-8?B?VUR2NVlRQ2JITlcvdXE4bkZiM2toK1Y1Z29PYkJDZ0JYRS9JQ2Frb1BvYmhS?=
 =?utf-8?B?SHZDNGJLOGR1K3IveTdIcWN4aFc4enFwUTVzSngzNEdHS3JCYk1oVEdXTjFx?=
 =?utf-8?B?QzZrb1ZKZDZnY09ZOUUzVkZ2alZjU3BCTUduZXpEcTl3cGh3QU0xZVQrR3hv?=
 =?utf-8?B?MGV4RXMrQlljY0FZSEhjUUFDaFpFa08zOVphMlArcUdkcWx1TXdNaGFBbWVP?=
 =?utf-8?B?Q3ZwQ0RtNFFIVzFTZnRzRkIwaWh3OGc1SFBlSnBacmdHY21LSnJJVmNEU0Vh?=
 =?utf-8?B?QzN5OVpjZ0x4aWpFdEJWamVCOGlxNW5sZTdsNjRuK1V6V2VBVzJNa2VPTi9y?=
 =?utf-8?B?cDEyWStQZjBLbk5QVSthWm1hSDJLbTZVQ2M2bHorYS9kTFZ5d3lqdXdnSmwz?=
 =?utf-8?B?cUZOOW9jNllWN3NzRlByT0xCWGF5angzV24wNW5IU2tXQ1UvemU4YmswcW5Y?=
 =?utf-8?B?NEtRQ0NaYUpHeG55YUhTT1VPM09OdlVVY2VUWVZNci9JaXlYV05vNzlKYkRl?=
 =?utf-8?Q?4OHWDoSkeiY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXSPRMB0019.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NS9CS0p1bGFPVHF4ZGx5Um9oZEpMWlBkK1FPTzkreGJYa1AvWWZGZDlhM2Jr?=
 =?utf-8?B?UEREZDBWM0V6Y25HSXgycmtTSjN1ZmdJWFlSY2FsNm1NamRONVkxSVFnRnJ5?=
 =?utf-8?B?dkpTNEtVeU1YSzVQYU5GQXhSNDZSaEpiMXpLVVRyN0xORlJMRzVZTWtuN2pH?=
 =?utf-8?B?YTJkTS9IeFRnNU5zMHFiR215NG9JbzBvaEs4Q2R0UWJqRW13OEFCOU1aQU91?=
 =?utf-8?B?OEtESjlSQ0V2Q1lKb2RaT29aSkhNNWRZVzBuaGtqdVVWV0pWaC9Zb3RYdG1p?=
 =?utf-8?B?c1Bvdkw3Wm5yK1gyKzdLNXUxSWxHODhiUXM5ZGlWQTU2R0k2Zjd4Yjd3cWhP?=
 =?utf-8?B?cThSZnFKWVhOQlRNdHJhUFEvcmtQS0duM2VCVFcwRS9OK1psSXhiUkJ4NWlD?=
 =?utf-8?B?Z3pFbXV4SFA2a2ZUSkVESFRISWpOUHd1eGRnTVVpb1J1Yjd6bER0OENUazR3?=
 =?utf-8?B?VWRtajRpb2orRzV1WnZLU2FGdnVDK0VwZ3hXTjZYTTA2b1Q2TzVWRFc2dXkx?=
 =?utf-8?B?L0pHUU0wMW9iOHFhbzFOaDRVT3prSHhxSWVlNVlUb2tSNkwwbXdlTEVHam9a?=
 =?utf-8?B?MGZDYk1zUlgrWVd5Y1ZGNFJhVU9EbW90bk9DdmJRb00vd3dibVNZbmlmRm92?=
 =?utf-8?B?RFdHK3YzT29taE0zZVFZSXhEWlJpNllhUUhrTUg1ajAvQk96TkJVb0ZqM2FB?=
 =?utf-8?B?RjJqSnZsUkYzSkxTbFN2QkV1MjVZQXExTkh0dVRzM3JKNWlicHJwb0YxTm1P?=
 =?utf-8?B?S2Y1ZkFST3dkY0Q4UHdUODlpbXRhUHNLM3RTWEhqOWpqRTJnMEpvaXNlQ1N3?=
 =?utf-8?B?akdoc2FvNjU3K0h4R1JPUFBFQ3FVQnREaWphanpRSW1hMFR0RHFuYlJVWWtn?=
 =?utf-8?B?OTdQKzVpNjdTZGowSUI5NlRBU2lZVkhjOGd1Vm9Jc2ZwdkxxWW1SVDFTRGN2?=
 =?utf-8?B?MHZGbkZtL1ExL20rU0d1WkRTUXFNSmt4bHdERDIzN1BWTmJFMC8wMlR0SWF6?=
 =?utf-8?B?cGd3M1Nyb3RJUjQ2QkhMSm9FVnQ5YTZKRGhzK0hmYUJmYVlpZ3RvTE12YWRG?=
 =?utf-8?B?bFAwZU5VQnd3b0htTkYzazQ5WlpWNEZGMGNSSDMwbVZ5cU1oSzd0bG1RcXRo?=
 =?utf-8?B?WXRxVld5blVlWXJHVGRMeUliQ0tzM093ZlM2Q3g4elJxcjN3TlVLM0ZZTWVp?=
 =?utf-8?B?YU1ITk1NcUtWcFdHZFlWdHBjbUxVVGRYajE0REhYQk1MMEdTNS9oWmE1azZn?=
 =?utf-8?B?Ykl5RU5HTGlwa1VYWVVJZXFhOUZGc1NaZmVYSlY1c1RMazFoSk9iOTByMGxq?=
 =?utf-8?B?SktyM0RLbnNRaUJOM1lHNXdyNEhvZTR1RHljcndLT3lYVFY4K1dmWW1DQTdE?=
 =?utf-8?B?UGlhQTNKd0x1RUczSU1sUDRNTFBDeDAxN05PMlhiRnB6RlkwUlNKdlpzd2J6?=
 =?utf-8?B?SE12b081cHF1QUN4SGJWbmZiT2hFeE1mdGdkYmhaakJCc3hUekhJM0RvMFht?=
 =?utf-8?B?b2pFdTBEVlJXUlBwaFU3S1lsS1ZUUVlPWHQxNUMxc28vVjVmNldXOW81UHpo?=
 =?utf-8?B?V2tZK0gySGlsUjliaE5jZ01vYXZEbVBnb2JucmNvSFYxd0cvbGJEY3hNVXF6?=
 =?utf-8?B?VW16Z093YjZBNUQwZWpvYTlZcEtydGc1RnV0eUgxOXk0OWNFSUdvV2xEMFBn?=
 =?utf-8?B?aDhPVW96RkhCd2gwNVRCL2lYeUdWZGJGTGN1emxMTklKVWc4WWNCeHNXZm1h?=
 =?utf-8?B?UnNPdXdaakxtUXovOWgzTDQyUEo2OFBWRlNSMzgyM3M1WnVzbE5LODdWZUlw?=
 =?utf-8?B?Mkd6dkRHV3hEY0xGWmRIZFE2YW5MaWZsOWx0RUFpRW1VTkVQZUFuRi84TTZE?=
 =?utf-8?B?KzEydlBiOHFreEhSYXJCQUYrajhqd0N2VEFEeW9adlpjOUFzUzVvWjc5bWFW?=
 =?utf-8?B?RDVqNmZrTThvemFVLyswRFVOQnE2RjRscWZGTHN5bjB1YUlUWHZQV0syMHU3?=
 =?utf-8?B?WFd3MXM2d0NXYU9lSnc1WUtMVTBobGgwQXphUHBkWmVnMnUvUktwZ2hxMkM2?=
 =?utf-8?B?alRZcmFHUnVqNHlSSzRCQnpOVDlHd0tNck10QjJpd3FURzBjSGR3QzdHQmpo?=
 =?utf-8?B?VEh3bmZ1ZzJZWk5mVEpmWDhoOTcvc2J0QThKWENXU1ZBY3JHUVRZRVJMSnQz?=
 =?utf-8?B?dnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad2a846-8636-48d3-1505-08ddf5ba51af
X-MS-Exchange-CrossTenant-AuthSource: GVXSPRMB0019.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 07:17:54.1188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nltbPEuBuysqjIpecw+KD24Kl7zhcReNQxmjeoTtm040YIRRPIsxlQvKGfT5r2Wq80XSqeOew8q+zKxAIGFlUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5217

From: Jan Kiszka <jan.kiszka@siemens.com>

The busy loop in background_task was so far not guarantee to be slower
than the 20 ms sleep in foreground_task. Specifically with newer
compilers such as gcc-14, it may complete way faster, causing spurious
test failures. Use a time-driven busy wait instead.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/smokey/alchemytests/task-2.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/testsuite/smokey/alchemytests/task-2.c b/testsuite/smokey/alchemytests/task-2.c
index 1284a8b61b..ca2225ad70 100644
--- a/testsuite/smokey/alchemytests/task-2.c
+++ b/testsuite/smokey/alchemytests/task-2.c
@@ -17,7 +17,7 @@ static RT_SEM sem;
 
 static void background_task(void *arg)
 {
-	unsigned int safety = 100000000, count = 0;
+	RTIME start;
 	int ret;
 
 	traceobj_enter(&trobj);
@@ -29,10 +29,9 @@ static void background_task(void *arg)
 
 	traceobj_mark(&trobj, 2);
 
-	while (--safety > 0) {
+	start = rt_timer_read();
+	while (rt_timer_read() < start + 1000000000)
 		compiler_barrier();
-		count++;
-	}
 
 	traceobj_exit(&trobj);
 }
-- 
2.51.0
