Message-ID: <2ff1a98a0802110034n6481b1ceuc6bd16b45dbc14c3@domain.hid>
Date: Mon, 11 Feb 2008 09:34:03 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <47AFF92A.7080404@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <18350.7135.108901.491437@domain.hid>
	<47AFF92A.7080404@domain.hid>
Subject: Re: [Xenomai-core] [patch 0/4] Support for select-like services.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Johan Borkhuis <j.borkhuis@domain.hid>
Cc: xenomai@xenomai.org

On Mon, Feb 11, 2008 at 8:28 AM, Johan Borkhuis
<j.borkhuis@domain.hid> wrote:
> Gilles,
>
>
>  Gilles Chanteperdrix wrote:
>  > Hi,
>  >
>  > here comes a third edition of the patchset adding support for select.
>  >
>  Could you tell me against which version this patch is tested? Would it
>  work with 2.4.1, or do I need the latest version from SVN?

The patch is against trunk. We would need to rework it a bit to adapt
it to 2.4.1, but since it adds a new syscall, I do not know if it will
be backported, though adding a syscall does not really break the ABI.

-- 
                                               Gilles Chanteperdrix

