Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013022.outbound.protection.outlook.com [40.107.159.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C559530DD11
	for <xenomai@lists.linux.dev>; Mon,  2 Feb 2026 07:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770016337; cv=fail; b=DbFx6CemvYCIBuOhz19LKHkRIe+wIaQA7NMGk2GHZqK2BnDUhRmhuPdiol53asKMwuw4c6wZZz8EzJ23CK64OkYHSyxRylQLFs1cYO1ji7YlDfHbznd522RUyxh+S7MGEaVMu6KI6suCBKuDxkxxMsAwsI/54zKdovQCKFhSMtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770016337; c=relaxed/simple;
	bh=XGCyeYIF9Hubwqay8qD6bUYSxBFYsNnp6vSRaTI9k3A=;
	h=Message-ID:Date:From:To:Subject:Cc:Content-Type:MIME-Version; b=admS1HtvFFfm5UqxI3aAeUIgofjLcEMc2Ndf6XzeLza97uNJqiUMnZNxWY3itl/yS1jSkf3kv1gF3Dx0y0zgQ2LMmXWQA/P1qwe1a2BLf0vDmVx5KiFzNryheOOMdpbWE/ThbbZsT+BZaon/eCU3InViUDHk7Sia3BWNNHUnIY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=v4XAua/s; arc=fail smtp.client-ip=40.107.159.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="v4XAua/s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=szu1XWZOiAmjUU7+GBWnk4wBnQx2uNaM7zwmF/nFRTzAvbO1Q7xFmL+EC5R3XVv0hyn4Hb7RHpjVEy2dJqPEIBYphAFZLleenUEYnld/CoaadndG2kVub+AhCupa6sp91vSQIWBL9pUJ/1yF/IZgMyDXbzgmWmGv12EyH37ArfN5J6ZP00Gd1xnO+9sSipSEAJw9tyQozVbP3TDeDBPbOP9Hi83sfu7Pk2Z8r1844AVyvudW7LPFL3XHaCMMjzk866Gi5EpUQOo2qN65LfrnL8Hn/2nm2S+3/GxgWWfEeibyDm3MoK5U3WIjO87dyzYTTn8hDxFcImicI8YMm+laXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHDgvFlfihV0xLvMXojiD4ET15ipDH0FMlbhf2VH5Hc=;
 b=vwZq1IAXlySYFwNMJW3Txi0MQGFnd+3kmWtGGUG1qMaSS18F3LBoIzuxHU30Vu5g4SYEsZxLqfkAkZpUuydDG3NkN/FhXKzXRNZ3wsPsgWWRC6zzk0TB1NX6TLdwLRENkPLeP/Ei8SdciK9c+3Nhl5tr8OGdBoD0yhYMRXrSLNghCurhudLM98yttJLkMhfyNOvuZstXTKRn1tgrFF+P6eWFrf/PWE6KHB0Qg1Jralb/B0+gV7dVg7p/+IphGIF8iajLTiRPPRTEcN9YLsEOOjL9jWWtBCR/dobAprJguNYd1eqSiclcP2hoiP0VMagr5biqOz9NPwB4cEULztiwAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHDgvFlfihV0xLvMXojiD4ET15ipDH0FMlbhf2VH5Hc=;
 b=v4XAua/sPB70otnCFewTbItJXSWE515vB2py365IAskhUaEl86Lhw2y7QQEP1CuJZYcbaWd5wDl+fHn3gmT126PNdRZYOUEYK7GUtR1DxIPrEaJJem2xQCgJXHfTJqSA3Qpj7tB+dO9qC16/DHLqev8TsZoG6c4ofSacxay/TRyu7Tqrk4+J8/moK0g/4QUOlv+y3kveuy4FlIwtsnsrW7GTdaRZqC78IwY7ec7OrckQzVepBmHIIvAntUTxFB487zYDoWXkNmuM86BenilS/MVuiyj/zAwQz/at7ZxAY/BfI2moKSWwtzm4rRSF/dCqXq1hiQeYkni3UxIHfzlHKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6057.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 07:12:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9564.014; Mon, 2 Feb 2026
 07:12:12 +0000
Message-ID: <cd03fe98-7237-426d-91c7-c6eae63a617e@siemens.com>
Date: Mon, 2 Feb 2026 08:12:11 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH v3] lib/cobalt: Avoid making mmap offset argument
 unconditionally 64-bit
