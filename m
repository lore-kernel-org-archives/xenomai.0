Message-ID: <4EF8FBB6.4060107@domain.hid>
Date: Mon, 26 Dec 2011 23:56:54 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4EF27CD5.4060603@domain.hid>
In-Reply-To: <4EF27CD5.4060603@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] hang in rtcansend
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Andrew Tannenbaum <trb@domain.hid>
Cc: xenomai@xenomai.org

On 12/22/2011 01:41 AM, Andrew Tannenbaum wrote:
> Summary: I am having a problem running rtcansend/recv on Xenomai 2.6.0,
> with the processes hanging in their cleanup code.
> 
> I had been running Xenomai on an Intel Atom system with a PEAK PCI
> SJA1000 CAN adapter.
> 
> I was running Linux 2.5.35.7 with Xenomai 2.5.5.2.  I connected a servo
> and motor to the PEAK adapter, and I was able to talk with it using
> rtcansend and rtcanrecv.
> 
> After working on other things for a few months, I need to return to this
> project, so I downloaded the latest Linux/Xenomai pair, which I think is
> Linux 2.5.38.8 and Xenomai 2.6.0.
> 
> I was able to compile these (using the Debian build advice, generating
> .deb files for Linux and Xenomai, which I install with dpkg -i).  I used
> a Linux .config derived from my older build.
> 
> With both the new and old installs, I am able to run xeno-test and get
> decent latencies and such, though some of the tests fail depending on
> what I have configured in Realtime/Drivers/Testing Drivers.  That is not
> what I'm asking about.
> 
> 
> 
> I am having a problem running rtcansend/recv on Xenomai 2.6.0:
> 
> I can run rtcanconfig and it sets up my rtcan0 properly so I can see and
> configure the servo.  The data in /proc/rtcan looks ok.
> 
> But when I try to talk with the servo using rtcansend, the rtcansend
> process fails during the close phase, it looks like this:
> 
> $ rtcansend rtcan0 -v -i 0x0 0x82 0x1
> interface rtcan0
> s=0, ifr_name=rtcan0
> <0x000> [2] 82 01
> Cleaning up...
> ^CSignal 2 received
> Cleaning up...
> $
> 
> So it hangs after the first "Cleaning up..." and I hit Control-C and
> then it catches the ^C and exits.  The code at the bottom of

After various attempts, the bug happens when the main thread exits with
pthread_exit while other threads exist in the process. It was already
there in 2.5.6 at least, but we did not see it with rtcansend because
there was no other thread than the main thread, while in 2.6.0, there is
now the rt_print thread running.

-- 
                                                                Gilles.

