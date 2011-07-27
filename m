Message-ID: <4E305DAB.80402@domain.hid>
Date: Wed, 27 Jul 2011 20:49:15 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4E299162.8000309@domain.hid>
In-Reply-To: <4E299162.8000309@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] __wrap_clock_gettime
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

On 07/22/2011 05:04 PM, Jan Kiszka wrote:
> Hi Gilles,
> 
> pulling assert_context.c into the common libxenomai created a problem
> around picking the right __wrap_clock_gettime. As libpthread_rt depends
> on libxenomai, the latter is loaded first and defines the debug version
> of __wrap_clock_gettime as the default. There is no chance to pull the
> posix skin implementation.
> 
> I don't have a nice idea yes how to resolve this. Options are:
>  - drop __wrap_clock_gettime from assert_context.c (affects any skin
>    user != posix)
>  - put assert_context stuff into separate library again
>  - put __wrap_clock_gettime in all skin libs != posix
> 
> I'm favoring the simplest approach ATM, ie. the first one. Other ideas?

I agree, but I would have thought __attriibute__((weak)) takes care of
this issue.

-- 
                                                                Gilles.

