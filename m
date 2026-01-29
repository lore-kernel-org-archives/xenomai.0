Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011068.outbound.protection.outlook.com [52.101.70.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515FD37F117
	for <xenomai@lists.linux.dev>; Thu, 29 Jan 2026 09:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769679911; cv=fail; b=IzV+/KSvGXvoAqx+YHroCEgCxlCieAjCj0DmfwNsQ0CqRi8f7R2GezPGTuEPxsWnM8nQ0D1pKhxvvTdydHLxNYAMeQN3d5AvC1NT+A1E0VlFjDOopqSJFRd8X8w6qt4VJVBYJNpXuQ0ma37Ya1W24k/Hix9j+/rB1j9kKe3nybM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769679911; c=relaxed/simple;
	bh=yn+8n1fm2Sg/MX4Jy4+6Jmew7pXfUZQVLT6+cR3wkT4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SN2k1CthQYjCv+G0AG28eDAOJsEbnQLTyzX59UEWV+KGbkc4P5uTxomVLzGDSZzUIBlA1EhejMnaPqBxe/U0PdYSyjtMkCF5QpS7t1dKSqICFNVCFyFVGkNBZDyq2pm+JczUmw33yWFLPkaGqmR2PKeQlKaX+Wm/qhysLem5sfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=aVy/s/Kj; arc=fail smtp.client-ip=52.101.70.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="aVy/s/Kj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lUTE+Jm0iDoI3toVVBqA9VRoyvjVfRPDGqUta50etSpyFNZ7bMWEETdDWLaEUGmbNXII0qKTHI1HoUba/5M3BlESfuwgdiNqTigT4dp5Vo4J7Bh1uuAhFYR7x31VX5+/DN8HTg9ktiYJhlf9WHcVxHu/FhHC3ASTOqJKucAPe8lG3yJ3/vzVUimex+7emi6tRew5xj2fQW3bGccGElV59NaHhhzXLlZQ0DXy3hyY2fHgY6YxKS2z5t3sHO2acw8ruvZMYkPI+69UJinzgeukF5b3i7021/tq1gXdZP1ASuIs0YueuA7Q5fPbUl8qXSuPTQPkJSjxB995qsnEfX8LOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BkpF5YoVLe7L5BIA/o4aT9OcgeAssmgaKyfnr45y5C0=;
 b=r4nfVxXi25FSw7RjVi7kxTybVXDPHN78ORm/9cfj6mkzTJydouwafuDVPieMpmBrcKrKSIctIiGL9kRdf/xuAkr2V97M04jFwPw05wA/zm++g54EXwWLp6V0AarbXgh3g7Cma0L5LOSRJuQo/ucgrytODai58lf4Ej2yjhnjwchgzU0QuetWXgZNhAPgtEODAyps/sCYwgXMjzN03jXV67rBAe0mX/ZMhgpL4YvBYg6O1OyEnZCcIWPpV0eSRvOiqoyzk8Bip0WHdavv2p85BF6elnEi7rHbbPo8u+/zjbVabxmOt+VoD0ZVTQWyPsBionVQCx7mrO0cYCHEqzDnKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkpF5YoVLe7L5BIA/o4aT9OcgeAssmgaKyfnr45y5C0=;
 b=aVy/s/KjoixOhcYlYobgM/zoFvoSNsNIUGmJW6wn6xWtBQ65n89tSXxJ4LoDfpyFFgcIQZ102ywZw9qkzMC/oBai5qfcRI0jZvB44HJ16jRTcr6q7D2/4WNKYUHcL1GHN0bzpQbIZz5cCsatOy4ojZkSn1OHSxB+jSbY4aX7qWoPlumXNw4ioCthW7NR37YITup5dssFtqOyGctxsQX3EBbQXJ0vlLZldIxmG/tsRQ9/bTungkxOwcWlmfvSLpeEGSUAFUoUlKukb90iHjI7VRcAXJVoQpYyT7lz/UGCd3SH6L25zxgL6ptQiv8QhyZ3Up3dMAYptjHI7LOy3EErjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB9399.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:5f1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 29 Jan
 2026 09:45:06 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 09:45:05 +0000
Message-ID: <da8e1a85-f8c0-43c7-8c58-d1b9cf7e20e3@siemens.com>
Date: Thu, 29 Jan 2026 10:45:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] Make RTDM tasks behave, part II
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at
References: <20260128112821.1232-1-richard@nod.at>
 <20260128112821.1232-3-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260128112821.1232-3-richard@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0206.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB9399:EE_
