Message-ID: <485E654D.3050202@domain.hid>
Date: Sun, 22 Jun 2008 16:44:29 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <16474.81.252.86.91.1211199249.squirrel@domain.hid>
	<12142.81.252.86.91.1211467896.squirrel@domain.hid>
	<2ff1a98a0805220819i8d73166w4c9a06d9734d0e0c@domain.hid>
	<2405.81.252.86.91.1211549465.squirrel@domain.hid>
	<2ff1a98a0805230655j35009227h75c63566373ece43@domain.hid>
	<5871.81.252.86.91.1211789666.squirrel@domain.hid>
	<18491.29266.196753.611570@domain.hid>
	<2766.81.252.86.91.1211992159.squirrel@domain.hid>
	<2ff1a98a0805280931j611ae10er69b968ae8699d63d@domain.hid>
	<16273.81.252.86.91.1212060383.squirrel@domain.hid>
	<2ff1a98a0805290614w3d846e6by69b033204f912391@domain.hid>
	<13639.81.252.86.91.1212153659.squirrel@domain.hid>
	<18496.31292.674733.417262@domain.hid>
	<3380.62.39.72.60.1213367793.squirrel@domain.hid>
In-Reply-To: <3380.62.39.72.60.1213367793.squirrel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem with time-out ends
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Fabien MAHOT <fabien.mahot@domain.hid>
Cc: xenomai@xenomai.org

Fabien MAHOT wrote:
> Hello,
> 
> thank you very much for your work.
> 
> I tried your Xenomai 2.4.4.
> 
> I began to patch a linux kernel 2.6.20.21 with the i386 adeos patch. I
> would to know why you cancelled the i386 adeos patch for linux kernel
> 2.6.23 ?
> 
> So, with the 2.6.20.21, when I execute my test program, I hadn't got a big
> improvement. There were always bugs.
> 
> Then, I patched a linux kernel 2.6.25 with the x86 adeos patch.
> This time, there was a big improvement when I executed my test
> program.But, occasionally, there was a program crash, without bug messages
> in the kernel traces.
> I added debug traces (calls to write function) in my program to understand
> why there was this crash. With theses new traces, I had a big crash of my
> program execution, and the system is also crashed. (I must reboot my
> system)
> In this case, I had a Xenomai fatal message in the kernel traces.
> 
> To sum up my test program :
> 
> In the test program, there are three Xenomai thread :
> threadTimeOutEnd (prio : 85): This thread waits the timeout end thanks to
> a Semaphore (In the timeout end handler, the Semaphore is posted), and
> warns threadTimeOut with a condvar broadcast. This thread calls display
> function to debug the program.
> threadTimeOut (prio : 80): Malloc memory space to create timeout. Set-up
> timeouts of 500ms. Free memory space of achieved timeouts (This thread is
> notified of timeout end with a condvar broadcasted by threadTimeOutEnd).
> This thread must do the timeout end handler processing.This thread calls
> display function to debug the program.
> threadDisplay (prio : 70): Call display function in a loop. Normally, this
> thread ends the test program and displays the stack of timeout end
> numbers. (if necesserray, adjust the loop counter)
> 
> Sorry, my test program is a bit long

This program does not compile due to carriage return added by your 
mailer. This is not the first time I tell you that. Please resend it as 
an attachment.

-- 


					    Gilles.