Content-Language: en-US
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0413.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6057:EE_
X-MS-Office365-Filtering-Correlation-Id: ae8a7875-acf9-4d18-0cd8-08de622a632a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZHlFZ0tKVnd2aFpuWVlrckV5MWUzckYwbkIyaGdOaWJuNkpPN09lZkpHdW1k?=
 =?utf-8?B?LzRsWGJLOTZXMDdqbmZKak5UdjNENGdncnhROWlOOHZMdDBWQmtEVG9aZTUv?=
 =?utf-8?B?d1A4c1d6b3ZzOE5UYWZnNlE5Y2tXUFQ3bkovYk00aVlMeTFzWEdiS1FPdDVZ?=
 =?utf-8?B?SDE2S2pGYjAwY3J3dFpMWHg5aFArSlVRb2E2WVEvOG9sb0N3dVc2dEFYbXFD?=
 =?utf-8?B?ajl5S2lSY0R1RDhuRmlkY21vY1dVdWx6bUV2OHdVYXFHQkJQTkpuWUQrT1lh?=
 =?utf-8?B?bUlhdGY3WWMxaitvT0Rja0JPUHhHUjFNQ3FXcDdaWGt1aTZ6czN2SUdXK0p2?=
 =?utf-8?B?Zm04TndiQ1F5aFlkNXY3V1l0NzQ5bXNaN256NWVFRmdTN3RkL2VDOFFpWlps?=
 =?utf-8?B?OE5KbTc4dlVxenZ3QVZBbk9lSkhjWWFKL1BPZ1JORlhqUHZqbmhMU3hUN3Z6?=
 =?utf-8?B?UHliSXJtMDlxLy9qdzRTVXdIKzgrQ2lEWlhUYmR0Q1pGWVVrMTNuMVpHVUFw?=
 =?utf-8?B?T1VVUmJRS3h2NVhZOW02eXkxNTY4U0laNW5EQlZrakt0Nm1XV3h4MGU4WVNZ?=
 =?utf-8?B?VE9qUHNCb0gxd1dXck5sUlZncU5UcU91QkpRWkRRUWQ5azFscWlONnoxRUpp?=
 =?utf-8?B?MzJjdFRScjZnd1dDL0NyUGU2bXlueE1vQU1TbnFFUVhhRWhYelNZVEpoODlC?=
 =?utf-8?B?b3FoMFFDS3hzS0ovUXVTRDhUU0NYZmZyaURMM0FBcmY3dWRJenhxRGJnR04r?=
 =?utf-8?B?aHpkZDhRK2hxN2d5UTR3Y0VNbjhuWUovQkcxWGhHeXRzUU54bEZQQmxBbTJ3?=
 =?utf-8?B?MSs1OWttQ2gvVlJsQ3AvWUlpVHZ2T09pWFVoWHdmdXJEV2YrZy9VUUFqcXBn?=
 =?utf-8?B?U3VPc1F2WXlQaGhleDI4VnFvTFdvSmZ1Z0l0UDgvUWgweWhVVGR3TGFTd3B3?=
 =?utf-8?B?emlmSTd6QVk0enVLOGthbDVPemxSYnRGaGUwb21yamYveHJ2cndHNkJ2UUN2?=
 =?utf-8?B?VHBTQStjM0pONEpaQmhCYlQrdkNTdG51V0RXSE44Vjl5ckd6WFdZV25iaUlj?=
 =?utf-8?B?cEJMMWM2anJPejNEU29KWENrS01SSFZGU2R2V3RmZk00alQrN0hQbHorb09J?=
 =?utf-8?B?dCs5QVpsMElUdjMvNGR0NEFzMUsyWVFkWEFGQlFrdFB5WDdBcktiem5RNjFV?=
 =?utf-8?B?bXpGVVhIQTdhcGVoK0krR0R0MFBBL1VIVHlOQW1PNFFyU3QwY0NUMXVwMXdp?=
 =?utf-8?B?SFZuWitLTHlwNnVzazMrM1VRSEwzay83TklWQTNwRGY4KzB6bWNWVVZtYTBp?=
 =?utf-8?B?bnIwbnI0M21nYnUzUnFhSytuaFJqL3k0eTBUWXdmWXEvTlBXUlc4QVhJbHpS?=
 =?utf-8?B?Z1pmanFhRklZSk1jMEZjUlNUd280QjhrZC9tTE1WVElBQ1JHQ0Y5RWFWa3Bi?=
 =?utf-8?B?dEEzemQ2ZkVLSENOWFN4WXZva0d0dTF5TXBCWDdlZlRmU3pRUGdpMUxiZ1dS?=
 =?utf-8?B?WTFodStMcGpsWmRIcVhsa3d2MVE1MUVrOFdnSXhvZkd1VnZ2dnpkc08yT2Rz?=
 =?utf-8?B?UmhzbGpuNGU3VlFQRnhVTzNuaHVwTm5WcTd2dFBtL2ZZTkZiQjVhTDFPV0o5?=
 =?utf-8?B?NTBwak5RV1QwVkw1Q2Q2QTJjTEhJek5iYU9CVGIrZlZRZDJvM0dFalNzRSt6?=
 =?utf-8?B?NG1EZDI5LzBtb3ZGZGVpb2VBV21CN0dMZk9MTlVpcG9VUCthL3kyWW9RWUVP?=
 =?utf-8?B?SU4wMXczUTdYOURoQ0ltS2lqbHplNlNzaEdNTVZjL3JlYnVMYWlIZERYZXFI?=
 =?utf-8?B?OERjRVRrZWZRQnBYTldpSUdqZWhVdkdMMDlEQWVQQlBSL2IzWHlCOHh2SGxH?=
 =?utf-8?B?ekxKaFB1YVFIZmhlbWpRZEtzUnNBU1lvbVJBc0plbGdjcW82OFM4eXB6Q1Jz?=
 =?utf-8?B?M0JJS05FODNBaTNqUHJXMzcvNlBwRWM0UHNJL3RNN25laWRjcER3QmQrNU55?=
 =?utf-8?B?T2NCZ0YwREpkR2NoRlNrU2JNRWFwTHErYmU4Nng2TDJ4ZVpKN0FLMy9TTEw0?=
 =?utf-8?B?Z1pkL0liZi9BcktEZ1FYQjQ4L2lOTFkrU0Y2K3NZaTh4ZjRZRHJUTGp6SThF?=
 =?utf-8?Q?C5w0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTJqaWxJbjAzNlNCK2hVOWJZQm5GZmNLSjVYa04yUEFSd2RzcTB3ZW4wa0Qy?=
 =?utf-8?B?ZlRSSC8zR21sQXU5bE9wUlB6eFVac2w4VkdPS2lGVUJaM0JQSUE0WUtVb2k0?=
 =?utf-8?B?T2xKWUwrLzltZmVtZGl6cWFDVVdnU1pDYkVwYlVlY2h1dmZPckRBaWxNaUtK?=
 =?utf-8?B?M1AwbUh6NHREV3VRamR2SkpWVFk1Tm1pRk1JUGIxQXFUemRhemdKM2g1Qmtp?=
 =?utf-8?B?VmI5UWtTSkdlV1owWGRrRW4veVJsZ1NlcWF6SnpEZmZzR3g4NWFRZTdXMFda?=
 =?utf-8?B?UzgwbmNiY1dYS1lrSjBqd21DR3J0dmRUQ0xuM1hqckhuVERmdE9NOEN1bzNk?=
 =?utf-8?B?eDJwMU9lMGZJR3NLb3RJVGUrWENnWkFrNEVta0pFU2Z5OGVaY2dXYmRmVmhp?=
 =?utf-8?B?andxRFhHaDY2elFlMTBUcElaaWg2Sk5PcnZ0VEJvZmxiTFk1NGs2NFN1VE9a?=
 =?utf-8?B?L2I0T2ZYamZ6bnRUemlqSDFldkNLVDE1KzdVWjZYVEdDVktnOFdPM3dwVHFs?=
 =?utf-8?B?SGdycmJDbU9uS0V5VkhIMVlMSmdybTI1dUQ1N2dVeHpTaUt3NW8rRDM0Wlo2?=
 =?utf-8?B?cFNNOThQRFJNY2EzVHlpanJFTEdMR2d1b0xVcUd3dFErYnZIeEZRNU9zaklj?=
 =?utf-8?B?cWRpZ1BwNjR1TjVFbFMrK0hSOXZQTE1PbVB1a3Y2L0pXTkRvNEJZdzdCcFA1?=
 =?utf-8?B?RDRGZUkzbjRQclBaTjVqdy8wdnFoamttNG1OWnl6dm56RnBNT2RaS2RrUi91?=
 =?utf-8?B?WUdHc1JacVdCY0swdCtIRW5hNmNNeWFOUkZMME12TDY0Q1FWNGRxTmhaZHN5?=
 =?utf-8?B?TUhPQjhmb25yVGVWaHFNbnhrd214czljMys3Vko0VzhXUU9RSDczeWsyRW9C?=
 =?utf-8?B?SkZQZ29iSmduU3NhekJMbTlQSit2b3pWdlFuZEhvUlpLWXpQRzdxMTF6QWUr?=
 =?utf-8?B?RFdiKzV3SGJxcXB5TGNZUUxaOTBSMlBmRzk2VnlWRldlV0VBL1JlOFBhZWtN?=
 =?utf-8?B?NmpxQVNDT3NxU0NIWndaejNwN3N3VmdjVUEvNkEyR3BRQVZkeTgvNHhJTWdw?=
 =?utf-8?B?Wlh2blZ0dXRUeVpRbzJNQk5yNGljOGlPOFdvRFJDU1VUeEJtOWpwNFdubUxB?=
 =?utf-8?B?a3djSHI2RUtSWGxaRlR0N2N3UEZhcVg3L3NuRGpJM3BybzlCVUNtUC9QdUdm?=
 =?utf-8?B?RkRjZ1p4NmpFTG5BUnpaZFhKdXEzaGg2M3hTSkUzN1pnN1lEbVJTOFltVURG?=
 =?utf-8?B?VFRGT1NsQ2o1aWM3WjZ6MCs5T1pKU0hMTko2ME83ZnFCMDBqdmJYU1oyNVhD?=
 =?utf-8?B?Z21sVkJjSVQ0SU1OZUZvM0dhWmpGQVhsUHR6MXAxeEpkZFpKanJDQ3dEZFVi?=
 =?utf-8?B?TW4zMHcrSWdnWFpkZ3pEU2c4VEwwSDFORzhlRFBub05wdW40dEZlZWQvUzcw?=
 =?utf-8?B?eitoa0NmdWNhNHo3R0JRamdJY3JZUzdsbmJONTljZVZhQ01uN3pPbi9lNEhX?=
 =?utf-8?B?SHBzeGFTM0RLMHVLYkRqNGR5aGl3TE1aSFZXREdpVE5rUEdiRGMxSVNHb21s?=
 =?utf-8?B?N0JFcEpQa2JUeFU5b3pQNUxlSmRqWWhnZ2N5QStWajVSejJjdFpGOUtJbHk2?=
 =?utf-8?B?VUw0SW5aTHBvUng3Y3lnL3I2ZSs0WWQvMmxIbFN6alkwOGhJcWEvUTRUc0hO?=
 =?utf-8?B?Qi9HNExURzNienFmb2o2Q2NydW9LekxnVVlEZGU2cjJwMWFhZVpaTzNRTGRK?=
 =?utf-8?B?aUszNWhrYWQ4eTRDT29Ecmo1UVpxVG1wYndYOVNrdndxK1pBN1RDSU93NEZt?=
 =?utf-8?B?VG8rUThDdnJQb1hLeFpWL2pBOWNnenI0bmpjeVYvNS9SYU93ZXZ1WGE0M2to?=
 =?utf-8?B?WER6M1BxOVF5TjdVQ202bFJ0MWxiWG9NQ2lqYUgvSDcxQUFMcWZuVTI2ZUlH?=
 =?utf-8?B?aDArSHdqcURhaUlXdThFc2Q4OTFvRWhnWUIwZ2NCT0JQbzNuWUdpV0JUYWk5?=
 =?utf-8?B?TkdrM0FWUUtRdmxzZHM2ZXNLWTBQMDNTNWM5ZGxqakJJZWNwT2NOQnphcGM3?=
 =?utf-8?B?cjVGQW14QUx2cGtkbk1oaU12ejlWNllYVlZESG1ZZHBIUVpHa1YvVjFIUjRo?=
 =?utf-8?B?djdMMjdYKzM1ZldTaURSaERRbFJFRXk2c3pCNVFHT0ZuUkFaVGU1STVsZGwz?=
 =?utf-8?B?NjJaMnBTc1BublFqVjE3QUsvN0JrQmxiV1B0RkFFWENwL2xPeTBBNEh1ZHZK?=
 =?utf-8?B?RzUrTWtGUUV4TmJtN21NYnpXYWFqN0Q5UllGb1pkazNidjJodjdGNGNyQ2Jv?=
 =?utf-8?B?eno5cXdtUEtpMDZwWEI2ajRUb2VhTFV1THY4TTZkOUhBdVVza3JBdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae8a7875-acf9-4d18-0cd8-08de622a632a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 07:12:12.6980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yqTmhb0bAFI1yssjt7xu1lMc7tNoWAQjpBYTzsd8ZOVaqdSsyZlbW6iVDG7jJC9jzqjgGt0/E4AfkMdfLHAITA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6057

