Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010013.outbound.protection.outlook.com [52.101.69.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6ED25FA29
	for <xenomai@lists.linux.dev>; Tue,  3 Feb 2026 22:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770156059; cv=fail; b=MHEieeTqUo8+eSQgpVHtSKumxd3mU6vfc5WHRfV2L9zee4EI7UE6yFQOvnBtPUJtvQDmEWjAkCtC/i0CwlwmwUrAObU+xVal165Wafu4PA+qhJ1W+j8bxLMVV85eGZDqtyWLpRu9S7J3vWmYMJPnDsxiFttjDUd1d07PDtP2kDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770156059; c=relaxed/simple;
	bh=Z/9ve02vBFFDZDaJMYT9V3dEH3kdG7CvcTwnzmPdpo8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fy1I4cGiO0xDlVJd2qZYPYHgF7XQQZblMMKeJEkuwisHJ8I3yER2K/7aQC3bBpiCfvmV3+I9slFERugf8RvtlmuyuMPsBb5UfknvUfuXPtDaCQ3uhDgtTHOHztq7Oh2XpY5VmgCv0afFm2hkPExXY/SPRf52QVMXL5pSmlwuC5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=k6DL7amh; arc=fail smtp.client-ip=52.101.69.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="k6DL7amh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mL4MkxTK8A/aRTbY6o7RcBpMB+CaIZWQguheG9cPppj9/2uDv4MDh7y3KlE1kDK4bTDV5/4pepv5nKF1oft0E+x4kP79dOKor42yRYThmXSxgkvEB1vZp/B1wZFskfz60QdsSQUPb5Fxb4xzusZpPiMkuv8xshetrWkpGgxQ0LJslnAam2YUnxqxa2AcghNGEMdWyHqkihf2pCOPm80V/zXvhWcpxbDW5QFWxF3FVx6jYs+BC9zzeeZjUIaPEwiyEgttJHpYeI2zTe9+DtMusL6H+QUr3QtecgwKXeMZJyJKeHdyDSrkmw3G1AUCWuk60+sm+8Ox44HeONbNa4mHpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/9ve02vBFFDZDaJMYT9V3dEH3kdG7CvcTwnzmPdpo8=;
 b=j5KGZTXEIAli+HvQHJjDxRaqO3zP11sdziuxGokwkTZt14TUp7ETgqaBN0s1v/I7H+35OvpO79j124L4g/FeAK5/r/1edNwWMaH/JvIR36DKV0wQl8QK0NJQjmzKyIg38I8h3D/lM+CaCzIRuu542bfDD4Uk4zzVLR1swOHLWYBKuTvwW2z0q8pbFy1ZSOhyJzlbb+mCpDDJwPR8oqYsKeg8KnldelT8QZVE9S/5UEkRStWQe0cZMow9CZ6kXCbz1iB9HkUyQbSV7erBgKMu+LR/L/HM3DQVdy9u6YQavRNjRVdNjigiYHpx8mIZ9cNp3u/fHTN9dLeZ4qjxZgFAIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/9ve02vBFFDZDaJMYT9V3dEH3kdG7CvcTwnzmPdpo8=;
 b=k6DL7amhcYx4THa4+UqCNT4J/8VLlT/cQxBY9qy5PgMq7C/1nQKKwS/MUvzfg+LCIeHi9bpbjJrXegsE+oq+kNY4qr9JRsj/gIGNCoKBSk4mlThaNvVHSJaI4LMmX/+t2OcGE61a5oa8Rkmh4yxFSyvJDAgV438dEvHh96dLR39Up41Jbpl4Or53sMM1TCkDHFrJi8CSuz2Mr3RdF1d6BE8CQ8pWgEtP8V85NgP1/NEBDtqaFs6hse9xeLvPkngIbk9pNoCIdsel1rR+FW6LK05Mqnzj3+8wQt/HzviCr+606tMHdCZkVmRmBxCM733TTFHYv7z35/oW6Q9SQR/K7A==
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by AS1PR10MB5578.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:476::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 22:00:55 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4072:14dc:7d1:74c7]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4072:14dc:7d1:74c7%6]) with mapi id 15.20.9587.010; Tue, 3 Feb 2026
 22:00:54 +0000
