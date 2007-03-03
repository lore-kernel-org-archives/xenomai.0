Message-ID: <45E90B60.6060406@domain.hid>
Date: Sat, 03 Mar 2007 07:45:04 +0200
From: Heikki Lindholm <holindho@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] MPC8641D and CONFIG_PPC_MERGE
References: <45E8D44F.7070200@domain.hid>
In-Reply-To: <45E8D44F.7070200@domain.hid>
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
To: Jeff Koftinoff <jeffk@domain.hid>
Cc: xenomai@xenomai.org

Jeff Koftinoff kirjoitti:
> Hi Everyone. I would really like to get Xenomai working on the new 
> Freescale 8641D dual core G4.
> 
> I see that for linux 2.6.19, Xenomai does not support CONFIG_PPC_MERGE 
> or architectures=powerpc instead of 'ppc'.

Weren't there some experimental powerpc ports already posted some time 
ago (by Wolfgang, I think)? See the list archive.

> Please forgive my ignorance; What exactly is the difference between 
> arch=ppc and arch=powerpc?
> 
> What is involved in changing adeos to work under arch=powerpc on the 
> 8641D in single core mode?
> 
> How much more work is involved in changing adeos to support SMP on powerpc?

The 64-bit powerpc target is under powerpc and supports SMP. The work 
required somewhat depends on the specific architecture implementation of 
SMP, but shouldn't be too difficult.

-- Heikki Lindholm

