MIME-Version: 1.0
Sender: mfornero@gmail.com
In-Reply-To: <53A2DC06.10005@geensyde.fr>
References: <53A2C543.8060706@geensyde.fr>
	<53A2DC06.10005@geensyde.fr>
Date: Fri, 20 Jun 2014 16:21:28 -0400
Message-ID: <CADVgf9m7nLm3RKyQus62aC6gYDK42O09ipScEqD3AfYce0e_ig@mail.gmail.com>
From: Matthew Fornero <mfornero.lists@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Fwd: Periodic high latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: thierry mallard <thierry.mallard@geensyde.fr>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, Jun 19, 2014 at 8:48 AM, thierry mallard
<thierry.mallard@geensyde.fr> wrote:
>
> Hi,
>
> I have installed xenomai 2.6.3 with a kernel 2.6.38.8 on my dell laptop
> using adeos-ipipe-2.6.38.8-x86-2.11-03.patch.
> CPU is i5-3230M.
>
>
> When running xeno latency, I get the following results.
> What can be the cause of the high latencies that I get periodically?

You may want to check whether C1E is enabled, it can cause latency
spikes with newer Intel processors. You can disable it by writing to
the MSR_POWER_CTL register (google for this).

Best Regards,

Matt

