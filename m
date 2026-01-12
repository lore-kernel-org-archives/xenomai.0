Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011014.outbound.protection.outlook.com [52.101.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1492C029C
	for <xenomai@lists.linux.dev>; Mon, 12 Jan 2026 13:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768223087; cv=fail; b=qlZ5aD1swZzB/oRCHucdrQSjCmDBBSobYXSS0k1HyeTbFA0YM3n+PtS3abqcChwEBGtnTHC03PN1iGBANCMbQsBUao/YENVBaafMzlTdM/rX0LHqAa599ftmbGSuFJJgDshi9ksDwkfRfJ2k6AdE3st+yxBgwSOdSqsc8cRID0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768223087; c=relaxed/simple;
	bh=TeUZxMo39+bUXyYcwPMtXXRJ7GJpTVuE1LMOcutRFF4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bB+aZZ5P9K1fW29Ew6BM/GytnUigJd1QuLPN3TO8/5LxbQDXrB2579+f0dfktcu+RqJ0Bpt/f0h7KqACXcB8TRiobHJM/LSUTmAO59oX4b4cDFst5Fj9PFbcG5EqcnkQpnKrdJVZoj+Q4t9FwoJ2fuvFNal8MZgPvk6dNcte+rM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=BbPWdcIR; arc=fail smtp.client-ip=52.101.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="BbPWdcIR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uJwT+pFiUiivoTs4usif8dKxB/5fH91eRlx9Bu5oeTZdxVHegtuurAo9dLVVnLB7sYqSoRj4R5mAyt8ZTJmXOhsTvC6/wsX4wY66ZnQ0cPRtGAwoSEq3oMLDl8HmtmxLi6mwYuOSoRl3utZV23AhqnxHVqw1bJyMdlueUl2M/QYBsK7Fh/EM/xbZNbmlEzoJR+uBWCao3n7DLwwWLTOyzpVrtxaGw1fyICoafXiwea/KVsudGjZ1f3nyaaYMIYqIu6yxFfl114ZypL8VdwiGGoWtEHnVAqOiumtZMnLpRLKuI7L2220fC3gY2ma8cbM25llDumGecyaZaWq9WHz2NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Nez9doW6EoYrhkyvJNooVTeRzxMQZ4fdZfNHHoyOn4=;
 b=BTz5KJ0kZLXmefiNywUMvp7JDmuXwrmRg3XWSb8koDcbMR1aag+Xp5vZCkjqKM5ZPOzjF1rzu987UTfxVb4DkYqKLskNkvp9GmeRxlCSbk6vdW3L+Z737915pavaYFgu7ftXBi5NErIPdi/84cp7GU8SFh8MQyeymC7/OswDQUslbIDVYbc1zSK3OOUQXKIowp/nS7x06PjuxwsibJf6Wi5MCtaqYijX0UYozuDzdKlAMzXqmeBSZa6bgpPaML2bSBr0OBno7/vxmdS4xJl0q48FrdjOnEQcZyv8PAR8JLgNwwSdwWgTUgzXbE8BigwfOYaaYQFd0fV+ys1dIDUJkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Nez9doW6EoYrhkyvJNooVTeRzxMQZ4fdZfNHHoyOn4=;
 b=BbPWdcIRyIlOvvrm8nyI2g3wTGuFCnP/tbMz0dloA9FR9bz5pwMFQXbmAZWo9k9hTua/NNkAq+5QsVInNNPqunuYTg+W+bxFNT0MSLKG427qyu/wpAFLcfJOIzt7PSonOQmUNmXLfWg7UQPy/566A0koUYx+U1y4jU7hL5eJdSl6K+DghXxsfl2LkJKhST92Mg4IxBqYmn2LQ7+ejVfs0gpfo/zmPMVTCt3yvzKSm6lVNxnawI/vdevU2rrWyk52AuEgELOuZ9Q4DpU14XG0HX0Ei3KaaC4xpuNtDlDrH5IVIDJJBBj9HnarMzdJKZ7DHpx5j5v/RrBJoRt42AEAuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB8553.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:232::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Mon, 12 Jan
 2026 13:04:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 13:04:42 +0000
Message-ID: <3b9dcbda-9975-49e5-be30-dd74ced848ba@siemens.com>
Date: Mon, 12 Jan 2026 14:04:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH v3 3/3] ci: Add CI for linux-dovetail
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
References: <20260112123349.3945734-1-clara.kowalsky@siemens.com>
 <20260112123349.3945734-4-clara.kowalsky@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260112123349.3945734-4-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB8553:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a794960-0046-4b80-52d8-08de51db26b9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2w4bE9MVFhvaDBwYWl1OWIxWlpCUW1RdThKZmFsaHlocnNLalNaSjUxVkRS?=
 =?utf-8?B?WWpxcHNTSFRqYUREb3JydXhWcEx4dDdFNmVZYXZtL2xOaXMzdGo0VnB3bVl2?=
 =?utf-8?B?eWJzMHFkcHRid3dIMGtqUEtzZHpsWitTMGQ1a2Y5MDFGTjR6T2lCVzFyZkJR?=
 =?utf-8?B?VGxSTTRxRXN1REtaWGFpT01scW9vNVVtb1l6MVE5d3FadGU4ZlJqeS9qMnI1?=
 =?utf-8?B?KzhaUS9mV280VVUrRVdURHVqL0U0YzBway8xd3NnRm9wdnZaeW1kRTRCSHAw?=
 =?utf-8?B?eEdGc3FZRnNEQjVLTWdVdUpCMjNySkE3b1B1ZGFuV3dhMHlXL0VvYzFtV1py?=
 =?utf-8?B?QWlGM05tWEp4bC90dnY1b1IzL3lVdUN3Y01qWEdadHVYdmdKSkJsbnZqV21v?=
 =?utf-8?B?dldRUVlDdUluSkUzVkNaQ0hGTGV6WDVscDFXOEQrTHFjci9Zbll6TGs1UUls?=
 =?utf-8?B?R3I3K2ZDK3pObTZ1MEI5UTZTam5RVGdRNUdGTFRXWFRMWGFkaTdoYVFYcndB?=
 =?utf-8?B?NjFTTlZJb2RZMlNKNVM2VTBldHI0bk8zWG1CKzIrbG4rRWpmbGNhUWxSejhB?=
 =?utf-8?B?a2FUdWVtZG01VDZUSWpuZnp1TjNvVTJuTzB2dlp4cUFaTDdUZ1VEMzNkVk1D?=
 =?utf-8?B?T3F2UmVPVnZvaXNJZzZ2ZTdlUVR0RFJKU1FaS1hLZ3VTNll5UTZGcGpZZ0t1?=
 =?utf-8?B?OGJRUmFxUXcyQktYWUpXM0RYSFlYNkdtU202bm9Zc2dFa0ZOcU9qcWpTc1pZ?=
 =?utf-8?B?UFlpeTdEZjI0V1JtZFZUK0xRQ045cjd1azlsNkhRY1JUYnlraEJNM0EyN1NJ?=
 =?utf-8?B?dUlWK1dudTZTSHkzUW5DeWpKWlJzazV0QUdBQXpGRHhjbUJFdU5wbWhxVllR?=
 =?utf-8?B?M09UaFdyYmRvV1ZJUlBxMjdUUW52Q3BMb1VIQlY4ditReGtndzA1QzZlcHAy?=
 =?utf-8?B?aGRNVU5YOXVkRDJWQWVXR0FsT2JaMFJZdlhBVVZheU5tUERpdHZkMVlKZFh6?=
 =?utf-8?B?c3ZPVnpIeWhuWDBHTk44VVpDaXFBTUNtTm5Pd3F1NUVNZEdPcVdlR3JhM1Vw?=
 =?utf-8?B?cXY3NzhOc0FEYWtnVHM2bVVMUk1PS1Z1OGNlYm55NXNDMDE4QnYxVTVuZzc4?=
 =?utf-8?B?QTRKc1lvWjBGVTVIYVlWNmppNVB4c3hWVy9sK2FLaTFaNFdac2dDR3N2cjhR?=
 =?utf-8?B?Nis4VFpsUmlCaTFXVVJmTjZHR0pkRmNYVHNrbVpPY04wWktJWG8xL1crQlZU?=
 =?utf-8?B?S0pZQUdKRmFVVUU3RXpGOUlxdVNKb3VsdmdmSTRRZit2SG9QS0dURUxaZ2tw?=
 =?utf-8?B?WFhkY3hBTjdxamF3ems3bDBSWTF6TEdwQmVVZjBJNWZhL0pDbE1qZmJRY2pS?=
 =?utf-8?B?VTBEY0kvUnFWcmsxWVNyMTNwZE83ZTgzRldCbTJrVFU5TVRHWlREcUE0R3c1?=
 =?utf-8?B?OUk4QzYrcitYNjZNTVdYUUJZV3BZbFNKVnVlbzVDVlR4OTl0ZGdoNC95bmVm?=
 =?utf-8?B?eThFeXhmeHN3eWtZQUNFV0Vqcy9vUy9VbzZVdXVEdWZvMlIwaEtUcFZmM3ZF?=
 =?utf-8?B?OW0zcXFLUHdCZXVCcnA2Y1RtN2JWZEpROUZrWStDYytWNXZLdjFqMy9WQW9r?=
 =?utf-8?B?RmVBaEMwVW1PU21tNmxTYlBEVlVzWHZzemZXYkFQY2ZzZGVnaU5WSFFZcStT?=
 =?utf-8?B?RzlGOElNOU4wOWI0eTlQYzN1aHk2ZmJGY0JlQjVoUnNOU1grenRnYTArMTNI?=
 =?utf-8?B?K2FNc21aWDF0S3JzbW1WMHJVcUpzdjVIWFlDUWZFeUx2UmF0L0IyK28vMUFa?=
 =?utf-8?B?RU9zbWp3SEFQTWZURkhDQ3o3NzMxZHNTcnB0d1NUeTZicnhhd1E2MzZ5UVBW?=
 =?utf-8?B?RjRwUlVxT05lUUJZNEhGTldEZ3d0NGhCZGRob2hnbkplNFFmZjFQOTRWQk9t?=
 =?utf-8?Q?wSleTloXIqSL5dpStFwbQq9DUlNYA8l1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmtadVJtMGxLcHErUURBYVlqT1F0K3ppNTEzOS9lQlkvOEpNNGRUMVFqbVFD?=
 =?utf-8?B?SnhCcWZMc3l6Y05PdzBHTjhYbk5FRmFpc0xLMmd3bVNOUG5mQngrSVFRdm54?=
 =?utf-8?B?YkYyNmRlNXhsZWlSVlJmT21ya0VzKzF0M3VJZ1dVOFd2RUcxTTVVcUpNeDZX?=
 =?utf-8?B?eUlMbFN2TFloWWV3ZS9ORkJueWRJZ05ScFpYcUVqc1ZXd2M2dmJtSisvVmp3?=
 =?utf-8?B?TGlWNVBJVTFrTGVoVmVlZUhEZlk4ZVVLY2VxUC9RTndTYVdJbTJmbHI1WlV0?=
 =?utf-8?B?bGVST2JYVDJuR1NMN0twK25jY2hydUhXMmU4U3ExVFF1MFJjR0luUGlickdm?=
 =?utf-8?B?UDhmNGtLdE4vMVFGcVNsTGpyVElDZ0lLcGpJYkg5MnA1ZURXU0c1UG9GQk4x?=
 =?utf-8?B?TFBkSldPTVYrM0xsOEhCMElLVkdEeFpUWVRZMkQ0WEh4K1VQMWZEV2tQWnkr?=
 =?utf-8?B?emp3b1g1ZHlTdTBLbVhWd1haQ2Fsem1wMEp0emtMT3Zid29yUlFtMm8zVG9y?=
 =?utf-8?B?OU1WWmNYUUVWSzNLWE9NVWVoeFdZUGRaVmJpd1lCbzZEZ3JsQ3lwUG1US0xY?=
 =?utf-8?B?SDBlK1FQQ1FJek0rbGJwczErTTBLOWZ2RHp3RmRCdUtVODltNjYxcldVVFE0?=
 =?utf-8?B?S1RudlpYWGNKQVNFd092OUNIdEdiYlk4K25ZSkdYUXVrZmZ2KzJmYi85U2Qr?=
 =?utf-8?B?VFNVOUxxUGxHTmZseVFDMzdHdEtGU2tnU3h5UVZKNk9PcjRVWGxBUkJ5NjJw?=
 =?utf-8?B?cnhCamJiUnRDZFMrVFcxZ2FwVzhoRGdYUXpnTlRpSmxMYUdvaDRPT2t0NUpo?=
 =?utf-8?B?TkpKcHhKV2kzZ1RHay9JeVhuVHAxSDFqSjdaWTFTNkdSRHluZzBOakdIcDZ0?=
 =?utf-8?B?dFVuRGRVejZySG1rckE1eSt1RVRuOTgvWGtSQVZrUlJxalo1WVQ4THFCSk9k?=
 =?utf-8?B?a0pCcTB3VmZlL05tYWg0MmQvS250V2JrRldQSWZaMk1Ncmtjai9qTkNSMmcy?=
 =?utf-8?B?NGwvajVwVkZkTFIzVEVraTRBMDMzS09aNnRZSy9qTENyblFNSG0veVR6Ymgx?=
 =?utf-8?B?ZjI5Qk0rMjlXUlZkNEt3L3BnUGNDVFZOTHRmeUUrcTFwZ0R6cFI1SEg2ZG9m?=
 =?utf-8?B?eW9tQlpaK1Mvb3RXYUJzbkZ2b3VvbFhOTEV5MDZLVTBQRHkvMTdrdnNGREd3?=
 =?utf-8?B?Tm43bmprcnk1TFRlVEk4QlpIdXJFUUNvWldZcWovQkV5MHhPVnBPei9HYXFt?=
 =?utf-8?B?YVFRRjloMDN0MUh2V0NUQURYWXFxdDhNb0JQMWJ0N2xaOVNuODJvakswUWVq?=
 =?utf-8?B?MExuS2JBbGlGdUcyVUp2UjRlcE80TFR3cFlENDRtNkdJSTJXbVVtM3M5MWhu?=
 =?utf-8?B?ZHdwaUNaMEUrMkRQMlhBQWVzVlhFSDlJOUs0NGdwdUpjQkJrYzdmWWE4Uk0w?=
 =?utf-8?B?RVkza2dmSy91emh4UVJ1L3pKVkoxTEZaSFBZK3Z6bkJmM2I2UVFPTHU3WDQy?=
 =?utf-8?B?WDRzcXZRWWxWYTlLQU9tYWNTeUtRUTN2Q1hlbDZVNHRGcUtBaW41a2VmbDRh?=
 =?utf-8?B?cUtnSVdUby9qRlhQUGFXUFJkUm0xN2lCN1l1dWFQVEpGK2RUUlhPUU16Y2Ur?=
 =?utf-8?B?cnh0Y0tBS2pMUDNZYVl2d0VEcW1sTkNrTWhOSmFaNTBkQnpyandhaHBtY2NV?=
 =?utf-8?B?OWJMY2VzeU5CVTZxZzBnSU4rVUVrekVxNHpra2prb2hSVWpEand0V0lsKy9U?=
 =?utf-8?B?byt4V1BRd1pBMUZPejFuVVBMcG1ud2lpNjBHaU8wQVdyS1hhZEFGR2hSdXp5?=
 =?utf-8?B?WVRGNzdsSTM4TEEzRlZLTTMxbVBMdHNFWDdIZytYVXJiQUxTRVlPSVVuSUhX?=
 =?utf-8?B?UmMveUJiMGhaSmlMNWorU2c4RHYzdHR5amhCTXlXK3NxTDF1OTVmWWNjK0Uz?=
 =?utf-8?B?Z29yY25wcEdMdmkxU2F1THRMVlJncUdBV0lvVVF1OEdoU0dzbWo4bzVZK3dL?=
 =?utf-8?B?VjluNEJLcjZZYzhnbnV4NERpWG9yN2oyRHA3Ujd3OTVSV1g4c0pVMHk1cEJK?=
 =?utf-8?B?VmVEdmdVcmdQTGZUT05PL3cwQlpuTndkQ29xSk9lMVVtbWJOaS92UGc5UHpV?=
 =?utf-8?B?QlVSNmsyUVVyQ2tEemMrVkVFNVEzWjBoOW5ZUDNKTmJ6dUxCZTNmQUt6UTJ1?=
 =?utf-8?B?ZlhzbFk0cEtjTitqNDhiZjFvMFFKU0VnWXgzak43aWlxSU1reWpxaHlLSDNT?=
 =?utf-8?B?Q1dRUjFRRnJwM1Rxc1J5SUlpcmw0MDBJcXh4cnJhTk9Hb3V0TEhmRncwUzJq?=
 =?utf-8?B?aXRYT2N0bSs0Nzl6S3pFYklzZjVnRFA1MStQdllFV2hqYkJlRnQwUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a794960-0046-4b80-52d8-08de51db26b9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 13:04:42.3619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z2GvP8s5DChy/4202iMWdYlnL6KouN3AuhfS4UlnW3vqB9CXlHUoEbHmDr+V86GC8K4MVVQr54RE8JTEi8mWOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8553

