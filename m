Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2052.outbound.protection.outlook.com [40.107.6.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6118B8F77
	for <xenomai@lists.linux.dev>; Wed,  4 Jan 2023 14:02:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IdXzqw73OUlLbKN1UVYhtuHLaEx+WqevxePXQY/9Co1uED3HptSUt214ElF1rGBF9cXmeWbFpOADcXvHyBDX0Hckk8n5xOq11QjxRURZSL0rsycOLTwONR7CClzJZP76qUN7nMpXyXhFFO4RQDasCEfaXWZgtbPi1h1n/zCRjPezbgR36RMs5wQm18t+mVXe6WTgwpx7Uph/SX70/w3z7fj/i7OpJO6Qp27zF+vHimzk/toFfzqxjRVZ8dKepgmML5gTI6F2Bp6ep9/7NvkgK3oyUYLXkKQ4Rm9rMNtvv4fTMgAhzhR8PZeJXwbZlRmBgqv7i8AROMptCYWPn/zCCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQBxR+kcpedduXzJnziHphYZBRTJP0pjDCEpmeU3t8k=;
 b=n0bsT41YXgEO0X4xlCty0QYIWpWZj7rkfiWeUXBoxEMM7LDXr2KmsjoULVgx9t0DgTuKF/7IgEFRiAWoVbQCIBkPaNQ+Itr9WiGszFj21pYo4B2EvBqF29xJDlfxcf3wPG4FQQuiBUxOalESf248v53AghpvqHvyAsEb4+ZNwUeJwqnJuztA0/Q7FCshjZHS7I6iH3oygGzh2BP3BigSdmb7fzplwX2OcScplhb+SNFDPT+nCgZnL1vmZpjwiLHxrEZ8s+c2FR/zICaZwuA5a2aAS+O7cGI1N+oS6LgCNSCZ3Uw3E42WPcd2uNZWDJwDr7qn99+sL6UOZtpGy7J2uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQBxR+kcpedduXzJnziHphYZBRTJP0pjDCEpmeU3t8k=;
 b=coAd2KKD1Zm+Yy7xCHK6cSmRSWMkdZBx5JOcwGNae74jxhu1Qi5g4CbhWtM7iJ6EoYFcPZV0xYQDD096Kr8ER436gmW2AgRXZxhDF0nnsXQhCbkqr/PMTqlnuAqLZx/ed30BUqZTf7uOZNOCidv3DqIItbvBbeSSbj8Z2a5trT+5UJa/zxpw+mEsJtOSQPWfi2ZTmIhTqXRVffLT7Hi06NrPOJf3ujGblxXSUmPOaRjSj7HBjswAaJtJ7BJZvUDk06pEjIwaEkI+zao92aZg8NcbSFKNJu0Ts2HgFD6a6cb9OlS+l3xFDV1O6jE65Mt7DXM6hlwAcSNkExcwUZHUdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3291.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:11a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 14:02:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 14:02:43 +0000
Message-ID: <e89e15ae-f539-22d7-a845-83e6b3e6ad25@siemens.com>
Date: Wed, 4 Jan 2023 15:02:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [xenomai-images][PATCH 0/2] Fix CI build failure if
 DISTRO_APT_PREMIRRORS is
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230104113715.2872917-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230104113715.2872917-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0007.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::17)
 To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3291:EE_
