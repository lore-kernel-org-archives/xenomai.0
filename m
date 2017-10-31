From: =?iso-8859-1?Q?C=E9dric_Perles?= <cperles@sepro-group.com>
Date: Tue, 31 Oct 2017 12:03:50 +0100 (CET)
Message-ID: <006f01d35237$eedce810$cc96b830$@sepro-group.com>
MIME-Version: 1.0
Content-Language: fr
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] ipipe + preempt_rt  : spinlock issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,



I=92m working on an iMX6 based board with NXP kernel 4.1.15.

I made a Xenomai 3.0.5/ipipe bsp that works well and I also made a
preempt-rt bsp that works well too.



However, now I would like to make a Xenomai/ipipe + preempt_rt bsp.



I adapted preempt_rt patch to fit to ipipe patched kernel but during
compilation I=92m facing issues concerning spinlocks:



drivers/gpio/gpio-generic.c:496:2: note: in expansion of macro
'spin_lock_init'

  spin_lock_init(&bgc->lock);

  ^

include/linux/spinlock_rt.h:17:24: error: '__ipipe_spinlock_t {aka struct
<anonymous>}' has no member named 'lock'

  rt_mutex_init(&(slock)->lock);   \





Searching some help on internet, I realized that only a few people tried
to use both Xenomai and Preempt-rt.

=3D> Is it an heresy ? if so, Why ?

I thought it was the best way to limit preemption for the tasks that
switched temporarily to secondary mode.



=3D> If it is not a stupid idea, did somebody already resolve this kind o=
f
conflict ? and how ?



Regards,



C=E9dric.




