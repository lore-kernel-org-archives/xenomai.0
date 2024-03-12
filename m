Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2074.outbound.protection.outlook.com [40.107.20.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C9B6996F
	for <xenomai@lists.linux.dev>; Tue, 12 Mar 2024 07:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710230402; cv=fail; b=POKddC8mnIl46Jirj4bOWAJ/rZ/7+R5g2OaffDbxFbqxIE5q61nx+o+21cijq9FSNtBpFMgDb6l1WxkwWiILzfd5lXPgAlyV9pW9aZpIQeUh359UqlbwdseLenS+DD+wY21jRCotYNt8PqDt6Nf4vq0t8xjZxVD+sEmJ4HMGD1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710230402; c=relaxed/simple;
	bh=R+oppHHI059/JVkPd5boLG8RKJs36pyxpKTS7If8aHA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kmZi4ggN4KYowjT8eOiaV7rAv+Mb3MB9Q1BpHwOc6U0N+5VBMZASsuFiF/iT5JCircjKwGlWcT41GZ6OSYOp0Xt6ZZo8SJOHBOUe60dQHpEdfs4AnCWgMQL+iQpxnN9KmG9zrzdC55F7SzxOew+n7uWIYi9qW6ZO8EG6Tiexzw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=hN2dnIYD; arc=fail smtp.client-ip=40.107.20.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="hN2dnIYD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMLqjPSuWFZ9CssJrXTM9JzpwI7TFQdQ0TBmdwIVTJPI5x8rYhGI3T1mHFA4p4sPzq4jyCKUGKsKpj2X306yb85dLiLR7EfZUDg4//5WEXunJ6ErZqreT4iIKnijTtBzTPM6XLxqKL6Q6VoBILYG7HOGZCiLURX0+6x/k/z1BdcZtod+LCLqudQXdWJfkqou6ovm9dJScFpbRMsgixyYFZv1Ss2DwHIWI9CjNfV7qEN2FUbyIO8TGeM1fJqJqwNbTb+mObV3CROB3+s/XJ02n+WSvxOGQNEUfssWKcoqV+IwdlaFB4RIobGxv6RFO6o85N4ceJ89sSopSQ5q2ZJDPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwzVq02pDK12cisQi8iCUXW1hGM8Arv056pqnJiBJT8=;
 b=I/5yEsKSS4ZgQ9AjiG4w5SiJG/SRbCKJIenKc4ahnr+gM2aot4hjVhIUxkxfRSTFn4+fcM7rC6JncT0+htHXHhci3OWqNSx+a93trDUWQ9xS+Ca2yl5JzUm97Lsfe/A2RxwJcaF6U8hhOTd9sg1u++nV4ewHo/y0Xt50Jm+zpBT4EJzk59S8NSe85q596Q0iMg0A17TFkswuf3iIm2EI4QdZ8kVDFn793NaF/N6nkzfVtEkzQVM6BxDeXkESxmRAz9sjGSn/9UBXiKs2YocmY6lFH/Es8eE/ZW453A5nNcAbpp6XOphxOXOhE6g54iOCYB7n3K4FragucyKNW5Tzmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwzVq02pDK12cisQi8iCUXW1hGM8Arv056pqnJiBJT8=;
 b=hN2dnIYDGSWFa73Llbyy1WCIfT4AoHLVHuZXhjMC2UU3ZmuwyT1/IR3VjAJ6Av9orp9+ggXcdrERqmsZe5IL5rLJzgDiJ1O1hPRgFH+tO6JUL2kbcPDBRctkhHdbO7M0iP3/W/On6QBgp7qOu6H96jVKksFqDLGb2ppRZUKMjgfB8JzCbUkEm8IOnZJuMLnAq1dCyBnZIj9lY2Ef8A31b8w6mUsF7IIyHv+1mtukoUb8FyDp90Jy5awFKlFxLnqDG+pqRuMmgjJoi6PiAU4D0Ui4yfPjcH19BZKAV/Mxp6UBcq7fe5SeGFpW+GfR2k7eUsfCH+NdjYhP88m9cpe8vA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from VI1PR10MB7672.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1c3::21)
 by GV1PR10MB6444.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:80::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 07:59:56 +0000
Received: from VI1PR10MB7672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d884:a30c:ee37:5cb9]) by VI1PR10MB7672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d884:a30c:ee37:5cb9%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 07:59:56 +0000
Message-ID: <521f0364-dfcd-4467-ac41-a7e2645674a4@siemens.com>
Date: Tue, 12 Mar 2024 08:59:54 +0100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] testsuite/smokey/gdb: Fix race-condition
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20240312063813.27021-1-Fabian.Scheler@siemens.com>
 <2cf397da0544e3be7ffd6abd8166e998804c9fa3.camel@siemens.com>
