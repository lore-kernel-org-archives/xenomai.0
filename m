Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2049.outbound.protection.outlook.com [40.107.104.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502EA13A878
	for <xenomai@lists.linux.dev>; Tue,  8 Oct 2024 05:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728365259; cv=fail; b=RC8zOlU2EXqMoSrWHdbP8ZCmJOnmzfphZd4kb6xV7rBjYyh2KQWPeNX9Qev2JAOovcPPG2IXb+rbSfFLqBxM1/NNE9bcHieObg0f7tmvk05uw7mn/sTTaGYx9K7n9oXbUtUA5V5UVotm3H3SRD/4SQyyCXElZNLsNYliNCelqNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728365259; c=relaxed/simple;
	bh=PnZ/GY1Luaa+nI3eNDYSXkQlE9j735S4ElY7jm0eE4c=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=GznrKEPU0ryqo7mADsRh0KGj2I9SUU5EKG5Lb2nFfoEVSKmF3MHT4D9z/OuY3IIacbYRINTVlite77yBRS6CPjvX3khwvd2yjhPo9Tw6o42uUWfXP8kmEEBfGcvw0qArhV23T2QudMV9iMaRDimYiyf4xXFf3f2Ay2Y6Yh3LiCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Fm0JhO/I; arc=fail smtp.client-ip=40.107.104.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Fm0JhO/I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=meH7I7zblKUigHw35xw4afug8XGWu0wShij5k+GaP36MYff79wtWCImgFjfJHVDKNkMUOUK6mfQ+Mv3/16f1WHFjfpLPD5peFS3u3QGEEkR6S7en9EyaNl3qb3pnbsi9Qx5GeVsvhcdENLLw+bYDkISF37DwnhvBn4ACMpvP3FTcNxGBBJI5onqM/2DRDml2lOdzRhyzQLl/rtRa0dgZrqgd2UiFYaxCCfset4c+YnzJc0FEdEg8yuOgTL6JpUjsg9Jpe+w2z5rUF4q0GdyZCj9NV7yfMNX1xfLgDPGLgImtJ7eIyRWV3iJOifJqL1TkBmX/j040zPg6z36+hbh5xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJ7o4y+fRP3q9mBhLaq96ApnFGBp3PBQj2Tu+vT49YE=;
 b=vFchlRwABOKTctkB4WU7fM+lxKl1PKhqa+k167YdvWJiotHN74MsLd98RUuz/H8EVhtpjHAKLgayvpfvbusMm4nnYUufAcy+sACHPnBYrjHdCY6v7cqEM9GDOUuqoOnp1kxx9zrMJAhDr6WDmjVHDlrwuxqr0e931BC9/PuLm3kfn2ik4RAW3tacD7AAsUuYeN4xmmrLWvdPaVE1JHpS318nlX0LQeeiYOrSZth2ndIX/oC/sbBP+INYC4+zoK/JeXdAYg5S3/rRLRW5+wSqZ+Pqp1WSpoce3Ecaj+ZKZlLzv5wsMZd/HWj0FAFFkSbTtX4Q8eio70f2v4sJQE4aGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJ7o4y+fRP3q9mBhLaq96ApnFGBp3PBQj2Tu+vT49YE=;
 b=Fm0JhO/IRtM4c04zk8sjBQ4CqIoG0dW+0HVV2P/zbseBg5C2dfIphye/YBg7czN9bDKOJZDRrGOXh9TE02uslblqThlrD3bPhzpliTfLtmV2RUTSD1iqBCbLGgxauPEvfHNyIgFQe2jzzLJHOxLyNinVSHZ4JwcjizXAalv/PUi51gweWgyfMD0wTKa9hxyqgwXvtgU0vDvKdZwppPyomI0fhil3FtIlz9kcPRRkkmhoE4Cx5Id5tB2HcW1N18rKrxICUx0df+TfA9mlaXVpz2156BLYZX4j79oQ305SHY5k+Zilbpbfw+ReCA4C1V4wU85aL8kDGGVWjgGxXNVtwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB8237.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:38d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Tue, 8 Oct
 2024 05:27:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8048.013; Tue, 8 Oct 2024
 05:27:32 +0000
Message-ID: <aa1cde94-37cc-40c8-b72c-8d7cbe92e8e4@siemens.com>
Date: Tue, 8 Oct 2024 07:27:31 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH 3.2.x] cobalt: Move relax related lostage_wakeup work from
 stack to thread
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB8237:EE_
X-MS-Office365-Filtering-Correlation-Id: 33f8352b-da8b-4e92-a115-08dce759e8aa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZTkvMFdqRzBzTGtZRzRBb0phbHg5UU1uTFQvRk9tUnZDakpDUzFVUkd1YXdv?=
 =?utf-8?B?NE4yQmdldWlaSU90RklYbnB2T0lQN2RxTVZreERHRlZiSy9vTlBvVjJGTUZJ?=
 =?utf-8?B?enZQT0EraHpSWFVBYmhXWGZNL2tYY3paamE4c2FBSnQzT1BHWGxWRDlWVlhN?=
 =?utf-8?B?Q0lMVXdEWVl1aE03RjUyRXhZdWlyWkVmMEg3Z2xLRk0rZmFueTJpNFFQWFFX?=
 =?utf-8?B?SklNcHhlQk9HbXdsZlpqY2dMSC9LSjErR3ZnMVhDbXlwR0VxejdBNTVIQTRB?=
 =?utf-8?B?c3hsWVdyUDhUeHoxOG1sV3AvbWxUNkdHSlVwN0JLZzlvSzBFVWNDc0RzK3hI?=
 =?utf-8?B?Z1RmSjhvRzBVZXZLSjlnREZaU3I2UGpGeGlLZGxBdGxTVnVmMFBxWDlGeHdI?=
 =?utf-8?B?K1hVcUQrZlI0Ukw3NzF2SlkwR3A3czVyS3lBL09URmp0WmtndUJ0U0ZNeTA2?=
 =?utf-8?B?NEowQkg5ak0zenB4dXVJb0pyT1gxN1pOakc1aTRyaFAyY3JtNzN2NkRQbk8x?=
 =?utf-8?B?eno5YWk3dERSeTlzem1WSDFpbW9Nc1BQaDI5K3hudUkxdlBhNzdYZElOeGZX?=
 =?utf-8?B?NUZURXJIMVF3VU9xYi9ERXpVeXNWdVdhWm02Mzdsa1kvWktuR0QxVkhOZ2pH?=
 =?utf-8?B?OTdZLzhjcFFpZXkxV2ZPTHhMRmRhL3EraEw1VW83RXZvNlBhakhPTDNhTkZP?=
 =?utf-8?B?NUY5K2laY0tPampXUmxuQVB0QmZzZFRvcEtlK09HanVld2ExZnU5RUNVcW5W?=
 =?utf-8?B?WjR1cFIyYUkwOUpieThOKys1dXdLRlhZcThzcVNjV01vVXc4b1krWUpaZGpn?=
 =?utf-8?B?VXpxRGtjT2VHdzhRa29Ic2s4ODhHOE80MGZwZ2czNmFyV3JhUFRvMHRKSGZ4?=
 =?utf-8?B?NytRcDh4ckUyZS93UWEyODZQWWIxS0JTS0dvVmZZMGhTNDRuV2tMR1JEV2Jl?=
 =?utf-8?B?Snl5Z1VCTTAzSldmMXorZ1NNcHZEUkRwUTJhcFlNYVJLbVRiQTZVR1pncUdM?=
 =?utf-8?B?S0lEVkMvRDNtUG4zY2YzUGo4YzhFbk9nZTJjdFJoUXdXV2ZJNndYKzk4bENU?=
 =?utf-8?B?VkZLcURDL2RiYWNqRm9OVzU2RUlUMmowUjVMUy94MnVqdU9paXA3TWF2eGlx?=
 =?utf-8?B?QkNuM29sS2JQQkUwNDR4VE1Sa0JIdEQ1ci80VndLZmovQXBkYnduN2dMTTRC?=
 =?utf-8?B?WWFkR2R2dGtGQy9wbzhnUHJRcWxuaFkzaGViQ1NJRjFyTDg0Uk1xMjE2U2cr?=
 =?utf-8?B?Q0RyUG5HOHVLVTczSlVsTUhTOU5zN3Jtei9lTStkN0J2dzlTUnVNZzl1UmNW?=
 =?utf-8?B?U0RBU0hvL3dOZ1AxM1Q0aEROcFp0cklDUGhraUsyYkRHYXVJeUxuM011RVd5?=
 =?utf-8?B?UWlzVHhIMXAxeDNlMGwxUmxXNC9HMWlLKzM0SzhrWnV4Ymdhc3VKZUNQeStD?=
 =?utf-8?B?WllVdmNwMmw2OC8ydmo4TG5WK2dHaC9iZGg5T2dhaGhpeGU5RUlsUHl2UUdT?=
 =?utf-8?B?VURWalUrNjUwWUVYOXFSb3BMYkdmdEJ5aFBUdXBvZVhZTXRHU3QzaXZuU0VI?=
 =?utf-8?B?Vy9mRE5nR3NPMldpQnpCSTRvRUd4ZlUxZDJsTDdlQ1VRcGM1aHFRb3VpWWNV?=
 =?utf-8?B?U0x4MVlPZmNDbTEwYUs3b0tQUzVCWFo1bVhtNFczL2lkTTZBMFJGb0MxdCsx?=
 =?utf-8?B?U05Ga01DODErOFRYL2t1dFBCM0dPZEJkckg2MUIzN1diVnRrc2FhS05RPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0t5dFNZUFJRR3FzVWJTNzZOeXFFK3JhTmtwTmhrOWI0cFdRdDVtbXNsSVZj?=
 =?utf-8?B?OU5OTnIzN1ZDVmRSRmNrYVRnNTRzR2dWSzJ0b3RuRUR4WHpYdzlMN2FPSGZ3?=
 =?utf-8?B?NnlSOE10WmozQmFaK3lNUlRBNVV2dFc5MXAwVkNDQWV5NC9YM3FBK2JBV2pk?=
 =?utf-8?B?ckU2NE4ybFFsRGNQdlNmeVB0UkpJUEdKa1VWSGlsMVEvcXNibmdnNE83Ry81?=
 =?utf-8?B?ZHc4a2pubjgyb0VSdzJsZndOdWhLOGRjNi9DQit1RFc5ZFdKM3pFd1gzNEl0?=
 =?utf-8?B?T1RzclVZVG93N2pEcG9ZbDRZNUdFRkFHTVdVeHkrdFRkQ1FUakhHU28vMlRN?=
 =?utf-8?B?OVdPQlkrMU01dlpmcG5lN0dUcVFCS3lDcEVFSnhIcFlacFBDVmZScU1CQVFF?=
 =?utf-8?B?UWR6VVg3OCt6ZTUvdlQyK0ZWaUZEYUViNFU4YUxBelgzNXYyaDZCRGloNzJo?=
 =?utf-8?B?RUk2M0dTOVFGRDhqeGlJOTR1YjI2cVhBWFR6eVJaaHRaNHN4SDQxUm4wa1lJ?=
 =?utf-8?B?aWgrVEpCeXR4UEozbmZsdnE5QTgrR3poT1JWU0tneEcvdHp0L3kxVlorTjBU?=
 =?utf-8?B?MzhNKy8ybnFWTm4vaXFpTUl0MGxMSW82NnlhcVJNYnllaVRqY0VwZVVXQnFm?=
 =?utf-8?B?NSs3cWE0bGFQZmpISysvb1dDaFRBOWcxOVVJbnk4UCtKM2tJcmVBQnFRKzMv?=
 =?utf-8?B?YnpnV212c3lveUZvNVVraWNid09sblV1YjVYQzFtRzFra0hFblJhWGdaR0Rm?=
 =?utf-8?B?dndVWXplUmhIUGthb3ExNHZac0xQYVdLT0hIb2F2dWpJQkpOdGJGZTE4QlRk?=
 =?utf-8?B?eTFhVmJzdGJnUGd5bG1QbkFLWVp1bXNqczk3UERLR3Z4U29wWlJFZkh1cUwx?=
 =?utf-8?B?UGNZaGpZd0dhaEZpZUJ1S3U3bkJzbVRiMjdNT2hhS21PRnJuWUdpaHcvV2hX?=
 =?utf-8?B?TC9HOGMveWpGUFRrOVRuZFBnZVB6NWFNdXpxaWVTS001blI3N1dxRmQ4WGZ4?=
 =?utf-8?B?WVJJUTJBeTJTOG5zTS9JMlNVQmxQYU5SQ1h0ZFN4NUNGOWZZOWJMalE4c05D?=
 =?utf-8?B?RXFKczhOcFZHRzhkR2oweVRNZ2pZRVh2NUtFc3JlWDhRQ3g2a1gvTXF1MkZU?=
 =?utf-8?B?eGtuYm1RMkovWnZkY3p0R056bkNPekx3d2w3cHE1d0dlUU1keFVka1VBZnNK?=
 =?utf-8?B?TEJEMW1Ea2hOVC8rVnpOT1U4MSt3dGp5c21yYmdVOUZWbldzTmQ1ZlhYNWRL?=
 =?utf-8?B?UVFwQnl4Ni9aU01kYmRjZVVCeDdrbElXMXZvUTVUVSsvZUUwcDdoVFA1ekhB?=
 =?utf-8?B?RjArdlBaREwxdERjVDZlTDg4SXNweGlva1IyYVpjRDdyOXlORE5WcnNMNEtY?=
 =?utf-8?B?RW1UdFFObllvK0EvMmgvc21KVkloUUhvOS82VEkvZG01L1UyZUttd0NidFR5?=
 =?utf-8?B?T2NyUmNnZWhDdnAwNzlQSEgwQjk0T2JGM2xzc0U5ODVmZU5paTd4ZkxKWnJi?=
 =?utf-8?B?MjFpTWxjWWNRVHJGWU83ZEZnYTNPZGIvME9IK3ArZ2xIc01pSVlmM3pCQzhC?=
 =?utf-8?B?MzVDSDBlRGplNXFBelpKMnVXTnluM3h3NHBpZXBjdHFzOGlsd0xmTUJaRDl1?=
 =?utf-8?B?MWdZT0hJOUdhckFWeXJ1M2srNExaQWRqcWtGdmFSV3lFWGlKWnNjemxYWkVk?=
 =?utf-8?B?cXJXVHJ1TVR2R2hWZGtTd3BOZHRQLzROdUtXeG13MnpXYytsYUpWbk5lSlFF?=
 =?utf-8?B?UjJZOHIrTGt1RzZYd29ERlg5SHVyaHNOZVp4SDZKZTc3U09iczBUaFNyOFBx?=
 =?utf-8?B?emg4SUdxSTdnSWVjZ1FEcHRyTW0wZWVmaEpmTGJVK0NnczdZTS8yT3VIUWhs?=
 =?utf-8?B?TktvVDZlOHZhc200N3BaaDV6V01NRzczNG1WejljdXpZMGJtaDZSMlVDbHFm?=
 =?utf-8?B?aGdXQ3h1YTh1b3l0emszN0FjNDc4amNpRHRtWERycnhhdWdrbld5QUNBY0Jk?=
 =?utf-8?B?RU1KZ1kxeFRYb2pRSi96Ujk4RVVza3Z3eHM4V3ZyR0dUTm9TZjRzTVJaZFU5?=
 =?utf-8?B?ZFpid3habE1JZ3l5TGJ3WWtCUGNLd2RuZTBXZHYzcHdkK05yeE12akwxQ1p4?=
 =?utf-8?Q?BAC0+lKyd8odCFGZCR0Kzh5zj?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f8352b-da8b-4e92-a115-08dce759e8aa
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 05:27:32.2436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Id+TheEYbnj1JKjzBJy9oxuEDV5hF2woZbiw6U3nsX2VQAGK8eqAmAh/x0qPHkizrHsqr/B1CaLViV9lmvnGBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8237

