Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B78168B1
	for <xenomai@lists.linux.dev>; Fri,  9 Aug 2024 16:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723219271; cv=fail; b=B8LhW+vbK10OUli66a2qwLPwldOIi1TJPtj8QVnTk9lt228c+l3oNCiWBBQEawSOPozBcSdVnUQtxEbyZ7tbPGMcPyUYQj2DZVPjXJL15+sqzkSSZhUCBUr2wR1KM7aVN0nWJ5XXQJP25ACUtwMGIEp9H3jwUFy0wben77OU4FE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723219271; c=relaxed/simple;
	bh=9QWVOo/LYzkRpLy3fGzc/R+L/q9hwQFP/72pYgMlpl0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AXeLKzcHDiPraagnwcnFg521AeAgFpJA144ZvwlEATBe+nIGhwXunKfkpSZFlxOFqmSz37cN/Op6/vkvDYIGKh7C1LH5Y2boGBhrl8y4KpKjYxAMVG2l+TugVSrdocnRHUkwgPa6bdc5c+XCutSDPT3eIK6OC7vFLf8DbkujxVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=brFHvMsa; arc=fail smtp.client-ip=40.107.20.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="brFHvMsa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iTsEQoVD6uKWAYgpbbhcEYanEIAcRVijl66Wk/+BhFIiYiHMLWEPfWB6pLJ+cVy5lXqNnJcNU1yKtd+5aPRCOQaDpPAL9MXmP7EwzgEhR4QHOblxSAEWQmSgdB0kUhb+DnTz/HwOjFO0oS3IMAZKdb5DxLnAPn9P2HFFr/yDRIe6VKPxIc7lJ4KY+O/T1Kf6Up1YVAiYdnYM0+R0nehwphIqun1CJYhehVaKUiIyDm7+AmchxxVI9RcerQZ7V9YM20FLkusY+nUlKMX4anhGACE+zrMoUgGL//VMSQKl0IW3yDjHBC79ItA/j0EpCQGCBX/qOq0ddQjqyRDi/uyi1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhUloSiJN/p5ePpbGIL1mgdlPJr/LLoR1+ugm6fqX44=;
 b=xoao9L822xfnF/bQGcCjjZroK9urysyaSZpq1oUTSUcKUJlBPSZDpBglQsSsvMfDsPkFFVpoHwzXIobiqRkRaXeQIoE00mo2247hwKyrQL6fWoMFIAKVAIrC5ZxtYDNPhMYgQflfsLcLnROLJ6z+EMcFX/EeJMb7lx9+4Bi4Fee7ZGhOjyJbkzTBlUplPLZ2cVPSGE+PFoPRqdbR/UoLF3ju+2GJc+qMElsoXm4q8dThm5xgDWcmQJ5G2kiQPAHd02AaJefjCUftlX4QIsUH2h03Bufhm2ki4qWa8kquq/ci/JbUKLjbAHEZraLhTxMEAb7qAdnTgzWO6b3d93ic7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhUloSiJN/p5ePpbGIL1mgdlPJr/LLoR1+ugm6fqX44=;
 b=brFHvMsaQlGgDHcuw9uK5jnm3+PGGAzuFAoPoQS8bG4/Ma5kAJ9neOF+YgYJtCNrshz3tW6oapV4u2LFpDIvWGStaiDNTPgy+vAG9Czx6uWWyIJZdLnGVej71cNsdyMzASoIpxmHCOMtBBYZZnShPRO741pWnWvANhqiwGt6w8F9mJpuC01o/rrTzQLK2VEOCoA8DmzFNOD8G45yULKJu5tuTz3Zq4LUS9KbX+csTub5Qt5pmzDOzMjRBmynDb88Tsl7fG2+jP3ifFtwo8cI1kbSq4JKzfrms2pvkmFtVaL0eOwqDdea4W0P7KwAGS6MUpsXeJq7iL8oFTeNFbgawg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3127.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:106::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Fri, 9 Aug
 2024 16:01:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7849.014; Fri, 9 Aug 2024
 16:01:04 +0000
