Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010060.outbound.protection.outlook.com [52.101.84.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6069935AC16
	for <xenomai@lists.linux.dev>; Fri, 24 Apr 2026 10:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777026507; cv=fail; b=RUtyYPjBCtSSjKUgKixYVItrb4snTfPnYkKHo0xOigOchCX94bJIGyXNEl5MUD1AghaQw0mz2/JLsE2lr1XL92FXGcg/+kzbzfdMqaGkjElRTVh+tANrjSJqhFjZRY0R42qf/F+Vyq0Gar1+hIbkHqyQR13PyHy7I83lRz+1L5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777026507; c=relaxed/simple;
	bh=JHvtCichUaX3fZ7zsNfNwhgQb33FJ+2MQhYL2ppxp0Q=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=ntAAnbnggBUMti821lstdE8seInY7n8FIF+KutIvjLDTiiTqKChU8rcCUqghzyZV40t3Se6ccM+hW9ZfGtz4pNYuwKoaH8AGSe/Q3DsLVg9gUshwemHQthsqszFcLqIk+KNgQvtVBjRYFHZSboPWuUWnWn+avYmhE9TiQJ8roYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=sqzy3uLP; arc=fail smtp.client-ip=52.101.84.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="sqzy3uLP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bO1R/+Bj6JjB5xqoSV+hhS056yl9hEqHuew3y2y24ZA5eE4EmOupcWuVAABJG9TEFtvhUGmpn5a5wAmtKy/p9HtTE0G3lUmXXqZEI4RvpEJhEGUXnNAHYoGLVfAymS5ecYidNzwXhFulPuuSy1te2Sy1ZAVlieMCs/bJNXOZSjnyBmV/pclRYD6Oxy83p67I1XioswYzYnzf1JXeFExbxdgMgpJGcK8hjgsxh/p1308PZBK6b2rIL0uzqxm6Fj0Ty0dwnYuzuJqm+Lqly5GlSvFxmL+v+yNJpMZaVfwkMaPWvYpOehqhb+lFf6xqjCisIVf5b1rtD97xrI+JRXFqjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lWvhzJ2f+ljDKW1IOLvG3akSKCNZW6XZjYX13Do2/Y=;
 b=ZG4qF9LdV2XCZns9GpHC6vQRS1rvq5RSv9meeDTXVKF5ZBZUnvwIfW8WGoiJ/tyhRFqtoxux3KZpcFk+bMQECU6HniU0vi0jO1MZdXe4pCze+hmVsqN2/BseRwHp5kjXNvsixAXC+Oo4u+BXnzIAhoTjQbq9sAtkeEmZmYD8C18MPxe3oXNAokJ1i61B203vYNLZTxUgjL5PetoDy1yqfxRc+VZI6TQZNA4Jnpkphf5HFS93QD86UAp/nd3NBjYkG+i4Z5xBnEZh1jFC1fFAPXKqBnKIzeZsYfZaRNUaWPH8vrJ7YdVNKEysOa41YASAYHq//u366MI9RNH7NR6p8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lWvhzJ2f+ljDKW1IOLvG3akSKCNZW6XZjYX13Do2/Y=;
 b=sqzy3uLPmvJYjvVuKkCji/HIVo2P7agf05aDLbt1yuUPGAaKM1SpVbIIXI+r6TvvGDG3Yqddbwz+dRTkoXKFYdxbSWKUPNSBrvhaTvrrh6CEjO418cxPL5akVxWPbDHS+0yN2K4EQvYLsK5zooo3xhXlu8HngbX4ttftkX6H8mdyRIXTH7u6DmRyNzfUeJ9ZizlGEVsLvVBeyOePjP1vfVjda+N9WBf8yqoyNxgD56p/CvHGGfh/shMu9OoLw+UA9JA0B2SKzhgb214hwHj/iDVs/lvuzacArl4Te/uoSI2yOP4/OVgErMUmDY9geYcHylmg8npa1FKE+J75GL6oWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5258.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:33c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Fri, 24 Apr
 2026 10:28:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 10:28:23 +0000
Message-ID: <12f73c9f-9fec-4d8e-86b3-367dfcc6fff2@siemens.com>
Date: Fri, 24 Apr 2026 12:28:22 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] Xenomai 3.3.3 released
To: Xenomai <xenomai@lists.linux.dev>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5258:EE_
X-MS-Office365-Filtering-Correlation-Id: fdebfd69-f5d3-48ee-498d-08dea1ec36a3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	LLVmCWecN8KH5kheoqIhHONKN4ImxFDxuUOkEFxVMpe+hv43/YTKm0KhxSYMWFaU/f02fZUTvhUwA1hi29A3e+99mLRtvmRcIRIUx4+21DnHGu42ub6XQGNeZz+iIP13BAie+R2XXPtO4JHc/boCjiOQMAaZEsCaedLG3w+NhTrlnCnZwjHDGpnnALwCbo4pxQc4KVHfFthSBQCx1NV6yKfWFf4mxFyJ5Ha0LoDRNSKxwvkvnbtX5k3tbzDZvkQ0SttlXmvtO9K7tZg0sWM6zQDwlZ9HFpaGJ5CW5YHILGgSJEC0rITcDFYGqtUmo9E62lqCGezqXH/kL8CPvdwHDUlUNxKP01Kwrh2h8YH7yc9cbpC96l9RNSegkqVbpRBPOxISme9ZmIRs2xPYetKzsZJ1klEvuJE8h5Z0JOYHAShMf0j9xgRn69IdBdDI0cRqZL3f7d4CKfoIVbsT+G1SPzeE9P4hjSF0UEqOKLCY3d0eN3KRb1dqnOu01uoPQsEKeanNO8H4A+Cd2cz5lYjRq3bnJW+ojJgY/u3qNJ+SKSFuvaEuHuUNXHjXFKiUbuWMa72AuTrNVG4n3D9/VJ4LpxI0CQBY6ZbSvnZUHoFIB67ob4qDcNA+n5t1cJYUBO857kuQt0MHMW2EjHYwsnNNDMbLYndE+p/NJkTbPH58qZ8s2kGX7uuusIw/NV0dPRVF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVNyU3FkcTNpYXBBTjY2T1dTSVhGV0F6SHVaWGtmdktZUWJEbUkycVVsTkhO?=
 =?utf-8?B?bUlreUNoQVhaRVVCZUZrUXVsSHJQRWJOd3d3TVA5cEg0OWRCdzlNRVZqWHZJ?=
 =?utf-8?B?dHNtUzBTcTcwOVorSFlEMEgzbFpMdUs2RXVXTTVJMWkxMW5BQjJsNDNwT00x?=
 =?utf-8?B?aTd0UFF2SEhybDV4L2lhcHZ3UEpwdGdkTFVTK0E3Nm1nenNybm9FSWU0WmFo?=
 =?utf-8?B?UzJnY240NUdkWDZDWjA1dHdsMm9OdHR6VlBPMER2OFBsQytpMXNoZ2xHZWVS?=
 =?utf-8?B?cE9KOWU1OUZITFZScENXOVVkVnFpd29MbVpETmd4YmtLcjEyaGxGOFl0eTZM?=
 =?utf-8?B?bERXVXRvQmQ1RitzM3ptM0djWVpjOFFaQXFjZ0JrVEFnZHU4aklFZ25hdWgw?=
 =?utf-8?B?RVJWQmxjYXAvR1l0Q05ES0dIMjQrajdrbUUyZ0VPTGdhaWdESXEra1c4RE81?=
 =?utf-8?B?eW9tMGEvY0w3UkxqcEM0Z29PTDhGUWk1ZENUQnhaVGx2cFlGSE9sSE0yTStx?=
 =?utf-8?B?RGJLL3hqQy9QdkxhL3NZQzZvVTREVTcvSnRuZ1I1cW1zWjRvdjdta1RFMWU0?=
 =?utf-8?B?NndzVHhGZ1M0QzhyeUVDYjkwTEttbHIxNzVCQXhzeVdlRGpXVDJFekphUlBh?=
 =?utf-8?B?NTBJbllNaEdVYUYwQ2xJRDB5UlJocTFNYTQvSzlTalIreXZ3QUIxdGtUYTBY?=
 =?utf-8?B?Q0lmM3RQOXpiUWdMUzJQaFNhZ3BFaEViMmUrUnk0QlRYSXJUKzRKVkcvQ0sw?=
 =?utf-8?B?ekI5MDNkWUM4TkxjbUljVmJiSUY4RG9KdDArRlNWUkhWZ0dCd1pUYmx1QmxG?=
 =?utf-8?B?UlJuV055OWF6empBRUVhWjQyT1dJdWtReG9KSlZXc1dSSWE0VXBsdkFHeGlC?=
 =?utf-8?B?bFNBUDFFdndDNTF3aFNWMmhNQ0U1U3RmNkJuY1BiWndKcWdxeURjMGhrYm5S?=
 =?utf-8?B?eDZ3L1g4dUlYbVZPRjBzbHFBcnJLc3FGcXN6TDNSQWg0Zmt3N2pWZlFSWHg2?=
 =?utf-8?B?SDJzVWdFTS9nVVlGaU8yTmR0M3B5eDM2QXZNaDgrcXc5V2Q3S1QyRzFmK1RK?=
 =?utf-8?B?UUJVbldTc3oxTUVTVEtkUTVialQvajhVS0FnU295OUk4RTBTdS95R2RyTXNT?=
 =?utf-8?B?cG9MWlk2N2ZQRGdDdmhScGhTZy8yTFgwUmpSL2FjcXJKMFkyR0xHNTFYZkw4?=
 =?utf-8?B?SklGeDJiQVJYNXNzeTVrbFF5M0RYNEpwMDBLN1FrL3JoMUwydW5xZTZUUXU4?=
 =?utf-8?B?MExBUXc2VDhaTTUwZGI4VjM1N3F5S05nQ2JBQnlnYmdRT25hQkZPclplemd0?=
 =?utf-8?B?SG1mSS81eFhqNjRjWVFpQldUNGFSZTNiUTNYSHJyVDRFUm5WNVBDM1BTWnBV?=
 =?utf-8?B?YkpidGd0ejRxUGxhQjBPN0gxSHhBUjU3bkxrTmN4Z2hET1hIT1gxVUFTM2h0?=
 =?utf-8?B?SHJ5b294Ky9LL2lyUmlyZ2tnYW5ybWcwZjJHZU0rdkpadExrYlRDY0pLSUMz?=
 =?utf-8?B?TisxaFN3Q3JlaVB2Ykw3bi9sSVBFZGFVK0tWWGNMMzJhNm1nYXBEK0dvWkxR?=
 =?utf-8?B?YzhlVTQzRDcrOElwMWtKTW9Wc0tDSXpkVkJSNk10dk95SmlMOTZPNnp1R2o4?=
 =?utf-8?B?NkNkcko2ZFI3YklJL2dtUXE2NEEwWlhrbGZXV2h4S0ZRQXBpV3BOVEM0S0tu?=
 =?utf-8?B?bW8xOWV1MHhIRGZLOHcyMXRlUW5pN1I5NzZPVFB5WFZ3dDlyMWY5eCt5NzRv?=
 =?utf-8?B?L1h5T0E0cDVDZnpZUUJacTZqSTQ0OEgwZGtFV1hYeloybGZoTTkyNFM3ZWhL?=
 =?utf-8?B?eUM0aW5SQjhyZy9Pb0NzY1BqODBuRmZNQzZVV2t1ZmdZd1NVdU9nT3RyQk9H?=
 =?utf-8?B?d2dLQ2FVeHZ0MU1yVHJFbGMwcGF2bEkxOUJucnNUWlNrRFh1WlZ2Y1lUd0ov?=
 =?utf-8?B?MER3TEd2R1RlQ3N3WVpxR0RTVHJpc2w4UmZiaWs5WEcrSjNZMDJjVWQ5bFpm?=
 =?utf-8?B?WHFzcUtZZkFnenZtcUdSQ2hDcWJyTjEwYUJOTHVtdjdQYjRqL0dQZ0YxckdW?=
 =?utf-8?B?YWdXOSt0Wm1VMWpNa2NWNWlRL0d3VVdOb1RiVHFlOWtTWjl1WHBWQnVzRXds?=
 =?utf-8?B?TmFDM0l1MlhncnBCbStjWHV4QlVxVWwxOWNSYXNjSnhDSE5vNnZGaFhsbHdP?=
 =?utf-8?B?ZVFpcEpIOVpBZTRvQW5QcWdna1p0MEthcEdVZlowNWxSS1BKRVYrV2JzNk1K?=
 =?utf-8?B?RnRPTFRJanFwRjJaZXhjcXo5OGRTZ1VwUVlqTzRydEhIRGdiSm5FR3o5WmJY?=
 =?utf-8?B?YTNmSEI0Mi9oME1YUTJIWERMRW40Ni8vbHl6bzdXY0xaM2xFcjFBUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdebfd69-f5d3-48ee-498d-08dea1ec36a3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 10:28:23.5629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S8iRy9xwux42Igy1Cb4QyStV6FNd8z6eGLVFsJyKQgaBVm9+00o9xMidSFL0vV7FW6st/FrKvv4WCkgC/xHGMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5258

