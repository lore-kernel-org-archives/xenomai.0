References: <5735F39A.8050204@siemens.com> <57601E35.3010101@siemens.com>
 <5a98b862-5b1f-449c-8989-f7e3d4fe8255@xenomai.org>
 <5760227A.3010203@siemens.com> <20160614153852.GC23680@hermes.click-hack.org>
 <57602631.10900@siemens.com> <20160614155112.GD23680@hermes.click-hack.org>
 <57602AC8.3070506@siemens.com> <20160614161230.GF23680@hermes.click-hack.org>
 <57603007.8010100@siemens.com> <20160614164240.GG23680@hermes.click-hack.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <57603804.7010608@siemens.com>
Date: Tue, 14 Jun 2016 18:59:48 +0200
MIME-Version: 1.0
In-Reply-To: <20160614164240.GG23680@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RTDM syscalls & switching
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2016-06-14 18:42, Gilles Chanteperdrix wrote:
> The original point of my mail was that your assertion that "Linux
> I/O syscalls cause ping pong" is false. How Linux syscalls work, I/O
> or otherwise, with Xenomai, has always been the same.

Yes, s/syscall/library call/ if you want to be that precise. No one
calls syscalls directly from the application, but the standard POSIX
function we are talking about are not doing much more than that. That's
what matters.

Jan


