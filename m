From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4C0692A9.2080806@domain.hid>
References: <4C0692A9.2080806@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 09 Jun 2010 12:41:23 +0200
Message-ID: <1276080083.18906.52.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] Mayday support (was: Re: [RFC] Break out of
 endless user space loops)
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>, Tschaeche IT-Services <services@domain.hid>


I've toyed a bit to find a generic approach for the nucleus to regain
complete control over a userland application running in a syscall-less
loop.

The original issue was about recovering gracefully from a runaway
situation detected by the nucleus watchdog, where a thread would spin in
primary mode without issuing any syscall, but this would also apply for
real-time signals pending for such a thread. Currently, Xenomai rt
signals cannot preempt syscall-less code running in primary mode either.

The major difference between the previous approaches we discussed about
and this one, is the fact that we now force the runaway thread to run a
piece of valid code that calls into the nucleus. We do not force the
thread to run faulty code or at a faulty address anymore. Therefore, we
can reuse this feature to improve the rt signal management, without
having to forge yet-another signal stack frame for this.

The code introduced only fixes the watchdog related issue, but also does
some groundwork for enhancing the rt signal support later. The
implementation details can be found here:
http://git.xenomai.org/?p=xenomai-rpm.git;a=commit;h=4cf21a2ae58354819da6475ae869b96c2defda0c

The current mayday support is only available for powerpc and x86 for
now, more will come in the next days. To have it enabled, you have to
upgrade your I-pipe patch to 2.6.32.15-2.7-00 or 2.6.34-2.7-00 for x86,
2.6.33.5-2.10-01 or 2.6.34-2.10-00 for powerpc. That feature relies on a
new interface available from those latest patches.

The current implementation does not break the 2.5.x ABI on purpose, so
we could merge it into the stable branch.

We definitely need user feedback on this. Typically, does arming the
nucleus watchdog with that patch support in, properly recovers from your
favorite "get me out of here" situation? TIA,

You can pull this stuff from
git://git.xenomai.org/xenomai-rpm.git, queue/mayday branch.


-- 
Philippe.



