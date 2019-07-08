MIME-Version: 1.0
Message-ID: <trinity-a65a3ea0-cae5-4f13-9fdf-bda26c1616ab-1562590950171@3c-app-webde-bs07>
From: "Mario Molitor" <Mario_Molitor@web.de>
Subject: use of posix function clock_gettime
Content-Type: text/plain; charset=UTF-8
Date: Mon, 8 Jul 2019 15:02:30 +0200
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello  Xenomai-Community,

we are seeming to have a migration problem by our internal synchronization=
 kernel-module.

The module try to get timestamp of Host-Real-Time-Clock in Real-Time IRQ c=
ontext.
In the old version of XENOMAI (2.6.5) it was possible to use XENOMAI POSIX=
 function directly (clock_gettime(CLOCK_HOST_REALTIME,tp)) in the kernel m=
odule.

But with XENOMAI version 3.0.7 is this not possible and I haven't found an=
y good workaround in the moment.

We use Xenomai in combination with kernel 4.14.71.

Every hint or suggestion are welcome.

Thanks,
Mario

