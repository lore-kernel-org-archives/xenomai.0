Received: from redirect.mail.gandi.net (relay13.mail.gandi.net [217.70.178.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BE51BC4E
	for <xenomai@lists.linux.dev>; Mon, 14 Jul 2025 07:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=217.70.178.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752478283; cv=fail; b=S6TADV/xMu0qPHyaKeas8yYYJigepAQnovG5U1gsyX/pYMqCPdk01GdlIgSZdmB+7gWfJ+vsU94YPSl0nb/lUPlE7h96xdQvmMqmZVf4oNlD58W52fd0NnguBho09n4J/VGxCOP6AM5014qLnYG0dZga7kGz6HsmsvSGnVHd54Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752478283; c=relaxed/simple;
	bh=+zgExty+dsVFLqgXUqg6TNYPfpSZFXWeHTVzg06uN8g=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NqTAj3/OsWA7MGwql6Su7joxFbxIH1DMViNtBFdgzR55qQ1qHuG+7qhkxqqpG4NtiuhpfjIzzYdauncisA5YwG302eGvdYmEYhcVFBsO+6RRbdYsSaO5abYFRnFLdhuv+ZL/BxTs43o9wx0UW31Yhyg840aAnwIv9SlvyjN/siE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doosan.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (1024-bit key) header.d=doosan.com header.i=@doosan.com header.b=eJtfedac; arc=fail smtp.client-ip=217.70.178.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doosan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=doosan.com header.i=@doosan.com header.b="eJtfedac"
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay13.mail.gandi.net (Postfix) with ESMTPS id 4D12243CEC
	for <xenomai@lists.linux.dev>; Mon, 14 Jul 2025 07:31:12 +0000 (UTC)
Received: from PUWP216CU001.outbound.protection.outlook.com (mail-koreasouthazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c410::1])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 88FF2D80808
	for <xenomai@xenomai.org>; Mon, 14 Jul 2025 07:31:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RqqtBCDrKVBqYXWBZDhnccf7UFhJT0sBajhu1QvddqpT9SGrNUpfqevQfnJx7oJIlrMQahmhrU4LNsB0Vpniblzvx18CYqqk8AIW/QgSJZ06vJq7SSjjZ5jbMswO5RH7/0ErIL2ut9NRLMh2vVXSpx46vkKgFQgWs0wn80WqL9n8BR8rhlhOIkoklmiQb5uXtu4NaMAXhjWdt/AiL0QdQ8YtfqwClHEnPlVBVIKygdetPHMcLcwr19k20KaNPYoST+K2BmHyQ77K4OEFnb+7wZm8q56g8O34eV/PLeZazcSbKXjeyIoWcuU5gUuBkDV4oR9UEvc/jetHJf0nUSvu2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zgExty+dsVFLqgXUqg6TNYPfpSZFXWeHTVzg06uN8g=;
 b=T38WQY5MuowuD6+BLBxFtCEuiLV/mn7tR75mmyAQItVKG4M73B257Ckp90/9T3Fa3u28LMEYcUoP5vuD+5won1gB5fQXG6b9ZQidAp2VwXpNEcoZgvGLpZjYTL18nCfBEgiMCRKYl8KzByrA/wG+4Lc7HfQZBURSMR16y1Sr6zgp9x+ZWyoLFKcw4OI3CnIWD9s8iqV1kJ8VX+QTquCpccmgBB4osDiEkmYugmCiHKbEC9zXE2pjtBaee1dwPwR52dk2oz8dFLchzyqeYvVmOqUwW/iMddnPSW1XA0l918/SZoFYRDt5HR2UHQln55HKU2XRnMkPoOLifYEeOdE+dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=doosan.com; dmarc=pass action=none header.from=doosan.com;
 dkim=pass header.d=doosan.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=doosan.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zgExty+dsVFLqgXUqg6TNYPfpSZFXWeHTVzg06uN8g=;
 b=eJtfedacA9297aeR8PeLvJhq731h+0bW9pbLwRuz2ZTMbLFUQBVYnyIeMS4gaV4b1PT9Li7WTkszYiAIcoEZ02S/+YMhquxs6Z/LEU/Ak/YwaH7BiISLMjVzFx1g6RO7DBmY4CRE3GIgTbSN1EtqQhk2RcAkvJrufnHe851ZptA=
Received: from SL2P216MB1358.KORP216.PROD.OUTLOOK.COM (2603:1096:101:12::11)
 by PS2P216MB1252.KORP216.PROD.OUTLOOK.COM (2603:1096:301:98::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 07:31:04 +0000
Received: from SL2P216MB1358.KORP216.PROD.OUTLOOK.COM
 ([fe80::de2f:c36b:e7a1:6986]) by SL2P216MB1358.KORP216.PROD.OUTLOOK.COM
 ([fe80::de2f:c36b:e7a1:6986%4]) with mapi id 15.20.8922.023; Mon, 14 Jul 2025
 07:31:03 +0000
From: =?ks_c_5601-1987?B?vcW5zsO2KE1pbmNoZW9sIFNoaW4pILyxwNMgtc676rfOurjGvb26?=
	<mincheol1.shin@doosan.com>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>
Subject: rt_queue IPC Error
Thread-Topic: rt_queue IPC Error
Thread-Index: Adv0kS/vWBEHHJwaQ1afwtJNTcrLhA==
Date: Mon, 14 Jul 2025 07:31:03 +0000
Message-ID:
 <SL2P216MB1358D5259F6E62AB410BD9CBA954A@SL2P216MB1358.KORP216.PROD.OUTLOOK.COM>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2P216MB1358:EE_|PS2P216MB1252:EE_
x-ms-office365-filtering-correlation-id: 2ff10a3b-d6bc-4443-2b75-08ddc2a863b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?ks_c_5601-1987?B?eE41TGVxdGtYTzJERDMrU1IvVTlBdG9tSTBCQUV1cmw1VkhSWEdn?=
 =?ks_c_5601-1987?B?NmNaWlB3bDZvV29oVEZwamFoaGFpWHJIaGFpb3dwNXNjbXBTcGNa?=
 =?ks_c_5601-1987?B?RnVTT2N5N0l0bTFzV0lIRklsbjVXMC9nMU53MU9HdExTNWh2MmJM?=
 =?ks_c_5601-1987?B?S0hyMXIyVzJhT25XV2t2QkYzVXFkcDJVeFVmTEtFUlhhVDFITUVL?=
 =?ks_c_5601-1987?B?SXVBN1EvaG1kVWh1RERVaWl0dWlIMTJNQk1sWm9qNTJkMmFZNnVM?=
 =?ks_c_5601-1987?B?d0QvUEg5OUJVQXNTaXp3Wmd3L08yVzAwamU3dkVaWWYyL3NmYWVv?=
 =?ks_c_5601-1987?B?ZWJvYTRmNkw0WnNKM2hhUDB3c2kzV3N4Q0QyQ21xdVJ4UDU1NzJH?=
 =?ks_c_5601-1987?B?OUd6dGJNZno5aUxueWpnWjNvanJaTmtoMDlPa2R3clUxS3l5MWpq?=
 =?ks_c_5601-1987?B?b3hwNThNaFZiZjFwZ3dZY1o0OUxqSUxLODgvb0cyTWRMZURIUldF?=
 =?ks_c_5601-1987?B?a09FY3VlV0p0emhxN1F2ZHVRVFN1TFJ6cGNoVUM1V2lCTUh0UW5h?=
 =?ks_c_5601-1987?B?MlBaVUxYVmhyRXV5MTRzbDdjTVhHR0hmUmd2TGVMUFIvYlNLdUhi?=
 =?ks_c_5601-1987?B?cGlqQlVkVnNVa0pWUnRmeTQ1Qng2akZmYTZYS1lQWFVMMGxzbTRL?=
 =?ks_c_5601-1987?B?SVBmWjVibGpVQnBHZ2RuS0hlb3FoUUxzcjdHUHBiYXNZYmRaN1l0?=
 =?ks_c_5601-1987?B?cENYT3lRN280OVRJbkdpWEZaODdmZk53UlA3QllqcHdGUnJWMDR2?=
 =?ks_c_5601-1987?B?MDBSZE5GRjFYalZsSUdiVXBVWG1OVGlsdkFtOE5wZmFmOXhQRjVQ?=
 =?ks_c_5601-1987?B?b0RFSlpBS1BNVWxZWmxJQjlhR3hUMHFpbUFWdTZ4R2U5S3lic0Zs?=
 =?ks_c_5601-1987?B?VmcwSTZJL1pjSUdFeDVQOS9jbDFGOHc2SW5KQW9pVmpqUllLVmRo?=
 =?ks_c_5601-1987?B?ZUdTdzJEa3JrQTBkWUF4SVo0Y1BrdVpkV2xBSGFudE9YTi83SFBF?=
 =?ks_c_5601-1987?B?cGJ2d3RKMTVlSS9Yb2wvOXNhWWFvcWpYT2J0ck1DWnpxWndsZUkr?=
 =?ks_c_5601-1987?B?aTNFcGFLcDJYalVwVWt2dDBrRnhydURuZEo5K2RWaWJnUS8wTzJo?=
 =?ks_c_5601-1987?B?QWFxTkEvNFBTdVpNd2lGZEh1QXl6YVBzNjlPUW5VM0dmNWY3M1lp?=
 =?ks_c_5601-1987?B?ZytFUzRRMHpjZnB3UlNyUGptMmQ0U294UVFyNjZLQmNreEwxZFVm?=
 =?ks_c_5601-1987?B?OG9BUVFQUjVIc1JhSEdKNEhSSHlTR0JndnA2STVoTE9KajJBNGFs?=
 =?ks_c_5601-1987?B?cnFsWWpJTm0rNVMwaWdWd2VsTUNoSjF4ek05d0FwUlRvRm9BUFEw?=
 =?ks_c_5601-1987?B?SVpFQnBudi9Va3ZHWUZwZE9FenE2dnZVSWJIYjluR3VjRnpyM1V2?=
 =?ks_c_5601-1987?B?ZDNJZ3B4N1U2U2RKYzZpTUdMRDBmY2lpL0kvYVNvS241Uks3L3Mv?=
 =?ks_c_5601-1987?B?MG1taGpuN0o2VFlhWCtyR3NPdlJxb2RnZlFucmlpQVc0Ny9WdG1B?=
 =?ks_c_5601-1987?B?WXVsdHlIKzQ2ZW1rc0VFeWg1dmFGOEZpN0dEMU0xQXBEL2Y4Q2o4?=
 =?ks_c_5601-1987?B?b2VYRjVieWw3RTllaTNLeWo1QXF2Y05WbG51STJGeDBjWURqK1g2?=
 =?ks_c_5601-1987?B?cjFiL2srOUdId3JXQ083ODlnZWFrUTJFWFNzamd2YjNzSnJXNERB?=
 =?ks_c_5601-1987?B?SXIwdmZDR3VON3dIUk9CUUdaYk9YMmJ1VmJ4TWtlSmF5cG5leUxW?=
 =?ks_c_5601-1987?B?VUt0ZnVaaVJKWkVXcmc2QzBXOFlXenZoYWZvQnB1eUlQbUlwTXFh?=
 =?ks_c_5601-1987?B?UjY0SVA5ZjR3RWhINEg1YVRQSFd5eldVYjhxR0RodEs0aWMyUFJH?=
 =?ks_c_5601-1987?B?VFlPRGtuaXZQcXR4TmIrUkUrZzQzd1NETlA3aU10YmFwNVpTTVow?=
 =?ks_c_5601-1987?B?RGhtRkNIQkdEbWxlQkFEUkZYL0VyaUNCbnVkb0pKMURXbWhMMjc0?=
 =?ks_c_5601-1987?B?NGVZVVZkSTNYczgwYVIwSkNWWnMvbGc3bkNJTjRneE4vS1doSlEv?=
 =?ks_c_5601-1987?B?UWJHY2puUlE3NGZaV1ZkNmxlZ1dZL0J2VEtCOGhNUVhVUWFLL0cz?=
 =?ks_c_5601-1987?Q?qsoxDLGA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ko;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2P216MB1358.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?ks_c_5601-1987?B?OGx6OXIyc0tRc05yWWJZZUJOUStON05PR3hVYk5pNDVEbGV3a2xK?=
 =?ks_c_5601-1987?B?a1ZJbWgxZUxPMFRpa1dnZ2FVaWtBRVNxc1I1L2hGdzBWdGtXamdN?=
 =?ks_c_5601-1987?B?WWZNaEF6cUkwdTBrQUdmVno2VE9mdCtKdWttK2pIZEpTWm05Nmht?=
 =?ks_c_5601-1987?B?QjJmQ01PdlhpeHV0TTdGUUs4WFBYcDJodHUvZnF5OEs2dm9FWklR?=
 =?ks_c_5601-1987?B?anVqT0JvSVhGZkVEVW1FZytBM05rTmhNMVlzYlgzWmtPSElzeHRz?=
 =?ks_c_5601-1987?B?ZGVXb0JrMEd0YlpCNmw0RzVVV0p4RVo4UFBuQ1ViSmlOcXBwQzlZ?=
 =?ks_c_5601-1987?B?a3RJWE9NMFVPaVpweVFyMFIxMkQ5cnA1ckllT3NNTnNmVGVQTUh2?=
 =?ks_c_5601-1987?B?OVBkbjFjNFNwT3pUU01VcmJuaTlKdWxDVTNIWkpXUHpQV2dLWXhn?=
 =?ks_c_5601-1987?B?cW8zK3hLV3Exb1dCK3pvNjdQZVcrVmswNWNUN0kwMFdZenZ2RTJz?=
 =?ks_c_5601-1987?B?SEFlQ0dmd1BweXpWelpRMnRZVi9RZVFZemNJRjZTRVp2YzJBd1NG?=
 =?ks_c_5601-1987?B?eXdTWUYrNWZPaFQ5aFU4bER2VjFnL2NDR01ETzlhc3p1VmpHeVpF?=
 =?ks_c_5601-1987?B?RC84Ym1NT2xxVlVhNEJhRWI5aS8xYjZLRWZaallSTjhVWWNoZnRF?=
 =?ks_c_5601-1987?B?dFlRZWRMdjdnR1hPZkd1UVdkeXhaMTZiN0EzTElwM1VLZWYrTUFa?=
 =?ks_c_5601-1987?B?cUlYdkxRbDZrRG9GektBcGVCb21HK1NVNVpyQ0ZYZkZZb2FHcXhU?=
 =?ks_c_5601-1987?B?N3VXWGxhMEt6UTdVMTdlRE5yb3gvQ0JuSHFlN21ELzhQT0VOSnY2?=
 =?ks_c_5601-1987?B?Z21MOUNlanlFQjRWdmFZUS9EMHYxOWtrYVNkbW5sKzZMQkhiNTJh?=
 =?ks_c_5601-1987?B?VjhJMHh0RmpxVDJvK3JVK3hEMGgyZmQ2Q0ltQk1ucVpJZU5hamw0?=
 =?ks_c_5601-1987?B?U1lhbEJrQ3Vjb3krVFg2eEg4YzN5VCtwUjZMRllKblNjRXJtWTQ4?=
 =?ks_c_5601-1987?B?SVJrUVp0bUZmVGhlN08rQ0RqT3Blc2F0TzNIVjVzWmhlS0VaakZN?=
 =?ks_c_5601-1987?B?V0lxdFdGOW5UUmVtZzBsSjQ3REIrQXpLbXZzcEp0V2VKaDhKVFpt?=
 =?ks_c_5601-1987?B?U3pVd20zVzRSTExFdGY2eEJGTElHcFUvRnN6ZVVwazJNMHY1SzB4?=
 =?ks_c_5601-1987?B?NjRTcHkweVdjczFhSWgyUjhhblJtT3ZVSENuUEp5R096RkVuUU9s?=
 =?ks_c_5601-1987?B?SngwZ0R4TVdXQ2kxL1VwakI1d09manFyOGxRUnE2bTRqRUVOQ1BX?=
 =?ks_c_5601-1987?B?RU9GZW9qNkJqbWF2SFBmK2ZYd2Q1WEMzeFVCQmZoMUVKTWNNSGNR?=
 =?ks_c_5601-1987?B?MjJxdFRTR1NSUjVVSEpqblJibU5VcXFQOFNkZUpPK0JMVlRMSUkv?=
 =?ks_c_5601-1987?B?MU9PRm5QWG15SXhtQkNidFdKNGQwc3NRWXA0WU5JbjV3aTRtb3hz?=
 =?ks_c_5601-1987?B?QnhDRHQvTHoraWU0NnNRMi9vR1lwUmRJK3pUK3kweFhRL2FxR3Vq?=
 =?ks_c_5601-1987?B?NlhEcjU4WUtRQzROU0d6UE5xN2xuYlh2UkZOLzc1MUt3bjJZRkV3?=
 =?ks_c_5601-1987?B?TVU4cWJZekJaeTd0anhKczd2Ymk4eW1VaktXM1Q3WWIwOFlRdWdT?=
 =?ks_c_5601-1987?B?Q285S1VmMlh6M3JWbjhMcWZaRUszdC9JQyt5TkltQnZMYXFvL0ww?=
 =?ks_c_5601-1987?B?cE9KN3ZUblcvTHA0ZCtyTm4yWnVyeVB4bnJYN3NRZjlCRUU2a0sr?=
 =?ks_c_5601-1987?B?SXVUK1dyaGYvREdtN0NwSi9FMGora2FNL3p3V0RSbVpsSFkxc0Ry?=
 =?ks_c_5601-1987?B?ZXppWEZlR2dKWllBNHhoRUlMOS9zNEZiR0g1L3o2UnlxamhyU0RU?=
 =?ks_c_5601-1987?B?OXpDdWRGWlZKelAyNzkxZGFGcEkvSTZKL0tOTzBKQzRTTlNDazlm?=
 =?ks_c_5601-1987?B?WEZDOWplVEU3N0ZqdXpnYTJWRFM2RXMxQXIxazYxZFA0dStwUmNU?=
 =?ks_c_5601-1987?B?R2RGV3NUdUh5YnpWUHowZ252S1ZuTGZTS1J4aTNEY0FlYTdwZFM0?=
 =?ks_c_5601-1987?B?UUphaTRzUFFpUDVJUzNUUGZJNktrRDhjbnJzVjJIOENRNmcwamNP?=
 =?ks_c_5601-1987?B?VGEwR25senJTc05lYnRiYnZJdW95ZWh5UG5id3hsL25hT1Q5MzRa?=
 =?ks_c_5601-1987?B?dUNmalQxNUpYWFNjdlgzVi8rSkxJdlZMUWxZQ2M1NzZ6TVBvYlhq?=
 =?ks_c_5601-1987?B?STdRQjRiV0o0SGE4WFRsT216eHMrYjN2WGF0WGEwejR3bGh5aHlm?=
 =?ks_c_5601-1987?Q?q7NJfKX4bK3NpmV+ublXtpvyCHN9Dl80YIiGVVH3?=
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: doosan.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2P216MB1358.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff10a3b-d6bc-4443-2b75-08ddc2a863b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 07:31:03.9213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1b3610-9ab0-42d5-93aa-46150d723d87
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1s78vPKlOV8nTL4dnlZUdYBFv16fFG2tz590bSBRO9WaOQsbvgvgwlwVKLpIeITS6LbCsmC+J+/Mu1NQEmuobbbd1tXhmRAxHZud6KwtxwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS2P216MB1252
X-GND-Status: LEGIT
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=doosan.com header.s=selector1 header.b=eJtfedac;
	arc=pass ("microsoft.com:s=arcselector10001:i=1");
	dmarc=pass (policy=none) header.from=doosan.com;
	spf=pass (spool.mail.gandi.net: domain of mincheol1.shin@doosan.com designates 2a01:111:f403:c410::1 as permitted sender) smtp.mailfrom=mincheol1.shin@doosan.com
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehudefiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffuthffkfgtgfggsehtsgdttddttdhlnecuhfhrohhmpemhpmluhnmnrldlofhinhgthhgvohhlucfuhhhinhdmucmgmlmkmncuqlnhfmosslnhvlltqmmhhmlvuceomhhinhgthhgvohhluddrshhhihhnseguohhoshgrnhdrtghomheqnecuggftrfgrthhtvghrnhepgfelffetlefgkefhtefgteetjefhhfevhfeuieevtdejjeeivdfhjedvleejffelnecuffhomhgrihhnpeguohhoshgrnhhrohgsohhtihgtshdrtghomhenucfkphepvddujedrjedtrddujeekrddvudegpddviedtfeemuddtleeimedutddumeduvdemmeduudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudejrdejtddrudejkedrvddugedphhgvlhhopehsphhoohhlrdhmrghilhdrghgrnhguihdrnhgvthdpmhgrihhlfhhrohhmpehmihhntghhvgholhdurdhshhhinhesughoohhsrghnrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvh

RGVhciBYZW5vbWFpIFByb2plY3QgVGVhbSwNCg0KSGVsbG8sIG15IG5hbWUgaXMgTWluY2hlb2wg
U2hpbiBmcm9tIHRoZSBEb29zYW4gUm9ib3RpY3MgQ29udHJvbCBBcmNoaXRlY3R1cmUgJiBGcmFt
ZXdvcmsgVGVhbS4NCg0KSSBoYXZlIGJlZW4gbWFraW5nIGdvb2QgcHJvZ3Jlc3Mgb24gbXkgcHJv
amVjdCB3aXRoIHRoZSBoZWxwIG9mIHlvdXIgcHJldmlvdXMgYW5zd2Vycy4gSG93ZXZlciwgSSBh
bSBjdXJyZW50bHkgZmFjaW5nIGEgbmV3IGlzc3VlIHRoYXQgSSBoYXZlIG5vdCBiZWVuIGFibGUg
dG8gcmVzb2x2ZSwgc28gSSBhbSByZWFjaGluZyBvdXQgZm9yIGFzc2lzdGFuY2UuDQpXaGVuIHVz
aW5nIHJ0X3F1ZXVlIHdpdGhpbiBhIHNpbmdsZSBwcm9jZXNzP3doZXJlIGJvdGggdGhlIFByb2R1
Y2VyIGFuZCBDb25zdW1lciBhcmUgaW1wbGVtZW50ZWQgYXMgc2VwYXJhdGUgcnRfdGFza3M/aW50
ZXItcHJvY2VzcyBjb21tdW5pY2F0aW9uIHdvcmtzIGFzIGV4cGVjdGVkLiBIb3dldmVyLCB3aGVu
IEkgc2VwYXJhdGUgdGhlIFByb2R1Y2VyIGFuZCBDb25zdW1lciBpbnRvIHR3byBkaWZmZXJlbnQg
cHJvY2Vzc2VzLCB0aGUgQ29uc3VtZXIgZmFpbHMgdG8gYmluZCB0byB0aGUgcXVldWUsIHJlc3Vs
dGluZyBpbiBhbiBlcnJvci4NCkFjY29yZGluZyB0byB0aGUgQVBJIG1hbnVhbCwgaXQgaXMgaW1w
b3J0YW50IGZvciBib3RoIHByb2Nlc3NlcyB0byBiZWxvbmcgdG8gdGhlIHNhbWUgWGVub21haSBz
ZXNzaW9uLiBJIGhhdmUgY2hlY2tlZCBhbmQgY29uZmlybWVkIHRoYXQgYm90aCBwcm9ncmFtcyBh
cmUgdXNpbmcgdGhlIHNhbWUgWGVub21haSBsaWJyYXJpZXMgYW5kIGFyZSBiZWluZyBleGVjdXRl
ZCB3aXRoIHRoZSBzYW1lIHVzZXIgcHJpdmlsZWdlcy4gRGVzcGl0ZSB0aGlzLCB0aGUgcHJvYmxl
bSBwZXJzaXN0cy4NCkNvdWxkIHlvdSBwbGVhc2UgaGVscCBtZSB1bmRlcnN0YW5kIHdoeSB0aGUg
Q29uc3VtZXIgaXMgdW5hYmxlIHRvIGJpbmQgdG8gdGhlIHF1ZXVlIGluIHRoaXMgbXVsdGktcHJv
Y2VzcyBzY2VuYXJpbz8NClRoYW5rIHlvdSBmb3IgeW91ciB0aW1lIGFuZCBhc3Npc3RhbmNlLg0K
QmVzdCByZWdhcmRzLA0KU2hpbiBNaW4gQ2hlb2wNCkNvbnRyb2wgQXJjaGl0ZWN0dXJlICYgRnJh
bWV3b3JrDQogDQoNCjE1NSwgSmVvbmdqYWlsLXJvLCBCdW5kYW5nLWd1LCBTZW9uZ25hbS1zaSwg
R3llb25nZ2ktZG8gRW1haWwgOiBtaW5jaGVvbDEuc2hpbkBkb29zYW4uY29tIE1vYmlsZSA6IDAx
MCA0Njk5IDE3NTEgV2ViIDogd3d3LmRvb3NhbnJvYm90aWNzLmNvbQ0K
