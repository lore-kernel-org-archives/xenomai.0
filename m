Message-ID: <48F49DCE.2070308@domain.hid>
Date: Tue, 14 Oct 2008 15:25:34 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48F3C3E4.4020801@domain.hid>
	<48F45847.3030704@domain.hid>	<48F461A6.6010600@domain.hid>
	<48F4634B.3030002@domain.hid>	<48F465DD.6020505@domain.hid>
	<48F46954.6050704@domain.hid> <48F473A2.1050104@domain.hid>
	<48F48E2E.2050004@domain.hid> <48F49540.3060507@domain.hid>
	<48F49637.2030000@domain.hid> <48F497B2.4080404@domain.hid>
	<48F4987F.1060901@domain.hid> <48F499EF.9010205@domain.hid>
In-Reply-To: <48F499EF.9010205@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] __thread instead of pthread_get/setspecific
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Ack. There are rt_printf (rtdk) and the task-self services of vxworks,
> vrtx and native skins. So if I get an OK for the proposal, I'll convert
> the rest, too.

And I really do not understand how the keys can be chosen at
compilation-time, especially in the situation where multiple libraries
allocate __thread objects separately: how does the compiler know which
key to give for each library ?

-- 
                                                 Gilles.

