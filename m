MIME-Version: 1.0
Date: Thu, 16 Apr 2009 13:47:11 +0200
Message-ID: <37f89760904160447j7399b4ctced93a3e4956db6a@domain.hid>
From: Marcel Soulot <msoulot@domain.hid>
Content-Type: multipart/alternative; boundary=001636c5bf44e9fcf40467aa9feb
Subject: [Xenomai-help] driver: IOCTL command behavior
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

--001636c5bf44e9fcf40467aa9feb
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I wrote a driver and used IOCTL command. When I test my driver with a test
application with root access the IOCTL cmd work fine.
I notice when I declared my IOCTL command that I used the _IOR for all of
them. Even the IOCTL command is a read (on register) or write.
So I try to correct my mistake and wants to use _IOR for read command and
_IOW for write command.
For the write command, I got a error -25 (not a typewriter) so I don't
understand why.
I also try to change the _IOW to _IOWR but same mistake.

Someone can explain what is the problem, please ?
Marcel.

--001636c5bf44e9fcf40467aa9feb
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi, <br><br>I wrote a driver and used IOCTL command. When I test my driver =
with a test application with root access the IOCTL cmd work fine.<br>I noti=
ce when I declared my IOCTL command that I used the _IOR for all of them. E=
ven the IOCTL command is a read (on register) or write.<br>
So I try to correct my mistake and wants to use _IOR for read command and _=
IOW for write command.<br>For the write command, I got a error -25 (not a t=
ypewriter) so I don&#39;t understand why. <br>I also try to change the _IOW=
 to _IOWR but same mistake.<br>
<br>Someone can explain what is the problem, please ?<br>Marcel.<br>

--001636c5bf44e9fcf40467aa9feb--

