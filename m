Date: Mon, 16 Feb 2015 21:44:38 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150216204438.GH1914@hermes.click-hack.org>
References: <54E24FED.8050906@mperpetuo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54E24FED.8050906@mperpetuo.com>
Subject: Re: [Xenomai] ARMv8 (ARM64) port of Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gary Gitelson <gary@mperpetuo.com>
Cc: xenomai@xenomai.org

On Mon, Feb 16, 2015 at 12:15:41PM -0800, Gary Gitelson wrote:
> Hi,
> 
>     There is an excellent guide for porting Xenomai to other ARM-based SOCs.
> But this seems to assume that they are 32-bit ARM SOCs, based on ARMv7 or
> lower.  Is there active work, or a guide or assistance, on porting to SOCs
> based on ARMv8 architectures (specifically, in my case, the Qualcomm
> MSM8994).

No, everything needs to be done for armv8.

>  I assume that almost everything in the arch/arm portion of the
> kernel would need to exist in the arch/arm64 subtree, but I am not sure
> exactly what is involved here.
>     Any assistance, or leads on existing work, would be much appreciated.

Linaro donated an ARMv8 board, I will start working on the I-pipe
port soon, but can not promise it will be finished rapidly.

-- 
					    Gilles.

