Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795523412;
	b=rTw1ZG7buzrCW+tzfojI8sbqJV4GOtk9sC2ViMJyPKQ+nQypQnyePD3xflZx8TearFAy
	 fxDfQI94+YG55K4gZtGyg3jZC+TIfniD76rnWWm/aJQwHCvSmKTnXPCj/CoDKc2myZJSm
	 bWXx3bOp235/Ts1MrcepowMJxXqWOpwcV/GWhs8cib/8g3wIP/EXHws0Cy0b6iDg9ct3J
	 i8hzsu95rzRzM+8fjktIcpQSrfgaPY/zbF3kDUgc491+beAnzbBh2V2BHybIMrrGHVS2+
	 Tjj+R0xqdPwq7SMz6Qjh/aFEkmhl4Vmej7ULdaXCqlcRimQ8lOpdwdBNKwkcTq8PdjA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795523412;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:References:Content-Language:From:Autocrypt:
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
	bh=v6XQb/VFcX/n+CIqK5TYHyi+QTXxCkxO7YyakuPHXZ4=;
	b=iSj/pxDp84Pf55OM9yU/9RfCDYCPl1xDvM40lTNEEA0w9hPK9Owy7cvZr1i+xnQB0zlg
	 kHnmUnpGki/dHe2zFuolSlH0DT1Gn0xJovq8r1WKUDEMSw8iyvkHVTLA6U5LNo1hZeyDj
	 67k/H3xLplDyqzQ6Jp5Iw9PgcFj94Gg1VRLGnBOdzDVr+mJHC9YPbs7u4tXq7P82dQVl2
	 9YBzm5hmhp1rbK2Xa4YcSevreLDp7Cnbd8VYkr5vjib174Dx7L3rxgdD/wZqB0ud4nCw6
	 +7CnXR/SsiZOIzfRgn/WEdTgddLqhXD4mdotTShl1E0gSLrjnUsctdox8lvCgkdglzw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=yKf9CwwY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.11
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011011.outbound.protection.outlook.com [40.107.130.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04D2606A32A
	for <xenomai@lists.linux.dev>; Tue, 24 Nov 2026 12:30:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A04D2606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=yKf9CwwY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IDS9oQkzjfvHfMr0TK8UYMVGtrOcokobpUArfEHHQaWJoHCJ9hW42W9qBggFEl+DUSAYskpGU5Xx+taQoG8s+TfmjtuScMyAkrEjYaFxFb9lccmEjIb7QovY7daR20nAAl0CSXplgttDW5qufRZYVM97zY+JaFxFwcyBJm+UlCG4OEplVAeolWYII8TckDeIkSG7jnrgX2x85WtEs7PDta+MlYPmsL/7Gf+n+uVSufD7oEmyxQbcgCvxDMpCW1KczM2k0zHCdgfnp5frVLPzzM/z8v1zrm/8GLZm0LEGZHisk4esKjs7MrOcWt4CknxrvGTlKJtt1mcBYUBJmqE52Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6XQb/VFcX/n+CIqK5TYHyi+QTXxCkxO7YyakuPHXZ4=;
 b=Aqda4Dt2vTL7ZzDwzR816uPU+Y0pi7utl44Ddhjc1Tsp55FE03rnT9Nsp+YHGCXa1+iHJx2s8ILs1Jm9Vx7VV2i8zXmBChcUZA21hvzjWrgsSn+C6jETClmbUsGmcwYWu6GPiVSWC9mMd/qqKthzc2pY00G7VhNKar16Zv0S3XtGrldjIipVmBrXtY2O3T5f1IXAH6osIyYH4mLO8NxafkLNJeg4BL2NWOqABIWZNEUgx99ZQwR8SpozdXPnohp1RVA7UF5Jn2VNu3O5pb4GaVyHXlTVupp3v0T6RKCGSPRc/KUzh6pILUw4vjxZIpmK+ep9KnFGsYQ+uo6SHCTo+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6XQb/VFcX/n+CIqK5TYHyi+QTXxCkxO7YyakuPHXZ4=;
 b=yKf9CwwYxD1+CWhF/oa/hgSGgxPZKQAEp/Frjgi+NzRcsADd5UBxWlH8RXCyL+io/Gafu4Xrpw2IzR4ZF14k7g7WlQqQi6IdJ1l6djTo3mSeMZj1n/YcSI8TFRjeyg4DSjkeb8jM6RPVLMlZTVBGBC/kdbHr1EP9AAtgC9Emu5ga+0O9Vw7I+kTEMoBrUDvmTSvMId6s+uVVkFcQIuqYUQIjF4BvHeCsXuDKKZMmO1vHU2SGoS0TEnEHt6MrcErE8JAY3i3yJqI+Ol967agzyKPQV6isKLKS42sJkfKXYIT8GTW6aSTFvdDtbiFKTEeMS5uiEu+TRarQ1PWjeox7Aw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AS1PR10MB7957.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:481::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Tue, 24 Nov
 2026 12:30:08 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0662.001; Tue, 24 Nov 2026
 12:30:08 +0000
Message-ID: <ccfe86ea-2afd-4047-bc65-4dd1a35820fc@siemens.com>
Date: Tue, 24 Nov 2026 13:30:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] symbol wrapping for libcobalt
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@lists.linux.dev>
References: <877bi3thhu.fsf@xenomai.org>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <877bi3thhu.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0233.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::6) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AS1PR10MB7957:EE_
X-MS-Office365-Filtering-Correlation-Id: 229a1d66-4721-444c-a109-08df4a26ad61
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|10067099003|261028144727099003|11063799006|5023799004|261022075727099003|261022105027099003|261021121427099003|261021135927099003|261026140227099003|261102123227099003|261026121527099003|56012099006|6133799003|22082099003|55112099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	d400lpbJDV14ql7j9PkK3MmfmIzQt5+lnYD9bsdHcsXv66zDVcB2RvHDcJEB+q9tcU5ymGnDfhIoQq0Otq7rO92kRIGJnmkH10GmUdyXT6DXkRD6Gh4QNfN45pz/xsWBajcYp49z09MxM8uVt9hDcX1XxEigi140pqOhcyi92stTWjvLxeIRkvEdsnRo2ou8mTcRR5FYxP8tpO5oqxJBCWge9WE/w/GMrAJJ+0iEq6GvNfqnEjxBksdLS9HK8GJdgh8O9cSqB3y0Olsa7CT2oO6+cLsPycUfL/uxSDeR/rDYgaZSen1B4JZBLQ6NLxOV0aOGsvcX9yOIZdnjCO1Y1uzVUOt7vSbXe/yxMxiIRlVHz/07I8MTlyNPHxdguzdsbVn/joFoPPtWH+Bhe3LvV1eNtjtpgm/jf3o2eDz/pwJSvB0lKDLF2c+Q5nv7bAvFSyfNJpvBAOZiquPVYTNV+9Z+hyKMKLh2c+lhLYUacJOh/d620072rWaU2OGP59rCMjh+OzK93onrFnrJAQg7kjNSsf3zj7ltvNTeWdkxBZMhzmHSMLkRvpVtEHFD+YyiOfaIImJZMcNTwERgvePxIdZZEr48bHrpX4MLbAFJgMRfdqzve6vWFzh6JP5u7FiyyLOZSOXdSyRAuH7sK/BI2z7H7XcLsxUY8ET6ivhY7m0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(261028144727099003)(11063799006)(5023799004)(261022075727099003)(261022105027099003)(261021121427099003)(261021135927099003)(261026140227099003)(261102123227099003)(261026121527099003)(56012099006)(6133799003)(22082099003)(55112099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aU9XZVIxOTRqWkdLZFExZjlvWGlRblhIZmwyTG9EdTRYZXlHM2VrTWN0OCtr?=
 =?utf-8?B?UENzemVTc1JUZkt0Z2R0azVTVWdTZGc5S1YxWmhYUTV0V2ovZG9jaUVYT3B1?=
 =?utf-8?B?U2FoU2tHUUVEc2U1Q2VvRHQzcnBDWmtnQm9ZMkZnUzNzQmZ4MTkzbDRlcDBa?=
 =?utf-8?B?UDVlQmt1bDlJT0ZRYjNMUThOcDlheVY5dW4xYUdOdWVPckVWN1Q2QTRBMW85?=
 =?utf-8?B?KysybTlWOXlZVWlxR1RtRXZEaDBDL20zZ2hlVmpOS1Vua1dJZm1IWi83U05m?=
 =?utf-8?B?QVBzczNyRVRCdDVmaEZnMXZBSmozWm5kMW90eDB0MGk3UkZZWTRSWTlxQy96?=
 =?utf-8?B?T2RWMlNPYVZQdlB6TXVvdmN6QlIyU0dMdjBSekh6Y2pqR3VuSFY4cFF1TVpI?=
 =?utf-8?B?cUNvYVhnNWRBdUFrZ1c2VCsrUmwvTk93RjdkZFNpcFo5SDVjd250d2poNlZh?=
 =?utf-8?B?eFpNTk9jVXQzamUyMXVLMXFDbzJEZm5HeEJ5Rzl2TWNuM0Y4dXpPbDdPK1Rz?=
 =?utf-8?B?ZUJPY0JRd2RZR1RRRWJ6V0dIT1B6YXZZbHRTSklidmZJbTNTajZ4Ymw5OFlE?=
 =?utf-8?B?OG4relBJU3VEYzlndGpUcXJlZFVzU3phSklkc1FSMFVTMHpzSGpqb0x3UXNr?=
 =?utf-8?B?b3AxVy80Qm1OTi9od3BjaGdBQXhIa1kxejNpR29FbFlwQ0lJRXpqc1RLVjIz?=
 =?utf-8?B?OWJIWWJEQmdWd1F2V0p0cHh6UmRJNGFCYUgwRlFkUzVLSzZYWStabmsvRzN4?=
 =?utf-8?B?RzlGaWhGQkNxTTJXQUlpc1kveWJjQ0NKbVA0UlBSU203amJERVdkNW5KWHVN?=
 =?utf-8?B?a2czL2pZRjQ2RVRJM3VXYUVVbFMxMjAzVFlnMndzdzJieitQWUgzczg3WmVP?=
 =?utf-8?B?MWdDVXJUaTFOT3ZlSzFhMFEvTkswaCtZcGFsVERVbHVubXZVMjJ3Z0JnOEdl?=
 =?utf-8?B?NCttcytlbURiNWJBR1VzdlFpd1NUbWFYUDVVbU5jeTdjL3JRV3JQSXAvRTBD?=
 =?utf-8?B?OExvN0N3dkVsV3d5OUhBQ0JOdnowRkk5eHVWZ3VNNmhiZjZDeS92cDk0dW1U?=
 =?utf-8?B?T1YyOTh6WS85ME1VOG5RbzNEV2pod0VGdjFyY1FiSWJtTGV0Z0g2Q1k0aVVH?=
 =?utf-8?B?TXNpN2NMbytCN2UxcitNekdxZElhZUIyWGFUejE3SGMyYkxjSjVvVHpnbWhz?=
 =?utf-8?B?R2h5YmdCWFF6R1Y5dEp3UkJvZlh0V2JVMUlob2F2VVFQR0I4TldubzY3RzhD?=
 =?utf-8?B?QTNQTnNkOWFqY09hRllvRE9GL0loTzdkQ0R6ck5nbGJXZGNBUWpLU05Ec2xY?=
 =?utf-8?B?WTlDdHg1cks0T1pHWlZ5L2tYMlhFb1B0cm9lQU1EcHpjKzZVTTZvSU9oMnpU?=
 =?utf-8?B?ZERzL1UrbDAyVFFhTUlucE1hRHNjMG84UzNHTW5YODNZWHVDaTJHbWh1SGZy?=
 =?utf-8?B?R3d3UkVoaS9sSy9HaVorRmhZa1ZtMUZOczA0Zk5pSFhGdE9NT0RCa3M5Qmcr?=
 =?utf-8?B?OEV4ZnpCQ3ZHRS82SWtZN203MWlKRXVXemRzWWlvelRlbmh5dmRvalVRZkJm?=
 =?utf-8?B?dzY2WEZXVG9jaXBTZ3Bia3NtVUdmWmczY1daRWNjV0FHaG9WMm1remJkbHpZ?=
 =?utf-8?B?N0lWVGhMS2xNYWxLWHZKclU4azAxNVZCS0l3SmVjVVkybnpaTDhWZW1JcDQw?=
 =?utf-8?B?STJ3Vkw5ZklIVjZvVDFlazJibFB6UkR1NjE4TEdXclpUMGs4V1RJaFBjRExD?=
 =?utf-8?B?OUdjamY4OVNVRDlNZ1BaVnUyOHhVaS9SaHEvdVZPU1hGR3hVN3hkRzc5M0ky?=
 =?utf-8?B?NVVCWFVUTHRUU2lKclBKNStmRnVtYkpQSHNoSk5qd2pPSFp2RnJIVU94NE94?=
 =?utf-8?B?b0Zsa1cwM1UvdUVtT0hQMlM1dnJxNkJlSCt1Z0t3d0xzQ1pOQmdYU2xROFhk?=
 =?utf-8?B?VVFncFhjdmx4VFdIbVZJRjNsSml3bU91dmVBcDA4YjFQd3EyVzRRcEZVWjhj?=
 =?utf-8?B?ZHNlRWd1LzNWRmZUMExlNFZFK3RPK0FvRWRXZEtub2ZMbFhWaUd2dTBZMjZw?=
 =?utf-8?B?Q3o3ZDNmaTF5TVREVkIra1pHK0hSVmh4dWl3aXJrbzNmVlVPNnpldXNTZnJi?=
 =?utf-8?B?N3p6U3NjanBXb2NRSGlSVWp3K3dkeVY3czVWVmhlYVlpdWpwbWVHWWdrNkRF?=
 =?utf-8?B?OVNKNkRtSVZKVEU5ME0xNzNOcHVSYnFidDN5QWt2MXZWNU5rbC9YZ1pXeFor?=
 =?utf-8?B?VEpRaW1Mc0ZiVmovazR1N1JmdzRMOXVJSDJjWng5MWJSbmVUS1FyaXQ2WHNs?=
 =?utf-8?B?VURyUUpKMEF0clI4WGRLeGtYYVBZZHMrcHJkSnc5dFNiVDBqODBHdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 229a1d66-4721-444c-a109-08df4a26ad61
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 12:30:08.9108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OPS0nVMLMZBM/k/ScvURFVtRd2jvhpmO2boOI5/aG7hmqqvgy4k4xxZOQNyW8ygbWXB0rKvI/puw3ZMubcVLZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB7957

On 23.11.26 21:33, Philippe Gerum wrote:
> 
> Since its very inception, the POSIX API in xenomai3 enables automatic
> wrapping of POSIX calls to their libcobalt counterpart using a linker
> trick (-Wl,--wrap), so that applications can use the pristine POSIX
> routine names to invoke Xenomai services. For instance, the following
> snippet:
> 
>       ret = pthread_create(&tid, &attr, foo_routine, NULL);
> 
> would translate internally to:
> 
>       ret = __wrap_pthread_create(&tid, &attr, foo_routine, NULL);
> 
> which is a weak symbol alias to:
> 
>       ret = __cobalt_pthread_create(&tid, &attr, foo_routine, NULL);
> 
> The significant part of this wrapping is that we go from symbol_x in the
> source code to __cobalt_symbol_x at link time, with libcobalt
> implementing the latter.
> 
> Over the years, we noticed several issues with this scheme:
> 
> - because turning on wrapping only happens at link time, there is no
>   indication whatsoever that some object file does expect wrapping to be
>   applied by the linker when producing the executable. For instance,
>   compiling such object file with build flags obtained from `xeno-config
>   --cobalt --cflags` then linking with `xeno-config --posix --ldflags`
>   would successfully create an executable, which would send all POSIX
>   calls to the underlying *libc, which may or may not be the intent,
>   depending on which xeno-config call was wrong. When building an
>   application from multiple parts which are not necessarily maintained
>   and built in the same team/organization which uses them (e.g. 3rd
>   party libs), this issue is a source of headaches. At the very least,
>   we need some guardrails to prevent this from going unnoticed.
> 
> - symbols in static archives are always wrapped although we may not want
>   this. Likewise, symbols in shared libs are not wrapped although we may
>   want the opposite. We have to resort to wrap-link.sh to accommodate
>   complex library dependencies, which makes the process quite brittle
>   since correctness here depends on the order of appearance of each
>   object and dependency in the link args. A badly ordered link sequence
>   successfully produces an executable, but the latter behaves
>   incorrectly.
> 
>   For instance, say we have lib3dparty.a which is a mere in-band library
>   that does not know about Xenomai, but is used by a Xenomai application
>   for non-rt business by threads it starts using some mundane library
>   service (e.g. libstdc++, via std::thread). Some foo() service
>   lib3dparty.a provides serializes callers using a pthread_mutex_t lock.
> 
>   We then link our rt app using wrap-link.sh, with lib3dparty.a
>   appearing before libcobalt because this seems to be the most natural
>   order to most users at first glance. Which would give this under the
>   hood:
> 
>         g++ -static -pthread -o app main.o -Wl,@cobalt.wrappers -lthirdparty -lcobalt -lpthread
>         # stage 1: g++ -o app.tmp -r -nostdlib -static -pthread main.o -Wl,@cobalt.wrappers -lthirdparty
>         # stage 2: g++ -o app app.tmp -static -pthread -lcobalt -lpthread
> 
>     Because lib3dparty.a comes before -lcobalt, the library goes into
>     the --wrap stage, and its lock is set up as a Cobalt mutex by some
>     init call in that library. Statically linking against libstdc++.a
>     does not help, because this dependency is injected on stage 2 when
>     wrapping is no more enabled in the link args. Mere dynamic linking
>     against libstdc++.so would not help either, since symbols defined in
>     a DSO escape wrapping entirely.
> 
>     And now the fireworks are set off: when the std::thread workers
>     attempt to lock the mutex using the plain glibc service, they
>     fail. At best by crashing, at worse with EPERM. Not everyone checks
>     pthread_mutex_lock() return codes, right?  So now we have multiple
>     workers stepping on each others toes when accessing a shared
>     resource. Zero indication of this happening except maybe weird
>     application output or crash. Perfect day.
> 
>   We could use C11 thrd_create() the same way to create workers and get
>   into the exact same pitfalls without involving libstdc++ at all.
>   

To be fair, using language provided threading and locking is generally
are recipe for desaster on PREEMPT-RT as well because most are non-RT only.

> - a POSIX object such as a mutex, condvar or semaphore can be set up on
>   one side and used on another, and we have no way to detect it; we
>   usually receive obscure errors at runtime, in the best case the
>   application crashes. Things get uglier with C++ when inline header
>   code gets wrapped and out-of-line parts are not.
> 
> - the y2038 issue makes things worse: v3 needs to keep yet another
>   hand-written list of wrappers for this,
>   i.e. cobalt-glibc-time64.wrappers so that time64 calls in 32bit builds
>   end up at the right place. The day the underlying *libc decides to
>   redirect other symbols to whatever build-specific counterpart (not
>   exclusively time64), we can only notice this after a runtime
>   breakage.
> 
>   Also, since the glibc headers know nothing about the __real_* symbols,
>   they won't redirect them to the proper 64bit implementation but keep
>   branching to their legacy 32bit variant, unless they are declared with
>   COBALT_DECL_TIME64. It looks like v3 may have at least fcntl, and all
>   the socket *msg calls escaping redirection right now. There is another
>   example, which is harmless this time fortunately, with wrapping
>   pthread_yield(). A recent glibc installs a redirection for this
>   routine:
> 
>   extern int __REDIRECT_NTH (pthread_yield, (void), sched_yield)
> 
>   This means that __cobalt_pthread_yield() is not called when such
>   redirect is in place. The only reason that keeps it working is that
>   pthread_yield() is redirected to sched_yield(), and we do intercept
>   sched_yield() anyway.
> 
> - when link-time optimization is involved, any references the
>   intermediate representation may add escapes wrapping. Once again, this
>   is 100% opaque to us, we have no idea what happens under the hood.
> 
> - there is a cost to implicit wrapping for I/O calls such as open(),
>   read(), write(), ioctl() and friends: we have to try the Xenomai side
>   first, then fallback to the regular *libc side if that fails. Granted,
>   this is only a problem for in-band code, but still: although
>   SCHED_WEAK threads are running in-band by convention and oob by
>   exception, they should not have to pay twice the price for each
>   wrapped I/O system call.
> 
> - on a more general note, we times and often recommend that a clear
>   real-time vs non real-time split be enforced in any application which
>   runs in a dual kernel environment (I'd argue that this should be a
>   rule of thumb for all rt designs, even those served by native
>   preemption as well). Doing so is basic sanity, so that
>   responsibilities and constraints are obvious from the get go when
>   reviewing the implementation, and we don't create situations in which
>   rt-unsafe code is called from a time-critical path too easily. In that
>   sense, symbol wrapping blurs the boundaries between rt and non-rt,
>   which contradicts this recommendation.
> 
> I believe that the last point carries a lot of weight in favor of
> explicit annotation of libcobalt calls in the application code
> (i.e. __COBALT(), __RT(), __EVL()). However, I'm not recommending that
> link-wrapping is dropped from v4, especially since we need an easy
> migration path from v3, but at the very least v4 should prevent misuses,
> help in figuring out where problems lie with symbol wrapping. What I'd
> like to see in v4:
> 
> - a way to somehow mark the object files that did include the libcobalt
>   headers, so that linking them without -Wl,--wrap fails.
> 

Already some idea for how this could be implemented?

> - conversely, a way to mark the object files that did _not_ include the
>   libcobalt headers but the regular glibc ones, so that linking them
>   _with_ -Wl,--wrap fails when the wrap list contains inconsistently
>   used symbols.

Well, the absence of the marker above must be enough in order to detect
pre-built standard libs.

> 
> This metadata could be used by a checker tool that would answer the
> following question: "where the heck each call to libcobalt services
> actually goes for this executable"? It could also be used to generate
> the wrap list on the fly for symbols which carry the 'wrapped' marker
> by inspecting the object list.
> 
> Icing on the cake, it should even be possible to use this information to
> implement auto-annotation of source code by reading a wrapped binary,
> i.e. patching in the __COBALT() annotations mechanically, for those who
> want an easy way to depart from symbol wrapping for an existing
> application.
> 
> Thoughts welcome.
> 

Having wrapping as an opt-in layer on top of an explicit
POSIX-compatible API sounds fair to me. Then only users who need the
wrapping for a good reason can select that separately. Technically,
users could already do that with Xenomai 3 today, but it is not
presented that way, thus likely only few will do it.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
