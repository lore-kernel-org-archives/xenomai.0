Message-ID: <3D359E41.91626167@domain.hid>
Date: Wed, 17 Jul 2002 12:41:37 -0400
From: Karim Yaghmour <karim@domain.hid>
Reply-To: karim@domain.hid
MIME-Version: 1.0
Subject: Re: [Adeos-main] porting adeos to MIPS architecture
References: <OFCD857115.70858C2E-ONC1256BF9.004147F0@domain.hid>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <http://mail.freesoftware.fsf.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: <adeos-main.mail.freesoftware.fsf.org>
List-Unsubscribe: <http://mail.freesoftware.fsf.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <http://mail.freesoftware.fsf.org/pipermail/adeos-main/>
To: toon.diels@domain.hid
Cc: adeos-main@gna.org

Hello Toon,

This is great. I'm looking forward to more ports like this. I'd really
like to take a look at the drawings and give you some feedback, but
there's no Visio for Linux and I haven't been running that other OS
for a long time. Could you export those to PS or EPS?

Cheers,

Karim

toon.diels@domain.hid wrote:
> 
> Hi all,
> 
> I am porting adeos-1.0 to a MIPS processor. The most straight forward activities are porting the inline
> assembly code for eg enabling/disabling interrupt, save/restoring registers etc.
> 
> However, porting the interrupt pipe (and domain switching) is not that trivial since it requires rewriting of the ipipe.
> MIPS interrupt mechanisms are different then the x86 interrupt handling.
> 
> Before I start rewriting the interrupt (and exception) pipe mechanism to MIPS architecture, I would like to ask the
> ADEOS originators what they expect to be reused when doing an architecture port: eg is it just reusing the API or
> do you also want to reuse the sources (and which ones).
> 
> I have added some visio drawings with respect to the MIPS interrupt/exception handling to indicate how this takes
> place on a MIPS.
> 
> (See attached file: viper_irq_pipeline.vsd)(See attached file: viper_irq.vsd)
> 
> thank you for the information and kind regards,
> 
> Toon
> 
>   ------------------------------------------------------------------------------------------------------------------------------------------------------
>                              Name: viper_irq_pipeline.vsd
>    viper_irq_pipeline.vsd    Type: unspecified type (application/octet-stream)
>                          Encoding: base64
> 
>                     Name: viper_irq.vsd
>    viper_irq.vsd    Type: unspecified type (application/octet-stream)
>                 Encoding: base64

-- 
===================================================
                 Karim Yaghmour
               karim@domain.hid
      Embedded and Real-Time Linux Expert
===================================================

