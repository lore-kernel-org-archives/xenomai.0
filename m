Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
From: "Yogi A. Patel" <yapatel@gatech.edu>
In-Reply-To: <20141122164224.GO6931@sisyphus.hd.free.fr>
Date: Sun, 23 Nov 2014 11:17:44 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <9D034F52-BEA4-41E5-B9D3-7CFF49F669EB@gatech.edu>
References: <C34B698C-EAE2-4FDB-806A-42534A6CBD22@gatech.edu>
 <20141120192151.GD4545@sisyphus.hd.free.fr>
 <ED3D3EA3-E2CF-4D13-AD18-68E75705DD83@gatech.edu>
 <20141122164224.GO6931@sisyphus.hd.free.fr>
Subject: Re: [Xenomai] GPU Processing Question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>


> On Nov 22, 2014, at 11:42, Gilles Chanteperdrix =
<gilles.chanteperdrix@xenomai.org> wrote:
>=20
> On Sat, Nov 22, 2014 at 10:18:32AM -0500, Yogi A. Patel wrote:
>> I understand your point about the primary mode issues with the Linux =
kernel based GPU drivers and needing to port them. However, the solution =
I was thinking about was to use a library called ArrayFire.=20
>>=20
>> ArrayFire (http://arrayfire.com/) the library communicates with the =
GPU through synchronous and asynchronous function calls made on the host =
(CPU) side.=20
>=20
> I do not think a library which accesses GPU registers from
> user-space is even possible:
> - the GPU registers are kind of a trade secret, sure NVIDIA released
> some documentations, but I believe it is for some old GPUs, not the
> latest ones, sure there is nouveau, but I do not think they got all
> the registers covered;=20
> - since the GPU registers are shared with the graphic driver, which
> handles what is displayed on your screen, you have obvious
> concurrence issues, and doing this would result in a risk of
> breaking what is displayed on the screen by the OpenGL pipeline, and
> a risk of the graphic drivers breaking what you are doing. You need
> a centralized arbiter to all that, and the driver is that
> centralized arbiter. If it had been possible to do everything from
> user-space, I believe NVIDIA would have done it instead of
> implementing their controversial driver.
>=20
> Extracted from ArrayFire README.md
>=20
> ArrayFire's multiple backends (CUDA, OpenCL and native CPU) make it
> platform independent and highly portable.
>=20
> The native CPU port probably does not use the GPU, and CUDA and
> OpenCL are probably based on libraries which interact with GPU
> drivers.

Thanks, Gilles.

I spoke to the company that makes that library and they said that which =
registers are used by the CUDA application is left up to the nvidia =
compiler. In addition, there are scientific GPUs that are separate from =
the GPUs for the graphics pipeline.

I am having a hard time finding compelling data for/against trying this =
out so I may just give it a whirl and see what I find.
=20
I know that Xenomai 3 has a tool for profiling when an app jumps out of =
primary mode. Is there an easy way to do that with v2.6.x?

Thanks for all the info.

Yogi=

