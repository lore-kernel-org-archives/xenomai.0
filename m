Message-ID: <45E92BDF.60909@domain.hid>
Date: Sat, 03 Mar 2007 09:03:43 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] MPC8641D and CONFIG_PPC_MERGE
References: <45E8D44F.7070200@domain.hid>
	<45E90B60.6060406@domain.hid>
In-Reply-To: <45E90B60.6060406@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Heikki Lindholm wrote:
> Jeff Koftinoff kirjoitti:
>> Hi Everyone. I would really like to get Xenomai working on the new 
>> Freescale 8641D dual core G4.
>>
>> I see that for linux 2.6.19, Xenomai does not support CONFIG_PPC_MERGE 
>> or architectures=powerpc instead of 'ppc'.
> 
> Weren't there some experimental powerpc ports already posted some time 
> ago (by Wolfgang, I think)? See the list archive.

I started porting to the powerpc tree some time ago but realized that it 
was not straight-forward. My quick hack didn't boot and then I stopped 
because of lack of free time.

>> Please forgive my ignorance; What exactly is the difference between 
>> arch=ppc and arch=powerpc?

Mainly the use of the generic IRQ layer and time of day. It requires an
in-depth review and design of the corresponding Adeos/I-pipe 
implementation. Well, the general design is already there for x86 
implemented by Philippe but needs to be adapted. Nevertheless, the port 
is planned for the near future. Funding would help, of course.

>> What is involved in changing adeos to work under arch=powerpc on the 
>> 8641D in single core mode?
>>
>> How much more work is involved in changing adeos to support SMP on 
>> powerpc?
> 
> The 64-bit powerpc target is under powerpc and supports SMP. The work 
> required somewhat depends on the specific architecture implementation of 
> SMP, but shouldn't be too difficult.

That's also my impression, and a system for porting and testing is also 
required.

Wolfgang.


