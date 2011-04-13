MIME-Version: 1.0
Sender: madjsw@domain.hid
Date: Wed, 13 Apr 2011 10:59:22 -0500
Message-ID: <BANLkTi=fp61zxZyg=gGt4moNNw_hLa8_og@domain.hid>
From: Jeff Weber <jwamsc@domain.hid>
Content-Type: multipart/alternative; boundary=000e0ce0b4927277d104a0cee424
Subject: [Xenomai-help] avoiding page faults
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--000e0ce0b4927277d104a0cee424
Content-Type: text/plain; charset=ISO-8859-1

I wish to avoid unwanted transitions of POSIX pthreads to secondary mode due
to page faults.

Does calling
mlockall(MCL_CURRENT | MCL_FUTURE)

lock pages when the memory is allocated, or referenced?

>From reviewing Xenomai, Linux RT_PREEMPT, and RTAI code, it appears the
answer is that memory is locked when the page is "referenced" (not
allocated), and that referencing by write is preferred over referencing by
read.  xeno_fault_stack() appears to pre-fault a subset of the stack when
turning the calling thread into a Xenomai thread.

If true, then I should allocate my own stack for each pthread created in my
program, and write every page ahead of time, then
call pthread_attr_setstack() prior to thread creation.  I should also write
every page of every dynamically allocated memory object.

Please help me verify if this understanding is correct.

thanks,
Jeff

--000e0ce0b4927277d104a0cee424
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>I wish to avoid unwanted transitions of POSIX pthreads to secondary mo=
de due to page faults.</div><div><br></div><div>Does calling</div><div>mloc=
kall(MCL_CURRENT | MCL_FUTURE)</div><div><br></div><div>lock pages when the=
 memory is allocated, or referenced?</div>
<div><br></div><div>From reviewing Xenomai, Linux RT_PREEMPT, and RTAI code=
, it appears the answer is that memory is locked when the page is &quot;ref=
erenced&quot; (not allocated), and that referencing by write is preferred o=
ver referencing by read. =A0xeno_fault_stack() appears to pre-fault a subse=
t of the stack when turning the calling thread into a Xenomai thread.=A0</d=
iv>
<div><br></div><div>If true, then I should allocate my own stack for each p=
thread created in my program, and write every page ahead of time, then call=
=A0pthread_attr_setstack() prior to thread creation. =A0I should also write=
 every page of every dynamically allocated memory object.</div>
<div><br></div><div>Please help me verify if this understanding is correct.=
</div><div><br></div><div>thanks,</div><div>Jeff</div><div><br></div>

--000e0ce0b4927277d104a0cee424--

