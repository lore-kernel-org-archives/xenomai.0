From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <69f2a808-f763-0c14-1d48-965bed9cd271@siemens.com>
Content-Type: text/plain; charset="utf-8"
Date: Fri, 11 Dec 2020 10:30:32 +0100
MIME-Version: 1.0
Message-ID: <1175-5fd33c00-129-25a5a500@199048248>
Subject: =?utf-8?q?Re=3A?==?utf-8?q?_Fwd=3A?==?utf-8?q?_=5BPatch?=
 =?utf-8?q?_1=2F5=5D?= Problems with upstream SPECTRE mitigation found in 
 =?utf-8?q?sendmsg=2Frecvmsg?= syscalls
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

Le Vendredi, D=C3=A9cembre 11, 2020 09:36 CET, Jan Kiszka <jan.kiszka@s=
iemens.com> a =C3=A9crit: 
 
> On 11.12.20 09:05, Fran=C3=A7ois Legal wrote:
> > Le Vendredi, D=C3=A9cembre 11, 2020 07:55 CET, Jan Kiszka <jan.kisz=
ka@siemens.com> a =C3=A9crit: 
> >  
> >> On 07.12.20 11:55, Fran=C3=A7ois Legal via Xenomai wrote:
> >>> From: Fran=C3=A7ois LEGAL <devel@thom.fr.eu.org>
> >>>
> >>> Remove the copy of struct struct user=5Fmsghdr onto stack allocat=
ed buffer.
> >>>
> >>
> >> Reasoning is missing here: The driver callbacks are supposed to do=
 that
> >> copy-from-user.
> >>
> >> But the Question is: why? Is that local copy history left-over, or=
 do
> >> only the drivers know how much to copy?
> >>
> >> Jan
> >>
> > 
> > Hi Jan,
> > 
> > The drivers are effectively doing that, hence the problem that happ=
ens with SPECTRE mitigation activated (at least on arm arch).
> > About the length of the copy, the drivers do about the the same, si=
zeof (struct user=5Fmsghdr)
> 
> Then we should move the common code into the common place, i.e. drop =
the
> copies in the drivers instead.
> 

I wonder, because from what I could read on RTIPC, these driver functio=
ns seems to be callable from kernel context (see rtipc=5Fget=5Farg() ).=

There is a risk of trigging SPECTRE mitigation in case is is called fro=
m kernel no, or maybe it does not get called through posix/io.c ?

Fran=C3=A7ois

> > 
> > So now about the "WHY ?", that I can't say for sure. It might be hi=
story, as the other modified parts are IPCs and RTCAN (which I believe =
are older than RTNET integration). I dug this a little bit, and what I =
can say is that in 2.6.x, in rtdm/syscall.c, the copy=5Fto/from=5Fuser =
calls were already present and in IPC, they were absent.
> > 
> 
> Yeah, for a long time, we didn't notice such mess automatically...
> 
> Jan
> 
> > Fran=C3=A7ois
> > 
> >>> Signed-off-by: Fran=C3=A7ois LEGAL <devel@thom.fr.eu.org>
> >>> ---
> >>>  kernel/cobalt/posix/io.c          | 20 ++------------------
> >>>  1 file changed, 2 insertions(+), 18 deletions(-)
> >>>  
> >>> diff --git a/kernel/cobalt/posix/io.c b/kernel/cobalt/posix/io.c
> >>> index f35aaf8..85272a5 100644
> >>> --- a/kernel/cobalt/posix/io.c
> >>> +++ b/kernel/cobalt/posix/io.c
> >>> @@ -79,18 +79,7 @@ COBALT=5FSYSCALL(write, handover,
> >>>  COBALT=5FSYSCALL(recvmsg, handover,
> >>>  	       (int fd, struct user=5Fmsghdr =5F=5Fuser *umsg, int flag=
s))
> >>>  {
> >>> -	struct user=5Fmsghdr m;
> >>> -	ssize=5Ft ret;
> >>> -
> >>> -	ret =3D cobalt=5Fcopy=5Ffrom=5Fuser(&m, umsg, sizeof(m));
> >>> -	if (ret)
> >>> -		return ret;
> >>> -
> >>> -	ret =3D rtdm=5Ffd=5Frecvmsg(fd, &m, flags);
> >>> -	if (ret < 0)
> >>> -		return ret;
> >>> -
> >>> -	return cobalt=5Fcopy=5Fto=5Fuser(umsg, &m, sizeof(*umsg)) ?: re=
t;
> >>> +	return rtdm=5Ffd=5Frecvmsg(fd, umsg, flags);
> >>>  }
> >>>  
> >>>  static int get=5Ftimespec(struct timespec *ts,
> >>> @@ -123,12 +112,7 @@ COBALT=5FSYSCALL(recvmmsg, primary,
> >>>  COBALT=5FSYSCALL(sendmsg, handover,
> >>>  	       (int fd, struct user=5Fmsghdr =5F=5Fuser *umsg, int flag=
s))
> >>>  {
> >>> -	struct user=5Fmsghdr m;
> >>> -	int ret;
> >>> -
> >>> -	ret =3D cobalt=5Fcopy=5Ffrom=5Fuser(&m, umsg, sizeof(m));
> >>> -
> >>> -	return ret ?: rtdm=5Ffd=5Fsendmsg(fd, &m, flags);
> >>> +	return rtdm=5Ffd=5Fsendmsg(fd, umsg, flags);
> >>>  }
> >>>  
> >>>  static int put=5Fmmsglen(void =5F=5Fuser **u=5Fmmsg=5Fp, const s=
truct mmsghdr *mmsg)
> >>>
> >>>
> >>
> >> -- 
> >> Siemens AG, T RDA IOT
> >> Corporate Competence Center Embedded Linux
> > 
> 
> -- 
> Siemens AG, T RDA IOT
> Corporate Competence Center Embedded Linux


