Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70080.outbound.protection.outlook.com [40.107.7.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550053D82
	for <xenomai@lists.linux.dev>; Mon,  5 Sep 2022 11:38:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHM3aZI1YQ7/3mdtKbi0ZTMTMlhKXuZ1RCMt+mJf3JMtpUBLTJZDsZbs9XZmrCWVs5GkN+Imyirx4jeNIfZQh7YMICwH9fag7b5y1+0/X1H9TSmk+deab40niM+tBs5giiOmjUeLVPEXDbGynOu020jsUsH7uFQCH8O4yl7akJP9lm7wxCh473wXVqUrRig7xHNbKMB8ltjtCW9k3BdZgETJENUiLkTsOwsJVci4XuwMPzKuEIAKs5dDPmlPxTvqlga1v6aYDiep7luWquqfGXDZBi+71aXFXRH9vlscYw7PbsJbU6olzKBDtrVYm83OLXhNSVJv4iy/OwMb0Zwcdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MaJoD1hEtlm/lkrxKibczu2ZUQxpdUYIYtTGOtMTT2M=;
 b=NWS4pYNLe0RIq/77TESKvY2SJjUUlM9ri9AyWj5O7oGkjOpG/G2LPs5gDsAduiXBnBlMboMD+5yrANRQQVVaUVFuu+XadXDkAqhekq7yPg1vJ83QRJ8y22YCMMhqxsyl+ysSdRK/+eHnUdL1egfv9UV4Z0ZIJeE94USuXaAhFBwwmCHMk2396/KJvjoXeJMY0UIAMwnA6a/bkyEekNCmVbyYqqYCiW4XC1loRjEXG1e3E+ons9XGBpz8TWRQ06aVVvvPw3R/cJWTxpGuZzBsG+z7WDmO0uj7IbODlgm7kmr+sVyIwDw67bdU97OjJeyJk63SERkzUR9SuHxHeDv2fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=bela.io smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MaJoD1hEtlm/lkrxKibczu2ZUQxpdUYIYtTGOtMTT2M=;
 b=Dybp0JtjpoAE2qNcN1YW6WfXfw6paa19zGCej72OOTu9g4Hp/sRB0B8qlzTD+49KAXnBYT2A82KmmKhBzmVuVwaarhMGQkO4zvtxV7OkOXplEB2lDGwnJmQoQsTvkosJbYk8CeJBQBb43c9ndmg2Dh1PP9K8BGn6XWblZy/6baoEo7Hm0kIBXYZG9ANfxWi7zlFZQJUy6sZ9I+4mTks0dCCjtEzbIZkSGTEm/KGnYpHBthJ9sysFvrjJa8C1ORnS3K8uSdLiSU7oySZrZWyV58wLoLO4JoPKH/YZ5dKA8kzdvCMyOCy1r+5cJ0s53+yF2nX2cnTMx2BOKpe2QetP5w==
Received: from AM8P191CA0025.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::30)
 by VI1PR10MB3646.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:138::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Mon, 5 Sep
 2022 11:38:07 +0000
