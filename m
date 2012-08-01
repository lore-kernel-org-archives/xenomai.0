Message-ID: <501966CD.5070609@xenomai.org>
Date: Wed, 01 Aug 2012 19:26:37 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CACKGRaU=LSM8HYOQAeZvLzGuMPsn+juQKrEHCZbfz=hZOKP_sg@mail.gmail.com>	<4FE5A583.2010401@xenomai.org>	<CACKGRaV9REKp-+xdZjqCXV3ACPYwDDfjLP02vB3o_B-bOO_shw@mail.gmail.com>	<4FE5A825.7090704@xenomai.org>
	<CACKGRaUm19XKtoYiCi3sqnULhqT0rOhED4rud_6HCg0New1dLg@mail.gmail.com>
In-Reply-To: <CACKGRaUm19XKtoYiCi3sqnULhqT0rOhED4rud_6HCg0New1dLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] How to fix error "incompatible ABI revision levels on
 Ubuntu Linux 3.6.38 on ARM?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: aungkyas@gmail.com
Cc: xenomai@xenomai.org

On 06/26/2012 03:50 PM, AKS wrote:
> Hi Gilles and Xenomai-ers
> 
> I have downloaded the Xenomai-2.6 the latest one, prepared the kernel
> and built the kernel. The kernel works as it can be loaded. Next, I have
> installed xenomai-runtime but I can install only the xenomai-run-time
> version numbered 2.5.5.2 - both Ubuntu Natty (11.04) and Precise (12.04)
> have the same 2.5.5.2
> 
> I wonder from where I can apt-get install the xenomai-runtime 2.6.0.x to
> match my kernel. I am trying to avoid xcompiling Xenomai. Pls advise.
> Thanks!

I would not know about that. We do not provide ubuntu packages here. We
provide a source package, with even a debian directory allowing to
compile it as a Debian package, and a tutorial:

http://www.xenomai.org/index.php/Building_Debian_packages

Explaining how to do it.

So, I do not see what more you expect from us.

-- 
					    Gilles.

