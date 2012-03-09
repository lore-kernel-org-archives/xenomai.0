Message-ID: <4F5A432F.6000909@domain.hid>
Date: Fri, 09 Mar 2012 18:51:43 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4F5A3E40.4060803@domain.hid>
In-Reply-To: <4F5A3E40.4060803@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] find segmentation fault in real-time-task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Michael Heuer <michael.heuer@domain.hid>
Cc: xenomai@xenomai.org

On 03/09/2012 06:30 PM, Michael Heuer wrote:
> Hi guys, I'm posting the first time and i hope you can help me.
> 
> At the moment i have a segmentation fault in the real-time part of my 
> program (task created with rt_task_create, Xenomai 2.5.6).
> 
> Is there a way to register an signal to print the call-stack?
> 
> If its in the non real-time part the signal is raised and i get my 
> information but in the real-time part i just get an Segmentation fault 
> in the shell...

Using xenomai does not make any difference with regard to that question:
you can, just as without xenomai, register a handler for the SIGSEGV
signal.

But if the segmentation fault is due to a stack overflow (which, I
suspect, is your problem), you will get another segmentation fault in
the segmentation fault signal handler, so, you have to use sigaltstack
to avoid that, but then using the "backtrace" function to walk the call
stack will no longer work, so, you need to use the SA_SIGINFO flag, and
walk the stack yourself extracting the stack pointer register value from
the "context" argument of the signal handler. This is a little complicated.

Another much simpler solution is to use gdb.

-- 
					    Gilles.

