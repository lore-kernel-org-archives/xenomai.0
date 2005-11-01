From: Romain Lenglet <rlenglet@domain.hid>
Date: Tue, 1 Nov 2005 12:27:02 +0900
References: <OF8F0700EC.A1D80BF4-ONC12570AB.004AE3CB-C12570AB.005254F3@domain.hid>
	<4366708B.8010501@domain.hid>
In-Reply-To: <4366708B.8010501@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511011227.03173.rlenglet@domain.hid>
Subject: [Xenomai-core] Re: [Xenomai-help] General Xenomai / RTAI Skin Usage
	Questions
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

> - A kernel option that causes Xenomai (or Adeos) to blatantly
> malfunction or even crash is a freaking BUG, and should be
> reported asap to the Xenomai-core list or the Adeos-main list.
> IOW, there is no such thing as options allowed to crash your
> box with Adeos/Xenomai because of some "don't care attitude";
> would such bug happen, it must and will be fixed. All the
> people involved in contributing to both projects try to make
> sure that any option could be enabled without risking terminal
> damage to anyone's setup. The worst thing that should be
> allowed to happen is high latency spots, because some options
> might cause some hardware to interact badly with critical
> resources Adeos/Xenomai also happen manage.

Here is a kernel-option-related bug.
I am using a stock Debian-patched kernel with the standard Debian 
kernel config, on Pentium M and Pentium 4 machines, + the latest 
Adeos patch.
The Debian kernel configuration file, that has every option 
enabled and everything as modules, works fine with Xenomai 
except for one single option which must be disabled:
CONFIG_PCI_MSI
This option messes with the oneshot timer (timer freezes).
(thanks to Gilles to have found this out)


Otherwise, my biggest source of problems is IRQ sharing between 
realtime and non-realtime drivers: this predictably provokes 
kernel panics. But Jan seems to be working on it.

-- 
Romain Lenglet

