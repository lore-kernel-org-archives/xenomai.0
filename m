MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18487.8166.661738.910852@domain.hid>
Date: Fri, 23 May 2008 21:49:58 +0200
In-Reply-To: <d6c8ef150805231248k794c5338y2277756df03c289a@domain.hid>
References: <d6c8ef150805231056n3a9ea030jada65bd5a7c2a2c0@domain.hid>
	<18487.5656.377471.470581@domain.hid>
	<d6c8ef150805231234m7c65aec5l5fa15c028ce96249@domain.hid>
	<18487.7736.634161.816552@domain.hid>
	<d6c8ef150805231248k794c5338y2277756df03c289a@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] Interrupt priorities and handling problems
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bosko Radivojevic <bosko.radivojevic@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Bosko Radivojevic wrote:
 > On Fri, May 23, 2008 at 9:42 PM, Gilles Chanteperdrix
 > <gilles.chanteperdrix@xenomai.org> wrote:
 > 
 > > Then what I have said is irrelevant, your interrupt handler is fully
 > > preemptible by Xenomai.
 > 
 > Great :)
 > 
 > > How are they disabled ? If they are disabled using Linux functions, then
 > > they are really enabled for Adeos, that is one of the intended effects
 > > of the Adeos patch.
 > 
 > OK, I missed that fact. So, why do I see latency than, at all?

Only the tracer can tell.

-- 


					    Gilles.

