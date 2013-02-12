Message-ID: <511A396E.2060703@xenomai.org>
Date: Tue, 12 Feb 2013 13:45:34 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <FA4CEC4EBE2FA145A7663764A1CCB31E5C4C8FBB@VOITV-EXCH-BE01.transas.com>
	<FA4CEC4EBE2FA145A7663764A1CCB31E5C4C8FF3@VOITV-EXCH-BE01.transas.com>
In-Reply-To: <FA4CEC4EBE2FA145A7663764A1CCB31E5C4C8FF3@VOITV-EXCH-BE01.transas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Would a Xenomai thread running in secondary mode
 affect the latencies of other Xenomai threads in primary modes ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Zemskov, Evgeny" <Evgeny.Zemskov@transas.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 02/12/2013 01:33 PM, Zemskov, Evgeny wrote:

> Good evening !
> 
> We're developing a system with bunch of Xenomai threads, one of which writes
> the data to some specific device (MIL-STD-1553B bus controller).
> 
> RTDM drivers for this device are not available, and we want to avoid porting
> them to RTDM.
> Since we don't need to wait for any interrupts from this device (we init the
> transmission with some ioctl's which write to the registers of the device and
> write the data being tarnsmitted with __copy_from_user), we've tried to use
> standard Linux drived from Xenomai thread.
> Naturally, on each transmission, the transmitting Xenomai thread switches to
> the secondary mode, but the resulting latency is perfectly OK for us (we
> estimate it at around 50..100 usec).


You probably should not expect a bounded latency from Linux.

> 
> Would such approach cause extra latencies to other Xenomai threads, which run
>  simultaneously in primary mode ?


If you enable CONFIG_XENO_OPT_PRIOCPL and the task running in secondary
mode has a higher priority than other Xenomai threads, then yes.
Otherwise no.

> Also, would there be any problems with constant switches of our writer thread
> between primary and secondary mode ?


It depends on your definition of "problems":
- such a task can not be considered a real-time task
- and the constant switches induces a bit of CPU consumption.

> As far as I understand, on each register access it is switched to secondary
> mode, and on each rt_cond_wait it goes back to primary mode.


You understand right.

-- 
                                                                Gilles.

