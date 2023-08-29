Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2041.outbound.protection.outlook.com [40.107.105.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BBE14F6C
	for <xenomai@lists.linux.dev>; Tue, 29 Aug 2023 13:45:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPpYBBoal+dN6sXLuyfHJ4Hk7S/rMMo7ByaQjAJZvVIfS8Y0AqOLnW0Vu5Cha66wJZOarvBMX676M2FSh1fVt3F9EzNAfijOzAoCJY1agCZjziqsqcpc8gnmqWP1yAPrbJ53nuwff7JNwWY77uZdrkengjO3fQXb+fwv3jVk55hK33fv0Tu6plxAXH7SFTTh8EfhE3FTKOC3fJ9WIKSQXX4L78PaF+xJSHCNqXlsrWrjlt9UxzMVQPadWwwutt+SR1EfPqqeDd2vjI/Qyv/3ooQxKz9qavdec07hq3U2549FpUFSMB/ZhKU/wKvd2A4sBgTS9ITtL2vTuxXMVGuh9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AViVgJbG4K5gZ0p6M3eboHkt1L6MWGR5XBEP9N+zfys=;
 b=jPJi77JRI594czy4Y2dr0IMZlvjl/UrpT8u0ZW0weDpckg3WYhtqSA8Dzt7QYSEiuDwODpZZ054n7Wob8X1ehclsgojgWtLZZnbKjoTXs+1Q/LzM7WrAIlyMakgg8FeLm26aJ3eQykXSE1u8S/XwsXbK/dhPwFPj4X2VY5DYXUodfl1nzAOzvRqulruwxmXoxLupsYZkDqkiRRojXIw9COrVFLP+eGtysksqbaPxtjx33QyF3w6k5hpXL442KfBlfywhQSX+XXMZ8bf5Ms1shQmtEDmyCdPIe9/e4/zfWSOUqxkNi9Xv29pHN8ikFC+VQcebr6J8VoqaG/QR4m+/KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AViVgJbG4K5gZ0p6M3eboHkt1L6MWGR5XBEP9N+zfys=;
 b=Y4IgLI6tse2Lbw2Dd9tIh2Wi5JQPe0QIbKo2MluiQfJSYSV+7S5WpvhNR/L0gUESa8E96l4LKtIEDbuPS/WBwndUkq4nbfx9hhCF/BfD/cg+DXxq5jU3W3tk03YzqyPdwGbYFLdz390mDozx+GZlD8aqUiN/SIm+Gkoig2PJ+dqbTgZeQ29v4E4nuZrD3mYr5Qaz7YQ+9OsSHmHDUBMzTi9UoVRz4xANUGLNl1drx0tbMG6ecURW+9VV6/movIhmbxQHzLm9a9hLC4WxHwU9Rm81lmUUXKWBlMhKaXxGiRrBLthqctmWnMVgMHZTkQ1fcUIW6v0kmKIQs/e+Vt2roQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7310.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:446::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 13:45:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 13:45:19 +0000
Message-ID: <edb713d7-3380-4b9b-82b3-6d8cef7c8238@siemens.com>
Date: Tue, 29 Aug 2023 15:45:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cobalt: Adjust dev_addr_set wrapper to 5.10, 5.1 and
 4.19 backports
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <f4a0e665-394e-46b6-ac61-cb3d3f76ea21@siemens.com>
 <d0819b6742607b5763ff643e9b7a540e5de7d544.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <d0819b6742607b5763ff643e9b7a540e5de7d544.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7310:EE_
X-MS-Office365-Filtering-Correlation-Id: 183ae5bc-c5d0-4b9e-0c8b-08dba8962efb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ilRs30HsdYF5eZvq1Li2K/pa3EqKd9sUGAxrrl5iCtDC6uib83sLk1SMUTr7trmr7P5EW5aeZkpylGRwYxV9UCJl/hanMA/+nYrSS+D9cMQrtt3UiLOX3PUz9hCI7fVTxlJ1PXDB+IKLJFF+gyKDkMG4r57tHHJysVhb0V36besONPqVz1gF0FyKE5vArC3Lg57+W9pXqtpcZORaB4+R1OGR6gzL9s7QYvN9NgmXC6b9tjHLgHKWB90iIxRkOEH7VJP8NgsQUTrMPeiAJsJXaokGsvrlv9xjjc57QjOr5Eq2AqQoUerZQivfil4u8YUiPAtnxpsjHc1SvHn7UyvCBtq00jOki2yLlloMLC7YCuKTMY9KunyvTuq/RxheladRIlwJ0NW9F+i++brYyEQEnCrrui5leittskyowSvojmm/8f1xya8RB6edjHgXhtDhkw8rhVaZxMaZb+ckTOFUd9Yc3vmvsonkiSVVrVUGxKI80P1aVM4jZgzzDqbvMBcrcIDrGhGT0/1CcNPskt/4MQPZA7cd1UTVz0KHyp+SAqRtA90R46JIRhfQP3hYt2DmO9zOrzBLrnzGz1+xJWJpWzlMZNat94Oi5pdTAGhUvcABYcYEyd7TUQGazCm22z1EtMhppgp62Skzz6ru7KYCEA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199024)(1800799009)(186009)(8936002)(66946007)(110136005)(53546011)(31686004)(478600001)(6506007)(66476007)(66556008)(6486002)(316002)(38100700002)(41300700001)(82960400001)(6512007)(36756003)(26005)(8676002)(44832011)(5660300002)(31696002)(83380400001)(2906002)(86362001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEgvQTRQQWJHUkswN0pOUHlsNzZ0T3RISkR1ZElpUkJxVnBSOGlhcXFzSDBn?=
 =?utf-8?B?MEt3UHEwTXcwYTlIQjZCOCttTTNCWmJ1QUwwY2Vhczl2ek1RTzNGekFwU3la?=
 =?utf-8?B?YTV0MzZYUUoxM0s0RHo4QzZHQWk1RDlpeDUyRkZKY2tRNEtKa3JORXNEdSti?=
 =?utf-8?B?SXUwVExCUDREaWV0R3VERzRHdnZCVkNhc2pwbUFJQmt3alVlWHR2VmNmKyt6?=
 =?utf-8?B?NjA0YWVHdjQxamxSb2hJM001WHJnbS9kNC9nZEFLak02ZnBIR3FyUndRRGhh?=
 =?utf-8?B?VmJiZEV1cDI1eGVwKy9RSkduU0RxQ0lKUTBXVnBqTmtvaHdwY3NXb3ZLN0Mz?=
 =?utf-8?B?N21qN0xYNFNUcGszRFplNjlxUkI2YmU4TnUzaDVLZnVabHFxbXBtdHlSYWJ3?=
 =?utf-8?B?eDZIRGZrQTlhdCt1K2hueG9rTERmVkl5WUdzOHU5ek51SXIvU2dwdTh1U2Jv?=
 =?utf-8?B?UTcrbS8yUHFGNTh0b0lsRTNYdXlhK0ZLbWVEZFhySXJPUXdkUStzVy95R0Vn?=
 =?utf-8?B?S0hLcno5YTFUUmpQNG0vTHpuWkpKK1VrSWJwYU5wRWo2RGFuckxwQ0ZmK2hD?=
 =?utf-8?B?RmFGWTdQQ0dIYmhTNDYrTXp5N0pPN2tUUUNLdXBXV3EzWDVIdytCZFM5THZm?=
 =?utf-8?B?RTRBT1JERmtWMGNiTE4xOU5nektxZ0NjL3RtQzhuWlJlMVN0WnRWcExmZll5?=
 =?utf-8?B?ZjVPZjlEV0VMYnNLM1lBN0R1SDd5Y3ppRWYrcTRQdDNLM3ZuY0ZYRU1QTUR0?=
 =?utf-8?B?eDFPUTZSUUNIM2hqTGdZRHZSN2JKQkk2bTFhbldnRDVPSDhsZTY0WUVwdjVQ?=
 =?utf-8?B?NGMyUFhadlgyL2dpSzZ0UWFVZytYaS9TY08rd2pqR3NWWnc4aC9UZW1EbEcy?=
 =?utf-8?B?eWRRbkp0NG1oMWI4VWpzcS9BNzdudEdqUldxTlJGWGw3aWFxb3VxUHJKNWdO?=
 =?utf-8?B?ZFRXM2VYWkdzRDZ0eW5zS05YamtKRk5PLzgzK3BteEVTNWt6cmRFQVh6N2Mr?=
 =?utf-8?B?bDd6LzcvVG50Ym1QVUxtOERoTmQ1WFRBZ1JweEt4em1hYkpzK3lrTTQ3dm5S?=
 =?utf-8?B?NU5kZ0ZnQkdGbElXVUVRVWk5WG9lQmI3RllVZVNBbytXenBiS0p3RXJCdWpz?=
 =?utf-8?B?eXJaZnFuRHpwa1VwMDh0N3NCWGlKR0V5bzkwNklWZXlDbXh0NjdvNk9TdzlE?=
 =?utf-8?B?V045VUlDMS9qaXFHUFRnV3NXUENNZnRDNFdBc1F2SDUxQUk1N1lnM1FYN0l3?=
 =?utf-8?B?dGl2Y1I3WEdKK3E5UVgrWnFwYUVSSVh3Z3oyOHRIV1ZtOVpZME9lQXpOemEx?=
 =?utf-8?B?cktzbFZGWWJESEJHdzZsZUdOK0R2d1FFdWZlcnc1YmtXeDBYU0FIZzFITzVz?=
 =?utf-8?B?RFZ2KzZMOUpkbXFvMnAvc2tyb09lek9nVUQ1RW5kTG9HTjVHVGdtbXRPL2pq?=
 =?utf-8?B?eUhJbHhzL2FiekRkaFhwbE13RC83bDlCRXFyWnZrYWtmRkNWMVhBTlJRaVo0?=
 =?utf-8?B?ZCtuYkd3YUhBQjRKUEt3SG85Nm9NbUpMY01ZQU81blVhR3FhTTZYTHBOQUpv?=
 =?utf-8?B?M0cwWGhsSXZCRTB4MVFoVFYzYUFhcFlNVkNoZWxNd0ZUZEpXU3Z2VXdEQ0t3?=
 =?utf-8?B?YmhjNSs2L1FwOGhyRDc1Yk9EWnRFSVBXNFpzQjBGaStnV0xkN1Ric0tONW44?=
 =?utf-8?B?bkh0aVUwZDhrTEZITjlXcW16NVpkVkxBMDVwTGhJdm1LcDR2dHBuNHRwblpu?=
 =?utf-8?B?YWFoeW5vdG1CbGI0WmNSVm1Hc2Vvd3lYNWpLMHNiSk1NZ3FzZkNxaU1jcGhu?=
 =?utf-8?B?OWlpbHRwNTl0eEV4UXpJcTBNZFFLNytjREpreDFBKzVPbHEzcGczNFdUYkgy?=
 =?utf-8?B?alJxT2d5VTNDMDl2UlAwQnBlWWNpZWNHTU9MbTYwUmlnRjhzaVBGbWxhODJr?=
 =?utf-8?B?UnpmNHJPZzcrL3lWMlQ5L0NOU1l0ckFuMkdFNFFsTE1uSG1CdnJVSVNlZ2pn?=
 =?utf-8?B?cDVOQlo0cWRKazNuZEtBOGg5UW4vTFhQTlBGVGVSODAxUEZhdXBKbXlCaW8w?=
 =?utf-8?B?YnRsSlY2MVVYT2owQm50dDNlZ21FNEM1dHRQS1lkQkQvcm93Z1BWNzYzZEpm?=
 =?utf-8?B?aSt4UVBjTkxXV3lsZ1Q4MzZ5YjYxS3pRWTQyVlVpakwwa3pDb3hVM1RDRWVl?=
 =?utf-8?B?MkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 183ae5bc-c5d0-4b9e-0c8b-08dba8962efb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 13:45:19.1628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OpIZPBV+4P93CvnKHt0RQEs5KD+u//PuNyK+xksmwknniN9ULcKKZLWMN53RUff+Y9gL4KZ/lX2DT/sgHJTLFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7310

On 29.08.23 13:04, Florian Bezdeka wrote:
> On Tue, 2023-08-29 at 11:40 +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Some stable kernels gained this helper meanwhile as well.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  kernel/cobalt/include/asm-generic/xenomai/wrappers.h | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
>> index ea7ed3ad56..a533d46690 100644
>> --- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
>> +++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
>> @@ -54,7 +54,13 @@
>>  #define close_fd(__ufd)	__close_fd(current->files, __ufd)
>>  #endif
>>  
>> -#if LINUX_VERSION_CODE < KERNEL_VERSION(5,15,0)
>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(5,15,0) && \
>> +    (LINUX_VERSION_CODE >= KERNEL_VERSION(5,11,0) || \
>> +     LINUX_VERSION_CODE < KERNEL_VERSION(5,10,188)) && \
>> +    (LINUX_VERSION_CODE >= KERNEL_VERSION(5,4,0) || \
>> +     LINUX_VERSION_CODE < KERNEL_VERSION(5,4,251)) && \
>> +    (LINUX_VERSION_CODE >= KERNEL_VERSION(4,19,0) || \
>> +     LINUX_VERSION_CODE < KERNEL_VERSION(4,19,291))
> 
> This is still broken. I have a 5.4.253 kernel here which already
> provides eth_hw_addr_set. 
> 
> LINUX_VERSION_CODE >= KERNEL_VERSION(5,4,0) is true for that kernel.
> 

Yes, the new lower limits were wrong. They should have been 5.5 and
4.20, respectively...

Jan

-- 
Siemens AG, Technology
Linux Expert Center

