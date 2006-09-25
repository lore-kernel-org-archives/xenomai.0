Message-ID: <45178382.3090500@domain.hid>
Date: Mon, 25 Sep 2006 09:21:38 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <4516F0D1.3010800@domain.hid> <1159135692.4971.68.camel@domain.hid>
In-Reply-To: <1159135692.4971.68.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: adeos-ipipe-2.6.18-ppc-1.4-00.patch,
	first version
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: adeos-main@gna.org, xenomai@xenomai.org

Philippe Gerum wrote:
> On Sun, 2006-09-24 at 22:55 +0200, Wolfgang Grandegger wrote:
>> Hi Philippe,
>>
>> attached you will find a first version of the PPC ADEOS-IPipe patch for 
>> Linux 2.6.18 (from kernel.org) for review. I have also included a 
>> commented log file with more information on the porting of 
>> adeos-ipipe-2.6.14-ppc-1.4-00 to Linux 2.6.18. It works with a recent 
>> version of Xenomai.
>>
> 
> Thanks, at first sight, this looks good. I don't see any obvious problem
> in the tracer code either. Anyway, I will play with it asap.

OK, I wanted to have it under SVN control asap (the IPIPE version 
increased twice during the last weeks).

>> The patch currently only supports dev
ices in the "arch/ppc" tree with
>> the option "CONFIG_PPC_MERGE" not set. Porting the "arch/powerpc" tree 
>> requires further effort and I need a test system as well. Puh, let's 
>> hope that the merge ppc -> powerpc will be completed soon.
>>
>> The idle loop is not yet working for 6xx and I have disabled it for
>> this reason (check arch/powerpc/kernel/idle.c). It needs further
>> debugging. I hope to find more time beginning of October.
> 
> Ok, thanks. Btw, returning from NAP on 6xx is done through an exception,
> right? If so, maybe we have a problem with this particular
> exception/interrupt branching directly to transfer_to_handler_full (i.e.
> the vanilla way) without being known from the Adeos pipeline, albeit it
> should? (red blinking warning: this is just a wild guess).

It actually does a doze. Napping can be switched on via procfs. So far, 
I understood that the decrementer exception will wakeup the CPU but I'm 
going to check the code and doc more carefully. An it did work with 2.6.14.

>> I have tested the patch on some AMCC 4xx system, on a MPC 8560 (85xx) 
>> and MPC 834x (6xx). I have also not yet tested the IPIPE tracer.
> 
> I'll give it a try too on a mpc52xx. Thanks again.

Unfortunately, the port for this CPU is broken, again ;-(. At least I 
did not get my Icecube-Board up and running.

Thanks.

Wolfgang.



