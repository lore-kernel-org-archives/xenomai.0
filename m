Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2058.outbound.protection.outlook.com [40.107.241.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0548F44
	for <xenomai@lists.linux.dev>; Mon,  8 Jan 2024 05:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="aIs57Fhx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhEwnjeytW/wk5p2btyomdc1yNwu7bjY84plhnCx70vXVQ6ShYY21h5TqfJEs37iHeX3CSYBuVaL0zU/Gv4oEdN5rBKzG1dUF0lJRGOOS8WskaLBNRtjedv6xcQNjsAwsJrwrNEA7vayGq+DhT00l/03CKX7XUqY8p5nFoWQjkCwhbLhC9MrDfI7HplMS1gEH4wKIRvCQUtvdMHO9mD27dMFaNvEX7VgO+CRM4NVjOHBwSKg46jqepqbHUtW3hi5R/SBPMWqoIzChhSevHogswH8+iUhpaf+wILrTIf+AzdWONzjCX9e3CqV+z8N1b3mB9NJvWElCbzvCw0/KpQt8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iP6tA2uBLypKUAjNpDHKiNJ9cYe6QHjD/v7Hh6XjnsQ=;
 b=Ircw3SMvDt+tLZyIY/T8nA4ngAaXvlZcI32vnRtr0FJPHJBDUiHp1+vODzjQDVwvzE4yQo3D3Kfkc1wKtvrbFZzMsXmGmKAVDdaU2U56AioK0VNDTl3QDCeA+GSTT6tCbuR3PoHgDuso1X/CeW4nEEiG7t9MdcwcYH1WRh82tcqU6U5+filVVx+MyPqi3Qm6/yWiuGu9v37YvFxLsHeFKrTaKdNIPBKWGoYZOVkOwlWutxDjhsFReNthFhNqsQhqfPlNE9VtgVtEvj07Jho8rqcE7qjT2cPVf4weD9OCbEZtBlQtDLjW8Bz0qIWy8TwGjuOLpK5Jzg8593A5JkRNaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iP6tA2uBLypKUAjNpDHKiNJ9cYe6QHjD/v7Hh6XjnsQ=;
 b=aIs57Fhxl6xFr0mHKKoIE1q21AHtbNoPMGZ/ztv6hmqlmuMwzXvkCcLTELJ2L4gdK7b49ECZZ5rqeZvMxG5jYieQpbKdejc+R2nhYacdweYbkjdp/nL6u1fzn+Sv8O6OMHVv1/ZEnpyv4xRDVzlrkAeS2HKlWlB/QF6aRZl9fmyl5ptp6N2TTZht0Eq17aobbOGTjZs136Nw5x+mnbxf6rHzHJySclJpw6EpMYETyQEsWn+lcOZcdLCQGoORDuLsfHLYV7Q5tDrpc4DAFb1sbGONGY7nUtwpOyHEtMpH/m3cEV8XT6c5otPtVFbD8kG2P3dprVSOWiJBYm7lUxhnHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5176.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 05:41:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 05:41:51 +0000
Message-ID: <5def1e14-e11f-4966-9f26-18ce62378592@siemens.com>
Date: Mon, 8 Jan 2024 06:41:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: The linux-evl and libevl stable version
Content-Language: en-US
To: Yao Yongxian <yxianyao@126.com>
Cc: xenomai@lists.linux.dev, Philippe Gerum <rpm@xenomai.org>
References: <5990240f.1ddd.18c8f7bf237.Coremail.yxianyao@126.com>
 <c8491c64-f8d7-4136-8552-8ac1fb111170@siemens.com>
 <6e6d5f0a.3f41.18ce78d31f5.Coremail.yxianyao@126.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <6e6d5f0a.3f41.18ce78d31f5.Coremail.yxianyao@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0035.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5176:EE_
X-MS-Office365-Filtering-Correlation-Id: bf8fdb02-a657-4cea-7547-08dc100c83b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	N+uxmMPYmdXXSYU2Blv0/ZHtkC1/7SU/joHqfzMkblrULYYvaJnyWNjqm6Zb8WGqTDet8As/oQML2yabYpoQy8NFjcE8Agea4VOBD7Fv+fttDo+OMBj8Pg0tAqsj4685wZkbnY3B3KjAKyLgciKe95j7XiFhuweQ7gwmPIfbWF1Y5vd+PQznWS8MU24fuXgPj+mKMI05uMDBipRjhUXBHUj+sNYFvoVEv2iJBrvD7g7CZc/Tmc83R0Fodxg8mm1GTNFjV1oapKQtC9Q+KjzbyJAwzRFl8nf0yPz85K7DgV19eLIdqvVB0eX1Gulc2XUFQPJpSAVtkvleg25Pja/MJC0Nrn2NVTBB7lTR8wHk8cLwVfowvtbA0uUiHM/Bj8ygXrdVQqD9gOlMXhViphHQtxVjdbd+ptlDJL20z5cf+lEJogfmKbbmwiTqr89SNy+vg3PmmmD5QOHtFBx2clXNJ5U27gM0b5gaRvMrJxyc1pUu+XSZE8ZbN4++m8f0vMOtif6eykQMPqgC3lKU6nO+BNQI1+aGs0e8/tLn7XmAFbKiA0TolhtKusXYC0U54Zkyl2YMBInlGONGt8IfcizrgeR9XJri2YjdbCfgj2J6rXEvEyuUsT86VN3EZJxMDz7liegPYQCIkbSFMOF1DHHRSg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(26005)(53546011)(2616005)(478600001)(966005)(6486002)(6506007)(6512007)(6666004)(5660300002)(2906002)(41300700001)(6916009)(66476007)(66556008)(316002)(8676002)(8936002)(44832011)(4326008)(66946007)(38100700002)(36756003)(86362001)(31696002)(82960400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlRxVHdUSUZwZkhleFIzdmoySUZxajJZUmxUbEZ5cDNYTlk2NGNQY1ZDN0Y4?=
 =?utf-8?B?QUFtbEZwNXNlOFpsLy9oNGMybGNkclowYWV1WGVwV0ZBRG1NM1JzRjBxdmlJ?=
 =?utf-8?B?K1R6WExZcHZISmlheUZpQVdpbEtTdCt2UHEvd1VQa21VK215MUM3VWw0VXlq?=
 =?utf-8?B?dDdXZ2JDWWFZclZBUFc5L01LTllIWkd5czdId2tEY0p3WGJnYVN2UmR0TEli?=
 =?utf-8?B?K29vREU3WUxJSDcxNUhzcW42QXFVb1dWZlBqNlV5VHJrUUUwSFpXVUxHa0Fa?=
 =?utf-8?B?UHBEQWExMDdvOGJacG1ESW5UN3dQR21tL0ZZSmtRa3luUGtIQ3Y4ekR2dzE1?=
 =?utf-8?B?aFRpYkhHblUvU2c0WGkra1I2TlprZURtUXhVY3BXTlo2WitwM25HQUl4SHBy?=
 =?utf-8?B?N000aHU5QjVCNFRON3F1UHVvS0IxakxzVEt1UDRlRktGNU40KzdVS1ZyVjgr?=
 =?utf-8?B?ZjQwOEFCY1VLbWtGbVdsTlZHZDJaakVGZktYOVBnK3R3ZDhsSlhyRUFhdTR4?=
 =?utf-8?B?MHJtNjQrZ1laOW5mVXkrM1F5TWM3bExVQ3lya3JlL0NIbXRUclp2NS9xR08x?=
 =?utf-8?B?cmxjR01JWmg0T3c1aEtHaUtTQlk3bjdoL254TnNWVzVGY1dPdVZQci83RnVC?=
 =?utf-8?B?V3h0azNyMy9rL1NUWXBINW85QXFHVmxiUyt4Z0JvRElENXF1WXBUZk5ZdGNW?=
 =?utf-8?B?OWJCdkNna0dISy8vN0R0SzRKbTZTbTJCdm5QU1ZPWUQzRklreGRzemFmMVhY?=
 =?utf-8?B?dmlKRDZrTTlOZ0tsNXFMMnE3VStIN3VzMzVubklrcXdDUFNRaHhoOC96ZkVR?=
 =?utf-8?B?NFZiL2Qrc0E3VVZaU1RYczZFbU80clJHZXF4SjVKV3NFUkIvaFF0NmxUeEtq?=
 =?utf-8?B?ODZYd29sbHA4UVJWREt0NTVMZFY3Q25wcVVGK3NCL0Ntb3VzeDZJenZ4T2s3?=
 =?utf-8?B?Z0NkcU45SkNLMklpY3V3MEtnL2wzQjlFYVZicjRYaEpidU1DQklmQXFRRVFF?=
 =?utf-8?B?NllsY3dBaVh5a0F3Y0l5T09HRmd1VXZrMklhMVdiWjVtTkpwYzZPSkNVWTVU?=
 =?utf-8?B?VFhiSnU0WWtoMGNFU0FQVlBPbjh0dG5RNTF0UzFGWFNFaThSb09JVXdHS3lz?=
 =?utf-8?B?bGkrc053b2xzdW9CbUZSZ0U3V3g4UDRFR3pHejlDT0o5dk9mOVY4eUpyYTkz?=
 =?utf-8?B?dzI2STNhYkhUOUpMT1B3eTVUR0gwdy9PcllCZ2RHSVMveXdWMms2MkNXL2ps?=
 =?utf-8?B?Z1RzWHFNZFN1RzJMVVZGWnhtdlhPUjVjRGY0WlZOSnU0aUlDU1RKSWxxVHZz?=
 =?utf-8?B?Z3U2SDdRVkxhNnA4aStUMWdBTGxvOVhiKzJoS2JRN0V5WWVwWUpBN2JHNnBO?=
 =?utf-8?B?ODB0NmJraEQ5RlpjM1NqSUJscTZhdWVqM0Z3N1JvN08ycjFPUk80RnhrOFFK?=
 =?utf-8?B?MXc1MmdLL1ZaNzMwYlJmWGVXdStJTkp3LzEveVIxVWY0d09ZMlVNeW9nUE14?=
 =?utf-8?B?UndzQWZOa1BXRTV4K05GQThuSk9FOG1qL2V2VnMyVXN1SzZNaFJjVmdQazRM?=
 =?utf-8?B?SFJNVTN2aWxmOThDT3VUZmNTY01KcnV3TkQ5Vy9RazNOOERPT3l5eitTVWw2?=
 =?utf-8?B?NmNIaVgxRy9WZEZrcnRTTmsxSUlNeTJZcmRJUzkzdFVzdkd0Q0MvblZkU1E4?=
 =?utf-8?B?WVlqQ2Nna2tVNzBQTG5zaDArQ3hEZXRkVFdHSlEwelFFRS9ZNUovbStYVHpU?=
 =?utf-8?B?c2s3WWtGZmpTNU5laVBuVHdhY2d0TU1oZVB1NFZZS1M2RUVRdnNiUFJ6Nk5Z?=
 =?utf-8?B?czN6ekpOdW5NNWZUMExOWWEvOTVjd0liOHowaHErWnlLd2FTa2ZtQnVGelQy?=
 =?utf-8?B?WDZQQjM5UHlkdlI3c0ZtdEpodXNEQ1B6U2FYNEdzemlsNXkxRlUxajQ1OGsz?=
 =?utf-8?B?TFhDY05LK2ZGUk1Jc0YvckFzdi9oQjNnQnFNWFZ2T1NMZlk3aVFuSXgwY0lL?=
 =?utf-8?B?M3hRUmVqVHZGZERwbUJTNkZmbTBRQVArNVBKbElrNWhvZWFwOW02WkU1dlFX?=
 =?utf-8?B?di96L2Rzdm50dm9kZ2I2QTdlbmR4Vm9RNVFZcThYQ3hmNnRHUGQ1WUJTT2Vp?=
 =?utf-8?B?U205N1JnVkIwU0J2ZlZzMXVYRDJPdGVVampSK0dBZkYvQWlPazNUdjFCMnNZ?=
 =?utf-8?B?Rmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf8fdb02-a657-4cea-7547-08dc100c83b7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 05:41:51.6266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tXMgTDv2+71EuOU9k7vXJt781lCnG/gz3+GwtThufAn7up9wLTmtfn5coMuI9MKCDpUveLT4cpks9vaJK1lJ+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5176

On 08.01.24 06:30, Yao Yongxian wrote:
> 
> Hi Jan,
> 
> 
> Thank you for your reply.
> 
> We plan to use Debian11.x(the Debian kernel is based linux-5.10.x LTS) on our product.
> 
> Is there compatibility issues between debian11's glibc library and linux-evl-6.6. x LTS?
> 

I don't expect any, just we won't test on that anymore.

Why are you starting a new development with a 3-years-old baseline?

Jan

> ----
> Yao Yongxian
> 
> 
> At 2024-01-03 01:21:48, "Jan Kiszka" <jan.kiszka@siemens.com> wrote:
>> On 22.12.23 04:05, Yao Yongxian wrote:
>>> Hi All，
>>>
>>> Have the stable versions of the linux-evl and libevl, which can be used in the product been officially released?
>>>
>>
>> linux-evl is provided in three active branches:
>> - 2 based on latest LTS kernels (currently 6.1 and 6.6)
>> - 1 tracking the latest development kernel (currently 6.7-rc)
>>
>> So, you likely want 6.6 when starting a new product development today,
>> and you will have 2 years of support for that baseline.
>>
>> libevl is single-branched and does not fork-off specific stable branches
>> so far. You can follow the API revision history at
>> https://v4.xenomai.org/core/user-api/api-revs/, and you will see that
>> this is fairly stable already, primarily adding APIs, not changing or
>> removing much anymore.
>>
>> Regarding the management and stability of the interface between
>> linux-evl and libevl (i.e. the ABI), see
>> https://v4.xenomai.org/core/under-the-hood/abi/.
>>
>> For more details (or to correct me), Philippe may help.
>>
>> Jan
>>
>> -- 
>> Siemens AG, Technology
>> Linux Expert Center

-- 
Siemens AG, Technology
Linux Expert Center

