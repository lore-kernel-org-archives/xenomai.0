From: <mario_molitor@web.de>
References: <trinity-a65a3ea0-cae5-4f13-9fdf-bda26c1616ab-1562590950171@3c-app-webde-bs07>
 <3f76a1b5-24eb-6efb-d8d2-3de10554c7ed@siemens.com>
In-Reply-To: <3f76a1b5-24eb-6efb-d8d2-3de10554c7ed@siemens.com>
Subject: AW: use of posix function clock_gettime
Date: Wed, 10 Jul 2019 22:42:09 +0200
Message-ID: <000101d5375f$f221cd60$d6656820$@web.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: de
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: 'Jan Kiszka' <jan.kiszka@siemens.com>, xenomai@xenomai.org

> First of all, all in-kernel APIs have been deprecated and removed in =
favor of RTDM driver APIs. However, RTDM does not expose this clock =
directly. You can only do rtdm_clock_read (realtime) or =
rtdm_clock_read_monotonic().

This was also my recognising after reading the code and the information =
was not really new. Anyway in meantime I have found a workaround/ =
solution for our problem.

>We could add a host_realtime API to RTDM if there is a good use case. =
And that would include a reason why the timestamp adjustment (monotonic =
-> host-realtime) cannot be done in the userspace application that =
consumes the driver data.

>From my point of view make this always sense if a measurement value =
needs an accurate Timestamp by the creating. The other applications =
which could need this are fieldbus application.=20
Our measurement system gets her measurement value in the Kernel-Space in =
a Xenomia-IRQ and in this case was the old Functionality very smart.=20
A new Functionality RTDM_ host_realtime would be close this gap and =
would by also make the RTDM Clock-service completely.

Mario

HBK



