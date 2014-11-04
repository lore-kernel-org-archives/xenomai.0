Resent-Message-ID: <20141104170535.GC19069@sisyphus.hd.free.fr>
Resent-To: xenomai@xenomai.org
Date: Tue, 4 Nov 2014 18:01:09 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141104170109.GB19069@sisyphus.hd.free.fr>
References: <297545433.13742.1415102393951.JavaMail.zimbra@wandercraft.eu>
 <20141104133014.GA16558@sisyphus.hd.free.fr>
 <1796749714.14336.1415110429589.JavaMail.zimbra@wandercraft.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1796749714.14336.1415110429589.JavaMail.zimbra@wandercraft.eu>
Subject: Re: [Xenomai] Serial realtime communication
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Huy Cong Vu <huy-cong.vu@wandercraft.eu>
Cc: xenomai@xenomai.org

On Tue, Nov 04, 2014 at 03:13:49PM +0100, Huy Cong Vu wrote:
> So in order to use my usb device (which I guess is non real-time,
> or perhaps there is a ways to check it?)

A device is not real-time or not real-time. A driver is. If your
device is using a Linux driver, then the driver is not real-time. If
your device is using a Xenomai driver, then the driver is real-time.

> in real-time, I have to instantiate an RTDM driver based on my
> device, and then after, perhaps it is possible to use functions in
> RTDM lib with that virtual device to manipulate the communication?

An RTDM device is no more virtual than a Linux device. The
difference is the libraries you use to access it. If you use xenomai
libraries, then you can access rtdm devices.

> 
> And as far as I know, it seems difficult to find a lib (or a
> driver) that supports serial connection in real-time...

Where did you get that idea? Xenomai sources contain drivers for
several serial ports. People contribute them as they need them.

The most commonly used being the one you find in PCs, documented
here:
http://xenomai.org/serial-16550a-driver/

Please do not forget to CC the mailing list.

-- 
					    Gilles.

