Message-ID: <49443DFF.1060003@domain.hid>
Date: Sun, 14 Dec 2008 00:58:07 +0200
From: Andre Marais <andre@domain.hid>
MIME-Version: 1.0
References: <200812090832.43063.roberto.bucher@domain.hid>	<200812111119.40464.roberto.bucher@domain.hid>	<4943A2AF.1050007@domain.hid>
	<200812131820.46419.roberto.bucher@domain.hid>
In-Reply-To: <200812131820.46419.roberto.bucher@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] Problems with last adeos patches
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

I seem to have the same/a similar problem, only using Dual and Quad core
machines. Sometimes the machine(s) hangs hard, networking is lost as well.

I can only verify it happens when running Xorg on the machine(s), seems
quite stable in console only. Machine's got a Silicon Motion Lynx3DM
card that I last had issues on.

Running Xenomai 2.4.6.1, Adeos 2.2-01, Kernel 2.6.27.7. Will have to
wait for a .config for a week or so though :-(

Regards,
Andre


Roberto Bucher wrote:
> I have the problem on a Dual Core Machine (2xT9600 Processor). 
> 
> On a Centrino machine with 1 processor, the same kernel+patch seems to be ok.
> 
> Paolo Mantegazza has a similar problem on 3 Dual core machines.
> 
> Thanks
> 
> Roberto
> 
> On Saturday 13 December 2008 12:55:27 Jan Kiszka wrote:
>> Roberto Bucher wrote:
>>> Some results:
>>>
>>> 1) I changed the nvidia driver from 177.80 to 177.82: problem still
>>> remains 2) I changed the driver to "vesa" in the xorg.conf file: X starts
>>> but the problem remains!
>>> 3) I connect using ssh -X from another terminal to the RT linux machine.
>>> I can't reproduce the problem. When I start scilab on the RT machine the
>>> RT system freezes and the connection fails.
>>>
>>> I installed the kernel 2.6.25.20 with patch  derived from
>>> adeos-ipipe-2.6.25- x86-2.0-09.patch and the system seems to work fine.
>> Another question (before I actually start looking at code): Are all test
>> boxes using > 1 CPUs? Or is the issue also present when there is only a
>> single CPU?.
>>
>> Jan
> 


-- 
Reading, after a certain age, diverts the mind too much from its
creative pursuits. Any man who read too much and uses his own brain
too little falls into lazy habits of thinking.
 - Albert Einstein.

 -----------------------------------------------------------------------
 LEGAL DISCLAIMER:
 The views or representations contained in this message, whether express
 or implied, are those of the sender only, unless that sender expressly
 states them to be the view or representations of an entity or person,
 who shall be named by the sender and the sender shall state to
 represent. No liability shall otherwise attach to any other entity or
 person.
 -----------------------------------------------------------------------

