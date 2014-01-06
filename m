Message-ID: <52CB30F9.50505@zultron.com>
Date: Mon, 06 Jan 2014 16:40:57 -0600
From: John Morris <john@zultron.com>
MIME-Version: 1.0
References: <52CB0DA1.9080302@zultron.com> <52CB17A9.6080901@xenomai.org>
In-Reply-To: <52CB17A9.6080901@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai Red Hat packaging
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 01/06/2014 02:52 PM, Gilles Chanteperdrix wrote:
> On 01/06/2014 09:10 PM, John Morris wrote:
>> Here are the packaging materials I've been using on Red Hat Enterprise
>> Linux clones for some time now, also recently updated for Fedora.
>>
>> https://github.com/zultron/xenomai-rpm
>>
>> The packaging is pretty straightforward, and follows the Debian
>> packaging for the xenomai-devel subpackage.
>>
>> A significant addition is the 'xenomai-gid-ctl' script for configuring
>> non-root access to Xenomai services, plus sysv and systemd boot init
>> scripts.
> 
> Are these specific to Red Hat, or can we put them in the set of files
> installed by default?

The 'xenomai-gid-ctl' script should work anywhere.

The 'xenomai.default' file (installed into /etc/default/xenomai) works
with RH- & Debian-derivatives, and other distros with the /etc/default
directory.  /etc/default/xenomai is only used to override the default
'xenomai' group, is semi-optional, and may be relocated.

Installing 'xenomai-gid-ctl' (and 'xenomai.default', if /etc/default
exists) from 'make install' could be useful to the end user, since it is
a stand-alone utility.

The EL6 sysv init script needs modification to support Debian's LSB init
system, simple for someone more familiar.

Other projects I'm familiar with often ship system init scripts in a
e.g. 'contrib' directory, and don't include complex makefile logic to
detect distro and install the correct init script.  Manual installation
is left up to the end user or the packager.

>   I'd appreciate comments on the control script's correctness
>> and the init scripts' utility.
> 
> You do not need to pass --enable-x86-tsc as it is enabled by default
> now.

Thanks!

> As for building the doc, xenomai sources contain generated
> documentation, so if you do not enable any option, you will have some
> documentation installed. If you still want to generate the doxygen
> documentation, what is the problem with --enable-dox-doc?

I'll find time to revisit doc generation and report back.

	John

