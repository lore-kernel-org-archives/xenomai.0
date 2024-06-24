Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2073.outbound.protection.outlook.com [40.107.14.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A61612F360
	for <xenomai@lists.linux.dev>; Mon, 24 Jun 2024 11:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719226922; cv=fail; b=nqjS2WxBg4TiR/YEDzFzj47OretjsZS/+u1HVPun3jtHWRmtPEa5R4/xjsKxbBuEdXty3eFbjUlyXQ7bu+kNUrBVevLOpvhb4NoT0QPpPcyTu+Uf5xm5xWuNYD2HQaJejwvugFbI7e/XPYybS94a/RvisW0rzTLyVE9YrMHe6Gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719226922; c=relaxed/simple;
	bh=Ktn317j2OCfzNnbiw//V/uO9LNrEpnvGQkMUIY/+65w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bKWUjr0BKnWevtFpj5JCxyBD1blNRbb+g4GLLzkYxvvG1KYODh9ki60ZRgh+wm/dJ3PdLlDxsjOeZ29x320TUPU2n3R4Dflna4DI1U99p+CndKbw3axbqNk+Or80BkdFth3ssXFtjepm1WkfsjeFQ8S5gJkOS+T+ISuQ/u5aSqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=JkVb1BQI; arc=fail smtp.client-ip=40.107.14.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="JkVb1BQI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYN7TWUSymemj9FQLRyZ7usNZbbg2BC672y3K0n09Y3pRBaAVJkUYs/3U5NeB1a+oQyjwMnFI7Fm9VHnpFfTWNGclTmhr7VnjyVtQvbb9nm+rmozxhVNtSwe168MwdpWGX2vCaBcKLmxj4aFUvD2EFeolCAxlbRpBVtixdJ/1mjcWnCKeNPi0hGQ0oHVKYkU65eiMHYGc4KiSWqBHOYYYOUsoH/QgGZ2YsEVpcW6rq8aywf7byqnWlABMk37gozSOc7NYDfcV5SvteIP6RXgV/1BVI4v4bHA1UsWIPCzFfWhzAD+wSDJAymNKBrzEoKS+etyD8taK8l6dZYVUczUMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Ii7lUeotUw6H2q1IDLQB0Jm5XzTEcwtqjFfcr7FGYk=;
 b=GX03V+tXg2EDkiCxfJd//3UmH/UFwbzg098GnZQInToXXaTTSYuJ6Fo1a2q2g+18gEXLxZszDYgA+BnzAcX4IbtucHSdmtsibiNCIjiPDPckOSffT9I2YB2wjpEhKUyl/NJRk4TcXXwfnpV0A0qzTXzuT+I2M3i50Vek3pUG60n/AxAGuCKx3tMbySJPmJhcxZVOuQSuAmRZNUra3aoEpWpCMYY++94MW1ZpvLL0V64RXGvyP3M6ErCOuZHE/eu1nQsbQX47rtwMSfRmLMZLfGiU4DB7l0JzG3uPStCyxSoGrsZIZodOOBgdHBTJMSpKfgCg0p7YqD4gcfuEL6mLUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Ii7lUeotUw6H2q1IDLQB0Jm5XzTEcwtqjFfcr7FGYk=;
 b=JkVb1BQILBVYsn3AKV6/D31WiQaZvHwn3Us4dE5K8Xye3I4aYB2Tt00oOPggRu5jNhQ89IOuJE4DlfgmAA9/ZHm1qcKNIaic5pRcvdbFOMN21q8fzJxK0Vzeei9qzlGJ77sYUAQIQNq/52sXdT6ES5/UBIuH8d1SAVFYJJ4Jd+Db73Q9orqzJuDM4zSPh6opcCwWh1skQSBQQGVHnGsSryTblbd8gd7iqceRCeg+e6uv1+5Jt78fjQpxg+KJV86Y2KPHASc+EzVI7PjHNfZest93EcbqKWfRK+m1SUPcvkf1/D8GUsQAot/4PEKMSlj9+39KACe5d8dVYGwlQUiIBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS5PR10MB8174.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:673::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 11:01:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 11:01:55 +0000
Message-ID: <ccacfe03-1682-47e6-928b-8436b191025a@siemens.com>
Date: Mon, 24 Jun 2024 13:01:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] testsuite: smokey - new testcase alchemy/task-11
To: David Oberhollenzer <david.oberhollenzer@sigma-star.at>,
 xenomai@lists.linux.dev
