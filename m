Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2067.outbound.protection.outlook.com [40.107.6.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F8846AC
	for <xenomai@lists.linux.dev>; Wed,  3 May 2023 12:47:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6/ruNPhg2uOZpFy263/f9fe6AK6mqWA8AwRGrgbzjnnbyzK4C88kZMdaTcyOhhUJGkXcqK4coafSUaL7TItH3I1u7iy9u7KxP0x3hziyr3ovnazUp9Vmlre6DePe/CfH+efp6qBpd7wXo2dxTOToqVtytymHKA4uTt8WGkIZXYAeDLmfhC9lr1BISl1z8+kL/nIZPYsgnGcwPIns4Wrp2xiboT45uPT0ZR3qBVETXsMdZ4bBSqiN3IeZ4KRqvzkiInGN3bTQ8rIlxlP0Q9AMfuluApQUSwAYHEYKK0N+i750+XvE7uhk6TbJhcLgvey2MA+ROCu82pjAKK0tudyrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CypSVW1fdT+jG/Cr8qfVfcN3/ZBpl95S0UnzurmRDWA=;
 b=AUTbbQE1SU27+cLB4CHv+McGibRAXDTuMS12rESxJTocyQ2AlY42s71PH8ETV36GcNnJLzl3cH2qsgTha77gsHquTU5oovrHt4GWAMRi1K2hfeDfLlrAimoPvOHXTQt4bhYIERj0YwKfq+KZDsUE8pMmhNdJlf23Fd20UPOqIdiAaipObgGiuKcBuNYNZ9MP/EacRPoQG82P87ZV/c8waSAcz0bBX1/Aqmqr3Ae7GyRNHp3jTMTf6igkxhBQW9OL6Uu6gorpPz9FDOvQCGXH15NnvrgijjInRSY7kXBZYqwMbtEp+vWleyC6f5/KUfxSoND3dgGp816rXAUC88/JKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CypSVW1fdT+jG/Cr8qfVfcN3/ZBpl95S0UnzurmRDWA=;
 b=UrLu4xlp7MsFYD7zVzEvyNetTNXndFa1fKmDLM1Fevsu5glfI9PoSzN/r19WgHb22rfaT3YtoYyN/s0k4El5Lo+Kbmqjt+pFLVE6EbdWGbhnk7bdlFyiMilc8i2qYSO5cKenMrsvfnkd7kkczixIcrRZairh/eTzo7Z7KnXnCIuDakH93f7bgCo8JtAWuysv/UtZZqYcMjzPZplI2g6iL2LL5xj4qe6uqU9LD70By3PGD4gfe4ajmWszzYz+Tt6t1lKfhccb/0Olk0Q9S3AiZb3SbuqBpW6zR25Aj0t1tvE1Zid6eTs+qjwbop1m8o5WDY6CSqXgCuJYoOZIb9KXjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:142::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Wed, 3 May
 2023 12:47:07 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%4]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 12:47:07 +0000
Message-ID: <87725da2-1d9b-83e3-9822-da38db11f7ac@siemens.com>
Date: Wed, 3 May 2023 14:47:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH xenomai-images 3/4] customizations: Mask
 systemd-network-generator service
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230503-flo-debian-bookworm-update-v1-0-6a4aa9e4d95f@siemens.com>
 <20230503-flo-debian-bookworm-update-v1-3-6a4aa9e4d95f@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230503-flo-debian-bookworm-update-v1-3-6a4aa9e4d95f@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P190CA0015.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3712:EE_