From: Jan Kiszka <jan.kiszka@siemens.com>

We cannot rely on the lostage_wakeup work being scheduled only
synchronously over the CPU of the relaxing thread. It thread might have
a CPU migration and other wakeup events pending and resume on different
CPU. As the lostage_wakeup work is currently on the stack, it can become
corrupt when xnthread_relax leaves earlier on the new CPU than the work
was processed on the old one - ugly crashes ahead as seen in [1].

Analogously to the signal wakeups, move the relax work into the xnthread
structure to avoid such corruptions. We intentionally refrain from
using irq_work_sync in the relaxation exit path to avoid starting to
wait a CPU that is already busy again with a lengthy RT task.

[1] https://lore.kernel.org/xenomai/770b1e4bc42cfa1ba5f4f37cc854956f3e78bb60.camel@siemens.com/T/#t

Backport of 95ccd795ec5db6c2d4d867b0f29fae964cffcf82, only affecting
dovetail kernels, I-pipe copies the work message.

Reported-by: JerryJun <jerryjun123@163.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/thread.h |  6 ++++++
 kernel/cobalt/thread.c         | 17 ++++++-----------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/cobalt/kernel/thread.h b/include/cobalt/kernel/thread.h
index b79cb84296..325859b6a4 100644
--- a/include/cobalt/kernel/thread.h
+++ b/include/cobalt/kernel/thread.h
@@ -65,6 +65,11 @@ struct lostage_signal {
 	struct lostage_signal *self; /* Revisit: I-pipe requirement */
 };
 
