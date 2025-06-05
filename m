Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012027.outbound.protection.outlook.com [52.101.71.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4EF23F299
	for <xenomai@lists.linux.dev>; Thu,  5 Jun 2025 16:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749140520; cv=fail; b=mRGeEp+69DBtDlKQqLz6XDp5bccQJXpkkb8d3CzF+vFZCikw1XCNuv5v0vGjKfLuzHL8jd3AnBvgEGKWZs0AiVp+pZxX0h2zfmfuMheszwY5Ez2TZ4JiAtLOck8UfxKQpnusPpR5YhyFRgAtQmEUHjsb5Rp2JgOv4qjRTQlPhps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749140520; c=relaxed/simple;
	bh=p7qIxWbLPG9QA5BDfb+yOvlFg+f6sSeou3wCAF+KtDY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SX/qGNJWMvpRskxe+4+pikPxqOuhNeXQmOZXBRBbMjDE0how6oZuCHv5toW06diZqDyLJuoEWt3MP3ruyRJbcZzWMXqJNKNU0EXX7yBSdQn33sL3/QLR8ENhdb44I+/O5LZON5xlukm3hDq6C2H4Q85jyKsS08RiJ0kX+H9jSUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Tga9FhEj; arc=fail smtp.client-ip=52.101.71.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Tga9FhEj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=geyHQSeurETwKqim5ZEETEZmJH8MDj63oLfvepyRK+8kXyU7DxbTTOJbnXcMkKqMaHJGleb0tVR61aNL3JIrIjDKYuktmruWUVcq1zm9CcuYMAXVjWA+WfHwcV9ezqOKIBEwXeM/tOZdZXzWbLgJOdJi57fXlFsAMN26hpmAfX978k6xuixQ0VvUkhVQGqsKRF+o8IeqzYxEyXzLTYbBDQGZaa1yuwW987OS0CTK1vQnNIyCA6BAua+DinirQzg6ugvNSwaH/sGoufbDQd3Exv+VRn3PGIX+7o3UaBhMc0Q5/eJAMfAbuVyuVxSoKWk4VBdDHoNARVZgkTK3kSi5MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7qIxWbLPG9QA5BDfb+yOvlFg+f6sSeou3wCAF+KtDY=;
 b=XlhxQok+CGmEFP6Z7LvDTcXAufH8XtTSqFut7AXPtDbK6o5B6/5Gj1/Vm26coC7RIYcnfI6j8oo2pgVeM6CJ+kA5dySGq0neuIQxDBoIRx+IZpLBnh8SX1tTRB3vV3IQUSAS95aIDtQHZuwifs74xwT6Csq1mhDDfn/MpWMHRopmQj/Y5bHHTfs3k4SnfLTD/5kEpKL/dpMQMqqJ+Q3n68tV0np3g8I1K97mvdxSY+MyaXbG9zF2cdNkehE1+CXWhr/uAIjwLLvxTE0sNg4EH+MY8fjTYLamBK2TnTIEx8FDOmBFTxnjmmtWm3maXAmva9k4UjjPV+7wteAD9k8gJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7qIxWbLPG9QA5BDfb+yOvlFg+f6sSeou3wCAF+KtDY=;
 b=Tga9FhEjM0JODOLLw+7D9DZP4aSy4QMAhz29YKj2Vu2Wa4R003Zko/UPJVJ33IyhyfQ+puk4McNgZnnsSvNVOQ+mSGz4R6r+0+bwZhUjeG8vQ2NrzBg2PJbiNgb1SGC2UWeg3fqWUUgOHkIsBttBtthFHtMAG8rLMP0HGx2wSSaVwtR2WtNNCZVQBX51EFzPnkMuNZAdICKd9AkgAwsZ4/37+1zhQhW/coH2fBso1D0u7fuKxMmX79Uoe/zmjYViZZeyMjAL+NNuke+769yvwrvy5wlwTfS3QNedSNibY/HgNkobI0vIXXRwOlYMVvTI571guHQfdciH5xAdq6t3aQ==
Received: from PAXSPRMB0030.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2bd::15)
 by VI1PR10MB3550.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:136::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Thu, 5 Jun
 2025 16:21:52 +0000
