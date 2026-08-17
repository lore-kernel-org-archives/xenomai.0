Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010065.outbound.protection.outlook.com [52.101.69.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F228C2E7BD6
	for <xenomai@lists.linux.dev>; Mon, 17 Aug 2026 15:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786979890; cv=fail; b=Jtrabqd0w99F++eDLE0kCKNvyONSVI+Y9ZlJyQjYJqqh5WBJ6Aq6UP6EMLJXepYCB6P9anMfCMuJBB3DkTkJCy0aiPlWAoWEyDDJqMMmSUJQ0RXtMhrMNxO2Gk4Z0k6aLRUrG4SoQg9SnxlZqyWtowh9t5oZMKl2Hq+NOPy7ebc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786979890; c=relaxed/simple;
	bh=+46aXPisXvvP2prlk5OBrkuN/ujzUinwB6DRmPV4Vmk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n7xI34Gc2bR9zP+VW4apI6k4CyO2F1WqjMCNR+vyHNdSgodbQRXSGVK/nanbUWiReFNN7HXLKtAOYSEJxPaJAlHi5t0hZ+bb9PpqlbNclkjJnUx6voY1J9ts9TMpMR9ogdPY0Ix1ZA+/ka7dOpQ1od7EyBzbqMrlptCiD3QMyP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=oDSC4ogF; arc=fail smtp.client-ip=52.101.69.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="oDSC4ogF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y9A3OWy3IRmxAO438xat62Y/grKptQmE2aNozUYsH5tIn3T2+OhiPcOTo+IoqiCP/QJvAAvdSNYUr8eRViZLorFFMR4JUIV+mrTbTCIUMtxEc5cCGtwtenbe9+pgl9tDtIi6O/VtPS72uP6gi5s9ZrC0asaE/TeMUI7gGTquvcINmiUkX3vr0BbMwNymMufLL2+HEpDKWYRRwC5fkKcaR5mcgSDyCW6A9O1T0Sba3jZOWqYUOB+6MxtrGDConWLjEUfoi73TVS12Wo/Ok+vYUyOlTT/F6iJb5m+L0xOkzYfJbQZ3c8lMmvUcDNuiMwxYvIJJhjQCQEnWwzDAB0lByQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7xC6Q1KJvfyiggBcdn9iWLk8yti1i5N0qifYV2DRcw=;
 b=dNV38j8z7SxBN46vKYiA5/dnyEMyFEIQyw+zTyiOTWQzd2kN0guqa+0UuDq4DFo5+2GbZPR+TCo68MlU69T2M1vvtoollDQMfYMw8HZxWj7evkYmMQF+8bHxHC/TzxRyp48hx2mZOXnWUSMBqhHY+h7RryQC4E11pJutqUnEL5d0rKL9hugeFX6vdPWLsuMFl8cAeS7Q3KEoffjkzQc0BU+pDXZKX9+mTqc+DD9JZKQGjFlyuawjZwddLbfgZdlLTKuQZi9Uu2wuH4VLrMLuI4qIDxwD22WCQNzs86JMCP92hzhGcFyxwxGa8s5Pr+2qJGqEh5RzEXL3xHATz2HUBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7xC6Q1KJvfyiggBcdn9iWLk8yti1i5N0qifYV2DRcw=;
 b=oDSC4ogF2lr+x4fkNWPu8T6l7ky8xHv2+xvtqZnh9hpx1YfMJuNsyBooVN9zzbyma1bXRbrNfup+qKZRAEPs1VIGnnB97lcNl2Hy3dy6/OjXeMW0VPsLRxmSV+nTazCiTNU81Apgu2bL3R0TxSdQpjWIN2S46CJOC7GBbldiwUWMjE9gV2/Jg2/9mxWHvCESgMYzwuGI5VJK6igEwobZy/TUAlfqxWSm1lwNZtcQUm6X+g/1xZnVnSBOsw2LFdKkgKYA5Y2j5u9O5areI1O4somUQpmOkCZG+NzhVIbu8EIuSP0t+rktotg68RTp6HG73VI/thXgtZeZOr4+M+tfqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB8253.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:119::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 15:18:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 15:18:05 +0000
Message-ID: <c41371fb-b484-48e3-a271-c4fcde473525@siemens.com>
Date: Mon, 17 Aug 2026 17:18:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: The state of Xenomai 4 on Xilinx Zynq-7000 (or ARM32 in general)
To: Gerte Hoogewerf <ghoogewerf@lmi3d.com>
Cc: Philippe Gerum <rpm@xenomai.org>, xenomai@lists.linux.dev
References: <CAKndYJGo5Yu7Ak694tX=cqRjtJneXs22DPjz=UDVkUcNJMWyOA@mail.gmail.com>
 <87v799kt2q.fsf@xenomai.org>
 <CAKndYJFhN5MfybdumExs7b5gTqW_CHa_i=cOL7R6xgjad1ytDQ@mail.gmail.com>
 <b7d8d1e3-0353-49dd-b626-5aaae76f7526@siemens.com>
 <CAKndYJFsiha4BZ1VmyM4-XADyNJ0RusC+TPJAm9k2q99=khLLA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAKndYJFsiha4BZ1VmyM4-XADyNJ0RusC+TPJAm9k2q99=khLLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0291.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB8253:EE_
X-MS-Office365-Filtering-Correlation-Id: fa1d9e9e-62bd-437b-5936-08defc72bc86
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|6133799003|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	B0HdvlqKlzAWVUsoO4yjPjzg4L3OdJRyVWlo+nJVl8snqd3kY563W0/kjjCSzb64ZR5CB+D+r9+f1hg55vsYHpfM2xu8u5fKSMbo816PFF0lsnHcp0EDS9WCujI6OFFPd4viKH/zspnCfxuxdif04Ko/lqUxxXX82GphRkRf3PQb7PRNZSrEiyvUcGxa2PFmZt00KokEj4bHjJqkqjNI1c+adzXMLRKtzdF4//Xw0ry4CGiH4mhvKt4bSpKhmPUDnvYzfYz/W0fgMoe4TF8HPOMjQtCia9t89RpH1tcBPfngA/JvPxhCsKYsR+zOZBs3R3GVEdqbJPgl5nIAkSgJvjXDPPcaG4SlXYdSiTRc7fvEglpB7KII9UxG3D02MVUqKEWrtZiAQQqBxWTmwRVh5JKgOx5VFipYFxjh4rGKJ1WGzm3fXbjKbXb6KhG2Eizc7rpwyisoNlbrOPZpTX8HDFNtfjq9QjVII312W1BN9hdsKHDSmDkIbA5rpk9ik5QrdV76djm2N2HAl4TfTvA/0cW2iJ8y2zg3CJEBDVRq7G1w8UoPHIKaMszYM3KR7YXpbxZ0GhJTZYBZR8+WgD09lTMVdIGekDxGo0JwILGlgSsWipgd15TbdOm4sYK6ps/XgBe1wCcTTAa9uxpyYkuwxWI3r+qLLvlMsf8xhHqFmW0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXhCdHdHUW0wditnc0RmNGJOL1Z5MWJhbjhhVlhGblNNdnZ0U1RNNTd3SURO?=
 =?utf-8?B?SEZZM1F0b1NwTzdTaHRCaFlWMkdBbFNCMFgwNTNCblh3M1Y1RUpuNURqU0Jw?=
 =?utf-8?B?Z3NXVUxnS3F6YXdxd2Jick5VSUo0TWVpcFo5M2kwa09DTDNvMFkwdTBUcWVH?=
 =?utf-8?B?RXVickk3emo1dFhvWHlqYUFRRkQzbE56ejdraWpFZjBseGxhU2dKTnJscDR4?=
 =?utf-8?B?TkJydXBzWXpOdUxzM0poZmhDZTBTajVUdnQrbk5UcmFrQTB0QUl4bmlyL2d0?=
 =?utf-8?B?MFoyWGdJbm5IaVN5UGt6aVFnN095R1FDLzAvcG45N0RBVzArTkUyYnY3Q2Zx?=
 =?utf-8?B?YktBQUV6QlhuWTZSVDJ5ZTM4eFQzS3V6aGg1cC9DRmY3TG9XWW5wR2d1S2tk?=
 =?utf-8?B?U2E3cFhPMXU4TnEydFdkMDVMOTRpTEtDNUZWKzEyUllrdStNVFhDaVZOZkNM?=
 =?utf-8?B?WDVSYUhJb3FLL0dmYmFnVTFRZUtjaTMxUlNjT0ovV2ttSVR3RW5nb2drd2J0?=
 =?utf-8?B?ZDZsU1R4VHR6dlhHYXpOYWtZRjBhWVpmRlFHemVFTE40WWd6WjBVZGJwVmhC?=
 =?utf-8?B?NkxJUkZ5R1FVYVQ3bURsL2F0QnlkUUhxZU5jMVpCcEdMSm41K2RMclJIN1Ex?=
 =?utf-8?B?UmFoeHVUblhXNzNOVDRTVlUxVlRrR29rZ0E4dU4ya1ZiTjArdFBXQk12bXAx?=
 =?utf-8?B?ckVLY1dUZUw3Ymg1bnNLL0t1WTVhN0V5Q0kwaHltWnhhcmF3YlpRRk5RVDI2?=
 =?utf-8?B?ajdId0tkckU3Y1hvaGdqZGdscitlN1pUVy9YVWJlZHhiaE9YSng2a1F1dXA2?=
 =?utf-8?B?dVpyRURRajF5VEtxTlZlU0xDaUtIMmhZNmVrQldHTk02ODl3YW9SWDFYdzlw?=
 =?utf-8?B?ZVVldEF5ek9qN0Ric2lubGNsWUNpN09ZYkNOR3hVeGpYQUh1RjdXY3IrU2dk?=
 =?utf-8?B?NCt1OWpOSVBxZGg2YVVub1Rmd3ZmRmhJNTFrT293RE1aL0dFU3FXd29XWlJB?=
 =?utf-8?B?VjI0U3llZTArTEQ2VFNnb0dIcmZmeVVFUFRNS2VEbEhRUVdpcFhWNFp4TlBL?=
 =?utf-8?B?MXM4K3pQU01BWWxwUi9JN1M1UHlrR3JyZU1IWktwMnFKZDE1dHhaUFNlSHhx?=
 =?utf-8?B?K1hvTXFubFNSUExOUDd6L1BsL1FxN2lFUFpyRkJRTk5CcDkvWldTd3lQeURy?=
 =?utf-8?B?UDhKTk9YWmJtbHRFbDRHK29JbGFwRGN5RGdtQm9RNlRrZHZlWlVCNW5WeGNQ?=
 =?utf-8?B?b0hheVNuK0E0M1VLYTdwb3c0SWpWYUJLY3RIWDJkdTFhRVdWOG1hVSsvY1hw?=
 =?utf-8?B?SkVuRVVwWm1MUGVpR0EzSDRleXpLTWVjR0JWamt5ZThkV1BCRy80NHNXOUxG?=
 =?utf-8?B?OGZQU3dnekJCdWJzTU1ESUFGT1hHemtKMTBCMTZhSlh2YXl0UUR6b1ZRaDJP?=
 =?utf-8?B?azhZVks4Njl1TEVJNDhtWGR2bzlGRk5jWUdOVU04b2h4RG5qVEZ1QmFYM21t?=
 =?utf-8?B?ZkFXeXRTR1VxOTlIb3NXT0NiTnBQVE1lQ2UrTnVVMjl0dnZKRU1UTkw3S1hB?=
 =?utf-8?B?YkY3cHdJcitBTVZEM0w3Tmx2QVg1QTl1VVVUVzFJV2xsQk45L0RFWVRxSnlu?=
 =?utf-8?B?WkV3dnRGem5OdFhoSGdRYWtxdlAzZCtBWXRSb3Jhb2NpaUltN1kvWWlES1lI?=
 =?utf-8?B?ZFRxRERwK1hnT0pDYXg3TzFXc2Z4Nnp2MUJIeFIvTFdRUzdVMmxwUGNudCtL?=
 =?utf-8?B?cm55VTkxWlRudzc0NUx0bE9YNlRENkxPZ2x1Y0JFTkdsQkpOaEtjY1NCNUJp?=
 =?utf-8?B?ZnVSaUhqY3FVMEo1endvWXl2UndoSzN2UDBjUmNDQjRLWUprcmpPOThlekFI?=
 =?utf-8?B?T0VkMitvRWh1aXlsYWR5TFZhNlZjZlpHTjlURDROSUxFRVdGdi9RWVJia05V?=
 =?utf-8?B?SE1oVWZvQXMrT2RMejRkSkIzcWhjZGRmK014Qk1obkp6TGRzeXkvUHd2Qjc5?=
 =?utf-8?B?V0pzWHpYcFFQSHh3V1pUOFVXVjdKNHUvelppeDlHWllKQTZRc1UxcXVhc2pQ?=
 =?utf-8?B?YkRXQ1lBY1E1WGZISW9xTWN1QWF0NW5Lc04zTWRqVDJOdFRVWFFPWThuOHlm?=
 =?utf-8?B?R3pMeGw1Y0ptQjdUUlF0R1pMOXNnbjA4cFY5cFhZelg1T3k1ZmJpK0hiY1Rj?=
 =?utf-8?B?d05CYXNoemNDYm16cnA2VFFLRk1mSnQ4a3pCSlIxZXl3OWFyU1VZNk1KVUhs?=
 =?utf-8?B?S3F5NEJVOTRLQ242OVZFZng0bHJaNmdnc2M0aHRqQ0wxdlpUeXNLQlFhTXZp?=
 =?utf-8?B?NGpxS0xwYzhZVFMyOVBvT1pNMzVvaHFSOWlhL29GOVBFVUpuc1RuZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa1d9e9e-62bd-437b-5936-08defc72bc86
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 15:18:05.4021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tM10VqXLnLA2Jp4TQYFHxDA5DCakSwGJQff/eBnl4ESofkU1hbPo8L/vXrlfoba60ZkOJi9+I8ayIt85Sm6svw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8253

On 17.08.26 14:05, Gerte Hoogewerf wrote:
> Hey Jan/Philippe,
> 
> Thanks for pointing me in this direction.  I've done a bit of research
> and I'm making good progress.
> 
> It actually booted as soon as I disabled the "scutimer" clock source
> via the DTB.  This made the kernel fall back to "arm_global_timer" and
> now it boots properly.
> 
> So, the original problem may be in Dovetail's "smp_twd" handoff under SMP.
> 

Was that actively used with 5.4-ipipe or older? Not that it wasn't and
just happened to be pulled in by Linux > 5.4.

>> [..] if someone is willing to set up a lava working with a Zynq board [..].
>> Still, it would also need someone to look into regressions, just like now...
> 
> I'm unaware of lava. Aside from Xenomai's patches, our boards need a
> massive patchset to function fully (NAND flash, FPGA, etc.).  So, our
> board is not the best testing vehicle. However, I am happy to help
> test periodically, that's a small favor to return.
> 

That would indeed be welcome already.

> Let me know if you have any thoughts on where to look in smp_twd.c;
> otherwise I'll keep digging on my end and report back.
> 

Looking at smp_twd.c in 5.4-ipipe and 5.10-dovetail as well as
6.18-dovetail, the major differences are around

"Updates clockevent frequency when the cpu frequency changes.
 Called on the cpu that is changing frequency with interrupts disabled."

But that path is only taken if CONFIG_COMMON_CLK is not set for the
target - it should be ARCH_ZYNQ.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
