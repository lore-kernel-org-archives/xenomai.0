Message-ID: <45EDAB66.9070700@domain.hid>
Date: Tue, 06 Mar 2007 18:56:54 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] process memory not locked
References: <38b44d590703060949lfa70769na93c19abd2ff248f@domain.hid>
In-Reply-To: <38b44d590703060949lfa70769na93c19abd2ff248f@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Saiful Khan <saiful.etc@domain.hid>
Cc: xenomai@xenomai.org

Saiful Khan wrote:
> Hello,
> 
> I have ported my normal GNU/Linux (Posix) application in Xenomai, and I
> have used Xenomai POSIX skin to do the same. In my application main()
> function is spawning a thread using
> pthread_attr_init()
> pthread_attr_setdetachstate()
> pthread_create()
> 
> But as soon as it spawn the thread the following message comes
> *Xenomai*: process *memory not locked* (missing mlockall?), and I do not
> get any message from that thread.
> 
> I have already  locked the paging  in main() as well as in the spawned
> thread using  mlockall(MCL_CURRENT | MCL_FUTURE). After google search I
> didnt found any solution to solve my problem.
> 
> 1. Please tell me the reason? Is there anything I am doing wrong while
> spawning thread?

Are you sure mlockall suceeded ? Check its return value to know.

> 2. What to do so that the thread also run in highest priority?

Use pthread_attr_setschedparam, or pthread_setschedparam.

-- 
                                                 Gilles Chanteperdrix

