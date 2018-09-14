From: Giulio Moro <g.moro@qmul.ac.uk>
Date: Fri, 14 Sep 2018 12:19:35 +0000
Message-ID: <VI1PR0701MB212671005AEF3217529DF3F2B5190@VI1PR0701MB2126.eurprd07.prod.outlook.com>
References: <a327adca-1576-0794-71cd-409b366dfdc8@alaxarxa.net>
 <28fd59c00f574c5a987ff73d72ffbc4c@andritz.com>
 <4078e730-9293-12b4-e3c2-843f0de5f637@alaxarxa.net>,
 <c69b760a81bb4d3ab0bc78f3d4502b5f@andritz.com>
In-Reply-To: <c69b760a81bb4d3ab0bc78f3d4502b5f@andritz.com>
Content-Language: en-GB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Order options to build a Xenomai program
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lange Norbert <norbert.lange@andritz.com>, Leopold Palomo-Avellaneda <leo@alaxarxa.net>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

> So, from my point of view it confirm my suspicious that the wrapper
> mechanism is fragile. I really didn't understand why Xenomai core team
> changed the native API for the POSIX. Although I saw the Jan Kiska
> conference video explaining it, tell me primitive or dump, but I prefer t=
o have
> a RT API that links against RT libraries and you can mix the POSIX functi=
ons
> that you want in a clear way.
>
> OTOH I have to admit that convert a POSIX program to RT in an easy way is
> amazing.

I normally disable wrappers and call explicitly the `__wrap_` equivalent wh=
en I want to use a Xenomai function , that is for instance `__wrap_pthread_=
create()` instead of `pthread_create()`.
I also add my own forward declaration, e.g.:

int __wrap_pthread_create(pthread_t *thread, const pthread_attr_t *attr, vo=
id *(*start_routine) (void *), void *arg);

But maybe this is already provided in some of the Cobalt headers.=

