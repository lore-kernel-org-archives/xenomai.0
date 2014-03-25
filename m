Message-ID: <53316C4C.6000708@sigmatek.at>
Date: Tue, 25 Mar 2014 12:45:16 +0100
From: Erwin Pranz <erwin.pranz@sigmatek.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Rescnt imbalance in rtdm_mutex_timedlock
Reply-To: erwin.pranz@sigmatek.at
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I am using rtdm_mutex_lock/rtdm_mutex_unlock in a rtdm driver and I get=20
a signal SIGDEBUG_MIGRATE_PRIOINV when I call the driver from a=20
priority-0 thread.The signal is sent in xnsynch_release_thread when=20
rescnt is 0 on a XNOTHER thread, which means that rescnt is not balanced.

I think the reason why rescnt is not balanced is in=20
rtdm_mutex_timedlock: when the owner of the mutex is NULL, the owner is=20
changed to the calling thread, but rescnt is not increased.

I suggest the following fix in rtdm_mutex_timedlock:
-       else if (likely(xnsynch_owner(&mutex->synch_base) =3D=3D NULL))
+       else if (likely(xnsynch_owner(&mutex->synch_base) =3D=3D NULL)) {
                 xnsynch_set_owner(&mutex->synch_base, curr_thread);
+               if (xnthread_test_state(curr_thread, XNOTHER))
+                       xnthread_inc_rescnt(curr_thread);
+       }

Best regards,

--=20
Erwin Pranz
Software
________________________________

SIGMATEK GmbH & Co KG
Sigmatekstra=DFe 1
5112 Lamprechtshausen =D6sterreich / Austria

Tel.:  +43/6274/4321-0
Fax:  +43/6274/4321-18
E-Mail: erwin.pranz@sigmatek.at
http://www.sigmatek-automation.com


