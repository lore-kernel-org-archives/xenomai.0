Date: Sun, 27 Jun 2010 12:37:12 +0200
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <20100627103712.GA2565@domain.hid>
References: <9FDCB500-CFA2-42CC-A7CB-EDFD66AF366C@usc.edu>
	<20100605211102.GB8097@domain.hid>
	<20100624224259.GA2800@domain.hid>
	<7FB1B9EA-EB7E-45A2-9C1F-D97916381AF3@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7FB1B9EA-EB7E-45A2-9C1F-D97916381AF3@domain.hid>
Subject: Re: [Xenomai-core] analogy - experimental branch
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Stefan Schaal <sschaal@domain.hid>
Cc: Peter Pastor Sampedro <pastorsa@domain.hid>, xenomai@xenomai.org

Hi,


Stefan Schaal wrote:
> Hi Alexis,
> 
>   thanks so much for the new analogy software. Here are some first observations:
> 
> 1) cmd_bits.c works fine on our NI6250 board
> 
> 2) however, a slightly modified version hangs -- I appended my cmd_bits.c to this email. All what I added is a for loop around the a4l_async_write() and a4l_snd_insn() commands, i.e., I wanted to trigger a write repeatedly. Look for the "sschaal" comment in my modified cmd_bits.c .  After 32 iterations, cmd_bits hangs, no error messages in dmesg. Interesting, when I change your "trigger_threshold" variable from 128 to 256, my loop runs for 16 iterations (other changes of the trigger threshold adjust the number of iterations I get in a similar way). Thus, it feels like there is a buffer which does not get reset after a4l_snd_insn() is called -- does this make sense?
> 

Could you tell me if the mite triggered an interrupt ? Could you send
a dump of cat /proc/xenomai/irq after having made the test program
hang ?

Many thanks,

> Best wishes,
> 
> -Stefan
> 
> 
> On Jun 24, 2010, at 15:43, Alexis Berlemont wrote:
> 
> > Hi,
> > 
> > Alexis Berlemont wrote:
> >> Hi Stefan,
> >> 
> >> Stefan Schaal wrote:
> >>> Hi Alexis,
> >>> 
> >>>  I was just wondering whether the new "experimental" branch in your git repository is something that can be tried already.
> >>> 
> >> 
> >> No. Not yet. This branch is aimed at temporarily holding the
> >> corrections I am trying to do for the cmd_bits issue. It needs quite a
> >> lot of work and I have not finished yet. 
> >> 
> >> If you have a look at the commits in this branch, we will see many
> >> "(broken)".
> >> 
> > 
> > I just rebased the experimental branch into the branch analogy. So,
> > starting from now, we should be able to properly use cmd_bits with a
> > clone of my git repository.
> > 
> > After having reworked the asynchronous buffer subsystem (and having
> > fixed some oops in the NI driver and in the new code), cmd_bits can
> > correctly communicate with the DIO subdevice. 
> > 
> > A command like "./cmd_bits 0xffff 0xffff" works on my
> > board. Unfortunately, I have not done the necessary to check the
> > digital output lines yet.
> > 
> > 
> >>> Best wishes,
> >>> 
> >>> -Stefan
> >> 
> >> -- 
> >> Alexis.
> > 
> > -- 
> > Alexis.
> 
> 
> ======================================================= cmd_bits.c ==================================================



-- 
Alexis.

