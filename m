Message-ID: <4EFCFE2A.8070505@domain.hid>
Date: Fri, 30 Dec 2011 00:56:26 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <32A50F80EA7447F2B43C6A65BED53790@domain.hid>
In-Reply-To: <32A50F80EA7447F2B43C6A65BED53790@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Use of condition vars
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Terry Fryar <terry.fryar@domain.hid>
Cc: xenomai@xenomai.org

On 12/29/2011 09:39 PM, Terry Fryar wrote:
> Using Xenomai 2.6.0, I have a question regarding the use of condition
> variables.  I think I understand why the mutex is required, but how to =
use
> it is a bit of a mystery?
> =20
> - To call "rt_cond_signal()", do you have to have the mutex acquired??
> =20
> - I assume to call "rt_cond_wait()", you are required to have the mutex=

> acquired, yes??

You have to hold the mutex both for rt_cond_signal() and rt_cond_wait().
The following exercpt from linuxthreads man pages explains it:

A condition variable must always be associated with a mutex,  to  avoid
the race condition where a thread prepares to wait on a condition vari=E2=
=80=90
able and another thread signals the condition  just  before  the  first
thread actually waits on it.

--=20
                                                                Gilles.


