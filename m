Message-ID: <483ADAE3.2060105@domain.hid>
Date: Mon, 26 May 2008 17:44:35 +0200
From: Sebastian Smolorz <smolorz@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] revision 3882 breaks compilation of xenomai
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai-core <xenomai@xenomai.org>

Hello Gilles,

with your last commit:
Fix compilation with ucLibc

I cannot build xenomai userland any more (at least when taking glibc). 
cyclictest fails with the following error:

../../skins/posix/.libs/libpthread_rt.so: undefined reference to `likely'
../../skins/posix/.libs/libpthread_rt.so: undefined reference to `unlikely'
collect2: ld returned 1 exit status

-- 
Sebastian

