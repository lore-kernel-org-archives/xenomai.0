MIME-Version: 1.0
In-Reply-To: <OF5D438985.E0F77773-ON85257B11.0049DC0C-85257B11.004A95E4@aanddtech.com>
References: <CAKS01o=CQrjWU4s4adBFtJout9v_tnhxEm8ziYyKi1qv824U7g@mail.gmail.com>
	<OF5D438985.E0F77773-ON85257B11.0049DC0C-85257B11.004A95E4@aanddtech.com>
Date: Wed, 13 Feb 2013 15:02:20 +0100
Message-ID: <CAKS01okiukirN94KAp8gipQiH_ZjMX5np=fSHKm3Zx81nXzK-g@mail.gmail.com>
From: Anup Kini <akini@synapticon.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Porting Ipipe to new ARM SoC (Xilinx Zynq) - porting
	guide
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: mfornero@aanddtech.com
Cc: xenomai@xenomai.org

Thanks for the update Matthew.
I have started working on the changes, will comment once i hit the goal.



On 13 February 2013 14:34, <mfornero@aanddtech.com> wrote:

> Anup Kini <akini@synapticon.com> wrote on 02/12/2013 05:14:17 PM:
>
> > From: Anup Kini <akini@synapticon.com>
> > To: xenomai@xenomai.org,
> > Cc: mfornero@aanddtech.com, gilles.chanteperdrix@xenomai.org,
> > stefan.roese@gmail.com
> > Date: 02/12/2013 05:13 PM
> > Subject: Porting Ipipe to new ARM SoC (Xilinx Zynq) - porting guide
> >
> > Hi All,
> >
> > I am new to Xenomai and trying to port ipipe to ZYNQ ZC702.
> > It would be really helpful to me if you guys could put up some steps
> > to follow or some porting guide on how to port ipipe to ZYNQ.
>
> Hi Anup,
>
> You can find my code on github at https://github.com/mfornero/ipipe
>
> This port is working, but uses the lower performing xttcps timer for the
> core 0 clockevent due to issues I was running into when using twd.
>
> I believe Stefan ran into something similar, and was able to resolve it by
> changing something in the .config (I haven't had a chance to look into it
> any further yet). If you want to restore the twd timer, simply reduce the
> rating of the xttcpss clockevent from 400 to 200 in
> arch/arm/mach-zynq-timer.c
>
> Note that there might be some new commits to the ipipe-core 3.5.7 tree
> that I haven't grabbed, so you might want to merge those in as well.
>
> Best Regards,
>
> Matthew Fornero
>
> >
> > --
> > Anup Kini
> > Systems Engineer
> >
> > Synapticon  |  Cyber-Physical System Solutions




-- 

*Anup Kini
*Systems Engineer****
*
------------------------------
*

*Synapticon** * |  Cyber-Physical System Solutions ****

Mobile:

Direct:

+49 151 / 638 646 73

+49 7335 / 186 999 17

Fax:****
+49 7335 / 186 999 1


 **

 ****

synapticon.com <http://www.synapticon.com/>  |
@synapticon_co<https://twitter.com/#!/synapticon_co>
****

Synapticon GmbH  |  Hohlbachweg 2  |  73344 Gruibingen, DE
Secretary +49 7335 / 186 999 0  |  General Manager: Nikolai Ensslen
Registry Court Ulm HRB 725114  |  USt-ID DE271647127****

This message and any files transmitted with it are confidential and
intended
solely for the use of the individual or entity to whom they are addressed.
Please notify the sender immediately if you have received this e-mail by
mistake and delete it from your system.
