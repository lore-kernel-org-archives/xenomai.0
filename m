Message-ID: <a015128a-fba4-02a2-984b-809cd7452c8a@siemens.com>
Date: Thu, 13 Jan 2022 18:47:10 +0100
MIME-Version: 1.0
Subject: Re: Cobalt over dovetail implementation status
Content-Language: en-US
References: <CAMMcbao8aCNnDqfQXBzRCKJD31eMX_rcsPymA+pgRRG6xTHCog@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAMMcbao8aCNnDqfQXBzRCKJD31eMX_rcsPymA+pgRRG6xTHCog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Arturo Laurenzi <arturo.laurenzi@gmail.com>, xenomai@xenomai.org

On 13.01.22 16:30, Arturo Laurenzi via Xenomai wrote:
> Hi all,
> in our lab we're relying on Xenomai 3.1 + RTnet in order to control our
> robotic platforms, which are seen as a network of EtherCat slaves.
> I'd like to know more about the implementation status of Xenomai (cobalt)
> over Dovetail, which to my understanding will be the only way to use > 5.4
> kernel versions.
> 
> We mostly use the Posix API (thread, mutex, condvar), timers, IDDP, XDDP,
> shared memory, and RTnet.
> 
> Is Dovetail already feature-complete w.r.t. Ipipe?
> 

Practically, yes. We are using it just like I-pipe since the 3.2 release 
of Xenomai.

> Is RTnet available?

Yes.

> 
> How to migrate from an Ipipe kernel .config to a Dovetail counterpart?

CONFIG_DOVETAIL=y - you can basically see this in our CI setups 
(including xenomai-images) that are even able to handle both variants 
(depending on the kernel version) with a single config.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