X-MS-Office365-Filtering-Correlation-Id: 8da47d92-4fac-48d8-1cc4-08db4bd480f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bNHBd1RvY21kj0TieKEV7VA2+LZnhVJ9BzGj/JyJyK1GZAkNxKoo00vdlGhTHXGXmVHUjcXz8X2gY1ir2EL5GX5A1s39E2BaqHmOGhsCULAfNdRlXhWHUFe7lL6yOSbi8euk9D4mh/kbEu6K8giQDBpw81MYONcx1Da9+pL5aTt2s2NjG+2hUILKk+yGpMZ021zR34mRZtDIeawklBNXyZawESGye1ZdsLkOHpmBa0TtmklBhROj+DjitvIZDSObG+Co/dI+0Lr4FcNkp1MOLZCIFISuijYKMHgjXWAH/3HDt2jA5osbj4dFiWddgfcsKEgGNuEq/U6Q1uqs1QPf3bLxclpiSfam0UkhB3g2Ib7v+cNnmRyQpTbTELNXO9b9g8JdFqHBZOPTUFeWljnqTKt7geGMhcs9WsPMejiECEvS6wVjbAXxNRyHNRkEo2PDgnOo/MmIn4j9O1qlF4xcLXm7QBVr/AU5lh7T7JGgJAi1PYYdiR+tOVmKx6Y/Dm6DsJwzMT5PwG5rxC1avnglfQngksWII0v5gXM6i9sM+o5KmZu+LKAG1fYoweFzjtb3mJjf2pwoeFKzKJRkPY4bjOEUQV+4PNFK23g8eFMgJr5bqhlq880e64Xl5iUk2+/1cEyDZvRnzAPcO71dFNCnew==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199021)(31686004)(478600001)(36756003)(316002)(5660300002)(38100700002)(2906002)(31696002)(8936002)(86362001)(66556008)(66476007)(8676002)(66946007)(44832011)(41300700001)(83380400001)(6512007)(6506007)(26005)(82960400001)(53546011)(6486002)(2616005)(186003)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MW9NNjdvdWhrUENsN0VPY1J3MDdyaVVmNGVlQTErWS9vMEJSN1lNcndSbktt?=
 =?utf-8?B?cVo2bHpHSUNQYVZEUWowYTlRSDdCUXZVd3FIU25FTU1tek9pRkNLRVBLZjY1?=
 =?utf-8?B?MXFyMkZtVzF2aFdYYU0wZkVBS2xSbytRU2xHSTM2UjZzMGJra0NzN0ZzREJ0?=
 =?utf-8?B?aDJXaWp2WlQxVVp2anFmc1piZ3BQTFd4aUxNMEtVNmIrZFVicnFPYnhZM3Rr?=
 =?utf-8?B?emErODhkYWdTblNXNmltUldJZE53R01iNVk1TiszcmpyaVVKRS9oclpOOThF?=
 =?utf-8?B?UG5uSUQ4WDJyRVdWSElBM0N4ckVEcExJMHdFY2ZLMHMzWnhwRTdHU09QUnQw?=
 =?utf-8?B?Z3dPb3ZYUERueXVXc3BxMGcraGozVFlpNWNDSG1HeXhYRDQ2M2ZvdVZtZFF2?=
 =?utf-8?B?d25LWmpDNVJ3aHh1ZTZqMU5RMGs5Rmh4RE9Fc2QwNFQwckZvTzg1RDJETnlr?=
 =?utf-8?B?WWtMcnQ4VjIzZGV0d1NFL3BkTGMxMzI1RWx3REpzWTdqUittUURDTTF2ajV0?=
 =?utf-8?B?VHIwOUhZcytwQlhoMTBDeDJuai9iU1BMYTFJam41RUFwLzBpcC9QRk5UdmlF?=
 =?utf-8?B?dittY1BudWYzVkFCa292UnJxYklHUkFCbVVUY1VVSDNSOGw2cjhaNnZkMUxQ?=
 =?utf-8?B?cW9RU2tRbzFJek5ERzBDVkZEVmZvbVV4ZmpIdW00SU9iV1RrQlZ5WjU4alkw?=
 =?utf-8?B?d1F3VTNtdmNwMnJyYkREczNvMmY5b2RNU0Q5NTBGVkRJcC9HM2xQeHJQOEZi?=
 =?utf-8?B?MGZpc29GQVhnS3NlU0ZLMHhjV1dXTy9qK0tyanQ1ekdHRGFlOHc1Y2tEYXly?=
 =?utf-8?B?SCt1TUtNUkJzdG11djUwcnVrVk9kNkRGY0hzaFFtVDZpTVdsYTFKL090OUlw?=
 =?utf-8?B?aFdkT0lSVk16aDRPRlowVnk2Zjg0REsvakMyQjdsZ1dFZjc5NVlPMmZKNVFB?=
 =?utf-8?B?RFpxakU3OGFjT0tlTldYTnlxVm0yamEvOWxMWTNUa2NvdGppd2lFSi8ra2ln?=
 =?utf-8?B?Z0ZLVXk2cFlDQnByaGwrWUpxejJkeTV0ek1mOUtQL2F3MzVjQ0h6SjNtRWZX?=
 =?utf-8?B?aDM5L3M1Q2E5ZUwrZzdMeENvdW5ZS1AxaGdRQUtjeFU0QlNrdUk3N2dJaWV1?=
 =?utf-8?B?VXZSa25IZEl5MkNEYnQ1TmZhOW92WVp1eE9GaUdwVWRGelVQS21XK25qcUc5?=
 =?utf-8?B?ZWROc0ZtdjdSdWpQNURrMmszT1ozSkp5aEVDU0dpSXk3bk5HeEd4UThHekVM?=
 =?utf-8?B?YysrOWRvT3ZQL1NjWmZCNlc1SjNiV2ZobTVFOTg3N0U4eGJhZitUYXlPdnla?=
 =?utf-8?B?a3BweUF1dWlPRzRpdlFqaDZuWkNpQWpra3JmR3czUlQ5TjJzaTAyMlZRWC9I?=
 =?utf-8?B?MTlMOW9SdktkeTZQa29zR25OWDFWOHQ4SGQ5d24wTlJyNnVJdlFlcWl5Qmc0?=
 =?utf-8?B?REwvcitQTHlIT0NwV0hqQUlrV2hRcjZGWkJZWUFmRktkUXNsZWl0M05OUUVW?=
 =?utf-8?B?NG44SzBSeUZKWjAzVUZ4Wks4b3NYeUtWakx1RnhndkdxTkxiSkR6cGlxcCt3?=
 =?utf-8?B?U1M5cnRuVUpkMXlyeTYwZS9FbU1BaisrUzRzZ2c1OXVMWlNmSVdnM2tHWE5n?=
 =?utf-8?B?Y2hzWTVtRUlDYVlPTGt2YThNNkhzRmVMbC81RXFvLzNYY0ZMS09EWitLN3Vt?=
 =?utf-8?B?VG1INDlyMUE3cVF0cmw0STAvbHRCQlRiSXhpWG4vaXRaQ1IyUUhlTy81ODNF?=
 =?utf-8?B?eTlLT3RuYnk1b1lHc2U5elZuVElGdjc3Ym1kR2daUG1rNjNQcXVReXVsSU5R?=
 =?utf-8?B?TUJrMVprNkxmYzdVZlNXSVhSZFpaTjF1dURVVzhxRWUxTnlmUDRCcDZybGFW?=
 =?utf-8?B?YlluM2JsTmFpeFd3bjVhVVZjMXFkQkhaaDFZVG5MVGpYaFB1YTFucCsrcE90?=
 =?utf-8?B?Qlc2MWVqTEJUcE5EYkVKRDgrclRmVlAxM2IxL1NCeE9IVk15ZEUzSlpiM1Ny?=
 =?utf-8?B?NzV3QTEzVUFIdjlHc3l2cHpKNmF6NHVsQWVSdjRuTURmYWo5dUxFclJQZjQ4?=
 =?utf-8?B?OEJ2b01BQXVldThoS01odTlwcFAyeDVRZlgvWGgvS1ZrN2MwbXQ1SzNjc2Ex?=
 =?utf-8?Q?9bbRyJl1Cg1RBiYzD+YNPja+Y?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8da47d92-4fac-48d8-1cc4-08db4bd480f1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 12:47:07.2718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3HdDm1kFoHW3ec0pDHmrHs0EjJC3zJce1i7OxCMYW+MlUdGXh4ea4QkYWXQ774zCPqjvTacxfR+Y589kiTvJew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3712

On 03.05.23 14:10, Florian Bezdeka wrote:
> We use ip=dhcp as kernel cmdline option for most of our CI targets.
> This cmdline option is now taken into account by newer systemd versions
> and a network configuration generation in userspace is triggered.
> 
> WLAN interfaces are part of the generated network configuration and
> might trigger a complete system hang. Especially the HiKey board in
> combination with 4.19 (ipipe) is affected.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  recipes-core/customizations/files/postinst | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/recipes-core/customizations/files/postinst b/recipes-core/customizations/files/postinst
> index 691988f..d8d141c 100644
> --- a/recipes-core/customizations/files/postinst
> +++ b/recipes-core/customizations/files/postinst
> @@ -15,3 +15,5 @@ echo "Xenomai Demo Image (login: root/root)" > /etc/issue
>  echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
>  
>  echo "demo" > /etc/hostname
> +
> +/usr/bin/systemctl mask systemd-network-generator
> 

Shouldn't this be patch 2 then, to avoid a regression moving to bullseye?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

