MIME-Version: 1.0
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Sat, 24 Apr 2021 01:05:50 -0400
Message-ID: <CALLqZ8RpaUPaMcVS4+gDsi5Dm71GtiJLKmLLDc-g_0XHP0FudQ@mail.gmail.com>
Subject: ARM jitter issues
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,
   I've tested both arm 4.19.y-cip and 5.4.y, and have found better numbers
when running the latency test.  I used a zynq-7000 board and I'm still
testing on beagleboard black.  If anyone would like to test please use the
ipipe-arm tree on the ipipe/5.4.y branch or ipipe/4.19.y-cip branch.  If
testing continues to look good I'll create a new patch sets closer to the
end of the weekend and I'll move on to resolving the jitter in ARM64.

Thanks

Greg
