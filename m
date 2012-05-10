MIME-Version: 1.0
Date: Thu, 10 May 2012 16:26:49 +0200
Message-ID: <CANKLDmvnyqTJ-0poJHYWDtsrkrVdwsYGpw0uR3vfvJZg+hDYtQ@mail.gmail.com>
From: Henri Roosen <henriroosen@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] Does qemu-kvm impact realtime performance?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

Hi all,

Does anyone know if running qemu-kvm impacts the realtime Xenomai
performance of the host system?

I have a multicore x86 target that runs a Xenomai enabled kernel and a
realtime application. Next to the realtime application I would like to
run qemu-kvm (on one of the cores) that runs some non-realtime guest
os. So I would like to know if qemu-kvm have impact on the
latencies/jitter of the realtime threads?

Thanks,
Henri

