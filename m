Message-ID: <2ff1a98a0806110535h6ce1a4a4vb577fc76a22f7a38@domain.hid>
Date: Wed, 11 Jun 2008 14:35:39 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <21830053.6301213172618935.JavaMail.root@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <26287316.6271213172573467.JavaMail.root@domain.hid>
	<21830053.6301213172618935.JavaMail.root@domain.hid>
Subject: Re: [Xenomai-help] Debugging realtime tasks
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Andreas Erler <a.erler@domain.hid>
Cc: "." <xenomai@xenomai.org>

On Wed, Jun 11, 2008 at 10:23 AM, Andreas Erler
<a.erler@domain.hid> wrote:
> Hi,
>
> I want to debug a userspace task created with: rt_task_create(&demo_task, "trivial", 0, 99, 0);
> When I set a breakpoint somewhere in the demo_task function I get the following message and gdbserver exits:
>
> Child terminated with signal = 5
>
> Child terminated with signal = 0x5 (SIGTRAP)
> GDBserver exiting
>
> Is it generally possible to debug realtime tasks or not?
> If yes, what I'm doing wrong here?

Yes, it is supposed to work. A common problem with using gdbserver
with gdb is not using the same version, you should use absolutely the
same  version of gdb and gdbserver.

If you use the same version of gdb and gdbserver and still have the
problem, could you post an example, and tell us where to put the
breakpoint ?

You should also tell us which version of Xenomai you use, and on which platform.

-- 
 Gilles

