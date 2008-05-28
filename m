Message-ID: <2ff1a98a0805280527ye76a5ai8bde80a4f29dc27f@domain.hid>
Date: Wed, 28 May 2008 14:27:31 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <d6c8ef150805280314n40da461dgb411a85827bb73c@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d6c8ef150805231056n3a9ea030jada65bd5a7c2a2c0@domain.hid>
	<2ff1a98a0805261014o5900fc40i61332fdb19a8ea08@domain.hid>
	<d6c8ef150805261016q7250012cxcb0f15aa8ae817fd@domain.hid>
	<2ff1a98a0805261021s1d369a23ic63451e9b87b68b6@domain.hid>
	<d6c8ef150805261047y660c853fwb398d344d8b3b540@domain.hid>
	<d6c8ef150805270431j24e99d94n1bdd56ada3eb5ff9@domain.hid>
	<2ff1a98a0805270511m1b337537pe8b66d29b494c20b@domain.hid>
	<d6c8ef150805270608g40c15b64w6b4ebb448c33d3a9@domain.hid>
	<d6c8ef150805280216h163bb7ei91894411c3aa7885@domain.hid>
	<d6c8ef150805280314n40da461dgb411a85827bb73c@domain.hid>
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

On Wed, May 28, 2008 at 12:14 PM, Bosko Radivojevic
<bosko.radivojevic@domain.hid> wrote:
> Hi,
>
> I hope this is the last mail in this thread :) In order to use IRQ1
> line, IRQ no. 30 should be requested. What get me in wrong way is
> that, when I tried first time to request IRQ 30 instead of 111 (PC15),
> everything hung. Actually, before requesting irq it is mandatory to
> set interrupt source type to anything except LOW LEVEL.
>
> Actually, I can still see a small jitter with heavy Ethernet activity,
> but it seems acceptable.

That's good news.

-- 
 Gilles

