Message-ID: <519DD279.7090904@xenomai.org>
Date: Thu, 23 May 2013 10:25:29 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <36f53837.5dc9.13ecf8dfe4d.Coremail.jinxin16897123@163.com>
In-Reply-To: <36f53837.5dc9.13ecf8dfe4d.Coremail.jinxin16897123@163.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] name rule ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: jinxin16897123 <jinxin16897123@163.com>
Cc: xenomai <xenomai@xenomai.org>

On 05/23/2013 06:03 AM, jinxin16897123 wrote:
>
> hi ,all
> I've download the xenomai, uncompress it and found :
> adeos-ipipe-3.0.36-arm-1.18-11.patch
> ipipe-core-3.2.21-arm-4.patch
> ipipe-core-3.4.6-arm-4.patch
> ipipe-core-3.5.7-arm-3.patch
>
>
> What's the difference between these file? what's the name rule?
> Thanks.
>

<radix>-<kernel version>-<architecture>-<patch release tag>.patch

patches bearing the adeos-ipipe radix denotes an old generation pipeline 
implementation. In such a case, the release tag is 
<major>.<minor>-<sublevel>.

ipipe-core denotes a new generation patch. In this case, the release tag 
is a simple patch iteration number. Unlike with former adeos-ipipe 
patches, the iteration level is reset (to 1) at each kernel version 
upgrade. e.g. ipipe-core-3.4.6-arm-4.patch, last of 3.4.6 series => 
ipipe-core-3.5.7-arm-1.patch, first of 3.5.7 series. We don't do that 
when bumping the kernel extra version number though.

Unless specifically mentioned in the patch file name, all patches apply 
to a mainline kernel version. We do not support vendor kernels.

-- 
Philippe.

