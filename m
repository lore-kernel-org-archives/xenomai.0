Message-ID: <47BD977C.1040209@domain.hid>
Date: Thu, 21 Feb 2008 16:23:40 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <7289437c0802210658w29e21207q74f1cfdf36d6e17c@domain.hid>
In-Reply-To: <7289437c0802210658w29e21207q74f1cfdf36d6e17c@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Kernel access of bad area with rtdm_event_wait()
 (MPC8347)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Perrine Martignoni <perrmart@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Perrine Martignoni wrote:
> Hello,
> 
> I work on a MPC8347 processor and I found out a problem with
> rtdm_event_wait(). I reproduce the problem with a simple code :
> 
> *driver.c* :
> #include <rtdm/rtdm_driver.h>
> 
> MODULE_AUTHOR("P.Martignoni");
> MODULE_LICENSE("GPL");
> 
> #define DEV_FILE_NAME       "DspDev"
> #define DRV_NAME            "DspDrv"
> 
> #define DEV_FILE_DSP            "dspdev0"
> 
> static rtdm_event_t s_ReadEvent;
> 
> static int Open(struct rtdm_dev_context    *p_Context,
>                 rtdm_user_info_t           *p_UserInfo,
>                 int                        Oflags)
> {
>     int ret = 0;
> 
>     rtdm_event_init(&s_ReadEvent,0);
> 
>     // generates an error : Oops : Kernel access of bad area, sig : 11 [#1]
>     rtdm_event_wait(&s_ReadEvent);

General advice: switch on XENO_OPT_DEBUG_RTDM (and IPIPE_DEBUG_CONTEXT)
to catch service invocations from a wrong context, like here.

Your mistake: calling a blocking Xenomai services from non-rt context
(see your registration of Open in t_IdspDevice).

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

