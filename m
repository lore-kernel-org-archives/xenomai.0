Message-ID: <b702f097261219e470392ab60ba6fd2d.squirrel@sourcetrek.com>
In-Reply-To: <DUB121-W2271AF72F050D09F1D570681BD0@phx.gbl>
References: <DUB121-W42B693A503D6EC1D2F144381BF0@phx.gbl>,
 <201506081211.15597.paul_c@tuxcnc.org>,
 <DUB121-W1EC856DF0BB8FC70B291281BF0@phx.gbl>,
 <201506090119.30719.paul_c@tuxcnc.org>,
 <DUB403-EAS557D5FDB6E75C92D3DC47981BE0@phx.gbl>,
 <20150609164046.GA12517@hermes.click-hack.org>,
 <20150609174138.GA17436@csclub.uwaterloo.ca>
 <DUB121-W2271AF72F050D09F1D570681BD0@phx.gbl>
Date: Wed, 10 Jun 2015 12:06:59 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Raspberry Pi 2 patch - BCM2709
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: mobin Motallebizadeh <mobin.seven@live.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>


mobin Motallebizadeh wrote:
>> From: lsorense@csclub.uwaterloo.ca
>> Date: Tue, 9 Jun 2015 13:41:38 -0400
>> To: gilles.chanteperdrix@xenomai.org
>> CC: mobin.seven@live.com; xenomai@xenomai.org
>> Subject: Re: [Xenomai] Raspberry Pi 2 patch - BCM2709
>>
>> On Tue, Jun 09, 2015 at 06:40:46PM +0200, Gilles Chanteperdrix wrote:
>> > On Tue, Jun 09, 2015 at 09:01:52PM +0430, mobin Motallebizadeh wrote:
>> > > None of them talk about rpi 2 which is from another architecture.
>> >
>> > That is simply not true. rpi2 processor has an ARM core, just like
>> rpi.
>>
>> Yes armv6 and armv7 are not different architectures, just different
>> generations, and given apparently the pheripherals of the two bcm chips,
>> they should be fairly compatible, although I suppose one being quad core
>> and having probably a different IRQ controller could cause some work to
>> need to be done (almost certainly, although it might be a standard
>> arm gic, I haven't looked at that part of the pi 2 yet, given when I got
>> one, my wife immediately took it and I haven't got to touch it since.
>> Apparently I should have gotten two.).
>>
>> --
>> Len Sorensen
>
> I've made some patches [see attachments]. I've just modified  ipipe patch
> for 3.18.12 and raspberry related patches to match RPi repo
> [https://github.com/raspberrypi/linux] which is 3.18.14 .
> the resulting kernel img boots without IPIPE and XENOMAI configs
> successfully(of course!) but with IPIPE doesn't boot.(so I haven't
> netconsole working)
> any suggestion to make it work will be appreciated.

See:
http://xenomai.org/2014/09/porting-xenomai-dual-kernel-to-a-new-arm-soc/

-- 
                    Gilles.


