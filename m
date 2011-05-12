Date: Thu, 12 May 2011 23:50:39 +0200
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <20110512215039.GA2904@domain.hid>
References: <OF15B3A65E.95FCDE8A-ONC125788C.002F7603-C125788C.002FD68D@esa.int>
	<1305018519.2151.15.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1305018519.2151.15.camel@domain.hid>
Subject: Re: [Xenomai-core] Integration of new drivers in xenomai
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Alexis Berlemont <berlemont.hauw@domain.hid>, xenomai@xenomai.org

Hi,

Sorry for answering late.

Philippe Gerum wrote:
> On Tue, 2011-05-10 at 10:42 +0200, julien.delange@domain.hid wrote:
> > Dear all,
> > 
> > For my work, I had to develop drivers for the 6052 and 6701 boards from 
> > National Instruments. These boards are already supported by the Comedi 
> > drivers but were not supported by Xenomai yet. So, I took the code from 
> > Comedi and adapt it to Xenomai with the analogy layer (a4l* functions and 
> > so on). It introduces two new drivers : analogy_ni_670x and 
> > analogy_ni_660x.
> > 
> > At this time, the driver compiles and loads correctly. I will have the 
> > hardware in ten days to test the code and make sure it works from a 
> > functional point of view.
> > 
> > In order to contribute to Xenomai, I would like to know if this code could 
> > be integrated in Xenomai repository. In particular, what are the 
> > conditions to integrate third-party code and especially driver code.
> 
> Simple and straightforward:
> 
> - free software license compatible with the linux kernel licensing terms
> - proper credits and copyrights retained from the original code
> - the code should solve a problem, instead of introducing it
> - standard linux kernel coding style
> 
> >  Then, 
> > if it seems interesting for you, I will submit a patch as soon as I 
> > checked that it works correctly with the physical boards.
> > 

Do not hesitate to send us a first set of patchs. Even if, few
functionalities are tested and validated, we can have an early look at
it. By the way, if Philippe is OK with the idea, I will integrate your
reviewed code in my git repository so that potential other users could
give it a try. 

> 
> Generally speaking, any sound contribution is welcome. Technically, Alex
> has the final cut for Analogy stuff.
> 
> > Thanks for any suggestion,
> > 
> > Best regards,
> > 
> > 
> > 
> > _______________________________________________
> > Xenomai-core mailing list
> > Xenomai-core@domain.hid
> > https://mail.gna.org/listinfo/xenomai-core
> 
> -- 
> Philippe.
> 
> 
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core

-- 
Alexis.

