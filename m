Message-ID: <4DF72535.8010700@domain.hid>
Date: Tue, 14 Jun 2011 11:09:09 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <BANLkTi=4KnpNyzx73XqHErLT9_5bQWHnHg@domain.hid>
	<4DF723D2.5080200@domain.hid>
In-Reply-To: <4DF723D2.5080200@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] xenomai-runtime package for Ubuntu (can we get
 2.6.38 hard real time kernel with it?)
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: AKS <aungkyas@domain.hid>, Alexey Galakhov <agalakhov@domain.hid>
Cc: adeos-main@gna.org

On 2011-06-14 11:03, Alexey Galakhov wrote:
>> My other question is that can I compile a 2.6.38 kernel, drivers and rootfile
>> system with Ubuntu Natty, since that patch and xenomai-runtime do not
>> limit the kernel number. Can it be possible to build an Ubuntu with 2.6.38
>> real time kernel based on Xenomai. I will be glad if anyone can kindly share
>> or point me to documentation for xenomai-runtime. Thanks!
> 
> Maybe. You have to have an ipipe patch for this kernel version. If you
> don't have one. you may use git version of ipipe and patch the kernel by
> hand. It is much more complex but doable.

No need to patch if you clone the ipipe git:

git://git.denx.de/ipipe-2.6.git ipipe-2.6.38-x86

Some pending x86 fixes are in

git://git.kiszka.org/ipipe.git queues/2.6.38-x86

Just run prepare-kernel against such a checked out tree.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

