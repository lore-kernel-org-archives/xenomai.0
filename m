Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2043.outbound.protection.outlook.com [40.107.247.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6735CB5
	for <xenomai@lists.linux.dev>; Fri,  6 Oct 2023 07:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="u0cxWykI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XwIPA2m3Yab86qmOBULyqKz/c7iXR1GtVpBYmSD3v1QsBqiS2PSTAN3XWwrjtA3CNN+YtBBRsKM4tZcM+D0WHKjqNT/yYO4RkKSIbpSZfZFomRW2QQ43yoeCakOxEWxIE7H4FN/MDi6t/uMpIzZlWOPHxBMpttyyhQ9D7+h5RS5K5FPzXOeE4rYd955gf6ufWOvYO3sZmK60JD0evwtS6YSPwKVOtChUW2O9ySaRYqPI497PWeRVPqot1O8YXcj1SoeTM95EQVMasZd+kqLzGxYJbHFtDuvGL/Kl42WNbI6lv7qRczSGK56Gh6as/yrb6QdrN5EY4BcVOx+zKnxW0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ie3dtW9/UZ7jSfZ6g3yzr4EBkSq+JaUM/o4VxmPQKVk=;
 b=kpRmR8XIJFkH5+Rn/84Rt8754l7aSKNTBc3Jb4OiyvLzHHEjmV/lMNI6apNkcwgXv5eTXKKhwERH5rY5MAkRrC99/igaigCX6yaMtQfBMFqNRGvjBmBIEsElXSQkYQOMVyKAlCV8OAjvoRsqhOJ9+lmXLwudETdtc/z8VIiYJESgFsww7emxp0y1uubZt5LIjEKgmVu1x7OOqlvimcVb4c3so9m9m8O5i43CpIqnQWKyg5jIuCuS3dY/3s6jOfMpwdpO6t8UQqCb/eLxIcH1GW4LVoKYWjKqHlqXZr7pkmPi6VIcSYnHqOI606LYuMH3mY7iQenyexYlThVmeCXTVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ie3dtW9/UZ7jSfZ6g3yzr4EBkSq+JaUM/o4VxmPQKVk=;
 b=u0cxWykI8VJisQsn8xSQzOWfQJcuIVxzrXtQHhfsHbJYJ1aJHnv/PG4vk7iSS7nmQ6sfV8mnCYoBqU7eugaQw8HIMVGBeqcfJt9pfcyyrTYiOaWXvTaai0gZ9XTTPTyXrXAC7tFB/q9zw6XzZnyjLrXJNALRyTXKvK57kE6pBhz++028Q4BRwswNYTkeCh5V/VsNC3mNkjS7UzUYJp0tH5V6BvDS3sJBTyjh4ev+Q0rPomdoP4R+RsrrYDaxRYuYUs4KHpIAzqhnLGmPRwN+Bq/4z2F6oR/Tg2+aeopxl6l7TOhAGZkdGji+O8FwPRyvrv/LvTTEususQpa+nCUFkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by VI1PR10MB8230.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Fri, 6 Oct
 2023 07:52:40 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3966:eb27:c3d8:bd10]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3966:eb27:c3d8:bd10%6]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 07:52:40 +0000
Message-ID: <6dfcb5c9-8f86-4c12-9207-21b99bc22b38@siemens.com>
Date: Fri, 6 Oct 2023 09:52:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Shell command segfault occurrence phenomenon when xenomai task
 switching running
Content-Language: en-US
To: =?UTF-8?B?67CV6rK97ZuIKEt5dW5naG9vbiBQYXJrKSDtjIDsnqUg65GQ7IKw66Gc67O0?=
 =?UTF-8?B?7Yux7Iqk?= <kyunghoon2.park@doosan.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <1695706251-3997-mlmmj-62db5be2@lists.linux.dev>
 <PS2P216MB13306DDFC18190667DEE0409D1C3A@PS2P216MB1330.KORP216.PROD.OUTLOOK.COM>
 <49968ea8-1651-4bf0-bdd5-b3e3dbe252b0@siemens.com>
 <PS2P216MB13303939F1828F55FF296B3AD1C3A@PS2P216MB1330.KORP216.PROD.OUTLOOK.COM>
 <78d7a44a-c84c-4a36-bbb6-fc6d7a3bb3b5@siemens.com>
 <PS2P216MB1330EB1FD1896D2A239CBF25D1C9A@PS2P216MB1330.KORP216.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <PS2P216MB1330EB1FD1896D2A239CBF25D1C9A@PS2P216MB1330.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::26) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|VI1PR10MB8230:EE_