From: Jan Kiszka <jan.kiszka@siemens.com>

When _FILE_OFFSET_BITS is 64, mmap is handled by the mmap64 symbol of
glibc. The original mmap continues to expect native off_t size, i.e.
32 bits on 32-bit archs.

While we require applications to be rebuilt with the same settings
Xenomai was built with as well (either both _TIME_BITS and
_FILE_OFFSET_BITS set to 64 or both left unset) which practically
shadows this issue, it remains wrong to change the wrapped mmap function
in a was that is incompatible with glibc.

To avoid running into conflicts between enabling and disabling
_TIME_BITS=64 and, thus, also _FILE_OFFSET_BITS=64, factor out the
affected mmap wrappers as well as their __real stubs into a separate
code module.

There is one catch: The cobalt-call to mmap in umm.c needs to be forced
to mmap64 to become agnostic to _FILE_OFFSET_BITS used by the cobalt
core internally.

Fixes: fb2bd6e647a9 ("y2038: build: Introduce new build parameter --disable-y2038")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Change in v3:
 - pin internal call to __cobalt_mmap64

 lib/cobalt/Makefile.am | 15 ++++++++
 lib/cobalt/mmap.c      | 79 ++++++++++++++++++++++++++++++++++++++++++
 lib/cobalt/rtdm.c      | 38 --------------------
 lib/cobalt/umm.c       |  2 +-
 lib/cobalt/wrappers.c  | 17 ---------
 5 files changed, 95 insertions(+), 56 deletions(-)
 create mode 100644 lib/cobalt/mmap.c

