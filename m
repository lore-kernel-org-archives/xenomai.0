Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BC33D82
	for <xenomai@lists.linux.dev>; Mon,  5 Sep 2022 11:49:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPtxdfxPBghFTicwgSVnaaWZm4jDAlGr8ZeFIOepaAbOixGi1rTh57TJdcncOsOa5Oe/YwkJBJJ5hYvqVn5/fIjfJiGQMaz6bKhbcqxu77F9AfFNvBzxvK701hc9OMBBwMUA0Pop2opazExdMEDkQIay7SP/metcNOqS2VQDRhYemP0Es4u+vA1A0gHiM6KoXHdTG/SlpwNqpK4RVoAT8xps7/NpWsidA2AhCYBG1E88gbN5J3Bo4Cl65t0HABI1munYccsp4NYgubSy/5aG7HKNm2yEoLZtpA3yGkAeF1H/VHAKNH4+UtEcYxW0f2JSxY3c8lFnuPObU4rFh6VJEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEDrqPn5CX2iD1vgnW7cCVF1eplbdA20i1q8ABvsH0Q=;
 b=F6t/ekmha9fItsvATHdODBFWpZiT6TFjw/EkFreNOWnFfTwsprzuS9aZdlI1rzK3sfCF5nnOJinRw2tiT8lOh5Tls4EQakMKydf9iTXwRSANtPq40wufK2Q5i5aXQyFfb3dtxfPRqG7axDXVZuNKDw6Eony1G+K46S5DAr03UOUiGy3IEsw8HWBw0q6HJmkNmupJEZkPd6yyWVkob+Ss44/IUZXge5bJ3zh57Z1Uz24ygFNgX2C/AdaXNktLX1Qf3bdHWP34+/AWKXv/b76613K3DH9988Rk/sSiFAmWfRV4Q3K4xkg/nEPmc3L821gLFG9I6eKa/WfVHRlzrhao7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEDrqPn5CX2iD1vgnW7cCVF1eplbdA20i1q8ABvsH0Q=;
 b=q/vFg+l+aNBCFwXndbE2G/2F7oCg2gLCn5hpp0p8u3SjPI5Fg+mHXBrX6KWWI+fAaacnrvE1WIJqNJDJB+kvRMyhwORnUCVrdZFmpWBaMnpV4ZjX5OdmZ190U2K/gTGaDvIFoyyPSIfzIlN6vbQHh7DSuzwf30yadzsahOIvn/7s+GdlM1Z43tD6Qgs+ASwUxxrIljx74E+YcSoA+jdiG/rKivgXDiWr9h0hmgk+3iXhtnzChTTF6MWBPmB/nB8mvTu7KyVthYtNXKWeDzonvktlGpq5F3OOAq0fhvheJ8nv8xBJpBfLTNJ6LBLTF8+HaU0QUmPAZdbdE9aI7uV0zw==
Received: from AS8PR04CA0187.eurprd04.prod.outlook.com (2603:10a6:20b:2f3::12)
 by GV2PR10MB6720.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Mon, 5 Sep
 2022 11:49:50 +0000
Received: from VE1EUR01FT044.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:2f3:cafe::7d) by AS8PR04CA0187.outlook.office365.com
 (2603:10a6:20b:2f3::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18 via Frontend
 Transport; Mon, 5 Sep 2022 11:49:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 VE1EUR01FT044.mail.protection.outlook.com (10.152.3.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10 via Frontend Transport; Mon, 5 Sep 2022 11:49:50 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Mon, 5 Sep 2022 13:49:49 +0200
Received: from [139.23.79.104] (139.23.79.104) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Mon, 5 Sep 2022 13:49:49 +0200
Message-ID: <55a0cfac-3707-bd00-2ce6-4f7bc6299671@siemens.com>
Date: Mon, 5 Sep 2022 13:49:48 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/3] rtnet: Enable compat ioctl interface
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, <xenomai@lists.linux.dev>
References: <20220818071442.16567-1-florian.bezdeka@siemens.com>
 <20220818071442.16567-2-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220818071442.16567-2-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.23.79.104]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--9.871000-8.000000
