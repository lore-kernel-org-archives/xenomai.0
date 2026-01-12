Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013000.outbound.protection.outlook.com [40.107.162.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7B323ED75
	for <xenomai@lists.linux.dev>; Mon, 12 Jan 2026 16:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768234059; cv=fail; b=UBuDPhk2KM4DoHycDdOJYhfHpT2zeFBQBa7kb7QC62yth8p+9LSMcBhVnkTwoLqhb3DvnmodAYAapYrHMJKhY/PC8QUFINAgpLZ/27TzIVD2zoCd0sUZ8vA/6qz5vHELEbEByg77hyAUh5qBk6fHabD5pu0y5K7/m+EMxYGVlpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768234059; c=relaxed/simple;
	bh=ZCRjba6zYTFQ2IbgdBYKiAfXctwGLAak864JuqkkzvM=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dngQIC9CZt7QAZaIk6cRZmSptbmBJlvArF8s5Grm/2mujxHMBwoj4GdKiy65MvvpVaYsgfZLm6QahJBRNHg+KLqPAc8OdeszRQxk7MkfmWzjsfrQ++VQxYWGuvF5+0jJPDjwfp1YuWUh0Ov4G0vseg/3ToWFz9FPCxGbwa6Kb40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=bDmYWSMQ; arc=fail smtp.client-ip=40.107.162.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="bDmYWSMQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hdX5glrs9zd/kEYqdDnVVfGNJNec5ljwaXZWUxybhPjw9sTJRx5ePJqpZ+DvzDEB8MiXTXBJvv/EDl+tLSOkTB9c23wIcS9qDhOD4iSunjrFRFFwvzGwyOxBgSXT2pShtLEsKXAjSJyWyYgts06yAWi84g9dFjmYHNL3N8+qmfEAO7icybWNKzliE43F1GcC5lQMgtSuZ0csrxhnZVGGijcDQ/NzwZglm0rD72ChyP/zM6QLd3Lu65jGVs4T54ZbkE6SE5DRhEmGVy6EexzPQCsBKc66XEBeNfinrHMR3FJj0cQb67nydmZ3h+Ev4I2O4keRnmxRwK8Up7/ojjtyoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4bGJw0voDtSh22w3tpJXYO2kRJcekKW5dOPYaTxjqs=;
 b=UMuSs3pI3mstSelymDWlWurf5QeCxUuq/+zTAVqycIHzjrKPRWHslu5kkUqOS7GwUnVWfCDWYDRmB1okiHGkhMagOeHpcjittTgZ3Z2Y6ZXEcwEKkPQmd+SbbKzgWtKE3Bd15QC701NmFX+PPTPd/5fgIgJFCGROlErcw1bz8HC8DB0ZoFueS7tUo0LBvS6Cri+beOVGX4TCwMTEUJOqIfgTbXFfIT/wX1ACtPMSp23wYCnvAg8L/gdhe9rlWKO9IU8YGXnDgLggJV2+GSchcE8BCMKXuVFIWqAEDR97nM6EnepOxVd5r59yKBT3tKcPV5ryIm3uvtJDMvp2ThF82g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4bGJw0voDtSh22w3tpJXYO2kRJcekKW5dOPYaTxjqs=;
 b=bDmYWSMQnULGDpTGGeXRgUfrWYuOZhPcVbq/2q9TQg6GjE5P2DkL64L4EayhBYlkJcLztkOC65zXl3plelNVZS9NLcxSK+ZsjmXQmWTIKSCUYmfOuGTwtKXtKNY1iYzkyku2hi+QnOuD496stacmrJU4WK9FwWhiV5FO6caJ1AvgJ4JGbahJhfJFc9ITBHKD6V02sxrtASMc+tMrhz2gpd0ToTZwfqR0VZ89gzCaiQrWCQtlVdPCFMFCJGyKBkghlcozCH/0VghtkFDthHKKMbK1xjy+W1AcDwb1rdYpV1lwaMq76f90xO3l6ZKLij/GRLAUDDtGONhrQ08pc54CIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5146.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:342::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 16:07:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 16:07:33 +0000
Message-ID: <9586e808-89a8-4495-9543-fa9b1ea52fc8@siemens.com>
Date: Mon, 12 Jan 2026 17:07:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH v3 0/3] Trigger CI job for dovetail
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
References: <20260112123349.3945734-1-clara.kowalsky@siemens.com>
 <6648e0df-6b8f-4cac-b050-90e961d1cc49@siemens.com>
 <a65891c8-90fa-4923-946a-c6a3830dc75f@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <a65891c8-90fa-4923-946a-c6a3830dc75f@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5146:EE_
