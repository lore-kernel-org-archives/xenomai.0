MIME-Version: 1.0
In-Reply-To: <507E0569.5040101@xenomai.org>
References: <CAFNBftfgRC66N1JBEj5-e+ya4s5-RUqzeXsNs_iK6BTFrLmJ=w@mail.gmail.com>
	<507E0569.5040101@xenomai.org>
Date: Wed, 17 Oct 2012 23:04:47 -0300
Message-ID: <CAFNBfteFL4Za8Va7PEd1dawWb3g1EqpdNSdhDjA9HkFDEpc8Aw@mail.gmail.com>
From: Flavio Castro Alves Filho <flavio.alves@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Latency tests - iMX53qsb
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

I'm trying to build using the instruction from Xenomai package
(rel_imx_3.0.15_12.03.00) and I'm facing some issues.

The kernel does not compile when I turn off 'CPU Frequency Scaling' option.

I use imx5_defconfig from the standard kernel config files.

When I let 'CPU Frequency Scaling' on, with Xenomai, I have the
message on Xenomai configuration options, but the build run with
success.

Do I have to lel this option on?

Thank you very much.

Best regards,

Flavio

2012/10/16 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
> On 10/17/2012 01:35 AM, Flavio Castro Alves Filho wrote:
>
>> Linux version 2.6.35.3-11.09.01+yocto-gd86aa36-svn795-dirty
>
>
> Please use something more recent than Linux 2.6.35, Linux 2.6.35 dates
> back from 2010, imx53 is supported with Xenomai for Linux versions later
> than 2.6.38, at least.
>
> --
>                                                                 Gilles.



-- 
Flavio de Castro Alves Filho

flavio.alves@gmail.com
www.linuxembarcado.com
Twitter: http://twitter.com/#!/fraviofii
LinkedIn profile: www.linkedin.com/in/flaviocastroalves

