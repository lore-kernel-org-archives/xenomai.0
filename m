Message-ID: <4D3EB23D.1030500@domain.hid>
Date: Tue, 25 Jan 2011 12:21:33 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <alpine.DEB.1.10.1101251010320.12329@domain.hid>
	<4D3E97D5.3050609@domain.hid>
	<alpine.DEB.1.10.1101251049460.12329@domain.hid>
	<4D3E9D71.7040008@domain.hid>
	<alpine.DEB.1.10.1101251215520.12329@domain.hid>
In-Reply-To: <alpine.DEB.1.10.1101251215520.12329@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] NULL pointer access on bfin when linking with
 xenomai and pthread
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenoka09@domain.hid
Cc: xenomai@xenomai.org

Kolja Waschk wrote:
> Hi,
> 
>> If not, recompile xenomai with --enable-debug, try and put a breakpoint
>> on the function xeno_sigshadow_handler.  If you hit the breakpoint, try
>> and execute the function step by step, looking whether a pointer could
> 
> The breakpoint isn't hit...
> 
> With following setup:
> 
> # continue to "_dl_get_ready_to_run" to be able to load symbols
> break *($pc - 0xC60 + 0x41B6)
> cont
> 
> sharedlibrary
> break xeno_sigshadow_handler
> break main
> 
> ... the output is as quoted below. Should xeno_sigshadow_handler be called as an
> immediate result of xeno_sigshadow_install? If I break on xeno_sigshadow_install,
> the fault doesn't occur and execution continues without problems to main()...

Well, I am not sure about this. A signal should be received as a result
of the call to __wrap_pthread_setschedparam, but the application should
receive it well before the handler is installed. So, this signal is
probably ignored by default, which somehow makes the thing work.

Anyway, what you can try to do is to mask the SIGSHADOW signal with
pthread_sigmask around the call to sigaction, in order to avoid whatever
race seems to happen with the libpthread library.

-- 
                                                                Gilles.

