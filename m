Message-ID: <531A3EE0.8070205@xenomai.org>
Date: Fri, 07 Mar 2014 22:49:20 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1394099202.26562.YahooMailNeo@web163902.mail.gq1.yahoo.com>
 <53199C18.40508@reliableembeddedsystems.com> <5319C7CA.1030701@xenomai.org>
 <531A36AB.9040009@reliableembeddedsystems.com>
In-Reply-To: <531A36AB.9040009@reliableembeddedsystems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] process behaviour when running xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Robert Berger <gmane@reliableembeddedsystems.com>
Cc: xenomai@xenomai.org

On 03/07/2014 10:14 PM, Robert Berger wrote:
> Hi Gilles,
> 
> On 03/07/2014 03:21 PM, Gilles Chanteperdrix wrote:>
>> Generally, before you report a non-working configuration of Xenomai,
>> with a certain version of the kernel, please try the exact same kernel
>> configuration without Xenomai.
>>
>>
> 
> I think I was not explicit enough in my previous email.
> The problem that ethernet does not work is __NOT__ due to Xenomai!
> 
> It's a general problem with beagle-xm and 3.10 (and not just)
> The workaround in theory is CONFIG_NOP_USB_XCEIV=M which will in best
> case turn on the ethernet interface in user space and not allow the
> kernel to load a rootfs over nfs.

I would say you need CONFIG_NOP_USB_XCEIV=Y instead of M, otherwise you
will need to put the module in an initramfs (if you try to load the
module from the rootfs on NFS, you have an obvious chicken-and-egg issue).
I also turn on the OMAP-specific transceivers in the configuration I
use, just in case.

You may also have to use the rootwait kernel parameter in order to wait
for the USB detection.

And finally, in u-boot, you may want to use "usb stop" before you call
bootm, as some versions of Linux do not like to start with the USB
already running.

-- 
                                                                Gilles.

