MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17590.28495.53263.24303@domain.hid>
Date: Thu, 13 Jul 2006 18:05:35 +0200
Subject: Re: [Xenomai-help] RT timer help
In-Reply-To: <e325d110607130902r6bdd04e4l1001f33e094d9d4a@domain.hid>
References: <e325d110607130503k37a4e648p1ae581e7b984abb4@domain.hid>
	<17590.14655.583084.480317@domain.hid>
	<e325d110607130737j3011b167wef31d2bf8fa6fd42@domain.hid>
	<17590.23816.918869.787019@domain.hid>
	<e325d110607130902r6bdd04e4l1001f33e094d9d4a@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Kim Chuan Lim <lim.kim.chuan@domain.hid>
Cc: xenomai@xenomai.org

Kim Chuan Lim wrote:
 > Hi Gilles,
 > 
 > > Does the latency test suffer from the same issue ?
 > 
 > I read the system time(rt_timer_read()) and the different is the same,
 > almost 1,000,000,000 different. But my program just took ~10seconds
 > for every update..

If latency suffers from the same issue, then your problem is in the
setup and I advise you once more to read the TROUBLESHOOTING
file. If latency does not suffer from the same issue, then you have made
a mistake in the code.

-- 


					    Gilles Chanteperdrix.

