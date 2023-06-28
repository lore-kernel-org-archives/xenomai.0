Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2049.outbound.protection.outlook.com [40.107.6.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187FC1878
	for <xenomai@lists.linux.dev>; Wed, 28 Jun 2023 04:48:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RKGdmx/ktuhq+ncl9sPaPCB0Fr15eoNGtbua1IyG6NVBLnf8AjP2m9MOIrMhHHREfCB28m8OzA5eCTX1J4brvSszULEtqp6XIiCbT0qHMYykXy+yT58eSqldCiabTfZL3Mo9wyA00s0x4Tmi0J7/HLSoLHBw7Myt+4losx1uxczalRNes1tjOyxZu+6/E05VtTXaqaVGU95VwLsjlXRlh57bGCUsGSAoAgPvEG3YlPpyrYpLw/h4rekwSkZVWMQKGfQB4QXYDE0JBGznYuG2H4wDo9FZtOz1qan2M81iXp8lMjU43NE5iAFBDM/HGdJEL4S/IG9x5vi5ZDmQag95GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5X+orR/pySaONoqt3598Q/oZFw4f6JGI67v4HJQItlg=;
 b=Zl8JA1hnRPT42cL2L1vHI2g05AMWCVHOfua2lkDi6AWa9naVkJxjCpxHAqMTBPeMEUGSyZbDowNefHA3AdBjA0XBFKr7Ka4bYwp0Ap8xDYwyBoiT1RCYCayAzYLO8hvGNg2sMZskdepdegeSYI1gcA7UhKP9tOP+KXEbaPzIazb3eOiLXsRZilEbSslivzFErK86MwSnIwAXFK+epXWGlu9F4IIWjtDK5OMQjwfoWLGL3O0au2M1L4Gf7qeMuB6/Zyfs12EuYt63FBIA/0oyyO0CZHLAEVOlEAnDZVNpExXyrX1wa5+XPdHNGy5Lts2WcFGEXauCx8NdKowTAtJNrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5X+orR/pySaONoqt3598Q/oZFw4f6JGI67v4HJQItlg=;
 b=fCCMkREgOwfJjCE3DHAaZsUq6br8jvVjo4jeC44fXrcpDGXRkZwTuKZMXneqh6VLvA+CfzUTwMzcoU9ynUTvu88vRcdmHvJZRqYeUhAV2sDhtcLy1GQU6MDij4CCq+5nhziKscMd9x7J0I2CYURw5iXtmv+L9MJeM9OOB0V9RDx9wMl/1JT+EwOuQsxucsauLoXc/VQjB45EjtPgmxeDnQlcP/Vzg4/ehYutn0KRolG0M6dolu0497mTCNLcMZ9bo0lUFnzNv8W734X1EhD48NdvYJXF4exPUGwxo6+K98MSliN4UEqk2F3kDYBlUOhaNUa81ZoEEi38zGO17WyH9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB8090.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:391::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 28 Jun
 2023 04:48:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 04:48:38 +0000
Message-ID: <c30ba005-e071-467a-8462-6478010bf4ac@siemens.com>
Date: Wed, 28 Jun 2023 06:48:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Reminder: Xenomai community call on Wednesday, Jun 28, 2023, UTC
 7:00 AM
Content-Language: en-US
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <MN2PR11MB428522CC19E11D6760D4FDCCF224A@MN2PR11MB4285.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <MN2PR11MB428522CC19E11D6760D4FDCCF224A@MN2PR11MB4285.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0188.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB8090:EE_
X-MS-Office365-Filtering-Correlation-Id: 68d070bd-88ad-4a3c-07fa-08db7792f03f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	22jxbL+ouBnxPEzjpz/If2DiBvbZsZurpd4YTtDJZVGtUlDYsZj0WqJHLTWy5BLCrQBX/pBw/KJ6wcZR1/UrKAJbyDl4bu3kHTEMao0CVhY+tE973ArLal3c7sSgOm7Q/wUykP+QyXE/5pnan9l8Y5l1dDouwmHQUtLcaLqoqaNHcXntuWrjulBXN3hTMXjAO2gwMXBRaiT2lqy397YTbd/WypL79tLGhVKCUKHn5+C2StvNthlHWpQHV+YQobTGyvMuiuts/QjdTHFC6sPpyHjTOqMB4cp4XMGtr4cRMhd7yZpVL+cQAcmPkyjjioQmrwD5yzfoffuPvE9uucDwD3H847MNLAPxcxXNCr7vIG4Fz1HqM3ZlcklNVww/QBdhIbpgMTBOAarWEcyvSfUSqxq4eIYNXT5vOZnMGxxuxBKVEJARV8Q9j2NCgbSUvE5SicOeQe23I2nwyp5ivWejfHzlesRcfXfgebAoMCpGNA/S7JnJt86Td+y20rWH3wwlNfEFZXAfYp0TN8I9Cvxfwo+FL51LCa5h3+cFuhaaDsHZINdk+qjRtszbz2Tmtydb0x0QeCrn+wY7dUNPLaump8ujx1dlY1q+eWOm+hBSnIsQtNaw9hMoudY+Tbk0VAUexRZCQIqMeKgu1OmzUEom2g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(366004)(451199021)(31686004)(110136005)(6666004)(478600001)(6486002)(83380400001)(2616005)(82960400001)(31696002)(86362001)(66476007)(6506007)(66556008)(53546011)(4744005)(26005)(186003)(6512007)(2906002)(66946007)(36756003)(8936002)(38100700002)(41300700001)(316002)(44832011)(8676002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFNsaElnYTRaRU5IeVhGMWdlU2p1ZktoejNTd3AyQWRkRUpJa1JHM0J1NmtX?=
 =?utf-8?B?T0V2WWhjQ1UvNS9tSkRQYUt0RGxKMkdwUi9mSEdZNmVZWU9VNUptcDNzVkVO?=
 =?utf-8?B?UGgyM052L2Z6b052RERiTW4zaHVuWU0vVGdCUFNKdmxIVUhNRzRVYmZQNnY3?=
 =?utf-8?B?SHRNczhJYWNFUVZzQWQ4bzVocW55QTM1K2xXcE1NZ045ZjRuY29tb3pNZm9m?=
 =?utf-8?B?Z3Y0NW1ycjFRMStmK3htT0RlOWlMSXJnNStDYWFnYjlsV1kxY0NKWUduSlY0?=
 =?utf-8?B?b015S0lCNFZIdU1EbVJ5cXNnZzVuckZmaWVubk93aTdyS2UvUFNCTW1XbU9F?=
 =?utf-8?B?eCtRd0N3UCtPQzJFUUtvWEhYZnRtTHlRYUhQSTRKeDBlbTczZjFwZkdiRXhD?=
 =?utf-8?B?WkIyN0FISXFYc0lONVJvUXRBS0xjRVdER0JCRStWb1JQTEtETE80Ny9jVXM4?=
 =?utf-8?B?SDdvRHdBWVdESHUzTFNDSndNTW1pSENuRVM3L2ZQQ0NVSWRFVnJUM2JTbXJn?=
 =?utf-8?B?UVpCR3duN29kS01pdDJvRmRJaEFGVmhIcUFxejhMWithTjJkSUZCbU9Mek5C?=
 =?utf-8?B?WlBFaEI4WnByd2N4eUNIaXdJb3czMTA2VWdRQVdadEFoOEI2bW56UVlNK2Jh?=
 =?utf-8?B?VlFsWkpGd3dhb21vSmJKWUJmTjIxWGdlbFVnaFlOeHhDek5HRVJORk5MQVkz?=
 =?utf-8?B?U1FDUmJIdDcyQWhxdWhTbnJQZmNNSFJCRTlaRU5GdjNQQ1lDSm5YM0c0NS8w?=
 =?utf-8?B?VWNqYzJWT1F0VXVvVnpPbnNUdGhPUFhLdlJZUjg2NW1UUmV5aEs0d0IzbGlp?=
 =?utf-8?B?OG5yOXVxemFkT05oK3pSd3k5eXh1WmYyRnlCb0x5TmJqaHQzVUpXd1RObHpQ?=
 =?utf-8?B?U3EwT012OWVNcFBiaWcwQmtsYitpSEdWZVNKNyt2Sjc4T2tqVWtVOUtENkJF?=
 =?utf-8?B?UWQ1NVhPb3hZdDF0RDRUbzEyalAwVzY4OVl1NUIwcXcwMHJTclp1SUNaejlu?=
 =?utf-8?B?cnVTL0ViaGpNaGlNcEFLblBvMVZNTDQwcTgvdGdSaldPK1Q5akxWa3F1NVRj?=
 =?utf-8?B?OXVhamh3bmF3NXltVHo4S0twQU5FOHpHaVZvelRmTlp3RzlFOFl4cCtLY0VZ?=
 =?utf-8?B?b29Gb0FGM3VyVWJvdmRuTzNkOXVGYnp2YUpYeGFmTkNYSmhsQXlJWmxNSG1T?=
 =?utf-8?B?ZTBYYWRhZHY1YVZweXJrS3YvN280N0JOKzJQb2dWeldqTFNFK3UzUHBLaGxK?=
 =?utf-8?B?UVFUdVo4TGFOeFR2eUxxM0syVlZpSFpkTVhXK0dWRGxCV2daUEU4OUpsaEtw?=
 =?utf-8?B?aGxyWVlzb2RWeG9RenU2VWVOc3lnNHRPUWFpME43UXhPdnd2eDdtbjdNTkhJ?=
 =?utf-8?B?d2dpVCtwSU9PdHRuZFJHeEU5QjVsMmxkNklDcWpCTlFES0hqQ2ZPYXkyclM4?=
 =?utf-8?B?RysrZE1YR1lZV2E0dzE3TFo1N3pIQ0lkYWlMbFZOYklZT3VvSDU4T1VhSWJJ?=
 =?utf-8?B?bm5pNmVZM2xjdGhMaG52MUVhWEI5Mlc4KzRUVmtFNzNOMzZNWFlacElUSTNI?=
 =?utf-8?B?S1I3dFRnb0Y0ZjRMTVNJSG1EN1NhenJNRWF3RkNhUUxXVkxQNzdWSUtsMFRN?=
 =?utf-8?B?RnhyWlB6dnZtUkhFNDd0eTAvVGVpSjFWVHJoRk1ZSW1NdWFRK25zN3duVThm?=
 =?utf-8?B?MTJuQXVGbVJOK3djdVNscXdabW93aFdTWTMzclF1azk1ay9lZ0wzN3NQMTVC?=
 =?utf-8?B?MkhmRWdQSnViUzhKZGs0dExoN3ZUTVZGWDBTNXUvTUJoa2RaMGdnNnBya2NI?=
 =?utf-8?B?RmpMaUFwcWZ6WW1LbzVvb0lkK090c2FiOEZCbGxDYTJHNW8za2szeHFjSUw5?=
 =?utf-8?B?VmdpZU03Tll5TEJBeWl3YkgvekRTTzQwcG1HYjNRV0VkZ1pXQWZiSTU5SGs2?=
 =?utf-8?B?cERrcCtKMzlCbk9iRjNTRHpoS0JDL08wNGZoWS9rMUZXclZwNTBoOU1hK2Jk?=
 =?utf-8?B?WkRPU0J1M3Z0d1h0L243NUN4cEZqcUREdGVmbE5qVHJJcjF3c1VOcXh0NXdR?=
 =?utf-8?B?V0o1RXA2clpMVWIzUzNlSmdKRzJ4L3h5OGhtOUFRUjFwRUE0MGxnbVkrVWQ4?=
 =?utf-8?Q?nn5+Hlgx2AuimdoK0Z93ayjUd?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d070bd-88ad-4a3c-07fa-08db7792f03f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 04:48:38.4297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TmmKK0ZU+XCS1KoyAiNc97bbCDfoI0DY/p1aazm+23nSQXibPvxjscY8eXEa+55UIX50guaT733aSFMOIIj0fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8090

Hi all,

On 28.06.23 04:55, Chen, Hongzhan wrote:
> We have the Xenomai community call today.
> 
> Topics may include but are not limited to upstream/downstream project 
> plans, status updates, and technical discussions. It's an open online 
> meeting that anyone can join and ask questions.
> 
> Time:
> Wednesday, Jun 28, 2023, UTC 7:00 AM
> Paris, France CEST 9:00 AM
> China CST 3:00 PM
> 

Sorry, I won't make it today due to on-site meetings at EOSS here in Prague.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

