Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D33C7E
	for <xenomai@lists.linux.dev>; Sat, 23 Jul 2022 14:28:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kW5l5Tz9OwGmcX7su0f5rAFjCMC8mxEZUElLWsjm4svpi9UzB0Hi4L1rb9MfBe19k+uVibsw3ZUNpGtMwhIT24HCUANDmVr6biDNG+k1zSZ88RVQF3thuCiDxmjTVJ37DZFZcCsSHxVs6mkhv9BS2S+GRkzTKDrn50jckB/1t7XxFYGdCnsH7N0q7fzpo4iVTP5HjAapS2A+TMHDL6u6UtPAUDFHAKJkmTIc61EB3mwXX9c4ObLbS2AlIlf4cwFXITnfVGC3+UpmslhK6sHcnDAWQWVluih9wjYLPqM+QdOHVwj4rtxY/gdL5hIn2UlTzuOzUcJVzzJV4/F67bzY+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xi5z29QKDm0fOCqN39PbiqPIZ5zbgpFQoZ83fu65eVI=;
 b=KyYPrBsu4P2wxlBg1HSbAfrrGNFgFEEHesfz22ppKJI+yb5b/dEolN/gwh2F3tAzHYIFlp5jgiaGU07cgVgVI2bElUjISKBWGS/5eOXW0vNj4URxEZXDbw2dJlZGw95Y/lQttgIxz3PHAM3FuimXc8LufpjXkjMsY8MSCb0cnSTKG+K2MEDiOHGjXEwFDX685TAduNO+hQFRc5TqWg8ABKXAmXQn2mJVNKFLq8oCIIhpFOsAqLrhRFDckRM0NnaqUXS+dPBWFwYHOK39xiqKEy7PZO9KVUdal2jf7SpCPIJ0SJKtyRPbpNy43GgyqcenoKE9bQSSXHhEQLNcbyW9rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=gmail.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xi5z29QKDm0fOCqN39PbiqPIZ5zbgpFQoZ83fu65eVI=;
 b=tgzX+54xlHWNBCSTtXvCi5G/+TITzRqeMOSNWnW0eoQOfe8I8z0ry1q4ztaWnnSviD5ol7vV2AlmNSc3Xo1+lccSJgCmRYZtXsLI4xKWR8IRfSIVQw64ybiY5YodPiPXpKq07ankk5Ng9VWd8tJJhmcu0LYYfJelm70YP4QKRanxIv9B6b4vSjyTqNGe7+Ec73k/CggeY0QlpneFynJM7ZDZpGuJxbjoLrSOJftWTiBqtG9APWE+0RMgTlQsJWthvypQpyr4tCw6PUrmuE73TMN2JMD06BVFqoTeDBnaca+UiABpEOA3ibVz2Ax6rsVEA3gNMyJMXg6LCr1dmLarOg==
Received: from FR3P281CA0122.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:94::6) by
 VE1PR10MB3072.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:105::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Sat, 23 Jul
 2022 14:28:39 +0000
Received: from VE1EUR01FT009.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:94:cafe::34) by FR3P281CA0122.outlook.office365.com
 (2603:10a6:d10:94::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.1 via Frontend
 Transport; Sat, 23 Jul 2022 14:28:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.70) by
 VE1EUR01FT009.mail.protection.outlook.com (10.152.2.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.17 via Frontend Transport; Sat, 23 Jul 2022 14:28:38 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Sat, 23 Jul 2022 16:28:38 +0200
Received: from [167.87.41.112] (167.87.41.112) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Sat, 23 Jul 2022 16:28:37 +0200
Message-ID: <9ac8c987-07b7-4f78-a1db-249b6383c4cb@siemens.com>
Date: Sat, 23 Jul 2022 16:28:37 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] fix build with clang
Content-Language: en-US
To: Norbert Lange <nolange79@gmail.com>, <xenomai@lists.linux.dev>
CC: Norbert Lange <norbert.lange@andritz.com>
References: <20220721100432.672540-1-norbert.lange@andritz.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220721100432.672540-1-norbert.lange@andritz.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.41.112]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--16.457700-8.000000
X-TMASE-MatchedRID: FSxjOqe5tUMepAyha3ctZsU8jBVxKY1xPg9yfk4YC0bece0aRiX9Wlds
	bGTm3zYnB2QWi8BF5ShpRezoWC5XLZaSqTYi+C5aYTfZ6fYw1B0jjSj5ypko399JA2lmQRNUu4I
	CdvW94WGOSVCvVHWJJ4R4RLK5G1ihK+fbv4M7+TC1M6vEQZCbhnDWCEZXvYIHngIgpj8eDcC063
	Wh9WVqgtQdB5NUNSsi1GcRAJRT6POOhzOa6g8KreQv6jOc+ek2i4KA+KfyQxZNMhMDvqqIOA0Ta
	ySWQYx0+quyocWlxzc=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.457700-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP:
 390A0FE7941149FB6EEFA6A124486CF54E4C9BB2F267B2193AFE09FFF8FB66AF2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dcfc4f16-38e7-4fcf-1de0-08da6cb7a2a3
