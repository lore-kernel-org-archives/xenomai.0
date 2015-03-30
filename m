Date: Mon, 30 Mar 2015 17:28:52 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150330152852.GM32766@hermes.click-hack.org>
References: <CACreCVKgzpDYUbMu2ihYtHxV5CSma-eNaH57u-CvCWmKbkoU=Q@mail.gmail.com>
 <20150328185913.GN25831@hermes.click-hack.org>
 <CACreCV+ddKJz6vq4vmb6b+Jd6kxrpbDTXUDyfoQ9WNk48w3u1Q@mail.gmail.com>
 <20150329110623.GB32766@hermes.click-hack.org>
 <CACreCVKG=6AEGF9BVBraHgQ8N=PwqD-6=kzfvinSpU+BBHtpng@mail.gmail.com>
 <20150329120218.GE32766@hermes.click-hack.org>
 <CACreCVLmJAa_hLLVQsiKYLks-4Ev=uAVw=5DFOZ+EL_DZ2VuPA@mail.gmail.com>
 <20150329124445.GH32766@hermes.click-hack.org>
 <CACreCV+Uke5rmAQ+2DXcJN-kHGmz-iwf39qDVhd8F_UwvDScdg@mail.gmail.com>
 <CACreCV+zCm_kLA27iLUmTLZifL72=ucna=6jrLMo_4dRb3gsjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACreCV+zCm_kLA27iLUmTLZifL72=ucna=6jrLMo_4dRb3gsjg@mail.gmail.com>
Subject: Re: [Xenomai] Boot failure when CONFIG_XENOMAI is enabled
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: GP Orcullo <kinsamanka@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, Mar 30, 2015 at 11:21:57PM +0800, GP Orcullo wrote:
> +u32 __cpu_reverse_map[NR_CPUS] = { [0 ... NR_CPUS-1] = MPIDR_INVALID };

This is wrong. You want u32 *__cpu_reverse_map then kmalloc a big
enough reverse map.

-- 
					    Gilles.

