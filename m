Message-ID: <4548A0E8.3070005@domain.hid>
Date: Wed, 01 Nov 2006 14:28:08 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RTDM/ALSA hybrid driver ?
References: <200610251610.36530.witzel.thomas@domain.hid>	<200611010018.34412.witzel.thomas@domain.hid>	<200611011558.17164.rlenglet@domain.hid>
	<200611010745.23388.witzel.thomas@domain.hid>
In-Reply-To: <200611010745.23388.witzel.thomas@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
To: witzel.thomas@domain.hid
Cc: xenomai@xenomai.org

Thomas Witzel wrote:
> On Wednesday 01 November 2006 01:58, Romain Lenglet wrote:
>> Since you wanted to develop/port your own device driver anyway, I
>> just suggested to use JACK as an interface with your
>> applications, instead of the ALSA interface. I believe that the
>> JACK API/interface is better suited for realtime applications.
>> So why not develop your own new JACK hard-realtime backend with
>> your RTDM driver?
> I just wanted to modify an existing driver Intel8x0 AC97 to do realtime 
> playback of  a sample. I'm still pursuing this.
> I have implemented a regular Linux userspace application for this at first and 
> it provides a response latency smaller than 1 ms for 19 out of 20 triggers, 
> but the 20th (on average) has latencies up to 20ms, which is totally 
> unacceptable.

Linux should be able to do better than that. Is your application 
prioritized properly (check for real-time priorities with "man 
sched_setscheduler")? And the kernel option CONFIG_PREEMPT should also 
help.

Wolfgang.


