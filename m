Date: Fri, 19 Dec 2014 15:57:55 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141219145755.GA7589@hermes.click-hack.org>
References: <CALH4WdbO8pfsUCvUUHVtv_Rzh22-CLxAuRAZ=HzuPWOcvY7KdQ@mail.gmail.com>
 <20141218174447.GV2012@hermes.click-hack.org>
 <CALH4WdZvLBWyUavA7=UV=RoJEg+Cd3nEELjnQac3uZSkfj8B+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALH4WdZvLBWyUavA7=UV=RoJEg+Cd3nEELjnQac3uZSkfj8B+A@mail.gmail.com>
Subject: Re: [Xenomai] PATCH : msi patch rtcan_peak_pci
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Frederik Bayart <frederik.bayart@triphase.com>
Cc: xenomai@xenomai.org

On Fri, Dec 19, 2014 at 12:20:13PM +0100, Frederik Bayart wrote:
> On 18 December 2014 at 18:44, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
> > On Thu, Dec 18, 2014 at 05:53:33PM +0100, Frederik Bayart wrote:
> >> Hallo,
> >>
> >> We have added msi to the rtcan_peak_pci driver
> >> In attachment a zip file containing the old and the new rtcan_peak_pci.c
> >> and the patch.
> >> Can this patch be applied the the source tree ?
> >
> > Please send the patch alone, preferably inline, or as an attachment.
> > This makes review and comment easier.
> >
> > --
> >                                             Gilles.
> 
> Gilles,
> 
> Below the patch. I used  xenomai-3-3.0-rc2.tar because I haven't used
> git yet but I verified that the
> driver source didn't changed in git
> (http://git.xenomai.org/xenomai-3.git/plain/kernel/drivers/can/sja1000/rtcan_peak_pci.c)
> 
> Frederik
> 
> --- a/kernel/drivers/can/sja1000/rtcan_peak_pci.c    2014-10-31
> 15:18:44.000000000 +0100
> +++ b/kernel/drivers/can/sja1000/rtcan_peak_pci.c    2014-12-18
> 17:44:21.799350602 +0100
> @@ -301,6 +301,8 @@
>      if ((ret = pci_write_config_word(pdev, 0x44, 0)))
>      goto failure_cleanup;
> 
> +    pci_enable_msi(pdev);
> +

You should get pci_enable_msi return status, and...

>      if (sub_sys_id > 3) {
>      if ((ret = rtcan_peak_pci_add_chan(pdev, CHANNEL_MASTER,
>                         &master_dev)))
> @@ -337,6 +339,8 @@
>      rtcan_peak_pci_del_chan(board->slave_dev, 0);
>      rtcan_peak_pci_del_chan(dev, 0);
> 
> +    pci_disable_msi(pdev);
> +

if it failed, do not use pci_disable_msi.

-- 
					    Gilles.

