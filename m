Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010039.outbound.protection.outlook.com [52.101.69.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F2E2367CD
	for <xenomai@lists.linux.dev>; Mon, 18 Aug 2025 16:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755534831; cv=fail; b=YVrSjAQ7jfT1zY099atITrDTnB4Szpswx0CY31p7wRHoq/krDVkUTpx/e50BxRxv/d7NT6yIOE/iDda3T4BEPtoysyHh23RigaFBPLApTOSPQjDZtEAY4HHyGLAxYPjnr9FDst42CGmdEi4vSoycHV550HUstG8UzT43nZ6oOjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755534831; c=relaxed/simple;
	bh=d4U90FNGIXfBML22/OfQn51O3KOlBXAvUW8IWpiur7U=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BcUgt/fDVqKhdDAuTbhfvoyzf0xCtI4VatOYRr3gLdJk5YgDfrlo4Qp98EsPPOn1QGFhZx75WHQ8RdGRNXge0F4I+5Ua1IbokphTwJGI4qf0VKdUkLgPxELKEwM6Kofb3+Q9KqVFCW4UiZMK2YwtS+Z3yZ1MWAnfIfXL3cUKnN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Eesw8OBM; arc=fail smtp.client-ip=52.101.69.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Eesw8OBM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o6/AxrDyLiG1yOc0XSFTMGU6hoxbYkwIsXCBa1e845+KzB1/AbCZTQQWnc1nOVxfoYG7V52Q82yWvLvxdioy+BZX3CEsyvbxeIThPHFUeJbhCHjfFSH2kKAbYN856Mw73OieXq6SQSDQbWhi853nPcmnVfa0xSxhmN/4/syr/chcjBrHA8Me/SKIh/D71cm2VQvBxAwmKedUSPy2po1GHaCt3Mrdg25yPxf7MDrHjH4RwZSU6y8edKM0NT6rvljqXAoZDmkXWxJjEBN0OnOYp3IZbVOonarbPzFlMFp4s1sg8HJeX3g42fGW4Eb+JaIEb7MIAggnR49yZ+QmCNNICQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uyErXbXNearRNRFJlgzEpOvUMNpfUMcNNPdUNcOs/4=;
 b=yEwz7ds71CWmtG+QGrRW13aDIkm5EqQwMgYT6S0hY+z7FDwPM5JrMWJUOznQ9elmZxYppV7azGnecYIvezvw5/qqd1euo0xQTup6TgvAn0PPcU9/SHls5VIJit54pvvXUf6PUWoHf1+bwlN51NU+wCpWB3Rgf792/pVHCr0SNzDmgGpzOMqQLkyabCPX/6bT3DE/aeGfcbClJNx2WeTWVhnvv6vJciQAbeCygWEZbE3b/XtHdSjAp3ZWFgsCWdFDzH4VIPdGRoJqQ8doiTSjqGMZvVWgJAZzOyb6S5gINfPJ5a1p44IAJFoq7NiojQVlDAD52mJ9hgiAHbgs3OMzHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uyErXbXNearRNRFJlgzEpOvUMNpfUMcNNPdUNcOs/4=;
 b=Eesw8OBMKmbLo9Dyuz63trRTokcvIZLvo9A0Jcxls+sZ71hXIgF5BrHRmYWaSRnPqztNBz0NQkgTX7z7/mJRBLg6FQSPLeGwqrpBa6xQcTtJvKv1xngmcAQRZalmftSiuNHExQl+xdTNfK/CAhT+66zyt2DozRHGZr42pAUoaTJQvI0V2w2q9tYK/AU30Qi3jjpHO1gSzBcjx+GPzjITkpnh/Ti+2RFBFmnF5hQOkufbs8iUkCe+uMaBZ4jIbk27wYpHce19n5BAKUrSn5fF4bdf2Mq8gDCgQPwxjPFW4X1zISui4vVYtcGQXGlA5c2N0Bd56e+IXZ+DnEDSOh2jeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB9109.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 16:33:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 16:33:45 +0000
Message-ID: <4877f4f9-c018-45fd-8039-6104957c0a65@siemens.com>
Date: Mon, 18 Aug 2025 18:33:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] Add missing MODULE_DESCRIPTION() to all affected
 drivers
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20250812-wip-flo-add-missing-module-descriptions-v1-0-c57f195e3f93@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250812-wip-flo-add-missing-module-descriptions-v1-0-c57f195e3f93@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB9109:EE_
X-MS-Office365-Filtering-Correlation-Id: e5039bca-a8db-4b2f-68b5-08ddde75001b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVlhbi9nSXh6N1lIOTczZnBOVE9yRFV4YUh1Wi96WkN0dGxvc1ZDY3R2aytZ?=
 =?utf-8?B?enBuVWVZVUdRN3Z0akhNL2lVZUlwY0Z2UGJ3UDJIR0NWYit4SFc4ai9jNGNp?=
 =?utf-8?B?MkJTUlFmV2ptRlBVR283aThMRi92NXlqOVdhK2xubnVIV2RRY05QYmRnMC9P?=
 =?utf-8?B?QW1CQmNaeUY4VWEwZ3c2cDhtZjBFeHdUYW00TW5qdUFZcUViTWt2eE5kT2dR?=
 =?utf-8?B?aDJRclpCMkhBT0FNM2ppK3d3MU9OcEs2aUVQclFCZmhpUUNranhIaUdlMDJu?=
 =?utf-8?B?UFRzNHlpSTZvNkg2eThuVVYyTFBHbEpORDVSWUljQkRjN0E5NlNGV1dZci9D?=
 =?utf-8?B?NGpkRnV5TWJsTDlmeFcrQUVFN1ltTFA0MVhRZWxhYWRFVTRGcmVoVGNTQk9S?=
 =?utf-8?B?ZVFidFBaWklIelNjNUQ0Q1VkdXAxeTBIelJ2bXpYWER0NThmYmdQeHpMQWhy?=
 =?utf-8?B?cDFRZjM0VnFPeE0xVUJYVElKbnVMRyt3TXNqeFdJQTIyQkV3YnhwaStTWVpR?=
 =?utf-8?B?U2ZpRTFVRm5HL09NdEIzK0VsZzNsVnZXNWd5TUNBY0RsdXVmK0lHekw1NGkr?=
 =?utf-8?B?eDFSdzVleVlpOUJTbU0zbjJ6RDU4ZE5iVGM4enRtYnpLWGNOYUxIUjhRNTJ0?=
 =?utf-8?B?Zzh4TlBnc0hESUs3cEdsMXB3TUE5U0tZTEJhTHRQbWZDbWNjbjIyTWZTeTRD?=
 =?utf-8?B?SEROZmN2RTNiQ0FqbHVQTnhzb0JqbGljOFBMV0EvTDVFRmh5MGs5NEEwUmxs?=
 =?utf-8?B?MnlkRC9jb0t3VmFBYzQ4UnVESFlyWkUrNE5lbGJtamt4Sk4wdE5MU3hhVUxS?=
 =?utf-8?B?dXc4enpkSmp1Slh0NXAvR0g5NkNPekpoaHRTREdKQ2J0MEtTc1poRzVpZ2h6?=
 =?utf-8?B?by9lZ0VTZWRPTitQaExnVXk1U3AzWlVKaktLWXJwTmlJeW5Gek5Wa0lKTWRk?=
 =?utf-8?B?aVE4UnNUa3UxTXlzNHRHTzVFdS9qUHhBZ3E3a3Z0WUhVcjM4U09hMTdLeTZy?=
 =?utf-8?B?eXBmbHFrdDVIVzlSekVlQldMKys3cGtjR3VDZk9xTkRiYUdaTmgyWVRXT2lI?=
 =?utf-8?B?K2lsalJQSXRlbCs1MlZYQThNT2trOVczRUJlVWE5ZmVwSGNXQnZmbUhacGQv?=
 =?utf-8?B?aVVhcDVNRnFLaHN4TnFLR3R3K2Z2SGZCR3JKUExlcWxZQVNDaytoY1dyZVMy?=
 =?utf-8?B?cU13TUxHL1p4VlQwamUrcHArN0RVZUhIZ0tQbTIyRnp3U2VaTUNqYkNyM1FI?=
 =?utf-8?B?aW9VNHFrbjEybVMyeEwwUFN0bTJLakVhSTk3MjR0VG9JRG9sWVlNRXpvbWxk?=
 =?utf-8?B?RXRlaGVOaUlCL2JZeCtNdEs2S0hzK3BZTXVTL0FuSmZHQmlkSDVWTWVIclQ1?=
 =?utf-8?B?YzRjS2hyYnFQK2hrYUc1TEJVUmhOSTVTejZnVDdycHRxdWRNM0QzeWpYOUxo?=
 =?utf-8?B?aVJzWUJMTVNwT285V0R4OU5XY3hrRXJURVN3RFRsYXdmSXY4OE1yR3VlOW8y?=
 =?utf-8?B?YmdQSlIwUUxVWVdDUXl2NTM2bU1DelNhMUJqVXI3YkpCR21YekVySzJOK1ow?=
 =?utf-8?B?S25ROHNxMVJBTnMvcVVldStBRGtqWTIrZURnN0VKWmZ0NjFjZVdqekxEamJQ?=
 =?utf-8?B?bFhMQW9tRGR0MFRCWXRjZDFuK3lwSnVFelY3VnZ0V3N1QloxcjdKTS8wemNJ?=
 =?utf-8?B?VDJKdlovb3BWZFQ4bUpIQ2RkcmZXb24rdWJFM2RHZm5waXN0eDBUTUpoY2NK?=
 =?utf-8?B?WVJ3YW1kQlN2WGNGcHd1SUVob281UDN4MnVYUVpzeFpkT3hHMFNhdkRrbVVj?=
 =?utf-8?B?RWJqL0V6ZUd4MndqaWZCRGVTUjZYK3piWjRnYjRRV2Z1TlpYN3NHZytNak5X?=
 =?utf-8?B?K0NVZ0RPMVJUUWZFSlZrUTZaQXkyMEt3cFZSTExGblZRZWZmb1lFekRnOEFG?=
 =?utf-8?Q?CqnESPXmeYI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3ZVampBeTBiWHFFcmtHZko4VmQ1RnJ6S2F2MFBIcTE5L05NbWgva1p1eFlL?=
 =?utf-8?B?TzZyUTNvbW5zMDAzbEVJRmsyN1lUN0FHTncveTdZYzBaYjVxeUZ4WmpFUmRN?=
 =?utf-8?B?T0VIbExVYm83NURaVGhocFAwcGdzdllRR1NiRXJQYytkV2toSlRXWEZnRW1H?=
 =?utf-8?B?OFlVMS9RRTB1RnFIQUNUcnpyWXV0NmxDazEwVVdPV2s4TUdyL2xsUVRvLzBr?=
 =?utf-8?B?UjhPSUNrWVZVWTVPU2Rzd1M5QXhOZDJ0dFZaRzZ1SmJrdlZ3R3JwTk05VktG?=
 =?utf-8?B?RmdGaDJBK3hwTEk3WUhiY3VvUFI1OUprQW5BVjlnSFYwRTNXaEdDdGdsWjFq?=
 =?utf-8?B?RGpaN1k5NExXdUxnOGVIV1ZRUzZRWUJYVHVaNmd1ZFF6ZVg2UWpJMmdiZTMv?=
 =?utf-8?B?cVdpSDYxeXQ2M1pmRXpZZ29pcUNab1VOeFRYbDlHQkNpZ3g5WDNmS3l5Q3ht?=
 =?utf-8?B?QkY0OGNzRjNvUXhDUER2NFJPcldHS1VpV2VxZ2xFSmJlRUtEVjFNNW1TZGNl?=
 =?utf-8?B?K3pDcmZwVzEzV3VhUURDeC95MEFtLzFnY2pVamF3WWdtVXIwbVRySTZ4akpW?=
 =?utf-8?B?dTVCK0toM0VKLzVITXVaRW9zRVcwUCtRUFVrVnhTdTdJc3pWaTE0NU93cWtD?=
 =?utf-8?B?T0lrZm91ZGhjbDh3WUErVU9qa0ZFZU81WDBQQmRPV21EcktkUmRzTTFLcXd1?=
 =?utf-8?B?T2hMSENubmt1TVI3ZE1qODRjRWdpSFFqNUovSVFIbm1hcjkzamV3dEw1ZmVT?=
 =?utf-8?B?UWNNc3RPWXh5SER5VXRpdDk4Z3hFZkpTbFQ2YXZ2eWVCQ21FOHBBZ2Q2NzRn?=
 =?utf-8?B?NnhaYUgxbkkwK3BVU0NMWk5FQmYzNmVlcnBkOUlpMXhyV2VPRTR3aUp1WGJ1?=
 =?utf-8?B?cUxlQmhjTFRrR2NmdE5EMThrUWNyMVFXSk1KRnFQQlpWYkVxSjVNNE5ZQXE3?=
 =?utf-8?B?UFZCU3Q2dEZXNk5hdnVlbi95Y3ZRUDZUQ0gzSm8ycVI3N1dJUUs4K2M2U2ZR?=
 =?utf-8?B?RTlrNWdLTndWa1NLczJkaytmVGdBTVc5VjJ2WjcxbDJLMmE2bzNSS1U0KzVj?=
 =?utf-8?B?b0VBVzllYWpiRXN3ZXF5cWo4UHVGOE8yQ1Q5d2gwV2FCNDNGTFRnSUVPdUJU?=
 =?utf-8?B?L1FJUndYczdBeFNVNC8xNUxmUHV2VURhSjYzQ25KSmV6SWtsMkZDRVZBdUl2?=
 =?utf-8?B?ZlgvclQ5RTI5L2RwbmpDWFRYakhXL3l5ZHhnNnhjYnMwSUhoUUNsbDFMbUp6?=
 =?utf-8?B?R2VkN1YxaXZYUzZUWHYxNzdSWXZnWUdubEJrK2lxYlV1NEdlQnBmbndJenJG?=
 =?utf-8?B?eDRXSE9JWWJnMVUwcUtNenk3WDlKeE1DaHJBUzYyeEJxd0hWTG5UU0IvNHlq?=
 =?utf-8?B?OTN1MkFIcC8zNmN5eWpmaGswU2dMRDMzTjBROHNldUNTcTQ4UjNnamVlSkNQ?=
 =?utf-8?B?Q1dacmxtVFNoNnFTZTVRUGtzb1JSYXkwbHVPaElZejJ3dmlOOFYwQ2huRkg0?=
 =?utf-8?B?a1RrOWg5bXJnckZLU0ZZUEVYclVYQ0hTSVl5ZEM4QnRZSWVCT3NhSEdPZnlu?=
 =?utf-8?B?d3JsdTZyQlUvTlNRaWo5d052d0J1cHVCZGRqZFcxZ1ZickZxZzJ2UkhLTHJ2?=
 =?utf-8?B?OHpvMTZFN2JKRmR3WWNjV1Q5Q0lrVXRzZlMzTGtOMHBQNDk2UXJVajdZT25S?=
 =?utf-8?B?VTZQMktDYzV4UU9Od2pXLzI5YitVcDV4allpSFBWLy85Ukc1cGxDdG9qYVkw?=
 =?utf-8?B?T1Z2ZzVJaU4yRi8wWjBubGhVOTg1bEdlYVNENFo4aXFYSEQxNTZNWmdmTXcz?=
 =?utf-8?B?T2VkeXR1a2VXRTR2MmV6alVZa1F3T2lhcjVCSjk3NkF4ek9MS0htT1JsOEpP?=
 =?utf-8?B?eGdwSTEvcVRXNnE1ems5VjkyUEZTNFVHUDlmNlN1MjlnYVRqUnozZlVaVHBW?=
 =?utf-8?B?TlJVd0htd1BCWEUwdU5sNnFoaHdLVUx6YzhJMnFJd2l3T1Z5cGs3M2RXZU0v?=
 =?utf-8?B?KzNOSWdTMzY0bCtVeDJTT2tobDJKL3dCTVpuTlNMaUJ2M2h1eUJPdU11cFZJ?=
 =?utf-8?B?VUVRVkVQQVNOT2NmNGhUWnEzbmJsb3F1NVAxZkFueTRZVTRPcTU1VXVWRWpk?=
 =?utf-8?Q?M07dJEMzQMMujm2e9EI8VbjEa?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5039bca-a8db-4b2f-68b5-08ddde75001b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 16:33:45.2039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r789m7W1xG/2eGHpC/G6OhaO3wWlF5Xc7BNHFxSIuXKzbj76BIYzH8H0Vge55JYOWbAstrVJnvKamcnGixwkqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB9109

