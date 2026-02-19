Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011031.outbound.protection.outlook.com [52.101.65.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E365834107F
	for <xenomai@lists.linux.dev>; Thu, 19 Feb 2026 14:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771512500; cv=fail; b=j39NS4RCQu/D4mesiO8HcBKSH5ic4BDkTN3pVYZM2sPNSolcPQIq5O5hLvnvkmtsHSI6lqWQSVZWrw06lWF6jCfsxVGYMt4OR4bmiSF91skgxBh64ZbSbHBO0cv7URP1WfO0cV5XAvdXCx6jVbMV2AVN+fKAcihSJIXA3UsK59E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771512500; c=relaxed/simple;
	bh=wtVh0c/aGE0keVjt3Co1Fbhs0BGZZtTb8R1P9uSF8bo=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=dqYFfDw1A41gWmr1Am68Yc/gar7lJ6auou3+uxqanyI4I+v5d9yH4YZqvGYS853O+uVQaG0eI+LPY/u316JB6tVD64jXVCUUYFQEp5Jus7CWt2XCryN90jGhtg/oZJditbRvDc4loS6UdXXEPbawHAxHHDDSsrBYDIlYlG0lsV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=zZwI1Pbe; arc=fail smtp.client-ip=52.101.65.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="zZwI1Pbe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TYOVQNumnraVF+rrqygH2lOsK9dow35wp//WjvQXTuRB7iA7gWpLwdzouBcs7ixBjjTQjsquBPI/Lt1UiyPBU/vwIGInUC03t0ONIBXSJT1EKWBSA2OW8ITk7wyappYzANI/FoO1k7uidUh3wV0+RLQGuj14OHgXPw+onv8LmlERDkG1R5WdeocACDODxcvZU4iqgH+oPh/QaHvq0h90lxFp0+ptdNo+Utou8OIAkUt7rjNIK3XdZUHWYMNDqGkX07++2qPdMx/9ezLXSr/Fpvae9Fq6xfKEkn6wWwUnX95HPC52reWcZ0S59xi2cbVVdmqPPUjqnPZ2TQ9emUFaaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3dEQ8s+Cx0LrOcvxg2yd/GgxbOLWVu/91FFRXLS+aA=;
 b=uawEovH0AOJyCtV09ArpbN9VQC3QS8+ygggu/DQPaGdYgfd4uInqAoDS5DdhPXDBxfkgnw2F8HPDef3KybeGwBqEMNJ0Bpe5sv7OhCjBXutMkc4RrJ7IUjpA3n7i7K9IhJ7zGaS3HD8Xzr6LoFf6zwKwVjBGp8XaKy4hrJwEnGAj1o3P4pFOfIdqLA3O8Pfkw7tgVFrFXxQ5JVF6jQoDy5mNk7AUCcZLWTfHka+PGFAo6MZyjP8Qos0lrT47IE9Lw+yKyn2CjpZS7aM9eIoxp5m5cR7o+wE931Do/8pTevbuumI8+ogBBGzQfxbJZwO9cVi4ME3y1aeUQtGJfWokcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3dEQ8s+Cx0LrOcvxg2yd/GgxbOLWVu/91FFRXLS+aA=;
 b=zZwI1Pbey9i/7oTr1ThK5Pk1lYCIgO1efsMwNUswY1KFJOxIG1+ZTUR+KoRDjEfNiKMI52UfTlOwPT/asLsBQJYZsfOJ/tGhXAsx+Fwx/MW0OOLK9eu5DHn0GiKuiC3b+IIwU+pea8iqL/Eg+u+QNGKSGiKbiUMzyILIyBLbq/NOvt51/eqFsbJGEr21aiVuEnk1FQKnxI2EvdYg5zQ4EB+FrvMBUemZ6omUXXg0ESQEbUQnlL8eKyjHV8Srt9T8Ej+6gW5Q5Y1nUyStxnB6DOFkEqElmn8fc+v8isSC+wR6XHEg1g9wRaDt0kvo2b36OlfUCea/nTvsra9AqRwplA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5170.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:342::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 14:48:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 14:48:14 +0000
Message-ID: <754be14a-3812-4394-b352-27144804472a@siemens.com>
Date: Thu, 19 Feb 2026 15:48:13 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] build: Modernize configure.ac
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0097.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5170:EE_
X-MS-Office365-Filtering-Correlation-Id: 73842770-55dc-4f30-a240-08de6fc5e91b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUpCTFkrRFhoU3c1UnQyVHFPOGhGZUV6Q1BrbVFvbVdhMmhSbHd0OEtBY2Jl?=
 =?utf-8?B?NitGMG1UQmxkQkV1Um9OZi9YMEVIQXJub1FxRGc2cjBWWC9LeGErTmVDVkdr?=
 =?utf-8?B?bXkxeTVnT09nMkFpc1c5SFExYks5RGZsZG14c3BrbHAvNlhLeUJKd3diK1Zs?=
 =?utf-8?B?eU5hUGpqWlpyUDl0Y2k4Q2VwQ0UwcTllNCtNU2dwSTJMMnY5cnMxSXZacUdN?=
 =?utf-8?B?M3pIMVNIUEZ6bVZxNVFrQUtYLy9PS2tkQTFWWVRIZ0xHc3FLSk9OdlpTR2wv?=
 =?utf-8?B?ZEFBV3VncXpyOXpJdWVVNWcrVEFIeGFuUEtVbXp5VHVkR3BqL0xIaDNzUDc4?=
 =?utf-8?B?QS9GVEZ1SmZlU0NoS2laeEplZ2RWS0N2akhQQ1lEVlpLQnJubnpSZ25nMFh5?=
 =?utf-8?B?SWJKVHlVdkx4SjhxUEx0YmVGUkZmTnBob2NBM1g4aUhmellkVFVtZm8wemxP?=
 =?utf-8?B?Nmo2UzUzS0xpZ2hhVXh1bUh2S3ovZGJtd2JmWEpreHFmK255RVRLZkpiZyt1?=
 =?utf-8?B?OWdhQUJCb3Q0dWdGMTV3cngwTWxKelhFbGRBNWV3UjVvWjZ1V2xMd0Y3NTVY?=
 =?utf-8?B?cXdwa0tKVXVpa0hJRDlMWnZyYXhUUytlazM2b28wMGliREpNVi8zNVlKelM1?=
 =?utf-8?B?YnJ0UGRwbzRqcWxJK01YUU9nZG9TSGVHNmQ5T2kzT2tFT25OdDRWcUp0aXpI?=
 =?utf-8?B?YkNaMlpOV01BbFVZb2gzUWZqaTBhUzlndUFhUVJEemN3enJ2OFJ2a1ZtMGdN?=
 =?utf-8?B?ZlJ5Ykp3eG5YNEdYakdHYktUZWlvZ0tOblVRc1JVOEt5RHU4L1ZFSTFDaWZW?=
 =?utf-8?B?Tkp5dmJqTGRqY0FNZ29UU1JyUGZNd2F3V3BKSjk1QkptWE94aSsrMzF3WW02?=
 =?utf-8?B?QVArR21IWnZYQkVzd2l2dkF3Y3dpMDA3RFR0WVhMZnhISDdESUNQdDNGT2RC?=
 =?utf-8?B?b2xmU0t0T3RjWGtYUmxDNC8vMTlXeFVlcWY4c29IRVFKcmRrVmpNZzJyOUpT?=
 =?utf-8?B?NnRPeXU5TWh6UnRJUGN3bGFEK0oxWlRuekwrUVhRQjMzREZiVzRSVVhLN3Y5?=
 =?utf-8?B?dlN4OGsyRkpyMXBlNXh5ZnZpY05BcVZudHMxaDBGb2tGa2tuSGhTdEpQWnhk?=
 =?utf-8?B?dFVWY1pYNGNYZnhMd2xhWUp3TGNqdnByR3lhakNvZlJoVWZ0UWRJR1N5TkJm?=
 =?utf-8?B?TUozY01zcEQvUGk2b3luV1puZWRkdjVjM1FjZW1nRGZXSitHUS9tcHNUbWti?=
 =?utf-8?B?WG8rSU52NS91emVPVUllNHdiMUU1dkZMSzlnVjh0OGtVRFIyTTZYeEV1SFp4?=
 =?utf-8?B?ZGJlcDZqaFhYcUdhM1o5b0IyRCtES3g3VUlzeHIxZkJNZVExYmJyUkdoTTJ5?=
 =?utf-8?B?MWhrOTBGV0xqeURHSkpUZU83NUhLeG5xbDlwU2pDczVYWTlzTEVXTzJVNC8x?=
 =?utf-8?B?dEVLY0hPZGcrMWc2M1puaVFMUldPazI4L3Nudk5UbllNS3lvcG00VFFncGo0?=
 =?utf-8?B?aUJSWE9mR1AvNHFqNlBnaXBvTzZLNFF4am5jZEhxY1FlSTVETDNoRGswNUZn?=
 =?utf-8?B?cmN0aU9KKzg2OC9wUXBYQ2dlS3dQQVg3UldxTzJwQ0lWUWhjT0VmclRsVm9N?=
 =?utf-8?B?cC85VjRLMXo4ZzhDWWRqSS82bEJmYWJpbDVGWVRqOGljenZ6SXdPLzNGcHVO?=
 =?utf-8?B?UkNrQkpGSFlnK214RlQxL2xMcmxWTGVkbzlOVmlSd0ZnbzNGa285eGlLR2dw?=
 =?utf-8?B?VkRQVldxNUJ4dTM0OFVNNVJJQy9rN3hra3RLVWd2YS9nQk1VM3YvNGNOVmVY?=
 =?utf-8?B?NEwyWnpmOVhySHJLM2xUR0JKTGJWdWlTYkZDSFJ3M0JRV3NRSVptWUttc21R?=
 =?utf-8?B?M1lLRlRFcXpabUVXMHRmMjl3cWVicEpBNTFzK0JVa3NXMTZMd0tuZnVrdjRq?=
 =?utf-8?B?cVBvYXY2b29CbUl3Y3FKUHBrUzZYaCtPK3YzRzRHeWV1a212dEF4bzBiaVRD?=
 =?utf-8?B?S042QURreDY1VktBMDl4YkZqYTA2dXV3TDg4cVlRWnRzczBHMWI0dGU0cCta?=
 =?utf-8?B?OHl3bzg4SStETDJkd1ZRbURxQmhuOTBMaGRQS2lRUlF5Yjl4WVFHL3NURWpm?=
 =?utf-8?Q?c/cA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2d5dElBS1pkMW5wRGJ6MVd2bW5MaWZoWHozYVJBQWZQSzNmKzdaa1NrQU9s?=
 =?utf-8?B?VEVBKzlKWUFsLzc1VXRsV0h0SUdJQkRkZlA0VC9zcDBMMWhHaTV0bXZCUVlD?=
 =?utf-8?B?RGx0dUhiZHo5VDZGRjNNRUluRVZreEZNR2dSVjQ5aC9mUk13anRCMXRWUDFt?=
 =?utf-8?B?THN4U0czd0c2UFBhTDhlL2Rjd1VLeWNuY3VmL2NSSVlFV2lBNDZPSW5EeEdF?=
 =?utf-8?B?K3lkT3VYWDFlUjRwdVkrQkVKdDE3TDdBWUFqdDUxQms5N0ttU3VGQWVVYnJG?=
 =?utf-8?B?Y0tucGt6a1BBYWlhRFlLL1F2U2FiWEQydTNFakZhZVMva1p5Tllvb0FpNXQv?=
 =?utf-8?B?T1dnbUlmOXJBcU14cjhLeEhLUjUveHJ0OHVGMUI2NG5XYnN6YlRDaDRTSTk2?=
 =?utf-8?B?dEEvU3c1QXdiTFJJb2pHeG55VzVrTjFZaFV4eXVDT2xCNUZ5OWJycDBPYyt6?=
 =?utf-8?B?Ukl1blNZaFRFazRvWmdFY3UweVdJMG95SHlDYlNBTHQzUlczR2svTHU4OWN2?=
 =?utf-8?B?c21NcVh6R2RmZ3hQTlZ1aFZmL0gxRlVTN0YzS3gwdlhHTjE2SURSWG55MXBJ?=
 =?utf-8?B?ekVEbFduT09vTnN3Ny9lWmdLM0Nwb2QwNGxDSklSMFdaMnY0OHAyNkN3Vi9M?=
 =?utf-8?B?eWtuYVU3R05sTFB5TkRUSTQ3QzdFVDZBbVhGQXRFTnNEbkNqVXNjY2gwZE54?=
 =?utf-8?B?KzJFamFud2xNSWVLWHNkNDZ0L0NrV3dROTRWYXdnd2tKazJTeWZvSXUxRlRC?=
 =?utf-8?B?VHcrblIvbENtMWx3NEtlZ0g2SU1nK0NlLzhlSmtrZS9GaXZpbFBWMnBPK0Zq?=
 =?utf-8?B?SmlKM2NYWC9yVHRFdGZ4TEU3QXhZY1J5UjJVTmRjek5HYndhaWpDeE94WURI?=
 =?utf-8?B?elZ3Q2pVMlNhMmVpVWxCSExHZ0lJYUhzaXF0bXhoWXBGUXRKazV5blB4T1da?=
 =?utf-8?B?YXlBTlc5QWg3NXE5V25RSWxjelpFcktkRlJKcWhoOWhZbEd4QVpDTTJralEx?=
 =?utf-8?B?NlZTK3d2dE9kMkVFTUJPcnRkbXV4aHNaRHpkMFdEMUU2b09LMkFtdU1FZThN?=
 =?utf-8?B?RmdoZUtUejRoQ2pDZVZNL2xCUWpkQSt2VXB5QlVYZWorWWtFRVBhYlprdE1l?=
 =?utf-8?B?WlNrMDltcCtabjgyYk1XOUlTOEJHUTNVcU93VmdGME00clZMSlNsMFZzbTdN?=
 =?utf-8?B?TVRxb1dZQmYxQWwrM2RRVzhyRkR6NWttQzUycWc0NlJrV1VPbkRWYXhBNUtv?=
 =?utf-8?B?b0N4MTRrQk4vc3NXcFgvbnFVZDJvaXVST1lFeitBSjE3eTFRRmtkZnI4ZnBu?=
 =?utf-8?B?RVN1Njh4bklqajJjRzExdW1USTVCbDhxNWJMNzVjanZVaVVrL1pWS0ZCMG1Z?=
 =?utf-8?B?NW16MmpCVHhXVGhkMHpiZU05SzhFSDc2bWs0K2xsSksra2dQbnQreFI1TVgz?=
 =?utf-8?B?VXBCbStVRzR3dmQwYWVVVXAzMGNybDVLSFVjUzNrY3B3T2dUVWRjRTFyZEZB?=
 =?utf-8?B?UUxtNGowaHdjNnlPOFBVZjAvdHpRYjB1azFNdkFZRnRnQ3dJRkJ6aCtCcHM2?=
 =?utf-8?B?akFNZ2NYTGNyVjNUWml4ajBBL3cyQkJob040dnh6N1M4VER3dzgwUlI2RDlM?=
 =?utf-8?B?WUNlYlZ2WTdXZUF6Y3pGMmVWMithSlo0RHZCcEp3WTJIUkxHLzdJWTdaYnBl?=
 =?utf-8?B?Z3J6MnhqWjl0aytmUmttSldRb2g4dFRMSnEyK3plYVZFbkpyZnIyTEJ6MmVt?=
 =?utf-8?B?Nmx4S20yd0VLdHMwMlpMSzI4R0prWHJheHNzYWk0L2pzV2VublVxNkFKVEd0?=
 =?utf-8?B?QnFhNTYwOFZwSUw2SjVEV01pR0IyMUFkSDVhbXl3ZWJ0QUdPb2IvMjg2VllZ?=
 =?utf-8?B?cStLQUNZaC9OVkNhSEthR3V0UTIzWFUwYzZMSVEwTTlkd1N3b0YxWUFQQkpq?=
 =?utf-8?B?bWVwRng2Zm5xQklyMmxJUkltK0RMOWlCUk9sc1U3ZElnbmVoNTZYNVcwaEht?=
 =?utf-8?B?aER6cEcvRitGcG44T0ExSTdVWGhEVUxmbXpqUWY3czgxSXVFWXhkTEgyeHU4?=
 =?utf-8?B?WnJzZlA5eHZsdkU5OGREMW5nWXVyQms0eUF5STZ6Q2hLRHpoNit6SXlEZENo?=
 =?utf-8?B?RUVBWnRkSDFBYXpjYmJ3cDJpL1NqVUxUYzN1eEJEdmRmaU45NEJXRUJNYkEz?=
 =?utf-8?B?ZEJtdWE0NWxFc1VFWmd2cW55WHdocEZ2ektiQmNKK2EraGhURXBsc1o5RUw3?=
 =?utf-8?B?S2c3WGtJS2RTRXl1elhaMDB2c3RnUEdRSjhzTVZ5TWtkVW1uWkF2ZEJaVlR6?=
 =?utf-8?B?VHphM0pPL1MzU1FTaHpsTkV0NEVNN1V3WHJrWklJQ2FqY1pVdkNhU3hDU1ox?=
 =?utf-8?Q?WWJHtUkc+arPvS7I=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73842770-55dc-4f30-a240-08de6fc5e91b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 14:48:14.4709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KO7n2u45JaJ2oJ5ME5COs4oFh0++gDimdQYoG0Y70/5F2cqNVE8caoo2bWFozkV3N36DOFykjc68jqUU4aQDgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5170

