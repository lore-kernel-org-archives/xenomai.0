Message-ID: <43C12304.4040802@domain.hid>
Date: Sun, 08 Jan 2006 16:34:44 +0200
From: Heikki Lindholm <holindho@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] latency kernel part crashes on ppc64
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hi,

Some recent changes (*cough* RTDM benchmark driver *cough*) broke kernel 
mode benchmarking for ppc64. Previously klatency worked fine, but now 
latency -t 1 crashes somewhere in xnpod_schedule. Jan, any pending 
patches a comin'?

-- Heikki Lindholm

