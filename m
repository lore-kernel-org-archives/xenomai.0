From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <314537.73250.qm@domain.hid>
References: <314537.73250.qm@domain.hid>
Content-Type: text/plain
Date: Wed, 18 Jul 2007 19:48:37 +0200
Message-Id: <1184780917.13258.79.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Problem with rt_pipe and user space	communication
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Mathieu JOINIE-MAURIN <mjoiniem@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2007-07-18 at 14:43 +0000, Mathieu JOINIE-MAURIN wrote:
> Hi everybody,
> 
> I try to learn Xenomai. I have a problem that I do not understand. I
> want that my real time task to communicate with my user space task
> through a pipe (FIFO) in order to save sample datas in a file. My
> problem is the following. I create a pipe with:

<snip>
> 
> I get a value of 8 for nb_read which corresponds to sizeof(double).
> But i am expecting more. I do not know why the system function read(2)
> works like this.
> 
The user-space side seems to read double values as soon as they are
written to the pipe (i.e. try sending two doubles in a row at each
kernel-side write op), so this behaviour would be the expected one.

Sidenote: rt_pipe_stream will not keep message boundaries (e.g. writing
8 + 4 + 4 may cause the read side to get 12 + 4); rt_pipe_send/write
will keep the boundaries intact.

> Thank you in advance for your help,
> 
> Mathieu
> 
> 
> 
> ______________________________________________________________________
> Ne gardez plus qu'une seule adresse mail ! Copiez vos mails vers
> Yahoo! Mail 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



