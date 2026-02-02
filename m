Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010023.outbound.protection.outlook.com [52.101.84.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA2E374182
	for <xenomai@lists.linux.dev>; Mon,  2 Feb 2026 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770044203; cv=fail; b=mqzYcgmAIpIdPhbc7OoI4wDonImFuQj5bBwiKtuSZek1WwXGwEVX5+pmj93EMekBokQBADlkoTtH0arJ1uZevOg2usfn7V5+DQiGv19NjCaxAhlahdYSoBuKVbIrX5frVfpLGlvshHhnmh2PDrMSg1MdWt5YEEGx/vE9Q1qEXtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770044203; c=relaxed/simple;
	bh=xd947CFIN/Cd+QfjZM18TCgj8+O+fo5P5O4SFI15opk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NSK433Imas3TTUYgGhhrgCeP/CvTS/LsJvdQk+ZAb3kFyrsHVUstdjaWQJjI4iNzuxBeC+PJ1XTfH23TtYX7z6UNInMYWwZ9fZ47JOl0OZzKFDdHzPzDV6k6lI+t4wO7rIbnkOmYnxHU5zIxOaZefEt1Jz9AYVAvaJri+1mLsqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=PtkGX6Fa; arc=fail smtp.client-ip=52.101.84.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="PtkGX6Fa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DbG+XLYmmOWyN/ksOwo5/3Qw15aolZaEPcolDIsIPqXWjM7/HHxOCyxPuhM1sOOX82gAsrtTO9hkdhW+Avq5IpSOJL+S3XthAjOOR5EY0A9tdEgZ1YoH/6zQGDWrAMSo3g4R6MRWalJBOAdSiAgH+CHK1HgKWSEabzCD8IoD++q+lkrwFPdL+12JuSOYL5bTgCZF0pwu/c1XnsDFkiXho5fnqb3lXG5PN12B0e5gwVdRwL1xV0vhS+WsI+qO/803CADGReB8ROwGMm9A5dDXR6YSnitg3ZVkMfIGxIHgTIgmr2I82KLPYxN+u7fd16npgoCmx4v/Yui2buI9S6R6XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19bcOGQPM2O0XUtIPHa2OFeBg0DcB2CxN4ZjX8+l8ws=;
 b=JdzwFMJ41VoT0kmWcr4pNhrsdyqDuqJPt4dlIcncvRZWvEmTPlLABrv/QJFnDtwYSEGOZ1DrriLhkHkcrfFrcLuVUlnyx4K2pC9ljqU1kGjJEd6ook4uQuWuYXtvYX6KJBXDRgFUKbq1hvY1Q+pv/D2Z1UcnWOnrcdHbKZ7mfaNhsy5dKsDSQMfyvTAsm7F+yyxq/xkrEBVvrPe8HYYtyhpYZKhDnKwsZUSSDFn6otpXKrgjP3y3+n/pdbbJDTqweVdZiGh2NLr/32IogiRZKvSK2J9ZZnmFgV82OpDCG+8AJRwo9xKtIi6j2YKMw05HV0sXxpb19/iX/MUedWrl+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19bcOGQPM2O0XUtIPHa2OFeBg0DcB2CxN4ZjX8+l8ws=;
 b=PtkGX6Faa7BergRmh/ry8hPZ2sTVC2jL/lldqZOMRo+SwcRlpVULOR5os/ZXVRX6CeI/C4ShapAdRgeOh9mPDiWIbEJCmBFNqt9d4RaX20LfoMi5YqYVvj1H+EYGGi6aTg1IhHJl6SPiibGQ6OHS3WxjMsXQ3SuqEBBqVrcfwX63tBICFT7t3YbAUEvSHv0Rq1VuBcrTQYbpg3LMMORmNHa9/dQmn4WfT8kQaFJOo2dKgFMSCpHvcxAYCNauUaEVJsmCy3qnd4CgZNIm7IeVjpBPsdmCWDBW6J2vtMyT4qQA9sv62zmgHR4Tl/mlZTcNKdYGCZLQn8TOQzfvIx8hmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DUZPR10MB8234.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4df::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 14:56:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9564.014; Mon, 2 Feb 2026
 14:56:36 +0000
Message-ID: <ad8c082b-79aa-43c1-8d20-950df3d5c3d8@siemens.com>
Date: Mon, 2 Feb 2026 15:56:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: /proc/xenomai/irq for Xenomai 3.3
To: Pierre FICHEUX <pierre.ficheux@smile.fr>,
 Xenomai <xenomai@lists.linux.dev>
References: <CAFc1U0tqO9SstMLehsKRhNT89fp0_U-9Q8_nKj4VeD8C5A5ZtQ@mail.gmail.com>
 <CAFc1U0uojGV4Tg2cD+c-aK3MxjvUnjWgCLrX+dP46hBsi7Nh+Q@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFc1U0uojGV4Tg2cD+c-aK3MxjvUnjWgCLrX+dP46hBsi7Nh+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0252.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DUZPR10MB8234:EE_
X-MS-Office365-Filtering-Correlation-Id: 8638d4e3-66d3-4d51-d80b-08de626b4380
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXVMQmpKaHdnZm1uZWxUREJrcDBQOU8vemI2cXRmRzc5Q0xqL0MrZEJ4ZEU4?=
 =?utf-8?B?N2d1VzBKcGJWeDROc3pXVmtQZml2YUh2Q0JnTGk1YnB2S200d3VGUkZpTGVp?=
 =?utf-8?B?RU5ISjM5bE04Qm5yc01SalIyb0NFbE9IMmlEdjJVdG5MWWI3UjN3aGQ4YUpO?=
 =?utf-8?B?MEcvK1NoVlFWaktzUUx4R3dXaUxrbnQ4VE8rZWRDRjVBNUdTVjhwRENkWmVw?=
 =?utf-8?B?YWV0eXByckJNTStoZnl0cHZ4WWoyVVRJcnBBZUJhK3YrK1FIb2tVNDhWSGFZ?=
 =?utf-8?B?RkwwS0g1bUJKTE5EUTJnT1d4Q2lnekhYQ3pma0llU295dzE2b1dMNVRITUhk?=
 =?utf-8?B?c2JyaXNNc1pOQ3hSQmtlYVRUVEMvaWNIZXdQVlQraGlrTE00Y0c2Rm1mWjJH?=
 =?utf-8?B?K21pazZIUzB0dTFxTFVBc1l0bXJibEVTVzhiMzVPeWp3NThiYW1uVGVOd1cr?=
 =?utf-8?B?MVdCUWZVN2cyWUJDZzBVcGhtbis0WldtY2VLWDVHVzVrbm1hOElxUFMzNVZ5?=
 =?utf-8?B?eVR5QXZXK2p3N05Jb2pka1B2bmFVSTVNSmVwaVd0TFF1Q3hYSUxucm42V1dX?=
 =?utf-8?B?Vnl0SnEyUVpmaHNtbVY2Qm1rM3QwRUROMm53MGJLaGZyVm9Dc3JMdGhyOTE0?=
 =?utf-8?B?a25Ic0ttS3FXb0U2TXRSbElQNUJvWnBWWHJPMHZVYWFmRWpZZzBrbEM1cnlE?=
 =?utf-8?B?VUg3Z2tYUnU1QlluNVNwd2UxWkFUMDE2OXFxakdTZXF5cjhSNjRZdklMQ1Q3?=
 =?utf-8?B?L0owUWJoSGJFcXhZUGZGNm1SZ3AwbTV5TWQrUW9XU1VWU044SEwxc3lBckEv?=
 =?utf-8?B?cEZFcE9OVDBOWnhLRWp5Nk1YZDhvck0vMWo2dWQzUUpiV1oxSDdtQWIxUjNp?=
 =?utf-8?B?a2ltYU1PcmxmN081Z0ZqeFRCcmZpUDdtV2Q1ditpSkRYUXEwRElsZHpQKzdv?=
 =?utf-8?B?N1kvaE16bWFlb2QyREhuWWgrZmxlK3Y2bjJUcHlFMkQyZHdUZ1RydWtDZElB?=
 =?utf-8?B?KzJFNmRTSmxOeHhZOWR6UFd2N2dBNEJFVFRBUXhIdTQwbFY0V0kvSEk4eUxr?=
 =?utf-8?B?NlhqV3YrQldLY3RRWFFxZVYxb2w5VzVLRTZvTW4zRE14cmc5ZGYzTURaaEpN?=
 =?utf-8?B?cUdSYkdVV1U1ckdSOWlCTVU0VS9iWUlQYzRWNkEzMExHQ00wRTlwMWZaWVNH?=
 =?utf-8?B?OXFoMmRDc25JaXhRakU3LzFJOXRtQ0NwZmZoSWFvbmgvVTk2eTRldmM3K09U?=
 =?utf-8?B?S1RjeitRbjByaWhwaGx1bW05ZDJUa3l4dGNTVDh1QUZ1MCtEQTQ4amd3dWZE?=
 =?utf-8?B?VXc5L3ZZNGpGMFRFVlFKbE5wUVlsNzU2ZnJId1lJdGgyNmJwVFpXZ0hoUlBM?=
 =?utf-8?B?TTJxeU9vOUd4S0l0bVN0NTc4WnFJT2c5RmtqT1ZYNzRwRkZSTUl0VWpMM1Vv?=
 =?utf-8?B?N1c3MjUxOE1nYWNCTkNGb0dIdWduRGlEdkp6cUE3bVZHSC9DMW5RaXdsalJT?=
 =?utf-8?B?QmN2WnFsRGpBSktSY3hCWlprRHYxcnozTW9ndURiY3lJNkhCQW40NmVJMWwx?=
 =?utf-8?B?VUJ4NnhYTkxhM3dkNmRSYXdPSTR1UDBsbzNQd1hDK2s0R085Z0U5aktVU25P?=
 =?utf-8?B?bkNkVmFjT3hCbHlZMnQzemFUTUc5dFQ1RE5JVE54dFZjeHFMNm5jNGZrSy91?=
 =?utf-8?B?MG81d1pYaEtrbWNCRjJjSTRVZUJaUXdlL1k1WWtSTzhxWGh3cXh4VDJ1WTBB?=
 =?utf-8?B?MS9mZU9EMGVldTRnc25sZitvWHdVOWJpdllyUDM2Ui9MODZxU0hjOE9lZFBx?=
 =?utf-8?B?WDladUVGOFBab2RpT2hqVWFVeVZvWU9RWXRUMzNNRVd5RFV6d0dnbUYrZEZQ?=
 =?utf-8?B?d25kTFBWa0ZxT3BBVG01WkFZZG1yeHVVKzJ1VXlTMmErdnFIYnNZOENVQnlt?=
 =?utf-8?B?TXMwOUE4cWhsMzJnTjk5dDc4N2c0RkxIcU1IT3o4UktWeEZhMmdEMVhWa3JE?=
 =?utf-8?B?OTh3cnhSYXpraDFpTTJyc0p5UWFnSUU5aHQrNE1xZ2RGMXFIdjdKQWtTRUg4?=
 =?utf-8?Q?tXgwTW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0hpR0lBVUoveTVRUmdtdERLZFlKTGxrWndEOHovcSs1c0RnZjhwNjZCaVJR?=
 =?utf-8?B?TDBjWnVmUHBQbFF5TXlYYUZMS3JIeVFoLytzeGtCOEljemFBY3IyNS8za1hM?=
 =?utf-8?B?VWhZcldObVdIc0ozR2FpL1VSVUdxL1VPblNsOG1aR29BUURkeVB4MStIRkVp?=
 =?utf-8?B?UDY3VGRTVkFKTUsrRnNVRjhqME5sR3B2YVE1VTUxZEY3TzI4d0x1Wi9nWTFq?=
 =?utf-8?B?emdlaS81NHN4ZFpZU2pyNzA2VjAxcVhjUmpSajA5TTZXVUM3TzBxMWxLdjFE?=
 =?utf-8?B?NVZXbmFNcFdxQ25aK2tYUCtTd3RiVzl5ZmJ5QUxUbEZ6aWlWd3pxcHB1TGd1?=
 =?utf-8?B?SWd1bG5yYkdmc3JmWnU5ZjVIMHAyTVY1RG9rNEpOa2NwSDBxRlRTUjZSZFdp?=
 =?utf-8?B?REh4NTdwN2hTOWlOa2pjVXBybndNVDArQUlNckw1ZEd2Zk9tbE9LamdNbm9I?=
 =?utf-8?B?Q3d1NEcrV1A4U1RlU2JMeFJsUkVibk5lZCtDV1ZvNG96cjFnMEV1ZnBlakor?=
 =?utf-8?B?YkMzeGlmUEN1KzdMdE9tclRiQU92ZXdhNnI5RnJTYUJoMU51cE9CVlkyVFdj?=
 =?utf-8?B?aTBNTEpVQ1JXVWJOTW5RRUE4UGxKV0JIMHIxWWdMbHB0RFhMeEx5bzRsN1Qx?=
 =?utf-8?B?ME5QSVZzYzJUL3BrUDFZZnl2dFhyVGV6Z2F6ci84Z3JaRVVQeG9xVE53VWZU?=
 =?utf-8?B?SkMzMG9qQXY1RmQzUUppVlczcXlzZzJqcXBYNkFKdG1MOFFNNVB1R3R5QTJr?=
 =?utf-8?B?Qm5LOUM1eGd4SG1QTFZhNWpJQU1wYkVpb3ZJN3VuMmRYeENoeGdpSGo0K254?=
 =?utf-8?B?MGduNHlCVmhTVEIvTkNWTFl3NXNTMG1ZNnpHUmJ4TXdMdFZUOTZRZkdFSWpO?=
 =?utf-8?B?UEJkTit0elFBQ05sUldFYTNTQ3pZSzJJSVB1b3J4VTFGTkYyNnQ0M0kxaDg0?=
 =?utf-8?B?Z2FDeDlNb0hFMGVyOStUQmJWRWZNdVpJTitQcHF0dlNQMUNVMGtEOGYwLzd1?=
 =?utf-8?B?TTJlZFNRQkZlUGJuN2M3Zkl4RkVPS285QlJaQWZwdWNvV0VXYm5BdStDTC8x?=
 =?utf-8?B?WlgrQXZwaHFFakdYa2h2VWErSTlUWVNSRWhEQVdPQWYxWHZnY1g4aEJEWHJD?=
 =?utf-8?B?QXVQS0lCWWJWTjVVM2RPZklYSk1SYVhxZklad3lzaWVuK0tTTEZjbkM3cEE5?=
 =?utf-8?B?bVU4eGtmbXFNYTF4cnVoaDZXZDZibzhBNVJZOW9ZNHFnT0dUanBzakxQZjVk?=
 =?utf-8?B?N1pFVk9HS2pBNldpTnluYnc3eXhNUmtHV1gwYmY4YTgzSi9DVlZId3NnS25q?=
 =?utf-8?B?YlkzZW40Z1A2UENxaENxVEdUdW9kQWJMc3NXenhDRkd4VXFHalJQMFpseFVa?=
 =?utf-8?B?QXM2MElNaGM3L0hVSXp3eHNnUkxFTFNTOWtBWmxHNUJKWlpBcldPSExiVnZO?=
 =?utf-8?B?NlRSNVg5MFNteGZ5QW5lTFpuNm1ORU5PSHJjeXBpQzhTbG0rQ3BVTXBueVB6?=
 =?utf-8?B?Q3I5WDVDSVg2cHMzNFp3ZTF4QzZYdThhc1lCWDFHR3IrY25qUTNUaVp2L0ZQ?=
 =?utf-8?B?LytGc3NkY05SRFpyNlFXUlNWY3prbklBVkxraTI2dmFJTjhJL0s4dEJpYzli?=
 =?utf-8?B?dk5yUFFUUkpvYU5zdFA1Mkt4TWlaUTJMTjRjZVlNRXFpdXVtSmNrSnRFR0pP?=
 =?utf-8?B?a2pKaHZxOGQyUys5R1hRSEc4WmJwRHg0UEtvVnM5UkdvbWtuYzN4OHF3ZDA2?=
 =?utf-8?B?UGw1QjNQUHVnZlRscjROV2tUdkJhalpSOURMWTNsR0EyRldPN2VHaFZ4RUF0?=
 =?utf-8?B?NG1ScmlpQTFrMlJWSHUwUm9YU3hkdEZyaldYVFB6N1RQVTF3L29mbkZjeXAx?=
 =?utf-8?B?RHVWVFFCUWpJNkcvaDNLd1MrbThEelA5UXFpQ0Vrd1c3QjNPeDYzcEJuMEJa?=
 =?utf-8?B?L0RHM1FhQ1E1aUM1Nm9meWlIRklEYkR0ZStXMHpXYndaR0lyOEdpdzFUMmlG?=
 =?utf-8?B?MThQZXp2emlRVjRKNXNNM0JnUEFET2dGRWFmYXlFclJDb0I3YmlLNmgvOThM?=
 =?utf-8?B?U2h4dFpmQllodC9vWmcrWm1qZE1WZFF1dFBzUnd4MjlBb2pScWQ5UjNIUHRP?=
 =?utf-8?B?Zy9DSWFHallQYkhMYjAxOEtEaG5VUlp5SmZleFlXcjF0MnpuVkVwVitjNHBo?=
 =?utf-8?B?NDhCcDlkbFpQMnNZSzZ4MnoxSGNUUFpwRzdkRVhWZ0NuaGdSWkd2MU1qWU5h?=
 =?utf-8?B?TGUwOURvbTlscWVyQTZzek1YSW51eW16d1NzMkYvWXVEeElEbjA5aExQdElO?=
 =?utf-8?B?S3pNUC9nSGRLNk82V2dVUVNxZ0F0VzhndDduNFZDcUw3SE1nZ1E5TXIyaTB3?=
 =?utf-8?Q?wEAIKeHCx8C9Qz2I=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8638d4e3-66d3-4d51-d80b-08de626b4380
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 14:56:36.8100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gDmH5bggC8ozsTqBHJq6DeFspZ8VcW3DX2fBXzH2eTzETSsnB3qp3Rlk7GLz7jv2KEjvu4AAtT2HkvNUivXgrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR10MB8234

On 02.02.26 15:05, Pierre FICHEUX wrote:
> Forget about my question, found it in /proc/interrupts with oob flag...
> 
> 272:         99          0          0          0      GPC  26 Level
> oob  rtser0
> 

Exactly. This came with the migration over Dovetail (kernel 5.10 /
Xenomai 3.2).

Jan

> Le lun. 2 févr. 2026 à 14:58, Pierre FICHEUX <pierre.ficheux@smile.fr> a écrit :
>>
>> Hi,
>>
>> I notice /proc/xenomai/irq is not available anymore (?)
>>
>> What is the way to know the IRQ used by a RTDM driver ?
>>
>> Regards
>>
>> --
>>
>> Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
>>                              http://www.smile.fr
>>                              https://smile.eu/fr/offres/embarque-iot
>> I would love to change the world, but they won't give me the source code
> 
> 

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
