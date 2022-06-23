Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60082.outbound.protection.outlook.com [40.107.6.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BAF43F2
	for <xenomai@lists.linux.dev>; Thu, 23 Jun 2022 09:35:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDC2mOWm0J0G2LpZ2wkpnQmqYAgX/fQqJXuvF6Rv/qj2xrvEgZHHpPTrZyrwdJUvoMd2U3K9kDKi0ebpbew9hX9XDQJLXyiEs/5wjJCSfuEYzAdNZwbhjykVNzFEUgBxciULmrEesPmiha21pVr14yXInhnpCGvP/JIJw4nxAOTPqUJT/8PU4XZ2z6aYUGsMXUnWC4m+dStNZrKeHj5AjUwixvAJOwhFWbAECl8Rz8ygcqs8pHqTxkJUpmSOea1k8FNU5PYSv1fG8zIxf8S3mMNAJUjqMw2YiM4aEEVJgBWqDZXysz3vEqQd4MvIGZsvlZbqA+vW79hf9Ra8SQ3WNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWq8za4IfD6s88/Jr4puB1lhB8D2W4O6iQyYlk8JTQw=;
 b=BMjuY2CaUK4VA8a1sw8AQex4xegjsOs+kHNBR3JO5RiUgcIDI88eeDd1coXxAi9z6UtIu7sDvc836Yb+rlfOrIvfiHs+1VScvNIeU0R0sUYjne2UEnHU0NduZxAndmF6WK0wsQCKmRZaDaUVNjSWf21c8Q5qhCpkUSabv3LbELzukYhRhvk39x20uVhUmGcNar/X27LmiyZPVOtsbG58trShX3PEekQK19W9+eWS3WAframLYGXU5MSPfoxpoq3qOeLXgVSXo7ryD6ZavUQrGbMqdR3Wr3nC2kaOci+bROUrrddDCxOudId4jtPC/A0S6myCHRTzpC8CFJw1EVDtvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=tin.it smtp.mailfrom=siemens.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=siemens.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWq8za4IfD6s88/Jr4puB1lhB8D2W4O6iQyYlk8JTQw=;
 b=lr8iSWl9GbFOuPK3HKTBJbHgmc8ABDc22PJTg8KZrWfD3GPoHCfFOa0du1rSk7jXhG0vVqKAO8RCAEk5DRrjfEoFlC+8wqpwzwRMxoNBnBwSSdRdtRnzh63gqP7rLVQYt+UotzE11E5Bvz7KORg1aN47FFsauaolPdVp/IJsaZ/ndicjJYipxT5OQpxwoKOYq2If2UUXVaf2w8z+Uot5VQdvPK3ZR29M1kJcxj8Od4qP4SN9VzTmp3rx8Vr3mIhsunwRsqCVU3kANzBZM20k58qK5gaGu6k+4jNqlM3XpeDK8v1GkxXhCsozoyMPqicYHkk0XMHoWZe63YVYKhaXoQ==
Received: from DB7PR03CA0098.eurprd03.prod.outlook.com (2603:10a6:10:72::39)
 by VI1PR10MB2127.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:2d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Thu, 23 Jun
 2022 09:35:53 +0000
Received: from DB5EUR01FT026.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:72:cafe::e5) by DB7PR03CA0098.outlook.office365.com
 (2603:10a6:10:72::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15 via Frontend
 Transport; Thu, 23 Jun 2022 09:35:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.72) by
 DB5EUR01FT026.mail.protection.outlook.com (10.152.5.2) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.14 via Frontend Transport; Thu, 23 Jun 2022 09:35:53 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 23 Jun 2022 11:35:52 +0200
Received: from [167.87.6.167] (167.87.6.167) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.9; Thu, 23 Jun
 2022 11:35:52 +0200
Message-ID: <8b54ad63-8e53-3c01-2b93-a1356facacd1@siemens.com>
Date: Thu, 23 Jun 2022 11:35:51 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3] utils/net/rtnet.in: fixes after shellcheck inspection
Content-Language: en-US
To: Mauro S. <mau.salvi@tin.it>, <xenomai@lists.linux.dev>
References: <4e8c2890-bab4-ea31-4db3-0866b389db3e@tin.it>
 <63e4b7c7-bc03-6ca1-f4e1-ac8b77d8826b@siemens.com>
 <7f7ea65a-a58e-33e3-1680-2e59289b2be8@tin.it>
 <fc9fc714-e1e8-8132-7cc3-76e7ee1f4d87@siemens.com>
 <d9a4b75d-81bb-28ea-4bee-293f19637c05@tin.it>
 <cdef20fa-8134-6706-e43a-b94a2e98334b@tin.it>
 <7556be30-4977-143c-f341-cdf1074bf4a3@tin.it>
 <868172c1-7a1f-9a3a-2a3b-55a12aa73958@siemens.com>
 <8bb2afe5-2c91-ec51-e544-65278d56f841@tin.it>
 <aacf04e4-91e3-6232-5b1d-c6570ef6e3f4@siemens.com>
 <86d5b170-dedf-000f-5f23-31bbf9145fd2@tin.it>
 <2897f396-1074-bae0-4cf0-46a97084da2c@siemens.com>
 <eae8a831-fc6d-b297-f03d-d477e9ef61ca@tin.it>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <eae8a831-fc6d-b297-f03d-d477e9ef61ca@tin.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.6.167]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--10.639000-8.000000
