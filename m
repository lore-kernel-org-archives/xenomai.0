Message-ID: <48F6195C.7070801@domain.hid>
Date: Wed, 15 Oct 2008 18:25:00 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] rt_task_info.status encoding
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hi,

the documentation refers to the Native Task Status (T_*) when it comes
to documenting rt_task_info.status. That is not correct. That field
contains far more flags than T_* is describing and, even worse, comes
with two collisions: T_PRIMARY and T_JOINABLE are not reported by
rt_task_inquire, rather T_RELAX (!T_PRIMARY, arrrg...) and T_HELD.

I see two ways out of this:

 a) Redirect the documentation to the nucleus thread state flags.

 b) Redefine the numerical values of T_PRIMARY and T_JOINABLE (the spare
    bits are unused with the native skin), add missing but possibly
    interesting flags as T_-constants and ensure that T_PRIMARY and
    T_JOINABLE are correctly injected on rt_task_inquire from user
    space.

Somehow I tend to prefer a)...

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

