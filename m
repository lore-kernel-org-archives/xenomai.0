Message-ID: <4D71282A.7060108@domain.hid>
Date: Fri, 04 Mar 2011 18:58:02 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTinnqCe1aJzfsJMGApD2De7NAk1hhOYAWqKdJfAL@mail.gmail.com>	<4D70FC9A.7040007@domain.hid>	<AANLkTinNtpWXzaggXX_g9Z+U0TqWP6iLHW_m=FqJbtUk@domain.hid>
	<4D712706.2020202@domain.hid>
In-Reply-To: <4D712706.2020202@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xenomai patched kernel "laggy"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Hyams <jeff.hyams@domain.hid>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Jeff Hyams wrote:
>> For response to the first post, no it does not lag when I disable xenomai
>> and the ipipe stuff and recompile/re-install the kernel.
>>
>> In response to the second, attached are I believe all the logs you are
>> looking for(up to and including the machine becoming "laggy")  There are
>> definitely some errors showing in the logs, but I am at a loss on how to fix
>> them or why they are happening.
> 
> Feb 28 11:20:39 DARPA-ARM-GFE kernel: [    0.000000] Command line:
> BOOT_IMAGE=/boot/vmlinuz-2.6.32-28-generic
> root=UUID=fd8c87d4-0b4b-4c42-b74e-5364fc394fee ro quiet splash
> 
> You have not removed "quiet" on the kernel command line.
> You did not send the kernel configuration.

... However, the kernel seems to be misconfigured, since it has MSI
enabled. You probably did not read this page:

http://www.xenomai.org/index.php/Configuring_x86_kernels

I suggest you try and follow the advices on this page, see if you still
have the issue, then retry sending what we asked you (but with
everything we asked, this time).

-- 
					    Gilles.

