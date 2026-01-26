Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010050.outbound.protection.outlook.com [52.101.69.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969F425A64C
	for <xenomai@lists.linux.dev>; Mon, 26 Jan 2026 15:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769439710; cv=fail; b=YEJgxHNa3l28nhPlh7I8Adhuuwzf5EL5LlbjjyN03KexptDFnqMfs7X6slPvZ1y+/gv/v3AA2HXmdIMkWzt1u0OJB2dD2GcQPapdhUD973lmpzzcxTxiouCtasX0BFV6wYz8llaaTfwLiEEC3H3rQN3L4r1FxuhEfJIvAc1tMBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769439710; c=relaxed/simple;
	bh=bY1dBbBrsdcQvGfqGkwOBIasRt96YoGKsabrXjBnLFU=;
	h=Message-ID:Date:From:To:Subject:Cc:Content-Type:MIME-Version; b=r3YX0osx0ZSHqNwxDSTwFFjoBBxhaUAhTkXpl5avqU4dwskKQnveuV0WQis6HOFhlxrYl2vO43DgYogOtrNeOLLVyMb+PAxQKQzg4vFhXeX8duqcY7RYk5rgAww7SDO/SOdxfepCFFrf3EW0BeqDIEDlBzXE7hwyQg4FHtO8Ito=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=t0lCp2hH; arc=fail smtp.client-ip=52.101.69.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="t0lCp2hH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n8xRWFiP2oHkyEwrHREY24iOLusYggqLqv13EC+Fkn0F5Jk61m10s+/PYdMD9zBFKinjkf9hnRFaSnlRxvefdAu9+QAurirytfmGyE3pfuNRCrij+WaB9VYO/KP/cUmLZsWsHQD0Y8eD1o5bhCfFZnBw7an9sEr2qak2g70A5yGS8/edzbkyv+jN+wMAql+7j3O5kwBCPZCUfSIC1oVN7rObl5Basroxdjja2gttuMsfZiSE5Foa844zlBb9om9vgmVzPJLAifiJrr3L9o6S7PQST4OM78AOFQ037fQbfPCy3v/6Z6E56q3lUM3wHyUdoTUWjn+/oF+6aTpqsmaV+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqNlrKLAI+g12VGX6FlVBIkLXylYfOxQoRsgd7qAZH0=;
 b=qrTrVrU1wsgv8m4k1yQzgf0JEd0cG44EJyU/24Y3xWWfml4AWf3e4GucrZkVaY8b600ZQCWXHcByvUNIqzA3SCNiC6GR9B3LkogTIeIkPizYjPECsx1hxWnFj2tVSXABsdKTLHdTmhpb2Z5l8T66J0Z1bK9SHS7TqFM7LGccKepVvp3UXSx7w7WGdRX8fcjfh+tb1XbKtF850CX65Sojn4/3bv5EynaU3Y54JkMbNgM+wh4jIN4qTgFTRygToXZsqHpRi3z4nD5vWPFXRklnZ60Q5584M1JAvvgy4ImWc7jAnOL7X8jkd/8xSlhc1bIrvOJVgiklvs1ViTd+IIR54w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqNlrKLAI+g12VGX6FlVBIkLXylYfOxQoRsgd7qAZH0=;
 b=t0lCp2hHmCm+S/TQJE8cPPMFRnGvi/Zrck5+112D33uK0PEyIDnIG+N4T6FCOuvG+U9BiZ+9ip85tMVbeY8PzekRwZIMDzGXxTakQp7vKzVUYi0GofLYskGyZ1hg8l9VRxdsfY0RyXGNBNckAwfLTCTCQwH+EJer+Gh2+11shd7EXrlP1v+k5GBBTFynxURntKK+SEk7nZeu/pUnRBYDueLgmCv80mXB32LGAEp4pixqRSAT5XqXZ8Wu3fa2rRrlRNpVA8+tp93fFhKLSrfz9FAZEYHfdWnK31OAoysbyjwJNtUwwfDHRuCcBJiMBWbKE6y2ktevLyhcyOaro6pucQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB9513.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:554::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 15:01:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 15:01:45 +0000
Message-ID: <c2020c95-48c9-4dbc-b0bd-fa2371c0f916@siemens.com>
Date: Mon, 26 Jan 2026 16:01:44 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] linux-xenomai: Fix armhf defconfig for
 BeagleBone Black