On 18.08.25 14:26, Florian Bezdeka wrote:
> Hi all,
> 
> when building Xenomai against newer Dovetail/Linux versions build
> warnings like the following occur:
> 
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/xenomai/net/stack/ipv4/rtipv4.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/xenomai/net/stack/ipv4/udp/rtudp.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/xenomai/net/stack/ipv4/tcp/rttcp.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/xenomai/net/stack/packet/rtpacket.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/xenomai/net/stack/rtmac/tdma/tdma.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/xenomai/net/stack/rtmac/rtmac.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/xenomai/net/stack/rtcfg/rtcfg.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/xenomai/udd/xeno_udd.o
> 
> I went through all drivers that had a MODULE_LICENSE() but no
> MODULE_DESCRIPTION() and added the latter.
> 
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Florian Bezdeka (13):
>       drivers/gpio: Add missing MODULE_DESCRIPTION()
>       drivers/testing: Add missing MODULE_DESCRIPTION()
>       drivers/analogy/national_instruments: Add missing MODULE_DESCRIPTION()
>       drivers/net/freescale: Add missing MODULE_DESCRIPTION()
>       drivers/eth1394: Add missing MODULE_DESCRIPTION()
>       drivers/stack/rtmac: Add missing MODULE_DESCRIPTION()
>       drivers/stack/ipv4: Add missing MODULE_DESCRIPTION()
>       drivers/stack/packet: Add missing MODULE_DESCRIPTION()
>       drivers/stack/rtcfg: Add missing MODULE_DESCRIPTION()
>       drivers/net/addons: Add missing MODULE_DESCRIPTION()
>       drivers/can: Add missing MODULE_DESCRIPTION()
>       drivers/spi: Add missing MODULE_DESCRIPTION()
>       drivers/udd: Add missing MODULE_DESCRIPTION()
> 
>  kernel/drivers/analogy/national_instruments/mite.c  | 1 +
>  kernel/drivers/can/rtcan_module.c                   | 1 +
>  kernel/drivers/gpio/gpio-bcm2711.c                  | 1 +
>  kernel/drivers/gpio/gpio-bcm2835.c                  | 2 +-
>  kernel/drivers/gpio/gpio-cherryview.c               | 1 +
>  kernel/drivers/gpio/gpio-mxc.c                      | 1 +
>  kernel/drivers/gpio/gpio-omap.c                     | 1 +
>  kernel/drivers/gpio/gpio-sun8i-h3.c                 | 1 +
>  kernel/drivers/gpio/gpio-xilinx.c                   | 2 +-
>  kernel/drivers/gpio/gpio-zynq7000.c                 | 2 +-
>  kernel/drivers/net/addons/cap.c                     | 1 +
>  kernel/drivers/net/addons/proxy.c                   | 1 +
>  kernel/drivers/net/drivers/eth1394.c                | 1 +
>  kernel/drivers/net/drivers/freescale/fec_main.c     | 1 +
>  kernel/drivers/net/stack/ipv4/af_inet.c             | 1 +
>  kernel/drivers/net/stack/ipv4/tcp/tcp.c             | 1 +
>  kernel/drivers/net/stack/ipv4/udp/udp.c             | 1 +
>  kernel/drivers/net/stack/packet/af_packet.c         | 1 +
>  kernel/drivers/net/stack/rtcfg/rtcfg_module.c       | 1 +
>  kernel/drivers/net/stack/rtmac/nomac/nomac_module.c | 1 +
>  kernel/drivers/net/stack/rtmac/rtmac_module.c       | 1 +
>  kernel/drivers/net/stack/rtmac/tdma/tdma_module.c   | 1 +
>  kernel/drivers/spi/spi-bcm2835.c                    | 1 +
>  kernel/drivers/spi/spi-master.c                     | 1 +
>  kernel/drivers/spi/spi-omap2-mcspi-rt.c             | 1 +
>  kernel/drivers/spi/spi-sun6i.c                      | 1 +
>  kernel/drivers/testing/heapcheck.c                  | 1 +
>  kernel/drivers/udd/udd.c                            | 1 +
>  28 files changed, 28 insertions(+), 3 deletions(-)
> ---
> base-commit: 8569b52053cb766a913d18118f4ede2666a9ae4c
> change-id: 20250812-wip-flo-add-missing-module-descriptions-8ca53e133979
> 
> Best regards,

Thanks, applied with minor text adjustments.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
