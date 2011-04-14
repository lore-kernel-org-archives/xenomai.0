MIME-Version: 1.0
Sender: madjsw@domain.hid
In-Reply-To: <4DA6E5FB.1050204@domain.hid>
References: <BANLkTi=fp61zxZyg=gGt4moNNw_hLa8_og@domain.hid>
	<4DA6E5FB.1050204@domain.hid>
Date: Thu, 14 Apr 2011 09:44:04 -0500
Message-ID: <BANLkTikdg1X_Ua0WR2k-KpCJO6iePSxVCA@mail.gmail.com>
From: Jeff Weber <jwamsc@domain.hid>
Content-Type: multipart/alternative; boundary=000e0ce0b492fcd39304a0e1f46b
Subject: Re: [Xenomai-help] avoiding page faults
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
Cc: xenomai@xenomai.org

--000e0ce0b492fcd39304a0e1f46b
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Apr 14, 2011 at 7:18 AM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Jeff Weber wrote:
> > I wish to avoid unwanted transitions of POSIX pthreads to secondary mode
> due
> > to page faults.
> >
> > Does calling
> > mlockall(MCL_CURRENT | MCL_FUTURE)
> >
> > lock pages when the memory is allocated, or referenced?
> >
> > From reviewing Xenomai, Linux RT_PREEMPT, and RTAI code, it appears the
> > answer is that memory is locked when the page is "referenced" (not
> > allocated), and that referencing by write is preferred over referencing
> by
> > read.  xeno_fault_stack() appears to pre-fault a subset of the stack when
> > turning the calling thread into a Xenomai thread.
> >
> > If true, then I should allocate my own stack for each pthread created in
> my
> > program, and write every page ahead of time, then
> > call pthread_attr_setstack() prior to thread creation.  I should also
> write
> > every page of every dynamically allocated memory object.
> >
> > Please help me verify if this understanding is correct.
>
> mlockall(MCL_CURRENT) locks all the memory currently mapped.
> mlockall(MCL_FUTURE) will lock all the memory when it is allocated/mapped.
>
> Here's an strace of my pthread library starting up a thread, which will
become a Xenomai posix thread:
...
25210 mlockall(MCL_CURRENT|MCL_FUTURE)  = 0
25210 open("/dev/null", O_RDWR)         = 3
25210 open("/dev/null", O_RDWR)         = 4
25210 sched_get_priority_max(SCHED_FIFO) = 99
25210 sched_get_priority_min(SCHED_FIFO) = 1
25210 sched_get_priority_max(SCHED_FIFO) = 99
25210 mmap2(NULL, 8392704, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS|MAP_S
TACK, -1, 0) = 0xb6dd7000
25210 mprotect(0xb6dd7000, 4096, PROT_NONE) = 0
25210 clone(child_stack=0xb75d7474,
flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SI
GHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CL
EARTID, parent_tidptr=0xb75d7bd8, {entry_number:6, base_addr:0xb75d7b70,
limit:1
048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1,
seg_not_pre
sent:0, useable:1}, child_tidptr=0xb75d7bd8) = 25212
...

The child thread stack is allocated/mapped by the mmap2() call above, in the
parent thread.  Since mlock(MCL_FUTURE) was called prior, the child stack
should be completely locked into parent memory.  However, it is not clear if
the stack memory locks are lost in the new child thread across the
clone().  The mlock() man page says these are definitely lost across a
fork().  The clone() CLONE_VM flag indicates the the parent and child thread
share the same memory mappings. I'm not a Linux virtual memory wizard.  Does
this also imply parent memory locks are inherited by a cloned child?

My mlock() man page has this:
       Real-time processes that are using mlockall() to prevent delays on
page
       faults should reserve enough locked stack  pages  before  entering
 the
       time-critical  section, so that no page fault can be caused by
function
       calls.  This can be achieved by calling a  function  that  allocates
 a
       sufficiently large automatic variable (an array) and writes to the
mem-
       ory occupied by this array in order to touch these stack  pages.
This
       way,  enough  pages will be mapped for the stack and can be locked
into
       RAM.  The dummy writes ensure that not even copy-on-write  page
 faults
       can occur in the critical section.

So does calling mlockall(MCL_FUTURE) early in the parent permanently lock
memory for all subsequent threads, or do I need to touch all pages in all
child threads to guarantee they are locked?

My architecture is x86 32-bit.

TIA,
Jeff

--000e0ce0b492fcd39304a0e1f46b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Thu, Apr 14, 2011 at 7:18 AM, Gilles =
Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@=
xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex;">
<div><div></div><div class=3D"h5">Jeff Weber wrote:<br>
&gt; I wish to avoid unwanted transitions of POSIX pthreads to secondary mo=
de due<br>
&gt; to page faults.<br>
&gt;<br>
&gt; Does calling<br>
&gt; mlockall(MCL_CURRENT | MCL_FUTURE)<br>
&gt;<br>
&gt; lock pages when the memory is allocated, or referenced?<br>
&gt;<br>
&gt; From reviewing Xenomai, Linux RT_PREEMPT, and RTAI code, it appears th=
e<br>
&gt; answer is that memory is locked when the page is &quot;referenced&quot=
; (not<br>
&gt; allocated), and that referencing by write is preferred over referencin=
g by<br>
&gt; read. =A0xeno_fault_stack() appears to pre-fault a subset of the stack=
 when<br>
