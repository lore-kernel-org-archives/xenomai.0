Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013002.outbound.protection.outlook.com [40.107.162.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496152C235B
	for <xenomai@lists.linux.dev>; Thu, 19 Feb 2026 06:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771481927; cv=fail; b=RsgQa/VH07qbHNF4isaHBUx/kNN/rBs0boPhx7KvNhe+idOp7QzAZp5oMg/Cv/EGHADaEy/JbZWozq8ngGR0zzga5XFSqvemZapMsjmhvGnA0dheRexidGA4jX9MiHfxQ6Hz+LqvnwUlwLykg7e33mXq/e1mxMvdeZaSd0x5QkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771481927; c=relaxed/simple;
	bh=FR6LvbxZ9XaQ63w+R9A90yMu0QMmVOjBhsBL8Q7jUpQ=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=UvKQo5EWRr3KdulrAE9OckIwDBdjGoIHoXCNF4qBVeu5nFWIuPX9VE2ekLIQ66C9xkDZ4UpCBdM4sD6ztj/QSR75X7Oo7uRlfoIkpb1xF2CpKGa1gwYB6835wbW2l1HswfC8Rphtmw2388vGLa30CXBPFH+pPgjEsEeQ/CfIi1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=nANNPueW; arc=fail smtp.client-ip=40.107.162.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="nANNPueW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8GiiKNEE38ynPmYZ30v04TUXydJeEQLrTYACZmoxjowkccabfD9EDDg2fV3cj8NzHySyWlbzL/oChXlJiKkG4XyUN+/VUm5yQQEbJljXNsxSanfc97OIV0gD5Qj3LYlBNf+ZY6bPTBEcSb2zimo7IkTYlkGpWOJmSeBPVlz1E/dJPsBq2dEVoz3b9UGpJIXnDeQZ8JSf7h7bDIm71iCNFlWE5tmvN4aET26pGio/vhwD637XVp+dJqzbs+HWy4Gwo7MpGCLcuxHGzhF0Qc4zwh3b4puctLdS7DwzL2TPrv5hGGCjucvYKsH9rYUr9sYlc1+XPsk3dz/1HAfloONzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3XwPug1vIiHq/htMxEAxYtkq74Gc6szFxPf334jApw=;
 b=KgNSQEaH8AjLnsdDYf9tKbSZTYLFuIQnvf2JqALM5qlXxwFGE3DpQuscYu0hyncA6V4zHCo+6byz8p2/ZlnK9d5cYYc0brke5IPnPwF5iIkKZx/kptSOXfcyvoH/S6USlSqx+Hg5QGuqvrH2cg26iacYKASloc1jNv1rq6FhRWqtmjt5KtEGHB1dGuVAvMDa3mMv2yGQg/gvFQBAPDIHyc1NvD6KsjdDxIiHXjy1qjt7g7OmGGX5L6FCvLKGHqLjdPMk2yF58rZlGmj8MXyY5oPBYYqmaPoNijsAIzJNr0IaA28drX2/Oweq1cYmfHztKqw4Q/kvQOrCmn2ZxiJ3wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3XwPug1vIiHq/htMxEAxYtkq74Gc6szFxPf334jApw=;
 b=nANNPueWny/V31Wqlo0OK/yjjHi4QCLATXPKh1oa13IvLY9BLurcdRRXGDgdWopOpd8mF5BV7y02o+0djtvA15zSh6YZE+XTEV/ggKiKNcTRpEabZJvVagykHFJOeTOSiKZOUt92fk8+jf0LeQFk/pj5IOYnbqkjMEf7PLw+EwHJKdJgJYj9j1nFyIt67BHe+ibto3su67lNrGeC6XOBTugV8zFuSss2TMrv29d/v/4KhKMGV/Hsl+inxCZvqFE+qqOkAm2+M3f3jZuIA6OXgkKThLoKBhIrH2vBixVSnvmEJyG7eNbAh8oT7VpgBjT1+KPxX41R44G7hFsQfNX7pA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7360.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:444::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 06:18:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 06:18:42 +0000
Message-ID: <9a715995-2bda-450d-99bc-3e52a0516fcf@siemens.com>
Date: Thu, 19 Feb 2026 07:18:41 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] linux-xenomai: Switch 6.12 latest to new cip
 branches
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0426.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7360:EE_
X-MS-Office365-Filtering-Correlation-Id: 6229f999-678f-4bee-b28e-08de6f7eba9f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2plMHJmV3p3MThlNlQzbGNJWUt5MU5qWGNlQjlLTnRacTJVWDdubU9pWjhk?=
 =?utf-8?B?disvbHFYY3VmTElVR1pMOTlLa2tZdmh5UkxkTGVzUWdNb0lXc3RvWFYxZEEv?=
 =?utf-8?B?WjU3cDk2Y0xLRDNEb0p2TjNFSEFkZUhxY0tZSDY4SGJDUzdVUFhZUW1kNHc3?=
 =?utf-8?B?ZEd1SzlwWFoxQU0rMWxtdWJsQk9LRDJ6cHZPMFZQdjFDczRVQzZreS9WdXpP?=
 =?utf-8?B?OTFSalpwN2FZQ3B5ZHExZ0FaeGNaSXQ1V3ZWd0puVFJrTHBiOUliREFJSHVv?=
 =?utf-8?B?RjIyZTJkVzVNdndXWUVBWW1CUnlHYWx0dWVLZ2NyUTQwdUtQSTBGbHhVNGI4?=
 =?utf-8?B?dmpHUktJbDJBaXd2cFIwTkhxdVZUK1NFUFFGNExJMDVoYnplT1Rld0prdUtR?=
 =?utf-8?B?ZmppUmNleTRqQlV4eGkzVkhHNnMxY0pBSG5zZlBkeEVVMkkvdTVPT3VHWENv?=
 =?utf-8?B?cjV1a3FFQm9pbE9MM1RGVmttRDJ1UGtKbkdzZ055UHVVaks3ckhlRzVLWitw?=
 =?utf-8?B?aGhLY1J2bk5UblBKTDViUGdkbUtvZXgvVG8xTHBNc0hwRkZaSUk3T0ZCc3Iv?=
 =?utf-8?B?eHBxZ1k0bHAvakVDQXBvVnRHREpsSHd4N3UwanpmaXVJUHoyRFIyTUtlRThH?=
 =?utf-8?B?OXVDVFVBUEtka2JQb2FDTkZVUytKd3VWWi9pZEk0cG9aN3U0aWI0TGc0S1U4?=
 =?utf-8?B?YmUvUmF5UXNrczlhVlpwaEtvUGJuNnkxOVc1T0loYXYvOXYrVzd5WnExeVdp?=
 =?utf-8?B?NGp3ZlZOK0tYYmgwWWYrSys3ZXlpVEdybWwreUN2RUNrQXhRWERhcjZMK1Fk?=
 =?utf-8?B?WVFhSWExbXI0VlZTVG82RUJydDJnMlU4MmtFYTZRQ25oL2d6dldzQTMxaFlY?=
 =?utf-8?B?emNYUTI5a011SlkydXIrNVZIWmk4cWpsZFkxdTZXWmVEcHBRTnI2VDhpbXdz?=
 =?utf-8?B?MmtrOUt6UnlxakVjem14aGNvMElqaDJLVjF0M0VrQmpWTFhWRUtYUU5Ob3pX?=
 =?utf-8?B?b3BsTG9TS2pFWllDYi9jZERVSUFCMEEzcVFQWHk1UE12bDlseVl6UTNkSHRZ?=
 =?utf-8?B?WC9NZ29xRFVkdW45Z2ZPbnYzNGVkNWpCL3B6YjV5amgreXpsTmlFTnhLa2pB?=
 =?utf-8?B?N3lhV3RHU3RQWGlmYVp6MXk2ZGhTcXBlYUJ1OU1BbC9kMnppdkw3QkZSUE1v?=
 =?utf-8?B?c0tPaGhYZ0FjdzhIMWdzRkl2MEx3RWYzTkMxWS9OOCtGNVYxMDcvS1BROXNq?=
 =?utf-8?B?ZjRnWWk0MzhSdkxYaXREc2VPaXdLQzdQeHgzY0FjWk5FcnNQY0wxZm0rNmdl?=
 =?utf-8?B?Snp2Uzk1eCsrcEQyU29rMjhTY3NKWmRLdncwU3VLd2YvNEJmVGMvUHl4OEpo?=
 =?utf-8?B?VUR2WWN1M0RHaXEvbVhXcjd5b1hPMDJqVC9NRkNrRjNWTlFvZlFheEhvdEpD?=
 =?utf-8?B?Q1FQMGgrNjNBd1VRU01VNE9RTEhaYnl1Tm9YNGwrU3V1RncwbWZNcEI2bnVF?=
 =?utf-8?B?TzJSVXBBbG1INU4zaEFtNUZRdnMzK2RaUTFrTTlISkdheGZvR0J6bndtaEVs?=
 =?utf-8?B?NkIwN3E3NlJvSGdCSzBRZy83eEgwcVFTNUwxRzJpa3BVTDVpd3BEcVlIRjg1?=
 =?utf-8?B?MXY2S0JqZWZaSTI4UjBiSnpsS1Q3dUo4ZWhBSXpobnR6VGNJRkhzZWt5TzdP?=
 =?utf-8?B?ZVZKQ04yN25NSCtwRHBFTXBYM1dTOVJ4eXJDdFdoK3FLTTdsTElubVdVZnlC?=
 =?utf-8?B?bWF2UlhQWHNRNm5aT01iMGU4a2RJekduYmpuOWVURVN0cGVHMmpyanNhOXpi?=
 =?utf-8?B?VXJXVXF2S2hxS0lUU2dJYmhMWkl2K0xCV1FUK2ZrNWxsNi9GVEJIbnpzQUhT?=
 =?utf-8?B?SndMa1BHL2o5YldiQ1lZdjZKWngzU2s3djBtT2hQV3lVL1ptaGlPUGRuRmp5?=
 =?utf-8?B?eTI4N3NrSjdibEkxb1pOUTFwQnhRREJjQ0dTSkpQaTg2RmdGU3AyeW1uUFlR?=
 =?utf-8?B?YmNCOE5rejdCbVV1cHFlbzVoUUlBWVJObTh1UkpQeWtPRUNPMS96Z3NHb0tO?=
 =?utf-8?B?Y3hIUEc5U1ZIYTRSaE1lTWtoYXhDWjZvem9qdzdxNUJLSWtxdWFxVVRMaTE5?=
 =?utf-8?Q?bnUI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmJXK2lFYk04cHdXUllsVjlYb2ZoczBqZUZ2L2NjOFVwRmsxZmZaaDhrUHFG?=
 =?utf-8?B?c2x1QUxZYUI4Q2VQaE9sTk5sdGIrK2hJZVlJaTk0a0RUanIvN0FFRDNiOWlj?=
 =?utf-8?B?SXd5dFAvVjV1ZjF6QWlFQ3hNbnhIN0pubDBpY2ZNRFl6ck43MWJPakRJb0Zs?=
 =?utf-8?B?ZGpsVWk5NFVuRVZZSWpuVk0ydnRKWXdBNTRtaGF2RVJReWlZZFZzS2ozalNM?=
 =?utf-8?B?cmFOSnE0MEMzNWlhbDZ3TU5GRytGZU9zdlRhTnV0MG9BUGZla2x5elFrc25k?=
 =?utf-8?B?bFE1WmE3OURpTUtoVllpUEczdHQvREZnak90Wk95cG55aTRvcGxnYU9IUi9D?=
 =?utf-8?B?Q1FSSjM3RENNcDVZYkwwUG5IZmV0QUlqTWg1RkF6WWVwRzJhWm8zekY4SXF1?=
 =?utf-8?B?SFdkZ1A1VHE1cTVBRkdCVHo3b3QwYlU1US9NcTd4MnoxemNtSTJpUldobWtG?=
 =?utf-8?B?aHZ4MUFSKzkzUHNHZkF3a1RxeHlFVDhneVUybW1LRXBWMkxrdWVpL3FLbFQ2?=
 =?utf-8?B?Z2dhMXgzOVBRNFlOSWEyOWxzMjVHT1hEcFRSU2g1QU5mVjc3UE45Y3YwTWNx?=
 =?utf-8?B?WlBFbS8zMlRUemZhYnIySzd4ZHgyOGttSlRtdEVIMy81ZEtWU2QwcDRhbVM0?=
 =?utf-8?B?c0ZXYm9oVVFoc2M3NytkMkt3TzZGYjZNTUNaSTN2M2xWbUkwMnNNLzNHdWhn?=
 =?utf-8?B?bXh6N0ZqQ2t2cjEwNEwrNnJiMmp4UTVEN0E3clRucXREaWlLdmVWMzJHQXpO?=
 =?utf-8?B?QlNoV3FWdi83eXV3RDZnNDJLWVVMU3VnZFI4UkM5b1BRVVZpSEZKclFiUFNq?=
 =?utf-8?B?bnlwZkhqcTVPQTBTeWRaOWx0VUIvc3RIYm0wWFFlODdrUGlpU1V0OU1CenNB?=
 =?utf-8?B?VEY3SXRTb3Z5TUh2VlRzdGdaNHpmM0huK3FkQlRNaTBhSThXbkdoTWJDRHpP?=
 =?utf-8?B?Q2ozNTJpZHBBd3ZkT2V4cmNlU3FPK0hPL1pBOHM0UXpudmpYK1BuR044QVFT?=
 =?utf-8?B?djVyby90WEtFYnIwUVhBemZBSEF1b1NiSUU1bEs0a1pJd3VwRW5Dc3VHUGFH?=
 =?utf-8?B?b2hHa0hJSjVmNlcxTkR0ME5LOTRVVEdCa1BLZGhtVnltRjQwaDBISDhYNHJk?=
 =?utf-8?B?TW1DNjNHZnFRdVM3ZlU5OUNPMFBrZmVzV213aVZOK09OUjhISm02VSs2YW1T?=
 =?utf-8?B?SDN1a3UyemVTWWUzaC8weEVtVnpCN2lKL3o2VkNpSFJkRk01ZXdPcXJ2UlJM?=
 =?utf-8?B?NW5pclFmanFqQk9BenlnNStwZEtaUHN2dFhUM1I2RmEvN3VBbkpYUitNY28z?=
 =?utf-8?B?T3lFTDlmZWVpT1BhazM1UGM1OGdBZ0N0bytVbWgxNGxzTm9saDhraHFqdnNv?=
 =?utf-8?B?c014QVd3MUV1azNxNVlnbzlEVGp0ZVhJS016MGdwQkZkaXgwSlcvTHZxWjIv?=
 =?utf-8?B?YWVDOExKZmljbDRGRHk4aWhuV2poem84MGM0UjhuYmdYZDdueW1paW45M0hN?=
 =?utf-8?B?VDNpMkR3eXp1ckVNbHkzRWJLVTlhYk1KTlJDMkdtci9ESGNtdWtyT1BBSzA1?=
 =?utf-8?B?Y042TlM1c1JVc0lDODYxKzZReHFub0hGeE5UNjViaDdzZ25FK3lFV1hERE1t?=
 =?utf-8?B?Z2VoOXFUMVR3eVhWdTVYcXg4TE5yeFo3Yk03RG1JU3E5MEtjamN4MnRyNlpF?=
 =?utf-8?B?V3M1eHpNYzdOY3FaMXUxRFRqVEtOV0kvSytkeU5zVXVPaTdCWjdnRHRQN2JN?=
 =?utf-8?B?OE9YQUdScjNSdUZEUGhGbVJReVNrUFJqcTJLSXlxbUhqempKNW40Y3YzV1hw?=
 =?utf-8?B?RGlrSmY0Z0h6NzljQnE4QTJ1WXREMHhQSjcxdGtDQzJSY3FZeHhjaldlb0JR?=
 =?utf-8?B?S08wNk5RU3BuZEdXSCszN1IwR1JPbGpWbEJ3bDA2MmlVV0VpN2FMeFVpZVhT?=
 =?utf-8?B?K29sbHJTMkZiTWRQN1U1eFNaYnBIZks0SXZUVlhxTXc0ZSs5TVRwYTRVMVVt?=
 =?utf-8?B?TGh6L256Lzg5d2FPcWJhMDlRMENXK0ltSG0wOVp0cmVIb1lESHZORnBmOW1r?=
 =?utf-8?B?T3g2YUNOOFBtb1lsV0J6QW11V2c2N0haOEk0Q2lPY1FzenRWelNVMXM1RG9z?=
 =?utf-8?B?Mmg5VjZrQ2ZQWWdRWkMzQ2hsYnZndk9odXNvMitMa1hacEk0aVlWYk1rWlBj?=
 =?utf-8?B?WGRXaDVDb3BCU1Z4a25WV2YyaEI0YjA3T1lBbGEremFwOUlMdE8xb3JoS1M2?=
 =?utf-8?B?MDVCekxHdGh6d3hDUTBqZzhzLzhpc3dzSzZoRFJSMm5oM2w2K0dWWURaSmZN?=
 =?utf-8?B?YkdtVUNGYXdLS3RydkhDa0JodlYwZTBES09NRWdYT25lQ1pLdnRSUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6229f999-678f-4bee-b28e-08de6f7eba9f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 06:18:42.4360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LTWJRICoefTW7MMnkYnEvaoTrsUTdsTCMM8BRODS47cq+M8TovBexgQZE+wkvCIQNvWnB2/U+lhDIVn/+cvT6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7360

