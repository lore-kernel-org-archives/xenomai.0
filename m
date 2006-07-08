From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17583.47182.991802.118974@domain.hid>
Date: Sat, 8 Jul 2006 15:51:10 +0200
Subject: Re: [Xenomai-help] xenomai beginner problem.
In-Reply-To: <e325d110607080632u5d80322bte8d32d8e4828030e@domain.hid>
References: <e325d110607071259g5ebc019bs2565887803265adc@domain.hid>
	<44AEC245.7090702@domain.hid>
	<e325d110607080632u5d80322bte8d32d8e4828030e@domain.hid>
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
 > Hi Jan,
 > 
 > You are right, i got some informations from my dmesg...
 > Xenomai: Local APIC absent or disabled!
 >          Disable APIC support or pass "lapic=1" as bootparam.
 > (...)
 > What should i do??

Try passing "lapic=1" as kernel boot parameter, and if it still does not
work, recompile your kernel with APIC support disabled.

If you want to know more about this issue, read the TROUBLESHOOTING
file.

-- 


					    Gilles Chanteperdrix.

