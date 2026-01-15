Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011044.outbound.protection.outlook.com [40.107.130.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4A73271F2
	for <xenomai@lists.linux.dev>; Thu, 15 Jan 2026 13:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768484024; cv=fail; b=pAhWmBvANDfEmM2RoEmocpUDCvpTGGuL1sNxkyKvfaA2Q6VR3ETaI1eSOfdyxW8BDf8N9eHjckf7ggL/nJmYxCw8LIxxVq4RMg3sOPmFfxBQkw0SjVRlzlGo7twYygnXEBpmnSnDxsc1AqIfZGomAYjC9lW8YhYJDwges24upRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768484024; c=relaxed/simple;
	bh=+RHySEKB2wi+hCzH58Kv18bKzcjIeAZSA2xMN8P6hBw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BRPr/Dbw74AsPDf47ggx4DOTjt+iu7lnkLZ0Dz2+/nlkRJxsIUsrJXcfzxdQMGWbd6irpVB/gcU36/J+dNZkOs6kUNGyLpedkQuUIfGz9FNOSZiLrJ2vZH3xUdA6RDwdSvMQ2O1z1jsK+BOZLz+VWqzKFNNGm8vNnnFlLSvH6Xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=tu1lojsA; arc=fail smtp.client-ip=40.107.130.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="tu1lojsA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nkh+9io6u982uUstS6MKOpuHMbH4Nh00SO7fgrlkCt9/NfSWvoBtvo9c02tR16PQLKLOqPOkD907VX2iZ5hLPUW4Dy228GDPt9gHC+0HZMtuAumKAc79iA5s3H93CfUfGmHGDQSlys6ZNgwsMTn3nKz1YJoJV/DttzApkUdZCODYIqiw/X4Zj4lGgTWt5uS7q7m2f0OmI+kbopnOFoOnLPIachOFxP8Ux6w0WkI6aBgrr7zAhWWvpzFFCJGK+FBafMpCmyqT0zDYmX3IPB1fpBJlSdaHY3dIG/wkZB4zs7RQO06K1I42rf0FX1FGSqr/xXhl8wSpVSS3ETZdg8Q3cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DsfiMlGkK9V1EepAS0eJT0AcAVqiE1vxpUCESy7vDuE=;
 b=NQUlQcoMNDyauyvLgn5i6wRhYASDsgrjPRTZMEh67FQgYJNU5OSAM/S66If+4ejgHOK10k2598pY6PY3FKvjIVziFBK2VZR+m2OKbc7elvh/YXkpLoROwUAmh3LCmHFCRKxao0yIl8l4txQ6Z+qrKfp0zUJWXpJo5w9Hh4miKLz2Dwcw/zqD3O853TsA39Us8b6hnwn/sqZjUPnac+T7hdJbW/yhpugbW9g06HEnyVQdj5iID0eQ1tTNQdYdHpewm0s7Rt2qX2q39U0khFOPTnjRomqLI92z0CTzkNVBvUj3ZPOMPM+RR4AYNhiNP2C2SnolAGv244AXlc/kaxKYiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsfiMlGkK9V1EepAS0eJT0AcAVqiE1vxpUCESy7vDuE=;
 b=tu1lojsAeQKgQyQq01Litq/V9QOXmqEtx/NWHghvsFXA9DVuDIMRM6/M7Hcli4l6qon5sV8pKcOUitxpmhmxn9tFlVRnfzKTOpMKLbk9UTpKsQIDoXCFeMc+mdy/xlFB9BIkes1QZnW/K8fJLhPHEQYA3pU7l8wB51F2LKVQqkg/ijlEwt9jbF6jgoMzIeKlu7iGaYlWQ9mDwbINrVIBo8509Kw3SDaNfas73/AHQECGfmuytsaKCaEv+ErToTy/i/DXkA1jyJAHfuGLvvS5URzIxtlmC+PPedt1QrwZ2S+y1a5mpz8ib1dk4k3VkxbzSQhkww1aKLo5naUH88GTHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7929.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:300::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 13:33:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9499.005; Thu, 15 Jan 2026
 13:33:37 +0000
Message-ID: <95cde725-1d61-4408-ae0e-0ea685ad603c@siemens.com>
Date: Thu, 15 Jan 2026 14:33:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH 3/3] test/README: make minor changes and
 fix typos
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
References: <20260114095657.2440127-1-clara.kowalsky@siemens.com>
 <20260114095657.2440127-3-clara.kowalsky@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260114095657.2440127-3-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7929:EE_
