Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2089.outbound.protection.outlook.com [40.107.6.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD8F194
	for <xenomai@lists.linux.dev>; Thu, 19 Oct 2023 04:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="OMb/j9dZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SsEZNltw9qmNQYd+w47Vqe/TDy7ifE5bCanutm1xaAoZ804wmFjRxMTC+TnlESM6Qvkv2+uimTmIBCry3f6k0OEE9XCkim5BcRVcqYXbvzvg3IPGzKvwiuHQnF3ZHCekqdXOSbCmA0L2KYbZeFAs+rcQDi47mkqj4Tgr+fG5qfZmjuPiA3cc/e3G66LWN2eApMfzb5jVPASWm7XIhKVOOY9r4QA2Itxfqt6iT5KmJT4ydPgarC67oN4y3JA5znMc8LMUPNwWkM6HoPScFLl9DKVL/25QJL2JtruLA5q1zd7ND4XTsvkDyaHsx3Nhc0VBTNANObmxZVC0k09BBsaAYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WxM2O0R0wOQ1FrPQAIAm755WwPYsYHgwT2SVdMRqKZU=;
 b=RNu+Gurer7zWaaSk32BJoyPHx29jdAss8eNczDisa2MVZd652fQZ3ZJ8RvdFSoMyzlZauMgcJ0DPaZxIvog7yVsKIxnuXnJYUelGL1PMh1fS0XAkcnMPv1k0tI73u8nd7Os49YbLf78G68CxGndatad9Rx05eyW09nxaSPlXk/S+jEeVi4zThjUzsWXeKm08aM/dOUKvWZBq4xFEElVSAWSM0GhTbEISfXi9j+pjLCRXXDRZAPKRt63KRAioFhnIiV+J9+gApuM9+tn4XVKagmDIPLf3oXjDjEmQ6q2KJWflWsrKMz7l492u9aUc7RGw7MKqOON1I+3TaO4jFXhD+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxM2O0R0wOQ1FrPQAIAm755WwPYsYHgwT2SVdMRqKZU=;
 b=OMb/j9dZMfEGcdaUiiGhWobVEDsp48fDsh/cbz5OPh+awpMWkqsASyjhavHN9fqRQb/ocBwmuS2++bCvoRREopPfsizQZu9MjnC8I5DkDZ5TcNhxj7Qd6DvE7guPrVN/JoQADu3Xr9DKOISgVNnvuGz59UHttm+nQE4vISRJE8Dzjd194qiTIOraXEilp687eOwPgnXLdkoQ1yvfHkOiTkd4BGPinomj8QXmlKTfBEOljQP6WLAW3bYPYgHWjsfhdl7ioxl04Gw7pkpLjRWawWt+6AsioQl5Ed079337MUe/1oPDMlVh3gfRd1TWidfbYUn/Jt+baX/f3Vl41uc6dA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8004.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:16::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 04:43:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5%2]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 04:43:43 +0000
Message-ID: <917e42af-545c-4439-bac4-78d1f9548931@siemens.com>
Date: Thu, 19 Oct 2023 06:43:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Cobalt kernel parameters
Content-Language: en-US
To: Prasanna Kannan <prasanna.kannan@ipg-automotive.com>,
 xenomai@lists.linux.dev
