In-Reply-To: <20150812123920.GD21595@hermes.click-hack.org>
References: <OF3EB5637C.BE58E83A-ONC1257E9F.0042D131-C1257E9F.0042E65D@marposs.com>
 <20150812122152.GC21595@hermes.click-hack.org>
 <20150812123920.GD21595@hermes.click-hack.org>
MIME-Version: 1.0
Message-ID: <OF4F6B2713.B0429143-ONC1257E9F.004ABEC3-C1257E9F.004AC655@marposs.com>
From: Cristiano.Mantovani@marposs.com
Date: Wed, 12 Aug 2015 15:36:43 +0200
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rt_task_sleep returns -38
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Thank you very much for your reply!

I have never used the mainline kernel on i.mx6q, only freescale kernels.
I have just compiled and I'm testing this new version for me.

Can I use the ipipe-core-3.10.32-arm-5 provided in Xenomai 2.6.4?
Is possible it works with kernel 3.10.17?

The same example with freescale kernel 3.0.35 (adeos-ipipe-3.0.43) has 
this behavior: 

the "rt_task_sleep" of task1 doesn't return with -38 but  task1 context is 
switched to secondary mode.
If I change the call of "system" with another linux system calls, the 
example works fine.


Cristiano Mantovani
R&D Measuring Systems - Software Designer
phone +39 051 899 389 | fax +39 051 899 802
Cristiano.Mantovani@marposs.com



______________________________________________________

MARPOSS S.p.A., with a sole shareholder
Via Saliceto, 13 - 40010 BENTIVOGLIO (BO) - ITALY

Share Capital euro 14,126,000 paid in full - Tax Code and Registration No. at 
Business Register of Bologna 02759341205
Economic and Administrative Index No. 464925 - VAT IT 02759341205
 


______________________________________________________


The   information  contained  in  this e-mail  and  any  attachments is 
confidential  and  may  also  be  privileged. If you have received the e-mail 
and any attachments by mistake, please inform us  immediately, destroy them 
without storing or copying them on any medium, and do not disclose or use the 
contents for any purpose.
Although our systems implement reasonable precautions against viruses and other 
threats, we cannot accept responsibility for any loss or damage arising from 
managing the contents of this e-mail. 

P  Please consider the environment before printing this e-mail


From:   Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
To:     Cristiano.Mantovani@marposs.com
Cc:     xenomai@xenomai.org
Date:   12/08/2015 14:39
Subject:        Re: [Xenomai] rt_task_sleep returns -38



On Wed, Aug 12, 2015 at 02:21:53PM +0200, Gilles Chanteperdrix wrote:
> On Wed, Aug 12, 2015 at 02:10:42PM +0200, 
Cristiano.Mantovani@marposs.com wrote:
> > Hi,
> > 
> > I have just started to use Xenomai and I'm using Linux kernel version 
> > 3.10.17-1.0.2 released for Freescale i.MX6Q with Xenomai 2.6.3 (I-pipe 

> > patch: ipipe-core-3.10.18-arm-1.patch).
> > I have seen a behavior that I don't understand, it is in this simple 
> > example:
> 
> Can you reproduce the same issues with current versions of the
> I-pipe patch?
(base on mainline kernels and not freescale fork)

... and Xenomai?

-- 
      Gilles.
https://click-hack.org




-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: image/jpeg
Size: 20961 bytes
Desc: not available
URL: <http://xenomai.org/pipermail/xenomai/attachments/20150812/637328fc/attachment.jpe>
