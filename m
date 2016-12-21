References: <CA+_GcoBZSOuEs_yrdG0EWXxUk5_PEC1qf69+jfqQFC_MpgFb9w@mail.gmail.com>
 <908427a1-bdb4-2ac8-ce51-3087f0006b17@xenomai.org>
 <CA+_GcoC-cYVnRM9KCQmpJUiG8=b=gLdFiMgPvDgcNdYKpnjNfA@mail.gmail.com>
 <212f288a-11c1-94f6-049e-c6d5aab99647@xenomai.org>
 <CA+_GcoD-T2zraBLgTDYi89_4Fdx_EBmPqkU5wn3wV51-xUZSgw@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <1677bcfb-1a55-5f1a-9b0f-845ec60f6191@xenomai.org>
Date: Wed, 21 Dec 2016 17:11:59 +0100
MIME-Version: 1.0
In-Reply-To: <CA+_GcoD-T2zraBLgTDYi89_4Fdx_EBmPqkU5wn3wV51-xUZSgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] System hang when doing several rtdm_task_init()
	calling
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sebastien Schneider <seb.schneider@gmail.com>
Cc: xenomai@xenomai.org

On 12/21/2016 03:24 PM, Sebastien Schneider wrote:
> I've correctly set CONFIG_XENO_OPT_WATCHDOG thanks to CONFIG_XENO_OPT_DEBUG.
> Here is the basic version of driver I try to load, and that leads to the
> same effect :
> 
> /#define LOWEST_PRIORITY 0/
> /#define HIGHEST_PRIORITY 99/
> /rtdm_task_t task1;/
> /rtdm_task_t task2;/
> /
> /
> /void handler_task1(void *arg)/
> /{/
> /        while(1)/
> /        {/
> /        }/
> /        return ;/
> /}/
> /
> /
> /void handler_task2(void *arg)/
> /{/
> /        while(1)/
> /        {/
> /        }/
> /        return ;/
> /}/
> /
> /
> /static int __init vlc_driver_init(void)/
> /{/
> /        printk(KERN_INFO "VLC: Inserting module...\n");/
> /        rtdm_task_init(&task1, "task1", handler_task1, NULL,
> LOWEST_PRIORITY, 0);/
> /        rtdm_task_init(&task2, "task2", handler_task2, NULL,
> HIGHEST_PRIORITY, 0);/
> /        return 0;/
> /}/
> /
> /
> /static void __exit vlc_driver_exit(void)/
> /{/
> /        printk(KERN_INFO "VLC: Removing module...\n");/
> /        return;/
> /}/
> /
> /
> /module_init(vlc_driver_init);/
> /module_exit(vlc_driver_exit);/
> /MODULE_LICENSE("GPL");/
> /
> /
> So, it must be something very basic I did not have understood !!!
> 

If the code above is actually the one you are trying to run over a dual
kernel system, infinitely running real-time tasks which never block can
only lead to a complete lock up.

-- 
Philippe.

