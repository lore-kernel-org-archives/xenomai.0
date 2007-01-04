From: Sebastian Smolorz <ssm@domain.hid>
Subject: Re: [Xenomai-core] Support for 2.6.19
Date: Thu, 4 Jan 2007 10:51:57 +0100
References: <459C3EB8.5DA080F6@domain.hid> <459CC73B.1080402@domain.hid>
In-Reply-To: <459CC73B.1080402@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <E1H2PGO-0003cg-1z@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Detlef Vollmann wrote:
> > Hello,
> >
> > the x86 branch supports kernel 2.6.19, but the ARM branch only supports
> > 2.6.15.  Is there a specific reason for this?
> > Does anybody have a feeling what would be needed to be changed
> > for 2.6.19 support?
>
> I guess the reason is that it is some work that needs to be done. I had
> ported from 2.6.15 to 2.6.17, it was a trivial task as far as I could
> see, but never tried to port to 2.6.19. There were some architectural
> changes in 2.6.19, I do not know about their impact on the ARM
> architecture though.

Shortly before christmas I tried to port I-pipe for ARM to 2.6.19 during an 
insane hacking session. ;-) I tried to do it with I-pipe 1.5 and not with 
version 1.6 (as Philippe did it for x86) because I felt it could be less 
work. But probably I was wrong because too much problems appeared that I did 
not fix because the time is missing ATM. A cleaner approach surely would be 
to port I-pipe 1.6 for ARM to 2.6.19. Perhaps I can find some time for a 
second attempt soon.

--
Sebastian

