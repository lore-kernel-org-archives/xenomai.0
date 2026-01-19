Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013006.outbound.protection.outlook.com [52.101.72.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470A130274D
	for <xenomai@lists.linux.dev>; Mon, 19 Jan 2026 08:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768810600; cv=fail; b=nncMkESYgUV163y7bed7VcpHpdhjvnUriBjB1+3vkDNsMz1RIgwOwjiK6Mm9c9bXW4hWLzb8G1zFlUnpr9PVhOUc9m8SpLF7RFMbRbau4KLfJmS/nr4L0IYf96c9ItlQJOkb//mx6iIBt5ZYURcYozGsIOipLUm8Z95pkqdButo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768810600; c=relaxed/simple;
	bh=yDv/BW9TnLfqnD1c8MOTl+HZw3sbiw7HJ3j6fS/JBns=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QnTXt8wECCAP93dHhWi1+kx8QNu5NvAPTzLKKKm0UMU8QlsTzKLqq97NbPsk9d75B04aZUPzbHJVYP3HiNyFSJdLFRJ6U4U+2Qr3nCqcfKjfHka1ReRnvb4CvNOtrt64BbtXfMKNtaU43e8sm8Lp7r62AjvmwXUsFDHuQZ6iBGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=p/P2oy3N; arc=fail smtp.client-ip=52.101.72.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="p/P2oy3N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mpLElYynbL4qMnx+q6GAKXw6Gjl/0FzF0y6RXN3U20WUE558C0c7nvMfIw8IH8i/FwHcExHsdqRdv0gM50pieTgE/W6LIoWn8RvGau+Yz1F1IFQdkbTXM5WMw21Pw3v/7FEtpVvkEMWoSNDOn8WbMbnalchGTlDc3qgZzsAOhAcPh2cpB9BLWUSlXomt2sJasdO8zfwML5u5J4RJucTU5rn7A0hPC7gq3cSndF3DL2Olp4ejcX9wzudjgtGpujTVGlndezexH7FAC2JTh/WDvZTvMJJAfJrKRWHLFe5gYW9v+AShrsEaVEdHX0JWri4eUDOohyz7FKwCUp5QiXXwdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQk1a1YlDQzaXokApuJZd4zK5l2AMqLRN5Fcu/hEXy4=;
 b=A0ygQVhOsSpGcDl6sSfuRssgMrmDKvNAZGjfzJICQnVqG/i3GKkSv9HGhp5cRv+r8QX1lmGVYIfyK06sIxcGuDduw39nGDmcu33mjI1lY7V6o34VIeUjPxC1XJKK1IGRRIC9RQE0yCE0+OaM3ZGSEw7atehrF2IJGoDycESdWjOkwCCfDffgilYD7qvQpUdJRwzEbPScd9WNM42mXYDvTuizwBcOhdNxQkErdJHMTeOsnb7Ivlb3fB+7nkbFPPbENoHaeZQK2ZT5jXWT4AVXSpGMoVOAu3BiY9QyrF5Q60leTh2xBOUGttLe8xMGbmX9Tt3cK2NLlimyUDR5JI3uug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQk1a1YlDQzaXokApuJZd4zK5l2AMqLRN5Fcu/hEXy4=;
 b=p/P2oy3NhJTDkXRY47hk4bP8tO1nTvW3/Xnik5Ybb++dCn5MxFU199Q823N8DDTD/gexs/naZyo5P9OOuiFAFCQ2nagd6Sgq3manhsOVYJ8VMnOLEfN8fRNVJofvAlJEip4sUzxnjYTDFABCSm+80u/BLe6EfCWrJ8Dsv2kDH2bNGF5VMk2S+FzKbmWEq0XQUFZw4xDML7FG5EJm4zIwabykorF9/d7ZEt5UzF2NiYmxnt6UTlQI4yuMffwY+V15xhUTfCZ95cDMGvY9uIMfKl3WwD5hjxPl8rmoN2jxCJltUmtRND6RzfWvSSUVMnmF7RBTtLBdBn7knAX3whEcIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5869.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:514::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Mon, 19 Jan
 2026 08:16:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9520.010; Mon, 19 Jan 2026
 08:16:33 +0000
Message-ID: <d3c3d55b-3f51-4629-bfa8-17634c2e567a@siemens.com>
Date: Mon, 19 Jan 2026 09:16:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: xenomai-image problem
To: Pierre FICHEUX <pierre.ficheux@smile.fr>,
 Xenomai <xenomai@lists.linux.dev>
References: <CAFc1U0utp_YgpET_EgBb=Q6e3orJfisB5_sSLq53APX73eWyJg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFc1U0utp_YgpET_EgBb=Q6e3orJfisB5_sSLq53APX73eWyJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5869:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d4cb974-9331-40e0-d812-08de57330ea6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d09NenN4MGtuY1JZeFpoTW9VeWd6WUNva2k1VnNlKzU3b1A1SjZvWVd2ZU1y?=
 =?utf-8?B?S09tRHE3ajhBaU1VeGYzR01oSDIzZHQ3WWpHQ2h5ektTaTdIQU1oemJCRDBl?=
 =?utf-8?B?SmxPejIySFBNRTVpMWpxTUZFcTNaZi9XTjRNV1Q2MHdveUJ5WDkwc2o5YlBa?=
 =?utf-8?B?THZrMmtyQUJScjlJUDFBdWFkK2RFdWpmK3Rpekt0ZUNFOXpOMWQxbjQ0L2Er?=
 =?utf-8?B?YVA2S3VyM1lKRVVCVTlKc0lFRExQZ2xzbk5Oc2VpRWoxSXd3dUlBRUxjMSsz?=
 =?utf-8?B?RzZVZVBQOGh5R1JqdEtxaFgxeEZBbU5DSHl4Z1pSUWxWR01STEZjNWFTWE5U?=
 =?utf-8?B?MUQrY1BsM01idmVjRlFvUlBBbDIwV1pTZjVHWG05WnFMRjNDRzhUMUdqUEkx?=
 =?utf-8?B?OEVIbHZmekp0NERETGYxM1owSFZPc1ZBNUxackpDRkZzZ3I5b3IwOTViWVM1?=
 =?utf-8?B?S0NOYW9BR0QrYmY4MUxkMTFHWVlkb3AxUG1PMnhaWGxlUjFMZ1pMSDg3Z3R6?=
 =?utf-8?B?TGRkeXczM1hLM3dhTjlBMHBOYTBPZmxndU94VU9neXM2TWNUaHlPc0orVG9q?=
 =?utf-8?B?T2RzZ2dFUEJXRmhRb0NZbXVpQzNZTzNzK2hCWTNTS3hMZDgyVmhzWExGdUIv?=
 =?utf-8?B?UXM2clZrZVUxdTB0K1F2VFA3U1haa0Y0R2QzanNLL1YvMUwxbVVIMTJPM2Iy?=
 =?utf-8?B?eFV4d3M2N2FnUFhVdW0xdFdxazV5WUZHSmxMS2c1ajE4S0Z3bEhFdU1OS2F6?=
 =?utf-8?B?V2VYQzh1ZHJEUzlUUjNPbGIrYWdEc0V6K2lIZ1VNS2E0VU1BVTE1WnF4OVdG?=
 =?utf-8?B?RjhoaWFYdndML0dLV2tsZjgzdWJKKzZpYU1pMHFqb0Z5OXdSZXBKa3RIMExi?=
 =?utf-8?B?OTQwd0ozdWVRVEpQaHliTCtwTTR1UXVQL3RWSE9YVmh4UEMzUWZuOU1XNzhz?=
 =?utf-8?B?Vy8zOC8xbExrUm5iTDJsTmNuUlFPajRxaWtDQVA5SFFyNjg2S2twVFVVSGJP?=
 =?utf-8?B?THhONm0yM0dtbWVtOEFzOERuQ21vRTZva0VlTHM2WkcwZVo0cDQwUUtrZ3RX?=
 =?utf-8?B?OWxEQStDZ0tES21Jb2MzQTMyeUhaL1p6bWZ6VHFRYkRSa0JNanZRb1V5Q21r?=
 =?utf-8?B?blA4aXpDTHBsRDgyS3RFS2w3NnpZMDNEbVQ2VkJMckRZSW12bFJoNkJQTGpr?=
 =?utf-8?B?Q2JnSkNYNWk0VnZjZUFQME93S1Q3ZnhWbktxWXVyNTkwdWQ0RTR5MGlLSlRa?=
 =?utf-8?B?Mm9UZjA1TWIxZFVGK1loSWtIUzd6OURtSlZrd29TNzMzQUpjUFZZdGVqZkor?=
 =?utf-8?B?QWcrTVFLdnUzVjF2aUxxTnU2aFFocW1IUzh2dXowN0F3SExldEI5cGdVbUoz?=
 =?utf-8?B?Um5HMUhlNlpmMTlXeU8wWDIyOXJQaXZPbFN0WStEN3NybnBuSElFb3J3Mjk4?=
 =?utf-8?B?a1VRRXBCTnErdkx3YWg3QUxadWY3WE5mVEFmWUJLWGRPL1E5RmprK0RVOFJl?=
 =?utf-8?B?NkdzdlpZR0JJS282M1lraFcyczhvY1NXYVBaYUJ1clFHcVpsSDNOV1BTWG9p?=
 =?utf-8?B?OG1yTFRPdlRRT0NLSzZhejhaV1NLcEtPSWMyVmdJSnNCQ3FRVTAwYUcxcmxx?=
 =?utf-8?B?em04MGVrWWR5M2d0aG1CL0xJQ29oVXVXZmtRMnQ1UkdSc3V3enVPbTR2QnhG?=
 =?utf-8?B?TC8wbWFJNFlQa1dMWU9GZ09HaGhjc3JqQ0x2QkZmMkpmbFY4eHQzTGtMOFNh?=
 =?utf-8?B?ZDVDL2hqZXFOeGZHWDJWVEdDbzFxa2J4bjUwQWxSTldmWUxyazJmTHZ4eThz?=
 =?utf-8?B?NFlIVU5QQmhEdng5U2NDSnFvVzFnRWxDeitWbW0wUWZkNDY1UUpBV1hmVTNv?=
 =?utf-8?B?Q3hwTGRsQ2oxcXRsMnEvTWplbGh1STJpUmYwTXRRRDN3bW9uYmF3clJtNEFu?=
 =?utf-8?B?NzZiUVRVQ0V5RnA3NGZKekhEY0ZpTUlBNWo5NGNMN2hqUG1FdGlGb1RIYStt?=
 =?utf-8?B?QlRNckQxWXF0UlltR1ZrV2JpM29zckt1cG5JenVDTmluVmNNRGxPY3N4dkJz?=
 =?utf-8?B?OTRra2xLVmRyY3pCZUJORjhJa3FFbXJYTjVFTEoxbFhXSW8wK0FSTEpyQ2tk?=
 =?utf-8?Q?yVNQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDFJT29obTJIQko2OWdEdGR6UHRPVmpKUWdDSWRGQk9hVDZSR0IrTmtxcWNJ?=
 =?utf-8?B?aWV1Y3FFbE9PbDN3MDlJUEhQM1ZCbXpiSENQMWczZHRHWHRHbUNERnFWNUwz?=
 =?utf-8?B?L1lzWXQrVkxrNUpFNlpzaVR5ZFFTUXc1S1JhTXJUSno2VkR1MzVKWk5jNm5p?=
 =?utf-8?B?eWI0MzZPa1VoL3o0UVpraXgwQkcxNGxkQytLTUFCVmhIMUp5b1BocDhwRzdH?=
 =?utf-8?B?RWliZXNXanAvZEdRWjVmb215cm5YM2NYSXRnRVdvWDdHNUVRZGpwNWZYekFu?=
 =?utf-8?B?Q0VJTVJvUXI3b3FUdmVJaTFGdkRFQXZBNWc0T2oySW5JandxUklFcmZXUVZC?=
 =?utf-8?B?Yk1hWDUxcEFuV2JEWFMxVXF0U0JiQ3NCSVFldmdKSVdETVRJbXZIYWhsSE50?=
 =?utf-8?B?UFpmdUhXWHpXWEdhdXNFcGUxMXF3ZXNsbnpvREZGamNmNUFjeStmc3NFbWF3?=
 =?utf-8?B?V0lhN0c2NmFhVERFR24xK0pNTHEwb2daVlVuUm5yTDFvVUovU25oWlRQQ1h5?=
 =?utf-8?B?amxMS3hkdGlLTzFWSUtCdmNzdUVlUWczd05uRVhxdlNZTU5hQ29WcGVFWDJo?=
 =?utf-8?B?VXE0M0lEeE56L2l6V2ZoeXJPMDZrbEVyOFovNjZnNHhrUjNFWEg1b0RUNjRB?=
 =?utf-8?B?akVlL1UrKzJNdXB6WWtrb0tlaVBkaEVlNUgvbVgwcEZSQlF4N1plQ1RDRFht?=
 =?utf-8?B?UlYvd1ZaS3pqQXFaMFJEclA0ZzdtRkQrUGFxTHZPbDlZUFdVdlVKSUExNzlw?=
 =?utf-8?B?VXhzZzVFLzBlZTd5M09hekNFQXBKWVp3eVo5U3lsVk52VEZ2ZGlUcjFsMjlL?=
 =?utf-8?B?UmZBTmI0czkza205Smp0MTZPMGtvV2pBbTBPRXVtOWptVGtEMTBnTEh1T09w?=
 =?utf-8?B?a0I3ZEVrTmRBWHdjMkV1OHNtekFLMmZMSitnOGJwRlFvTHpiU3gwRHJSWTZG?=
 =?utf-8?B?enE5OStLRzc4T0c0bmZObE9IYVU4NE5zdTg3V2l4NXJPMWd1MEYydkdWLzlJ?=
 =?utf-8?B?RFZKbUJUMU9rUGR5czBoRzFOaERuTWY5Yld2d0xOZFVpV0tFclJWeEh2RkJE?=
 =?utf-8?B?bHc3SVpKbDNOSkxxVmJPMjhoTXExVjNCQTNtZUR0ZWxhVUhIWm5lYTRRQUg3?=
 =?utf-8?B?VEpyRjdDTUFuUjdsTFFrQldWdDNxUGoyd0pXOHBPT0pFMStmcEZFR0VYNjRR?=
 =?utf-8?B?TGt2RnB1M1YvMDcrZDFJMTlQMTl4dzkyUGJuQTh0ZnhQMkNSTHN6S3pSMkYz?=
 =?utf-8?B?M2gyeDdxRkkvNklFekhveVE0TTBEVm5XTUsyZjNGYXljS3R5dEd4Wi90Wjc1?=
 =?utf-8?B?dTFkekpvZlBOM3pPb1pFM1ZpaFFBazNjZHdxT2I3V0h2d1k0b2JsUVRQbDJF?=
 =?utf-8?B?WHdmODNMV1dmTDB6cEhSelE2YlA1VnprMVBiME8vTmJtL2U0aGVlc2VKS1Nl?=
 =?utf-8?B?ejZXQ3FYeEt3eTZXNk16TUpZcXZnNUFlRHRrN0l5ZHVVTVdMWUN5YXZPTUk3?=
 =?utf-8?B?bDRNNDF6TEk2QS9rS1Y4QTdzQzE1bUg5anNYcU40dkpXMURSRUU3YmtxbXVL?=
 =?utf-8?B?QllzSDMwR3p2RUJCRE5ySEJEYmV4WEI0YTdPU3o4Qzd5UGswbWhIcktEekdX?=
 =?utf-8?B?RmxEbTBJWGlucUN6NGVyV3ROQ2dhdVBzUkQwc0xnOTczdWdGZFBBSlpXdHc0?=
 =?utf-8?B?NEtNeTZVYklUbmowbmpXcGZqQk04YlFmN0RtNkdlb0djdnpBaXp2bGh0eE45?=
 =?utf-8?B?aENpZUU5QlNYOHJWN29LdFMyWlIyWG5wRWd4anJ3S1JWQXR2Z3lwOXRYdXND?=
 =?utf-8?B?bVd0enlJakt1NmdRajQ5VXVVTVNYc1lJWDVOWlBvOWhQZE9abkVOcFNCdlZn?=
 =?utf-8?B?WlZFZElQRExEVUE1WEtOVlltTDhQZG1ESEVPcVVDMTV5anNiSW12UmtZN1pZ?=
 =?utf-8?B?d0g0SlFFR2ZrUnRjNE9PWnFtRVBaMDFWWXZCSkNZWWhCUWZXK1lxL2tPQzln?=
 =?utf-8?B?VE9ad053WEd5WEZ5Yk0zOG0wb25wSGtMMk1uY2JPTTZTZU04TTZQbzQrUEpo?=
 =?utf-8?B?MGgyYktSN2lROXVBU05Eb1lnclVHcVpUZ0VnWEl4aDdyL2V1dzhRQ3p5TXlx?=
 =?utf-8?B?SE9zeUhUVmFHay9qcndVVTduMkdCc2s1djR6N1ZwKzVFd254enlNNjJPUFpr?=
 =?utf-8?B?cDcwQ0g4MlNRaFBYQldyRWNBalZUVEU1WnlNeWM0bkdSUlBYaGdkVDZBSUlj?=
 =?utf-8?B?OEFzZktvRXhOZWVVc3UzT3YreFdNdThqeFJYWDVIS3BqQ3BXL1VOc2MrSExp?=
 =?utf-8?B?SENWTSs0dDRHT2lJdVlSSkV0UTUzTnFBSmlLS3R5N0xFOTgyMUo2QT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4cb974-9331-40e0-d812-08de57330ea6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 08:16:33.9126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BPuNrJCvDI9xL+Yz1ZDhozOX+wDa0TTMeupaHGSSTmzeMY3Kwr+otcZ+hCAyKdqchz0A4fjgPBr8jmnNZWzWCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5869

On 19.01.26 08:49, Pierre FICHEUX wrote:
> Hi all,
> 
> I try to use the current version of xenomai-image and I get an error
> at the beginning of the build (Xenomai 3 with several targets).
> 
> $ ./kas-container menu
> 2026-01-19 08:41:30 - INFO     - kas 5.1 started on Debian GNU/Linux 12
> 2026-01-19 08:42:02 - INFO     - Saving configuration as /work/.config.yaml
> 2026-01-19 08:42:02 - INFO     - Using /repo as root for repository xenomai
> 2026-01-19 08:42:02 - INFO     - Repository isar already contains
> 9792d18e9334b3cec72e2ade6a1065084c0c24d6 as commit
> 2026-01-19 08:42:02 - INFO     - Repository isar checked out to
> 9792d18e9334b3cec72e2ade6a1065084c0c24d6
> 2026-01-19 08:42:02 - INFO     - /work/build$
> /work/isar/bitbake/bin/bitbake -c build demo-image
> Loading cache: 100% |
>      | ETA:  --:--:--
> Loaded 0 entries from dependency cache.
> Parsing recipes: 100%
> |######################################################| Time: 0:00:02
> Parsing of 52 .bb files complete (0 cached, 52 parsed). 107 targets, 0
> skipped, 0 masked, 0 errors.
> NOTE: Resolving any missing task queue dependencies
> Sstate summary: Wanted 12 Local 0 Mirrors 0 Missed 12 Current 1 (0%
> match, 7% complete)00:00
> Initialising tasks: 100%
> |###################################################| Time: 0:00:00
> NOTE: Executing Tasks
> ERROR: isar-mmdebstrap-target-1.0-r0 do_bootstrap:
> ExecutionError('/work/build/tmp/work/xenomai-demo-armhf/isar-mmdebstrap-target/1.0-r0/temp/run.do_bootstrap.296',
> 25, None, None)
> ERROR: Logfile of failure stored in:
> /work/build/tmp/work/xenomai-demo-armhf/isar-mmdebstrap-target/1.0-r0/temp/log.do_bootstrap.296
> ...
> 
> The error seems to be the result of a missing dpkg command.
> 
> | I: installing essential packages...
> | chroot: failed to run command ‘dpkg’: No such file or directory
> 
> I've used it some months ago without any problem, do I need to update
> anything else ?
> 
> Thx by advance
> 

There might be a problem with registering qemu-user-static via
binfmt_misc for the execution of arm binaries on your host. I guess
building an x86 target works, right?

You could try to clean the local binfmt_misc registration once:

echo "-1" > /proc/sys/fs/binfmt_misc/status

kas-container will set it up again on the next call.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
