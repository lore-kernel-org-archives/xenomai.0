Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012004.outbound.protection.outlook.com [52.101.66.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F8B34B693
	for <xenomai@lists.linux.dev>; Thu,  6 Nov 2025 16:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445703; cv=fail; b=e9wjqaNJmlx9YfcN0xmp/AyK0kZyGzX03faFWm7wB44CcgZtT0cSqMUwOtl46+CGitNshOogB25IQy+sY0WeIY91ZoewGv+1JSUfdc1ATU1P8REkRaLLZf6J9h3UJfH+/zkKk01ChuH11FJyyXwCuOlBgg45DMtQPLmfX0aRV2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445703; c=relaxed/simple;
	bh=jAH1J4X0KabnLa64/9U0ynWHPiKBad+SgWzIWscojNE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oB+hrkruVSCkrHYiFeuUcSTyFF4XQ0kciMkCgRlZBR9P+5q01DncEWh0waBYqRR3B/R0bdJWlWw7NRlhD9XBeELLhQx0nYaet1hyYUlP4Dq/U1loTIfbMu1ucetiare2t+r19ww0Zk+X7C4VjuRFxICq+Zdqj4YQzAgy4QrYuek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=gabUny3s; arc=fail smtp.client-ip=52.101.66.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="gabUny3s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dNYBllXisl/fH+Xpe7YykPRDBt6DmcMFFt/s6Z6t3xi201uPPDBHDtlUM3qxE+7dWD45NPQYjVYrsrwSDc8BAHxAPEnTaohLS59ahalV9CG/intbd60TXUSXI0sK6JJQH41Pq+t+lPHJSp7J4++PJ4PZnyEafAYe99cOSj0cTDyJbM+GuW+5QRCi+dTFU12OtIOJu7KABxM2NsqF7dHKO7KRv+lUgE49JQCwj+f7aM6uG9mgDpb1dyX8gls52JBjNBCo3I4TTCaIMVwE9yQhEG6hUQVUUsV7pG/2CPJPaCZF+SQrE/VHgdYsa62f1Lk4gSEbRTeV28L2qS9udmaFiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32gP2GDtFp0JgJO04Btopt2LwUCg9/aR9pTNNhgIE/Q=;
 b=oLEhrVmjWuOtB0BXMVeEzqBOPS7iO1nbZX5pUJn3vxWO7mt9ybj/lLsZN45XJNDTp/W8MnTEZGNv34W/bqMMciR/RzTluOYQlnqQnmVLVme//30666eoyTN9c7e2Dj9cV12gNLSaqrgK62IDv3Fd4fYWx8Ya4A6ZwXXkKQv0CBGuXLnSYRfn+jo3YYaw5ZcW5LO/woIboMQ10AFFwFzLWBmme0WA6XkRZ+hmFoVTYlI4mNIIfKT5xoEj/D/0wfMBeIvdiJbanX3//PdIvXqohIzCMEa7+QO8pRZbdToBDX5wHHfyOQDYJbFuNdEo0tUdISOBIccQEcnFtY/vOrltVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32gP2GDtFp0JgJO04Btopt2LwUCg9/aR9pTNNhgIE/Q=;
 b=gabUny3saOLG3mwaxynDqf5Ltc+Ohdv5oto5v4nproK9SW4e7tRPQNSI+TGW/Tc1uK73k/6unKDfxPWNO84XIARu1wgr5Zj/M0Ln/fjLqURfVulyycGMR9wblVUZoDOSW8reZmLNkX+RsdJC5HJKKsZVgsySLtdMvPgF01u7cuHwnNzApmuKQN0SxcRvOEnD20FzH/NH8+qY1Hxw9eBr9EWR2ZYh8itmsLvJSnFpOZtW7Ym29A6OWqUCJMd6labf9zUIy/HlLiKFggCKujZ2YGD3nm3zuzM7pfbA1cqH2G/7hk+FzCrTVLVGvEsANHa1d0a3VJIlk0n/izED+34otg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by FRWPR10MB9210.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:d10:19c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 16:13:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9275.015; Thu, 6 Nov 2025
 16:13:44 +0000
Message-ID: <bd0412b9-fe0f-483f-b5d9-efc63dceef29@siemens.com>
Date: Thu, 6 Nov 2025 17:13:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images] ci: disable tmpfiles clean timer
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
References: <20251106143432.1185102-1-tobias.schaffner@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251106143432.1185102-1-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0387.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|FRWPR10MB9210:EE_
X-MS-Office365-Filtering-Correlation-Id: 87bafdd4-1216-4089-45ff-08de1d4f7594
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWlyblloN3krT0dLQ0NVTTlqRnI3Z2JoUkZiVG9iMDRoUWdPWStLbnRMTDJR?=
 =?utf-8?B?ajdmTHIyQ09OZXpUYncxeVJKdEk4SEt3d0k0bDJhZVF1TnRLNEpCY3hwYXV4?=
 =?utf-8?B?Z0lkTFE3SEtYNU5jZmtCQlBXQW1pZnhzSzA4NFUzVmtweXBBUVRmRjF6ZEVD?=
 =?utf-8?B?U3diTktlUWpqNGcyM1dqVXZUMVY4WHhTbGhFTk11eVR2M213QkJIZlRKd1B6?=
 =?utf-8?B?SmZ1U3crQWhWUzNFV2FEQmxLdGNkd3BIS0l0MFQ4VXg0NUZTeTBGcTBCREhO?=
 =?utf-8?B?OVBEUWlVVVF4UmdCNVA2cnJDaXVaTnl3WE9NOE5SWVNTL2kwdzd4REp0dmw2?=
 =?utf-8?B?c1AxMVBUMkdBNUxUQ0djOFNaYWFRNVdyaUlEellPaXRuU244R01NT3RKcEc0?=
 =?utf-8?B?WWpqeTBkL3d1ZC9rTmpWSFVqdHNicE9WaktwVXMyNHJ2Z0pNcWdHMkpubDJ4?=
 =?utf-8?B?ejVmaUFYTXhPZjRqbFZZbWpQYU5Mby9tOTBCQ1Bsb0NDSEp1V0JzZXNtdHND?=
 =?utf-8?B?NVhWN3FoR213alRUT0hNY2JIWUwrVE9oREtqUnBSSU9zVWNVWGV1QkdnWkVS?=
 =?utf-8?B?ZkR2ZlRoMkdFeFdkRWw2UDZGVzllOXlmWGoyQXlISTZLNjRzUDcvTXgvWFlS?=
 =?utf-8?B?enpZTlhBMUt0Q2NSTnArK0UwSWQ4Q2tZZDhIRFlZandCeVFEcWNodDBQc3Uw?=
 =?utf-8?B?RHh4OHVrZTZBcXlzR0pSeldtUEVYajlVMTZ5bGEzNmRsdTRMbHNZNW0wMy9W?=
 =?utf-8?B?TS94ZzNYZk1Ic0orMEgwV2VoOXdaQWpZWU9DT1hVWEgwZDRjRDZQYzd1QzFo?=
 =?utf-8?B?TzhQZGJsSTJEYk15cnZCUzRRbXVUM0k5U05QSGphaGZlMGVsNm9KNkFGOFVY?=
 =?utf-8?B?clh2NUtKaGtyaGJtRFhsR29GUDIvMVVOOVMxZnBOZW11UlB3UHBWbExXdlF5?=
 =?utf-8?B?d1NTNUF6YkRKbVJBUjJBL3lWVzdFVG51ZjlaSjQ2aDRFcVJ2T043OWtuOGhZ?=
 =?utf-8?B?cUFpSU9SdU9seS9MYTVRSmdmZ1QwUmZGYWt3YktZcU1vSG9iL3VHc1Y2bmtE?=
 =?utf-8?B?cUZzL3ZzRk5IbjJSYkFyN3IvTnVnSnNhbmF0UWs3cDBLU01ONWMxbnNCNTlD?=
 =?utf-8?B?eUMrU1VJaDZuZGpnYi9JemxmUGpCQmF3VFFYRnJTZlNGRVd2SlY4SGcwWFJj?=
 =?utf-8?B?Wmg0OWJhcExJa2NEdWtnR09qSjB2WUY3dWczMkFkL2hOOEZCTzUvNVpOUHlU?=
 =?utf-8?B?TTd3Z3NtTUEvdmluVjg1RHdCdHpJRVVPZnNXL05hbTcvL3VtMUlqMEpoWlNp?=
 =?utf-8?B?QnBSUE9mVGdEWEZsbHRuU0FKZW40bStKaWxORUZKVEwxSm04Rm5ZaDhobzQr?=
 =?utf-8?B?WWRRK3lWYlF4RXMxK2x0YldPclFGOTR5YkRIZmt5Y21yUHBWS0lIU0xIeHRv?=
 =?utf-8?B?WDZBaUFQZlFPd3JyVmV2SzJ6eXNCb05Ec3ZxREsrSFBUcHJ4WStaSU9SVG40?=
 =?utf-8?B?Y0RuUUYwdTU2WXNNYU96TWxqTmlMWkdscDI0N1VkS21vak1QMFJwNFhReUoy?=
 =?utf-8?B?QW9MdHVHenk1Qm12bHk3ZzZvZ1lWT3BDejB3cEpOaHltWUVweUh3aWM2dmNS?=
 =?utf-8?B?K1Z2OCtmL2tCTmxRYXRkUnJwZE9oSHg1TW9udGFqMVZWQy9aUExYWlY4Mmxx?=
 =?utf-8?B?bzg2NzZqY2lxY3NjLzJzbVR1aWtDSTllM0dMVDhoSWN2TTRXTURrZWJoWEVD?=
 =?utf-8?B?eE1LaDltb1I5cjZCbEREVTRDQldOUTlhaEZsZHBWL0w4Mm9MWTg2cUdxR3Jr?=
 =?utf-8?B?aFczQm1ET0Q4UE9IaWU5NE9zWVdTdlpLYlZPZjV3UzFRWUR0VHFtSWpXZzc1?=
 =?utf-8?B?eXh0WXZzbFozRUwvU0RZOHlIcGQ2Um9MdFhBTGYreVRqV3g1ZlVzalEwNzcv?=
 =?utf-8?Q?G6HtF3x69mwyrMAX3yz5Blb1dXuNyLbc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFluNnBkQnFaa2wvdUIyL0prTHU1bkRYRWIybFkwMkw4eFhWaFMrbHpUTldz?=
 =?utf-8?B?TjFnUk5nK2VMWWI0LzlDeEJYOWRWMVBUMlliT2hBN3JSZllkK2FRNWRnRTcy?=
 =?utf-8?B?SXJ6OE9XTDRPL2FjV1kvQlNPeFd4VEltTGs2YWhEZU9WS0dWYzIyUUs3TXR5?=
 =?utf-8?B?c1hWNHhmcEY1MUFrYStWYnh3YlRweHlza3IzZkxjV1lpYWd6MFJlZzN0aG1H?=
 =?utf-8?B?eEp2MEZaREErdUVSSFhZMUtMdktNSnlHWEtkQm44dUVKNmkrRWJkMHljTE9M?=
 =?utf-8?B?Z2R3SHpJV1NGT285V3dVNUhzcmMraTJocUFLS01oTCtISk1Mc0JRUTRabEJk?=
 =?utf-8?B?NnhwVUF3Z1h2eW5yWnhYUExJNVNHVUU5R21ld3pJM3FWdnFaTXBPYmlYRFNT?=
 =?utf-8?B?ZERWVCthdktGZ3JLajNuSElRbW9WcmFEN2cyU2VxcGt5NXZTODkxTnMyMEtv?=
 =?utf-8?B?VnYxWlhrZzUyOU02Snl0K1BWVXltd0grb2VHRnJZcDBRY2htLzVacGFGenBY?=
 =?utf-8?B?RjBpcFNtMVdhOVZ0UUNncjhhWU5JYThJbGNPeE9Ic0Q5QXlqUis1UmZOQnow?=
 =?utf-8?B?Wk9JbWU1MVJMMm1ITElLampJWXBZRzVycVBKMkg2OTdrUml1UEZMM2xMTWxa?=
 =?utf-8?B?ZUxMa1Z5OWlwY1BBTW1WNDBLMitEMDBQWG1QYWJlMnRvb2JkYXErbU5WN3JO?=
 =?utf-8?B?Nk1GVVFhNmpiTDRTT1paclU4NjE1aVIwL09uZDRoT251aFZTNGtiRXBGdUlQ?=
 =?utf-8?B?dmJUMlBzN3YySG85YUN6VUJEbXhXeDZvMWtsK3hsMDJrL0FyM096eDVGMUtq?=
 =?utf-8?B?Znl4bjEvUnI2SVFBc2JqUDQzeWU0NFozenlQRDE3RTNzQ3g2NjhJMWFiT1Ew?=
 =?utf-8?B?TlJhNCtidzZiaEZVOGNtdHJ6YUFrZDJlSDg0RE9pZXYydEVma1E0T1NGdHk5?=
 =?utf-8?B?ZGd0cFJ1NzRUeE1YRmZkbmE0RE1xVlJ0QXBsQng2Ukl5UFl3bFBWb2g1UHln?=
 =?utf-8?B?MEQ4OGRuYnQrVGlFMmhrU2ozV2dHZy9NMDlIaDU3cmh6Mk9lV2IzWmU0TlBN?=
 =?utf-8?B?Tk9mNHdIb2g3OWlhcjVQWHBsTHFWbWp6Q1NpcW9SS2UrNXhsMCtkb2dkWU9a?=
 =?utf-8?B?Mk1qK1N4V0pkUU5QNFNEVm9yamVHK0FxaGo3dzVGMU5XcHpRNVdPZXZ4MG15?=
 =?utf-8?B?d1RxMWNDMWxqK3pvN2ZyeVcwbFd0amFVZ1hNNTBhNEVneUlSYnpGZEl2SVhU?=
 =?utf-8?B?cTVIR1ptL3JzQmRRVFg4WUJJcG9lZFoyOGJKRXQycmpnSmRvM2hXSGI4YXAy?=
 =?utf-8?B?UEw3b0lDRmRlbDZoZnplRWVOVTJzY0YrWWQ3YTloNjNNMTlxWC85d1BGOHdJ?=
 =?utf-8?B?cklxMzZlc3FmV1hVWmp0ZzRsVEt5N09nZ2FBWk96VmdvYmtJYzRNeGVtaURZ?=
 =?utf-8?B?S1ZOb0RYdGMzS1E3ZUVOcmxFTXJuSjF0VzJwc0I3U21SNDd6YWxnQk53YlBh?=
 =?utf-8?B?cERzU3QzekROSncyRDhId2xvRk1sM0pVUnNwaWpVVlUwMm0zak9PUEdqdjlD?=
 =?utf-8?B?azhFY0FSWGR4UjhLcWM4QXpnMjhKMDByWDJJTW55WUJNUThvamx3YzlYcHZq?=
 =?utf-8?B?WG1tMVhxYTQ1cVd1MG83TTd3M1NmSjJ4NU5KRzgzNHpQbWs3YTBBc29ZbU5R?=
 =?utf-8?B?VG9rSG9yK3A1ajU2NStkaXRRSVptL1JzaTNOVWpXdFltdHlnMjUveTh0R3pB?=
 =?utf-8?B?WThacWs0RFJHY0Q4V0pjTWg2Yjh3dlBndExoc0pzdE90NHpqWWNSWTB3b1BC?=
 =?utf-8?B?RmVmWVZkTk1tZDZ2TytWdVdWUEw0NU9kWm9TdlYzNVVoVkxRVGpIdUxIdjJD?=
 =?utf-8?B?UE1MZHNsZWZIZnlueWN4NkhJNHdGTWNzVDhMcldMUFFQRW9sRXdoNHBDRmha?=
 =?utf-8?B?WVVsWDkzaHIzUnltdlRSTDJidUFtaEhjeXR4dy9aNmIzUTNZbkZzelg5OVE4?=
 =?utf-8?B?Qk9NdTFmdG50MFNLa2t5d21iS09qMFBlTmlJY25JOGxYQUsvQlU0L251TWtl?=
 =?utf-8?B?bS9NeFU3d2hoc3FDL3BMMTFCdDBYNmVERFBra01nVzNRMExqaEFkOWJjN2xV?=
 =?utf-8?B?SlFOcWxDVTkxd1A2c0IrcFgvVGVTZ2tLaTJkSGxVeGJyZ0FtU3lsRkVZaHdy?=
 =?utf-8?B?aVc5NGJwS2VyZ3IvZ3g4dnFZTEpGZW5qVVRERW9YYVFmeTFGYzdUcWVrbWZX?=
 =?utf-8?B?WHpWQTJMZDlhYnZMOTkrL3pFbDZnPT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87bafdd4-1216-4089-45ff-08de1d4f7594
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 16:13:44.6715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KzFCGCBQetWGCDs1w/XfcoiZ/KMcqjyCzlAo6BBuwssLr29NrIK3M5N50jWfLniAAiBqyABVF+tin5adUJpDow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR10MB9210

On 06.11.25 15:34, Tobias Schaffner wrote:
> The systemd tmpfiles clean timer may remove runtime data generated by
> xeno-tests during longterm CI runs, leading to failed tests.
> 
> This issue can occur due to a timestamp gap caused by late NTP
> synchronization after system startup, which makes the service consider
> recently created data as outdated.
> 
> As we can not wait for the NTP synchronization to finish because this is
> undeterministic we will mask the timer in ci builds for now.
> 
> Moving file locations away from /tmp should be considered when
> introducing non-root users tests.
> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  recipes-core/customizations-ci/files/postinst | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/recipes-core/customizations-ci/files/postinst b/recipes-core/customizations-ci/files/postinst
> index f89d9e9..9cd0c49 100644
> --- a/recipes-core/customizations-ci/files/postinst
> +++ b/recipes-core/customizations-ci/files/postinst
> @@ -11,3 +11,6 @@
>  #
>  
>  echo "bind 'set enable-bracketed-paste off'" >> /etc/bash.bashrc
> +
> +# Disable the tmpfiles clean timer to not interfere with xeno-tests runtime data
> +/usr/bin/systemctl mask systemd-tmpfiles-clean.timer

Thanks a lot for tracking down this nasty issue!

Applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
