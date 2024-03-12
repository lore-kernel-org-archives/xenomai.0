Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2044.outbound.protection.outlook.com [40.107.105.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E126B69D01
	for <xenomai@lists.linux.dev>; Tue, 12 Mar 2024 08:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710232195; cv=fail; b=rhi9E5Pk5EFME2ho7uEdVvH/IA+FCEFxoDmX7bGV+nFuVDzo9lsFW2oC4iioARCuwdhz3DXC5TYQE8qOY5Pqn8nNFYLg7Cs1ATsGdeojKv1c7u0x8PtmjojeSkXr7OcPDmPiUuxLl1fa4qslHjaBre39r2fqb07iPnIlMIDAe5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710232195; c=relaxed/simple;
	bh=QhwYvFAf6skXnrPNL6PwQ0TUXvKFcRaJ7tdi2VXxpak=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JXk97+LEIHb27CAdVC6HzoI5vKH4wopAY3xLUKQ2MgkIFNj41hA3LQYrYOwTZ6zvC5bE8mwgpWZP6EXcmDeFeJ/rfWBnwSRVMXWTR3QukiBja2+ciaJoLnG1ShiKQQAOBXdMf2Yno3bFP8EQMjb90s7EIL+1iMFn4HJf/85AL44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=hOEi2P1W; arc=fail smtp.client-ip=40.107.105.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="hOEi2P1W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIjCNKrkNKbGSkYlGzYPZwsc4uGA1QDtM2lO7xWPGQ2n+0x/enXL+gyf9OA0Gg1honpAnx+O5Yo8QLiQXWHbtOMQP95qScsUjfz1QKAh1nMB0JlaO22WGZcrv0mk22wM9sWTwEqY/lgkcenaTKIskK/yk1QINE1qMyKdmHneynLwRlY37dT5hMi41Nq0na4a1WyNs2DJuRGAz6kQlGWCXh9DZNlCdYVRozxwg0Qdme8mpXGjUr9iQCZuSB53734Z/u/94fmFTI8Avk1hbOTrm7I+kXqi2SoX7Iw6wAKj3plo6tek5OLNGgkZEYYrEWeH78hXY6tvJVLtGpQov5zvgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xteyOYGBEFb/Vqjss1sYSev9hZp9kP5Butldw4u8ilc=;
 b=LcCd2lNwSDU2K5DTBKF7WVuis179W8XR6mJoS+WFFhD6yyW5fqN8uaKXtHwJ3Y9/bdb8L7qXL3KOlmS9vTUQo5N6kp9ghzTsRy/U6t4mFgLefVmEzoT0dxGEc1jqsRRbjDzpnLL3GL8Nki9SSz8pZj1xh9Pw40ZE8unY0/a3SDZTUEX5k0ZrJuFHUSxmNZ+ot1shbUlUBFjS6sZljqnEaOwfGcrmNKprLlTPE1pIoqGgmEyTgzYokCVM9mYzva+See3Jks58Sl8Roz+I44iWv7zq4r5tK7kuwILD33x6I1XoyCfIhHpDTUZ7soB62Aoo458RmjSRvzuA3pcUetDYbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xteyOYGBEFb/Vqjss1sYSev9hZp9kP5Butldw4u8ilc=;
 b=hOEi2P1WQPclDSyZrnVDJOdEV82viTqEg8BZObaEy+6Td8h3KJzey0F+QOE/t478D4u155IfgqlF39RJeucMZCktgQHydl/S1B1iijVWE0PDGeulqr0fnmQybRqHRSZag6TMWWLKOUObIeVfvt3xNs6ICUTug6I9zNrCli2TtypRbm5JV563ch0EYhTI1u9goJY2/3U9ZumYLUJOwzISN1ImihvA3VyM1UI+jK1F/pYJuYg7/KviiVmi+9VSLLy9gcpoTJKpw2/V/fnuTifFZ7sxys9ddCPo76JTzoDt2E/OHPYxlwF1a15lfzp/5D83irtYFfFcc7fMUDmI3J6GTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from VI1PR10MB7672.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1c3::21)
 by DB8PR10MB3561.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 08:29:46 +0000
Received: from VI1PR10MB7672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d884:a30c:ee37:5cb9]) by VI1PR10MB7672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d884:a30c:ee37:5cb9%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 08:29:46 +0000
Message-ID: <1f33c7cb-06f8-4873-a7b1-153062fdc8c2@siemens.com>
Date: Tue, 12 Mar 2024 09:29:42 +0100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] testsuite: smokey - new testcase
 pi_nesting_contend_multicore
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
References: <20240312072341.27967-1-Fabian.Scheler@siemens.com>
 <28da2b72-87a3-4b3e-b59a-9bba18b290cc@siemens.com>
From: "Scheler, Fabian (T CED SES-DE)" <Fabian.Scheler@siemens.com>
In-Reply-To: <28da2b72-87a3-4b3e-b59a-9bba18b290cc@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0061.namprd07.prod.outlook.com
 (2603:10b6:610:5b::35) To VI1PR10MB7672.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:1c3::21)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR10MB7672:EE_|DB8PR10MB3561:EE_
