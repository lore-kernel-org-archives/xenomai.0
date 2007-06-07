From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200706071413.10635.ngustavson@domain.hid>
References: <200706071357.12212.ngustavson@domain.hid>
	<200706071413.10635.ngustavson@domain.hid>
Content-Type: text/plain
Date: Thu, 07 Jun 2007 21:34:16 +0200
Message-Id: <1181244856.4998.133.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] writing from NRT to a rt_pipe
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: NZG <ngustavson@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2007-06-07 at 14:13 -0500, NZG wrote:
> Further experimentations appear to show that the problem is that I'm closing 
> the NRT pipe before data is received in the RT thread, this appears to cause 
> the loss of data in the pipe.
> 
> Is this the desired behavior?

Yes, clearly.

> 
> NZG
> 
> 
> On Thursday 07 June 2007 1:57 pm, NZG wrote:
> > When writing from NRT to a real time pile (open, write, close).
> > Are message boundaries preserved based upon the length of the write call?
> >
> > It's not working for me. The code below returns success, but calling
> >
> > err = rt_pipe_read(comp,k,sizeof(kommand_t),TM_NONBLOCK);
> > or
> > err = rt_pipe_read(comp,k,sizeof(kommand_t),100);
> >
> > from RT space on the same pipe never returns any data
> >
> > err = rt_pipe_read(comp,k,sizeof(kommand_t),TM_NONBLOCK);
> > always returns err
> > 0x0b,  Resource temporarily unavailable
> >
> >  err = rt_pipe_read(comp,k,sizeof(kommand_t),100);
> > always returns err:
> > 0x6e, Connection timed out
> >
> > NZG
> >
> > code specifics follow...............
> >
> > 		int err;
> > 		kommand_t k = {
> > 		.type = KILLCYCLE,
> > 		};
> >
> > 	    int cfd = open(COMMANDPIPE, O_WRONLY|O_SYNC);
> >
> > 	   if(cfd<0){
> > 	   	printf("can't open %s (%s)\n",COMMANDPIPE, strerror(-cfd));
> > 	   	fflush(stdout);
> > 	   	return;
> > 	   }
> >
> > 	   printf("sizeof kommand_t = %u\n",sizeof(kommand_t));
> >
> >        err=write(cfd,&k,sizeof(kommand_t));
> >
> >        if(err>=0)printf("wrote %u bytes to %s\n",err,COMMANDPIPE);
> >
> >        if(err<0)printf("err writing to %s (%s)\n",COMMANDPIPE,
> > strerror(errno));
> >
> >
> >        if(close(cfd)<0)printf("couldn't close %s\n",COMMANDPIPE);
> >
> >
> >
> >
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