This is a smaller stable update for 3.3. Still it contains a couple of 
corner-case fixes, so it might be worth to check the list below.

Download: https://gitlab.com/Xenomai/xenomai3/xenomai/-/archive/v3.3.3/xenomai-v3.3.3.tar.bz2

Changes since 3.3.2:

Florian Bezdeka (2):
      y2038: lib/cobalt: select: Normalize timeout value in the y2038 case
      y2038: lib/cobalt: select: Fix timeout writeback of the compat time64_t case

Hannes Diethelm (1):
      drivers/net/stack: Migrate struct rt_proc_call to flexible array member

Jan Kiszka (11):
      lib/cobalt: Update vdso parser to latest Linux version
      testsuite/smokey/alchemytests: Make task-2 test more robust
      arm: fptest: Ensure that fp_regs_set/check functions are truly inline
      lib/cobalt: arm: Skip SIGSHADOW_ACTION_BACKTRACE over asynchronous signals
      testsuite/smokey/sched-quota: Make workload more predictable
      alchemy/task: Initialize thread handle on rt_task_bind
      alchemy/task: Match thread handle on task lookup as well
      README: Drop reference to no longer existing arch READMEs
      cobalt/thread: Keep host task PID in xnthread struct as well
      ci: Define our trigger source for downstream
      config: Bump version number

Markus Kurz (3):
      docs(xeno3): change to client-side search
      docs(xeno3): adjust the size of the search bar
      docs(xeno3): fix warnings in doxygen build

Jan

-- 
Siemens AG, Technology
Linux Expert Center