X-MS-Office365-Filtering-Correlation-Id: c75864ff-096f-4521-ef09-08de543ab02e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7142099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1FVREVHaXZxVysxNzUvaGpmdUlrZktzalNDRnJRS2FWZ0Jqb3MxcDlsa1FO?=
 =?utf-8?B?WHZ0aUN3b1dUZjIxR0FuTzRSUE9jb1Bzand1ZElZQ2toWmhMZitNeEFqM2dZ?=
 =?utf-8?B?dytVNy9FaTBJMnBoekNCM3FiU2FXVCs1RGROcnQxcWttRmNtV1ZpaTUyVDJY?=
 =?utf-8?B?ejN3WEdjY0dmSkR5d2pWb3hKSVkzYVJPek9MQ2xRV2JxT3I5bGgvWml1a09o?=
 =?utf-8?B?UklvSktwZTNpQ1A1eWdjdDdJbVhKb29Ta2s1VGFuZkZwbXV5NGVpbXF4R1lv?=
 =?utf-8?B?NjNpTHpjU1BzQ3NpWnI4R0d0MU54azBxTWdoaUEzVUdlVkozTVBuVDJGbjdm?=
 =?utf-8?B?ODRDQ2J3T2l6VnI3T0VjQ21TWjVpV1hUYkdobzdCTFNVeU9RVDFuOXhNQ0g3?=
 =?utf-8?B?cHJDOXprSGZ0RkRickxzQXNJbWVySUF1YXZXTm5jSGlrVTdUZHdSMDNhN2Y5?=
 =?utf-8?B?MTMxL2dDVG9vaHJrVzI2U2x3Sm5acUJ4M0xoYytGdzQ1d2pzMFRwSTBMSHUy?=
 =?utf-8?B?Q3Y0MVVPcFJMcGpoL3FORmMvclVrajF3SjVjWHo2ZzdyeSt2aUN3bFF6Rk1B?=
 =?utf-8?B?MHBkZnB3bi9pdzgwYStnSEd5MU9rZ2VKbzdpcDdIbS9CNjlIZmNyZS9zVDY0?=
 =?utf-8?B?a09BTy9uZENVTWk5TmNiQ2M2aHdURm00RTBRbTB1R0NYcWZ2MWZCcXlscy9X?=
 =?utf-8?B?bHd3MVVMSHhWL3pVaUhoTXRuVFV1WFNsc1ZmRkt0Q2tMVlJHRVlmbXVHbE9r?=
 =?utf-8?B?T2IxNG9tM3ZnV0N5MkFYT0FtTlFvZ1A2UjRsMm1TMURRb1A0MVBQNXNEOENE?=
 =?utf-8?B?UnB3Y3BjUkNKajd6N3RmbWxoZ0xKcS9lZmMwZ014WmE5YmVEVktEQ2Q3RDVK?=
 =?utf-8?B?UGl0a0NBem9aYy9seWlheEt5QW9QbnA4NlNGek5aZnhidVN1NU4rcDJraVgr?=
 =?utf-8?B?c1hGbFU0TG1GZXhKUjhtV2xUZEhIeS9oRDk2MWtkRlBvZCs5Zml6NGFGa2VW?=
 =?utf-8?B?aTJnOXgvWDErdGREWk1mUWltaWovd1EyYnZJT3JEcUxjTUJRMUZEZGVwcUdG?=
 =?utf-8?B?aDk0cysyazJFUEtBdEZaMUNLV2hZSmM3Q0FKcG1oVFZtZHRhUVVGS2REZ2k2?=
 =?utf-8?B?bEZrb2NwR1pYSkZjZGdUMFB3Z1hHNmxJOVJBeFUxRTFiUjRrM2Fic3R2eUdQ?=
 =?utf-8?B?OTVVamFFZ0RjNFJwaVUwYUZ3bXlpVVM4QllOdTFnUERjbXphSjJSaHRMclVG?=
 =?utf-8?B?L056ZXBuQVlIN0U2U3BIbFh6eG5oQzZCd1I4SGcrSnNacFUrUjhsZ04yL1JF?=
 =?utf-8?B?ZkI3KzhVUlBZY05Lclg1ZjZzRlZ3UmhiL2tyUmlxcllaeVhvbFE3aVh1d3Bv?=
 =?utf-8?B?dmhiL2VNa2lPTy9hbW1PazlWMkJ2OTMxZWI2UkJLZ0tnclZEYms1SUFKMkZY?=
 =?utf-8?B?bndiOW4zQjZGamZuY1U5RDdZUEFrUDg5SmNJZm9xS0VNMEo0dHN1dEMzN0ds?=
 =?utf-8?B?OTFERmozeGtpalo2REwxWmdna0Fhbk9iRkF0SnpiYnFGWktVUS9qUnpDNCt1?=
 =?utf-8?B?TzFlN05iSmZBSXBZZFQrTXdMYUNuZ3BMRzNYeEoyUTJSN3BMODJpR2FGWDdK?=
 =?utf-8?B?eDFIL1FBZ2lZcGw2cStrZEM4YzViUTl3RW9WektGbmFWUmxSZWtURkpjdUg5?=
 =?utf-8?B?REFEcERjVlVBYWZnVDdpd2w2NEo1MkJLc3h3WDloVk56T1ZxODhmY1BFSTJa?=
 =?utf-8?B?ZFdGOG9tZGxmV1RrWUlqN3FvenBXdXFZTFFJSGE3UWVzNmZXZjBUaUE4NmND?=
 =?utf-8?B?RWF1U3Z5UlZoc3g2WEhqVTBqaFhzbkkxZjgzLy8wdlRIVUNhNUtGTDN5UEJI?=
 =?utf-8?B?eW5HZ2tKQU9FSE5LTmlBUzlUOEZVSEFwZkQ1TCtiaWFEeEJwMnBGdjRtWXFu?=
 =?utf-8?B?Nk1mdEN4bEM2NFhmd0h6MVZhcUpvR3pPd3htT2xOWTZld01nUjNSY0c1UElO?=
 =?utf-8?B?enFDTmJ5L3NEbFN1ZVdmRld5cytUVlpxWk1zOEhkVDNicGhWeVJveU03Zmh2?=
 =?utf-8?Q?hMrjEl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7142099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2VST0JBUVpDTG8zRzF4U29Vak5hSW45K0ZQQnJNT2VtZUNSazRhWkdXYWlm?=
 =?utf-8?B?TEJNN0JXNElxRmpVV1BDdGhSTFgvcCt4NWo1K2dGM0pLNFFGYVhTUVdIVTZ4?=
 =?utf-8?B?UlNNZEtna3E3QWNMMnJibHUzY2g1L2ZCdnQ5NTF4aGlCV0JRLzdJMXQzZUtr?=
 =?utf-8?B?NzMzdUdhMGFVL0RiemFqTE1EcERVS3U3K1RhNmp3eHZWbHVBWWE4QkNmNjN2?=
 =?utf-8?B?SGY4b1MrL2htS2hiZ29XRHpvejhqTUdlOEpqWEdjSTU2VFpnZG5mNzZheHg5?=
 =?utf-8?B?SmlQT3JGVGRUQkdSS0U4Q04zRHZ1TGNmSDY5MVp0RHJDTnlYMC85NnJXZmlv?=
 =?utf-8?B?elZENWJaNXI2SmQwY2UzYTN0MDZndWgrWjl3MXZCeEN2S3RqQk40R2ZHUzE2?=
 =?utf-8?B?RWRrS2JOemJ2NzV0bHg1RjZrVk9ScVRoVkFMcmRjendLbTNlY01tUEI4cEVz?=
 =?utf-8?B?U3o1SVczTzhvSkFPYVFidy9BNzlBQ0FFN24za3AwVW0vaHdaZlBveTRISjZG?=
 =?utf-8?B?bTFtTHF3TElOM3BmRU43a1BxbVlnZWg0SUdidDdyWmJ5TnNMZlRPOHNTQ3g3?=
 =?utf-8?B?a3hJV2UwYUgrbXJlTTNJRnh0QXZ6QTJSNDl4ckt2ZU1QRmpFNFFUT2ZjNm1E?=
 =?utf-8?B?Y0czOUNFeHVRWlZnTFhjZ3hxNFIySkduYmM4bjA5dkpPRGFDbElkZUdkNko1?=
 =?utf-8?B?ZHd6ajIyblJ0OGJxK0xzMUljOTROUGxFYlJHdHJtb3BHVTdkbndCQkd1SFg0?=
 =?utf-8?B?M3FBMmZyaWxBd0QyTGJuNTdONkFhaWNCQ21JVitJcVZjckR2dXo1ZnN0bXpa?=
 =?utf-8?B?WXRySk9DbmRKWFR3T1BtS0hQdEZDeXg4V0c4WVI0clRsRm5qdmxJWjRncnZV?=
 =?utf-8?B?UjdNRFN2WXhjS05HcndZQTNwUUJmVUFkemxiWmQ3d3E0NHVjTVBwdnZQcmZJ?=
 =?utf-8?B?VUVRZ0VvTE1xT1F6N0p5bkNWTTN2ZkZGdUovZlFwUmlmWWcxQko0bEh1VjZD?=
 =?utf-8?B?VDVLeEdxa0JBTmtPU1pPSkNERCs3M1pkb3BJUzMzd3RsTkkwbjYvK0t2QWFY?=
 =?utf-8?B?WkxSdGhLM1Eydm5sUDA3STdEVmRHUUJpNGNNZW1tbFlxVVNkOHo1VXppY0tR?=
 =?utf-8?B?c3lHRnZDRTUrTGRmaEVRTGRTYnh5L1pTYmNhTkZWWXgrenRmalBWbmc4eDRa?=
 =?utf-8?B?STF6S0FXd01RYURDN1JhNWFWZVc2MEZHYkdvb001MjFuZ3ZNTnpDOWpuVFdO?=
 =?utf-8?B?TW15bCtEMlYyV0EyUHBRVFhPeU12V0JNTUl1cy9RNmJiNzlzdW55MnZMbndC?=
 =?utf-8?B?YlBhYXlqaDFqVEowanVhSnBqcVVXb2VEMTFzNXYyTU9HUWt1RU1UMitJVllC?=
 =?utf-8?B?UThpN1IwempjL0p5QklhS3c5aFFzOW5wWWJxazJUQndubGxxUGNWQ1FNcEZj?=
 =?utf-8?B?UjFWNDB1VTFDMEVjWlErRk1vQzlVVTB1OXZZbjdraDhiUUE5eFUvZDdPK1JI?=
 =?utf-8?B?SWwzS2FJaXJqejdwcEF3RDc1ZWNJVlNPS1E3cmF5M1hjem9RQVk0blRFRjI4?=
 =?utf-8?B?RG5BKzVXb25nZHBtaXRvNHUvNFdyNkx0T1RKY2VqMzY4TE9WRFVRZm1wRlYy?=
 =?utf-8?B?RDJrb2pUL0VSNGhTc3ZYMFJwUWlrOURMVGhSRm5WY1I5aXZUS1p0TTlocm51?=
 =?utf-8?B?SHpEamFSTzdPTHVzWkdMQlpqelV0cTRCaHErUERTNWd5MmFnUC8wcE5wSkhs?=
 =?utf-8?B?REs4ZWFzNEIrcXlRWU5KaTl2SmtXZmVKUVpwU1FEcmtNZy84RWk0NktYdnV2?=
 =?utf-8?B?SnpudWlhQks4U3BZMm9iZFFMNVk2Z2tYMldueTBLWGcyNWw0Skx2QUtDZU96?=
 =?utf-8?B?YlRlK2FycHdud0ZFRncvSTdxN2pqSHVxVmRTR0hWaTcvYmg1aHh1b24yYkw4?=
 =?utf-8?B?eGloVjA2amI1bXl1Z1lIb3IvUUt2Z2RRa21XRGJudGE0Rk9CY2hsTXVodVBN?=
 =?utf-8?B?VFpFZTJzMC9zcXRReWtWQnNMalZrSHF6SHAxYll4VE5qZXBiOTVFNGZwV2Y0?=
 =?utf-8?B?eTlpZ0pWc2lwZ3YzbGdyVGRGM3I1aEJoVmhSRnhOUWZXaWt1YWp1emFtSDF0?=
 =?utf-8?B?cUk0VkdablkyMi81Y2tXRkg2QTI2b2dhcVhJZHhaMkZ6QTkzb0kxVTVPMW0z?=
 =?utf-8?B?VnNDeUdMeDlhVzYwSTNFUlhMdENMaTFOZ0tGaWowaDZTV1cwWklGWFc2aWlp?=
 =?utf-8?B?ejFJWk9HMkc4NE53Ykg1a1I1Q2g2R3YwUmtHWGI3Sk9zY0ZiYW9wMXdpQXpl?=
 =?utf-8?B?czNaandJOGtnc281YjlZdXBQZ1FTSklneXpLT3BkdURTcGdzWU9qZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c75864ff-096f-4521-ef09-08de543ab02e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 13:33:37.6194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KRWYC/DJq8Vm9MAfjIubC1Pqg8CRj8QfDmfw77FgADUWeHK6srgknhzDSyZIO9CXQnFvu7bmZCOCJz5ZTFjAKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7929

