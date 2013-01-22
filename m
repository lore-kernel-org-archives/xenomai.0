Message-ID: <50FE80CB.4000608@xs4all.nl>
Date: Tue, 22 Jan 2013 13:06:35 +0100
From: Bas Laarhoven <sjml@xs4all.nl>
MIME-Version: 1.0
References: <4D4F8D1B-022E-47F8-A579-EBF2A3427C5D@mah.priv.at>	<50F6D940.3040406@xs4all.nl>	<F1ACE4FC-3E71-4498-B683-81F5C40CB6E3@mah.priv.at>	<50F7AF53.2090800@xs4all.nl>	<50F7BC13.50009@xenomai.org>	<50F7FCD8.7020105@xs4all.nl>	<50FA9FA0.7020400@xenomai.org>	<F995AEC4-6B7E-4DB9-9C64-A5ED3F01DCFA@mah.priv.at>	<50FAAE9A.2060705@xenomai.org>	<1C475D27-61D9-41F9-98D8-476556B485C4@mah.priv.at>	<50FD2D03.4090306@xenomai.org>
	<327290E8-7EDA-4ED8-80DC-93ADEB393C9F@mah.priv.at>
	<50FD9293.4060304@xenomai.org>
	<A5889380-DB90-428D-BAA3-236632265665@mah.priv.at>
In-Reply-To: <A5889380-DB90-428D-BAA3-236632265665@mah.priv.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Emc-developers] "new
 RTOS"	status:	Scheduler	(?)	lockup on ARM - SUMMARY
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mail17@mah.priv.at>
Cc: EMC developers <emc-developers@lists.sourceforge.net>, xenomai@xenomai.org

On 21-1-2013 22:20, Michael Haberler wrote:
> Am 21.01.2013 um 20:10 schrieb Gilles Chanteperdrix:
>
>> On 01/21/2013 02:32 PM, Michael Haberler wrote:
>>
>>> Am 21.01.2013 um 12:56 schrieb Gilles Chanteperdrix:
>
>>>>> question: does a RTC time warp have any possible bearing on
>>>>> Xenomai operations?
>>>>
>>>> No, it should not, Xenomai uses its own clock, which is set only
>>>> once upon boot, so, is unaffected by Linux wallclock time
>>>> changes... or should be.
>>>
>>> it might not be Xenomai after all. Uhum.
>>>
>>> the bughunt safari tribe has decided to focus on class 'duh' problems
>>> and resolves to shut up until red hands are spotted.
>>
>> I would still put the check in the timer "set_next_event" callback, just
>> in case...
> I assume Bas will give the postmortem shortly - he nailed the issue; the RTC boot timewarp makes for a lost DHCP lease midflight and NFS freezing, making it look like a kernel hang.
>
> relieved,
>
> - Michael

Michael said it all, there's not much for me to add. I'll summarize the 
case for the records ; )

Lesson learned: Change only one variable at a time and don't assume 
anything!

I had been using a NFS mounted filesystem with the Beaglebone for over a 
year now without problems and got used to it's reliability (as I was 
used to in a corporate environment in the past).
Because the Xenomai software was built with libraries (eabihf) not 
compatible with my (eabi) system I switched to the Ubuntu image Michael 
built, and everything seemed to work fine. Except that the (xenomai) 
kernel froze out after around 50-60 minutes of uptime. With the JTAG 
debugger I could see the kernel still running, but all applications 
(both text and X via SSH, and console via serial/USB connection) seemed 
frozen and there was no output indicating what was going on. Of course 
the xenomai kernel was the first suspect. But that proved to be a 
mistake. With hindsight, knowing the cause of the freeze now, I wonder 
why I haven't gotten the NFS connection time-out message on the console, 
but for some reason or another that isn't generated in this case.

The underlying problem is that the Beaglebone has no battery backed 
real-time clock. This gives (only) a serious problem (freeze) with (1) a 
network mounted NFS root filesystem and (2) an initial kernel time lying 
in the past and (3) a DHCP lease time shorter than some multiple (in 
this case 2x) of the required system uptime.

Ubuntu (and maybe Debian too) systems are obviously not designed to 
start with a completely wrong real-time clock value. And the dhclient 
(as many other programs) is not designed to handle the large time step 
that's generated once the clock is set properly sometime during the boot 
process.
Note that if the filesystem is on local storage (e.g. FLASH or 
harddisk), there will only be a short disruption of the network 
connection and it's likely that the problem won't be noticed at all.

A final solution hasn't been found yet: I prefer a workaround without 
changing the dhclient or some other standard program. I think it would 
suffice to acquire a new lease right after the time-step has been made. 
This has to be done without giving up the previous lease (that has 
expired because of the time-step), because that would cause the system 
to freeze again. Suggestions on how to do this are welcome. I can't 
spend much more time on this issue this week.

-- Bas

>
>
>
>
>
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai


