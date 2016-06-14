Date: Wed, 15 Jun 2016 00:12:42 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160614221242.GM23680@hermes.click-hack.org>
References: <5a98b862-5b1f-449c-8989-f7e3d4fe8255@xenomai.org>
 <5760227A.3010203@siemens.com>
 <20160614153852.GC23680@hermes.click-hack.org>
 <57602631.10900@siemens.com>
 <20160614155112.GD23680@hermes.click-hack.org>
 <57602AC8.3070506@siemens.com>
 <20160614161230.GF23680@hermes.click-hack.org>
 <57603007.8010100@siemens.com>
 <20160614164240.GG23680@hermes.click-hack.org>
 <57603804.7010608@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57603804.7010608@siemens.com>
Subject: Re: [Xenomai] RTDM syscalls & switching
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On Tue, Jun 14, 2016 at 06:59:48PM +0200, Jan Kiszka wrote:
> On 2016-06-14 18:42, Gilles Chanteperdrix wrote:
> > The original point of my mail was that your assertion that "Linux
> > I/O syscalls cause ping pong" is false. How Linux syscalls work, I/O
> > or otherwise, with Xenomai, has always been the same.
> 
> Yes, s/syscall/library call/ if you want to be that precise. No one
> calls syscalls directly from the application, but the standard POSIX
> function we are talking about are not doing much more than that. That's
> what matters.

Yes and /Linux/Xenomai/ because these library calls are implemented
in Xenomai libraries, not in glibc. Whereas glibc library calls
branch almost unambiguously on Linux syscalls, Xenomai library calls
can either branch to Xenomai syscall or to Linux syscall. So,
calling Xenomai library calls "Linux I/O syscalls" is very
misleading.

-- 
					    Gilles.
https://click-hack.org