On 12.01.26 13:33, Clara Kowalsky wrote:
> The linux-dovetail repo is configured in the CI/CD settings to use as
> configuration file this file in xenomai-images.
> This adds a CI job for triggering the xenomai-images CI if new commits
> are pushed to a supported dovetail branch. By default the
> build jobs on the physical targets are started for the corresponding dovetail
> version.
> By setting KERNEL_VERSION_WITH_QEMU to the dovetail version that
> triggered the CI, the QEMU build jobs are also always run.
> 
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  ci/ci-dovetail.yml | 47 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 ci/ci-dovetail.yml
> 
> diff --git a/ci/ci-dovetail.yml b/ci/ci-dovetail.yml
> new file mode 100644
> index 0000000..c326c97
> --- /dev/null
> +++ b/ci/ci-dovetail.yml
> @@ -0,0 +1,47 @@
> +#
> +# Xenomai Real-Time System
> +#
> +# Copyright (c) Siemens AG, 2026
> +#
> +# Authors:
> +#  Clara Kowalsky <clara.kowalsky@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +# This is the CI/CD configuration file of the linux-dovetail repository,
> +# as configured in its CI/CD settings

Would be good to describe this - but also the existing trigger structure
- in the README.md. Given that this does not exist yet for xenomai ->
xenomai-images, we can also do that on top.

