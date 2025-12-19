Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013060.outbound.protection.outlook.com [52.101.83.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA65D316917
	for <xenomai@lists.linux.dev>; Fri, 19 Dec 2025 11:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766143884; cv=fail; b=APgezfk9baJJO5wXruVek8HCskTwpPPACBYTz5y3GQTAu7XtBASBVvSetk2djvV1yxgSKrtF9rh7NzteV2YrSol9eYsyBeGIH+bR1apPqNXxuKM9+w7o4BsK9CYzxOg5Z4L67s8JD7DzefC6k7JW+24vflOpQV1QdN02YJEt6zM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766143884; c=relaxed/simple;
	bh=yo6FXMDzkA0ZB5WttpoM3TmLmk5dlMjtJuH4Gg0CSrQ=;
	h=Message-ID:Date:From:To:Subject:Cc:Content-Type:MIME-Version; b=qwLZm9FlQESuFxGrCtZLs+jjIybTfa2FL1uPUy4bKhjq12v4GSECHtidT72tt3TGJpiJ0pJpHUytLkqIGPSZPU+76fm9sBSZR815R0cifCQd3ianDUXpp5PhF7QA99rpbVYrgH9T2fhcu6YfrmqWop16G26vzFN5F8HiIMAqKew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=E0+TjMA7; arc=fail smtp.client-ip=52.101.83.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="E0+TjMA7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aRq6qZBthCkQ2MKbcg4ZBgaX2MqR56gYXeI925mUOSHmoK8BmDKENdZwKTGVY4xAvMA4Ru0n0bcEPGkE2wH+TE2MzGufxj4QC/Ajtmrvh7+2LwN2gI8qJSu4Lhr2eilG6FO8zALH9VE5qGvvUNK6dupv1JZLZbIXqwNyURWUSs/AS9auOEGv0j3sshbYH+HmarJdK5MaXRpgyJbGlAz5lsRbdL+7AIydLUvIwRbnBxe2TTvMfrWLKDPn4gFQzwy513ic+gAZOVKsHAXeceOi4wnKCA0Yzc12j+CemVhZt46zAmWOZEyw8QOxEd5ergdTwYxy/ofF0MIf2HV7PG+pJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HN8SUzlyx+JK6t1y5raWI+RslF31gFpfxg53B71NgNg=;
 b=UG5P35JFrQtq3TpfSppnA8yDJDvGKLkNemcn/dA0gO1zEzX1X7Oh35e99uwsTZ7JOedZ33WC1/FeaEjVKMoD7dzxLr3K1+daOla5t21lgrhtkJCmO17kv/5VYmy18zJSNGb5DNhj8DYq5TuyYzugHRg7Gu4PXP4mBVKBos0E1dx3CqjLNaSwStjGdgJkyUrCnG4i14NJUfilfF2EcTz/hcD636tTwb6zowyrW8QEwG39WFoJA0StMaLFOC+CGw2L/vzEs3lkbvMGQnxuzeq6jLmpR8KykBwYlhQJ0oIx804nmlRlualAR9XZE0RTK5n5/7rTjAWxIhLXnCAmcrlRXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HN8SUzlyx+JK6t1y5raWI+RslF31gFpfxg53B71NgNg=;
 b=E0+TjMA73pd1EJD6xc6Nz3GKIZh6egdz6nVkI4sTbCzWX45fI7Wa5f658UCxNQj15fr2rZx+q60+h2yvi04ws/eeRfmdc6/SvKc1T2mcVXVr2ZReyNCmTGp18HrTCU0BvbxDzNsvujfRbLMKrx+rE/GkLpovDprDepLrn38LxdsE6VmweDCDByG/CQzXxd3ozijTDZwZQZMVhkzSt4jNfTlK0CpREOVdxmwE2Grr17kjaXAYYeTWnhFuaNL7VkSPNYXHuEnblf8t1ZiDKGuVj6a28VVL07JJYxqWULjngEzqr62fpyEDD8NN52LR8FvVNObhIdBz51w08BSf9H0o+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8901.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 11:31:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9434.001; Fri, 19 Dec 2025
 11:31:18 +0000
Message-ID: <fcbe8f96-a7ed-4678-ad60-130b535cbe57@siemens.com>
Date: Fri, 19 Dec 2025 12:31:13 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH v2] Lift minimal kernel version to 6.1
Content-Language: en-US
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0187.namprd03.prod.outlook.com
 (2603:10b6:610:e4::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8901:EE_
X-MS-Office365-Filtering-Correlation-Id: 286520a8-e937-4af5-8e06-08de3ef2205c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zld1ZWxNak1JVmtOaXVZZ2dFTjdPVGs2eXZBTlhNcUZxZE1SdmZTQzAwdXlx?=
 =?utf-8?B?Zm9BOFVHKzljQ2xHMmJWdFRjZ3NRZTZuOGlHL0MzWHhYb2YrcjJIM0RGYVNw?=
 =?utf-8?B?YjI3Q3lSVEgxdHFFdkJBNUE3NDZ3c1ZCRGFyV3RUQU11QTZwLzh6V1NRYmJX?=
 =?utf-8?B?NkZ4SERIckJ0b2p5MmNjeFNLUjNHcDV5VjVKQTVwbFc3UnFBSmtwSTFES3la?=
 =?utf-8?B?QUJGS1RYS1hOWDhXeW44T0dGSWFJWTZubDZZazBJYmNmOGQ3c0xpbDIwbjdX?=
 =?utf-8?B?VU0xWDZmQXpxdjdJdlFPZjRwSjV5UTlhZjlsVzM3NStUMjhxa3VIeWtpK0R2?=
 =?utf-8?B?VytNVDJFeHB3ZFE3Rm1uanU5Q0pJNzMrMFA0WlpEeUsvYkFMTlB2aytTUVhr?=
 =?utf-8?B?RmFuRm9MZGxFcXlQRnFtUzA2WWo1MUJIOWFZK05KQ2FLUHEweW83ZVJRaWU3?=
 =?utf-8?B?RDlNYXRkWTNmOG1QL25oSkJ6WWNEb0pQb0VzamZLeURoS2p6NUdueEN1TG1v?=
 =?utf-8?B?cG43RlBSSnFmRFVNRGJqYmFSbjJvUVR5SU1XbXhJK0NHTU9FTE93eWN5YkZG?=
 =?utf-8?B?dWhMQ3JmM2EvYmYvekJCKy9rWDBvc0JGaGI1a0lZMCtrd1NoZExFdkx5NEJk?=
 =?utf-8?B?TVJkNnRLOFp5V1VndXRVbTZnb09JMllRQnpmcnh1M0tLYTA1Y09ZTi80RWFy?=
 =?utf-8?B?MVNiU245dHY1cy9zaGhmM2UzZld6djAyRElsem9UU2FtdmxHUWRvU1MzWFBl?=
 =?utf-8?B?Q0pTYmNiYk1obEVIYUlIVGtlTmV3M2xkNlAwUTNvV2VDeVpXZ1p4cW4xZzRt?=
 =?utf-8?B?aXFPY2ZqQmhzNEtveURNSUwxU3JUN2c4cjh4NkYzUk1Kdm01K0Q2OHNaZzZh?=
 =?utf-8?B?TG1USWNubTJPazRoOCtmOVdnRHdtaHVIT00vQ1FvcEk4dSttWVlPU1dkQmJ6?=
 =?utf-8?B?MmFBVWhLbGRRZzZLWEZGZThSZWREN0VyZVVlU0I5T0lJUVQzZFNTWTlINzlY?=
 =?utf-8?B?WElLaWQ1T21jc0JXV0JtVjUvVVdtN0V0aWJxRVlENXVlOFhaTE5IU1M3WWd6?=
 =?utf-8?B?TDdCbW9ZT0ttRmhIYWtMSWc4ZW1FbE9NMFJLQkgvbXlDbzhkSnJzRVlPQ1ZN?=
 =?utf-8?B?SDZ6VGx4S1ZpY1dJQnBwQmtyUTBZTVVONkZQUmE4d1Y1ZmJyNmpqNmlEOXBx?=
 =?utf-8?B?cWZUSUpIK0lMcXpaYk56eGN3RUxnbndES25XMWZYdlB4R1NkRXIyQVI5UHBJ?=
 =?utf-8?B?aEdKUkRxR1Rlek52aURhVS9pL0hPOTBsaVJua0NGTjRXZXBGSWlTVlkvMjZz?=
 =?utf-8?B?V2d1aDkvc0U0YnVrbGtuRUI4aTNQQ1FwYUZsYUpzYTJpLzZpNVJpbTA2MDBh?=
 =?utf-8?B?NXVsVHAwQ2g5QUtLY2tWT0xIYUdSUndnbzVRaVA5eS9XeTdJcXQxRmZHcUZI?=
 =?utf-8?B?VkJaV1NHVjU5Q2pUTFp6aUpRRENDMGpiMUpXM3phRm5HZjgzNDNXVExuNEVR?=
 =?utf-8?B?eFEwdmp4d0EybmlZbFJud2tYeU1hdGJQVTFTSUJXc0lHWGk1T3NZazArZjln?=
 =?utf-8?B?c1UwV3RDOVJzMWphRk1nZDJRNkNUK2ZWUk5nbFhjWFVpSEdIczlBU1ptWC9M?=
 =?utf-8?B?LzJCcjJncEc0cXhrd3Y0VytaQWR5alhySkt3MTJyRmJwOTBsMkhTeTZ6c3E2?=
 =?utf-8?B?VXBXT290WlNyTGdCcy9ud1pGSlBWL3ZQMGRiUUhtdnF6Q2laeUNYbTRjcExT?=
 =?utf-8?B?YVZDL3dQVDhmcFdBWDlRRk9LRTlkWHdRcS9FTDVTczVBUVJYUUx6TnpaZlk5?=
 =?utf-8?B?dmtnTTVGQzBaUXpqUzlKQ29oUERDbkN2VHhyVVA3eXRmaXpHT1NVZCs5UlR4?=
 =?utf-8?B?Zmt4eXZzMXcrVmVpRnJud2pIMlNFZjkwM200Zmt5ajRxaWxCd1hlbDFyVVhw?=
 =?utf-8?Q?sArxXRp3fvQ5JBgeqAIm1DAzXa42AemG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnRFcUI4cHlKYmlDcDZRK3c0bWRaZmMyN0kxNFlUTFh6SmllYlQrOWdnVFdz?=
 =?utf-8?B?TjFDb1l4MExZODdHWXlvZitlQXZzcklUbUl1S21YVGJ4N2didkY2Y3ZJbkxH?=
 =?utf-8?B?d01MRjhLWWJpb0xtUWdQMW5HdDVHeUpqcjVKVTdRcEIxSmR0dDNKRU95bXZD?=
 =?utf-8?B?TUdJT0wwTWlhelFGYlByRStTNDY4cTJ2Y1prV2psLzc5ZHg1QkZieXlDeFdG?=
 =?utf-8?B?Y1d3OTFFUDJHU3d0eDk1Qkk3SW8xbUlvTWoweDdhS0lUc1pTaDlCckg2em44?=
 =?utf-8?B?ZkFCQUJPdmY0TG0rR0JlUFErcldQZHdEaDc3M0s5TGFiTTNRckJJam0yZ3FZ?=
 =?utf-8?B?K3lHQTI2R3E5YVNnbjhkTjhWb0lpRDluamV1SlM4aytZcW1BM0UyN2M3MURC?=
 =?utf-8?B?Qmx6bC9VYUtMQUpkU3FuYlNodmV2ODExYUlDZFBkTDU1VE16elhLVXIyVVJx?=
 =?utf-8?B?OTdGOFo3bFhaZmhGeHhJNXBEdm1aZHpaeGlXVEdVU1dSWktPejA2YlQ4VGFw?=
 =?utf-8?B?MnFWQ0JPWWpKUFZMMjVqK09EZ25nV0xldGRkbVpoc0NrOFVOdm1wL0NuNk1m?=
 =?utf-8?B?YUVHanVZUm9sVTZSMlBCdXorcGhzMnV1SjBPdmNIUkhia25UY2F6cWhzSU5n?=
 =?utf-8?B?Wm10SE9MTVBjclRRYUxsWXRzMWVFV21EbmFXV3NZZjVtN1BPTFdmcGorQmV3?=
 =?utf-8?B?Q3dKb2xCazVzalRlM3B4clErTVlkVXJRcVgwS1BNVUVmWTdqVDlGUmc4akpt?=
 =?utf-8?B?RzlVNU1NY3M5ZVMzSjBPdDJHWUdRUXVMRGF4em9aMGdXSmlvSXdIdEliSVZq?=
 =?utf-8?B?aGJJWnVkQlM4TUF2OUEvUCt6b2RjcmxtRmRFRUtPcEdGUHExaDRxVzNiQW85?=
 =?utf-8?B?ZWkrRDNieGs1UUh5UUI2VFlQOGZhWGtNaDZienZpOS9INU1LbVJsS1dKckpK?=
 =?utf-8?B?a1VWMW15YlhSK3VPRkJySEhwRFBsTEhMN2FhTXZnRExyZGlLazhhRHE2OExo?=
 =?utf-8?B?MFNoczhMWExpZVJ4WUdNVmwvVHJQQkp3WFZ3OEQ0b2VRUmlFQkw1OVUxTFgy?=
 =?utf-8?B?cUltRUNmczRWVFBRa0JnNUVOdUtmeW5acnJSSGh2cDZVV2pXVnhpaGFJVk1K?=
 =?utf-8?B?c2lMQVRVWEJTNnI5OGxRRCtLTENtYytWMC9rY1EvNkRPYXdzQ01HdHdVT1Z0?=
 =?utf-8?B?OVIyY1lkTXJ1VzYvaTR5MXljcWRqa2pFNTdZYUYxejBJMDhHWC9yOFlOTEVk?=
 =?utf-8?B?K3B5UTMzZ0FzQWU2WFVqVlZVSjliWXJ3MWp2eCtFdTlKMmpPQjg0a0lJM25v?=
 =?utf-8?B?NzRDa0NoQ2kyUVJaTDA5WXU2S2ErTHZ2OEh6NHRNTXV2M0pSbzdoZjZEZUlm?=
 =?utf-8?B?NG5xS3lHWSswTkh3aGViM2NJek1jQkVFbW1vUDJkUnJXYmpLUDltdHg0SHBS?=
 =?utf-8?B?cDVSQXkrSlFJK2RIMTNCaHZ2RjZYWFFuczA0bGM0bFJDM1diN0xuOW9SWUtl?=
 =?utf-8?B?eFJ4SWc3THdGWWkrbjF2Vnkvd3ZWM2s5dTVGNnpLakhobUZxRWVLWEZlZE9X?=
 =?utf-8?B?bTZjZ3NLVCtXaHR0V3dYSlo0akQrZ3hnc0tGN2x1MStBS05TREJsYVJHN3Zi?=
 =?utf-8?B?SGhuVTc2cEVtMjZXMGtpL3UzZnFUTGExVEdzT0lKZnJBS09PcHlzRnQ5MS92?=
 =?utf-8?B?bmNDczdDSm1NVWxES3NFNVpGdlRrbGZVRzZaMGVwVExMQ1ArR01HOG9yaW5W?=
 =?utf-8?B?WHFYZmdOZU9lenBlOS93a2l4M3hURWZYaVdseXBOMEQvdk5ZVmNiSFc5Qzla?=
 =?utf-8?B?ektVQUJDeVZXR2tIV3BkSVJtdGpvalJKWDhaYWhLeGVVRTlyTUpjb3FYQmEr?=
 =?utf-8?B?SnJmVk9MQzA5NkdFeElxTUpjd1lzTmJ2MzhXWUMxUG1QR2hOZnV6MDM0NHBm?=
 =?utf-8?B?N2RIdlNDeGhuN2hNSHh4UzNuVDk2VStCNko2aklyY0VhNVNmRTBOZW95bUhj?=
 =?utf-8?B?UHl3emJOZjV3Vk0yUHA1ZXk4UFprM1pORWxPcUpFdU1ja3dkYlk1aTlycW54?=
 =?utf-8?B?V282SUFEL0lSK1Zaa1kyL3FFOXJqRys4Q0JYS3JLQW9YR1kzQ1hDa2EvYjRP?=
 =?utf-8?B?L0dNZ0dldU5maEM0YUdGakQ3U3VSY1Iyb1F0ckVmZjRqSFRobjhPZWcvZXR2?=
 =?utf-8?B?VVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 286520a8-e937-4af5-8e06-08de3ef2205c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 11:31:18.1891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nKPkd3Ot2sC2aY6J+HgSfHSVQ8G6Eu6aGW9gVVhJ/j5KECwsAYgwMfD6HPzAW2HU8X37adaXR/kT8Ct4qqF/Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8901

From: Jan Kiszka <jan.kiszka@siemens.com>

To limit the test matrix of the next major release, lift the minimally
supported kernel version to 6.1. Drop any compat code for older kernels
and update the pipeline to use 6.12 instead of 5.10 for build tests.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - update the pipeline
 - update installation guide

 .gitlab-ci.yml                                | 24 +++++++++----------
 doc/asciidoc/README.INSTALL.adoc              |  2 +-
 .../include/asm-generic/xenomai/wrappers.h    | 24 -------------------
 kernel/drivers/net/drivers/at91_ether.c       | 10 --------
 kernel/drivers/net/drivers/e1000e/netdev.c    | 10 --------
 .../drivers/net/drivers/freescale/fec_main.c  | 18 --------------
 kernel/drivers/net/drivers/igb/igb_main.c     |  8 -------
 kernel/drivers/net/drivers/igc/igc_main.c     |  8 -------
 kernel/drivers/net/drivers/macb.c             | 10 --------
 kernel/drivers/serial/16550A_pci.h            |  2 --
 kernel/drivers/spi/spi-device.c               |  8 -------
 11 files changed, 13 insertions(+), 111 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index fd23775965..572e0990a3 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -193,18 +193,18 @@ arm-6.xx-latest:
     PIPELINE_REV: "v6\\.[0-9].*-dovetail-rebase"
     KERNEL_DEFCONFIG: multi_v7_defconfig
 
-arm-6.1-head:
+arm-6.12-head:
   extends: .build
   variables:
     ARCH: arm
-    PIPELINE_REV: v6.1.y-cip-dovetail-rebase
+    PIPELINE_REV: v6.12.y-dovetail-rebase
     KERNEL_DEFCONFIG: multi_v7_defconfig
 
-arm-5.10-head:
+arm-6.1-head:
   extends: .build
   variables:
     ARCH: arm
-    PIPELINE_REV: v5.10.y-cip-dovetail-rebase
+    PIPELINE_REV: v6.1.y-cip-dovetail-rebase
     KERNEL_DEFCONFIG: multi_v7_defconfig
 
 arm64-6.xx-latest:
@@ -214,18 +214,18 @@ arm64-6.xx-latest:
     PIPELINE_REV: "v6\\.[0-9].*-dovetail-rebase"
     KERNEL_DEFCONFIG: defconfig
 
-arm64-6.1-head:
+arm64-6.12-head:
   extends: .build
   variables:
     ARCH: arm64
-    PIPELINE_REV: v6.1.y-cip-dovetail-rebase
+    PIPELINE_REV: v6.12.y-dovetail-rebase
     KERNEL_DEFCONFIG: defconfig
 
-arm64-5.10-head:
+arm64-6.1-head:
   extends: .build
   variables:
     ARCH: arm64
-    PIPELINE_REV: v5.10.y-cip-dovetail-rebase
+    PIPELINE_REV: v6.1.y-cip-dovetail-rebase
     KERNEL_DEFCONFIG: defconfig
 
 x86-6.xx-latest:
@@ -235,18 +235,18 @@ x86-6.xx-latest:
     PIPELINE_REV: "v6\\.[0-9].*-dovetail-rebase"
     KERNEL_DEFCONFIG: x86_64_defconfig
 
-x86-6.1-head:
+x86-6.12-head:
   extends: .build
   variables:
     ARCH: x86
-    PIPELINE_REV: v6.1.y-cip-dovetail-rebase
+    PIPELINE_REV: v6.12.y-dovetail-rebase
     KERNEL_DEFCONFIG: x86_64_defconfig
 
-x86-5.10-head:
+x86-6.1-head:
   extends: .build
   variables:
     ARCH: x86
-    PIPELINE_REV: v5.10.y-cip-dovetail-rebase
+    PIPELINE_REV: v6.1.y-cip-dovetail-rebase
     KERNEL_DEFCONFIG: x86_64_defconfig
 
 i386-userland:
diff --git a/doc/asciidoc/README.INSTALL.adoc b/doc/asciidoc/README.INSTALL.adoc
index cad32f3d56..5797b8fc0d 100644
--- a/doc/asciidoc/README.INSTALL.adoc
+++ b/doc/asciidoc/README.INSTALL.adoc
@@ -267,7 +267,7 @@ although this is not mandatory if building with `--disable-tls`.
 _Cobalt_-specific requirements
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-- The kernel version must be 5.10 or better.
+- The kernel version must be 6.1 or better.
 
 - An interrupt pipeline (Dovetail) patch must be available for your
   target kernel. You can find the official patches issued by the
diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
index b611c405c8..a68c3b1951 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
@@ -43,30 +43,6 @@
 		.proc_lseek = seq_lseek,				\
 }
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(5,11,0)
-#define IRQ_WORK_INIT(_func) (struct irq_work) {	\
-	.flags = ATOMIC_INIT(0),			\
-	.func = (_func),				\
-}
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(5,14,0) && \
-    (LINUX_VERSION_CODE >= KERNEL_VERSION(5,11,0) || \
-     LINUX_VERSION_CODE < KERNEL_VERSION(5,10,220))
-#define close_fd(__ufd)	__close_fd(current->files, __ufd)
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(5,15,0) && \
-    (LINUX_VERSION_CODE >= KERNEL_VERSION(5,11,0) || \
-     LINUX_VERSION_CODE < KERNEL_VERSION(5,10,188))
-#define dev_addr_set(dev, addr)		memcpy((dev)->dev_addr, addr, MAX_ADDR_LEN)
-#define eth_hw_addr_set(dev, addr)	memcpy((dev)->dev_addr, addr, ETH_ALEN)
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(5,17,0)
-#define pde_data(i)	PDE_DATA(i)
-#endif
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(6,2,0)
 #define timer_delete_sync	del_timer_sync
 #endif
