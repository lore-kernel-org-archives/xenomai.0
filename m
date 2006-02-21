Date: Tue, 21 Feb 2006 13:01:28 -0800
From: Steven Seeger <steve@domain.hid>
Message-ID: <C020BFA8.24B5%steve@domain.hid>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Content-transfer-encoding: 7bit
Subject: [Xenomai-help] another issue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

In my last email I said that making a system call in a lower priority task
seems to interfere with a higher priority task. I also said that once a
shadow thread makes a system call, it seems to forever lose its determinism.
The higher priority task I mentioned in my last email does indeed make a
system call: iopl(). I need to be able to access i/o without losing my
determinism. I'm pretty sure there's a bug somewhere and would appreciate
any help figuring it out. I can post more code if need be. Tomorrow that is.
Time to get to class now. :)

Regards,
Steven


