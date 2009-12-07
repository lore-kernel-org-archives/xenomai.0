Message-ID: <801038.31731.qm@domain.hid>
Date: Mon, 7 Dec 2009 01:57:11 -0800 (PST)
From: Yigal Goldberger <yigal_gold@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Xenomai-help] serial com errors
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

Hi Again,

I hope it's not too long and tiring ...
But the relevant code (I think...) is the initialization stage , and the select and read loop that blocks and reads .


The problem is as follows :
I have 2 threads listening on two different serial coms . running the same code below . Using select to block and wait for bytes to be available on the port , and then reading them with the read function .
These 2 threads are Xenomai threads with priority higher then the thread that is responsible of working on the data .
I see that when reaceiving with BAUDRATES lower than 115200 (38400) no problem occures , and when receving on both port with BAUDRATE 115200 , I get errors in the received bytes ( which is identified by a wrong checksum ,and sometimes with a "No more room in flip buffer" printout on the console as well as errno 11 (EAGAIN) ) . When I added a 10 mili second sleep to the executing thread (the thread that uses the data )the problem seems to disappear .


Below is the 2 code parts that Initialize the file descriptor of the reading thread , and the reading select - read loop :


The code  creating the file descriptor :


fd = open (devname, O_RDWR | O_NOCTTY | O_NDELAY | O_NONBLOCK );

memset ((void *)&ttykey, 0, sizeof (ttykey));

	ttykey.c_cflag = 0;
	ttykey.c_cflag |= CLOCAL;
	ttykey.c_cflag |= CREAD;
	ttykey.c_cflag |= CS8;

	ttykey.c_lflag = 0;

#if 0
	ttykey.c_lflag |= ECHO;
#endif
	
	ttykey.c_iflag = 0;
	ttykey.c_iflag |= IGNPAR;
	ttykey.c_iflag |= IGNBRK;


	ttykey.c_oflag = 0;

	DPRINT( ("setting speed\n") );
	cfsetispeed (&ttykey, B9600);
	cfsetospeed (&ttykey, B9600);

	if (fd > 0)
	{
		DPRINT( ("setting terminal attributes\n") ); 
		tcsetattr (fd, TCSANOW, &ttykey);
	}


/**********************************************************************/
/**********************************************************************/
//The code of the reading thread :


