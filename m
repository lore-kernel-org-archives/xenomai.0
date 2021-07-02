Subject: Re: cyclictest + cobalt
References: <CAB9YM8jh8oB9JR8+08CPtaQ8e8ViEqKS2gvgeNgXpdU7coBzug@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <abe74d70-b918-670b-b603-68914f682150@siemens.com>
Date: Fri, 2 Jul 2021 08:23:46 +0200
MIME-Version: 1.0
In-Reply-To: <CAB9YM8jh8oB9JR8+08CPtaQ8e8ViEqKS2gvgeNgXpdU7coBzug@mail.gmail.com>
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
To: Rui Queiroz <rqueiroz@dei.uc.pt>, xenomai@xenomai.org

On 01.07.21 16:23, Rui Queiroz via Xenomai wrote:
> Hi,
> 
> I have no experience with Xenomai and I was wondering if someone could
> clarify if cyclictest is included in Xenomai 3.1?
> Here [1] says "cyclictest is part of the Xenomai test suite..." but I could
> not confirm it.
> 
> If I simply install the rt-tests package and run cyclictest will it take
> advantage of the cobalt "kernel" by default or do I need to preform some
> extra steps (activate a posix skin etc)
> 
> Thank you
> 
> 
> [1] http://manpages.ubuntu.com/manpages/groovy/en/man1/cyclictest.1.html
> 

Xenomai carries a slight adjusted but likely significantly outdated
version of cyclictest in-tree [2], primarily for demonstration purposes.
The "official" test is called "latency" [3], and that one is also part
of our regular testsuite.

Jan

[2]
https://source.denx.de/Xenomai/xenomai/-/tree/master/demo/posix/cyclictest
[3] https://source.denx.de/Xenomai/xenomai/-/tree/master/testsuite/latency

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

