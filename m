Message-ID: <510FFDE0.4080703@icid.cu>
Date: Mon, 04 Feb 2013 13:28:48 -0500
From: raespi <raespi@icid.cu>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Subject: [Xenomai] about switchtest ...
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi ... I'm using the 2.6.0 Xenomai version in userspace.  I managed to =

forwardport the *adeos-ipipe-3.0.36-arm-1.18-11* patch provided to the =

3.1.10 kernel version since it's the one I'm currently using.  I managed =

to modify it in a way that it compiles and runs on my SMDK2440 ARM =

target.  I attached the patch for your consideration.  If you consider =

it valuable I can send you another version at a later time with the =

other marchs included ( I removed them from the patched and left the =

modifications important to me ) ...

I followed the guide and everything works fine, I see the boot messages =

and the *xeno latency* test runs without any problem.  The problem =

arises when I try the *xeno-test *program, it starts with the first test =

and then crashes with an error:

switchtest: Unable to open switchtest device.
(modprobe xeno_switchtest ?)

I issued a *cat /proc/xenomai/rtdm/named_devices* and got:

Hash    Name                Driver        /proc
24    rttest-timerbench0                 xeno_timerbench    =

rttest-timerbench0
55    rttest-switchtest0                 xeno_switchtest    =

rttest-switchtest0

Meaning the rttest-switchtest0 device is there right?? I looked for it =

here after googling this problem.  In some mailing lists it's said that =

this problem was fixed in the 2.5.1 head version, but as you can see =

it's still popping up ...

Any ideas ??

Thanks in advance ...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: adeos-ipipe-3.1.10-arm-001.patch
Type: text/x-diff
Size: 460278 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130204/7310252=
d/attachment.patch>