+struct lostage_wakeup {
+	struct pipeline_inband_work inband_work; /* Must be first. */
+	struct task_struct *task;
+};
+
 struct xnthread_init_attr {
 	struct xnthread_personality *personality;
 	cpumask_t affinity;
@@ -215,6 +220,7 @@ struct xnthread {
 	u32 proghash;		/* Hash value for exe_path */
 #endif
 	struct lostage_signal sigarray[XNTHREAD_MAX_SIGNALS];
+	struct lostage_wakeup relax_work;
 };
 
 static inline int xnthread_get_state(const struct xnthread *thread)
diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index ff12f288ad..343f1f0e09 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -1967,11 +1967,6 @@ int xnthread_harden(void)
 }
 EXPORT_SYMBOL_GPL(xnthread_harden);
 
-struct lostage_wakeup {
-	struct pipeline_inband_work inband_work; /* Must be first. */
-	struct task_struct *task;
-};
-
 static void lostage_task_wakeup(struct pipeline_inband_work *inband_work)
 {
 	struct lostage_wakeup *rq;
@@ -2045,11 +2040,6 @@ void __xnthread_propagate_schedparam(struct xnthread *curr)
 void xnthread_relax(int notify, int reason)
 {
 	struct task_struct *p = current;
-	struct lostage_wakeup wakework = {
-		.inband_work = PIPELINE_INBAND_WORK_INITIALIZER(wakework,
-					lostage_task_wakeup),
-		.task = p,
-	};
 	struct xnthread *thread = xnthread_current();
 	int cpu __maybe_unused, suspension;
 	kernel_siginfo_t si;
@@ -2063,6 +2053,11 @@ void xnthread_relax(int notify, int reason)
 	 */
 	trace_cobalt_shadow_gorelax(reason);
 
+	thread->relax_work.inband_work = (struct pipeline_inband_work)
+		PIPELINE_INBAND_WORK_INITIALIZER(thread->relax_work,
+						 lostage_task_wakeup);
+	thread->relax_work.task = p;
+
 	/*
 	 * If you intend to change the following interrupt-free
 	 * sequence, /first/ make sure to check the special handling
@@ -2075,7 +2070,7 @@ void xnthread_relax(int notify, int reason)
 	 */
 	splmax();
 	trace_cobalt_lostage_request("wakeup", p);
-	pipeline_post_inband_work(&wakework);
+	pipeline_post_inband_work(&thread->relax_work);
 	/*
 	 * Grab the nklock to synchronize the Linux task state
 	 * manipulation with handle_sigwake_event. This lock will be
-- 
2.43.0
