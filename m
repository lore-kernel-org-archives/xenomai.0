Message-ID: <54232226.1060509@xenomai.org>
Date: Wed, 24 Sep 2014 15:57:26 -0400
From: Jorge Ramirez Ortiz <jro@xenomai.org>
MIME-Version: 1.0
References: <mailman.653.1404749254.5713.xenomai@xenomai.org>	<53C3E6CE.2040306@xenomai.org>	<53C42ADE.7040204@gmail.com>	<53C44696.2070906@xenomai.org>	<53C44EE9.3040000@xenomai.org>	<53C6CC9B.4040009@xenomai.org>	<53C81CFD.30908@gmail.com>	<53C82A08.50100@xenomai.org>	<CACKc53LL5C2AUTjd6cah1JyoDD5BMGeg5RQjsDjX9_FNvqdAJQ@mail.gmail.com>	<53DAA390.7040406@xenomai.org>	<CACKc53LQ5pCL14tVodDbMjyexPoYcaLi-PFzFOGT=VNGhR6FpQ@mail.gmail.com>	<53DBA8D7.9040505@xenomai.org>	<CACKc53+jJ9tq-5oHN65V5o-tTU5L67ZiwKQ5eyFW0C=4HRyYqA@mail.gmail.com>	<CACKc53KpB1=-HciLvY-E_u4FDO72LGBSwtSV19G_h5_iT8e-LQ@mail.gmail.com>	<53E96D0E.7060505@xenomai.org>	<53EE6E07.7090104@xenomai.org>
 <CACKc53Jm2ZkEfuP9Y=Zf9kOB_uKyQiWAhWCX25iuW0KG4ZDScw@mail.gmail.com>
In-Reply-To: <CACKc53Jm2ZkEfuP9Y=Zf9kOB_uKyQiWAhWCX25iuW0KG4ZDScw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] sensoray 626 patch [Re: Xenomai Digest, Vol 27,
	Issue 12]
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wojciech Domski <wojciech.domski@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 09/09/2014 05:31 AM, Wojciech Domski wrote:
> Dear Jorge,
> 
> Yes, this fix solved the problem. Now, everything works just fine. Please
> find attached a Sensoray 626 driver. It is cleaned and tested to work with
> two cards. There shouldn't be any problem with more cards support.
> However, I would like to ask you for a favour. Is it possible for you to
> put this patch to Xenomai 2 tree ?

looking into this now.

> 
> Also as you could notice before I've written a piece of API for using the
> Sensoray 626 card. Is is possible to add this also to Xenomai but to
> example section or something similar, of course?
> 
> Best regards,
> Wojciech Domski
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJUIyImAAoJECDcy2IJkagRGVMH/RnY/4dsH4wt2zQ4pfXvCOB2
b4IWIhaBksfjzziHP7PPuL+mjRiitowhq6NWnxzJMm8+04hckOOJtooNV4KZyG95
OGdE0E+NzcXiuB8SCGlTQc3rNUHynlOBB1s8z+8qN69CN6y3FrqvXjKID/Z03lJI
vf7RNHFx+svVH0PG7EC3jHW3hH4VKSzgNkhpTSmHfnMeEG0YYJea0rR/QUuh0EKN
wvz6NaFlovn/YPo8/kqYbn5IirhBVkKrgb1ZyCnlmFEkzPlVoFZBnmIU9npWs++5
pOMCVhenp7kXoAdaScH0/Wkx3XVki38otWOwoK4VOFGBM29mEouF3q+a6MckYTU=
=p3Qe
-----END PGP SIGNATURE-----