Content-Language: en-US
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:23::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB9513:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fe27161-ebfd-46bc-fab6-08de5cebd296
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUdNZis2QUFDNTlROW9kTTNBdGVDRmc4dFIyN1dlSkFUZnBkWkZJeVV4cEZ0?=
 =?utf-8?B?UXFXTHFtZDNyMW4zV0tySEwzYkFsNnJqakFVRXEzM3ZzaitVTUpzaWZ2S2JM?=
 =?utf-8?B?NFVWd0xvZWRsUDYweWx5N3RKY2NUaW9FWjg5Q0g4Yi84bDdCNk54bk1malFu?=
 =?utf-8?B?R3hHemNMWVhoazhRS2taV3lsUkwrVldzZTNlSlBMUGxGTWd0U2R3L1VYRnVK?=
 =?utf-8?B?UkJoeHl3ZTg4NXZMMTdOMU8vZGtyNzVxTVBhZllYRDFLUkxGdU4xaFM2ZGdD?=
 =?utf-8?B?Z1pWdzJMT2RyNDB6NTZaSHE1cmk0NC96Q3dwenFYQjQ1Y0hVTE43SkFjNGwx?=
 =?utf-8?B?R3ZGQ1hRRFhFU1YyTHc3aWVneHI1WkZ0QTYxcUlqeFVIdEgvbE5UYVU1M2Uw?=
 =?utf-8?B?UUxtb0t3V1dZZFVRVEt3azlSQkQ2ZHRXOGdrb1BWSVRrYWlCRzhhYTg2Syta?=
 =?utf-8?B?RDdiQ3V1NGdkMHBiMGo5L2l3bDBsRE9uMDFUcXZEZCtnalVhanFudGdOOEZi?=
 =?utf-8?B?elRXSVhpSCt5N0w2K0thbzlXUlNJQks3T3YwSjFuNzloeGZLZGVBejNKdTkx?=
 =?utf-8?B?SjB5YURWcUJ5S3FWWWtXWmZMZUwwTVlSQldBemIwckRORVJvbXdudlBsbXBu?=
 =?utf-8?B?aGRDcExWNnA0VWVQSlI1WTl1K2RHcDIrWjJlbkRaODhESUNGRUd0QUc0cGEv?=
 =?utf-8?B?MUxSWFdjV2Q1aVkyOCt4WDIxNUFLNFpDb0VTc2J5UkZlYVljZXpQeHBsemt5?=
 =?utf-8?B?S0JNcDVwcmcwR3JVYzFQTGMxeTRNZy9EN3F1eExKTkZnemNpS3RtS0RvQnNo?=
 =?utf-8?B?aGprblB3NklyNjd2TjRzNWVzSHBTT3NLRzFSVzh6VTE4Sy92UzF3dUxaTjBI?=
 =?utf-8?B?L0pNWkhXaTBNMjUxTU9QcUpJbVVjL3J0TGVuRWtGL3VhQkRSQUFyc3JOVWF0?=
 =?utf-8?B?cTNUVnBSMDNtSUF6dm9IbXN3alBhS3dOa1FibW91S0JqVmpQNndFOE1YclpP?=
 =?utf-8?B?ejE5eTNrSERQTUhTZUZKdGZ4eDl6K2lpUzR4Wml4ZzlpNmw1NTM3NlhrWVIx?=
 =?utf-8?B?WEw2ME1kamJXRlc0Z1BVSU5wSnBLdHF4cVlMd25nUjRkT1dXU2U5T2ExaXVX?=
 =?utf-8?B?dm10d3dMY1A0UHRmSEx2MzNrM1E4QkViYTN1K3p5eTI0Z2huZUVTVnN1V0hF?=
 =?utf-8?B?dDdxOXFBNExvY0s0RHZJNmdIanViNUwwMk03MjdTaFR4aDJoR0hmeWI0NExm?=
 =?utf-8?B?RWJPRlhuWnRDNTVnRGJmSmw3UklMVkFPN1NqV1JCdGFubm85SldJRm9XbVRp?=
 =?utf-8?B?R0c1MjU5Rm0wLzg1U2RiRHgrWUVLa2M0QVFpVExaTDZOdnhlOFdySXE3V2hl?=
 =?utf-8?B?bkNYelQ4Rnd0d2ZTQU9rMWpuRm1JWE9LblE4QldEZ2ZRN3hpMUxkN2hJaDF3?=
 =?utf-8?B?WTBBcUJVeGFGZUk5QVFjWjB2T3hhTWNEOG5lZi9VU0MzNm42SXd5VTJYZ3Fr?=
 =?utf-8?B?QUtpbDVLY0xzYXBrZjZRbnBsNEhMV21od0ZhT1djTjZGa1pjaUFXY2w5NitW?=
 =?utf-8?B?eUJXMGk3WUx6M1FmTmowRTZHTjZBUG11M3l5VFZWSTdMZnZVNHZYTytXQmp0?=
 =?utf-8?B?NXNjMW5aMFZvcVl6eS81OHFSSlNIWENnMFZoZkdMT2V5aXAzOXJMY2txcTI4?=
 =?utf-8?B?VURpSDhtRDBnek9RM2hpNDVtNzVHbVoxalFzNU9UdUo1c0lCMGJIUWhzMHBp?=
 =?utf-8?B?ck9BZlgwNEVSdVI5eFplUDE2VEZ2bldwakRxU2huQk5jYytvUUtBUU1tTnIx?=
 =?utf-8?B?bWV5eE10T0VYODBFa0hRQUpEY240SmNTNVVXNEFRUVI5bndhN1M2N3JORERV?=
 =?utf-8?B?bHNyT0JSUzdUS01EemtVbGJtSjNNTVpaVkdtNExJcXQxTWlZc3dLREsyeXpZ?=
 =?utf-8?B?WVh4aUp2Y051RHBzTDJ5Q3pYYVVIKzBCMXdhRnF3bjV3WWJ6QU1UUWtJbGhr?=
 =?utf-8?B?OE1uK0wwdGxiRlJtSFhBUTBrRm9NSjhOeVdod0lFa3k0VEN6dmVQMWJGWG5l?=
 =?utf-8?B?VUdCMTJ4bkRCeTc1ZTlmOUtDS2ExYWYrWE1jVTVQZzlNcE5FdUtpUzVHTXdi?=
 =?utf-8?Q?5MLo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0JXYnJKOVFFblhQaG5iWUpKTEs3ZXlSRG9pSnNpaUVmWlNPSHNPOXZlcUda?=
 =?utf-8?B?RTVaRTZXMTd1T0g5bTFIRjR0YWN4RHphdWt0aWhUUkRGS3h3dTI2S1FhT3hS?=
 =?utf-8?B?ZCtjQlY4NWEyTU9TYlVqT0FMZjBhRmpqcTlOdTlJNmY3NnUzSzdBbktFNFkv?=
 =?utf-8?B?eTlQUVhhQWlaakF0a2ttZEI5bnFvV0htR0h3eFA0NEp0N2MrdDFndGQzbFRk?=
 =?utf-8?B?Nk82eVVmOUo3K2NWbWFZMUxtcStGZFpxaVZ5cXVUNlR3c3hLeUZYaUZFZmlK?=
 =?utf-8?B?NnhGcG11Z2Z4NkVWNVVaV21BQlFZK1FLeS9yM0kvVVpsa1JjQzFBc3h1S2ZG?=
 =?utf-8?B?UktHeDJYWVF4WVE5Vjk3YUxkaGlQcmtJVHYvZTBNY2VYczFXMjlRTlQyTi9i?=
 =?utf-8?B?clpJL25GRElBOTdRZExSRndNWmxUVU0rd1JIYjlya1RiK2grUy9YUFNHdkwv?=
 =?utf-8?B?VVEzWkUzVnIwVFRqMWRGeFpNSDZ4ZE1YN1BzZlZTR3ZTdkZ1VStCalJrN0cw?=
 =?utf-8?B?U2lhYnZoaEMxRWVlRGIxZERuVnArWU80N2NVNXpOOGFnWU85b3pjOTFuaXhp?=
 =?utf-8?B?d29pWWF6QWNZWStEeGJweTJ5K0cycEdaZE1pU3RXRnBKNFBUT3FWazRDV2tE?=
 =?utf-8?B?cE9MeGFrR3NhQTh2R1J0UnhtdUQ1aVhxdkZKUVNWeVVmdUpJRGNOdnZrMjB1?=
 =?utf-8?B?M0dhK3A0cU9VRkxuelpxdk9rNCthYmdvOHorelkyQUJTZjNVN1p4MjlYTHI4?=
 =?utf-8?B?OCt0T3MvT3FieWlRVC95MGVLOTBJRlF3bVNFcC9hamdmVDRqT2x5MHZYcE9h?=
 =?utf-8?B?RDlVRzdFVmhpYk83OG9FNzFFa0hvMXl2QTk5Y2hGdUtSL1FZQnlkU3ZMd3BO?=
 =?utf-8?B?VDhVVjlZOXJ1U1RybHoxdHNwL0NWT3NhUm8yZ2k5TVFxbUFsZjRQZ0V3eHp1?=
 =?utf-8?B?UHRxNU15dHFxZWNrTW9BaldLcW9hWFpyZ3paenhGaFZzYkxYTSt5M3lwNE1v?=
 =?utf-8?B?SjlOc1lVSDR4VU1FY0E5WlhudnAwS1RFREtIMnlSMmlFdzZ3Ulc4NmwzN1gw?=
 =?utf-8?B?RGtyby9BM1lHaVMyR2hjRjZSdGlqNGk5K1BMRUtsTmxuTVhEMDhGT2RzYVR0?=
 =?utf-8?B?UmRpTzdyUlBXUjAzRm5DZlVUM2NXbGNaV0JoRWZMVEtub2pGdTUwVm1GdUsy?=
 =?utf-8?B?OWpQVEpiRDhkcTZLVk9WdjFvOFU5ekl6ZVFpak9UR0QzbGJZUE9mOGtrQ25u?=
 =?utf-8?B?dk9ZeU1HeHhqdDdoc1JiVEdFcytqNjd3bDJnRjdTM2hUeUhtcFUyaUN0elFE?=
 =?utf-8?B?UWgvclNGZWdDQ2o1K0M1NTBSckg1Z1llSS9SSmpHWGNQVlE0d1NaeDFiVE4x?=
 =?utf-8?B?Y3htQ1JnNWlkT0FhanI1UzR3c3RqRkdPU3AxSFoxUmdhVXVrd2ZNb1JSZjE5?=
 =?utf-8?B?TTJWWXl0VFBmclFpT09TTlEzNnZvd1pKM1R5UEw5enk0c3VmbDFuTm90eXh3?=
 =?utf-8?B?QlE3VmoyeFA1WDNJaGtjazJiZnR4WU5Kbm5GaFd3NWdKVXF0TUw3WnpJYXd3?=
 =?utf-8?B?UWZsRFplTUdka01qT2tEU0p6dTdkL1k1SkZYaHIrdWFpMEVheXZPYmpsOUxR?=
 =?utf-8?B?QzNLQklpaVdMN2FXSVgxTXAxMkFOV1JiK1BEdVJ1VkNEUkxIWGJsVkpMeGtY?=
 =?utf-8?B?aTRaZHArSStHQkRpK25oUDBkcjhRcTEwcE1mL2hZYzdObXNZNUEvQUJOeTJk?=
 =?utf-8?B?T1g5c3drd01wdkhRMUhTNlZBMnRJNUpqeWd2QTdhOHRjam0zSDFCdW51RkhY?=
 =?utf-8?B?RlJQaEtySkZIcWxSRjRvbXNRbzJpUmdKS0ZiUDN4SXpaUWkrUWJ0SW5LbGZ1?=
 =?utf-8?B?RkR1WTBZVTdSSWkvS0p2cFlZUEZUaVI5bjJYZFpQbEdPbFJBQkxHZ3Rlbnc2?=
 =?utf-8?B?MFZzQTZlMW1iamRhTVp6S0N1U3VLVVA4Z0FvK0JNeU03ZjZFd21UWWNLSFVN?=
 =?utf-8?B?UDlrWUpRaXNtZkZoM0d2bTJLSC9PcWRSTHUvUGFLbEFmd0lmZDNGZGYyMGl6?=
 =?utf-8?B?L05pNVQ0b0tMTysrZ2hCM29lVWV3NXo0WU9Zc2JrNklNSDdOZ054czZXaXRr?=
 =?utf-8?B?Qk1PdXZkaUhmZGhRRjdHUjJHbjh2V1hkTFpYRFlpbkN6ZkcwQ3p2MHp6ajFJ?=
 =?utf-8?B?cFR4cHg0bkpHM3BGTVJTclU2TXBoRENVZm15TTIwemFGU0UyUjNjU21iQnc3?=
 =?utf-8?B?ajVLdDMvaHFQNjk5ZUZuczVYaDlJZkYvUzYzNUhjUUtzRkNNbjV5Zlpwd1hq?=
 =?utf-8?B?Qm1xZmlQRXU3OFcvVm9LV1IzNDZnSjFLRnByZVVzbmVBbFdBY242VmhyRmVT?=
 =?utf-8?Q?f4E+C209SgHfl7Ng=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe27161-ebfd-46bc-fab6-08de5cebd296
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 15:01:45.5634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9MkI+BULIFUj45NJK6tyPXy2K1xTIgjmBs6dTpvoxeZYmvfKhuqU4PyUK5THBAVOt7mRlzdZqeViudzueA+bTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9513

