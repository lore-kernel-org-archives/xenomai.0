Message-ID: <545D2CD9.1030404@xenomai.org>
Date: Fri, 07 Nov 2014 21:34:33 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <545CC287.908@selex-es.com>
In-Reply-To: <545CC287.908@selex-es.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai 2.X on Freescale QorIQ T2080 processor
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Pampolini Matteo <matteo.pampolini@selex-es.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 11/07/2014 02:00 PM, Pampolini Matteo wrote:
> Hello there,
> 
> do you know if all around the world someone is working to port Xenomai
> 2.X on Freescale QorIQ T2080 processor?
> Because this processor does not appear in the list of supported ones?
> 
> If yes, would it be possible to know which patch is used? And if no, may
> you please point me in the right direction
> to create it by myself and then give it back to community?
> 

You did not mention which kernel release was of interest, so I'll assume
3.14. This patch is the right starting point for 3.14:

http://download.gna.org/adeos/patches/v3.x/powerpc/ipipe-core-3.14.17-powerpc-4.patch

Then add the few commits that piled up in the I-pipe git tree since tag
"ipipe-core-3.14.17-powerpc-4", which the patch mentioned above
corresponds to: http://git.xenomai.org/ipipe.git/log/?h=ipipe-3.14
Or wait until drop -5 appears in the download area, they will be included.

Then have a look at the PIC code for making it aware of the interrupt
pipeline, this beast likely sports a MPIC (just a guess), in which case
the work to support the "generic" MPIC is done already. Having a look at
the error interrupt handling for freescale's PIC chips in sysdev/ may be
a good idea too.

Another interesting part is in head_fsl_booke.S, in case this platform
has additional exception vectors which might need to be pipelined.

There will be other issues, but this is a starting point.

-- 
Philippe.