Received: from PAXSPRMB0030.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::19fd:c825:6c6b:fb4b]) by PAXSPRMB0030.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::19fd:c825:6c6b:fb4b%4]) with mapi id 15.20.8769.031; Thu, 5 Jun 2025
 16:21:52 +0000
From: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
To: "rpm@xenomai.org" <rpm@xenomai.org>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: Re: Dovetail 6.15: x86: Invalid wait context
Thread-Topic: Dovetail 6.15: x86: Invalid wait context
Thread-Index: AQHb1I8r2TXB1T/joUaXy9sy1yFdhrP0NrYrgAAD/ACAAIgSgA==
Date: Thu, 5 Jun 2025 16:21:52 +0000
Message-ID: <a6c0bc4c19cf73a94ae409b1cd7cd5993da5e162.camel@siemens.com>
References: <ee6e634d9d87ef52670dbb9ce91d7080b8640a71.camel@siemens.com>
		 <87tt4ubote.fsf@xenomai.org>
	 <997e11d95184f34a23fad2607504ef567ec07758.camel@siemens.com>
In-Reply-To: <997e11d95184f34a23fad2607504ef567ec07758.camel@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXSPRMB0030:EE_|VI1PR10MB3550:EE_
x-ms-office365-filtering-correlation-id: ef70f794-19a5-4ff2-4963-08dda44d14e4
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RytNUE9udENCMVlKQXZRKzVYTnphN2pqNkpOR2pBTjJ0ODVES3FXbzlHcUla?=
 =?utf-8?B?TzI2ZldEWDJUcVhmSFBnUzhKMUVDMnd2T0FuWGc0S29taExsblBWNmd0cEh0?=
 =?utf-8?B?MHREM3dhMTkxSHdSSXl1RkNjSktIYTIxaHhLVGQxb1hDVlIzTjZUakFhVG5U?=
 =?utf-8?B?UmJxQklGYmtRMHVaZXNjLzNJTTlYSXZEbEw5TVhTS2ZPa0c5OEJQRGhhTmRt?=
 =?utf-8?B?YzlUK2M1LytOclZXWjVBRGhnL3NtT2xUSFIyRmpkbEpxMlpPbW1PS3pETFVK?=
 =?utf-8?B?aEM5UmZGSWlwZU9PcFl3N0Y4STJtZS9kMXU1OU1hbzdHNjJic3hhRWtPUS9y?=
 =?utf-8?B?QUtTQ2FzWmRIcmhDUTBsdGFEYzBFTmNMTDJRTjN5WFNtb3JIcDMvZ3lZV0gy?=
 =?utf-8?B?YjloQk9BdXVTVTRqQnlGejlIU0V0ZS9nR0RUN0szeEpiRUx2N0xLdzU2QkFj?=
 =?utf-8?B?cEpuTngvRHQ0ODlvYldETW9qdXdqRFR6SkdjL3NYV0IyeFIyeTVTWmFiVnNx?=
 =?utf-8?B?L1ZQeW9Gb3VvaTVSc2IzdUZIdEFsTm5heFdnZWttVStiajZUcW1DdTllcFU4?=
 =?utf-8?B?OXFFWGpNMnlLMkcrVWMwQzhZSmxBemptU00yRDhjNEs1aVhocjRtTTlTcVo3?=
 =?utf-8?B?L1JqTzRVV2RZYkNHcFYxWkw1YkovNnlBN0psZWRvRkI5YW40TURQdkN3dVh0?=
 =?utf-8?B?T2N4cEg4SllHMHhMSlcwc2w0a2ovT0QvSTdUVTgraEM1M1UwbGtEeWRIWTZ1?=
 =?utf-8?B?cXR3WFZNQ3pnVWhKL0NWSi9mZWRLUDN0d3N1NFZtNmo5aWxmMW1zS2ttZVB0?=
 =?utf-8?B?SzFnMzBJaVJFTkZJdVhKbGZYa2NvWHJPTWF2TDR2MTVwYzhBNWI3cW0zL2ox?=
 =?utf-8?B?ZXkzQ0NiZjUwWTQvZ0VuSTAwSEt2bkYzZUlJNjJUalpJMG5rUVFLM2cybkVo?=
 =?utf-8?B?UUxJbmtWQTlwejVTOGJBZUQwY3lQR0grWHZxUFkxMGdFeVQ3NENMdldlMDht?=
 =?utf-8?B?WHhaWFFzVVNCdlE0cm5HcGhLUGVCSVJvNmd1WFJBWHN1WS9WSXFwTUJkZFBj?=
 =?utf-8?B?a1NhTEEyR0ZMMkwxS20rTkdKUkUzRTZrNElNWWRCY1RLQW5WeHY5NWQxS0ty?=
 =?utf-8?B?YWZ2SnpWTHJNNDJrMDE3SGdwdnVtTkVVaWF0WVdSclY2cTBueExsUlFja0lq?=
 =?utf-8?B?b2swUlNDMm5oZDlzbFRSKy9NQlYzOTVhMFZjd0J2VVRYUUx2TDdvZkpXK3M3?=
 =?utf-8?B?azJudUtHa2NYVTNtYWRlcCs1YUNxWVdZMnAvYlQ1WGtYWmI4UkNBa0w0SHJT?=
 =?utf-8?B?SUFYODNIM0VsbEJRWmVESW1ORFkwQkhmV2hQZWpCZzZwZk1VQURQUWJSYmNp?=
 =?utf-8?B?UXprMUw5Q3c3UHQ2by82OFo1NHdpcjAwVkhaYjdrUFRFRFRDK3BDWXRGNG5O?=
 =?utf-8?B?WHptcnVocElFWnk5VkdLNldmOUY5L2hZc1oxZ0RSejJ2RmtsQTg5b21jZEZQ?=
 =?utf-8?B?ZFc1OXN3TUMvRERJenR2UDd0OGsxY0IxQ3lnOWdnbE14VTdxTUpnaGJVNDlK?=
 =?utf-8?B?dDdZa001bmtkYmdHaTFmS0YwMGtvdjdIYnVEMjZFblZWdFVuQ28ya0ExaW1L?=
 =?utf-8?B?aUF3R085S05aNm9nK2tPMEVTdHVNaTdUS1NzdlJrTlEzWXVlTnNKN2U2aGgz?=
 =?utf-8?B?QlgzendjK2oyeldndEJ1cDNZYmEzazMrRlJQRlRZdkxwemtHM2ZjL21VWlNn?=
 =?utf-8?B?MFI0RlpwaDUrUW9SOXVzSzlvclIrRTBZWkE3c1UxMDVPMStMdFcxMmVNT1ZE?=
 =?utf-8?B?cHFFeTlrV3NKcHJmWlFwNlMwVVB1Zm55TWJXTGxqTDduc3ZpcHdVYVhhL1F4?=
 =?utf-8?B?ZjQ5OWhyVXpVMDNhSDV6a284M1I4L0ZkNGVrNXMrQ3dQbGlxZEwrQitKRzZL?=
 =?utf-8?Q?9Sd8ry13mH0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0030.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RFpPNy9TSjdkTEI5Z1Nmb2ozOXZCc1YwUDArMXBKb29GSk9jMVlQTUxSSFp4?=
 =?utf-8?B?Qklabnl0MWZES3k2QXp4Um5Pa1NqcUV4QXEwNm9UeDlreVJIWUlLSWgxL0hO?=
 =?utf-8?B?TmR2NWY3UXcxRS9uNDh3R1VsMDFSSGM2NTZHaXJtRFlEY3ZRTUpuT2dxYUg4?=
 =?utf-8?B?TUFkUGs1QitzSHBhZVM1THdRQVNkZDhlUk9hNlM0THpEZnpiTVdOYU43QXVW?=
 =?utf-8?B?MmN5VnVFditNbkVrQWN1eElwY2VRc1ZrMXdnQnVlcGRLcEcwS1lDSEdrc1Zn?=
 =?utf-8?B?SDJZZ3N4WXBXU3VzZGZUTjI5aUM4Zmg0SlRNVUxyZGZJQzdYbERWSmlRdnNj?=
 =?utf-8?B?RVBpS1JZNFJ1S1JNbXJKQXZsSGVWNEpiT0xkMFhiOThJYXltUTEwamFwVS9w?=
 =?utf-8?B?MjJLMWI0NGVUd3FsN0ZQdzhISFFWLzU5RU8xTjg3SUxEUkl4YmZoRmorYmZj?=
 =?utf-8?B?NmMyTkVOTk9lYkwzd1NFRi9reTBYMmpNcm9oTm44YVp1MEVlSERObTFKeEJj?=
 =?utf-8?B?SFNCZXpjTk5WcWk2bEttT3dPeVFMaEpzRWYxSERyMlNVbWs3RUJDV3pndmF0?=
 =?utf-8?B?NXdpUEFuL0h0dzRVejROWDRFMWIvVHBmald0V3JRaEtrWDRRMzZoaFprbEhs?=
 =?utf-8?B?WkY0enhnejdMTzZBYzh1ejkrYUltK2RwZFowbmpBNEN6cnZHd0d1ajVVTUR0?=
 =?utf-8?B?UXNxNDRmbXl1aFNBeDdaRmY1RCt4aHdvUURzK3I0dFZ2RXpFOHFDUlhLTWFu?=
 =?utf-8?B?N2lXeXNjeS9WSHRWS3dHZzUwbVRKdGtNNzZJVjluTGk4b3dhUEhxaFBtNFgv?=
 =?utf-8?B?aWdFMXQ5RGVRcVE3d2NaR0VuZjRMc3kyNTZzRTBxUVY3c244dUlvd2wrcW54?=
 =?utf-8?B?eFNsVVZGT1Y0NDZ4UVBSUkJVa2pCV1IwS09MVWZVTTdFVXVYa3BMTks2L3NT?=
 =?utf-8?B?ZW5EVnROTE5PaTRvVytYb3pPUTc0M1lPSjFlRno2QUpGRlMvN2htMVByZ211?=
 =?utf-8?B?eno0UEoyRHFBVU80WkNvbXpNWTcyU0o5ZTdKeUlsQ0NRS2FzZzNHeHpjUm1Y?=
 =?utf-8?B?VXkyL2RXQ1RaVFBpZDRXOU5jS291dnZoNlQvTGFKY0FXbUVtVEtoTlpsMmF4?=
 =?utf-8?B?ZCtqQi9yUXk1S1RYcXRqYnhIVVBwL25jYmZ4WjVJYzRuOHlpT01pNGlKV2ZB?=
 =?utf-8?B?SGlVeW1UQ2ZGOGg5Tmp5WVJ2ajhjTVgrWDdudW5CVC80enBxUWIzWFBlc3lw?=
 =?utf-8?B?NGg3aHFIN2hUNklSZGRReENHdnJFQTcyOEMrWG9mb0VyVFJaZ1RnYjZadmY0?=
 =?utf-8?B?bEdTaCtUdjhBQW5nbVFPZGxJWDlIcjByTTlZSlYvdVZlQ3dacVdya3NuZWhV?=
 =?utf-8?B?TkhNYWs4eS9jK21YNUF2SmRqMXp6UkxnalpUelI5ZE50ZWpTcG5nMFoyT3h1?=
 =?utf-8?B?ZVdYaEVXSFgzYmxCNWttZHNOT2hOVlgzTVhpWVNxQTJURjBqeHloUzhLeUUr?=
 =?utf-8?B?SGprck03WUwwNmJtUmNFV01tdk13dzdZK0xlTkpOTzhTNU9XUXpWaEJmODRi?=
 =?utf-8?B?aithVVJlc2hUeTRGOTJoc3NpdERFbGdnUFA2bGtIblIxREJNa0RnZHp1a0Q1?=
 =?utf-8?B?N2pkZFA5VUdZMllaYUhzMWlPTWVkVWZ0R2NpOEpERlFpTzM5bWRmQmlwRFVT?=
 =?utf-8?B?NS90VmZvd3NaRjltVmlDNCtFZWFVbG9aM0E0K09MaCsyNUYvckZDd1NnSXcz?=
 =?utf-8?B?bXBoRjRsd252cFdrMXRFM1NVK2xyRy9Tb0taM1FkVS8vOU8xZWN4NndiUjVy?=
 =?utf-8?B?MnNhVGt4cDFtcG05a2xvaXVJQ2V3MjgyNVNrdjNEZzViam9UTEJhUWFjQVI1?=
 =?utf-8?B?Q0hGeFNWY090U3ZhcDFPcThKemxQNWZDaENuYitJUVJyVW93LzFicnUzZVpy?=
 =?utf-8?B?SU1NMWQxc1I4eDFkMkJjeTRKVXVGZTc4dGlxcEJPZGhxRE9naTlzYU1PWkRt?=
 =?utf-8?B?c2VXb3UrRjRIWDdvZmFsdVo2cnJLckZNdkVTS0xSVGNnZzV5RzNqVnlEL3FJ?=
 =?utf-8?B?QmFxZW1SZU9HUy9nRjJsMW96WUtFMmdWb2dYd2I4REZGbDZCTDVsbFE3dk1t?=
 =?utf-8?B?OFIrcW44RkQ5TVhTUS9sQitwZTl6b1lZd0h5cHZHVDJtbnNCLzMvTGhPRTc2?=
 =?utf-8?B?cTlpTHVJT0lrOEVDcHh1RDUrVGJrcktIektSUDN3bGlCZi9EdlNySkxSMUhu?=
 =?utf-8?B?TUJBRVYvYmNvV2t4d2xaTWtYWG1nPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <46EF2C7865AD7B47BB7ACEAC5F18C636@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0030.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ef70f794-19a5-4ff2-4963-08dda44d14e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 16:21:52.6025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uqcwFMWV+lmvj9UBXSjye6DBIYMbGe5PjrNoHrTNM6dZWHhwrKUtyLIV5quc2ERYRfiz1u/sdjVHl3wjeQvNS1ajhxf85wZd1yHNBMEJG3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3550

