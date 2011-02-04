MIME-Version: 1.0
In-Reply-To: <4D4AABF4.6030804@domain.hid>
References: <AANLkTikSnhe5fnSLQm7eSOh9R7YA2cJ=m78n+S3kpW9K@mail.gmail.com>
	<4D4A84ED.7030604@domain.hid> <4D4A8BD8.1060900@domain.hid>
	<4D4A9052.2090508@domain.hid> <4D4A9118.2070602@domain.hid>
	<4D4A957B.6050907@domain.hid> <4D4A9654.80402@domain.hid>
	<4D4AA479.2020808@domain.hid> <4D4AABF4.6030804@domain.hid>
Date: Fri, 4 Feb 2011 15:33:04 +0200
Message-ID: <AANLkTimdawDBCnZon1v06F6uFf1dqwt8Re11rXPv6ZnY@mail.gmail.com>
From: Rudolf Meijering <rudolf@domain.hid>
Content-Type: multipart/alternative; boundary=90e6ba4fc1ceff0527049b74eb4c
Subject: Re: [Xenomai-help] RT OS Selection advice for parallel processing
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

--90e6ba4fc1ceff0527049b74eb4c
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Thanks a lot for everyone's input! It seems like for our application, GPU
off-loading is not the way to go. We have redesigned our system for all
processing to take place on the Intel i7. Total maximum processing latency
stays 100ms, and interrupt frequency goes up to 1.5 KHz.

I have done some research on the pro's and con's of PREEMPT_RT vs Xenomai.
As far as I can determine some of the benefits include:
1. Programming with Xenomai native API's are more elegant than POSIX
real-time API=92s.
2. Xenomai has possibly less overhead than a full preemptive kernel. The
user interface does not require RT capabilities.

Are there any other substantial benefits worth considering? Which would you
use?

Regards,

On Thu, Feb 3, 2011 at 3:21 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Jan Kiszka wrote:
> > On 2011-02-03 12:49, Gilles Chanteperdrix wrote:
> >> Jan Kiszka wrote:
> >>> On 2011-02-03 12:27, Gilles Chanteperdrix wrote:
> >>>> Jan Kiszka wrote:
> >>>>> On 2011-02-03 12:04, Gilles Chanteperdrix wrote:
> >>>>>> Jan Kiszka wrote:
> >>>>>>> [ And, personally, I don't trust the NVIDIA driver a lot. But tha=
t
> might
> >>>>>>> be influenced by the fact that latest versions lock up my noteboo=
k
> >>>>>>> regularly after resume and that I filed another obvious locking
> issue of
> >>>>>>> the compilable driver stub around mmap_sem without any response
> from the
> >>>>>>> vendor. ]
> >>>>>> Some colleague of mine is using the NVIDIA driver (through the
> opengl
> >>>>>> mapping, not CUDA/VDPAU, whatever) on high-end NVIDIA boards in a
> non RT
> >>>>>> situation. he definitely observed some huge latencies not due to
> >>>>>> scheduling issues, when uploading textures to the GPU. We are
> talking
> >>>>>> tens of milliseconds here.
> >>>>> Ugh, tens of milliseconds is heavy, more than I would expect from
> >>>>> wbinvd. OTOH, uploading textures may involve mapping the RAM that
> >>>>> contains them for the GPU. To exclude that as source, he could try
> >>>>> instrumenting CACHE_FLUSH() (in nv-linux.h).
> >>>> No, it really looks like a bug in the blob. Of course the 40ms is a
> spot
> >>>> from time to time, usually, the upload is really fast.
> >>> Unless it's a stall on the PCI bus, the blob should leaves some trace=
s
> >>> in ftrace.
> >> I am talking about the kernel-space blob. ftrance does just show that
> >> the ioctl has been submitted.
> >
> > Function tracing takes you at least into the blob wrapper, both for
> > requests issued to the blob and for its callbacks to access Linux
> > services. It looks like NVIDIA as concentrating both arch and kernel
> > specific abstractions there, not in the blob (but that's just an
> > impression).
>
> Sorry, I misunderstood ftrace, I thought strace. No, we did not try ftrac=
e.
>
> --
>                                             Gilles.
>

