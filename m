Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010008.outbound.protection.outlook.com [52.101.69.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207A0248F47
	for <xenomai@lists.linux.dev>; Thu, 19 Feb 2026 14:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771512489; cv=fail; b=MguUpiiUcFYVrqNS4VA1G0E4rAfo87OIiOwguZ+gJzSsvUsu6DfAA2pxuJzskHXgs7JPn3ZykH/s7fpQQJv/iHOLofy3yx0iqAI6+C0LTnF9yi+MvUlqxgqvhqqtsbO6Em0Vg+cG5ad+XqLgtQHGrpOWuCHc4oaHvdObuVcIwPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771512489; c=relaxed/simple;
	bh=o1VBTUtHubKDyhdj5BQEEdQWQOccGzl69G8kfeQEHBo=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=hoz4YkwNPImTiX2564W2CIClf1Js1O3xODycoGZOb9Ef+Oi9IEwuLF26NkU7hBQQ+lnzHDrjwRWuhP41WG20/PyOVW1X+b9njSxU/S/j7szUs+a6j8nt3gkgkK/H2X2Ay/G3ga0G/6TjVQQT82lHmpcKJmFUjZ0w/lKYtjIY7Ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=BK+a2N1k; arc=fail smtp.client-ip=52.101.69.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="BK+a2N1k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SxlYZWQrWplWUw8Ool6Q70B+xadlRLF+yOtLhp2ZsOdoS85dJFWHgaUK4EqzD9YGZqUpU4wU1a9XLvqimyrk/fz6Kq9MMCuOFOgtN5+Sq11rQEqNaO8u4xXUe5vjrKyMR+/eAc3JuwJXXHhUa5Aisq2rMs/8hJHOvx6MYPD8NWnyOP/Ymv0EC+gKOqZEu9YtOp5ANaPXajtzlXWuHU1EKbQmsYnc0/i21OhqkDzTMwEstOB+39RJISfx4rjrhf7H+J4xdGG1O3wiji2LOD72jtkhQoeUf7KhD3tgmo/57ZZpu4hD8eI9mFCkt6Qv01AA6h4k9k1QmMQ2Q+PcgrBf2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qoeo9Jh3wlhBgYOTFBwNQm6eWIzzGg+uos2BoxZEyu8=;
 b=S/+/+8hbiFcN2RqFHoyhUKp6klT6ld40El4L2xWtXWE/XmJVL2hWZVy7lh0iRF2+HH+mHGu7rO9ajQMeMgss9WEhcNAP4TR5h1lu7BCiCw+5We0w8Ha3SzPLGfvA1AbJpxEG1JCWGn3TsVKONVU+qh0y2vsfEgyz7Wyubila3wwZz1L9oGTI0vuJdWaCCYApeqJR1Zpta9MwQvWQEcMe2ZpMVNFQrSNcKAE8/tXQBknPKHuiLZesXZJpKBobmCAJkMxh2AA+vGRsvfoHJEo9z1lWRfwfU1t8OF6hUXHeUjs/nyY6PS41bBvWW117J32fPsNESm0Tft+KC2ZJpVIpiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qoeo9Jh3wlhBgYOTFBwNQm6eWIzzGg+uos2BoxZEyu8=;
 b=BK+a2N1kV5PWL19GOCoWeeFu4vmbbNVYACs0aSV/hx3WsvXaAFtRlfRmYQNKfsKsNxfc/qOPmpCjrnorwJnMySdAIJFC9yHn7f+5E7FPrJqOQc9/iFxVokQ4Vf2PlCa5T/+vC687wcwOmMyUtmJ5BBiMKAn+OUcv8Uk/XP0AzgqvKB3AZTeA/1oINksYcGInoZ2JakNEDGJNhzDYwJlS/d1QA6AGh5TH6aXav2xXci0rgCJOeiP/M9dvdwtM51T6dRtotQfLOG3O2lR3uZLiFJfsOhEchfg5Rm17rKx0aC6Bh28CwCtl/AQgEZ2EHrwrQ3E2Uke0nxOoqL4f5QT11Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5170.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:342::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 14:48:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 14:48:05 +0000
Message-ID: <fbaa39cc-1385-45c0-882f-849616425734@siemens.com>
Date: Thu, 19 Feb 2026 15:48:04 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] build: Drop unused AM_PROG_LEX
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5170:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b967a7f-b0c1-4d9e-56e3-08de6fc5e399
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2tVb29CNUloVTZRMElYemFGU0E2VGF5YTBLRTdZZHlydHBrQnBKTGRBdzRY?=
 =?utf-8?B?TmowMVhVOFdtMmlYb3ZuZ2QreXhGbU1COERQL2tKcDdyazNWaWJrdTJKSExn?=
 =?utf-8?B?Yk9sSG8yYnA3ZHlmSWN4cUxEcWh3UE13cXZzYmFpR0dDUzdGdndHWGNZcnFV?=
 =?utf-8?B?Wk1PbVlmTWdta20yRW1zQUhHNG5JZVA5NHBtWVhCTzVNSnNRTTZrdU00NlhL?=
 =?utf-8?B?NVpBWllRS1AybFB3MVZ2aWtIa21jd01PWkdqbkExenFUQUFkNXBycC8wUjhZ?=
 =?utf-8?B?UVVwbktJS1pMMDVLZDRtN2tZc1I0RnJybzlIVUU4SDhMMnVSeXh3eTVhT3dF?=
 =?utf-8?B?U0pYSHlyMm9tZTJMbFJMUjg4cEJSMlk4TzNzOUVnenlYbFkxVVplaGQwbmtH?=
 =?utf-8?B?MkoraEVUTDNzdE0yV2ZVam92bHNKNzFJcTJnbWtCbHUvNU1MUWFRdEZmOXgr?=
 =?utf-8?B?ejRDVDhDWndEZi9xTjR0d2JZSWJSOHpUbXVsM0N4QTdGUTU2WmJHQ3BSdEhn?=
 =?utf-8?B?U2o3TWdzeTJuUWFsOHNMQVozRFVDNklDTUtKd29uYmFsYlVWYnpvZFdFSEVU?=
 =?utf-8?B?U1BNYmR0VFY5VUg1aURHM0pZZTBVVVpyMks5SHQyZWg5SW9MQTZFc2VKbjNt?=
 =?utf-8?B?Rkg0QWdJWXJQbm8yN0wwekN3azgxSkQ0aUIwamJWQ1pjSDVLS2I0K0xXRlIw?=
 =?utf-8?B?ZlFsY2o0WFRxOTRlSU9HT0g2NE91aUJkdWZYL2g3eEZrRlpjOWQ5NW8wbDZO?=
 =?utf-8?B?eVZEWUwzU3lhdUtXZkNGS2xCNFVDY0hOOWVKQkdETjVlQ2dXend1cithOEJ4?=
 =?utf-8?B?NnBVdm1uL2JRRkVOLzV4YkJLSEUrakZLUHJnL3grVks5c3d5cGN1dWJEUWN1?=
 =?utf-8?B?aFV1VGV3bytsYXUyS1JtVkVIWHB2SFFEUHlzU2UzTy9FRTAveWFEeXZFMDZX?=
 =?utf-8?B?c3pyRGV6RkhrRkFaSkpNbmJ5QlFNY3VkR2M0aThPZGZKVzhIUHJmOUErQjQ3?=
 =?utf-8?B?UE1aaThGMDVMaU9QWmVKMFhKTnV4bDl4bHNJbDNsU2dhZkZaM2Z3U2xmM3JB?=
 =?utf-8?B?ZlFNdlhYbUR4b3Y0MUxMb3ZxeGlYaDRiTjlDaU01UDcxVzhONkpOQjd3c01Z?=
 =?utf-8?B?WGN1eHdlSWlPMWZYNWNNNmI1Z3pmTzBBcU1ML3JWVy8zQ0tiN2dqOXBuSG9x?=
 =?utf-8?B?WGhUZGFtVDhBTi8zWElTdDljWVhkQkhEZXVkN0VXN3Npa2g5ZmVuN3k5ZnV0?=
 =?utf-8?B?ME1NeVF4NmlleFd0TU90K1E1TDdUdkhnVHFSajNTQkpPc0Y1a2RFYW51eVdu?=
 =?utf-8?B?bkhlakE3Mmczak1JN2k2aG1qSDdRRk9oVVFnK0RUNWFIb0V1NGQ0ZlBQRlU3?=
 =?utf-8?B?US9wOEI4MGdmTlkxU2picFh2d0toTDErODVDb1hlYnZQMzFyei9NTzdBc2hH?=
 =?utf-8?B?bHBReW5SSWlHVCs3aExhUFNuOU9CNHdoWVJjTEo1WlQwMmZxT1VvWG5VeDBZ?=
 =?utf-8?B?TkRSSzFlZGlWVFgzMSt5NnkyZVRMVDg3Rit1M1J0UzE0ait4YkpBZGY0dExk?=
 =?utf-8?B?THhyRnFjRUlCcVkyYmNXR29pZzhOa0JXKzVla3Z1dGJHcUhYS1o0SHkzZ2ZC?=
 =?utf-8?B?MCtNc2hnRjVmQWZUTEtTWDZsRjdSd0lLVmswOUk1UU5seS8wUXpVZkEzZHU4?=
 =?utf-8?B?TGJiQzZTMkV1YzZlYnYxM1pWRWF1cDQwZFQ0cXNZU3BLZTRhUVN5YjVKeDla?=
 =?utf-8?B?dHdsZnQzbGpiKzIwVVpsdEY5ODl6REQveXI0ZkdXUUZOWmxUN08rdkQxMkpI?=
 =?utf-8?B?TVVtbjBSYXZrRXJtNmxla25FQ2pQUkcwQ2FTUUl6TjdPcDVoR210WWNpdVBz?=
 =?utf-8?B?NHhvekNEV0VQMmI2SDN3Qm4xTURjckI0ek5vajdvRGU3NXN2NGZEd3BzNjdn?=
 =?utf-8?B?b1dRbTEwdytVTDBWWTh5Y3VHT2FlUEUySGUrejViYkJnemtHQWxRcE9NTW93?=
 =?utf-8?B?NTdQa3l1M1lqd21XbHZxbGJMZUhCL2F5NGRTcmdxZVR6RHVrOTg2OXVmWTJx?=
 =?utf-8?B?YnhZbTBCdjliUCtDbDRDRE9iWlU5WFdkaG5lNU1PNUtnNm5ic0NKNW5TK0Rt?=
 =?utf-8?Q?K2Is=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWV5Q3BQNmpQdmEzRTllSXFCQVIwNkgzK1ZnbEpPQ3VNM1FjWTFDVnZXWEpP?=
 =?utf-8?B?SmN1MCtqMDFubVpuR3JES1lvNmdUUFFDK3J5RXFEV0hCbDFRdkt4YzZ2TjFz?=
 =?utf-8?B?TmYwRWhlbHdtMExwQnBPeFZSWUM3L0t4TnhpcS9ZOEV0c1Z0VHFST2h3eEVO?=
 =?utf-8?B?YmNLYlRHWGpJUjNsa3pNSk5kMWU0WDhMekFyZ3pFeFphV3BtZkhwL09TS0ly?=
 =?utf-8?B?eVNqT1kvQnRTa0RFaWhKSU1VMkpHbHpqb3J6VUJ4QVRRVjhLbUZBRDc5cDRR?=
 =?utf-8?B?aCtHdEhaTGNLdSs3NWc3WHZzcXFNMWtCOFNZN044aWttTGNaaFNleDZHWURW?=
 =?utf-8?B?MjM5cnBVWCtKV3A2YVEweHJRV0RzSFJJYjFWbzZIOVZ6MFVFMTRsSG1PZmJj?=
 =?utf-8?B?UTlCKzhVSi83empoMUh5bU8vb05Pamp2RG5QVkcyd05oVFNMZUhyRDdrN0FX?=
 =?utf-8?B?N3JMSE1UNTIzbTJFUjBpRWJtTkpuUmtvSEJpNUtaeG05b2t0RXViN2JsLzZQ?=
 =?utf-8?B?ZHBPVEI1eXR3eEppNGhKWGJlN0R4RnVBZ0dZRGNkU1N2azN1SVYwb0ZKY1hE?=
 =?utf-8?B?USs4SWxzNGZqMmhpbHdvMUE2L05KbVZJbVpwZllKc1VERjl2SldoUWR0VFFI?=
 =?utf-8?B?YWtDOGNFZmJtWjlabHJUa3l2ZkkrQ0ljaVMxdmxQbmNvZVkyaFQ5YnBFOWpT?=
 =?utf-8?B?NlcxVkNESG1OSkhBdVVCR0NIQU55L3lGcjJXalR2K2ZFRUNUcnVweWl3Y2NP?=
 =?utf-8?B?VlZ3TFV6N2lNazN0aG15VEJCa2lacGswMSswbUZ0cW5idHQraDU1UjFPUDJK?=
 =?utf-8?B?eW85WlU0Qzh0T3FvdTQ0T3YxTHBSakNRZzFhU3F1RjkvMHkzNS9PNmN3dEJL?=
 =?utf-8?B?TTQwQndUcVFYbmRtbFVRb1AxOTkvWldJZlBlTFFxamtqZ1hCcExXZ2x3dEJK?=
 =?utf-8?B?dVcwTFpjNzVxQ1o5M001dUV3cDd5dTdzaW1QWHFwSWhwM3lTdU0zSm1Tdmto?=
 =?utf-8?B?Uk90eG1zTnBaU0V6NTZZek44bkFDSFFPNy9pdEk4QWVLcnAzMGtiNGxieW1x?=
 =?utf-8?B?eFpoRFNBMUViZ2NQT1RiMFZ0VGE3ZlM0OFphdEViamVoMWlJMSs4WVQxSXJK?=
 =?utf-8?B?YXZlRE1WbjUyLzlTTEw4TXFGMXU3bERqQnVPNzFNUHoycjcwZ240Vkw2MTVa?=
 =?utf-8?B?SjVyOXVDMHN3TGp5YkhrNDYwakdmczFwNmpIVkZqZ0lnaG9RY3MrZ2Nyc2M4?=
 =?utf-8?B?VG0zcm9uUWViVmZqL1dtVFlCeFRML3JuSXQ3R2FiVTV4cE5NMDZiZXUrNGRV?=
 =?utf-8?B?TFM0NHIrWmJhOEFkb0lWOGhKUTlzYkI1WmlMdjlPWm5MWCtPVVVINUJtRVZK?=
 =?utf-8?B?aHIzaHZ3R2FLZjRQSFBxOFE3bXpQU2NlTmRkVktzbC9LL3V3YWxTeExTWnVu?=
 =?utf-8?B?UmxvK0VKbVNiTUlBYk50MEFoRWN3aTBTOFVoZE9pcGZ1U2RQV1doWWY4emUy?=
 =?utf-8?B?WlI4TjMvaG9meEwxcWZUdW5YZExuSnMzVFkzZDg2TktBR2VrZlhnU0hLM1hl?=
 =?utf-8?B?Wnh4c3BKQzNSVFIvM0JFZ1B4VCtWczVPcjlRdWh2YVorNkJKdXJMdzRsQWhp?=
 =?utf-8?B?bWtGMGxNNFpNSmRyUW1paVd6UFBPZnR2czVRbDJzTEdIRUZyVGRqNXVIRU8y?=
 =?utf-8?B?S0Z5RWFBc0UrUGk3eXhEbmEzams3WmtQdHVlVElKR1kyNGg1NFljZ2lsTTVw?=
 =?utf-8?B?R1ZROUlNZ2ZtQjlxODBNclVQVVlNcExjSHcrTkVlM3cvWFVRU0JINFRVS0pV?=
 =?utf-8?B?ZENlTkRvVzJZRnB6Zk82eC9XVXpETk9yVXltNjFVSmIwY01hSmMwcDBBZVdz?=
 =?utf-8?B?WlJFK0JOMTV2bGRKWURlRlo4dlFEQzkzUDMvZThBM0ZZZUE0Yk5LT0lyL1Zi?=
 =?utf-8?B?U1hmUmV2Tm5lbEFLdmRUMU5BcTZMb2xZYzFvdjFQaWs3V0RwMDF2OUhuUHRs?=
 =?utf-8?B?QlJDUlNBUXlxa0R3MGJuWkd0UHE5VCtuZi9lVWFiWk1Tck54Yi9lTFZiSHFo?=
 =?utf-8?B?cjlxbUVjSVA5eTlLSTdqRkFValhQYzFOSjVZVEZPZ1I0UHU3elFJMHNWRHBn?=
 =?utf-8?B?ZldWNy9mTGxwaldWVUNuU2prYXcydWVnT0l6V3lmdjBHN1JJaWVZSExVOU84?=
 =?utf-8?B?VWZaeUZwR09RLytza2w4TTRzOHpINnJKZkFyZEJ0T1FVczl4T3AxRlA2aU5V?=
 =?utf-8?B?TE5QUWRyZGZNcWI0UkZVTHhTVWx4WUJHK3hVZ0I3MUIzWmtzMmFnelNId3dr?=
 =?utf-8?B?UUlIUmhEUW5nTEswVWVOUGdVVEgrTDFhQWRiWGNKdnR2eHcyU2xUaUdCS1pX?=
 =?utf-8?Q?RsInv2KRls3cz+LU=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b967a7f-b0c1-4d9e-56e3-08de6fc5e399
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 14:48:05.2333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 03nR5h0snMEcllejxgZqCNy2hqK7sA2DLRDXjZC08TUONzQhgM0Q2r79fTyiXQFYH7Bv/ofmYX50gNd6VvswfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5170

From: Jan Kiszka <jan.kiszka@siemens.com>

This might have been relevant back then when the cobalt code base was
also building kernel bits. Now the kernel itself does that.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 configure.ac | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index c1214bda88..5d8fe4fb87 100644
--- a/configure.ac
+++ b/configure.ac
@@ -120,7 +120,6 @@ AM_INIT_AUTOMAKE([foreign no-exeext dist-bzip2 tar-ustar subdir-objects])
 m4_ifdef([AM_SILENT_RULES],[AM_SILENT_RULES([yes])])
 AM_MAINTAINER_MODE
 AM_PROG_AS
-AM_PROG_LEX
 
 XENO_BUILD_ARGS="$ac_configure_args"
 
-- 
2.47.3
