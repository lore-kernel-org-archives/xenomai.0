MIME-Version: 1.0
In-Reply-To: <5169EC2C.4000101@xenomai.org>
References: <CAPpP=rPQa-Fa+1j7Lb11dUX8srkinCQQ2yS2gR5y9f9Pqf1jdg@mail.gmail.com>
	<516998B7.9090901@xenomai.org>
	<CAPpP=rOEjuy8w0x-_zRv_7vHDOmjU6n1Hi=jrE6UNEULL=zYcQ@mail.gmail.com>
	<5169C63B.1070406@xenomai.org>
	<CAPpP=rMOmOkd2Gwswu685zsPhxJDMj7GnRWA0yU+gRHmz=V2bw@mail.gmail.com>
	<5169EC2C.4000101@xenomai.org>
Date: Mon, 15 Apr 2013 10:47:25 +0200
Message-ID: <CAPpP=rNCBdcussSRzHN_Vpjj0afWZRGKRqPXxh7ps2-_GP7nBQ@mail.gmail.com>
From: alex alex <duch.alexandre@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] [QUESTION] thread creation and hook function
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

>There are simple ways in the application itself, you do not need a
>kernel module and a switch hook.

The reason I use a switch hook is to retrieve informations about context
switches to produce a Gantt chart of the sechuleur. But maybe hook
functions are
not suitable for this? Anyway, I'll try to use the tracer with the latest
version of xenomai to try to understand what is happening.

Thank you very much for your replies and advice.


Alex.





2013/4/14 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> On 04/14/2013 12:41 AM, alex alex wrote:
>
> > linux kernel : 3.2.21
> > xenomai version : 2.6.2.1
> > arch: x86
>
>
> BTW, Xenomai is broken on 3.2.21, so moving to 3.4 or 3.5 is recommended.
>
>
> --
>                                                                 Gilles.
>