X-MS-Office365-Filtering-Correlation-Id: 253d871a-f63b-455a-c829-08dbc64136dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+HVNcGI+LmhKerVJn1rdataTEscK2N9fFyq4zPhAM7ct2Icz3Q/rXjuI056fdHeLqMk3yEgCBB1U0AF3gjY58zk3pwMiYcOIZHk/Ge2OjjNjctqE9/eJjJeF7dEfQiHVdjZP3u1qhBanH0JQBazPV++jmixks6/KVyIFjmbl3IzzPvovvs4geMVWxRVE2E1nempkMwxcN3sSvtksWZbb+hVVp+lBrq3mkGygplqFdITiOB2bGl1nVHmTwxNs3rdWkgYP6G3g/oYkxVUacwrv4GDAXJ2IShhzuRqh44Y4mi/ngHDcg8gXBKT/aorjGTM5yAKzQEednZ8ST0voG+TAm8oYA0Rbvf+Ixpyovy/tkin36hAEHvtgZS/p7lT0dZrq/BK0CN+QvdbhAxtY8DPyVqZD5MsTU3jbaa8A4uYq908K23PyXWzD+hMTpEtPU6Ez+OkKN1nvw4eHFn+WZuyJZx2g2DSesGobUsc+oj+9secdzK2qzoxtNXFduSofaq9V+O7r7m9L38OgpT4Hpij7UsnkPHVRZZMxVcjRs6QtC3zNlf018W44aj3koCVqK2NkFTlkDIbzgBw5zmz4Mgf2xigMxLIb3+qyLN5i6+3WCC1K29munRF3z4T+OA2ZF6d6hsXOm/VKzWEPO/5URLOcGQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(39860400002)(366004)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(41300700001)(2616005)(26005)(2906002)(4744005)(5660300002)(36756003)(44832011)(83380400001)(8676002)(8936002)(4326008)(38100700002)(53546011)(478600001)(31696002)(82960400001)(6486002)(6666004)(86362001)(6506007)(6512007)(31686004)(66946007)(66556008)(66476007)(6916009)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHJkUFNYVFV5b3ZrRXFwdFNBNFBDOHpaUFMyM3R2ZnF1ZlBPSW04N201NFBD?=
 =?utf-8?B?MUtGK2pNQ0VubjFrdzc1MzRpdjhOWkcxQVQ5R3RPVFM4Qzc4d0hJUHYwejFa?=
 =?utf-8?B?UHA1ZlhlSVY3N3hpbFd4RXhWcU9MME0xeVVGa3hCaG5JSGlJTmxpTi84VnJt?=
 =?utf-8?B?dmVRQ1Q0cnE2WUhidkk5ZUFwYTNPelNWTHZBMCtReCszeTNaOTlTSzU4dnZ3?=
 =?utf-8?B?RTNNMjVCT0o4UDQ3bHhKZldwRk9GeFA3TzNYek5PaGFNb2pPWGV0SFM1OC83?=
 =?utf-8?B?TUFWdGxYMXhteE1rZHNkRUROMW5EeVhBdHZGanRFUTY0V0xmbE1KZVk0N2Fo?=
 =?utf-8?B?UU1PTE04S2VTdjd5eTBIOEd5UWFMS2lQajJueUNCV2hDSGFDRFlEVS9TSnQ0?=
 =?utf-8?B?TmZWUXM4R2VQYTBOWGJ1Sm10VVhGL0EvbWw2ajNOUHZ5dWtrQ2dTNUhKNERs?=
 =?utf-8?B?VHdvZkRQQXpYQTIzNm1FWGZyTEQ2UytWVmxOVWF2TlEyRTI5NG11SmM5MzdC?=
 =?utf-8?B?cTRTZWZlM3E5TjQ3a2tiRVBXSDlBdzh1eEZtckgvWHdoQXRlQWU1SU1EYlQ2?=
 =?utf-8?B?dkwrcnQxd2JSSjB3TXN6Z25obGRwaTFhMG5OUXdFNkNoZDlXTVV5WWFBUXpB?=
 =?utf-8?B?NzBmZEJyOGhzVThra1pzbi9oMFNNZExxYkRKRWQyZjNNYXUwVUNjNlByQXdx?=
 =?utf-8?B?alE2QWI4aDNMU2VvYkdJM1RYcDUxL2VidkJRUHcyRmp3TzVkdjY1UWFqd01L?=
 =?utf-8?B?VStTT0Z2MWhYNWZIOGt2Y3dvRXFvSGt1cG5lMGI1SENNL1ZZcjJNYVc3eWlh?=
 =?utf-8?B?eHN6OG9XaEtwRUwvRDFtNDR3dFdFNDFyc0R2SEJVcHRrOU81NTdzRU9BOUhp?=
 =?utf-8?B?Mnh6WXhzeU1Xek5wOTg3ekRDU0hXZXVrSU5TcnIwdENKY1hIOTF5ZkcvT3po?=
 =?utf-8?B?eG1EY0R2QkgydVozUDdseXhZc3JtTmpia0c3K2FnS3dSRUNaVXg3OTNPMEEv?=
 =?utf-8?B?ZldUWmtTVFg0cE43STZQMy9kaWxleERpR2Q5R2RyOFRqVllOTXJKbWM4eFU3?=
 =?utf-8?B?SkxxT3g4clJkNjlZaHA1dGZxL2IrZmxZanFZaDdGWDk0SXlOUjZ2WjhXWENn?=
 =?utf-8?B?Y2llWFZGREFEN3FQbDVOWVFEV2lVTmZVNnczVE9TU0cvUFlQck53S0tObzdv?=
 =?utf-8?B?cE1nVjcwUDM1N1NreEVuTmRNTTAzU3VyYWpYek1WM1RBOTAzT3lNemN5bDl1?=
 =?utf-8?B?QUQrSFFoOG83MmU5QVJram9hNldBeTh3di9Xb1M1MndmOHBRWXJFdy9sbXUz?=
 =?utf-8?B?eExLcnBNSmlZemo2TFNycURFZ3VXTXNPcXM4cWg3Y3RZUWRpSWgyMk9lNnV4?=
 =?utf-8?B?UTEvTmlabkwzT2pYckNDYi9GWFRXSTBIWjczaG5CU09yZy9QenJpa1M2cjNt?=
 =?utf-8?B?cS9EK3JCSm1BMVZJeitFNlZ0KzFLMmtTV3NDcUpDU0xKRVZuZEZHVUU5b09s?=
 =?utf-8?B?WmlYOWtCWnNHZUt1ZURmSjJIR2VyRllscDRNYzhBR2NuTTJuYXR5Tmxvampa?=
 =?utf-8?B?c0dJYmVTeVlHaDRLd2dYWDNwb2RuQTZIR2JrV1hCajRwMjZ3Ti9NeFZ2SXg4?=
 =?utf-8?B?U1RZVVZMSzJHbEdDYStFZlpZUnBjWlAwTHlIR0J5TzFVK2Y0NG1xU3Z5NFZr?=
 =?utf-8?B?eEpmeEZLVnh5Nlh2NkxmeTdEcnRRMTRjRU05UDdUTUdRekF5MERSeVdHRm1p?=
 =?utf-8?B?NlRvdEFSLzZyUG1tR1VMVStxY29MZG5SUEJ3M2crYnJXUU1BVzJVYnloOXM0?=
 =?utf-8?B?SVZ3QldCaStFeFo4Z1VVWFMyRnlGNGVDTDZpUUp2UEllQktqQ2JLUXVvdTBp?=
 =?utf-8?B?NzZueDlXOW9qU29wbTVuMDh5U0prTXd0amJ1VzVlbXhYWXlvazE3TWlRejZ2?=
 =?utf-8?B?aXRudXRia29CMEJTQzVkVHF0RGRybHBnN0V4TjNpb3pFWWVJTnNzN29EZEVm?=
 =?utf-8?B?V2szb3NXc0pGSDJVeEZWZ1pYTWNLQWVva3Z5QWh0VldSVTBmUFJaa25aV0Vs?=
 =?utf-8?B?VkpvempjVWJPVUZqK1NpQUVzWnQ3TXVYd0ZXSFI2UW1zZU1yd2k1czNia1do?=
 =?utf-8?B?TWJTUzhadFQrT3QwdFcrSWlGNzJ4YjcwMmduTmVrNVZQeTRFZVg3b21jN25h?=
 =?utf-8?B?Q1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 253d871a-f63b-455a-c829-08dbc64136dc
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 07:52:40.0183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WvJYHaAKbZ8LokuwGvYeKZkodlN5FySyoJ/KV3KbfY+itFL+4s7yE2jgyvKrABrPC3Uv2KJ5/ue71qFuNA76GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8230

On 06.10.23 08:54, 박경훈(Kyunghoon Park) 팀장 두산로보틱스 wrote:
> Hello
> 
> I solved segfault issue with your help
> 
> As you said, I ported xenomai-stable 3.1.x to ipipe-core-5.4.255-x86-15
> and no segfault occurred when executing the shell command
> 
> But I met a new problem that xenomai task was killed by xenomai watchdog.
> This issued occurred about 20 hours running after.
> 
> I changed watchdog times(4sec -> 9sec)in the kernel configuration(xenomai debug menu) and re-tested it.
> But the same phenomenon occurred.
> 
> Have there been any reports of a similar phenomenon?

Sure, this is a frequent problem of applications that do not leave Linux
some time to "breath". Make sure you have no infinitely running RT
threads in yours. They should throttle their work every few hundred of
milliseconds at least. Maybe there is even a more fundamental issue in
your code that causes run-aways threads.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

