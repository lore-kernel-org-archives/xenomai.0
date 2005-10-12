Message-ID: <434D0D2D.4010606@domain.hid>
Date: Wed, 12 Oct 2005 15:18:37 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] PATCH: fix ppc64 calibration
References: <1CFEB358338412458B21FAA0D78FE86D02CABCA8@domain.hid>
	<434CFDFF.2090201@domain.hid> <434D06C9.3030802@domain.hid>
In-Reply-To: <434D06C9.3030802@domain.hid>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Heikki Lindholm <holindho@domain.hid>
Cc: xenomai@xenomai.org

On 10/12/2005 02:51 PM Heikki Lindholm wrote:
> Wolfgang Grandegger kirjoitti:
>> On 10/11/2005 05:11 PM Fillod Stephane wrote:
>> 
>>>Heikki Lindholm wrote:
>>>[..]
>>>
>>>>Probably, but there are less than awesome 4xx boards around and I'd 
>>>>guess they might even be more likely targets than G4 based machines,
>>>
>>>for 
>>>
>>>>example. Some tuning might be needed.
>>>
>>>How many people are using Xenomai (or Fusion) on 4xx ?
>>>What are their typical sched latency ?
>> 
>> 
>> Attached is the result of some latency measurements on the Ocotea eval
>> board. The AMCC 440 GX is already a fast 4xx processor. Unfortunately,
>> the linuxppc-2.6.10rc3 does not run on our Ebony board. Nevertheless,
>> it's difficult to provide a resonable default value. Why not simply
>> using 0 and it's then up to the user to provide an appropriate value
>> at configuration time?
> 
> 0? No machine is that fast. For the 32-bit ppc it might be harder to 
> provide a reasonable default, because of the broader scale of hardware, 
> but I'd guess that < 100MHz targets prefer to use a dedicated RTOS 
> instead of Xenomai. For the 64-bit targets, I didn't find slower than 

There are a lot of 32 bit CPUs < 100 MHz running Linux and sometimes
they even need a realtime extension.

> 400 MHz machines and they were iSeries, which, I suppose, also aren't 
> prime target for Xenomai. Regardless of what default value is used, 
> there could be some examples provided by the config help to direct user 
> to the right direction.

I fully agree.

> What's the problem with Ebonys? I remember running at least 2.6.9 on 
> Ebonys (440GP) and Walnuts (405).

We have linux-2.4.14-rc3 running on all AMCC eval boards (see
http://www.denx.de). But the kernel supported by RTAI/Fusion,
linuxppc-2.6.10rc3, does not boot on Ebony. The main problem is the
missing support for U-Boot but there might be others. And it's simply
not worth the effort to port it, I think.

Wolfgang.

