Message-ID: <444FF092.2010002@domain.hid>
Date: Thu, 27 Apr 2006 00:13:38 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] I-pipe latency tracer for ppc
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


As promised, the I-pipe tracer has been ported to ppc. People working on 
this architecture are invited to give it a try, it's a great tool to 
find out where the cycles are actually going.

Just apply the tracer patch on top of the Adeos patch bearing the same 
revision number, and select the feature from the kernel configuration. 
If you happen to have some issue while booting the instrumented kernel 
on embedded setups (e.g. freeze after kernel decompression), try 
reducing the size of the trace log (CONFIG_IPIPE_TRACE_SHIFT).

http://download.gna.org/adeos/patches/v2.6/ppc/tracer/

-- 

Philippe.

