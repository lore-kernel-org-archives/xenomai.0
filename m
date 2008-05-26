Message-ID: <2ff1a98a0805260313l5d99ad3ak2bf19a5e64006e2b@domain.hid>
Date: Mon, 26 May 2008 12:13:46 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <483A5FAD.40703@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <483A5FAD.40703@domain.hid>
Subject: Re: [Xenomai-help] Latency times on AT91SAM9263
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Paradoxxa <paradoxxa2001@domain.hid>
Cc: xenomai@xenomai.org

On Mon, May 26, 2008 at 8:58 AM, Paradoxxa <paradoxxa2001@domain.hid> wrote:
> Hi all,
>
> I have here a AT91SAM9263 with a 2.6.24 kernel, Xenomai 2.4.3 and Adeos
> Patch 1.9-01.
> I'm wondering if the latency times are ok. What do you think about it?
> In the attachment you can find the log files.

This looks rather good, especially since you run with a 100us latency
which is known to cause lockups on slow ARMs. The latencies I get with
the machines I have access to are rather near 250us.

> /usr/xenomai/bin/switchtest: /lib/libpthread.so.0: version `GLIBC_2.3.3' not
> found (required by /usr/xenomai/bin/switchtest)
> /usr/xenomai/bin/switchtest: /lib/libpthread.so.0: version `GLIBC_2.3.3' not
> found (required by /usr/xenomai/lib/libpthread_rt.so.1)

You are playing a dangerous game: the glibc on your test platform is
not the same as the one used by your compiler. When generating your
test platform root filesystem, you should either use the same glibc
version as the one used by your toolchain, or you should use front-end
such as ucfront, which links with the compiled glibc.


-- 
 Gilles

