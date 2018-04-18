From: Gustav Johansson <gusjohan@kth.se>
Date: Wed, 18 Apr 2018 11:35:23 +0000
Message-ID: <1524051320838.89517@kth.se>
Content-Language: en-GB
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Scheduling timer period Xenomai RPI3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

Hi!


I'm running Xenomai on Raspberry Pi 3 given by: http://www.cs.ru.nl/lab/xen=
omai/ and I

 have some questions.


Where can I find information on how often the system timer interrupts for s=
cheduling

regarding rt tasks? When using command "dmesg | grep pipe -i" I get :



"[    0.000000] I-pipe, 19.200 MHz clocksource, wrap in 960767920505705 ms
[    0.000000] clocksource ipipe_tsc: mask: 0xffffffffffffffff max_cycles: =
0x46d987e47,

max_idle_ns: 440795202767 ns
[    0.000894] Interrupt pipeline (release #9)
[    0.171104] Switched to clocksource ipipe_tsc"


Is the frequency 19.200MHz how often the scheduler will execute?


Regards,

Gustav Johansson
