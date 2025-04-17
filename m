Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010052.outbound.protection.outlook.com [52.101.69.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C723D33FD
	for <xenomai@lists.linux.dev>; Thu, 17 Apr 2025 08:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744880364; cv=fail; b=I82Jsqylo+C31GdCO392KzyeLDFfaxxcSp8GjNZfg+D7SaSP0o+O60wU7ZnQyr5AuoeoGVAxcVYWlcNIzTqq3sdOblivQkbpjb2AladlC//SSHgkhROc6X12Ur1RNq9HaHrjF5fKpsSl1ulZWk/5LYXxIGJ+czdX+6ELSn8Mfxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744880364; c=relaxed/simple;
	bh=TfjPMauXdeTnkVSRfO71dS9xdCsz6J0Zu8cdFDbY7EI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bZBdxVxr15s9K1p5BxU6ZI6uWYDKcXugyy5MO+jTZ+mMzRl5RC7e4TWeSXi5MRqYFDUE8rWWiff7gAAGyINow9zvS4tvl30SK6VaecvQqqmUa4JxTB0vj+D8n4ExLIL2U7eW23+XI9M4sD2RNs6heR9XcU4pCoBMbrpFh1MJ/Rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=K5Vpo8+M; arc=fail smtp.client-ip=52.101.69.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="K5Vpo8+M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EIVSMGQeRq2PI3eBczmf6Xe7ebBEg4neFeTfVJfT/qnAPU7zXmaL6R+oBxHw+Ov4omkoTBq5eujWtWcX9mDxbsjVVccqVQ2I/eErV6vvog+wUHFZaLuMIePgDcpl8iuVRIV1TiBS+oMxmSyGOWwc4fvVR0M70uvqmvpN/fDjdqiKZYSmGUI4BbSBM5YjoSFSuu8oNAVkXv4sLTBSak4eWT/eQ03Bdrohb5QzyRh0Hp0LwvsDAtuhpH8Ve8C2Urxe9s8B1jnK0khGzzUDz9Nhts3Yz2mBtxUmR+I9TP1O/1jeqsnORha6qtZ7a5TcPmk0kXKWm6/XTMgl8gDKm8bi9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3rWHE1NPtj+zFjXz6zFvkuS2GuXTV6oejmi6PddmdU=;
 b=pk8D6IXLLf3Yrj4e6nDJp4Fw6MxPEezd8lVWPP0i+iZ84PXDMgM+MQPX5TqSriXMr3GcQjFgaJxUUpIq8BxiDIHuyDKAMMvIhvlodoB2pTDJDnFqILo3rceK06TXAVEWSz6rsbCHCEpUpHO/mwB54Zo7Ss/wT3ob+t4HWQ5K9Aux0s0Klp/n3wz1mqt0JPNJ2e5UTjhEl/uXlqhYfIU7IfB4ktw3iHlfRfzcsulJY+4EMab1gLY4cRtNp5Ad2u+fKLkcK8BrurBMtqGpGlj666+gBqkJRXZgHRA2Kuc9WuN8CTnXw8v0WDy5N99ZAScsGmAKOIjxFzszzluyKPJlNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3rWHE1NPtj+zFjXz6zFvkuS2GuXTV6oejmi6PddmdU=;
 b=K5Vpo8+MJrT9vuP0j5TdOraWls/2VyFr+sUN/GaeGDrkMuRyxa4y6OYvmrytBbM62MSy0+olqrt98hlLg2fMgJ3lB/aIFW2MH0h1Ia7yOCAzlE6z+xlT4MTjflgxE5uTbjVKC/Xxyatf459exG9Hrw4EFsrZpuxhAwbyrLIPXdnSYChdv2eIPNoDrsIq3EM3/2CzWimVa+R0ue11F3ETM4KJy+8Av3LAY7HB56wpAfMKlkqA82JJ80C6KkN1g7DO4E0DdwDtqoByShYCEQ6ctlAkIm7FUBPuDj5dO8tboo7vbBQqxEFb22sZMW2ex+t7htAJe/kN0I5YAR3GRgDuqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5220.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:348::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Thu, 17 Apr
 2025 08:59:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 08:59:18 +0000
Message-ID: <370f022e-d5e3-46f1-a19f-5448afeebb61@siemens.com>
Date: Thu, 17 Apr 2025 10:59:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Build error of kernel/xenomai/debug.c
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 "Qiao, Wei" <wei.qiao@intel.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Cc: "Chen, Hongzhan" <hongzhan.chen@intel.com>,
 "Pirou, Florent" <florent.pirou@intel.com>
References: <IA1PR11MB6513EB0131E06C8CC865E8EF8CBC2@IA1PR11MB6513.namprd11.prod.outlook.com>
 <72c2c5cb18b635f1145c35b6592c661cf55aeb0f.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <72c2c5cb18b635f1145c35b6592c661cf55aeb0f.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0390.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5220:EE_
X-MS-Office365-Filtering-Correlation-Id: 860106a7-8c50-40a3-887f-08dd7d8e231e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dEgzaHRmZ0NHSFlzRWJjQ0tqUjhmQkMyWU1jZDd3UkVyejVYa0dFVVA2RllE?=
 =?utf-8?B?cDZwVlF4Yk9Lck1TRzVYd0dPWFlyUmVMM2themJQVENGb25jbkNXZExxMEwy?=
 =?utf-8?B?bUZOV1c3N0VhQ21EcnltUitleDlqSlVvUjhjOXcrRENnOFcwWG5Mb3VFWWwz?=
 =?utf-8?B?YzRqc2tlZEVUK0ZIZWI4bnVaTmNhU21Jc284SnNDNjBJd3QxS2d4SkoxMU1a?=
 =?utf-8?B?L290ZWt0c21NSzc2TmRud0lmMmtPZ2l4cGQzN3JaOEZCQkUwT3VLY1EySnEr?=
 =?utf-8?B?dURGY1pRTVlZZFJzbU05cWJ0ckJWM3VNUFRvaXRlYkVXSUV5QUhNWXlCWS93?=
 =?utf-8?B?SGYzdFFxVDdyRWFyZ3NZT3dEUEhTdVRzb2ZLZ211UTNBYlVtOHhHbHJOU1BQ?=
 =?utf-8?B?eDlJZHh2NC83TjVlRVpCbEh3ekIvRjh0RWNzVlZUSHdYb1FMZmdJZ2YzVTVP?=
 =?utf-8?B?RmYxRE1uWXRWSDNXTUxlSElDUk0xZDB5anA1L1lDMlhKWXVBQTJTNDRnbkJX?=
 =?utf-8?B?V1UrZE9laGdMSmdoZk5xTFgzVzRXdDcxUG5xVW91UXBPRldoMDdnVGFXRXk3?=
 =?utf-8?B?MGlEcFc1eUlGdkFWN2UzRHFSTjk5SnBZSFNJdHplQm5IdHZmL1lrZlN2N2Vz?=
 =?utf-8?B?VFlzbWFoQWJhSjZTYlRhK3dpbnpnRXUyUTNXNGhKZ2NNNjZkdkVyOTkxVWhD?=
 =?utf-8?B?UHZwbzNZendaRW1yZFNzcXpZK3IrbXIyVjh6djU5d3FvL2pBcDZ2WHhQRjBQ?=
 =?utf-8?B?YXowdEY1SDRYc3p6K01rMUhIOWtWYkVSNGZYVE1vKzU1VS9OQTJZbVNmNUxp?=
 =?utf-8?B?V2tBdEN0RVNrY1FNSmpCR0NROHVmbUhLMXFQU2xEdjVKWVZUUHVDUzVLSHgz?=
 =?utf-8?B?Vi9oVlJJZXprQzY2V3pCZHI0eTNxeVVCbXYvd3pCME9zc21DYVQ4aEVlOXNE?=
 =?utf-8?B?bFc1Q1BoWWs5dDBPeHRvcFd0cFNYRVJxWEhNcGNMUHJTNFV5a3hYR3BtWG5W?=
 =?utf-8?B?MUlQTENKeHZxL2xPQTdzNzFpZVU0MWtCS3ZvN3FxeUJIZFd3MmtBUDVsZUhX?=
 =?utf-8?B?ZVFnM2JaK0U5djQwOHphZC9aZFFrMDRyZVdOL2Evd3dsNnJQaWR4RFdGUlZO?=
 =?utf-8?B?c2w3d0k1bW9FZVVNSTRwcVhzeUtTZzd0NS9YWU9CU2pFcENNeTZkUjFxYWJi?=
 =?utf-8?B?dkNIVmNzcXJ3SU5QWGhETFN0bHdxRlVlYllhc0d6Si9zTGdENFNkM0lONDVv?=
 =?utf-8?B?WWN0T3J2Q2VWZXJmM1VaS3ZBNEFVQ2RWRUFNRDZPRUpYRHkycVFZR0JvM1VM?=
 =?utf-8?B?Z0E1TFJJUWwwZU13WFR6bkZ5SU83Rm14c0phUXcySkEydkxrc3FKN09hL3ox?=
 =?utf-8?B?Z05ERGdBbjFGU1UwV2FjTit2ekdKQXMyaEkxdWFKY2o5U3VmanpJM0ZWT0xW?=
 =?utf-8?B?aXN6dm1SbnBISno2SzZjZCtURkI2SGtNSjZpNldLaFBFNDZaRWVGWTB5clVu?=
 =?utf-8?B?UFhsUEwvSWQ3SHJoVjk0bG5oUWNGUmxtQWtFbFZZNEZsaTFoOVV5MjY1WHZT?=
 =?utf-8?B?ZlBaVnNoRGdMWVZLczZGRFVaMGlVL0wrV0pFK1psbFNENlpITG1jbjhJVU1z?=
 =?utf-8?B?TDV2eFVQMEVMRGRzNFFmdHNVa0VheW1FS2ZwS1F0MjlabW5LYWRuTFJTcWZu?=
 =?utf-8?B?UEtZMEpZMHdCODdvUVgzelo5b0NsUlA3aHp0Z2R0TEhlVmM0YU4vZVZGYXlE?=
 =?utf-8?B?Wm9BMmxaa1VzcnRBV0J3Ull5U2RuT3hqbjdkaXJMdTJnNUNoUnFQRkcwcXNk?=
 =?utf-8?B?RUg4ZzBDQVdyOWlBZjZ4dTFHaDZzZWlVUGNidExFeUpJWXBoSjVhSVR6Sk5R?=
 =?utf-8?B?dnROQWpBd1RiR1VVVkp3elJ3a3pUZWJNOU1JbXRva0tQS0k3TTJVZzFhL0ls?=
 =?utf-8?Q?+YWFgtsHRG8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFQ3WlFhYVNxVkQxa2Q0QUZyTW9aRlVqZFI5WWFpZzZ5bWdXL25FYndWY2xO?=
 =?utf-8?B?Nm5aYXdPT2FZYmsyNEI4NlBVYjhTYlpkWnpocUFIY0w5cnd1MVJ1TCt0bGFT?=
 =?utf-8?B?QnFkazhPWWFEYTVueFREVUhhYUc0NVlIRGRPaUVGeEQ0R24zd3lCRXM5MTFU?=
 =?utf-8?B?c0dFZ1NCeXYvNDhlWEJLQXFxaTQ2L3ZMc250OWtqQVNFWHFvZ1NHREFkQWRn?=
 =?utf-8?B?NWxkRXkyZ01FMVBLMU01UFNzSTZ4MnE4OVR0UzlRcHpkMVlOTjNDdE96TGV3?=
 =?utf-8?B?V0hYWEM4U1NsTyt1K0RaY25rWGVkdWVqa2x2NHpXbFNLYjh5WUgycFYyUVJC?=
 =?utf-8?B?R2JrYm1Na1NGeWw1emF3Sk9sVEMrWXdjYm9ZSVhNZ1IwbFFCZ1lhZnNTNGUv?=
 =?utf-8?B?S0pSMGVMTytSd2prUXFnRTlJWkRiYlFQeUtFR1UraHFmOXhzNFk2TVF1MnhC?=
 =?utf-8?B?bEk2RGJTbnVqbXdZVmo4Z0Q1U0lEZ2lIa0xmaS9ySUNRaEFVN2Fkekx2YnFO?=
 =?utf-8?B?cnhUdEpBb0xwV3BDdWpHM1pwN1pISTk5am1zNi9GYi8rLzF2T0VxQnN5cGRu?=
 =?utf-8?B?aHFhQk55ZE9RS3kyUzNOMTVpN0tuUkN5WlQ2NkxjbVg0YVJlaE9qQTl2d2tT?=
 =?utf-8?B?OGhPSkhNWXZYdnduVDRFSm5QQ2R0ZmJFZnU4TTZMWXdEVnZqbHAzT25aeWI0?=
 =?utf-8?B?VTFzVE1rTkgrZWZ0ZmFUWEZqQVo3eU9nRitqL2Q1WnRpd0FMRjE4TlFseUpS?=
 =?utf-8?B?SVIzTklQZUhndXdpOGtMa3FhRnJsamxzVVNmb04rTkpHQkYxSEticDQ4cGRM?=
 =?utf-8?B?dmNTak50eE5ENlJSM2gxbjZNS3cxWDYyMHJoOC94S0Q2TEhGS0FQalVNMWEr?=
 =?utf-8?B?SWxFNUg3d0s5TGhPREIrM3ExclNUY2w4cVRNV09kMnBDMTJCZHR1WHlHeTdx?=
 =?utf-8?B?N0dQODk2bkF6Q2lzYy80T0lheXBwb29KRTZlNWJZNFdPVFlwYVh4dVJOUmxE?=
 =?utf-8?B?d1pnRzU4bHNnZnJvT3lZdWdpZWoyNDZsV2dLVkJhRlVuNll1aG1hRURPNDVB?=
 =?utf-8?B?eUtFR3ptcWVNeUNNOFkxejJXVERoSkNiMS8vSlNCSUpxck9mQVlNTFZONGNt?=
 =?utf-8?B?TDMycTFsWjNRUE9VSHNpamwrTEloVkpxVVlpMmxWVkRsWCtZL0d5b0Rjdkg4?=
 =?utf-8?B?Y05PZGljcWRpU2p3b2xvQVRMOGJ6aGQ2UXgyYnU4ckFST1Nma2xwbml4RHF3?=
 =?utf-8?B?ZVNNaWx0SUJWdlprdkk1NmJOdlAzOG1DdXdhSzFjTW82S3diUWZ6Rmw3WGI3?=
 =?utf-8?B?Z2xwMjJHYURaaG9Tc01CNktqazN1Q29NRjQyZCt4a1Vqc0Vqa3YyRDY2Wk1w?=
 =?utf-8?B?SmNBeUZxcFhlbzJEN0VxdG4rT1hKcXd0M0N6U0dycldPVDVXbDF4ZzdMNmpX?=
 =?utf-8?B?OFJnRGJWcWpIV2s5dDNhV1M4c1ZIS0tNUCs3OUJZZkZ4NHZmcmxTd3V6aUxX?=
 =?utf-8?B?S0pRZU5wOXNXa1lGK3BEMUh4bFhLU04rS2lzWFA2Y3dhc3dyUVFzR1FOeURs?=
 =?utf-8?B?QXA5ekhzcGQ1WE1Oa2xkN2ttZEpKekMyZUJFYVFobk9qREI0K2REQnVlOU5q?=
 =?utf-8?B?TzRldENwQUpXZlQ4NDNuSzljaEs1WnR2cGJUKzVXY3pjMG05bXNWck5QbXda?=
 =?utf-8?B?OUNhNGNzWktFUVBzcWxYd3ROc3pORzhZK0dlaWJ1Z0M3Z3ZnZ055RFhmeXFr?=
 =?utf-8?B?LzArUWIrdTdQTHV4dEtGMzRCL3ZuK1NoWng4ZjZ0YmdlM016K3ZpMDl1aW5N?=
 =?utf-8?B?YWpZdkNtRnJrajZFVlRvVWRKQjA0QVdER2FMNFlkM0lJUTB4Q0dUZnh2QStn?=
 =?utf-8?B?cVY5bU1IRnpDRG9vMmxHekFIemV6SGkzRzh0dlRubWhBTjd1NE0vbmhMd1VQ?=
 =?utf-8?B?Si91RytFUG55dTFMUHVjL2F1dFcvRmc4YkV0cTNERWtuNW5qVkYrSHJkbW4y?=
 =?utf-8?B?V1BvK1Y0ZkdmN2ZTRkUwMVJBU3VPTXIwWmZKYWxsUkp6VFVlUEFzVitQRlVn?=
 =?utf-8?B?eVZES0JFMVo3bUZqZ2x5cm5jeitqQ0dOdUcxNU4wd3lhMUNoOHR1Z1VMWlRJ?=
 =?utf-8?Q?OOT5ldEIKnNfYIcXmJHRdHwW3?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 860106a7-8c50-40a3-887f-08dd7d8e231e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 08:59:18.6748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F2Tln90PJZPm5+itrndVOZ2ULHgfUCyAINvgcr64fZj954aiTy8ABTiQPfHfKiuPRh1kwZusyvS7pMiXVK+3lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5220

On 17.04.25 10:43, Florian Bezdeka wrote:
> On Thu, 2025-04-17 at 08:15 +0000, Qiao, Wei wrote:
>> Hi All,
>>
>> If we build the kernel in ubuntu 24.04, there is build error:
>>
>> from kernel/xenomai/debug.c:23:
>> In function 'strcpy',
>>     inlined from 'hash_symbol' at kernel/xenomai/debug.c:94:2:
>> ./include/linux/fortify-string.h:787:17: error: call to '__write_overflow' declared with attribute error: detected write beyond size of object (1st parameter)
>>   787 |                 __write_overflow();
>>       |                 ^~~~~~~~~~~~~~~~~~
>>
>> This is because new gcc version has stricter FORTIFY_SOURCE( =3 is ‌stricter‌ than =2). Please help to fix, thanks.
> 
> That is the flexible array story...
> 
> You could try something like below (completely untested) and report
> back if it works:
> 
> diff --git a/kernel/cobalt/debug.c b/kernel/cobalt/debug.c
> index 25b194c26..d048dc757 100644
> --- a/kernel/cobalt/debug.c
> +++ b/kernel/cobalt/debug.c
> @@ -47,7 +47,8 @@ EXPORT_SYMBOL_GPL(cobalt_debug_vfroot);
>  
>  struct hashed_symbol {
>  	struct hashed_symbol *next;
> -	char symbol[];
> +	size_t size;
> +	char symbol[] __counted_by(size);
>  };
>  
>  static struct hashed_symbol *symbol_jhash[SYMBOL_HSLOTS];
> @@ -91,6 +92,7 @@ static const char *hash_symbol(const char *symbol)
>  		goto out;
>  	}
>  
> +	p->size = len + 1;
>  	strcpy(p->symbol, symbol);
>  	p->next = *h;
>  	*h = p;
> 

A bit of overkill, given that allocation and access of according size
happens within the same function. No smarter way to tell the compiler to
stay away here?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
