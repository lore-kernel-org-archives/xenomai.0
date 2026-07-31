Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010058.outbound.protection.outlook.com [52.101.84.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7301F3ACF1D
	for <xenomai@lists.linux.dev>; Fri, 31 Jul 2026 08:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785487804; cv=fail; b=qJaf/jVOukGmLox7hKkVATEbrsAzzKNjC2UhxV+Dg0EUxVPTecxod6o0QWSFuTL8CKbbLiL/EumLSDaT6BB8OekfwjDt/8XkOcpgVJ//nzp80m8aT1RCS0dkLSWvJnG/2q51+qaKmkfPkADVI6SJsPE/p24qoKGzyeVkF26PWiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785487804; c=relaxed/simple;
	bh=YcZ1RB0RhOAcJvXAj7NAgNqfFt/ZElg9xTkI4ePPVjE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Zb2FCJQbtqP50ngI8TCTN//melMWvYd4+XB5Tj6r0ouk7w1dmZ+47Y7fu6dVD/tKBt4dJpjCDp35STCG4Yq9CW1jr1NRDjqY3ZA27th6Csc/yuQr5Eg/ZaTTjPGLxZDfpx9bFVgigSUGtLIFdmpkRS4CqPk6GkYaHWnnGQOx8XE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Rl4xoa2H; arc=fail smtp.client-ip=52.101.84.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Rl4xoa2H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hl8ZyALXkVVoX9F4L3pF9bB0V13zWVZxXkJD2GE0z8oH34Vv/xHJTqTr5tsmwyBJKCjZL11JIZ3UDlXwmE2HRykijIL5mfjH1YTe97vwjlkd7yZ5LYHbwMoukE37O/zznrUFnOzkevWE9orxVnEDBIZpLIvd0/gYU1Y7LOHMN/KmFgR2Sfu2JMDKfFUZ8fYsGeejJrI7wPa+DO+Xvy92iYq9pGy5pa3oz8jU8eMFPS7a/Z1j8CxfHbJYyxruNQS28DW2IR+Gk/bIh+w+HxWdKCu06BmI8uqgm4+AQEHHtrmdlPvDu/O4NWy1K0x0itmYg9inzjRD9LAd1Jjm3E0PdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXDiirZvN/npjMWZk4veFj6zwSDh2Yi+2/bewm4pOh4=;
 b=JoBb105BLD0eUWP30j0vhr57RQ1LC1mQ0/rXhP8sNrOoIHUO5rdDFu/4UhtM+ORWT0Wzp9LPP63hHPxxaToswcQ/IUbRu5ZKsXPBevkJO32lnzQ6Vf+jkoZRZtNl8W8AbVpqMBK6y3e7ccRc6MktXqomE1DfzLEJ5Nc4A3nOSpad5IcdvCCPB9dYUU6jnSwWZI/miDb61Rbt4mXdFQwMXnhJsr1FoZt5pHKBnhW6ruj2CKk0eRcF2GcrGRYq1GZ6GCq4Ut3BlEkzy3bADJAcuGooxHxHddZsaU+hE3jk7/73p04hMD3zJcMlpOyZbMMYn20+o1XnJk8ppUSLxptnTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXDiirZvN/npjMWZk4veFj6zwSDh2Yi+2/bewm4pOh4=;
 b=Rl4xoa2HXd5FsGe4axbysdoQ0LbkGmYvG11vp7ahitHbbXVaSBpenqlJ2Xcf9QRmezvJ4/K9Xa4qviijL0xWhF0PBJ3rdXEdsdi1lLAc9MM5+m2I8M161OLqy300+xri7bWUsOYvJtToy0wzJUii1aQBDLXkXvHBAZsAhzV/szEc2sOXaBfFN4zxAx7vWYnKZzXvatWCu+9vGLbIFlvNZsMa/wM7IEH+cXRNFsVbLMFZz9/5pL1vDo7ddrC982Vb2OUMEg5ScA/9aFLIKqUsb/PhoxXG1Q8yKxIQ2FV0CZIe3wJaHQs/PArcVDlR3ockpkh9nb/8ojzToeO4Kkqy4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:740::12)
 by GV2PR10MB9653.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:304::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 08:49:56 +0000