diff --git a/kernel/drivers/net/drivers/at91_ether.c b/kernel/drivers/net/drivers/at91_ether.c
index a5ef40c579..4bd2ec76ba 100644
--- a/kernel/drivers/net/drivers/at91_ether.c
+++ b/kernel/drivers/net/drivers/at91_ether.c
@@ -303,9 +303,6 @@ static int __init at91ether_probe(struct platform_device *pdev)
 	struct macb *lp;
 	int res;
 	u32 reg;
-#if LINUX_VERSION_CODE < KERNEL_VERSION(5, 13, 0)
-	const char *mac;
-#endif
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!regs)
@@ -358,15 +355,8 @@ static int __init at91ether_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, dev);
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(5, 13, 0))
 	res = of_get_mac_address(pdev->dev.of_node, lp->dev->dev_addr);
 	if (res)
-#else
-	mac = of_get_mac_address(pdev->dev.of_node);
-	if (mac)
-		memcpy(lp->dev->dev_addr, mac, ETH_ALEN);
-	else
-#endif
 		rtmacb_get_hwaddr(lp);
 
 	res = of_get_phy_mode(pdev->dev.of_node);
diff --git a/kernel/drivers/net/drivers/e1000e/netdev.c b/kernel/drivers/net/drivers/e1000e/netdev.c
index 0679688e20..dad685eb7b 100644
--- a/kernel/drivers/net/drivers/e1000e/netdev.c
+++ b/kernel/drivers/net/drivers/e1000e/netdev.c
@@ -3912,11 +3912,6 @@ static int e1000_probe(struct pci_dev *pdev,
 	if (err)
 		goto err_pci_reg;
 
-#if LINUX_VERSION_CODE <= KERNEL_VERSION(6,0,0)
-	/* AER (Advanced Error Reporting) hooks */
-	pci_enable_pcie_error_reporting(pdev);
-#endif
-
 	pci_set_master(pdev);
 	/* PCI config space info */
 	err = pci_save_state(pdev);
@@ -4240,11 +4235,6 @@ static void e1000_remove(struct pci_dev *pdev)
 
 	rtdev_free(netdev);
 
-#if LINUX_VERSION_CODE <= KERNEL_VERSION(6,0,0)
-	/* AER disable */
-	pci_disable_pcie_error_reporting(pdev);
-#endif
-
 	pci_disable_device(pdev);
 }
 
