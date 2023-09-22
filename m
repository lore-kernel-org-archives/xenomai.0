Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2062.outbound.protection.outlook.com [40.107.6.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F0D2E65E
	for <xenomai@lists.linux.dev>; Fri, 22 Sep 2023 15:49:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jwku1EZBKhGWceCu/qeW6Jy6fgaGAbbnKdPpjwN7TjPcr2JIf7p8r9NxeI9cABtMfvTC7ccqrwcqLa1Tti9BRNxxd+wyYAmXLkoB3n5kuFm5FtyXWbJ10p47EtA2ezUpoFB7K9Z4qVc3WgL3k5eeVx7VRPgqZGhPflkSgw0fHD3Q8RaxQjiU4xH9E/VqRFNQDfuSKwaGkO11rSpXt7Jrgk2LVKSxOTgVT1cAGo0PGgwx2SnmQMqcTi0z4+3dtkYaQQ/s+j87LrrvyAuy2XoL8mIQCR4+EqTldEDEuCVXKjpNsqClNI+tnG6YsASlxGkjX0J6pdEJPaZEdMMfrvtXzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPOFbNw3MV7QyT3187c1KQpAS20BKpV41kmRjXCvUZk=;
 b=QVDDxoSim8X7at7uCIvP7A0l5fdFB5rmFVl11kfCCNEqnvC5t1/9u8jxTXFS6iZQkw9edwSqSkJI581r75Oga6au9pgzNManSV0xxWlNBop9CdWYnEqHdd5GNb9zPFKQyp2dYhlILiWukjd3E9nBFYUORbKeUh8g1blV5lktxZwW9unOTSbIDxt6pVSAPK0vdP72xFyvdMpTy5F3CLy7p7ywmuosOEa8pa2BCib9WoWfIVkhu6DybNHsoJFx7Hgbi9XXhTNYv6d0Ba3PMIdiw/fRJWDghAtrvYUF4muLaUi/7EfXRCj23bODrTe96YDyrlI3EDurxdejYrNgsRDKhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPOFbNw3MV7QyT3187c1KQpAS20BKpV41kmRjXCvUZk=;
 b=qSKEmJv/enrHEmihk+bCFwEFJCpZ+En2UixJwEEeZtVoybq5kxGzK2DlBW01vdtmvpqxnWC1zjYx8ITaBvYmyI7ooUVIi/2tcqkk0gHMMA+0p/X8PEzeIaZ/2DS8sEfjgwYT/vIzrZKuyZF/DJ+KR/N6GdPz01JrCoMX49QAihTBabJ79yw+gow2N791yBG/JfS7BTNVBJt2/e6ZMEHiBWypCZryaFTS3r4n2I4vsofjf7QlNk+WcxWDnJpya/fK3+E5tV/mXQ2i/b7ghHsg5N2iIPV8nHTq8eb8nq+c/PDQ4zsNHEuRzs6h/tQBs2PRqW40WaRixdthfdMEVc2Hxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7873.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:63e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 22 Sep
 2023 15:49:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 15:49:17 +0000
Message-ID: <23cc119f-7301-49d8-9a95-03ff9e061ab1@siemens.com>
Date: Fri, 22 Sep 2023 17:49:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] lib: Add smokey_run_extprog as helper for testsuite
Content-Language: en-US
To: Aaron Marcher <aaron@sigma-star.at>, xenomai@lists.linux.dev
Cc: richard@nod.at
References: <901c80cc-d506-445e-add9-00aa0e536803@siemens.com>
 <20230920135253.5842-1-aaron@sigma-star.at>
 <20230920135253.5842-2-aaron@sigma-star.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230920135253.5842-2-aaron@sigma-star.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0063.namprd05.prod.outlook.com
 (2603:10b6:610:38::40) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7873:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e36ca0f-0043-4546-95ec-08dbbb837a41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZcjkhytQor8Xw3KPGaPyITPIov/DSDEAbpNU96vXIyl3pbKk/GLOA5vNjaqAqcBnoZL3+wPH/riLBvMVV2DyWfFDqlL5h+V2+Ta0j4esYGassYMOBz+sHXhswN5wPZrdOlUO4ukzXG2vhrk+Ju6ebB9xp/FiDBNAm3NSX5bk3NFQVSwwfiWYKs+nOqvV8voaZ7Wf2U7IN5IuTCIOdK3FqvyHbJ/HDKCFcfl3pxfYHjShz5UujHqNcP0S8t3S2ulFHyxhth99TZVTm6jZP4AamRMkbJvblb702jD0IewdyVLvBM8juxtP5BOe+7nYCEjxINu9ifezSHbFSrjAG+VubgSYs7ZcTIf5Tujn7+kOAEYiGGLN8myNXryvkXsvuepXcYH26gBxFwwBoweNosyZf0hP1B7rDM0nsLNTlXvmVA0T/n8tXyfv3Lm4u3zMjeqS8AlE8Z4WispspxA7rFQkIPtJw0rTkOCq6KONvIPoMSTSvNFOZO38CDE1mZ3wxwqZSodB2t/bYTxAT+UyZbefGSgz40BTDmZOYp6kIgO9d4v4GSGeUAcwAtFZIcHCXtdeXQ0rqu7vgFqvhXOxGp16Q9DixbT/5ZOVQk600UF8TFFDQbQCgT4R3pkhY8Dc05TnDHEQL+AMuYEw6e/187EuEQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(1800799009)(186009)(451199024)(2906002)(478600001)(6506007)(26005)(6512007)(6486002)(36756003)(82960400001)(38100700002)(86362001)(53546011)(2616005)(31696002)(5660300002)(316002)(66476007)(66946007)(66556008)(31686004)(4326008)(8676002)(44832011)(8936002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUZuVTJwZTkvcW5MUStLZ0QzYU5Gdi85d2l1UDhqb29Jc1l5eXgvRWVpWjEv?=
 =?utf-8?B?N2hScm94Y2xFZzd0TElWTno2S0l6Qy94RjlQNkxTeEU0L3g5QzZ0b3U3Ny9k?=
 =?utf-8?B?bUlHYUlNQkFLNUJBVFl5NWI0THhUNFY2bUxhRCtHZm16RXlmTEVKL1FqUngy?=
 =?utf-8?B?czV2Y09UM2gwL0dlUEZHZllSN1RMTHRJN0QwRnVNZW5LTWpmdFZrc2JFbVFl?=
 =?utf-8?B?UzNROFNIWFk3UzhhNG1FOVl6eGxJTTB3bG55WUg0SkVSdytQakt0c2pTaE9C?=
 =?utf-8?B?ODFadmxCUlhnMHdXei9DY1ptc3NwYXQrWkxFTnhtM214bVQ4dzVOTHhOUnBl?=
 =?utf-8?B?NTBIaUhOSlF0QitFL2lxaUR2eVhIRW40UkRKYWlpMUpuRFpsVnRNblJlRThw?=
 =?utf-8?B?cFdVNHpYUjlaalcyZTAvcDlIajZpZkV2VHVKYm5RaEpoZG1HOUpnU2lCa2Zl?=
 =?utf-8?B?TUhMU1BIWllCYWd4bGhRanptZjdGcTZwcGhVNktGVFNlbHU3UDR1YkdDby9m?=
 =?utf-8?B?OXdmbTVVQ3VlQ2xyV085Ymttek04ak90b0tEOUpCaVVDQzlCbGZEYUkzWkQv?=
 =?utf-8?B?NGJ0ZEZyZjBFRGExVkk4ZHl2eWs0VEdBL08zOFBSQy9GTFZOTlRCbDJobFFj?=
 =?utf-8?B?Q0pVVUhmMW5IcnZ6SzBxeVJoR2tSb0FmM080VWxaVTdwMldYTXRNbE5ibjRC?=
 =?utf-8?B?cTFBNW9NUXorMFhCem9EaTJYUGYyNkdKUkRKSmhBZmpJNFgzVndURk14clMr?=
 =?utf-8?B?SEQrOGN0TURJbjNJcHFIQ3diaVFqN2E4NGxBTDUvTXQvT2RpeDlvVTlMY29C?=
 =?utf-8?B?SS9kdkZlcmdwUlRXOFpwMVoxT1o3WktEOUUwenE1U1BGNm9XZEdSMkp6N3NQ?=
 =?utf-8?B?bW42ZU4zelR5cGlHRmJQNERBeXVWa0lwb0FncXZ5b1QrcmZMYmF3aS9PL25U?=
 =?utf-8?B?dVZmSytBRHBKM0tFMjRhN2dEQTBsN3RFcVhUZldjVkRMaXZOTXh2a005eno0?=
 =?utf-8?B?NEUzZU9wbW9sV3I1MHpGN2VSTHEzTENBTW1ZNjVkSE5JVHZFMHM4b05uNTds?=
 =?utf-8?B?N3dJeEtLU1krYk1lRWJEN2lEdjZSaE0xS25sendMY3RXODdZazJYOHMxT0pR?=
 =?utf-8?B?VTNNd29TWk4xVVovODZJSVdyN2N5UzNZV2M5ckw2bTJoaU1yM3F1RzlEaVZ1?=
 =?utf-8?B?MkJuM1NNaFA2OW5BU2s1RTVWYjNDQlp3ckpqb0ZsR3doRldndWxEeVFQOTM4?=
 =?utf-8?B?TEMzWkFzdS9YTXZvdmtoTDd6MUZpbER6RXVVSVhXN2dNSG1tbm5lRWhDbys4?=
 =?utf-8?B?TFA5Zm11eFp5cnoxcTQvL3UvODk1QXdUT0FQbmdNdytITG1nWTZKQko4KzlV?=
 =?utf-8?B?anVqMUMxMFUzckxFQit0MFZkMmgwdVQvTCtiZXVsVmgwS21ibGZTWUUrNTg0?=
 =?utf-8?B?eUNrTTh4dFVXV0NycUU3Q1NBZ1VydnUxUDNsMU9paWRBSzJYZXQ5aksrZHNz?=
 =?utf-8?B?a2JvaEQ5ODFjcXFzVXJJeXFMSmJKYmJLZEJJaDdxakxCc3VDdkxBMDQwblM2?=
 =?utf-8?B?OVpGM1ZCQnlBV1VQU2FSdUtxQ1hlUlZjN3BYS09PNXlUZWhydW9HMEtwSldx?=
 =?utf-8?B?L0RuRzVjMzY2cHo5SEl4cWtCdTYxb1hBYUNXSG9Ed2NjNWk2RlMybEJTeWhs?=
 =?utf-8?B?QUJKMkIrL2cwckJqdENhYmlTSjRQeHd6Z004endwZ00vSnlsWHRGeWtLeUkv?=
 =?utf-8?B?YW43MVFPenBNTDA4aWVVTC9lN1JVRWc2YU9vL2s5ck5QRTZsbUx1QUo0UWVC?=
 =?utf-8?B?TDhGcGNwL1M5Z1YrdzZzYy9lMFVESXhNeEZtTkhEcXl1TWRLRW5nZWdrOFM4?=
 =?utf-8?B?S1RnN3B5bVAxbFpxNzJ1d2t2ODRuSXB6M0pSL2twYWdKeFI5ZERWY054T3Rp?=
 =?utf-8?B?dkhiWFlXNGhkbE8xd3FSSEZsZ0xkOFhMUVF6c0VMTXZCdWZKZk54Sit6emJW?=
 =?utf-8?B?VXZISFpjUTlJOXd6WXdDNkVLWDNVaThoUGNzVkVVVncvYStUaExMZjQzS01o?=
 =?utf-8?B?ZGVxUEVlV1kzOTh0M2gvMzhvNm5ybWVjcmNzb3R3VENLZ0FuOEg3ZWc0dFZL?=
 =?utf-8?B?bnIrakx6N0pVMk1TSFcyZlFuVmNCcEdBcVpFZjNNbFBqVmJ6VE1OK0FMUDh1?=
 =?utf-8?B?R0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e36ca0f-0043-4546-95ec-08dbbb837a41
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 15:49:17.1142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GTqH0uox831Y3IUsDA3LFKndI65V5bkuvTrD0Ttr82qEG+V/YOfJKuW0q8loQwxV1nhz8rWbefhbkCoYRBZcTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7873

On 20.09.23 15:52, Aaron Marcher wrote:
> Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
> ---
>  include/smokey/smokey.h |  2 ++
>  lib/smokey/helpers.c    | 15 +++++++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/include/smokey/smokey.h b/include/smokey/smokey.h
> index 0ac1e8df4..4d0fe011f 100644
> --- a/include/smokey/smokey.h
> +++ b/include/smokey/smokey.h
> @@ -259,6 +259,8 @@ int smokey_modprobe(const char *name, bool silent);
>  
>  int smokey_rmmod(const char *name);
>  
> +int smokey_run_extprog(const char *dir, const char *name, int argc, char *const argv[]);
> +
>  #ifdef __cplusplus
>  }
>  #endif
> diff --git a/lib/smokey/helpers.c b/lib/smokey/helpers.c
> index 0fc450ff6..dfd63b409 100644
> --- a/lib/smokey/helpers.c
> +++ b/lib/smokey/helpers.c
> @@ -410,3 +410,18 @@ int smokey_rmmod(const char *name)
>  
>  	return err;
>  }
> +
> +int smokey_run_extprog(const char *dir, const char *name, int argc, char *const argv[])
> +{
> +	int ret;
> +	char *tst_path;
> +
> +	ret = asprintf(&tst_path, "%s/%s --cpu-affinity=0", dir, name);

Why do we need to hard-code an affinity here?

Jan

> +	if (ret == -1)
> +		return -ENOMEM;
> +
> +	ret = system(tst_path);
> +	free(tst_path);
> +
> +	return ret;
> +}

-- 
Siemens AG, Technology
Linux Expert Center

