Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013055.outbound.protection.outlook.com [52.101.83.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515C94BF95D
	for <xenomai@lists.linux.dev>; Fri,  2 Oct 2026 18:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790964135; cv=fail; b=eg/UyLIfjxUfyAQrM3V0CiGxukImN/LhvlWyvZPOAzpU/BHCNaJ+gQe7WttEThuU8iBLnVS1riIjIKQhgkK7+QGGXqEi/fzoclZXo3TF6BddAPXFTHylQbm/kFTHtqJlDOxk5liGEbuvYdpVsv5f3KpS+ylCu9kp5s8oioNcBfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790964135; c=relaxed/simple;
	bh=9WOR0OHEGeve4EjF3wFPi0GvyuLbpmJ1CHYF1pgAovU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sDs1uHJeLrlfHKT/T+CLD3Nr9ZIAwzbDZeEsJKPf0vMEZqUXh4tRtvECYBLxGPHwo/+5VOkKY9zSCZDROy7j9YYY24y2zXAT5rSUG4leiUYSj8cqbF+iUiaxOq11d29HECuA8aHgUFwNg5sZ2ObnAlyRM/Dw1hnnkJKAw8EQ4mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=b4EKmJVM; arc=fail smtp.client-ip=52.101.83.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="b4EKmJVM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MggKEWYGflWm6fjBmbQlEaW+DZWqtYw5D/ws4ExneD2HoQ2w8vpnG8EJHe22WWIoxC8ENtFZIpLrErFKs6Oezpr5IN1Wb3NAtTkTStqIkD3zQ+qqcpVhCR8WfULX33DsOTsr9/8VweC1K7lHzzQGBGfyvht09q+uoqiCr+I2YFeuxvLqAB1S1T+0vPtnULnMMeeaboVhMRxvZ9IKfY3UboyXAwsOfcLlIbHY9V6TzZR++Ucc+aLdW0CZ5YGeT+G4IKOVVcuOZ/9/OE4L6Fq99cPrnG+xplCkokCBKK4AmDwkmxLfTzd4mgzduxUZ6n09benZYQaoTtTVjp/HL2sYZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GjcW5OPwiT2wFUJ5seU3hhXrxuLzDDmqzJK3kM4kBs=;
 b=loNaonspCwbYr9vcyYxPqR4GMwblwkItAlLnOTwYE1XtHWkDJSJ9cdV1Pa2lu2qiq2T5UONpbgMp+8R566Gw2zSyonau30XaYcC3uHIWu7nVO9HQwr8uLWzAP0voEL9ePTOoITyTu9ghKJEpgk8sdtC8eGMQcwx+5O4kOWfjY0/Xd6yOtbeA4leN0nhx846uCcbEwSpefM3Y/KlbMav1wYurWifASGYvQLNviMsUxd9fsYW0fwVAtc4SqXp7ZCg2+3/9mlhTKF+AiCdItPnqPc4UPvMOinudpt2yAz3s0CnHGfQCf/8u8NmaXdFCLqs4HIKlbduJGDl8IlQQ8ViaCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GjcW5OPwiT2wFUJ5seU3hhXrxuLzDDmqzJK3kM4kBs=;
 b=b4EKmJVMHbbiAFz3xuJSNRRQ6Dwi0x2PjdAYbBunuIpUMPugveaUl0/duSknC1Bh70YiWt9hHOcEHwkIGj8JAtPpFbp7RCTZP2JFtRgYeZFPpT2XvW3iym1gWbcmuN50Q7A4ZRZGKrDfh0EBVPjWW6+y6SxakkpsyksmbPzVxx3MDFVdwOYOIL08d1drjhNYUltv6BZaAbTOSv8rggrfeJr881dgn9dYDtjXSOcAtM8sW0fHUL5Q0EcHfIEgSPn7aWJr0UYCMxh+MmRTEeVmQg2azK5COaA2sW1u1lwN51jn8vN8JWYno50BEw/Pq6os+ukJgpAlnkvVk0aX4j6u5g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by PAWPR10MB7341.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:2e6::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Fri, 2 Oct
 2026 18:02:07 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 18:02:06 +0000
Message-ID: <eb7384fa-b236-4420-bffa-9ee5a24893e1@siemens.com>
Date: Fri, 2 Oct 2026 20:02:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Problem with timer on zynq 7000 platform
To: =?UTF-8?Q?Fran=C3=A7ois_Legal?= <francois.legal@eventlab.fr>,
 xenomai@lists.linux.dev
References: <1209-6abfc980-4f-5a2d1100@131627188>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1209-6abfc980-4f-5a2d1100@131627188>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::7) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|PAWPR10MB7341:EE_
X-MS-Office365-Filtering-Correlation-Id: e837dc2f-de14-41f8-8943-08df20af4546
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|55112099003|10067099003|260925021311599003|11063799006|260925021911599003|56012099006|6133799003|260925022911599003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	GUoElluqL88UxQbWKgThy7nIQirYezsEcHaP1o5/ut+xEDKENEuH+DnJdSA5Qc8xOPihi1da03rOoi17BFJ7C5lmrrowRCC1FqyMgtkYbL2uI2GezLHyqOid86rjI3wUEykZt90haX/+NUBlGDmQJIIi2KTCAlgBsY+JGpMNi3bD91BMipvIlbeURgVFsELuaB2RwnAqgq0Us6QEAQ7gQKZfL5fO0wotMSAIZ04PfXGgQaEXXrAz9oAGqBuFhPUdfl+MIS4rWctjQ41LWanNf1yUcQSPxX/BY/W1S6TXMdZMZuBhoDqqL2ACFU5GN92XOV9O8mxPwjoYmz0x7W/9qKWiBnZiqBjwTGED+J/ptdTe/hyF2TcC1NMsYscxW/NoEDopYwZzkD67VqXVnwCuWduLtrY3UgxoLiHE2eo+SZQMSuXYMGTaWl+vxTjJvnXciCBEhGQCrEvufJka4uEZS2yypXjk4NB0EVRkGDTr+CXK++aqdAfCSNA2GtyH0beKfxkg6/ANxIjFn1HVTd82sgMBDm2FgNyuFQ0/CCAHxLJwH3e3mp1dwfasZYu8ww2YxbJtP/XC9taSAm3qHsOmG+sIq0F/1Vd2WSsOw3XFcA13DDe7i186PbD9V0hsXNxVoMMcgP5718IUv9E5VVWlibASiyGkm5UxICQkX3Ynrqw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(55112099003)(10067099003)(260925021311599003)(11063799006)(260925021911599003)(56012099006)(6133799003)(260925022911599003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tm04aEFzeit5VGkrcEFQWmR2THFETENBdlk5ckxEdFNNYmtOTHBpWWpJZmE3?=
 =?utf-8?B?N3RINk9PMFVobnVXWHJZaTVGYUdXNGx6U1pObEVETmlxK1NyaUM2NmtmQXg4?=
 =?utf-8?B?R0xKZ2E5SVR1eWg1ZVNCTzBUeFJhV2NlUU04dmgrTHR6bXh3UGhQdVZGR0tx?=
 =?utf-8?B?QXdWWnJadjZCYk1DQlg1blRRdm5Hd3l2SDZmRi9GNFdlZ1E5WE1oZ0xDQUpQ?=
 =?utf-8?B?bTEvbFpLZnArOWZXeFozOWo1NTdhUnI2WXZwWEkwMjZSVktCaHgvdE1HZmNk?=
 =?utf-8?B?NkQ0U0pnSG5ZRlpUeTNWakV4ZDd3QTBsQW9JbUlLRXd0Y29udGpIOHZlZWZY?=
 =?utf-8?B?Y2x5a3NkWU5LTGxFWC9yalNGYjJFODQwcytHbjhJYXhFRjB5Rk85TWZiYm14?=
 =?utf-8?B?anU0RGlIN0dQb1U1VndjUFgzQnFoTDRFS3huMTJ3UlJZYnhyUTlRd1VWeXZX?=
 =?utf-8?B?cVMwMGx2OEh4VHI2emhueTUxU2lJYzZLZVJVR05kcDVkeUZJK1NvUVFiKytj?=
 =?utf-8?B?ZXhiMWJBdmhyNnN3elF6czZnbjBONVdncC8zL1FBUGJhUU8xN2ZVN1FiNEpl?=
 =?utf-8?B?M0xTSzZqWXdYSW9SdU1GVkx1Z01MNnJ2THgwakNOa1J4TFJHNS93SXJ6dkhW?=
 =?utf-8?B?OTlWaTBIa2YvN2hkY1Q1ZHRCRE5ZdFZxclhVbFk2RVZlWGRFTHU3WDdzbGF5?=
 =?utf-8?B?U0o0NzVtVUE4SktqMXltaEdZaEVXZHQ5bSt1dldBOUhNeDJiQ0dqQWl3cGtY?=
 =?utf-8?B?MnRLUlJyY2xUckY3cEtGdFJuK2xuVDZrMGdqd3VaWXd6cTRYdm1kUkNVUGtM?=
 =?utf-8?B?L3k1ZnkvN3pPSkpiWFRSVHlIT3hJMnkzZnYvb0cyNDlKSlF3NWdLbTRiNWNM?=
 =?utf-8?B?VDhGWVVQWDRGNGhMWnNRdGdhcWpiRXY2NXd3NUd0MkV1dkw5cDBtTWpIei93?=
 =?utf-8?B?WGlrZ0toWVkwU3dhbDIxT0ZickJYS01mSU5LeEE4NDAwM1llbHlrNXI5cDVz?=
 =?utf-8?B?WUtGTkVGMXhJQmQ2TjRXWHNIMCtBWmJDeCtTME9IMVdsTmhpTFphQmNCWFdS?=
 =?utf-8?B?ODMyWUJqbG9CQjRqSVQrcC9LSXV5TVdJWCtaMDhxK2RRNnpUelJZZE5hRnZa?=
 =?utf-8?B?L2J6WUxCVms3OTFUOUlySU9WN1ZHa1pNMWtsU1EvYmVMNGV0bytDRCtONFBG?=
 =?utf-8?B?emgrcmRvRUZCVCtKeDJTWDZuRXlwMW5FRVY0Ry9uUnlHK3lMRmQ5cGtOeG45?=
 =?utf-8?B?SmpERXp6U1V6ZWZiUHdLT1dQNkNKNEM0YVNrZHhvZXVwZ3lJdXJuQU51VTZr?=
 =?utf-8?B?alF3NldBU0dWOUR6TjQxT1orT2pZSUNWNmNJTUllczV5ajNVQmxVNGxKS1Bi?=
 =?utf-8?B?SHJYTU96dUt4bEFHTFZ1dzhXNHJIYmwxZFN3U0NHa2lVbWVqL2hQSGFhOHNZ?=
 =?utf-8?B?OFdMQkduQUNOeWY0YnVYeG95SGhxOHR4NzNtQ0RXdlo4d2V3Z3V5QTVmdDQv?=
 =?utf-8?B?NmdpYW82WnNXdm1udndrS3h3dVRTL1hENmI2MmNCODlRK1dDSnZveW1DT1hR?=
 =?utf-8?B?OUFsTENEWEgrMFF6MUxoaDZLV2RDdGpUTktqTndtNVNybW8ra1lFYWxpcUl5?=
 =?utf-8?B?Y3JKekNqZ1ZuWHFac0ZnOGROck5HMGR2MGM2NGxCR3owOW92VG84dnJ6US83?=
 =?utf-8?B?TmxDMUNqRFJDbW90c1VrNVpUOWhOdHBzU1p1a0FrZml3VXRLbm5aWlZBdFRU?=
 =?utf-8?B?YnBLQnNJZHZaZ04xNHV2bzdCZndkSUNRY0s0WmJMdi9oY3BFc2Z2YmFicEla?=
 =?utf-8?B?cm5wdUpXQTBWL0FKeVpFaFkwem1xS1BPZ2xkNjd3OHVhSjJnc3hVOE1JWFZT?=
 =?utf-8?B?bTFUMFNwUGhmdjVGci80cjhHbnJNN3o1aktBazJzbDBjbzgvUllPbUdlai9W?=
 =?utf-8?B?RVBlV2VEL0J0cXUxSmZpNGdtL21HeXF5aXZIaVdwQWFYVWpzd0ZGd3c1b1Rj?=
 =?utf-8?B?TFpOcFZmVGFtZXBQM0VwYi81NkFTOFlZZCsxQVI1WTZXSUUvZmVQRWZnM1pJ?=
 =?utf-8?B?Q0RQbEtkT0dQMjBMaVM4TC93OUVvZW4wTGxYSkxyM2ZJMVZxR2JGZmpYOXVZ?=
 =?utf-8?B?b0ZkaDBVcUdzZDczaThWKy9XSjBCVGxxTlRVZEVPdU84TmFjNEtvL2tWazVW?=
 =?utf-8?B?aWU0L3prOWdGa3NuUVd0YnVSdTJhaktpZjVFckVJQThFbkxIeXMwU0VGaG03?=
 =?utf-8?B?QUxCc1VvNGZ3aGwzck80R3dzYmVHZWYvUDdiNzAzS2ZNTjBnVXFRa3B6MmNV?=
 =?utf-8?B?SFVzSE5nd3JGOVF4ckowRjlmNHRRdmtNRlFxQ0tyWjZMcGkyY3VKdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e837dc2f-de14-41f8-8943-08df20af4546
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 18:02:06.4199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IjAr6Jht0aoRJqwjhamQpxOlqR9OEA7XvEu05+Twpm4EhVauIV9ByZ5EIuUt5CRZkZblECWJzNqBSZCDxsYJXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7341

On 02.10.26 17:11, François Legal wrote:
> I ended up switching to Xenomai 3.3 + dovetail (linux 6.12 for now) to fix my monotonic clock diverging between userland and kernel.
> 
> But now another problem arises. I'm using posix timer to trig certain actions. And since the switch, those actions don't fire any more.
> For example, if I set up a timer to fire at next second, it does not. Checking /proc/xenomai/timer/coreclk, I kind of see something happen :
> CPU  SCHED/SHOT            TIMEOUT     INTERVAL    NAME
> 0    294672/247088         3ms253us    -           [host-timer/0]
> 0    6/0                   -           -           [watchdog]
> 1    227779/211523         3ms247us    -           [host-timer/1]
> 1    38/0                  -           -           [watchdog]
> 1    1/0                   4789309920  949011081s  cobalt_timer_handler
> 
> I guess the last lime correspond to my timer, but the timeout does not really match my expectation, and the interval should be 0.
> 
> It looks like I'm having a time vs time64 issue, but I not sure how to get through this.
> 

Can you be more specific which API(s) you are using?

And if you suspect a time64_t issue, how did you compile you app? Are
you using the flags emitted by xeno-config? You may also try to disable
time64_t support via --disable-y2038 when configuring Xenomai userland,
to either confirm or rebut the theory.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