Message-ID: <0e2f567d-06e1-446d-b34f-02b9b9fc3165@siemens.com>
Date: Fri, 9 Aug 2024 18:01:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Thread stuck in IDDP sendto()
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: C Smith <csmithquestions@gmail.com>, Xenomai <xenomai@lists.linux.dev>
References: <CAFLxGvwDaDC-TY7qfhQrfTWPUu=4sYoT5j=U0iY3hQB43=PKDg@mail.gmail.com>
 <e4baa33a-fe36-4623-aa10-c66f88627856@siemens.com>
 <CA+K1mPH=JAwPY2PSGX8Wcn7hqVuJ-t9zdEStQ4FZdeHFy57YWA@mail.gmail.com>
 <d3c212fa-154b-4f5b-b568-2816f585f311@siemens.com>
 <CAFLxGvxpYZxV6qQre_uQjmF=nAa_Wea5EEWpH1kjreuRAi8CWQ@mail.gmail.com>
 <CAFLxGvytCz=B5M3dhvuBDcg5=mJK0E+-TUOESbkM2oSkz-qDPg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFLxGvytCz=B5M3dhvuBDcg5=mJK0E+-TUOESbkM2oSkz-qDPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0262.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3127:EE_
X-MS-Office365-Filtering-Correlation-Id: 5083c8d4-c10e-43a4-75a9-08dcb88c78bd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RnZoQ0dJNmU3THhoL0d0UjgvMncrRU0xQzN5RnYwY3g0Nk5IOS9sNE5yTGJk?=
 =?utf-8?B?QjMzVThwaVlTZ0RlbkpwL1ZPYkkrQTFRNVUybyt6L0hjc0RNMFBFa2gwdi9i?=
 =?utf-8?B?WVpHbEI2Uzl2S3NFUkxhTFdkbFNMaTBaSmErZC9BdW1rTmpSSVJaTnhFQTFn?=
 =?utf-8?B?SGhiMlQ0MHhld1JZNlI4TXVWWFlXMUNpMStjaVdyK0lZK1JkYm16bTdJQ2ww?=
 =?utf-8?B?M2IrWmRxbXlib1BUR3J0cEE0Q3l1empMQTNtRzhtTW1oTXpodmYyejlCajVx?=
 =?utf-8?B?N096Q1dQV2lvZmt0ZE4wTnBuQWNyWHZzWDlwT3NxcXFNWVlxVzUwSlB6TXda?=
 =?utf-8?B?OGhLdUxkVHl0S1RmUDVZY05VY09yS3drdVBJYzE3d1paWUE4VkF4dTBqZVJH?=
 =?utf-8?B?enhnamNXYnQ2Qys2S0lTOTZva2VjWHJLRlRIZWk3K2srUk1VQnE0QURKblE2?=
 =?utf-8?B?TytnYU5INzZWQnVLNGlhWDNEaGI4U2dGQmhLUHdDWlVldlZ4NndCZ3FEMDVV?=
 =?utf-8?B?b0RKQTlhWm9LSGJwaE4xZlJ0RjZrcndzekVYWjJjVjdjaWU5Rk5VMm4zaXFF?=
 =?utf-8?B?ZVNsbmc1cnMveWZ1eWRzTTBSSDBXeDg2QWFvTVR2bDZqekM4cGdvOXFKQjEz?=
 =?utf-8?B?UVpKemErblcwK2JjS0txWXRRTHhtZDQ0VTNGYkd6Y2QvaG1TSUZXaU4vd0Rt?=
 =?utf-8?B?bUFNc2p3MUdkcWp1OFd5WlREdUlEem15VUp6YngxU28xcnpBY1loOTJvQ2hK?=
 =?utf-8?B?OUdHV2MycHp2ZHQ1djBmdmcvaHdDa1BwUXlUejFLSDdvUUQ1WEFZdE5xOE1O?=
 =?utf-8?B?djFqYjZJUm5SNkY5M1lFNkxPak1yNnE2ZFZ3SUdXU0tXNkZ6eGwrM3lsTTJw?=
 =?utf-8?B?ckVTTUROYk5wYTJUK09jTjAxMWdsUlptVTd2NkE2RzNXaXpVYXIvOGp0aWY3?=
 =?utf-8?B?N0RvRmF0cXlseTkxYituYlZ6U2NzbzFteHpyM3JFN2ZrTFN4RTlNeFpJYmxQ?=
 =?utf-8?B?c3BMTGdwUFMzOU83TVpSUFM3Vlg2c3VUZmRRNDN4amVRcTc4VUdRMGkrWlJL?=
 =?utf-8?B?STlWZVlnZldaTEdtVkNuOVB6SVVZN3MrUTV1Q0xRMDRyZk1TczZNNWRIYWt0?=
 =?utf-8?B?YmIyQVpnK2dVM1hDdmo0OEdkdTRJOUJySlpScGFFR21nUlFvcXZPR2R5L0lo?=
 =?utf-8?B?Y2ZOZkJOakNpVFZUUXhYeWFzUU4vSUVQTFVDeFkwS2tDalBXbXNOSW5SaXpB?=
 =?utf-8?B?T2IvWlo5NEh3V0lNVTYwcGlyTDV1bUFsTENHNFlBQ25ERUVJeDdZN2VqS08w?=
 =?utf-8?B?ZkljVG5QbGVCdG9kc1YxLzI3bHVCbTdzdmU1b1RDb2IvRmRmZUdsa09ZbHpQ?=
 =?utf-8?B?SWRQM1Z1cFRJV1g1dk9GeXBCZXlvOFpSNko2RmtIcjcwUGZabXNNQlBxbDM4?=
 =?utf-8?B?OUJva1JyOFMxME1kZVo0RTRlSTNYSEdJaXdiRU5yN1VhMHFUNnRPcGpUQ3hn?=
 =?utf-8?B?eHlCanlkREUxMHpTbWxaK0lDL3AzMjR6VWdLT0JoeXVVVERibE1xYmJTUTJU?=
 =?utf-8?B?bG9xTmZXT0dpa1BuWkgrM2FReVRreEdqZ3Y4eU50bUlLazNsZUFua2VtNzNO?=
 =?utf-8?B?TmFNalkrRTZZSEJ2R3JzeGdHU2FaWnI1bUE5QjZnbHFJeGpjcm5adW1GUVdy?=
 =?utf-8?B?b3JnNUVtT05NTkZ1UTVYMmI1UEtLWXB2YnFrZytwVldOekRaTGJYSHVGZk5s?=
 =?utf-8?B?QW14TUl0OWZQTEhrWExCNTl2dWtsekprWnlFVkNWZVBoczVPQ1dKN2FUNmlY?=
 =?utf-8?B?clN6YjNsZEZ3SVBSbjZmdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWd1ZjhhMUs1M04wSjQzMGRkNFB6eUlXekJoenlid1lWcWdDbDBGN0tzb2Iy?=
 =?utf-8?B?K2UyTVVmVWt0OVFTQXplT1pQUmFNd0N1QmdaYW1yM3VLREhCR1VKVHBkQitG?=
 =?utf-8?B?d0paUFM1N3BlQUlTcXdBNmtwTnBSWEU4a3F6MFRIeFRCM1Y3cEVsczl0WXNx?=
 =?utf-8?B?WDhVVWFoM2ZkN1ZDcmJrR2NSL0JSamF4aGJuMVowQ1plSnMxUkZhbXhlbFBa?=
 =?utf-8?B?cTFWc2RZSk9DMGtPQ24yRHlzYmNQUno3ZlpzUTdLMnhhVThFY1VSZm1ZUzA1?=
 =?utf-8?B?amlUQ2w0eHd5UVNLOEJWcUVLMGtDQ0JTUkp1T0l0V1RibVFGL3hObnZOVGJ0?=
 =?utf-8?B?ZmRFNmxZcksxZEZwaTkzSlR2cXMwU1ZWVEtHOUZTRWRuYjRFSkFMUjJBRktP?=
 =?utf-8?B?RXZGazVZYStmV3pYY2lpSVhpOWRIemNYYnA5bFZtajI4eVBpOStMV2FwczQy?=
 =?utf-8?B?d0h5RUcrWWYwZWV4dDdKRFlOa2ZtaDVlL1d6d1kzMjk2a0k5Y2JQRVNJOUJG?=
 =?utf-8?B?UWhLdDlDV1dyaWw4RmxjUlJWcm0yMmV3WC9XZ25aTy85eFhJZ3o1MW9VMVV4?=
 =?utf-8?B?RWhrVXdabXFpbmNicDdaVjgzR3g0QnRvQnk5bHNrQ2xpQWI2VVFPSjU5Mnph?=
 =?utf-8?B?Q3Z3UVBHQVYrRWlGbml4cFVrOVU0dWorUTdkYU5kUnFJakpBZUh3WXBiR1Z0?=
 =?utf-8?B?Y0FOeEtOSFYvNkc2UXZTMElsWVhpdXV3dXZSRmVFVzZ3OTZRNDBZbStQSm9T?=
 =?utf-8?B?eWhYVVhUdWhmdkR4dXMvL0NhWU5qWWhHeDJ6djA4U2R4WldvMEN0MjJ6c01n?=
 =?utf-8?B?RmVhZk5tMnIydXVEUVpoYkZVVEdqK0tVQW4rd01IWVlsb1grZnVsS1NhYTFS?=
 =?utf-8?B?akk0bVJzMkNHWFRIdk5Way9UMG5kb3laYnJhQkdGK2wxQ2ovdEhRbGVIeVg4?=
 =?utf-8?B?c1huRkp0MEtqampkcEZzbUJGdDF1WlhGT3dEbCt1RHY5RTd5K2gwTWFYZUVk?=
 =?utf-8?B?cEhnSG40MTk0QnJ4OVh1SEQwbXN3WmRTZkMxQWRwemVacVhPNVRKOWxXaXhi?=
 =?utf-8?B?M2tmT1ZxUmo3MHVxWUMvVWsreGY2V2x1SEZCSW42ZStuOGRwTlpPUjY4cURR?=
 =?utf-8?B?ZlNyWi95YmZrV3l3YzB6c0g5SFpmUE1ReEdCeDZLaHp1WlhpZzR4RjJPSE5U?=
 =?utf-8?B?Qy9rdVM5SmZKS2RDMmVMbTY5cEU0VTFMUnRxVEIvQ1pWSms2Y2F0TXkvdW1s?=
 =?utf-8?B?ZGNydHB2eXBKcEhvMXhybFlwNndPdWZRVC9seWRHTWpEUlNiZjQxOTJmazB3?=
 =?utf-8?B?REEyZXh2aGphc2tZbmdDWmlJc3dHKzZjM3RpTzdmczhTU01hdTNhWEVQUVcx?=
 =?utf-8?B?RGlkRWF5eU0zbXRUclowU1EveGVid2tCTWVuNm10aFQwN3I1SXVkZlNId1pF?=
 =?utf-8?B?ZDlONDdvcFpMTm8wU2N6MVlEVnJGVERHbnFsOXI3eThCQU9UVE96Z3RwYS85?=
 =?utf-8?B?OEZmYlhEQW9KR1lrMUlaQlNUWUtqQlRDRDUzSmpuMVJVYzNsVGdxUElTUzBL?=
 =?utf-8?B?cUZDeHRMbnVRTDVnU2F3cFFQanI0aFNqWExMby9ST29iOG5EQzRUNUYvZkpR?=
 =?utf-8?B?Wm1qRGlaOGhDMFJnVFpOY1d1bkFEY3JrWGFKbEkzRGdXZlJ3QTVTSTVUTWUr?=
 =?utf-8?B?eVBOcVk3K1hrV2JhSGdjLzdUY2dmNTVBeEJhTHp0YlhnYzl6QjVWamo3MmpB?=
 =?utf-8?B?bHRsaUdlOFhkMUk4cmNqL0krSld1dnRiNUhtaHZhcWlyUWZNUmY2b0sxdlU3?=
 =?utf-8?B?YW5nUnhNcFlXWW9hcTlOQnplQ3NiSFplSit0ZUltR1JJYVlGdlBZa0V4djRU?=
 =?utf-8?B?cDRVQVdDeXZvQ01uWjQ4SlkrR2Zwell3L2xoVVBranJIaDU2YXUrWTlOdkdM?=
 =?utf-8?B?bldzR3dJSENmeVNRVnJqMDgxQ1p0SFRxRk1BNDRrV1ZYQk5oTnVhSTdDVmJp?=
 =?utf-8?B?ZjBHZ3JzM1V5WGV0OGg0NVBpL2xGZGtycm9xSFZLTXVWQVJMOUM1VlZkcGFl?=
 =?utf-8?B?bkRDM0R3NnFIZGFJSWpyNkJJNFV4WVcvSHBnR1dHSjVSQWRrM0NqVnN0NC9O?=
 =?utf-8?B?T0xRQUozbDNhbkVvZ2J4Q3p4Yk0yTEliVDJPSDRSK0dWUTB4NWNkeW0zeVQ1?=
 =?utf-8?B?cXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5083c8d4-c10e-43a4-75a9-08dcb88c78bd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 16:01:04.1184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8YRTm9Ih/rJtO16lCCZ0nGs95+Xmof1CXOrxx6s1Dxv0NgEudX53R253GemLygsclDQIl1LmJSrFeIPbCevkSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3127

On 09.08.24 16:08, Richard Weinberger wrote:
> On Fri, Aug 9, 2024 at 2:50 PM Richard Weinberger
> <richard.weinberger@gmail.com> wrote:
>> This confuses me.  So, if a thread dies without calling close() on the
>> IDDP socket,
>> RTDM will *not* run proto_ops->close() implicitly?
>> (The source indicates this).
> 
> Well, I has to be like that, of course. It's all within the very same
> process. :-S
> 
> As soon one side of the IDDP socket vanishes without closing his side
> of the socket,
> the other side will block in sendmsg() when the buffer is full.
> 

This kind of makes sense, yes. You could still use a timeout and fail
that way.

Was that your problem then?

Jan

-- 
Siemens AG, Technology
Linux Expert Center