> +#
> +
> +stages:
> +  - set_vars
> +  - trigger_xenomai_images
> +
> +default:
> +  image: debian:trixie-slim
> +
> +set-vars:
> +  stage: set_vars

Missed this:

  tags:
   - lava

is missing here, "lava" to get the smaller runner. We may eventually not
accept untagged jobs, and then this will stall.

I'm adding this while merging.

> +  script:
> +    - |
> +      KERNEL_VERSION=$(echo "$CI_COMMIT_BRANCH" | sed -nE 's/^v([0-9]+\.[0-9]+)(\.y)?-dovetail-rebase$/\1/p' || echo "unknown")
> +      echo "KERNEL_VERSION: $KERNEL_VERSION"
> +      { echo "KERNEL_VERSION=$KERNEL_VERSION"; } > vars.env
> +  artifacts:
> +    reports:
> +      dotenv: vars.env
> +  rules:
> +    - if: '$CI_COMMIT_BRANCH =~ /^v(5\.(10|15)|6\.(1|12))(\.y)?-dovetail-rebase$/'
> +
> +trigger-xenomai-images:
> +  stage: trigger_xenomai_images
> +  needs:
> +    - set-vars
> +  trigger:
> +    project: xenomai/xenomai-images
> +    branch: next
> +    forward:
> +      pipeline_variables: true
> +  variables:
> +    KERNEL_VERSION: $KERNEL_VERSION
> +    KERNEL_VERSION_WITH_QEMU: $KERNEL_VERSION
> +    ONLY_RUN: xenomai-3/dovetail

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
