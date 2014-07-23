Message-ID: <53CF5DFB.3000309@zultron.com>
Date: Wed, 23 Jul 2014 02:02:19 -0500
From: John Morris <john@zultron.com>
MIME-Version: 1.0
References: <53C9627E.4010102@zultron.com> <53C974FA.5030308@xenomai.org>
 <53C97A17.8090906@zultron.com> <53C97AC3.9010506@xenomai.org>
In-Reply-To: <53C97AC3.9010506@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Debian packages for testing:  Xenomai 2.6.3,
 Linux 3.8.13, x86 and Beaglebone
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org



On 07/18/2014 02:51 PM, Gilles Chanteperdrix wrote:
> On 07/18/2014 09:48 PM, John Morris wrote:
>> On 07/18/2014 02:26 PM, Gilles Chanteperdrix wrote:
>>> On 07/18/2014 08:07 PM, John Morris wrote:
>>>> I've built new Xenomai kernel packages for the Machinekit project.  As
>>>> the subject says, they're based on Xenomai 2.6.3 and Linux 3.8.13 and
>>>> run on the x86 architectures (mostly vanilla with the Debian config) and
>>>> Beaglebone (Robert C Nelson's patches and config).
>>>>
>>>> They are based on the upstream Debian packaging, completely different
>>>> from my previous packages, which were based on the awful make-kpkg
>>>> stuff.  These promise to be much more maintainable.
>>>>
>>>> RTAI kernels are also included in the new packaging.
>>>>
>>>> To install:
>>>>
>>>> # configure the Debian archive
>>>> sudo sh -c \
>>>>        "sudo apt-key adv --keyserver hkp://keys.gnupg.net \
>>>>            --recv-key 73571BB9; \
>>>>        echo 'deb http://deb.dovetail-automata.com wheezy main' > \
>>>>            /etc/apt/sources.list.d/machinekit.list"
>>>
>>> If you are interested, you can make a debian package which adds the key
>>> to the keyring. See:
>>> http://www.xenomai.org/debian/pool/main/x/xenomai-keyring/
>>
>> Hi Gilles,
>>
>> I actually did this last time around, and even copied your code.  What's
>> the advantage of putting the key in a package over directly importing
>> the key with the above 'apt-key' command?
>
> If a user wants to remove a key, he simply removes the package instead
> of having to know the apt-key command (which most user never even use,
> as the debian project keys are installed with such a package).

Updated instructions:

# install the Dovetail Automata signing key package
wget 
http://deb.dovetail-automata.com/pool/main/d/dovetail-automata-keyring/dovetail-automata-keyring_0.1-1~wheezy1_all.deb
dpkg -i dovetail-automata-keyring_0.1-1~wheezy1_all.deb

# configure the archive and update package indexes
echo 'deb http://deb.dovetail-automata.com wheezy main' > \
     /etc/apt/sources.list.d/machinekit.list"
sudo apt-get update

# install the Xenomai kernel and headers; pick the command
# applicable to your situation
#
# amd64 architecture:
apt-get install \
     linux-image-xenomai.x86-amd64 \
     linux-headers-xenomai.x86-amd64
# i386 architecture:
apt-get install \
     linux-image-xenomai.x86-i686-pae \
     linux-headers-xenomai.x86-i686-pae
# Beaglebone:
apt-get install \
     linux-image-xenomai.beaglebone-omap \
     linux-headers-xenomai.beaglebone-omap

If you have an r8168 NIC in your PC, see 
/etc/modprobe.d/r816x_blacklist.conf to enable that driver and disable 
the r8169.

	John