void *CTlp::ReadThread (CTlp *thistlp)
{

   int nbytes;
   int buf_ix;
   fd_set input;
   FD_ZERO(&input);
   FD_SET(thistlp->fd, &input);

   unsigned char bigbuf [IN_COMMAND_BUF_SIZE];
   unsigned char cmdbyte;
   BOOL receive_error;
   int inbytes_ix = 0;
   unsigned char inbytes [3];
   int totalbytes = 0;
   inbytes [2] = 0;
   timeval io_timeout ;	
   timeval * pIo_timeout;	
   thistlp->state = &CTlp::tlp_await_first_byte;
	  

//   thistlp->fd = thistlp->init_port (thistlp->device_name);

   pIo_timeout = NULL ;	
   	
   DPRINT(  ("readthread\n") );

   thistlp->Tlp_Exec_mqd = mq_open (thistlp->pconn_info->toexecq->message_queue_name, O_WRONLY);
   pthread_cleanup_push ((void(*)(void*))cleanwrite, (void *)thistlp->Tlp_Exec_mqd);

 
   thistlp->SetBaudRate (thistlp->requested_baud_rate);

   while (TRUE)
   {
	if (thistlp->nbytes_to_read == 1)
	{
		int xxx = tcgetattr (thistlp->fd, &thistlp->ttykey);
	}

	if ((nbytes = select (thistlp->fd+1, &input, NULL, NULL,pIo_timeout /*NULL*/)) < 0)
	{

		DPRINT( ("select problem: %s\n", strerror (errno)) );
		break;
	}
	else
	{

		DPRINT( ("select returned %d\n", nbytes));
		if (nbytes)//there are bytes to read from IO device -serial port
		{
		  char *stopstring;
		  thistlp->CommandIO_In_progress = true ;
		  int nread = read (thistlp->fd, bigbuf, sizeof (bigbuf));

		  //This is a sync point , we try to lock this mutex and if we block
		  //it means that the frame list has not yet been deleted by the
		  //OutThread
		  pthread_mutex_lock (&thistlp->mutexSyncFrameListDestruction);
		  pthread_mutex_unlock (&thistlp->mutexSyncFrameListDestruction);

		  totalbytes += nread ;
		  
		  buf_ix = 0;
		  
		  while (buf_ix < nread)
		  {
			receive_error = FALSE;
			inbytes [inbytes_ix] = bigbuf [buf_ix++];
			inbytes_ix = (inbytes_ix+1) % thistlp->nbytes_to_read;
			if (inbytes_ix == 0)
			{
			 if (thistlp->nbytes_to_read == 2)
			 {
				//In this case bytes are sent over the line in ASCII code
				//two chars per data byte , each char being a 0..F ascii code .
				DPRINT(  ("read bytes = %02x (%c), %02x (%c)\n", inbytes [0], inbytes [0], inbytes [1], inbytes [1]) );
				//strtoul with 16 expects that each char in inbytes will be 
				//a the ascii value representing '0..F' hexadecimal values 
				cmdbyte = strtoul ((char *)inbytes, &stopstring, 16);
				DPRINT(  ("translated to %08x\n", cmdbyte) );
				if (stopstring != (char *)&inbytes [2])
				{
					//if this code is reached it means that a corrupted
					//byte which cannot be interpreted as an ascii rep' of 
					//a hex digit was read from the line indicating a com error !
					DPRINT(  ("couldn't translate\n") );
					receive_error = TRUE;
					// ?? what to do now - bad hex digit in ascii???
				}
			 }
			 else 
			 {
					//This code is run in case we are using a BAUDRATE higher than
					//9600 in which case the stream is sent as is - not ASCII !!!
					//hence there's no need to interpret the ASCII code .
					//Another possibility is that we reached the last byte EOT .
					//in which case it also isn't sent in ASCII
					DPRINT(  ("read one byte : %02x\n", inbytes [0]) );
					cmdbyte = inbytes [0];
			 }
			stateptr funtorun = thistlp->state;
			if (!receive_error)
				(thistlp->*funtorun)(&cmdbyte);
			else
				thistlp->state = thistlp->NackToHost (M_BAD_HEADER);
		   }
		  }
		}
		else
		{
			if (!FD_ISSET(thistlp->fd,&input ) )
				FD_SET(thistlp->fd, &input);
			//in the event of a timeout during command reception we release 
			//all the resources (frames ) allocated to the command and restart the tlp machine
			thistlp->post();
			thistlp->ReleaseCommandFrames( thistlp->current_frame);
		 	thistlp->current_frame = all_my_frames->Alloc (thistlp->pconn_info);
			thistlp->current_frame->request_header->length = 0;
			thistlp->CommandIO_In_progress = false ;
			thistlp->overrunflag = false ;
			pIo_timeout = NULL ;
			thistlp->state = &CTlp::tlp_await_first_byte;
			thistlp->SetBaudRate ( B9600 );
			printf(" IO Timeout Occured on com %d , restarting tlp ... \n", thistlp->default_port );	
		}
		
		if (thistlp->CommandIO_In_progress)
		{	//If we are in the middle of a command we must enforce
			 //a timeout ,if not we	can wait infinitely 
			
			io_timeout.tv_sec = 6 ;
			io_timeout.tv_usec = 0 ;	
			pIo_timeout = &io_timeout ;
		}
		else
			pIo_timeout = NULL ;

	
		
	} //big else
   }//while
   pthread_cleanup_pop (TRUE);
   return (void*)NULL;
}


Ideas will be more than welcome .

Thanks,
Yigal Goldberger.





      

