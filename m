Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013057.outbound.protection.outlook.com [40.107.159.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C0A29CF2
	for <xenomai@lists.linux.dev>; Wed, 27 Nov 2024 05:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732684757; cv=fail; b=RLa2R0rNJe90zJjkmaB5GRNBj3TFf/kaxxwJnRf8t9SedgkudP2G4J8pLMESFKon+WC4kf+DKB2l0g0fv80O7MgyzK9Y6irBNZUsp/67yVNdhjRoGqAF2ZRFNC0yz52Pc6g/xbjhJ3aF43a+KIaMXG/PbAc2r9HlmxDxlFn0k0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732684757; c=relaxed/simple;
	bh=qtotxq/dZqoDWu3QJ3MfAQULUMtBQfRircWxWVva4vo=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IEP+PdgKqs9CmcXmCe14F2IG7ciAOIvJQ/43SPs+stqVgg7At9FKJqQZmZRvFEHOkhXuszdwFB39UGN5nniLqEXDMCiSovTRa5pfXwImHfInYknY1WRTHJ9405GuinpV/TBMBMqvcb8FY7VyJQGxRsWHcGZnwe1XMS4SW1WQdnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=f9sEpL4T; arc=fail smtp.client-ip=40.107.159.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="f9sEpL4T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Irw2TTnLvBJ2OG2ObOVHQx1unVJ27Jbm7b81OlpAOf/B31/P20Chm8Cku7BFkxe+w32Fi+HxqJEwz7wdrt9vW4eWtmQRnMeftaQJDxYE7anwlM8l1YtoVrZwelntPRa0oedaUa5B1ZTIG1NdjAVmvkI4G+21MW5dWLwzKW1aSrZKf97RRLZT1OVydyUeC9KU7GiWngHrPf/omEb4MgCMSQsR+Ihj0wposCg2BNIrIxG9B3SOslZksE1HPPUtrmR7idH5HaW/fWFt3Vv4Z/zctqcO0JrWtzdTRxfZjtTumSum15xCSjBcg9rGl3KyDSBconzzNIYXSUi3ROKUdRkljQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WaTL729cLvigpov8ZOnpmEpusJg9f3zCpswyL5OOZuw=;
 b=wCjF+LZCy0B1mw0N159wjhSxUgRFeeqZo93HHu1mKfjhRMzRp4mmXwdZdY1AppjlkJ8p8SXxQjCZwxtU9hVtFVCpI5eh/N5S0NK3R0Nj3ZLi2Di5jQB4jfeLloHaj04nAsM1BnIgJ06r6d4EgUcs2x2k//+Ze6oBz9SZKOP4ZfD54aqXPQtSQX1PoglMo57QQrUMIc9HgbbU3RrWU8yijhs81LQmpbacivldJNKugNc6abCNmOsm4gOefNFNzwksgzuDFTQYxNVl4bIjqiUJrMgfANCZeSGJ1b/o4CkIgpx8r5O22tt4qTLXTY5yF1nWIwIuHyI51oPF5IkUZ/WedA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WaTL729cLvigpov8ZOnpmEpusJg9f3zCpswyL5OOZuw=;
 b=f9sEpL4TJ5w8xbuFvSNZgqzrWkWXEDX5rhYBgyf8qQtoMEMb21/5jTviqEP7FDRfKn4gAzzMQRz/svvL6M1MUlOi/8A4nHCOaAlkhVfrsnXWNWZHLEpf5MJOG6NZYrZwij8ef+hZIUz5OlbdVhBFLLmmK7Km+noH6JTQWJzx6Ph42UtIpvvDgZnsmvAQFIpu15TWBsGaq3QGLBapE4j7LaO1Z7LrhcKBTWMI0jAerhjFv8Ph1s8shlCGXsk+Eq581H0gstoWluS2W9Cxa018yl4LgaBxX06aXw5sP6D56oD4xuJMv0AsdUgNVRbexQTa71vlUft1+e38Iwjp/iFRxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6749.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.12; Wed, 27 Nov
 2024 05:19:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8207.009; Wed, 27 Nov 2024
 05:19:12 +0000
Message-ID: <042426bf-84a9-4801-a67a-a2e61aef0b35@siemens.com>
Date: Wed, 27 Nov 2024 13:19:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: Xenomai community call on Wednesday, Nov 27, 2024, UTC 7:30 AM
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <PH7PR11MB7499F7DDE006A3A7291F61FAF27B2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74993A52AA247D08069980E4F2F22@PH7PR11MB7499.namprd11.prod.outlook.com>
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
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <PH7PR11MB74993347DB8F72364025EFEBF2282@PH7PR11MB7499.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0035.eurprd03.prod.outlook.com
 (2603:10a6:208:14::48) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6749:EE_
X-MS-Office365-Filtering-Correlation-Id: 61ae523c-04d1-475c-4ce3-08dd0ea30725
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1NpVS9XV3I4ZFlQVGo2N3p4K0V3NTFKNit1QlloVzRLOEVLOGd5TG8rbW1s?=
 =?utf-8?B?SGpSVjVGTG9QNVRrbmU3YnRLNTQrSkhqbnk3anBDZzZERDliK2V0WjlSc21l?=
 =?utf-8?B?YUc0RjlnUnE4dC9lUnBnOEluUXlvakhrNUd4MWhNMUNKTjVUaVJRR0g5ZTJt?=
 =?utf-8?B?VlNwWnZMZk5RZzkrM29maWNkV1lGc0k1eXhvVCt2bFc2dVMyVHBOdysrZEh1?=
 =?utf-8?B?enBLNG0yc3ZrbnBBWTY1aFMwdWVSdU05NnB1S0Y2MFRUZTZhR0lOY0tySWFU?=
 =?utf-8?B?dUJpdThVVVFKYkxZQndXbGtEYVhZb3pLL3JpM0lFRU5WSVFETTNlamo2OUpO?=
 =?utf-8?B?NTBKNVBPc1cyeTFDSU15cTFSeGhvVHdkVC9KWkRZdm5wS3Z3bzhiU05JQ01u?=
 =?utf-8?B?MWpUUU1neGxhYmpNWkp3UmlKWFoxRW1Md0dta0NoV2NiRXpNSDNOdUxyb0pP?=
 =?utf-8?B?bkZUTnJIVThOSjUvQ0FGVzVDa3Z0MFZybWN4RC95dFF5dWVOdy96QXdqR0pl?=
 =?utf-8?B?SEQ4Q1B5S0drbzdiRG16SE05SXk3SnRrb0o4anhnVHhpcjZnTG40TDgyaldL?=
 =?utf-8?B?OEswbk5OenhWRi81UU1JcHVmTExTUHpWVHlENDJmQlNJQ0pXL3lqeFF2LzUv?=
 =?utf-8?B?WWlBQUcvVFNQVnNxVjQ5NGNaci8zRnFBK1NGR2FGTFN3NkdvWlFRNEROVG9R?=
 =?utf-8?B?bXh5TzJMWjgzd2Z2a0FQVjR6RUZLYlAySWlxQ29DWk15Yml5RWxvWEIvWkZ1?=
 =?utf-8?B?Q21IMkIyQktlN0k2eFNGUE1sVUViMzVoNjRXZW5BN05BQVBlZTBjaHZ4N3Fs?=
 =?utf-8?B?aXVIQTBXUEdCMkVRSHc2K1d0QUNCVlJ3S2lIRW4wUitKQ2wrNFF1amhRYlZV?=
 =?utf-8?B?WG1rUExLc2p1VEt2WW4rSllsR1FvMUl5MHlCZEpVVmYyWWF2eHV5TDRrQnR5?=
 =?utf-8?B?U0djZmFvYnNQT21XbDdrYW5YOFpFQjkxUytXMVVYQURHQU5vNWVxbjRuRC9X?=
 =?utf-8?B?UXpuUkZqNmpIY2NQcXRwVUtLRk9SUFdZbG8wSkxwN0tIQXM4djhHUDFJWHpu?=
 =?utf-8?B?MEc5Qk5rZVBwYk9ROVdwMnArbTB0bG5mNVdvbVlFREU1MFZpRTRYOEs1VVIy?=
 =?utf-8?B?aDJZaGhOSFRRaXlvUm4zaE9RSnpQblZ4RDVzNlMrSVhjYXVDWkF3K3lvL2Ri?=
 =?utf-8?B?dkpHY283bGVRYW4yQmpMU1V3aGtvdkJaL2pTcnZEM05EZ1o0Z1A0QnBUeFNO?=
 =?utf-8?B?eHBwc3E1Q0p6c1pFTVRjVjJyZGNBQ0w1UCtuOGN0bjFZckx3Ymt2UlFVdHVC?=
 =?utf-8?B?QkM3dkJNZ0FXMmJDbERwZ2JXTEI0d0UzNEpzQnorNTI2OWhaUDhjaUVsMGsv?=
 =?utf-8?B?Yk95ZEhWUmg3a2l3d2ZuQ0VRZHJpeEVZUHBjQ0o1cjFCMktXYnkwZ1NoRkFU?=
 =?utf-8?B?bnRsT2lJbXR1NkFDLzNXVE1lbUZPbXR4cHgrbWl3d2lWSmc0Wm5SeXkyVDVq?=
 =?utf-8?B?cnRVV09DQk9wMDhFRVE3SnhRbzlUOGcwL0JDTnN4RHdMNnNZbmM3L0o4UEE1?=
 =?utf-8?B?cGNNclkrQUNEanpMcnhMbERCUFM5a0FFK2pBSE1xdTZCUUlGdU9OQTJNaXVt?=
 =?utf-8?B?Tjh0aTJaOHdyZlRnVkRrRG4wWG11NlJPakJ4SW1QSlM1Z0FsdlNodXFiNUl2?=
 =?utf-8?B?TUNmOTczaEhFK1ZBSGduS3FmeEtiN2twUlVVSGE4d3NZVFA1R3hHT0tJQ05E?=
 =?utf-8?Q?/x8Zqhs1+vUCUTXzrE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFFYQVc5cVJFNkRaYSt5T1daMyttOGZmaG1QMWlkNUE2TVNtSGJ5Vyt0Z2Jn?=
 =?utf-8?B?VzQzc3dURjJWdjFDSjNMWXdpY1pIeGM0WTlKTDdGR0hRRHRUTFpUR1VhNzRL?=
 =?utf-8?B?V09RZkxZUE5KTCs1ZUVrdk1RRitjU0xVTXNRRVUwWnZNaXBDMk1ZN0xPaXpp?=
 =?utf-8?B?Zitsb0RQaW44R2VBaHRsS0h6MVp0WFZ2MEliMURHcXlZbHhOYklLelJNWVow?=
 =?utf-8?B?UDJKRVRrR0RjY1FIVG82MjJVMkZRMVlHZEc1S0gzdGJWZzk0aW1sN3o4ZFY1?=
 =?utf-8?B?TEZuZTlIVEx4V2h0czlyYk96KzBDTnlzdWN1RThQYlQwZk9KcEJTaWlKZFB3?=
 =?utf-8?B?K0dvNEVXQXVXc01ydUZzbkVZZVVmYlp1eHZsTG9IMGQ4amF3akhibUxxcTFr?=
 =?utf-8?B?MGtVUmRhZThxS0NSeXZpSk4xc00ya3Nnand3NHNYd2NjdHpTaEp0dWNtOGg5?=
 =?utf-8?B?a1A4L0orclVoTXNDendGMmtkRjdWS0txUWoxS0JKNWJRZ3JuaXVzeUhwS1N5?=
 =?utf-8?B?dFpEVmVpa3VSdy9DWXRKQ3U1cUVuYUFlNFZ5Y1F1MGY5R1hhQWpZY0NON05H?=
 =?utf-8?B?ZHh6QU8wTjZuQkZpZTZObS93V3FhdGZ1QjlwMHlrUWI2cmhnSmM2b0lrQmRM?=
 =?utf-8?B?ckR1OUlsRGg0TWc0T1ROTUxvS09SVGlXTUpsbDhxY016MEdCMk5MYU5iSE92?=
 =?utf-8?B?NVozbnEwREMyUmRGK1pyYUQva0lBWWI3RjBzeDYyY1RkUW9IN3JMTGp5WWJ0?=
 =?utf-8?B?NDYvdVFmNEZ6WE5CclNDbGFJZER6QkJ1Z2tQck5wSkZheEpUUXc0VFFvOHJV?=
 =?utf-8?B?SE4yOCtaSjhMS1Y0WU5rV0ErbEdsanh0TGw5aXl5RTdYL1dBZkV5NnhFTWlO?=
 =?utf-8?B?UFVOcnlhNXE3N0t5dTlRa2cvWUQzQUo5T3lqanBPdTNWdEQwZDVONThRSU1B?=
 =?utf-8?B?RmlLOVdFVktBOTkwRFA1YWYxdW0yd2d3MWhGNk8xeXpTeEQ1R3dkOFFzZXlR?=
 =?utf-8?B?SEZPcHRWUHFQTDd4aHFRUzBJeVNzMnd5VnV6VDV2eSswQ0lKTDhqZ3F5ZEow?=
 =?utf-8?B?aWEyNEdVczV6MngrNzVFT080enVEQS8xOVp5bFhFak5jUElmTEErSlVGdEU0?=
 =?utf-8?B?U05FQUVNWCtyYllGMFNRcG11RmI0SkxlK3lIZ2dReVdpQk11dmhucnI1d3BE?=
 =?utf-8?B?NXZGUVY4UG12NUxNNzkvZ2tPeUFtNGN4M1hRT3A0c3Z2SGdYRlZwRGVqN2dY?=
 =?utf-8?B?Q1JvM0o5aDRBaXI2YXR3UTVnS1QxVnMxSGptNmJycHUwRER5LzBhWVlNbmpG?=
 =?utf-8?B?U2ZNR3M5QmVmZFlEOWorTGI5OW13bTMxdFdudVdobjRLZENJMG5PNFFSOWIr?=
 =?utf-8?B?OXdOa3pNYmNmMFhKUnRiaGdTd1o4Z0R3UStNQlAxOHM2cUNCcThJNUxxMW5S?=
 =?utf-8?B?ZWM1dUU1dm9DSWw5TEMxTis4c29tOWp1TkFGUDRyNGxyVitzcFJJeGpUUkdj?=
 =?utf-8?B?cGdoK202M2hMWGw3amo1bDdsQTk1a1VuUTdhclh1VGxrMFZRdGV4YkpSSXdM?=
 =?utf-8?B?YXcrUU04MUJOZUE3U0RucVFaUUVnUXJEelYxRGZKVG5wNVBRTmh0WHdiUmdJ?=
 =?utf-8?B?dmdWNVpGbFgwVjNwVnlSSHZuTG9PTVhHK3ZMRFRMbE1YaTlJcUtTRUkzNTBC?=
 =?utf-8?B?dC9RMGtDN25qQytBUmtmd3hBYk53djJ2YUthL2ZhTlZxV2o1MzBodzRocUEz?=
 =?utf-8?B?MUh6K1BsalpmVmg5eVpYMm5tM2RyK0JROEExZ1pFSkM2UFFiTG1YeEJmMDF6?=
 =?utf-8?B?cmw0SFNDWldVbnN0VndpeVl0NjZFNXU2aEZiNE9LanIyTGp2aWRrY0hLTmk1?=
 =?utf-8?B?YnpkYUsvV2thczhyK1pqU21CL1JxcWJHaXB2M1hBdzhDOTdON0cxcDlpa2or?=
 =?utf-8?B?SXlUTVhiVEpDaFF1RFd6OGkvb3JYSkRQSkpBcjlITE5rRDJtRU1uTmMzU09l?=
 =?utf-8?B?dTNYZDl4ajVtT1ZQaC9ERDlNMExmQ1B4NDVDeHF6UTE1U1VRZkdiM25ZVDI3?=
 =?utf-8?B?NEl1V2J2R3lzSGhySUwrY2U5RnBjRFg4c09WTjhBSzJKTnFjem1KUHVaNWRL?=
 =?utf-8?Q?3DBgzptFRqiw4RQ6SIPsKKIUZ?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ae523c-04d1-475c-4ce3-08dd0ea30725
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 05:19:11.9798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SsOYltirkwvyMJIdUxb6g/BxiIVJFJeM7mpc38wzGmp+L+YemnhjJKUw5U47U9ucHEzd/lGibz7laX9/Hq80WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6749

On 27.11.24 10:39, Chen, Hongzhan wrote:
> Topics may include but are not limited to upstream/downstream project 
> plans, status updates, and technical discussions. It's an open online 
> meeting that anyone can join and ask questions.
> 
> Time:
> Wednesday, Nov 27, 2024, UTC 7:30 AM
> Paris, France CEST 8:30 AM
> China CST 3:30 PM
> 
> Join Zoom Meeting 
> https://intel.zoom.us/j/91297279269?pwd=WmdwS0pDODRNMS9tQk54Y1dvbFlqUT09
> Or
> https://intel.zoom.us/wc/join/91297279269?wpk=wcpk52a9f96d989e7e20b628c2c36e48b68e
> 
> Meeting ID: 912 9727 9269
> Passcode: 367528
> 

I'm traveling on a fast train, my connection may be bad - let's see...

Jan

-- 
Siemens AG, Technology
Linux Expert Center
