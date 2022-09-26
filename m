Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50043.outbound.protection.outlook.com [40.107.5.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2E038D
	for <xenomai@lists.linux.dev>; Mon, 26 Sep 2022 16:33:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BULFkuPPwWM72nWOS08lO7HQubP7L31munQgpS3EkrJqPXhj0O7o6u7E87Vt7SoxaReQkcu6i3vx1rvhE6IQ/MZC9WzcMgU3tcYrLQOf+k/Che4YaNQQd4yq73Vyo3bbAUKYC1t3p68bI5Z6afhavFxyz7uPuL/yXyBUrgeK1WP50zVcPSuo1g6FQNJYHcRkzQaEpRaVN3msXpP7RBHOXzyXD3R2sWprjKo8CH4I1CnlsX3dh9/WEa4LD40bvP9UGzQcCuJ37lFF67K9hDUSH4e7ol04cBvK8xV+w+6VmMY4YEiaq3brzD/bAl7DMnOD5wfcnN9+mVy7n5iYJjgJMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjretuBJQ1u061iOIGQyvPAU9nMgUoCcJkvs+FMc4yk=;
 b=VDbjiOiFEOGM1+aZpojH3WzdnFnwnStvHTFQmT0Tiuy3MroVvCI7cvKDAtCTE7fq6cOakjKUzAgtTM/LivPjvTTMzUjvx87JlYtN73PLfS+bT+AMtEippFjHQcB5T+wyx+h0aTZg5zkOm8IuPHvFvhy13TrvLt6JOqrz1xtTqkUJZbcxmXtFD7RgGdNhU+YwdzbfqQe31I4GFiweXF3s0mCVyMFPXnFBS5WA0BV0es636/VScVSheoFP85OUxq+3heabBUnq3VekBHUNZXU0HWlEXCEt5wbqXlonMiLgH8QvJKxEzSAIidkKq3xoH+CHZtClzrYE+htiKI68op1jjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjretuBJQ1u061iOIGQyvPAU9nMgUoCcJkvs+FMc4yk=;
 b=D3XVdaBwF8BgA4tw2ZZyqxl5qrV2nixQwJZ07mKI4U9y1Zq3d3v9RLCWA3Y/pAWHzuzWJVjNGh0s0aACEOVdDw3BgDExsM5yp71LWWV71qBJjOGcgrtS9D+nwMQlDE7xD1IIdldy3bq1Cq0mKctFJna9u67YJi2RjoGJ14uYhW5oP4u3XbE3ZsjuCkG3QqZhfAyZeon/rYdsVWuEhJJip2xi1EH/suzLtLGiRuNtr7S8spRYAK+cfLUnna5R47PfUhv7keXFvIihhyZc65JE9M0SBgjxlfMip4odfGN25AejAjPLqGNhN6J1RQfAsy/pg1dHSx2UIlmzFBVmBbN35g==
Received: from GV3P280CA0044.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:9::11) by
 GV2PR10MB6431.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.25; Mon, 26 Sep 2022 16:33:00 +0000
