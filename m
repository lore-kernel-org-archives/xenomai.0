References: <20210327095417.2289913-1-rpm@xenomai.org>
 <20210327095417.2289913-5-rpm@xenomai.org>
 <556e88f0-6b20-ab48-1d22-d0dcf8a2d8f0@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH 4/8] lib: y2038: convert to internal timespec type
In-reply-to: <556e88f0-6b20-ab48-1d22-d0dcf8a2d8f0@siemens.com>
Date: Wed, 31 Mar 2021 10:13:14 +0200
Message-ID: <87zgyjrbad.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: chensong@tj.kylinos.cn, Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org


Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> Hi Philippe,
>
> which "internal timespec type" are you talking about? You're using
> struct timespec here, which is not y2038 safe on 32 bit platforms.
>

The whole point of these series is solely to enable the code base for
building on the recent kernel series, not to address the y2038
issue. Song and yourself are addressing the later in a series of patches
indirectly based on my tree via wip/dovetail.

So I'm introducing the bits aimed at building on v5.x+ kernels which
includes converting to the new time specification types used upstream,
nothing more. Your fixes on the ia32/compat breakage introduced in the
first attempt are part of this new series (i.e. timeout handling in
compat mode for mq, mutex).

IOW, with that series in, we have a fully functional Xenomai 3.x code
base for the most recent kernel releases running on top of the I-pipe,
still not y2038-safe though. According to several discussions which took
place during the Xenomai community meetings, my understanding is that
your y2038 work lives on top of that code base. As we progress with
merging the rest of my tree in, we will gain the ability to run on top
of Dovetail as well for x86, arm and arm64, so that we can move from
running I-pipe/v5.4 to Dovetail/v5.10 and beyond (Dovetail is already on
track for v5.12).

> I wonder about the effect of splitting the assignments into separate
> tv_sec and tv_nsec assignements. I know this pattern from getting aware
> of different paddings between kernel and user space in case we handle a
> compat application, but this is all library stuff and compat
> applications should use the compat syscalls which hopefully care about
> different paddings...
>

It is not related to padding, this is only a matter of having differents
C types on both sides of the assignment: struct timespec vs struct
__user_old_timespec. As mentioned in the log, this series aims at
clearly delimiting the user / kernel boundary wrt time specification,
so we have different types on both sides. This was intended as prep work
before the y2038 issue is addressed on your end, in order to clarify the
interface. If you don't need it eventually, just drop it as part of your
series making Xenomai y2038-safe.

-- 
Philippe.

