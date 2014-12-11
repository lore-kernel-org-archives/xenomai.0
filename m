Date: Thu, 11 Dec 2014 22:37:10 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141211213710.GH27793@hermes.click-hack.org>
References: <5489E65F.6000905@nta-inc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5489E65F.6000905@nta-inc.net>
Subject: Re: [Xenomai] xenomai-3.git next branch build failure
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeff Webb <jeff.webb@nta-inc.net>
Cc: Xenomai <xenomai@xenomai.org>

On Thu, Dec 11, 2014 at 12:45:51PM -0600, Jeff Webb wrote:
> When trying to compile the 'next' branch of xenomai-3.git under Ubuntu 14.04, I get this error:
> 
> Making all in autotune
> make[2]: Entering directory `/home/webb-ja/deb/xenomai-3.git.test/utils/autotune'
> gcc -DHAVE_CONFIG_H -I. -I../../include  -I/home/webb-ja/deb/xenomai-3.git.test/lib/cobalt/arch/x86/include -I/home/webb-ja/deb/xenomai-3.git.test/kernel/cobalt/arch/x86/include -DNDEBUG -O2 -D_GNU_SOURCE -D_REENTRANT -pipe -fstrict-aliasing -Wall -Wstrict-prototypes -Wmissing-prototypes -Wno-long-long -Wno-unused-parameter -Werror -D__XENO__ -D__IN_XENO__ -I/home/webb-ja/deb/xenomai-3.git.test/include/cobalt -I../../include    -MT autotune-autotune.o -MD -MP -MF .deps/autotune-autotune.Tpo -c -o autotune-autotune.o `test -f 'autotune.c' || echo './'`autotune.c
> autotune.c: In function ‘main’:
> autotune.c:298:9: error: ignoring return value of ‘daemon’, declared with attribute warn_unused_result [-Werror=unused-result]
>    daemon(0, 0);
>          ^
> cc1: all warnings being treated as errors
> make[2]: *** [autotune-autotune.o] Error 1
> make[2]: Leaving directory `/home/webb-ja/deb/xenomai-3.git.test/utils/autotune'
> make[1]: *** [all-recursive] Error 1
> make[1]: Leaving directory `/home/webb-ja/deb/xenomai-3.git.test/utils'
> make: *** [all-recursive] Error 1
> 
> I see this sort of thing often due to Ubuntu's default compiler flags settings.  I applied the attached patch to fix it.

Yes, thanks. I think Jorge already proposed a similar fix, but I can
not find where I put it. So, I will take your patch. Just a note, is
the "error" function defined for uclibc ?

-- 
					    Gilles.

