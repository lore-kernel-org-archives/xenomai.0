Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2079.outbound.protection.outlook.com [40.107.13.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627627C
	for <xenomai@lists.linux.dev>; Wed,  5 Apr 2023 06:31:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpiuBVgA+kHCo8V+OTwn4FNfKn/2UweFoOXV0L+YsB7ZTYdwU/gvhdzgPYfxM7g+Exb0/u7EvNt9P8u8XVh4E5pYAOwzRR7NcRKj/uq+gVwwcdjPlxXpfCn4+Cdtevy10Hi0xUQlk66y8t0MshDYZTOO5SE+KVwx59T7kka1BUUs9x/VQRrge5UvopcmXu1JYj1Y7c7qlDRxw3mmkcQDFXPIiSD69V3N45KZkFGBkpj5mrUGBjKJ9OvlU/Ky5QKltEYxxjSWGjjqdPLqHRVfLsv92wOQCxbRnEK37TKrgSG3uSldl2jQX6ANr+1mjsa8Z0GGtOMYSEtnwiAQA2WUAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4T1vqwgoKdGaqbjXSQuJsASJp9rXt0CI8suOENjcn8=;
 b=Clu9vz0sXE2N3ig/n3UbPmN2ODwGQWYiI1OmfNJJM8TdswSrWjc/quKys6C1w59IwdEeAyILCOGFon81APPht8bmu5X3eBpAK4PiE2vni0pkW1PWnGYwcCYeq8AHQR+qAxYCkuMvDtTW1eJBmEh4yV9jrBwdgoxSQB7bJT5JB32+H/0Z97DoW6p+q/f4wGt5HwMMW3kfayIIXH0uDhDXAkDG/G7KO4ChlvXnk0Z5d9yJ1wJJ5Y9bzblHICmxzEX/aJ3wOTHen2yZyLza7DKaYdRDMFOOo1W3B1AUUrXhZmZ6nhE0jNjEcgRpbaoF95GmKaMIeJf8f8kRVA+JE7MnhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4T1vqwgoKdGaqbjXSQuJsASJp9rXt0CI8suOENjcn8=;
 b=V1aYW552gqxMApMKBpzI8pkYdMoOVSr8gRJrTMZarFLHSUdXrEKtvJfiUNgxdhVxjCoK1mBV704h/nxVwPKM5IX0DpWdSDhpAI/mP/7bbhr5RsaDRAL4amnt/+9DRqYnPEpsriOx5q5NBv82cVliMrK6MlofvTBrlrdRsMGqiEcqNlP6JxhcFyCxaIKoxR9cajL1UrKZ04BcJux1Ltkbc8eD8u1fv29KK19PkFakvBUsU3BORmiJ+baWOyNwwPgls4MOBcB6eCKNRd3jUdzpvztyc5tEgEr1v8v1DqMu9V1ANm1kJ0RSoTSJ+p0MeiKmTgP1VpHly/TQAFuHg9+Jjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU2PR10MB7726.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:46f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.18; Wed, 5 Apr
 2023 06:31:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%9]) with mapi id 15.20.6277.012; Wed, 5 Apr 2023
 06:31:11 +0000
