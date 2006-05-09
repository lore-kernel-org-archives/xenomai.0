Message-ID: <44604DEA.9050901@domain.hid>
Date: Tue, 09 May 2006 10:08:10 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] A bug of udev rules?
References: <44603695.2020407@domain.hid>
	<200605091559.50160.rlenglet@domain.hid>
In-Reply-To: <200605091559.50160.rlenglet@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Romain Lenglet <rlenglet@domain.hid>
Cc: xenomai@xenomai.org

Romain Lenglet wrote:
> Liu Zhenghui wrote:
> 
>>I installed xenomai on Debian Linux sid. For some reason, I
>>recently changed to udev to manage the /dev. Then udev always
>>report error on
>>
>>rules installed by xenomai at boot time like following:
>>: add_to_rules: invalid KERNEL operation
>>: add_to_rules: invalid rule
>>: '/etc/udev/rules.d/udev.rules:100'
>>
>>As a result, the device rtheap and rtp* is not controlled by
>>udev rules and always has default mode "0660".
>>
>>I found there is wrong with rules installed by xenomai, which
>>source is located at ksrc/nucleus/udev/*.rules:
>>
>># real-time heap device (Xenomai:rtheap)
>>KERNEL="rtheap",  NAME="rtheap", MODE="0666"
>>      ~should be "==" here, not "="
>>
>>My udev version in debian is 0.091-2, kernel version is
>>2.6.15.7
>>
>>Is it a bug? Luckly, it works after I changed "=" to "=="
> 
> 
> I also got such errors with my own rules and rules from other 
> packages.
> Debian's udev package applies an upstream patch which makes udev 
> more strict about the syntax, since version 090 (21 April 2006).
> See /usr/share/doc/udev/changelog.Debian.gz.
> 
> So, you are right, it should be:
> KERNEL=="rtheap",  NAME="rtheap", MODE="0666"
> Key match and assignment are now strictly syntactically 
> different, and KERNEL is a read-only key which can't be 
> assigned.
> 
> I think that it is safe to change KERNEL= into KERNEL== in 
> Xenomai's rules files, since the == syntax has been introduced 
> since Udev version 055 (March 2005).
> 
> By the way, I think that the NAME= assignment is superfluous, 
> because by default NAME is the kernel-assigned name in KERNEL.
> 
> 
> Attached is the two-line patch.
> 

Applied, thanks.

-- 

Philippe.

