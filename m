Subject: Re: RTnet default behavior
References: <b89e46e4-45b8-1fc1-cb0d-2c4d44b07eb7@compador.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5b5bb644-2f40-dc2b-0414-a25c35ecffbd@siemens.com>
Date: Fri, 18 Oct 2019 16:33:13 +0200
MIME-Version: 1.0
In-Reply-To: <b89e46e4-45b8-1fc1-cb0d-2c4d44b07eb7@compador.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Johannes Holtz <johannes.holtz@compador.de>, xenomai@xenomai.org

On 18.10.19 16:10, Johannes Holtz via Xenomai wrote:
> Hi ,
> 
> I inherited a project where the RTnet stack is loaded manually at boot
> time. To be specific. Instead of using the rtnet command line programs
> the rtnet.ko kernel object as well as the necessary drivers are loaded
> with insmod. The devices are then brought up with rtifconfig and rtroute.
> 
> The network consist of 7 PCs (all with the same boot time mechanism)
> with pre-defined IPs. The setup works and initializes in an
> asynchronized way (like a typical non-RT network).
> 
> I'm investigating some performance problems and I don't know whats is
> really going on since no config is used. How is determined which
> participant is acting as Master and how the slots are distributed? What
> are the default values?

You only mentioned rtifconfig and rtroute above, no rtcfg or tdmacfg.
Are you sure RTmac is involved?

> 
> Also: The RTmac readme says a slot "transmits a single packet of up to a
> specific maximum size". I like to know what that size is and what the
> behavior is when I have many much smaller datagrams queued. Will they be
> distributed over as many cycles? And also what happens if I send a
> datagram which is much bigger. Is there an MTU?

I'll be happy to explain, but we should first of all try to find out
what is configured here.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

