Message-ID: <43C75905.70603@domain.hid>
Date: Fri, 13 Jan 2006 08:38:45 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] rt_pipe_create() and P_MINOR_AUTO
References: <20060112180233.T15311@domain.hid>
In-Reply-To: <20060112180233.T15311@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Kent Borg <kentborg@domain.hid>
Cc: xenomai@xenomai.org

Kent Borg wrote:
> Hello,
> 
> First things first: I am using version Xenomai 2.0.1 on a recompiled
> Ubuntu kernel version 2.6.14.3.
> 
> I am confused by rt_pipe_create(), specifically, the "minor"
> parameter.  The writeup at
> http://snail.fsffrance.org/www.xenomai.org/documentation/branches/v2.0.x/html/api/group__pipe.html#ga20
> says that:
> 
>   Passing P_MINOR_AUTO causes the minor number to be
>   auto-allocated. In such a case, the name parameter must be valid so
>   that user-space processes may subsequently follow the symbolic link
>   that will be automatically created from
>   /proc/xenomai/registry/pipes/name to the allocated pipe device entry
>   (i.e. /dev/rtp*).
> 
> Sounds great, but it doesn't seem true.  <mope>  

eh. P_MINOR_AUTO appears in 2.0.2.

> 
> So I have to manage minor usage be hand until P_MINOR_AUTO is
> implemented, or did I miss something?
> 
> 
> Thanks,
> 
> -kb, the Kent who hasn't had a chance to try the 2.6.15 kernel he
> started playing with last week.
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
> 


-- 

Philippe.

