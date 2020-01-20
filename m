From: Lange Norbert <norbert.lange@andritz.com>
Subject: Cobalt deadlock for no apparent reason
Date: Mon, 20 Jan 2020 18:03:41 +0000
Message-ID: <VI1PR05MB5917D1906A1A32505BFE5168F6320@VI1PR05MB5917.eurprd05.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

Hello,

I got a deadlock while running through gdbserver, this is an implementation=
 of a synchronized queue,
Fup side waits via condition variable, main wants to push data, but main fa=
ils to acquire the mutex.
The mutex is an errorchecking type, without priority inheritance, and not u=
sed elsewhere.


The task are as following:

CPU  PID    CLASS  TYPE      PRI   TIMEOUT       STAT       NAME
  1  1686   rt     cobalt      4   -             Wt         main
  3  1690   rt     cobalt      2   -             Wt         fup.medium

main is stuck in this function

int mutex_lock(struct mutex_data *pData)
{
    pthread_t threadId =3D pthread_self();
    // assert(pthread_equal(threadId, pData->m_LockId) =3D=3D 0);
->    int r =3D pthread_mutex_lock(&pData->m_Mutex);
    assert(r =3D=3D 0);
    pData->m_LockId =3D threadId;
    return r;
}

In libcobalt:
  do
    ret =3D XENOMAI_SYSCALL1(sc_cobalt_mutex_lock, _mutex);
  while (ret =3D=3D -EINTR);

fup.medium is stuck in:

int conditionvar_wait(struct conditionvar_data *pData, struct mutex_data *p=
Mutex)
{
    pthread_t sid =3D pthread_self();
    assert(pthread_equal(sid, pMutex->m_LockId) !=3D 0);
    pMutex->m_LockId =3D 0;
->    int r =3D pthread_cond_wait(&pData->m_CondVar, &pMutex->m_Mutex);
    assert(r =3D=3D 0);
    pMutex->m_LockId =3D sid;
    return r;
}

In libcobalt:
  while (err =3D=3D -EINTR)
    err =3D XENOMAI_SYSCALL2(sc_cobalt_cond_wait_epilogue, _cnd, _mx);

Mit besten Gr=FC=DFen / Kind regards

NORBERT LANGE

AT-RD3

ANDRITZ HYDRO GmbH
Eibesbrunnergasse 20
1120 Vienna / AUSTRIA
p: +43 50805 56684
norbert.lange@andritz.com<mailto:norbert.lange@andritz.com>
andritz.com<http://www.andritz.com/>

________________________________

This message and any attachments are solely for the use of the intended rec=
ipients. They may contain privileged and/or confidential information or oth=
er information protected from disclosure. If you are not an intended recipi=
ent, you are hereby notified that you received this email in error and that=
 any review, dissemination, distribution or copying of this email and any a=
ttachment is strictly prohibited. If you have received this email in error,=
 please contact the sender and delete the message and any attachment from y=
our system.

ANDRITZ HYDRO GmbH


Rechtsform/ Legal form: Gesellschaft mit beschr=E4nkter Haftung / Corporati=
on

Firmensitz/ Registered seat: Wien

Firmenbuchgericht/ Court of registry: Handelsgericht Wien

Firmenbuchnummer/ Company registration: FN 61833 g

DVR: 0605077

UID-Nr.: ATU14756806


Thank You
________________________________
