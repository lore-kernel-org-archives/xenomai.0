Message-ID: <5490A768.7040605@nta-inc.net>
Date: Tue, 16 Dec 2014 15:43:04 -0600
From: Jeff Webb <jeff.webb@nta-inc.net>
MIME-Version: 1.0
References: <548f3ed0cc1f95.52388489@wp.pl>
In-Reply-To: <548f3ed0cc1f95.52388489@wp.pl>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Subject: Re: [Xenomai] Add cards parameter to rt_e1000e module?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, rtnet-users@lists.sourceforge.net

On 12/15/2014 02:04 PM, Mariusz Janiak wrote:
>>>> Certainly a well behaved driver would not touch a device already handl=
ed
>>>> by a linux driver.  It should be possible to just issue an unbind requ=
est
>>>> to the linux driver for the desired device and then a bind request to
>>>> the rtnet driver to take over that device.
>>
>> Thanks for sharing this information.  It sounds like that might work.
>>
>>> The problem with the
>>> bind/unbind solution is that the driver that will get all the cards
>>> first depends on the drivers initialization order. With the "cards"
>>> parameter, you do not have this issue.
>>
>> Maybe one could create a script that would attempt to unbind both the rt=
 and non-rt drivers (or check to see which one is bound and then unbind it)=
, and then make the desired "bind" calls.  It would be better if the incorr=
ect binding were not made in the first place, however.  I think the ideal s=
olution would be to have a file that contains device/driver pairs that woul=
d keep the kernel from passing the specified devices to any other drivers. =
 I wonder how hard that would be to implement.
>
> The RTnet configuration file rtnet.conf has already instrumentation for b=
inding/unbinding devices. The REBIND_RT_NICS variable has to be set up with=
 the correct NIC PCI addresses. If you have more then one NIC, you can iden=
tity PCI address of respective eth's using ethtool
>
> ethtool -i eth0
> ethtool -i eth1
>
> etc.
>
> The bus-info field contains device pci addres that you can directly inser=
t to REBIND_RT_NICS. If you don't know which eth menage with physical inter=
face, you can blink LED port of the NIC using, eg.
>
> ethtool -p eth0

(I am cross-posting this message to rtnet-users from the xenomai mailing li=
st, since this is even more relevant there.  I apologize to those who recei=
ve duplicate e-mails.)

Thank you again, Mariusz.  All of this information is helpful.  I was follo=
wing the instructions to start the RTnet core manually (as documented in th=
e README file), since I am not using RTmac in my application.  I saw some r=
eferences to REBIND_RT_NICS, but I didn't look into it very closely, since =
rtnet.conf and the "rtnet" script appeared to associated with RTmac.

After looking at the "rtnet" script, I see that it does indeed use bind/unb=
ind in exactly the way we were discussing.  The script works very works wel=
l to switch an interface between standard and real-time networking, but unf=
ortunately it does not support running without the RTmac layer.  I made som=
e minor modifications to the script to add this support.  With my modificat=
ions, if TDMA_MODE =3D "none" (instead of "master" or "slave"), the script =
skips all of the rtmac/rtcfg/tmda initialization.  I have attached patches =
for both the rtnet and xenomai-3.git/next repositories.  I hope that they w=
ill be accepted, since I believe others have asked for this functionality i=
n the past.

Gilles, it appears that the "cards" parameter may not be needed anymore, un=
less there are some other situations in which bind/unbind won't work.  I ca=
n see how that would make maintaining the RT drivers simpler.

-Jeff

-------------- next part --------------
A non-text attachment was scrubbed...
Name: rtnet-no-tdma-git.patch
Type: text/x-patch
Size: 888 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20141216/a7cf8f8=
a/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: rtnet-no-tdma-xeno3.patch
Type: text/x-patch
Size: 617 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20141216/a7cf8f8=
a/attachment-0001.bin>
