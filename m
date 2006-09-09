Message-ID: <45029746.9060302@domain.hid>
Date: Sat, 09 Sep 2006 12:28:22 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] tdm_event_timedwait documentation
References: <20060909011533.GE1192@domain.hid>
In-Reply-To: <20060909011533.GE1192@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Bernhard Walle <bernhard.walle@domain.hid>
Cc: xenomai@xenomai.org

Bernhard Walle wrote:
> Hello,
> 
> IMO the documentation of tdm_event_timedwait is a bit unclear. There
> are two timeout values: the timeout and the timeout sequence. After
> reading the source code the behaviour is clear but from documentation
> I would have expected following behaviour:
> 
>    - the sequence timeout is the sum of the timeouts over all calls
>      (which is in case)
> 
>    - the timeout in the parameter is the maximum timeout of this call
>      (which is not in case)
> 
> If I didn't get the source code totally wrong
> 
>         if (timeout < 0) {
>             err = -EWOULDBLOCK;
>             goto unlock_out;
>         }
> 
>         if (timeout_seq && (timeout > 0)) {
>             /* timeout sequence */
>             timeout = *timeout_seq - xnpod_get_time();
>             if (unlikely(timeout <= 0)) {
>                 err = -ETIMEDOUT;
>                 goto unlock_out;
>             }
>             xnsynch_sleep_on(&event->synch_base, timeout);
>         } else {
>             /* infinite or relative timeout */
>             xnsynch_sleep_on(&event->synch_base, xnpod_ns2ticks(timeout));
>         }
> 
> the timeout value is only interesting if RTDM_TIMEOUT_NONE or
> RTDM_TIMEOUT_INFINITE otherwise it's not relevant because it's
> overwritten by the value of the timeout sequence. That should be
> expressed in the documentation.

This overwriting only takes place if timeout_seq is non-NULL. Otherwise,
we are in "usual" timeout mode.

> 
> Maybe
> 
>  * @param[in] timeout Relative timeout, see
>  * @ref RTDM_TIMEOUT_xxx for special values (any positive value
>  * means the timeout specified in the timeout sequence)
> 
> or something like that.

No, that's wrong then. I guess we rather need something like this:

"@param[in] timeout Relative timeout in nanoseconds, see @ref
RTDM_TIMEOUT_xxx for special values; pass the overall timeout of the
related series if timeout_seq is non-NULL"

Does this help to clarify the situation? BTW, the same applies to
rtdm_sem_timeddown and rtdm_mutex_timeddown, all of those could be
combined in such a series.

> 
> 
> Regards,
>   Bernhard
> 
> PS: As there are more and more RTDM-related questions (not only from
> me :)) -- what do you think about a mailing list for real-time drivers
> only? Which means a common list for RTAI and Xenomai. 
> 
> Because I'm using both systems for evaluation I'm always a bit unsure
> to which list I should write (well, if it's not RTAI specified I wrote
> to the Xenomai list because I know you're working on Xenomai and the
> RTAI implementation is from Paolo Mantegazza ;)).

RTDM specification and development only take place over Xenomai, RTAI
later adopts what we implement here. And this will quite likely remain
so in the future. Therefore, the best place to discuss also abstract
RTDM question is here, maybe later on a dedicated xenomai-drivers list
when the traffic increases.

For oddities of the RTAI implementation there is still the RTAI list
where I'm subscribed as well and can jump in when required.

Jan

