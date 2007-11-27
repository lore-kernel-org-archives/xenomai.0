Message-ID: <2ff1a98a0711270904h43f3e02eqf955e9b3cebc9957@domain.hid>
Date: Tue, 27 Nov 2007 18:04:21 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <e4ef24880711270901w3c1b0lde2fd40dd5bffd2f@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5a4b7020711270211i9c996a8l25ba908cac47ae5b@domain.hid>
	<2ff1a98a0711270604n4abf25bdg6237ad5971c71959@domain.hid>
	<e4ef24880711270901w3c1b0lde2fd40dd5bffd2f@domain.hid>
Subject: Re: [Xenomai-help] kernel panic - not syncing: VFS unable to mount
	root fs on unknown-block(0, 0) and mkinitrd
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Rob Gubler <rgubler@domain.hid>
Cc: xenomai@xenomai.org

On Nov 27, 2007 6:01 PM, Rob Gubler <rgubler@domain.hid> wrote:
> Oh, thats good to know.  I didn't realize that.  I thought some
> configurations, like with certain SCSI controllers *required* initrd to do
> some pre-configuration before loading the root device.  Thanks for the info.

The only case I have seen where using an initrd is mandatory is when
using LVM with the root filesystem on a logical volume: some
user-space tools need to be run to configure the volumes, so they must
run from an initrd.

-- 
                                               Gilles Chanteperdrix

