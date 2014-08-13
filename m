Message-ID: <53EB5F9D.8000905@xenomai.org>
Date: Wed, 13 Aug 2014 14:52:45 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CANWkrRN=ExZ4qgcXp8+d2NOzBHUvWb2u6Zu8twmr8Vo2VZnnqg@mail.gmail.com>
In-Reply-To: <CANWkrRN=ExZ4qgcXp8+d2NOzBHUvWb2u6Zu8twmr8Vo2VZnnqg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RTDM !xnpod_unblockable_p() question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Smith <2michael.smith@gmail.com>, xenomai@xenomai.org

On 08/13/2014 02:28 PM, Michael Smith wrote:
> Hi
> I have been struggling with this problem for days on end, but there is just
> not enough information in the code
> or documentation for me to solve it.
> I am calling rtdm_mutex_lock() inside a device driver module. It is called
> by my PCI probe function as
> the driver is initializing.
> I keep on getting the error message:
> Xenomai: assertion failed at kernel/xenomai/skins/rtdm/drvlib.c:1534
> (!xnpod_unblockable_p())
> And the resultant -EPERM error message from the return of the function.
> 
> I know these checks were inserted to stop any call from an incorrect
> context. But as far as the documentation states
> it can be called from a kernel module.

The doc (2.6) reads:

 * This service can be called from:
 *
 * - Kernel-based task
 * - User-space task (RT)

The generic "kernel module" context is not mentioned. You get -EPERM
because you cannot call this from a probe() routine, which runs in
secondary/pure linux mode. Acquiring a RTDM mutex requires the caller to
run in real-time mode.

> Also as the mail form March 2006 states
> http://www.xenomai.org/pipermail/xenomai/2006-March/003116.html
> 
> !xnpod_unblockable_p():
> - allows blockable RT-context (kernel and user threads)
> - rejects user threads in secondary mode
> - rejects Linux threads
> 
> Is there something I'm missing with regards to the calling context?
> Are there any other situations this could also produce this return?
> Because as far as I can see it should fine being called in a kernel module.
> 
> Thanks
> Michael Smith
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
> 


-- 
Philippe.

