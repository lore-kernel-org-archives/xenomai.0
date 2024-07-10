Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2083.outbound.protection.outlook.com [40.107.104.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99353C092
	for <xenomai@lists.linux.dev>; Wed, 10 Jul 2024 04:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720586719; cv=fail; b=D06JFY85P5l9IIfPnhFtu6+LckacOL+nu+thrKNodBArdBA2jHvfmDYQc8dkjxsdKHut9K+zokBPd8nVthrtExQ2d+q4I+vMJRVNIpxbmmucZCeEiGNOfueIkhVms3jhEPrXa/x5ifHYNuDt7qmo6YsiU0oGaSG39Qe5kgZM1bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720586719; c=relaxed/simple;
	bh=r5K/Fe2USzFJ6rN+czB8HFFmfT6bNhoB/dmt+b9hinc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L2wPbnmebRYLIeKauONsuiL7IrXhEWI8Pqk0PC35Eb2gNuP8KpVdN9xqpDFfBCu6oRR5+bv0BhT0o2la1q6ky16AEd4uFAUYGcPQ7N0FF0CgHCcnmiqJlZMSEzQ89WcTgA4kkou1jyuNkVjYmTNpOIpSY2dLy+Db91xvq6Yj6FE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=on5ejzSp; arc=fail smtp.client-ip=40.107.104.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="on5ejzSp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTp95SY5S22Vo4k4C5uAvCkABCzSCRRv5GzcYzD9XNptTeA6IHPWc6ANjs7WLbHTj6P1r/aPzd/wxzIy9r7AcTf38h2Za1nuj4Fvy5FMm53HPODSS5uj9+eM4v8OmqIpMV550NHX25V221xQ9SbWC2BZUXrNbznHmIr1VLMACwlV40EwxRMl0o7GRFXdySSuTAk0faIS6l4a5oiql6kQOkfwxxaiYiB1tOo5WliRg/QcmSw76Xd6zq1P8ENiuVPKIyqrtIkeJ+9P2Ad3HOzoGRRxyUIrFduVdaIiCKTgw+Q3rzhMW9csILfyLFRD7c2KGSqDCbQPbJObNTIINwBn2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BT4H5VhHMVxBCloEWR36IbeAeZj1xDsFvgdY1irI0Z4=;
 b=Nr4e15vomqI8jYvdrQJkX70/Ow/Vw7AbdH1NEhZRh6DJ+LGvAFpgNIPtxWG4m4Bv7RsNfZ6N/6vEBEKc8QN97yLpBk3G/8/H4mea9KSeiv5DnmZZsuEGrm/SISbQrNM5tgjeP030R3T8gKuG2IFhtyvOH04UTFQ09BAuXYxMacjjL86K7VRLKX5QUs1MbMa8HpyLSpoxBawWFT6T2xXrhtq3JziL/3twA1KSGzbIj7jw7fjxY5nJMUJURplF3VpfLi/B6t+eYAYMwbSOLEvh92S7xvmdCDA3ld16BcPlR+9Ow8cZuKoKL9bAH8lF+65qqxB32KgMH9/O0PUToCEkSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BT4H5VhHMVxBCloEWR36IbeAeZj1xDsFvgdY1irI0Z4=;
 b=on5ejzSpK2pSZ1PCglAkn6X/P0HMEFCrxCcCKEuBBpPSaBNQAld6U1bs6OyeBdtuyDGH9e2j84KSKZ/suQtxni5x6TPD4aUmRQ6901PhzYZEBJAgy7B8gCh42/52Hej8bwBCL9xZfOoxBBKpIIhioELHEWn/M8QHsGWIZ8H5sC+0r8gewV/ieLlB8VfRc83kIYUBCQcv+8mls5DhXEL2Kq98fqAEesKlNXrWiYfHPRs4gCsHpzTnl3J568xNzybDi343HXbtKJEMJR5wEHEQjOyYNP6BKcY8OrRqCOQ50G1u+jVCx/GQJOD19RRa37Csn9o/3dfVf+RxFegkcmQSKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 04:45:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 04:45:11 +0000
Message-ID: <0d7b3260-48fa-4eb1-a169-8c48844dbe43@siemens.com>
Date: Wed, 10 Jul 2024 06:45:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] ci: Add a long term latency test
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
References: <20240709083524.739194-1-tobias.schaffner@siemens.com>
 <20240709083524.739194-5-tobias.schaffner@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240709083524.739194-5-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0198.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3178:EE_
