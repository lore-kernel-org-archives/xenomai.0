References: <1394099202.26562.YahooMailNeo@web163902.mail.gq1.yahoo.com>
 <53199C18.40508@reliableembeddedsystems.com> <5319C7CA.1030701@xenomai.org>
 <531A36AB.9040009@reliableembeddedsystems.com>
Message-ID: <1394277251.3519.YahooMailNeo@web163906.mail.gq1.yahoo.com>
Date: Sat, 8 Mar 2014 03:14:11 -0800 (PST)
From: Huub Van Niekerk <huubvanniekerk@yahoo.com>
In-Reply-To: <531A36AB.9040009@reliableembeddedsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [Xenomai] process behaviour when running xenomai
Reply-To: Huub Van Niekerk <huubvanniekerk@yahoo.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Robert Berger <gmane@reliableembeddedsystems.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On Friday, March 7, 2014 10:57 PM, Robert Berger <gmane@reliableembeddedsystems.com> wrote:
 
Hi Gilles,

On 03/07/2014 03:21 PM, Gilles Chanteperdrix wrote:>
> Generally, before you report a non-working configuration of Xenomai,
> with a certain version of the kernel, please try the exact same kernel
> configuration without Xenomai.
>
>

>I think I was not explicit enough in my previous email.
>The problem that ethernet does not work is __NOT__ due to Xenomai!

>It's a general problem with beagle-xm and 3.10 (and not just)
>The workaround in theory is CONFIG_NOP_USB_XCEIV=M which will in best
>case turn on the ethernet interface in user space and not allow the
>kernel to load a rootfs over nfs.
>My intention was to ask the op if he has the network up and running with
>a 3.10 kernel and Xenomai.

Hi Robert,

Both with and without Xenomai, my network runs fine. For me, the breakpoint of getting it to work was the enabling ([*] in kernel config) of the 95XX chipset, since this chipset combines USB-host and ethernet-over-USB. So it is not real ethernet but simulated. See the xM-manual and 9514 data, which is not in the manual. I have set the NOP_USB_XCEIV = [y] btw. For completeness, I run kernel 3.10.18, since that is by my knowledge the currently latest supported kernel by Xenomai.

Regards,

hvn
