Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013045.outbound.protection.outlook.com [52.101.72.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8762D212B0C
	for <xenomai@lists.linux.dev>; Tue, 27 May 2025 12:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748350791; cv=fail; b=pIllLxcKSfftXbHA6PaqsV6+CkMA/RV1EO+u5NHm+f+ToZ2ByFYrNcRf+nph+3s6CK44kqJWg5njzXUaeKbTF8TdUnQ1NLkB9FHqkRX344+jxIWAE2Z2AjrjgnXsneczjYg9b+XOp91ZcQt8a2wNacWrmf/AyLTY8EZ3G10bny0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748350791; c=relaxed/simple;
	bh=vApGJoBdwIRexCEKaXSoauMvgyuJGMWvSu9AAh878Wo=;
	h=Message-ID:Date:From:To:Subject:Cc:Content-Type:MIME-Version; b=SgVGilir6kVb9GURm9BpAlU1FLTIHUFB7CF4UnOk+F1k3rjxU/8yHPQlfVljN1iorpq6XAZUmrfM3QsTbEVKRQTWdNwsvqNdfmT+3Yfwd/KMtwJqxTw0oc5itYBYYjnB2xmyNOHu382085lQbgjL7iLp5pgauvZFxLs/EOFh52c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=vU3M3UY7; arc=fail smtp.client-ip=52.101.72.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="vU3M3UY7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vhmXb+huuUZdlHswf8le/C8uhKlHUOSbzJaLk4eg9WBfvGjrWvKEOjF62Z/CAybqQTUCFOZCgLrRGdO2Fo0h+xpWkeYhfXWz4W0d4oWPaWj+wUgMa30Yw2DRzBumMvheu1KDacHE1wasdgz3Zs3lAESrLEo8PkkEzi9LiZFeZTU7dYJWbCN+CtlYnawU73jeZI5/1AYy9DNHSR1CEHJQXnxURJt7Ogu+3nL3anaw58AZ4c4E79AtA7S9QOlx6kevyT6zzc0pjFm8bzdyDu/rVCQ8k75hUy1qenW99oXXcLgrl4C8GPp3gzzVvCPYwhdlXmeveL+L53VI9bhDWEoqdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTWPb0rFRd5ZzFK3hMHl7PvSfEiZt3WAQqIKaPNdPb8=;
 b=TyNefkkwDkMaH3DxqH8TW8rTA/F/7IDdaidXSM3MbHBOEs7FfJqZGQuv4NixBdcSlt5AIouZtcz3J64kdbz6u3NUHgOxmV9mU3DRBcE5rt7S3oxOkeOYP7bLobmyp7vxf6PxwIFVwY7NalIPnDXuDzadXm+a777M+536E8sr8IXyEpbwnFsPGmD15e3osHFV5n7xDhr9P+n3KKJ645NbK5+t3iFeXC07e2Fi8fvBGXTBU8COUyh5gXP1ByFV+FILHAHCOPCeiAZKbZoUvai99LQX7mUzGnwkRnSvsa4Hr7CUh7b0d8RRu0vG5JYd6PKqq9WxXLp4wNvw0Zz5J6ekCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTWPb0rFRd5ZzFK3hMHl7PvSfEiZt3WAQqIKaPNdPb8=;
 b=vU3M3UY7IW3aupNS6ccDdBaKj68o2g5QQEPYz23oZmjDoTnYJT3QfYxGTaf8dNTs2ameZdaVGrXv2yQxTkTy8ohpzelhwF9bJ14juH0f0OK8lfcjidX7hVsmtIQ6aOAAgE2ZnROSBuTQDwtXpWGS6pVi+/qJ4SOu5KHaAREFyuw9c7f/ZXnFxDyswGgvCxA3XPV+N3YgI1N8yvr5zKI5/bn+9x0K6Oucu+87HklqRvVu1nnaToy0oVOi1j+hNVx9MjasQZIe2oQ+bxg9wiVSyJKbrqT5fsNkdn1Z/UDoN16jVkZZi7tuFaq1D7SGAPTF1Xsi7BJA84EqANK6Mp7/vQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB9089.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Tue, 27 May
 2025 12:59:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8769.025; Tue, 27 May 2025
 12:59:45 +0000
Message-ID: <00e27ff6-15e8-4b24-9c2b-181755ec2cba@siemens.com>
Date: Tue, 27 May 2025 14:59:44 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH v2] cobalt/posix/clock: Allow NULL resolution on
 clock_getres64
Content-Language: en-US
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,
 chensong <chensong@tj.kylinos.cn>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0389.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB9089:EE_
