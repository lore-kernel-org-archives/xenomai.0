Message-ID: <54D9140E.20109@xenomai.org>
Date: Mon, 09 Feb 2015 21:09:50 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAEMXjGxixe5fgX-7uijpcGkNoPzoZcocJxEK-D+VqBdopx4puQ@mail.gmail.com>
In-Reply-To: <CAEMXjGxixe5fgX-7uijpcGkNoPzoZcocJxEK-D+VqBdopx4puQ@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Bosch CCAN/DCAN driver for RTDM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Steve B <sbattazzo@gmail.com>, xenomai <xenomai@xenomai.org>

On 02/09/2015 06:42 PM, Steve B wrote:
> Hello,
> I have put together a quick port of the Linux driver for CCAN/DCAN to work
> with RTDM, thanks to Wolfgang Grandegger's Flexcan driver port as an
> example.
> 
> It's not thoroughly/formally tested, but it works with rtcansend and
> rtcanrecv, and works well with my application sending and receiving a few
> hundred frames per second at 500k baud, which I think is a good enough
> initial test for me.
> I can also give the "rtt" test a shot when I have time.
> 
> Is there anyone out there who would like to test this? I am wondering what
> is the procedure to submit, should I create a patch and attach? I haven't
> looked at how to add it into the kernel build process, I have just built it
> in its own separate place so far.
> 

Posting the patch to this list is fine.

-- 
Philippe.