diff --git a/lib/cobalt/Makefile.am b/lib/cobalt/Makefile.am
index 4318adf185..ed7e503899 100644
--- a/lib/cobalt/Makefile.am
+++ b/lib/cobalt/Makefile.am
@@ -7,9 +7,12 @@ noinst_HEADERS =	\
 
 lib_LTLIBRARIES = libcobalt.la libmodechk.la
 
+noinst_LTLIBRARIES = libcobaltext.la
+
 libcobalt_la_LDFLAGS = @XENO_LIB_LDFLAGS@ -version-info 2:0:0 -lpthread -lrt
 
 libcobalt_la_LIBADD = \
+	libcobaltext.la				\
 	arch/@XENO_TARGET_ARCH@/libarch.la	\
 	../boilerplate/libboilerplate.la
 
@@ -43,6 +46,18 @@ libcobalt_la_CPPFLAGS =			\
 	-I$(top_srcdir)/include/cobalt	\
 	-I$(top_srcdir)/include
 
+# source files that require native off_t size
+libcobaltext_la_SOURCES =	\
+	mmap.c
+
+libcobaltext_la_LDFLAGS = @XENO_LIB_LDFLAGS@
+
+libcobaltext_la_CPPFLAGS =		\
+	@XENO_COBALT_CFLAGS@		\
+	-I$(top_srcdir)/include/cobalt	\
+	-I$(top_srcdir)/include		\
+	-U_TIME_BITS -U_FILE_OFFSET_BITS
+
 libmodechk_la_LIBADD = libcobalt.la
 
 libmodechk_la_SOURCES =	\
