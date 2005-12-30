Message-ID: <43B5658D.3030004@domain.hid>
Date: Fri, 30 Dec 2005 17:51:25 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] I-pipe + latency tracing patch
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
Cc: adeos-main@gna.org


I've just rolled out two patches, the first issue of the 1.1 series for 
x86, and the accompanying tracer patch contributed by Jan Kiszka and 
Luotao Fu. With the latter patch, the I-pipe shall trace the longest 
stalled path of the domain with the highest priority. Apply them in that 
order:

http://download.gna.org/adeos/patches/v2.6/adeos/i386/adeos-ipipe-2.6.14-i386-1.1-00.patch
http://download.gna.org/adeos/patches/v2.6/adeos/i386/tracer/ipipe-tracer-2.6.14-i386-1.1-00.patch

The core patch does not include Dmitry's work on the shared IRQ issues 
yet, but -01 will.

-- 

Philippe.

