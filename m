From: "Terry Fryar" <terry.fryar@domain.hid>
References: <32A50F80EA7447F2B43C6A65BED53790@domain.hid>
	<4EFCFE2A.8070505@domain.hid>
In-Reply-To: <4EFCFE2A.8070505@domain.hid>
Date: Mon, 2 Jan 2012 08:03:46 -0600
Message-ID: <5D50CD94D19545EDA20A7FCDFD2DEE09@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
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
To: 'Gilles Chanteperdrix' <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Thanks Gilles!

-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
Sent: Thursday, December 29, 2011 5:56 PM
To: Terry Fryar
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] Use of condition vars

On 12/29/2011 09:39 PM, Terry Fryar wrote:
> Using Xenomai 2.6.0, I have a question regarding the use of condition
> variables.  I think I understand why the mutex is required, but how to
> use it is a bit of a mystery?
>
> - To call "rt_cond_signal()", do you have to have the mutex acquired??
>
> - I assume to call "rt_cond_wait()", you are required to have the
> mutex acquired, yes??

You have to hold the mutex both for rt_cond_signal() and rt_cond_wait().
The following exercpt from linuxthreads man pages explains it:

A condition variable must always be associated with a mutex,  to  avoid the
race condition where a thread prepares to wait on a condition vari‐ able
and another thread signals the condition  just  before  the  first thread
actually waits on it.

--
                                                                Gilles.


