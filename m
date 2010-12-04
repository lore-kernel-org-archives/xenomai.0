MIME-Version: 1.0
Date: Sat, 4 Dec 2010 16:26:43 +0100
Message-ID: <AANLkTik4jAA-7k=py3Gj0xdPptza=Vk6ndDazTku=iBJ@mail.gmail.com>
From: krzyma krzyma <krzyma8bit@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] Freeze after rt_sem_broadcast
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,
I have a simple program which only has to start some tasks. I wanted
to start the tasks with rt_sem_broadcast. The problem is when I have
more than ~50 tasks, then the system just freezes and nothing works
(keyboard). and I need to restart it hardly. I figured out that the
problem exists only with rt_sem_broadcast, without it the number of
tasks is not the problem. I have Xenomai 2.4.4 on Fedora 3 (2.6.25.11)
with all the xenomai debug  and watchdog options enabled.

Thanks,
Krzysztof

