MIME-Version: 1.0
Date: Sun, 24 Jan 2016 22:35:13 -0600
Message-ID: <CA+C+_XQ=uam1BHxoQjWpp_JhC2H9owiNfzyyf8+tWBLVjyiFGg@mail.gmail.com>
From: Mathew Benson <mathew.benson@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Xenomai on qemu
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

I created a Petalinux build with the 4.0.0 kernel and Xenomai 3.0.1 from
the stable branch.  I'm running in Qemu, temporarily, until my board
arrives.  The first time it booted, it paused at:

[Xenomai] scheduling class idle registered.
[Xenomai] scheduling class rt registered.
I-pipe: head domain Xenomai registered.

for about 30 seconds.  But it eventually booted up.  As far as I can tell,
everything looked good.  The kernel self reported xenomai 3.0.1.  I
commanded a poweroff and restarted qemu.  This time it paused at the same
line but never came back.  The host CPU is pegged.

I'm fairly confident this is a qemu issue.  What is the CPU doing at that
"Head domain Xenomai registered" step?  The menuconfig menu said I had some
options enabled that were known to be incompatible with Xenomai (APM, ACPI,
etc...), but I thought I turned those all off.