&gt; turning the calling thread into a Xenomai thread.<br>
&gt;<br>
&gt; If true, then I should allocate my own stack for each pthread created =
in my<br>
&gt; program, and write every page ahead of time, then<br>
&gt; call pthread_attr_setstack() prior to thread creation. =A0I should als=
o write<br>
&gt; every page of every dynamically allocated memory object.<br>
&gt;<br>
&gt; Please help me verify if this understanding is correct.<br>
<br>
</div></div>mlockall(MCL_CURRENT) locks all the memory currently mapped.<br=
>
mlockall(MCL_FUTURE) will lock all the memory when it is allocated/mapped.<=
br>
<br></blockquote><div>Here&#39;s an strace of my pthread library starting u=
p a thread, which will become a Xenomai posix thread:</div><div>...</div><d=
iv>25210 mlockall(MCL_CURRENT|MCL_FUTURE) =A0=3D 0</div><div>25210 open(&qu=
ot;/dev/null&quot;, O_RDWR) =A0 =A0 =A0 =A0 =3D 3</div>
<div>25210 open(&quot;/dev/null&quot;, O_RDWR) =A0 =A0 =A0 =A0 =3D 4</div><=
div>25210 sched_get_priority_max(SCHED_FIFO) =3D 99</div><div>25210 sched_g=
et_priority_min(SCHED_FIFO) =3D 1</div><div>25210 sched_get_priority_max(SC=
HED_FIFO) =3D 99</div>
<div>25210 mmap2(NULL, 8392704, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONY=
MOUS|MAP_S</div><div>TACK, -1, 0) =3D 0xb6dd7000</div><div>25210 mprotect(0=
xb6dd7000, 4096, PROT_NONE) =3D 0</div><div>25210 clone(child_stack=3D0xb75=
d7474, flags=3DCLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SI</div>
<div>GHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLON=
E_CHILD_CL</div><div>EARTID, parent_tidptr=3D0xb75d7bd8, {entry_number:6, b=
ase_addr:0xb75d7b70, limit:1</div><div>048575, seg_32bit:1, contents:0, rea=
d_exec_only:0, limit_in_pages:1, seg_not_pre</div>
<div>sent:0, useable:1}, child_tidptr=3D0xb75d7bd8) =3D 25212</div><div>...=
</div><div><br></div><div>The child thread stack is allocated/mapped by the=
 mmap2() call above, in the parent thread. =A0Since mlock(MCL_FUTURE) was c=
alled prior, the child stack should be completely locked into parent memory=
. =A0However, it is not clear if the stack memory locks are lost in the new=
 child thread across the clone().=A0=A0The mlock() man page says these are =
definitely lost across a fork(). =A0The clone() CLONE_VM flag indicates the=
 the parent and child thread share the same memory mappings. I&#39;m not a =
Linux virtual memory wizard. =A0Does this also imply parent memory locks ar=
e inherited by a cloned child?=A0</div>
<div><br></div><div>My mlock() man page has this:</div><div><div>=A0=A0 =A0=
 =A0 Real-time processes that are using mlockall() to prevent delays on pag=
e</div><div>=A0=A0 =A0 =A0 faults should reserve enough locked stack =A0pag=
es =A0before =A0entering =A0the</div>
<div>=A0=A0 =A0 =A0 time-critical =A0section, so that no page fault can be =
caused by function</div><div>=A0=A0 =A0 =A0 calls. =A0This can be achieved =
by calling a =A0function =A0that =A0allocates =A0a</div><div>=A0=A0 =A0 =A0=
 sufficiently large automatic variable (an array) and writes to the mem-</d=
iv>
<div>=A0=A0 =A0 =A0 ory occupied by this array in order to touch these stac=
k =A0pages. =A0 This</div><div>=A0=A0 =A0 =A0 way, =A0enough =A0pages will =
be mapped for the stack and can be locked into</div><div>=A0=A0 =A0 =A0 RAM=
. =A0The dummy writes ensure that not even copy-on-write =A0page =A0faults<=
/div>
<div>=A0=A0 =A0 =A0 can occur in the critical section.</div></div><div><br>=
</div><div>So does calling=A0mlockall(MCL_FUTURE) early in the parent perma=
nently lock memory for all subsequent threads, or do I need to touch all pa=
ges in all child threads to guarantee they are locked?</div>
<div><br></div><div>My architecture is x86 32-bit.</div><div><br></div><div=
>TIA,</div><div>Jeff</div><div><br></div><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></div>

--000e0ce0b492fcd39304a0e1f46b--

