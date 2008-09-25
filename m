Message-ID: <48DB8506.70300@domain.hid>
Date: Thu, 25 Sep 2008 14:33:10 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <420196.99125.qm@domain.hid>	<48C3F4F2.5030208@domain.hid>
	<48D80630.4020500@domain.hid>
In-Reply-To: <48D80630.4020500@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] RT_HEAP Problem
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: yasser_kashfi@domain.hid
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Gilles Chanteperdrix wrote:
>> Yasser Kashfi wrote:
>>> Hi
>>> Thanks Gilles for your notes. The problem is solved.
>> Well... not exactly, it shows that the problem is using highmem, but we
>> should now modify xenomai so that it supports using highmem.
>>
> 
> 
> Hi Yasser,
> 
> here is a patch which is supposed to fix this issue with highmem. Could 
> you apply it and use the same kernel configuration as you used initially
> ? 
> 
> Thanks in advance.

Hi Yasser,

if you do not have time to test this patch, please tell us, we will try
and test it by other means.

Regards.

-- 
                                                 Gilles.

