Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011048.outbound.protection.outlook.com [52.101.65.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E25F189BAC
	for <xenomai@lists.linux.dev>; Thu, 17 Apr 2025 11:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744891198; cv=fail; b=ez20eTTuZt/9incuml0JDf3IAZlQfykZdHKbbL+NRClHUURa5vjR88K5Rpz76BSn4Z9eDjLiloG+3KqJxmOTFBG8YmG7UyqtCtQp2R2PjpnVBXB68tBcut9lZESfyDgWB862YUnuGmWmRpcez1IM0f7Dyn+FatV1pjHvNMvryJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744891198; c=relaxed/simple;
	bh=jzdFIH3dqZP/vVCR/6vP/6G+z1yZO59tbFVBnHP5e/w=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=KjxzfMKLy0DZGBGZqmP73SDAzkmwYJq7so+EdeBikwF2hIko8aqvTLvd32tXs3qPdFQE91bd+D83ATR06svxeznmCeOJ1ScGalEyLZEhVPwpPUIOd+WoZnfNMVi2vVLTABoKpE0vlXHI7E5UxZ0rSQKPoZfCas+snPrpgBrfiMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=q0B1JivI; arc=fail smtp.client-ip=52.101.65.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="q0B1JivI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YmMd+LNcmlorkJb1oxNGsHUqMK00Dc10xKoqS5VUHUZPSb8wzSisLR9qNqeBr7WYPyWxOHCu4XTMRoM+jWhPmXlYY6z6lqmqxvu0dqjc5guU0gTjd5qI+YNOg2xMO0M77YsUyEkExIqLdEEsHOUfVAIcmuAFWy4voinoHqnIr0Wr0POBsgeWX0XFZxcbF8nF0g4kIcLjSPrewjDjzW/FyYlw5PxY2NS5Ud2El+1eOR6Z0WFMfVJW0aECQ6Q8DqatnybNSbDaH5xjZiAmHAEx2oinz5UXa0kMtWP29XRe+EACzSMKgepEjroN2ejjl/WkLsMy+4B4oNcwzdcRe8plFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uv6yY9QBfzjAK2/iUIQM2DLRd8ksmwUbKGAJk5Ro01o=;
 b=x5W6ZXGQT22vNhvBar/FAVHKhZxHeW4LdPYDh3WNlH7nsnYg7ICoDaBBduxYEirIjEGzpWcqVQBytyiu39ildzJXwxP66dXb/aTebP7h5NfkLp8Y6NniPb7Z0DNvFOjlb4lVkblb4v5josiUCMmiryHrwZ92fgbCk4CR2k6Xo+EpdQ9BGz1p4dUDjL1QeCN6MmjUYtHZ0QXGx/IIFeElEv+dxmV9vUvEi2pXOUM6I8+6Gl0PHBXrQv94H9ZFa6T/QpMKnAymWS+jXFfP3CObBk1jog7oFHYHkiJzqZCCefp8UYiu30nBo9E61/L2ZvnYlsx62/HRGNDUltKT+BOILQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uv6yY9QBfzjAK2/iUIQM2DLRd8ksmwUbKGAJk5Ro01o=;
 b=q0B1JivILlIuB7FnOIBmIqDOH9PZtEU812s6Nl2OggjrTDjxFd1rP6DBxxG/Kia5kdAU+RvcejI21nqiVBgk0gpdpvIxSs1tYdEP3FAJz5Q7H8Xnnw550qBHMy92mMGdTB3+x8UaL/DpwrnH+RU2bgFGRKT7zyNay71Z5Q8WgOrnRRmCcWEqGvIk9IiSI/JSdVsAZxx1vMMqi9l5oBn2t9Zfk8e6gTeHiUIHtF5mdglui8mbH4GP/1Yt/EBq45eejfSd3CLszitfHzSYLB7u88QHbxi03zlActQwZSSAjYSFMOY7omEIxCTR//FG+OfGO1xLH6vrLWB2HrUwj6+Ikw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6044.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:7f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.21; Thu, 17 Apr
 2025 11:59:51 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 11:59:51 +0000
Message-ID: <69eac7d2-ff74-4d6d-a9f1-c1c50f7e9fa3@siemens.com>
Date: Thu, 17 Apr 2025 13:59:50 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] Xenomai 3.0.16 released
To: Xenomai <xenomai@lists.linux.dev>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6044:EE_
X-MS-Office365-Filtering-Correlation-Id: a3d93a1e-dc69-40d1-bc66-08dd7da75c02
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QytpdmRGdTRQaUhnalFRNjZCNkJ2aFB4T01UcTdNTmhEWTJyd0EvMTF3UUpP?=
 =?utf-8?B?Qm5CQzFGT0FQN1JhMGlZa0ROYU4zTHVwUHM4U3puL1JOUVJUcFFqQXE4cDY1?=
 =?utf-8?B?cGxhNjh4RytuWk9obTUrMXZTZG9vSHlhKzhVTDRPbmd5c0VLY2EreDh0MjQ4?=
 =?utf-8?B?V21kR3dUSmtxdEk2NFZhTE11L2J5cUFpU1hUZDZvVXcrM3prK0xlNUdHaTYw?=
 =?utf-8?B?WHVRekVwN0RidFh1SlVwcmMzc3NYSHJmWHlKMEhtSXczUXUrWXBOU1VjdlM3?=
 =?utf-8?B?a045L1Zza2VFTGZJWmlSSUpHWGlzUmRjL1FtU0xoZW9Ka2ZoOVkxS01jdVUy?=
 =?utf-8?B?Z09mWEI0SGhidGpiRVE0a3g3RTFiYmpTOElqMWkyM1EzYm9VcE9WbkdZeUEr?=
 =?utf-8?B?YjNBb2JrNHpPSGFLQXVkNytwK0E2Tlp4M1ZieW02dk16UHRuaytRQkt3MFQ1?=
 =?utf-8?B?cVVmUEVObjFSMlltQmpMUHpTUE1qUkl4VTJIZ0dFYitZbWNrQ1lRTEFHZDNG?=
 =?utf-8?B?L291bUxEVXFrbTZYUW1vMCtrbDVXN2tPblpqT0pUVkEvOUk2R1VYcTlFZzBD?=
 =?utf-8?B?eXo2SUpPVnFQWEJZd2JYNFdlNjRTQlM2cjYyMnluZUN4Mno5TG84bjVLMCs2?=
 =?utf-8?B?VDJjMSsxSjFGL01abmhLTElBU2duNU9xdnB5KzRRd0pCU0RTV05ySWUxRVRu?=
 =?utf-8?B?cmFOQjRWVXBnMGlHSlNVSDY4VS90ZDB2dmJ0Q3R1SU5lVHVjQk1pR1Y1UTlI?=
 =?utf-8?B?SUhxWmhBeWliK3dHcTRkcHQ1U2ZDWmJqQllXQ0hFcm5EMmxsRi9qKy9lMWJ1?=
 =?utf-8?B?dGxlYnFwQzJKcmhPa2hxVGxnQVkzVTJibFhsbkhPcjkycXA0Mjg0THZ3L2o0?=
 =?utf-8?B?WitSNnpnN0dUNWMvZWVxNnA0ZGhTM0tBNGhZYklIRnJ6cFY4UEJ1QzdMM05s?=
 =?utf-8?B?cWxrU1pEY2pjQTRTZXVKY0daYTR4d0ZNc3hnekkwTGFiZHMzL1ZOUi8rN2Vo?=
 =?utf-8?B?cm9hNXFUWjQ5Vnd6YzY1OVJGd0NyZ3BXMlRrYXYzK3lHN3gvK3FsTkkzSElp?=
 =?utf-8?B?dUNjSHpJbDVyQUJkL2hWWXdpbWlvVEdkWjVYdzBzdWdTK0VwaU0zUXFjQ2Qz?=
 =?utf-8?B?WC9QUzJuU3VUc1hhVVo3RGpGNnhsckd1NGdzazVqV0hzYWNYalN1NzB6ZlNQ?=
 =?utf-8?B?VTdyZ241NXZtU1ZPajhnaWNVenQvdStSU2NSRlJLT0V2TmViY3dwNXM4VjNE?=
 =?utf-8?B?RjJ0Z3FXV1pWbWhEbHE3YlJmZUtiRDFPWUljQ09pQkR4Vm93M3k2dGx6Q3Rz?=
 =?utf-8?B?YzhpcWloSHJZaEgxcGI4SHcxeUROUkFFdmZQaW5NOXNWaE5IYnlTaGxvSDVU?=
 =?utf-8?B?Y1Y5dHZVOEFBRFVpVmR5Wno5RDJKYytES2ZxaVFyL3pnUVpoUGY0UTRqQW5K?=
 =?utf-8?B?S0xicVNNTWphMHRSNi9tOG5WZG95azVESURJajBMUUxnZ3N6US9Uak94ZEts?=
 =?utf-8?B?QWdiZ080bEF2QzdhTHk1b2xpYUhxQVgrQlQ3TXUxU2dpaHJteC9JNFNkMktD?=
 =?utf-8?B?VGdzUmgyaHliVXgzWTg4TmhHbjZ4RDQ1SFhHNnFhTmhSMzVHcE1ibGpqK3BP?=
 =?utf-8?B?ZGVwT1dTNFI5NWdvWStNcTVoWjh5WVdQS2dKVUhEeWlicE9yQzhybGxYS05x?=
 =?utf-8?B?S2llaXFpTkNMQkVNSW9uUDYvUjgxb3hWSHhvVzJGVTA2ZldtNTZoWno0dThX?=
 =?utf-8?B?eFVqM1ovNXltaUtUUXJtR0dCNWVsNE0zcFhLdStUN2F2MmZEZS85TjU1MHdI?=
 =?utf-8?Q?HlRBcFPY7Xatwb7s6SLgvcCl587+EtsK+tuZw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWhvbzVpNzZraTE0eTNyN2U2UFN6VDV6OGtUQWo5eHZhR2xvb1Q2TXR3M0dT?=
 =?utf-8?B?MVF6TU8xVVpYUGVNV0dmUTl6Slg0U0RRUVV4Z3hSU25JRDVVWjFkczFmdHdL?=
 =?utf-8?B?dkxTbUwwbGlBTWJRQW83NUZLSERxT1dmZExvRHFjRGpiK09GWlJ2a0VMdWtt?=
 =?utf-8?B?WDV5Mk9ndzFpME0ybDZSZ1dYUmh6d1ZUWDQyVzlpYTRSUWluRW05d29OUU5Y?=
 =?utf-8?B?d3hLZHo1TytxQ1FFQUFTR0x4ajgwY05FRldVVFpQdjJ3a1B0VVdYWjhidExH?=
 =?utf-8?B?MSszYWl5QURNQ0xqS05OYlM4Q0RIVWhnbGtyR2NMU0RwekpoZVFhZDRnU2ty?=
 =?utf-8?B?N1JnVWZ2OWlwbXh5VlF6RUp2SC9ab0lrMHJJT2Z1d25UZE04Z1NkWXRsVDJn?=
 =?utf-8?B?OE1GY2oyTGFjaVAybHphOHpsYmtucnU0cDMwcGJHb2JBTlRRa25LY211WWg3?=
 =?utf-8?B?RUFDZjJJcGFmN2xORzJTbjNHN25XZHZMMjJrNDA0UjU0ODljNEZIRWpoZlNG?=
 =?utf-8?B?MUFIanpOQXBkdlZJRUNJR2EwUlBmMUJjMW1qaGdIYXh1dWtadHlYV2tHSnQx?=
 =?utf-8?B?a3N1b3pITExOVzJhN0x6K2hkUVNHSHkwc2E5aHVKTk94UUdHTWVQSWpicWdR?=
 =?utf-8?B?WnBLYXVVUlF1bmtWMzNiOSsvOUtRbG9VNHpTKzNKOGp0M1VPQkt1Z29DTXUr?=
 =?utf-8?B?Rk5SckpIQkhFWFNhQmhHbGIvYVZQdkNzYWVwa3VJTU5Sb015U2IrTFJvR3Fo?=
 =?utf-8?B?YUwxaDNyUy9TN0hqeHVwYjNoUDRnN2Y2SVZndngyTFFaQ1VvdE9QM0w1ZkRq?=
 =?utf-8?B?cjFadjA1dE9BVTNjTloyMVhjV0FnZlhla1NmaUFhR0Vwc09JZXRUQUdkS01X?=
 =?utf-8?B?aTY0SXZyK3hySTMzcE1jYXduMTBGdmlIUDBGRWRzNmRwM2d3Z2Zhcmd4VkNi?=
 =?utf-8?B?MnBjOWsxQ3pJTDFzTWRodnY4djR4c09mZ3h2MjV1d1EvbHNzL0RSY3JTTVd5?=
 =?utf-8?B?bVg0b3dSdXlpTUxobkltRDBuQ2ljOHBRZjl3a1AwQk1lcEY3ZzNibUJ6eEN3?=
 =?utf-8?B?aGllMVl5ME9TTjROOXN0ZktxVm1TQ0k2UEJUVXgrdTFvbnozdzR3cGwzNWJX?=
 =?utf-8?B?c3FiU3FhRVRucnFYWWhSa3ZhWkhZQTJsS2ZkMko5NnRHNSs4QVBsMEx4Z1BM?=
 =?utf-8?B?RnVSYiszVGNFY0JNL0ZnSmI1OG15akRPNm5PQWRFb1MySWFRLzI2RTZOaTFy?=
 =?utf-8?B?ajdSN05yOHF2bm9QNkJCQXJaL0JKaDV4VmJXMWNaQ0dTVXR4TVNMazlkQnpR?=
 =?utf-8?B?Tkw2OXAwbnNZbEZ2OTIzQXg5R01iZFowbXoxTkxuUnBOdW5taGorbjQrS1pu?=
 =?utf-8?B?TmlEUzNTZng2WTNMZU1PbEx0OFNLWnJjQXErQWk5d2UrTU95UUFqejk3elor?=
 =?utf-8?B?L3VpMzJKMW4wK3l1U0lXT3IzamNta2t2R1h4ajcrNGhlNCtIRXVoVGtDYW1s?=
 =?utf-8?B?SXhRTzhmTmRDSjFEc3NpaHB2NytwbGluVmxObmdhcXVRcFlxODF1bExKcldX?=
 =?utf-8?B?TlBnd25Hc1dYZGMxV2JqejRkTmh1RlRxajBCcVN5RmpZTVpKZUxYdjlTU0xm?=
 =?utf-8?B?VzlhcEJGcW1sZDVFMjR2V09aUW5reGErdklBU0lVVW9OVDYwMmgzWlMyRHNO?=
 =?utf-8?B?NWV6T29rdTYvcm9MZit0eG5sUUFjcW5uN0pjNmJTMVJrRlQyb3orcGFaS2po?=
 =?utf-8?B?NWxLanI0UDFPdUNyZzZmS0NPVmt6NzNrOUJtN1cvQVk0dTlreGJVaDBXaENI?=
 =?utf-8?B?NTlLQTdKNUtNMWtoS1ljQ09Tckk4L2dleEtYTWxlVGJwSWVBR3JvY2QyUmNC?=
 =?utf-8?B?NVBsWlh3bndlQm53R0s4QmVleDk3dzV2UXU5OXh4cFZyT0x1akgyQ0Z1cENv?=
 =?utf-8?B?b2RaQTNObndYaTJOVWkwV2c2dTgyZVBaendXVGw1MWFKaTRrVEdtb0xKejl2?=
 =?utf-8?B?Q1hXNk5SNWNnekp0amVWNzNoUDAvZEZYczNRU3V5MlhoQllwaWc5OFM1Zm5L?=
 =?utf-8?B?R0l4N1MzUWx3MFVNVWZWVlN6TitTVllWc3IxcXBYbEJSWHVBKzJFZG9pdFhs?=
 =?utf-8?B?YTJzRGUvY1lheUtiSmg3eHgwWFh3VTdoL2JyV2lyeE1IQ3BHeU4yZWYzR2NY?=
 =?utf-8?B?Z1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3d93a1e-dc69-40d1-bc66-08dd7da75c02
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 11:59:51.4341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mFkLe5GIiaS3s9F9x9MCmDm7LDpYQDxj+HLy81NrT+VRS+LHY5n+WTRW2RwSM6DcBFwJxWvCwIiGTl9Mm7mpcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6044

And finally the stable update for 3.0. Is anyone still using it?

Download: https://source.denx.de/Xenomai/xenomai/-/archive/v3.0.16/xenomai-v3.0.16.tar.bz2

Changes since 3.0.15:

Florian Bezdeka (1):
      drivers/via-rhine: Fix a build warning in via_rhine_init_one

Haiyang He (1):
      lib/cobalt: Fix a deadlock when release_buffer() attempts to re-acquire buffer_lock

Jan Kiszka (9):
      ci: Do not run CI for tags
      testsuite: alchemytests: Give more time when running in a VM
      cobalt: select: Move nfds range check to caller of xnselect
      ci: Exclude master branch from builds
      README: Update links according to our new homepage structure
      cobalt/vfile: Plug race while opening
      ci: Tag build jobs
      ci: Fix detection of tags
      config: Bump version number

liyinjie (1):
      kernel/cobalt: use flexible array member for symbol in struct hashed_symbol

Jan

-- 
Siemens AG, Technology
Linux Expert Center

