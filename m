Message-ID: <54F5BE3F.4010008@xenomai.org>
Date: Tue, 03 Mar 2015 14:59:27 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAKk99t1N5b0_iQerSxPyKmMTLC8PePTJCO9zzFLdkmt_mDiiVg@mail.gmail.com>	<54F58A4C.7030006@xenomai.org>
 <CAKk99t3_g0ZODEe32KGAzfHckWC=-Gqr6CrFa5yRh-hLF5Ttow@mail.gmail.com>
In-Reply-To: <CAKk99t3_g0ZODEe32KGAzfHckWC=-Gqr6CrFa5yRh-hLF5Ttow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai/cobalt: low_init(): binding failed: Function
 not implemented error issued when trting to run latency app on xeno 3.x-rc3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Helder Daniel <hdaniel@ualg.pt>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 03/03/2015 02:03 PM, Helder Daniel wrote:
> Hi Philippe,
> 
> Thanks for your very quick response.
> I am installing cobalt in a physical pc for testing cobalt.
> 
> Meanwhile I tried what you suggested to check the registry in Mercury:
> 
>> If the registry could not be mounted, then you can't see it, that is
>> expected.
>> 1. Do you have /var/run on your system?
>>
> Yes I have (but no xenomai entry):
> 
> ls /var/run
> 
> acpid.pid               exim4               NetworkManager.pid
>  sm-notify.pid
> acpid.socket            gdm3                pm-utils            sshd
> atd.pid                 gdm3.pid            rpcbind             sshd.pid
> avahi-daemon            initctl             rpcbind.lock        udev
> console                 initramfs           rpcbind.pid         udisks
> ConsoleKit              lock                rpcbind.sock        utmp
> console-kit-daemon.pid  motd.dynamic        rpc.statd.pid       vmblock-fuse
> crond.pid               mount               rsyslogd.pid        vmtoolsd.pid
> crond.reboot            mpt-statusd.pid     sdp
> dbus                    mpt-statusd.status  sendsigs.omit.d
> dhclient.eth0.pid       network             shm
> 
>> 2. Does passing --registry-root=/tmp to the application fix the issue?
> 
> No. Gives the same error:
> 
> ./writeport --registry-root=/tmp
>    3"004.187| WARNING: [main] cannot connect to registry daemon
>    3"004.187| BUG: [main] initialization failed, EAGAIN

Does your PATH variable include $prefix/sbin?
(typically /usr/xenomai/sbin unless you set a different installation
prefix when configuring).

Bottom line is that the sysregd executable must be found when scanning
the PATH variable.

PS: please keep the list posted. This discussion may be useful to other
users.

-- 
Philippe.

