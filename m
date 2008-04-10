Message-ID: <2ff1a98a0804101103i12cdf92ehde6110763656116f@domain.hid>
Date: Thu, 10 Apr 2008 20:03:40 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <47FE53F8.2010605@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <000701c89a75$d349f630$9601a8c0@domain.hid>
	<18429.6412.785941.128928@domain.hid>
	<000801c89a89$b7b09820$9601a8c0@domain.hid>
	<47FD650C.7030709@domain.hid>
	<2ff1a98a0804100225q6e216a50nb0c7c78c86d8817c@domain.hid>
	<47FE25EF.9070204@domain.hid>
	<2ff1a98a0804100843u4d4c20e5rd33f0b1c94f1e78a@domain.hid>
	<2ff1a98a0804101026g3fdb4795l59895c0a7be0f5a7@domain.hid>
	<47FE53F8.2010605@domain.hid>
Subject: Re: [Xenomai-help] mlockall questions
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jeff koftinoff <jeffk@domain.hid>
Cc: xenomai@xenomai.org

On Thu, Apr 10, 2008 at 7:52 PM, jeff koftinoff <jeffk@domain.hid> wrote:
> Gilles Chanteperdrix wrote:
>
> >
> > It looks we are wrong. The main thread stack remains allocated
> > on-demand, even though the process is mlocked. It must be some recent
> > kernel evolution
> >
>
>  Hmm.. interesting.  What is the best way to make sure all my stacks are not
> allocated on-demand?

Find attached the example I used to read the stack size of an mlocked process.

You can run it on your target to see if you get the same result as me.

Now, I suspect this on-demand allocation only exists for the main
thread stack, I will run further tests to confirm this. So, you may:
- decide not to use the main thread for real-time duties
- memset a large buffer on stack to force the kernel to commit memory.

-- 
 Gilles