X-MS-Office365-Filtering-Correlation-Id: 829efe2e-e4ff-4fe1-a577-08dc426e9361
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	K/H7yGAjvPzIfvKB2kMIIWUB0tzhPMaueIBpLSWYcoeUQ/wOmwWlsJllpmkwoN3NGc8DZxwxrIp8IwNGEqZsAE9UAc6PbrgSGVHwDC1k4Y2XjTYwbP01+/1e6w+u3CZeS45jXBuXmEHGX5nAFO7yQcb9aYpHfpMUKOpH1x1l5bHNdbel84EtsxYhrAv+BNqxR57Pcki/FQSKwKZcJCCjyrBHRCjwzXBUEz5XLvL8b/uFnS6J+r1xKM+MYn7vuDngOSkl9eH5lfHsPPbA33RhtxRs3zb/Dy1nTmeZn+KfuBT7RchyDqT7FD88iG16aEdwkUOOXxCs23av29J5RQaMTVPXnPApossqC1B8DrR0BAd7RC8+87F6oxbUr7VfmaF/U7/WKOmFu9cgrAUCPckXJlLwjxk6zx4CKcCX2pRReVq3Vg4EgCXKuMecNDYV2rcWGBByte9X2qV6/6KVqjTy8u5ql5mPaQLmJ8CHnxOvt+qxXnbP76zhtvM37NQx20Y+yQlIdpQSBT9veec3AIQq67t+jsqUTZhZhV9WfVYmkW06DPMKJzr2DoSwqAGVlpR3JAESGWQsTQ4EI7f/0EG3K44deZV0+XSPLVE62dCrfik=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB7672.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFJiT1FzYmIxWmVGYnBscForWVFQaENlbGtrYm5sT1ZCZFVDVjlLWklOWjM2?=
 =?utf-8?B?dHVra0RWTEtVVHZLUTBxeWNWQk9kdW5ZeFM2aDJLUDBUQnlQbEwzNUVlVERH?=
 =?utf-8?B?OWxHbTNJTG5ScVdBb2taVDFaV041TlpzV250YnFWZE9Rb1k2WHNLS2RHeVhD?=
 =?utf-8?B?UitLZWF2UG42b2thSkFTbDBpanY4ZXljYkZad3A1ZmNkZTNXYnZ3dmdhTWFw?=
 =?utf-8?B?MGFHZktRbmIwdEZPcXZkMG5Na21odWpMQ3NmQy9Fd2pyVlgrNWRWRjVTbkkw?=
 =?utf-8?B?V1JGWmZVcEZqRTBZMW5DVTh5MTJxTkdwL25LZnBLTDZ2aVpYTHo1allDUFky?=
 =?utf-8?B?UU1mYzU2MTRqNDJEbTdLR0JLTmVzRm52S0pJejhySk9tMGlpRndEODdPZ1ps?=
 =?utf-8?B?RGlWQWpFOTBFWDZnVXRCR05CNkk0OWc2Q3hDZlAwcTNpUjBTWENYcVdDNWFM?=
 =?utf-8?B?ZkNoYWRKWGZVVXV3a2xPY0x4VytaY2NIdUJxQjVQaG5JeTRmVmJCUDdlcWQ0?=
 =?utf-8?B?Mml5b1daQW1aT0N4dTJScVFZMUdyL3luQ0RoNkN1Q0N4RFJyZjlpdlk3cUxV?=
 =?utf-8?B?TTVybWZvRHd6blFuWWkzKzJNWGJhSWVoMVU1clNRdnRxVnFtV2NML2pJK0xH?=
 =?utf-8?B?QnordDV1eHdjRm1Tb0ZicC9GWWhST3c0THNGZ0EwNW5hOWdpT211cUVVdFY3?=
 =?utf-8?B?UG43Yzc1VFhTbTJkcnpQSm8zSFBZOE02MFA0MG1iL1ZISEZtUWQ0Ylp6U002?=
 =?utf-8?B?OW9VQ25NWGkzdVRkMlNjMTBvNDZPdmJqdmVXUzduczZjY2JhMTVUTU5pOHRr?=
 =?utf-8?B?SDIyeERLS2x2eERxbFo4eXV3WUdaVUJERE0renNGSlZkMXlKVTVySFlzUkZ6?=
 =?utf-8?B?M254dTRpNWVjQkdjckc3NHhmYXk3S3NFTHJoYWJyK2NtQnR5MHhEaGNWRDFE?=
 =?utf-8?B?QW5HaXVTUzBoaktjZzdSMFRmeGwxMzIvaEx0dW5MODZVTEN4bXRpdzlnajdp?=
 =?utf-8?B?NytJTHdrNmJxazdSQ1NjckRjR0RlK2o0cG0rQWQzUVNaRlFjL2w1NW5ya2xs?=
 =?utf-8?B?aGNFZTFoL3lJQ1ZueGZoWTlJekczREhWMlBpcUpadFVZV2llU0hIcFJNVEVa?=
 =?utf-8?B?MzE1VGk2eDc0Mit0WG01YlpmcUJMZWxEQUpEZHRMOFZHS21uUUtvcm5VanBv?=
 =?utf-8?B?bXE0KzA3RTNNcjQyckFLbFlJSmJGQkgyWnJTRC9LVHhpTFo4K0JPaExTYjR2?=
 =?utf-8?B?QnNqVXF4NUJzUDRlUjJqNy9ORkVadnFDcnZIV2JtVEMyZEJoMXpSLzNrTy9J?=
 =?utf-8?B?elhsS2VIVjBJVGw4UHVpUmZVZGNHc3hNei9UcXNuYkhYYTVGSTdIdXAzMzRM?=
 =?utf-8?B?MDRsOFhBTHBpb0oxQlVTMVJub00wcDE2ZUhkcTdjRXliTWpRNFlIS04wZUpW?=
 =?utf-8?B?MW5nL3Q1UXR4UUtmZXBRUE94OGsxUnNBL2Y5RktnZ1poWmpVMFI1Q20vRUVX?=
 =?utf-8?B?ejhmell2WkRlUDV3QU5tSkd5V2VqUlQ0VDVJWW1jbitoK3BpU0YrTmJhS1Nm?=
 =?utf-8?B?ZXhQVjQ3VWlDREZmUE1sbGlrRmZtc3U2bHJiWmF3cmZDem1OaSszRjYrbGlH?=
 =?utf-8?B?alhTSjlLbGwvUk9jWWdDVWwzT05QQ3BvOUlWOHhHSDJuYU9DenBPUnBHMVJ5?=
 =?utf-8?B?clBmeWExemJqd0RuWW9JcG9kVVRUWnpZNFp4WG1taytiRGNXLzI4VFhLclYy?=
 =?utf-8?B?bGo3R1IrZ3FWSTE0Ny80UzlnL3Q5RHpEdmNueGNYVFlrMzUrZkhTbnBCeGU0?=
 =?utf-8?B?L2hENC9jaHNlVXFtOWttWHJJVVRNc0QvQlJtd05YdGJEdllQRnoyNG5nT0VE?=
 =?utf-8?B?ZHBpb05Rdm02eW94UDZOQkJkN0JUaXRYQ2lTa0xra3VBUzdvTmYvdUFVT2o1?=
 =?utf-8?B?c3BjV3lrTTJEczliSGdKS3JKVzZ1SU80SXJvUFo0ZkxRYVFNZloxeUlTYmhH?=
 =?utf-8?B?QmU2UHdvSHdweFdGWkhNdE5FTjNteGtHNHNKUXRxNk4wek53Y0ZCd0RqSG5Q?=
 =?utf-8?B?M3VRdWlJWkxrZmRBVDN0L0diZFhGaGM5Y2tvN0ZlWEJ6aGlaU0tWdEZBeHlJ?=
 =?utf-8?B?NmtDYUNXUkg4dlUxbFREYU9UK2RhU2xQMGtwemtCRWhKQS9MYzFiNEhyZDAy?=
 =?utf-8?B?Y0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 829efe2e-e4ff-4fe1-a577-08dc426e9361
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB7672.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 08:29:46.8351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sMoF/VUeLz11rqa1pV4sjjFrYZHOPUdMHJi//4ehPKfK142u+Gc2XX4/9gcJ2HcPt49Cg5yVn0Dgit9JvTekkNx6EIRRfJZKmZ6zFWL5AmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3561

