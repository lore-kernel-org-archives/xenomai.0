Subject: Re: [Xenomai-core] [PATCH] adeos-ipipe-2.6.17-i386-1.3.05
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <449556F4.2010907@domain.hid>
References: <449556F4.2010907@domain.hid>
Content-Type: text/plain
Date: Tue, 20 Jun 2006 17:02:34 +0200
Message-Id: <1150815755.4386.54.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Sun, 2006-06-18 at 15:36 +0200, Jan Kiszka wrote:
> Hi,
> 
> this is a rebased i386 ipipe patch for the new 2.6.17 kernel.
> 
> Again it was just about applying some failing hunks manually (and
> checking if that was legal). I also included my last two kgdb-over-ipipe
> patches, but they are of limited use as long as no kgdb is publicly
> available for the new kernel.
> 
> All is working fine so far. This mail was, e.g., posted from a Xenomai
> box running the patch, switchtest, and latency.

Tested here UP+SMP and committed. This will be part of the upcoming
-rc3. Thanks.

-- 
Philippe.



