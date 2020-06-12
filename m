Subject: Re: rtdm_task_init does not work with Xenomai 3
References: <BCA29F40-0C3A-4DF7-9FE9-EF5D55C66C27.ref@yahoo.fr>
 <BCA29F40-0C3A-4DF7-9FE9-EF5D55C66C27@yahoo.fr>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <61b3ec84-8d38-630a-8542-7b42faf71362@siemens.com>
Date: Fri, 12 Jun 2020 18:17:07 +0200
MIME-Version: 1.0
In-Reply-To: <BCA29F40-0C3A-4DF7-9FE9-EF5D55C66C27@yahoo.fr>
Content-Type: text/plain; charset="utf-8"
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

On 02.06.20 20:34, ayaida marwane via Xenomai wrote:
> Dear all,
> 
> I tried to have an example using rtdm_task_init with Xenomai 3.0.7. The example is tis one:
> 
> ————————— 
> 
> #include <rtdm/driver.h>
> static int periode_us = 1000;
> static int a, ret;
> module_param(periode_us, int, 0644);
> 
> rtdm_task_t task;
> 
> void task_ultrason(void *arg){
>    a=1;
>    rtdm_printk(KERN_INFO "%s.%s() : hello = %d\n", THIS_MODULE->name, __FUNCTION__,a);

This will only be printed once, then the task terminates. You likely
want to put this in a loop and wait on the next cycle via
rtdm_task_wait_period().

Jan

> }
> 
> int __init ultrason_init(void) {
>    a=0;
>    rtdm_printk(KERN_INFO "%s.%s() : hello = %d\n", THIS_MODULE->name, __FUNCTION__,a);
>    ret = rtdm_task_init(&task, "ultrason", task_ultrason, NULL, 99, periode_us*1000);
>    if (ret) {
>         rtdm_printk(KERN_INFO "%s.%s() : error rtdm_task_init, hello = %d\n", THIS_MODULE->name, __FUNCTION__,a);
>    }
>    else  rtdm_printk(KERN_INFO "%s.%s() : success rtdm_task_init, hello = %d\n", THIS_MODULE->name, __FUNCTION__,a);
>    return 0;
> }
> void __exit ultrason_exit(void) {
>    a=2;
>    rtdm_task_destroy(&task);
>    rtdm_printk(KERN_INFO "%s.%s() : hello = %d\n", THIS_MODULE->name, __FUNCTION__,a);
>    }
> 
> module_init(ultrason_init);
> module_exit(ultrason_exit);
> MODULE_LICENSE("GPL »);
> 
> ————————— 
> 
> When I insert the module and remove it, I found in dmesg:
> 
> ————————— 
> 
> [ 5045.187448] test.ultrason_init() : hello = 0
> [ 5045.189495] test.ultrason_init() : success rtdm_task_init, hello = 0
> [ 5049.631665] test.ultrason_exit() : hello = 2
> 
> ————————— 
> 
> The task_ultrason is never called.
> 
> I read from https://gitlab.denx.de/Xenomai/xenomai/-/wikis/Migrating_From_Xenomai_2_To_3 <https://gitlab.denx.de/Xenomai/xenomai/-/wikis/Migrating_From_Xenomai_2_To_3>, that rtdm_task_init() shall be called from secondary mode.
> 
> Since Xenomai 3, rtdm_task_init() involves creating a regular kernel thread, which will be given real-time capabilities, such as running under the control of the Cobalt kernel. In order to invoke standard kernel services, rtdm_task_init() must be called from a regular Linux kernel context.
> 
> So, how to adapt my example to call rtdm_task_init() from  from a regular Linux kernel context to make this example working?
> 
> Thank you for your help.
> 
> BR,
> Marwane.
> 
> 
> 
> 
> 
> 
> 


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

