Message-ID: <2ff1a98a0801230208ve14d7ebyc6192c914102087@domain.hid>
Date: Wed, 23 Jan 2008 11:08:05 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <50661.28824.qm@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <50661.28824.qm@domain.hid>
Subject: Re: [Xenomai-help] Xenomai with LPC2468 ARM processor
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gigi Atanasoaie <agigi02@domain.hid>
Cc: xenomai@xenomai.org

On Jan 23, 2008 8:50 AM, Gigi Atanasoaie <agigi02@domain.hid> wrote:
> Hello,
>
> I'm trying to use Xenomai with uCLinux (kernel
> 2.6.21), running on LPC2468 ARM processor.
>
> I have some questions:
>
> 1. Is the Adoes ipipe implementation available for
> this processor? If yes, can you, please, specify the
> patch to be used?

We have an I-pipe patch for ARM, we tried to provide on Xenomai wiki
some information on how to port this patch on a new board :
http://www.xenomai.org/index.php/I-pipe:ArmPorting

Note that this patch is made to run on ARMs with an mmu, if you want
xenomai to run without MMU, you will probably have to add some #ifdef
CONFIG_MMU here and there.

>
> 2. Has anybody experience using it, in the
> configuration above?
>
> Regards,
>  Gige
>
>
>
>       ____________________________________________________________________________________
> Never miss a thing.  Make Yahoo your home page.
> http://www.yahoo.com/r/hs
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>



-- 
                                               Gilles Chanteperdrix

