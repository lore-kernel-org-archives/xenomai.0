Message-ID: <4DF0F82C.1010509@domain.hid>
Date: Thu, 09 Jun 2011 18:43:24 +0200
From: Roberto Bielli <roberto.bielli@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] rt_task_delete doesn't work
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hi,

the function rt_task_delete goes in segmentation fault.

this is the environment:

- kernel 2.6.31.8 arm marvell (test custom porting)
- xenomai 2.5.5.1

- the code:
int main (int argc, char *argv[])
{
     //    Porta di comunicazione
     int s;
     RT_TASK pippo;
     int err;

     mlockall(MCL_CURRENT|MCL_FUTURE);

     // gestione signal handler
     struct sigaction sa;
     sa.sa_sigaction = (void *)sigHandler;
     sigemptyset (&sa.sa_mask);
     sa.sa_flags = SA_SIGINFO;

     sigaction(SIGTERM, &sa, NULL);
     sigaction(SIGINT, &sa, NULL);
     sigaction(SIGPIPE, &sa, NULL);
     sigaction(SIGFPE, &sa, NULL);
     sigaction(SIGSEGV, &sa, NULL);

     PrintTimeMex( TRUE,RT_VERSION"\n" );

     unlink( LOGEXT_FILE );


     err = rt_task_create( &pippo, "pippo", 0x2000, 20, T_FPU );
     err = rt_task_delete( &pippo );
...
...
...



Can anyone help me ?

Thanks for all

