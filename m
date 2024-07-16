Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2077.outbound.protection.outlook.com [40.107.20.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9F533987
	for <xenomai@lists.linux.dev>; Tue, 16 Jul 2024 07:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721114314; cv=fail; b=uf31+a3ZU7Hm+Li86EK8UMsLCv5cWVPfODoYKJagIar8gYawFtVOpyFCmny6r25crVY6S4HhUSkFUUAo94TYEOodW0yvj7ZbfnpKIVZRNViydQoCUKQ4zxwTcvI8A6/uHYfSehGOI6/WVz0llAdRAJm95AaX1yu/1AVJX5GHno4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721114314; c=relaxed/simple;
	bh=gnaX+CtNkmpIzQ+/D5erWDDs38H1nf34VRXko88ZVZo=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s9qGnbFT+s9KCWaAJhYu9smsfI02n3Ijh53vkCQ8sy6ElBfFmBGQupJx6n/dwHISXB1amafVJU2Ob5Z3Ry+tCnVksEoK9/4V1rBzxo4CQOjh8279WIwVlisf5sY3FufPd3875hpTKKdElbdPP90DyrpFquYRR7FKNETPiY7NP7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=CdGTwe4L; arc=fail smtp.client-ip=40.107.20.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="CdGTwe4L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mYTblvvESUipN0sXZoQfDABQo/adJd3PyjwPT24h1bvrXbr5be0Q5eVa2qFYd7/HSuh/5bgc0IlSnfb6Vn65JxcUwcVdVw4SASq4Nc1aIH2yoysJc+Ated2vJMY7EHs+SiLlhtUoR9SFKcEt7zg58A0K2POlxt3gTURGdgg8p/EBTL33EOGDtBJZ0JKsg7GW0UgTct5HvNbbYzGG+KWmOIbrWnHQXmtiFLFN3V5i2TyRtlxcEOlx0zUWegclfBzzE2Mcyb6EyanPEQa5DY8JvCnxfMdJfMKVuZweCDwAY46HsqdYr2NIZuctmiouKSNZ7RPdZlxcJ7tzodrcMP2SqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHBlBV0aMnLo7RS4QHJCUARpyS2k4fsHGrqk0Ur4fWo=;
 b=S4epPy4BULQTQRUiCc04dp3Dv8vuah8uYH9nfGyWEAjdLsvIAsRUPq8oZqC8BqGDM5s/b6/ODPTFHFilW9UQOlXO8A/2TNY0vrmbnvaoMCwL83W3IOE9t/eeoh306tGDCfnv7ocRHIozqIGG0FWUMSYFv5DNAYKc4ykzl9ZA28w7gsgqP2hXOq9CkKyypSIqFMOFciaANUMk9h5W2RBzPJTzHDBHpmUBCRGAQS0UaCz3C1iSwdigpjIk4njEPfBSWFyXUMJn/lMgijtnLTowat4Ftf5u/8q/9uGgZV4bD71IEiUqOicK9RVVsnj1ZOrl78BzuYvsl9VxNgkvDGdfeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHBlBV0aMnLo7RS4QHJCUARpyS2k4fsHGrqk0Ur4fWo=;
 b=CdGTwe4LY8+tqpP5vSMsowrGLwUixbbhSdME1FaHJNXAX0IVHlyvPkyExbz46kpqY2XDRaCZ+n/wQVnW0JdtCdGdpKNXrSmJ/TAYFaNCL29h0mXodcUBQ5dg6dg6VvDESbhTjAk0bC3EmvSdpvzMQDdHw03o2QGyC1x9Fhz4o8sAEQ1mvg5tiWhz9FqYfla2QSXIfIddCxijn/t7WZJIjBcu578k4LX/diH+Vo2pYqEEwiLdBrhJPb9aTks8VGCE2k+0icAv2roooRHNwv0DcRerIg+vxK/Pyk+YXLOvDeGzrHyi0k2YLQotBzUOTCgviS0D/r8lcxqRP0nKMFPT5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DBAPR10MB4121.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1b6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 07:18:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 07:18:20 +0000
Message-ID: <e5ff450d-dbe9-4cd2-8c88-bdcc7840dc10@siemens.com>
Date: Tue, 16 Jul 2024 09:18:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [xenomai-images] Ignore name when searching for failures
 in junit report
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
References: <20240712085232.2989424-1-tobias.schaffner@siemens.com>
 <d01917ff-79cb-44f4-b051-e393be802bd1@siemens.com>
 <eca43d81-15d5-4153-b402-b154847b7665@siemens.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <eca43d81-15d5-4153-b402-b154847b7665@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DBAPR10MB4121:EE_
X-MS-Office365-Filtering-Correlation-Id: 601cfccc-46bf-494b-7e9e-08dca56778d1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEFsYUVabWVtSldrN3paNEJUUWFheEEyMk5BSHZ0WFJjOE5lQnhNSXpqQis1?=
 =?utf-8?B?YzZYd2RYMDJkUHEvdGZRbUppOEYrdmVWK2huNmk0U1NKN05TR0h1OTB4Sk9p?=
 =?utf-8?B?ekhhdnFpbE9YaW9yN3VBM2FpeHdnOXlyTnN0Z1V4MGdhL3JVZVJkMFRJUVJD?=
 =?utf-8?B?WEo5RmVVK1hPcXpaKy9YRnpsTUg4NHRLcjZoZVBCWjJoT1EvVFl0aDgvVzBv?=
 =?utf-8?B?K3FRSkpYcVhRMk1pM214N1dTcURGTWR1S20wc2R3YVAyZE5tenU0ZENVbmNz?=
 =?utf-8?B?VXpEMFErM010Y0FsT3d1aU9BOUE3ZEZ5YUVXTy82UlZISFQwa3JFdlBSclYy?=
 =?utf-8?B?aEI4ZFV1VXZMYTJHa2M2VitjeFQ2OGlJR1QzQityRno4bkpUVGVEa2IwR2pF?=
 =?utf-8?B?SndLNDFsV3JUMUZoSVV0ZXJ3Q3p6aWxRSytFa3hVa0xvMTlmVmsybVFOcEJZ?=
 =?utf-8?B?aVIreXJFVTVEajlPeTRuVjFYMXh4NnFWSGpZb25GT2ZLTU1CSEY3Mk5QUWVY?=
 =?utf-8?B?Z2I0azBEMGw0cVR1dWFTVncxUGNTV3ludGlkaWVubk1yQmdEMnVQNnFqVzVH?=
 =?utf-8?B?TUxuZlNMUHpWdGE4Umo3ZlhySDlSRGZONW5tT1E0ZEtxcFMzU0FPcUtpYURQ?=
 =?utf-8?B?eUYvTno5ckI1czR2TElpOFZ4Qk5sWFNvKytLK0lsWkIrU255YUFXdElZVDNt?=
 =?utf-8?B?dE8rSVFoZjR6VVNOZEFtZ1FyRjl3eGFITFU5TEtmSEs5SFM0clp5MWp3Z3dp?=
 =?utf-8?B?N3k3dDVJZ3BlalN4eUlEd3RnUEdVZmhtQlpkWHdzM0NlbmZwQnBYTGMraUNB?=
 =?utf-8?B?aE8rZzd2akFUSVNKVGhhSU51a2RkSDhYZmd1S1NrWHAxWlRFRDl1N1dNMjhh?=
 =?utf-8?B?K20vVng4RHVmaUtENGFZSWpSRGxlSHJXNlR0VUxpRW13akJrY3ByYlpwUFlq?=
 =?utf-8?B?VnpvZ0l2NkhLMEZUb3ZvU0FzeG9wSHovWUgvaDJZMUxBQ0tlTG1UdGhNVG9m?=
 =?utf-8?B?S0x4V01QZjZ6cW81UWNEMFNCTXFTd3ZEOGl5RThoOWY4am5zMW1MUDBQUm1p?=
 =?utf-8?B?Tk01YlYyQ1pFZ2RTclZhNGRBQ2ZkRUFwSXNPMVU4NXFFZk5iSTZ6NzczdXlE?=
 =?utf-8?B?Tkd2WmwyT3NVL1lUL3FsV1pvcDNoTkJRR3c4OUFEdmd4ZlNMV3Fhbmp2ZGxD?=
 =?utf-8?B?WVVLQjZkQWJ1M0hGcTlkUnppMGxQWmgzU3FtRlMxeXFpcXc4Q3lXbGR3b1JT?=
 =?utf-8?B?Zm9QU3hxeCtVMW95NkovQjUzNHNzR1ZQWEZXN0Jhc25hdkdBelBLWXFmb1o4?=
 =?utf-8?B?OWltWDdRU3duSzRqcldPT1Fkb1J2NURscHVCc1ZkMkFNbHRaR1M2MWRqSkZX?=
 =?utf-8?B?VXYvUG9Wb1ZDTmw4YmVlYkwxZEJyMVJIK1R5RnYrNlJEVzc4ZFdqOU9EVmt1?=
 =?utf-8?B?S0R3ZmFmNlBWelhyanpRSGo3OGtLU25RWWluZjhaTGVVSHB0c1hEYXM2bllW?=
 =?utf-8?B?U21zQWMzM0NYeUdWR09UQ01HT1R3Vjk1c1h1ampOY0pWcXI0bmI5dnZMS2hH?=
 =?utf-8?B?L0cxQkc1VnhhMXMzclI1YWw2RWdMY1ZRVEhyQnM0Y2Z0VDdPY09ucWpUQ1hP?=
 =?utf-8?B?SW5sdzY4Y2dVQmZjY2xSM3VrSElyV3FGVTBIZjNTdnlEYm1RUVhNaDVEelZk?=
 =?utf-8?B?UENuRisxN0xxL0VkaTVuWTh1aGVYTDU0a0pIRHBXZ3ROUHp1RkRCM1dlaTlw?=
 =?utf-8?Q?ty/gHAXidmTqHzn9i4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFA1R3lFTkcycVk1Lzh5S0xOZEkxQURxeHRQaVFzM2dZNXR5M1UrSkVFMGpD?=
 =?utf-8?B?MFk4RFp2ZVZWdVozemVSeEV2U1liNFBDdEVVUE5CeGFYWkZaM1FydlU2cjYr?=
 =?utf-8?B?dVRSRVVCQ1llZGQxRExEYUd1TTB4MUFRemV4UEh6ejljSmRkWVpFRjZHSUow?=
 =?utf-8?B?TVZyUXZYMmRRVmpFaHExNFltSXQvS0tCaFhMazhoNUJXUUZuaHlZWnh6Y01o?=
 =?utf-8?B?QURKQ1Q3dmR1eXZqU2dWMkRncmZBT2RtRlk2MWhJTkZLdGdyNlIvVXNSOGNV?=
 =?utf-8?B?MFVlUFVXbjg4R001VVlIajlkblU3TzFxZE1HRzVIcnBndU00UHpNUDlDb0Rx?=
 =?utf-8?B?RXNvMlFGa1NpUVBrbjNUb3FBeUJNVU1wdHRkbDVTT3NBNVBNczhHYllyVTdk?=
 =?utf-8?B?U2Z5MnI1UGV1U3JlUGh3SFVpeTlOc3c1My9RRnpVV2ZMaWhPNEhHcHZvZDhZ?=
 =?utf-8?B?a3VZTEFXMzVXcE1nVGd6aWg0WFhCRFpUWHdFRVR3WnIvVTgzdDNlM1FrWU9T?=
 =?utf-8?B?OUh2bmdYWERPV0xmb1E3OUtTTnhMTjcrSFMzai91b1lOS3VabmR1L1RVd0hN?=
 =?utf-8?B?czYxVktSQjduaGVyZWI4OWhDcGNXVitsaVpZVi95SE1RSDN1cEtibzcwZTVh?=
 =?utf-8?B?T084a3VXWFRFNEo4N0hGSGhXNUdyWFRoS0JOdzVkYmE2MHRmV0tSZG5uakdz?=
 =?utf-8?B?VUxFZDBvZVVJMVBDQkdINjRHZ0QzYTR2K3pOclJNWmlzVzF6MlN6S2hVWDQy?=
 =?utf-8?B?dEptc0w0Wkd5YWp5QW9nN1MwbVRWemdOSE5GMUE0RW1CWTVtZlJrZ0Ywb3Jo?=
 =?utf-8?B?THQ0MnpmRUlnWUJGKzRsQTlMUmtaUEE0MUZ6dFp4Zm5pOVVnQ0FoZEU5emtS?=
 =?utf-8?B?OGFzYzN2dHVjOFVwQ0RqYkZLOGRVOElZRUdTSjMrcDlzcGwzTlZKcUJkNGh2?=
 =?utf-8?B?V21jdUFPd3l1ZWRPekJ5ZEVGZ0NUam4zMnRPTWdKdnVXbkFvVkx1MWxWMGs5?=
 =?utf-8?B?aEJNOG14NnVTK1IwVUMwTTRmUEhWWER2VDF2WURvcGRCekhUNVM3K09sNER2?=
 =?utf-8?B?RGp4QVM1RE5wU3h4UHdpTG1uV1Jnamg3R09FMDBEeEhrSVdaQXlsVWNZaFlI?=
 =?utf-8?B?NHB2Zjl0UWg2a3VnZDlIV1JkYWJ3T2loR2FVTFg1Syt2SU1lQ3lMYUEvNWtv?=
 =?utf-8?B?ekdrbUJHOXVOVzd3ZE9TbkNkQXJnb0Q4Z1JSMWZ1Tmg1UFRGME9ZdVVkMC80?=
 =?utf-8?B?cnppRDlCOEw3MUg3THFZNnVkdHFsd29WcURTWllsbndwNUFkQnlyTXN1dVli?=
 =?utf-8?B?dFlMcGIvWTVwT1l4ditMb0FjdWNqeUNaeEpYSTlWRW53ZC9JTWxNbHVReTUz?=
 =?utf-8?B?NVBrSUZTRHNZdy9WWTlOOStyMU5zVGgxUEladmVsUWo5NzNINnl2a2RTL3FY?=
 =?utf-8?B?YVNQR3RZcVFoN1dKUkZ4UEdtWVA1K2hBYWwvdVlLSGNEekk0R3ZhQ0R3dURr?=
 =?utf-8?B?VVBlTlhhV3YvbUJhcWptTG9JWVltN2N5STRnYTJORndLWE9yRFdtMys5Q1dT?=
 =?utf-8?B?aE1Yc25LWUJlOURtK2JRV2tsYVBxWHNXeitlbTlxRUJ5bFBwZG9iT1JmdERu?=
 =?utf-8?B?OCtGZFN1bFVGYzA2aE1FQjJuTzRHOG9iWkFtL2lhaDl0bGpjVmpTSG1qYmk5?=
 =?utf-8?B?UDQxTUtFQ2xxbUlqUURwL2kweVF1N01NZ2wyY21ReUsveEpGTG43YTFUcU9D?=
 =?utf-8?B?cjBTRWppay9pNGc2QURsSUVwdmZHZWhuK2ZXTUNXNTMzUHRVeWFXb29OdUFk?=
 =?utf-8?B?S0JQQ2cybm16ak1QYmtDTTlOTUJEWE9acWVadzB5emJVM0J3aDl1ZG5Vbi9L?=
 =?utf-8?B?cmFhMVlzQkZjRVVEU2Z3TFMzd0RYaXl4d1R1VmhTbTV2RVQ2VnorblgyOHVh?=
 =?utf-8?B?ZUdackVwVmcvUG5HVWhEWnQyajUxQVArTUw5dmwvNHhsdTNqamRqaGRXL1N0?=
 =?utf-8?B?dWNYZDRhOGk5cnlmc2FQdHRaRWdKbVZTdDdpdHVZK2JpWHhpd1FYMzFUYTNQ?=
 =?utf-8?B?Ylo5Q0FXYUJtVGZObG5LOE1malE0NFpUbzBLcEgyWUVYZS9JdmlKMk1GRGZR?=
 =?utf-8?Q?Cx06bp5VyD0D/hXdndvsHI7kN?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 601cfccc-46bf-494b-7e9e-08dca56778d1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 07:18:20.8016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tT99sST2R9ZDWYe/V+UXIi2JEtvOxGqwdVE4CW8lzc7jqIb9bjkQjY9WHUsn5S3tKySttEFaukN8bhSEyMN0aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4121

On 16.07.24 07:57, Tobias Schaffner wrote:
> Hi Jan,
> 
> On 12.07.24 11:01, Jan Kiszka wrote:
>> On 12.07.24 10:52, Tobias Schaffner wrote:
>>> We only search for failed test-cases that have the name job. This is not
>>> correct. E.g. the xeno-test result will have the name "xeno-test".
>>>
>>> Fail if there is any failed testcase found in the junit xml report.
>>>
>>
>> https://source.denx.de/Xenomai/xenomai-images/-/commit/22db8c107109eef90bc5f93baa5a38c2e7f50f5c
>>
>> If you find a case where a test failed and that did not leads to a job
>> failure, please let us know. But that should likely be addressed in the
>> LAVA tests then.
> 
> If the shell command in a lava-test-case call fails this will not make
> the action fail but create an report entry with the given test-case-name.
> 
> Therefore a run with a failed xeno-test command will look like this:
> Results:
> * 0_xenomai-test-suite.xenomai-test [fail]
> * lava.job [pass]
> * lava.power-off [pass]
> * lava.0_xenomai-test-suite [pass]
> * lava.login-action [pass]
> * lava.kernel-messages [pass]
> [...]
> 
> We could make the whole action fail by not using lava-test-case but this
> would still not make the job fail.
> 
> * lava.job [pass]
> * lava.power-off [pass]
> * lava.0_xenomai-test-suite [fail]
> * lava.login-action [pass]
> * lava.kernel-messages [pass]
> [...]
> 
> Any input why and how this should make the job fail?

It seems it needs a "lava-test-raise" to make the overall job fail. This
is what we do over in isar-cip-core but not here. Lava docs are unclear
on how to evaluate test results - seems they pushed that away. Fact is
that we either need a much more sophisticated evaluation or consistent
job error raising to use the new scheme.

> 
> Do we have an example of a report with an failed entry after a retry? A
> successful retry should not lead to a failed result to my current
> understanding.

https://source.denx.de/Xenomai/xenomai-images/-/jobs/861463

Jan

