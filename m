Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013057.outbound.protection.outlook.com [52.101.83.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54322550D5
	for <xenomai@lists.linux.dev>; Tue,  8 Sep 2026 07:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788853447; cv=fail; b=q7zOBR9Eyw3jlCWn+oNlbbBAK+T6v0kThoEiQH0SF6jKxKFOnt1IdtUFsG2BPcDXhGmQXknbZm6fFdYdwaXGlFpVKvxCTXSkoQZ6Myfki45RN1pyXVlE0YmtzF3pP9LJpX4imzHd/UDOy8ts8ztekkXRQvB/vPAUSf2X8TWmtqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788853447; c=relaxed/simple;
	bh=w+5I//2scA/GkiNSf4uqcZfqDzzv6JeMw8fTaR3BIjs=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k+81aCvWx0jTX44WnZIcRMa78gxjFrJncuhe6vVMDSgYYHYL9tNslTrLJZwR25d04gZEkGceztvQML24gHpWIUzl3IaTH/Od5s1cPfYIqnhRxu/6taWXGhy22K3eIg7Y3RqcvQ8FrMy4kxLO45lbpTNHDoAuZdmv/BicMGRIrpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ny5sH3gb; arc=fail smtp.client-ip=52.101.83.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ny5sH3gb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WCDFfW59+E5rdtRpUK0bNr12z3Ga38luReVgKU/3zO/dkfbXJI0ilWQavWiBrY0HVkmK5BZ8PnwZ5R4AkYSKDrKa8h4MiqmZqNcP/hSZrUaKMOjkaimoENF+s65TR0bI0WNyrqmGd5EoLRP7Xu7Wxq1Z8HDDyph66nzkp335MHdSlo3e0NuAmGRY1MV10Nkn/mzoD5x7kzB2vla7BUxvuaDSo44CyttKj5hn4tAXaEx5GaMKa8PAGc030ES5FhBt+Bx7ANTLr7ferGtuM9YYbJSEJ3LsOsAZyo0yBxUkyX/83/1EgwIOlh1YEMX/i9E0onpz9XzUeI1a0UikZkMNSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOsB7p0Gxw6v/Gbwd6OZdfk9kFtTmgxzKh94Z+ebYyk=;
 b=j5RxQRGpsqn4Yp2C29QxZuIRSs/ECJEe+ybg9aVzRKbshH8aukOmmve5Z9TQc6w0HjpsyxVKtDYbQ6pMdhmvLKp705baIg9hnNMYPpo8PB4PwJGwrAPifTTgTbTTdVIa6j3N0JPk8SttvfRb5wfdEMn77eScrTnzHSBzS/Q1APHhUCOvHFPOX6Kj5PIVMesoOFZ75BAb6PhDYqYH9gm2PIqM1jD5HTssBcuBhWEnHvaKFeUdu9NO5A0vJrurM3YhLDI6Cc/eGDj+xKE0wHZD047GZpjpTvhkMtemQGI4aEmBIyZMadpI9CZAEBLSW5/TNd2hu1xLx8WX20I5tyZUeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOsB7p0Gxw6v/Gbwd6OZdfk9kFtTmgxzKh94Z+ebYyk=;
 b=ny5sH3gb9d+T0Q+hIbqjYPerhW8us6fNjpVSXx61T+yrXHId4NSwhjrI6oHSFnSZ8poKan5CegjfODEhy22UOE38XwqaSkCJoxfTg4bx7GzcMarz0VjPQY/J3rwETuadyjQSuaSSvizyMHgOkTXnzCQF1plofB+GNf1c65ighgSJIlf7AZp5+rzWryKJHWAokdVQW2sKmaiZPSaQ0G1f/0csWqUKPLYHxyivqFgnFcQq0FAegofvmTXbLUOvvolCOWMiIkhQ/6FESVQl50rMVtZVS/tWMQkSbLgqr6KxU++UbC25DglP/m7TglWlw7jzBUN5cgaT0kQE7PG6IK9TBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB8281.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:386::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 07:43:58 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 07:43:58 +0000
Message-ID: <0d29e7e8-499b-46bc-99d8-a197927d06e6@siemens.com>
Date: Tue, 8 Sep 2026 09:43:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] docs: Fix a2x warning for PDF builds
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
References: <20260903083447.2220024-1-clara.kowalsky@siemens.com>
 <20260903083447.2220024-2-clara.kowalsky@siemens.com>
 <308d85c3-7e7f-40f1-8755-5a99b25d0015@siemens.com>
 <d508985c-bd9f-4e66-aaf5-5645e5a4f9dd@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <d508985c-bd9f-4e66-aaf5-5645e5a4f9dd@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB8281:EE_
