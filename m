Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2089.outbound.protection.outlook.com [40.107.13.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897FA1FBF
	for <xenomai@lists.linux.dev>; Wed, 31 May 2023 05:27:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzdcpB7jYowdMOQ+wm+DNEi25Hgl0XkbDU8JpaZlq0rQCULL+jvCzlBtIcN7VGzckxeajdNqrtMHA8MG+lWYdMxdL5s7JewrPP70E4lpsKh466GVNsBZbDiflXz72GUilLEIQPKSwhqjm8f+FGDQgnKm9YHasUDdxEknvJ7s8P2exYOqfCmbleSMo/DqSKOzyQPrwKOIPjKxhb2GQuu57Uz8qt+FfvgmbJBxbpkPT1C37WcUW9stARHSbudB+e1G56w6sL8cuLtUCioH5VlVpwCCVVWFDjOtak8SAisuB2OGZ/qc1+QyKIWlQPWWxpEfoZTqiI5utATwDN8xTJIDBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rG42SneLu9JkdYenc7jkR1h2OaE4gj0o5jy/2s2Bwo=;
 b=OFaEIVS4OrEMYYTeynqowtE23n7prk+LpuNRwGgX7bAytxxYlQaJpz+l8d/TkeyIU0C3VFmCwtXUCBki0+WILIfapVwKNmFR8euThYknU78nclV33NkC037ICLZPmPqMUimNAq0TkCsS9J7O9AR2k98D1BQ9TjbpZTlDnueAcif4UiZ0WWd4UXlStWaVVfClQkvBF585gVHkacRns9Igf6Cak23hTTOvuQCJgp/KldC5ZaBn65amnhB+lruJLKT4Z+GphNco+D1OnQiL0StZLlUDF4ta0syD1UdKFxAOm7cuQg4bFw4HXoJUujzONA8AEYFaGPHRVj6XF5dzJVwaBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rG42SneLu9JkdYenc7jkR1h2OaE4gj0o5jy/2s2Bwo=;
 b=mAZBBv1QwG1suDQYlatdVlJZyZxV35ocILrX+25L76NvhnbvJg57XwYpGpBqaM7N6fD4LqK1F5evb37WPvKw3fk8uZVPthmLqEdS8RWrrbZfkQsTBnckIlWQdz+CRd/OEoAMDp87htgDQvrSQkf378l/L5gXHG/0pawI5pN7ebrK6LhemQhZS3Zq5Rmw6uuYab59okJNqEYo49DEZMWyklHGF+vTQQMWitaWhkla1M+kU1WuLRkiDiQ9GBN1UQyufagJYYNEf7aXu7TzqQatrwZcYByhbMkB2sw9JgPZJeZXY0oqCGEZ7Hn1K0qxU+SuWF5ITHwuy/HA1Pe5W3R8xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7416.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2ea::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Wed, 31 May
 2023 05:27:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18%7]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 05:27:46 +0000
Message-ID: <7223f5bf-784d-a062-d2de-975e173a329b@siemens.com>
Date: Wed, 31 May 2023 07:27:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/1] rwsem_down_write_slowpath check if oob() before
 skipping schedule()
