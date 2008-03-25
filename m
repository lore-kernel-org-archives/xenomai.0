Message-ID: <2ff1a98a0803251037y3c0d8735he1fc82895c349c3c@domain.hid>
Date: Tue, 25 Mar 2008 18:37:02 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <3551.81.252.86.91.1206464698.squirrel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <16201.81.252.86.91.1205764989.squirrel@domain.hid>
	<18400.53752.538963.384358@domain.hid>
	<6621.81.252.86.91.1205927700.squirrel@domain.hid>
	<2ff1a98a0803190613r7572d87eibef16aecf39ef71a@domain.hid>
	<10023.62.39.72.60.1205940829.squirrel@domain.hid>
	<18407.43111.568301.509775@domain.hid>
	<18407.58512.849738.173184@domain.hid>
	<18408.10253.285795.914555@domain.hid>
	<3551.81.252.86.91.1206464698.squirrel@domain.hid>
Subject: Re: [Xenomai-help] Application crash
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Fabien MAHOT <fabien.mahot@domain.hid>
Cc: xenomai@xenomai.org

On Tue, Mar 25, 2008 at 6:04 PM, Fabien MAHOT
<fabien.mahot@domain.hid> wrote:
> Hello,
>
>  thank you very much for your answers !
>
>  I tried several configurations with my AMD ETX module... Interrupt shield
>  enable/disable, with GeodeLX
>
>  or Pentium-MMX processor. My application always crashed. However when the
>  priority coupling was
>
>  disabled, my application worked correctly. (but it must be enabled)
>
>  You said to me that I ve got an hardware issue. So, I tried with an other
>  ETX module. A Kontron with
>
>  celeron processor. With or Without the interrupt shield, my application
>  crashed. I also try with a PC
>
>  with a celeron processor, that's the same result.
>
>  Maybe, I ve got a problem with my c libraries, but as I ve got a good
>  beahaviour when the priority
>
>  coupling is disabled.What is your libraries version, please ?

I have tested with Xenomai trunk and version 2.4.2 (same version as
you). What do you mean by crash anyway ? Box lockup, application dying
? Is there no message on the console ? Did you try running your
application inside gdb ?

>
>  So, I am almost sure that it's not a hardware problem. But a problem with
>  my xenomai environment

If you suspect your xenomai environment, the best thing to do is to
remove any trace of Xenomai on your test box, and recompile Xenomai
from scratch, using the same version of Xenomai tarball for
kernel-space support and user-space support.

-- 
 Gilles

