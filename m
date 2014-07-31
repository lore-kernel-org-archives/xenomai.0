Message-ID: <53DAA390.7040406@xenomai.org>
Date: Thu, 31 Jul 2014 16:14:08 -0400
From: Jorge Ramirez Ortiz <jro@xenomai.org>
MIME-Version: 1.0
References: <mailman.653.1404749254.5713.xenomai@xenomai.org>	<53C3E6CE.2040306@xenomai.org>	<53C42ADE.7040204@gmail.com>	<53C44696.2070906@xenomai.org>	<53C44EE9.3040000@xenomai.org>	<53C6CC9B.4040009@xenomai.org>	<53C81CFD.30908@gmail.com>	<53C82A08.50100@xenomai.org>
 <CACKc53LL5C2AUTjd6cah1JyoDD5BMGeg5RQjsDjX9_FNvqdAJQ@mail.gmail.com>
In-Reply-To: <CACKc53LL5C2AUTjd6cah1JyoDD5BMGeg5RQjsDjX9_FNvqdAJQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
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

On 07/31/2014 05:22 AM, Wojciech Domski wrote:
 I prepared the driver to work well with multiple Sensoray 626 and I tested
 it with two of those. I have a problem, however.
 I suspect that the analogy interface doesn't play along with the driver but
 I'm not certain about that. Here what's happening.
 I have two s626 cards: s0 and s1. For the sake of conversation let's assume
 that analogy device analogy0 is a0 and so on.
 When I link s0 to a0, unlink, link s1 to a1, unlink everything works fine,
 however. Once more when I link s0 but this time to a1 something goes wrong.
 I get -16 error from a4l_sys_attach() which is

 No such device

 What is the reason of this happening? I do clean everything every time when
 I release s626.
 Here is what I do when I want to open my device:

 a4l_sys_open();
 a4l_sys_attach();
 a4l_open();
 rt_dev_open();
 a4l_fill_desc();

 When I close the s626 I do:

 rt_dev_close();
 a4l_close();
 a4l_sys_detach();
 a4l_sys_close();

 Best regards,
 Wojciech Domski

- ------------------

please could you send the driver and the kernel traces for the experiment?


- -- 
jro

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJT2qOQAAoJECDcy2IJkagRnH0H/3j3VgCu8KSUfOBYzC7McFxg
my+hW6i+FFNn3kpJJ2/EQtmg/pFGdenIwd/Uu8XJhwaLfT0mtP67b8GDuD/BsPGp
lVyuFeznew6gN+usGnQe48sEUCnpadlwI/ZIjcZhJqmcVzwUw991RvA32l6Z9x3/
biYv9N0QiaEpp3c0rWAApnHetsun7rFxGuzgAq2pB+adeWCOSTtOpYEado7qOrEx
FyBj8Gh1sc7kMLnyml/UXgLBvxsaSUXq81t1QwaOOZS4TQLtg/HstHMlTvqrS6k2
WsbhmS5qqmKBIKeEjWUl6d5S3TKfW+XjaY3JVFlN8p6EPS3LUl5SkxqzH/Zavfw=
=+hI6
-----END PGP SIGNATURE-----

