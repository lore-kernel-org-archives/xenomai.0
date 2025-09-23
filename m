Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010004.outbound.protection.outlook.com [52.101.84.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C8330E0F1
	for <xenomai@lists.linux.dev>; Tue, 23 Sep 2025 05:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758606196; cv=fail; b=B//y4qQ5r4rS6mxcN06LJbWWJdn6C6jq8POvsSZxmdOQNHlG1yZcNMuZ2c13gBJl0nBQOZIFq+P/2v6L7Lux1zVA+2z2K/sn7C+1sEaN8Lxo4HwVdrfkSK6odYRBd9VzP5jCjLnOmyFHWhvTe1FnNwRCjZmEiLKptACjhbybCts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758606196; c=relaxed/simple;
	bh=2wGEHuPArfrzXTP1t2xv9n/0DfGGTZHZE1tvcdhMGM0=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=tXPNaIA0pmeSOFvnr4uZtl48kM+VT0WTlAcfhx8kVjkfFyayDII2oLqtUHjOpTSF6Jxlj1n0Gk0WsyoU4T84nIBgKb0U7pNzP89/tVLkK5ToH3oMW8M4a1moqK9HZxNZ83DhfoLdn2T6CFjGyxZH1+UFPW1GWhXSGQ+9p8JJ6Zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ohxdmtzc; arc=fail smtp.client-ip=52.101.84.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ohxdmtzc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xXHuSuRislJcViFSO0gN91jgUeu7ZTmS931tkD90R6f2TC9wDMZebWNKcqHWS6Lrj8LBSw39oWqI//eTrGmH+sF9GnaUX0uhhFltis6mfud1Q5geOSFyY6QHcMPOi5STwa/0VEynUFbFfKNvHSQ/Pm9uStSXvw/vXAWBaiV48vTZ95aJaWOrVbKAap5Qo5TG+wxF8uVQ7kS48fRFa7ZwcrNpFeK4Rkxt6t5OWlM3ujQBIx4R3GviM/TKNTNx40QEwyjeyKuqBv6+MwxsWS8Rq+G/RCJThr8Gn2XjwL2GwOyqmN1oscBtkdWDI8hfljpDpHxSOzEbLtkBdoahagS1pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnCWe8FKxoJwHQKIpfUD5UsgPcfRhVURhAcf+k9ULlc=;
 b=tPr7J0pyp6y20Cgv/NcUzUf/2vqckecPuIta1bfU3amS4sp9J7vGvQZpTWPZpKK/VlsUK7ZSdHwV5LVhoEmip01N1eSAZkSekBebuKBdRo0GeCQUMSRwou+UXA7NCadfsnp2zPD3TOjTR7QWbg4t/IvfhbwLFvj++rF/PdQFBa2Gn2lMfyHKbQiqGz+NOZFpHoYjdjMUvagTzLa27l6UP51SfHC+ka1ywtiJMFjMq/zI4DpssZRJiCWQNrjshkW3kE5EZy3Yp7t064UAjbnnroG1QwOEceMR4AzDXxygqSjgx1uHZ3QD/rYhexKThKBwfI8eMuQ0ybvpQVgzPC4R2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnCWe8FKxoJwHQKIpfUD5UsgPcfRhVURhAcf+k9ULlc=;
 b=ohxdmtzc0aBIobSFOIkBmh9PjnXoDga4/FNEL+zLiZ+7l/IfDrBNh56yT9qdq3iE62atpu4Km9b+gGHds+i8bFvAkXOSlfb+SPHll0i9YLevooNBOYTlmaESKnx/UKEBp0WSy2GosvoCtEqLXcE61KpDI1TCUdKHV4ESqt93oZsoasoK2Saw1i60NOM34vFlnwJkgIL5zJ/74p8shIwtFVKuXQWMKM6wRfFtfAqwvVBFszg40safjhHzdV8OV7eWHpCPteDqzDiZvOpWcl2AifTUDq2LSgNk0G5VEND0/PFApeb5Fk4ZeEPYeVERjgW2L65hqI5cFmpYT+Bqc3EWvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8776.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 05:43:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 05:43:10 +0000
Message-ID: <0d628811-9955-4fd9-90a2-27be551dda14@siemens.com>
Date: Tue, 23 Sep 2025 07:43:09 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] configure: Propagate debug build settings also to plain
 applications
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0363.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8776:EE_
X-MS-Office365-Filtering-Correlation-Id: a3cd7b47-3ac6-4d31-1664-08ddfa641457
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZCtyYWQvUXZ6UHkyUDFiKzhWZGJiVUNmV0FGVGlZMkJweUdtN09WUUtPVkww?=
 =?utf-8?B?VUptQVN0ZEM1R2NodDBjMVpLVVVFcmhLTk5iSXRpdnhIUUEwaitvRHNzamM2?=
 =?utf-8?B?WGRoM0NjM3RnSUFzWVVPVlFjdW9teDZXTXRIT2ZXbkdTaWYwYWphTnR5QnB3?=
 =?utf-8?B?S0pSNTZ2OE5aWnYzU1VtbU5KT1JzL3grZXJYaW5LMFhuRnZsS2RWTVBLdnpu?=
 =?utf-8?B?ZkdNSmNYOTdnNGN6TjJVOHB4Nk5WWHF6MGVQSGE2MDA1WU1udVUreE04MHRX?=
 =?utf-8?B?OHBaQjgyZk9pMkd2T0pxVW5pK0JwZEEydEI1RHIzNEdtblVFWC9rQjhCVVVa?=
 =?utf-8?B?TFFKbUF4V3JmdnkxZnJFbjBsR1JLRk1Bdk5XZVVkQ3I3TFBoU21DdXA0THZY?=
 =?utf-8?B?VHBRR1p4QkhhcWlHNSt4Rm1MSVJOQU5FSkR0L2lhOEp3WTRvcWo1d3R1S0dP?=
 =?utf-8?B?YUw4ZlVubHBNay9UTVU4YWtMZU13RXdkck8wQzk1ZkJ0RlNNUlpMUlgxeGEy?=
 =?utf-8?B?SHRPVUpYc3pFQmVCZ1FWOHQ4NnRjU3pFbG9qZkptelc2Tjh1TEFTOWVSZGNh?=
 =?utf-8?B?WkxsYmMvMXpxd1l0WkxJUFBXVjFZT0oyeDk3ZFZlRy9saFdEMGtISXVuTTJK?=
 =?utf-8?B?Nnl2WFhqK251TjV1TEE4dEFRWVFRRUJhU2hPcEF0SWd0SFQzQVB1aWFYYjlJ?=
 =?utf-8?B?d3hzN2E0WGNXZHJhNUlXbG1NM2lpcFJ3dkRMbmxkb0ZwRFdnSnlnNEpKSzZ3?=
 =?utf-8?B?S3RySUM2eUR5RU5QTHRrQ3gwa1A5TjQ4czkyd2hSOXVJUmhEd01VOUEzTmNh?=
 =?utf-8?B?NmlnK0k3cTZGakJSMTQwNnV3dWhNdjZEd1Azcm55cVJhZTAyV0tadFFTYURX?=
 =?utf-8?B?MUc3bFJHOEJRdG80S0VROHdDNUxwbzNhZjJVWE12dUJ2TXVlWElSdDE0Rk95?=
 =?utf-8?B?UXpONlhjMFBuV2JKREtKTlBCdmZrRU5pd1V2dGcyaC9QYWhZa1B4a25kSURa?=
 =?utf-8?B?L3g1cTFKRUZRNXNKL0ZzaHdmWGFqTkZxNjdNUXFoRDNQY25SVFpzeWhLWmhj?=
 =?utf-8?B?dzV5M1NuaG5oTDRRU3g1UVhSMWFoMWw0Vll2WFFPZmJhVGZQdG1mWEJyTnZk?=
 =?utf-8?B?RCt6c0toZGdGeUZ6cGt6VDdrNVhQQkNKT2FkcnJUa2ZRV2RuZUhNYUNBa1Rq?=
 =?utf-8?B?TmlPWEg5dlAzNzM0ZDh0Z2J0ZGVya2UySTRYc0FybUp2dHR5cEVEUW1RMm9Y?=
 =?utf-8?B?MzBGWjNXd0MvU0dLWS9CN0NtSmdWN2l3Sm9WSFdRQWlzRUZnMGJVd21YOXEz?=
 =?utf-8?B?Z09Pb3ByTzA2cG4xNGRXZXVVSkNSeXdLdUtwZ1pPbENJWk1wMWpJVzJCZkF5?=
 =?utf-8?B?VzNmcVM4ZVNSOG5VNzg4alVMNGg1UXY0OWd1VWpoMnVNdzdHankwN2FtS3Rz?=
 =?utf-8?B?WS85UGFkRE9aUVdDaS90VDRab0orVGQ2QU1nV2p1NjFBOUhwQ2lKaFdwYTJz?=
 =?utf-8?B?ZlZCeDNOdE9abWFpL01jcEhSd1RmRVNjSi9ZbU1NWnpIUEg1Ny9XVVZZSmlh?=
 =?utf-8?B?cmxiVGVYaml5STNOek9OSklJRW1lcUZGSE55eVpPN3ZFZnFHS2M4WjM0VEhs?=
 =?utf-8?B?RVN4QlVpdDdEaEtGWnFCK0tPZjkxcHdUU1NqeDh6ZzF1MVFIVENzQlQ2SFFp?=
 =?utf-8?B?d2hOS0RoU0ZrUHY2Rmkybjg1WHZjajFBV2lWck1Td3BpaXo3NjR5R3pUZXVv?=
 =?utf-8?B?aFptNEp1UG1UakU0dVkrdUp3bWM3V29ybEJJdG1vS21WU1JoeGZEUEozTG9k?=
 =?utf-8?B?T2xQVDkybE1ISGpsSiszRU8weVIxdXVMZG5nb0xFT1FaNGkwNWEwNkZacWhl?=
 =?utf-8?B?MHlvS2QxaEU5ZzNRMGJLbWtjeURRNjl2VlJQaU5SK21IY1NMM2VyVGdwa1da?=
 =?utf-8?Q?HU6RNxbxgVI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vy9BOFVwZG56eXhhUjJTcFJyaE5BWmVlcy9mT0lFMldxVnhSL2hEZUdUNC9T?=
 =?utf-8?B?MjJhVnRBUFJPc0xBL01NcTJVWXg2UjRCWDQ3Ny9EZTFsTWRwSFRMU1ArQ0Js?=
 =?utf-8?B?azd0UTkvZlZuTkl5c1AxNW00Q3lHTmRBYkN2b1gzbXRXZmJWTEtCQnNkaTZt?=
 =?utf-8?B?OHlLQVpBZ1REaG9vYnc1aDVvWW1mZHlPNnJuYXZEdTFVRVNiTmlaeTZPSDhl?=
 =?utf-8?B?bEh6QmRlVkxGSjE5VGNsMllzOFllWkxWQ0o3b2xCSVZBall3Z1ZzQ2tDMzcz?=
 =?utf-8?B?QlJaU01RbkNvRHV4SjlEN1NFZVJQQTdtbDMvc21tTGxJMmtYcXc5KzhzbXNK?=
 =?utf-8?B?S3VSVTdBYmFIVGxRK2tMcmlyVnk5RXJFcFhTeVRJT2RNZGxwNGRtRnhRcGhF?=
 =?utf-8?B?T1FWQXRmVVFJR0xNaTlJalVOL0RmSFZCTURFZ0xuYVFFeE5YU3k5ckpsc3gy?=
 =?utf-8?B?eHZvNTBhdWNIVDlDOGRkRWdxN3lpTTNjL1JmZE1xSUtzU1ZjVlB2MnJzZlEx?=
 =?utf-8?B?OWJqSkhkaWJPeldxbWc3WEhMaTRtTzF4MUtJTDlrZEtSZkE2eGpFWEV2VFJ6?=
 =?utf-8?B?NmFQd0RKSEJIc0FqaXBHMktZemN0bVI0RlVYa0xSUmZhb1FPTnJla0lkYk03?=
 =?utf-8?B?MVVDb3pXdUNtclVOUEJRcjlINVZkTjZYK3lHN0F6eHRZWUcycmlCbnlOSkFM?=
 =?utf-8?B?OFhPQmFUWHdRSG9kQmc5QUxSaVdjZlNIMldienllTDA3dGZuRUVSeVNObWpX?=
 =?utf-8?B?VlRtcEM4cWpJWTZUcEJMNkFObnRaK1MwdHhOZitHOTVaWmQ5QWdtUHRIa3FH?=
 =?utf-8?B?QnBmK05KbW9BTmNoTmRlUVk5TTdpS1Z4cXB0WldnRXRzUG1zczFCQk5yRmFl?=
 =?utf-8?B?SGdIL2d6Tk93VTJSOUdsZXhOTk1PalJ5Nnp1bThHdkVaT1BxZ3BIV3ZibFJr?=
 =?utf-8?B?TmJ4OForajYxQ0c3ejdkM2JoQWtaTDlrZTVxUENsM295RlBNSTRzL1llUDB5?=
 =?utf-8?B?dElIUi9jUnhNQ3IxQ0xGNkdwNXB2K2NJMVUwS2oxY2x0RVVOb0V6VUJKU09z?=
 =?utf-8?B?NWE2dEEzRGNYbU56enpiSUxkaTV6OXR3eUc4QkZaamNjMVZKT0UxeEZFRFkw?=
 =?utf-8?B?WGI2RzAxZHNwR3BKdWVrS0VXYm82Qks4bzlxRlNvY1JuM2ZGTHlKZHlYcGFr?=
 =?utf-8?B?K1Q2Nmd2TVRQOU9MZFNmc0JiRUVIa2J3WlFBc3d4U2ZLbGhBQUdWOTdqbzE0?=
 =?utf-8?B?RDZPc1BmbXNCVS9sSnV4MUpkbStmTE9uZTRTdEhoWXJoNFJrRzBvMVM0NCtQ?=
 =?utf-8?B?ZTRIWHh5NGREeTZQN0t4N2RnVTlnNmgwMlhmT0ZpVy9EOVM2V1YzOGlEVElU?=
 =?utf-8?B?Q1lYdDh1NDMxRFVrblpYQVpRdy9SU3pyS0wwRGQ5V2pHb0JNU205V2xVNXRY?=
 =?utf-8?B?c0Vmc01QRWhiT00xMHNycXpBc3U3SVlhR1BJL1FZdk14NkpUcVNhb0RKM3J0?=
 =?utf-8?B?R3VES1R4a0lBZEtublRaZlloWjZUeHNteUZmOStaeC9iWVZPckp1dk5DRWsr?=
 =?utf-8?B?dWtVM1kvSmF0SGtEYmdZVkc1Y2M5SUFqTHEzZUM3c2Zaang2emlBa25mS0hO?=
 =?utf-8?B?VlJjKzdLazR2NWFub3BHMGo2VmlIa1NiL0cvWUdqUmlkY0NLc2RON1FPSmRM?=
 =?utf-8?B?U1RIZmNuQzZrS3R6UXN4djdJRVNiOGFtNkR3RXgrN3dJSzhnY0Z2cFU5UEVp?=
 =?utf-8?B?cFRzbEZXMURrLytWY0Q5ai8rWWRLOWpHRHhPaDZkbnhSWHBCK0JhbTB4MlZU?=
 =?utf-8?B?eXluWXgxU25KYVY0S3VNVDR5MDF5cGdhcUdkQVdTWWJ0RmpUeUJWZklmVktm?=
 =?utf-8?B?ZWh6RjdyNHBnMkd2clhZcUdGcHNVcDRRaFZVbk9HaDR0cU1xeWFzUkY2dG85?=
 =?utf-8?B?bU5tRlFCdmtvUnFHS3NtZkNjcHFpcFA1OGNVdDloSE9kZFA3OXJSdWx4Rk9a?=
 =?utf-8?B?NXVobXNjelp2Y25kc256bXNjUUExWnp5VmJ2WkVEZWR0ODcwL0IzQjk0N1Zj?=
 =?utf-8?B?ckpEaE8xSW4wWVA3Uzc5MVViMjJ0OUFrdkFnaWFhbW45YTdkbFhqS0YvN0N4?=
 =?utf-8?Q?vT/O4ieNuEC0kKKB26X8CqQBw?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3cd7b47-3ac6-4d31-1664-08ddfa641457
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 05:43:10.2704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4FYsbANM5ZFBMEvDTKUD4CltqzcZTJaJcrzR+P9SsozByreiTdxmMS5rwSlqWAnEjxMxYuJ6Z1lHLXzHu+ABLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8776

