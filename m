Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED7A339A1
	for <xenomai@lists.linux.dev>; Mon, 21 Apr 2025 09:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745228728; cv=fail; b=hMg61UaQ0m4ybhQf3qskioW09wZKs/JZT3lm74tZHgvq/UiYl7IvobzM8YNBivXgsCfH1Xt3806WCbfH5QDV9LFAmQK7lgGheL9BFvVAJwC/7Fw+SYhEqzVUIEoiWDpV4t5/W1rEgbDsrSztKswzGERq+ZY2XQUbe0rTYbjrBKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745228728; c=relaxed/simple;
	bh=Q07oqqwKB0/8NbBDn6o04VQP81t5cTGYNUgn/9730OE=;
	h=Content-Type:Message-ID:Date:Subject:To:Cc:References:From:
	 In-Reply-To:MIME-Version; b=oTDRN3P7r6vtPptr1XmfqR4r3/kgtJcD+2kmefb1u9pIQsmZjwPXVqxDvEYWIU8CoXZnZUD4orNEuCMJEc6luuJEVoJ9rrFGssxskKleiq4PfnTye9j/VKfGRRaHgCNIIQX5mYRkzEAkvXEPxL8BfkM5yTZn6ocUQyBbGZQRc5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=lUXLiZoh; arc=fail smtp.client-ip=40.107.21.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="lUXLiZoh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ezt8YFcWJz0/BLam/HVYc09hXlnTdrRwNE1zVTRhaEzm3Wv/F+pKFyUyXMAqOyY9y6TdZNOJqNMD3CLqqvj49oZbiVYWI2KXO3eRIsqUDhXG7ljSjdHHRLUsu+OXQP+/gqgoOEyox7FuhXwfMZdZyJZHfr0Y7YzeiWv8qy4YVoNkmbJOB8N/TKnT4VQeHabo9FVNJtbUi+mNyZAU4Jlhs0mwWgrbt1+mT83yqQHI3wMVdP4egUQkGJwaWaubIXS7020pEKbYnECcwkwf0E5sF3va7jOOsnP+6z9jCteCggJQ4mP34SRkq8eCkh0rCXAhTiBXENjyJafYcZP0ziHxNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4hqrBYbtmW6tAphL9C6KKAxZAq7ZSq42pEQu/D7Xwk=;
 b=MDKAneC8ew6qw11nN0lwk+zMq+puihkMnsxtwr+hSmzy2F5MW1BJmZacB1qZJOrqcllTJovGxAnezmU2GGVm3gQNd+YfkikNfCcxlGY9uSy8n6oSDTyijSAvTnkYvm7fjJ3dq4o2TN/IBu6yueQ0aiM8tRPndUfo7AoCehu+mLWOkp7ZaT4JbAJ1S0Du7B04Q98wShDZ22fcZf6VGGP/s+QIEAeQaqFWaCYWq6pq50IuGObVilsWHwWayS+8KqQFMKN3vfR2a6rLxBycSRQKB3LIMaZpWA4wuMBGAgb3RswgBT8oBhkXcfsrF4rLzOYzijIwNF6wmEGbiKbmiZAKCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4hqrBYbtmW6tAphL9C6KKAxZAq7ZSq42pEQu/D7Xwk=;
 b=lUXLiZohCKORjDfniGG08WVq52hJ01vLBwQMzLXOe9dkLyrDPDSDVNDSLiIWc8QOMRKmk7MtLclo4hp/MIrWmT9kF4fDmHt6qK/V3nMxeUPVbsPd8/jd3Ff77GJg3vzn+BVOtMSUMWUluSnSVhTwPOI4qMfrwDnxXlhugSYn8FiJ8qpSeic2t/CIM9VNmBH3utsDk1FBOVKS7lpw9QoTJ4g+uZVPaHUNY0zULlH/p727McBl+m6YXXJQm6jchLlQYb6PSQJdtEtwxlX9oDBoqycri9TqrFaRYDHxTgTpMFrvNvWkbRtMxkRf7CEtxCzZ+bwOD0KygH9XK1iplf7F8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by AS4PR10MB7967.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4fe::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.31; Mon, 21 Apr
 2025 09:45:21 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::cd2e:c788:fefd:4504]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::cd2e:c788:fefd:4504%5]) with mapi id 15.20.8655.030; Mon, 21 Apr 2025
 09:45:21 +0000
