Message-ID: <f5e14e470807300222q55dce280p4635265037d4350a@domain.hid>
Date: Wed, 30 Jul 2008 11:22:15 +0200
From: "Ulrich Schwab" <uli.schwab@domain.hid>
In-Reply-To: <489026E5.1010801@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <487E1BE8.1000306@domain.hid>
	<f5e14e470807200925h3ac5d321x1a6d7629dd03fb0e@domain.hid>
	<488DD994.8020501@domain.hid> <488F2749.9010605@domain.hid>
	<f5e14e470807291515j19e7d34v3b9a1579bc10377f@domain.hid>
	<489026E5.1010801@domain.hid>
Subject: Re: [Xenomai-core] Error propagating ISR to Linux domain
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
Cc: xenomai-core <xenomai@xenomai.org>

On Wed, Jul 30, 2008 at 10:31 AM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> ...  you loose the RT response, as was (correctly) said in my first answer.
You are right, of course.
It was my error not to mention this in the original post.

For me this is just the solution to avoid the infinte loop when irqs are shared.
Until now it was always possible to avoid shared irqs (between RT and non-RT)
by changing the position of the PCI card.

Ulrich