X-MS-Office365-Filtering-Correlation-Id: d6be83aa-507b-4dc6-41ad-08de5f1b1519
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2dpemtDSGRHUXl0SGNWNmhJYmVNMzBTYVFVVHlRMnFVRFJDZG5uam1JT1Jy?=
 =?utf-8?B?NjAyR2FYT21HUVJpcEF1cDVBbWZpSis3SGx6aUM2WWp4RmcyMzltVWNadHZH?=
 =?utf-8?B?VDAzTXlFTTBnYVh4OFdEc3RWZU5ZMXgvemZ3OXFlei9YdUhDeGlXSEdnWTk4?=
 =?utf-8?B?TUdJekZuVUFvVlV5UTF0RDNUWE5zY2IrdVhlc3NrclpKTFpRM0RYRzFmdll6?=
 =?utf-8?B?U3AzeHoweTg4OWVkRkJxZGVpSjdaOGdEbVoxNk9CTTd6RFhOcUR3QS9sS2JU?=
 =?utf-8?B?RkVtOUg0WXdjY3dXTDlUcDJMYWVxRjNxa2M3eHo1b0h1U2xlUXVpcmdPSDBl?=
 =?utf-8?B?TTZKWFBTeGl6VnRhaTEzSzl5bzR6V241TGVkbnBLOWF2cU4xOERPQjREN2ts?=
 =?utf-8?B?aFEzemJ2SnlZZzkvOE1ncXZIdXZYS2lxZmx1T1NpK253T2ZVZFhSUnFIdUU2?=
 =?utf-8?B?Zm5wMEF2YUZaSmw0U3p4bWhVZkpleTdGVTMyUkZZQUpiMzQ1RGc2dTdvWTF6?=
 =?utf-8?B?SWgzWHlMNVl1QnBaem5ibEtzUXcxdHA0d0lreHlKK0JuRDd3YW1JZHUwYWJm?=
 =?utf-8?B?cUdQS0lLT0xxY0JrNDZXMmZQT0FTL1B5eCt3Wnk3UUxPYlEvU3d4Kyt0ZllL?=
 =?utf-8?B?K0JmNWgzelFWaDN4dS9Za0lCL0ZieUk4NHFxaDVMUnJ1T2llejd5U2c1N2px?=
 =?utf-8?B?b0hicWVzN2RMYnY5dlNyVTBOd3ZlNTA1ek0vSlhvcVUyWlFlR0V0SWRNRkk4?=
 =?utf-8?B?VDVIYXlENnl2cXJudGJBMDJHTTBVa1BVSDFHZ1A2Z2RzYUhmMVFtOVhUSFB5?=
 =?utf-8?B?dzdPMExvNTV2RXlEbHZUZFl3K3FlOVg4OFdaSkpISVMrZjNtbzhNQXlLZEVR?=
 =?utf-8?B?MTkyaWFjRlZKUWV4TVNBbVpHSWh1bWZPa0xabEQwVjB2UnpSaUF5R012ZTNI?=
 =?utf-8?B?MVVpRDNsclVidjhiWmd4cE1Md0xCL2dHUFM1WUgvUkxzV1ZiNGNuYmVDMDdW?=
 =?utf-8?B?ZkMxRUtqQkJSV1JNQTEzakdaUGJIQVJKTnJsWXg2cU5WM0VkSHdPUjBETU45?=
 =?utf-8?B?K3h0NFpISksyZFdyck1QZlhRRkwzQm5abmEwR1M4eit0aVdlaTArSW83WTNN?=
 =?utf-8?B?NGI2d0ZMTFJlcU9JYzdUaWduVGlOYitJOWZaSzA1dlVlTks5S3VHSmcwbEo0?=
 =?utf-8?B?L00xWWRROEdja2RUYUlvL2ErUGhrQStCSTVhM2JqWFkrSmlKLzVEd0s3aEJh?=
 =?utf-8?B?ZTVQRmxabGFERUQwUURUY1J5Z05zVG93Z1l1UGVGeityOS9sU3V3NlU2VmVw?=
 =?utf-8?B?bUlKSTZRRUtzUWxPT2Ftb3JsTmNIY0F3S2dQR3UyS1lOS2JpKzg2b0ZsK3dY?=
 =?utf-8?B?ZGMyMVV2Sm42TkVsSEs3cUNnVVUvY015SVRURS80MlZsNkJ4bUxnWC90WjY2?=
 =?utf-8?B?eUZrWlFuNTNQUjgvdmhlUXlCMVkyM3lnTWFEeFVRYmRUVDlUQ2xVd3FKSUdT?=
 =?utf-8?B?Z2ZmWmJtMkVoQlBtcTNDV0FFcHdHWjVrRm5SL3BXWUtjRmR2d09JdEpUYWFO?=
 =?utf-8?B?RW5RbC9yUFk2VDY2d0JncUl3VFR4dGJCU01JQ1cveGMyRnhqL2JvZ3RJV1RC?=
 =?utf-8?B?eVdzUGhYVXhCSHRSOVFFZWVqaTh4a2w4eTNiZjFaVStFSUtBc3FzLy9YdWtF?=
 =?utf-8?B?dXlqVHZCOXE0TmlSVGswbE41SHNTT01RaWZ6aCsySlo1UTJkUENJL2xTYTJx?=
 =?utf-8?B?NmRpeWc2V2RpQkxOVi9wck9zU05jVCtiaVNUODZQU1VlT0ZJL0k5TDlMYWdn?=
 =?utf-8?B?dzRUYjZrdkdNNnpZSzE3Smk1VHFRRk9hZHh5UDBVZVp5czJtVVAvaVhxdGJX?=
 =?utf-8?B?Mk1KY2FJUUd3ODNpbmtYUnE1cFpwOFVOalFydUFFYjg0K3RRZkdFQnRva0Va?=
 =?utf-8?B?aHJyQW1ONFNXLzI5eE42cHJoM0VuTUZYWXFjN0R2MFlPL2VwcXJQL0ZBVW5P?=
 =?utf-8?B?MFFwdVRRV2pxL3dHWTRqdFMyeFFrdTBBZ0l2NmUyNmw2ak1BbDZ1WkEzOXFX?=
 =?utf-8?B?Wk44emcxMkZlZ0x1dTdDSW5pb0J6aHkvWTBKbldmWmhzM2N0UWd6OEd5aHhJ?=
 =?utf-8?Q?FDR4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z29YSFQ2bUVxYkMvby9uelNORDFrY1FEVG8wWHRrOERudlJBamxSNmZWTUY3?=
 =?utf-8?B?U0wyeHUyNi9mS0JNOU1GV3EwL05aL2t5T3FOaUFSVk40UE9UU05CUWZlbVpC?=
 =?utf-8?B?QkN2Z2puM1dCOFZhQUYyNURValdzMjZ2MFpFNXIxWldGZXBGS2R1WkZndWM2?=
 =?utf-8?B?Q1I5UUxuK3d3R2U5Z2xodlM2QVJELzk0QWZrbWp1bC81aUEvVjBRa2M3bFZS?=
 =?utf-8?B?TytKcFRvbzgzU2x2V3RLTUVkeCsyaTNVcjJxdERPWHFyTXFHZk9KVE1PUkxs?=
 =?utf-8?B?bmJPTkZ1WDREVjl5TGtUaEdVVUNSVWs2WGt1Z2NUMjBGcnRxRVBqclVzN2xq?=
 =?utf-8?B?NlFqeS9FYnBuMVNPd2xMbk1EdmQ2bjg2K1NjQ0ZZQ2haM0NIbDluVUJJY2hJ?=
 =?utf-8?B?WGMrVDhXcXRKTGdOWUtpVnpDdGIyQjJIVXlrclBLTTUvcVhSb2luQjFuWmFW?=
 =?utf-8?B?OWlxK2Z1eERIZWp5MXdZa2JaSVZNMFovSnE3MkRUOEUweW9QWnBBRzEvRTZS?=
 =?utf-8?B?RXJ0S29mTS81OTF1L1hiNkMyNTlWbitNb1ZsSWI5M3FWaktjb3BBRk5OaWVS?=
 =?utf-8?B?ME5DVUxNSXNoTkM2T2pVT0huWEI5ajZ5MVpDR3cvd2hMVGZpbG5IVmVuVW9w?=
 =?utf-8?B?VWxtcXJqVzNXckVFQ01weWYza2VCL1ZYc25YRTlOcko5RXRhRVlXYXVHNTBY?=
 =?utf-8?B?ck03d0tUalpQR0dkLzB4YTFWOFp0c3E5aTF3M1pkUmxZQnZjY05DazBHWEQ2?=
 =?utf-8?B?NFcxeGJoQU1nSDBiYTVnaGVCRVRKVUZpdFl6NEZRdXp2WW03R3ZsMkRzYTRX?=
 =?utf-8?B?V2lWM3VFdHIyZXA1RnVHdDdrWnJnZTRCWkYxWTdyREFBQ0RKTmo3R3l3c1RR?=
 =?utf-8?B?SEJyb2lTOURKZ1hXd2pHWTE5aVovWXdUOVdzSDdZVStGbHJqWDczbU5MQkNU?=
 =?utf-8?B?YnI4RUFVRzloUWlXbXNXWUY0QklRUXdhMXBkRTE4bUZybHZsWDBaVkVDb1pn?=
 =?utf-8?B?eVJDSUVrZll6TG0zYWtKeGpBNkNJOUdkR0ZQcjcrTHpuNmswMVo3RlB6WG1q?=
 =?utf-8?B?QUVSNVYwQTBOejIzaWRHdEdvNXpWRFZmMSt5bEdmaldvNE1TSy9TUmZzY1NT?=
 =?utf-8?B?N2htUU81WnFRNTBLNHd4blk4ck5BdDdlWlMwTFJLVlREMGYxRFRzcEIyVUNE?=
 =?utf-8?B?YUhYQjBkY2VxRzFGV2V2cDFxVnRLdzZ6S1c2eWJub251U1VmcTR4eFNDVURh?=
 =?utf-8?B?T3BSYnhkc0ZRNkYvYnBxS21qUjVDUHhRWjNZUkZrMlp0TnQyRVllQ0lKK1RZ?=
 =?utf-8?B?RUp6OFN4blNJazdPdTZRMG1OZzNkcXZEQU5hL01SbXJoaTQ0bXdUQUV0SDZx?=
 =?utf-8?B?L1FmVEtwSTc2VGdGL29XbVF4Wk9DZVZGdDRDZVEwRlhxNHZDSDVjVE1QbEJM?=
 =?utf-8?B?NEt6cFVsMWZqZVFCaG1zYk8yRHRoblFCTnI0d2Vqb25UeFhDZVIrMUxyN1lu?=
 =?utf-8?B?QlFxRnkzSG5DZSsxNEk1U0RWS2dxZWt5bWR6elZhbEVra09CajJQVDhXM0gy?=
 =?utf-8?B?aU5yNGd5cTNCWnl5MGJBMFpNaUluNXBneGFPVTBlZU4rZHZERnh0R1pKYmpT?=
 =?utf-8?B?RkE1ODJ2b3NTdU9qLytWYVFxaUt1ei9wRk13UHI5bThzNkJodzdjNFM2ckcx?=
 =?utf-8?B?bURSOXY1Q09ObXc1MUg0RmhGTjNNV2NLbjJ4dVdKbzZSTHg3QzA2Y0JHckpM?=
 =?utf-8?B?V3RObnJ1K0JnVnFyUy9wVzY5WENFNjMyOEE0RlZ2NHJsaEZuRmVsQ214V3pL?=
 =?utf-8?B?WGE0ckdnZVFSdzFSNnJnajhyU2MrSkRWZURVTHRBTVVnRGk5YnhpblROa0xZ?=
 =?utf-8?B?K1JiUWFQS2J6alFvT0VDUGRMYzcyaHluMUl3MjQwUDNxTFN4K2tROUdpem5I?=
 =?utf-8?B?bzE2dUlpdkprelJBWUloTDdhWkRLU0RXN1JsMWZWUnUvdXpEbStzN0gzcXha?=
 =?utf-8?B?Q04zYUlJckNMd1N5UHJiYTE4OGt2NWVYRVQ2QmdvUnpacGpZdm4xTXlHRkJ5?=
 =?utf-8?B?dTNYdWJNTGpjb3RyVkU2Y0JsYzQwUnZ4Q3dOZEZzNEl6enhINVNPT3VTMU1B?=
 =?utf-8?B?cmw2QUUvSGp2a3RsdkVpVSthbGZQS3IyakVJYnRDNzVaQkxBOHBEdDgyeUZp?=
 =?utf-8?B?emFpZFZWRkFzU205QVhQR0txSHBMODk5VnpId3RMLzdxTFhYckpDY3FjcTRp?=
 =?utf-8?B?STUwbEFUbzJIK1loTkJBN0hCcDRUa3ExUy9PN1dhN29QYmpSU3ZrSmZzeklO?=
 =?utf-8?B?dkc3cFQwelRjNDhJYVJFN3ZIMWc5WHNkaEthdlE4Skk2QU4xVnF0dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6be83aa-507b-4dc6-41ad-08de5f1b1519
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 09:45:05.8064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XaLxbxUecQXZy3rOBF2FDPooQ7TjqJKMnmZptKoudDJAc6u+2kwpp2QrqVZZxr95jKObmrugWaX1dQV2slnJaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9399

