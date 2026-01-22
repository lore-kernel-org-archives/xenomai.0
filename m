Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013016.outbound.protection.outlook.com [52.101.72.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CFF44D686
	for <xenomai@lists.linux.dev>; Thu, 22 Jan 2026 11:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769080166; cv=fail; b=qs9EzdbK2hsOHLi/4Pi48sRgQ/FuEZvpCtWhYxwMzgF50V9qtqifM5TWFs75W/b5GjZ5LNziC57Td3iKjPMOg8Gwcs7uBHUgbYwPlU1dg23BmxMXbLEVtYXuGP4hXoIdfLI2SuFYHF57sxjYEXMHlVaesVLkmZ10POlC9RN4a+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769080166; c=relaxed/simple;
	bh=tNjqX0roPWzXzRa7oGBTtNU6XS459Q9/pz9bR4DjVjY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o+7dEHSAmC0Uj4qxqyXP1a7W/E90ek6UY4nm9+Ah0/W5YvMn2OPGyq2MwfPWQMMMgcYdAlO8uD0l1Bv5ZA1tx8UDHxViaUZCcC+tecb3Ci09vTBOxuu1/zor3UVZC6EDp1V60iTjT8DUw55EX4EQ6rU7oIT3LqA9pOQVA/+PZFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=wTYHugLS; arc=fail smtp.client-ip=52.101.72.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="wTYHugLS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s4mK8UCYdwjlenlLzqHvVxj67CSjHEIi3ZKuvF6We/gwCvCNN4r6Zn/gi3/ioncTzL1cnCoffKjXPhuYkBl/v1d3YMFqoXtuA9qea5eINrUHDd9QHe5aXTjWk+z2PUIhPSRNBIDKkDAxH+qr2Hp6bYKusZDe6f7m62CKUcseuEHU5MCLPyiomT9F+rN/NbZVTTPklXhgcPShNlHEVq81198R36o1zRRbxrA6YQv40r9pBNH0laOqjhSzKBJRTehlk7XpPs+2m8cNt+C3fzWtSDQEmKoTWSC2GXRmqs3/JEfrlgg2wGncJekVTBFv/X+n7nE/6RIcMg7tAj0RbLDWPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfjYlAqloPNWwbRYtpa9uKW55BFEMpHuQYeGSckXzxQ=;
 b=QQQzQrDUFY+v3wsJH96HgZHUPPnVw0MYdfDYpjgodT9UtqEz+wcpOjmkRHqQUkM/8QO2WEY6VXLYot4VN9st7FoNLqBiIOSDFcy8OJrR1JdiZTg9x8x+b8odfHdcySNjS7GsIUwpfk9hKZr9BSfrf9d0VHWv+2mxFGXIhNII0eb9cBkG03O6iraWv3eIr0iuwWwCx8qgqdyRAqu9ADqPK8X49ucp6l4rkc0ri+40y5v/oPqHQy8UnIrtG+Wu0MnBgV3gzOCxD7nRWkZ54rp71wPfrDftViI7egjHoo6Ehff3ByY0fpLlnDiqmzGY1HF4khQvUrrA7AACvcc/QFlFIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfjYlAqloPNWwbRYtpa9uKW55BFEMpHuQYeGSckXzxQ=;
 b=wTYHugLSS+mCxYn8NhDUveOA5dJKGHY2pLNdLlN8gdI3kETQCgacoy7rW9YDw9nqIVlTwShwkJusKTFnFxVWgI3fMYO4hPsf/hbfVxOtY8Tdm47mYRVqaJHeOA+FTFS/CQK/D82VqtUPv1qTvcSXbm3UZkD95TV2Ugs/ARIQa8HX8CP8eeo8Wv8zwLZFy4nfsoNb81fTgKNGx3QGyUqCNhRx5Kf2c5AWK3maQwTQM+XqRYQqZbhmEp7oNczwHZduoduyuj7ZNVUOaLwc+n8spfLdnxpLTvTuSLvOo7tzDrUS1uVO8rTcHZ4CPVSTnt0LBOnrMEFPUOEiNjLBM3HEww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS4PR10MB5222.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4b2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 11:09:19 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492%3]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 11:09:19 +0000
