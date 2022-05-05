From: "Grau, Gunter" <gunter.grau@philips.com>
Subject: RE: Can't compile userspace application with compiler switch
 -std=c++11 and Xenomai 3.2
Date: Thu, 5 May 2022 15:51:57 +0000
Message-ID: <AM7P122MB02296A38B8F29412DE82C82CF2C29@AM7P122MB0229.EURP122.PROD.OUTLOOK.COM>
References: <AM7P122MB022978CBCF4698031D9E1F33F2C29@AM7P122MB0229.EURP122.PROD.OUTLOOK.COM>
In-Reply-To: <AM7P122MB022978CBCF4698031D9E1F33F2C29@AM7P122MB0229.EURP122.PROD.OUTLOOK.COM>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

> -----Original Message-----
> From: Xenomai <xenomai-bounces@xenomai.org> On Behalf Of Grau,
> Gunter via Xenomai
> Sent: Donnerstag, 5. Mai 2022 16:57
> To: xenomai@xenomai.org
> Subject: Can't compile userspace application with compiler switch -std=3D=
c++11
> and Xenomai 3.2
>
> Caution: This e-mail originated from outside of Philips, be careful for
> phishing.
>
>
> Hi,
>
> We are trying to port our application to Xenomai 3.2.
> The source is c++ and we use in some parts C++11 elements. Therefore the
> compile switch is set to -std=3Dc++11.
> When now compiling with this option we see following output when using
> Xenomai 3.2:
>
> In file included from /home/delphi/sw/oss/IntelliVue-OSS-R18-
> FEATUREBUILD-5.4-Kernel-88/sdk-iv-monitor/target-
> sysroot/usr/xenomai/include/cobalt/semaphore.h:24,
>                  from /home/delphi/sw/oss/IntelliVue-OSS-R18-FEATUREBUILD=
-5.4-
> Kernel-88/sdk-iv-monitor/target-
> sysroot/usr/xenomai/include/cobalt/sys/cobalt.h:25,
>                  from /home/delphi/sw/oss/IntelliVue-OSS-R18-FEATUREBUILD=
-5.4-
> Kernel-88/sdk-iv-monitor/target-
> sysroot/usr/xenomai/include/copperplate/clockobj.h:113,
>                  from /home/delphi/sw/oss/IntelliVue-OSS-R18-FEATUREBUILD=
-5.4-
> Kernel-88/sdk-iv-monitor/target-
> sysroot/usr/xenomai/include/alchemy/timer.h:22,
>                  from /home/delphi/sw/oss/IntelliVue-OSS-R18-FEATUREBUILD=
-5.4-
> Kernel-88/sdk-iv-monitor/target-
> sysroot/usr/xenomai/include/alchemy/heap.h:22,
>                  from ../PROG/Test.cpp:39:
> /target-sysroot/usr/xenomai/include/cobalt/uapi/kernel/urw.h: In function
> 'void __try_read_start(const urw_t*, urwstate_t*)':
> /target-sysroot/usr/xenomai/include/cobalt/uapi/kernel/urw.h:57:19: error=
:
> expected primary-expression before 'volatile'
>  #define READ_ONCE ACCESS_ONCE
>                    ^~~~~~~~~~~
> /target-sysroot/usr/xenomai/include/cobalt/uapi/kernel/urw.h:64:10: note:
> in expansion of macro 'READ_ONCE'
>   token =3D READ_ONCE(urw->sequence);
>           ^~~~~~~~~
> /target-sysroot/usr/xenomai/include/cobalt/uapi/kernel/urw.h:57:19: error=
:
> expected ')' before 'volatile'
>  #define READ_ONCE ACCESS_ONCE
>                    ^~~~~~~~~~~
> /target-sysroot/usr/xenomai/include/cobalt/uapi/kernel/urw.h:64:10: note:
> in expansion of macro 'READ_ONCE'
>   token =3D READ_ONCE(urw->sequence);
>           ^~~~~~~~~
>
> This worked with Xenomai 3.1.
> It looks like the issue is related to the usage of "typeof" in the ACCESS=
_ONCE
> macro. This seems not to be allowed if you use -std option:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgcc.g
> nu.org%2Fonlinedocs%2Fgcc%2FAlternate-Keywords.html%23Alternate-
> Keywords&amp;data=3D04%7C01%7C%7C1dd88557c5d94977fc5a08da2ea79757
> %7C1a407a2d76754d178692b3ac285306e4%7C0%7C0%7C63787359458116553
> 7%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzI
> iLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DW8vcAhLswMlUE
> HddpjoZnNNT%2BumenFsVtq73oD7dKX8%3D&amp;reserved=3D0
> I have now a workaround by defining a macro prior the inclusion of "heap.=
h":
> #define typeof __typeof__
> But I am not happy with this. Is there a way to do this better? Is -std n=
ow not
> allowed with Xenomai?
>
> Thanks,
> Gunter Grau
>

Hi,

Sorry. Forgot to add some testcode:

#include <iostream>
#include <heap.h>

int main() {
    std::cout << "Hello World!";
    return 0;
}

Since the issue comes with the include. No need to really use heap function=
s.
Please try to compile with alchemy skin.

Looks like it was introduced with the inclusion of "cobals/sys/cobalt.h" in=
 include/copperplate/clockobj.h in this commit:
dbda3c2c6e4b4eca052bb0cbbd059ead174f33cc

Thanks in advance,
Gunter

________________________________
The information contained in this message may be confidential and legally p=
rotected under applicable law. The message is intended solely for the addre=
ssee(s). If you are not the intended recipient, you are hereby notified tha=
t any use, forwarding, dissemination, or reproduction of this message is st=
rictly prohibited and may be unlawful. If you are not the intended recipien=
t, please contact the sender by return e-mail and destroy all copies of the=
 original message.