X-MS-Office365-Filtering-Correlation-Id: cee68245-6fdd-4353-6008-08dca09b153a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3ArUlNCOEs0WVNmZGpQcUxvR0FYRUQrYnlrVkNCZG1kbVNGckx2TmtzdU9T?=
 =?utf-8?B?QXpFTm9PaGUyWUJab0FITGVoSnNPY0FZK2VvZkVXeDQ1OUloR1FqcXZ3Ym9w?=
 =?utf-8?B?bWR4dGxoSC95alU0UDROQXVFa09MbmhmMlVaYlNHVFhrT2VHMTdOMTdCTjc2?=
 =?utf-8?B?MFUwcDNVNmlMZVBPRWE3WkVSUndZbkFBWlV6RUJaZUsxWElkZzd3QW1iVldU?=
 =?utf-8?B?WlhGWnNQMHV3V0ZlQnkyOUd6aG5mV1JQamVDT3c0Q1I3WVY2UHdOdk4wZG05?=
 =?utf-8?B?YTFUTHZqVmNJdHlWOStScTlmdEZmSDdpRjFYaW13eUVYNWFlUjNDemJCTjhO?=
 =?utf-8?B?Vllud29odVBZNnhjdjVWN29GSkM5V1BhbDAwalVlalNScHRCeHZTTXR4WUN4?=
 =?utf-8?B?ZE1WS3l0MTZDeGdyODRvZ0lJY0hZeDNtWmpDa3p2NVcvQ1pieTFGVWZGUjdp?=
 =?utf-8?B?UzlHVEFyU1Q1RGxGWURvQzZFVEp0RnRtdEFubDFPU2FtNHNZSWQ1RHN3Q2la?=
 =?utf-8?B?WEFmdkU4UGVodEJYM25iUWxhYnNXN2RaWTdhSkNSR3UzN3luVDduSUNMRmt3?=
 =?utf-8?B?SzJxV3F4RkhSd1Q0Z1ZsWGpPUS9aM1hndWUwaWVLYnlGUWxkYnJpbzh6U1N1?=
 =?utf-8?B?TVBlQmI2bVFFQXVKenFFckt2Q3FBbHRoekR2NTR2NGV6MW1MWWlOVG5xZzBt?=
 =?utf-8?B?dmdNVUZWNnhJS0dkVVFTbUtmSlJmMjZhUDByRkVSTU5yc0hhSmZ1Q1pudmNF?=
 =?utf-8?B?T1hLMmJmQkw3ZCsyS25Ua0FVdmsxaGNsbkNBanRZbVBMbnhmUUo5eW5ZYlBj?=
 =?utf-8?B?Y2JucTNrSVE2Qk1vQkVtcmt4NDF6V3BpaUdHU1dDYk8rT3pxWmR2YjFiT1k3?=
 =?utf-8?B?bG9Yd21GVUlxSFRmK3RpemgwMmlNMmY4VkswTy8wSU4yMjRWNzRmR1ZtMmhs?=
 =?utf-8?B?Uk5FMXFZdGdMRVVxemRvckFsYjlHT3BLai9SRUhacUhoZHBEbVh0VHVKZ1Jy?=
 =?utf-8?B?U3UxMkppKzNQNzRLNVdNM0h3QklYaVE5WlFkeGxvaHFCZFNiNU1POGRlNXhw?=
 =?utf-8?B?MU56UHZHcXlzbzlMT3c5VXFBa3RsaGpxM2h3bkMzUlg1QkVPeDdPNzZVckxO?=
 =?utf-8?B?dzJVdXBhNThUdGVLeXd5dk5TNFhaZTNDMEM4RVFNNFA4dEZkblVRblB2czRh?=
 =?utf-8?B?ZXo1bWZMd2NyQkVENTVSV2Z4OUZycGdtRW9TbUwwV2FFeTNDcW1yVkxNUUR4?=
 =?utf-8?B?SFd5cGgzZkprcmp3aVhmNUlFeDVQd1ZrYk05dklJSktwUGQxdlkwT1JhRFRJ?=
 =?utf-8?B?aGFOcXV4eTkwRW9BdjBjSzdDUUhTREhGVm9rVVpYRDloNE14Z3lWK1l4NVFY?=
 =?utf-8?B?N1pST1JaTm5BYUdoTHF6V3o3MElHeTluRG5ZTEJ4TFZuaWFOSHFKdFpYbnF4?=
 =?utf-8?B?MW5Dd1Q1SExkYTFNdzZONlVvcHNYdTExQ3ZKelIvSTJMNnNWeFNZdzdGWnpU?=
 =?utf-8?B?V1F6OEhVallLYm1VT1VNNEZBRXJHVHN6amJWampKcGZob2U4UXowK2hXdzln?=
 =?utf-8?B?UW0vUUNXQ290WTRuQTZ5cCtyMExoR0E0YjlwRXdWODFCRlVnVVU1eUdSd3hH?=
 =?utf-8?B?R1g3aDRIVFF4ZDAreWtWY25xOWlvNmt2b0o2QzY1L1VBVFFFd3dwdHcwdDBq?=
 =?utf-8?B?U2l2UEpVdFJBS0NLQVFPbXNZNEcxaUxkR2xhcnloOFo3Sm5nVU9PbjZCZ0xL?=
 =?utf-8?B?dWhTb1VXY3h1Z0h3eE5iR2ppRDdFSUs0cVI4di9yUHBiM3BoY2syc2psOFI5?=
 =?utf-8?B?QWtDNVJGdEVxL0ovMTkvQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDhleGdmbG5NbHhpTlA2b24rL0FhOFQzdW9MbVZmQUQvRFRiay9yVmlNZ3JI?=
 =?utf-8?B?RGZ1RitXUFZMWGNERzA5WHBmWTF2NjgwRTNPL1JNRWpwQjczY1lZZndyNm11?=
 =?utf-8?B?Ty9rWk1LZE5GRGhBWXNLemJ4VmVMd0RFejJkbUlJVU5ncXBOUXlKOUxndlU4?=
 =?utf-8?B?MzZvVjdSUlR3MnJKQS9mMmVROG1lZWhwSDZienJ0eGpiMDYzWEtleU42Vjlv?=
 =?utf-8?B?cHh2ZnVMTjlSQnFOUHl4WlRMT2hTNUx2SDZKUzg2S1NQaG5IdThWVFdQbTMw?=
 =?utf-8?B?MWwrRGJJaGxmbmsrQmk3SHRhZkJxTjZkUTZZSlladnhocWVOc0xqRTZ1dXRm?=
 =?utf-8?B?TW5VTzJIa3JzVnNmMHQ5QVpycVlSUFc3NWhEd0VuSkpSemR4S01Hb0xlQmtE?=
 =?utf-8?B?WmRnMnV3NVlGbXdSSktOOUZDNmQwcTRZSFNPZE5PaW5YeWZYZHJ6SlNCMDJW?=
 =?utf-8?B?UkRFMlFVaC93MC9OajlORGM2anhPWkZnOUxJcDFRWHUvYzM5L3JJYTNzcndI?=
 =?utf-8?B?KzZYb2ZaLyt4R2FhbTVDbGdRTFhsVy9UcWlaNFhEK0ZLUkRWaU1uS0hHaGpp?=
 =?utf-8?B?YWdETG94US92S1lCQzBLUGRKZXR5blZ1dWthMkg0c2dlYUk1STEvTFFwa0Rz?=
 =?utf-8?B?MGtCM0N3NjhrODl2T295NFl2ZVp4c0FGTElCSmZ2N1JRdkJxZm5ub09VbG8z?=
 =?utf-8?B?WkhwR1h6SVJ2dUlTK1ZlU2xPbTJybWhCb3A3T1l4QTljcW5tMkpvTXlycmFK?=
 =?utf-8?B?WFdRTzI2K3prcnB4MUw3UmVYTytOZGJ4MW5qY3J1OVlkTnYwV1B1TGxVOGNu?=
 =?utf-8?B?R21VeUZyekhCUmU2LzJ3ZXh1KzI0bXJVVWdpYlZFbUVPM2RSdTlmV2Q1MmtW?=
 =?utf-8?B?bVZmeTNSQUlWbm5wTXd4MWxwYk1XNi9BMzBHc0JzN1BEdVI1aktmYmJhUW12?=
 =?utf-8?B?cmg1bW9RaEduQjluMVl4aUMyMUVJSG9WRVVUVStVdjhLU1g4QlZzajZtR29U?=
 =?utf-8?B?ZjJDQmlleVpzMjd0M0VQcmsrdGk0d3h6NWhSWXRYSy81RFZQS3hzQS9iY0Jn?=
 =?utf-8?B?aHZJdWJZamdRTUJtbDdoTXpvUXVUUnRGSEE0cXJkVXBEZThsUko1eWU3emFp?=
 =?utf-8?B?Y0ZOZlZBYzM5clJIbExPTFFvTnkwTHh6WFowcGRXWlBRSDRYYmJFamMvdk8x?=
 =?utf-8?B?RHhySzBLdkpYWEFPMnN6TkxWbnRsYTMzbFhCV0pFb0R3dWdxNE1LSUhMQUdw?=
 =?utf-8?B?TUtTRVI3VDBWZGY3MUF0akRBVzVkaGVJYThHQXJmWFozZU4vVnB6bmdmQnlR?=
 =?utf-8?B?VzV4NVNIODdERFlCdGU3Sk9qOU1Lbm5walFtamZTa1J4d1VieXVoOElrZUt5?=
 =?utf-8?B?dkx3alN2MHNqSHlwZ0JYZ0cwaHBmYTZiWVZaV0RuSG5hTitGL3o0L3ZJbk43?=
 =?utf-8?B?U3NsckFtbGNuamVUWmVLclpoWGhCeEVqNDJsTkViWGhSMUV6ZEtJYTBqOXRX?=
 =?utf-8?B?eTJ2YUJBNDRiUnY5VzBydTN1OGxGdzBoSklFVE14Ry9PeC9CVmFjN1VzcjBU?=
 =?utf-8?B?RGFkZEE2ZHhoYVFxRXFmQVVLYy9xWlVkUkorTjVvR0JIQmRFRDZmdjZKSWY1?=
 =?utf-8?B?MXVWcEx1SUxtQVVFbXZPc01jQ0sxT3ZFdDBkWCtyM0NzYWV6Mzk5VjVBd0Zm?=
 =?utf-8?B?ZTFlbmJsRUh5OFVaeDZ6NktzR0JvNXVRZkxIS1Q5Y2hRS2Rzbm53YnRZQlFu?=
 =?utf-8?B?N0VQWWtHVWlZUXJLSmgyZkFRMXlGNUZ2dVhQYlZVUnVreS9JYXRIS0NEOTFN?=
 =?utf-8?B?eGNiaUFvcm1OejVTWWlzSkR6dTdOaXBJUjZCSm5zeVRadFIwVGlyNFZKdGY4?=
 =?utf-8?B?ajFVMjRwcnhkOVoyNW5NMldiWTNSVStKT3BnbVJTb1pkcUFmSmF0aTViMXYy?=
 =?utf-8?B?aDVlNUdNME5rL0xaOXhtdWdSSGlub2pGYzYzSlpHUUY0V0ZSNUtzNTRXdFJh?=
 =?utf-8?B?WVBIQlNOTk5nUjhERUI2ejhoSWNQVll4ekxTV21udXJzeU9oSXMzREhDZlJW?=
 =?utf-8?B?cGorbklGVEsrS2UxMkFmeVgyd3JrQlVObCtkUEdTZjRkVmU2R3J3eHJ6dmNt?=
 =?utf-8?Q?2WUg/gKfd5Wq/Nd9tVL3lTQIW?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cee68245-6fdd-4353-6008-08dca09b153a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 04:45:11.7226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hzz1HRW6OAwOlemTsAXe9F69kSF3Ovp3c4QsWVZZV+quGucyQ9sITACbzRrG6Y/W/HzomslHIOC42kzJIt1TCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3178

