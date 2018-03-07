Date: Wed, 7 Mar 2018 18:17:27 +0200 (EET)
From: =?windows-1251?B?2OXi9+Xt6u4g0uDw4PEgw/Do4+7w/OXi6Pc=?=
 <shevchenko.taras@triolcorp.com.ua>
Message-ID: <193431298.3050958.1520439447908.JavaMail.zimbra@triolcorp.com.ua>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] cant compile rtdm module
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>


Hi, 
I can successfully compile and run code with Xenomai api in user space 
but if i try to compile rtdm code there is many error 
I try to use own code and your example from /kernel/drivers/gpio - outputs below 

please guide me how to compile and run simple rtdm module 

yeti@yeti-UDOO-x86:~/xenoInstall/xenomai-3.0.5/kernel/drivers/gpio$ make V=1 
make: *** No targets. Stop. 
yeti@yeti-UDOO-x86:~/xenoInstall/xenomai-3.0.5/kernel/drivers/gpio$ make V=1 -C /usr/src/linux-headers-4.9.38-xenomai-3.0.5 M=$PWD modules 
make: Entering directory '/usr/src/linux-headers-4.9.38-xenomai-3.0.5' 
test -e include/generated/autoconf.h -a -e include/config/auto.conf || ( \ 
echo >&2; \ 
echo >&2 " ERROR: Kernel configuration is invalid."; \ 
echo >&2 " include/generated/autoconf.h or include/config/auto.conf are missing.";\ 
echo >&2 " Run 'make oldconfig && make prepare' on kernel src to fix it."; \ 
echo >&2 ; \ 
/bin/false) 
mkdir -p /home/yeti/xenoInstall/xenomai-3.0.5/kernel/drivers/gpio/.tmp_versions ; rm -f /home/yeti/xenoInstall/xenomai-3.0.5/kernel/drivers/gpio/.tmp_versions/* 
make -f ./scripts/Makefile.build obj=/home/yeti/xenoInstall/xenomai-3.0.5/kernel/drivers/gpio 
(cat /dev/null; ) > /home/yeti/xenoInstall/xenomai-3.0.5/kernel/drivers/gpio/modules.order 
make -f ./scripts/Makefile.modpost 
find /home/yeti/xenoInstall/xenomai-3.0.5/kernel/drivers/gpio/.tmp_versions -name '*.mod' | xargs -r grep -h '\.ko$' | sort -u | sed 's/\.ko$/.o/' | scripts/mod/modpost -a -i ./Module.symvers -I /home/yeti/xenoInstall/xenomai-3.0.5/kernel/drivers/gpio/Module.symvers -o /home/yeti/xenoInstall/xenomai-3.0.5/kernel/drivers/gpio/Module.symvers -S -w -s -T - 
make: Leaving directory '/usr/src/linux-headers-4.9.38-xenomai-3.0.5' 
yeti@yeti-UDOO-x86:~/xenoInstall/xenomai-3.0.5/kernel/drivers/gpio$ 
