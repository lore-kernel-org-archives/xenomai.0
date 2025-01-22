Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7FC653
	for <xenomai@lists.linux.dev>; Wed, 22 Jan 2025 05:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737524614; cv=fail; b=u0klCicd7jpmxeAvxlFTE+NHzNzBa12yfUiNGXb7ghiA+cO1uLYo/PdHAMHO6btspomYvtgROR9l9aXN4yUCp1hBiem1sXYMpFyUsLAxoYmq2zDMH/5r0LMI5LFdiO4ZSbmlMvw5ry0wxiKhSH9YWIJYMb7p37KZLJYIqU6uZOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737524614; c=relaxed/simple;
	bh=abQEDEQjdUCWi7IgmdfMGoCjMwVeNpPLZb9Lxuyyqn4=;
	h=Message-ID:Date:From:Subject:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y8aVzGVb0AER5ebhFSP0aGXZ/5V8aQ+T0WIvpuIjsvbNyIFKjxiRDF3H30Cc7SNoE90YCQY+1S/DrCCLEpEVGAdlIgWt+/jP/nHVPTCtCEcSHEDV4EdwtVslyLhkXRKlApPIj0+uSrCOOuAHE0TXhlESAhBN2vI+Sz5OBwSw+/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=qtaXLDls; arc=fail smtp.client-ip=40.107.22.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="qtaXLDls"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=if5vFVjRSM/AtADz+W928VR6AUI/5saQibO0gmZ9Nppl2p5wX3V7p06AEYkRh0YrypeRO33svieJBmjxAvs2ddKmQ9T5JrRRXF8ntyBgE+XKETs2N2yI4GYFYQzOMMLYDuFD1CMTmzSnkHA0IvfhoRgEZz+Ll6LQW0J0CdpEYTs0s+GZVbGrjrRsLn+vQvXYbAx0h0yHo8m3KN/8c3S4uj3T6geYV1I15GsheO9zHhzt/fOcHPND2EdBdkkf3/JJgx+XUFBW5MnzcLX6rwK3un7Jcu0fn3QoPTLeM8cxv+rM92E+0h+xT5epdCQvuyho/TD/aCnYjC5knZmvN0x3jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRgt/sUJbmig7ckWYZkTwM6ve/v7TndFQ6ZTrFHpgNk=;
 b=dkc6kAYeJWpjKKZX4/djieqfNyavoGlP8mB8X1xiaExykeZdzKsMZXLan7UOCITsB1IEoNnc5J5gmJWHe75jNhpStcRNMBkBU7TaYEUxdfH+XdkgddSEcpPKqmhpC4NYHOnGaP+Vlc7e8fUZX2OkN74S1w55k+GlzFLh0/mczuom5YREg58mFUFMZ9iGxakFARDRlSrKyfsbbagE3VQYN5ILiHYsaDUDsgnPwqsa1ArAEfKmP5quZ0kxLJ81sA0d2l07puXIJDrJc3o8EjhNiCbkRPOCBxaA8McEOerCGWuj25ZudkvYNf+tJfQj65uiNGzrOSw0sn9GvMT8Mh82aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRgt/sUJbmig7ckWYZkTwM6ve/v7TndFQ6ZTrFHpgNk=;
 b=qtaXLDlsPNchzfFRbnB2JuucVbeJALpTbiVnT3/KaY2c+tEmC+jyb94p3WLCOqDs6wCRHVSltwWpjWQjajgse2xVDfnp6ALFV3jI86hZuRgPf1gkla+wjntDvv7d6iAixxXcaCZwO7/StE27j5Nkd07X5Nfc7IXODc/fy/xPqH8gIOlVh/q7eCa5hDSnWCixDGnR62AlsVtCwr1x6XPXursus+zteaMd2LGUfaX5UQBMaSCrAt323t0n2CMxJIR/OYa2BKQ2Mih3BqvQRb/TaHfPyt9UaV/uaIRyGjUDt/mZXV2y6oEdHSGvom3runKXPLi3wrWJxra0ZKMxoWr2vQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB9168.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:569::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.15; Wed, 22 Jan
 2025 05:43:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 05:43:29 +0000
