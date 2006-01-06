Date: Fri, 6 Jan 2006 16:32:26 -0500
From: Kent Borg <kentborg@domain.hid>
Subject: Re: [Xenomai-core] heres a go at an
	adeos-ipipe-2.6.15-i386-1.1-01.patch
Message-ID: <20060106163226.X16178@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-reply-to: 43BC87C2.1080503@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Jim Cromie posted a patch attempt for 2.6.15 (yeah!), and the patch
applied, but it doesn't compile for me:

  [...]
    LD      init/built-in.o
    LD      .tmp_vmlinux1
  arch/i386/kernel/built-in.o: In function `__ipipe_sync_stage':
  : undefined reference to `ret_from_intr'
  arch/i386/kernel/built-in.o: In function `__ipipe_sync_stage':
  : undefined reference to `ret_from_intr'
  make: *** [.tmp_vmlinux1] Error 1
  ~/linux-2.6.15$ 

For a .config I started with the stock Ubuntu 2.6.12-10-686 config
file and then took the defaults for all the oldconfig questions.

Suggestions?


Thanks,

-kb


