Message-ID: <43B970BA.3080707@domain.hid>
Date: Mon, 02 Jan 2006 19:28:10 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] in-kernel timer benchmark -v3
References: <43B92741.8030609@domain.hid>
In-Reply-To: <43B92741.8030609@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Happy New Year everyone!
> 
> Hope you all survived the turn of the year without complications. ;)
>

Nearly buried alive in patches, but this is hardly a complication.

> I would like to start with a new patch round. The first one is a revised
> and extended version of the earlier posted in-kernel timer benchmark
> based on a RTDM device. Changes since the first version:
> 
>  * revised command line argument to set the test mode
>  * display test mode during startup
>  * display hint on missing benchmark device
>  * support of trace freeze on latency above specified threshold
>  * extended benchmark device to provide ipipe-tracing functions to
>    userspace
>  * further minor fixes
> 

Ok, merged.

> I think the patch should be ready to merge now. This would also be
> helpful to provide a base on which Gilles can build his timer-scaling
> tests. BTW, we still need some RTDM abstraction for timers, but this is
> a different topic that will be addressed later.
> 

Btw, since -rc1 is out, I've deprecated the Adeos oldgen support for all 
archs (ia64 is now I-pipe based too), so that I can merge Dmitry's work 
later on, exclusively into the newgen codebase. So if anyone still keeps 
any venerable pre-Ipipe patch in some hideout of his hdd, just let it go 
now; I know it's heartbreaking, but Xenomai is thankless.

-- 

Philippe.