diff --git a/lib/cobalt/mmap.c b/lib/cobalt/mmap.c
new file mode 100644
index 0000000000..069163a855
--- /dev/null
+++ b/lib/cobalt/mmap.c
@@ -0,0 +1,79 @@
+/*
+ * Copyright (C) 2005 Jan Kiszka <jan.kiszka@web.de>.
+ * Copyright (C) 2005 Heikki Lindholm <holindho@cs.helsinki.fi>.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
+  USA.
+ */
+
+#include <sys/mman.h>
+#include <rtdm/rtdm.h>
+#include <cobalt/uapi/syscall.h>
+#include <asm/xenomai/syscall.h>
+
+COBALT_IMPL(void *, mmap64, (void *addr, size_t length, int prot, int flags,
+			     int fd, off64_t offset))
+{
+	struct _rtdm_mmap_request rma;
+	int ret;
+
+	if (fd < 0) /* We don't do anonymous mappings. */
+		goto regular;
+
+	/* RTDM ignores the address hint, and rejects MAP_FIXED. */
+	rma.length = length;
+	rma.offset = offset;
+	rma.prot = prot;
+	rma.flags = flags;
+
+	ret = XENOMAI_SYSCALL3(sc_cobalt_mmap, fd, &rma, &addr);
+	if (ret != -EADV && ret != -ENOSYS) {
+		if (ret) {
+			errno = -ret;
+			return MAP_FAILED;
+		}
+
+		return addr;
+	}
+
+regular:
+#if mmap64 == mmap
+	return __STD(mmap(addr, length, prot, flags, fd, offset));
+#else
+	return __STD(mmap64(addr, length, prot, flags, fd, offset));
+#endif
+}
+
+COBALT_IMPL(void *, mmap, (void *addr, size_t length, int prot, int flags,
+			   int fd, off_t offset))
+{
+	return __COBALT(mmap64(addr, length, prot, flags, fd, offset));
+}
+
+__weak
+void *__real_mmap(void *addr, size_t length, int prot, int flags,
+		  int fd, off_t offset)
+{
+	return mmap(addr, length, prot, flags, fd, offset);
+}
+
+#if mmap64 != mmap
+__weak
+void *__real_mmap64(void *addr, size_t length, int prot, int flags,
+		  int fd, off64_t offset)
+{
+	return mmap64(addr, length, prot, flags, fd, offset);
+}
+#endif
diff --git a/lib/cobalt/rtdm.c b/lib/cobalt/rtdm.c
index 00c1aaf4b2..119ba3f83d 100644
--- a/lib/cobalt/rtdm.c
+++ b/lib/cobalt/rtdm.c
@@ -541,41 +541,3 @@ COBALT_IMPL(int, shutdown, (int fd, int how))
 
 	return __STD(shutdown(fd, how));
 }