From: Jan Kiszka <jan.kiszka@siemens.com>

Allows symbolic debugging also of those apps.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 configure.ac                    | 12 +++++++-----
 testsuite/xeno-test/Makefile.am |  3 ++-
 utils/chkkconf/Makefile.am      |  1 +
 utils/net/Makefile.am           |  4 +++-
 utils/slackspot/Makefile.am     |  1 +
 5 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/configure.ac b/configure.ac
index aa3794a5f3..a28d80a5e0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -729,18 +729,19 @@ XENO_USER_APP_CFLAGS="$CFLAGS $XENO_USER_APP_CFLAGS"
 XENO_USER_APP_LDFLAGS="$LDFLAGS  $XENO_USER_APP_LDFLAGS"
 
 if test x$debug_mode = xpartial; then
-   XENO_USER_CFLAGS="-g -O2 $XENO_USER_CFLAGS"
+   XENO_USER_CFLAGS_DEBUG="-g -O2"
 elif test x$debug_mode = xfull; then
-   XENO_USER_CFLAGS="-g -O0 $XENO_USER_CFLAGS"
+   XENO_USER_CFLAGS_DEBUG="-g -O0"
 elif test x$debug_symbols = xy; then
-   XENO_USER_CFLAGS="-g -O2 $XENO_USER_CFLAGS"
+   XENO_USER_CFLAGS_DEBUG="-g -O2"
 else