diff --git a/kernel/drivers/net/drivers/freescale/fec_main.c b/kernel/drivers/net/drivers/freescale/fec_main.c
index 69a3517621..cb0eda73bf 100644
--- a/kernel/drivers/net/drivers/freescale/fec_main.c
+++ b/kernel/drivers/net/drivers/freescale/fec_main.c
@@ -1250,15 +1250,9 @@ static void fec_get_mac(struct net_device *ndev)
 	if (!is_valid_ether_addr(iap)) {
 		struct device_node *np = fep->pdev->dev.of_node;
 		if (np) {
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(5, 13, 0)
 			int err = of_get_mac_address(np, tmpaddr);
 			if (!err)
 				iap = tmpaddr;
-#else
-			const char *mac = of_get_mac_address(np);
-			if (!IS_ERR(mac))
-				iap = (unsigned char *) mac;
-#endif
 		}
 	}
 
@@ -2157,13 +2151,9 @@ static void fec_enet_itr_coal_set(struct net_device *ndev)
 }
 
 static int
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(5, 15, 0)
 fec_enet_get_coalesce(struct net_device *ndev, struct ethtool_coalesce *ec,
 		      struct kernel_ethtool_coalesce *kernel_coal,
 		      struct netlink_ext_ack *extack)
-#else
-fec_enet_get_coalesce(struct net_device *ndev, struct ethtool_coalesce *ec)
-#endif
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
 
