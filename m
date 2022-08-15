Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50063.outbound.protection.outlook.com [40.107.5.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF516184C
	for <xenomai@lists.linux.dev>; Mon, 15 Aug 2022 11:56:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmo8P2Pk4lHXmThi5gbVaqbRA9zGrZyVtpgSb1TreZZhdAOAppwacArg0H+qw9AhJni3xlhkxvm75HA0dxRITx/34HlEpcrKe4XeCFIorf/x44hVOcBsyZTAgaINiusgAcvovUQ8xZoOFtoaVyeFs5HfRN6G34ejfqyH0/XSLzSVGpwUWimvmU2WJ9LI69i1aoByV4xQ02uh+wNuMt+kFAJcSlKBhF+yXjpb8e6YcUiY4/VsFEYY03opJcHiq5YbBTILuk/2JbaqzRYhouXf0czausA2lUG4fZyEi1o0cCVWDKCGcST3x8A1Jc2xqT8Xrldq2WkXJhE9Od7mJyybtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G61u3eMDt6HIDhGSwr8uFB2sIgz7nMbKAY6UyR9GerY=;
 b=OM5EYOi1ZVUn9C6m34YvZLnnwA5OWB19KpXWOD+jgfgyRP8D3KW4e1Hkl2/u3GZVG+72+jb5RjcyeYB0cE+0dWN+fFBxZ/1TXJct9nhDDZEooNalSKSgfuP19MFI2PZfvSyg37nwcRGY94fbT7O5ASoFhZPGQsO1W/DwLycXWcErmuaaTCRanikLlIBCA8JypgM9HAk/qAcqeFE7Ul/7YK52AnguW147ugFOZKzFELB5QywSv/ZayHc8bh6HC/xTFIPEDwC34FuOA6/EFE3W87Rb4J2OYz13xMDqOzo68UI3ew5iiUoL4cax3Cm1PFPz6n7yXbyWsKvwNM5COehKhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 194.138.21.75) smtp.rcpttodomain=philips.com smtp.mailfrom=siemens.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G61u3eMDt6HIDhGSwr8uFB2sIgz7nMbKAY6UyR9GerY=;
 b=asmW2EJBtSZZzPD5mKLICVXuASbwdCTJP7IeetQUfpoF5ROiiy3QI3yuWGlGveBAKChjsBxf9XR1eLgwiqC1kVDIDivDXfj7WTnPx/47cH7z1DTuSsyNA+p6sAaEIz7iXP+Juvv78NID7vhJ3F4OT2IRZHwS9CygJv0B9sMYjeaLMLcP7OuOQ7Spwc/TDMQEqRuXp6qo926Qvm24s2JPSaXqnIlP419qdrY5TBN39RO2CgRsibfVMB7VczYchOrbK6etAzvEqdGdQTFKkdTNKpKsTr2Xm3joqgUEYTX6wjnaMG4+dO/widq+dTcnSQVR4cyfsqLO/QI1SxBJNtnP9Q==
Received: from GV3P280CA0073.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:a::12) by
 DB7PR10MB1931.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:5:c::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.17; Mon, 15 Aug 2022 11:56:11 +0000
