Message-ID: <5319C7CA.1030701@xenomai.org>
Date: Fri, 07 Mar 2014 14:21:14 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1394099202.26562.YahooMailNeo@web163902.mail.gq1.yahoo.com>
 <53199C18.40508@reliableembeddedsystems.com>
In-Reply-To: <53199C18.40508@reliableembeddedsystems.com>
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

On 03/07/2014 11:14 AM, Robert Berger wrote:
> Hi,
> 
> On 03/06/2014 11:46 AM, Huub Van Niekerk wrote:
>> Hi,
>>
>> I'm running Xenomai 2.6.3 with kernel 3.10.18 now on BeagleBoard-Xm Rev. C and experience this behaviour: when I try to install packages from commandline, the installation manager starts quick and reads the package(s), but after that it stays dead quiet like it's frozen. ps -ef shows it's just going on, no defunc or anything like that. Also, when I want to watch the processes using top, it starts, but nothing shows. When I want to end it, Ctl-C gives no response giving me no other option than to use kill. Is this a known behaviour when running Xenomai ?
> 
> I tried something similar (just took the patch from the ELDK 5.5) but
> have some issues:
> 
> 1) no network on the beagle-xm and even if I hack my way through with
> phy_nop it's not getting better
> 
> I really would like to boot with a rootfs over nfs and it does not look
> like this is going to hapen with a 3.10 kernel on a beagle-xm.

FWIW, I only test xenomai with tftp + nfs, even the U-boot script is not
on the board itself. Xenomai 2.6.3 with linux 3.10.18 has been tested on
the pandaboard, which has exactly the same ethernet chip as beagle-xm
(from what I see in Huub's dmesg). The only difficulty for me was the
missing USB transceiver in the kernel configuration.

Generally, before you report a non-working configuration of Xenomai,
with a certain version of the kernel, please try the exact same kernel
configuration without Xenomai.


-- 
                                                                Gilles.

