MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18428.54575.238202.690441@domain.hid>
Date: Wed, 9 Apr 2008 16:39:43 +0200
In-Reply-To: <14532.81.252.86.91.1207740558.squirrel@domain.hid>
References: <16201.81.252.86.91.1205764989.squirrel@domain.hid>
	<6621.81.252.86.91.1205927700.squirrel@domain.hid>
	<2ff1a98a0803190613r7572d87eibef16aecf39ef71a@domain.hid>
	<10023.62.39.72.60.1205940829.squirrel@domain.hid>
	<18407.43111.568301.509775@domain.hid>
	<18407.58512.849738.173184@domain.hid>
	<18408.10253.285795.914555@domain.hid>
	<3551.81.252.86.91.1206464698.squirrel@domain.hid>
	<2ff1a98a0803251037y3c0d8735he1fc82895c349c3c@domain.hid>
	<2786.81.252.86.91.1206522879.squirrel@domain.hid>
	<2ff1a98a0803260236r409752a3v55cd8dce1305a003@domain.hid>
	<15944.81.252.86.91.1206526011.squirrel@domain.hid>
	<18410.43769.299931.151297@domain.hid>
	<1159.62.39.72.60.1207731606.squirrel@domain.hid>
	<14532.81.252.86.91.1207740558.squirrel@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] Posix timers increase
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Fabien MAHOT <fabien.mahot@domain.hid>
Cc: xenomai@xenomai.org

Fabien MAHOT wrote:
 > > Hello,
 > >
 > > I ve got an application in which I create a lot of posix timers (with
 > > timer_create). After a while timer_create returns an error. There is no
 > > available timer. I would like to increase the timer amount. How can I do
 > > this ? there is a link with "Size of the system heap" kernel configuration
 > > option ?
 > >
 > > thanks a lot
 > >
 > 
 > 
 > folder xenomai : ksrc/skins/posix/timer.c : #define PSE51_TIMER_MAX 128

Beware: posix timers use signals, and signals in user-space cause the
target thread to switch to secondary mode. So, timers are or little use
in user-space. You would better use clock_nanosleep, or
pthread_make_periodic_np/pthread_wait_np.

-- 


					    Gilles.