X-TMASE-MatchedRID: 0ayLSLUekQU5QaOxwNGfvo9bHfxDWoibueEnIw0gB7b23FLYbMDsfwEP
	JrYlsf/6HNORVFrWC04aJw69PPKrRa3aC25avUua2v4PzRk1tzKSUA3vmCcWBJTaJnWciFiiRwD
	U669267y3CLdtdG1oCGBt9mS7pKVTeoqVs1ZLrvAzd+tJEfcx1FxxDx5qbkR9OX/V8P8ail1yZ8
	zcONpAsdmzcdRxL+xwKrauXd3MZDWhNyaOMoiE/AEjPDuhcWqNKhNXH3Neh0zfcpjAelpIzBJ6d
	2O9ummf
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.871000-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 715D9DD91CCFAD84A9C9418233283419DDFAD86B7B696C244A58A123434460002000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84c8d031-b335-446f-e545-08da8f34bd57
X-MS-TrafficTypeDiagnostic: GV2PR10MB6720:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dZlU8FfVdG1e2PGoiaIdkhC4AbrihAssXiw1w0KU7mUJZyPmKel6prP87CSR7+qJV1EcQma9+CS80lFg8w/99884jVzDteCUGAal47r4TBAF46PYFquVyh8v+BxtmywVLERRhb+YFtQ5VRO1d/UL8h3OcugTejaUbXBHNM7B/lxDqxDa0eDWNCcxoF5ZDwLn5H5J2NUN7kCzvOVqPR3oza+pCtL7ZuSSa1iIrRblYrxCWc0dZ0B0Xonu9HZKDRXgVYlGruUfi7EFSMdfYcmFYgIISOyKYV1nFcKrbHcQdQUdui/F2huCelAb/GsrQah00hH/Itdd0aPISrbBosvl5eDBZC7o+mkdb08lsWm/P/ItkfAtvsV4sj4lkgdkV2dgnVHE9usQ1kXyIAuCEyKHwvmW4zr+W80TWfCERkwfZyId43ZoUdWX6/IePX+DoV4B8WD5oKA1MzNzO85wHmyCgkfw3noK1m9fo03mOdN+rthPdw/iN2Zl7i3yuLc6jEKWqu2CJcBV++8ItfuRijIgGyQgbCqlA00mJLYsdcRB/dkZCYqgJluF7dulVAZe6mt/rr1raxpooLGkXeYEZGGpkkuK3AImoxfykSLFhOXPiGtBAPcqW9pkbbW47eABtHmBj5GgZkX/huIUaP1v8ArjewTsJO3JdaOu2ytTAo245iRzc8WpCzOexcEoXU8E790Shjr2/gxP3uiDZVKBmYUgaKp9Mcu9aPMLWWIWRcKKgR7QGTljU3iZn/A3YPxN6AIjW7Pq0F2qgbdrHQcUltXzlYl2CtI+0gnqx+bcOGBAwjQ69s0ITCuRu+Zy8Vuu44pNW1mX7Opd1/r0zNtDRWelM+2JH5OMCPbbRvVnIBnfMpo=
X-Forefront-Antispam-Report:
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39860400002)(346002)(376002)(40470700004)(36840700001)(46966006)(41300700001)(70206006)(47076005)(83380400001)(336012)(2616005)(186003)(956004)(316002)(6706004)(36756003)(478600001)(110136005)(16576012)(8676002)(16526019)(53546011)(70586007)(31686004)(26005)(44832011)(40480700001)(31696002)(356005)(82310400005)(86362001)(36860700001)(5660300002)(82960400001)(2906002)(82740400003)(4744005)(8936002)(40460700003)(81166007)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 11:49:50.3603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c8d031-b335-446f-e545-08da8f34bd57
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VE1EUR01FT044.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6720

On 18.08.22 09:14, Florian Bezdeka wrote:
> Running rtnet for compat applications failed because the compat ioctl
> interface was not activated.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  kernel/drivers/net/stack/rtnet_chrdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/drivers/net/stack/rtnet_chrdev.c b/kernel/drivers/net/stack/rtnet_chrdev.c
> index 9457661a1..fa859c3bc 100644
> --- a/kernel/drivers/net/stack/rtnet_chrdev.c
> +++ b/kernel/drivers/net/stack/rtnet_chrdev.c
> @@ -195,6 +195,7 @@ void rtnet_unregister_ioctls(struct rtnet_ioctls *ioctls)
>  static struct file_operations rtnet_fops = {
>  	.owner = THIS_MODULE,
>  	.unlocked_ioctl = rtnet_ioctl,
> +	.compat_ioctl = rtnet_ioctl,
>  };
>  
>  static struct miscdevice rtnet_chr_misc_dev = {

Applied this one already, thanks.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
