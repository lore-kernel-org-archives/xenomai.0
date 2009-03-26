Sender: Vandana Sasidharan <vandana.sasidharan@domain.hid>
From: Vandana Sasidharan <vandana.sasidharan@domain.hid>
MIME-Version: 1.0
Date: Thu, 26 Mar 2009 12:57:12 +0530
Message-ID: <OF2372DA24.DE72182A-ON65257585.0028F12A-65257585.0028F145@domain.hid>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [Xenomai-help] Error in adapter.cc during the "make" of xenosim
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

Hi,

Thank you Bruno for your suggestion. After making changes in the Adapter.cc
as you had told and while re-compiling I got the following errors in
"queue.c and heap.c".

queue.c


/usr/src/xenomai-2.4.7/xenosim-2.4.7/../include/native/queue.h:135:
prototype declaration
/usr/src/xenomai-2.4.7/xenosim-2.4.7/../ksrc/skins/native/queue.c:360: `q'
undeclared (first use in this function)
/usr/src/xenomai-2.4.7/xenosim-2.4.7/../ksrc/skins/native/queue.c:360:
(Each undeclared identifier is reported only once
/usr/src/xenomai-2.4.7/xenosim-2.4.7/../ksrc/skins/native/queue.c:360: for
each function it appears in.)
make[2]: *** [queue.o] Error 1
make[2]: Leaving directory
`/usr/src/xenomai-2.4.7/xenosim-2.4.7/sim_bld/skins/native'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory
`/usr/src/xenomai-2.4.7/xenosim-2.4.7/sim_bld/skins'
make: *** [all-recursive] Error 1

 int rt_queue_delete_inner(RT_QUEUE *q, void __user *mapaddr)
    351 {
    352         int err = 0;
    353         spl_t s;
    354
    355         if (xnpod_asynch_p())
    356                 return -EPERM;
    357
    358         xnlock_get_irqsave(&nklock, s);
    359
    360         q = xeno_h2obj_validate(q, XENO_QUEUE_MAGIC, RT_QUEUE);
    361
    362         if (!q) {
    363                 err = xeno_handle_error(q, XENO_QUEUE_MAGIC,
RT_QUEUE);
    364                 xnlock_put_irqrestore(&nklock, s);
    365                 return err;
    366         }
    367

heap.c :

/usr/src/xenomai-2.4.7/xenosim-2.4.7/../ksrc/skins/native/heap.c:388:
syntax error before `*'
/usr/src/xenomai-2.4.7/xenosim-2.4.7/../ksrc/skins/native/heap.c: In
function `rt_heap_delete_inner':
/usr/src/xenomai-2.4.7/xenosim-2.4.7/../ksrc/skins/native/heap.c:389:
number of arguments doesn't match prototype
/usr/src/xenomai-2.4.7/xenosim-2.4.7/../include/native/heap.h:121:
prototype declaration
/usr/src/xenomai-2.4.7/xenosim-2.4.7/../ksrc/skins/native/heap.c:398:
`heap' undeclared (first use in this function)
/usr/src/xenomai-2.4.7/xenosim-2.4.7/../ksrc/skins/native/heap.c:398: (Each
undeclared identifier is reported only once
/usr/src/xenomai-2.4.7/xenosim-2.4.7/../ksrc/skins/native/heap.c:398: for
each function it appears in.)
make[2]: *** [heap.o] Error 1
make[2]: Leaving directory
`/usr/src/xenomai-2.4.7/xenosim-2.4.7/sim_bld/skins/native'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory
`/usr/src/xenomai-2.4.7/xenosim-2.4.7/sim_bld/skins'
make: *** [all-recursive] Error 1


int rt_heap_delete_inner(RT_HEAP *heap, void __user *mapaddr)
{
        int err = 0;
        spl_t s;

        if (!xnpod_root_p())
                return -EPERM;

        xnlock_get_irqsave(&nklock, s);

        heap = xeno_h2obj_validate(heap, XENO_HEAP_MAGIC, RT_HEAP);

        if (!heap) {
                err = xeno_handle_error(heap, XENO_HEAP_MAGIC, RT_HEAP);
                xnlock_put_irqrestore(&nklock, s);
                return err;
        }

Please can you help and let me know what wrong I am doing.
Thank you in advance,
With regards,
Vandana

=====-----=====-----=====
Notice: The information contained in this e-mail
message and/or attachments to it may contain 
confidential or privileged information. If you are 
not the intended recipient, any dissemination, use, 
review, distribution, printing or copying of the 
information contained in this e-mail message 
and/or attachments to it are strictly prohibited. If 
you have received this communication in error, 
please notify us by reply e-mail or telephone and 
immediately and permanently delete the message 
and any attachments. Thank you




