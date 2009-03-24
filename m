MIME-Version: 1.0
In-Reply-To: <49C7899F.5030306@domain.hid>
References: <b131c9f0903230100x1b2aa2fet9e2b0efe68a7a77f@domain.hid>
	<49C7899F.5030306@domain.hid>
Date: Tue, 24 Mar 2009 09:37:21 +0200
Message-ID: <b131c9f0903240037q446193f5hbfdd3ade40ea2af4@domain.hid>
From: vikesh rambaran <vikesh.rambaran@domain.hid>
Content-Type: multipart/alternative; boundary=00221532c5b417241e0465d874e8
Subject: Re: [Xenomai-help] Xenomai LTTng support
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

--00221532c5b417241e0465d874e8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Thanx for the all feedback Jan and Andreas !

On Mon, Mar 23, 2009 at 3:07 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:

>
> > However, I am having trouble with the following and would appreciate help
> >
> > a) "git clone git://git.kiszka.org/ipipe-2.6.git lttng/2.6.28-x86"
> > as per the email, results in the 2.6.29-rc6. What should the command be
> > to access the 2.6.28 tree ?
>
> Additionally try "git checkout lttng/2.6.28-x86".
>

Ok, should have done some homework before asking that question :)
Worked through the fundamentals of the git usermanual. Fancy VCS !

For newbies to git (like me), the complete command i had to issue on the
cloned repository to
get the lttng branch was :

git checkout -b v2.6.28-x86 origin/lttng/2.6.28-x86



> >
> > Note : downloading ipipe-2.6.28.7-x86-2.2-06 from
> >
> http://git.kiszka.org/?p=ipipe-2.6.git;a=commit;h=7abbb32f691345126d96cb6b48c587e145b8ef20
> > using the web interface gives the 2.6.28.7 tree. Is this ok to use ?
> >
> > b) The LTTng manual mentions that there should be a kernel option
> > Linux Trace Toolkit Next Generation (LTTng) under General settings. This
> > seems to be
> > unavailable for both the above trees. What must be done to enable this
> > feature ?
>
> It will be available in the git branch that contains LTTng.
>

Yes, see it now !


>
> >
> > c) Applying the xenomai instrumentation patch from
> > [http://permalink.gmane.org/gmane.linux.real-time.xenomai.devel/6009]
>  to
> > the xenomai 2.4.7
> > tree using patch -p1 < "filename",  results in numerous hunks. What am i
> > doing wrong ?
>
> Hmm, I'm afraid the patch has to be back-ported manually. It was
> developed against the instrumentation points in trunk, 2.4.x looks a bit
> different (but you should be able to derive the adoption pattern from
> that patch).


Ok , will do so and post the updated diff

Thanx
Vicki

--00221532c5b417241e0465d874e8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanx for the all feedback Jan and Andreas !<br><br><div class=3D"gmail_quo=
te">On Mon, Mar 23, 2009 at 3:07 PM, Jan Kiszka <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:jan.kiszka@domain.hid" target=3D"_blank">jan.kiszka@domain.hid=
om</a>&gt;</span> wrote:<br>
<br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(2=
04, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div>&gt;<br>
&gt; However, I am having trouble with the following and would appreciate h=
elp<br>
&gt;<br>
&gt; a) &quot;git clone git://<a href=3D"http://git.kiszka.org/ipipe-2.6.gi=
t" target=3D"_blank">git.kiszka.org/ipipe-2.6.git</a> lttng/2.6.28-x86&quot=
;<br>
&gt; as per the email, results in the 2.6.29-rc6. What should the command b=
e<br>
&gt; to access the 2.6.28 tree ?<br>
<br>
</div>Additionally try &quot;git checkout lttng/2.6.28-x86&quot;.<br>
<div></div></blockquote><div><br>Ok, should have done some homework before =
asking that question :)<br>Worked through the fundamentals of the git userm=
anual. Fancy VCS !<br><br>For newbies to git (like me), the complete comman=
d i had to issue on the cloned repository to <br>
get the lttng branch was :<br><br>git checkout -b v2.6.28-x86 origin/lttng/=
2.6.28-x86<br><br><br></div><blockquote class=3D"gmail_quote" style=3D"bord=
er-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-l=
eft: 1ex;">
<div><br>
&gt;<br>
&gt; Note : downloading ipipe-2.6.28.7-x86-2.2-06 from<br>
&gt; <a href=3D"http://git.kiszka.org/?p=3Dipipe-2.6.git;a=3Dcommit;h=3D7ab=
bb32f691345126d96cb6b48c587e145b8ef20" target=3D"_blank">http://git.kiszka.=
org/?p=3Dipipe-2.6.git;a=3Dcommit;h=3D7abbb32f691345126d96cb6b48c587e145b8e=
f20</a><br>


&gt; using the web interface gives the 2.6.28.7 tree. Is this ok to use ?<b=
r>
&gt;<br>
&gt; b) The LTTng manual mentions that there should be a kernel option<br>
&gt; Linux Trace Toolkit Next Generation (LTTng) under General settings. Th=
is<br>
&gt; seems to be<br>
&gt; unavailable for both the above trees. What must be done to enable this=
<br>
&gt; feature ?<br>
<br>
</div>It will be available in the git branch that contains LTTng.<br>
<div></div></blockquote><div><br>Yes, see it now !<br>=A0<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204=
); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div><br>
&gt;<br>
&gt; c) Applying the xenomai instrumentation patch from<br>
&gt; [<a href=3D"http://permalink.gmane.org/gmane.linux.real-time.xenomai.d=
evel/6009" target=3D"_blank">http://permalink.gmane.org/gmane.linux.real-ti=
me.xenomai.devel/6009</a>] =A0to<br>
&gt; the xenomai 2.4.7<br>
&gt; tree using patch -p1 &lt; &quot;filename&quot;, =A0results in numerous=
 hunks. What am i<br>
&gt; doing wrong ?<br>
<br>
</div>Hmm, I&#39;m afraid the patch has to be back-ported manually. It was<=
br>
developed against the instrumentation points in trunk, 2.4.x looks a bit<br=
>
different (but you should be able to derive the adoption pattern from<br>
that patch).</blockquote><div>=A0</div><div>Ok , will do so and post the up=
dated diff<br><br>Thanx<br></div></div>Vicki<br>

--00221532c5b417241e0465d874e8--

