Message-ID: <49D09863.9080008@domain.hid>
Date: Mon, 30 Mar 2009 12:01:07 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20090330061745.D3E7A90005@domain.hid>
In-Reply-To: <20090330061745.D3E7A90005@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Unable to use Xenomai-Services on ARM/S3C2410
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: p.vonbrunn@domain.hid
Cc: xenomai@xenomai.org

p.vonbrunn@domain.hid wrote:
> The problem with updating the kernel is the platform-specific patch
> (additional devices etc.), which is very huge and only available for
> 2.6.19. The latency-test doesn't seem to run: Illegal Instruction is the
> output I get. Did I miss anything?

I do not intend to spend time on bugs which have already been fixed.

And nobody asks you to port your whole board-specific support to 2.6.28
to just run latency. You only need support for serial port, and maybe
ethernet driver if you intend to run the test over NFS.

Now, the only two bugs which come to my mind are:
- EABI setting
- gcc version (you can only use gcc up to 4.1 with this revision of
xenomai).

Also note that nowadays, maintaining forks of the Linux kernel for
specific boards is considered a bad way of getting linux to support your
board, one reason being precisely the one you invoke: upgrading becomes
difficult.
See http://lwn.net/Articles/230831/

-- 
                                                 Gilles.

