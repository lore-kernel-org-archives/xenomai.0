Date: Tue, 28 Feb 2006 10:15:40 -0800
From: Steven Seeger <steve@domain.hid>
Message-ID: <C029D34C.25A3%steve@domain.hid>
In-Reply-To: <44048E34.2020207@domain.hid>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Content-transfer-encoding: 7bit
Subject: [Xenomai-core] Re: [Xenomai-help] rt_task_wait_period() and overruns
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: xenomai@xenomai.org

I do not recall having this problem with fusion, but I'll take your word on
it. I don't have time to go back and check. :)

Purging the overrun count when rt_task_wait_period() is called may work but
not for all conditions. For example, say I am monitoring a patient's
heartbeat by taking an A/D reading every 1 ms in order to build an ECG
waveform. If I have 4 overruns, I've got a problem because I've missed
crucial data, and this is a serious problem. Of course, it isn't the RTOS's
job to create an error condition in this fashion. But on the other hand, it
woudln't be desirable to have 4 duplicate measurements in such a waveform,
either. The user could check the overrun count himself already, if desired.

The problem with purging the overrun count is that a lot of periodic threads
use counters to perform certain actions. Say my thread runs every 1 ms, so
every 500 times I want to toggle an LED to make it blink at a rate of 2 Hz.
If the overrun counter is purged, then such behavior is going to mess up the
counter. If there is a momentary loss of realtime due to a higher priorituy
thread going nuts, the light will still most likely blink at the right time.

Perhaps the best option would be to make this a task property that users can
set? Keep the current behavior by default, but purge overruns if they so
desire. The cost of this would be only one branch condition in
rt_task_wait_period().

Steven


On 2/28/06 9:53 AM, "Philippe Gerum" <rpm@xenomai.org> wrote:

> Steven Seeger wrote:
> Right (except that fusion never exhibited the behaviour you described,
> though). 
> Still, there is an interesting question that remains which you indirectly
> brought 
> in, and which is the real issue to worry about: does rt_task_wait_period(), as
> it 
> is now, behave in the best interest of users who happen to use it properly?
> 
> I mean: if the application misses several deadlines because something is going
> wild in there, wouldn't the recovery procedure be easier if one knows at once
> how 
> many deadlines have been missed in a raw, without having to call the RTOS
> back. 
> IOW, do we want to purge the overrun count after the first notification and
> make 
> rt_task_wait_period return this count (e.g. ala Chorus/OS's thread pools), or
> would it be preferable to keep the things the way they are now?
> 
> Breaking the API again is also an issue, albeit we already broke it for a few
> other calls when working on v2.1 anyway.
> 
> Open question. Something like a poll, actually.


