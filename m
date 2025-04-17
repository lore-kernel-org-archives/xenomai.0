Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011069.outbound.protection.outlook.com [40.107.130.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20C92550AD
	for <xenomai@lists.linux.dev>; Thu, 17 Apr 2025 17:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744910394; cv=fail; b=aq91EzbJ5UkyDVkpz+1Csc4MIrlxIRTt6v0eGUKcRsQ9bLAF3ghfVWTOJxZG3e08cMB8u0jFgflxFRJ6NF4uGVL1kpJuEplfH9NyddwFzPN5OJn8cIWC0ZLNyFPFS75Nhref3saDNrTrikDh4BXolT1dsnkRpJXlD/DpXYG52iE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744910394; c=relaxed/simple;
	bh=+3Pwp8P+7RQha1fFS2G133jh2aWrKNtA0kg7XpwsOmw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TjVDTc9j1FDxMGcXtMUB56C9kS/28M1xJPkMyzaID/qLHbzWT1wVoHlrMe5qfyn5ZVk0d8PUpCU29tZuqEzhaZ83BkiwL50q2zi/VTTXuot0Jwd7S8IJp4LDdLuXuKrruAnb/dlXd0X/I+G9MZBiga/AkEnB483jahsVlSpCD3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Na60T2O9; arc=fail smtp.client-ip=40.107.130.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Na60T2O9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0b+ryzOO5/D2QPHCyPq8YoEMBwTrVxAs8ihmXZ81sedJan2sHVCGHaeXK0DpS1L3HyLqtAFkBbP4yBKXPx1Ntt3a+0oIwPC10QNvk/1hRVjnU5MFA86NsxXsjyliVGJaZku+938Z4cUDOtwYMlzUWI4qnfIGyVbka20Na5gAbfd2SIL2OqhKfLWaR27BeigSpTTxzG0uWuIk5Tq9VZ8H3uuhYvW+TxVchuNXVhk+h+DX1YGOMasN2qQ4jBMyMjkqZG34ZpETpG5gdCnk63EpImsQZltbiIBensGKuSixrIgRczAFDqTzfKskzVjhIHVN2B5/camuu77YLD2rOQicQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EE5u6YbI1yyQe2hxIFGcPAjOnRFqe0B7NNf9GBtLwmI=;
 b=qVHov62WfS2/586tk19h3kjoGPmgTmJ6y4mPY8hbPt33UnHt/V/REA/ItLqGCw6d6NPTjvZ+I9JeF3UWFsxNBhbYpXWRRYjqYVR23wC/w3JBx9WGP9yimJyqlacXFtC4iSr8GrDrtmcAbPVwXil19dKIiutblpqxUKSOFH45klGXJliS8yHnpyR+RIhLIT9Pss+4iR5h2FCZQ6YcKnnefEnDEklFhlM3MRIIA6hdnLbHHg5M7wX0BbiHFPfBD9u6y2hdmiJl5AuMULVUci9WYcN9SC9mcc5i/wE2kQ5Z7v02qkgpNC9x2ukEJweym6mgjxYF5Yb86kdUX3qW2Cpk0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EE5u6YbI1yyQe2hxIFGcPAjOnRFqe0B7NNf9GBtLwmI=;
 b=Na60T2O9a/Wt1YGvrIGe89+ApQyZWnX/omumeUQhczpb3DSgnorYqezY78wb5ZoY8wlTrqi5Zbos1puanjPm39LLi349dfdn7cqB6XQAYS6GPeBSvhLS6vCwDVP/UPNeuyK1BjgctPx7QOgj/mSI9xMpzV/gDlv1jvXCW4u6iAIYK+rUHzoo/y4PwcOOtuLArQ50CGN6RgzdA8e6hO9usYsMgjldA5sNm5AO4TGgRizG+F9HphvVESsbbXmAOhjbasOq10zprg6nKmjyLOfTiiSH3Go0e+TtaKTcEE8g8hfM9A742iqjSKJzSnKrzflzRwuu5vpP93QqP6QKJFuiAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6827.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Thu, 17 Apr
 2025 17:19:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 17:19:48 +0000
Message-ID: <c5cf98e8-aacc-4e84-aaf7-8714ee57ee04@siemens.com>
Date: Thu, 17 Apr 2025 19:19:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: select() sets -EBADF
To: C Smith <csmithquestions@gmail.com>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <CA+K1mPGcVn1BF0sdG0YHAZHDuQe=68DpBK-bXSSbApP2TV7Q1A@mail.gmail.com>
 <f76f5f55-a793-4fb4-9870-770adad60c2c@siemens.com>
 <CA+K1mPH9ddmD6wSXLfrs_SqPRhcsJQtMrv2Q84ri5SrU8xHKyQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CA+K1mPH9ddmD6wSXLfrs_SqPRhcsJQtMrv2Q84ri5SrU8xHKyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0351.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6827:EE_
X-MS-Office365-Filtering-Correlation-Id: b8fc171e-e077-4ce1-989b-08dd7dd40e85
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bC92MGVXRFNQMVA3ZUZJOFZQUks0MUE2Y01jM1hCNXZDNVd2RHRIVEZqMGFL?=
 =?utf-8?B?RTJkUDkrZUF5WndFTlZ1UXJYTXB4TklIOVRQcTVKc1RXVlRROFc2VmpYNXhF?=
 =?utf-8?B?WTd4eFpPblV0dmVzcUFLVE55OXVaZzMycGRCWkorUXJJZjkrNjY2ZTdiOVpw?=
 =?utf-8?B?VVVOYjBQOEMvcGpIR0dqRE42b0EvMTgyVUJrVnJxK0VRSG5QcHZzbE1OR1U0?=
 =?utf-8?B?ZEowK3drbkZaL0ovVmVJOFNDUVViVDBCUFpsbC9aZmtiNmU0Z2Z3aXo3cXg2?=
 =?utf-8?B?cDNDdU9OYXFOWDVna1Q4ZVFVYmJ4a0s5R2ZONFBKRVdZaFR4WkZhMitCRmZt?=
 =?utf-8?B?elJ1aWZSYlpjbDAwLzUva3YrRVBmUVkyWGordm0rb2xCQXV0Qk1LdEVlaTRC?=
 =?utf-8?B?VjVGVGRKWXprNVJ2WjdRQVlMMXdCRWVmeTlLOWFwRmpISXBnSlMrSUtuMlAw?=
 =?utf-8?B?NkE3WXNFMTAvWEMwRzhpVUF2SHdBNmk3YmhqQjdITWZIOWRCOWVXeTVpK3BE?=
 =?utf-8?B?TnRqbHNJRFI1aVJiemdFV0c0Q2VEVE92dU9oQ0tmbkhwZ2pxZ0puZUxLNDlh?=
 =?utf-8?B?alQ3R2pVTGRLU0pTZFIvaEtJUmIrdDAwYkpMNUw5SHlBS0FuWG8rbUY3blI3?=
 =?utf-8?B?UG5oV2djQ0kwdnBEbWQ0bFlrRGFLU2JlbWVCalY5cXVRTnJGNG1RUlhQZ2lW?=
 =?utf-8?B?azJDNThaNXgzbzlKREFKZkhaS1E0YzBuOVVBU1VPODJHSi81SVZXcmpxQ2dx?=
 =?utf-8?B?S21lTFptUTh4Qk5zWnNKcFQyTHhrYzZRUnUvRncxT2dqMmVBdHdlVnpTOGQx?=
 =?utf-8?B?MGZ0OFJXWnF2NXJUZ0ZYTUtMcm9MZ3RoQS8zeW1zVHg3S3pFNlBDUzd4REs5?=
 =?utf-8?B?OUdPZjB5a0lTTWJQUzhPWE9jT1NjNjZDOGFoc3V1TE11bHliTlhuR2Jza1Fx?=
 =?utf-8?B?eXpKSjdUUHdLa3MvbnZZaVhhSG5uZEhJeXJobzRaM3lSOHpqdjZoUVh3Nitu?=
 =?utf-8?B?ODRPZzhZOE5zdCthSEFZWUpycDluSitxdEVVVXU2ZzJDdDVsVVprVm15WFVK?=
 =?utf-8?B?Z1RFR1A2SGgyOXpPNFRmWmtHNzM3SXA5QyswN0NxNERMQkN5NGRqYTRPVEZz?=
 =?utf-8?B?Umsrbml6K3ovVmhGUWZ2UGRkcFNJN0xMdVZ3MlhtamdnZHV5UUR3LzdFRDRY?=
 =?utf-8?B?WHVla3dTM2dONHg0Sjg2Y0pFcS9MdXc1cTlKbkRpamp1a21QQllrRG5CYVlx?=
 =?utf-8?B?Q2JmSSs3cHNHWFNPOFdDRStqSXF1QkFjUHU2Zm9ja1Z3M2pEbHNFWXdVejJN?=
 =?utf-8?B?bGRuQTc5dmRuYTBUM3dGenlneUtXY1o3bEpNU2dQTCtNM1JlSVRQSzczd3ZI?=
 =?utf-8?B?YnlUSk1sUStMY085VDlhb1ZjSGpsS3lNU0c0UmszN1RPV1JBUHFFbjg3THp2?=
 =?utf-8?B?TVliSm9rZDVLY0VuY09mSU5BazEzNE1TQmd5d20wMVptamRMdzN6YkpSTFNl?=
 =?utf-8?B?K2E5aXo1K1JNdHF4Nmc3dWR3SjVuWThEbDVCVE9DeEhVN1Njb0c1dFdoSnJG?=
 =?utf-8?B?WGlYcWpKcU5HUDg0NlRqa2VKL20yRUs4OVlOM2tuU2xMUFFVMDRXN2tlZGZO?=
 =?utf-8?B?M1hGNFdZb243L2JGUitUUjcxUGVQOHRvbnRwS3g1cnBsR0cveC9rRk9TV0la?=
 =?utf-8?B?Zk9RNmsra0NYaWtDK0lyS3RyTWdtZUVZaXcyVzJoczNlYndkMnV0R0c5UlV4?=
 =?utf-8?B?TmVjc2RMcUtEQy9zZWhGajdralBCU3kxZ2FQdnpYVDB6eERLS2dsMkV6aUsx?=
 =?utf-8?B?dUpXajNoZmhIQ25kNEZ0UDNqTGZFdm04VmVlelhhcVNCaWlCTUNvU1FTdzR1?=
 =?utf-8?B?dTBsRnBqakY3bW9zR0RyTFdnakR4eDFQY0FWbnFCSWt1VzVLa0xES0hVQXhm?=
 =?utf-8?Q?W9KWHfzD5Ek=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFZHc2ZUNGIyZ0hDbW5EbGk1ZC9GZWZIbXczcmJYaVdkVEVlZTdFSFBucGov?=
 =?utf-8?B?bU4wMzRnQ2dscTFWZWJpZVU0SmFWY2dZUGRXZ3lIajd6dE5qVHZ3NFFvODV5?=
 =?utf-8?B?M1dkNnA1eTROaWlPT2l4U2lZN3lEQkFJM0dERVNyRDZMenZCSWpVSHFCZWdN?=
 =?utf-8?B?R3pOaGtHMDdBYmpMOHk5a2ZVUTVEZGdOdldMdFVBZms1bEJSZjUxZ0RmUXB5?=
 =?utf-8?B?TjJEeG1LVDhTTzRiTysvVmRveUQ4blRhN1I1RXBTbWhKNnBSRDFrU085NEFh?=
 =?utf-8?B?ODNUV0Z3OFZ2OU10dVJBS1NHeS9zM0NkRyt2QUM5UGlwMTFDa2FHdjZLeW5l?=
 =?utf-8?B?cDYzaDY1aHFlcnhPQ0VXb2pjUGpRR0RVZFljR3ZKRkdqL1JacEllNGx2RWdu?=
 =?utf-8?B?R3EvSWJvZUxzSy9mWlBjQTJ0RTBqUlpQa1lBNVdCSGEwYTkxMm12TnAxZkpE?=
 =?utf-8?B?THMrK1hOZ1BYazVyekRzY2RMb3lBV25HaytGTWlHeGVVS1R2RHJESEhsV3Fi?=
 =?utf-8?B?MVR4bVhWK1V2aGx6YmFDdzA0MU8wVTRjdXdJUFJVUTZjZkpkZGx4OGRIR3pM?=
 =?utf-8?B?aXFGQitzVWw5cE1VbzBrRFRWTnpyWmNrNk5zYzB5TXFycTl0RlNRY2Q2aStV?=
 =?utf-8?B?NkVXK1N1UHd1TDE5djJ5TysrTnppV3BmeThFVE4zQ0kvMmJTV0Y2eXo2RlBB?=
 =?utf-8?B?LzVYN1VlcW5jUElnYUZBMUVZTW4zRUxJVmc2QTFESmxhK1JFcjhRdmRqY2tu?=
 =?utf-8?B?dUJiS3NwTEZSQjZGYnpQSExBYjNvL3hnQWFDazZRVzVRdjZGYzY0enFkR3g4?=
 =?utf-8?B?dW9jWVZNVFVKbHEyTm5pUWNhTWZZZTY2bmxJVmtOaDFQTnRoM3p0V1owRHN3?=
 =?utf-8?B?bmhHWU9ab1QxY3pESmlZQTNFSFgvbzZZSjBubjNBeW5kNnFKeGZYSytVa3c3?=
 =?utf-8?B?S1JoNUx3VWtCY3VuOXF2Z2N4Q013Q3VBejZSNm9SMVduOWc0b041WkxNd2d1?=
 =?utf-8?B?N2NDVTR5SGlJSGtINlJGbi9OOUlRdDNCSnFUelVoSFQrdzBnYVR0ZVFCaFZm?=
 =?utf-8?B?WGgrTDlnSGd1a1dZaHI0MEVKaFBDcGltUzNLNUZsalBscmtMMWgyVHZ0WGlj?=
 =?utf-8?B?V0tKdmVDM05IRmQrSndFVTNiaDdwczJrUzJBK3NTdWFDQ29ndng3RzZjdDVl?=
 =?utf-8?B?ZjFBL0JzQkk5NzBtaG96Q2pDbjkvLzZGeDV6WitIRG1rYjRncTZWWGw1b1NZ?=
 =?utf-8?B?WUdKRWNBS3VvZmcreXhMd2ZWbmZsTEZONk9lREhzSzEzTktPMDBaUU9FcURP?=
 =?utf-8?B?eU5HVTNzcGlpS0p6b3VDTDhCcUZkRnVWTnM5eXorTDdPZWY0Z3paL2hLMHpG?=
 =?utf-8?B?MGtkRHp5QlFKek1nR3pqYUwvV3pka0J0MjZ6Wjg2OEJQQXh3TTg0YTdSbllp?=
 =?utf-8?B?OTVCelRKTEMyWlBjKytHdHRNSWw0bWwvZXY3VXVCT0hTSWliYkNFNitFTGV6?=
 =?utf-8?B?VCtibXJEeDlGMENWMjlPeE5YM0tuUmw5cU9sT29CMHhvSEIybmxWWDlEUEhB?=
 =?utf-8?B?VTV5UUJrSWxTZ3ppcHRHZnJGcm1JTjQ4OFpHR1hvZGxFanhIcmgxcjFqZnB4?=
 =?utf-8?B?WTVOcEZURjBrYjQ2OXpYbU4rbWlmTVFGSDVJc2YyUEozTU8zU3FQeGVHcVVo?=
 =?utf-8?B?b0Y2WmxpQm1FN3VWQ1BUcmRFb3Q2Nk40WnBjODJRclY0R3EzaWxxZE1JMHJ4?=
 =?utf-8?B?RVBWUElNMEhhaXJOcjUyT0J5ZTNKdjhZRnZsM3A4NUR0Myt5cXkzVnk2RUVj?=
 =?utf-8?B?ZjJVYmE2OEVZanRTSUtLelR5MEhKUUtqMURFVG9GZDNFLzAxQ3Fna2w0T3ZD?=
 =?utf-8?B?eDAyWjlZeGJjZG9ucWNjV3pHZW1qd05DZkJjU3l4Rm1vSjU5UVlFVHVQV0Na?=
 =?utf-8?B?TXFlRlV5c2FoY0J4MDlVOS9rbGJZYWZFamQzWHdlNjlxbUE1Y21NT2p4VVpS?=
 =?utf-8?B?dVFxN0dadmJNM1kzOWVGdElKajlpdUZJQzBlN3k0emR2RmQxL0dvQjBNMVhL?=
 =?utf-8?B?QkZRbkxWVy8vUUhuYklSZ29lQWNrUnh3S0JQdThpOHlJTGRPdlNabCtGWnRq?=
 =?utf-8?B?bnY2WDRZSEV2QTZyRVBPbHJUUjc5TW8xZmhjVlFZaU5aM2t5T0R6K1VOVm9F?=
 =?utf-8?B?dGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8fc171e-e077-4ce1-989b-08dd7dd40e85
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 17:19:48.8342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kwe16t01vqI1AUkTPj0iasTWSDPSSb8rTsuHxazv4ndxQpY+VwuntjP1gF+Dfz3IEt9DxWQhyNugOmZgN3yqTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6827

On 17.04.25 18:40, C Smith wrote:
> On Thu, Apr 17, 2025 at 1:09 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 16.04.25 20:26, C Smith wrote:
>>> I am having a problem with select() in a Xenomai RT Task. A valid file
>>> descriptor is associated with the serial device but select() thinks
>>> the fd is invalid. A snippet of the code is shown below:
>>>
>>> struct rtser_config Serial::serial_config = {
>>>     .config_mask = 0xFFFF,
>>>     .baud_rate = 115200,
>>>     .parity = RTSER_NO_PARITY,
>>>     .data_bits = RTSER_8_BITS,
>>>     .stop_bits = RTSER_1_STOPB,
>>>     .handshake = RTSER_NO_HAND,
>>>     .fifo_depth = RTSER_FIFO_DEPTH_8,
>>>     .reserved = 0,
>>>     .rx_timeout = 250000,
>>>     .tx_timeout = RTSER_DEF_TIMEOUT,
>>>     .event_timeout = RTSER_TIMEOUT_NONE,
>>>     .timestamp_history = RTSER_RX_TIMESTAMP_HISTORY,
>>>     .event_mask = RTSER_EVENT_RXPEND,
>>>     .rs485 = 0 };
>>>
>>> int rtser0_fd = open("/dev/rtdm/rtser0", O_RDONLY);
>>> ioctl(rtser0_fd, RTSER_RTIOC_SET_CONFIG, &serial_config);
>>> fd_set read_fds;
>>> FD_ZERO(&read_fds);
>>> FD_SET(rtser0_fd, &read_fds);
>>> struct timeval timeout;
>>> timeout.tv_sec = 0;
>>> timeout.tv_usec = 250;
>>>
>>> int ret = select(rtser0_fd + 1, &read_fds, NULL, NULL, &timeout);
>>>
>>> The expectation is that select() will unblock once data is received,
>>> with no errors. However, select returns -1 and an errno is set to
>>> -EBADF.
>>> My app prints the strerr() below:
>>> [ERROR] 10.746 ms IO Thread Select Error: Bad file descriptor
>>>
>>> To verify that the file descriptor is valid, immediately after the
>>> select() call, a read() is performed and valid bytes are returned OK.
>>> Why is select returning -1 and setting errno to -EBADF when my file
>>> descriptor is valid?
>>
>> Did you double-check if the cobalt select syscall is actually issued?
>> Maybe there is some wrapping problem.
>> Jan
> 
> I single-stepped the select() call  and indeed it goes into the cobalt library.
> It was this call:
> XENOMAI_SYSCALL5(sc_cobalt_select, __nfds,  __readfds, __writefds,
> __exceptfds, __timeout);
> which returned -9
> 
> I am using: Xeno tag: v3.2.5, ipipe patch to kernel 5.4.281 (I must
> develop on this version of our product, BTW)
> 

OK - some bad news: no serial driver implements the required callbacks
to provide select support. In fact, only gpio, rt-tcp and udd do that so
far.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
