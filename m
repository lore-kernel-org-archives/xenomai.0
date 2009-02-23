Message-ID: <49A2FE68.5040508@domain.hid>
Date: Mon, 23 Feb 2009 20:52:08 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <a0ef0a9d0902230831t1f1cb440tc4bc7fdeab134fc8@domain.hid>	
	<49A2F11E.2040204@domain.hid>
	<a0ef0a9d0902231134m34399babk5d674d99c671f4e4@domain.hid>
In-Reply-To: <a0ef0a9d0902231134m34399babk5d674d99c671f4e4@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Adeos patch for arm ??
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Ghanem Lafi <lafi.ghanem@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Ghanem Lafi wrote:
> Hello Gilles,
> 
> The choice is an obligation because the vendor  of the board  offers only an
> uClinux  patch for a version 2.6.11.8...
> And they said that it is the only uClinux patch.

Please keep the discussion public.

What I meant by saying that you should focus on getting Linux running on
it is that you should adapt whatever board specific code is in this
vendor patch to the latest linux kernel release, following the linux
kernel coding standards (and not the rules followed by the vendor), then
try and get this support merged into the mainline linux by posting your
patches on the linux arm kernel mailing list. When this is done, you
will be able to apply whatever patch you want, uclinux, adeos I-pipe,
and with a minimum effort, you will even be able to follow the linux
kernel releases.

What board is this by the way? It may happen that it is in fact already
supported by the mainline kernel.

-- 
					    Gilles.