On 14.01.26 10:56, Clara Kowalsky wrote:
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  tests/README.md | 111 ++++++++++++++++++++++++------------------------
>  1 file changed, 55 insertions(+), 56 deletions(-)
> 
> diff --git a/tests/README.md b/tests/README.md
> index b8288e7..5ad52fe 100644
> --- a/tests/README.md
> +++ b/tests/README.md
> @@ -1,13 +1,13 @@
>  # Testing
>  
> -For image testing this project uses the
> -[Linaro Automated Validation Architecture(LAVA)](https://www.lavasoftware.org/).
> -The images are generate a gitlab-ci pipeline. This pipline builds the images and
> -sends them to the lava testlab.
> +For image testing, this project uses the
> +[Linaro Automated Validation Architecture (LAVA)](https://www.lavasoftware.org/).
> +The images are generated by a GitLab CI pipeline. This pipeline builds the images and
> +sends them to the LAVA test lab.
>  
>  ## Test targets
>  
> -following images are test:
> +The following images are tested:
>  - qemu-armhf
>  - qemu-arm64
>  - qemu-amd64
> @@ -17,24 +17,24 @@ following images are test:
>  
>  ## Deploy test
>  
> -After the [LAVA setup](#lava-setup) a test can be deploy with the lavacli tool, e.g.:
> +After the [LAVA setup](#lava-setup), a test can be deployed with the `lavacli` tool, e.g.:
>  ```
>  lavacli jobs run tests/jobs/xenomai-qemu-amd64.yml
>  ```
>  
>  # Tests
>  
> -Currently the following tests are executed on each target:
> +Currently, the following tests are executed on each target:
>  - lava-smoketest
>  - xenomai-test-suite
>  
>  ### xenomai-test-suite
>  
> -The xenomai test suite executes the xeno-test tool from xenomai/testsuite.
> +The Xenomai test suite executes the `xeno-test` tool from `xenomai/testsuite`.
>  
>  # Test Architecture
>  
> -To test xenomai-images on the target hardware the following architecture
> +To test xenomai-images on the target hardware, the following architecture
>  is used:
>  ```
>                                                                 +----------+
> @@ -51,85 +51,84 @@ is used:
>                                                            \
>                                                             \   +----------+
>                                                              \- | Target n |
> -                                                              \| qemu     |
> +                                                              \| QEMU     |
>                                                                 |          |
>                                                                 +----------+
>  ```
>  A test is deployed in the following steps:
> -1. gitlab-runner: builds the artifacts
> -2. After the build is successful the build artifacts are deployed to a AWS S3 bucket.
> -3. The runner sends a lava job description to the LAVA master, who triggers the
> -job execution on LAVA Dispatcher.
> +1. gitlab-runner: builds the artifacts.
> +2. After the build is successful, the build artifacts are deployed to an AWS S3 bucket.
> +3. The runner sends a LAVA job description to the LAVA master, which triggers the
> +job execution on the LAVA Dispatcher.
>  
>  The LAVA master selects the LAVA Dispatcher to execute the given job on a
> -target. Qemu targets are executed directly on the LAVA Dispatcher. For non-virtual
> -targets the payload (kernel,rootfs,...) is deployed via tftp to the selected
> +target. QEMU targets are executed directly on the LAVA Dispatcher. For non-virtual
> +targets, the payload (kernel, rootfs,...) is deployed via TFTP to the selected
>  hardware.
>  
>  The dispatcher executes the following steps:
> -1. Instrumentation of the rootfs. This will collect the necessary lavatools
> -and adds them to the rootfs
> -2. Power up the target
> -3. deploy the payload(kernel,rootfs,...) with help of the bootloader
> -4. trigger the payload boot
> -5. execute the tests
> -6. power off the target
> +1. Instrumentation of the rootfs. This collects the necessary LAVA tools
> +and adds them to the rootfs.
> +2. Power up the target.
> +3. Deploy the payload (kernel, rootfs,...) with the help of the bootloader.
> +4. Trigger the payload boot.
> +5. Execute the tests.
> +6. Power off the target.
>  
>  # LAVA Setup
>  
> -Setup a lava environment by following the
> +Set up a LAVA environment by following the
>  [installation guide](https://docs.lavasoftware.org/lava/first-installation.html)
> -or use [lava-docker](https://github.com/kernelci/lava-docker).
> +or use [lava-docker](https://github.com/BayLibre/lava-docker).
>  
>  # CI Files
>  
> -To support different ci setups all ci files are stored in `.ci`. `.gitlab-ci.yml` in
> -the repository root use the settings to build on gitlab.com. To use another setup adapt
> -the [Custom CI configuration path](https://code.siemens.com/help/ci/pipelines/settings#custom-ci-configuration-path)
> -
> +To support different CI setups, all CI files are stored in [`ci`](/ci). The [`.gitlab-ci.yml`](/.gitlab-ci.yml) in
> +the repository root uses these settings to build on gitlab.com. To use another setup, adapt
> +the [custom CI configuration path](https://docs.gitlab.com/ci/pipelines/settings/#custom-ci-configuration-path).
>  
>  ## CI Variables
>  
> -The following variables are used and set by the ci system:
> +The following variables are used and set by the CI system:
>  - Proxy settings:
> -  - `HTTP_PROXY`    : http proxy
> -  - `HTTPS_PROXY`   : https proxy
> -  - `FTP_PROXY`     : ftp proxy
> +  - `HTTP_PROXY`    : HTTP proxy
> +  - `HTTPS_PROXY`   : HTTPS proxy
> +  - `FTP_PROXY`     : FTP proxy
>    - `NO_PROXY`      : no proxy
>  
>  - Build environment specific settings:
> -  - `ALT_DNS_SERVER`: optional, can be set to something like "8.8.8.8" to use a specific DNS server
> -  - `DISTRO_APT_PREMIRRORS`: optional, can be set to something like "deb\.debian\.org cdn-aws.deb.debian.org\n" to use a specific Debian mirror
> +  - `ALT_DNS_SERVER`: Optional, can be set to something like "8.8.8.8" to use a specific DNS server.
> +  - `DISTRO_APT_PREMIRRORS`: Optional, can be set to something like "deb\.debian\.org cdn-aws.deb.debian.org\n" to use a specific Debian mirror.
>  
> -- CI job "filers":
> -  - `ALL_QEMU_JOBS`: Default is false. Set to true to enable all qemu based jobs
> -  - `LAVA_TESTS_ENABLED`: Default is true. Set to false to disable all LAVA jobs
> +- CI job "filters":
> +  - `ALL_QEMU_JOBS`: Default is `false`. Set to `true` to enable all QEMU-based jobs.
> +  - `LAVA_TESTS_ENABLED`: Default is `true`. Set to `false` to disable all LAVA jobs.
>  
>  - LAVA settings:
> -  - `LAVA_MASTER_ACCOUNT`: lava master account name to register lavacli for test execution
> -  - `LAVA_MASTER_TOKEN`: token to connect with the lava master
> -  - `LAVA_ARTIFACTS_URL`: optional variable where to get the artifacts for testing
> -  - `LAVA_MASTER_URL`: URL to the LAVA Master
> -  - `CONTAINER_REGISTRY`: Container registry server to pull lavacli base image from. Uses registry.gitlab.com if unset.
> +  - `LAVA_MASTER_ACCOUNT`: LAVA master account name to register `lavacli` for test execution.
> +  - `LAVA_MASTER_TOKEN`: Token to connect with the LAVA master.
> +  - `LAVA_ARTIFACTS_URL`: Optional variable where to get the artifacts for testing.
> +  - `LAVA_MASTER_URL`: URL to the LAVA Master.
> +  - `CONTAINER_REGISTRY`: Container registry server to pull `lavacli` base image from. Uses `registry.gitlab.com` if unset.
>    - `WAIT_FOR_DEVICE_TIMEOUT`: Timeout for device health check. Default is 10 minutes.
>  
>  - Image deployment settings:
> -  - `USE_S3_BUCKET`: Set to `1` in order to upload build artifacts to AWS S3
> -  - `AWS_ACCESS_KEY_ID`: Key ID to use for uploading
> -  - `AWS_SECRET_ACCESS_KEY`: Secret access key for uploading
> -  - `S3_BUCKET_URL`: S3 URL where to place the artifacts (synchronize with `LAVA_ARTIFACTS_URL`)
> +  - `USE_S3_BUCKET`: Set to `1` in order to upload build artifacts to AWS S3.
> +  - `AWS_ACCESS_KEY_ID`: Key ID to use for uploading.
> +  - `AWS_SECRET_ACCESS_KEY`: Secret access key for uploading.
> +  - `S3_BUCKET_URL`: S3 URL where to place the artifacts (synchronize with `LAVA_ARTIFACTS_URL`).
>  
>  - Build settings:
> -  - `BUILD_OPTIONS` : optional parameter. Used for triggers. Overwrite to build the newest ipipe together with xenomai or other combinations.
> +  - `BUILD_OPTIONS`: Optional parameter. Used for triggers. Overwrite to build the newest ipipe together with Xenomai or other combinations.
>  
>  - Scheduled lavacli container build (not needed if using official container):
> -  - `CONTAINER_DEPLOY_TOKEN_USER`: Username of deploy token for uploading lavacli container to `CONTAINER_REGISTRY`
> -  - `CONTAINER_DEPLOY_TOKEN_PWD`: Password of deploy token for uploading lavacli container to `CONTAINER_REGISTRY`
> +  - `CONTAINER_DEPLOY_TOKEN_USER`: Username of deploy token for uploading `lavacli` container to `CONTAINER_REGISTRY`.
> +  - `CONTAINER_DEPLOY_TOKEN_PWD`: Password of deploy token for uploading `lavacli` container to `CONTAINER_REGISTRY`.
>  
> -## LAVA Template variable
> +## LAVA Template Variables
>  
> -- `TARGET`: Name of the target in the LAVA Lab
> -- `BUILD_ARCH`: Architecture of the Target
> -- `DEPLOY_DIR`: Path to the test components will be generate by the script `scripts/run-lava-tests.sh`
> -- `ISAR_IMAGE`: Name of the ISAR image (e.g. demo-image)
> -- `ISAR_DISTRIBUTION`: Name of the ISAR DISTRIBUTION (e.g. xenomai-demo)
> +- `TARGET`: Name of the target in the LAVA Lab.
> +- `BUILD_ARCH`: Architecture of the target.
> +- `DEPLOY_DIR`: Path to the test components that will be generated by the script [`scripts/run-lava-tests.sh`](/scripts/run-lava-tests.sh).
> +- `ISAR_IMAGE`: Name of the Isar image (e.g., `demo-image`).
> +- `ISAR_DISTRIBUTION`: Name of the Isar distribution (e.g., `xenomai-demo`).

Thanks, all three applied (with minor adjustments).

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
