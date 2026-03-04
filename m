Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010016.outbound.protection.outlook.com [52.101.84.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623F738422A
	for <xenomai@lists.linux.dev>; Wed,  4 Mar 2026 07:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772610867; cv=fail; b=JCgCm65sfP5FXT2yaDq/9rj5YLTV4TLj/s2G2pcaKXEkjMvainQESfUkIgbXkF43MBjBWRLUwW8ZmlPGZ+VuKen/5gG3bCQkPC1yWFGGg8ICI4z5D0Jzmog1SGiu9ZTn3Asgoje37QTlwttjwbuaeKMPi/l2BYrvNhA23FYXhoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772610867; c=relaxed/simple;
	bh=3iIHM25M32RC8Ecrw9SsYFvGfis6OgP/LGtrCBQA7DA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kG20Z0IgsOFzjgXYV14NRb7umUdan0512Nc5C4g2cuWyeg5s3aaalEmE3UwXRfiWd5azL74Wuiow86SKJFUpfVtUyFyUzi5zs/qZIgkRvVlobNTrtc0fpnS3wzIcRsv4BCIdSIY3iwfcIwR8HOEgryPXE5MUB5AbnxFexnhnB20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=CmRJdZMF; arc=fail smtp.client-ip=52.101.84.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="CmRJdZMF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C6KjKiObHhfE+yVBNqNOY1+Y4+/Qx+1kHVbwO4fHvB+TAwqduIavv/MGYypa1HOEHgLer++ysfbxmi+8ccsBla10Pso8lDrFYNeeiczvEAJkAWcYReEE82ZbK5bvlCGMcmooUQqeQxn3eCwYgH1PaykhW4GDh4zJqn1Z5G+wyPUgl0IU6t+9Jd/Jp0aPJzwyKIDJxncsM0QiKtLttmCXV6FwCIS79GlFHYC2QGvIr8Gch5IjOFrp21uT2en3va+7YzzP2qdgX8UkC+qhEQxIab3wxPz0BmeKwqvHX4X/VsC6iUE/1EJaWs9NTZT16V1SevY/2V/E9h4+K6BFgZkQzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kxb21JRK24cjiVX1Le4GViKBZNvNQl9fT/qNybJlZnk=;
 b=alUXuefGrry1/IrcEiyizr+7331V7Xd8S3yfhdgE1lvwIe+xonV8QE4DVdMacqV1JMjIUjw3OiCkTN9AGm69A2oYcEeiC/5lCEkxGNmiMVi+W9isegW9noXDIUc6VYpXakgzLmvw5s4yaybcBs2oEBm0mY5Rf+VNANQKLOY2AbQfCBf3LKEg+Cn9M7nRmObf/3kW5R6nf0faRy7e6d3Q+jiZL0qplEZbSUZpzQJac2WUJJdFx0riGiMeQq64al4aTuc3hpi2/D4/tMSWmsZOhfdSvWZLmR9yM0gcfRuoDdb3zo+jvpSj7620E6o10R5JLSpqBQfIakHZ18koyqzrfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kxb21JRK24cjiVX1Le4GViKBZNvNQl9fT/qNybJlZnk=;
 b=CmRJdZMFJYJErq8XPXVde9X6PglNpHjn0p8CwkWSHYnxA6dysQxOgPgT6Pnm9WLOIe3bVmHJ9AvbIaYnLrrfj6WpjHdgtxv39SDOkR8xT4GsHROHg/Jb5LUccSFvCIx1wN4nLnxMmLh7Oec4JxLoBwz3AWscs4iLqNr8Ur4i23kpWl9xntcaCqi/6tB1LgezT7FvS1aqoiIcDiin2BvYsJ0AmDk06FIoQgo36mif9WrCCzNad8q4rfwbw03MSRx/w+Bfy5rspfuBXffpLlgdolzuUSFeDQ5peC7wooUAxEiDG8muQFLFvpwI6GX9ZirVCcSRNIxc5upkZXzp7YxfRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB3753.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:43::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Wed, 4 Mar
 2026 07:54:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 07:54:20 +0000
Message-ID: <1c719ea2-c3ef-4f66-86ad-f4e19e6c4b96@siemens.com>
Date: Wed, 4 Mar 2026 08:54:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Some question about TI 's AM62Lx
To: =?UTF-8?B?5qKB?= <liang_1911@163.com>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <fc96d945-5c67-4d6a-80dd-336c99594371@siemens.com>
 <b721ca3.5ae3.19cb7a9b43a.Coremail.liang_1911@163.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <b721ca3.5ae3.19cb7a9b43a.Coremail.liang_1911@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::28) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB3753:EE_
