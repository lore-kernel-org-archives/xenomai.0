MIME-Version: 1.0
In-Reply-To: <542AF7CF.1090600@xenomai.org>
References: <CABVE6k1dDnGUBQSRCDCAcgbnY-eFP422WCwTzZWQPKiD997E-w@mail.gmail.com>
 <2193EAD1-45DF-4E12-8FFD-34AC726315E9@mah.priv.at>
 <CABVE6k1OG+SyDBJuUzJfS8sXi3PO8E2VuHcF6HF126A7j-yLYg@mail.gmail.com>
 <542A97C7.8000701@xenomai.org>
 <CABVE6k2L1Rh5R0E7L6TPFJ8ri7yFX02HGaRR+7WYSReZM9xKFQ@mail.gmail.com>
 <542AC724.5010406@xenomai.org>
 <CABVE6k3PZFRCvvSK+=ZKoU6MPdCZHT0E_4h7WqPzACBLSd-Udg@mail.gmail.com>
 <542ADE09.2020008@xenomai.org>
 <CABVE6k22eS8PXUKHRhAy3wTtbMqFrA7Vy+AyjUT9ipqAmLwckQ@mail.gmail.com>
 <542AF7CF.1090600@xenomai.org>
From: =?UTF-8?Q?Hasret_Sar=C4=B1yer?= <hsrtsryr@gmail.com>
Date: Tue, 30 Sep 2014 23:23:29 +0300
Message-ID: <CABVE6k33e1SAa4J0QL5p4Z3vs5DZDhH9zQ4ZxX6+1pPodsd4iw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Xenomai: binding failed: Operation not permitted.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <Xenomai@xenomai.org>

2014-09-30 21:34 GMT+03:00 Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org>:

> On 09/30/2014 08:29 PM, Hasret Sar=C4=B1yer wrote:
> > 2014-09-30 19:44 GMT+03:00 Gilles Chanteperdrix <
> > gilles.chanteperdrix@xenomai.org>:
> >
> >> On 09/30/2014 06:11 PM, Hasret Sar=C4=B1yer wrote:
> >>> 2014-09-30 18:07 GMT+03:00 Gilles Chanteperdrix <
> >>> gilles.chanteperdrix@xenomai.org>:
> >>>
> >>>> On 09/30/2014 04:56 PM, Hasret Sar=C4=B1yer wrote:
> >>>>> I did all step on this guide
> >>>>> <http://xenomai.org/2014/06/building-debian-packages/>. And I
> expexted
> >>>> that
> >>>>> xenomai was ready to use.
> >>>>
> >>>> Xenomai should be ready to use, the latency test is a utility part o=
f
> >>>> xenomai using xenomai, so running it as root will tell you if xenoma=
i
> is
> >>>> ready or if you still have other issues (actually, most issues with
> >>>> beginner are kernel configuration issues).
> >>>
> >>>
> >>> I run "xeno-test" and the output is below
> >>
> >> Ok. Xenomai seems to be working on your system, and you seem not to
> >> have any pathological latency issues.
> >>
> >> Note that since latency output is plain text, you could have pasted it
> >> in the mail body.
> >>
> >> So, your last problem now, if you want to run programs as a user and
> >> not as root, is to follow:
> >>
> http://xenomai.org/2014/06/running-a-xenomai-application-as-a-regular-use=
r/
> >
> >
> > ok. But I am not clear some points.To compile,the necessary modules are
> > added in makefile.
> >
> > What should I do to add to the kernel? I did using "modprobe", but it
> > didn't work.
> >
>
> It depends on how you configured the kernel. As indicated in the
> documentation, if you configured xenomai to be built-in, there is no
> xeno_nucleus module, so you have to pass the xeno_nucleus.xenomai_gid
> parameter to the kernel.
>
> As indicated in the documentation, you can also use sysfs.
>
>
> --
>                                                                 Gilles.
>


I tried three ways(as root or not), but they didn't.
