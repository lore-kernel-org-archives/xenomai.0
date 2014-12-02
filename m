Date: Tue, 2 Dec 2014 10:33:46 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141202093346.GE2076@hermes>
References: <314E5ECDAA86314791309FA670550F89C9C51961@SINTEFEXMBX05.sintef.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <314E5ECDAA86314791309FA670550F89C9C51961@SINTEFEXMBX05.sintef.no>
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

On Tue, Dec 02, 2014 at 09:28:37AM +0000, Terje Frøysa wrote:
> Dear forum,
> 
> Question:
> If a driver is deemed buggy and the IRQ disabled, why is it still serving the interrupts?
> 
> Running Debian 3.8.13-bone67 and Xenomai 2.6.4
> 
> At opening call, my GPIO RTDM IRQ driver enables a GPIO line w/irq.
> My user-space program issues read-requests to receive a time-stamp for each irq.
> The irq handler is very compact. It only reads the system time, rises a semaphore if not already up and returns RT_INTR_HANDLED.
> 
> When starting (open + loop w/reads),  the dmesg log-message appears:  "IRQ155 not handled. Disabling IRQ line".
> It appears only once in the start.
> Never-the-less, the interrupts are still handled and keep coming.

Well, probably because the code re-enables the irq line ?

-- 
					    Gilles.