-
-COBALT_IMPL(void *, mmap64, (void *addr, size_t length, int prot, int flags,
-			     int fd, off64_t offset))
-{
-	struct _rtdm_mmap_request rma;
-	int ret;
-
-	if (fd < 0) /* We don't do anonymous mappings. */
-		goto regular;
-
-	/* RTDM ignores the address hint, and rejects MAP_FIXED. */
-	rma.length = length;
-	rma.offset = offset;
-	rma.prot = prot;
-	rma.flags = flags;
-
-	ret = XENOMAI_SYSCALL3(sc_cobalt_mmap, fd, &rma, &addr);
-	if (ret != -EADV && ret != -ENOSYS) {
-		ret = set_errno(ret);
-		if (ret)
-			return MAP_FAILED;
-
-		return addr;
-	}
-
-regular:
-#if mmap64 == mmap
-	return __STD(mmap(addr, length, prot, flags, fd, offset));
-#else
-	return __STD(mmap64(addr, length, prot, flags, fd, offset));
-#endif
-}
-
-COBALT_IMPL(void *, mmap, (void *addr, size_t length, int prot, int flags,
-			   int fd, off_t offset))
-{
-	return __COBALT(mmap64(addr, length, prot, flags, fd, offset));
-}
diff --git a/lib/cobalt/umm.c b/lib/cobalt/umm.c
index c0d4489d34..24a5f713d5 100644
--- a/lib/cobalt/umm.c
+++ b/lib/cobalt/umm.c
@@ -58,7 +58,7 @@ static void *__map_umm(const char *name, uint32_t *size_r)
 		return MAP_FAILED;
 	}
 
