Message-ID: <50578B21.1010105@xenomai.org>
Date: Mon, 17 Sep 2012 22:42:09 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50578981.4070702@wanadoo.fr>
In-Reply-To: <50578981.4070702@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Impact on mmap behaviour depending on the relative
 position of -lnative in ld command line
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Thierry Bultel <thierry.bultel@wanadoo.fr>
Cc: xenomai@xenomai.org

On 09/17/2012 10:35 PM, Thierry Bultel wrote:

> Hi all,
> 
> I am porting an application that works on x86, linux-2.6.38.8+xenomai-2.5.2, compiler gcc-4.3.2;
> on
> ARM cortexA9; linux-3.2.21+xenomai-2.6.1. compiler is gcc-4.4.6 from crosstools.
> 
> The application uses shared memory between 2 processes, and I have noticed
> that my "mmap" call fails on ARM, whereas it works on x86.
> 
> After a few investigation, I have found out that the reason was somewhere in a Makefile.
> The application uses the posix, rtdm, and native skins.
> 
> Thus I have something like:
> 
> XENO_CONFIG+=$(DESTCMD) $(SYSROOT)/usr/bin/xeno-config
> 
> XENO_FLAGS+=$(shell $(XENO_CONFIG) --skin=posix --ldflags)
> XENO_FLAGS+=$(shell $(XENO_CONFIG) --skin=rtdm --ldflags)
> XENO_FLAGS+=$(shell $(XENO_CONFIG) --skin=native --ldflags)
> 
> And since it makes quite big command lines, this was added at a time:
> 
> # Remove duplicate options
> LDFLAGS=$(sort $(GENERIC_LDFLAGS) $(XENO_FLAGS))
> 
> removing the "sort" basically results in putting back "-lnative" at the end of the 'ld' line and fixes the issue.
> 
> I am just curious to understand what is happening, if is is expected or an ld issue of my given version, because
> I thought that the "-l" options order was not important (and is apparently not on x86).


The order of -l option is important and always has been as far as I
know. What depends on the architecture seems to be the implementation of
the --wrap flag with static libraries, and xenomai uses it.

So, if you are using static libraries, you should use the wrap-link.sh
available in xenomai sources (and even installed).
If you are using dynamic libraries, I do not see how a binary with the
wrong mmap can be generated.

Also note that the rtdm calls are available in the posix skin under
their posix name. So, for instance, you can replace rt_dev_open, with...
open, and stop using the rtdm skin.

-- 
                                                                Gilles.

