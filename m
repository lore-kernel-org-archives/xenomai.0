Subject: Re: SCHED_WEAK vs linux regular threads
References: <4a206d9deb77bc032eef9c689aa1266cf9ed12c3.camel@sprinte.eu>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <14cada63-0f68-5018-688e-c952533624a5@xenomai.org>
Date: Thu, 1 Aug 2019 13:27:37 +0200
MIME-Version: 1.0
In-Reply-To: <4a206d9deb77bc032eef9c689aa1266cf9ed12c3.camel@sprinte.eu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Julien Blanc <julien.blanc@sprinte.eu>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 8/1/19 11:53 AM, Julien Blanc via Xenomai wrote:
> Hi,
> 
> I'm a bit puzzled about how SCHED_WEAK behaves vs linux regular
> threads.
> 
> Suppose a kernel built without CONFIG_XENO_OPT_SCHED_WEAK (so, only 0
> is a valid value for sched_priority, which should be the same as
> SCHED_OTHER).
> 
> Let’s say i have four threads :
> * thread 1, RT, with SCHED_FIFO policy and a sched_param value of 90
> * thread 2, RT, with SCHED_WEAK policy and a sched_param value of 0
> * thread 3, RT, with SCHED_WEAK policy and a sched_param value of 0
> * thread 4, non-RT, with SCHED_RR policy and a sched_param value of 30
> 
> Now, what happens regarding the scheduling ?
> * thread 1 always run first as long as it does not leave the primary
> domain

Yes.

> * thread 2 and 3 enters the primary domain only during xenomai xthread-
> only calls ? And leaves it just after.

Correct, unless they hold some Cobalt mutex(es) in which case the switch
back to secondary mode is deferred until the (outer) mutex is dropped.

> * if thread 2 and 4 competes for the CPU (while thread 2 is in the
> secondary domain), who is given CPU ?

thread 4, since in secondary mode this would be SCHED_OTHER(thread2) vs
SCHED_RR(thread4).

> * how does thread 2 and 3 competes (while in secondary mode) against
> linux kernel (while in secondary mode) ? And other programs ? (ie, can
> a SCHED_WEAK process eating all cpu hang the whole linux system, like
> with standard RT threads).

Cobalt [SCHED_WEAK,0] translates to Linux [SCHED_OTHER]
Cobalt [SCHED_WEAK,1-99] translates to Linux [SCHED_FIFO,1-99]

So you could definitely starve other threads with the latter if running
a busy loop in secondary mode.

> * is there a way to prioritize thread 2 and thread 3 (while in the
> secondary domain) ?

You need to give them non-zero SCHED_WEAK priorities to do that, which
would translate as SCHED_FIFO,<prio> on the plain Linux side.

 (for example by adjusting a posix only priority).
> Or is it the whole reason behind CONFIG_XENO_OPT_SCHED_WEAK ?
> 

The whole idea behind SCHED_WEAK - which is an extension of the original
behavior of SCHED_OTHER,0 threads already available with Xenomai 2.x to
the regular SCHED_FIFO class - is about keeping the priority order
consistent for threads which need to cross primary/secondary domain
boundaries, while ensuring that those threads - when running in primary
mode - cannot compete with Cobalt-managed real-time scheduling classes.

IOW, there is a hierarchy in scheduling classes, which Cobalt abides by
when looking for the next thread to run (by decreasing priority order):

1. SCHED_FIFO, SCHED_RR (round-robin is in essence FIFO+quantum timer)
2. SCHED_QUOTA
3. SCHED_SPORADIC
4. SCHED_TP
5. SCHED_WEAK (when members run in primary mode)
6. SCHED_IDLE (regular inband/secondary mode context when there is no
Cobalt activity basically, including SCHED_WEAK threads running in
secondary mode)

-- 
Philippe.