@@ -2180,13 +2170,9 @@ fec_enet_get_coalesce(struct net_device *ndev, struct ethtool_coalesce *ec)
 }
 
 static int
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(5, 15, 0)
 fec_enet_set_coalesce(struct net_device *ndev, struct ethtool_coalesce *ec,
 		      struct kernel_ethtool_coalesce *kernel_coal,
 		      struct netlink_ext_ack *extack)
-#else
-fec_enet_set_coalesce(struct net_device *ndev, struct ethtool_coalesce *ec)
-#endif
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	struct device *dev = &fep->pdev->dev;
@@ -2238,11 +2224,7 @@ static void fec_enet_itr_coal_init(struct net_device *ndev)
 	ec.tx_coalesce_usecs = FEC_ITR_ICTT_DEFAULT;
 	ec.tx_max_coalesced_frames = FEC_ITR_ICFT_DEFAULT;
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(5, 15, 0)
 	fec_enet_set_coalesce(ndev, &ec, NULL, NULL);
-#else
-	fec_enet_set_coalesce(ndev, &ec);
-#endif
 }
 
 static int fec_enet_get_tunable(struct net_device *netdev,
diff --git a/kernel/drivers/net/drivers/igb/igb_main.c b/kernel/drivers/net/drivers/igb/igb_main.c
index d757396479..aedf526b63 100644
--- a/kernel/drivers/net/drivers/igb/igb_main.c
+++ b/kernel/drivers/net/drivers/igb/igb_main.c
@@ -2029,10 +2029,6 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err)
 		goto err_pci_reg;
 
