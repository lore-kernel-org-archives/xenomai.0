Subject: Re: [Xenomai-help] Howto catch SEGV signals in Xenomai
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45F7F81E.9040203@domain.hid>
References: <17783933.1173875794637.JavaMail.ngmail@domain.hid>
	<1173878793.32259.46.camel@domain.hid>  <45F7F81E.9040203@domain.hid>
Content-Type: text/plain
Date: Wed, 14 Mar 2007 14:33:39 +0100
Message-Id: <1173879220.32259.54.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, 2007-03-14 at 14:26 +0100, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
> > On Wed, 2007-03-14 at 13:36 +0100, M. Koehrer wrote:
> > 
> >>Hi Philippe, 
> >>
> >>I applied again the patch to the 2.6.19.2 (adeos-ipipe-2.6.19-i386-1.6-03.patch)
> >>and also enabled the nucleus debug option.
> >>But there is no change. The system still freezes.
> >>
> > 
> > 
> > Ok, thanks. So we did no enter the twilight zone, yet.
> 
> Ok, but since I already had a case of trying to relax a kicked thread, I
> would vote for leaving the XENO_ASSERT.
> 

Ack.

-- 
Philippe.



