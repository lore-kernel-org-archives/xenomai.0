MIME-Version: 1.0
In-Reply-To: <4FE22000.5090102@xenomai.org>
References: <CAM1yFZ8PK+i3quP2MfFeEAR2Wya0f9bV=bjYehXeY5KTw8EJuQ@mail.gmail.com>
	<4FE22000.5090102@xenomai.org>
Date: Thu, 21 Jun 2012 11:16:38 +0530
Message-ID: <CAM1yFZ9k4SWugyHLJCnKddH0Eu4rJQO9W07aBqVw+sCvQrP_XQ@mail.gmail.com>
From: Anisha Kaul <born.rebel.83@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai]
	=?windows-1252?q?error=3A_storage_size_of_=91sysinfo=92?=
	=?windows-1252?q?_isn=92t_known?=
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 21/06/2012, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> I see a discrepancy here, you are told to disable CONFIG_ACPI_PROCESSOR
> and you disable CONFIG_ACPI,

I was indeed reading the `make menuconfig` options wrongly. But,
changing this option didn't help. I also tried to redo some other
changes that I had done previously, but nothing helped in  getting rid
of those errors.
So, finally I just deleted those directories containing extracted
xenomai and linux files, and started from scratch again - this time
very carefully selecting every option.

The kernel is still compiling on my computer, but this time it has
gone past the stage where it met those errors. I hope it'll get
peacefully compiled this time.



> find and fix the problem yourself, I am tired of answering you.

Of course I do feel that I have tested your patience with these kind
of configuration errors. I am myself sick of recompiling xenomai and
kernel over and over. I do wish to start with the programming things
now. I hope this is the last time I am doing this.

I surely won't bug this mailing list with the configuration issues at
least, in future. And no, I am not taking you for granted, I am
utterly grateful for all the patience you've shown by now.
Pardon me all the inconvenience I have caused you.

-- 
Anisha Kaul

