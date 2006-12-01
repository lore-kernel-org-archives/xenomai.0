Subject: Re: [Xenomai-help] Re: [Xenomai-core] [ANNOUNCE] Xenomai Example
	Repository
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4570B112.8010204@domain.hid>
References: <457002EB.8080106@domain.hid> <45705C11.2010502@domain.hid>
	<457064F3.5050300@domain.hid> <1164995694.4952.134.camel@domain.hid>
	<4570B112.8010204@domain.hid>
Content-Type: text/plain
Date: Fri, 01 Dec 2006 23:59:08 +0100
Message-Id: <1165013948.4952.186.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

On Fri, 2006-12-01 at 23:47 +0100, Wolfgang Grandegger wrote:
> >

[...]

>  
> > This said, I agree that adding a fake module directory to capture the
> > flags set by the main kernel Makefile is one step beyond ugliness; the
> > other approach being to only provide a 2.6 Makefile frag. As 2007
> > approaches, I think that anyone still involved with projects relying on
> > 2.4 kernels do know how to build 2.4 modules for the targeted platform.
> 
> I think the example modules should compile on any platform and the 
> "kernel CFLAGS capturing" trick is the most straight-forward way to do 
> it for 2.4. It simplifies our life, avoids fiddling with various arch 
> dependent flags in the Makefile, which will be even more ugly, and it 
> serves as an example on how to get proper flags. Therefore I tend to add 
> an appropriate script to the "scripts" subdirectory.

That would be acceptable too; the capture trick is ugly, but if we
really want to have the generic examples available to all platforms, I
see no other way to get the exact compilation and link flags. So it's
basically a matter of choice: either we don't provide any Makefile frag
for 2.4, or we implement the capture trick so that every platform can
compile them.

-- 
Philippe.