X-MS-Office365-Filtering-Correlation-Id: 7290fc70-753f-47ea-ad1d-08dd9d1e5abc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alRjUVk4OGJrYnFxT0VDcDVLcFZKZm1iR2JNNVpoemNyU2tDNXVyRzBJQzIz?=
 =?utf-8?B?enBBaVJlekxKUGIyOVNwZEhzR0E3TXlKUGtyTkdqRWtUTzRRR2pheTVmeVIw?=
 =?utf-8?B?U3ZLMnhZU0R2RGUxazVJRHQxWHcxelJKbE1FeFFyNjJ4YmlOaWRaU0U1MnFz?=
 =?utf-8?B?MXNpUDF1NlF2Z1ZlZHh0MGVpY2VNMlp5TFpRbDYzVS9jYWtTL3ZMY0gzOGlt?=
 =?utf-8?B?MnRoTGt0VDhtL0V1Wk55WTQvQTB1eU9sWUJTdjMxb1Y0a2dsUGxWaHNIR1Yz?=
 =?utf-8?B?T0JyR3FyUXBnNHRFb3grazZFWVM4dWJjVkdyek1jbkpBMTN0N0k4Zzk1RzhU?=
 =?utf-8?B?S3hzNk52NTRQZjNmRGUrQ2hxcjhxSklFcm5UOTU0RWNUbitVSHpYWEZFZGM5?=
 =?utf-8?B?R1c2clJ2SkptNzlCY2dxVGVDbFhyYnVERVplOUlNWjI5VytsVm9xcDB0Nkda?=
 =?utf-8?B?OTJqRW9PV3phd3Y4c0QwMytOendqM3VJSzlkN2JzazNNMUdzaE5GUy9JeGNm?=
 =?utf-8?B?YjUvUWhaaURWVXBsZm1PWFdkTXFqbTF6SGhQY2xKM3NGUmJ6RUhZYU4wVGNl?=
 =?utf-8?B?ZDRjT1prcXkvZnNhY0tMQTEzQjF2ejExYS9OQVNiTTVwc1JkMmhKeG5DcHlS?=
 =?utf-8?B?N3FaemJ1V05XdmdHVXhvbnRmV0F6TWltdDc5dFB6b1h3aWZvVHdDbjJUR25p?=
 =?utf-8?B?eWVLMXVoUWVsUjlPRi9KYlhXRnRxUXQvZUFUSi9xTUEzU3pvTndEYVJYZklV?=
 =?utf-8?B?MDkrNnJuS1hoWklIMVFQcHQ5azY0bk9mcXZxcHp0TUtTeUk4YTNhdVRKdHZ1?=
 =?utf-8?B?OWdTZzdQUjA3ZzhTYWZ0Y1ljTWxSNVpGU2ppQk5CUERWSVlQck8wa2xpbjFS?=
 =?utf-8?B?eEt6NVZXUkM1VG1ZVjJzUkYxc25yV3FWSkE3UFViUVNCb3BIR2tHWHZlYVdW?=
 =?utf-8?B?YlBTTkR4QjdZRE53UVdNZkJqL1dCenhyNDJUUjc1ZWsvMFB5NlZabUpnRlJT?=
 =?utf-8?B?cFZ5akkrQWlsRHE2YUo3MXVlUXcwemh0enZQK21ieXJZQXdLUHZRNjVPcmtp?=
 =?utf-8?B?Z0JWb01QT3ZETUsvOHRkRDV4cFFxZGNRaEhmcXJGZWtjcHQxTmIvUDdRb2JT?=
 =?utf-8?B?OEIrbURXK1E0T01vYTVRQ1NLbnk5TXJJNFFWZHRmWmh4cDErNHp3bE9VVWRU?=
 =?utf-8?B?UW4wSExwNjg0VmJtaDVBU1hyTHhsYitiS2lINGkrVFp2RXczc0NJMkcwekpi?=
 =?utf-8?B?elIwcUVzYUFRRXJSQkh0OXBWSThDTjFLbWIzQWYxelVQb3B3QWUyL1U5aXFh?=
 =?utf-8?B?WlVVTUYvN1RpRjVNdkFWVjhWT2MyMXp6SkhqL2ZMU2NPQTFQZW41RDFGb2FZ?=
 =?utf-8?B?QkFCQ1JXdUMzWHAzTExUcksxREdpNTliQUVzWHBKejF1eTBBQ3dQajk0bUht?=
 =?utf-8?B?eUN5VFBLUUppa0gvTDM1NmJTU0xGU2JCYTErYnU5Q3VmVkhOWEQ2dkZmUk1J?=
 =?utf-8?B?UkI5QTVMcmh3Skw5b3dQeG53ejM5K3BsdWFodFVFbVd2S0dnRzJaaE4wTjNP?=
 =?utf-8?B?aHZlWHFZTVVrbzhhOTZIQ1hVd29VcFp5T2dzbXlvZ1h5OUk2NDR6Q2pNTzYy?=
 =?utf-8?B?YlhYaE40bWJQaXlKUXBHcUZvNUhCLzFkd3l0bVpuNkFiU1VENVhnRDFkMS9x?=
 =?utf-8?B?RDAzSTNuckozcitlRVNURkNVNGpFS0NIcUFkcGM2MUZhc2NNaTcrR2RJRFBB?=
 =?utf-8?B?Y1hQSWxaWmNielNMWVdwcXhMcTFoU2ZJNi9waEgvRHNTdzZ1N2dpOE5VU3JX?=
 =?utf-8?B?ODRzZWhKNWRwcEtqbjJhUHkrT2RBOVdmTHg1ckhIZ21CMDg1QyswSFM0OVpD?=
 =?utf-8?B?R2ptV3dxRkFjK0FwWXlVZmFxbzdRMDVWL1lKOUpDL1VuajJNeE04LzZDSjVE?=
 =?utf-8?Q?tJh9sIIiu74=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T28ra1hFcWlkUGRPV0JQZDZmWlQyTEFnTVJEcEYrY0Z3a0ppaUZtNXhRazBW?=
 =?utf-8?B?U0dsb1FyMCsyRGNZc1IrZFRTMCtvUldoY1Z3THdqMFRld0FrWnQwTGNVT1dV?=
 =?utf-8?B?cUYzUXNiUWdyc2ZoWExDazEwMG12NUhiQVlIemQ2TmVwNVhUTDMyYlNJSkJs?=
 =?utf-8?B?NnBaeGxrTmZmRXYrNmFKSDJ2Nkx3T0VBcTlXaEl0dk4vS25ZZW50aEhlOHFR?=
 =?utf-8?B?dytuM055T1FiYlBsYjAvL281SkJuWGNKcGozZHAxSWNORGphU1RMZHRXMEk2?=
 =?utf-8?B?U0J2V0M2c1BMU1RYYVNEc2VSS2dKUGFwMXBFNnBOS3RYd0RSckVDeFBlZkx0?=
 =?utf-8?B?T1VjSzFzd2QxTEpXSHF5NEJKbVg3RDRYZzlpTEpROTlSNWprLyt6ZEhrb1Bt?=
 =?utf-8?B?eFJVQU1ReTNyb3FGd1g0dUY1NHlHQzdXRWRFYXJBNXJ6WlpYMDEvV08zUW5a?=
 =?utf-8?B?RnAzQ1YzeDBlY2w0dlBrdkxSejBFR0pKOGo0NzJyT0J3WkdYbHEyZXFVUWhK?=
 =?utf-8?B?REYwZTB6NGJoZjY3WnpWSmlVY0dlb21YZ0pkM0J4SWtNYzh4WWs5ZTVETG85?=
 =?utf-8?B?UFRaZmZ5Nnl4ZHk5R1ZUVmZ0cTZjR09YSnJEZkpHbUFMTElKVWJrQndTQkN6?=
 =?utf-8?B?L29ZWU5NSTQwSGhwZlE0M3VLVGRDRVhrRDZqdS9zNjFLM3NuWTBBMVZOWG93?=
 =?utf-8?B?UUVsLzNlSFhYY2YzTFZucmxRbjlGa0hWK1E0aVJ6TUpGYzc2RmwzUVhnTnRs?=
 =?utf-8?B?SkNoQU5qdVJ4SHdiVzlVQUUrL0lNSFhTbU9UcFJYenlmdzZGZ3RWVXVxbHdZ?=
 =?utf-8?B?YmRaWTQ1ZE9DTWErbjM0RXV2ZzBPVER3bjVZcGJObHZrbFllU3FabXkyUDRj?=
 =?utf-8?B?TndQc2JxbkswYjFES081c3dvRG9HMmNZM0xpTXFoTERDOEpQSVNJbERVaGor?=
 =?utf-8?B?Y29PUHE5eUloWTZsaDVMczBZM2dLcjlVS08rT0ZFN29jalMxZHFlcFpGSzZO?=
 =?utf-8?B?VFExM0Rtc052c05leTZRSERDQ3dUWkphL0NtR3ZVbkJPRjBQdXJHcjhLS0pn?=
 =?utf-8?B?cHVuS1MzRDN5azFzR1dFSlNIMXJJYnFzdXBIUEZXMkVHR3JpdzBPaFBvRUM5?=
 =?utf-8?B?UFJ5ZlYzZzN2RklHall3UzBEUjI2UzRSRWtGOGR4akV1b1NLV3ZzU0ZncHNu?=
 =?utf-8?B?eVlLaEFIZzhyT3FEWTg2am15K1pnVm15ZGZXUzMzalg5N3Y1cThEMWNLQjk4?=
 =?utf-8?B?ck5nTEtpNjFsSjR6RFZJZ3MyOXEyTFVVUytrNTNETjZ0STAwSXNiZkJaZ2c0?=
 =?utf-8?B?QVVvZHFJWGV2QXR4OERmM0pUcUY0ZHJPVXJraFkrYW83RUV2UmI0ZlJFWExx?=
 =?utf-8?B?dFRqMktUMGd4dCtQK0djQjdURkFINGZHYlpNUG1sOTRXUHJ2SHZuTVRLQW85?=
 =?utf-8?B?SWVDbHNpK2ppL1h6Nm1XbDRSQUZwU0V2S0o1dnNWQjdxQnhoQU1kRnFhWE50?=
 =?utf-8?B?VWwvU1lpd2xobkd4anVzcklUb0ttc1k1Nlh5ZUxqT1ZwVkoxQ25MNXI2L2RW?=
 =?utf-8?B?TDNZaG9qTE1mZ1czbXZ2QjVoRVdYUmIzZU5tb3djSStRall5M2dCZHVUQmZL?=
 =?utf-8?B?N2l5RkpCaGxMMlBSazIxc052TnVFWTgyV1FUdExxTk5ibTB5WEh0L1RyNHVn?=
 =?utf-8?B?UXBMM2gwZHA1Tjl4RFkxOFBlbGthU3pKRG0zSk8xS2VhYVZvUUVqa2ZEZ24x?=
 =?utf-8?B?UGhaOWpXaHcwbzJqeFpxZitRakUwWUFObmY5ZjI4NTl3SDV5V3A1Q2FSUFk1?=
 =?utf-8?B?WDVxMXdFdTJwTlZVNm1waTQxYXpkZ0RnKzdzL0dXN1FNWllOK1VFdzlIZmJY?=
 =?utf-8?B?YkZwZnZqQi92M1NyWEgycXl2cHo4ZnhYbW5za01Mdm95bnIzcEJpdm8vYnNj?=
 =?utf-8?B?c25RWUsyV1dCb3ZKaTRsOFNMU2RmTGM2VkRkRFdnREtBNklrOUYwbk1CU0Ny?=
 =?utf-8?B?MVNheVFKSERMb1IrUDMyNnRqMXVUZ1lnZEJtbXBPczVwZjR4U1IwaTIreGRa?=
 =?utf-8?B?THJOSEN3YVI5ZFdpUnpRdGFnV29BcWtZUnhyMFJYbFl2cXBTOGNiYXBhQkg3?=
 =?utf-8?B?NFJVM1NhaTBsVVRHcGxac0JzS2k4T1FzT0srRnFmd1VFaENGN3VVOGRYYWds?=
 =?utf-8?B?Ymc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7290fc70-753f-47ea-ad1d-08dd9d1e5abc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 12:59:45.4694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qmwqB61uuzXK0IL0ix4jEnq+z98tql730ESl482RiwiN/MAyp3aJ3g5UYiQH+q9cwDDTTlU33B+sOLCTV39N9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB9089

