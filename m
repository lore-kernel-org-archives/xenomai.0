Message-ID: <5468842E.205@xenomai.org>
Date: Sun, 16 Nov 2014 12:02:06 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <54687601.5020805@free.fr>
In-Reply-To: <54687601.5020805@free.fr>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Some questions and issues about Xenomai 3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Thierry Bultel <tbultel@free.fr>, xenomai@xenomai.org

On 11/16/2014 11:01 AM, Thierry Bultel wrote:
> Hi,
> I am currently attempting to port my application from xenomai-2.6.(3/4)
> to xenomai-3-rc2
> 
> My application uses the canfestival package, which uses rt_socket_can.
> The distribution is buildroot, and I have hacked it a little to support
> the build of mercury, because it is not supported yet.
> 
> For info, I have basically added this:
> XENOMAI_CONF_OPT += --with-core=mercury
> XENOMAI_CONF_OPT += --enable-smp
> XENOMAI_CONF_OPT += --enable-pshared
> XENOMAI_CONF_OPT += --enable-registry
> 
> I am encountering several issues:
> 
> 1) xeno-config
> a) it says an error with posix skin
> localuser@thierry-desktop ~/workspace/agv (STD_ITG_15.03)*$
> /nous/BASYSTEMES/buildroot/buildroot_agv_v15_amos820/host/usr/arm-buildroot-linux-gnueabihf/sysroot/usr/bin/xeno-config
> --skin=posix --cflags
> unknown RTOS skin: posix

Building for the posix skin over the Mercury core basically means
building on top of the glibc, therefore calling xeno-config is useless
as you need no Xenomai-specific flags from us.

Retrieving build flags via xeno-config for Mercury is useful for
non-POSIX APIS, e.g. psos, vxworks, alchemy: in this case, there are
some Xenomai-specific flags required for building over the relevant
emulator/interface.

This said, maybe this script should accept --posix/--skin=posix and
deliver no particular cflags in this case, instead of bailing out on
error. This might help generic build machinery.

> 
> b) --compat fails, and is not mentioned in the Usage
> 

--compat is for enabling the 2.6.x compatibility mode the 3.x transition
kit provides (aka libtrank); as 2.6.x only supports dual kernel mode,
--compat only makes sense when one targets the Cobalt core in 3.x. IOW,
You cannot use --compat to transition from a dual kernel to a native
kernel (i.e. Mercury) configuration. The main reason for this, is that a
number of 2.6.x API features are dual kernel specific.

> 
> 2) I have read in the manual that rtcan.h has been renamed to can.h
> But after the install step, can.h is not installed in the staging.
> buildroot was using "make install-user" for doing so. Changing to "make
> install" does not help.

> 
> 3) More general question, about rtcan:
> prepare_kernel.sh seems definitively needed for Cobalt kernel only. So
> how can the rtcan drivers be built in the PREEMPT_RT kernel ?
> Sorry for my dummy question.
> 

rtcan has not been ported to Mercury, so you won't find any of the
relevant files installed for a Mercury build. At the moment, the
assumption is that rtcan is basically a dual kernel specific replacement
for the native CAN stack available from the mainline kernel. So an
application running in a single kernel configuration should/could use
the native CAN stack instead of rtcan.

Of course this is a broad and general statement that likely does not
account for rtcan-specific details/features. This may need to be
discussed with current rtcan users.

-- 
Philippe.

