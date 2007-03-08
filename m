Message-ID: <45EFD4CF.5080808@domain.hid>
Date: Thu, 08 Mar 2007 10:18:07 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] latency hangs on AT91RM9200
References: <45DECFAF.60304@domain.hid>	<45DF04F2.4020002@domain.hid>	<45DF192C.6020505@domain.hid>	<45E2B3A1.8070102@domain.hid>	<45E2C2C3.1020202@domain.hid>	<45EFC936.4080405@domain.hid>
	<17903.52402.226751.881659@domain.hid>
	<45EFCD72.3080904@domain.hid>
In-Reply-To: <45EFCD72.3080904@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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
To: Steven Scholz <steven.scholz@domain.hid>
Cc: Xenomai-core@domain.hid

Steven Scholz wrote:
> Gilles Chanteperdrix wrote:
> 
>>Steven Scholz wrote:
>> > Hi Gilles,
>> > 
>> > >> Ok, found the bug (actually, Philippe did), as almost expected, the way
>> > >> it is related to the latency program period is not really obvious. The
>> > >> bug is that in the macro "irq_handler" in entry-armv.S, the return value
>> > >> (in r0) of __ipipe_grab_irq is overriden by the subsequent call to
>> > >> get_irqnr_and_base.
>> > >>
>> > > 
>> > > Here comes a patch. Note that it will only work correctly with
>> > > CONFIG_PREEMPT disabled for now.
>> > 
>> > Any progress with CONFIG_PREEMPT enabled ?
>>
>>enabling CONFIG_PREEMPT almost works. But non real-time tasks system
>>calls fail from time to time.
> 
> 
> But I do need a new patch?
> 
> Cause with last patch I get "BUG()" in schedule ...

The patch that almost works with CONFIG_PREEMPT only exist on Philippe's
disk, it has not been released.

-- 
                                                 Gilles Chanteperdrix

