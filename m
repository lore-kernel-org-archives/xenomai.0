Message-ID: <511B65C1.4070905@siemens.com>
Date: Wed, 13 Feb 2013 11:06:57 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <DC570CF5-F540-40FB-B313-596AF53EDDA2@mah.priv.at>
	<F43474DF-1ADA-4463-AF44-2B498EF3024E@mah.priv.at>
	<CANKLDmuNom-Eeg_2UO3DBjL8z6SUF=vZJtfgM0URp464mA7evw@mail.gmail.com>
	<511B6481.4010207@siemens.com>
In-Reply-To: <511B6481.4010207@siemens.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] puzzled: running switchtest improves latency figures
	permanently
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henri Roosen <henriroosen@gmail.com>, Michael Haberler <mail17@mah.priv.at>
Cc: Schooner <schooner30@tiscali.co.uk>, sam sokolik <samco@empirescreen.com>, John Morris <john@zultron.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2013-02-13 11:01, Jan Kiszka wrote:
> On 2013-02-13 10:49, Henri Roosen wrote:
>> On Wed, Feb 13, 2013 at 10:26 AM, Michael Haberler <mail17@mah.priv.at>wrote:
>>
>>>
>>> We have a report from 'the field' which we cannot make sense of.
>>>
>>> The situation:
>>> - an AMD board: http://www.asus.com/Motherboard/F1A75M_PRO
>>> - dmesg post boot: http://pastebin.com/38XrxNBy
>>> - xeno-regression-test runs well, max 32us jitter
>>> - John's Xenomai kernel packages:  3.5.7/2.6.2.1 [1]
>>> - a native-skin userland RT threads application (linuxcnc[3])
>>>  - 2 threads
>>>  - jitter measured with its own GUI application 'latency-test'
>>>  - successfully tested on several other platforms
>>>
>>>
>>> what we observed:
>>>
>>> 1. Problem behaviour
>>> ---------------------
>>> - boot
>>> - run LinuxCNC latency-test
>>> - observe massive spikes in latency
>>>  - >100uS on a 25uS thread!
>>>  - http://static.mah.priv.at/public/latency/skunkworks-unprimed.png
>>>
>>> now any of 2), 3) or 4) improve latency:
>>>
>>> 2. run switchtest:  temporary change
>>> ------------------------------------
>>> - while still running LinuxCNC latency-test from 1) above,
>>> - running "/usr/lib/xenomai/testsuite/switchtest -s 1000" in a separate
>>> window
>>> - hit 'Reset Statistics' on the latency-test window
>>> - max latency drops massively
>>> - see http://static.mah.priv.at/public/latency/skunkworks-primed.png [3]
>>> - ^C-ing out of the switchtest makes latency rise again
>>>
>>>
>>> 3. running a trivial shell script:  temporary change during script
>>> execution
>>>
>>> ----------------------------------------------------------------------------
>>> - reboot
>>> - run latency-test, again observe latency spikes
>>> - in a separate window, run:
>>>  - while true; do echo "nothing" > /dev/null; done
>>> - again, latency-test shows rather low latency figures after hitting
>>> 'reset statistics' *as long as the above script is running*
>>> - quote from Sam: "BTW - I ran the latency-test all night with the
>>> donothing scrip and it peaked at about 19.6us latency."
>>> - killing the script makes the latency spikes reappear.
>>>
>>>
>>> 4. running xeno-regression-test and breaking out: permanent drop in latency
>>> --------------------------------------------------------------------------
>>> - reboot
>>> - run latency-test, again observe latency spikes
>>> - in a separate window, run:
>>>   sudo xeno-regression-test -l "/usr/lib/xenomai/testsuite/dohell -m /tmp
>>> 100 " -t 2
>>> - latency drops
>>> - the key observation: if you break by ^C out of xeno-regression-test,
>>> *latency
>>> figures remain low*
>>> - note that breaking out of xeno-regression-test left some processes
>>> running, obviously dd and ls:  http://pastebin.ca/2313116
>>> - once these processes complete ( http://pastebin.ca/2313117) latency
>>> goes up again.
>>>
>>> second data point:
>>> we have a report from another user, same kernel, Intel Q8200 Quad core
>>> board, which confirms 'dohell 900' in a separate window does drop latency
>>> significantly. This suggests it might not board specific.
>>>
>>>
>>> This leaves us puzzled as to the causality here. We would really like to
>>> get rid of the latency spikes, but the shell script approach isnt appealing.
>>>
>>> Any suggestions?
>>>
>>
>> I've seen similar behaviour. In my case it had to do with the latency of
>> transitions of the cpu's idle states. The problem was worked around by
>> providing "nohlt idle=poll". I'm sure it is documented somewhere on the
>> xenomai website too.
> 
> That will burn quite a bit of power, though. Maybe there is some BIOS
> switch to relax power saving mode a bit without giving up on halt. Also,
> do you see the same effect in text mode?
> 
> In any case, confirming the latency source via the ipipe tracer is a
> good first step: http://xenomai.org/index.php/I-pipe:Tracer. You could
> programmaticly break the trace once you detect the spike in your
> program. Post the resulting trace here for public discussion.
> 
> Jan
> 

BTW, though unrelated to the latency issues: Running a 32-bit kernel on
a box with >1GB RAM is not a good choice, performance-wise. PAE is slow...

i386 is for low-end embedded only today. I'll continue testing it, but
it will surely receive less attention than x86-64, just like in mainline
Linux.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

