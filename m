Date: Mon, 2 May 2016 12:05:34 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160502100534.GA22013@hermes.click-hack.org>
References: <2396B4D2166B62479FBBE370D4A7C1F30A732092@mb2010-3.intra.tut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2396B4D2166B62479FBBE370D4A7C1F30A732092@mb2010-3.intra.tut.fi>
Subject: Re: [Xenomai] rtdm_socket() error -97 for sending UDP or RAW packets
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Umair Ali <ali.umair@tut.fi>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, May 02, 2016 at 10:01:16AM +0000, Umair Ali wrote:
> 
> 
> Hello Gilles,
> 
> Thanks for the reply.
> 
> 
> ** may work from the init module, but not from a real-time thread or vice versa I am calling rtdm_socket() in init module of the kernel app.

Then maybe you should call it from a real-time thread.

> 
> Can you tell me what kind of portocls are supported by rtdm_socket()

This depends on the options you selected in RTnet configuration. If
you selected the protocol you want, but rtdm_socket fails in
kernel-space, again, looking at the sources will be your best help.

Regards.

-- 
					    Gilles.
https://click-hack.org