-   XENO_USER_CFLAGS="-O2 $XENO_USER_CFLAGS"
+   XENO_USER_CFLAGS_DEBUG="-O2"
 fi
 
 if test x$use_assert = x; then
-   XENO_USER_CFLAGS="-DNDEBUG $XENO_USER_CFLAGS"
+   XENO_USER_CFLAGS_DEBUG="-DNDEBUG $XENO_USER_CFLAGS_DEBUG"
 fi
+XENU_USER_CFLAGS="$XENO_USER_CFLAGS_DEBUG $XENO_USER_CFLAGS"
 
 XENO_USER_CFLAGS_STDLIB="$XENO_USER_CFLAGS"
 XENO_USER_CFLAGS="$XENO_USER_CFLAGS -I$topdir/include/$rtcore_type"
@@ -1014,6 +1015,7 @@ AC_SUBST(XENO_COBALT_CFLAGS)
 AC_SUBST(XENO_LIB_LDFLAGS)
 AC_SUBST(XENO_USER_CFLAGS)
 AC_SUBST(XENO_USER_CFLAGS_STDLIB)
+AC_SUBST(XENO_USER_CFLAGS_DEBUG)
 AC_SUBST(XENO_USER_LDADD)
 AC_SUBST(XENO_USER_APP_CFLAGS)
 AC_SUBST(XENO_USER_APP_LDFLAGS)
