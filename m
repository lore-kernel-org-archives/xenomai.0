From: Henry Bausley <hbausley@deltatau.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 23 Aug 2012 11:18:21 -0700
Message-ID: <1345745901.24823.36.camel@lx-henry>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] nanosleep returns -1 unless using SCHED_FIFO.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org



With xenomai 2.5.6 nanosleep no longer works unless the application is
using SCHED_FIFO.  Previously we used xenomai 2.4.10 and the code would
nanosleep.


int main(void) 
{
  struct timespec SecSleeper = {0};
  SecSleeper.tv_sec = 1;
  SecSleeper.tv_nsec = 0;
  int P[3];

  // param.__sched_priority = 1;
  // pthread_setschedparam(pthread_self(),  SCHED_FIFO, &param);    
  while (1)
  {
        printf("Dummy\n");
        P[1]++;
        P[2] = nanosleep(&SecSleeper, NULL);
        P[3] = errno;
  }  
  return 0;
}


Is this behavior expected?




Outbound scan for Spam or Virus by Barracuda at Delta Tau


