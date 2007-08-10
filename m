Message-ID: <2ff1a98a0708100728s499c1139n39b4c7c2437fae7a@domain.hid>
Date: Fri, 10 Aug 2007 16:28:44 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <000c01c7db59$181f8680$c124a986@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <000c01c7db59$181f8680$c124a986@domain.hid>
Subject: Re: [Xenomai-help] POSIX Skin: Changing scheduling parameters of
	threads in other processes
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?Torsten_Kr=F6ger?= <t.kroeger@domain.hid>
Cc: xenomai@xenomai.org

On 8/10/07, Torsten Kr=F6ger <t.kroeger@domain.hid> wrote:
> Hi everyone,
>
> to summarize my discussion form yesterday:
>
> 1. I would like to implement 'real' synchronous message passing using
> the posix skin. 'Real' synchronous message passing shall mean that a
> receiver _always_ inherits the priority of the sender. Right now, I
> think this is not possible. Please let me know, if anyone knows a
> possibility.

We could add a new flag to posix message queues attributes to have
such a priority inheritance. Of course, this would be a non portable
extension.


--=20
                                               Gilles Chanteperdrix

