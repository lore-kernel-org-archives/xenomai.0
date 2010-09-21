MIME-Version: 1.0
Sender: madjsw@domain.hid
In-Reply-To: <4C98C4DF.6070904@domain.hid>
References: <AANLkTikF63jMSnD-XDq_KvApr1EZoGPLP6rFG7HcwpPC@mail.gmail.com>
	<AANLkTinhmyo1AFvPzHXZ12ochSOpMHLj9qwEfQ8GCc5L@mail.gmail.com>
	<4C98C4DF.6070904@domain.hid>
Date: Tue, 21 Sep 2010 11:08:22 -0500
Message-ID: <AANLkTimRZmbDchvfe8OcknedwVT22VCARtp7-K9byqm3@domain.hid>
From: Jeff Weber <jwamsc@domain.hid>
Content-Type: multipart/alternative; boundary=0016e6d388cff21a990490c73cfb
Subject: Re: [Xenomai-help] Fwd: isolate realtime and Linux by CPU on SMP
	system
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

--0016e6d388cff21a990490c73cfb
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Sep 21, 2010 at 9:44 AM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Jeff Weber wrote:
> > What is the best method for segregating Xenomai and Linux by CPU?  I was
> > unable to do this cleanly using /proc/xenomai/affinity for Xenomai,
> > together with the Linux isolcpus boot option.  Details below.
>
> I have no definite answer, I have not checked. What I suspect, however,
> is that when you try and force an affinity for a Xenomai thread, it
> tries and apply this affinity in secondary mode, i.e. as a plain Linux
> thread. So, will fail if the target thread is not in the "isolcpus"
> mask. In other words, a Xenomai thread can not run on a CPU where Linux
> threads can not run.
>
> Is there a means to startup the Linux init process, with the constraint of
only running on a given CPU, and have this property inherited by all
children Linux processes?

If true, then I am hopeful I can place all Xenomai primary mode threads on
the other CPU using /proc/xenomai/affinity .

Jeff

--0016e6d388cff21a990490c73cfb
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 21, 2010 at 9:44 AM, Gilles Chanteperdrix <span dir=3D"ltr">&lt=
;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org=
enomai.org</a>&gt;</span> wrote:<br><div class=3D"gmail_quote"><blockquote =
class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); m=
argin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class=3D"im">Jeff Weber wrote:<br>
&gt; What is the best method for segregating Xenomai and Linux by CPU? =A0I=
 was<br>
&gt; unable to do this cleanly using /proc/xenomai/affinity for Xenomai,<br=
>
&gt; together with the Linux isolcpus boot option. =A0Details below.<br>
<br>
</div>I have no definite answer, I have not checked. What I suspect, howeve=
r,<br>
is that when you try and force an affinity for a Xenomai thread, it<br>
tries and apply this affinity in secondary mode, i.e. as a plain Linux<br>
thread. So, will fail if the target thread is not in the &quot;isolcpus&quo=
t;<br>
mask. In other words, a Xenomai thread can not run on a CPU where Linux<br>
threads can not run.<br>
<br></blockquote></div>Is there a means to startup the Linux init process, =
with the constraint of only running on a given CPU, and have this property =
inherited by all children Linux processes?<br><br>If true, then I am hopefu=
l I can place all Xenomai primary mode threads on the other CPU using /proc=
/xenomai/affinity .<br>
<br>Jeff<br>

--0016e6d388cff21a990490c73cfb--