X-MS-Office365-Filtering-Correlation-Id: 20165f6e-73f6-48bf-663b-08de79c33dee
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	v5sajWmI7w0NR4WdKnT+X6odDJ8KYJzlVcr5Iyi/290Pt60bm8mVJ0chHH8OiH9vPhjByaJxJGvWATuXd0d80wbZGv3Ozd5Id3B2YhEpSz9jWisd0wofiStxOJ/w+fVQzPq9BOXwBLSoak4tmERJ5AcMX0+hCJWRDT7032moecfZBJNTa+p3raes0al8ESFXOx32n1u5KUMJgoSptg/xYsBTThhccmMpfgQLutU7/Z/YTnidHVL5VEs6AdtcF1lwZcui80FZz43Hf5RvFIuJZbJVassIgQjFsuFsM/4IjFJLNLdLOjq1ticyHgH7w8RAcmSY9GBvsQfWbnmHXxJBavuz3umgAFwhKuZOcUIlRHl1Lz6GPv5m4zW2htG7FL9L9vyThzcLkh9KGZ7kVhajDbCh7JN7WLLV0NemtkuX7g2UBrQE1UojTlhUsE8gGXea9C7OUCxVm/lOvPJYRttNoc+3tzIamNNQRG0NXOwIlNjx059JQ/zevkfOJhFcKjhKYqAQ4hrORMoLbZXjY4Vy17Rohi88oUcwlcujoB2/FmzNkr4R9fZFdd5N7jUpHR3e03Jc5eTaF0GI+23GmgQWP8kPuWfb3XZ1yR1vqKssvvvGycnUFCZC/JLqUBa7BqC16qYulj+suuzHGDIhk+Z/76sKI/Bf/1c6CfT+jYYuDN9V1btnbSYcoKp3BSyrzdYB85y4Q+z1o9K3uaJ1wSt3c6m5+0r4Hn6+jAa3Ikx+QX4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTl3aVNabk1mZEhBNWxkWUpPS2kyWldrelRRTjJhL3dmQkZtV01ZVjROZWkw?=
 =?utf-8?B?Kzg1MGMxK01lVUZWbFFJVVBDbUlmaHplZzE1YWZSWGdmVmRHVmxGbi8xc3k3?=
 =?utf-8?B?cWlMYlhQMGJYc0kyN1liNDZtSlA3ZVVIakEza0diNGlHd0h6T3NKMnZsazN3?=
 =?utf-8?B?WVdWMmJTeUptbjYrcmpBd05pRVRGV2UwZlFQcFVuWUdSMmovMmFucjJsYlNq?=
 =?utf-8?B?aDVUN0hrWE55b0JXdHpydFZzVTk0UUlrSTZPRisvL1c5cHMwaFl4WmhrdGY1?=
 =?utf-8?B?UDdJUUJRZ3RwRnR2QmpMRW5kdTBGUU1vamJCRmt4aFVXeUtYVEFXdWo5cUNJ?=
 =?utf-8?B?Z3B5d3dRMnFzNjA0dWMrRFpnVWtLU0tMdlhvKzBDcGl6dndPdkhxS0pjWExK?=
 =?utf-8?B?UGRJZy9PV3czVXVtSUJkRnloKzFIZ2VFa05VRjJ5RzdCVUtROWRydks0bGxP?=
 =?utf-8?B?YjlacWJBNTRhYk95cVFQcW5HN3ZLK2Q3VThnbFhPNjMySjJHY0JCbXlvaGtP?=
 =?utf-8?B?a0VPZW5VR0puaE9iL0hFMDNmTkxDMWk3dUE3U3pzWlpBNzRFMXgvWVVwMm40?=
 =?utf-8?B?aVRxbXJvYmZlTkpIK2o5dC9aTjFmV2Z4RFl5REdaZU5HdFc3amJ6ZGhNc2Ix?=
 =?utf-8?B?QmpLR24vZmFoM0Y5MUF4WVFZYlBjdmJ3bjNha3lpZnRQMTZqcUlFZFlSK0xo?=
 =?utf-8?B?MDRTOUJ5T0JmUDJsUkloRGY5L3JzYXo4NTE1cTNqYVJ0cjVBSy95Nm8rdFZx?=
 =?utf-8?B?VzE0SEQvRXV0MStjbjdBTVdSSFliQ2JZU1Jyamk3RTU3QVo0L212dFlFbWR6?=
 =?utf-8?B?VkJ2NGI1WlBza1Qvcy9tRVJIbUdZN1NaS2xqeHNVTGhrRUpJcDFXUWpUVVZs?=
 =?utf-8?B?MUtjYlJXL25yYjlmdnFmUW1tdDdIVjRsOWlSL0ZDSjZCdzNOdkJya3pra2o3?=
 =?utf-8?B?ZkJLWHJDTXVzdWtOR2ZxY09uQmxyWStXT0sxVTZNTFV0dHR6dDg2eTljZk9u?=
 =?utf-8?B?T2IvMU1QbUZ5L1RmVDY0QUxSYlBzTkhYNGV0NE9HeDhWZ09QT0RYQmxrSTha?=
 =?utf-8?B?OGxoZ05sV2puSHpkT0IvS3NuQU5mNytTWVdQb3ZIK2p0WnBWNDVRS0IzMVNi?=
 =?utf-8?B?MEFKeE5HQ2IvTkl1SVlJdE1wVHNaWUthZHd2cktEcit2NVRyc3pWWVZMWXlr?=
 =?utf-8?B?eFFWY1ZhbXp1YmpaT3J4Nms4TjNCVFk2R3orSHluQTlIUmJ3ZkMyRitjTzQ0?=
 =?utf-8?B?eU1tdUNMUTJ5NTBHQmdaMkw4ZHJ6Z1NacTlaQmNRU2svK0FXTy9GUzZQSVR1?=
 =?utf-8?B?cnBNZ3d6ZlprK3dWdTVpbjJLbVVGQUJ5STA3ZUt2VGdKd0FsQmZNY1lHZytM?=
 =?utf-8?B?emNOSERjb3BYdEkzTzFOazRXb0ZDNkRJeTVZRUhYR0d0MEpUS2x1aTdOS1VD?=
 =?utf-8?B?TTZHenNicVdNV1N3djV4YlU1RUJKc29BM2FXcXhlcmJMZHg4UXpvNWF4NUZx?=
 =?utf-8?B?d2lTditzeDBOdGlzcUVHb05HanpxSGx3dUJHNTAvMFJjY2Q0TGY2MVBxVzlC?=
 =?utf-8?B?VlZVeGlwM01IN0tTc2w3VCtId3dhb2hYTnBGYWF4YmJOeWJkcUVkYWdlOGhD?=
 =?utf-8?B?U0dGOGNyZ2hLNlNRZWx3NnZUQ2V5R3R1TjR1aEhCWDRlZ201V1J4alE0WHhG?=
 =?utf-8?B?cXVST3pSbk5OOStSaUgyVjhxR2VRbmZqN3B3QnE2SmorY3FKMzA2QnhUQTcz?=
 =?utf-8?B?T3BRTm0zLzVCSHdFRTZOZ2NJanFjWHZRTlJDMWNWTTQ3SG40K2ZIWjJlYyto?=
 =?utf-8?B?S3N5NXZpQWVodVlKNGtsR2xnbWp2MXd5SG5nYnNrbWFsR3N3QTJYeGFtaE1M?=
 =?utf-8?B?ZHhDZzNWZGdObXNzZjR5Uys4UGtnRldrekVzMUtyQ1JDMERaaEdoK0tzd3Nl?=
 =?utf-8?B?Vit0SDFhWS91WHBhR3BwMFArdHhUcnFnMTlpUzNtbXp4c01ra2F4czNQNDNX?=
 =?utf-8?B?cURoejU3NUkycFFsV1RDMi9jcW03SnlRd0ZMVzRsNzdPVjcvc3NFVXpYbk1Q?=
 =?utf-8?B?VkNjME1QYWFzR0hqVXkyc3VqcWZHMzBvRHpiUi9UOE10UE1uYjBFRVlzNzdR?=
 =?utf-8?B?QnZ6V21NNmtjaUJncUV5M0tQc0J6b2tKWHR4aUg0Wi9kaWp3MnhqVFRUWDJT?=
 =?utf-8?B?cjhzY0hiS3VhUTA1eDBQLzNDQjN0VUkyZUYyYVVWTDdFK296THdYVTVyLzV2?=
 =?utf-8?B?b3YrMFh5MDFOK3BRVFFGWlU2SkVjV1A1amlXNk1Fb0UzL09hbkEwdTVKMVVB?=
 =?utf-8?B?ejhrWXhlclMybXlXVTVoOEsxb3M0N0pUTWZiN01aZ2NLWEtma3Erdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20165f6e-73f6-48bf-663b-08de79c33dee
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 07:54:20.2400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eOZfJW4PF1aMfYtxbNspHhTmtDfYB5SRzUEGhGCuPAirulu8/Umzt7dqHUlLeWH186/dwz89Z50jlmZLicF6yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3753

On 04.03.26 08:04, 梁 wrote:
> Hi all,
> I would like to ask whether there are any plans to support TI's latest
> AM62Lx chips in Xenomai 3 or Xenomai 4?
> 
I may just work (tm). At least I tried that a while ago on a BeaglePlay
and also on some AM65 based devices, and not Xenomai-related changes
where needed. Give it a try using our 6.18 kernels, I would say.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
