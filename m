MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17882.5512.521970.784116@domain.hid>
Date: Mon, 19 Feb 2007 22:24:24 +0100
Subject: Re: [Xenomai-core] Re: I-pipe 1.7 breaks mlockall safety check
In-Reply-To: <45D9989E.4070103@domain.hid>
References: <45D45AEA.50404@domain.hid> <1171547803.24117.8.camel@domain.hid>
	<45D46704.9050109@domain.hid> <1171560346.24117.77.camel@domain.hid>
	<45D5746C.1090003@domain.hid> <45D8DF58.2090804@domain.hid>
	<17880.57781.152126.164326@domain.hid>
	<1171842613.13484.17.camel@domain.hid>
	<17880.60750.537420.707178@domain.hid>
	<45D95218.6000602@domain.hid> <45D9989E.4070103@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
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
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
 > May this hunk explain the behaviour?
 > 
 > http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/arch/i386/patches/adeos-ipipe-2.6.20-i386-1.7-02.patch?a=i386;v=SVN-2.3.x#7755
 > 
 > munlockall is realised via mlockall, so OR'ing here would never take
 > away any flag.

My intent was to avoid that the VM_PINNED flag be cleared by mlockall.
So, I guess the correct pattern is:

current->mm->def_flags = current->mm->def_flags & ~VM_LOCKED | def_flags;

-- 


					    Gilles Chanteperdrix.