Hi Jan,

Am 12.03.2024 um 08:44 schrieb Jan Kiszka:
> On 12.03.24 08:23, Fabian Scheler wrote:
>> The testcase adds checks the correct handling of priority boosts in a nested
>> priroity-inheritance scenario and distributes the high-priority threads involved
> 
> priority

thanks!

> 
>> in this testcase to different cores if possible. In contrast to
>> protect_nesting_protect and protect_nesting_pi only priority-inheritance is
>> involved here.
>>
>> The testcase implements that check as follows:
>> - A low priority thread locks two mutexes initialized as pi-mutexes.
>> - Two priority threads (prio high and very high) block on these mutexes, thus
>>    the priority of the low priority thread is boosted.
>> - A medium priority thread is started on the same core as the low priority
>>    thread that must no interrupt the low priority thread as this one is running
> 
> must not

thanks!

> 
>>    on a boosted priority.
>> - The low priority thread unlocks the mutexes one by one, the medium priority
>>    thread must not run until all mutexes are unlocked and the low priority thread
>>    falls back to its original priority.
>> - The correct execution of the medium priority thread is checked by the low
>>    priority thread by checking a flag that is set by the medium priority thread.
>>
> 
> (Not yet having read the code)
> How does core distribution come into play here?

The two threads with priority high and very high are distributed to 
different cores if this is possible. I will add this information also to 
the commit-message.

Ciao
Fabian
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

