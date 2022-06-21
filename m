Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2081.outbound.protection.outlook.com [40.107.20.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD1CA5C
	for <xenomai@lists.linux.dev>; Tue, 21 Jun 2022 07:25:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVHS53tIVhRTWsUK1uwsjQk9KIj38AVZeZW0JSNcPVWplqd8xKkgq6rEbSFSCPXWorzB1zvjsBecYu25BJ1aFfzS618q4Omb1l1hD6ILi0LpZInGf+r7MP49BzOdqnKiTOq0YXLdGt1uALM3SsyVum64hHQFH+5R/SUM0Yc15MBh9l8CwA8Wt8LFXKtarr2MF5YrBOO3rABC7qk/m22fBhfzVVVYRKSJrHYWknQBeVfN1zrpY7n5ZjFDXxX7/bFW8z/GoqeaEeHYcqBf4RwaLc4WpEtOJvF+1IJq32H4DTRhsxXL75Hkf3qF0feeeeI+z+cDlLfDlEKSq9/R4kJBXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSG1c8Yp0fF1VFC3pTnHl/arszZJiRd+gslc6NGcIuE=;
 b=cNuMOqSKNEzsDGY0iiy5OdkKDaoJThJbWSDcJB0u9PlLJWEzpuScvGr5Qa4ZIM8jxmLW2ojkTqjgCU6wY/5SUDUcKi7eMu0H9qp7sQLbaJfQB4Zvyyzha0Ef/aA4/cXY5hnt90SDdYbGvoDkMLp6LX9w3eYd8CNpbqkXVNTAZ15KGhsnwm7EFub3ABkYtjc+eSUCqL02zDqbE6EQVb0+Lw1ZC5CVagrvEtVfxXX+B7gr/2EeJglLzV2QjH3JWUNzPpdyXj9NqBU3oOWo1C5Xbs720AnmywTTIO2J1EHeHSGlADOsv/nsD6ZtDRCWfbWeyf0/R+ipeKFbVHsb1SLsqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=xenomai.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSG1c8Yp0fF1VFC3pTnHl/arszZJiRd+gslc6NGcIuE=;
 b=VuVlN04aklDMS49S0AntvcN4ACH+DKSUB3wSAQTSObcmbrk+A5z0ZG7HE9D1Zj9VLOxFaqLMeYHjIOzAPU9T6KHgxuS9odv4vv9He/MacDGcfTCD67gIihuhYmm+LxgjwFHIsFRopcIvZsTM7E39nm5/74KVz/QCdXBYXpz7DA1+W+RenE/q+GWY4HtPTIr06/iiTEb94rgfp0OSYDsl9T0Dtd15HfEI2QhOAJKObfqiwDfD33jxZdBTiT1YPZaprFAesBwhRaqAkIKrYiSVG80RFT1mu2AHo5VCfmQviWXjfh8N+HORj6B2sRFrJVgw5v2K0w8wkDwQk+fiJwjz7Q==
Received: from DB8PR09CA0002.eurprd09.prod.outlook.com (2603:10a6:10:a0::15)
 by DB6PR1001MB1255.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Tue, 21 Jun
 2022 07:25:27 +0000
Received: from DB5EUR01FT094.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:a0:cafe::2b) by DB8PR09CA0002.outlook.office365.com
 (2603:10a6:10:a0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Tue, 21 Jun 2022 07:25:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.72) by
 DB5EUR01FT094.mail.protection.outlook.com (10.152.4.184) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.14 via Frontend Transport; Tue, 21 Jun 2022 07:25:27 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 21 Jun 2022 09:25:26 +0200
Received: from [139.22.105.48] (139.22.105.48) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 21 Jun 2022 09:25:26 +0200
Message-ID: <0562704e-14cb-ebce-aa0b-ea0adcb7e4d9@siemens.com>
Date: Tue, 21 Jun 2022 09:25:25 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: 5.15-dovetail or mainline regression?
Content-Language: en-US
To: "Bezdeka, Florian (T CED SES-DE)" <florian.bezdeka@siemens.com>,
	"rpm@xenomai.org" <rpm@xenomai.org>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
