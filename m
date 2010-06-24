Date: Fri, 25 Jun 2010 00:43:00 +0200
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <20100624224259.GA2800@domain.hid>
References: <9FDCB500-CFA2-42CC-A7CB-EDFD66AF366C@usc.edu>
	<20100605211102.GB8097@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100605211102.GB8097@domain.hid>
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

Alexis Berlemont wrote:
> Hi Stefan,
> 
> Stefan Schaal wrote:
> > Hi Alexis,
> > 
> >   I was just wondering whether the new "experimental" branch in your git repository is something that can be tried already.
> > 
> 
> No. Not yet. This branch is aimed at temporarily holding the
> corrections I am trying to do for the cmd_bits issue. It needs quite a
> lot of work and I have not finished yet. 
> 
> If you have a look at the commits in this branch, we will see many
> "(broken)".
> 

I just rebased the experimental branch into the branch analogy. So,
starting from now, we should be able to properly use cmd_bits with a
clone of my git repository.

After having reworked the asynchronous buffer subsystem (and having
fixed some oops in the NI driver and in the new code), cmd_bits can
correctly communicate with the DIO subdevice. 

A command like "./cmd_bits 0xffff 0xffff" works on my
board. Unfortunately, I have not done the necessary to check the
digital output lines yet.
 

> > Best wishes,
> > 
> > -Stefan
> 
> -- 
> Alexis.

-- 
Alexis.

