Sender: Michael Welling <mwelling79@gmail.com>
Date: Mon, 22 Feb 2016 11:53:41 -0600
From: Michael Welling <mwelling@ieee.org>
Message-ID: <20160222175341.GA22349@deathstar>
References: <20160215174121.GA10070@deathstar> <56C2B626.8010804@sigmatek.at>
 <20160216175837.GC9806@deathstar> <56C56C98.4020501@sigmatek.at>
 <20160218071030.GA20063@deathstar> <56C57320.8060002@sigmatek.at>
 <20160218161047.GA10005@deathstar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160218161047.GA10005@deathstar>
Subject: Re: [Xenomai] RT serial cross-link failure
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Netbal <wolfgang.netbal@sigmatek.at>
Cc: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, mwelling79@gmail.com, Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On Thu, Feb 18, 2016 at 10:10:48AM -0600, Michael Welling wrote:
> On Thu, Feb 18, 2016 at 08:30:40AM +0100, Wolfgang Netbal wrote:
> > 
> > 
> > Am 2016-02-18 um 08:10 schrieb Michael Welling:
> > >On Thu, Feb 18, 2016 at 08:02:48AM +0100, Wolfgang Netbal wrote:
> > >>
> > >>Am 2016-02-16 um 18:58 schrieb Michael Welling:
> > >>>On Tue, Feb 16, 2016 at 06:39:50AM +0100, Wolfgang Netbal wrote:
> > >>>>Am 2016-02-15 um 18:41 schrieb Michael Welling:
> > >>>>>I took the time to update the IMX UART driver such that it registers with the 3.18 kernel.
> > >>>>>
> > >>>>>The driver appears to register correctly and the /dev/rtdm/rtser* nodes appear.
> > >>>>>
> > >>>>>When I run the cross-link demo the system hangs after an error in read_task.
> > >>>>>
> > >>>>>Here is the output that I get:
> > >>>>>main : write-file opened
> > >>>>>main : write-config written
> > >>>>>main : read-file opened
> > >>>>>main : read-config written
> > >>>>>main : write-task created
> > >>>>>main : read-task created
> > >>>>>main : starting write-task
> > >>>>>main : strating read-task
> > >>>>>  Nr |   write-irq    |    irq->read    |   write->read   |
> > >>>>>----------------------------------------------------------
> > >>>>>read_task: error on RTSER_RTIOC_WAIT_EVENT, Operation no permitted
> > >>>>>main : /dev/rtdm/rtser1 (read) -> closed
> > >>>>>read_task: exit
> > >>>>>
> > >>>>>Any ideas why this would happen?
> > >>>>>
> > >>>>>I can provide the patch for the driver if necessary. I tried to keep the changes to a minimal.
> > >>>>Dear Michael,
> > >>>>
> > >>>>I added a patch on December where I extended the IMX UART driver to support
> > >>>>open firmware, maybe my patch can help you to find your issue.
> > >>>>I posted the patch in the mailing list, you can find it here
> > >>>>https://xenomai.org/pipermail/xenomai/2015-December/035655.html
> > >>>>
> > >>>>Kind regards
> > >>>>Wolfgang
> > >>Sorry Michael,
> > >>
> > >>My patch working for xenomai 2.6.4 file ksrc/drivers/serial/rt_imx_uart.c
> > >I am pretty sure that there is another patch applied previous.
> > >
> > >If you look at your patch you see German comments and open firmware code that
> > >is obviously not in the v2.6.4 on the git repository.
> > >
> > >https://git.xenomai.org/xenomai-2.6.git/tree/ksrc/drivers/serial/rt_imx_uart.c?h=v2.6.4
> > >
> > I posted my patch, because I thought that Wolfgang Grandegger the author of
> > the driver may check it and include it to the xenomai if it is useable for
> > other users.
> >
> 
> Yes but the patch does not apply to the driver in the source tree.
> Please provide the driver that you have after the patch.

Any ideas out there?

