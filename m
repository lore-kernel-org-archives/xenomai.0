MIME-Version: 1.0
From: "MB. Parsa" <mbparsa@gmail.com>
Date: Fri, 06 May 2016 21:30:18 +0000
Message-ID: <CAJuLgznevZ6Tr1+HyH6_3DsZoBruo8PTNdStttvyVva_rC5VNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Error compiling Xenomai 3 + Ubuntu 16
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi I am trying to make the kernel after configuration, everything went well
and compiler was compiling that I got this error and I have not idea why
should I get such an error ?

 CC [M]  net/ipv4/netfilter/ipt_ECN.o
net/ipv4/netfilter/ipt_ECN.c:20:42: fatal error:
linux/netfilter_ipv4/ipt_ECN.h: No such file or directory
compilation terminated.
scripts/Makefile.build:263: recipe for target
'net/ipv4/netfilter/ipt_ECN.o' failed
make[3]: *** [net/ipv4/netfilter/ipt_ECN.o] Error 1
scripts/Makefile.build:402: recipe for target 'net/ipv4/netfilter' failed
make[2]: *** [net/ipv4/netfilter] Error 2
scripts/Makefile.build:402: recipe for target 'net/ipv4' failed
make[1]: *** [net/ipv4] Error 2
Makefile:937: recipe for target 'net' failed
make: *** [net] Error 2

Could you please help me figure out what is happing ?
