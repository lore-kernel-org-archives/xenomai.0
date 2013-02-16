Message-ID: <511F797C.3010006@xenomai.org>
Date: Sat, 16 Feb 2013 13:20:12 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AB936CE5-5675-4DA5-85B2-F2DD5A88531B@mah.priv.at>
In-Reply-To: <AB936CE5-5675-4DA5-85B2-F2DD5A88531B@mah.priv.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] packaging question: no kernel dependencies?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mail17@mah.priv.at>
Cc: xenomai@xenomai.org

On 02/16/2013 08:22 AM, Michael Haberler wrote:

> I'm working to debian-package linuxcnc with Xenomai userland RT
> threads.
> 
> AFAICT building requires only the userland support package, but for
> instance not the kernel headers. The way I read
> http://www.xenomai.org/documentation/xenomai-2.6/html/README.INSTALL/#_feature_conflict_resolution
> it is safe to rely on runtime detection of feature compatibility.
> 
> goof prevention question: Is it safe to wrap such a package without
> explicit references to some kernel version?


Yes, the only thing which defines the kernel/user ABI, is the branch you
are using, so, for instance, you can keep a kernel patched with 2.6.1,
and upgrade user-space to 2.6.2.1. And you will get a runtime error if
you try running a kernel patched with 2.5.6 with a 2.6.2.1 user-space.

-- 
                                                                Gilles.

