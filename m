Message-ID: <48F70DE3.7000801@domain.hid>
Date: Thu, 16 Oct 2008 11:48:19 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5D63919D95F87E4D9D34FF7748CE2C2A0155D6F0@domain.hid>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A0155D6F0@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] how to build a Xenomai posix library ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roderik.wildenburg@domain.hid
Cc: xenomai@xenomai.org

roderik.wildenburg@domain.hid wrote:
> I did so and called, within the library, every posix_rt-function with
> the prefix __wrap_ : e.g. __wrap_shm_open then I compiled my
> application, which does not use any Xenomai-function, and linked it
> with pthread_rt an rt (-lpthread_rt -lrt) and my new Xenomai-library
> (linking without any wrapping defined). Linking and compiling did not
> produce any error. But, when I call a function in my library, which
> in turn calls __wrap_shm_open, then shm_open fails. When I link my
> application with wrapping (as provided by the XENO_CONFIG-script)
> then everything is fine. Do you have an explanation for this behavior
> or even better a solution ?

__wrap_shm_open only works if you have the CONFIG_XENO_OPT_POSIX_SHM
option enabled. Is it enabled? Note that xenomai posix skin shm support
is mainly useful for sharing memory between kernel and user-space. If it
is enabled, then please tell us what is the value of errno when
__wrap_shm_open fails.

-- 
                                                 Gilles.