X-MS-Office365-Filtering-Correlation-Id: 74800367-2169-402c-5c5e-08daee5c59cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1JZrhNXRMLUZFKq5smOYkwZ2e6Gs0KGFbegi/nuP4puaPTglwziPdcAEtflioiLu3wXh7znH7NgLoLSlLUXux1hE16aF6BxvviG0rzpm6Uh+Figlhhkk0rp6QIZORgfMlpupqvl0Q6041XCJftm0jR4ubRVx14kf7rT2j6eVEEtfmKJJTxkBQUReq+u9q/hdX/80Iy2CgDvroCKn7nfLchm1+xBMj21k37ytRvlkiiYbHtL9HkOgrZK9R3NZsP9b/WUoMjIhUNcRdicwrybfYX7F0lpDwac/KsmBSnymZF4WzeG2c7ui5JnlK7qdm2XpCebXs1zJJZltVfM8x2TG3NB0gm8okwDKrZajySRnregHN1x2RamBgG6NE7jTpmTHpPTT6TInb+qqiR1Mw5xCFwdHruk30FoTmYRYwcWGvIDsm7JPkYvZiXnWpJpI7eItdaYPXu1B9HdYr4D+J1lQIAUubQ0yeL8NkxPQg5mEk3MqgLiO3JKnL4kU3RE2tkUp1lH2jJadfdUXZlPW6j+znfJN6WadMm4Is3gpjZFt2GO2A/ecrQ91lWbMTXT2DWSsPyhNWprlSBqTdIQQGcxRvNs/jIdZjfN72XNcW7x2W7uztt7zZOMs+1zMJoDREF3g9+0GBy7ww9EZVQI5eVIhlQYWBO/6U76b5B4Pi/A/H8dL6/r75t6LW9QIsEaTyJ3tqSbGCsm4prlxJbLxkpmV5m4vV++wMmlc1pNFL6netaM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(451199015)(26005)(2616005)(53546011)(186003)(6512007)(83380400001)(6506007)(86362001)(31696002)(36756003)(38100700002)(82960400001)(478600001)(8676002)(41300700001)(31686004)(8936002)(2906002)(5660300002)(4744005)(44832011)(6486002)(66946007)(66476007)(66556008)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWsxT1grTkxaV3F1TUlWdTZucUovcGJjUzFlTXE1d3E4RWlSbGoySkFDYnBJ?=
 =?utf-8?B?M0dzdFVvekVnMmFBTWdUVUxlT1dITWFhc1RyT3pNS1hTakFCUS9uNC95dUNp?=
 =?utf-8?B?MkVqOWhqdStPRVVQc3EzRjMxaFZVOXpPbUNEVEE1VWN3RUNYZW4vTytwcDhr?=
 =?utf-8?B?UnE5NEdmWkVlT202VVBJMUtKWENmcTNvVHplMGNjTzhERVBIZlkxNlhhdndI?=
 =?utf-8?B?bmRDL0ZicFcvcERuMDJwd1hCUGMzZGdRLzlHVk1FSWgwK1FpalRjcEFsNUZk?=
 =?utf-8?B?aHhFciswaFpNd0p3YlozY0V6cmhuR3h2dlBoVElQcWpid2hZYXdPNnlmS1hn?=
 =?utf-8?B?TWJJekZOQXZYZWJIek4wbXRmQm5QMXlQVDF1TnU0cGcvYlRneTdLdlVOMjY0?=
 =?utf-8?B?QzBlWXFHaUZPOFM4ZTYwdk4wNEVVYWlMcDFOeDB0TENoSk1YTGJvOWM2Q0py?=
 =?utf-8?B?ZFdYcEJoOWJCREZNNVNlalhmd0ZrQTVhSkRteWVLdjNVVzRHZ0hvanQySFN5?=
 =?utf-8?B?V3IvV2UzbjNpWG1LVEo0TjdPSHB4TVJVQ1NjWXcxRHNDeTI2RGZDRU9DUk8v?=
 =?utf-8?B?RC9HQ2JGVVdDWHRhMzFuZzBmNHRRQWJQdjJodXBmSXQweXozMWxZaUFTTE5p?=
 =?utf-8?B?N3JXcXdwNTErd3l6aVNzb1NqcDBCbWFlWEVYVkw2WDVlSjdpSy9tV0Q3ZkF5?=
 =?utf-8?B?L2N3S2ptMjYyeHVuZXB5ckJ2STIyR09UOUdiYTU4YTVjSElNanZ2bTdUNVU5?=
 =?utf-8?B?VFU3QU5RM0QwbUhLK25scnBQMWZMNTZpZEViWUtuMnJwQmpyUi9xQ2J4ZHVj?=
 =?utf-8?B?QXk0cytPUklkVzVXZXcwL1FhaGJlMUl3cGFMYlNJcFUxVzhUZ0UrN0w1UXpS?=
 =?utf-8?B?bE1wblE3UjZUNVhvWU1BeGNEUTl2RE5OZVRNZVRBYSsyZFdTbjVzTU5NbStT?=
 =?utf-8?B?dURUWlFxNDRBd1czYS9xV3FkL0RWaGpZL2N3NTVMR1YvRndKcjNCR01YQjZ5?=
 =?utf-8?B?YVFURkxqYmpxY1Ewdko5NHhpUEJRN2IzN0VTT1RjQ1BDNDJkVDJZUmJhMzNi?=
 =?utf-8?B?cHVCVVhZYTN0M2g4K09EM21HRVAzUWxrNGd4eGp4Z3E0amJsTUh1MzdDakNu?=
 =?utf-8?B?M0JNZFpiNzV1ZGd0Ym9Ta0x3MXhENEN6cmFSK2lLck5LclQ1cVgrdzFBcDFo?=
 =?utf-8?B?T0YwNktWQkpyd0Q0WHJXbmFPSzVSSVl5OFJBcFJKa3Q4VDROYnFMU3ZaZDEv?=
 =?utf-8?B?T1FUVU4ya05YS1p4cEprdXdTY1dhdi8ySXRlcTRXZUtiaW03QzB5SFRhVkhj?=
 =?utf-8?B?VEpsRHFCdzdVQiswOXQ5MXNZWHV0VGNzZDgrYWM2MitkbU0wSTMxcElKTGNi?=
 =?utf-8?B?MVU3SnhlT2phYS9vK1lWQm5iSUdJa1ZyZUNRckNPQW12R2hUaWlRLzNJc0J5?=
 =?utf-8?B?WUhNcGszem83a01teDg0OGV2SjJQZ25qU2prU0lQcmkvV0t2eE54cEN0WlFC?=
 =?utf-8?B?MElVQnlXZnNSeDV1cEhvbi90b3Y0Y3FWMEhua3F0UUFQZDhtNmdteVdyL2dp?=
 =?utf-8?B?S1FUR1Zpenc5cjhrYit1YlVSTnplYVdxcHoxWU5GSHVCR2VpMDc3Z2tCYTh1?=
 =?utf-8?B?R2phTnBKRVkzM1Y4NE5YcEVBNWRUN0lrZlNCcFlNY0w4NjVDcDMxY0RjZGZa?=
 =?utf-8?B?T1U1UkZCRnYvUXpSUFZHR1F4YUdxRlBlVlN4dENEa2VXV2FLU29xOTByNW8v?=
 =?utf-8?B?dFFSdnpzN29iQ1RmV0tjaUlKQnRBSDBMbUNDWXQ3TTNlVU1MMVkrSXZuWVpw?=
 =?utf-8?B?NWY0RzVnOVhqMDRHZGlZbmpMdkJveDIyZkttaGdnTEhqS1IveEppNnA1NHRC?=
 =?utf-8?B?aEUzYWt0czJpL0VKQjFQUXdJbEh2SkdFZ1UzaEVxMitSOTIrN3duQUVDeE5h?=
 =?utf-8?B?OFlnT0xWTm1EMXB6dXVUV0FiTnZJNkVRRndwc1R2ZHVDeWx0SlE1ZGU1L1Fy?=
 =?utf-8?B?ZlNVT2hDM3hERFdSdDRKSWR6Qm9FNnU1c3hYU3A4U3lTcm45bjhuWTE5dG5U?=
 =?utf-8?B?WHB1U3hPc3B1bEJQZEdDRG9TTGdVVzlCbUxqSEF6NnpSVW5zS1N3V2ZoNGpD?=
 =?utf-8?B?N0dZVEtIMERFRFZMV3FWOVpSSDlwa2JWMXd1RWg2ZmVreUhoellXYXdnWjlZ?=
 =?utf-8?B?NlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74800367-2169-402c-5c5e-08daee5c59cd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 14:02:43.8628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PY1JscCPtNqNAOnJ1vaukJjXvFdOJ8hmLk70UVB4bwMUTK1PRTw/F4SWN38xo4ti+sALWAfuhbn2Qn1CVjIfCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3291

On 04.01.23 12:37, Florian Bezdeka wrote:
> Hi all,
> 
> this fixes an issue on our internal CI infrastructure where 
> DISTRO_APT_PREMIRRORS was not set. Now both worlds - with and without
> this variable - work.
> 
> Best regards,
> Florian
> 
> Florian Bezdeka (2):
>   ci: Variables block cleanup
>   ci: Update documentation for build environment specific settings
> 
>  ci/gitlab-ci-base.yml | 2 --
>  tests/README.md       | 4 ++++
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 

Thanks for analyzing - both applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

