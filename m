Date: Wed, 20 May 2015 02:13:22 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150520001322.GI10686@hermes.click-hack.org>
References: <555BA2F4.4030106@techfak.uni-bielefeld.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <555BA2F4.4030106@techfak.uni-bielefeld.de>
Subject: Re: [Xenomai] rtdm_driver.h fails to build: implicit declaration of
 smp_mb__before_atomic_dec()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Robert Haschke <rhaschke@techfak.uni-bielefeld.de>
Cc: xenomai@xenomai.org

On Tue, May 19, 2015 at 10:54:12PM +0200, Robert Haschke wrote:
> I'm trying to build Xenomai 2.6.4 on linux 3.18.13 with i-pipe patch for
> 3.18.12.
> When enabling RTDM support, the compiler throws the following error:
> 
> In file included from ../kernel/xenomai/skins/posix/syscall.c:40:0:
> ../include/xenomai/rtdm/rtdm_driver.h: In function ‘rtdm_context_unlock’:
> ../include/xenomai/rtdm/rtdm_driver.h:587:2: error: implicit declaration of
> function ‘smp_mb__before_atomic_dec’ [-Werror=implicit-function-declaration]
>   smp_mb__before_atomic_dec();
>   ^
> cc1: some warnings being treated as errors

That question again.

Xenomai developers do not have access to a crystal ball or to an
IPOT network. Thus, a released version of Xenomai only supports the
I-pipe patches which were released prior to its release. For this
reason, Xenomai 2.6.4 does not support Linux kernel versions more
recent than 3.14. For more recent releases, use the git repository.


> 
> This function became deprecated in kernel 3.16 and was removed in 3.18.

Ah, maybe this explain this commit then:

https://git.xenomai.org/xenomai-2.6.git/commit/?id=d7f7e99ea19eb0dc13b1e02e633ec53ac9b89475


-- 
					    Gilles.

