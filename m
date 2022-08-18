Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2088.outbound.protection.outlook.com [40.107.21.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEEA4405
	for <xenomai@lists.linux.dev>; Thu, 18 Aug 2022 12:50:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ifa+TfVGn+nBVnhY8y/CxbkKqd7GnFjQvXVTiz0njZtAxGWGOOt6IPaGdI5aNciU0fZwxgTxxen8fQcUsEyNRdpNzrCK9wA8RDLoSDgOpAtmMdnUmHct9OGVsOtd0j6VszOY5gDfpe/bcwELidawYyMJWlxkEnB4rFqK6PYc6trBD9L8jhpW+IPRQnRnzneUl8v0uPkZ1zvRmAOnSAy+P9/VHQn/Qf4FekhyahKJx0LnoKYHZ3xIiUoErsvpPwja9Kw1o1B3UwMJqAZweB5If6JzQOwIbdSL1MfV/ge+dLYyAlCyEKHOqXWdAoPHhjzyjCIKVNAuzF8SI4RIQAiuOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIVy6mLiFUV/XEOrjC2gouRq61akQNipefINu813kTM=;
 b=UxsYGMqOKt8FNdPDjxTOCDTcwo2iI5fUmHWi62WO4ctM6Dvi7fiKLfQxhhS3vu/sQrBIQcd0/unCgjIg8Xo5quTEeBPUVJOCe4UFwZ9t/t3BiKJkERAImmgD2Pyi3dx0YfEuNx+3hM4ixu9qPdvzpd+4KLgEKDGLSmvs9eAz625m7qQu1g1OPWplKEeZgPZrkZLD+5gshRl/VbUr2e/tBlOkoAa09zWw0WuXUOH3M7W5/Ric7WGCEcjKQ4imQeUJsi+KPrfTJeuSOm6pD/1p8jWbxKiZ+KvTtM8awS+DF8ySOhsgqsgByM3hONXOgGweGkX5ZpbPLb2cLEe8W2FpHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 194.138.21.76) smtp.rcpttodomain=bela.io smtp.mailfrom=siemens.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIVy6mLiFUV/XEOrjC2gouRq61akQNipefINu813kTM=;
 b=F69lCWewAm92/7voBFqbYXy92RI099uzQ2y4lc/6+OiKWdCem4Q6wpbLGMlRmMGXaY/4sGE6cDFPiagiaYclmZKxc65C3/y+umtsOltoMhbh8HoKZ+NCjGV/6TNCBgNyEtCQJsPuFW9Io7cEWPhrFa2k+v9cTsGlh6ojr06E48NL36zwQbGZqcX1SnpRuS3kUaNv2aDbHq7QRncaD3gPCOFIM3NHMEcSRX+i9WwOr/KXbMbo1hGcDL2D0B7SnEa680xlH/jgumMTlRsC0xL1PTTaqgzFRUh6c1mNREs3YD0ww8adF1ovH6gWn/wsghJdwwVYOQL59xcy2mDIBWwpUQ==
Received: from DU2P251CA0009.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::22)
 by DB8PR10MB2684.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Thu, 18 Aug
 2022 12:50:14 +0000
