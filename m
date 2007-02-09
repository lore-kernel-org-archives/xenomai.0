Message-ID: <45CC651C.6060402@domain.hid>
Date: Fri, 09 Feb 2007 13:12:12 +0100
From: Stephan Zimmermann <s.zimmermann@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] fata: removing non-linked element...
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
I just saw the following errormessages while running some tests with my 
application.

"Xenoami: fatal: removing non-linked element, holder=ef9a5794 
qslot=f96f70d0 at include/xenoami/nucleus/queue.h:422"
"Xenomai: Stuck on nucleus lock f96f6380"

Followed by pressing the reset-button...

I Run Xenomai 2.3 rev 2139 on AMD X2, kernel 2.6.17.14, debian sarge.

May this be due to an misbehaviour in my app, or does it look like 
something xenomai related? I am not sure how to interpret these messages.

Thanks in advance, Stephan



