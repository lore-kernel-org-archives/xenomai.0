Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793616500;
	b=1pKotugFJDhn6yMzCxKZtwJSvNRwOCYnjn4o8xVUz3SKocra7G9vlW0qd+hTiPrVmA0A
	 Vmh6T3YSfZ7ncO/qyekAfB81kX8mLvMG6mAxtfa+GmozZdiDZ2KQ29KaeCoCkix1XdTNd
	 GPSOLcmTKqPEiz0Hl798LhTF44gEFqHcJlmQkpvwb4754Y0vIEE7rldeBS0jc2XZ29GLT
	 8SxfsyO/n08WMCjxnXQ8P8Etju0OF2ncHlEHPmvTvo25xqlTziXHs7WVqEeFwd/Wd4kdG
	 EATxs0Wcmta5w4q7G6fG818cpG0l+8lpltyrGSatXIKnqa335PKEz1zIaZ6qPDQB24w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616500;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=it7OjmCKbyWT055NDQYmOHoZ+dA5jgcviOP8upWnuJ0=;
	b=ZMUdz4fNIkhIQo8zyBxzXEBjVmyb7+xIN6AFQyqV/mHMsqHxrWyveflYs4fbS3ewszjO
	 9fVl3zS9McbkD2a1/m+RuXRK1vFPg4oDIRTNO8A+x54uVJ9KilJloWSYJZOVg2J6ZLIGU
	 g1/rmRJXoGHL29c+8m0Qmdh7vXA06Hw+v9QozCosZ0DwQuHyNC2D80Y6JxLcPWqpc65eo
	 Fwf31P08s8SfUGYWlxbgMFHKJkNVzLqRrF/hYSxiQkNJLJkbzZOpA9NzqyykUvGayNkjt
	 +lYmZWlocOeyPygWPMG9lIqZGx4AhRe0OiXE3Md5AW/xKUsnTZl70ZN4FlEIXOp+qsQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=SzXEK5b0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.19
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012019.outbound.protection.outlook.com [52.101.66.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED92606A326
	for <xenomai@lists.linux.dev>; Mon,  2 Nov 2026 10:48:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9ED92606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=SzXEK5b0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cIVqLZXZzZJ2H7dWNNjWdQWbpfeQ8Y3kh5np/ZNIeKcmlx5EU7xvKqTF8QQo6pPgZuXIw9cNXq7JSyOWLBfHrEdqY0oYB8dXh1KKEabzCKldtmljT+IuSqKaxyYaYk3SDYUyVKo8Gwo6621075kl+H4TpnI8kjqp+cFrrOPVvjvsmC7850ETdaki4GTUH7vx3KbJI3YkvdCZ8sRcznaO8PfD7DSpIiYNAfjuTykrUPExqHIt8mDpgO/1lu6ovCb0jabf3+2rQygMXlIjJI0yqevZNNTIVeziMrFLT0C6Ltf8QmPwU5ZYl8aArPFvXS3IDrbUS050iiXC3v/PBiTpwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=it7OjmCKbyWT055NDQYmOHoZ+dA5jgcviOP8upWnuJ0=;
 b=dO9Kj+UQFjk+ui3IujlyPVT2NX60cGd/LrE5bzzn7nz/azc9tqpGEMy+h/x3s2Q3neTVUjLEnkqsH81Em2rj3gtAG0vQWkfbpRi24ZKcQqHYsaBFDvhyxeE4ynNoxqesj98v2YjwWUf+4DTFkMaYEdH8IltqoIjwrK1r2q/IrRAEPdLFHg1gpUiCde5AoWdhrMYiTMIgANTNf5l9QtQFHde831Hp4hp2ccivpjys3zG/flcWqd2s1R1vWw52ZNYzw1mfuvGZgWS1XhPm2CalveEu10dPlVwOB2rKGPKHm1zoIHfKY5j4dJ3wSet7NiXHvwZ2+EQsjfMypAvRhwpLqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=it7OjmCKbyWT055NDQYmOHoZ+dA5jgcviOP8upWnuJ0=;
 b=SzXEK5b0W0LWE+Eq+SM5O5URChry6RGvJIlUv86MFQ0ihspQGWPJ5JiHvoNP9Nq6a2nM5Poh83QLCmRvFkFvamtopRaJDbQW33c0t9gdxmd3UrcbAxa5bvViyDX3o7qiuORIiXLFPeZtWCoZiJRxLJVX7ZL4vrFwsWztgBqE2DyrDaIIwneviibR8iiA/G15Qv5LqzUn17LToCXMdn7RYkRyjQI7n83ZwIzytKYFPBvqryIcP6ykKX2pLOxKrhGw+tLv+c//99M/Poa/GrjoS9w85fLXrI2xs8o98YUdbjQ6A3E6hL1/ETPbTDCgF+jvBd5FCZ+LXV9h9dwnsX30Zg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by DB9PR10MB5930.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:39a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Mon, 2 Nov 2026
 10:48:13 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0592.007; Mon, 2 Nov 2026
 10:48:13 +0000
Message-ID: <c08f9acd-711b-4e9c-a3ea-f34d322e4c01@siemens.com>
Date: Mon, 2 Nov 2026 11:48:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.2.y] net: dovetail: Restore accidentally lost mp_ops
 cleanup
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
References: <660c8205-c3d1-414d-8977-6ee6ce1ebe1c@siemens.com>
 <874ie0topt.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <874ie0topt.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::9) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|DB9PR10MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: f0db1f52-fc5e-4b09-d9b7-08df38cecb00
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|261021121427099003|261022105027099003|261026121527099003|261026140227099003|261028144727099003|4143699003|11063799006|10067099003|56012099006|260925021911599003|260925021311599003|260925022911599003|22082099003|18002099003|55112099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	QpcLJZhSkiA4ZnIW9xOpfew6w/LzELcdwqZyhIyZrX7BmifU3Kwq+mD9X8AkF3Rop622jo6Hw1afvVODx2wwfxcgV2cWopyvs17+AzerK3sso6kuXX39VZHUVZAtUuRZH1SBE30DPzwvPFWFqJHi4MOVY//pelYz3etPAlH4fTo0QfVrbrJMSvhyurTpwCcrxlsC+7uJ2avDu8VoNF4d52iiKv9OHZavwFz0SlYdZxyOMhIWKiEHh5YwJk6TZEhILRmuH5fmPZ5kh5dQDWZaG+5MWFn0/v6Rto3O/1tvfdJOznz2fF2cZLltEnWuZ99G70wO6M9g+ef5ysnTk4m9ke0E7eO2rgBVEofuUjbDImZ0rzH29qeh8t19yANOhW5EyRRwNrh1aVd1R+dFjCx/dOECysaIbEKN1nW3yEEWR3q6YwDVF5sIdqCzMARg8RruQd5eHWLfrP6hVq4VHUckBLDH7BO0N6/lLqmfLiZyZ1hAdag4a6LkRBeKoPH+VQCv65A2MwtnsWyTG1OaorVqIy44h1fKGFDN33bF+h+XMHmxsb4lBCdJPQ8S0QRGG4dh77Y9WYXR1+P7zYB/RXDT0+r39ZBjhgankKJfvGRMnro9RjcOYfzyxEuYwPGu6XKVNxPt3X2ALybpdlPjPfkUmDsta4LveZ4qhGzz8huesDE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(261021121427099003)(261022105027099003)(261026121527099003)(261026140227099003)(261028144727099003)(4143699003)(11063799006)(10067099003)(56012099006)(260925021911599003)(260925021311599003)(260925022911599003)(22082099003)(18002099003)(55112099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWlRUktuUy9BTFp5Nm9XVExvZ1lRT1J1QVZMd2RQNDk4dUxCcEhsRWlYVkFv?=
 =?utf-8?B?NUtIV2dVSm1EYS9SS1BBWmVzbEtIS2JNZzlKUGlNL0dxYXBzaFJ2cUJXWVFv?=
 =?utf-8?B?Y3ZzU2poOUY4WDR0UHpJWjVYYjZLczZDMytzNTJwRjhVaFBCQmV4RFNlWmlI?=
 =?utf-8?B?Q3pML1lNeDZqMDJWS0RNUVA5aTBOQm9KTlBEc0UwVzRxNjF4NEcwSk11eXNT?=
 =?utf-8?B?c0Y2aEVKdTBUOEFHaDUvTm9MdXVrWFhpVDhIblhObkRoelZqMU9CazJ5d0o5?=
 =?utf-8?B?SXl1WGpMK0gzaWJYNWVxQlQxR0hiaC9aNDVuN0tTaW4xUWJWcVBkOXBZQmR6?=
 =?utf-8?B?MG5RUmkzNWtTdWVPWnJMZDNXVUVlcTA2am9vODR5QVhucHZheXZiSXgrMWdL?=
 =?utf-8?B?SFNYODMxMEpGU20waThEQURZelFQVTNSSFRjZ3dzZlZQanpPeFdXWXNQTU5h?=
 =?utf-8?B?enlsQkpRZk5XM25wQlp0a20rSStYRlVnV0Z3bzBXUDJtOStzZkV6bTlQZ0Fs?=
 =?utf-8?B?WmRBM2VYbEszQjRRejMvMTRpbTIyaDNMOTJBcGxFU3IyRUtCeU1meEFkU1ZQ?=
 =?utf-8?B?YlRlSk51VDJ0UG8wQnFQZS9VbldiLzlpQmZoZVoxNSs4dnE0YzhXZmZHaFVL?=
 =?utf-8?B?K2V0ZjZtQ2NHUFArMlh3S2hUNXVKWitqaEhDaEJCaWNrWHZNRHo0RnVWZ1Bj?=
 =?utf-8?B?Qm1TUjM4NGRjZlNKT296MUdkNzdoNGdDYi9CaS9TWUlWaXNISEF4ZG1iUFN4?=
 =?utf-8?B?SzdhbDV2VmtnZTR0YURybGRydk0vQXU4TXFMNHlSWEpQQTR4c1BrNTJnZ0g3?=
 =?utf-8?B?NC9NYWNZUzY3RFE2K042Z1gydlBJeFdsTmJ5OG92OTVoWnBkVEZtM1U0blJQ?=
 =?utf-8?B?c2VLbzZncThkVE1GV3FFcFJNdGhDcjR2UWU2WEhKOGtjdWxKUlFrZE5yRmdI?=
 =?utf-8?B?ZW1LVi9lcnNYbnpBWTBldmo4N1NYTmhqaVJVWElaZ3ZlUTNVL3NZdmxQeHRV?=
 =?utf-8?B?R0tFVDQrT1laUmVLSG5DR1dVY01aS2Z4NFpoYysxWTNvdDFiaWk4M1IrK1ha?=
 =?utf-8?B?WXg1cjU3bmtjN1hZTW5PaWJMY1BHbUxhVmhsU25pdkdWT05VRS9TSlZiNXFj?=
 =?utf-8?B?cGdDRDZlaDBZM2hOQXd2cXNBTEgxd0FJazRZT0twTzBFbUNMdlhvWmY0aFFF?=
 =?utf-8?B?NjNHRkFNNHQvajhKUFBwVDE4T3g5NVBhbzE2ZU0yZ3RwWEI4V1BPQ1FnR212?=
 =?utf-8?B?bk1NZnBOWHJNNmxNbDRuVy9EYU5qVGVDTnRTRk96NmdiSFJ5WkhXMnFxUG1Z?=
 =?utf-8?B?TWtYWFp1d2twUEdIVTdOTGpDVnFic0xNVU1GMFNPWlpDaTZ2VGZHQXdac2k5?=
 =?utf-8?B?VlhpdUJzNjErdzVudlFoMCt1WDFJZUluelY3N0VLK3lGb2ZLaWQxWmNJL0Rk?=
 =?utf-8?B?Q0Y1K0E3SUZlVmxGbTB0MHk5enRDR2d0eER5SW9ZMVdrSlc3YWtncGoxaytv?=
 =?utf-8?B?R0dMdlZ5NEVWaU5lK09sNExvdmkyMi85bG5icDhlQjdyNDIyOE9VSGxOWXlI?=
 =?utf-8?B?bmxYeGJPdHZZdjZYa0ljYmRrVnh0QnVoMUQ1TmkwRGExNE5RY2VtZkp4NC9F?=
 =?utf-8?B?d25LNFB3MUhLYmVpNFd0L2JkZmozTGRhZ0tPbTFsSVhOR2lRaU13YWRJcVkz?=
 =?utf-8?B?N245QkQ3amJtSWZyZnVFOHhEUjRzWi9WNWg4NjJ3NFhWN2JyeFRKYTBiUFlB?=
 =?utf-8?B?dEs3eFB1WUdIbmM0Q1VUbW41YVBtZDV0L2o5dVIzMEhOaFUxVER4Qy9XaUZY?=
 =?utf-8?B?R3VTV040SkprZ3ZSR0xjRndmdmZwSWNxM2ZFNHBxSzhneitTQmY2WFBDeFVD?=
 =?utf-8?B?ckdtSXVKVXEvUEo1OVRmV0hJRldnMVVZam5mZ09VakhhREFHYXVDaGlXbzM1?=
 =?utf-8?B?NTZVZG1kWlV1bGo0ZC80UEpaUWliRW1MRU83bWFEbXZ3VUZsSS9qdTBMc3Rp?=
 =?utf-8?B?M0NQb3B5dFdDT0NKSHNOSzZudHNFVkdjRGs2TWdOYnB3OXF0eWkxZ21qRTA2?=
 =?utf-8?B?enpyWTBxTERFMjc4QThYVUpVaVUrQkR1MVhPekVYMVpKRFZPVGJ1UmhXQmJq?=
 =?utf-8?B?Q2FDSnI0OVZxZzRqRks5TmxZMmh6QzE2SWI0Z1NvS0tMQWJVVnFNdlpyNTRE?=
 =?utf-8?B?alVaNzR5WVJSUzdzeURGb253akpwcWdNZlJrSlJ2S2dSb05lZHZFWTRORGZV?=
 =?utf-8?B?MkdwdThOZWVIQmVTK3pvUjdyUTI4d0pLU01NcXkrdkNuV0FscXkzWWR5endu?=
 =?utf-8?B?dm5lM3loVkhoK3ZxbksreGR4WnBVK2pDUEw2MUJPbEprT0pTd1VtQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0db1f52-fc5e-4b09-d9b7-08df38cecb00
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 10:48:13.0863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c+OxewLxDf0JsoNwQ+mttTX1fdzROXz3PtzcTlbL1wgbzbhFI/+LXd1iM13s9vzxidR0EpOdE4WloWjokkrQoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5930

On 01.11.26 19:02, Philippe Gerum wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Fixes: 2db757ed1c20 ("net: dovetail: enable out-of-band networking")
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>
>> Should go into 7.3 as well.
>>
>>  net/core/page_pool.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
>> index 13ef7c723a89c..6136471425fe3 100644
>> --- a/net/core/page_pool.c
>> +++ b/net/core/page_pool.c
>> @@ -338,6 +338,11 @@ static void page_pool_uninit(struct page_pool *pool)
>>  	if (!pool->system)
>>  		free_percpu(pool->recycle_stats);
>>  #endif
>> +
>> +	if (pool->mp_ops) {
>> +		pool->mp_ops->destroy(pool);
>> +		static_branch_dec(&page_pool_mem_providers);
>> +	}
>>  #ifdef CONFIG_PAGE_POOL_OOB
>>  	kfree(pool->alloc.cache);
>>  #endif
> 
> Merged into 7.2, thanks. Noted for 7.3.
> 

I think you accidentally pushed the update as "7.2-evl-dovetail" to
linux-dovetail.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
