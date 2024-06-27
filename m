Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2081.outbound.protection.outlook.com [40.107.22.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EE022F1C
	for <xenomai@lists.linux.dev>; Thu, 27 Jun 2024 06:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719469804; cv=fail; b=C8AUC7xjpRMSIKrg2tHUAJXUBmj0LFrkwi+qsELh87OAaFaRaxkFCljiV5obb8lSap51ZA8vs+QlL80Ve859SbUnC8jVWM1LtCfNJ4nR2uqbet1IC7EFBtY9uaFJ2jZnlVGo6l0wfC2QrjefeX0A9obDfe7u6dHJ6eUSzDiTfsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719469804; c=relaxed/simple;
	bh=2awUml8+LGll2b5YcRQ4e5goe5CxTz18nQGW/3lboNk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dvEjmnuB+oN3c2+TGe2OqTXjTQ9gS+9xhQvY29alirmE4qG/p/x5YgPgK/agpFIVGz5b2PtVHCMDEaGDmQILvO+LtKo1HvnCtiQG24Aw5SjSQy7QZOdwvM6sSsMUpFUmsJ3bs2bZftD12dpsjUIDPWtxW1cv8F8t1DDRZBXmHaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=KRTKs2sa; arc=fail smtp.client-ip=40.107.22.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="KRTKs2sa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SoC72580r81miXJhYOiN12bXBqNbwNGChDEMPRJbg05Wz8htkpQIPLmi1XILI2F2fVBAY9NK9R61j/uD0QsclvGScBMHJGP9GxCTi0LlYrTjQqBOZweXAWllpFTtG5j+MB6hayTY/Nc1iJqg8B3E/D77WfSXv0G2p1VCmzRPmfIm2aYK2LnQyWbOUJYOcWfXW8367NhbgnpMtqFswaOgt7Yc7GDAcV0jiFb0pdA8uQbu0/1wD29g6Qoxfn/sn5t8nCQ6csWyPWdr0YJ/2gfvbEi7LdANzyXvv7cSIQasIZyO4yo6wyAh5zxejvM8XMnAsbVGF620OEW6a9WrQ/U9WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vIL/7GYhQZcCcRyqdZqmJ+33R+hVGrIPXMPmEWrh2A=;
 b=RkfBYiZCijMaTltNgi4+DstUm+I/uTa2EdNAXb1ovFs78qyTtYBPutVaHMsDnP9RLukt2jY2YoRu5EgixFee4jP1XCGWMYXYGmVgl2HrY2BErod6/b71DTZikbblTkahxWLYTeuOhRoyyxIs2wH+1VLdx5LNes6DpvVUr32rqs3+Qx6aS0wPbdRBc3HSvlYagNl37RmtttqiAs5jfs6oh8K+B/xB9xh7yPnco2Ny50Ce1daThmPaZm/I5JSlMDci9O6cKBdrpWcWA7W4D4/kJN3wCP1pZYxtIcHUPqzDCaZ0z1AVpWV5D3YJm8WaluGgWyDedkTaFnQeE9J7PfXtRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vIL/7GYhQZcCcRyqdZqmJ+33R+hVGrIPXMPmEWrh2A=;
 b=KRTKs2saLGK3XodFsc4K3tRbZavwR3uyD7FOC/qpGHjtSM9s8/fRKQ+IwS/7jARb4MGL5VxblLRT4KJ+rMlrkCyCDX0xHjcxOQHQZQQdvoLJOP0ydP7YNwZFfXkbEalg7y4KVSDgTTLGrhGofgAfkBN1xkXNlauoHfT0TbXHGE7z+V/0GL8OQwT3ias/EqTdYAvzjoLWSHEGcsoyqWh+MeZfxiURyVLsHoQF6cFcoDeqsObagMent5tY/0mD5ZoSGtBPqh1KW621AqJ96AEd4CaCK5+rB2cAtxuv9CXp7EPhHUvFn49f7AjzPF6I7H1E2fq9IXVQYpEYPeVFgJrCug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5259.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:33b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 06:29:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 06:29:56 +0000
Message-ID: <743413db-e149-4bc3-96de-41b6ebd5cb00@siemens.com>
Date: Thu, 27 Jun 2024 08:29:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: cleanup stage for .gitlab-ci.yml?
To: Richard Weinberger <richard.weinberger@gmail.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <CAFLxGvy74--ghqXA9dAdnw40UDr6sT6T8NY5dv95Kg6F-uav_w@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFLxGvy74--ghqXA9dAdnw40UDr6sT6T8NY5dv95Kg6F-uav_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5259:EE_
X-MS-Office365-Filtering-Correlation-Id: eed43aea-5ca9-4435-cc43-08dc96728f9e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UllTRUNzclpXeGZSSnFjUHZHSXducEh5UWl0bFdNRVRUbFlmU1VkTXJ6YzVG?=
 =?utf-8?B?WDRHMUVFMyt5NXlSUSthNUZKeWppbVFzNGljREVkUWM4TElJdWF4ejdtdmJN?=
 =?utf-8?B?YlRNVXJaSXl2UnltNURUSWY0M2JBZWJlZlU1NGNCd3o4ZGdNdTBhU3ZJNzJI?=
 =?utf-8?B?amtaUmU1bFZhTzMxOVRmUG9zbmVkaUNpRHBiK3ppYzJhUlo3OUhaMHk3Y1FC?=
 =?utf-8?B?V1hZNWM3REVrYlBvNUJOYXMwMXlrOG55Sy9zanAzYmZiYTRpVjNrd3ZoUGlP?=
 =?utf-8?B?TGpGREJDUFVHMnoydjNOMDdvbE02NStRbTNZSDBNaXhUSEVqMUlDREdGTjll?=
 =?utf-8?B?M09BdGRzTXpKSVZ4UDFzS08rTWdmdlVKL3Ywb0JscmJNMHltOHcwbWR3aFBJ?=
 =?utf-8?B?Q0IvZ2tkOTJiUVVvb0pscmFGMTdHajF2ZlJJTFZmcENITm5kck5IVjZoeU55?=
 =?utf-8?B?WGxFRStCcUI5NTJzZVR4SWlsOXZhS25PVmwvajVVcVJRc0JWdGkxS0svL2s4?=
 =?utf-8?B?SU9SdEtJU3FCMS9Da0JnenNUWHNzVk84MDI4QUl6cnVtbDFtdk1JN3VncmlE?=
 =?utf-8?B?b2FFR04zbjRDL0E3VmFnVmxvdkRRa3pDYll5dnVFYXZIS2w1cGNhbE9IMCtp?=
 =?utf-8?B?NGR3SW1tdDh2TFNGUjZFZ2kvNk9Wb3pFV1R1U0NIRENUZENXbytMRTFnRUxr?=
 =?utf-8?B?c3V2Q2hBWkdoRWZRbGxHcjhxeklaWmM3Q2NDdnI1a0x4TENXWWxzNmRyQ0Z1?=
 =?utf-8?B?azViOCtvWWlucXo1b0c3M3VUaTZnRVFmMmxSeFdaUXBhNEZ1ZUV3ajYvODd4?=
 =?utf-8?B?bGVrOVZxZytpanVobFVXcUJsT3pqSURGTWsxZjUyVTAwcVFNVkl3OERHdTBh?=
 =?utf-8?B?UVEyZ2JvUkNIcFluZjhQYWpKdS84QlZ3Nk9aTWhIT0tZaEFsTlJxelhJYVJC?=
 =?utf-8?B?TlJWVmtEbmM1TFlMUkc4d0NzcGZvazIyUjg1dTNHdml6MXFzQzZJWndDalpn?=
 =?utf-8?B?aU5TZUp4WjNBTUIyVGhNVkt5ZGJKTXZLUjcwTVV0RU9SY2lQb3BRQWlhOGZY?=
 =?utf-8?B?WFprK3NwaEVVZWZ2LzZ6MndSVlVDVkVQc0JNZXF3OHBaK1dTc1pjdXp3c1N4?=
 =?utf-8?B?VitXaXFFYnhiUTVkQkpnbk92eHpkYUFxamZGV3laeExSK2JRbzdtNkVyNkFI?=
 =?utf-8?B?UTVhNHhrekI0aC9LckdVZUYvaEc1V3NwZE1GcWVPWDN0S0FCOXZYcFlocGdh?=
 =?utf-8?B?bFRDZ0dKeExPUUc5NklhSlJ4aHlWVXVlK201UmRhUTFZaExLd3lQL1ZYZGJP?=
 =?utf-8?B?QlIvNGs5dzIxZlpMK3JCSVV0bnJncWtWd1V2RnBYbzBVeFYwaWQrQ1lxdkVs?=
 =?utf-8?B?VFZ6YXFaaW1ObkMzSTBoRFU0N3AxL1FSRXBDOW5tTGZsZ01jY2R2S3F5YkZ0?=
 =?utf-8?B?Qmd1aUliMkpCUkFudm9RSmpRc0QrcmI3MTdtRDB3U2YzMVdLbUlQNjhMOGlF?=
 =?utf-8?B?NlpURncyVWJoYlNDNldPbHp2QUJDTzRDcEE1aEJkM0NxSnpxM2NZSXJzaW92?=
 =?utf-8?B?M21oNGJKd0RrcmpPMXpIZVlEOEpTT1h5Y0ZJa0g4TzUydEQyUU9QMWgybEZa?=
 =?utf-8?B?aDdrWFVpcTF4ZUw0WWNsYTJOZzlKR2NKT0lPYXZidnpBbEMvNWFQUzN0Uy9s?=
 =?utf-8?B?ZmF2dG1VS3lyTkUveEx2enN4KzJxNkVrdDVCbHh4cXhqcmpJcC90bWxmM3Ry?=
 =?utf-8?Q?iWx+t4yTctMCl8159n+4BEgDTYD1f5q8/kVhiBJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFNJdXJCa00vMG8zMXRscjhoeUEvVkYxc0htWkorU0w2RE9zU1FXOFJWdHhu?=
 =?utf-8?B?TEl3NVl3ZUZ2OEtaZjZ3Vlc4Y3dSK0FkK0lZai9BR1NqMHFiOGg4ODNjWmJw?=
 =?utf-8?B?YzlDYW5RTndTRklsTkt0ajRQSTlYMTY3S3UzZ1NrcU5Rek0rell4Q1NZeFlH?=
 =?utf-8?B?bm5tbzQ1NmRsT0tzWVdidHZDRWpNSHJvcnI1QkVRZkhnTWJYdERDdHBQQmNh?=
 =?utf-8?B?SmpzakpTT25SYzlXdzgzc1FFbk9ueFlaRkhGTDgvQUJTNUVrSDNIdkh0ZTBP?=
 =?utf-8?B?T09QbC9yOUN4c2RGS0VkaHhnZjNzUzRiYkRRb1dmbnRSZ0kvMU1ROGNvcXA1?=
 =?utf-8?B?a1B4Rlg5Y2lZQjdXdFJqMGlhKysrWlNsWHZKWlNmK1VUdW5aS3R5VVRpeUQv?=
 =?utf-8?B?ZlkzL1puWmZSQk5tSHdwYlQrNkI5MjIwbk9LMjVmNjdOY2dXdVJRbTVCdnBL?=
 =?utf-8?B?SWgzeWxRMVJuY2FvbW05K1hGd0RDV2lObmpKakNRcCs1RDJBbERxRGhLOWc4?=
 =?utf-8?B?RFFaRVNkZFNWaGlFWU9PZk1OZXdad3R2ekgvd3lHd0ZyaGowUys2c2JlTko3?=
 =?utf-8?B?c01TM2pPajRKUEhZTTlReFV6OEl0eDZpNnc2MmtLeU1RS0preTNPSFJVS3Jz?=
 =?utf-8?B?UWlENTloS3h6VWI3RjFIN1lUbW9XZytjeUpBbHhlaExLeTZGYVBHdmhpNDcx?=
 =?utf-8?B?YkI1YVo5WXp1SWlBNUNvWWhPbE9sT3FxVExlTytOdVFxT0drcUZFY1M2bWR1?=
 =?utf-8?B?bDd2ZzlQY2pYK2gzcjB3eEpEbXdVOHpVMHVCcVUyRkVETXl4bG5SM2JKWnhS?=
 =?utf-8?B?YjRqVTdXamJ0eDAyQlo2cStKWU5jWmxFQnZsWkM3cjBhS0psQUNSZjI3a0JL?=
 =?utf-8?B?aWtMc3VxYytkcGpZYWxCNURZQnl5bmphbW5NOER2Z2dYRVAwSWlQNHFoYmZN?=
 =?utf-8?B?dXJ1S1BadTlXUncralpTQVpkWFB0cFl6ekJ4cDl4c3NiRG0zUGhyQ1pvdktY?=
 =?utf-8?B?eUNaZ0ZmREtvWkl1bWZTd3pKcU15ZXJKcGMwK3lnQkc1L08xZE9vaFczN1Bj?=
 =?utf-8?B?U01GbW5VMU1EdFBtK3pscnRFeXkvTUxJU3VQN1p1Q2kzZzBJQzRwdktobFdq?=
 =?utf-8?B?RUdQK1VKL0NSNnJjRUthVndBN1gvYURmNU9uajVqamRhMGliM0JNbmQzSDRK?=
 =?utf-8?B?eHhCbGZzVlVZWnVLVlB0cktGbFBoZENCNUM0N1NrOFNQMkI3aEEydTNjYkFN?=
 =?utf-8?B?cHhlL0VCVFU1Ym1vS1BNTXNwTHdVelBYTmlJQjV4dGJoTjJSUUVoRTJKTUhU?=
 =?utf-8?B?L3lPY2cvbTJVOGJFaXJWaUhYS2dVSnR2VGhnSkJ6RzZiNmtNbUF1V0x6WnhF?=
 =?utf-8?B?NVIzSnBwVjhiZVRhUStIeG1Bbkp1MVBvVHlFcS9NQW9HT1kzZk9vZXQ2aXM0?=
 =?utf-8?B?WVJyUVU5R1QveHB6U0ZRTTJvQ2xhK1dndFFnWEhsL21UT0NkTDdkajVQcFFB?=
 =?utf-8?B?NWxxdnd1NzJiaCtZWnJIaUVEb1hhVDlWOW9VdmtKWk45Qkg4SStSeExMa2Jq?=
 =?utf-8?B?RFZEdHB2VUxnYmJoM0o0a3F3K1lSaEYyaGhyV1prTXkweWdlci9ZdEJaQmg4?=
 =?utf-8?B?N1ZnYVZFQjh6MXJxKzhxTlUzYzFTRlJiS3cyN1BGbWxBaVREUzhYT3gvZEoy?=
 =?utf-8?B?YWlxdXJXODhsMUN3U3U1ZTNlZFJEbkl3Nlg2WXdwbi9Ic0lyYUVrM0I4ZHdW?=
 =?utf-8?B?Q1VaOGJiZ0liK1pUVFRSZW8xTzMwUUFDYVN0c3Q1YStMTzFUSVJoTGhJNGxI?=
 =?utf-8?B?ZzZ2TStPRmtXdG5SU1dNbVRScnptVStJQmNESzRUT1p4OEt5ODRGN3JMUWpR?=
 =?utf-8?B?Q1NLQk1PU3dzY0Rsa08vTzBWbFVtL0EyNDBJVGFlRFFvblJweWJjYStXeWhB?=
 =?utf-8?B?dVdjOXFmR0FZWVVGU00yc0MzcDhJTXM4TGwxSFFubUZBWGVrMDNTWVpqSlFG?=
 =?utf-8?B?Q1JnNHhKbjVVVi9oK3J3dVc0TkV2clNUQTlhY3FlUDRKWHhjV2hDOExTNkVG?=
 =?utf-8?B?Q0pEdW53MFVhN2hHdCtzT3lxTS8wbk5GVm9uTlpHQmNJQlh1aThhWjcvdlNn?=
 =?utf-8?B?cnptMHI4OFFlOWx2c2tGTDdRN2JvY2YrWWQ5THc3Z1RYcXZLMm9udTJBMGM2?=
 =?utf-8?B?U1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eed43aea-5ca9-4435-cc43-08dc96728f9e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 06:29:56.0528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GS1SijayIzI/s8gfv4838cAbBy75rDaNbCTnx8M0GtNjBr0bq1YtzXpFw2Li7gfKPiN60ukDE3E25G/Td4G5cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5259

On 26.06.24 21:48, Richard Weinberger wrote:
> Hi!
> 
> It is possible to have a cleanup stage in Xenomai's .gitlab-ci.yml file?
> I'd love to run something like that:
> - pushd ${KDIR}
> - make clean
> - /path/to/xenomai/scripts/prepare-kernel.sh --reverse
> - git status --short | grep -q . && exit 1
> 
> ...to make sure that both make clean prepare-kernel.sh --reverse
> actually clean up the kernel tree.
> 

Of course, this is possible, just send a patch.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

