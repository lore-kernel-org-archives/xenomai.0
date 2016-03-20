Date: Sun, 20 Mar 2016 08:25:20 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160320072520.GF3345@hermes.click-hack.org>
References: <DB5PR06MB1109ECFBDA54A3B1A11457608F8E0@DB5PR06MB1109.eurprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB5PR06MB1109ECFBDA54A3B1A11457608F8E0@DB5PR06MB1109.eurprd06.prod.outlook.com>
Subject: Re: [Xenomai] Suggested approach to schedule N-RT work in kernel on
 a specific CPU core
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Alex Plits <alex_plits@radwin.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Sun, Mar 20, 2016 at 07:15:42AM +0000, Alex Plits wrote:
> Hi,
> 
> We have a requirement to schedule N-RT linux kernel specific work  (e.g. workQ) on a dedicated core from an RTDM driver running
> In Xenomai "context".
> The current RTDM API does in fact provide an API to schedule a N-RT workQ but this does not meet our needs as we need the N-RT job to run on
> A dedicated CPU. Current API implementation will run this special workQ on the CPU where the RT scheduling call occurred, so I have 2 queries we need help with -
> 
> 1.       Is there an API/example/configuration that will achieve our needs?
> 
> 2.       In case there isn't what would be the best approach to implement such a mechanism - I can think of solutions but it seems excessive:
> 
> a.       Run another Xenomai thread that has CPU affinity on the target cpu Core which will call a dedicated RTDM blocking call (e.g. IOCTL with semTake) and then the scheduling RTDM driver will release that semaphore - which will re-schedule the thread on the core we need and now it can call a N-RT IOCTL for example.
> 
> b.      Initialize a new WorkQ on I-Pipe init which will be binded on the target cpu Core only then add new RTDM api to schedule work on that WorkQ - although I'm not sure this will work as it will use the VIRQ  mechanism which will somehow need to change cores.

If the Linux kernel provides a function to do this, we could
implement a function mirroring that function in the RTDM API. Looks
simple. Am I missing something ?

-- 
					    Gilles.
https://click-hack.org

