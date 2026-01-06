Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011070.outbound.protection.outlook.com [52.101.65.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E45A35972
	for <xenomai@lists.linux.dev>; Tue,  6 Jan 2026 08:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767686581; cv=fail; b=rpSdFm4obQMmi4QQpJ19NA0xQxyukjtepKK0Gs1MU0lZrq6S1hzK4H9RVUOrMHXc2TKR/6BS6OUDajlfqOuSa1u/s+S7zMp2Cr9qBV7lXJVnjuypaLNaMxCVJ7efyxFAivC8WLNE7iyiXLXqx8ll9uM30HqLME4hcMbBpsDHgcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767686581; c=relaxed/simple;
	bh=7YtiOJaQXRUUa90Ypq+zYIzhCNDQETYgjDx2A87CBLY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EoWjtxYQXJfuWAftdqaKokodVXVrtU7L0slZllof50BCB09fLbVfw5luSx+fJTGFv/sGA1fHR/K7JP17iWf/225um3DNfH+Vj1QZoGTzcVTVIOuKgN5LwHR5hVoevlk5Z6kZuCGOh2YwNEC8GZZWMDz4AUn3au/6kchSBjKpT4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=MYCVIVV/; arc=fail smtp.client-ip=52.101.65.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="MYCVIVV/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/88l7moA8peQSxr7e6z9CwjiwPsap0OhAUDo2pVgaMWdMI2J+OstFx1gRR4NNq8KyEvl3JdMYazjSccgovSGmet6KYu/b5gokqO8tUihNs0AsjhMZsQQzXoRlIc5lVlWh6quDnBVfo+mTs1SU5uJzbwDHQljCt9SJnF3gwibAp9XcIf8lUg4uD1zQ86+xNd5ZEAxhBjG34H5siOIKXdHcdKgq7Yb14HBSxFt2bDwGlVMvZ7gH/xhXRmljN/Ma+jDLVwN2B1RUlAwRBEe+SPatEowEw9a6NF/+adTTP9qvPAxFSWbzwcei66JqB0Sa3rcyC8R9AkoWl8mjcDip0h2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7YtiOJaQXRUUa90Ypq+zYIzhCNDQETYgjDx2A87CBLY=;
 b=xOlXeEww1zY7zZaGBB/6fjUYr1oqMSaq7IUbh+NMPKkkwQ7Z3lOuxTTlDyQwY1m4G8uyfVUJJ8vH/gFF3WwDHWXPLuVS6hsosZH0mzas5euUdhzELKer/XWqF5fTr/DFMWxeiiSxQFT7g5jKpwrzy894dz9BNQzNI1W4HHyc74n+AbPtwvuBHY+ak31+noxr377C/urlFNs8YZIFtaMbNikeUlguvGlW0OVS5oWLq05yB5k1IOk8Yup7clKezCCPut6EVOpT4NjWi698CmQ6v5lS+pDOowI8UelvnEMiG9tYcBEJT2SAJmbPeNb8/2yTo33SJlxyQ/6OnvjgV3KoFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YtiOJaQXRUUa90Ypq+zYIzhCNDQETYgjDx2A87CBLY=;
 b=MYCVIVV/HCs2GlNeHSaW1pEDyBSYQ/6L5e9sxd0/74bEzHKKnQosQQepnFCRAriF2isn+E4LRphrY9UrIgxp9OBas/rwUdIefvmCd2pna/VZUb0U/k9d9djSAdn8HxXEUZBAqJeu10fzUsnTI/Mv/WrEWHLH9Lu0vzWNKpRplHDz7V0oIkhSQVrHU4daO/NYfYIrQSXxcZjxFJ68PyEfvC73nBo1btp0Nrq+aXZFK42ETf9ht3/6/jHMquvUhcIB0Gv0lCLRcyTKFqAn21E27vhVNYPVEomUFco5QMoRtkbHHfBYc0KFfBtpjPc+1iFS8WkFqy3D7S7YDozkFjCMhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6074.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 08:02:52 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 08:02:52 +0000
Message-ID: <344b0097-efa8-4316-9cef-96b3b93455c7@siemens.com>
Date: Tue, 6 Jan 2026 09:02:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: System crash: Interaction between KVM (Intel) and Dovetail when
 sharing CPU cores
To: =?UTF-8?B?5YiY5p2o?= <liuyang@sinsegye.com.cn>,
 xenomai <xenomai@lists.linux.dev>
Cc: =?UTF-8?B?6YOt5Y+M5ou0?= <guoshuangshuan@sinsegye.com.cn>,
 =?UTF-8?B?5a6L5YGl546u?= <songjianwei@sinsegye.com.cn>
References: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.4e05857e.625a.49c0.b295.72fa87a282f1@feishu.cn>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.4e05857e.625a.49c0.b295.72fa87a282f1@feishu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0031.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6074:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cd601ff-4ce0-45b7-ff84-08de4cf9fdfb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXd1VFZLOXJXUUVPd2NjZVpJMlBWR1dHdS8vZThMalMxekNLUHVJMTNvYmtG?=
 =?utf-8?B?eVRaTVlDVkJMc1NsYkFMa3U4bzkzMUJlQjBENEhQcEVsVjRtUjhJOHZYNUpa?=
 =?utf-8?B?U2o0eW5zdSs2R3VsZGhrOFBwck4wTldCVDlnSENXZXVmZDNhUzIyL2FVQ3ht?=
 =?utf-8?B?QkdUaVZ5Zkp0MDBLSEpXdm1DL3prK0pmRHZyTE13Mm53UjhwNUo0dkVLY0sv?=
 =?utf-8?B?V29adnlidXlHV0pwSjFWdTd6dC9GSzdGNFR4NnZHUnNKalp6M2VjbElCdkds?=
 =?utf-8?B?dzFrNk8vSTJadk5OUzVaSlZaYS9WcnhEdGlLVnlHak1NT28relJGRzZZOWxL?=
 =?utf-8?B?QXJjanhjNVdKTkQ5RFQwSjBhOUIrUkRLa3NLMlVSMUpnREVKQzdVOHZnSjFk?=
 =?utf-8?B?Zm03ZU1PQnhCbGd3YkFxQ1ZVN3VxQ0EvSHpKQWhtMW4vZFhmTzB0NkVwLzl6?=
 =?utf-8?B?Qm9DWmtUYlhoaVEybVU2ZCs3V3pQUEZUZk9tVitmSTBnL3hTbzZ3azBQaDBY?=
 =?utf-8?B?V2lXNDFSMEtiSU1zWkdYSGtCdGVqVkltWDlIN0Q0M1p4YXVqY1lEcVZGV0lO?=
 =?utf-8?B?OCtueWdOU1BUcnUxWVhEZGROVDhGSDJBTXQ4cU5uK2c3RVRwd0hELzVCMDVM?=
 =?utf-8?B?alUrYkN6ZmE3TVRubTRoSU1CSUVHVWdkZ1o2RGNOZ1VLb1g2Snc4cHZzUnVN?=
 =?utf-8?B?QzJDSjFTdEZ0UThUWWU1VjJYcXp3Z0k1UHVMamxEWUdUb09QSDBub3VtV29G?=
 =?utf-8?B?R0JvVklKYjRmZ2dqRkxXaXphUDVTcm9jZ1dMVzVhM2ZBNWlSWWpXZ25Udkt3?=
 =?utf-8?B?ZmFlT0xoSXlqbWVlS0V0SzdYR1BUQkkyT3F3cTl5d0hucVdLOUZ6M2wvUThS?=
 =?utf-8?B?WWhPVHRNaWhDOWZPMG9nZklSaXlNZ3gvWjBabGhtc0wyV25pb0hUd3lORWVT?=
 =?utf-8?B?UVpNbWxkSys5TXRpVDdxcS9JVW9lSm9HODdzRjllRkhyWlY2MjVxa1pnVzV2?=
 =?utf-8?B?cG5qMGE0YkZmWWcweTVwMEJ3OUZkekhxbFYrc3ZhREF1ZEVVSnlTaHVMbDNw?=
 =?utf-8?B?cGZ5aU44QkNuUnk4YjVMK3hEQ3BVY2JRbVBkeUFWaGlNZVJtd1IrZzI1TVBH?=
 =?utf-8?B?dXhiYnNLOWRTdXBwYmFTd3ltQVdtOEFTUlF3cWI1WkNHdDI1Kzl5cllXT0dT?=
 =?utf-8?B?S1NzZGY3YlNLWmhoaDRpL2d4NjBRbkE5ZlB1YUw4Rkkrdzg1Wkx5QzJmWEV0?=
 =?utf-8?B?dEwvN0U1RVRqdytmRVZlKzlTbWEvY1NQS0RHYnNTbklYTzg1dktqU055MDR5?=
 =?utf-8?B?N0gxUUljZW9PblJGaDVVODNDaE5GUWd1OHNGWjRsYWV0K1hmMGg5aW9JdTNR?=
 =?utf-8?B?T25jLzd4ei9zUXNJemEvOWpPMDc1RGdXOVVHbGMyZmhxUHBSdVg4UFdSM2FK?=
 =?utf-8?B?Z0pvTnl3aU9jTklYYm5QT0FuNmdoZTZJa2hOZW5VaXdjUEJ1bWVxaHRhOER3?=
 =?utf-8?B?Zi8zL1VJRTdzWXZyRTBSSVBkL3dWVlBUem9wMWQva0ZhK0JiamVXNGpxc3dQ?=
 =?utf-8?B?allnYUJaWHo4Y2xBRDlkUGN1a2VFYUFnRmtwY21uSy9scXVMeGVMTVJGSFRC?=
 =?utf-8?B?UitmRkhDVzA0M1RJSWNneEJKbTEyd2w4WkNuSXhUM0Z6dzdtY2hIQ0VDbmpY?=
 =?utf-8?B?ZUdGTExTZ1EwZmlzQWdITXFjRVRrQnNhM0h3Z0ZxaWRlMW5lWitrY3NqQ1BU?=
 =?utf-8?B?NkY5NTA0MFQrTlZaQ3JCOGhaOVdzS0VIN3Vuc1dQUFovcXVXRWRVWitoR3lS?=
 =?utf-8?B?T1owdGk5aVNSbEVlQUgzaFJzMGIzVTdBVjR5Wm9wTUVDby9WNGp6RS95QmRW?=
 =?utf-8?B?dnFSWHJ3eHlwZmlPQWhOU3kxaHJmSjV5VFMzNHFCeHJJL2ZqNWVvQlYvcHJQ?=
 =?utf-8?B?TzhsUFJHZ05TbFZBazVnRFVDWm5YMUdzaGd3MEtPWXVHVkdUcEZqcWJvWXd1?=
 =?utf-8?B?YjEzdEtoTGNBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUlmNm5YTVROZHlsRnBQblhpeG1rck5PaFNJaDlKVHFSeUNqb3VQczd2Vzky?=
 =?utf-8?B?WDAwOWxnRC9kZjVQY1A0aVpYMklvSHVHNUlLclNzT0JNMFlDTWhTMEl1ZUl5?=
 =?utf-8?B?dlB1Zk9NMHJ2VW8zU3lQZ2dXbnBoRzRIYXZYTlR4UnY1eGdRTUdjcWZSUVZn?=
 =?utf-8?B?bmJlZFZxbnlOMVM2Z0NkVG5vYnh1NnE1emJLWGI0UWZ5U3BmU3ozbDhSL1VI?=
 =?utf-8?B?YUZOK09pWHZhbE5hQ3hiK01CMGpUa0I5U3BqM1FhSmIwUS9aYWFsdnhTY01w?=
 =?utf-8?B?bXA3cDJzYVJ4ODNLOFJ3TklUQ3hTdmhCVEIyOTZDZ0VWcnlBckhjbmFHREEz?=
 =?utf-8?B?Q28zNEdzQzFGUDNIWTdDMC95T0FoOFBCdVdnbHIyN0UrWm1hZmtGbS8yZ2tz?=
 =?utf-8?B?OTNTWlNmS0l1U25PSE1RUS92UVdFdnEvS2lGUjZDM096aEU4eFg1UzZ5SVAz?=
 =?utf-8?B?bW5qREgyQVNTSGJ2VFVxSkJCNVk5QVRqVUUwckcwRFZkRFh5cXhTSEJLVmQr?=
 =?utf-8?B?NU9wdTR6UkgwNnFJbk5pWjcwT0dXeXFCUjVXeGNWdWtWQjNXTTdBM05PYm0r?=
 =?utf-8?B?amN1eU41azlNTkYrY01qTWlGTnRmUEhacVJuWjlicG5vRm1hL1Z2Z3R2T0ts?=
 =?utf-8?B?Z1F4bGcwTUFTYTM2MXFEODdUdTFuRFVBZU1vUi9GK2IvdzJUOHNrNlc3Q1li?=
 =?utf-8?B?SDZiRHJ1SWZjblVYZEF3NFlQVWJuZnl0d2F5Yk4va0dISW5GNnY4eUt1c0xT?=
 =?utf-8?B?dEhaWk9vK1hOYUJOL3o2aXR1YlFlYm11VkhUL3oxbDdMQklzUGpIQ3gxZXRk?=
 =?utf-8?B?RHVORWg3d0t3QjA4VTB5YzZtM0FVRW1mVlVnWjc1a0RzdzZuaTlUV3JZZmRL?=
 =?utf-8?B?SlljUEQyYUtacFNBR1h4dHNtd3FlVTFTMXZvTmpyODZkUTFKenZnZU4yM01p?=
 =?utf-8?B?Mm5rTVBaYzY5U3doV0NXTDFGWVYyVDdZTW82TkNMNzVKTVpMdDc2QnMzR0gv?=
 =?utf-8?B?N0NNdGJWZFVsd0tJQjVjQ1d2SHA0ZGlWT0VaN1NPQ1NIaEIwSXdrQWd2b2d6?=
 =?utf-8?B?WEVzN2JvS0NoTmwrTEtLaEk4SzMzQ1ppTm1sQkFpSmxtMFdaOG1WanRRQkFr?=
 =?utf-8?B?eTU3aVB4djBZZmxVL1k3TGRiQ0dUSHo2cjJkNjIzM2txalIxcVpZc1RPN0pK?=
 =?utf-8?B?NFd4MWlSc3lUY0tlRmhvemtVYnVjaC9uSnBkb0Y3bHN5c1VCTGlMUHVQNW9m?=
 =?utf-8?B?eSs0Sk5GVzFEbXBEbVI0Vm9IaVRHQkc5RlZ2cHdhbVdmMG1DZk44UStTZzlF?=
 =?utf-8?B?ZHNlWXhqNDRCalZJOElXR21hNnBianhPOFJ3NUsybm5pK0szWjV6dmFxM0NW?=
 =?utf-8?B?SFh6clp0eENUK0o1aERaLzI0cjBqQ0IxRVR1c0RpS1NDN2lBajR6YWZka0F4?=
 =?utf-8?B?S0wwcUp5Vm1XT2VBWGRQM1crVTZaK21TWURYamlMSUFmQUFaMytRbEZqb2Rv?=
 =?utf-8?B?MFJXUjU5NmQyTUorM2JQL3Ftc0tFNy9NWkZWUEErRWxwNzBQZldZU0dNcHdF?=
 =?utf-8?B?Zm4rM0J6SU84OXEycnVXN2M5ZFNzbERrazQ4ODRuaVpHTUlZdVBwTkMxbHJz?=
 =?utf-8?B?VnNiZVlLdFMrQ2ZwZUYwUW1JbFIrd1Q1NXJxMzFtUDZMSjNVN0lqY1NEZXZr?=
 =?utf-8?B?YTJ4dFVmd1JQY1podWM1RWJFcFhiK1A1ZWJLT3V4TkhRRXJTcW1pVFdqT0Fn?=
 =?utf-8?B?V285RHhyNGVSSzVRVzNlN2psZnZqMEx4K3VHZ1FwUUdYVlE5cHpiUXc5MGJk?=
 =?utf-8?B?aU4yT3FybEllL2NKbU1scVY2NGNPbVZQVFlMbzNsU01jSjI5WmRRZnNiVWdM?=
 =?utf-8?B?S0dTOTV4WTZWa1c4a1NPMHZiaXViODZlNTNiTVRZTHJDWkEzSFhVK3B5ekx3?=
 =?utf-8?B?YUI1Q09EbUVKSm5SbVpnbThXaHdOME82ZlJjeXRSbGt5T1VpTkZqck5aTkcv?=
 =?utf-8?B?V3VJbklSQm5qWTY2Nk5tdG5FK3gyczlOYUp2Z0NsWkZtdElkTUxyc0RneG5O?=
 =?utf-8?B?dzkyQ2dzNUJVM3B6bVc2ejVVRmI3S1JXSjhNQVNaOFF0VlVRbmdiVUg5SWxi?=
 =?utf-8?B?bHBxZVR3U2dkcTFLMFovL1hsWU1EcElEU051amFUQ0s3RUVTSHFWcXFxallM?=
 =?utf-8?B?SWNURSs1MkNNcmRzSnhFdnZ6bHBIc1RNVDdnL1QwWmlNazNEOHQ3SXQxVWw5?=
 =?utf-8?B?Um9seGd6WkNNYXNCbU1VUnZKa1RpOVF2NDBqeERWNWI5MVF0ZFliTFk4Mzhi?=
 =?utf-8?B?cDZyUlhmNXJrMjMwUnlvbnd0OWo2eVNqU2NHeDE4czgvZmNHakFJUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cd601ff-4ce0-45b7-ff84-08de4cf9fdfb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 08:02:52.6479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eYPJC/r/NCG7Z84utaAQU7H6R6MiVWEdaTmb4kBEHDXR8PhBM3A3ss4qeyfwbbw7mHir1/1CS6LN3/5Ehmq72w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6074

On 06.01.26 04:21, =E5=88=98=E6=9D=A8 wrote:
> Hi developers,
> I am encountering a system hang issue when running Xenomai 3.3.1 with Ker=
nel 6.12.55 on an Intel platform.=C2=A0 (alse test with linux 5.15.51 + cob=
alt 3.2.3)

So, the issue happens with both 5.15 and 6.12, or only with 6.12?

> Issue Summary:=C2=A0The system works fine if I use isolcpus to separate K=
VM VCPUs and Xenomai applications. However, if they share the same CPU (wit=
hout isolation),=C2=A0
> the entire host hangs at the moment the VM starts loading the OS (right a=
fter OVMF finishes).
> Hardware/Software:
> =E2=80=A2 CPU: Intel (VMX enabled)
> =E2=80=A2 Kernel: 6.12.55 + Dovetail
> =E2=80=A2 QEMU/KVM: CPU Host-Passthrough
> This issue only occurs on Intel. I performed the same tests on an AMD pla=
tform (SVM), and it works perfectly without any hangs.
> By setting kvm-intel.preemption_timer=3D0, I can occasionally avoid the i=
mmediate hang and capture some error logs (see attached).
> #########################################################################=
#########################
> [=C2=A0 181.519260] Oops: double fault: 0000 [#1] PREEMPT SMP NOPTI IRQ_P=
IPELINE
> [=C2=A0 181.519265] CPU: 0 UID: 0 PID: 4405 Comm: Schedule Not tainted 6.=
12.55-rkernel-s1.7 #metaOS
> [=C2=A0 181.519268] Hardware name: Sinsegye SP7022-7231/SP7022-7231, BIOS=
 SP70220720250618B 02/10/2025
> [=C2=A0 181.519269] IRQ stage: Xenomai
> [=C2=A0 181.519270] RIP: 0000:0x0
> [=C2=A0 181.519279] ------------[ cut here ]------------
> [=C2=A0 181.519280] kernel BUG at arch/x86/kernel/traps.c:1055!
> [=C2=A0 181.521244] Oops: invalid opcode: 0000 [#2] PREEMPT SMP NOPTI IRQ=
_PIPELINE
> [=C2=A0 181.521249] CPU: 0 UID: 0 PID: 4405 Comm: Schedule Not tainted 6.=
12.55-rkernel-s1.7 #metaOS
> [=C2=A0 181.521252] Hardware name: Sinsegye SP7022-7231/SP7022-7231, BIOS=
 SP70220720250618B 02/10/2025
> [=C2=A0 181.521253] IRQ stage: Linux
> [=C2=A0 181.521254] RIP: 0010:fixup_bad_iret+0xb3/0xc0
> [=C2=A0 181.521260] Code: f6 43 e0 03 74 24 48 8b 4d e0 65 48 33 0c 25 28=
 00 00 00 4c 89 e8 75 14 48 81 c4 b0 00 00 00 5b 41 5c 41 5d 5d c3 cc cc cc=
 cc <0f> 0b e8 b6 34 00 00 66 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90
> [=C2=A0 181.521262] RSP: 0008:fffffe1e46ae5ba8 EFLAGS: 00010046
> [=C2=A0 181.521266] RAX: fffffe1e46addf58 RBX: fffffe1e46ade000 RCX: 0000=
000000000000
> [=C2=A0 181.521267] RDX: 00000000000000a8 RSI: fffffe1e46ae5c50 RDI: ffff=
fe1e46ade000
> [=C2=A0 181.521268] RBP: fffffe1e46ae5c70 R08: 0000000000000000 R09: 0000=
000000000000
> [=C2=A0 181.521270] R10: 0000000000000000 R11: 0000000000000000 R12: ffff=
fe1e46ae5c88
> [=C2=A0 181.521271] R13: fffffe1e46addf58 R14: 0000000000000000 R15: 0000=
000000000000
> [=C2=A0 181.521272] FS:=C2=A0 00007f13a1c59640(0000) GS:ffff8baf2ec00000(=
0000) knlGS:ffff8baf2ec00000
> [=C2=A0 181.521273] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
> [=C2=A0 181.521274] CR2: ffffffffffffffd6 CR3: 000000011decc004 CR4: 0000=
000000f72ef0
> [=C2=A0 181.521275] PKRU: 55555554
> [=C2=A0 181.521276] Call Trace:
> [=C2=A0 181.521278]=C2=A0 <#DF>
> [=C2=A0 181.521282]=C2=A0 ? copy_from_kernel_nofault+0x74/0x110
> [=C2=A0 181.521288]=C2=A0 error_entry+0x138/0x140
> [=C2=A0 181.521291] RIP: 0010:native_irq_return_iret+0x0/0x2
> [=C2=A0 181.521294] Code: df 58 5f e9 6e ff ff ff 41 5f 41 5e 41 5d 41 5c=
 5d 5b 41 5b 41 5a 41 59 41 58 58 59 5a 5e 5f 48 83 c4 08 f6 44 24 20 04 75=
 02 <48> cf 57 0f 01 f8 eb 12 0f 20 df 48 0f ba ef 3f 48 81 e7 ff e7 ff
> [=C2=A0 181.521295] RSP: 0008:fffffe1e46ae5d38 EFLAGS: 00010046 ORIG_RAX:=
 0000000000000008
> [=C2=A0 181.521296] RAX: 0000000000000000 RBX: ffffffffffffffd6 RCX: ffff=
fffffffffff2
> [=C2=A0 181.521297] RDX: fffffe1e46ae5dc8 RSI: 0000000000000000 RDI: ffff=
fe1e46ae5d88
> [=C2=A0 181.521298] RBP: fffffe1e46ae5d78 R08: fffffe1e46ae5dc8 R09: ffff=
8babd1b44d40
> [=C2=A0 181.521298] R10: 0000000000000001 R11: fffffe1e46ae5b00 R12: ffff=
fe1e46ae5d88
> [=C2=A0 181.521299] R13: 0000000000000040 R14: fffffe1e46ae5f58 R15: 0000=
000000000000
> [=C2=A0 181.521300]=C2=A0 ? asm_exc_general_protection+0xd/0x30
> [=C2=A0 181.521303]=C2=A0 ? copy_from_kernel_nofault+0x74/0x110
> [=C2=A0 181.521306]=C2=A0 show_opcodes+0xd4/0xe0
> [=C2=A0 181.521309]=C2=A0 ? _printk+0x5c/0x80
> [=C2=A0 181.521312]=C2=A0 ? vprintk_deferred+0x21/0x30
> [=C2=A0 181.521314]=C2=A0 show_ip+0x3b/0x50
> [=C2=A0 181.521316]=C2=A0 show_iret_regs+0x1b/0x50
> [=C2=A0 181.521319]=C2=A0 __show_regs+0x2b/0x340
> [=C2=A0 181.521321]=C2=A0 ? dump_stack_print_info+0xfc/0x150
> [=C2=A0 181.521323]=C2=A0 show_regs+0x3c/0x70
> [=C2=A0 181.521325]=C2=A0 __die_body+0x23/0x70
> [=C2=A0 181.521328]=C2=A0 die+0x41/0x70
> [=C2=A0 181.521330]=C2=A0 exc_double_fault+0xc7/0x180
> [=C2=A0 181.521333]=C2=A0 asm_exc_double_fault+0x23/0x30
> [=C2=A0 181.521335] RIP: 0000:0x0
> [=C2=A0 181.521337] Code: Unable to access opcode bytes at 0xffffffffffff=
ffd6.
> [=C2=A0 181.521338] RSP: 0008:00007f13a1c58bd0 EFLAGS: 00010202
> [=C2=A0 181.521340] RAX: 0000000010000019 RBX: 0000000000000001 RCX: 0000=
7f13cf09a2dc
> [=C2=A0 181.521341] RDX: 00007f13901de790 RSI: 0000000000000001 RDI: 0000=
000000000001
> [=C2=A0 181.521342] RBP: 0000000000000001 R08: 000d2714bb43ad11 R09: 0000=
7f13cf0b8080
> [=C2=A0 181.521343] R10: 0000000000000000 R11: 0000000000000202 R12: 0000=
7f13901de790
> [=C2=A0 181.521344] R13: 0000000000000000 R14: 0000000000000000 R15: 0000=
7f13cc1845c8
> [=C2=A0 181.521346]=C2=A0 </#DF>
> [=C2=A0 181.521346] Modules linked in: vhost_net vhost vhost_iotlb tap ca=
n_raw can xt_CHECKSUM ipt_REJECT nf_reject_ipv4 xt_tcpudp nft_compat nft_ch=
ain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetli=
nk bridge stp llc binfmt_misc nls_iso8859_1 intel_rapl_msr intel_rapl_commo=
n intel_uncore_frequency intel_uncore_frequency_common x86_pkg_temp_thermal=
 coretemp mei_hdcp kvm_intel kvm iTCO_wdt rapl intel_cstate rt_igb intel_pm=
c_bxt mei_me serio_raw wmi_bmof iTCO_vendor_support ee1004 rtnet mei acpi_t=
ad mac_hid sch_fq_codel dm_multipath scsi_dh_rdac scsi_dh_emc ipmi_devintf =
ipmi_msghandler scsi_dh_alua msr drm efi_pstore ip_tables x_tables autofs4 =
btrfs blake2b_generic raid10 raid456 async_raid6_recov async_memcpy async_p=
q async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 linear crct10dif_pc=
lmul crc32_pclmul ghash_clmulni_intel sha512_ssse3 sha256_ssse3 sha1_ssse3 =
i2c_i801 e1000e igb i2c_mux i2c_smbus dca i2c_algo_bit video wmi pinctrl_al=
derlake aesni_intel crypto_simd cryptd
> [=C2=A0 181.521457] ---[ end trace 0000000000000000 ]---
> [=C2=A0 181.584206] RIP: 0000:0x0
> [=C2=A0 181.584210] Code: Unable to access opcode bytes at 0xffffffffffff=
ffd6.
> [=C2=A0 181.584211] RSP: 0008:00007f13a1c58bd0 EFLAGS: 00010202
> [=C2=A0 181.584213] RAX: 0000000010000019 RBX: 0000000000000001 RCX: 0000=
7f13cf09a2dc
> [=C2=A0 181.584214] RDX: 00007f13901de790 RSI: 0000000000000001 RDI: 0000=
000000000001
> [=C2=A0 181.584215] RBP: 0000000000000001 R08: 000d2714bb43ad11 R09: 0000=
7f13cf0b8080
> [=C2=A0 181.584216] R10: 0000000000000000 R11: 0000000000000202 R12: 0000=
7f13901de790
> [=C2=A0 181.584217] R13: 0000000000000000 R14: 0000000000000000 R15: 0000=
7f13cc1845c8
> [=C2=A0 181.584218] FS:=C2=A0 00007f13a1c59640(0000) GS:ffff8baf2ec00000(=
0000) knlGS:ffff8baf2ec00000
> [=C2=A0 181.584220] CS:=C2=A0 0000 DS: 0000 ES: 0000 CR0: 000000008005003=
3
> [=C2=A0 181.584221] CR2: ffffffffffffffd6 CR3: 000000011decc004 CR4: 0000=
000000f72ef0
> [=C2=A0 181.584222] PKRU: 55555554
> [=C2=A0 181.584223] note: Schedule[4405] exited with irqs disabled
> [=C2=A0 181.584497] ------------[ cut here ]------------
> [=C2=A0 181.584500] WARNING: CPU: 0 PID: 0 at kernel/context_tracking.c:1=
28 ct_kernel_exit.constprop.10+0xd2/0xe0
> [=C2=A0 181.584506] Modules linked in: vhost_net vhost vhost_iotlb tap ca=
n_raw can xt_CHECKSUM ipt_REJECT nf_reject_ipv4 xt_tcpudp nft_compat nft_ch=
ain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetli=
nk bridge stp llc binfmt_misc nls_iso8859_1 intel_rapl_msr intel_rapl_commo=
n intel_uncore_frequency intel_uncore_frequency_common x86_pkg_temp_thermal=
 coretemp mei_hdcp kvm_intel kvm iTCO_wdt rapl intel_cstate rt_igb intel_pm=
c_bxt mei_me serio_raw wmi_bmof iTCO_vendor_support ee1004 rtnet mei acpi_t=
ad mac_hid sch_fq_codel dm_multipath scsi_dh_rdac scsi_dh_emc ipmi_devintf =
ipmi_msghandler scsi_dh_alua msr drm efi_pstore ip_tables x_tables autofs4 =
btrfs blake2b_generic raid10 raid456 async_raid6_recov async_memcpy async_p=
q async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 linear crct10dif_pc=
lmul crc32_pclmul ghash_clmulni_intel sha512_ssse3 sha256_ssse3 sha1_ssse3 =
i2c_i801 e1000e igb i2c_mux i2c_smbus dca i2c_algo_bit video wmi pinctrl_al=
derlake aesni_intel crypto_simd cryptd
> [=C2=A0 181.584567] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G =C2=
=A0 =C2=A0=C2=A0 D =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 6.12.55-rkernel=
-s1.7 #metaOS
> [=C2=A0 181.584572] Tainted: [D]=3DDIE
> [=C2=A0 181.584574] Hardware name: Sinsegye SP7022-7231/SP7022-7231, BIOS=
 SP70220720250618B 02/10/2025
> [=C2=A0 181.584576] IRQ stage: Linux
> [=C2=A0 181.584578] RIP: 0010:ct_kernel_exit.constprop.10+0xd2/0xe0
> [=C2=A0 181.584582] Code: b7 24 ff 48 c7 43 10 00 00 00 00 44 89 e7 e8 65=
 fc ff ff e8 50 05 00 00 41 89 85 ac 08 00 00 5b 41 5c 41 5d 5d c3 cc cc cc=
 cc <0f> 0b e9 6d ff ff ff 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90
> [=C2=A0 181.584587] RSP: 0018:ffffffff98803e28 EFLAGS: 00010202
> [=C2=A0 181.584590] RAX: 4000000000000000 RBX: ffff8baf2ec61760 RCX: 0000=
000000000000
> [=C2=A0 181.584592] RDX: 239ca7eb0002000f RSI: ffffffff985d6b39 RDI: ffff=
ffff985a419b
> [=C2=A0 181.584595] RBP: ffffffff98803e40 R08: 00000000000a9b20 R09: 0000=
000000000000
> [=C2=A0 181.584597] R10: 000000647744b41d R11: 0000000000000000 R12: 0000=
000000000005
> [=C2=A0 181.584599] R13: ffffffff98b3b260 R14: ffffffff98810940 R15: ffff=
8baf3f7cff4e
> [=C2=A0 181.584602] FS:=C2=A0 0000000000000000(0000) GS:ffff8baf2ec00000(=
0000) knlGS:0000000000000000
> [=C2=A0 181.584605] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
> [=C2=A0 181.584607] CR2: ffffffffffffffd6 CR3: 000000011decc004 CR4: 0000=
000000f72ef0
> [=C2=A0 181.584610] PKRU: 55555554
> [=C2=A0 181.584611] Call Trace:
> [=C2=A0 181.584613]=C2=A0 <TASK>
> [=C2=A0 181.584615]=C2=A0 ct_idle_enter+0x12/0x20
> [=C2=A0 181.584619]=C2=A0 cpu_idle_poll+0x10/0x100
> [=C2=A0 181.584623]=C2=A0 do_idle+0x50/0x140
> [=C2=A0 181.584627]=C2=A0 cpu_startup_entry+0x2d/0x30
> [=C2=A0 181.584630]=C2=A0 rest_init+0xe5/0xf0
> [=C2=A0 181.584634]=C2=A0 start_kernel+0x75f/0xab0
> [=C2=A0 181.584638]=C2=A0 ? load_ucode_intel_bsp+0x2f/0x90
> [=C2=A0 181.584642]=C2=A0 x86_64_start_reservations+0x1c/0x30
> [=C2=A0 181.584645]=C2=A0 x86_64_start_kernel+0x96/0xa0
> [=C2=A0 181.584649]=C2=A0 common_startup_64+0x13e/0x141
> [=C2=A0 181.584653]=C2=A0 </TASK>
> [=C2=A0 181.584655] ---[ end trace 0000000000000000 ]---
>=20
>=20
> Has anyone encountered similar issues on Intel with recent Dovetail kerne=
ls? Any suggestions on where to look in the VMX/Dovetail entry code would b=
e greatly appreciated.

I think I wrote already that we lack systematic testing here: :)
https://gitlab.com/Xenomai/xenomai3/xenomai/-/issues/55

Are you able to reproduce the issue with a generic setup (e.g.
switchtest + qemu/kvm with random guest), or does it need your specific
workload?

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center
