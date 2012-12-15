Message-ID: <50CC6607.6080506@xenomai.org>
Date: Sat, 15 Dec 2012 12:59:03 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50C9FCAE.7020507@ucv.cl>
In-Reply-To: <50C9FCAE.7020507@ucv.cl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Question about Xenomai,  Posix and Java
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?SMOpY3RvciBWYXJnYXM=?= <hector.vargas@ucv.cl>
Cc: xenomai@xenomai.org

On 12/13/2012 05:05 PM, H=C3=A9ctor Vargas wrote:

> Hi everyone,
>=20
> I want to create an application where a control task (real time control=
=20
> of a DC motor) developed in Xenomai (posix skin) can be controlled from=
=20
> a Java interface (GUI). The idea is to create a middle task between the=
=20
> xenomai control task and the Java application working as a gateway by=20
> using TCP sockets. Before starting to work on it I would like to know i=
f=20
> someone has already done something like this. It is possible to do it?.=



I do not see why it would not work (RTnet has everything needed AFAIK).
But why not invoking the Xenomai code from the Java code as JNI ?

--=20
                                                                Gilles.