Message-ID: <ec542b43-9ddb-4211-b3cf-73360c0441b3@siemens.com>
Date: Thu, 22 Jan 2026 12:09:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images] ci: run the EVL testsuite for basic
 testing
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
References: <20260122103928.424945-1-tobias.schaffner@siemens.com>
 <c607f371-4c22-4e27-a70f-6b7b379609ef@siemens.com>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <c607f371-4c22-4e27-a70f-6b7b379609ef@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: JN3P275CA0036.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:ca::8)
 To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS4PR10MB5222:EE_
X-MS-Office365-Filtering-Correlation-Id: a74e9ecb-39cf-4845-3eb2-08de59a6b07b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmlKRWVkRjY3aE9Kd3VPMVpidk9peGFvS0hiemY4YWlmWld0Y3JocHRNNmhr?=
 =?utf-8?B?NEZxdThVdGhxeWtrZG4vT1ExV1RqU1pmbldxVU55eVdQblVLMG4vQUlsdmtu?=
 =?utf-8?B?UERidnE2eU1iSzBtZFVrY0NFTGlmL3dYS3RMdG5TTnFPamxwNDY2ZjZIdFdY?=
 =?utf-8?B?N1BRQWR4OUdOM3ZpR2lOcms2ays2TU1vTVp5Q1ppZTNGdmdlZ2FDdjZBSzg2?=
 =?utf-8?B?VlJZQXVraFhXd2t6VDN2ZTlueGRDRDZOeXVjbmVMa1NLRlFmVW9sV2JaQjJQ?=
 =?utf-8?B?OWNGTzRadEhqQVFReE9zaUZQVWJGVWYrME1qV3VvOTA5YUJuY1p1NXRBcDRU?=
 =?utf-8?B?a0xTam92SXdaekJPMDVhTTRPcVphQW05OER6VDI5R3VJVHdUbG9YS3RwM2w0?=
 =?utf-8?B?YndaNlhSTWh3NVp4bWs3WERUbi9CL1BTYm5HcVN4TEQxRm1pTzA0VEhlRkY4?=
 =?utf-8?B?Q0pkKzV3VXYzRURXK2M5MWt0OFZKVU5zY1EvWlR5UzkxMjlUTEI3MHFlcG02?=
 =?utf-8?B?MGVpYnZnOThBOUptL3U3WXcyVEYvNWpDb3N6U0plR3BIZWlRQ1dNeHBrU05l?=
 =?utf-8?B?ZFk1UEw3c2tMQ3dHdVpHUDFXREk4bnR1eWdWbnFUcnVYT1FYSzJmMld0VFF4?=
 =?utf-8?B?NDBIc3B1SzJ1UUdDZGF4NTU2OFZndXdyYTVmVkptODVSRmh5YVd4bG1Tb0cw?=
 =?utf-8?B?VWV4K3k4T1BWMHpubGNsMjJmK2tPYUtKRzFlZ1Bremd3T1NISU1qWTF4SUJX?=
 =?utf-8?B?ZEtmZk1TSTZiTlVwcDI1cEpXYThCVHREOFdrUHZXNHM2NWo4NnhBbU1yY1Zi?=
 =?utf-8?B?WW5lRTNSY21kajYwQnlzU2dDOWgyblhvU1lhZWUwY1dWam9hamlrVmNZS0xB?=
 =?utf-8?B?U3ovUnVteXBBbUdWNXNtZnplZjJJditsbkxVS29PYUlpRmRDSUdDZmNPV0JZ?=
 =?utf-8?B?QkFvcHVTUmFkZllGaUZ5TGpMVXBlUThHYnFQVXc3SHBvZ1lsRXFKNXU0S1Vw?=
 =?utf-8?B?eGlUWGNiRmxEbmVEZ294N3lJUlZvRHVHeHFEMTFWU1RaUStOb0doa0hSR1lD?=
 =?utf-8?B?Z0FOcEF5NVlIb3lXeFh2WDNSRytqY0ZCOG4wVG5FRmVmRFVjbitEakliM2ww?=
 =?utf-8?B?UG5FQmhYZlh1WW1Xa0FaUXB6bEZKaGE4eVY5dnRSK0ZLdU51RWZzMnNCeWZ5?=
 =?utf-8?B?ejNvd1gyVElJRDdtdWxLS1drTUVrYzlEdmJqQ28rKzFCLzJaWmp6SUNzZlJk?=
 =?utf-8?B?U3QxQlY1ZmZHaE1yUlA5bHNYcUNlb204RDk0elNUSE1JTHhkWGJKYW5ZMlpN?=
 =?utf-8?B?WDFrT2pSdmd4VnNxVGdQYXVQTmdERDdBQmE5V20wZjFNQXFvN1dhZHYvQjli?=
 =?utf-8?B?cTNicFprV0pLSDBBUHhUYS9PMk0zcHQ3Z0pxUmsrRjBRRDhzMlFOdmpIY2tl?=
 =?utf-8?B?MkFqVzRCMnlNQzZqelpWcGszaEFnSDJEM0lWUDlSeDNYaTVYTVlneDgvQnU5?=
 =?utf-8?B?a3JyTm8wSUhrNUh1Z0hZUTFsSzFxN0dBUFdYNEp1d09GSlp1OFg1ZXV5dXh0?=
 =?utf-8?B?RkszMkg4QTF6TEdzU3JqKzVDeWhlWmlnTXlhcVlIdmVVb05mZUJSb2dCaWww?=
 =?utf-8?B?ZnpmeFhIZ3lsWUVTbTRzZmF4UE82dlhPVVk3SXFPVHZzekdzdHFnbHFtZTFE?=
 =?utf-8?B?K3J1UUQ3YXdqMUNzU3pYODZoUmZ3RkZoQTlUOUZFNFdPbktjdlFiUDYwRkVu?=
 =?utf-8?B?SUdmSW9DT3hwZGJMS1NLRUEzNnlnWFpkVzZESHVMN0l4dThrdFRPdVUxeENS?=
 =?utf-8?B?d3JSd2RiSGJEcnRDbU9ZZm1oOXU4Tmsrc3ZUdHhTZjNiN2pSbG9SWHNqTHNQ?=
 =?utf-8?B?Ry9SRTVaNGtsam14eC85V2pMTU5USU1NZ1VzM280Z1pseFFjZ3lBVnAvRE96?=
 =?utf-8?B?N3pLNlU4L3RiMmhsbVJwQytTUXh6bTc0SnpiYlljYmFxd3ExUU94VVlacnly?=
 =?utf-8?B?NGJXRGpTZ2tLS2xycGlYQVJUUkNwd1psNlh6K3Znd0hhaEpsNU56YjVRamFM?=
 =?utf-8?B?UFZPcTVSYWQyN0RyWXR3empOcVZHd3VENStXeW93SjFsMWxadHFseDdXdkRQ?=
 =?utf-8?Q?xhS8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEhrakI1S1YxV2RwOGRxclF1TXBKUG9UMi9EeHdwWGJMSituc2NzakF6Ky9l?=
 =?utf-8?B?OUMwVzhBclRqbDdlUXpkRTBDc25LeHVHVUdIT1o3anFZekVzcG92Ky94VDNx?=
 =?utf-8?B?cTVmUlJrSWw3b3NKSW5QR0pvTEkyTlpTeSsveEJVa0RacHF3YS9ZM1R3QzNJ?=
 =?utf-8?B?Mm1Sck1ucmw3YUR4S2ZwOGJHNE9PUW1qNlF0MEdyRnlSTDZVeXI2VjM1OFNh?=
 =?utf-8?B?Q2VucXhVWTNnKy9GUU9rbm5mSG44M0lKU0k4ekpybG5tRWJQckpwdG94NW1p?=
 =?utf-8?B?RjZPMTBHUDNVZGhrSmZxZVd2VG1GK2NTNWdDdU1LZ3hCWHovbXJBb0Z5Wm1E?=
 =?utf-8?B?T0dpelRJSndvUXpFbm9ySkhNcEVDaW5oS0tDdXZ0czNTVkZuNC9NMWdhdFNY?=
 =?utf-8?B?TGVEWXd1VDFRNUVpNjhUQ0IrR0h6bll5STZNYllJeXNXbnRGV0xlYU05c2Rv?=
 =?utf-8?B?MjlQSy9lWWhIV1ZIQUtTYkZEb1h5N2FoejlYSWxkZGFEZENnN1lWVDhvVE4z?=
 =?utf-8?B?WG9BL3hGUm5UcUdtWjJDTlFTZW8reHFpbEcxZXZwQ2hKaGgzeCtySmw1am4x?=
 =?utf-8?B?SkpFUDVGZncrakpQMUl3dUFDcUxPUzhnQzRNMG5GaEtzNHlDV0tKRmZPU3NY?=
 =?utf-8?B?T2d0TkZqU1UxRE1DWGp3d0hxNFpIaWlNQzFDeHV0dDRGdjV3S2ZVa2FySDVS?=
 =?utf-8?B?cERabmEyOXZieE9FOFd6TVRIVEZtQjVxTDZYdVBZaklvSi9TU01tY05BR3dZ?=
 =?utf-8?B?bkc2d2lEWnZCclIvOEk1R2tYU2UzeVZwcW1TSS9uOUxVbGg3TERZSFZTOEFh?=
 =?utf-8?B?a0xMbHJBbjhobmswM2xYUXJCbFFKOXB4UXNFVXpTRUxtY3E3RkM0eUFwMEdM?=
 =?utf-8?B?Q1lYOEMrdkRGbE9hQllRY2wzdWxzeUVpcGZRQXo0N2x1dEZkRHhZQ1NUMEpD?=
 =?utf-8?B?dUJpakRVdlJ6akhEaTYzVnpQQ0ZwMUtsYU95ZGlmNDZhZXdBNjJUcFowa0V0?=
 =?utf-8?B?eHlZZHl2dGFZODQrOXNRVU9qUkgxdDc0NC93NC93Q1ZtT0NmYXZZMnJRNUNC?=
 =?utf-8?B?K3BHVU5WcmtJOHhERUQ5VUJKOVRKdU10d1Z5WG1IYk0yVGRsb0FPSERSMHpj?=
 =?utf-8?B?bjRub1RFZThuZUtncGRIdFJFWEExMHVQUmdhdElmcjdwSE5oN1JGcGJiYncy?=
 =?utf-8?B?MGhxVXpQVnY2WmEwQWRmK0JSY3RkRmtpcm5hV3BkTUZWdGNnWUt0QmFZaks0?=
 =?utf-8?B?MUJrQXBSeVlYVkNlTUczSGs4YUFobm5OUEozN25OREpxL1ozV21ZYjVUcGxq?=
 =?utf-8?B?a3VIM3pLcm5lbGF6NTBCWDI5MVdhRnl3WkJEYUNmK0ZENi9vRklFbnY4VDU3?=
 =?utf-8?B?S0EvaGR5WDJZdFhrbi95NjZMVzhMbDFET3ErdkRkd3hxM2RLMEE5a3N2dFB3?=
 =?utf-8?B?UHAxcjJEYXIxdHVCajFFd3NkZ3pvK2psb0RPR0RTamhJTTJrQUtrSjEvNXpC?=
 =?utf-8?B?ckpNemhicHpsaDNralUvWVBYaGVNQnFwK0QySTF5NU5xYjZnYmNweWRGelR2?=
 =?utf-8?B?RkFlMVVBMjJwdk8xNFNteWxjbGk0ZUh4dHVPajFEVHludFRUaWMxb0thQTVT?=
 =?utf-8?B?dm9KZnZOTnMzTEszMTNUazhuaUlKV0xzRTRDYi85OTA0YkpjSkp2eWM1SVRI?=
 =?utf-8?B?T21qRkswTld2T1ZTRWVsSXgxeXBDd3VuQ1JkSVZjOWwyRVBRanFLUDVKK2NL?=
 =?utf-8?B?UHE2K2Zna0t5MCt1a1ZsV3JiVndPci9MS0ZUMEFObkkrQVVEM0tFRzZyVnhs?=
 =?utf-8?B?YUhqQUZ3VUtBRHphTXhpMVlrM2E2ZTNqTlNZbFZ6NFRsTCtOV1VtS1lLa2lu?=
 =?utf-8?B?K3Z3SHREeDkwWVJabXgzd0dva1dKSWVQMWlkVUFRNFBCNDlCTkJCN0ptQURs?=
 =?utf-8?B?Q04xTWxpdDRLNTFoamlKelhEUFI5bmJobWtvUUlXL1F4dnlhQzJOTTlaVzUy?=
 =?utf-8?B?Rm1xY3BNNXZwb2JuNlpkTFVydERqeVoxak5LdGhiMTJhUVNVa09ZakJRU3oz?=
 =?utf-8?B?L3UwVk1Ka2JPN0FtRkQ0T0lpVmxjbXdzSjY0TUg2T293d2dKRWVwbmltcStv?=
 =?utf-8?B?dVFYaEFuZ09VN1ZaVjZvK04xd21iSlUrZlVTeW1IckJjNkZHelRwNWlTeERx?=
 =?utf-8?B?MGRGbUsybmFhM0JaUHRCUmpJM0ErNnR2S1hUSHEwenZQV2NURzFwR1pFZVlu?=
 =?utf-8?B?NnZBRU9TRTBZdHkxNGN2ZWRIS2lCNWpzdWQrZ0FXNVdsajZUUkZHM09kMkZ2?=
 =?utf-8?B?WExKdjJuWEt1L2pLL2dhcEVVL01BN2kwVmNNeDBPSmJ5U1VVTE9GVjFiRTgr?=
 =?utf-8?Q?UsVhbEQxsSwwvgs4=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a74e9ecb-39cf-4845-3eb2-08de59a6b07b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 11:09:19.5210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4nysknSdmsfwtbsku+Cq2tfSIWmEaugAeFcRqPQjPMWo9j+kL+gA3fPzNPqS2Ew1GECsgJMq6QRPMYjYyOu/7f4KImRLTNCflfOvWRGoL0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5222



