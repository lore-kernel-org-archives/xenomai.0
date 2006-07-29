Message-ID: <44CB312E.8090409@domain.hid>
Date: Sat, 29 Jul 2006 11:58:06 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] cpu_set_t and friends undefined
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

Hello,

with todays SVN version of Xenomai, the testsuite program 
switchtest/switch.c does not compile because cpu_set_t and friends 
(CPU_SET, ...) are not undefined. I'm using kernel version 2.4.25.

Any idea what goes wrong. I haven't found where cpu_set_t is declared, 
not even in Linux 2.4.17.7.

Thanks.

Wolfgang.

