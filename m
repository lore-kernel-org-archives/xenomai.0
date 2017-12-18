References: <39ebca6b-d5b4-4a70-4a81-dcf11f0393e1@numalliance.com>
Mime-Version: 1.0 (1.0)
In-Reply-To: <39ebca6b-d5b4-4a70-4a81-dcf11f0393e1@numalliance.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Message-Id: <B6A0C1D5-6B71-44A8-B8E6-7648B68F4D16@qmul.ac.uk>
From: Giulio Moro <g.moro@qmul.ac.uk>
Date: Mon, 18 Dec 2017 09:55:59 +0000
Subject: Re: [Xenomai] Compilation flags to chose mercury API over cobalt
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Bastien COUNILH <bcounilh@numalliance.com>
Cc: Xenomai@xenomai.org

Passing the options returned by `xeno-config --skin=3Dposix --ldflags` to th=
e linker will automatically "wrap" the calls to most `posix_` functions (ful=
l list at /usr/xenomai/lib/posix.wrappers). When a function (e.g.: pthread_c=
reate() ) is "wrapped", then all the calls to `pthread_create()` will be rep=
laced by calls to __wrap_pthread_create(). The wrapped version is implemente=
d by xenomai. If you want to call the corresponding Linux service you can ca=
ll the equivalent `__real_` function. So in order to create a Linux thread y=
ou can call `__real_pthread_create()` in your code.
Note: you may have to declare the __real_ function(s) yourself, using the ap=
propriate function signature.

Giulio

> On 18 Dec 2017, at 09:38, Bastien COUNILH <bcounilh@numalliance.com> wrote=
:
>=20
> Hello,
>=20
> I am programming an application that runs in the secondary zone, communica=
ting with a primary zone application.
> (Briefly , in the primary zone , i do data acquisition that I write in a s=
hared memory. When i'm done writing data, i send a signal to my seondary zon=
e program through a pipe to start its data analysis).
>=20
> When it recieves the pipe signal, my function launches a series of calcula=
tion and verifications.
> As it is not necessary done in a precise sequence, i decided to run the ca=
lculcations and the verification in parallel threads. It allows to gain exec=
ution time on the heavy calculations, but also to shut the program down fast=
er if an error is returned by my data verification.
>=20
> My problem is :
> - I use the function pthread_create that is defined both in linux standard=
 library and Cobalt core. These threads have to be created in the secondary z=
one. Is there a compilation flag that will allow me to use the regular ptrhe=
ad functions ratehr than Xenomai API ones ?
>=20
>=20
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

