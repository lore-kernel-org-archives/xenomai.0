Subject: Re: [Xenomai-core] Re: [Xenomai-help] [ANNOUNCE] RTDM driver for
	CAN devices
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44D4A0E4.5070703@domain.hid>
References: <44CF6EB1.1010808@domain.hid> <44D36389.3030706@domain.hid>
	<44D4A0E4.5070703@domain.hid>
Content-Type: text/plain
Date: Sat, 05 Aug 2006 17:45:03 +0200
Message-Id: <1154792704.4330.12.camel@domain.hid>
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
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

On Sat, 2006-08-05 at 15:45 +0200, Wolfgang Grandegger wrote:

> > - EXPORT_SYMBOL vs. EXPORT_SYMBOL_GPL: For me this makes no practical
> > difference anymore (kernel modules, specifically drivers must be GPL, no
> > matter what kind of symbols they use). Anyway, shouldn't we better go
> > the kernel path and introduce new APIs under _GPL? Just takes a wrapper
> > for 2.4 I guess.
> 
> Fine for me. Other comments?
> 

It's ok with me too.

> And how can I generate Doxygen documentation to check the integration of 
> the RTCAN device profile description?
> 

Passing --enable-dox-doc to configure will cause Doxygen to be run on
the sources as part of the build process. Doxygen.in should be updated
so that new documented contents appear in the INPUT stanza.

-- 
Philippe.



