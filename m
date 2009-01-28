Message-ID: <498082B7.2000609@domain.hid>
Date: Wed, 28 Jan 2009 16:07:19 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <8E970E0F84BD44C9B4C41942F86F2F34@domain.hid>
In-Reply-To: <8E970E0F84BD44C9B4C41942F86F2F34@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] TR: Kernel panic with (Kernel-2.6.27/Xenomai
	-2.4.6)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sebastien DI MERCURIO <sebastien.di-mercurio@domain.hid>
Cc: xenomai@xenomai.org

Sebastien DI MERCURIO wrote:
> Hello,
>  
> I have compiled and installed linux kernel 2.6.27 in a fedora distro running
> in Virtualbox. Everything worked fine.
> After that, I patched the kernel using xenomai-2.4.6 script
> "prepare-kernel.sh". So, the adeos patch used was
> adeos-ipie-2.6.27-x86-2.1-01.patch. No problem.
>  
> Then I have configured the newly patched kernel for activate xenomai and
> nucleus (find the .config file in attachment). I compiled the kernel. No
> error, no problem.
>  
> But when I boot the patched kernel, it produces a panic, apparently in
> xeno_sys_init (look at the screen copy of vitualbox).

Do you have the same error if you boot this kernel on a real machine ?


-- 
                                                 Gilles.

