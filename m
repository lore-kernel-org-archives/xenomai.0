Message-ID: <b647ffbd0602160220we254aacx@domain.hid>
Date: Thu, 16 Feb 2006 12:20:23 +0200
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
In-Reply-To: <43F3C4EA.7050303@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_15653_25000749.1140085223292"
References: <b647ffbd0602150939g59256b2bx@domain.hid>
	<43F3C4EA.7050303@domain.hid>
Subject: [Xenomai-core] Re: [PATCH] Shared interrupts (ready to merge)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_15653_25000749.1140085223292
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 16/02/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:

Hmm, I still find XN_ISR_NOINT in the patch. Shouldn't we solve this
> before merging (i.e. make XN_ISR_HANDLED non-zero)?


Ok, XN_ISR_NOINT is removed in favor of XN_ISR_HANDLED which is now
non-zero.
Actually, at first I wanted to make it just the other way about.


Moreover, I attached an add-on patch to overcome the name buffer in
> xnintr_t. Note that this patch is only compile-tested, I have no native
> interrupt test-case at hand.



Heh.. someone once suggested the -p key with "diff" to me? :o)

I bet your patch would even work but it's, well, slightly broken indeed ;-)

Look at the native/syscall.c : __rt_intr_delete() :

RT_INTR *intr =3D (RT_INTR *)rt_registry_fetch(ph.opaque);
...
xnfree(intr);

"intr" actually points to intr_buf->intr and it works as expected only
because "RT_INTR intr" is the first member of the struct, so that it's
address =3D=3D the address of the whole object of this struct.

To do it properly you would need to make your "unnamed" struct visible
for both __rt_intr_create() and __rt_intr_delete(). Something like :

struct RT_INTR_ENV {

#define link2intr_env(laddr) \
((RT_INTR_ENV *)(((char* )laddr) - (int)(&((RT_INTR_ENV *)0)->intr)))

    RT_INTR intr;
    char name[XNOBJECT_NAME_LEN];
};

and then make use of link2intr_env() in __rt_intr_delet().


Ok, with you approach we would avoid allocating memory
for name[XNOBJECT_NAME_LEN] when an object is created in kernel-mode
and do it via RT_INTR_ENV only when it's created in user-mode.

We could even use that approach for all objects in native skin, but we can'=
t
because of "anonymous" objects supported in kernel-mode too and, well, I
personally would not like those RT_OBJECT_ENV structures all over the map i=
n
syscall.c :)

So I don't want to break the whole picture only for the RT_INTR object (it
doesn't support "anonymous" objects now).

Nevertheless, if you still want to save a hundred bytes of data or so (how
many interrupt objects would a normal system have? and I guess the lenght o=
f
name is about 10 symbols on average :)

for the users that don't use native skin, then I would suggest the followin=
g
way :

xnintr_t contains just the link "char *name" as you suggested but RT_INTR
contains the name[XNOBJECT_NAME_LEN] member (as it was before actually).

If it's ok,  then I'll send um... yet another final patch that addresses
both issues :)


Jan
>
>
>

--
Best regards,
Dmitry Adamushko

------=_Part_15653_25000749.1140085223292
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><div><span class=3D"gmail_quote">On 16/02/06, <b class=3D"gmail_sendern=
ame">Jan Kiszka</b> &lt;<a href=3D"mailto:jan.kiszka@domain.hid" target=3D"_bla=
nk" onclick=3D"return top.js.OpenExtLink(window,event,this)">jan.kiszka@domain.hid=
.de</a>
&gt; wrote:<br>
<br>
</span><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rg=
b(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hmm, I sti=
ll find XN_ISR_NOINT in the patch. Shouldn't we solve this<br>before mergin=
g (
i.e. make XN_ISR_HANDLED non-zero)?
</blockquote><div><br>
Ok, XN_ISR_NOINT is removed in favor of XN_ISR_HANDLED which is now non-zer=
o.<br>
Actually, at first I wanted to make it just the other way about.<br>
&nbsp;</div><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px=
 solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">M=
oreover, I attached an add-on patch to overcome the name buffer in<br>xnint=
r_t. Note that this patch is only compile-tested, I have no native
<br>interrupt test-case at hand.</blockquote><div><br>
<br>
Heh.. someone once suggested the -p key with &quot;diff&quot; to me? :o)<br=
>
<br>
I bet your patch would even work but it's, well, slightly broken indeed ;-)=
<br>
<br>
Look at the native/syscall.c : __rt_intr_delete() :<br>
<br>
RT_INTR *intr =3D (RT_INTR *)rt_registry_fetch(ph.opaque);<br>
...<br>
xnfree(intr);<br>
<br>
&quot;intr&quot; actually points to intr_buf-&gt;intr and it works as expec=
ted only<br>
because &quot;RT_INTR intr&quot; is the first member of the struct, so that=
 it's<br>
address =3D=3D the address of the whole object of this struct.<br>
<br>
To do it properly you would need to make your &quot;unnamed&quot; struct vi=
sible<br>
for both __rt_intr_create() and __rt_intr_delete(). Something like :<br>
<br>
struct RT_INTR_ENV {<br>
<br>
#define link2intr_env(laddr) \<br>
((RT_INTR_ENV *)(((char* )laddr) - (int)(&amp;((RT_INTR_ENV *)0)-&gt;intr))=
)<br>
<br>
&nbsp;&nbsp;&nbsp; RT_INTR intr;<br>
&nbsp;&nbsp;&nbsp; char name[XNOBJECT_NAME_LEN];<br>
};<br>
<br>
and then make use of link2intr_env() in __rt_intr_delet().<br>
<br>
<br>
Ok, with you approach we would avoid allocating memory<br>
for name[XNOBJECT_NAME_LEN] when an object is created in kernel-mode<br>
and do it via RT_INTR_ENV only when it's created in user-mode.<br>
<br>
We could even use that approach for all objects in native skin, but we can'=
t<br>
because of &quot;anonymous&quot; objects supported in kernel-mode too and, =
well,
I personally would not like those RT_OBJECT_ENV structures all over the
map in syscall.c :)<br>
<br>
So I don't want to break the whole picture only for the RT_INTR object (it =
doesn't support &quot;anonymous&quot; objects now).<br>
<br>
Nevertheless, if you still want to save a hundred bytes of data or so
(how many interrupt objects would a normal system have? and I guess the
lenght of name is about 10 symbols on average :)<br>
<br>
for the users that don't use native skin, then I would suggest the followin=
g way :<br>
<br>
xnintr_t contains just the link &quot;char *name&quot; as you suggested but
RT_INTR contains the name[XNOBJECT_NAME_LEN] member (as it was before
actually).<br>
<br>
If it's ok,&nbsp;  then I'll send um... yet another final patch that addres=
ses both issues :)<br>
<br>
</div><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid=
 rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Jan<br>=
<br><br></blockquote></div><br><br>-- <br>Best regards,<br>Dmitry Adamushko


------=_Part_15653_25000749.1140085223292--

