From: Robert Berger <gmane@reliableembeddedsystems.com>
Date: Fri, 07 Mar 2014 12:14:48 +0200
Message-ID: <53199C18.40508@reliableembeddedsystems.com>
References: <1394099202.26562.YahooMailNeo@web163902.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
In-Reply-To: <1394099202.26562.YahooMailNeo@web163902.mail.gq1.yahoo.com>
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

On 03/06/2014 11:46 AM, Huub Van Niekerk wrote:
> Hi,
> 
> I'm running Xenomai 2.6.3 with kernel 3.10.18 now on BeagleBoard-Xm Rev. C and experience this behaviour: when I try to install packages from commandline, the installation manager starts quick and reads the package(s), but after that it stays dead quiet like it's frozen. ps -ef shows it's just going on, no defunc or anything like that. Also, when I want to watch the processes using top, it starts, but nothing shows. When I want to end it, Ctl-C gives no response giving me no other option than to use kill. Is this a known behaviour when running Xenomai ?

I tried something similar (just took the patch from the ELDK 5.5) but
have some issues:

1) no network on the beagle-xm and even if I hack my way through with
phy_nop it's not getting better

I really would like to boot with a rootfs over nfs and it does not look
like this is going to hapen with a 3.10 kernel on a beagle-xm.

3.13.x with fdt works nicely, but there is no Xenomai patch for it;)

> 
> 
> Thanks,
> 
> hvn
> 

Regards,

Robert

...For every complex problem there is a solution which is simple, neat
and wrong. -- H.L. Mencken

My public pgp key is available,at:
http://pgp.mit.edu:11371/pks/lookup?op=get&search=0x90320BF1