On 28.01.26 12:28, Richard Weinberger wrote:
> Make sure that RTDM tasks terminate gracefully via rtdm_task_should_stop().
> To achieve this, enforce the correct teardown order: always terminate and
> join the thread first, and only then destroy the resources it was using.
> 
> While this change does not fix a bug, it allows us to distinguish between
> expected and unexpected task termination.

So far, the drivers used the resource teardown as "should stop" signal,
probably also for historical reasons (Xenomai 2, even RTAI was supported
this way).

But please write a more telling subject, rather than numbering the commits.

Jan

> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  kernel/drivers/net/addons/proxy.c                  | 2 +-
>  kernel/drivers/net/stack/rtcfg/rtcfg_frame.c       | 4 ++--
>  kernel/drivers/net/stack/rtmac/nomac/nomac_proto.c | 2 +-
>  kernel/drivers/net/stack/rtmac/tdma/tdma_module.c  | 4 ++--
>  kernel/drivers/net/stack/rtnet_rtpc.c              | 2 +-
>  kernel/drivers/net/stack/stack_mgr.c               | 3 ++-
>  6 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/drivers/net/addons/proxy.c b/kernel/drivers/net/addons/proxy.c
> index e9956cd33..c3e5ce1c9 100644
> --- a/kernel/drivers/net/addons/proxy.c
> +++ b/kernel/drivers/net/addons/proxy.c
> @@ -418,8 +418,8 @@ static void __exit rtnetproxy_cleanup_module(void)
>  	unregister_netdev(dev_rtnetproxy);
>  	free_netdev(dev_rtnetproxy);
>  
> -	rtdm_event_destroy(&rtnetproxy_tx_event);
>  	rtdm_task_destroy(&rtnetproxy_tx_task);
> +	rtdm_event_destroy(&rtnetproxy_tx_event);
>  
>  	/* free the non-real-time signal */
>  	rtdm_nrtsig_destroy(&rtnetproxy_rx_signal);
> diff --git a/kernel/drivers/net/stack/rtcfg/rtcfg_frame.c b/kernel/drivers/net/stack/rtcfg/rtcfg_frame.c
> index c7babb6d1..70318ad3c 100644
> --- a/kernel/drivers/net/stack/rtcfg/rtcfg_frame.c
> +++ b/kernel/drivers/net/stack/rtcfg/rtcfg_frame.c
> @@ -558,8 +558,8 @@ int __init rtcfg_init_frames(void)
>  	return 0;
>  
>  error2:
> -	rtdm_event_destroy(&rx_event);
>  	rtdm_task_destroy(&rx_task);
> +	rtdm_event_destroy(&rx_event);
>  
>  error1:
>  	rtskb_pool_release(&rtcfg_pool);
> @@ -573,8 +573,8 @@ void rtcfg_cleanup_frames(void)
>  
>  	rtdev_remove_pack(&rtcfg_packet_type);
>  
> -	rtdm_event_destroy(&rx_event);
>  	rtdm_task_destroy(&rx_task);
> +	rtdm_event_destroy(&rx_event);
>  
>  	while ((rtskb = rtskb_dequeue(&rx_queue)) != NULL) {
>  		kfree_rtskb(rtskb);
> diff --git a/kernel/drivers/net/stack/rtmac/nomac/nomac_proto.c b/kernel/drivers/net/stack/rtmac/nomac/nomac_proto.c
> index 84317697b..6cdedae2f 100644
> --- a/kernel/drivers/net/stack/rtmac/nomac/nomac_proto.c
> +++ b/kernel/drivers/net/stack/rtmac/nomac/nomac_proto.c
> @@ -127,6 +127,6 @@ int __init nomac_proto_init(void)
>  
>  void nomac_proto_cleanup(void)
>  {
> -	rtdm_event_destroy(&wakeup_sem);
>  	rtdm_task_destroy(&wrapper_task);
> +	rtdm_event_destroy(&wakeup_sem);
>  }
> diff --git a/kernel/drivers/net/stack/rtmac/tdma/tdma_module.c b/kernel/drivers/net/stack/rtmac/tdma/tdma_module.c
> index 47c66d91f..3c516d23b 100644
> --- a/kernel/drivers/net/stack/rtmac/tdma/tdma_module.c
> +++ b/kernel/drivers/net/stack/rtmac/tdma/tdma_module.c
> @@ -228,14 +228,14 @@ static int tdma_detach(struct rtnet_device *rtdev, void *priv)
>  	struct tdma_priv *tdma = (struct tdma_priv *)priv;
>  	struct tdma_job *job, *tmp;
>  
> +	rtdm_task_destroy(&tdma->worker_task);
> +
>  	rtdm_event_destroy(&tdma->sync_event);
>  	rtdm_event_destroy(&tdma->xmit_event);
>  	rtdm_event_destroy(&tdma->worker_wakeup);
>  
>  	tdma_dev_release(tdma);
>  
> -	rtdm_task_destroy(&tdma->worker_task);
> -
>  	list_for_each_entry_safe (job, tmp, &tdma->first_job->entry, entry) {
>  		if (job->id >= 0)
>  			tdma_cleanup_slot(tdma, SLOT_JOB(job));
> diff --git a/kernel/drivers/net/stack/rtnet_rtpc.c b/kernel/drivers/net/stack/rtnet_rtpc.c
> index fe60209f2..16dd84979 100644
> --- a/kernel/drivers/net/stack/rtnet_rtpc.c
> +++ b/kernel/drivers/net/stack/rtnet_rtpc.c
> @@ -251,8 +251,8 @@ int __init rtpc_init(void)
>  
>  void rtpc_cleanup(void)
>  {
> -	rtdm_event_destroy(&dispatch_event);
>  	rtdm_task_destroy(&dispatch_task);
> +	rtdm_event_destroy(&dispatch_event);
>  	rtdm_nrtsig_destroy(&rtpc_nrt_signal);
>  }
>  
> diff --git a/kernel/drivers/net/stack/stack_mgr.c b/kernel/drivers/net/stack/stack_mgr.c
> index f4f8c7fff..82e8412dc 100644
> --- a/kernel/drivers/net/stack/stack_mgr.c
> +++ b/kernel/drivers/net/stack/stack_mgr.c
> @@ -257,6 +257,7 @@ int rt_stack_mgr_init(struct rtnet_mgr *mgr)
>   */
>  void rt_stack_mgr_delete(struct rtnet_mgr *mgr)
>  {
> -	rtdm_event_destroy(&mgr->event);
> +
>  	rtdm_task_destroy(&mgr->task);
> +	rtdm_event_destroy(&mgr->event);
>  }


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
