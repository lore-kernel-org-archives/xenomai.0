Date: Tue, 26 Jan 2016 22:21:34 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160126212134.GD9298@hermes.click-hack.org>
References: <CA+C+_XQ=uam1BHxoQjWpp_JhC2H9owiNfzyyf8+tWBLVjyiFGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+C+_XQ=uam1BHxoQjWpp_JhC2H9owiNfzyyf8+tWBLVjyiFGg@mail.gmail.com>
Subject: Re: [Xenomai] Xenomai on qemu
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mathew Benson <mathew.benson@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Sun, Jan 24, 2016 at 10:35:13PM -0600, Mathew Benson wrote:
> I created a Petalinux build with the 4.0.0 kernel and Xenomai 3.0.1 from
> the stable branch.  I'm running in Qemu, temporarily, until my board
> arrives.  The first time it booted, it paused at:
> 
> [Xenomai] scheduling class idle registered.
> [Xenomai] scheduling class rt registered.
> I-pipe: head domain Xenomai registered.
> 
> for about 30 seconds.  But it eventually booted up.  As far as I can tell,
> everything looked good.  The kernel self reported xenomai 3.0.1.  I
> commanded a poweroff and restarted qemu.  This time it paused at the same
> line but never came back.  The host CPU is pegged.
> 
> I'm fairly confident this is a qemu issue.  What is the CPU doing at that
> "Head domain Xenomai registered" step?  The menuconfig menu said I had some
> options enabled that were known to be incompatible with Xenomai (APM, ACPI,
> etc...), but I thought I turned those all off.

If you have CONFIG_NO_HZ enabled, disable it. This will be fixed in
the next version of Xenomai.

-- 
					    Gilles.
https://click-hack.org

