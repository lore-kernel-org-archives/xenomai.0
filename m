Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2067.outbound.protection.outlook.com [40.107.21.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9D413FE0
	for <xenomai@lists.linux.dev>; Tue,  5 Mar 2024 17:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709658318; cv=fail; b=VDNddnw/qY7KJzRuuVMBJeRHF5ZigJVtAYjf0xOqQDJOM/5fNJEMuk+3XoMObMRi6a3qGcEi8NqMUensUmp6MPGfwhfFo9Jy79HAVI20CVrirvj4nAoH6lC3Z/iFd/nBYaYqNKnyWFxcO0aEljV8gzr8umw3pLeeKUTAXcR7dzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709658318; c=relaxed/simple;
	bh=MPcGi1BWTPUtSxGqXHE5FgJZwyUm27etncC5lFBUKOs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZLDIHn3LrQSYZBkBXX80ls0FOGdjjJ9QNAkzf++6cQ2LxGscEDflsuY8q7MbzOIsDej+Sn6xOsI+kM0i43VmAS9ajgC4Z7HQvbwmP5essFhY9bPFzNErNLGKD8EnTEzDeQokjQUcz8/51nowAv6LUAiFG94ZBa19EsTO/zJ2vCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=T4v4nIet; arc=fail smtp.client-ip=40.107.21.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="T4v4nIet"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X030Y96UqPPv2wOwVyZDHFUaFab06I+0A+CSwJlJuBlaUgzll362PLGE4T66zZBkz25PwV730pKnK2lHQKKqOKbjmx21VdQjPitLP7npL4VxQR20q6KDAn4VJhFXddT+vqPjDITtrSQ2mhLNCQKuvJHo8mijlN7F8f4W5bZ027ANc+Bzl39xYnLm3QYlvITOryQ36FqRcIFXNCMiTzMzzm0A0mymqdJ8l4kjgbutnTnK1JdjImMG2wf3LUw+9tGnHGGGsej2jAQj6Hjtuiuu8ee7X5986Xo8giU3ZmQSNT8CgeVriSrIQA5HqPUeXFHDzHCQ3Xpuhcg4ypQeLMeKwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cv8gUU6DlfC/GJfV9gEHKJhmNAnlBUyingAqDZ6HzLg=;
 b=WsPOXG/jkK5tsqc0WTUj3hP2Lv5k3mtIIR++KJVAg/TXF8Q1TMqQPTCHIU0irzwQYHNk63qeZGj8JSqV4zN4+B9nj/qfv4GFocTobMNpuYsbvGZOUQIC//DTaJbWVnEZCOTD05tU7NrbJBbwvTst23iQpWm5xa7MQ7NkmUZvtag/1SCxhdrL/3dCsXcWtdV3OAuGdW00dWbYdQs9cTvBLzRKAUMkDY5kBoBDMeDg/W52w40+2AJaKkN3nEmjx2Ywk7E30VzO3ltx9hQTNGbOUXDtfCLzzGfO6NAlQ65tSMXzuD90MlrMmihLuD6d4MfHW7VkPoGSbQCiNPpSCfe/Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cv8gUU6DlfC/GJfV9gEHKJhmNAnlBUyingAqDZ6HzLg=;
 b=T4v4nIetL1/UVQRDkmFStBRNtc1EKnD5LpQUwWErwNm3O/f3aa780lKS4AUH0Fmvwno46fl0Ib0swAkOanANSLwYv7259Qe5ETzBJxw5OXsmxXxLly3QcsUbh5UH1oAHNt6sRpB7nIEV7JvIXBYR4SqNdrB450SO+fARNEcg0OrqzacKmfr8v7aNg/yGQ5aH6kFhp+4GQdaOBEJvW4ci/ArWS7hJGA3cOAdih5kr0IWLF8oRedigxbHnbjbvMI8b/toh9rcgbuvZTCKhczOQOCms9+NCnFjfmi5p5ep0RZF2kcoNmaL5W9ERWnXDZfM02FXOqK/T8IeekzxxJjmtjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3474.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:154::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 17:05:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 17:05:11 +0000
Message-ID: <8b3ae00d-3d40-4531-b236-ad6bf2a8bfd9@siemens.com>
Date: Tue, 5 Mar 2024 18:05:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] [POC] test implementaion of rt-signals
Content-Language: en-US
To: Richard Weinberger <richard.weinberger@gmail.com>, xenomai@lists.linux.dev
Cc: "Bezdeka, Florian" <florian.bezdeka@siemens.com>,
 David Oberhollenzer <david.oberhollenzer@sigma-star.at>
References: <20230816101842.3377643-1-johannes.kirchmair@sigmatek.at>
 <CAFLxGvyhP+qEfrZQVvOqrLbLmhq48k2G5aA12b9sowKXZeDtTw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAFLxGvyhP+qEfrZQVvOqrLbLmhq48k2G5aA12b9sowKXZeDtTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0311.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3474:EE_
