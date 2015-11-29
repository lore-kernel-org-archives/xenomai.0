References: <CAK4EZFT_wVtDGhQe+ZdgJTL2nVoqykBM5J4T0=Fw8iijGZ1G4Q@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <565B3EB8.8040807@xenomai.org>
Date: Sun, 29 Nov 2015 19:06:48 +0100
MIME-Version: 1.0
In-Reply-To: <CAK4EZFT_wVtDGhQe+ZdgJTL2nVoqykBM5J4T0=Fw8iijGZ1G4Q@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Raspberry Pi Real-Time Firmware Issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Adam Vaughan <vaughana@umich.edu>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 11/28/2015 11:38 PM, Adam Vaughan wrote:
> Hello,
> 
> I've seen a fair amount of Raspberry Pi related discussion on this mailing
> list lately, so I thought I'd mention that a real-time latency issue was
> fixed in the recent firmware ed611df.
> 
> The issue caused disable_pvt not to work on both the RPi 1 and 2 since the
> October 6th, 2014 firmware release.  Without disable_pvt, the chip will
> stall for ~16 microseconds every half second.
> 
> A description is available here:
> 
> https://github.com/raspberrypi/firmware/issues/497

The troubleshooting guide has been updated to include this information:
http://xenomai.org/troubleshooting-a-dual-kernel-configuration/#the_latency_test_shows_high_latencies

Thanks for the hint,

-- 
Philippe.