-#if LINUX_VERSION_CODE <= KERNEL_VERSION(6,0,0)
-	pci_enable_pcie_error_reporting(pdev);
-#endif
-
 	pci_set_master(pdev);
 	pci_save_state(pdev);
 
@@ -2467,10 +2463,6 @@ static void igb_remove(struct pci_dev *pdev)
 	kfree(adapter->shadow_vfta);
 	rtdev_free(netdev);
 
-#if LINUX_VERSION_CODE <= KERNEL_VERSION(6,0,0)
-	pci_disable_pcie_error_reporting(pdev);
-#endif
-
 	pci_disable_device(pdev);
 }
 
diff --git a/kernel/drivers/net/drivers/igc/igc_main.c b/kernel/drivers/net/drivers/igc/igc_main.c
index 29501b6108..a3a6b71135 100644
--- a/kernel/drivers/net/drivers/igc/igc_main.c
+++ b/kernel/drivers/net/drivers/igc/igc_main.c
@@ -3693,10 +3693,6 @@ static int igc_probe(struct pci_dev *pdev,
 	if (err)
 		goto err_pci_reg;
 
-#if LINUX_VERSION_CODE <= KERNEL_VERSION(6,0,0)
-	pci_enable_pcie_error_reporting(pdev);
-#endif
-
 	pci_set_master(pdev);
 
 	err = -ENOMEM;
@@ -3925,10 +3921,6 @@ static void igc_remove(struct pci_dev *pdev)
 
 	rtdev_free(netdev);
 
-#if LINUX_VERSION_CODE <= KERNEL_VERSION(6,0,0)
-	pci_disable_pcie_error_reporting(pdev);
-#endif
-
 	pci_disable_device(pdev);
 }
 
