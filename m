MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Date: Tue, 10 Feb 2015 16:04:51 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
In-Reply-To: <loom.20150210T153230-142@post.gmane.org>
References: <CAEMXjGxixe5fgX-7uijpcGkNoPzoZcocJxEK-D+VqBdopx4puQ@mail.gmail.com>
 <loom.20150210T153230-142@post.gmane.org>
Message-ID: <421c45d170f050857f0863b592dc2faa@grandegger.com>
Subject: Re: [Xenomai] Bosch CCAN/DCAN driver for RTDM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Alfred Koegel <akoegel@gmx.de>

Hi Steve,

On Tue, 10 Feb 2015 14:38:32 +0000 (UTC), Alfred Koegel <akoegel@gmx.de>
wrote:
> Steve B <sbattazzo <at> gmail.com> writes:
> 
>> 
>> Hello,
>> I have put together a quick port of the Linux driver for CCAN/DCAN to
>> work
>> with RTDM, thanks to Wolfgang Grandegger's Flexcan driver port as an
>> example.
>> 
>> It's not thoroughly/formally tested, but it works with rtcansend and
>> rtcanrecv, and works well with my application sending and receiving a
few
>> hundred frames per second at 500k baud, which I think is a good enough
>> initial test for me.
>> I can also give the "rtt" test a shot when I have time.
>> 
>> Is there anyone out there who would like to test this? I am wondering
>> what
>> is the procedure to submit, should I create a patch and attach? I
haven't
>> looked at how to add it into the kernel build process, I have just
built
>> it
>> in its own separate place so far.

Unfortunately I don't have hardware at hand to test the driver but I could
assist in getting it included into:

"http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/drivers/can/c_can"

With a proper Kconfig it should automatically be visible to the kernel and
the kernel could then be built as usual. Therefore a patch for the Xenomai
tree would be nice but as a first step don't hesitate to just send you
current version.

Thanks,

Wolfgang.


