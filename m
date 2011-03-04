Message-ID: <4D712706.2020202@domain.hid>
Date: Fri, 04 Mar 2011 18:53:10 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTinnqCe1aJzfsJMGApD2De7NAk1hhOYAWqKdJfAL@mail.gmail.com>	<4D70FC9A.7040007@domain.hid>
	<AANLkTinNtpWXzaggXX_g9Z+U0TqWP6iLHW_m=FqJbtUk@domain.hid>
In-Reply-To: <AANLkTinNtpWXzaggXX_g9Z+U0TqWP6iLHW_m=FqJbtUk@domain.hid>
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

Jeff Hyams wrote:
> For response to the first post, no it does not lag when I disable xenomai
> and the ipipe stuff and recompile/re-install the kernel.
> 
> In response to the second, attached are I believe all the logs you are
> looking for(up to and including the machine becoming "laggy")  There are
> definitely some errors showing in the logs, but I am at a loss on how to fix
> them or why they are happening.

Feb 28 11:20:39 DARPA-ARM-GFE kernel: [    0.000000] Command line:
BOOT_IMAGE=/boot/vmlinuz-2.6.32-28-generic
root=UUID=fd8c87d4-0b4b-4c42-b74e-5364fc394fee ro quiet splash

You have not removed "quiet" on the kernel command line.
You did not send the kernel configuration.

-- 
					    Gilles.

