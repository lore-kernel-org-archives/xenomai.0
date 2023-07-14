Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05A3747E
	for <xenomai@lists.linux.dev>; Fri, 14 Jul 2023 07:52:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfV4OKDUG1HDIsTqP/4duZd6OqovSt2I7sMQToQeof63Rk6b/7Z7k+9UmFFMYeM+O5uHi2NJpP/sX/P/sMdXTZ2+4GkW3odDbGib+WGqdhTL6Clh+6KdoqLpfkmLLAe/Q1DEndbL3FkW9Dkv2yQ2ZUo1LevaSMXqeItypws+6UDEq35TL2IXFVTzuTCPqyQQ/MWag+gd6Dt8VPnTJNwzqx5k9UtkVkAvj3PJ3QCrim9R+0NVQoHyGaKToU/v6ZPqhagQiTkzJh0s+W3kAXUubgi/nvsGssxeMZfUqd1yE5En7kJJw0CMGhPF54xemVMd/GiBLX8syCkKrGhngMa5vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXbtgLp8fAnl0va/nZOuYZmIOxk9rN7UqDsruyjTUuA=;
 b=cBRv7L9LHl9L13BDa71v/hQ5Tf7VEKOzlLQBr6IyTiylhckUUAp9CuAQuM2EYhQiyixxqgjkwQftkHYQEW7KXQh8ieqn1liVVaGHXVNTJoDw6CEvADorNRtMC24w3C+A9D+WS5u1Ve/HHMG3vRwSPPy5q7Qnvm4Gzyg2fZUHoyIYjWg5PUeWis0NivT0Q4Td/aTWDJUnIGvrxnQmikJZkvabqr356I4ZFys914nILsG/LJe572KzpSsGCfPmEBUnPrcxUQNvBcftzojYFAlwGCQdPf+oRbkncbixwzUhSPCuawxgE8zMTnP0jM9eAMuV/CB5bbk8Etl3yZQlvWZYtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXbtgLp8fAnl0va/nZOuYZmIOxk9rN7UqDsruyjTUuA=;
 b=NgTe+A4yL/zjfzOVOWQmowYgTniucm7vdyRrcZ2huYx+tXlX2xRaS58ePNpuSSqTZDswv0t1F3qi2t8SA0ScBlm+IZE6a1ijxCWbuwcj4QJLRCBbo6gTXSUYDYSn8cs0HHvTIvShSwUgl7Torg026eq+aOQf8opn6xx7WxuhwLvGggkdUH6AlYbcYii0L3SCfYhpsduBJD0FENcqnOaZe0ZpzW9BctD9/5chOSZ/bE4QoqThoLkvH6dKlU6g/IqGN4CpnB6Hb0jdZn9jz43nRCO2Yl301B4QqSHvoId1rmf5LKM03Wt/Ty+hHlaDcCjmrtl581DJw7mPFflIHGX+mA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:289::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 07:52:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f964:e0e9:199:9246]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f964:e0e9:199:9246%6]) with mapi id 15.20.6565.028; Fri, 14 Jul 2023
 07:52:18 +0000
Message-ID: <b22d1a94-32df-9b09-7435-267e315e7b37@siemens.com>
Date: Fri, 14 Jul 2023 09:52:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Xenomai-dovetail-kernel failed to boot with bootargs "irqpoll"
Content-Language: en-US
To: "mars_liu2023@163.com" <mars_liu2023@163.com>,
 xenomai <xenomai@lists.linux.dev>
