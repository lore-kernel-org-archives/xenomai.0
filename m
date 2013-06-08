MIME-Version: 1.0
In-Reply-To: <CAFNBfteWESjgYQeMH0kv2w3qVGuX+XUkWqCNhbYPimH+vLcGTA@mail.gmail.com>
References: <7EC33A2F-9868-4A32-A19F-9A7C70AF9EBB@mah.priv.at>
	<51AF8424.40300@xenomai.org>
	<CAFNBfteWESjgYQeMH0kv2w3qVGuX+XUkWqCNhbYPimH+vLcGTA@mail.gmail.com>
Date: Sat, 8 Jun 2013 19:46:40 -0300
Message-ID: <CAFNBftcwKG_t_wEOwHaE850UCo7aHprtpf2HU83_H0MKH71p-Q@mail.gmail.com>
From: Flavio Castro Alves Filho <flavio.alves@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Beaglebone kernels - automated builds WIP
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Answering my own question:

=> My setup

Ubuntu 12.04 with a complete build of Angstrom for BeagleBone Black
using openembedded setup scripts

I used 'bitbake meta-ide-support' in order to have the toolchain for
building the kernel.

Despite having the build system, I'm using the original image from
e-mmc without changing anything

=> My procedure

* I used ipipe.git repository and ipipe-next branch as my mainline
kernel source code. I assumed that it was equivalent to the mainline
kernel with the v3.8.10 tag with the additions of the adeos-ipipe
equivalent patches (if we use the Xenomai's installer from the
download package)
* I added the BeagleBone Black related patches. To do so, I got the
meta-beagleboard from Yocto/Angstrom, checkout the hash which they've
just committed the v3.8.10 kernel for building and copied the patches
and configuration file
* I applied those patches to ipipe. It failed in one patch, but when I
saw, it was just #include positions. I corrected by hand.
* Executed scripts/prepare-kernel.sh, to install Xenomai patches
* Run menuconfig, to correct the real time part of the configuration file
* Build the kernel. It worked straight
* Copied the uImage file to the board

* Compiled Xenomai and installed to the board. In my case, I created a
recipe and installed the ipk file into my image.

I'll try to organize it in order to have an easier way to have it done.

Best regards,

Flavio


2013/6/8 Flavio Castro Alves Filho <flavio.alves@gmail.com>:
> Hello,
>
> 2013/6/5 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
>> On 06/05/2013 05:42 PM, Michael Haberler wrote:
>>
>>> just letting you know I'm working with Robert Nelson to tack on a
>>> Xenomai kernel build to his automated build the thread is here:
>>> http://eewiki.net/display/linuxonarm/BeagleBone+Black+Comments (cant
>>> link to the actual post, search for xenomai)
>
> I'm currently working on a similar activity - have Linux Xenomai
> working on BeagleBone Black.
>
>>>
>>> this flow already produces the vanilla kernels which are in the BB
>>> Ubuntu and Debian images; the process is outlined here:
>>> http://tinyurl.com/n5ly89t ; the xenomai kernel(s) would be tacked
>>> onto this stream: http://rcn-ee.net/deb/wheezy-armhf/
>>>
>>> for now I'll use the patches Stephan had forwarded me in private, and
>>> switch on next release (suggestions to do better than that welcome)
>>
>>
>> You should probably use the ipipe-next branch in ipipe git tree.
>
> I'm sorry for my probably newbie question, but how should I use the
> ipipe git tree?
>
>>
>> --
>>                                                                 Gilles.
>>
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> http://www.xenomai.org/mailman/listinfo/xenomai
>
>
>
> --
> Flavio de Castro Alves Filho
>
> flavio.alves@gmail.com
> www.linuxembarcado.com
> Twitter: http://twitter.com/#!/fraviofii
> LinkedIn profile: www.linkedin.com/in/flaviocastroalves



-- 
Flavio de Castro Alves Filho

flavio.alves@gmail.com
www.linuxembarcado.com
Twitter: http://twitter.com/#!/fraviofii
LinkedIn profile: www.linkedin.com/in/flaviocastroalves

