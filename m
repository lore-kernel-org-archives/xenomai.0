Message-ID: <45C309BF.9090808@domain.hid>
Date: Fri, 02 Feb 2007 10:51:59 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Error: cat: /proc/xenomai/stat: Cannot allocate
	memory
References: <19981456.1170405795640.JavaMail.ngmail@domain.hid>	<1170408789.4981.1.camel@domain.hid>
	<1170409755.4981.11.camel@domain.hid>
In-Reply-To: <1170409755.4981.11.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
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
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> On Fri, 2007-02-02 at 10:33 +0100, Philippe Gerum wrote:
> 
>>On Fri, 2007-02-02 at 09:43 +0100, M. Koehrer wrote:
>>
>>>Hi everybody,
>>>
>>>I have a strange issue frequently when reading /proc/xenomai/stat.
>>>I do a cat /proc/xenomai/stat and I get an "Cannot allocate memory" error.
>>>This happens typcially after I have started and terminated by application that uses a number of tasks.
>>>I am able to reproduce it deterministically...
>>>While the application is running, I can see the stat values perfectly.
>>>Here is the head output of all /proc/xenomai/* files:
>>
>>At first sight looking at the code, there seems to be a memory leak
>>caused by an unfree kmalloc() block in the sched & stat sequence
>>routines. Will confirm and fix. Thanks,
>>
> 
> 
> Not confirmed for the leakage part regarding kmalloc(). We do have a
> seq_release_private() freeing the allocated block, so back to square #1.
> This said, some kernel memory is not released somewhere, as running
> vmstat tells me here.
> 
> Btw, is the rest of your system functional after the error occurs, or is
> a reboot needed afterwise?

Do you observe the same leakage without the nocow patch ?

-- 
                                                 Gilles Chanteperdrix

