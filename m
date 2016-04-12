Date: Tue, 12 Apr 2016 12:57:12 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160412105712.GG8694@hermes.click-hack.org>
References: <CABprWpketiup8jSBhmbhO3vJ2PzOtj0uuOG8J6_eFkMJiUUeDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABprWpketiup8jSBhmbhO3vJ2PzOtj0uuOG8J6_eFkMJiUUeDg@mail.gmail.com>
Subject: Re: [Xenomai] IPIPE_LOCK Problem
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Varun Deshpande <varun9485@gmail.com>
Cc: xenomai@xenomai.org

On Tue, Apr 12, 2016 at 11:55:15AM +0200, Varun Deshpande wrote:
> Hello all,
> 
> I am trying to compile Xenomai 3.0.2 with Kernel 4.1.18. I am running a
> 32bit Ubuntu(14.04.04). I configured the kernel and changed the following
> options
> 
> 1) Enable loadable module support  →   Forced module loading (Press Y)
> 2) Enable loadable module support  →   Forced module unloading (Press Y)
> 3) Xenomai/cobalt   →  Drivers  →   RTnet  →   Protocol Stack  →  RTmac
> Layer  →   NoMAC discipline for RTmac (Press M)
> 4) Xenomai/cobalt   →  Drivers  →   RTnet  →   Drivers  →  (For All
> requried Drivers Press M){Exclude Others by pressing N)
> 5) Xenomai/cobalt   →  Drivers  →   RTnet  →  Add­Ons  → Real­Time
> Capturing Support (Press M)
> 6) Power management and ACPI options  →  ACPI (Advanced Configuration &
> Power Interface)Support  →  Processor(Press N)
> 7) Power management and ACPI options  →  APM (Advanced Power Management)
> BIOS support (Press N)
> 8) Power management and ACPI options  →   CPU Frequency scaling   →CPU
> Frequency scaling (Press N)
> 9) Power management and ACPI options  →  CPU Idle  →  CPU idle PM support
> (Press N)
> 10) Networking support  →  Networking Options  →  Timestamping in
> PHYdevices (Press Y)
> 11) Device Drivers  →  Input device support  →  Miscellaneous devices→   PC
> Speaker support (Press N)
> 12) Device Drivers  →  Staging Drivers  (Press N)
> 13) Processor type and features -->  Continuous Memory Allocator (Press N)
> 14) Processor type and features --> Transparent Huge Page Support (Press N)
> 15) Processor type and features --> Allow for memory compaction (Press N)
> 16) Processor type and features --> Page Migration (Press N)

The missing key information here is the resulting kernel
configuration. You likely have some option enabled that none of our
build or run tests enables.

-- 
					    Gilles.
https://click-hack.org