Message-ID: <dd9c6665-ca22-b93c-c68b-75ce825119f3@siemens.com>
Date: Wed, 5 Apr 2023 08:30:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To: Gunter Grau <gunter.grau@philips.com>,
 =?UTF-8?Q?Jean-Baptiste_Tr=c3=a9dez?=
 <jean-baptiste.tredez@ba-healthcare.com>, Xenomai <xenomai@lists.linux.dev>
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: fec driver needs care
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU2PR10MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d653e6f-0d8a-4930-2992-08db359f5903
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Z5eBCeVU7SOlXUo3syzZmHGH0UB0tHHQY1DSLnE3cnxmUdDf+VSWxlWDb1HOSvZMQ0miT8KLGlNVmF+M156kn9mSAJ8VRIuuR6YzwpWbKKMRQnlNf+SiBRLze4Yp+ViEaJbgJB03jEgTAO/YZ6BqxF3dExgZOuUj4ogfdjqZrYTpAdocNg0bJVfhI5fn9s97Prrb9nRFloVLjURBdrt1M5F9XHhcErCU4B/v7Fh0blKxxt9rk2/tNe8jnmXwLxKo5RGOpCT6ou77uuKCup/92VwbW1dn4cwRhM/3Cjuw1CivCBdEmstatQCq9XZ6jNYESz/j9WK9lY82MyhGI0fudjqbJnRUpIjAhJiYHvoV5yfIFvdlrL+pJCMBWuL5oM6UqJ4FFQiLWAYFYiwVOsEvCkxDf+qcJkgoJPnGzDvzOotQdRYUPcK+u9SD6nJnE8pqfRt2kFdfCuWq0KBKRiilYM0rJEc8zpqGSQ5FGBGG9taCDx1wltjfuNhrvxqII4WhnG9iPjcu+mfRjWdlS8Ygc8WFYdfFHUVlP/b4pMCbiDzwa32ZACZxV7R05N2uGdgIXlkDkvu1E2pQHIU024waz1guaSbF/B+73nkYAmjNrW6tzIEj16WPksOzsGciYdMncZQ/B6fG+sjcuEg08UvYdgH0t4130MK3F44bXZcuq8M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(451199021)(31686004)(66556008)(316002)(66476007)(110136005)(6486002)(296002)(66946007)(966005)(8676002)(6512007)(36756003)(26005)(6506007)(6666004)(186003)(2616005)(38100700002)(2906002)(478600001)(8936002)(41300700001)(5660300002)(86362001)(31696002)(4744005)(44832011)(3480700007)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0F0UHgwK0d6alNwOFVuN0FxdERZNWZ5Vi9lemFWcS9kNjdRNm53ZnpOeHEr?=
 =?utf-8?B?RHMxdDFyTGticEFneWl3S1ZkT0xscG1DRE82OUdJTXd2bEZ6TEpieVZKaXls?=
 =?utf-8?B?Wkd5Ym1XQ3A2OFdJWEpFd1J6R3lvc0xyWk4vUkorblVKWU5VdFFwZTJ3a3NK?=
 =?utf-8?B?blRlUy95Mmw2UkhvVGh6aVVCL0l6UWJwNXA2bWdoSnNiaWlJUWVCSHdsWlNt?=
 =?utf-8?B?RlZrbVRiaXR5U3dBOTlJcnAvcHdvSXpnZFcvLy9QV3lUOGdMcWtGdlYvWXJD?=
 =?utf-8?B?Ti9QUCtlekIzc0xONDgvMkZxVFhZNlp0bzZLQ08rcno0dnEvUWVRSXV5UWRQ?=
 =?utf-8?B?R1lJSit1R05DcCs2RU5OWm1JUkV6MWlBb1dKajFrdytqQjZvVUFSK2Z0b21w?=
 =?utf-8?B?a2d3WHhvQk5maDA0eWRzWDhTbDVORjZJU3RnZ3dMMHNjMXI1OVd6OUx1dnFx?=
 =?utf-8?B?djhPaFFxK24rUW5aUXlrTFBzWEhMZGJQbUNxSlVxY1dzQ2tZRmMvc2E4REtv?=
 =?utf-8?B?cnRUbHVxc0RPRmczalRUSGdOcFFNajY3a3VmSWlLV0ZpODRWVGJuYWtmUlZ1?=
 =?utf-8?B?U0JINzMwMXNDYVdkcHd0VWQ0eHhqallGVldXTTNDWXdUY3BGN2NwTjNBaE0r?=
 =?utf-8?B?WnJ6OXljTkVmZ25rSXU4S05rL3RnYk5MNmNwNzl3RVFTV3Y3NHBINU9DSWdv?=
 =?utf-8?B?OHJIV1Noa200RThQN3FEWkF2Z2NXOFJZZS9BZ0cyeW1MWWZrRjE1ZnRDZXQ4?=
 =?utf-8?B?TElHYkM3VHhOWVF5eUNLK1FMUTNkTHpmeUZLdWhvZ1JRZjR1MWZUVG15cUFX?=
 =?utf-8?B?YmRCVmliQ2hGSHl1Mm42UEVUVHBoYVRXYnJIc1FicDQ2TkFOc3E1MUFQZGZz?=
 =?utf-8?B?WWg3eGlFcGVLOHFKeldHdi9FM21NODd1UE55OTBxbm9tVVV2Z1l6TWQrT3p6?=
 =?utf-8?B?dmtTblozMFJ5eStrUmRxMjhTTzVuZ0dlSDhJUzlTT01WL2Z4TUlNUkpjaWpz?=
 =?utf-8?B?WEx3L000eE44YmN0QjcvVVpxKzZlL3hLdi9yRGZyaXZNVEhiQXBNVjFodWZG?=
 =?utf-8?B?SWMzN05pbHZyWlZyTDA3VHB6WVBWNGpXYm12Vm5RQ2JickNDQ2F5U0huMlE0?=
 =?utf-8?B?THJYYk9PYXlYZ3pqMktyUlVhRm9sUlcwcEFiUlB0amk2U3FkUVZuRW9WaTJG?=
 =?utf-8?B?UElmYXN6NUcwYXpwMDBiUW9ndDg0M3FMdHJzWGN3ZDZ2NVNXKzZHbldUbVh3?=
 =?utf-8?B?VnNsNnB1S3MvUC9Oemx2cXB6ZGVtOS9OTHpvVFIraFZaWm5XTDVwVG1BaU5W?=
 =?utf-8?B?ZGpLb3RYcTJ2L1hLNC83NmFTMXZGWVpTa2ZHVTAyU0V2V1VUTmdGNkZ4dUdt?=
 =?utf-8?B?ZGVmMWwrckhZQ3RQWE1FcDhtbndZckE5dTFVaGtQdmdORmpmbU1jQUZCbEFl?=
 =?utf-8?B?aXhteVZHYlRCcHcxTzZMNi9vYUx0azRycmQ3Nm9TNEp2bFMwVkYwY3JoSHVI?=
 =?utf-8?B?MnhNWmZrYW0xMnNSNnJKalY5RzFVMWlwK0w5eXpRdVR5dFJvTFpmSi9RbTUr?=
 =?utf-8?B?c1UzQnVnUGdTOVF3TTcxWlhob20wSk1hUzlHRUV2YmVYMlZ1c0IydDNXTWlO?=
 =?utf-8?B?U3B3QWFWVHhWMWFjTGVvLzZ0RklkeFhHck9nLzV3dGp4cUFjaXAxcWdnWXVq?=
 =?utf-8?B?UlFSVkwwaTFaKzFLSWxYeHFQL2luWkxralV3TG9HWk5JeEVabEtpODcvc0Nu?=
 =?utf-8?B?cjhNM2pmdFpYWE5FVEVtd210Rm5nSmdxMjdBRmVxcHdCcVZLQ1BZMUVwNnI3?=
 =?utf-8?B?R2R6UmV2UXdZQ1FxNTdwT0FmaWQ4eGF5ek9ZOGpncTgvMTEraXpzYjNqN2lU?=
 =?utf-8?B?YThncDhBWWdsK2lNVEhFRlhHMGFja3d3UmxaUXk0ZW1td0VDdlZkdThjeE9l?=
 =?utf-8?B?Vk9YOWRUN1Ezemd1L3hFZ1lFVThtRG5BbjQ4TGt6andpRzFPM0p4QXJ6VjJQ?=
 =?utf-8?B?ZE1YdE5jNkpSYTBFVVhYenFiOUZnRlhTUFJzSmU4K08zMmZ2d1Q3QUlIMW4z?=
 =?utf-8?B?V0lUQUZTN08va1ZGOHk3OUdJbm5RVGxOejFPRTFSdmVQRWYwSGRBSmsrUmdw?=
 =?utf-8?B?RUpOVHdtdmFkNVJlZE5pY0F3ODRrMG82YmZFZUFBVi83cm85citDZDVyZWF2?=
 =?utf-8?B?K0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d653e6f-0d8a-4930-2992-08db359f5903
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 06:31:11.4357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nu2ZXXqus/2kcnASIaDBeRca3zkry+J5WMXt+xmmyEY9ux6yeuaWIrbAoyJmIXwxcqlFTKWpMEwzNGtz0sgqLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7726

Hi all,

kernel 6.3 created separate MII callbacks for C22 and C45. This breaks
kernel/drivers/net/drivers/freescale/fec_main.c, see e.g. [1]. We
basically need [2], but with backward compatibility for 6.2 and older.
Could someone have a look, and specifically test that the result still 
works?

Thanks,
Jan

[1] https://source.denx.de/Xenomai/xenomai/-/jobs/608467
[2] https://github.com/torvalds/linux/commit/8d03ad1ab0b052f1f992a52fb80a31b7540b61f6

-- 
Siemens AG, Technology
Competence Center Embedded Linux