References: <2261a1e5.4d52.1894fb82fac.Coremail.mars_liu2023@163.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <2261a1e5.4d52.1894fb82fac.Coremail.mars_liu2023@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0238.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5349:EE_
X-MS-Office365-Filtering-Correlation-Id: bd42147e-4626-4db3-eb85-08db843f3f36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Szf6BjIGbm8Np/vQgkqePUsjwgOGJTW5KT6+B5RqOzcMH17JQI/cs+2lriVYGOCNVcqn0Lx0pCSOJ7iwu1nv24yKqgGvfHFwWCKWGTScHizo3acIWdzdAyyKdTtq+FojjEaF8VERp9vGOwMlyr5wfZxXqYP6mvfS6kxhn1smwdVIGUP0LK75PDSEU0r+RZQVRQJ/+PbZokshm4/z7UF2QY1MDEWl6hnkFISuyVR81K3fFUnojC6PqXbUa0v1AyvAvKQqM4A1ElJoiOEykB87RbexBNGR1T7zIFAF7OOd6mKMlm9xgCbInCXuY82Q1y/yVIGtlkN613FEL5HlyBQ11LQEcCiXwDU+vXuD0LwYWrKT83acDl/g/CBu5nQwhf+4eKthCY/tjt4nzQg6C4lnAgXzMkA6QobNTmHs4sN0PRyNMjktWSHiQi1evLGydMc1U/4ormZ6ot4NQWUcbgk0LhzrdY22nXkL+0eJ77Wnjf5zuX0aaTCfiAyyPp2I5LGVFEtMF/Yhm+Q17XNqe0jTAKLqZ88bYLTAV0bH8KmsUEp20GC+UGgP/DiFhcXpvGQW+2SmZt7Hg1JgY+1IHp2rIiocIjgDojYpht5rPDRHkI0esvek2oxgDsLKzaGgJ3XrCGI5PXHis0JjwrYMfvkQ0A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(451199021)(31686004)(2906002)(478600001)(110136005)(6486002)(6666004)(8676002)(8936002)(4744005)(41300700001)(36756003)(44832011)(316002)(66476007)(66556008)(66946007)(82960400001)(83380400001)(38100700002)(6512007)(31696002)(5660300002)(86362001)(26005)(2616005)(186003)(6506007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckpMbmRXTFg2ell2dEZIUEVkSGIvcnNNamdwNUtBWmZjZXc4QWxpQ1pmY2pi?=
 =?utf-8?B?RytLaHN2UlZiemFSR0JKZVgxUW5WamZEZ3VPVEJiYU1sZnFpaDBBQTJoZUZX?=
 =?utf-8?B?TjhIMC9xVmtpOU50UFNYUFRVWTdJaVl6cHpCd01rL05BbnRwWVlSL0wwY0Ro?=
 =?utf-8?B?Ukl4cTJPejVqYmd1MVRnWi9QSjFiTU9MNklLamhrMEs1ME5Pc2tYSlVtZVBo?=
 =?utf-8?B?bjJGR09Sd0NOZHZNTndqaHRJSkFvV1FCaXRsNW5SRnlhcDdjUlVaeFRNOXAw?=
 =?utf-8?B?dTd4SjBrZXQvdk15anpMY3k0L1dVbHMxTmpvOFFjYVhEeHVJYnFGZFlTTnVu?=
 =?utf-8?B?WjhaREVMMFZ3S0dQd0k1ajN0OFFVK09oYXl4RGEyUDViZitTblBZUVlDVGxU?=
 =?utf-8?B?R3Arcm5yTVd4a1RWQlVMQ1NsNHFvWmd5dExDcmNpYmFvdHFxV09mK1Z4REpC?=
 =?utf-8?B?TVA4clJwMU95NGdySTYrOFowcVJXZmlCSUhHc0pSK1RFcm1rWmhLMzdXTTZG?=
 =?utf-8?B?Zlg0d0hwU2VsdTRmbjFJdnJqTGo3VkRvdjZ1aVU5RlZGbzR1cmJSL3JCOFJR?=
 =?utf-8?B?R2V4SUlVTW9HSXZoY0xIenNiUzVDUXdpQjM0RVZkNDNZSTFVVmNKTDMyYmlV?=
 =?utf-8?B?bFB6SXJmMCs4MmI2bGpzRXV6cFlETFRGYkxuSjBWM2dZeXl3Vzk2TDZEeDFY?=
 =?utf-8?B?WmlkR1dMMytSeDFXYktxM1RoWTIvMnJsWXp1QkRtMzA5MElpM3NSVXBwSVk2?=
 =?utf-8?B?QmVDSXpFQTh3WjVCSTYwTkZnKzlTVktmZWtCRzQwLzZDNUxTNkV5T0ZPUGpG?=
 =?utf-8?B?WVlaYWlFYktuc1lrOCtGRk9XMkRaQnZOZGJhM2p6Zy8wSTh4dXlKdXVKUDZZ?=
 =?utf-8?B?SWZMcWlzY1NhVGs4ZzU3ejFWZUhhd2ZFUlYwdnM1blU2NG1Bck83dXQxSU9r?=
 =?utf-8?B?QXYzYzliLzZWNER0UHdEZ3Yvc0trYVhhQkliNDZqUDFteFYzQ3puSE83bDc3?=
 =?utf-8?B?UVRseEVyM25iVFZ4a3RtNGtoVytWRTZNZ3cvNnVWenRqeEd3RHJKeTI1T1Zk?=
 =?utf-8?B?aXhOUHlubGVlWWx6MEJYNmpHdVZjQmYyZXRUYWhkWDRoNXhPSnlwcjB6aHV1?=
 =?utf-8?B?b1AyT1BOSVg0eGhyemY2UFVOMEJyNnFONjlaUTlUMzkyOUVvT25ZcHFBblBr?=
 =?utf-8?B?Z0RVVkxpOFdGTjl3cGN1RTE3bTY1NHdNbnFUZVg2M2FjZ1Q5djZoWTRiRG1Q?=
 =?utf-8?B?TUNWRVVmaHA3QXp1QjRzRTMrcGtyOG93ZXZVZmk4dksxTXJwak9mYWRCK3Vk?=
 =?utf-8?B?NUE4MHJtOWxhS3h3c3krZmtpYzhLMUl4NUVRVEcxc0VVQ1kxSTkvMU9iQks2?=
 =?utf-8?B?KzhyNnVsM2NMREhTUXZHOEl3SllNYlozcFkrWnptNnRYUzNBRHlRdVFwNzlx?=
 =?utf-8?B?OVdUb2RSL3JiajB5bVFDTnkxSXhTWmZUejg5NkNlandCZWZleWhrSWRyMUMy?=
 =?utf-8?B?ZDR2QVVnUjJuN0VNTTNnUmdUZ2ZtSUZjUUZ0ZlVUSE1kV1F5Rjhoa3I5ajRq?=
 =?utf-8?B?Z2V5ZkFMT2t5TzJpNDlKWEVvYjY3NGxBWXl2REsyejNYLy9IMm1YN2M1OHZy?=
 =?utf-8?B?T3ZzenI4Mm9VN05Fa1pBRDhDQitENXh4c29KRnhYTWZpd05PaFRtSUpxNkp0?=
 =?utf-8?B?dnFaS1lBOUNmY29PNm8wQk9hR2VYTnlKR3I1VXZkQTRGTEpmZ1o1LzFVeFQ5?=
 =?utf-8?B?eHc5bjdGZktHbkJXTllwVHQ0Vi9UUEZEOE1ScXZTMkRlRUJFbjd2ZWJlbTlO?=
 =?utf-8?B?ckxCUlBIeXhyWUtIeDhucGx5bkV0NGVDS1NCYU1LK1lWeWVacW8zUStmKzBz?=
 =?utf-8?B?dnpGaDMzMGpIOVovTFIrb1dvdmp0Ym9pNlExN0hmTFZKRmlMdUlmK0crTmdk?=
 =?utf-8?B?b1pEUlhzYlZoajIrZ1JvVmxNaExKaUwzYVVLT01aL2ZROHgwVEdLblJRdENR?=
 =?utf-8?B?WndhTXpTZUowVEJGQTU1Mm4vaFZpM1BXMVF0dmUvNGNzZ05vcER2T1gvOGRC?=
 =?utf-8?B?UXB1M3ZjSk9SRkJ6ZFZBYXplTHQ1TTJPY1VmN0xvc0s1alBYbW1tUmZtZkdG?=
 =?utf-8?B?K1k4aVdlT1EzZ1l2NWYyRSs4bjlBMEF6TUtjZFYzVzk1dDZqOWJ3TGJNVDNo?=
 =?utf-8?B?cVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd42147e-4626-4db3-eb85-08db843f3f36
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 07:52:18.3506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0hj3RJ24TYnmV+pNQkhRTbqoNUjfLmvgujVJJwuflNMZ0zYOKGpeyMM6ag68tgMUSIWGmu+Dyk3sdYjSisfWFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5349

On 13.07.23 16:46, mars_liu2023@163.com wrote:
> Hi, xenomai:
> Linux-v5.10.180-dovetail-xenomai.v3.2.2 （kernel：Linux-dovetail-v5.10.180-dovetail1-rebase , xenomai: xenomai v3.2.2）boot failed with bootargs 'irqpoll' on a machine which have two physical cpus .
> 

"Intended to get systems with badly broken firmware running." - is that
also the reason for you to add irqpoll? Just to clarify the use case
upfront.

Jan

> We  tested on other single-cpu machines with the same kernel and bootargs as above ,which did not fail to boot.
> 
> We also tested the older kernel (linux-4.19.89-ipipe-9-xenomai-3.1, patch: ipipe-core-4.19.89-x86-9.patch, xenomai 3.1) and debian 11.7 kernel (5.10.0-22-amd64)on dual cpu machine with the  bootargs 'irqpoll'  ,that didn't fail either.

Never tested that so far, might be a limitation / conflict of Dovetail.
Needs to be debugged.

Did you happen to check also a newer Dovetail kernel (6.1, 6.4)?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

