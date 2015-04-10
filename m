Message-ID: <5527F517.1090809@galauner.de>
Date: Fri, 10 Apr 2015 18:06:47 +0200
From: Andreas Galauner <andreas@galauner.de>
MIME-Version: 1.0
References: <5527DF9B.9020304@galauner.de>
 <20150410152959.GQ20752@hermes.click-hack.org>
In-Reply-To: <20150410152959.GQ20752@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Xenomai on Linux 3.18 on Zynq
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

On 10.04.2015 17:29, Gilles Chanteperdrix wrote:
> Maybe you already tried since you tried "all kinds of things", but
> better be sure, have you tried enabling Xenomai and I-pipe debugging
> options? 

Sorry for that sloppy phrase, it's a side project and I lost track what
exactly I did over the last weekends.

I just enabled the I-pipe debugging features. I didn't know that they
are under "Kernel hacking". The Xenomai debugging features were enabled
all the time.

Sadly, I don't get any messages that may relate to my system behaviour.
Actually no messages at all except the initialization messages of i-pipe
and Xenomai.

What I forgot to mention is, that it's not a complete freeze. It seems
to me, that the system just gets horribly slow. The heartbeat LED stops
blinking and I get occasional terminal output (1-2 lines) until it stops
completely.

There seem to be three points where the kernel may hang:
1) Somewhere in the driver init phase
2) While mounting the rootfs
3) At the login prompt or idle shell

And as I said, sometimes I get a few more lines from the kernel after a
while.

One example:
> [    1.648675] mmcblk0: mmc0:b368 USD   7.46 GiB 
> [    1.654727]  mmcblk0: p1 p2
> [    1.660107] EXT3-fs (mmcblk0p2): error: couldn't mount because of unsupported optional features (240)
> [    1.670176] EXT2-fs (mmcblk0p2): error: couldn't mount because of unsupported optional features (244)
> [   64.605360] EXT4-fs (mmcblk0p2): recovery complete
> [   64.612160] EXT4-fs (mmcblk0p2): mounted filesystem with ordered data mode. Opts: (null)
> [   64.620218] VFS: Mounted root (ext4 filesystem) on device 179:2.
> [   64.635207] devtmpfs: mounted
> [   64.638469] Freeing unused kernel memory: 276K (c05f7000 - c063c000)
> INIT: version 2.88 booting
> 

- Andy

