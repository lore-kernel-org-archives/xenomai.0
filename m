Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013051.outbound.protection.outlook.com [52.101.83.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B3837A488
	for <xenomai@lists.linux.dev>; Thu, 29 Jan 2026 07:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769672757; cv=fail; b=Q4t1AxJXZqV28nQ/byfr44lGfusfwsLTfcsR/lpqXMIfHiHWeug82Kqr26xGjzjyHIrcK6IDbPwcTcc7EkJTJzQdb+xs1p00zPxHErfHp5npLoKHV52/0W2d4Df7u/py27y0LnoNkjjBZG/UtqstJsVfRlzd/JklTYbgNxwKY7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769672757; c=relaxed/simple;
	bh=3sup1SWIdSswY97C7wy9iDmvofuGFRcpzfP104OzfE4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PsD7S+8ShAofP+yY5EUqUJgKj3CRmqG0at4sWjuz7lHl2nihXVKGUfLzCWhbjhvaDcThzpYmEDPat8WPclaPubg8Bd66KGLkEJ7IzfjQF7NS38aZ1jJ+PxWB/+x6skRGNr4IBXW3nDTF/oCgnZ4wk8nS9Ndl3EDXVkQ3UMyuYmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=iagXb+13; arc=fail smtp.client-ip=52.101.83.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="iagXb+13"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ra6XCZ4ETHm+kuGqErRkoVr0V7GjbsxdKEvE5bE0Ke8YmzLkLB0A2AAW0SkDlYxYRSCBmSFdkzn2+3nNA/im/xyQGvry5OviMwyr/64Q5hjidGZcTw5cRBGMAq6eBQsqmYXbGMqeY4oaFQKfmGmYE3QrF+mEZSbPiFeVFQPGZYC3mjcbSEAUSTsq/5VCiaS825y21yYLTYePIo5Bg+Y0H1LqI5UGqMvqLkAK7rKByM2PjOO27jgm450xaf4rFFKGn6VHSwnx1ELRgv5BhmUe2rJFWESuyKq4TFCqXVDjls5cKZ1Np200QF27DJrqJNbmCkUBYEHPKy8A5xs/PmBZEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wiUeS9DLlS47uXNLO/ruNICNEXtqXTiWEgTPRu5YYkk=;
 b=OBZ0jpSxcGssdLAW+sML/2NW1rZO2kr/xXvIWLOn34206R9+aKB3yOBLIVO180XlHRqdWtYIDy/2a5sH1He8ATmQ4AlnC/HGKiN7T5/aDstk6MuEy3FTKkCd7fFU7ElbUTr1ibbAW8fvASsg5lOSEw4erY4eFs3C5uA1kbbz1zwM3vAUzTLBrXf9OLNQpCasa0YIfcChSgfaGtXNgK3irhL+L60AUP/DaSgT0x8SvBF04S3Sq+CMZFPwwzEU78dQN0cGf3BvrU8WeCP6xAHPS9+ppkbVGXDx5H1sYj8eEQvnGfkKipPmeoxiBsfKT1PiETR5xZu4uLIDkmDhHlaXkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wiUeS9DLlS47uXNLO/ruNICNEXtqXTiWEgTPRu5YYkk=;
 b=iagXb+13yT9LHiOjQSbpsIwNoQwVsPgo4ML71l6ZKUQIG7eRQlrO283Uc0f+uaOPSlYd3TAvwC3pKAvgN+A4eUswiP4TeamjFQ+aQZg7zgZASvwhSrrR2gB0XPb7Qf5Mi/tBVME6+bTfoBITSG7/+LB5foNqFlkRwQsPppyMpfU8k9UNQC37iNp+zMat9bsvCWErDcUJdr6LnWuV8IKNP9gacrUAbsJ8bMTjLyGAURTgtDrzOypmIZRxizBa+BV/gX7JRxofFXXyPQm2Vo5Nu5AzqqLUQg5/ZO4YbHwTY0lbUk2bBwCA3uz1jsTZAbTWz2NKUvW3GEKYmYiOOiiaMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS5PR10MB8176.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:678::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 07:45:51 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 07:45:51 +0000
Message-ID: <2c9f0b74-4e8c-4542-b0ef-ee13ad21c2d0@siemens.com>
Date: Thu, 29 Jan 2026 08:45:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix race between RTDM task termination and xnthread_join
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at
References: <20260127213927.26960-1-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260127213927.26960-1-richard@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0430.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS5PR10MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: dd907c32-3271-4010-b506-08de5f0a6cd4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWVsVUxlUEZ0Uk82azR6L0RmSCtBeW9KVWdzNklqK1VDK3RhbW1DcEc0RXY5?=
 =?utf-8?B?elVTZ25PS3hlQ2tGTjdHdnNZb045UVlCTmJEZklKUjVGc1RZVjI0clBrSnVK?=
 =?utf-8?B?WmJuQnUyd0tmMjhYbGxTZXVLWkJzU2V3RHlYMnBSWDkwWW13cnhLcFFOSDIw?=
 =?utf-8?B?NmdPVTJOejZHZi9BNkFmVjZ3a1NoSnY0SS82dWNPczFzcEdudVVzeGs0MURh?=
 =?utf-8?B?bnFBUGJnRlNZTnRnSm1Wb2ZTTEdGNkFuYUpkRU1iVHVSVExiQitLZkhLczJH?=
 =?utf-8?B?MlcrVkttOGZBZk9IbWZKTXdRSms0NGU5aVlQOHRLeWs1Rk5zaGNpRS85Tm1a?=
 =?utf-8?B?OUF4TVZIMjkxSk9RWjhGNDhpeGlLcndtWVdxL29KcVllYkNtcHAvWVFOMXUw?=
 =?utf-8?B?TW1mUlhGVmp3dDJHMVZkd3JiYjZoSkxieWlMb2IwdGNoVnNPRXBoeDhZa3dk?=
 =?utf-8?B?MDFQK2ZQNnVGci9wUmxpT2twTmh2WFMrVWYwK2V0OU5tU0w2TXcyZmE0OWFv?=
 =?utf-8?B?K3N5RkxQZ0hYdE5QWVBIalRmTEwvZmNiakFkUksvZWpmeE9vcFdzK0lCa3pt?=
 =?utf-8?B?akI3MjlBbWRRZVNiekR3VElwOTZraG5tcmZyTjRPWkx1QXo4Z3kvSEdaTmRX?=
 =?utf-8?B?cWtvaStsK1RqbHN0bW5nUHpsWFBkdXFNS1hmL1JhL2tMUEpRdW1OMkxkRUkw?=
 =?utf-8?B?aXFXajFPeUY3NGhudjFOOWxaK01SVU15OXVNRjl2WnJVL2FtTHJwVFhCTWhD?=
 =?utf-8?B?NHZmcGwremdoUnh0aHVwTENlaUpHOUVzeU5rYXc5bWo2elNqTUFPc1VQMncr?=
 =?utf-8?B?QkhQdkMxaHgzM2hyMENQVW9mTDZtODNkTXQ2TWcyNjNkT0xjYTc0bE0vZm5n?=
 =?utf-8?B?OUZtYTB4dlpEbHZuL29QdktJUlVMc3VPZm9vS2ZpWW5sUk5xeU9WK0dUcytK?=
 =?utf-8?B?ZjU1Um5IUEs5aGp1dHNIVXdtQ3J5YzRTdHZFUU5qSVppVUxxRkVublQ0M1o0?=
 =?utf-8?B?WEZOcTAxZ1R4RlBLNWJEaGVGYnZNS1Q1WjljbXFZd0xreU4ycUc2RnNmcGxt?=
 =?utf-8?B?VGVUa3dRbDBiaHFKQUV1VnRUWGJmakI2VjVqdWdZZDJQbjZqQXJON1p0b21x?=
 =?utf-8?B?bS9IcVRhRHB6NDRXVndvVS9pcUdjTzNHd0NBTUQvS1RGM3FobDA3MmRPOFIr?=
 =?utf-8?B?T294M3NjeHhBeDVKSHRsK04vSmVlaFhLVnVEd2hzclE1NXBPMEFuMURsekg4?=
 =?utf-8?B?THZKa1NUWEU3cTlaS2xtdG9WcVQ0MGNlOThrTXREOWl4ZDhtQVI0bnMzWWJv?=
 =?utf-8?B?cDhwak9sc0Zqd05SbE5OTDg1RytTYWUyaDcwci9CUFErbXF0eWxJdTh3dDFs?=
 =?utf-8?B?NTU4L0tKVnNGQVBiaHd2V1pTSU91QlJRenkyRC9IWElPd2ZlVFpEdVFrUDYx?=
 =?utf-8?B?ckQ4SlhNb2NHbzV0TlliRjVqdmU3dG9nSk9mOC9yUituaUxTKzdMVkZOeERj?=
 =?utf-8?B?VkJSNXlOTEUxREI3Z2RsVlE4dUYvVlY5UlFxZXRmblBJemZhYUl4a1RjdGFC?=
 =?utf-8?B?aCtCbzFlcjhYMCttdm9EcmFHZ1ZlUXhielZqcGdNSzZqbTEyT2p0dmZhN2FD?=
 =?utf-8?B?ZXozNThLbjhEQXFWVURlbFlPRjkzZWYxbjJIZTRnNEI1S1puWFZ3YW5wc0Yv?=
 =?utf-8?B?ckVKYk1Ud3VKWnU3QUhOZW5QL1dvc2FDa2NNRWMxVWpFdHJ6aDV2KzdQYUFN?=
 =?utf-8?B?SVEwVHA5anFla0VmMTVVYURsYWtJZU5CM3E3Z3l3U01Oak04bVh5d1liWWx6?=
 =?utf-8?B?Tm90dGtOamY4dVI0VkR0b3F1b3YzdXhIanVmN08xSUY4KzFxbExRajBmcHFw?=
 =?utf-8?B?L0srSzBtcDJOSnVEdlAwT3p3VnU2R3J3VWFTWkRJTnZtU2duVXlNcHJob3ZL?=
 =?utf-8?B?VjhVUENlVnBrTXVSWlpLbUlZZm9ZYTM0SFQyazJjOHZkd1gwdFZDWnVQaWZt?=
 =?utf-8?B?czF4RC9rQ09NOGQ2NUtTT2ZQVUg5QXN6NENzUHBROUdIaWFFNXM2T1ZTZVRq?=
 =?utf-8?B?V1FLKzNRUUxXWjRoa1k3LzFsTEowTlZQazFuY0JHYjNnMG5pQzJQNWhsdmxk?=
 =?utf-8?Q?h+lc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Yjd4MHFiYVhnV1BJMGZwb3NuMFlKSzFmb001TkVOSnNKZ1FLbStnSHJJZ0RW?=
 =?utf-8?B?dWVDOW9peHJEWHVPNE5hR1dDWWl6ejJqcGtCWmx6d0hhUE5mV2I4NFZNWEdX?=
 =?utf-8?B?QUg5em5halNFcFJENzJVR0M2UUFLYXc2Z2NXMXZVQ1czZWZEV202UHhwejB4?=
 =?utf-8?B?L0lHYm1wM21VZzMyZ2VmdzQvSmQ4RUw3ZWdheTR3d3hYUnhOVXFjNG1TUXR1?=
 =?utf-8?B?K3hUUkJwTjA4alZzSzhoRGFIbytrdlJBOWptanY3eTF6Q1FKN0ZDSmlBK216?=
 =?utf-8?B?akxlMVdqc2NnVXJzNDI2NzNDc0pJTzZzTmQ3V3BNQytGMUNMc0p6KzkySkRN?=
 =?utf-8?B?WmtCMGdJZmlsdzY5OW5QMDlCQUpoODg4NW5kcVIwZ0ZWaHZBbUJXalpibG9Z?=
 =?utf-8?B?REZTR0IxTTdvVCtVaVRMU1BoWHRwSFRYSDNKbmMrMTBQUnV4dkZRTlZnVzJB?=
 =?utf-8?B?Y1lFeW04K1FwQldLazZGeHo0YjJ3S28rRmx0YW9KSEdVRHN0R09hWkk0d3l2?=
 =?utf-8?B?RE5VMDVJVyt2dFlacStrdkJPMVk3bEVUYjkvaEZDUXcvcUVHYituZXY4cWE1?=
 =?utf-8?B?S1lxL2k4WUFxbmhHZVo5TzZPdlJwM0Q1MXhDRW4yME05cVVCa3BzdnViMTUv?=
 =?utf-8?B?Vll6MmcwR2dtMDBXS0cxSzNPY3JsVDdmVDhPVGFReUxrSDZkai9USE4xNkpr?=
 =?utf-8?B?MGNZKzg2dm14aEgyeUhQQVByVFc0N1NacUVnNWErbi9xbFlXMEdyNldxWGpD?=
 =?utf-8?B?RmlDcnNtUCs0aHY0QjlBVCs2QW42amVGNTVwa1VVMWdDYXJDYnhFS1IrN2Z6?=
 =?utf-8?B?MEhKV2VxaWhyb0o2MWNFaGVEb2c4OG4yOUxDTHB0Y2ljRzVvQWNYMlR0QnBs?=
 =?utf-8?B?QXc2aEJQVEErTzY4K050ZHJNN29wRW1xZW1NUnRMcUdjL3I4WVN1Tm9FeEhp?=
 =?utf-8?B?YnVxbExRMnc3dXo2QU9EcExjbVNVa2ZYZ0VpQjhNTE1yWGJtbWJDYmlWd1RG?=
 =?utf-8?B?TTMyc1YxdzNVTk1PaUdFaGh5TVdxVFBxK29zQ2Y0OVJaQTF5dXg2Z0Q1Ukdx?=
 =?utf-8?B?RHAvcW9GaW1UTGkwNVpVa1FFblNvN2x2VmNobGVXdWRqR1Z1Q2lZOXMwN2hM?=
 =?utf-8?B?NkY2VmNxRGUrQ3NVZFlqakZ1OEdPQU9OVjFsUWprQkxlSFIvZmtqYXZtTDR6?=
 =?utf-8?B?RGJjS2QzQml5QXhuZTRUcGpmM1VBam1RK3pWVlBmaFNiWW1vK2VNbytJTXBK?=
 =?utf-8?B?aTE0OWRiYk5rOSsvODd3dnR1ZmhLNytXcGtmSEZseHFHemV2a1NQZHJDSnZv?=
 =?utf-8?B?YW5zMzZhNWhPTU9NZHc1SDlpU005RkNRUlNZT1ZFRUlnNUF0V1IwdUpaNkdK?=
 =?utf-8?B?U1YzR1RmT2dPVGR3ME9idnQ2dE9ESnU0cG5mMHFGZWZVN3RGeG9WOGoraW5Z?=
 =?utf-8?B?cFhGcHZtWEFzRmZ6Y2c2ZWg2dTUxem84ZVBRb2lsQk9LLzAzNHBUU2c1Vm85?=
 =?utf-8?B?aktLdlhpamt1Z1BEUTd0amZURTlsalhaY3RSMlRzSDFUY1hHN1BiRmM5cWd5?=
 =?utf-8?B?azM0S0hib0hmMWtDSExUL3doZmx3K2R1QUJwOHpQT0tHY1RpenBxd2RVenBH?=
 =?utf-8?B?b21mbnl2ajJCRmtlZVpLR1FrR0x3SFUrbDhnM3pDK0l4NnI1WStwY0RDVXFh?=
 =?utf-8?B?S0o4YkY3d1ZNU1VPdXRVN1JZM0ZtcmJlaUFsM0MrbVQrcnJsVzRCb0R2QTla?=
 =?utf-8?B?WWZrc3lTQ3orbG12SE9JNWdsMWEvb2VrTTR2K293azZNL3lveEh0OEVjbE5u?=
 =?utf-8?B?c1QwM1lqczhYcFZ4ZmFFeis0N0dRUEZNNnkzTHhGaHNmVy90cEtzRjBqRVA4?=
 =?utf-8?B?SFZZVWRLbDczT3lFTUtUMy8vU1RKd2d5N3VZcUF5Qm1CTGpEUDNZYms4ZlNa?=
 =?utf-8?B?ZzZnQjRWb0tIbDNEYzVFV3pkZnFobkpKTGNScjlWelZMT1phZGdPRnV1OFd5?=
 =?utf-8?B?L3VMWTU5dzNLcWNnRTJ3bTlDU1RMTHhTaHJHMTk1OXMvZGljQ3ZqV2RLdVJz?=
 =?utf-8?B?MVdraW1KK3YxRzhpem1uOVJhNWRFWHlBcHFUdDZTNHk4SDBZQ3Fqb0I5czRu?=
 =?utf-8?B?bUQreUVYYmVSVDZzWjRQYUVERmlkWTJjRTRCRmt1MXF4QTRrT3BPa1dlemE0?=
 =?utf-8?B?R1ZFaGhwOVRUaldaM1kzd0lId2NLUmRjY1N6bi8rZFZFbWcvbjhva2hIeXR4?=
 =?utf-8?B?QkdlUkpidGMwVThQZkxsNFFqWkdKV1hUdkFGa2FRcmhpWGdCWXF6ek1MblFu?=
 =?utf-8?B?K1kxSkljWm5mUjc5SUhPaWVxZFZHOWpqWURLcEhyUm5YbXhId2Nadz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd907c32-3271-4010-b506-08de5f0a6cd4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 07:45:51.5790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x4mGolB2WtUYEr00gfwr3HzJKHoIvO6JKTRm6tgG14ySqEMVo/ksgaRG6SDEMuTD8CTSy8vqNxR/G+s9RTT9SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8176

On 27.01.26 22:39, Richard Weinberger wrote:
> Ensure that the task structure remains valid until the join operation is complete.
> Previously, a race condition could cause the structure to be freed before
> xnthread_join() accessed it, leading to a use-after-free scenario.

Where exactly? xnthread_join performs some checks for the existence of
the target, and it is locking it (find_get_pid).

Jan

> 
> [   21.643656] ==================================================================
> [   21.643667] BUG: KASAN: slab-use-after-free in xnthread_join+0x7a9/0x8f0
> [   21.643710] Read of size 4 at addr ffff888108929550 by task rmmod/249
> [   21.643715]
> [   21.643730] CPU: 1 UID: 0 PID: 249 Comm: rmmod Not tainted 6.18.2-g768d3d5bf800-dirty #60 PREEMPT(voluntary)
> [   21.643736] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
> [   21.643740] IRQ stage: Linux
> [   21.643743] Call Trace:
> [   21.643748]  <TASK>
> [   21.643751]  dump_stack_lvl+0x94/0xd0
> [   21.643762]  print_report+0xcb/0x610
> [   21.643769]  ? __timer_delete_sync+0x120/0x1b0
> [   21.643776]  ? __virt_addr_valid+0x1dd/0x2d0
> [   21.643790]  ? xnthread_join+0x7a9/0x8f0
> [   21.643795]  kasan_report+0x96/0xd0
> [   21.643801]  ? xnthread_join+0x7a9/0x8f0
> [   21.643807]  xnthread_join+0x7a9/0x8f0
> [   21.643812]  ? __pfx_xnthread_join+0x10/0x10
> [   21.643817]  ? mutex_unlock+0x7d/0xd0
> [   21.643826]  rtpc_cleanup+0x2b/0x60 [rtnet]
> [   21.643844]  rtnet_release+0xe/0xd00 [rtnet]
> [   21.643858]  __do_sys_delete_module+0x315/0x4e0
> [   21.643864]  ? __pfx___do_sys_delete_module+0x10/0x10
> [   21.643869]  ? fput_close_sync+0xd8/0x190
> [   21.643874]  ? __pfx_fput_close_sync+0x10/0x10
> [   21.643879]  ? pipeline_syscall+0x9b/0x210
> [   21.643885]  do_syscall_64+0xea/0x3b0
> [   21.643892]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [   21.643898] RIP: 0033:0x7fca2bc38b77
> [   21.643903] Code: 73 01 c3 48 8b 0d 89 92 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 b0 08
> [   21.643908] RSP: 002b:00007ffdb96b9bd8 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
> [   21.643916] RAX: ffffffffffffffda RBX: 00005634eb2f1490 RCX: 00007fca2bc38b77
> [   21.643919] RDX: 0000000000000000 RSI: 0000000000000800 RDI: 00005634eb2f14f8
> [   21.643923] RBP: 0000000000000000 R08: 1999999999999999 R09: 0000000000000000
> [   21.643926] R10: 00007fca2bcacac0 R11: 0000000000000206 R12: 00007ffdb96b9e20
> [   21.643929] R13: 00007ffdb96baebb R14: 00005634eb2f02a0 R15: 00007ffdb96b9e28
> [   21.643934]  </TASK>
> [   21.643936]
> [   21.643938] Allocated by task 2:
> [   21.643941]  kasan_save_stack+0x24/0x50
> [   21.643946]  kasan_save_track+0x14/0x30
> [   21.643950]  __kasan_slab_alloc+0x59/0x70
> [   21.643955]  kmem_cache_alloc_node_noprof+0x12b/0x540
> [   21.643960]  copy_process+0x345/0x66c0
> [   21.643966]  kernel_clone+0xba/0x6e0
> [   21.643970]  kernel_thread+0xc6/0x100
> [   21.643974]  kthreadd+0x397/0x570
> [   21.643979]  ret_from_fork+0x232/0x290
> [   21.643986]  ret_from_fork_asm+0x1a/0x30
> [   21.643993]
> [   21.643994] Freed by task 0:
> [   21.643996]  kasan_save_stack+0x24/0x50
> [   21.644000]  kasan_save_track+0x14/0x30
> [   21.644004]  __kasan_save_free_info+0x3a/0x60
> [   21.644010]  __kasan_slab_free+0x43/0x70
> [   21.644014]  kmem_cache_free+0xd6/0x470
> [   21.644018]  rcu_core+0x56d/0x1a10
> [   21.644023]  handle_softirqs+0x186/0x570
> [   21.644027]  irq_exit_rcu+0xb3/0xe0
> [   21.644031]  arch_do_IRQ_pipelined+0x10e/0x550
> [   21.644038]  sync_current_irq_stage+0x353/0x410
> [   21.644044]  irq_pipeline_can_idle+0x6d/0xc0
> [   21.644048]  do_idle+0x337/0x4d0
> [   21.644053]  cpu_startup_entry+0x4f/0x60
> [   21.644057]  start_secondary+0x1c9/0x250
> [   21.644062]  common_startup_64+0x13e/0x148
> [   21.644067]
> [   21.644069] Last potentially related work creation:
> [   21.644070]  kasan_save_stack+0x24/0x50
> [   21.644074]  kasan_record_aux_stack+0x89/0xa0
> [   21.644078]  __call_rcu_common.constprop.0+0x70/0x8a0
> [   21.644086]  rcu_core+0x56d/0x1a10
> [   21.644089]  handle_softirqs+0x186/0x570
> [   21.644092]  irq_exit_rcu+0xb3/0xe0
> [   21.644095]  arch_do_IRQ_pipelined+0x10e/0x550
> [   21.644100]  sync_current_irq_stage+0x353/0x410
> [   21.644103]  irq_pipeline_can_idle+0x6d/0xc0
> [   21.644107]  do_idle+0x337/0x4d0
> [   21.644111]  cpu_startup_entry+0x4f/0x60
> [   21.644114]  start_secondary+0x1c9/0x250
> [   21.644118]  common_startup_64+0x13e/0x148
> [   21.644122]
> [   21.644123] Second to last potentially related work creation:
> [   21.644124]  kasan_save_stack+0x24/0x50
> [   21.644128]  kasan_record_aux_stack+0x89/0xa0
> [   21.644132]  __call_rcu_common.constprop.0+0x70/0x8a0
> [   21.644136]  finish_task_switch+0x47f/0x610
> [   21.644143]  __schedule+0xf4b/0x2b50
> [   21.644147]  schedule_idle+0x5c/0x90
> [   21.644151]  do_idle+0x26d/0x4d0
> [   21.644154]  cpu_startup_entry+0x4f/0x60
> [   21.644157]  start_secondary+0x1c9/0x250
> [   21.644161]  common_startup_64+0x13e/0x148
> [   21.644165]
> [   21.644166] The buggy address belongs to the object at ffff888108928f80
> [   21.644166]  which belongs to the cache task_struct of size 3840
> [   21.644170] The buggy address is located 1488 bytes inside of
> [   21.644170]  freed 3840-byte region [ffff888108928f80, ffff888108929e80)
> [   21.644174]
> [   21.644176] The buggy address belongs to the physical page:
> [   21.644180] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x108928
> [   21.644185] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> [   21.644188] flags: 0x200000000000040(head|node=0|zone=2)
> [   21.644195] page_type: f5(slab)
> [   21.644201] raw: 0200000000000040 ffff8881001d8dc0 dead000000000122 0000000000000000
> [   21.644205] raw: 0000000000000000 0000000080080008 00000000f5000000 0000000000000000
> [   21.644209] head: 0200000000000040 ffff8881001d8dc0 dead000000000122 0000000000000000
> [   21.644213] head: 0000000000000000 0000000080080008 00000000f5000000 0000000000000000
> [   21.644216] head: 0200000000000003 ffffea0004224a01 00000000ffffffff 00000000ffffffff
> [   21.644220] head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
> [   21.644222] page dumped because: kasan: bad access detected
> [   21.644223]
> [   21.644224] Memory state around the buggy address:
> [   21.644227]  ffff888108929400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [   21.644230]  ffff888108929480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [   21.644233] >ffff888108929500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [   21.644235]                                                  ^
> [   21.644237]  ffff888108929580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [   21.644240]  ffff888108929600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [   21.644242] ==================================================================
> [   21.644244] Disabling lock debugging due to kernel taint
> [   22.758097] RTnet: unloaded
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  kernel/cobalt/thread.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
> index e9baf38e1..dfa5108b9 100644
> --- a/kernel/cobalt/thread.c
> +++ b/kernel/cobalt/thread.c
> @@ -228,6 +228,7 @@ static inline int spawn_kthread(struct xnthread *thread)
>  	if (IS_ERR(p))
>  		return PTR_ERR(p);
>  
> +	get_task_struct(p);
>  	wait_for_completion(&done);
>  
>  	return 0;
> @@ -1675,8 +1676,12 @@ int xnthread_join(struct xnthread *thread, bool uninterruptible)
>  		goto out;
>  	}
>  
> -	if (xnthread_test_info(thread, XNDORMANT))
> +	if (xnthread_test_info(thread, XNDORMANT)) {
> +		if (!xnthread_test_state(thread, XNUSER | XNROOT))
> +			put_task_struct(xnthread_host_task(thread));
> +
>  		goto out;
> +	}
>  
>  	trace_cobalt_thread_join(thread);
>  
> @@ -1748,6 +1753,9 @@ int xnthread_join(struct xnthread *thread, bool uninterruptible)
>  
>  	put_pid(pid);
>  done:
> +	if (!xnthread_test_state(thread, XNUSER | XNROOT))
> +		put_task_struct(xnthread_host_task(thread));
> +
>  	ret = 0;
>  	if (switched)
>  		ret = xnthread_harden();

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
