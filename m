Message-ID: <2ff1a98a0803070852t73f1c458m6b969019f16732f7@domain.hid>
Date: Fri, 7 Mar 2008 17:52:37 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <d3f72a390803070847w1a5152d1o9d316d8ada2cd12c@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d3f72a390803070847w1a5152d1o9d316d8ada2cd12c@domain.hid>
Subject: Re: [Xenomai-core] ERROR ON COMPILING TRUNK XENOMAI
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: axel axel <softaxel@domain.hid>
Cc: xenomai@xenomai.org

On Fri, Mar 7, 2008 at 5:47 PM, axel axel <softaxel@domain.hid> wrote:
> Hi,
>
> i'm compiling xenomai trunk with the gcc 3.4.3 for ARM.
>
> I have the following error:
>
> thread.c: In function `pse51_thread_init':
>  thread.c:285: error: `_CS_GNU_LIBPTHREAD_VERSION' undeclared (first use in
> this function)
> thread.c:285: error: (Each undeclared identifier is reported only once
>  thread.c:285: error: for each function it appears in.)
> make[3]: *** [libpthread_rt_la-thread.lo] Error 1
>  make[2]: *** [all-recursive] Error 1
> make[1]: *** [all-recursive] Error 1
> make: *** [all-recursive] Error 1
>
> What do you think about this?

My fault, in an attempt to know if we are running linuxthreads or
NPTL, I assumed that _CS_GNU_LIBPTHREAD_VERSION was always defined. If
not defined, we should assume we are using libpthread.

-- 
 Gilles Chanteperdrix

