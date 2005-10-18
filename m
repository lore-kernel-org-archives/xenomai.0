From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17237.13723.766826.515585@domain.hid>
Date: Tue, 18 Oct 2005 19:49:15 +0200
Subject: Re: [Xenomai-help] compiling xenomai on x86_64
In-Reply-To: <4354AD5A.7010305@domain.hid>
References: <4353F109.7000707@domain.hid>
	<4353F411.4000500@domain.hid>
	<4353F896.1040508@domain.hid>
	<435402B4.5060004@domain.hid> <435403C8.80400@domain.hid>
	<43540531.8050304@domain.hid>
	<435406E0.8020405@domain.hid> <435408E5.8020007@domain.hid>
	<435419B0.8030004@domain.hid>
	<4354AD5A.7010305@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
 > I just analysed this further: the problem disappears when I manually
 > remove any "-I<path-to-kernel-includes>" from the makefiles. Seems to be
 > the well-known user space include issue again... ;)

I tried to compile every kernel arch/i386 has a patch for with gcc 2.95,
3.3 and 3.4, and I saw no issue with inclusions of kernel headers
from user-space. At all.

So, there is definitely something you are doing differently from me. 
If this issue is different from the '-m32' flag issue, could you please
fill a bug report, and this time, attach the exact procedure you are
following to compile (whether in-tree, or out-of-tree, whether using
configure or Kconfig, everything that would allow someone to ), the
.config and .xeno_config files you used, in order for me to be able to
reproduce the problem you observed ?

-- 


					    Gilles Chanteperdrix.