X-MS-Office365-Filtering-Correlation-Id: cef44145-d5e0-4b90-97d9-08df0d7cf136
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|10067099003|6133799003|3023799007|56012099006|55112099003|22082099003|18002099003|5023799004|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	JpCJLlozBu9EVGx5r7xaxC5dpGeDXjCItLb89IA7v5gjJwothsPS5wEc3Mk8m5hDFM+aC4RUp8Mw+7tKL1wMCtv4VA7hnQb8B9kaAmuKEqu7Z95jceoBmcfM9Upd/IxYH9B254cUCdDHFByx0jv9gxc4fORIeXZuaYwiwRP9f0wYPmeHOMnv4hSC/rY7Xcg1HZ6/nzFnGkaXXl12ZgIi+BGp/v7z61khgKiuBHLcrjvhYU0JM2EBFuTdwERc9C7Up57VrViYDbJKUeF26wY1VhG9dxPoQzJBjbLfvzhtHHkqBS4bFdI6865ZeY2AWFXy15MzVhrr4XlLiVNx/DXIwJJE94g3/lg1kq9T0y+E6Gj1ZkyFKEiimZrPj8pgcXkyaFfmLb8M0LtW9t1zeFaHo27NxU16xKCddiZMfzeiNbXi7Zjq+Lsl4V7m8g5ucPcIAQZgwlCIqx4OXOp/06GuDDNQHo5w9X6ZXuFLtquWVSt2EhRHP6TxaIlJ3KWaWX7bAqWQzWTSXkGjagVJwQUg+L7l/BYR4myEaDukA+UMhoaaOGN7c8RdSZRuJfn53g6BD1bbVHNzg7Ksbxzj70V0/ntdS2Yn/uwfCx0H2FkOrIc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(6133799003)(3023799007)(56012099006)(55112099003)(22082099003)(18002099003)(5023799004)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Uk9DSGVmTVZ1bjBYS0dZVTg1Z0wvNEgxaHVCYnRhc3owNzlUUjhDaGlpNTAw?=
 =?utf-8?B?czFqd1ZuWjBuTDhUc1NmYkpqdXBvRG5ha20xTmtLRjg0Q002L3ZtVUdwVE4x?=
 =?utf-8?B?elNadmVyOVhXcHNCRDJrRjhZcnRVSHZIRWFseDVyRnh0NkVmNWtYTk54VnlP?=
 =?utf-8?B?anlObXNtWWNXdEJxWVh0U3FiTTYyYXdPOGo1MytDZTM2UDA0MmxsWGhQRmo4?=
 =?utf-8?B?MWlaNEMvUkVBVGZ2bnR4OGNDU3BlTFJ6K1hNV1k3WlBjUDgyM1dTRCt3Y2xn?=
 =?utf-8?B?VVE1SDNndzlHVjM4VzBnZEx3L0dhTnpjVjQ1cmtRVnJneXIvK2x1aDdSVmZC?=
 =?utf-8?B?cWVDdjlaeEk5ZjI1VThlb2psNFN0YXVSQ3JOYWUvLzBueVErejR4M3Z4ZWFz?=
 =?utf-8?B?RHNzM2JzeXQ5d3lreWRSVkFZa3U4TjBCZTNSajNzbDhHZXpIZ25BRm5Jcjc0?=
 =?utf-8?B?blRDb3dkYlRmNk1CTUEzcGtGUTQ2WktrT3A2TFFpdWJnTXlQdWtQSHhGTGNQ?=
 =?utf-8?B?dWVPd294UzMvSzFSUnh1RHBzeXhoZU1OamtsWEErdGRLVGRCNGhiTVAvWGxs?=
 =?utf-8?B?cTI0V1R0ZEVSNEprbEdkOFZJYlBtbE4xa3E4QllqN1NlSmtUSTNVL3lWb1FI?=
 =?utf-8?B?TVZWVkNnaGNXQ0VabzZqaExIeVpjbUkwOFZvczl4MEdJNGlIMzZ5QTZhS2o4?=
 =?utf-8?B?ZXVDSldJeTc1RXVES3VlajV4Ym1TbitsTGxSQUdCS1B1Wm01MnVvbnM1TVlP?=
 =?utf-8?B?dmp5bnpnWlA0dUkvUmJhbXZDSzEwM2NVNTNqUVNXTW1QTmxsRkplNFpycUs0?=
 =?utf-8?B?eU5kRlorQnFaTDF5M3RmZlpkaVFNVFdUN2xyMmU2NEhFSUV4N2xKNmpDZUdh?=
 =?utf-8?B?YlR4MFhxdVlibytkcHVPS0xJR0lha3h6d0tVQ2NiZkp5ZkQ1M1pYNnhQMDJt?=
 =?utf-8?B?T2pFWFptTFpGWHh2YTY3d3NTSnNjaElXd0p6My9FR2NmMU9STklVdHdyUHdi?=
 =?utf-8?B?TTNsMlJkNFlPdE55b1gyUWhSU2FOcVJCdjVlZnZrc3FDQzVuZnJjOGl3R3o5?=
 =?utf-8?B?WmZhZVVFMUVGY0ZzUlNoR0VqSDlKa3MvV09mb0dCYnV0RHpSaERTR05BKytj?=
 =?utf-8?B?RDdVZFA4cmMyTHVLZ1IxaVYvb1g5ZUtVdXdqTDMwZy85R3lYQmVFV2V3UzNJ?=
 =?utf-8?B?TzcyaVZkRnpqZUh5WFJjSjc1MERjNk40MGRpQXVkVlhHQVFzQ1JJZHZhejRv?=
 =?utf-8?B?bk9XZFliTHVWcnd0eVdnOTJIOGhPUi9zazlNWXB2R2NvUDBpeGVkT2tWcHpt?=
 =?utf-8?B?aThUU3orTEFBdXBhdlNrSkM2Q1dLd1hNbURtZi9mV0xvbUtBK1BKMGppQjZL?=
 =?utf-8?B?SFJkdjVsMDRYNGZNakxIVUxBUkxxVGQ3VTd3VExkVVhDRXJCL3ArYkVudnIy?=
 =?utf-8?B?eER5VGF4NFNqNnk0akQ5QythOTFuZmhSckVBVEVTNjVvaCtWTlA1MGNkYmpK?=
 =?utf-8?B?Ny84Q3RUejNEWE5rcUZPZ2NSZExmOWxhS3JvVDgvZGUrUjZSYXo1ZlliSDNz?=
 =?utf-8?B?ZWJaOWJNR0RjSHMyQllCc3lsMFJjRUE4Y2dQSytPOGt4NlhhM3RpQWF1MzN2?=
 =?utf-8?B?Q1k2QXNCSGJzNlBDYmFFR1ZwakF2VUhnV05DYys0M3ZBaFV2ZEovWkFXdHRp?=
 =?utf-8?B?Qjh2V0hMSnpiUWRnVTBJVjh6RkdiR3VkMGdlemFnbW1uOEtxdWhaVEJxYnZW?=
 =?utf-8?B?STBWcXN6emdibUswSHBscmxRYjN6Z0tKY0lQSWk3T0doWmJyUUZ5QnhuenZO?=
 =?utf-8?B?U1ZxVm4xVUpmN3ovVTBDM1BmV3FydVFod1gzM21IV09uQytMZmp0clRsaFV5?=
 =?utf-8?B?MjVucHkrWE52YTAxSm1teW1XMlZ6dDQ4QjY2cVQ1NWplRm9tSDRmU09sbkFi?=
 =?utf-8?B?L3ZGRGlCMUU1YnEyZTEvOEhtUGdwNnU1cWxKS2lBeGwya2ovZ3paL0R4bjd4?=
 =?utf-8?B?cjFDNHRxV2VGYzg0M0JIREIrS2dHS2FYK3IyL3RpZVAyUjNXbi9KbEsvOUhK?=
 =?utf-8?B?bWNzM0NHS1lYaU56S3Exd1JzSEtUQjI5N2dDSmZnUFhVWnBjOTZTWCs5cmVm?=
 =?utf-8?B?VGpNTXplbUptUkNIbGxzR3RXY0pJTzlDQ01senFzcG9tZVhhYTBVQW9lVjdm?=
 =?utf-8?B?WXo5MG8wSVNnZmVLTGdBNlZrMjUxeUFoRUFWOUhGUXdUQXF5VE15ZnA1Sk5C?=
 =?utf-8?B?ODMzUWduRWw2dW42WDhVYWR1MmtlNzVVNUJZcFVhbWdEL09EOUJRRlpjV0xM?=
 =?utf-8?B?d3NnVm5BRExSYXdXYkJaT3VnODhYTDJNRXo3T085OHhFYnUwbnR6Zz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cef44145-d5e0-4b90-97d9-08df0d7cf136
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 07:43:58.4947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0/ccSS1Jd0drVp/mx936c2xxSjadT4j4PBSYCNxJuy67WvBx7GumNCC7P0farG7QS1/2OKsr7oex+TlXRBHA9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8281

