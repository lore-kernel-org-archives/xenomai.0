Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2081.outbound.protection.outlook.com [40.107.20.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA76185A
	for <xenomai@lists.linux.dev>; Thu,  7 Dec 2023 03:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="DjMwRpq5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mquNKq9gjZ8Q2IMizRs3ffrcPQpQE9+nUOOsAPaS5Mtrf6I4MHYlBPDNkEzNjFxRqcTPm50I64lUGLzEE8tYFjQ/GvnRkgd2Va+6Cz3lt4rvSw97JmXqFcOdvnMTJf+cO1d1sgnDeYBVbvWBe2p5w/xzplS6Yo54i7lKF8bYJe+JfjzGOFoy6WvfVuxGsDlO36J5syoFqIhWw0EWAXxr8yOyN/NRYgkSHOdfBAdx5j8ZhxpT7drZsnseb+16smiNMvGc4zVSSnpnyf1VOOgGrIkFsGMJY5yWHfG4sDYXnyCuGoEUPBjmaZ8OWZKXTOR/XETwjWZEdFrqHwvOdPi8OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QY11+3qXeX0UZkmC0HgXMtc1Zbwtf0TXOyH2kNJDjIA=;
 b=Cqnrj4GhcCOQ7YpkhQrBh4k1hFp/7KV+3AIJrIhZ+MKwrEKjNyGlLV62nWRnc4VBPiLbWNKqjJtSiqzXprIbFgVJ7xMMvOY69YLCfxj//XCBtdYKvKd+9abM9chNrQza+8VcDpb4X5NbNmY6aGubJ0RvMy9zJzUJSMOt8ZNCc+wNVdCae0ckNOHtv8bIDXCXKdhpt4b/gscnhLQNJyhZF3yG9HmDzknIY0FG8dGlBJOf3/WrHj/5ypN3cXvSoRRpg3OR8xCCtZNRjj17YSTM1W5ntkLB8A3VjIb1ax3RRpiL0W30DpOP57nwWkNd6ov72cVFvczU1rRotlR2UsIYfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QY11+3qXeX0UZkmC0HgXMtc1Zbwtf0TXOyH2kNJDjIA=;
 b=DjMwRpq53gc/BGhHBQoZUMQQsIPEcH2YC5ZlAxn/jTgo79sTUNYh5OriERszoB65Xqa1gjd/GCayuveJMBernBZjlHOFt1Q6hKzHggicwFI2iytQSB3dSZ7HteMjx2gofl6H1S0U/QmYNBPe9HeBMxEiZdyYWPN1C6yHdQjAbyATRdVqsC+Kzszz8C8igvmf2FLEy/gtt7YTQM+56pkvpAkKALxLHiHyHAORE3UcTJnZuEVPwbMUMeznYpA/ccgnc78x94OHfCbzu9OrLXlgbqVRZbsWgrAipFyQX6LmGUqY2ni5HTMrpKOb2B+9wPElsF7ELr6GSMhl20NvLYnbmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB8196.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Thu, 7 Dec
 2023 03:09:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 03:09:22 +0000
Message-ID: <59304ac9-8bf2-401c-8722-a2642ba2226f@siemens.com>
Date: Thu, 7 Dec 2023 12:09:07 +0900
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH] tests/jobs: Fix warning about an invalid
 value for kernel type
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: quirin.gylstorff@siemens.com
References: <20231205152202.924589-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231205152202.924589-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0009.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::19)
 To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB8196:EE_
