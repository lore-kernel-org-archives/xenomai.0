Subject: Re: [Xenomai-core] [BUG] timer issues with SVN head
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45C33513.9070704@domain.hid>
References: <45C225D1.7060503@domain.hid> <1170409213.4981.4.camel@domain.hid>
	<45C33513.9070704@domain.hid>
Content-Type: text/plain
Date: Fri, 02 Feb 2007 15:41:01 +0100
Message-Id: <1170427261.4981.74.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Reply-To: rpm@xenomai.org
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

On Fri, 2007-02-02 at 13:56 +0100, Jan Kiszka wrote:
> Philippe Gerum wrote:
> 
> > On Thu, 2007-02-01 at 18:39 +0100, Jan Kiszka wrote:
> >   
> >> Hi,
> >>
> >> just to save my current finding and maybe trigger some feedback:
> >>
> >> We just tried both 2.3.x-SVN and trunk with our "reference robot". While
> >> 2.3.x behaves fine, weird things happened with trunk /wrt some serial
> >> device. We saw reception timeouts and no serial IRQs.
> >>
> >> So I fired up a second box with plain latency test (all the latest: SVN,
> >> 2.6.19.2, ipipe-i386-1.6-06):
> >>
> >>     
> >>> root@domain.hid :/root# latency      
> >>> == Sampling period: 100 us
> >>> == Test mode: periodic user-mode task
> >>> == All results in microseconds
> >>> warming up...
> >>> RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
> >>> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
> >>> RTD| 1299105.405| 1505168.638|  -14316.105|    3671| 1299105.405|  -14316.105
> >>>       
> >
> > I can't reproduce this here, so this is likely an untested configuration
> > issue again.
> >
> > .config welcome. TIA,
> >
> >   
> What about a patch? =8)
> 

Even better, thanks. I should really work with
CONFIG_XENO_OPT_TIMING_PERIODIC enabled sometimes...

> --- include/nucleus/timebase.h  (revision 2094)
> +++ include/nucleus/timebase.h  (working copy)
> @@ -183,7 +183,7 @@ static inline xnticks_t xntbase_get_jiff
>  
>  static inline xnticks_t xntbase_get_rawclock(xntbase_t *base)
>  {
> -	return xntbase_get_jiffies(base);
> +	return xntbase_periodic_p(base) ? base->jiffies : xnarch_get_cpu_tsc();
>  }
>  
>  int xntbase_alloc(const char *name,
> 
> 
> This fixes at least one symptom I found, the broken latency test, but we still need
> to re-check the serial device scenario on the robot. That will take longer
> unfortunately.
> 
> Jan
> 
> 
-- 
Philippe.



