Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3212F158DD1
	for <xenomai@lists.linux.dev>; Tue,  2 Jul 2024 12:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719924663; cv=fail; b=hEUrOBFv4viFjAOUu0tkzrIRLwqxHReaTVJkEVKxjVtmcyq8+HDYlOzxg8UzUZb9nUgGnAufZR/b7YqO5zBH5R4AX8edYdaVW7oJSlPRUGrXUb3dCm7LRtBgpol71Ix/jxxk7J9G5HFo91mVvsmtlQpBsTPMHVNOS5FcVPMoLSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719924663; c=relaxed/simple;
	bh=KbC1mowfNmsKlEvDQ4I4nA9iFo0pgW9tb1CDMqMOzIo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tMNhw6NpNbe6LuH2jtfoLolixvHcMXnR8RPCQqBhiB52XXOcw6QnnZZJFFIoL9Xu2WZA8Vi7yVHoS1Lo/iVyKPBfU+KAzz4osNdvEr4rjLhZ7KUadH9UdOze6KewvRKP8NwLyRCXfxyrvLPwstxB0OsnJDflbcHZI0L56d/dJQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=gIOlDqMw; arc=fail smtp.client-ip=40.107.20.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="gIOlDqMw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XAFg58eZlHxDAXDmScB/OO3AHX9qnL1s+6EBS97fUGizGM5VKHzpSu1QoSxx1lA9Foh4kFdl+u6GoVUH9RBRzmRyoIdyMFLwdyLOLxJMki0C/kuJSGL8BAgSAfP47zzUhfSyOm4gUTI30XvfHwv4i4AbB0WAUT0CLumc6c7arsk5NkaKpsBuLI5zMzsTCGLe+rXqb86yoJcm88I/0pOqjKK7rM7sTEBolckqQso0ZGgrUpRH1AgScJddUrLrusc8S6VaSkoKS4aJNLu3e75tuQ5n0QeRbZNYKDYXlDpff8OE4c+j7qIP4a7jTAXR9APi8RwNI1qlOrZvDWd6p9Ae+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCo3L/oFQDSP5XqHkhOCyDtJj0t7rXdB6BJbKmBEyDc=;
 b=iJCnymADYF7+z60k/lWjOobsAUl6L8SdXZFTJyHEwFlVPDKOTXX9EoDvZIwnWQ15a4fsf24JBPt7eUOBFer4St0I7Hmlul6HSTeVbLl8rnYKsicrlhpgcIBTlSh4R9kXOLU3IxjNc428JGRSvykyqvqDT4QGY4sQ2WJkoeTK/gkePKWX69MBEhRaIrNfA5L+Yk2PGvHd76+wRWxCNoDKDH4R2/LkHoolR2nbsa0qloanYpUZotsMr69fidt+xf5/Q8Bj+O85n9pz6qaVrss5A7C2Brz5rrP5/LBbSkM2e8mPzPYpV/4DboCrFGn45IXYxuApB3v5QVwRbjpO3g2YbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCo3L/oFQDSP5XqHkhOCyDtJj0t7rXdB6BJbKmBEyDc=;
 b=gIOlDqMwcFK8pYITQr+cv89RX8gnE5BuQC3VYVnwMSDBYkM94ALqlhUj+a2RgDNqj2j7Blrz6FonvM0eLqMBVwg3AY7jwCuklUC6j2GcIsNUsbBK5l5TmfVoiSxNg2zySnCRZwilbCLeaodNbFfXc327jweDJZ7zwvFpGuLYUAOmUSCNXlK7d8sWXB3BniADxBdkXNetYMUX1bOJQR4o4dOTkML0+76z2qQALTQgDsDSE7YXiO1cS95W3dJwkaeFVj03tRabRg5XD4Vlt8SC87/mb1LZWElEDQmCQ7MeS3uZ14mib1UuazPil2N3fs+dXkxIsQlMWRNrxyi5CjL3Ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB8436.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:41b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.34; Tue, 2 Jul
 2024 12:50:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 12:50:56 +0000
