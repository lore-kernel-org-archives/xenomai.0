Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012064.outbound.protection.outlook.com [52.101.71.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D3C79CF
	for <xenomai@lists.linux.dev>; Fri, 28 Mar 2025 06:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743141987; cv=fail; b=MsqnNWsDMDS9XLHZ8nqNCEvAIIKLSFp4PGlGRlxZcUcBTxJDLID4+iovo5kutExlpjlStNWXtWXMOcjtZKooXR73809GVDxeUgSjGm6dOt1m4pEVr2im8SIclOzrAhqdhhSKt7tOODRYrCDjbvqHrcdWhAMfbIEsO3n1OJyqcgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743141987; c=relaxed/simple;
	bh=ORqyY/XOVP/6D2hS3O5cebwZxWMSlrWJc2VIlBrFuOk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HCNvmUI5yL8JaB5IlgvwU2ugzZgrzcVzaBQNTRYhfBnKgCMEJ8ZVH3HGPybJs5hNnV/HJSOjZJnGeNvegOYTymDIMplHzeBdmKck6VZQrUKg7ciov0/KXEswRiRG8rcf8uz0IAzq9W7tTHy239H/NdN5Gg/zczGt1HQoTf0XrMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=U3ui1Ud1; arc=fail smtp.client-ip=52.101.71.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="U3ui1Ud1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WQyLj0Lso2WtmFOePIxuU91nZpBJJyRuoGAEVfPnpO7DbxXNC3pnkcSUUbneBT0y2alGVfH09slFy+MZdNIm2UoGNBZeRTPopaCeKW4mZ4RvQ2wVCGKcXOGzyPAJ8IIy84gXNr+MmUfLPLLIbVm/xUcmna73c7i9MfYXaizfCvF2D8rHloymq9Lp3R3VZlEAtm+NxXOKmBerPretZm+Rg/gvWdx1Td5LV4oAI9M9hIQ2Q9fHJwMVbMsMbmG4jMhqAooeBQZEOmz32Iq1jIrbQglgckfHOKhY2rzQDtRDNJy5KZtsGGlRYHYLFvhZbog+/bUmBQ7nVa8Z0iLzq85s2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JE3sNriPq9GKUhVu6EumhtLPr/p4C0xAal7lshu/alE=;
 b=RWviw1IuiaAxK127qiHwRO//egq/9tJ74tzAKO1h/3MV22jz0A87xdOP7Wt4lBfnJp/lhIV1tejEpwVnjrmILL0m6/wSWUH7ThdPzh2vSpX9Rxd58OWN12xo94nmonDEVy1bPLYEX/+IKxYpx3YL5GeYvEpVPweOlTi1LxstlcRF8Rg+TO3PNnSe682t4jEO7WbUtaoEoBMkEhubBlp8yfg3pwRV7MM7fOJCBbImKpa8bztBm1nAI1riHwD1eGGTxXrDY38xsdFmSudocOYQwD/Ho5DQiXdhzZUJ3rEmP0spRWOiDpCSYVyr3A5srwTtUxOtcvet3xIspxUaOOnyRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JE3sNriPq9GKUhVu6EumhtLPr/p4C0xAal7lshu/alE=;
 b=U3ui1Ud1qHrKdUpx9CUC2MH3kwmov1rFzS3ULM2BI+E3gFOqZyayJ6WL36XB+J4g4/dJVVv8RHgwGReYmHCj6FgZgkpw+ohQ1QPDKb1rUo5c1fJXg7JhYz5luAzcuaLAwNq6vwA+vW9c+Ys7b8I9C8ecR1nuMH+Nc0YOkkurJ9YxkI6acvGqbvIxfkDUKW8On9+ofnGPdA7kjxyBj4nYRln3/ZtRwNr9rn1MzJNUrY4tGcrOOXxnh1nLGQnIaaeZrcJeK8DHBq3SBpV5l2qBbbpPWhsLYNZ7hYIXaQE34xEpLvMTpd7YY2rz8Tq8onE+l0UKwQaLeXSvP47GHlRP1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 06:06:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8583.027; Fri, 28 Mar 2025
 06:06:22 +0000
Message-ID: <e5426038-8819-48db-959b-e7982d2ba667@siemens.com>
Date: Fri, 28 Mar 2025 07:06:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Xenomai 3 and Linux Dovetail Compatibility Table
To: Pierre FICHEUX <pierre.ficheux@smile.fr>
Cc: Yann Le Chevoir <yann.lechevoir@cae.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <DB9PR09MB60325FCC7AEFE1880D9698EF81A62@DB9PR09MB6032.eurprd09.prod.outlook.com>
 <DB9PR09MB6032B14E3FA653EB1FD4BDEC81A62@DB9PR09MB6032.eurprd09.prod.outlook.com>
 <582f231a-3e17-4b4a-804e-7f43ebda3c48@siemens.com>
 <CAFc1U0t8cWGpCc-ntsxCm-+obz7fu3w8jMrV1w=XtRyRCMDKqQ@mail.gmail.com>
 <CAFc1U0vf9y98v_iaWdBz1YcdRfJ+6pd_t1Hv+9F3zfmNu3+C1Q@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFc1U0vf9y98v_iaWdBz1YcdRfJ+6pd_t1Hv+9F3zfmNu3+C1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0047.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS5PR10MB8243:EE_
X-MS-Office365-Filtering-Correlation-Id: efe52a73-1149-43a0-d340-08dd6dbeaa0c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aUJvcjB3bW5RTldmNS8xZ3FiejVnUlJSSklIakhjS3JXa2tMUWozUGpxMjEw?=
 =?utf-8?B?TldsUE1pRE96aVhiMFZKWHJvK21yaHhmSE5qZjRjb1lYb0xFbjNteUUraU9o?=
 =?utf-8?B?NHZUczFWcG9pUEtXU2t2Q3BJV3J1T3ROWHlCYURXSXgyaGpXWXhyemF3R2Vh?=
 =?utf-8?B?UWRVUUVrOFR0T3FlRTQwaTBlQ3k4OUdwQUdWWFI2bXU1bUI2Q2lIak9WUzZW?=
 =?utf-8?B?ejBNZWpqaGxodnYyNUhCak1Tb0h2WjlaNTJNZktjbVN1MzBWSmJ4RDBJYTc0?=
 =?utf-8?B?QWxkdTdMU1FaaUJva3lEZXlFWmRlL3BZS2VmYzRsM1o5cUpNN21nSGg4anlw?=
 =?utf-8?B?NUNPRy9YY1ZVQWtJSHJZdGlrQmQ1UHgwWjBXZW56cDU1RDVWNC96OHZ3aHVG?=
 =?utf-8?B?U2Z1OHFZRDZBd2hjMGtzbkk2VFdTNjQrVVhqeUFlVE5zU1BiZVhlQzNMWW43?=
 =?utf-8?B?dU5TL1poL0Q4Yzdobjk0Ymladnp2c3NuR1RwcGtHUHAxQ3V6M1cxMHZYcEly?=
 =?utf-8?B?RVBTSjF3eEk2dGhrRWxlOGtRbDN6OHBxK0lFb3V0VGg5QXVtUTFOWUJZT1BW?=
 =?utf-8?B?eWdoeHJEUHFqZHA4VFhyeEhyZ244YUc1aCtzSWtNbmpKK2dYTEl1NmRiYVJ2?=
 =?utf-8?B?Qjl1WHZBeU43TUpkUTRwSkNBQjQxU0g1NFV5dHNUZTlhVTB3elord3gvMmIz?=
 =?utf-8?B?dmtiZVBHTGt5MjBqc1QwMnI2amtYemhKVWZENkkyaXlHMFgzVmRQVkNoeXkv?=
 =?utf-8?B?TFpvQy8rd0UzekllalNMZjE0a1hOR3k4dERUNFhwbW9jR0IvaG95NDJFUW9T?=
 =?utf-8?B?VGQ5QzRoU0JuUUNtZ08xSys5MmRBUVpTY3hnaDdJYzY4NEE3ZERreEtLYzBl?=
 =?utf-8?B?bEJxYVcxTUlJNHJEUjJoOW9nK0o1TmZyeWxqWkVJSGt1d05EYjlwR3ZNdUFO?=
 =?utf-8?B?VHlkcm9iWmhPRHJVeVg4aStBN2FaR05kL0l0ZktMb1B6YTJ0YzhwNWdSUHUz?=
 =?utf-8?B?RXJNTTVzS3gwOVlqZ2QwL0Z2cC9HN1NVK2pDbGlWYlNOQ0tBZCtmNFBPclk5?=
 =?utf-8?B?Y3ZRVzA4WkRLNVJwOTREOENTRnFjN3VFeUFnNkZvNE1SS2R2Mk1KS2d1NHRp?=
 =?utf-8?B?dFdLK1U5dVpGbW9RR0dMbjZvY2JMQVVlU0VyWnZ4T0NaKytZY2ttektXVjRt?=
 =?utf-8?B?TldKSlVVa1lzNUtVL2VWR2c4V1g1NWRqTENTMkZNL3J0TzVkbkdYOHFacFBB?=
 =?utf-8?B?eW4rcGpGRHVrUm1WRHBVZXZNVXZNTzd3UndWMmZtSm9rZDQ4dmFFRkgyUkxF?=
 =?utf-8?B?aUJUTE1FaE52OEc0d1I4MUVxZEpZZXVUVm9GVjgvYmJwbTgzRHRTZUVBd1BO?=
 =?utf-8?B?ZVQ2Z1RlRTFyVjlGcHRPREdORHAxRHh1WFRJcUxBRHRpUjhTS2ZpZjY5dkdr?=
 =?utf-8?B?SDFVQm4ydS8ySHQ1M0VOajl2ZVo4dmorK3lVUmd6N3dPOUVmQ2JFbGlpQjgw?=
 =?utf-8?B?VldNVnFBR1Zabzc5b202M2hnNWFnTW1tbTdLZGRiYmlxNUR4SE5sT29iNTBp?=
 =?utf-8?B?WjFVbDByRzNQeUM1SnJyNnY2Nm5ZUWd3Q2Qxb01BSjB4eDZYL2hqazU0dVF5?=
 =?utf-8?B?cWxmdG9FSjNCdEZmWUhxaDBkeDllRE95K2JTZnFoSGZxbVQzd2xjUlI0cWNX?=
 =?utf-8?B?bFdZLzVEOFMyTmU3M2tzTTZmd3RjT3NqMytoNlBuZVRsc0djY0poZXFBc1VL?=
 =?utf-8?Q?vZFY4b8tuNlpWaltQrONTMrz0p+vj4YWfi+1Rog?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnBOV2V6ei91VTVTL3Z3VS9WbGRhQUhtbTErMlVNU0liTW9Cc05oak8vV1pN?=
 =?utf-8?B?bmFJbEFyaUlrNHYzRFZndE5IRkY1Vkhaek5RK3FUMi9tUTl5VmM0UzNuRmcz?=
 =?utf-8?B?VXphRFJLaHhrenZyZEZSM3ZMV0Y1TnkxUVptTTVBaHVqa21wMjdyOEtxaVpa?=
 =?utf-8?B?OXNtSlozam0zZGI5T2M3OFNrN05lcVZjQXJlN1FxakJ4Qk5DS3RsVVJlQWtE?=
 =?utf-8?B?RWU4anZETndqVDM4eG5YTys3R0VUZWI5L20wcjZFZ0E4SnZXMG9UbXFORmRF?=
 =?utf-8?B?WllTc09QOUpqZk0vdU42V29NamlTMThVRTdaWmxVaTlMVjFDQzRTeFlXdlRV?=
 =?utf-8?B?STI3TG1UdVppVjFaQ3pmMkxzb3VSZHRHNDF3UERzL2NJZkhkeXpLbG1UM1R2?=
 =?utf-8?B?VEhNSzBaUEZwanVpcjVYSFNWZTlmV2hJUXRPcmFIeFRVNWg4blorQ1pUN00r?=
 =?utf-8?B?UHVpbXhaZnZTUzdDRmlVY0ovc2NCS0pKdlBWUDhKUG1CYjZOZWFiZlBsMytr?=
 =?utf-8?B?cjh0czdYdExubHJQL0xCQTZ6Y284TEVmTHJyUXMvSkpGemJDaDRrcktPWWVE?=
 =?utf-8?B?a2s2WitCODFIaFBla0Nqb2tvTE9FMzI5WU5ISGlTeDVPbU1Cd2QxRUxBZThW?=
 =?utf-8?B?aXVVaWVhWTNoUFFQNEgxUjJrQXBjc3BEYUVZeFd2VGdBWHViN0VWVmtISE1t?=
 =?utf-8?B?QXdmVnRHNU1UckVsR2hxSEtzOVF1Z1JwN3NrdElZbVROY1BGdTExdWcvQjVL?=
 =?utf-8?B?SUdiTDN5VTJvRkJSc2IrWk1pMEFPNXFOOVE5QS9Ja1JQNVMzUExWNEtUcUE5?=
 =?utf-8?B?S1BZTGpHYmxNNDdUU2xSck1kQ3BnVVc3YVFPOGUvNDE5MWh5SmI3SFJuUnpB?=
 =?utf-8?B?SDdoalpKTVpwUDZQNXkydkw0OWZ6YVVCK0FzejFsbVVkREk4Z1JiUnNCL0ow?=
 =?utf-8?B?S2ZRQmRQT00rVUJrNGNjVEhJNUxOUFFYd1hyZ0ZHZlVXZktWU2F1WnBnQmFW?=
 =?utf-8?B?NjB4ZVU1NllyZlFUODJlS2dSN2dwRXpySGtDUFdCODMvbVIxTDZSUm4xYUNY?=
 =?utf-8?B?L090WHlhdnltOVRybEV2bmJpTUV6d3VtbzFFNHBYMlVtQWFwQVZzdVZCeHMv?=
 =?utf-8?B?dnR2WitzVHZreERuT0R2MHFKbTlCTFVRMnlnd3gvcDFoSWdXNnNGSDRUaVdr?=
 =?utf-8?B?OXJDeHpxaUZneFVyQ1hCRnI1bkw0K1U5bFhTL2gwcUtmUXc5VFF3bmtpMVdy?=
 =?utf-8?B?b0FVTHlyUHZrc2ZLbUt4ZlNIbVA1WURwNjlEbTVkOU51TTEwV1A3eFpMTWlv?=
 =?utf-8?B?V0pXUVZEZnAzUDFpOWg2elJYNFlJaFJpSjdxcEgrVmozNGFGa2JSRm02Rk9a?=
 =?utf-8?B?NE9CRklBM0Nza3dveHVhdzFhNjIvbW8zVWVyOUNPTzJad1MyYXZLR3orRmlH?=
 =?utf-8?B?RzBpRWUraENtbkdrSll3YXZLYVVGc2E5MmgzNWp3YU0zZ0hsbWhGZWpLWjhI?=
 =?utf-8?B?MjFITHBTZzE3YXlvWmhBeHJCQlRTSEdSZGlOcUd2VlVhQlpEL09PN00wayti?=
 =?utf-8?B?a2J3Tmg1cXphVjRidCtsZ3UzK2k3elJ5ays5RGlieml6NjZGNzJsb3hmZWdw?=
 =?utf-8?B?OGdNRklHU1VHdmE2a0l5bzFOVWt2NEwxcFk2bmc5UGw3TC9oOUF5ZzU4bmsv?=
 =?utf-8?B?eHQwbFVwd2ZzcHZzclU2VDhKWUluZ2lJSVB4T0hsL25JRUo0dVJ4anVsTUFr?=
 =?utf-8?B?STZ4eVZGUGwxUzhjOTU3YjQ3T1p3aENZT05HbnBqQklKdjhDdTUrS1lIRVhp?=
 =?utf-8?B?bFNIam05d2VKdXpNdGZUQ1RqbExOZURBd1ZQY1pBZHJaV3NhRDVoemV0enVI?=
 =?utf-8?B?TkpJY2hXdG4vUHhuOFp6YXNYWDAzMXpWWXArbThIZ25DMTJGZU5aVFZ1RUtS?=
 =?utf-8?B?TjhsWnk0a0VkRzJSa0JzNS9xUDNaV2RMSnRXTWNvOFpmTit6K1NSRDN3SFVK?=
 =?utf-8?B?bWxzS2RnbGFBZkk5eEh6WFdQWVU5clEwYW1tRFZ1eHVKUWFRMlhhNHNsTUJF?=
 =?utf-8?B?cllGSzZUT1NESUlTdzRzSXNEeCt0c25LZ3lDdnN0ZmZJMUJKNjR6MjF3RUYz?=
 =?utf-8?Q?hqUbAF5kQFnmPfqKWFZmwHwSd?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efe52a73-1149-43a0-d340-08dd6dbeaa0c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 06:06:22.1974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jP5VM9YezrsLiEiJsWwY/cYpBG8dIGfkdWl0UHzUSFF6YSuz79pesY5jeH8SikD54rm/sOnd9an1XC7F2EqkMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8243

On 28.03.25 07:00, Pierre FICHEUX wrote:
> Same for "all" the links (repositories) from xenomai.org !
> 

Was either a temporary hick-up or is (still) a local issue on your side.
Works fine here.

Jan

> 
> Le ven. 28 mars 2025 à 06:57, Pierre FICHEUX <pierre.ficheux@smile.fr> a écrit :
>>
>> Hi,
>>
>> The xenomai-images link seems to be "forbidden" (error 403).
>>
>> regards
>>
>> Le jeu. 27 mars 2025 à 07:11, Jan Kiszka <jan.kiszka@siemens.com> a écrit :
>>>
>>> On 26.03.25 21:47, Yann Le Chevoir wrote:
>>>> Hello everyone,
>>>>
>>>> We previously discussed when I installed Xenomai 3.0.9 on an imx6q with Linux 4.9 + I-Pipe.
>>>> It's working well!
>>>>
>>>> I am now trying to migrate this work to our imx8 with Linux 6.6.23 + Dovetail + Xenomai 3.2.6 (?).
>>>> I also plan to try Xenomai 4 after becoming familiar with the latest Xenomai 3.
>>>>
>>>> At first glance, I find it difficult to determine which versions are supposed to work together.
>>>> Did I miss a compatibility table somewhere?
>>>>
>>>
>>> The only table we have are our CI and image configurations, see e.g
>>> https://source.denx.de/Xenomai/xenomai-images.
>>>
>>>> After successfully preparing the kernel linux-dovetail-v6.6.23-dovetail2 + Xenomai 3.2.6 (using the tarball associated with the tag),
>>>> I encountered a redefinition issue with DEFINE_SEMAPHORE in rtcan_dev.c, which does not compile,
>>>> along with other compilation issues when fixing this one.
>>>
>>> You need 3.3 for kernels > 6.1.
>>>
>>>>
>>>> Should I try Xenomai 3.3?
>>>> Any other recommendations for this migration?
>>>
>>> Unless your hardware (and some unfortunate vendor kernel) puts
>>> constraints on you, always start with latest stable version. That is
>>> 3.3, and that is 6.12. 6.6 is no longer maintained as dovetail series.
>>>
>>> Jan
>>>
>>> --
>>> Siemens AG, Foundational Technologies
>>> Linux Expert Center
>>>
>>
>>
>> --
>>
>> Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
>>                              http://www.smile.fr
>>                              https://smile.eu/fr/offres/embarque-iot
>> I would love to change the world, but they won't give me the source code
> 
> 
> 


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
