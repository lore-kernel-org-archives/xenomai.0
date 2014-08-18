Message-ID: <53F1E305.1000300@xenomai.org>
Date: Mon, 18 Aug 2014 13:27:01 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <53F12A7C.90509@ebus.com>
In-Reply-To: <53F12A7C.90509@ebus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] I-pipe patches for x86
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Doug Brunner <dbrunner@ebus.com>, Xenomai <xenomai@xenomai.org>

On 08/18/2014 12:19 AM, Doug Brunner wrote:
> Hi all,
> 
> I'm in the midst of upgrading the software stack for an embedded 
> controller based on a WinSystems PPM-LX800 (was previously Xeno 2.6.1 
> and Linux 3.2). I see there are I-pipe patches out for 3.10.32 and 3.14, 
> as well as the 3.8.13 included with Xenomai 2.6.3. This is going in a 
> road vehicle and so the priority is on stability over the security 
> offered by the newer Linux (it should only rarely be connected to a 
> network and never to the Internet.) What's your impression of the 
> stability of the newer versions vs. 3.8?
> 
> Thanks,
>      Doug Brunner

Hi Doug,

as maintainers, we try and test each version, and fix the issues we find
until delivery. So, from our point of view, they are all equally stable,
and it is difficult to answer your question. One detail however: you
will not be able to run Xenomai 2.6.3 on Linux 3.14, you will need the
upcoming Xenomai 2.6.4 for that. Xenomai 2.6.4 is expected to be
delivered in the next few weeks.

Regards.

-- 
                                                                Gilles.

