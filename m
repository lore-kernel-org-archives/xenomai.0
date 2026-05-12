Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011047.outbound.protection.outlook.com [40.107.130.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2540D3815D9
	for <xenomai@lists.linux.dev>; Tue, 12 May 2026 09:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778578220; cv=fail; b=HB9sv9YLIY2TvW24j7IPMi/UMjvNxo6YxMx69QYLf81JHWynxu8AGxNVwoUsG0w3fb4VMdVUDKenpwdD4o2EwBAz5JPS9ugxEOMcEW5TYTKNMlPGuS8VOYN4wfeT1tRXHN3YBvo/MqHa2QsxEC0xjTeszEdxZxjVBJPOd9A2PZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778578220; c=relaxed/simple;
	bh=v35QAZyx8rXu6+gkGiN7X3gugJhlP1hleHPP9QvBmvk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Hq3qHdti+ClX4vBVVx3w6xQlnKcxahOO05rIVlbOB8H+4kOeJi4BQ1o+oCfinXWNAMIlVoWkoeJg8rl4JsWwGKoLMCMH6AuQFg3Nl5n4ymvN4x6JqLTNzI1eUeftP5HPW/Rtf17Iw7eKx5E31epZ/IU/nCPdMgnf0WZA+DnO5og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Mvc96Hq/; arc=fail smtp.client-ip=40.107.130.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Mvc96Hq/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yCaooayuy+BzN/Is3Ez+iA5neHvgj0IUEuZjf8b9sjzBNfqdjwrMXEWeVtmYXSUXf8rINDSdtp9CaIk+QwWQpE5Q5Guu6m1DDSnJnZnusBtBAS8ydvUshMQrquPIs/FUnwpylX5F2OGNO/1XB+bOiPZvMcBx2vPEh72oPsOZkFFYRPEJFOzYqJk9sfLxr2g4MGddIGABxKfGTajCqffDf+bchT5HOOfTZzSwOuuKal26PqFj4tNxBRFxkbZCOYJpQhFHjbGaOdwt1J6Fn+iBSrogV6NVCAEhxPvxINv6UvY7fiYblwmfXTGbOSnz9/SQd03WglDlgCcWEM8WmtgKpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5hWc5LyJ7FA6XmyKUpGiiobyOxsdZi7FYJd4yRT70Rg=;
 b=aWRR/nYlOdOsv5exRb1+QiJ4zlFVmtu/3IYGi/OPoQlE0m7ObYTh23G4ajQUakhB44oLMclNQl8ChLDjqAAU9dNBTe1CK4u/kAaIrnQWJbx8/hzAvhMKVvrD3z8jc3vuUdv8hqNSKlJmjXW7Oid3B5Oiej9dTYLXrtotC6tCvxTQPhzCYGL7UrDZf0ZeqN7mayvtEKE3el8/2SnQIxEyDfTAeHchW5UnwrBgFGCM9Dcd+89ax86zhIZiL1ftZVurxLEwxAuGGAw7J579hVTvE3cekskqWoDwC4owBJiEpXwwNtQ84tC63RSecyDH5CG1EERCFD4L6dLgxr3EoKOJQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hWc5LyJ7FA6XmyKUpGiiobyOxsdZi7FYJd4yRT70Rg=;
 b=Mvc96Hq/yB6p+oXKBsj2ricZwwNzS9IsqgxG6qqcFAwtT809V2wW1dIzHErRWWdSKjeCXEKEpBqdn+BwPMRIiSKMmWhb6chfQOwimPXDhKA7B+sZZYFoXqDd2sPdC1CQzJS4j1uFEk5JASawpI5WwYnXTj+UxqlZU57iGKk5rpo5f6ShT47FpJVR8wYEGak5PaOflPnR9WBaRWV2qX3M9Jss2pj4SodY2eG1UwoSufuitR3JDGT/5BG+7d0/kjrIdmCGciZQX3/K+llXo9fp40bewy66gFa+9ME4GXoQ1gg9AXi1BjH+M486l4bHM3nVExn+iyt/fmcxtqwuPl/U7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8901.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 09:30:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 09:30:12 +0000
Message-ID: <b36655bf-b372-423c-91fa-0b0120a13e3d@siemens.com>
Date: Tue, 12 May 2026 11:30:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Spurious task resume due to SIGSHADOW
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <CAFLxGvw_cRpJbBKg2YG9_oi5Bv_DU39OB41nPyJcq7hv7hK6YQ@mail.gmail.com>
 <411e79a0-cabf-4d86-bed0-12e0b9546c1f@siemens.com>
 <CAFLxGvyUZWXEYdvKynRhJEkJGnEKomCmKYvZg3+Z7DJUM+SUPQ@mail.gmail.com>
 <94e64297-32e5-4818-867b-a8fa27d0c630@siemens.com>
 <CAFLxGvxA5q++HKe9AREfP6qmiNObWTch8E2Gh_ZiUaUyUENVVQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFLxGvxA5q++HKe9AREfP6qmiNObWTch8E2Gh_ZiUaUyUENVVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0289.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8901:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d7c6b71-c443-40cb-a59d-08deb00910e5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|11063799003|55112099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	kZX0eC0QgYbMlWEdTTdnQG5EetTN7f7fFGLTQDz0J0FRjVvCUao+O0QDtuC9joV1mM7T9HhERuXANQsOUfjdDxCabxDenpObFwfFkwEIWmYT1TkynG80YQd874cZllEm4Kx0kWOtNZhIB1dJCO2LjfasiJ1CWnEVJ80M0uqHU/50rFyEZ6LL+b0N2JrR8//kJKXVQ3NpEp1cEkEEwi0Xv6ZdP2/eos7UPcjuHNQdQNrfFilCZKe+hgIkbLNqRCJK+CFUgGRjhH3Njs2tcCihpZfvVn/bNCaVH4ovKQu+cjmZIc06SrHFiFOIfLXzK0I/OSG087+ZBTbrywmdOpYdJftZzbG02SOLm2Ri7XlQwx7ST5TijJ5Z6tIPoSzTySE6iUnhDpgruBGBQKtCeOj6Ap0Kk/FRYGd6/nXFZsXO1M8IEpUDg5uVWI77GSKoz1JrYaeEdXEtoCtOKi0MiqRMdbg8PaE8futQiQ692/RR+XpULX9dmgAIzSrfp2rk146rLuF917Lc44bCTEa0OTAgd/bRT5QoKGEDU8prMSf8RSYqvUNpPnoEiWUilMZmOs3o/yZ4zL47zsrz3QEy98yxuHcsnwua512a16GpgG10RBOmO2mOYNVsKVq4MTuIitH52IZcY81839pw2ZIjoP/jAo96Yx3fUhHTvjgCs2dctUMC9rfkIlU8K0oHkPM8zVZX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(11063799003)(55112099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFVYSGNJZXNzNGZFMVFBOVlWelkvL0ZCdmorY256YmlXdzh1dDBiQ0NoeGdk?=
 =?utf-8?B?ckw1eDRLZWNwQStIOFlUK2V1ZVhidXNxVFlCaXdGR0ZHRjdQb0U2eDdZWlRB?=
 =?utf-8?B?K1lLVXhYZTNWM0s0SnMrSXBUOXNObFk5aGlNelB2SDI4Zm84NEhESGxIL0Nm?=
 =?utf-8?B?MTF1elpZdkthOVpSdkZKTElSSktKWnNmMHBiR1k4L3Y5RGhnaTFqbHFJSTZo?=
 =?utf-8?B?bWhSSFg1ekRZKzdza3J4dmYyZG1vUEdGTkNwSWhISkpBcTMzWnpnUDJ2SWQ2?=
 =?utf-8?B?QjZ3c0ROTW9vaSs3T2VjU0FNZ1VLdGxJTVRzUVN0UWJoUUZsazcvRjk0L3dQ?=
 =?utf-8?B?UHpOSWExVnFnT0g5TU5Zb3BabE5yZ2xrTEdMQWtOYkY0M1hva3JRc09ld3VK?=
 =?utf-8?B?cktYVHhNemdNZ0lrOHdvcmYwQnhVTS9nWUdqVnlNWmY0bDhpYXFIS2FDU3Rl?=
 =?utf-8?B?ZStiOFdJS0J6RHF0YmpuanlGcUgzcUJpQTllejdOcGlNQmRaa0gzSk9VeEpv?=
 =?utf-8?B?aWp0Z3N0Z0JHUlFnTWJ3bStlbnd1Zm1yb29kbEdRT1VaR3VrN0M5RVBDbFRv?=
 =?utf-8?B?bVpNS05qZHdpN0FDK0t0UUFsaXdVRkxCVkFCdXBVcUlXUkNvcEwxbVA0SXB5?=
 =?utf-8?B?NG1zNVREZ1NabXJVMDhGZTZLWnE4OUwzdThUUkd3bndodXUrbHZYbmVETVRw?=
 =?utf-8?B?QWtXbkx2SkJtYXVicGR4MndRczE0bFZheGN2RHRCRW5lSDhIY3U0dWFRUHFO?=
 =?utf-8?B?ZGF2NU10d1NzZHZSaTRjbDlHTFptSUsreXh6M0tqMUJlbVloa0xBbjNKdEUx?=
 =?utf-8?B?SlprSHJwbm9FK0Uzd3ZWUXFjMHArN001Y25VWU1WUU1KMmJ4bEVHYXdacC9L?=
 =?utf-8?B?ZXZhYWFSVmpvMS85TnpkYU5lYXN1MFg0RksxYW1tcWhBUmpVZjBUQmhiaVlR?=
 =?utf-8?B?RmZZWHM4TndZUHhFdWI4WE1YTUNUWVhBYjJWQ0VwQU9yaVJodzcyb1U1TFNR?=
 =?utf-8?B?akpLNHp4akQwR251VmhaT1FiWWNuVnRtd2ZsWXFoT3p5T0Nxa3lieVNHYUFB?=
 =?utf-8?B?NTVVQzBhVVpoTjdIV0h3dzZmSlo2QnZYaEVXM29RU281OWNNb3Y3N1BRUkF0?=
 =?utf-8?B?aFcrKzZ2SVVoWXczNk9acUduTnpkSlUzbXBFWjIxL1RSTXhhYVA4S2cvdG4y?=
 =?utf-8?B?TVZCNit1YTNBVjdjanBwUG1TaWlUOVBnd3R5ZDBaR0JmL3puUGM5N09QenNW?=
 =?utf-8?B?cnUyU05XSnl5dC83ZlFsU1FXY05KZjB2dEpINnM0TEp4THdzWmJnNlZSRFFR?=
 =?utf-8?B?SmZPL3hJUEg1NkRTUS80RTllWWRMOGhHUFJIbzBhVjlubUNMS242QzRoaGJm?=
 =?utf-8?B?NlBlYm9yTFg5a2lDamtkaXRRNjRLUHNBQnIwemFBQ2dJNWtxQkQ2Q093U0Fa?=
 =?utf-8?B?cGdCS01QeE9MQzJsUWY0M0VCOHlxWElaK0prSWs5dEdYT21SZXl1YzdreDAz?=
 =?utf-8?B?RjIvRDM4dkZaMnptUDBxeUc1c3dyRG5ldjRrUXo5OXBuZ0YzU3d1ZkpsZmNI?=
 =?utf-8?B?QllLMHhiY0g0NldYTlFONXNYK1pSTkU3MjJNaUJpbFFTdGVYM1NsUG8wcGlh?=
 =?utf-8?B?RW8ybkovTGRSWkQyTnJ3NXgzVW0vdnM0ZmhGM0hwdm1rNENmMm5ZU2Q1UG1D?=
 =?utf-8?B?VFJiWjdOTFoxRXJ0R3dYWTJJZzErVy9aRzcyeHV2ZmtpQXprS1gzWEwrR2ZL?=
 =?utf-8?B?WmJOdC9HZ2xFeHBXTlFLcnkwQUk4d09vMWpFbVVYY3h3NG81OHFWb0dBN1NY?=
 =?utf-8?B?MW1QZVVBaGFpelE5aUxMVDhSdWtwdlFmZU9ITkRCUFZod2h2eDJLUFczTHVx?=
 =?utf-8?B?K3haa3pHNEFGVXE1Q1BpMFVXSHhtaG04Y0ZiVUhsMzFNZ1k0eTFNUWZnWnZN?=
 =?utf-8?B?Z0Zuc0FHRi9MUmc5ZDV1MGt3OGFuc3kzbEtweUpuamlaTEQyYy9HNGNSMG1L?=
 =?utf-8?B?c1p5UFVyVGJnTmF2Rmt6S3hxUmM1UXFsTm1aQ096VVF4NFpVeTEza2ZMME45?=
 =?utf-8?B?QjRXRDZlZEc1NDg4N2luR3RHbDR0d1kzdXNYWjNRR1hLNUxCcDR4dkxhZGxV?=
 =?utf-8?B?UkE5enVhNm5tYnIrZ0Q0NEFJMDRMYU0vUCtrU081WitGTEJmem93ekV5emx0?=
 =?utf-8?B?ZW9VcEdiTG93SThSVzRxUkNoWmN0N0VxWDhyYlRlM1M4KzVsRWVocGdpVldm?=
 =?utf-8?B?aWFMWmJtMWVWbjdUQzJHQjJIdzVvTnRhaThyNTdFVmRDd3BqSDJlWDVKY3lO?=
 =?utf-8?B?YnJ0MWRVSFlZK1Bxd1pIN2ZzUXkrcXVYNUhUVUVWMDZhRHRHdHZ5Nnc4S2pt?=
 =?utf-8?Q?uuj6gyqgaZgEoGro=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d7c6b71-c443-40cb-a59d-08deb00910e5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 09:30:12.2616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A+kDKdkfV9xsM7R4s73TQqoR7vJw77LeGIVeGppXlyVOo/4dKICMaLPHQ6e78rbbk15oIgSVyvEa79Zur8Cq6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8901

On 12.05.26 11:16, Richard Weinberger wrote:
> On Tue, May 12, 2026 at 10:50 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 12.05.26 09:19, Richard Weinberger wrote:
>>> On Tue, May 12, 2026 at 7:50 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>
>>>> On 11.05.26 23:49, Richard Weinberger wrote:
>>>>> I'm currently debugging an issue on a very old Xenomai system, while
>>>>> reading the source I noticed that the very same issue could also exist
>>>>> on recent Xenomai releases.
>>>>>
>>>>> What I see is the following:
>>>>> - A task gets suspended and unblocked using rt_task_suspend() and
>>>>> rt_task_unblock()
>>>>
>>>> This is intentionally rt_task_unblock instead of rt_task_resume?
>>>
>>> From what I can tell, yes.
>>>
>>>> Because:
>>>>
>>>> "A nesting count is maintained so that rt_task_suspend() and
>>>> rt_task_resume() must be used in pairs."
>>>
>>> The application has non-trivial thread management, from what I can
>>> tell, it's fine.
>>>
>>
>> Unlikely, because it will completely confuse tcb->suspends, preventing
>> future suspends for the task that was not properly resumed.
> 
> Well, the application does rt_task_suspend(), followed by rt_task_unblock().
> But unblock does not resume a task. That's why the application later
> uses rt_task_resume().
> So, it should be paired.

So, at least for resume story, the unblock is pointless at best.

> Please keep in mind, this is unrelated to the SIGSHADOW race.
> 

Right, but we didn't know until you had a separate reproducer.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
