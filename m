Message-ID: <4A925454.8000005@domain.hid>
Date: Mon, 24 Aug 2009 10:50:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1251101267.3754.18.camel@domain.hid>
In-Reply-To: <1251101267.3754.18.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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
To: Christoph Permes <christoph.permes@domain.hid>
Cc: xenomai@xenomai.org

Christoph Permes wrote:
> Hi,
> 
> I have a realtime application running in user space that sometimes terminates with a segmentation fault. 
> I get a message segfault at 4c4f5200 ip b7cb98d8 sp b7ef7354 error 4 in libc-2.7.so[b7c5e000+138000], 
> but there is no core file writen, although ulimit is set to unlimited.
> 
> I wrote a small test program that produces a segmentation fault and I get a core file when the segfault
> happens before the realtime task starts but not when it happens in the task.
> 
> Is it somehow possible to enable writing core files also for realtime tasks?

In addition to what Philippe asked, why do you not try to run your
application directly in gdb? Or with gdbserver? This would workardound
the lack of core file...

-- 
                                          Gilles