Content-Language: en-US
To: Dave Rolenc <Dave.Rolenc@kratosdefense.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Cc: Russell Johnson <russell.johnson@kratosdefense.com>
References: <0173f9b60a0e4dfbb40fe55454a65fdd@PH1P110MB1666.NAMP110.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <0173f9b60a0e4dfbb40fe55454a65fdd@PH1P110MB1666.NAMP110.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0209.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7416:EE_
X-MS-Office365-Filtering-Correlation-Id: 96d269c6-0970-488c-bbc2-08db6197c45b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tqonFZQJcT81AWGGA3W7IrDL/izxihHqYnnGwxZJ8lQ73EbXsbzvZMJIfkqWSOpuGvC5gzECuV8xT+NQbn8AmLggXo7u/emtdqY4nOiIC7eovORBi8Gt3QHemlr9SwvdITaLlrNayg5gYDjh7ZUZRs58dkWRqJ+OS9h+Bqfy4T32vIzm5zyGV1txlzZ+8aWeBcnCKFkClnn2Uv1Ft9g7c4s054RaBrniCc0JP50UAI6tmp7zczvhkGvNvePAV7OYe1xSoJ73ml2/emPFb3O4REC6krkgbQKUN8Nhw9CvAS++o6cwajCbLnYa/gG+gSu9oMcmPrFXRYq23rygdxEiWoDTAqneGWGUHPKCtxS+gMb814zeY3ughQK0Vo1/1pwkrsPUe5Izz2kbCxuQiY4oMAqR8F1CtxtOYMAq8jdwUTI+gzoCzsdBrbp0SvMacq2XfHCCOETi2VlKKjmSzaaonJt9IGXNJK4T4plPdab2ZrSB+9PTQGJ6VU7/zeKjEcbNK3A1PyaiH/Df3ETpkkYYhPolhXepomBdlQoPOmhpHV0w69J4I+jtS17mPZHR0ix5XXjKlzSBZvbAsjq6W7CnE0z5st2JbxyvKRdoCTx/56mDAu7aMytp9S9Bqvmhuois8WNAY9ibpUpvsNvROA292Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(451199021)(31696002)(86362001)(66476007)(66946007)(66556008)(44832011)(4326008)(8936002)(8676002)(316002)(41300700001)(31686004)(5660300002)(2906002)(4744005)(110136005)(478600001)(38100700002)(6666004)(82960400001)(6486002)(83380400001)(53546011)(186003)(26005)(6512007)(6506007)(36756003)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFh5Q0Y0bjc4RGk3OVR0NXZNVzVCL256UDdLWGF5dDlMN1BZRVBtcEFnRGk1?=
 =?utf-8?B?NFNyWFhDSEdrN3ZEdW9wQ0hmUVUxK0t2anJuOG0xSm9wbzdMNkIvbUt4NS8r?=
 =?utf-8?B?eEdoUllmZm0rRlFMTzJTTG1GSzlQblNwbjlaQnNPS3pETzlMejR4OUludW1p?=
 =?utf-8?B?dC80bGh6S2NKbGJ2aFBXZ2NsRjVqQjdCQjJuQjJYMXNESWVZUDB6RzZnVzYr?=
 =?utf-8?B?SlgwTTR3SDkyYjQ0UW1ud2ZRSnc2dHRBRnVtNkl4TVRkTzJlTEtvN0lCSTNI?=
 =?utf-8?B?WU9seDRRVk5yUGRPbm1uUWc4aVAxRk1MVE5FWnpxYTFLbFhpM1NKekR4UnRl?=
 =?utf-8?B?S0NHMzcwSW5mMDFhWThXWkdreE1ubWtFQUkva3M4MC9KaXdqUG04VzJtZEti?=
 =?utf-8?B?bmk1WVE5c3NjTk9SY0pYNUpKblhMbi9vUlZQQ0treU5PYlpveExxeXEzemdI?=
 =?utf-8?B?bFYrY2cvMGExTVdveGRMWGc3cUxrQ1FFRUliYVdwS0x1eHRZYUh4Ujd2c3dr?=
 =?utf-8?B?VW8xeDV2Yk14WlJxT0FybzNiNUNHdm8ydEwrZHJEZ1lmcTcyWWk5dkN6ZTZZ?=
 =?utf-8?B?N2ZSbjF1SU9aUjFBdTVxOW9Kb2lXVk9EQ3JUOGJ4ZThjVzZwVFdaZ1dPcGoz?=
 =?utf-8?B?TmdsQjE4ZEZZY3hZTUNOdjVtNk00MXUwbTFCVmp1cWNnT2NPelRJb2RuYXlM?=
 =?utf-8?B?Y3pHWENmMmxERGZndFhicFRIZDZVZEFlSHp5eGg4clpodXhqQVRiNURwektY?=
 =?utf-8?B?WWhXVEVOaUFidHU2Zmw4SVVNYjNrZmp5RnBBeXVrK0d6OElWekF0bi9VUGVC?=
 =?utf-8?B?bGlGVlpPeXREWHJROTdNZE9obHJnUGFqVTQ1SkJodUJsbmF0YWlJSDI2Nk1t?=
 =?utf-8?B?VjJtL3BCaVZJOU5PL1gxQTByVTlZK090bzBkRDlEYjNVVm8rTmwzR0NMZ1BL?=
 =?utf-8?B?dkNnc09HZDl2MDZjSExCSlhSM2JQSFkyRlZBMjNsekczYVdhbHVuekhhZ2E1?=
 =?utf-8?B?YnZxUGlhV0JOQi9jNnA1WHdwUkxva0daMkJDU251bjlRYXVuSVlBbDFWbFYr?=
 =?utf-8?B?WWFjWXA1Q1hzL05lVzIzYlk1UFRMTkdWUlpPa0ZwSVJaMjB5anRtR2U3aTlm?=
 =?utf-8?B?emVpa2Ntemo2RzYwTkVUVWFReUMvdXFjQU9iMU5RWjY1bWZTVFUvQlFQM2FX?=
 =?utf-8?B?UG1QVVRKNVpGU1NzczJjL2xSc0prSnl0bFQ1bU1FOGI3MU12YWFOY1dqK3dB?=
 =?utf-8?B?ZmRUcHIxSWpETlpLRmxrNzcyY1d5MDh6M0V3bms3U0lCOWpqSUxNdGVqYUZz?=
 =?utf-8?B?MGNpY2JXQ1dqMFpjOHV2bk91bSsvbWNZVWRKd2xUNWxzVjZCdVp1dFpia1du?=
 =?utf-8?B?K3NMMDJ3RUlFR2djYmpScjV4cUxxYndxcExhNW9NWW52N0RTRDVFL0ltaEdU?=
 =?utf-8?B?YmNTUGpyakk2OVVnOFpicEdmZTVkem1NMG1ieVBoQm41eGR6eno0N1JqTjFL?=
 =?utf-8?B?bVhuZW1waXFvc0owTmtiNFowMEpkNDUzcTU0eGlkcXJvZmt6NjFyZlNyRFBM?=
 =?utf-8?B?L0JUMHFwQ01EekIzK203R0tUVDVjSE1XM0cwM0Rmb3ZKSHBLNUtBbGlLeVR0?=
 =?utf-8?B?SkhPWFpGMW9Jd2lqa3V2MDcvaWx6SWxBbWM5bzZ6aUNDaUhVU3d1Q0Z4N3Yz?=
 =?utf-8?B?bTdhZlBEZ1ZxZU1GaUorQVcwNGF5YU00em4wa2NMSXRVSElmUHpVT2pCVHJs?=
 =?utf-8?B?dXFNL0JhRHNONGszS0M5SFVORW9NRUc4WkZSQmYwcnBwbldCQ0FNbTNaaDA0?=
 =?utf-8?B?SnJYUlA1dmo1czIvOUhqQjNsU0s4bjRJa0hVM3J2UW9tZDVmc1E5Ym1EUjhZ?=
 =?utf-8?B?OEdNRUlKWFhUdnc0YjlaUHNZbzdpaFRRZXpNTUVsazBRMFJDRCtSZjhWQVY5?=
 =?utf-8?B?cE5heHlrRDdpdWtOWFBCZXRsb2VRb3l2eW1lMlAzeXdwU3lWSWkxc3BKdnlw?=
 =?utf-8?B?U1ZkYks4aUt4UlkvaFRkQUJabFVXaTNNVnYzNWhKcnhFYm9vUEpiMFc2b01Y?=
 =?utf-8?B?OFJweVhhSjM3bkp4N2U4L3B5SFlNMXdIUnJWSk1BcHN0Um96TFBXOEp2S2Vq?=
 =?utf-8?B?Z01KZG5LcnRsWlBYYUpKNStWb1BIYmxVdG9hYUtlRjFlTlRpUmJyQUZjNHBi?=
 =?utf-8?B?S0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d269c6-0970-488c-bbc2-08db6197c45b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 05:27:46.7007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s835qhH7Dtx8NWMQlwbX/0zmRVjflIVxNW7nElAIqGelNqVL4SD4lx7AOrAn2SzOQ2IwdjSJZKwRU+lBhf7KTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7416

On 30.05.23 21:04, Dave Rolenc wrote:

Here should be the commit message that explains the reason for this
change. It will go into git, your patch 0/1 just into the mailing list
archive.

> Signed-off-by: Dave Rolenc <dave.rolenc@kratosdefense.com>
> ---
>  kernel/locking/rwsem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index 4cc73e6f8974..cb77bd38cb64 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -1151,7 +1151,7 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
>  			owner_state = rwsem_spin_on_owner(sem);
>  			preempt_enable();
>  
> -			if (owner_state == OWNER_NULL)
> +			if (owner_state == OWNER_NULL && running_oob())
>  				goto trylock_again;
>  		}
>  

Since when does EVL allow to call rwsem_down_write from OOB? Isn't that
the actual issues, but in your application?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