On 1/22/26 11:46, Jan Kiszka wrote:
> On 22.01.26 11:39, Tobias Schaffner wrote:
>> Run the EVL test suite for some first smoke tests.
>>
>> EVL_TESTS_SKIP_PATTERN allows to exclude tests in the test suite. At
>> the moment this is used to disable scheduling quota tests that fail on
>> virtual targets.
> 
> And why do we disable them?

We only disable them on virtual targets not on physical ones.

These tests are expected to be unreliable with a virtualization layer in 
between possibly causing delays aren't they?

>>
>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>> ---
>>   ci/gitlab-ci-base.yml | 5 +----
>>   ci/xenomai_4_next.yml | 1 +
>>   2 files changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
>> index 186d1cb..76e38e6 100644
>> --- a/ci/gitlab-ci-base.yml
>> +++ b/ci/gitlab-ci-base.yml
>> @@ -107,8 +107,6 @@ default:
>>           - report.xml
>>       expire_in: 1 week
>>     rules:
>> -    - if: '$XENOMAI_VERSION == "4-next"'
>> -      when: never
>>       - if: '$LAVA_TESTS_ENABLED == "true"'
>>   
>>   .test-qemu:
>> @@ -116,9 +114,8 @@ default:
>>     variables:
>>       ADDITIONAL_XENO_TEST_ARGS: "--vm"
>>       ADDITIONAL_TEST_TIMEOUT_MINUTES: 25
>> +    EVL_TESTS_SKIP_PATTERN: "sched-quota-accuracy|sched-tp-accuracy|sched-tp-overrun"
> 
> Why set this variable here, rather than close to its use?
> 
>>     rules:
>> -    - if: '$XENOMAI_VERSION == "4-next"'
>> -      when: never
>>       - if: '$LAVA_TESTS_ENABLED != "true"'
>>         when: never
>>       - if: '$KERNEL_VERSION == $KERNEL_VERSION_WITH_QEMU'
>> diff --git a/ci/xenomai_4_next.yml b/ci/xenomai_4_next.yml
>> index 30ca9b1..03dc233 100644
>> --- a/ci/xenomai_4_next.yml
>> +++ b/ci/xenomai_4_next.yml
>> @@ -20,3 +20,4 @@ variables:
>>     KERNEL_VERSION_WITH_QEMU: "6.12"
>>     BUILD_IDENTIFIER: "evl-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
>>     CACHE_KERNEL: evl
>> +  TEST_COMMAND: "evl test -k $(evl test -l | grep -Ev \"${EVL_TESTS_SKIP_PATTERN}\")"
> 
> Jan
> 