Received: from DB5EUR01FT046.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:230:cafe::45) by DU2P251CA0009.outlook.office365.com
 (2603:10a6:10:230::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19 via Frontend
 Transport; Thu, 18 Aug 2022 12:50:14 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=siemens.com;
Received-SPF: Fail (protection.outlook.com: domain of siemens.com does not
 designate 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.76) by
 DB5EUR01FT046.mail.protection.outlook.com (10.152.5.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.15 via Frontend Transport; Thu, 18 Aug 2022 12:50:14 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Thu, 18 Aug 2022 14:50:13 +0200
Received: from [139.22.139.217] (139.22.139.217) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 18 Aug 2022 14:50:12 +0200
Message-ID: <c5cdd1fd-7d2f-5276-bcc7-3000a6efbe04@siemens.com>
Date: Thu, 18 Aug 2022 15:50:11 +0300
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
To: Giulio Moro <giulio@bela.io>, <xenomai@lists.linux.dev>
References: <2eba63d2-9560-b62f-b283-194b99692c30@bela.io>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <2eba63d2-9560-b62f-b283-194b99692c30@bela.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [139.22.139.217]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--20.925000-8.000000
X-TMASE-MatchedRID: kxpaLTp5p64GIMvoc0zm9B1zJ/7joraZPg9yfk4YC0aPR2u912hYRKVj
	gXyvS9c/vn1ivDdpAIfzSerr9lENubDoL9ytuR9pg6t2qT3iOCFCf8FhUXr2UHycvC6I0dJIS1z
	wNuiBtITfUZT83lbkEHY2WsQTo6ONncH8J6d3AturyVtLxWPWVpkQqFknoewhfjUCBXbhed86En
	2bnefhoAv1OPvvDLzs+vo5Q3ytDQUM8WkpUhX3n5UYIN3K4D9zle+q6k7Q/cwvzLls7HTfGQ5GM
	zfaGfZvgW6bY8SOq3WjxYyRBa/qJQYnglAWdCYbt7DW3B48kkHdB/CxWTRRuyUIayx+Skid
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--20.925000-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: D248153AC740CBA1D83B0628A77DFDF4961C4F74F8597EB0A0909042D440FD132000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4bb2b331-e503-4894-bd2c-08da811831ec
X-MS-TrafficTypeDiagnostic: DB8PR10MB2684:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mCJMuHsbSVw1PGxeeA4tN+XimrcH0AdmUiKJWnH+uhMlvCHk+M3CfwGVR/H9eZZU77Yid34fw8ZjMHzxTTQhjCP5fL/LkM10mkm/kY44vf4I0G5W28zxJCxcj+t/nbkRUKr/pCOV3tULW9QS/wpszkfUPwx/ulhnDC0AlKfAQhSEmo0rp4w+LOkO9l/usItpIfQptnHgf8W5xNvWm1qnCRumc19BY3iEJ/JA1ODOc0unt44BRH4nlmTlkT1pXJ5rKTD1dBU65tXy+4QPwpi4ptKKWMR1DHXPFLPvZGgrV/0Ddbv60w5iDQWoWObuNx3BiZXJhfysHvLFlrGi/dpzL2n6IbAMtb+J67yOYRLbJIJ0VP09mdfcgboQxDqfdaJv26I/yFvlC/xtY3wvA4BugPVpIw2q3fxoVM9fPkGMVvNo/8AdTgATGSWKQk6zuS/6ATr8L3uwUPycAyf7FEi/DhELy8M+PjhwNTob2alOhMc//CYroHAkY0maJxQHYGxzO4ZRxpN/1qOTcLWat3cYmuO7Cx+MLFg5YbJYJ6m+NSXxohqlSCt98gngkcrzosDtWAxrJvzqyxYbcZ/0adIJla+JSU2tS9vSf3N+jAedh5iPeLJIdSAEtla/KQqNiSNRvFugxsvXMntMI57vBnPZRMOvTthbiaRREoiKEZpWwb+9SSk0P91HnxjtUDCjQFiz5N931EgX0qr8uScRi2KLIMjkxtM+86UUjB1SKcaBAoVKnr4ZdMQmiYUdNKqJTBPUcG3KQbtzqRe0hxzUjy2YQuNtmZ2c4FfFsy74t703ritg0fEcYTmsKc44mB66y+xzHUbuNJAGOnFIBuM5i543xjMGEX8JTUsarcj08SIKm1s3R5+Uu8r4hwYi6pDQBBmJ0puvs+SyTyJ9Axsvh4jUuA==
X-Forefront-Antispam-Report:
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(396003)(346002)(136003)(40470700004)(46966006)(36840700001)(956004)(336012)(53546011)(16526019)(47076005)(8936002)(2616005)(83380400001)(186003)(5660300002)(2906002)(44832011)(41300700001)(31686004)(82310400005)(26005)(478600001)(36756003)(86362001)(81166007)(34020700004)(356005)(40460700003)(82740400003)(82960400001)(36860700001)(31696002)(70586007)(16576012)(6706004)(40480700001)(316002)(70206006)(110136005)(8676002)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 12:50:14.2205
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb2b331-e503-4894-bd2c-08da811831ec
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5EUR01FT046.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB2684

On 17.08.22 18:59, Giulio Moro wrote:
> This was needed for my bindep-pkg build. Not sure what config option
> requires it.
> 
> ---
> 
> From 62063ad20509ba448f5601343b44647a00f5fcc2 Mon Sep 17 00:00:00 2001
> From: Giulio Moro <giuliomoro@yahoo.it>
> Date: Wed, 17 Aug 2022 15:50:52 +0000
> Subject: [PATCH] selinux: incrementing the count of known PFs.
> 
> Fixup for a24b313bd77a4b3e15168d8115a8d661113fac0b
>   'selinux: dovetail: declare oob socket class'
> 
> Signed-off-by: Giulio Moro <giuliomoro@yahoo.it>
> ---
>  security/selinux/include/classmap.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/selinux/include/classmap.h
> b/security/selinux/include/classmap.h
> index 8605d5fa893f..2112f07c36c7 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -257,6 +257,6 @@ struct security_class_mapping secclass_map[] = {
>      { NULL }
>    };
> 
> -#if PF_MAX > 46
> +#if PF_MAX > 47
>  #error New address family defined, please update secclass_map.
>  #endif
> -- 
> 2.25.1
> 
> 

Which dovetail kernel versions is this targeting?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
