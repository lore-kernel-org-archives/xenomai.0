Message-ID: <000701c89d68$8857e380$0202a8c0@domain.hid>
From: "van der Linden" <ejvanderlinden@domain.hid>
References: <001f01c89cc6$f269b250$0202a8c0@domain.hid>
	<18433.65.910459.873472@domain.hid>
Date: Sun, 13 Apr 2008 15:16:06 +0200
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Communication between Xenomai and Linux domains
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Gilles, thanks for the answer.

Perhaps I may ask a few more questions?

I have to create an application that is partly real-time (low interrupt 
latency required) and partly non-real-time (also communicating via UDP 
etc.).
Both parts need to communicate (exchange control information). I will create 
multiple threads in this application.

My real-time thread will call the alsa-sound library libasound and use the 
ALSA Linux kernel driver for my sound card.

I gues I have to follow the next steps:

1. Determine the real-time threads and make them Xenomai threads. Also give 
them the right priority.

2. Non real-time threads become Linux threads.

3. Now I can follow two paths

4A. Start linux as a prio 0 Xenomai thread (how do you do that?) and use 
Xenomai IPC methods between Xenomai threads and the Linux threads.
      Side effect; when a Xenomai thread calls a Linux system call, the 
Linux system call is executed with the priority of the calling Xenomai 
thread.
      Also when a Linux thread calls a Xenomai IPC, it will change from 
secondary to primary mode.
      I think calling a Linux system call from Xenomai thread should be 
avoided because the real-time behaviour can be disturbed.

4B. Start Linux as a seperate ADEOS operating system (besides Xenomai) and 
communicate with native skin rt pipes between Xenomai threads and Linux 
threads.
       Xenomai runs in primary mode, Linux runs in secondary mode.
       Is the calling of a Linux system calls from a Xenomai thread 
possible? Can I use the Linux ALSA library lib_asound?
       So, my (Linux) application starts Xenomai threads and Linux threads. 
Xenomai threads can communicate with native skin rt pipes.

What do you recommend for a new application 4A or 4B?

What can be used as performance measurement tool. The normal "top" Linux 
command will only show IRQ's taking almost 100% of the cpu loading.
I gues that must be the Xenomai schedular but how can I display the loading 
the seperate Xenomai threads realy take?

Thanks for helping me.

Ernst-jan


> van der Linden wrote:
> > Hello,
> >
> > I'm quite new to Xenomai.
> >
> > Before further exploring Xenomai, I like to know if it is possible to 
> > communicate between a Xenomai process and a standard Linux process.
> >
> > Is there some reading on this subject?
>
> I answered a similar question yesterday:
> https://mail.gna.org/public/xenomai-core/2008-04/msg00082.html
>
> It was about communicating between threads, whereas you ask about
> communicating between processes. But the answer is pretty much the same;
> native skin pipes and other Xenomai IPCs may be used to communicate
> between different processes.
>
> -- 
>
>
>     Gilles.
> 

