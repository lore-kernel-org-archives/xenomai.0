Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2079.outbound.protection.outlook.com [40.107.22.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4413F3D82
	for <xenomai@lists.linux.dev>; Mon,  5 Sep 2022 12:00:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZ8ooeJWVBrkB25fCwtsYky9VQVfIDA2yUKB/R73lL1vsvqLBXn5bfKOK0XUQkn+weseA7DPGyboGxpQZ/8g4hFu0l3GR/KJDXZ4YYwd3ncy/GduKARMSCvOqOwaNC7Ya6cg49JktHtJDHA9Z3LFdpdoVslye6myUJ/Fxj3NKB+z19c4HO/A9w96pfSGItwbQigR/q9xEkT4j16hebrg4nJn94K1IJ9XVrIj5Ez1fAcifJYS1F1G07+hByUj31R82Plsk49uqKAtNSEh1swuL57Rt+ZGWpoM8bL/ExMJLNtHcGRLmlBA6PHBvE/DgeGfrpywN6zFbb3v5RLdH213xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkNxqjlBJRHtSvMsf1H1W7MQQ0i18ZTehemfr5+5KYU=;
 b=Y+qNbd53V1E1mEDU3eOyzkJqS/FYHjQjtLSDAdlhL10oPphGwfOZ0jncG/oUG1k+lIM47va7fSvQ5aL38qzw/uFtwgMEEJ5DNTWzqNmjFlrm3Xj9nHbtVhVZk0WsHu8RSqTZMuutqjeyuLFzqa/RMyq5YXs40GlAu/0N4JESo8RMThEKuEbVUgUwYinqnLOb0d9yqUUrZBfF3UnxwEgolxiUlsQvPt4e1+QleWSG14mZbdXkqsqMMTmD+upG3eYzHqC/j+uphXYDLLhqAo8bRnilPYFfmfLv9bVAwMbGw9CBvs+MQMPg7zuvvgW277ziADXSbU8TYmb7wtF2sWvXXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=intel.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkNxqjlBJRHtSvMsf1H1W7MQQ0i18ZTehemfr5+5KYU=;
 b=aY1yx1ssWQMb+QkPKwy18kNaSy1UyhEnZ/NfD9ZrU8rNF0tQmisl1aKBh4Uk7TVejADzpNwiowJUmhXATYxNRSw1y53HJ18LKsMwLHFoKG/n+J0XIviWMG1y17WR3n2hVVz7/RJEPDHwN2STVbKhSSCnYrIjhLauHOBkvTjGI+UKkSeMgxanJi9Vkqx36nUs7N3E8uZA+UDPJaHk8HcljfphOc4pKc8rlt6BP8LoLeqz6mFPEemJT9fgWKFZmoFZX1m9vpBqrf+BY7E1gElZaYrgNgqe7Z1CDO8S7FMYwBemihSpP7qo54P3Efa/9PmNY0cZe9c2LBwbjSleHjZ6mg==
Received: from AS4P189CA0007.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5d7::18)
 by AS1PR10MB5771.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Mon, 5 Sep
 2022 11:59:57 +0000
Received: from VE1EUR01FT097.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:5d7:cafe::e2) by AS4P189CA0007.outlook.office365.com
 (2603:10a6:20b:5d7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12 via Frontend
 Transport; Mon, 5 Sep 2022 11:59:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 VE1EUR01FT097.mail.protection.outlook.com (10.152.3.60) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10 via Frontend Transport; Mon, 5 Sep 2022 11:59:56 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Mon, 5 Sep 2022 13:59:56 +0200
Received: from [139.23.79.104] (139.23.79.104) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Mon, 5 Sep 2022 13:59:55 +0200
Message-ID: <c932287e-0574-3681-f7e1-b7066c94e547@siemens.com>
Date: Mon, 5 Sep 2022 13:59:55 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 0/1] net/drivers: igc: introduce rt_igc driver
Content-Language: en-US
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>, Jan Kiszka
	<jan.kiszka@web.de>, "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <20220822011821.21283-1-hongzhan.chen@intel.com>
 <ad5ac2e9-e662-ee94-94fa-c7d42b6e4b68@web.de>
 <MN2PR11MB4285D85CEB6935A1CC30EE64F2789@MN2PR11MB4285.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <MN2PR11MB4285D85CEB6935A1CC30EE64F2789@MN2PR11MB4285.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.23.79.104]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--25.693300-8.000000