Received: from VE1EUR01FT057.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:21a:cafe::e2) by AM8P191CA0025.outlook.office365.com
 (2603:10a6:20b:21a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Mon, 5 Sep 2022 11:38:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 VE1EUR01FT057.mail.protection.outlook.com (10.152.3.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10 via Frontend Transport; Mon, 5 Sep 2022 11:38:06 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Mon, 5 Sep 2022 13:38:06 +0200
Received: from [139.23.79.104] (139.23.79.104) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Mon, 5 Sep 2022 13:38:06 +0200
Message-ID: <e07c15a4-1934-a157-cc37-7d027c48d871@siemens.com>
Date: Mon, 5 Sep 2022 13:38:05 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] selinux: incrementing the count of known PFs.
Content-Language: en-US
To: Giulio Moro <giulio@bela.io>, <xenomai@lists.linux.dev>, Philippe Gerum
	<rpm@xenomai.org>
References: <2eba63d2-9560-b62f-b283-194b99692c30@bela.io>
 <c5cdd1fd-7d2f-5276-bcc7-3000a6efbe04@siemens.com>
 <696f43b5-c61a-2e94-2840-7a6b06dc2c1b@bela.io>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <696f43b5-c61a-2e94-2840-7a6b06dc2c1b@bela.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [139.23.79.104]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--21.452800-8.000000
X-TMASE-MatchedRID: qeBAs1OleyYGIMvoc0zm9B1zJ/7joraZPg9yfk4YC0aJUlmL3Uj0mP41
	59kh1JlcIwBtsiUnVNSETMjf6aTOJ9XPRrB9GBM/JqvZyzSBFsT4kBiMXhevoecetZHFh20W3Sk
	TY86NiDgvfU/riSJXkTaqWBgHP7EjjzqLvABc+8iajINAXT7+F0vB8k/m3FQqjpyluct2Nr2CF6
	GkB9h+Dz+B/tp8itBTc8E5p4psr/5zIWZLcXOUbZMfUJb9OR2q36+nC2sgSjLnTYvtA+C5imFJu
	1E9dvuM96Y0U2Rd33nzPvRcNNSOxlrsKsrBqKxwzatjOFl7Pg4saaYlMvaOHAPZZctd3P4BUkCy
	fz2KH3iPVQ4A6OGlkftN2vjEPERNv8qe8eDZGEmYeihb/0g171/gigjYmFkNbl4CKqupkMr0VPv
	T0zx0mIXiEjOByvq7nptr8PnHpynnzlXMYw4XMAGLeSok4rrZC24oEZ6SpSk+Mqg+CyrtwA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--21.452800-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 561E4FB584C91E3534DA36ED35AD53F1C0A68F4BAEE9B9B10CE9E8802C2AF2412000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47914892-cb82-4327-165d-08da8f3319f3
X-MS-TrafficTypeDiagnostic: VI1PR10MB3646:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	B5xj2922cPDif0aosRPFVVtDKz9I/0tAqoMweR2p5c6mF4d8ujSvhJPNP2hQsuQuxrMw78e505AiN0W/qXxxWShtWMNFuWjw3pw57vaWdLGpl52rFUkTG8F01sH2Z84KUrlWVZPlNX7m6IjBGLCnhZQyIst50Ql6BGqeLOq5phV9G4/+Z1RtSHDSeEssxXAXLiue5Stx+yX+VqhJ+MjmOIuNpd97tegCl4qlLv5RDp3hZmG7G5OktZ5EyFX2dn5pVyggq36Z70GRzovCgEFV4VPFefo/QrPHZ9zX2kDVTVXcmqXNz1LG/7iXV56cH3qRmoDk2PAL5AzeHGE/mInEABDKLhBglIVhHoSxHCdoBZc6NN6HpVe643mbqGEfk3SDfet/sjgW8yVN2q5/pRlS3QCqc1KpOmE5LePE9tTW5Jm2mFXKZ9XGaL9EvCl0+3rCFtubqdGcmmaJl5itshKn/rWlF/a6Mb3uTHPY4lyj0tCd0QAnI4FVDQ+tHH0AG2cSjkaemQ4zpvl+KxREzhfXS78lkTWZh7YJ0X3ipGCVEGRUt2LTDYAZA2WcybGCwzH1ODLltOSete7udzUzFPxIN5hbqmh2it21dCyKIybbZq0ZLLhQTDdwye8qONmdmwjB6nGXe3FzLDrRheKfPAp/lxS2brcxD7tEx4PeJWXFLaNrili7hv6EuQ96bP1zcGGDEDXJUZ2G6hdVapm71+lIvUnVYd88XpFBcpAofyRq9Is8MA5LWzMdiHWVtBLXQjKzadZEp6l5lK1+JePIHb1htybzxSuxh4cDkh2gKZMUiMNKJW31YaWGlsft3Q3Gb8s7LjLSk5Py5ZOY/q3DbuBMqb/qP/t16rhzcmFwKdF8D6SGf0AgzgAFUrRkApFwS4lIC4JHyyGY3Z0wIgEdXXuHhw==
X-Forefront-Antispam-Report:
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(376002)(396003)(346002)(40470700004)(46966006)(36840700001)(31696002)(82740400003)(36756003)(478600001)(966005)(110136005)(316002)(6706004)(16576012)(31686004)(86362001)(36860700001)(82960400001)(81166007)(356005)(41300700001)(53546011)(40480700001)(82310400005)(956004)(26005)(40460700003)(47076005)(2616005)(8676002)(2906002)(70586007)(70206006)(44832011)(186003)(5660300002)(8936002)(16526019)(336012)(83380400001)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 11:38:06.7343
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47914892-cb82-4327-165d-08da8f3319f3
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VE1EUR01FT057.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3646

On 19.08.22 11:49, Giulio Moro wrote:
> [resending because it bounced back from the list]
> 
>> Which dovetail kernel versions is this targeting?
> 
> This was applied and tested on
> https://source.denx.de/Xenomai/xenomai4/linux-evl/-/tree/vendor/ti/v5.10.120
> but it should be equally required and work equally well to
> https://source.denx.de/Xenomai/xenomai4/linux-evl/-/tree/v5.10.y-evl-rebase
> and probably any containing the same commit  'selinux: dovetail: declare
> oob socket class'
> 

Ok, thanks. So, it's only 5.10 or also later version?

Philippe will have to handle this change, adding him.

> 
> Jan Kiszka wrote on 18/08/2022 14:50:
>> On 17.08.22 18:59, Giulio Moro wrote:
>>> This was needed for my bindep-pkg build. Not sure what config option
>>> requires it.
>>>
>>> ---
>>>
>>>  From 62063ad20509ba448f5601343b44647a00f5fcc2 Mon Sep 17 00:00:00 2001
>>> From: Giulio Moro <giuliomoro@yahoo.it>
>>> Date: Wed, 17 Aug 2022 15:50:52 +0000
>>> Subject: [PATCH] selinux: incrementing the count of known PFs.
>>>
>>> Fixup for a24b313bd77a4b3e15168d8115a8d661113fac0b
>>>    'selinux: dovetail: declare oob socket class'

FWIW, I don't find this commit ID in linux-dovetail.git or
linux-evl.git. And looking at it, it's definitely remains unclear to me
why we should doe PX_MAX += 2 here. Can you elaborate?

Jan

>>>
>>> Signed-off-by: Giulio Moro <giuliomoro@yahoo.it>
>>> ---
>>>   security/selinux/include/classmap.h | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/security/selinux/include/classmap.h
>>> b/security/selinux/include/classmap.h
>>> index 8605d5fa893f..2112f07c36c7 100644
>>> --- a/security/selinux/include/classmap.h
>>> +++ b/security/selinux/include/classmap.h
>>> @@ -257,6 +257,6 @@ struct security_class_mapping secclass_map[] = {
>>>       { NULL }
>>>     };
>>>
>>> -#if PF_MAX > 46
>>> +#if PF_MAX > 47
>>>   #error New address family defined, please update secclass_map.
>>>   #endif
>>> -- 
>>> 2.25.1
>>>
>>>
>>
>> Which dovetail kernel versions is this targeting?
>>
>> Jan
>>
> 

-- 
Siemens AG, Technology
Competence Center Embedded Linux
