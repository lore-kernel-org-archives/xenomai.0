MIME-Version: 1.0
From: Pedro Queiros <pqueiros@domain.hid>
Date: Wed, 3 Jun 2009 17:43:04 +0100
Message-ID: <f253850f0906030943g2a2d4474p35213e712cadba8@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] turn an rt_task back to linux user space
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,
I would like to know if the is any way to turn a xenomai task, which
was shadowed from a linux thread with the rt_task_shadow(), back to
the linux user space (kill the rt_task and continue the linux thread
execution after that).
I tried the function rt_task_delete() but it ends the rt_task and
exits the linux thread without returning to Linux user space.

Regards,

Pedro Queir=F3s
Institute of System and Robotics (ISR)
Department of Electrical and Computer Engineering
University of Coimbra, Portugal.