On 09.07.24 10:35, Tobias Schaffner wrote:
> Add a long term latency test that is only running on physical targets.
> The duration is set to 30 minutes for testing purposes.
> 

How about making this configurable as well via a CI env var? And the job
timeout could them be the duration + 5 min. or so.

Jan

> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  .gitlab-ci.yml                  | 10 +++++++++-
>  ci/xenomai_3_next_long_term.yml | 21 +++++++++++++++++++++
>  2 files changed, 30 insertions(+), 1 deletion(-)
>  create mode 100644 ci/xenomai_3_next_long_term.yml
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 9edf635..803feaf 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -23,7 +23,7 @@ stages:
>      forward:
>        pipeline_variables: true
>    rules:
> -    - if: '$ONLY_RUN == null || $ONLY_RUN == $CI_JOB_NAME || $ONLY_RUN == "xenomai-3/${CI_JOB_NAME}"'
> +    - if: '$CI_PIPELINE_SOURCE == "push" && ($ONLY_RUN == null || $ONLY_RUN == $CI_JOB_NAME || $ONLY_RUN == "xenomai-3/${CI_JOB_NAME}")'
>  
>  
>  stable/v3.0.x:
> @@ -49,3 +49,11 @@ xenomai-3/next:
>    trigger:
>      include:
>        - local: '/ci/xenomai_3_next.yml'
> +
> +xenomai-3/next-long-term:
> +  extends: .parent
> +  trigger:
> +    include:
> +      - local: '/ci/xenomai_3_next_long_term.yml'
> +  rules:
> +  - if: $CI_PIPELINE_SOURCE == "schedule"
> diff --git a/ci/xenomai_3_next_long_term.yml b/ci/xenomai_3_next_long_term.yml
> new file mode 100644
> index 0000000..0edaca5
> --- /dev/null
> +++ b/ci/xenomai_3_next_long_term.yml
> @@ -0,0 +1,21 @@
> +#
> +# Xenomai Real-Time System
> +#
> +# Copyright (c) Siemens AG, 2024
> +#
> +# Authors:
> +#  Tobias Schaffner <tobias.schaffner@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +include:
> +  - local: '/ci/gitlab-ci-base.yml'
> +  - local: '/ci/kernel_6_6_physical.yml'
> +
> +variables:
> +  XENOMAI_BUILD_OPTION: ":opt-xenomai-next.yml"
> +  XENOMAI_VERSION: "next"
> +  LATEST_KERNEL_VERSION: "6.6"
> +  TEST_COMMAND: "xeno-test -k -l 'dohell -m /tmp 3600' -- -T 3600"
> +  TEST_TIMEOUT_MINUTES: 80

-- 
Siemens AG, Technology
Linux Expert Center

