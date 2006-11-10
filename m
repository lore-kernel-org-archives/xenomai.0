Message-ID: <BAY101-F393615B841E0E80C7EBAEEE2F70@domain.hid>
From: "Marco Rossi" <cicciobombo123@domain.hid>
Date: Fri, 10 Nov 2006 14:11:24 +0100
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Subject: [Xenomai-help] Problem with RTDM
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

I found the problem; in the same PC there is an installation of rtai and to 
avoid problem with dynamic library I modified the file /etc/profile adding 
the line "export LD_LIBRARY_PATH=/usr/realtime-rtai/lib"> Deleting this line 
all work ok.
Thank you for support

_________________________________________________________________
Usa il tuo PC come un telefono per chiamare cellulari e telefoni fissi! 
http://imagine-msn.com/messenger/launch80/?locale=it-it&TAB=2


