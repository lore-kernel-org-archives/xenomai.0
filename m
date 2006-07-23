Subject: Re: [Xenomai-core] Xenomai v2.2
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44C3AEB9.5070905@domain.hid>
References: <1153227929.5029.25.camel@domain.hid>	<44BE8ECF.2050608@domain.hid>
	<44BE943E.80302@domain.hid>	<44BEA974.40708@domain.hid>
	<44BFC5FA.6080608@domain.hid> <44BFFC62.8030601@domain.hid>
	<44C21AF8.3000906@domain.hid> <44C25DA7.6020302@domain.hid>
	<44C287C4.30209@domain.hid>  <44C3AEB9.5070905@domain.hid>
Content-Type: text/plain
Date: Sun, 23 Jul 2006 22:24:12 +0200
Message-Id: <1153686253.8053.5.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On Sun, 2006-07-23 at 19:15 +0200, Jan Kiszka wrote:
> Hannes Mayer wrote:
> > Hi Jan!
> > 
> > Jan Kiszka wrote:
> >> What about addr2line -e vmlinux -f c01d68b2?
> > 
> > # addr2line -e vmlinux -f c01d68b2
> > xnshadow_ppd_insert
> > shadow.c:0
> > 
> >> Ok, will keep you posted!
> > 
> > Tante grazie e buon fine settimana,
> > Hannes.
> > 
> 
> Please try "make clean" before rebuilding your 2.4 kernel with a
> different timer support. For me this fixed the issue (2.4 build system
> seems to fail catching all dependencies, thus some struct sizes don't
> get updated consistently).
> 

For the record, I did run into the very same issue this afternoon while
trying to reproduce this crash on 2.4.32: invalid dereference from
kernel at offset #240 when starting the latency test, right after having
armed the periodic timing support from a previous configuration that
lacked it. A clean rebuild did fix the issue.

> The only thing that still puzzles me is that my crash happened at a
> different code line. Anyway, might be due to other .config differences.
> 
> This digging in 2.4 over x86 was "worthwhile": Two further corner-case
> bugs found, though not all fixed yet.
> 
> Jan
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



