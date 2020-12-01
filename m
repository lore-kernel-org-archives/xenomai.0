MIME-Version: 1.0
From: Ronny Meeus <ronny.meeus@gmail.com>
Date: Tue, 1 Dec 2020 11:26:39 +0100
Message-ID: <CAMJ=MEfkw3N1O1t3Nic10sdYO6hrUU7OOR5=a0wi61w1V-23vA@mail.gmail.com>
Subject: race in timerobj
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello Xenomai community,

it looks like we have a race condition in the timer object handling.
The scope of the below mentioned issue is the alarm interface of the
alchemy skin:
int rt_alarm_start(RT_ALARM *alarm, RTIME value, RTIME interval)

The documentation mentions that this start can be called also on an
already running timer:
"This service overrides any previous setup of the expiry date and
reload interval for the given alarm."

In the timer server code (see file lib/copperplate/timerobj.c):
static void *timerobj_server (void *arg))
I see the timer being re-inserted in the timeout list in case of a
periodic timer.

write_lock_nocancel(&svlock);
...
if (interval.tv_sec > 0 || interval.tv_nsec > 0) {
  timespec_add(&tmobj->itspec.it_value, &value, &interval);
  timerobj_enqueue(tmobj);
}
write_unlock(&svlock);
tmobj->handler(tmobj);
write_lock_nocancel(&svlock);
}

This re-insert is done with the svlock taken but the timer specific
lock is not taken.

In the start on the other hand I see:

int timerobj_start(struct timerobj *tmobj,
  void (*handler)(struct timerobj *tmobj),
  struct itimerspec *it) /* lock held, dropped */
{
tmobj->handler = handler;
tmobj->itspec = *it;
...
write_lock_nocancel(&svlock);

So the itspec is updated with only the timerobj lock taken.
If the timeout value is changed via the timerobj_start while the timer is
under processing by the timer server, we can enter an endless loop (at
least that is what we see sporadically)

Does this make sense?

Best regards,
Ronny