X-MS-Office365-Filtering-Correlation-Id: 3db65749-1907-42fb-3419-08de51f4b1bb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVJQMEw3Q0g1aEFyLzhNNjBXaXN2djlreDVwdWo3OVlBUXFWUFY3cnNNQzRP?=
 =?utf-8?B?aENPSCtUQ0w4OTlzM0svK0JpZVlSWUJLWWlrK0ptVkEwdzQxT1drd0dkUktk?=
 =?utf-8?B?TlVEZnRoRDAyZmZISWVRL3lHaGc5UEdzb0d0VndXZFNXK1JObk5jc09iNk1p?=
 =?utf-8?B?RGlnc3Zaekdrd0JlOE9iMEMyb0xBY3pNSUZUd2Q3WDdUSElmdDlhUzhZR3NF?=
 =?utf-8?B?SHVvNTA1SDlqRkFOTkFxQkQzTkNXK09UOU1YS3J1ci9tWEUxSDRXc2prQ2dY?=
 =?utf-8?B?RzRJOXFlSjJyY1puc2Y2dFg2UmM1T0JGMXpSc3gxVkJWMGg2NXdIZjMwSUJX?=
 =?utf-8?B?OXMvbFUwazVoeVMzYkVuMlN6SG5ja0ZKRFIyYkw5WkEyRkFMN3RPcUxtdldl?=
 =?utf-8?B?ZDNPakVhbXN5TE4ydWZYUVJkQ2txTFZHcEpWc2tWQ1JManlGbEp0QUVvb3VD?=
 =?utf-8?B?MnJ1dTBvUWZhU0xqU1RZdGhCM2FpUXl5aEUxUU9McExYeFZqWXFpZkNpN0wy?=
 =?utf-8?B?cE9CNlMxMlFsK3RCamVJWHlJTTZlV3ZlSDA0R2RHQkxjczNiSU1iMFhzN3ZO?=
 =?utf-8?B?empXZTZ1dElXMlRUSFM4Q1J1bitxN0UzWmpYNlR3MlB5NGV5RTc3eGNzMmlp?=
 =?utf-8?B?Wld1N3JWMW5LQnBDaDRramNYa1JhTjdaUDBESzJ6ZlMzWnBxYlFLcTJkVStM?=
 =?utf-8?B?Z0dPZW1VUVlJNmNYMmxjOWV4dVFpd3pCZFR2UVROYnFJWVBoSW5kZUhSQlN5?=
 =?utf-8?B?Sk5IZDNqMGFRdVBUeHEwdVVQNnpNbUtUM3hGdU92VzRHYmJrTEplbDltK0hK?=
 =?utf-8?B?YmhlK3pDWmpMOHU4RmFYUHp0bVRkTk80ZHZlVjM4MDcxTktLN1dEV0ZaSXJU?=
 =?utf-8?B?dTFoZUNjOEhIY0Nnc3RNdWp0SmdQcDJucFR1bWNReG9BOEJGM1dyandDNDZU?=
 =?utf-8?B?aDA2S0JFN1RLRmZLWEIwdk5KdzJ0YVlQRXcyaWhCNU9DL3VieTFTZDVPdUJp?=
 =?utf-8?B?VzE0NG1IMW16RjJlZDF2SktGN0RsbDZFN2k3bjBxU0grcFdCUkpGa04vVGVi?=
 =?utf-8?B?S3R1L28ydU9EQjlubVY4UmI3bnoxWFZYTHZHVzFGY01VK05pWVhheXRKa2FE?=
 =?utf-8?B?VlNiQkZxbncyelF5b1JVSysyVmYraDFLQW9EWHRUdjBBTjF0d2hwSU92TmJo?=
 =?utf-8?B?bkhYOGUrL3l0QjB6SHlobnlWbUg4UlBPQ2hRSmNxY3hiQVFaRGVHVGpqc0Mv?=
 =?utf-8?B?UHduUmpPWVFvZm5uVEYxbnByUkhCck1FRGRsRkN5a3VPR3NjU3R1dm1Sbm1P?=
 =?utf-8?B?RmZta1VVdHRmbXFGQ21YUkxvcFJPK1JJZFdlWHBaSUNZbEM1ejVxTFU4WEo3?=
 =?utf-8?B?S1Rhc0dDNnVhTlZYbWQvcWhCSEoxaHRTMjNyamc5b3EyUTlxeC9nKys5cGhv?=
 =?utf-8?B?Y0JQbjNIOGJBc1d5SXJja0tOUkFJQ3Y1TnBEYzlQR05CT3NpK0JqWXVyOUs0?=
 =?utf-8?B?ZHdtdVNqQVRHNnR2R2NaWnBwY1BJQ2svbzJrd2ZjS0tnOTJhZXFHRlQ3Qlc2?=
 =?utf-8?B?ZVRpOXpzVjJUYllmWlNEd2NQT2VOVWFEVHkybXN3RXliUVArL2hMRzVMSlZZ?=
 =?utf-8?B?SzFyVWlzNTJ4RVVrQjJ0RFVCbmcyN0xOM21WUkxRclVmNlVMUGVLOEh1NHNV?=
 =?utf-8?B?RnlPcGFFMWR5cThNRS9DV2QyVm41M211d2lsbnNaV1ZKUTNGbW81L2liTE1v?=
 =?utf-8?B?cjg5cndPRWpoWXFUUWlEUEJUN1MzTnFPK3U0dGNnVFIyQUF3ay9HRWZFSHp2?=
 =?utf-8?B?SjdVR1ZVSVBhNkFKN0Q2aEI5NW1NUzY3bzN0Ym5RR0dWTTMrR2QzdGwvZUxD?=
 =?utf-8?B?bFhaZmlwQk0yV0ZQQTRzdXRoUjk5S05ISEhGTmxHM0Qvc3hqcURoTjRnRDhI?=
 =?utf-8?B?dzdsb3prY3AyUFdBWlQ3S0VubDkyNWFmeHNtVUkxVEVGUHFoMDV2dUR1Tnh1?=
 =?utf-8?B?bXczQnZpcytnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3VTT0xTc1FWanl1cEJHejNlaER6UU5Cc3JZSnpIdndXVVpsb0dzNGszTmEz?=
 =?utf-8?B?SWxXVnhLVUhzaStrQzRBRXE2YWJDN2pQTUJ5aERMcTlDRnRzQWlNR09kTENm?=
 =?utf-8?B?aGxJSWJxVHlmQk02czBFaFd3SDJmTjRKMEp4V3hlekFxVU1XR0VHTnhlcno1?=
 =?utf-8?B?TDB2dWdNR0t3RzlhdlgraFpUeWtjbStXOVcveTAyMDFvYzZibEVvQzUvWkpX?=
 =?utf-8?B?cWNUYmh6bVhHMDFvOXFGaFRlMnFtR2VBeFN4R2NJOGxjT1BXb2FJaFd1ZU5N?=
 =?utf-8?B?M01mUE9PS09CN3ZKTTJXd2pQTDNjTjdrZmxZaDR3Z1Y2d1p1WER3M2pxZGxa?=
 =?utf-8?B?UUJJM2w1T0FSSzJzUnA3ODBmVVZLT3ZBa3hiYnJpc0NoZTR5aUF1eUk4WDUy?=
 =?utf-8?B?aFM1bU4xVGlZZmV0R3ArM0NlODVpTHBBcWJKNVhEY216ekkxcTY2bjFEZnpp?=
 =?utf-8?B?elRRY0RXU1VnSmhQbmtvNlY5L1Y4RlFVYjRtWkRKL1NjRExZUU1BUUxiTjB3?=
 =?utf-8?B?dkxsZk1ucStqZWhOZFRwVXB5VWloU2ZIZ2dxa3pnTjB6anFVTUNnRWlENTZx?=
 =?utf-8?B?SFdoM00yQ0w0R0hQODV1ZWRwb09iSkVzdGRLSXRDcHIxcnNDRTUyb1M0ek5z?=
 =?utf-8?B?TS9sKzczQk9HWVNpL1ZFYlptY1YwbzVNOE1PZEp6S3phSldnWURibEtxbHZI?=
 =?utf-8?B?VWRKNjJSLzlCdjN2YXBBTHBGQldtNmcrc2c2eGUxaHBuQStLT01GNjNhcnJn?=
 =?utf-8?B?R2tsaGxDemJlQWUzMXNlUm5BQlBuL2grNDJnTkRXYjVNTUZ0ejdtZ3BoT2tu?=
 =?utf-8?B?RTdVTnJwU1V2NjJGR3VOUzFMS3FvTExmQlVzSXQ0VDJVd0ZTZ05RYXA5Q3hH?=
 =?utf-8?B?dmVTTmlicGh3cjdiM3p5UVhDbEpkcHF3QjFoMnNORTRwYjRHcGhocnFOd1p3?=
 =?utf-8?B?a3hhWElHRzRlV3lmUGlTRUhJV2kreW9EVktRWmlLSDZGclg3SDY0bE9Fek5h?=
 =?utf-8?B?cm1ZclRCcG9CT3J4TTJBd0tQekN3YVFjUjBReTl2RmhkS0dqMTFkUDRaWjRh?=
 =?utf-8?B?L2VTak80TWF1QS91c2hBcmx6Mzl5RStmelVLL001aFo3Y25acUNoalBOeHEw?=
 =?utf-8?B?UnJ4ak5vMWdSMis4NGlRTEhUdHRRb0txTy9TRjBKOUE2MHdJb0l0YjROcGFT?=
 =?utf-8?B?ZkQxN1cyNnliVDhJWGJabVhCSmYycVdUTlRrcFVucHNnb0dTY1VoVHRBMk1X?=
 =?utf-8?B?OE5Pdkd1dnp1enJKcy9iKzR5eXYzMlR2dTY2WG51TjZKU3ZiMHZ3QkVwZGh4?=
 =?utf-8?B?Vi9sQ253dCtSbjVpTEVLSHBkVUFTSVdjUGpWSkp2b3EyQUgzaFNUcnlVSXdE?=
 =?utf-8?B?SFhtdHZXcjhVY0VkYnlMTHd4dTdTbmNMSUxNdm1EclRvRDRWZW0vS3Jkdkh2?=
 =?utf-8?B?RHJCMEFzVG1QNkZsTkVFbkNxOE0xOG93Y2dMeGZuWDVrUng0ME9rdlYvZTlX?=
 =?utf-8?B?YnErZytETmJHSUdYNFVrcWV6cE1Vb0xYd2s0M3lQcVdVTmZxOFlaaHpERU1K?=
 =?utf-8?B?WDVIQmwvMU9rWkNJTzBJc2J1MjFnWGZ1VmpsQnRGZXJuZWk3d1hUNjhPTzJp?=
 =?utf-8?B?WFdQcWVaRDdiZk1jTUNzcG10d0E0dUMvdTBMd3lxK2lPNGZtV0NVUGtDeWdU?=
 =?utf-8?B?dEcvMjMxd0JWQi9QMzZ4d20xdUZIOUtpeHBqMkl6UnFZdUtKSGxXL2lCZWsr?=
 =?utf-8?B?RU5lNnZFMTFTN0NNT3F6OThsSmRncHI0RmhrVzV2NjJib2ROMXhKYm9SZENE?=
 =?utf-8?B?RFQvN0JXVEE3cW93M1hOYXBhWGZYOENDT21ZMWFwRHplMXoyRFlsay9hQjY0?=
 =?utf-8?B?dmIyR3h3dUkwaUJxQWlHMmR2RitNclRZNCszNjNmV2g5elMxL2FnbHdLZDdr?=
 =?utf-8?B?MXRWRlhEOVk4WmhLVjV6enJWcUp1MnBPRndqdk8wWHp6QlZheTZmYlpuQnpi?=
 =?utf-8?B?Y1Fsb3ZtM0tkbmsrRitmVDZvTUpydVl6SWovVy9ZcFdrY3Z0djFITVlzQ0JC?=
 =?utf-8?B?VXdQRlRlQVlQZEp5S0pmSnlPWVV3NzRZUkpoNFQzZVorN1paVE16YVErVTVu?=
 =?utf-8?B?amV4akt1L3A0azhLMTJwcUxabmUyYk12ZmE0cTI1VG5aako4WXZ0K1E0cVFN?=
 =?utf-8?B?TUtYSEtERFBIcUdvcGxqTzhlSHdMbldhekVnbzJUNFR0Ylk4ejU5RmhiZTR1?=
 =?utf-8?B?L2lidWhZSWJWUG5aL1NNM09DNEhjcWd3aHA4aDF3Z2R5VXp4QlNNK0tPcWE2?=
 =?utf-8?B?cU9jZkVHSGJtZi8vbHBkL1ZGQWNZS1JITGhNaVA3SGd4TVYwSXUxUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db65749-1907-42fb-3419-08de51f4b1bb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 16:07:32.9831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mtp3RmHOVYTJAdDnSfCA21sunP4KlsrDsebQ+d6c/GbZUAo0xEa/1N9XI8XY178XuXC5D9MxR4nXt9d1dcfd+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5146

