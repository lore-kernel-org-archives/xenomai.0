From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Subject: Re: [Xenomai-help] FPU not available in user-space programs
Date: Thu, 6 Jul 2006 13:45:25 -0300
References: <44AC8482.6000902@domain.hid>
	<17580.62726.293737.991643@domain.hid>
In-Reply-To: <17580.62726.293737.991643@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200607061345.25400.lbocseg@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Thank you Gilles and Jan,

Jan, I had taken a look at that thread just after I created this thread.

Well, at least, now I know this fault is expected and is not an error.

Do I need to make a dummy float-point operation in primary mode for avoidin=
g=20
unexpected higher latency for enabling FPU in critical code?

Thank you for your support. I must enforce that this list has the best supp=
ort=20
I've seen. I posted a question on Doxygen's user list a few days ago and ju=
st=20
one user answered to it, but not really solved what I was asking...

By the way, does someone here know how can I put comment code on=20
documentation, as in:
/*! ...
   \code /* this is a comment */ \endcode */

Of course this won't compile. The user suggests to put the above code insid=
e a=20
#ifdef __COMMENT__ and define it on Doxyfile, but that makes the code seem =

ugly in kdevelop, besides causing a compiler warning:

warning: "/*" within comment


Is there a cleaner way to make possible to put comments inside the @code=20
command?

I hope you can help me once more this time... ;)

Thanks,

Rodrigo.

____________________________________________________________
Em Quinta 06 Julho 2006 08:33, Gilles Chanteperdrix escreveu:

>Rodrigo Rosenfeld Rosas wrote:
> > Hi,
> >
> > I was looking at /proc/xenomai/faults and noticed that the only errors
> > were on TRAP 7 (FPU not available).
> >
> > Each time I run the user-space program using the native skin, I
> > increment the fault by one. I don't understand why this happens. From
> > documentation, FPU should be enabled automatically for user-space
> > programs.
> >
> > Any ideas why I'm getting this error and what does it mean? Should I do
> > some float-point operation before creating my real-time tasks?
>
>This fault is not an error, it happens when a task use the FPU for the
>first time in primary mode. When in secondary mode, such an FPU fault
>happens every time the FPU is used after a context switch, you simply do
>not know about it because it is not accounted for.

=09

=09
	=09
_______________________________________________________=20
Voc=EA quer respostas para suas perguntas? Ou voc=EA sabe muito e quer comp=
artilhar seu conhecimento? Experimente o Yahoo! Respostas !
http://br.answers.yahoo.com/


