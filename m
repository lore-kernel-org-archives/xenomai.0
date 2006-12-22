Message-ID: <b647ffbd0612220242g603dbfd8g75a59ab3790d04f5@domain.hid>
Date: Fri, 22 Dec 2006 11:42:59 +0100
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
In-Reply-To: <9386881.1166783234553.JavaMail.ngmail@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <458ACFDA.8070300@domain.hid>
	<12420573.1166713240349.JavaMail.ngmail@domain.hid>
	<b647ffbd0612210717u4b8f0505m65d01bc2824a144a@domain.hid>
	<8403506.1166715370788.JavaMail.ngmail@domain.hid>
	<b647ffbd0612210743m2b208cb2w6e9054336fd68028@domain.hid>
	<9212697.1166778373331.JavaMail.ngmail@domain.hid>
	<458BA432.2000205@domain.hid>
	<b647ffbd0612220140m504db8e4x52ca45477e425d44@domain.hid>
	<458BB057.9090009@domain.hid>
	<9386881.1166783234553.JavaMail.ngmail@domain.hid>
Subject: [Xenomai-help] Re: Re: A fairly small rtnet/Xenomai...
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 22/12/06, M. Koehrer <mathias_koehrer@domain.hid> wrote:
> Hi Gilles,
>
> > fault_vm is safe to use only if you are calling fork at a time when
> > there is only one thread. So, if your application is forking at init, it
> > should be OK.
> Do you mean there must be only one real time thread?
> That means, when I have an application that creates multiple real time threads,
> I can not rely on fault_vm() ?

Yes, read my previous mail.

> In this case I have to do the "hard" way by using a different (non real time)
> context to do the forks and system() calls.

That's much safer indeed. Both in respect of this particular problem
and others that may be encountered using fork() from a multithreaded
application.

e.g. look here

http://www.gnu.org/software/libc/manual/html_node/Threads-and-Fork.html#Threads%20and%20Fork

> As this is hard to understand, I strongly recommend that there is Xenomai support
> for this! I.e. a Xenomai API that can be called with a (callback-)function pointer and
> a user data pointer.
> When a (realtime) thread calls this function, the real time thread is blocked.
> The callback function is then called from a safe context and
> after exit of the callback function the real time thread is resumed.

I haven't got your idea. Did you get the cause of the problem with fork() ?

>
> Regards
>
> Mathias

-- 
Best regards,
Dmitry Adamushko

