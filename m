Message-ID: <44C3CF5C.3010806@domain.hid>
Date: Sun, 23 Jul 2006 21:34:52 +0200
From: Hannes Mayer <h.mayer@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] rt_intr_create returns ENOSYS ?
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

Hi all!

Subject basically says it.

I'm trying to do this:
err = rt_intr_create(&intr_desc, "parint", PARPORTINT, I_PROPAGATE);
in main() before spawning an RT tasks, but it fails with ENOSYS.
Xeno2.2, 2.4.32

Any enlightenment very much appreciated!

Thanks a lot,
Hannes.


