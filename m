Message-ID: <4C23B213.5080103@domain.hid>
Date: Thu, 24 Jun 2010 21:29:23 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTik_lbFNx1L6vYAYLVZDnEWG7IdQnAq7-4z2pLiy@domain.hid>
In-Reply-To: <AANLkTik_lbFNx1L6vYAYLVZDnEWG7IdQnAq7-4z2pLiy@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Some questions about Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Charles Clerdan <charles.clerdan@domain.hid>
Cc: xenomai@xenomai.org

Charles Clerdan wrote:
> Hi,
> 
> I'm actually working on an academic project about Real-Time on Xenomai.
> I have some questions about Xenomai (for all of them, the application is in
> user-space).

An off-topic remark: "actually" is a "faux-ami", it does not mean at all
the same thing as "actuellement" in french.

> 
> How can we use gdb with a RT application? (I understand that, a Xenomai
> thread has no PID because it's use a TASK descriptor instead but gdb needs a
> PID to attach with)

a Xenomai thread is first of all a full-blown glibc thread, and thus, a
process containing a Xenomai thread is a full-blown linux process, with
a valid PID. Note that talking about the PID of a thread does not really
make sense, because a PID is a Process ID, so the identifier of the
process, not the thread, and gdb also attaches to a process, that is, to
all the threads of a process at once.

There is not much to say about debugging with gdb a process running
Xenomai threads, but since it is an FAQ, we answered it here:
http://www.xenomai.org/index.php/FAQs#How_can_GDB_be_used.3F

> 
> How can I detect that a Xenomai thread is in secondary mode (I try to use
> RT_TASK_INFO but the value is always 0 even if I do non-RT call) ? And does
> a mecanism like assertion exist in order to prevent this?

You do not want to detect that a Xenomai thread is running in secondary
mode, this can lead to crappy code which we do not want to cause you to
write. What you may want, however, is to detect that a thread which you
would want to run in primary mode has switched to secondary mode. For
this, you should do what the file examples/native/sigdebug.c found in
Xenomai sources does, or if you are using the POSIX skin, what is
documented here:
http://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai#Using_the_PTHREAD_WARNSW_bit.

> 
> I want to make an IT server as exemple, how can I get back some IT or
> generate them from the ADEOS' I-pipe ?

Well. You may theoretically use the native or POSIX API to handle
interrupts (I guess by IT you mean interrupts?) in user-space, but it is
discouraged. What you should do, however, is to write an RTDM driver. See:
http://www.xenomai.org/documentation/branches/v2.3.x/pdf/RTDM-and-Applications.pdf

For the detailed documentations of the native, posix and RTDM skins, see:
http://www.xenomai.org/documentation/xenomai-2.5/html/api/index.html

-- 
					    Gilles.