From: Jan Kiszka <jan.kiszka@siemens.com>

In 6.18, the kernel's dtb for the BBB drop "ti,omap3-uart" from its uart
compatibles. This now directs serial support the 8250_omap, rather than the
already enabled omap-serial driver.

Furthermore, we need to build-in the MMC driver since trixie because the
default initramfs will no longer include that driver as module.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Florian, maybe this also resolves your BBB issues with 6.18-dovetail.

 recipes-kernel/linux/files/armhf_defconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-kernel/linux/files/armhf_defconfig b/recipes-kernel/linux/files/armhf_defconfig
index 7f370b9..ff8908d 100644
--- a/recipes-kernel/linux/files/armhf_defconfig
+++ b/recipes-kernel/linux/files/armhf_defconfig
@@ -2748,7 +2748,7 @@ CONFIG_SERIAL_8250_FSL=y
 CONFIG_SERIAL_8250_DW=y
 CONFIG_SERIAL_8250_EM=y
 # CONFIG_SERIAL_8250_RT288X is not set
-# CONFIG_SERIAL_8250_OMAP is not set
+CONFIG_SERIAL_8250_OMAP=y
 CONFIG_SERIAL_8250_MT6577=y
 CONFIG_SERIAL_8250_UNIPHIER=y
 # CONFIG_SERIAL_8250_MOXA is not set
@@ -5209,7 +5209,7 @@ CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_IO_ACCESSORS=y
 CONFIG_MMC_SDHCI_PCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
-CONFIG_MMC_SDHCI_OMAP=m
+CONFIG_MMC_SDHCI_OMAP=y
 CONFIG_MMC_SDHCI_OF_ARASAN=y
 CONFIG_MMC_SDHCI_OF_AT91=y
 CONFIG_MMC_SDHCI_OF_ESDHC=y
-- 
2.51.0
