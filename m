Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011045.outbound.protection.outlook.com [40.107.130.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6AC2F1FC7
	for <xenomai@lists.linux.dev>; Thu,  4 Sep 2025 12:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756989559; cv=fail; b=lTqOUHEKq+zl3PB/No8VOZTEdzY23Y+HSkgEhKpzRMELF95HIEPbN3Gr9cC+ukZVCuraMkkv/6CQn+1mPZ70Ft4H/fPWZy9vvIyKS4CMwPJh697IPsGzDgigGVpQ7mL8MYeshHpxlwL/C9rG7SI7ZS0SZBZzjasBzp/Ybtkmizg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756989559; c=relaxed/simple;
	bh=8n0wJQKonBqMOUE6Ta1Zqk/WvlQpFfM12YElhs6OiqM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ov+cAgg+xPkI8BlkkZmH8SoG1RPE7kPNjIYmobRAnNnuRXoTAaiI2elN3yZJnoUhhZmWEZeBEN5740Pno5lcsIrO6Mzo5i+5GWlQ2wfle0gxQA8XjTu2G0G91LOeXdgCK3pVwaVHSZoMHhoKxImOrs3SlUCbWnMy6BUPL+JB9MM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=LQiwJc7T; arc=fail smtp.client-ip=40.107.130.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="LQiwJc7T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J6U2Ga9Klqh8+g90T7qBQ2tDhZJ5iMfWLyhiAkSSSI4Lo22HBsIF2/Dux/LaPZqQK7Ms94kivkcFedzqUTIR8yIm//SVRuVBBn+8ojU+rYUknDOYt9BsoksdDtVf80pwJOYvJmkKxJ1vFcwtW4ZXzQBr7xLFz8wTZ/MIs/FJC24/HwKDQp4PAyi4+ZVpXnNmmu9FZus95mouUlBh9TMCrmfuM9gvcuMVETMTbtaShUGXNZ6USRUAjMfVeNp8z3E5Pr/21XjaysKzcxSYWCwyNKmAxqehO4jTxQQI4zqfOVkPc/LjxTYuoAuTzJC7un64/pp72reZMlhz6+VZAyrKjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q14TIuKmmrfl20LNd0Cywh3XNVydM+D5cCoxLmHLkt4=;
 b=P0VMnjMz9Z3YzYb0Kbms8G67MuUcP5O0hnqDDveiHfONh2Qu+or+qkntw5SeWlupQBzMabhX4GhXYKuzk92WzBnx/m5dqS3t+/E0cGFCMwir1nWwdP5ZLWmFh5uKa60Q498BuffvUJs/EDr5vCAcf5nXgbqhrVDdoUdad+7oPorjxVkj0/Tv9LC0409ByrioGHbzVp31W57N12jXxcstlMgHb68EvNKiBLwlQ8M2LeaJB4Lr4K54C5EVD3WbklPJFT3rWSJHAo8XO3iHkoaVxl4FLsCn/aqqA7Imqhkqqi3d4Yh+qK8z5BJR0MfgIE6UWl0daJY5l0bvMpORy9EKsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q14TIuKmmrfl20LNd0Cywh3XNVydM+D5cCoxLmHLkt4=;
 b=LQiwJc7TZi9jaWx3oycjuaIeJz2m7PrVEW7Sa2jLmZMNXqjmgq3P6q/r2hy8uqBiHuXJyzsHALAJIkdMwQyWFy3BJDsCsT7Y+PyWq4V75yhMK4Tvp9WY75kei26Kn1CbKHeEgmE6g/+PPm/BrUG38wgnSWdxnv7wyAeec2/UZukJKGYV/paPLfhK7zDvW3sb/6nDRsEuM7+nF8wVBBqQJUwkyMhJnbTb066wzVF0dZftXooI5S2RbMVUvnqymuw98/UYJF82+1LuxSiYWbJAu1emQc9ggxrKGxc8FebbZlMuSo0WNkFfj6Ek047H+BzzsnJyoodhh3dmoaccPiPXqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PAVPR10MB6914.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:30d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Thu, 4 Sep
 2025 12:39:11 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%7]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 12:39:11 +0000
