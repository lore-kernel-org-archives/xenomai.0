Message-ID: <1398502711.53016.YahooMailNeo@web171601.mail.ir2.yahoo.com>
Date: Sat, 26 Apr 2014 09:58:31 +0100 (BST)
From: Matthias Schneider <ma30002000@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Issue in notifier_callback while threadobj_lock is being
	held (forge/mercury)
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

Hi all,=0A=0Awhen threadobj_lock is being held and a thread suspension trig=
gers a call of=0Anotifier_callback, I am experiencing some issues. The scen=
ario in my case=0Awas a thread being started waiting on threadobj_wait_star=
t()/wait_on_barrier()=0Awhile a thread suspension was already triggered. (I=
n case the started thread is=A0=0Aof lower priority than the starting threa=
d, threadobj_start() will not wait=0Afor it).=0A=0AThe problem I was experi=
encing (due to timing) was that threadobj_lock()=0Awas called in notifier_c=
allback(), failed because the mutex was already held=0A(by wait_on_barrier(=
)) and thus did not set the threadobj->status variable,=A0=0Ahowever, wait_=
on_barrier() had already unset the status variable before actually=A0=0Aunl=
ocking the mutex in pthread_cond_wait().=0A=0AThis caused threadobj_lock() =
in notifier_callback() return -EDEADLK and not=A0=0Adoing anything, and thr=
eadobj_unlock() to assert on __threadobj_tag_unlocked(thobj)=0Adue status n=
ot reflecting the locked state.=0A=0AAdditionally I see problems in notifie=
r_callback() in general since it will=0Aleave the threadobj unlocked on ret=
urn regardless of its previos state.=0AI am not sure how to address this is=
sue, I have helped myself by blocking=A0=0ASIGNOTIFY in wait_on_barrier(), =
but that is obviously an incomplete fix=0A(if it is any at all). Probably t=
here are other situtions as well that could=A0=0Acause this behavior.=0A=0A=
Any ideas on what to do about that?=A0=0A=0AThanks in advance,=0AMatthias

