Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011071.outbound.protection.outlook.com [52.101.65.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CF230EF92
	for <xenomai@lists.linux.dev>; Thu, 23 Apr 2026 15:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776957365; cv=fail; b=DMMm7oCnyiQP7WBK7IxM7fzwIV2qurfzJGZo6WToWjc/6Oa7oK8ryJUFMpDm7HaWwfVRBCaC+vvRolkEYgugd1Um12IvHsodTBUDONKSzdN6gQD2OoO0X74A4G2oyo05HeXszVWnGSRzapKKT0WU6+EI8bzWVOblg5ORLNSEFKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776957365; c=relaxed/simple;
	bh=puUN/BQSuxBUIQ/CqHu4/qDZaz6I557QnoHzDSNi0CM=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=hVwQyyZAlnzhIIG/g5ZARLUtLidQyRcp3fLBOMW6nZCd8DxSuQytphZNvqLeJhuC0mvv6a+ufkm5q3EcGhGBPtH0CyaFfkNwgRMHV8Jt+c1gIvalXHIMWS+s3grKeyy88cjH8THxBDDsHD9CXtRalaft0yUi6WFeO0wNSReioAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=rJv1sczL; arc=fail smtp.client-ip=52.101.65.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="rJv1sczL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KhuF7KceC6zCWVRLBahfQ1zfo/Nf8YIGeVReGy8caNR2BuvW6YFqq/OzzVoavJsfSiM/zTvn2HhNGmEcGV/rsnlyqRQP133C83sSDNXbyIxXJ5rRLBM1tflqq+68vB5/FOH1GJcQLveRiNhRKNFa7hCCh7tNiRDlcaU+QBtM87qmixpo3a9OoIosJEw7m0Mv813IryWZIMK3rI6tV3eVPYrwWtZBtrTQtFN7oSzulkYo+zRKSyO4M8lxFqRBM+mj/ncDSsCkQ1wF5UIgPDfOs4Q/vI6sgP3nbFvGYA+l7W+/gHmBDgTnoeO9v/b8K5GQ92ehgLThzTPB0zdtF6G5HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjQlxQ+Cj0kZXwLqB3tsuUsZPTdcnlNULXkaz5vxNMU=;
 b=DBoa3z5z8wjLB3+kXN+x76p6Fr4Flxy19Eue2/WoxlFlucR3SEW+blS1z1kTKmPRgeBx6tZJ0CorVPJ+OWWdf8ybRzL09UCbfLC6kzO5Cim5whEBZSZGVynJaXo2iPB1CHVfa4wzLrQToE8gNhqUY99NPO0khyY2mZDVZzPxLfVpK0PjdflA7JauXtnXEQI2Iit1+BHHkUGZ0+xAJhljN4IEHWp+xaHnyKnF6h+0rcIL1xMGyc5i4/Gii4Geu9UjItIs0Zr+Qy6XP3NRaPKNgppRQEX+GKhL6yCkvdE0dkSkM0xZOpJgphFa5NBhEJxCmHvokYSGPshyCY7z2uUmGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjQlxQ+Cj0kZXwLqB3tsuUsZPTdcnlNULXkaz5vxNMU=;
 b=rJv1sczLnikIL1s7F/FShOWdT5U5aGDu8fCHwG11RSfgLqH9BQOHBdbSM2N2/PZvFA9DVyCrcQ0vfqdkMzmMmTbELo4GJOcSOSzb9n4Vd55kOSDMHa8kCRrzUHGCj2l56mmaPoUD8//QeMNOrnx5W03nEpy/gsAVnv50XlGgyTJgf7tPi6uNbAZPWIPB5X6/wNbNdRkeYg2hzI8z1D3PHshVrH+yKI5F2jwQTa+l1NXowq592d2aJB7Tp0LNEdk3cLtLZnIbhLL/1T9AA7RHDKJAj01JdhXa0YEUAzEJlXf51NVOJM4qQroxNuFXlJTj1q+/QdFC90dUwVzez8eIRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5363.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Thu, 23 Apr
 2026 15:15:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 15:15:59 +0000
Message-ID: <c5800fdd-7638-4136-bc95-7c3be6922a97@siemens.com>
Date: Thu, 23 Apr 2026 17:15:58 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH stable/v3.2.x] cobalt/ipipe: Perform host_pid initialization
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0068.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cc::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5363:EE_
X-MS-Office365-Filtering-Correlation-Id: d78a1cd5-7786-482a-08dd-08dea14b39b4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	tveGeisupToKB8Oka4Fp59LhGy0m7KaB0KcIxmOHZxV9eW2lVAEH3ZBgA5cta1OgqNzNgHQ4ggGjbhIw/dI/34lzeAYY02cYOpxEC7rCOVkiBxcPN0O3uyJRb+dddhCYpls/YOf8o8yBRncgV2sVFbhpCX/YQnJbYrs0kJds7BG7qlLYKXLZzVBhn/MhKfUi3kufP8iqCVHpHX0CykjVtWOoPXOgO/Vg1vzHSKLjzRsXvJZsoa/GTNhkyKnPm6H6Xx21Zhdwd93X0Rjnk9GJMQzyd9rOpPvZvGdbvHzAx+3V28/6kEJm7eLJWWqR3CM76aXu3V5WzVAurc2ws6okbq8467gXca6RjRB0CDKdKyhAs+9tnTU/tRqDnDcw6IgcJidjGlWlyh7lCb05T8YL2FtN3cdHSm3KwbH7DOMvIe3uLScQeUMjbGJ6Rsu7d92zOAjolqSbu7uNIGFujTA6w7AyraUROOHqcNzOue44q5M4fJ46ataNHWUSTqdmgBbhrIiwTIThtkSr+Hr+wWJxE8+t6hrVt0EYlpcXp7dEP6CF7dXknqXgf/+OhlCPYKS+gh5u4ZnVvRaz6aMoNSwSTMm/VALSjkzSxv81miwv6rC+PEOvTPKhSwzNGUGLkJlX1MboQomFi7cTDuIEc9SBb3ZbbxdG5ON3W2wkXfAHnZG+0KCFTQOqbTFKRZ8d6i/2hndI6PSA2zAc163iiJcPJ+HGdWW0pqYCfQJ7+KarXqc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEQ0d1p1ckEzV1FWbnVkcUh2WjV5U2hYd2FsMTk5WlJjdTd4dml4dFhNNnpv?=
 =?utf-8?B?ZFR6ajhWWmFtN2pCUTRybVNPMkNnZEVVemtLN2t3cDhNQ3Y2bzFoZVdDSHFT?=
 =?utf-8?B?TVVCcC9YZzAySllVSS9XRGJCNHIyRjdRVUpiR3dPTjJMMmVYSStoOWQxYWU4?=
 =?utf-8?B?a05PYStjbTdTQ3VqV0xwR2RkSDVrNHlkbWF2TGp2NUJSOFp5amorRUN0a3Vi?=
 =?utf-8?B?eVl3M29jOFpBNk5MZ3dScEw4RXppaW1RbjhVdEViSFFOT3pVUC9jRkRzMkJT?=
 =?utf-8?B?LzF3VEZlTlR4dkxpdlNIQkVPOE9BQ1FFSzFiaDhNbmtJWUJaeE1uZG02am5E?=
 =?utf-8?B?ZE1UWWxpbUh0Ym9MZ0R5ZmNHT1hnUHdLZ1NmZnZBRjNLTkgxL2paWlB6YUF2?=
 =?utf-8?B?TzBleHVlZnc4bEkrQ3pVNVQveXhrZmxZYXdUVSt6QkdFRy95cGZiSFd0WVZQ?=
 =?utf-8?B?a2VZWTZacW5maVZnSG5vdmRiTFl6c1grY3NxckhyMDlqVWlORW41WDRtZVRS?=
 =?utf-8?B?Y3FPM1Z0NkprbVFlK2ZSZWhqNDE1Tk1QQlpzdTZ6NUtvWWJCL1JNeDVnUXVW?=
 =?utf-8?B?Mkt1VzBnK1doaWU5MHpzS2NES3BCNTdsb1NhVkdLbEhWbXNtOE83akhPN0Ur?=
 =?utf-8?B?UXdLRmRJc2NIVXY5MmVLZHk3dE44VnlZWFNBNSszQnpCVytZK1FHRTNINjlz?=
 =?utf-8?B?dWk1MUdZaDV0ZzlwMnZ3NTlIWkN3MU95RkpzODh3WEZZbVhEejFlS05KN0VR?=
 =?utf-8?B?QlJmSHM3NXBHTzV6Q0VuYmJub2tnZ2hpeWFURDZvWmZ6YkV5WG1MRTRYanNk?=
 =?utf-8?B?ajBiTHA5RzFqL2tjMWJmdGs5VHhxMTFQZWZlZEh2SHNneDZ1cXNrNG1XMFBT?=
 =?utf-8?B?cDNzMVlUWjIzOWpzZEc5amsxSXd0ZWY5ZU1lSC9RdmxLTC9FQW1PcUs4MmFI?=
 =?utf-8?B?WWNzT1dLYkY3amJvRjhteWVmRWlXY1MzQVJ1RHR6c1R6aHZRZDlWRFgyR1dm?=
 =?utf-8?B?NkdRdjBZU3NnTUlDeEQ2N0NiS3pXNXlKZUI3dGpxYU10aHdGaVpOOXNuVmpM?=
 =?utf-8?B?S0owRWY4VU45YnVXaU1Vb2xJWExhZzhFMGtXd2wvckVjUVJvQ3MxVCtMNk11?=
 =?utf-8?B?TmtGc1dmYjNIdktOYjhEZTJGcFdFSklFWExuc0ZzR01FSkt2amNmOE9lLy9x?=
 =?utf-8?B?K1VwdUdXVWs5YnNNemcycG9SMXhSZnpJVzBzbEdlbHpsVlRReElJbnlpL0E1?=
 =?utf-8?B?MFlqVm9XUHNSOUp2aWVFSVRNMWE4RGlESDI2ZXk4UHh6dFFsakU5TG5OT1k4?=
 =?utf-8?B?bHFNc3Erejl4WVlBeXBXcFBJRHQyYm5rdjQxM09Cb3dnUVhtbDVKZjhzcE9o?=
 =?utf-8?B?aXA5WWw5cXlhVEFTcWxWa3JKcXZGNSs2YitYWXI0L2FZNi8yQ0FNZStSY0ZL?=
 =?utf-8?B?ZXE0akpSVE9iV1l0MUJNQW52ZVVER0NzMDFmcFNiYTRuZTdkSGZIb1lIVFdp?=
 =?utf-8?B?bmtVeDV5cVYwYkg5enR4SE1TVVdjSkh3Q0Z5aEtXVXkzZWo2Z3FPdEVDbW1N?=
 =?utf-8?B?MFZaRkJwOWlCNXRmdEhVZHpsdU0yUEhqYTFDTEtWVnU5dWdFTEZ6ckttM3U1?=
 =?utf-8?B?L0JVNlZTbTIwcEY1QkVCNkh0TGJDbk9kR2I4MFlMd1VZSUZheFVzdTBITU9v?=
 =?utf-8?B?RTc2UlJOZXdYbm4vREIrVGQ0YjZhQ3Q1MHRMbmNmb3gycHJUaURQZ2UwbmJx?=
 =?utf-8?B?bEQrWjA1S0NwcXpWVzkyeEtRcVdMYzhNNDZXdUY3YTdMQ2JXRlFwQTNGeWxQ?=
 =?utf-8?B?RDk0TmR2djNnQ0R0ZHZBZm5zSkRvb0hUOUFpVVFRaTJ2bE9mN2U5M25QUm9x?=
 =?utf-8?B?OEdteGlYVFJJUDMxcVoxRk96cDRwZWsyODdMWVJwdHFPQUIyVENCNUxKY1NW?=
 =?utf-8?B?bXRXRElzVlNJSjA5ZFh1Nk9Edi9HOEZjVGR4RTNvY0FFZDIvTldtU3FUOHF1?=
 =?utf-8?B?d2laSG9HYmtQMG91WjZiSzJKakFUSFdBaFg5WVJYaVBoVHg5OU13Z0h5N2lG?=
 =?utf-8?B?OWR4MkJpWDdMNnhwYXg4Y0h5QzU4MDR6alBKYWJVdU1PY1FzdC9UOWloSFpY?=
 =?utf-8?B?dlpPT0hhVzZhVEEwYmtMUlgzRDNkWmhHMURtcld4Zlk5SEZnWXBXdWlnTFg1?=
 =?utf-8?B?RXZRZXpQQ2RWelVJdkFoaUI4UUJxSnRMb3dJSjFBbis0TSsxT3hLWWRvaDJD?=
 =?utf-8?B?Nm43LzA1eWpwVHI5c0hkaHZwYkg0bGNuUGpRTnlMckR5ZTN4RFZLaSs4bWQ5?=
 =?utf-8?B?ZUZueGxyN01WVW5VLzdBK2tQdWNhNWlxUzRLc2xOTjNDMnNaN29vdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d78a1cd5-7786-482a-08dd-08dea14b39b4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 15:15:59.8017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5q9Phhli5/yfBtDCfvBwg/wv6ofD1p8xq/0gE75LiiTABuMZ6FK7UFAMTIzhmVHS4zfW2Ohv+lQ+nxwOgf9ZgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5363