From: "Scheler, Fabian (T CED SES-DE)" <Fabian.Scheler@siemens.com>
In-Reply-To: <2cf397da0544e3be7ffd6abd8166e998804c9fa3.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0181.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::8) To VI1PR10MB7672.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:1c3::21)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR10MB7672:EE_|GV1PR10MB6444:EE_
X-MS-Office365-Filtering-Correlation-Id: ea7a0d99-915e-4b00-a6e0-08dc426a6824
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qwnZfv04GCUSV7ubpQeSxTV+53tINB/K0EgIVML1k4OJWp0RxgEOUMxXFYhGEcqp5L+SFoZAm1+QUHrK6qxChZSJPaM1VZrInr9iSdKtvHWP4P0XeUdKWXKpWoqF8lglftWcFJVBXMGGEXC1Kni3Mj12y9EYWpulMDAwxJiH2mrzCdrGBKnQn95YQ7rHVCUJ+KQ17HBb8bFe9A4oQEMbzFTYutIRQfsMWFGYOGstfUnLYghxqVxqPZQO4m6H/q1jY3vuFHTdKbqBQmAoePYZmixWfAX2QOijGj7zRrwhFhk14cYO4WAAhKG6LaSGxkBiH4TBCOsWC6dEtRmJJpZKTG/1lKizOZhV8xZpYAkPJHXtcDOoJiUE5WseRV1/4iq7eXNYirGzloC9MtVoFtYbGSzuic9DK1O8qw0zHOLBy53L71eOeB+crwKXKCGnmBzKYcqY2cbQba+gZc4Ob4KGmqFUvz6kQZbPLitsG1scdsYwF3+6cEalYX5VR9Z8liV2ABzTV0X0HICCAYJXelh/GpKoGK4FCy/ud6KqhWtjsHS5bA1T0J0aksoASOoggL+uRsNBq0QFMgeO6cs6sJk/bajHWxWpfPLGlqlXTzLvNmA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB7672.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjkreXpmdU05OGpHT1JKdFNZK2JSOWRmQ0trNGpsSHVmYis0ZFRaK3ZkRCsy?=
 =?utf-8?B?VDBTWXQ1Q21jblRVMzcvcnh5TlJvaURkV1psRk45K2UzOTVSQkR2bDRpMjV4?=
 =?utf-8?B?VmN0c3NtMENkTnVra01nNlBlRm5DT3JVMUlheUlxS1FQd0tWalpUTEVWYkNj?=
 =?utf-8?B?aGpVa0xweDlJdGp6aStmeUFZckNUMWtERnZmbzhqbEFmcTRDcGhhMmhQM3Y2?=
 =?utf-8?B?WDFKZjN1Rm92TDA0WU4rQ3VwMnhYR3FucHJxZjhzRnRIZkhWdndWWGdSajY4?=
 =?utf-8?B?S0RsZXlMVCt6LzdwTkEzL0hUQUxoVmlJZElmam5KMG5BUWpRbDh5alZWTHYx?=
 =?utf-8?B?NkN2K0xWdWNIajkvWXlmWkJmRzVEZ1JuYnEzOEZnZXU0NTJpV3paTGpJeVNB?=
 =?utf-8?B?LzNWd2l2cHU0dXdGUnI2dU9RbFJ3ZVdJVThmcHZNT0J1MHRXcjdVVUZncksx?=
 =?utf-8?B?ZFllOEtDMnlmaG5XRWs3dTgxUkhwNFhON3hzRlQ0ZFhCVFgwYmE1WmtXb0Fw?=
 =?utf-8?B?WDhQUm9NQ2x3QVZWT28yTkZZV0lHQ3NyN3VDTjZ4dDV6RmJxVGY1WTlDMVBE?=
 =?utf-8?B?dVdsRW85cThWeC91VStmSmlxVjJoWGZBWHorMXQ4TVZXYWZvSmUrLzV6NXFD?=
 =?utf-8?B?UEcyZjNGeGNhNWVTaEw3NThIMkJDd3A5eXdMTmZEemxKbTZKZEhhbENYZXcz?=
 =?utf-8?B?R1Fycm1rSStubEg5K0hwNldONDFUTmtxYkJaSStObFl0anM1R294UzNEcWlS?=
 =?utf-8?B?YzN2ZmdkTEhDNWcwdWk1Rnd6UC9vbVhsd3pIdjBOT0VzVnA5YW9hWnY1MWZi?=
 =?utf-8?B?d3doOGVpSTNXK0RLUkk4SVB6RDdvMXlNVHU0SW03NlFyMnpzRTdrVGl0VkYv?=
 =?utf-8?B?b01QU2NEdmd6TmVScDhrQ1NOdjVpWE8vcDJWRGFWanc0cytxR1ArNi9WSE5H?=
 =?utf-8?B?YUM4RldWSW1XSXphYXJhVUE2SUZHQ0RJU2hOa2xRZW9jQWtXK3BsNHJWcHR2?=
 =?utf-8?B?UkhlblRNSTZiYTQ0YnRSeHVUOGx1WHJ6OUFVbzVVNUhER0ZSeWxkOWRMMDIr?=
 =?utf-8?B?MWdWMWhqa2VrQkdiQk9tVllvUmV1OTJrYkVhbm9BS1VZdnlQV0RWNGlYb3VX?=
 =?utf-8?B?aElBNk5WMDRmU1JnZzlwNy9OdTJuVkVmTytLSlJVSEM1UzliZ2hrUmFESWNT?=
 =?utf-8?B?b1JST3J1U056b09EOFFmam5UNzJ1UzVwYXBTR3lOSTNsY3BpdkxMZFRRR1ZH?=
 =?utf-8?B?Tkl4VVpTUkdsTlVJQmV1SDMrYVBYc05sRXlaWHBsZk1FV3YwMm1zei9kOEE2?=
 =?utf-8?B?bmlSSkw2RUVyZXFNTGlXck9kL0tleFpKZnRNcGx1QVRFTFRMbXpUWEY0TWUw?=
 =?utf-8?B?eDlsNTN3RXU2K1pKUnhOZzl2aWpmdkZOeTAzMFZ3RnJqYTFMVmxYbXY1VHN2?=
 =?utf-8?B?dGhOTjg0azVsVGNlQ1FOT2YwMmZlTHFCM28xK0l4MDVDajAxRVVjQ2dmRlFI?=
 =?utf-8?B?c2s4N29uZE1hdEdFemFHWmgrNlEyNFRYWEJmU21nYzFFNjFsUzl0Q1gzZmhO?=
 =?utf-8?B?MkNIaEhvOG5mM2dzT09ZV3cyMnlQeEpZSll4d0ttZi9lOE1wajZ5YWliK0or?=
 =?utf-8?B?M0l5MkZyNldiaXFzVSt5UWphb2tndkhaUDZmSGswQkV4L2tDVENKWWJhbkg5?=
 =?utf-8?B?ZzBGY2FmejlwOFJJZE5uQjF3ZVE3cGlOa2hrM2hrOEVHckx2Z0tOdFJiaU5w?=
 =?utf-8?B?LytCNnZPNUR5M1h2aWppZ0xoK3p6U2hZM0dIeVlhOUtqMGsvUUp6b1l2VjdY?=
 =?utf-8?B?L1JkbjcrcTVUcjhCRWRRRkJaUEpZbk9OYnFiL1Nvc3Q4cmtGdGVYcktKYTBy?=
 =?utf-8?B?WGNFdUc1RVdwTTdBTXVkQ0ZlSFNhelZoajFycDlXSElwQkJpR240ZVR2SHVR?=
 =?utf-8?B?U09VM2NMWmhMNThHMnp1Zy9FNCsxRndSbW9VdStUczhzQ1RLZ3djRGhpaEEy?=
 =?utf-8?B?WXNPdmdlbW1YK3d4SDBwWUZ3MXJ5ZDNvTWZmVWgxT0VhUHdQSlZFcHFsKzFK?=
 =?utf-8?B?RFl3K2h5R2xEVzZpT2p2Y000UW1JemxOUlYzWk05UmEzN0xqYWUvakk0ZGcw?=
 =?utf-8?B?T2RWTEZDeU9Qek8rMFdIQVZhVzEvK21kdm5hd01rTXhkdTlMVm5udUt1ZG1v?=
 =?utf-8?B?Ymc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea7a0d99-915e-4b00-a6e0-08dc426a6824
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB7672.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 07:59:56.1986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yl/gL69t0rWak93ZKHkwgxYONzOT6/SUhu4XqA5HM4cG/MKFzP1c70OjLxnR2mpL/9b8McqznkpIeLNyzMGC75dqSPXBo7n49dzLsRl1uwg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6444