From: Jan Kiszka <jan.kiszka@siemens.com>

These changes resolve a lot of "X is obsolete" warnings and take some of
the autoupdate suggestions into account. Set our new baseline to 2.69
which was shipped via bullseye.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 configure.ac | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/configure.ac b/configure.ac
index 5d8fe4fb87..a9da072877 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1,5 +1,5 @@
 dnl Process this file with autoconf to produce a configure script.
-AC_PREREQ(2.62)
+AC_PREREQ([2.69])
 
 # The config/version-code file defines the general versioning data
 # as: <major>.<minor>.<subrev>, giving the full Xenomai version stamp.
@@ -7,7 +7,7 @@ AC_PREREQ(2.62)
 # implement (which actually expresses the revision level of the
 # Copperplate library).  The kernel ABI is Cobalt-specific and is
 # defined for each architecture in the asm/features.h file.
-AC_INIT([Xenomai],m4_normalize(m4_include([config/version-label])),xenomai@xenomai.org)
+AC_INIT([Xenomai],[m4_normalize(m4_include([config/version-label]))],[xenomai@xenomai.org])
 
 AC_CONFIG_HEADERS(include/xeno_config.h)
 AC_CONFIG_AUX_DIR(config)
@@ -174,7 +174,7 @@ AC_MSG_RESULT([$target_cpu_arch])
 XENO_TARGET_ARCH=$target_cpu_arch
 AM_CONDITIONAL(XENO_X86,[test x$target_cpu_arch = xx86])
 AC_ENABLE_SHARED
