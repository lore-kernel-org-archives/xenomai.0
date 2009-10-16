Sender: Alexis Berlemont <alexis.berlemont@domain.hid>
From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Sat, 17 Oct 2009 00:31:05 +0200
References: <96eea0c80910151813v635d518dr6abd72986e2f07bd@domain.hid>
	<72cf3fb0910161406g313db0ffm61c6bd09a65e025c@domain.hid>
	<96eea0c80910161506v6292310et2d5fdf617355d97e@domain.hid>
In-Reply-To: <96eea0c80910161506v6292310et2d5fdf617355d97e@domain.hid>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200910170031.06247.berlemont.hauw@domain.hid>
Subject: Re: [Xenomai-help] national instruments card and comedi-rtdm-dev
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Pastor <peter.pastor@domain.hid>
Cc: xenomai@xenomai.org

On Saturday 17 October 2009 00:06:21 Peter Pastor wrote:
> Hey Alexis,
> 
> Thanks for your response !!
> 
> >> Yes take the abe repository, please. I will make a pull request soon.
> 
> I downloaded the git xenomai-abe repository and installed linux-2.6.29.1
> (since there was no patch for 2.6.30.5).
>

That's because you did not retrieve the "comedi" branch, you are working the 
master branch which is left unused.

You should create a branch on your local repository with the remote comedi 
branch as reference.

> The installation worked out, however, it seems that the comedi_pcimio
>  driver is not included.
> Am I missing something during configuring the kernel ??
> 
> From what I understand now is that I need xeno_comedi.ko which is the
> interface to xenomai and RTDM and I need comedi_pcimio.ko which actually
> talks to the hardware and does real-time capable I/O. Is this correct ??
> 
> Thanks a lot, I am really glad that I am getting somewhere !!
> 
>  peter
> 

Alexis.