Content-Type: multipart/mixed; boundary="------------9eMTn7cUYauWsAYiEPAz0ykJ"
Message-ID: <4abe85c4-1457-4137-9e54-ea1a8aa534d4@siemens.com>
Date: Mon, 21 Apr 2025 11:45:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Build error of kernel/xenomai/debug.c
To: "Qiao, Wei" <wei.qiao@intel.com>, "Kiszka, Jan" <jan.kiszka@siemens.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Cc: "Chen, Hongzhan" <hongzhan.chen@intel.com>,
 "Pirou, Florent" <florent.pirou@intel.com>
References: <IA1PR11MB6513EB0131E06C8CC865E8EF8CBC2@IA1PR11MB6513.namprd11.prod.outlook.com>
 <72c2c5cb18b635f1145c35b6592c661cf55aeb0f.camel@siemens.com>
 <370f022e-d5e3-46f1-a19f-5448afeebb61@siemens.com>
 <IA1PR11MB6513A045F8ECB1186B65DA9A8CBF2@IA1PR11MB6513.namprd11.prod.outlook.com>
 <4342e7e1-a7d4-431c-8fcc-f7731d3938d9@siemens.com>
 <IA1PR11MB6513FC978522428982B0A30A8CB82@IA1PR11MB6513.namprd11.prod.outlook.com>
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Content-Language: en-US
In-Reply-To: <IA1PR11MB6513FC978522428982B0A30A8CB82@IA1PR11MB6513.namprd11.prod.outlook.com>
X-ClientProxiedBy: FR0P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::21) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5712:EE_|AS4PR10MB7967:EE_
X-MS-Office365-Filtering-Correlation-Id: bd475a51-af23-4ad0-d8df-08dd80b93b62
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|7053199007|4013099003|4053099003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1pNUUhDZlQwU1FkTjRzY2hhWnN5U3dkNVphTW52ZFFJNThmWE9tUEJTd1Yx?=
 =?utf-8?B?azVabFFVTGh3KzRGVVRLdnJJM1lPZXVsRElDOE1LWDFkeWxFSDdkMTBRcStG?=
 =?utf-8?B?WEppbjNjLytlaG13cHBqUGhPcXQ4YjA3OXZWbU9NK0pwV0E5djdZcHFKeTBs?=
 =?utf-8?B?Qy9BNU9HbVhRbHZyc09KZTBRUlY3WDZESzFKWnptanFXaHdwK3l0TFJUVENH?=
 =?utf-8?B?d0pWaThXU21Vck02UWl1bjdxajRqR24zUVA5eGMyVHhtUjdiZWlSZlRXdGl5?=
 =?utf-8?B?bUtvMXNLZTZVNTBPQU93QXVWUmg1SGtLS0hMcklicmVnUWM2UHdpWXgxZUl2?=
 =?utf-8?B?WGhLa0hUbm1sc2lzMzI3SDkrZzJLV0l5Tm5yYU1RZVFJaU9BQUh3ckVTUFdZ?=
 =?utf-8?B?L1dZck5ucHJvdE5vQ2tYSjRld2V0N3grcFhnTGRETDlnYjVFamw3WG9iWE9h?=
 =?utf-8?B?eVgvcG9YenFFeWlTZmFlc09RY0xtZFFTMmg5RVJlK3ozaXZabGtCbCsxblh6?=
 =?utf-8?B?SFMrMzRrYmlNbkwrWG11M3JNZzFTcU9vUUpwNHZ3ODhiQ2NxRlZuaGlhMkN5?=
 =?utf-8?B?SXlsNWVGc283eW40U2M5OFBpT2pvMGJkamk4aXE1b3lmckdXMktyUjB1MmpT?=
 =?utf-8?B?amV2MWEvMVI1Um5vNDAwMDNsM3hzb3R5V2R1MUVlaHBRMFZTeTVKa1lnbzIr?=
 =?utf-8?B?bVoyWjZRVDZCSEVhaUw1cm1VZ09MV3ptZVhOdEdRLy9Nb0ZmcitrQWVCZitw?=
 =?utf-8?B?U3orOGdOa3ROa3RYeUhxYjNpRlo1eUx5akFsZDhqUjRDSVZrOFZySlhMRU5Y?=
 =?utf-8?B?QUs1bnJDejlhVGhYUzFiYktTdUxQU2Z4aFRhUjE4TXV1SGVSVGxySm45SFBS?=
 =?utf-8?B?QVIwYy9EaWFiM2dyU0JyYjRxbklpbmdRbWg5dktrZGZBRmNuS2ZObHowM1NG?=
 =?utf-8?B?K3g4c3ZwOE5rV2pHcEl0VzVvRW5vT0tFS1NVRVlqR1RDQjJWSGRVMi85dHp0?=
 =?utf-8?B?Ym5UWThMdXEyRkthb0JXQmU2ZVhlWWJhb3hCa0RYOHZUd0Q1VWFTK2VDZ0Qw?=
 =?utf-8?B?Y0VJV0duRjV1UnBqRmtFaFpIR1hQcjBZWFRZT2VlRk50RnNmMWQrRmh0UExB?=
 =?utf-8?B?T2twdmZ4KzRVRERiZE8zR0tER3BkL0ZtT3VNWFBVaEtaVGhHQjFOK3QvSFBp?=
 =?utf-8?B?bjJ6R3pkTFIwNnMvSnRXbFcySU54WDBQamhjN2FGUTAvRzEvbVo2dmhMN2Ja?=
 =?utf-8?B?dGl2NE9xZHBoN25EYWhGRW9ja3RxT3ZLVUo5T2JQVXNVQ1Z2SnpBYXljOVpn?=
 =?utf-8?B?bzNDcGVxL2d4SkpnTVVJQzVlQzlRRXJBU05rYUNLUWhmKzJTQzRkSnpibVZP?=
 =?utf-8?B?WjFtbVp0UEVHaVd0OGdTR2tRSnQvb2tDWHNLOHZ2ODZUZEwyUk1HMmpPNHNC?=
 =?utf-8?B?emFxdTRKNnkvY040S2puTTdsK2ViamljeXRsMUwybDR1WDNKWXhHL2pOTW1m?=
 =?utf-8?B?YWtJamhLdlpodWhJc21rR0VsVDEwd3p4NUk0MUZJU3UzLzdsci9XUWxYRDg4?=
 =?utf-8?B?Z3lTUlN5UXRKeGNqRkFhUzBUNzk0dTU1NzNLUkVKWkVPVytBSWlvQk96bWFp?=
 =?utf-8?B?bk9remJUVytKbWRMamdCaXlQRDNBdnIvTjQ5dEM1eDVLeEFxZVp0UWtYN2or?=
 =?utf-8?B?c3JBVEU2WHNLbFdtSGZ6TTN5RjRMQTdGZ25QcDZkamdjVTNPN0dsSDNYZjQw?=
 =?utf-8?B?bi92M1hGYTgvM1ErbTZ5SGFZNGtiUHRFYXlMS3pPQldlUmRGQUZSajAyQ3JR?=
 =?utf-8?B?OGJZRUpwakRJL3Z1OXpLTTBlU1creklsSnp5Z2U0amsyNVR3d2hxYTNWeVdk?=
 =?utf-8?B?KzZFamFqdTUwSXZsNG5MYmg2TkJtYlptOVczL1pMb2N5cU5oOWFjMzgzcTR3?=
 =?utf-8?Q?CaHesEZSNyk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(7053199007)(4013099003)(4053099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWQvT1R6eTlWYkJ4ck8rT3N2UzBWbVRxdEJ2NkpyaFhHb1JudVpqK3krZVRT?=
 =?utf-8?B?NHlVOFVBSkhBaGdDZVNsTlNyVmk3aXpEMjBLd3lFenBROUNWSm14MFBuU2c2?=
 =?utf-8?B?T0NuR3RwT2RBU1IrcUdwRE9pRWdSVWZhTFVxSjcxNnJMdTNmaUtmU2VkaXFi?=
 =?utf-8?B?d0U2U0FtUzREakdPV0ZXOGZ3WjhSQSt3b2NYVlJWVzF6akl0NVlHcUZ1RG9B?=
 =?utf-8?B?Y1NjbkVuNHNiVy9DSGlYMmF0dXZHWWYzN0MyeVhJZWdNb1Btd1JLQnpuVERh?=
 =?utf-8?B?RFFuU25BREJaRkVJWHdQTm5SMDZXajY4eDN1T1VJdUhyMkZ6WlhheHI1TXps?=
 =?utf-8?B?cXFMQkgvSUhKSDd6MnJBdjBlL3lBNlVLRldYMVAweERNTXFDSTJMWmJEbTU2?=
 =?utf-8?B?YmRXYlJMbEdxMmFrcEFpUFJFOHZIUnF3T1RqSXhDVG1TWkxhenZLeDFxckpu?=
 =?utf-8?B?eE1MU1ROUkYrV0krS3RIUVQ4cVQwOUp5Vll0b1l2Z3c5TTIvZlI0UVNvVk9M?=
 =?utf-8?B?WEg2NHBITmEwTnVmSmZMazB2bU1FaU1KZ3NteUpnZFExMERyTUd3aDUycnA0?=
 =?utf-8?B?UnNDUzYvZXRJODJOdGpsekFvVlk5ODNRTWNuYzRUUHViYmYybG1leXBuV0tl?=
 =?utf-8?B?TmxMeG9FZ2xLcDdQNXE4WWU0OXJMR2JWMXNSNmlqcElhMWVEUlo0VS9ZTkJj?=
 =?utf-8?B?SmlwZVlLc1RtOG1XZFM0ejFvVGRkRllTOTRwajlKYlhUVnQ5UldZaTkrREly?=
 =?utf-8?B?bU1NTzQ5SjNFMHhxbXZyLy93bkFIa3dXMVBHZ1VQNUF1L1BBbXRBTkdobFB5?=
 =?utf-8?B?TGlEVXVyQ0RCVTZsK3BFNkRJMWxBNVFtZEkyMGl3VGp4VGNYK1NTRExOVVZa?=
 =?utf-8?B?cjF0cXg4YU1FSlVXWDBZL1FxS09hWmRTY0Z6VCtLSnVvWkFQemdsM3RaaWpK?=
 =?utf-8?B?eWJMSitIYU84YmpjMGFTRCtXSUw5TFJqRFVDanJOaE1Ta2xOaVc3QTdIdDEx?=
 =?utf-8?B?UU5hcGI5WFVrZnFBMFVoa2JKeWw5OWt2N2F0YUxXcGE1ZnV4TnpLRDdBWDRB?=
 =?utf-8?B?NUxvWGxCMmdtTHF1cllvOHM1Z0ZEclp3Y3IrYjZZRjQ5WVNuUkZPMGFweS96?=
 =?utf-8?B?dkJZYytENUlKT0ovUElEd1BHcS9maXhkQTFaaFdRMWdETCtrSFAwSzV1Mk5R?=
 =?utf-8?B?OHo3M01XRkZoQ2F2YnZZbXVnNlB5MmIyZjkyand5eU1mZHc1cU44OUxUK3E3?=
 =?utf-8?B?OGM0WHc5RVNVOFBlUk5jU2pZeFN2dk5jQm1aY01RTHd3UVl4alMvNHRIc0FH?=
 =?utf-8?B?UWlFY0s5UlRreDBqcHBsOHlsOW1qN1laaStjUWZTaVVJbkpVQkhOWk43MjQv?=
 =?utf-8?B?bDkrbWpUMGUrUVA3Q1VkYTdvT1Z2UkV3OVc1NjFJdkZxVi82clJVZE1TTmhO?=
 =?utf-8?B?V3pJbVJtNFNRcS9XM3BGNTg3QVV6em94ak0vekdQaS82Z3kycUs0eElkeHdi?=
 =?utf-8?B?aGUrRVhmdS84R0NaYzR0Sm42cGZDelR2ZkN2Z2MxZzh2MUlETndSSis1V0dq?=
 =?utf-8?B?ZHFjSi85RGwzemxMTFJGMzAyN0ppc055OVlBalFZbUxRWmQ2c3I1TnUvdnZN?=
 =?utf-8?B?M3FKaDJmTHF4YTdTOUM0anhSbVE2K1R2aUV1UW9idmIwVHhselhrVjJTc0pH?=
 =?utf-8?B?NURFeW1DYk01SzJHb2d4S2g4VjdsWG1odGlvdnI3WjA0Rkd2M0IwZm5yRFZF?=
 =?utf-8?B?aVJRa0lRZGxoelkvanBuZGtLSlp5MTY3ZXNWQnNnMm9zblA4YkNrc0NOakVN?=
 =?utf-8?B?cUtCcXFsRW9SNW5WTEFNOThqUS9wQm5RMVJzaDdNZTgyNkpRcVRqbHJPZWdQ?=
 =?utf-8?B?SjN2aTZTdmN4TE45dEJwT3RBb2o1azQwUUtVVzlva3hwZTA5b29WWitkYVVK?=
 =?utf-8?B?dnJmV3ExQ0h4amw1ekIyd0N4dldielNuVlBiUjF5d1k2bU5VYmwvOEUxN2Zw?=
 =?utf-8?B?b2lhNjQ0Vlc0bUY0N1Z6R0s3L25oNEZ4SlRLVWdtUlRKSEs1ZG5IRU5RWDVX?=
 =?utf-8?B?UjZ0elAzb0EzOUgvUzlwWU5vYVVrajdCSGZhcWRnNEZieHJ0TG9mb1B1UkI5?=
 =?utf-8?B?UWNWa29TZWN0U0IyK2RZVC9mcXB3WHY4bDY2T1JUWlVIT3ZjOElyWFUrR1Zn?=
 =?utf-8?B?Y1dKcWVObGtGaWhGT3ErVEs3Y29UN1ZkWm13RXpxU2RGV3BXOFdKZDhEVGZH?=
 =?utf-8?B?RElGUWszVmhjUmVzMEgyTUV1WDJRPT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd475a51-af23-4ad0-d8df-08dd80b93b62
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 09:45:21.1907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 96zfCPQZyoAmwPofxGGinomwtARjMel2fgNsfXeoiVWqMIqk3GX878hN+Z2/rywBv+Dx5NhuTamLJx2pBwAiNG3XBjfGJ6JEpxMEvSBgEaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB7967

--------------9eMTn7cUYauWsAYiEPAz0ykJ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 21.04.25 02:08, Qiao, Wei wrote:
> Gcc verison:
> qiaowei@wqiao2:~$ gcc --version
> gcc (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0
> 
> Kernel: 
> v6.12.19-dovetail1-rebase
> 
> https://gitlab.com/Xenomai/xenomai-hacker-space.git
> tag: v3.3

I tried the following build configurations, all worked:

- gcc (GCC) 15.0.1 20250329 (Red Hat 15.0.1-0)
- gcc (GCC) 14.2.1 20250110 (Red Hat 14.2.1-7)
- gcc (Debian 12.2.0-14) 12.2.0
- gcc (Debian 10.4.0-7) 10.4.0

The default gcc version of Ubuntu 24.04 - as provided by the gcc package
- is 13.2.0-7ubuntu1. Seems you installed the gcc-13 package for some
reason.

What happens if you switch back to the default compiler, does that work?

I can't tell why, but gcc 13.2 seems unable to derive the object size...

As Jan mentioned the quick fix I posted is kind of an overkill.

As I don't have an Ubuntu system at hand and all tries to reproduce on
Debian and Fedora failed so far and in addition a lot of different
compiler versions are working fine: No further investigations will
follow on my end.

> 
> -----Original Message-----
> From: Florian Bezdeka <florian.bezdeka@siemens.com> 
> Sent: Monday, April 21, 2025 5:47 AM
> To: Qiao, Wei <wei.qiao@intel.com>; Kiszka, Jan <jan.kiszka@siemens.com>; xenomai@lists.linux.dev
> Cc: Chen, Hongzhan <hongzhan.chen@intel.com>; Pirou, Florent <florent.pirou@intel.com>
> Subject: Re: Build error of kernel/xenomai/debug.c
> 
> On 18.04.25 07:51, Qiao, Wei wrote:
>> Test pass.
>> The system can boot up and work well.
> 
> Which xenomai/compiler/kernel combination are you trying to build?
> 
> I tried to reproduce with gcc 15 - the latest gcc release - but it is still building fine.
> 
> You mentioned Ubuntu 24.04, which should ship gcc 10.5, which should be fine as well.
> 
>>
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: Thursday, April 17, 2025 4:59 PM
>> To: Bezdeka, Florian <florian.bezdeka@siemens.com>; Qiao, Wei 
>> <wei.qiao@intel.com>; xenomai@lists.linux.dev
>> Cc: Chen, Hongzhan <hongzhan.chen@intel.com>; Pirou, Florent 
>> <florent.pirou@intel.com>
>> Subject: Re: Build error of kernel/xenomai/debug.c
>>
>> On 17.04.25 10:43, Florian Bezdeka wrote:
>>> On Thu, 2025-04-17 at 08:15 +0000, Qiao, Wei wrote:
>>>> Hi All,
>>>>
>>>> If we build the kernel in ubuntu 24.04, there is build error:
>>>>
>>>> from kernel/xenomai/debug.c:23:
>>>> In function 'strcpy',
>>>>     inlined from 'hash_symbol' at kernel/xenomai/debug.c:94:2:
>>>> ./include/linux/fortify-string.h:787:17: error: call to '__write_overflow' declared with attribute error: detected write beyond size of object (1st parameter)
>>>>   787 |                 __write_overflow();
>>>>       |                 ^~~~~~~~~~~~~~~~~~
>>>>
>>>> This is because new gcc version has stricter FORTIFY_SOURCE( =3 is ‌stricter‌ than =2). Please help to fix, thanks.
>>>
>>> That is the flexible array story...
>>>
>>> You could try something like below (completely untested) and report 
>>> back if it works:
>>>
>>> diff --git a/kernel/cobalt/debug.c b/kernel/cobalt/debug.c index
>>> 25b194c26..d048dc757 100644
>>> --- a/kernel/cobalt/debug.c
>>> +++ b/kernel/cobalt/debug.c
>>> @@ -47,7 +47,8 @@ EXPORT_SYMBOL_GPL(cobalt_debug_vfroot);
>>>  
>>>  struct hashed_symbol {
>>>  	struct hashed_symbol *next;
>>> -	char symbol[];
>>> +	size_t size;
>>> +	char symbol[] __counted_by(size);
>>>  };
>>>  
>>>  static struct hashed_symbol *symbol_jhash[SYMBOL_HSLOTS]; @@ -91,6
>>> +92,7 @@ static const char *hash_symbol(const char *symbol)
>>>  		goto out;
>>>  	}
>>>  
>>> +	p->size = len + 1;
>>>  	strcpy(p->symbol, symbol);
>>>  	p->next = *h;
>>>  	*h = p;
>>>
>>
>> A bit of overkill, given that allocation and access of according size happens within the same function. No smarter way to tell the compiler to stay away here?
>>
>> Jan
>>
>> --
>> Siemens AG, Foundational Technologies
>> Linux Expert Center

--------------9eMTn7cUYauWsAYiEPAz0ykJ
Content-Type: text/vcard; charset=UTF-8; name="florian_bezdeka.vcf"
Content-Disposition: attachment; filename="florian_bezdeka.vcf"
Content-Transfer-Encoding: base64

bnVsbA==

--------------9eMTn7cUYauWsAYiEPAz0ykJ--
