Message-ID: <4B508AE7.8090300@domain.hid>
Date: Fri, 15 Jan 2010 16:33:59 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <4B209B9C.7010309@domain.hid>	
	<20100108105925.GA14163@domain.hid>	
	<1262949018.2455.5.camel@domain.hid>	
	<1263312199.2455.169.camel@domain.hid>	
	<20100112172443.GP8605@domain.hid>	
	<1263318551.2455.188.camel@domain.hid>	
	<20100112185012.GQ8605@domain.hid>	
	<1263324215.2455.293.camel@domain.hid>	
	<20100112221802.GR8605@domain.hid>
	<1263567811.2428.487.camel@domain.hid>
In-Reply-To: <1263567811.2428.487.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Adeos-main] I-pipe for 2.6.32 PPC
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main@gna.org, Bernhard Pfund <bernhard@domain.hid>, xenomai@xenomai.org, Lennart Sorensen <lsorense@domain.hid>

Hi Philippe,

Philippe Gerum wrote:
[snip]
> On Tue, 2010-01-12 at 17:18 -0500, Lennart Sorensen wrote: 
> You did port the pipeline to 2.6.32/ppc32 for running on mpc8360, which
> fits your needs. But the pipeline patch has to be upgraded for ppc64 as
> well. Even for ppc32, a patch is normally validated for a set of 4xx,
> 512x, 52xx, 82xx, 85xx, and 86xx platforms, by the Xenomai standards:
> http://www.xenomai.org/index.php/Embedded_Device_Support#Supported_Evaluation_Boards_3
> 
> Btw, your patch never made it to the list, since this is a
> subscriber-only list, and last time I checked, you were not subscribed.
> Or maybe you posted from a different mail address, but I did not see
> your mail though. I usually acknowledge public contributions.

Here is the story. Lennart mentioned on the linuxppc-dev mailing list,
that he has a iPipe patch for 2.6.32:
 http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-December/079191.html

I asked him privately, if the patch is available and he sent it to me
with the note, that I can publish it on the mailing list if I feel it's
useful. This patch helped me to go ahead immediately with some related
development work. I also forwarded the patch to you.

Wolfgang.