References: <88b02fec-830d-24aa-ae41-bab5031dafed@siemens.com>
 <2307b8d0-e901-2642-6d19-bf1dca91f015@siemens.com>
 <a5d4cc9a4ba0457913c522048fb061444a7bce04.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <a5d4cc9a4ba0457913c522048fb061444a7bce04.camel@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.105.48]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--11.424900-8.000000
X-TMASE-MatchedRID: gWVgGZTbTRb/J7/cdz0rWm4COPh/7ifttkEL1EmUpaMZca7SN08UZAbn
	5hqHE5b1xBgoygRkMm1fPChVhdu3Pivn27+DO/kwtTOrxEGQm4Zw1ghGV72CB54CIKY/Hg3AtOt
	1ofVlaoJlgn288nW9IIghcpGUPiP65MIx11wv+CM7AFczfjr/7E0S8APyuDyCKbbzRqPQQQBXlk
	z4r/ZgABNGjQIKmmgdU7iRV8NIloU=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.424900-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP:
 B56D2FBFD7C2CC7FACE46BB781CDC81D1BD0698A26411DECE74FD36DCCE1F10C2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3334fe3-2f94-4840-af85-08da53573705
X-MS-TrafficTypeDiagnostic: DB6PR1001MB1255:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR1001MB1255169044288EC8F0F4572395B39@DB6PR1001MB1255.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YKxO20TW8CP9gqPP+uWh16Yo628es13JG+Ckp5wVA5eI0TF4+Em5OaK+Z1OKZWRPKrbZlI8FDAJAw6+wZG4c+1S3bFk0SuF5TLp8VAPXDAMld72NZbhju3F5Cc54VVg7sb6K36B7h7lsdTyozx65A8VS4Ldk55dT62xrTTCfJTDmumCKQ9JtuX7+FQSn0YpYzJDCWNTjv2QzdgVyVi5pZ+bXJSTh686htJD/zRUfrCpoR0U1luNCVFvZcHBr9f4IcXKCUgb/BD5opIE8yC+rHnAKvXPPq9r+81HgURd0BdzXCFakCt0/8qdQlNydNksPywSnxR0cy4TjEM7ChrWEthmYN/HoJY3WumhFIBHOvUGZQOFEY0DIO18Rrk0X7VBbLxKWHHXrFfHZqAbQ5SKFagsErMFuCa9cXEFK/smBTXVUGzSoY8IrjWyH0KDVP+87pRpSZJAC1V26Ybp6rBr3oDmSZSmW/mNfzs36OY4PXm90JW6TGBAwKWItBoE/Xx+h6vm9oBZS5uZvsNJ6WUEATfBowRq5xnEPIhlCyZTpwV21MnZsCB3wLw2L8jJZajP1ZZI/P8xETVbZ0p7BsChSLlBTK6Lsfx5E1wytxqe3vSmsASf0fEoICWMxJhbf8dayeoTntleHkR3V6DhuwYi5xmAJFM5mTuCm7VC8TRa4rLVeHhv+1NFCuM2nsBM6vexEWS3FHpP9mGfZrjKnoXwBxoMPNM+/Ow8zwVJ/tLyQSi4gKTpnQsquYWjgfabexx+cGj5HN1W6lKyDGT4BaJG3rJ2bS9S8h8a1eI0KANeOg4NFWWJVQcE5kYrPwmBmzci5
X-Forefront-Antispam-Report:
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(396003)(39860400002)(376002)(36840700001)(46966006)(40470700004)(316002)(478600001)(44832011)(16576012)(40480700001)(110136005)(36860700001)(83380400001)(31686004)(4744005)(36756003)(8936002)(8676002)(6706004)(70586007)(70206006)(5660300002)(47076005)(53546011)(41300700001)(336012)(86362001)(186003)(26005)(16526019)(2906002)(40460700003)(81166007)(82960400001)(356005)(82740400003)(82310400005)(31696002)(2616005)(956004)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 07:25:27.5944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3334fe3-2f94-4840-af85-08da53573705
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5EUR01FT094.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR1001MB1255

On 21.06.22 09:19, Bezdeka, Florian (T CED SES-DE) wrote:
> PS: Can we use xenomai@xenomai.org again? There was a test message
> yesterday which looks promising.

Yes, it got resolved. But I would still recommend migrating to the new
address.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
