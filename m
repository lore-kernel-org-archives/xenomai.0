Message-ID: <4a206d9deb77bc032eef9c689aa1266cf9ed12c3.camel@sprinte.eu>
Subject: SCHED_WEAK vs linux regular threads
From: Julien Blanc <julien.blanc@sprinte.eu>
Date: Thu, 01 Aug 2019 11:53:27 +0200
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

Hi,

I'm a bit puzzled about how SCHED_WEAK behaves vs linux regular
threads.

Suppose a kernel built without CONFIG_XENO_OPT_SCHED_WEAK (so, only 0
is a valid value for sched_priority, which should be the same as
SCHED_OTHER).

Let’s say i have four threads :
* thread 1, RT, with SCHED_FIFO policy and a sched_param value of 90
* thread 2, RT, with SCHED_WEAK policy and a sched_param value of 0
* thread 3, RT, with SCHED_WEAK policy and a sched_param value of 0
* thread 4, non-RT, with SCHED_RR policy and a sched_param value of 30

Now, what happens regarding the scheduling ?
* thread 1 always run first as long as it does not leave the primary
domain
* thread 2 and 3 enters the primary domain only during xenomai xthread-
only calls ? And leaves it just after.
* if thread 2 and 4 competes for the CPU (while thread 2 is in the
secondary domain), who is given CPU ?
* how does thread 2 and 3 competes (while in secondary mode) against
linux kernel (while in secondary mode) ? And other programs ? (ie, can
a SCHED_WEAK process eating all cpu hang the whole linux system, like
with standard RT threads).
* is there a way to prioritize thread 2 and thread 3 (while in the
secondary domain) ? (for example by adjusting a posix only priority).
Or is it the whole reason behind CONFIG_XENO_OPT_SCHED_WEAK ?

Regards,

Julien










