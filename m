Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2086.outbound.protection.outlook.com [40.107.103.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1943B1917C8
	for <xenomai@lists.linux.dev>; Fri, 30 Aug 2024 12:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725019234; cv=fail; b=Jxsvpyig51tWr6KNNiHzncZ9blVY8JkDaiQe/d3tjJENhaMFnsemU6mZK1ckM4GVdoBmS7ss6jRJ7IFk/fRnjQEc2RIxys3iiPEEmOs0vbeIvZ7+0FqBYHb0Zl1OdMhjR38JY7rpGu/FQf/Is/bP6vPQBkOa4MUmm31iRq9kOtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725019234; c=relaxed/simple;
	bh=byjrMfJRaO4JCo6q8hD08AHgfa5JFmNuVVFy2niHpnI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eu1veN5ZhTaEUlddhR/JgX2v3ignFK4q01Ih9Pc/ChiabzNkwz0rSarOI+N6detGmXG+he1Qh61ZjyhcEBk9tcwFW0N9v6Zy1yzUiDn8Ca3eZ2MvkqeTPmmiRA0F6aPBw0t+BW03M5fv251YH8bXcdX5/6IPpIt+bAkJFzzaDi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Wn+t08Mq; arc=fail smtp.client-ip=40.107.103.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Wn+t08Mq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QniNwWR53UUnOX5EfSjI7qeiLKJWzTOS5tGteX7yrUO+Jo6LIS6dcPkuJmxKP2E3dMXzmPITGmkMYunsRyjMjlS1dfxn5t/2ywibH0zYyljJKd7IawDs4smCY8xdyqEcc1nrBfPVjQj5OC433YfuRBvDRtCg3sKvKUml/LtbVxQq3wu3546fVdNXPMIN9AADAxEtEUQWLs92s213jrIFNubtDB+Eh4nIhLZau2SabKEu6gUPidP3zoeIOE2d992sdALHCkxzF+KaHoKQv7lXQJmLlOKl0bAwrei1kDS5tGF1FUBQFdT/rarPa+n8lMLnKhpJFBe76cXxIdS2klYs4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3I+2QXEI8eFGFJsiymbWZmJUYOVb4uA1j7CxAdThEaQ=;
 b=ZaESAGvdolUAfTr/AhNbTenM2o2DW42THyrfJb/FQEQSrnSwcvI2MxRSGSUnKVZoazE1PnzI8uCL3U13sYwZ6p0V61z4ezmB5/yLv08TD+V77/X4fm4+JedZFd8kmM4t0xkOJ+fx3vsaTsf27Bw6HHvfWaz0xTqdWiia+47JWjZfia9bQfWuOcVSEg0FFhlVvqPswOiPNdXai7f0m9KXblq8ecSNDCEf5MWdQ71UVTjqgi5aH8jOk9rL/crdMYcljt0qFhMCJmIBf4qtRbFlwMdIpyO0mgt0RVMB3TWUVBd351Y6lLlgKGaUDI6vKDOyGqu3KTEZMY++PRMePuZUaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3I+2QXEI8eFGFJsiymbWZmJUYOVb4uA1j7CxAdThEaQ=;
 b=Wn+t08Mq9VMw9brAqVAt6HAzwfGclD/QnH6z11G7TgUcno+9oJm9zWkMSktW5TiJepzmNeNCPcjX8tfvTWlaGECoF4d6KYQSrUixLnOJruPU4t1iCBDwGvEHjjNldBCwHwSqNQj8u/nXlyIq+ScOl0sUI+fczqiO/aG8PUnQ0KKtM2X2nAAYYktu7cCaCdBJ+IGfQ6gltoGu6FvESZkk4pk6YZCxgKtsoD/TplAKUhyuXeU4bsBlGCxm/UAeK3c2aOnAk8qyapguXMP/kFPzB07bWBghb8qN6n7msBxo5Yc6/1zX+bZxR09pa9keT+QSmUadn1QsGqQQwq5VgPfIuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB9113.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:41a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Fri, 30 Aug
 2024 12:00:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 12:00:27 +0000
Message-ID: <6af7ce37-f6a5-44f1-9f48-18120baa831e@siemens.com>
Date: Fri, 30 Aug 2024 14:00:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Process stuck in cobalt_monitor_enter
To: "Mauro S." <mau.salvi@yahoo.com>, Xenomai <xenomai@lists.linux.dev>
References: <9d5bb262-0646-451e-a5af-82c0473a3003.ref@yahoo.com>
 <CADBp9xn_Gcu9TCaiZHZvo3hwT4JzzTxE4ueMH3dt81KJWF8qOA@mail.gmail.com>
 <67ce5b0a-1013-4ab2-9617-0723c0dc0809@siemens.com>
 <d1b99e9a-5bc6-414c-9f5d-972134f60c31@yahoo.com>
 <bea3518e-5d72-4a86-a5b9-ac71a59c235b@siemens.com>
 <e5efbf9d-9054-46d3-8deb-aa321146068e@yahoo.com>
 <1b8ec985-8ae2-4bd2-8964-23f97cac7ba4@siemens.com>
 <CADBp9xn4OGi99e57phnv58NtCbxzO62bhrkJhSns-FUbbt4_pg@mail.gmail.com>
 <6fb4564d-3d39-4be1-838c-423a865638b9@siemens.com>
 <2d41fc43-db7d-4070-a769-bb37083cb414@siemens.com>
 <2e779a4e-ce60-4487-9dbd-7d40726b2d9e@yahoo.com>
 <0d9b6cd5-4b95-4b28-bf06-9e98d7d6310d@yahoo.com>
 <46a1ceb0-0684-4bb8-bcd3-5f71456c2d10@siemens.com>
 <0363a40f-ac3a-4024-a9bb-e37841625cb8@yahoo.com>
 <7707fef0-b164-4a79-913d-6ddcce6600d5@yahoo.com>
 <4e5fe5f2-44cb-4578-b47a-89980173eac9@yahoo.com>
 <e48a247d-db37-4c78-ae35-0d1a35646aeb@siemens.com>
 <f8361e27-2fed-4aa4-9348-bdc64760f7e5@yahoo.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <f8361e27-2fed-4aa4-9348-bdc64760f7e5@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB9113:EE_
X-MS-Office365-Filtering-Correlation-Id: e569a552-d994-4762-8e35-08dcc8eb569c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zng0aVJPOXl6S280ejRmTGVheWROcnMyOU8wTm5zdlRDZG5GbldpLy9ubmps?=
 =?utf-8?B?QUdKL3p6bTNoYzJpdGl0THhaSG1IbXYzVHc2SkI4OVZZMXVGa0lpU3AxVE1O?=
 =?utf-8?B?cHNocGd3VzY1RldOclBiSllZK0R0Z3lhbUt6ZlJLUGlnRXZGTjVWaU84RVF2?=
 =?utf-8?B?MW1ObXNjTUpGaGpybnV1YjlHSzRMOGJXbFlOSEw3VitNQXVYUzBtYlZPOUND?=
 =?utf-8?B?aURuNlBZdmNoMmxuVDYwMFpYSmhGYjdpMlRzYlBKSmg1ZHdtUjBQR0xPa1lO?=
 =?utf-8?B?SkQySkxFZXp6U3QrZ3F4Q1M0d3kzWkxKZVl0cDdqSGtZbXc0WE9DY0NPbDdR?=
 =?utf-8?B?OEllL3A5TDFCZGdBb1g3VnNra1FnaG5QTVBjeEU2MFhjeVZEbytkc2lzUy9a?=
 =?utf-8?B?eVBsMDIxRVBQdytuZzI1dzQzRTE1emk4MkZyeS9IYXR4Lzk2cWNVQURWSDFM?=
 =?utf-8?B?V0lyK2h4R1lPZHgvdzRweGJibWphK1Evckk5ZXZ6c251ak5HaHhHeGRHdGlC?=
 =?utf-8?B?bWZTVjg1ME1IN3l3MnkxK0R5Q1NIOGpEenF1b3hCSjJpYUtxTWY1ZVhaWlBE?=
 =?utf-8?B?WTFMNytHMFdrZjUvMkZRV3J3WjE4UWlTY0NhQzNuZHMxelROSi9OS0IxYStX?=
 =?utf-8?B?bmFaNHpmVVUrejBuZ0h6Z09YRjRjVGlZdkw0NWxSYzNBeUxvSHJjMlM3dVEr?=
 =?utf-8?B?eWh3Sjk1ZS82ZkdJYXRMN0Y4c0JYb3lPdDJIWDBsS0dWazJOSXkvZ0xxRlZH?=
 =?utf-8?B?WCsvUmI0YVZrK3cxdThTMEl5dG1WQTZ0ZEJFKzBKV1k5eElvZllkYndiZ0JT?=
 =?utf-8?B?L0h5K1pxQnFMWUJJVFdtbnpWTEN6NmxmUUswek1tcnF2LzMzNmRNS04yQmtz?=
 =?utf-8?B?ZWlvejlHTWx4Q3dxU081d2o3TlU0b2prTjRNVVFGa2F1MkNmdk5wZXFjUm0z?=
 =?utf-8?B?SGhTT0w0MDZDcy83TjVOWXJ4RjBqK2NoclhBZFRvRnY3YzZQUkJLU0RLaEZZ?=
 =?utf-8?B?RWNhMkFnenlzWGxTeFUxcTZiVWhDU2pWMTJCYjJHS2hzbDlUenRUT0dnTkI5?=
 =?utf-8?B?K1Z6dXBpZStJaFRVTUNVaG5sUFEzQnJHQ1doenRvcE5jaGh3R09FdWRZdGJr?=
 =?utf-8?B?ZEU5dGROVWtDZ1VtVkdFQ3c4RmhNYm1lZlNkM1RHMmpBMjNyZVFOMlFKYTJE?=
 =?utf-8?B?S2prZnNUQWJzWGNldFV0RW83QUNEZW9pamVldGxhbVdPYVF6TEExWlNlRy9x?=
 =?utf-8?B?ZVlNL2g1T0NmOG9VRHpUZFAvalRKOWdpdmNTVXlwbkx2TjRtV080Nk5WSXMz?=
 =?utf-8?B?cWhocG8xOCtwbmJ1b1NEVUsyWmpBM3VuNWVnZExKZ0ZrL3VUM1FxaWhlK1lZ?=
 =?utf-8?B?b3ZTWTd2TDNNcGVrZEVIVmpMNHlKZ09FaUtWMG50MkNTWXFaVVk0cWY0SU1w?=
 =?utf-8?B?aCt6MnkwaHJzVXg2M2ZZRVAyU1VpamwvdUpZRlpLbjBpWFJDTGF0UjNST0hC?=
 =?utf-8?B?SENuTzdsanQ5cU1MNGl5VzNLZWk5eTdiV1pOZk13Ry9KeEc1MWNKNlhLb0lh?=
 =?utf-8?B?TGFIMHlnb1NrYWR4VDI2cTdML080dXdOQWU1bUMwNHN0eW1idjF4WXkwc05S?=
 =?utf-8?B?Q1lRSlBtaW5LQU8ySEkrSEhOSlE1MjdoZVVTd2FtdzBrT3dKTWYweE96TjZN?=
 =?utf-8?B?RjljMHBjUW1tN2ZTVFViZWNib2x3MEZ2Um54YmhYa1lUdDJyNEh2SkV1WmRi?=
 =?utf-8?B?SEFtWC9XNUw5YzhxY0xFTUlST0RiYU5DOFJYb0k3TkNuTmwyOTJzNC9pVVY3?=
 =?utf-8?B?R21qL3dDM0lmNmZYcWFQQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFNCUXV3RVc3YzhHWWFhMWxUZXNZNE5QMHBXeWVQQWRHaXUvMkZ1eStaV21Q?=
 =?utf-8?B?Qm92OXYyc0JUWHYxWDQrSUdkdEhMSDdKYmhNbW9QMVpMN2d6V1RvSW9Mbm5F?=
 =?utf-8?B?elVRK0lPTi9WTHo5NFF3dUpld1VQejVUV3hsQmp6am1lYzlLV3JITUdteDcx?=
 =?utf-8?B?MHA0TmFJejBzSS9uclY3ZHNNK1RuK2pzL1pVZW9ESG1OWkY1VFA0S1pMOEVK?=
 =?utf-8?B?MjZ4ekxCSHphYk94OGN5S3hJUDA4N3dpTTdQMzFTOFN5QlZGK29URXVERGpV?=
 =?utf-8?B?TFppU0xwYklZUTBpZXhHQm11ZTh4TnBwTmkzejZSWTlCTmZDSlZSUlNYU1A1?=
 =?utf-8?B?dFZ6Rm1PSHhIUHBnbXVMY0dKTE81S0tmd3ZHalNLWXlpQmJFSmwwcTBpKzgv?=
 =?utf-8?B?SUhoeDhhMG1tWTZ3MVcrK0ZHMmtyV2wrdlhBMHg3d0FmOFJrb1ZtQndwais2?=
 =?utf-8?B?QURVVkQyYWZ3bjkzeGxUVC81VS82WWg0UzZRdnEzZ25lcHFTaGNkR1pnNm9n?=
 =?utf-8?B?aHhtYzJQNi96R3JkbEdqMFpNbTdiMm1WZHZBbld1d3ozQk8vQjBRZlJKUSth?=
 =?utf-8?B?dmp4N1RpYUxZTDRqWHNLWnBVTmZ5NXVQQ2had2dYbmhGSzNtT3JlODQvMnFD?=
 =?utf-8?B?L3ZOUkZMdDZyemw5WDcyTUxMVTY1NEF5eS9QNExTR0tZaGhFRmpySWJydmJE?=
 =?utf-8?B?b1Y0dVFxaUNGQ1hKY1F4Z00ra3BUQ2gzZ282aDdPRytuVUFqN3A4UWRyemtX?=
 =?utf-8?B?SzhXZzc1aTZVSkRmSlZQOXVhcDRWQkQ2NUNjL0hkL2JYRnBzeHArbGNuaGhy?=
 =?utf-8?B?VHh3dEFzdTFqUGJPU2c3eXlMSHhFdmxOQ0habTVLVFdYWFV5dFBNeE1Gekc3?=
 =?utf-8?B?UnFrQUNUZERYV1hyQkd0WlJDRTFlSjZFN1NYRk9wbU1iZTZHeTU4T0V3RGx0?=
 =?utf-8?B?bmp1aXdxQ0ZDb0l6Ry84UGxMUjBBL1NVQVdtbzRvQ0xHZks1SEo3TGx0SjZE?=
 =?utf-8?B?RVZDQlhKS2NQWVR4ZEU1SDdYQnFycGxZcEU5SXdGNlFNUU9VUWRsOGViMGNr?=
 =?utf-8?B?YXFuSzV3SFVIVEhIT2YrUHVKQ0J5UjhOakpuMDFIT2tZckwxWXpHZFRpRmVh?=
 =?utf-8?B?WUl2RVpidWEvRS9wMnJTbkw5UHNIRFBIWVZSdDhOUXc1aUpZdDg2aFVlOU1Q?=
 =?utf-8?B?WGRCaTRyeEluRXQ2L1FIaDZjMjlvSGVrbGpVL2xnYU1wVS9XOUowcmtrQ25G?=
 =?utf-8?B?ZEpKNytabGZJUlVkMDRYeURYM3B1WUpLVTQ2cGgzMERKZE5zczI1MlpydXBj?=
 =?utf-8?B?VzNicFZkdlJjZ3VLQW9mTVMvQVhKejg0MUQvRUZERFJzMFpRNnRBODM1S1BD?=
 =?utf-8?B?TkMxcUozVThTdGU3U2tEcTNXa053by90TXhLVm9ONFBRMWFERGhRc1dRZFNC?=
 =?utf-8?B?ekZsSzUwYmF0K2FXVkpvQlFWazdwdzlHSDFaWUVVb0ZVR0pUNFZFclBvSWN6?=
 =?utf-8?B?V1VpdFRFOUJrWjY1c25yRnZndFBPR24wL2RDTC80RXpCTVZWbjdwV0FYOWxa?=
 =?utf-8?B?VkhnREtGaGIxS3BWVVk2ekxPRzl0dzZWdXRuTE9JbUpmSWZySnhWYUVoQlov?=
 =?utf-8?B?QWVSY1A2ZnA1L2k5QzdxNXBlRGNBYTBxdFo3cEF5YjBGQldrQVNKNkFjQmRH?=
 =?utf-8?B?MXZNMlM5d3JyRWNNTHlrQXhNTk5JWlByRTRRSkJNM1FCK0daTE02SExlRmhO?=
 =?utf-8?B?VERTVGZqN3REd0haTUFKaVQ2SGFUUWlGOHB1TThGZWVZZ3k2U3lNaGU1YmpL?=
 =?utf-8?B?eDJpWVUvNm1jMXhhQzNvTk5xbk93ZEMxWnU5U0tCaEJKb2N6eHpRTEppNFk5?=
 =?utf-8?B?bjhtL1hmWXVJdXEyUURBTERNbmRNWE4zTHVMcklrTnNlTXcvQ0k0VmF3T2FV?=
 =?utf-8?B?VDd4M0pmNFY3elp4YTlVUnZrR1F0czRvbmV5bUhkNkVvVytEdzVRMGtCaE9B?=
 =?utf-8?B?eWlnVzJ6ZTM0TjVPUDNyQ09XNnB3ZE93TFVXbUsrQXRaVC9tS0FSbmJSYTJ0?=
 =?utf-8?B?OC9rRXZWWDJTanIxZ0RRd2M5bERiT0VoU2FWZkxuYWVCUStDRjlvVlRucjJj?=
 =?utf-8?B?UXlsZmYreDY4RURRSmpOaFRZWEYwWkdCSldWQS9BNE0zSWdORGxCVGRvbEtN?=
 =?utf-8?B?S3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e569a552-d994-4762-8e35-08dcc8eb569c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 12:00:27.6639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7LXhc9nqjqJqarwQhI4Jzy2LYMQvGf+oTraRBjOdUDsVIyFBSMGOT0MHiFgNkvD2itoi+DELZVjlJTTBeyXYxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB9113

On 28.08.24 16:32, Mauro S. wrote:
> On 28/08/24 15:40, Jan Kiszka wrote:
>> On 28.08.24 15:05, Mauro S. wrote:
>>> Hi,
>>>
>>> I'm back after doing more tests also on real hardware.
>>>
>>> Here is a summary:
>>> - custom image: kernel 5.4.255 + xenomai 3.2.3, built by Yocto Dunfell
>>> (GCC 9.5.0)
>>> - xenomai-image: kernel 5.4.228 (and its initrd.img) + xenomai 3.2.4,
>>> built by isar in xenomai image (GCC 12.2.0)
>>>
>>> I confirm that the problem shows only with my own kernel + rootfs, both
>>> on QEMU and on real hardware.
>>> Other combinations:
>>> - xenomai-image kernel (and its initrd.img) + xenomai-image rootfs
>>> - xenomai-image kernel (and its initrd.img) + my rootfs
>>> - my kernel + xenomai-image rootfs
>>> don't show the problem, both on QEMU and on real hardware.
>>>
>>> Furthermore, I compiled the xenomai-image kernel forcing the 5.4.255
>>> version and using my defconfig: the kernel became identical to mine,
>>> then I expected to see the problem using this kernel with my rootfs. But
>>> -surprise- the problem does NOT show.
>>>
>>> xenomai-image uses xenomai 3.2.4, but I don't see relevant changes
>>> between 3.2.4 and 3.2.3 (mine) in code linked into kernel sources.
>>> Then, could really the problem be triggered by the GCC compiler version
>>> used to build the kernel OR the rootfs?
>>> Actually, my kernel with the xenomai-image rootfs does not show the
>>> problem, then seems that the problem shows only when using GCC 9.5.0 on
>>> both sides.
>>>
>>> Or is it a dormant bug that some versions of GCC hide?
>>>
>>
>> One option. Did you already try switching to a different, likely newer
>> toolchain while keeping the rest?
>>
> 
> No, for the moment: I should port the whole custom meta layer (that
> contains kernel and xenomai recipes) to a recent Yocto version. This
> means that also other userspace components will change: would that
> influence our testing?
> 
>> But it could also be that the compiler brings in some noise to a rather
>> narrow race window, widening it so that it becomes much more likely to
>> be hit.
>>
>>> I can share with you my rootfs and my kernel and the QEMU startup args,
>>> or other things that could help you, and I'm open to suggestions about
>>> other tests to do.
>>
>> Problem may be that we will have to be able to reproduce variations of
>> both in order to try out instrumentations.
> 
> Right, I overlooked this aspect.
> 
>>
>> I'm also still puzzled that it takes both your self-built kernel and
>> userland to trigger the issue. We only have similar but not identical
>> code for both when it comes to xnsync_fast_*. Hmm, maybe it is worth to
>> compare the disassembly of lib/cobalt/internal.o...
> 
> Yes, this really puzzles me too.
> Attached the disassembly (obtained with objdump -dSlf) of the two
> libcobalt.so.2.0.0, with the two libraries too.
> 

There seems to be a difference between the two toolchains in the
selected TLS models. Could you check for both CONFIG_XENO_TLS_MODEL in
include/xeno_config.h?

Jan

-- 
Siemens AG, Technology
Linux Expert Center