From: Jan Kiszka <jan.kiszka@siemens.com>

Permitted according to POSIX spec. Adjust the testsuite accordingly.

Fixes: 633022801750 ("y2038: cobalt/posix/clock: Adding clock_getres64")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - also adjust the test case

 kernel/cobalt/posix/clock.c            | 2 +-
 testsuite/smokey/y2038/syscall-tests.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/cobalt/posix/clock.c b/kernel/cobalt/posix/clock.c
index 845918a4a1..e6c187ca40 100644
--- a/kernel/cobalt/posix/clock.c
+++ b/kernel/cobalt/posix/clock.c
@@ -103,7 +103,7 @@ COBALT_SYSCALL(clock_getres64, current,
 	if (ret)
 		return ret;
 
-	if (cobalt_put_timespec64(&ts, u_ts))
+	if (u_ts && cobalt_put_timespec64(&ts, u_ts))
 		return -EFAULT;
 
 	trace_cobalt_clock_getres(clock_id, &ts);
diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index 7b56d281a6..4318712cc4 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -363,13 +363,13 @@ static int test_sc_cobalt_clock_getres64(void)
 	struct xn_timespec64 ts64;
 	int ret;
 
-	/* Make sure we don't crash because of NULL pointers */
-	ret = XENOMAI_SYSCALL2(sc_nr, NULL, NULL);
+	/* Make sure we accept a NULL pointer */
+	ret = XENOMAI_SYSCALL2(sc_nr, CLOCK_MONOTONIC, NULL);
 	if (ret == -ENOSYS) {
 		smokey_note("clock_getres64: skipped. (no kernel support)");
 		return 0; // Not implemented, nothing to test, success
 	}
-	if (!smokey_assert(ret == -EFAULT))
+	if (!smokey_assert(ret == 0))
 		return ret ? ret : -EINVAL;
 
 	/* Providing an invalid address has to deliver EFAULT */
-- 
2.43.0