Message-ID: <234d7440-99ab-4ba8-bc17-7fff64e960c6@siemens.com>
Date: Tue, 2 Jul 2024 14:50:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Thread safety of cobalt syslog/syslogv call
To: =?UTF-8?Q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
Cc: xenomai@lists.linux.dev
References: <10fc-66825d80-9-27de53c0@198494853>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <10fc-66825d80-9-27de53c0@198494853>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0197.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB8436:EE_
X-MS-Office365-Filtering-Correlation-Id: 3162ef91-5958-442d-cbf5-08dc9a959d9d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2kyaG9mdDJPWmVGdmNzSWczT1pMNFp5KzBucEJPYjVGZTk5QktTVG5DK3NF?=
 =?utf-8?B?MHY2MnQ4RGRnMDlJQXJrakFXU1dhRGJraGlMZTE2enJwajVKZjk2NmFPTTVm?=
 =?utf-8?B?ZjMyWTM3d3FSQ1lFOEtXZDV1a3BKR2VYWVFodzA5VjFoTDhzSmFnL1dVaUN1?=
 =?utf-8?B?alZqTDBJZjFtOWxrVGg3Zm9yaEpjamFvbUkvUzczc09EbVRUYVRlZDhoeW41?=
 =?utf-8?B?MmR3aXV3WEVpMmlHeW9KMVBYYW03ZDNIdlM3ZHN4enNjdUs3VnREODY0VHNE?=
 =?utf-8?B?a1lPdm5JcmU2eXhHd1ZkWW5oVU16cFdUZCs1SXdrbmpWRzBMYmNVV2JjQmxS?=
 =?utf-8?B?blp5SERMRmM2cVlYaGhkU3M3YU1lQnNCWEp0bEovZTkxNElQSTdFeVVSSG5O?=
 =?utf-8?B?cy9NMmdVK2hhcXQ0OFppR1hFS0ZlbjRJQ2ZHK0YrWW5iTFdWNmxvV2NENG02?=
 =?utf-8?B?UTZVWHdPM2M3RmhwbFVudkdwY2F5bTRpYVR3SFc3dTFIdGxNaEhNclpDMzh1?=
 =?utf-8?B?QnBXSFd4MHBlVmFtSzFpcUFEdkc5VWFlNnR2bTVvNlc2MWtQOXV0TDI0Z0pk?=
 =?utf-8?B?ZWg3Q2Q2RWZRZTlrVzVQUElhTmRGNkFaa2FFZ0gxeWdCNWtqRzg1QlRtWEFG?=
 =?utf-8?B?TFZyWW41WG1FWnVrR2pzTk5DejZJRUtsMWE0QzlWZlJzZnUvUzBhMkFzUEo2?=
 =?utf-8?B?NG5jbkIyRi9PaStaYUNhUjJBMXlyNGlsb0U4OWFuVmxNSytYbCtJQnVFc2hT?=
 =?utf-8?B?R1JYWTlOU01RRWtINmNUcWFaZWZidHU0d09UNUFoaGtlTTVDWWVmYXNHVnNr?=
 =?utf-8?B?Sm1GY2dVS2NGSFhadjFLdVVaT3Q0VFA3V1BVU3o1c0M2QjRwRDR2Sng1M3FQ?=
 =?utf-8?B?WDh6bkdEb3dnelJMc1RyVEZXcDdTS3FMTE53MUtVWE5tU205R1JOS1NJZ2VK?=
 =?utf-8?B?Mk9NMHRwM1REenQ1eU1RcDJXSmN2MDB5b0QzLy82SExHTllpYzNycWNUZ0Zx?=
 =?utf-8?B?cVRYbkM3QTNkalhHV1gwRDQvK1pub1FkeGsyalB3aS9lRlF0ZHJBRkxFYm1u?=
 =?utf-8?B?anBMdnBjUFFFTWxzTmRvWXMvTW01UHQzaTFNRjVlM3NlWDVvQXBGSTNDV0xn?=
 =?utf-8?B?WERJOWdPS2hJajVUMVN3Q1lYRXFza1RGOHJsd3l5SHdSVnNGbzlNcFhnNWZv?=
 =?utf-8?B?cDhyZXhTNVYramFub3lFOU9iQ05UMWRWTTVLYTAwTDVmT3dDbEIzMHh4SDlB?=
 =?utf-8?B?WW5TTWVqTzN0TkFqaVJDM3M2RCtBUktZdm9pYmRIeHJUSnZqME92WEJ0aUVN?=
 =?utf-8?B?US90Z21iTVFIRnh3QWhaSHJnNXlkTmRBVks4bFNRdDZJd2lXL0RXQlRlMjgr?=
 =?utf-8?B?UUFETU4zUDR2UFdGcTBKS1VKS045WUlENk1VNWYyVFdjU1VsUmE2b0Q4bm1U?=
 =?utf-8?B?dWpxUEFCV0RybTQvN0llV1VtNDFUU2Z2dTB0NTh6YytqT0tXUUxLWkI4dFJW?=
 =?utf-8?B?U3JpWjZ6aXo4ekVYaDh1WmJKUFFwY0NWSVlBRHd0aTJ1WDZad0xwRWdhWWFU?=
 =?utf-8?B?MlVUZzB6NmR6QkJDRndLeTlKdEtmVFE4MjVjV2JIbU9uUjJ4M0wxdVFUaWlh?=
 =?utf-8?B?TElDTnZXVVNJTW9URHBPSXlna2pHVFhUa3JtNU5JMVRGRDd0bU5XcTlRdUtJ?=
 =?utf-8?B?TnY2QXhGZyt5dEtrV0F1amF6bHNpdi9JUXlUN2l4Rzk2TlJSaXllaGxPWmlt?=
 =?utf-8?B?ZWcyZ0ZRSmNPOVNnTlR0dkVyWjFyMFRFN25pakU0NGpCNWNteWFxMnR1czVW?=
 =?utf-8?B?bU0vYThpZUlCcUZ4aUxrZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFV1SFR5aWlNeWlDWXoxSzRad05XdEpHZlFQbm9jeS9YRUROOThwWUtzYW85?=
 =?utf-8?B?ZHE4cHBkK3FHTEpNalVvamVwaFY5Ums1WjdZaDF5TThmMDd2NjZlT3pkdSs3?=
 =?utf-8?B?NEtZVEFXRUY4K3JsK1p0MS9rRWdtb2d5a2Q0djFsdFdTWnAzQ3VydVpMMkdP?=
 =?utf-8?B?TDI2YTIrYk11TjlqZW1IRjZMeHdNSG5PZXVad1AxNGhuRWdVai9NWkN0SkpK?=
 =?utf-8?B?VDBZcWlYSjRac2VicmxPQnAzUlVVMXhIVG53QU8zZUl5dGJlQ1FtblVWMjlR?=
 =?utf-8?B?QXYzbC9FMjRsZ3dwR0plVXpKVnJxMUQ2dmR2dEp4bDJnRDJDdmNwTEFyU2hS?=
 =?utf-8?B?NVRPS1E0dUtZbi9ndEx0aWQ1QWJQaDJhNzZscDZOL0dFemtOTlFiWUVBUXIz?=
 =?utf-8?B?bkZZWVhYdnVDRGkyL2g2NTF3NURJTHFQaGVUaS9kQThnejZrRWxWRkhjQTM2?=
 =?utf-8?B?YU8wMXQvaytGa25yMGhnemxYOFF5WDYrRnRQZFFhdkg4d0FUUEs0MW45WThW?=
 =?utf-8?B?cDZKbS9HQkgzbkpjUjdreTBXaHIyTCtXZ09YQk0rMy9sOEVRLzVBb01vQXUw?=
 =?utf-8?B?dXZwMTlQQ2psZG4yd0pYSS9mZDB2Wk8zZHVabW01cDN4aEp2SkhSY2MrSGQ0?=
 =?utf-8?B?YU1ZNGR5QW5wVFVSRnY0TUJ2WFFGcU1GbUpUdlBSdGtZQlN4NklPcG8xaXFn?=
 =?utf-8?B?azBNUjVkanFjQWswY1NtKzh6akVJMnI1V3MrVVhxOENWaGlKTzlNWitSMWJq?=
 =?utf-8?B?ZEh2UDZ4WTExd3BVWHRlN3AwaUM1V3pmQjVlek9jSnVnWjVSanFSdlByMjlZ?=
 =?utf-8?B?NStyczlkY1F2WEJ3VWU1ek9wSTBCSmNlYXlYMVYySVVBNm0rLytucWxBTmlj?=
 =?utf-8?B?V2ViYjRyQUd6K29nWTQweU5waEtCam5lenVqQmkwSFlVWDlmRko1MEkxVlMy?=
 =?utf-8?B?eWtDanh2bXBJd0lhVmdpUnNqQkdZZmVqdWdiaENxRHhtQTRPbFkvdjZYN0xQ?=
 =?utf-8?B?ZWI1dDRwUlFZSWFxRjBocUlhWTdxb1p6MVdHaXB5Y0xoMVhMNG1iRWJaZEZG?=
 =?utf-8?B?K0RHUjIxR3BMZkZWYTA0eVFlK0g5YTBEblBpWnVJL2U1cmoxK1IvQWYzUEFT?=
 =?utf-8?B?UEdTYXBEQndqZmVZc2hmbWs3SDJPUEtGTXFZeVVEUUFtaFhVUG1Mb2J5dXVZ?=
 =?utf-8?B?bmE4dHkzMjhKdTdiQjR2WDI3V2tJdFlCemxQenFJcXRFUWNoanBzQVYyeDZ1?=
 =?utf-8?B?WndBbUFYU3h5SGUzbHYvdktWck1iN0JncitkaER1NHNUMWlUOVlBWXd6bWd6?=
 =?utf-8?B?M3grZXI4ZHJTTXBKRVd0ZnRrMUsxV2xEblNNekN5ekVoSkVnQXNXWVRJekox?=
 =?utf-8?B?SG5PMW14bzk5OUVKQWsreDJIdFdUREUrMHVDR1BNN0lYVmwzRzlEaXNwMkpS?=
 =?utf-8?B?SXdFZzY1N0ZJZzdiejlGY1M0SitKNFZvckZZaGhTWkNDNXpmRElGZkJGN3Zj?=
 =?utf-8?B?UDNaZ3VLZW9OcnhxVy9EUEIyL2NMYk0vcTZKc1NpUGZjVGZmeGdNaXVJQ0Zn?=
 =?utf-8?B?cFRDdGtVc3J1cGhrQTR2MlA0bFNsTG0zRE5qNFpKY2V5b1hBdWRtUWc0L3Rk?=
 =?utf-8?B?TmJFV1Vhd3pObFVDNFBGQThVUVRsNkFVbkhFR21QaFBKcHMrZEdEOHRyL1lE?=
 =?utf-8?B?WEQzazZvcVh2VDdrNTdDTHBXNmNFalNJZ2RoMFhTUDQ3a2NiSE1HQmEwS2Jp?=
 =?utf-8?B?a3RFSFRUOHMrK0Y2enQxenlabzR5Tk1veVFHbkZxR05mWnVON1lOZ0syWUs4?=
 =?utf-8?B?QTN1cjdSVTF6UGpqN2NTRHVlTzd5ZzZHdmZJWTM1NnQwNTdDNXQrV05SdlBs?=
 =?utf-8?B?d24zdjN3eXlGZmZ6M1dEaDFob0NSOStMR0Q0UEwza1VheFRxbE1EcDFGYTJx?=
 =?utf-8?B?ZElFZkVPL2l2alNydkRkZG1idmlRU3NuNDJSZWhYaXVJZW9rcy9IaExwOTJS?=
 =?utf-8?B?bEV6L1pha3NTNitRSjhBLzRwMzE2MG9SMCt3TE0wclpTSGl3bkQzT21HWVp1?=
 =?utf-8?B?Z212dXFMR3puaFM5akR2OFFYVWNlcVJYbGFxS1FLZkVxRHpjeklDVjMvWFZS?=
 =?utf-8?B?VURMYnBRMEk5S1phYzNIdVN4NVk1ckJZOENoeVM3bFR3dnQ2TWRQbFlVRFZ1?=
 =?utf-8?B?V0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3162ef91-5958-442d-cbf5-08dc9a959d9d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 12:50:56.6193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: smdOkm2F909/qdC6pFC6fSoH30bgb2DN8grAEYam/glG9GisrWiYfOX9PLS7LmVly/zMGovHrtd9SbDwbFH8Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8436