Received: from HE1EUR01FT015.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:9:cafe::6b) by GV3P280CA0044.outlook.office365.com
 (2603:10a6:150:9::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16 via Frontend
 Transport; Mon, 26 Sep 2022 16:33:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 HE1EUR01FT015.mail.protection.outlook.com (10.152.0.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 16:33:00 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Mon, 26 Sep 2022 18:32:58 +0200
Received: from [167.87.17.23] (167.87.17.23) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.12; Mon, 26 Sep
 2022 18:32:58 +0200
Message-ID: <0422cef4-3e77-836d-0d67-a75abbca681e@siemens.com>
Date: Mon, 26 Sep 2022 18:32:57 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [xenomai-images][PATCH] ci: Update AWS Deployment settings to use
 Cloudfront URL
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
	<xenomai@lists.linux.dev>, <florian.bezdeka@siemens.com>
References: <20220916132115.32643-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220916132115.32643-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.17.23]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--18.578100-8.000000
X-TMASE-MatchedRID: UgbjIbm2QqbdDS6etHbe26x38sCrHdkHPg9yfk4YC0YSEYfcJF0pRU8k
	gvk2XctFMYkmNIO7+hYs7W7nLtOct0XgvWQOMaftMbdAWUD+/AWq6W3AJ8aVbj8Ckw9b/GFeTJD
	l9FKHbrkhg/had72R1F896reIChkilyI8S4mT8odOK+rVow/DPrx3mx6MnhF1fgFnYw42PF0BDy
	a2JbH/+pLIQKBXBt8ksz8QWnnsobb6DxBeqeXlOupGJSAHQICs1ZteLfOPw7SOtWfhyZ77Di6My
	Pq4TWG5tsxVqq1TeAWSLvAQjXykCkGPbm3tak5+kZOl7WKIImrvXOvQVlExsMC4UUZr4lSF+gD2
	vYtOFhgqtq5d3cxkNYK4HTgQbHHGyhdYKwok2/hsV/gv7XIA00lN5tOnkFHMl9yvU9y+gUbFhXM
	jdQIJpg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.578100-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 4BE3301762A0367868BBC6DF71DB5801D4C339C0960BD511BECC1EBA3D825DA32000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT015:EE_|GV2PR10MB6431:EE_
X-MS-Office365-Filtering-Correlation-Id: 6411a38c-7582-4ee9-3db7-08da9fdcc6cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lj6Edv1LnuepBgAqIImJ57Xxp5xi4SzUttw9K0ryYbA/2SYWmbc4wzqRmbggXxnyyic6RPEK6B3QrnPJ1PjhlXU60q5I6SzRF4oPMCgze/8HZKv3PHtEPk69h/mN6Dmhdc9jdgVU5KWkTzdr2pDfWMxkQ2EKKqmY9BCftT/rqvJvaRQeOEQgnn4Tq6289fGgSNVCqXkmATlLrwdd+eyv864mv05Ky/AtVz1ZUbX3g6POh37poCR74bMDbSpCoEEj5XO9cxENjns1bKA8h82wjmRYtsVJVYsDwvIKBnvKhXPPq+M4m3xMe6WR9XRZKtZQRy2po1nsTNK5ELoGuTW3LRdPk869DARrzvUH8oF0p/xvV+RcxFgtERFNfC3j+pqDsjWjo5f4d6m7nd97PtrRuKFv9OWY/r7m7XDsfs78DECylBQTL/srkjPrW83E24vf5XtC7dh3mGqD+oF8w6oNb4tmslpcO6OeE6ZyUEUqByxcoEmJjsflDNfxa5ikG2we805mszWl+4dkjTo5idvvIWRzQxxENxorI/UfO8KnlfJncoi06sCMMImU0C6ccVx4N22Wbx+DeMP6I/iVjc67vCcdMKxHsLurHqMTRkhxX+d1zFuHDlcNYEeuMItTrwUJMZj+0Bow3Xov2/kKJ3X4kZx44Y4zy+5WlcdX8iM/t0Hk7koorGB6zOdCuvexW5Xs5dJdOx0keaIevJCN7QA1cA9NOSmO7/T/nq8UaA1BOKEQV5vckAibkd9Kva3lALv8YfV0eMRIAsoQVtA0+pgagIQjaWA/jMrGua/kdNWU3BSGst/E1Q9xZpASCbrxE/VNATs0hiMHUN3J1cww+qismc7SjOQ6NR83DMkOCh+jpIoyvnuA/auwmTN2OMCRM9jA63qtq8c4kHZ5+gUJzoBeSaWx+5A+pVZxjyPSDs6Y8Xc=
X-Forefront-Antispam-Report:
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199015)(40470700004)(46966006)(36840700001)(44832011)(5660300002)(26005)(8936002)(53546011)(83380400001)(41300700001)(40460700003)(82740400003)(82960400001)(36860700001)(956004)(186003)(2616005)(36756003)(2906002)(82310400005)(81166007)(16526019)(336012)(47076005)(356005)(6636002)(110136005)(31686004)(40480700001)(6706004)(31696002)(86362001)(70586007)(70206006)(316002)(8676002)(478600001)(16576012)(3940600001)(43740500002)(36900700001)(131040200001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 16:33:00.2304
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6411a38c-7582-4ee9-3db7-08da9fdcc6cc
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HE1EUR01FT015.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6431

On 16.09.22 15:21, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Remove the acl settings as the are no longer valid.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  scripts/deploy_to_aws.sh  | 10 ++++------
>  scripts/run-lava-tests.sh |  2 +-
>  2 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/scripts/deploy_to_aws.sh b/scripts/deploy_to_aws.sh
> index f5aed6f..c555a2c 100755
> --- a/scripts/deploy_to_aws.sh
> +++ b/scripts/deploy_to_aws.sh
> @@ -25,8 +25,6 @@ if [ -z "${destination}" ] || [ -z "${AWS_ACCESS_KEY_ID}" ]  || [ -z "${AWS_SECR
>      exit 0
>  fi
>  
> -aws_args="--acl=public-read"
> -
>  isar_base_name="${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${target}"
>  deploy_dir="${destination}/${CI_PIPELINE_ID}/${BUILD_IDENTIFIER}"
>  
> @@ -39,17 +37,17 @@ if [ ! -f "${kernel}" ]; then
>  fi
>  
>  #KERNEL
> -aws s3 cp "${aws_args}" "${kernel}" "${deploy_dir}/${isar_base_name}-${kernel_suffix}"
> +aws s3 cp "${kernel}" "${deploy_dir}/${isar_base_name}-${kernel_suffix}"
>  # INITRD
> -aws s3 cp "${aws_args}" "${images_dir}/${target}/${isar_base_name}-initrd.img" "${deploy_dir}/${isar_base_name}-initrd.img"
> +aws s3 cp "${images_dir}/${target}/${isar_base_name}-initrd.img" "${deploy_dir}/${isar_base_name}-initrd.img"
>  # ROOTFS
>  if ! ls "${images_dir}/${target}/${isar_base_name}".*.gz ; then
>      gzip "${images_dir}/${target}/${isar_base_name}.*"
>  fi
>  image=$(ls "${images_dir}/${target}/${isar_base_name}".*.gz)
> -aws s3 cp "${aws_args}" "${image}" "${deploy_dir}/$(basename "${image}")"
> +aws s3 cp "${image}" "${deploy_dir}/$(basename "${image}")"
>  # DTB
>  dtb=$(ls "${images_dir}/${target}/"*.dtb 2> /dev/null || true )
>  if [ -n "${dtb}" ] ; then
> -    aws s3 cp "${aws_args}" "${dtb}" "${deploy_dir}/$(basename "${dtb}")"
> +    aws s3 cp  "${dtb}" "${deploy_dir}/$(basename "${dtb}")"
>  fi
> diff --git a/scripts/run-lava-tests.sh b/scripts/run-lava-tests.sh
> index 30a853f..70deb36 100755
> --- a/scripts/run-lava-tests.sh
> +++ b/scripts/run-lava-tests.sh
> @@ -17,7 +17,7 @@ if [ -z "${TARGET}" ]; then
>  fi
>  
>  # S3 artifacts
> -artifact_url="${LAVA_ARTIFACTS_URL:-https://xenomai-images-artifacts.s3.amazonaws.com/artifacts}"
> +artifact_url="${LAVA_ARTIFACTS_URL:-https://d1a54g2tyy2hl.cloudfront.net/artifacts}"
>  # public master
>  lava_master_uri="${LAVA_MASTER_URL:-https://lava.xenomai.org}"
>  

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