X-MS-Office365-Filtering-Correlation-Id: 2495f409-4b9f-4865-0df9-08dc3d366af3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	faKFG7yeLmlWHYYuzCTvKmyu2YZbUkL9jYEiausCxAETeRd3XyO6oQL47YKZU9I4i7BcWqMJ512xjNMZJug3Rd2b3fgiqDexBLUm1awON9TPGVVTR6FBukpgTVMEb7B3KbKC7L9ZdF7SpiNXUYe79PU9FzBAW85HtHMe/c+RSEeC44ye4mfkelZaiLsJzmffp+khwc50mbEcKCR3Lpe/3GbXeTD7b9pXHCz/1FHJ9HwoMZDXk5OPV6Em+EjSHyd/5r/XegTPmgH7AjfYkgcwhdCHFf/I63CM5QS9WtT0uRdba0OPKyYs955MwY3HG3u25p/mtdAdHVKWGe/qqhJIkWva5Mjx7rrTqbpQhks7tCVz7mJmZbZqcL1Vko4bDKidG0mrD/5ZKu9YjXRzSIAqPO1yZqY1vGW2gs83Nxrjd/fMg4Ug6GAeApmrzzSUJhSRFn3+mRs8GuUMxZ2A2159ZKi3LAK0ju6p1oPaXA9JO3ZdlUwp6FZj5izID4KPGqYQa95P8qkl80sZO+pDd+iDA6WcdjXVIqvPxByDR3i/6L9KxLldNqTFMdCfv3ZscleNupTFlu1tFM+HDEePtoD8CgjfTiic1ICmgNwjlfzhInHUr0VY/Vpna420PjYWlxXx8/+EwCmiCZaD7clqdy1OTEImIl862hriwEuczrbnet8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlBOc1d6UVpWMTdHODhGVm5ndVp6WWg5REhwLzhVeE5uSFJWVGFTa2tpWVN2?=
 =?utf-8?B?N2taSDJDb3RybkNJdkpZVjNHU1djMFY3R3Q1eE10SWduaThDbThnOUZyZ3RN?=
 =?utf-8?B?NFBhbkRRVWExSGpDa1puclB3MUhqRCtDSEwrMjlxeFJocUV1c0k5RlJZTkRK?=
 =?utf-8?B?dHVPWDR4RDBLY0dpdFUzSWxKODFnSTJEOTdCbUtRK0draEdRNWpqQ1lvNTRW?=
 =?utf-8?B?QURGV1hpVUpTRjlSbzlIZXNTamxoSFlvNFhtNHZpTSs1NEVMTHhJeWVRY3pV?=
 =?utf-8?B?OENGaG5ldjdJdFhEOGNwRUdiYTBWd2VVMmVwRHJUT3pCSm9mYm9lUzlUSlc2?=
 =?utf-8?B?MGRidmhBblpHN0V5ME1iZGZZbWJPMWZoZ3lOMW83RDBaUlVxbTZydHdGb1Z6?=
 =?utf-8?B?TTlkZFdzTnZYVGxCcFMzNnM0eExXUklUTE5uYXF4Z09vSmZyL3NkQS9rMkdM?=
 =?utf-8?B?TVhXSXBtQkdyMUZoS1hxNkxnTG9zdVpydjJ4M2NlaTFnZHFvY0htNFBLQTdB?=
 =?utf-8?B?V1h0MS9VN0hYQnhrZGt3endQMmVVTVp3azBRVGswWitQbGtGdVhhaXphQlRk?=
 =?utf-8?B?c0tTcHpXdFZ2VTh4NDd0THY3SjVrSXdiT2RPNDUvdEVPNUtTZExQdnY4QUhX?=
 =?utf-8?B?ZlZ2c3FFU1hxZXQ2ZTJ3WkQ5VDZBWXcxRzNBdXJPSlQzclBCc0pkMGxSVEJC?=
 =?utf-8?B?NWJVUTFlT0xXd24ybVkyNklwWjd3MWkxeEFwOWllcmhrc2NsbTZWSzNJNTYr?=
 =?utf-8?B?MzFjV1RJZjh3RjBqRGFTaWVmbXM1M00wQzJDQXFUditqZzFRNjd0WVFvalBo?=
 =?utf-8?B?dDE5VGxMSit4RmNkd0V2OE1LUDJSZk0wQkpvVFJ2L2NYVEMxQnFYTC9OT1d6?=
 =?utf-8?B?V2tpTjlNc1Y4dUR5UGZDazRzbVAzd3I1YmRBdDlmcUd4bXVXeXhiOS9MVFNp?=
 =?utf-8?B?WE9ZbkpQTnA4MTFEdkluRU5FZm00ZkZ6aUp1TkxORURvVHVJZFlEdUNwZkt6?=
 =?utf-8?B?bEJENTI1UVpDRUUwY3MrS3FmWkJNOWE4eGdXOVZLdGVDTXRacWRqMmZTRnVj?=
 =?utf-8?B?MVpLOERDemc1eWtYdWx0L05QL082a3g0MmpTZWQ2dmx6QmpxRkVzaXM0bXRz?=
 =?utf-8?B?TWlnWVJvU3NpYi9hbGZBclBxN1N5N1B2QWt0SGdHSlF5TllSQmE3YUg5S2hn?=
 =?utf-8?B?UnUzNEliS3VDK1VscHBnaVFodW40SW1oelBiOTkzWDNONVllSjZ6NHBMQzc4?=
 =?utf-8?B?ZWk0Z1hTZ0RDejVjZjdGcVdwRXRFUXpOeFRPeUZXQnFoSGYxTlZ0VnRud05U?=
 =?utf-8?B?Zm9NeFYxRnQzUVk0RlpPdUY4TVdySEZkeFFsWDdUME9Xd08rQ2J5RmtiY0U5?=
 =?utf-8?B?aE44NjBIVFFCSjhQZDVhMlIwbURySFBhR09NUmNySDNXVkFxLzlTbitPbmtH?=
 =?utf-8?B?SWlRQXYyWHo5TTE0dVR1Sm9CN0NWZ2FYVks0ZWduc2JIODNmanV6c1pIWUV2?=
 =?utf-8?B?WDMrb2pBT0YxTHhmUGJ4aHp2YnRjbUtjVkpUaHJ0V0Z5cVRsL21mSElRYWlu?=
 =?utf-8?B?enVUakRIazh6UkU4Z1RRUlcwRWNENXFNcWZ2ZEhaNFh6a3R5VmJKbEJYQXMx?=
 =?utf-8?B?WnNEbGFOc3ZnanNrUVp2cVFhRjZOZHNYdGlVaGlMSWRJU3dKZjN2bk1TUHZL?=
 =?utf-8?B?T1llQU9ET1UyQmFkNzYybXpLdmVRa1RPczdscUljZFhxTENOWDdhNlh2Szlw?=
 =?utf-8?B?SWVzNFhZVEJieUF3T1pjdnB0TDVqcHVTMnp0SUNVQ3BQbnNmbENuUEFTaU1i?=
 =?utf-8?B?R3RRNXY5cDBjdjVBU1hUTTBRd0J0bFBXaXpYanB4WU44cWluMUMyZm1FRnlE?=
 =?utf-8?B?NDhaeGJkUXhGQnpGNUFMWEtkVCtac2JxS0xRYXdJR05Zck5XNEpMNkF0MEx6?=
 =?utf-8?B?ODVkKzMyTjdlYXNqbzcvTlFaRVZSZmJXbU5oZXNkVVEvTEcwUEhXOUlDUXhF?=
 =?utf-8?B?RVAzYmE3SUZEVXREMHY2ZldWcWloa2hzNXNES0FHOW1WNjBNZHFsV29hUVBZ?=
 =?utf-8?B?ZTg3T1BudExMbE9RNDMwOFBhZUYzNGE1ZlRIWTlUekgrVlRrWnJCWDVtOGY1?=
 =?utf-8?B?Z1hUeHNyMGw1b0UyMlNFSVhoSlZ2NzRNOWlJT3JQUVQzSlZhNldHa25ReHpl?=
 =?utf-8?B?VXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2495f409-4b9f-4865-0df9-08dc3d366af3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 17:05:11.2432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ax5DcdlI1YLecORzLgCzBkaICyo3izwA15s57B1vhi6lIF9T/IoU3fQag/QjGnXhqL0SgJHOMmEH8Qg505ePwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3474

