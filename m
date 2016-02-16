Sender: Michael Welling <mwelling79@gmail.com>
Date: Tue, 16 Feb 2016 11:36:59 -0600
From: Michael Welling <mwelling@ieee.org>
Message-ID: <20160216173659.GB9806@deathstar>
References: <20160215174121.GA10070@deathstar> <56C2B626.8010804@sigmatek.at>
 <20160216172924.GE17780@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160216172924.GE17780@hermes.click-hack.org>
Subject: Re: [Xenomai] RT serial cross-link failure
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Tue, Feb 16, 2016 at 06:29:24PM +0100, Gilles Chanteperdrix wrote:
> On Tue, Feb 16, 2016 at 06:39:50AM +0100, Wolfgang Netbal wrote:
> > 
> > 
> > Am 2016-02-15 um 18:41 schrieb Michael Welling:
> > > I took the time to update the IMX UART driver such that it registers with the 3.18 kernel.
> > >
> > > The driver appears to register correctly and the /dev/rtdm/rtser* nodes appear.
> > >
> > > When I run the cross-link demo the system hangs after an error in read_task.
> > >
> > > Here is the output that I get:
> > > main : write-file opened
> > > main : write-config written
> > > main : read-file opened
> > > main : read-config written
> > > main : write-task created
> > > main : read-task created
> > > main : starting write-task
> > > main : strating read-task
> > >   Nr |   write-irq    |    irq->read    |   write->read   |
> > > ----------------------------------------------------------
> > > read_task: error on RTSER_RTIOC_WAIT_EVENT, Operation no permitted
> > > main : /dev/rtdm/rtser1 (read) -> closed
> > > read_task: exit
> > >
> > > Any ideas why this would happen?
> > >
> > > I can provide the patch for the driver if necessary. I tried to keep the changes to a minimal.
> > Dear Michael,
> > 
> > I added a patch on December where I extended the IMX UART driver to 
> > support open firmware, maybe my patch can help you to find your issue.
> > I posted the patch in the mailing list, you can find it here 
> > https://xenomai.org/pipermail/xenomai/2015-December/035655.html
> 
> Please, as indicated at the bottom of every mail you receive from
> the mailing list, and in the mail headers, the address of the
> mailing list is xenomai@xenomai.org.
> 
> IT IS NOT xenomai-bounces@xenomai.org
> 
> When you send a regular mail to this wrong address, the mail
> administrators receive a mail, because, as its name indicates, this
> address is made to receive bounces. This is annoying.
>

Sorry I did not notice this on the reply.

Do you have any idea what driver Wolfgang's patch applies to?
 
> 
> -- 
> 					    Gilles.
> https://click-hack.org
> 
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