On 01.07.24 09:39, François Legal wrote:
> Le Lundi, Juillet 01, 2024 09:24 CEST, Jan Kiszka <jan.kiszka@siemens.com> a écrit: 
>  
>> On 01.07.24 08:47, François Legal wrote:
>>> Hello,
>>>
>>> I was wondering whether or not the syslog/vsyslog calls in cobalt runtime libs are thread safe. I observer strange behaviour in my logs under heavy log load.
>>>
>>
>> Can you be more precise in what you do? And which parts of
>> lib/cobalt/printf.c you consider problematic /wrt thread safety, the
>> printout to syslog or the wrapper functions themselves?
>>
>> Jan
>>
> 
> I have a set of threads that would each send to syslof under certain conditions. In my syslog, I can see a bunch of truncated log entries. I'd first though that maybe RT_PRINT_DEFAULT_BUFFER & RT_PRINT_DEFAULT_BUFFERS_COUNT would be too small in my application, but increasing those values did not make any differences.
> I ended up looking at the code and got to vprint_to_buffer that should be called when I want to send an entry to syslog in my RT threads, and was wondering (I believe it is not) whether or not this function was thread safe.
> Am I getting something wrong ?

You application is supposed to call rt_syslog (& Co.) or regular syslog
when wrapped to map that on the RT version (analogously to other cobalt
services). Internally, those are mapped on vprint_to_buffer, true, and
that is supposed to be thread-safe - it operates on per-thread data
structures and lock-free in a single-producer/single-consumer
relationship with the printer thread.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

