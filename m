Message-ID: <5a36acc4.08db240a.80186.2e7c@mx.google.com>
Date: Sun, 17 Dec 2017 12:43:28 -0500
From: Greg Gallagher <greg@embeddedgreg.com>
In-Reply-To: <CO2PR07MB2533556D28F1EABA8A58E7B3A9090@CO2PR07MB2533.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: Re: [Xenomai] Xenomai on Arm64
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?5Y2a6K+aIOS9mQ==?= <yubocheng@live.cn>, "xenomai@xenomai.org" <xenomai@xenomai.org>


   Hi,
     So the best approach here would be to try to use a patch that is
   close to 4.4.15. Apply the ipipe patches and you'll have to resolve to
   conflicts by hand. I'm not sure how many conflicts you'll find.
   Thanks
   Greg

   From: yubocheng@live.cn
   Sent: December 17, 2017 12:22 PM
   To: greg@embeddedgreg.com; xenomai@xenomai.org
   Subject: Re: [Xenomai] Xenomai on Arm64

   Hi Greg,
   I'm using L4T. The feedback from 'uname -r' is:
   4.4.15-tegra
   Would that be a problem?
   Thank you!
   Bocheng Yu
     __________________________________________________________________

   From: Greg Gallagher <[1]greg@embeddedgreg.com>
   Sent: Sunday, December 17, 2017 10:24
   To: ?? ?; [2]xenomai@xenomai.org
   Subject: Re: [Xenomai] Xenomai on Arm64

   What kernel are you using L4T or mainline?
   Sent from my BlackBerry - the most secure mobile device - via the
   Rogers Network
     Original Message
   From: [3]YuBocheng@live.cn
   Sent: December 17, 2017 9:44 AM
   To: [4]xenomai@xenomai.org
   Subject: [Xenomai] Xenomai on Arm64
   Hi,
   I'm trying to patch Xenomai on Nvidia TX2, an Arm64 processor. When I
   used Xenomai 3.0.5 and [5]ipipe-core-4.9.24-arm64-2.patch, I was not
   allowed config the kernel. As I understood, this is because Xenomai
   3.0.5 doesn't fully support Arm64 (/kernel/cobalt/arch/arm64 is empty).
   So I was wondering which versions of Xenomai and ipipe I should use?
   Stable release or versions under development?
   Thank you!
   Bocheng Yu
   _______________________________________________
   Xenomai mailing list
   [6]Xenomai@xenomai.org
   [7]https://xenomai.org/mailman/listinfo/xenomai

References

   1. mailto:greg@embeddedgreg.com
   2. mailto:xenomai@xenomai.org
   3. mailto:YuBocheng@live.cn
   4. mailto:xenomai@xenomai.org
   5. http://ipipe-core-4.9.24-arm64-2.patch/
   6. mailto:Xenomai@xenomai.org
   7. https://xenomai.org/mailman/listinfo/xenomai
