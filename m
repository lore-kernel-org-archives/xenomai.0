From: NZG <ngustavson@domain.hid>
Date: Thu, 7 Jun 2007 13:57:12 -0500
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200706071357.12212.ngustavson@domain.hid>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] writing from NRT to a rt_pipe
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

When writing from NRT to a real time pile (open, write, close).
Are message boundaries preserved based upon the length of the write call?

It's not working for me. The code below returns success, but calling 

err = rt_pipe_read(comp,k,sizeof(kommand_t),TM_NONBLOCK);
or
err = rt_pipe_read(comp,k,sizeof(kommand_t),100);

from RT space on the same pipe never returns any data

err = rt_pipe_read(comp,k,sizeof(kommand_t),TM_NONBLOCK); 
always returns err 
0x0b,  Resource temporarily unavailable

 err = rt_pipe_read(comp,k,sizeof(kommand_t),100);
always returns err:
0x6e, Connection timed out

NZG

code specifics follow...............

		int err;
		kommand_t k = {
		.type = KILLCYCLE,	
		};
	   
	    int cfd = open(COMMANDPIPE, O_WRONLY|O_SYNC);
	   
	   if(cfd<0){
	   	printf("can't open %s (%s)\n",COMMANDPIPE, strerror(-cfd));
	   	fflush(stdout);
	   	return;
	   }
	   	
	   printf("sizeof kommand_t = %u\n",sizeof(kommand_t));
	   
       err=write(cfd,&k,sizeof(kommand_t));
       	
       if(err>=0)printf("wrote %u bytes to %s\n",err,COMMANDPIPE); 
       	
       if(err<0)printf("err writing to %s (%s)\n",COMMANDPIPE, 
strerror(errno));
       
       
       if(close(cfd)<0)printf("couldn't close %s\n",COMMANDPIPE);


 

