Date: Tue, 2 Dec 2014 13:17:20 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141202121720.GK2076@hermes>
References: <314E5ECDAA86314791309FA670550F89C9C51961@SINTEFEXMBX05.sintef.no>
 <20141202093346.GE2076@hermes>
 <314E5ECDAA86314791309FA670550F89C9C519EE@SINTEFEXMBX05.sintef.no>
 <20141202095707.GG2076@hermes>
 <314E5ECDAA86314791309FA670550F89C9C51AB4@SINTEFEXMBX05.sintef.no>
 <20141202105344.GH2076@hermes>
 <314E5ECDAA86314791309FA670550F89C9C51CF0@SINTEFEXMBX05.sintef.no>
 <20141202121320.GI2076@hermes>
 <314E5ECDAA86314791309FA670550F89C9C51D31@SINTEFEXMBX05.sintef.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <314E5ECDAA86314791309FA670550F89C9C51D31@SINTEFEXMBX05.sintef.no>
Subject: Re: [Xenomai] IRQ155 not handled. Disabling IRQ line
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Terje =?utf-8?Q?Fr=C3=B8ysa?= <Terje.Froysa@sintef.no>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, Dec 02, 2014 at 12:16:08PM +0000, Terje Frøysa wrote:
> No, not as far as I can tell.
> I have tried to find out how to tell. The only clue I get from the web is to check the 
> /proc/interrupts
> /proc/xenomai/irq
> The interrupt exists only once in the /proc/xenomai/irq.
> 
> Are there other means to check this?

That is the way, yes.

Could you post the code of the irq handler you pass to
rtdm_irq_request ?

-- 
					    Gilles.

