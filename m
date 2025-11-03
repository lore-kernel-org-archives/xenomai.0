Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013063.outbound.protection.outlook.com [40.107.159.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EEC3043AC
	for <xenomai@lists.linux.dev>; Mon,  3 Nov 2025 13:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762175016; cv=fail; b=h8CxwY4TBi/hqiGknS3taLl7cWJ9ZgMm42QaTqt1SZQavP6qmo0JV3JCSpuJQor63S3EiegahJByj+u6HpibA1nE/K2ddwG8963ymQC5rO3sSs0hTqY5s2yVY/Ffsi9Z9xttLBAqN35By2MaQIsldftzs7UdSmIFhoFvg6i9f6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762175016; c=relaxed/simple;
	bh=V2/4rz9LTRuDnjTl2f+yz0Xiu1HPbPaZSETZN46fCOg=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=kvArzRNmwulQKxdu4JNiZgJyL8VnILEfaSMPj/6RckzkxTtUsomUboB6KtDfsCgKO4x0A+gkCMX5Qc51gBhSxJKOc2xF8J7TY9ObQPCcWlRlArG29C2Qj1kOFO/qbzV8eId2sbbOWaa+4Ia8I39D+gFacVNQ+3UICRdKarigdO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=oLLwh53F; arc=fail smtp.client-ip=40.107.159.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="oLLwh53F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QypcV5NZO+KXjGBKkTQ2EeJUCYZ5llzR9BPiF75NeXYMLjpz7ouILf8h/izCU/AgUi/7NsmPnvR6psZghi2ojPfxyoqXFyMkbrvc02ahdpsJEwbJfcGavaaYvOt8CzUbQGDauPeirPYSQFTcBF5283bl0gdGb+NUB/ClufVjvPS6/sdPWlw/V7us+G8v5rAs8a4x7qtoBcTnjh0PzKmg1N5FiC0PhPTWqKGGh4Xey0EwQEa6Oz3h73rIHA4bfiepdwlFWQt+nXnwytdwKyVe0nmC0P1Pp3F6CGBz24Tqa7Bo23i+j5nmwMmlWEjxqSznl2j54ijPByOT4SuSkegeEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLvF/2orrMeynDnYPzX4mQAp41wgVu8G/5BEOiPtnvY=;
 b=vlUn4w8giWvDl/yX4LTPN4sMtqbj8KU0r5Jn2KMDWrdwJ6Oje86y0F19WJoTurzCzwApdevaLGxWNFbTWkY9vr3/Nu5vU9vXWclpNWtQmaWpZ+LM+9be2ngxTnpYSfdVedmsyEzRxb6SaYceM+8CxbJpGVeodgvnYbxhgTFrojN0zVAnVFr8r1+fY3lmkMQMDTIYzeejcQJibbUxNg2repstP7XAfxRBmR7tw4UALHCqmbtrv1T2wqWnKrT7mwLuDQ9MUgDugI4ECaWDcnkU9lKgY6Nm4sk0xrlnYXudb3MH9hCZDf7Hn0oMjla0mM2adGwvvKpLr/ZMwIJ4jQW5NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLvF/2orrMeynDnYPzX4mQAp41wgVu8G/5BEOiPtnvY=;
 b=oLLwh53FAtoIxsfFfmOmhO5sABITON0Z3lPLsMrSwfOeuaoJWPDQcaTd+qfcydik1VWun2/b8tLdZfbMJhGL6ibOH2GYcJsE86SvnMLGF5gfUaYCr899x+oH4i1h0G8kaDnz9Q5om8djbEjfEaJRBf6wROdnzbUzqw8rAM4GvulWaGrLmjQeSfVmT4y3gRShs51p+JlAmn5NcjB+XoTyxxcFXMFZmLkWGN6hjGV8k5l7Amugp6W4kscYd/fr1HBJz4cl2rryhti++mUaynkTofhEl/qwI63CU/V440NIab+0odHcqROkbmXja95EOoDAD3ztKmvIK4wc3OXDZ/qp6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5625.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:478::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 13:03:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 13:03:28 +0000
Message-ID: <1f4124b3-7631-4753-96d7-75034e152d22@siemens.com>
Date: Mon, 3 Nov 2025 14:03:28 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] start-qemu: Forward ssh by default
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0069.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::22) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5625:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ed770d8-96b6-4a3c-56b4-08de1ad961eb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wm5sZ25WeTJMVE9pOEtjTzdDK09HcEdDbkhOR0U5Y3V4L01RVkdRMWs4QXhI?=
 =?utf-8?B?UisrTnlEb2hqWGE0cnF5WllITVhNVjIyNTFOYWZSY1VLVmxUU2tockIvYk1w?=
 =?utf-8?B?RjdlYW16N0d2dXNrQ3MzbmRTckNEcXFWYTI2TEFpRDllRkgvbGtpamJrU040?=
 =?utf-8?B?Zms5R0k2U2Z3VkgzTWlMaG1DK3ZBVXZMLzFvZGFvanRmRGNOUGhabzkxdXYz?=
 =?utf-8?B?V1FlSWFDbUpsWmNwb0JncVJFQ0MwYktUMkcvbTBtL0NIMVVlRGdST2xQNy9n?=
 =?utf-8?B?UElOQ1BTU0lxbkNrWDUzRTVoRDBBTXR4WmIycjlLakh5eW8rR0JkTkxuVStC?=
 =?utf-8?B?UVZ0RnNTSzhPdFdKT3YrdDJmVHgwWngreDZ1NmdpcGVhT2puVW8vQ1AzMGZC?=
 =?utf-8?B?VktES1JmWmNtQ2pzcDFsdmdaS21YVlR0QzJjWlNyZWNWam9FTmpGWUZmTDh5?=
 =?utf-8?B?VWFpT01pelI0TWtQYTNXZll0QjJ5M00rdE9kZk5MY1F1TDVaRUMwZlV6Vm94?=
 =?utf-8?B?KzZxNzlPYVZzUjlyeDNyM3kralJDQ0VtL1ovaGJ2a1lpRmZsbEUvT2NKV3FB?=
 =?utf-8?B?MUlLWUpIRWE2TVRYYTFvWGw5TndUbCtpazVYTE96bDFOU0JzVUZ5dFVXNGtP?=
 =?utf-8?B?MmhqUkVzNU81Zzl1QUhhR3orZmhlWGxBZ054WDBqS29pWHA2dngxWm9TaWsx?=
 =?utf-8?B?SG81c01Bem9aODhDbWk0eVc0RFZPSzluSnlFSUF5dWJiMlYwZjI2NmZZek1h?=
 =?utf-8?B?WllTd3J4Nkx5aUlJZ3UyUStTL3RndmFVa1puWDk0SGdOeFZXWksyeENqZVZQ?=
 =?utf-8?B?QzVZSzhiUUFQMDBwRUR0d1lTN3J4Y0g5c1Y0MzdIMEZtbytnWUJFQmp3R2x2?=
 =?utf-8?B?aXRPVTY0QmZiV2VDNHRzSzNWdUdxTE5KclVkTHNBR3h4cWNKVitPL0loZDVN?=
 =?utf-8?B?VFRXQnJuUzkvZ3NWOGJrcm9QcXBQdGp5S3dYYzlYUy9nbXU1RHdVL3BoUjE4?=
 =?utf-8?B?bGxlS2Vra1lwR0owQjE4K3hBa0tMcmIzM3ZCd09kNG1lZnJ1ZS9zYWozVWNY?=
 =?utf-8?B?NTduamJVS05XY3FoTGRRSHd0clZmT0lqNVVlbjFaUUxKNUMveDlTUzcxUUFU?=
 =?utf-8?B?a2pXUGNtK0tDZjlkWk1WajFLN25PNnY4R1RHaDNIWEJiSlN1ZHI0cy85aG9R?=
 =?utf-8?B?Q3lIZWN1UDdyRmw1ZHdHb0Z5dVI0OXZLMWYyWjZRUXZDUU4rNWsyUkJJTHox?=
 =?utf-8?B?WVlKdStXQkozZU1pNkFrMWZROU9Qc0JUTS9EcEliNHNRTFFQQW5kc01GR2lS?=
 =?utf-8?B?ajVqdCtEbU1hUjlnTzBBVXdPNldpNVNWRkVIQ2E2Y29oTjlXbnF3OGhRSkJu?=
 =?utf-8?B?MWV2YVAyYmJrOVNBUUwwcDBMbEhPdklPZnNDRmZicnQwQmRRdUZLZ0N2L3Vp?=
 =?utf-8?B?d1YrcWlXYVg5WU5ObU5ieUZ5bTMxZE1ZZ3J4c1hTS2lFOTVyZFVsVXZiWTZD?=
 =?utf-8?B?em05ZGcwWUNVZm1lcnEzVmRVdGNpY1krNVVEcEdXZExwUVFYWW56UkZGK2tq?=
 =?utf-8?B?WWQ3bVVweTl0Q25UR0I0WlMxMDVialFkYWt0Q2M3R1RKendtQkYyQkE1Yjh4?=
 =?utf-8?B?bmNhcEJRNWlZTnltWFh0anJPMUY2NmVVUnJHakFjYXI3RFhtRXZsZFVtbmxq?=
 =?utf-8?B?Q0VwRjlkeFBhUzNLeEVoTWZDcndWMzRNNktURUkvSWJ4dnhVNDJqdTgzWGFD?=
 =?utf-8?B?QTZsT2FINmVQRm80SGp1aUdUNlIwNVU5Wjc5K1Jmb0RvclFVMGUrM2lOSWlw?=
 =?utf-8?B?eUFrUmdUMjBiL09uY0IvcmFXSjVLS2U2QUhsZU0vZU9SYkE2blJRaEdKdWpv?=
 =?utf-8?B?WFhlMjRmSmFRTjhPcTFMRHhsczZBTUlzNHV1MDNiU2xwZlhyZGdxbzNCMTkz?=
 =?utf-8?Q?MbP+hzc8zyCJEimd9JA26xo/gRZa8Xyn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Um0vaEU5T1F3L29HSUV4ZmsxU3JZMk9WUDVsdXZBYUFQcDdvMGxGbjFZcm15?=
 =?utf-8?B?cmNXSElRWXpXL3ZERkRoOGVKRk45dGQ1MnIvRHNWRXpYaWU0dG5MRUwwRlo1?=
 =?utf-8?B?R3MrUlJKa2dJaDBSai9SZ2JPWUVBNDg3c2FiVWhRak5ZRVY4dHRVRVk5TGh3?=
 =?utf-8?B?UU9XWGo3V0Q0OVFuV3Y5amorRFExekVkeXMrVlBxTjFiWnUrWXFnNjlmcW9x?=
 =?utf-8?B?RFhKbjBSK1ArL1hWMXQyNWJpK0dGaUdEd3BjRWJGSDZVZ3NteHhPVnlMM0hQ?=
 =?utf-8?B?NzUzZVdEMWowcm0xNFJ4ZmZYTUQyQ0drVkJQRlI1cnBETmxPNjdZWVhyNVRS?=
 =?utf-8?B?NStvUVcvWFJtUS9TZlV3M1ViSDJlZjdXMENtUDBBR01Pc3cyQlFOR1BIbUZV?=
 =?utf-8?B?K3dBSjdrcDlvQ21ZYUlSOUJxYjdYaFJyKy9pSkNXNDFZTlpsN01TTkVRSFpr?=
 =?utf-8?B?Uy9rZW5ZSnFpTFJUbmJ6WGJiSmFUTEpyQ3hUL1hHcVlIVlQ3MFdPTDZWV3lu?=
 =?utf-8?B?MmpRUFUwVGRmbU5TWWZqd3o1Mm8ycUZMdXdYTDhqVlRsTTMxSUtpOXRHRjJl?=
 =?utf-8?B?anFsckx6STRTV0JHTkZRblYvSnJFQ0M3Q21zay9EQ051MFVyTHo1NW5ZMity?=
 =?utf-8?B?YVpyYWlKSDhQWS9sTnpTbVJXWVNsMWpRenZkU3pHcVd0ckIrb0laN09LMy90?=
 =?utf-8?B?ZmE4ZzJFWm9XcFBPd3VaWGh6T1IzcXFSa1RQMVpCNWo1bVpaS21DMDl5bkM4?=
 =?utf-8?B?clBkc1ZVSjVPYVoxTkpCbkNrMXdiRkVBYzRWelRZWmdUMDZ5aDdtZ0JvODcz?=
 =?utf-8?B?OERhVG00cG1pNjdPVTdwSkJnMEo2b3BoUHZUclU2Rm1NcGlVMUw2N1YxOEo5?=
 =?utf-8?B?bkhWekhyWUdQaVpMc29haDNNZnhZUFJiekN0cG5xVU5QSXg4Z1dpL1FIZGZ0?=
 =?utf-8?B?V2g1OW8xdHdTbFl3MlZFdHFVaVluWXNENnJjQUlyRnhLWSs4anpXTi9nK0Y2?=
 =?utf-8?B?M0VKcE85ZDlpZDZTNVdwSlQ0NVZ0WExMaVByeTh5cTNDWmlnbndLblVDU2JO?=
 =?utf-8?B?TkFDbmg3RWhUZmVGU1BmUlo3Y1ZNVS80TEloZ2NaZENvZEVCSitGVkdnZSt1?=
 =?utf-8?B?bEc4enViaUJJQUtqZk9IOG5yVWFzUVVXc2pDRjZob0dkYldkTWk4ZzIvZnlX?=
 =?utf-8?B?Uk0wN2l2QjhuMVVPd2ZISUVNZngyUGVYSTVMV2hnRkQ3eDFUWUp5MXR5WU5U?=
 =?utf-8?B?Z011Y3VwLzNtbFV2WkdtZ1BNN2FScUN1QjRzZ0NVUEdjazBPUHNQSnRZc3Jj?=
 =?utf-8?B?ZUZPbEZQNVRibVFqUjdkWVRTZzd3ZWE5d2JlelMvbjV4VUJWbmNXT0NGNkpS?=
 =?utf-8?B?eWJINFRwM1JEWElTaC9KNjZwbG5Ra1BySklkSG13Q2VvOGlDMlQ1Uy9PT3hG?=
 =?utf-8?B?TWhlRGJTTitDSlpjeUdpd0hvcmY5TGplUGJ4OUs3Z3FlOEZLZXhCanNHei9j?=
 =?utf-8?B?ZEZHNzlSbkkzVkhock1aUE5jbVdLRmR5UG52ZCtzSFRneG9FbVQrVXo3NFRE?=
 =?utf-8?B?d0VqNzBGRDFqNHFtRTNuTkN1NHhjbGdBUGZZUi9tRm9WUkFETFA5bjh0dWQ3?=
 =?utf-8?B?K1FqeEo3QmJqNlpkT0hSMnp0Y04rM0Y3VDB4Z0pJeXR2YnZyN2pvdjI3ZlFq?=
 =?utf-8?B?aFlpSVpZcWZIcVZTZmhoTURzdTh0NlQ2OVBVUnBUT25MSHZjUDd1MTQxL1pO?=
 =?utf-8?B?VExhMnJyNzcrUC9TTSt2SCtjc096V0EwSFR6RXhnUGlObGJpdnNUbEtiZ0Fp?=
 =?utf-8?B?WE9jeXgzenJuL1J3QWFLK09Obmg5U1JhUk5CTkJWUTI2TVB0d1Q2WXhheDlv?=
 =?utf-8?B?SlpJMC84bFhzTURRSmVIY1dsNHFZM1A2SElQWEpvQlR1T1RWVFFYTGUvbUZT?=
 =?utf-8?B?ZDdPbVJlMFdQTE53R1Rob3BERkVDZVpESzFiSkJFSlNSYlgvMEx0bEhTWFZj?=
 =?utf-8?B?TXo3Zm5tbHlRZHdqUXY4aUY4U0IvaXRDVnlUOFFDbGREak9xWTRqZkdoUDhK?=
 =?utf-8?B?ZldRQTlqQVA4RkVINSt6VkgybVIzOEdQMVBoU0dZSDc1bmZQU0RqVlFrWjRH?=
 =?utf-8?B?RHZYWXJvYklKTjFhYUc2Smlxa2JqQUNuUEFCZXArbU9vaDFOMy8yY1BwS2tB?=
 =?utf-8?B?MUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed770d8-96b6-4a3c-56b4-08de1ad961eb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 13:03:28.7594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aT8wD8El1P3UBHIopcpUcFO1OyF1emp/ZMN9gcmfaVFxUq8uphkJviGYWImEfFeF8y/PLPcXEscTP3ODl1Rpaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5625

From: Jan Kiszka <jan.kiszka@siemens.com>

Makes the qemu instances by default reachable via ssh on local port
22222 which is convenient for exchanging binaries and data as well as
for debugging inside the VM.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 start-qemu.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/start-qemu.sh b/start-qemu.sh
index 7c3b842..7b9fdb1 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -95,6 +95,6 @@ fi
 
 ${QEMU_PATH}${QEMU} \
 	-drive file=${IMAGE_PREFIX}.ext4,discard=unmap,if=none,id=disk,format=raw \
-	-m 1G -serial mon:stdio -netdev user,id=net \
+	-m 1G -serial mon:stdio -netdev user,id=net,hostfwd=tcp:127.0.0.1:22222-:22 \
 	-kernel ${IMAGE_PREFIX}-${KERNEL_SUFFIX} -append "${KERNEL_CMDLINE}" \
 	-initrd ${IMAGE_PREFIX}-initrd.img ${QEMU_EXTRA_ARGS} "$@"
-- 
2.51.0
