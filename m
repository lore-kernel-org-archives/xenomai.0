Date: Wed, 1 Jul 2015 11:20:50 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150701092050.GD3641@hermes.click-hack.org>
References: <CAL5YyVbm6rHu0QFyfMZbrVdDAeHmJrtrggbsAyERdC5HhaeQng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL5YyVbm6rHu0QFyfMZbrVdDAeHmJrtrggbsAyERdC5HhaeQng@mail.gmail.com>
Subject: Re: [Xenomai] Kernel compilation problem x86
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ACO31 <alain.cordat@gmail.com>
Cc: xenomai@xenomai.org

On Wed, Jul 01, 2015 at 11:02:56AM +0200, ACO31 wrote:
> Hello,
> 
> I want to compile the RC5 of Xenomai 3  for X86 arch
> I use ipipe core 3.16.7-5  accorded to linux kernel 3.16.7 from kernel.org.
> (I've do the same compile for the RC4 without problem)
> no error message for prepare-kernel.sh.
> No problem with kernel make menuconfig.
> But the compile stop with error message about apc.h:
> cobalt/kernel/apc.h no such file or dir
> #include <cocobalt/kernel/apc.h>
> ...
> I re lauch teh compil wit same kernel archive and rc4 to valide archives
> and process:
> No error message...
> Thanks
> alain

The compilation of Xenomai from the archive has been built-tested
(starting tonight, it will be done every night, the report may be
found here: https://click-hack.org/~gilles/bx-forge/)

I also checked that the file include/cobalt/kernel/apc.h may be
found in the archive and it is there. I have also greped the sources
for the typo "cocobalt" and there is no such typo in the archive
sources.

So, obviously either you are compiling otherwise modified sources,
or some out of tree code. Or you introduced the typo while typing
the report and some other issues is causing the problem, like a
particular kernel configuration. But as your mail does not provide
much of the information we would need to try and reproduce your
issue, and which are recommended on our website
(https://xenomai.org//asking-for-help/), we can not help you
much more than that.

-- 
					    Gilles.
https://click-hack.org

