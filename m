References: <1504766189.59b0e8edb9f7a@mail.inbox.lv>
 <ae84bec2-afdb-3cf0-031c-b8db97387f59@xenomai.org>
 <1504779380.59b11c7427039@mail.inbox.lv>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <49358bd0-9902-ded1-8aa8-f2e91c73980f@xenomai.org>
Date: Fri, 8 Sep 2017 11:05:45 +0200
MIME-Version: 1.0
In-Reply-To: <1504779380.59b11c7427039@mail.inbox.lv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Application command line arguments(parameters)
 reordering problem
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Andris <andrlv@inbox.lv>
Cc: xenomai@xenomai.org

On 09/07/2017 12:16 PM, Andris wrote:
> Thanks!
> But this patch resolve problem only if all command line arguments starts
> with "--", but if command line is with mixed arguments, for example:
> ./app -p 250 --enable-feature 1
> then the problem still exist.

Just checked, it does not here. Are you sure?

> I'm playing with Intel DPDK and Xenomai and I would like to pass command
> line arguments directly to DPDK. DPDK expect to get command line in
> following format:
> <eal options> -- <application specific options>
> for example:
> ./app -l 0-3 -n 3 -- -p 0x1 -q 1
>  

There is still an issue with this form though, since the double-dash
separator moves at the head of the vector.

-- 
Philippe.

