MIME-Version: 1.0
In-Reply-To: <4FD2EB49.1030105@xenomai.org>
References: <CAGTNcBt+DrdbxnewSxFi3gJjnHKrgE_rB8OJaRvMQWe8uX8ORg@mail.gmail.com>
	<CAGTNcBsrjvd_bWx1YN=aeXgiC1B3o+Y_bsW732y=B0xnaqPkVw@mail.gmail.com>
	<4FD2EB49.1030105@xenomai.org>
Date: Sat, 9 Jun 2012 16:44:39 -0400
Message-ID: <CAGTNcBsF5rjM=zYWsHVAAmZbfhL8EsmJa29R1AuV6biaZkLUnQ@mail.gmail.com>
From: Josh Bowman <jbowman@facts-inc.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] I-pipe 2.6.38.8-x86-2.11-02 reports illicit call from
 domain Xenomai (on x86 32-bit)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

With CONFIG_KGDB disabled in the kernel config, the ipipe trace is no
longer being generated. (IPIPE_DEBUG_CONTEXT *is* still enabled.)

I haven't needed kgdb yet, and haven't learned to use it; it was
enabled in my kernel by mistake.

If you think there might still be a problem here, and there's anything
I can do to help, please let me know.

Thank you,
Josh Bowman

On Sat, Jun 9, 2012 at 2:20 AM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
>
>
> Could you try disabling kgdb support in kernel configuration?
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.

