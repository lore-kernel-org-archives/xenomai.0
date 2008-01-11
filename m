Message-ID: <2ff1a98a0801111029g3d3312ads532b6ec0ca5bcaf7@domain.hid>
Date: Fri, 11 Jan 2008 19:29:32 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <4787B3DB.5010507@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d3623eab0801110744y63764ba2sb122db96a85bde80@domain.hid>
	<d3623eab0801110806y75b51c1kc31efe7d357de522@domain.hid>
	<4787B3DB.5010507@domain.hid>
Subject: Re: [Xenomai-help] cannot make system() calls anymore
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org, jay@domain.hid

On Jan 11, 2008 7:22 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> Jerome Pasquero wrote:
> > Hi,
> >
> > I recently upgraded from xenomai 2.3.0 under linux 2.6.17.14 to the latest
> > stable version of xenomai 2.4.1 under linux 2.6.23.12.
> > Everything seems to be working just fine, except that I seem to  no longer
> > be able to make system calls inside a real-time task. It simply freezes
> > everything and I need to restart my computer.
> > I don't know if it was just a fluke that it was working with 2.3.0 and that
> > I am not supposed to do that at all. Could it be that I forgot to include an
> > option when recompiling the kernel?
>
> A system freeze is not a valid reaction of Xenomai on invalid user
> activity - unless that freeze just means one of your high-prio tasks
> decided to enter an endless loop. Have you already tried to enable the
> Xenomai watchdog?

A freeze on fork (system calls fork) is typical of the "nocow" stuff
not working correctly.

-- 
                                               Gilles Chanteperdrix

