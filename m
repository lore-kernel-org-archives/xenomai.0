Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2045.outbound.protection.outlook.com [40.107.249.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5CF25774
	for <xenomai@lists.linux.dev>; Tue, 25 Jun 2024 15:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719331093; cv=fail; b=bzNVFJe96KCq4SZq8lzBFHq1phF1dk4fzgegxXryAYNXPFfcHT1FH6G7deRWjHQDBmcy4qOoEgVfz7NTIaATB/GerXdhDvx9CLX3nMDMDUiAqlLOzX9WPzBeLKbjb1mz5U3sTUSd1/2jXs7Py3okGmSo3bRFiRzaEnq9kV8PtA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719331093; c=relaxed/simple;
	bh=HAaJkd6n/J0sTabbaFM4+/YA8OLUZEoELP9tpGEyl7E=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hfKWNchjvH4ZWbcfxgeg3ElLjocmghrWjxL/rOPj1SWfkoiHIAkIwCCdQ9gU+2Kcp5ast9niJrGVbmfZL2M2xBHMmTAt7sxAumUZ2wM7XwN9Zokm5rWxQtdKM0D+B67yVdK2UVK4guV7ergsfV3orBNbB8CmD/jEdrPp9PIFX9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=fRIacDfD; arc=fail smtp.client-ip=40.107.249.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="fRIacDfD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MkUwrGCvta6MrRHiX4fdUDG8i3q1z1tu9bM+W6oWnsp8e2a6TzWY5wIhcVUEw+4Wg+kpKFf1qTVwmZymAa9ATfzJDM+yOkMn1DgmEX0RVMb9A8HaWtg/FLXKCrI247KX58fqB/1YIfTv9xvevQiwNfO/waGQztz6srDj4u0pW3cs1PqKlNx4XfrkwkfsnDmhl/O12vqNP08sI4WZs4nOpUi8eIx2vH2tNUuIf5ZrE7o6S3b096lsrxAvySlUQ3c3fa7Jr3zF+CCyuyrT6Qs2MK6ni/EPrMP1D21hYAvEneSK3sN0/3fbqdxRAZEY/UUGycN4ERmQEJFsl/n7mil8Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oieyQ93xyJnFw4unLGtT4De//yGAjJX25/kOHFO4UMA=;
 b=X64vSgoQveXMgbhw9h109L9MNV2wAsoye1TskxHtH0pyghquOM+B0LosRmOSR9k4SrXiCqlbyVB05xSdRAhXuJ6wwhW41RBocA0lXSBRoqZwJgpOcodAQN1vqMZGkjDwtL+ij9gQziXHYgMFdTcTPYVXfoRvos276W/toO4WjPJ6pL4ilWfVDMvYNBpkYhI7+kBkysdWh13lY+ChjB3bzVnb7TQaTSdsalW71WejHvB2lhAF9lGuAPxWO9i/EYBKWta0p5HD2u7oRvtVQTwlfH450nl2v96GR7tneW/1dwG2trjkzYfRly3pSOpglTskFAeK4w1unbaLBu7PFiPBHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oieyQ93xyJnFw4unLGtT4De//yGAjJX25/kOHFO4UMA=;
 b=fRIacDfDfAw8v1NZlNiKDIeIRLc+CJXCrzTflpFRvFBNFBd2PauIJDH+tX3udrVXVgi+rN2Mt8B9iYoaO98Vx++Ph4sfqUyzmFadkL3TMcPDRdjoFtWJeVUQZSPKznaCFkqgpy++vKkq9YRzVEvG5nhnvPLCSBscPam01OEq5Z79XOHA3VRf42UYNcR1MPGtaEHSSK5hIpsHOYwKLaPWZ/I8pq+zgQJRgT8k/hhKOp32OBA6UKKoRyl2m6af/ApqbOBemUVd2kWIKSOKQX0tfiVWMD1eci3eNWBOSgOiTOqWDmduXyKLDVQCuolEGF/B+g1l4z5A9vX9o6/QupHpaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB6183.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:58a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Tue, 25 Jun
 2024 15:58:06 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 15:58:06 +0000
Message-ID: <35962c14-e3cc-48c2-ac9e-d5d36c32f0fc@siemens.com>
Date: Tue, 25 Jun 2024 17:58:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/14] Assorted Cleanups For prepare-kernel.sh
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at
References: <20240624203341.6263-1-richard@nod.at>
 <dfd637b9-9ffd-4952-848e-5b57cde21ec3@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <dfd637b9-9ffd-4952-848e-5b57cde21ec3@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0096.namprd03.prod.outlook.com
 (2603:10b6:610:cd::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB6183:EE_
X-MS-Office365-Filtering-Correlation-Id: 2591ee12-323c-4816-7934-08dc952f9a67
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|1800799022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDRkL3ZTYW9WV1gydHBZQjdQS3E2OEVOWDI1eU4zZXF4NnVzaHlCaDdKblpI?=
 =?utf-8?B?MHJ5YStsRnl3K3IxVittcFNFM2kyY0s0Rjc5YWxLYWpCbmlqdmtmckdmVlg3?=
 =?utf-8?B?LzQ4RWg2TnZjTGZaVUVhUXk5K0dWUWN3MjZJd3NkaWJpcnRHRHl1UDltdkNM?=
 =?utf-8?B?VWZPYlVQbTNlY2FkcGZESXliU0VLRE9rZkhlRk44UmhoQ2NvQnlKR1V2aVcv?=
 =?utf-8?B?OHk3OEhpZUlRRzRqNTNFV2RCTWlOSGZ2NStpL1Z1NDVuTTVvRUcwK3lCc1lw?=
 =?utf-8?B?cG9xRCtucVpBUFhibXd4VGVPRWRlb3cvSEVnR3d6bzI3c1NySGcyeFcrUXpn?=
 =?utf-8?B?aHpWaEVKamU1R1luN0ZqajdEWHJuWWM5WHBzY3dzdXRxOUFVcWhIMCs3TmJD?=
 =?utf-8?B?TzRMcEdPbG1Cbzg0aVM1eWh0S1V0bnJMOTNrVnlRblQrOElhK0VoMFZwNnR6?=
 =?utf-8?B?YzJkaUxwSWt4UVpnS09TaGIvckZJOEVvRE9oVmVEMnU5d0pqeHR0QUM2OWFy?=
 =?utf-8?B?N3JNaE41N1dQZ1l6VnFHOUp2NlFIZ21PWHZST2RkcTVhRmFVVnBJVXBtVGFj?=
 =?utf-8?B?UU9nY3NaQ2JMa29FSWhJZUl4YkVtSWR5c0poUGZWWE0xN2hVaXNhNXdrQmFJ?=
 =?utf-8?B?L0F4WmNrNUNDeGI3MXNYbU0rU1UxWUhqbjVjZDZzSDV6TVR3R3NVU0VLaWxh?=
 =?utf-8?B?OGZWdHY2bkNMRUVFQSsrMUN4dzRCd09UeXVsQnI4Ly9hbkNnSEpCSWVDVVNn?=
 =?utf-8?B?TGxrY242VkxYbW5FanJnaWFndmhNYXFsdFc3NGZDWTBXR1VKdjE5NGpaNkpT?=
 =?utf-8?B?SWVmc1VnLzc0ZEFhd3U4R1FJaUd3ckFvcExESmEzaU8zeGpWWC9mWGpPMS9Q?=
 =?utf-8?B?WkxYbGFZWlpLbmo0aGZOd0tabHh2RHpNZ2JMOVVIN1YraGNhQjdUQmpFTEw2?=
 =?utf-8?B?OVFOZ05odDFrNHBBM2wvQmFqVGQ1SFF3dFV2RlVva29kNGZaTVNjSi9XVFhw?=
 =?utf-8?B?VUFjMkd4WDdVaDIrZTdnV08wVEt6bURhbi96WEYzbzU0LzNGeVByNDFZa1FO?=
 =?utf-8?B?cmYzL1dOK09SYnBIT2VGa1d5WXI3NlJLWEcvMnZvODRROWQ3akdhbnN3VkMr?=
 =?utf-8?B?T2VMUEZwdXdVSTd0dHVHRGcyRTBGK09uNHE5RjhPRURJbmZzbDA5Qk1BSUpH?=
 =?utf-8?B?b0J2a3FXOGY0cEFJVVNQY2Q3QUw1MEJJdFlNUDhhMlBqVFVNU1pESVp2NW42?=
 =?utf-8?B?S0JlYU1xczNuUVpGV041RzZ2TWJISCtTMDBia21VWUsxQ3hFdk1qZGlmYnRz?=
 =?utf-8?B?QlJ6ak80eW1ML0Y1L2dTUk9kc2VFeWZtOG1iMDRYM3RXSzZvZm5qZHZnaTly?=
 =?utf-8?B?WVpaYjZnNzF5TmN1eEhaQzV1ZUkzTU9WVHNmcHJBbnp3V0VRWE93d05aWklT?=
 =?utf-8?B?b3RpL3MxRFVtYWVMQkxmMHdmMEVpOUNKbnZNNURBRERBcHZ6TWIxdndXcU9l?=
 =?utf-8?B?WUFERThSM0lkeUcvbEFkRFVWSGdobjJMYzE2WWZVb3ZNMHY2eXlFYTNXeU51?=
 =?utf-8?B?aTVNRUlxL2tBNmQyVVNZeVRMVUJMaHd3bExzVEJya3FtOUVxMTNVanpieWV4?=
 =?utf-8?B?ZEtUMzFsdDVVYTV4Q2FPT0JIbW9jWmJJR2l3U2w2endDRHJGMWQ4UHhCaDhu?=
 =?utf-8?B?UVJFT2FNbUlYQ3Z3WVROYklZa3pxanNldXArM2VWVFJmWG0zeGM5aUtFZHZj?=
 =?utf-8?Q?maUUvI7ym9cJpTluI4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bU4va3F1YlQzZG02NldvakQwOVZ2WHBndHc1UGs3UUMzZXZHTXRLVy9KK2pl?=
 =?utf-8?B?ZWxQZU1yR3B0czNzbWd6Mjc4YWpMTmx5K0l4NU1Xc1ltQnJ1ZkdsZWgvYzRl?=
 =?utf-8?B?K3FsMXRySlphV0lLMXh2WGIzZU8rYjAzL1EvRHhIL1JVbEFuNjhjcHVOcjdp?=
 =?utf-8?B?U09KRGxpSUE5Rk5KKzNGWENkVFZqdy9WejFLY0lSckxjWHgzbllYblk5dStM?=
 =?utf-8?B?MXB0czBCWXl0M0dNTW5NV1VlZTRmV1kxditUQkFUZVFlVW5YSFpjZmx5UmR1?=
 =?utf-8?B?bFN0NkhuSEYyckh5UGJiWGdyVzZlaDdmb2xCUlFvaXppMlAzVDliOGVHZHNL?=
 =?utf-8?B?Qk5GVTlYWmZXUTJEQmZ4c0d0bGVIWnhiY3JIMHJ6dDVUb1ZjR0dDd0dCa2pO?=
 =?utf-8?B?VUdJbkJVM2NrY05xQlNTbTd0K05aUzU4MkRIV2dqVEV1d3VtVitQUlhKdHhF?=
 =?utf-8?B?WVYzZ3lEMFdWWXJ6NW80R3VJRXVzTmVWdkxLdlRFTVNuamtqcTRNMlQxd3ds?=
 =?utf-8?B?a2NScmhJcXowN3dqbW9yQVVrdFBoWllsTXU4c2ZtOFFSLzBOamdJZW4reDdn?=
 =?utf-8?B?MkJLMm9ZOFFEN2QweDFzOTNqV1dKRjJMTi9GYlIvZnRjU21KdHVXL2lHTktx?=
 =?utf-8?B?UDRpbHpsZWxzdGV0eHV6bTU0TGh2QU1oZC9UUzdXVk9NMXN6WFlUR1J5ZUhI?=
 =?utf-8?B?Z0ZFREtlQ0tOdy90VE5PR1A4QUVvWVF2cHZpSzZqT2RVT3BqUFRaZFgrWkNt?=
 =?utf-8?B?bHdYbDhpdXIzaXFlT3RaMzMzN1V1UVg4UFFUTHBQRlRVbWhMSXo5QnUwTUY4?=
 =?utf-8?B?aFBxRkJmL2g1Wlo2MENVeStvcmUzLzUzZ1ZSSnpBSlIvejNJOFk2ZXVJU3My?=
 =?utf-8?B?RGh6b0UrZmZSZFRVVGRUc2JRdWZ6bE1kWFpvbzY5eVZCcVBHenlQOTNra1kw?=
 =?utf-8?B?Nkp5a29tNC9CM3dCbEd2TkM2eXNoRmd4WlBtQnlUeUZ4M2xMeU9JK0d0S0FB?=
 =?utf-8?B?K2hHY284Yzl1UjNUZVBVVnR0Rk1oOVVGRytuOUNpMWZaNWhyMkNjRkNJeEMr?=
 =?utf-8?B?Q2g2enBMMWhKUXF4cGwya2pmMWtRUXNiemxkQTROVDRMa1I1R2tSejFNZDVW?=
 =?utf-8?B?cDc1dVcxWFFBcDRFeXlpNkcwMEg3MzJqMW0vN3FOQWtURWYzMThMY1pYRnI2?=
 =?utf-8?B?QktKZG90dXB4RVBKSmlLWnhBWmx2djlDYjN0ZlBCNFBVY2ZjU3hXWUFDaFZv?=
 =?utf-8?B?eGZhdnZMZjluYklhRHZFVUg4WUpNOThrN0dQNnovWTJEeDJYS2pjNHlKU1pD?=
 =?utf-8?B?WkFGdGdOS3FuaE05Z0hmdFR1ano3VCtNeU1RT0JyalpSVHhlWVgxeTh4azd5?=
 =?utf-8?B?NU8vM2hSNzJvSUlGSDEwTXRmeCtBKzdPYTd4RXRIQ3ZkTFdScmFjMXliT0h0?=
 =?utf-8?B?SWZPRnA1UkduaXA3N2J4V3NHcVVpMEY4VmVYUFBSYmF4Uks4R2Evd2V3NkZE?=
 =?utf-8?B?T3hIWVcramFDT0xzUDNvY1JmRXNpZmhJQWt5SUJwb3JYNXdUL2ZhVDBUVksz?=
 =?utf-8?B?d1NDUHZuaDBHMzBRa0YzOXR4UUpKbHRpeXg1WEpOdExFRWIyNHRmS0tUS2NW?=
 =?utf-8?B?YW9vc1J5ODM4aWtNcGFKYjhkWDVoU1FPZFVUaFl0ckNGME1XMk52cjFkek5X?=
 =?utf-8?B?VGZ4WlczMVZPWFlsTHBYbml4TW02aXQ3RTROYUJwV0VDYnFwR2RRLzFXZlJI?=
 =?utf-8?B?bHlybWlOenJwenlBY2lOR09QK3FZSDlVRlVDZEJ3dGRUTkhOSUw2b3dxdEhF?=
 =?utf-8?B?aDI1dHowLzNhcWtMNkN3cFZBQUtMcFJoemYzRi9NcGw5SlE3RGZhTWh0OFpQ?=
 =?utf-8?B?V21rejI3NDhCaGV5MXZnUVRkWHRUNlJjZ29EZUd2N3pJbC9pcXd1ckJXRy9B?=
 =?utf-8?B?b21ML3U3TEkrQWR1eitLN0x3V3c4WUVwMW90bm1yc0N1SndVRE1lQ1Z4WW1j?=
 =?utf-8?B?UU5sWDJyMk94UU96WEVnTXZvNGNpQnVSTm9CalhuVmJIYlNUNFJEbXA2TE1y?=
 =?utf-8?B?R21IQWRhODMrNTdRd0E0OXNGZDVtNVpkVjVvdWxJNUlFeEVmWHdxYkhKVXNw?=
 =?utf-8?B?QUd4dk5RYTNnZkJBTS9XVC9YOUFFMEJFK1kvek9RQytFbFhvN1ZqY1MxWnMr?=
 =?utf-8?B?VlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2591ee12-323c-4816-7934-08dc952f9a67
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 15:58:06.7803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SY7n9LbwWKAZPA/tdnj5dQZPNzcmiErJgtKy0jPCl4Cg/YkBRRFhkQw4sBMEx6XN1su6khPxBUgVw7mRuOGYtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6183

On 25.06.24 17:46, Jan Kiszka wrote:
> On 24.06.24 22:33, Richard Weinberger wrote:
>> This series contains the following improvements and cleanups.
>>
>> - Implement --reverse to undo the effects of the script
>> - Emit changes that work on any architecture, renders --arch= optional
>> - Switch from /bin/bash to /bin/sh
>> - Make shellcheck happy up to warning level, info level is still a lot of work
>> - Convert the whole script to tabs
>> - Remove dead and in vain code
>> - Various fixes
>>
>> Changes since v1[0]:
>> - Rebased to current next branch
>> - Reorganized patch series
>> - Worked in feedback from Jan and Florian
>>
>> Richard Weinberger (14):
>>   prepare-kernel.sh: Convert to tabs
>>   prepare-kernel.sh: Add reverse mode
>>   prepare-kernel.sh: Emit architecture agnostic changes
>>   prepare-kernel.sh: Improve kernel tree check
>>   prepare-kernel.sh: Disable SC2115 warning around $linux_tree
>>   prepare-kernel.sh: Remove --filterkvers= and --filterarch=
>>   prepare-kernel.sh: Remove interactivity
>>   prepare-kernel.sh: Don't depend on bash
>>   prepare-kernel.sh: Remove --forcelink
>>   prepare-kernel.sh: Fix dovetail check
>>   prepare-kernel.sh: Define command line variables
>>   prepare-kernel.sh: Remove dead code
>>   prepare-kernel.sh: Don't allow uninitialized variables
>>   prepare-kernel.sh: Remove kernel version check
>>
>>  scripts/Kconfig.frag      |   2 +-
>>  scripts/prepare-kernel.sh | 587 +++++++++++++++++---------------------
>>  2 files changed, 268 insertions(+), 321 deletions(-)
>>
>> [0]: https://lore.kernel.org/xenomai/20240525115806.12101-1-richard@nod.at/
>>
> 
> Thanks, series with smaller adjustments in next now. The final diff is
> limited to whitespaces, though.
> 

Does not look good yet, at least regarding backward compatibility (we
didn't change our CI rules, so...):

https://source.denx.de/Xenomai/xenomai/-/pipelines/21335

Jan

-- 
Siemens AG, Technology
Linux Expert Center

