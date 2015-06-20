Message-ID: <558579E2.9070507@web.de>
Date: Sat, 20 Jun 2015 16:34:10 +0200
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Mayday issues again
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

Hi Philippe,

the mayday mechanism is causing troubles to me again.

First of all, there is a bug /wrt restarting the mayday syscall. We
current don't restart on pending signals, thus destroy the register of
the interrupted thread that contains the syscall return code. See my
for-forge branch for a fix proposal.

But actually I would like to get rid of the syscall trampoline
completely if somehow possible, at least for certain archs. The reason
is that it ruins debuggability. If a RT thread is stopped by gdb with
the help of the mayday mechanism, it ends up waiting for resumption on
the mayday page. Even worse, backtracing is broken, at least on x86.

That brings me to the key question: why do we need the syscall
trampoline? We set TIP_MAYDAY in the target task, the task causes
IPIPE_TRAP_MAYDAY to be reported via the trap hook, the hook sets the
trampoline code, the trampoline triggers the syscall, and only on
syscall return, we finally migrate the task to Linux. What prevents
doing the migration already in the trap hook, ie. in
handle_mayday_event? The pattern seems similar to the migration we
trigger on userspace faults. And it seems to works, at least for x86,
and doesn't have the unwanted side effects.

The background of this work is improving gdb support, in particular
deterministic stopping and resuming of multi-threaded RT processes. I'm
still in the design & prototype phase, RFC patches will follow later.

Jan

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: OpenPGP digital signature
URL: <http://xenomai.org/pipermail/xenomai/attachments/20150620/34f24c6e/at=
tachment.sig>
