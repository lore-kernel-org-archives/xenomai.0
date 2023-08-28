Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2080.outbound.protection.outlook.com [40.107.7.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58726116
	for <xenomai@lists.linux.dev>; Mon, 28 Aug 2023 16:29:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJ8Laq4eVG5bAF3TcfN5si3cyRy10TDUHtPaHcx1Kv4RremGwo76dEvJ4C3MQHLUtkoRYhkERzNy7Tpq1PhATn1/E7ZP2rQKDWd/LfhAsPe+WbHnZdb4IXObetHN/mYTwun/fAUSyeVivvzYv0fDEkaqkGkaJ6jmfHdUVgKM5H/nyawM1adqpPhRUkVo8NgbEuvFRrHBMy6+jZDQeGioigwCkSWTjSP3iO8jmMUlqWryYeWRA4+O8Zs41LzooKRBCaZYM/CHvRVnBe2EDT88HUPsj3ZE9/bZVsQ7n4nA3Z7s7g7lMU9ZwxW5PNFXRx7rxf8EQYxCzsdbzP3TAghMww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=heTezHggH4ckXAtTnT9qojGnXOfwWumL/OIIsF5E23E=;
 b=jGJfXTRBQVJTWNIimcQp845+aastpA0uHe7fMaokA8lbXusrUmUT9+as0CftIOBzi01pNZ5v+PQvIQX82CH53LLH41cSd8cvq5Khq9sB2HMct1aJ3tMu3ZwhlpKCDMyhA+gU1v26LcfQTm+racX02d3gDzbvT0SVhgwme+xMsh0rUs5xBwGoBhFQ3hhXlT09HgUifocwft3OYoyOl2hERClZn4KwtjjKOm1BxO8G0DmVqK3S9KFDuh6zkqC42+hoZRUeUtP2cLEMb6KxwzvVqha+v5nj1eCWRDPJ2YKn7tKAGNesRUTrZlyezxDbSOU9F8jp+1G0t9VASmGvTPf16A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=heTezHggH4ckXAtTnT9qojGnXOfwWumL/OIIsF5E23E=;
 b=xcxlA9OtFxYjnynKF/slmTggZzIfkhEEmbhb1Qk+czkBVaP+Uq54nOPTtf8hrfBtNrFwL4WBAwkzcIKOszzB/BDomXdC4Ck65TnBBcW2O8AYr/NBj7ggpN0x+5U+9aEkDJSpKgIqktfb9pTI3gQYIp3TGWygNpLMuNmUnQaIzc0UVMKllQoG0obudRCQn9vZ1OaUWroLP5wu/Lzqb4cN1It7QGgKEde/3zy8o+37vW/MGVJkdvbUf0/jgmSAILigEpWHfxWd9GpUBLL3zDfpFHMlLMTP5W3/BmO8lb0OuUM95L708PIoB5dZN0zoYRRsVyA4Doy2j44rqyc1FjRnoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6965.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 16:29:03 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 16:29:02 +0000
Message-ID: <906ca7ee-c870-4466-b495-3f5ba2c81d0b@siemens.com>
Date: Mon, 28 Aug 2023 18:28:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Sporadic segfault upon start of Linux app while Xenomai app is
 running
Content-Language: en-US
To: "Heber, Stefan" <Stefan.Heber@zwickroell.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <FR2P281MB2654953C4123B74DB77CDC51FCE0A@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <FR2P281MB2654953C4123B74DB77CDC51FCE0A@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::21) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6965:EE_
X-MS-Office365-Filtering-Correlation-Id: a07a1c50-de89-4bbc-0930-08dba7e3e3a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QzVKPxhukilUWl72+fI+EDitp2sXfZ3NsXRvLKLGbqnxTBDKtPLvbgltZyody2fsYqvrVLXcSoKKc4Wp3v+DX4+ssrfEs+GjUlgriEvT6EGUkcw3QioOvJmHi5tLfSZkE7wy9j8i2XGAiUYfr+rtOLwFcWSQaZXE2gZq761U8/Sn1MM8eCikph1ynZMWg70BsBmwr9g38cUCgq3A+bgHvDGzGS890xmzJehs6F0fFNSz2gOAKl2bMAr7179asNgu0L+VIYS8WcaPGpLPPecCAVaSY7d7TdY104f3jYYHJLrHHKgYLsaRqGB+g96xeyDxAIraG4RRLmlERcFr/1J+k4S2s1MbDMn9yqVfc4QN4/dM/iie1cEpl9VzdhenyMQMOIGVw36uuVNtrzuEJ5nosQvRrMYh0zTU3zCX9G3VTTaCrByHR1H5UnaLTCVEEdxuZ/7avEv2O1ZoKZI9R1Ep7T6ydK+RpSFxD8Lee9arQUfspSGkDsq7HE2SQjxaDNRmvcKDqxxa54aJEK9EapTtcul7JtVxvbEyPp66nlHNCn0GpSZD/XGW4ArfR1fiKA2zozrHtmVyXL029sdYa8HB1W5TYFlmBtayfEOUkOZOWS0iII7mxbnlFCeW5mrFMhThxnTY0ZsISsADflrDltQQCw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(346002)(136003)(451199024)(1800799009)(186009)(8676002)(8936002)(2906002)(36756003)(110136005)(66556008)(66946007)(66476007)(316002)(5660300002)(44832011)(31686004)(41300700001)(6486002)(6506007)(2616005)(53546011)(26005)(6512007)(38100700002)(478600001)(82960400001)(83380400001)(31696002)(86362001)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3ZVdGhqTVZiVnFtQ2hiSGFyZktYaThDN1pUeW82VlA2YVBMMmxHQjVjSzJt?=
 =?utf-8?B?OTVBdGEzVTNOS01md3FNWDBjV0M0WGNFQkk0c2FUVzBFWTltSnM2ZUNiUEdt?=
 =?utf-8?B?SURLN1d5ajl6MTYvZmkvV0xNcVJHT014MjZ0cXdGTkRybEd4WkdXYlNFWUhQ?=
 =?utf-8?B?WjN4TGNoblNFNjJPd0FvSmpmTkd2ZkNSWU9LNWhlWnB5YVVKWU1uNWxrdUhx?=
 =?utf-8?B?ait1eWVxVXhNWlZrdUx1djlyazlMTUxBVE5NMmdxU0N2blRGWFpVMEtjOW8w?=
 =?utf-8?B?c3R0K0g5SnZvSjBjVmRrUGNVaGZYbkdzQ2RaUVVZYjVzT25yaFA3SUhzeDVr?=
 =?utf-8?B?M1FjTmptRlN6djVpN2FlaGRDbjIxNk82NkdvY2xZMVpmU2o0R2pBZitkbElB?=
 =?utf-8?B?aUd3QmN0bkp6c2IyWUR3NmdZd3IycTA0Q2tIWXJwdGQ2bUN2YnNydWlSZmIx?=
 =?utf-8?B?REZGdWFYL0ppb3BNc1VRbS9vdU4yT2FJeWdrR3VKd3EwdGF6WjkzaEcrNXgr?=
 =?utf-8?B?VTdDRExJYnozWk1KcjBBcHE1eXNFV014QWpnazFVMkhadkRHN1l0VC9iYVdl?=
 =?utf-8?B?WVpCZTd5OElNaFNRRmExVWQ0TG13d29EWTZBek5ibzdwTTBEYlRPcFEwRHVw?=
 =?utf-8?B?SC9uVnJ2VytsZUptaEM5aG56UVFNc2FqMGJmYXk3ZGlyTitYYnZ6aktyZUxT?=
 =?utf-8?B?NjdZWmdtdmVLQlNCcE5RMEZHMjFoK3BBZzU2NjQwUTNPQmxlbnRHd2dFZW9h?=
 =?utf-8?B?L3o1OFpKZ1RWZEx1U3N4VmhCNitMZyticzArUkVGQjFGUW9XcjRvcnQ2bklw?=
 =?utf-8?B?RWpFRDdrbjlDcnUyQzdXOWNRWitlQU42dXN2VHAzN256eUhHS3UxY0Y4QVMv?=
 =?utf-8?B?M0pGQnh3VGNWWkN6WHptQytKNmpFdzFoemVWTFlhRDVWZU5rRmVkVGhKaDBx?=
 =?utf-8?B?Z1I5aURJcWtGWXFtb3pCZkFoSjBJUGluekxmTm9YUk83dlB3cmFEbDU1Umpn?=
 =?utf-8?B?UEZZRUFDUzhKTE9MRm9ROVhGT0pKMUNUK1VZa2RVblBmcVU3L04zMll1Y0wy?=
 =?utf-8?B?cnJJY2FibXNPc1FzQnpmN083dVRVWndaMUpldVRucGpyajd5dmFrdU1LV3JP?=
 =?utf-8?B?VnBTeUtDSlhlODBRMjJLVjFmMnA1UUtwVnFZUS9rall4dWF0NXlFSm5YalFN?=
 =?utf-8?B?NmxYaUc2bXNSdm1hbWhqbGlvVGFYcmVEYU8vSTU5K05vMFVuQUZUamNMQWwr?=
 =?utf-8?B?UHhFYUk4R0UrMzIvVnhMbXFSUFcybjhrVTJma3ZsRWQ2V041eWJZUGYzNXlS?=
 =?utf-8?B?WEZpamh5OE1LTjdKS2JzaWJZMm5sQVdVbENqckFhS3VQcUNUQ0VISDF6R3A0?=
 =?utf-8?B?V0JhTitPOHJ3QnpoYU43Vk1oM2tWalF1bnRKTXR6WklPT044SlhCRTU3ZGdB?=
 =?utf-8?B?dUdDY3NXUzBUMUsrQVplWm5jUTkyOHBQa0kzWHVrZGtjZzR0cEE5NEtVaDlt?=
 =?utf-8?B?UldRZitHdGxnU2cxbW55OVBRUWhaL3EwTDhIaXZrRFBac3RVak8vYld0a0h6?=
 =?utf-8?B?TXFJbGJZMG5RK3NPSWFMSWRwWktGTWxZeHlsSHVkSjcvTHFuYlhRQzZYSzgy?=
 =?utf-8?B?MUhiK042TEdIV0xodWlXa21SN3VjZmExMXcrUStPS3M0TmgvK25EZnV3VmxC?=
 =?utf-8?B?YkJjV0N5WFIyazVwYzJ6aGRWRmVvckpLRnEvRDFqT0RGOWVXWjd1WUgxb3dY?=
 =?utf-8?B?WDlYQUdNbFc2VG9SNnhOSStheWpqdUJQd1R3VHRmWHI2My9haXJFQnNZUzdN?=
 =?utf-8?B?RHYyWkszOXk3Q0krdm1MUEp2c3dVNHpEajQ0dTErRW5IeHVnakRIYTdvaHhH?=
 =?utf-8?B?WlpPdjc1SHZXTHZQWTFQeGtBMXBOY3pnaFpITXQwems2MjVVMDN0dnV0VXVz?=
 =?utf-8?B?d2gzTWU5NnVRU0ZTdGFuNzZ6RzhMdFM4c20xWDhWMkZXS09yZGVXQnFsRnhT?=
 =?utf-8?B?T09tczRmVlRGdHdONmFkS3RoazV5QytlWWhqTFZNUEFIeTdNb2xBTU9QNjBm?=
 =?utf-8?B?OGg4NG5yaUJLczBqa2RyZVQzMmdlUkVKaVhpYk9Iam90M2srcHRpclcrbE8y?=
 =?utf-8?B?VlhraEJrR24wMTBlOVIvOEZ4Ti9KcmlCZ2NEdW5TTi9oK2RPQmtMUEhpZERw?=
 =?utf-8?B?NFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a07a1c50-de89-4bbc-0930-08dba7e3e3a8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 16:29:02.8635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t8hg1U2/v9r57hLPGnAlr+HySR1mq+L1IF5MO0S1d4orDobbtDCDyDo1SZKpP1916+KskbPy7BR0xEQS6jyQhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6965

