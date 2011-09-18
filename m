From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <CAAXf6LVErpVae0HVcqv4Rc6p2wnJLje7He2NJC7S1aCSVnD9NQ@mail.gmail.com>
References: <CAAXf6LVErpVae0HVcqv4Rc6p2wnJLje7He2NJC7S1aCSVnD9NQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 18 Sep 2011 17:37:16 +0200
Message-ID: <1316360236.2169.40.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] PSOS skin: mismatch in function signatures cause
 buffer overflow
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Thomas De Schampheleire <patrickdepinguin+xenomai@domain.hid>
Cc: Xenomai-help@domain.hid

On Fri, 2011-09-16 at 14:59 +0200, Thomas De Schampheleire wrote:
> Hi,
> 
> The original PSOS interfaces that take a name (like t_create,
> sm_create etc), expect a character array with length 4:
> unsigned long t_create(char name[4], unsigned long prio, unsigned long
> sstack, unsigned long ustack, unsigned long flags, unsigned long
> *tid);
> unsigned long sm_create(char name[4], unsigned long count, unsigned
> long flags, unsigned long *smid);
> 
> while the corresponding PSOS skin in Xenomai expects a null-terminated
> character array (a real string):
> u_long t_create(const char *name, u_long prio, u_long sstack, u_long
> ustack, u_long flags, u_long *tid_r);
> u_long sm_create(const char *name, u_long icount, u_long flags, u_long *smid_r);
> 
> 
> In certain situations, this difference gives rise to a buffer overflow
> on the name variable.
> For example:
> 
>         unsigned long smid, err;
>         {
>                 char id[4] = {'S','E','M','0'};
>                 err = sm_create(id,0,SM_PRIOR,&smid);
>         }
>         {
>                 char id[4] = "SEM";
>                 id[3] = '1';
>                 err = sm_create(id,0,SM_PRIOR,&smid);
>         }
>         {
>                 char id[4] = "SEM2";
>                 err = sm_create(id,0,SM_PRIOR,&smid);
>         }
>         {
>                 char id[4] = "MySemaphore";
>                 err = sm_create(id,0,SM_PRIOR,&smid);
>         }
> 
> The first two examples are perfectly valid code. The third one (SEM2)
> is dubious because the end-of-string character will overflow the
> array, although the compiler does not complain. The fourth example
> (MySemaphore) obviously is an array-overflow and is indeed warned upon
> by the compiler.
> 
> On target, this creates the following semaphores (taken from the registry):
> 
> # ls /proc/xenomai/registry/psos/semaphores/SEM*
> /proc/xenomai/registry/psos/semaphores/My*
> /proc/xenomai/registry/psos/semaphores/MySeAB4abcaaaaaaaaaaaaaaaaaaaaa
> /proc/xenomai/registry/psos/semaphores/SEM0????p????_S22753
> /proc/xenomai/registry/psos/semaphores/SEM1p????_S22753
> /proc/xenomai/registry/psos/semaphores/SEM2?_S22753
> 
> As you can see, in all cases there was an array overflow (the question
> marks correspond to non-ASCII characters), caused by the missing
> null-termination (in itself caused by a mismatch between the original
> PSOS interface and the Xenomai PSOS skin implementation of it).
> 
> If you do not explicitly create a character array of length 4, e.g.
> (char id[] = "SEM1") then the Xenomai code obviously works fine: it
> receives a null-terminated string, as it expects.
> 
> 
> To fix this problem, the PSOS skin should treat incoming names as
> non-null-terminated character arrays of length 4, and explicitly add
> null-termination before passing it to the nucleus.
> 
> What is your view on this?

Actually, we used to follow strictly the pSOS convention for this until
2.4.x, at which point we moved to name strings precisely because
non-null terminated char[4] arrays would break the registry, the way you
described. This is one of the rare situations where mimicking a useless
limitation of the original API may be challenged by usability concerns
in the new environment, and usability won in that case. The problem
mostly comes from the fact that char[4] is automatically convertible to
const char *, so we have no warning/error leading us to check the
potentially problematic call sites.

The concern about moving back to char[4] arrays - null-terminated if
shorter - is for people who currently assign strings longer than 4
characters to name their objects. What could be done, is providing a
build switch to select the accepted input, like
--disable-psos-long-names to turn on char[4] interpretation.

> 
> Thanks,
> Thomas
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