X-MS-Office365-Filtering-Correlation-Id: f3adeadc-8964-4f50-b06a-08dbf6d1e945
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GcoPCp+3ouGiwrogRWgj4t8/MVpNVK1gzsG80IDcu3XuYt+aYsl71Zqon5KpnF9YrMbwg6aCB10pMBedBRvjgH/1+jPQZfTJGI9K4zX6i1wTxl+56WP7PxxtiMOAHX/B1D7p9O7oqwDFr2CDD2mO15bFJYC0En10NB+Pw2XE0XLRXMEfEXjJN4CNMazRpJycPsp9WeDX5Jgn2XZjkLNZYxqQ78018EcyamcwIOVPxKHNtF4TbiZYFRiNh7RjnMKIWD1OXGyHf/5PX2QCKdaBHpYJ77SWaS/qi2exDB/h9YoL6TBp9tGm8l878JqOToJeGWwDtndBbdO9IB7ZYQiceZWpjKxTimjrxNT2kLQBFbEdfj7INFYjQcUqV88NDzQG+Pz1TnU6Y0/G+LLs2hU3WzML1ZY/ZSB73lwbb6Q4xmHmoiOsP0IzVoT6O/uzSK28/0DqyG7uT4glHiupV5bMpeU+LGjvw+r06lBVxhwnteDahhfwQV2gUs1SiAI4rpJzWIcdeGyyuFAzhoRPji4FtvTUCZ/yhrEEdpjgqe9mdYm+UG+U786ETGbvAG91H4HISyMavL7PDj6wWt84cR5DPOVrNIWRAPDIJ68MdLD1PkhRqaEvVBzkUHX1Vu3afXC/Ydmv1iDpKhw4XN9pM4du0BudnAQ+Wxv1SGoQseogRihXajdJqtziTYL8xVTlKfgV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(366004)(376002)(230173577357003)(230922051799003)(230273577357003)(186009)(64100799003)(451199024)(1800799012)(107886003)(2616005)(26005)(6506007)(6666004)(53546011)(5660300002)(41300700001)(6512007)(66556008)(8676002)(2906002)(6486002)(478600001)(966005)(316002)(8936002)(66946007)(4326008)(66476007)(44832011)(83380400001)(36756003)(82960400001)(31696002)(86362001)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0Yzem9UZGZ0eEVYQzNFcndLK1VLZGJORFRDaG8ycU9PZFpZcnk5QWo5T2dY?=
 =?utf-8?B?d3c5VENweDc5dUZXcWxuZ3hYVXpQelNsQzFvQ2JSbkFiZ2hyN2xvVnhGL2Z0?=
 =?utf-8?B?UTRHYzVOeVhYMU1uUmROcGJidnBsWU1UTXJ4SHlaNTRUeUFMeXFqRy94dTZU?=
 =?utf-8?B?VS9ySzgxdE8vbzV2Nklrb3hjeElkMW9oRFk3c3NieU1VME8yVUxYeUNQaU0z?=
 =?utf-8?B?VDd5SDU1NGZ1cHAwQjVoNmVySkN1TStDYjV2eUdpK2cxS1hiTW1JWDN4dUlS?=
 =?utf-8?B?N0Jkd05kanluSm03UGhzM1FGVXIrUUd5Zm56S09KMS9rdjVaNDV0NEU5aDQw?=
 =?utf-8?B?RUtRZ0JnQkM1dWYyTStTUUU4L1RKSWVMNTVoNlo4bDlVbGRyUXd0TWU1S0FG?=
 =?utf-8?B?UWZvUXJpU1VQdHFUeDZPQzlKOTA1ZVdvdnFCUmsrOENGZUgxQUhlQVFkVlpM?=
 =?utf-8?B?UUlFSTI3VE9xZ0pZd011bU9ibm9yOHdRNlpJK3NpVExHYXZlWnhXQnNIS2ZL?=
 =?utf-8?B?NzRURmpOZXBPL1RxNUt2TEtNQ3RFR3MwNHhtd2lKdzg1R253VktxU3g5RDhE?=
 =?utf-8?B?d2xUOE1IVkR1MzRiSVI0SHYwQUIzOU5VMHNTb2l3TXVXNWdUZm1GQzdGUkor?=
 =?utf-8?B?dTNlTEJ1UmFuVkdBOENRUDROZ3MzRlhhM2xZWHhESFkxS3MrUWg2VGxLWmpn?=
 =?utf-8?B?bmtMdCtoL2VJa3d1REFRSlo4U0gva2NkSHBsTXpOc1BwUkoxZW1iTThNWVc1?=
 =?utf-8?B?NTIyVU1zRWprbnRjTHRnRE5VZm80L0syYWZmMzVaL1FnSmVrNGw1VkdEZ29H?=
 =?utf-8?B?QXN5cTlVcDFMK2hSbXZNbGdtZENValZ4UWdlVnE2US9tTENhZVNid1BQSElY?=
 =?utf-8?B?UnBxNFlzMDhHUWIxd00rV2hHV3JQY0RoRWlMRG9WdXhaY0JpOVV1amFYQ0FF?=
 =?utf-8?B?cWZoNTY3NWJFMUZLdUVhY2tRWVFjN2YxUmsvU0tiSVJDczFJNmwvZisyWmw5?=
 =?utf-8?B?TzYydjR5UkFKNk9NdVVubUR1WktiVE9vWnFDQ0JFVTB0L2M4eFBVK2NMbjN2?=
 =?utf-8?B?VFU4WVhlT2FicEVMaTNRL3hhaEp2NE1wZG9WRGxmTno4djVjNCtKMkVCcWQ1?=
 =?utf-8?B?QlhXNHM3eXRHWWtCL2kvNHVzeGJmZHlRUnJqQlhTK2VpTDg4cDYzcndxT1Bz?=
 =?utf-8?B?clJkMm4wWUkzWU5sRmpHcU43TmQ3WmVocDBZdy9jbjRwcWNDNFpmSUtma0dw?=
 =?utf-8?B?dEUyTXpUbVBudXFMSnllcXNiUFVNb0dMaFp0K3VEYzh0djBGVFUxSFU1SCsy?=
 =?utf-8?B?SjkrNHRVVUpNZFVwU3N6aEd1aFZ4RDlTUzBjVmRJSVJXMUNLQU8wdTJZYTQw?=
 =?utf-8?B?dnFlWmRpd1RSWTg0UnBRVkFhY0FXalN1b0M1KzVqbGVDdXcveHp4cE50U1Rm?=
 =?utf-8?B?d29qcTh4blJYa3hLQS9vZ3FzSDVmSFRwbkJEUVU0NjJGZVBvV0kzS3BYZjho?=
 =?utf-8?B?US9NaWp1S2UrNXVhTUMwck9pdWdnZDJqTW1ZN0VwOTFUVUtvTkVVSSt5cWdS?=
 =?utf-8?B?ZTNTc3ZyeUxyMzRpU3E0WjFhM0Erd1dHdldwMFpHendQRTNQMjM3cWdMTFRv?=
 =?utf-8?B?cTQyUXNkTVRHL1VLRmZnRUU5bUkzUlFxNkZYUWhtWnVhQ1BIMUM5alNtM0Fp?=
 =?utf-8?B?ZGRjZ1grQ3plRlkzUnJrU3I4UCtvQUNVOXhMdHBPcTZ2UEh3VFEwWTZoMEN6?=
 =?utf-8?B?NWVYWmVwUGp2K2F2b3BJUE9ManF3QXIyOVNoUnJQTUdxTHlueVhMNGNDZ1Fj?=
 =?utf-8?B?M3RDRUd2MVoyMmcyY2x3TXpYL0NKTmJpQWJDRmZ4dmQ1L2xSTjBpNTdVMDhk?=
 =?utf-8?B?QVYyTWswRU9aVU5rU01JVVI2cTI5NCttaW8renJ4b3B2ZVhjQ3J0Y0pSckln?=
 =?utf-8?B?VENEWVJLTVhPcnl5QU1kakZPWVhyVURUWDVFMDhULzZpTERmQndrMksxTkVu?=
 =?utf-8?B?K0FJN3JVbHE0TmxaM2sxNExyd2VLUTlwYUxuOW5rM2lwM1R6Y0VyQzYxSllO?=
 =?utf-8?B?a2JlczBUczdsZ2VwQmxVb2J3R2ZkdkxDRisvbVFSbW1aaTh2RWlIM1YreGFp?=
 =?utf-8?B?b2pzVlp5Q29QNUdoeHI3Yy9BOVBUNzZUeE95U3I3dlEzNGpuYmtjYXpZZTd3?=
 =?utf-8?B?U0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3adeadc-8964-4f50-b06a-08dbf6d1e945
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 03:09:22.6501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E9FeIN5ghPAGxz/nKPQVf7ApBGRq/42wBUIAiUTMlERgGwgkKiihceTRi2ieSjni0qJfGHKDH2smy3Bf25BDqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8196

On 05.12.23 23:22, Florian Bezdeka wrote:
> The following warning could be seen in the LAVA web gui for all x86 test
> jobs. An example available at [1]:
> 
>     Invalid job definition:
>     not a valid value @ data['actions[0]']['deploy']['tftp']['kernel']['type']
> 
> According to the docs [2] the supported values are:
>     image, uimage and zimage
> 
> As kernel type for x86 bootloaders is never used we can remove the type
> property completely.
> 
> [1] https://lava.xenomai.org/scheduler/job/11720
> [2] https://docs.lavasoftware.org/lava/actions-deploy.html#type
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  tests/jobs/xenomai-x86-64-efi.yml | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tests/jobs/xenomai-x86-64-efi.yml b/tests/jobs/xenomai-x86-64-efi.yml
> index ec28291..d71b5ae 100644
> --- a/tests/jobs/xenomai-x86-64-efi.yml
> +++ b/tests/jobs/xenomai-x86-64-efi.yml
> @@ -33,7 +33,6 @@ actions:
>      to: tftp
>      kernel:
>        url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-vmlinuz
> -      type: bzimage
>      ramdisk:
>        url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-initrd.img
>        compression: gz

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

