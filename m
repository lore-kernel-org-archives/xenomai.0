Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011012.outbound.protection.outlook.com [40.107.130.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8D8204096
	for <xenomai@lists.linux.dev>; Tue,  8 Jul 2025 18:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752000342; cv=fail; b=PkkSwEBYcQUUAAuQems0O0unjoNZ97BNPnWb8fOBaluL0IZdV1mEtQsLb52HXfHIWUFVezC5KN+HHdI5j2ftJjuN8fJjeN8d8MSxe/Ww2l/ga7vlfBbTNjJGkv3Q2QZ4cf0Yr3CbKqZH3KFoAoppTVBur3O4MWi1OL4tN8EhnOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752000342; c=relaxed/simple;
	bh=77GroBsYMiUuusB5hfsqjNT9v3Ols92iz60aSMk2EeA=;
	h=Message-ID:Date:From:Subject:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CAg8KoNoQBSBJhulHnVPLL03sPjnDkgjzoJUC37eK+x7/EHWK5eDgiNNVVLZ5nOzGZFGi5UTzdzuvvHpLXCt8+2C1BrrL3OD6iCA7SGjR90z+boFR0ZoNxEo6422sM3CXDpjhfWSMKd2ntbZdrSDszaAzXSbmOve9BcDEez7O/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=eY+OZqbz; arc=fail smtp.client-ip=40.107.130.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="eY+OZqbz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HSp2bNDRjxGsOhvkd9glSTpmlrQtJWat7XkoTEArNpQ/0r/vcC5+5Nfy1stc0MOdWlP6SR4eZ29fNs9+R/uLt/ncB/ZJftvvhQ5illcZTk17HjTVMMFAYrTi4iA3mupMz54/yDfxmvqsukMZlayz36MGPXXpFG4kB5ci4P7m7p3GgsJNe11mx+JpQ4AwfZ6dLt8POergow0QOyZzGtrYeTckk0htG0OX+G1TYGgIChnCmPAAIZOGenZJgjiJ2LZWyt+zwB1LNJjVRZiLNfsO/J1d3HW7h29Dq3mUvz9orql1rTHBmgYqlqhrglHTDt6rWa73iFOySTMnIdwI883SXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5jDSc1cwve5AEtoT+G9SEQHz8ozA0zeuqJIDYHmIOI=;
 b=srtADpTRTpBck9mOVKO2wsUccn+N1Ag2g60dshCebqOgu3ZHeYNQN644qEiLaVF90t9KBP5Fp7deGfp4tqdT9jE0gdioXWxDRwz8HflCpQJXwsEy5dAhpUwYWPERgnZGVJRTnLwLx3COxTbHTeMdLtOoZ4GklBgRvSTGxN6XjONoNj89TEO/DvYwX7F6KXwUzzNQjceKdk7BcxPcii4eYqvX0GZK1L1TYuhL+L7PfvcL+7ASGEnAb7hiPtnmTfIK9RUyUGf3FIQOVpQIBEm1p2Nu1oPIMJMFD9VxIXMwq/+OYA3Gr7ZSU3SFC7Ih3GUJlmx8oLZ07FoA8r9Is+Na2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5jDSc1cwve5AEtoT+G9SEQHz8ozA0zeuqJIDYHmIOI=;
 b=eY+OZqbzaBtQTRuSGgSDj2yQcPD7RRiKJ3BkX55ySlFwQD9tPyeffO9Bq7FovkmTx57JHcCfslP5rsp4XFNFvrGNG6vsEWsZXyN/9oCS+i7j9tjLywObN+uSv+VKoVEWx/KlG73Vw2vJN/1ZroNQ1Z2HeMWbFMdTwEw8/RLRH2HNprDMQH+V1XuyQBnVYztTy5nlgACr2kGVDW/4sz0QHEcyBg38xxEu6xzivLE8TmEj/M1iWWw3FF2pfD8ZnoVq3hsp25M9WUyyO+pcOksVFJkI8eCYWvg9csFT7BEB4roCeG0emPFaqDyJWtKI5bpdzE5DjTrZkOG2/+9xUzUmOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB6790.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2ff::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Tue, 8 Jul
 2025 18:45:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 18:45:37 +0000
Message-ID: <61cf30b0-30af-4ff7-8c3a-4ba62624d74a@siemens.com>
Date: Tue, 8 Jul 2025 20:45:36 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Xenomai community call on Wednesday, July 8, 2025, UTC 7:30 AM
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <PH7PR11MB7499F7DDE006A3A7291F61FAF27B2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499D816A0B79C85EF7CD712F2D62@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499161719AD2EC0D1651C48F2A42@PH7PR11MB7499.namprd11.prod.outlook.com>
 <DS0PR11MB7482106CBDA92B4A595D7363F2AA2@DS0PR11MB7482.namprd11.prod.outlook.com>
 <PH7PR11MB7499B238FF2BECBDD784752AF2B82@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749988D39A66B3EC8E9431E6F28E2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499BDD1032C1C09D4107EE7F29C2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499E15D2AD5555818A6E5C4F2462@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74993258CAA8CDDA598B287DF2542@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499E32BB1968236810DF6B3F25A2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74993347DB8F72364025EFEBF2282@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499E7C229D3943554AE31B6F23E2@PH7PR11MB7499.namprd11.prod.outlook.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <PH7PR11MB7499E7C229D3943554AE31B6F23E2@PH7PR11MB7499.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0311.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB6790:EE_
X-MS-Office365-Filtering-Correlation-Id: 43b43029-2306-4f7d-2054-08ddbe4fa13f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WnZOOEJVaGRXdDZFNTJzMjRrUHpUbjBFSC9UcHU0VTk3Y0NVMTRHT25PRi9q?=
 =?utf-8?B?WmFobWU3M0k0TzF0TGN4eW5lS3pJRHR5M2U1aVFxK3hUWWtIZFN2QVZ2MHdO?=
 =?utf-8?B?ZzFkRFdIc2hKOHQ3ckpWU0FCK2xFSElLQ0V6Q2pkV3JsWjA5dU5aRWdPU0ow?=
 =?utf-8?B?SXdERjZndVovYUh4MTdoeFRlZWJ4OWxBZUxiczBSVWZuZkYvd21sQVFNRlpa?=
 =?utf-8?B?ZVhlS2lQUDNHYnpicG9SQmN3b3JPTFB3QnFVV3JYWkZWTzhWTVNJOTFvdXlu?=
 =?utf-8?B?SW1Eb1FYQS9SSWJabFNDUDJudUFFdjlhTTk2MFRpYTJrb3puWE1hWXFNbEsv?=
 =?utf-8?B?aUVpQ3M0L2NFa2UxdXMyRFZsd0w1OUF0WkM4U0VXNSsyVHNJZHc2bmY5VkRa?=
 =?utf-8?B?c1pQOW9XMXNIM3JuYU1qUCtldUgyY1JwWU5CTEU2Z0g1TFNnQkk3cHpiV2p0?=
 =?utf-8?B?Nll5SC92YlRma2Y0R2orWEZYNC9yZEpReTJFODM3c04yazdGSm5ndDl2M1Z1?=
 =?utf-8?B?Z2tnekE5MStmeHZ6Rjd4TlpMV3FkbDVIbFcvcEpsK3lkcWpuWEhqZWt3ekVM?=
 =?utf-8?B?a2hiREpobHQxV1NZcWZZNWMyb3R4c2FWQ0NYMU5NZ2dsMi9aaWI2cUdLWnZj?=
 =?utf-8?B?cm50SElma0ljdzZudm4xVlBpRUZWNVJhZ3ppVVNIWVd1WkRPd0M0d2Y4NzFz?=
 =?utf-8?B?RmFXTTFpNUY4NnhTaVpWdGFOS1Q2WnZHQUU2cSt1bFpXelQvcG5kWU1tNUoz?=
 =?utf-8?B?V1BmOXZsdk0yS2hvVHhXUzFEVFhFZ3JPaDhNemhHZTU1dnU2elZXQ1AvSlNO?=
 =?utf-8?B?Q3lmQW53ek9HZUZ4RmJ4SzYrVlZPcUdyajhicEoySzU4QU45eUFsdks0bmcw?=
 =?utf-8?B?TVZCY0s4bGJpRFhYZThGSzRKZXJ1NFZTbkIwdEF5TnBieEZZUi92S2YzV3VT?=
 =?utf-8?B?S0ZheGVyWWREdDRmbXpLd2pPRDRtWFFMVytmRTdVRVZSY2VqR3BUT2RRdVli?=
 =?utf-8?B?dHJ5MVA4TXo4ci9OazVFbVdwRVFBTTR0c0wzRHJpd0lqYXlVRHRkWXIrQlp5?=
 =?utf-8?B?UkFFd2V2NnllVCtwdFdOdlpMMkJramdOMUJWVmorRUR3YW1xYnRIWXViYW1E?=
 =?utf-8?B?b3JiMmpHQXEwUjhPa0xjSGtudUh3cDR6TkFpUnREMGtuSkVIVU5rOGtYbU1j?=
 =?utf-8?B?Rk5HaktkbGVvWjVQR3hsSWNYRXIxYys2SzRHUUlZS2IrdllYK3AvQklnblJ6?=
 =?utf-8?B?V0lFQlpTVzJYSEIzT2hDdkhEYVV3RjJQcTNOdVZUdjltbW5nUHZDN0tPbW1R?=
 =?utf-8?B?VXBiTWFhSjN6RHlWWVRWY2lDRWNiOVRHRFpjVXlBVG5wNEIvYlBtZnEvVkhk?=
 =?utf-8?B?aU9LNVllVmJtT21qZG5aYmt3QXZLRnE4Q1VhenpsMUlVa01GblR2OWVRSVg3?=
 =?utf-8?B?MzZuclN0TW0wbjBkRlprWG5Qc3Fzb1EvMWFxdkxkMkZiakRGYnFFbFl1MG00?=
 =?utf-8?B?VDRIOU10bmM1THhoZnRaV2xJYTZXSFd3VGw5MkRtUHI1WWRzOENhMDZlZCtr?=
 =?utf-8?B?K2daUE9kRnVIS0wxdy9XYVFoRmVIZFdHbnNSb0lKZ1JXc2c5dk1SVGp0T2s1?=
 =?utf-8?B?eENnd1NGa0JERUhCNFBJT2dFcEZFNDZQcURIblJBYWRlUnluOHduQzJkZXhy?=
 =?utf-8?B?VFRWT2FHL1UyNllRaG9HeStEeWFFRXZwTVJLbkw1ZUV4dkZEQlJEajhTaFFm?=
 =?utf-8?B?UGk1a0JtZHpLR2lJRFdFZDZGdXNwT0pVMkNRWkxCd2MxTFBMQ1JWQVJiSUJu?=
 =?utf-8?B?OXZUQjZENHRjWlhGVGRrVVdIT2FqYm9USTRSQkRvMmI3ak9zSWl5dmtEWU9o?=
 =?utf-8?B?ZUpoWEU0ZEtva05MMjJKTmRWLy9CK1dTa0VWK29DZnJiZ0hsalJxNEdOSEFS?=
 =?utf-8?Q?jShqAP+3TDU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHlmeEN2d3FVdEU1YVpmQXoyVWdoT0NrUGZDK3FpSElpajF2aXNCK25SWDlO?=
 =?utf-8?B?MVNKUEUxdys4anhGc0VTTFdmK1JPcXFWS1ZOazJGeXZFNENqdGJXQnZvdHlJ?=
 =?utf-8?B?MG5jWlgyTFR0ZXMyeUcvRm50cDc2MUdJL3lhZVBUTE5jZUV0WW5sdFozbkty?=
 =?utf-8?B?eG95RlNJeHNkWTlHZzN0RXg3OEdNZHo0SHFvakM5bUpRcEtBK3FuZWIvRmZa?=
 =?utf-8?B?elZXWnBYRC8vS295a1VFb2ptKzgzcGxGNzhXM20wVDRpWTduT0JPR1ZjZk9W?=
 =?utf-8?B?SW56VXMzZ3p1VzhRSDhGbmYwRU9kT2gvb2lWTEpYcWY5MWV5bUJxQ01ZdFBE?=
 =?utf-8?B?TGpzSnRHNE90WXNkWmcwWFQ5aFd6NlkxeEROY29KdXZ1eHUwRWNVdkhkcURX?=
 =?utf-8?B?SHBnQ2NFaCtyV0pPZjI3cytqOXpnSGhDQTRNUTFpMzZ3Ukx0OVpJUjJaVEd0?=
 =?utf-8?B?OVBoZHRpVzk5djJ4R3NidkhTdVFGWmxIdS96T0kxcEJtV2pYSFA2NDZpcnpr?=
 =?utf-8?B?RW9rU1ViOURpYmFja2x2UTI3bzBDdTVMOG1vMVhoeVdpaVVGbitzM1E4cDFI?=
 =?utf-8?B?cWljdXVFbWZvTFkyZnBLQjZNOUNVY2g4UUxhS21FaEZ2OEdhc0NtRy8wdmo1?=
 =?utf-8?B?OGNpbndlV0FsL1Y2MHEvVnRRUmQ0WkRQQmw5d1R0S3BScEIrVmw5SkRUTTJB?=
 =?utf-8?B?cUNVTUUrMzhPZkRCeUMyVDZnMGtHSmhRRVdaRnBZMlloLzZuNTRLRTdmWjIy?=
 =?utf-8?B?QzVSZld1clRwd21Wek5aUDhlQ3pBaTA4Q01ZYTFORnY2YnM2NUd6RHByVkxo?=
 =?utf-8?B?QklxS2N5N25pYmdudGs5YkYrdWRHUGNiOWxGN3pHSmx1ekxnQTAxdEhEclBu?=
 =?utf-8?B?alR1UU82TVgxMlR5M0JudWdmR0xPSUp3ODl2WlRWbjlsTkdFSERocEw2UXNy?=
 =?utf-8?B?UTRKdTV0azdSQ1JCR2hmQVpkSzNtb050VCt3UUZySFhFNDREOVRUYkYvRWZu?=
 =?utf-8?B?QTE5Ulp2STdudXZtZ3BFZktOUHowbU4zcVhFM3BvV0VycmtGaFVCQUkyekFY?=
 =?utf-8?B?Y1dnMlVuaEI0L05wT1V1ejRFaEdEdzc2NGwwYWtKRm5iazg5a29VdVM3MnRY?=
 =?utf-8?B?ak82NGhWT2x6TEtSSE5ORkltMGlvdWRmUWh0dTdHN2JiVllSZjhXRGNWSHdP?=
 =?utf-8?B?SzdFMG5pazRTYWRQNlBCVEdESzFiZ1kwdmxTVjJsZE4rWHRaUERaaXFuNmJa?=
 =?utf-8?B?NE92bHU3TFpNL2pEKzJHemZ6UTBjUVBrUUxqaUVRYnB6WS85TVY2UTh5V3Ur?=
 =?utf-8?B?L3lhOXFQUCtvc0VGZDd4S05TY3QyUDdIdGsxbGQ0UXAzenJzVXpUZHBBejBl?=
 =?utf-8?B?eXNDZ01GWTY1TW1pdURsajhGVnUvc3prTkFSN1FHL2R2Qk95Q0JxdjlxK1Bl?=
 =?utf-8?B?UzZaZi8wZEF3SUg2YU9EV1htVlc5WXhPSHJkalZtY0tPZnAzWlJpSDZkUVY2?=
 =?utf-8?B?Zm5sTVZFKy83bFdrSXMvWjVXcHFITnpEemJVUTlBNmxDVlZlY1k1blhhdm9z?=
 =?utf-8?B?R0NaMDZ6eTJGWXZEdmE1V1RHNzBCUzdCV08vdTg5bnVqUnhQaUh5MUFCM29F?=
 =?utf-8?B?UUhNUXdxRE9STXR3WWJiTGExSTJ2UHBwbHJZM3ZDN3ZuWm1UL1IwbkMyQzJF?=
 =?utf-8?B?RTEwMVBMcmhXUHQwSFNTWFVWbE15MGpxaGVwQktaL1lncDhWaVRDS25qZDRk?=
 =?utf-8?B?Uzg4TVZVTEtSa0UzcFhGZE9EYk5va1pML1lpNWczMnk2QUk1bW1vSDBVM1Q3?=
 =?utf-8?B?OE16cTRiNGQ3bW9uWU5OdWxJOXlXZitoR3k1V2N2R21EUXFoWDI5cEh0VDhU?=
 =?utf-8?B?MkdkWmg3VG0rUHZWMHdTUTV0WmxFbkFFazB0UXQwTEFyU2xkbFN2ZDMzeHdk?=
 =?utf-8?B?cEh2U2N2U3l2cVIwNEh6ei9QWVZZWDZqemR4cXpYdFZGanNvazl4L0hDcklu?=
 =?utf-8?B?cUdhL2ViL3pvUnlTVjFSNlVIRkNVSGpYMGVTajVrOEJaTzZHVFpOM3ludkg4?=
 =?utf-8?B?Q0t2Q2pXU28wQmt6cHlJU1lBRE1ZSThTdnl3K1lhNzhNZ2V0SFk1N1VZSzgv?=
 =?utf-8?B?cGswaHBaSDF3T0N0blBIQmU3ZEUzNHhIUXhjRDRXay91ZkxZQ2VwdFFrSzZ3?=
 =?utf-8?B?WGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43b43029-2306-4f7d-2054-08ddbe4fa13f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 18:45:37.5351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RFB21rqPdvMBDztd8x6mjSbx8+H/ItinK3b6cOOzipId57kchqCPHv2N9RkORlwE1KQH8QU/HOnXPYEDgm9reg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6790

Topics may include but are not limited to upstream/downstream project 
plans, status updates, and technical discussions. It's an open online 
meeting that anyone can join and ask questions (you may have to wait for 
the organizer to let you in).

Time:
Wednesday, July 8, 2025, UTC 7:30 AM
Paris, France CEST 9:30 AM
China CST 3:30 PM

Join Teams Meeting:
https://teams.microsoft.com/l/meetup-join/19%3ameeting_NmQ4NjFlZmItZmE1NS00MzZjLTk3OWMtNzc3N2Q0N2Y2MzM4%40thread.v2/0?context=%7b%22Tid%22%3a%2238ae3bcd-9579-4fd4-adda-b42e1495d55a%22%2c%22Oid%22%3a%22058073ef-2de1-450d-b434-70a67389dcfa%22%7d

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