X-MS-TrafficTypeDiagnostic: VE1PR10MB3072:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nbIMybxqusccjPb1M9Ius8uundV1cn7K/YjsVK6+aK0Bi6IiSNUZG9zW7FtUCHORIxgKG177HTsPWrfZbZRWiOh1Db0y3Pec6EDCcTMQw4x7q9/HiP2p7PM86PddeI157AzDrGxHrufPcckBANgqslMiziuJ11x33KhHnfRZIZ68X+HP6gtCk9OOIR+roZ4zuTH/A9/I8ttQP6r/s1GkTuNLGIcETIzsbdhAmJmsRHqt0h5zE40WcTT8gIE4hgHn7qev8x1hXCTBTUj7EsdUXw+61x7j/YTDhTolaEMCKQoxKe8ieFL5ngTjdnVkRwsJkGPgXW5MdHKRopPaStIjq55WrQOBZ7kZQDCL/o1JzxX81J6egxnvxN2fC8AoYn4ltFLw/qG+7meYudllQ0CCPnV7OYYsPQj4YfU06TycpC5gdGNHVcATvS6OdRpr5G/OBYQgJwI8ZQaGOWfKJkCNDWr7+EDCl0anotoJ8QhS6qNV1E2Kp/pukufovZfeBR/MWW8xUfHKE8OT6R9RPVRl8KzNu1it1ZfiAnPGPjy1sX7HTIJQhHWNg/y2vK8U8AysZ2+y/WdvVtjLiYc3HvpSUE9VLk9IZaXTzN0wcDl7/V155qopK5AIVMQ2CvQnHqRBePlZ+TOKNTxWdd4OK9BC9zJy9M4CxylyzamCT/AH5YOV+YFYv4vGmTu/j2fJIoId+P/DWJy5N9ZyZGY5YqxsqWWSbTSdnfSo8Pc7MU3zCcArhj25QDYmS5Wajvi1y+r8D4kPakEIDpNmKVvjQWktBc/VnAHpwRZpuF/1yj2yMds9ravSmz+YrVNPa0c+7kLOZ9SDearzvmjdeJGOw1uRud9JQUZkdLVa/JArBdL/0Ng4/qBXMIlShe2n+La7bx1b
X-Forefront-Antispam-Report:
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(346002)(39860400002)(376002)(46966006)(36840700001)(40470700004)(8676002)(4326008)(6706004)(26005)(31696002)(40460700003)(82740400003)(83380400001)(40480700001)(336012)(16526019)(41300700001)(47076005)(186003)(86362001)(36756003)(31686004)(70586007)(82960400001)(7596003)(82310400005)(7636003)(70206006)(2906002)(356005)(36860700001)(53546011)(2616005)(956004)(316002)(110136005)(478600001)(16576012)(44832011)(5660300002)(8936002)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2022 14:28:38.9291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcfc4f16-38e7-4fcf-1de0-08da6cb7a2a3
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VE1EUR01FT009.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3072

On 21.07.22 12:04, Norbert Lange wrote:
> clang will never support 'variable length array in structure',
> and there does not seem to be a reason for this weird construct.
> 
> Signed-off-by: Norbert Lange <norbert.lange@andritz.com>
> ---
>  testsuite/smokey/memcheck/memcheck.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/testsuite/smokey/memcheck/memcheck.c b/testsuite/smokey/memcheck/memcheck.c
> index a33700f49..c12d658a4 100644
> --- a/testsuite/smokey/memcheck/memcheck.c
> +++ b/testsuite/smokey/memcheck/memcheck.c
> @@ -80,9 +80,7 @@ static inline void swap(void *left, void *right, const size_t size)
>  
>  static void random_shuffle(void *vbase, size_t nmemb, const size_t size)
>  {
> -	struct {
> -		char x[size];
> -	} __attribute__((packed)) *base = vbase;
> +	char *base = (char *)vbase;

I don't think that is the same. base[n] will address the n-th (minus
one) buffer of the size 'size'.

>  	unsigned int j, k;
>  	double u;
>  

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