From: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
To: "rpm@xenomai.org" <rpm@xenomai.org>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: Re: [PATCH Dovetail 6.18 1/3] arm64: irq_pipeline: Fix mapping of
 SGI/LPI IPIs
Thread-Topic: [PATCH Dovetail 6.18 1/3] arm64: irq_pipeline: Fix mapping of
 SGI/LPI IPIs
Thread-Index: AQHclBlJM5evYY4YaUiPlXbXeNYk2rVw9CO1gAAmPgCAACDDvIAASlAAgAADewA=
Date: Tue, 3 Feb 2026 22:00:54 +0000
Message-ID: <776cf4d59124068e8d4ee1976fb3eb00f55c9b86.camel@siemens.com>
References: <20260201-wip-flo-fixes-for-6-18-v1-0-91ea07c7eb7e@siemens.com>
			<20260201-wip-flo-fixes-for-6-18-v1-1-91ea07c7eb7e@siemens.com>
			<87o6m6vutd.fsf@xenomai.org>
			<513ae7f9858f1bc553be3c6fcbbcabf1c89d6b25.camel@siemens.com>
		 <87qzr1ivxz.fsf@xenomai.org>
	 <198ace7718b548735ec0cb3e29b5c4f8129fbe9d.camel@siemens.com>
In-Reply-To: <198ace7718b548735ec0cb3e29b5c4f8129fbe9d.camel@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.2 (3.58.2-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB5712:EE_|AS1PR10MB5578:EE_
x-ms-office365-filtering-correlation-id: c2e8a907-4183-4be9-fbf5-08de636fb435
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bzVUTXU3dnh2aVhBMzFVWUh5aUtaTTdmNGVTV2lnbTNidHhmUUhyeEVKR29K?=
 =?utf-8?B?MVFxOHI2WFRIVTJsWFZLTUsvSEZLME5mczBCckkzaVp3ZGgwTE1RVVJQeW5k?=
 =?utf-8?B?enNhSDFUVXFadXFIbERtTDBhd3M5d0kxenI3YkRmT0xpM1JoLyt4Z0U5c3BH?=
 =?utf-8?B?czlTL1BvQmFUdzlpNGs1U3Q3dmtZYnlkOERGbWtyUmZUZm96S1MxQWZ3RHpw?=
 =?utf-8?B?WmZyNUo3MFVtSER6T3VvT1pGa1pwRmhsYk5objY3dHh0S2M4NXFUZ00zUEx2?=
 =?utf-8?B?ZERqbkxaVXR2RHlXT0x2aEF4R0YzaEh2V3ptL2ZEWHNQNEpRL2p5eVhmTWZm?=
 =?utf-8?B?b05NTzNpTHdqVkJ3M0V3NmRZNEJFcU1DTXZPQ1N5TVE5Q1AvS0tENjFIcEhz?=
 =?utf-8?B?Qkt5eWp1OE1LVExON2R4aFlTU3F1Y0M0L2U3OUlrVVAxcytsTnJUb3VCb2xP?=
 =?utf-8?B?c1phTWZ4Znl6NithdmVxY1RPYnlwKy9QakFGZVZwYlNuMm4zTmJDditmTWFO?=
 =?utf-8?B?dW1qRXNlU0dhQ0tObGRWNnlCcjFXeXhUcnNoTGlpb0R0T0VNUjY3SEMxV2lN?=
 =?utf-8?B?RVk5R3FTU3MrbkpPakpCSkhWcDZMVFJjR0xlcWhSQkVUWFdiMnFacGNWTk5Q?=
 =?utf-8?B?ZmRBdjVZUzE1UUdWRUpKeVlvckg5ajdTcUFTN3JnbWg2NXhLcG9ySnNWcGRx?=
 =?utf-8?B?cWdIVnV0bFU4QTFjRWNYTXVMaWZ2WjdGNXU5NDdBVEp3UE41OUJuT1puWDls?=
 =?utf-8?B?bTNTUVZkc1hxczBFSlAybkJnMjZWc1dtUjA2NUJrVUVzQjk4YnQwNFQrcVdi?=
 =?utf-8?B?M1d4eEU2M01laWd4T3kvc2FOZFRSTk9zeGhnZXZoUWJSOS9QNUNOUlFRSlI3?=
 =?utf-8?B?cVZURjZoTWwyTlVVOWxqN1RWcjYxeVg2bzVWSjlxR3NzU1puckRhdHZjbnVQ?=
 =?utf-8?B?U0xBbERwT1RuVXVGbk5yaEpPOVQzaGN3VW00RytDTDZkQ1hpR2M3NytoS3dZ?=
 =?utf-8?B?M3dRV0RXRFpnNXFjYy9GK3Z5Z1pyYml3OXJCVmhVZXdwc1kyNXZRa1EzaU5M?=
 =?utf-8?B?WEJEWDAyM0x5WXdUM0U3VFlESnlaUnE3ME44QnhjV0hzdzNNTmNMRjJuRXls?=
 =?utf-8?B?WTA3bldvYzVXcnNJM1RZTnY3dkljNVgvZkM1b0ZiZTd5NklpbUIveXZzdUNG?=
 =?utf-8?B?dEJ6dURmV0FuQjh1R05KaVc2M3MzZ01ZS0VkeXY4UkJnbCtwS1NKNlN1ZThG?=
 =?utf-8?B?clpHSHhheldmREYra2s3UGkrbUhNUEoyQ092bXJ2S2FFZVY0Y3lZM1FJS3ov?=
 =?utf-8?B?S3RHVGlSS0Y3RVU3aXMzMCt3NVJpYUgvS3l5VTI1RVZ3VmlhYlJtNG9WTzRP?=
 =?utf-8?B?QkdOYlFDVVlHQlBreCtKUWdLTEFhZkhyN215ZkpIODhIU2RLaFduK1VmUWth?=
 =?utf-8?B?NEJRTUcvWnNaWFd0Z2QvVTVnU2pZSGt4eHR4Z25aT1F1VXNtNTFXOU5hU3Ba?=
 =?utf-8?B?bGFKaGpIVXVCOXBuYTlJNldFaVFBblRkSG5tWHVxMTMzMHFCanowS2h5VUpP?=
 =?utf-8?B?WlhsbGJXSWNLQmhJTTJnY0dBeit3Tm56Y1o1NGdxQnpJejF3OEJwRTBVeTZG?=
 =?utf-8?B?ZkRJNzFiYVdiTDc5ZEdzditseWZYUS9maXFOZm9kTjNzK0xtOGlBWDF5MFFw?=
 =?utf-8?B?MWc1MFppbTJxRnoyVUJJV3RJdkN6L25zQmhlbVdmQnVPekZqUUp5WXpCWGcy?=
 =?utf-8?B?MWRvdkhoeUlhMWFIMWo4VW9ZL1hMTm5wYUV4Z3JCNFNOWHNQdS9SdVdXOHRW?=
 =?utf-8?B?aWViMjdZbkxiUmxsZVJiejBlTUxnK3cvNCtZbURLZkhGRDE5ZHg5QmV3bmxz?=
 =?utf-8?B?MGRrbjJKdUdjZWZEc2JHWExMNVdqSjdBdWc0UmZ0U3FvTDdSRVVkUWVDd3NB?=
 =?utf-8?B?OU1DbHZxekt2NjBNZzcxR0dTZ2Fta1l6eXVzOFV6U1I1bjRTWUEwWUxNQVNv?=
 =?utf-8?B?dFBHZTdGQjJGa2h5Q2tLN2J2cG0vY1dLUXpsb3dadGwzeVlRTVU3SlJDZDNE?=
 =?utf-8?B?YURCUGRiZXBRd2N2dTlDdnBtbkxJSjk1bkIxa2F4d2JQVlhPaVRiMHVUTUVI?=
 =?utf-8?B?cWFGZUg5eFZFbVVmNWR3MElwUEpHZUtMa3hqWCs0UjZYcnhXNlRCOUtRcFYy?=
 =?utf-8?Q?na9MzXOpj3XJjdkyEm/nikQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dkZGaGpXL3NrQ29hemljeHZTbGpYSWNJdW1GZ2tuR2YrRVBCaVRQSVlOdjhH?=
 =?utf-8?B?M2JObnhGUnZDVTErSUxkbWlNTXhsV1QxQVZ3UHRtR1h3RWhmdGkyZjdkb2dh?=
 =?utf-8?B?ditKY0FSSWpUak1CK3duR09EU3VnanJDa1VCdjR2VTg0aG50SGZGNDA1ZGUw?=
 =?utf-8?B?dVY2SjhaVjdYcW90WTE1R1VGMGt6UzM3TmQ0aExlQkJwWWZYR2JIWHBGNldJ?=
 =?utf-8?B?YTJiMnBTN1c2M3M2NUM1a3RLZ3pEVVlzYU1MaVNkcFN4MkoyMk9tV2c2czRD?=
 =?utf-8?B?RG4zQytQWnp5VWRtKytvenNWcWYvVEIvRlFnTHRZRmJWeXVXd253M0lCeGMy?=
 =?utf-8?B?UmdrcXRoRUMyYVJwUkh6TFFLSzhUV2JyVDRTWkNLUzVaU21wclFBWDQzNGcw?=
 =?utf-8?B?ZUVZeWpzYUZpeXZtb0xWQ1NSNVo1eDE2SjRDblZJcGozOWlhdDRzZHVibURz?=
 =?utf-8?B?K0lVY1J5Ny93SzZ1WFlVaVg1VVBGT0loMUt2MTFMZ1JDejFiZGZrcElTZXJi?=
 =?utf-8?B?NHRURTlzUFJTZWZhd0YrYjdpUElUQzY2QzhjR2pScUhGYzh0b0hiOS9Dd0xG?=
 =?utf-8?B?ZHA0MGFtYzhQeHpmekxqUEU2N1c0OWROeU0vMGUvNTlkQWJjUno5RmJrWmhY?=
 =?utf-8?B?aHFVUW5nQ0x2dFplUU56QnI5a3JaTmM3WWRTRlhlVG4zblNudnpnajhHYjIy?=
 =?utf-8?B?N25Ma1A4K2U2Vkg3ZlZlN1B2YjU1ZzdvU09SajZROVlJMTY5M3loOFpsZ1RT?=
 =?utf-8?B?WTQ3K3VENEJlYWtYeDA0ZlI1Q2taalZyZ2VFbEVkRkNNMEk1WDZmOHBNV2FZ?=
 =?utf-8?B?Q3RFYzFmWG5UWWVxdmQ4KytRL0xjeWRiaUVGbzltcmJkdVZCeTJkdXo2T3Rs?=
 =?utf-8?B?VC9ZRGxEYm9vbEZGYWVNaXgrYkVsZWpDMzJXcXFQOXRnNTVoLzk5TlFSZWJj?=
 =?utf-8?B?SzFSclhBTlkzVHFyOUFOSkZydVVPMHdiMG5yT3hWSVBsU2htakp5SDNEV0VF?=
 =?utf-8?B?T09FV0lPOVlUWXVNOUUya3N5QzB0Z1NObERyTE5Fd05NakZXV0NNOW1DaHFm?=
 =?utf-8?B?SWNxYjkvdWkyUTFjVWFlVjBtTGRyVk95UlE4Z0RJZm9ldnA5UmJqaWpqNWcw?=
 =?utf-8?B?cG04U2ZPeTk2ckxvQnNNZ2YzRmNkeThHRUtsT05kUnJ5K3d5b1RJODM5YzVK?=
 =?utf-8?B?KzUwWVRSci93NkU0MW80Y0xib2hVUmpmeGl5d0pYc1lVamN0NzJZWXZTZHlz?=
 =?utf-8?B?ZjZ1b09OK0lTbTZkL1YwUmZ6a1JtdEUwMjlBOHBKOVQ4ZWZxdDhoaUlsUHlX?=
 =?utf-8?B?d3BBWFNrV0FtMkFiZEpjV09MVEZyalJLRlJHTFFKU1pVanIxZWo2cTNvb3Vo?=
 =?utf-8?B?L0VCRGRORVg1OWp0YVFseWNOK3loUVJmcmFSQ0FSU3d5OXhaaDlmbGw3WGJR?=
 =?utf-8?B?bzRoR2EvK1dHUUxIMmt2TkZtU282b2hoMzl4Y2ZLYjhHVjVTR2F6WFBtcngw?=
 =?utf-8?B?MmhZVGQrY0g5WnozdEpEVEhKVWJjSHdiU1FRVEd0S2RKVDFjbWliSXZ4WUww?=
 =?utf-8?B?MEZ0aXgrZkxsL0hybkZBUmFTUXRSdVFFYmdicWxVYkZYZ28vUDhlVmliRXVW?=
 =?utf-8?B?M2UvRkc5RjNTclpHZDdMY3ZTSU45V0VNZ255YlNWM2pMTnlkRHNjWDhrTFZB?=
 =?utf-8?B?eEY3NmxXMkFTazdKVEQ3Rmw0K21iaUI3VjlLUzJ6VXJaelF0WXRzSWZhbW9F?=
 =?utf-8?B?Y2ZGeXdNWnovRHJaanBnWC9wRjRNSzU3U0ZXVmVISDkwQ2EzNktEU0dTdlRF?=
 =?utf-8?B?THM0ZEVJR0FsbEhLOCtkT2FNOTh5YWtRWStzcHExNnVFTHMrOERIaUNySkVi?=
 =?utf-8?B?cmEyS29kcW8zNlVMczNkc0xDemJMSWE0MUJIa05Wc0cybzVFdWg0OFhXek90?=
 =?utf-8?B?L1dCMWs4YllrdUFUNms3QzlOQW83RmJ2a1JFNmhqblZGS21IUGs5TTdBNFhh?=
 =?utf-8?B?VjNyQ3JBRTNSQUc5S1I2eXNWc2k4S2tmczZHRUpOMU9tYXp2YnZTRTlad3du?=
 =?utf-8?B?NkVoZkduWFhPb2FtWlNjM3lhOEZqRlBwa0pQV2FGOVZrZ1QveTY5aHFiZ3lP?=
 =?utf-8?B?S241cWVaK09tT0w0dTY1NEFldkFpUkgrNTRNZ2toMGRmZDVHWTdoU1Z0bEhD?=
 =?utf-8?B?c2wrRXBpVCtVN1hsSWRlV2lIcmhjWFpxTVRtZXNhanJlaWRDSHJoSFVVY0Zr?=
 =?utf-8?B?Q2ExcFBvOTg3NVpLVFlQazVudTQ3bXZYbnN4b3U2Y2JvWk9qRDBaZjBybS80?=
 =?utf-8?B?TGZkOWp2Z3pYckxEWDB4eFVPb1RXbDhvNCtRZkZPZ3I5T3ZvUWNBWGltaVJJ?=
 =?utf-8?Q?NQPnQvxtZbaVsf4BwItjqSIJvHMQW91gRJdWydpNyNjcc?=
x-ms-exchange-antispam-messagedata-1: +ibqrtw7yEYdXFME1N60GaQYGgHHhx7zfoE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2FA3A8796FEF641932245F87E174975@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e8a907-4183-4be9-fbf5-08de636fb435
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2026 22:00:54.9120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n9Y5VcKV1QG3HOjDELZoTPOABn30m1pvdI9SSMjuD6GDtuSQIafXi8mSVbrbRki0f78XpEyH6PjVHDBAXkgoguSYPAc6chpcIS1Ws4aIpyU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5578

T24gVHVlLCAyMDI2LTAyLTAzIGF0IDIyOjQ4ICswMTAwLCBGbG9yaWFuIEJlemRla2Egd3JvdGU6
DQo+IE9uIFR1ZSwgMjAyNi0wMi0wMyBhdCAxODoyMiArMDEwMCwgUGhpbGlwcGUgR2VydW0gd3Jv
dGU6DQo+ID4gRmxvcmlhbiBCZXpkZWthIDxmbG9yaWFuLmJlemRla2FAc2llbWVucy5jb20+IHdy
aXRlczoNCj4gPiANCj4gPiA+IE9uIFR1ZSwgMjAyNi0wMi0wMyBhdCAxNDowOCArMDEwMCwgUGhp
bGlwcGUgR2VydW0gd3JvdGU6DQo+ID4gPiA+IC1zdGF0aWMgaW5saW5lIHZvaWQgbWFwX29vYl9p
cGlzKGludCBjcHUpDQo+ID4gPiA+ICtzdGF0aWMgaW5saW5lIHZvaWQgbWFwX29vYl9pcGlzKGlu
dCBjcHUsIGludCBvZmZzZXQpDQo+ID4gPiA+ICB7DQo+ID4gPiA+ICAJaW50IGlwaTsNCj4gPiA+
ID4gIA0KPiA+ID4gPiAgCWZvciAoaXBpID0gT09CX0lQSV9PRkZTRVQ7IGlwaSA8IE9PQl9OUl9J
UEkgKyBPT0JfSVBJX09GRlNFVDsgaXBpKyspDQo+ID4gPiA+IC0JCWdldF9pcGlfZGVzYyhjcHUs
IGlwaSkgPSBpcnFfdG9fZGVzYyhpcGlfaXJxX2Jhc2UgKyBpcGkpOw0KPiA+ID4gPiArCQlnZXRf
aXBpX2Rlc2MoY3B1LCBpcGkpID0gaXJxX3RvX2Rlc2MoaXBpX2lycV9iYXNlICsgY3B1ICogb2Zm
c2V0ICsgaXBpKTsNCj4gPiA+ID4gIH0NCj4gPiA+IA0KPiA+ID4gSSdtIHN0aWxsIHF1aXRlIHN1
cmUgdGhhdCB0aGUgbG9vcCBpcyB3cm9uZyBhbmQgc2hvdWxkIGJlIA0KPiA+ID4gDQo+ID4gPiAr
c3RhdGljIGlubGluZSB2b2lkIG1hcF9vb2JfaXBpcyhpbnQgY3B1LCBpbnQgb2Zmc2V0KQ0KPiA+
ID4gIHsNCj4gPiA+ICAgICAgICAgaW50IGlwaTsNCj4gPiA+ICANCj4gPiA+IC0gICAgICAgZm9y
IChpcGkgPSBPT0JfSVBJX09GRlNFVDsgaXBpIDwgT09CX05SX0lQSSArIE9PQl9JUElfT0ZGU0VU
OyBpcGkrKykNCj4gPiA+IC0gICAgICAgICAgICAgICBnZXRfaXBpX2Rlc2MoY3B1LCBpcGkpID0g
aXJxX3RvX2Rlc2MoaXBpX2lycV9iYXNlICsgaXBpKTsNCj4gPiA+ICsgICAgICAgb2Zmc2V0ID0g
aXBpX2lycV9iYXNlICsgKGNwdSAqIG9mZnNldCk7DQo+ID4gPiArDQo+ID4gPiArICAgICAgIGZv
ciAoaXBpID0gT09CX0lQSV9PRkZTRVQ7IGlwaSA8IG5yX2lwaTsgaXBpKyspDQo+ID4gPiArICAg
ICAgICAgICAgICAgZ2V0X2lwaV9kZXNjKGNwdSwgaXBpKSA9IGlycV90b19kZXNjKG9mZnNldCAr
IGlwaSk7DQo+ID4gPiAgfQ0KPiA+ID4gDQo+ID4gDQo+ID4gRm9yIGlwaT1TR0ktMC03LCB0aGUg
dXBzdHJlYW0gaW1wbGVtZW50YXRpb24gb2YgaXBpX3NldHVwX2xwaSgpIGRvZXM6DQo+ID4gDQo+
ID4gICAgICAgICAgICAgICAgIGlycSA9IGlwaV9pcnFfYmFzZSArIChjcHUgKiBucl9pcGkpICsg
aXBpOw0KPiA+IAkJZ2V0X2lwaV9kZXNjKGNwdSwgaXBpKSA9IGlycV90b19kZXNjKGlycSk7DQo+
ID4gDQo+ID4gSW4gcGlwZWxpbmVkIG1vZGUsIHdlIG5lZWQgdG8gZG8gdGhhdCBmb3IgaXBpPVNH
STAgZm9yIGluLWJhbmQgSVBJcywNCj4gPiB0aGVuIGZvciBpcGk9U0dJMS0zIGZvciBvb2Igb25l
cyAoc2VlIGJlbG93KS4gQWxsIG1lbWJlcnMgb2YNCj4gPiBpcGlfbXNnX3R5cGUgYmVjb21lIF9s
b2dpY2FsXyBJUElzIG11bHRpcGxleGVkIG92ZXIgU0dJMC4gVGhhdCBpcyB0aGUNCj4gPiB3aG9s
ZSBwb2ludCBvZiB5b3VyIGZpeCByZWdhcmRpbmcgQ1BVX0JBQ0tUUkFDRSBhbmQgS0dEQl9ST1VO
RFVQLg0KPiA+IA0KPiA+IA0KPiA+ID4gaW5zdGVhZC4gKE5vdGUgT09CX05SX0lQSSArIE9PQl9J
UElfT0ZGU0VUIHZzLiBucl9pcGkpDQo+ID4gDQo+ID4gVGhlIGNvZGUgYWJvdmUgd291bGQgbWFw
IHRoZSBvcmlnaW5hbCBJUEkgcmFuZ2UgZnJvbSBTR0kwLTcsIHdoaWNoIHdlDQo+ID4gZG9uJ3Qg
aGF2ZSB0byBpbiBwaXBlbGluZWQgbW9kZSwgd2Ugb25seSB1c2UgU0dJMC0zIGhlcmUuDQo+ID4g
DQo+ID4gPiANCj4gPiA+IEV4YW1wbGU6DQo+ID4gPiANCj4gPiA+IHN0YXRpYyB2b2lkIGFybTY0
X3NlbmRfaXBpKGNvbnN0IGNwdW1hc2tfdCAqbWFzaywgdW5zaWduZWQgaW50IG5yKQ0KPiA+ID4g
ew0KPiA+ID4gCXVuc2lnbmVkIGludCBjcHU7DQo+ID4gPiANCj4gPiA+IAlpZiAoIXBlcmNwdV9p
cGlfZGVzY3MpDQo+ID4gPiAJCV9faXBpX3NlbmRfbWFzayhnZXRfaXBpX2Rlc2MoMCwgbnIpLCBt
YXNrKTsNCj4gPiA+IA0KPiA+ID4gSG93IHNob3VsZCB0aGF0IHdvcmsgZm9yIElQSV9JUlFfV09S
Sz8gSVBJX0lSUV9XT1JLIGlzIGxvY2F0ZWQgYmVoaW5kDQo+ID4gPiB0aGUgSVBJcyB1c2VkIGZv
ciBPT0IgYW5kIGdldF9pcGlfZGVzYygwLCBJUElfSVJRX1dPUkspIHdvdWxkIHJldHVybg0KPiA+
ID4gTlVMTCBhcyB3ZSBza2lwcGVkIHRoZSBtYXBwaW5nIGluIG1hcF9vb2JfaXBpcygpLg0KPiA+
ID4gDQo+ID4gDQo+ID4gQW55IElQSSBmcm9tIElQSV9SRVNDSEVEVUxFIHRvIElQSV9JUlFfV09S
SyBhcmUgbXVsdGlwbGV4ZWQgb3ZlciBTR0kwIGJ5DQo+ID4gc21wX2Nyb3NzX2NhbGwoKS7CoA0K
PiA+IA0KPiANCj4gSGVyZSB3ZSBnby4gSSBtaXNzZWQgdGhhdCBzbXBfY3Jvc3NfY2FsbCgpIGNh
bGxzIF9fc21wX2Nyb3NzX2NhbGwoKSB3aXRoDQo+IGlwaW5yIHNldCB0byAwLCB1bmNvbmRpdGlv
bmFsbHksIG5vdCBmb3J3YXJkaW5nIGlwaW5yLiBJIHNpbXBseQ0KPiBvdmVybG9va2VkIHRoYXQu
IFRoYXQgYWxsb3dzIHVzIHRvIG9ubHkgbWFwIHRoZSBvb2IgSVBJcyBhcyB0aGUgIndyb25nIg0K
PiBtYXBwaW5nIGluIGFybTY0X3NlbmRfaXBpKCkgY2FuIG5vdCBoYXBwZW4gYW55bW9yZS4gU29y
cnkgZm9yIHRoZQ0KPiBjb25mdXNpb24uDQoNClRoYXQgZGlkbid0IGxhc3QgbG9uZy4gVHdvIHdh
eXMgdG8gZml4IHRoZSBwcm9ibGVtIGF0IHRoZSBlbmQ6DQoNCiAgLSBPbmx5IG1hcCBPT0IgSVBJ
cyBhcyBzdWdnZXN0ZWQgYnkgUGhpbGlwcGUuDQogICAgTWVhbnMgd2UgaGF2ZSB0byBtb2RpZnkg
YXJtNjRfYmFja3RyYWNlX2lwaSgpIGFuZA0KICAgIGtnZGJfcm91bmR1cF9jcHVzKCkgZm9yIHRo
ZSBkb3ZldGFpbGluZyBjYXNlLg0KICAgIENhbGxpbmcgYXJtNjRfc2VuZF9pcGkoKSB3aXRoIGFu
IGlwaS1uciAhPSAwIGlzIG5vdCBhbGxvd2VkIGluIHRoZQ0KICAgIGRvdmV0YWlsaW5nIGNhc2Ug
Zm9yIGluYmFuZCBJUElzLg0KDQogIC0gTWFwIGFsbCBJUlFzIGFzIHN1Z2dlc3RlZCBieSBtZS4N
Cg0KSG9wZWZ1bGx5IGNvcnJlY3Qgbm93Li4uDQoNCldoaWNoIHdheSBpcyB0aGUgcHJlZmVycmVk
IG9uZT8NCg0KPiANCj4gSSB3aWxsIHNlbmQgb3V0IHYyIHRvbW9ycm93IGFmdGVyIHNvbWUgbW9y
ZSB0ZXN0aW5nLg0KPiANCj4gPiBJUElfQ1BVX0JBQ0tUUkFDRSBhbmQgSVBJX0tHREJfUk9VTkRV
UCBzaG91bGQgYmUgYXMNCj4gPiB3ZWxsLCBidXQgdW5mb3J0dW5hdGVseSBieXBhc3NlZCB0aGF0
IHJvdXRpbmUgdG8gY2FsbCBpbnRvDQo+ID4gYXJtNjRfc2VuZF9pcGkoKSBkaXJlY3RseSwgd2hp
Y2ggaXMgaW52YWxpZC4gU28sIGlmIGFsbCBjYWxsIHNpdGVzIHdoaWNoDQo+ID4gd2FudCB0byBz
ZW5kIGFuIGluLWJhbmQgSVBJIGRvIHRoaXMgcmVtYXBwaW5nIHNvIHRoYXQgYXJtNjRfc2VuZF9p
cGkoKQ0KPiA+IGlzIGFsd2F5cyBjYWxsZWQgd2l0aCBpcGk9U0dJMCBmb3IgdGhlbSwgd2UgYXJl
IG9rLg0KPiA+IA0KPiA+IElPVywgYXJtNjRfc2VuZF9pcGkoKSBjYW4gb25seSBiZSBjYWxsZWQg
Zm9yIFNHSTAtMywgaS5lLiBvbmUgaW4tYmFuZA0KPiA+IGNoYW5uZWwgb3ZlciB3aGljaCBhbGwg
dXBzdHJlYW0gSVBJcyBhcmUgbXVsdGlwbGV4ZWQsIHRocmVlIG9vYiBJUElzIHRoZQ0KPiA+IHJl
YWwtdGltZSBjb3JlIG1heSB1c2UgYXMgaXQgc2VlcyBmaXQuDQo+ID4gDQo+ID4gSSBzaG91bGQg
aGF2ZSBhbiBIaWtleSBMZW1ha2VyIHNvbWV3aGVyZSBpbiBteSBkcmF3ZXJzIHRvIGJlIGV4Y2F2
YXRlZA0KPiA+IHRoYXQgSSBjYW4gcmVjb25uZWN0IHRvIG15IGxhYi4gSXMgaXQgdGhlIGhhcmR3
YXJlIHdoaWNoIHNob3dzIHRoZSBpc3N1ZQ0KPiA+IGluIGxwaSBtb2RlLCBvciBpcyBpdCBhIDk2
MD8NCj4gDQo+IEkgY2FuIG9ubHkgdGVzdCB0aGUgU0dJIG1vZGUgaGVyZS4gRXZlcnl0aGluZyBl
bHNlIGNhbWUgdXAgd2hpbGUNCj4gaW5zcGVjdGluZyB0aGUgY29kZS4NCg==
