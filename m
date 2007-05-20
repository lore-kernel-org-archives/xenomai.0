From: Paul <paul_c@domain.hid>
Date: Sun, 20 May 2007 11:18:30 +0100
References: <46180AB8.3000905@domain.hid> <200704072306.46154.paul_c@domain.hid>
	<4618A2BF.1030104@domain.hid>
In-Reply-To: <4618A2BF.1030104@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200705201118.30019.paul_c@domain.hid>
Subject: Re: [Xenomai-help] Xenomai Live CD
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Theo Veenker <Theo.Veenker@domain.hid>
Cc: xenomai@xenomai.org


Hi Theo

On Sunday 08 April 2007 09:07, Theo Veenker wrote:
> > [Side note: I already do nightly Sarge based Morphix modules, so slipping
> > in a Xenomai version once in a while is possible].

> Would be nice. I'm very interested in having a (small) live cd which I can
> customize and give to my clients.

Finally got round to setting up an Etch based build system for the Morphix 
project[1] so am now in a position to look again at a minimal live CD. An 
assortment of kernel packages were compiled overnight for various CPU 
flavours (586, 686, k7, & k8) and the initial base ISO boots without any 
problem under qemu.

 Aside from the core Xenomai tools and libraries, what are the main packages 
you require - We have a blank canvas here, so just about anything can be 
added.


Regards, Paul.


[1] http://www.morphix.org