diff --git a/testsuite/xeno-test/Makefile.am b/testsuite/xeno-test/Makefile.am
index cd809abd84..2cc706ad46 100644
--- a/testsuite/xeno-test/Makefile.am
+++ b/testsuite/xeno-test/Makefile.am
@@ -5,7 +5,8 @@ test_SCRIPTS = xeno-test-run-wrapper dohell
 test_PROGRAMS = xeno-test-run
 bin_SCRIPTS = xeno-test
 
-xeno_test_run_CPPFLAGS = -DTESTDIR=\"$(testdir)\" -D_GNU_SOURCE
+xeno_test_run_CPPFLAGS = @XENO_USER_CFLAGS_DEBUG@ \
+	-DTESTDIR=\"$(testdir)\" -D_GNU_SOURCE
 xeno_test_run_LDADD = -lpthread -lrt
 
 xeno-test: $(srcdir)/xeno-test.in Makefile
diff --git a/utils/chkkconf/Makefile.am b/utils/chkkconf/Makefile.am
index 25e73d7c17..f13ac97b0e 100644
--- a/utils/chkkconf/Makefile.am
+++ b/utils/chkkconf/Makefile.am
@@ -8,4 +8,5 @@ sbin_PROGRAMS = chkkconf
 chkkconf_SOURCES = checkconfig.c
 
 chkkconf_CPPFLAGS = 		\
