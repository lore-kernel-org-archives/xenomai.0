Message-ID: <4B1663B9.8030306@domain.hid>
Date: Wed, 02 Dec 2009 13:55:21 +0100
From: Wolfgang Mauerer <wm@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Realtime gettimeofday()
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hi,

we'd like to implement a gettimeofday() mechanism that works
in realtime context, both from user- and kernelland. Most importantly,
the correctins made to the wall time by the NTP protcol on Linux
must be transferred into the Xenomai domain. We have a preliminary
implementation (with several weaknesses) ready, but before we go
into the details of writing a complete solution, it would be
great to have the community's opinion on how to proceed best -- there
are a number of alternatives, each with specific strenghts and
weaknesses. Any comments on the following proposals are very welcome!

Essentially, getting the NTP-corrected time requires three ingredients:

- A clock source.
- A wall time t_{0} as basis, together with the value of the
  clocksource at that moment.
- An NTP-corrected conversion factor between clock ticks and walltime.

Since the NTP correction information holds wrt. a specific clock source,
we have to use the clock source used by Linux.

The Linux kernel provides a vsyscall based solution to the problem:
The base data are periodically copied to a userland-accessible page,
and a vsyscall reads the information using seqlock protection (i.e.,
rereading the information when it was changed during the read
operation). This way, the data can be locklessly relayed into userland,
and perturbation for the kernel is minimal as no lock to write the data
is required.

However, things get a little more involved when realtime comes into
play: Using a simple seqlock that might require rereading the data an
arbitrary number of times contrary to the determinism requirements of
realtime. So far, we can think of three alternatives:

1.) Re-use the vsyscall data from the kernel with a buffered seqlock
    replacement. We cannot directly use the data provided by the Linux
    kernel because Xenomai might have interrupted the update process,
    which leads to an inconsistent state. Instead, we would use a
    "buffered" seqlock that uses two more copies of the data that are
    accompanied by a flag which indicates if some other Xenomai thread
    is currently reading or writing to the data: They are both filled
    with an initial valid copy of the data during Xenomai
    initialisation. When the data are requested in primary mode, Xenomai
    first checks if the Linux seqlock is taken:

    - If the lock is taken, the data provided by Linux may be in an
      inconsistent state, and the backup copies are used.
    - If the lock is not taken, check with the aforementioned
      flag if another Xenomai task is currently updating one of
      the copies.
      - (A) If yes, then read the data from the other copy.
      - (B) If no, perform at most one read try of the Linux data --
        another CPU running the Linux kernel might update them in the
        meantime.
	If they have been read without perturbation,
	mark one copy as being currently updated (naturally,
        we need to flip the flag atomically), update the buffer, and
	use the data. If the data were modified during the read phase,
	discard the result and continue as in (A)

    Note that the flags may also be extended with version
    information to check which buffer has been updated more recently.

    While Xenomai might block the update process for a while,
    we always have at least a consistent copy of the data, and there is
    a fixed upper bound on the time required to compute the current
    NTP-corrected wall time.

2.) Use a transactional mechanism as outlined above to relay the data
    into userland, make sure that the triple (sec,nsec,ticks) is copied
    atomically to avoid an invalid state, and live with the fact that if
    the correction factor is not uptodate, we are only in danger of
    using outdated information, but won't get a completely bogous result
    (a userland application might start to read a buffer that is
    concurrently being updated by another CPU)

3.) Use explicit locking between the Linux kernel and Xenomai to update
    respectively access the data, and partially eliminate the
    performance advantages of the vsyscall mechanism. This would have
    the usual drawbacks associated with locks in primary mode. Besides,
    since a kernel lock is involved, it would not allow for a pure
    userland solution without kernel intervention.

Are there preferences and/or arguments for/against any of these
solutions? Or any better ideas? Thanks in advance for your comments!

Best, Wolfgang


