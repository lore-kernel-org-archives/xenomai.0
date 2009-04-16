Message-ID: <49E72BA8.20203@domain.hid>
Date: Thu, 16 Apr 2009 14:59:20 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <37f89760904160447j7399b4ctced93a3e4956db6a@domain.hid>
In-Reply-To: <37f89760904160447j7399b4ctced93a3e4956db6a@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] driver: IOCTL command behavior
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Marcel Soulot <msoulot@domain.hid>
Cc: xenomai@xenomai.org

Marcel Soulot wrote:
> Hi,
> 
> I wrote a driver and used IOCTL command. When I test my driver with a test
> application with root access the IOCTL cmd work fine.
> I notice when I declared my IOCTL command that I used the _IOR for all of
> them. Even the IOCTL command is a read (on register) or write.
> So I try to correct my mistake and wants to use _IOR for read command and
> _IOW for write command.
> For the write command, I got a error -25 (not a typewriter) so I don't
> understand why.
> I also try to change the _IOW to _IOWR but same mistake.
> 
> Someone can explain what is the problem, please ?

A piece of code is worth a thousand words...

-- 
                                                 Gilles.