References: <2047000542.27707045.1697689065162.JavaMail.zimbra@ipg-automotive.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <2047000542.27707045.1697689065162.JavaMail.zimbra@ipg-automotive.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8004:EE_
X-MS-Office365-Filtering-Correlation-Id: 72fa56a7-628f-404f-7c27-08dbd05df928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lKkWQe3Ndz9iWv1iVJCntNLGEYleYU0VhEE5PZ9cIhheoeJnB95KIwjc2Ad3OzUsteQbItLydNDHjAPNPU6XnnGRG36yo+KS6ObsuTbSZJlII37L1kafxNmQHY39EmNsCoxYutgK27tOs4JYgkRSyzYwzfFx7eivnX86NSDzk+B0Kox0B3OeqpV/MXaJ+V22kgU2F3rz2kBHKbaqE3wosSRjz2SkIzIAz4UUHenemCmC0FIHk6pbzlpo5+OULzYX9zpZkPkEhEIKf1BXod8LRJIcsQKxyTsBWpPyfCDPnI1+SzXwlxRfDfEGRDj5ULTw5t63Q0wMya8Vm84FV4wJrr2r3hu9JOtnhYQ5WzxR4TdNZ/mu7jSDNM1cydnolDrlCVKKGgXY6SyiPcE7a4eYXgRp4SAsSyiK6P0wUP57qWU281rBj9/vpKPHcuateBWnuSvPLERnHTwvAk6CH12QyGZxQVtiNTDOViJd7ZTj8kMg2loESXG7Rhc+9XptiRYWaEn8D6N/utXjyh3SCvV1mT1dFYFqQFlYP0tb+r6WSrpjPjXvqdYcYI64pwMQJ2E6GXBCYbRUKODRX2kpwAiAp6Ku72SRJIKJGcMAvDjwelYRhtvugfp+2JvFyor6FKXDPGWuT9mKDNMayEAa1omIOw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(346002)(136003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(38100700002)(3480700007)(53546011)(2616005)(26005)(6512007)(41300700001)(8676002)(66946007)(44832011)(4744005)(2906002)(6486002)(66556008)(8936002)(5660300002)(316002)(66476007)(7116003)(478600001)(6506007)(36756003)(83380400001)(82960400001)(31696002)(31686004)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlpuUEQwTVlYRlQvMndQV2VieExjY2svWXRiTGNtY2hldzJhM2VlZTQ0U1dr?=
 =?utf-8?B?K3N0MEQ1eU44YjE4a0d2bTUxaUs3bXA3bkFPRkg3RCsxV0E1TDNZYXIwdFEz?=
 =?utf-8?B?WE9nUlNIM3BXaDVXQnM3d2pYVUR5MDhueVoxd3o1RDZHajJTNnV2Y2Znem9S?=
 =?utf-8?B?WExxK0tsTGVkVVJkdklGajFIbFllbVN5UWxHYlk0Yk4rZm04Vk1IOVZhaWdO?=
 =?utf-8?B?Ly9YTTdmMjFIZHdTRjkrVVZwdzNTTEdybWhQZjgrQnpmdmRKTmNLUytoWHBk?=
 =?utf-8?B?NWE5R291MUFlaVRzNXRwb1dla2tLTjZPYnJBWm81aHRrVXpFdlVsemN3N2FL?=
 =?utf-8?B?dmZzcmVDQnNOTEx1b29CZDZVbWRPN1l5RHNCWktLeVBWYWRFSnhMbS83TmhZ?=
 =?utf-8?B?Q2JpV0twTXRsamZySW56ekh3QVd2MlA2OE12cXp0M2dZcVorMGRYbjhwbFBl?=
 =?utf-8?B?c3ZjTGlHckpCaU1JVXl5N0M4M3pSWDZXWlUvNS9ra3B5ZFZhZ1BEbDloODVl?=
 =?utf-8?B?SzZBRE9QSFRJbkJFQ1c5WWFwaGhEZDFZN0lIY1NPTm9lOGtVQkdMeW5aVC9D?=
 =?utf-8?B?ejdGNlRwOTlEK2Vnc2V6eC8wRE50UWsxbzBtSFRqSGxXUGNDYmp5d0tNazNh?=
 =?utf-8?B?RWVocEZHRFVpMnVHMmJleEJNTHhtbXVhQnNFVXA1TGZJQkFLckpBeEJhbVlW?=
 =?utf-8?B?M0pYc1hBaWdicmFsdFRYVFdMcVc5UWlzeHFiSUdDM0d1OHY3cDBxSVVaRGtF?=
 =?utf-8?B?TGVkQlF3MTJNRGdmZGl1T2U0dksyazBic0F6NVNTNkpJQzlnNTU1NVRoQ2hr?=
 =?utf-8?B?b2ZwMFlCeWxkamQ3ODZqL0EzTUlaSDBEbkdCVXYxSVNaTi8xWERRNjZqNGUr?=
 =?utf-8?B?VTQ5ZkdLeEVLZVpaTHFKY1hSTzNjRXJhZVNSKzlJL3cydS9zb1R5N3A0bUdN?=
 =?utf-8?B?QzJ4amRKMHpiSFZOWWcyQjRHV2dIaXRTbmNoakVDQmZaUW5wMElDbFh5Y1ho?=
 =?utf-8?B?OVpmd3NsZ2wyK2NRbCtQdEZKamx2ZWZKQjN5ZXVIRG96R1ZURWNEaVJqUjFn?=
 =?utf-8?B?YlNZK1lDOUo5SkRROTNjL2FmVkUzNHFNcUU1ZXJmVVlabGtuRzhZcDZtWXVB?=
 =?utf-8?B?YkNhcG9QY2RNNFY4dTNwUmpUSWRCOWtCTytIOW9ONGhJSUtyQ3JDa1dQaU5s?=
 =?utf-8?B?T2s3LzZTR0M2SE52N0ZIbitEa0ZWcmVHUmJwMXpnb1NjRmE2WmY2ZDg2MU5a?=
 =?utf-8?B?bXQ5TmtpaDE0ZlJkUFBkWDgzVVAraFlYOVFDRXVjNklDU0pFUHhaNEd1MkFx?=
 =?utf-8?B?aTdsY0xIN2U2bjZBUjQ0aVhuTm1aMnlOOENqOHpNZkZmbDg1Q1pXcFJ2YTV5?=
 =?utf-8?B?VHR5S1VTYWZ4UXA2d2pRVHZIMFhuc2M2TUdZTTJrQ01PR01oWVBhV0hoTzF1?=
 =?utf-8?B?R2M0VitnYU9vakpYUlBzVnpzU0FmZFRWeDNsMTFRWmhOS2FORFQ4eTBKOC9x?=
 =?utf-8?B?WlorclZISXp4N0MxN2NwUURQdXBOMS9KWmg0U2JZc3BMZmVGS1lqcEVFdXc0?=
 =?utf-8?B?V1N3Yy9jeEYwWko2LzdzMkJnbEZuTG1IUzlWUElIWmJRUis1VjNLTG5ZamJE?=
 =?utf-8?B?cWUzZ21odkRUZVAycTZiTWdsNzd3ekR1ZTVRMDU5aExPZVV2QUFiNDlsZ1dS?=
 =?utf-8?B?T0hlYVRTa3NnSHVhOFMrWC9Nbm5sRDRORWhucUxONWVhcHhoT2ZiUDc3cmN0?=
 =?utf-8?B?WU5adnI3UlFQNjlMdjdXc1NCdUtjb1hQRllDS1RtTzdaMEc3T2hYa0NaeVNV?=
 =?utf-8?B?d0o2QnZzSE9mWlU2Q3VqVFUvT3ZKdUQwMUt6dmRxUFpBc2JsN3pDcVdCRldt?=
 =?utf-8?B?R1RSMG8xdjFhTEdnRVlML25YRkxmSTExZUVzZzJyS1hCa09tbjFlL0p4cTd5?=
 =?utf-8?B?OWZNYUJySzUwcTNxUi91ZWRxbUw0NUdGdndSdTk1VHBIQzBiK1IxMW4wVjlM?=
 =?utf-8?B?aENZNEltbEdacmZhOFJ6cFFYZHc0eWo5amlodWVnblcxbS81VGlDeUpnK0hD?=
 =?utf-8?B?bHQxUG9PekN3NjlDZ0g4amVnSCt5YVJTOTRmTGk3WjVMTTdPemtPSWJ2bTda?=
 =?utf-8?B?RTluMURuaXMxWU1kTzlRa0g5ZVl4SVg0eTZ2ZnhlenZDQVNrVi9QTndZelRO?=
 =?utf-8?B?aGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72fa56a7-628f-404f-7c27-08dbd05df928
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 04:43:43.4781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7OERZ0fjCwLeZms5H+PXwa6W4tqB91uey6GMljpjHUK0im7GA1bDO6Y0JkioNTBAH+VkXj2KHBfrhTFxOMIYOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8004

On 19.10.23 06:17, Prasanna Kannan wrote:
> Hello,
> 
> I’m currently using Xenomai 3.2.2, and here passing the kernel parameter “xenomai.clockfreq” doesn’t seem to have any effect.
> In Xenomai 3.1 I was able to successfully use this parameters. Is this parameter still valid with Xenomai 3.2.2, 
> if not are there any suitable alternatives?
> In the past I also used to check the clockfreq registered by Xenomai using /sys/module/xenomai/parameters/clockfreq. 
> Somehow this is also missing in 3.2.2. I am thankful for any pointers here.
> 

This parameter was obsoleted by the switch to dovetail kernel patches:
Xenomai is now using Linux and its vdso as clock source. This also means
there is no longer a need to calibrate some hardware clock itself in
Xenomai, therefore also no clockfreq parameter anymore.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

