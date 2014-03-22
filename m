From: Robert Berger <gmane@reliableembeddedsystems.com>
Date: Sat, 22 Mar 2014 17:03:21 +0100
Message-ID: <532DB449.6080601@reliableembeddedsystems.com>
References: <1394099202.26562.YahooMailNeo@web163902.mail.gq1.yahoo.com>
 <53199C18.40508@reliableembeddedsystems.com> <5319C7CA.1030701@xenomai.org>
 <531A36AB.9040009@reliableembeddedsystems.com>
 <1394277251.3519.YahooMailNeo@web163906.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
In-Reply-To: <1394277251.3519.YahooMailNeo@web163906.mail.gq1.yahoo.com>
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

Hi,

On 03/08/2014 12:14 PM, Huub Van Niekerk wrote:>
> Hi Robert,
>
> Both with and without Xenomai, my network runs fine. For me, the
breakpoint of getting it to work was the enabling ([*] in kernel config)
of the 95XX chipset, since this chipset combines USB-host and
ethernet-over-USB. So it is not real ethernet but simulated. See the
xM-manual and 9514 data, which is not in the manual. I have set the
NOP_USB_XCEIV = [y] btw. For completeness, I run kernel 3.10.18, since
that is by my knowledge the currently latest supported kernel by Xenomai.

Can you please post (e.g. pastebin) your kernel config somewhere? I will
be busy next week, but definitely want to give it a try.

If you want to try 3.10.28 the patch is here [1]

Regards,

Robert

[1]
http://git.denx.de/?p=eldk.git;a=blob;f=meta-eldk/recipes-kernel/xenomai/files/0001-ipipe-kernel-3.10.patch;h=a8be9819c1df055db348c5d2f7278cbd43cb8d6c;hb=eldk-rel-v5.5

>
> Regards,
>
> hvn
>
...To go faster, slow down. Everybody who knows about orbital mechanics
understands that.- Scott Cherf

My public pgp key is available,at:
http://pgp.mit.edu:11371/pks/lookup?op=get&search=0x90320BF1



