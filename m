Message-ID: <474D9337.90206@domain.hid>
Date: Wed, 28 Nov 2007 17:11:35 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <2F8EE677D406514ABE53EF9C0934A666042ABE01@domain.hid>
In-Reply-To: <2F8EE677D406514ABE53EF9C0934A666042ABE01@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Low priority primary mode threads scheduling v
 s	linux regular th read.
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
To: Laurent.POYART@fr.thalesgroup.com
Cc: xenomai@xenomai.org

Laurent.POYART@fr.thalesgroup.com wrote:
> Gilles wrote:
>> The problem is that when Tx2 is running in secondary mode, it needs to
>> voluntary switch to primary mode. When in secondary mode, Tx2 is
>> suspended from Xenomai nucleus point of view, so xnpod_resume_thread
>> cause the SIGHARDEN signal to be sent to Tx2, but Tx2 needs to run a
>> little bit to handle the signal which will cause it to switch to
>> primary mode.
>>
>> So, in my opinion (but I may be wrong) TL will continue to run until
>> it lets Tx2 run.
> 
> I think there is a misundestanding. In my example (see bellow), Tx2 is not in secondary mode . It is a primary mode thread which is blocked while waiting for an RT event (xenomai domain). I wanted to be sure of the scheduling issue between the TL (linux regular thread) which is running and the Tx2 (primary) which becomes runnable.
> In my opinion, TL will continue to run (because of the Tx1 status) but I'm not sure.
> 

Due to priority coupling, that's correct, provided TL undergoes
SCHED_FIFO. The point of such coupling is to make the kernel temporarily
inherit the real-time priority of the Xenomai thread while the latter
runs in secondary mode, so that the priority scheme is preserved as much
as possible during migrations. As such, TL inherits it too and may
compete for the CPU since it runs in the SCHED_FIFO class.

Said differently, Xenomai and plain Linux real-time threads all run in
the SCHED_FIFO class as seen from the Linux scheduler, and start sharing
a common priority scheme as soon as a Xenomai thread switches to
secondary mode, with priority coupling enabled.  Of course, plain Linux
threads running in the SCHED_NORMAL class cannot compete this way for
the CPU.

-- 
Philippe.

