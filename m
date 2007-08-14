Date: Tue, 14 Aug 2007 16:47:17 +0200 (CEST)
From: Klaas Gadeyne <klaas.gadeyne@domain.hid>
In-Reply-To: <46C1B498.8060600@domain.hid>
Message-ID: <Pine.LNX.4.64.0708141629570.18303@domain.hid>
References: <46C02829.9020009@domain.hid> <46C04384.4030805@domain.hid>
	<46C05180.5090302@domain.hid> <46C05690.2010108@domain.hid>
	<46C063E0.1010809@domain.hid> <46C07005.8000504@domain.hid>
	<46C1B498.8060600@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [Xenomai-help] [Ethercatmaster-users] EML conflict with RTCAN?
 low_level_input framebuilding failed.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rolandtollenaar@domain.hid
Cc: Xenomai-help@domain.hid, EML users <ethercatmaster-users@domain.hid>, rtnet-users <rtnet-users@domain.hid>

On Tue, 14 Aug 2007, Roland Tollenaar wrote:
> To refresh, I am running EML and rtcan together and separately they
> appear to function perfectly but when combined, EML sometimes starts
> ejecting the error:

How many threads do you have sending process data, and what are there
priorities? (/proc/xenomai/sched IIRC)

> EC_Telegram::index_check() : index not the same,
> low_level_input() :  framebuilding failed.
>
> Or something pretty closely to that effect.
>
> Despite EML warning that the frame could not be built, the inputs (which
> rely on the framebuilding being succesful pretty stringently) seem to
> function perfectly. It seems as though EML is emitting a false warning.

What do you mean with "inputs functioning perfectly"?

> I have now killed the warning from EML with the following hack:
>
> In EC_Telegram::check_index() I have effectively killed the check by
> snubbing the holler and always returning true. Now the application no
> longer emits warnings and everything functions well (or so it seems). I
> have a sawtooth analog output on a scope which triggers well.

Should I have read s/input/output/g in the above?

> It
> fluttered sometimes when EML emitted the warning. Presumably the
> fluttering is caused by some latency which I thought might be the result
> of EML emitting the warnings. However even without the warnings from EML
> this fluttering incidentally takes place. Generally I can increase the
> chance of this flutter (I will confirm this with a latency test later
> on) by clicking about in the user interface of my application (QT).
>
>
> So EML seems to go haywire when there is latency and there seems to be
> latency when I am using rtcan. (Bit of latency can also be caused by
> clicking about but I think it is mainly rtcan causing the latency spikes
> and the clicking about just knocks it over the edge more often.)
>
> I have also made the index that is supposedly not the same visible. For
> the EML chaps: index and m_idx and the output seems to be something like
> this
>
> index	m_idx
> 0	1
> 0	0
> 1	2
> 2	3
> 2	3
> 3	4
> 4	5
> :	:
> :	:
> 253	254
> 0	2
>
> or something to that effect. Can anyone comment on this?

Is the above the index in the output captured with wireshark or
something else?

AFAIS from the code shouldn't be affected by latency of the PD
thread.  You might uncomment the following log statements to get more
info too (I wonder why they are commented out anyway, Tom?)

static bool ec_rtdm_txandrx(struct EtherCAT_Frame * frame, struct
netif * netif) {
         int tries = 0;
         while (tries < MAX_TRIES_TX) {
                 pthread_mutex_lock (&txandrx_mut);
                 if (low_level_output(frame,netif)){
                         if (low_level_input(frame,netif)){
                                 pthread_mutex_unlock(&txandrx_mut);
                                 return true;
                         }
                         else{
                                 //log(EC_LOG_ERROR,
 				"low_level_txandrx: receiving
 				failed\n");
                                 pthread_mutex_unlock(&txandrx_mut);
                         }
                 }
                 else{
                         //log(EC_LOG_ERROR, "low_level_txandrx:
 			sending failed\n");
                         pthread_mutex_unlock(&txandrx_mut);
                 }
                 tries++;
         }
         log(EC_LOG_FATAL, "low_level_txandrx: failed: MAX_TRIES_TX:
 	Giving up\n");
         return false;

Klaas


