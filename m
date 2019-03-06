From: Lange Norbert <norbert.lange@andritz.com>
Subject: Posix skin and Mutex initialisation/destruction inconsistencies
Date: Wed, 6 Mar 2019 09:39:48 +0000
Message-ID: <0e040cd1aa3b4df6ba3c61eb6c1a4adf@andritz.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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

1)
There is an inconsistency with the documentation [1], which claims that mut=
ex and condition variables
need to be explicitly initialized with the *_init functions.
The implementation however checks the state via a flag and calls *_init if =
necessary, and the program below works correctly.

2)
There is some further issue, if you depend on the "lazy initialization", de=
monstrated by running the
program below with an argument. This case can happen for example if some su=
bsystem was removed
before being used (never needed the lock).
In other words, the "lazy initialization" scheme is working with lock/unloc=
k but not with destroy.


#include <assert.h>
#include <pthread.h>

int main(int argc, char const *argv[]) {
        pthread_mutex_t mymutex =3D PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP=
;

  if (argc =3D=3D 1) {
    assert(0 =3D=3D pthread_mutex_lock(&mymutex));
    assert(0 =3D=3D pthread_mutex_unlock(&mymutex));
  }
  assert(0 =3D=3D pthread_mutex_destroy(&mymutex));

  return 0;
}

[1] - https://gitlab.denx.de/Xenomai/xenomai/wikis/Porting_To_Xenomai_POSIX

Regards, Norbert
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


Rechtsform/ Legal form: Gesellschaft mit beschr=C3=A4nkter Haftung / Corpor=
ation

Firmensitz/ Registered seat: Wien

Firmenbuchgericht/ Court of registry: Handelsgericht Wien

Firmenbuchnummer/ Company registration: FN 61833 g

DVR: 0605077

UID-Nr.: ATU14756806


Thank You
________________________________