Received: from AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::527e:14a7:bd3e:86be]) by AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::527e:14a7:bd3e:86be%5]) with mapi id 15.21.0270.015; Fri, 31 Jul 2026
 08:49:56 +0000
Message-ID: <fb297fa9-2231-4b93-a1d7-8fc42d9f3132@siemens.com>
Date: Fri, 31 Jul 2026 10:49:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] debian: Replace SysV init script with native systemd unit
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
References: <20260730154748.2343236-1-clara.kowalsky@siemens.com>
 <3e5c078d-7e83-4589-901d-cb216721b83e@siemens.com>
Content-Language: en-US
From: Clara Kowalsky <clara.kowalsky@siemens.com>
In-Reply-To: <3e5c078d-7e83-4589-901d-cb216721b83e@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0092.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::12) To AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:740::12)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR10MB9645:EE_|GV2PR10MB9653:EE_
X-MS-Office365-Filtering-Correlation-Id: edc641cb-b8d6-4871-212c-08deeee0b1fb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|56012099006|10067099003|55112099003|18002099003|22082099003|11063799006|4143699003|3023799007;
X-Microsoft-Antispam-Message-Info:
	s6j9BkY89TAR/cQ4lCPFA2BI/Zzoa6UDg9fZphtlS38W16QLNokIbkXy+taWFQIy3HRwzSz0H0F62VNFLXjxvaLy/9omdGEXuf0uBKjukY+67td59Vo5CK8Nu0S6Bs9uQx+DZYRNNIAR2bA1x57tI39RAXP6O6DjfoiYRHIVnqtxfQn4SyPKhd2vH8drmsZ9ooxVbY/2LGcNUVnYpBsKHDHDFHKZ2eplOjsibM9EsU4rP21EVnwlZcffML2mahj+lPZ+cMKYsPCxExkyLefP9Ycba8sed6Po4GUrgesw49i8Gc9JVu0q6KRba0N6KuYuvCtF7/U0fjF+W7BD+Jmx0b3QeoVS/ZG6XbngyHSY2YY5tuUj+M5bpmj8QqG/AV3rhpXL+rLr8fKk/e6HhRkB8DihaGjIJI757QTUhMZmAHT6I2S8/XK+EbNyfI0gDjwAeS5sQSNEmnbKfQVkQvV+YI+8R1q2buuiBdTfYLldaf/p2zeJZzPYGtQAu2mgK//X2lY2Pe2j+R9I/jDlqPpEEMDNzwONUzCA+qQ1iS4ZD6aDzo42CsXybWjfuwKqo3D+yREDTCr/95vfLGzdvAlWgzF+acJxc537OcyjKDMKz9hM2dn/DhS41ChbhPP3m2gja3OJkoP0q1p4Dk7YWGdbUhYDHZuc4oq8UE4i3726thk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(10067099003)(55112099003)(18002099003)(22082099003)(11063799006)(4143699003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGh3WUR5UGk4bHYrbzdsMjY3Nk1zNDNDMUdjaDVsMWhIWjNsZzA4L0t2b3RH?=
 =?utf-8?B?NVllV0tCc0NqWkZ6KzQ3Nm1WWGFYdkV4amlrdEN3OUdiSjhPNlZYVEVPcDdL?=
 =?utf-8?B?eGE4TCtxZWtOdmQ2MU9rd2I3czMwSDdnS2VpTHZiVVVIQldnVTlmb2hoWXF2?=
 =?utf-8?B?NUUyNURjQXc1aENheXJMaTJETnlOOU9vU2xHbkJ4alVBenp6bEFJL2RWNkc2?=
 =?utf-8?B?ZGJURW1BeVpEUmJEZGk2N0pwZzU5cTVSKzZRSnVacnB5cjUvSHdsU0lWZVln?=
 =?utf-8?B?ckhKVjhCNjFyN2ZaSXc1QTJmNE8rSlFNQllvd05QOGZXdWhvcUFCQ0hnRnJD?=
 =?utf-8?B?aUlXSnJtQm1sNWQ4UGZnMkVjSlRudHFoWTJ6a1l5ZEJmRFRLK3lCclpJMVU5?=
 =?utf-8?B?T1RwdGdQWUhvTm82UGdaUUVtN2I1bmE0SENYRU8wV0xJSXZ4dDdUR2lsSUZu?=
 =?utf-8?B?aWw1Vk9OVXZ1KzhER2djRktFSndaUlNYQnpWZWZJWFJLSUNxbnJDek9Ldysx?=
 =?utf-8?B?T3Y5SVIvNU1Rejk0ZFhMdnBFTEdwVzlidHltYklCM1lKUUs4MU8wL296eFVl?=
 =?utf-8?B?bXEvUGw5UjlvUC94ZjhZYzVXTVk2SVE3QW9OM2lmeWd5bkVZOWZQMExEYTZZ?=
 =?utf-8?B?dzF6dVA2Q3FqeU1DOW0wUkl3bmVtczQrS2ZhWEJtU2JicXd4Y2tCeGpyVjZl?=
 =?utf-8?B?ZTU0MXNMWnhBdXgrYlZUK2U4U3VoRVZNN2tLZ0o5YVFEZG5ScHVLcmlPcXpm?=
 =?utf-8?B?T3o4QUh5enF1QjQvQnl6Y3lXNzVVWGtxdmVxZmIxRGIxblpsNkRHa1cxSXJk?=
 =?utf-8?B?Q2ppa2h6Tm1NVHErOXJjR1JuYXM5MzRqQmNsbXdaSFRiaUZWb2poanJlK1Zj?=
 =?utf-8?B?cXpHU0ZiL2NRS21QOUFudTc1SitVK3ZVaXEvakd4WmF0VWhXRE5vd3dNNkt4?=
 =?utf-8?B?Sm1Od0hlYXM3SWVvOU9lQWVUNkNBdDhpT1hDMy9IL2JuRlFYV1Rxdkl2M3N6?=
 =?utf-8?B?ZVBPUGRkVjJxdTVDNXpHN0JTMWliQXJ3RWV0K082eEdlZVdvRm82TzdodTBo?=
 =?utf-8?B?bVdJUFRWZE1MTmlabVVWT3VNQklYcVdGVjZFeFppVzVuRTNXVzlqcmhCb21z?=
 =?utf-8?B?SHhWaWFZOWl5NkZsNWNPSFR2eVR6TE1uMmFpZGxNQ21QMmxKdmhiaWZFNjc2?=
 =?utf-8?B?bERLNS9tZFZDczFCV3IrNHltS1EvcWZ6ZkYzMXFhZjdWMUdFVDJZTitET1VD?=
 =?utf-8?B?dEtMdG9RNkM2OHVpamR2amwxVEN0QkhKbkYrbEtRL1UxLzR2WUU0UHNpMUJq?=
 =?utf-8?B?Q2tzU1pRVE91UWNFN1BjU2M2UnBraCtWODNHQVdVY1h4WWYvaEpmc2lTRDNt?=
 =?utf-8?B?T1lFNVgvZWFFNkUvdnVod3BqT2VUcFNpWVRTNzNBaklCQURGOUdwQ3cyd1kw?=
 =?utf-8?B?WjNmU2tBYjNPWS94RlpkVTNzbHpDODVYbjN6Y09sc0FnQXVWT3dianN3N3h0?=
 =?utf-8?B?NGhDNGh4T2RZY3h0a0VxaGk0L2JyekgreUI1Q3RscUhPQldqRC9oZ01zRSs1?=
 =?utf-8?B?MkUyclp1Um9ycDZFOEh3ejVZVjNVSmZyT1dMMlhkZmZGa2Z1bTBiN3MwTEEw?=
 =?utf-8?B?VEpUU040cmVwNzI3MyttZVdydTliTGh5NGRkM1QxMUVlKzZ3TFc0eEFHbE1l?=
 =?utf-8?B?eExlQTcrbmErSUtUV2k0MUs3MzFxYUd2cHZQYTZxLzJtQXUrYkF1V0NkMDA3?=
 =?utf-8?B?N0ZaeWwvbDlJQWkrQ3BQbUJkTWI4Wk5yZ25GWmtkSGhkTkJGelF2cE5TL3k0?=
 =?utf-8?B?eHc0ZkNLUzBKbVQwUmU4eXVjd1RvRmJTQURzdjZYczFXbFlZOUNjQk0rbFdT?=
 =?utf-8?B?WFlTbm1adUZCbDFCMWptcE5aUTNtTTE1czg1dlMxK2VTZ1BQQUltaE92T0FE?=
 =?utf-8?B?MUJzVERXVGRUbGpvUWsvNXlFTzFsT2J3SGZYUDRKRUFnUGlwUmtLd3BzbzJm?=
 =?utf-8?B?bWV6dkdzQVFEcVlCSG5jOG1IeUdMZDBadnFISTAxSWR3eUtBQzBrdWF3cENR?=
 =?utf-8?B?SEtkR0ovQUpyaVFHYWdKYTJPcXhnYWE2REVGK204cXpubWNLa05BSFFhWGl4?=
 =?utf-8?B?RDFYMGtVV3BTK0hsN2tUTExpSWo4OGhNUC8xYVFwQUFDSFRCRlNVMGdNcE9v?=
 =?utf-8?B?U3BmTjNEVTI0Rnk1dGZEWjdPZjBPMTBBS2pSN1Q0eHI1bTNTZjVHWWJUV3R6?=
 =?utf-8?B?dENXMytCRlhRc1p0UUlqaTJrem8zeEhkVk1JS0ZiUE1nWVdmcGhneUYydkp2?=
 =?utf-8?B?RG1sNDRKQzFaWU1DaC9xa1d5OWZmSFNzTjFOc1pBV2M4NHlqSkU5NkxQUGp5?=
 =?utf-8?Q?P2RBlvlJsQtorddA=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edc641cb-b8d6-4871-212c-08deeee0b1fb
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 08:49:56.0216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5qsuwA1GwQrNIOB95y/Rogq54537sFLhvA5olW+aRdeWoKIw/fYzp8NpqC/x3x1HLhfAC82u83fmLg5apPUciJYh+ye0kg6yXztZz6zrl80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB9653