+	@XENO_USER_CFLAGS_DEBUG@ \
 	-DDATADIR=\"$(datadir)\" -D_GNU_SOURCE
diff --git a/utils/net/Makefile.am b/utils/net/Makefile.am
index 86d351ede4..44a1d468e0 100644
--- a/utils/net/Makefile.am
+++ b/utils/net/Makefile.am
@@ -2,7 +2,9 @@ nodist_sysconf_DATA = rtnet.conf
 
 dist_sysconf_DATA = tdma.conf
 
-AM_CPPFLAGS = -I$(top_srcdir)/kernel/drivers/net/stack/include
+AM_CPPFLAGS = \
+	@XENO_USER_CFLAGS_DEBUG@ \
+	-I$(top_srcdir)/kernel/drivers/net/stack/include
 
 sbin_SCRIPTS = rtnet
 
diff --git a/utils/slackspot/Makefile.am b/utils/slackspot/Makefile.am
index 87f99e49ea..80d79b176e 100644
--- a/utils/slackspot/Makefile.am
+++ b/utils/slackspot/Makefile.am
@@ -2,6 +2,7 @@ sbin_PROGRAMS = slackspot
 
 AM_CPPFLAGS = 				\
 	@XENO_USER_CFLAGS_STDLIB@	\
+	@XENO_USER_CFLAGS_DEBUG@	\
 	-I$(top_srcdir)/include
 
 slackspot_SOURCES = slackspot.c
-- 
2.51.0
