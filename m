Subject: Re: rtdm_task_init does not work with Xenomai 3
References: <BCA29F40-0C3A-4DF7-9FE9-EF5D55C66C27.ref@yahoo.fr>
 <BCA29F40-0C3A-4DF7-9FE9-EF5D55C66C27@yahoo.fr>
 <B5BA411F-973C-4EDA-B87D-F323D28D3DEF@yahoo.fr>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <68aba520-be16-e25e-61ad-32a7061e43e1@xenomai.org>
Date: Mon, 8 Jun 2020 09:36:49 +0200
MIME-Version: 1.0
In-Reply-To: <B5BA411F-973C-4EDA-B87D-F323D28D3DEF@yahoo.fr>
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
To: ayaida marwane <ayaida_marwane@yahoo.fr>
Cc: xenomai@xenomai.org

On 6/7/20 10:33 PM, ayaida marwane via Xenomai wrote:
> Hi,
> 
> Any suggestion about the request below?
> 
> Thanks!
> 
> BR,
> Marwane.
> 
>> Le 2 juin 2020 à 20:34, ayaida marwane via Xenomai <xenomai@xenomai.org> a écrit :
>>
>> Dear all,
>>
>> I tried to have an example using rtdm_task_init with Xenomai 3.0.7. The example is tis one:
>>
>> ————————— 
>>
>> #include <rtdm/driver.h>
>> static int periode_us = 1000;
>> static int a, ret;
>> module_param(periode_us, int, 0644);
>>
>> rtdm_task_t task;
>>
>> void task_ultrason(void *arg){
>>   a=1;
>>   rtdm_printk(KERN_INFO "%s.%s() : hello = %d\n", THIS_MODULE->name, __FUNCTION__,a);
>> }
>>
>> int __init ultrason_init(void) {
>>   a=0;
>>   rtdm_printk(KERN_INFO "%s.%s() : hello = %d\n", THIS_MODULE->name, __FUNCTION__,a);
>>   ret = rtdm_task_init(&task, "ultrason", task_ultrason, NULL, 99, periode_us*1000);
>>   if (ret) {
>>        rtdm_printk(KERN_INFO "%s.%s() : error rtdm_task_init, hello = %d\n", THIS_MODULE->name, __FUNCTION__,a);
>>   }
>>   else  rtdm_printk(KERN_INFO "%s.%s() : success rtdm_task_init, hello = %d\n", THIS_MODULE->name, __FUNCTION__,a);
>>   return 0;
>> }
>> void __exit ultrason_exit(void) {
>>   a=2;
>>   rtdm_task_destroy(&task);
>>   rtdm_printk(KERN_INFO "%s.%s() : hello = %d\n", THIS_MODULE->name, __FUNCTION__,a);
>>   }
>>
>> module_init(ultrason_init);
>> module_exit(ultrason_exit);
>> MODULE_LICENSE("GPL »);
>>
>> ————————— 
>>
>> When I insert the module and remove it, I found in dmesg:
>>
>> ————————— 
>>
>> [ 5045.187448] test.ultrason_init() : hello = 0
>> [ 5045.189495] test.ultrason_init() : success rtdm_task_init, hello = 0
>> [ 5049.631665] test.ultrason_exit() : hello = 2

This looks like a I bug fixed many moons ago in the printk support code for
the pipeline. This issue caused printk() output sent from the head stage not
to appear in the kernel log, a regression due to upstream changes which went
unnoticed.

You may want to update your I-pipe patch to the latest available in your
kernel series to make sure the fix is there. If not, your rt task would indeed
run shortly as requested by rtdm_task_init(), but the feedback would be
spuriously elided.

A trivial way to check this without ftracing: have task_ultrason() call
rtdm_task_sleep(10000000000ULL) before exiting, then you would have 10 secs to
manually check it was actually spawned by reading /proc/xenomai/sched/threads.

-- 
Philippe.