On 08.09.26 09:27, Clara Kowalsky wrote:
> 
> 
> On 9/7/26 16:22, Jan Kiszka wrote:
>> On 03.09.26 10:34, Clara Kowalsky wrote:
>>> The documentation PDF build passes "-D" to a2x, raising warnings such
>>> as
>>>
>>> a2x: WARNING: --destination-dir option is only applicable to HTML and
>>> manpage based outputs
>>>
>>> Drop the unsupported option for PDF builds.
>>> See #18.
>>>
>>> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
>>> ---
>>>   doc/asciidoc/Makefile.am | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/doc/asciidoc/Makefile.am b/doc/asciidoc/Makefile.am
>>> index 782c7a23f..669decaeb 100644
>>> --- a/doc/asciidoc/Makefile.am
>>> +++ b/doc/asciidoc/Makefile.am
>>> @@ -91,7 +91,7 @@ html/%: %.adoc Makefile
>>>       $(A2X) -f manpage -D man1 $(ASCIIDOC_MAN_OPTS) $<
>>>     %.pdf: %.adoc Makefile
>>> -    $(A2X) -f pdf -D . $(ASCIIDOC_PDF_OPTS) $<
>>> +    $(A2X) -f pdf $(ASCIIDOC_PDF_OPTS) $<
>>>     $(tmpdir)/%.txt: %.adoc Makefile plaintext.conf plaintext.xsl
>>>       @$(mkdir_p) $(tmpdir)
>>
>> Could it be that this did have some side effects? My pipeline is red
>> because of missing .pdf files:
>>
>> https://gitlab.com/Xenomai/xenomai3/xenomai-doc/-/jobs/16348492423
>>
>> Jan
>>
> Yes. When omitting the -D destination dir, the pdf is placed in the
> source dir where the .adoc is located.
> https://linux.die.net/man/1/a2x
> 
> build/doc/asciidoc$ a2x -f pdf -a icons -a toc -a toclevels=3 -a
> xenover=3.3 ../../../doc/asciidoc/MIGRATION.adoc
> 
> When using "-D .", the warning is printed that the option is not
> supported for pdf outputs, but it actually places the .pdf into the
> wanted directory.
> 
> As we want the pdfs generated in the build dir, let's omit the commit
> and live with the warning.
> 

Weird tool: complains that the option is not applicable, provides not
alternative to it, and also does what it is told.

Agreed, let's drop this change.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
