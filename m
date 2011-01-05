Message-ID: <4D24D6F3.8020007@domain.hid>
Date: Wed, 05 Jan 2011 21:39:15 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4D20D7A7.2090003@domain.hid> <4D21A5CF.9000107@domain.hid>
	<4D24D30E.7060108@domain.hid> <4D24D3C0.8080205@domain.hid>
	<4D24D4CE.6030600@domain.hid>
In-Reply-To: <4D24D4CE.6030600@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Build issue with rtcan and I-pipe for linux
	2.6.36 on powerpc.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Wolfgang Grandegger <wg@domain.hid>, Xenomai core <Xenomai-core@domain.hid>

Jan Kiszka wrote:
> Am 05.01.2011 21:25, Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Am 03.01.2011 11:32, Wolfgang Grandegger wrote:
>>>> Hi Gilles,
>>>>
>>>> the attached patch fixes the issue.
>>>>
>>> Nothing critical, but I think we should consistently wrap the other way
>>> around
>>>
>>> #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36)
>>> #define platform_device of_device
>>> #endif
>>>
>>> and update the users to the new style.
>> Err... Am I missing the obvious here? If you include
>> <linux/platform_device.h> on powerpc you then get a massive mess prior
>> to 2.6.36.
> 
> Maybe this is an exception, don't know the powerpc details, but
> generally our drivers should be written according to latest (supported)
> kernel APIs and then extended/wrapped/etc. to compile with older
> versions as well.

platform_device has existed for a long time in the 2.6 series: the
matching between platform_device and platform_driver is the hack which
replaces enumeration USB and PCI bus provide on embedded systems busses.

Some platforms introduced of_device to handle another kind of
enumeration: the device tree.

Now, it seems the member which were specific to of_device migrated to
the platform_device structure, so, the of_device structure was cancelled
completely, and replaced by platform_device all over the place.

At least, is it my understanding.

Now, we can typedef device_tree_device to be of_device on old kernels,
and platform_device on new kernels, but using of_device for this does
not seem stupid either.

-- 
					    Gilles.

