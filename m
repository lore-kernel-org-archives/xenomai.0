Date: Tue, 31 May 2016 16:16:46 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160531141646.GG5951@hermes.click-hack.org>
References: <574D9B03.8080706@sigmatek.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <574D9B03.8080706@sigmatek.at>
Subject: Re: [Xenomai] Performance impact after switching from 2.6.2.1 to
 2.6.4
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Netbal <wolfgang.netbal@sigmatek.at>
Cc: xenomai@xenomai.org

On Tue, May 31, 2016 at 04:09:07PM +0200, Wolfgang Netbal wrote:
> Dear all,
> 
> we have moved our application from "XENOMAI 2.6.2.1 + Linux 3.0.43" to 
> "XENOMAI 2.6.4. + Linux 3.10.53". Our target is an i.MX6DL. The system 
> is now up and running and works stable. Unfortunately we see a 
> difference in the performance. Our old combination (XENOMAI 2.6.2.1 + 
> Linux 3.0.43) was slightly faster.
> 
> At the moment it looks like that XENOMAI 2.6.4 calls 
> xnpod_schedule_handler much more often then XENOMAI 2.6.2.1 in our old 
> system.  Every call of xnpod_schedule_handler interrupts our main 
> XENOMAI task with priority = 95.
> 
> I have compared the configuration of both XENOMAI versions but did not 
> found any difference. I checked the source code (new commits) but did 
> also not find a solution.

Have you tried Xenomai 2.6.4 with Linux 3.0.43 ? In order to see
whether it comes from the kernel update or the Xenomai udpate?

-- 
					    Gilles.
https://click-hack.org

