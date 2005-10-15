Message-ID: <4350BCF3.6030606@domain.hid>
Date: Sat, 15 Oct 2005 10:25:23 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai -> PPC (III): Total Failure
References: <50649.193.52.24.125.1129318390.squirrel@domain.hid>
	<43500B0D.1030405@domain.hid>
In-Reply-To: <43500B0D.1030405@domain.hid>
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

Wolfgang Grandegger wrote:
> On 10/14/2005 09:33 PM smannori@domain.hid wrote:
> 
>>Hi:
>>
>>result: total failure. I think that could be the x.org X11 driver
>>
>>    BoardName "ATI Radeon (fglrx)"
>>    Driver "radeon"
>>
>>that cause so many problems.
> 
> 
> It's not clear to me what you are speaking about. What failed?
> 
> 
>>Someone could suggest any alternative explanations ?
>>
>>My every attempt to install Fusion/RTAI or Xenomai on this machine was a
>>disaster. I think that Powerbook and iBook are different beast.
>>
>>Beside that, standard Linux works great on this machine, expecially if you
>>use a recent kernel (2.6.11 or better).
> 
> 
> If you have a rather recent Linux 2.6 version running on your system,
> just use it. The distro does not really matter. Then download a recent
> kernel version from kernel.org and try to get it compiled and running on
> your box. Use the .config file from the kernel comming with the
> distribution. Don't forget to disable power management. Then wait until
> an up-to-date iPIPE patch get's available.
> 

Ok, the "thing" is here. Validated on my mpc52xx for now; will test it later on 
the Sandpoint board.

http://download.gna.org/adeos/patches/v2.6/adeos/ppc/adeos-ipipe-2.6.13-ppc-1.0-00.patch

-- 

Philippe.

