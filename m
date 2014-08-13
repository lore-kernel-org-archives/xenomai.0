MIME-Version: 1.0
Date: Wed, 13 Aug 2014 14:28:18 +0200
Message-ID: <CANWkrRN=ExZ4qgcXp8+d2NOzBHUvWb2u6Zu8twmr8Vo2VZnnqg@mail.gmail.com>
From: Michael Smith <2michael.smith@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] RTDM !xnpod_unblockable_p() question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi
I have been struggling with this problem for days on end, but there is just
not enough information in the code
or documentation for me to solve it.
I am calling rtdm_mutex_lock() inside a device driver module. It is called
by my PCI probe function as
the driver is initializing.
I keep on getting the error message:
Xenomai: assertion failed at kernel/xenomai/skins/rtdm/drvlib.c:1534
(!xnpod_unblockable_p())
And the resultant -EPERM error message from the return of the function.

I know these checks were inserted to stop any call from an incorrect
context. But as far as the documentation states
it can be called from a kernel module.
Also as the mail form March 2006 states
http://www.xenomai.org/pipermail/xenomai/2006-March/003116.html

!xnpod_unblockable_p():
- allows blockable RT-context (kernel and user threads)
- rejects user threads in secondary mode
- rejects Linux threads

Is there something I'm missing with regards to the calling context?
Are there any other situations this could also produce this return?
Because as far as I can see it should fine being called in a kernel module.

Thanks
Michael Smith