On 7/30/26 19:21, Jan Kiszka wrote:
> On 30.07.26 17:47, Clara Kowalsky wrote:
>> Debian trixie warns when relying on the generated compatibility unit for
>> /etc/init.d/xenomai.
>>
>> This addresses
>>
>> systemd-sysv-generator[1423]: SysV service '/etc/init.d/xenomai' lacks a native systemd unit file, automatically generating a unit file for compatibility.
>> systemd-sysv-generator[1423]: Please update package to include a native systemd unit file.
>> systemd-sysv-generator[1423]: ⚠ This compatibility logic is deprecated, expect removal soon. ⚠
>>
>> See #54.
>>
>> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
>> ---
>>   debian/libxenomai1.xenomai.init    | 36 ------------------------------
>>   debian/libxenomai1.xenomai.service | 13 +++++++++++
>>   debian/rules                       |  2 +-
>>   3 files changed, 14 insertions(+), 37 deletions(-)
>>   delete mode 100644 debian/libxenomai1.xenomai.init
>>   create mode 100644 debian/libxenomai1.xenomai.service
>>
>> diff --git a/debian/libxenomai1.xenomai.init b/debian/libxenomai1.xenomai.init
>> deleted file mode 100644
>> index 811fe25fd..000000000
>> --- a/debian/libxenomai1.xenomai.init
>> +++ /dev/null
>> @@ -1,36 +0,0 @@
>> -#!/bin/sh -e
>> -### BEGIN INIT INFO
>> -# Provides:          xenomai
>> -# Required-Start:    mountkernfs
>> -# Required-Stop:
>> -# Default-Start:     2 3 4 5
>> -# Default-Stop:      0 1 6
>> -# Short-Description: Set Xenomai group
>> -### END INIT INFO
>> -
>> -GROUP=xenomai
>> -INITNAME=/etc/init.d/xenomai
>> -FILENAME=/sys/module/xenomai/parameters/allowed_group
>> -GID=$(getent group $GROUP | cut -d: -f3)
>> -
>> -test -e $FILENAME || exit 0
>> -test -n "$GID" || exit 0
>> -
>> -case "$1" in
>> -  start)
>> -        echo "$GID" > $FILENAME
>> -        ;;
>> -  stop)
>> -        echo "-1" > $FILENAME
>> -        ;;
>> -  restart|force-reload)
>> -        $0 start
>> -        ;;
>> -  *)
>> -        echo "Usage: $INITNAME {start|stop|restart|force-reload}"
>> -        exit 1
>> -        ;;
>> -esac
>> -
>> -exit 0
>> -
>> diff --git a/debian/libxenomai1.xenomai.service b/debian/libxenomai1.xenomai.service
>> new file mode 100644
>> index 000000000..4494dc00c
>> --- /dev/null
>> +++ b/debian/libxenomai1.xenomai.service
>> @@ -0,0 +1,13 @@
>> +[Unit]
>> +Description=Set Xenomai group
>> +ConditionPathExists=/sys/module/xenomai/parameters/allowed_group
>> +After=systemd-modules-load.service
>> +
>> +[Service]
>> +Type=oneshot
>> +RemainAfterExit=yes
>> +ExecStart=/bin/sh -ec 'gid=$(/usr/bin/getent group xenomai | /usr/bin/cut -d: -f3); [ -n "$gid" ] && echo "$gid" > /sys/module/xenomai/parameters/allowed_group || true'
>> +ExecStop=/bin/sh -ec 'echo -1 > /sys/module/xenomai/parameters/allowed_group || true'
> 
> Why "|| true"? Can't we detect the condition when we should not write
> (like in the original script) and give the write the chance to properly
> fail the unit? You may even use a script to deduplicate that part of the
> logic.
> 
> BTW, how did you test this?
> 
> Jan

Yes, that's not ideal. I'll send a v2 where the systemd unit calls a 
separate script (basically the original one) with all checks included.

I tested this by building the libxenomai1 package in xenomai with 
dpkg-buildpackage. Booted a Debian trixie based image built with 
xenomai-images, installed the libxenomai1 package with my changes into 
it, "systemctl daemon-reload", reboot.
Checked "dmesg | grep sysv" -> no more warnings.
Checked status of xenomai.service and played around to set/unset the GID 
in allowed_groups.

Clara

> 
>> +
>> +[Install]
>> +WantedBy=multi-user.target
>> diff --git a/debian/rules b/debian/rules
>> index 9e56de260..dd52cbaf0 100755
>> --- a/debian/rules
>> +++ b/debian/rules
>> @@ -103,7 +103,7 @@ binary-indep: build install
>>   binary-arch: build install
>>   	dh_testdir -a
>>   	dh_testroot -a
>> -	dh_installinit -a --name=xenomai
>> +	dh_installsystemd -a --name=xenomai
>>   	dh_installman -a
>>   	dh_installdocs -a -A README
>>   	dh_link -a
> 
> 