--90e6ba4fc1ceff0527049b74eb4c
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Thanks a lot for everyone&#39;s input! It seems like for our application, G=
PU off-loading is not the way to go. We have redesigned our system for all =
processing to take place on the Intel i7. Total maximum processing latency =
stays 100ms, and interrupt frequency goes up to 1.5 KHz.<div>
<br></div><div>I have done some research on the pro&#39;s and con&#39;s of =
PREEMPT_RT vs Xenomai. As far as I can determine some of the benefits inclu=
de:</div><div><div>1. Programming with Xenomai native API&#39;s are more el=
egant than POSIX real-time API=92s.</div>
<div>2. Xenomai has possibly less overhead than a full preemptive kernel. T=
he user interface does not require RT capabilities.</div></div><div><br></d=
iv><div>Are there any other substantial benefits worth considering? Which w=
ould you use?</div>
<div><br></div><div>Regards,</div><div><br><div class=3D"gmail_quote">On Th=
u, Feb 3, 2011 at 3:21 PM, Gilles Chanteperdrix <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org=
.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><div><div></div><div class=3D"h5">Jan Kiszk=
a wrote:<br>
&gt; On 2011-02-03 12:49, Gilles Chanteperdrix wrote:<br>
&gt;&gt; Jan Kiszka wrote:<br>
&gt;&gt;&gt; On 2011-02-03 12:27, Gilles Chanteperdrix wrote:<br>
&gt;&gt;&gt;&gt; Jan Kiszka wrote:<br>
&gt;&gt;&gt;&gt;&gt; On 2011-02-03 12:04, Gilles Chanteperdrix wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt; Jan Kiszka wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; [ And, personally, I don&#39;t trust the NVIDI=
A driver a lot. But that might<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; be influenced by the fact that latest versions=
 lock up my notebook<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; regularly after resume and that I filed anothe=
r obvious locking issue of<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; the compilable driver stub around mmap_sem wit=
hout any response from the<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; vendor. ]<br>
&gt;&gt;&gt;&gt;&gt;&gt; Some colleague of mine is using the NVIDIA driver =
(through the opengl<br>
&gt;&gt;&gt;&gt;&gt;&gt; mapping, not CUDA/VDPAU, whatever) on high-end NVI=
DIA boards in a non RT<br>
&gt;&gt;&gt;&gt;&gt;&gt; situation. he definitely observed some huge latenc=
ies not due to<br>
&gt;&gt;&gt;&gt;&gt;&gt; scheduling issues, when uploading textures to the =
GPU. We are talking<br>
&gt;&gt;&gt;&gt;&gt;&gt; tens of milliseconds here.<br>
&gt;&gt;&gt;&gt;&gt; Ugh, tens of milliseconds is heavy, more than I would =
expect from<br>
&gt;&gt;&gt;&gt;&gt; wbinvd. OTOH, uploading textures may involve mapping t=
he RAM that<br>
&gt;&gt;&gt;&gt;&gt; contains them for the GPU. To exclude that as source, =
he could try<br>
&gt;&gt;&gt;&gt;&gt; instrumenting CACHE_FLUSH() (in nv-linux.h).<br>
&gt;&gt;&gt;&gt; No, it really looks like a bug in the blob. Of course the =
40ms is a spot<br>
&gt;&gt;&gt;&gt; from time to time, usually, the upload is really fast.<br>
&gt;&gt;&gt; Unless it&#39;s a stall on the PCI bus, the blob should leaves=
 some traces<br>
&gt;&gt;&gt; in ftrace.<br>
&gt;&gt; I am talking about the kernel-space blob. ftrance does just show t=
hat<br>
&gt;&gt; the ioctl has been submitted.<br>
&gt;<br>
&gt; Function tracing takes you at least into the blob wrapper, both for<br=
>
&gt; requests issued to the blob and for its callbacks to access Linux<br>
&gt; services. It looks like NVIDIA as concentrating both arch and kernel<b=
r>
&gt; specific abstractions there, not in the blob (but that&#39;s just an<b=
r>
&gt; impression).<br>
<br>
</div></div>Sorry, I misunderstood ftrace, I thought strace. No, we did not=
 try ftrace.<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div><br></div>

--90e6ba4fc1ceff0527049b74eb4c--