Message-ID: <52126010-5b9b-4649-8883-9ab9295b00ea@siemens.com>
Date: Thu, 4 Sep 2025 14:39:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ci: increase wait for device timeout to 30min
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 florian.bezdeka@siemens.com, xenomai@lists.linux.dev
References: <20250904113929.2064680-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250904113929.2064680-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::15) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PAVPR10MB6914:EE_
X-MS-Office365-Filtering-Correlation-Id: f9138fd8-7090-40bb-c9a3-08ddebb00c8f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eWxtaWczVkhDMnBiaS9BU2d3QTJVVDY4SDdJcllHVVVOQWdMY2wvcDFLZFBR?=
 =?utf-8?B?UWxvZm9URTlTL2Z3Sk9ULzFWcUgybndLT0NWNDdDejFTMzZXY0srVDYrMGVy?=
 =?utf-8?B?NkJnSlFvVk5CRU1ydmVkR2NjWUFMQ3RqZGFkL0lNdXRnUGV1bFpPODE4blQ5?=
 =?utf-8?B?RVJtLzlGdEMzNWdzRVI3UjNLdytBakg0NnhKRzlNeGZLTHRWRVRCdkpBcWJ3?=
 =?utf-8?B?RDdoWVU0dXZ2bzhOYWprN2JMaGZvSzZ5TW00OEhsYkZvNWMwVTJtcE81SGg0?=
 =?utf-8?B?VUowNXZyM1FBaWNFek8waWthcHdweFUyQ1l3YngxdndWMnpjWnNMN1VvT05l?=
 =?utf-8?B?blk2SnQzQ29nVkFGbWphZHowS1M1VHV0MXcrbjBIaDcrbVpaMVBOb3AzZ2hC?=
 =?utf-8?B?SUpOM2VJY1ZEUGRHR0hSQWMyZkhGSkJOZDFscGR1Z2FSRnJHK1dLbkxMa2hB?=
 =?utf-8?B?bFR3THQ0NUhaUVRJZ1AwZ2lwbFVmUXh4YXp1ZTNoZVBFakp3aytjMEZDZmlz?=
 =?utf-8?B?N2c0VE5NOXNSSExzMUFKd2xJZVdHV1NQSUdLT1lCZ3podkdLcjgremNMMDlR?=
 =?utf-8?B?TTZLS3R5UCt6NlNNaG5sQVJuOHJwQWRxZzJZK1duNlRtUHJzQXNFZzJpY0ZJ?=
 =?utf-8?B?ek40RC9VSnh0U2l0V1N2Y2Rac01PUXluTkNUYjR2dTZoK2lPbENJL0NCNWNN?=
 =?utf-8?B?b1E1K211ZnVVNSsrREF0dWErMS9YZjFQakxhQzJYdDJaRUVrZGhxZXQyRnBl?=
 =?utf-8?B?UVZRalJQWmRiU0RyZ3M5bnJBY29BTjlOOW8reE93clpmSExIU2wvNy9iOGIx?=
 =?utf-8?B?d1ZpSzN2cXdWS1RMUHM1RGEyMU9rUzBHNCs1ZWQzN2RCVXI5L3FIdmxwQzdr?=
 =?utf-8?B?UkhvRFNmMDNZd0dKdDl5UnkzOW9yM2RuLy9qVWkrdDFxMzlFVDhjeVBiamQr?=
 =?utf-8?B?VEtUQjFaZ0F4WkliWDN0aU44USs0QmtkWmd3c1BxYWRJbFk5b3RjT3R4blpz?=
 =?utf-8?B?WHFJcDR5ZThYTW5zSzYzNFp5TVVwdGNocURKSWNkWW44dzl5WFB4OXN0SGVj?=
 =?utf-8?B?YlpxVm1JbHYwM0xYWUlPaCtzQkZUTVU1d2VXbzNRRTNpOE8vcGRBN04zcnc0?=
 =?utf-8?B?Z0ZoWEg3S1h4eGpVcXN1OXRJSzFCbHNHcHhlMmgyM0pPajAyUi96L096emJ2?=
 =?utf-8?B?VkRvNExwU3FReXBGV2Rjd1ZHTXQweVFBR1FpYWVETlhDUGhXUkN4clRTbGFW?=
 =?utf-8?B?T0Nab0pnUnI1ajd2RGFwbG9OWDBseDFyeGlwSHNNclExeVZXa1RCd1J0d1hl?=
 =?utf-8?B?QlppRUVkYVNEU25GQ0EyOVE2cGRLcVZTcDZmOHZITVNEYStLbDZsbjFDWTJj?=
 =?utf-8?B?Nythb1NKaThRZVV3RjgrQVgrVk16MVJrUVpOVWowMUd2NGZEQkxvYUVjMzJP?=
 =?utf-8?B?WDZZdXk5ekxSWldhYUtVQ3dVVStYdFdQaE5lWFdicHE3SW5hNnJpNVVCcERF?=
 =?utf-8?B?eFVITlN6N1VRZGZ5Wm5MVkJML3JOb2VtSHZPMW1OSDF1VUM4RTQ5bVNEM2ZT?=
 =?utf-8?B?cjBZZ3dzeldHVUU1WXYwbHdEWVZRTmZIRDI3REpuSW1PM09ocnI2Wkh3MUJO?=
 =?utf-8?B?OU9RcTU2L2xHMlhtYVZvTGpLTGQza01XNHJhYUpsRHBBcXFoMlh0TEtRbVk5?=
 =?utf-8?B?eU5IQ2dxdHBreFNxejJVUVludE16Yk4xdUV3Z2dCOW1YdmE2Y3dzcnYyQWdV?=
 =?utf-8?B?QlAzR0J6ajFLc3NNa21VWGQyVG12ZUo0MjgyV2lhZFp6U2lCMlZRL1FyVkpK?=
 =?utf-8?B?ZTNwV0E4YVpwVG1Vckgwa0ZBZldLOVZ3VGdCS05kckxnSjlibXpSS2trdEpU?=
 =?utf-8?B?T0FMSlkrV1U4RHFsSU1XQUcraGFjV05jYUluR2xRbGRGWWNvVGhEYmQrQTh6?=
 =?utf-8?Q?5xPg6VV4dO0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmdDdjZPdVNsQ2p4QzRzQTFEK2swcWphUVRHdlRHMVdyYktNemUyM0ZZZXFT?=
 =?utf-8?B?dFVkRlQzeXFVSUM4RVRXNTlaem5JK1d3bWxaWkFKTXJHRnZEQkVDaUVaekRx?=
 =?utf-8?B?aHJ2NXhRVjF5Tm9wcmRWY3BHb3dxZ0RzK3VRaVpBalc1YkJCYzNhazMvRmRs?=
 =?utf-8?B?ZDVoTEFZN240dFc5eWxob0dkWHZVNW5MdUpCbkxEMXZvWTVOZFhXaUVzTWwz?=
 =?utf-8?B?dnBFTVhnRTBmY3ljbFZPVHZEdlpCdG95VlVUNDdjK0pFbHNTenlLOVIxV1M2?=
 =?utf-8?B?NldyeWxNT1Z5R2wybmFvbkJteFh4VXk2ZjRLV3E3amZ5MFh6RktjQTVZNEtH?=
 =?utf-8?B?cVRIZ1JvMzVTL2FZRUxERDZuZWw3YlRaY09NU09PcDFyNnNiNExWNWdFVlcr?=
 =?utf-8?B?N3cxdm42c2U1aEY1eXhCRUxpQUNIMVg0ZDZ2bFJvNVk1b1Frdlc2bEZJTk9M?=
 =?utf-8?B?dWM5VDVPTXpJNDE0cjBldk0vQkpQcWJYT1lEbzdLUDU1U3JzeklLcnczdmxG?=
 =?utf-8?B?aURUbTBzc3pWVXZ2N3RtWTUvSGwxeG1sQWdjZjZXS3VQTGNWWW0zSEkvclg0?=
 =?utf-8?B?MEhXM01yZkFCUlFYbkZNdUgyb2IyeW5xSHpYYTNWWUVSK1N2R011dkJSRjlN?=
 =?utf-8?B?QW9TTjk5ZHFlYmZIc0Z1MWxmd2xyYUl0VW1WcGFxbzZSbUZ1VVBRR2ZmK2R3?=
 =?utf-8?B?NmxiSlFLWmIzdHkrL3FQWmJCQUp5MjEzWml2T094dEhvb0xYMGdOUmVianM1?=
 =?utf-8?B?L2VONTlYYVZIZTZjUFdXSmNkRnlnOG5mN2lxeUY2TGxaNzZBZ1RiVGlZWlg3?=
 =?utf-8?B?RUVoNUF4MXFpMXNQN1NMbEt6T2xEVnRJUk41SWxxZlVmZENGaFowQjFWTHdQ?=
 =?utf-8?B?S1o3Z0sxelE3aHhuV21KNDBPcWlrc1l4U05ML01GZXNwQmkzR1pZQlhpVFIy?=
 =?utf-8?B?clU2TmlXNlE0eXhPZGhsV21lYWJQa0NhQTdVMmlEVEFkZktENm5CK2NjMGth?=
 =?utf-8?B?aHdhNVFjWnFzRVFpNHR1VmJ2VmF0YmFjQTU4RzJ1UVRPSzNEQjJLbHBCK1ky?=
 =?utf-8?B?bDEvRVk5b1A4U0lsYUVIUmQ4bHRxa0h4QlpxK280NjlHcWV1WE9HV0dUeUtC?=
 =?utf-8?B?Q21Xc3h3RUJ1dFlmam80SlFuL0YwWG9uRVQ2NW5pRDY2NHVKbWdBUHJCN0tE?=
 =?utf-8?B?NUd4cStkWDBxTG04QmR6dXByM2s5WWwrQnZyekhmU0tPV25KZ2Q0WVYwcTQ3?=
 =?utf-8?B?SUVSZXpCOEc3ZzhHVU5LUHlYWkxBTTYyUDlFS1FsVDdva1ZmTklGTW5wakFW?=
 =?utf-8?B?L21JTnphcW5pOTlxR2VpV1pLWmlxUWpCeFdUa3NIamhkMHRYK2NMZDFjZzBz?=
 =?utf-8?B?UXBxR0JnME1Kb3k3b01PUndKVElkRy9LMjdOejBGcnVnUllCQSs1ZFoyamVj?=
 =?utf-8?B?Wk04S3lrLzNSNmlMc05ValZGaEhSdUx4V2RjWUVTb0hPeHg0bjFiOXMyeVRh?=
 =?utf-8?B?QS9KaitSUzdTc0FnTGVOUzFmM2IwaGhpQXJhUC85VzZEQTNuWlhkUjFnRnVY?=
 =?utf-8?B?VTd5RFpURzhpNmFxdVZJeWpIVkVFdlA4MmhjL3JJOWNVQlc2Q2szQTlHWmpP?=
 =?utf-8?B?aXNHNExkK3lnZUdBRXQycnFxYjFFRG44ZCtOTzBCU1NLNFA1dDJwWXZRcmhD?=
 =?utf-8?B?K21YTkJWNjFJQXkybm1qbG5NTmVCZS83bU9qS2tyYnVoeTBnRDZIR2NnSWN5?=
 =?utf-8?B?UmQzZ3VIYUJMMzNiUnJtTFZTSzNYUFVLcm9GVldqaTVmUVBFTkh6dlIyMFJ6?=
 =?utf-8?B?a3VnazNYZ1pVUkNDY0FBUGU5ZkNneDBQNzVha0xoS3FNZDBwMWhYblZhRmds?=
 =?utf-8?B?NkdKdzBMVFNuZlAvNmlmZmwzeTBHN1h3RUhBZE8vcUo4NjdFdklCS2NlcWNL?=
 =?utf-8?B?TEh4a0ZzanV1MkZaVEJpSDBMMGg0KzA1SFNzNk14ZkM1YnlIZ2tkMmdLMG51?=
 =?utf-8?B?NEk2eDJzQkQ2U1ZSWU1uR25ydGZkQ1RsSFN5VlRuOHRqazZxQWVUdEgyT0tm?=
 =?utf-8?B?cW52Vnh4WWYzOXUvNitFSElXVi9BNUJYY2Q2aXBhekVVNTRNYmlGdVE2QWlt?=
 =?utf-8?B?QTJLcVN6YlhaZzQ1R1lVejhSRDVveE9HYWRFenZYRmFkU1NudUg2dytVcnMw?=
 =?utf-8?B?akE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9138fd8-7090-40bb-c9a3-08ddebb00c8f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 12:39:11.6198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7529C9yBvENZS0mEwxoxogeqtQ9td9O+cqEQgTbi4nTBiZujUEhZNF5qnwrxSBp8NLua1vOoaBZJy8vLZ6czew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6914

On 04.09.25 13:38, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This should avoid test failures with due to no device available
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  ci/gitlab-ci-base.yml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
> index 875d951..fc41929 100644
> --- a/ci/gitlab-ci-base.yml
> +++ b/ci/gitlab-ci-base.yml
> @@ -28,6 +28,7 @@ variables:
>    SSTATE_LOCATION: "s3://xenomai-images-artifacts/sstate"
>    SSTATE_MIRRORS: "file://.* ${SSTATE_LOCATION}/PATH;downloadfilename=PATH"
>    SSTATE_MAX_AGE: 14d
> +  WAIT_FOR_DEVICE_TIMEOUT: 30
>  

That alone will not help because we may have >>1 pending qemu test jobs
and currently only 2 "devices". I think we need to differentiate between
"no device working" and "all devices busy".

I will remove "ci: check the device health" from next again, and we
should rethink the conditions for failing things there.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
