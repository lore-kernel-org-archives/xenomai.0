Message-ID: <437B5283.6010003@domain.hid>
Date: Wed, 16 Nov 2005 16:38:43 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <OFE0FCA674.602362D5-ONC12570BB.00369D55-C12570BB.00376F54@domain.hid>
In-Reply-To: <OFE0FCA674.602362D5-ONC12570BB.00369D55-C12570BB.00376F54@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [PATCH] Auto-allocation of minor values for pipe
	objects
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

Dmitry Adamushko wrote:
> Philippe Gerum <rpm@xenomai.org> wrote on 15.11.2005 23:17:50:
> 
>  > Dmitry Adamushko wrote:
>  > >
>  > > Hello,
>  > >
>  > > enclosed please find a patch that hopefully adds so desired
>  > > functionality. I have made various tests with it just now and it seems
>  > > to work fine.
>  > >
>  >
>  > Sounds good.
>  >
>  > > A size of the bitmap is dependent on XNPIPE_NDEVS parameter in the 
> same
>  > > vein as xnpipe_states depends on it; so hopefully that is what you 
> have
>  > > meant Philippe (?)
>  > >
>  >
>  > And NDEVS still does not depend on BITS_PER_LONG - yes, that's ok.
>  >
>  > Two minor missing points :
>  >
>  > - Doc update for rt_pipe_create() describing P_MINOR_AUTO
>  > - ChangeLog frag
> 
> Enclosed a final patch.
>

Applied, thanks.

> One thing I wanted to point out is that the exteneded interface is not 
> usable for the "rtai" skin since rtf_create() must know a real minor 
> before calling xnpipe_connect() (at least it's implemented this way at 
> the moment).
> 
> int rtf_create (unsigned minor, int size)
> 
> {
> 
> ...
>    fifo = __fifo_table + minor; <---- That's the reason!
> 
>    err = xnpipe_connect(minor,
>                         &__fifo_output_handler,
>                         &__fifo_exec_handler,
>                         NULL,
>                         fifo); <---- it's already dependent on minor.
> 
> And I don't think, of course, it's a good idea to export a separate 
> interface for allocation of minor values from the nucleus. So either:
> 
> - rtf_create() should be rewritten differently;
> 
> - keep it as is since it looks like the real rtai interface doesn't 
> require such a functionality.
> 
> 

We need to keep the things as they are for the RTAI skin. The art of emulating an 
interface includes mimicking its shortcomings.

-- 

Philippe.

