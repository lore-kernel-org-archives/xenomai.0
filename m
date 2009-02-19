From: Peter Soetens <peter.soetens@domain.hid>
Date: Thu, 19 Feb 2009 13:08:31 +0100
References: <9c789a000902160455k7dcae1d2tc151b12df6140ec0@domain.hid>
	<499BBB08.5060801@domain.hid> <87iqn7qpj7.fsf@domain.hid>
In-Reply-To: <87iqn7qpj7.fsf@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200902191308.31266.peter.soetens@domain.hid>
Subject: Re: [Xenomai-core] Comedi drivers in Xenomai porting/integration
	status ?
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Alexis Berlemont <berlemont.hauw@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

On Thursday 19 February 2009 00:43:56 Alexis Berlemont wrote:
> Hi,
>
> >> That was the reason why, I was really suprised to find Comedi
> >> integrated into the mainline kernel. What strikes me more is that
> >> Comedi seems to be left as is. Do you think, it will be cleaned up or
> >> reworked ?
> >
> > Without rework Comedi will not make into mainline (I wouldn't call the
> > staging corner "mainline"). And when reading this
> > http://permalink.gmane.org/gmane.linux.kernel/793476, it is probably the
> > best time now to propose interface changes and contribute back
> > improvements made for the RTDM rework.
>
> How would you proceed ? Maybe, the first step would be to ask on the
> Comedi mailing-list if someone is interested in discussing on the API
> rework. Maybe, someone will answer this time.

Much wil depend on how you approach upstream. An example: Keith Packard and 
Ingo Molnar managed to push major changes into the Linux kernel mainline. Not 
by forcing yet another architecture into Linus' throat, but by saying "Hey, I 
need these video services from the kernel, how should we fix that?" or saying: 
'Look how broken locking imlementation X is, I have a patch that cleans it up, 
and by the way, adds priority inheritance." 

What I'm saying is tht it's very risky to ask upstream to move to you. But if 
you move to upstream, success is almost guaranteed.

Peter

-- 
Peter Soetens -- FMTC -- <http://www.fmtc.be>

