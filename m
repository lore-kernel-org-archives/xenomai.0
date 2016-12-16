Message-ID: <0E43CD10656442C39F51CAC025EB22BA@itd206>
From: "Sureshvs" <sureshvs@datapatterns.co.in>
Date: Fri, 16 Dec 2016 18:25:40 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Reg:xenomai 3 rtdm_sem_down behaviour
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: sureshvsmca@gmail.com

Hi
ARCH=3DpowerPC
Processor: MPC8641
Linux Kernel : 3.10.32
Xenomai  version: 3.0.3
ipipe :ipipe-core-3.10.32-powerpc-9.patch
Installatio: Cobalt

We are using rtdm synchronisation service(semaphore) in our driver module f=
or synchronizing the interrupt event from driver with userspace ioctl call.

 rtdm_sem_down is  unblocking.(i.e)very first time without posting the rtdm=
_sem_up event.(we have not enabled the interrupt)

subsequent rtdm_sem_down is blocking and unblocking on every rtdm_sem_up ev=
ents.

RTDM_WAIT:
similarly rtdm_wait call is unblocking very first time.


Kindly provide the suggestion and solution as soon as possible.


Regards
Suresh=20

**************** CAUTION - Disclaimer *****************This email may conta=
in confidential and privileged material for the
sole use of the intended recipient(s). Any review, use, retention, distribu=
tion or disclosure by others is strictly prohibited. If you are not the int=
ended recipient (or authorized to receive for the recipient), please contac=
t the sender by reply email and delete all copies of this message. Also, em=
ail is susceptible to data corruption, interception, tampering, unauthorize=
d amendment and viruses. We only send and receive emails on the basis that =
we are not liable for any such corruption, interception, tampering, amendme=
nt or viruses or any consequence thereof.=20
*********** End of Disclaimer ***********DataPatterns ITS Group**********

