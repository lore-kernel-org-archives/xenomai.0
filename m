Message-ID: <45D9F759.7020006@domain.hid>
Date: Mon, 19 Feb 2007 20:15:37 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
Subject: [Xenomai-help] patching continues
Reply-To: rolandtollenaar@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

Hi all,

I have gone through the kernel patching steps and all seems to go well. 
Except...

1
I don't seem to get an initrd from the make process and my system does 
not have a mkinitrd on it. Is this normal? I get the vmlinux though 
which I am very happy about :)

2
Then the make modules install generates the lib/modules/2.6.16-pipe 
directory but it has only a very few modules. Not nearly as many as the 
current kernel seems to have.

Might anyone be able to give some hints as to what I could be doing wrong?

Kind regards,

Roland.

