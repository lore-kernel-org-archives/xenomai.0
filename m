Message-ID: <4DF10894.2050306@domain.hid>
Date: Thu, 09 Jun 2011 19:53:24 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4DF0F82C.1010509@domain.hid>
In-Reply-To: <4DF0F82C.1010509@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] rt_task_delete doesn't work
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Roberto Bielli <roberto.bielli@domain.hid>
Cc: xenomai@xenomai.org

On 06/09/2011 06:43 PM, Roberto Bielli wrote:
> Hi,
> 
> the function rt_task_delete goes in segmentation fault.
> 
> this is the environment:
> 
> - kernel 2.6.31.8 arm marvell (test custom porting)
> - xenomai 2.5.5.1

Have you tried xenomai 2.5.6 ?

> 
> - the code:
> int main (int argc, char *argv[])
> {
>      //    Porta di comunicazione
>      int s;
>      RT_TASK pippo;
>      int err;
> 
>      mlockall(MCL_CURRENT|MCL_FUTURE);
> 
>      // gestione signal handler
>      struct sigaction sa;
>      sa.sa_sigaction = (void *)sigHandler;
>      sigemptyset (&sa.sa_mask);
>      sa.sa_flags = SA_SIGINFO;
> 
>      sigaction(SIGTERM, &sa, NULL);
>      sigaction(SIGINT, &sa, NULL);
>      sigaction(SIGPIPE, &sa, NULL);
>      sigaction(SIGFPE, &sa, NULL);
>      sigaction(SIGSEGV, &sa, NULL);
> 
>      PrintTimeMex( TRUE,RT_VERSION"\n" );
> 
>      unlink( LOGEXT_FILE );
> 
> 
>      err = rt_task_create( &pippo, "pippo", 0x2000, 20, T_FPU );

Have you tried checking rt_task_create return value?

>      err = rt_task_delete( &pippo );
> ...
> ...
> ...
> 
> 
> 
> Can anyone help me ?
> 
> Thanks for all
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
> 


-- 
                                                                Gilles.