Message-ID: <a815c74a-8bb1-47f1-942c-aa0db5a79383@siemens.com>
Date: Wed, 22 Jan 2025 06:43:28 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Reminder: Xenomai community call on Wednesday, Jan. 22, 2025, UTC
 7:30 AM
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <PH7PR11MB7499F7DDE006A3A7291F61FAF27B2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499D816A0B79C85EF7CD712F2D62@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499161719AD2EC0D1651C48F2A42@PH7PR11MB7499.namprd11.prod.outlook.com>
 <DS0PR11MB7482106CBDA92B4A595D7363F2AA2@DS0PR11MB7482.namprd11.prod.outlook.com>
 <PH7PR11MB7499B238FF2BECBDD784752AF2B82@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749988D39A66B3EC8E9431E6F28E2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499BDD1032C1C09D4107EE7F29C2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499E15D2AD5555818A6E5C4F2462@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74993258CAA8CDDA598B287DF2542@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499E32BB1968236810DF6B3F25A2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74993347DB8F72364025EFEBF2282@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499E7C229D3943554AE31B6F23E2@PH7PR11MB7499.namprd11.prod.outlook.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <PH7PR11MB7499E7C229D3943554AE31B6F23E2@PH7PR11MB7499.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0176.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::45) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB9168:EE_
