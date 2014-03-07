From: Robert Berger <gmane@reliableembeddedsystems.com>
Date: Fri, 07 Mar 2014 23:14:19 +0200
Message-ID: <531A36AB.9040009@reliableembeddedsystems.com>
References: <1394099202.26562.YahooMailNeo@web163902.mail.gq1.yahoo.com>
 <53199C18.40508@reliableembeddedsystems.com> <5319C7CA.1030701@xenomai.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
In-Reply-To: <5319C7CA.1030701@xenomai.org>
Subject: Re: [Xenomai] process behaviour when running xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi Gilles,

On 03/07/2014 03:21 PM, Gilles Chanteperdrix wrote:>
> Generally, before you report a non-working configuration of Xenomai,
> with a certain version of the kernel, please try the exact same kernel
> configuration without Xenomai.
>
>

I think I was not explicit enough in my previous email.
The problem that ethernet does not work is __NOT__ due to Xenomai!

It's a general problem with beagle-xm and 3.10 (and not just)
The workaround in theory is CONFIG_NOP_USB_XCEIV=M which will in best
case turn on the ethernet interface in user space and not allow the
kernel to load a rootfs over nfs.
My intention was to ask the op if he has the network up and running with
a 3.10 kernel and Xenomai.

Sorry for not being clear enough.

Regards,

Robert

...There's no time to stop for gas, we're already late.- Karin Donker

My public pgp key is available,at:
http://pgp.mit.edu:11371/pks/lookup?op=get&search=0x90320BF1



