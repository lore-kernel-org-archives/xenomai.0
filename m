MIME-Version: 1.0
In-Reply-To: <52839493.4040300@xenomai.org>
References: <CAN0CFw203jRKLtMmb9jCQbyQnM1hmAaHr=FtonvxxcSUov8Ujw@mail.gmail.com>
 <52839493.4040300@xenomai.org>
Date: Thu, 14 Nov 2013 04:31:35 -0800
Message-ID: <CAN0CFw3Z8je+wTdPBcWJArfoZuq=HWkb3bVW2ZYYVFor+8S3SA@mail.gmail.com>
From: Grant <emailgrant@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] patch the kernel?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

>> Is patching the kernel necessary in order to use xenomai?
>
> It depends on which version of Xenomai you are talking about. If you are
> talking about Xenomai stable version, then yes, you have to follow the
> installation instructions here:
> http://www.xenomai.org/documentation/xenomai-2.6/html/README.INSTALL/
>
> Which include running the "prepare-kernel.sh" patch, which modifies the
> kernel.
>
> If you are talking about Xenomai current development version, a.k.a. Xenomai
> forge, then it gives you the choice of running:
> - on an unmodified kernel  (but you will not have real-time guarantees);
> - a kernel patched with the PREEMPT_RT patch;
> - a kernel modified as with the stable version.
>
> The current state of Xenomai forge is that it is stable enough on the x86
> and ARM architectures to run a latency test under load.

Thanks I really need to try Xenomai forge.  I wish Gentoo had an
ebuild but there is a bug for it:

https://bugs.gentoo.org/show_bug.cgi?id=438236

- Grant