diff --git a/kernel/drivers/net/drivers/macb.c b/kernel/drivers/net/drivers/macb.c
index 6da5761479..36b258012e 100644
--- a/kernel/drivers/net/drivers/macb.c
+++ b/kernel/drivers/net/drivers/macb.c
@@ -1570,9 +1570,6 @@ static int __init macb_probe(struct platform_device *pdev)
 	u32 config;
 	int err = -ENXIO;
 	struct pinctrl *pinctrl;
-#if LINUX_VERSION_CODE < KERNEL_VERSION(5, 13, 0)
-	const char *mac;
-#endif
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!regs) {
@@ -1690,15 +1687,8 @@ static int __init macb_probe(struct platform_device *pdev)
 	config |= macb_dbw(bp);
 	macb_writel(bp, NCFGR, config);
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(5, 13, 0)
 	err = of_get_mac_address(pdev->dev.of_node, bp->dev->dev_addr);
 	if (err)
-#else
-	mac = of_get_mac_address(pdev->dev.of_node);
-	if (mac)
-		memcpy(bp->dev->dev_addr, mac, ETH_ALEN);
-	else
-#endif
 		rtmacb_get_hwaddr(bp);
 
 	err = of_get_phy_mode(pdev->dev.of_node);
diff --git a/kernel/drivers/serial/16550A_pci.h b/kernel/drivers/serial/16550A_pci.h
index 161874d1cc..95d1b90586 100644
--- a/kernel/drivers/serial/16550A_pci.h
+++ b/kernel/drivers/serial/16550A_pci.h
@@ -36,7 +36,6 @@ struct rt_16550_pci_board {
 #define PCI_DEVICE_ID_CP112UL		0x1120
 #define PCI_DEVICE_ID_CP114UL		0x1143
 #define PCI_DEVICE_ID_CP138U		0x1380
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(5,17,0)
 #define PCI_DEVICE_ID_MOXA_CP102UL	0x1021
 #define PCI_DEVICE_ID_MOXA_CP102U	0x1022
 #define PCI_DEVICE_ID_MOXA_C104		0x1040
@@ -48,7 +47,6 @@ struct rt_16550_pci_board {
 #define PCI_DEVICE_ID_MOXA_CP134U	0x1340
 #define PCI_DEVICE_ID_MOXA_C168		0x1680
 #define PCI_DEVICE_ID_MOXA_CP168U	0x1681
-#endif
 
 static const struct rt_16550_pci_board rt_16550_moxa_c104 = {
 	.name = "Moxa C104H/PCI",
diff --git a/kernel/drivers/spi/spi-device.c b/kernel/drivers/spi/spi-device.c
index 9fb1501fe8..f3963d81d7 100644
--- a/kernel/drivers/spi/spi-device.c
+++ b/kernel/drivers/spi/spi-device.c
@@ -124,19 +124,11 @@ static int spi_device_probe(struct spi_device *spi)
 	return 0;
 }
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(5,18,0)
 static void spi_device_remove(struct spi_device *spi)
-#else
-static int spi_device_remove(struct spi_device *spi)
-#endif
 {
 	struct rtdm_spi_remote_slave *slave = spi_get_drvdata(spi);
 
 	slave->master->ops->detach_slave(slave);
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(5,18,0)
-	return 0;
-#endif
 }
 
 static const struct of_device_id spi_device_match[] = {
-- 
2.51.0


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