T24gVGh1LCAyMDI1LTA2LTA1IGF0IDEwOjE0ICswMjAwLCBGbG9yaWFuIEJlemRla2Egd3JvdGU6
DQo+IE9uIFRodSwgMjAyNS0wNi0wNSBhdCAxMDowMCArMDIwMCwgUGhpbGlwcGUgR2VydW0gd3Jv
dGU6DQo+ID4gRmxvcmlhbiBCZXpkZWthIDxmbG9yaWFuLmJlemRla2FAc2llbWVucy5jb20+IHdy
aXRlczoNCj4gPiANCj4gPiA+IEhpIFBoaWxpcHBlLA0KPiA+ID4gDQo+ID4gPiB0aGUgZm9sbG93
aW5nIGlzIHRha2VuIGZyb20gb3VyIENJLCB0ZXN0aW5nIERvdmV0YWlsIDYuMTUuDQo+ID4gPiBP
biB4ODYgd2UgaGF2ZSBhbiBpbnZhbGlkIHdhaXQgY29udGV4dCByZXBvcnRlZDoNCj4gPiA+IA0K
PiA+ID4gWyAgMTUxLjU3NDAzMl0gDQo+ID4gPiBbICAxNTEuNTc0MDM5XSA9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PQ0KPiA+ID4gWyAgMTUxLjU3NDA0M10gWyBCVUc6IEludmFsaWQgd2Fp
dCBjb250ZXh0IF0NCj4gPiA+IFsgIDE1MS41NzQwNDZdIDYuMTUuMCAjMSBOb3QgdGFpbnRlZA0K
PiA+ID4gWyAgMTUxLjU3NDA0OF0gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiA+
IFsgIDE1MS41NzQwNDhdIHN3YXBwZXIvMC8wIGlzIHRyeWluZyB0byBsb2NrOg0KPiA+ID4gWyAg
MTUxLjU3NDA1MF0gZmZmZmZmZmY4NDExNzRjMCAoJnN0YXRlLT5yZWFkcSl7Li4uLn0tezM6M30s
IGF0OiBfX3dha2VfdXArMHgyMS8weDYwDQo+ID4gPiBbICAxNTEuNTc0MDYzXSBvdGhlciBpbmZv
IHRoYXQgbWlnaHQgaGVscCB1cyBkZWJ1ZyB0aGlzOg0KPiA+ID4gWyAgMTUxLjU3NDA2NF0gY29u
dGV4dC17MjoyfQ0KPiA+ID4gWyAgMTUxLjU3NDA2NV0gbm8gbG9ja3MgaGVsZCBieSBzd2FwcGVy
LzAvMC4NCj4gPiA+IFsgIDE1MS41NzQwNjZdIHN0YWNrIGJhY2t0cmFjZToNCj4gPiA+IFsgIDE1
MS41NzQwNzNdIENQVTogMCBVSUQ6IDAgUElEOiAwIENvbW06IHN3YXBwZXIvMCBOb3QgdGFpbnRl
ZCA2LjE1LjAgIzEgUFJFRU1QVChmdWxsKSANCj4gPiA+IFsgIDE1MS41NzQwNzhdIEhhcmR3YXJl
IG5hbWU6IFFFTVUgU3RhbmRhcmQgUEMgKFEzNSArIElDSDksIDIwMDkpLCBCSU9TIDEuMTYuMy1k
ZWJpYW4tMS4xNi4zLTJ+YnBvMTIrMSAwNC8wMS8yMDE0DQo+ID4gPiBbICAxNTEuNTc0MDc5XSBJ
UlEgc3RhZ2U6IExpbnV4DQo+ID4gPiBbICAxNTEuNTc0MDgzXSBDYWxsIFRyYWNlOg0KPiA+ID4g
WyAgMTUxLjU3NDA4Nl0gIDxJUlE+DQo+ID4gPiBbICAxNTEuNTc0MDg4XSAgZHVtcF9zdGFja19s
dmwrMHg3OS8weGUwDQo+ID4gPiBbICAxNTEuNTc0MDk1XSAgX19sb2NrX2FjcXVpcmUrMHg5NDIv
MHhiZjANCj4gPiA+IFsgIDE1MS41NzQxMDRdICBsb2NrX2FjcXVpcmUrMHhlMi8weDJmMA0KPiA+
ID4gWyAgMTUxLjU3NDEwN10gID8gX193YWtlX3VwKzB4MjEvMHg2MA0KPiA+ID4gWyAgMTUxLjU3
NDExMV0gID8gZmluZF9oZWxkX2xvY2srMHgyYi8weDgwDQo+ID4gPiBbICAxNTEuNTc0MTE1XSAg
X3Jhd19zcGluX2xvY2tfaXJxc2F2ZSsweDQ5LzB4NjANCj4gPiA+IFsgIDE1MS41NzQxMjBdICA/
IF9fd2FrZV91cCsweDIxLzB4NjANCj4gPiA+IFsgIDE1MS41NzQxMjJdICBfX3dha2VfdXArMHgy
MS8weDYwDQo+ID4gPiBbICAxNTEuNTc0MTI1XSAgeG5waXBlX3dha2V1cF9wcm9jKzB4MTUyLzB4
NTkwDQo+ID4gPiBbICAxNTEuNTc0MTMyXSAgaGFuZGxlX3N5bnRoZXRpY19pcnErMHhjMi8weDI1
MA0KPiA+ID4gWyAgMTUxLjU3NDEzN10gIGFyY2hfZG9fSVJRX3BpcGVsaW5lZCsweGNhLzB4MTgw
DQo+ID4gPiBbICAxNTEuNTc0MTQxXSAgPC9JUlE+DQo+ID4gPiBbICAxNTEuNTc0MTQyXSAgPFRB
U0s+DQo+ID4gPiBbICAxNTEuNTc0MTQ0XSAgc3luY19jdXJyZW50X2lycV9zdGFnZSsweGFhLzB4
MTEwDQo+ID4gPiBbICAxNTEuNTc0MTQ3XSAgaW5iYW5kX2lycV9lbmFibGUrMHg0Mi8weDYwDQo+
ID4gPiBbICAxNTEuNTc0MTUxXSAgY3B1aWRsZV9pZGxlX2NhbGwrMHgxN2QvMHgyMDANCj4gPiA+
IFsgIDE1MS41NzQxNTVdICBkb19pZGxlKzB4ODkvMHhkMA0KPiA+ID4gWyAgMTUxLjU3NDE1OF0g
IGNwdV9zdGFydHVwX2VudHJ5KzB4MjkvMHgzMA0KPiA+ID4gWyAgMTUxLjU3NDE2MF0gIHJlc3Rf
aW5pdCsweGYwLzB4MTkwDQo+ID4gPiBbICAxNTEuNTc0MTY0XSAgc3RhcnRfa2VybmVsKzB4NjMy
LzB4NzAwDQo+ID4gPiBbICAxNTEuNTc0MTc5XSAgeDg2XzY0X3N0YXJ0X3Jlc2VydmF0aW9ucysw
eDE4LzB4MzANCj4gPiA+IFsgIDE1MS41NzQxODVdICB4ODZfNjRfc3RhcnRfa2VybmVsKzB4Nzgv
MHg4MA0KPiA+ID4gWyAgMTUxLjU3NDE4OF0gIGNvbW1vbl9zdGFydHVwXzY0KzB4MTNlLzB4MTQ4
DQo+ID4gPiBbICAxNTEuNTc0MTk4XSAgPC9UQVNLPg0KPiA+ID4gDQo+ID4gPiBUaGF0IHNlZW1z
IHRvIGJlIHRyaWdnZXJlZCBieSB0aGUgWGVub21haSAzIHNtb2tleSB0ZXN0c3VpdGUuDQo+ID4g
PiANCj4gPiA+IEFueSBpZGVhcz8NCj4gPiANCj4gPiBEb2VzIHRoaXMgaGFwcGVuIHdoZW4gZnVs
bCBwcmVlbXB0aW9uIGlzIGRpc2FibGVkIG9uIHg4Nj8NCj4gDQo+IFRlc3QtTG9nOiBodHRwczov
L2xhdmEueGVub21haS5vcmcvc2NoZWR1bGVyL2pvYi8yMTY3OQ0KPiBLZXJuZWwtQ29uZmlnOiBo
dHRwczovL3NvdXJjZS5kZW54LmRlL1hlbm9tYWkveGVub21haS1pbWFnZXMvLS9ibG9iL25leHQv
cmVjaXBlcy1rZXJuZWwvbGludXgvZmlsZXMvYW1kNjRfZGVmY29uZmlnP3JlZl90eXBlPWhlYWRz
DQo+IA0KDQpCdHc6IEVuYWJsaW5nIENPTkZJR19ERUJVR19FTlRSWSBvbiA2LjE1IGRlbGl2ZXJz
Og0KDQp2bWxpbnV4Lm86IHdhcm5pbmc6IG9ianRvb2w6IGRvX2ludDgwX2VtdWxhdGlvbisweDIw
NDogcmV0dXJuIHdpdGggaW5zdHJ1bWVudGF0aW9uIGVuYWJsZWQNCnZtbGludXgubzogd2Fybmlu
Zzogb2JqdG9vbDogaXJxZW50cnlfZXhpdCsweGRjOiBjYWxsIHRvIHN5bmNocm9uaXplX3BpcGVs
aW5lKCkgbGVhdmVzIC5ub2luc3RyLnRleHQgc2VjdGlvbg0Kdm1saW51eC5vOiB3YXJuaW5nOiBv
Ymp0b29sOiBjdF9pZGxlX2V4aXQrMHgxOiBjYWxsIHRvIGluYmFuZF9pcnFfc2F2ZSgpIGxlYXZl
cyAubm9pbnN0ci50ZXh0IHNlY3Rpb24NCnZtbGludXgubzogd2FybmluZzogb2JqdG9vbDogY3B1
aWRsZV9lbnRlcl9zdGF0ZSsweDFhNDogcmV0dXJuIHdpdGggaW5zdHJ1bWVudGF0aW9uIGVuYWJs
ZWQNCnZtbGludXgubzogd2FybmluZzogb2JqdG9vbDogZGVmYXVsdF9pZGxlKzB4NzogY2FsbCB0
byBpbmJhbmRfaXJxX2Rpc2FibGUoKSBsZWF2ZXMgLm5vaW5zdHIudGV4dCBzZWN0aW9uDQp2bWxp
bnV4Lm86IHdhcm5pbmc6IG9ianRvb2w6IG13YWl0X2lkbGUrMHg0NDogY2FsbCB0byBpbmJhbmRf
aXJxX2Rpc2FibGUoKSBsZWF2ZXMgLm5vaW5zdHIudGV4dCBzZWN0aW9uDQp2bWxpbnV4Lm86IHdh
cm5pbmc6IG9ianRvb2w6IGFjcGlfcHJvY2Vzc29yX2ZmaF9jc3RhdGVfZW50ZXIrMHg5YTogY2Fs
bCB0byBpbmJhbmRfaXJxX2Rpc2FibGUoKSBsZWF2ZXMgLm5vaW5zdHIudGV4dCBzZWN0aW9uDQp2
bWxpbnV4Lm86IHdhcm5pbmc6IG9ianRvb2w6IGNwdV9pZGxlX3BvbGwuaXNyYS4wKzB4NjA6IGNh
bGwgdG8gaW5iYW5kX2lycV9lbmFibGUoKSBsZWF2ZXMgLm5vaW5zdHIudGV4dCBzZWN0aW9uDQp2
bWxpbnV4Lm86IHdhcm5pbmc6IG9ianRvb2w6IGludGVsX2lkbGVfaXJxKzB4NTQ6IGNhbGwgdG8g
aW5iYW5kX2lycV9kaXNhYmxlKCkgbGVhdmVzIC5ub2luc3RyLnRleHQgc2VjdGlvbg0Kdm1saW51
eC5vOiB3YXJuaW5nOiBvYmp0b29sOiBhY3BpX3NhZmVfaGFsdCsweDFhOiBjYWxsIHRvIGluYmFu
ZF9pcnFfZGlzYWJsZSgpIGxlYXZlcyAubm9pbnN0ci50ZXh0IHNlY3Rpb24NCnZtbGludXgubzog
d2FybmluZzogb2JqdG9vbDogcG9sbF9pZGxlKzB4MWQ6IGNhbGwgdG8gaW5iYW5kX2lycV9lbmFi
bGUoKSBsZWF2ZXMgLm5vaW5zdHIudGV4dCBzZWN0aW9uDQoNCklzIHRoYXQgc29tZXRoaW5nIHdl
IHNob3VsZCBsb29rIGludG8/DQoNCg==
