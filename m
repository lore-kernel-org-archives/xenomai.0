References: <1394099202.26562.YahooMailNeo@web163902.mail.gq1.yahoo.com>
 <5319F47D.3080906@xenomai.org>
Message-ID: <1394221706.80932.YahooMailNeo@web163901.mail.gq1.yahoo.com>
Date: Fri, 7 Mar 2014 11:48:26 -0800 (PST)
From: Huub Van Niekerk <huubvanniekerk@yahoo.com>
In-Reply-To: <5319F47D.3080906@xenomai.org>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Friday, March 7, 2014 5:33 PM, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
 
On 03/06/2014 10:46 AM, Huub Van Niekerk wrote:

> Hi,
> 
> I'm running Xenomai 2.6.3 with kernel 3.10.18 now on BeagleBoard-Xm
> Rev. C and experience this behaviour: when I try to install packages
> from commandline, the installation manager starts quick and reads the
> package(s), but after that it stays dead quiet like it's frozen. ps
> -ef shows it's just going on, no defunc or anything like that. Also,
> when I want to watch the processes using top, it starts, but nothing
> shows. When I want to end it, Ctl-C gives no response giving me no
> other option than to use kill. Is this a known behaviour when running
> Xenomai ?

>Does the access to SD-card work fine? BeagleBone users have reported an 
>issue with the OMAP SD card controller fixed in the 3.12 kernel by this 
>patch:

>http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=7472bab236bdee1173412585591329e718f4d324

>Patching the kernel with Xenomai made the bug more likely to happen.

Don't know if it has anything to do with it, but quite a few write actions seem to end in stalling. But so do other actions, like sudo. Via another ssh session, I can then see what's happening and either kill the action or let it go on. Quite annoying and causes a lot of delay in waiting and then see if something is still getting on.
