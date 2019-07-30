Subject: Re: Building Xenomai 3 , Kernel 4 ... for BeagleBone Black
References: <CAEmXcAxMLPYufU7aYD5kBxvtQ-jr8eq6Y+uRW+Td-NWzL=sw5w@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <9a2d7001-a0d7-b87c-be89-c4cad2051273@siemens.com>
Date: Tue, 30 Jul 2019 16:22:03 +0200
MIME-Version: 1.0
In-Reply-To: <CAEmXcAxMLPYufU7aYD5kBxvtQ-jr8eq6Y+uRW+Td-NWzL=sw5w@mail.gmail.com>
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
To: danwe <daniel.wenninger92@gmail.com>, xenomai@xenomai.org

On 29.07.19 19:23, danwe via Xenomai wrote:
> Hi,
> 
> Is there any different of Building Xenomai 3 with the proper Kernel for a
> BBB to any other microcomputers/computers?
> On https://xenomai.org/documentation/xenomai-3/html/README.INSTALL/ are so
> many different examples and I do not understand what I need to do to build
> this.
> Is there any example to build Xenomai 3 and Kernel with Buildroot?

IIRC, buildroot has a Xenomai 3 package. That might be outdated a bit, but it
should be simple to build on top.

> Does flashing on SD-Card depend on building Xenomai with Kernel?
> I just need to run Xenomai 3 with the proper Kernel on a BeagleBone Black

If you only need the kernel and the userland tools on top of an existing image:
You can study how to cross-build for other archs also in our CI setup
(.travis.yml file in the source tree). That should be in line with what the doc
says about cross-building, but it's also for sure what we run on every push to git.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

