Message-ID: <f5e14e470809260406v3352ef88nf8eb21f727a8a1c6@domain.hid>
Date: Fri, 26 Sep 2008 13:06:33 +0200
From: "Ulrich Schwab" <uli.schwab@domain.hid>
In-Reply-To: <597724.70868.qm@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <597724.70868.qm@domain.hid>
Subject: Re: [Xenomai-help] CONFIG_XENO_OPT_NATIVE_INTR?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: menege1@domain.hid
Cc: xenomai@xenomai.org

On Fri, Sep 26, 2008 at 2:15 AM, egemen kaleli <menege1@domain.hid> wrote:
> Hello,
>
> When I want to call "rt_intr_create(&intr_timer,"MyIrq",irq,I_NOAUTOENA)"
> function it returns  -ENOSYS.CONFIG_XENO_OPT_NATIVE_INTR is off in default.I
> want to make it on.How can I do it?Which files and directories should  I
> look for?Any help will be greatly appreciated.
Usually You only need to handle irqs in a driver, and a xenomai driver
is doing it with the RTDM skin
and the system call: rtdm_irq_request  (see the API docs)
This is the reason CONFIG_XENO_OPT_NATIVE_INTR is off by default
If You want to switch it on anyway, You can do it in the kernel config
page for the native skin.

Ulrich Schwab