X-MS-Office365-Filtering-Correlation-Id: fe82bb87-7b10-4b31-7c4a-08dd3aa7b32a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUZjczN4bHdGdEVOdW44WGxEZUxvR3o0UThza3lUOVVGSFp1Sm0xbitUaWc5?=
 =?utf-8?B?YlpBaEdGOUFtb21PVkdGdXFKMC9DR3FaRVNNYTJrOGFYdlRudFQ3WUhKRjNG?=
 =?utf-8?B?L084Y0l5MWxUclJJSTkwcTZqc1ZaYlgzM0Q1T1RnVkNrT3ZZODlLOW1vWHNk?=
 =?utf-8?B?QmlNNU1RSGZLWnBVVGI0K2lycGNuQW55WEF5alVYdVUyaG9VcFg3Nmpla0lH?=
 =?utf-8?B?UENjU1QxSjZxODJlRGtUVXVwVTkrTXMxU2RPTndRSFhzRU9VVWVSNllOa0ZL?=
 =?utf-8?B?ZzhZL04yRGRIdFh3N1ZPcmJrOURUdmppOUlubUhGa204QWtVN3BLSWt1UjFo?=
 =?utf-8?B?cjB2Rit0S2VCMEtYRGNWanZDZSsrb3hZRnZNdEJ6NjVUTW5OWENoTGFDSEJL?=
 =?utf-8?B?N2lXNk5hNm9ldmU3UFROQi9LSmJxVlM0eGJQTGlhTnNPQndMQW03a3hQMm1j?=
 =?utf-8?B?MFVPT0RtUVpkSlVkK1NOVlFDa0tPKzRFanhQNit6aWxBWVozK1RyVldFV1BO?=
 =?utf-8?B?R1l5bHhVNjdwelFFNzZRNEFFTjVKbU91VERVRWQ4MVVZTWkrSnNhNThhMkxq?=
 =?utf-8?B?WFVMSSs0UnZaSkowV0NkWElxc1lHeUYzTitGam54d0c4cXFzMnltRFdmUWt6?=
 =?utf-8?B?MU96d1NwTFpSd3lqY201eUMwSks4Vm9aZU9jRUtEd3o0bEVObkxyVGQwNjdk?=
 =?utf-8?B?MUF2aHVhQkJNdDI0T25mL1p2UlNlQnhsSGs0bklYekxzMFh4MDlCaDdpNjRa?=
 =?utf-8?B?ZVRrQ2ZWQ2FxSmVMWk44RkVCYks2SWZFWHdvZHlUL3plSWVzM0ptNXJqYWRZ?=
 =?utf-8?B?K01TbEZSdktuUDJDYkUrR2k2R3lYMTZpNHBIUmh4YVp1eFFmQ3ZHd1pLeU9J?=
 =?utf-8?B?UkdoNnZjY3g1OXNKWGZrT1ZVUFR0SGFZYmdtaGRsUEhSL21XY3NvNkxTaG5W?=
 =?utf-8?B?N2pDeXVCekR3RktneHpSWlRBcnNsbUFHaFk2ZGZZSjBoWHZlUjZrTVVlV3Nm?=
 =?utf-8?B?RFVwS2QrTjR5cGZ2a1l2bGJmOFhzaTJaampGK3JiNG5aWXg2WkhnTXJFb3ls?=
 =?utf-8?B?dWNUNWRYS2F0Ykl2bGplMnpWQlBOV2RlMXNZcVhYRzNuY1VGSkZQdUVodWRj?=
 =?utf-8?B?NWRlRWhhRmJoanlLK3RNM045c3B6bE1VQ0pueGtrQ21INjhkOTltZzljRWwz?=
 =?utf-8?B?T3U1RC9QSVZoTUlteU5hUFR2dzdwM0xpZ3Vmb21tYjhGQUVmTXA1NDBwcXNv?=
 =?utf-8?B?eGRDYUoyME10T25BdldIQi9yZ2doclJyU1JJMStHcHR0TWNxT0VvYzZmMnJ4?=
 =?utf-8?B?SVFvNEY1S3I3bmJZeU9ESm9ubzk4UkNZWmd4VHZqNlR4Z1JDSkJEL0pJMjY4?=
 =?utf-8?B?SFFlVWxmODRLWUVhb2pQQkVCdERDcnB1NDU1bm0yQmcwVjFJNzBLT3ZDS24r?=
 =?utf-8?B?d3Ria3pKQ0xGYUV4Nk91OThKczcyOHZxTk05YTIxc2p2SlNrdmgwbGY4UEZV?=
 =?utf-8?B?czdabjZ6RStkby8rTzZvcC9WNG56QzdWVU45aFhmZDdOcTVPQ0d0ZkhObXBR?=
 =?utf-8?B?M2t1QTBLWmJhZ0ZEZ1lndXZSMmhVLzFNSC9Wd3Vrc1JseDZ5S3hMaEVTQ1VE?=
 =?utf-8?B?dkk0dG9Gb0xPbWtrbzM0UUozOGNKaVJsUFdlNVdOWW1NdkpQampQZkNDM3pq?=
 =?utf-8?B?cG9ERStvempvMHgwL2lYOGw5MTRWcEZrS2FqdXFRejR3ZndtSUc4TE1idit1?=
 =?utf-8?B?bmtRTVFEei82U2tFT3h1cUxZTVNjTWVOcE02NVMzR09GTEp5WS94R3d6L0du?=
 =?utf-8?B?ZnI0RDBzZXMvQ3RaOFc1Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDloQllhbjRwaGJlUjNZOFlDZDBwRmx4RGxTOHVtSm9Oem5yS1p1TUVFanZi?=
 =?utf-8?B?aEZySm9rYWs4N2lZZHBhWmlzTVROT0hjUlNHQitUaS9uejFxd0Q5T0ozTTlF?=
 =?utf-8?B?blc0QzVSZTAwK3lCUkpNQmVyVEhnTDBRMjlHbGoyV2l4NEk4ZktISk9Oaldu?=
 =?utf-8?B?MGYrQkFnQ1JMcER2SXVPQit6WWlDcGdVY0kyYmk0U1RWUmtIMUc2YzR4L2ll?=
 =?utf-8?B?UEdQQUdxZGwxNnJZSEwyMnVSM0Zib1NTdThXNmxZdjlwSS9JVmtJWCs0RmZm?=
 =?utf-8?B?elB6WCtkSTZVeWRJblpLaFQzM25BcWFJT25uQXpOd1JwWUNYMFNwd3NCNHc3?=
 =?utf-8?B?R01ZQnhIbytsWllyT1ZJRXdINkQ3eWJUcjNHWG9Ga2k5aWRNVmthcUhjVnpV?=
 =?utf-8?B?MXRvbUtiQ3dsMWdSOVM2WlJKWjRWbHkrVjhsM1AvMjhGNk93ZHdTczkwMWl3?=
 =?utf-8?B?SXNTRzU3bitLMllsOHIxYTFVK1FaZGJGMGxQQmxETzN5d2psR0RJMUtFSkJl?=
 =?utf-8?B?ekhDblFCZG0yNENudU5ldlNERUZKbHVNdTloVVoyR200eDE4M3dIYkpFbHFv?=
 =?utf-8?B?eTJ5V3NEZWxBdWc2Q05hY1dkVjZJcVR4bU8wUi93S2lFbFcwbmdrWnBObGJm?=
 =?utf-8?B?QW4xeGswOWMxUFRWVmN2SHJ5dzRKeGFDNUdGSGgydG9XT0k2b1dxSFN5R1dv?=
 =?utf-8?B?ZGd0SVlmbEptL2lyT0xGZ284ZTQ5QUc5aDZpa0tWb1VGeW05elpXOGNGcXJY?=
 =?utf-8?B?YXhINVkrQS9VdDU0c2NIa3ZoTE1FbmpCZHgzSVVvcWxGRlZLYmkvRTFwTGU5?=
 =?utf-8?B?UCtRTURQRUFYSU1FdUJCVXI2RGh3NUpOeDhobXFOaGRRYkh0bWk5dUsyZ0gv?=
 =?utf-8?B?Y0puc0dWMDlodVBZOUdNbW92MGJmd3hma3Iyc2RQeWE5dk1BeTE1M2NkWGpP?=
 =?utf-8?B?d1pjcy9KbVJtUWZkeFhBd0ZYUFlxYWVjeGhvN0Y2ZlRmSm8xUlIrOTg2cXBB?=
 =?utf-8?B?WjhDdjBka3ZQMEQ4VWNrTDVGcC9IWGN3eURBV2VCVjRrcWh5TzVjTDVJeFho?=
 =?utf-8?B?Tm5za2hzOWxJWGI4THl0L29zTjd2S2hpUlVvcHJSeG9IdzRwRm0yVGkyaEhR?=
 =?utf-8?B?emlIdU9CRWxFMzcrR3dLakJNU1JVdUZwZXlQSjU2Mk93NTZCRExYOGJ3U1ZJ?=
 =?utf-8?B?L2lUUFRnM3dWSjQ5TXV4OFJMSFBLaXc5ZXRpeDBXZkFvbllydWZHNEE0ME10?=
 =?utf-8?B?dDFOZGEyL2hXTjdGRDVZKzkrU1M1L1JJTklxbU0vQzJ5QzZkSTA0Z0dXTFVC?=
 =?utf-8?B?VHFGZUovb1F5ZVJHVnU3VDFoa0FrSzJJeWhpWXdsckdQa1J4ak1naFhRdHRS?=
 =?utf-8?B?YTNoU21YcEdxaStDd3JBQTJnQVFCa3VpRmdjaWdOcDVNZzRiME1WSVQvaXls?=
 =?utf-8?B?cE41elRXd0Z4SDh2Q083SHFDQ01lSzVpcWliOERSdU1ubzY4SVl5SjA1UkxJ?=
 =?utf-8?B?UjlqMjFMS0ZQV3pUYlZadzgvNjNjRkN5dnE0QXdzelhoZGZmeDlyN1Q1aTYv?=
 =?utf-8?B?RTdIc0hsdW9uSk51WVAweEVwaXlKRmY4N1lyV1RMdHZpZVZuaTVLd0pMd0Nw?=
 =?utf-8?B?bG0xZmp2Uk0wU2JYRThpdFBFZU9YczNDa21EVkdNaFYrOWFLQUNkSHpQZW1B?=
 =?utf-8?B?QklOUDByYklvbW1mek1ZdEYvcmErQis5VS9raVRTaHFPMG5nbVlTVXkrR1U0?=
 =?utf-8?B?YnFZOG41WlcrNUY4ODRRZVBGWFA4b0ZDMDRRKzl1OG9yMHkydExCdWlsVm9w?=
 =?utf-8?B?YUpNSGo4NGFHVXpWVzJoNGtubzhlelNZNmdlUW1uUFliWW41OWFBUmg0NVA1?=
 =?utf-8?B?QmpZMzM0c3Z1VmVsZ05RcG5yVDJHM1N0SDdjZWRRSEp1cElVMHlPK0N2dUZD?=
 =?utf-8?B?dHUrVlgrY1RvaHlHOFpzcVhpanJheEpiL3VWMTQxYlZRNlQ0MmlBYzBFMXRE?=
 =?utf-8?B?Mi9qZFNzNmt5eXFjNis2ck1QTmd4VkdIRFFTbzBvNmRWY0YwRWU4VjZZY0lR?=
 =?utf-8?B?UlBYNGNGR1phT2pZNGErQno3TDkvenNJSlJVL0FPS2YvMDhYdWdVQzl4ckoy?=
 =?utf-8?B?cFk5b0Q2TTZ6NGhXV0RaUmZNaTJLeHdoZ0YvbFVkSDZaaXBrMUd3Q3MzZVhW?=
 =?utf-8?B?V3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe82bb87-7b10-4b31-7c4a-08dd3aa7b32a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 05:43:29.7447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T3pt7B5tk+z6SIc+aZFPwNBbk+94bGbaj/WWXX+lMqn3t7qdYt5NuuruFVxxCsqEjK3JUnVLBBZBokK7uoJ6pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9168

Topics may include but are not limited to upstream/downstream project 
plans, status updates, and technical discussions. It's an open online 
meeting that anyone can join and ask questions.

Time:
Wednesday, Jan.22, 2025, UTC 7:30 AM
Paris, France CEST 8:30 AM
China CST 3:30 PM

Join Zoom Meeting https://intel.zoom.us/j/91297279269?pwd=WmdwS0pDODRNMS9tQk54Y1dvbFlqUT09
Or
https://intel.zoom.us/wc/join/91297279269?wpk=wcpk52a9f96d989e7e20b628c2c36e48b68e

Meeting ID: 912 9727 9269
Passcode: 367528

Best regards,
Jan

PS: Hongzhan will open the call for us but won't be able to participate.