Received: from HE1EUR01FT014.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:a:cafe::d7) by GV3P280CA0073.outlook.office365.com
 (2603:10a6:150:a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10 via Frontend
 Transport; Mon, 15 Aug 2022 11:56:11 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=siemens.com;
Received-SPF: Fail (protection.outlook.com: domain of siemens.com does not
 designate 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.75) by
 HE1EUR01FT014.mail.protection.outlook.com (10.152.0.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.11 via Frontend Transport; Mon, 15 Aug 2022 11:56:11 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Mon, 15 Aug 2022 13:56:10 +0200
Received: from [167.87.14.55] (167.87.14.55) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.9; Mon, 15 Aug
 2022 13:56:09 +0200
Message-ID: <72810e59-33db-821a-64c1-8e2c41bdacd4@siemens.com>
Date: Mon, 15 Aug 2022 14:56:08 +0300
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [[I-PIPE PATCH]] ipipe: noarch: Fix ipipe level end interrupt
Content-Language: en-US
To: Gunter Grau <gunter.grau@philips.com>, <xenomai@lists.linux.dev>
References: <AM7P122MB022949A2E0ADC59FCC8809BBF2689@AM7P122MB0229.EURP122.PROD.OUTLOOK.COM>
 <20220815102704.1825151-1-guntgrau@bbl.ms.philips.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220815102704.1825151-1-guntgrau@bbl.ms.philips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.14.55]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--16.060900-8.000000
X-TMASE-MatchedRID: Cc2Ao8tLfKDPhQMrvkSA3r6YI58LYP7EXKlUkWaHqwvx5KZMlKYS/U+c
	rEA4+nhZWAuSz3ewb21I2G4+LR+k2ybNpQWNMK2NmkGkedb7C36JjS8iOK+MioS/TV9k6ppAF43
	0d3dMHkYnXBZmkoVhSe3ysWjNsapALHKCt2FwkyHPk0ByibR6MD6hJYir1MIciVJZi91I9JiWOD
	D/yzpvdwdkFovAReUoilvAb18i4hOp8InwajlUhBrlGIRS0oy0Lan7PVCaTid/OBWacv+iVS6My
	Pq4TWG5tsxVqq1TeAWSLvAQjXykCkGPbm3tak5+kZOl7WKIImrvXOvQVlExsHAruZnjhopu+gD2
	vYtOFhgqtq5d3cxkNfAxRSAc0OEN9v+NNOVSdf++rqyfyPCAwZxdpsVQeyCDTGyVYZk0/nghbAM
	xXLX5pcoBpQ/atJ2V
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.060900-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 489A719224B6EA5F9EACCDBB8D88C817474599E8BFAB6AA41B55BE7D439B7C132000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ffad6f3-dd52-4204-a39d-08da7eb52598
X-MS-TrafficTypeDiagnostic: DB7PR10MB1931:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDBIMGxJQUkzejhLWE5QY2Q4eE9CRHcrdWFkU0JIWGFlTllqVVJKRWd5d3c5?=
 =?utf-8?B?am5oMzZQcjlwMGsyQkxCQVVUNjRMQktvMUkyRGYvNForZTZWSndMRTNZNFR6?=
 =?utf-8?B?RXhpRW53b1NSVXRGWmdDNlpvYWpGK3E4THJYQ1pWNjZ6VEhOeEdxZW5lSURC?=
 =?utf-8?B?YysvZU96TlBIa3RGU1pGbUxtWFdwZ1ZVOFZTRGErYXFsS2tCNlYwU0dKUHA5?=
 =?utf-8?B?am41YXQxV2FkTnNiWE9VR3ZYTjhZeURzc2ZtdVNqczg4VFVJelVWeExwNGRn?=
 =?utf-8?B?eW04NGZ5aUszb3lJdHJab2dqR2F3K3BURDZ3REFGY1N3RkdkbTVXZTB4UlZq?=
 =?utf-8?B?MXMrd08ybG91SlI2QmhCMWtOcGVSSFAwb0dHMUc5bU1Idk5nTGRRbzgwbnRR?=
 =?utf-8?B?NlpsdnZiQ0VNcnlPTHlxYi83ZXlCL2xIOWU4WkhFMnliUDVrS3ViWmRsUDFh?=
 =?utf-8?B?b3A2OFBQMklrTnJ1SlMyRFVkUFA4U29zS2ZJMCtRS2ovU0hOdkx0TmRvUDJV?=
 =?utf-8?B?Nm9IZ1N2YkdoNzRIYUdmNkxneGE1UzZ0dUlTOURXZ1lzZFRUelFqRXpUODdl?=
 =?utf-8?B?eFZ4YnRPOFJVN2I3cnFpRlZMVExuV1E4U2ErTlNwbG10WndqWC9mVWZxdmVy?=
 =?utf-8?B?Z3E4cFVac056eDFRYWd1dEVPUUlkby9zVHBDVTRJOUV2Q3N4VnhQOWs1M2FW?=
 =?utf-8?B?bHhtK1BYeHcrcDFwa2F4Z01mNWVOM1ZNTUZPa0RFektPN1RBSkZZM2FvdDhT?=
 =?utf-8?B?amhyRng4WlR0U0ZRcXdrbW5BcUs4c201ZDVSNmd4bU5BNnQyOVFibi9xQ2lq?=
 =?utf-8?B?Zi9BcEpJam5mWXVhWHI5K0RESXQwYU8rRHhya3JUNFIrOEp0THEwVXFHcEpS?=
 =?utf-8?B?YlhIWWRrYWR5cDk5bTlKajZYNVoxdnNoU2xkVXRwb21WbzBnbmNEbFJNdEN6?=
 =?utf-8?B?SHZTN0toSno0RlZQenFHTFpHVzVzOHBYaktjazBkdyt6V3p5cEIyYXlBbDJw?=
 =?utf-8?B?TEh2SFBneGl6cE1MRGpHZmE0R3ZqcmRrWVc2MEJyaEpHNmdsbS9ySXllZVlH?=
 =?utf-8?B?OW9zdmtMdFc4bUZWaUNBVkVrNzB5ZGNaVHJoV0J2VkcvR3UxbnBxd2ZwcU84?=
 =?utf-8?B?SW9ncm1nNXNpMHAraW9pWWVVbGRiWHJuY0pNcjlZMUFTdzFqS1FlMEE5eDlx?=
 =?utf-8?B?L0JlRStWYlV0RisyZUdQZVIwSkw1ZFh5NlZpQ2VYbnYzMUVyTm1HMlgrRGlh?=
 =?utf-8?B?THM5azBrY3V2TWIwYTRrNHRPM1NzS1JpeXB6Y01ZT3VIN25iQT09?=
X-Forefront-Antispam-Report:
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(136003)(376002)(39860400002)(40470700004)(36840700001)(46966006)(336012)(186003)(956004)(16526019)(47076005)(2616005)(34070700002)(356005)(82740400003)(81166007)(44832011)(83380400001)(70206006)(70586007)(5660300002)(36860700001)(8936002)(8676002)(40480700001)(82310400005)(2906002)(478600001)(86362001)(53546011)(26005)(40460700003)(41300700001)(316002)(6706004)(16576012)(31686004)(82960400001)(36756003)(31696002)(110136005)(87944003)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 11:56:11.0288
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ffad6f3-dd52-4204-a39d-08da7eb52598
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HE1EUR01FT014.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB1931

On 15.08.22 13:27, Gunter Grau wrote:
> From: Gunter Grau <gunter.grau@philips.com>
> 
> There is the possibility that a new level triggered interrupt is
> already waiting when __ipipe_end_level_irq() is called.
> In this case at the moment when the irq is unmasked it may already
> fire and call __ipipe_ack_level_irq() before the masked state is
> cleared in the irq description. If this happens mask_irq() called by
> __ipipe_ack_level_irq() will not mask the interrupt and the system
> my stall.
> To prevent this, the masked state will now be cleared before unmasking
> the interrupt. A following direct interrupt handler call will then
> correctly mask the hardware interrupt as needed.
> 
> Signed-off-by: Gunter Grau <gunter.grau@philips.com>
> ---
>  kernel/irq/chip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index 6a883a4cee87..25d0942b592a 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -1048,8 +1048,8 @@ void __ipipe_ack_level_irq(struct irq_desc *desc)
>  
>  void __ipipe_end_level_irq(struct irq_desc *desc)
>  {
> -	desc->irq_data.chip->irq_unmask(&desc->irq_data);
>  	irq_state_clr_masked(desc);
> +	desc->irq_data.chip->irq_unmask(&desc->irq_data);
>  }
>  
>  void __ipipe_ack_fasteoi_irq(struct irq_desc *desc)

OK, but if we need this ordering here, why didn't we need it before for
unmask_irq()? There, it was sufficient so far to disable local irqs
around unmask + clr.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
