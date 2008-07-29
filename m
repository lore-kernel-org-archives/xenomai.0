Message-ID: <488F9869.4040003@domain.hid>
Date: Wed, 30 Jul 2008 00:23:37 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <200807152346.21863.leo@domain.hid>
	<488D9A75.1040705@domain.hid>
	<200807300008.48525.leo@domain.hid>
In-Reply-To: <200807300008.48525.leo@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] OT. A question about constraints in realtime
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Leopold Palomo Avellaneda <leo@domain.hid>
Cc: xenomai@xenomai.org

Leopold Palomo Avellaneda wrote:
> A Dilluns 28 Juliol 2008, Gilles Chanteperdrix va escriure:
>> Leopold Palomo Avellaneda wrote:
>>> The sensable people claims that their driver works with some versions of
>>> Linux (till fedora 4 and some suse) but I'm not be able to run it in a
>>> debian etch. I don't know if the distros provide a kernel with some kind
>>> of modifications that solve it, but I don't think so.
>>>
>>>
>>> Well, thanks in advance and I'm sorry for the noise. Really, the realtime
>>> stuff is something not obvious...
> 
> First of all thanks for the answer. 
> 
>> The first thing to do is to get statistics about the scheduling latency
>> of your driver. This means measuring the difference between the date
>> when the driver (kernel-code) wakes up the task and the date when the
>> task effectively runs. The bad news is that it will be hard with a
>> binary-only driver. If the driver has some compilable glue, then you can
>> hook into this glue, otherwise, you will have to resort to ugly hacks in
>> the kernel code.
> 
> Well, I cannot (or it's too difficult to do it with a _only_ binary driver. 
> This driver is a lib (.so) and the user use some functions of that lib. 

It is hard, but not impossible. You can hook into the sys_open function,
detect that you are opening the driver (using either the device path, or
 current->comm), and in this case, replace the file operation pointer in
the file descriptor with your own file operations pointers which does
some tracing then calls the original file operation pointer. So, it is
not impossible.

-- 


					    Gilles.

