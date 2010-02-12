Message-ID: <4B757217.3060406@domain.hid>
Date: Fri, 12 Feb 2010 16:21:59 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Yet another ((weak)) bug
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Hi Gilles,

this one requires some fixing too:

xeno_sem_heap is marked weak. xeno_init_sem_heaps is called once per
initialized skin. It unmaps any existing heap and creates a new one.
That's already fragile during constructor run, but it's lethal during
process runtime, ie. when using dlopen.

I think the solution is to handle forks separately and only remap in
that case. Digging in this direction now.

BTW, what triggers the re-run of xeno_init_sem_heaps after a fork so far?

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

