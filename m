Message-ID: <4AD83649.7080109@domain.hid>
Date: Fri, 16 Oct 2009 11:00:57 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <446570.78791.qm@domain.hid>
In-Reply-To: <446570.78791.qm@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] shm_open returns errno 38 - function not
	implemented
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Yigal Goldberger <yigal_gold@domain.hid>
Cc: xenomai@xenomai.org

Yigal Goldberger wrote:
> Hi again,
> 
> I'm trying to create a shared memory area .
> The system is a powerpc based board running linux kernel 2.6.29.4
> and Xenomai 2.4.8 .
> When I call shm_open from user space I get error 38 - function not implemented .

Normally, xenomai's shm_open tries to use the xenomai posix skin service
first, and if it fails (because the shared memory option was not enabled
in the posix skin configuration), falls back to linux service.

You get this error because:
- Xenomai posix skin's shared memory services are not enabled;
- your glibc does not support posix shared memory services (you can
check this in xenomai's config.log, there is a test detecting it).

Now, Xenomai posix skins's shared memory services are to be used if you
want to share memory between a kernel-space real-time posix application,
and a user-space real-time posix application.

So, if this is what you want to do, enable the xenomai posix skin shared
memory services in the kernel configuration (and please upgrade to
xenomai 2.4.9.1, because some bugs in the shared memory support were
fixed recently). If you want to share memory between two user-space
applications, you can also use xenomai shared memory services, but you
are probably better of upgrading your glibc to a glibc which support
posix shared memories.

-- 
                                          Gilles