From: Jan Kiszka <jan.kiszka@siemens.com>

Kernel 6.12 for both dovetail and evl is switching to a CIP baseline.
Adjust our build accordingly.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-xenomai-3_latest.bb | 6 +++---
 recipes-kernel/linux/linux-xenomai-4_latest.bb | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/recipes-kernel/linux/linux-xenomai-3_latest.bb b/recipes-kernel/linux/linux-xenomai-3_latest.bb
index 9c348fe..0a68d11 100644
--- a/recipes-kernel/linux/linux-xenomai-3_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_latest.bb
@@ -40,7 +40,7 @@ GIT_BRANCH = "${@ \
     else 'v5.10.y-cip-dovetail-rebase' if is_kernel(d, '5.10') \
     else 'v5.15.y-dovetail-rebase' if is_kernel(d, '5.15') \
     else 'v6.1.y-cip-dovetail-rebase' if is_kernel(d, '6.1') \
-    else 'v6.12.y-dovetail-rebase' if is_kernel(d, '6.12') \
+    else 'v6.12.y-cip-dovetail-rebase' if is_kernel(d, '6.12') \
     else d.getVar('LATEST_KERNEL_BRANCH') }"
 
 GIT_REPO:armhf = "${@ \
@@ -51,7 +51,7 @@ GIT_BRANCH:armhf = "${@ \
     else 'v5.10.y-cip-dovetail-rebase' if is_kernel(d, '5.10') \
     else 'v5.15.y-dovetail-rebase' if is_kernel(d, '5.15') \
     else 'v6.1.y-cip-dovetail-rebase' if is_kernel(d, '6.1') \
-    else 'v6.12.y-dovetail-rebase' if is_kernel(d, '6.12') \
+    else 'v6.12.y-cip-dovetail-rebase' if is_kernel(d, '6.12') \
     else d.getVar('LATEST_KERNEL_BRANCH') }"
 
 GIT_REPO:arm64 = "${@ \
@@ -62,7 +62,7 @@ GIT_BRANCH:arm64 = "${@ \
     else 'v5.10.y-cip-dovetail-rebase' if is_kernel(d, '5.10') \
     else 'v5.15.y-dovetail-rebase' if is_kernel(d, '5.15') \
     else 'v6.1.y-cip-dovetail-rebase' if is_kernel(d, '6.1') \
-    else 'v6.12.y-dovetail-rebase' if is_kernel(d, '6.12') \
+    else 'v6.12.y-cip-dovetail-rebase' if is_kernel(d, '6.12') \
     else d.getVar('LATEST_KERNEL_BRANCH') }"
 
 SRC_URI += "${GIT_REPO};protocol=https;branch=${GIT_BRANCH}"
diff --git a/recipes-kernel/linux/linux-xenomai-4_latest.bb b/recipes-kernel/linux/linux-xenomai-4_latest.bb
index ed49555..20fa03f 100644
--- a/recipes-kernel/linux/linux-xenomai-4_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai-4_latest.bb
@@ -32,7 +32,7 @@ python () {
 
 GIT_BRANCH = "${@ \
     'v6.1.y-cip-evl-rebase' if is_kernel(d, '6.1') \
-    else 'v6.12.y-evl-rebase' if is_kernel(d, '6.12') \
+    else 'v6.12.y-cip-evl-rebase' if is_kernel(d, '6.12') \
     else d.getVar('LATEST_KERNEL_BRANCH') }"
 GIT_BRANCH:riscv64 = "wip/evl-riscv"
 
-- 
2.47.3