-AC_PROG_LIBTOOL
+LT_INIT
 
 dnl
 dnl Parse options
@@ -677,11 +677,11 @@ dnl Check for atomic builtins. For now we only check for the legacy
 dnl interface, i.e. __sync_*.
 
 AC_CACHE_CHECK([whether the compiler provides atomic builtins], ac_cv_atomic_builtins, [
-LIBS=
-AC_TRY_LINK([
-int atomic_sub(int i) { return __sync_sub_and_fetch(&i, 1); }
-int atomic_add(int i) { return __sync_add_and_fetch(&i, 1); }
-], [], ac_cv_atomic_builtins="yes")
+  LIBS=
+  AC_LINK_IFELSE([AC_LANG_SOURCE([
+    int atomic_sub(int i) { return __sync_sub_and_fetch(&i, 1); }
+    int atomic_add(int i) { return __sync_add_and_fetch(&i, 1); }
+  ])], [], [ac_cv_atomic_builtins=yes])
 ])
 if test "$ac_cv_atomic_builtins" != "yes"; then
    AC_MSG_ERROR([compiler does not support atomic builtins])
@@ -690,7 +690,7 @@ fi
 unset want_fortify
 AC_MSG_CHECKING(for fortify support)
 AC_ARG_ENABLE([fortify],
-	      AC_HELP_STRING([--enable-fortify],
+	      AS_HELP_STRING([--enable-fortify],
 			     [Enable _FORTIFY_SOURCE]),
 	      [case "$enableval" in
 	      y | yes) want_fortify=yes;;
@@ -748,7 +748,7 @@ XENO_USER_CFLAGS="$XENO_USER_CFLAGS -I$topdir/include/$rtcore_type"
 AC_MSG_CHECKING([whether ld supports @file])
 AC_CACHE_VAL(ac_cv_ld_file_option,
   AC_LANG_SAVE
-  AC_LANG_C
+  AC_LANG([C])
   save_LDFLAGS="$LDFLAGS"
   [LDFLAGS="-Wl,@/dev/null"]
   AC_LINK_IFELSE([AC_LANG_SOURCE([main(){}])],
@@ -762,7 +762,7 @@ AC_SUBST(LD_FILE_OPTION)
 
 AC_MSG_CHECKING(whether to enable dlopening of Xenomai libraries)
 AC_ARG_ENABLE(dlopen-libs,
-	AC_HELP_STRING([--enable-dlopen-libs], [Allow dynamic loading of Xenomai libraries]),
+	AS_HELP_STRING([--enable-dlopen-libs], [Allow dynamic loading of Xenomai libraries]),
 	[case "$enableval" in
 	y | yes) CONFIG_XENO_LIBS_DLOPEN=y ;;
 	*) CONFIG_XENO_LIBS_DLOPEN=$enableval ;;
@@ -780,25 +780,24 @@ AM_CONDITIONAL(CONFIG_XENO_LIBS_DLOPEN,[test x$CONFIG_XENO_LIBS_DLOPEN = xy])
 
 AC_MSG_CHECKING(whether to enable TLS support)
 AC_ARG_ENABLE([tls],
-	    AC_HELP_STRING([--enable-tls],
+	    AS_HELP_STRING([--enable-tls],
 			   [Enable thread local storage]),
 	    [use_tls=$enableval])
 AC_MSG_RESULT($use_tls)
 
 AC_MSG_CHECKING(whether glibc has y2038 support)
-AC_TRY_COMPILE([#include <features.h>],
-	[
+AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[#include <features.h>]], [[
 		#if !(__GLIBC__ > 2 || (__GLIBC__ == 2 && __GLIBC_MINOR__ >= 34))
 			#error "No y2038 support"
 		#endif
-	],
-	glibc_has_y2038_support=yes,
-	glibc_has_y2038_support=no)
+	]])],
+	[glibc_has_y2038_support=yes],
+	[glibc_has_y2038_support=no])
 AC_MSG_RESULT($glibc_has_y2038_support)
 
 AC_MSG_CHECKING(whether to enable y2038 support in Xenomai libraries)
 AC_ARG_ENABLE(y2038,
-	AC_HELP_STRING([--disable-y2038], [Disable y2038 support]),
+	AS_HELP_STRING([--disable-y2038], [Disable y2038 support]),
 	[
 		CONFIG_XENO_LIBS_TIME64=no
 	],
@@ -1158,4 +1157,4 @@ AC_CONFIG_FILES([ \
 	doc/asciidoc/Makefile \
 	])
 
-AC_OUTPUT()
+AC_OUTPUT
-- 
2.47.3
