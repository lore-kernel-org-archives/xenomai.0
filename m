Message-ID: <458697A5.4000203@domain.hid>
Date: Mon, 18 Dec 2006 14:29:09 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] prepare kernel fails
References: <5D63919D95F87E4D9D34FF7748CE2C2A6F928A@ARVMAIL1.mra.roland-man.biz>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A6F928A@ARVMAIL1.mra.roland-man.biz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Roderik_Wildenburg@domain.hid
Cc: xenomai@xenomai.org

Roderik_Wildenburg@domain.hid wrote:
> When I try to prepare the kernel with xenomai-2.3-rc2 I get the
> following error :
> "find: xenomai-2.3-rc2/sim: file or directory not found"
> 
> The Prepare command I use :
> scripts/prepare-kernel.sh --linux=/home/user/linuxppc  --arch=ppc
> 
> Does anybody know what this means ?

Not really. The "sim" is not part of the -rc2 and also -rc3 releases but 
it exists in the SVN trunk.

> I Could not find a sim directory or file in older versions too, but they
> prepared the kernel correctly.

The missing directory will not harm. Anyhow, if you start testing 
2.3-rcX now, please use xenomai-2.3-rc3.

Wolfgang.


