Message-ID: <521871FD.30705@web.de>
Date: Sat, 24 Aug 2013 10:42:37 +0200
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <5215C4FE.707@inmess.de>
In-Reply-To: <5215C4FE.707@inmess.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] two dd processes: soft lockup
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Benedikt Boeck <benedikt.boeck@inmess.de>
Cc: xenomai@xenomai.org

On 2013-08-22 09:59, Benedikt Boeck wrote:
> Hello,
> =

> I got a problem. After starting two dd processes (if=3D/dev/zero
> of=3D/dev/null), I get first a few messages about soft lockup:
> kernel:[...] BUG: soft lockup - CPU#. stuck for ..s! [dd:...]
> and little later a
> Kernel panic - not syncing: Fatal exception in interrupt
> =

> But if I had running xeno-test before and then starting two dd processes
> I don't get a soft lockup. Strange?
> =

> Also there is no soft lockup with a kernel identical till a deactivated
> CONFIG_XENOMAI.
> A deactivated CONFIG_SMP also prevent the error. But I like to have both
> cores. Trying all four variants of CONFIG_SCHED_SMT=3Dy/n and
> CONFIG_SCHED_MC=3Dy/n didn't effect the error.
> =

> Tested with different kernel versions (3.4.6, 3.5.7, 3.8) always with
> matching ipipe patch.  I think with 3.8 I didn't get a kernel panic but
> still soft lockups.
> Using Xenomai 2.6.2.1 and haven't tried other versions yet. The
> processor is a Celeron Dual-Core T3100.
> =

> Does somebody have a idea? Maybe I just made a simple (but effective)
> mistake.

I've tried your configuration on ipipe-3.8 [1] but wasn't able to
reproduced it in a 2-cpu VM with 2 dd instances. Could you provide the
3.8 config as well that generates the warnings for you? And please
provide the information Gilles asked for,

Thanks,
Jan

[1] http://git.xenomai.org/?p=3Dipipe.git;a=3Dshortlog;h=3Drefs/heads/ipipe=
-3.8


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130824/c6b285c=
9/attachment.pgp>
