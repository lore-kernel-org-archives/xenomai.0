Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012026.outbound.protection.outlook.com [52.101.66.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7207B3C2F
	for <xenomai@lists.linux.dev>; Mon, 26 May 2025 17:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748281624; cv=fail; b=chfnY6uz0vKTHvoJhfdmfLTW9+SSdMzpdPoKjBAHmWFqQyxJoIkP2n3EUf7loIRAjE79Lff7l7V4CyuDBGkU/hv/EzMwNxj5w+aSiOjUjl0EAdm/nIXL4jm9Xc97532EjIMR6HC+egG2oIn2HYybmay4HSAiLsh+ZtEHhqIHa2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748281624; c=relaxed/simple;
	bh=Qilidwoht9o8pwDDNpJNITwWjH8UYgBn81q3FM2hDio=;
	h=Message-ID:Date:From:To:Subject:Cc:Content-Type:MIME-Version; b=sMivuC7DMuUGGqk0nh3GvqZC6x/bJzvBWlt1FPMCNx7KMsjbCSw4+Xhn/qczFRvhfNcNE0w0NiB0CzVibK0LZKJ1oJQhSRPQ8UuUxCecPZUEdyb+0aU2kzszPkKdlpQV8nS6zwmsPBayg4dWEmcAYYZir4+0zSoZ870f+dFLHvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=o4SljVRj; arc=fail smtp.client-ip=52.101.66.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="o4SljVRj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZOi3b/BOsW3iDmAyHyqIOyuUZdHpPZ1j40UhlQZ3FZcxXmVn9txfKVhzn7bDQYKa+s+xkAuU18vFs4UDUIp5W6JFr7QYBoi5iJB5zZSD99Gfenq0iVnMP64hUf2ySxDQmwmOo4ImEA9A2et92AcyQnPQ5JrJ7ocv/Ei4Fp0fDqEodT5WrN5QqWFhkbElNFctkf5f3X+OViySFHBJxBLi9dG2gogAhiCeTybJ/s6NZ2MqGLRdygCnpmsRXpxAJhlR/NQmCIUXn9E3YwnmLoSgV/TIc8WRqOTs77/8qoh2zaFviBNW4Eik1G62AG3lEgI0QOKT1ENMOxQ6A90kPaTbFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UsexXtzi2/CNVKqvShlN4YzUYLTbh8pDMchyPEk9Oqg=;
 b=FdIS2muhwierxcdfd+OEebVOY2EclLPTz31/pi2OLk5yAj+xdo2IvXSan4QdGf1VmhSYazfBeemq9A5kOYzMnIndwwlYMlUvbR3vbh6ZWmp9z9MUr3Npu9aQY5pW4PkJcLfWikOk6XgOAiMffO3DxxzL+i+Py+if+53sGpxVsjLb9eWpjxWGpdSoaSZL+6Xkj6hnUQocWddq3yywwpVDbLYOX6Km2vj68sp3JEe1Fvsooo0/v8nJGUKsza4tTZyYP/HdH5CR7Q/EOITF8AxiNpRBVC9ARNiaXoj81MnX+smzog8AYFuLDlWZDfp7qNnTY9+6hTqb/8k2bMol8/VWiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsexXtzi2/CNVKqvShlN4YzUYLTbh8pDMchyPEk9Oqg=;
 b=o4SljVRjTVMKk7JZQSoEfCCcUN1+1cBezVnGGsw6+gj1F7lg3tO+VFrZjkfGBCcWEqaflKgurBImXX7CWvAGZnqgj4L1DFIIFaukje63gfmtImA6sA2CGVcV5i3KvltUL4GHGDm58zqhyR/JNVquKpk7NmPtjpaCFqZf1LLBFidbN3ItmTGnZVdT052BGPTtfg1JlW70r06daJGysSXQxGGc2fxkF6mA0En9/s8aFK91tZzHjXetWY/B3e6E4nrkZ1gbAtn9lm3r6k02EluEVKPx40CkWZWj9cXAaqeZcc+PdgBKMydE0RiH+ovg+k552UJy5adO532zF1vsOkANsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB6864.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:324::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Mon, 26 May
 2025 17:46:58 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 17:46:58 +0000
Message-ID: <dd5f7483-c648-4985-928d-bb3e902e060f@siemens.com>
Date: Mon, 26 May 2025 19:46:57 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] debian: Install cobalt-glibc-time64.wrappers
Content-Language: en-US
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB6864:EE_
X-MS-Office365-Filtering-Correlation-Id: 978abf96-a37a-4f31-c877-08dd9c7d4fd6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0JtR2VNYTNHSXBrTzZvT09TOU5RbitUTEFsZDNEaTlKelpCQWk0dFRvRHNR?=
 =?utf-8?B?Z1lGaXVPUlJ3V04rbDNLWlFvdnhGSnViaW41SmQzNXcrRDRQUVREZHFsQndS?=
 =?utf-8?B?ajIwblArZE5TaFhzRzJlV09RU3FpcmhDNjJ4M2p4NmJ3aHJJeXFJdGlJTENO?=
 =?utf-8?B?a2Z0ZVpLZmhTRDZqQnZsdmwySkRqZ2Znc0xkbmpjU2VnRHcxU0cvM0RsQTJI?=
 =?utf-8?B?TFVPcER2UnYvM1VVcjJMSUU4c2JVclplcjUrSFl2QWZtSVB6YUJNTDhRTmJk?=
 =?utf-8?B?Rjd0MngvTXdGdExjZ1NTKzlHaHZ1dXRjQU03aWhiL2ZUdllXZ0F0c0RoVXoz?=
 =?utf-8?B?NUtTQkpKZURoNHFOamVjaGpFMDJqRThVcFFHc0RpY2RINENwcG1hNGRkMTRP?=
 =?utf-8?B?VHBuK1BON3o5Y0dXQWcwSlRVV2RiQ2k1R2FZSThtWlc2S3AydWRMSXNGcUo2?=
 =?utf-8?B?T2ttdW5MM3JBSUJLd3Y5WGZ6eHFYSFVISDMzNzNrcXIwSnpCbGxJSEd4ajZu?=
 =?utf-8?B?V2VEUVR0ODdaeHkxVGlQRi9iR1EwYkJHOGcvem9LTmI3TTlqT05hRFRuUXA2?=
 =?utf-8?B?b1VjblRERVVQT1Izd242UGFLb1FUZ3dLZTlCdlVPeHJsWkNOTXNDeXpNaG5S?=
 =?utf-8?B?VzF6UDlFdERxMEpLQ0FjeDRzZTF3Tm01YkZhWFExNUF6NDJCMytvNS9nSm9T?=
 =?utf-8?B?NXVuTnErY253Zmg4U3M1cmNVZEtvSHhuTmpsZ1Z5Sk4xZ1pJNERTM0h6di9J?=
 =?utf-8?B?endhZVlZQVN1VjBySHVOSnd4cE9CZUFPaWpmTE4wTW9FZUFCSGFnbWNsQTR5?=
 =?utf-8?B?NjQ5QklWSEIraDJaenllTTM4QVliUVJxM1o1RWdyOFF1YmJYaFlLZ3pJYkRj?=
 =?utf-8?B?YVArT1UwWUZvakRQeWYwZ3RBZlo0T2creFRXZFZoR1NHZkVRNXh2U2RIU21S?=
 =?utf-8?B?VEh5bldESkM4ZTM3WGYzSjJtOWxNUDd5U3piWG5XZExNQ3NMZHBsVXpLTDBp?=
 =?utf-8?B?TzQrdFFwakVJY3ZOV0lZdFJWWndVZDlUckZGV0I3dFhFUmVmZDV2V0E4L1dN?=
 =?utf-8?B?S2libUxXSEFBRktraEJ2VmZQSnpub2ZQNU95azNLNXJ1MG1lSVpNd2t3M2sw?=
 =?utf-8?B?Qk9ldVdMNjRDM3BTMFVFa2ZqckJLeHpseG14UEJxbGRHbnJYLzMrYlhEdFBR?=
 =?utf-8?B?YTZFdUwvaXZCdDhFcFJ6d0FiZUd4djlxSzhXQ3lSTmExRk5mWEx1SU4xYlli?=
 =?utf-8?B?SnZCQkhiMWFOaUtSTkxQMHJHdmZkdk1Xem5aYi9yV3BwNmc0YkU3b1dtRVRr?=
 =?utf-8?B?QXo4UjYyU1ZkTC9JSEdweTkyU2xYMDM4V21ramkyV3ExdXZreTI1L2lEQkhp?=
 =?utf-8?B?Qldtd1lTWDYrd283VUdRVFlqTm5FWnZveHlmSm1OU1VwL0t0bjh1STNMdWVD?=
 =?utf-8?B?TTA0UU45Tzh1cUlPcWh3SDk1RTluUkZBQThRMmhvNkNMTmZ4Sk1aZStzYmFZ?=
 =?utf-8?B?S2lnQU1qaXhLc283RXVmVUIwNXlFQ0VWRVBYNTFROXU2dDdvYlJCbmdNUTg1?=
 =?utf-8?B?WlNSbk1STWRxRGdmaDBJMDNFblFTaG9XVUdGTXBqTXB0cllZV1BtaWFJeS8r?=
 =?utf-8?B?U2poUUh2eEg3cHVVOS8zMk9MVExMTTlLenJQbjFqdVpMYTRNWldkL2tkS2Zs?=
 =?utf-8?B?cHI4aGpUQjl1cit0K25CdTlTYUVKUzRjMmJnWU41RFhBTnVZbi9Pc2gzWU1K?=
 =?utf-8?B?YzYwZnllcEtSeXAxNHQ0dVF0UnpLQWJjNjZwbzdvWjZQaEhycVllNXZTVlpH?=
 =?utf-8?B?RGk3Z2hNWXBtUVBBT3JaVkc3NktET2d5Um04UUF1YjYzdDBMTUtMdm9yMkdh?=
 =?utf-8?B?ZzgyaUMyMFEyMnR5U1JpZHM5V21Fc2dsdHM0N1hRWHU0RDVBK1Y2Q204L1FP?=
 =?utf-8?Q?Y9p374qhZoA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1gvUFVKczBoWTduR3E2c0tUTkROMTVNUS9ZdEJzMG1OeHJFblFnZHpBZzN2?=
 =?utf-8?B?UlBCbzZTRWMvb3FOWTYzQ1AxUlpjR2ZvY0FEa2gwZ210azlyOG1UVm85NlBY?=
 =?utf-8?B?S3NKa2hEMjJTSWtjZG4yM1ZQemh3SUdPYjI5USs4TyttdVdoemU1V0c4Zytw?=
 =?utf-8?B?bEg1RnNybEFva3IzWVNUZW1RQXJHdk5VM1RPb0s0ejJGTi91ZXoyNGhPMFZE?=
 =?utf-8?B?VThqeGx0dXllVEFlWTJCMTNJTFhqb09CbS8wZUxUamhTekhqRXZpemlSMWNk?=
 =?utf-8?B?bG5UYU1OQWZ1UkRCUGxFcTRrcGlFMEdocEZaM0dRUEZISTN4bEZJcHV4djVU?=
 =?utf-8?B?amxSd1VXbE9adGFCOUd0RStCcStOQzk2bXZ5ZHJ1bkNlMjRFVVRaRWtjYlBE?=
 =?utf-8?B?WnJvQTI0eENlZS8zSGtLUlo4UHplL3FzV3I5QnNkMzEvTnVLZTlNV0FkUSty?=
 =?utf-8?B?TWw3YThNS1kyb1VnMDN2R1FUczgzQTJHWjQ1cVhiWmorRGZmU2ZVc0s5VTJQ?=
 =?utf-8?B?SmVFRkQyOEh0VlAvejlOcjRWL1BKdHdKMDYzZW8wL1MyNEU0MXpCaXVSNFVV?=
 =?utf-8?B?M0VVL0NqNXY3OGk0bFByYllCbVZQRUhkdEZDY2ZDSzFkeFU3eFBCR2hzaDVa?=
 =?utf-8?B?bEJpOU1OUXZzdkF0ODVqSWVKLzdyOTBDN3BLVXlQa1A4d2V0MkJjbm1TcXFV?=
 =?utf-8?B?TWs4U0FFQWN4S2FjelFKYWtISFMzeUswbU9yYkIrYVY2MEdpOFJmWUxXWmpO?=
 =?utf-8?B?Qk5BVEpybzU5RDRjR2Z5c1I3TTFCV0xFS0hoV0FQbHFKSUhwUEZCZXFEcDE2?=
 =?utf-8?B?SjY4THZHYVIrb1YvMmdqUnR0c2k0eXlmanF2UVBUSjRqTDhaOXBGNEZ2ZURI?=
 =?utf-8?B?Tk1kV29QcEM3RVBCOXlyN2NabXZmUklraTFWSUVJRm16L0JMekNBUmtoLzVz?=
 =?utf-8?B?eDdRL2tpN3dmU2hwQXZDTElNZnhYN3hLUEZqWUkxWWhaSFpTZTdKQzM3Sldz?=
 =?utf-8?B?b3JFcDhXOER4WEh2ZEJRTGp1NzN4ZUI3Qy9rVkliV0F4aFIvQk4vdWxjTFBo?=
 =?utf-8?B?bnpUTnhCYUJCWjNZNDNaU0hFMEFKWHF3eGUxWGYzcHhzRzVGT2NLR0dwQlRr?=
 =?utf-8?B?RkNjSnQ0a0xCa2xYbkdxcHRqZkIvY1BNZnVKbnFGaFhiWE5udkc1OHozMmJ3?=
 =?utf-8?B?dEFza2hYUFN6Yk5QV0RadHNsRnhtVytQT0loQklPRjFiY1M1cE9pYnovOEJ2?=
 =?utf-8?B?ZFRBNDNUV3VwYkpjOFZqT0tIY3pDdS9OR3VaUW5oWDNidkdIVWU0SjBOZ3Mv?=
 =?utf-8?B?Ti9YR3FBR3pFTjJ2cUQ1QzJidkRhWmRZc05YYTg2amJ3d3Z1QzRkZ0pJREdQ?=
 =?utf-8?B?NFdDNlVFakxXd3RHQjdZaXMzNjg0dzVNQWFjNjJJS3M3YWZEdVgzYUJSR2Nk?=
 =?utf-8?B?NVJCV2J3dTNRUzlaRWhJMGNQb0FDTGlOaHlJQUVxd1BRdktwMXY0cWNLbVRh?=
 =?utf-8?B?c3JYYWJET2paRDFVcFZzV0xiRVZLS2tHNUc5dGh1U1kyd3o0Q1VXT2p1bFBB?=
 =?utf-8?B?NDF0QlR1MWFNSGNJZC9MZmhIQVptNzZzWU9RTFRCZVBoTEZpaW5zOUxnODBk?=
 =?utf-8?B?UmtVWGdRZkJnZjk1MFlQbDl0YWNCWEpUK1VWajh0QjBkS1FWbG9vM3JlT2JN?=
 =?utf-8?B?SHJuRDA1OGMvVVRnUDliRS95MGdZQW9udjNSWWUzc0tENklDZmZ1K3Ftbmhk?=
 =?utf-8?B?ZXo2ZEpjMHNtTTJQbVp4QnkrRklzcVFjVWx1Q0dsM3JNQVNZdzhBckNzZDY5?=
 =?utf-8?B?WWZUcWpKQkxkazUvS1prK0RPSVlQUEhWNGxFZVNTaXZyckVoTzY2ci9hSWFk?=
 =?utf-8?B?SU9kL2lZVm1XTFEydUQra3hEYkJYNTFtem9wWUxvWmVnVEdQakQ0UG5vTkl1?=
 =?utf-8?B?aEZybzluWWM3WDdDN2F0NDBkMTEzeFVWMDZFTGQ1VEJxNVFMMXFvMTBISDg4?=
 =?utf-8?B?ZnBBSkJoNEluSXErR3hUdndxc0ZIb2lBNWJtWGtHMEFsRnViUzVvOXdDYVRO?=
 =?utf-8?B?akhUL2JrZHFtOFVlY3VFRWVLcDZ5MXFnR21NL1hMTk5jZXVZdThwckpRb2to?=
 =?utf-8?B?cDk0ejhld1QrS2NVK20zV0EvRXdpV3l0NVZyZzMvM2haNFZSQ0RHL1Y2OHZQ?=
 =?utf-8?B?YkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 978abf96-a37a-4f31-c877-08dd9c7d4fd6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 17:46:58.4388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yUvbpUjMywZSx4hCEan+u/4FpcdNRNg6XBSOR77KU/GNnf2DHFVfQz6jir1ZXpR1vtEm+TjGyFipdpV1TPMSYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6864

From: Jan Kiszka <jan.kiszka@siemens.com>

This was forgotten by c2b883446b80.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 debian/libxenomai-dev.install | 1 +
 1 file changed, 1 insertion(+)

diff --git a/debian/libxenomai-dev.install b/debian/libxenomai-dev.install
index b57231585c..9edb13269b 100644
--- a/debian/libxenomai-dev.install
+++ b/debian/libxenomai-dev.install
@@ -5,5 +5,6 @@ usr/lib/*.a
 usr/lib/*.so
 usr/lib/modechk.wrappers
 usr/lib/cobalt.wrappers
+usr/lib/cobalt-glibc-time64.wrappers
 usr/lib/dynlist.ld
 usr/lib/xenomai/bootstrap*.o
-- 
2.43.0
