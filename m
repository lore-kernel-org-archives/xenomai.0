Subject: Re: race in timerobj
References: <CAMJ=MEfkw3N1O1t3Nic10sdYO6hrUU7OOR5=a0wi61w1V-23vA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <8149f85c-4d2e-8411-ee9a-86669c5a1532@siemens.com>
Date: Tue, 1 Dec 2020 12:06:23 +0100
MIME-Version: 1.0
In-Reply-To: <CAMJ=MEfkw3N1O1t3Nic10sdYO6hrUU7OOR5=a0wi61w1V-23vA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ronny Meeus <ronny.meeus@gmail.com>, xenomai@xenomai.org

On 01.12.20 11:26, Ronny Meeus via Xenomai wrote:
> Hello Xenomai community,
> 
> it looks like we have a race condition in the timer object handling.
> The scope of the below mentioned issue is the alarm interface of the
> alchemy skin:
> int rt_alarm_start(RT_ALARM *alarm, RTIME value, RTIME interval)
> 
> The documentation mentions that this start can be called also on an
> already running timer:
> "This service overrides any previous setup of the expiry date and
> reload interval for the given alarm."
> 
> In the timer server code (see file lib/copperplate/timerobj.c):
> static void *timerobj_server (void *arg))
> I see the timer being re-inserted in the timeout list in case of a
> periodic timer.
> 
> write_lock_nocancel(&svlock);
> ...
> if (interval.tv_sec > 0 || interval.tv_nsec > 0) {
>   timespec_add(&tmobj->itspec.it_value, &value, &interval);
>   timerobj_enqueue(tmobj);
> }
> write_unlock(&svlock);
> tmobj->handler(tmobj);
> write_lock_nocancel(&svlock);
> }
> 
> This re-insert is done with the svlock taken but the timer specific
> lock is not taken.
> 
> In the start on the other hand I see:
> 
> int timerobj_start(struct timerobj *tmobj,
>   void (*handler)(struct timerobj *tmobj),
>   struct itimerspec *it) /* lock held, dropped */
> {
> tmobj->handler = handler;
> tmobj->itspec = *it;
> ...
> write_lock_nocancel(&svlock);
> 
> So the itspec is updated with only the timerobj lock taken.
> If the timeout value is changed via the timerobj_start while the timer is
> under processing by the timer server, we can enter an endless loop (at
> least that is what we see sporadically)
> 
> Does this make sense?

Yes, at least to me. Patch welcome.

Note, though, that updating the handler will remain inherently racy.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