X-TMASE-MatchedRID: eykcc/HsS31mvcelz2C5QLQc5DCOw3yNPg9yfk4YC0bM1jffIgQXhq1Z
	GUKR0YgsRu2i7U96I/s8LTT5jD43KbDoL9ytuR9pWo0SBooXS7Q4qGaEI/i7xv3HILfxLV/9Chd
	I4sLlrjiHJC/JOD1Qlb/hkGq+6aBQ+cj2iOHhSkcesaa2Wlm9t6VS2oTBTH9HSMFvyr5L84K6s6
	UL48vRAL2uIcc7lRe40PMPY3uIa1mQiRRm/eGhWdPPaj5Qewa2HWlGy04g9z5IcJTn2HkqsfmoZ
	6x4ZgCUlc8zdeVEPWWYpuG7kpoKRzBMLRvqqJyXZCX/q1YlZm1xSC9D7cl3qNtNtOEgicP6sKi4
	EXb8AIpS51Bc2UMFVbEThU84InSzr8+IB7pb9CBpTM4HZiEhc8tDKNMWTdcfF+qQpCWTUjkQtuq
	s6BbPJx+mWhwtM0ESPkqrm3IbK/O/nM5E8QS8mLEUURtFUw0wGUlRnSNPdxeie2FBq5CMBtQeZo
	36ab1g1EZ/lznv4UVCdQLWN9PCC6Ljs+k5BQwiZ4vashV8LSzUuaIAsdkZ6lllim4HFeWAV0QSZ
	/pNFUHHN9tnHHgXhKlwc05TlRp2rLrdQysupgxydLiKWjHcpEPqY0/D4oew9TCJfXmXS2/kRE2h
	9ncEXFezEE205dNvs+GbdNi+FiIr59u/gzv5MLUzq8RBkJuGSSOWVJeuO1A5f9Xw/xqKXVkMvWA
	uahr83Mh122xXdCt4N1jhRVQFLd934/rDAK3zGjFMngtLLWhJFQD69E10vA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--25.693300-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: F9027BE3CE223AA20BFE642A695DA41A6E8831F7BFA3547FB0C0CEB0F75ACB912000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd478652-bafd-41e6-bed7-08da8f3626a8
X-MS-TrafficTypeDiagnostic: AS1PR10MB5771:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oUhysmKdpH9lpWCsjo3ajSppsW81ONkH9eOIwQ0Rxjq634/quEyZ74A3MpIi20vjq7fGA37ZQYvW0jKUvOZv5KIfursQCF5sKuC31j8RXYz5DBPVxapKC693RSVPlnRzA5eKx5RJcYwlBYhs9jZjhSzCSM1E+54jAyfn6KJBwdr+I6RjeLeBZw7JKSnZYBdpJs5SaxfXKYbnRDj9EgGpFUJ66brokzVTnzE4a5CPrd80zTAu06I1Sc44gkjuJy7TrWD4gGE6A6dGMp5HwhsjnCGs4qcCzy1i9zWGIVu2IuCTIaEhRUaB8Xl/3u6Y4/68tYHwQyY58S/XELVSzOxii+LUmFNprldFVkFo/kghXuvXb0rQhiZzk8Uid6APFZkHGmbSEF8Hw6ZoGKXMrI/qF0Sw9aBys5ozetf1oebmamtaYPY/TKnuPVItzivn0C614uXv3I3cM/YpDoHS9DnyjaV9iIIUhcRZaWmdCUwcX+ZC3IALkdz9hMLuIfDIcOGoXO/xe27XS2Lx3IVmNNVgjvyVZSNJCHMzulttxAf+ghbkrOCykANvRr3EZvbganbrr3Lkxy1XjqJ4rCc8wuAgkFzq8i7wf4HdBNO4KlL0qHl07tWgmuio34Z5wKZn/mYbNHh/oUzPq88dHu0s7zoZ+LEid+UEP/65+f9o5KcAKobKstVSXiqclJEjL9lPTKduXTq1r1hJ29sSXFhaE7ug3+NMAnvjrfEn5y6QGQD7m7GD+JXfwUyQQDwu9urxteqEkEiRjDm/YIcOXaKeoRS5DejvDCdyCjNQxIX3Todl0wUJBuf8Ul3AaIoUEWP8uphI64FdZmzaY9SPM/n1fGt93GfnlXze7vLNmUlCQyicj74=
X-Forefront-Antispam-Report:
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(39860400002)(396003)(136003)(36840700001)(46966006)(40470700004)(336012)(31686004)(81166007)(86362001)(31696002)(70206006)(8676002)(70586007)(36860700001)(356005)(82960400001)(36756003)(82740400003)(83380400001)(2616005)(956004)(478600001)(53546011)(2906002)(16526019)(41300700001)(47076005)(26005)(316002)(82310400005)(6706004)(40460700003)(110136005)(186003)(44832011)(40480700001)(16576012)(5660300002)(8936002)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 11:59:56.5320
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd478652-bafd-41e6-bed7-08da8f3626a8
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VE1EUR01FT097.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5771

