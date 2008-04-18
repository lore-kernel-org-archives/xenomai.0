Message-ID: <4808D446.10902@domain.hid>
Date: Fri, 18 Apr 2008 13:03:02 -0400
From: "Steven A. Falco" <sfalco@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Bug in ipipe patch?
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

I don't know if this has already been reported, but I think there is a
bug in file:

    adeos-ipipe-2.6.24-powerpc-DENX-2.1-01.patch

specifically for the file ipipe.c.

The macro "EXPORT_SYMBOL_GPL(tasklist_lock)" appears in two places; once
outside of any ifdef, and once inside the "#else  /* !CONFIG_PPC64 */"
ifdef.

Consequently, when building for a 32-bit processor, I get a "redefined"
error:

/home/sfalco/linux/embedded/ppc3/linux/linux-2.6-denx/arch/powerpc/kernel/ipipe.c:747:
error: redefinition of '__kstrtab_tasklist_lock'
/home/sfalco/linux/embedded/ppc3/linux/linux-2.6-denx/arch/powerpc/kernel/ipipe.c:724:
error: previous definition of '__kstrtab_tasklist_lock' was here

    Steve


