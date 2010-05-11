Message-ID: <4BE96428.4080104@domain.hid>
Date: Tue, 11 May 2010 16:05:28 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <DFFBF4EB468A894AB1474ED220F05AF60134C0BA@srv-dc.ona-electroerosion.com>
In-Reply-To: <DFFBF4EB468A894AB1474ED220F05AF60134C0BA@srv-dc.ona-electroerosion.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai and/or PREEMPT_RT patch
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Asier Tamayo <asier.tamayo@domain.hid>
Cc: xenomai@xenomai.org

Asier Tamayo wrote:
> Hello all:
> 
> I'm just a newbie to this list, so just forgive me if my question is obvious or has been answered many times ;-)
> 
> I want to do a port from an old system running a proprietary RTOS to a new one based in Linux. My system runs many applications at the same time (GUI, parsers, ...), a few of which are hard real-time. 
> 
> I've seen there are many approaches to the real-time issue in Linux; finally, it seems to me that the only solutions that will last are Xenomai and the PREEMPT_RT patches (OSADL). Am I wrong?

These are surely the primary candidates. More approaches exists, but I
wouldn't start considering them until you reach the limits of the
mentioned ones (which is quite hard these days).

> 
> Can anybody give me some advice about which system to use? Any good comparison I can read? Everything I find comparing real-time Linux approaches seems to be quite out of date.

There are many factors of your scenario that influence a comparison. So
you should sketch your requirements and variables first. To name a few:
 - CPU architecture
 - overview on your critical loop(s)
 - their timing requirements
 - portability of your applications (to decide about application
   adaption vs. legacy OS emulation)

As we are on the Xenomai list, the major strengths (personal opinion) of
this approach should already be mentioned:
 - well extensible to emulate legacy RTOS APIs
 - strict separation between RT and Linux domain - nevertheless, both
   contexts are smoothly usable from within the very same user space
   application

> Should I use Xenomai on its own? Or maybe Xenomai and Linux with the preempt patches applied? Running the GUI, which demands a lot of CPU and RAM, can have any effect on the real-time behaviour?

Independent of the software approach, hardware can always ruin your day,
specifically on x86 (SMI, contentions on I/O buses, shared caches,
etc.). Weather this matters to you, depends on your timing requirements
and how "hard" your real-time has to be.

> 
> Any hint will be really helpful,
> 
> Best regards,
> 
> Asier

HTH,
Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