X-TMASE-MatchedRID: XYZjbEcsSe74AkTW3FFRihr3Sp02t5CNPg9yfk4YC0a8coKUcaOOvdq1
	p6neH75UQElZmpic3to5khb3w81T2LbA5L7kuBELr08WjbgRB+EtW698SW8GnGY+xOrx57jWAPi
	R4btCEeai94yedfsPOrWODdZ1PDmEbIPreAkQ5T2jtUyHKvGNNe9e8ifCHArbK0+leiJxLlcEa8
	g1x8eqF97p0Ru8jKvFyxFgoBQvBFpFhtKHemq9onoEYjU4TZUyU/iZp2cK49xeYVWU5uHQ/EF+Q
	lYpjQppBsa4Vv7How0j9vifTTZuG6GvCFqoKSwTkZOl7WKIImrvXOvQVlExsJaWKijZlsbB2bNx
	1HEv7HAqtq5d3cxkNYwmYPNvIh23wiLMxunXMEqX4xQua1lKl64azWevwbRSAM307BR/nw0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.639000-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP:
 D12B38E9EAED9427CDE52A538DC35B12B57154B5F8F8214176CEBA99AD1E1CCA2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43fcb268-e55e-4502-c565-08da54fbc457
X-MS-TrafficTypeDiagnostic: VI1PR10MB2127:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR10MB212700874B85CECFE2ACB4DF95B59@VI1PR10MB2127.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yySSADzmt6jVfQ+6iWSMexFcfWr0IAvKFBvBgspc3ib4Iyh9gOtTQ5bYhle0kIKmYwiMQVe6TSFOCp6PjBuxUkk55CbCzz+nFM5vwmL7anRFbScep/pufrwDJDNb+eig+bxrEzeKLfuV0vWRPGoDo4NrwswfjppcP7j90+bgBGOjd94vRYQvKqJIF+kfZqDVwAU+8rKuslPG0Naux0e2cYFN6g2BIRsXbuqfm/QOEDtKWot1DhKTG2l1agcve9fDcbbOd0HxfBxA9P3V7ehx0yQg01hRfia9fLoXylMFjVXdKEloGxnQzslx1DlhWVlcsYYp8KN1kcoLZ31hZdR/16r53U+WfWWf10YT8ows3cqUcruxEOSmSuh1ytttO1YZXJ4dT3sofvBYuL3kX2PEQIHyeZGYqENUv/F3y+4ytbX0I0KpetOFrmPf5Y4TJXaEDsOIwWvigBi5QelARGkbxYwQNL91rgTP05EYEwCEdygAHqlgkff6hqgl8uOlXKO8mcj8u4LpZzxxFapBaE4P+NcMOlwEsje4aFOcsYSYjRi9cH2ZPg+8p72QFHt6rN7OEuTLHEdWDzxDOoV8QV3OAKfUHcX6QTj/rV23n7Sl51vjCOzxCjXLmcnAJZ+CNI8D/+WbyTYOXttq5BTXkW/7kRFHJDsHv4H4A2n05nLFC1wxy/+PVSkYX+LZrsVjYJwfWK976Jhn8tnBUqj4DYVmqCc2MAmHL7N1T/Uuofha+2V1TJ/Ygl9rFc+sz61Wwg8TQLr5nViSSqlnXrWGnrd1i03NgsXNc3F67ZsJR7ZfYN/7UrcK7l30braXkPM5Qnz6ovyQIn5ySZAxRHaPsoHzxUGBMsik+2ikRs/dxfnNiN7zls1jxbb5sk7co+bLMR9ch6alt76hcQ/adpi2dg6ZMA==
X-Forefront-Antispam-Report:
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(396003)(346002)(376002)(40470700004)(46966006)(36840700001)(44832011)(2616005)(956004)(356005)(110136005)(31686004)(4744005)(2906002)(478600001)(36756003)(16526019)(5660300002)(6706004)(82740400003)(186003)(41300700001)(82960400001)(40460700003)(8936002)(81166007)(966005)(16576012)(316002)(31696002)(47076005)(336012)(53546011)(40480700001)(70586007)(70206006)(86362001)(26005)(8676002)(36860700001)(83380400001)(82310400005)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 09:35:53.3176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43fcb268-e55e-4502-c565-08da54fbc457
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5EUR01FT026.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2127

On 23.06.22 11:16, Mauro S. wrote:
> Il 23/06/22 10:59, Jan Kiszka ha scritto:
>> On 23.06.22 10:48, Mauro S. wrote:
>>
>> Please use git send-email in the future - I've fixed up the
>> misformatting manually this time and merged to next.
>>
>> Thanks,
>> Jan
>>
> 
> Ok, sorry for the noise.
> 
> I'm using Thunderbird in plain text, with text wrapping disabled.
> I see the patch correctly formatted, both when I send it and when I
> receive it,
> but probably Thunderbird does something "magic"...

I'm using TB for single patches as well - with
https://addons.thunderbird.net/de/thunderbird/addon/toggle-line-wrap/.

BTW, you can check how your patch is received here:
https://lore.kernel.org/xenomai/eae8a831-fc6d-b297-f03d-d477e9ef61ca@tin.it/T/#m7da3e7f94ca18470aad6861eafcbce338f6ccad4

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