Cc: richard@nod.at, lorenz@sigma-star.at
References: <20240617091654.66342-1-david.oberhollenzer@sigma-star.at>
 <20240617091654.66342-5-david.oberhollenzer@sigma-star.at>
 <655ed859-97cf-4a9d-b9ad-08ad9dedeab5@siemens.com>
 <64890924-793c-4e36-9db4-761c391b9906@sigma-star.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <64890924-793c-4e36-9db4-761c391b9906@sigma-star.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0244.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS5PR10MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: b3776887-7c45-4cd2-6e6c-08dc943d0f00
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWRSQW5vL21iUzBRMkQzaFlOc25GSld4L0FIUnVRQ244aVZtOHQ3aGl4b211?=
 =?utf-8?B?eHpHUnJybERvdTdqSTJoKzdYM1J4Y3JhZU9xdHYvUU9FRGlidVdWdzBSVFZx?=
 =?utf-8?B?bE5USnBqNUFtd1NUOXdNVjh3bDlzd3FQYUo1M2dkZWZJQjNPSzdPVmxEMjhY?=
 =?utf-8?B?Rm1TTStlcHcvTU4zdytiYUl3RlU1V0NzNVFtUG5tVEQrL01pTkhIWnZQYzdW?=
 =?utf-8?B?bHVleU5uQ3gxYjFYS1MreGVEZzJLUlFzY0U4TG55Uk1MUWIybTltUVZMRGhK?=
 =?utf-8?B?SGpwdWd1VzRjUFJ6MVI5eWRRSFFpTXpXd0VxWFRxRkVENlJLbW5WTkhsRE5a?=
 =?utf-8?B?L0xTSDdoMTNSZ01uS2tONzdOSWljVHc4MzRTU2h3QlpjOVdCKzdPQTFmZW9V?=
 =?utf-8?B?WHhnQ0NSc2JPZEpSUkVGcjVvRnhtYTRURS9GQnlmTE1acGJUOXZkUXE4RE11?=
 =?utf-8?B?NHVVYmN5cWxLSE9DT0ptOHhhRjcreWxEbzNVTm5odlRLUVU5cGF5UXViWENp?=
 =?utf-8?B?WGgzaXE2L3B3eWRBaE9aVjlKTWVZd3ZQS3loYStJeTZDZzk1WExYSEgvRkVm?=
 =?utf-8?B?cTNDR0xwai96Unp4QWllTm14YWlXVlV4ME9QUk9Eam1uMURyZEhiOS9RdHBo?=
 =?utf-8?B?eFF1UHRCcUo5blozbFRmN1M0R3lkUUwxUkV5UGZnUk5CYzJXZSt5QU1tS2RN?=
 =?utf-8?B?eHhLSGZsYTJkN2I3QlZpZ3k4bXBUVzdGUEVaV3lVMXd6c3pIYVM4NldEOTZs?=
 =?utf-8?B?OXFpVUpwOW9RUUFaY3JDZzBtREp4RThsZ3JaMkZkMmFCbUFpL05LbUczL3Fi?=
 =?utf-8?B?UEdhajBWaC9XbTBheEFjSmI2bS9uUG9MVjVKa3VRT01sVTR1Sk1LSTlvMitM?=
 =?utf-8?B?OVdlMHBEaFA4YW5uazgvODlEVERXZ1JNTGRnNmhOdmR5STMzeGJaWTE0b25I?=
 =?utf-8?B?T081S3MyNlo4NldwaExVWlNRTzZLQU4xZFF4MUo0WnBKYkdTKzA0ZDFIWVVD?=
 =?utf-8?B?azBKQWUxZG1iUXlhS20zc0dyQ0h6R0lrWXFvdjZUZGtleUhYakxWd2FvNTRI?=
 =?utf-8?B?V1o1NHdyU2JhWjdFL0U4MFFZSmJuTXBEbU05VzlOSWJiNlpobkY5RGhUay9r?=
 =?utf-8?B?eVdyZWRqLytOUlJ1aHp1QWFCUWUvcTBpWFNuNGFYWTIwZEdIWmpoYTRFdGQx?=
 =?utf-8?B?eGFhaGJhRWFKVmVybzFOMDAwMW1XdjJsZXQ4ZXRSdStRZGJ6bGdqYlFYTzU2?=
 =?utf-8?B?cHgybUM2U09xVDJsVkxta3BKUWx6RkNDdGdTRzh2Ym12OHlzYTNuaGx2bGFa?=
 =?utf-8?B?dlM5cUNxenE3NS9KZFRCcWNtWTcvRzF3WFU3eXk4OGZhSFJTcEhuSWNlUW1l?=
 =?utf-8?B?K3BZTGE5ME96eFVITEVPY3JSelZPR2tXMFQzejRVMzdudlZTZ3BiTVJHY21I?=
 =?utf-8?B?NCtpWS9qbVdNTy9Ma3dUN2VteGFhdnpPUUwyTS9tRFREbFdDcmQ1eGtMaUt2?=
 =?utf-8?B?aEFUbGZ1dm1RQWJDTG1DOXZmeFh4WnVRT0JwM3ora04yVEplcFFzQ0lRbFA5?=
 =?utf-8?B?cWw2b0NGdG1UZzVsVlFtQXNoaDdpRWVaOGd1ZmRYaXpxZythRStxS2FkUy9m?=
 =?utf-8?B?WmFkNm5QRDFQdnF2TGpCL3IxdzRqbDNXN3VZYS9MUlh1YzFKazRiYW1CSWFX?=
 =?utf-8?Q?c6iDUGWFoce4R24YJi6u?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3RPZUE1Qk1sd2UycWlVQi9FL0w2QU1QQnA4YTNQZFpURzE3N3FsUmt5SGZs?=
 =?utf-8?B?aEpJOUJmdExhN3E4VDB3eWFNOFVSUWREOFljYk90S3BRblhHYVpROG5ZSFhY?=
 =?utf-8?B?WE9jS0JianF2TFV3NW9QK1JDMVlHMVhrOVczb1FqdzN1SzNYUXVaTFpuYkF6?=
 =?utf-8?B?QTlCbkQvNTdoL3pCNklXSTRsa1gydEY5OTUrQ1JVNU5JTUJOdFVaQTNGN2p5?=
 =?utf-8?B?b29VTTlyUFdDNDdjVm9HVHZJS3ZTQkJQRWZLb3VLanFjUmJlYjVjWlRqSzV1?=
 =?utf-8?B?VXFSRDEzRnoxTzAwc2FJNE9VOW9QaGt2RG0rVVEwVHVNdFpaa0JvOTE4UFNL?=
 =?utf-8?B?ais2NkpyU1g3djZheUV3b09RamhFUmtKdUZRdmJtT2hNdE5OcENQT25SZmxr?=
 =?utf-8?B?cHNyVjE3ejNDaGw5M1RoNUhjVlJPbWE3WldrVS8wN0YwUUtGemhOQVAwZXhD?=
 =?utf-8?B?cFV5eUFwdkx3UUhIMTFaVFdFV2hrWmdPZ0lRN3RIWmQzWDBlRDdXc1dLNTRx?=
 =?utf-8?B?cFlwSVI2WUtGM21CTkxxcjU0UmtxN1A2ajdvVjBSSnpFdVJvZzZpV0dVbUg4?=
 =?utf-8?B?WEVUVWZ2RHRMV0Jhd0xvakw1OTJ5QVNiSU5kVld1bWhQUnU3U0VIbzgyeUpj?=
 =?utf-8?B?OXhxVDYweWxvR25KTHFDbmdZUlZQVXlzSUdTdTRMbmJPRFV6VVFNL1ZSQklL?=
 =?utf-8?B?aHdTOVdXdFJEMlk5OXE3dkphSWd2Z1JJN2pVZ0UzeVU0TW9LQjBta09WOWR4?=
 =?utf-8?B?UzgzSHpqWFpxRGdId21IenVpTWFGM3Fkb0t1bVY0cU5MT3AzU29iSmNNQnpz?=
 =?utf-8?B?SG9taldCU0o5bkJvM3lxT0FNYTl1ZGJKZkU5ZVBMd0RrSThKTStuR0s4TlIw?=
 =?utf-8?B?b1FKbEZYK0dnMVoyZkl3czdDaEE2NlFGWEJsT2Vrd2NWMkRMQTlMcFdub2hj?=
 =?utf-8?B?T0t6VUVIb0ZIUEhuVUg3YWZXYzBVRzhHMExNL3lvZ0ZyWXJOU0NLVVJEQlZh?=
 =?utf-8?B?OWtvRzF6Zm1VbUVuUWRjRHNXc3VZQk14dkdwWVRNTE9nM3dIRDFLMHJ1MWt0?=
 =?utf-8?B?U2lLaGUvYnRnbHFnRnpPcGZIVGRkZ1hlTzhOeTlqclJWb2dIdVMrekFDL1VM?=
 =?utf-8?B?VHdKcjNpWCtRUlJVRCtXVVUxVnh3d0RBT2k1d3FmRnVscFIrdDFyWUVSekNy?=
 =?utf-8?B?MXB2OW9sZ3RsTTRTZ0NNMjdJY0JSMU1salJSSmg2ampKcTB2QzNQSU9IMTZu?=
 =?utf-8?B?L3BnSjQ1YTdIcHNqWElkZ1lzNVllUDY4aWE5YjdCUHh1UktPbjBTdGxXRnJH?=
 =?utf-8?B?NUN4UkVjQVNoNkJVQTNFU2lINk96MlppYjZLM3o1S2M0alUzL09rUkJ4bHFT?=
 =?utf-8?B?aGhLcnA0VXNOalo0WkowMDIvWjFRakJ0Zmx5bElQVTJQY1RaQ2QzZm1oT05V?=
 =?utf-8?B?Q2NDMDVBbk9CdFd3NzU3Z0x4dVd4QURGU3k4bkF1L0hwR1J4Zkx0ZVNiNlJx?=
 =?utf-8?B?eVQvaG9nWW9NalBiRFZnclF4VGxTMzd3RmwyM3RlQ2RDRjVnWERpMTlPLzZR?=
 =?utf-8?B?cDFVWlpmY3lpQlBtYjViNkZOdTM4OE9pU2lxbUxDQ0VkWkdYbTE2MXdXTHQv?=
 =?utf-8?B?L0ROdlNyc2hab2hPY0lrQmZNUjcvMHZxMk1xcWhaTGsyaHlvNjhWTE95eVJT?=
 =?utf-8?B?NWs2MTRjbE9kL3ZLUENqY2JxKzJUL0NDR1c2aFVQOWREZ2p6NjB6Mk5Nam8r?=
 =?utf-8?B?bGtLcmRhdWRWdkFLL0NTcEdzTjBtSGRhODJRZXFkZ2pLRnJVMDk5QmhIOXRN?=
 =?utf-8?B?aEgwd3hkcUYxTjg2OG95M0U0aTdiSmd0S2tkaTEzYlFBTXZ1OWN2UUR3cFNP?=
 =?utf-8?B?eUNDWit3T2Jxbm1xTG9MNTdoNjN4LzE1SWg0cHoyWm95alBYT0ZrajN2WlBM?=
 =?utf-8?B?NE9pczV1bDBqS1YySVk2WGRONWtzbnVvUjdsNkVPT1FGaHRCd2hxM3AzVmln?=
 =?utf-8?B?K1pKNm9xQ0ZYODlOd3krR014azRUSFQxcVlWcWFyMmgrUEg0MXE1NzUvcVYv?=
 =?utf-8?B?bFVCcGZMZWkrVDNWRmRUYkJnOU5BUWJZZEd6Qmo5b0o2NGVuVTZCaWROeitH?=
 =?utf-8?B?K25wUGZHb1F4QTJNWHZvZHN2SjRUYmp4S2thQ3pLTm1yOWNwTFIzb25tUldz?=
 =?utf-8?B?Q1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3776887-7c45-4cd2-6e6c-08dc943d0f00
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 11:01:55.0747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K6BNQypSRctsVriQUK7V2GxWoAq63XDpTlvyZqV0WSaEfy/Y+spyv/+vBmc/cWmFbhBV7DqoHyPd/+dXP62DYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8174

On 24.06.24 12:31, David Oberhollenzer wrote:
> On 6/17/24 18:45, Jan Kiszka wrote:
>>
>> This causes sporadic failures in qemu, see e.g.
>>
>> https://source.denx.de/Xenomai/xenomai-images/-/jobs/852670
>>
>> Could it be that we need to add some "VM slack" here, like we have in
>> other tests already?
>>
> 
> In addition to actual hardware, I did test this on Qemu, including
> on a busy build server.
> 
> I added some slack for Qemu, and what I though was a generous error
> threshold, but I guess the fundamental problem itself won't go away
> and always trigger on sufficiently slow/clogged machines.
> 
> As I understand it, your fix compltely disables the test on Qemu?
> 

Kind of: test is run, but time deviations no longer cause a failure.

> I did find a `smokey_on_vm` flag that is used in the mutex test. As an
> alternative, the PERIOD_INITIAL and PERIOD_SWITCH macros could be
> modified to give it even more slack, depending on that flag.
> 
> But then again, the fundamental issue remains. I guess it make sense
> to disable it for the Qemu pipline as you already did.
> 

Yes, QEMU is inherently unpredictable, even more with emulated
architectures.

Jan

-- 
Siemens AG, Technology
Linux Expert Center
