MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18103.2297.602539.889750@domain.hid>
Date: Mon, 6 Aug 2007 13:41:45 +0200
In-Reply-To: <2ff1a98a0708060208k1d217ae6ge20389074d9bf1bd@domain.hid>
References: <46B1A842.1090708@domain.hid>
	<1186049556.6611.319.camel@domain.hid>
	<46B1B7DE.3080404@domain.hid>
	<1186053839.6611.326.camel@domain.hid>
	<46B2E1B3.2020102@domain.hid>
	<2ff1a98a0708060208k1d217ae6ge20389074d9bf1bd@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] Unexpected switch to secondary mode
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Johan Borkhuis <j.borkhuis@domain.hid>, rpm@xenomai.org, Xenomai-help@domain.hid

Gilles Chanteperdrix wrote:
 > On 8/3/07, Johan Borkhuis <j.borkhuis@domain.hid> wrote:
 > > Philippe,
 > >
 > > (BTW: is this something that should be discussed in the Xenomai group,
 > > or would it be better to move this discussion to the Adeos mailing list?)
 > >
 > > I do have question on this. We already discussed this problem earlier,
 > > and I managed to find a very dirty work around for my application: I
 > > added a lot of "dummy" functions to my application, which are spread
 > > over the whole application. By calling these after the mlockall, but
 > > before I switch to RT-mode I manage to eliminate most of the switches.
 > 
 > Before implementing the nocow patch, I opened /proc/self/maps and
 > caused a fault on every writable page, even if ugly, this looks
 > simpler than spreading dummy functions over the whole application.

I posted the piece of code here:
https://mail.gna.org/public/xenomai-help/2006-12/msg00168.html

-- 


					    Gilles Chanteperdrix.