On 28.08.23 15:40, Heber, Stefan wrote:
> Dear list,
> 
> we again have some trouble with xenomai (x64 / 3.2.3 / ipipe / 
> linux 5.4.105): If we start a simple non-xenomai program while a xenomai 
> program running a thread in SCHED_FIFO (in our case prio 99) and getting 
> scheduled frequently, we sometimes (in our case with a probability of 
> 0.2%) experience a segfault upon start of the simple program.
> 
> We reduced this case to a very simple xenomai app that endlessly runs a 
> loop with only nanosleep and a simple "hello world" non-xenomai app. The 
> sources of both you can find attached to this email, together with a 
> Makefile and a bash script that starts helloworld 1000000 times and 
> counts errors. Additionally you can find the config of our xenomai build 
> there.
> 
> We also experimented with xenomai versions a bit:
> - xenomai 3.2.3 ipipe with linux 5.4.105 shows the problem
> - xenomai 3.2.2 ipipe with linux 5.4.105 shows the problem
>   => it isn't a side effect of the patch you developed for us a while ago 
>   and that is included in 3.2.3
> - xenomai 3.2.3 dovetail with linux 5.10.127 is clean.
> 
> Could you please have a look into that?
> 

Is this reproducible with a standard x86 image, maybe even qemu, which
we generate from xenomai-images? Or does it need specific kernel config
settings?

Did you already try to find out more about the crash of that standard
application? Does it always fail over the same instruction or same type
of operation?

Jan

-- 
Siemens AG, Technology
Linux Expert Center

