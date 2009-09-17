MIME-Version: 1.0
Date: Thu, 17 Sep 2009 14:17:36 -0400
Message-ID: <9b3e2dc20909171117x6fb3f8b7ka4491e2bf9259cce@domain.hid>
From: Stephen Sinclair <radarsat1@domain.hid>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai-help] udev rules
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

I am successfully running Xenomai examples now.  Just wanted to note
that it took me a little while to figure out why I was getting this
error even though I had set up the xenomai group as suggested in the
quick build guide:

$ ./trivial-periodic
Xenomai: open: Permission denied
Xenomai: mmap(local sem heap): Permission denied

I found that the /dev/rtheap node did not have the correct
permissions. I finally found the rtheap.rules file included in
xenomai.  I just wanted to suggest that installation of this rules
file in /etc/udev/rules.d should perhaps be included as a step in this
quick build guide.

thanks,
Steve

