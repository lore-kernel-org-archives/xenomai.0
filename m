Subject: Re: RTDM Printk do not work on rtdm_timer_handler_t
References: <D5DEC4F7-7609-4B43-9DF7-BEBFEEFB1AC1.ref@yahoo.fr>
 <D5DEC4F7-7609-4B43-9DF7-BEBFEEFB1AC1@yahoo.fr>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <bbcae94e-9dbe-e95c-13f4-b67abee77cc6@siemens.com>
Date: Mon, 18 May 2020 12:47:29 +0200
MIME-Version: 1.0
In-Reply-To: <D5DEC4F7-7609-4B43-9DF7-BEBFEEFB1AC1@yahoo.fr>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ayaida marwane <ayaida_marwane@yahoo.fr>, xenomai@xenomai.org

On 18.05.20 11:27, ayaida marwane via Xenomai wrote:
> Dear all,
> 
> I have tried this code :
> 
> ————————————————————
> 
> #include <rtdm/driver.h>
> 
> static int periode_us = 1000;
> module_param(periode_us, int, 0644);
> 
> static void timer_task(rtdm_timer_t *);
> static rtdm_timer_t rtimer;
> 
> static int __init init_oscillateur (void)
> {
>          int err;
> 
>          rtdm_printk(KERN_INFO "%s.%s() : Initialisation\n", THIS_MODULE->name, __FUNCTION__);
> 
>          if ((err = rtdm_timer_init(& rtimer, timer_task, "Timer_Task")) != 0) {
>                  return err;
>          }
> 
>          if ((err = rtdm_timer_start(& rtimer, periode_us*1000, periode_us*1000, RTDM_TIMERMODE_RELATIVE)) != 0) {
>                  rtdm_timer_destroy(& rtimer);
>                  return err;
>          }
> 
>          return 0;
> }
> 
> static void __exit exit_oscillateur (void)
> {
>          rtdm_timer_stop(& rtimer);
>          rtdm_timer_destroy(& rtimer);
>          rtdm_printk(KERN_INFO "%s.%s() : Exit\n", THIS_MODULE->name, __FUNCTION__);
> }
> 
> static void timer_task(rtdm_timer_t * unused)
> {
>          rtdm_printk(KERN_INFO "%s.%s() : Appel Timer\n", THIS_MODULE->name, __FUNCTION__);
> }
> 
> module_init(init_oscillateur);
> module_exit(exit_oscillateur);
> MODULE_LICENSE("GPL");
> 
> 
> ————————————————————
> 
> However, when I execute the code, we have only :
> 
> [ 6696.615556] oscillateur_gpio_rtdm.init_oscillateur() : Initialisation
> [ 6705.148129] oscillateur_gpio_rtdm.exit_oscillateur() : Exit
> 
> So, why the rtdm_printk in the timer_task is never called?
> 
> Thanks for your help.
> 
> BR,
> Marwane.
> 
> 
> 

No obvious reason why is should print or run. You can start analyzing by 
looking at stats in /proc/xenomai/timer, if yours is ticking.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

