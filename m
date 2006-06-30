From: Romain Lenglet <rlenglet@domain.hid>
Subject: Re: [Xenomai-core] prepare_kernel --output-patch
Date: Fri, 30 Jun 2006 18:26:06 +0900
References: <44A4D271.90006@domain.hid>
In-Reply-To: <44A4D271.90006@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606301826.06445.rlenglet@domain.hid>
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

Wolfgang Grandegger wrote:
> what is "prepare_kernel --output-patch" useful for?

It modifies the behavior of prepare_kernel, so that it does not 
modify the kernel source tree (except that it must apply the 
Adeos patch), but instead generates a patch file that has the 
same effect when applied against that Adeos-patched kernel 
source tree.

Therefore, it is useful for creating Xenomai packages for 
GNU/Linux distributions, such as packages based on dh-kpatches 
in Debian, which require to have patch files.

-- 
Romain LENGLET