-	addr = __RT(mmap(NULL, statbuf.size, PROT_READ|PROT_WRITE,
+	addr = __RT(mmap64(NULL, statbuf.size, PROT_READ|PROT_WRITE,
 			 MAP_SHARED, fd, 0));
 	__RT(close(fd));
 
diff --git a/lib/cobalt/wrappers.c b/lib/cobalt/wrappers.c
index 18c237734f..3a0063f051 100644
--- a/lib/cobalt/wrappers.c
+++ b/lib/cobalt/wrappers.c
@@ -28,7 +28,6 @@
 #include <sys/select.h>
 #include <sys/socket.h>
 #include <sys/time.h>
-#include <sys/mman.h>
 #include <stdio.h>
 #include <stdarg.h>
 #include <stdlib.h>
@@ -384,22 +383,6 @@ int __real_select (int __nfds, fd_set *__restrict __readfds,
 	return select(__nfds, __readfds, __writefds, __exceptfds, __timeout);
 }
 
-__weak
-void *__real_mmap(void *addr, size_t length, int prot, int flags,
-		  int fd, off_t offset)
-{
-	return mmap(addr, length, prot, flags, fd, offset);
-}
-
-#if mmap64 != mmap
-__weak
-void *__real_mmap64(void *addr, size_t length, int prot, int flags,
-		  int fd, off64_t offset)
-{
-	return mmap64(addr, length, prot, flags, fd, offset);
-}
-#endif
-
 __weak
 int __real_vfprintf(FILE *stream, const char *fmt, va_list args)
 {
-- 
2.51.0
