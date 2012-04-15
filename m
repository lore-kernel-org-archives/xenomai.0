Message-ID: <4F8AD9E6.1040005@domain.hid>
Date: Sun, 15 Apr 2012 16:23:34 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <DUB114-W7121A0DDCD5D2E2B7CD801AF3B0@domain.hid>
In-Reply-To: <DUB114-W7121A0DDCD5D2E2B7CD801AF3B0@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_event_wait makes linux crash if executed
 while debugging with gdbserver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Fabio Visona <fabioviso@domain.hid>
Cc: xenomai@xenomai.org

On 04/13/2012 04:49 PM, Fabio Visona wrote:
> Hello,
>  
> I am trying to debug a Xenomai task through gdbserver over ethernet, with:
>  
> gdbserver host:12345 --attach 240
>  
> where 240 is the PID of the Xenomai real-time task I want to debug.

You are supposed to debug the whole process, not attach to just one
thread. So, you should pass the pid of the process main thread.

> Execution crashes at EXCPT 0x0, which should be a system call, according
> to Xenomai sources (syscall.h).
>  
> Xenomai version is 2.5.3, Linux 2.6.34.7, running on a Blackfin BF518
> processor.

Please try with xenomai 2.5.6, and if it does not work, it would be nice
if you could try 2.6.0.

-- 
                                                                Gilles.

