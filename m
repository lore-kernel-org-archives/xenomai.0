Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2071.outbound.protection.outlook.com [40.107.13.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68C11754B
	for <xenomai@lists.linux.dev>; Mon, 27 May 2024 06:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716790951; cv=fail; b=kr6mppmjX1xGmcUw9CYnV2/F5GvxlGgIZSgY29nrHTvEWmN/zJVrIGzsdTYM2bNx256G5iG7q9WHYC3nCVRJgUxt8El8RGsLFD+oFB13CLiHi+TM7h7iS0y9yaWZNJjm5X/OFqicfY5QIcxWaaGYds4LO1xz8aFb8ZaQZYnyhoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716790951; c=relaxed/simple;
	bh=am3OVoOBl6dsqEpO4QGDG+m4lsf4s+1wMN3eBDCshsY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XbLfSZ/KzdI8ztREET6YjH0o0u8FxHYeozP31GSgGeYvCcFBLcYm8vIzqgfmyAM5svGtXGu01ZLCcg9zx8SCH80L76+1rv9XxLjHPwO6DlUlt/de4x1YZjJgUmamWlkdunJXwAqeFFD05Z+zZNVYg1bosdge0giaUTmweqRlb2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=IG7VRsha; arc=fail smtp.client-ip=40.107.13.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="IG7VRsha"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVfTBG0DVoPrNq4YlAdy0+b5XxOvEPIHQybGcoJ5xFLOQRHotC6xveGg3BB0B+VTi8seCfoEibm4u0TOBaKeQRs8ywaJb6Z8RqiNVdIGKY4iTSGhBOpBvokscRvAdjW/oIWeqc3FiY52J9Fj+FDt3qWR/PA/X3VJrgRQtllno0Ei1p1Zthvanpgpmv0YJbNWLbGM8q9+7pNgtHLdYmW9/AoEct1m23dVNll5CyhFYtCelDDWRFEv4Spo8dD259skertFF50jcvcfJn/Rxl7OU1qFxVOXtxzvw244Qs+23fHuwOoR7nd7vWyIjb7T9Yrbor1EbLNYTmxNbcaRYVjMIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNr8vILhtbDEzjsJYRYEaRWWOpn9cJAb1qILr5X9lCs=;
 b=lvP09qQPDaJ5NQjl8va+CVy4VEaml9/LMUcOO+4InRmGXHYsehV6IQlUN0S5P9uu6kL+WCP2dDsWfCgVR16PenI5GbQlifQC2bsy2PmBtgHqxyvr6BP+mVdBfBo/5PFHCpmUHJmNtCgOXwyzuC0soeltVtmTt73jmZ1VvPZHjBtA3pFiWcR/gDaPfO4+cLdbG3TAXIqS4zI+7Q6DTIKrRjMJqRenkKq7ZpSPRCI9M2ygfHGo2Kvexlq7+PaFtlnOFY3bjCWgt670NQ0nD2bP31dhPmL1MROfomTpUgvvfWfjvKTnqhlKkL5th+WNtxPR1b9BOSl3WKfsyJAwYiL5Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNr8vILhtbDEzjsJYRYEaRWWOpn9cJAb1qILr5X9lCs=;
 b=IG7VRshagiaL3FDflk9Vl49QLLL04+AiiTw86kV6QC0EJ5HPOqe2TLVyYaSj3uLwE0rtSSyvycfPX2DYtrbTdzOeKuD8+SrTDNncmL/cSn7uHYs3CJlVyFL15lfKbPKsiav3uHrP+x8l0XdnEYT8ixp5rj7LgkfL1Bj1r43ANKPBcyR0vn8lGiDUXE+1HJHrX98BvfQtKynHh5J/5yFikVlqkwkwZV5RFtyf7hTCrITTaNmIsg0C3fYgrXpetRNtA7hP9pAsB8W1b4MUEfu0DT74ah2o+ZATn46Eba3gVu1gnAHbb2bMv+DTiQubn+/F1KdbPUhVhP1VBb8G8R/phg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8559.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 06:22:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 06:22:25 +0000
Message-ID: <e9dbdda0-051b-428b-974e-e10db663d1d1@siemens.com>
Date: Mon, 27 May 2024 08:22:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] cobalt/thread: kernel cmdline param
 'supported_cpus' cannot Take effect in create [ROOT/*] idle threads.
To: =?UTF-8?B?6ZmI5Yqy5a6P?= <chenjinhong@sinsegye.com.cn>,
 xenomai <xenomai@lists.linux.dev>
Cc: "florian.bezdeka" <florian.bezdeka@siemens.com>,
 =?UTF-8?B?5a6L5YGl546u?= <songjianwei@sinsegye.com.cn>,
 =?UTF-8?B?5YiY5p2o?= <liuyang@sinsegye.com.cn>,
 =?UTF-8?B?5p2O6IOk6aKJ?= <liyinjie@sinsegye.com.cn>
References: <c572a244-dc12-4b13-a159-373dfcd2d492.chenjinhong@sinsegye.com.cn>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <c572a244-dc12-4b13-a159-373dfcd2d492.chenjinhong@sinsegye.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0135.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8559:EE_
X-MS-Office365-Filtering-Correlation-Id: 5faaa7f8-6775-4dcb-8fa9-08dc7e156061
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bVZRTWhYTmx0WE5FVDl2QXBsb1NxWW1sN2Zwa1c2Sk5jeTJ1QTlRZnVNTHRh?=
 =?utf-8?B?RlYzQWs1VG9kT0wrRjU5Y3hqOGgxTjRRTVR0eFNob0czOG1sZU0wdWFjYmY3?=
 =?utf-8?B?bWJpWmNBSDVlT1RTdnJlQzd4aWllWTdyMXBBWjV0N3NkUi93R2VJWjhKU1VL?=
 =?utf-8?B?U1pZM2VlSjNBNWVOanJuOVlZcnUva3pZZ0VueVZBRG1FSDZCYVJxZlV3TU5n?=
 =?utf-8?B?SGQrMjQ2NGhIbHpEZkU4VFdFK2VoZFpad080YnpTSUJtYXptRDdDQU0zTjFO?=
 =?utf-8?B?TUtXUGg0enZLYUQrd2xLNitDU2lKNjk0ODU0MkRGM2xSaEgyQzZrVXdCcUtW?=
 =?utf-8?B?ZDFWQnF3eisxRW9RR0dDQktSamg3SEg2TXZYVTlINHhHSk9jV2dXRDA0UE4r?=
 =?utf-8?B?bUpSeVRQUE1JajZ6UzVYMjhkSVhqZDVjbmdaN1VJN2ZGRjArcnJaSmYrRzh5?=
 =?utf-8?B?dGVmNTZFQWdNVEg4UW8ybnkrVjkzK2hvQzdyd25qVmtXV21VR0tURHBxd2x1?=
 =?utf-8?B?SWh3TXZhTTQ3VWJYd2J2WlRKWm5hLy9zb1lMck14ZjdkNUs1c0c3ZHJTMEl2?=
 =?utf-8?B?OXlsV1J3YkMvL1NMVnNHMndQeWNwMUhJZmlQb0l6T2drZEoxUXRkdEhnNlpx?=
 =?utf-8?B?L0sxT2d0YjFOd0xGOEdhWG5wRXlweGFrajBlUlMreDMrelNqRGxOZUozckVN?=
 =?utf-8?B?bFR3MU5GYy9FZld2QjNGVVd0NTVmVzFaNGE0SHFwQ1FvdW01b04xVFA0ek1u?=
 =?utf-8?B?WXRLK0V5b3daRUJZODZUZHcyQkxlY240QytlSkQ1NzcrQVdUVWdPNW1xbnBD?=
 =?utf-8?B?Q2k4MkdVUGlZZmRRMHRiSkhadVhjMXlsRmIzdGNpWGhuZDlEYmpmMWxtbkFF?=
 =?utf-8?B?SVV4dDNvNVhTakxuYVBvdWNqc09mQjdScG1nRnJRWG1nUXd5WmlUZmRhb256?=
 =?utf-8?B?Rmc4Z2E0Rllxd0pLcTVMcUZIeWpiYUEzVXo4NHk5TGdxZGFJTGpVZnB0aVdk?=
 =?utf-8?B?THdabzFSV2x5ZDFWeUdjZi9maFRXblJ1enZCTDRmOEZUNkRSV2h0c042OFdU?=
 =?utf-8?B?WXZISjhaVXJlSW9mWldkRGlzd05ndFd0NkdENGV2RHB3eGd3OWlzUG5GL05L?=
 =?utf-8?B?QXU5T2lyeStJVm5EU2VGbjZ1czNYU3pKQnVyNm04VmtrMnVIaVJXUXNUOE93?=
 =?utf-8?B?OGhIZDhEZE91LzhzNHIrdjVXWVk2SitGVnlBTWR0UDJGblBzUERzMlhqRE1p?=
 =?utf-8?B?N3JkYjhIek45ZDY2Snc2VnM4SkRIcVBqN25nUXVsM2crWXg5bTRZV0I1SmFD?=
 =?utf-8?B?cCs2VE9EWStQMy8zUWoxa3pOZFIvd0JmeW9qaFVDdGdGdmpicjVtU2lpMXA3?=
 =?utf-8?B?Sjg0eWJyUDhIb1F5S1ViSXNtN2xzRzRIZ0FRNHNGY2JLdG5TREpBcUUzZm1x?=
 =?utf-8?B?akZzSys3OEhlOTg4OTZWWWFvSGtzblNQbXFheXl3SEljRHF6RmxYdk5kR3pW?=
 =?utf-8?B?WXhjNmNCNThKK3hNaDR5VWlEZXc0QnhyallxWS9ORDVJeXM3SmR4WlFYNUt3?=
 =?utf-8?B?NGxGYmlxTlVWQ09BU0Q2RWtVT0M4Uk04R0NPR0swUHJaMkFYWnJaQ1g3MG5Z?=
 =?utf-8?B?VENrVXppTzFEdmVuU0ROYXRqRnNoZ2UyMUxmZHA4ejdiVzBucVBWenhLVlVZ?=
 =?utf-8?B?ZTZiMUxXRVJmdlJGcGZ5OUlUU3BSTXp6VWM3QVkzK0FKanNBOXgwMXlRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2NRWC9JZVdyQThUeGIwWHUzQXhXRklrdEhYaG8yQkloc21jN0RTWE5QeElD?=
 =?utf-8?B?cldscDgvTjdHTFphNENqRkVYN3E4b292NW9EVU5DRE1XOWdkN21Zd25hNmVk?=
 =?utf-8?B?WTEyMzYyUmdsOWhFRGRNb2h0WE0yUVY1bXdtcjY1bTFDTktYZ3kvQ2s2bldl?=
 =?utf-8?B?cFRCNmprcDFGQmpzWVBRYndic2Z3ZlJBSDZKb0p6OUZzb1dPV3VybGxoOHFD?=
 =?utf-8?B?ZEJDRXJYSnhyYlRTR1ZNc2t2bS9qUk9zUjc5emlhWml6WjN4QkZhQ3pROGtZ?=
 =?utf-8?B?bkhxWTRVblY3ZzBwZU9DdHhiQnBNSU9nSi85dGRJYkxzL0RCaFVpVEVUTktz?=
 =?utf-8?B?eUdXSWVGVzlCR3dGZ3VQU0ZNL21CY2Z2ZStRN0ZBaDcxaTNlbXNXVjFkQmtE?=
 =?utf-8?B?SlFoNFI3bmhDTG0rQTRITDVkN0E1bTcyQzdycTk1UTJJWVhYRHpzWWNWZGl1?=
 =?utf-8?B?K082M1JmZ3JmazY2NVo4c2ltbHlkdzhDZlVqZEdIU2pHTFBMRkN6N2lLb04z?=
 =?utf-8?B?NmJ0MVJNVDZMZlQxMlo3R3d5Z1NGenFqNDU5dE9lbG9WUXlRNnkvOVlTb3FI?=
 =?utf-8?B?UzQ4S0ZZOFFVcHUvZ24rL0ZTQUhvbW9zVWtka1U3WWlmaVJ0RGlRNHh2L1ky?=
 =?utf-8?B?SVdmNHYzaFErN1JvT01kemdXOHhyTEloSzVmN0Z2Tk9aR2xjSWVyQW5mSnQw?=
 =?utf-8?B?M3Zhd1k2YjgxaW5venB1UzBPUjBOanVzSFlxakhIUWEwZ0VMMzRlOHRXbm9s?=
 =?utf-8?B?WDdqc3ErUW5LM2lXSGRVUzJRdThvZHliTS9rQi9kbGdMSXNNcXJ5TnZyZTE0?=
 =?utf-8?B?c3RZdHlqamJ1UGxiUUJBYXJtVGhGZkRyenNqbUdzQklrN29jTTVzTXN1UVcw?=
 =?utf-8?B?Qm44ZHI2bFNERml3ZldtK0czSVdqdUZWRkVWdElYV2JoemRFWU1LcE1acGZi?=
 =?utf-8?B?N1F1dklIaW81QlpSNE9BTDZJQ2ltaVhTbTc4TlRKK01PQkdHZmRacGNtZXhs?=
 =?utf-8?B?V3ozU2ZlZzB3bDN4ZDJtTzlqc21VSHRrZzFiTXJ1V0QzZVZ5VWFydGtCVHB2?=
 =?utf-8?B?ZURuZ3Z1MW5oS0ozdUJZa09PenZ3OHNicUVaakVrdFRJUldid2lKMTJibi81?=
 =?utf-8?B?SEFVYUZMd1Q2OHRtWWV3NDJMWE9ESDB5SjI1dEJsNXNwN2RLUHE2dGdNWWRQ?=
 =?utf-8?B?Zkx2QlZiSnNwQklyVUZDditZTzA1bkMzOHlYYnJ5Um1iZVUrYjE0Zis3c1Bq?=
 =?utf-8?B?Z2Vlbk82bVUzOFVsVXVtN0JwQmdJbkIxS1hET3A3MXA2TmZ1WWFkTHd4SEVa?=
 =?utf-8?B?L09RWUFvV2gvUytwSFhzQmNDcDVWZmkyREttYTJ2dEJ0cWM4RmNpQ0VWV2c3?=
 =?utf-8?B?by9LL2hpalpEWXl1cXlTZEJ2cDVEeTBqbWNYTWs5RzU2aU9HRnBVVGxta3RY?=
 =?utf-8?B?cFptNjJlS2xmTnpFdWVIOUVuMENENHhoTUJqM2U2MXkwVXdYQlNuM3BwMlpN?=
 =?utf-8?B?TWh5ZXNVTElOTk82RUJGWTB2UjNWYjVYazVsS1dlN1lFd3R3L2I5RFFrYlcx?=
 =?utf-8?B?clhQaHZVT2ZzVW5TZUE0aFJRNVpyNEs2MW1wVFBmc3p3N0pHckUvaEhKT252?=
 =?utf-8?B?QllpZnVHbmU2TnRqQzh4TitzbjFQWGY2ZjNocUoyd29Idk5IdnVlNUxzdTho?=
 =?utf-8?B?WUxpTnJyN0hCQ0FXODdCQ0puZXU3SEdubHlqMVdMcWNKSTFNclowUHRjeEpU?=
 =?utf-8?B?TGlVKzl2d0svb0N2ckFJVkJwT09FWTM5UEpmY2UzYmVLL2s4L0hOY2hMekNG?=
 =?utf-8?B?OWswNHIrRnM2ZmhkMUIvREtXYmVuc0k1YWZWMGJzNDcybUhxTFZ0cUdLdUxE?=
 =?utf-8?B?dUpkMTk5T1IwRGNHZ2tSOEY1UnVkV3lNVTI2WmRGMy9tUkV0NytiRzZCV2pp?=
 =?utf-8?B?b0swRG9tYndtVlUvcUZFcDVrTnNyTnpjMUt2cEhpamkzdlR4bnMwL3dSRUR5?=
 =?utf-8?B?ZUZ4NUdBS0tEanpNUDYzODNnMXpHeGtTTDAyam9iaVhJQ0Z4UkhZMDJLbGVC?=
 =?utf-8?B?Zm52Vzc3NDU5c0ZtTWVHTmo0cVFXRDJGSnY5bzRSTFc0NmJ1ZENDMG56NEVh?=
 =?utf-8?Q?xi9G2585+QWtppdQXlWvUAxCp?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5faaa7f8-6775-4dcb-8fa9-08dc7e156061
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 06:22:25.7265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0rOKiIA8kz+s/dzqIA/PifNsRN0dk/C5BqoyUIAODTrgjeuoCuDviEYYBOuyD9MBlM1DB1qpVudlnauk1O1MRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8559

On 27.05.24 07:44, 陈劲宏 wrote:
> From: JinHong Chen <chenjinhong@sinsegye.com.cn>
> Date: Fri, 24 May 2024 15:48:02 +0800
> Subject: [PATCH v1 1/1] cobalt/thread: grub param 'supported_cpus' cannot Take
>  effect in create [ROOT/*] idle threads.
> 
> This is the patch for supporting 'supported_cpus' param of kernel cmdline. For following version:
> - Xenomai 3, Head of stable/v3.2.x branch.
> 

I'm not yet getting the problem you see and how this patch contributes
to resolve it. Or is this intended as optimization?

We are currently initializing xnsched on all CPUs, not only the
supported ones, and that has a reason I need to dig out again.

Thanks,
Jan

> Signed-off-by: JinHong Chen <chenjinhong@sinsegye.com.cn>
> ---
>  kernel/xenomai/sched.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/xenomai/sched.c b/kernel/xenomai/sched.c
> index aa65fd7f5..2987899b1 100644
> --- a/kernel/xenomai/sched.c
> +++ b/kernel/xenomai/sched.c
> @@ -231,6 +231,8 @@ void xnsched_init_all(void)
>  	int cpu;
>  
>  	for_each_online_cpu(cpu) {
>  +    if (!cpumask_test_cpu(cpu, &xnsched_realtime_cpus))
>  +      continue;
>  		sched = &per_cpu(nksched, cpu);
>  		xnsched_init(sched, cpu);
>  	}

-- 
Siemens AG, Technology
Linux Expert Center

