Mime-Version: 1.0 (1.0)
From: "Yogi A. Patel" <yapatel@gatech.edu>
In-Reply-To: <20141120192151.GD4545@sisyphus.hd.free.fr>
Date: Sat, 22 Nov 2014 10:18:32 -0500
Message-Id: <ED3D3EA3-E2CF-4D13-AD18-68E75705DD83@gatech.edu>
References: <C34B698C-EAE2-4FDB-806A-42534A6CBD22@gatech.edu>
 <20141120192151.GD4545@sisyphus.hd.free.fr>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

> On Nov 20, 2014, at 2:21 PM, Gilles Chanteperdrix <gilles.chanteperdrix@xe=
nomai.org> wrote:
>=20
>> On Thu, Nov 20, 2014 at 02:10:10PM -0500, Yogi A. Patel wrote:
>> Hi -
>>=20
>> I=E2=80=99m interested in using a GPU processing library (ArrayFire
>> <http://arrayfire.com/>) to run some computationally heavy models
>> in our real-time framework (data acquired->run in model->generate
>> some output via DAQ).
>>=20
>> I don=E2=80=99t know much about integrating GPU processing into the loop -=

>> and am looking for basic suggestions on the pros/cons when
>> considering hard real-time demand.
>>=20
>> Any thoughts from anyone are appreciated. Examples are also
>> appreciated!
>=20
> Using GPU shaders implies interacting with a Linux GPU driver. So,
> will get the thread using them out of primary mode. So, if you want
> to use them and keep running in primary mode, you will have to port
> GPU drivers to Xenomai RTDM skin. The problem being that a lot of
> GPU drivers are proprietary, so, porting them to RTDM will be
> difficult, I mean very difficult, if not impossible. Among the free
> ones, some drivers do not really execute the shaders on the GPU (was
> surprised by that using Cg shaders with nouveau drivers recently,
> granted, this is probably an old version of the nouveau drivers,
> since it is the Debian stable version, but this is nevertheless
> surprising). And finally a modern GPU driver is something rather
> complex, which makes it even more difficult to get it to use RTDM.
>=20
> --=20
>                        Gilles.

I understand your point about the primary mode issues with the Linux kernel b=
ased GPU drivers and needing to port them. However, the solution I was think=
ing about was to use a library called ArrayFire.=20

ArrayFire (http://arrayfire.com/) the library communicates with the GPU thro=
ugh synchronous and asynchronous function calls made on the host (CPU) side.=
=20

Would the use of such a library still cause loss of primary mode operation w=
ith the dual kernel approach?

Yogi=
