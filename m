MIME-Version: 1.0
In-Reply-To: <4DF72535.8010700@domain.hid>
References: <BANLkTi=4KnpNyzx73XqHErLT9_5bQWHnHg@domain.hid>
	<4DF723D2.5080200@domain.hid> <4DF72535.8010700@domain.hid>
Date: Tue, 14 Jun 2011 18:19:49 +0800
Message-ID: <BANLkTi=2KAgzwrb-CZMYNHadUOU1Mi75Ew@domain.hid>
From: AKS <aungkyas@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Adeos-main] xenomai-runtime package for Ubuntu (can we get
 2.6.38 hard real time kernel with it?)
Reply-To: aungkyas@domain.hid
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main@gna.org

Hi Jan and Alex

Thanks for the pointers and appreciated. Cheers!

On 6/14/11, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> On 2011-06-14 11:03, Alexey Galakhov wrote:
>>> My other question is that can I compile a 2.6.38 kernel, drivers and
>>> rootfile
>>> system with Ubuntu Natty, since that patch and xenomai-runtime do not
>>> limit the kernel number. Can it be possible to build an Ubuntu with
>>> 2.6.38
>>> real time kernel based on Xenomai. I will be glad if anyone can kindly
>>> share
>>> or point me to documentation for xenomai-runtime. Thanks!
>>
>> Maybe. You have to have an ipipe patch for this kernel version. If you
>> don't have one. you may use git version of ipipe and patch the kernel by
>> hand. It is much more complex but doable.
>
> No need to patch if you clone the ipipe git:
>
> git://git.denx.de/ipipe-2.6.git ipipe-2.6.38-x86
>
> Some pending x86 fixes are in
>
> git://git.kiszka.org/ipipe.git queues/2.6.38-x86
>
> Just run prepare-kernel against such a checked out tree.
>
> Jan
>
> --
> Siemens AG, Corporate Technology, CT T DE IT 1
> Corporate Competence Center Embedded Linux
>