On 12.01.26 15:52, Jan Kiszka wrote:
> On 12.01.26 14:11, Jan Kiszka wrote:
>> On 12.01.26 13:33, Clara Kowalsky wrote:
>>> Hi,
>>>
>>> this adds the functionality that if new commits are pushed to dovetail,
>>> the corresponding kernel builds in xenomai-images are triggered.
>>> I tested this for dovetail/v6.12.y-dovetail-rebase and
>>> xenomai-images/next.
>>> Thanks Jan and Florian for your comments in v1.
>>>
>>> Changes in v2:
>>> - removed 4.19 handling for now, as suggested
>>> - in ci/ci-dovetail.yml, add a comment that this file is configured as
>>>   CI/CD configuration file of the linux-dovetail repo
>>> - in ci/ci-dovetail.yml, use a debian:trixie-slim image
>>> - add commit to rename LATEST_KERNEL_VERSION to KERNEL_VERSION_WITH_QEMU
>>> - in ci/xenomai_3_dovetail.yml, sort kernel versions and rename
>>>   templates
>>>
>>> There was also an issue that the QEMU jobs were not triggered in v1. 
>>> KERNEL_VERSION_WITH_QEMU is now set as pipeline variable, in order to
>>> make sure that the rules in the .build-qemu job are evaluated when
>>> having the variable info available (by setting KERNEL_VERSION_WITH_QEMU
>>> in a template previously, KERNEL_VERSION_WITH_QEMU in the .build-qemu
>>> job was still empty and the QEMU jobs were not triggered).
>>>
>>> Changes in v3:
>>> - the v2 had my test branch in ci/ci-dovetail.yml
>>>
>>> Best regards,
>>> Clara
>>>
>>> Clara Kowalsky (3):
>>>   ci: replace LATEST_KERNEL_VERSION by KERNEL_VERSION_WITH_QEMU
>>>   ci: Add build job for pipeline triggered by linux-dovetail
>>>   ci: Add CI for linux-dovetail
>>>
>>>  .gitlab-ci.yml                  |  8 ++++++
>>>  ci/ci-dovetail.yml              | 47 +++++++++++++++++++++++++++++++++
>>>  ci/gitlab-ci-base.yml           |  4 +--
>>>  ci/xenomai_3_3_x.yml            |  2 +-
>>>  ci/xenomai_3_dovetail.yml       | 39 +++++++++++++++++++++++++++
>>>  ci/xenomai_3_next.yml           |  2 +-
>>>  ci/xenomai_3_next_long_term.yml |  2 +-
>>>  ci/xenomai_4_next.yml           |  2 +-
>>>  8 files changed, 100 insertions(+), 6 deletions(-)
>>>  create mode 100644 ci/ci-dovetail.yml
>>>  create mode 100644 ci/xenomai_3_dovetail.yml
>>>
>>
>> Thanks, applied to next, and I will soon also configure linux-dovetail
>> accordingly. Let's give this some practical exposure.
>>
> 
> Ok, here is an issue already:
> 
> https://gitlab.com/Xenomai/linux-dovetail/-/pipelines/2258056311
> 
> We are currently missing a rules (and also recipes) for that kernel on
> xenomai-images side. However, the same will likely happen when pushing
> any of the merged branches (e.g. v6.12.y-dovetail, instead of
> v6.12.y-dovetail-rebase). Those pushes should just be ignored rather
> than raising alarms.
> 

There is unfortunately more going wrong:

https://gitlab.com/Xenomai/xenomai-images/-/pipelines/2257965129

Looks like as if we are not building Xenomai-enabled images, for
whatever reason. Some magic variable must be missing, some kas config
file, who knows.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
