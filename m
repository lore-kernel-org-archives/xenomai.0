References: <574D9B03.8080706@sigmatek.at>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <fc250048-4a85-c561-d5d7-280191d0564f@xenomai.org>
Date: Tue, 31 May 2016 17:08:54 +0200
MIME-Version: 1.0
In-Reply-To: <574D9B03.8080706@sigmatek.at>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
To: wolfgang.netbal@sigmatek.at, xenomai@xenomai.org

On 05/31/2016 04:09 PM, Wolfgang Netbal wrote:
> Dear all,
> 
> we have moved our application from "XENOMAI 2.6.2.1 + Linux 3.0.43" to
> "XENOMAI 2.6.4. + Linux 3.10.53". Our target is an i.MX6DL. The system
> is now up and running and works stable. Unfortunately we see a
> difference in the performance. Our old combination (XENOMAI 2.6.2.1 +
> Linux 3.0.43) was slightly faster.
>

Could you quantify "slightly faster"? This is a dual kernel system, so
changes on either the regular kernel side and/or the co-kernel side may
have a measurable impact.

> At the moment it looks like that XENOMAI 2.6.4 calls
> xnpod_schedule_handler much more often then XENOMAI 2.6.2.1 in our old
> system.  Every call of xnpod_schedule_handler interrupts our main
> XENOMAI task with priority = 95.

That handler is attached to the inter-processor interrupt used for
rescheduling tasks running on a remote CPU. You may want to check the
CPU affinity settings of your tasks, and the way they interact/synchronize.

-- 
Philippe.

