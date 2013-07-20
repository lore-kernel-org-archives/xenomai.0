Message-ID: <51EA4243.4020904@web.de>
Date: Sat, 20 Jul 2013 09:54:43 +0200
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <C83BFA2D-B71C-4494-B6F8-931A2F0EE44E@imag.fr>
In-Reply-To: <C83BFA2D-B71C-4494-B6F8-931A2F0EE44E@imag.fr>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] shielding fully CPU or CORE
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Skander Bahloul <skander.bahloul@imag.fr>
Cc: xenomai@xenomai.org

On 2013-07-19 11:17, Skander Bahloul wrote:
> Dear Xenomai list members,
> =

> On a successful instal (but without NVIDIA driver, cf my previous message=
), I am now starting using Xenomai.
> =

> We need to :
> 1* shield fully a CPU or core, against the scheduler, interruption, etc
> 2* run a single thread on this isolated CPU or core
> =

> Step 2 is OK with the Xenomai API.
> But how should I achieve step 1 ?
> =

> I did not find advice in the Xenomai documentation.
> I guess it should be done with :
> 	$ sudo shield -a 0-3 -m -1
> =

> Do you agree ?
> When may I find detailed info on CPU shielding ?

With "shield fully", do you mean 99,9...% or true 100%? The latter is
not possible with current Linux kernels, thus also not with Xenomai. For
the former, try kernel parameter isocpus (to keep Linux off certain
cores), possibly in combination with xeno_hal.rthal_supported_cpus (to
limit Xenomai to those cores).

True CPU domination is possible via virtualization, e.g. I'm working on
such a solution. But you will not get a Linux process environment for
your RT task, rather a set of bare-metal CPU cores you will have to boot
up yourself. Also, a lot of noise comes from other shared resources
(besides the CPU core itself), like memory and specifically the links to
the I/O devices (PCI bridges/buses...). So no miracle to expect that way
as well, at least on x86.

Jan

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130720/83b0855=
b/attachment.pgp>
