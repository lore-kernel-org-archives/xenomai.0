Message-ID: <443826D4.9070507@domain.hid>
Date: Sat, 08 Apr 2006 23:10:44 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Problems using Xenoscope
References: <91clg3-vfp.ln1@domain.hid>
In-Reply-To: <91clg3-vfp.ln1@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
To: Bernhard Walle <bernhard.walle@domain.hid>
Cc: xenomai@xenomai.org

Bernhard Walle wrote:
> Hello,
> 
> I have problems using Xenoscope (Xenomai 2.1.0, Xenosim 2.1). The
> simulation works, i.e. text messages are printed on the console. I use
> the example from
> http://www.mail-archive.com/xenomai@xenomai.org.
> 
> The problem is that the traces dialog is empty, there are also no items
> in the tree, only
> 
>   - System
>      -RT/Interfaces
>

It's not a bug, it's just that the tracer and some other interface 
objects are still missing.

> Debugging with GDB seems to work. I used 6.4 and 5.3. I use Debian
> GNU/Linux 3.1 with gcc 3.x.
> 
> 
> Regards,
>   Bernhard


-- 

Philippe.

