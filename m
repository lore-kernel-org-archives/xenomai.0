Content-Disposition: inline
From: NZG <ngustavson@domain.hid>
Date: Thu, 7 Jun 2007 10:49:32 -0500
MIME-Version: 1.0
Message-Id: <200706071049.32906.ngustavson@domain.hid>
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Fwd: can't use message pipe - Cannot allocate memory
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

I'm trying to pass a message from user space to Xenomai and it doesn't seem
 to be working. I keep getting an error when attempting to write to the pipe
 in user space.

rt_pipe_write error

: Cannot allocate memory

This happens whether I use posix calls or real time calls.

If I change the poolsize to 0 for allocation from the heap, writes no longer
error out but the data is not received in real time space.

Does this work for anyone else? Anyone have any ideas I could try?

thx,
NZG

code specifics follow...................................................

3 differen POOLSIZE attempts
**************************************************
#define KOMMANDBUFFER 100
//#define POOLSIZE_CONTROL (sizeof(kommand_t)*KOMMANDBUFFER)
//#define POOLSIZE_CONTROL 0
#define POOLSIZE_CONTROL	1024




real-time thread
***********************************
if((err=rt_pipe_create (p, name, P_MINOR_AUTO, POOLSIZE_CONTROL))!=0){
	error(0,-err, "could not create rt pipe");
	return err;
}

/**
 * retrieve a message from the message buffer
 * and updates the kommand structure passed to it.
 * @returns the type of command retrieved.
 *
 */
static inline int getkommand(kommand_t *k){
int err;
  err = rt_pipe_read(&command_pipe,k,sizeof(kommand_t),TM_NONBLOCK);
  if(err<0)error(0,-err, "rt_pipe_read error\n");
  return k->type;//return the type of message
}

while(getkommand(&kommand)!=KILLCYCLE);

user space using real time calls
***********************************
 err=rt_pipe_write(&command_pipe, &k,sizeof(kommand_t),P_NORMAL);
	if(err<0)error(0,-err, "rt_pipe_write error\n");

alternateuser space using posix calls
***********************************
	    int cfd = open(COMMANDPIPE, O_RDWR);

	   if(cfd<0){
	   	printf("can't open %s (%s)\n",COMMANDPIPE, strerror(-cfd));
	   	fflush(stdout);
	   	return;
	   }

       err=write(cfd,&k,sizeof(kommand_t));

       if(err==0)printf("couldn't write to %s\n",COMMANDPIPE);

       if(err<0)printf("err writing to %s (%s)\n",COMMANDPIPE,
strerror(errno));

       if(close(cfd)<0)printf("couldn't close %s\n",COMMANDPIPE

-------------------------------------------------------

