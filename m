From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <alpine.DEB.1.10.1012221612360.11502@domain.hid>
References: <alpine.DEB.1.10.1012211818430.9596@domain.hid>
	<4D110810.1090504@domain.hid>
	<alpine.DEB.1.10.1012221012270.10955@domain.hid>
	<alpine.DEB.1.10.1012221306370.10955@domain.hid>
	<1293025850.22129.15.camel@domain.hid>
	<alpine.DEB.1.10.1012221511320.11502@domain.hid>
	<1293027465.22129.17.camel@domain.hid>
	<alpine.DEB.1.10.1012221612360.11502@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 22 Dec 2010 16:29:11 +0100
Message-ID: <1293031751.22129.21.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] gdb/gdbserver hangs during rt_task_create
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Kolja Waschk <xenoka09@domain.hid>
Cc: Xenomai GNA <xenomai@xenomai.org>

On Wed, 2010-12-22 at 16:25 +0100, Kolja Waschk wrote:
> > wrap-link.sh in the link rules for your app:
> 
> It seems to target a problem when the application is linked statically, but in my case most of the code is put into a dynamic library. I can use the ..posix.wrappers when building the library and
> omit the option when building the executable, but that doesn't seem to make a difference

Check whether the thread manager does attempt to call into the Xenomai
replacement for the pthread_cond_wait call.

> 
> Kolja
> 
> 

-- 
Philippe.



