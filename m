MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18517.4121.263079.559612@domain.hid>
Date: Sun, 15 Jun 2008 14:50:33 +0200
In-Reply-To: <710742c4778be6e1dff6e20b9c4303be@domain.hid>
References: <2ff1a98a0806100243ld67333an560e93d227e20a4f@domain.hid>
	<710742c4778be6e1dff6e20b9c4303be@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] xenomai scheduler's ticks period
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: matthieu.connaulte_xenomai@domain.hid
Cc: xenomai@xenomai.org

Matthieu wrote:
 > So, do I have to understand that all skins have their own scheduler ?
 > To schedule at 1ms, the instriction tickSet(1000) seems to works but
 > specifying option tick_arg=1000 to xeno_vxworks module doesn't ! I thing
 > that I do it in a bad way, endeed I added "options xeno_vxworks
 > tick_arg=1000" to /etc/modprobe.conf/local ... (In fact I must add this
 > module manually, it isn't loaded automatically while a vxworks instruction
 > need to execute).

I already answered this mail. You will find my answer in the mailing
list archives here:
https://mail.gna.org/public/xenomai-help/2008-06/msg00063.html

-- 


					    Gilles.