Hi Florian,

Am 12.03.2024 um 08:48 schrieb Florian Bezdeka:
> Hi Fabian,
> 
> 
> On Tue, 2024-03-12 at 07:38 +0100, Fabian Scheler wrote:
>> @@ -283,8 +285,14 @@ static int run_gdb(struct smokey_test *t, int argc, char *const argv[])
>>   
>>   		default:
>>   			wait_for_pattern("(gdb) ");
>> +
>> +			/* the signal handler only is used to skip the test if
>> +			   gdb is missing */
>>   			if (child_terminated)
>>   				break;
>> +                        else
> 
> Formatting: ^^^^^^^ Spaces vs tabs.

thanks!

Ciao
Fabian

> 
>> +				signal(SIGCHLD, SIG_DFL);
>> +
>>   			send_command("b breakpoint_target\n", 1);
>>   			send_command("r\n", 1);
> 
> Best regards,
> Florian

-- 
With best regards,
Dr. Fabian Scheler

Siemens AG
T CED EDC-DE
Hertha-Sponer-Weg 3
91058 Erlangen, Germany
Phone: +49 (1522) 1702973
Mobile: +49 (1522) 1702973
mailto:fabian.scheler@siemens.com
www.siemens.com

Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Jim 
Hagemann Snabe; Managing Board: Roland Busch, Chairman, President and 
Chief Executive Officer; Cedrik Neike, Matthias Rebellius, Ralf P. 
Thomas, Judith Wiese; Registered offices: Berlin and Munich, Germany; 
Commercial registries: Berlin-Charlottenburg, HRB 12300, Munich, HRB 
6684; WEEE-Reg.-No. DE 23691322