On 31.08.22 10:24, Chen, Hongzhan wrote:
> 
> 
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@web.de> 
>> Sent: Saturday, August 27, 2022 12:27 AM
>> To: Chen, Hongzhan <hongzhan.chen@intel.com>; xenomai@lists.linux.dev
>> Subject: Re: [PATCH 0/1] net/drivers: igc: introduce rt_igc driver
>>
>> On 22.08.22 03:18, Hongzhan Chen wrote:
>>> ported basic network functions not including TSN.
>>>
>>> 1. passed three network related smokey test: UDP, raw, dgram, But
>>>    I do not know if these three test is enough to validate the
>>>    driver, please let me know if there is other tests need to
>>>    cover.
>>
>> If those tests exchanged more than a hand-full of packets (to make sure
>> we are not leaking buffers, thus will run out of resources after a
>> while) and if you checked that the reported latency is comparable to
> 
> I setup two environements to do rt_igc validation listed in [1]. I also setup [2] environment
> to compare performance with i210. All three smokey tests( UDP, DGRM, RAW)
> had passed 72 hours long time test in [1].B. In environment [1].B, the latency 
> is about 60us better than 120 us latency got in [2] in UDP smokey test.
> 
> [1]:
> 
> A: I225<--->switch <--> I210
> 
> B: I225<--->I225
> 
> [2]:
> 
> C: I210<--> I210
> 

OK, looks good.

One follow-up question: I've just spotted those hw semaphore functions.
None of them is every called from RT task or even RT interrupt context,
did you check that carefully?

>> rt_igb e.g., then we have a good indication that the driver works. The
>> rest is field-testing.
>>
>>> 2. In addtion, another thing I want to discuss here is TSN functions of
>>>    i225 has the very similiar effect with TDMA not only from clock sync,
>>>    master and slave arch, timing mangement but the difference for TSN is
>>>    that most of fucntions is implemented by hardware. We are considering
>>>    if it is feasible to implement TSN-enabled TDMA-TSN driver to make
>>>    use of i225 hardware feature because TDMA itself is really heavy.
>>
>> Yeah, time-triggered send is basically what RTmac/TDMA introduced via
>> software almost two decades ago. I'm not sure, though, if we should map
>> the configuration of TSN capabilities of modern hardware on interfaces
>> (RTmac & Co.) that were designed that long ago. If it happens to work
>> our easily, it's a nice experiment, but we would likely miss other
>> things (Qbv transmission windows e.g.). And there is also the question
>> how to set up an operate PTP aside RTnet.  
> 
> Yes, PTP would be a hard topic.
> In addition, the TSN reference application I refer to  would use socket option for example
>  SO_TIMSSTAMPING but rtnet  does not support. It also use vlan to differentiate priority 
> for different steams but rtnet does not support vlan.
> TSN may make use of two more NIC queues to dispatch packets to guarantee deterministic
> for higher priority packet but rtnet do not have scheme to do related mapping or scheduler to 
> two more queues... 

Yeah, there is quite a bit of fundamental work ahead if we want to
enable that. Right now, RTnet is "all or nothing" of the card. Do we
have SR-IOV here, and could that help? I'm thinking of handing out only
a VF to an RTnet driver and configure everything that is needed to run
that VF with deterministic traffic on the PF during setup.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