From: Jan Kiszka <jan.kiszka@siemens.com>

Add the requires initialization of host_pid to the ipipe versions of
pipeline_init_*_tcb. Those were missing in the original patch as it was
developed against the dovetail-only head.

Fixes: 04bdfae691ab (backport of "cobalt/thread: Keep host task PID in xnthread struct as well")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

I've picked that upstream commit also for 3.2 - and ran into this gab. 
Pipeline green now again, but I wanted to share for transparency.

 kernel/cobalt/ipipe/sched.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/cobalt/ipipe/sched.c b/kernel/cobalt/ipipe/sched.c
index 3104e50156..8ce1ccf16c 100644
--- a/kernel/cobalt/ipipe/sched.c
+++ b/kernel/cobalt/ipipe/sched.c
@@ -121,6 +121,7 @@ void pipeline_init_shadow_tcb(struct xnthread *thread)
 	tcb->core.user_fpu_owner = p;
 #endif /* CONFIG_XENO_ARCH_FPU */
 	xnarch_init_shadow_tcb(thread);
+	thread->host_pid = task_pid_nr(xnthread_host_task(thread));
 
 	trace_cobalt_shadow_map(thread);
 }
@@ -135,6 +136,7 @@ void pipeline_init_root_tcb(struct xnthread *thread)
 	tcb->core.mm = p->mm;
 	tcb->core.tip = NULL;
 	xnarch_init_root_tcb(thread);
+	thread->host_pid = 0;
 }
 
 int pipeline_leave_inband(void)
-- 
2.47.3
