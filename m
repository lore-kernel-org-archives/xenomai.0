From: Christoph Permes <christoph.permes@domain.hid>
In-Reply-To: <1251103248.2922.14.camel@domain.hid>
References: <1251101267.3754.18.camel@domain.hid>
	<1251103248.2922.14.camel@domain.hid>
Date: Tue, 25 Aug 2009 10:10:39 +0200
Message-Id: <1251187839.4303.8.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Subject: Re: [Xenomai-help] No core files for segmentation faults in
 realtime tasks
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Am Montag, den 24.08.2009, 10:40 +0200 schrieb Philippe Gerum:
> On Mon, 2009-08-24 at 10:07 +0200, Christoph Permes wrote:
> > Hi,
> > 
> > I have a realtime application running in user space that sometimes terminates with a segmentation fault. 
> > I get a message segfault at 4c4f5200 ip b7cb98d8 sp b7ef7354 error 4 in libc-2.7.so[b7c5e000+138000], 
> > but there is no core file writen, although ulimit is set to unlimited.
> > 
> > I wrote a small test program that produces a segmentation fault and I get a core file when the segfault
> > happens before the realtime task starts but not when it happens in the task.
> > 
> > Is it somehow possible to enable writing core files also for realtime tasks?
> 
> This feature is not disabled for real-time tasks actually, so there must
> be something else at work.
> 
> You may want to send your small test case, and give more details about
> your hardware and software configuration, at the very least the CPU
> architecture your code runs on, the Xenomai, I-pipe patch, and kernel
> release numbers.
> 

I'm using kernel 2.6.29 now, it turned out that this kernel version
handles core dump files not the same way as 2.6.22 which I used
previously.
Now every core dump is written to the same file, while my old kernel
generated a separate file for every core dump. Therefore it seemed that
no core files are written.
I solved the problem by adjusting /proc/sys/kernel/core_pattern to get
the old behavior.

Christoph



