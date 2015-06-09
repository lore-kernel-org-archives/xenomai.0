Message-ID: <DUB403-EAS557D5FDB6E75C92D3DC47981BE0@phx.gbl>
From: mobin Motallebizadeh <mobin.seven@live.com>
MIME-Version: 1.0 (1.0)
Date: Tue, 9 Jun 2015 21:01:52 +0430
References: <DUB121-W42B693A503D6EC1D2F144381BF0@phx.gbl>
 <201506081211.15597.paul_c@tuxcnc.org>
 <DUB121-W1EC856DF0BB8FC70B291281BF0@phx.gbl>
 <201506090119.30719.paul_c@tuxcnc.org>
In-Reply-To: <201506090119.30719.paul_c@tuxcnc.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Raspberry Pi 2 patch - BCM2709
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>


> On Jun 9, 2015, at 4:57 AM, Paul <paul_c@tuxcnc.org> wrote:
> 
> On Monday 08 June 2015, mobin Motallebizadeh wrote:
>>> 2) The "official" Linux support is to be found in the mach-bcm2709
> 
> Warning: I may be mistaken here, it could be the mach-bcm2835 tree. It 
> has been a while since I've done anything with the RPi kernels. Having 
> three (sub)trees for Broadcom devices is confusing...
> 
>>> tree. This is still "work in progress", but looks to be at the
>>> stage where it is usable - I've not been following developments too
>>> closely, is it in the mainline kernel yet ?
>> 
>> never heard of it! and couldn't find it on Google. can you provide
>> the link?
> 
> Google "rpi mainline" gives 46,100 hits, top of the list is: 
> http://elinux.org/RPi_Upstreaming
> 
> A little further down the list is:
> https://www.raspberrypi.org/forums/viewtopic.php?f=71&t=12504 which 
> provides a link to the mailing list where development is discussed: 
> http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel

They're all about bcm3845 and old rpi and there are ipipe patches for it.
None of them talk about rpi 2 which is from another architecture.