On 05.03.24 16:54, Richard Weinberger wrote:
> On Wed, Aug 16, 2023 at 12:19 PM Johannes Kirchmair
> <johannes.kirchmair@sigmatek.at> wrote:
>> diff --git a/kernel/cobalt/dovetail/kevents.c b/kernel/cobalt/dovetail/kevents.c
>> index 4da4f51b7..61417717b 100644
>> --- a/kernel/cobalt/dovetail/kevents.c
>> +++ b/kernel/cobalt/dovetail/kevents.c
>> @@ -57,6 +57,9 @@ void handle_oob_trap_entry(unsigned int trapnr, struct pt_regs *regs)
>>                 xnsched_run();
>>         }
>>
>> +       if (xnthread_handle_rt_signals(trapnr, regs) == 0)
>> +               return;
>> +
> 

This is not the version I shared. But I assume the issue applies to that
one as well, right?

> While continuing Johannes' work I noticed a problem with this code.
> If we happen to trigger another exception while setting up the signal
> frame a domain
> switch could have happened and the subsequently call to
> xnthread_relax() will crash the kernel
> because it works only when we're in the primary domain.
> 
> e.g. if regs->sp points to a bogus memory location in userspace,
> xnthread_handle_rt_signals() will
> not only fail but also switch domains due to a page fault.
> We'll return here relaxed.
> 
> My current workaround is a check like:
> if (is_secondary_domain())
>     return;
> 

Yes, this makes sense.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

