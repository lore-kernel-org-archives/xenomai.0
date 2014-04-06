Message-ID: <1396783490.22359.YahooMailNeo@web171604.mail.ir2.yahoo.com>
Date: Sun, 6 Apr 2014 12:24:50 +0100 (BST)
From: Matthias Schneider <ma30002000@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Race condition between threadobj_unlock and
	threadobj_free in t_resume
Reply-To: Matthias Schneider <ma30002000@yahoo.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

The following minimal program=A0=0A=0Ahttp://pastebin.com/JdnnXwsF=A0=0A=0A=
seems to lead to a race condition between=A0threadobj_unlock=A0=0Aand threa=
dobj_free as indicated by valgrind (xenomai-forge=A0=0Aand mercury):=A0=0A=
=0A=3D=3D9573=3D=3D Invalid read of size 4=0A=3D=3D9573=3D=3D    at 0x403F2=
14: threadobj_unlock (threadobj.h:407)=0A=3D=3D9573=3D=3D    by 0x403FAD2: =
put_psos_task (task.c:151)=0A=3D=3D9573=3D=3D    by 0x4040E9F: t_resume (ta=
sk.c:419)=0A=3D=3D9573=3D=3D    by 0x80486F9: main (task-2.c:20)=0A=3D=3D95=
73=3D=3D  Address 0x42a20c4 is 172 bytes inside a block of size 664 free'd=
=0A=3D=3D9573=3D=3D    at 0x4029C88: free (vg_replace_malloc.c:446)=0A=3D=
=3D9573=3D=3D    by 0x40641B6: pvfree (heapobj.h:156)=0A=3D=3D9573=3D=3D   =
 by 0x406425A: xnfree (heapobj.h:421)=0A=3D=3D9573=3D=3D    by 0x406460C: t=
hreadobj_free (threadobj.h:285)=0A=3D=3D9573=3D=3D    by 0x4068C6B: finaliz=
e_thread (threadobj.c:1239)=0A=3D=3D9573=3D=3D    by 0x40B5AE5: __nptl_deal=
locate_tsd (pthread_create.c:157)=0A=3D=3D9573=3D=3D    by 0x40B5CFE: start=
_thread (pthread_create.c:318)=0A=3D=3D9573=3D=3D    by 0x41C2C3D: clone (c=
lone.S:131)=0A=3D=3D9573=3D=3D=A0=0A=0AI am not sure on how to fix this, an=
y ideas? I do admit=A0=0Athat the use case is neither typical nor very usef=
ul on its own,=A0=0Abut it is used=A0in my test environment.=A0=0A=0AIt see=
ms that when resuming a thread that already is in=0Aits finalizer may lead =
to that thread's heap already being freed=0Awhen it is about to being unloc=
ked by the resume function.=0A=0AThanks in advance for your help,=0Aregards=
,=0AMatthias=A0

