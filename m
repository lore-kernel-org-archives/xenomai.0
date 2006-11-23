Subject: Re: [Xenomai-help] Debugging in Xenomai
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB015D5270@domain.hid>
References: <DD39B5C3F4963040ADC9768BE7E430CB015D5270@domain.hid>
Content-Type: text/plain
Date: Thu, 23 Nov 2006 18:23:31 +0100
Message-Id: <1164302612.5006.548.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2006-11-23 at 15:25 +0000, Daniel Schnell wrote:
> Hi,
>  
> our application deadlocks from time to time. 
>  
> To isolate which of the threads are deadlocked, I look
> into /proc/xenomai/stat. Here I can see if there are context switches
> happening or not. Further I can see which threads have which PID and
> which task state they are into. One of the task states that is not
> clear to me btw is the state "X" or "relaxed shadow". Anybody ?
>  

It's running under the control of the Linux scheduler (secondary mode).
The fact that SIGINT seems blocked for your application over GDB is no
good sign, and this is what needs to be investigated. Is SIGINT properly
handled (i.e. causing GDB to take control back) before your application
enters this wild state? E.g. does hitting ^C over GDB while your
application is initializing, and maybe later during the routine
processing work? When does this apparently stop working?

I'm trying to find out whether the fact that SIGINT is not being caught
anymore is related to the deadlocked state here.

Another thing: what does 'ps' say when the application looks deadlocked?

-- 
Philippe.



